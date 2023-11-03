<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		exclude-result-prefixes="localization defaultresource">

<!--
   Copyright (c) 2000-2009 Misys (http://www.misys.com),
   All Rights Reserved.
   
   Guarantee type form stylesheet.
-->
	<xsl:output method="html" indent="yes"/>

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

	<xsl:param name="isTemplate">false</xsl:param>	<!-- This parameter is used by the report templates -->

	<!-- Global Imports. -->
	<xsl:include href="../../../core/xsl/common/system_common.xsl" />
	<xsl:include href="../../../core/xsl/common/e2ee_common.xsl" />

	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />

	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	
	<!--TEMPLATE Main-->
	
	<xsl:template match="license_definition">
		<!-- Loading message  -->
		<xsl:call-template name="loading-message"/>
	
		<div>
			<xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
			<!-- Form #0 : Main Form -->
			<xsl:call-template name="form-wrapper">
				<xsl:with-param name="name" select="$main-form-name"/>
				<xsl:with-param name="validating">Y</xsl:with-param>
				<xsl:with-param name="content">
					<xsl:call-template name="hidden-fields"/>
					<xsl:call-template name="license-details"/>
					<!--  Display common menu. -->
					<xsl:call-template name="system-menu"/>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="realform">
				<xsl:with-param name="option"><xsl:value-of select="$option"/></xsl:with-param>
				<xsl:with-param name="featureid">
					<xsl:if test="ls_def_id[.!=''] and $operation!='ADD_FEATURES'">
						<xsl:value-of select="ls_def_id"/>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
		</div>
		
	   <script>
	   dojo.ready(function(){
	  		misys._config = misys._config || {};
	  		
	  		dojo.mixin(misys._config, {
	  			
	  		productTypeCodeList : {
				   <xsl:for-each select="/license_definition/prod_type_code/product_type_element/product_code">
				   					<xsl:variable name="productCode" select="self::node()/text()" />
				   					<xsl:value-of select="."/>: [
				   						<xsl:for-each select="/license_definition/prod_type_code/product_type_element[product_code=$productCode]/product_type_details" >
				   							<xsl:variable name="productTypeDescription" select="product_type_description" />
				   							<xsl:variable name="productTypeCode" select="product_type_code" />
				   							{ value:"<xsl:value-of select="$productTypeCode"/>",
						         				name:"<xsl:value-of select="$productTypeDescription"/>"},
				   						</xsl:for-each>
				   						]<xsl:if test="not(position()=last())">,</xsl:if>
			   		</xsl:for-each>

	   		},
	   		
	        lsTypesProductMapping : {
	    			<xsl:if test="count(/license_definition/avail_products/products) > 0" >
		        		<xsl:for-each select="/license_definition/avail_products/products/type" >
		        			<xsl:variable name="ls-type" select="."/>
		        			'<xsl:value-of select="$ls-type"/>': [
		        			<xsl:for-each select="/license_definition/avail_products/products[type=$ls-type]/product_code" >
		        			          <xsl:variable name="product-code" select="."/>
			   							{ value:"<xsl:value-of select="."/>",
					         					<xsl:choose>
											     	<xsl:when test="(defaultresource:isSwift2019Enabled() = 'true') and $product-code = 'BG'">
											     	 	name:"<xsl:value-of select="localization:getDecode($language, 'N001', 'IU' )"/>
											     	 </xsl:when>
											     	 <xsl:when test="(defaultresource:isSwift2019Enabled() = 'true') and $product-code = 'BR'">
											     	 	name:"<xsl:value-of select="localization:getDecode($language, 'N001', 'RU' )"/>
											     	 </xsl:when>
											     	 <xsl:otherwise>
											     	 	name:"<xsl:value-of select="localization:getDecode($language, 'N001', . )"/>
											     	 </xsl:otherwise>
										     	</xsl:choose>"},
	   						</xsl:for-each>]<xsl:if test="not(position()=last())">,</xsl:if>
		         		</xsl:for-each>
	         		</xsl:if>
				},
	   		
  			subProductsCollection : {
	    			<xsl:if test="count(/license_definition/product_subproduct_map/product) > 0" >
		        		<xsl:for-each select="/license_definition/product_subproduct_map/product/product_code" >
		        			<xsl:variable name="productCode" select="self::node()/text()" />
	   						<xsl:value-of select="."/>: [
		   						<xsl:for-each select="/license_definition/product_subproduct_map/product[product_code=$productCode]/sub_product_code" >
		   							{ value:"<xsl:value-of select="."/>",
				         				name:"<xsl:value-of select="localization:getDecode($language, 'N047', . )"/>"},
		   						</xsl:for-each>
	   							{value:"*",name:"*"}]<xsl:if test="not(position()=last())">,</xsl:if>
		         		</xsl:for-each>
	         		</xsl:if>
				}
			});
		   
   		});
  		</script> 
  		
		<!-- Javascript imports  -->
		<xsl:call-template name="js-imports"/>

		<!-- Widgets templates -->

		<xsl:call-template name="ls-products-dialog-template"/>
	
		<xsl:call-template name="customer-dialog-template"/>
		
	</xsl:template>	
	
	
 <!--                                     -->  
 <!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
 <!--                                     -->
 
 <!-- Additional JS imports for this form are -->
 <!-- added here. -->
 <xsl:template name="js-imports">
  <xsl:call-template name="system-common-js-imports">
   <xsl:with-param name="xml-tag-name">license</xsl:with-param>
   <xsl:with-param name="binding">misys.binding.system.license</xsl:with-param>
   <xsl:with-param name="override-help-access-key">SY_LIC</xsl:with-param>
   <xsl:with-param name="override-home-url">'/screen/<xsl:value-of select="$nextscreen"/>?option=<xsl:value-of select="$option"/>'</xsl:with-param>
   
  </xsl:call-template>
  
 </xsl:template>

 <!-- Additional hidden fields for this form are  -->
 <!-- added here. -->
    <xsl:template name="hidden-fields">
        <xsl:call-template name="hidden-field">
            <xsl:with-param name="name">owner_company_id</xsl:with-param>
            <xsl:with-param name="value"><xsl:value-of select="owner_company_id" /></xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="hidden-field">
	       <xsl:with-param name="name">ls_operation</xsl:with-param>
	       <xsl:with-param name="value"><xsl:value-of select="$operation"/></xsl:with-param>
	     </xsl:call-template>
    </xsl:template>

 <!-- ***************************************************************************************** -->
 <!-- ************************************* LICENSE DETAILS *********************************** -->
 <!-- ***************************************************************************************** -->
 <xsl:template name="license-details">

   <xsl:call-template name="fieldset-wrapper">
	<xsl:with-param name="legend">XSL_HEADER_LICENSE_DEFINITION</xsl:with-param>
	<xsl:with-param name="parse-widgets">N</xsl:with-param>
	<xsl:with-param name="content">

    <!-- License Definition -->
   
    <xsl:if test="$displaymode='edit'">
	      <xsl:call-template name="select-field">
		      <xsl:with-param name="label">XSL_LICENSE_TYPE</xsl:with-param>
		      <xsl:with-param name="name">ls_type</xsl:with-param>
		      <xsl:with-param name="required">Y</xsl:with-param>
		      <xsl:with-param name="value"><xsl:if test="ls_type[.!='']"><xsl:value-of select="ls_type"/></xsl:if></xsl:with-param>
		      <xsl:with-param name="options">
			  <xsl:apply-templates select="license_types"/>
		      </xsl:with-param>
	      </xsl:call-template>
      </xsl:if>
      <xsl:if test="$displaymode='view'">
      		<xsl:variable name="ls_type_code"><xsl:value-of select="ls_type"></xsl:value-of></xsl:variable>
			<xsl:variable name="productCode">*</xsl:variable>
			<xsl:variable name="subProductCode">*</xsl:variable>
			<xsl:variable name="parameterId">C026</xsl:variable>
      		<xsl:call-template name="input-field">
		      <xsl:with-param name="label">XSL_LICENSE_TYPE</xsl:with-param>
		      <xsl:with-param name="name">ls_type</xsl:with-param>
		      <xsl:with-param name="required">Y</xsl:with-param>
		      <xsl:with-param name="value"><xsl:if test="ls_type[.!='']"><xsl:value-of select="localization:getCodeData($language,'$subProductCode',$productCode,$parameterId, $ls_type_code)"/></xsl:if></xsl:with-param>
	      </xsl:call-template>
      </xsl:if>
      <!-- License Name -->
	    <xsl:call-template name="input-field">
	     <xsl:with-param name="label">XSL_LICENSE_NAME</xsl:with-param>
	     <xsl:with-param name="name">ls_name</xsl:with-param>
	     <xsl:with-param name="required">Y</xsl:with-param>
	     <xsl:with-param name="size">3</xsl:with-param>
	     <xsl:with-param name="maxsize">3</xsl:with-param>
	    </xsl:call-template>
	    <!-- License description -->
	    <xsl:call-template name="input-field">
	     <xsl:with-param name="label">XSL_LICENSE_DESCRIPTION</xsl:with-param>
	     <xsl:with-param name="name">ls_desc</xsl:with-param>
	     <xsl:with-param name="size">70</xsl:with-param>
	     <xsl:with-param name="maxsize">70</xsl:with-param>
	    </xsl:call-template>
	    
	    <xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_LICENSE_DEFAULT</xsl:with-param>
		<xsl:with-param name="legend-type">indented-header</xsl:with-param>
		<xsl:with-param name="parse-widgets">N</xsl:with-param>
		<xsl:with-param name="content">
	    <xsl:call-template name="column-container">
			 <xsl:with-param name="content">
			  <!-- column 1 -->		 
				  <xsl:call-template name="column-wrapper">
				   <xsl:with-param name="content">
				     <xsl:call-template name="column-wrapper">
				   <xsl:with-param name="content">
				   	<xsl:call-template name="checkbox-field">
     					<xsl:with-param name="label">XSL_LICENSE_MULTI_CURRENCY</xsl:with-param>
    					<xsl:with-param name="name">multi_cur</xsl:with-param>
    				</xsl:call-template>
    				</xsl:with-param>
    				</xsl:call-template>
    				<xsl:call-template name="column-wrapper">
				   		<xsl:with-param name="content">
    					<xsl:call-template name="checkbox-field">
     					<xsl:with-param name="label">XSL_LICENSE_ALLOW_OVERRIDE</xsl:with-param>
    					<xsl:with-param name="name">multi_cur_override</xsl:with-param>
    				</xsl:call-template>
    				</xsl:with-param>
    				</xsl:call-template>    				
    				 </xsl:with-param>
				   </xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="checkbox-field">
     		<xsl:with-param name="label">XSL_LICENSE_ALLOW_OVERDRAW</xsl:with-param>
    		<xsl:with-param name="name">allow_overdraw</xsl:with-param>
    	</xsl:call-template> 
				   
		<xsl:call-template name="checkbox-field">
     		<xsl:with-param name="label">XSL_LICENSE_ALLOW_MULTI_LS</xsl:with-param>
    		<xsl:with-param name="name">allow_multi_ls</xsl:with-param>
    	</xsl:call-template>
		</xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_LICENSE_PRINCIPAL_DETAILS</xsl:with-param>
		<xsl:with-param name="legend-type">indented-header</xsl:with-param>
		<xsl:with-param name="parse-widgets">N</xsl:with-param>
		<xsl:with-param name="content">
			<xsl:call-template name="checkbox-field">
     			<xsl:with-param name="label">XSL_LICENSE_ALLOW_OVERRIDE</xsl:with-param>
    			<xsl:with-param name="name">principal_override</xsl:with-param>
    		</xsl:call-template>
    		
    		<xsl:call-template name="input-field">
	    		<xsl:with-param name="label">XSL_LABEL_PRINCIPAL</xsl:with-param>
	     		<xsl:with-param name="name">principal_label</xsl:with-param>
	     		<xsl:with-param name="size">20</xsl:with-param>
	     		<xsl:with-param name="maxsize">20</xsl:with-param>
	    	</xsl:call-template>
		
		</xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_LICENSE_NON_PRINCIPAL_DETAILS</xsl:with-param>
		<xsl:with-param name="legend-type">indented-header</xsl:with-param>
		<xsl:with-param name="parse-widgets">N</xsl:with-param>
		<xsl:with-param name="content">
			<xsl:call-template name="checkbox-field">
     			<xsl:with-param name="label">XSL_LICENSE_ALLOW_OVERRIDE</xsl:with-param>
    			<xsl:with-param name="name">non_principal_override</xsl:with-param>
    		</xsl:call-template>
    		
    		<xsl:call-template name="input-field">
	    		<xsl:with-param name="label">XSL_LABEL_NON_PRINCIPAL</xsl:with-param>
	     		<xsl:with-param name="name">non_principal_label</xsl:with-param>
	     		<xsl:with-param name="size">20</xsl:with-param>
	     		<xsl:with-param name="maxsize">20</xsl:with-param>
	    	</xsl:call-template>
	    	
	    	<xsl:if test="$displaymode='edit'">
	      		<xsl:call-template name="select-field">
		      		<xsl:with-param name="label">XSL_NON_PRINCIPLE_DEFAULT</xsl:with-param>
		      		<xsl:with-param name="name">non_principal_default</xsl:with-param>
		      		<xsl:with-param name="value"><xsl:if test="non_principal_default[.!='']"><xsl:value-of select="non_principal_default"/></xsl:if></xsl:with-param>
		      		<xsl:with-param name="options">
		       			<xsl:apply-templates select="non_principal_default"/>
		      		</xsl:with-param>
	      		</xsl:call-template>
      		</xsl:if>
     		<xsl:if test="$displaymode='view'">
	      		<xsl:variable name="ls_type_code"><xsl:value-of select="ls_type"></xsl:value-of></xsl:variable>
				<xsl:variable name="productCode">*</xsl:variable>
				<xsl:variable name="subProductCode">*</xsl:variable>
				<xsl:variable name="parameterId">C028</xsl:variable>
	      		<xsl:call-template name="input-field">
			      <xsl:with-param name="label">XSL_LICENSE_TYPE</xsl:with-param>
			      <xsl:with-param name="name">ls_type</xsl:with-param>
			      <xsl:with-param name="required">Y</xsl:with-param>
			      <xsl:with-param name="value"><xsl:if test="ls_type[.!='']"><xsl:value-of select="localization:getCodeData($language,'$subProductCode',$productCode,$parameterId, $ls_type_code)"/></xsl:if></xsl:with-param>
		      </xsl:call-template>
      		</xsl:if>
		
		</xsl:with-param>
		</xsl:call-template>

	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_PRODUCT_MAPPING</xsl:with-param>
		<xsl:with-param name="legend-type">indented-header</xsl:with-param>
		<xsl:with-param name="parse-widgets">N</xsl:with-param>
		<xsl:with-param name="content">&nbsp;
			<div id="products-section">
				<xsl:call-template name="build-ls-products-dojo-items">
					<xsl:with-param name="items" select="products/product"/>
				</xsl:call-template>
			</div>
		</xsl:with-param>
	</xsl:call-template>

   <xsl:call-template name="fieldset-wrapper">
	<xsl:with-param name="legend">ASSOCIATED_CUSTOMERS</xsl:with-param>
	<xsl:with-param name="legend-type">indented-header</xsl:with-param>
	<xsl:with-param name="parse-widgets">N</xsl:with-param>
	<xsl:with-param name="content">
		<!-- Valid for all checkbox -->
		<xsl:call-template name="checkbox-field">
			<xsl:with-param name="label">XSL_LS_DEF_FOR_ALL_CUSTOMERS</xsl:with-param>
			<xsl:with-param name="name">valid_for_all</xsl:with-param>
		</xsl:call-template>
		<!-- Customers grid -->
		<div id="customers-section">
		<xsl:call-template name="build-customers-dojo-items">
			<xsl:with-param name="items" select="customers/customer"/>
		</xsl:call-template>
		</div>
	</xsl:with-param>
   </xsl:call-template>
	</xsl:with-param>
	</xsl:call-template>
 </xsl:template>

	<xsl:template match="license_types">
		<option>
			<xsl:attribute name="value">
		       <xsl:value-of select="license_type_code"/>
		    </xsl:attribute>
		    <xsl:value-of select="license_type_desc"/>
	    </option>
	</xsl:template>
	
	<xsl:template match="non_principal_default">
		<option>
			<xsl:attribute name="value">
		       <xsl:value-of select="non_principal_default_code"/>
		    </xsl:attribute>
		    <xsl:value-of select="non_principal_default_desc"/>
	    </option>
	</xsl:template>
	
 <!-- 
  Realform
  -->
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
	      <xsl:with-param name="value"><xsl:value-of select="$token" /></xsl:with-param>
  		</xsl:call-template>
      <xsl:call-template name="e2ee_transaction"/>
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>

	<!-- ********* -->
	<!-- Customers -->
	<!-- ********* -->
	<!-- Dialog Start -->
	<xsl:template name="customer-dialog-template">
		<div id="customer-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
			<!-- Customer entity -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_JURISDICTION_ENTITY</xsl:with-param>
				<xsl:with-param name="name">customer_entity</xsl:with-param>
				<xsl:with-param name="required">N</xsl:with-param>
				<xsl:with-param name="readonly">Y</xsl:with-param>
				<xsl:with-param name="button-type">system-license-maintenance-entity</xsl:with-param>
			</xsl:call-template>
			
			<!-- Customer abbreviated name -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_JURISDICTION_ABREVIATED_NAME</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
				<xsl:with-param name="name">customer_abbv_name</xsl:with-param>
				<xsl:with-param name="swift-validate">N</xsl:with-param>
				<xsl:with-param name="readonly">Y</xsl:with-param>
			</xsl:call-template>
			<!-- Customer name -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_JURISDICTION_NAME</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
				<xsl:with-param name="name">customer_name</xsl:with-param>
				<xsl:with-param name="swift-validate">N</xsl:with-param>
				<xsl:with-param name="readonly">Y</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">company_id</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">entity_id</xsl:with-param>
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
	
	<xsl:template name="ls-products-dialog-template">
		
		<xsl:call-template name="ls-products-dialog-declaration"/>
		
		<div id="ls-products-template" style="display:none">
			<div class="clear multigrid">
				<p dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_LICENSE_NO_PRODUCTS')"/>
				</p>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode"/>
				</div>
				<button dojoType="dijit.form.Button" type="button" id="addProductsButton" dojoAttachEvent="onClick: addItem" dojoAttachPoint="addButtonNode">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ADD_PRODUCTS')"/>
				</button>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template name="ls-products-dialog-declaration">
		<div id="ls-products-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
			<!-- Customer entity -->
			<div id="productDiv">
				<xsl:variable name="code"><xsl:value-of select="product_code"/></xsl:variable>
				<xsl:call-template name="select-field">
			    	<xsl:with-param name="label">XSL_JURISDICTION_PRODUCT</xsl:with-param>
			     	<xsl:with-param name="name">product_code</xsl:with-param>	    
			     	<xsl:with-param name="required">Y</xsl:with-param>
			     </xsl:call-template>
			     <xsl:call-template name="hidden-field">
			    	<xsl:with-param name="name">product_code_hidden</xsl:with-param>	    
			     	<xsl:with-param name="value">
			     	 <xsl:if test="$code != ''">
			     	 	<xsl:value-of select="localization:getDecode($language, 'N001', $code )"/>
			     	 </xsl:if>
			     	</xsl:with-param>  
			     </xsl:call-template>
			</div>
			<div id="subProductDiv">
				<xsl:variable name="sub_code"><xsl:value-of select="sub_product_code"/></xsl:variable>
				<xsl:call-template name="select-field">
			    	<xsl:with-param name="label">XSL_JURIDICTION_SUBPRODUCT_TYPE</xsl:with-param>
			     	<xsl:with-param name="name">sub_product_code</xsl:with-param>	    
			     	<xsl:with-param name="required">Y</xsl:with-param>
			     </xsl:call-template>
			     <xsl:call-template name="hidden-field">
			    	<xsl:with-param name="name">sub_product_code_hidden</xsl:with-param>	    
			     	<xsl:with-param name="value">  
			     	  <xsl:if test="$sub_code != ''">
			     	 	<xsl:value-of select="localization:getDecode($language, 'N047', $sub_code )"/>
			     	 </xsl:if> 
			     	</xsl:with-param>
			     </xsl:call-template>
			 </div>
			 
			 <div id="productTypeDiv">
				<xsl:variable name="productTypeCode"><xsl:value-of select="prod_type_code"/></xsl:variable>
				<xsl:call-template name="select-field">
			    	<xsl:with-param name="label">XSL_PRODUCTYPE_CODE_LABEL</xsl:with-param>
			     	<xsl:with-param name="name">product_type_code</xsl:with-param>
			     	<xsl:with-param name="required">Y</xsl:with-param>
			     </xsl:call-template>
			     <xsl:call-template name="hidden-field">
			    	<xsl:with-param name="name">product_type_code_hidden</xsl:with-param>	    
			     	<xsl:with-param name="value">
			     	 <xsl:if test="$productTypeCode != ''">
			     	 <xsl:value-of select="localization:getCodeData($language,'*', product_code,'C011', $productTypeCode)"/>
			     	 </xsl:if>
			     	</xsl:with-param>  
			     </xsl:call-template>
			</div>
			<div class="dijitDialogPaneActionBar">
				<xsl:call-template name="label-wrapper">
					<xsl:with-param name="content">
						<button dojoType="dijit.form.Button" type="button" id="productOkButton">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')"/>
						</button>
						<button dojoType="dijit.form.Button" type="button" id="productCancelButton">
							<xsl:attribute name="onClick">dijit.byId('ls-products-dialog-template').hide();</xsl:attribute>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')"/>
						</button>
					</xsl:with-param>
				</xsl:call-template>
			</div>
		</div>
	</xsl:template>

	<!-- ************************************************************************** -->
	<!--                          CUSTOMERS - START                                 -->
	<!-- ************************************************************************** -->
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
					<xsl:attribute name="company_id"><xsl:value-of select="$customer/company_id"/></xsl:attribute>
					<xsl:attribute name="name_"><xsl:value-of select="$customer/name_"/></xsl:attribute>
					<xsl:attribute name="abbv_name"><xsl:value-of select="$customer/abbv_name"/></xsl:attribute>
					<xsl:attribute name="entity"><xsl:value-of select="$customer/entity"/></xsl:attribute>
					<xsl:attribute name="entity_id"><xsl:value-of select="$customer/entity_id"/></xsl:attribute>
				</div>
			</xsl:for-each>
		</div>
		
	</xsl:template>
	
	<!-- ************************************************************************* -->
	<!--                          CUSTOMERS - END                                    -->
	<!-- ************************************************************************* -->
	
	<xsl:template name="build-ls-products-dojo-items">
		<xsl:param name="items"/>
		
		<div dojoType="misys.system.widget.LicenseProducts" dialogId="ls-products-dialog-template" gridId="products-grid" id="products">
			<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LICENSE_PRODUCT')"/>,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LICENSE_SUB_PRODUCT')"/>,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LICENSE_PRODUCT_TYPE')"/>
			</xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ADD_PRODUCTS')"/></xsl:attribute>
			<xsl:for-each select="$items">
				<xsl:variable name="product" select="."/>
				<xsl:variable name="parameterId">
					<xsl:choose>
						<xsl:when test="$product/product_code[.='BG' or .='BR']">C011</xsl:when>
						<xsl:when test="$product/product_code[.='SI']">C010</xsl:when>
					</xsl:choose>
				</xsl:variable>
				<xsl:variable name="position" select="position()" />
				<div dojoType="misys.system.widget.LicenseProduct">
					<xsl:attribute name="product_code"><xsl:value-of select="$product/product_code"/></xsl:attribute>
					<xsl:attribute name="sub_product_code"><xsl:value-of select="$product/sub_product_code"/></xsl:attribute>
					<xsl:attribute name="product_type_code"><xsl:value-of select="$product/product_type_code"/></xsl:attribute>	
					<xsl:attribute name="product_code_hidden">
						<xsl:choose>
				     		<xsl:when test="(defaultresource:isSwift2019Enabled() = 'true') and ($product/product_code = 'BG' or $product/product_code = 'BR')">
				     	 		<xsl:if test="$product/product_code = 'BG'">
									<xsl:value-of select="localization:getDecode($language, 'N001', 'IU')"/>	
								</xsl:if>
								<xsl:if test="$product/product_code = 'BR'">
									<xsl:value-of select="localization:getDecode($language, 'N001', 'RU')"/>	
								</xsl:if>
				     	 	</xsl:when>
				     	 	<xsl:otherwise>
				     	 		<xsl:value-of select="localization:getDecode($language, 'N001', $product/product_code)"/>	
				     		 </xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<xsl:attribute name="sub_product_code_hidden"><xsl:value-of select="localization:getDecode($language, 'N047', $product/sub_product_code)"/></xsl:attribute>
					<xsl:attribute name="product_type_code_hidden"><xsl:value-of select="localization:getCodeData($language,'*', $product/product_code, $parameterId, $product/product_type_code)"/></xsl:attribute>
				</div>
			</xsl:for-each>
		</div>
		
	</xsl:template>
	
</xsl:stylesheet>
