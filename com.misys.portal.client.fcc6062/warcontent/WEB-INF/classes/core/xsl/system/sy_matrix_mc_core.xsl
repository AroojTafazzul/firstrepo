<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Matrix Screen, System Form.

Copyright (c) 2000-2011 Misys (http://www.misys.com),
All Rights Reserved. 


-->
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		exclude-result-prefixes="localization security defaultresource">
 
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="languages"/>
  <xsl:param name="nextscreen"/>
  <xsl:param name="option"/>
  <xsl:param name="action"/>
  <xsl:param name="company_type"/>
  <xsl:param name="tnx_type_code_value"/>
  <xsl:param name="token"/>
  <xsl:param name="displaymode">edit</xsl:param>
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="operation">SAVE_FEATURES</xsl:param>
  <xsl:param name="override_company_abbv_name"></xsl:param>
  <xsl:param name="user_company_type"/>
  <xsl:param name="product">
	<xsl:choose>
    	<xsl:when test="matrix_record/product_code[.='']">*</xsl:when>
		<xsl:otherwise><xsl:value-of select="matrix_record/product_code"/></xsl:otherwise>
	</xsl:choose>
  </xsl:param>
  <xsl:param name="processdttm"/>
  <xsl:param name="minAmountEnable"><xsl:value-of select="defaultresource:getResource('AUTHMATRIX_MIN_AMT_ENABLE')"/></xsl:param>

  <!-- Global Imports. -->
  <xsl:include href="../../../core/xsl/common/system_common.xsl" />
  <xsl:include href="../../../core/xsl/common/attachment_templates.xsl" />
  <xsl:include href="../../../core/xsl/common/maker_checker_common.xsl" />
  <!-- TODO Removed the Client version of the reauthentication,
  But this stylesheet needs to go to the core or to be removed -->
  <xsl:include href="../../../core/xsl/system/sy_reauthenticationdialog.xsl" />
  <xsl:include href="../../../core/xsl/common/e2ee_common.xsl" />
    
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
   <xsl:apply-templates select="matrix_record"/>
  </xsl:template>
  <!-- <xsl:template name="type-options">
     <option value="*">
       	<xsl:value-of select="localization:getDecode($language, 'N071', '*')"/>
     </option>
      <option value="01">
       <xsl:value-of select="localization:getDecode($language, 'N071', '01')"/>
     </option>
      <option value="03">
      	<xsl:value-of select="localization:getDecode($language, 'N071', '03')"/>
     </option>
      <option value="13">
      	<xsl:value-of select="localization:getDecode($language, 'N071', '13')"/>
     </option>
</xsl:template>	 -->
  <xsl:template match="matrix_record">
   <!-- Loading message  -->
   <xsl:call-template name="loading-message"/>
    
   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
    
    <!-- Reauthentication Start -->
    <xsl:call-template name="server-message">
 		<xsl:with-param name="name">server_message</xsl:with-param>
 		<xsl:with-param name="content"><xsl:value-of select="message"/></xsl:with-param>
 		<xsl:with-param name="appendClass">serverMessage</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="reauthentication" />
    <!-- Reauthentication End -->
     
    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
      <xsl:call-template name="hidden-fields"/>
      <xsl:call-template name="matrix-details"/>
    
      <!--  Display common menu. -->
      <xsl:if test="$canCheckerReturnComments = 'true'">
      	<xsl:call-template name="comments-for-return-mc">
      		<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
      	</xsl:call-template>
      </xsl:if>
    
       <xsl:call-template name="maker-checker-menu"/>

     </xsl:with-param>        
    </xsl:call-template>
    
    <xsl:call-template name="realform"/>
   </div>
   <script>

   dojo.ready(function(){
  		misys._config = misys._config || {};
  		
  		dojo.mixin(misys._config, {
  			tenorTypeProductList : {
		   <xsl:for-each select="/matrix_record/tenor/tenor_type/product_code">
		   					<xsl:variable name="productCode" select="self::node()/text()" />
		   					<xsl:value-of select="."/>: [
		   						<xsl:for-each select="/matrix_record/tenor/tenor_type[product_code=$productCode]/tenor_type_details" >
		   							<xsl:variable name="tenorTypeDescription" select="tenor_type_description" />
		   							<xsl:variable name="tenorTypeCode" select="tenor_type_code" />
		   							{ value:"<xsl:value-of select="$tenorTypeCode"/>",
				         				name:"<xsl:value-of select="$tenorTypeDescription"/>"},
		   						</xsl:for-each>
		   						]<xsl:if test="not(position()=last())">,</xsl:if>
	   		</xsl:for-each>

	   		},
	   			productTypeCodeList : {
		   <xsl:for-each select="/matrix_record/prod_type_code/product_type_element/product_code">
		   					<xsl:variable name="productCode" select="self::node()/text()" />
		   					<xsl:value-of select="."/>: [
		   						<xsl:for-each select="/matrix_record/prod_type_code/product_type_element[product_code=$productCode]/product_type_details" >
		   							<xsl:variable name="productTypeDescription" select="product_type_description" />
		   							<xsl:variable name="productTypeCode" select="product_type_code" />
		   							{ value:"<xsl:value-of select="$productTypeCode"/>",
				         				name:"<xsl:value-of select="$productTypeDescription"/>"},
		   						</xsl:for-each>
		   						]<xsl:if test="not(position()=last())">,</xsl:if>
	   		</xsl:for-each>

	   		},
  				SubProductsCollection : {
	    			<xsl:if test="count(/matrix_record/avail_products/products/product/product_code) > 0" >
		        		<xsl:for-each select="/matrix_record/avail_products/products/product/product_code" >
		        			<xsl:variable name="productCode" select="self::node()/text()" />
	   						<xsl:value-of select="."/>: [
		   						<xsl:for-each select="/matrix_record/avail_products/products/product[product_code=$productCode]/sub_product_code" >
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
	    			<xsl:if test="count(/matrix_record/avail_products/products/product/product_code) > 0" >
		        		<xsl:for-each select="/matrix_record/avail_products/products/product/product_code" >
		        			<xsl:variable name="productCode" select="self::node()/text()" />
	   						<xsl:value-of select="."/>: [
		   						<xsl:choose>
		   						<xsl:when test="count(/matrix_record/avail_products/products/product[product_code=$productCode]/tnx_type) > 0">
		   						<xsl:for-each select="/matrix_record/avail_products/products/product[product_code=$productCode]/tnx_type" >
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
   <!-- Javascript imports  -->
   <xsl:call-template name="js-imports"/>
  </xsl:template>
  
 <!--                                     -->  
 <!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
 <!--                                     -->
 
 <!-- Additional JS imports for this form are -->
 <!-- added here. -->
 <xsl:template name="js-imports">
 <xsl:variable name="help_access_key">
  	<xsl:choose>
 		<xsl:when test="security:isBank($rundata)"><xsl:value-of select="'SY_JURIS'"></xsl:value-of></xsl:when>
 		<xsl:otherwise><xsl:value-of select="'JM_01'"></xsl:value-of></xsl:otherwise>
 	</xsl:choose>
 	</xsl:variable>
  <xsl:call-template name="system-common-js-imports">
   <xsl:with-param name="xml-tag-name">matrix_record</xsl:with-param>
   <xsl:with-param name="binding">misys.binding.system.matrix</xsl:with-param>
   <xsl:with-param name="override-help-access-key"><xsl:value-of select="$help_access_key"/></xsl:with-param>
   <xsl:with-param name="override-home-url">'/screen/<xsl:value-of select="$nextscreen"/>?option=<xsl:value-of select="$option"/><xsl:if test="$override_company_abbv_name!=''">&amp;company=<xsl:value-of select="$override_company_abbv_name"/></xsl:if>'</xsl:with-param>
   <xsl:with-param name="override-help-access-key">SY_JURIS_C</xsl:with-param>
   
  </xsl:call-template>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are  -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <div  class="widgetContainer">
    <xsl:call-template name="localization-dialog"/>
	<xsl:call-template name="hidden-field">
     <xsl:with-param name="name">matrix_id</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">company_id</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">wild_card_ind</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">amt_type</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">brch_code</xsl:with-param>
   </xsl:call-template>
    <xsl:if test="not(entities)">
   	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">entity</xsl:with-param>
		<xsl:with-param name="value">*</xsl:with-param>
   	</xsl:call-template>
   </xsl:if>
  </div>
 </xsl:template>
 
 <!--
  Main Details of the Company 
  -->
 <xsl:template name="matrix-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">MENU_CHANGE_AUTHORISATION_MC</xsl:with-param>
    <xsl:with-param name="button-type">
   		<xsl:if test="$hideMasterViewLink!='true'">mc-master-details</xsl:if>
   	</xsl:with-param>
   	<xsl:with-param name="override-displaymode">edit</xsl:with-param>
    <xsl:with-param name="content">
  	<!-- STATIC DATA -->
  	<!-- static_banque node is only passed for bank matrix maintenance on bankgroup side -->
    <xsl:if test="$option='BANK_AUTHORISATION_MAINTENANCE_MC'">
		<xsl:call-template name="input-field">
    		<xsl:with-param name="label">XSL_JURISDICTION_COMPANY</xsl:with-param>
    		<xsl:with-param name="name">bank_authorization</xsl:with-param> 
    		<xsl:with-param name="value"><xsl:value-of select="static_bank/abbv_name"/></xsl:with-param>
       		<xsl:with-param name="override-displaymode">view</xsl:with-param>
    	</xsl:call-template>
	</xsl:if>	 
	
    <!-- static_company is only passed for customer matrix maintenance on bankgroup side -->
    <xsl:if test="$option='CUSTOMER_AUTHORISATION_MAINTENANCE_MC'">
		<xsl:call-template name="input-field">
    		<xsl:with-param name="label">XSL_JURISDICTION_COMPANY</xsl:with-param>
    		<xsl:with-param name="name">customer_authorization</xsl:with-param> 
    		<xsl:with-param name="value"><xsl:value-of select="$override_company_abbv_name"/></xsl:with-param>
       		<xsl:with-param name="override-displaymode">view</xsl:with-param>
    	</xsl:call-template>
	</xsl:if>
	
	<!-- Entities -->
	  <xsl:choose> 
	  	<xsl:when test="$displaymode='edit'">
		  	<xsl:choose>
		  		<xsl:when test="$company_type = '03' and entities">
		  			<xsl:call-template name="entity-field">
		    		 <xsl:with-param name="button-type">system-entity</xsl:with-param>
		    		 <xsl:with-param name="entity-label">XSL_JURISDICTION_ENTITY</xsl:with-param>
		       		 <xsl:with-param name="required">Y</xsl:with-param>
		       		 <xsl:with-param name="keep-entity-product-button">*</xsl:with-param>
		       		 <xsl:with-param name="override_company_abbv_name" select="$override_company_abbv_name" />
		    		</xsl:call-template>
		  		</xsl:when>
		  	</xsl:choose>
	  	</xsl:when>
	  	<xsl:otherwise>
		  	<xsl:if test="$displaymode='view'">
			  	<xsl:choose>
			  		<xsl:when test="$company_type = '03' and entities">
			  			<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_JURISDICTION_ENTITY</xsl:with-param>
							<xsl:with-param name="name">entity_display</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="entity"/></xsl:with-param>
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
		 </xsl:if>
	  </xsl:otherwise>
   </xsl:choose>
   

  	<!-- Type -->
	<xsl:choose>
	  <xsl:when test= "$displaymode = 'edit'">
	  	<xsl:call-template name="select-field">
	     	<xsl:with-param name="label">XSL_JURISDICTION_TNX_TYPE_CODE</xsl:with-param>
	     	<xsl:with-param name="name">tnx_type_code</xsl:with-param>
	     	<xsl:with-param name="required">Y</xsl:with-param>
	     	<!-- <xsl:with-param name="value"><xsl:value-of select="$tnx_type_code_value"/></xsl:with-param>	      -->	
	     	<xsl:with-param name="options">
	     		<xsl:call-template name="type-options"/>
	    	</xsl:with-param>
	    </xsl:call-template>
	 </xsl:when>
	 <xsl:otherwise>
	  	<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_JURISDICTION_TNX_TYPE_CODE</xsl:with-param>
			<xsl:with-param name="name">tnx_type_code_display</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'C071', tnx_type_code)"/></xsl:with-param>
		</xsl:call-template>	 	 	
	</xsl:otherwise>
  </xsl:choose>
  
	<div id="productDiv">
	 <xsl:choose>
		<xsl:when test= "$displaymode = 'edit'">
			<xsl:variable name="code"><xsl:value-of select="product_code"/></xsl:variable>
			<xsl:call-template name="select-field">
		    	<xsl:with-param name="label">XSL_JURISDICTION_PRODUCT</xsl:with-param>
		     	<xsl:with-param name="name">product_code</xsl:with-param>	    
		     	<xsl:with-param name="required">Y</xsl:with-param>
		     	<xsl:with-param name="options"><xsl:call-template name="product_code_options"/></xsl:with-param>
		     </xsl:call-template>
		     <xsl:call-template name="hidden-field">
		    	<xsl:with-param name="name">product_code_hidden</xsl:with-param>	    
		     	<xsl:with-param name="value">
		     	<xsl:choose>
			     	<xsl:when test="(defaultresource:isSwift2019Enabled() = 'true') and $code = 'BG'">
			     	 	<xsl:value-of select="localization:getDecode($language, 'N001', 'IU' )"/>
			     	 </xsl:when>
			     	 <xsl:when test="(defaultresource:isSwift2019Enabled() = 'true') and $code = 'BR'">
			     	 	<xsl:value-of select="localization:getDecode($language, 'N001', 'RU' )"/>
			     	 </xsl:when>
			     	 <xsl:otherwise>
			     	 	<xsl:value-of select="localization:getDecode($language, 'N001', $code )"/>
			     	 </xsl:otherwise>
		     	</xsl:choose>
		     	</xsl:with-param>  
		     </xsl:call-template>
	    </xsl:when>
		<xsl:otherwise>
			<xsl:variable name="code"><xsl:value-of select="product_code"/></xsl:variable>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_JURISDICTION_PRODUCT</xsl:with-param>
					<xsl:with-param name="name">product_code_display</xsl:with-param>
					<xsl:with-param name="value">
					<xsl:choose>
				     	<xsl:when test="(defaultresource:isSwift2019Enabled() = 'true') and $code = 'BG'">
				     	 	<xsl:value-of select="localization:getDecode($language, 'N001', 'IU' )"/>
				     	 </xsl:when>
				     	  <xsl:when test="(defaultresource:isSwift2019Enabled() = 'true') and $code = 'BR'">
			     	 	<xsl:value-of select="localization:getDecode($language, 'N001', 'RU' )"/>
			     		 </xsl:when>
				     	 <xsl:otherwise>
				     	 	<xsl:value-of select="localization:getDecode($language, 'N001', $code )"/>
				     	 </xsl:otherwise>
		     		</xsl:choose>
		     	</xsl:with-param>  
				</xsl:call-template>
		</xsl:otherwise>
	 </xsl:choose>
	</div>
	<div id="subProductDiv">
	 <xsl:choose>
		<xsl:when test= "$displaymode = 'edit'">
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
	    </xsl:when>
		<xsl:otherwise>
			<xsl:variable name="sub_code"><xsl:value-of select="sub_product_code"/></xsl:variable>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_JURIDICTION_SUBPRODUCT_TYPE</xsl:with-param>
					<xsl:with-param name="name">sub_product_code_display</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N047', $sub_code )"/></xsl:with-param>
				</xsl:call-template>
		</xsl:otherwise>
	 </xsl:choose>
	 </div>
	 
	 <div id="productTypeDiv">
	 <xsl:choose>
		<xsl:when test= "$displaymode = 'edit'">
			<xsl:variable name="productTypeCode"><xsl:value-of select="product_type_code"/></xsl:variable>
			<xsl:call-template name="select-field">
		    	<xsl:with-param name="label">XSL_PRODUCTYPE_CODE_LABEL</xsl:with-param>
		     	<xsl:with-param name="name">product_type_code</xsl:with-param>
		     	<xsl:with-param name="required">N</xsl:with-param>
		     </xsl:call-template>
		     <xsl:call-template name="hidden-field">
		    	<xsl:with-param name="name">product_type_code_hidden</xsl:with-param>	    
		     	<xsl:with-param name="value">
		     	<xsl:choose>
					<xsl:when test="$productTypeCode != '' and (defaultresource:isSwift2019Enabled() = 'true')">
		     	 		<xsl:value-of select="localization:getCodeData($language,'*', product_code,'C082', $productTypeCode)"/>
		     		 </xsl:when>
			     	 <xsl:otherwise>
			     	 	<xsl:value-of select="localization:getCodeData($language,'*', product_code,'C011', $productTypeCode)"/>
			     	 </xsl:otherwise>
			     </xsl:choose>
		     	</xsl:with-param>  
		     </xsl:call-template>
	    </xsl:when>
		<xsl:otherwise>
			<xsl:variable name="productTypeCode"><xsl:value-of select="product_type_code"/></xsl:variable>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_PRODUCTYPE_CODE_LABEL</xsl:with-param>
					<xsl:with-param name="name">product_type_code_display</xsl:with-param>
					<xsl:with-param name="value">
					<xsl:choose>
						<xsl:when test="defaultresource:isSwift2019Enabled() = 'true'">
			     	 		<xsl:value-of select="localization:getCodeData($language,'*', product_code,'C082', $productTypeCode)"/>
			     		 </xsl:when>
				     	 <xsl:otherwise>
				     	 	<xsl:value-of select="localization:getCodeData($language,'*', product_code,'C011', $productTypeCode)"/>
				     	 </xsl:otherwise>
			       </xsl:choose>	
					</xsl:with-param>	
				</xsl:call-template>
		</xsl:otherwise>
	 </xsl:choose>
	</div>
	 
	 <!-- Tenor which is displayed and mandatory only when Product type is BG -->
	 <div id="tenorDiv">
	 <xsl:choose>
		<xsl:when test= "$displaymode = 'edit'">
			<xsl:variable name="tenor"><xsl:value-of select="tenor_type_code"/></xsl:variable>
			<xsl:call-template name="select-field">
		    	<xsl:with-param name="label">XSL_JURISDICTION_TENOR</xsl:with-param>
		     	<xsl:with-param name="name">tenor_type_code</xsl:with-param>
		     	<xsl:with-param name="required">N</xsl:with-param>
		   </xsl:call-template>
		     
		     <xsl:call-template name="hidden-field">
		    	<xsl:with-param name="name">tenor_type_code_hidden</xsl:with-param>	    
		     	<xsl:with-param name="value">
		     	 <xsl:if test="$tenor != ''">
		     	 <xsl:value-of select="localization:getCodeData($language,'*', product_code, 'C015', $tenor)"/> 
		     	 </xsl:if>
		     	</xsl:with-param>  
		     </xsl:call-template>
	    </xsl:when>
		<xsl:otherwise>
			<xsl:variable name="tenor"><xsl:value-of select="tenor_type_code"/></xsl:variable>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_JURISDICTION_TENOR</xsl:with-param>
					<xsl:with-param name="name">tenor_type_code_display</xsl:with-param>
					<xsl:with-param name="value">
					<xsl:value-of select="localization:getCodeData($language,'*', product_code, 'C015', $tenor)"/></xsl:with-param>		
				</xsl:call-template>
		</xsl:otherwise>
	 </xsl:choose>
	</div>
	 
	 
  <!-- Sub transaction type code which is displayed and mandatory only when Product type is BG/SI -->
  <div id="subTnxTypeDiv">
	 <xsl:choose>
		<xsl:when test= "$displaymode = 'edit'">
			<xsl:variable name="sub_tnx"><xsl:value-of select="sub_tnx_type_code"/></xsl:variable>
			<xsl:call-template name="select-field">
		    	<xsl:with-param name="label">XSL_AUTHORIZATION_SUB_TNX_TYPE_CODE</xsl:with-param>
		     	<xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>	    
		     	<xsl:with-param name="required">N</xsl:with-param>
		     </xsl:call-template>
		     <xsl:call-template name="hidden-field">
		    	<xsl:with-param name="name">sub_tnx_type_code_hidden</xsl:with-param>	    
		     	<xsl:with-param name="value">
		     	 <xsl:if test="$sub_tnx != ''">
		     	 	<xsl:value-of select="localization:getDecode($language, 'N003', $sub_tnx )"/>
		     	 </xsl:if>
		     	</xsl:with-param>  
		     </xsl:call-template>
	    </xsl:when>
		<xsl:otherwise>
			<xsl:if test="$company_type = '03'">
			<xsl:variable name="sub_tnx"><xsl:value-of select="sub_tnx_type_code"/></xsl:variable>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_AUTHORIZATION_SUB_TNX_TYPE_CODE</xsl:with-param>
					<xsl:with-param name="name">sub_tnx_type_code_display</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N003', $sub_tnx )"/></xsl:with-param>
				</xsl:call-template>
			</xsl:if>	
		</xsl:otherwise>
	 </xsl:choose>
	 </div>
	 
	  <div id="accDiv">
	  	<xsl:if test= "$displaymode = 'edit' and $company_type = '03'">
		  	<xsl:call-template name="input-field">
			  	<xsl:with-param name="label">XSL_JURISDICTION_ACCOUNT</xsl:with-param>
			  	<xsl:with-param name="name">account_no</xsl:with-param>
			  	<xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
			  	<xsl:with-param name="readonly">Y</xsl:with-param>
		  	</xsl:call-template>
		  	<xsl:call-template name="hidden-field">
			  	<xsl:with-param name="name">account_no_hidden</xsl:with-param>
			  	<xsl:with-param name="value"><xsl:value-of select="account_no"/></xsl:with-param>
		  	</xsl:call-template>
		    <xsl:call-template name="button-wrapper">		   	  
		      <xsl:with-param name="show-image">Y</xsl:with-param>
			  <xsl:with-param name="show-border">N</xsl:with-param>
			  <xsl:with-param name="id">account_img</xsl:with-param>
			  <xsl:with-param name="appendClass">inlineBlock inlineBlockNoLabel</xsl:with-param>
		    </xsl:call-template>
	    </xsl:if>
	  </div>
	  <xsl:if test= "$displaymode = 'view' and $company_type = '03'">
	 	  <xsl:call-template name="input-field">
		   	 <xsl:with-param name="label">XSL_JURISDICTION_ACCOUNT</xsl:with-param>
		     <xsl:with-param name="name">account_no</xsl:with-param>
		     <xsl:with-param name="value"><xsl:value-of select="account_no"></xsl:value-of></xsl:with-param>
		  </xsl:call-template>
	  </xsl:if>
	  
	  
	  
   	<!-- Limit Amount -->
   	<xsl:if test="$minAmountEnable = 'false'">
	   	<xsl:if test="not($displaymode = 'view' and product_code [.='SE'])">
			<div id="limit_amount">
				<xsl:call-template name="currency-field">
					<xsl:with-param name="label">XSL_JURISDICTION_LIMIT_AMOUNT</xsl:with-param>
					<xsl:with-param name="product-code">lmt</xsl:with-param>
					<xsl:with-param name="override-currency-value"><xsl:value-of select="iso_code"/></xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
			</div>
		</xsl:if>
	
		<script>
			dojo.ready(function(){
				misys._config = misys._config || {};
				dojo.mixin(misys._config, {
					lmt_amt : '<xsl:value-of select="lmt_amt"/>',
					company_type : '<xsl:value-of select="$company_type"/>'
				});
			});
		</script>
		
		
		
		<div id="limit_min_amount" hidden="true">
			<xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_JURISDICTION_MIN_LIMIT_AMOUNT</xsl:with-param>
				<xsl:with-param name="product-code">lmt</xsl:with-param>
				 <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
				<xsl:with-param name="override-currency-value"><xsl:value-of select="lmt_cur_code"/></xsl:with-param>
				<xsl:with-param name="show-currency">N</xsl:with-param>
				<xsl:with-param name="override-amt-name">min_lmt_amt</xsl:with-param>
				<xsl:with-param name="override-amt-value"><xsl:value-of select="min_lmt_amt"/></xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
		</div>
		<script>
	     dojo.ready(function(){
	     	misys._config = misys._config || {};
	     	dojo.mixin(misys._config, {
	     		min_lmt_amt : '<xsl:value-of select="min_lmt_amt"/>',
	     		company_type : '<xsl:value-of select="$company_type"/>'
	     	});
	     });
	    </script>
	</xsl:if>
	
	
	<xsl:if test="$minAmountEnable = 'true' and security:isBank($rundata) and $option='AUTHORISATION_MAINTENANCE_MC'">
	   	<xsl:if test="not($displaymode = 'view' and product_code [.='SE'])">
			<div id="limit_amount">
				<xsl:call-template name="currency-field">
					<xsl:with-param name="label">XSL_JURISDICTION_LIMIT_AMOUNT</xsl:with-param>
					<xsl:with-param name="product-code">lmt</xsl:with-param>
					<xsl:with-param name="override-currency-value"><xsl:value-of select="iso_code"/></xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
			</div>
		</xsl:if>
	
		<script>
			dojo.ready(function(){
				misys._config = misys._config || {};
				dojo.mixin(misys._config, {
					lmt_amt : '<xsl:value-of select="lmt_amt"/>',
					company_type : '<xsl:value-of select="$company_type"/>'
				});
			});
		</script>
	</xsl:if>
	
	
	<xsl:if test="$minAmountEnable = 'true' and ($option='CUSTOMER_AUTHORISATION_MAINTENANCE_MC' or security:isCustomer($rundata))">
		<!-- Currency for Min Amount and Max Amount -->
	   	<xsl:if test="$displaymode = 'edit' and not(product_code [.='SE'])">
			<div id="currency">
				<xsl:call-template name="currency-field">
					<xsl:with-param name="label">XSL_JURISDICTION_LIMIT_CURRENCY</xsl:with-param>
					<xsl:with-param name="product-code">lmt</xsl:with-param>
					<xsl:with-param name="override-currency-displaymode">edit</xsl:with-param>
					<xsl:with-param name="override-currency-value"><xsl:value-of select="iso_code"/></xsl:with-param>
					<xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
					<xsl:with-param name="override-amt-value"></xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
				</xsl:call-template>
			</div>
		</xsl:if>
		
			<xsl:if test="$displaymode = 'view' and not(product_code [.='SE'])">
			<div id="currency">
				<xsl:call-template name="currency-field">
					<xsl:with-param name="label">XSL_JURISDICTION_LIMIT_CURRENCY</xsl:with-param>
					<xsl:with-param name="product-code">lmt</xsl:with-param>
					<xsl:with-param name="override-currency-displaymode">edit</xsl:with-param>
					<xsl:with-param name="override-currency-value"><xsl:value-of select="iso_code"/></xsl:with-param>
					<xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
					<xsl:with-param name="override-amt-value"></xsl:with-param>
					<xsl:with-param name="currency-readonly">Y</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
				</xsl:call-template>
			</div>
		</xsl:if>
		
		
		<!-- Min Limit Amount -->
   		<xsl:if test="not($displaymode = 'view' and product_code [.='SE'])">
   		<div id="limit_min_amount">
			<xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_JURISDICTION_MIN_LIMIT_AMOUNT</xsl:with-param>
				<xsl:with-param name="product-code">lmt</xsl:with-param>
				 <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
				<xsl:with-param name="override-currency-value"><xsl:value-of select="lmt_cur_code"/></xsl:with-param>
				<xsl:with-param name="show-currency">N</xsl:with-param>
				<xsl:with-param name="override-amt-name">min_lmt_amt</xsl:with-param>
				<xsl:with-param name="override-amt-value"><xsl:value-of select="min_lmt_amt"/></xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
		</div>
		</xsl:if>
		<script>
	     dojo.ready(function(){
	     	misys._config = misys._config || {};
	     	dojo.mixin(misys._config, {
	     		min_lmt_amt : '<xsl:value-of select="min_lmt_amt"/>',
	     		company_type : '<xsl:value-of select="$company_type"/>'
	     	});
	     });
	    </script>	
		    
		    <!-- Max Limit Amount -->
	   	
			<xsl:if test="not($displaymode = 'view' and product_code [.='SE'])">
			<div id="limit_max_amount">
				<xsl:call-template name="currency-field">
					<xsl:with-param name="label">XSL_JURISDICTION_MAX_LIMIT_AMOUNT</xsl:with-param>
					<xsl:with-param name="product-code">lmt</xsl:with-param>
					 <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
					<xsl:with-param name="override-currency-value"><xsl:value-of select="lmt_cur_code"/></xsl:with-param>
					<xsl:with-param name="show-currency">N</xsl:with-param>
					<xsl:with-param name="override-amt-name">lmt_amt</xsl:with-param>
					<xsl:with-param name="override-amt-value"><xsl:value-of select="lmt_amt"/></xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
			</div>
			</xsl:if>
			<script>
		     dojo.ready(function(){
		     	misys._config = misys._config || {};
		     	dojo.mixin(misys._config, {
		     		lmt_amt : '<xsl:value-of select="lmt_amt"/>',
		     		company_type : '<xsl:value-of select="$company_type"/>'
		     	});
		     });
		    </script>
	   	
   	</xsl:if>
	 
    <xsl:if test = "$company_type = '03'">
	  <xsl:choose>
	   <xsl:when test= "$displaymode = 'edit'">
	    <!-- Verify -->
	     <xsl:call-template name="multichoice-field">
		    	<xsl:with-param name="label">XSL_JURISDICTION_VERIFY</xsl:with-param>
		    	<xsl:with-param name="name">verify</xsl:with-param>
		    	<xsl:with-param name="type">checkbox</xsl:with-param>
		    	<xsl:with-param name="checked">
		    		<xsl:choose>
		    			<xsl:when test="verify[.='']">Y</xsl:when>
		    			<xsl:otherwise><xsl:value-of select="verify"/> </xsl:otherwise>
		    		</xsl:choose>
		    	</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
		  <xsl:choose>
			<xsl:when test="verify[. = 'N']">
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_JURISDICTION_VERIFY_MC</xsl:with-param>
					<xsl:with-param name="name">verify_display</xsl:with-param>				
					<xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'N034_NO')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_JURISDICTION_VERIFY_MC</xsl:with-param>
					<xsl:with-param name="name">verify_display</xsl:with-param>				
					<xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'N034_YES')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		 </xsl:choose>
	   </xsl:otherwise>
	</xsl:choose>
	</xsl:if>
	
	<xsl:if test="$company_type = '03' ">
	<xsl:choose>
	   <xsl:when test= "$displaymode = 'edit'">
	    <!-- Send -->
	     <xsl:call-template name="multichoice-field">
		    	<xsl:with-param name="label">XSL_JURISDICTION_SEND</xsl:with-param>
		    	<xsl:with-param name="name">send</xsl:with-param>
		    	<xsl:with-param name="type">checkbox</xsl:with-param>
		    	<xsl:with-param name="checked">
		    		<xsl:choose>
		    			<xsl:when test="send[.='']">Y</xsl:when>
		    			<xsl:otherwise><xsl:value-of select="send"/> </xsl:otherwise>
		    		</xsl:choose>
		    	</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
		  <xsl:choose>
			<xsl:when test="send[. = 'N']">
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_JURISDICTION_SEND_MC</xsl:with-param>
					<xsl:with-param name="name">send_display</xsl:with-param>				
					<xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'N034_NO')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_JURISDICTION_SEND_MC</xsl:with-param>
					<xsl:with-param name="name">send_display</xsl:with-param>				
					<xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'N034_YES')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		 </xsl:choose>
	   </xsl:otherwise>
	</xsl:choose>
	</xsl:if>
	<xsl:choose>
	   <xsl:when test= "$displaymode = 'edit'">
	    <!-- Sequential -->
	     <xsl:call-template name="multichoice-field">
		    	<xsl:with-param name="label">XSL_JURISDICTION_SEQUENTIAL</xsl:with-param>
		    	<xsl:with-param name="name">sequential</xsl:with-param>
		    	<xsl:with-param name="type">checkbox</xsl:with-param>
		    	<xsl:with-param name="checked">
		    		<xsl:choose>
		    			<xsl:when test="sequential[.='']">Y</xsl:when>
		    			<xsl:otherwise><xsl:value-of select="sequential"/> </xsl:otherwise>
		    		</xsl:choose>
		    	</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
		  <xsl:choose>
			<xsl:when test="sequential[. = 'N']">
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_JURISDICTION_SEQUENTIAL_MC</xsl:with-param>
					<xsl:with-param name="name">sequential_display</xsl:with-param>				
					<xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'N034_NO')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_JURISDICTION_SEQUENTIAL_MC</xsl:with-param>
					<xsl:with-param name="name">sequential_display</xsl:with-param>				
					<xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'N034_YES')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		 </xsl:choose>
	   </xsl:otherwise>
	</xsl:choose>
  </xsl:with-param>
  </xsl:call-template>
  
  
  	<!--          -->
   	<!--  roles  -->
   	<!--          -->
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="localized">N</xsl:with-param>
		<xsl:with-param name="legend"><xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_LEVELS')"/></xsl:with-param>
		<xsl:with-param name="content">
			<xsl:call-template name="roles-table"/>		
		</xsl:with-param>
	</xsl:call-template>
 
 	
  </xsl:template>
 <!-- 
  Realform
  -->
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
       <xsl:with-param name="value"><xsl:value-of select="$operation"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="$option"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:if test = "$user_company_type != '03'">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">company</xsl:with-param>
       <xsl:with-param name="value">
        <xsl:choose>
         <xsl:when test="$option='BANK_AUTHORISATION_MAINTENANCE_MC'"><xsl:value-of select="static_bank/abbv_name"/></xsl:when>
         <xsl:when test="$option='CUSTOMER_AUTHORISATION_MAINTENANCE_MC'"><xsl:value-of select="$override_company_abbv_name"/></xsl:when>
        </xsl:choose>
       </xsl:with-param>
      </xsl:call-template>
      </xsl:if>
      <xsl:if test="tnx_id[.!='']">
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">tnxid</xsl:with-param>
        <xsl:with-param name="value"><xsl:value-of select="tnx_id"/></xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">mode</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$draftMode"/></xsl:with-param>
      </xsl:call-template>
      <xsl:if test="matrix_id[.!='']">
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">featureid</xsl:with-param>
        <xsl:with-param name="value"><xsl:value-of select="matrix_id"/></xsl:with-param>
       </xsl:call-template>
      </xsl:if>     
     <!-- Security token -->
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">token</xsl:with-param>
		<xsl:with-param name="value">
			<xsl:value-of select="$token" />
		</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">processdttm</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$processdttm"/></xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">isSwift2019Enabled</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="defaultresource:isSwift2019Enabled()"/></xsl:with-param>
     </xsl:call-template>	
     <xsl:call-template name="reauth_params"/>
     <xsl:call-template name="e2ee_transaction"/>
     </div>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:if>
  </xsl:template>
  
  <!-- ******************************************************************** -->
  <!-- ************************  Type options ***************************** -->
  <!-- ******************************************************************** -->
  <xsl:template name="type-options">
     
     <xsl:for-each select="/matrix_record/tnx_type_codes/tnx_type_code_details">
		<xsl:variable name="tnxTypeCode" select="tnx_type_code_val" />
			<option value="{$tnxTypeCode}">
				<xsl:value-of select="tnx_type_code_desc"/>
			</option>
	</xsl:for-each>
     
 </xsl:template>
  
	<!--  Business Area options -->
	<xsl:template name="product_code_options">
		<xsl:for-each select="/matrix_record/avail_products/products/product">
			<xsl:variable name="productName" select="product_code" />
			<xsl:choose>
				<xsl:when test="$productName='ALL'">
					<option value="*">
						<xsl:value-of select="localization:getDecode($language, 'N001', '*')"/>
					</option>
				</xsl:when>
				<xsl:when test="(defaultresource:isSwift2019Enabled() = 'true') and $productName = 'BG'">
					<option value="{$productName}">
						<xsl:value-of select="localization:getDecode($language, 'N001', 'IU')"/>
					</option>
				</xsl:when>
				<xsl:when test="(defaultresource:isSwift2019Enabled() = 'true') and $productName = 'BR'">
					<option value="{$productName}">
						<xsl:value-of select="localization:getDecode($language, 'N001', 'RU')"/>
					</option>
				</xsl:when>				
				<xsl:otherwise>
						<option value="{$productName}">
							<xsl:value-of select="localization:getDecode($language, 'N001', $productName)"/>
						</option>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>

  <xsl:template name="roles-table">
  	<xsl:param name="existing-roles" select="level"/>
	<xsl:call-template name="attachments-table">
		<xsl:with-param name="max-attachments">-1</xsl:with-param>
		<xsl:with-param name="optionvalue"><xsl:value-of select="$option"/></xsl:with-param>
		<xsl:with-param name="existing-attachments" select="$existing-roles"/>
		<xsl:with-param name="table-thead">
			<th class="ctr-acc-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LEVELS')"/></th>
		</xsl:with-param>
		<xsl:with-param name="table-row-type">role</xsl:with-param>
		<xsl:with-param name="empty-table-notice">XSL_JURISDICTION_NO_LEVEL_SETUP</xsl:with-param>
		<xsl:with-param name="delete-attachments-notice">XSL_JURISDICTION_LEVEL_NOTICE</xsl:with-param>
	</xsl:call-template>
	
	<!--
     Edit Fields 
     -->
	<xsl:if test="$displaymode='edit'">
     	<script>
     	 dojo.ready(function(){
			 misys._config = misys._config || {};
			 dojo.mixin(misys._config,  {
				roleAttached : <xsl:value-of select="count($existing-roles)"/>
		 	});
		 });
	    </script>
		<button dojoType="dijit.form.Button" type="button">
			<xsl:attribute name="id">openRoleDialog</xsl:attribute>
			<xsl:attribute name="onclick">misys.showTransactionAddonsDialog('role');</xsl:attribute>
			<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_ADD_LEVEL')" />
		</button>
		
	<!-- Holder div for hidden fields, created when an item is added -->
     <div id="role_fields"></div>
     
     <xsl:call-template name="dialog">
  	  <xsl:with-param name="id">roleDialog</xsl:with-param>
  	  <xsl:with-param name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LEVELS')"/></xsl:with-param>
  	  <xsl:with-param name="content">
  	   <div class="required">
        <xsl:call-template name="select-field">
			<xsl:with-param name="label">XSL_JURISDICTION_LEVEL</xsl:with-param>
			<xsl:with-param name="required">Y</xsl:with-param>
			<xsl:with-param name="name"></xsl:with-param>
			<xsl:with-param name="id">roles_details_role_name_nosend</xsl:with-param>
			<xsl:with-param name="options">
		      <xsl:call-template name="role-options">
		      </xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
		 <xsl:with-param name="name"></xsl:with-param>
	     <xsl:with-param name="id">roles_level_id_role_name_nosend</xsl:with-param>
	     <xsl:with-param name="value"></xsl:with-param>
	    </xsl:call-template>
		<xsl:call-template name="hidden-field">
		 <xsl:with-param name="name"></xsl:with-param>
	     <xsl:with-param name="id">roles_order_number_role_name_nosend</xsl:with-param>
	     <xsl:with-param name="value"></xsl:with-param>
	    </xsl:call-template>
		</div>
  	  </xsl:with-param>
  	  <xsl:with-param name="buttons">
  	   <xsl:call-template name="row-wrapper">
        <xsl:with-param name="id">addRoleButton</xsl:with-param>
        <xsl:with-param name="content">
         <button dojoType="dijit.form.Button" id="addRoleButton" type="button">
          <xsl:attribute name="onclick">misys.addTransactionAddon('role')</xsl:attribute>
          <xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SAVE')"/>
         </button>
         <button dojoType="dijit.form.Button" id="cancelRoleButton" type="button">
          <xsl:attribute name="onclick">misys.hideTransactionAddonsDialog('role');</xsl:attribute>
          <xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/>
         </button>
        </xsl:with-param>
       </xsl:call-template>
  	  </xsl:with-param>
	 </xsl:call-template>
	</xsl:if>
</xsl:template>


  <!-- ******************************************************************** -->
  <!-- ***********************  Product options *************************** -->
  <!-- ******************************************************************** -->
  <xsl:template name="product-options">
    <xsl:if test="/matrix_record/avail_products//product_code[.!='']">
	    <option>
	    	<xsl:attribute name="value">*</xsl:attribute>*
	    	<xsl:if test="/matrix_records/product_code='*'"><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
	    </option>
	</xsl:if>
    <xsl:for-each select="/matrix_record/avail_products//product_code">
    	<option value="{.}">
			<xsl:value-of select="localization:getDecode($language, 'N001', .)"/>
			<xsl:if test="/matrix_record/product_code=."><xsl:attribute name="selected">selected</xsl:attribute></xsl:if>
    	</option>
    </xsl:for-each>	 
  </xsl:template>
  
  <!-- ******************************************************************** -->
  <!-- ***********************  role options ***************************** -->
  <!-- ******************************************************************** -->
  <xsl:template name="role-options">
   <!-- xsl:param name="current"/-->	
   <xsl:variable name="dest">
	<xsl:if test="$company_type='01'">01</xsl:if>
	<xsl:if test="$company_type='02'">02</xsl:if>
	<xsl:if test="$company_type='03' or $company_type='06'">03</xsl:if>
   </xsl:variable>
   
   <!-- Other options (only authorisation ones, ie roletype=02) -->
   <xsl:apply-templates select="//avail_roles/role[roletype='02' and (roledest=$dest or roledest='*')]">
   <xsl:sort select="role_description" />
   </xsl:apply-templates>
   </xsl:template>
  
  <!-- Template for Bank Description (whether already given or still available) in Input Mode -->
  <xsl:template match="//avail_roles/role">
	<option>
	 <xsl:attribute name="value"><xsl:value-of select="id"/></xsl:attribute>
	 <xsl:value-of select="role_description"/>
	</option>
  </xsl:template>
</xsl:stylesheet> 