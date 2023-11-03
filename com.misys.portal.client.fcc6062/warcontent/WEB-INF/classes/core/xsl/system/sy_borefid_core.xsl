<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		exclude-result-prefixes="localization">

<!--
   Copyright (c) 2000-2010 Misys (http://www.misys.com),
   All Rights Reserved. 
-->

	<!-- Get the language code -->
	<xsl:variable name="isSwift2019Enabled" select="defaultresource:isSwift2019Enabled()"/>
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="languages"/>
	<xsl:param name="nextscreen"/>
	<xsl:param name="option"/>
	<xsl:param name="token"/>
	<xsl:param name="action"/>
	<xsl:param name="displaymode">edit</xsl:param>
	<xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
	<xsl:param name="main-form-name">fakeform1</xsl:param>
	<xsl:param name="operation"/>
	
	<xsl:include href="../common/system_common.xsl" />
    <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
     <xsl:include href="../../../core/xsl/common/e2ee_common.xsl" />

	<xsl:template match="/">
		<xsl:call-template name="loading-message" />
		<script>
		dojo.ready(function(){
			misys._config = misys._config || {};
			
       		var	backValues = new Array();
       		<xsl:for-each select="//avail_customer_references/customer_reference/cust_reference">
       			
       			<xsl:variable name="avail_cust_ref" select="self::node()/text()" />
				<xsl:variable name="cust_ref_name" select="." />
  					<xsl:for-each select="//avail_customer_references/customer_reference[cust_reference=$avail_cust_ref]/back_office_1" >
	        			backValues["<xsl:value-of select="$cust_ref_name"/>"] = new Array();
	        			backValues["<xsl:value-of select="$cust_ref_name"/>"].value = "<xsl:value-of select="."/>";
	        			backValues["<xsl:value-of select="$cust_ref_name"/>"].label = "<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_CUSTOMER_REFERENCE_BACK_OFFICE_1')"/>";
  					</xsl:for-each>
        	</xsl:for-each>	         	        	
        	
        	        	   

			dojo.mixin(misys._config, {
				backOffice1Values : backValues,
				
				subProductsCollection : {
	       		<xsl:for-each select="//avail_products/avail_products_sub_products/product_code">
		        	<xsl:variable name="avail_prodcode" select="self::node()/text()" />
	   				<xsl:value-of select="."/>: 
	   					[
		   					<xsl:for-each select="//avail_products/avail_products_sub_products[product_code=$avail_prodcode]/avail_sub_products/sub_product_code" >
		   							{ 
		   						  	value:"<xsl:value-of select="."/>",
				    			  	name:"<xsl:value-of select="localization:getDecode($language, 'N047', . )"/>"
				    			 	},
		   					</xsl:for-each>
	   					]
	   					<xsl:if test="not(position()=last())">,</xsl:if>
		        </xsl:for-each>
		       	}	 
			});				
		});
	</script>
		
		<div>
  			<xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
			<xsl:call-template name="form-wrapper">
		     <xsl:with-param name="name" select="$main-form-name"/>
		     <xsl:with-param name="validating">Y</xsl:with-param>
		     <xsl:with-param name="content">
		     
			     <xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_COMPANY_DETAILS</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:apply-templates select="boreference_record"/>
					</xsl:with-param>
				 </xsl:call-template>
				 
			     <xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_REFERENCES</xsl:with-param>
					<xsl:with-param name="content">	&nbsp;
					 
				    	<xsl:call-template name="build-bo-reference-ids-dojo-items">
				    		<xsl:with-param name="items" select="boreferences/borefrence"/>
							<xsl:with-param name="id">borefids</xsl:with-param>
						</xsl:call-template>
	  		        </xsl:with-param>
				 </xsl:call-template>
				 
				 <xsl:call-template name="system-menu"/>
		     </xsl:with-param>
		    </xsl:call-template>
		    <xsl:call-template name="bo-reference-ids-declaration" />
		    <!--  Display common menu. -->
			
			<xsl:call-template name="realform"/>
			<!-- Javascript imports  -->
	   		<xsl:call-template name="js-imports"/>
	   		
		</div>
		
	</xsl:template>

	 <xsl:template name="js-imports">
	  <xsl:call-template name="system-common-js-imports">
	   <xsl:with-param name="xml-tag-name">boreference_record</xsl:with-param>
	   <xsl:with-param name="binding">misys.binding.system.bo_refid</xsl:with-param>
	   <xsl:with-param name="override-help-access-key">BO_REF</xsl:with-param>
	   <xsl:with-param name="override-home-url">'/screen/BankSystemFeaturesScreen?option=<xsl:value-of select="$option"/>&amp;company=<xsl:value-of select="//abbv_name"/>'</xsl:with-param>
	  </xsl:call-template>
	 </xsl:template>
	<!--TEMPLATE Main-->

	<xsl:template match="boreference_record">

		<xsl:call-template name="input-field">
		     <xsl:with-param name="label">XSL_JURISDICTION_ABREVIATED_NAME</xsl:with-param>
		     <xsl:with-param name="id">abbv_name_view</xsl:with-param>
		     <xsl:with-param name="value" select="abbv_name" />
		     <xsl:with-param name="override-displaymode">view</xsl:with-param>
	    </xsl:call-template>
	    
	    <xsl:call-template name="hidden-field">
		     <xsl:with-param name="value" select="company_id" />
		     <xsl:with-param name="name">company_id</xsl:with-param>
	    </xsl:call-template>
	     <xsl:call-template name="hidden-field">
		     <xsl:with-param name="value" select="type" />
		     <xsl:with-param name="name">type</xsl:with-param>
	    </xsl:call-template>
	     <xsl:call-template name="hidden-field">
		     <xsl:with-param name="value" select="brch_code" />
		     <xsl:with-param name="name">brch_code</xsl:with-param>
	    </xsl:call-template>
	     <xsl:call-template name="hidden-field">
		     <xsl:with-param name="value" select="abbv_name" />
		     <xsl:with-param name="name">abbv_name</xsl:with-param>
	    </xsl:call-template>
	     <xsl:call-template name="hidden-field">
		     <xsl:with-param name="value" select="bank_abbv_name" />
		     <xsl:with-param name="name">bank_abbv_name</xsl:with-param>
	    </xsl:call-template>
	    
	    <xsl:call-template name="input-field">
		     <xsl:with-param name="label">XSL_JURISDICTION_NAME</xsl:with-param>
		     <xsl:with-param name="id">ext_name_view</xsl:with-param>
		     <xsl:with-param name="value" select="ext_name" />
		     <xsl:with-param name="override-displaymode">view</xsl:with-param>
	    </xsl:call-template>
	    <xsl:call-template name="hidden-field">
		     <xsl:with-param name="value" select="ext_name" />
		     <xsl:with-param name="name">ext_name</xsl:with-param>
	    </xsl:call-template>
	    
	    <xsl:if test="address_line_1[.!=''] and address_line_1[.!='null']">
		<xsl:call-template name="input-field">
		     <xsl:with-param name="label">XSL_JURISDICTION_ADDRESS</xsl:with-param>
		     <xsl:with-param name="id">address_line_1_view</xsl:with-param>
		     <xsl:with-param name="value" select="address_line_1" />
		     <xsl:with-param name="override-displaymode">view</xsl:with-param>
	    </xsl:call-template>
	    <xsl:call-template name="hidden-field">
		     <xsl:with-param name="value" select="address_line_1" />
		     <xsl:with-param name="name">address_line_1</xsl:with-param>
	    </xsl:call-template>
	    </xsl:if>
	    
		<xsl:if test="address_line_2[.!=''] and address_line_2[.!='null']">
			<xsl:call-template name="input-field">
			     <xsl:with-param name="id">address_line_2_view</xsl:with-param>
			     <xsl:with-param name="value" select="address_line_2" />
			     <xsl:with-param name="override-displaymode">view</xsl:with-param>
		    </xsl:call-template>
		    <xsl:call-template name="hidden-field">
			     <xsl:with-param name="value" select="address_line_2" />
			     <xsl:with-param name="name">address_line_2</xsl:with-param>
		    </xsl:call-template>
		</xsl:if>
		<xsl:if test="dom[.!=''] and dom[.!='null']">
			<xsl:call-template name="input-field">
			     <xsl:with-param name="id">dom_view</xsl:with-param>
			     <xsl:with-param name="value" select="dom" />
			     <xsl:with-param name="override-displaymode">view</xsl:with-param>
		    </xsl:call-template>
		    <xsl:call-template name="hidden-field">
			     <xsl:with-param name="value" select="dom" />
			     <xsl:with-param name="name">dom</xsl:with-param>
		    </xsl:call-template>
		</xsl:if>
		<xsl:if test="contact_name[.!=''] and contact_name[.!='null']">
			<xsl:call-template name="input-field">
			     <xsl:with-param name="label">XSL_JURISDICTION_CONTACT_NAME</xsl:with-param>
			     <xsl:with-param name="id">contact_name_view</xsl:with-param>
			     <xsl:with-param name="value" select="contact_name" />
			     <xsl:with-param name="override-displaymode">view</xsl:with-param>
		    </xsl:call-template>
		    <xsl:call-template name="hidden-field">
			     <xsl:with-param name="value" select="contact_name" />
			     <xsl:with-param name="name">contact_name</xsl:with-param>
		    </xsl:call-template>
		</xsl:if>
			
	</xsl:template>

	<xsl:template name="realform">
	  <!-- Do not display this section when the counterparty mode is 'counterparty' -->
	  <xsl:if test="$collaborationmode != 'counterparty'">
	  <xsl:call-template name="form-wrapper">
	   <xsl:with-param name="name">realform</xsl:with-param>
	   <xsl:with-param name="method">POST</xsl:with-param>
	   <xsl:with-param name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$nextscreen"/></xsl:with-param>
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
	      <xsl:call-template name="hidden-field">
	       <xsl:with-param name="name">TransactionData</xsl:with-param>
	       <xsl:with-param name="value"/>
	      </xsl:call-template>
	      <xsl:call-template name="hidden-field">
	       <xsl:with-param name="name">company</xsl:with-param>
	       <xsl:with-param name="value">
	        <xsl:value-of select="//abbv_name"/>
	       </xsl:with-param>
	      </xsl:call-template>
	      <xsl:call-template name="hidden-field">
	      	<xsl:with-param name="name">boRefLength</xsl:with-param>
	      	<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('BO_REFERENCE_LENGTH')"/></xsl:with-param>
	      </xsl:call-template>	
	      <xsl:call-template name="hidden-field">
	       	<xsl:with-param name="name">token</xsl:with-param>
	       	<xsl:with-param name="value"><xsl:value-of select="$token"/></xsl:with-param>
	      </xsl:call-template>
	      <xsl:call-template name="e2ee_transaction"/>
	     </div>
	    </xsl:with-param>
	   </xsl:call-template>
	   </xsl:if>
	 </xsl:template>

	<!-- Populate Product Code Select Box -->
	<xsl:template name="avail_product_code" mode="productSelectBox">
		<!-- List of available Products -->
		<option value="0">&nbsp;</option>
		<xsl:for-each select="//avail_products/avail_products_sub_products/product_code">
			<xsl:variable name="avail_prodcode"><xsl:value-of select="."/></xsl:variable>
					     		
			<xsl:if test="not($avail_prodcode='BK' or .='TD' or .='SE' or .='LN')">
				<option>
					<xsl:choose>
			     		<xsl:when test="($isSwift2019Enabled = 'true') and $avail_prodcode = 'BG'">
						<xsl:attribute name="value"><xsl:value-of select="$avail_prodcode"/></xsl:attribute>
						<xsl:value-of select="localization:getDecode($language, 'N001', 'IU')"/>	
						</xsl:when>
						<xsl:when test="($isSwift2019Enabled = 'true') and $avail_prodcode = 'BR'">
			     	 	<xsl:attribute name="value"><xsl:value-of select="$avail_prodcode"/></xsl:attribute>
						<xsl:value-of select="localization:getDecode($language, 'N001', 'RU')"/>
						</xsl:when>
			     	 	<xsl:otherwise>
						<xsl:attribute name="value"><xsl:value-of select="$avail_prodcode"/></xsl:attribute>
						<xsl:value-of select="localization:getDecode($language, 'N001', $avail_prodcode)"/>						
					</xsl:otherwise>
		     </xsl:choose>
					
					
				</option>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>
	
	<!--  Populate customer's references dropdown list -->
	<xsl:template name="avail_customer_ref" mode="customerRefSelectBox">
		<!-- List of available customer's references -->
		<xsl:for-each select="//avail_customer_references/customer_reference">
			 <xsl:if test="back_office_1 != '' or back_office_2 != '' or back_office_3 != '' or back_office_4 != '' or back_office_5 != '' or back_office_6 != '' or back_office_7 != '' or back_office_8 != '' or back_office_9 != ''"> 
				<xsl:variable name="avail_custrefcode"><xsl:value-of select="cust_reference"/></xsl:variable>
				<option>
					<xsl:attribute name="value"><xsl:value-of select="$avail_custrefcode"/></xsl:attribute>
					<xsl:value-of select="$avail_custrefcode"/>
				</option>
			</xsl:if>
		 </xsl:for-each>
	</xsl:template>
	
	<!-- Template for the declaration of bo reference id's -->
	<xsl:template name="bo-reference-ids-dialog-declaration">
		<div id="bo-reference-ids-dialog-template" style="display:none" class="widgetContainer">
			<!-- Select the customer reference -->
			<xsl:if test="count(//avail_customer_references/customer_reference/cust_reference)>=0">
				<xsl:call-template name="select-field">
					<xsl:with-param name="label">XSL_PARTIESDETAILS_CUSTOMER_REFERENCE</xsl:with-param>
					<xsl:with-param name="name">select_customer_reference</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
					<xsl:with-param name="options">
						<xsl:call-template name="avail_customer_ref"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<!-- TI Mnemonic -->
			<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_JURISDICTION_CUSTOMER_REFERENCE_BACK_OFFICE_1</xsl:with-param>
					<xsl:with-param name="name">select_back_office_1</xsl:with-param>
					<xsl:with-param name="disabled">Y</xsl:with-param>
					<xsl:with-param name="swift-validate">N</xsl:with-param>
					<xsl:with-param name="size">30</xsl:with-param>
					<xsl:with-param name="maxsize">255</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="select-field">
				<xsl:with-param name="label">XSL_JURISDICTION_PRODUCT</xsl:with-param>
				<xsl:with-param name="name">select_prodcode</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
				<xsl:with-param name="options">
					<xsl:call-template name="avail_product_code" />
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="select-field">
				<xsl:with-param name="label">XSL_JURISDICTION_SUB_PRODUCT</xsl:with-param>
				<xsl:with-param name="name">select_subprodcode</xsl:with-param>
				<xsl:with-param name="disabled">Y</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="multioption-group">
	         <xsl:with-param name="group-label">XSL_GENERALDETAILS_COLL_TYPE_LABEL</xsl:with-param>
	         <xsl:with-param name="content">
             <xsl:call-template name="radio-field">
				<xsl:with-param name="label">XSL_REFERENCESDETAILS_RANK</xsl:with-param>
				<xsl:with-param name="name">uniqueRef</xsl:with-param>
				<xsl:with-param name="id">uniqueRef_1</xsl:with-param>
				<xsl:with-param name="value">multiple</xsl:with-param>
			 </xsl:call-template>
			 <xsl:call-template name="radio-field">
				<xsl:with-param name="label">XSL_REFERENCESDETAILS_SINGLE</xsl:with-param>
				<xsl:with-param name="name">uniqueRef</xsl:with-param>
				<xsl:with-param name="id">uniqueRef_2</xsl:with-param>
				<xsl:with-param name="value">unique</xsl:with-param>
			 </xsl:call-template>
	        </xsl:with-param>
	       </xsl:call-template>
			<div id="display_multipleRef" style="display:none">
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_REFERENCESDETAILS_CUSTOMER_INPUT_CENTER</xsl:with-param>
					<xsl:with-param name="name">customer_input_center</xsl:with-param>
					<xsl:with-param name="swift-validate">N</xsl:with-param>
					<xsl:with-param name="size">3</xsl:with-param>
					<xsl:with-param name="maxsize">2</xsl:with-param>
					<xsl:with-param name="fieldsize">x-small</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">DATEFROM</xsl:with-param>
					<xsl:with-param name="name">from</xsl:with-param>
					<xsl:with-param name="swift-validate">N</xsl:with-param>
					<xsl:with-param name="size">4</xsl:with-param>
					<xsl:with-param name="maxsize">3</xsl:with-param>
					<xsl:with-param name="type">number</xsl:with-param>
					<xsl:with-param name="fieldsize">x-small</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">DATETO</xsl:with-param>
					<xsl:with-param name="name">to</xsl:with-param>
					<xsl:with-param name="swift-validate">N</xsl:with-param>
					<xsl:with-param name="size">4</xsl:with-param>
					<xsl:with-param name="maxsize">3</xsl:with-param>
					<xsl:with-param name="type">number</xsl:with-param>
					<xsl:with-param name="fieldsize">x-small</xsl:with-param>
				</xsl:call-template>
			</div>
			<div id="display_uniqueRef" style="display:none">
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">BO_REFERENCE</xsl:with-param>
					<xsl:with-param name="name">title</xsl:with-param>
					<xsl:with-param name="swift-validate">N</xsl:with-param>
					<xsl:with-param name="size">12</xsl:with-param>
					<xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('BO_REFERENCE_LENGTH')"/></xsl:with-param>
				</xsl:call-template>
			</div>
			<div class="dijitDialogPaneActionBar">
				<xsl:call-template name="label-wrapper">
					<xsl:with-param name="content">
						<button dojoType="dijit.form.Button" type="button" onClick="misys.dialog.submitBoRefId('bo-reference-ids-dialog-template')">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
						</button>
						<button dojoType="dijit.form.Button" type="button">
							<xsl:attribute name="onClick">misys.dialog.closeBoRefId('bo-reference-ids-dialog-template')</xsl:attribute>
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
						</button>
					</xsl:with-param>
				</xsl:call-template>
			</div>
		</div>
	</xsl:template>


	<xsl:template name="bo-reference-ids-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="bo-reference-ids-dialog-declaration" />
		<!-- Dialog End -->
		<div id="bo-reference-ids-template" style="display:none">
			<div>
				<p dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_REFERENCESDETAILS_NO_REFERENCE_ITEM')" />
				</p>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem" dojoAttachPoint="addButtonNode" type="button">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_REFERENCESDETAILS_ADD_REFERENCE_ITEM')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	
	<xsl:template name="build-bo-reference-ids-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />

		<div dojoType="misys.openaccount.widget.ReferenceIds" dialogId="bo-reference-ids-dialog-template">
			<xsl:attribute name="headers">
				<xsl:value-of
					select="localization:getGTPString($language, 'CUST_REFERENCE')" />,
				<xsl:value-of
					select="localization:getGTPString($language, 'BACK_OFFICE_1_HEADER')" />,
				<xsl:value-of
					select="localization:getGTPString($language, 'XSL_REFERENCESDETAILS_CUSTOMER_INPUT_CENTER_HEADER')" />,	
				<xsl:value-of
					select="localization:getGTPString($language, 'XSL_JURISDICTION_PRODUCT_HEADER')" />,
				<xsl:value-of
					select="localization:getGTPString($language, 'XSL_JURISDICTION_SUB_PRODUCT_HEADER')" />,	
				<xsl:value-of
					select="localization:getGTPString($language, 'DATEFROM')" />,
				<xsl:value-of
					select="localization:getGTPString($language, 'DATETO')" />,
				<xsl:value-of
					select="localization:getGTPString($language, 'TITLE')" />
					
			</xsl:attribute>
			
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_REFERENCESDETAILS_ADD_REFERENCE_ITEM')"/></xsl:attribute>
			
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
			<xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="refrence" select="." />
					<div dojoType="misys.openacount.widget.ReferenceId">
						<!-- Customer reference --> 
						<xsl:attribute name="cust_reference">
							<xsl:value-of select="$refrence/customer_reference/cust_reference"/>
						</xsl:attribute>
						<xsl:attribute name="back_office_1">
							<xsl:value-of select="$refrence/customer_reference/back_office_1"/>
						</xsl:attribute>
						<xsl:attribute name="customer_input_center">
							<xsl:value-of select="$refrence/customer_input_center"/>
						</xsl:attribute>
						<xsl:attribute name="prodcode">
							<xsl:value-of select="$refrence/prodcode" />
						</xsl:attribute>
						<xsl:attribute name="subprodcode">
							<xsl:value-of select="$refrence/subprodcode" />
						</xsl:attribute>
						<xsl:attribute name="from">
							<xsl:value-of select="$refrence/from" />
						</xsl:attribute>
						<xsl:attribute name="to">
							<xsl:value-of select="$refrence/to" />
						</xsl:attribute>
						<xsl:attribute name="title">
							<xsl:value-of select="$refrence/title" />
						</xsl:attribute>
					</div>
				</xsl:for-each>
			</xsl:if>
		</div>

	</xsl:template>


</xsl:stylesheet>