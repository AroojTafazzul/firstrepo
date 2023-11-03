<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
 Transaction Bulk (BK) Form, Customer Side.

Copyright (c) 2000-2011 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      23/03/2012
author:    Pavan Kumar
##########################################################
-->

<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
        xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
        xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
        xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
        exclude-result-prefixes="localization securitycheck utils defaultresource">
        
    
    <xsl:param name="isMultiBank">N</xsl:param>
    <xsl:param name="nicknameEnabled"/>
        
   	<xsl:template name="js-bulk-product-collections">
    <xsl:param name="isFromDraft"/>
		<script>
			dojo.ready(function(){
			dojo.require("dojox.collections.ArrayList");
			misys._config = misys._config || {};
			misys._config.nickname = '<xsl:value-of select="$nicknameEnabled"/>';
			dojo.mixin(misys._config, {
					childSubProductsCollection : new Array(),
					childSubProductsCollectionPayroll : new Array(),
			        subProductsCollection : new Array(),
			        subProductsCollectionPayroll : new Array(),
			        amountAccessPayrollArray : new Array(),
			        itemAccessPayrollArray : new Array(),
			        bkAccessPayrollArray : new Array(),
			        bkTypeCollection : new Array(),
			        payrollTypeCollection : new Array()
			        <xsl:if test="amount_access[.!='']">
			        	,amountAccessPayroll : <xsl:value-of select="amount_access"/>
			        </xsl:if>
			        <xsl:if test="item_access[.!='']">
			        	,itemAccessPayroll : <xsl:value-of select="item_access"/>
			        </xsl:if>
	       		});
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

	       	<xsl:for-each select="avail_products/product">
	       		<xsl:variable name="prodNode" select="."/>
	       		<xsl:variable name="customerBank" select="$prodNode/configured_customer_bank"/>				
	       		<!-- Build the list of FT types available each of the BK types -->
	       		<xsl:for-each select="$prodNode[product_code='BK' and configured_customer_bank=$customerBank]/bktype">
					<xsl:variable name="bkType" select="."/>
					<xsl:choose>
						<xsl:when test="$bkType/code[.='PAYRL']">
							misys._config.childSubProductsCollectionPayroll['<xsl:value-of select="$bkType/code"/>'] = misys._config.childSubProductsCollectionPayroll['<xsl:value-of select="$bkType/code"/>'] || [];
							<xsl:for-each select="$bkType/payroll_type">
								<xsl:variable name="payrollType" select="."/>
								misys._config.childSubProductsCollectionPayroll['<xsl:value-of select="$bkType/code"/>']['<xsl:value-of select="$payrollType/code"/>'] = misys._config.childSubProductsCollectionPayroll['<xsl:value-of select="$bkType/code"/>']['<xsl:value-of select="$payrollType/code"/>'] || [];
								<xsl:for-each select="$payrollType/entity">
									 misys._config.childSubProductsCollectionPayroll['<xsl:value-of select="$bkType/code"/>']['<xsl:value-of select="$payrollType/code"/>']['<xsl:value-of select="."/>_<xsl:value-of select="$customerBank"/>'] = new Array(<xsl:value-of select='count($bkType/payroll_type)'/>);
								</xsl:for-each>
								misys._config.childSubProductsCollectionPayroll['<xsl:value-of select="$bkType/code"/>']['<xsl:value-of select="$payrollType/code"/>']['<xsl:value-of select="$payrollType/entity"/>_<xsl:value-of select="$customerBank"/>'] = [
								<xsl:for-each select="$payrollType/ft_sub_product_code">
								    { 
		   								value:"<xsl:value-of select="./code"/>",name:"<xsl:value-of select="./description"/>"
		   							}
		   							<xsl:if test="not(position()=last())">,</xsl:if>
								</xsl:for-each>
								];
							</xsl:for-each>
						</xsl:when>
						<xsl:otherwise>
								misys._config.childSubProductsCollection['<xsl:value-of select="$bkType/code"/>'] = misys._config.childSubProductsCollection['<xsl:value-of select="$bkType/code"/>'] || []
								<xsl:for-each select="$bkType/entity">
									 misys._config.childSubProductsCollection['<xsl:value-of select="$bkType/code"/>']['<xsl:value-of select="."/>_<xsl:value-of select="$customerBank"/>'] = new Array(<xsl:value-of select='count($bkType/ft_sub_product_code)'/>);
								</xsl:for-each>
								misys._config.childSubProductsCollection['<xsl:value-of select="$bkType/code"/>']['<xsl:value-of select="$bkType/entity"/>_<xsl:value-of select="$customerBank"/>'] = [
								<xsl:for-each select="$bkType/ft_sub_product_code">
								    { 
		   								value:"<xsl:value-of select="./code"/>",name:"<xsl:value-of select="./description"/>"
		   							}
		   							<xsl:if test="not(position()=last())">,</xsl:if>
								</xsl:for-each>
								];
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
				<!-- Build the list final bulk sub products for each of the BK type and Each FT Type-->
				<xsl:for-each select="$prodNode[product_code='BK' and configured_customer_bank=$customerBank]/bktype">
					<xsl:variable name="bkType" select="."/>
					<xsl:choose>
						<xsl:when test="$bkType/code[.='PAYRL']">
							<xsl:for-each select="$bkType/payroll_type">
								<xsl:variable name="payrollType" select="."/>
								misys._config.subProductsCollectionPayroll['<xsl:value-of select="$payrollType/code"/>'] = misys._config.subProductsCollectionPayroll['<xsl:value-of select="$payrollType/code"/>'] || [];
								<xsl:for-each select="$payrollType/entity">
									 misys._config.subProductsCollectionPayroll['<xsl:value-of select="$payrollType/code"/>']['<xsl:value-of select="."/>_<xsl:value-of select="$customerBank"/>'] = new Array(<xsl:value-of select='count($payrollType/ft_sub_product_code)'/>);
								</xsl:for-each>
								<xsl:for-each select="$payrollType/ft_sub_product_code">
								    misys._config.subProductsCollectionPayroll['<xsl:value-of select="$payrollType/code"/>']['<xsl:value-of select="$payrollType/entity"/>_<xsl:value-of select="$customerBank"/>']['<xsl:value-of select="./code"/>'] =
								    { 
		   								value:"<xsl:value-of select="./sub_product_code"/>",name:"<xsl:value-of select="./sub_product_code_description"/>"
		   							};
								</xsl:for-each>
							</xsl:for-each>
						</xsl:when>
						<xsl:otherwise>
								misys._config.subProductsCollection['<xsl:value-of select="$bkType/code"/>'] = misys._config.subProductsCollection['<xsl:value-of select="$bkType/code"/>'] || [];
								<xsl:for-each select="$bkType/entity">
									 misys._config.subProductsCollection['<xsl:value-of select="$bkType/code"/>']['<xsl:value-of select="."/>_<xsl:value-of select="$customerBank"/>'] = new Array(<xsl:value-of select='count($bkType/ft_sub_product_code)'/>);
								</xsl:for-each>
								<xsl:for-each select="$bkType/ft_sub_product_code">
								    misys._config.subProductsCollection['<xsl:value-of select="$bkType/code"/>']['<xsl:value-of select="$bkType/entity"/>_<xsl:value-of select="$customerBank"/>']['<xsl:value-of select="./code"/>'] =
								    { 
		   								value:"<xsl:value-of select="./sub_product_code"/>",name:"<xsl:value-of select="./sub_product_code_description"/>"
		   							};
								</xsl:for-each>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
				
				<xsl:for-each select="$prodNode[product_code='BK' and configured_customer_bank=$customerBank]/bktype/payroll_type">
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
					<xsl:if test="entity!=''">
							misys._config.bkTypeCollection['<xsl:value-of select="entity"/>_<xsl:value-of select="$customerBank"/>'] = misys._config.bkTypeCollection['<xsl:value-of select="entity"/>_<xsl:value-of select="$customerBank"/>'] || [];
							misys._config.bkTypeCollectionTracker_entity = misys._config.bkTypeCollectionTracker_entity || new dojox.collections.ArrayList();
						 	if(!isBkTypePresent(misys._config.bkTypeCollection['<xsl:value-of select="entity"/>_<xsl:value-of select="$customerBank"/>'], '<xsl:value-of select="./../code"/>'.toString()))
						  	{	
								misys._config.bkTypeCollection['<xsl:value-of select="entity"/>_<xsl:value-of select="$customerBank"/>'].push(
		   								{
											value:"<xsl:value-of select="./../code"/>",name:"<xsl:value-of select="./../description"/>"
									 	}
		   							);
		   					}
							misys._config.bkTypeCollectionTracker_entity.add('<xsl:value-of select="./../code"/>'.toString());
					</xsl:if>
				</xsl:for-each>
				<xsl:for-each select="$prodNode[product_code='BK' and configured_customer_bank=$customerBank]/bktype[.!='PAYRL']">
					<xsl:if test="entity!=''">
						misys._config.bkTypeCollection['<xsl:value-of select="entity"/>_<xsl:value-of select="$customerBank"/>'] =misys._config.bkTypeCollection['<xsl:value-of select="entity"/>_<xsl:value-of select="$customerBank"/>'] || [];
						misys._config.bkTypeCollection['<xsl:value-of select="entity"/>_<xsl:value-of select="$customerBank"/>'].push(
						    { 
   								value:"<xsl:value-of select="code"/>",name:"<xsl:value-of select="description"/>"
   							}
						);
					</xsl:if>
				</xsl:for-each>
				
				<!--  Build list of pay available roll types for each of the entities -->
				<xsl:for-each select="$prodNode[product_code='BK' and configured_customer_bank=$customerBank]/bktype/payroll_type">
						misys._config.payrollTypeCollection['<xsl:value-of select="entity"/>_<xsl:value-of select="$customerBank"/>'] = misys._config.payrollTypeCollection['<xsl:value-of select="entity"/>_<xsl:value-of select="$customerBank"/>'] || [];
						misys._config.payrollTypeCollection['<xsl:value-of select="entity"/>_<xsl:value-of select="$customerBank"/>'].push(
						    { 
   								value:"<xsl:value-of select="code"/>",name:"<xsl:value-of select="description"/>"
   							}
						);
				</xsl:for-each>
				
				<xsl:for-each select="$prodNode[product_code='BK' and configured_customer_bank=$customerBank]/bktype[code='PAYRL']/payroll_type">
					<xsl:variable name="node" select="."/>
					misys._config.amountAccessPayrollArray['<xsl:value-of select="$node/code"/>'] = <xsl:value-of select='$node/amount_access'/>;
					misys._config.itemAccessPayrollArray['<xsl:value-of select="$node/code"/>'] = <xsl:value-of select='$node/item_access'/>;
					
					misys._config.bkAccessPayrollArray['<xsl:value-of select="$node/code"/>'] = misys._config.bkAccessPayrollArray['<xsl:value-of select="$node/code"/>'] || [];
				</xsl:for-each>
				
				<xsl:for-each select="$prodNode[product_code='BK' and configured_customer_bank=$customerBank]/bktype[code='PAYRL']/payroll_type">
					<xsl:variable name="node" select="."/>
					misys._config.bkAccessPayrollArray['<xsl:value-of select="$node/code"/>']['<xsl:value-of select="$node/entity"/>_<xsl:value-of select="$customerBank"/>'] = 
						misys._config.bkAccessPayrollArray['<xsl:value-of select="$node/code"/>']['<xsl:value-of select="$node/entity"/>_<xsl:value-of select="$customerBank"/>'] || [];	
					
					
					misys._config.bkAccessPayrollArray['<xsl:value-of select="$node/code"/>']['<xsl:value-of select="$node/entity"/>_<xsl:value-of select="$customerBank"/>'].push(
					    { 
 							itemAccess:"<xsl:value-of select="$node/item_access"/>", amountAccess:"<xsl:value-of select="$node/amount_access"/>"
 						}
					);
				</xsl:for-each>
			</xsl:for-each>
				misys._config.openPending = <xsl:value-of select="$isFromDraft"/>;
			});
		</script>  		
  	</xsl:template>
  		
	<!-- Additional hidden fields for this form are  -->
	<!-- added here. -->
	<xsl:template name="bk-hidden-fields">
		<xsl:variable name="entityParam" select="entity"></xsl:variable>
		<xsl:variable name="companyIdParam" select="company_id"></xsl:variable>
		<xsl:variable name="applicantActNoParam" select="applicant_act_no"></xsl:variable>
		<xsl:call-template name="common-hidden-fields">
			<xsl:with-param name="show-cust_ref_id">N</xsl:with-param>
			<xsl:with-param name="show-type">N</xsl:with-param>
			<xsl:with-param name="additional-fields">	
				<xsl:call-template name="hidden-field">
				   <xsl:with-param name="name">entity_hidden</xsl:with-param>
				   <xsl:with-param name="value"><xsl:value-of select="entity"/></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
				   <xsl:with-param name="name">applicant_act_nickname_hidden</xsl:with-param>
				   <xsl:with-param name="value"><xsl:value-of select="utils:getNickNameForXML($entityParam,$companyIdParam,$applicantActNoParam)"/></xsl:with-param>
				</xsl:call-template>	
				<xsl:call-template name="hidden-field">
				   <xsl:with-param name="name">applicant_act_nickname</xsl:with-param>
				   <xsl:with-param name="value"><xsl:value-of select="applicant_act_nickname"/></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
				   <xsl:with-param name="name">applicant_collection_act_nickname</xsl:with-param>
				   <xsl:with-param name="value"><xsl:value-of select="applicant_collection_act_nickname"/></xsl:with-param>
				</xsl:call-template>	
				<xsl:call-template name="hidden-field">
				   <xsl:with-param name="name">bulk_template_id</xsl:with-param>
				</xsl:call-template>
			    <xsl:call-template name="hidden-field">
				   <xsl:with-param name="name">bulk_ref_id</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
				   <xsl:with-param name="name">bulk_tnx_id</xsl:with-param>
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
			       <xsl:with-param name="name">counterparty_details_name_1</xsl:with-param>
			       <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_name"/></xsl:with-param>
			    </xsl:call-template>
			    <xsl:call-template name="hidden-field">
			       <xsl:with-param name="name">counterparty_details_position_1</xsl:with-param>
			       <xsl:with-param name="value">1</xsl:with-param>
			    </xsl:call-template>	
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">beneficiary_mode</xsl:with-param>
				</xsl:call-template>
				<!-- >xsl:call-template name="hidden-field">
					<xsl:with-param name="name">child_sub_product_code</xsl:with-param>
				</xsl:call-template-->
				<xsl:call-template name="hidden-field">
			       <xsl:with-param name="name">applicant_abbv_name</xsl:with-param>
			    </xsl:call-template>
				<xsl:call-template name="hidden-field">
			       <xsl:with-param name="name">applicant_name</xsl:with-param>
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
				<xsl:call-template name="hidden-field">
			       <xsl:with-param name="name">applicant_reference</xsl:with-param>
			    </xsl:call-template>
			    	<xsl:call-template name="hidden-field">
			       <xsl:with-param name="name">applicant_collection_reference</xsl:with-param>
			    </xsl:call-template>
			    <xsl:call-template name="hidden-field">
				   <xsl:with-param name="name">product_code</xsl:with-param>
				   <xsl:with-param name="value">BK</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
				   <xsl:with-param name="name">sub_product_code</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
				   <xsl:with-param name="name">child_product_code</xsl:with-param>
				   <xsl:with-param name="value">FT</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
		       	   <xsl:with-param name="name">pre_approved_status</xsl:with-param>
		   		</xsl:call-template>
		   		<!-- Following fields are being used after implementaion of
		   			 entity level permission for product group and pay roll type
		   			 drop down on the UI, As these drop down are populated
		   			 dynamically so use these fields to when we reitrive
		   			 from draft and access in JS -->
		   		<xsl:call-template name="hidden-field">
		       	   <xsl:with-param name="name">bk_type_hidden</xsl:with-param>
		       	   <xsl:with-param name="value"><xsl:value-of select="bk_type"/></xsl:with-param>
		   		</xsl:call-template>
		   		<xsl:call-template name="hidden-field">
		       	   <xsl:with-param name="name">payroll_type_hidden</xsl:with-param>
		       	   <xsl:with-param name="value"><xsl:value-of select="payroll_type"/></xsl:with-param>
		   		</xsl:call-template>
		   		<xsl:call-template name="hidden-field">
			       <xsl:with-param name="name">bank_base_currency</xsl:with-param>
			       <xsl:with-param name="value"><xsl:value-of select="bank_base_currency"/></xsl:with-param>
			    </xsl:call-template>
		   		<!-- Include cross-references -->
		   		<xsl:apply-templates select="cross_references" mode="hidden_form"/>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="bulk-general-details">
		<xsl:param name="show-child-transactions"/>
		<xsl:param name="show-eligible-bulks-for-merge"/>
		<xsl:param name="child-product-code"/>
		<xsl:if test="$child-product-code='FT' or $child-product-code=''">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="column-container">
					<xsl:with-param name="content">
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="content">
							   <xsl:if test="entities[number(.) &gt; 0]">
									<div id="display_entity_row" class="field">
										<span class="label"><xsl:value-of select="localization:getGTPString($language, 'ENTITY_LABEL')"/></span>
										<div class="content" id="display_entity"><xsl:value-of select="entity"/></div> 
									</div>
								</xsl:if>
								<!-- Bank to which Bulk-order needs to be linked to. -->
								<div id="display_customer_bank_row" class="field">
									<span class="label"><xsl:value-of select="localization:getGTPString($language, 'CUSTOMER_BANK_LABEL')"/></span>
									<div class="content" id="display_customer_bank"><xsl:value-of select="issuing_bank/name"/></div> 
								</div>
								<xsl:if test="$displaymode='edit' or ($displaymode='view' and (bk_type='PAYMT' or bk_type='PAYRL'))">
								<div id="display_account_row" class="field">
									<span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSFER_FROM')"/>&nbsp;</span>
									<div class="content" id="display_account"><xsl:value-of select="applicant_act_name"/></div> 
								</div>
								</xsl:if>
								<xsl:if test="$displaymode='edit' or ($displaymode='view' and bk_type='COLLE')">
								<div id="display_to_account_row" class="field">
									<span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSFER_TO')"/>&nbsp;</span>
									<div class="content" id="display_to_account"><xsl:value-of select="applicant_act_name"/></div> 
								</div>
								</xsl:if>
								<xsl:call-template name="nickname-field-template"/>
								<div id="display_child_sub_product_code_row" class="field">
									<span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_SUB_PRODUCT')"/>&nbsp;</span>
									<div class="content" id="display_child_sub_product_code"><xsl:if test="child_sub_product_code[.!='']"><xsl:value-of select="localization:getDecode($language, 'N047', concat(child_sub_product_code,'_BK'))"/></xsl:if></div> 
								</div>
								<div id="product_group_row" class="field">
									<span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_BK_PRODUCT_GROUP')"/>&nbsp;</span>
									<xsl:if test="$displaymode='edit' or $displaymode='view'">
										<div class="content" id="product_group"><xsl:value-of select="localization:getDecode($language, 'N089',bk_type)"/></div>
										<xsl:if test="$displaymode='edit' or ($displaymode='view' and bk_type='PAYRL')">
											<div id="display_payroll_row" >
												<span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_BK_PAYROLL_TYPE_LABEL')"/>&nbsp;</span>
												<div class="content" id="display_payroll_type"><xsl:value-of select="localization:getDecode($language, 'N090', payroll_type)"/></div> 
											</div>
										</xsl:if>	
									</xsl:if>
								</div>
								 <xsl:choose>
	                                <xsl:when test="child_sub_product_code ='MUPS'">
	                                      <div id="display_clearing_code_row" class="field">
	                                            <span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_CLEARING_CODE_NAME')"/>&nbsp;</span>
	                                            <div class="content" id="display_clearing_code"><xsl:value-of select="clearing_code"/></div> 
	                                      </div>
	                                </xsl:when>
	                                <xsl:when test="$displaymode='edit'">
	                                      <div id="display_clearing_code_row" class="field" style="display:none">
	                                            <span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_CLEARING_CODE_NAME')"/>&nbsp;</span>
	                                            <div class="content" id="display_clearing_code"><xsl:value-of select="clearing_code"/></div> 
	                                      </div>
	                                </xsl:when>
                                </xsl:choose>
								<xsl:call-template name="input-field">	
								  <xsl:with-param name="label">XSL_GENERALDETAILS_BULK_DESCRIPTION</xsl:with-param>
								  <xsl:with-param name="name">narrative_additional_instructions</xsl:with-param>
								  <xsl:with-param name="size">50</xsl:with-param>
								  <xsl:with-param name="maxsize">50</xsl:with-param>
								  <xsl:with-param name="swift-validate">Y</xsl:with-param>
								</xsl:call-template>
								<div id="pre_approved_display_row" class="field">
								  <span class="label"/>
							        <div id="PAB" class="content">
							   	       <xsl:attribute name="style">
							   	         <xsl:choose>
							   	 	         <xsl:when test="pre_approved_status[.='Y']">display:inline</xsl:when>
							   	 	         <xsl:otherwise>display:none</xsl:otherwise>
							   	         </xsl:choose>
							   	       </xsl:attribute>
								      <xsl:value-of select="localization:getGTPString($language,'XSL_BULK_PAB_ONLY')"/>
							       </div> 
								</div>
						  </xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="column-wrapper">
						  <xsl:with-param name="appendClass">bulk-general-details-column-wrapper</xsl:with-param>
							<xsl:with-param name="content">
								<!-- xsl:call-template name="input-field">
									<xsl:with-param name="label">BANK_LABEL</xsl:with-param>
									<xsl:with-param name="fieldsize">small</xsl:with-param>
									<xsl:with-param name="value" select="issuing_bank/name" />
									<xsl:with-param name="override-displaymode">view</xsl:with-param>
								</xsl:call-template-->
								
							  	<xsl:call-template name="common-general-details">
						     		<xsl:with-param name="show-cust-ref-id">N</xsl:with-param>
						     		<xsl:with-param name="cross-ref-summary-option">FILE_DETAILS</xsl:with-param>
						  		</xsl:call-template><!--
								 TODO identify is sub_product_code or child subproduct code needs to be sent
								--><xsl:call-template name="business-date-field">
									<xsl:with-param name="label">XSL_GENERALDETAILS_TRANSFER_DATE</xsl:with-param>
									<xsl:with-param name="name">value_date</xsl:with-param>
									<xsl:with-param name="size">10</xsl:with-param>
									<xsl:with-param name="maxsize">10</xsl:with-param>
									<xsl:with-param name="required">Y</xsl:with-param>
									<xsl:with-param name="fieldsize">small</xsl:with-param>
									<xsl:with-param name="sub-product-code-widget-id">sub_product_code</xsl:with-param>
									<xsl:with-param name="bank-abbv-name-widget-id">issuing_bank_abbv_name</xsl:with-param>
									<xsl:with-param name="cur-code-widget-id">bk_total_amt_cur_code</xsl:with-param>									
								</xsl:call-template>
							  <xsl:if test="$displaymode ='view'">	
								<xsl:call-template name="hidden-field">
									<xsl:with-param name="name">value_date_unsigned</xsl:with-param>
									<xsl:with-param name="value" select="value_date"></xsl:with-param>
								</xsl:call-template>
							  </xsl:if>
								<xsl:choose>
				   	 	         <xsl:when test="cust_ref_id[.='']">
				   	 	         <xsl:call-template name="input-field">
									  <xsl:with-param name="label">XSL_GENERALDETAILS_BULK_REF_ID</xsl:with-param>	
									  <xsl:with-param name="name">cust_ref_id</xsl:with-param>
									  <xsl:with-param name="size">16</xsl:with-param>
									  <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_CASH_LENGTH')"/></xsl:with-param>
									  <xsl:with-param name="regular-expression">
									  			<xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_CASH_VALIDATION_REGEX')"/>
									  </xsl:with-param>
									  <xsl:with-param name="value" select="ref_id"></xsl:with-param>
									  <xsl:with-param name="fieldsize">small</xsl:with-param>
								</xsl:call-template>				   	 	         
				   	 	         </xsl:when>
							   	 <xsl:otherwise>
							   	 <xsl:call-template name="input-field">
									  <xsl:with-param name="label">XSL_GENERALDETAILS_BULK_REF_ID</xsl:with-param>	
									  <xsl:with-param name="name">cust_ref_id</xsl:with-param>
									  <xsl:with-param name="size">16</xsl:with-param>
									  <xsl:with-param name="maxsize">64</xsl:with-param>
									  <xsl:with-param name="regular-expression">
									  			<xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_CASH_VALIDATION_REGEX')"/>
									  </xsl:with-param>
									  <xsl:with-param name="fieldsize">small</xsl:with-param>
								</xsl:call-template>
							   	 </xsl:otherwise>
							   </xsl:choose>
								<div id="dialogTransaction" />
								<div dojoType="dijit.form.Form" id="transactionForm" method="post" />
								<div dojoType="dijit.form.Form" id="existingForm" method="post" >
								  <!--  Hidden field used to store list of Child transactions's ref id which has to be moved to other bulk when selected
								        Move to option
								        This is set from merge_demerge_bk.js -->
									<xsl:call-template name="hidden-field">
				 						<xsl:with-param name="name">list_keys</xsl:with-param>
									</xsl:call-template>
									<xsl:call-template name="hidden-field">
				 						<xsl:with-param name="name">merge_fts</xsl:with-param>
				 						 <xsl:with-param name="value"><xsl:value-of select="list_keys"/></xsl:with-param>
									</xsl:call-template>
								  <!-- 
								         Hidden field used to set destination bulk ref id, when destination bulk is selected for de merge.
								         This is set from merge_demerge_bk.js
								      -->
								    <xsl:call-template name="hidden-field">
				 						<xsl:with-param name="name">destination_bulk_ref_id</xsl:with-param>
									</xsl:call-template>
									<xsl:call-template name="hidden-field">
				 						<xsl:with-param name="name">destination_bulk_tnx_id</xsl:with-param>
									</xsl:call-template>
								</div>
							
						 </xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="bulk-summary-details"/>
				<p>&nbsp;</p>
				
	      		<xsl:if test="$displaymode='edit'">
	      			<xsl:if test="not(item_access) or  (item_access[.='true'])  ">
	      				<div id="addTransactionButtonContainer">
							<xsl:call-template name="button-wrapper">
								<xsl:with-param name="label">XSL_BK_ADD_TRANSACTION</xsl:with-param>
								<xsl:with-param name="id">button_addtnx</xsl:with-param>
								<xsl:with-param name="onclick">misys.addTransaction();return false;</xsl:with-param>
								<xsl:with-param name="show-text-label">Y</xsl:with-param>
							</xsl:call-template>
						</div>
					</xsl:if>
				</xsl:if>
				<xsl:choose>
				<!--  This template is used from open from draft and open for merge
				      When from draft show the child transactions in the current bulk
				      when from open from merge show eligible bulks along with current bulk header info  -->
			    <xsl:when test="$show-child-transactions='Y'">     
					<xsl:if test="not(item_access) or  (item_access[.='true'])  ">
						<xsl:call-template name="topic-transaction-grid" />
					</xsl:if>
					 <xsl:if test="$displaymode = 'edit' and (not(item_access) or  (item_access[.='true'])) and ((bulk_copy_access[.='true']))">	
						<xsl:call-template name="move-items-button"/>
					  </xsl:if>	
				</xsl:when>	 
				<xsl:when test="$show-eligible-bulks-for-merge ='Y'">
				   <xsl:call-template name="topic-eligible-bulk-grid" />
				   <xsl:call-template name="move-items-new-bulk-button"/>
				</xsl:when>
				<xsl:otherwise>
				</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
		</xsl:if>
		<xsl:if test="$child-product-code='IN'">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
					<xsl:call-template name="row-wrapper">
						<xsl:with-param name="label">XSL_BK_REF_ID</xsl:with-param>	
						<xsl:with-param name="content">
							<xsl:call-template name="input-field">
								  <xsl:with-param name="name">ref_id</xsl:with-param>
								  <xsl:with-param name="override-displaymode">view</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="hidden-field">
								  <xsl:with-param name="name">ref_id</xsl:with-param>
								  <xsl:with-param name="value"><xsl:value-of select="ref_id"/></xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="hidden-field">
								<xsl:with-param name="name">bk_total_amt_cur_code</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select="bk_total_amt_cur_code"/></xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="hidden-field">
								<xsl:with-param name="name">bk_total_amt</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select="bk_total_amt"/></xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test ="entity and entity !=''"> 
					<xsl:call-template name="entity-field">
						<xsl:with-param name="label" select="localization:getGTPString($language, 'ENTITY_LABEL')"/>
						<xsl:with-param name="value" select="entity"/>
					</xsl:call-template>
					</xsl:if>
					<xsl:call-template name="bank-details" />
					<xsl:call-template name="bulk-summary-invoice-details"/>
					<p>&nbsp;</p>
					<xsl:if test="$show-child-transactions='Y'">     
						<xsl:call-template name="bulk-invoice-show-grid" />
					</xsl:if>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="bk-fscm-hidden-fields">
			     <xsl:with-param name="childProductCode">IN</xsl:with-param>
		</xsl:call-template>
		</xsl:if>
		<xsl:if test="$child-product-code='IP'">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
					<xsl:call-template name="row-wrapper">
					<xsl:with-param name="label">XSL_BK_REF_ID</xsl:with-param>
						<xsl:with-param name="content">
							<xsl:call-template name="input-field">
								  <xsl:with-param name="name">ref_id</xsl:with-param>
								  <xsl:with-param name="override-displaymode">view</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="hidden-field">
								  <xsl:with-param name="name">ref_id</xsl:with-param>
								  <xsl:with-param name="value"><xsl:value-of select="ref_id"/></xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="hidden-field">
								<xsl:with-param name="name">bk_total_amt_cur_code</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select="bk_total_amt_cur_code"/></xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="hidden-field">
								<xsl:with-param name="name">bk_total_amt</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select="bk_total_amt"/></xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test ="entity and entity !=''"> 
					<xsl:call-template name="entity-field">
						<xsl:with-param name="label" select="localization:getGTPString($language, 'ENTITY_LABEL')"/>
						<xsl:with-param name="value" select="entity"/>
					</xsl:call-template>
					</xsl:if>
					<xsl:call-template name="bank-details" />
					<xsl:call-template name="bulk-summary-invoice-details"/>
					<p>&nbsp;</p>
					<xsl:if test="$show-child-transactions='Y'">     
						<xsl:call-template name="bulk-invoice-payable-show-grid" />
					</xsl:if>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="bk-fscm-hidden-fields">
			     <xsl:with-param name="childProductCode">IP</xsl:with-param>
		</xsl:call-template>
		</xsl:if>
	</xsl:template>
		
	
	<xsl:template name="bulk-summary-details">
	 	<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_BULK_SUMMARY</xsl:with-param>
			<xsl:with-param name="content">
			<xsl:choose>
				<xsl:when test="child_sub_product_code = 'MEPS' or  child_sub_product_code = 'RTGS' ">
				<div id="MEPS_RTGS_DISCLAIMER" class="field" style="font-size: 1em;">
					<xsl:value-of select="localization:getGTPString($language,'XSL_BK_MEPS_RTGS_DISCLAIMER')"/>
				</div>
				</xsl:when>
				<xsl:otherwise>
				<div id="MEPS_RTGS_DISCLAIMER" class="field" style="font-size: 1em;">
					
				</div>
				</xsl:otherwise>
				</xsl:choose>
				<p>&nbsp;</p>
		
		
			
				<xsl:call-template name="column-container">
					<xsl:with-param name="content">
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="content">
							    <xsl:call-template name="currency-field">
									<xsl:with-param name="label">XSL_BK_TOTAL_AMT</xsl:with-param>
									<xsl:with-param name="override-currency-name">bk_total_amt_cur_code</xsl:with-param>
									<xsl:with-param name="override-currency-value" select="bk_cur_code"/>
									<xsl:with-param name="override-amt-name">bk_total_amt</xsl:with-param>
									<xsl:with-param name="required">N</xsl:with-param>
									<xsl:with-param name="amt-readonly">Y</xsl:with-param>
									<xsl:with-param name="currency-readonly">Y</xsl:with-param>
									<xsl:with-param name="show-button">N</xsl:with-param>
									<xsl:with-param name="constraints">N</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="total_approved_amt[.!=''] and $displaymode = 'view'">
							<xsl:call-template name="column-wrapper">
							<xsl:with-param name="content">
									 <xsl:call-template name="currency-field">
										<xsl:with-param name="label">XSL_BK_TOTAL_APPROVED_AMT</xsl:with-param>
										<xsl:with-param name="override-currency-name">bk_total_amt_cur_code</xsl:with-param>
										<xsl:with-param name="override-currency-value" select="bk_cur_code"/>
										<xsl:with-param name="override-amt-name">total_approved_amt</xsl:with-param>
										<xsl:with-param name="required">N</xsl:with-param>
										<xsl:with-param name="amt-readonly">Y</xsl:with-param>
										<xsl:with-param name="currency-readonly">Y</xsl:with-param>
										<xsl:with-param name="show-button">N</xsl:with-param>
										<xsl:with-param name="constraints">N</xsl:with-param>
										<xsl:with-param name="appendClass">inlineLabel</xsl:with-param>
									</xsl:call-template>
							  </xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="content">
							   <xsl:if test="not(amount_access) or  (amount_access[.='true'])  ">
									    <xsl:call-template name="currency-field">
											<xsl:with-param name="label">XSL_BK_HIGHEST_AMT</xsl:with-param>
											<xsl:with-param name="override-currency-name">bk_highest_amt_cur_code</xsl:with-param>
											<xsl:with-param name="override-currency-value" select="bk_cur_code"/>
											<xsl:with-param name="override-amt-name">bk_highest_amt</xsl:with-param>
											<xsl:with-param name="required">N</xsl:with-param>
											<xsl:with-param name="amt-readonly">Y</xsl:with-param>
											<xsl:with-param name="currency-readonly">Y</xsl:with-param>
											<xsl:with-param name="show-button">N</xsl:with-param>
											<xsl:with-param name="constraints">N</xsl:with-param>
										</xsl:call-template>
								</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="highest_approved_amt[.!=''] and $displaymode = 'view'">
							<xsl:call-template name="column-wrapper">
							<xsl:with-param name="content">
									 <xsl:call-template name="currency-field">
										<xsl:with-param name="label">XSL_BK_HIGHEST_APPROVED_AMT</xsl:with-param>
										<xsl:with-param name="override-currency-name">bk_total_amt_cur_code</xsl:with-param>
										<xsl:with-param name="override-currency-value" select="bk_cur_code"/>
										<xsl:with-param name="override-amt-name">highest_approved_amt</xsl:with-param>
										<xsl:with-param name="required">N</xsl:with-param>
										<xsl:with-param name="amt-readonly">Y</xsl:with-param>
										<xsl:with-param name="currency-readonly">Y</xsl:with-param>
										<xsl:with-param name="show-button">N</xsl:with-param>
										<xsl:with-param name="constraints">N</xsl:with-param>
										<xsl:with-param name="appendClass">inlineLabel</xsl:with-param>
									</xsl:call-template>
							  </xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:call-template name="column-wrapper">
						<xsl:with-param name="content">
								 <xsl:call-template name="hidden-field">
							       <xsl:with-param name="name">record_number</xsl:with-param>
							    </xsl:call-template>
								<div id="display_record_number_row" class="field">
									<span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_BK_RECORD_NUMBER')"/>&nbsp;</span>
									<div class="content" id="display_record_number"><xsl:value-of select="record_number"/></div>
								</div>
						  </xsl:with-param>
						</xsl:call-template>
						<xsl:if test="no_approved_records[.!=''] and $displaymode = 'view'">
							<xsl:call-template name="column-wrapper">
								<xsl:with-param name="content">
									<xsl:call-template name="input-field">
									  <xsl:with-param name="label">XSL_BK_APPROVED_RECORD_NUMBER</xsl:with-param>	
									  <xsl:with-param name="name">no_approved_records</xsl:with-param>
									  <xsl:with-param name="readonly">Y</xsl:with-param>
									</xsl:call-template>
							  	</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		 </xsl:call-template>	
		 <!-- This below parameters are needed for re-authentication in view mode -->
	     <!-- Start  -->
	     <xsl:if test="$displaymode!='edit'">  
	     <xsl:call-template name="hidden-field">
	        <xsl:with-param name="name">entity</xsl:with-param>
	     </xsl:call-template>
	       <xsl:call-template name="hidden-field">
	        <xsl:with-param name="name">bk_total_amt_cur_code</xsl:with-param>
	        <xsl:with-param name="value"><xsl:value-of select="bk_cur_code"/></xsl:with-param>
	     </xsl:call-template>
	     <xsl:call-template name="hidden-field">
	        <xsl:with-param name="name">bk_total_amt</xsl:with-param>
	     </xsl:call-template>
	     </xsl:if>
	     <!--  Esign2 field to store the value when returned from server-->
	     <xsl:call-template name="hidden-field">
	        <xsl:with-param name="name">bk_esign2_value</xsl:with-param>
	     </xsl:call-template>	    
	     
	     <!-- End  -->
	</xsl:template>
	<xsl:template name="bulk-summary-invoice-details">
	 	<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_BULK_SUMMARY</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="column-container">
					<xsl:with-param name="content">
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="content">
							    <xsl:call-template name="currency-field">
									<xsl:with-param name="label">XSL_BK_TOTAL_AMT</xsl:with-param>
									<xsl:with-param name="override-currency-name">bk_total_amt_cur_code</xsl:with-param>
									<xsl:with-param name="override-currency-value" select="bk_cur_code"/>
									<xsl:with-param name="override-amt-name">bk_total_amt</xsl:with-param>
									<xsl:with-param name="required">N</xsl:with-param>
									<xsl:with-param name="amt-readonly">Y</xsl:with-param>
									<xsl:with-param name="currency-readonly">Y</xsl:with-param>
									<xsl:with-param name="show-button">N</xsl:with-param>
									<xsl:with-param name="constraints">N</xsl:with-param>
									<xsl:with-param name="appendClass">inlineLabel</xsl:with-param>
								</xsl:call-template>
								<xsl:if test="bk_fin_amt[.!='']">
								    <xsl:call-template name="currency-field">
										<xsl:with-param name="label">XSL_BK_FIN_AMT</xsl:with-param>
										<xsl:with-param name="override-currency-name">bk_fin_cur_code</xsl:with-param>
										<xsl:with-param name="override-currency-value" select="bk_fin_cur_code"/>
										<xsl:with-param name="override-amt-name">bk_fin_amt</xsl:with-param>
										<xsl:with-param name="required">N</xsl:with-param>
										<xsl:with-param name="amt-readonly">Y</xsl:with-param>
										<xsl:with-param name="currency-readonly">Y</xsl:with-param>
										<xsl:with-param name="show-button">N</xsl:with-param>
										<xsl:with-param name="constraints">N</xsl:with-param>
										<xsl:with-param name="appendClass">inlineLabel</xsl:with-param>
									</xsl:call-template>
								</xsl:if>								
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="column-wrapper">
						<xsl:with-param name="content">
								<xsl:if test="bk_highest_amt[.!='']">
								    <xsl:call-template name="currency-field">
										<xsl:with-param name="label">XSL_BK_HIGHEST_AMT</xsl:with-param>
										<xsl:with-param name="override-currency-name">bk_cur_code</xsl:with-param>
										<xsl:with-param name="override-currency-value" select="bk_cur_code"/>
										<xsl:with-param name="override-amt-name">bk_highest_amt</xsl:with-param>
										<xsl:with-param name="required">N</xsl:with-param>
										<xsl:with-param name="amt-readonly">Y</xsl:with-param>
										<xsl:with-param name="currency-readonly">Y</xsl:with-param>
										<xsl:with-param name="show-button">N</xsl:with-param>
										<xsl:with-param name="constraints">N</xsl:with-param>
										<xsl:with-param name="appendClass">inlineLabel</xsl:with-param>
									</xsl:call-template>
								</xsl:if>							
								 <xsl:call-template name="hidden-field">
							       <xsl:with-param name="name">record_number</xsl:with-param>
							    </xsl:call-template>
								<div id="display_record_number_row" class="field">
									<span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_BK_RECORD_NUMBER')"/>&nbsp;</span>
									<div class="content" id="display_record_number"><xsl:value-of select="record_number"/></div>
								</div>
						  </xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		 </xsl:call-template>
	</xsl:template>
	
	<xsl:template name="topic-transaction-grid">
		<p>&nbsp;</p>
		<div id="transactionGridContainer" class="widgetContainer">
			<div>
				<xsl:call-template name="animatedFieldSetHeader">
			   		<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_HELPSEARCH_OPTIONS')"/></xsl:with-param>
			   		<xsl:with-param name="animateDivId">searchCriteria</xsl:with-param>
			   		<xsl:with-param name="prefix">searchCriteria</xsl:with-param>
			   		<xsl:with-param name="show">N</xsl:with-param>
			   	</xsl:call-template>
				<div>
				  <xsl:attribute name="id">searchCriteria</xsl:attribute>
					<xsl:attribute name="style">display:none;width:100%;padding-left:5px; </xsl:attribute>
					<div class="widgetContainer clear">
						<!--  <small><xsl:value-of select="localization:getGTPString($language, 'LIST_HELP_SDATA')"/></small>  -->
						<div name="TransactionSearchForm" id="TransactionSearchForm" dojoType="dijit.form.Form">
							<div id="search_ref_id_row" class="field">
								<label for="search_ref_id"><xsl:value-of select="localization:getGTPString($language, 'REFERENCEID_LABEL')"/></label>
								<input trim="true" style="width: 14em" class="medium" id="search_ref_id" name="search_ref_id" dojoType="dijit.form.TextBox" maxlength="20" value="" size="14" />
								<input type="hidden" name="bulk_ref_id" id="search_bulk_ref_id" value="{ref_id}" dojoType="dijit.form.TextBox"/>
								<input type="hidden" name="bulk_tnx_id" id="search_bulk_tnx_id" value="{tnx_id}" dojoType="dijit.form.TextBox"/>
							</div>
							<xsl:if test="child_sub_product_code!='TPT' and child_sub_product_code!='INT' and child_sub_product_code!= 'MT103' and child_sub_product_code!= 'MUPS' and child_sub_product_code!= 'MEPS' and child_sub_product_code!= 'RTGS'">
							<div id="bank_code_row" class="field">
								<label for="bank_code"><xsl:value-of select="localization:getGTPString($language, 'XSL_BANK_CODE')"/></label>
								<input trim="true" style="width: 14em" class="medium" id="bank_code" name="bank_code" dojoType="dijit.form.TextBox" maxlength="20" value="" size="14" />
							</div>
							<div id="branch_code_row" class="field">
								<label for="branch_code"><xsl:value-of select="localization:getGTPString($language, 'XSL_BRANCH_CODE')"/></label>
								<input trim="true" style="width: 14em" class="medium" id="branch_code" name="branch_code" dojoType="dijit.form.TextBox" maxlength="20" value="" size="14" />
							</div>
							</xsl:if>
							<xsl:if test="child_sub_product_code[.='MUPS']">
							<div id="ifsc_code_row" class="field">
								<label for="ifsc_code"><xsl:value-of select="localization:getGTPString($language, 'XSL_IFSC_CODE')"/></label>
								<input trim="true" style="width: 14em" class="medium" id="ifsc_code" name="ifsc_code" dojoType="dijit.form.TextBox" maxlength="15" value="" size="14" />
							</div>
							</xsl:if>
							<div id="ben_account_no_row" class="field">
								<label for="ben_account_no"><xsl:value-of select="localization:getGTPString($language, 'ACCOUNTNO_LABEL')"/></label>
								<input trim="true" style="width: 14em" class="medium" id="ben_account_no" name="ben_account_no" dojoType="dijit.form.TextBox" maxlength="32" value="" size="14" />
							</div>
							<div id="ben_account_name_row" class="field">
								<label for="ben_account_name"><xsl:value-of select="localization:getGTPString($language, 'BENEFICIARY_NAME_LABEL')"/></label>
								<xsl:choose>
								  <xsl:when test="child_sub_product_code!='HVPS' and child_sub_product_code!='HVXB'"><input trim="true" style="width: 20em" class="medium" id="ben_account_name" name="ben_account_name" dojoType="dijit.form.TextBox" maxlength="35" value="" size="14" /></xsl:when>
								  <xsl:otherwise><input trim="true" style="width: 35em" class="medium" id="ben_account_name" name="ben_account_name" dojoType="dijit.form.TextBox" maxlength="60" value="" size="14" /></xsl:otherwise>
								</xsl:choose>
							</div>
							<div id="tnx_stat_code_row" class="field" >
								<label for="tnx_stat_code"><xsl:value-of select="localization:getGTPString($language, 'STATUS_LABEL')"/></label>
								<select name="tnx_stat_code" id="tnx_stat_code" dojoType="dijit.form.FilteringSelect">
									<option value=""> </option>
									<option value="01"><xsl:value-of select="localization:getDecode(language, 'N004', '01')" /> </option>
									<option value="02"><xsl:value-of select="localization:getDecode(language, 'N004', '02')" /> </option>
									<option value="03"><xsl:value-of select="localization:getDecode(language, 'N004', '03')" /> </option>
									<option value="04"><xsl:value-of select="localization:getDecode(language, 'N004', '04')" /> </option>
									<option value="07"><xsl:value-of select="localization:getDecode(language, 'N004', '07')" /> </option>
									<option value="09"><xsl:value-of select="localization:getDecode(language, 'N004', '09')" /> </option>
								</select>
							</div>
							<div id="searchSubmitButton_row" class="field">
								<label for="searchSubmitButton"></label>
								<button dojoType="dijit.form.Button" id="searchSubmitButton" onClick="misys.grid.setListKey(dijit.byId('gridBulkTransaction'));" type="submit">
									<xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_SEARCH')"/>
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
				<p/>
				<div>
					<script type="text/javascript">
						var gridLayoutBulkTransaction, pluginsData;
						dojo.ready(function(){
					    	gridLayoutBulkTransaction = {"cells" : [ 
					                  [{ "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'REFERENCEID')"/>", "field": "ref_id", "width": "10em", "styles":"white-space:prewrap;text-align: center;", "headerStyles":"white-space:prewrap;"},

					                   <xsl:if test="child_sub_product_code!='TPT' and child_sub_product_code!='INT' and child_sub_product_code!='HVPS'and child_sub_product_code!= 'HVXB' and child_sub_product_code!= 'MUPS' and child_sub_product_code!= 'MEPS' and child_sub_product_code!= 'RTGS' and child_sub_product_code!='MT103'">
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'HEADER_BANK_CODE')"/>", "field": "Counterparty@cpty_bank_code", "width": "12%", "styles":"white-space:prewrap;text-align: center;", "headerStyles":"white-space:prewrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'HEADER_BRANCH_CODE')"/>", "field": "Counterparty@cpty_branch_code", "width": "12%", "styles":"white-space:prewrap;text-align: center;", "headerStyles":"white-space:prewrap;"},
					                   </xsl:if>
					                   <xsl:if test="child_sub_product_code [.='MUPS']">
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'HEADER_IFSC_CODE')"/>", "field": "Counterparty@cpty_bank_swift_bic_code", "width": "15%", "styles":"white-space:prewrap;text-align: center;", "headerStyles":"white-space:prewrap;"},
					                   </xsl:if>
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'ACCOUNTNO')"/>", "field": "Counterparty@counterparty_act_no", "width": "20%", "styles":"white-space:prewrap;", "headerStyles":"white-space:prewrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'BENEFICIARY_NAME')"/>", "field": "Counterparty@counterparty_name", "width": "28%", "styles":"white-space:prewrap;", "headerStyles":"white-space:prewrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'CURCODE')"/>", "field": "ft_cur_code", "width": "4em", "styles":"text-align: center;white-space:prewrap;", "headerStyles":"white-space:prewrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'AMOUNT')"/>", "field": "ft_amt", "width": "15%", "styles":"text-align: right;", "headerStyles":"white-space:prewrap;text-align: center"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'STATUS')"/>", "field": "status", "width": "10%", "styles":"text-align: center;", "headerStyles":"white-space:prewrap;text-align: center"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'PRODUCT_STATUS')"/>", "field": "prod_stat_code", "width": "10%", "styles":"text-align: center;", "headerStyles":"white-space:prewrap;text-align: center"}
					                   <xsl:if test="$displaymode='edit'">
					                   		,{ "noresize":"true", "name": "&nbsp;", "field": "action", "width": "5em", "styles": "text-align:center;", "headerStyles": "text-align: center", "get":misys.grid.getActions, "formatter": misys.grid.formatActions}
					                    ]
					                   </xsl:if>
					                  <xsl:if test="$displaymode!='edit'">
					                   		,{ "noresize":"true", "name": "&nbsp;", "field": "transaction_detail_view", "width": "6em", "styles": "text-align:center;", "headerStyles": "text-align: center","get":misys.grid.getActions,"formatter": misys.grid.formatActions}
					                   ]
					                   </xsl:if>
					              ]};
							pluginsData = {indirectSelection: {headerSelector: "true",width: "30px",styles: "text-align: center;"}, paginationEnhanced: {pageSizes: ["10","25","50","100"], description: true, sizeSwitch: true, pageStepper: true, gotoButton: true, maxPageStep: 7, position: " top "}}						
						});
					</script>
		
					<div style="width:100%;height:100%;" class="widgetContainer clear">
						<div dojoType="dojox.data.QueryReadStore" jsId="storeBulkTransaction" requestMethod="post">
							<xsl:attribute name="url">
								<xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/AjaxScreen/action/GetJSONData?listdef=core/listdef/customer/BK/listTransactionsInBK.xml&amp;bulk_ref_id=<xsl:value-of select='ref_id'/>&amp;bulk_tnx_id=<xsl:value-of select='tnx_id'/>&amp;bk_type=<xsl:value-of select='bk_type'/>&amp;payroll_type=<xsl:value-of select='payroll_type'/>
							</xsl:attribute>
						</div>
						<!--  When bulk is is draft (01) allow to move items else do not show selection for child transaction -->
					<xsl:choose>

					 <xsl:when test="tnx_stat_code[.='01'] and $mode='DRAFT' and  $displaymode = 'edit' and (not(bulk_copy_access) or (bulk_copy_access[.='true'])) and child_sub_product_code[.!='DOM']">
						<table rowsPerPage="50" 
							plugins="pluginsData" 
							canSort="misys.grid.noSortOnSeventhColumn"
							store="storeBulkTransaction" structure="gridLayoutBulkTransaction" class="grid" 
							autoHeight="true" id="gridBulkTransaction" dojoType="dojox.grid.EnhancedGrid" 
							noDataMessage="{localization:getGTPString($language, 'TABLE_NO_DATA')}" selectionMode="multiple" selectable="true" 
							escapeHTMLInData="true" loadingMessage="{localization:getGTPString($language, 'TABLE_LOADING_RECORDS_LIST')}" >
							<thead>
								<tr></tr>
							</thead>
							<tfoot>
								<tr><td></td></tr>
							</tfoot>
							<tbody>
								<tr><td></td></tr>
							</tbody>
						</table>
					</xsl:when>
					 <xsl:when test="tnx_stat_code[.='01'] and $mode='DRAFT' and  $displaymode = 'edit' and (not(bulk_copy_access) or (bulk_copy_access[.='true']))">
						<table rowsPerPage="50" 
							plugins="pluginsData" 
							canSort="misys.grid.noSortOnNinthColumn"
							store="storeBulkTransaction" structure="gridLayoutBulkTransaction" class="grid" 
							autoHeight="true" id="gridBulkTransaction" dojoType="dojox.grid.EnhancedGrid" 
							noDataMessage="{localization:getGTPString($language, 'TABLE_NO_DATA')}" selectionMode="multiple" selectable="true" 
							escapeHTMLInData="true" loadingMessage="{localization:getGTPString($language, 'TABLE_LOADING_RECORDS_LIST')}" >
							<thead>
								<tr></tr>
							</thead>
							<tfoot>
								<tr><td></td></tr>
							</tfoot>
							<tbody>
								<tr><td></td></tr>
							</tbody>
						</table>
					</xsl:when>
					<xsl:when test=" $displaymode = 'view' and child_sub_product_code[.!='DOM']">
					    <table rowsPerPage="50" 
							plugins="pluginsData" 
							canSort="misys.grid.noSortOnSixthColumn"
							store="storeBulkTransaction" structure="gridLayoutBulkTransaction" class="grid" 
							autoHeight="true" id="gridBulkTransaction" dojoType="dojox.grid.EnhancedGrid" 
							noDataMessage="{localization:getGTPString($language, 'TABLE_NO_DATA')}" selectionMode="none" selectable="true" 
							escapeHTMLInData="true" loadingMessage="{localization:getGTPString($language, 'TABLE_LOADING_RECORDS_LIST')}" >
							<thead>
								<tr></tr>
							</thead>
							<tfoot>
								<tr><td></td></tr>
							</tfoot>
							<tbody>
								<tr><td></td></tr>
							</tbody>
						</table>
					</xsl:when>
					<xsl:otherwise>
					    <table rowsPerPage="50" 
							plugins="pluginsData" 
							canSort="misys.grid.noSortOnAllColumns"
							store="storeBulkTransaction" structure="gridLayoutBulkTransaction" class="grid" 
							autoHeight="true" id="gridBulkTransaction" dojoType="dojox.grid.EnhancedGrid" 
							noDataMessage="{localization:getGTPString($language, 'TABLE_NO_DATA')}" selectionMode="none" selectable="true" 
							escapeHTMLInData="true" loadingMessage="{localization:getGTPString($language, 'TABLE_LOADING_RECORDS_LIST')}" >
							<thead>
								<tr></tr>
							</thead>
							<tfoot>
								<tr><td></td></tr>
							</tfoot>
							<tbody>
								<tr><td></td></tr>
							</tbody>
						</table>
					</xsl:otherwise>
					</xsl:choose>
						<div class="clear" style="height:1px">&nbsp;</div>
					</div>
				</div>
			</div>
	</xsl:template>
	<xsl:template name="move-items-button">
    <div id="move-items" class="widgetContainer">
    <xsl:variable name="se_ref_id" select='upload_file_id'></xsl:variable>
    <xsl:variable name="mergeanddemerge" select="utils:checkMergeDeMergeForSE($se_ref_id)"></xsl:variable>
     <xsl:variable name="amendable" select="utils:getAmendable($se_ref_id)"></xsl:variable>
    <xsl:choose>
    <xsl:when test="$mergeanddemerge = 'true'"> <!-- unchecked -->
      <xsl:call-template name="button-wrapper">
	         <xsl:with-param name="label">XSL_ACTION_MOVE</xsl:with-param>
	         <xsl:with-param name="id" >move_button_id</xsl:with-param>
	         <xsl:with-param name="show-text-label">Y</xsl:with-param>
	         <xsl:with-param name="onclick">misys.moveItems('gridBulkTransaction')</xsl:with-param>
	  </xsl:call-template>
	  </xsl:when>
	  <xsl:otherwise>
	  <xsl:choose>
	  <xsl:when test="$amendable = 'true'">
	  <xsl:call-template name="button-wrapper">
	         <xsl:with-param name="label">XSL_ACTION_MOVE</xsl:with-param>
	         <xsl:with-param name="id" >move_button_id</xsl:with-param>
	         <xsl:with-param name="show-text-label">Y</xsl:with-param>
	         <xsl:with-param name="onclick">misys.moveItems('gridBulkTransaction')</xsl:with-param>
	  </xsl:call-template>
	  </xsl:when>
	  </xsl:choose>
	  </xsl:otherwise>
	  </xsl:choose>
    </div>
   </xsl:template>
   <xsl:template name="move-items-new-bulk-button">
    <div id="move-items-new-bulk" class="widgetContainer">
      <xsl:call-template name="button-wrapper">
	         <xsl:with-param name="label">XSL_MOVE_ITEMS_TO_NEW_BULK</xsl:with-param>
	         <xsl:with-param name="id" >move_item_new_bulk_button_id</xsl:with-param>
	         <xsl:with-param name="show-text-label">Y</xsl:with-param>
	         <xsl:with-param name="onclick">misys.moveItemsToNewBulk('gridBulkTransactionForDemerge')</xsl:with-param>
	  </xsl:call-template>
    </div>
   </xsl:template>
   
   	<xsl:template name="bk_type_options">
	   <xsl:variable name="bkType"><xsl:value-of select="bk_type"/></xsl:variable>
	   <xsl:choose>
	    <xsl:when test="$displaymode='edit'">
		     <xsl:for-each select="avail_products/product[product_code='BK']/bktype">
	      		<option>
	      			<xsl:attribute name="value"><xsl:value-of select="./code"/></xsl:attribute>
			       	<xsl:value-of select="./description"/>
			    </option>
	      	 </xsl:for-each>
	    </xsl:when>
	    <xsl:otherwise>
	      	<xsl:value-of select="avail_products/product[product_code='BK']/bktype[code=$bkType]/description"></xsl:value-of>
	    </xsl:otherwise>
	   </xsl:choose>
   </xsl:template>
   <xsl:template match="payroll_type">
	 	<option>
			<xsl:attribute name="value"><xsl:value-of select="./code"/></xsl:attribute>
			<xsl:value-of select="./desc"/>
		</option>
	</xsl:template>
	
   <xsl:template name="payroll_type_options">
   	   <xsl:variable name="payrollType"><xsl:value-of select="payroll_type"/></xsl:variable>
	   <xsl:choose>
		    <xsl:when test="$displaymode='edit'">
			     <xsl:for-each select="avail_products/product[product_code='BK']/bktype[code='PAYRL']/payroll_type">
		      		<option>
		      			<xsl:attribute name="value"><xsl:value-of select="./code"/></xsl:attribute>
				       	<xsl:value-of select="./description"/>
				    </option>
		      	 </xsl:for-each>
		    </xsl:when>
		    <xsl:otherwise>
		      	<xsl:value-of select="avail_products/product[product_code='BK']/bktype[code='PAYRL']/payroll_type[code=$payrollType]/description"></xsl:value-of>
		    </xsl:otherwise>
	   </xsl:choose>
   </xsl:template>
   <!--  Grid to show list of destination/eligible  bulks for demerge -->
   <xsl:template name="topic-eligible-bulk-grid">
		<p>&nbsp;</p>
		<div id="transactionGridContainer" class="widgetContainer">
			<div>
				<xsl:call-template name="animatedFieldSetHeader">
			   		<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_HELPSEARCH_OPTIONS')"/></xsl:with-param>
			   		<xsl:with-param name="animateDivId">searchCriteria</xsl:with-param>
			   		<xsl:with-param name="prefix">searchCriteria</xsl:with-param>
			   		<xsl:with-param name="show">N</xsl:with-param>
			   	</xsl:call-template>
				<div>
				  <xsl:attribute name="id">searchCriteria</xsl:attribute>
					<xsl:attribute name="style">
					   display:none;width:100%;padding-left:5px;
				   </xsl:attribute> 
					<div class="widgetContainer clear">
						<small><xsl:value-of select="localization:getGTPString($language, 'LIST_HELP_SDATA')"/></small>
						<div name="TransactionSearchForm" id="TransactionSearchForm" dojoType="dijit.form.Form">
							<div id="search_ref_id_row" class="field">
								<label for="search_ref_id"><xsl:value-of select="localization:getGTPString($language, 'REFERENCEID_LABEL')"/></label>
								<input trim="true" style="width: 14em" class="medium" id="search_ref_id" name="search_ref_id" dojoType="dijit.form.TextBox" maxlength="20" value="" size="14" />
							</div>
							<div id="upload_file_id_row" class="field">
								<label for="upload_file_id"><xsl:value-of select="localization:getGTPString($language, 'FILE_REF_ID')"/></label>
								<input trim="true" style="width: 14em" class="medium" id="upload_file_id" name="upload_file_id" dojoType="dijit.form.TextBox" maxlength="20" value="" size="14" />
							</div>
							<div id="bulk_reference_row" class="field">
								<label for="bulk_reference"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BULK_REF_ID')"/></label>
								<input trim="true" style="width: 14em" class="medium" id="bulk_reference" name="bulk_reference" dojoType="dijit.form.TextBox" maxlength="20" value="" size="14" />
							</div>
							<div id="searchSubmitButton_row" class="field">
								<label for="searchSubmitButton"></label>
								<button dojoType="dijit.form.Button" id="searchSubmitButton" onClick="misys.grid.setListKey(dijit.byId('gridBulkTransactionForDemerge'));" type="submit">
									<xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_SEARCH')"/>
								</button>
							</div>
							<!--  Hidden fields values of which will always be in where clause -->
							<div>
								<input type="hidden" name="bk_type" id="search_bk_type" value="{bk_type}" dojoType="dijit.form.TextBox"/>
								<input type="hidden" name="payroll_type" id="search_payroll_type" value="{payroll_type}" dojoType="dijit.form.TextBox"/>
								<input type="hidden" name="child_sub_product_code" id="search_child_sub_product_code" value="{child_sub_product_code}" dojoType="dijit.form.TextBox"/>
								<input type="hidden" name="applicant_act_no" id="search_applicant_act_no" value="{applicant_act_no}" dojoType="dijit.form.TextBox"/>
								<input type="hidden" name="value_date" id="search_value_date" value="{value_date}" dojoType="dijit.form.TextBox"/>
								<input type="hidden" name="current_bulk_ref_id" id="search_current_bulk_ref_id" value="{ref_id}" dojoType="dijit.form.TextBox"/>
							</div>
						</div>
					</div>
				</div>
			</div>
				<p/>
				<div>
					<script type="text/javascript">
						var gridLayoutBulkTransaction, pluginsData;
						dojo.ready(function(){
					    	gridLayoutBulkTransaction = {"cells" : [
					                  [{ "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'REFERENCEID')"/>", "field": "ref_id", "width": "15%", "styles":"white-space:prewrap;text-align: center;", "headerStyles":"white-space:prewrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'FILE_REF_ID')"/>", "field": "upload_file_id", "width": "10%", "styles":"white-space:prewrap;text-align: center;", "headerStyles":"white-space:prewrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'HEADER_BULK_CUST_REFERENCE')"/>", "field": "cust_ref_id", "width": "10%", "styles":"white-space:prewrap;text-align: center;", "headerStyles":"white-space:prewrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'HEADER_VALUE_DATE')"/>", "field": "value_date", "width": "15%", "styles":"white-space:prewrap;", "headerStyles":"white-space:prewrap;"}]
					              ]};
							pluginsData = {indirectSelection: {headerSelector: "true",width: "3%",styles: "text-align: center;"}, paginationEnhanced: {pageSizes: ["10","25","50","100"], description: true, sizeSwitch: true, pageStepper: true, gotoButton: true, maxPageStep: 7, position: " top "}}						
						});
					</script>
		
					<div style="width:100%;height:100%;" class="widgetContainer clear">
						<div dojoType="dojox.data.QueryReadStore" jsId="storeBulkTransaction" requestMethod="post">
							<xsl:attribute name="url">
								<xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/AjaxScreen/action/GetJSONData?listdef=core/listdef/customer/BK/listEligibleBKForDemerge.xml&amp;bk_type=<xsl:value-of select='bk_type'/>&amp;uploaded_file_id=<xsl:value-of select='uploaded_file_id'/>&amp;payroll_type=<xsl:value-of select='payroll_type'/>&amp;child_sub_product_code=<xsl:value-of select='child_sub_product_code'/>&amp;value_date=<xsl:value-of select="value_date"/>&amp;applicant_act_no=<xsl:value-of select="applicant_act_no"/>&amp;current_bulk_ref_id=<xsl:value-of select="ref_id"/>
							</xsl:attribute>
						</div>
						<!--  When bulk is is draft (01) allow to move items else do not show selection for child transaction -->
	
					    <table rowsPerPage="50" 
							plugins="pluginsData" 
							store="storeBulkTransaction" structure="gridLayoutBulkTransaction" class="grid" 
							autoHeight="true" id="gridBulkTransactionForDemerge" dojoType="dojox.grid.EnhancedGrid" 
							noDataMessage="{localization:getGTPString($language, 'TABLE_NO_DATA')}" selectionMode="single" selectable="true" 
							escapeHTMLInData="true" loadingMessage="{localization:getGTPString($language, 'TABLE_LOADING_RECORDS_LIST')}" >
							<thead>
								<tr></tr>
							</thead>
							<tfoot>
								<tr><td></td></tr>
							</tfoot>
							<tbody>
								<tr><td></td></tr>
							</tbody>
						</table>
						<div class="clear" style="height:1px">&nbsp;</div>
					</div>
				</div>
			</div>
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
	
	<!-- TO be removed after completion of new bulk feature. -->
	<!-- Grid for Bulk Invoice Financing -->
	<!-- <xsl:template name="bulk-invoice-grid">
		<xsl:param name="product"/>
		<p>&nbsp;</p>
		<div id="invoiceGridContainer" class="widgetContainer">
			<div>
				<xsl:call-template name="animatedFieldSetHeader">
			   		<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_HELPSEARCH_OPTIONS')"/></xsl:with-param>
			   		<xsl:with-param name="animateDivId">searchCriteria</xsl:with-param>
			   		<xsl:with-param name="prefix">searchCriteria</xsl:with-param>
			   		<xsl:with-param name="show">N</xsl:with-param>
			   	</xsl:call-template>
				<div>
				  <xsl:attribute name="id">searchCriteria</xsl:attribute>
					<xsl:attribute name="style">display:none;width:100%;padding-left:5px; </xsl:attribute>
					<div class="widgetContainer clear">
						<div name="TransactionSearchForm" id="TransactionSearchForm" dojoType="dijit.form.Form">
							<div id="search_ref_id_row" class="field">
								<label for="search_ref_id"><xsl:value-of select="localization:getGTPString($language, 'REFERENCEID_LABEL')"/></label>
								<input trim="true" style="width: 14em" class="medium" id="search_ref_id" name="search_ref_id" dojoType="dijit.form.TextBox" maxlength="20" value="" size="14" />
							</div>
							<xsl:choose>
								<xsl:when test="entities and entities = '1'">
									<div id="entity_row" class="field">
										<span class="label"><xsl:value-of select="localization:getGTPString($language, 'ENTITY_LABEL')"/></span>
										<div class="content" id="display_entity"><xsl:value-of select="entity"/></div> 
									</div>
								</xsl:when>
								<xsl:when test="entities and entities > '1'">
									<div id="entity_row" class="field">
										<xsl:call-template name="entity-field">
									    <xsl:with-param name="required">N</xsl:with-param>
									    <xsl:with-param name="readonly">N</xsl:with-param>
									    <xsl:with-param name="button-type">entity</xsl:with-param>
									    <xsl:with-param name="prefix">applicant</xsl:with-param>
								    </xsl:call-template> 
									</div>
								</xsl:when>
							</xsl:choose>
							<div id="buyer_name_row" class="field">
								<label for="buyer_name"><xsl:value-of select="localization:getGTPString($language, 'BUYER_NAME_LABEL')"/></label>
								<input trim="true" style="width: 14em" class="medium" id="buyer_name" name="buyer_name" dojoType="dijit.form.TextBox" maxlength="35" value="" size="35" />
							</div>
							<div id="total_cur_code_row" class="field">
								<xsl:call-template name="currency-field">
									<xsl:with-param name="label">CURCODE</xsl:with-param>
									<xsl:with-param name="product-code">total</xsl:with-param>
									<xsl:with-param name="override-currency-name">total_cur_code</xsl:with-param>
									<xsl:with-param name="required">
										<xsl:choose>
											<xsl:when test="amount_from != '' or amount_to !=''">Y</xsl:when>
											<xsl:otherwise>N</xsl:otherwise>
										</xsl:choose>
									</xsl:with-param>
									<xsl:with-param name="show-amt">N</xsl:with-param>
									<xsl:with-param name="currency-readonly">N</xsl:with-param>
									<xsl:with-param name="show-button">Y</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="hidden-field">
									<xsl:with-param name="name">amount_from_cur</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="hidden-field">
									<xsl:with-param name="name">amount_to_cur</xsl:with-param>
								</xsl:call-template>
							</div>
							<div id="amount_row" class="field">
								<label for="amount_from"><xsl:value-of select="localization:getGTPString($language, 'AmountFrom')"/></label>
								<input trim="true" style="width: 10em" class="small" id="amount_from" name="amount_from" dojoType="dijit.form.CurrencyTextBox" maxlength="35" value="" size="10" />

								<label for="amount_to"><xsl:value-of select="localization:getGTPString($language, 'AmountTo')"/></label>
								<input trim="true" style="width: 10em" class="small" id="amount_to" name="amount_to" dojoType="dijit.form.CurrencyTextBox" maxlength="35" value="" size="10" />
							</div>
							<div id="invoice_date_row" class="field">
								<label for="invoice_date_from"><xsl:value-of select="localization:getGTPString($language, 'INVOICE_DATE_FROM')"/></label>
								<input trim="true" style="width: 10em" class="small" id="invoice_date_from" name="invoice_date_from" dojoType="dijit.form.DateTextBox" maxlength="35" value="" size="35" />
								
								<label for="invoice_date_to"><xsl:value-of select="localization:getGTPString($language, 'INVOICE_DATE_TO')"/></label>
								<input trim="true" style="width: 10em" class="small" id="invoice_date_to" name="invoice_date_to" dojoType="dijit.form.DateTextBox" maxlength="35" value="" size="35" />
							</div>
							<div id="invoice_due_date_row" class="field">
								<label for="invoice_due_date_from"><xsl:value-of select="localization:getGTPString($language, 'INVOICE_DUE_DATE_FROM')"/></label>
								<input trim="true" style="width: 10em" class="small" id="invoice_due_date_from" name="invoice_due_date_from" dojoType="dijit.form.DateTextBox" maxlength="35" value="" size="35" />
								
								<label for="invoice_due_date_to"><xsl:value-of select="localization:getGTPString($language, 'INVOICE_DUE_DATE_TO')"/></label>
								<input trim="true" style="width: 10em" class="small" id="invoice_due_date_to" name="invoice_due_date_to" dojoType="dijit.form.DateTextBox" maxlength="35" value="" size="35" />
							</div>
							<xsl:call-template name="hidden-field">
					    		<xsl:with-param name="name">appl_date</xsl:with-param>
					    	</xsl:call-template>
							<div id="searchSubmitButton_row" class="field">
								<label for="searchSubmitButton"></label>
								<button dojoType="dijit.form.Button" id="searchSubmitButton" onClick="misys.grid.setListKey(dijit.byId('gridBulkTransaction'));" type="submit">
									<xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_SEARCH')"/>
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
				<p/>
				<div>
					<xsl:call-template name="hidden-field">
				    	<xsl:with-param name="name">ref_id</xsl:with-param>
				   	</xsl:call-template>
					<xsl:call-template name="fieldset-wrapper">
						<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
							<xsl:with-param name="content">
								<xsl:call-template name="column-container">
									<xsl:with-param name="content">
										<xsl:call-template name="column-wrapper">
											<xsl:with-param name="content">
												<xsl:call-template name="input-field">
													  <xsl:with-param name="label">XSL_BK_REF_ID</xsl:with-param>	
													  <xsl:with-param name="id">general_ref_id_view</xsl:with-param>
    												  <xsl:with-param name="value" select="ref_id" />
													  <xsl:with-param name="override-displaymode">view</xsl:with-param>
												</xsl:call-template>
											</xsl:with-param>
										</xsl:call-template>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
					</xsl:call-template>
					<xsl:choose>
						<xsl:when test="entities and entities = '1'">
							<div id="entity_row" class="field">
								<span class="label"><xsl:value-of select="localization:getGTPString($language, 'ENTITY_LABEL')"/></span>
								<div class="content" id="entity"><xsl:value-of select="entity"/></div> 
							</div>
						</xsl:when>
						<xsl:when test="entities and entities > '1'">
							<div id="entity_row" class="field">
								<xsl:call-template name="entity-field">
							    <xsl:with-param name="required">N</xsl:with-param>
							    <xsl:with-param name="readonly">N</xsl:with-param>
							    <xsl:with-param name="button-type">entity</xsl:with-param>
							    <xsl:with-param name="prefix">applicant</xsl:with-param>
						    </xsl:call-template> 
							</div>
						</xsl:when>
					</xsl:choose>
				</div>
				<div name="invoiceGridList" id="invoiceGridList">
					<script type="text/javascript">
						var gridLayoutBulkTransaction, pluginsData;
						dojo.ready(function(){
					    	gridLayoutBulkTransaction = {"cells" : [ 
					                  [{ "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'REFERENCEID')"/>", "field": "ref_id", "width": "10em", "styles":"white-space:prewrap;text-align: center;", "headerStyles":"white-space:prewrap;"},
					                  <xsl:if test="entities and entities > '0'">
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'ENTITY')"/>", "field": "entity", "width": "12%", "styles":"white-space:prewrap;text-align: center;", "headerStyles":"white-space:prewrap;"},
					                  </xsl:if>
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'PROGRAM_NAME')"/>", "field": "fscm_prog@program_name", "width": "12%", "styles":"white-space:prewrap;text-align: center;", "headerStyles":"white-space:prewrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'SELLER_NAME')"/>", "field": "seller_name", "width": "12%", "styles":"white-space:prewrap;text-align: center;", "headerStyles":"white-space:prewrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'BUYER_NAME')"/>", "field": "buyer_name", "width": "20%", "styles":"white-space:prewrap;", "headerStyles":"white-space:prewrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'CURCODE')"/>", "field": "total_net_cur_code", "width": "4em", "styles":"text-align: center;white-space:prewrap;", "headerStyles":"white-space:prewrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'AMOUNT')"/>", "field": "total_net_amt", "width": "15%", "styles":"text-align: right;", "headerStyles":"white-space:prewrap;text-align: center"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'OS_AMOUNT')"/>", "field": "liab_total_net_amt", "width": "15%", "styles":"text-align: right;", "headerStyles":"white-space:prewrap;text-align: center"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'INVOICE_DATE')"/>", "field": "iss_date", "width": "15%", "styles":"text-align: right;", "headerStyles":"white-space:prewrap;text-align: center"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'INVOICE_DUE_DATE')"/>", "field": "due_date", "width": "15%", "styles":"text-align: right;", "headerStyles":"white-space:prewrap;text-align: center"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'STATUS')"/>", "field": "prod_stat_code", "width": "10%", "styles":"text-align: center;", "headerStyles":"white-space:prewrap;text-align: center"}]
					                  
					              ]};
							pluginsData = {indirectSelection: {headerSelector: "true",width: "30px",styles: "text-align: center;"}, paginationEnhanced: {pageSizes: ["10","25","50","100"], description: true, sizeSwitch: true, pageStepper: true, gotoButton: true, maxPageStep: 7, position: " top "}}						
						});
					</script>
		
					<div style="width:100%;height:100%;" class="widgetContainer clear">
						<div dojoType="dojox.data.QueryReadStore" jsId="storeBulkTransaction" requestMethod="post">
							<xsl:attribute name="url">
								<xsl:choose>
									<xsl:when test="$product = 'IN'">
										<xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/AjaxScreen/action/GetJSONData?listdef=openaccount/listdef/customer/IN/listInvoiceTransactionsInBK.xml&amp;search_ref_id=<xsl:value-of select='search_ref_id'/>
									</xsl:when>
								</xsl:choose>
							</xsl:attribute>
						</div>
					    <table rowsPerPage="50" 
							plugins="pluginsData" 
							store="storeBulkTransaction" structure="gridLayoutBulkTransaction" class="grid" 
							autoHeight="true" id="gridBulkTransaction" dojoType="dojox.grid.EnhancedGrid" 
							noDataMessage="{localization:getGTPString($language, 'TABLE_NO_DATA')}" selectionMode="none" selectable="true" 
							escapeHTMLInData="true" loadingMessage="{localization:getGTPString($language, 'TABLE_LOADING_RECORDS_LIST')}" >
							<thead>
								<tr></tr>
							</thead>
							<tfoot>
								<tr><td></td></tr>
							</tfoot>
							<tbody>
								<tr><td></td></tr>
							</tbody>
						</table>

						<div class="clear" style="height:1px">&nbsp;</div>
					</div>
				</div>
			</div>
	</xsl:template>
 -->	
	<xsl:template name="bulk-invoice-show-grid">
		<xsl:param name="product"/>
		<p>&nbsp;</p>
		<div id="invoiceGridContainer" class="widgetContainer">
			<div>
				<xsl:call-template name="animatedFieldSetHeader">
			   		<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_HELPSEARCH_OPTIONS')"/></xsl:with-param>
			   		<xsl:with-param name="animateDivId">searchCriteria</xsl:with-param>
			   		<xsl:with-param name="prefix">searchCriteria</xsl:with-param>
			   		<xsl:with-param name="show">N</xsl:with-param>
			   	</xsl:call-template>
				<div>
				  <xsl:attribute name="id">searchCriteria</xsl:attribute>
					<xsl:attribute name="style">display:none;width:100%;padding-left:5px; </xsl:attribute>
					<div class="widgetContainer clear">
						<div name="TransactionSearchForm" id="TransactionSearchForm" dojoType="dijit.form.Form">
							<div id="search_ref_id_row" class="field">
								<label for="search_ref_id"><xsl:value-of select="localization:getGTPString($language, 'REFERENCEID_LABEL')"/></label>
								<input trim="true" style="width: 14em" class="medium" id="search_ref_id" name="search_ref_id" dojoType="dijit.form.TextBox" maxlength="20" value="" size="14" />
								
								<input type="hidden" name="bulk_ref_id" id="search_bulk_ref_id" value="{ref_id}" dojoType="dijit.form.TextBox"/>
								
							</div>
							<xsl:choose>
								<xsl:when test="entities and entities = '1'">
									<div id="entity_row" class="field">
										<span class="label"><xsl:value-of select="localization:getGTPString($language, 'ENTITY_LABEL')"/></span>
										<div class="content" id="display_entity"><xsl:value-of select="entity"/></div> 
									</div>
								</xsl:when>
								<xsl:when test="entities and entities > '1'">
									<div id="entity_row" class="field">
										<xsl:call-template name="entity-field">
									    <xsl:with-param name="required">N</xsl:with-param>
									    <xsl:with-param name="readonly">N</xsl:with-param>
									    <xsl:with-param name="button-type">entity</xsl:with-param>
									    <xsl:with-param name="prefix">applicant</xsl:with-param>
								    </xsl:call-template> 
									</div>
								</xsl:when>
							</xsl:choose>
							<div id="buyer_name_row" class="field">
								<label for="buyer_name"><xsl:value-of select="localization:getGTPString($language, 'BUYER_NAME_LABEL')"/></label>
								<input trim="true" style="width: 14em" class="medium" id="buyer_name" name="buyer_name" dojoType="dijit.form.TextBox" maxlength="35" value="" size="35" />
							</div>
							<xsl:if test="$displaymode = 'edit'">
								<div id="total_cur_code_row" class="field">
									<xsl:call-template name="currency-field">
										<xsl:with-param name="label">CURCODE</xsl:with-param>
										<xsl:with-param name="product-code">total</xsl:with-param>
										<xsl:with-param name="override-currency-name">total_cur_code</xsl:with-param>									
										<xsl:with-param name="required">
											<xsl:choose>
												<xsl:when test="amount_from != '' or amount_to !=''">Y</xsl:when>
												<xsl:otherwise>N</xsl:otherwise>
											</xsl:choose>
										</xsl:with-param>
										<xsl:with-param name="show-amt">N</xsl:with-param>
										<xsl:with-param name="currency-readonly">N</xsl:with-param>
										<xsl:with-param name="show-button">Y</xsl:with-param>									
									</xsl:call-template>
									<xsl:call-template name="hidden-field">
										<xsl:with-param name="name">amount_from_cur</xsl:with-param>
									</xsl:call-template>
									<xsl:call-template name="hidden-field">
										<xsl:with-param name="name">amount_to_cur</xsl:with-param>
									</xsl:call-template>
								</div>
							</xsl:if>
							<div id="amount_row" class="field">
								<label for="amount_from"><xsl:value-of select="localization:getGTPString($language, 'FinAmountFrom')"/></label>
								<input trim="true" style="width: 10em" class="small" id="AmountRange" name="AmountRange" dojoType="dijit.form.CurrencyTextBox" maxlength="35" value="" size="10" />
								<label for="amount_to"><xsl:value-of select="localization:getGTPString($language, 'FinAmountTo')"/></label>
								<input trim="true" style="width: 10em" class="small" id="AmountRange2" name="AmountRange2" dojoType="dijit.form.CurrencyTextBox" maxlength="35" value="" size="10" />
							</div>
							<div id="invoice_date_row" class="field">
								<label for="invoice_date_from"><xsl:value-of select="localization:getGTPString($language, 'INVOICE_DATE_FROM')"/></label>
								<input trim="true" style="width: 10em" class="small" id="invoice_date_from" name="invoice_date_from" dojoType="dijit.form.DateTextBox" maxlength="35" value="" size="35" />
								
								<label for="invoice_date_to"><xsl:value-of select="localization:getGTPString($language, 'INVOICE_DATE_TO')"/></label>
								<input trim="true" style="width: 10em" class="small" id="invoice_date_to" name="invoice_date_to" dojoType="dijit.form.DateTextBox" maxlength="35" value="" size="35" />
							</div>
							<div id="invoice_due_date_row" class="field">
								<label for="invoice_due_date_from"><xsl:value-of select="localization:getGTPString($language, 'INVOICE_DUE_DATE_FROM')"/></label>
								<input trim="true" style="width: 10em" class="small" id="invoice_due_date_from" name="invoice_due_date_from" dojoType="dijit.form.DateTextBox" maxlength="35" value="" size="35" />
								
								<label for="invoice_due_date_to"><xsl:value-of select="localization:getGTPString($language, 'INVOICE_DUE_DATE_TO')"/></label>
								<input trim="true" style="width: 10em" class="small" id="invoice_due_date_to" name="invoice_due_date_to" dojoType="dijit.form.DateTextBox" maxlength="35" value="" size="35" />
							</div>
							<div id="searchSubmitButton_row" class="field">
								<label for="searchSubmitButton"></label>
								<button dojoType="dijit.form.Button" id="searchSubmitButton" onClick="misys.grid.setListKey(dijit.byId('gridBulkTransaction'));" type="submit">
									<xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_SEARCH')"/>
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
				<p/>
				<div name="invoiceGridList" id="invoiceGridList">
					<script type="text/javascript">
						var gridLayoutBulkTransaction, pluginsData;
						dojo.ready(function(){
					    	gridLayoutBulkTransaction = {"cells" : [ 
					                  [{ "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'REFERENCEID')"/>", "field": "ref_id", "width": "10%", "styles":"white-space:prewrap;text-align: center;", "headerStyles":"white-space:prewrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'INVOICE_REFERENCE_LABEL')"/>", "field": "issuer_ref_id", "width": "10%", "styles":"white-space:prewrap;text-align: center;", "headerStyles":"white-space:prewrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'PROGRAM_NAME')"/>", "field": "fscm_prog@program_name", "width": "15%", "styles":"white-space:prewrap;text-align: center;", "headerStyles":"white-space:prewrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'SELLER_NAME')"/>", "field": "seller_name", "width": "10%", "styles":"white-space:prewrap;text-align: center;", "headerStyles":"white-space:prewrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'BUYER_NAME')"/>", "field": "buyer_name", "width": "10%", "styles":"white-space:prewrap;", "headerStyles":"white-space:prewrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'CURCODE')"/>", "field": "total_net_cur_code", "width": "5%", "styles":"text-align: center;white-space:prewrap;", "headerStyles":"white-space:prewrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'INVOICE_AMOUNT')"/>", "field": "total_net_amt", "width": "5%", "styles":"text-align: right;", "headerStyles":"white-space:prewrap;text-align: center"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'FINANCED_AMNT')"/>", "field": "finance_amt", "width": "5%", "styles":"text-align: right;", "headerStyles":"white-space:prewrap;text-align: center"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'OS_AMOUNT')"/>", "field": "liab_total_net_amt", "width": "5%", "styles":"text-align: right;", "headerStyles":"white-space:prewrap;text-align: center"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'INVOICE_DATE')"/>", "field": "iss_date", "width": "8%", "styles":"text-align: right;", "headerStyles":"white-space:prewrap;text-align: center"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'INVOICE_DUE_DATE')"/>", "field": "due_date", "width": "8%", "styles":"text-align: right;", "headerStyles":"white-space:prewrap;text-align: center"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'STATUS')"/>", "field": "prod_stat_code", "width": "15%", "styles":"text-align: center;", "headerStyles":"white-space:prewrap;text-align: center"}
					                   <!-- { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'FIN_REQUESTED_PERCENT1')"/>", "field":"inv_eligible_pct", "width": "4%", "styles":"text-align: center;", "headerStyles":"white-space:prewrap;text-align: center"} -->]
					                  
					              ]};
							pluginsData = {indirectSelection: {headerSelector: "true",width: "30px",styles: "text-align: center;"}, paginationEnhanced: {pageSizes: ["10","25","50","100"], description: true, sizeSwitch: true, pageStepper: true, gotoButton: true, maxPageStep: 7, position: " top "}}						
						});
					</script>
		
					<div style="width:100%;height:100%;" class="widgetContainer clear">
						<div dojoType="dojox.data.QueryReadStore" jsId="storeBulkTransaction" requestMethod="post">
							<xsl:attribute name="url">
										<xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/AjaxScreen/action/GetJSONData?listdef=openaccount/listdef/customer/IN/showInvoiceTransactionsInBK.xml&amp;bulk_ref_id=<xsl:value-of select='ref_id'/>
							</xsl:attribute>
						</div>
					    <table rowsPerPage="50" 
							plugins="pluginsData" 
							store="storeBulkTransaction" structure="gridLayoutBulkTransaction" class="grid" 
							autoHeight="true" id="gridBulkTransaction" dojoType="dojox.grid.EnhancedGrid" 
							noDataMessage="{localization:getGTPString($language, 'TABLE_NO_DATA')}" selectionMode="none" selectable="true" 
							escapeHTMLInData="true" loadingMessage="{localization:getGTPString($language, 'TABLE_LOADING_RECORDS_LIST')}" >
							<thead>
								<tr></tr>
							</thead>
							<tfoot>
								<tr><td></td></tr>
							</tfoot>
							<tbody>
								<tr><td></td></tr>
							</tbody>
						</table>

						<div class="clear" style="height:1px">&nbsp;</div>
					</div>
				</div>
			</div>
	</xsl:template>
	
	<xsl:template name="bulk-invoice-payable-show-grid">
		<xsl:param name="product"/>
		<p>&nbsp;</p>
		<div id="invoiceGridContainer" class="widgetContainer">
			<div>
				<xsl:call-template name="animatedFieldSetHeader">
			   		<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_HELPSEARCH_OPTIONS')"/></xsl:with-param>
			   		<xsl:with-param name="animateDivId">searchCriteria</xsl:with-param>
			   		<xsl:with-param name="prefix">searchCriteria</xsl:with-param>
			   		<xsl:with-param name="show">N</xsl:with-param>
			   	</xsl:call-template>
				<div>
				  <xsl:attribute name="id">searchCriteria</xsl:attribute>
					<xsl:attribute name="style">display:none;width:100%;padding-left:5px; </xsl:attribute>
					<div class="widgetContainer clear">
						<div name="TransactionSearchForm" id="TransactionSearchForm" dojoType="dijit.form.Form">
							<div id="search_ref_id_row" class="field">
								<label for="search_ref_id"><xsl:value-of select="localization:getGTPString($language, 'REFERENCEID_LABEL')"/></label>
								<input trim="true" style="width: 14em" class="medium" id="search_ref_id" name="search_ref_id" dojoType="dijit.form.TextBox" maxlength="20" value="" size="14" />
								
								<input type="hidden" name="bulk_ref_id" id="search_bulk_ref_id" value="{ref_id}" dojoType="dijit.form.TextBox"/>
								
							</div>
							<xsl:choose>
								<xsl:when test="entities and entities = '1'">
									<div id="entity_row" class="field">
										<span class="label"><xsl:value-of select="localization:getGTPString($language, 'ENTITY_LABEL')"/></span>
										<div class="content" id="display_entity"><xsl:value-of select="entity"/></div> 
									</div>
								</xsl:when>
								<xsl:when test="entities and entities > '1'">
									<div id="entity_row" class="field">
										<xsl:call-template name="entity-field">
									    <xsl:with-param name="required">N</xsl:with-param>
									    <xsl:with-param name="readonly">N</xsl:with-param>
									    <xsl:with-param name="button-type">entity</xsl:with-param>
									    <xsl:with-param name="prefix">applicant</xsl:with-param>
								    </xsl:call-template> 
									</div>
								</xsl:when>
							</xsl:choose>
							<div id="buyer_name_row" class="field">
								<label for="buyer_name"><xsl:value-of select="localization:getGTPString($language, 'BUYER_NAME_LABEL')"/></label>
								<input trim="true" style="width: 14em" class="medium" id="buyer_name" name="buyer_name" dojoType="dijit.form.TextBox" maxlength="35" value="" size="35" />
							</div>				
							<div id="amount_row" class="field">
								<label for="amount_from"><xsl:value-of select="localization:getGTPString($language, 'FinAmountFrom')"/></label>
								<input trim="true" style="width: 10em" class="small" id="AmountRange" name="AmountRange" dojoType="dijit.form.CurrencyTextBox" maxlength="35" value="" size="10" />

								<label for="amount_to"><xsl:value-of select="localization:getGTPString($language, 'FinAmountTo')"/></label>
								<input trim="true" style="width: 10em" class="small" id="AmountRange2" name="AmountRange2" dojoType="dijit.form.CurrencyTextBox" maxlength="35" value="" size="10" />
							</div> 
							<div id="invoice_date_row" class="field">
								<label for="invoice_date_from"><xsl:value-of select="localization:getGTPString($language, 'INVOICE_DATE_FROM')"/></label>
								<input trim="true" style="width: 10em" class="small" id="invoice_date_from" name="invoice_date_from" dojoType="dijit.form.DateTextBox" maxlength="35" value="" size="35" />
								
								<label for="invoice_date_to"><xsl:value-of select="localization:getGTPString($language, 'INVOICE_DATE_TO')"/></label>
								<input trim="true" style="width: 10em" class="small" id="invoice_date_to" name="invoice_date_to" dojoType="dijit.form.DateTextBox" maxlength="35" value="" size="35" />
							</div>
							<div id="invoice_due_date_row" class="field">
								<label for="invoice_due_date_from"><xsl:value-of select="localization:getGTPString($language, 'INVOICE_DUE_DATE_FROM')"/></label>
								<input trim="true" style="width: 10em" class="small" id="invoice_due_date_from" name="invoice_due_date_from" dojoType="dijit.form.DateTextBox" maxlength="35" value="" size="35" />
								
								<label for="invoice_due_date_to"><xsl:value-of select="localization:getGTPString($language, 'INVOICE_DUE_DATE_TO')"/></label>
								<input trim="true" style="width: 10em" class="small" id="invoice_due_date_to" name="invoice_due_date_to" dojoType="dijit.form.DateTextBox" maxlength="35" value="" size="35" />
							</div>
							<div id="searchSubmitButton_row" class="field">
								<label for="searchSubmitButton"></label>
								<button dojoType="dijit.form.Button" id="searchSubmitButton" onClick="misys.grid.setListKey(dijit.byId('gridBulkTransaction'));" type="submit">
									<xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_SEARCH')"/>
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
				<p/>
				<div name="invoiceGridList" id="invoiceGridList">
					<script type="text/javascript">
						var gridLayoutBulkTransaction, pluginsData;
						dojo.ready(function(){
					    	gridLayoutBulkTransaction = {"cells" : [ 
					                  [{ "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'REFERENCEID')"/>", "field": "ref_id", "width": "10%", "styles":"white-space:prewrap;text-align: center;", "headerStyles":"white-space:prewrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'INVOICE_REFERENCE_LABEL')"/>", "field": "issuer_ref_id", "width": "10%", "styles":"white-space:prewrap;text-align: center;", "headerStyles":"white-space:prewrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'PROGRAM_NAME')"/>", "field": "fscm_prog@program_name", "width": "15%", "styles":"white-space:prewrap;text-align: center;", "headerStyles":"white-space:prewrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'SELLER_NAME')"/>", "field": "seller_name", "width": "10%", "styles":"white-space:prewrap;text-align: center;", "headerStyles":"white-space:prewrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'BUYER_NAME')"/>", "field": "buyer_name", "width": "10%", "styles":"white-space:prewrap;", "headerStyles":"white-space:prewrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'CURCODE')"/>", "field": "total_net_cur_code", "width": "5%", "styles":"text-align: center;white-space:prewrap;", "headerStyles":"white-space:prewrap;"},
              						   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'INVOICE_AMOUNT')"/>", "field": "total_net_amt", "width": "5%", "styles":"text-align: right;", "headerStyles":"white-space:prewrap;text-align: center"},					                   
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'FINANCED_AMNT')"/>", "field": "finance_amt", "width": "5%", "styles":"text-align: right;", "headerStyles":"white-space:prewrap;text-align: center"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'OS_AMOUNT')"/>", "field": "liab_total_net_amt", "width": "5%", "styles":"text-align: right;", "headerStyles":"white-space:prewrap;text-align: center"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'INVOICE_DATE')"/>", "field": "iss_date", "width": "7%", "styles":"text-align: right;", "headerStyles":"white-space:prewrap;text-align: center"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'INVOICE_DUE_DATE')"/>", "field": "due_date", "width": "7%", "styles":"text-align: right;", "headerStyles":"white-space:prewrap;text-align: center"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'STATUS')"/>", "field": "prod_stat_code", "width": "15%", "styles":"text-align: center;", "headerStyles":"white-space:prewrap;text-align: center"},
					                   <!-- { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'FIN_REQUESTED_PERCENT')"/>", "field":"inv_eligible_pct", "width": "6%", "styles":"text-align: center;", "headerStyles":"white-space:prewrap;text-align: center"} -->]
					                  
					              ]};
							pluginsData = {indirectSelection: {headerSelector: "true",width: "30px",styles: "text-align: center;"}, paginationEnhanced: {pageSizes: ["10","25","50","100"], description: true, sizeSwitch: true, pageStepper: true, gotoButton: true, maxPageStep: 7, position: " top "}}						
						});
					</script>
		
					<div style="width:100%;height:100%;" class="widgetContainer clear">
						<div dojoType="dojox.data.QueryReadStore" jsId="storeBulkTransaction" requestMethod="post">
							<xsl:attribute name="url">							
								<xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/AjaxScreen/action/GetJSONData?listdef=openaccount/listdef/customer/IP/showInvoicePayableTransactionsInBK.xml&amp;bulk_ref_id=<xsl:value-of select='ref_id'/>		
							</xsl:attribute>
						</div>
					    <table rowsPerPage="50" 
							plugins="pluginsData" 
							store="storeBulkTransaction" structure="gridLayoutBulkTransaction" class="grid" 
							autoHeight="true" id="gridBulkTransaction" dojoType="dojox.grid.EnhancedGrid" 
							noDataMessage="{localization:getGTPString($language, 'TABLE_NO_DATA')}" selectionMode="none" selectable="true" 
							escapeHTMLInData="true" loadingMessage="{localization:getGTPString($language, 'TABLE_LOADING_RECORDS_LIST')}" >
							<thead>
								<tr></tr>
							</thead>
							<tfoot>
								<tr><td></td></tr>
							</tfoot>
							<tbody>
								<tr><td></td></tr>
							</tbody>
						</table>

						<div class="clear" style="height:1px">&nbsp;</div>
					</div>
				</div>
			</div>
	</xsl:template>
	
	<xsl:template name="bulk-invoice-grid-view">
		<xsl:param name="product"/>
		<p>&nbsp;</p>
		<div id="invoiceGridContainer" class="widgetContainer">
				<p/>
				<div name="invoiceGridList" id="invoiceGridList">
					<script type="text/javascript">
						var gridLayoutBulkTransaction, pluginsData;
						dojo.ready(function(){
					    	gridLayoutBulkTransaction = {"cells" : [ 
					                  [{ "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'REFERENCEID')"/>", "field": "REFERENCEID", "width": "10%", "styles":"white-space:prewrap;text-align: center;", "headerStyles":"white-space:prewrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'INVOICE_REFERENCE_LABEL')"/>", "field": "INVOICE_REFERENCE_LABEL", "width": "10%", "styles":"white-space:prewrap;text-align: center;", "headerStyles":"white-space:prewrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'PROGRAM_NAME')"/>", "field": "PROGRAM_NAME", "width": "10%", "styles":"white-space:prewrap;text-align: center;", "headerStyles":"white-space:prewrap;"},
									   <xsl:if test="$product = 'IN'">
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'BUYER_NAME')"/>", "field": "BUYER_NAME", "width": "10%", "styles":"white-space:prewrap;", "headerStyles":"white-space:prewrap;"},
									   </xsl:if>
									   <xsl:if test="$product = 'IP'">
									   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'SELLER_NAME')"/>", "field": "SELLER_NAME", "width": "10%", "styles":"white-space:prewrap;", "headerStyles":"white-space:prewrap;"},
									   </xsl:if>
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'CURCODE')"/>", "field": "CURCODE", "width": "4%", "styles":"text-align: center;white-space:prewrap;", "headerStyles":"white-space:prewrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'AMOUNT')"/>", "field": "AMOUNT", "width": "5%", "styles":"text-align: right;", "headerStyles":"white-space:prewrap;text-align: center"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'OS_AMOUNT')"/>", "field": "OS_AMOUNT", "width": "5%", "styles":"text-align: right;", "headerStyles":"white-space:prewrap;text-align: center"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'INVOICE_DATE')"/>", "field": "INVOICE_DATE", "width": "6%", "styles":"text-align: right;", "headerStyles":"white-space:prewrap;text-align: center"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'INVOICE_DUE_DATE')"/>", "field": "INVOICE_DUE_DATE", "width": "6%", "styles":"text-align: right;", "headerStyles":"white-space:prewrap;text-align: center"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'STATUS')"/>", "field": "STATUS", "width": "15%", "styles":"text-align: center;", "headerStyles":"white-space:prewrap;text-align: center"},
					                   <!-- { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'FIN_REQUESTED_PERCENT')"/>", "field":"FIN_REQUESTED_PERCENT", "width": "6%", "styles":"text-align: center;", "headerStyles":"white-space:prewrap;text-align: center"} -->]
					                  
					              ]};
							pluginsData = {indirectSelection: {headerSelector: "true",width: "30px",styles: "text-align: center;"}, paginationEnhanced: {pageSizes: ["10","25","50","100"], description: true, sizeSwitch: true, pageStepper: true, gotoButton: true, maxPageStep: 7, position: " top "}}						
						});
					</script>
		
					<div style="width:100%;height:100%;" class="widgetContainer clear">
						<div dojoType="dojox.data.QueryReadStore" jsId="storeBulkTransaction" requestMethod="post">
							<xsl:attribute name="url">
								<xsl:if test="$product = 'IN'">
									<xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/AjaxScreen/action/GetJSONData?listdef=openaccount/listdef/customer/IN/showInvoiceTransactionsInBK.xml&amp;bulk_ref_id=<xsl:value-of select='ref_id'/>
								</xsl:if>
								<xsl:if test="$product = 'IP'">
									<xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/AjaxScreen/action/GetJSONData?listdef=openaccount/listdef/customer/IP/showInvoicePayableTransactionsInBK.xml&amp;bulk_ref_id=<xsl:value-of select='ref_id'/>
								</xsl:if>
							</xsl:attribute>
						</div>
						
						<xsl:if test="$product = 'IN'">
						    <table rowsPerPage="50" 
								plugins="pluginsData" 
								store="storeBulkTransaction" structure="gridLayoutBulkTransaction" class="grid" 
								autoHeight="true" id="invoicesGrid" dojoType="dojox.grid.EnhancedGrid" 
								noDataMessage="{localization:getGTPString($language, 'TABLE_NO_DATA')}" selectionMode="none" selectable="true" 
								escapeHTMLInData="true" loadingMessage="{localization:getGTPString($language, 'TABLE_LOADING_RECORDS_LIST')}" >
								<thead>
									<tr></tr>
								</thead>
								<tfoot>
									<tr><td></td></tr>
								</tfoot>
								<tbody>
									<tr><td></td></tr>
								</tbody>
							</table>
						</xsl:if>
						<xsl:if test="$product = 'IP'">
							<table rowsPerPage="50" 
								plugins="pluginsData" 
								store="storeBulkTransaction" structure="gridLayoutBulkTransaction" class="grid" 
								autoHeight="true" id="invoicePayablesGrid" dojoType="dojox.grid.EnhancedGrid" 
								noDataMessage="{localization:getGTPString($language, 'TABLE_NO_DATA')}" selectionMode="none" selectable="true" 
								escapeHTMLInData="true" loadingMessage="{localization:getGTPString($language, 'TABLE_LOADING_RECORDS_LIST')}" >
								<thead>
									<tr></tr>
								</thead>
								<tfoot>
									<tr><td></td></tr>
								</tfoot>
								<tbody>
									<tr><td></td></tr>
								</tbody>
							</table>						
						</xsl:if>
						<div class="clear" style="height:1px">&nbsp;</div>
					</div>
				</div>
			</div>
	</xsl:template>
	
	<xsl:template name="bk-fscm-hidden-fields">
		<xsl:param name="childProductCode"/>
		<xsl:param name="childSubProductCode"/>
		<xsl:call-template name="common-hidden-fields">
			<xsl:with-param name="show-cust_ref_id">N</xsl:with-param>
			<xsl:with-param name="show-type">N</xsl:with-param>
			<xsl:with-param name="additional-fields">	
				<xsl:call-template name="hidden-field">
				   <xsl:with-param name="name">entity_hidden</xsl:with-param>
				   <xsl:with-param name="value"><xsl:value-of select="entity"/></xsl:with-param>
				</xsl:call-template>		
			    <xsl:call-template name="hidden-field">
				   <xsl:with-param name="name">bulk_ref_id</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
				   <xsl:with-param name="name">bulk_tnx_id</xsl:with-param>
				</xsl:call-template>
			    <xsl:call-template name="hidden-field">
				   <xsl:with-param name="name">product_code</xsl:with-param>
				   <xsl:with-param name="value">BK</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
				   <xsl:with-param name="name">sub_product_code</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
				   <xsl:with-param name="name">child_product_code</xsl:with-param>
				   <xsl:with-param name="value"><xsl:value-of select="$childProductCode"/></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">child_sub_product_code</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="$childSubProductCode"/></xsl:with-param>
				</xsl:call-template>
				
		   		<!-- Following fields are being used after implementaion of
		   			 entity level permission for product group and pay roll type
		   			 drop down on the UI, As these drop down are populated
		   			 dynamically so use these fields to when we reitrive
		   			 from draft and access in JS -->
		   		<xsl:call-template name="hidden-field">
		       	   <xsl:with-param name="name">bk_type_hidden</xsl:with-param>
		       	   <xsl:with-param name="value"><xsl:value-of select="bk_type"/></xsl:with-param>
		   		</xsl:call-template>
		   		<xsl:call-template name="hidden-field">
			       <xsl:with-param name="name">bank_base_currency</xsl:with-param>
			       <xsl:with-param name="value"><xsl:value-of select="bank_base_currency"/></xsl:with-param>
			    </xsl:call-template>
		   		<!-- Include cross-references -->
		   		<xsl:apply-templates select="cross_references" mode="hidden_form"/>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="bank-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_BANK_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="issuing-bank-tabcontent"/>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">issuing_bank_customer_reference_hidden</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>	
		</xsl:call-template>
	
	</xsl:template>
</xsl:stylesheet>