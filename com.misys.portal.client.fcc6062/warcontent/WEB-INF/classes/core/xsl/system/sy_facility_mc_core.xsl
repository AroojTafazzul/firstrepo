<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################


Copyright (c) 2000-2011 Misys (http://www.misys.com),
All Rights Reserved. 


##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		exclude-result-prefixes="localization">
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
  <xsl:param name="processdttm"/>
  <xsl:param name="canCheckerReturnComments"/>
  <xsl:param name="checkerReturnCommentsMode"/>
  <xsl:param name="allowReturnAction">false</xsl:param>
  <xsl:param name="registrations_made">Y</xsl:param>
  <xsl:param name="operation">SAVE_FEATURES</xsl:param>
  <xsl:param name="currentmode"/>
  <xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
  <xsl:param name="arrowDownImage"><xsl:value-of select="$images_path"/>arrow_down.png</xsl:param>
  <xsl:param name="arrowUpImage"><xsl:value-of select="$images_path"/>arrow_up.png</xsl:param> 
   
  <!-- Global Imports. -->
  <xsl:include href="../common/system_common.xsl" />
  <xsl:include href="../common/maker_checker_common.xsl" />
    <xsl:include href="../../../core/xsl/common/e2ee_common.xsl" />
    
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
   <!-- Loading message  -->
   <xsl:call-template name="loading-message"/>
   
   	<script>
		dojo.ready(function(){
			misys._config = misys._config || {};
			dojo.mixin(misys._config, {
			
			productTypeCodeList : {
			<xsl:if test="count(/input/master_facility_record/prod_type_code/product_type_element/product_code) > 0 ">


			   <xsl:for-each select="/input/master_facility_record/prod_type_code/product_type_element">
			   					<xsl:value-of select="product_code"/>: [
			   						<xsl:for-each select="product_type_details" >
			   							<xsl:variable name="productTypeDescription" select="product_type_description" />
			   							<xsl:variable name="productTypeCode" select="product_type_code" />

			   							{ 
			   								value:"<xsl:value-of select="$productTypeCode"/>",
					         				name:"<xsl:value-of select="$productTypeDescription"/>"},
			   						</xsl:for-each>
			   						]<xsl:if test="not(position()=last())">,</xsl:if>
		   		</xsl:for-each>
	   		</xsl:if>
	   		},
	   		
	   		guaranteeTemplateList : {
	   			<xsl:if test="count(/input/master_facility_record/guarantee_template/bank) > 0">
	   				<xsl:for-each select="/input/master_facility_record/guarantee_template/bank">
	   			 			'<xsl:value-of select="bank_name"/>' : {
	   			 				<xsl:for-each select="templates_type/guarantee_templates">
	   			 					'<xsl:value-of select="type_code"/>' : [
	   									<xsl:for-each select="guarantee_name">
       									<xsl:variable name="templateName" select="self::node()/text()" />
				   			 			{ 	
				   			 				value:"<xsl:value-of select="$templateName"/>",
							         		name:"<xsl:value-of select="$templateName"/>"
							         	}<xsl:if test="not(position()=last())">,</xsl:if>
       									</xsl:for-each>
       								]<xsl:if test="not(position()=last())">,</xsl:if>
       							</xsl:for-each>
       						}<xsl:if test="not(position()=last())">,</xsl:if>
	   			 </xsl:for-each>
	   			</xsl:if>
	   		},
	   		guaranteeFacilityTemplateList : {
	   			<xsl:if test="count(/input/master_facility_record/guarantee_template/bank) > 0">
	   				<xsl:for-each select="/input/master_facility_record/guarantee_template/bank">
	   			 			'<xsl:value-of select="bank_name"/>' : {
	   			 				<xsl:for-each select="templates_type/guarantee_templates">
	   			 						'<xsl:value-of select="type_code"/>' : {
	   			 						'<xsl:value-of select="sub_product"/>' : [
	   									<xsl:for-each select="guarantee_name">
       									<xsl:variable name="templateName" select="self::node()/text()" />
				   			 			{ 	
				   			 				value:"<xsl:value-of select="$templateName"/>",
							         		name:"<xsl:value-of select="$templateName"/>"
							         	}<xsl:if test="not(position()=last())">,</xsl:if>
       									</xsl:for-each>
       									]
       								}<xsl:if test="not(position()=last())">,</xsl:if>
       							</xsl:for-each>
       						}<xsl:if test="not(position()=last())">,</xsl:if>
	   			 </xsl:for-each>
	   			</xsl:if>
	   		},
       		
       		guaranteeTemplateByEntityList :{
       			<xsl:if test="count(/input/master_facility_record/guarantee_template/bank) > 0">
	   				<xsl:for-each select="/input/master_facility_record/guarantee_template/bank">
	   			 			'<xsl:value-of select="bank_name"/>' : {
       							<xsl:for-each select="templates_type/valid_entity/entity_template">
       									'<xsl:value-of select="entity_name"/>' : [
       												<xsl:for-each select="guarantee_name">
       													"<xsl:value-of select="self::node()/text()" />"
				   			 							<xsl:if test="not(position()=last())">,</xsl:if>
       												</xsl:for-each>
       											]<xsl:if test="not(position()=last())">,</xsl:if>
       							</xsl:for-each>
       							}<xsl:if test="not(position()=last())">,</xsl:if>
       				</xsl:for-each>
				</xsl:if>
       		},
	   		
       		SubProductsCollection : {
	    			<xsl:if test="count(/input/master_facility_record/avail_products/products/product/product_code) > 0" >
		        		<xsl:for-each select="/input/master_facility_record/avail_products/products/product/product_code" >
		        			<xsl:variable name="productCode" select="self::node()/text()" />
	   						<xsl:value-of select="."/>: [
		   						<xsl:for-each select="/input/master_facility_record/avail_products/products/product[product_code=$productCode]/sub_product_code" >
		   						   <xsl:if test="not($productCode='SE' and .= 'CTCHP')">
		   							{ value:"<xsl:value-of select="."/>",
				         				name:"<xsl:value-of select="localization:getDecode($language, 'N047', . )"/>"},
				         			</xsl:if>
		   						</xsl:for-each>
	   							{value:"*",name:"*"}]<xsl:if test="not(position()=last())">,</xsl:if>
		         		</xsl:for-each>
	         		</xsl:if>
				},
				
			SubTnxTypeCollection : {
	    			<xsl:if test="count(/input/master_facility_record/avail_products/products/product/product_code) > 0" >
		        		<xsl:for-each select="/input/master_facility_record/avail_products/products/product/product_code" >
		        			<xsl:variable name="productCode" select="self::node()/text()" />
	   						<xsl:value-of select="."/>: [
		   						<xsl:choose>
		   						<xsl:when test="count(/input/master_facility_record/avail_products/products/product[product_code=$productCode]/tnx_type) > 0">
		   						<xsl:for-each select="/input/master_facility_record/avail_products/products/product[product_code=$productCode]/tnx_type" >
		   						<xsl:variable name="tnxTypeCode" select="tnx_type_code" />
		   							{
		   							"<xsl:value-of select="$tnxTypeCode"/>" :	[
			   						<xsl:for-each select="sub_tnx_type_code" >
			   							{ value:"<xsl:value-of select="."/>",
					         				name:"<xsl:value-of select="localization:getDecode($language, 'N003', . )"/>"},
			   						</xsl:for-each>
		   							{value:"*",name:"*"}]}<xsl:if test="not(position()=last())">,</xsl:if>
		   						</xsl:for-each>
		   						</xsl:when>
		   						<xsl:otherwise>
		   						{"*" : {value:"*",name:"*"}}
		   						</xsl:otherwise>
		   						</xsl:choose>]<xsl:if test="not(position()=last())">,</xsl:if>
		         		</xsl:for-each>
	         		</xsl:if>
				}
				});
			});
	</script>
   
   
   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
   	 	<xsl:with-param name="name" select="$main-form-name"/>
   	 	<xsl:with-param name="validating">Y</xsl:with-param>
   	 	<xsl:with-param name="content">
      			<xsl:apply-templates select="input/master_facility_record" mode="input"/>
      			<xsl:call-template name="system-menu" />
      			<xsl:call-template name="entities"/>
     	</xsl:with-param>
    </xsl:call-template>
    	<xsl:call-template name="realform"/>
   </div>
    
   	<!-- Javascript imports  -->
   <xsl:call-template name="js-imports"/>
  </xsl:template>
 <!-- Additional JS imports for this form are -->
 <!-- added here. -->
 <xsl:template name="js-imports">
  <xsl:call-template name="system-common-js-imports">
   	<xsl:with-param name="xml-tag-name">master_facility_record</xsl:with-param>
   	<xsl:with-param name="binding">misys.binding.system.facility</xsl:with-param>
   	<xsl:with-param name="override-help-access-key">SY_FACI</xsl:with-param>
   	<xsl:with-param name="override-home-url">'/screen/<xsl:value-of select="$nextscreen"/>?option=<xsl:value-of select="$option"/>'</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
<!-- =========================================================================== -->
<!-- =================== Template for Basic Package Details in INPUT mode =============== -->
<!-- =========================================================================== -->
  <xsl:template match="master_facility_record" mode="input">
	<script>
   dojo.ready(function(){
  		misys._config = misys._config || {};
  		
  		dojo.mixin(misys._config, {
  			custRefCollection : {
	    			<xsl:if test="count(/input/master_facility_record/cust_ref_elements/customer_reference_element) > 0" >
		        		<xsl:for-each select="/input/master_facility_record/cust_ref_elements/customer_reference_element/bank_abbv_name" >
		        			<xsl:variable name="bankAbbvName" select="self::node()/text()" />
	   						"<xsl:value-of select="."/>": [
		   						<xsl:for-each select="/input/master_facility_record/cust_ref_elements/customer_reference_element[bank_abbv_name=$bankAbbvName]/customer_reference" >
		   							{ value:"<xsl:value-of select="reference"/>",
				         				name:"<xsl:value-of select="reference"/>"},
		   						</xsl:for-each>
	   								]<xsl:if test="not(position()=last())">,</xsl:if>
		         		</xsl:for-each>
	         		</xsl:if>
				}
				
				<xsl:if test="count(/input/master_facility_record/banks_facility/bank_facility) > 0" >
				,
				bankNameIdCollection : {
					
						<xsl:for-each select="/input/master_facility_record/banks_facility/bank_facility" >
							<xsl:value-of select="bank_abbv_name_facility"/>: <xsl:value-of select="bank_id"/>
							<xsl:if test="not(position()=last())">,</xsl:if>
						</xsl:for-each>
				}
				</xsl:if>
			});
   		});
   		
  </script>
  <script>
   dojo.ready(function(){
  		misys._config = misys._config || {};
  		
  		dojo.mixin(misys._config, {
  			entityCollection : {
	    			<xsl:if test="count(/input/master_facility_record/avail_entity_elements/avail_entity_element) > 0" >
		        		<xsl:for-each select="/input/master_facility_record/avail_entity_elements/avail_entity_element/customer_reference" >
		        			<xsl:variable name="custRef" select="self::node()/text()" />
	   						'<xsl:value-of select="."/>': [
		   						<xsl:for-each select="/input/master_facility_record/avail_entity_elements/avail_entity_element[customer_reference=$custRef]/entity" >
		   							{ value:"<xsl:value-of select="entity_abbv_name"/>",
				         				name:"<xsl:value-of select="entity_abbv_name"/>"},
		   						</xsl:for-each>
	   								]<xsl:if test="not(position()=last())">,</xsl:if>
		         		</xsl:for-each>
	         		</xsl:if>
				}
						   });
   		});
  </script>
  
				

  	<xsl:call-template name="fieldset-wrapper">
  		<xsl:with-param name="legend">XSL_HEADER_FACILITY_DETAILS</xsl:with-param>
 			<xsl:with-param name="content">
 			<xsl:variable name="isModified"><xsl:value-of select="is_modified"/></xsl:variable>
	 			<xsl:if test="facility_id[.!='']">
			      		<xsl:call-template name="hidden-field">
			       			<xsl:with-param name="name">facility_id</xsl:with-param>
			       			<xsl:with-param name="value"><xsl:value-of select="facility_id"/></xsl:with-param>
			      		</xsl:call-template>
	 			</xsl:if>
 				 <xsl:call-template name="input-field">
  					<xsl:with-param name="label">XSL_FACILITY_COMP_ABBV_NAME</xsl:with-param>
    				<xsl:with-param name="name">company_abbv_name</xsl:with-param>
    				<xsl:with-param name="size">20</xsl:with-param>
    				<xsl:with-param name="fieldsize">large</xsl:with-param>
   					<xsl:with-param name="maxsize">20</xsl:with-param>
   					<xsl:with-param name="required">Y</xsl:with-param>
   						<xsl:with-param name="disabled">Y</xsl:with-param>
   				</xsl:call-template>
	   		<xsl:choose>
	       <!-- NEW -->
	       		<xsl:when test="securityCheck:hasPermission($rundata, 'sy_bankgroup_facility_def_mulibank') and security:isGroup($rundata) and $isModified != 'Y'"> 
	   			 	 <xsl:call-template name="select-field">
	   				 <xsl:with-param name="label">XSL_FACILITY_BANK_ABBV_NAME</xsl:with-param>
	       				<xsl:with-param name="name">bank_abbv_name</xsl:with-param>
	     				<xsl:with-param name="size">10</xsl:with-param>
	     				<xsl:with-param name="required">Y</xsl:with-param>
	      				 <xsl:with-param name="options">
	    				 	<xsl:for-each select="banks_facility/bank_facility">
	     						<option>
		     							<xsl:value-of select="bank_abbv_name_facility"></xsl:value-of>
	    					 	</option>
	    					 </xsl:for-each>
	      				 </xsl:with-param>
	      				</xsl:call-template>
	   			</xsl:when>
	   			<xsl:otherwise>
	      				<xsl:call-template name="input-field">
	  					<xsl:with-param name="label">XSL_FACILITY_BANK_ABBV_NAME</xsl:with-param>
	    				<xsl:with-param name="name">bank_abbv_name</xsl:with-param>
	    				<xsl:with-param name="size">70</xsl:with-param>
	   					<xsl:with-param name="maxsize">70</xsl:with-param>
	   					<xsl:with-param name="fieldsize">large</xsl:with-param>
	   					<xsl:with-param name="required">Y</xsl:with-param>
	   					<xsl:with-param name="disabled">Y</xsl:with-param>
	   				</xsl:call-template>
	      			</xsl:otherwise>
	      	</xsl:choose>
	      	<xsl:choose>
	      	<xsl:when test="$isModified = 'Y' or $displaymode = 'view'">
  				<xsl:call-template name="input-field">
  					<xsl:with-param name="label">XSL_FACILITY_REFERENCE</xsl:with-param>
    				<xsl:with-param name="name">facility_reference</xsl:with-param>
    				<xsl:with-param name="size">20</xsl:with-param>
   					<xsl:with-param name="maxsize">20</xsl:with-param>
   					<xsl:with-param name="fieldsize">large</xsl:with-param>
   					<xsl:with-param name="required">Y</xsl:with-param>
   					<xsl:with-param name="disabled">Y</xsl:with-param>
   				</xsl:call-template>
				<xsl:call-template name="input-field">
		  			<xsl:with-param name="label">XSL_FACILITY_BACK_OFFICE_REF</xsl:with-param>
		    		<xsl:with-param name="name">bo_reference</xsl:with-param>
		    		<xsl:with-param name="size">70</xsl:with-param>
		   			<xsl:with-param name="maxsize">70</xsl:with-param>
		   			<xsl:with-param name="fieldsize">large</xsl:with-param>
		   			<xsl:with-param name="required">Y</xsl:with-param>
		   			<xsl:with-param name="disabled">Y</xsl:with-param>
		   		</xsl:call-template>
   			</xsl:when>
   			<xsl:otherwise>
   			<xsl:call-template name="input-field">
  					<xsl:with-param name="label">XSL_FACILITY_REFERENCE</xsl:with-param>
    				<xsl:with-param name="name">facility_reference</xsl:with-param>
    				<xsl:with-param name="size">20</xsl:with-param>
   					<xsl:with-param name="maxsize">20</xsl:with-param>
   					<xsl:with-param name="fieldsize">large</xsl:with-param>
   					<xsl:with-param name="required">Y</xsl:with-param>
   				</xsl:call-template>
				<xsl:call-template name="select-field">
				   		<xsl:with-param name="label">XSL_FACILITY_BACK_OFFICE_REF</xsl:with-param>
						<xsl:with-param name="name">bo_reference</xsl:with-param>
	     				<xsl:with-param name="size">10</xsl:with-param>
				     	<xsl:with-param name="required">Y</xsl:with-param>
				      	<xsl:with-param name="options">
				    		<xsl:for-each select="customer_reference">
				     			<option>
					     			<xsl:value-of select="utils:decryptApplicantReference(reference)"></xsl:value-of>
				    			</option>
				    		 </xsl:for-each>
				      	</xsl:with-param>
				 </xsl:call-template>
   			</xsl:otherwise>
   			</xsl:choose>
   				<xsl:call-template name="input-field">
  					<xsl:with-param name="label">XSL_FACILITY_DESCRIPTION</xsl:with-param>
    				<xsl:with-param name="name">facility_description</xsl:with-param>
    				<xsl:with-param name="size">80</xsl:with-param>
   					<xsl:with-param name="maxsize">80</xsl:with-param>
   					<xsl:with-param name="fieldsize">large</xsl:with-param>
   					<xsl:with-param name="required">N</xsl:with-param>
   				</xsl:call-template>
   				<xsl:call-template name="currency-field">
						<xsl:with-param name="label">XSL_FACILITY_AMOUNT</xsl:with-param>
						<xsl:with-param name="product-code">base</xsl:with-param>
						<xsl:with-param name="override-currency-value"><xsl:value-of select="cur_code"/></xsl:with-param>
						<xsl:with-param name="override-amt-name">facility_amt</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
						<xsl:with-param name="show-button">
			   			  	<xsl:choose>
			   					<xsl:when test="$isModified = 'Y'">N</xsl:when>
			   					<xsl:otherwise>Y</xsl:otherwise>
			   				</xsl:choose>
		   				</xsl:with-param>
		   		</xsl:call-template>
		   		  <div style="display:none;">
				     	<xsl:call-template name="currency-field">
							<xsl:with-param name="override-amt-name">facility_outstanding_amt</xsl:with-param>
							<xsl:with-param name="show-button">N</xsl:with-param>
							<xsl:with-param name="show-currency">N</xsl:with-param>
							<xsl:with-param name="override-amt-value"><xsl:value-of select="outstanding_amt"></xsl:value-of></xsl:with-param>
		   				</xsl:call-template>
		   				<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">temp_outstanding_facility_amt</xsl:with-param>
						<xsl:with-param name="value" select="outstanding_amt"/>
					</xsl:call-template>
		   		</div>
		   		<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_FACILITY_DATE</xsl:with-param>
					<xsl:with-param name="name">review_date</xsl:with-param>
					<xsl:with-param name="type">date</xsl:with-param>
					<xsl:with-param name="size">10</xsl:with-param>
					<xsl:with-param name="maxsize">10</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
	   			</xsl:call-template>
	   			<xsl:call-template name="input-field">
  					<xsl:with-param name="label">XSL_FACILITY_PRICING_DETAILS</xsl:with-param>
    				<xsl:with-param name="name">facility_pricing_details</xsl:with-param>
    				<xsl:with-param name="size">250</xsl:with-param>
   					<xsl:with-param name="maxsize">250</xsl:with-param>
   					<xsl:with-param name="fieldsize">large</xsl:with-param>
   				</xsl:call-template>
   				<xsl:choose>
   				<xsl:when  test="$displaymode = 'edit'">
   				<xsl:call-template name="select-field">
   					<xsl:with-param name="label">XSL_JURISDICTION_ACTIVE_LABEL</xsl:with-param>
						<xsl:with-param name="name">facility_status</xsl:with-param>
	     				<xsl:with-param name="size">10</xsl:with-param>
				     	<xsl:with-param name="required">Y</xsl:with-param>
				      	<xsl:with-param name="options">
							<xsl:call-template name="status_options"/>
				      	</xsl:with-param>
				      	<xsl:with-param name="value"><xsl:value-of select="status"/> </xsl:with-param>
   				</xsl:call-template>
   				</xsl:when>
   				<xsl:otherwise>
   					<xsl:call-template name="input-field">
   					<xsl:with-param name="label">XSL_JURISDICTION_ACTIVE_LABEL</xsl:with-param>
   						<xsl:with-param name="name">facility_status</xsl:with-param>
   						<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N020', status)"/></xsl:with-param>
   					</xsl:call-template>
   				</xsl:otherwise>
   				</xsl:choose>
   				<xsl:if test="entities[.='Y']">
	   			<xsl:call-template name="fieldset-wrapper">
  					<xsl:with-param name="legend">XSL_FACILITY_ENTITY_LIST</xsl:with-param>
 							<xsl:with-param name="content">
	   			<div id= "facility-entity"> 
	   			 <xsl:if test="$displaymode = 'edit'">
   	 			 <xsl:attribute name="class">collapse-label</xsl:attribute>
   				</xsl:if>
   				<xsl:choose>
   				<xsl:when test="$displaymode = 'edit'">
	   			 <xsl:call-template name="select-field">
       				<xsl:with-param name="name">entity_avail_list_facility</xsl:with-param>
       				<xsl:with-param name="type">multiple</xsl:with-param>
     				<xsl:with-param name="size">10</xsl:with-param>
      				 <xsl:with-param name="options">
    				 	<xsl:for-each select="avail_entities/entity">
     						<option>
								<!-- <xsl:attribute name="value"><xsl:value-of select="entity_id"/></xsl:attribute> -->
	     							<xsl:value-of select="entity_abbv_name"/>
    					 	</option>
    					 </xsl:for-each>
      				 </xsl:with-param>
      			</xsl:call-template>
      			
      			
      			 <div id="add-remove-buttons-facility" class="multiselect-buttons">
	    				 <button dojoType="dijit.form.Button" type="button">
	      					<xsl:attribute name="onClick">misys.addMultiSelectItems(dijit.byId('entity_select_list_facility'), dijit.byId('entity_avail_list_facility'));</xsl:attribute>
	    					  <xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_ADD')" />
	     				 <img>
	      					<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($arrowDownImage)"/></xsl:attribute>
	     					<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_ADD')" /></xsl:attribute>
	     			 	</img>
	     				</button>
		     				<button dojoType="dijit.form.Button" type="button" id="removeFacilityEntityButton">
		      				<!-- <xsl:attribute name="onClick">misys.addMultiSelectItems(dijit.byId('entity_avail_list_facility'), dijit.byId('entity_select_list_facility'))</xsl:attribute> -->
		     					 <xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REMOVE')" />
		     			  <img>
		      				<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($arrowUpImage)"/></xsl:attribute>
		      				<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REMOVE')" /></xsl:attribute>
		      			</img>
		     			</button>
    			</div>
      			<xsl:call-template name="select-field">
       				<xsl:with-param name="name">entity_select_list_facility</xsl:with-param>
       				<xsl:with-param name="type">multiple</xsl:with-param>

     				<xsl:with-param name="size">10</xsl:with-param>
      				 <xsl:with-param name="options">
    				 	<xsl:for-each select="attached_entities/entity">
     						<option>
								<!-- <xsl:attribute name="value"><xsl:value-of select="entity_id"/></xsl:attribute> -->
	     							<xsl:value-of select="entity_abbv_name"/>
    					 	</option>
    					 </xsl:for-each>
      				 </xsl:with-param>
      			</xsl:call-template>
      			</xsl:when>
      			<xsl:otherwise>
      			 <xsl:call-template name="select-field">
				    <xsl:with-param name="name">entity_select_list_facility</xsl:with-param>
				    <xsl:with-param name="type">multiple</xsl:with-param>
				    <xsl:with-param name="size">10</xsl:with-param>
				    <xsl:with-param name="options">
				     <ul class="multi-select">
				    <xsl:for-each select="attached_entities/entity">
     						<li>
	     							<xsl:value-of select="entity_abbv_name"></xsl:value-of>
    					 	</li>
    				</xsl:for-each>
    				</ul>
				    </xsl:with-param>
				   </xsl:call-template>
				 </xsl:otherwise>
      			</xsl:choose>
      			</div>
      			</xsl:with-param>
      			</xsl:call-template>
      			</xsl:if>
      			 <xsl:if test="$isModified = 'Y'">
				     <xsl:call-template name="hidden-field">
				    	<xsl:with-param name="name">isModified</xsl:with-param>	  
				    	<xsl:with-param name="value">$isModified</xsl:with-param>  
				     </xsl:call-template>
				     <div style="display:none;">
				     	<xsl:call-template name="currency-field">
							<xsl:with-param name="override-amt-name">previous_facility_amt</xsl:with-param>
							<xsl:with-param name="show-button">N</xsl:with-param>
							<xsl:with-param name="show-currency">N</xsl:with-param>
							<xsl:with-param name="override-amt-value"><xsl:value-of select="facility_amt"></xsl:value-of></xsl:with-param>
		   				</xsl:call-template>
		   				<xsl:call-template name="currency-field">
							<xsl:with-param name="override-amt-name">previous_limit_amt</xsl:with-param>
							<xsl:with-param name="show-button">N</xsl:with-param>
							<xsl:with-param name="show-currency">N</xsl:with-param>
		   				</xsl:call-template>
				     </div>
				  </xsl:if>.
				  <xsl:call-template name="hidden-field">
				  	<xsl:with-param name="name">enablePendingBank</xsl:with-param>	  
				    <xsl:with-param name="value"><xsl:value-of select="pending_bank_enable"/></xsl:with-param>  
				  </xsl:call-template>
				  <xsl:call-template name="hidden-field">
				  	<xsl:with-param name="name">facilityAmtValidation</xsl:with-param>	  
				    <xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('FACILITY_AMOUNT_VALIDATION_REQUIRED')"/></xsl:with-param>  
				  </xsl:call-template>
     		</xsl:with-param>      		
  		</xsl:call-template>
  		
  		<xsl:call-template name="limit-details" />
  		
  		<xsl:call-template name="limit-details-declaration" />
  		
  	</xsl:template>
  	
  	<xsl:template name="limit-details">
	     <xsl:if test="security:isCustomer($rundata)">
	  		<xsl:call-template name="download-button">
	  			<xsl:with-param name="label">Download File</xsl:with-param>
	  			<xsl:with-param name="showcsv">Y</xsl:with-param>
	  			<xsl:with-param name="showxls">Y</xsl:with-param>
	  		</xsl:call-template>
  		</xsl:if>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_FACILITY_LIMIT_DETAILS</xsl:with-param>
			<xsl:with-param name="content">&nbsp;
				<xsl:call-template name="build-limit-details-dojo-items">
					<xsl:with-param name="items" select="limits/limit" />
					<xsl:with-param name="id" select="limits" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>	
	
	<xsl:template name="build-limit-details-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->

		<div dojoType="misys.system.widget.LimitDetails" dialogId="limit-details-dialog-template">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_FACILITY_ADD_LIMIT')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_FACILITY_EDIT_LIMIT')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_FACILITY_VIEW_LIMIT')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_LIMIT_REFERENCE_HEADER')" />,
				<xsl:value-of select="localization:getGTPString($language, 'CURCODE')" />,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_LIMIT_AMOUNT_HEADER')" />,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_LIMIT_DATE_HEADER')" />,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_LIMIT_PRODUCT_HEADER')" />,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_LIMIT_SUB_PRODUCT_HEADER')" />,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_LIMIT_OUTSTANDING_LIMIT_HEADER')" />,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_LIMIT_PENDING_BANK_HEADER')" />,
				<!-- <xsl:value-of select="localization:getGTPString($language, 'XSL_LIMIT_PENDING_CUST_HEADER')" />, -->
				<xsl:value-of select="localization:getGTPString($language, 'XSL_LIMIT_UTILISED_AMT_HEADER')" />,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_LIMIT_UTILIZED_PERCENT_HEADER')" />,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_LINKED_ENTITIES_HEADER')" />,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_STATUS')" />
			</xsl:attribute>
			<xsl:if test="$items">
			<xsl:for-each select="$items">
				<xsl:variable name="limit" select="." />
				<div dojoType="misys.system.widget.LimitDetail">
				<xsl:attribute name="product_code"><xsl:value-of
						select="$limit/product_code" />
				</xsl:attribute>
				<xsl:attribute name="product_code_label">
				<xsl:choose>
				<xsl:when test="((defaultresource:isSwift2019Enabled() = 'true') and product_code = 'BG')">
					<xsl:value-of select="localization:getDecode($language, 'N001', 'IU')" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="localization:getDecode($language, 'N001', product_code)" />
				</xsl:otherwise>
				</xsl:choose>
				</xsl:attribute>
				<xsl:attribute name="sub_product_code"><xsl:value-of
						select="$limit/sub_product_code" />
				</xsl:attribute>
				<xsl:attribute name="sub_product_code_label">
					<xsl:value-of select="localization:getDecode($language, 'N047', sub_product_code)" />
				</xsl:attribute>
				<xsl:attribute name="product_type_code"><xsl:value-of
						select="$limit/product_type_code" />
				</xsl:attribute>
				<xsl:attribute name="product_type_code_label">
					<xsl:value-of select="localization:getCodeData($language,'*', product_code,'C011', product_type_code)"/>
				</xsl:attribute>
				<xsl:attribute name="product_template"><xsl:value-of
						select="$limit/product_template" />
				</xsl:attribute>
				<xsl:attribute name="beneficiary_name"><xsl:value-of
						select="$limit/counterparty" />
				</xsl:attribute>
				<xsl:attribute name="beneficiary_country"><xsl:value-of
						select="$limit/country" />
				</xsl:attribute>
				<xsl:attribute name="limit_id"><xsl:value-of
						select="$limit/limit_id" />
				</xsl:attribute>
				<xsl:attribute name="limit_ref"><xsl:value-of
						select="$limit/limit_reference" />
				</xsl:attribute>
				<xsl:attribute name="limit_amt"><xsl:value-of
						select="$limit/limit_amt" />
				</xsl:attribute>
				<xsl:attribute name="limit_cur_code"><xsl:value-of
						select="$limit/cur_code" />
				</xsl:attribute>
				<xsl:attribute name="limit_review_date"><xsl:value-of
						select="$limit/review_date" />
				</xsl:attribute>
				<xsl:attribute name="limit_pricing"><xsl:value-of
						select="$limit/limit_pricing_details" />
				</xsl:attribute>
				
				<xsl:attribute name="limit_outstanding_amt"><xsl:value-of
						select="$limit/outstanding_amt" />
				</xsl:attribute>
				<xsl:attribute name="limit_pending_bank_amt"><xsl:value-of
						select="$limit/pending_bank_amt" />
				</xsl:attribute>
				<!-- <xsl:attribute name="limit_pending_customer_amt"><xsl:value-of
						select="$limit/pending_customer_amt" />
				</xsl:attribute> -->
				<xsl:attribute name="limit_utilised_amt"><xsl:value-of
						select="$limit/utilised_amt" />
				</xsl:attribute>
				<xsl:attribute name="limit_utilised_percent"><xsl:value-of
						select="$limit/utilised_percent" />
				</xsl:attribute>
				<xsl:attribute name="linked_entities_number"><xsl:value-of
						select="$limit/linked_entities" />
				</xsl:attribute>
				
				<xsl:attribute name="entity_avail_list_limit"><xsl:value-of
						select="$limit/entity_avail_list_limit" />
				</xsl:attribute>
				<xsl:attribute name="entity_select_list_limit"><xsl:value-of
						select="$limit/entity_select_list_limit" />
				</xsl:attribute>
				<xsl:attribute name="existing_limit"><xsl:value-of
						select="$limit/existing_limit" />
				</xsl:attribute>
				<xsl:attribute name="limit_status"><xsl:value-of
						select="$limit/status" />
				</xsl:attribute>
				<xsl:attribute name="limit_status_label">
					<xsl:if test="$limit/status[.='A']">
						<xsl:value-of select="localization:getGTPString($language,'N020_A')"/>
					</xsl:if>
					<xsl:if test="$limit/status[.='I']">
						<xsl:value-of select="localization:getGTPString($language,'N020_I')"/>
					</xsl:if>
				</xsl:attribute>
				<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">temp_limit_outstanding_amt<xsl:value-of select="$limit/limit_id" /></xsl:with-param>
						<xsl:with-param name="value" select="$limit/outstanding_amt"/>
						</xsl:call-template>
				</div>
			</xsl:for-each>
			</xsl:if>
		</div>
	</xsl:template>
  	
 	<xsl:template name="limit-details-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="limit-details-dialog-declaration" />
		<!-- Dialog End -->
		<div id="limit-details-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_FACILITY_NO_LIMIT')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode" id="addLimitButton">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_FACILITY_ADD_LIMIT')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template name="limit-details-dialog-declaration">
		<div id="limit-details-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
			<div class="standardPODialogContent">
			<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="legend">XSL_LIMIT_DEFINITION</xsl:with-param>
				<xsl:with-param name="content">&nbsp;
					<xsl:call-template name="column-container">
				  	 <xsl:with-param name="content">
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="content">
								<xsl:choose>
									<xsl:when test="$displaymode = 'edit'">
								<xsl:variable name="productCode"><xsl:value-of select="limits/limit/product_code"/></xsl:variable>
								<xsl:call-template name="select-field">
									<xsl:with-param name="label">XSL_LIMIT_PRODUCT</xsl:with-param>
									<xsl:with-param name="name">product_code</xsl:with-param>
									<xsl:with-param name="required">Y</xsl:with-param>
									<xsl:with-param name="options">
										<xsl:choose>
											<xsl:when test="$displaymode = 'edit'">
												<xsl:call-template name="product_code_options"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="localization:getDecode($language, 'N001', $productCode)" />
											</xsl:otherwise>
										</xsl:choose>
									</xsl:with-param>
									 <xsl:with-param name="override-displaymode">edit</xsl:with-param>
								</xsl:call-template>
								
								 <xsl:call-template name="hidden-field">
							    	<xsl:with-param name="name">product_code_hidden</xsl:with-param>	    
							     </xsl:call-template>
							     <xsl:call-template name="hidden-field">
							    	<xsl:with-param name="name">product_code_label</xsl:with-param>	    
							     </xsl:call-template>
							     <xsl:call-template name="hidden-field">
							    	<xsl:with-param name="name">limit_status_label</xsl:with-param>	    
							     </xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
										 <xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_LIMIT_PRODUCT</xsl:with-param>
											<xsl:with-param name="name">product_code</xsl:with-param>
											<xsl:with-param name="override-displaymode">edit</xsl:with-param>
											<xsl:with-param name="disabled">Y</xsl:with-param>
							   			</xsl:call-template>
								</xsl:otherwise>
							</xsl:choose>

								<xsl:choose>
									<xsl:when test="$displaymode = 'edit'">
											<xsl:call-template name="select-field">
												<xsl:with-param name="label">XSL_LIMIT_SUB_PRODUCT</xsl:with-param>
												<xsl:with-param name="name">sub_product_code</xsl:with-param>
												<xsl:with-param name="required">Y</xsl:with-param>
											</xsl:call-template>
											 <xsl:call-template name="hidden-field">
										    	<xsl:with-param name="name">sub_product_code_hidden</xsl:with-param>	    
										     </xsl:call-template>
										     <xsl:call-template name="hidden-field">
										    	<xsl:with-param name="name">sub_product_code_label</xsl:with-param>	    
										     </xsl:call-template>
									</xsl:when>
									<xsl:otherwise>
											 <xsl:call-template name="input-field">
												<xsl:with-param name="label">XSL_LIMIT_SUB_PRODUCT</xsl:with-param>
												<xsl:with-param name="name">sub_product_code</xsl:with-param>
												<xsl:with-param name="override-displaymode">edit</xsl:with-param>
												<xsl:with-param name="disabled">Y</xsl:with-param>
								   			</xsl:call-template>
									</xsl:otherwise>
								</xsl:choose>

							<xsl:if test="enable_product_type = 'Y'or $displaymode = 'view'">
								<div id="productTypeDiv">
									<xsl:choose>
										<xsl:when test="$displaymode = 'edit'">
											<xsl:call-template name="select-field">
												<xsl:with-param name="label">XSL_LIMIT_TYPE_SUB_PRODUCT</xsl:with-param>
												<xsl:with-param name="name">product_type_code</xsl:with-param>
												<xsl:with-param name="required">N</xsl:with-param>
												<xsl:with-param name="options"/>
											</xsl:call-template>
											<xsl:call-template name="hidden-field">
										    	<xsl:with-param name="name">product_type_code_hidden</xsl:with-param>	    
										     </xsl:call-template>
										</xsl:when>
										<xsl:otherwise>
											 <xsl:call-template name="input-field">
												<xsl:with-param name="label">XSL_LIMIT_TYPE_SUB_PRODUCT</xsl:with-param>
												<xsl:with-param name="name">product_type_code</xsl:with-param>
												<xsl:with-param name="override-displaymode">edit</xsl:with-param>
												<xsl:with-param name="disabled">Y</xsl:with-param>
								   			</xsl:call-template>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:if test="enable_template = 'Y'or $displaymode = 'view'">
									<xsl:choose>
										<xsl:when test="$displaymode = 'edit'">
												<xsl:call-template name="select-field">
													<xsl:with-param name="label">XSL_LIMIT_PRODUCT_TEMPLATE</xsl:with-param>
													<xsl:with-param name="name">product_template</xsl:with-param>
													<xsl:with-param name="required">N</xsl:with-param>
													<xsl:with-param name="options"/>
												</xsl:call-template>
												<xsl:call-template name="hidden-field">
										    	<xsl:with-param name="name">product_template_hidden</xsl:with-param>	    
										     </xsl:call-template>
										</xsl:when>
										<xsl:otherwise>
												 <xsl:call-template name="input-field">
													<xsl:with-param name="label">XSL_LIMIT_PRODUCT_TEMPLATE</xsl:with-param>
													<xsl:with-param name="name">product_template</xsl:with-param>
													<xsl:with-param name="override-displaymode">edit</xsl:with-param>
													<xsl:with-param name="disabled">Y</xsl:with-param>
									   			</xsl:call-template>
										</xsl:otherwise>
									</xsl:choose>
									</xsl:if>
								</div>
								 </xsl:if> 
									<!-- TODO . change below 2 fields -->
								<xsl:choose>
								   	<xsl:when test="$displaymode = 'edit'">
								   		<xsl:if test="enable_counterparty = 'Y'">
											<xsl:call-template name="input-field">
												<xsl:with-param name="label">XSL_LIMIT_COUNTERPARTY</xsl:with-param>
												<xsl:with-param name="name">beneficiary_name</xsl:with-param>
												<xsl:with-param name="override-displaymode">edit</xsl:with-param>
												<xsl:with-param name="size">35</xsl:with-param>
												<xsl:with-param name="maxsize">35</xsl:with-param>
												<xsl:with-param name="required">N</xsl:with-param>
												<xsl:with-param name="fieldsize">facilityCounterparty</xsl:with-param>
												<xsl:with-param name="readonly">Y</xsl:with-param>
												<xsl:with-param name="value">
													<xsl:value-of select="counterparty" />
												</xsl:with-param>
												<xsl:with-param name="content-after">
												<xsl:if test="$displaymode = 'edit'">
													<xsl:call-template name="get-button">
												        <xsl:with-param name="button-type">beneficiary</xsl:with-param>
												        <xsl:with-param name="label">XSL_ALT_BENEFICIARY</xsl:with-param>
												        <xsl:with-param name="non-dijit-button">Y</xsl:with-param>
												      </xsl:call-template>
				    							</xsl:if>
												</xsl:with-param>
											</xsl:call-template>
										
											<xsl:call-template name="country-field">
											    <xsl:with-param name="label">XSL_LIMIT_COUNTRY</xsl:with-param>
											    <xsl:with-param name="override-displaymode">edit</xsl:with-param>
											    <xsl:with-param name="prefix">beneficiary</xsl:with-param>
											    <xsl:with-param name="readonly">Y</xsl:with-param>
										    </xsl:call-template>
								  		</xsl:if> 
								   	</xsl:when>
								   	<xsl:otherwise>
								   		<xsl:call-template name="input-field">
												<xsl:with-param name="label">XSL_LIMIT_COUNTERPARTY</xsl:with-param>
												<xsl:with-param name="name">beneficiary_name</xsl:with-param>
												<xsl:with-param name="override-displaymode">edit</xsl:with-param>
												<xsl:with-param name="size">35</xsl:with-param>
												<xsl:with-param name="maxsize">35</xsl:with-param>
												<xsl:with-param name="required">N</xsl:with-param>
												<xsl:with-param name="fieldsize">facilityCounterparty</xsl:with-param>
												<xsl:with-param name="readonly">Y</xsl:with-param>
												<xsl:with-param name="value">
													<xsl:value-of select="counterparty" />
												</xsl:with-param>
												<xsl:with-param name="disabled">Y</xsl:with-param>
											</xsl:call-template>
										
											<xsl:call-template name="country-field">
											    <xsl:with-param name="label">XSL_LIMIT_COUNTRY</xsl:with-param>
											    <xsl:with-param name="override-displaymode">edit</xsl:with-param>
											    <xsl:with-param name="prefix">beneficiary</xsl:with-param>
											    <xsl:with-param name="readonly">Y</xsl:with-param>
												 <xsl:with-param name="disabled">Y</xsl:with-param>
										    </xsl:call-template>
								   	</xsl:otherwise>
							   	</xsl:choose>
							   <xsl:choose>
							   	<xsl:when test="$displaymode = 'edit'">
								    <xsl:call-template name="select-field">
					  					<xsl:with-param name="label">XSL_JURISDICTION_ACTIVE_LABEL</xsl:with-param>
										<xsl:with-param name="name">limit_status</xsl:with-param>
					     				<xsl:with-param name="size">10</xsl:with-param>
								     	<xsl:with-param name="required">Y</xsl:with-param>
										<xsl:with-param name="options">
											<xsl:call-template name="status_options"/>
										</xsl:with-param>
					  				</xsl:call-template>
					  			</xsl:when>
					  			<xsl:otherwise>
					  			<xsl:variable name="limit_status"><xsl:value-of select="limits/limit/status"/></xsl:variable>
					  				<xsl:call-template name="input-field">
				   						<xsl:with-param name="label">XSL_JURISDICTION_ACTIVE_LABEL</xsl:with-param>
				   						<xsl:with-param name="name">limit_status</xsl:with-param>
				   						<xsl:with-param name="override-displaymode">edit</xsl:with-param>
										<xsl:with-param name="disabled">Y</xsl:with-param>
				   					</xsl:call-template>
					  			</xsl:otherwise>
							    </xsl:choose>						
							</xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="content">
								<div style="display:none;">
									<xsl:call-template name="input-field">
										<xsl:with-param name="name">limit_id</xsl:with-param>
									</xsl:call-template>
								</div>
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_LIMIT_REFERENCE</xsl:with-param>
									<xsl:with-param name="name">limit_ref</xsl:with-param>
									<xsl:with-param name="regular-expression">[^\%^&lt;&gt;]*</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="size">20</xsl:with-param>
									<xsl:with-param name="maxsize">20</xsl:with-param>
									<xsl:with-param name="disabled">
										<xsl:choose>
											<xsl:when test="$displaymode = 'view'">Y</xsl:when>
											<xsl:otherwise>N</xsl:otherwise>
										</xsl:choose>
									</xsl:with-param>
									<xsl:with-param name="required">
				      				 	<xsl:choose>
				      				 		<xsl:when test="$displaymode = 'view'">N</xsl:when>
				      				 		<xsl:otherwise>Y</xsl:otherwise>
				      				 	</xsl:choose>
				      				 </xsl:with-param>
								</xsl:call-template>

						<xsl:choose>
							<xsl:when test="$displaymode = 'edit'">
								<xsl:call-template name="currency-field">
									<xsl:with-param name="label">XSL_LIMIT_AMOUNT</xsl:with-param>
									<xsl:with-param name="product-code">limit</xsl:with-param>
									<xsl:with-param name="override-amt-name">limit_amt</xsl:with-param>
									<xsl:with-param name="required">Y</xsl:with-param>
					   			</xsl:call-template>
					   			
								</xsl:when>
									<xsl:otherwise>
											<xsl:call-template name="currency-field">
												<xsl:with-param name="label">XSL_LIMIT_AMOUNT</xsl:with-param>
												<xsl:with-param name="override-currency-name">limit_cur_code</xsl:with-param>
												<xsl:with-param name="override-amt-name">limit_amt</xsl:with-param>
												<xsl:with-param name="show-button">N</xsl:with-param>
												<xsl:with-param name="currency-readonly">Y</xsl:with-param>
												<xsl:with-param name="override-currency-displaymode">edit</xsl:with-param>
												<xsl:with-param name="amt-readonly">Y</xsl:with-param>
												<xsl:with-param name="override-amt-displaymode">edit</xsl:with-param>
												<xsl:with-param name="disabled">Y</xsl:with-param>
											</xsl:call-template>
									</xsl:otherwise>
								</xsl:choose>

					   			 <xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_LIMIT_DATE</xsl:with-param>
									<xsl:with-param name="name">limit_review_date</xsl:with-param>
									<xsl:with-param name="type">date</xsl:with-param>
									<xsl:with-param name="size">10</xsl:with-param>
									<xsl:with-param name="maxsize">10</xsl:with-param>
									<xsl:with-param name="fieldsize">small</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="disabled">
										<xsl:choose>
											<xsl:when test="$displaymode = 'view'">Y</xsl:when>
											<xsl:otherwise>N</xsl:otherwise>
										</xsl:choose>
									</xsl:with-param>
									<xsl:with-param name="required">
				      				 	<xsl:choose>
				      				 		<xsl:when test="$displaymode = 'view'">N</xsl:when>
				      				 		<xsl:otherwise>Y</xsl:otherwise>
				      				 	</xsl:choose>
				      				 </xsl:with-param>
					   			</xsl:call-template>
					   			 <xsl:call-template name="textarea-field">
					   				 <xsl:with-param name="label">XSL_LIMIT_PRICING</xsl:with-param>
						        	 <xsl:with-param name="name">limit_pricing</xsl:with-param>
						        	 <xsl:with-param name="rows">6</xsl:with-param>
						        	 <xsl:with-param name="cols">25</xsl:with-param>
						        	 <xsl:with-param name="maxlines">9</xsl:with-param>
						        	 <xsl:with-param name="swift-validate">N</xsl:with-param>
						        	 <xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="disabled">
										<xsl:choose>
											<xsl:when test="$displaymode = 'view'">Y</xsl:when>
											<xsl:otherwise>N</xsl:otherwise>
										</xsl:choose>
									</xsl:with-param>
						        </xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				  </xsl:call-template>
				  
				  <div style="display:none;">
				     	<xsl:call-template name="currency-field">
							<xsl:with-param name="override-amt-name">limit_outstanding_amt</xsl:with-param>
							<xsl:with-param name="show-button">N</xsl:with-param>
							<xsl:with-param name="show-currency">N</xsl:with-param>
							<xsl:with-param name="override-amt-value"><xsl:value-of select="limit_outstanding_amt"/></xsl:with-param>
		   				</xsl:call-template>
		   		</div>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">limit_pending_bank_amt</xsl:with-param>
						<xsl:with-param name="value" select="pending_bank_amt"/>
					</xsl:call-template>
					<!-- <xsl:call-template name="hidden-field">
						<xsl:with-param name="name">limit_pending_customer_amt</xsl:with-param>
						<xsl:with-param name="value" select="pending_cust_amt"/>
					</xsl:call-template> -->
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">limit_utilised_amt</xsl:with-param>
						<xsl:with-param name="value" select="utilised_amt"/>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">limit_utilised_percent</xsl:with-param>
						<xsl:with-param name="value" select="utilised_percent"/>
					</xsl:call-template>
					
					<xsl:variable name="hasCurrencyValidation"><xsl:value-of select="defaultresource:getResource('LIMIT_CURRENCY_VALIDATION_PERMITTED')"/></xsl:variable>
					 <xsl:call-template name="hidden-field">
				    	<xsl:with-param name="name">currency_validation</xsl:with-param>	  
				    	<xsl:with-param name="value"><xsl:value-of select="$hasCurrencyValidation"/></xsl:with-param>  
				     </xsl:call-template>
				     
				      <xsl:call-template name="hidden-field">
				    	<xsl:with-param name="name">limit_total_amount_validation</xsl:with-param>	  
				    	<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('FACILITY_AMOUNT_VALIDATION_REQUIRED')"/></xsl:with-param>  
				     </xsl:call-template>
				     
				     <xsl:call-template name="hidden-field">
				    	<xsl:with-param name="name">lmt_cpty_template</xsl:with-param>	  
				    	<xsl:with-param name="value"><xsl:value-of select="lmt_cpty_template"/></xsl:with-param>  
				     </xsl:call-template>
				  
				  
				 <xsl:if test="entities[.='Y']">
				  <xsl:call-template name="fieldset-wrapper">
  					<xsl:with-param name="legend">XSL_LIMIT_ENTITY_LIST</xsl:with-param>
 							<xsl:with-param name="content">
	   						<div id= "limit-entity"> 
	   						 	<xsl:if test="$displaymode = 'edit'">
   	 				 				<xsl:attribute name="class">collapse-label</xsl:attribute>
   								</xsl:if>
   								<xsl:choose>
   									<xsl:when test="$displaymode = 'edit'">
	   									<xsl:call-template name="select-field">
       										<xsl:with-param name="name">entity_avail_list_limit</xsl:with-param>
       										<xsl:with-param name="type">multiple</xsl:with-param>
       										<xsl:with-param name="size">10</xsl:with-param>
     										<xsl:with-param name="override-displaymode">edit</xsl:with-param>
      				 						<xsl:with-param name="options">
					    				 
      									 </xsl:with-param>
      									</xsl:call-template>

      									 <div id="add-remove-buttons-limit" class="multiselect-buttons">
	    									 <button dojoType="dijit.form.Button" type="button" id="add_limit_entity">
	      										<xsl:attribute name="onClick">misys.addMultiSelectItems(dijit.byId('entity_select_list_limit'), dijit.byId('entity_avail_list_limit'));</xsl:attribute>
	    					 					 <xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_ADD')" />
	     				 						<img>
							      					<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($arrowDownImage)"/></xsl:attribute>
							     					<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_ADD')" /></xsl:attribute>
							     			 	</img>
	     									</button>
		     								<button dojoType="dijit.form.Button" type="button" id="remove_limit_entity">
							      			 	<xsl:attribute name="onClick">misys.addMultiSelectItems(dijit.byId('entity_avail_list_limit'), dijit.byId('entity_select_list_limit'))</xsl:attribute>
							     				<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REMOVE')" />
							     			 	<img>
								      				<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($arrowUpImage)"/></xsl:attribute>
								      				<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REMOVE')" /></xsl:attribute>
							      				</img>
		     								</button>
    									</div>
						      			<xsl:call-template name="select-field">
						       				<xsl:with-param name="name">entity_select_list_limit</xsl:with-param>
						       				<xsl:with-param name="type">multiple</xsl:with-param>
						     				<xsl:with-param name="size">10</xsl:with-param>
						     				<!-- <xsl:with-param name="override-displaymode">edit</xsl:with-param> -->
						      				 <xsl:with-param name="options"/>
											<xsl:with-param name="disabled">
						      				 	<xsl:choose>
						      				 		<xsl:when test="$displaymode = 'view'">Y</xsl:when>
						      				 		<xsl:otherwise>N</xsl:otherwise>
						      				 	</xsl:choose>
						      				 </xsl:with-param>
						      			</xsl:call-template>
      								</xsl:when>
					      			<xsl:otherwise>
					      			 <xsl:call-template name="select-field">
									    <xsl:with-param name="name">entity_select_list_limit</xsl:with-param>
									    <xsl:with-param name="type">multiple</xsl:with-param>
									    <xsl:with-param name="size">10</xsl:with-param>
										<xsl:with-param name="override-displaymode">edit</xsl:with-param>
											  <xsl:with-param name="disabled">Y</xsl:with-param>
											  <xsl:with-param name="options">
						    				 	<xsl:for-each select="attached_entities/entity">
						     						<option>

														<xsl:attribute name="value"><xsl:value-of select="entity_id"/></xsl:attribute>
							     							<xsl:value-of select="entity_abbv_name"/>
						    					 	</option>
						    					 </xsl:for-each>
						      				 </xsl:with-param>
									   </xsl:call-template>
									 </xsl:otherwise>
      							</xsl:choose>
      						</div>
      					</xsl:with-param>
      			</xsl:call-template>
      			</xsl:if>
			<xsl:call-template name="hidden-field">
    			<xsl:with-param name="name">linked_entities_number</xsl:with-param>	    
    			<xsl:with-param name="value">0</xsl:with-param>
     		</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			</div>
			<div class="dijitDialogPaneActionBar">
				<xsl:call-template name="label-wrapper">
					<xsl:with-param name="content">
						<button type="button" dojoType="dijit.form.Button">
							<xsl:attribute name="onmouseup">dijit.byId('limit-details-dialog-template').hide();</xsl:attribute>
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
						</button>							
						<button dojoType="dijit.form.Button">
							<xsl:attribute name="onClick">dijit.byId('limit-details-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
						</button>
					</xsl:with-param>
				</xsl:call-template>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template name="product_code_options">
		<xsl:for-each select="/input/master_facility_record/avail_products/products/product">
			<xsl:variable name="productName" select="product_code" />
			<xsl:choose>
				<xsl:when test="$productName='ALL'">
					<option value="*">
						<xsl:value-of select="localization:getDecode($language, 'N001', '*')"/>
					</option>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="((defaultresource:isSwift2019Enabled() = 'true') and $productName = 'BG')">
							<option value="{$productName}">
							<xsl:value-of select="localization:getDecode($language, 'N001', 'IU')"/>
							</option>
					     </xsl:when>
					     <xsl:otherwise>
					     	<option value="{$productName}">
					     		<xsl:value-of select="localization:getDecode($language, 'N001', $productName)"/>
					     	</option>	
					     </xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	
 <xsl:template name="realform">
  <!-- Do not display this section when the counterparty mode is 'counterparty' -->
  <xsl:if test="$collaborationmode != 'counterparty'">
  <xsl:call-template name="form-wrapper">
   <xsl:with-param name="name">realform</xsl:with-param>
   <xsl:with-param name="method">POST</xsl:with-param>
   <xsl:with-param name="action"> <xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$nextscreen"/></xsl:with-param>
    <xsl:with-param name="content">
     <div class="widgetContainer">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">operation</xsl:with-param>
       <xsl:with-param name="id">realform_operation</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="$operation"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
        <xsl:with-param name="value"><xsl:value-of select="$option"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">token</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$token"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      	<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">processdttm</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="$processdttm"/></xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">company</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="input/master_facility_record/company_abbv_name"/></xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="e2ee_transaction"/>
      <xsl:if test="input/master_facility_record/facility_id[.!='']">
      	<xsl:call-template name="hidden-field">
       		<xsl:with-param name="name">featureid</xsl:with-param>
       		<xsl:with-param name="value"><xsl:value-of select="input/master_facility_record/facility_id"/></xsl:with-param>
      	</xsl:call-template>
      </xsl:if></div>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:if>
  </xsl:template>
  <xsl:template name="entities">
	 <xsl:call-template name="fieldset-wrapper">
	  <xsl:with-param name="legend">XSL_ENTITY_SELECTION</xsl:with-param>
	  <xsl:with-param name="content">
	  </xsl:with-param>
	 </xsl:call-template>	
 </xsl:template>
 <xsl:template name="status_options">
   		<option>
			<xsl:attribute name="value">A</xsl:attribute>
			<xsl:value-of select="localization:getGTPString($language,'N020_A')"/> 
		</option>
		<option>
			<xsl:attribute name="value">I</xsl:attribute>
			<xsl:value-of select="localization:getGTPString($language,'N020_I')"/> 
		</option>
 </xsl:template>
</xsl:stylesheet>