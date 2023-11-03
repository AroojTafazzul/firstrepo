<?xml version="1.0" encoding="UTF-8" ?>

<!DOCTYPE xsl:stylesheet [
<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:xd="http://www.pnp-software.com/XSLTdoc"
	exclude-result-prefixes="localization defaultresource">
	
	
	<xd:doc>
		<xd:short>Commercial dataset details</xd:short>
		<xd:detail>
			This displays message of no commercial dataset if no dataset is available and add button to add commercial data set.
 		</xd:detail> 		
 	</xd:doc>
	<xsl:template name="commercial-ds-details-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="commercial-ds-details-dialog-declaration" />
		<!-- Dialog End -->
		<div id="commercial-ds-details-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_DETAILS_PO_NO_COMMERCIAL_DATASET')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode" id="add_commercial_ds_button">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ADD_COMMERCIAL_DATASET')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Transport dataset details</xd:short>
		<xd:detail>
			This displays message of no transport dataset if no dataset is available and add button to add transport data set.
 		</xd:detail>		
 	</xd:doc>
	<xsl:template name="transport-ds-details-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="transport-ds-details-dialog-declaration" />
		<!-- Dialog End -->
		<div id="transport-ds-details-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_DETAILS_PO_NO_TRANSPORT_DATASET')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode" id="add_transport_ds_button">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ADD_TRANSPORT_DATASET')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Payment Transport dataset</xd:short>
		<xd:detail>
			This displays message of no transport dataset if no dataset is available and add button to add transport data set.
 		</xd:detail>		
 	</xd:doc>
	<xsl:template name="payment-transport-ds-details-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="payment-transport-ds-details-dialog-declaration" />
		<!-- Dialog End -->
		<div id="payment-transport-ds-details-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_DETAILS_PO_NO_TRANSPORT_DATASET')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode" id="add_pymt_transport_ds_button">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ADD_TRANSPORT_DATASET')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Insurance dataset</xd:short>
		<xd:detail>
			This displays message of no Insurance dataset if no dataset is available and add button to add Insurance data set.
 		</xd:detail>		
 	</xd:doc>
	<xsl:template name="insurance-ds-details-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="insurance-ds-details-dialog-declaration" />
		<!-- Dialog End -->
		<div id="insurance-ds-details-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_DETAILS_PO_NO_INSURANCE_DATASET')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode" id="add_insurance_ds_button">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ADD_INSURANCE_DATASET')" />
				</button>
			</div>
		</div>
	</xsl:template>
	

	<xd:doc>
		<xd:short>Commercial dataset details dialog declare</xd:short>
		<xd:detail>
			This templates displays BIC label and set the BIC parameters,also adds button of cancel and OK to confirm submitting
 		</xd:detail>		
 	</xd:doc>
	<xsl:template name="commercial-ds-details-dialog-declaration">
		<div id="commercial-ds-details-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
			<div class="standardPODialogContent">
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_PURCHASE_ORDER_SUBMITTER_BIC</xsl:with-param>
					<xsl:with-param name="name">cds_bic</xsl:with-param>
					<xsl:with-param name="override-displaymode">edit</xsl:with-param>
					<xsl:with-param name="size">35</xsl:with-param>
					<xsl:with-param name="maxsize">35</xsl:with-param>
					<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
					<xsl:with-param name="value">
						<xsl:value-of select="bic" />
					</xsl:with-param>
					<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
				</xsl:call-template>		
			</div>
			<div class="dijitDialogPaneActionBar">
				<xsl:call-template name="label-wrapper">
					<xsl:with-param name="content">
						<button type="button" dojoType="dijit.form.Button">
							<xsl:attribute name="onmouseup">dijit.byId('commercial-ds-details-dialog-template').hide();</xsl:attribute>
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
						</button>
						<xsl:if test="$displaymode = 'edit'">							
						<button dojoType="dijit.form.Button">
							<xsl:attribute name="onClick">dijit.byId('commercial-ds-details-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
						</button>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Transport Dataset dialog declaration</xd:short>
		<xd:detail>
			This templates displays BIC label and set the BIC parameters,also adds button of cancel and OK to confirm submitting
 		</xd:detail>		
 	</xd:doc>
	<xsl:template name="transport-ds-details-dialog-declaration">
		<div id="transport-ds-details-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
			<div class="standardPODialogContent">
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_PURCHASE_ORDER_SUBMITTER_BIC</xsl:with-param>
					<xsl:with-param name="name">tds_bic</xsl:with-param>
					<xsl:with-param name="override-displaymode">edit</xsl:with-param>
					<xsl:with-param name="size">35</xsl:with-param>
					<xsl:with-param name="maxsize">35</xsl:with-param>
					<xsl:with-param name="required"> <xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
					<xsl:with-param name="value">
						<xsl:value-of select="bic" />
					</xsl:with-param>
					<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
				</xsl:call-template>		
			</div>
			<div class="dijitDialogPaneActionBar">
				<xsl:call-template name="label-wrapper">
					<xsl:with-param name="content">
						<button type="button" dojoType="dijit.form.Button">
							<xsl:attribute name="onmouseup">dijit.byId('transport-ds-details-dialog-template').hide();</xsl:attribute>
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
						</button>
						<xsl:if test="$displaymode = 'edit'">							
						<button dojoType="dijit.form.Button">
							<xsl:attribute name="onClick">dijit.byId('transport-ds-details-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
						</button>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Payment transport Dataset dialog declaration</xd:short>
		<xd:detail>
			This templates displays Submitter BIC,address details and sets the parameters of these field which include size,maxsize etc
 		</xd:detail>		
 	</xd:doc>
	<xsl:template name="payment-transport-ds-details-dialog-declaration">
		<div id="payment-transport-ds-details-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
			<div class="standardPODialogContent">
			<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_DATA_SET_IDENTIFICATION</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="toc-item">N</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DATA_SET_ID</xsl:with-param>
							<xsl:with-param name="name">payment_tds_id</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="required">
							<xsl:choose>
					  	  			 <xsl:when test="$displaymode = 'edit'">Y</xsl:when>
					  	  			 <xsl:otherwise>N</xsl:otherwise>
				  	  			 </xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="disabled">
				  	  			 <xsl:choose>
					  	  			 <xsl:when test="$displaymode = 'edit'">N</xsl:when>
					  	  			 <xsl:otherwise>Y</xsl:otherwise>
				  	  			 </xsl:choose>
			  	  			 </xsl:with-param>
							<xsl:with-param name="value">
								<xsl:value-of select="payment_tds_id" />
							</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DATA_SET_VERSION</xsl:with-param>
							<xsl:with-param name="name">payment_tds_version</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="size">18</xsl:with-param>
							<xsl:with-param name="maxsize">18</xsl:with-param>
							<xsl:with-param name="regular-expression">^[0-9]{1,18}$</xsl:with-param>
							<xsl:with-param name="required">
								<xsl:choose>
					  	  			 <xsl:when test="$displaymode = 'edit'">Y</xsl:when>
					  	  			 <xsl:otherwise>N</xsl:otherwise>
				  	  			 </xsl:choose>
				  	  		</xsl:with-param>
				  	  		<xsl:with-param name="disabled">
				  	  			 <xsl:choose>
					  	  			 <xsl:when test="$displaymode = 'edit'">N</xsl:when>
					  	  			 <xsl:otherwise>Y</xsl:otherwise>
				  	  			 </xsl:choose>
			  	  			 </xsl:with-param>
							<xsl:with-param name="value">
								<xsl:value-of select="payment_tds_version" />
							</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
						</xsl:call-template>						
						
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PURCHASE_ORDER_SUBMITTER_BIC</xsl:with-param>
							<xsl:with-param name="name">payment_tds_bic</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="required">
								<xsl:choose>
					  	  			 <xsl:when test="$displaymode = 'edit'">Y</xsl:when>
					  	  			 <xsl:otherwise>N</xsl:otherwise>
				  	  			 </xsl:choose></xsl:with-param>
							 <xsl:with-param name="disabled">
				  	  			 <xsl:choose>
					  	  			 <xsl:when test="$displaymode = 'edit'">N</xsl:when>
					  	  			 <xsl:otherwise>Y</xsl:otherwise>
				  	  			 </xsl:choose>
			  	  			 </xsl:with-param>
							<xsl:with-param name="value">
								<xsl:value-of select="payment_tds_bic" />
							</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_DATA_TRANSPORT_INFORMATION</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="toc-item">N</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PROPOSED_SHIP_DATE</xsl:with-param>
							<xsl:with-param name="name">payment_tds_prop_date</xsl:with-param>
							<xsl:with-param name="type">date</xsl:with-param>
							<xsl:with-param name="size">10</xsl:with-param>
							<xsl:with-param name="maxsize">10</xsl:with-param>
							<xsl:with-param name="fieldsize">small</xsl:with-param>
							<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_ACTUAL_SHIP_DATE</xsl:with-param>
							<xsl:with-param name="name">payment_tds_actual_date</xsl:with-param>
							<xsl:with-param name="type">date</xsl:with-param>
							<xsl:with-param name="size">10</xsl:with-param>
							<xsl:with-param name="maxsize">10</xsl:with-param>
							<xsl:with-param name="fieldsize">small</xsl:with-param>
							<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_HEADER_CONSIGNMENT_DETAILS</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="toc-item">N</xsl:with-param>
							<xsl:with-param name="content">
								&nbsp;
								<xsl:call-template name="build-consignment-qty-details-dojo-items">
									<xsl:with-param name="id">consignment_qty_details_id</xsl:with-param>
								</xsl:call-template>
								&nbsp;
								<xsl:call-template name="build-consignment-vol-details-dojo-items">
									<xsl:with-param name="id">consignment_vol_details_id</xsl:with-param>
								</xsl:call-template>
								&nbsp;
								<xsl:call-template name="build-consignment-weight-details-dojo-items">
									<xsl:with-param name="id">consignment_weight_details_id</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
										
					    
					    <xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_HEADER_TRANSPORT_DOC_REFERENCE</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="toc-item">N</xsl:with-param>
							<xsl:with-param name="content">
								&nbsp;
								<xsl:call-template name="build-transport-document-ref-dojo-items">
									<xsl:with-param name="id">payment_tds_dataset_transport_doc_ref</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_HEADER_TRANSPORTED_GOODS</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="toc-item">N</xsl:with-param>
							<xsl:with-param name="content">
								&nbsp;
								<xsl:call-template name="build-transported-goods-dojo-items">
									<xsl:with-param name="id">payment_tds_dataset_transported_goods</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					
					  </xsl:with-param>
				</xsl:call-template>	
			</div>
			<div class="dijitDialogPaneActionBar">
				<xsl:call-template name="label-wrapper">
					<xsl:with-param name="content">
						<button type="button" dojoType="dijit.form.Button">
							<xsl:attribute name="onmouseup">dijit.byId('payment-transport-ds-details-dialog-template').hide();</xsl:attribute>
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
						</button>
						<xsl:if test="$displaymode = 'edit'">							
						<button dojoType="dijit.form.Button">
							<xsl:attribute name="onClick">dijit.byId('payment-transport-ds-details-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
						</button>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Insurance Dataset dialog declaration</xd:short>
		<xd:detail>
			This templates displays BIC,Match issuer(name and Country),Properitry identification(identification and type) etc fields in its Insurance dataset dialogue and sets 
			parameters related to it.,it also adds cancel and ok button in the dialog box.
 		</xd:detail>		
 	</xd:doc>
		<xsl:template name="insurance-ds-details-dialog-declaration">
		<div id="insurance-ds-details-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
			<div class="standardPODialogContent">
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_LABEL_BIC</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="toc-item">N</xsl:with-param>
					<xsl:with-param name="content">
					&nbsp;
						<xsl:call-template name="build-insurance-bic-dojo-items">
							<xsl:with-param name="id">insurance_dataset_bic</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_DETAILS_PO_MATCH_ISSUER</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="toc-item">N</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DETAILS_PO_MATCH_NAME</xsl:with-param>
							<xsl:with-param name="name">ids_match_issuer_name</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="maxsize">70</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="country-field">
						    <xsl:with-param name="label">XSL_DETAILS_PO_COUNTRY</xsl:with-param>
						    <xsl:with-param name="name">ids_match_issuer_country</xsl:with-param>
						    <xsl:with-param name="override-displaymode">edit</xsl:with-param>
						    <xsl:with-param name="prefix">ids_match_issuer_country</xsl:with-param>
						    <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
					    </xsl:call-template>
					    
				 		<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_DETAILS_PO_PROPRIETARY_IDENTIFICATION</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="toc-item">N</xsl:with-param>
							<xsl:with-param name="content">
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_IDENTIFICATION</xsl:with-param>
									<xsl:with-param name="name">ids_identification</xsl:with-param>
									<xsl:with-param name="size">35</xsl:with-param>
									<xsl:with-param name="maxsize">35</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_IDENTIFICATION_TYPE</xsl:with-param>
									<xsl:with-param name="name">ids_identification_type</xsl:with-param>
									<xsl:with-param name="size">35</xsl:with-param>
									<xsl:with-param name="maxsize">35</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:with-param>
				 </xsl:call-template>
				
				<xsl:call-template name="multichoice-field">
	     			 <xsl:with-param name="type">checkbox</xsl:with-param>
	      			 <xsl:with-param name="label">XSL_DETAILS_PO_MATCH_ISSUE_DATE</xsl:with-param>
	  	  			 <xsl:with-param name="name">ids_match_iss_date</xsl:with-param>
	  	  			 <xsl:with-param name="override-displaymode">edit</xsl:with-param>
	  	  			 <xsl:with-param name="disabled">
		  	  			 <xsl:choose>
			  	  			 <xsl:when test="$displaymode = 'edit'">N</xsl:when>
			  	  			 <xsl:otherwise>Y</xsl:otherwise>
		  	  			 </xsl:choose>
	  	  			 </xsl:with-param>
	  	  			 <xsl:with-param name="checked"><xsl:value-of select ="ids_match_iss_date"/></xsl:with-param>
	  	  			 <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
	     		 </xsl:call-template>
	     		 <xsl:call-template name="multichoice-field">
	     			 <xsl:with-param name="type">checkbox</xsl:with-param>
	      			 <xsl:with-param name="label">XSL_DETAILS_PO_MATCH_AMOUNT</xsl:with-param>
	  	  			 <xsl:with-param name="name">ids_match_amount</xsl:with-param>
	  	  			 <xsl:with-param name="override-displaymode">edit</xsl:with-param>
	  	  			 <xsl:with-param name="disabled">
		  	  			 <xsl:choose>
			  	  			 <xsl:when test="$displaymode = 'edit'">N</xsl:when>
			  	  			 <xsl:otherwise>Y</xsl:otherwise>
		  	  			 </xsl:choose>
	  	  			 </xsl:with-param>
	  	  			 <xsl:with-param name="checked"><xsl:value-of select ="ids_match_amount"/></xsl:with-param>
	  	  			 <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
	     		 </xsl:call-template>
	     		 <xsl:call-template name="multichoice-field">
	     			 <xsl:with-param name="type">checkbox</xsl:with-param>
	      			 <xsl:with-param name="label">XSL_DETAILS_PO_MATCH_TRANSPORT</xsl:with-param>
	  	  			 <xsl:with-param name="name">ids_match_transport</xsl:with-param>
	  	  			 <xsl:with-param name="override-displaymode">edit</xsl:with-param>
	  	  			  <xsl:with-param name="disabled">
		  	  			 <xsl:choose>
			  	  			 <xsl:when test="$displaymode = 'edit'">N</xsl:when>
			  	  			 <xsl:otherwise>Y</xsl:otherwise>
		  	  			 </xsl:choose>
	  	  			 </xsl:with-param>
	  	  			 <xsl:with-param name="checked"><xsl:value-of select ="ids_match_transport"/></xsl:with-param>
	  	  			 <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
	     		 </xsl:call-template>
	     		 <xsl:choose>
		     		 <xsl:when test="$displaymode='view' ">
							<xsl:variable name="code_type"><xsl:value-of select="insurance_dataset/InsrncDataSetReqrd/MtchAssrdPty"></xsl:value-of></xsl:variable>
							<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
							<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
							<xsl:variable name="parameterId">C023</xsl:variable>
								<xsl:call-template name="input-field">
								 	<xsl:with-param name="label">XSL_DETAILS_PO_MATCH_ASSURED_PARTY</xsl:with-param>
								 	<xsl:with-param name="name">ids_match_assured_party</xsl:with-param>
								 	<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $code_type)"/></xsl:with-param>
								 	<xsl:with-param name="override-displaymode">edit</xsl:with-param>
								 	 <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>	
								</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="select-field">
							<xsl:with-param name="label">XSL_DETAILS_PO_MATCH_ASSURED_PARTY</xsl:with-param>
							<xsl:with-param name="name">ids_match_assured_party</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="required">N</xsl:with-param>
							<xsl:with-param name="options">
								<xsl:call-template name="ids-match-assured-party-codes" />	
							</xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
	     		 
				
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_DETAILS_PO_CLAUSES_REQUIRED_HEADER</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="toc-item">N</xsl:with-param>
					<xsl:with-param name="content">
					&nbsp;
						<xsl:call-template name="build-insurance-required-clause-dojo-items">
							<xsl:with-param name="id">insurance_dataset_req_clause</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
	     		 		
			</div>
			<div class="dijitDialogPaneActionBar">
				<xsl:call-template name="label-wrapper">
					<xsl:with-param name="content">
						<button type="button" dojoType="dijit.form.Button">
							<xsl:attribute name="onmouseup">dijit.byId('insurance-ds-details-dialog-template').hide();</xsl:attribute>
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
						</button>	
						<xsl:if test="$displaymode = 'edit'">						
						<button dojoType="dijit.form.Button">
							<xsl:attribute name="onClick">dijit.byId('insurance-ds-details-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
						</button>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Certificate Dataset dialog declaration</xd:short>
		<xd:detail>
			This templates displays labels for BIC,Certificate type,match issuer(name and country) etc and sets its parameters such as name,value,size of these field.
			This template also adds button cancel and OK button in dialog box.
 		</xd:detail>		
 	</xd:doc>
	<xsl:template name="certificate-ds-details-dialog-declaration">
		<div id="certificate-ds-details-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
			<div class="standardPODialogContent">
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_LABEL_BIC</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="toc-item">N</xsl:with-param>
					<xsl:with-param name="content">
						&nbsp;
						<xsl:call-template name="build-certificate-bic-dojo-items">
							<xsl:with-param name="id">certificate_dataset_bic</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:variable name="code_type"><xsl:value-of select="certificate_dataset/CertDataSetReqrd/CertTp"></xsl:value-of></xsl:variable>
				<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
				<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
				<xsl:variable name="parameterId">C021</xsl:variable>
				<xsl:choose>
					<xsl:when test="$displaymode='view' ">
						<xsl:if test="certificate_dataset/CertDataSetReqrd/CertTp[.!='']">
								<xsl:call-template name="input-field">
								 	<xsl:with-param name="label">XSL_DETAILS_PO_CERTIFICATE_TYPE</xsl:with-param>
								 	<xsl:with-param name="name">ceds_cert_type</xsl:with-param>
								 	<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $code_type)"/></xsl:with-param>
								 	<xsl:with-param name="override-displaymode">edit</xsl:with-param>
								 	<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>	
								</xsl:call-template>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="select-field">
							<xsl:with-param name="label">XSL_DETAILS_PO_CERTIFICATE_TYPE</xsl:with-param>
							<xsl:with-param name="name">ceds_cert_type</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="required">N</xsl:with-param>
							<xsl:with-param name="options">
								 <xsl:call-template name="ceds-cert-type-codes" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:call-template name="hidden-field">
			    	<xsl:with-param name="name">ceds_cert_type_hidden</xsl:with-param>	    
			     	<xsl:with-param name="value">
			     	 <xsl:if test="certificate_dataset/CertDataSetReqrd/CertTp[.!='']">
			     	 <xsl:value-of select="localization:getCodeData($language,'*', $productCode, $parameterId, $code_type)"/>
			     	 </xsl:if>
			     	</xsl:with-param>  
			     </xsl:call-template>
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_DETAILS_PO_MATCH_ISSUER</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="toc-item">N</xsl:with-param>
					<xsl:with-param name="content">

						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DETAILS_PO_MATCH_NAME</xsl:with-param>
							<xsl:with-param name="name">ceds_match_issuer_name</xsl:with-param>
							<xsl:with-param name="size">40</xsl:with-param>
							<xsl:with-param name="maxsize">70</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="country-field">
						    <xsl:with-param name="label">XSL_DETAILS_PO_COUNTRY</xsl:with-param>
						    <xsl:with-param name="name">ceds_match_issuer_country</xsl:with-param>
						    <xsl:with-param name="override-displaymode">edit</xsl:with-param>
						    <xsl:with-param name="prefix">ceds_match_issuer_country</xsl:with-param>
						    <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
					    </xsl:call-template>
				 		<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_DETAILS_PO_PROPRIETARY_IDENTIFICATION</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="toc-item">N</xsl:with-param>
							<xsl:with-param name="content">
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_IDENTIFICATION</xsl:with-param>
									<xsl:with-param name="name">ceds_identification</xsl:with-param>
									<xsl:with-param name="size">35</xsl:with-param>
									<xsl:with-param name="maxsize">35</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_IDENTIFICATION_TYPE</xsl:with-param>
									<xsl:with-param name="name">ceds_identification_type</xsl:with-param>
									<xsl:with-param name="size">35</xsl:with-param>
									<xsl:with-param name="maxsize">35</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:with-param>
				 </xsl:call-template>
				<xsl:call-template name="multichoice-field">
	     			 <xsl:with-param name="type">checkbox</xsl:with-param>
	      			 <xsl:with-param name="label">XSL_DETAILS_PO_MATCH_ISSUE_DATE</xsl:with-param>
	  	  			 <xsl:with-param name="name">ceds_match_iss_date</xsl:with-param>
	  	  			 <xsl:with-param name="override-displaymode">edit</xsl:with-param>
	  	  			 <xsl:with-param name="disabled">
		  	  			 <xsl:choose>
			  	  			 <xsl:when test="$displaymode = 'edit'">N</xsl:when>
			  	  			 <xsl:otherwise>Y</xsl:otherwise>
		  	  			 </xsl:choose>
	  	  			 </xsl:with-param>
	  	  			  <xsl:with-param name="checked"><xsl:value-of select ="ceds_match_iss_date"/></xsl:with-param>
	     		 </xsl:call-template>

	     		 <xsl:call-template name="multichoice-field">
	     			 <xsl:with-param name="type">checkbox</xsl:with-param>
	      			 <xsl:with-param name="label">XSL_DETAILS_PO_MATCH_INSPECTION_DATE</xsl:with-param>
	  	  			 <xsl:with-param name="name">ceds_match_insp_date</xsl:with-param>
	  	  			 <xsl:with-param name="override-displaymode">edit</xsl:with-param>
	  	  			 <xsl:with-param name="disabled">
		  	  			 <xsl:choose>
			  	  			 <xsl:when test="$displaymode = 'edit'">N</xsl:when>
			  	  			 <xsl:otherwise>Y</xsl:otherwise>
		  	  			 </xsl:choose>
	  	  			 </xsl:with-param>
	  	  			 <xsl:with-param name="checked"><xsl:value-of select ="ceds_match_insp_date"/></xsl:with-param>
	     		 </xsl:call-template>
	     		 <xsl:call-template name="multichoice-field">
	     			 <xsl:with-param name="type">checkbox</xsl:with-param>
	      			 <xsl:with-param name="label">XSL_DETAILS_PO_AUTHORIZED_INSPECTOR_INDICATOR</xsl:with-param>
	  	  			 <xsl:with-param name="name">ceds_match_insp_ind</xsl:with-param>
	  	  			 <xsl:with-param name="override-displaymode">edit</xsl:with-param>
	  	  			 <xsl:with-param name="disabled">
		  	  			 <xsl:choose>
			  	  			 <xsl:when test="$displaymode = 'edit'">N</xsl:when>
			  	  			 <xsl:otherwise>Y</xsl:otherwise>
		  	  			 </xsl:choose>
	  	  			 </xsl:with-param>
	  	  			 <xsl:with-param name="checked"><xsl:value-of select ="ceds_match_insp_ind"/></xsl:with-param>
	     		 </xsl:call-template>
	     		 <xsl:call-template name="multichoice-field">
	     			 <xsl:with-param name="type">checkbox</xsl:with-param>
	      			 <xsl:with-param name="label">XSL_DETAILS_PO_MATCH_CONSIGNEE</xsl:with-param>
	  	  			 <xsl:with-param name="name">ceds_match_consignee</xsl:with-param>
	  	  			 <xsl:with-param name="override-displaymode">edit</xsl:with-param>
	  	  			 <xsl:with-param name="disabled">
		  	  			 <xsl:choose>
			  	  			 <xsl:when test="$displaymode = 'edit'">N</xsl:when>
			  	  			 <xsl:otherwise>Y</xsl:otherwise>
		  	  			 </xsl:choose>
	  	  			 </xsl:with-param>
	  	  			 <xsl:with-param name="checked"><xsl:value-of select ="ceds_match_consignee"/></xsl:with-param>
	     		 </xsl:call-template>
	     		 <xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_DETAILS_PO_MATCH_MANUFACTURER</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="toc-item">N</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DETAILS_PO_MATCH_NAME</xsl:with-param>
							<xsl:with-param name="name">ceds_match_mf_issuer_name</xsl:with-param>
							<xsl:with-param name="size">40</xsl:with-param>
							<xsl:with-param name="maxsize">70</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="country-field">
						    <xsl:with-param name="label">XSL_DETAILS_PO_COUNTRY</xsl:with-param>
						    <xsl:with-param name="name">ceds_match_mf_issuer_country</xsl:with-param>
						    <xsl:with-param name="override-displaymode">edit</xsl:with-param>
						    <xsl:with-param name="prefix">ceds_match_mf_issuer_country</xsl:with-param>
						    <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
					    </xsl:call-template>
					    
				 		<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_DETAILS_PO_PROPRIETARY_IDENTIFICATION</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="toc-item">N</xsl:with-param>
							<xsl:with-param name="content">
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_IDENTIFICATION</xsl:with-param>
									<xsl:with-param name="name">ceds_match_mf_identification</xsl:with-param>
									<xsl:with-param name="size">35</xsl:with-param>
									<xsl:with-param name="maxsize">35</xsl:with-param>
									<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_IDENTIFICATION_TYPE</xsl:with-param>
									<xsl:with-param name="name">ceds_match_mf_identification_type</xsl:with-param>
									<xsl:with-param name="size">35</xsl:with-param>
									<xsl:with-param name="maxsize">35</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:with-param>
				 </xsl:call-template>
				 
				 <xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_DETAILS_PO_LINE_ITEM_IDENTIFICATION_HEADER</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="toc-item">N</xsl:with-param>
					<xsl:with-param name="content">
						&nbsp;
						<xsl:call-template name="build-certificate-line-item-id-dojo-items">
							<xsl:with-param name="id">certificate_dataset_line_item_id</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</div>
			<div class="dijitDialogPaneActionBar">

				<xsl:call-template name="label-wrapper">
					<xsl:with-param name="content">
						<button type="button" dojoType="dijit.form.Button">
							<xsl:attribute name="onmouseup">dijit.byId('certificate-ds-details-dialog-template').hide();</xsl:attribute>
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
						</button>			
						<xsl:if test="$displaymode = 'edit'">				
						<button dojoType="dijit.form.Button">
							<xsl:attribute name="onClick">dijit.byId('certificate-ds-details-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
						</button>
						</xsl:if>

					</xsl:with-param>
				</xsl:call-template>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Other Certificate Dataset dialog declaration</xd:short>
		<xd:detail>
			This templates displays labels for BIC,Certificate type (in add,edit and view mode) and sets its parameters such as name,value,size of these field.
			This template also adds button cancel and OK button in dialog box.
 		</xd:detail>		
 	</xd:doc>
	<xsl:template name="other-certificate-ds-details-dialog-declaration">
		<div id="other-certificate-ds-details-dialog-template" style="display:none" class="widgetContainer">
		<xsl:attribute name="title">Confirmation</xsl:attribute>
			<div class="standardPODialogContent">
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_LABEL_BIC</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="toc-item">N</xsl:with-param>
					<xsl:with-param name="content">
						&nbsp;
						<xsl:call-template name="build-other-certificate-bic-dojo-items">
							<xsl:with-param name="id">other_certificate_dataset_bic</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:variable name="code_type"><xsl:value-of select="other_certificate_dataset/OthrCertDataSetReqrd/CertTp" /></xsl:variable>
				<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
				<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
				<xsl:variable name="parameterId">C024</xsl:variable>
				<xsl:choose>
					<xsl:when test="$displaymode='view' ">
						<xsl:if test="other_certificate_dataset/OthrCertDataSetReqrd/CertTp[.!='']">
								<xsl:call-template name="input-field">
								 	<xsl:with-param name="label">XSL_DETAILS_PO_CERTIFICATE_TYPE</xsl:with-param>
								 	<xsl:with-param name="name">ocds_cert_type</xsl:with-param>
								 	<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $code_type)"/></xsl:with-param>
								 	<xsl:with-param name="override-displaymode">view</xsl:with-param>	
								</xsl:call-template>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="select-field">
							<xsl:with-param name="label">XSL_DETAILS_PO_CERTIFICATE_TYPE</xsl:with-param>
							<xsl:with-param name="name">ocds_cert_type</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="required">Y</xsl:with-param>
							<xsl:with-param name="options">
								 <xsl:call-template name="ocds-cert-type-codes" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:call-template name="hidden-field">
			    	<xsl:with-param name="name">ocds_cert_type_hidden</xsl:with-param>	    
			     	<xsl:with-param name="value">
			     	 <xsl:if test="other_certificate_dataset/OthrCertDataSetReqrd/CertTp[.!='']">
			     	 <xsl:value-of select="localization:getCodeData($language,'*', $productCode, $parameterId, $code_type)"/>
			     	 </xsl:if>
			     	</xsl:with-param>  
			     </xsl:call-template>
			</div>
			<div class="dijitDialogPaneActionBar">
				<xsl:call-template name="label-wrapper">
					<xsl:with-param name="content">
						<button type="button" dojoType="dijit.form.Button">
							<xsl:attribute name="onmouseup">dijit.byId('other-certificate-ds-details-dialog-template').hide();</xsl:attribute>
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
						</button>
						<xsl:if test="$displaymode = 'edit'">							
						<button dojoType="dijit.form.Button">
							<xsl:attribute name="onClick">dijit.byId('other-certificate-ds-details-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
						</button>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</div>
		</div>
	</xsl:template>
	
	
	<xd:doc>
		<xd:short>Certificate Dataset detail declaration</xd:short>
		<xd:detail>
			This templates displays no certificate dataset message if there is no value in certificate dataset or adds button to add a certificate dataset.
 		</xd:detail>		
 	</xd:doc>
	<xsl:template name="certificate-ds-details-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="certificate-ds-details-dialog-declaration" />
		<!-- Dialog End -->
		<div id="certificate-ds-details-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_DETAILS_PO_NO_CERTIFICATE_DATASET')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ADD_CERTIFICATE_DATASET')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Other Certificate Dataset detail declaration</xd:short>
		<xd:detail>
			This templates displays no other certificate dataset message if there is no value in certificate dataset or adds button to add other certificate dataset.
 		</xd:detail>		
 	</xd:doc>
	<xsl:template name="other-certificate-ds-details-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="other-certificate-ds-details-dialog-declaration" />
		<!-- Dialog End -->
		<div id="other-certificate-ds-details-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_DETAILS_PO_NO_OTHER_CERTIFICATE_DATASET')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ADD_OTHER_CERTIFICATE_DATASET')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	
	<xd:doc>
		<xd:short>Build Commercial Dataset detail</xd:short>
		<xd:detail>
			This templates displays header for diplaying dataset in add,edit and view mode,also displayes submitter bic header.
 		</xd:detail>
 		<xd:param name="items"> Items to be build to form display</xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">display mode can be overriden in edit form.</xd:param>		
 	</xd:doc>
	<xsl:template name="build-commercial-ds-details-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
		<xsl:value-of select="override-displaymode"/>
		<div dojoType="misys.openaccount.widget.CommercialDatasetDetails" dialogId="commercial-ds-details-dialog-template" id="commercial-ds">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ADD_COMMERCIAL_DATASET')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_EDIT_COMMERCIAL_DATASET')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_VIEW_COMMERCIAL_DATASET')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of
						select="localization:getGTPString($language, 'XSL_HEADER_PO_SUBMITTER_BIC')" />,
			</xsl:attribute>
			<xsl:if test="$items">
			<xsl:for-each select="$items">
				<xsl:variable name="submitr" select="." />
				<div dojoType="misys.openaccount.widget.CommercialDatasetDetail">
				<xsl:attribute name="BIC"><xsl:value-of
						select="$submitr/BIC" /></xsl:attribute>
				</div>
			</xsl:for-each>
			</xsl:if>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Build Transport Dataset detail</xd:short>
		<xd:detail>
			This templates displays header for diplaying dataset in add,edit and view mode,also displayes submitter bic header. 
 		</xd:detail>
 		<xd:param name="items"> Items to be build to form display</xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">display mode can be overriden in edit form.</xd:param>		
 	</xd:doc>
	<xsl:template name="build-transport-ds-details-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->

		<div dojoType="misys.openaccount.widget.TransportDatasetDetails" dialogId="transport-ds-details-dialog-template" id="transport-ds-details">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ADD_TRANSPORT_DATASET')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_EDIT_TRANSPORT_DATASET')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_VIEW_TRANSPORT_DATASET')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of
						select="localization:getGTPString($language, 'XSL_HEADER_PO_SUBMITTER_BIC')" />,
			</xsl:attribute>
			<xsl:if test="$items">
			<xsl:for-each select="$items">
				<xsl:variable name="submitr" select="." />
				<div dojoType="misys.openaccount.widget.TransportDatasetDetail">
				<xsl:attribute name="BIC"><xsl:value-of
						select="$submitr/BIC" /></xsl:attribute>
				</div>
			</xsl:for-each>
			</xsl:if>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Build Payment Transport Dataset detail</xd:short>
		<xd:detail>
			This templates displays header for diplaying dataset in add,edit and view mode,also displayes submitter bic and name in header of table. 
 		</xd:detail>
 		<xd:param name="items"> Items to be build to form display</xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">display mode can be overriden in edit form.</xd:param>		
 	</xd:doc>
	<xsl:template name="build-payment-transport-ds-details-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->

		<div dojoType="misys.openaccount.widget.PaymentTransportDatasetDetails" dialogId="payment-transport-ds-details-dialog-template" id="payment-transport-ds-details">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ADD_TRANSPORT_DATASET')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_EDIT_TRANSPORT_DATASET')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_VIEW_TRANSPORT_DATASET')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of
						select="localization:getGTPString($language, 'XSL_DATA_SET_ID_HEADER')" />,
				<xsl:value-of
						select="localization:getGTPString($language, 'XSL_HEADER_PO_SUBMITTER_BIC')" />,
				<xsl:value-of
						select="localization:getGTPString($language, 'XSL_DATA_SET_VERSION_HEADER')" />,
			</xsl:attribute>
			<xsl:if test="$items">
			<xsl:for-each select="$items">
				<xsl:variable name="submitr" select="." />
				<div dojoType="misys.openaccount.widget.PaymentTransportDatasetDetail">
					<xsl:attribute name="payment_tds_version"><xsl:value-of
							select="DataSetId/payment_tds_version" /></xsl:attribute>
					<xsl:attribute name="payment_tds_id"><xsl:value-of
							select="DataSetId/payment_tds_id" /></xsl:attribute>
					<xsl:attribute name="payment_tds_bic"><xsl:value-of
							select="DataSetId/bic" /></xsl:attribute>
					<xsl:attribute name="payment_tds_prop_date"><xsl:value-of
							select="DataSetId/payment_tds_prop_date" /></xsl:attribute>
					<xsl:attribute name="payment_tds_actual_date"><xsl:value-of
							select="DataSetId/payment_tds_actual_date" /></xsl:attribute>							
												
					<xsl:call-template name="build-transport-document-ref-dojo-items">
							<xsl:with-param name="items" select="$submitr/TrnsprtDocRef/TrnsprtDocRefDtls" />
						<xsl:with-param name="id" select="payment_tds_dataset_transport_doc_ref" />
					</xsl:call-template>
					
					<xsl:call-template name="build-transported-goods-dojo-items">
							<xsl:with-param name="items" select="$submitr/TrnsprtdGoods/TrnsprtdGoodsDtls" />
						<xsl:with-param name="id" select="payment_tds_dataset_transported_goods" />
					</xsl:call-template>
					
					<xsl:call-template name="build-consignment-qty-details-dojo-items">
							<xsl:with-param name="items" select="$submitr/Consgnmt/TtlQty" />
						<xsl:with-param name="id" select="consignment_qty_details_id" />
					</xsl:call-template>

					<xsl:call-template name="build-consignment-vol-details-dojo-items">
							<xsl:with-param name="items" select="$submitr/Consgnmt/TtlVol" />
						<xsl:with-param name="id" select="consignment_vol_details_id" />
					</xsl:call-template>
					
					<xsl:call-template name="build-consignment-weight-details-dojo-items">
							<xsl:with-param name="items" select="$submitr/Consgnmt/TtlWght" />
						<xsl:with-param name="id" select="consignment_weight_details_id" />
					</xsl:call-template>
					
				</div>
			</xsl:for-each>
			</xsl:if>
		</div>
	</xsl:template>
	
	
	<xd:doc>
		<xd:short>Build Insurance Dataset detail</xd:short>
		<xd:detail>
			This templates displays header for diplaying dataset in add,edit and view mode,also displayes header of the Insurance dataset table.
			It also adds attributes of different fields in insurance dataset dialog under matcher issuer section,Properitry Id,clause required
			and BIC section and fills it with given value.
 		</xd:detail>
 		<xd:param name="items"> Items to be build to form display</xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">display mode can be overriden in edit form.</xd:param>		
 	</xd:doc>
	<xsl:template name="build-insurance-ds-details-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->

		<div dojoType="misys.openaccount.widget.InsuranceDatasetDetails" dialogId="insurance-ds-details-dialog-template" id="insurance-ds-details">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ADD_INSURANCE_DATASET')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_EDIT_INSURANCE_DATASET')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_VIEW_INSURANCE_DATASET')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of
						select="localization:getGTPString($language, 'XSL_LABEL_MATCH_ISSUER_NAME')" />,
			</xsl:attribute>
			<xsl:if test="$items">
			<xsl:for-each select="$items">
				<xsl:variable name="InsrncDataSetReqrd" select="." />
				<div dojoType="misys.openaccount.widget.InsuranceDatasetDetail">
				<xsl:attribute name="ids_match_issuer_name"><xsl:value-of
						select="$InsrncDataSetReqrd/MtchIssr/Nm" />
				</xsl:attribute>
				<xsl:attribute name="ids_match_issuer_country"><xsl:value-of
						select="$InsrncDataSetReqrd/MtchIssr/Ctry" />
				</xsl:attribute>
				<xsl:attribute name="ids_identification"><xsl:value-of
						select="$InsrncDataSetReqrd/MtchIssr/PrtryId/Id" />
				</xsl:attribute>
				<xsl:attribute name="ids_identification_type"><xsl:value-of
						select="$InsrncDataSetReqrd/MtchIssr/PrtryId/IdTp" />
				</xsl:attribute>
				<xsl:attribute name="ids_match_iss_date">
					<xsl:choose>
						<xsl:when test="$InsrncDataSetReqrd/MtchIsseDt = 'true'">Y</xsl:when>
						<xsl:otherwise>N</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
				<xsl:attribute name="ids_match_amount">
					<xsl:choose>
						<xsl:when test="$InsrncDataSetReqrd/MtchAmt = 'true'">Y</xsl:when>
						<xsl:otherwise>N</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
				<xsl:attribute name="ids_match_transport">
					<xsl:choose>
						<xsl:when test="$InsrncDataSetReqrd/MtchTrnsprt = 'true'">Y</xsl:when>
						<xsl:otherwise>N</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
				<xsl:attribute name="ids_match_assured_party"><xsl:value-of
						select="$InsrncDataSetReqrd/MtchAssrdPty" />
				</xsl:attribute>
				<div dojoType="misys.openaccount.widget.InsuranceSubmittrBics">
					<xsl:apply-templates select="$InsrncDataSetReqrd/Submitr"/>
				</div>
				<div dojoType="misys.openaccount.widget.InsuranceRequiredClauses">
					<xsl:apply-templates select="$InsrncDataSetReqrd/ClausesReqrd"/>
				</div>
				</div>
			</xsl:for-each>
			</xsl:if>
		</div>
	</xsl:template>
	
	
	<xd:doc>
		<xd:short>Build Insurence Dataset detail</xd:short>
		<xd:detail>
			This templates adds attribute which is id of BIC field and fill it with BIC value.
 		</xd:detail>		
 	</xd:doc>
	<xsl:template match="insurance_dataset/InsrncDataSetReqrd/Submitr">
		<div dojoType="misys.openaccount.widget.InsuranceSubmittrBic">
			<xsl:attribute name="ids_bic"><xsl:value-of select="BIC"/></xsl:attribute>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Clause Required</xd:short>
		<xd:detail>
			This templates defines 3 variable with different value and fills the value of a attribute based on these values.
 		</xd:detail>	
 	</xd:doc>
	<xsl:template match="ClausesReqrd">
		<xsl:variable name="code_type"><xsl:value-of select="."></xsl:value-of></xsl:variable>
		<xsl:variable name="parameterId">C022</xsl:variable>
		<xsl:variable name="code_type_desc"><xsl:value-of select="localization:getCodeData($language,'*', product_code, $parameterId, $code_type)"/></xsl:variable>
		<div dojoType="misys.openaccount.widget.InsuranceRequiredClause">
			<xsl:attribute name="ids_clauses_required"><xsl:value-of select="."/></xsl:attribute>
			<xsl:attribute name="ids_clauses_required_hidden"><xsl:value-of select="$code_type_desc"/></xsl:attribute>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Build Certificate dataset</xd:short>
		<xd:detail>
			This templates displays header for diplaying dataset in add,edit and view mode,also displayes header of the certificate dataset table.
			It also adds defines variables and adds attributes of different fields in certificate dataset dialog under matcher issuer section,Properitry Id etc
			 fills it with given value.
 		</xd:detail>
 		<xd:param name="items"> Items to be build to form display</xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">display mode can be overriden in edit form.</xd:param>		
 	</xd:doc>
	<xsl:template name="build-certificate-ds-details-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->

		<div dojoType="misys.openaccount.widget.CertificateDatasetDetails" dialogId="certificate-ds-details-dialog-template" id="certificate-ds-details">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ADD_CERTIFICATE_DATASET')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_EDIT_CERTIFICATE_DATASET')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_VIEW_CERTIFICATE_DATASET')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of
						select="localization:getGTPString($language, 'XSL_LABEL_CERTIFICATE_TYPE')" />,
			</xsl:attribute>
			<xsl:if test="$items">
			<xsl:for-each select="$items">
				<xsl:variable name="code_type"><xsl:value-of select="./CertTp"></xsl:value-of></xsl:variable>
				<xsl:variable name="parameterId">C021</xsl:variable>
				<xsl:variable name="code_type_desc"><xsl:value-of select="localization:getCodeData($language,'*', product_code, $parameterId, $code_type)"/></xsl:variable>
				<xsl:variable name="CertDataSetReqrd" select="." />
				<div dojoType="misys.openaccount.widget.CertificateDatasetDetail">
				<xsl:attribute name="ceds_cert_type"><xsl:value-of
						select="$CertDataSetReqrd/CertTp" />
				</xsl:attribute>
				<xsl:attribute name="ceds_match_issuer_name"><xsl:value-of
						select="$CertDataSetReqrd/MtchIssr/Nm" />
				</xsl:attribute>
				<xsl:attribute name="ceds_match_issuer_country"><xsl:value-of
						select="$CertDataSetReqrd/MtchIssr/Ctry" />
				</xsl:attribute>
				<xsl:attribute name="ceds_identification"><xsl:value-of
						select="$CertDataSetReqrd/MtchIssr/PrtryId/Id" />
				</xsl:attribute>
				<xsl:attribute name="ceds_identification_type"><xsl:value-of
						select="$CertDataSetReqrd/MtchIssr/PrtryId/IdTp" />
				</xsl:attribute>
				<xsl:attribute name="ceds_match_iss_date">
					<xsl:choose>
						<xsl:when test="$CertDataSetReqrd/MtchIsseDt = 'true'">Y</xsl:when>
						<xsl:otherwise>N</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
				<xsl:attribute name="ceds_match_insp_date">
					<xsl:choose>
						<xsl:when test="$CertDataSetReqrd/MtchInspctnDt = 'true'">Y</xsl:when>
						<xsl:otherwise>N</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
				<xsl:attribute name="ceds_match_insp_ind">
					<xsl:choose>
						<xsl:when test="$CertDataSetReqrd/AuthrsdInspctrInd = 'true'">Y</xsl:when>
						<xsl:otherwise>N</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
				<xsl:attribute name="ceds_match_consignee">
					<xsl:choose>
						<xsl:when test="$CertDataSetReqrd/MtchConsgn = 'true'">Y</xsl:when>
						<xsl:otherwise>N</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
				<xsl:attribute name="ceds_match_mf_issuer_name"><xsl:value-of
						select="$CertDataSetReqrd/MtchManfctr/Nm" />
				</xsl:attribute>
				<xsl:attribute name="ceds_match_mf_issuer_country"><xsl:value-of
						select="$CertDataSetReqrd/MtchManfctr/Ctry" />
				</xsl:attribute>
				<xsl:attribute name="ceds_match_mf_identification"><xsl:value-of
						select="$CertDataSetReqrd/MtchManfctr/PrtryId/Id" />
				</xsl:attribute>
				<xsl:attribute name="ceds_match_mf_identification_type"><xsl:value-of
						select="$CertDataSetReqrd/MtchManfctr/PrtryId/IdTp" />
				</xsl:attribute>
				<xsl:attribute name="ceds_cert_type_hidden"><xsl:value-of select="$code_type_desc" /></xsl:attribute>
				<div dojoType="misys.openaccount.widget.CertificateSubmittrBics">
					<xsl:apply-templates select="$CertDataSetReqrd/Submitr"/>
				</div>
				<div dojoType="misys.openaccount.widget.CertificateLineItemIdentifications">
					<xsl:apply-templates select="$CertDataSetReqrd/LineItmId"/>
				</div>
				</div>
			</xsl:for-each>
			</xsl:if>
		</div>
	</xsl:template>
	
	
	<xd:doc>
		<xd:short>Build Certificate dataset</xd:short>
		<xd:detail>
			This templates adds BIC field id attributes in certificate dataset and fills it with value from BIC.
		</xd:detail>		
 	</xd:doc>
	<xsl:template match="certificate_dataset/CertDataSetReqrd/Submitr">
		<div dojoType="misys.openaccount.widget.CertificateSubmittrBic">
			<xsl:attribute name="ceds_bic"><xsl:value-of select="BIC"/></xsl:attribute>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Line Item Id</xd:short>
		<xd:detail>
			This templates adds id of line item identification inside certificate dataset and fill it with the value.
			</xd:detail>	
 	</xd:doc>
	<xsl:template match="LineItmId">
		<div dojoType="misys.openaccount.widget.CertificateLineItemIdentification">
			<xsl:attribute name="ceds_line_item_id"><xsl:value-of select="."/></xsl:attribute>
		</div>
	</xsl:template>
	
	
	<xd:doc>
		<xd:short>Build Other Certificate dataset</xd:short>
		<xd:detail>
			This templates displays header for diplaying dataset in add,edit and view mode,also displayes header of the certificate dataset table.
			It also defines variables and adds attributes of different fields in other certificate dataset dialog fills it with given value.
 		</xd:detail>
 		<xd:param name="items"> Items to be build to form display</xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">display mode can be overriden in edit form.</xd:param>		
 	</xd:doc>
	<xsl:template name="build-other-certificate-ds-details-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->

		<div dojoType="misys.openaccount.widget.OtherCertificateDatasetDetails" dialogId="other-certificate-ds-details-dialog-template" id = "other-certificate-ds-details">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ADD_OTHER_CERTIFICATE_DATASET')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_EDIT_OTHER_CERTIFICATE_DATASET')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_VIEW_OTHER_CERTIFICATE_DATASET')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of
						select="localization:getGTPString($language, 'XSL_LABEL_CERTIFICATE_TYPE')" />,
			</xsl:attribute>
			<xsl:if test="$items">
			<xsl:for-each select="$items">
				<xsl:variable name="code_type"><xsl:value-of select="./CertTp"></xsl:value-of></xsl:variable>
				<xsl:variable name="parameterId">C024</xsl:variable>
				<xsl:variable name="code_type_desc"><xsl:value-of select="localization:getCodeData($language,'*', product_code, $parameterId, $code_type)"/></xsl:variable>
				<xsl:variable name="OthrCertDataSetReqrd" select="." />
				<div dojoType="misys.openaccount.widget.OtherCertificateDatasetDetail">
				<xsl:attribute name="ocds_cert_type"><xsl:value-of
						select="$OthrCertDataSetReqrd/CertTp" />
				</xsl:attribute>
				<xsl:attribute name="ocds_cert_type_hidden"><xsl:value-of
						select="$code_type_desc" />
				</xsl:attribute>
				<div dojoType="misys.openaccount.widget.OtherCertificateSubmittrBics">
					<xsl:apply-templates select="$OthrCertDataSetReqrd/Submitr"/>
				</div>
				</div>
			</xsl:for-each>
			</xsl:if>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Submitter template</xd:short>
		<xd:detail>
			This templates adds id of BIC field attribute and fill it with value from BIC
 		</xd:detail>	
 	</xd:doc>
	<xsl:template match="Submitr">
		<div dojoType="misys.openaccount.widget.OtherCertificateSubmittrBic">
			<xsl:attribute name="ocds_bic"><xsl:value-of select="BIC"/></xsl:attribute>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Insurence BIC dialog declaration</xd:short>
		<xd:detail>
			This templates adds attribute title and fills it with Confirmation value,It also calls input field template for BIC in insurance dialog
			and sets it parameters with different value.it also adds button of OK and CANCEL in the dialog box.
 		</xd:detail>	
 	</xd:doc>
		<xsl:template name="insurance-bic-dialog-declaration">
		<div id="insurance-bic-dialog-template" style="display:none"
			class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>

					<div>
						<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_PURCHASE_ORDER_SUBMITTER_BIC</xsl:with-param>
					<xsl:with-param name="name">ids_bic</xsl:with-param>
					<xsl:with-param name="override-displaymode">edit</xsl:with-param>
					<xsl:with-param name="size">35</xsl:with-param>
					<xsl:with-param name="maxsize">35</xsl:with-param>
					<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
					<xsl:with-param name="value"></xsl:with-param>
					<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
					</xsl:call-template>
						<div class="dijitDialogPaneActionBar">
						<xsl:call-template name="label-wrapper">
							<xsl:with-param name="content">
								<button type="button" dojoType="dijit.form.Button">
									<xsl:attribute name="onmouseup">dijit.byId('insurance-bic-dialog-template').hide();</xsl:attribute>
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
								</button>							
								<xsl:if test="$displaymode = 'edit'">
									<button dojoType="dijit.form.Button">
										<xsl:attribute name="onClick">dijit.byId('insurance-bic-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
									</button>
								</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
						</div>
					</div>

		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Insurance BIC declaration</xd:short>
		<xd:detail>
			This templates displays message NO bic if no BIC is there or provide a button to ADD BIC in Insurence dataset dialog box
 		</xd:detail>		
 	</xd:doc>
	<xsl:template name="insurance-bic-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="insurance-bic-dialog-declaration" />
		<!-- Dialog End -->
		<div id="insurance-bic-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_BPO_NO_BIC')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_BPO_ADD_BIC')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	
	<xd:doc>
		<xd:short>Build Insurence BIC</xd:short>
		<xd:detail>
			This templates displays BIC header inside Insurence dataset in add,edit and view mode,also displayes header in BIC table.
			It also defines variables and adds attributes and fills it with given selected value.
 		</xd:detail>
 		<xd:param name="items"> Items to be build to form display</xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">display mode can be overriden in edit form.</xd:param>		
 	</xd:doc>
	<xsl:template name="build-insurance-bic-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
		
		<div dojoType="misys.openaccount.widget.InsuranceSubmittrBics" dialogId="insurance-bic-dialog-template">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_BPO_ADD_BIC')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_BPO_EDIT_BIC')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_BPO_VIEW_BIC')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_LABEL_BIC')" />,
			</xsl:attribute>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
			 <xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="InsrncDataSetReqrd" select="./insurance_dataset/InsrncDataSetReqrd" />
					<div dojoType="misys.openaccount.widget.InsuranceSubmittrBic">
						<xsl:attribute name="BIC"><xsl:value-of
						select="$InsrncDataSetReqrd/Submitr/BIC"/>
				</xsl:attribute>
					</div>
				</xsl:for-each>
			</xsl:if>
		</div>

	</xsl:template>
	
	
	<xd:doc>
		<xd:short>Certificate BIC dialog declaration</xd:short>
		<xd:detail>
			This templates adds attribute title and fills it with Confirmation value,It also calls input field template for BIC in certificate dialog
			and sets it parameters with different value.it also adds button of OK and CANCEL in the dialog box.
 		</xd:detail>	
 	</xd:doc>
	<xsl:template name="certificate-bic-dialog-declaration">
		<div id="certificate-bic-dialog-template" style="display:none"
			class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>

					<div>
						<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_PURCHASE_ORDER_SUBMITTER_BIC</xsl:with-param>
					<xsl:with-param name="name">ceds_bic</xsl:with-param>
					<xsl:with-param name="override-displaymode">edit</xsl:with-param>
					<xsl:with-param name="size">35</xsl:with-param>
					<xsl:with-param name="maxsize">35</xsl:with-param>
					<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
					<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
					</xsl:call-template>
						<div class="dijitDialogPaneActionBar">
						<xsl:call-template name="label-wrapper">
							<xsl:with-param name="content">
								<button type="button" dojoType="dijit.form.Button">
									<xsl:attribute name="onmouseup">dijit.byId('certificate-bic-dialog-template').hide();</xsl:attribute>
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
								</button>							
								<xsl:if test="$displaymode = 'edit'">
									<button dojoType="dijit.form.Button">
										<xsl:attribute name="onClick">dijit.byId('certificate-bic-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
									</button>
								</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
						</div>
					</div>

		</div>
	</xsl:template>
	
	
	<xd:doc>
		<xd:short>Certificate BIC declaration</xd:short>
		<xd:detail>
			This templates displays message NO bic if no BIC is there or provide a button to ADD BIC in dialog box
 		</xd:detail>		
 	</xd:doc>
	<xsl:template name="certificate-bic-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="certificate-bic-dialog-declaration" />
		<!-- Dialog End -->
		<div id="certificate-bic-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_BPO_NO_BIC')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_BPO_ADD_BIC')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Build Certificate BIC</xd:short>
		<xd:detail>
			This templates displays BIC header inside certificate dataset in add,edit and view mode,also displayes header in BIC table.
			It also defines variables and adds attributes and fills it with given selected value.
 		</xd:detail>
 		<xd:param name="items"> Items to be build to form display</xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">display mode can be overriden in edit form.</xd:param>		
 	</xd:doc>
	<xsl:template name="build-certificate-bic-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
		
		<div dojoType="misys.openaccount.widget.CertificateSubmittrBics" dialogId="certificate-bic-dialog-template">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_BPO_ADD_BIC')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_BPO_EDIT_BIC')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_BPO_VIEW_BIC')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_LABEL_BIC')" />,
			</xsl:attribute>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
			 <xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="CertDataSetReqrd" select="./certificate_dataset/CertDataSetReqrd" />
					<div dojoType="misys.openaccount.widget.CertificateSubmittrBic">
						<xsl:attribute name="BIC"><xsl:value-of
						select="$CertDataSetReqrd/Submitr/BIC" />
				</xsl:attribute>
					</div>
				</xsl:for-each>
			</xsl:if>
		</div>

	</xsl:template>
	
	<xd:doc>
		<xd:short>Other Certificate BIC dialog declaration</xd:short>
		<xd:detail>
			This templates adds attribute title and fills it with Confirmation value,It also calls input field template for BIC in other certificate dialog
			and sets it parameters with different value.it also adds button of OK and CANCEL in the dialog box.
 		</xd:detail>	
 	</xd:doc>
	<xsl:template name="other-certificate-bic-dialog-declaration">
		<div id="other-certificate-bic-dialog-template" style="display:none"
			class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>

					<div>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_PURCHASE_ORDER_SUBMITTER_BIC</xsl:with-param>
						<xsl:with-param name="name">ocds_bic</xsl:with-param>
						<xsl:with-param name="override-displaymode">edit</xsl:with-param>
						<xsl:with-param name="size">35</xsl:with-param>
						<xsl:with-param name="maxsize">35</xsl:with-param>
						<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
						<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
					</xsl:call-template>
						<div class="dijitDialogPaneActionBar">
						<xsl:call-template name="label-wrapper">
							<xsl:with-param name="content">
								<button type="button" dojoType="dijit.form.Button">
									<xsl:attribute name="onmouseup">dijit.byId('other-certificate-bic-dialog-template').hide();</xsl:attribute>
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
								</button>							
								<xsl:if test="$displaymode = 'edit'">
									<button dojoType="dijit.form.Button">
										<xsl:attribute name="onClick">dijit.byId('other-certificate-bic-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
									</button>
								</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
						</div>
					</div>

		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Other Certificate BIC declaration</xd:short>
		<xd:detail>
			This templates displays message NO bic if no BIC is there or provide a button to ADD BIC in Insurence dataset dialog box
 		</xd:detail>		
 	</xd:doc>
	<xsl:template name="other-certificate-bic-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="other-certificate-bic-dialog-declaration" />
		<!-- Dialog End -->
		<div id="other-certificate-bic-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_BPO_NO_BIC')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_BPO_ADD_BIC')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	
	<xd:doc>
		<xd:short>Build Other Certificate BIC</xd:short>
		<xd:detail>
			This templates displays BIC header inside other certificate dataset in add,edit and view mode,also displayes header in BIC table.
			It also defines variables and adds attributes and fills it with given selected value.
 		</xd:detail>
 		<xd:param name="items"> Items to be build to form display</xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">display mode can be overriden in edit form.</xd:param>		
 	</xd:doc>
	<xsl:template name="build-other-certificate-bic-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
		
		<div dojoType="misys.openaccount.widget.OtherCertificateSubmittrBics" dialogId="other-certificate-bic-dialog-template">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_BPO_ADD_BIC')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_BPO_EDIT_BIC')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_BPO_VIEW_BIC')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_LABEL_BIC')" />,
			</xsl:attribute>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
			 <xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="OthrCertDataSetReqrd" select="./other_certificate_dataset/OthrCertDataSetReqrd" />
					<div dojoType="misys.openaccount.widget.OtherCertificateSubmittrBic">
						<xsl:attribute name="BIC"><xsl:value-of
						select="$OthrCertDataSetReqrd/Submitr/BIC" />
				</xsl:attribute>
					</div>
				</xsl:for-each>
			</xsl:if>
		</div>

	</xsl:template>
	
	
	<xd:doc>
		<xd:short>Certificate Id dialog declaration</xd:short>
		<xd:detail>
			This templates adds attribute title and fills it with Confirmation ,It also calls input field template for Line item identification inside Certificate dialog
			and sets it parameters.it also adds button of OK and CANCEL in the dialog box.
 		</xd:detail>	
 	</xd:doc>
	<xsl:template name="certificate-line-item-id-dialog-declaration">
		<div id="certificate-line-item-id-dialog-template" style="display:none"
			class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>

					<div>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DETAILS_PO_LINE_ITEM_IDENTIFICATION</xsl:with-param>
							<xsl:with-param name="name">ceds_line_item_id</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">70</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
						</xsl:call-template>
						<div class="dijitDialogPaneActionBar">
						<xsl:call-template name="label-wrapper">
							<xsl:with-param name="content">
								<button type="button" dojoType="dijit.form.Button">
									<xsl:attribute name="onmouseup">dijit.byId('certificate-line-item-id-dialog-template').hide();</xsl:attribute>
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
								</button>							
								<xsl:if test="$displaymode = 'edit'">
									<button dojoType="dijit.form.Button">
										<xsl:attribute name="onClick">dijit.byId('certificate-line-item-id-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
									</button>
								</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
						</div>
					</div>

		</div>
	</xsl:template>
	
	
	<xd:doc>
		<xd:short>Certificate Line item Id declaration</xd:short>
		<xd:detail>
			This templates displays message NO Line item id if no Line item is there or provide a button to ADD Line item identification in Certificate dataset dialog box
 		</xd:detail>		
 	</xd:doc>
	<xsl:template name="certificate-line-item-id-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="certificate-line-item-id-dialog-declaration" />
		<!-- Dialog End -->
		<div id="certificate-line-item-id-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_NO_LINE_ITEM_ID')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_ADD_LINE_ITEM_ID')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	
	<xd:doc>
		<xd:short>Build Certificate Line Item </xd:short>
		<xd:detail>
			This templates displays Line item header inside certificate dataset in add,edit and view mode,also displayes header in Line Item table.
			It also defines variables and adds attributes and fills it with given selected value.
 		</xd:detail>
 		<xd:param name="items"> Items to be build to form display</xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">display mode can be overriden in edit form.</xd:param>		
 	</xd:doc>
	<xsl:template name="build-certificate-line-item-id-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
		
		<div dojoType="misys.openaccount.widget.CertificateLineItemIdentifications" dialogId="certificate-line-item-id-dialog-template">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_ADD_LINE_ITEM_ID')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_EDIT_LINE_ITEM_ID')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_VIEW_LINE_ITEM_ID')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_LABEL_LINE_ITEM_ID')" />,
			</xsl:attribute>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
			 <xsl:if test="$items">
			 
				<xsl:for-each select="$items">
					<xsl:variable name="CertDataSetReqrd" select="./certificate_dataset/CertDataSetReqrd" />
					<div dojoType="misys.openaccount.widget.CertificateLineItemIdentification">
						<xsl:attribute name="LineItmId"><xsl:value-of
						select="$CertDataSetReqrd/LineItmId" />
				</xsl:attribute>
					</div>
				</xsl:for-each>
			</xsl:if>
		</div>

	</xsl:template>
	
	
	<xd:doc>
		<xd:short>Insurance Required Clause Dialog declaration</xd:short>
		<xd:detail>
			This templates adds a title attributes and and fills it with it Confirmation,it also defines variables and sets the parameters of Clause required field in Insurence dataset based on these
			variables in input and select field.It also adds parameter of the hidden field and adds Cancel and Ok button to the clause dialog box
 		</xd:detail>	
 	</xd:doc>
	<xsl:template name="insurance-required-clause-dialog-declaration">
		<div id="insurance-required-clause-dialog-template" style="display:none"
			class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>

					<div>
						<xsl:variable name="code_type"><xsl:value-of select="insurance_dataset/InsrncDataSetReqrd/ClausesReqrd"></xsl:value-of></xsl:variable>
						<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
						<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
						<xsl:variable name="parameterId">C022</xsl:variable>
						<xsl:choose>
						<xsl:when test="$displaymode='view' ">
							<xsl:if test="insurance_dataset/InsrncDataSetReqrd/ClausesReqrd[.!='']">
								<xsl:variable name="code_type"><xsl:value-of select="insurance_dataset/InsrncDataSetReqrd/ClausesReqrd"></xsl:value-of></xsl:variable>
								<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
								<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
								<xsl:variable name="parameterId">C022</xsl:variable>
									<xsl:call-template name="input-field">
									 	<xsl:with-param name="label">XSL_DETAILS_PO_CLAUSES_REQUIRED</xsl:with-param>
									 	<xsl:with-param name="name">ids_clauses_required</xsl:with-param>
									 	<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $code_type)"/></xsl:with-param>
									 	<xsl:with-param name="override-displaymode">view</xsl:with-param>	
									</xsl:call-template>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="select-field">
								<xsl:with-param name="label">XSL_DETAILS_PO_CLAUSES_REQUIRED</xsl:with-param>
								<xsl:with-param name="name">ids_clauses_required</xsl:with-param>
								<xsl:with-param name="override-displaymode">edit</xsl:with-param>
								<xsl:with-param name="required">N</xsl:with-param>
								<xsl:with-param name="options">
									 <xsl:call-template name="ids-clauses-required-codes" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
						
					<xsl:call-template name="hidden-field">
			    	<xsl:with-param name="name">ids_clauses_required_hidden</xsl:with-param>	    
			     	<xsl:with-param name="value">
			     	 <xsl:if test="insurance_dataset/InsrncDataSetReqrd/ClausesReqrd[.!='']">
			     	 <xsl:value-of select="localization:getCodeData($language,'*', $productCode, $parameterId, $code_type)"/>
			     	 </xsl:if>
			     	</xsl:with-param>  
			     </xsl:call-template>
						
						<div class="dijitDialogPaneActionBar">
						<xsl:call-template name="label-wrapper">
							<xsl:with-param name="content">
								<button type="button" dojoType="dijit.form.Button">
									<xsl:attribute name="onmouseup">dijit.byId('insurance-required-clause-dialog-template').hide();</xsl:attribute>
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
								</button>							
								<xsl:if test="$displaymode = 'edit'">
									<button dojoType="dijit.form.Button">
										<xsl:attribute name="onClick">dijit.byId('insurance-required-clause-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
									</button>
								</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
						</div>
					</div>

		</div>
	</xsl:template>
	
	
	<xd:doc>
		<xd:short>Insurance Required Clause Declaration</xd:short>
		<xd:detail>
			This templates displayes no clause required message or add clause required button.
 		</xd:detail>	
 	</xd:doc>
	<xsl:template name="insurance-required-clause-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="insurance-required-clause-dialog-declaration" />
		<!-- Dialog End -->
		<div id="insurance-required-clause-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_NO_CLAUSE_REQ')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_ADD_CLAUSE_REQ')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	
	<xd:doc>
		<xd:short>Build Insurence required clause</xd:short>
		<xd:detail>
			This templates displays header for diplaying clause field in insurence dataset in add,edit and view mode,also displayes header of the clause table.
			It also defines variables and adds attributes of different fields in clause dialog fills it with given value.
 		</xd:detail>
 		<xd:param name="items"> </xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">Overridden display mode.</xd:param>		
 	</xd:doc>
	<xsl:template name="build-insurance-required-clause-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
		
		<div dojoType="misys.openaccount.widget.InsuranceRequiredClauses" dialogId="insurance-required-clause-dialog-template">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_ADD_CLAUSE_REQ')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_EDIT_CLAUSE_REQ')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_VIEW_CLAUSE_REQ')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_LABEL_CLAUSE_REQ')" />,
			</xsl:attribute>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
			 <xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="CertDataSetReqrd" select="./CertDataSetReqrd" />
					<div dojoType="misys.openaccount.widget.InsuranceRequiredClause">
						<xsl:attribute name="LineItmId"><xsl:value-of
						select="$CertDataSetReqrd/LineItmId" />
				</xsl:attribute>
					</div>
				</xsl:for-each>
			</xsl:if>
		</div>

	</xsl:template>

	
	<xd:doc>
		<xd:short>Charge payer code</xd:short>
		<xd:detail>
			This templates adds value attribute and fill it with value from charges payer code.It also fills charges payer description
 		</xd:detail>		
 	</xd:doc>
	<xsl:template name="charges_payer_code_options">
		<xsl:for-each select="charges_payer/charges_payer_details">
	        <option>
	           <xsl:attribute name="value">
	            <xsl:value-of select="charges_payer_code"></xsl:value-of>
	            </xsl:attribute>
	            <xsl:value-of select="charges_payer_description"/>
	        </option>
      	</xsl:for-each>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Charge payee code</xd:short>
		<xd:detail>
			This templates adds value attribute and fill it with value from charges payee code.It also fills charges payee description
 		</xd:detail>		
 	</xd:doc>
	<xsl:template name="charges_payee_code_options">
		<xsl:for-each select="charges_payee/charges_payee_details">
	        <option>
	           <xsl:attribute name="value">
	            <xsl:value-of select="charges_payee_code"></xsl:value-of>
	            </xsl:attribute>
	            <xsl:value-of select="charges_payee_description"/>
	        </option>
      	</xsl:for-each>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Certificate type code</xd:short>
		<xd:detail>
			This templates adds value attribute and fill it with value from certificate type code.It also fills certificate type description
 		</xd:detail>		
 	</xd:doc>
	<xsl:template name="ceds-cert-type-codes">
		<xsl:for-each select="certificate_types/certificate_type_details">
	        <option>
	           <xsl:attribute name="value">
	            <xsl:value-of select="certificate_type_code"></xsl:value-of>
	            </xsl:attribute>
	            <xsl:value-of select="certificate_type_description"/>
	        </option>
      	</xsl:for-each>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Payment term code</xd:short>
		<xd:detail>
			This templates adds value attribute and fill it with value from payment term code.It also fills payment term description
 		</xd:detail>		
 	</xd:doc>
	<xsl:template name="payment_term_code_options">
		<xsl:for-each select="payment_terms/payment_term_details">
	        <option>
	           <xsl:attribute name="value">
	            <xsl:value-of select="payment_term_code"></xsl:value-of>
	            </xsl:attribute>
	            <xsl:value-of select="payment_term_description"/>
	        </option>
      	</xsl:for-each>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Other certificate type code</xd:short>
		<xd:detail>
			This templates adds value attribute and fill it with value from other certificate type code.It also fills other certificate type description
 		</xd:detail>		
 	</xd:doc>
	<xsl:template name="ocds-cert-type-codes">
		<xsl:for-each select="other_certificate_type/other_certificate_type_details">
	        <option>
	           <xsl:attribute name="value">
	            <xsl:value-of select="other_certificate_type_code"></xsl:value-of>
	            </xsl:attribute>
	            <xsl:value-of select="other_certificate_type_description"/>
	        </option>
      	</xsl:for-each>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Match assured party code</xd:short>
		<xd:detail>
			This templates adds value attribute and fill it with value from other match assured party code.It also fills match assured party description
 		</xd:detail>		
 	</xd:doc>
	<xsl:template name="ids-match-assured-party-codes">
		<xsl:for-each select="match_assured_party/match_assured_party_details">
	        <option>
	           <xsl:attribute name="value">
	            <xsl:value-of select="match_assured_party_code"></xsl:value-of>
	            </xsl:attribute>
	            <xsl:value-of select="match_assured_party_description"/>
	        </option>
      	</xsl:for-each>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Clause Required code</xd:short>
		<xd:detail>
			This templates adds value attribute and fill it with value from other Clause required code.It also fills clause required description
 		</xd:detail>		
 	</xd:doc>
	<xsl:template name="ids-clauses-required-codes">
		<xsl:for-each select="clauses_required/clauses_reqd_details">
	        <option>
	           <xsl:attribute name="value">
	            <xsl:value-of select="clauses_reqd_code"></xsl:value-of>
	            </xsl:attribute>
	            <xsl:value-of select="clauses_reqd_description"/>
	        </option>
      	</xsl:for-each>
	</xsl:template>



<xd:doc>
		<xd:short>Bank Payment obligation detail declaration</xd:short>
		<xd:detail>
			This templates displays no Bank Payment Obligation message if there is no value in BPO dataset or adds button to add a Bank Payment Obligation.
 		</xd:detail>		
 </xd:doc>
<xsl:template name="bank-payment-obligation-details-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="bank-payment-obligation-details-dialog-declaration" />
		<!-- Dialog End -->
		<div id="bank-payment-obligation-details-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_DETAILS_PO_NO_BPO_DATASET')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button id="add_bpo_button" type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ADD_BPO_DATASET')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Charges</xd:short>
		<xd:detail>
			This templates adds different attributes in Charges widget and fill it with the value from given select field.
 		</xd:detail>		
 	</xd:doc>
	<xsl:template match="Chrgs">
		<div dojoType="misys.openaccount.widget.Charge">
			<xsl:attribute name="payment_charges_payer"><xsl:value-of select="ChrgsPyer"/></xsl:attribute>
			<xsl:attribute name="payment_charges_payee"><xsl:value-of select="ChrgsPyee"/></xsl:attribute>
			<xsl:attribute name="payment_charges_amount"><xsl:value-of select="Amt"/></xsl:attribute>
			<xsl:attribute name="payment_charges_percent"><xsl:value-of select="Pctg"/></xsl:attribute>
			<xsl:attribute name="payment_charge_type"><xsl:value-of select="Tp"/></xsl:attribute>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Charge dialog declaration</xd:short>
		<xd:detail>
			This templates adds attribute title and fills it with Confirmation ,It also calls input field template and select field template for Charges payer and payee in BPO
			dialog box and sets it parameters.It also adds amount percentage and type field in charge dialog in BPO.It also adds button of OK and CANCEL in the dialog box.
 		</xd:detail>	
 	</xd:doc>
	<xsl:template name="charge-dialog-declaration">
		<div id="charge-dialog-template" style="display:none"
			class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
			<div id="charge-dialog-template-content" class="standardPODialogContent">
					<div>
						<xsl:choose>
							<xsl:when test="$displaymode='view' ">
								<xsl:if test="bank_payment_obligation/PmtOblgtn/Chrgs/ChrgsPyer[.!='']">
									<xsl:variable name="code_type"><xsl:value-of select="bank_payment_obligation/PmtOblgtn/Chrgs/ChrgsPyer"></xsl:value-of></xsl:variable>
									<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
									<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
									<xsl:variable name="parameterId">C018</xsl:variable>
										<xsl:call-template name="input-field">
										 	<xsl:with-param name="label">XSL_LABEL_CHARGES_PAYER</xsl:with-param>
										 	<xsl:with-param name="name">payment_charges_payer</xsl:with-param>
										 	<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $code_type)"/></xsl:with-param>
										 	<xsl:with-param name="override-displaymode">view</xsl:with-param>
										 	<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>	
										</xsl:call-template>
								</xsl:if>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="select-field">
									<xsl:with-param name="label">XSL_LABEL_CHARGES_PAYER</xsl:with-param>
									<xsl:with-param name="id">payment_charges_payer</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="required">N</xsl:with-param>
									<xsl:with-param name="options">
										<xsl:call-template name="charges_payer_code_options"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:choose>
							<xsl:when test="$displaymode='view' ">
								<xsl:if test="bank_payment_obligation/PmtOblgtn/Chrgs/ChrgsPyer[.!='']">
									<xsl:variable name="code_type"><xsl:value-of select="bank_payment_obligation/PmtOblgtn/Chrgs/ChrgsPyee"></xsl:value-of></xsl:variable>
									<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
									<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
									<xsl:variable name="parameterId">C019</xsl:variable>
										<xsl:call-template name="input-field">
										 	<xsl:with-param name="label">XSL_LABEL_CHARGES_PAYEE</xsl:with-param>
										 	<xsl:with-param name="name">payment_charges_payee</xsl:with-param>
										 	<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $code_type)"/></xsl:with-param>
										 	<xsl:with-param name="override-displaymode">view</xsl:with-param>	
										</xsl:call-template>
								</xsl:if>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="select-field">
									<xsl:with-param name="label">XSL_LABEL_CHARGES_PAYEE</xsl:with-param>
									<xsl:with-param name="id">payment_charges_payee</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="required">N</xsl:with-param>
									<xsl:with-param name="options">
										<xsl:call-template name="charges_payee_code_options"/>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>	
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PARTIESDETAILS_FT_AMT_LABEL</xsl:with-param>
								<xsl:with-param name="id">payment_charges_amount</xsl:with-param>
								<xsl:with-param name="type">amount</xsl:with-param>
								<xsl:with-param name="override-displaymode">edit</xsl:with-param>
								<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_LABEL_PERCENTAGE</xsl:with-param>
								<xsl:with-param name="id">payment_charges_percent</xsl:with-param>
								<xsl:with-param name="type">number</xsl:with-param>
								<xsl:with-param name="override-displaymode">edit</xsl:with-param>
								<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_GENERALDETAILS_COLL_TYPE_LABEL</xsl:with-param>
								<xsl:with-param name="id">payment_charge_type</xsl:with-param>
								<xsl:with-param name="override-displaymode">edit</xsl:with-param>
								<xsl:with-param name="swift-validate">N</xsl:with-param>
								<xsl:with-param name="required">N</xsl:with-param>
								<xsl:with-param name="size">35</xsl:with-param>
								<xsl:with-param name="maxsize">35</xsl:with-param>
								<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							</xsl:call-template>
						<div class="dijitDialogPaneActionBar">
						<xsl:call-template name="label-wrapper">
							<xsl:with-param name="content">
								<button type="button" dojoType="dijit.form.Button">
									<xsl:attribute name="onmouseup">dijit.byId('charge-dialog-template').hide();</xsl:attribute>
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
								</button>							
								<xsl:if test="$displaymode = 'edit'">
									<button dojoType="dijit.form.Button">
										<xsl:attribute name="onClick">dijit.byId('charge-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
									</button>
								</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
						</div>
					</div>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Charge declaration</xd:short>
		<xd:detail>
			This templates calls charge dialog declaration template and displays no Charges message if there is no charges in BPO or adds button to Add charges in BPO dialog.
 		</xd:detail>		
 	</xd:doc>
	<xsl:template name="charges-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="charge-dialog-declaration" />
		<!-- Dialog End -->
		<div id="charges-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_BPO_NO_CHARGES')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_BPO_ADD_CHARGES')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	
	<xd:doc>
		<xd:short>Build Charges Items</xd:short>
		<xd:detail>
			This templates displays header for diplaying charges in BPO in add,edit and view mode,also displayes header of the Charges payer and payee in charges table inside BPO.
 		</xd:detail>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">Overridden display mode.</xd:param>		
 	</xd:doc>
	<xsl:template name="build-charges-dojo-items">
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
		
		<div dojoType="misys.openaccount.widget.Charges" dialogId="charge-dialog-template">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_BPO_ADD_CHARGES')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_BPO_EDIT_CHARGES')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_BPO_VIEW_CHARGES')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_BPO_CHARGES_PAYER')" />,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_BPO_CHARGES_PAYEE')" />,
			</xsl:attribute>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
		</div>

	</xsl:template>
	
	
	<xd:doc>
		<xd:short>Bank Payment term declaration</xd:short>
		<xd:detail>
			This templates displays no Bank Payment term message if there is no value in BPO payement term dialog or adds button to add a Payment term in BPO.
 		</xd:detail>		
 </xd:doc>
	<xsl:template name="bpo-payment-terms-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="bpo-payment-terms-dialog-declaration" />
		<!-- Dialog End -->
		<div id="bpo-payment-terms-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_BPO_NO_PAYMENT_TERMS')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_BPO_ADD_PAYMENT_TERMS')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	<!-- Forward Dataset Report section -->
	<xd:doc>
		<xd:short>Charge dialog declaration</xd:short>
		<xd:detail>
			This templates adds attribute title and fills it with Confirmation ,It also calls input field template,currency field template,multichoice field template for Buyer bank BPO,Payment Amount,
			PO clause required and sets it parameters.
 		</xd:detail>	
 	</xd:doc>
	<xsl:template name="forward-dataset-goods-details-dialog-declaration">
		<div id="forward-dataset-goods-details-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
			<div id="forward-dataset-goods-details-dialog-template-content" class="standardPODialogContent">
			<div>
				<xsl:call-template name="input-field">
	      			 <xsl:with-param name="label">XSL_LABEL_BUYER_BANK_BPO</xsl:with-param>
	  	  			 <xsl:with-param name="name">po_reference_id</xsl:with-param>
	  	  			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
	     		 </xsl:call-template>
	     		 <xsl:call-template name="input-field">
	      			 <xsl:with-param name="label">XSL_LABEL_BUYER_BANK_BPO</xsl:with-param>
	  	  			 <xsl:with-param name="name">po_reference_issue_date</xsl:with-param>
	  	  			 <xsl:with-param name="type">date</xsl:with-param>
	  	  			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
	     		 </xsl:call-template>
	     		 <xsl:call-template name="multichoice-field">
	     			 <xsl:with-param name="type">checkbox</xsl:with-param>
	      			 <xsl:with-param name="label">XSL_LABEL_BUYER_BANK_BPO</xsl:with-param>
	  	  			 <xsl:with-param name="name">final_submission</xsl:with-param>
	  	  			 <xsl:with-param name="override-displaymode">edit</xsl:with-param>
	  	  			 <xsl:with-param name="disabled">Y</xsl:with-param>
	     		 </xsl:call-template>
	     		 <xsl:call-template name="currency-field">
					<xsl:with-param name="label">XSL_DETAILS_PO_PAYMENT_AMT</xsl:with-param>
					<xsl:with-param name="override-currency-name">line_item_total_cur_code</xsl:with-param>
					<xsl:with-param name="override-amt-name">line_item_total_amount</xsl:with-param>
					<xsl:with-param name="show-button">N</xsl:with-param>
					<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
					<xsl:with-param name="currency-readonly">Y</xsl:with-param>
					<xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
					<xsl:with-param name="amt-readonly">Y</xsl:with-param>
					<xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="forward_dataset_submission/FwdDataSetSubmissnRpt/ComrclDataSet/Goods/ComrclLineItms/FrghtChrgs/Tp[.!='']">
					<xsl:variable name="code_type"><xsl:value-of select="forward_dataset_submission/FwdDataSetSubmissnRpt/ComrclDataSet/Goods/ComrclLineItms/FrghtChrgs/Tp"></xsl:value-of></xsl:variable>
					<xsl:variable name="parameterId">C033</xsl:variable>
						<xsl:call-template name="input-field">
						 	<xsl:with-param name="label">XSL_DETAILS_PO_CLAUSES_REQUIRED</xsl:with-param>
						 	<xsl:with-param name="name">goods_freight_charge_type</xsl:with-param>
						 	<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*','*',$parameterId, $code_type)"/></xsl:with-param>
						 	<xsl:with-param name="override-displaymode">view</xsl:with-param>	
						</xsl:call-template>
				</xsl:if>
				<xsl:call-template name="currency-field">
					<xsl:with-param name="label">XSL_DETAILS_PO_PAYMENT_AMT</xsl:with-param>
					<xsl:with-param name="override-currency-name">line_item_total_cur_code</xsl:with-param>
					<xsl:with-param name="override-amt-name">goods_total_net_amount</xsl:with-param>
					<xsl:with-param name="show-button">N</xsl:with-param>
					<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
					<xsl:with-param name="currency-readonly">Y</xsl:with-param>
					<xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
					<xsl:with-param name="amt-readonly">Y</xsl:with-param>
					<xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="forward_dataset_submission/FwdDataSetSubmissnRpt/ComrclDataSet/Goods/ComrclLineItms/Incotrms/IncotrmsCd/Cd[.!='']">
					<xsl:variable name="code_type"><xsl:value-of select="forward_dataset_submission/FwdDataSetSubmissnRpt/ComrclDataSet/Goods/ComrclLineItms/Incotrms/IncotrmsCd/Cd"></xsl:value-of></xsl:variable>
					<xsl:variable name="parameterId">C034</xsl:variable>
						<xsl:call-template name="input-field">
						 	<xsl:with-param name="label">XSL_DETAILS_PO_CLAUSES_REQUIRED</xsl:with-param>
						 	<xsl:with-param name="name">goods_freight_charge_type</xsl:with-param>
						 	<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*','*',$parameterId, $code_type)"/></xsl:with-param>
						 	<xsl:with-param name="override-displaymode">view</xsl:with-param>	
						</xsl:call-template>
				</xsl:if>
	     		 <xsl:call-template name="input-field">
	      			 <xsl:with-param name="label">XSL_LABEL_BUYER_BANK_BPO</xsl:with-param>
	  	  			 <xsl:with-param name="name">goods_incoterms_proprietary_id</xsl:with-param>
	  	  			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
	     		 </xsl:call-template>
	     		 <xsl:call-template name="input-field">
	      			 <xsl:with-param name="label">XSL_LABEL_BUYER_BANK_BPO</xsl:with-param>
	  	  			 <xsl:with-param name="name">goods_incoterms_scheme_name</xsl:with-param>
	  	  			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
	     		 </xsl:call-template>
	     		 <xsl:call-template name="input-field">
	      			 <xsl:with-param name="label">XSL_LABEL_BUYER_BANK_BPO</xsl:with-param>
	  	  			 <xsl:with-param name="name">goods_incoterms_issuer</xsl:with-param>
	  	  			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
	     		 </xsl:call-template>
	     		 
	     		 <xsl:call-template name="input-field">
	      			 <xsl:with-param name="label">XSL_LABEL_BUYER_BANK_BPO</xsl:with-param>
	  	  			 <xsl:with-param name="name">goods_incoterm_location</xsl:with-param>
	  	  			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
	     		 </xsl:call-template>
	     		 
	     	</div>
	     	</div>
	    </div>
	</xsl:template>
	
	
	<xd:doc>
		<xd:short>Build Forward dataset good details</xd:short>
		<xd:detail>
			This templates displays header for diplaying dataset in add,edit and view mode,also displayes header of the Obligater bank and recipient bank BIC in the table.
			It also defines variables and adds attributes of different fields in forward dataset dialod and fills it with given selected value.
 		</xd:detail>
 		<xd:param name="items"> ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">Overridden display mode.</xd:param>		
 	</xd:doc>
	<xsl:template name="build-forward-dataset-goods-details-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
		<div dojoType="misys.openaccount.widget.ForwardDataSetGoods" dialogId="forward-dataset-goods-details-dialog-template" id="forward-dataset-goods">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ADD_BPO_DATASET')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_EDIT_BPO_DATASET')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_VIEW_BPO_DATASET')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of
						select="localization:getGTPString($language, 'XSL_HEADER_PURCHASE_ORDER_OBLIGOR_BANK_BIC')" />,
				<xsl:value-of
						select="localization:getGTPString($language, 'XSL_HEADER_PURCHASE_ORDER_RECIPIENT_BANK_BIC')" />,
			</xsl:attribute>
			<xsl:for-each select="$items">
				<xsl:variable name="forwardDatasetGood" select="." />
				<div dojoType="misys.openaccount.widget.ForwardDataSetGood">
				<xsl:attribute name="po_reference_id"><xsl:value-of
						select="$forwardDatasetGood/FwdDataSetSubmissnRpt/ComrclDataSet/Goods/PurchsOrdrRef/Id" /></xsl:attribute>
				<xsl:attribute name="po_reference_issue_date"><xsl:value-of
						select="$forwardDatasetGood/FwdDataSetSubmissnRpt/ComrclDataSet/Goods/PurchsOrdrRef/DtOfIsse" /></xsl:attribute>
				<xsl:attribute name="final_submission"><xsl:value-of
						select="$forwardDatasetGood/FwdDataSetSubmissnRpt/ComrclDataSet/Goods/FnlSubmissn" /></xsl:attribute>
				<xsl:attribute name="line_item_total_amount"><xsl:value-of
						select="$forwardDatasetGood/FwdDataSetSubmissnRpt/ComrclDataSet/Goods/LineItmsTtlAmt" /></xsl:attribute>
				<xsl:attribute name="goods_freight_charge_type"><xsl:value-of
						select="$forwardDatasetGood/FwdDataSetSubmissnRpt/ComrclDataSet/Goods/ComrclLineItms/FrghtChrgs/Tp" /></xsl:attribute>
				<xsl:attribute name="goods_total_net_amount"><xsl:value-of 
						select="$forwardDatasetGood/FwdDataSetSubmissnRpt/ComrclDataSet/Goods/TtlNetAmt"/></xsl:attribute>
				<xsl:attribute name="goods_incoterms_code"><xsl:value-of
						select="$forwardDatasetGood/FwdDataSetSubmissnRpt/ComrclDataSet/Goods/Incotrms/IncotrmsCd/Cd" /></xsl:attribute>
				<xsl:attribute name="goods_incoterms_proprietary_id"><xsl:value-of
						select="$forwardDatasetGood/FwdDataSetSubmissnRpt/ComrclDataSet/Goods/Incotrms/IncotrmsCd/Prtry/Id" /></xsl:attribute>
				<xsl:attribute name="goods_incoterms_scheme_name"><xsl:value-of
						select="$forwardDatasetGood/FwdDataSetSubmissnRpt/ComrclDataSet/Goods/Incotrms/IncotrmsCd/Prtry/SchmeNm" /></xsl:attribute>
				<xsl:attribute name="goods_incoterms_issuer"><xsl:value-of
						select="$forwardDatasetGood/FwdDataSetSubmissnRpt/ComrclDataSet/Goods/Incotrms/IncotrmsCd/Prtry/Issr" /></xsl:attribute>
				<xsl:attribute name="goods_incoterm_location"><xsl:value-of
						select="$forwardDatasetGood/FwdDataSetSubmissnRpt/ComrclDataSet/Goods/Incotrms/Lctn" /></xsl:attribute>
				
				<xsl:if test="$forwardDatasetGood/FwdDataSetSubmissnRpt/ComrclDataSet/Goods/ComrclLineItms[.!='']">
					<div dojoType="misys.openaccount.widget.CommercialLineItems">
						<xsl:apply-templates select="ComrclLineItms"/>
					</div>
				</xsl:if>
				<xsl:if test="$forwardDatasetGood/FwdDataSetSubmissnRpt/ComrclDataSet/Goods/Adjstmnt[.!='']">
					<div dojoType="misys.openaccount.widget.GoodsAdjustments">
						<xsl:apply-templates select="Adjstmnt"/>
					</div>
				</xsl:if>
				<xsl:if test="$forwardDatasetGood/FwdDataSetSubmissnRpt/ComrclDataSet/Goods/FrghtChrgs[.!='']">
					<div dojoType="misys.openaccount.widget.GoodsFreightCharges">
						<xsl:apply-templates select="FrghtChrgs"/>
					</div>
				</xsl:if>
				<xsl:if test="$forwardDatasetGood/FwdDataSetSubmissnRpt/ComrclDataSet/Goods/Tax[.!='']">
					<div dojoType="misys.openaccount.widget.GoodsTaxes">
						<xsl:apply-templates select="Tax"/>
					</div>
				</xsl:if>
				<xsl:if test="$forwardDatasetGood/FwdDataSetSubmissnRpt/ComrclDataSet/Goods/BuyrDfndInf[.!='']">
					<div dojoType="misys.openaccount.widget.BuyerDefinedInfo">
						<xsl:apply-templates select="BuyrDfndInf"/>
					</div>
				</xsl:if>
				<xsl:if test="$forwardDatasetGood/FwdDataSetSubmissnRpt/ComrclDataSet/Goods/SellrDfndInf[.!='']">
					<div dojoType="misys.openaccount.widget.SellerDefinedInfo">
						<xsl:apply-templates select="SellrDfndInf"/>
					</div>
				</xsl:if>
				</div>
			</xsl:for-each>
		</div>
	</xsl:template>
	
	<!-- BPO : ForwardDatasetReport dataset sections templates :: start -->
	<xd:doc>
		<xd:short>BPO Insurance dataset details</xd:short>
		<xd:detail>
			This templates sets parameter of the different field in BPO Insurance dataset. 
 		</xd:detail>
 		<xd:param name="node">Provides the path</xd:param>	
 	</xd:doc>
	<xsl:template name="bpo-insurance-dataset-deatils">
		<xsl:param name="node"/>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_INSURANCE_DATASET_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_ISSUER_NAME</xsl:with-param>
					<xsl:with-param name="name">ins_issuer_name</xsl:with-param>
					<xsl:with-param name="maxsize">70</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of
						select="$node/Issr/Nm" /></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
					<xsl:with-param name="name">ins_issue_date</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of
						select="$node/IsseDt" /></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_INSURANCE_DOC_ID</xsl:with-param>
					<xsl:with-param name="name">ins_doc_id</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of
						select="$node/InsrncDocId" /></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_INSURED_AMOUNT</xsl:with-param>
					<xsl:with-param name="name">ins_amt</xsl:with-param>
					<xsl:with-param name="type">amount</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of
						select="$node/InsrdAmt" /></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_INSURANCE_GOODS_DESC</xsl:with-param>
					<xsl:with-param name="name">ins_goods</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of
						select="$node/InsrdGoodsDesc" /></xsl:with-param>
				</xsl:call-template>
				<xsl:variable name="insuranceClauseCode"><xsl:value-of
						select="$node/InsrncClauses" /></xsl:variable>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_INSURANCE_CLAUSES</xsl:with-param>
					<xsl:with-param name="name">ins_clause</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*','*','C022', $insuranceClauseCode)"/></xsl:with-param>
				</xsl:call-template>
				<xsl:if test="$node/ClmsPyblIn !=''">
				<xsl:call-template name="currency-field">
					<xsl:with-param name="label">XSL_INSURANCE_PAYABLE_IN</xsl:with-param>
					<xsl:with-param name="name">ins_payable_curr</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of 
						select="$node/ClmsPyblIn"/></xsl:with-param>
				</xsl:call-template>
				</xsl:if>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xd:doc>
		<xd:short>BPO Certificate dataset details</xd:short>
		<xd:detail>
			This templates sets parameter of the different field in BPO certificate dataset. 
 		</xd:detail>
 		<xd:param name="node">Provides the path</xd:param>		
 	</xd:doc>
	<xsl:template name="bpo-certificate-dataset-deatils">
		<xsl:param name="node"/>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_CERTIFICATE_DATASET_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:variable name="certificateTypeCode"><xsl:value-of
						select="$node/CertTp" /></xsl:variable>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_CERIFICATE_TYPE</xsl:with-param>
					<xsl:with-param name="name">certificate_type</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*','*','C021', $certificateTypeCode)"/></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
					<xsl:with-param name="name">certificate_issue_date</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of
						select="$node/IsseDt" /></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_ISSUER_NAME</xsl:with-param>
					<xsl:with-param name="name">certificate_issuer</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of
						select="$node/Issr/Nm" /></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_CERTIFICATE_ID</xsl:with-param>
					<xsl:with-param name="name">certificate_id</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of
						select="$node/CertId" /></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_INSURANCE_GOODS_DESC</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of
						select="$node/GoodsDesc" /></xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xd:doc>
		<xd:short>BPO Other Certificate dataset details</xd:short>
		<xd:detail>
			This templates sets parameter of the different field in BPO Other certificate dataset. 
 		</xd:detail>
 		<xd:param name="node">Provides the path</xd:param>		
 	</xd:doc>
	<xsl:template name="bpo-other-certificate-dataset-deatils">
		<xsl:param name="node"/>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_OTHER_CERTIFICATE_DATASET_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:variable name="otherCertificateTypeCode"><xsl:value-of
						select="$node/CertTp" /></xsl:variable>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_OTHER_CERIFICATE_TYPE</xsl:with-param>
					<xsl:with-param name="name">other_certificate_type</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*','*','C024', $otherCertificateTypeCode)"/></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
					<xsl:with-param name="name">other_certificate_issue_date</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of
						select="$node/IsseDt" /></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_ISSUER_NAME</xsl:with-param>
					<xsl:with-param name="name">other_certificate_issuer</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of
						select="$node/Issr/Nm" /></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_CERTIFICATE_INFO</xsl:with-param>
					<xsl:with-param name="name">other_certificate_info</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of
						select="$node/CertInf" /></xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	
	<xd:doc>
		<xd:short>Delta report details</xd:short>
		<xd:detail>
			This templates sets parameter of the different field in Delta report. 
 		</xd:detail>		
 	</xd:doc>
	<xsl:template name="delta-report-details">
		<xsl:param name="node"/>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_DELTA_REPORT_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:for-each select="$node/UpdtdElmt">
					<xsl:variable name="updatedElement" select="." />
					<xsl:variable name="index"><xsl:value-of select="$updatedElement/ElmtSeqNb"/></xsl:variable>
					<xsl:call-template name="fieldset-wrapper">
					    <xsl:with-param name="legend">XSL_HEADER_UPDATED_ELEMENT</xsl:with-param>
					    <xsl:with-param name="legend-type">indented-header</xsl:with-param>
					    <xsl:with-param name="content">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_ELEMENT_NAME</xsl:with-param>
								<xsl:with-param name="name">element_name<xsl:value-of 
									select="$index"/></xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of 
									select="$updatedElement/ElmtNm"/></xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_CURRENT_VALUE</xsl:with-param>
								<xsl:with-param name="name">current_value<xsl:value-of 
									select="$index"/></xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of
									select="$updatedElement/Rplcmnt/CurVal" /></xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PROPOSED_VALUE</xsl:with-param>
								<xsl:with-param name="name">proposed_value<xsl:value-of 
									select="$index"/></xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of
									select="$updatedElement/Rplcmnt/PropsdVal" /></xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:for-each>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	 	<xd:doc>
		<xd:short>Data Mismatch Info</xd:short>
		<xd:detail>
			This templates sets parameter for dataset match details and get the content of mismatches,else if no mismatches,display the message 
 		</xd:detail>
 		<xd:param name="items"> Items to be build to form display</xd:param>
 		</xd:doc>	    <xsl:template name="dataset-mismatch-info">
			<xsl:param name="items"/>
			<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="legend">XSL_HEADER_DATASET_MATCH_REPORT_DETAILS</xsl:with-param>
				<xsl:with-param name="content">
				<xsl:choose>
					<xsl:when test="$items != ''">
								<div id="dataset-mismatch-template">
									<div class="clear multigrid">
										<div style="width:100%;height:100%;" class="widgetContainer clear">
											<table border="0" cellpadding="0" cellspacing="0" class="attachments">
							    				 <xsl:attribute name="id">dataset_table</xsl:attribute>
								   			     <thead>
								    			   <tr>
												       <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_MISMATCH_SEQ_NO_HEADER')"/></th>
												       <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_MISMATCH_CONTEXT')"/></th>
												       <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_ELEMENT_NAME')"/></th>
												       <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_SUBMITTED_VALUE')"/></th>
											       </tr>
									   		      
									      </thead>
								<tbody>
							      	<xsl:call-template name="datasetmismatches">
								      	<xsl:with-param name="outerLimit"><xsl:value-of select="count($items/MisMtchInf)"/></xsl:with-param>
								      	<xsl:with-param name="items" select ="$items"></xsl:with-param>
							      	</xsl:call-template>
							      </tbody>
									 </table>
									 <div class="clear" style="height:1px">&nbsp;</div>
								 </div>
							 </div>
					</div>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NO_MISMATCHES')" />
					</xsl:otherwise>
				</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:template>
		
		
			
	<xsl:template name="datasetmismatches">
	<xsl:param name="outerCounter">1</xsl:param>
	<xsl:param name="items"/>
	<xsl:param name="outerLimit"/>
	<xsl:param name="innerLimit"><xsl:value-of select="count($items/MisMtchInf[number($outerCounter)]/MisMtchdElmt)"></xsl:value-of></xsl:param>
	<xsl:param name="innerCounter">1</xsl:param>
	<tr>
		<td><xsl:attribute name="rowspan"><xsl:value-of select="$innerLimit"/></xsl:attribute> 
			<xsl:value-of select="$items/MisMtchInf[number($outerCounter)]/SeqNb"/></td>
		<td><xsl:attribute name="rowspan"><xsl:value-of select="$innerLimit"/></xsl:attribute>
			<xsl:value-of select="$items/MisMtchInf[number($outerCounter)]/RuleDesc"/></td>
		<td><xsl:value-of select="$items/MisMtchInf[number($outerCounter)]/MisMtchdElmt[number($innerCounter)]/ElmtPth"/><xsl:value-of select="$items/MisMtchInf[number($outerCounter)]/MisMtchdElmt[number($innerCounter)]/ElmtNm"/></td>
		<td><xsl:value-of select="$items/MisMtchInf[number($outerCounter)]/MisMtchdElmt[number($innerCounter)]/ElmtVal"/></td>
	</tr>
	
	<xsl:call-template name="datasetmismatch-element">
		<xsl:with-param name="innerCounter"><xsl:value-of select="number($innerCounter)+1"/></xsl:with-param>
		<xsl:with-param name="items" select="$items/MisMtchInf[number($outerCounter)]"/>
		<xsl:with-param name="innerLimit" select="$innerLimit"/>
	</xsl:call-template>
		
	<xsl:if test="number($outerCounter)+1 &lt;= number($outerLimit)">
		<xsl:call-template name="datasetmismatches">
			<xsl:with-param name="outerCounter"><xsl:value-of select="number($outerCounter)+1"/></xsl:with-param>
			<xsl:with-param name="items" select="$items"/>
			<xsl:with-param name="outerLimit" select="$outerLimit"/>
		</xsl:call-template>
	</xsl:if>
	</xsl:template>
	
	<xsl:template name= "datasetmismatch-element">
	<xsl:param name="innerCounter"/>
	<xsl:param name="items"/>
	<xsl:param name="innerLimit"/>
	<tr>
		<td><xsl:value-of select="$items/MisMtchdElmt[number($innerCounter)]/ElmtPth"/><xsl:value-of select="$items/MisMtchdElmt[number($innerCounter)]/ElmtNm"/></td>
		<td><xsl:value-of select="$items/MisMtchdElmt[number($innerCounter)]/ElmtVal"/></td>
	</tr>
	<xsl:if test="number($innerCounter)+1 &lt;= number($innerLimit)">
		<xsl:call-template name="datasetmismatch-element">
			<xsl:with-param name="innerCounter"><xsl:value-of select="number($innerCounter)+1"/></xsl:with-param>
			<xsl:with-param name="items" select="$items"/>
			<xsl:with-param name="innerLimit" select="$innerLimit"/>
		</xsl:call-template>
	</xsl:if>
	</xsl:template>
		
		
	<!-- *************************************************************** -->
						<!-- Routing summaries -->
	<!-- *************************************************************** -->
	
	<xd:doc>
		<xd:short>Routing Summary</xd:short>
		<xd:detail>
			This templates calls two templates,routing summary individual and multimodal and sets its parameters
 		</xd:detail>	
 		<xd:param name="prefix">An identifier for the field.</xd:param>
 		<xd:param name="toc-item">A Flag that indicates whether the header section label to be added as a tic-toc content on the floating navigation widget. </xd:param>
 	</xd:doc>
	<xsl:template name="routing-summary">
		<xsl:param name="prefix"/>
		<xsl:param name="toc-item" />
		<xsl:call-template name="routing-summary-individual">
			<xsl:with-param name="prefix"><xsl:value-of select="$prefix" /></xsl:with-param>
			<xsl:with-param name="toc-item" select="$toc-item"/>
			<xsl:with-param name="label">
				<xsl:choose>
					<xsl:when test="product_code [.='EA'] and prod_stat_code[.='A6']">XSL_HEADER_PMT_TDS_ROUTING_SUMMARY_IND_DETAILS</xsl:when>
					<xsl:otherwise>XSL_HEADER_ROUTING_SUMMARY_IND_DETAILS</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="routing-summary-multimodal">
			<xsl:with-param name="prefix"><xsl:value-of select="$prefix" /></xsl:with-param>
			<xsl:with-param name="toc-item" select="$toc-item"/>
			<xsl:with-param name="label">
				<xsl:choose>
					<xsl:when test="product_code [.='EA'] and prod_stat_code[.='A6']">XSL_HEADER_PMT_TDS_ROUTING_SUMMARY_MULTIMODAL_DETAILS</xsl:when>
					<xsl:otherwise>XSL_HEADER_ROUTING_SUMMARY_MULTIMODAL_DETAILS</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
		
	</xsl:template>
	
	<!-- Routing summary Fieldset. -->
	<xd:doc>
		<xd:short>Routing Summary Individual</xd:short>
		<xd:detail>
			This templates sets parameter for Routing summary individual details and gets the content from template individual routing summary div
 		</xd:detail>	
 		<xd:param name="prefix">A part of identifier for the field.</xd:param>
 		<xd:param name="toc-item">A Flag that indicates whether the header section label to be added as a tic-toc content on the floating navigation widget. </xd:param>
 	</xd:doc>
	<xsl:template name="routing-summary-individual">
		<xsl:param name="prefix"/>
		<xsl:param name="toc-item" />
		<xsl:param name="label">XSL_HEADER_ROUTING_SUMMARY_IND_DETAILS</xsl:param>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend" select="$label"/>
			<xsl:with-param name="toc-item" select="$toc-item"/>
			<xsl:with-param name="content">
				<xsl:call-template name="individual-routing-summary-div">
					<xsl:with-param name="prefix"><xsl:value-of select="$prefix" /></xsl:with-param>
					<xsl:with-param name="isWidgetContainer">N</xsl:with-param>
					<xsl:with-param name="hidden">N</xsl:with-param>
					<xsl:with-param name="toc-item" select="$toc-item" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Routing Summary Multimodal</xd:short>
		<xd:detail>
			This templates sets parameter for Routing summary multimodal details,calls input-field template for taking in charge and place of final destination and sets different parameters
			such as name,label,value etc
 		</xd:detail>	
 		<xd:param name="prefix">A part of identifier for the field.</xd:param>
 		<xd:param name="toc-item">A Flag that indicates whether the header section label to be added as a tic-toc content on the floating navigation widget. </xd:param>
 	</xd:doc>
	<xsl:template name="routing-summary-multimodal">
		<xsl:param name="prefix"/>
		<xsl:param name="toc-item" />
		<xsl:param name="label">XSL_HEADER_ROUTING_SUMMARY_MULTIMODAL_DETAILS</xsl:param>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend" select="$label"/>
			<xsl:with-param name="toc-item" select="$toc-item"/>
			<xsl:with-param name="content">
				<xsl:choose>
					<xsl:when test="$prefix !=''">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_TAKING_IN_CHARGE</xsl:with-param>
							<xsl:with-param name="name"><xsl:value-of select="$prefix"/>taking_in_charge</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="line_items/lt_tnx_record/routing_summaries/rs_tnx_record/taking_in_charge" />
							</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_TAKING_IN_CHARGE</xsl:with-param>
							<xsl:with-param name="name"><xsl:value-of select="$prefix"/>taking_in_charge</xsl:with-param>
							<xsl:with-param name="value">
								<xsl:value-of select="routing_summaries/rs_tnx_record/taking_in_charge" />	
							</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
				
				<xsl:choose>
					<xsl:when test="$prefix !=''">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PLACE_OF_FINAL_DEST</xsl:with-param>
							<xsl:with-param name="name"><xsl:value-of select="$prefix"/>final_dest_place</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="line_items/lt_tnx_record/routing_summaries/rs_tnx_record/place_of_final_destination" />
							</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PLACE_OF_FINAL_DEST</xsl:with-param>
							<xsl:with-param name="name"><xsl:value-of select="$prefix"/>final_dest_place</xsl:with-param>
							<xsl:with-param name="value">
								<xsl:value-of select="routing_summaries/rs_tnx_record/place_of_final_destination" />	
							</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	
	<xd:doc>
		<xd:short>Individual Routing summary declaration</xd:short>
		<xd:detail>
			This templates calls different templates and sets parameters of these templates
 		</xd:detail>	
 	</xd:doc>
	<xsl:template name="individual-routing-summary-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="individual-routing-summary-dialog-declaration"/>
		<!-- Dialog End -->
		<!-- Air  -->
		<xsl:call-template name="individual-routing-summary-generic-declaration">
			<xsl:with-param name="label-add-button">XSL_DETAILS_PO_ADD_ROUTING_SUMMARY_TRANSPORT_MODE_AIR</xsl:with-param>
			<xsl:with-param name="label-no-item">XSL_DETAILS_PO_NO_ROUTING_SUMMARY_TRANSPORT_MODE_AIR</xsl:with-param>
			<xsl:with-param name="div-id">routing-summary-air-template</xsl:with-param>
		</xsl:call-template>
		<!-- Sea  -->
		<xsl:call-template name="individual-routing-summary-generic-declaration">
			<xsl:with-param name="label-add-button">XSL_DETAILS_PO_ADD_ROUTING_SUMMARY_TRANSPORT_MODE_SEA</xsl:with-param>
			<xsl:with-param name="label-no-item">XSL_DETAILS_PO_NO_ROUTING_SUMMARY_TRANSPORT_MODE_SEA</xsl:with-param>
			<xsl:with-param name="div-id">routing-summary-sea-template</xsl:with-param>
		</xsl:call-template>
		<!-- Road  -->
		<xsl:call-template name="individual-routing-summary-generic-declaration">
			<xsl:with-param name="label-add-button">XSL_DETAILS_PO_ADD_ROUTING_SUMMARY_TRANSPORT_MODE_ROAD</xsl:with-param>
			<xsl:with-param name="label-no-item">XSL_DETAILS_PO_NO_ROUTING_SUMMARY_TRANSPORT_MODE_ROAD</xsl:with-param>
			<xsl:with-param name="div-id">routing-summary-road-template</xsl:with-param>
		</xsl:call-template>
		<!-- Rail  -->
		<xsl:call-template name="individual-routing-summary-generic-declaration">
			<xsl:with-param name="label-add-button">XSL_DETAILS_PO_ADD_ROUTING_SUMMARY_TRANSPORT_MODE_RAIL</xsl:with-param>
			<xsl:with-param name="label-no-item">XSL_DETAILS_PO_NO_ROUTING_SUMMARY_TRANSPORT_MODE_RAIL</xsl:with-param>
			<xsl:with-param name="div-id">routing-summary-rail-template</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Individual Routing summary generic declaration</xd:short>
		<xd:detail>
			This templates displayes No label message if there is no item added or add button to add any item in routing summary.
 		</xd:detail>
 		<xd:param name="label-add-button">label to add diffent button</xd:param>
 		<xd:param name="label-no-item">label when no item is present</xd:param>
 		<xd:param name="div id">id of specific grid on browser</xd:param>	
 	</xd:doc>
	<xsl:template name="individual-routing-summary-generic-declaration">
	<xsl:param name="label-add-button"></xsl:param>
	<xsl:param name="label-no-item"></xsl:param>
	<xsl:param name="div-id"></xsl:param>
	
		<div style="display:none">
		<xsl:attribute name="id"><xsl:value-of select="$div-id"/></xsl:attribute>
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of select="localization:getGTPString($language, $label-no-item)" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem" dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, $label-add-button)" />
				</button>
			</div>
		</div>
	</xsl:template>	
	
	<!-- Template for the declaration of routing summary -->
	<xd:doc>
		<xd:short>Individual Routing summary dialog declaration</xd:short>
		<xd:detail>
			This templates calls different template of individual routing summary of different modes.
 		</xd:detail>
 		<xd:param name="toc-item">A Flag that indicates whether the header section label to be added as a tic-toc content on the floating navigation widget. </xd:param>
 	</xd:doc>
	<xsl:template name="individual-routing-summary-dialog-declaration">
		<xsl:param name="toc-item">N</xsl:param>
		<xsl:call-template name="individual-routing-summary-air-dialog-declaration">
			<xsl:with-param name="toc-item" select="$toc-item" />
		</xsl:call-template>
		<xsl:call-template name="individual-routing-summary-sea-dialog-declaration">
			<xsl:with-param name="toc-item" select="$toc-item" />
		</xsl:call-template>
		<xsl:call-template name="individual-routing-summary-rail-dialog-declaration">
			<xsl:with-param name="toc-item" select="$toc-item" />
		</xsl:call-template>
		<xsl:call-template name="individual-routing-summary-road-dialog-declaration">
			<xsl:with-param name="toc-item" select="$toc-item" />
		</xsl:call-template>
	</xsl:template>
	<xd:doc>
		<xd:short>Individual routing summary</xd:short>
		<xd:detail>
			This templates adds different attribute and fill it with value from given field.It also sets the value of parameters of different templates called under this. 
 		</xd:detail>
 		<xd:param name="hidden">hidden field in routing summary</xd:param>
 		<xd:param name="prefix">Forms an id of the field when this is included</xd:param>
 		<xd:param name="no-items">Value from this is filled when an in no-item attribute</xd:param>
 		<xd:param name="isWidgetContainer">adds class attributes and fill it with WidgetContainer if its value is set to Y</xd:param>
 	</xd:doc>
	<xsl:template name="individual-routing-summary-div">
	<xsl:param name="hidden">Y</xsl:param>
	<xsl:param name="prefix"></xsl:param>
	<xsl:param name="no-items">N</xsl:param>
	<xsl:param name="isWidgetContainer">Y</xsl:param>
	<xsl:param name="toc-item">Y</xsl:param>
	
	<xsl:variable name="airVarItems" select="routing_summaries/air_routing_summaries/rs_tnx_record"></xsl:variable>
	<xsl:variable name="seaVarItems" select="routing_summaries/sea_routing_summaries/rs_tnx_record"></xsl:variable>
	<xsl:variable name="roadVarItems" select="routing_summaries/road_routing_summaries/rs_tnx_record"></xsl:variable>
	<xsl:variable name="railVarItems" select="routing_summaries/rail_routing_summaries/rs_tnx_record"></xsl:variable>
	
	<div>
		<xsl:if test="$isWidgetContainer='Y'">
				<xsl:attribute name="class">widgetContainer</xsl:attribute>
		</xsl:if>
		<xsl:if test="$hidden='Y'">
				<xsl:attribute name="style">display:none</xsl:attribute>
		</xsl:if>
		<xsl:attribute name="id"><xsl:value-of select ="$prefix"/>individual-routing-summary-div</xsl:attribute>
		<!-- Air widget -->
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_AIR</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="toc-item" select="$toc-item" />
			<xsl:with-param name="content">
			<!-- magical nbsp without it this widget is not parse!  -->
			<div>&nbsp;</div>
				<xsl:call-template name="build-individual-routing-summary-dojo-items">
						<xsl:with-param name="items" select="$airVarItems"/>
						<xsl:with-param name="items-filter">01</xsl:with-param>
						<xsl:with-param name="type-filter">01</xsl:with-param>
						<xsl:with-param name="no-items"><xsl:value-of select ="$no-items"/></xsl:with-param>
						<xsl:with-param name="id"><xsl:value-of select ="$prefix"/>air_routing_summaries</xsl:with-param>
						<xsl:with-param name="widget">misys.openaccount.widget.AirRoutingSummaries</xsl:with-param>
				</xsl:call-template> 
			</xsl:with-param>
		</xsl:call-template>
				
		<!-- Sea widget -->
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_SEA</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="toc-item" select="$toc-item" />
			<xsl:with-param name="content">
			<!-- magical nbsp without it this widget is not parse!  -->
			<div>&nbsp;</div>
			<xsl:call-template name="build-individual-routing-summary-dojo-items">
					<xsl:with-param name="items" select="$seaVarItems"/>
					<xsl:with-param name="items-filter">02</xsl:with-param>
					<xsl:with-param name="no-items"><xsl:value-of select ="$no-items"/></xsl:with-param>
					<xsl:with-param name="type-filter">01</xsl:with-param>
					<xsl:with-param name="id"><xsl:value-of select ="$prefix"/>sea_routing_summaries</xsl:with-param>
					<xsl:with-param name="widget">misys.openaccount.widget.SeaRoutingSummaries</xsl:with-param>
			</xsl:call-template> 
			</xsl:with-param>
		</xsl:call-template>
		
		<!-- Road widget -->
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_ROAD</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="toc-item" select="$toc-item" />
			<xsl:with-param name="content">
			<!-- magical nbsp without it this widget is not parse!  -->
			<div>&nbsp;</div>
			<xsl:call-template name="build-individual-routing-summary-dojo-items">
					<xsl:with-param name="items" select="$roadVarItems"/>
					<xsl:with-param name="items-filter">03</xsl:with-param>
					<xsl:with-param name="no-items"><xsl:value-of select ="$no-items"/></xsl:with-param>
					<xsl:with-param name="type-filter">01</xsl:with-param>
					<xsl:with-param name="id"><xsl:value-of select ="$prefix"/>road_routing_summaries</xsl:with-param>
					<xsl:with-param name="widget">misys.openaccount.widget.RoadRoutingSummaries</xsl:with-param>
			</xsl:call-template> 
			</xsl:with-param>
		</xsl:call-template>
		
		<!-- Rail widget -->
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_RAIL</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="toc-item" select="$toc-item" />
			<xsl:with-param name="content">
			<!-- magical nbsp without it this widget is not parse!  -->
			<div>&nbsp;</div>
			<xsl:call-template name="build-individual-routing-summary-dojo-items">
					<xsl:with-param name="items" select="$railVarItems"/>
					<xsl:with-param name="items-filter">04</xsl:with-param>
					<xsl:with-param name="no-items"><xsl:value-of select ="$no-items"/></xsl:with-param>
					<xsl:with-param name="type-filter">01</xsl:with-param>
					<xsl:with-param name="id"><xsl:value-of select ="$prefix"/>rail_routing_summaries</xsl:with-param>
					<xsl:with-param name="widget">misys.openaccount.widget.RailRoutingSummaries</xsl:with-param>
			</xsl:call-template> 
			</xsl:with-param>
		</xsl:call-template>
	</div>
	</xsl:template>

	<xd:doc>
		<xd:short>Individual routing summary</xd:short>
		<xd:detail>
			This templates adds attribute and fill it with value from the given selected field based on the condition(if some condition is present).It also sets the value of parameters of different templates called under this. 
 		</xd:detail>
 		<xd:param name="items"> Items to be build to form display</xd:param>
 		<xd:param name="items-filter"> Items to be filter based on mode</xd:param>
 		<xd:param name="type-filter">Types to be filter based on mode</xd:param>
 		<xd:param name="no-items">Value from this is filled when an in no-item attribute</xd:param>
 		<xd:param name="id">Id of the form field for submission</xd:param>
 		<xd:param name="widget">This is added in dojotype</xd:param>
 		<xd:param name="override-displaymode">display mode can be overriden</xd:param>
 	</xd:doc>
	<xsl:template name="build-individual-routing-summary-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="items-filter" /><!-- transport mode numbre or PLACE,FINALDEST,TAKINGIN -->
		<xsl:param name="type-filter" /><!-- transport mode numbre or PLACE,FINALDEST,TAKINGIN -->
		<xsl:param name="no-items">N</xsl:param>
		<xsl:param name="id" />
		<xsl:param name="widget"/>
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
		<div>
			<xsl:attribute name="dialogAddItemTitle">

				<!-- Dialog Header Selection for Transport Type - Individual -->
				<xsl:if test="contains($id,'air_routing_summaries')">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_ROUTING_SUMMARY_TRANSPORT_MODE_AIR')" />
				</xsl:if>
				<xsl:if test="contains($id,'sea_routing_summaries')">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_ROUTING_SUMMARY_TRANSPORT_MODE_SEA')" />
				</xsl:if>
				<xsl:if test="contains($id,'rail_routing_summaries')">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_ROUTING_SUMMARY_TRANSPORT_MODE_RAIL')" />
				</xsl:if>
				<xsl:if test="contains($id,'road_routing_summaries')">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_ROUTING_SUMMARY_TRANSPORT_MODE_ROAD')" />
				</xsl:if>
			</xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle">
				<!-- Upon Revisit/Update/Edit: Dialog Header Selection for Transport Type - Individual -->
				<xsl:if test="contains($id,'air_routing_summaries')">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_EDIT_ROUTING_SUMMARY_TRANSPORT_MODE_AIR')" />
				</xsl:if>
				<xsl:if test="contains($id,'sea_routing_summaries')">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_EDIT_ROUTING_SUMMARY_TRANSPORT_MODE_SEA')" />
				</xsl:if>
				<xsl:if test="contains($id,'rail_routing_summaries')">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_EDIT_ROUTING_SUMMARY_TRANSPORT_MODE_RAIL')" />
				</xsl:if>
				<xsl:if test="contains($id,'road_routing_summaries')">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_EDIT_ROUTING_SUMMARY_TRANSPORT_MODE_ROAD')" />
				</xsl:if>
			</xsl:attribute>
						
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dojoType"><xsl:value-of select="$widget" /></xsl:attribute>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
			<xsl:if test="$no-items='N'">			
			 <xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="routingSummary" select="." />
					<xsl:if test="($routingSummary/routing_summary_mode[.=$items-filter] and $routingSummary/routing_summary_type[.=$type-filter])">
						<div dojoType="misys.openaccount.widget.RoutingSummary">
							<xsl:attribute name="id"><xsl:value-of select="concat($id, '_', 'misys_openaccount_widget_RoutingSummary_', position())" /></xsl:attribute>
							<xsl:attribute name="ref_id"><xsl:value-of
								select="$routingSummary/ref_id" /></xsl:attribute>
							<xsl:attribute name="tnx_id"><xsl:value-of
								select="$routingSummary/tnx_id" /></xsl:attribute>
							<xsl:attribute name="routing_summary_mode"><xsl:value-of
								select="$routingSummary/routing_summary_mode" /></xsl:attribute>
							<xsl:attribute name="routing_summary_type"><xsl:value-of
								select="$routingSummary/routing_summary_type" /></xsl:attribute>
							<xsl:attribute name="linked_ref_id"><xsl:value-of
								select="$routingSummary/linked_ref_id" /></xsl:attribute>
							<xsl:attribute name="linked_tnx_id"><xsl:value-of
								select="$routingSummary/linked_tnx_id" /></xsl:attribute>
								<xsl:choose>
									<xsl:when test="$routingSummary/air_carrier_name != ''">
										<xsl:attribute name="air_carrier_name">
											<xsl:value-of select="$routingSummary/air_carrier_name" />
										</xsl:attribute>
									</xsl:when>
									<xsl:when test="$routingSummary/sea_carrier_name != ''">
										<xsl:attribute name="sea_carrier_name">
											<xsl:value-of select="$routingSummary/sea_carrier_name" />
										</xsl:attribute>
									</xsl:when>
									<xsl:when test="$routingSummary/road_carrier_name != ''">
										<xsl:attribute name="road_carrier_name">
											<xsl:value-of select="$routingSummary/road_carrier_name" />
										</xsl:attribute>
									</xsl:when>
									<xsl:when test="$routingSummary/rail_carrier_name != ''">
										<xsl:attribute name="rail_carrier_name">
											<xsl:value-of select="$routingSummary/rail_carrier_name" />
										</xsl:attribute>
									</xsl:when>
								</xsl:choose>
							<!-- Apply the templates for sub tags departures/departure : This will call the template defined to be called for a match of tag name departures -->
							<xsl:if test="$routingSummary/departures != ''">
								<xsl:apply-templates select="departures"/>
							</xsl:if>
							<xsl:if test="$routingSummary/destinations != ''">
								<xsl:apply-templates select="destinations"/>
							</xsl:if>
							<xsl:if test="$routingSummary/loading_ports != ''">
								<xsl:apply-templates select="loading_ports"/>
							</xsl:if>
							<xsl:if test="$routingSummary/discharge_ports != ''">
								<xsl:apply-templates select="discharge_ports"/>
							</xsl:if>
							<xsl:if test="$routingSummary/rail_receipt_places != ''">
								<xsl:apply-templates select="rail_receipt_places"/>
							</xsl:if>
							<xsl:if test="$routingSummary/rail_delivery_places != ''">
								<xsl:apply-templates select="rail_delivery_places"/>
							</xsl:if>
							<xsl:if test="$routingSummary/road_receipt_places != ''">
								<xsl:apply-templates select="road_receipt_places"/>
							</xsl:if>
							<xsl:if test="$routingSummary/road_delivery_places != ''">
								<xsl:apply-templates select="road_delivery_places"/>
							</xsl:if>
						</div>
					</xsl:if>
				</xsl:for-each>
			</xsl:if>
			</xsl:if>
		</div>
	</xsl:template>
	<!-- ****************************************** -->
			<!-- Routing summary by AIR -->
	<!-- ****************************************** -->
	<xd:doc>
		<xd:short>Individual Routing Summary air dialog declaration</xd:short>
		<xd:detail>
			This templates sets parameters of different template called in this,adds OK and CANCEL button in Transport by air dialog.
 		</xd:detail>
 		<xd:param name="toc-item">A Flag that indicates whether the header section label to be added as a tic-toc content on the floating navigation widget. </xd:param>
 	</xd:doc>
	<xsl:template name="individual-routing-summary-air-dialog-declaration">
		<xsl:param name="toc-item"/>
		<div id="routing-summary-air-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
				<div id="routing-summary-air-dialog-template-content" class="standardPODialogContent">
					<div>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">air_routing_summary_type</xsl:with-param>
							<xsl:with-param name="value">01</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">air_routing_summary_mode</xsl:with-param>
							<xsl:with-param name="value">01</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_CARRIER_NAME</xsl:with-param>
							<xsl:with-param name="name">air_carrier_name</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_HEADER_DEPARTURE</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="toc-item" select="$toc-item"/>
							<xsl:with-param name="content">
							&nbsp;
								<xsl:call-template name="build-transport-by-air-details-dojo-items">
									<xsl:with-param name="id">transport_by_air_departures</xsl:with-param>
									<xsl:with-param name="dialogTemplateId">transport-by-air-dept-details-dialog-template</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_HEADER_DESTINATION</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="toc-item" select="$toc-item"/>
							<xsl:with-param name="content">
							&nbsp;
								<xsl:call-template name="build-transport-by-air-details-dojo-items">
									<xsl:with-param name="id">transport_by_air_destinations</xsl:with-param>
									<xsl:with-param name="dialogTemplateId">transport-by-air-dest-details-dialog-template</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						
						<div class="dijitDialogPaneActionBar">
						<xsl:call-template name="label-wrapper">
							<xsl:with-param name="content">
								<button type="button" dojoType="dijit.form.Button">
									<xsl:attribute name="onmouseup">dijit.byId('routing-summary-air-dialog-template').hide();</xsl:attribute>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
								</button>
								<xsl:if test="$displaymode = 'edit'">
								<button dojoType="dijit.form.Button">
									<xsl:attribute name="onClick">dijit.byId('routing-summary-air-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
								</button>
								</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
						</div>
					</div>
				</div>
			</div>	
	</xsl:template>

	<!-- Transport By Air : Departure -->
	<xd:doc>
		<xd:short>Transport by air departure detail declaration</xd:short>
		<xd:detail>
			This templates displayes message if no transport by air departure details are there or add a button to add departure airport details
 		</xd:detail>	
 	</xd:doc>
	<xsl:template name="transport-by-air-dept-details-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="transport-by-air-details-dialog-declaration">
			<xsl:with-param name="dialogTemplateId">transport-by-air-dept-details-dialog-template</xsl:with-param>
			<xsl:with-param name="dialogtemplateContentId">transport-by-air-dept-details-dialog-template-content</xsl:with-param>
		</xsl:call-template>
		<!-- Dialog End -->
		<div id="transport-by-air-dept-details-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_NO_DEPT_AIRPORT_DET')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_ADD_DEPT_AIRPORT_DET')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Transport by air departure destination declaration</xd:short>
		<xd:detail>
			This templates displayes message if no transport by air destination details are there or add a button to add destination airport details
 		</xd:detail>	
 	</xd:doc>
	<xsl:template name="transport-by-air-dest-details-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="transport-by-air-details-dialog-declaration">
			<xsl:with-param name="dialogTemplateId">transport-by-air-dest-details-dialog-template</xsl:with-param>
			<xsl:with-param name="dialogtemplateContentId">transport-by-air-dest-details-dialog-template-content</xsl:with-param>
		</xsl:call-template>
		<!-- Dialog End -->
		<div id="transport-by-air-dest-details-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_NO_DEST_AIRPORT_DET')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_ADD_DEST_AIRPORT_DET')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Transport by air details dialog declaration</xd:short>
		<xd:detail>
			This templates sets parameters for different field called by input field template,it also adds OK and CANCEL button in Transport by air dialog.
 		</xd:detail>
 		<xd:param name="dialogTemplateId"> Identifier of dialog </xd:param>
 		<xd:param name="dialogtemplateContentId">Identifier of dialog Content </xd:param>
 	</xd:doc>
	<xsl:template name="transport-by-air-details-dialog-declaration">
		<xsl:param name="dialogTemplateId"></xsl:param>
		<xsl:param name="dialogtemplateContentId"></xsl:param>
		<div style="display:none" class="widgetContainer">
			<xsl:attribute name="id"><xsl:value-of select="$dialogTemplateId"/></xsl:attribute>
			<xsl:attribute name="title">Confirmation</xsl:attribute>
			<div class="standardPODialogContent">
				<xsl:attribute name="id"><xsl:value-of select="$dialogtemplateContentId"/></xsl:attribute>
					<div>
						<xsl:if	test="contains($dialogTemplateId,'transport-by-air-dept-details-dialog-template')">
							<xsl:call-template name="hidden-field">
								<xsl:with-param name="name">air_dept_rs_sub_type</xsl:with-param>
								<xsl:with-param name="value">01</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_DETAILS_PO_ROUTING_SUMMARY_AIRPORT_CODE</xsl:with-param>
								<xsl:with-param name="name">departure_airport_code</xsl:with-param>
								<xsl:with-param name="maxsize">6</xsl:with-param>
								<xsl:with-param name="fieldsize">x-small</xsl:with-param>
								<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
								<xsl:with-param name="override-displaymode">edit</xsl:with-param>
								<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
							</xsl:call-template>
							
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_DETAILS_PO_ROUTING_SUMMARY_TOWN</xsl:with-param>
								<xsl:with-param name="name">departure_air_town</xsl:with-param>
								<xsl:with-param name="maxsize">35</xsl:with-param>
								<xsl:with-param name="override-displaymode">edit</xsl:with-param>
								<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
								<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
							</xsl:call-template>
							
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_DETAILS_PO_ROUTING_SUMMARY_AIRPORT_NAME</xsl:with-param>
								<xsl:with-param name="name">departure_airport_name</xsl:with-param>
								<xsl:with-param name="maxsize">35</xsl:with-param>
								<xsl:with-param name="override-displaymode">edit</xsl:with-param>
								<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						
						<xsl:if	test="contains($dialogTemplateId,'transport-by-air-dest-details-dialog-template')">
							<xsl:call-template name="hidden-field">
								<xsl:with-param name="name">air_dest_rs_sub_type</xsl:with-param>
								<xsl:with-param name="value">02</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_DETAILS_PO_ROUTING_SUMMARY_AIRPORT_CODE</xsl:with-param>
								<xsl:with-param name="name">destination_airport_code</xsl:with-param>
								<xsl:with-param name="maxsize">6</xsl:with-param>
								<xsl:with-param name="fieldsize">x-small</xsl:with-param>
								<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
								<xsl:with-param name="override-displaymode">edit</xsl:with-param>
								<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
							</xsl:call-template>
							
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_DETAILS_PO_ROUTING_SUMMARY_TOWN</xsl:with-param>
								<xsl:with-param name="name">destination_air_town</xsl:with-param>
								<xsl:with-param name="maxsize">35</xsl:with-param>
								<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
								<xsl:with-param name="override-displaymode">edit</xsl:with-param>
								<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
							</xsl:call-template>
							
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_DETAILS_PO_ROUTING_SUMMARY_AIRPORT_NAME</xsl:with-param>
								<xsl:with-param name="name">destination_airport_name</xsl:with-param>
								<xsl:with-param name="maxsize">35</xsl:with-param>
								<xsl:with-param name="override-displaymode">edit</xsl:with-param>
								<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
							</xsl:call-template>
						</xsl:if>

						<div class="dijitDialogPaneActionBar">
							<xsl:call-template name="label-wrapper">
								<xsl:with-param name="content">
									<button type="button" dojoType="dijit.form.Button">
										<xsl:attribute name="onmouseup">dijit.byId('<xsl:value-of select="$dialogTemplateId"/>').hide();</xsl:attribute>
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
									</button>							
									<xsl:if test="$displaymode = 'edit'">
										<button dojoType="dijit.form.Button">
											<xsl:attribute name="onClick">dijit.byId('<xsl:value-of select="$dialogTemplateId"/>').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
										</button>
									</xsl:if>
								</xsl:with-param>
							</xsl:call-template>
						</div>
					</div>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Build Transport by air details</xd:short>
		<xd:detail>
			This templates displays header for diplaying departure and destination airport details in add,edit and view mode,also displayes header aircode,airname and town in the table.
			It also adds attributes for different fields and fills it with given selected value.
 		</xd:detail>
 		<xd:param name="items"> Items to be build to form display</xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">display mode can be overriden in edit form.</xd:param>
 		<xd:param name="dialogTemplateId">identifier of the dialog </xd:param>		
 	</xd:doc>
	<xsl:template name="build-transport-by-air-details-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="dialogTemplateId" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->

		<div>
			<xsl:attribute name="dialogId"><xsl:value-of select="$dialogTemplateId"/></xsl:attribute>
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:choose>
				<xsl:when test="contains($dialogTemplateId,'transport-by-air-dept-details-dialog-template')">
					<xsl:attribute name="dojoType">misys.openaccount.widget.TransportByAirDeptDetails</xsl:attribute>
					<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_ADD_DEPT_AIRPORT_DET')" /></xsl:attribute>
					<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_RS_EDIT_TRNSBYAIR_DEPT')" /></xsl:attribute>
					<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_RS_VIEW_TRNSBYAIR_DEPT')" /></xsl:attribute>
					<xsl:attribute name="headers">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_RS_AIRCODE')" />,
						<xsl:value-of select="localization:getGTPString($language, 'XSL_RS_TOWN')" />,
						<xsl:value-of select="localization:getGTPString($language, 'XSL_RS_AIRNAME')" />,
					</xsl:attribute>
				</xsl:when>
				<xsl:when test="contains($dialogTemplateId,'transport-by-air-dest-details-dialog-template')">
					<xsl:attribute name="dojoType">misys.openaccount.widget.TransportByAirDestDetails</xsl:attribute>
					<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_ADD_DEST_AIRPORT_DET')" /></xsl:attribute>
					<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_RS_EDIT_TRNSBYAIR_DEST')" /></xsl:attribute>
					<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_RS_VIEW_TRNSBYAIR_DEST')" /></xsl:attribute>
					<xsl:attribute name="headers">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_RS_AIRCODE')" />,
						<xsl:value-of select="localization:getGTPString($language, 'XSL_RS_TOWN')" />,
						<xsl:value-of select="localization:getGTPString($language, 'XSL_RS_AIRNAME')" />,
					</xsl:attribute>
				</xsl:when>
			</xsl:choose>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
			<xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="trnsByAir" select="." />
					<xsl:value-of select="$trnsByAir"/>
					<div>
						<xsl:if	test="contains($dialogTemplateId,'transport-by-air-dept-details-dialog-template')">
							<xsl:attribute name="dojoType">misys.openaccount.widget.TransportByAirDeptDetail</xsl:attribute>
							<xsl:attribute name="id"><xsl:value-of select="concat($id, '_', 'misys_openaccount_widget_TransportByAirDeptDetail_', position())" /></xsl:attribute>
							<xsl:attribute name="departure_airport_code"><xsl:value-of select="$trnsByAir/departure_airport_code"/></xsl:attribute>
							<xsl:attribute name="departure_air_town"><xsl:value-of select="$trnsByAir/departure_air_town"/></xsl:attribute>
							<xsl:attribute name="departure_airport_name"><xsl:value-of select="$trnsByAir/departure_airport_name"/></xsl:attribute>
							<xsl:attribute name="is_valid"><xsl:value-of select="$trnsByAir/is_valid"/></xsl:attribute>
							<xsl:attribute name="routing_summary_id"><xsl:value-of select="$trnsByAir/routing_summary_id"/></xsl:attribute>
							<xsl:attribute name="routing_summary_sub_type"><xsl:value-of select="$trnsByAir/routing_summary_sub_type"/></xsl:attribute>
							<xsl:attribute name="ref_id"><xsl:value-of select="$trnsByAir/ref_id"/></xsl:attribute>
							<xsl:attribute name="tnx_id"><xsl:value-of select="$trnsByAir/tnx_id"/></xsl:attribute>
						</xsl:if>
						<xsl:if	test="contains($dialogTemplateId,'transport-by-air-dest-details-dialog-template')">
							<xsl:attribute name="dojoType">misys.openaccount.widget.TransportByAirDestDetail</xsl:attribute>
							<xsl:attribute name="id"><xsl:value-of select="concat($id, '_', 'misys_openaccount_widget_TransportByAirDestDetail_', position())" /></xsl:attribute>
							<xsl:attribute name="destination_airport_code"><xsl:value-of select="$trnsByAir/destination_airport_code"/></xsl:attribute>
							<xsl:attribute name="destination_air_town"><xsl:value-of select="$trnsByAir/destination_air_town"/></xsl:attribute>
							<xsl:attribute name="destination_airport_name"><xsl:value-of select="$trnsByAir/destination_airport_name"/></xsl:attribute>
							<xsl:attribute name="is_valid"><xsl:value-of select="$trnsByAir/is_valid"/></xsl:attribute>
							<xsl:attribute name="routing_summary_id"><xsl:value-of select="$trnsByAir/routing_summary_id"/></xsl:attribute>
							<xsl:attribute name="routing_summary_sub_type"><xsl:value-of select="$trnsByAir/routing_summary_sub_type"/></xsl:attribute>
							<xsl:attribute name="ref_id"><xsl:value-of select="$trnsByAir/ref_id"/></xsl:attribute>
							<xsl:attribute name="tnx_id"><xsl:value-of select="$trnsByAir/tnx_id"/></xsl:attribute>
						</xsl:if>
					</div>
				</xsl:for-each>
			</xsl:if>
		</div>
	</xsl:template>

	

	<!--This template is called for each tag named "<departures>" in the xml, when apply-templates select="departures" is called. -->
	<xd:doc>
		<xd:short>Departures</xd:short>
		<xd:detail>This templates applies departure template for multiple calls in TransportByAirDeptDetails Widget</xd:detail>
	</xd:doc>
	<xsl:template match="departures">
		<div dojoType="misys.openaccount.widget.TransportByAirDeptDetails">
			<xsl:apply-templates select="departure"/>
		</div>
	</xsl:template>
	<xd:doc>
		<xd:short>Departure</xd:short>
		<xd:detail>This templates adds attributes and fill it with given selected value in TransportByAirDeptDetails Widget</xd:detail>
	</xd:doc>
	<xsl:template match="departure">
		<div dojoType="misys.openaccount.widget.TransportByAirDeptDetail">
			<xsl:attribute name="routing_summary_id"><xsl:value-of select="routing_summary_id"/></xsl:attribute>
			<xsl:attribute name="routing_summary_sub_type"><xsl:value-of select="routing_summary_sub_type"/></xsl:attribute>
			<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
			<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
			<xsl:attribute name="departure_airport_code"><xsl:value-of select="departure_airport_code"/></xsl:attribute>
			<xsl:attribute name="departure_air_town"><xsl:value-of select="departure_air_town"/></xsl:attribute>
			<xsl:attribute name="departure_airport_name"><xsl:value-of select="departure_airport_name"/></xsl:attribute>
			<xsl:attribute name="is_valid"><xsl:value-of select="is_valid"/></xsl:attribute>
		</div>
	</xsl:template>
	
	<!--This template is called for each tag named "<destinations>" in the xml, when apply-templates select="destinations" is called. -->
	<xd:doc>
		<xd:short>Destination</xd:short>
		<xd:detail>This templates applies destination template for multiple calls in TransportByAirDestDetails Widget</xd:detail>
	</xd:doc>
	<xsl:template match="destinations">
		<div dojoType="misys.openaccount.widget.TransportByAirDestDetails">
			<xsl:apply-templates select="destination"/>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Destination</xd:short>
		<xd:detail>This templates adds attributes and fill it with given selected value in TransportByAirDestDetails Widget</xd:detail>
	</xd:doc>
	<xsl:template match="destination">
		<div dojoType="misys.openaccount.widget.TransportByAirDestDetail">
			<xsl:attribute name="routing_summary_id"><xsl:value-of select="routing_summary_id"/></xsl:attribute>
			<xsl:attribute name="routing_summary_sub_type"><xsl:value-of select="routing_summary_sub_type"/></xsl:attribute>
			<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
			<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
			<xsl:attribute name="destination_airport_code"><xsl:value-of select="destination_airport_code"/></xsl:attribute>
			<xsl:attribute name="destination_air_town"><xsl:value-of select="destination_air_town"/></xsl:attribute>
			<xsl:attribute name="destination_airport_name"><xsl:value-of select="destination_airport_name"/></xsl:attribute>
			<xsl:attribute name="is_valid"><xsl:value-of select="is_valid"/></xsl:attribute>
		</div>
	</xsl:template>
	
	<!-- ****************************************** -->
			<!-- Routing summary by AIR -->
	<!-- ****************************************** -->
	
	<!-- ****************************************** -->
			<!-- Routing summary by SEA -->
	<!-- ****************************************** -->
	<xd:doc>
		<xd:short>Individual Routing Summary sea dialog declaration</xd:short>
		<xd:detail>
			This template add attribute title with value Confirmation,sets parameters of different template called under this template,adds OK and CANCEL button in Transport by sea dialog.
 		</xd:detail>
 		<xd:param name="toc-item">A Flag that indicates whether the header section label to be added as a tic-toc content on the floating navigation widget. </xd:param>
 	</xd:doc>
	<xsl:template name="individual-routing-summary-sea-dialog-declaration">
		<xsl:param name="toc-item" />
		<div id="routing-summary-sea-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
				<div id="routing-summary-sea-dialog-template-content" class="standardPODialogContent">
					<div>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">sea_routing_summary_type</xsl:with-param>
							<xsl:with-param name="value">01</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">sea_routing_summary_mode</xsl:with-param>
							<xsl:with-param name="value">02</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_CARRIER_NAME</xsl:with-param>
							<xsl:with-param name="name">sea_carrier_name</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_DETAILS_ROUTING_SUMMARY_LOADING_PORT</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="toc-item" select="$toc-item" />
							<xsl:with-param name="content">
							&nbsp;
								<xsl:call-template name="build-transport-by-sea-details-dojo-items">
									<xsl:with-param name="id">transport_by_sea_loading_ports</xsl:with-param>
									<xsl:with-param name="dialogTemplateId">transport-by-sea-loading-port-details-dialog-template</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_DETAILS_ROUTING_SUMMARY_DISCHARGE_PORT</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="toc-item" select="$toc-item" />
							<xsl:with-param name="content">
							&nbsp;
								<xsl:call-template name="build-transport-by-sea-details-dojo-items">
									<xsl:with-param name="id">transport_by_sea_discharge_ports</xsl:with-param>
									<xsl:with-param name="dialogTemplateId">transport-by-sea-discharge-port-details-dialog-template</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
				<div class="dijitDialogPaneActionBar">
				<xsl:call-template name="label-wrapper">
					<xsl:with-param name="content">
						<button type="button" dojoType="dijit.form.Button">
							<xsl:attribute name="onmouseup">dijit.byId('routing-summary-sea-dialog-template').hide();</xsl:attribute>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
						</button>	
						<xsl:if test="$displaymode = 'edit'">						
						<button dojoType="dijit.form.Button">
							<xsl:attribute name="onClick">dijit.byId('routing-summary-sea-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
						</button>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
				</div>
			</div>	
		</div>
	</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Transport by sea loading port detail declaration</xd:short>
		<xd:detail>
			This templates displayes message if no transport by sea port details details are there or add a button to add loading port details
 		</xd:detail>	
 	</xd:doc>
	<xsl:template name="transport-by-sea-loading-port-details-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="transport-by-sea-details-dialog-declaration">
			<xsl:with-param name="dialogTemplateId">transport-by-sea-loading-port-details-dialog-template</xsl:with-param>
			<xsl:with-param name="dialogtemplateContentId">transport-by-sea-loading-port-details-dialog-template-content</xsl:with-param>
		</xsl:call-template>
		<!-- Dialog End -->
		<div id="transport-by-sea-loading-port-details-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_NO_LOADING_PORT')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_ADD_LOADING_PORT')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Transport by sea discharge port declaration</xd:short>
		<xd:detail>
			This templates displayes message if no transport by sea discharge port details are there or add a button to add sea discharge port details
 		</xd:detail>	
 	</xd:doc>
	<xsl:template name="transport-by-sea-discharge-port-details-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="transport-by-sea-details-dialog-declaration">
			<xsl:with-param name="dialogTemplateId">transport-by-sea-discharge-port-details-dialog-template</xsl:with-param>
			<xsl:with-param name="dialogtemplateContentId">transport-by-sea-discharge-port-details-dialog-template-content</xsl:with-param>
		</xsl:call-template>
		<!-- Dialog End -->
		<div id="transport-by-sea-discharge-port-details-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_NO_DISCHARGE_PORT')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_ADD_DISCHARGE_PORT')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Transport by sea details dialog declaration</xd:short>
		<xd:detail>
			This templates sets parameters for different field called by input field template,it also adds OK and CANCEL button in Transport by air dialog.
 		</xd:detail>
 		<xd:param name="dialogTemplateId">Identifier of dialog Template </xd:param>
 		<xd:param name="dialogtemplateContentId"> Identifier of Dialog Content</xd:param>
 	</xd:doc>
	<xsl:template name="transport-by-sea-details-dialog-declaration">
		<xsl:param name="dialogTemplateId"></xsl:param>
		<xsl:param name="dialogtemplateContentId"></xsl:param>
		<div style="display:none" class="widgetContainer">
			<xsl:attribute name="id"><xsl:value-of select="$dialogTemplateId"/></xsl:attribute>
			<xsl:attribute name="title">Confirmation</xsl:attribute>
			<div class="standardPODialogContent">
				<xsl:attribute name="id"><xsl:value-of select="$dialogtemplateContentId"/></xsl:attribute>
					<div>
						<xsl:if	test="contains($dialogTemplateId,'transport-by-sea-loading-port-details-dialog-template')">
							<xsl:call-template name="hidden-field">
								<xsl:with-param name="name">sea_loading_rs_sub_type</xsl:with-param>
								<xsl:with-param name="value">03</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_ROUTING_SUMMARY_LOADING_PORT</xsl:with-param>
								<xsl:with-param name="name">loading_port_name</xsl:with-param>
								<xsl:with-param name="maxsize">35</xsl:with-param>
								<xsl:with-param name="override-displaymode">edit</xsl:with-param>
								<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						
						<xsl:if	test="contains($dialogTemplateId,'transport-by-sea-discharge-port-details-dialog-template')">
							<xsl:call-template name="hidden-field">
								<xsl:with-param name="name">sea_discharge_rs_sub_type</xsl:with-param>
								<xsl:with-param name="value">04</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_ROUTING_SUMMARY_DISCHARGE_PORT</xsl:with-param>
								<xsl:with-param name="name">discharge_port_name</xsl:with-param>
								<xsl:with-param name="maxsize">35</xsl:with-param>
								<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
								<xsl:with-param name="override-displaymode">edit</xsl:with-param>
								<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
							</xsl:call-template>
						</xsl:if>

						<div class="dijitDialogPaneActionBar">
							<xsl:call-template name="label-wrapper">
								<xsl:with-param name="content">
									<button type="button" dojoType="dijit.form.Button">
										<xsl:attribute name="onmouseup">dijit.byId('<xsl:value-of select="$dialogTemplateId"/>').hide();</xsl:attribute>
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
									</button>							
									<xsl:if test="$displaymode = 'edit'">
										<button dojoType="dijit.form.Button">
											<xsl:attribute name="onClick">dijit.byId('<xsl:value-of select="$dialogTemplateId"/>').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
										</button>
									</xsl:if>
								</xsl:with-param>
							</xsl:call-template>
						</div>
					</div>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Build Transport by sea details</xd:short>
		<xd:detail>
			This templates displays header for diplaying loading and discharging airport details in add,edit and view mode,also displayes header routing summary loading and discharge port in the table.
			It also adds attributes for different fields and fills it with given selected value.
 		</xd:detail>
 		<xd:param name="items"> Items to be build to form display</xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">display mode can be overriden in edit form.</xd:param>
 		<xd:param name="dialogTemplateId"> Identifier of dialog template</xd:param>		
 	</xd:doc>
	<xsl:template name="build-transport-by-sea-details-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="dialogTemplateId" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->

		<div>
			<xsl:attribute name="dialogId"><xsl:value-of select="$dialogTemplateId"/></xsl:attribute>
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:choose>
				<xsl:when test="contains($dialogTemplateId,'transport-by-sea-loading-port-details-dialog-template')">
					<xsl:attribute name="dojoType">misys.openaccount.widget.TransportBySeaLoadingPortDetails</xsl:attribute>
					<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_ADD_LOADING_PORT')" /></xsl:attribute>
					<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_EDIT_LOADING_PORT')" /></xsl:attribute>
					<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_VIEW_LOADING_PORT')" /></xsl:attribute>
					<xsl:attribute name="headers">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_ROUTING_SUMMARY_LOADING_PORT')" />,
					</xsl:attribute>
				</xsl:when>
				<xsl:when test="contains($dialogTemplateId,'transport-by-sea-discharge-port-details-dialog-template')">
					<xsl:attribute name="dojoType">misys.openaccount.widget.TransportBySeaDischargePortDetails</xsl:attribute>
					<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_ADD_DISCHARGE_PORT')" /></xsl:attribute>
					<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_EDIT_DISCHARGE_PORT')" /></xsl:attribute>
					<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_VIEW_DISCHARGE_PORT')" /></xsl:attribute>
					<xsl:attribute name="headers">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_ROUTING_SUMMARY_DISCHARGE_PORT')" />,
					</xsl:attribute>
				</xsl:when>
			</xsl:choose>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
			<xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="trnsBySea" select="." />
					<div>
						<xsl:if	test="contains($dialogTemplateId,'transport-by-sea-loading-port')">
							<xsl:attribute name="dojoType">misys.openaccount.widget.TransportBySeaLoadingPortDetail</xsl:attribute>
							<xsl:attribute name="id"><xsl:value-of select="concat($id, '_', 'misys_openaccount_widget_TransportBySeaLoadingPortDetail_', position())" /></xsl:attribute>
							<xsl:attribute name="loading_port_name"><xsl:value-of select="$trnsBySea/loading_port_name"/></xsl:attribute>
							<xsl:attribute name="is_valid"><xsl:value-of select="$trnsBySea/is_valid"/></xsl:attribute>
							<xsl:attribute name="routing_summary_id"><xsl:value-of select="$trnsBySea/routing_summary_id"/></xsl:attribute>
							<xsl:attribute name="routing_summary_sub_type"><xsl:value-of select="$trnsBySea/routing_summary_sub_type"/></xsl:attribute>
							<xsl:attribute name="ref_id"><xsl:value-of select="$trnsBySea/ref_id"/></xsl:attribute>
							<xsl:attribute name="tnx_id"><xsl:value-of select="$trnsBySea/tnx_id"/></xsl:attribute>
						</xsl:if>
						<xsl:if	test="contains($dialogTemplateId,'transport-by-sea-discharge-port')">
							<xsl:attribute name="dojoType">misys.openaccount.widget.TransportBySeaDischargePortDetail</xsl:attribute>
							<xsl:attribute name="id"><xsl:value-of select="concat($id, '_', 'misys_openaccount_widget_TransportBySeaDischargePortDetail_', position())" /></xsl:attribute>
							<xsl:attribute name="discharge_port_name"><xsl:value-of select="$trnsBySea/discharge_port_name"/></xsl:attribute>
							<xsl:attribute name="is_valid"><xsl:value-of select="$trnsBySea/is_valid"/></xsl:attribute>
							<xsl:attribute name="routing_summary_id"><xsl:value-of select="$trnsBySea/routing_summary_id"/></xsl:attribute>
							<xsl:attribute name="routing_summary_sub_type"><xsl:value-of select="$trnsBySea/routing_summary_sub_type"/></xsl:attribute>
							<xsl:attribute name="ref_id"><xsl:value-of select="$trnsBySea/ref_id"/></xsl:attribute>
							<xsl:attribute name="tnx_id"><xsl:value-of select="$trnsBySea/tnx_id"/></xsl:attribute>
						</xsl:if>
					</div>
				</xsl:for-each>
			</xsl:if>
		</div>
	</xsl:template>
	
	<!--This template is called for each tag named "<loading_ports>" in the xml, when apply-templates select="loading_ports" is called. -->
	<xd:doc>
		<xd:short>Loading Ports</xd:short>
		<xd:detail>This templates applies loading_port template for multiple calls in TransportBySeaLoadingPortDetails Widget</xd:detail>
	</xd:doc>
	<xsl:template match="loading_ports">
		<div dojoType="misys.openaccount.widget.TransportBySeaLoadingPortDetails">
		<xsl:apply-templates select="loading_port"/>
	</div>
	</xsl:template>
	<xd:doc>
		<xd:short>Loading Port</xd:short>
		<xd:detail>This templates adds attributes and fill it with given selected value in TransportBySeaLoadingPortDetail Widget</xd:detail>
	</xd:doc>
	<xsl:template match="loading_port">
		<div dojoType="misys.openaccount.widget.TransportBySeaLoadingPortDetail">
			<xsl:attribute name="routing_summary_id"><xsl:value-of select="routing_summary_id"/></xsl:attribute>
			<xsl:attribute name="routing_summary_sub_type"><xsl:value-of select="routing_summary_sub_type"/></xsl:attribute>
			<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
			<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
			<xsl:attribute name="loading_port_name"><xsl:value-of select="loading_port_name"/></xsl:attribute>
			<xsl:attribute name="is_valid"><xsl:value-of select="is_valid"/></xsl:attribute>
		</div>
	</xsl:template>
	
	<!--This template is called for each tag named "<discharge_ports>" in the xml, when apply-templates select="discharge_ports" is called. -->
	<xd:doc>
		<xd:short>Discharge Ports</xd:short>
		<xd:detail>This templates applies discharge_port template for multiple calls in TransportBySeaDischargePortDetails Widget</xd:detail>
	</xd:doc>
	<xsl:template match="discharge_ports">
		<div dojoType="misys.openaccount.widget.TransportBySeaDischargePortDetails">
		<xsl:apply-templates select="discharge_port"/>
	</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Discharge Port</xd:short>
		<xd:detail>This templates adds attributes and fill it with given selected value in TransportBySeaDischargePortDetail Widget</xd:detail>
	</xd:doc>
	<xsl:template match="discharge_port">
		<div dojoType="misys.openaccount.widget.TransportBySeaDischargePortDetail">
			<xsl:attribute name="routing_summary_id"><xsl:value-of select="routing_summary_id"/></xsl:attribute>
			<xsl:attribute name="routing_summary_sub_type"><xsl:value-of select="routing_summary_sub_type"/></xsl:attribute>
			<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
			<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
			<xsl:attribute name="discharge_port_name"><xsl:value-of select="discharge_port_name"/></xsl:attribute>
			<xsl:attribute name="is_valid"><xsl:value-of select="is_valid"/></xsl:attribute>
		</div>
	</xsl:template>
	
	<!-- ****************************************** -->
			<!-- Routing summary by SEA -->
	<!-- ****************************************** -->

	<!-- ****************************************** -->
			<!-- Routing summary by RAIL -->
	<!-- ****************************************** -->
	<xd:doc>
		<xd:short>Individual Routing Summary rail dialog declaration</xd:short>
		<xd:detail>
			This template add attribute title with value Confirmation,sets parameters of different template called under this template,adds OK and CANCEL button in Transport by rail dialog.
 		</xd:detail>
 		<xd:param name="toc-item">A Flag that indicates whether the header section label to be added as a tic-toc content on the floating navigation widget. </xd:param>
 	</xd:doc>
	<xsl:template name="individual-routing-summary-rail-dialog-declaration">
		<xsl:param name="toc-item" />
		<div id="routing-summary-rail-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
				<div id="routing-summary-rail-dialog-template-content" class="standardPODialogContent">
					<div>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">rail_routing_summary_type</xsl:with-param>
							<xsl:with-param name="value">01</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">rail_routing_summary_mode</xsl:with-param>
							<xsl:with-param name="value">04</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_CARRIER_NAME</xsl:with-param>
							<xsl:with-param name="name">rail_carrier_name</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_DETAILS_TRNS_BY_RAIL_RECEIPT_PLACE</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="toc-item" select="$toc-item" />
							<xsl:with-param name="content">
							&nbsp;
								<xsl:call-template name="build-transport-by-rail-road-details-dojo-items">
									<xsl:with-param name="id">transport_by_rail_receipt_places</xsl:with-param>
									<xsl:with-param name="dialogTemplateId">transport-by-rail-receipt-place-details-dialog-template</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_DETAILS_TRNS_BY_RAIL_DELIVERY_PLACE</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="toc-item" select="$toc-item" />
							<xsl:with-param name="content">
							&nbsp;
								<xsl:call-template name="build-transport-by-rail-road-details-dojo-items">
									<xsl:with-param name="id">transport_by_rail_delivery_places</xsl:with-param>
									<xsl:with-param name="dialogTemplateId">transport-by-rail-delivery-place-details-dialog-template</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					<div class="dijitDialogPaneActionBar">
						<xsl:call-template name="label-wrapper">
							<xsl:with-param name="content">
								<button type="button" dojoType="dijit.form.Button">
									<xsl:attribute name="onmouseup">dijit.byId('routing-summary-rail-dialog-template').hide();</xsl:attribute>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
								</button>
								<xsl:if test="$displaymode = 'edit'">								
								<button dojoType="dijit.form.Button">
									<xsl:attribute name="onClick">dijit.byId('routing-summary-rail-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
								</button>
								</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
					</div>
				</div>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Transport by rail reciept place details declaration</xd:short>
		<xd:detail>
			This templates displayes message if no transport by rail place details are there or add a button to add reciept place details for rail.
 		</xd:detail>	
 	</xd:doc>
	<xsl:template name="transport-by-rail-receipt-place-details-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="transport-by-rail-road-details-dialog-declaration">
			<xsl:with-param name="dialogTemplateId">transport-by-rail-receipt-place-details-dialog-template</xsl:with-param>
			<xsl:with-param name="dialogtemplateContentId">transport-by-rail-receipt-place-details-dialog-template-content</xsl:with-param>
		</xsl:call-template>
		<!-- Dialog End -->
		<div id="transport-by-rail-receipt-place-details-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_NO_RECEIPT_PLACE')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_ADD_RECEIPT_PLACE')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Transport by rail delivery place detail declaration</xd:short>
		<xd:detail>
			This templates displayes message if no delivery place details of rail are there and add a button to add delivery place details
 		</xd:detail>	
 	</xd:doc>
	<xsl:template name="transport-by-rail-delivery-place-details-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="transport-by-rail-road-details-dialog-declaration">
			<xsl:with-param name="dialogTemplateId">transport-by-rail-delivery-place-details-dialog-template</xsl:with-param>
			<xsl:with-param name="dialogtemplateContentId">transport-by-rail-delivery-place-details-dialog-template-content</xsl:with-param>
		</xsl:call-template>
		<!-- Dialog End -->
		<div id="transport-by-rail-delivery-place-details-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_NO_DELIVERY_PLACE')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_ADD_DELIVERY_PLACE')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Transport by rail road details dialog declaration</xd:short>
		<xd:detail>
			This templates sets parameters for different field called by input field template,it also adds OK and CANCEL button in Transport by rail road dialog.
 		</xd:detail>
 		<xd:param name="dialogTemplateId">Identifier of Dialog Template </xd:param>
 		<xd:param name="dialogtemplateContentId">Identifier of Dialog Content </xd:param>
 	</xd:doc>
	<xsl:template name="transport-by-rail-road-details-dialog-declaration">
		<xsl:param name="dialogTemplateId"></xsl:param>
		<xsl:param name="dialogtemplateContentId"></xsl:param>
		<div style="display:none" class="widgetContainer">
			<xsl:attribute name="id"><xsl:value-of select="$dialogTemplateId"/></xsl:attribute>
			<xsl:attribute name="title">Confirmation</xsl:attribute>
			<div class="standardPODialogContent">
				<xsl:attribute name="id"><xsl:value-of select="$dialogtemplateContentId"/></xsl:attribute>
					<div>
						<xsl:if	test="contains($dialogTemplateId,'transport-by-rail-receipt-place')">
							<xsl:call-template name="hidden-field">
								<xsl:with-param name="name">rail_receipt_place_rs_sub_type</xsl:with-param>
								<xsl:with-param name="value">07</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_TRANSPORT_BY_RAIL_RECEIPT_PLACE</xsl:with-param>
								<xsl:with-param name="name">rail_receipt_place_name</xsl:with-param>
								<xsl:with-param name="maxsize">35</xsl:with-param>
								<xsl:with-param name="override-displaymode">edit</xsl:with-param>
								<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						
						<xsl:if	test="contains($dialogTemplateId,'transport-by-rail-delivery-place')">
							<xsl:call-template name="hidden-field">
								<xsl:with-param name="name">rail_delivery_place_rs_sub_type</xsl:with-param>
								<xsl:with-param name="value">08</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_TRANSPORT_BY_RAIL_DELIVERY_PLACE</xsl:with-param>
								<xsl:with-param name="name">rail_delivery_place_name</xsl:with-param>
								<xsl:with-param name="maxsize">35</xsl:with-param>
								<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
								<xsl:with-param name="override-displaymode">edit</xsl:with-param>
								<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if	test="contains($dialogTemplateId,'transport-by-road-receipt-place')">
							<xsl:call-template name="hidden-field">
								<xsl:with-param name="name">road_receipt_place_rs_sub_type</xsl:with-param>
								<xsl:with-param name="value">05</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_TRANSPORT_BY_RAIL_RECEIPT_PLACE</xsl:with-param>
								<xsl:with-param name="name">road_receipt_place_name</xsl:with-param>
								<xsl:with-param name="maxsize">35</xsl:with-param>
								<xsl:with-param name="override-displaymode">edit</xsl:with-param>
								<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						
						<xsl:if	test="contains($dialogTemplateId,'transport-by-road-delivery-place') ">
							<xsl:call-template name="hidden-field">
								<xsl:with-param name="name">road_delivery_place_rs_sub_type</xsl:with-param>
								<xsl:with-param name="value">06</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_TRANSPORT_BY_RAIL_DELIVERY_PLACE</xsl:with-param>
								<xsl:with-param name="name">road_delivery_place_name</xsl:with-param>
								<xsl:with-param name="maxsize">35</xsl:with-param>
								<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
								<xsl:with-param name="override-displaymode">edit</xsl:with-param>
								<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
							</xsl:call-template>
						</xsl:if>

						<div class="dijitDialogPaneActionBar">
							<xsl:call-template name="label-wrapper">
								<xsl:with-param name="content">
									<button type="button" dojoType="dijit.form.Button">
										<xsl:attribute name="onmouseup">dijit.byId('<xsl:value-of select="$dialogTemplateId"/>').hide();</xsl:attribute>
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
									</button>							
									<xsl:if test="$displaymode = 'edit'">
										<button dojoType="dijit.form.Button">
											<xsl:attribute name="onClick">dijit.byId('<xsl:value-of select="$dialogTemplateId"/>').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
										</button>
									</xsl:if>
								</xsl:with-param>
							</xsl:call-template>
						</div>
					</div>
			</div>
		</div>
	</xsl:template>
	<xd:doc>
		<xd:short>Build Transport by air details</xd:short>
		<xd:detail>
			This templates displays header for diplaying reciept and delivery place of rail-road details in add,edit and view mode,also displayes header reciept and delivery place in the table.
			It also adds attributes for different fields and fills it with given selected value.
 		</xd:detail>
 		<xd:param name="items"> Items to be build to form display</xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">display mode can be overriden in edit form.</xd:param>
 		<xd:param name="dialogTemplateId"> Identifier of dialog template</xd:param>
 	</xd:doc>
	<xsl:template name="build-transport-by-rail-road-details-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="dialogTemplateId" />
		<xsl:param name="templateString" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->

		<div>
			<xsl:attribute name="dialogId"><xsl:value-of select="$dialogTemplateId"/></xsl:attribute>
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:choose>
				<xsl:when test="contains($dialogTemplateId,'transport-by-rail-receipt-place-details-dialog-template')">
					<xsl:attribute name="dojoType">misys.openaccount.widget.TransportByRailReceiptPlaceDetails</xsl:attribute>
					<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_ADD_RECEIPT_PLACE')" /></xsl:attribute>
					<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_EDIT_RECEIPT_PLACE')" /></xsl:attribute>
					<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_VIEW_RECEIPT_PLACE')" /></xsl:attribute>
					<xsl:attribute name="headers">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_TRNS_BY_RAIL_RECEIPT_PLACE')" />,
					</xsl:attribute>
				</xsl:when>
				<xsl:when test="contains($dialogTemplateId,'transport-by-rail-delivery-place-details-dialog-template')">
					<xsl:attribute name="dojoType">misys.openaccount.widget.TransportByRailDeliveryPlaceDetails</xsl:attribute>
					<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_ADD_DELIVERY_PLACE')" /></xsl:attribute>
					<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_EDIT_DELIVERY_PLACE')" /></xsl:attribute>
					<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_VIEW_DELIVERY_PLACE')" /></xsl:attribute>
					<xsl:attribute name="headers">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_TRNS_BY_RAIL_DELIVERY_PLACE')" />,
					</xsl:attribute>
				</xsl:when>
				<xsl:when test="contains($dialogTemplateId,'transport-by-road-receipt-place-details-dialog-template')">
					<xsl:attribute name="dojoType">misys.openaccount.widget.TransportByRoadReceiptPlaceDetails</xsl:attribute>
					<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_ADD_RECEIPT_PLACE')" /></xsl:attribute>
					<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_EDIT_RECEIPT_PLACE')" /></xsl:attribute>
					<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_VIEW_RECEIPT_PLACE')" /></xsl:attribute>
					<xsl:attribute name="headers">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_TRNS_BY_RAIL_RECEIPT_PLACE')" />,
					</xsl:attribute>
				</xsl:when>
				<xsl:when test="contains($dialogTemplateId,'transport-by-road-delivery-place-details-dialog-template')">
					<xsl:attribute name="dojoType">misys.openaccount.widget.TransportByRoadDeliveryPlaceDetails</xsl:attribute>
					<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_ADD_DELIVERY_PLACE')" /></xsl:attribute>
					<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_EDIT_DELIVERY_PLACE')" /></xsl:attribute>
					<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_VIEW_DELIVERY_PLACE')" /></xsl:attribute>
					<xsl:attribute name="headers">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_TRNS_BY_RAIL_DELIVERY_PLACE')" />,
					</xsl:attribute>
				</xsl:when>
			</xsl:choose>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
			<xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="trnsByRailRoad" select="." />
					<div>
						<xsl:if	test="contains($dialogTemplateId,'transport-by-rail-receipt-place-details-dialog-template')">
							<xsl:attribute name="dojoType">misys.openaccount.widget.TransportByRailReceiptPlaceDetail</xsl:attribute>
							<xsl:attribute name="rail_receipt_place_name"><xsl:value-of select="$trnsByRailRoad/rail_receipt_place_name"/></xsl:attribute>
							<xsl:attribute name="is_valid"><xsl:value-of select="$trnsByRailRoad/is_valid"/></xsl:attribute>
							<xsl:attribute name="routing_summary_id"><xsl:value-of select="$trnsByRailRoad/routing_summary_id"/></xsl:attribute>
							<xsl:attribute name="routing_summary_sub_type"><xsl:value-of select="$trnsByRailRoad/routing_summary_sub_type"/></xsl:attribute>
							<xsl:attribute name="ref_id"><xsl:value-of select="$trnsByRailRoad/ref_id"/></xsl:attribute>
							<xsl:attribute name="tnx_id"><xsl:value-of select="$trnsByRailRoad/tnx_id"/></xsl:attribute>
						</xsl:if>
						<xsl:if	test="contains($dialogTemplateId,'transport-by-rail-delivery-place-details-dialog-template')">
							<xsl:attribute name="dojoType">misys.openaccount.widget.TransportByRailDeliveryPlaceDetail</xsl:attribute>
							<xsl:attribute name="rail_delivery_place_name"><xsl:value-of select="$trnsByRailRoad/rail_delivery_place_name"/></xsl:attribute>
							<xsl:attribute name="is_valid"><xsl:value-of select="$trnsByRailRoad/is_valid"/></xsl:attribute>
							<xsl:attribute name="routing_summary_id"><xsl:value-of select="$trnsByRailRoad/routing_summary_id"/></xsl:attribute>
							<xsl:attribute name="routing_summary_sub_type"><xsl:value-of select="$trnsByRailRoad/routing_summary_sub_type"/></xsl:attribute>
							<xsl:attribute name="ref_id"><xsl:value-of select="$trnsByRailRoad/ref_id"/></xsl:attribute>
							<xsl:attribute name="tnx_id"><xsl:value-of select="$trnsByRailRoad/tnx_id"/></xsl:attribute>
						</xsl:if>
						<xsl:if	test="contains($dialogTemplateId,'transport-by-road-receipt-place-details-dialog-template')">
							<xsl:attribute name="dojoType">misys.openaccount.widget.TransportByRoadReceiptPlaceDetail</xsl:attribute>
							<xsl:attribute name="road_receipt_place_name"><xsl:value-of select="$trnsByRailRoad/road_receipt_place_name"/></xsl:attribute>
							<xsl:attribute name="is_valid"><xsl:value-of select="$trnsByRailRoad/is_valid"/></xsl:attribute>
							<xsl:attribute name="routing_summary_id"><xsl:value-of select="$trnsByRailRoad/routing_summary_id"/></xsl:attribute>
							<xsl:attribute name="routing_summary_sub_type"><xsl:value-of select="$trnsByRailRoad/routing_summary_sub_type"/></xsl:attribute>
							<xsl:attribute name="ref_id"><xsl:value-of select="$trnsByRailRoad/ref_id"/></xsl:attribute>
							<xsl:attribute name="tnx_id"><xsl:value-of select="$trnsByRailRoad/tnx_id"/></xsl:attribute>
						</xsl:if>
						<xsl:if	test="contains($dialogTemplateId,'transport-by-road-delivery-place-details-dialog-template')">
							<xsl:attribute name="dojoType">misys.openaccount.widget.TransportByRoadDeliveryPlaceDetail</xsl:attribute>
							<xsl:attribute name="road_delivery_place_name"><xsl:value-of select="$trnsByRailRoad/road_delivery_place_name"/></xsl:attribute>
							<xsl:attribute name="is_valid"><xsl:value-of select="$trnsByRailRoad/is_valid"/></xsl:attribute>
							<xsl:attribute name="routing_summary_id"><xsl:value-of select="$trnsByRailRoad/routing_summary_id"/></xsl:attribute>
							<xsl:attribute name="routing_summary_sub_type"><xsl:value-of select="$trnsByRailRoad/routing_summary_sub_type"/></xsl:attribute>
							<xsl:attribute name="ref_id"><xsl:value-of select="$trnsByRailRoad/ref_id"/></xsl:attribute>
							<xsl:attribute name="tnx_id"><xsl:value-of select="$trnsByRailRoad/tnx_id"/></xsl:attribute>
						</xsl:if>
					</div>
				</xsl:for-each>
			</xsl:if>
		</div>
	</xsl:template>
	
	
	<!--This template is called for each tag named "<rail_receipt_places>" in the xml, when apply-templates select="rail_receipt_places" is called. -->
	<xd:doc>
		<xd:short>Rail Reciept Places</xd:short>
		<xd:detail>This templates applies rail_reciept_place template for multiple calls in TransportByRailReceiptPlaceDetails Widget</xd:detail>
	</xd:doc>
	<xsl:template match="rail_receipt_places">
		<div dojoType="misys.openaccount.widget.TransportByRailReceiptPlaceDetails">
		<xsl:apply-templates select="rail_receipt_place"/>
	</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Rail Reciept Place</xd:short>
		<xd:detail>This templates applies destination template for multiple calls in TransportByRailReceiptPlaceDetail Widget</xd:detail>
	</xd:doc>
	<xsl:template match="rail_receipt_place">
		<div dojoType="misys.openaccount.widget.TransportByRailReceiptPlaceDetail">
			<xsl:attribute name="rail_receipt_place_name"><xsl:value-of select="rail_receipt_place_name"/></xsl:attribute>
			<xsl:attribute name="routing_summary_id"><xsl:value-of select="routing_summary_id"/></xsl:attribute>
			<xsl:attribute name="routing_summary_sub_type"><xsl:value-of select="routing_summary_sub_type"/></xsl:attribute>
			<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
			<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
			<xsl:attribute name="is_valid"><xsl:value-of select="is_valid"/></xsl:attribute>
			
		</div>
	</xsl:template>
	
	<!--This template is called for each tag named "<rail_delivery_places>" in the xml, when apply-templates select="rail_delivery_places" is called. -->
	<xd:doc>
		<xd:short>Rail Delivery Places</xd:short>
		<xd:detail>This templates applies rail_delivery_place template for multiple calls in TransportByRailDeliveryPlaceDetails Widget</xd:detail>
	</xd:doc>
	<xsl:template match="rail_delivery_places">
		<div dojoType="misys.openaccount.widget.TransportByRailDeliveryPlaceDetails">
		<xsl:apply-templates select="rail_delivery_place"/>
	</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Rail Delivery Place</xd:short>
		<xd:detail>This templates adds attributes and fill it with given selected value in TransportByRailDeliveryPlaceDetail Widget</xd:detail>
	</xd:doc>
	<xsl:template match="rail_delivery_place">
		<div dojoType="misys.openaccount.widget.TransportByRailDeliveryPlaceDetail">
			<xsl:attribute name="rail_delivery_place_name"><xsl:value-of select="rail_delivery_place_name"/></xsl:attribute>
			<xsl:attribute name="routing_summary_id"><xsl:value-of select="routing_summary_id"/></xsl:attribute>
			<xsl:attribute name="routing_summary_sub_type"><xsl:value-of select="routing_summary_sub_type"/></xsl:attribute>
			<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
			<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
			<xsl:attribute name="is_valid"><xsl:value-of select="is_valid"/></xsl:attribute>
		</div>
	</xsl:template>
	<!-- ****************************************** -->
			<!-- Routing summary by RAIL -->
	<!-- ****************************************** -->
	
	<!-- ****************************************** -->
			<!-- Routing summary by ROAD -->
	<!-- ****************************************** -->
	<xd:doc>
		<xd:short>Individual Routing Summary road dialog declaration</xd:short>
		<xd:detail>
			This templates sets parameters of different template called under this,adds OK and CANCEL button in Transport by road dialog.
 		</xd:detail>
 		<xd:param name="toc-item">A Flag that indicates whether the header section label to be added as a tic-toc content on the floating navigation widget. </xd:param>
 	</xd:doc>
	<xsl:template name="individual-routing-summary-road-dialog-declaration">
		<xsl:param name="toc-item" />
		<div id="routing-summary-road-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
				<div id="routing-summary-road-dialog-template-content" class="standardPODialogContent">
					<div>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">road_routing_summary_type</xsl:with-param>
							<xsl:with-param name="value">01</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">road_routing_summary_mode</xsl:with-param>
							<xsl:with-param name="value">03</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_CARRIER_NAME</xsl:with-param>
							<xsl:with-param name="name">road_carrier_name</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_DETAILS_TRNS_BY_RAIL_RECEIPT_PLACE</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="toc-item" select="$toc-item" />
							<xsl:with-param name="content">
							&nbsp;
								<xsl:call-template name="build-transport-by-rail-road-details-dojo-items">
									<xsl:with-param name="id">transport_by_road_receipt_places</xsl:with-param>
									<xsl:with-param name="dialogTemplateId">transport-by-road-receipt-place-details-dialog-template</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_DETAILS_TRNS_BY_RAIL_DELIVERY_PLACE</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="toc-item" select="$toc-item" />
							<xsl:with-param name="content">
							&nbsp;
								<xsl:call-template name="build-transport-by-rail-road-details-dojo-items">
									<xsl:with-param name="id">transport_by_road_delivery_places</xsl:with-param>
									<xsl:with-param name="dialogTemplateId">transport-by-road-delivery-place-details-dialog-template</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					<div class="dijitDialogPaneActionBar">
						<xsl:call-template name="label-wrapper">
							<xsl:with-param name="content">
								<button type="button" dojoType="dijit.form.Button">
									<xsl:attribute name="onmouseup">dijit.byId('routing-summary-road-dialog-template').hide();</xsl:attribute>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
								</button>
								<xsl:if test="$displaymode = 'edit'">								
								<button dojoType="dijit.form.Button">
									<xsl:attribute name="onClick">dijit.byId('routing-summary-road-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
								</button>
								</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
					</div>
				</div>
			</div>
		</div>
	</xsl:template>
	<xd:doc>
		<xd:short>Transport by road reciept place details declaration</xd:short>
		<xd:detail>
			This templates displayes message if no transport by road reciept place details are there or add a button to add reciept place details for road.
 		</xd:detail>	
 	</xd:doc>
	<xsl:template name="transport-by-road-receipt-place-details-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="transport-by-rail-road-details-dialog-declaration">
			<xsl:with-param name="dialogTemplateId">transport-by-road-receipt-place-details-dialog-template</xsl:with-param>
			<xsl:with-param name="dialogtemplateContentId">transport-by-road-receipt-place-details-dialog-template-content</xsl:with-param>
		</xsl:call-template>
		<!-- Dialog End -->
		<div id="transport-by-road-receipt-place-details-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_NO_RECEIPT_PLACE')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_ADD_RECEIPT_PLACE')" />
				</button>
			</div>
		</div>
	</xsl:template>
	<xd:doc>
		<xd:short>Transport by road delivery place detail declaration</xd:short>
		<xd:detail>
			This templates displayes message if no delivery place details of road are there and add a button to add delivery place details of road transport.
 		</xd:detail>	
 	</xd:doc>
	<xsl:template name="transport-by-road-delivery-place-details-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="transport-by-rail-road-details-dialog-declaration">
			<xsl:with-param name="dialogTemplateId">transport-by-road-delivery-place-details-dialog-template</xsl:with-param>
			<xsl:with-param name="dialogtemplateContentId">transport-by-road-delivery-place-details-dialog-template-content</xsl:with-param>
		</xsl:call-template>
		<!-- Dialog End -->
		<div id="transport-by-road-delivery-place-details-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_NO_DELIVERY_PLACE')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_ADD_DELIVERY_PLACE')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	<!--This template is called for each tag named "<road_receipt_places>" in the xml, when apply-templates select="road_receipt_places" is called. -->
	<xd:doc>
		<xd:short>Road Reciept Places</xd:short>
		<xd:detail>This templates applies road_receipt_place template for multiple calls in TransportByRoadReceiptPlaceDetails Widget</xd:detail>
	</xd:doc>
	<xsl:template match="road_receipt_places">
		<div dojoType="misys.openaccount.widget.TransportByRoadReceiptPlaceDetails">
		<xsl:apply-templates select="road_receipt_place"/>
	</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Road Reciept Place</xd:short>
		<xd:detail>This templates adds attributes and fill it with given selected value in TransportByRoadReceiptPlaceDetail Widget</xd:detail>
	</xd:doc>
	<xsl:template match="road_receipt_place">
		<div dojoType="misys.openaccount.widget.TransportByRoadReceiptPlaceDetail">
			<xsl:attribute name="road_receipt_place_name"><xsl:value-of select="road_receipt_place_name"/></xsl:attribute>
			<xsl:attribute name="routing_summary_id"><xsl:value-of select="routing_summary_id"/></xsl:attribute>
			<xsl:attribute name="routing_summary_sub_type"><xsl:value-of select="routing_summary_sub_type"/></xsl:attribute>
			<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
			<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
			<xsl:attribute name="is_valid"><xsl:value-of select="is_valid"/></xsl:attribute>
		</div>
	</xsl:template>
	
	<!--This template is called for each tag named "<road_delivery_places>" in the xml, when apply-templates select="road_delivery_places" is called. -->
	<xd:doc>
		<xd:short>Road Delivery Places</xd:short>
		<xd:detail>This templates applies road_delivery_place template for multiple calls in TransportByRoadDeliveryPlaceDetails Widget</xd:detail>
	</xd:doc>
	<xsl:template match="road_delivery_places">
		<div dojoType="misys.openaccount.widget.TransportByRoadDeliveryPlaceDetails">
		<xsl:apply-templates select="road_delivery_place"/>
	</div>
	</xsl:template>
	<xd:doc>
		<xd:short>Road Delivery Place</xd:short>
		<xd:detail>This templates adds attributes and fill it with given selected value in TransportByRoadDeliveryPlaceDetail Widget</xd:detail>
	</xd:doc>
	<xsl:template match="road_delivery_place">
		<div dojoType="misys.openaccount.widget.TransportByRoadDeliveryPlaceDetail">
			<xsl:attribute name="road_delivery_place_name"><xsl:value-of select="road_delivery_place_name"/></xsl:attribute>
			<xsl:attribute name="routing_summary_id"><xsl:value-of select="routing_summary_id"/></xsl:attribute>
			<xsl:attribute name="routing_summary_sub_type"><xsl:value-of select="routing_summary_sub_type"/></xsl:attribute>
			<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
			<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
			<xsl:attribute name="is_valid"><xsl:value-of select="is_valid"/></xsl:attribute>
		</div>
	</xsl:template>
	<!-- ****************************************** -->
			<!-- Routing summary by ROAD -->
	<!-- ****************************************** -->
	
	
	
	<!-- *************************************************************** -->
						<!-- Routing summaries -->
	<!-- *************************************************************** -->
	<xd:doc>
		<xd:short>Build BPO payment term</xd:short>
		<xd:detail>
			This templates displays header for diplaying BPO payment term in add,edit and view mode,also displayes header in the BPO payment term code table.
			It also  adds attributes of different fields in BPO payment term dialog and fills it with value given in the select criteria.
 		</xd:detail>
 		<xd:param name="items"> Items to be build to form display</xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">display mode can be overriden in edit form.</xd:param>	
 	</xd:doc>
	<xsl:template name="build-bpo-payment-terms-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
		
		<div dojoType="misys.openaccount.widget.BpoPaymentTerms" dialogId="bpo-payment-terms-dialog-template">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_BPO_ADD_PAYMENT_TERMS')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_BPO_EDIT_PAYMENT_TERMS')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_BPO_VIEW_PAYMENT_TERMS')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PAYMENT_TERMS')" />,
			</xsl:attribute>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
			 <xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="paymentOblg" select="." />
					<div dojoType="misys.openaccount.widget.BpoPaymentTerm">
						<xsl:attribute name="pmt_code">
							<xsl:if test="$paymentOblg/PmtTerms/PmtCd/Cd[.!= '']">01</xsl:if>
						</xsl:attribute>
						<xsl:attribute name="pmt_other_term_code">
							<xsl:if test="$paymentOblg/PmtTerms/OthrPmtTerms[.!= '']">02</xsl:if>
						</xsl:attribute>
						
						<xsl:attribute name="payment_code"><xsl:value-of
								select="$paymentOblg/PmtTerms/PmtCd/Cd" /></xsl:attribute>
						<xsl:attribute name="payment_nb_days"><xsl:value-of
								select="$paymentOblg/PmtTerms/PmtCd/NbOfDays" /></xsl:attribute>
						<xsl:attribute name="payment_other_term"><xsl:value-of
								select="$paymentOblg/PmtTerms/OthrPmtTerms" /></xsl:attribute>
						<xsl:attribute name="payment_amount"><xsl:value-of
								select="$paymentOblg/PmtTerms/Amt" /></xsl:attribute>
						<xsl:attribute name="payment_percent"><xsl:value-of
								select="$paymentOblg/PmtTerms/Pctg" /></xsl:attribute>
					</div>
				</xsl:for-each>
			</xsl:if>
		</div>

	</xsl:template>
	
	<!-- Bank Payment Obligation section -->
	<xd:doc>
		<xd:short>Bank Payment Obligation Detail Dialog Declaration</xd:short>
		<xd:detail>
			This templates adds attribute title and fills it with Confirmation value,also sets parameters of different template called under this template,adds OK and CANCEL buttonin BPO dialog.
 		</xd:detail>
 		<xd:param name="toc-item">A Flag that indicates whether the header section label to be added as a tic-toc content on the floating navigation widget. </xd:param>
 	</xd:doc>
	<xsl:template name="bank-payment-obligation-details-dialog-declaration">
		<xsl:variable name="toc-item">N</xsl:variable>
		<div id="bank-payment-obligation-details-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
			<div id="bank-payment-obligation-details-dialog-template-content" class="standardPODialogContent">
			<div>
				<xsl:call-template name="checkbox-field">
	      			 <xsl:with-param name="label">XSL_LABEL_BUYER_BANK_BPO</xsl:with-param>
	  	  			 <xsl:with-param name="name">buyer_bank_bpo</xsl:with-param>
	  	  			 <xsl:with-param name="override-displaymode">edit</xsl:with-param>
	  	  			 <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
	  	  			 <xsl:with-param name="disabled">
	  	  			 <xsl:choose>
	  	  			 <xsl:when test="$displaymode = 'edit'">N</xsl:when>
	  	  			 <xsl:otherwise>Y</xsl:otherwise>
	  	  			 </xsl:choose>
	  	  			 </xsl:with-param>
	     		 </xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_PURCHASE_ORDER_OBLIGOR_BANK</xsl:with-param>
					<xsl:with-param name="name">obligor_bank</xsl:with-param>
					<xsl:with-param name="override-displaymode">edit</xsl:with-param>
					<xsl:with-param name="size">35</xsl:with-param>
					<xsl:with-param name="maxsize">35</xsl:with-param>
					<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
					<xsl:with-param name="fieldsize">small</xsl:with-param>
					<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_PURCHASE_ORDER_RECIPIENT_BANK</xsl:with-param>
					<xsl:with-param name="name">recipient_bank</xsl:with-param>
					<xsl:with-param name="override-displaymode">edit</xsl:with-param>
					<xsl:with-param name="size">35</xsl:with-param>
					<xsl:with-param name="maxsize">35</xsl:with-param>
					<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
					<xsl:with-param name="fieldsize">small</xsl:with-param>
					<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
				</xsl:call-template>
				
		        <xsl:call-template name="input-field">
			         <xsl:with-param name="label">XSL_LABEL_PAYMENT_OBLIGATION_AMOUNT</xsl:with-param>
			         <xsl:with-param name="id">payment_obligation_amount</xsl:with-param>
			         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
			         <xsl:with-param name="type">amount</xsl:with-param>
			         <xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
			         <xsl:with-param name="fieldsize">small</xsl:with-param>
			         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
		        </xsl:call-template>
		        <xsl:call-template name="input-field">
			         <xsl:with-param name="label">XSL_LABEL_PAYMENT_OBLIGATION_PERCENT</xsl:with-param>
			         <xsl:with-param name="id">payment_obligation_percent</xsl:with-param>
			         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
			         <xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
			         <xsl:with-param name="fieldsize">small</xsl:with-param>
			         <xsl:with-param name="type">number</xsl:with-param>
			         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
		        </xsl:call-template>   		
			    <xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_LABEL_CHARGES_AMOUNT</xsl:with-param>
					<xsl:with-param name="id">payment_charges_amount</xsl:with-param>
					<xsl:with-param name="type">amount</xsl:with-param>
					<xsl:with-param name="fieldsize">small</xsl:with-param>
					<xsl:with-param name="override-displaymode">edit</xsl:with-param>
					<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_LABEL_CHARGES_PERCENT</xsl:with-param>
					<xsl:with-param name="id">payment_charges_percent</xsl:with-param>
					<xsl:with-param name="type">number</xsl:with-param>
					<xsl:with-param name="fieldsize">small</xsl:with-param>
					<xsl:with-param name="override-displaymode">edit</xsl:with-param>
					<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
					<xsl:with-param name="id">payment_expiry_date</xsl:with-param>
					<xsl:with-param name="fieldsize">small</xsl:with-param>
					<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
					<xsl:with-param name="override-displaymode">edit</xsl:with-param>
					<xsl:with-param name="type"><xsl:if test= "$displaymode='edit'">date</xsl:if></xsl:with-param>
					<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
				</xsl:call-template>
				<!-- Applicable Law -->
				<xsl:call-template name="country-field">
					<xsl:with-param name="label">XSL_LABEL_APPLICABLE_LAW</xsl:with-param>
					<xsl:with-param name="prefix">applicable_law</xsl:with-param>
					<xsl:with-param name="override-displaymode">edit</xsl:with-param>
					<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
				</xsl:call-template>
				
				<!-- Payment Terms section -->
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_PAYMENT_TERMS_DETAILS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="toc-item" select="$toc-item" />
					<xsl:with-param name="content">
					&nbsp;
						<xsl:call-template name="build-bpo-payment-terms-dojo-items">
							<xsl:with-param name="id">payment_obligations_paymnt_terms</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
						
				<!-- End of Payment terms section -->
				<!-- Settlement terms section -->
				<xsl:choose> 
					<xsl:when test="$displaymode = 'edit'">
					<xsl:call-template name="fieldset-wrapper">
						<xsl:with-param name="legend">XSL_HEADER_SETTLEMENT_TERMS</xsl:with-param>
						<xsl:with-param name="toc-item" select="$toc-item" />
						<xsl:with-param name="content">
				          <xsl:call-template name="fieldset-wrapper">
						      	<xsl:with-param name="legend">XSL_LABEL_CREDITOR_AGENT</xsl:with-param>
						      	<xsl:with-param name="legend-type">indented-header</xsl:with-param>
						      	<xsl:with-param name="toc-item" select="$toc-item" />
				     			<xsl:with-param name="content">
			     			
				     			<xsl:call-template name="multioption-group">
				     				<xsl:with-param name="label">XSL_LABEL_CREDITOR_AGENT</xsl:with-param>
						      		<xsl:with-param name="content">
							      	<xsl:call-template name="radio-field">
								         <xsl:with-param name="label">XSL_LABEL_BIC</xsl:with-param>
								         <xsl:with-param name="name">settlement</xsl:with-param>
								         <xsl:with-param name="id">settlement_bic</xsl:with-param>
								         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
								         <xsl:with-param name="value">01</xsl:with-param>
								         <xsl:with-param name="readonly">N</xsl:with-param>
								         <xsl:with-param name="checked">N</xsl:with-param>
							        </xsl:call-template>
							        <div id="CreditorAgentBIC" style="display:none">
								        <xsl:call-template name="input-field">
									         <xsl:with-param name="label">XSL_PURCHASE_ORDER_SUBMITTER_BIC</xsl:with-param>
									         <xsl:with-param name="id">creditor_agent_bic</xsl:with-param>
									         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
									         <xsl:with-param name="fieldsize">small</xsl:with-param>
									         <xsl:with-param name="type">text</xsl:with-param>
									         <xsl:with-param name="maxsize">11</xsl:with-param>
									         <xsl:with-param name="required">Y</xsl:with-param>
									         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								        </xsl:call-template>
							        </div>
							        <xsl:call-template name="radio-field">
								         <xsl:with-param name="label">XSL_LABEL_NAME_AND_ADDRESS</xsl:with-param>
								         <xsl:with-param name="name">settlement</xsl:with-param>
								         <xsl:with-param name="id">settlement_name_address</xsl:with-param>
								         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
								         <xsl:with-param name="value">02</xsl:with-param>
								         <xsl:with-param name="readonly">N</xsl:with-param>
								         <xsl:with-param name="checked">N</xsl:with-param>
							        </xsl:call-template>
							        <div id="CreditorAgentName" style="display:none">
								        <xsl:call-template name="input-field">
									         <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_NAME</xsl:with-param>
									         <xsl:with-param name="id">creditor_agent_name</xsl:with-param>
									         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
									         <xsl:with-param name="fieldsize">small</xsl:with-param>
									         <xsl:with-param name="type">text</xsl:with-param>
									         <xsl:with-param name="maxsize">70</xsl:with-param>
									         <xsl:with-param name="required">Y</xsl:with-param>
									         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								        </xsl:call-template>
								         <xsl:call-template name="input-field">
									         <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_STREET</xsl:with-param>
									         <xsl:with-param name="id">creditor_street_name</xsl:with-param>
									         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
									         <xsl:with-param name="fieldsize">small</xsl:with-param>
									         <xsl:with-param name="type">text</xsl:with-param>
									         <xsl:with-param name="maxsize">70</xsl:with-param>
									         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								        </xsl:call-template>
								        <xsl:call-template name="input-field">
									         <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_POST_CODE</xsl:with-param>
									         <xsl:with-param name="id">creditor_post_code_identification</xsl:with-param>
									         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
									         <xsl:with-param name="fieldsize">small</xsl:with-param>
									         <xsl:with-param name="type">text</xsl:with-param>
									         <xsl:with-param name="maxsize">16</xsl:with-param>
									         <xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
									         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								        </xsl:call-template>
								        <xsl:call-template name="input-field">
									         <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_TOWN</xsl:with-param>
									         <xsl:with-param name="id">creditor_town_name</xsl:with-param>
									         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
									         <xsl:with-param name="fieldsize">small</xsl:with-param>
									         <xsl:with-param name="type">text</xsl:with-param>
									         <xsl:with-param name="maxsize">35</xsl:with-param>
									         <xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
									         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								        </xsl:call-template>
								        <xsl:call-template name="input-field">
									         <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION</xsl:with-param>
									         <xsl:with-param name="id">creditor_country_sub_div</xsl:with-param>
									         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
									         <xsl:with-param name="fieldsize">small</xsl:with-param>
									         <xsl:with-param name="type">text</xsl:with-param>
									         <xsl:with-param name="maxsize">35</xsl:with-param>
									         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								        </xsl:call-template>
								        <xsl:call-template name="country-field">
											<xsl:with-param name="prefix">creditor</xsl:with-param>
											<xsl:with-param name="required">Y</xsl:with-param>
											<xsl:with-param name="override-displaymode">edit</xsl:with-param>
											<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										</xsl:call-template>
									</div>
									</xsl:with-param>
					        	</xsl:call-template>
					        		
					        	<xsl:call-template name="fieldset-wrapper">
							      	<xsl:with-param name="legend">XSL_LABEL_CREDITOR_ACCOUNT</xsl:with-param>
							      	<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							      	<xsl:with-param name="toc-item" select="$toc-item" />
					      			<xsl:with-param name="content">	
									<xsl:call-template name="multioption-group">
									      	<xsl:with-param name="group-label">XSL_CREDITOR_ACCOUNT_ID_TYPE</xsl:with-param>
									      	<xsl:with-param name="content">
									      	<xsl:call-template name="radio-field">
										         <xsl:with-param name="label">XSL_PURCHASE_ORDER_ACCOUNT_TYPE_IBAN</xsl:with-param>
										         <xsl:with-param name="name">creditor_account_type</xsl:with-param>
										         <xsl:with-param name="id">creditor_account_iban</xsl:with-param>
										         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
										         <xsl:with-param name="value">01</xsl:with-param>
										         <xsl:with-param name="readonly">N</xsl:with-param>
										         <xsl:with-param name="checked">N</xsl:with-param>
									        </xsl:call-template>
									        <xsl:call-template name="input-field">
										         <xsl:with-param name="label"></xsl:with-param>
										         <xsl:with-param name="id">creditor_account_id_iban</xsl:with-param>
										         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
										         <xsl:with-param name="value"></xsl:with-param>
										         <xsl:with-param name="fieldsize">small</xsl:with-param>
										         <xsl:with-param name="type">text</xsl:with-param>
										         <xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
										         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									        </xsl:call-template>
									        <xsl:call-template name="radio-field">
										         <xsl:with-param name="label">XSL_PURCHASE_ORDER_ACCOUNT_TYPE_BBAN</xsl:with-param>
										         <xsl:with-param name="name">creditor_account_type</xsl:with-param>
										         <xsl:with-param name="id">creditor_account_bban</xsl:with-param>
										         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
										         <xsl:with-param name="value">02</xsl:with-param>
										         <xsl:with-param name="readonly">N</xsl:with-param>
										         <xsl:with-param name="checked">N</xsl:with-param>
									        </xsl:call-template>
									        <xsl:call-template name="input-field">
										         <xsl:with-param name="label"></xsl:with-param>
										         <xsl:with-param name="id">creditor_account_id_bban</xsl:with-param>
										         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
										         <xsl:with-param name="value"></xsl:with-param>
										         <xsl:with-param name="fieldsize">small</xsl:with-param>
										         <xsl:with-param name="type">text</xsl:with-param>
										         <xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
										         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									        </xsl:call-template>
									        <xsl:call-template name="radio-field">
										         <xsl:with-param name="label">XSL_PURCHASE_ORDER_ACCOUNT_TYPE_UPIC</xsl:with-param>
										         <xsl:with-param name="name">creditor_account_type</xsl:with-param>
										         <xsl:with-param name="id">creditor_account_upic</xsl:with-param>
										         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
										         <xsl:with-param name="value">03</xsl:with-param>
										         <xsl:with-param name="readonly">N</xsl:with-param>
										         <xsl:with-param name="checked">N</xsl:with-param>
									        </xsl:call-template>
									        <xsl:call-template name="input-field">
										         <xsl:with-param name="label"></xsl:with-param>
										         <xsl:with-param name="id">creditor_account_id_upic</xsl:with-param>
										         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
										         <xsl:with-param name="value"></xsl:with-param>
										         <xsl:with-param name="fieldsize">small</xsl:with-param>
										         <xsl:with-param name="type">text</xsl:with-param>
										         <xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
										         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									        </xsl:call-template>
									        <xsl:call-template name="radio-field">
										         <xsl:with-param name="label">XSL_PURCHASE_ORDER_ACCOUNT_TYPE_OTHER</xsl:with-param>
										         <xsl:with-param name="name">creditor_account_type</xsl:with-param>
										         <xsl:with-param name="id">creditor_account_prop</xsl:with-param>
										         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
										         <xsl:with-param name="value">04</xsl:with-param>
										         <xsl:with-param name="readonly">N</xsl:with-param>
										         <xsl:with-param name="checked">N</xsl:with-param>
									        </xsl:call-template>
									        <xsl:call-template name="input-field">
										         <xsl:with-param name="label"></xsl:with-param>
										         <xsl:with-param name="id">creditor_account_id_prop</xsl:with-param>
										         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
										         <xsl:with-param name="value"></xsl:with-param>
										         <xsl:with-param name="maxsize">34</xsl:with-param>
										         <xsl:with-param name="fieldsize">small</xsl:with-param>
										         <xsl:with-param name="type">text</xsl:with-param>
										         <xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
										         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									        </xsl:call-template>
								        </xsl:with-param>
							        </xsl:call-template>
							        <xsl:call-template name="multioption-group">
								      <xsl:with-param name="group-label">XSL_CREDITOR_ACCOUNT_TYPE</xsl:with-param>
								      <xsl:with-param name="content">
											    <xsl:call-template name="radio-field">
											         <xsl:with-param name="label">XSL_CREDITOR_ACCOUNT_TYPE_CODE</xsl:with-param>
											         <xsl:with-param name="name">creditor_act_type_code</xsl:with-param>
											         <xsl:with-param name="id">creditor_act_type_code</xsl:with-param>
											         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
											         <xsl:with-param name="value">01</xsl:with-param>
											         <xsl:with-param name="readonly">N</xsl:with-param>
											         <xsl:with-param name="checked">N</xsl:with-param>
										        </xsl:call-template>
												<xsl:call-template name="select-field">
											         <xsl:with-param name="label"></xsl:with-param>
											         <xsl:with-param name="id">creditor_account_type_code</xsl:with-param>
											         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
											         <xsl:with-param name="options">
											         	<xsl:call-template name="creditor_account_type_codes" >
															 <xsl:with-param name="field-name">creditor_account_type_code</xsl:with-param>
														</xsl:call-template>
											         </xsl:with-param>
											         <xsl:with-param name="fieldsize">small</xsl:with-param>
											         <xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
											         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								        		</xsl:call-template>
										        <xsl:call-template name="radio-field">
											         <xsl:with-param name="label">XSL_BPO_LABEL_PROPRIETARY</xsl:with-param>
											         <xsl:with-param name="name">creditor_act_type_code</xsl:with-param>
											         <xsl:with-param name="id">creditor_act_type_prop</xsl:with-param>
											         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
											         <xsl:with-param name="value">02</xsl:with-param>
											         <xsl:with-param name="readonly">N</xsl:with-param>
											         <xsl:with-param name="checked">N</xsl:with-param>
										        </xsl:call-template>
										        <xsl:call-template name="input-field">
											         <xsl:with-param name="label"></xsl:with-param>
											         <xsl:with-param name="id">creditor_account_type_prop</xsl:with-param>
											         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
											         <xsl:with-param name="value"></xsl:with-param>
											         <xsl:with-param name="fieldsize">small</xsl:with-param>
											        <xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
											         <xsl:with-param name="type">text</xsl:with-param>
											         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										        </xsl:call-template>
								      </xsl:with-param>
								    </xsl:call-template>
								    <xsl:call-template name="input-field">
					         			 <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
								         <xsl:with-param name="name">creditor_account_name</xsl:with-param>
								         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
								         <xsl:with-param name="value"></xsl:with-param>
								         <xsl:with-param name="type">text</xsl:with-param>
								         <xsl:with-param name="fieldsize">small</xsl:with-param>
								         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							        </xsl:call-template>
							        <xsl:call-template name="currency-field">
										<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_CURRENCY</xsl:with-param>
										<xsl:with-param name="name">creditor_account_cur_code</xsl:with-param>
										<xsl:with-param name="override-currency-name">creditor_account_cur_code</xsl:with-param>
										<xsl:with-param name="show-button">Y</xsl:with-param>
										<xsl:with-param name="show-amt">N</xsl:with-param>
										<xsl:with-param name="product-code">creditor_account</xsl:with-param>
										<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									</xsl:call-template>
							     </xsl:with-param>
						      </xsl:call-template>
						      </xsl:with-param>
						     </xsl:call-template>
						    </xsl:with-param>
						   </xsl:call-template>
					       </xsl:when>
					       <xsl:otherwise>
					       		<xsl:if test="bank_payment_obligation/PmtOblgtn/SttlmTerms/CdtrAgt/BIC !='' or bank_payment_obligation/PmtOblgtn/SttlmTerms/CdtrAgt/NmAndAdr/Nm != '' or bank_payment_obligation/PmtOblgtn/SttlmTerms/CdtrAcct/Tp/Cd !='' or bank_payment_obligation/PmtOblgtn/SttlmTerms/CdtrAcct/Ccy != ''">
					       		<xsl:call-template name="fieldset-wrapper">
									<xsl:with-param name="legend">XSL_HEADER_SETTLEMENT_TERMS</xsl:with-param>
									<xsl:with-param name="toc-item" select="$toc-item" />
									<xsl:with-param name="content">
									<xsl:if test="bank_payment_obligation/PmtOblgtn/SttlmTerms/CdtrAgt/BIC !='' or bank_payment_obligation/PmtOblgtn/SttlmTerms/CdtrAgt/NmAndAdr/Nm != ''">
							          <xsl:call-template name="fieldset-wrapper">
									      	<xsl:with-param name="legend">XSL_LABEL_CREDITOR_AGENT</xsl:with-param>
									      	<xsl:with-param name="legend-type">indented-header</xsl:with-param>
									      	<xsl:with-param name="toc-item" select="$toc-item" />
							     			<xsl:with-param name="content">
									     		<xsl:call-template name="input-field">
											         <xsl:with-param name="label">XSL_PURCHASE_ORDER_SUBMITTER_BIC</xsl:with-param>
											         <xsl:with-param name="id">creditor_agent_bic</xsl:with-param>
											         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
											         <xsl:with-param name="fieldsize">small</xsl:with-param>
											         <xsl:with-param name="type">text</xsl:with-param>
											         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										        </xsl:call-template>
										        <xsl:call-template name="input-field">
											         <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_NAME</xsl:with-param>
											         <xsl:with-param name="id">creditor_agent_name</xsl:with-param>
											         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
											         <xsl:with-param name="fieldsize">small</xsl:with-param>
											         <xsl:with-param name="type">text</xsl:with-param>
											         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										        </xsl:call-template>
										         <xsl:call-template name="input-field">
											         <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_STREET</xsl:with-param>
											         <xsl:with-param name="id">creditor_street_name</xsl:with-param>
											         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
											         <xsl:with-param name="fieldsize">small</xsl:with-param>
											         <xsl:with-param name="type">text</xsl:with-param>
											         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										        </xsl:call-template>
										        <xsl:call-template name="input-field">
											         <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_POST_CODE</xsl:with-param>
											         <xsl:with-param name="id">creditor_post_code_identification</xsl:with-param>
											         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
											         <xsl:with-param name="fieldsize">small</xsl:with-param>
											         <xsl:with-param name="type">text</xsl:with-param>
											         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										        </xsl:call-template>
										        <xsl:call-template name="input-field">
											         <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_TOWN</xsl:with-param>
											         <xsl:with-param name="id">creditor_town_name</xsl:with-param>
											         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
											         <xsl:with-param name="fieldsize">small</xsl:with-param>
											         <xsl:with-param name="type">text</xsl:with-param>
											         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										        </xsl:call-template>
										        <xsl:call-template name="input-field">
											         <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION</xsl:with-param>
											         <xsl:with-param name="id">creditor_country_sub_div</xsl:with-param>
											         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
											         <xsl:with-param name="fieldsize">small</xsl:with-param>
											         <xsl:with-param name="type">text</xsl:with-param>
											         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										        </xsl:call-template>
										        <xsl:call-template name="country-field">
													<xsl:with-param name="prefix">creditor</xsl:with-param>
													<xsl:with-param name="override-displaymode">edit</xsl:with-param>
													<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
												</xsl:call-template>
							     			</xsl:with-param>
							     		</xsl:call-template>
							     	</xsl:if>
							     	<xsl:if test="bank_payment_obligation/PmtOblgtn/SttlmTerms/CdtrAcct/Tp/Cd !='' or bank_payment_obligation/PmtOblgtn/SttlmTerms/CdtrAcct/Tp/Prtry !='' or bank_payment_obligation/PmtOblgtn/SttlmTerms/CdtrAcct/Ccy != ''">	
							     		<xsl:call-template name="fieldset-wrapper">
									      	<xsl:with-param name="legend">XSL_LABEL_CREDITOR_ACCOUNT</xsl:with-param>
									      	<xsl:with-param name="legend-type">indented-header</xsl:with-param>
									      	<xsl:with-param name="toc-item" select="$toc-item" />
							      			<xsl:with-param name="content">	
									       		<xsl:call-template name="input-field">
											         <xsl:with-param name="label">XSL_PURCHASE_ORDER_ACCOUNT_TYPE_IBAN_LABEL</xsl:with-param>
											         <xsl:with-param name="id">creditor_account_id_iban</xsl:with-param>
											         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
											         <xsl:with-param name="value"></xsl:with-param>
											         <xsl:with-param name="fieldsize">small</xsl:with-param>
											         <xsl:with-param name="type">text</xsl:with-param>
											         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										        </xsl:call-template>
										        <xsl:call-template name="input-field">
											         <xsl:with-param name="label">XSL_PURCHASE_ORDER_ACCOUNT_TYPE_BBAN_LABEL</xsl:with-param>
											         <xsl:with-param name="id">creditor_account_id_bban</xsl:with-param>
											         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
											         <xsl:with-param name="value"></xsl:with-param>
											         <xsl:with-param name="fieldsize">small</xsl:with-param>
											         <xsl:with-param name="type">text</xsl:with-param>
											         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										        </xsl:call-template>
										        <xsl:call-template name="input-field">
											         <xsl:with-param name="label">XSL_PURCHASE_ORDER_ACCOUNT_TYPE_UPIC_LABEL</xsl:with-param>
											         <xsl:with-param name="id">creditor_account_id_upic</xsl:with-param>
											         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
											         <xsl:with-param name="value"></xsl:with-param>
											         <xsl:with-param name="fieldsize">small</xsl:with-param>
											         <xsl:with-param name="type">text</xsl:with-param>
											         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										        </xsl:call-template>
										        <xsl:call-template name="input-field">
											         <xsl:with-param name="label">XSL_PURCHASE_ORDER_ACCOUNT_TYPE_OTHER_LABEL</xsl:with-param>
											         <xsl:with-param name="id">creditor_account_id_prop</xsl:with-param>
											         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
											         <xsl:with-param name="value"></xsl:with-param>
											         <xsl:with-param name="fieldsize">small</xsl:with-param>
											         <xsl:with-param name="type">text</xsl:with-param>
											         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										        </xsl:call-template>
								        		<xsl:call-template name="input-field">
											         <xsl:with-param name="label">XSL_CREDITOR_ACCOUNT_TYPE_CODE_LABEL</xsl:with-param>
											         <xsl:with-param name="id">creditor_account_type_code</xsl:with-param>
											         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
											         <xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N217', creditor_account_type_code)"/></xsl:with-param>
								        			<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								        		</xsl:call-template>
										     	<xsl:call-template name="input-field">
											         <xsl:with-param name="label">XSL_BPO_PROPRIETARY</xsl:with-param>
											         <xsl:with-param name="id">creditor_account_type_prop</xsl:with-param>
											         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
											         <xsl:with-param name="value"></xsl:with-param>
											         <xsl:with-param name="fieldsize">small</xsl:with-param>
											         <xsl:with-param name="type">text</xsl:with-param>
											         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										        </xsl:call-template>
								      </xsl:with-param>
								    </xsl:call-template>
								    <xsl:call-template name="input-field">
					         			 <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
								         <xsl:with-param name="name">creditor_account_name</xsl:with-param>
								         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
								         <xsl:with-param name="value"></xsl:with-param>
								         <xsl:with-param name="type">text</xsl:with-param>
								         <xsl:with-param name="fieldsize">small</xsl:with-param>
								         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							        </xsl:call-template>
									<xsl:call-template name="input-field">
										<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_CURRENCY</xsl:with-param>
										<xsl:with-param name="name">creditor_account_cur_code</xsl:with-param>
										<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										<xsl:with-param name="override-displaymode">edit</xsl:with-param>
										<xsl:with-param name="fieldsize">small</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
						     </xsl:with-param>
						 </xsl:call-template>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
					   
			<div class="dijitDialogPaneActionBar">
				<xsl:call-template name="label-wrapper">
					<xsl:with-param name="content">
						<button type="button" dojoType="dijit.form.Button">
							<xsl:attribute name="onmouseup">dijit.byId('bank-payment-obligation-details-dialog-template').hide();</xsl:attribute>
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
						</button>
						<xsl:if test="$displaymode = 'edit'">							
						<button dojoType="dijit.form.Button">
							<xsl:attribute name="onClick">dijit.byId('bank-payment-obligation-details-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
						</button>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</div>
			</div>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Build Bank Payment Obligation details</xd:short>
		<xd:detail>
			This templates displays header for diplaying BPO Dataset in add,edit and view mode,also displayes header obligor bank and recipient bank bic in the table.
			It also adds attributes for different fields and fills it with given selected value.
 		</xd:detail>
 		<xd:param name="items"> Items to be build in form to display </xd:param>
 		<xd:param name="override-displaymode">Overridden display mode.</xd:param>		
 	</xd:doc>
	<xsl:template name="build-bank-payment-obligation-details-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
		<div dojoType="misys.openaccount.widget.PaymentObligations" dialogId="bank-payment-obligation-details-dialog-template" id="bank-payment-obligations">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ADD_BPO_DATASET')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_EDIT_BPO_DATASET')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_VIEW_BPO_DATASET')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of
						select="localization:getGTPString($language, 'XSL_HEADER_PURCHASE_ORDER_OBLIGOR_BANK_BIC')" />,
				<xsl:value-of
						select="localization:getGTPString($language, 'XSL_HEADER_PURCHASE_ORDER_RECIPIENT_BANK_BIC')" />,
			</xsl:attribute>
			<xsl:for-each select="$items">
				<xsl:variable name="paymentOblg" select="." />
				<div dojoType="misys.openaccount.widget.PaymentObligation">
				<xsl:attribute name="buyer_bank_bpo"><xsl:value-of
						select="$paymentOblg/buyer_bank_bpo" /></xsl:attribute>
				<xsl:attribute name="obligor_bank"><xsl:value-of
						select="$paymentOblg/OblgrBk/BIC" /></xsl:attribute>
				<xsl:attribute name="recipient_bank"><xsl:value-of
						select="$paymentOblg/RcptBk/BIC" /></xsl:attribute>
				<xsl:attribute name="payment_obligation_amount"><xsl:value-of
						select="$paymentOblg/Amt" /></xsl:attribute>
				<xsl:attribute name="payment_obligation_percent"><xsl:value-of
						select="$paymentOblg/Pctg" /></xsl:attribute>
				<xsl:attribute name="payment_charges_amount"><xsl:value-of select="$paymentOblg/ChrgsAmt"/></xsl:attribute>
				<xsl:attribute name="payment_charges_percent"><xsl:value-of select="$paymentOblg/ChrgsPctg"/></xsl:attribute>
				<xsl:attribute name="payment_expiry_date">
					<xsl:choose>
						<xsl:when test="$paymentOblg/XpryDt[.!='']">
							<xsl:value-of select="concat(substring($paymentOblg/XpryDt,9,2),'/',substring($paymentOblg/XpryDt,6,2),'/',substring($paymentOblg/XpryDt,1,4))"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of select="$paymentOblg/XpryDt"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
				<xsl:attribute name="applicable_law_country"><xsl:value-of
						select="$paymentOblg/AplblLaw" /></xsl:attribute>
				<xsl:attribute name="creditor_agent_bic"><xsl:value-of
						select="$paymentOblg/SttlmTerms/CdtrAgt/BIC" /></xsl:attribute>
				<xsl:attribute name="creditor_agent_name"><xsl:value-of
						select="$paymentOblg/SttlmTerms/CdtrAgt/NmAndAdr/Nm" /></xsl:attribute>
				<xsl:attribute name="creditor_street_name"><xsl:value-of
						select="$paymentOblg/SttlmTerms/CdtrAgt/NmAndAdr/Adr/StrtNm" /></xsl:attribute>
				<xsl:attribute name="creditor_post_code_identification"><xsl:value-of
						select="$paymentOblg/SttlmTerms/CdtrAgt/NmAndAdr/Adr/PstCdId" /></xsl:attribute>
				<xsl:attribute name="creditor_town_name"><xsl:value-of
						select="$paymentOblg/SttlmTerms/CdtrAgt/NmAndAdr/Adr/TwnNm" /></xsl:attribute>
				<xsl:attribute name="creditor_country_sub_div"><xsl:value-of
						select="$paymentOblg/SttlmTerms/CdtrAgt/NmAndAdr/Adr/CtrySubDvsn" /></xsl:attribute>
				<xsl:attribute name="creditor_country"><xsl:value-of
						select="$paymentOblg/SttlmTerms/CdtrAgt/NmAndAdr/Adr/Ctry" /></xsl:attribute>
				
				<xsl:attribute name="creditor_account_type_code"><xsl:value-of
						select="$paymentOblg/SttlmTerms/CdtrAcct/Tp/Cd" /></xsl:attribute>
				<xsl:attribute name="creditor_account_type_prop"><xsl:value-of
						select="$paymentOblg/SttlmTerms/CdtrAcct/Tp/Prtry" /></xsl:attribute>
				<xsl:attribute name="creditor_account_id_iban"><xsl:value-of
						select="$paymentOblg/SttlmTerms/CdtrAcct/Id/IBAN" /></xsl:attribute>
				<xsl:attribute name="creditor_account_id_bban"><xsl:value-of
						select="$paymentOblg/SttlmTerms/CdtrAcct/Id/BBAN" /></xsl:attribute>
				<xsl:attribute name="creditor_account_id_upic"><xsl:value-of
						select="$paymentOblg/SttlmTerms/CdtrAcct/Id/UPIC" /></xsl:attribute>
				<xsl:attribute name="creditor_account_id_prop"><xsl:value-of
						select="$paymentOblg/SttlmTerms/CdtrAcct/Id/PrtryAcct/Id" /></xsl:attribute>
				<xsl:attribute name="creditor_account_cur_code"><xsl:value-of
						select="$paymentOblg/SttlmTerms/CdtrAcct/Ccy" /></xsl:attribute>
				<xsl:attribute name="creditor_account_name"><xsl:value-of
						select="$paymentOblg/SttlmTerms/CdtrAcct/Nm" /></xsl:attribute>
				
				<xsl:attribute name="settlement_bic">
					<xsl:if test="$paymentOblg/SttlmTerms/CdtrAgt/BIC[.!= '']">01</xsl:if>
				</xsl:attribute>
				<xsl:attribute name="settlement_name_address">
					<xsl:if test="$paymentOblg/SttlmTerms/CdtrAgt/NmAndAdr/Nm[.!= '']">02</xsl:if>
				</xsl:attribute>
				<xsl:attribute name="creditor_account_iban">
					<xsl:if test="$paymentOblg/SttlmTerms/CdtrAcct/Id/IBAN[.!= '']">01</xsl:if>
				</xsl:attribute>
				<xsl:attribute name="creditor_account_bban">
					<xsl:if test="$paymentOblg/SttlmTerms/CdtrAcct/Id/BBAN[.!= '']">02</xsl:if>
				</xsl:attribute>
				<xsl:attribute name="creditor_account_upic">
					<xsl:if test="$paymentOblg/SttlmTerms/CdtrAcct/Id/UPIC[.!= '']">03</xsl:if>
				</xsl:attribute>
				<xsl:attribute name="creditor_account_prop">
					<xsl:if test="$paymentOblg/SttlmTerms/CdtrAcct/Id/PrtryAcct/Id[.!= '']">04</xsl:if>
				</xsl:attribute>
				<xsl:attribute name="creditor_act_type_code">
					<xsl:if test="$paymentOblg/SttlmTerms/CdtrAcct/Tp/Cd[.!= '']">01</xsl:if>
				</xsl:attribute>
				<xsl:attribute name="creditor_act_type_prop">
					<xsl:if test="$paymentOblg/SttlmTerms/CdtrAcct/Tp/Prtry[.!= '']">02</xsl:if>
				</xsl:attribute>
				<xsl:if test="./PmtTerms[.!='']">
				<div dojoType="misys.openaccount.widget.BpoPaymentTerms">
					<xsl:apply-templates select="PmtTerms"/>
				</div>
				</xsl:if>
				</div>
			</xsl:for-each>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Payment terms</xd:short>
		<xd:detail>
			This templates adds attributes for different fields and fills it with given selected value.
 		</xd:detail>	
 	</xd:doc>
	<xsl:template match="PmtTerms">
		<div dojoType="misys.openaccount.widget.BpoPaymentTerm">
			<xsl:attribute name="payment_code"><xsl:value-of select="PmtCd/Cd"/></xsl:attribute>
			<xsl:attribute name="payment_nb_days"><xsl:value-of select="PmtCd/NbOfDays"/></xsl:attribute>
			
			<xsl:attribute name="payment_other_term"><xsl:value-of select="OthrPmtTerms"/></xsl:attribute>
			<xsl:attribute name="payment_amount"><xsl:value-of select="Amt"/></xsl:attribute>
			<xsl:attribute name="payment_percent"><xsl:value-of select="Pctg"/></xsl:attribute>
			<xsl:attribute name="pmt_code">
					<xsl:if test="PmtTerms/PmtCd/Cd[.!='']">01</xsl:if>
				</xsl:attribute>
				<xsl:attribute name="pmt_other_term_code">
					<xsl:if test="PmtTerms/OthrPmtTerms[.!='']">02</xsl:if>
				</xsl:attribute>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>BPO Payment term dialog declaration</xd:short>
		<xd:detail>
			This templates adds attributes and fills it with Confirmation value,also sets parameters of different template called under this,adds OK and CANCEL button in BPO payment term dialog.
 		</xd:detail>	
 	</xd:doc>
	<xsl:template name="bpo-payment-terms-dialog-declaration">
		<div id="bpo-payment-terms-dialog-template" style="display:none"
			class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
			<div id="bpo-payment-terms-dialog-template-content" class="standardPODialogContent" >
					<div>
						<xsl:choose>
							 <xsl:when test="$displaymode='view' ">
							    <xsl:if test="bank_payment_obligation/PmtOblgtn/PmtTerms/Amt[.!='']">
									<xsl:call-template name="input-field">
										<xsl:with-param name="label">XSL_DETAILS_PO_PAYMENT_AMT</xsl:with-param>
										<xsl:with-param name="id">payment_amount</xsl:with-param>
										<xsl:with-param name="override-displaymode">view</xsl:with-param>
										<xsl:with-param name="value"><xsl:value-of select="bank_payment_obligation/PmtOblgtn/PmtTerms/Amt"></xsl:value-of></xsl:with-param>
										<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
								<xsl:if test="bank_payment_obligation/PmtOblgtn/PmtTerms/Pctg[.!='']">
									<xsl:call-template name="input-field">
										<xsl:with-param name="label">XSL_DETAILS_PO_PAYMENT_PERCENTAGE</xsl:with-param>
										<xsl:with-param name="id">payment_percent</xsl:with-param>
										<xsl:with-param name="override-displaymode">view</xsl:with-param>
										<xsl:with-param name="value"><xsl:value-of select="bank_payment_obligation/PmtOblgtn/PmtTerms/Pctg"></xsl:value-of></xsl:with-param>
										<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
								<xsl:if test="bank_payment_obligation/PmtOblgtn/PmtTerms/PmtCd/Cd[.!='']">
									<xsl:variable name="code_type"><xsl:value-of select="bank_payment_obligation/PmtOblgtn/PmtTerms/PmtCd/Cd"></xsl:value-of></xsl:variable>
									<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
									<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
									<xsl:variable name="parameterId">C020</xsl:variable>
										<xsl:call-template name="input-field">
										 	<xsl:with-param name="label">XSL_LABEL_PAYMENT_CODE</xsl:with-param>
										 	<xsl:with-param name="name">payment_code</xsl:with-param>
										 	<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $code_type)"/></xsl:with-param>
										 	<xsl:with-param name="override-displaymode">view</xsl:with-param>	
										</xsl:call-template>
								</xsl:if>
								<xsl:if test="bank_payment_obligation/PmtOblgtn/PmtTerms/PmtTerms/PmtCd/NbOfDays[.!='']">
									<xsl:call-template name="input-field">
							         <xsl:with-param name="label">XSL_LABEL_NO_OF_DAYS</xsl:with-param>
							         <xsl:with-param name="id">payment_nb_days</xsl:with-param>
							         <xsl:with-param name="override-displaymode">view</xsl:with-param>
							         <xsl:with-param name="value"><xsl:value-of select="bank_payment_obligation/PmtOblgtn/PmtTerms/PmtCd/NbOfDays"></xsl:value-of></xsl:with-param>
							         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
						        	</xsl:call-template>
						        </xsl:if>
								<xsl:if test="bank_payment_obligation/PmtOblgtn/PmtTerms/OthrPmtTerms[.!='']">
									<xsl:call-template name="input-field">
										<xsl:with-param name="label">XSL_LABEL_OTHER_PAYMENT_TERMS</xsl:with-param>
										<xsl:with-param name="id">payment_other_term</xsl:with-param>
										<xsl:with-param name="override-displaymode">view</xsl:with-param>
										<xsl:with-param name="value"><xsl:value-of select="bank_payment_obligation/PmtOblgtn/PmtTerms/OthrPmtTerms"></xsl:value-of></xsl:with-param>
										<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
									</xsl:call-template>
								</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="input-field">
						         <xsl:with-param name="label">XSL_DETAILS_PO_PAYMENT_AMT</xsl:with-param>
						         <xsl:with-param name="id">payment_amount</xsl:with-param>
						         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
						         <xsl:with-param name="required">Y</xsl:with-param>
						         <xsl:with-param name="type">amount</xsl:with-param>
						         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
					        </xsl:call-template>
					        <xsl:call-template name="input-field">
						         <xsl:with-param name="label">XSL_DETAILS_PO_PAYMENT_PERCENTAGE</xsl:with-param>
						         <xsl:with-param name="id">payment_percent</xsl:with-param>
						         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
						          <xsl:with-param name="type">number</xsl:with-param>
						         <xsl:with-param name="required">Y</xsl:with-param>
						         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
					        </xsl:call-template>
						<xsl:call-template name="multioption-group">
					      <xsl:with-param name="group-label">XSL_GENERALDETAILS_TENOR_IC_LABEL</xsl:with-param>
					      <xsl:with-param name="content">
							    <xsl:call-template name="radio-field">
							         <xsl:with-param name="label">CODE</xsl:with-param>
							         <xsl:with-param name="name">payment</xsl:with-param>
							         <xsl:with-param name="id">pmt_code</xsl:with-param>
							         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
							         <xsl:with-param name="value">01</xsl:with-param>
							         <xsl:with-param name="readonly">N</xsl:with-param>
							         <xsl:with-param name="checked">N</xsl:with-param>
						        </xsl:call-template>
						        <div id="paymentCode">
									<xsl:call-template name="select-field">
								         <xsl:with-param name="label">XSL_LABEL_PAYMENT_CODE</xsl:with-param>
								         <xsl:with-param name="id">payment_code</xsl:with-param>
								         <xsl:with-param name="fieldsize">small</xsl:with-param>
								         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
								         <xsl:with-param name="required">Y</xsl:with-param>
								         <xsl:with-param name="options">
											<xsl:call-template name="payment_term_code_options"/>
										</xsl:with-param>
							        </xsl:call-template>
							        <xsl:call-template name="input-field">
								         <xsl:with-param name="label">XSL_LABEL_NO_OF_DAYS</xsl:with-param>
								         <xsl:with-param name="id">payment_nb_days</xsl:with-param>
								         <xsl:with-param name="fieldsize">small</xsl:with-param>
								         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
								         <xsl:with-param name="value"></xsl:with-param>
								         <xsl:with-param name="size">18</xsl:with-param>
								         <xsl:with-param name="maxsize">18</xsl:with-param>
								         <xsl:with-param name="regular-expression">^([1-9]\d*|0){1,18}</xsl:with-param>
								         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							        </xsl:call-template>
						        </div>
						        <xsl:call-template name="radio-field">
							         <xsl:with-param name="label">XSL_LABEL_OTHER_PAYMENT_TERMS</xsl:with-param>
							         <xsl:with-param name="name">payment</xsl:with-param>
							         <xsl:with-param name="id">pmt_other_term_code</xsl:with-param>
							         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
							         <xsl:with-param name="value">02</xsl:with-param>
							         <xsl:with-param name="readonly">N</xsl:with-param>
							         <xsl:with-param name="checked">N</xsl:with-param>
						        </xsl:call-template>
						        <xsl:call-template name="input-field">
							         <xsl:with-param name="label"></xsl:with-param>
							         <xsl:with-param name="id">payment_other_term</xsl:with-param>
							         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
							         <xsl:with-param name="value"></xsl:with-param>
							         <xsl:with-param name="required">Y</xsl:with-param>
							         <xsl:with-param name="fieldsize">small</xsl:with-param>
							         <xsl:with-param name="type">text</xsl:with-param>
							         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							         <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						        </xsl:call-template>   		
					      </xsl:with-param>
					    </xsl:call-template>
						</xsl:otherwise>
							</xsl:choose>
						<div class="dijitDialogPaneActionBar">
						<xsl:call-template name="label-wrapper">
							<xsl:with-param name="content">
								<button type="button" dojoType="dijit.form.Button">
									<xsl:attribute name="onmouseup">dijit.byId('bpo-payment-terms-dialog-template').hide();</xsl:attribute>
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
								</button>							
								<xsl:if test="$displaymode = 'edit'">
									<button dojoType="dijit.form.Button">
										<xsl:attribute name="onClick">dijit.byId('bpo-payment-terms-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
									</button>
								</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
						</div>
					</div>
				</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Payment Term dialog declaration</xd:short>
		<xd:detail>
			This template adds different parameter(such as label,value,size etc) for different template called inside this,
			Also adds CANCEL and OK button at the end of dialog
 		</xd:detail>
 	</xd:doc>
	<xsl:template name="payment-term-dialog-declaration">
		<div id="payment-term-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
			<div class="standardPODialogContent">
				<div>
					<xsl:choose>
						<xsl:when test="$displaymode='edit'">
							<xsl:call-template name="currency-field">
								<xsl:with-param name="label">XSL_DETAILS_PO_PAYMENT_AMT</xsl:with-param>
								<xsl:with-param name="override-currency-name">details_cur_code</xsl:with-param>
								<xsl:with-param name="override-amt-name">details_amt</xsl:with-param>
								<xsl:with-param name="override-displaymode">edit</xsl:with-param>
								<xsl:with-param name="currency-readonly">Y</xsl:with-param>
								<xsl:with-param name="show-button">N</xsl:with-param>
								<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
								<xsl:with-param name="regular-expression">^(?:\d{1,18}|(?=.*\.)(?!.*\..*\.)[\d.]{1,19})$</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="currency-field">
								<xsl:with-param name="label">XSL_DETAILS_PO_PAYMENT_AMT</xsl:with-param>
								<xsl:with-param name="override-currency-name">details_cur_code</xsl:with-param>
								<xsl:with-param name="override-amt-name">details_amt</xsl:with-param>
								<xsl:with-param name="show-button">N</xsl:with-param>
								<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								<xsl:with-param name="currency-readonly">Y</xsl:with-param>
								<xsl:with-param name="override-currency-displaymode">edit</xsl:with-param>
								<xsl:with-param name="amt-readonly">Y</xsl:with-param>
								<xsl:with-param name="override-amt-displaymode">edit</xsl:with-param>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_DETAILS_PO_PAYMENT_PERCENTAGE</xsl:with-param>
						<xsl:with-param name="name">details_pct</xsl:with-param>
						<xsl:with-param name="override-displaymode">edit</xsl:with-param>
						<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
						<xsl:with-param name="value">
							<xsl:value-of select="pct" />
						</xsl:with-param>
						<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
						<xsl:with-param name="regular-expression">^(?:\d{1,11}|(?=.*\.)(?!.*\..*\.)[\d.]{1,12})$</xsl:with-param>
					</xsl:call-template>
					<xsl:choose>
						<xsl:when test="$displaymode='edit'">
							<xsl:call-template name="multioption-group">
							      <xsl:with-param name="group-label">XSL_GENERALDETAILS_TENOR_IC_LABEL</xsl:with-param>
							      <xsl:with-param name="content">
									    <xsl:call-template name="radio-field">
									         <xsl:with-param name="label">CODE</xsl:with-param>
									         <xsl:with-param name="name">payment_term</xsl:with-param>
									         <xsl:with-param name="id">pmt_term_code</xsl:with-param>
									         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
									         <xsl:with-param name="value">01</xsl:with-param>
									         <xsl:with-param name="readonly">N</xsl:with-param>
									         <xsl:with-param name="checked"><xsl:choose>
									         	<xsl:when test="code[.!='']">Y</xsl:when>
									         	<xsl:otherwise>N</xsl:otherwise>
									         </xsl:choose></xsl:with-param>
								        </xsl:call-template>
								        <div id="paymentTermCode" style = "white-space:nowrap;">
							        		<xsl:call-template name="select-field">
										         <xsl:with-param name="label">XSL_LABEL_PAYMENT_CODE</xsl:with-param>
										         <xsl:with-param name="id">details_code</xsl:with-param>
										         <xsl:with-param name="fieldsize">small</xsl:with-param>
										         <xsl:with-param name="required">Y</xsl:with-param>
										         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
										         <xsl:with-param name="options">
													<xsl:call-template name="payment_term_code_options"/>
												</xsl:with-param>
									        </xsl:call-template>
									        <xsl:variable name="code_type"><xsl:value-of select="code"></xsl:value-of></xsl:variable>
									        <xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
											<xsl:variable name="parameterId">C020</xsl:variable>
									        <xsl:call-template name="hidden-field">
												<xsl:with-param name="name">code_desc</xsl:with-param>
												<xsl:with-param name="value">
													<xsl:choose>
														<xsl:when test="details_code"><xsl:value-of	select="localization:getCodeData($language,'*',$productCode,$parameterId, $code_type)" /></xsl:when>
														<xsl:otherwise></xsl:otherwise>
													</xsl:choose>
												</xsl:with-param>							
											</xsl:call-template>
									        <xsl:call-template name="input-field">
										         <xsl:with-param name="label">XSL_LABEL_NO_OF_DAYS</xsl:with-param>
										         <xsl:with-param name="id">details_nb_days</xsl:with-param>
										         <xsl:with-param name="fieldsize">small</xsl:with-param>
										         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
										         <xsl:with-param name="size">18</xsl:with-param>
										         <xsl:with-param name="maxsize">18</xsl:with-param>
										         <xsl:with-param name="regular-expression">^([1-9]\d*|0){1,18}</xsl:with-param>
										         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										         <xsl:with-param name="value">
													<xsl:value-of select="nb_days" />
												</xsl:with-param>
									        </xsl:call-template>
								        </div>
								        <xsl:call-template name="radio-field">
									         <xsl:with-param name="label">XSL_LABEL_OTHER_PAYMENT_TERMS</xsl:with-param>
									         <xsl:with-param name="name">payment_term</xsl:with-param>
									         <xsl:with-param name="id">pmt_term_other_code</xsl:with-param>
									         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
									         <xsl:with-param name="value">02</xsl:with-param>
									         <xsl:with-param name="readonly">N</xsl:with-param>
									         <xsl:with-param name="checked"><xsl:choose>
									         	<xsl:when test="other_paymt_terms[.!='']">Y</xsl:when>
									         	<xsl:otherwise>N</xsl:otherwise>
									         </xsl:choose></xsl:with-param>
								        </xsl:call-template>
								        <xsl:call-template name="input-field">
									         <xsl:with-param name="label"></xsl:with-param>
									         <xsl:with-param name="id">details_other_paymt_terms</xsl:with-param>
									         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
									         <xsl:with-param name="value">
												<xsl:value-of select="other_paymt_terms" />
											 </xsl:with-param>
									         <xsl:with-param name="fieldsize">small</xsl:with-param>
									         <xsl:with-param name="maxsize">140</xsl:with-param>
									         <xsl:with-param name="type">text</xsl:with-param>
									         <xsl:with-param name="required">Y</xsl:with-param>
									         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									         <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
								        </xsl:call-template>   		
							      </xsl:with-param>
							    </xsl:call-template>
							 </xsl:when>
							 <xsl:otherwise>
									<xsl:call-template name="input-field">
									 	<xsl:with-param name="label">XSL_PAYMENT_CODE_LABEL</xsl:with-param>
									 	<xsl:with-param name="name">code_desc</xsl:with-param>
									 	<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									 	<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									</xsl:call-template>
									<xsl:call-template name="input-field">
								         <xsl:with-param name="label">XSL_NO_OF_DAYS_LABEL</xsl:with-param>
								         <xsl:with-param name="name">details_nb_days</xsl:with-param>
								         <xsl:with-param name="maxsize">18</xsl:with-param>
								         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
										<xsl:with-param name="type">integer</xsl:with-param>
								         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								         <xsl:with-param name="value">
											<xsl:value-of select="nb_days" />
										</xsl:with-param>
							        </xsl:call-template>
							        <xsl:call-template name="input-field">
								         <xsl:with-param name="label">XSL_OTHER_PAYMENT_TERMS_LABEL</xsl:with-param>
								         <xsl:with-param name="id">details_other_paymt_terms</xsl:with-param>
								         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
								         <xsl:with-param name="value">
											<xsl:value-of select="other_paymt_terms" />
										 </xsl:with-param>
								         <xsl:with-param name="type">text</xsl:with-param>
								         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							        </xsl:call-template>
							 </xsl:otherwise>
						</xsl:choose>
						<xsl:if test="$displaymode='view' and (prod_stat_code[.='AA'] or prod_stat_code[.='D4'])">
						 <xsl:call-template name="fieldset-wrapper">
								<xsl:with-param name="legend">XSL_HEADER_EXPECTED_PAYMENT_DETAILS</xsl:with-param>
								<xsl:with-param name="legend-type">indented-header</xsl:with-param>
								<xsl:with-param name="toc-item">N</xsl:with-param>
								<xsl:with-param name="content">
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_NET_PAYMENT_AMOUNT</xsl:with-param>
											<xsl:with-param name="id">itp_payment_amt</xsl:with-param>
											<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
											<xsl:with-param name="override-displaymode">edit</xsl:with-param>
										</xsl:call-template>
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_EXPECTED__ITP_PAYMENT_DATE</xsl:with-param>
											<xsl:with-param name="id">itp_payment_date</xsl:with-param>
											<xsl:with-param name="type">date</xsl:with-param>
											<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
											<xsl:with-param name="override-displaymode">edit</xsl:with-param>
										</xsl:call-template>
									
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						
					</div>	
					<div class="dijitDialogPaneActionBar">
					<xsl:call-template name="label-wrapper">
						<xsl:with-param name="content">
							<button type="button" dojoType="dijit.form.Button">
								<xsl:attribute name="onmouseup">dijit.byId('payment-term-dialog-template').hide();</xsl:attribute>
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
							</button>							
							<xsl:if test="$displaymode = 'edit'">
								<button dojoType="dijit.form.Button">
									<xsl:attribute name="onClick">dijit.byId('payment-term-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
								</button>
							</xsl:if>
						</xsl:with-param>
					</xsl:call-template>
					</div>
				</div>
		</div>
	</xsl:template>

	<xd:doc>
		<xd:short>Payment Term declaration</xd:short>
		<xd:detail>
			This templates gives label on button to add payment term and displayes a message when no payment is added.
 		</xd:detail>
 	</xd:doc>
	<xsl:template name="payment-terms-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="payment-term-dialog-declaration" />
		<!-- Dialog End -->
		<div id="payment-terms-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_DETAILS_PO_NO_PAYMENT')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode" id="add_payment_term_button">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_PAYMENT')" />
				</button>
			</div>
			
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Build Payment Term Dojo Items</xd:short>
		<xd:detail>
			This templates displays header for diplaying Payment term in add,edit and view mode,also displayes header of payment condition,amount and currency code in table adds different
			attributes and fills it with given selected value.
			
 		</xd:detail>
 		<xd:param name="items"> Items to be build in form to display</xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">display mode can be overriden in edit form.</xd:param>		
 	</xd:doc>
	<xsl:template name="build-payment-terms-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
		<div dialogId="payment-term-dialog-template">
			<xsl:attribute name="dojoType">misys.openaccount.widget.PaymentTerms</xsl:attribute>
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_PAYMENT')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_EDIT_PAYMENT')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_VIEW_PAYMENT')" /></xsl:attribute>
			<xsl:attribute name="headers">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PAYMENT_TERMS')" />,
					<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_PAYMENT_CUR_CODE')" />,
					<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_PAYMENT_AMOUNT_OR_PCT')" />
				</xsl:attribute>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>

			<xsl:for-each select="$items">
				<xsl:variable name="payment" select="." />
				<div dojoType="misys.openaccount.widget.PaymentTerm">
					<xsl:attribute name="ref_id"><xsl:value-of
						select="$payment/ref_id" /></xsl:attribute>
					<xsl:attribute name="tnx_id"><xsl:value-of
						select="$payment/tnx_id" /></xsl:attribute>
					<xsl:attribute name="payment_id"><xsl:value-of
						select="$payment/payment_id" /></xsl:attribute>
					<xsl:attribute name="code"><xsl:value-of
						select="$payment/code" /></xsl:attribute>
					<xsl:attribute name="code_desc"><xsl:value-of select="localization:getCodeData($language,'*','*','C020', $payment/code)" /></xsl:attribute>
					<xsl:attribute name="other_paymt_terms"><xsl:value-of
						select="$payment/other_paymt_terms" /></xsl:attribute>
					<xsl:attribute name="nb_days"><xsl:value-of
						select="$payment/nb_days" /></xsl:attribute>
					<xsl:attribute name="cur_code"><xsl:value-of
						select="$payment/cur_code" /></xsl:attribute>
					<xsl:attribute name="amt"><xsl:value-of
						select="$payment/amt" /></xsl:attribute>
					<xsl:attribute name="pct"><xsl:value-of
						select="$payment/pct" /></xsl:attribute>
					<xsl:attribute name="is_valid"><xsl:value-of
						select="$payment/is_valid" /></xsl:attribute>
					<xsl:attribute name="itp_payment_amt"><xsl:value-of
						select="$payment/itp_payment_amt" /></xsl:attribute>
					<xsl:attribute name="itp_payment_date"><xsl:value-of
						select="$payment/itp_payment_date" /></xsl:attribute>
						
				</div>
			</xsl:for-each>
		</div>

	</xsl:template>
	
	<xd:doc>
		<xd:short>Creditor Account type codes</xd:short>
		<xd:detail>
			This templates provides Creditor account type codes for the Settlement terms as per the ISO 20022 messages 2008 standards.
 		</xd:detail>
 		<xd:param name="field-name"> The creditor account type. </xd:param>
 	</xd:doc>
	<xsl:template name="creditor_account_type_codes">
		<xsl:param name="field-name"/>
		 <xsl:choose>
	        <xsl:when test="$displaymode='edit'">
			<option value="CACC">
				<xsl:value-of select="localization:getDecode($language, 'N217', 'CACC')" />
			</option>
			<option value="CASH">
				<xsl:value-of select="localization:getDecode($language, 'N217', 'CASH')" />
			</option>
			<option value="CHAR">
				<xsl:value-of select="localization:getDecode($language, 'N217', 'CHAR')" />
			</option>
			<option value="CISH">
				<xsl:value-of select="localization:getDecode($language, 'N217', 'CISH')" />
			</option>
			<option value="COMM">
				<xsl:value-of select="localization:getDecode($language, 'N217', 'COMM')" />
			</option>
			<option value="LOAN">
				<xsl:value-of select="localization:getDecode($language, 'N217', 'LOAN')" />
			</option>
			<option value="MGLD">
				<xsl:value-of select="localization:getDecode($language, 'N217', 'MGLD')" />
			</option>
			<option value="MOMA">
				<xsl:value-of select="localization:getDecode($language, 'N217', 'MOMA')" />
			</option>
			<option value="NREX">
				<xsl:value-of select="localization:getDecode($language, 'N217', 'NREX')" />
			</option>
			<option value="ODFT">
				<xsl:value-of select="localization:getDecode($language, 'N217', 'ODFT')" />
			</option>
			<option value="ONDP">
				<xsl:value-of select="localization:getDecode($language, 'N217', 'ONDP')" />
			</option>
			<option value="SACC">
				<xsl:value-of select="localization:getDecode($language, 'N217', 'SACC')" />
			</option>
			<option value="SLRY">
				<xsl:value-of select="localization:getDecode($language, 'N217', 'SLRY')" />
			</option>
			<option value="SVGS">
				<xsl:value-of select="localization:getDecode($language, 'N217', 'SVGS')" />
			</option>
			<option value="TAXE">
				<xsl:value-of select="localization:getDecode($language, 'N217', 'TAXE')" />
			</option>
			<option value="TRAS">
				<xsl:value-of select="localization:getDecode($language, 'N217', 'TRAS')" />
			</option>
		 </xsl:when>
	        <xsl:otherwise>
	         <xsl:choose>
	          <xsl:when test="$field-name = 'CACC'"><xsl:value-of select="localization:getDecode($language, 'N217', 'CACC')" /></xsl:when>
	          <xsl:when test="$field-name = 'CASH'"><xsl:value-of select="localization:getDecode($language, 'N217', 'CASH')" /></xsl:when>
	          <xsl:when test="$field-name = 'CHAR'"><xsl:value-of select="localization:getDecode($language, 'N217', 'CHAR')" /></xsl:when>
	          <xsl:when test="$field-name = 'CISH'"><xsl:value-of select="localization:getDecode($language, 'N217', 'CISH')" /></xsl:when>
	          <xsl:when test="$field-name = 'COMM'"><xsl:value-of select="localization:getDecode($language, 'N217', 'COMM')" /></xsl:when>
	          <xsl:when test="$field-name = 'LOAN'"><xsl:value-of select="localization:getDecode($language, 'N217', 'LOAN')" /></xsl:when>
	          <xsl:when test="$field-name = 'MGLD'"><xsl:value-of select="localization:getDecode($language, 'N217', 'MGLD')" /></xsl:when>
	          <xsl:when test="$field-name = 'MOMA'"><xsl:value-of select="localization:getDecode($language, 'N217', 'MOMA')" /></xsl:when>
	          <xsl:when test="$field-name = 'NREX'"><xsl:value-of select="localization:getDecode($language, 'N217', 'NREX')" /></xsl:when>
	          <xsl:when test="$field-name = 'ODFT'"><xsl:value-of select="localization:getDecode($language, 'N217', 'ODFT')" /></xsl:when>
	          <xsl:when test="$field-name = 'ONDP'"><xsl:value-of select="localization:getDecode($language, 'N217', 'ONDP')" /></xsl:when>
	          <xsl:when test="$field-name = 'SACC'"><xsl:value-of select="localization:getDecode($language, 'N217', 'SACC')" /></xsl:when>
	          <xsl:when test="$field-name = 'SLRY'"><xsl:value-of select="localization:getDecode($language, 'N217', 'SLRY')" /></xsl:when>
	          <xsl:when test="$field-name = 'SVGS'"><xsl:value-of select="localization:getDecode($language, 'N217', 'SVGS')" /></xsl:when>
	          <xsl:when test="$field-name = 'TAXE'"><xsl:value-of select="localization:getDecode($language, 'N217', 'TAXE')" /></xsl:when>
	          <xsl:when test="$field-name = 'TRAS'"><xsl:value-of select="localization:getDecode($language, 'N217', 'TRAS')" /></xsl:when>
	          <xsl:otherwise><xsl:value-of select="localization:getDecode($language, 'N217', 'OTHR')" /></xsl:otherwise>
	         </xsl:choose>
	        </xsl:otherwise>
	       </xsl:choose>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Shipment sub schedule declaration</xd:short>
		<xd:detail>
			This template adds different parameter(such as label,value,size etc) for different template called inside this,
			Also adds CANCEL and OK button at the end of dialog
 		</xd:detail>
 	</xd:doc>
	<xsl:template name="sub-shipment-schedule-dialog-declaration">
		<div id="sub-shipment-schedule-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
			<div class="standardPODialogContent">
				<div>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_SHIPMENTDETAILS_QUANTITY</xsl:with-param>
						<xsl:with-param name="name">sub_shipment_quantity_value</xsl:with-param>
						<xsl:with-param name="fieldsize">small</xsl:with-param>
						<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
						<xsl:with-param name="override-displaymode">edit</xsl:with-param>
						<xsl:with-param name="regular-expression">^(?:\d{1,18}|((?!\.?$)(\d{1,18}\.\d{1,13})){1,19})$</xsl:with-param>
						<xsl:with-param name="maxsize">19</xsl:with-param>
						<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_SHIPMENTDETAILS_EARLIEST_SHIP_DATE</xsl:with-param>
						<xsl:with-param name="name">schedule_earliest_ship_date</xsl:with-param>
						<xsl:with-param name="fieldsize">small</xsl:with-param>
						<xsl:with-param name="override-displaymode">edit</xsl:with-param>
						<xsl:with-param name="type"><xsl:if test= "$displaymode='edit'">date</xsl:if></xsl:with-param>
						<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_SHIPMENTDETAILS_LAST_SHIP_DATE</xsl:with-param>
						<xsl:with-param name="name">schedule_latest_ship_date</xsl:with-param>
						<xsl:with-param name="fieldsize">small</xsl:with-param>
						<xsl:with-param name="override-displaymode">edit</xsl:with-param>
						<xsl:with-param name="type"><xsl:if test= "$displaymode='edit'">date</xsl:if></xsl:with-param>
						<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
					</xsl:call-template>
					<div class="dijitDialogPaneActionBar">
						<xsl:call-template name="label-wrapper">
							<xsl:with-param name="content">
								<button type="button" dojoType="dijit.form.Button">
									<xsl:attribute name="onmouseup">dijit.byId('sub-shipment-schedule-dialog-template').hide();</xsl:attribute>
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
								</button>
								<xsl:if test="$displaymode = 'edit'">
									<button dojoType="dijit.form.Button">
										<xsl:attribute name="onClick">dijit.byId('sub-shipment-schedule-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
									</button>
								</xsl:if>								
							</xsl:with-param>
						</xsl:call-template>
					</div>
				</div>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Declares the shipment sub schedule.</xd:short>
		<xd:detail>
		Creates the buttons for adding shipment sub schedules and displays no shipment sub schedule message if no shipment sub schedules are present
 		</xd:detail>
	</xd:doc>
	<xsl:template name="sub-shipment-schedule-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="sub-shipment-schedule-dialog-declaration" />
		<!-- Dialog End -->
		<div id="sub-shipment-schedule-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_DETAILS_OA_NO_SUB_SHIPMENT_SCHEDULE')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_DETAILS_OA_ADD_SUB_SHIPMENT_SCHEDULE')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Build Shipment Sub Schedule items</xd:short>
		<xd:detail>
			This templates displayes label for the table for shipment quantity value,earliest shipment date and latest shipment date,
			it also displayed header in case of adding updating and viewing shipment sub schedules ,adds different attribute to
			shipment sub schedule widget.
 		</xd:detail>
 		<xd:param name="items">Items to be build to form display</xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">Overridden display mode.Shows in edit mode of the parent form</xd:param>
 	</xd:doc>
	<xsl:template name="build-shipment-schedule-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
		<div dojoType="misys.openaccount.widget.ShipmentSubSchedules" dialogId="sub-shipment-schedule-dialog-template">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_OA_ADD_SUB_SHIPMENT_SCHEDULE')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_OA_EDIT_SUB_SHIPMENT_SCHEDULE')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_OA_VIEW_SUB_SHIPMENT_SCHEDULE')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_OA_SHIPMENT_QUANTITY_VALUE')" />,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_OA_SHIPMENT_EARLIEST_SHIPMENT_DATE')" />,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_OA_SHIPMENT_LATEST_SHIPMENT_DATE')" />,
			</xsl:attribute>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
			<xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="shipmentSchedule" select="." />
					<div dojoType="misys.openaccount.widget.ShipmentSubSchedule">
						<xsl:attribute name="shipment_id"><xsl:value-of
							select="$shipmentSchedule/shipment_id" /></xsl:attribute>
						<xsl:attribute name="ref_id"><xsl:value-of
							select="$shipmentSchedule/ref_id" /></xsl:attribute>
						<xsl:attribute name="tnx_id"><xsl:value-of
							select="$shipmentSchedule/tnx_id" /></xsl:attribute>
						<xsl:attribute name="sub_shipment_quantity_value"><xsl:value-of 
							select="$shipmentSchedule/sub_shipment_quantity_value"/></xsl:attribute>
						<xsl:attribute name="schedule_earliest_ship_date"><xsl:value-of
							select="$shipmentSchedule/schedule_earliest_ship_date"/></xsl:attribute>
						<xsl:attribute name="schedule_latest_ship_date"><xsl:value-of
							select="$shipmentSchedule/schedule_latest_ship_date"/></xsl:attribute>
					</div>
				</xsl:for-each>
			</xsl:if>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Shipment Sub Schedules</xd:short>
		<xd:detail>
		It calls product identifier template inside Shipment Schedules widget
 		</xd:detail>
	</xd:doc>
	<xsl:template match="shipment_schedules">
		<div dojoType="misys.openaccount.widget.ShipmentSubSchedules">
			<xsl:apply-templates select="shipment_schedule"/>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Shipment Sub Schedule</xd:short>
		<xd:detail>
		It  gets the value of different attributes such as ref_id,tnx_id,shipment_id,sub_shipment_quantity_value,schedule_earliest_ship_date
		and schedule_latest_ship_date inside Shipment Schedules widget.
 		</xd:detail>
	</xd:doc>
	<xsl:template match="shipment_schedule">
		<div dojoType="misys.openaccount.widget.ShipmentSubSchedule">
			<xsl:attribute name="shipment_id"><xsl:value-of select="shipment_id"/></xsl:attribute>
			<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
			<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
			<xsl:attribute name="sub_shipment_quantity_value"><xsl:value-of select="sub_shipment_quantity_value"/></xsl:attribute>
			<xsl:attribute name="schedule_earliest_ship_date"><xsl:value-of select="schedule_earliest_ship_date"/></xsl:attribute>
			<xsl:attribute name="schedule_latest_ship_date"><xsl:value-of select="schedule_latest_ship_date"/></xsl:attribute>
		</div>
	</xsl:template>
		<xd:doc>
		<xd:short>Seller side submitting bank details dialog declare</xd:short>
		<xd:detail>
			This templates displays BIC label and set the BIC parameters,also adds button of cancel and OK to confirm submitting
 		</xd:detail>		
 	</xd:doc>
	<xsl:template name="seller-side-submitting-bank-dialog-declaration">
		<div id="seller-side-submitting-bank-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
			<div class="standardPODialogContent">
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_PURCHASE_ORDER_SUBMITTER_BIC</xsl:with-param>
					<xsl:with-param name="name">seller_side_submitting_bank</xsl:with-param>
					<xsl:with-param name="override-displaymode">edit</xsl:with-param>
					<xsl:with-param name="size">11</xsl:with-param>
					<xsl:with-param name="maxsize">11</xsl:with-param>
					<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
					<xsl:with-param name="value">
						<xsl:value-of select="seller_side_submitting_bank" />
					</xsl:with-param>
					<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
				</xsl:call-template>		
			</div>
			<div class="dijitDialogPaneActionBar">
				<xsl:call-template name="label-wrapper">
					<xsl:with-param name="content">
						<button type="button" dojoType="dijit.form.Button">
							<xsl:attribute name="onmouseup">dijit.byId('seller-side-submitting-bank-dialog-template').hide();</xsl:attribute>
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
						</button>
						<xsl:if test="$displaymode = 'edit'">							
						<button dojoType="dijit.form.Button">
							<xsl:attribute name="onClick">dijit.byId('seller-side-submitting-bank-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
						</button>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Build Seller side submitting bank detail</xd:short>
		<xd:detail>
			This templates displays header for diplaying dataset in add,edit and view mode,also displayes submitter bic header.
 		</xd:detail>
 		<xd:param name="items"> Items to be build to form display</xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">display mode can be overriden in edit form.</xd:param>		
 	</xd:doc>
	<xsl:template name="build-seller-side-submitting-bank-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
		<xsl:value-of select="override-displaymode"/>
		<div dojoType="misys.openaccount.widget.SellerSideSubmittingBankDetails" dialogId="seller-side-submitting-bank-dialog-template">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ADD_COMMERCIAL_DATASET')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_EDIT_COMMERCIAL_DATASET')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_VIEW_COMMERCIAL_DATASET')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of
						select="localization:getGTPString($language, 'XSL_HEADER_PO_SUBMITTER_BIC')" />,
			</xsl:attribute>
			<xsl:if test="$items">
			<xsl:for-each select="$items">
				<xsl:variable name="submitr" select="." />
				<div dojoType="misys.openaccount.widget.SellerSideSubmittingBankDetail">
				<xsl:attribute name="seller_side_submitting_bank"><xsl:value-of
						select="$submitr/seller_side_submitting_bank" /></xsl:attribute>
				</div>
			</xsl:for-each>
			</xsl:if>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Seller side submitting bank details</xd:short>
		<xd:detail>
			This displays message of no Seller side submitting bank if no seller side submitting bank is available and add button to add Seller side submitting bank details.
 		</xd:detail> 		
 	</xd:doc>
	<xsl:template name="seller-side-submitting-bank-details-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="seller-side-submitting-bank-dialog-declaration" />
		<!-- Dialog End -->
		<div id="seller-side-submitting-bank-details-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_DETAILS_PO_NO_COMMERCIAL_DATASET')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ADD_COMMERCIAL_DATASET')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	<!--  Bank Details Fieldset. -->
	<xd:doc>
		<xd:short>Buyer Bank Details</xd:short>
		<xd:detail>
			This field shows buyer bank name,buyer bank reference. Also shows buyer side and seller side submitting bank fields.
 		</xd:detail>
	</xd:doc>
	<xsl:template name="oa-bank-details">
		<xsl:param name="sender-name" />
		<xsl:param name="readonly">
			<xsl:choose>
				<xsl:when test="product_code[.='IO'] and tnx_type_code[.='03'] and defaultresource:getResource('IO_AMEND_READONLY')">Y</xsl:when>
				<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">
				<xsl:choose>
					<xsl:when test="product_code[.='IO']">XSL_HEADER_BUYER_BANK_DETAILS</xsl:when>
					<xsl:when test="product_code[.='EA']">XSL_HEADER_SELLER_BANK_DETAILS</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="issuing-bank-tabcontent">
					<xsl:with-param name="sender-name" select="$sender-name" />
					<xsl:with-param name="sender-reference-name"><xsl:value-of select="$sender-name"/>_reference</xsl:with-param>
   				</xsl:call-template>
   				<xsl:if test="not(product_code [.='EA'] and prod_stat_code[.='A6'])">
	   				<xsl:call-template name="fieldset-wrapper">
						<xsl:with-param name="legend">XSL_HEADER_BUYER_SIDE_SUBMITTING_BANK_DETAILS</xsl:with-param>
						<xsl:with-param name="legend-type">indented-header</xsl:with-param>
						<xsl:with-param name="content">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PURCHASE_ORDER_SUBMITTER_BIC</xsl:with-param>
								<xsl:with-param name="name">buyer_submitting_bank_bic</xsl:with-param>
								<xsl:with-param name="maxsize">11</xsl:with-param>
								<xsl:with-param name="size">11</xsl:with-param>
								<xsl:with-param name="fieldsize">small</xsl:with-param>
								<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								<xsl:with-param name="readonly" select="$readonly"/>
							<!-- 	<xsl:with-param name="hide-label">
									<xsl:choose>
										<xsl:when test="product_code[.='IO'] and tnx_type_code[.='03'] and buyer_submitting_bank_bic[.='']">Y</xsl:when>
										<xsl:otherwise>N</xsl:otherwise>
									</xsl:choose>
								</xsl:with-param> -->
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
					
					<xsl:call-template name="fieldset-wrapper">
						<xsl:with-param name="legend">XSL_HEADER_SELLER_SIDE_SUBMITTING_BANK_DETAILS</xsl:with-param>
						<xsl:with-param name="legend-type">indented-header</xsl:with-param>
						<xsl:with-param name="content">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PURCHASE_ORDER_SUBMITTER_BIC</xsl:with-param>
								<xsl:with-param name="name">seller_submitting_bank_bic</xsl:with-param>
								<xsl:with-param name="maxsize">11</xsl:with-param>
								<xsl:with-param name="size">11</xsl:with-param>
								<xsl:with-param name="fieldsize">small</xsl:with-param>
								<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								<xsl:with-param name="readonly" select="$readonly"/>
							<!-- 	<xsl:with-param name="hide-label">
									<xsl:choose>
										<xsl:when test="product_code[.='IO'] and tnx_type_code[.='03'] and seller_submitting_bank_bic[.='']">Y</xsl:when>
										<xsl:otherwise>N</xsl:otherwise>
									</xsl:choose>
								</xsl:with-param> -->
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!--  Payment Details Fieldset. -->
	<xd:doc>
		<xd:short>Payment Details</xd:short>
		<xd:detail>
			This section contains describes payment terms,headers and identification
 		</xd:detail>
	</xd:doc>
	<xsl:template name="oa-payment-terms">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_PAYMENT_TERMS_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
			<xsl:if test="not(tnx_type_code) or tnx_type_code[.='49' or .='63'] and product_code [.='EA']">
			&nbsp;
				<xsl:if test="$displaymode='edit'">
					<xsl:choose>
						<xsl:when test="tnx_type_code[.='63']">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_EXPECTED_PAYMENT_DATE</xsl:with-param>
								<xsl:with-param name="id">expected_payment_date</xsl:with-param>
								<xsl:with-param name="value" select="expected_payment_date" />
								<xsl:with-param name="override-displaymode">view</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="hidden-field">
					       <xsl:with-param name="name">expected_payment_date</xsl:with-param>
					       <xsl:with-param name="value" select="expected_payment_date"/>
					     </xsl:call-template>
						</xsl:when>
					</xsl:choose>
				</xsl:if>
				
				<xsl:if test="$displaymode='view'">
				<xsl:choose>
					<xsl:when test="tnx_type_code[.='63']">
						<xsl:if test="expected_payment_date[. != '']">
							<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_EXPECTED_PAYMENT_DATE</xsl:with-param>
									<xsl:with-param name="name">expected_payment_date</xsl:with-param>
									<xsl:with-param name="value"><xsl:value-of select="expected_payment_date"/></xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:when>
					 <xsl:when test="tnx_type_code[.='49']">
						<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_EXPECTED_PAYMENT_DATE</xsl:with-param>
								<xsl:with-param name="name">expected_payment_date</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select="expected_payment_date"/></xsl:with-param>
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
				</xsl:if>
			</xsl:if>	
			&nbsp;
				
			<xsl:if test= "not(tnx_type_code[.='49'] and product_code[.= 'EA'])">	
				<xsl:call-template name="build-payment-terms-dojo-items">
					<xsl:with-param name="items" select="payments/payment" />
					<xsl:with-param name="id">po-payments</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
						
			</xsl:with-param>
		</xsl:call-template>							
	</xsl:template>
	
		<!--  Settlment Details Fieldset. -->
	<xd:doc>
		<xd:short>Settlement Terms</xd:short>
		<xd:detail>
			This template adds different parameter(such as label,size etc) for different template called inside this,
 		</xd:detail>
	</xd:doc>
	<xsl:template name="oa-settlement-terms">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_SETTLEMENT_TERMS_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="fieldset-wrapper">
					      	<xsl:with-param name="legend">XSL_LABEL_CREDITOR_AGENT</xsl:with-param>
					      	<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			     			<xsl:with-param name="content">
			     			<xsl:choose> 
								<xsl:when test="$displaymode = 'edit'">
				     			<xsl:call-template name="multioption-group">
				     				<xsl:with-param name="label">XSL_LABEL_CREDITOR_AGENT</xsl:with-param>
						      		<xsl:with-param name="content">
							      	<xsl:call-template name="radio-field">
								         <xsl:with-param name="label">XSL_LABEL_BIC</xsl:with-param>
								         <xsl:with-param name="name">credtr_bic</xsl:with-param>
								         <xsl:with-param name="id">credtr_bic</xsl:with-param>
								         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
								         <xsl:with-param name="value">01</xsl:with-param>
								         <xsl:with-param name="readonly">N</xsl:with-param>
								         <xsl:with-param name="checked">
								         	<xsl:choose>
								         		<xsl:when test="fin_inst_bic[.!='']">Y</xsl:when>
								         		<xsl:otherwise>N</xsl:otherwise>
								         	</xsl:choose>
										 </xsl:with-param>
							        </xsl:call-template>
							        <div id="settlement_creditor_agent_bic" style="display:none">
								        <xsl:call-template name="input-field">
									         <xsl:with-param name="label">XSL_PURCHASE_ORDER_SUBMITTER_BIC</xsl:with-param>
									         <xsl:with-param name="name">fin_inst_bic</xsl:with-param>
									         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
									         <xsl:with-param name="type">text</xsl:with-param>
									         <xsl:with-param name="size">11</xsl:with-param>
									         <xsl:with-param name="maxsize">11</xsl:with-param>
									         <xsl:with-param name="fieldsize">small</xsl:with-param>
									         <xsl:with-param name="required">Y</xsl:with-param>
									         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								        </xsl:call-template>
							        </div>
							        <xsl:call-template name="radio-field">
								         <xsl:with-param name="label">XSL_LABEL_NAME_AND_ADDRESS</xsl:with-param>
								         <xsl:with-param name="name">credtr_bic</xsl:with-param>
								         <xsl:with-param name="id">credtr_name_address</xsl:with-param>
								         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
								         <xsl:with-param name="value">02</xsl:with-param>
								         <xsl:with-param name="readonly">N</xsl:with-param>
								         <xsl:with-param name="checked">
								         	<xsl:choose>
								         		<xsl:when test="fin_inst_name[.!='']">Y</xsl:when>
								         		<xsl:otherwise>N</xsl:otherwise>
								         	</xsl:choose>
										 </xsl:with-param>
							        </xsl:call-template>
							        <div id="settlement_creditor_agent_name" style="display:none">
								        <xsl:call-template name="input-field">
									         <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_NAME</xsl:with-param>
									         <xsl:with-param name="name">fin_inst_name</xsl:with-param>
									         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
									         <xsl:with-param name="type">text</xsl:with-param>
									         <xsl:with-param name="maxsize">70</xsl:with-param>
									         <xsl:with-param name="required">Y</xsl:with-param>
									         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									         <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
								        </xsl:call-template>
								         <xsl:call-template name="input-field">
									         <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_STREET</xsl:with-param>
									         <xsl:with-param name="name">fin_inst_street_name</xsl:with-param>
									         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
									         <xsl:with-param name="type">text</xsl:with-param>
									         <xsl:with-param name="maxsize">70</xsl:with-param>
									         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									         <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
								        </xsl:call-template>
								        <xsl:call-template name="input-field">
									         <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_POST_CODE</xsl:with-param>
									         <xsl:with-param name="name">fin_inst_post_code</xsl:with-param>
									         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
									         <xsl:with-param name="type">text</xsl:with-param>
									         <xsl:with-param name="required">Y</xsl:with-param>
									         <xsl:with-param name="maxsize">16</xsl:with-param>
									         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								        </xsl:call-template>
								        <xsl:call-template name="input-field">
									         <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_TOWN</xsl:with-param>
									         <xsl:with-param name="name">fin_inst_town_name</xsl:with-param>
									         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
									         <xsl:with-param name="type">text</xsl:with-param>
									         <xsl:with-param name="required">Y</xsl:with-param>
									         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									         <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
								        </xsl:call-template>
								        <xsl:call-template name="input-field">
									         <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION</xsl:with-param>
									         <xsl:with-param name="name">fin_inst_country_sub_div</xsl:with-param>
									         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
									         <xsl:with-param name="type">text</xsl:with-param>
									         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									         <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
								        </xsl:call-template>
								        <xsl:call-template name="country-field">
								        	<xsl:with-param name="name">fin_inst_country</xsl:with-param>
											<xsl:with-param name="prefix">fin_inst</xsl:with-param>
											<xsl:with-param name="override-displaymode">edit</xsl:with-param>
											<xsl:with-param name="required">Y</xsl:with-param>
											<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										</xsl:call-template>
									</div>
									</xsl:with-param>
					        		</xsl:call-template>
					        		</xsl:when>
					        		<xsl:otherwise>
					        			<xsl:call-template name="input-field">
									         <xsl:with-param name="label">XSL_PURCHASE_ORDER_SUBMITTER_BIC</xsl:with-param>
									         <xsl:with-param name="name">fin_inst_bic</xsl:with-param>
									         <xsl:with-param name="type">text</xsl:with-param>
									         <xsl:with-param name="required">Y</xsl:with-param>
									         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								        </xsl:call-template>
								        <xsl:call-template name="input-field">
									         <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_NAME</xsl:with-param>
									         <xsl:with-param name="name">fin_inst_name</xsl:with-param>
									         <xsl:with-param name="type">text</xsl:with-param>
									         <xsl:with-param name="required">Y</xsl:with-param>
									         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									         <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
								        </xsl:call-template>
								         <xsl:call-template name="input-field">
									         <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_STREET</xsl:with-param>
									         <xsl:with-param name="name">fin_inst_street_name</xsl:with-param>
									         <xsl:with-param name="type">text</xsl:with-param>
									         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									         <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
								        </xsl:call-template>
								        <xsl:call-template name="input-field">
									         <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_POST_CODE</xsl:with-param>
									         <xsl:with-param name="name">fin_inst_post_code</xsl:with-param>
									         <xsl:with-param name="type">text</xsl:with-param>
									         <xsl:with-param name="required">Y</xsl:with-param>
									         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								        </xsl:call-template>
								        <xsl:call-template name="input-field">
									         <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_TOWN</xsl:with-param>
									         <xsl:with-param name="name">fin_inst_town_name</xsl:with-param>
									         <xsl:with-param name="type">text</xsl:with-param>
									         <xsl:with-param name="required">Y</xsl:with-param>
									         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									         <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
								        </xsl:call-template>
								        <xsl:call-template name="input-field">
									         <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION</xsl:with-param>
									         <xsl:with-param name="name">fin_inst_country_sub_div</xsl:with-param>
									         <xsl:with-param name="type">text</xsl:with-param>
									         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									         <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
								        </xsl:call-template>
								        <xsl:call-template name="country-field">
								        	<xsl:with-param name="name">fin_inst_country</xsl:with-param>
											<xsl:with-param name="prefix">fin_inst</xsl:with-param>
											<xsl:with-param name="required">Y</xsl:with-param>
											<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										</xsl:call-template>
					        		</xsl:otherwise>
					        	</xsl:choose>
				        		</xsl:with-param>
					        </xsl:call-template>
					        		
								<xsl:call-template name="fieldset-wrapper">
							      	<xsl:with-param name="legend">XSL_LABEL_CREDITOR_ACCOUNT</xsl:with-param>
							      	<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					      			<xsl:with-param name="content">
					      			<xsl:choose> 
								    	<xsl:when test="$displaymode = 'edit'">
							      			<xsl:call-template name="multioption-group">
									      	<xsl:with-param name="group-label">XSL_CREDITOR_ACCOUNT_ID_TYPE</xsl:with-param>
									      	<xsl:with-param name="content">
							      		
									      	<xsl:call-template name="radio-field">
										         <xsl:with-param name="label">XSL_PURCHASE_ORDER_ACCOUNT_TYPE_IBAN</xsl:with-param>
										         <xsl:with-param name="name">fin_account_type</xsl:with-param>
										         <xsl:with-param name="id">fin_account_iban</xsl:with-param>
										         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
										         <xsl:with-param name="value">01</xsl:with-param>
										         <xsl:with-param name="readonly">N</xsl:with-param>
										         <xsl:with-param name="checked">
										         	<xsl:choose>
										         		<xsl:when test="seller_account_iban[.!='']">Y</xsl:when>
										         		<xsl:otherwise>N</xsl:otherwise>
										         	</xsl:choose>
												 </xsl:with-param>
									        </xsl:call-template>
									        <xsl:call-template name="input-field">
										         <xsl:with-param name="label"></xsl:with-param>
										         <xsl:with-param name="name">seller_account_iban</xsl:with-param>
										         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
										         <xsl:with-param name="type">text</xsl:with-param>
										         <xsl:with-param name="required">Y</xsl:with-param>
										         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									        </xsl:call-template>
									        <xsl:call-template name="radio-field">
										         <xsl:with-param name="label">XSL_PURCHASE_ORDER_ACCOUNT_TYPE_BBAN</xsl:with-param>
										         <xsl:with-param name="name">fin_account_type</xsl:with-param>
										         <xsl:with-param name="id">fin_account_bban</xsl:with-param>
										         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
										         <xsl:with-param name="value">02</xsl:with-param>
										         <xsl:with-param name="readonly">N</xsl:with-param>
										         <xsl:with-param name="checked">
												 	<xsl:choose>
										         		<xsl:when test="seller_account_bban[.!='']">Y</xsl:when>
										         		<xsl:otherwise>N</xsl:otherwise>
										         	</xsl:choose>
												 </xsl:with-param>
									        </xsl:call-template>
									        <xsl:call-template name="input-field">
										         <xsl:with-param name="label"></xsl:with-param>
										         <xsl:with-param name="name">seller_account_bban</xsl:with-param>
										         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
										         <xsl:with-param name="required">Y</xsl:with-param>
										         <xsl:with-param name="type">text</xsl:with-param>
										         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									        </xsl:call-template>
									        <xsl:call-template name="radio-field">
										         <xsl:with-param name="label">XSL_PURCHASE_ORDER_ACCOUNT_TYPE_UPIC</xsl:with-param>
										         <xsl:with-param name="name">fin_account_type</xsl:with-param>
										         <xsl:with-param name="id">fin_account_upic</xsl:with-param>
										         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
										         <xsl:with-param name="value">03</xsl:with-param>
										         <xsl:with-param name="readonly">N</xsl:with-param>
										         <xsl:with-param name="checked">
										         	<xsl:choose>
										         		<xsl:when test="seller_account_upic[.!='']">Y</xsl:when>
										         		<xsl:otherwise>N</xsl:otherwise>
										         	</xsl:choose>
										         </xsl:with-param>
									        </xsl:call-template>
									        <xsl:call-template name="input-field">
										         <xsl:with-param name="label"></xsl:with-param>
										         <xsl:with-param name="name">seller_account_upic</xsl:with-param>
										         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
										         <xsl:with-param name="required">Y</xsl:with-param>
										         <xsl:with-param name="type">text</xsl:with-param>
										         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									        </xsl:call-template>
									        <xsl:call-template name="radio-field">
										         <xsl:with-param name="label">XSL_PURCHASE_ORDER_ACCOUNT_TYPE_OTHER</xsl:with-param>
										         <xsl:with-param name="name">fin_account_type</xsl:with-param>
										         <xsl:with-param name="id">fin_account_prop</xsl:with-param>
										         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
										         <xsl:with-param name="value">04</xsl:with-param>
										         <xsl:with-param name="readonly">N</xsl:with-param>
										         <xsl:with-param name="checked">
										         	<xsl:choose>
										         		<xsl:when test="seller_account_id[.!='']">Y</xsl:when>
										         		<xsl:otherwise>N</xsl:otherwise>
										         	</xsl:choose>
										         </xsl:with-param>
									        </xsl:call-template>
									        <xsl:call-template name="input-field">
										         <xsl:with-param name="label"></xsl:with-param>
										         <xsl:with-param name="name">seller_account_id</xsl:with-param>
										         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
										         <xsl:with-param name="type">text</xsl:with-param>
										         <xsl:with-param name="maxsize">34</xsl:with-param>
										         <xsl:with-param name="required">Y</xsl:with-param>
										         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									        </xsl:call-template>
									        </xsl:with-param>
							        		</xsl:call-template>
							        		
							        		<xsl:call-template name="multioption-group">
										      <xsl:with-param name="group-label">XSL_CREDITOR_ACCOUNT_TYPE</xsl:with-param>
										      <xsl:with-param name="content">
										      	<xsl:call-template name="radio-field">
											         <xsl:with-param name="label">XSL_CREDITOR_ACCOUNT_TYPE_CODE</xsl:with-param>
											         <xsl:with-param name="name">seller_act_type_code</xsl:with-param>
											         <xsl:with-param name="id">crdtr_act_code</xsl:with-param>
											         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
											         <xsl:with-param name="value">01</xsl:with-param>
											         <xsl:with-param name="readonly">N</xsl:with-param>
											         <xsl:with-param name="checked">
											         	<xsl:choose>
											         		<xsl:when test="seller_account_type_code[.!='']">Y</xsl:when>
											         		<xsl:otherwise>N</xsl:otherwise>
											         	</xsl:choose>
											         </xsl:with-param>
										        </xsl:call-template>
												<xsl:call-template name="select-field">
											         <xsl:with-param name="label"></xsl:with-param>
											         <xsl:with-param name="name">seller_account_type_code</xsl:with-param>
											         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
											         <xsl:with-param name="required">Y</xsl:with-param>
											         <xsl:with-param name="options">
											         	<xsl:call-template name="creditor_account_type_codes" >
															 <xsl:with-param name="field-name">creditor_account_type_code</xsl:with-param>
														</xsl:call-template>
											         </xsl:with-param>
											         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								        		</xsl:call-template>
								        		
								        		<xsl:call-template name="radio-field">
											         <xsl:with-param name="label">XSL_BPO_LABEL_PROPRIETARY</xsl:with-param>
											         <xsl:with-param name="name">seller_act_type_code</xsl:with-param>
											         <xsl:with-param name="id">crdtr_act_prop</xsl:with-param>
											         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
											         <xsl:with-param name="value">02</xsl:with-param>
											         <xsl:with-param name="readonly">N</xsl:with-param>
											         <xsl:with-param name="checked">N</xsl:with-param>
										        </xsl:call-template>
										        <xsl:call-template name="input-field">
											         <xsl:with-param name="label"></xsl:with-param>
											         <xsl:with-param name="name">seller_account_type_prop</xsl:with-param>
											         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
											         <xsl:with-param name="required">Y</xsl:with-param>
											         <xsl:with-param name="type">text</xsl:with-param>
											         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										        </xsl:call-template>
								        	</xsl:with-param>
								        	</xsl:call-template>
									   		</xsl:when>
								       		<xsl:otherwise>
									       		<xsl:call-template name="input-field">
											         <xsl:with-param name="label">XSL_PURCHASE_ORDER_ACCOUNT_TYPE_IBAN</xsl:with-param>
											         <xsl:with-param name="name">seller_account_iban</xsl:with-param>
											         <xsl:with-param name="type">text</xsl:with-param>
											         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										        </xsl:call-template>
										        <xsl:call-template name="input-field">
											         <xsl:with-param name="label">XSL_PURCHASE_ORDER_ACCOUNT_TYPE_BBAN</xsl:with-param>
											         <xsl:with-param name="name">seller_account_bban</xsl:with-param>
											         <xsl:with-param name="type">text</xsl:with-param>
											         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										        </xsl:call-template>
										        <xsl:call-template name="input-field">
											         <xsl:with-param name="label">XSL_PURCHASE_ORDER_ACCOUNT_TYPE_UPIC</xsl:with-param>
											         <xsl:with-param name="name">seller_account_upic</xsl:with-param>
											         <xsl:with-param name="type">text</xsl:with-param>
											         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										        </xsl:call-template>
										        <xsl:call-template name="input-field">
											         <xsl:with-param name="label">XSL_PURCHASE_ORDER_ACCOUNT_TYPE_OTHER</xsl:with-param>
											         <xsl:with-param name="name">seller_account_id</xsl:with-param>
											         <xsl:with-param name="type">text</xsl:with-param>
											         <xsl:with-param name="maxsize">34</xsl:with-param>
											         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										        </xsl:call-template>
								        		<xsl:call-template name="input-field">
											         <xsl:with-param name="label">XSL_CREDITOR_ACCOUNT_TYPE_CODE</xsl:with-param>
											         <xsl:with-param name="name">seller_account_type_code</xsl:with-param>
											         <xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N217', seller_account_type_code)"/></xsl:with-param>
								        			<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								        		</xsl:call-template>
								        		<xsl:call-template name="input-field">
											         <xsl:with-param name="label">XSL_BPO_LABEL_PROPRIETARY</xsl:with-param>
											         <xsl:with-param name="name">seller_account_type_prop</xsl:with-param>
											         <xsl:with-param name="type">text</xsl:with-param>
											         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										        </xsl:call-template>
								       		</xsl:otherwise>
							       		</xsl:choose>
							       		<xsl:call-template name="input-field">
						         			 <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
									         <xsl:with-param name="name">seller_account_name</xsl:with-param>
									         <xsl:with-param name="maxsize">70</xsl:with-param>
									         <xsl:with-param name="type">text</xsl:with-param>
									         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									         <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
								        </xsl:call-template>
								        <xsl:choose>
								        	<xsl:when test="$displaymode = 'edit'">
								        		<xsl:call-template name="currency-field">
													<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_CURRENCY</xsl:with-param>
													<xsl:with-param name="override-currency-name">seller_account_cur_code</xsl:with-param>
													<xsl:with-param name="show-button">Y</xsl:with-param>
													<xsl:with-param name="product-code">seller_account</xsl:with-param>
													<xsl:with-param name="override-displaymode">edit</xsl:with-param>
													<xsl:with-param name="show-amt">N</xsl:with-param>
													<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
												</xsl:call-template>
								        	</xsl:when>
								        	<xsl:otherwise>
								        		<xsl:call-template name="input-field">
								        			<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_CURRENCY</xsl:with-param>
								        			<xsl:with-param name="name">seller_account_cur_code</xsl:with-param>
								        			<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								        		</xsl:call-template>
								        	</xsl:otherwise>
								        </xsl:choose>
								        
								      </xsl:with-param>
								    </xsl:call-template>
				</xsl:with-param>	
			</xsl:call-template>
	</xsl:template>
	
		<!--  Shipment details Fieldset. -->
	<xd:doc>
		<xd:short>Shipment Details</xd:short>
		<xd:detail>
			This template have the details of Partial Shipment(allowed/not allowed),Trans-shipment(allowed/not allowed), earlier shipment date and last shipment date.
 		</xd:detail>
 		<xd:param name="toc-item">A Flag that indicates whether the header section label to be added as a tic-toc content on the floating navigation widget. </xd:param>
	</xd:doc>
	<xsl:template name="oa-shipment-details">
		<xsl:param name="toc-item" />
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_SHIPMENT_DETAILS</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="toc-item" select="$toc-item"/>
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
							<xsl:with-param name="radio-value"><xsl:value-of select="part_ship" /></xsl:with-param>
							<xsl:with-param name="checked">
								<xsl:if test="part_ship[. = 'Y' or . = '']">Y</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="radio-field">
							<xsl:with-param name="label">XSL_SHIPMENTDETAILS_PART_SHIP_NOT_ALLOWED</xsl:with-param>
							<xsl:with-param name="name">part_ship</xsl:with-param>
							<xsl:with-param name="id">part_ship_2</xsl:with-param>
							<xsl:with-param name="value">N</xsl:with-param>
							<xsl:with-param name="radio-value"><xsl:value-of select="part_ship" /></xsl:with-param>
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
							<xsl:with-param name="radio-value"><xsl:value-of select="tran_ship" /></xsl:with-param>
							<xsl:with-param name="checked">
								<xsl:if test="tran_ship[. = 'Y' or . = '']">Y</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="radio-field">
							<xsl:with-param name="label">XSL_SHIPMENTDETAILS_TRAN_SHIP_NOT_ALLOWED</xsl:with-param>
							<xsl:with-param name="name">tran_ship</xsl:with-param>
							<xsl:with-param name="id">tran_ship_2</xsl:with-param>
							<xsl:with-param name="value">N</xsl:with-param>
							<xsl:with-param name="radio-value"><xsl:value-of select="tran_ship" /></xsl:with-param>
							<xsl:with-param name="checked">
								<xsl:if test="tran_ship[. = 'N']">Y</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
			        </xsl:with-param>
			   </xsl:call-template>
			   <xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SHIPMENTDETAILS_EARLIEST_SHIP_DATE</xsl:with-param>
					<!-- events : onblur, onfocus -->
					<xsl:with-param name="name">earliest_ship_date</xsl:with-param>
					<xsl:with-param name="type">date</xsl:with-param>
					<xsl:with-param name="value">
						<xsl:value-of select="earliest_ship_date" />
					</xsl:with-param>
					<xsl:with-param name="size">10</xsl:with-param>
					<xsl:with-param name="maxsize">10</xsl:with-param>
					<xsl:with-param name="fieldsize">small</xsl:with-param>
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
	
		<!-- Goods Details Fieldset.-->
	<xd:doc>
		<xd:short>Goods Details</xd:short>
		<xd:detail>
			This template adds different parameter(such as label,size etc) for different template called inside this.
 		</xd:detail>
 		<xd:param name="toc-item">A Flag that indicates whether the header section label to be added as a tic-toc content on the floating navigation widget. </xd:param>
	</xd:doc>
	<xsl:template name="oa-goods-details">
		<xsl:param name="toc-item" />
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">
				<xsl:choose>
					<xsl:when test="product_code [.='EA'] and prod_stat_code[.='A6']">XSL_HEADER_GOODS_DETAILS_HEADER</xsl:when>
					<xsl:otherwise>XSL_HEADER_DESCRIPTION_GOODS</xsl:otherwise>				
				</xsl:choose>
			</xsl:with-param>
			<xsl:with-param name="content">
					<xsl:if test="not(product_code [.='EA'] and prod_stat_code[.='A6'])">
						<xsl:if test="$displaymode='edit'">
							<xsl:call-template name="textarea-field">
								<xsl:with-param name="label">XSL_PURCHASE_ORDER_GOODS_DESC</xsl:with-param>
								<xsl:with-param name="name">goods_desc</xsl:with-param>
								<xsl:with-param name="maxlines">2</xsl:with-param>
								<xsl:with-param name="cols">35</xsl:with-param>
								<xsl:with-param name="rows">5</xsl:with-param>
								<xsl:with-param name="maxlength">69</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="$displaymode='view' and goods_desc[.!='']">
						      <xsl:call-template name="big-textarea-wrapper">
						      <xsl:with-param name="label">XSL_PURCHASE_ORDER_GOODS_DESC</xsl:with-param>
						      <xsl:with-param name="content"><div class="content">
						        <xsl:value-of select="goods_desc"/>
						      </div></xsl:with-param>
						     </xsl:call-template>
					    </xsl:if>
					</xsl:if>
			    <xsl:if test="$displaymode='edit'">
					<xsl:call-template name="currency-field">
						<xsl:with-param name="label">XSL_IMPORT_OPEN_ACCOUNT_CURRENCY_CODE</xsl:with-param>
						<xsl:with-param name="product-code">total</xsl:with-param>
						<xsl:with-param name="override-currency-name">total_cur_code</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
						<xsl:with-param name="show-amt">N</xsl:with-param>
						<xsl:with-param name="currency-readonly">
							<xsl:choose>
								<xsl:when test="tnx_type_code[.='03']">Y</xsl:when>
								<xsl:otherwise>N</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
						<xsl:with-param name="show-button">
							<xsl:choose>
								<xsl:when test="tnx_type_code[.='03']">N</xsl:when>
								<xsl:otherwise>Y</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="displaymode='view'">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_IMPORT_OPEN_ACCOUNT_CURRENCY_CODE</xsl:with-param>
						<xsl:with-param name="name">total_cur_code</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="not(product_code [.='EA'] and prod_stat_code[.='A6'])">
					<xsl:call-template name="oa-shipment-details">
						<xsl:with-param name="toc-item" select="$toc-item"/>
					</xsl:call-template>
				</xsl:if>
				&nbsp;
				<xsl:if test="$section_po_line_items!='N'">	
					<!-- Buyer Details -->
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
							<xsl:choose>
								<xsl:when test="$option = 'FULL' or $option = 'DETAILS' or $displaymode='view'">
									<br/>
									<xsl:call-template name="input-field">
										<xsl:with-param name="label">XSL_AMOUNTDETAILS_PO_TOTAL_LINE_ITEMS_AMT_LABEL</xsl:with-param>
										<xsl:with-param name="value"><xsl:value-of select="total_cur_code"/>&nbsp;<xsl:value-of select="total_amt"/></xsl:with-param>
										<xsl:with-param name="name">fake_total_amt</xsl:with-param>
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="currency-field">
										<xsl:with-param name="label">XSL_AMOUNTDETAILS_PO_TOTAL_LINE_ITEMS_AMT_LABEL</xsl:with-param>
										<xsl:with-param name="product-code">total</xsl:with-param>
										<xsl:with-param name="override-currency-name">fake_total_cur_code</xsl:with-param>
										<xsl:with-param name="override-amt-name">fake_total_amt</xsl:with-param>
										<xsl:with-param name="currency-readonly">Y</xsl:with-param>
										<xsl:with-param name="amt-readonly">Y</xsl:with-param>
										<xsl:with-param name="show-button">N</xsl:with-param>
									</xsl:call-template>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
		
	<!--  Inco terms Fieldset. -->
	<xd:doc>
		<xd:short>Inco-terms</xd:short>
		<xd:detail>
			This field shows incoterms header and builf a list of incoterms
 		</xd:detail>
	</xd:doc>
	<xsl:template name="oa-inco-terms">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_INCO_TERMS_DETAILS</xsl:with-param>
			<xsl:with-param name="content">&nbsp; 
				<xsl:call-template name="build-incoterms-dojo-items">
					<xsl:with-param name="items" select="incoterms/incoterm"/>
					<xsl:with-param name="id" select="po-incoterms" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
		<!-- User Details Fieldset. -->
	<xd:doc>
		<xd:short>User Details</xd:short>
		<xd:detail>
			This section contains input boxes of buyer information and seller information.
 		</xd:detail>
	</xd:doc>
	<xsl:template name="oa-user-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">
				<xsl:choose>
						<xsl:when test="product_code [.='EA'] and prod_stat_code[.='A6']">XSL_HEADER_USER_DEFINED_INFORMATION_DETAILS</xsl:when>
						<xsl:otherwise>XSL_HEADER_USER_INFORMATION_DETAILS</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">
						<xsl:choose>
							<xsl:when test="product_code [.='EA'] and prod_stat_code[.='A6']">XSL_HEADER_USER_DEFINED_BUYER_INFORMATIONS</xsl:when>
							<xsl:otherwise>XSL_PURCHASE_ORDER_BUYER_INFORMATIONS</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">&nbsp;
						<xsl:call-template name="user_defined_informations_buyer">
							<xsl:with-param name="items" select="user_defined_informations/user_defined_information[type=01]" />
							<xsl:with-param name="id" select="po-buyer-user-informations" />
							<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">
						<xsl:choose>
							<xsl:when test="product_code [.='EA'] and prod_stat_code[.='A6']">XSL_HEADER_USER_DEFINED_SELLER_INFORMATIONS</xsl:when>
							<xsl:otherwise>XSL_PURCHASE_ORDER_SELLER_INFORMATIONS</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
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
	<xd:doc>
		<xd:short>Contact Details</xd:short>
		<xd:detail>
			This section contains contact details section.
 		</xd:detail>
	</xd:doc>
	<xsl:template name="oa-contact-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_CONTACT_PERSON_DETAILS</xsl:with-param>
			<xsl:with-param name="content">&nbsp;
				<xsl:call-template name="build-contact-details-dojo-items">
					<xsl:with-param name="items" select="contacts/contact" />
					<xsl:with-param name="id" select="po-contacts" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>		

	<xd:doc>
		<xd:short>Commercial Dataset</xd:short>
		<xd:detail>
			This template contains commercial dataset section adds different parameters for this.
 		</xd:detail>
	</xd:doc>
	<xsl:template name="commercial-ds-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_PURCHASE_ORDER_COMMERCIAL_DATASET_DETAILS</xsl:with-param>
			<xsl:with-param name="content">&nbsp;
				<xsl:call-template name="build-commercial-ds-details-dojo-items">
					<xsl:with-param name="items" select="commercial_dataset/ComrclDataSetReqrd/Submitr" />
					<xsl:with-param name="id" select="commercial-ds" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Transport Dataset</xd:short>
		<xd:detail>
			This template contains transport dataset section adds different parameters for this.
 		</xd:detail>
	</xd:doc>
	<xsl:template name="transport-ds-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_PURCHASE_ORDER_TRANSPORT_DATASET_DETAILS</xsl:with-param>
			<xsl:with-param name="content">&nbsp;
				<xsl:call-template name="build-transport-ds-details-dojo-items">
					<xsl:with-param name="items" select="transport_dataset/TrnsprtDataSetReqrd/Submitr" />
					<xsl:with-param name="id" select="transport-ds" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>		
	
	<xd:doc>
		<xd:short>Insurance Dataset</xd:short>
		<xd:detail>
			This template contains Insurance dataset section adds different parameters for this.
 		</xd:detail>
	</xd:doc>
	<xsl:template name="insurance-ds-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_PURCHASE_ORDER_INSURANCE_DATASET_DETAILS</xsl:with-param>
			<xsl:with-param name="content">&nbsp;
				<xsl:call-template name="build-insurance-ds-details-dojo-items">
					<xsl:with-param name="items" select="insurance_dataset/InsrncDataSetReqrd" />
					<xsl:with-param name="id" select="insurance-ds" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>		
	
	<xd:doc>
		<xd:short>Certificate Dataset</xd:short>
		<xd:detail>
			This template contains Certificate dataset section .
 		</xd:detail>
	</xd:doc>
	<xsl:template name="certificate-ds-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_PURCHASE_ORDER_CERTIFICATE_DATASET_DETAILS</xsl:with-param>
			<xsl:with-param name="content">&nbsp;
				<xsl:call-template name="build-certificate-ds-details-dojo-items">
					<xsl:with-param name="items" select="certificate_dataset/CertDataSetReqrd" />
					<xsl:with-param name="id" select="certificate-ds" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xd:doc>
		<xd:short>Other Certificate Dataset</xd:short>
		<xd:detail>
			This template contains Other Certificate dataset section,calls another template 'build-other-certificate-ds-details-dojo-items'.
 		</xd:detail>
	</xd:doc>
	<xsl:template name="other-certificate-ds-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_PURCHASE_ORDER_OTHER_CERTIFICATE_DATASET_DETAILS</xsl:with-param>
			<xsl:with-param name="content">&nbsp;
				<xsl:call-template name="build-other-certificate-ds-details-dojo-items">
					<xsl:with-param name="items" select="other_certificate_dataset/OthrCertDataSetReqrd" />
					<xsl:with-param name="id" select="other-certificate-ds" />
				</xsl:call-template>

			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>	
	
	<xd:doc>
		<xd:short>Bank Payment Obligation Dataset</xd:short>
		<xd:detail>
			This template contains section of banks payment obligation.
 		</xd:detail>
	</xd:doc>
	<xsl:template name="bank-payment-obligation-ds-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_PURCHASE_ORDER_BPO_DATASET_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				&nbsp;
				<xsl:call-template name="build-bank-payment-obligation-details-dojo-items">
					<xsl:with-param name="items" select="bank_payment_obligation/PmtOblgtn" />
					<xsl:with-param name="id" select="bank-payment-obligation-ds" />
				</xsl:call-template>
				
			</xsl:with-param>
		</xsl:call-template>

	</xsl:template>
	
	<!-- Baseline Payment terms -->
	<xd:doc>
		<xd:short>BaseLine Payment Details</xd:short>
		<xd:detail>
			This template contains BaseLine Payment Terms Section.
 		</xd:detail>
	</xd:doc>
	<xsl:template name="baseline-payment-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_PAYMENT_TERMS_DETAILS</xsl:with-param>
			<xsl:with-param name="content">&nbsp;
				<xsl:call-template name="build-baseline-payments-details">
					<xsl:with-param name="items" select="forward_dataset_submission/FwdDataSetSubmissnRpt/ComrclDataSet/PmtTerms" />
					<xsl:with-param name="id">baseline-payments</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!-- Amount Details Fieldset. -->
	<xd:doc>
		<xd:short>BaseLine Amount Details</xd:short>
		<xd:detail>
			This template contains BaseLine Amount details section which contains total line item amount,outstanding line item amount etc.
 		</xd:detail>
	</xd:doc>
	<xsl:template name="baseline-amount-details">
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_ORDERED_LINE_ITEMS_TOTAL_AMOUNT</xsl:with-param>
			<xsl:with-param name="name">order_total_amt</xsl:with-param>
			<xsl:with-param name="type">amount</xsl:with-param>
			<xsl:with-param name="currency-value"><xsl:value-of select="total_cur_code" /></xsl:with-param>
			<xsl:with-param name="value">
		        <xsl:if test="$displaymode='view'">
		         <xsl:value-of select="total_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="order_total_amt"></xsl:value-of>
		        </xsl:if>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_ACCEPTED_LINE_ITEMS_TOTAL_AMOUNT</xsl:with-param>
			<xsl:with-param name="name">accpt_total_amt</xsl:with-param>
			<xsl:with-param name="type">amount</xsl:with-param>
			<xsl:with-param name="currency-value"><xsl:value-of select="total_cur_code" /></xsl:with-param>
			<xsl:with-param name="value">
		        <xsl:if test="$displaymode='view'">
		         <xsl:value-of select="total_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="accpt_total_amt"></xsl:value-of>
		        </xsl:if>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_OUTSTANDING_LINE_ITEMS_TOTAL_AMOUNT</xsl:with-param>
			<xsl:with-param name="name">outstanding_total_amt</xsl:with-param>
			<xsl:with-param name="type">amount</xsl:with-param>
			<xsl:with-param name="currency-value"><xsl:value-of select="total_cur_code" /></xsl:with-param>
			<xsl:with-param name="value">
		        <xsl:if test="$displaymode='view'">
		         <xsl:value-of select="total_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="outstanding_total_amt"></xsl:value-of>
		        </xsl:if>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_PENDING_LINE_ITEMS_TOTAL_AMOUNT</xsl:with-param>
			<xsl:with-param name="name">pending_total_amt</xsl:with-param>
			<xsl:with-param name="type">amount</xsl:with-param>
			<xsl:with-param name="currency-value"><xsl:value-of select="total_cur_code" /></xsl:with-param>
			<xsl:with-param name="value">
		        <xsl:if test="$displaymode='view'">
		         <xsl:value-of select="total_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="pending_total_amt"></xsl:value-of>
		        </xsl:if>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_ORDERED_NET_TOTAL_AMOUNT</xsl:with-param>
			<xsl:with-param name="name">order_total_net_amt</xsl:with-param>
			<xsl:with-param name="type">amount</xsl:with-param>
			<xsl:with-param name="currency-value"><xsl:value-of select="total_cur_code" /></xsl:with-param>
			<xsl:with-param name="value">
		        <xsl:if test="$displaymode='view'">
		         <xsl:value-of select="total_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="order_total_net_amt"></xsl:value-of>
		        </xsl:if>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_ACCEPTED_NET_TOTAL_AMOUNT</xsl:with-param>
			<xsl:with-param name="name">accpt_total_net_amt</xsl:with-param>
			<xsl:with-param name="type">amount</xsl:with-param>
			<xsl:with-param name="currency-value"><xsl:value-of select="total_cur_code" /></xsl:with-param>
			<xsl:with-param name="value">
		        <xsl:if test="$displaymode='view'">
		         <xsl:value-of select="total_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="accpt_total_net_amt"></xsl:value-of>
		        </xsl:if>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_OUTSTANDING_NET_TOTAL_AMOUNT</xsl:with-param>
			<xsl:with-param name="name">outstanding_total_net_amt</xsl:with-param>
			<xsl:with-param name="type">amount</xsl:with-param>
			<xsl:with-param name="currency-value"><xsl:value-of select="total_cur_code" /></xsl:with-param>
			<xsl:with-param name="value">
		        <xsl:if test="$displaymode='view'">
		         <xsl:value-of select="total_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="outstanding_total_net_amt"></xsl:value-of>
		        </xsl:if>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_PENDING_NET_TOTAL_AMOUNT</xsl:with-param>
			<xsl:with-param name="name">pending_total_net_amt</xsl:with-param>
			<xsl:with-param name="type">amount</xsl:with-param>
			<xsl:with-param name="currency-value"><xsl:value-of select="total_cur_code" /></xsl:with-param>
			<xsl:with-param name="value">
		        <xsl:if test="$displaymode='view'">
		         <xsl:value-of select="total_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="pending_total_net_amt"></xsl:value-of>
		        </xsl:if>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Commercial Goods Details</xd:short>
		<xd:detail>
			This template contains commercial goods details header section.
 		</xd:detail>
	</xd:doc>
	<xsl:template name="commercial-goods-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_LINE_ITEMS</xsl:with-param>
			<xsl:with-param name="content">&nbsp;
				<!-- Line items grid -->
				<xsl:call-template name="build-commercial-dataset-line-items-dojo-items">
					<xsl:with-param name="items" select="forward_dataset_submission/FwdDataSetSubmissnRpt/ComrclDataSet/Goods/ComrclLineItms" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		
	</xsl:template>
	
	<!-- Delta Report Display in Tabular Format -->
	
	<xd:doc>
		<xd:short>Delta Report</xd:short>
		<xd:detail>
			This template contains Delta Report Section.
 		</xd:detail>
 		<xd:param name="node">Provides path for test condition</xd:param>
	</xd:doc>
	<xsl:template name="delta-report-declaration">
		<xsl:param name="node"/>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_DELTA_REPORT_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<div id="delta-report-template">
					<div class="clear multigrid">
						<div style="width:100%;height:100%;" class="widgetContainer clear">
							<table border="0" cellpadding="0" cellspacing="0" class="attachments">
						     <xsl:attribute name="id">invoice_table</xsl:attribute>
						      	<xsl:if test="$node/UpdtdElmt">
							      <thead>
							       <tr>
								       <th class="medium-tblheader" scope="col"></th>
								       <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_ELEMENT_NAME')"/></th>
								       <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_CURRENT_VALUE')"/></th>
								       <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_PROPOSED_VALUE')"/></th>
								       <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION')"/></th>
							       </tr>
							      </thead>
							      <tbody>
									<xsl:attribute name="id">updated_details_table</xsl:attribute>      
							        <xsl:for-each select="$node/UpdtdElmt">
										<xsl:variable name="updatedElement" select="." />
							          <tr>
							          	<td><xsl:value-of select="$updatedElement/ElmtSeqNb"/></td>
							         	<td><xsl:value-of select="$updatedElement/ElmtPth"/><xsl:value-of select="$updatedElement/ElmtNm"/></td>
							         	<xsl:choose>
							         		<xsl:when test="$updatedElement/Rplcmnt/CurVal">
							         			<td><xsl:value-of select="$updatedElement/Rplcmnt/CurVal" /></td>
							         		</xsl:when>
							         		<xsl:when test="$updatedElement/Deltn/DeltdVal">
							         			<td><xsl:value-of select="$updatedElement/Deltn/DeltdVal" /></td>
							         		</xsl:when>
							         		<xsl:otherwise>
							         			<td></td>
							         		</xsl:otherwise>
						         		</xsl:choose>
						         		<xsl:choose>
							         		<xsl:when test="$updatedElement/Rplcmnt/PropsdVal">
							         			<td><xsl:value-of select="$updatedElement/Rplcmnt/PropsdVal" /></td>
							         		</xsl:when>
							         		<xsl:when test="$updatedElement/Addtn/PropsdVal">
							         			<td><xsl:value-of select="$updatedElement/Addtn/PropsdVal" /></td>
							         		</xsl:when>
							         		<xsl:otherwise>
							         			<td></td>
							         		</xsl:otherwise>
						         		</xsl:choose>
						         		<xsl:choose>
						         			<xsl:when test="$updatedElement/Rplcmnt">
						         				<td><xsl:value-of select="localization:getGTPString($language, 'XSL_UPDATION')"/></td>
						         			</xsl:when>
						         			<xsl:when test="$updatedElement/Addtn">
							         			<td><xsl:value-of select="localization:getGTPString($language, 'XSL_ADDITION')"/></td>
							         		</xsl:when>
							         		<xsl:otherwise>
							         			<td><xsl:value-of select="localization:getGTPString($language, 'XSL_DELETION')"/></td>
							         		</xsl:otherwise>
						         		</xsl:choose>
							          </tr>
							         </xsl:for-each>
							      </tbody>
							    </xsl:if>
						     </table>			
							<div class="clear" style="height:1px">&nbsp;</div>
						</div>
					</div>
				</div>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	
	<!--  Documents required Fieldset. -->
	<xd:doc>
		<xd:short>Documents Required</xd:short>
		<xd:detail>
			This template sets different parameter(such as label,size etc) for different template called inside this
 		</xd:detail>
	</xd:doc>
	<xsl:template name="oa-documents-required">
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
						<xsl:with-param name="radio-value"><xsl:value-of select="reqrd_commercial_dataset" /></xsl:with-param>
						<xsl:with-param name="checked">
							<xsl:if test="reqrd_commercial_dataset[. = 'Y' or . = '']">Y</xsl:if>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="radio-field">
						<xsl:with-param name="label">XSL_PURCHASE_ORDER_COMMERCIAL_DATASET_NOT_REQUIRED</xsl:with-param>
						<xsl:with-param name="name">reqrd_commercial_dataset</xsl:with-param>
						<xsl:with-param name="id">reqrd_commercial_dataset_2</xsl:with-param>
						<xsl:with-param name="value">N</xsl:with-param>
						<xsl:with-param name="radio-value"><xsl:value-of select="reqrd_commercial_dataset" /></xsl:with-param>
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
						<xsl:with-param name="radio-value"><xsl:value-of select="reqrd_transport_dataset" /></xsl:with-param>
						<xsl:with-param name="checked">
							<xsl:if test="reqrd_transport_dataset[. = 'Y']">Y</xsl:if>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="radio-field">
						<xsl:with-param name="label">XSL_PURCHASE_ORDER_TRANSPORT_DATASET_NOT_REQUIRED</xsl:with-param>
						<xsl:with-param name="name">reqrd_transport_dataset</xsl:with-param>
						<xsl:with-param name="id">reqrd_transport_dataset_2</xsl:with-param>
						<xsl:with-param name="value">N</xsl:with-param>
						<xsl:with-param name="radio-value"><xsl:value-of select="reqrd_transport_dataset" /></xsl:with-param>
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

	
	
	
	<!-- Amount Details Fieldset. -->
	<xd:doc>
		<xd:short>Amount Details</xd:short>
		<xd:detail>
			This template contains Amount Details Section which contains section of adjustment, charges and freight charges.It contains freight charges type(collect/prepaid) and total net amount. 
 		</xd:detail>
	</xd:doc>
	<xsl:template name="amount-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				&nbsp;
				<!-- show amout details only for new payment initiation and for  Intent to Pay -->
                <xsl:if test="product_code [.='EA'] and  (not(tnx_type_code) or tnx_type_code[.='59'])">
                    <xsl:call-template name="baseline-amount-details" />
                </xsl:if>
				<!-- Adjustments -->
				<xsl:if test="$displaymode='edit' or ($displaymode='view' and ./adjustments/adjustment)">
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
				<xsl:if test="not(tnx_type_code) or tnx_type_code[. != '49']">
					<xsl:choose>
						<xsl:when test="prod_stat_code[.='A6'] and tnx_type_code[.='61']">
							<xsl:if test="$displaymode='edit' or ($displaymode='view' and ./freightCharges/freightCharge)">
								<xsl:call-template name="freight-charge-details" />
							</xsl:if>
							<xsl:if test="$displaymode='edit' or ($displaymode='view' and ./taxes/tax)">
								<xsl:call-template name="taxes-details" />
							</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<xsl:if test="$displaymode='edit' or ($displaymode='view' and ./taxes/tax)">
								<xsl:call-template name="taxes-details" />
							</xsl:if>
							<xsl:if test="$displaymode='edit' or ($displaymode='view' and ./freightCharges/freightCharge)">
								<xsl:call-template name="freight-charge-details" />
							</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
				
					<!-- Line Item Net Amount -->
					&nbsp;
					<xsl:call-template name="currency-field">
						<xsl:with-param name="label">XSL_AMOUNTDETAILS_PO_TOTAL_NET_AMT_LABEL</xsl:with-param>
						<xsl:with-param name="override-currency-name">total_net_cur_code</xsl:with-param>
						<xsl:with-param name="override-amt-name">total_net_amt</xsl:with-param>
						<xsl:with-param name="amt-readonly">Y</xsl:with-param>
						<xsl:with-param name="currency-readonly">Y</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
						<xsl:with-param name="show-button">N</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
                &nbsp;
                
                <xsl:if test="product_code [.='EA'] and prod_stat_code[.='54']">
                    <xsl:if test="intent_to_pay_amt[. != '']">
                        <xsl:call-template name="input-field">
                            <xsl:with-param name="label">XSL_INTENT_TO_PAY_AMOUNT</xsl:with-param>
                            <xsl:with-param name="id">intent_to_pay_amt</xsl:with-param>
                            <xsl:with-param name="value">
                                <xsl:value-of select="total_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="intent_to_pay_amt"></xsl:value-of>
                            </xsl:with-param>
                            <xsl:with-param name="override-displaymode">view</xsl:with-param>
                        </xsl:call-template>
                        <xsl:call-template name="hidden-field">
                           <xsl:with-param name="name">intent_to_pay_amt</xsl:with-param>
                           <xsl:with-param name="value" select="intent_to_pay_amt"/>
                         </xsl:call-template>
                    </xsl:if>
                    <xsl:call-template name="currency-field">
                        <xsl:with-param name="label">XSL_FINANCE_AMOUNT</xsl:with-param>
                        <xsl:with-param name="override-currency-name">finance_cur_code</xsl:with-param>
                        <xsl:with-param name="override-amt-name">finance_amt</xsl:with-param>
                        <xsl:with-param name="amt-readonly">N</xsl:with-param>
                        <xsl:with-param name="currency-readonly">Y</xsl:with-param>
                        <xsl:with-param name="required">Y</xsl:with-param>
                        <xsl:with-param name="show-button">N</xsl:with-param>
                    </xsl:call-template>
                    <xsl:call-template name="currency-field">
	                    <xsl:with-param name="label">XSL_REQUESTING_FINANCE_CUR_CODE</xsl:with-param>
	                    <xsl:with-param name="product-code">request_finance</xsl:with-param>
	                    <xsl:with-param name="override-currency-name">request_finance_cur_code</xsl:with-param>
	                    <xsl:with-param name="required">Y</xsl:with-param>
	                    <xsl:with-param name="currency-readonly">N</xsl:with-param>
	                    <xsl:with-param name="show-amt">N</xsl:with-param>
	                    <xsl:with-param name="show-button">Y</xsl:with-param>
                	</xsl:call-template>              
                </xsl:if>

			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Warning Section</xd:short>
		<xd:detail>
			This displays the warnings in the top pof the page..
 		</xd:detail> 		
 	</xd:doc>
	<xsl:template name = "warnings">
		<div id ='warningsHeader'>
			<xsl:call-template name="animatedFieldSetHeader">
		   		<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_WARNINGS')"/></xsl:with-param>
		   		<xsl:with-param name="animateDivId">warning</xsl:with-param>
		   		<xsl:with-param name="prefix">warning</xsl:with-param>
		   		<xsl:with-param name="onClickFlag">Y</xsl:with-param>
		   	</xsl:call-template>
		   	<div id='warning' class="serverMessage">
			   	<!-- <xsl:variable name = "errorMsg"><xsl:value-of select ="error_msg"/></xsl:variable> -->
			   	<xsl:call-template name ="tokenize-string">
			   		<xsl:with-param name ="text"><xsl:value-of select ="error_msg"/></xsl:with-param>
			   		<xsl:with-param name ="delimiter">:</xsl:with-param>
			   	</xsl:call-template>
	   	    </div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Tokenizing the String</xd:short>
		<xd:detail>
			Tokenize the string and fetches the localization
 		</xd:detail> 		
 	</xd:doc>
	<xsl:template name ="tokenize-string">
	<xsl:param name = "text"/>
	<xsl:param name = "delimiter">:</xsl:param>
	<xsl:choose>
		<xsl:when test="substring-before($text, $delimiter) != ''">	
			<xsl:value-of select="localization:getGTPString($language, substring-before($text, $delimiter))"/><br />
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="localization:getGTPString($language, $text)"/>
		</xsl:otherwise>
	</xsl:choose>
    <xsl:if test="contains($text,$delimiter)">
        <xsl:call-template name="tokenize-string">
            <xsl:with-param name="text" select="substring-after($text, $delimiter)"/>
            <xsl:with-param name ="delimiter"><xsl:value-of select ="$delimiter"/></xsl:with-param>
        </xsl:call-template>
    </xsl:if>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Transport Document Reference Declaration</xd:short>
		<xd:detail>
			This templates displayes no Transport Document Reference or add Transport Document Reference required button.
 		</xd:detail>	
 	</xd:doc>
	<xsl:template name="transport-document-ref-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="transport-document-ref-dialog-declaration" />
		<!-- Dialog End -->
		<div id="transport-document-ref-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_NO_TRANSPORT_DOC_REF')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_ADD_TRANSPORT_DOC_REF')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Transport Document Reference Dialog declaration</xd:short>
		<xd:detail>
			This templates adds a title attributes and and fills it with it Confirmation,it also defines variables and sets the parameters of Transport Document Reference required field in Transport dataset based on these
			variables in input and select field.It also adds parameter of the hidden field and adds Cancel and Ok button to the Transport Document Reference dialog box
 		</xd:detail>	
 	</xd:doc>
	<xsl:template name="transport-document-ref-dialog-declaration">
		<div id="transport-document-reference-dialog-template" style="display:none"
			class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>

					<div>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DATA_SET_ID</xsl:with-param>
							<xsl:with-param name="name">payment_tds_doc_id</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="required"><xsl:choose>
					  	  			 <xsl:when test="$displaymode = 'edit'">Y</xsl:when>
					  	  			 <xsl:otherwise>N</xsl:otherwise>
				  	  			 </xsl:choose>
				  	  		</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="disabled">
				  	  			 <xsl:choose>
					  	  			 <xsl:when test="$displaymode = 'edit'">N</xsl:when>
					  	  			 <xsl:otherwise>Y</xsl:otherwise>
				  	  			 </xsl:choose>
			  	  			 </xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DATA_SET_ISS_DATE</xsl:with-param>
							<xsl:with-param name="name">payment_tds_doc_iss_date</xsl:with-param>
							<xsl:with-param name="type">date</xsl:with-param>
							<xsl:with-param name="size">10</xsl:with-param>
							<xsl:with-param name="maxsize">10</xsl:with-param>
							<xsl:with-param name="fieldsize">small</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="required">
								<xsl:choose>
					  	  			 <xsl:when test="$displaymode = 'edit'">Y</xsl:when>
					  	  			 <xsl:otherwise>N</xsl:otherwise>
				  	  			 </xsl:choose>
				  	  		</xsl:with-param>
							<xsl:with-param name="disabled">
				  	  			 <xsl:choose>
					  	  			 <xsl:when test="$displaymode = 'edit'">N</xsl:when>
					  	  			 <xsl:otherwise>Y</xsl:otherwise>
				  	  			 </xsl:choose>
			  	  			 </xsl:with-param>
							<xsl:with-param name="value">
								<xsl:value-of select="payment_tds_doc_iss_date" />
							</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
						</xsl:call-template>
						<div class="dijitDialogPaneActionBar">
						<xsl:call-template name="label-wrapper">
							<xsl:with-param name="content">
								<button type="button" dojoType="dijit.form.Button">
									<xsl:attribute name="onmouseup">dijit.byId('transport-document-reference-dialog-template').hide();</xsl:attribute>
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
								</button>							
								<xsl:if test="$displaymode = 'edit'">
									<button dojoType="dijit.form.Button">
										<xsl:attribute name="onClick">dijit.byId('transport-document-reference-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
									</button>
								</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
						</div>
					</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Build Transport Document Reference </xd:short>
		<xd:detail>
			This templates displays header for diplaying Transport Document Reference field in transport dataset in add,edit and view mode,also displayes header of the Transport Document Reference table.
			It also defines variables and adds attributes of different fields in Transport Document Reference dialog fills it with given value.
 		</xd:detail>
 		<xd:param name="items"> </xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">Overridden display mode.</xd:param>		
 	</xd:doc>
 	<xsl:template name="build-transport-document-ref-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
		
		<div dojoType="misys.openaccount.widget.TransportDocumentReferences" dialogId="transport-document-reference-dialog-template">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_ADD_TRANSPORT_DOC_REF')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_EDIT_TRANSPORT_DOC_REF')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_VIEW_TRANSPORT_DOC_REF')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_DATA_SET_ID_HEADER')" />,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_DATA_SET_ISS_DATE_HEADER')" />
			</xsl:attribute>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
			 <xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="transportedDocRef" select="." />
					<div dojoType="misys.openaccount.widget.TransportDocumentReference">
						<xsl:attribute name="payment_tds_doc_id"><xsl:value-of
							select="$transportedDocRef/Id" />
						</xsl:attribute>
						<xsl:attribute name="payment_tds_doc_iss_date"><xsl:value-of select="tools:convertISODate2MTPDate($transportedDocRef/DtOfIsse,'en')" />
						</xsl:attribute>
					</div>
				</xsl:for-each>
			</xsl:if>
		</div>

	</xsl:template>
	
	<xd:doc>
		<xd:short>Transported Goods Declaration</xd:short>
		<xd:detail>
			This templates displayes no Transported Goods or add Transported Goods required button.
 		</xd:detail>	
 	</xd:doc>
	<xsl:template name="transported-goods-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="transported-goods-dialog-declaration" />
		<!-- Dialog End -->
		<div id="transported-goods-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_NO_TRANSPORTED_GOODS')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_ADD_TRANSPORTED_GOODS')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Transported Goods Dialog declaration</xd:short>
		<xd:detail>
			This templates adds a title attributes and and fills it with it Confirmation,it also defines variables and sets the parameters of Transported Goods required field in Transport dataset based on these
			variables in input and select field.It also adds parameter of the hidden field and adds Cancel and Ok button to the Transported Goods dialog box
 		</xd:detail>	
 	</xd:doc>
	<xsl:template name="transported-goods-dialog-declaration">
		<div id="transported-goods-dialog-template" style="display:none"
			class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>

					<div>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_GENERALDETAILS_PO_REF_ID</xsl:with-param>
							<xsl:with-param name="name">payment_tds_po_ref_id</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="required">
								<xsl:choose>
					  	  			 <xsl:when test="$displaymode = 'edit'">Y</xsl:when>
					  	  			 <xsl:otherwise>N</xsl:otherwise>
				  	  			 </xsl:choose>
				  	  		</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="disabled">
				  	  			 <xsl:choose>
					  	  			 <xsl:when test="$displaymode = 'edit'">N</xsl:when>
					  	  			 <xsl:otherwise>Y</xsl:otherwise>
				  	  			 </xsl:choose>
			  	  			 </xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_GENERALDETAILS_PO_ISS_DATE</xsl:with-param>
							<xsl:with-param name="name">payment_tds_po_iss_date</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="required">
								<xsl:choose>
					  	  			 <xsl:when test="$displaymode = 'edit'">Y</xsl:when>
					  	  			 <xsl:otherwise>N</xsl:otherwise>
				  	  			 </xsl:choose>
				  	  		</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="disabled">
				  	  			 <xsl:choose>
					  	  			 <xsl:when test="$displaymode = 'edit'">N</xsl:when>
					  	  			 <xsl:otherwise>Y</xsl:otherwise>
				  	  			 </xsl:choose>
			  	  			 </xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PURCHASE_ORDER_GOODS_DESC</xsl:with-param>
							<xsl:with-param name="name">payment_tds_goods_desc</xsl:with-param>
							<xsl:with-param name="size">70</xsl:with-param>
							<xsl:with-param name="maxsize">70</xsl:with-param>
							<xsl:with-param name="required">N</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>
						<div class="dijitDialogPaneActionBar">
						<xsl:call-template name="label-wrapper">
							<xsl:with-param name="content">
								<button type="button" dojoType="dijit.form.Button">
									<xsl:attribute name="onmouseup">dijit.byId('transported-goods-dialog-template').hide();</xsl:attribute>
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
								</button>							
								<xsl:if test="$displaymode = 'edit'">
									<button dojoType="dijit.form.Button">
										<xsl:attribute name="onClick">dijit.byId('transported-goods-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
									</button>
								</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
						</div>
					</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Build Transported Goods</xd:short>
		<xd:detail>
			This templates displays header for diplaying Transported Goods field in transport dataset in add,edit and view mode,also displayes header of the Transported Goods table.
			It also defines variables and adds attributes of different fields in Transported Goods dialog fills it with given value.
 		</xd:detail>
 		<xd:param name="items"> </xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">Overridden display mode.</xd:param>		
 	</xd:doc>
 	<xsl:template name="build-transported-goods-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
		
		<div dojoType="misys.openaccount.widget.TransportedGoodsDetails" dialogId="transported-goods-dialog-template">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_ADD_TRANSPORTED_GOODS')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_EDIT_TRANSPORTED_GOODS')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_VIEW_TRANSPORTED_GOODS')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'PO_REFERENCE')" />,
				<xsl:value-of select="localization:getGTPString($language, 'PO_ISS_DATE')" />,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_GOODS_DESC_HEADER')" />
			</xsl:attribute>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
			 <xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="transportedGoodsDetails" select="." />
					<div dojoType="misys.openaccount.widget.TransportedGoodsDetail">
						<xsl:attribute name="payment_tds_po_ref_id"><xsl:value-of
							select="$transportedGoodsDetails/PurchsOrdrRef/Id" />
						</xsl:attribute>
						<xsl:attribute name="payment_tds_po_iss_date"><xsl:value-of select="tools:convertISODate2MTPDate($transportedGoodsDetails/PurchsOrdrRef/DtOfIsse,'en')" />
						</xsl:attribute>
						<xsl:attribute name="payment_tds_goods_desc"><xsl:value-of
							select="$transportedGoodsDetails/GoodsDesc" />
						</xsl:attribute>
					</div>
				</xsl:for-each>
			</xsl:if>
		</div>

	</xsl:template>
	
	<xd:doc>
		<xd:short>Consignment Quantity Details Declaration</xd:short>
		<xd:detail>
			This templates displayes no Consignment Quantity Details or add Consignment Details required button.
 		</xd:detail>	
 	</xd:doc>
	<xsl:template name="consignment-qty-details-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="consignment-qty-details-dialog-declaration" />
		<!-- Dialog End -->
		<div id="consignment-qty-details-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_NO_CONSIGNMENT_QTY')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_ADD_CONSIGNMENT_QTY')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Consignment Quantity Details Dialog declaration</xd:short>
		<xd:detail>
			This templates adds a title attributes and and fills it with it Confirmation,it also defines variables and sets the parameters of Consignment Quantity Details required field in Transport dataset based on these
			variables in input and select field.It also adds parameter of the hidden field and adds Cancel and Ok button to the Consignment Details dialog box
 		</xd:detail>	
 	</xd:doc>
	<xsl:template name="consignment-qty-details-dialog-declaration">
		<div id="consignment-qty-details-dialog-template" style="display:none"
			class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>

					<div>
						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_HEADER_CONSIGNMENT_QTY</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="toc-item">N</xsl:with-param>
							<xsl:with-param name="content">
							
							<xsl:choose>
									<xsl:when test="$displaymode = 'edit'">
										<xsl:call-template name="select-field">
											<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_QUANTITY_CODE</xsl:with-param>
											<xsl:with-param name="name">pmt_tds_qty_unit_measr_code</xsl:with-param>
											<xsl:with-param name="override-displaymode">edit</xsl:with-param>
											<xsl:with-param name="required">Y</xsl:with-param>
											<xsl:with-param name="options">
												<xsl:call-template name="quantity-unit-measure-codes">
													<xsl:with-param name="field-name">pmt_tds_qty_unit_measr_code</xsl:with-param>
												</xsl:call-template>
											</xsl:with-param>
										</xsl:call-template>
										<xsl:call-template name="hidden-field">
											<xsl:with-param name="name">pmt_tds_qty_unit_measr_label</xsl:with-param>							
											<xsl:with-param name="value">
												<xsl:choose>
													<xsl:when test="pmt_tds_qty_unit_measr_code"><xsl:value-of select="localization:getDecode($language, 'N202', pmt_tds_qty_unit_measr_code)" /></xsl:when>
													<xsl:otherwise></xsl:otherwise>
												</xsl:choose>
											</xsl:with-param>							
										</xsl:call-template>
									</xsl:when>
									<xsl:otherwise>
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_QUANTITY_CODE</xsl:with-param>
											<xsl:with-param name="name">pmt_tds_qty_unit_measr_label</xsl:with-param>
											<xsl:with-param name="override-displaymode">edit</xsl:with-param>
											<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
											<xsl:with-param name="swift-validate">N</xsl:with-param>
											<xsl:with-param name="size">35</xsl:with-param>
											<xsl:with-param name="maxsize">35</xsl:with-param>
										</xsl:call-template>
									</xsl:otherwise>
								</xsl:choose>
								
								<!-- Quantity unit measure: Other -->
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_QUANTITY_OTHER</xsl:with-param>
									<xsl:with-param name="name">pmt_tds_qty_unit_measr_other</xsl:with-param>
									<xsl:with-param name="size">35</xsl:with-param>
									<xsl:with-param name="maxsize">35</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
								</xsl:call-template>
								
								<!-- Quantity value -->
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_QUANTITY_VALUE</xsl:with-param>
									<xsl:with-param name="name">pmt_tds_qty_val</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="swift-validate">N</xsl:with-param>
									<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
									<xsl:with-param name="regular-expression">^(?:\d{1,18}|(?=.*\.)(?!.*\..*\.)[\d.]{1,19})$</xsl:with-param>
									<xsl:with-param name="fieldsize">small</xsl:with-param>
									<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						
						<div class="dijitDialogPaneActionBar">
						<xsl:call-template name="label-wrapper">
							<xsl:with-param name="content">
								<button type="button" dojoType="dijit.form.Button">
									<xsl:attribute name="onmouseup">dijit.byId('consignment-qty-details-dialog-template').hide();</xsl:attribute>
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
								</button>							
								<xsl:if test="$displaymode = 'edit'">
									<button dojoType="dijit.form.Button">
										<xsl:attribute name="onClick">dijit.byId('consignment-qty-details-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
									</button>
								</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
						</div>
					</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Consignment Quantity</xd:short>
		<xd:detail>
			This templates displays header for diplaying Consignment Quantity field in transport dataset in add,edit and view mode,also displayes header of the Transport Document Reference table.
			It also defines variables and adds attributes of different fields in Transport Document Reference dialog fills it with given value.
 		</xd:detail>
 		<xd:param name="items"> </xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">Overridden display mode.</xd:param>		
 	</xd:doc>
 	<xsl:template name="build-consignment-qty-details-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
		
		<div dojoType="misys.openaccount.widget.ConsignmentQtyDetails" dialogId="consignment-qty-details-dialog-template">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_ADD_CONSIGNMENT_QTY')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_EDIT_CONSIGNMENT_QTY')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_VIEW_CONSIGNMENT_QTY')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_QUANTITY_CODE_HEADER')" />,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_CONSG_QUANTITY_VALUE_HEADER')" />,
			</xsl:attribute>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
			 <xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="consgQty" select="." />
					<div dojoType="misys.openaccount.widget.ConsignmentQtyDetail">
						<xsl:attribute name="pmt_tds_qty_unit_measr_code"><xsl:value-of
							select="$consgQty/pmt_tds_qty_unit_measr_code" />
						</xsl:attribute>
						<xsl:attribute name="pmt_tds_qty_unit_measr_other"><xsl:value-of
							select="$consgQty/pmt_tds_qty_unit_measr_other" />
						</xsl:attribute>
						<xsl:attribute name="pmt_tds_qty_val"><xsl:value-of
							select="$consgQty/pmt_tds_qty_val" />
						</xsl:attribute>
						<xsl:attribute name="type"><xsl:value-of select="pmt_tds_qty_unit_measr_code"/></xsl:attribute>
						<xsl:attribute name="type_label"><xsl:value-of
							select="localization:getDecode($language, 'N202', pmt_tds_qty_unit_measr_code)" /></xsl:attribute>
						<xsl:attribute name="other_type"><xsl:value-of select="pmt_tds_qty_unit_measr_other"/></xsl:attribute>
					</div>
				</xsl:for-each>
			</xsl:if>
		</div>

	</xsl:template>
	
	<xd:doc>
		<xd:short>Consignment Volume Details Declaration</xd:short>
		<xd:detail>
			This templates displayes no Consignment Volume Details or add Consignment Details required button.
 		</xd:detail>	
 	</xd:doc>
	<xsl:template name="consignment-vol-details-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="consignment-vol-details-dialog-declaration" />
		<!-- Dialog End -->
		<div id="consignment-vol-details-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_NO_CONSIGNMENT_VOL')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_ADD_CONSIGNMENT_VOL')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Consignment Volume Details Dialog declaration</xd:short>
		<xd:detail>
			This templates adds a title attributes and and fills it with it Confirmation,it also defines variables and sets the parameters of Consignment Volume Details required field in Transport dataset based on these
			variables in input and select field.It also adds parameter of the hidden field and adds Cancel and Ok button to the Consignment Details dialog box
 		</xd:detail>	
 	</xd:doc>
	<xsl:template name="consignment-vol-details-dialog-declaration">
		<div id="consignment-vol-details-dialog-template" style="display:none"
			class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>

					<div>
						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_HEADER_CONSIGNMENT_VOL</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="toc-item">N</xsl:with-param>
							<xsl:with-param name="content">
							
							<xsl:choose>
									<xsl:when test="$displaymode = 'edit'">
										<xsl:call-template name="select-field">
											<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_QUANTITY_CODE</xsl:with-param>
											<xsl:with-param name="name">pmt_tds_vol_unit_measr_code</xsl:with-param>
											<xsl:with-param name="override-displaymode">edit</xsl:with-param>
											<xsl:with-param name="required">Y</xsl:with-param>
											<xsl:with-param name="options">
												<xsl:call-template name="quantity-unit-measure-codes">
													<xsl:with-param name="field-name">pmt_tds_vol_unit_measr_code</xsl:with-param>
												</xsl:call-template>
											</xsl:with-param>
										</xsl:call-template>
										<xsl:call-template name="hidden-field">
											<xsl:with-param name="name">pmt_tds_vol_unit_measr_label</xsl:with-param>							
											<xsl:with-param name="value">
												<xsl:choose>
													<xsl:when test="pmt_tds_vol_unit_measr_code"><xsl:value-of select="localization:getDecode($language, 'N202', pmt_tds_vol_unit_measr_code)" /></xsl:when>
													<xsl:otherwise></xsl:otherwise>
												</xsl:choose>
											</xsl:with-param>							
										</xsl:call-template>
									</xsl:when>
									<xsl:otherwise>
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_QUANTITY_CODE</xsl:with-param>
											<xsl:with-param name="name">pmt_tds_vol_unit_measr_label</xsl:with-param>
											<xsl:with-param name="override-displaymode">edit</xsl:with-param>
											<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
											<xsl:with-param name="swift-validate">N</xsl:with-param>
											<xsl:with-param name="size">35</xsl:with-param>
											<xsl:with-param name="maxsize">35</xsl:with-param>
										</xsl:call-template>
									</xsl:otherwise>
								</xsl:choose>
								
								<!-- Quantity unit measure: Other -->
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_QUANTITY_OTHER</xsl:with-param>
									<xsl:with-param name="name">pmt_tds_vol_unit_measr_other</xsl:with-param>
									<xsl:with-param name="size">35</xsl:with-param>
									<xsl:with-param name="maxsize">35</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
								</xsl:call-template>
								
								<!-- Quantity value -->
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_QUANTITY_VALUE</xsl:with-param>
									<xsl:with-param name="name">pmt_tds_vol_val</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="swift-validate">N</xsl:with-param>
									<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
									<xsl:with-param name="regular-expression">^(?:\d{1,18}|(?=.*\.)(?!.*\..*\.)[\d.]{1,19})$</xsl:with-param>
									<xsl:with-param name="fieldsize">small</xsl:with-param>
									<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						
						<div class="dijitDialogPaneActionBar">
						<xsl:call-template name="label-wrapper">
							<xsl:with-param name="content">
								<button type="button" dojoType="dijit.form.Button">
									<xsl:attribute name="onmouseup">dijit.byId('consignment-vol-details-dialog-template').hide();</xsl:attribute>
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
								</button>							
								<xsl:if test="$displaymode = 'edit'">
									<button dojoType="dijit.form.Button">
										<xsl:attribute name="onClick">dijit.byId('consignment-vol-details-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
									</button>
								</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
						</div>
					</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Consignment Volume</xd:short>
		<xd:detail>
			This templates displays header for diplaying Consignment Volume field in transport dataset in add,edit and view mode,also displayes header of the Transport Document Reference table.
			It also defines variables and adds attributes of different fields in Transport Document Reference dialog fills it with given value.
 		</xd:detail>
 		<xd:param name="items"> </xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">Overridden display mode.</xd:param>		
 	</xd:doc>
 	<xsl:template name="build-consignment-vol-details-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
		
		<div dojoType="misys.openaccount.widget.ConsignmentVolDetails" dialogId="consignment-vol-details-dialog-template">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_ADD_CONSIGNMENT_VOL')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_EDIT_CONSIGNMENT_VOL')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_VIEW_CONSIGNMENT_VOL')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_QUANTITY_CODE_HEADER')" />,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_CONSG_VOLUME_VALUE_HEADER')" />,
			</xsl:attribute>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
			 <xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="consgVol" select="." />
					<div dojoType="misys.openaccount.widget.ConsignmentVolDetail">
						<xsl:attribute name="pmt_tds_vol_unit_measr_code"><xsl:value-of
							select="$consgVol/pmt_tds_vol_unit_measr_code" />
						</xsl:attribute>
						<xsl:attribute name="pmt_tds_vol_unit_measr_other"><xsl:value-of
							select="$consgVol/pmt_tds_vol_unit_measr_other" />
						</xsl:attribute>
						<xsl:attribute name="pmt_tds_vol_val"><xsl:value-of
							select="$consgVol/pmt_tds_vol_val" />
						</xsl:attribute>
						<xsl:attribute name="type"><xsl:value-of select="pmt_tds_vol_unit_measr_code"/></xsl:attribute>
						<xsl:attribute name="type_label"><xsl:value-of
							select="localization:getDecode($language, 'N202', pmt_tds_vol_unit_measr_code)" /></xsl:attribute>
						<xsl:attribute name="other_type"><xsl:value-of select="pmt_tds_vol_unit_measr_other"/></xsl:attribute>
					</div>
				</xsl:for-each>
			</xsl:if>
		</div>

	</xsl:template>
	
		<xd:doc>
		<xd:short>Consignment Weight Details Declaration</xd:short>
		<xd:detail>
			This templates displayes no Consignment Weight Details or add Consignment Details required button.
 		</xd:detail>	
 	</xd:doc>
	<xsl:template name="consignment-weight-details-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="consignment-weight-details-dialog-declaration" />
		<!-- Dialog End -->
		<div id="consignment-weight-details-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_NO_CONSIGNMENT_WEIGHT')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_ADD_CONSIGNMENT_WEIGHT')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Consignment Weight Details Dialog declaration</xd:short>
		<xd:detail>
			This templates adds a title attributes and and fills it with it Confirmation,it also defines variables and sets the parameters of Consignment Weight Details required field in Transport dataset based on these
			variables in input and select field.It also adds parameter of the hidden field and adds Cancel and Ok button to the Consignment Details dialog box
 		</xd:detail>	
 	</xd:doc>
	<xsl:template name="consignment-weight-details-dialog-declaration">
		<div id="consignment-weight-details-dialog-template" style="display:none"
			class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>

					<div>
						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_HEADER_CONSIGNMENT_WEIGHT</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="toc-item">N</xsl:with-param>
							<xsl:with-param name="content">
							
							<xsl:choose>
									<xsl:when test="$displaymode = 'edit'">
										<xsl:call-template name="select-field">
											<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_QUANTITY_CODE</xsl:with-param>
											<xsl:with-param name="name">pmt_tds_weight_unit_measr_code</xsl:with-param>
											<xsl:with-param name="override-displaymode">edit</xsl:with-param>
											<xsl:with-param name="required">Y</xsl:with-param>
											<xsl:with-param name="options">
												<xsl:call-template name="quantity-unit-measure-codes">
													<xsl:with-param name="field-name">pmt_tds_weight_unit_measr_code</xsl:with-param>
												</xsl:call-template>
											</xsl:with-param>
										</xsl:call-template>
										<xsl:call-template name="hidden-field">
											<xsl:with-param name="name">pmt_tds_weight_unit_measr_label</xsl:with-param>							
											<xsl:with-param name="value">
												<xsl:choose>
													<xsl:when test="pmt_tds_weight_unit_measr_code"><xsl:value-of select="localization:getDecode($language, 'N202', pmt_tds_weight_unit_measr_code)" /></xsl:when>
													<xsl:otherwise></xsl:otherwise>
												</xsl:choose>
											</xsl:with-param>							
										</xsl:call-template>
									</xsl:when>
									<xsl:otherwise>
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_QUANTITY_CODE</xsl:with-param>
											<xsl:with-param name="name">pmt_tds_weight_unit_measr_label</xsl:with-param>
											<xsl:with-param name="override-displaymode">edit</xsl:with-param>
											<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
											<xsl:with-param name="swift-validate">N</xsl:with-param>
											<xsl:with-param name="size">35</xsl:with-param>
											<xsl:with-param name="maxsize">35</xsl:with-param>
										</xsl:call-template>
									</xsl:otherwise>
								</xsl:choose>
								
								<!-- Quantity unit measure: Other -->
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_QUANTITY_OTHER</xsl:with-param>
									<xsl:with-param name="name">pmt_tds_weight_unit_measr_other</xsl:with-param>
									<xsl:with-param name="size">35</xsl:with-param>
									<xsl:with-param name="maxsize">35</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
								</xsl:call-template>
								
								<!-- Quantity value -->
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_QUANTITY_VALUE</xsl:with-param>
									<xsl:with-param name="name">pmt_tds_weight_val</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="swift-validate">N</xsl:with-param>
									<xsl:with-param name="required">Y</xsl:with-param>
									<xsl:with-param name="regular-expression">^(?:\d{1,18}|(?=.*\.)(?!.*\..*\.)[\d.]{1,19})$</xsl:with-param>
									<xsl:with-param name="fieldsize">small</xsl:with-param>
									<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						
						<div class="dijitDialogPaneActionBar">
						<xsl:call-template name="label-wrapper">
							<xsl:with-param name="content">
								<button type="button" dojoType="dijit.form.Button">
									<xsl:attribute name="onmouseup">dijit.byId('consignment-weight-details-dialog-template').hide();</xsl:attribute>
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
								</button>							
								<xsl:if test="$displaymode = 'edit'">
									<button dojoType="dijit.form.Button">
										<xsl:attribute name="onClick">dijit.byId('consignment-weight-details-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
									</button>
								</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
						</div>
					</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Consignment Weight</xd:short>
		<xd:detail>
			This templates displays header for diplaying Consignment Weight field in transport dataset in add,edit and view mode,also displayes header of the Transport Document Reference table.
			It also defines variables and adds attributes of different fields in Transport Document Reference dialog fills it with given value.
 		</xd:detail>
 		<xd:param name="items"> </xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">Overridden display mode.</xd:param>		
 	</xd:doc>
 	<xsl:template name="build-consignment-weight-details-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
		
		<div dojoType="misys.openaccount.widget.ConsignmentWeightDetails" dialogId="consignment-weight-details-dialog-template">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_ADD_CONSIGNMENT_WEIGHT')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_EDIT_CONSIGNMENT_WEIGHT')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_VIEW_CONSIGNMENT_WEIGHT')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_QUANTITY_CODE_HEADER')" />,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_CONSG_WEIGHT_VALUE_HEADER')" />,
			</xsl:attribute>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
			 <xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="consgWeight" select="." />
					<div dojoType="misys.openaccount.widget.ConsignmentWeightDetail">
						<xsl:attribute name="pmt_tds_weight_unit_measr_code"><xsl:value-of
							select="$consgWeight/pmt_tds_weight_unit_measr_code" />
						</xsl:attribute>
						<xsl:attribute name="pmt_tds_weight_unit_measr_other"><xsl:value-of
							select="$consgWeight/pmt_weight_qty_unit_measr_other" />
						</xsl:attribute>
						<xsl:attribute name="pmt_tds_weight_val"><xsl:value-of
							select="$consgWeight/pmt_tds_weight_val" />
						</xsl:attribute>
						<xsl:attribute name="type"><xsl:value-of select="pmt_tds_weight_unit_measr_code"/></xsl:attribute>
						<xsl:attribute name="type_label"><xsl:value-of
							select="localization:getDecode($language, 'N202', pmt_tds_weight_unit_measr_code)" /></xsl:attribute>
						<xsl:attribute name="other_type"><xsl:value-of select="pmt_tds_weight_unit_measr_other"/></xsl:attribute>
					</div>
				</xsl:for-each>
			</xsl:if>
		</div>

	</xsl:template>
	
	<xsl:template name="freight-charge-details">
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
	</xsl:template>
	
	<xsl:template name="taxes-details">
	
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
	
	</xsl:template>
	
	<!-- Mismatch Report Display in Tabular Format -->
	
	<xd:doc>
		<xd:short>Mismatch Report</xd:short>
		<xd:detail>
			This template contains Mismatch Report Section.
 		</xd:detail>
 		<xd:param name="node">Provides path for test condition</xd:param>
	</xd:doc>
	<xsl:template name="mismatch-report-declaration">
		<xsl:param name="node"/>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_MISMATCH_REPORT_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<div id="delta-report-template">
					<div class="clear multigrid">
						<div style="width:100%;height:100%;" class="widgetContainer clear">
							<table border="0" cellpadding="0" cellspacing="0" class="attachments">
						     <xsl:attribute name="id">invoice_table</xsl:attribute>
						     	 <thead>
							       <tr>
								       <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_MISMATCH_SEQ_NO_HEADER')"/></th>
								       <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_MISMATCH_DETAILS_HEADER')"/></th>
								       <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_ELEMENT_NAME')"/></th>
								       <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_ELEMENT_VALUE')"/></th>
							       </tr>
							      </thead>
							      <tbody>
							      	<xsl:call-template name="mismatches">
								      	<xsl:with-param name="outerLimit"><xsl:value-of select="count($node/MisMtchInf)"/></xsl:with-param>
								      	<xsl:with-param name="node" select ="$node"></xsl:with-param>
							      	</xsl:call-template>
							      </tbody>
						     </table>			
							<div class="clear" style="height:1px">&nbsp;</div>
						</div>
					</div>
				</div>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="mismatches">
	<xsl:param name="outerCounter">1</xsl:param>
	<xsl:param name="node"/>
	<xsl:param name="outerLimit"/>
	<xsl:param name="innerLimit"><xsl:value-of select="count($node/MisMtchInf[number($outerCounter)]/MisMtchdElmt)"></xsl:value-of></xsl:param>
	<xsl:param name="innerCounter">1</xsl:param>
	<tr>
		<td><xsl:attribute name="rowspan"><xsl:value-of select="$innerLimit"/></xsl:attribute> 
			<xsl:value-of select="$node/MisMtchInf[number($outerCounter)]/SeqNb"/></td>
		<td><xsl:attribute name="rowspan"><xsl:value-of select="$innerLimit"/></xsl:attribute>
			<xsl:value-of select="$node/MisMtchInf[number($outerCounter)]/RuleDesc"/></td>
		<td><xsl:value-of select="$node/MisMtchInf[number($outerCounter)]/MisMtchdElmt[number($innerCounter)]/ElmtNm"/></td>
		<td><xsl:value-of select="$node/MisMtchInf[number($outerCounter)]/MisMtchdElmt[number($innerCounter)]/ElmtVal"/></td>
	</tr>
	
	<xsl:call-template name="mismatch-element">
		<xsl:with-param name="innerCounter"><xsl:value-of select="number($innerCounter)+1"/></xsl:with-param>
		<xsl:with-param name="node" select="$node/MisMtchInf[number($outerCounter)]"/>
		<xsl:with-param name="innerLimit" select="$innerLimit"/>
	</xsl:call-template>
		
	<xsl:if test="number($outerCounter)+1 &lt;= number($outerLimit)">
		<xsl:call-template name="mismatches">
			<xsl:with-param name="outerCounter"><xsl:value-of select="number($outerCounter)+1"/></xsl:with-param>
			<xsl:with-param name="node" select="$node"/>
			<xsl:with-param name="outerLimit" select="$outerLimit"/>
		</xsl:call-template>
	</xsl:if>
	</xsl:template>
	
	<xsl:template name= "mismatch-element">
	<xsl:param name="innerCounter"/>
	<xsl:param name="node"/>
	<xsl:param name="innerLimit"/>
	<tr>
		<td><xsl:value-of select="$node/MisMtchdElmt[number($innerCounter)]/ElmtNm"/></td>
		<td><xsl:value-of select="$node/MisMtchdElmt[number($innerCounter)]/ElmtVal"/></td>
	</tr>
	<xsl:if test="number($innerCounter)+1 &lt;= number($innerLimit)">
		<xsl:call-template name="mismatch-element">
			<xsl:with-param name="innerCounter"><xsl:value-of select="number($innerCounter)+1"/></xsl:with-param>
			<xsl:with-param name="node" select="$node"/>
			<xsl:with-param name="innerLimit" select="$innerLimit"/>
		</xsl:call-template>
	</xsl:if>
	</xsl:template>
	
	<!-- Instructions to Bank -->
   <xsl:template name="instructions-to-bank">
    <xsl:param name="value" />
    <xsl:param name="displaymode" />
    <xsl:param name="toc-item">Y</xsl:param>
    <xsl:param name="required">Y</xsl:param>
   		<xsl:call-template name="fieldset-wrapper">
	  		<xsl:with-param name="legend">XSL_HEADER_INSTRUCTION_TO_BANK</xsl:with-param>
	   		<xsl:with-param name="id">free_format_text</xsl:with-param>
	   		<xsl:with-param name="toc-item" select="$toc-item"/>
	   		<xsl:with-param name="content">
	   		&nbsp;
			    <xsl:call-template name="textarea-field">
					<xsl:with-param name="label"></xsl:with-param>
					<xsl:with-param name="name">free_format_text</xsl:with-param>
					<xsl:with-param name="messageValue"><xsl:value-of select="$value"/></xsl:with-param>
					<xsl:with-param name="rows">5</xsl:with-param>
				   	<xsl:with-param name="cols">50</xsl:with-param>
			   		<xsl:with-param name="maxlines">300</xsl:with-param>
			   		<xsl:with-param name="override-displaymode"><xsl:value-of select="$displaymode"/>
			   		</xsl:with-param>
			   		
			 	</xsl:call-template>
	   		</xsl:with-param>
   		</xsl:call-template>
   </xsl:template>	
   
   <!-- Commercial Document Reference Block -->
	<xd:doc>
		<xd:short>Commercial Document Details</xd:short>
		<xd:detail>
			This template contains Commercial Document Details Section which calls input boxes for Invoice number and Commercial Document issue date.
		</xd:detail>
	</xd:doc>
	<xsl:template name="commercial-document-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_PURCHASE_ORDER_COMMERCIAL_DATASET_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				 &nbsp;	
				 <xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_COMMERCIAL_DOCUMENT_DETAILS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:if test="$displaymode='edit'">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_INVOICE_NUMBER</xsl:with-param>
								<xsl:with-param name="name">invoice_number</xsl:with-param>
								<xsl:with-param name="required">Y</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_COMMERCIAL_DOCUMENT_ISSUE_DATE</xsl:with-param>
								<xsl:with-param name="name">invoice_iss_date</xsl:with-param>
								<xsl:with-param name="type">date</xsl:with-param>
								<xsl:with-param name="size">10</xsl:with-param>
								<xsl:with-param name="maxsize">10</xsl:with-param>
								<xsl:with-param name="fieldsize">small</xsl:with-param>
								<xsl:with-param name="required">Y</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="$displaymode='view'">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_INVOICE_NUMBER</xsl:with-param>
								<xsl:with-param name="name">invoice_number</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select ="invoice_number"/></xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_COMMERCIAL_DOCUMENT_ISSUE_DATE</xsl:with-param>
								<xsl:with-param name="name">invoice_iss_date</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select ="invoice_iss_date"/></xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						&nbsp;
						<xsl:call-template name="checkbox-field">
						     <xsl:with-param name="label">XSL_FINAL_SUBMISSION_FLAG</xsl:with-param>
						     <xsl:with-param name="name">final_submission_flag</xsl:with-param>
						     <xsl:with-param name="value"><xsl:value-of select="final_submission_flag"/></xsl:with-param>
					 	</xsl:call-template>
					 	
							<xsl:call-template name="checkbox-field">
							     <xsl:with-param name="label">XSL_FORCED_MATCH</xsl:with-param>
							     <xsl:with-param name="name">forced_match</xsl:with-param>
							     <xsl:with-param name="value"><xsl:value-of select="forced_match"/></xsl:with-param>
						 	</xsl:call-template>
			 			
			 		</xsl:with-param>
			 	</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		
	</xsl:template>
	
		<!-- Payment Transport DataSet -->
	<xd:doc>
		<xd:short>Payment Transport dataset</xd:short>
		<xd:detail>
			This displays message of no transport dataset if no dataset is available and add button to add transport data set.
 		</xd:detail>		
 	</xd:doc>
	<xsl:template name="payment-transport-ds-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_PURCHASE_ORDER_TRANSPORT_DATASET_DETAILS</xsl:with-param>
			<xsl:with-param name="content">&nbsp;
			
			<!-- Display other parties -->
			<xsl:if test="$displaymode='edit'">
				<xsl:call-template name="checkbox-field">
					<xsl:with-param name="name">display_other_parties</xsl:with-param>
					<xsl:with-param name="label">XSL_PURCHASE_ORDER_DISPLAY_OTHER_PARTIES</xsl:with-param>
					<xsl:with-param name="checked">Y</xsl:with-param>
					<xsl:with-param name="readonly">Y</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
				<xsl:call-template name="tabgroup-wrapper">
					<xsl:with-param name="tabgroup-id">other_parties_section</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					 <!-- Tab 0_0 - Bill To  -->
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
					 <!-- Tab 0_2 - Consignee -->
					<xsl:with-param name="tab2-label">XSL_HEADER_CONSIGNEE_DETAILS</xsl:with-param>
					<xsl:with-param name="tab2-content">
						<xsl:call-template name="party-details">
							<xsl:with-param name="prefix">consgn</xsl:with-param>
							<xsl:with-param name="show-button">Y</xsl:with-param>
							<xsl:with-param name="required">N</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
					<!-- Tab 0_3 - Consignor -->
					<xsl:with-param name="tab3-label">XSL_HEADER_CONSIGNOR_DETAILS</xsl:with-param>
					<xsl:with-param name="tab3-content">
						<xsl:call-template name="party-details">
							<xsl:with-param name="prefix">consgnor</xsl:with-param>
							<xsl:with-param name="show-button">Y</xsl:with-param>
							<xsl:with-param name="required">Y</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
							
				<xsl:if test="$displaymode='edit' or ($displaymode='view' and ./payment_transport_dataset/TrnsprtDataSet)">
					<xsl:call-template name="build-payment-transport-ds-details-dojo-items">
						<xsl:with-param name="items" select="payment_transport_dataset/TrnsprtDataSet" />
						<xsl:with-param name="id" select="payment-transport-ds" />
					</xsl:call-template>
				</xsl:if>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>	
	
	<xsl:template name="current-amt-availability">
		<!-- <xsl:call-template name="currency-field">
			<xsl:with-param name="label">XSL_OUTSTANDING_AMOUNT</xsl:with-param>
				<xsl:with-param name="override-currency-name">outstanding_amt_cur_code</xsl:with-param>
				<xsl:with-param name="override-amt-name">outstanding_total_net_amt</xsl:with-param>
				<xsl:with-param name="amt-readonly">Y</xsl:with-param>
				<xsl:with-param name="currency-readonly">Y</xsl:with-param>
				<xsl:with-param name="show-button">N</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_PENDING_AMOUNT</xsl:with-param>
				<xsl:with-param name="override-currency-name">pending_amt_cur_code</xsl:with-param>
				<xsl:with-param name="override-amt-name">pending_total_net_amt</xsl:with-param>
				<xsl:with-param name="amt-readonly">Y</xsl:with-param>
				<xsl:with-param name="currency-readonly">Y</xsl:with-param>
				<xsl:with-param name="show-button">N</xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_ACCEPTED_AMOUNT</xsl:with-param>
				<xsl:with-param name="override-currency-name">accpted_amt_cur_code</xsl:with-param>
				<xsl:with-param name="override-amt-name">accpt_total_net_amt</xsl:with-param>
				<xsl:with-param name="amt-readonly">Y</xsl:with-param>
				<xsl:with-param name="currency-readonly">Y</xsl:with-param>
				<xsl:with-param name="show-button">N</xsl:with-param>
			</xsl:call-template> -->
			
			
			
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_ORDERED_NET_TOTAL_AMOUNT</xsl:with-param>
				<xsl:with-param name="name">order_total_net_amt</xsl:with-param>
				<xsl:with-param name="type">amount</xsl:with-param>
				<xsl:with-param name="currency-value"><xsl:value-of select="total_cur_code" /></xsl:with-param>
				<xsl:with-param name="value">
			        <xsl:if test="$displaymode='view'">
			         <xsl:value-of select="total_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="order_total_net_amt"></xsl:value-of>
			        </xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			
			<!-- TBD : Total Bank Payment Obligation Amount -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_OUTSTANDING_NET_TOTAL_AMOUNT</xsl:with-param>
				<xsl:with-param name="name">outstanding_total_net_amt</xsl:with-param>
				<xsl:with-param name="type">amount</xsl:with-param>
				<xsl:with-param name="currency-value"><xsl:value-of select="total_cur_code" /></xsl:with-param>
				<xsl:with-param name="value">
			        <xsl:if test="$displaymode='view'">
			         <xsl:value-of select="total_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="outstanding_total_net_amt"></xsl:value-of>
			        </xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			<!-- TBD : Total Outstanding Bank Payment Obligation Amount -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_PENDING_NET_TOTAL_AMOUNT</xsl:with-param>
				<xsl:with-param name="name">pending_total_net_amt</xsl:with-param>
				<xsl:with-param name="type">amount</xsl:with-param>
				<xsl:with-param name="currency-value"><xsl:value-of select="total_cur_code" /></xsl:with-param>
				<xsl:with-param name="value">
			        <xsl:if test="$displaymode='view'">
			         <xsl:value-of select="total_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="pending_total_net_amt"></xsl:value-of>
			        </xsl:if>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_ACCEPTED_NET_TOTAL_AMOUNT</xsl:with-param>
			<xsl:with-param name="name">accpt_total_net_amt</xsl:with-param>
			<xsl:with-param name="type">amount</xsl:with-param>
			<xsl:with-param name="currency-value"><xsl:value-of select="total_cur_code" /></xsl:with-param>
			<xsl:with-param name="value">
		        <xsl:if test="$displaymode='view'">
		         <xsl:value-of select="total_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="accpt_total_net_amt"></xsl:value-of>
		        </xsl:if>
			</xsl:with-param>
		</xsl:call-template>
		
		<!-- TBD : Total Active Bank Payment Obligation Amount -->
		<xsl:call-template name="currency-field">
			<xsl:with-param name="label">XSL_PAID_AMOUNT</xsl:with-param>
			<xsl:with-param name="override-currency-name">paid_amt_cur_code</xsl:with-param>
			<xsl:with-param name="override-amt-name">paid_total_net_amt</xsl:with-param>
			<xsl:with-param name="amt-readonly">Y</xsl:with-param>
			<xsl:with-param name="currency-readonly">Y</xsl:with-param>
			<xsl:with-param name="show-button">N</xsl:with-param>
		</xsl:call-template>
			<!-- <xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_ORDERED_LINE_ITEMS_TOTAL_AMOUNT</xsl:with-param>
			<xsl:with-param name="name">order_total_amt</xsl:with-param>
			<xsl:with-param name="type">amount</xsl:with-param>
			<xsl:with-param name="currency-value"><xsl:value-of select="total_cur_code" /></xsl:with-param>
			<xsl:with-param name="value">
		        <xsl:if test="$displaymode='view'">
		         <xsl:value-of select="total_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="order_total_amt"></xsl:value-of>
		        </xsl:if>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_ACCEPTED_LINE_ITEMS_TOTAL_AMOUNT</xsl:with-param>
			<xsl:with-param name="name">accpt_total_amt</xsl:with-param>
			<xsl:with-param name="type">amount</xsl:with-param>
			<xsl:with-param name="currency-value"><xsl:value-of select="total_cur_code" /></xsl:with-param>
			<xsl:with-param name="value">
		        <xsl:if test="$displaymode='view'">
		         <xsl:value-of select="total_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="accpt_total_amt"></xsl:value-of>
		        </xsl:if>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_OUTSTANDING_LINE_ITEMS_TOTAL_AMOUNT</xsl:with-param>
			<xsl:with-param name="name">outstanding_total_amt</xsl:with-param>
			<xsl:with-param name="type">amount</xsl:with-param>
			<xsl:with-param name="currency-value"><xsl:value-of select="total_cur_code" /></xsl:with-param>
			<xsl:with-param name="value">
		        <xsl:if test="$displaymode='view'">
		         <xsl:value-of select="total_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="outstanding_total_amt"></xsl:value-of>
		        </xsl:if>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_PENDING_LINE_ITEMS_TOTAL_AMOUNT</xsl:with-param>
			<xsl:with-param name="name">pending_total_amt</xsl:with-param>
			<xsl:with-param name="type">amount</xsl:with-param>
			<xsl:with-param name="currency-value"><xsl:value-of select="total_cur_code" /></xsl:with-param>
			<xsl:with-param name="value">
		        <xsl:if test="$displaymode='view'">
		         <xsl:value-of select="total_cur_code"></xsl:value-of>&nbsp;<xsl:value-of select="pending_total_amt"></xsl:value-of>
		        </xsl:if>
			</xsl:with-param>
		</xsl:call-template> -->
			
			<xsl:call-template name="hidden-field">
                  <xsl:with-param name="name">order_total_amt</xsl:with-param>
                  <xsl:with-param name="value" select="order_total_amt"/>
            </xsl:call-template>
            <xsl:call-template name="hidden-field">
                  <xsl:with-param name="name">accpt_total_amt</xsl:with-param>
                  <xsl:with-param name="value" select="accpt_total_amt"/>
             </xsl:call-template>
             <xsl:call-template name="hidden-field">
                  <xsl:with-param name="name">outstanding_total_amt</xsl:with-param>
                  <xsl:with-param name="value" select="outstanding_total_amt"/>
             </xsl:call-template>
             <xsl:call-template name="hidden-field">
                  <xsl:with-param name="name">pending_total_amt</xsl:with-param>
                  <xsl:with-param name="value" select="pending_total_amt"/>
             </xsl:call-template>
             <xsl:call-template name="hidden-field">
                  <xsl:with-param name="name">order_total_net_amt</xsl:with-param>
                  <xsl:with-param name="value" select="order_total_net_amt"/>
        </xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
