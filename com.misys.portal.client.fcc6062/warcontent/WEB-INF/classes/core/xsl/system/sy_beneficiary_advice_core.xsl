<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<!--
   Copyright (c) 2000-2012 Misys (http://www.misys.com),
   All Rights Reserved.
   author : gurudath reddy
   Beneficiary Advice Template Maintenance form stylesheet.
-->
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		exclude-result-prefixes="localization security">

	<!-- 	
		Global Parameters.
		These are used in the imported XSL, and to set global params in the JS 
	-->
	<xsl:param name="rundata"/>
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="languages"/>
	<xsl:param name="nextscreen"/>
	<xsl:param name="option"/>
	<xsl:param name="action"/>
	<xsl:param name="token"/>
	<xsl:param name="displaymode">edit</xsl:param>
	<xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
	<xsl:param name="main-form-name">fakeform1</xsl:param>
	<xsl:param name="operation"/>

	<!-- Global Imports. -->
	<xsl:include href="../common/system_common.xsl" />
	
	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />

	<xsl:template match="/">
		<xsl:apply-templates select="beneficiary_advice"/>
	</xsl:template>
	
	<!--TEMPLATE Main-->
	<xsl:template match="beneficiary_advice">
		<!-- Loading message  -->
		<xsl:call-template name="loading-message"/>
		<div>
			<xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
			<div id="beneficiaryAdvicesMainContainer">
				<!-- Form #0 : Main Form -->
				<xsl:call-template name="form-wrapper">
					<xsl:with-param name="name" select="$main-form-name"/>
					<xsl:with-param name="validating">Y</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="hidden-fields"/>
						<div class="widgetContainer">
							<xsl:call-template name="beneficiary_advice-details"/>
						</div>
						<!--  Display common menu. -->
						<xsl:call-template name="system-menu"/>
					</xsl:with-param>
				</xsl:call-template>
			</div>
			<xsl:call-template name="realform">
				<xsl:with-param name="option"><xsl:value-of select="$option"/></xsl:with-param>
				<xsl:with-param name="featureid">
					<xsl:if test="templateId[.!=''] and $operation!='ADD_FEATURES'">
						<xsl:value-of select="templateId"/>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
		</div>
		<!-- Javascript imports  -->
		<xsl:call-template name="js-imports"/>
		
		<!-- Widgets templates -->
		<xsl:call-template name="column-dialog-template"/>
		<xsl:call-template name="customer-dialog-template"/>
    </xsl:template>	
	
	<!-- Additional JS imports for this form are -->
	<!-- added here. -->
	<xsl:template name="js-imports">
		  <xsl:call-template name="system-common-js-imports">
			   <xsl:with-param name="xml-tag-name">beneficiary_advice</xsl:with-param>
			   <xsl:with-param name="binding">misys.binding.system.beneficiary_advice</xsl:with-param>
			   <xsl:with-param name="override-home-url">'/screen/<xsl:value-of select="$nextscreen"/>?option=<xsl:value-of select="$option"/>'</xsl:with-param>
		  </xsl:call-template>
	</xsl:template>

	<!-- Additional hidden fields for this form are  -->
	<!-- added here. -->
	<xsl:template name="hidden-fields">
	</xsl:template>

 	<xsl:template name="beneficiary_advice-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_MAIN_DETAILS</xsl:with-param>
			<xsl:with-param name="parse-widgets">N</xsl:with-param>
			<xsl:with-param name="content">
		
			    <!-- Beneficiary Advice Template Id-->
			   	<xsl:call-template name="input-field">
				     <xsl:with-param name="label">XSL_BENEFICIARY_ADVICE_TEMPLATE_ID</xsl:with-param>
				     <xsl:with-param name="name">templateId</xsl:with-param>
				     <xsl:with-param name="required">Y</xsl:with-param>
				     <xsl:with-param name="size">10</xsl:with-param>
				     <xsl:with-param name="maxsize">10</xsl:with-param>
				     <xsl:with-param name="fieldsize">small</xsl:with-param>
				      <xsl:with-param name="override-displaymode">
				     		<xsl:choose>
				     			<xsl:when test="templateId[.!='']">view</xsl:when>
				     			<xsl:otherwise>edit</xsl:otherwise>
				     		</xsl:choose>
				     </xsl:with-param>
			    </xsl:call-template>
			    <xsl:if test="templateId[.!='']">
			    	<xsl:call-template name="hidden-field">
			    		<xsl:with-param name="name">templateId</xsl:with-param>
			    	</xsl:call-template>
			    </xsl:if>
			
			    <!-- Beneficiary Advice Template description -->
			    <xsl:call-template name="input-field">
				     <xsl:with-param name="label">XSL_BENEFICIARY_ADVICE_TEMPLATE_DESCRIPTION</xsl:with-param>
				     <xsl:with-param name="name">description</xsl:with-param>
				     <xsl:with-param name="size">35</xsl:with-param>
				     <xsl:with-param name="maxsize">35</xsl:with-param>
			    </xsl:call-template>
				
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_BENEFICIARY_ADVICE_TEMPLATE_COLUMNS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="parse-widgets">N</xsl:with-param>
					<xsl:with-param name="content">
						<!-- Customers grid -->
						<div id="columns-section">
							<xsl:call-template name="build-columns-dojo-items">
								<xsl:with-param name="items" select="columns/column"/>
							</xsl:call-template>
							<!-- This div is required to force the content to appear -->
							<div style="height:1px">&nbsp;</div>
						</div>
					</xsl:with-param>
			    </xsl:call-template>
			    <xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_BENEFICIARY_ADVICE_TEMPLATE_CUSTOMERS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="parse-widgets">N</xsl:with-param>
					<xsl:with-param name="content">
						<!-- Standard checkbox -->
						<xsl:call-template name="checkbox-field">
							<xsl:with-param name="label">XSL_BENEFICIARY_ADVICE_TEMPLATE_FOR_ALL_CUSTOMERS</xsl:with-param>
							<xsl:with-param name="name">all_entities</xsl:with-param>
						</xsl:call-template>
						<!-- Customers grid -->
						<div id="customers-section">
							<xsl:call-template name="build-customers-dojo-items">
								<xsl:with-param name="items" select="customers/customer"/>
							</xsl:call-template>
							<!-- This div is required to force the content to appear -->
							<div style="height:1px">&nbsp;</div>
						</div>
					</xsl:with-param>
			   </xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	 </xsl:template>

	 <!-- Realform -->
	 <xsl:template name="realform">
		  <xsl:param name="option"/>
		  <xsl:param name="featureid"/>
			  <!-- Do not display this section when the counterparty mode is 'counterparty' -->
			  <xsl:call-template name="form-wrapper">
				   <xsl:with-param name="name">realform</xsl:with-param>
				   <xsl:with-param name="method">POST</xsl:with-param>
				   <xsl:with-param name="action">
				   		<xsl:choose>
					          <xsl:when test="$nextscreen and $nextscreen !=''"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$nextscreen"/></xsl:when>
					          <xsl:otherwise><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/BankSystemFeaturesScreen</xsl:otherwise>
				        </xsl:choose>
				   </xsl:with-param>
				   <xsl:with-param name="content">
					     <div class="widgetContainer">
						      <xsl:call-template name="hidden-field">
							       <xsl:with-param name="name">operation</xsl:with-param>
							       <xsl:with-param name="id">realform_operation</xsl:with-param>
							       <xsl:with-param name="value">SAVE_FEATURES</xsl:with-param>
						      </xsl:call-template>
						      <xsl:call-template name="hidden-field">
							        <xsl:with-param name="name">option</xsl:with-param>
									<xsl:with-param name="value"><xsl:value-of select="$option"/></xsl:with-param>
						      </xsl:call-template>
						      <xsl:if test="$featureid != ''">
						        <xsl:call-template name="hidden-field">
							        <xsl:with-param name="name">featureid</xsl:with-param>
									<xsl:with-param name="value"><xsl:value-of select="$featureid"/></xsl:with-param>
						        </xsl:call-template>
						      </xsl:if>
							  <xsl:call-template name="hidden-field">
							       <xsl:with-param name="name">TransactionData</xsl:with-param>
							       <xsl:with-param name="value"/>
						      </xsl:call-template>
						      <xsl:call-template name="hidden-field">
						       	<xsl:with-param name="name">token</xsl:with-param>
						       	<xsl:with-param name="value"><xsl:value-of select="$token"/></xsl:with-param>
						      </xsl:call-template>
					     </div>
				   </xsl:with-param>
			  </xsl:call-template>
	  </xsl:template>

	<!-- Columns -->
	<xsl:template name="column-dialog-template">
		<!-- Dialog start -->
		<div id="column-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
			
			<!-- Column Label -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_BENE_ADVICES_COLUMN_LABEL</xsl:with-param>
				<xsl:with-param name="name">column_label</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param> 
				<xsl:with-param name="size">25</xsl:with-param>
				<xsl:with-param name="maxsize">25</xsl:with-param>
			</xsl:call-template>
    		<!-- Column Data Type -->
			<xsl:call-template name="select-field">
				<xsl:with-param name="label">XSL_BENE_ADVICES_COLUMN_TYPE</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
				<xsl:with-param name="name">column_type</xsl:with-param>
				<xsl:with-param name="fieldsize">s-medium</xsl:with-param>
		     	<xsl:with-param name="options">
		     		<xsl:call-template name="column-types"/>
		    	</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">column_type_label</xsl:with-param>
			</xsl:call-template>
			<!-- Customer name -->
			<xsl:call-template name="select-field">
				<xsl:with-param name="label">XSL_BENE_ADVICES_COLUMN_ALIGNMENT</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
				<xsl:with-param name="name">column_alignment</xsl:with-param>
				<xsl:with-param name="fieldsize">small</xsl:with-param>
				<xsl:with-param name="options">
		     		<xsl:call-template name="column-alignments"/>
		    	</xsl:with-param>
			</xsl:call-template>
			<!-- Customer name -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_BENE_ADVICES_COLUMN_WIDTH</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
				<xsl:with-param name="name">column_width</xsl:with-param>
				<xsl:with-param name="type">number</xsl:with-param>
				<xsl:with-param name="size">3</xsl:with-param>
				<xsl:with-param name="maxsize">3</xsl:with-param>
				<xsl:with-param name="fieldsize">xx-small</xsl:with-param>
			</xsl:call-template>
			
			<div class="dijitDialogPaneActionBar">
				<xsl:call-template name="label-wrapper">
					<xsl:with-param name="content">
						<button dojoType="dijit.form.Button" type="button" id="columnOkButton">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')"/>
						</button>
						<button dojoType="dijit.form.Button" type="button" id="columnCancelButton">
							<xsl:attribute name="onmouseup">dijit.byId('column-dialog-template').hide();</xsl:attribute>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')"/>
						</button>
					</xsl:with-param>
				</xsl:call-template>
			</div>
		</div>
		<!-- Dialog End -->
		<div id="columns-template" style="display:none">
			<div class="clear">
				<p dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_NO_COLUMN_SETUP')"/>
				</p>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode"/>
				</div>
				<button dojoType="dijit.form.Button" type="button" id="addColumnButton" dojoAttachEvent="onClick: addItem" dojoAttachPoint="addButtonNode">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_ADD_COLUMN')"/>
				</button>
			</div>
	   </div>
	</xsl:template>
    <xsl:template name="build-columns-dojo-items">
		<xsl:param name="items"/>
		<div dojoType="misys.system.widget.BeneficiaryAdvicesTemplateColumns" dialogId="column-dialog-template" gridId="columns-grid" id="columns">
			<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'BENE_ADV_COLUMN_LABEL')"/>,
				<xsl:value-of select="localization:getGTPString($language, 'BENE_ADV_COLUMN_TYPE')"/>,'',
				
				<xsl:value-of select="localization:getGTPString($language, 'BENE_ADV_COLUMN_ALIGNMENT')"/>,
				<xsl:value-of select="localization:getGTPString($language, 'BENE_ADV_COLUMN_WIDTH')"/>
			</xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_ADD_COLUMN')"/></xsl:attribute>
			<xsl:for-each select="$items">
				<xsl:variable name="column" select="."/>
				<xsl:variable name="position" select="position()" />
				<div dojoType="misys.system.widget.BeneficiaryAdvicesTemplateColumn">
					<xsl:attribute name="id">column_<xsl:value-of select="$position"/></xsl:attribute>
					<xsl:attribute name="label"><xsl:value-of select="$column/label"/></xsl:attribute>
					<xsl:attribute name="type"><xsl:value-of select="$column/type"/></xsl:attribute>
					<xsl:attribute name="type_label"><xsl:value-of select="$column/type_label"/></xsl:attribute>
					<xsl:attribute name="alignment"><xsl:value-of select="$column/alignment"/></xsl:attribute>
					<xsl:attribute name="width"><xsl:value-of select="$column/width"/></xsl:attribute>
				</div>
			</xsl:for-each>
		</div>
	</xsl:template>
	
	<!-- Column Type Options -->
	<xsl:template name="column-types">
		<xsl:choose>
		    <xsl:when test="$displaymode='edit'">
			     <option value="01">
			       	<xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_COLUMN_TYPE_AMOUNT_WITH_DECIMAL')"/>
			     </option>
			     <option value="02">
			       	<xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_COLUMN_TYPE_AMOUNT_WITHOUT_DECIMAL')"/>
			     </option>
			     <option value="03">
			       	<xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_COLUMN_TYPE_DATE')"/>
			     </option>
			     <option value="04">
			       	<xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_COLUMN_TYPE_NUMERIC')"/>
			     </option>
			     <option value="05">
			       	<xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_COLUMN_TYPE_ALPHANUMERIC')"/>
			     </option>
			     <option value="06">
			       	<xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_COLUMN_TYPE_LETTERS')"/>
			     </option>
		    </xsl:when>
		    <xsl:otherwise>
		      	<xsl:if test="column_type[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_COLUMN_TYPE_AMOUNT_WITH_DECIMAL')"/></xsl:if>
		      	<xsl:if test="column_type[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_COLUMN_TYPE_AMOUNT_WITHOUT_DECIMAL')"/></xsl:if>
		      	<xsl:if test="column_type[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_COLUMN_TYPE_DATE')"/></xsl:if>
		      	<xsl:if test="column_type[. = '04']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_COLUMN_TYPE_NUMERIC')"/></xsl:if>
		      	<xsl:if test="column_type[. = '05']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_COLUMN_TYPE_ALPHANUMERIC')"/></xsl:if>
		      	<xsl:if test="column_type[. = '06']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_COLUMN_TYPE_LETTERS')"/></xsl:if>
		    </xsl:otherwise>
	   </xsl:choose>
    </xsl:template>
    
    <!-- Column Alignment Options -->
    <xsl:template name="column-alignments">
		<xsl:choose>
		    <xsl:when test="$displaymode='edit'">
			     <option value="left">
			       	<xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_COLUMN_TYPE_ALIGNMENT_LEFT')"/>
			     </option>
			     <option value="right">
			       	<xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_COLUMN_TYPE_ALIGNMENT_RIGHT')"/>
			     </option>
			     <option value="center">
			       	<xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_COLUMN_TYPE_ALIGNMENT_CENTER')"/>
			     </option>
		    </xsl:when>
		    <xsl:otherwise>
		      	<xsl:if test="column_alignment[. = 'left']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_COLUMN_TYPE_ALIGNMENT_LEFT')"/></xsl:if>
		      	<xsl:if test="column_alignment[. = 'right']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_COLUMN_TYPE_ALIGNMENT_RIGHT')"/></xsl:if>
		      	<xsl:if test="column_alignment[. = 'center']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_COLUMN_TYPE_ALIGNMENT_CENTER')"/></xsl:if>
		    </xsl:otherwise>
	   </xsl:choose>
    </xsl:template>
	
	<!-- Associated Customers -->
	<xsl:template name="customer-dialog-template">
		<!-- Dialog start -->
		<div id="customer-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
			<!-- Customer entity -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_JURISDICTION_ENTITY</xsl:with-param>
				<xsl:with-param name="name">customer_entity</xsl:with-param>
				<xsl:with-param name="required">N</xsl:with-param> 
				<xsl:with-param name="readonly">Y</xsl:with-param>
				<xsl:with-param name="button-type">system-beneficiary-advice-designer-entity</xsl:with-param>
			</xsl:call-template>
    
			<!-- Customer abbreviated name -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_JURISDICTION_ABREVIATED_NAME</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
				<xsl:with-param name="name">customer_abbv_name</xsl:with-param>
				<xsl:with-param name="readonly">Y</xsl:with-param>
				<xsl:with-param name="swift-validate">N</xsl:with-param>
			</xsl:call-template>
			<!-- Customer name -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_JURISDICTION_NAME</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
				<xsl:with-param name="name">customer_name</xsl:with-param>
				<xsl:with-param name="swift-validate">N</xsl:with-param>
				<xsl:with-param name="readonly">Y</xsl:with-param>
			</xsl:call-template>
			<div class="dijitDialogPaneActionBar">
				<xsl:call-template name="label-wrapper">
					<xsl:with-param name="content">
						<button dojoType="dijit.form.Button" type="button" id="customerOkButton">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')"/>
						</button>
						<button dojoType="dijit.form.Button" type="button" id="customerCancelButton">
							<xsl:attribute name="onmouseup">dijit.byId('customer-dialog-template').hide();</xsl:attribute>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')"/>
						</button>
					</xsl:with-param>
				</xsl:call-template>
			</div>
		</div>
		<!-- Dialog End -->
		<div id="customers-template" style="display:none">
			<div class="clear">
				<p dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_GUARANTEE_NO_CUSTOMER_SETUP')"/>
				</p>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode"/>
				</div>
				<button dojoType="dijit.form.Button" type="button" id="addCustomerButton" dojoAttachEvent="onClick: addItem" dojoAttachPoint="addButtonNode">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_GUARANTEE_ADD_CUSTOMER')"/>
				</button>
			</div>
		</div>
	</xsl:template>
    <xsl:template name="build-customers-dojo-items">
		<xsl:param name="items"/>
		<div dojoType="misys.system.widget.Customers" dialogId="customer-dialog-template" gridId="customers-grid" id="customers">
			<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'ABBVNAME')"/>,
				<xsl:value-of select="localization:getGTPString($language, 'NAME')"/>,
				<xsl:value-of select="localization:getGTPString($language, 'ENTITY')"/>
			</xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_GUARANTEE_ADD_CUSTOMER')"/></xsl:attribute>
			<xsl:for-each select="$items">
				<xsl:variable name="customer" select="."/>
				<xsl:variable name="position" select="position()" />
				<div dojoType="misys.system.widget.Customer">
					<xsl:attribute name="id">customer_<xsl:value-of select="$position"/></xsl:attribute>
					<xsl:attribute name="abbv_name"><xsl:value-of select="$customer/abbv_name"/></xsl:attribute>
					<xsl:attribute name="name_"><xsl:value-of select="$customer/name_"/></xsl:attribute>
					<xsl:attribute name="entity"><xsl:value-of select="$customer/entity"/></xsl:attribute>
				</div>
			</xsl:for-each>
		</div>
	</xsl:template>
</xsl:stylesheet>
