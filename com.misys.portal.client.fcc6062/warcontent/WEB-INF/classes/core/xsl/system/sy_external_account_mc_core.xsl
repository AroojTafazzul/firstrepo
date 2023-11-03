<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for : 

 Entity Screen, System Form.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      12/03/08
author:    Laure Blin
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
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		exclude-result-prefixes="localization security">
 
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="nextscreen"/>
  <xsl:param name="option"/>
  <xsl:param name="operation"/>
  <xsl:param name="company"/>
  <xsl:param name="entity"></xsl:param>
  <xsl:param name="action"/>
  <xsl:param name="displaymode">edit</xsl:param>
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="productcode"/>
  <xsl:param name="operation">SAVE_FEATURES</xsl:param>
  <xsl:param name="processdttm"/>
  <xsl:param name="ibanAccountValidationRegex"/>
  <xsl:param name="ibanAccountValidationEnabled"/>
  <xsl:param name="intialActvflag"/>  
  <xsl:param name="isMultiBank">N</xsl:param>
  
  <!-- Global Imports. -->
  <xsl:include href="../../../core/xsl/common/system_common.xsl" />
  <xsl:include href="../../../core/xsl/system/sy_jurisdiction.xsl" />
  <xsl:include href="../../../core/xsl/common/maker_checker_common.xsl" />
  <xsl:include href="../../../core/xsl/common/e2ee_common.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="external_account">
   <xsl:call-template name="external_account"/>
  </xsl:template>
  
  <xsl:template name="external_account">
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
      <xsl:call-template name="company-details"/>
      <xsl:call-template name="customer-reference"/>
      <xsl:call-template name="external-account-details"/>
    	 <xsl:if test="$canCheckerReturnComments = 'true'">
      		<xsl:call-template name="comments-for-return-mc">
      		<xsl:with-param name="value"> <xsl:value-of select="return_comments"/></xsl:with-param>
      	</xsl:call-template>
      </xsl:if>
      <xsl:call-template name="maker-checker-menu"/>
     </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="realform"/>
   </div>
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
	 		<xsl:when test="security:isBank($rundata)"><xsl:value-of select="'EA_02'"></xsl:value-of></xsl:when>
	 		<xsl:otherwise><xsl:value-of select="'EA_01'"></xsl:value-of></xsl:otherwise>
	   </xsl:choose>
   </xsl:variable>
  <xsl:call-template name="system-common-js-imports">
   <xsl:with-param name="xml-tag-name">external-account</xsl:with-param>
   <xsl:with-param name="binding">misys.binding.system.external_account_mc</xsl:with-param>
   <xsl:with-param name="override-help-access-key"><xsl:value-of select="$help_access_key"/></xsl:with-param>   
    <!-- <xsl:with-param name="override-home-url">CONTEXT_PATH + SERVLET_PATH + '/screen/<xsl:value-of select="$nextscreen"/>?option=<xsl:value-of select="$option"/>&amp;company=<xsl:value-of select="$company"/>'</xsl:with-param> -->
   <xsl:with-param name="override-home-url">'/screen/<xsl:value-of select="$nextscreen"/>?option=<xsl:value-of select="$option"/>&amp;company=<xsl:value-of select="$company"/>&amp;entity=<xsl:value-of select="$entity"/>'</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are  -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <div class="widgetContainer">
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">brch_code</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">company_id</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="company_id"/></xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
   <xsl:with-param name="name">owner_type</xsl:with-param>
   <xsl:with-param name="value">05</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
   <xsl:with-param name="name">account_type</xsl:with-param>
   <xsl:with-param name="value">01</xsl:with-param>
   </xsl:call-template>
   <xsl:if test="$operation='MODIFY_FEATURES'">
   <xsl:call-template name="hidden-field">
	<xsl:with-param name="name">abbv_name</xsl:with-param>
	<xsl:with-param name="id">abbv_name_hidden</xsl:with-param>
	<xsl:with-param name="value"><xsl:value-of select="abbv_name"/></xsl:with-param>
   </xsl:call-template>
   </xsl:if>
   <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">swiftBicCodeRegexValue</xsl:with-param>
	 <xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('BIC_CHARSET')"/></xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="localization-dialog"/>
   </div>
 </xsl:template>
 
 <xsl:template name="company-details">
 <xsl:call-template name="fieldset-wrapper">
   		<xsl:with-param name="legend">XSL_HEADER_COMPANY_DETAILS</xsl:with-param>
   		<xsl:with-param name="button-type">
   			<xsl:if test="$hideMasterViewLink!='true'">mc-master-details</xsl:if>
   		</xsl:with-param>
   		<xsl:with-param name="override-displaymode">edit</xsl:with-param>
   		<xsl:with-param name="content">
   		<xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_JURISDICTION_COMPANY</xsl:with-param>
      			<xsl:with-param name="name">company_abbv_name</xsl:with-param>
      			<xsl:with-param name="value"><xsl:value-of select="company"/></xsl:with-param>
      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
     	</xsl:call-template>
       <xsl:if test="$isMultiBank='Y'">
	    <xsl:call-template name="select-field">
          <xsl:with-param name="label">BANK_NAME</xsl:with-param>
          <xsl:with-param name="name">bank_abbv_name</xsl:with-param>
          <xsl:with-param name="required">Y</xsl:with-param>
          <xsl:with-param name ="options">
             <xsl:call-template name="bank-options"/>
          </xsl:with-param>
          <xsl:with-param name="value"><xsl:value-of select="bank_abbv_name"/></xsl:with-param>
       </xsl:call-template>			
      </xsl:if>
		<!-- Entities -->
		<xsl:choose>
			<xsl:when test="entities">
				<xsl:call-template name="animatedFieldSetHeader">
			   		<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'ENTITIES')"/></xsl:with-param>
					<xsl:with-param name="animateDivId">entity_list</xsl:with-param>
			   		<xsl:with-param name="prefix">entity_list</xsl:with-param>
			   		<xsl:with-param name="onClickFlag">Y</xsl:with-param>
				</xsl:call-template>
				<xsl:variable name="entityCount"><xsl:value-of select="count(entities/entity)"/></xsl:variable>
				<script>
				dojo.ready(function(){
						misys._config = (misys._config) || {};
		
						misys._config.user_entity_accounts_record_count = misys._config.user_entity_accounts_record_count || <xsl:value-of select="$entityCount"></xsl:value-of>,
						
						misys._config.entityIdNmArray =  misys._config.entityIdArray || [
						{
									<xsl:for-each select="entities/entity">
										'<xsl:value-of select="entity_id" />':['<xsl:value-of select="entity_abbv_name" />']
										<xsl:if test="position()!=last()">,</xsl:if>
									</xsl:for-each>
						}
						],
						
						dojo.mixin(misys._config,{  
								
								entityIdArray : new Array(),     
																	
								entityIdArray : [
											<xsl:for-each select="entities/entity">
												<xsl:value-of select="entity_id"></xsl:value-of><xsl:if test="position()!=last()">,</xsl:if>
											</xsl:for-each>
								]
								
						});
					});
				</script>
				<div id='entity_list'>
					<div id="userAccountsTableHeaderContainer" style="width:100%;">
						<div class="userAccountsTableCell userAccountsTableCellHeader  userAccountsHeaderSelector">
							<xsl:choose>
							    <xsl:when test="$displaymode='edit'">
							      <xsl:call-template name="column-check-box">
										<xsl:with-param name="id">entity_select_all</xsl:with-param>
								  </xsl:call-template>
							    </xsl:when>
							    <xsl:otherwise>
							     	<p class="hide">auto</p>
							    </xsl:otherwise>
						   </xsl:choose>
						 </div>
						 <div class="userAccountsTableCell userAccountsTableCellHeader  userAccountColumnCell" >
								<xsl:attribute name="style">width:95%;</xsl:attribute>
								<xsl:value-of select="localization:getGTPString($language, 'ENTITY')"/>
						</div>
					</div>	
					<xsl:for-each select="entities/entity">
					<div style="width:100%;">
						<div class="userAccountsTableCell userAccountsTableCellOdd alignCenterWithPadding userAccountsHeaderSelector">
							<xsl:call-template name="column-check-box">
								<xsl:with-param name="id">entity_<xsl:value-of select="entity_id"/></xsl:with-param>
								<xsl:with-param name="checked"><xsl:value-of select="is_enabled"/></xsl:with-param>
								<xsl:with-param name="disabled">
									<xsl:choose>
										<xsl:when test = "is_valid[.= 'N']">Y</xsl:when>
										<xsl:otherwise>N</xsl:otherwise>
									</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
						</div>
						<div class="userAccountsTableCell userAccountsTableCellOdd alignLeftWithPadding" style="width:95%;">
							<xsl:value-of select="entity_abbv_name"/>
						</div>					
					</div>					
					</xsl:for-each>					
				</div>
			</xsl:when>
		</xsl:choose>
   		</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
        <xsl:template name="bank-options">
           <xsl:choose>
            <xsl:when test="$displaymode='edit'">
             <xsl:for-each select="banks/bank_abbv_name">
                <option>
                 <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
                    <xsl:value-of select="."></xsl:value-of>
                </option>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="bank_abbv_name"/>
            </xsl:otherwise>
           </xsl:choose>
       </xsl:template>
 <xsl:template name="customer-reference">
	 <xsl:call-template name="fieldset-wrapper">
	 	<xsl:with-param name="legend">XSL_PARTIESDETAILS_CUSTOMER_REFERENCE</xsl:with-param>
	   	   <xsl:with-param name="content">
	   	     <xsl:variable name="ext-reference-value">
   	   			<xsl:value-of select = "external_acc_reference"/>  
   	   		</xsl:variable>
	   	   <xsl:variable name="cust_ref_desc">
   	   			<xsl:value-of select="//*/customer_reference[reference=$ext-reference-value]/description"/>
   	   		    </xsl:variable>
   	   		
   	   		<xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">external_acc_reference_val</xsl:with-param>
		       <xsl:with-param name="value"><xsl:value-of select="$cust_ref_desc"/></xsl:with-param>
		   	</xsl:call-template>
     	   <xsl:choose>
     	   	<xsl:when test ="$displaymode='edit'">
	     	   	<xsl:call-template name="select-field">
	     	  	 <xsl:with-param name="label">XSL_PARTIESDETAILS_CUSTOMER_REFERENCE</xsl:with-param>
	     	  	 <xsl:with-param name="name">external_acc_reference</xsl:with-param>
	     	  	 <xsl:with-param name="value"><xsl:value-of select="external_acc_reference"/></xsl:with-param>
	     	  	 <xsl:with-param name="required">Y</xsl:with-param>
	     	  	 <xsl:with-param name="options">
	 	  			<xsl:for-each select = "customer_reference[not(reference=preceding::reference)]">
	    				<option>
	    					<xsl:attribute name = "value">
	    						<xsl:value-of select = "reference"/>
	    					</xsl:attribute>
	    					<xsl:value-of select ="description"/>
	    				</option>
	    			</xsl:for-each>
	     	  	</xsl:with-param>
	     	  </xsl:call-template>
     	   	</xsl:when>
     	   	<xsl:otherwise>     	   	
     	   		<xsl:call-template name="input-field">
	      			<xsl:with-param name="label">XSL_PARTIESDETAILS_CUST_REFERENCE</xsl:with-param>
	      			<xsl:with-param name="name">external_acc_reference</xsl:with-param>
	      			<xsl:with-param name="value"><xsl:value-of select="$cust_ref_desc"/></xsl:with-param>
     			</xsl:call-template>
     	   	</xsl:otherwise>    	   
     	   </xsl:choose>
	   	   </xsl:with-param>
	   </xsl:call-template>
 </xsl:template>
 <!--
  Main Details of the External Accounts
  -->
 <xsl:template name="external-account-details">
 	<script>
	dojo.ready(function(){
       	  	misys._config.ibanAccountValidationRegex = '<xsl:value-of select="$ibanAccountValidationRegex" />';
       	  	misys._config.ibanAccountValidationEnabled = '<xsl:value-of select="$ibanAccountValidationEnabled" />';
       	  	});
	</script>  
		
	<xsl:variable name="current"><xsl:value-of select="static_company/language"/></xsl:variable>
  	<xsl:call-template name="fieldset-wrapper">
   		<xsl:with-param name="legend">XSL_HEADER_EXTERNAL_ACCOUNT</xsl:with-param>
   		<xsl:with-param name="content">
     		 <xsl:call-template name="select-field">
     			<xsl:with-param name="label">XSL_ACCOUNT_FORMAT</xsl:with-param>
     			<xsl:with-param name="name">format</xsl:with-param>
     			<xsl:with-param name="fieldsize">small</xsl:with-param>
     			<xsl:with-param name="required">Y</xsl:with-param>
     			<xsl:with-param name="options">
     				<xsl:call-template name="account-format-options"/>
     			</xsl:with-param>
   			 </xsl:call-template>
   			 <xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_ACCOUNT_NICK_NAME_LABEL</xsl:with-param>
      			<xsl:with-param name="name">acct_name</xsl:with-param>
      			<xsl:with-param name="type">text</xsl:with-param>
      			<xsl:with-param name="required">Y</xsl:with-param>
      			<xsl:with-param name="maxsize">40</xsl:with-param>
     		</xsl:call-template>
     		 <xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_ACCOUNT_NUMBER</xsl:with-param>
      			<xsl:with-param name="name">account_no</xsl:with-param>
      			<xsl:with-param name="type">text</xsl:with-param>
      			<xsl:with-param name="required">Y</xsl:with-param>
      			<xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('ACCOUNT_NUMBER_LENGTH')"/></xsl:with-param>
     		</xsl:call-template>
     		<xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_ALTERNATIVE_ACCOUNT_NUMBER</xsl:with-param>
      			<xsl:with-param name="name">alternative_acct_no</xsl:with-param>
      			<xsl:with-param name="type">text</xsl:with-param>
      			<xsl:with-param name="required">N</xsl:with-param>
      			<xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('ACCOUNT_NUMBER_LENGTH')"/></xsl:with-param>
     		</xsl:call-template>
     		<xsl:call-template name="currency-field">
       	  		<xsl:with-param name="label">XSL_ACCOUNT_CURRENCY</xsl:with-param>
            	<xsl:with-param name="product-code">account</xsl:with-param>
           		<xsl:with-param name="show-amt">N</xsl:with-param>
           		<xsl:with-param name="required">Y</xsl:with-param>
           		<xsl:with-param name="override-currency-value"><xsl:value-of select="./cur_code"/></xsl:with-param>
        	 </xsl:call-template>
			<xsl:call-template name="input-field">
      			 <xsl:with-param name="label">XSL_ACCOUNT_DESCRIPTION</xsl:with-param>
      			 <xsl:with-param name="name">description</xsl:with-param>
      			 <xsl:with-param name="maxsize">40</xsl:with-param>
     		</xsl:call-template>
     		<xsl:call-template name="input-field">
       	  		<xsl:with-param name="label">XSL_ROUTING_CODE</xsl:with-param>
            	<xsl:with-param name="name">routing_bic</xsl:with-param>
            	<xsl:with-param name="maxsize">20</xsl:with-param>
        	 </xsl:call-template>
        	<xsl:call-template name="input-field">
		      	<xsl:with-param name="label">XSL_BENEFICIARY_SWIFT_BIC_CODE</xsl:with-param>
		      	<xsl:with-param name="name">bank_iso_code</xsl:with-param>
		      	<xsl:with-param name="value"><xsl:value-of select="iso_code"/></xsl:with-param>
		        <xsl:with-param name="size">11</xsl:with-param>
		       	<xsl:with-param name="maxsize">11</xsl:with-param>
                <xsl:with-param name="required">Y</xsl:with-param>
		       	<xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
		       	<xsl:with-param name="swift-validate">N</xsl:with-param>
		    </xsl:call-template>
		    <xsl:if  test= "$displaymode = 'edit'">
		    <xsl:call-template name="button-wrapper">
				 <xsl:with-param name="label">XSL_ALT_BANK</xsl:with-param>
				 <xsl:with-param name="show-image">Y</xsl:with-param>
				 <xsl:with-param name="show-border">N</xsl:with-param>
				 <xsl:with-param name="onclick">misys.setExecuteClientPassBack(true);misys.showSearchDialog('bank',"['bank_name', 'bank_address_line_1', 'bank_address_line_2', 'bank_dom', 'bank_iso_code', 'bank_contact_name', 'bank_phone','bank_country']", {swiftcode: false, bankcode: false}, '', '', 'width:710px;height:350px;', '<xsl:value-of select="localization:getGTPString($language, 'LIST_TITLE_SDATA_LIST_OF_BANKS')"/>');return false;</xsl:with-param>
			     <xsl:with-param name="id">bank_iso_img</xsl:with-param>
				 <xsl:with-param name="non-dijit-button">N</xsl:with-param>
				 <xsl:with-param name="swift-validate">N</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
		    <!--
				    
        	 <xsl:call-template name="input-field">
                <xsl:with-param name="label">XSL_BENEFICIARY_SWIFT_BIC_CODE</xsl:with-param>
                <xsl:with-param name="name">bank_iso_code</xsl:with-param>
                <xsl:with-param name="value"><xsl:value-of select="iso_code"/></xsl:with-param>
                <xsl:with-param name="size">11</xsl:with-param>
                <xsl:with-param name="maxsize">11</xsl:with-param>
                <xsl:with-param name="button-type">swift</xsl:with-param>
                <xsl:with-param name="required">Y</xsl:with-param>
                <xsl:with-param name="prefix">bank</xsl:with-param>
			</xsl:call-template>
			--><xsl:call-template name="input-field">
			    <xsl:with-param name="label">XSL_BANK_NAME</xsl:with-param>
			  	<xsl:with-param name="name">bank_name</xsl:with-param>
			  	<xsl:with-param name="required">Y</xsl:with-param>
		  	</xsl:call-template>	    	
     	  	<xsl:call-template name="input-field">
		   	 	<xsl:with-param name="label">XSL_BANK_ADDRESS</xsl:with-param>
		   		<xsl:with-param name="name">bank_address_line_1</xsl:with-param>
		   		<xsl:with-param name="required">Y</xsl:with-param>
		    <xsl:with-param name="maxsize">35</xsl:with-param>
	      </xsl:call-template>
	       <xsl:call-template name="input-field">
		    	<xsl:with-param name="label"></xsl:with-param>
		    	<xsl:with-param name="name">bank_address_line_2</xsl:with-param>
		    	<xsl:with-param name="maxsize">35</xsl:with-param>
	      </xsl:call-template>
	       <xsl:call-template name="input-field">
		    	<xsl:with-param name="label"></xsl:with-param>
		    	<xsl:with-param name="name">bank_dom</xsl:with-param>
		    	<xsl:with-param name="maxsize">35</xsl:with-param>
	      </xsl:call-template>
	      <xsl:call-template name="country-field">
     		<xsl:with-param name="name">country</xsl:with-param>
     		<xsl:with-param name="prefix">bank</xsl:with-param>
     		<xsl:with-param name="required">Y</xsl:with-param>
     		<xsl:with-param name="value"><xsl:value-of select="country"/></xsl:with-param>
     		<xsl:with-param name="readonly">Y</xsl:with-param>
     	   </xsl:call-template>
     	   
     	   <!-- Active Flag -->
	   		<div id="active_flag_div">
	   			 <xsl:call-template name="multichoice-field">
		     		<xsl:with-param name="type">checkbox</xsl:with-param>
		       	 	<xsl:with-param name="label">XSL_ACTIVE_FLAG</xsl:with-param>
		  	  		<xsl:with-param name="name">actv_flag</xsl:with-param>
		  	  		<xsl:with-param name="checked"><xsl:if test="actv_flag[. = 'Y'] or $intialActvflag = 'Y'">Y</xsl:if></xsl:with-param>
		   		 </xsl:call-template>
	   		</div>
	   		<xsl:if test="sweeping_enabled!='' and defaultresource:getResource('LIQUIDITY_BACK_OFFICE_KTP') = 'false'">
	   			 <xsl:call-template name="input-field">
	      			 <xsl:with-param name="label">XSL_SWEEPING_ENABLED</xsl:with-param>
	      			 <xsl:with-param name="id">sweeping_enabled</xsl:with-param>
	      			 <xsl:with-param name="value">
	      			 <xsl:choose>
		      			 <xsl:when test="sweeping_enabled[.='Y']"><xsl:value-of select="localization:getGTPString($language, 'XSL_YES')"/></xsl:when>
		      			 <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_NO')"/></xsl:otherwise>
	      			 </xsl:choose>
	      			 </xsl:with-param>
	      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
	     		</xsl:call-template>
     		</xsl:if>
	   </xsl:with-param>
	 </xsl:call-template>
 </xsl:template>
 
 <!--
  Main Details of the Products
  -->
 <!-- 
  Realform
  -->
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
       <xsl:with-param name="value" select="$operation"></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="$option"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
      </xsl:call-template>
      	<xsl:call-template name="hidden-field">
       		<xsl:with-param name="name">company</xsl:with-param>
       		<xsl:with-param name="value"><xsl:value-of select="$company"/></xsl:with-param>
      	</xsl:call-template>
      <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">token</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$token"/></xsl:with-param>
      </xsl:call-template>
      <xsl:if test="account_id[.!='']">
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">featureid</xsl:with-param>
        <xsl:with-param name="value"><xsl:value-of select="account_id"/></xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">processdttm</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$processdttm"/></xsl:with-param>
      </xsl:call-template>
       <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">mode</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$draftMode"/></xsl:with-param>
      </xsl:call-template>
      <xsl:if test="tnx_id[.!='']">
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">tnxid</xsl:with-param>
        <xsl:with-param name="value"><xsl:value-of select="tnx_id"/></xsl:with-param>
       </xsl:call-template>
      </xsl:if>
        <xsl:call-template name="hidden-field">
         <xsl:with-param name="id">url_parameter_entity</xsl:with-param>
   		 <xsl:with-param name="name">entity</xsl:with-param>
   		 <xsl:with-param name="value"><xsl:value-of select="$entity"/></xsl:with-param>
  		</xsl:call-template>
  		<xsl:call-template name="e2ee_transaction"/>
     </div>
    </xsl:with-param>
   </xsl:call-template>
     </xsl:if>
  </xsl:template>
<!-- Account format Options -->
<xsl:template name="account-format-options">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
   
     <option value="02"><xsl:value-of select="localization:getDecode($language, 'N069', '02')"/></option>
     <option value="99"><xsl:value-of select="localization:getDecode($language, 'N069', '99')"/></option>
    </xsl:when>
    <xsl:otherwise>
      	<xsl:if test="format[. = '02']"><xsl:value-of select="localization:getDecode($language, 'N069', '02')"/></xsl:if>
      	<xsl:if test="format[. = '99']"><xsl:value-of select="localization:getDecode($language, 'N069', '99')"/></xsl:if>
    </xsl:otherwise>
   </xsl:choose>
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