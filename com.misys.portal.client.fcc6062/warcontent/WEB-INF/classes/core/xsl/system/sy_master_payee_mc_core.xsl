<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Master payee, System Form.

Copyright (c) 2000-2011 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      13/10/2011
author:    Rajesh kumar
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		exclude-result-prefixes="localization">
  <!-- 	
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
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
  <xsl:param name="isMultiBank">N</xsl:param>
  <!-- Global Imports. -->
  <xsl:include href="../common/system_common.xsl" />
  <xsl:include href="../common/maker_checker_common.xsl" />
  <xsl:include href="../../../core/xsl/common/e2ee_common.xsl" />
    
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
   <!-- Loading message  -->
   <xsl:call-template name="loading-message"/>
   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
   	 	<xsl:with-param name="name" select="$main-form-name"/>
   	 	<xsl:with-param name="validating">Y</xsl:with-param>
   	 	<xsl:with-param name="content">
      			<xsl:apply-templates select="input/master_payee_record" mode="input"/>
      			
      			<!-- <xsl:call-template name="system-menu" /> -->
      			<xsl:if test="$canCheckerReturnComments = 'true'">
						<xsl:call-template name="comments-for-return-mc">
							<xsl:with-param name="value"><xsl:value-of select="input/master_payee_record/return_comments"/></xsl:with-param>
						</xsl:call-template>
					</xsl:if>
      			<xsl:call-template name="maker-checker-menu"/>
      			
      			
     	</xsl:with-param>
    </xsl:call-template>
    	<xsl:call-template name="payeeref-dialog-template" />
    	<xsl:call-template name="realform"/>
   </div>
    
   	<!-- Javascript imports  -->
   <xsl:call-template name="js-imports"/>
  </xsl:template>
 <!-- Additional JS imports for this form are -->
 <!-- added here. -->
 <xsl:template name="js-imports">
  <xsl:call-template name="system-common-js-imports">
   	<xsl:with-param name="xml-tag-name">master_payee_record</xsl:with-param>
   	<xsl:with-param name="binding">misys.binding.system.master_payee</xsl:with-param>
   	<xsl:with-param name="override-help-access-key">SY_BILLPB</xsl:with-param>	
   	<xsl:with-param name="override-home-url">'/screen/<xsl:value-of select="$nextscreen"/>?option=<xsl:value-of select="$option"/>'</xsl:with-param>
  </xsl:call-template>
  	<script>
        dojo.ready(function(){
              misys._config = misys._config || {};
              misys._config.billp = {};
              dojo.mixin(misys._config.billp,{
                          registrationArr : new Array()
              });
              
              <xsl:for-each select="/input/payee_categories/payee_category">
                          misys._config.billp.registrationArr["<xsl:value-of select="@code"/>"] = "<xsl:value-of select="registartion_required"/>";
              </xsl:for-each>
              });
              
	            
	</script>
	<script>
        dojo.ready(function(){
              misys._config = misys._config || {};
              misys._config.isMultiBank=<xsl:choose>
									 	<xsl:when test="$isMultiBank='Y'">true</xsl:when>
									 	<xsl:otherwise>false</xsl:otherwise>
								   </xsl:choose>;
              misys._config.bankList={};
              <xsl:for-each select="/input/banks/bank_name">
                          misys._config.bankList["<xsl:value-of select="."></xsl:value-of>"]
              </xsl:for-each>
              dojo.mixin(misys._config,{
              	perBankPayeeCategory:{
              		<xsl:for-each select="/input/per_bank_category/bank_category/bank_name">
              			<xsl:variable name="bank_name" select="self::node()/text()"/>
              			<xsl:value-of select="."/>:[
              				<xsl:for-each select="/input/per_bank_category/bank_category[bank_name=$bank_name]/category_name">
	              				{name:"<xsl:value-of select="substring-after(., '_')"/>",
	              				value:"<xsl:value-of select="substring-after(., '_')"/>"},
              				</xsl:for-each>
              			]<xsl:if test="not(position()=last())">,</xsl:if>
              		</xsl:for-each>
              	}
              });
              
              dojo.mixin(misys._config,{
              	perBankPayeeCategoryRegistrationRequired:{
              		<xsl:for-each select="/input/per_bank_category/bank_category/bank_name">
              			<xsl:variable name="bank_name" select="self::node()/text()"/>
              			<xsl:value-of select="$bank_name"/>:[
	              			<xsl:for-each select="/input/per_bank_category/bank_category[bank_name=$bank_name]/category_name">
	              				{reg:"<xsl:value-of select="substring(., 1, 1)" />",
	              				cat:"<xsl:value-of select="substring(., 3)"/>"},
	              			</xsl:for-each>
              			]<xsl:if test="not(position()=last())">,</xsl:if>
              		</xsl:for-each>
              	}
              });
              });         
	</script>
 </xsl:template>
 
<!-- =========================================================================== -->
<!-- =================== Template for Basic Package Details in INPUT mode =============== -->
<!-- =========================================================================== -->
  <xsl:template match="master_payee_record" mode="input">
  		<xsl:call-template name="fieldset-wrapper">
  		<xsl:with-param name="legend">XSL_HEADER_BASIC_MASTER_PAYEE_DETAILS</xsl:with-param>
  		<xsl:with-param name="button-type">
   			<xsl:if test="$hideMasterViewLink!='true'">mc-master-details</xsl:if>
   		</xsl:with-param>
 			<xsl:with-param name="content">
 				<!-- if update populate the master payee id -->
		 		<xsl:if test="master_payee_id[.!='']">
		      		<xsl:call-template name="hidden-field">
		       			<xsl:with-param name="name">master_payee_id</xsl:with-param>
		       			<xsl:with-param name="value"><xsl:value-of select="master_payee_id"/></xsl:with-param>
		      		</xsl:call-template>
 				</xsl:if>
 				<xsl:call-template name="hidden-field">
		       			<xsl:with-param name="name">payee_type</xsl:with-param>
		       			<xsl:with-param name="value"><xsl:value-of select="payee_type"/></xsl:with-param>
		      	</xsl:call-template>
		      	<xsl:call-template name ="hidden-field">
		      		<xsl:with-param name="name">current_date</xsl:with-param>
		      		<xsl:with-param name="value"></xsl:with-param>
		      	</xsl:call-template>
		      	<xsl:call-template name="hidden-field">
		       			<xsl:with-param name="name">reg_required</xsl:with-param>
		       			<xsl:with-param name="value"></xsl:with-param>
		      	</xsl:call-template>
		      	
 				 <xsl:call-template name="input-field">
  					<xsl:with-param name="label">XSL_JURISDICTION_PAYEE_CODE</xsl:with-param>
    				<xsl:with-param name="name">payee_code</xsl:with-param>
    				<xsl:with-param name="size">8</xsl:with-param>
    				<xsl:with-param name="fieldsize">small</xsl:with-param>
   					<xsl:with-param name="maxsize">8</xsl:with-param>
   					<xsl:with-param name="regular-expression">[0-9]{1,8}</xsl:with-param>
   					<xsl:with-param name="required">Y</xsl:with-param>
   				</xsl:call-template>
   				
   				
   			 	<xsl:call-template name="input-field">
  					<xsl:with-param name="label">XSL_JURISDICTION_PAYEE_NAME</xsl:with-param>
    				<xsl:with-param name="name">payee_name</xsl:with-param>
    				<xsl:with-param name="size">70</xsl:with-param>
   					<xsl:with-param name="maxsize">70</xsl:with-param>
   					<xsl:with-param name="fieldsize">large</xsl:with-param>
   					<xsl:with-param name="required">Y</xsl:with-param>
   				</xsl:call-template>
  				<xsl:call-template name="input-field">
  					<xsl:with-param name="label">XSL_JURISDICTION_LOCAL_PAYEE_NAME</xsl:with-param>
    				<xsl:with-param name="name">local_payee_name</xsl:with-param>
    				<xsl:with-param name="size">70</xsl:with-param>
   					<xsl:with-param name="maxsize">70</xsl:with-param>
   					<xsl:with-param name="fieldsize">large</xsl:with-param>
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
   				<!-- category selection -->
   				<xsl:choose>
   					<xsl:when test="$isMultiBank='Y'">
   						<xsl:choose>
   							 <xsl:when test="$displaymode='edit'">
   							 	<xsl:call-template name="select-field">
									<xsl:with-param name="label">XSL_FEATURE_BILLER_CATEGORY_DESC</xsl:with-param>
									<xsl:with-param name="name">payee_category</xsl:with-param>
									<xsl:with-param name="required">Y</xsl:with-param>
									<xsl:with-param name="value"><xsl:value-of select="master_payee_record/payee_category"/></xsl:with-param>
								</xsl:call-template>
   							 </xsl:when>
   							 <xsl:otherwise>
   							 	<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_FEATURE_BILLER_CATEGORY_DESC</xsl:with-param>
									<xsl:with-param name="override-displaymode">view</xsl:with-param>
									<xsl:with-param name="value"><xsl:value-of select="payee_category"/></xsl:with-param>
								</xsl:call-template>
   							 </xsl:otherwise>
   						</xsl:choose>
   					</xsl:when>
   					<xsl:otherwise>
   						<xsl:call-template name="select-field">
							<xsl:with-param name="label">XSL_FEATURE_BILLER_CATEGORY_DESC</xsl:with-param>
							<xsl:with-param name="name">payee_category</xsl:with-param>
							<xsl:with-param name="required">Y</xsl:with-param>
							<xsl:with-param name="options">
								<xsl:call-template name="payee_category_options"/>
							</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="payee_category"/></xsl:with-param>
						</xsl:call-template>
   					</xsl:otherwise>
   				</xsl:choose>
   					   			
			    <xsl:choose>
					<xsl:when test="$displaymode='edit'">
						<xsl:call-template name="row-wrapper">
							<xsl:with-param name="label">XSL_JURISDICTION_PAYEE_DESCRIPTION</xsl:with-param>
							<xsl:with-param name="type">textarea</xsl:with-param>
							<xsl:with-param name="content">
								<xsl:call-template name="textarea-field">
								<xsl:with-param name="name">description</xsl:with-param>
								<xsl:with-param name="rows">3</xsl:with-param>
								<xsl:with-param name="cols">50</xsl:with-param>
								<xsl:with-param name="maxlines">3</xsl:with-param>
								<xsl:with-param name="fieldsize">large</xsl:with-param>
								<xsl:with-param name="required">N</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="row-wrapper">
							<xsl:with-param name="label">XSL_JURISDICTION_LOCAL_PAYEE_DESCRIPTION</xsl:with-param>
							<xsl:with-param name="type">textarea</xsl:with-param>
							<xsl:with-param name="content">
								<xsl:call-template name="textarea-field">
								<xsl:with-param name="name">local_description</xsl:with-param>
								<xsl:with-param name="rows">3</xsl:with-param>
								<xsl:with-param name="cols">50</xsl:with-param>
								<xsl:with-param name="maxlines">3</xsl:with-param>
								<xsl:with-param name="fieldsize">large</xsl:with-param>
								<xsl:with-param name="required">N</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
				    </xsl:when>
			    	<xsl:otherwise>
			    	<xsl:if test="description != '' ">
						<xsl:call-template name="big-textarea-wrapper">
							<xsl:with-param name="label">XSL_JURISDICTION_PAYEE_DESCRIPTION</xsl:with-param>
							<xsl:with-param name="content">
								<div class="content">
									<xsl:value-of select="description"/>
								</div>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
						<xsl:if test="local_description != '' ">
						<xsl:call-template name="big-textarea-wrapper">
							<xsl:with-param name="label">XSL_JURISDICTION_LOCAL_PAYEE_DESCRIPTION</xsl:with-param>
							<xsl:with-param name="content">
								<div class="content">
									<xsl:value-of select="local_description"/>
								</div>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
			    	</xsl:otherwise>
			    </xsl:choose>

			    <div id="service_section">
			    <xsl:call-template name="input-field">
  					<xsl:with-param name="label">XSL_JURISDICTION_SERVICE_CODE</xsl:with-param>
    				<xsl:with-param name="name">service_code</xsl:with-param>
    				<xsl:with-param name="size">8</xsl:with-param>
    				<xsl:with-param name="fieldsize">small</xsl:with-param>
   					<xsl:with-param name="maxsize">8</xsl:with-param>
   					<xsl:with-param name="regular-expression">[0-9]{1,8}</xsl:with-param>
   					<xsl:with-param name="required">Y</xsl:with-param>
   				</xsl:call-template>
   				<xsl:call-template name="input-field">
  					<xsl:with-param name="label">XSL_JURISDICTION_SERVICE_NAME</xsl:with-param>
    				<xsl:with-param name="name">service_name</xsl:with-param>
    				<xsl:with-param name="size">70</xsl:with-param>
   					<xsl:with-param name="maxsize">70</xsl:with-param>
   					<xsl:with-param name="fieldsize">large</xsl:with-param>
   					<xsl:with-param name="required">Y</xsl:with-param>
   				</xsl:call-template>
   				<xsl:call-template name="input-field">
  					<xsl:with-param name="label">XSL_JURISDICTION_LOCAL_SERVICE_NAME</xsl:with-param>
    				<xsl:with-param name="name">local_service_name</xsl:with-param>
    				<xsl:with-param name="size">70</xsl:with-param>
   					<xsl:with-param name="maxsize">70</xsl:with-param>
   					<xsl:with-param name="fieldsize">large</xsl:with-param>
   				</xsl:call-template>
   				</div>
				<xsl:if test="payee_type[.='01']">
		   			<xsl:call-template name="currency-field">
						<xsl:with-param name="label">XSL_PAYEE_DDA_AMT</xsl:with-param>
						<xsl:with-param name="product-code">base</xsl:with-param>
						<xsl:with-param name="override-currency-value"><xsl:value-of select="cur_code"/></xsl:with-param>
						<xsl:with-param name="override-amt-name">limit_amt</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
		   			</xsl:call-template>
	   			</xsl:if>
	   			<xsl:if test="payee_type[.='02']">		   			
		   			<xsl:call-template name="input-field">
				    	<xsl:with-param name="button-type">currency</xsl:with-param>
				    	<xsl:with-param name="label">XSL_JURISDICTION_CURRENCY</xsl:with-param>
				    	<xsl:with-param name="name">base_cur_code</xsl:with-param>
				    	<xsl:with-param name="value" select="cur_code"></xsl:with-param>
				    	<!-- to give the name to the javascript, normally it's a product code -->
				    	<xsl:with-param name="override-product-code">base</xsl:with-param>
				    	<xsl:with-param name="size">3</xsl:with-param>
				        <xsl:with-param name="fieldsize">x-small</xsl:with-param>
				       	<xsl:with-param name="maxsize">3</xsl:with-param>
				       	<xsl:with-param name="uppercase">Y</xsl:with-param>
				       	<xsl:with-param name="required">Y</xsl:with-param>
				    </xsl:call-template>
    
	   			</xsl:if>
	   			 <xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_JURISDICTION_END_DATE</xsl:with-param>
					<xsl:with-param name="name">end_date</xsl:with-param>
					<xsl:with-param name="type">date</xsl:with-param>
					<xsl:with-param name="size">10</xsl:with-param>
					<xsl:with-param name="maxsize">10</xsl:with-param>
					<xsl:with-param name="fieldsize">small</xsl:with-param>
	   			</xsl:call-template>
   			 	<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_JURISDICTION_SAMPLE_BILL_PATH</xsl:with-param>
					<xsl:with-param name="name">samp_bill_path</xsl:with-param>
					<xsl:with-param name="size">255</xsl:with-param>
					<xsl:with-param name="maxsize">255</xsl:with-param>
					<xsl:with-param name="fieldsize">large</xsl:with-param>
					<xsl:with-param name="regular-expression">(ftp|http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&amp;%@!\-\/]))?</xsl:with-param>
   				</xsl:call-template>
   				<xsl:call-template name="input-field">
  					<xsl:with-param name="label">XSL_JURISDICTION_ADDITIONAL_INFO</xsl:with-param>
    				<xsl:with-param name="name">additional_Info</xsl:with-param>
    				<xsl:with-param name="size">200</xsl:with-param>
   					<xsl:with-param name="maxsize">200</xsl:with-param>
   					<xsl:with-param name="fieldsize">large</xsl:with-param>
   				</xsl:call-template>
   				<xsl:call-template name="input-field">
  					<xsl:with-param name="label">XSL_JURISDICTION_LOCAL_ADDITIONAL_INFO</xsl:with-param>
    				<xsl:with-param name="name">local_additional_Info</xsl:with-param>
    				<xsl:with-param name="size">200</xsl:with-param>
   					<xsl:with-param name="maxsize">200</xsl:with-param>
   					<xsl:with-param name="fieldsize">large</xsl:with-param>
   			</xsl:call-template>
     		</xsl:with-param>      		
  		</xsl:call-template>
  		<xsl:call-template name="payeeref-grid-details" />	 
  		<!--<xsl:call-template name="fieldset-wrapper">
   			<xsl:with-param name="content">
     			<xsl:call-template name="payeeref-grid-details" />
     			  <xsl:call-template name="payeeref-dialog-template" />    
   			</xsl:with-param>
   		</xsl:call-template>
  	--></xsl:template>
	<xsl:template name="payeeref-grid-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_MASTER_PAYEE_BILL_REF_DETAILS</xsl:with-param>
					<!--<xsl:with-param name="parse-widgets">N</xsl:with-param>
					--><xsl:with-param name="content">
						<xsl:call-template name="build-payeerefs-dojo-items">
							<xsl:with-param name="items" select="master_payee_refs/master_payee_ref_record" />
							<xsl:with-param name="max-bill-refs">5</xsl:with-param>
						</xsl:call-template>
					<!-- This div is required to force the content to appear -->
					<div style="height:1px">&nbsp;</div>
					</xsl:with-param>
		</xsl:call-template>
		
		<!--  <div id="payeerefs-section" style="display:block">
				<xsl:call-template name="build-payeerefs-dojo-items">
					<xsl:with-param name="items" select="master_payee_refs/master_payee_ref_record" />
				</xsl:call-template>
		</div> -->
	</xsl:template>	
	
  <xsl:template name="payee_category_options">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <xsl:apply-templates select="/input/payee_categories/payee_category"/>
    </xsl:when>
    <xsl:otherwise>
      	<xsl:value-of select="/input/master_payee_record/payee_category"/>      
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
  
  <xsl:template name="bank-options">
  	<xsl:choose>
  		<xsl:when test="$displaymode='edit'">
  			<xsl:for-each select="/input/banks/bank_abbv_name">
		     	<option>
		     		<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
		     	    <xsl:value-of select="."></xsl:value-of>
		     	</option>
     		</xsl:for-each>
  		</xsl:when>
  		<xsl:otherwise>
  			<xsl:value-of select ="/input/master_payee_record/bank_abbv_name"></xsl:value-of>
  		</xsl:otherwise>
  	</xsl:choose>
  </xsl:template>
		
	<!-- Payee Bill refs start -->
	<xsl:template name="invalidateRPayeeConfirmationDialog">
		<div id="invalidate-reg-payee-dialog" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
			<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="content">
					<!-- Referrence id  -->
					<xsl:call-template name="label-wrapper">
						<xsl:with-param name="content">XSL_REG_PAYEE_INVALIDATE_MESSAGE</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="label-wrapper">
						<xsl:with-param name="content">
							<button dojoType="dijit.form.Button"  id="yesButton" type="button">
							<!--<xsl:attribute name="onmouseup">misys.fncValidatePayeeRefPopup();</xsl:attribute>
								-->
								<xsl:attribute name="onClick">misys.dialog.submitPayeeRef('payeeref-dialog-template')</xsl:attribute>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_DIALOG_YES')"/>
							</button>
							<button dojoType="dijit.form.Button" type="button" id="noButton">
								<xsl:attribute name="onmouseup">dijit.byId('invalidate-reg-payee-dialog').hide();</xsl:attribute>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_DIALOG_NO')"/>
							</button>
							<button dojoType="dijit.form.Button" type="button" >
								<xsl:attribute name="onmouseup">dijit.byId('invalidate-reg-payee-dialog').hide();</xsl:attribute>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')"/>
							</button>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>	
			</xsl:call-template>
		</div>
	</xsl:template>
	<!-- Dialog Start -->
	<xsl:template name="payeeref-dialog-template">
		<div id="payeeref-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
					
					<!-- Referrence id  -->
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_JURISDICTION_REFERENCE_ID</xsl:with-param>
						<xsl:with-param name="name">reference_id</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
						<xsl:with-param name="maxsize">8</xsl:with-param>
						<xsl:with-param name="size">8</xsl:with-param>
						<xsl:with-param name="fieldsize">small</xsl:with-param>
						<xsl:with-param name="regular-expression">[0-9]{1,8}</xsl:with-param>
					</xsl:call-template>
					<!--
					 English Label 
					--><xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_JURISDICTION_LABEL</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
						<xsl:with-param name="maxsize">25</xsl:with-param>
						<xsl:with-param name="size">25</xsl:with-param>
						<xsl:with-param name="name">label</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_JURISDICTION_LOCAL_LABEL</xsl:with-param>
						<xsl:with-param name="required">N</xsl:with-param>
						<xsl:with-param name="maxsize">25</xsl:with-param>
						<xsl:with-param name="size">25</xsl:with-param>
						<xsl:with-param name="name">local_label</xsl:with-param>
					</xsl:call-template>					
		    		<xsl:call-template name="textarea-field">	
		    			<xsl:with-param name="label">XSL_JURISDICTION_HELP_MESSAGE</xsl:with-param>
				        <xsl:with-param name="name">help_message</xsl:with-param>
				        <xsl:with-param name="cols">100</xsl:with-param>
				        <xsl:with-param name="rows">6</xsl:with-param>
				        <xsl:with-param name="maxlength">600</xsl:with-param>			        
				    </xsl:call-template>
				    <div></div>
				   	<xsl:call-template name="textarea-field">	
		    			<xsl:with-param name="label">XSL_JURISDICTION_LOCAL_HELP_MESSAGE</xsl:with-param>
				        <xsl:with-param name="name">local_help_message</xsl:with-param>
				        <xsl:with-param name="cols">100</xsl:with-param>
				        <xsl:with-param name="rows">6</xsl:with-param>
				        <xsl:with-param name="maxlength">600</xsl:with-param>			        
				    </xsl:call-template>
				    
				    
					<xsl:call-template name="fieldset-wrapper">
						<xsl:with-param name="legend">XSL_JURISDICTION_VALIDATION</xsl:with-param>
						<xsl:with-param name="legend-type">indented-header</xsl:with-param>
						<xsl:with-param name="content">
							<xsl:call-template name="multioption-inline-wrapper">
								<xsl:with-param name="group-label">XSL_JURISDICTION_UI_FIELD_TYPE</xsl:with-param>
								<xsl:with-param name="content">
									<xsl:call-template name="multichoice-field">
										<xsl:with-param name="label">XSL_JURISDICTION_COMBOBOX</xsl:with-param>
										<xsl:with-param name="name">field_type</xsl:with-param>
										<xsl:with-param name="id">field_type_1</xsl:with-param>
										<xsl:with-param name="value">S</xsl:with-param>
										<xsl:with-param name="required">Y</xsl:with-param>
										<xsl:with-param name="type">radiobutton</xsl:with-param>
									    <xsl:with-param name="inline">Y</xsl:with-param>
									</xsl:call-template>
									<xsl:call-template name="multichoice-field">
										<xsl:with-param name="label">XSL_JURISDICTION_TEXTBOX</xsl:with-param>
										<xsl:with-param name="name">field_type</xsl:with-param>
										<xsl:with-param name="id">field_type_2</xsl:with-param>
										<xsl:with-param name="value">T</xsl:with-param>
										<xsl:with-param name="checked">Y</xsl:with-param>
										<xsl:with-param name="required">Y</xsl:with-param>
										<xsl:with-param name="type">radiobutton</xsl:with-param>
									    <xsl:with-param name="inline">Y</xsl:with-param>
									</xsl:call-template>
								</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="checkbox-field">
								<xsl:with-param name="label">XSL_JURISDICTION_OPTIONAL</xsl:with-param>
								<xsl:with-param name="name">optional</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="checkbox-field">
								<xsl:with-param name="label">XSL_JURISDICTION_CHECKSUM</xsl:with-param>
								<xsl:with-param name="name">external_validation</xsl:with-param>
							</xsl:call-template>
							<div id="format_div">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_JURISDICTION_FORMAT</xsl:with-param>
								<xsl:with-param name="name">validation_format</xsl:with-param>
								<xsl:with-param name="maxsize">255</xsl:with-param>
								<xsl:with-param name="fieldsize">large</xsl:with-param>
							</xsl:call-template>
							</div>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="multioption-inline-wrapper">
						<xsl:with-param name="group-label">XSL_JURISDICTION_INPUTIN</xsl:with-param>
						<xsl:with-param name="content">
							<xsl:call-template name="multichoice-field">
								<xsl:with-param name="label">XSL_JURISDICTION_INPUT_REGISTRATION</xsl:with-param>
								<xsl:with-param name="name">input_in_type</xsl:with-param>
								<xsl:with-param name="id">input_in_type_1</xsl:with-param>
								<xsl:with-param name="value">R</xsl:with-param>
								<xsl:with-param name="required">Y</xsl:with-param>
								<xsl:with-param name="type">radiobutton</xsl:with-param>
							    <xsl:with-param name="inline">Y</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="multichoice-field">
								<xsl:with-param name="label">XSL_JURISDICTION_INPUT_TRANSACTION</xsl:with-param>
								<xsl:with-param name="name">input_in_type</xsl:with-param>
								<xsl:with-param name="id">input_in_type_2</xsl:with-param>
								<xsl:with-param name="value">T</xsl:with-param>
								<xsl:with-param name="checked">Y</xsl:with-param>
								<xsl:with-param name="required">Y</xsl:with-param>
								<xsl:with-param name="type">radiobutton</xsl:with-param>
							    <xsl:with-param name="inline">Y</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
					<div id="dialog-buttons" class="dijitDialogPaneActionBar">	
						<xsl:call-template name="label-wrapper">
							<xsl:with-param name="content">
								<button dojoType="dijit.form.Button"  id="payeerefOkButton" type="button">
								<!--<xsl:attribute name="onmouseup">misys.fncValidatePayeeRefPopup();</xsl:attribute>
								-->
									<xsl:attribute name="onClick">misys.dialog.submitPayeeRef('payeeref-dialog-template')</xsl:attribute>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')"/>
								</button>
								<button dojoType="dijit.form.Button" type="button" id="payeerefCancelButton">
									<xsl:attribute name="onmouseup">dijit.byId('payeeref-dialog-template').hide();</xsl:attribute>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')"/>
								</button>
						</xsl:with-param>
						</xsl:call-template>
					</div>
				
			
		</div>
		<!-- Dialog End -->
		<div id="payeerefs-template" style="display:none">
			<div class="clear">
				<p dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of select="localization:getGTPString($language, 'TABLE_NO_MASTER_PAYEE_REF_DATA')"/>
				</p>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode"/>
				</div>
				<p><br/></p>
				<xsl:if test="$displaymode = 'edit'">
				<button dojoType="dijit.form.Button" type="button"  dojoAttachEvent="onClick: addItem" dojoAttachPoint="addButtonNode">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_ADD_PAYEE_REF')"/>
				</button>
				</xsl:if>
			</div>
		</div>
	</xsl:template>
	
	<!-- ************************************************************************** -->
	<!--                          PAYEE REF - START                                 -->
	<!-- ************************************************************************** -->
	<xsl:template name="build-payeerefs-dojo-items">
		<xsl:param name="items"/>
		<xsl:param name="max-bill-refs"/>
		<div dojoType="misys.system.widget.PayeeRefs" dialogId="payeeref-dialog-template" class="widgetContainer" gridId="payee_refs-grid" id="payee_refs_grid" >
			<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'REFERENCE_ID')"/>,
				<xsl:value-of select="localization:getGTPString($language, 'LABEL')"/>,
				<xsl:value-of select="localization:getGTPString($language, 'LOCAL_LABEL')"/>,
				<xsl:value-of select="localization:getGTPString($language, 'OPTIONAL')"/>,
				<xsl:value-of select="localization:getGTPString($language, 'CHECKSUM')"/>,
				<xsl:value-of select="localization:getGTPString($language, 'REGISTRATION')"/>,
				<xsl:value-of select="localization:getGTPString($language, 'FIELD_TYPE')"/>,
			</xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_MASTER_PAYEE_ADD_BILL_REF')"/></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_MASTER_PAYEE_UPDATE_BILL_REF')"/></xsl:attribute>
			<xsl:attribute name="maxBillRefs"><xsl:value-of select="$max-bill-refs"/></xsl:attribute>
			<xsl:attribute name="viewMode">
    				<xsl:value-of select="$displaymode"/>
    	    </xsl:attribute>
			<xsl:for-each select="$items">
				<xsl:variable name="payee_ref" select="."/>
				<xsl:variable name="position" select="position()" />
				<div dojoType="misys.system.widget.PayeeRef"  >
					<xsl:attribute name="id">payee_ref_<xsl:value-of select="$position"/></xsl:attribute>
					<xsl:attribute name="reference_id"><xsl:value-of select="$payee_ref/reference_id"/></xsl:attribute>
					<xsl:attribute name="label"><xsl:value-of select="$payee_ref/label"/></xsl:attribute>
					<xsl:attribute name="local_label"><xsl:value-of select="$payee_ref/local_label"/></xsl:attribute>
					<xsl:attribute name="help_message"><xsl:value-of select="$payee_ref/help_message"/></xsl:attribute>
					<xsl:attribute name="local_help_message"><xsl:value-of select="$payee_ref/local_help_message"/></xsl:attribute>
					<xsl:attribute name="optional"><xsl:value-of select="$payee_ref/optional"/></xsl:attribute>
					<xsl:attribute name="validation_format"><xsl:value-of select="$payee_ref/validation_format"/></xsl:attribute>
					<xsl:attribute name="external_validation"><xsl:value-of select="$payee_ref/external_validation"/></xsl:attribute>
					<xsl:attribute name="input_in_type"><xsl:value-of select="$payee_ref/input_in_type"/></xsl:attribute>
					<xsl:attribute name="field_type"><xsl:value-of select="$payee_ref/field_type"/></xsl:attribute>
				</div>
			</xsl:for-each>
		</div>
	</xsl:template>
 	<xsl:template match="payee_category">
  	<option>
	    <xsl:attribute name="value"><xsl:value-of select="@code"/></xsl:attribute>
	    <xsl:value-of select="@desc"/>
	 </option>
	</xsl:template>
 	<xsl:template match="bank_name">
  	<option>
	    <xsl:attribute name="value"><xsl:value-of select="text()"/></xsl:attribute>
	 </option>
	</xsl:template>	
 <!-- ***************************************************************************************** -->
 <!-- ************************************** REALFORM ***************************************** -->
 <!-- ***************************************************************************************** -->
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
      	<xsl:with-param name="name">payee_category_hidden</xsl:with-param>
      	<xsl:with-param name="value"><xsl:value-of select="input/master_payee_record/payee_category"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">token</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$token"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:if test="input/master_payee_record/master_payee_id[.!='']">
      	<xsl:call-template name="hidden-field">
       		<xsl:with-param name="name">featureid</xsl:with-param>
       		<xsl:with-param name="value"><xsl:value-of select="input/master_payee_record/master_payee_id"/></xsl:with-param>
      	</xsl:call-template>
      	<xsl:call-template name="hidden-field">
   			<xsl:with-param name="name">invalidate_payee</xsl:with-param>
   			<xsl:with-param name="value">N</xsl:with-param>
	   </xsl:call-template>
	   <xsl:call-template name="hidden-field">
   			<xsl:with-param name="name">registrations_made</xsl:with-param>
   			<xsl:with-param name="value"><xsl:value-of select="$registrations_made"/></xsl:with-param>
	  	</xsl:call-template>
      </xsl:if>
       <xsl:if test="input/master_payee_record/tnx_id[.!='']">
      		<xsl:call-template name="hidden-field">
       			<xsl:with-param name="name">tnxid</xsl:with-param>
       			<xsl:with-param name="value"><xsl:value-of select="input/master_payee_record/tnx_id"/></xsl:with-param>
      		</xsl:call-template>
      	</xsl:if>
      	<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">processdttm</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="$processdttm"/></xsl:with-param>
		</xsl:call-template>
         <xsl:call-template name="e2ee_transaction"/>
      <!--<xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">mode</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$displaymode"/></xsl:with-param>
      </xsl:call-template>
     --></div>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:if>
  </xsl:template>
</xsl:stylesheet>