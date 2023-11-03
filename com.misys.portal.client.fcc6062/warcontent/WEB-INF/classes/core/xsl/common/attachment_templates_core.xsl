<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Generic templates for attaching files, documents, charges etc. to transactions, followed
by specific implementations for each attachment type. 

Global variables referenced in these templates
 $main-form-name

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      12/03/08
author:    Cormac Flynn
email:     cormac.flynn@misys.com
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
    exclude-result-prefixes="localization utils defaultresource">

 <!-- Templates for the file upload -->
 <xsl:include href="file_upload_templates.xsl" />
 <xsl:include href="file_upload_widgets.xsl" />

 <!--
  COMMON TEMPLATES 
  -->

 <!--
  A table of attachments 
  -->
 <xsl:template name="attachments-table">
  <xsl:param name="max-attachments"/>
  <xsl:param name="existing-attachments"/>
  <xsl:param name="table-caption"/>
  <xsl:param name="table-summary"/>
  <xsl:param name="table-thead"/>
  <xsl:param name="collapsible-prefix"/>
  <xsl:param name="table-row-type"/>
  <xsl:param name="optionvalue"/>
  <xsl:param name="empty-table-notice"/>
  <xsl:param name="delete-attachments-notice"/>
  <xsl:param name="bank-abbv" />
  <xsl:param name="title"/>
  <xsl:param name="hasEntities"/>
  <xsl:param name="isMT798">N</xsl:param>
  <xsl:param name="isRemittanceLetter">N</xsl:param>
  <xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
  <xsl:param name="editImage"><xsl:value-of select="$images_path"/>edit.png</xsl:param>
  <xsl:param name="deleteImage"><xsl:value-of select="$images_path"/>delete.png</xsl:param>
  <xsl:param name="actionDownImage"><xsl:value-of select="$images_path"/>action-down.png</xsl:param>
  <xsl:param name="actionUpImage"><xsl:value-of select="$images_path"/>action-up.png</xsl:param>
  
  
  <table border="0" cellpadding="0" cellspacing="0" class="attachments">
   <xsl:if test="count($existing-attachments) = 0">
    <xsl:attribute name="style">display:none;</xsl:attribute>
   </xsl:if>
   <xsl:attribute name="id"><xsl:value-of select="$collapsible-prefix"/><xsl:value-of select="$table-row-type"/>-master-table</xsl:attribute>
   <xsl:attribute name="summary"><xsl:value-of select="localization:getGTPString($language, $table-summary)"/></xsl:attribute>
   <caption style="display:none"><xsl:value-of select="localization:getGTPString($language, $table-caption)"/>&nbsp;<xsl:if test="$max-attachments!='-1'">(<xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_MAX')"/>&nbsp;<xsl:value-of select="$max-attachments"/>)</xsl:if></caption>
   <thead>
    <tr>
     <xsl:copy-of select="$table-thead"/>
     <xsl:if test="$displaymode='edit'">
      <th class="table-buttons"/>
     </xsl:if>
    </tr>
   </thead>
   <tbody>
    <xsl:choose>
     <xsl:when test="count($existing-attachments) = 0"><xsl:if test="$table-row-type!='role'"> <tr style="display:none;"><td/><td/><td/><td/><td/></tr></xsl:if> </xsl:when>
     <xsl:otherwise>
      <xsl:for-each select="$existing-attachments">
       <!-- 
        For Authorizations sort by order_number
        -->
       <xsl:sort select="order_number" order="ascending"/>
       
       <!-- 
        Set a variable to hold the item ID 
       -->
       <xsl:variable name="attachment-id">
        <xsl:choose>
         <xsl:when test="$table-row-type = 'document'">
          <xsl:value-of select="document_id"/>
         </xsl:when>
         <xsl:when test="$table-row-type = 'counterparty'">
          <xsl:value-of select="counterparty_id"/>
         </xsl:when>
         <xsl:when test="$table-row-type = 'charge'">
          <xsl:value-of select="chrg_id"/>
         </xsl:when>
         <xsl:when test="starts-with($table-row-type, 'customerReference')">
          <xsl:value-of select="position()-1"/>
         </xsl:when>
         <xsl:when test="$table-row-type = 'alert01'">
          <xsl:value-of select="position()"/>
         </xsl:when>
         <xsl:when test="$table-row-type = 'alert02'">
          <xsl:value-of select="position()"/>
         </xsl:when>
         <xsl:when test="$table-row-type = 'topic'">
          <xsl:value-of select="position()"/>
         </xsl:when>
         <xsl:when test="$table-row-type = 'role'">
          <xsl:value-of select="position()"/>
         </xsl:when>
        </xsl:choose>         
       </xsl:variable>
       
       <!-- 
        Set a variable to hold the row content 
       -->
       <xsl:variable name="row-content">
        <xsl:choose>
         <xsl:when test="$table-row-type = 'document'">
          <xsl:call-template name="document-table-row">
          	<xsl:with-param name="isRemittanceLetter"><xsl:value-of select="$isRemittanceLetter"/></xsl:with-param>
          </xsl:call-template>
         </xsl:when>
         <xsl:when test="$table-row-type = 'counterparty'">
          <xsl:call-template name="counterparty-table-row"/>
         </xsl:when>
         <xsl:when test="$table-row-type = 'topic'">
          <xsl:call-template name="topic-table-row">
          	<xsl:with-param name="suffix"><xsl:value-of select="position()"/></xsl:with-param>
          </xsl:call-template>
         </xsl:when>
         <xsl:when test="$table-row-type = 'charge'">
          <xsl:call-template name="charge-table-row">
          	<xsl:with-param name="isMT798" select="$isMT798"/>
          </xsl:call-template>
         </xsl:when>
         <xsl:when test="starts-with($table-row-type, 'customerReference')">
          <xsl:call-template name="customer-reference-table-row" />
         </xsl:when>
         <xsl:when test="starts-with($table-row-type, 'alert')">
          <xsl:call-template name="alert-table-row">
          	<xsl:with-param name="suffix"><xsl:value-of select="position()"/></xsl:with-param>
          	<xsl:with-param name="row-type"><xsl:value-of select="$table-row-type"/></xsl:with-param>
          	<xsl:with-param name="option"><xsl:value-of select="$optionvalue"/></xsl:with-param>
          	<xsl:with-param name="hasEntities"><xsl:value-of select="$hasEntities"/></xsl:with-param>
          </xsl:call-template>
         </xsl:when>
         <xsl:when test="$table-row-type = 'role'">
          <xsl:call-template name="role-table-row">
          	<xsl:with-param name="suffix"><xsl:value-of select="position()"/></xsl:with-param>
          </xsl:call-template>
         </xsl:when>
        </xsl:choose>
       </xsl:variable>
       
       <!-- Set the row -->
       <tr class="existing-attachment">
        <xsl:attribute name="id"><xsl:value-of select="$table-row-type"/>_row_<xsl:value-of select="$attachment-id"/></xsl:attribute>
        <xsl:copy-of select="$row-content"/>
        <xsl:if test="$displaymode='edit'">
         <td>
          
		  
		  <button dojoType="dijit.form.Button" type="button" class="noborder">
		    <xsl:attribute name="onclick">misys.editTransactionAddon('<xsl:value-of select="$table-row-type"/>', <xsl:value-of select="$attachment-id"/>,'',<xsl:value-of select="position()"/>);</xsl:attribute>
			<img alt="Edit">
			  <xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($editImage)"/></xsl:attribute>
			  <xsl:attribute name="title"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_MODIFY')"/></xsl:attribute>
			</img>
		  </button>
		  <div dojoType="dijit.form.DropDownButton" class="noborder">
           <xsl:attribute name="label"><![CDATA[<img src="]]><xsl:value-of select="utils:getImagePath($deleteImage)"/>/<![CDATA[" title="]]><xsl:value-of select="localization:getGTPString($language, 'XSL_TITLE_HELP_DELETE')"/><![CDATA["/>]]></xsl:attribute>
	       
           <span/>
           <div dojoType="dijit.TooltipDialog">
           	<xsl:choose>
	           	<xsl:when test="starts-with($table-row-type, 'customerReference')">
	           		<xsl:attribute name="execute">misys.fncDeleteCustomerReferenceRow('<xsl:value-of select="$table-row-type"/>', <xsl:value-of select="$attachment-id"/>,'', '', '<xsl:value-of select="$bank-abbv"/>')</xsl:attribute>
	           	</xsl:when>
	           	<xsl:otherwise>
	           		<xsl:attribute name="execute">misys.deleteTransactionAddon('<xsl:value-of select="$table-row-type"/>', <xsl:value-of select="$attachment-id"/>)</xsl:attribute>
	           	</xsl:otherwise>
           	</xsl:choose>
            <xsl:attribute name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_TITLE_ATTACHMENT_DELETE')"/></xsl:attribute>
            <p><xsl:value-of select="localization:getGTPString($language, $delete-attachments-notice)"/></p>
            <button dojoType="dijit.form.Button" type="submit"><xsl:value-of select="localization:getGTPString($language, 'XSL_TITLE_ATTACHMENT_DELETE')"/></button>
           </div>
          </div>
 		  </td>
        </xsl:if>
       </tr>
      </xsl:for-each>
     </xsl:otherwise>
    </xsl:choose>
   </tbody>
  </table>
  
  <!-- Disclaimer -->
  <p class="empty-list-notice">
   <xsl:attribute name="id"><xsl:value-of select="$table-row-type"/>-notice</xsl:attribute>
   <xsl:if test="count($existing-attachments)!=0">
    <xsl:attribute name="style">display:none</xsl:attribute>
   </xsl:if>
   <xsl:value-of select="localization:getGTPString($language, $empty-table-notice)"/><xsl:if test="$max-attachments!=-1 and $displaymode='edit'">(<xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_MAX')"/> <xsl:value-of select="$max-attachments"/>)</xsl:if>
  </p>
 </xsl:template>
 
 <!-- 
  -->
 <xsl:template name="role-table-row">
  <xsl:param name="suffix">0</xsl:param>
  <td>
   <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">authorization_level_role_id_<xsl:value-of select="$suffix" /></xsl:with-param>
     <xsl:with-param name="value" select="role_id" />
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">authorization_level_order_number_<xsl:value-of select="$suffix" /></xsl:with-param>
     <xsl:with-param name="value" select="order_number" />
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">authorization_level_level_id_<xsl:value-of select="$suffix" /></xsl:with-param>
     <xsl:with-param name="value" select="order_number" />
   </xsl:call-template>
   <xsl:variable name="roleId"><xsl:value-of select="role_id"/></xsl:variable>
   <xsl:value-of select="//role[id=$roleId]/role_description"/>
  </td>
 </xsl:template>

 <!-- 
  SPECIFIC TEMPLATES FOR DOCUMENTS, COUNTERPARTIES, etc.
  @TODO move this in a proper file
  -->
 <xsl:template name="attachments-customer-references">
   <xsl:param name="max-attachments">-1</xsl:param>
   <xsl:param name="customerDetailsEnabled">false</xsl:param>
   <xsl:param name="companyType">01</xsl:param>
   
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_CUSTOMER_REFERENCES</xsl:with-param>
		<xsl:with-param name="content">
		<!-- We can add additional customer reference fields in the JS array misys._config.customReferenceFields. See below example -->
		<!--  misys._config.customReferenceFields = misys._config.customReferenceFields || ['additional_reference']; -->
		<!-- Also if it is mandatory add it to the misys._config.mandatoryReferenceFields array -->
		<script> 
     		dojo.ready(function(){
				misys._config = misys._config || {};
				misys._config.coreReferenceFields = ['reference','description','back_office_1','back_office_2','back_office_3','back_office_4','back_office_5','back_office_6','back_office_7','back_office_8','back_office_9'];
				misys._config.customReferenceFields = misys._config.customReferenceFields || ['syncflag'];
				misys._config.mandatoryReferenceFields = ['reference','description'];
				misys._config.CustomerReferenceChangedMap = [];
			});
		 </script>
		<div class="widgetContainer">
		    <!-- hidden field used to pass the bank between customerReferenceDialog and misys.addTransactionAddon -->
		    <xsl:call-template name="hidden-field">
		     <xsl:with-param name="id">customerReference_target_bank</xsl:with-param>
		     <xsl:with-param name="value" />
		    </xsl:call-template>
		    <xsl:call-template name="hidden-field">
		       <xsl:with-param name="id">customerDetailsEnabled</xsl:with-param>
		       <xsl:with-param name="value"><xsl:value-of select="$customerDetailsEnabled" /></xsl:with-param>
		     </xsl:call-template> 
		</div>
   <xsl:for-each select="bank_desc_record | avail_desc_record">
   <xsl:sort select="abbv_name"/>
	 <xsl:variable name="bank_abbv_name" select="abbv_name"></xsl:variable>
	 <xsl:variable name="nodeName" select="name()"/>
	 <xsl:variable name="bankId" select="company_id"/>
     <xsl:variable name="existing-references" select="../bank[abbv_name = $bank_abbv_name]/customer_reference" />
	<xsl:variable name="allowBankgroupBanks"><xsl:value-of select="defaultresource:getResource('ALLOW_BANKGROUP_BANKS')"/></xsl:variable>
		
	<xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and ($nodeName = 'bank_desc_record' or count($existing-references) > 0))">
		<xsl:if test="(type='01' or (type='02' and $allowBankgroupBanks='true'))">
		<xsl:variable name="isRefSecExpanded">
			<xsl:choose>
				<xsl:when test="$companyType='01'">true</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="$companyType='02' and $displaymode='edit' and $nodeName != 'bank_desc_record'">false</xsl:when>
						<xsl:otherwise>true</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
     <!-- Static Edit Fields -->
     <script> 
     	dojo.ready(function(){
			misys._config = misys._config || {};
			dojo.mixin(misys._config,  {
				'customerReference_<xsl:value-of select="$bank_abbv_name"/>Attached' : <xsl:value-of select="count($existing-references)"/>
			});
			misys._config.availBanks = misys._config.availBanks || new Array();
			misys._config.availBanks.push('<xsl:value-of select="$bank_abbv_name"/>');
		});
	 </script>

	 <div style="width:100%;">
		 <div class="userAccountsTableCell userAccountsTableCellOdd alignCenterWithPadding userAccountsHeaderSelector">
			<xsl:call-template name="column-check-box">
				<xsl:with-param name="id">bank_enabled_<xsl:value-of select="$bank_abbv_name"/></xsl:with-param>
				<!-- The checkbox is always checked for a Bank user (since only that Bank is available) 
					 For a BankGroup user only attached Banks are checked -->
				<xsl:with-param name="checked">
					<xsl:choose>
					  <xsl:when test="$companyType='01' or ( $companyType = '02' and $nodeName = 'bank_desc_record')">Y</xsl:when>
					  <xsl:otherwise>N</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
				<xsl:with-param name="disabled">
					<xsl:choose>
					  <xsl:when test="$companyType='01'">Y</xsl:when>
					  <xsl:otherwise>N</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
				
			</xsl:call-template>
		</div>
		<div class="userAccountsTableCell userAccountsTableCellOdd alignLeftWithPadding" style="width:92%;">
			<xsl:attribute name="id">bank_desc_<xsl:value-of select="$bank_abbv_name"/></xsl:attribute>
		  <xsl:value-of select="name" /> (<xsl:value-of select="abbv_name" />)
		</div>
		<div class="userAccountsTableCell userAccountsTableCellOdd alignCenterWithPadding" style="width:3%;">
			<!-- <xsl:choose>
				<xsl:when test="$displaymode = 'edit' or ($displaymode != 'edit' and (count(existing_products/product) != 0)) "> -->
				<!-- <xsl:when test="$displaymode = 'edit'"> -->
			<!-- 	<span style="vertical-align:top;" ><xsl:attribute name="id">bank_references_indicator_<xsl:value-of select="abbv_name"/></xsl:attribute>
					<xsl:if test="$displaymode='view'">	
						<xsl:value-of select="count(existing_products/product)"/>&nbsp;<xsl:value-of select="localization:getGTPString($language, 'XSL_USER_ACCOUNTS_PRODUCT_COUNT')"/>
					</xsl:if>
				</span> -->
				<span>
					<xsl:attribute name="style">
							<xsl:choose>
							    <!-- <xsl:when test="($displaymode !='edit') and ($account_record/account_enabled[.='Y']) and (count($account_record/existing_products/product) > 0)"> -->
							    <xsl:when test="($displaymode !='edit')">
							     	 display:none;cursor:pointer;vertical-align:middle;
							    </xsl:when>
							    <xsl:otherwise>
							    	<xsl:choose><xsl:when test="$isRefSecExpanded='true'">display:none;</xsl:when><xsl:otherwise>display:inline;</xsl:otherwise></xsl:choose>
							          cursor:pointer;vertical-align:middle;
							    </xsl:otherwise>
							</xsl:choose>
					</xsl:attribute>
					<xsl:attribute name="id">reference_list_down_<xsl:value-of select="abbv_name"/></xsl:attribute>
					<a>
						<xsl:attribute name="onClick">misys.toggleReferenceSection('<xsl:value-of select="abbv_name"/>','down');</xsl:attribute>
						<img>
							<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($actionDownImage)"/></xsl:attribute>
							<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'OPEN_PRODUCTS_ASSIGNMENT')"/></xsl:attribute>
						</img>
					</a>
				</span>
				<span>
					<xsl:attribute name="style">
							<xsl:choose>
							   <!--  <xsl:when test="($displaymode !='edit') and ($account_record/account_enabled[.='Y']) and (count($account_record/existing_products/product) > 0)"> -->
							    <xsl:when test="($displaymode !='edit')">
							     	display:inline;cursor:pointer;vertical-align:middle;
							    </xsl:when>
							    <xsl:otherwise>
							          <xsl:choose><xsl:when test="$isRefSecExpanded='true'">display:inline;</xsl:when><xsl:otherwise>display:none;</xsl:otherwise></xsl:choose>
							          cursor:pointer;vertical-align:middle;
							    </xsl:otherwise>
							</xsl:choose>
					</xsl:attribute>
					<xsl:attribute name="id">reference_list_up_<xsl:value-of select="abbv_name"/></xsl:attribute>
					<a>
						<xsl:attribute name="onClick">misys.toggleReferenceSection('<xsl:value-of select="abbv_name"/>','up');</xsl:attribute>
						<img>
							<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($actionUpImage)"/></xsl:attribute>
							<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'CLOSE_PRODUCTS_ASSIGNMENT')"/></xsl:attribute>
						</img>
					</a>
				</span>
				<!-- </xsl:when>
				<xsl:otherwise>
					<span><xsl:value-of select="localization:getGTPString($language, 'XSL_NO_PRODUCTS')"></xsl:value-of></span>	
				</xsl:otherwise>
			</xsl:choose> -->
		</div>
	</div>	
	<xsl:variable name="bank_custref">bank_custref_<xsl:value-of select="$bank_abbv_name"/></xsl:variable>
	<div  id="{$bank_custref}">
		<xsl:attribute name="style">
			<xsl:choose>
				<xsl:when test="$isRefSecExpanded = 'true'">display:inline;</xsl:when>
				<xsl:otherwise>display:none;</xsl:otherwise>
			</xsl:choose>
		</xsl:attribute>
		<!-- bank abbv name -->
	     <xsl:call-template name="hidden-field">
	       <xsl:with-param name="id">bank_abbv_name_<xsl:value-of select="$bank_abbv_name" /></xsl:with-param>
	       <xsl:with-param name="name">bank_abbv_name_<xsl:value-of select="$bank_abbv_name" /></xsl:with-param>
	       <xsl:with-param name="value" select="$bank_abbv_name" />
	     </xsl:call-template> 
	     
	     <xsl:call-template name="hidden-field">
	       <xsl:with-param name="id">common_fixed_id_<xsl:value-of select="$bank_abbv_name" /></xsl:with-param>
	       <xsl:with-param name="name">common_fixed_id_<xsl:value-of select="$bank_abbv_name" /></xsl:with-param>
	       <xsl:with-param name="value" select="$bank_abbv_name" />
	     </xsl:call-template>

         <!-- Table -->
         <xsl:call-template name="attachments-table">
           <xsl:with-param name="max-attachments" select="$max-attachments"/>
           <xsl:with-param name="existing-attachments" select="$existing-references"/>
           <xsl:with-param name="table-thead">
             <th class="ctr-acc-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_CUSTOMER_REFERENCE_HEADER')"/></th>
             <th class="ctr-acc-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_CUSTOMER_REFERENCE_DESCRIPTION_HEADER')"/></th>
           </xsl:with-param>
           <xsl:with-param name="table-row-type">customerReference_<xsl:value-of select="abbv_name" /></xsl:with-param>
           <xsl:with-param name="empty-table-notice">XSL_JURISDICTION_NO_CUSTOMER_REFERENCE</xsl:with-param>
           <xsl:with-param name="delete-attachments-notice">XSL_TITLE_CUSTOMER_REFERENCE_NOTICE</xsl:with-param>
           <xsl:with-param name="bank-abbv"><xsl:value-of select="abbv_name" /></xsl:with-param>
         </xsl:call-template>
    
         <!-- Hidden Fields for existing customer references -->
         
         <xsl:for-each select="$existing-references">
           <xsl:call-template name="hidden-field">
             <xsl:with-param name="name">customer_reference_<xsl:value-of select="$bank_abbv_name"/>_details_reference_<xsl:value-of select="position()-1" /></xsl:with-param>
             <xsl:with-param name="value" select="utils:decryptApplicantReference(reference)" />
           </xsl:call-template> 
           <xsl:call-template name="hidden-field">
             <xsl:with-param name="name">customer_reference_<xsl:value-of select="$bank_abbv_name" />_details_description_<xsl:value-of select="position()-1" /></xsl:with-param>
             <xsl:with-param name="value" select="description" />
           </xsl:call-template>
           
           <!-- Back Office References, per BO type -->
            <xsl:if test="defaultresource:getResource('REFERENCE_BACK_OFFICE_1') != ''">
	           <xsl:call-template name="hidden-field">
	             <xsl:with-param name="name">customer_reference_<xsl:value-of select="$bank_abbv_name" />_details_back_office_1_<xsl:value-of select="position()-1" /></xsl:with-param>
	             <xsl:with-param name="value" select="back_office_1" />
	           </xsl:call-template>
	       </xsl:if>
	       <xsl:if test="defaultresource:getResource('REFERENCE_BACK_OFFICE_2') != ''">
	           <xsl:call-template name="hidden-field">
	             <xsl:with-param name="name">customer_reference_<xsl:value-of select="$bank_abbv_name" />_details_back_office_2_<xsl:value-of select="position()-1" /></xsl:with-param>
	             <xsl:with-param name="value" select="back_office_2" />
	           </xsl:call-template>
           </xsl:if>
           <xsl:if test="defaultresource:getResource('REFERENCE_BACK_OFFICE_3') != ''">
	           <xsl:call-template name="hidden-field">
	             <xsl:with-param name="name">customer_reference_<xsl:value-of select="$bank_abbv_name" />_details_back_office_3_<xsl:value-of select="position()-1" /></xsl:with-param>
	             <xsl:with-param name="value" select="back_office_3" />
	           </xsl:call-template>
           </xsl:if>
           <xsl:if test="defaultresource:getResource('REFERENCE_BACK_OFFICE_4') != ''">
	           <xsl:call-template name="hidden-field">
	             <xsl:with-param name="name">customer_reference_<xsl:value-of select="$bank_abbv_name" />_details_back_office_4_<xsl:value-of select="position()-1" /></xsl:with-param>
	             <xsl:with-param name="value" select="back_office_4" />
	           </xsl:call-template>
           </xsl:if>
           <xsl:if test="defaultresource:getResource('REFERENCE_BACK_OFFICE_5') != ''">
	           <xsl:call-template name="hidden-field">
	             <xsl:with-param name="name">customer_reference_<xsl:value-of select="$bank_abbv_name" />_details_back_office_5_<xsl:value-of select="position()-1" /></xsl:with-param>
	             <xsl:with-param name="value" select="back_office_5" />
	           </xsl:call-template>
           </xsl:if>
           <xsl:if test="defaultresource:getResource('REFERENCE_BACK_OFFICE_6') != ''">
	           <xsl:call-template name="hidden-field">
	             <xsl:with-param name="name">customer_reference_<xsl:value-of select="$bank_abbv_name" />_details_back_office_6_<xsl:value-of select="position()-1" /></xsl:with-param>
	             <xsl:with-param name="value" select="back_office_6" />
	           </xsl:call-template>
           </xsl:if>
           <xsl:if test="defaultresource:getResource('REFERENCE_BACK_OFFICE_7') != ''">
	           <xsl:call-template name="hidden-field">
	             <xsl:with-param name="name">customer_reference_<xsl:value-of select="$bank_abbv_name" />_details_back_office_7_<xsl:value-of select="position()-1" /></xsl:with-param>
	             <xsl:with-param name="value" select="back_office_7" />
	           </xsl:call-template>
           </xsl:if>
           <xsl:if test="defaultresource:getResource('REFERENCE_BACK_OFFICE_8') != ''">
	           <xsl:call-template name="hidden-field">
	             <xsl:with-param name="name">customer_reference_<xsl:value-of select="$bank_abbv_name" />_details_back_office_8_<xsl:value-of select="position()-1" /></xsl:with-param>
	             <xsl:with-param name="value" select="back_office_8" />
	           </xsl:call-template>
           </xsl:if>
           <xsl:if test="defaultresource:getResource('REFERENCE_BACK_OFFICE_9') != ''">
	           <xsl:call-template name="hidden-field">
	             <xsl:with-param name="name">customer_reference_<xsl:value-of select="$bank_abbv_name" />_details_back_office_9_<xsl:value-of select="position()-1" /></xsl:with-param>
	             <xsl:with-param name="value" select="back_office_9" />
	           </xsl:call-template>
           </xsl:if>
           
           <xsl:call-template name="hidden-field">
             <xsl:with-param name="name">customer_reference_<xsl:value-of select="$bank_abbv_name" />_details_position_<xsl:value-of select="position()-1" /></xsl:with-param>
             <xsl:with-param name="value" select="position()" />
           </xsl:call-template> 
           
           <xsl:call-template name="hidden-field">
             <xsl:with-param name="name">customer_reference_<xsl:value-of select="$bank_abbv_name" />_details_syncflag_<xsl:value-of select="position()-1" /></xsl:with-param>
             <xsl:with-param name="value" select="syncflag" />
           </xsl:call-template> 
                		
          <xsl:call-template name="hidden-field">
	        	<xsl:with-param name="name">customer_reference_<xsl:value-of select="$bank_abbv_name" />_details_liquidityenabledflag_<xsl:value-of select="position()-1" /></xsl:with-param>
	        	<xsl:with-param name="value" select="liquidityenabledflag" />
     		</xsl:call-template>
     		
         </xsl:for-each>
		
		 <xsl:if test="$displaymode='edit'">
		   <button dojoType="dijit.form.Button" type='button'>
             <xsl:attribute name="id">openCustomerReferenceDialog<xsl:value-of select="$bank_abbv_name"/></xsl:attribute>
             <xsl:attribute name="onclick">misys.showCustomerReferenceDialog('customerReference', '<xsl:value-of select="$customerDetailsEnabled"/>', '', '<xsl:value-of select="$bank_abbv_name"/>');</xsl:attribute>
             <xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_ADD_CUSTOMER_REFERENCE')" />
           </button>
	     </xsl:if>
	     
	  </div>
     
   <!-- Holder div for hidden fields, created when an item is added -->
   <div>
   	<xsl:attribute name="id">customerReference_fields_<xsl:value-of select="$bank_abbv_name"/></xsl:attribute>
   </div>

   <xsl:call-template name="dialog">
    <xsl:with-param name="id">customerReferenceDialog_<xsl:value-of select="$bank_abbv_name"/></xsl:with-param>
    <xsl:with-param name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_ADD_CUSTOMER_REFERENCE')" /></xsl:with-param>
    <xsl:with-param name="content">
     <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_JURISDICTION_CUSTOMER_REFERENCE</xsl:with-param>
       <xsl:with-param name="id">customerReference_<xsl:value-of select="$bank_abbv_name"/>_details_reference_nosend</xsl:with-param>
       <xsl:with-param name="size">20</xsl:with-param>
       <xsl:with-param name="maxsize">64</xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
       <xsl:with-param name="regular-expression">^[^&lt;&gt;]*</xsl:with-param>
       <xsl:with-param name="fieldsize">
	       <xsl:choose>
	       	<xsl:when test="$customerDetailsEnabled='true'">small</xsl:when>
	       	<xsl:otherwise>medium</xsl:otherwise>
	       </xsl:choose>
       </xsl:with-param> 
     </xsl:call-template>
     <!-- <xsl:call-template name="hidden-field">
       <xsl:with-param name="id">customerDetailsEnabled_<xsl:value-of select="$bank_abbv_name"/></xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="$customerDetailsEnabled" /></xsl:with-param>
     </xsl:call-template> --> 
     <xsl:if test="$customerDetailsEnabled='true'">
	     <button dojoType="dijit.form.Button" type="button">
	     	<xsl:attribute name="id">checkCustomerReferenceButton_<xsl:value-of select="$bank_abbv_name"/></xsl:attribute>
	     	<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CHECK')"/>
	     </button>
	     <!-- field to check the existence of customer's reference -->
		<div id="beforeCheckField">
			<label id="checkFieldLabel" for="customerReference_{$bank_abbv_name}_details_reference_nosend">&nbsp;</label>
			<div class="medium">
				<xsl:attribute name="id">checkField_<xsl:value-of select="$bank_abbv_name"/></xsl:attribute>
			</div>
		</div>
	</xsl:if>
     <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_JURISDICTION_CUSTOMER_REFERENCE_DESCRIPTION</xsl:with-param>
       <xsl:with-param name="id">customerReference_<xsl:value-of select="abbv_name"/>_details_description_nosend</xsl:with-param>
       <xsl:with-param name="size">30</xsl:with-param>
       <xsl:with-param name="maxsize">255</xsl:with-param>
       <xsl:with-param name="regular-expression">^[^&lt;&gt;]*</xsl:with-param>
       <xsl:with-param name="required">Y</xsl:with-param>
     </xsl:call-template>
     
     <!-- Back Office References -->
           
     <xsl:if test="defaultresource:getResource('REFERENCE_BACK_OFFICE_1') != ''">
	     <xsl:call-template name="input-field">
	       <xsl:with-param name="label">XSL_JURISDICTION_CUSTOMER_REFERENCE_BACK_OFFICE_1</xsl:with-param>
	       <xsl:with-param name="id">customerReference_<xsl:value-of select="abbv_name"/>_details_back_office_1_nosend</xsl:with-param>
	       <xsl:with-param name="size">20</xsl:with-param>
	       <xsl:with-param name="maxsize">64</xsl:with-param>
	       <xsl:with-param name="required">N</xsl:with-param>
	       <xsl:with-param name="regular-expression">^[^&lt;&gt;]*</xsl:with-param>
       	   <xsl:with-param name="content-after">
	     <xsl:if test="defaultresource:getResource('REFERENCE_BACK_OFFICE_1_VALIDATION') = 'true'">
		     <button dojoType="dijit.form.Button" type="button">
           <xsl:attribute name="id">checkCustomerReferenceButton_1_<xsl:value-of select="abbv_name"/></xsl:attribute>		     
		     	<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CHECK')"/>
		     </button>
		     <!-- field to check the existence of customer's reference -->
		 </xsl:if>	       
	       </xsl:with-param>	    
		  </xsl:call-template>
     </xsl:if>
    
    <xsl:if test="defaultresource:getResource('REFERENCE_BACK_OFFICE_2') != ''">
	     <xsl:call-template name="input-field">
	       <xsl:with-param name="label">XSL_JURISDICTION_CUSTOMER_REFERENCE_BACK_OFFICE_2</xsl:with-param>
	       <xsl:with-param name="id">customerReference_<xsl:value-of select="abbv_name"/>_details_back_office_2_nosend</xsl:with-param>
	       <xsl:with-param name="size">20</xsl:with-param>
	       <xsl:with-param name="maxsize">64</xsl:with-param>
	       <xsl:with-param name="regular-expression">^[^&lt;&gt;]*</xsl:with-param>
       	   <xsl:with-param name="required">N</xsl:with-param>
	        <xsl:with-param name="content-after">
	        <xsl:if test="defaultresource:getResource('REFERENCE_BACK_OFFICE_2_VALIDATION') = 'true'">
		   <button dojoType="dijit.form.Button" type="button">
	           <xsl:attribute name="id">checkCustomerReferenceButton_2_<xsl:value-of select="abbv_name"/></xsl:attribute>
		     	<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CHECK')"/>
		     </button>
		 		</xsl:if>    
	        </xsl:with-param>
	     </xsl:call-template>
	      </xsl:if>
	      
	      
	       <xsl:if test="defaultresource:getResource('REFERENCE_BACK_OFFICE_3') != ''">
	     <xsl:call-template name="input-field">
	       <xsl:with-param name="label">XSL_JURISDICTION_CUSTOMER_REFERENCE_BACK_OFFICE_3</xsl:with-param>
	       <xsl:with-param name="id">customerReference_<xsl:value-of select="abbv_name"/>_details_back_office_3_nosend</xsl:with-param>
	       <xsl:with-param name="size">20</xsl:with-param>
	       <xsl:with-param name="maxsize">64</xsl:with-param>
	       <xsl:with-param name="regular-expression">^[^&lt;&gt;]*</xsl:with-param>
       	   <xsl:with-param name="required">N</xsl:with-param>
	       <xsl:with-param name="content-after">
	       <xsl:if test="defaultresource:getResource('REFERENCE_BACK_OFFICE_3_VALIDATION') = 'true'">
		   <button dojoType="dijit.form.Button" type="button">
	           <xsl:attribute name="id">checkCustomerReferenceButton_3_<xsl:value-of select="abbv_name"/></xsl:attribute>
		     	<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CHECK')"/>
		     </button>
			 </xsl:if>
	       </xsl:with-param>
	     </xsl:call-template>
     </xsl:if>
     
     
     
       
     <xsl:if test="defaultresource:getResource('REFERENCE_BACK_OFFICE_4') != ''">
	     <xsl:call-template name="input-field">
	       <xsl:with-param name="label">XSL_JURISDICTION_CUSTOMER_REFERENCE_BACK_OFFICE_4</xsl:with-param>
	       <xsl:with-param name="id">customerReference_<xsl:value-of select="abbv_name"/>_details_back_office_4_nosend</xsl:with-param>
	       <xsl:with-param name="size">20</xsl:with-param>
	       <xsl:with-param name="maxsize">64</xsl:with-param>
	       <xsl:with-param name="regular-expression">^[^&lt;&gt;]*</xsl:with-param>
       	   <xsl:with-param name="required">N</xsl:with-param>
	       <xsl:with-param name="content-after">
	       <xsl:if test="defaultresource:getResource('REFERENCE_BACK_OFFICE_4_VALIDATION') = 'true'">
		   <button dojoType="dijit.form.Button" type="button">
	           <xsl:attribute name="id">checkCustomerReferenceButton_4_<xsl:value-of select="abbv_name"/></xsl:attribute>
		     	<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CHECK')"/>
		     </button>
		     <!-- field to check the existence of customer's reference -->
		 </xsl:if>
	       </xsl:with-param>
	     </xsl:call-template>
     </xsl:if> 
     
       
     <xsl:if test="defaultresource:getResource('REFERENCE_BACK_OFFICE_5') != ''">
	     <xsl:call-template name="input-field">
	       <xsl:with-param name="label">XSL_JURISDICTION_CUSTOMER_REFERENCE_BACK_OFFICE_5</xsl:with-param>
	       <xsl:with-param name="id">customerReference_<xsl:value-of select="abbv_name"/>_details_back_office_5_nosend</xsl:with-param>
	       <xsl:with-param name="size">20</xsl:with-param>
	       <xsl:with-param name="maxsize">64</xsl:with-param>
	       <xsl:with-param name="required">N</xsl:with-param>
	       <xsl:with-param name="regular-expression">^[^&lt;&gt;]*</xsl:with-param>
       	   <xsl:with-param name="content-after">
	       <xsl:if test="defaultresource:getResource('REFERENCE_BACK_OFFICE_5_VALIDATION') = 'true'">
		   <button dojoType="dijit.form.Button" type="button">
	           <xsl:attribute name="id">checkCustomerReferenceButton_5_<xsl:value-of select="abbv_name"/></xsl:attribute>
		     	<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CHECK')"/>
		     </button>
		     <!-- field to check the existence of customer's reference -->
		 </xsl:if>
	       </xsl:with-param>
	     </xsl:call-template>
     </xsl:if>
     
       
     
     <xsl:if test="defaultresource:getResource('REFERENCE_BACK_OFFICE_6') != ''">
  	     <xsl:call-template name="input-field">
	       <xsl:with-param name="label">XSL_JURISDICTION_CUSTOMER_REFERENCE_BACK_OFFICE_6</xsl:with-param>
	       <xsl:with-param name="id">customerReference_<xsl:value-of select="abbv_name"/>_details_back_office_6_nosend</xsl:with-param>
	       <xsl:with-param name="size">20</xsl:with-param>
	       <xsl:with-param name="maxsize">64</xsl:with-param>
	       <xsl:with-param name="required">N</xsl:with-param>
	       <xsl:with-param name="regular-expression">^[^&lt;&gt;]*</xsl:with-param>
       	   <xsl:with-param name="content-after">
	        <xsl:if test="defaultresource:getResource('REFERENCE_BACK_OFFICE_6_VALIDATION') = 'true'">
		   <button dojoType="dijit.form.Button" type="button">
	           <xsl:attribute name="id">checkCustomerReferenceButton_6_<xsl:value-of select="abbv_name"/></xsl:attribute>
		     	<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CHECK')"/>
		     </button>
		     <!-- field to check the existence of customer's reference -->
		 </xsl:if>
	       </xsl:with-param>
	     </xsl:call-template>
     </xsl:if>
      
        
     <xsl:if test="defaultresource:getResource('REFERENCE_BACK_OFFICE_7') != ''">
	     <xsl:call-template name="input-field">
	       <xsl:with-param name="label">XSL_JURISDICTION_CUSTOMER_REFERENCE_BACK_OFFICE_7</xsl:with-param>
	       <xsl:with-param name="id">customerReference_<xsl:value-of select="abbv_name"/>_details_back_office_7_nosend</xsl:with-param>
	       <xsl:with-param name="size">20</xsl:with-param>
	       <xsl:with-param name="maxsize">64</xsl:with-param>
	       <xsl:with-param name="required">N</xsl:with-param>
	       <xsl:with-param name="regular-expression">^[^&lt;&gt;]*</xsl:with-param>
       	   <xsl:with-param name="content-after">
	        <xsl:if test="defaultresource:getResource('REFERENCE_BACK_OFFICE_7_VALIDATION') = 'true'">
		   <button dojoType="dijit.form.Button" type="button">
	           <xsl:attribute name="id">checkCustomerReferenceButton_7_<xsl:value-of select="abbv_name"/></xsl:attribute>
		     	<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CHECK')"/>
		     </button>
		     <!-- field to check the existence of customer's reference -->
		 </xsl:if>
	       </xsl:with-param>
	     </xsl:call-template>
     </xsl:if>
      
       
     
     <xsl:if test="defaultresource:getResource('REFERENCE_BACK_OFFICE_8') != ''">
	     <xsl:call-template name="input-field">
	       <xsl:with-param name="label">XSL_JURISDICTION_CUSTOMER_REFERENCE_BACK_OFFICE_8</xsl:with-param>
	       <xsl:with-param name="id">customerReference_<xsl:value-of select="abbv_name"/>_details_back_office_8_nosend</xsl:with-param>
	       <xsl:with-param name="size">20</xsl:with-param>
	       <xsl:with-param name="maxsize">64<!-- <xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_LBO_LENGTH')"/> --></xsl:with-param>
	       <xsl:with-param name="regular-expression">^[^&lt;&gt;]*</xsl:with-param>
       	   <xsl:with-param name="required">N</xsl:with-param>
<!-- 	        <xsl:with-param name="regular-expression">
				     			<xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_LBO_VALIDATION_REGEX')"/>
		     </xsl:with-param> -->
	       <xsl:with-param name="content-after">
	        <xsl:if test="defaultresource:getResource('REFERENCE_BACK_OFFICE_8_VALIDATION') = 'true'">
		   <button dojoType="dijit.form.Button" type="button">
	           <xsl:attribute name="id">checkCustomerReferenceButton_8_<xsl:value-of select="abbv_name"/></xsl:attribute>
		     	<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CHECK')"/>
		     </button>
		     <!-- field to check the existence of customer's reference -->
		 </xsl:if>
	       </xsl:with-param>
	     </xsl:call-template>
	     <xsl:call-template name="hidden-field">
	       <xsl:with-param name="id">customerReference_<xsl:value-of select="abbv_name"/>_details_liquidityenabledflag_nosend</xsl:with-param>
	       <xsl:with-param name="value" />
	     </xsl:call-template> 
     </xsl:if>
      
     
     <xsl:if test="defaultresource:getResource('REFERENCE_BACK_OFFICE_9') != ''">
	     <xsl:call-template name="input-field">
	       <xsl:with-param name="label">XSL_JURISDICTION_CUSTOMER_REFERENCE_BACK_OFFICE_9</xsl:with-param>
	       <xsl:with-param name="id">customerReference_<xsl:value-of select="abbv_name"/>_details_back_office_9_nosend</xsl:with-param>
	       <xsl:with-param name="size">20</xsl:with-param>
	       <xsl:with-param name="maxsize">64</xsl:with-param>
	       <xsl:with-param name="regular-expression">^[^&lt;&gt;]*</xsl:with-param>
       	   <xsl:with-param name="required">N</xsl:with-param>
	       <xsl:with-param name="content-after">
	        <xsl:if test="defaultresource:getResource('REFERENCE_BACK_OFFICE_9_VALIDATION') = 'true'">
		   <button dojoType="dijit.form.Button" type="button">
	           <xsl:attribute name="id">checkCustomerReferenceButton_9_<xsl:value-of select="abbv_name"/></xsl:attribute>
		     	<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CHECK')"/>
		     </button>
		     <!-- field to check the existence of customer's reference -->
		 </xsl:if>
	       </xsl:with-param>
	     </xsl:call-template>
     </xsl:if>
     
      
     
     <div id="beforeCheckDetails">
		<label id="beforeCheckDetailsLabel">&nbsp;</label>
		<div class="medium">
			<xsl:attribute name="id">check_details_<xsl:value-of select="abbv_name"/></xsl:attribute>
		</div>
	 </div>
     <xsl:call-template name="hidden-field">
       <xsl:with-param name="id">customerReference_<xsl:value-of select="abbv_name"/>_details_position_nosend</xsl:with-param>
       <xsl:with-param name="value" />
     </xsl:call-template> 
    </xsl:with-param>
    <xsl:with-param name="buttons">
     <xsl:call-template name="row-wrapper">
       <xsl:with-param name="id">addCustomerReferenceButton_<xsl:value-of select="abbv_name"/></xsl:with-param>
       <xsl:with-param name="content">
         <button dojoType="dijit.form.Button" type="button">
           <xsl:attribute name="id">addCustomerReferenceButton_<xsl:value-of select="abbv_name"/></xsl:attribute>
           <xsl:attribute name="onclick">misys.addCustomerReference('customerReference', <xsl:value-of select="$bankId"/>, '<xsl:value-of select="abbv_name"/>');</xsl:attribute>
           <xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SAVE')"/>
         </button>
         <button dojoType="dijit.form.Button" type="button">
         	<xsl:attribute name="id">cancelCustomerReferenceButton_<xsl:value-of select="abbv_name"/></xsl:attribute>
           <xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/>
         </button>
       </xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
   
   </xsl:if>
   </xsl:if>
   
   
   </xsl:for-each>
   </xsl:with-param>
    </xsl:call-template>
   

   
 </xsl:template>


 <!--
  Attach counterparties. 
  -->
<xsl:template name="attachments-counterparties">
 <xsl:param name="max-attachments">-1</xsl:param>
 <xsl:param name="existing-attachments" select="counterparties/counterparty"/>
 
 <xsl:call-template name="fieldset-wrapper">
  <xsl:with-param name="legend">XSL_HEADER_BENEFICIARIES</xsl:with-param>
  <xsl:with-param name="content">
    <xsl:call-template name="attachments-table">
     <xsl:with-param name="max-attachments" select="$max-attachments"/>
     <xsl:with-param name="existing-attachments" select="$existing-attachments"/>
     <xsl:with-param name="table-caption">XSL_BENEFICIARIES_TABLE_CAPTION</xsl:with-param>
     <xsl:with-param name="table-summary">XSL_BENEFICIARIES_TABLE_SUMMARY</xsl:with-param>
     <xsl:with-param name="table-thead">
      <th class="ctr-acc-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_FT_HEADER_BENEFICIARY_ACT_NO')"/></th>
      <th class="ctr-acc-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BENEFICIARY_DETAILS')"/></th>
      <th class="ctr-amt-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_FT_HEADER_AMOUNT')"/></th>
      <th class="ctr-amt-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BENEFICIARY_TRANSFER_REFERENCE')"/></th>
     </xsl:with-param>
     <xsl:with-param name="table-row-type">counterparty</xsl:with-param>
     <xsl:with-param name="empty-table-notice">XSL_DETAILS_NO_COUNTERPARTY</xsl:with-param>
     <xsl:with-param name="delete-attachments-notice">XSL_TITLE_DOCUMENT_NOTICE</xsl:with-param>
    </xsl:call-template>
    
    <!--
      Hidden Fields for existing attachments
     -->
    <xsl:for-each select="$existing-attachments">
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">counterparty_details_document_id_<xsl:value-of select="counterparty_id"/></xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="counterparty_id"/></xsl:with-param>
     </xsl:call-template> 
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">counterparty_details_act_no_<xsl:value-of select="counterparty_id"/></xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="counterparty_act_no"/></xsl:with-param>
     </xsl:call-template> 
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">counterparty_details_name_<xsl:value-of select="counterparty_id"/></xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="counterparty_name"/></xsl:with-param>
     </xsl:call-template>
     <xsl:if test="counterparty_address_line_1[.!= '']">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">counterparty_details_address_line_1_<xsl:value-of select="counterparty_id"/></xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="counterparty_address_line_1"/></xsl:with-param>
      </xsl:call-template> 
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">counterparty_details_address_line_2_<xsl:value-of select="counterparty_id"/></xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="counterparty_address_line_2"/></xsl:with-param>
      </xsl:call-template> 
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">counterparty_details_dom_<xsl:value-of select="counterparty_id"/></xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="counterparty_dom"/></xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">counterparty_details_ft_cur_code_<xsl:value-of select="counterparty_id"/></xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="counterparty_cur_code"/></xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">counterparty_details_ft_amt_<xsl:value-of select="counterparty_id"/></xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="counterparty_amt"/></xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">counterparty_details_reference_<xsl:value-of select="counterparty_id"/></xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="counterparty_reference"/></xsl:with-param>
     </xsl:call-template>
    </xsl:for-each> 
    
    <!--
     Static Edit Fields 
     -->
    <xsl:if test="$displaymode='edit'">
     <xsl:variable name="currentEntity">
      <xsl:value-of select="//entity"/>
     </xsl:variable>
    
     <xsl:variable name="currentFTType">
      <xsl:value-of select="//ft_type"/>
     </xsl:variable>
     
     <script>
     	dojo.ready(function(){
			misys._config = misys._config || {};
			dojo.mixin(misys._config,  {
				counterpartyAttached : '<xsl:value-of select="count($existing-attachments)"/>'
			});
		});
	 </script>
     
     <button dojoType="dijit.form.Button" id="openCounterpartyDialog" type="button">
      <xsl:attribute name="onclick">misys.showCounterpartyDialog('counterparty');</xsl:attribute>
      <xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_ADD_COUNTERPARTY')"/>
     </button>
     
     <!-- Holder div for hidden fields, created when an item is added -->
     <div id="counterparty_fields"></div>
     
     <xsl:call-template name="dialog">
  	  <xsl:with-param name="id">counterpartyDialog</xsl:with-param>
  	  <xsl:with-param name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_BENEFICIARY_DETAILS')"/></xsl:with-param>
  	  <xsl:with-param name="content">
  	   <div class="required">
        <xsl:call-template name="input-field">
         <xsl:with-param name="label">XSL_PARTIESDETAILS_BENEFICIARY_ACT_NO</xsl:with-param>
         <xsl:with-param name="id">counterparty_details_act_no_nosend</xsl:with-param>
         <xsl:with-param name="size">34</xsl:with-param>
         <xsl:with-param name="maxsize">34</xsl:with-param>
         <xsl:with-param name="button-type">counterparty</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="input-field">
         <xsl:with-param name="label">XSL_PARTIESDETAILS_BENEFICIARY_NAME</xsl:with-param>
         <xsl:with-param name="id">counterparty_details_name_nosend</xsl:with-param>
         <xsl:with-param name="size">34</xsl:with-param>
         <xsl:with-param name="maxsize">34</xsl:with-param>
        </xsl:call-template>
       </div>
       <xsl:if test="$currentFTType = '02'">
        <xsl:call-template name="input-field">
         <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
         <xsl:with-param name="id">counterparty_details_address_line_1_nosend</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="input-field">
         <xsl:with-param name="id">counterparty_details_address_line_2_nosend</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="input-field">
         <xsl:with-param name="id">counterparty_details_dom_nosend</xsl:with-param>
        </xsl:call-template>
       </xsl:if>
       <div class="required">
        <xsl:call-template name="currency-field">
         <xsl:with-param name="label">XSL_PARTIESDETAILS_FT_AMT_LABEL</xsl:with-param>
         <xsl:with-param name="product-code"></xsl:with-param>
         <xsl:with-param name="override-currency-name">counterparty_details_ft_cur_code_nosend</xsl:with-param>
         <xsl:with-param name="override-currency-value"><xsl:value-of select="ft_cur_code"/></xsl:with-param>
         <xsl:with-param name="override-amt-name">counterparty_details_ft_amt_nosend</xsl:with-param>
         <xsl:with-param name="currency-readonly">Y</xsl:with-param>
         <xsl:with-param name="show-button">N</xsl:with-param>
        </xsl:call-template>
<!--         <xsl:call-template name="input-field">-->
<!--          <xsl:with-param name="label">XSL_PARTIESDETAILS_FT_AMT_LABEL</xsl:with-param>-->
<!--          <xsl:with-param name="name">counterparty_details_ft_cur_code_nosend</xsl:with-param>-->
<!--          <xsl:with-param name="value"><xsl:value-of select="ft_cur_code"/></xsl:with-param>-->
<!--          <xsl:with-param name="size">3</xsl:with-param>-->
<!--          <xsl:with-param name="maxsize">3</xsl:with-param>-->
<!--          <xsl:with-param name="fieldsize">x-small</xsl:with-param>-->
<!--          <xsl:with-param name="readonly">Y</xsl:with-param>-->
<!--         </xsl:call-template>-->
<!--        <xsl:call-template name="input-field">-->
<!--         <xsl:with-param name="name">counterparty_details_ft_amt_nosend</xsl:with-param>-->
<!--         <xsl:with-param name="size">21</xsl:with-param>-->
<!--         <xsl:with-param name="maxsize">21</xsl:with-param>-->
<!--         <xsl:with-param name="fieldsize">small</xsl:with-param>-->
<!--         <xsl:with-param name="type">amount</xsl:with-param>-->
<!--        </xsl:call-template>-->
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_SYSTEMFEATURES_FT_COUNTERPARTY_REFERENCE</xsl:with-param>
        <xsl:with-param name="id">counterparty_details_reference_nosend</xsl:with-param>
        <xsl:with-param name="size">12</xsl:with-param>
        <xsl:with-param name="maxsize">12</xsl:with-param>
       </xsl:call-template>
      </div>
  	  </xsl:with-param>
  	  <xsl:with-param name="buttons">
  	   <xsl:call-template name="row-wrapper">
        <xsl:with-param name="id">addCounterpartyButton</xsl:with-param>
        <xsl:with-param name="content">
         <button dojoType="dijit.form.Button" id="addCounterpartyButton" type="button">
          <xsl:attribute name="onclick">misys.addCounterpartyAddon('counterparty');</xsl:attribute>
          <xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SAVE')"/>
         </button>
         <button dojoType="dijit.form.Button" id="cancelCounterpartyButton" type="button">
          <xsl:attribute name="onclick">misys.hideTransactionAddonsDialog('counterparty');</xsl:attribute>
          <xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/>
         </button>
        </xsl:with-param>
       </xsl:call-template>
  	  </xsl:with-param>
	 </xsl:call-template>
    </xsl:if>
   </xsl:with-param>
  </xsl:call-template>
</xsl:template>

<!-- 
 Complete a row in the table for an existing customer reference
 -->
<xsl:template name="customer-reference-table-row">
  <td><div style="white-space:pre;"><xsl:value-of select="utils:decryptApplicantReference(reference)" /></div></td>
  <td><div style="white-space:pre;"><xsl:value-of select="utils:decryptApplicantReference(description)" /></div></td>
</xsl:template>

<!-- 
 Complete a row in the table for an existing counterparty
 -->
<xsl:template name="counterparty-table-row">
 <td><xsl:value-of select="counterparty_act_no"/></td>
 <td><xsl:value-of select="counterparty_name"/>
 <xsl:if test="counterparty_address_line_1[.!= '']">
  <br/><xsl:value-of select="counterparty_address_line_1"/>
  <xsl:if test="counterparty_address_line_2[.!= '']">
   <br/><xsl:value-of select="counterparty_address_line_2"/>
  </xsl:if>
  <xsl:if test="counterparty_dom[.!= '']">
   <br/><xsl:value-of select="counterparty_dom"/>
  </xsl:if>
 </xsl:if>
 </td>
 <td>
  <xsl:value-of select="counterparty_cur_code"/>&nbsp;<xsl:value-of select="counterparty_amt"/>
 </td>
 <td>
  <xsl:value-of select="counterparty_reference"/>
 </td>
</xsl:template>

<!--
 Attach charges 
 -->
<xsl:template name="attachments-charges">
 <xsl:param name="max-attachments">-1</xsl:param>
 <xsl:param name="collapsible-prefix"/>
 <xsl:param name="legend">XSL_HEADER_PRODUCT_CHARGE_DETAILS</xsl:param>
 <xsl:param name="existing-attachments" select="charges/charge"/>
 <xsl:variable name="isMT798"><xsl:value-of select="is_MT798"/></xsl:variable>
 <xsl:call-template name="fieldset-wrapper">
  <xsl:with-param name="legend"><xsl:value-of select="$legend"></xsl:value-of></xsl:with-param>
  <xsl:with-param name="collapsible-prefix"><xsl:value-of select="$collapsible-prefix"/></xsl:with-param>
  <xsl:with-param name="legend-type">
	  <xsl:choose>
	  	<xsl:when test="$displaymode='view' and $mode!='UNSIGNED' and $collapsible-prefix=''">indented-header</xsl:when>
	  	<xsl:when test="$mode!='UNSIGNED' and $collapsible-prefix!=''">collapsible</xsl:when>
	  	<xsl:otherwise>toplevel-header</xsl:otherwise>
	  </xsl:choose>
  </xsl:with-param>
  <xsl:with-param name="content">
   <xsl:call-template name="attachments-table">
    <xsl:with-param name="collapsible-prefix"><xsl:value-of select="$collapsible-prefix"/></xsl:with-param>
    <xsl:with-param name="max-attachments" select="$max-attachments"/>
    <xsl:with-param name="existing-attachments" select="$existing-attachments"/>
    <xsl:with-param name="table-caption">XSL_PRODUCT_CHARGE_TABLE_CAPTION</xsl:with-param>
    <xsl:with-param name="table-summary">XSL_PRODUCT_CHARGE_TABLE_SUMMARY</xsl:with-param>
    <xsl:with-param name="isMT798" select="$isMT798"/>
    <xsl:with-param name="table-thead">
     <th class="chrg-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_CHARGE_HEADER_CHARGE')"/></th>
     <th class="chrg-comment-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_CHARGE_DESCRIPTION')"/></th>
     <th style="width:26px" scope="col"><xsl:value-of select="localization:getGTPString($language, 'CURCODE')"/></th>
     <th class="chrg-amt-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_CHARGE_HEADER_AMOUNT')"/></th>
     <th scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_CHARGE_HEADER_STATUS')"/></th>
     <th scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_CHARGE_HEADER_SETTLEMENT_DATE')"/></th>
     <xsl:if test="$isMT798='Y' and $isMT798 !=''">
     <th class="chrg-type-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTING_CHARGE_TYPE')"/></th>
     </xsl:if>
    </xsl:with-param>
    <xsl:with-param name="table-row-type">charge</xsl:with-param>
    <xsl:with-param name="empty-table-notice">XSL_REPORTINGDETAILS_NO_CHARGE</xsl:with-param>
    <xsl:with-param name="delete-attachments-notice">XSL_TITLE_CHARGE_NOTICE</xsl:with-param>
   </xsl:call-template>
    
   <!--
    Hidden Fields 
    -->
   <xsl:for-each select="$existing-attachments">
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">charge_details_chrg_details_<xsl:value-of select="chrg_id"/></xsl:with-param>
     <xsl:with-param name="value">
      <xsl:choose>
      <!--  <xsl:when test="chrg_code[.='ISSFEE']">
        <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_CODE_ISSFEE')"/>
       </xsl:when>
       <xsl:when test="chrg_code[.='COMMISSION']">
        <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_CODE_COMMISSION')"/>
       </xsl:when>
       <xsl:when test="chrg_code[.='OTHER']">
        <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_CODE_OTHER')"/>
       </xsl:when> -->
       
       <xsl:when test="chrg_code[. != '']">
       		<xsl:value-of select="localization:getDecode($language, 'N006', chrg_code)" />
       </xsl:when>
       <xsl:otherwise>
       		<xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_CODE_OTHER')" />
       </xsl:otherwise>
      </xsl:choose>
     </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">charge_details_additional_comment_<xsl:value-of select="chrg_id"/></xsl:with-param>
     <xsl:with-param name="value" select="additional_comment"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">charge_details_chrg_type_<xsl:value-of select="chrg_id"/></xsl:with-param>
     <xsl:with-param name="value" select="chrg_type"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">charge_details_chrg_code_<xsl:value-of select="chrg_id"/></xsl:with-param>
     <xsl:with-param name="value" select="chrg_code"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">charge_details_cur_code_<xsl:value-of select="chrg_id"/></xsl:with-param>
     <xsl:with-param name="value" select="cur_code"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">charge_details_amt_<xsl:value-of select="chrg_id"/></xsl:with-param>
     <xsl:with-param name="value" select="amt"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">charge_details_status_<xsl:value-of select="chrg_id"/></xsl:with-param>
     <xsl:with-param name="value" select="status"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">charge_details_settlement_date_<xsl:value-of select="chrg_id"/></xsl:with-param>
     <xsl:with-param name="value" select="settlement_date"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">charge_details_chrg_id_<xsl:value-of select="chrg_id"/></xsl:with-param>
     <xsl:with-param name="value" select="chrg_id"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">charge_details_inception_date_<xsl:value-of select="chrg_id"/></xsl:with-param>
     <xsl:with-param name="value">
      <xsl:choose>
       <xsl:when test="inception_date"><xsl:value-of select="inception_date"/></xsl:when>
       <xsl:otherwise><xsl:value-of select="/*/current_date"/></xsl:otherwise>
      </xsl:choose>
     </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">charge_details_exchange_rate_<xsl:value-of select="chrg_id"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">charge_details_eqv_cur_code_<xsl:value-of select="chrg_id"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">charge_details_eqv_amt_<xsl:value-of select="chrg_id"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">charge_details_bearer_role_code_<xsl:value-of select="chrg_id"/></xsl:with-param>
     <xsl:with-param name="value">
      <xsl:choose>
       <xsl:when test="/*/product_code[.='LC' or .='BG' or .='SG' or .='FT' or .='TF' or .='SI' or .='LI']">01</xsl:when>
       <xsl:when test="/*/product_code[.='EL' or .='SR']">02</xsl:when>
       <xsl:when test="/*/product_code[.='IC' or .='IR']">03</xsl:when>
       <xsl:when test="/*/product_code[.='EC']">04</xsl:when>
      </xsl:choose>
     </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">charge_details_created_in_session_<xsl:value-of select="chrg_id"/></xsl:with-param>
     <xsl:with-param name="value">
      <xsl:choose>
       <xsl:when test="created_in_session"><xsl:value-of select="created_in_session"/></xsl:when>
       <xsl:otherwise>Y</xsl:otherwise>
      </xsl:choose>
     </xsl:with-param>
    </xsl:call-template>
   </xsl:for-each>
    
   <!--
    Edit Fields 
   -->
   <xsl:if test="$displaymode='edit'">
     <script> 
     	dojo.ready(function(){
			misys._config = misys._config || {};
			dojo.mixin(misys._config,  {
				chargeAttached : '<xsl:value-of select="count($existing-attachments)"/>'
			});
		});
	 </script>
    
    <button dojoType="dijit.form.Button" type="button">
     <xsl:attribute name="id"><xsl:value-of select="concat($collapsible-prefix,'openChargeDialog')"/></xsl:attribute>
     <xsl:attribute name="onclick">misys.showTransactionAddonsDialog('charge','<xsl:value-of select="$collapsible-prefix"/>');</xsl:attribute>
     <xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_ADD_CHARGE')"/>
    </button>

	<!-- Holder for hidden fields -->
	<div id="charge_fields"></div>

	<xsl:call-template name="dialog">
     <xsl:with-param name="id"><xsl:value-of select="$collapsible-prefix"/>chargeDialog</xsl:with-param>
     <xsl:with-param name="title">
     	<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PRODUCT_CHARGE_DETAILS')"/>
     </xsl:with-param>
     
     <xsl:with-param name="content">
      <div class="required">
       <xsl:choose>
       <xsl:when test="defaultresource:getResource('CHRGE_CODE_DB_CHECK_UI_DROPDOWN') != 'true'">
       <xsl:variable name="charge-label">XSL_REPORTINGDETAILS_CHARGE</xsl:variable>
       <xsl:call-template name="select-field">
        <xsl:with-param name="label"><xsl:value-of select="$charge-label"/></xsl:with-param>
        <xsl:with-param name="name"><xsl:value-of select="$collapsible-prefix"/>charge_details_chrg_code_nosend</xsl:with-param>
        <xsl:with-param name="required">Y</xsl:with-param>
        <xsl:with-param name="options">
         <xsl:choose>
          <xsl:when test="$displaymode='edit'">	        
	        <option value="ISSFEE">
	         <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_CODE_ISSFEE')"/>
	        </option>
	        <option value="COMMISSION">
	         <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_CODE_COMMISSION')"/>
	        </option>
	        <option value="OTHER">
	         <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_CODE_OTHER')"/>
	        </option>
          </xsl:when>
          <xsl:otherwise>
           <xsl:choose>
	        <!-- <xsl:when test="chrg_code[.='ISSFEE']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_CODE_ISSFEE')"/></xsl:when>
	        <xsl:when test="chrg_code[.='COMMISSION']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_CODE_COMMISSION')"/></xsl:when>
	        <xsl:when test="chrg_code[.='OTHER']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_CODE_OTHER')"/></xsl:when> -->
	       	<xsl:when test="chrg_code[. != '']">
		    	<xsl:value-of select="localization:getDecode($language, 'N006', chrg_code)" />
			</xsl:when>
          	<xsl:otherwise>
          	  <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_CODE_OTHER')" />
         	</xsl:otherwise>
	       </xsl:choose>
          </xsl:otherwise>
         </xsl:choose>
        </xsl:with-param>
       </xsl:call-template>
       </xsl:when>
      <xsl:otherwise>
       <xsl:variable name="charge-label">XSL_REPORTINGDETAILS_CHARGE</xsl:variable>
		<xsl:call-template name="select-field">
		<xsl:with-param name="required">Y</xsl:with-param>
		 <xsl:with-param name="label"><xsl:value-of select="$charge-label"/></xsl:with-param>
			<xsl:with-param name="name">
				<xsl:value-of select="$collapsible-prefix" />charge_details_chrg_code_nosend</xsl:with-param>
			<xsl:with-param name="options">
				<xsl:call-template name="code-data-options">
					<xsl:with-param name="paramId">C080</xsl:with-param>
					<xsl:with-param name="productCode">*</xsl:with-param>
					<xsl:with-param name="specificOrder">Y</xsl:with-param>
					<xsl:with-param name="value"><xsl:if test="chrg_code[.!='']"><xsl:value-of select="chrg_code"/></xsl:if></xsl:with-param>
					</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		</xsl:otherwise>
		 </xsl:choose>
      </div>
	      <xsl:call-template name="row-wrapper">
		       <xsl:with-param name="required">Y</xsl:with-param> 
		       <xsl:with-param name="id"><xsl:value-of select="$collapsible-prefix"/>charge_details_additional_comment_nosend</xsl:with-param>
		       <xsl:with-param name="label">XSL_REPORTINGDETAILS_CHARGE_DESCRIPTION</xsl:with-param>
		       <xsl:with-param name="type">textarea</xsl:with-param>
		       <xsl:with-param name="content">
		        <xsl:call-template name="textarea-field">
			         <xsl:with-param name="override-form-name">fakeform0</xsl:with-param>
			         <xsl:with-param name="id"><xsl:value-of select="$collapsible-prefix"/>charge_details_additional_comment_nosend</xsl:with-param>
			          <xsl:with-param name="regular-expression">[^\%^&lt;&gt;]*</xsl:with-param>
			         <xsl:with-param name="rows">5</xsl:with-param>
			         <xsl:with-param name="cols">45</xsl:with-param>
			         <xsl:with-param name="maxlines">8</xsl:with-param>
			    </xsl:call-template>
	       	 </xsl:with-param>
	      </xsl:call-template>
	      <xsl:variable name="isMT798"><xsl:value-of select="is_MT798"/></xsl:variable>
	      <xsl:if test="$isMT798='Y'">
	      <div id = "charge_type_div">
	        <xsl:call-template name="select-field">
		        <xsl:with-param name="label">XSL_REPORTING_CHARGE_TYPE</xsl:with-param>
         		<xsl:with-param name="name"><xsl:value-of select="$collapsible-prefix"/>charge_details_chrg_type_nosend</xsl:with-param>
		      	<xsl:with-param name="required">N</xsl:with-param>
		        <xsl:with-param name="options">
		        <xsl:choose>
		          <xsl:when test="$displaymode='edit'">	        
			        <option value="C">
			         <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_TYPE_CREDIT')"/>
			        </option>
			        <option value="D">
			         <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_TYPE_DEBIT')"/>
			        </option>
		          </xsl:when>
		          <xsl:otherwise>
		           <xsl:choose>
			        <xsl:when test="chrg_type[.='C']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_TYPE_CREDIT')"/></xsl:when>
			        <xsl:when test="chrg_type[.='D']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_TYPE_DEBIT')"/></xsl:when>
			       </xsl:choose>
		          </xsl:otherwise>
		        </xsl:choose>
		        </xsl:with-param>
       		</xsl:call-template>
       </div>
       </xsl:if>
      
         <div class="required">
         <xsl:call-template name="currency-field">
         <xsl:with-param name="label">XSL_REPORTINGDETAILS_CHARGE_AMOUNT</xsl:with-param>
         <xsl:with-param name="product-code"></xsl:with-param>
         <xsl:with-param name="override-currency-name"><xsl:value-of select="$collapsible-prefix"/>charge_details_cur_code_nosend</xsl:with-param>
         <xsl:with-param name="required">Y</xsl:with-param>
         <xsl:with-param name="override-currency-value">         
         <xsl:choose>
           <xsl:when test="cur_code"><xsl:value-of select="cur_code"/></xsl:when>
           <xsl:when test="/*/tnx_cur_code[. != '']"><xsl:value-of select="/*/tnx_cur_code"/></xsl:when>
           <xsl:otherwise>
            <xsl:choose>
             <xsl:when test="/bg_tnx_record/bg_cur_code[. != '']"><xsl:value-of select="/bg_tnx_record/bg_cur_code"/></xsl:when>
             <xsl:when test="/ec_tnx_record/ec_cur_code[. != '']"><xsl:value-of select="/ec_tnx_record/ec_cur_code"/></xsl:when>
             <xsl:when test="/el_tnx_record/lc_cur_code[. != '']"><xsl:value-of select="/el_tnx_record/lc_cur_code"/></xsl:when>
             <xsl:when test="/ft_tnx_record/ft_cur_code[. != '']"><xsl:value-of select="/ft_tnx_record/ft_cur_code"/></xsl:when>
             <xsl:when test="/ic_tnx_record/ic_cur_code[. != '']"><xsl:value-of select="/ic_tnx_record/ic_cur_code"/></xsl:when>
             <xsl:when test="/ir_tnx_record/ir_cur_code[. != '']"><xsl:value-of select="/ir_tnx_record/ir_cur_code"/></xsl:when>
             <xsl:when test="/lc_tnx_record/lc_cur_code[. != '']"><xsl:value-of select="/lc_tnx_record/lc_cur_code"/></xsl:when>
             <xsl:when test="/sg_tnx_record/sg_cur_code[. != '']"><xsl:value-of select="/sg_tnx_record/sg_cur_code"/></xsl:when>
             <xsl:when test="/tf_tnx_record/fin_cur_code[. != '']"><xsl:value-of select="/tf_tnx_record/fin_cur_code"/></xsl:when>
             <xsl:when test="/po_tnx_record/total_cur_code[. != '']"><xsl:value-of select="/po_tnx_record/total_cur_code"/></xsl:when>
             <xsl:when test="/so_tnx_record/total_cur_code[. != '']"><xsl:value-of select="/so_tnx_record/total_cur_code"/></xsl:when>
            </xsl:choose>
           </xsl:otherwise>
          </xsl:choose>
         </xsl:with-param>
         <xsl:with-param name="override-amt-name"><xsl:value-of select="$collapsible-prefix"/>charge_details_amt_nosend</xsl:with-param>
         <xsl:with-param name="button-type">charge</xsl:with-param>
        </xsl:call-template>
       
       <xsl:if test="$collapsible-prefix=''">
			<xsl:call-template name="select-field">
	        <xsl:with-param name="label">XSL_REPORTINGDETAILS_CHARGE_STATUS</xsl:with-param>
	        <xsl:with-param name="id"><xsl:value-of select="$collapsible-prefix"/>charge_details_status_nosend</xsl:with-param>
	       	<xsl:with-param name="required">Y</xsl:with-param>       
	        <xsl:with-param name="options">
	          <xsl:choose>
	           <xsl:when test="$displaymode='edit'">
	            <option value=""/>
		         <option value="01">
		          <xsl:value-of select="localization:getDecode($language, 'N057', '01')"/>
		         </option>
		         <option value="02">
		          	<xsl:value-of select="localization:getDecode($language, 'N057', '02')"/>
		         </option>
		         <option value="03">
		         	<xsl:value-of select="localization:getDecode($language, 'N057', '03')"/>
		         </option>
		         <option value="99">
		         	<xsl:value-of select="localization:getDecode($language, 'N057', '99')"/>
		         </option>
	           </xsl:when>
	           <xsl:otherwise>
		         <xsl:choose>
		          <xsl:when test="status[. = '01']"><xsl:value-of select="localization:getDecode($language, 'N057', '01')"/></xsl:when>
		          <xsl:when test="status[. = '02']"><xsl:value-of select="localization:getDecode($language, 'N057', '02')"/></xsl:when>
		          <xsl:when test="status[. = '03']"><xsl:value-of select="localization:getDecode($language, 'N057', '03')"/></xsl:when>
		          <xsl:when test="status[. = '04']"><xsl:value-of select="localization:getDecode($language, 'N057', '04')"/></xsl:when>
		          <xsl:when test="status[. = '05']"><xsl:value-of select="localization:getDecode($language, 'N057', '05')"/></xsl:when>
		          <xsl:when test="status[. = '99']"><xsl:value-of select="localization:getDecode($language, 'N057', '99')"/></xsl:when>
		         </xsl:choose>
	           </xsl:otherwise>
	          </xsl:choose>
	        </xsl:with-param>
	       </xsl:call-template>
       </xsl:if>
       </div>
       <xsl:call-template name="hidden-field">
       <xsl:with-param name="id">currentDate</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="current_date" /></xsl:with-param>
       </xsl:call-template>
        <xsl:call-template name="hidden-field">
        	<xsl:with-param name="name">is_MT798</xsl:with-param>
     	</xsl:call-template>
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_REPORTINGDETAILS_CHARGE_SETTLEMENT_DATE</xsl:with-param>
        <xsl:with-param name="id"><xsl:value-of select="$collapsible-prefix"/>charge_details_settlement_date_nosend</xsl:with-param>
        <xsl:with-param name="size">10</xsl:with-param>
        <xsl:with-param name="type">date</xsl:with-param>
        <xsl:with-param name="fieldsize">small</xsl:with-param>
        <xsl:with-param name="disabled">Y</xsl:with-param>
       </xsl:call-template>
     </xsl:with-param>
     <xsl:with-param name="buttons">
       <xsl:call-template name="row-wrapper">
        <xsl:with-param name="id"><xsl:value-of select="$collapsible-prefix"/>addChargeButton</xsl:with-param>
        <xsl:with-param name="content">
         <button dojoType="dijit.form.Button" type="button">
          <xsl:attribute name="id"><xsl:value-of select="$collapsible-prefix"/>addChargeButton</xsl:attribute>
          <xsl:attribute name="onclick">misys.addTransactionAddon('charge','<xsl:value-of select="$collapsible-prefix"/>')</xsl:attribute>
          <xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SAVE')"/>
         </button>
         <button dojoType="dijit.form.Button" type="button">
          <xsl:attribute name="id"><xsl:value-of select="$collapsible-prefix"/>cancelChargeButton</xsl:attribute>
          <xsl:attribute name="onclick">misys.hideTransactionAddonsDialog('charge','<xsl:value-of select="$collapsible-prefix"/>');</xsl:attribute>
          <xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/>
         </button>
        </xsl:with-param>
       </xsl:call-template>
     </xsl:with-param>
    </xsl:call-template>
   </xsl:if>
  </xsl:with-param>
 </xsl:call-template>
</xsl:template>

<!-- 
Attach FEES
 -->
 
<xsl:template name="attachments-fees">
 <xsl:param name="max-attachments">-1</xsl:param>
 <xsl:param name="collapsible-prefix"/>
 <xsl:param name="legend">XSL_HEADER_PRODUCT_CHARGE_DETAILS</xsl:param>

 <xsl:param name="existing-attachments" select="fees/fee"/>
 
 <xsl:call-template name="fieldset-wrapper">
  <xsl:with-param name="legend"><xsl:value-of select="$legend"></xsl:value-of> </xsl:with-param>
  <xsl:with-param name="collapsible-prefix"><xsl:value-of select="$collapsible-prefix"/></xsl:with-param>
  <xsl:with-param name="legend-type">
	  <xsl:choose>
	  	<xsl:when test="$displaymode='view' and $collapsible-prefix=''">indented-header</xsl:when>
	  	<xsl:when test="$collapsible-prefix!=''">collapsible</xsl:when>
	  	<xsl:otherwise>toplevel-header</xsl:otherwise>
	  </xsl:choose>
  </xsl:with-param>
  <xsl:with-param name="content">
   <xsl:call-template name="attachments-table">
    <xsl:with-param name="collapsible-prefix"><xsl:value-of select="$collapsible-prefix"/></xsl:with-param>
    <xsl:with-param name="max-attachments" select="$max-attachments"/>
    <xsl:with-param name="existing-attachments" select="$existing-attachments"/>
    <xsl:with-param name="table-caption">XSL_PRODUCT_FEE_TABLE_CAPTION</xsl:with-param>
    <xsl:with-param name="table-summary">XSL_PRODUCT_FEE_TABLE_SUMMARY</xsl:with-param>
    <xsl:with-param name="table-thead">
     <th class="chrg-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_FEE_HEADER_FEE')"/></th>
     <th style="width:26px" scope="col"><xsl:value-of select="localization:getGTPString($language, 'CURCODE')"/></th>
     <th class="chrg-amt-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_FEE_HEADER_AMOUNT')"/></th>
     <th scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_FEE_HEADER_SETTLEMENT_DATE')"/></th>
    </xsl:with-param>
    <xsl:with-param name="table-row-type">fee</xsl:with-param>
    <xsl:with-param name="empty-table-notice">XSL_REPORTINGDETAILS_NO_FEE</xsl:with-param>
    <xsl:with-param name="delete-attachments-notice">XSL_TITLE_FEE_NOTICE</xsl:with-param>
   </xsl:call-template>
    
   <!--
    Hidden Fields 
    -->
   <xsl:for-each select="$existing-attachments">
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">fee_details_chrg_details_<xsl:value-of select="chrg_id"/></xsl:with-param>
     <xsl:with-param name="value">
      <xsl:choose>
       <!-- <xsl:when test="chrg_code[.='ISSFEE']">
        <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_CODE_ISSFEE')"/>
       </xsl:when>
       <xsl:when test="chrg_code[.='COMMISSION']">
        <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_CODE_COMMISSION')"/>
       </xsl:when>
       <xsl:when test="chrg_code[.='OTHER']">
        <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_CODE_OTHER')"/>
       </xsl:when> -->
       <xsl:when test="chrg_code[. != '']">
	       <xsl:value-of select="localization:getDecode($language, 'N006', chrg_code)" />
	   </xsl:when>
       <xsl:otherwise>
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_CODE_OTHER')" />
       </xsl:otherwise>
      </xsl:choose>
     </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">fee_details_chrg_code_<xsl:value-of select="chrg_id"/></xsl:with-param>
     <xsl:with-param name="value" select="chrg_code"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">fee_details_cur_code_<xsl:value-of select="chrg_id"/></xsl:with-param>
     <xsl:with-param name="value" select="cur_code"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">fee_details_amt_<xsl:value-of select="chrg_id"/></xsl:with-param>
     <xsl:with-param name="value" select="amt"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">fee_details_settlement_date_<xsl:value-of select="chrg_id"/></xsl:with-param>
     <xsl:with-param name="value" select="settlement_date"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">fee_details_chrg_id_<xsl:value-of select="chrg_id"/></xsl:with-param>
     <xsl:with-param name="value" select="chrg_id"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">fee_details_inception_date_<xsl:value-of select="chrg_id"/></xsl:with-param>
     <xsl:with-param name="value">
      <xsl:choose>
       <xsl:when test="inception_date"><xsl:value-of select="inception_date"/></xsl:when>
       <xsl:otherwise><xsl:value-of select="/*/current_date"/></xsl:otherwise>
      </xsl:choose>
     </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">fee_details_exchange_rate_<xsl:value-of select="chrg_id"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">fee_details_eqv_cur_code_<xsl:value-of select="chrg_id"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">fee_details_eqv_amt_<xsl:value-of select="chrg_id"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">fee_details_bearer_role_code_<xsl:value-of select="chrg_id"/></xsl:with-param>
     <xsl:with-param name="value">
      <xsl:choose>
       <xsl:when test="/*/product_code[.='LC' or .='BG' or .='SG' or .='FT' or .='TF' or .='SI' or .='LI']">01</xsl:when>
       <xsl:when test="/*/product_code[.='EL' or .='SR']">02</xsl:when>
       <xsl:when test="/*/product_code[.='IC' or .='IR']">03</xsl:when>
       <xsl:when test="/*/product_code[.='EC']">04</xsl:when>
      </xsl:choose>
     </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">fee_details_created_in_session_<xsl:value-of select="chrg_id"/></xsl:with-param>
     <xsl:with-param name="value">
      <xsl:choose>
       <xsl:when test="created_in_session"><xsl:value-of select="created_in_session"/></xsl:when>
       <xsl:otherwise>Y</xsl:otherwise>
      </xsl:choose>
     </xsl:with-param>
    </xsl:call-template>
   </xsl:for-each>
    
   <!--
    Edit Fields 
   -->
   <xsl:if test="$displaymode='edit'">
    <script>
    	dojo.ready(function(){
			misys._config = misys._config || {};
			dojo.mixin(misys._config,  {
				feeAttached : '<xsl:value-of select="count($existing-attachments)"/>'
			});
		});
	</script>
    
    <button dojoType="dijit.form.Button" type="button">
     <xsl:attribute name="id"><xsl:value-of select="concat($collapsible-prefix,'openChargeDialog')"/></xsl:attribute>
     <xsl:attribute name="onclick">misys.showTransactionAddonsDialog('fee','<xsl:value-of select="$collapsible-prefix"/>');</xsl:attribute>
     <xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_ADD_FEE')"/>
    </button>

	<!-- Holder for hidden fields -->
	<div id="fee_fields"></div>

	<xsl:call-template name="dialog">
     <xsl:with-param name="id"><xsl:value-of select="$collapsible-prefix"/>feeDialog</xsl:with-param>
     <xsl:with-param name="title">
     	<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PRODUCT_FEE_DETAILS')"/>
     
     </xsl:with-param>
     
     <xsl:with-param name="content">
      <div class="required">
      
       <xsl:call-template name="select-field">
        <xsl:with-param name="label">XSL_REPORTINGDETAILS_FEE_TYPE</xsl:with-param>
        <xsl:with-param name="id"><xsl:value-of select="$collapsible-prefix"/>fee_details_chrg_code_nosend</xsl:with-param>
        <xsl:with-param name="options">
         <xsl:choose>
          <xsl:when test="$displaymode='edit'">
	        <option value=""/>
	        <option value="BEX">
	         <xsl:value-of select="localization:getGTPString($language, 'XSL_FEE_CODE_BEX')"/>
	        </option>
	        <option value="BCL">
	         <xsl:value-of select="localization:getGTPString($language, 'XSL_FEE_CODE_BCL')"/>
	        </option>
	        <option value="UPF">
	         <xsl:value-of select="localization:getGTPString($language, 'XSL_FEE_CODE_UPF')"/>
	        </option>
	        <option value="UWC">
	         <xsl:value-of select="localization:getGTPString($language, 'XSL_FEE_CODE_UWC')"/>
	        </option>
	        <option value="CSR">
	         <xsl:value-of select="localization:getGTPString($language, 'XSL_FEE_CODE_CSR')"/>
	        </option>
	        <option value="PRM">
	         <xsl:value-of select="localization:getGTPString($language, 'XSL_FEE_CODE_PRM')"/>
	        </option>	        
          </xsl:when>
          <xsl:otherwise>
           <xsl:choose>
	        <!-- <xsl:when test="chrg_code[.='ISSFEE']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_CODE_ISSFEE')"/></xsl:when>
	        <xsl:when test="chrg_code[.='COMMISSION']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_CODE_COMMISSION')"/></xsl:when>
	        <xsl:when test="chrg_code[.='OTHER']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_CODE_OTHER')"/></xsl:when> -->
	        <xsl:when test="chrg_code[. != '']">
				<xsl:value-of select="localization:getDecode($language, 'N006', chrg_code)" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_CODE_OTHER')" />
            </xsl:otherwise>
	       </xsl:choose>
          </xsl:otherwise>
         </xsl:choose>
        </xsl:with-param>
       </xsl:call-template>
      </div>
	   <div class="required">
         <xsl:call-template name="currency-field">
         <xsl:with-param name="label">XSL_REPORTINGDETAILS_FEE_AMOUNT</xsl:with-param>
         <xsl:with-param name="product-code"></xsl:with-param>
         <xsl:with-param name="override-currency-name"><xsl:value-of select="$collapsible-prefix"/>fee_details_cur_code_nosend</xsl:with-param>
         <xsl:with-param name="override-currency-value">
         <xsl:choose>
           <xsl:when test="cur_code"><xsl:value-of select="cur_code"/></xsl:when>
           <xsl:when test="/*/tnx_cur_code[. != '']"><xsl:value-of select="/*/tnx_cur_code"/></xsl:when>
           <xsl:otherwise>
            <xsl:choose>
             <xsl:when test="/bg_tnx_record/bg_cur_code[. != '']"><xsl:value-of select="/bg_tnx_record/bg_cur_code"/></xsl:when>
             <xsl:when test="/ec_tnx_record/ec_cur_code[. != '']"><xsl:value-of select="/ec_tnx_record/ec_cur_code"/></xsl:when>
             <xsl:when test="/el_tnx_record/lc_cur_code[. != '']"><xsl:value-of select="/el_tnx_record/lc_cur_code"/></xsl:when>
             <xsl:when test="/ft_tnx_record/ft_cur_code[. != '']"><xsl:value-of select="/ft_tnx_record/ft_cur_code"/></xsl:when>
             <xsl:when test="/ic_tnx_record/ic_cur_code[. != '']"><xsl:value-of select="/ic_tnx_record/ic_cur_code"/></xsl:when>
             <xsl:when test="/ir_tnx_record/ir_cur_code[. != '']"><xsl:value-of select="/ir_tnx_record/ir_cur_code"/></xsl:when>
             <xsl:when test="/lc_tnx_record/lc_cur_code[. != '']"><xsl:value-of select="/lc_tnx_record/lc_cur_code"/></xsl:when>
             <xsl:when test="/sg_tnx_record/sg_cur_code[. != '']"><xsl:value-of select="/sg_tnx_record/sg_cur_code"/></xsl:when>
             <xsl:when test="/tf_tnx_record/fin_cur_code[. != '']"><xsl:value-of select="/tf_tnx_record/fin_cur_code"/></xsl:when>
             <xsl:when test="/po_tnx_record/total_cur_code[. != '']"><xsl:value-of select="/po_tnx_record/total_cur_code"/></xsl:when>
             <xsl:when test="/so_tnx_record/total_cur_code[. != '']"><xsl:value-of select="/so_tnx_record/total_cur_code"/></xsl:when>
            </xsl:choose>
           </xsl:otherwise>
          </xsl:choose>
         </xsl:with-param>
         <xsl:with-param name="override-amt-name"><xsl:value-of select="$collapsible-prefix"/>fee_details_amt_nosend</xsl:with-param>
         <xsl:with-param name="button-type">fee</xsl:with-param>
        </xsl:call-template>
       
         </div>
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_REPORTINGDETAILS_FEE_SETTLEMENT_DATE</xsl:with-param>
        <xsl:with-param name="id"><xsl:value-of select="$collapsible-prefix"/>fee_details_settlement_date_nosend</xsl:with-param>
        <xsl:with-param name="size">10</xsl:with-param>
        <xsl:with-param name="type">date</xsl:with-param>
        <xsl:with-param name="fieldsize">small</xsl:with-param>
        <xsl:with-param name="disabled">N</xsl:with-param>
       </xsl:call-template>
     </xsl:with-param>
     <xsl:with-param name="buttons">
       <xsl:call-template name="row-wrapper">
        <xsl:with-param name="content">
         <button dojoType="dijit.form.Button" type="button">
          <xsl:attribute name="id"><xsl:value-of select="$collapsible-prefix"/>addChargeButton</xsl:attribute>
          <xsl:attribute name="onclick">misys.addTransactionAddon('fee','<xsl:value-of select="$collapsible-prefix"/>')</xsl:attribute>
          <xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SAVE')"/>
         </button>
         <button dojoType="dijit.form.Button" type="button">
          <xsl:attribute name="id"><xsl:value-of select="$collapsible-prefix"/>cancelChargeButton</xsl:attribute>
          <xsl:attribute name="onclick">misys.hideTransactionAddonsDialog('fee','<xsl:value-of select="$collapsible-prefix"/>');</xsl:attribute>
          <xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/>
         </button>
        </xsl:with-param>
       </xsl:call-template>
     </xsl:with-param>
    </xsl:call-template>
   </xsl:if>
  </xsl:with-param>
 </xsl:call-template>
</xsl:template>


<!-- 
 Complete a row in the table for an existing counterparty
 -->
<xsl:template name="charge-table-row">
<xsl:param name="isMT798">N</xsl:param>
 <td>
  <xsl:choose>
   <!-- <xsl:when test="chrg_code[.='ISSFEE']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_CODE_ISSFEE')"/></xsl:when>
   <xsl:when test="chrg_code[.='COMMISSION']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_CODE_COMMISSION')"/></xsl:when>
   <xsl:when test="chrg_code[.='OTHER']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_CODE_OTHER')"/></xsl:when> -->
   <xsl:when test="chrg_code[. != ''] and defaultresource:getResource('CHRGE_CODE_DB_CHECK') != 'true'">
		<xsl:value-of select="localization:getDecode($language, 'N006', chrg_code)" />
   </xsl:when>
   <xsl:when test="chrg_code[. != ''] and defaultresource:getResource('CHRGE_CODE_DB_CHECK') = 'true'">	
		<xsl:value-of select="localization:getCodeData($language,'*','*','C080',chrg_code)"/>
   </xsl:when>
   <xsl:otherwise>
        <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_CODE_OTHER')" />
   </xsl:otherwise>
  </xsl:choose>
 </td>
 <td class="chrgaddcmt"><xsl:value-of select="additional_comment"/></td>
 <td><xsl:choose>
	 	<xsl:when test="eqv_cur_code[.!='']"><xsl:value-of select="eqv_cur_code"/></xsl:when>
	 	<xsl:otherwise><xsl:value-of select="cur_code"/></xsl:otherwise>
 	</xsl:choose>
 </td>
 <td>
  <xsl:choose>
  	<xsl:when test="eqv_amt[.!='']"><xsl:value-of select="eqv_amt"/></xsl:when>
  	<xsl:otherwise><xsl:value-of select="amt"/></xsl:otherwise>
  </xsl:choose>
 </td>
 <td>
  <xsl:choose>
   <xsl:when test="status[. = '01']"><xsl:value-of select="localization:getDecode($language, 'N057', '01')"/></xsl:when>
   <xsl:when test="status[. = '02']"><xsl:value-of select="localization:getDecode($language, 'N057', '02')"/></xsl:when>
   <xsl:when test="status[. = '03']"><xsl:value-of select="localization:getDecode($language, 'N057', '03')"/></xsl:when>
   <xsl:when test="status[. = '04']"><xsl:value-of select="localization:getDecode($language, 'N057', '04')"/></xsl:when>
   <xsl:when test="status[. = '05']"><xsl:value-of select="localization:getDecode($language, 'N057', '05')"/></xsl:when>
   <xsl:when test="status[. = '99']"><xsl:value-of select="localization:getDecode($language, 'N057', '99')"/></xsl:when>
  </xsl:choose>
 </td>
 <td>
  <xsl:value-of select="settlement_date"/>
 </td>
 <xsl:if test="$isMT798='Y'">
	<td>
	  <xsl:choose>
	   <xsl:when test="chrg_type[.='C']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_TYPE_CREDIT')"/></xsl:when>
	   <xsl:when test="chrg_type[.='D']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_TYPE_DEBIT')"/></xsl:when>
	  </xsl:choose>
	 </td>
 </xsl:if>
</xsl:template>

 <!--
  Attach documents. 
  -->
 <xsl:template name="attachments-documents">
  <xsl:param name="max-attachments">-1</xsl:param>
  <xsl:param name="product_code"><xsl:value-of select="product_code"/></xsl:param>
  <xsl:param name="existing-attachments" select="documents/document"/>

  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_DOCUMENTS</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="attachments-table">
     <xsl:with-param name="isRemittanceLetter">
     	<xsl:choose>
     		<xsl:when test="$product_code = 'EL'">Y</xsl:when>
     		<xsl:otherwise>N</xsl:otherwise>
     	</xsl:choose>
     </xsl:with-param>
     <xsl:with-param name="max-attachments" select="$max-attachments"/>
     <xsl:with-param name="existing-attachments" select="$existing-attachments"/>
     <xsl:with-param name="table-caption">XSL_DOCUMENTSDETAILS_TABLE_CAPTION</xsl:with-param>
     <xsl:with-param name="table-summary">XSL_DOCUMENTSDETAILS_TABLE_SUMMARY</xsl:with-param>
     <xsl:with-param name="table-thead">
      <th class="doc-name-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENTS_COLUMN_DOCUMENT')"/></th>
      <xsl:if test="$product_code != 'EL'">
	      <th class="doc-dupe-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_NO')"/></th>
	      <th class="doc-dupe-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_DATE')"/></th>
      </xsl:if>
      <th class="doc-orig-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_1ST_MAIL')"/></th>
      <th class="doc-dupe-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_2ND_MAIL')"/></th>
      <xsl:if test="$product_code != 'EL'">
      	<th class="doc-dupe-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_TOTAL')"/></th>
      	<th class="doc-dupe-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_COLUMN_MAP_TO_ATTACHMENT')"/></th>
      </xsl:if>
     </xsl:with-param>
     <xsl:with-param name="table-row-type">document</xsl:with-param>
     <xsl:with-param name="empty-table-notice">XSL_DOCUMENTS_NONE</xsl:with-param>
     <xsl:with-param name="delete-attachments-notice">XSL_TITLE_DOCUMENT_NOTICE</xsl:with-param>
    </xsl:call-template>
    
    <!--
     Hidden Fields 
     -->
    <xsl:for-each select="$existing-attachments">
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">documents_details_code_<xsl:value-of select="document_id"/></xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="code"/></xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">documents_details_document_id_<xsl:value-of select="document_id"/></xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="document_id"/></xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">documents_details_second_mail_<xsl:value-of select="document_id"/></xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="second_mail"/></xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">documents_details_name_<xsl:value-of select="document_id"/></xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="name"/></xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">documents_details_first_mail_<xsl:value-of select="document_id"/></xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="first_mail"/></xsl:with-param>
     </xsl:call-template>
     <xsl:if test="$product_code != 'EL'">
	     <xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">documents_details_total_<xsl:value-of select="document_id"/></xsl:with-param>
	      <xsl:with-param name="value"><xsl:value-of select="total"/></xsl:with-param>
	     </xsl:call-template>
	     <xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">documents_details_mapped_attachment_name_<xsl:value-of select="document_id"/></xsl:with-param>
	      <xsl:with-param name="value"><xsl:value-of select="mapped_attachment_name"/></xsl:with-param>
	     </xsl:call-template>
	     <xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">documents_details_mapped_attachment_id_<xsl:value-of select="document_id"/></xsl:with-param>
	      <xsl:with-param name="value"><xsl:value-of select="mapped_attachment_id"/></xsl:with-param>
	     </xsl:call-template>
	     <xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">documents_details_doc_no_<xsl:value-of select="document_id"/></xsl:with-param>
	      <xsl:with-param name="value"><xsl:value-of select="doc_no"/></xsl:with-param>
	     </xsl:call-template>
	     <xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">documents_details_doc_date_<xsl:value-of select="document_id"/></xsl:with-param>
	      <xsl:with-param name="value"><xsl:value-of select="doc_date"/></xsl:with-param>
	     </xsl:call-template>
     </xsl:if>
    </xsl:for-each>
    
    <!--
     Edit Fields 
     -->
    <xsl:if test="$displaymode='edit'">
     <script>
     	dojo.ready(function(){
			misys._config = misys._config || {};
			dojo.mixin(misys._config,  {
				documentAttached : '<xsl:value-of select="count($existing-attachments)"/>'
			});
		});
	  </script>
     
     <button dojoType="dijit.form.Button" id="openDocumentDialog" type="button">
      <xsl:attribute name="onclick">misys.populateAttachmentInfo(); misys.showTransactionAddonsDialog('document');</xsl:attribute>
      <xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENTSDETAILS_ADD_DOCUMENT_ITEM')"/>
     </button>
     
     <!-- Holder div for hidden fields, created when an item is added -->
     <div id="document_fields"></div>
     
		<xsl:variable name="firstMailRequired">
			<xsl:choose>
				<xsl:when test="defaultresource:getResource('COLLECTION_DOCUMENTDETAILS_FIRST_MAIL_REQUIRED')='true'">Y</xsl:when>
				<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="secondMailRequired">
			<xsl:choose>
				<xsl:when test="defaultresource:getResource('DOCUMENTDETAILS_SECOND_MAIL_REQUIRED')='true'">Y</xsl:when>
				<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		
		<xsl:variable name="firstMailValue">
			<xsl:choose>
				<xsl:when test="defaultresource:getResource('COLLECTION_DOCUMENTDETAILS_FIRST_MAIL_REQUIRED')='true'">Y</xsl:when>
				<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:variable name="SecondMailValue">
			<xsl:choose>
				<xsl:when test="defaultresource:getResource('COLLECTION_DOCUMENTDETAILS_FIRST_MAIL_REQUIRED')='true'">Y</xsl:when>
				<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<xsl:variable name="totalDocumentRequired">
			<xsl:choose>
				<xsl:when test="($firstMailRequired = 'Y' or $secondMailRequired ='Y')">Y</xsl:when>
				<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>	
	<xsl:variable name="maxSizeforDocument"><xsl:value-of select="defaultresource:getResource('COLLECTION_DOCUMENT_ALLOWED_SIZE')"/></xsl:variable>
	<xsl:variable name="isDocumentMandatory"><xsl:value-of select="defaultresource:getResource('COLLECTION_DOCUMENT_MANDATORY')"/></xsl:variable>
        
     <xsl:call-template name="no-close-dialog">
  	  <xsl:with-param name="id">documentDialog</xsl:with-param>
  	  <xsl:with-param name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_DOCUMENT_DETAILS')"/></xsl:with-param>
  	  <xsl:with-param name="content">
  	   <div class="required">
        <xsl:call-template name="select-field">
         <xsl:with-param name="label">XSL_DOCUMENTSDETAILS_DOCUMENT</xsl:with-param>
         <xsl:with-param name="id">documents_details_code_nosend</xsl:with-param>
         <xsl:with-param name="options">
          <xsl:call-template name="document-codes"/>
         </xsl:with-param>
         <xsl:with-param name="required">Y</xsl:with-param>
        </xsl:call-template>
       </div>
       <xsl:call-template name="input-field">
        <xsl:with-param name="id">documents_details_name_nosend</xsl:with-param>
        <xsl:with-param name="maxsize">35</xsl:with-param>
        <xsl:with-param name="value" select="name"/>
        <xsl:with-param name="disabled">Y</xsl:with-param>
        <xsl:with-param name="swift-validate">N</xsl:with-param>
       </xsl:call-template>
       <xsl:if test="$product_code != 'EL'">
	       <xsl:call-template name="input-field">
	        <xsl:with-param name="label">XSL_DOCUMENTDETAILS_NO</xsl:with-param>
	        <xsl:with-param name="id">documents_details_doc_no_send</xsl:with-param>
	        <xsl:with-param name="size">20</xsl:with-param>
	        <xsl:with-param name="maxsize">20</xsl:with-param>
	        <xsl:with-param name="swift-validate">N</xsl:with-param>
	       </xsl:call-template>
	       <xsl:call-template name="input-field">
	        <xsl:with-param name="label">XSL_DOCUMENTDETAILS_DATE</xsl:with-param>
	        <xsl:with-param name="id">documents_details_doc_date_send</xsl:with-param>
	        <xsl:with-param name="size">10</xsl:with-param>
	        <xsl:with-param name="maxsize">10</xsl:with-param>
	        <xsl:with-param name="type">date</xsl:with-param>
	        <xsl:with-param name="fieldsize">small</xsl:with-param>
	        <xsl:with-param name="swift-validate">N</xsl:with-param>
	       </xsl:call-template>
       </xsl:if>
       
        <xsl:choose>
			<xsl:when test="$firstMailRequired ='N' and ($product_code ='EC' or $product_code ='IC')">
		       <xsl:call-template name="input-field">
		        <xsl:with-param name="label">XSL_DOCUMENTSDETAILS_1ST_MAIL</xsl:with-param>
		        <xsl:with-param name="id">documents_details_first_mail_send</xsl:with-param>
		        <xsl:with-param name="size">20</xsl:with-param>
		        <xsl:with-param name="maxsize"><xsl:value-of select="$maxSizeforDocument"/></xsl:with-param>
		        <xsl:with-param name="swift-validate">N</xsl:with-param>
		        <xsl:with-param name="required"><xsl:value-of select="$firstMailRequired" /></xsl:with-param>
		         <xsl:with-param name="value">0</xsl:with-param>
		       </xsl:call-template>
		    </xsl:when>
		    <xsl:when test="$product_code = 'EL'">
		       <xsl:call-template name="input-field">
			   <xsl:with-param name="label">XSL_DOCUMENTSDETAILS_1ST_MAIL</xsl:with-param>
			   <xsl:with-param name="id">documents_details_first_mail_send</xsl:with-param>
			   <xsl:with-param name="size">20</xsl:with-param>
			   <xsl:with-param name="maxsize">20</xsl:with-param>
			   <xsl:with-param name="swift-validate">N</xsl:with-param>
			   <xsl:with-param name="required">Y</xsl:with-param>
			   </xsl:call-template>
		       </xsl:when>
		     <xsl:otherwise>
		      <xsl:call-template name="input-field">
		        <xsl:with-param name="label">XSL_DOCUMENTSDETAILS_1ST_MAIL</xsl:with-param>
		        <xsl:with-param name="id">documents_details_first_mail_send</xsl:with-param>
		        <xsl:with-param name="size">20</xsl:with-param>
		        <xsl:with-param name="maxsize"><xsl:value-of select="$maxSizeforDocument"/></xsl:with-param>
		        <xsl:with-param name="swift-validate">N</xsl:with-param>
		        <xsl:with-param name="required"><xsl:value-of select="$firstMailRequired" /></xsl:with-param>
		       </xsl:call-template>
		     </xsl:otherwise>
		     </xsl:choose>   
		       
       <xsl:choose>
			<xsl:when test="$secondMailRequired ='N' and ($product_code ='EC' or $product_code ='IC')">
		       	<xsl:call-template name="input-field">
		        <xsl:with-param name="label">XSL_DOCUMENTSDETAILS_2ND_MAIL</xsl:with-param>
		        <xsl:with-param name="id">documents_details_second_mail_send</xsl:with-param>
		        <xsl:with-param name="size">20</xsl:with-param>
		        <xsl:with-param name="maxsize"><xsl:value-of select="$maxSizeforDocument"/></xsl:with-param>
		        <xsl:with-param name="swift-validate">N</xsl:with-param>
		        <xsl:with-param name="required"><xsl:value-of select="$secondMailRequired"/></xsl:with-param>
		        <xsl:with-param name="value">0</xsl:with-param>
		       </xsl:call-template>
       </xsl:when>
       <xsl:when test="$product_code = 'EL'">
       <xsl:call-template name="input-field">
		        <xsl:with-param name="label">XSL_DOCUMENTSDETAILS_2ND_MAIL</xsl:with-param>
		        <xsl:with-param name="id">documents_details_second_mail_send</xsl:with-param>
		        <xsl:with-param name="size">20</xsl:with-param>
		        <xsl:with-param name="maxsize">20</xsl:with-param>
		        <xsl:with-param name="swift-validate">N</xsl:with-param>
		        <xsl:with-param name="required">Y</xsl:with-param>
		       </xsl:call-template>
       </xsl:when>
       <xsl:otherwise>
       	 	<xsl:call-template name="input-field">
		        <xsl:with-param name="label">XSL_DOCUMENTSDETAILS_2ND_MAIL</xsl:with-param>
		        <xsl:with-param name="id">documents_details_second_mail_send</xsl:with-param>
		        <xsl:with-param name="size">20</xsl:with-param>
		        <xsl:with-param name="maxsize"><xsl:value-of select="$maxSizeforDocument"/></xsl:with-param>
		        <xsl:with-param name="swift-validate">N</xsl:with-param>
		        <xsl:with-param name="required"><xsl:value-of select="$secondMailRequired"/></xsl:with-param>
		       </xsl:call-template>
	</xsl:otherwise>
       </xsl:choose>
       
       <xsl:if test="$product_code != 'EL'">
	       <xsl:call-template name="input-field">
	        <xsl:with-param name="label">XSL_DOCUMENTSDETAILS_TOTAL</xsl:with-param>
	        <xsl:with-param name="id">documents_details_total_send</xsl:with-param>
	        <xsl:with-param name="size">20</xsl:with-param>
	        <xsl:with-param name="maxsize">20</xsl:with-param>
	        <xsl:with-param name="swift-validate">N</xsl:with-param>
	        <xsl:with-param name="required"><xsl:value-of select="$totalDocumentRequired"/></xsl:with-param>
	       </xsl:call-template>
	       <!-- Map to Attachment -->
			<xsl:choose>
				<xsl:when test="$displaymode != 'view' and $product_code and ($product_code ='EC' or $product_code ='IC')">
					<xsl:call-template name="select-field">
						<xsl:with-param name="name">documents_details_mapped_attachment_name_send</xsl:with-param>
						<xsl:with-param name="label">XSL_DOCUMENT_COLUMN_MAP_TO_ATTACHMENT_LABEL</xsl:with-param>
						<xsl:with-param name="required">N</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">documents_details_mapped_attachment_id_send</xsl:with-param>
						<xsl:with-param name="value" select="documents_details_mapped_attachment_id_send" />
						<xsl:with-param name="required">N</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_DOCUMENT_COLUMN_MAP_TO_ATTACHMENT_LABEL</xsl:with-param>
						<xsl:with-param name="value">
							<xsl:value-of select="documents_details_mapped_attachment_name_send" />
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">
							<xsl:value-of select="documents_details_mapped_attachment_id_send" />
						</xsl:with-param>
					</xsl:call-template>					
				</xsl:otherwise>
			</xsl:choose>			
       </xsl:if>
  	  </xsl:with-param>
  	  <xsl:with-param name="buttons">
  	   <xsl:call-template name="row-wrapper">
        <xsl:with-param name="id">addDocumentButton</xsl:with-param>
        <xsl:with-param name="content">
         <button dojoType="dijit.form.Button" id="addDocumentButton" type="button">
          <xsl:attribute name="onclick">misys.addTransactionAddon('document');</xsl:attribute>
          <xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SAVE')"/>
         </button>
         <button dojoType="dijit.form.Button" id="cancelDocumentButton" type="button">
          <xsl:attribute name="onclick">misys.hideTransactionAddonsDialog('document');</xsl:attribute>
          <xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/>
         </button>
        </xsl:with-param>
       </xsl:call-template>
  	  </xsl:with-param>
	 </xsl:call-template>
    </xsl:if>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- 
  -->
 <xsl:template name="document-table-row">
 <xsl:param name="isRemittanceLetter">N</xsl:param>
	<td>
	 <xsl:choose>
	  <xsl:when test="code and code[.!= ''] and code[.!= '99']">
    	<xsl:value-of select="localization:getDecode($language, 'C064', code)"/>
	  </xsl:when>
	  <xsl:otherwise>
	   <xsl:value-of select="name"/>
	  </xsl:otherwise>
	 </xsl:choose>
	</td>
	<xsl:if test="$isRemittanceLetter = 'N'">
		<td><xsl:value-of select="doc_no" /></td>
		<td><xsl:value-of select="doc_date" /></td>
	 </xsl:if>
		<td><xsl:value-of select="first_mail"/></td>
		<td><xsl:value-of select="second_mail"/></td>
	<xsl:if test="$isRemittanceLetter = 'N'">
		<td><xsl:value-of select="total"/></td>
		<td><xsl:value-of select="mapped_attachment_name"/></td>  
	</xsl:if>
 </xsl:template>
 
 
  <xsl:template name="topic-table-row">
    <xsl:param name="suffix"/>
      
	  <td>
	   <xsl:call-template name="hidden-field">
	     <xsl:with-param name="id">topic_id_<xsl:value-of select="$suffix" /></xsl:with-param>
		 <xsl:with-param name="name">topic_id_<xsl:value-of select="$suffix" /></xsl:with-param>
		 <xsl:with-param name="value" select="topic_id" />
	   </xsl:call-template>
	   <img  width="80" height="50">
		  <xsl:attribute name="id">image_<xsl:value-of select="$suffix" /></xsl:attribute>
		  <xsl:attribute name="src"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/AjaxScreen/action/GetCustomerLogo?logoid=<xsl:value-of select="img_file_id"/></xsl:attribute>
	   </img>
	   <xsl:call-template name="hidden-field">
		  <xsl:with-param name="id">img_file_id_<xsl:value-of select="$suffix" /></xsl:with-param>
		  <xsl:with-param name="name">img_file_id_<xsl:value-of select="$suffix" /></xsl:with-param>
		  <xsl:with-param name="value" select="img_file_id" />
	   </xsl:call-template>
	  </td>
	  <td>
	   <xsl:value-of select="title"/>
	   <xsl:call-template name="hidden-field">
		  <xsl:with-param name="id">title_<xsl:value-of select="$suffix" /></xsl:with-param>
		  <xsl:with-param name="name">title_<xsl:value-of select="$suffix" /></xsl:with-param>
		  <xsl:with-param name="value" select="title" />
	   </xsl:call-template>
	  </td>
	  <td>
	   <a onclick="if (!this.isContentEditable) return !window.open(this.href,'blank');">
	   		<xsl:attribute name="href" ><xsl:value-of select="link"/></xsl:attribute>
	   		<xsl:value-of select="link"/>
	   </a>
	   <xsl:call-template name="hidden-field">
		  <xsl:with-param name="id">link_<xsl:value-of select="$suffix" /></xsl:with-param>
		  <xsl:with-param name="name">link_<xsl:value-of select="$suffix" /></xsl:with-param>
		  <xsl:with-param name="value" select="link" />
	   </xsl:call-template>
	  </td>
 </xsl:template>
 
 <!-- Document codes -->
  <xsl:template name="document-codes">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <option value=""/>
     <xsl:call-template name="code-data-options">
	 	<xsl:with-param name="paramId">C064</xsl:with-param>
	 	<xsl:with-param name="productCode"><xsl:value-of select="/*/product_code"/></xsl:with-param>
	 	<xsl:with-param name="specificOrder">Y</xsl:with-param>
	 </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
    	<xsl:value-of select="localization:getDecode($language,  'C064', code)"/>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>

  <!-- 
   Complete a row in the table for an existing alert
   -->
  <xsl:template name="alert-table-row">
 	 <xsl:param name="suffix">0</xsl:param>
 	 <xsl:param name="row-type">alert01</xsl:param>
 	 <xsl:param name="option"/>
 	 <xsl:param name="hasEntities"/>
 	 <xsl:param name="prefix">
 	 	<xsl:choose>
 	 	  <xsl:when test="$row-type = 'alert01'">01</xsl:when>
         <xsl:otherwise>02</xsl:otherwise>
        </xsl:choose>
 	 </xsl:param>
 	 
 	 <xsl:if test="$hasEntities='Y'">
 	 	<td>
	    	 <xsl:value-of select="entity" /> 
	    	 <xsl:call-template name="hidden-field">
		       <xsl:with-param name="id">alerts_<xsl:value-of select="$prefix" />_details_entity_<xsl:value-of select="$suffix" /></xsl:with-param>
		       <xsl:with-param name="name">alerts_<xsl:value-of select="$prefix" />_details_entity_<xsl:value-of select="$suffix" /></xsl:with-param>
		       <xsl:with-param name="value" select="entity" />
	    	 </xsl:call-template>
	    </td>
 	 
 	 </xsl:if>
 	 
    <td>
    	 <xsl:value-of select="localization:getDecode($language, 'N001', prod_code)" />
    	 <xsl:call-template name="hidden-field">
	       <xsl:with-param name="id">alerts_<xsl:value-of select="$prefix" />_details_select_prodcode_<xsl:value-of select="$suffix" /></xsl:with-param>
	       <xsl:with-param name="name">alerts_<xsl:value-of select="$prefix" />_details_select_prodcode_<xsl:value-of select="$suffix" /></xsl:with-param>
	       <xsl:with-param name="value" select="prod_code" />
    	 </xsl:call-template> 
    	 <xsl:call-template name="hidden-field">
	       <xsl:with-param name="id">alerts_<xsl:value-of select="$prefix" />_details_prodcode_<xsl:value-of select="$suffix" /></xsl:with-param>
	       <xsl:with-param name="name">alerts_<xsl:value-of select="$prefix" />_details_prodcode_<xsl:value-of select="$suffix" /></xsl:with-param>
	       <xsl:with-param name="value" select="prod_code" />
    	 </xsl:call-template> 
    	 <xsl:call-template name="hidden-field">
	       <xsl:with-param name="id">alerts_<xsl:value-of select="$prefix" />_details_proddecode_<xsl:value-of select="$suffix" /></xsl:with-param>
	       <xsl:with-param name="name">alerts_<xsl:value-of select="$prefix" />_details_proddecode_<xsl:value-of select="$suffix" /></xsl:with-param>
	       <xsl:with-param name="value" select="prod_code" />
    	 </xsl:call-template> 
    </td>
	<td>
		<xsl:choose>
 	 	  <xsl:when test="$option='ALERT_SUBMISSION_MAINTENANCE'">
 	 	   <xsl:value-of select="localization:getDecode($language, 'N002', tnx_type_code)" />
			 <xsl:call-template name="hidden-field">
		       <xsl:with-param name="id">alerts_<xsl:value-of select="$prefix" />_details_select_tnxtypecode_<xsl:value-of select="$suffix" /></xsl:with-param>
		       <xsl:with-param name="name">alerts_<xsl:value-of select="$prefix" />_details_select_tnxtypecode_<xsl:value-of select="$suffix" /></xsl:with-param>
		       <xsl:with-param name="value" select="tnx_type_code" />
	    	 </xsl:call-template>
	    	 <xsl:call-template name="hidden-field">
		       <xsl:with-param name="id">alerts_<xsl:value-of select="$prefix" />_details_tnxtypecode_<xsl:value-of select="$suffix" /></xsl:with-param>
		       <xsl:with-param name="name">alerts_<xsl:value-of select="$prefix" />_details_tnxtypecode_<xsl:value-of select="$suffix" /></xsl:with-param>
		       <xsl:with-param name="value" select="tnx_type_code" />
	    	 </xsl:call-template>
	    	 <xsl:call-template name="hidden-field">
		       <xsl:with-param name="id">alerts_<xsl:value-of select="$prefix" />_details_tnxtypedecode_<xsl:value-of select="$suffix" /></xsl:with-param>
		       <xsl:with-param name="name">alerts_<xsl:value-of select="$prefix" />_details_tnxtypedecode_<xsl:value-of select="$suffix" /></xsl:with-param>
		       <xsl:with-param name="value" select="tnx_type_code" />
	    	 </xsl:call-template>
		  </xsl:when>
         <xsl:otherwise>
	         <xsl:variable name="codeval"><xsl:value-of select="date_code"/></xsl:variable>
   		 	 <xsl:variable name="offsetsigncode"><xsl:value-of select="offsetsign"/></xsl:variable>
   		 	 <xsl:variable name="offsetcode"><xsl:value-of select="offset"/></xsl:variable>
	         <xsl:choose>
           		<xsl:when test="$codeval='*'">*</xsl:when>
           		<xsl:otherwise><xsl:value-of select="localization:getGTPString($language, $codeval)"/>
             		<xsl:choose>
               		<xsl:when test="$offsetsigncode='1'">&nbsp;(+</xsl:when>
               		<xsl:otherwise>&nbsp;(-</xsl:otherwise>
             		</xsl:choose>
             		<xsl:value-of select="$offsetcode"/>)
           		</xsl:otherwise>
   			 </xsl:choose>
   			 
			 <xsl:call-template name="hidden-field">
		       <xsl:with-param name="id">alerts_<xsl:value-of select="$prefix" />_details_select_datecode_<xsl:value-of select="$suffix" /></xsl:with-param>
		       <xsl:with-param name="name">alerts_<xsl:value-of select="$prefix" />_details_select_datecode_<xsl:value-of select="$suffix" /></xsl:with-param>
		       <xsl:with-param name="value" select="date_code" />
	    	 </xsl:call-template>
	    	 <xsl:call-template name="hidden-field">
		       <xsl:with-param name="id">alerts_<xsl:value-of select="$prefix" />_details_datecode_<xsl:value-of select="$suffix" /></xsl:with-param>
		       <xsl:with-param name="name">alerts_<xsl:value-of select="$prefix" />_details_datecode_<xsl:value-of select="$suffix" /></xsl:with-param>
		       <xsl:with-param name="value" select="date_code" />
	    	 </xsl:call-template>
	    	 <xsl:call-template name="hidden-field">
		       <xsl:with-param name="id">alerts_<xsl:value-of select="$prefix" />_details_datedecode_<xsl:value-of select="$suffix" /></xsl:with-param>
		       <xsl:with-param name="name">alerts_<xsl:value-of select="$prefix" />_details_datedecode_<xsl:value-of select="$suffix" /></xsl:with-param>
		       <xsl:with-param name="value" select="date_code" />
	    	 </xsl:call-template>
	    	 <xsl:call-template name="hidden-field">
		       <xsl:with-param name="id">alerts_<xsl:value-of select="$prefix" />_details_offsetcode_<xsl:value-of select="$suffix" /></xsl:with-param>
		       <xsl:with-param name="name">alerts_<xsl:value-of select="$prefix" />_details_offsetcode_<xsl:value-of select="$suffix" /></xsl:with-param>
		       <xsl:with-param name="value" select="offset" />
	    	 </xsl:call-template>
	    	 <xsl:call-template name="hidden-field">
		       <xsl:with-param name="id">alerts_<xsl:value-of select="$prefix" />_details_offsetsigncode_<xsl:value-of select="$suffix" /></xsl:with-param>
		       <xsl:with-param name="name">alerts_<xsl:value-of select="$prefix" />_details_offsetsigncode_<xsl:value-of select="$suffix" /></xsl:with-param>
		       <xsl:with-param name="value" select="offsetsign" />
	    	 </xsl:call-template>

	    	 <xsl:variable name="jobName">milestonesjob<xsl:value-of select="$prefix" /></xsl:variable>
             <xsl:call-template name="hidden-field">
		       <xsl:with-param name="id">alerts_<xsl:value-of select="$prefix" />_details_output_<xsl:value-of select="$suffix" /></xsl:with-param>
		       <xsl:with-param name="name">alerts_<xsl:value-of select="$prefix" />_details_output_<xsl:value-of select="$suffix" /></xsl:with-param>
		       <xsl:with-param name="value" select="$jobName" />
	    	 </xsl:call-template>
	    	 <xsl:call-template name="hidden-field">
		       <xsl:with-param name="id">alerts_<xsl:value-of select="$prefix" />_details_complete_milestone_<xsl:value-of select="$suffix" /></xsl:with-param>
		       <xsl:with-param name="name">alerts_<xsl:value-of select="$prefix" />_details_complete_milestone_<xsl:value-of select="$suffix" /></xsl:with-param>
		       <xsl:with-param name="value"/>
	    	 </xsl:call-template>

         </xsl:otherwise>
        </xsl:choose>
		 
	</td>
	<td>
	
	    
	    <xsl:variable name="codeAddr">
	      <xsl:value-of select="address"/>
	    </xsl:variable>
	    
	    <xsl:variable name="translateAdr">
	      <xsl:choose>
		    <xsl:when test="$codeAddr='INPUT_USER'">
		    	<xsl:value-of select="localization:getGTPString($language, 'INP_USER')"/>
			</xsl:when>
			<xsl:when test="$codeAddr='BO_INPUT_USER'">
		    	<xsl:value-of select="localization:getGTPString($language, 'INP_USER')"/>
			</xsl:when>
			<xsl:when test="$codeAddr='CONTROL_USER'">
		    	<xsl:value-of select="localization:getGTPString($language, 'CTL_USER')"/>
			</xsl:when>
			<xsl:when test="$codeAddr='BO_CONTROL_USER'">
		    	<xsl:value-of select="localization:getGTPString($language, 'CTL_USER')"/>
			</xsl:when>
			<xsl:when test="$codeAddr='RELEASE_USER'">
		    	<xsl:value-of select="localization:getGTPString($language, 'RLS_USER')"/>
			</xsl:when>
			<xsl:when test="$codeAddr='BO_RELEASE_USER'">
		    	<xsl:value-of select="localization:getGTPString($language, 'RLS_USER')"/>
			</xsl:when>
		    <xsl:otherwise/>
		  </xsl:choose>
	    </xsl:variable>
	    
	    <xsl:choose>
          	<xsl:when test="alertlanguage='*'">
          		<xsl:value-of select="$translateAdr"></xsl:value-of>
			</xsl:when>
          	<xsl:otherwise>
          		<xsl:value-of select="address"/>
          	</xsl:otherwise>
   		</xsl:choose>
	    
	    
		<xsl:call-template name="hidden-field">
	       <xsl:with-param name="id">alerts_<xsl:value-of select="$prefix" />_details_address_value_<xsl:value-of select="$suffix" /></xsl:with-param>
	       <xsl:with-param name="name">alerts_<xsl:value-of select="$prefix" />_details_address_value_<xsl:value-of select="$suffix" /></xsl:with-param>
	       <xsl:with-param name="value" select="$translateAdr"/>
    	</xsl:call-template>
    	<xsl:call-template name="hidden-field">
	       <xsl:with-param name="id">alerts_<xsl:value-of select="$prefix" />_details_address_<xsl:value-of select="$suffix" /></xsl:with-param>
	       <xsl:with-param name="name">alerts_<xsl:value-of select="$prefix" />_details_address_<xsl:value-of select="$suffix" /></xsl:with-param>
	       <xsl:with-param name="value" select="address" />
    	</xsl:call-template>
	</td>
	<xsl:call-template name="hidden-field">
       <xsl:with-param name="id">alerts_<xsl:value-of select="$prefix" />_details_select_usercode_<xsl:value-of select="$suffix" /></xsl:with-param>
       <xsl:with-param name="name">alerts_<xsl:value-of select="$prefix" />_details_select_usercode_<xsl:value-of select="$suffix" /></xsl:with-param>
       <xsl:with-param name="value" select="./address" />
   	 </xsl:call-template>
   	 <xsl:call-template name="hidden-field">
       <xsl:with-param name="id">alerts_<xsl:value-of select="$prefix" />_details_usercode_<xsl:value-of select="$suffix" /></xsl:with-param>
       <xsl:with-param name="name">alerts_<xsl:value-of select="$prefix" />_details_usercode_<xsl:value-of select="$suffix" /></xsl:with-param>
       <xsl:with-param name="value" select="address"/>
   	 </xsl:call-template> 
   	 <xsl:call-template name="hidden-field">
       <xsl:with-param name="id">alerts_<xsl:value-of select="$prefix" />_details_userdecode_<xsl:value-of select="$suffix" /></xsl:with-param>
       <xsl:with-param name="name">alerts_<xsl:value-of select="$prefix" />_details_userdecode_<xsl:value-of select="$suffix" /></xsl:with-param>
       <xsl:with-param name="value" select="issuer_abbv_name" />
   	 </xsl:call-template> 
   	  <xsl:call-template name="hidden-field">
       <xsl:with-param name="id">alerts_<xsl:value-of select="$prefix" />_details_langcode_<xsl:value-of select="$suffix" /></xsl:with-param>
       <xsl:with-param name="name">alerts_<xsl:value-of select="$prefix" />_details_langcode_<xsl:value-of select="$suffix" /></xsl:with-param>
       <xsl:with-param name="value" select="alertlanguage" />
   	 </xsl:call-template> 
	<xsl:call-template name="hidden-field">
     	<xsl:with-param name="id">alerts_<xsl:value-of select="$prefix" />_details_position_<xsl:value-of select="$suffix" /></xsl:with-param>
      	<xsl:with-param name="name">alerts_<xsl:value-of select="$prefix" />_details_position_<xsl:value-of select="$suffix" /></xsl:with-param>
      	<xsl:with-param name="value" select="$suffix" />
  	</xsl:call-template> 
  </xsl:template>
  
  <xsl:template name="column-check-box">
		<xsl:param name="disabled"/>
	    <xsl:param name="readonly"/>
	    <xsl:param name="checked"/>
	    <xsl:param name="id"/>
		<div dojoType="dijit.form.CheckBox">
			<xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
			<xsl:if test="$disabled='Y'">
	         <xsl:attribute name="disabled">true</xsl:attribute>
	        </xsl:if>
	        <xsl:if test="$readonly='Y' or $displaymode='view'">
	         <xsl:attribute name="readOnly">true</xsl:attribute>
	        </xsl:if>
	        <xsl:if test="$checked='Y'">
	         <xsl:attribute name="checked"/>
	        </xsl:if>	 	 
  		</div>
  </xsl:template>

  
</xsl:stylesheet>