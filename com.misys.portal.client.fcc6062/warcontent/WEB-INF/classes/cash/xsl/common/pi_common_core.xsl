<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates that are common to FT forms on the customer side. This
stylesheet should be the first thing imported by customer-side
XSLTs.

This should be the first include for forms on the customer side.

Copyright (c) 2000-2011 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      10/05/11
author:    Sangeetha
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
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		exclude-result-prefixes="localization securitycheck utils security defaultresource">

<xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
<xsl:param name="clearImage"><xsl:value-of select="$images_path"/>pic_clear.gif</xsl:param>		


	
	<xsl:template name="pi-transfer-to-details">
		<xsl:param name="beneficiary-header-label">XSL_HEADER_BENEFICIARY_DETAILS</xsl:param> 
		<xsl:param name="isBankReporting"/>    		
   	    <xsl:variable name="pre-approved_beneficiary_only" select="not(securitycheck:hasPermission(utils:getUserACL($rundata),'ft_regular_beneficiary_access',utils:getUserEntities($rundata))) or (defaultresource:getResource('NON_PAB_ALLOWED') = 'false')"/>   	    
   		<xsl:call-template name="fieldset-wrapper">
	     	<xsl:with-param name="legend" select="$beneficiary-header-label"/>
	     	<xsl:with-param name="button-type"></xsl:with-param>	
	     	<xsl:with-param name="content">
		       <xsl:call-template name="column-container">
				 <xsl:with-param name="content">			 
				  <xsl:call-template name="column-wrapper">
				   <xsl:with-param name="content">	
			      		<xsl:call-template name="input-field">
						  <xsl:with-param name="label">XSL_BENEFICIARYDETAILS_NAME_PI</xsl:with-param>
						  <xsl:with-param name="name">beneficiary_name</xsl:with-param>	
						 <!--  <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_VALIDATION_REGEX')"/></xsl:with-param> -->							  
						  <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_name"/></xsl:with-param>
						  <xsl:with-param name="maxsize">35</xsl:with-param>
						  <xsl:with-param name="required">Y</xsl:with-param>
						  <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>
						  <xsl:with-param name="content-after">
							<xsl:if test="$displaymode='edit'">
								<xsl:call-template name="button-wrapper">
								  <xsl:with-param name="label">XSL_ALT_BENEFICIARY</xsl:with-param>
								  <xsl:with-param name="show-image">
								  	<xsl:choose>
								  		<xsl:when test="$isBankReporting = 'Y'">N</xsl:when>
								  		<xsl:otherwise>Y</xsl:otherwise>
								  	</xsl:choose>
								  </xsl:with-param>
								  <xsl:with-param name="show-border">N</xsl:with-param>
								  <xsl:with-param name="id">beneficiary_img</xsl:with-param>								  
								</xsl:call-template>
							
							 <xsl:if test="not($pre-approved_beneficiary_only)">
						     <xsl:call-template name="button-wrapper">
						      <xsl:with-param name="id">clear_img</xsl:with-param>
						      <xsl:with-param name="label">XSL_ALT_CLEAR</xsl:with-param>
						      <xsl:with-param name="show-image">
								  	<xsl:choose>
								  		<xsl:when test="$isBankReporting = 'Y'">N</xsl:when>
								  		<xsl:otherwise>Y</xsl:otherwise>
								  	</xsl:choose>
								  </xsl:with-param>
						      <xsl:with-param name="show-border">N</xsl:with-param>
						      <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($clearImage)"/></xsl:with-param>
						      <xsl:with-param name="img-height">16</xsl:with-param>
						      <xsl:with-param name="img-width">13</xsl:with-param>
						     </xsl:call-template>	
						     </xsl:if>
						    </xsl:if>				   
						  </xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="beneficiary-nickname-field-template"/>						
						<xsl:call-template name="input-field">
						  <xsl:with-param name="name">beneficiary_name_2</xsl:with-param>								  						  
						  <xsl:with-param name="maxsize">35</xsl:with-param>
						 <!--  <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_VALIDATION_REGEX')"/></xsl:with-param> -->
						  <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>
						</xsl:call-template>
						<xsl:if test="sub_product_code[.='PICO'] or bk_sub_product_code[.='MPPID' or .='UPPID']">
						<xsl:call-template name="input-field">
						  <xsl:with-param name="name">beneficiary_name_3</xsl:with-param>	
						  <!-- <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_VALIDATION_REGEX')"/></xsl:with-param> -->							  						  
						  <xsl:with-param name="maxsize">35</xsl:with-param>
						  <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>
						</xsl:call-template>
						</xsl:if>
						<xsl:call-template name="input-field">
							    <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
							    <xsl:with-param name="name">beneficiary_address</xsl:with-param>
							    <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_address_line_1"/></xsl:with-param>
							    <xsl:with-param name="maxsize">35</xsl:with-param>
							    <xsl:with-param name="required">Y</xsl:with-param>
							    <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>
						</xsl:call-template>
					    <xsl:call-template name="input-field">
							     <xsl:with-param name="name">beneficiary_city</xsl:with-param>
							     <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_address_line_2"/></xsl:with-param>
							     <xsl:with-param name="maxsize">35</xsl:with-param>
							     <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>
						</xsl:call-template>
					    <xsl:call-template name="input-field">
							     <xsl:with-param name="name">beneficiary_address_line_4</xsl:with-param>
							     <xsl:with-param name="maxsize">35</xsl:with-param>					
							     <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>
					    </xsl:call-template> 
						<xsl:call-template name="input-field">
							     <xsl:with-param name="name">beneficiary_dom</xsl:with-param>
							     <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_dom"/></xsl:with-param>
							     <xsl:with-param name="maxsize">35</xsl:with-param>
							     <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>
					    </xsl:call-template> 
					    <xsl:if test="$displaymode ='edit'">
					    <div id="postal_code_div">
					    	<xsl:call-template name="input-field">
				      			<xsl:with-param name="label">XSL_BENEFICIARY_POSTAL_CODE</xsl:with-param>
				      			<xsl:with-param name="name">beneficiary_postal_code</xsl:with-param>
				      			<xsl:with-param name="size">15</xsl:with-param>
				       			<xsl:with-param name="maxsize">15</xsl:with-param>
				       			<xsl:with-param name="fieldsize">small</xsl:with-param>
				       			<xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
				       			<xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>
			    			</xsl:call-template>			    			
				    		<xsl:call-template name="country-field">
				    			<xsl:with-param name="label">XSL_BENEFICIARY_COUNTRY</xsl:with-param>
				      			<xsl:with-param name="prefix">beneficiary</xsl:with-param>	
			    				<xsl:with-param name="name">beneficiary_country</xsl:with-param>
				      			<xsl:with-param name="appendClass">inlineBlock beneAdvCountry</xsl:with-param>				      			
				      			<xsl:with-param name="override-displaymode">
				      			<xsl:choose>
							  		<xsl:when test="$isBankReporting = 'Y'">view</xsl:when>
							  		<xsl:otherwise><xsl:value-of select="$displaymode"></xsl:value-of></xsl:otherwise>
								</xsl:choose>
				      			</xsl:with-param>
				      			<xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>
				      			<xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_country"/></xsl:with-param>
				    		</xsl:call-template>
				    	</div>					
						</xsl:if>
						<xsl:if test="$displaymode ='view'">
					    <div id="postal_code_div">
				    		<xsl:call-template name="input-field">
				      			<xsl:with-param name="label">XSL_BENEFICIARY_POSTAL_CODE</xsl:with-param>
				      			<xsl:with-param name="name">beneficiary_postal_code</xsl:with-param>				      			
				       			<xsl:with-param name="readonly">Y</xsl:with-param>
			    			</xsl:call-template>
				    		<xsl:call-template name="country-field">
				    			<xsl:with-param name="label">XSL_BENEFICIARY_COUNTRY</xsl:with-param>
				      			<xsl:with-param name="prefix">beneficiary</xsl:with-param>	
			    				<xsl:with-param name="name">beneficiary_country</xsl:with-param>				      		
				      			<xsl:with-param name="readonly">Y</xsl:with-param>
				      			<xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_country"/></xsl:with-param>
				    		</xsl:call-template>
				    	</div>					
						</xsl:if>
	                    <div id="pre_approved_benificiary" class="content">
						   	 <xsl:attribute name="style">
						   	 <xsl:choose>
						   	 	<xsl:when test="pre_approved_status[.='Y']">display:block;</xsl:when>
						   	 	<xsl:otherwise>display:none;</xsl:otherwise>
						   	 </xsl:choose>
						   	 </xsl:attribute>
							<xsl:value-of select="localization:getGTPString($language,'XSL_REMITTANCE_PAB')"/>
						</div>
				</xsl:with-param>
		      	</xsl:call-template>
		      	</xsl:with-param>
	    	</xsl:call-template>
	    	</xsl:with-param>
		</xsl:call-template>
	
		<script>
		   dojo.ready(function(){
			        	misys._config = misys._config || {};
						misys._config.non_pab_allowed = <xsl:value-of select="defaultresource:getResource('NON_PAB_ALLOWED') = 'true' and securitycheck:hasPermission(utils:getUserACL($rundata),'ft_regular_beneficiary_access',utils:getUserEntities($rundata))"/>;	
					});
		</script>
	</xsl:template>
    
    <xsl:template name="pi-transaction-details">	
    <xsl:param name="isBankReporting"/> 	
	<xsl:call-template name="fieldset-wrapper">
	   <xsl:with-param name="legend">XSL_HEADER_TRANSACTION_DETAILS</xsl:with-param>
	     <xsl:with-param name="content">
		  <xsl:call-template name="column-container">
	 	   <xsl:with-param name="content">
	 	    <xsl:call-template name="column-wrapper">
	    	 <xsl:with-param name="content">
	    	 <xsl:choose>
	    	   <xsl:when test="bulk_ref_id[.='']">
			    <!--  Transaction Amount Field -->
	     		<xsl:if test="not(amount_access) or  (amount_access[.='true'])  ">
				    <xsl:call-template name="currency-field">
				      	<xsl:with-param name="label">XSL_AMOUNTDETAILS_REMITTANCE_AMT_LABEL</xsl:with-param>
					   	<xsl:with-param name="product-code">ft</xsl:with-param>
					   	<xsl:with-param name="required">Y</xsl:with-param>				   					   	
					   	<xsl:with-param name="currency-readonly">
					   	<xsl:choose>
					   		<xsl:when test="$isBankReporting = 'Y'">Y</xsl:when>
					   		<xsl:when test="sub_product_code[.='PICO']">Y</xsl:when>
					   		<xsl:otherwise>N</xsl:otherwise>
					   	</xsl:choose>				   		
					   	</xsl:with-param>
					   	<xsl:with-param name="amt-readonly" select="$isBankReporting"/>
					   	<xsl:with-param name="show-button">
					   	<xsl:choose>
					   		<xsl:when test="sub_product_code[.='PICO'] or (sub_product_code[.='PIDD'] and $isBankReporting = 'Y')">N</xsl:when>
					   		<xsl:otherwise>Y</xsl:otherwise>
					   	</xsl:choose>
					   	</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			  </xsl:when>
			  <xsl:otherwise>
			  	 <xsl:if test="not(amount_access) or  (amount_access[.='true'])  ">
				    <xsl:call-template name="currency-field">
				      	<xsl:with-param name="label">XSL_AMOUNTDETAILS_REMITTANCE_AMT_LABEL</xsl:with-param>
					   	<xsl:with-param name="product-code">ft</xsl:with-param>
					   	<xsl:with-param name="required">Y</xsl:with-param>				   					   	
					   	<xsl:with-param name="currency-readonly">Y</xsl:with-param>
					   	<xsl:with-param name="show-button">N</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			  </xsl:otherwise>
			   </xsl:choose>	
		    	 <xsl:if test="sub_product_code[.='PIDD'] and bulk_ref_id[.='']">
		    	<!--<xsl:call-template name="input-field">
		    	--><xsl:call-template name="country-field">
			    	<xsl:with-param name="label">XSL_GENERALDETAILS_DRAWN_ON_COUNTRY</xsl:with-param>
			    	<xsl:with-param name="prefix">drawn_on</xsl:with-param>	
			    	<xsl:with-param name="name">drawn_on_country</xsl:with-param>	
			    	<xsl:with-param name="appendClass">inlineBlock beneAdvCountry</xsl:with-param>	
			   		<xsl:with-param name="required">Y</xsl:with-param>		   
			   		<xsl:with-param name="readonly">N</xsl:with-param>
			    	<xsl:with-param name="codevalue-product-code">FT</xsl:with-param>
				    <xsl:with-param name="codevalue-sub-product-code">PIDD</xsl:with-param>
				  	<xsl:with-param name="show-search-icon">
				  	<xsl:choose>
					   		<xsl:when test="$isBankReporting = 'Y'">N</xsl:when>
					   		<xsl:otherwise>Y</xsl:otherwise>
					</xsl:choose>
				  	</xsl:with-param>
   				</xsl:call-template>
   				</xsl:if>		   			
		    	<xsl:call-template name="input-field">
	     			<xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>	
		    		<xsl:with-param name="name">cust_ref_id</xsl:with-param>
	   				<xsl:with-param name="size">16</xsl:with-param>
	   				<xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_CASH_LENGTH')"/></xsl:with-param>
	   				<xsl:with-param name="regular-expression">
	   						<xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_CASH_VALIDATION_REGEX')"/>
	   				</xsl:with-param>
	   				<xsl:with-param name="fieldsize">small</xsl:with-param>
	   				<xsl:with-param name="readonly" select="$isBankReporting"/>
	   			</xsl:call-template>		
	   			<xsl:if test="not(amount_access) or  (amount_access[.='true'])  ">
	   			<xsl:call-template name="select-field">
			      	<xsl:with-param name="label">XSL_GENERALDETAILS_DELIVERY_MODE</xsl:with-param>
			      	<xsl:with-param name="name">adv_send_mode</xsl:with-param>
			      	<xsl:with-param name="required">Y</xsl:with-param>
			      	<xsl:with-param name="fieldsize">x-medium</xsl:with-param>
			      	<xsl:with-param name="value"><xsl:value-of select="adv_send_mode"/></xsl:with-param>
			      	<xsl:with-param name="options"><xsl:call-template name="delivery_mode_options"/></xsl:with-param>
			      	<xsl:with-param name="readonly" select="$isBankReporting"/>
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
			    					
			    <div id="delivery_mode_09_div">
			  <xsl:choose>  
			  	<xsl:when test="bulk_ref_id[.='']">
			  	 <xsl:if test="$displaymode='edit'">
					<xsl:call-template name="textarea-field">
				       	<xsl:with-param name="label">XSL_GENERALDETAILS_MAILING_NAME_ADDRESS_OTHER</xsl:with-param>	
				        <xsl:with-param name="name">mailing_other_name_address</xsl:with-param>
				        <xsl:with-param name="cols">40</xsl:with-param>			     
				        <xsl:with-param name="rows">6</xsl:with-param>
				        <xsl:with-param name="maxlines">6</xsl:with-param>							               
		    		</xsl:call-template>
		    	</xsl:if>
		    	 <xsl:if test="$displaymode='view'">
                   <xsl:call-template name="row-wrapper">
                   <xsl:with-param name="label">XSL_GENERALDETAILS_MAILING_NAME_ADDRESS_OTHER</xsl:with-param>
                   <xsl:with-param name="content">
                   <div class="content">
                   <xsl:value-of select="mailing_other_name_address"/>
                  </div>
                  </xsl:with-param>
                 </xsl:call-template>
               </xsl:if>
		    	</xsl:when>
		    	<xsl:otherwise>
		    	   <xsl:call-template name="input-field">
		 				 <xsl:with-param name="label">XSL_GENERALDETAILS_MAILING_NAME</xsl:with-param>
					     <xsl:with-param name="name">mailing_other_name_address</xsl:with-param>
					     <xsl:with-param name="maxsize">35</xsl:with-param>	
			    	</xsl:call-template> 
			    	<xsl:call-template name="input-field">
					     <xsl:with-param name="name">mailing_other_name_2</xsl:with-param>
					     <xsl:with-param name="maxsize">35</xsl:with-param>	
			    	</xsl:call-template> 
			    	<xsl:call-template name="input-field">
					     <xsl:with-param name="name">mailing_other_name_3</xsl:with-param>
					     <xsl:with-param name="maxsize">35</xsl:with-param>	
			    	</xsl:call-template> 
			    	<xsl:call-template name="input-field">
		 				 <xsl:with-param name="label">XSL_GENERALDETAILS_MAILING_ADDRESS</xsl:with-param>
					     <xsl:with-param name="name">mailing_other_address_1</xsl:with-param>
					     <xsl:with-param name="maxsize">35</xsl:with-param>	
			    	</xsl:call-template> 
			    	<xsl:call-template name="input-field">
					     <xsl:with-param name="name">mailing_other_address_2</xsl:with-param>
					     <xsl:with-param name="maxsize">35</xsl:with-param>	
			    	</xsl:call-template> 
			    	<xsl:call-template name="input-field">
					     <xsl:with-param name="name">mailing_other_address_3</xsl:with-param>
					     <xsl:with-param name="maxsize">35</xsl:with-param>	
			    	</xsl:call-template> 
		    	 </xsl:otherwise>
		     </xsl:choose> 
		   	 <xsl:if test ="$displaymode='edit'">					   	
	    		<xsl:call-template name="input-field">
	 				 <xsl:with-param name="label">XSL_BENEFICIARY_POSTAL_CODE</xsl:with-param>
				     <xsl:with-param name="name">mailing_other_postal_code</xsl:with-param>
				     <xsl:with-param name="maxsize">15</xsl:with-param>	
				     <xsl:with-param name="size">15</xsl:with-param>	
				     <xsl:with-param name="fieldsize">small</xsl:with-param>				    
				     <xsl:with-param name="appendClass">inlineBlock</xsl:with-param>				 		     		    
			    </xsl:call-template> 
	    		<xsl:call-template name="country-field">
			    	<xsl:with-param name="label">XSL_PARTIESDETAILS_CONTRY</xsl:with-param>
			    	<xsl:with-param name="prefix">mailing_other</xsl:with-param>
			    	<xsl:with-param name="name">mailing_other_country</xsl:with-param>				    				    	    						   				    	
			   		<xsl:with-param name="appendClass">inlineBlock beneAdvCountry</xsl:with-param>	
			   		<xsl:with-param name="required">Y</xsl:with-param>		   			   					   				   					   
   				</xsl:call-template>	
   			</xsl:if>
   			<xsl:if test="$displaymode ='view'">
   				 <xsl:call-template name="input-field">
				  	<xsl:with-param name="label">XSL_BENEFICIARY_POSTAL_CODE</xsl:with-param>
				  	<xsl:with-param name="name">mailing_other_postal_code</xsl:with-param>				      			
				  	<xsl:with-param name="readonly">Y</xsl:with-param>
			    </xsl:call-template>
				<xsl:call-template name="country-field">
				  <xsl:with-param name="label">XSL_PARTIESDETAILS_CONTRY</xsl:with-param>
				  <xsl:with-param name="prefix">mailing_other</xsl:with-param>	
			      <xsl:with-param name="name">mailing_other_country</xsl:with-param>				      		
				  <xsl:with-param name="readonly">Y</xsl:with-param>				      			
				 </xsl:call-template>
   				
   			</xsl:if>
			    </div>
			    <xsl:if test ="$displaymode='edit'">		    
			    <xsl:call-template name="textarea-field">	
			       	<xsl:with-param name="label">XSL_GENERALDETAILS_PAYMENT_DETAILS</xsl:with-param>	
			        <xsl:with-param name="name">narrative_additional_instructions</xsl:with-param>
			        <xsl:with-param name="cols">35</xsl:with-param>			     
			        <xsl:with-param name="rows">2</xsl:with-param>
			        <xsl:with-param name="maxlines">2</xsl:with-param>
			        <xsl:with-param name="disabled" select="$isBankReporting"/>		
			        <xsl:with-param name="button-type">
			        	<xsl:choose>
			        		<xsl:when test="$isBankReporting = 'Y'"></xsl:when>
			        		<xsl:otherwise>phrase</xsl:otherwise>
			        	</xsl:choose>
			        </xsl:with-param>		        
	    		</xsl:call-template>
	    		</xsl:if>
	    	   <xsl:if test ="$displaymode='view'">			    
			    <xsl:call-template name="row-wrapper">	
			       	<xsl:with-param name="label">XSL_GENERALDETAILS_PAYMENT_DETAILS</xsl:with-param>	
			        <xsl:with-param name="content">
                   <div class="content">
                   <xsl:value-of select="narrative_additional_instructions"/>
                  </div>
                  </xsl:with-param>				        
	    		</xsl:call-template>
	    		</xsl:if>
	    		<xsl:choose>
				    	<xsl:when test="sub_product_code[.='PICO']">
				    	<div class="field" style="margin-left:120px;"><xsl:value-of select="localization:getGTPString($language,'XSL_GENERALDETAILS_DELIVERY_MODE_PICO_DISCLAIMER')"/></div></xsl:when>
				    	<xsl:otherwise>
				    	<xsl:if test="bulk_ref_id[.='']">
				    	<div class="field" style="margin-left:120px;"><xsl:value-of select="localization:getGTPString($language,'XSL_GENERALDETAILS_DELIVERY_MODE_PIDD_DISCLAIMER')"/></div>
				    	</xsl:if>
				    	</xsl:otherwise>
				</xsl:choose>
				</xsl:if>
				<!-- beneficiary_reference and bk_particular are not applicable -->
				<!--<xsl:if test="bulk_ref_id[.!='']">
				<xsl:call-template name="input-field">
	    			<xsl:with-param name="label">XSL_GENERALDETAILS_BEN_REF</xsl:with-param>	
	    			<xsl:with-param name="name">beneficiary_reference</xsl:with-param>
	  				<xsl:with-param name="size">19</xsl:with-param>
	  				<xsl:with-param name="maxsize">19</xsl:with-param>
	  				<xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_reference"/></xsl:with-param>
	  				<xsl:with-param name="fieldsize">small</xsl:with-param>
		  		</xsl:call-template>
		  		</xsl:if>

				<xsl:if test="bulk_ref_id[.!='']">
				<xsl:call-template name="input-field">
				    <xsl:with-param name="label">XSL_BK_PARTICULARS</xsl:with-param>
				    <xsl:with-param name="name">bk_particular</xsl:with-param>
				    <xsl:with-param name="fieldsize">small</xsl:with-param>
				    <xsl:with-param name="size">12</xsl:with-param>
	   				<xsl:with-param name="maxsize">12</xsl:with-param>	
				</xsl:call-template> 
				</xsl:if>-->
				
				<xsl:choose>
				<xsl:when test="security:isBank($rundata)">
		    	<xsl:call-template name="hidden-field">
			      <xsl:with-param name="name">fx_rates_type_temp</xsl:with-param>
			      <xsl:with-param name="value"><xsl:value-of select="fx_rates_type"></xsl:value-of></xsl:with-param>
			     </xsl:call-template>
			     <xsl:call-template name="hidden-field">
			      <xsl:with-param name="name">fx_master_currency</xsl:with-param>
			     <xsl:with-param name="value"><xsl:value-of select="fx_contract_nbr_cur_code_1"></xsl:value-of></xsl:with-param>
			    </xsl:call-template>			    
				</xsl:when>
				<xsl:when test="not(security:isBank($rundata))">
				<xsl:call-template name="hidden-field">
			      <xsl:with-param name="name">fx_rates_type_temp</xsl:with-param>
			      <xsl:with-param name="value"><xsl:value-of select="fx_rates_type"></xsl:value-of></xsl:with-param>
			     </xsl:call-template>
			     <xsl:call-template name="hidden-field">
			      <xsl:with-param name="name">fx_master_currency</xsl:with-param>
			     <xsl:with-param name="value"><xsl:value-of select="fx_contract_nbr_cur_code_1"></xsl:value-of></xsl:with-param>
			    </xsl:call-template>
				</xsl:when>

				</xsl:choose>
		 	 </xsl:with-param>
		   </xsl:call-template>	
	    <xsl:call-template name="column-wrapper">
    	 <xsl:with-param name="content">
    	  <div id="transfer_date_div">
    	   <xsl:choose>
			<xsl:when test="$displaymode='edit' and bulk_ref_id[.='']">
				<xsl:call-template name="business-date-field">
				    <xsl:with-param name="label">XSL_GENERALDETAILS_VALUE_DATE</xsl:with-param>
				    <xsl:with-param name="name">iss_date</xsl:with-param>
				    <xsl:with-param name="size">10</xsl:with-param>
				    <xsl:with-param name="maxsize">10</xsl:with-param>
				    <xsl:with-param name="required">Y</xsl:with-param>
				    <xsl:with-param name="fieldsize">small</xsl:with-param>
				    <xsl:with-param name="sub-product-code-widget-id">sub_product_code</xsl:with-param>
				    <xsl:with-param name="bank-abbv-name-widget-id">issuing_bank_abbv_name</xsl:with-param>
				    <xsl:with-param name="cur-code-widget-id">ft_cur_code</xsl:with-param>
				    <xsl:with-param name="override-displaymode">
					    <xsl:choose>
					    	<xsl:when test="bulk_ref_id[.='']">
						    	<xsl:choose>
						    	<xsl:when test="$displaymode = 'edit'">edit</xsl:when>
						    	<xsl:otherwise>view</xsl:otherwise>
						    	</xsl:choose>
					    	</xsl:when>
					    	<xsl:otherwise>view</xsl:otherwise>
					    </xsl:choose>
				    </xsl:with-param>
				    <xsl:with-param name="readonly" select="$isBankReporting"/>
				</xsl:call-template>
			  </xsl:when>
			   <xsl:when test="$displaymode='view'">				
				<xsl:if test="recurring_payment_enabled[.='N']">
			    <xsl:call-template name="business-date-field">
				    <xsl:with-param name="label">XSL_GENERALDETAILS_VALUE_DATE</xsl:with-param>
				    <xsl:with-param name="name">iss_date</xsl:with-param>
				    <xsl:with-param name="size">10</xsl:with-param>
				    <xsl:with-param name="maxsize">10</xsl:with-param>
				    <xsl:with-param name="required">Y</xsl:with-param>
				    <xsl:with-param name="fieldsize">small</xsl:with-param>
				    <xsl:with-param name="sub-product-code-widget-id">sub_product_code</xsl:with-param>
				    <xsl:with-param name="bank-abbv-name-widget-id">issuing_bank_abbv_name</xsl:with-param>
				    <xsl:with-param name="cur-code-widget-id">ft_cur_code</xsl:with-param>
				    <xsl:with-param name="override-displaymode">
					    <xsl:choose>
					    	<xsl:when test="bulk_ref_id[.='']">
						    	<xsl:choose>
						    	<xsl:when test="$displaymode = 'edit'">edit</xsl:when>
						    	<xsl:otherwise>view</xsl:otherwise>
						    	</xsl:choose>
					    	</xsl:when>
					    	<xsl:otherwise>view</xsl:otherwise>
					    </xsl:choose>
				    </xsl:with-param>				   
				</xsl:call-template>
			   </xsl:if>
			  </xsl:when>
			</xsl:choose>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">iss_date_unsigned</xsl:with-param>
		     	<xsl:with-param name="value" select="iss_date"></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">sub_product_code_unsigned</xsl:with-param>
		     	<xsl:with-param name="value" select="sub_product_code"></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">display_entity_unsigned</xsl:with-param>
		     	<xsl:with-param name="value" select="entity"></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">ft_cur_code_unsigned</xsl:with-param>
		     	<xsl:with-param name="value" select="ft_cur_code"></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">ft_amt_unsigned</xsl:with-param>
		     	<xsl:with-param name="value" select="ft_amt"></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">recurring_start_date_unsigned</xsl:with-param>
		     	<xsl:with-param name="value" select="recurring_start_date"></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">recurring_end_date_unsigned</xsl:with-param>
		     	<xsl:with-param name="value" select="recurring_end_date"></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">regexValue</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_VALIDATION_REGEX')"/></xsl:with-param>
			</xsl:call-template>						
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">allowedProducts</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_VALIDATION_EXCLUDED_PRODUCTS')"/></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">product_type</xsl:with-param>
				<xsl:with-param name="value" select="sub_product_code"></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">currency_res</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="currency_res"/></xsl:with-param>
			</xsl:call-template>
		</div>
	    </xsl:with-param>
	   </xsl:call-template>
	  </xsl:with-param>
	 </xsl:call-template>
 	</xsl:with-param>
   </xsl:call-template>		
  </xsl:template>
  	<xsl:template name="delivery_mode_options">
  		<xsl:choose>
  		 <xsl:when test="$displaymode='edit'">
	  	<xsl:for-each select="delivery_mode_options/delivery_mode_option">
	     	<xsl:variable name="delivery_mode_value"><xsl:value-of select="."/></xsl:variable>
	     	<option>
	     		<xsl:attribute name="value"><xsl:value-of select="$delivery_mode_value"/></xsl:attribute>     		
	     	    <xsl:value-of select="localization:getDecode($language, 'N018', $delivery_mode_value)"/> 
	     	</option>
	    </xsl:for-each>
	    </xsl:when>
	    <xsl:otherwise>
	    	<xsl:choose>
      			<xsl:when test="adv_send_mode[. = '06']"><xsl:value-of select="localization:getDecode($language, 'N018', '06')"/></xsl:when>
      			<xsl:when test="adv_send_mode[. = '07']"><xsl:value-of select="localization:getDecode($language, 'N018', '07')"/></xsl:when>
      			<xsl:when test="adv_send_mode[. = '08']"><xsl:value-of select="localization:getDecode($language, 'N018', '08')"/></xsl:when>
      			<xsl:when test="adv_send_mode[. = '09']"><xsl:value-of select="localization:getDecode($language, 'N018', '09')"/></xsl:when>    
     		</xsl:choose>
	    </xsl:otherwise>
	    </xsl:choose>	
  	</xsl:template>
</xsl:stylesheet>