<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for the details of

 Fund Transfer (FT) Form, Customer Side.

Copyright (c) 2000-2011 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      10/02/12
author:    Raja Rao
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
  version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
  xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
  xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
  exclude-result-prefixes="utils localization">
<xsl:param name="isMultiBank">N</xsl:param>
<!-- 
   SE TNX 
  -->
  <xsl:template match="se_tnx_record"> 
   <!-- Preloader -->
   <xsl:call-template name="loading-message"/>
 
   <div>
    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
	     <xsl:call-template name="menu">	     	
	     	<xsl:with-param name="show-template">N</xsl:with-param>    	     	
	     	<xsl:with-param name="show-return">Y</xsl:with-param>   	     	
	     	<xsl:with-param name="show-save">Y</xsl:with-param>  	     	
	     </xsl:call-template>     
	     
	     <!-- Reauthentication -->
		 <xsl:call-template name="server-message">
		 		<xsl:with-param name="name">server_message</xsl:with-param>
		 		<xsl:with-param name="content"><xsl:value-of select="message"/></xsl:with-param>
		 		<xsl:with-param name="appendClass">serverMessage</xsl:with-param>
		 </xsl:call-template>		 
		 <xsl:call-template name="reauthentication" />
	     <xsl:apply-templates select="cross_references" mode="hidden_form"/>
	     <xsl:call-template name="hidden-fields-se"/>	     
	     <xsl:call-template name="general-details" /> 	     
	     <xsl:call-template name="cheque-details"/>	  
	     <xsl:call-template name="cochq-disclaimer"/>	    
     </xsl:with-param>
    </xsl:call-template>
    
    <!-- The form that is submitted -->
    <xsl:call-template name="realform"/>

    <!-- Display common menu, this time outside the form -->
    <xsl:call-template name="menu">
	     	<xsl:with-param name="second-menu">Y</xsl:with-param>
	     	<xsl:with-param name="show-template">N</xsl:with-param>   
	     	<xsl:with-param name="show-return">Y</xsl:with-param>     
	     	<xsl:with-param name="show-save">Y</xsl:with-param> 
	</xsl:call-template>
   </div> 
   
    <script>
     dojo.ready(function(){
			<xsl:choose>
				<xsl:when test="cheque_book_request_config/min_max_missing">
					misys._config._isNoOfChqBookConfigMissing = true;
				</xsl:when>
				<xsl:otherwise>
					misys._config._isNoOfChqBookConfigMissing = false;
					<xsl:if test="cheque_book_request_config/min_request">
						misys._config._noOfChqBooksMin = <xsl:value-of select="cheque_book_request_config/min_request" />;
						misys._config._noOfChqBooksMax = <xsl:value-of select="cheque_book_request_config/max_request" />;
					</xsl:if>
				</xsl:otherwise>	
			</xsl:choose>
					misys._config = (misys._config) || {};
   					misys._config.isMultiBank = <xsl:choose>
							 						<xsl:when test="$isMultiBank='Y'">true</xsl:when>
							 						<xsl:otherwise>false</xsl:otherwise>
							 					</xsl:choose>;
			<xsl:if test="$isMultiBank='Y'">
				dojo.mixin(misys._config, {entityBanksMap :
				<xsl:value-of select="utils:getEntityBanksJSONforScript($rundata,entities)"/>
			});
			</xsl:if>
			
			dojo.mixin(misys._config,{
				perBankChequeMin: {
				   			<xsl:if test="count(/se_tnx_record/cheque_book_request_config/per_bank_cheques_min_max/per_bank/bank) > 0" >
				        		<xsl:for-each select="/se_tnx_record/cheque_book_request_config/per_bank_cheques_min_max/per_bank/bank" >
				        			<xsl:variable name="bank" select="self::node()/text()" />
				  						<xsl:value-of select="."/>: [
				   						<xsl:for-each select="/se_tnx_record/cheque_book_request_config/per_bank_cheques_min_max/per_bank[bank=$bank]/min_request" >
				   							<xsl:value-of select="."/>,
				   						</xsl:for-each>
				   						]<xsl:if test="not(position()=last())">,</xsl:if>
				         		</xsl:for-each>
				       		</xsl:if>
						}
			});
			dojo.mixin(misys._config,{
				perBankChequeMax: {
				   			<xsl:if test="count(/se_tnx_record/cheque_book_request_config/per_bank_cheques_min_max/per_bank/bank) > 0" >
				        		<xsl:for-each select="/se_tnx_record/cheque_book_request_config/per_bank_cheques_min_max/per_bank/bank" >
				        			<xsl:variable name="bank" select="self::node()/text()" />
				  						<xsl:value-of select="."/>: [
				   						<xsl:for-each select="/se_tnx_record/cheque_book_request_config/per_bank_cheques_min_max/per_bank[bank=$bank]/max_request" >
				   							<xsl:value-of select="."/>,
				   						</xsl:for-each>
				   						]<xsl:if test="not(position()=last())">,</xsl:if>
				         		</xsl:for-each>
				       		</xsl:if>
						}
			});
			dojo.mixin(misys._config,{
				perBankChequeNumberRange: {
				   			<xsl:if test="count(/se_tnx_record/cheque_number_range_per_bank/per_bank/bank) > 0" >
				        		<xsl:for-each select="/se_tnx_record/cheque_number_range_per_bank/per_bank/bank" >
				        			<xsl:variable name="bank" select="self::node()/text()" />
				  						<xsl:value-of select="."/>: [
				   						<xsl:for-each select="/se_tnx_record/cheque_number_range_per_bank/per_bank[bank=$bank]/range" >
				   							<xsl:value-of select="."/>,
				   						</xsl:for-each>
				   						]<xsl:if test="not(position()=last())">,</xsl:if>
				         		</xsl:for-each>
				       		</xsl:if>
						}
			});
			dojo.mixin(misys._config,{
				perBankDeliveryModes: {
				   			<xsl:if test="count(/se_tnx_record/delivery_mode_options/delivery_mode_per_bank/bank_name) > 0" >
				        		<xsl:for-each select="/se_tnx_record/delivery_mode_options/delivery_mode_per_bank/bank_name" >
				        			<xsl:variable name="bank_name" select="self::node()/text()" />
				  						<xsl:value-of select="."/>: [
				   						<xsl:for-each select="/se_tnx_record/delivery_mode_options/delivery_mode_per_bank[bank_name=$bank_name]/delivery_mode_option" >
				   							<xsl:variable name="delivery_mode_value"><xsl:value-of select="."/></xsl:variable>
				   							{ value:"<xsl:value-of select="localization:getDecode($language, 'N018', $delivery_mode_value)"/>",
						         				name:"<xsl:value-of select="localization:getDecode($language, 'N018', $delivery_mode_value)"/>"},
				   							<!-- <xsl:value-of select="localization:getDecode($language, 'N018', $delivery_mode_value)"/>, -->
				   						</xsl:for-each>
				   						]<xsl:if test="not(position()=last())">,</xsl:if>
				         		</xsl:for-each>
				       		</xsl:if>
						}
			});
   		});
   </script>

   <!-- Javascript and Dojo imports  -->
   <xsl:call-template name="js-imports"/>
  </xsl:template>
  
  <!--General Details Fieldset.-->
  <xsl:template name="general-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
      <xsl:call-template name="se-general-details"/>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="se-general-details">
  
  <xsl:if test="$isMultiBank!='Y'">
	  <xsl:call-template name="input-field">
	     	<xsl:with-param name="label">BANK_LABEL</xsl:with-param>	
			<xsl:with-param name="fieldsize">small</xsl:with-param>
	  			<xsl:with-param name="id">issuing_bank_name_view</xsl:with-param>
	  			<xsl:with-param name="value" select="issuing_bank/name" />
	  			<xsl:with-param name="override-displaymode">view</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	
   <!-- Hidden fields. -->
   <div>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">ref_id</xsl:with-param>
    </xsl:call-template>
    <!-- Don't display this in unsigned mode. -->
    <xsl:if test="$displaymode='edit'">
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">appl_date</xsl:with-param>
     </xsl:call-template>
    </xsl:if>
   </div>
   
   <!--  System ID. -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
    <xsl:with-param name="id">ref_id_view</xsl:with-param>
    <xsl:with-param name="value" select="ref_id" />
    <xsl:with-param name="override-displaymode">view</xsl:with-param>
   </xsl:call-template>
   
    <xsl:if test="$displaymode='view' and cust_ref_id[.!=' ']">
   <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>
     <xsl:with-param name="name">cust_ref_id</xsl:with-param>
     <xsl:with-param name="value" select="cust_ref_id"/>
   </xsl:call-template>
   </xsl:if>   
   
   <!--  Application date. -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
    <xsl:with-param name="id">appl_date_view</xsl:with-param>
    <xsl:with-param name="value" select="appl_date" />
    <xsl:with-param name="override-displaymode">view</xsl:with-param>
   </xsl:call-template>

	
   <xsl:if test="$displaymode='view' and bo_ref_id[.!=' ']">
   <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_SE_BANK_REF</xsl:with-param>
     <xsl:with-param name="name">bo_ref_id</xsl:with-param>
     <xsl:with-param name="value" select="bo_ref_id"/>
   </xsl:call-template>
   </xsl:if>
  
   </xsl:template>
  

  
  <xsl:template name="cheque-details">
  		<xsl:call-template name="fieldset-wrapper">
    		<xsl:with-param name="legend">XSL_HEADER_CHEQUE_DETAILS</xsl:with-param>
    		<xsl:with-param name="content">
    			<div>    			
				  	<xsl:call-template name="entity-field">
					    <xsl:with-param name="required">Y</xsl:with-param>
					    <xsl:with-param name="button-type">entity</xsl:with-param>
					    <xsl:with-param name="prefix">applicant</xsl:with-param>
				    </xsl:call-template>	
				    <xsl:if test="$isMultiBank='Y'">
						  <xsl:call-template name="select-field">
								<xsl:with-param name="label">BANK_NAME</xsl:with-param>
								<xsl:with-param name="name">customer_bank</xsl:with-param>
								<xsl:with-param name="required">Y</xsl:with-param>
								<xsl:with-param name="options">
									<xsl:value-of select="issuing_bank/name"/>									
								</xsl:with-param>
								<xsl:with-param name="value" select="issuing_bank/name" />
							</xsl:call-template>
					</xsl:if>
				    			   
			    	<xsl:call-template name="user-account-field">
				     	<xsl:with-param name="label">XSL_SE_ACT_NO_LABEL</xsl:with-param>			
					    <xsl:with-param name="name">applicant</xsl:with-param>
					    <xsl:with-param name="entity-field">entity</xsl:with-param>
					    <xsl:with-param name="dr-cr">debit</xsl:with-param>
					    <xsl:with-param name="show-product-types">N</xsl:with-param>
					   <xsl:with-param name="product_types">SE:<xsl:value-of select="sub_product_code"/></xsl:with-param> 
					   <xsl:with-param name="required">Y</xsl:with-param>				
					   <xsl:with-param name="value"><xsl:value-of select="applicant_act_name"/></xsl:with-param>	   
			    	</xsl:call-template>	
			    	<xsl:call-template name="nickname-field-template"/>
			    	<xsl:choose>
			    	<xsl:when test="sub_product_code[.='COCQS']">
			    	<xsl:choose>
			    		<xsl:when test="$displaymode='edit'">
				    		<xsl:call-template name="select-field">
						      	<xsl:with-param name="label">XSL_CHEQUEDETAILS_CHEQUE_TYPE</xsl:with-param>
						      	<xsl:with-param name="name">cheque_type</xsl:with-param>
						      	<xsl:with-param name="required">Y</xsl:with-param>
						      	<xsl:with-param name="fieldsize">x-medium</xsl:with-param>
						      	<xsl:with-param name="value"><xsl:value-of select="cheque_type"/></xsl:with-param>
						      	<xsl:with-param name="options"><xsl:call-template name="cheque_type_options"/></xsl:with-param>
							</xsl:call-template>
			    		</xsl:when>
				    		<xsl:otherwise>
					    		<xsl:call-template name="input-field">
							      	<xsl:with-param name="label">XSL_CHEQUEDETAILS_CHEQUE_TYPE</xsl:with-param>
							      	<xsl:with-param name="name">cheque_type</xsl:with-param>
							      	<xsl:with-param name="fieldsize">x-medium</xsl:with-param>
							      	<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N115', cheque_type)"/></xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="hidden-field">
								<xsl:with-param name="name">cheque_type</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select="cheque_type"/></xsl:with-param>
						</xsl:call-template>	
			    		</xsl:otherwise>
			    	</xsl:choose>
			    	<div class="field">
							<label id="labelId">
						<xsl:variable name="cheque_type_var"><xsl:value-of select="cheque_type"/></xsl:variable>
							<xsl:if test="$rundata!='' ">
							 <xsl:if test="$cheque_type_var='01'">
							 		<xsl:call-template name="localization-dblclick">
							
									<xsl:with-param name="xslName">XSL_GENERALDETAILS_CASHIER_ORDER</xsl:with-param>
									<xsl:with-param name="localName" select="localization:getGTPString($rundata, $language, 'XSL_GENERALDETAILS_CASHIER_ORDER')" />
									</xsl:call-template>
							
						</xsl:if>
						<xsl:if test="$cheque_type_var='02'">
						<xsl:call-template name="localization-dblclick">
						<xsl:with-param name="xslName">XSL_GENERALDETAILS_CHEQUE_NUMBER</xsl:with-param>
					    <xsl:with-param name="localName" select="localization:getGTPString($rundata, $language, 'XSL_GENERALDETAILS_CHEQUE_NUMBER')" />
						</xsl:call-template>
						</xsl:if>
							</xsl:if>
							
							
								<xsl:if test="$cheque_type_var='01'">
								
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CASHIER_ORDER')"/>
								</xsl:if>
								<xsl:if test="$cheque_type_var='02'">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CHEQUE_NUMBER')"/>
								
								</xsl:if>
							</label>
							<div class="inlineBlock chequeServicesChequeNumber">
								<xsl:call-template name="input-field">
						      		<xsl:with-param name="label">XSL_GENERALDETAILS_CHEQUE_NUMBER_FROM</xsl:with-param>
						      		<xsl:with-param name="name">cheque_number_from</xsl:with-param>
						      		<xsl:with-param name="size"><xsl:value-of select="defaultresource:getResource('CHEQUE_NUMBER_LENGTH')"/></xsl:with-param>
						      		<xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getChequeNumberLength()"/></xsl:with-param>
						      		<xsl:with-param name="fieldsize">small</xsl:with-param>
						      		<xsl:with-param name="required">Y</xsl:with-param>
						      		<xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
									<xsl:with-param name="regular-expression">[0-9]{1,<xsl:value-of select="defaultresource:getResource('CHEQUE_NUMBER_LENGTH')"/>}</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="input-field">
						      		<xsl:with-param name="label">XSL_GENERALDETAILS_CHEQUE_NUMBER_TO</xsl:with-param>
						      		<xsl:with-param name="name">cheque_number_to</xsl:with-param>
						      		<xsl:with-param name="size"><xsl:value-of select="defaultresource:getResource('CHEQUE_NUMBER_LENGTH')"/></xsl:with-param>
						      		<xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getChequeNumberLength()"/></xsl:with-param>
						      		<xsl:with-param name="fieldsize">small</xsl:with-param>
						      		<xsl:with-param name="required">Y</xsl:with-param>
						      		<xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
						      		<xsl:with-param name="regular-expression">[0-9]{1,<xsl:value-of select="defaultresource:getResource('CHEQUE_NUMBER_LENGTH')"/>}</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="hidden-field">
							     	<xsl:with-param name="name">cheque_number_range</xsl:with-param>
							    </xsl:call-template>
							</div>
						</div>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="input-field">
			      		<xsl:with-param name="label">XSL_GENERALDETAILS_NUMBER_OF_CHEQUE_BOOKS</xsl:with-param>
			      		<xsl:with-param name="name">no_of_cheque_books</xsl:with-param>
			      		<xsl:with-param name="size">2</xsl:with-param>
			      		<xsl:with-param name="maxsize">2</xsl:with-param>
			      		<xsl:with-param name="fieldsize">x-small</xsl:with-param>
			      		<xsl:with-param name="type">number</xsl:with-param>
			      		<xsl:with-param name="required">Y</xsl:with-param>
						</xsl:call-template>
						<xsl:choose>
						<xsl:when test="$displaymode='edit'">
							<xsl:call-template name="select-field">
					      	<xsl:with-param name="label">XSL_GENERALDETAILS_DELIVERY_MODE</xsl:with-param>
					      	<xsl:with-param name="name">adv_send_mode</xsl:with-param>
					      	<xsl:with-param name="required">Y</xsl:with-param>
					      	<xsl:with-param name="fieldsize">x-medium</xsl:with-param>
					      	<xsl:with-param name="options"><xsl:call-template name="delivery_mode_options"/></xsl:with-param>
					    	<xsl:with-param name="value" select="adv_send_mode"/>
					      	</xsl:call-template>	
					      	<div id="delivery_mode_08_div">
							<xsl:call-template name="input-field">
						      	 <xsl:with-param name="label">XSL_BRANCH_CODE</xsl:with-param>
							     <xsl:with-param name="name">collecting_bank_code</xsl:with-param>
							     <xsl:with-param name="maxsize">4</xsl:with-param>	
							     <xsl:with-param name="fieldsize">xx-small</xsl:with-param>
			                     <xsl:with-param name="appendClass">inlineBlock</xsl:with-param>	                     	
			                     <xsl:with-param name="readOnly">Y</xsl:with-param>	     			  
							 </xsl:call-template>	
							 <xsl:call-template name="input-field">
							     <xsl:with-param name="name">collecting_branch_code</xsl:with-param>	
						   		 <xsl:with-param name="maxsize">3</xsl:with-param>	
						   		 <xsl:with-param name="fieldsize">xx-small</xsl:with-param>
			                     <xsl:with-param name="appendClass">inlineBlock inlineBlockNoLabel NoAsterik</xsl:with-param>
			                     <xsl:with-param name="readOnly">Y</xsl:with-param>
			                 </xsl:call-template>
			                 <xsl:if test="$displaymode='edit'">		    
								<xsl:call-template name="button-wrapper">
									<xsl:with-param name="show-image">Y</xsl:with-param>
									<xsl:with-param name="show-border">N</xsl:with-param>
									<xsl:with-param name="onclick">misys.showBankBranchCodeDialog('bank_branch_code', "['collecting_bank_code', 'collecting_branch_code']", '', '02,03', 'Y', '', 'width:710px;height:350px;', '<xsl:value-of select="localization:getGTPString($language, 'LIST_TITLE_SDATA_COLLECTING')"/>',false);return false;</xsl:with-param>
									<xsl:with-param name="id">bank_img</xsl:with-param>
									<xsl:with-param name="non-dijit-button">N</xsl:with-param>
								</xsl:call-template>
							</xsl:if>	   				    		
							<xsl:call-template name="input-field">
				 				 <xsl:with-param name="label">XSL_GENERALDETAILS_COLLECTORS_NAME</xsl:with-param>
							     <xsl:with-param name="name">collectors_name</xsl:with-param>
							     <xsl:with-param name="maxsize">35</xsl:with-param>	
							     <xsl:with-param name="size">35</xsl:with-param>							     		    
						    </xsl:call-template> 
						    <xsl:call-template name="input-field">
				 				 <xsl:with-param name="label">XSL_GENERALDETAILS_COLLECTORS_ID</xsl:with-param>
							     <xsl:with-param name="name">collectors_id</xsl:with-param>
							     <xsl:with-param name="maxsize">20</xsl:with-param>	
							     <xsl:with-param name="size">20</xsl:with-param>					     					     
						    </xsl:call-template>
						</div>	
						<xsl:call-template name="hidden-field">
								<xsl:with-param name="name">adv_send_mode_hidden</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select="adv_send_mode"/></xsl:with-param>
						</xsl:call-template>				    
			        	</xsl:when>
				    	<xsl:otherwise>
				    	<xsl:call-template name="input-field">
			      		<xsl:with-param name="label">XSL_GENERALDETAILS_DELIVERY_MODE</xsl:with-param>
			      		<xsl:with-param name="name">adv_send_mode</xsl:with-param>
			      		<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N018', adv_send_mode)"/> </xsl:with-param>			      		
			      		</xsl:call-template>
			      		<div id="delivery_mode_08_div">
							<xsl:call-template name="input-field">
						      	 <xsl:with-param name="label">XSL_BRANCH_CODE</xsl:with-param>
							     <xsl:with-param name="name">collecting_bank_code</xsl:with-param>
							     <xsl:with-param name="maxsize">4</xsl:with-param>	
							     <xsl:with-param name="fieldsize">xx-small</xsl:with-param>
			                     <xsl:with-param name="appendClass">inlineBlock</xsl:with-param>	                     	
			                     <xsl:with-param name="readOnly">Y</xsl:with-param>	     			  
							 </xsl:call-template>	
							 <xsl:call-template name="input-field">
							     <xsl:with-param name="name">collecting_branch_code</xsl:with-param>	
						   		 <xsl:with-param name="maxsize">3</xsl:with-param>	
						   		 <xsl:with-param name="fieldsize">xx-small</xsl:with-param>
			                     <xsl:with-param name="appendClass">inlineBlock inlineBlockNoLabel</xsl:with-param>
			                     <xsl:with-param name="readOnly">Y</xsl:with-param>
			                 </xsl:call-template>
			                 <xsl:if test="$displaymode='edit'">		    
								<xsl:call-template name="button-wrapper">
									<xsl:with-param name="show-image">Y</xsl:with-param>
									<xsl:with-param name="show-border">N</xsl:with-param>
									<xsl:with-param name="onclick">misys.showBankBranchCodeDialog('bank_branch_code', "['collecting_bank_code', 'collecting_branch_code']", '', '02,03', 'Y', '', 'width:710px;height:350px;', '<xsl:value-of select="localization:getGTPString($language, 'LIST_TITLE_SDATA_COLLECTING')"/>',false);return false;</xsl:with-param>
									<xsl:with-param name="id">bank_img</xsl:with-param>
									<xsl:with-param name="non-dijit-button">N</xsl:with-param>
								</xsl:call-template>
							</xsl:if>	   				    		
							<xsl:call-template name="input-field">
				 				 <xsl:with-param name="label">XSL_GENERALDETAILS_COLLECTORS_NAME</xsl:with-param>
							     <xsl:with-param name="name">collectors_name</xsl:with-param>
							     <xsl:with-param name="maxsize">35</xsl:with-param>	
							     <xsl:with-param name="size">35</xsl:with-param>							     		    
						    </xsl:call-template> 
						    <xsl:call-template name="input-field">
				 				 <xsl:with-param name="label">XSL_GENERALDETAILS_COLLECTORS_ID</xsl:with-param>
							     <xsl:with-param name="name">collectors_id</xsl:with-param>
							     <xsl:with-param name="maxsize">20</xsl:with-param>	
							     <xsl:with-param name="size">20</xsl:with-param>					     					     
						    </xsl:call-template>
						</div>
				    	</xsl:otherwise>
				    	</xsl:choose>
					</xsl:otherwise>
					</xsl:choose>	   
			   </div>
			    <!-- comments for return -->
     			<xsl:call-template name="comments-for-return">
	  				<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
	   				<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
   	 			</xsl:call-template>
			   </xsl:with-param>
   		</xsl:call-template>
  </xsl:template>
  
   <xsl:template name="cochq-disclaimer">
    <xsl:if test="$displaymode='edit'">
	  <xsl:if test="sub_product_code[.='COCQS']"> 
		  <div id="COCHQS_DISCLAIMER" class="cochqDisclaimer">
			<xsl:call-template name="simple-disclaimer">
				<xsl:with-param name="label">XSL_COCHQS_DISCLAIMER</xsl:with-param>
			</xsl:call-template>
		  </div>
	  </xsl:if>		
	</xsl:if>
	  <xsl:if test="sub_product_code[.='CQBKR']"> 
		  <div id="CQBKR_DISCLAIMER" class="cochqDisclaimer">
			<xsl:call-template name="simple-disclaimer">
				<xsl:with-param name="label">XSL_CQBKR_DISCLAIMER</xsl:with-param>
			</xsl:call-template>
		  </div>
	  </xsl:if>	  
  </xsl:template>  
  
  <xsl:template name="cheque_type_options">
	  	<xsl:for-each select="cheque_types/cheque_type">
	     	<xsl:variable name="cheque_type_value"><xsl:value-of select="."/></xsl:variable>
	     	<option>
	     		<xsl:attribute name="value"><xsl:value-of select="$cheque_type_value"/></xsl:attribute>     		
	     	    <xsl:value-of select="localization:getDecode($language, 'N115', $cheque_type_value)"/> 
	     	</option>
	    </xsl:for-each>
  </xsl:template>  
  
  <xsl:template name="delivery_mode_options">
	  	<xsl:for-each select="delivery_mode_options/delivery_mode_option">
	     	<xsl:variable name="delivery_mode_value"><xsl:value-of select="."/></xsl:variable>
	     	<option>
	     		<xsl:attribute name="value"><xsl:value-of select="$delivery_mode_value"/></xsl:attribute>     		
	     	    <xsl:value-of select="localization:getDecode($language, 'N018', $delivery_mode_value)"/> 
	     	</option>
	    </xsl:for-each>
  </xsl:template>
  
  	<!-- for disclaimers -->
	<xsl:template name="simple-disclaimer">
		<xsl:param name="label"/>
		<div><xsl:value-of select="localization:getGTPString($language, $label)" disable-output-escaping="yes" /></div>
	</xsl:template>    
  
  <!--
   SE Realform.
   -->
  <xsl:template name="realform">
   <xsl:call-template name="form-wrapper">
    <xsl:with-param name="name">realform</xsl:with-param>
    <xsl:with-param name="method">POST</xsl:with-param>
    <xsl:with-param name="action" select="$realform-action"/>
    <xsl:with-param name="content">
     <div class="widgetContainer">
      <xsl:call-template name="localization-dialog"/>
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
       <xsl:with-param name="name">option</xsl:with-param>
       <xsl:with-param name="value">CS</xsl:with-param>
      </xsl:call-template> 
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">tnxtype</xsl:with-param>
       <xsl:with-param name="value">01</xsl:with-param>
      </xsl:call-template>
      <xsl:value-of select="tnxtype"/>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">attIds</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
    <!--   <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">issuing_bank_name</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template> -->
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
	    <xsl:with-param name="name">productcode</xsl:with-param>
	    <xsl:with-param name="value" select="$product-code"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
    	<xsl:with-param name="name">subproductcode</xsl:with-param>
    	<xsl:with-param name="value"><xsl:value-of select="sub_product_code"/></xsl:with-param>
   	  </xsl:call-template>
      <xsl:call-template name="e2ee_transaction"/>
      <xsl:call-template name="reauth_params"/>
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  
</xsl:stylesheet>
