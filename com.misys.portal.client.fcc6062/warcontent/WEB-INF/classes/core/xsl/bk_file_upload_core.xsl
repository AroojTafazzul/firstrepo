<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Secure Email (SE) Form, Customer Side.
 
Copyright (c) 2000-2010 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.1
date:      13/01/12
author:    Pavan Kumar
email:     pavankumar.c@misys.com
##########################################################
-->


<xsl:stylesheet 
  version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
  exclude-result-prefixes="localization">
  
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  <xsl:param name="option"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">SE</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/BulkScreen</xsl:param>
  <!-- Local variables. -->
  <xsl:param name="show-eucp">N</xsl:param>
  <xsl:param name="isMultiBank">N</xsl:param>
        
  <!-- Global Imports. -->
  
  <xsl:include href="../../core/xsl/common/bk_upl_trade_common.xsl" />      
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="se_tnx_record"/>
  </xsl:template>
  
  <!-- 
   SE TNX FORM TEMPLATE.
   
  -->
  <xsl:template match="se_tnx_record"> 
  		<script>
			dojo.ready(function(){
			
         	  	misys._config = (misys._config) || {};	

	            misys._config.isMultiBank =<xsl:choose>
									 			<xsl:when test="$isMultiBank='Y'">true</xsl:when>
									 			<xsl:otherwise>false</xsl:otherwise>
									 		</xsl:choose>;
	            <xsl:if test="$isMultiBank='Y'">
	            dojo.mixin(misys._config, {
					entityBanksCollection : {
			   			<xsl:if test="count(/se_tnx_record/avail_main_banks/entities_banks_list/entity_banks/mb_entity) > 0" >
			        		<xsl:for-each select="/se_tnx_record/avail_main_banks/entities_banks_list/entity_banks/mb_entity" >
			        			<xsl:variable name="mb_entity" select="self::node()/text()" />
			  						<xsl:value-of select="."/>: [
			   						<xsl:for-each select="/se_tnx_record/avail_main_banks/entities_banks_list/entity_banks[mb_entity=$mb_entity]/customer_bank" >
			   							{ value:"<xsl:value-of select="."/>",
					         				name:"<xsl:value-of select="."/>"},
			   						</xsl:for-each>
			   						]<xsl:if test="not(position()=last())">,</xsl:if>
			         		</xsl:for-each>
			       		</xsl:if>
					},
					<!-- Banks for without entity customers.  -->
					wildcardLinkedBanksCollection : {
			   			<xsl:if test="count(/se_tnx_record/avail_main_banks/bank/abbv_name) > 0" >
			  						"customerBanksForWithoutEntity" : [
				        			<xsl:for-each select="/se_tnx_record/avail_main_banks/bank/abbv_name" >
			   							{ value:"<xsl:value-of select="."/>",
					         				name:"<xsl:value-of select="."/>"},
				         			</xsl:for-each>
			   						]
			       		</xsl:if>
					},
					
					customerBankDetails : {
			       		<xsl:if test="count(/se_tnx_record/customer_banks_details/bank_abbv_desc/bank_abbv_name) > 0" >
			        		<xsl:for-each select="/se_tnx_record/customer_banks_details/bank_abbv_desc/bank_abbv_name" >
			        			<xsl:variable name="bank_abbv_name" select="self::node()/text()" />
			  						<xsl:value-of select="."/>: [
			   						<xsl:for-each select="/se_tnx_record/customer_banks_details/bank_abbv_desc[bank_abbv_name=$bank_abbv_name]/bank_desc" >
			   							{ value:"<xsl:value-of select="."/>",
					         				name:"<xsl:value-of select="."/>"},
			   						</xsl:for-each>
			   						]<xsl:if test="not(position()=last())">,</xsl:if>
			         		</xsl:for-each>
			       		</xsl:if>
					}
				});
				</xsl:if>
			});
	  	</script>
   <!-- Preloader -->
   <xsl:call-template name="loading-message"/>
   <div>
	<xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
   	  <xsl:call-template name="menu">
     	<xsl:with-param name="show-template">N</xsl:with-param>
     	<xsl:with-param name="show-submit">N</xsl:with-param>
     	<xsl:with-param name="show-save">N</xsl:with-param>
     	<xsl:with-param name="show-upload">Y</xsl:with-param>
      </xsl:call-template>
      <xsl:apply-templates select="cross_references" mode="hidden_form"/>
      <xsl:call-template name="hidden-fields"/>
      <xsl:call-template name="general-details" />
      <!--<xsl:call-template name="upload-bank-details" />      
     --></xsl:with-param>
    </xsl:call-template>      
   	<xsl:call-template name="attachments-file-dojo"> 
   	  <xsl:with-param name="attachment_type">BULK_FILE_UPLOAD</xsl:with-param>
   	  <xsl:with-param name="legend">XSL_HEADER_BULK_FILE_UPLOAD</xsl:with-param>
   	  <xsl:with-param name="max-files">1</xsl:with-param>
   	</xsl:call-template>
    <!-- The form that is submitted -->
    <xsl:call-template name="realform"/>
    <!-- Display common menu, this time outside the form -->
    <xsl:call-template name="menu">
     <xsl:with-param name="show-template">N</xsl:with-param>
     <xsl:with-param name="show-submit">N</xsl:with-param>
     <xsl:with-param name="show-save">N</xsl:with-param>
     <xsl:with-param name="show-upload">Y</xsl:with-param>
     <xsl:with-param name="second-menu">Y</xsl:with-param>
    </xsl:call-template>
   </div> 
   <!-- Javascript and Dojo imports  -->
   <xsl:call-template name="js-imports"/>
  </xsl:template>

  <!-- Additional JS imports for this form are -->
  <!-- added here. -->
  <xsl:template name="js-imports">
   <xsl:call-template name="common-js-imports">
    <xsl:with-param name="binding">misys.binding.core.bk_file_upload</xsl:with-param>   
    <xsl:with-param name="override-help-access-key">BK_04</xsl:with-param>
   </xsl:call-template>
  </xsl:template>
 
  <!-- Additional hidden fields for this form are  -->
  <!-- added here. -->
  <xsl:template name="hidden-fields">
   <div class="widgetContainer">
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">brch_code</xsl:with-param>
     <xsl:with-param name="value" select="brch_code"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">company_id</xsl:with-param>
     <xsl:with-param name="value" select="company_id"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">company_name</xsl:with-param>
     <xsl:with-param name="value" select="company_name"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">tnx_id</xsl:with-param>
     <xsl:with-param name="value" select="tnx_id"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">old_ctl_dttm</xsl:with-param>
     <xsl:with-param name="value" select="//ctl_dttm"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">old_inp_dttm</xsl:with-param>
     <xsl:with-param name="value" select="inp_dttm"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">prod_stat_code</xsl:with-param>
     <xsl:with-param name="value" select="prod_stat_code"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">token</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">date_time</xsl:with-param>
   </xsl:call-template>    
   <xsl:call-template name="hidden-field">
	 <xsl:with-param name="name">issuing_bank_name</xsl:with-param>
	 <xsl:with-param name="value"><xsl:value-of select="issuing_bank/name"/></xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
	  <xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
	  <xsl:with-param name="value"><xsl:value-of select="issuing_bank/abbv_name"/></xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
	  <xsl:with-param name="name">issuing_bank_iso_code</xsl:with-param>
	  <xsl:with-param name="value"><xsl:value-of select="issuing_bank/iso_code"/></xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="hidden-field">
	  <xsl:with-param name="name">applicant_reference</xsl:with-param>
	</xsl:call-template>
   </div>
  </xsl:template>
  <!--
   General Details Fieldset. 
   -->
  <xsl:template name="general-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
         <xsl:call-template name="bulk-product-collections"/>		  
      <xsl:call-template name="file-upload-general-details"/>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  
  	<xsl:template name="bulk-product-collections">
		<script>
			dojo.ready(function(){
			dojo.require("dojox.collections.ArrayList");
			misys._config = misys._config || {};
			dojo.mixin(misys._config, {
					childSubProductsCollection : new Array(),
					childSubProductsCollectionPayroll : new Array(),
					flexiSubProductsCollection:new Array()
	       		});
	       	<!-- 	<xsl:if test="format='STANDARD'"> -->
	       		<!-- Build the list of File types available each of the BK types -->  
	       	<xsl:for-each select="avail_products/product">
       		    <xsl:variable name="customerBank" select="configured_customer_bank"/>			       		
	       		<xsl:for-each select="bktype">
					<xsl:variable name="bkType" select="."/>
					<xsl:choose>
						<xsl:when test="$bkType/code[.='PAYRL']">
						    misys._config.childSubProductsCollectionPayroll['<xsl:value-of select="$customerBank"/>'] = misys._config.childSubProductsCollectionPayroll['<xsl:value-of select="$customerBank"/>'] || [];
							misys._config.childSubProductsCollectionPayroll['<xsl:value-of select="$customerBank"/>']['<xsl:value-of select="$bkType/code"/>'] = misys._config.childSubProductsCollectionPayroll['<xsl:value-of select="$customerBank"/>']['<xsl:value-of select="$bkType/code"/>'] || [];
							<xsl:for-each select="$bkType/payroll_type">
								<xsl:variable name="payrollType" select="."/>
								misys._config.childSubProductsCollectionPayroll['<xsl:value-of select="$customerBank"/>']['<xsl:value-of select="$bkType/code"/>']['<xsl:value-of select="$payrollType/code"/>'] = misys._config.childSubProductsCollectionPayroll['<xsl:value-of select="$customerBank"/>']['<xsl:value-of select="$bkType/code"/>']['<xsl:value-of select="$payrollType/code"/>'] || [];
								<xsl:for-each select="$payrollType/entity">
									 misys._config.childSubProductsCollectionPayroll['<xsl:value-of select="$customerBank"/>']['<xsl:value-of select="$bkType/code"/>']['<xsl:value-of select="$payrollType/code"/>']['<xsl:value-of select="."/>'] = new Array(<xsl:value-of select='count($bkType/payroll_type)'/>);
								</xsl:for-each>
								misys._config.childSubProductsCollectionPayroll['<xsl:value-of select="$customerBank"/>']['<xsl:value-of select="$bkType/code"/>']['<xsl:value-of select="$payrollType/code"/>']['<xsl:value-of select="$payrollType/entity"/>'] = [
								<xsl:for-each select="$payrollType/bk_sub_product_code">
								    { 
		   								value:"<xsl:value-of select="./file_type"/>",name:"<xsl:value-of select="./file_type"/>",
   					                    accountFlag:"<xsl:value-of select="./account_flag"/>",valueDateFlag:"<xsl:value-of select="./value_date_flag"/>",
   					                    formatName:"<xsl:value-of select="./format_name"/>",mapCode:"<xsl:value-of select="./map_code"/>",
   					                    formatType:"<xsl:value-of select="./format_type"/>",ammendable:"<xsl:value-of  select="./amendable"/>",
   					                    fileEncrypted:"<xsl:value-of select="./file_encrypted"/>",overrideDuplicateReference:"<xsl:value-of select="./override_duplicate_reference"/>",
   					                    payRollType:"<xsl:value-of select="./payroll_type"/>",productGroup:"<xsl:value-of select="./product_group"/>",productType:"<xsl:value-of select="./product_type"/>",
   					                    fileTypePermissoin:"<xsl:value-of select="./file_type_permission"/>"
		   							}
		   							<xsl:if test="not(position()=last())">,</xsl:if>
								</xsl:for-each>
								];
							</xsl:for-each>
						</xsl:when>
						<xsl:otherwise>
								misys._config.childSubProductsCollection['<xsl:value-of select="$customerBank"/>'] = misys._config.childSubProductsCollection['<xsl:value-of select="$customerBank"/>'] || []						
								misys._config.childSubProductsCollection['<xsl:value-of select="$customerBank"/>']['<xsl:value-of select="$bkType/code"/>'] = misys._config.childSubProductsCollection['<xsl:value-of select="$customerBank"/>']['<xsl:value-of select="$bkType/code"/>'] || []
								<xsl:for-each select="$bkType/entity">
									 misys._config.childSubProductsCollection['<xsl:value-of select="$customerBank"/>']['<xsl:value-of select="$bkType/code"/>']['<xsl:value-of select="."/>'] = new Array(<xsl:value-of select='count($bkType/bk_sub_product_code)'/>);
								</xsl:for-each>
								misys._config.childSubProductsCollection['<xsl:value-of select="$customerBank"/>']['<xsl:value-of select="$bkType/code"/>']['<xsl:value-of select="$bkType/entity"/>'] = [
								<xsl:for-each select="$bkType/bk_sub_product_code">
								    { 
								        value:"<xsl:value-of select="./file_type"/>",name:"<xsl:value-of select="./file_type"/>",
   					                    accountFlag:"<xsl:value-of select="./account_flag"/>",valueDateFlag:"<xsl:value-of select="./value_date_flag"/>",
   					                    formatName:"<xsl:value-of select="./format_name"/>",mapCode:"<xsl:value-of select="./map_code"/>",
   					                    formatType:"<xsl:value-of select="./format_type"/>",ammendable:"<xsl:value-of  select="./amendable"/>",
   					                    fileEncrypted:"<xsl:value-of select="./file_encrypted"/>",overrideDuplicateReference:"<xsl:value-of select="./override_duplicate_reference"/>",
   					                    payRollType:"<xsl:value-of select="./payroll_type"/>",productGroup:"<xsl:value-of select="./product_group"/>",productType:"<xsl:value-of select="./product_type"/>",
   					                    fileTypePermissoin:"<xsl:value-of select="./file_type_permission"/>"
		   							}
		   							<xsl:if test="not(position()=last())">,</xsl:if>
								</xsl:for-each>
								];
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
			</xsl:for-each>	
				
				
				<!-- Build list of bulk types for each of the entity -->
				function isBkTypePresent(bkcollection, bktype)
				{
					for (var i=0; i &lt; bkcollection.length; i++) {
						
						var obj = bkcollection[i];
						if(obj.value === bktype)
							{
							return true;
							}
					}
					return false;
				};
				misys._config.bkTypeCollection = [];
			<xsl:for-each select="avail_products/product">
       		<xsl:variable name="customerBank" select="configured_customer_bank"/>		
				<xsl:for-each select="bktype/payroll_type">
				<!-- Entities in case of payroll are at payroll types,as payroll types are different for pay roll
					type to check payroll type permission iterate on payroll type and build unique list of bk type
					payroll  for each entity -->
				 <xsl:variable name="replaceEntity">
				 	<xsl:call-template name="string-replace-all">
						<xsl:with-param name="text" select="entity" />
						<xsl:with-param name="replace" select="' '" />
						<xsl:with-param name="by" select="'_'" />
					</xsl:call-template>
				 </xsl:variable>
							var object = {
											value:"<xsl:value-of select="./../code"/>",name:"<xsl:value-of select="./../description"/>"
										 };
							var bkType = '<xsl:value-of select="./../code"/>'.toString();
							misys._config.bkTypeCollection['<xsl:value-of select="$customerBank"/>'] = misys._config.bkTypeCollection['<xsl:value-of select="$customerBank"/>'] || [];							
							misys._config.bkTypeCollection['<xsl:value-of select="$customerBank"/>']['<xsl:value-of select="entity"/>'] = misys._config.bkTypeCollection['<xsl:value-of select="$customerBank"/>']['<xsl:value-of select="entity"/>'] || [];
 							misys._config.bkTypeCollectionTracker_entity = misys._config.bkTypeCollectionTracker_entity || new dojox.collections.ArrayList();
						 	if(!isBkTypePresent(misys._config.bkTypeCollection['<xsl:value-of select="$customerBank"/>']['<xsl:value-of select="entity"/>'],bkType))
						  	{	
								misys._config.bkTypeCollection['<xsl:value-of select="$customerBank"/>']['<xsl:value-of select="entity"/>'].push(
		   								object
		   							);
		   					}
							misys._config.bkTypeCollectionTracker_entity.add(bkType);
					
				</xsl:for-each>
				</xsl:for-each>
			<xsl:for-each select="avail_products/product">
	       		<xsl:variable name="customerBank" select="configured_customer_bank"/>
				<xsl:for-each select="bktype[.!='PAYRL']">
					
						misys._config.bkTypeCollection['<xsl:value-of select="$customerBank"/>'] = misys._config.bkTypeCollection['<xsl:value-of select="$customerBank"/>'] || [];					
						misys._config.bkTypeCollection['<xsl:value-of select="$customerBank"/>']['<xsl:value-of select="entity"/>'] =misys._config.bkTypeCollection['<xsl:value-of select="$customerBank"/>']['<xsl:value-of select="entity"/>'] || [];
						misys._config.bkTypeCollection['<xsl:value-of select="$customerBank"/>']['<xsl:value-of select="entity"/>'].push(
						    { 
   								value:"<xsl:value-of select="code"/>",name:"<xsl:value-of select="description"/>"
   							}
						);
					
				</xsl:for-each>
			</xsl:for-each>
				<!--  Build list of pay available roll types for each of the entities -->
				misys._config.payrollTypeCollection = [];
				<xsl:for-each select="avail_products/product">
       		<xsl:variable name="customerBank" select="configured_customer_bank"/>			
				<xsl:for-each select="bktype/payroll_type">
						misys._config.payrollTypeCollection['<xsl:value-of select="$customerBank"/>'] = misys._config.payrollTypeCollection['<xsl:value-of select="$customerBank"/>'] || [];				
						misys._config.payrollTypeCollection['<xsl:value-of select="$customerBank"/>']['<xsl:value-of select="entity"/>'] = misys._config.payrollTypeCollection['<xsl:value-of select="$customerBank"/>']['<xsl:value-of select="entity"/>'] || [];
						misys._config.payrollTypeCollection['<xsl:value-of select="$customerBank"/>']['<xsl:value-of select="entity"/>'].push(
						    { 
   								value:"<xsl:value-of select="code"/>",name:"<xsl:value-of select="description"/>"
   							}
						);
				</xsl:for-each>
				</xsl:for-each>
			});
		</script>  		
  	</xsl:template>
  	<xsl:template name="string-replace-all">
		<xsl:param name="text" />
		<xsl:param name="replace" />
		<xsl:param name="by" />
		<xsl:choose>
			<xsl:when test="contains($text, $replace)">
				<xsl:value-of select="substring-before($text,$replace)" />
				<xsl:value-of select="$by" />
				<xsl:call-template name="string-replace-all">
					<xsl:with-param name="text"
						select="substring-after($text,$replace)" />
					<xsl:with-param name="replace" select="$replace" />
					<xsl:with-param name="by" select="$by" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$text" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
  
  <!--<xsl:template name="upload-bank-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_BANK_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
      <xsl:call-template name="se-upload-bank-details"/>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  --><xsl:template name="file-upload-general-details">
   <!-- Hidden fields. -->
   <div>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">ref_id</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">se_type</xsl:with-param>
    </xsl:call-template>   
    <!-- Don't display this in unsigned mode. -->
    <xsl:if test="$displaymode='edit'">
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">appl_date</xsl:with-param>
     </xsl:call-template>
    </xsl:if>
      <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">format</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="format"/></xsl:with-param>
     </xsl:call-template>
   </div>
	<xsl:if test="entities[number(.) &gt; 0]">
		<xsl:call-template name="address">
		      <xsl:with-param name="show-entity">Y</xsl:with-param>
		      <xsl:with-param name="show-name">N</xsl:with-param>
		      <xsl:with-param name="show-address">N</xsl:with-param>
		      <xsl:with-param name="prefix">applicant</xsl:with-param>
		      <xsl:with-param name="override-product-code">SE</xsl:with-param>
	     </xsl:call-template>
	 </xsl:if> 
      <xsl:call-template name="hidden-field">
  			<xsl:with-param name="name">applicant_name</xsl:with-param>
  	  </xsl:call-template>
  	  <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">applicant_abbv_name</xsl:with-param>
	  </xsl:call-template>
  	  <xsl:call-template name="hidden-field">
		    <xsl:with-param name="name">applicant_address_line_1</xsl:with-param>
	  </xsl:call-template>
	  <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">applicant_address_line_2</xsl:with-param>
	  </xsl:call-template>
	  <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">applicant_dom</xsl:with-param>
	  </xsl:call-template>   
    
    <!-- Bank to which Bulk-order needs to be linked to. -->
	<xsl:if test="$isMultiBank='Y'">
		<xsl:choose>
			<xsl:when test="$displaymode = 'edit'">
				<xsl:call-template name="select-field">
					<xsl:with-param name="label">CUSTOMER_BANK_LABEL</xsl:with-param>
					<xsl:with-param name="name">customer_bank</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				 <xsl:call-template name="input-field">
					<xsl:with-param name="label">CUSTOMER_BANK_LABEL</xsl:with-param>
					<xsl:with-param name="name">customer_bank</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
					<xsl:with-param name="disabled">Y</xsl:with-param>
	   			</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">customer_bank_hidden</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="customer_bank"/></xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	<xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_UPLOAD_FILE_DESCRIPTION</xsl:with-param>
     <xsl:with-param name="name">upload_description</xsl:with-param>
     <xsl:with-param name="maxsize">50</xsl:with-param>
   	</xsl:call-template>
   	<xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_UPLOAD_FILE_REFERENCE</xsl:with-param>
     <xsl:with-param name="name">reference</xsl:with-param>
     <xsl:with-param name="maxsize">20</xsl:with-param>
    </xsl:call-template>  
    <xsl:if test="format='STANDARD'">
	<xsl:call-template name="select-field">
	  <xsl:with-param name="label">XSL_BK_PRODUCT_GROUP_LABEL</xsl:with-param>
	  <xsl:with-param name="required">Y</xsl:with-param>
	  <xsl:with-param name="name">bk_type</xsl:with-param>
	  <xsl:with-param name="value"><xsl:value-of select="bk_type"/></xsl:with-param>
	</xsl:call-template>
	<xsl:if test="$displaymode='edit' or ($displaymode='view' and bk_type='PAYRL')">
		<div id="payrolltype">
		<xsl:call-template name="select-field">
			<xsl:with-param name="label">XSL_BK_PAYROLL_TYPE_LABEL</xsl:with-param>
			<xsl:with-param name="name">payroll</xsl:with-param>
			<xsl:with-param name="required">N</xsl:with-param>
		</xsl:call-template>								
		</div>
	 </xsl:if>
  </xsl:if>	 
   <xsl:call-template name="select-field">
     <xsl:with-param name="label">XSL_UPLOAD_FILE_TYPE</xsl:with-param>
     <xsl:with-param name="name">upload_file_type</xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
	</xsl:call-template>
	 	
								    
	
    <!-- <div id="account-flag">
   <xsl:call-template name="user-account-field">
	<xsl:with-param name="label">XSL_TRANSFER_FROM</xsl:with-param>			
    <xsl:with-param name="name">applicant</xsl:with-param>
    <xsl:with-param name="entity-field">entity</xsl:with-param>
    <xsl:with-param name="required">Y</xsl:with-param>
    <xsl:with-param name="dr-cr">debit</xsl:with-param>
    <xsl:with-param name="show-product-types">N</xsl:with-param>
    <xsl:with-param name="product_types-as-js">Y</xsl:with-param>
    <xsl:with-param name="product_types">'BK:'+dijit.byId('product_type').get('value')</xsl:with-param>
    xsl:with-param name="product_types">FT:MT101,FT:FI202,FT:FI103,FT:MT103,FT:IBG,FT:IAFT,FT:MEPS,FT:PICO,FT:PIDD,FT:IBGEX,FT:GPC</xsl:with-param
    <xsl:with-param name="product-types-required">N</xsl:with-param>
  </xsl:call-template> 
    </div> -->
   <!--  <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_UPLOAD_VALUE_DATE</xsl:with-param>
     <xsl:with-param name="name">value_date</xsl:with-param>
   	 <xsl:with-param name="size">10</xsl:with-param>
     <xsl:with-param name="maxsize">10</xsl:with-param>
     <xsl:with-param name="fieldsize">small</xsl:with-param>
     <xsl:with-param name="type">date</xsl:with-param>
     <xsl:with-param name="swift-validate">N</xsl:with-param>
    </xsl:call-template> -->
    	<xsl:call-template name="hidden-field">
	 <xsl:with-param name="name">product_group</xsl:with-param>
	</xsl:call-template>
    <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">format_name</xsl:with-param>
  	</xsl:call-template>
  	<xsl:call-template name="hidden-field">
     <xsl:with-param name="name">map_code</xsl:with-param>
  	</xsl:call-template>
  	<xsl:call-template name="hidden-field">
     <xsl:with-param name="name">format_type</xsl:with-param>
  	</xsl:call-template>
  	<xsl:call-template name="hidden-field">
     <xsl:with-param name="name">amendable</xsl:with-param>
  	</xsl:call-template>
  	<xsl:call-template name="hidden-field">
     <xsl:with-param name="name">file_encrypted</xsl:with-param>
  	</xsl:call-template>
  	<xsl:call-template name="hidden-field">
     <xsl:with-param name="name">override_duplicate_reference</xsl:with-param>
  	</xsl:call-template>
  	<xsl:call-template name="hidden-field">
     <xsl:with-param name="name">payroll_type</xsl:with-param>
  	</xsl:call-template>
  
	<xsl:call-template name="hidden-field">
	 <xsl:with-param name="name">product_type</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="hidden-field">
	 <xsl:with-param name="name">file_type_permission</xsl:with-param>
	</xsl:call-template>
   

  </xsl:template>
  <!-- File upload Realform.
   -->
  <xsl:template name="realform">  
   <xsl:call-template name="form-wrapper">
   <xsl:with-param name="method">POST</xsl:with-param>
    <xsl:with-param name="name">realform</xsl:with-param>
    <xsl:with-param name="action" select="$realform-action"/>
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
       <xsl:with-param name="value" select="$mode"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">tnxtype</xsl:with-param>
       <xsl:with-param name="value">01</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">attIds</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">fileHashCode</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">attachment_type</xsl:with-param>
       <xsl:with-param name="value">BULK_FILE_UPLOAD</xsl:with-param>
      </xsl:call-template> 
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
       <xsl:with-param name="value">UPLOAD</xsl:with-param>
      </xsl:call-template>
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  
</xsl:stylesheet>