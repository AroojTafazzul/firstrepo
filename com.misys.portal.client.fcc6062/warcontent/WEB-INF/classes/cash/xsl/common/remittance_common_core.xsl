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
date:      12/08/11
author:    Lithwin
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
		<xsl:param name="option_for_app_date"/>
		<xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
		<xsl:param name="questionImage"><xsl:value-of select="$images_path"/>question.png</xsl:param>
		<xsl:param name="clearImage"><xsl:value-of select="$images_path"/>pic_clear.gif</xsl:param>
    	
	<xsl:template name="js-remittance-collections">
		<script>
			dojo.ready(function(){
			dojo.require("dojox.collections.ArrayList");
			misys._config = misys._config || {};
			dojo.mixin(misys._config, {
			 remittanceArray : new Array()
			});
			
			<xsl:for-each select="remittance_details/remittance_reason">
			    <xsl:variable name="remittance" select="."/>
			     misys._config.remittanceArray['<xsl:value-of select="$remittance/remittance_description"/>'] = misys._config.remittanceArray['<xsl:value-of select="$remittance/remittance_description"/>'] || [];
			     misys._config.remittanceArray['<xsl:value-of select="$remittance/remittance_description"/>'] = new Array(<xsl:value-of select='count($remittance/remittance_description)'/>);
			     misys._config.remittanceArray['<xsl:value-of select="$remittance/remittance_description"/>']= 
			     {
			     name:"<xsl:value-of select="./remittance_code"/>"
			     };
			 </xsl:for-each>
			
			misys._config.non_pab_allowed = <xsl:value-of select="defaultresource:getResource('NON_PAB_ALLOWED') = 'true' and securitycheck:hasPermission(utils:getUserACL($rundata),'ft_regular_beneficiary_access',utils:getUserEntities($rundata))"/>;

			});
		</script>
		
		<xsl:call-template name="fieldset-wrapper">
	     	<xsl:with-param name="legend">XSL_HEADER_REMITTANCEREASON</xsl:with-param>
	     	<xsl:with-param name="content">
	     	<xsl:call-template name="select-field">	
	     	<xsl:with-param name="label">XSL_REMITTANCE_DESCRIPTION</xsl:with-param>
			        <xsl:with-param name="name">remittance_description</xsl:with-param>
			        <xsl:with-param name="fieldsize">x-medium</xsl:with-param>
			        <xsl:with-param name="required">Y</xsl:with-param>
			        <xsl:with-param name="value"><xsl:value-of select="remittance_description"/></xsl:with-param>
			        <xsl:with-param name="options">
			        <xsl:call-template name="remittance_mode_options"/>
			        </xsl:with-param>
			        </xsl:call-template>
			      <xsl:call-template name="input-field">
			     <xsl:with-param name="label">XSL_REMITTANCECODE</xsl:with-param>
			     <xsl:with-param name="name">remittance_code</xsl:with-param>
			        <xsl:with-param name="fieldsize">x-medium</xsl:with-param>
			        <xsl:with-param name="readonly">Y</xsl:with-param>
			        <xsl:with-param name="value"><xsl:value-of select="remittance_code"/></xsl:with-param>
			       <!-- <xsl:with-param name="value"><xsl:value-of select="remittance_description"/></xsl:with-param> -->
			     </xsl:call-template>
	     	</xsl:with-param>	
	     </xsl:call-template>
	</xsl:template>
	
	<xsl:template name="js-remittance-collections-view">
		<xsl:variable name="remittance_code"><xsl:value-of select="remittance_description"></xsl:value-of>
		</xsl:variable>
		<xsl:call-template name="fieldset-wrapper">
	     	<xsl:with-param name="legend">XSL_HEADER_REMITTANCEREASON</xsl:with-param>
	     	<xsl:with-param name="content">
	     		<xsl:call-template name="input-field">
	     			<xsl:with-param name="label">XSL_REMITTANCE_DESCRIPTION</xsl:with-param>
			        <xsl:with-param name="name">remittance_description</xsl:with-param>
			        <xsl:with-param name="fieldsize">x-medium</xsl:with-param>
			        <xsl:with-param name="readonly">Y</xsl:with-param>
			        <xsl:with-param name="value"><xsl:value-of select="remittance_description"/></xsl:with-param>
			        <!-- <xsl:with-param name="value"><xsl:value-of select="utils:retrieveFIRemittanceDesc($language, $remittance_code)"/></xsl:with-param> -->
			     </xsl:call-template>
			     <xsl:call-template name="input-field">
			     <xsl:with-param name="label">XSL_REMITTANCECODE</xsl:with-param>
			     <xsl:with-param name="name">remittance_code</xsl:with-param>
			        <xsl:with-param name="fieldsize">x-medium</xsl:with-param>
			        <xsl:with-param name="readonly">Y</xsl:with-param>
			        <xsl:with-param name="value"><xsl:value-of select="remittance_code"/></xsl:with-param>
			     </xsl:call-template>
			 </xsl:with-param>	
	     </xsl:call-template>
	</xsl:template>
	
	
	<xsl:template name="remittance_mode_options">
	  	<xsl:for-each select="remittance_details/remittance_reason">
	     	<option>
	      			<xsl:attribute name="value">
			       	<xsl:value-of select="./remittance_description"></xsl:value-of>
			       	</xsl:attribute>
			       	<xsl:value-of select="./remittance_description"/>
	     	</option>
	    </xsl:for-each>
  </xsl:template>  
  
    <xsl:template name="ordering-institution-details">
   		<xsl:call-template name="fieldset-wrapper">
	     	<xsl:with-param name="legend">XSL_HEADER_ORDERING_INSTITUTION_DETAILS</xsl:with-param>
	     	<xsl:with-param name="button-type"></xsl:with-param>	
	     	<xsl:with-param name="content">
		       <xsl:call-template name="column-container">
				 <xsl:with-param name="content">			 
				  <xsl:call-template name="column-wrapper">
				  <xsl:with-param name="content">
					<xsl:call-template name="input-field">
	                  <xsl:with-param name="label">XSL_SWIFT_BIC_CODE</xsl:with-param>
	                  <xsl:with-param name="name">ordering_institution_swift_bic_code</xsl:with-param>
	                  <xsl:with-param name="size">11</xsl:with-param>
	                  <xsl:with-param name="maxsize">11</xsl:with-param>
	                  <xsl:with-param name="fieldsize">small</xsl:with-param>
	                  <xsl:with-param name="content-after">
		               <xsl:if test="$displaymode='edit'">
		                <xsl:call-template name="button-wrapper">
	                      <xsl:with-param name="show-image">Y</xsl:with-param>
	                      <xsl:with-param name="show-border">N</xsl:with-param>
	                      <xsl:with-param name="onclick">misys.showSearchDialog('bank',"['ordering_institution_name', 'ordering_institution_address_line_1', 'ordering_institution_address_line_2', 'ordering_institution_dom', 'ordering_institution_swift_bic_code', 'ordering_bank_contact_name', 'ordering_institution_phone', 'ordering_institution_country']", {swiftcode: false, bankcode: false}, '', '', 'width:710px;height:350px;', '<xsl:value-of select="localization:getGTPString($language, 'LIST_TITLE_SDATA_LIST_OF_SWIFT_BANKS')"/>');return false;</xsl:with-param>
	                      <xsl:with-param name="id">ordering_iso_img</xsl:with-param>
	                      <xsl:with-param name="non-dijit-button">N</xsl:with-param>
	                    </xsl:call-template>
                   		</xsl:if>
	                  </xsl:with-param>
	                </xsl:call-template>
			      	<xsl:call-template name="address">	      	
			       		<xsl:with-param name="prefix">ordering_institution</xsl:with-param>	
			       		<xsl:with-param name="show-name">Y</xsl:with-param>
			       		<xsl:with-param name="name-label">XSL_ORDERING_INSTITUTION_NAME_AND</xsl:with-param>
			       		<xsl:with-param name="show-reference">N</xsl:with-param>
			       		<xsl:with-param name="show-contact-name">N</xsl:with-param>
			       		<xsl:with-param name="show-contact-number">N</xsl:with-param>
			       		<xsl:with-param name="show-fax-number">N</xsl:with-param>
			       		<xsl:with-param name="show-email">N</xsl:with-param>
			       		<xsl:with-param name="show-country">Y</xsl:with-param>
			       		<xsl:with-param name="swift-validate">N</xsl:with-param>
			      	</xsl:call-template>	
			       	<xsl:call-template name="account-field">
			       		<xsl:with-param name="prefix">ordering_institution</xsl:with-param>
			       		<xsl:with-param name="override-displaymode">
			       			<xsl:choose>
							   	<xsl:when test="$displaymode='view'">view</xsl:when>
							   	 	<xsl:otherwise>edit</xsl:otherwise>
							</xsl:choose>
			       		 </xsl:with-param>
			       	</xsl:call-template>
			       	</xsl:with-param>
			       </xsl:call-template>
			      </xsl:with-param>
			    </xsl:call-template>
	    	</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!--
  	 Beneficiary Details Fieldset. 
   	-->
   	<xsl:template name="remittance-beneficiary-details">
   		<xsl:param name="beneficiary-header-label">XSL_HEADER_BENEFICIARY_DETAILS</xsl:param>   			
   		<xsl:param name="beneficiary-name-label">XSL_BENEFICIARYDETAILS_NAME_REMITTANCE</xsl:param>   	 
   		<xsl:param name="beneficiary-account-label">XSL_BENEFICIARY_ACCOUNT_REMITTANCE</xsl:param>    	 
   		<xsl:param name="beneficiary-swiftcode-label">XSL_SWIFT_BIC_CODE</xsl:param>  	    	 
   		<xsl:param name="beneficiary-bank-address-label">XSL_PARTIESDETAILS_BANK_NAME_AND</xsl:param>  		
   	    <xsl:param name="show-branch-address">N</xsl:param>
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
						  <xsl:with-param name="label">XSL_PARTIESDETAILS_BENEFICIARY_NAME_AND_REMITTANCE</xsl:with-param>
						  <xsl:with-param name="name">beneficiary_name</xsl:with-param>		
						  <xsl:with-param name="swift-validate">Y</xsl:with-param>
						  <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_name"/></xsl:with-param>
						  <xsl:with-param name="maxsize">35</xsl:with-param>
						  <!-- <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_VALIDATION_REGEX')"/></xsl:with-param> -->
						  <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>
						  <xsl:with-param name="required">Y</xsl:with-param>
						  <xsl:with-param name="content-after">
							<xsl:if test="$displaymode='edit' and not(security:isBank($rundata))">
								<xsl:call-template name="button-wrapper">
								  <xsl:with-param name="label">XSL_ALT_BENEFICIARY</xsl:with-param>
								  <xsl:with-param name="show-image">Y</xsl:with-param>
								  <xsl:with-param name="show-border">N</xsl:with-param>
								  <xsl:with-param name="id">beneficiary_img</xsl:with-param>
								</xsl:call-template>
							
							 <xsl:if test="not($pre-approved_beneficiary_only)">
						     <xsl:call-template name="button-wrapper">
						      <xsl:with-param name="id">clear_img</xsl:with-param>
						      <xsl:with-param name="label">XSL_ALT_CLEAR</xsl:with-param>
						      <xsl:with-param name="show-image">Y</xsl:with-param>
						      <xsl:with-param name="show-border">N</xsl:with-param>
						      <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($clearImage)"/></xsl:with-param>
						     </xsl:call-template>	
						     </xsl:if>
						     </xsl:if>				   
						  </xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="beneficiary-nickname-field-template"/>						
						<xsl:call-template name="input-field">
							    <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
							    <xsl:with-param name="name">beneficiary_address</xsl:with-param>
							    <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_address_line_1"/></xsl:with-param>
							    <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>
							    <xsl:with-param name="required">Y</xsl:with-param>
						   </xsl:call-template>
						   <xsl:call-template name="input-field">
							     <xsl:with-param name="name">beneficiary_city</xsl:with-param>
							     <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_address_line_2"/></xsl:with-param>
							     <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>
						   </xsl:call-template>
						   <xsl:call-template name="input-field">
							     <xsl:with-param name="name">beneficiary_dom</xsl:with-param>
							     <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_dom"/></xsl:with-param>
							     <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>
							</xsl:call-template> 
						<!-- When from Bulk Show this country and make it mandatroy -->
						<!-- Making this part configurable as discussed with Product Management for MPS-30472 -->
						<xsl:if test="bulk_ref_id[.!=''] and (defaultresource:getResource('SHOW_BENEFICIARY_COUNTRY_CODE') = 'true')">
							<xsl:call-template name="country-field">
				    			<xsl:with-param name="label">XSL_BENEFICIARY_COUNTRY</xsl:with-param>
				      			<xsl:with-param name="name">beneficiary_country</xsl:with-param>
				      			<xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_country"/></xsl:with-param>
				      			<xsl:with-param name="prefix">beneficiary</xsl:with-param>
				      			<xsl:with-param name="required">Y</xsl:with-param>
				    		</xsl:call-template>
						</xsl:if>
						
	                    <xsl:call-template name="input-field">
						    <xsl:with-param name="label">XSL_BENEFICIARY_ACCOUNT_REMITTANCE</xsl:with-param>
						    <xsl:with-param name="name">beneficiary_account</xsl:with-param>	
						    <xsl:with-param name="maxsize">34</xsl:with-param>	
						    <xsl:with-param name="required">Y</xsl:with-param>
						    <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_act_no"/></xsl:with-param>
						    <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>
						    <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_ACCOUNT_NO_VALIDATION_REGEX')"/></xsl:with-param>
					  	</xsl:call-template>
					  	
					  	<div id="pre_approved_row" class="field">
							<span class="label"/>
							<div id="REMITTANCE" class="content">
							   	 <xsl:attribute name="style">
							   	 <xsl:choose>
							   	 	<xsl:when test="pre_approved_status[.='Y']">display:inline</xsl:when>
							   	 	<xsl:otherwise>display:none</xsl:otherwise>
							   	 </xsl:choose>
							   	 </xsl:attribute>
								<xsl:value-of select="localization:getGTPString($language,'XSL_REMITTANCE_PAB')"/>
							</div> 
						</div>
					  	
		      	</xsl:with-param>
		      	</xsl:call-template>
		      	 <xsl:call-template name="column-wrapper">
				   <xsl:with-param name="content">	
					<xsl:call-template name="input-field">
	                  <xsl:with-param name="label">XSL_SWIFT_BIC_CODE</xsl:with-param>
	                  <xsl:with-param name="name">cpty_bank_swift_bic_code</xsl:with-param>
	                  <xsl:with-param name="size">11</xsl:with-param>
	                  <xsl:with-param name="maxsize">11</xsl:with-param>
	                  <xsl:with-param name="fieldsize">small</xsl:with-param>
	                  <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>
	                  <xsl:with-param name="content-after">
 		                <xsl:if test="$displaymode='edit'">
			                <xsl:call-template name="button-wrapper">
		                      <xsl:with-param name="show-image">Y</xsl:with-param>
		                      <xsl:with-param name="show-border">N</xsl:with-param>
		                      <xsl:with-param name="onclick">misys.showSearchDialog('bank',"['cpty_bank_name', 'cpty_bank_address_line_1', 'cpty_bank_address_line_2', 'cpty_bank_dom', 'cpty_bank_swift_bic_code', '', '','cpty_bank_country']", {swiftcode: false, bankcode: false}, '', '', 'width:710px;height:350px;', '<xsl:value-of select="localization:getGTPString($language, 'LIST_TITLE_SDATA_LIST_OF_SWIFT_BANKS')"/>');return false;</xsl:with-param>
		                      <xsl:with-param name="id">bank_iso_img</xsl:with-param>
		                      <xsl:with-param name="non-dijit-button">N</xsl:with-param>
		                    </xsl:call-template>
 	                    </xsl:if>
	                  </xsl:with-param>
	                </xsl:call-template>
	                
			      	<xsl:call-template name="address">    
			       		<xsl:with-param name="prefix">cpty_bank</xsl:with-param>		
			       		<xsl:with-param name="show-name">Y</xsl:with-param>   
	          		 	<xsl:with-param name="name-label" select="$beneficiary-bank-address-label"/>
			       		<xsl:with-param name="show-reference">N</xsl:with-param>
			       		<xsl:with-param name="show-contact-name">N</xsl:with-param>
			       		<xsl:with-param name="show-contact-number">N</xsl:with-param>
			       		<xsl:with-param name="show-fax-number">N</xsl:with-param>
			       		<xsl:with-param name="show-email">N</xsl:with-param>	       		    		
			       		<xsl:with-param name="show-country">Y</xsl:with-param>
			       		<xsl:with-param name="swift-validate">N</xsl:with-param>
			      	</xsl:call-template>
			      	
			      	<xsl:if test="$show-branch-address='Y'">
			      		<xsl:if test="$displaymode='edit'">
						<xsl:call-template name="multichoice-field">
	          		 		<xsl:with-param name="label">XSL_BRANCH_ADDRESS_CHECKBOX</xsl:with-param>
	          		 		<xsl:with-param name="type">checkbox</xsl:with-param>
	           		 		<xsl:with-param name="name">branch_address_flag</xsl:with-param>	           		 		
		            	</xsl:call-template>
		            	</xsl:if>
		            	<div id="bankBranchContent">	
			            	<xsl:call-template name="address">	      	
					       		<xsl:with-param name="prefix">beneficiary_bank_branch</xsl:with-param>	
					       		<xsl:with-param name="show-name">N</xsl:with-param>      
					       		<xsl:with-param name="address-label">XSL_BRANCH_ADDRESS</xsl:with-param>
					       		<xsl:with-param name="show-reference">N</xsl:with-param>
					       		<xsl:with-param name="show-contact-name">N</xsl:with-param>
					       		<xsl:with-param name="show-contact-number">N</xsl:with-param>
					       		<xsl:with-param name="show-fax-number">N</xsl:with-param>
					       		<xsl:with-param name="show-email">N</xsl:with-param>	 
					       		<xsl:with-param name="swift-validate">N</xsl:with-param>
					       		<xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>
					      	</xsl:call-template>      	
				      	</div>			      		
	            	</xsl:if>	
			      	<xsl:call-template name="clearing-code-desc-field">
		    			<xsl:with-param name="prefix">beneficiary_bank</xsl:with-param>	
		    		</xsl:call-template>
	    			</xsl:with-param>
	    		  </xsl:call-template>
	    		 </xsl:with-param>
	    	</xsl:call-template>
	    </xsl:with-param>
		</xsl:call-template>
	</xsl:template>
 
	<!--
  	 Ordering Customer Details Fieldset. 
   	-->
    <xsl:template name="ordering-customer-details">
   		<xsl:call-template name="fieldset-wrapper">
	     	<xsl:with-param name="legend">XSL_HEADER_ORDERING_CUSTOMER_DETAILS</xsl:with-param>
	     	<xsl:with-param name="button-type"></xsl:with-param>	
	     	<xsl:with-param name="content">
	     		<xsl:call-template name="column-container">
				<xsl:with-param name="content">			 
					<xsl:call-template name="column-wrapper">
						<xsl:with-param name="content">
		     	
			      	<xsl:call-template name="address">	      	
			       		<xsl:with-param name="prefix">ordering_customer</xsl:with-param>	
			       		<xsl:with-param name="show-name">Y</xsl:with-param>  			       		
			       		<xsl:with-param name="name-label">NAME_LABEL</xsl:with-param>
			       		<xsl:with-param name="show-reference">N</xsl:with-param>
			       		<xsl:with-param name="show-contact-name">N</xsl:with-param>
			       		<xsl:with-param name="show-contact-number">N</xsl:with-param>
			       		<xsl:with-param name="show-fax-number">N</xsl:with-param>
			       		<xsl:with-param name="show-email">N</xsl:with-param>
			       		<xsl:with-param name="swift-validate">N</xsl:with-param>
			      	</xsl:call-template>	
			      	
			       	<xsl:call-template name="account-field">
			       		<xsl:with-param name="prefix">ordering_customer</xsl:with-param>			       		
			       		<xsl:with-param name="required">Y</xsl:with-param>
			       		<xsl:with-param name="override-displaymode">
			       			<xsl:choose>
							   	<xsl:when test="$displaymode='view'">view</xsl:when>
							   	 	<xsl:otherwise>edit</xsl:otherwise>
							</xsl:choose>
			       		 </xsl:with-param> 			   
			       	</xsl:call-template>
		      	    </xsl:with-param>
		      	    </xsl:call-template>
		      	    <xsl:call-template name="column-wrapper">
					<xsl:with-param name="content">
		    		
					<xsl:call-template name="input-field">
	                  <xsl:with-param name="label">XSL_ORIGINATING_INSTITUTION_SWIFT_BIC_CODE</xsl:with-param>
	                  <xsl:with-param name="name">ordering_customer_bank_swift_bic_code</xsl:with-param>
	                  <xsl:with-param name="size">11</xsl:with-param>
	                  <xsl:with-param name="maxsize">11</xsl:with-param>
	                  <xsl:with-param name="fieldsize">small</xsl:with-param>
	                  <xsl:with-param name="content-after">
		                <xsl:if test="$displaymode='edit'">
			                <xsl:call-template name="button-wrapper">
		                      <xsl:with-param name="show-image">Y</xsl:with-param>
		                      <xsl:with-param name="show-border">N</xsl:with-param>
		                      <xsl:with-param name="onclick">misys.showSearchDialog('bank',"['ordering_customer_bank_name', 'ordering_customer_bank_address_line_1', 'ordering_customer_bank_address_line_2', 'ordering_customer_bank_dom', 'ordering_customer_bank_swift_bic_code', 'ordering_customer_bank_contact_name', 'ordering_customer_bank_phone','ordering_customer_bank_country']", {swiftcode: false, bankcode: false}, '', '', 'width:710px;height:350px;', '<xsl:value-of select="localization:getGTPString($language, 'LIST_TITLE_SDATA_LIST_OF_SWIFT_BANKS')"/>');return false;</xsl:with-param>
		                      <xsl:with-param name="id">ordering_customer_iso_img</xsl:with-param>
		                      <xsl:with-param name="non-dijit-button">N</xsl:with-param>
		                    </xsl:call-template>
	                    </xsl:if>
	                  </xsl:with-param>
	                </xsl:call-template>
		    		
			      	<xsl:call-template name="address">	      	
			       		<xsl:with-param name="prefix">ordering_customer_bank</xsl:with-param>		
			       		<xsl:with-param name="show-name">Y</xsl:with-param>   
	          		 	<xsl:with-param name="name-label">XSL_PARTIESDETAILS_BANK_NAME_AND</xsl:with-param>
			       		<xsl:with-param name="show-reference">N</xsl:with-param>
			       		<xsl:with-param name="show-contact-name">N</xsl:with-param>
			       		<xsl:with-param name="show-contact-number">N</xsl:with-param>
			       		<xsl:with-param name="show-fax-number">N</xsl:with-param>
			       		<xsl:with-param name="show-email">N</xsl:with-param>	      		    		
			       		<xsl:with-param name="show-country">Y</xsl:with-param>
			       		<xsl:with-param name="swift-validate">N</xsl:with-param>	 
			       		<xsl:with-param name="required">Y</xsl:with-param>
			      	</xsl:call-template>
			      	
			      	<xsl:call-template name="account-field">
			       		<xsl:with-param name="prefix">ordering_customer_bank</xsl:with-param>
			       		<xsl:with-param name="override-displaymode">
			       			<xsl:choose>
							   	<xsl:when test="$displaymode='view'">view</xsl:when>
							   	 	<xsl:otherwise>edit</xsl:otherwise>
							</xsl:choose>
			       		 </xsl:with-param>			       			 
			       	</xsl:call-template>
			      </xsl:with-param> 	
    		    </xsl:call-template>
    		  </xsl:with-param>
    		</xsl:call-template>    
	    </xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
    <!--
  	 Intermediary Bank Details Fieldset. 
   	-->
   	<xsl:template name="intermediary-bank-details">
   	<xsl:if test="($displaymode='edit' or ($displaymode='view' and intermediary_bank_swift_bic_code[.!='']))">
	   		<xsl:call-template name="fieldset-wrapper">
		     	<xsl:with-param name="legend">XSL_HEADER_INTERMEDIARY_BANK_DETAILS</xsl:with-param>
		     	<xsl:with-param name="button-type"></xsl:with-param>
		     	<xsl:with-param name="content">
		     	<xsl:call-template name="column-container">
				 <xsl:with-param name="content">			 
				  <xsl:call-template name="column-wrapper">
				   <xsl:with-param name="content">	
					<xsl:call-template name="input-field">
	                  <xsl:with-param name="label">XSL_SWIFT_BIC_CODE</xsl:with-param>
	                  <xsl:with-param name="name">intermediary_bank_swift_bic_code</xsl:with-param>
	                  <xsl:with-param name="size">11</xsl:with-param>
	                  <xsl:with-param name="maxsize">11</xsl:with-param>
	                  <xsl:with-param name="fieldsize">small</xsl:with-param>
	                  <xsl:with-param name="content-after">
		                <xsl:if test="$displaymode='edit'">
			                <xsl:call-template name="button-wrapper">
		                      <xsl:with-param name="show-image">Y</xsl:with-param>
		                      <xsl:with-param name="show-border">N</xsl:with-param>
		                      <xsl:with-param name="onclick">misys.showSearchDialog('bank',"['intermediary_bank_name', 'intermediary_bank_address_line_1', 'intermediary_bank_address_line_2', 'intermediary_bank_dom', 'intermediary_bank_swift_bic_code', 'intermediary_bank_contact_name', 'intermediary_bank_phone','intermediary_bank_country']", {swiftcode: false, bankcode: false}, '', '', 'width:710px;height:350px;', '<xsl:value-of select="localization:getGTPString($language, 'LIST_TITLE_SDATA_LIST_OF_SWIFT_BANKS')"/>');return false;</xsl:with-param>
		                      <xsl:with-param name="id">inter_bank_iso_img</xsl:with-param>
		                      <xsl:with-param name="non-dijit-button">N</xsl:with-param>
		                    </xsl:call-template>
                    	</xsl:if>
	                  </xsl:with-param>
	                </xsl:call-template>
			   		
			      	<xsl:call-template name="address">	      	
			       		<xsl:with-param name="prefix">intermediary_bank</xsl:with-param>	
			       		<xsl:with-param name="show-name">Y</xsl:with-param>   
	          		 	<xsl:with-param name="name-label">XSL_PARTIESDETAILS_BANK_NAME_AND</xsl:with-param> 
			       		<xsl:with-param name="show-reference">N</xsl:with-param>
			       		<xsl:with-param name="show-contact-name">N</xsl:with-param>
			       		<xsl:with-param name="show-contact-number">N</xsl:with-param>
			       		<xsl:with-param name="show-fax-number">N</xsl:with-param>
			       		<xsl:with-param name="show-email">N</xsl:with-param>	       		    		
			       		<xsl:with-param name="show-country">Y</xsl:with-param>
			       		<xsl:with-param name="swift-validate">N</xsl:with-param>			       		
			       		<xsl:with-param name="required">N</xsl:with-param>
			      	</xsl:call-template>
			      	</xsl:with-param>
			      	</xsl:call-template>
			      	
			       <xsl:call-template name="column-wrapper">
				   <xsl:with-param name="content">
			      	<xsl:call-template name="clearing-code-desc-field">
			   			<xsl:with-param name="prefix">intermediary_bank</xsl:with-param>	
			   		</xsl:call-template>
   				</xsl:with-param>
				</xsl:call-template>
			  </xsl:with-param>
			  </xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		</xsl:if>
   	</xsl:template>

   	<xsl:template name="instruction-to-bank-details">
   		<xsl:param name="override-displaymode"/>
   		<xsl:call-template name="fieldset-wrapper">
	     	<xsl:with-param name="legend">XSL_HEADER_INSTRUCTION_TO_BANK_DETAILS</xsl:with-param>
	     	<xsl:with-param name="content">
	    		<xsl:call-template name="textarea-field">	
			        <xsl:with-param name="name">instruction_to_bank</xsl:with-param>
			        <xsl:with-param name="cols">35</xsl:with-param>
			        <xsl:with-param name="rows">2</xsl:with-param>
			        <xsl:with-param name="maxlines">2</xsl:with-param>
			        <xsl:with-param name="swift-validate">N</xsl:with-param>
			        <xsl:with-param name="override-displaymode">
						<xsl:choose>
						   	<xsl:when test="$override-displaymode != '' "><xsl:value-of select="$override-displaymode"/></xsl:when>
							<xsl:otherwise><xsl:value-of select="$displaymode"/></xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>		        
			    </xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
   <!-- Account Number Field -->
   <xsl:template name="account-field">
   		<xsl:param name="prefix"/>
   		<xsl:param name="name-label">ACCOUNTNO_LABEL</xsl:param>
   		<xsl:param name="required">N</xsl:param>
   		<xsl:param name="override-displaymode">edit</xsl:param>
	    <xsl:call-template name="input-field">
		     <xsl:with-param name="label" select="$name-label"/>
		     <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_account</xsl:with-param>
		     <xsl:with-param name="required" select="$required"/>
		     <xsl:with-param name="maxsize">34</xsl:with-param>		
		     <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
	    </xsl:call-template>
   </xsl:template>
   
   <!--
  	 Transaction Details Fieldset. 
   	-->
     	<xsl:template name="transaction-details">
   		<xsl:param name="transaction-label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:param>
   		<xsl:param name="show-charge-option">Y</xsl:param>
   		<xsl:param name="show-related-reference">N</xsl:param>
   		<xsl:param name="show-sender-to-receiver-info">N</xsl:param>
   		<xsl:param name="show-request-date">N</xsl:param>
   		<xsl:param name="show-debit-account-for-charges">N</xsl:param>
   		<xsl:param name="show-payment-details-to-beneficiary">Y</xsl:param>
   		<xsl:param name="override-sub-product-code"/>
   		<xsl:param name="override-displaymode"/>
   		<xsl:call-template name="fieldset-wrapper">
	     	<xsl:with-param name="legend">XSL_HEADER_TRANSACTION_DETAILS</xsl:with-param>
	     	<xsl:with-param name="content">
	     	<xsl:call-template name="column-container">
				 <xsl:with-param name="content">			 
				  <xsl:call-template name="column-wrapper">
				   <xsl:with-param name="content">	
	     		<!-- Remittance amount field -->
	     		<xsl:if test="not(amount_access) or  (amount_access[.='true'])  ">
					<xsl:variable name="currency_res"><xsl:value-of select="utils:hasCrossCurrencyRestriction(issuing_bank/abbv_name)"/></xsl:variable>
			   		<xsl:if test="$currency_res ='true'">
						<xsl:call-template name="currency-field">
					      	<xsl:with-param name="label">XSL_AMOUNTDETAILS_REMITTANCE_AMT_LABEL</xsl:with-param>
						   	<xsl:with-param name="product-code">ft</xsl:with-param>	
						   	<xsl:with-param name="sub-product-code"><xsl:value-of select="$override-sub-product-code"/></xsl:with-param>		
						   	<xsl:with-param name="required">Y</xsl:with-param>		
						   	<xsl:with-param name="show-button">N</xsl:with-param>	       
							<xsl:with-param name="currency-readonly">N</xsl:with-param>
<!-- 							   	<xsl:choose> -->
<!-- 							   		<xsl:when test="bulk_ref_id[.!='']">Y</xsl:when> -->
<!-- 							   		<xsl:otherwise>N</xsl:otherwise> -->
<!-- 							   	</xsl:choose>				   		 -->
<!-- 						   	</xsl:with-param> -->
						   	<!-- <xsl:with-param name="override-currency-displaymode" select="$override-displaymode"></xsl:with-param> -->
						<!--    	<xsl:with-param name="override-amt-displaymode" select="$override-displaymode"></xsl:with-param> -->
						   	<xsl:with-param name="override-currency-displaymode">
								<xsl:choose>
								   	<xsl:when test="$override-displaymode != '' "><xsl:value-of select="$override-displaymode"/></xsl:when>
									<xsl:otherwise><xsl:value-of select="$displaymode"/></xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="override-amt-displaymode">
								<xsl:choose>
								   	<xsl:when test="$override-displaymode != '' "><xsl:value-of select="$override-displaymode"/></xsl:when>
									<xsl:otherwise><xsl:value-of select="$displaymode"/></xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
					    </xsl:call-template>
				    </xsl:if>

				    <xsl:if test="$currency_res ='false'">
						<xsl:call-template name="currency-field">
					      	<xsl:with-param name="label">XSL_AMOUNTDETAILS_REMITTANCE_AMT_LABEL</xsl:with-param>
						   	<xsl:with-param name="product-code">ft</xsl:with-param>
						   	<xsl:with-param name="sub-product-code"><xsl:value-of select="$override-sub-product-code"/></xsl:with-param>		
						   	<xsl:with-param name="required">Y</xsl:with-param>		
						   	<xsl:with-param name="show-button">Y</xsl:with-param>	       
						   	<xsl:with-param name="currency-readonly">N</xsl:with-param>
<!-- 							   	<xsl:choose> -->
<!-- 							   		<xsl:when test="bulk_ref_id[.!='']">Y</xsl:when> -->
<!-- 							   		<xsl:otherwise>N</xsl:otherwise> -->
<!-- 							   	</xsl:choose>				   		 -->
<!-- 						   	</xsl:with-param> -->
						   	<!-- <xsl:with-param name="override-currency-displaymode" select="$override-displaymode"></xsl:with-param> -->
						<!--    	<xsl:with-param name="override-amt-displaymode" select="$override-displaymode"></xsl:with-param> -->
						   	<xsl:with-param name="override-currency-displaymode">
								<xsl:choose>
								   	<xsl:when test="$override-displaymode != '' "><xsl:value-of select="$override-displaymode"/></xsl:when>
									<xsl:otherwise><xsl:value-of select="$displaymode"/></xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="override-amt-displaymode">
								<xsl:choose>
								   	<xsl:when test="$override-displaymode != '' "><xsl:value-of select="$override-displaymode"/></xsl:when>
									<xsl:otherwise><xsl:value-of select="$displaymode"/></xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
					    </xsl:call-template>
				    </xsl:if>
 				</xsl:if>

				    <!-- Charge Option -->
				    <xsl:if test="not(amount_access) or  (amount_access[.='true'])  ">
				    <xsl:if test="$show-charge-option='Y'">
					  	<xsl:call-template name="select-field">
					      	<xsl:with-param name="label">XSL_CHARGE_OPTION</xsl:with-param>
					      	<xsl:with-param name="name">charge_option</xsl:with-param>
					      	<xsl:with-param name="required">Y</xsl:with-param>
					      	<xsl:with-param name="fieldsize">large</xsl:with-param>
					      	<xsl:with-param name="options">	
					      		<xsl:choose>
									<xsl:when test="$displaymode='edit'">		       		
										<xsl:call-template name="code-data-options">
		                              		<xsl:with-param name="paramId">C081</xsl:with-param>
		                              		<xsl:with-param name="productCode">FT</xsl:with-param>
		                              		<xsl:with-param name="subProductCode">MT103</xsl:with-param>
		                             		<xsl:with-param name="specificOrder">Y</xsl:with-param>
		                              		<xsl:with-param name="value"><xsl:if test="chrg_code[.!='']"><xsl:value-of select="chrg_code"/></xsl:if></xsl:with-param>
		                              	</xsl:call-template>
	                              	</xsl:when>
	                              	<xsl:otherwise>
								    	<xsl:choose>
								     		 <xsl:when test="charge_option[. = 'SHA']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_OPTION_SHA')"/></xsl:when>
										     <xsl:when test="charge_option[. = 'OUR']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_OPTION_OUR')"/></xsl:when>								     
										     <xsl:when test="charge_option[. = 'BEN']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_OPTION_BEN')"/></xsl:when>
								    	</xsl:choose>
								   </xsl:otherwise>
	                              	</xsl:choose>
					     	</xsl:with-param>
					     	<xsl:with-param name="readonly">
					     		<xsl:choose>
					     			<xsl:when test="$override-displaymode = 'view'">Y</xsl:when>
					     			<xsl:otherwise>N</xsl:otherwise>
					     		</xsl:choose>
					     	</xsl:with-param>
					   	</xsl:call-template>
				   	</xsl:if>
			    	
			    	<!-- Related Reference -->	
			    	<xsl:if test="$show-related-reference='Y'">
				    	<xsl:call-template name="input-field">
			     			<xsl:with-param name="label">XSL_RELATED_REFERENCE</xsl:with-param>		
				    		<xsl:with-param name="name">related_reference</xsl:with-param>
			   				<xsl:with-param name="size">16</xsl:with-param>
			   				<xsl:with-param name="maxsize">16</xsl:with-param>
			   				<xsl:with-param name="fieldsize">large</xsl:with-param>
			   				<xsl:with-param name="required">Y</xsl:with-param>
			   				<xsl:with-param name="swift-validate">Y</xsl:with-param>
			   				<xsl:with-param name="override-displaymode">
								<xsl:choose>
								   	<xsl:when test="$override-displaymode != '' "><xsl:value-of select="$override-displaymode"/></xsl:when>
									<xsl:otherwise><xsl:value-of select="$displaymode"/></xsl:otherwise>
								</xsl:choose>
					   		</xsl:with-param>
			    		</xsl:call-template>
		    		</xsl:if>
		    	</xsl:if>
		    	<!-- Customer Reference -->	
		    	<xsl:call-template name="input-field">
	     			<xsl:with-param name="label" select="$transaction-label"/>			
		    		<xsl:with-param name="name">cust_ref_id</xsl:with-param>
	   				<xsl:with-param name="size">16</xsl:with-param>
	   				<xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_CASH_LENGTH')"/></xsl:with-param>
	   				<xsl:with-param name="regular-expression">
	   							<xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_CASH_VALIDATION_REGEX')"/>
	   				</xsl:with-param>
	   				<xsl:with-param name="fieldsize">small</xsl:with-param>
	   				<xsl:with-param name="override-displaymode">
						<xsl:choose>
						   	<xsl:when test="$override-displaymode != '' "><xsl:value-of select="$override-displaymode"/></xsl:when>
							<xsl:otherwise><xsl:value-of select="$displaymode"/></xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
	    		</xsl:call-template>
	    		<xsl:if test="not(amount_access) or  (amount_access[.='true'])  ">
	    		<!-- Payment Details to Beneficiary -->
	    		<xsl:if test="$show-payment-details-to-beneficiary='Y'">
	    			<xsl:choose>
			    		<xsl:when test="$displaymode='edit'">
			    			<xsl:call-template name="row-wrapper">
						      <xsl:with-param name="label">XSL_PAYMENTS_DETAILS_TO_BENEFICIARY</xsl:with-param>
						      <xsl:with-param name="id">payment_details_to_beneficiary</xsl:with-param>	
						      <xsl:with-param name="type">textarea</xsl:with-param>   
						      <xsl:with-param name="content"> 
						      <xsl:call-template name="textarea-field">
				     			<xsl:with-param name="name">payment_details_to_beneficiary</xsl:with-param>
						        <xsl:with-param name="cols">35</xsl:with-param>
						        <xsl:with-param name="rows">4</xsl:with-param>
						        <xsl:with-param name="maxlines">4</xsl:with-param>
						       	<xsl:with-param name="swift-validate">Y</xsl:with-param>
						       	<xsl:with-param name="required">N</xsl:with-param>
					    	  </xsl:call-template>
					    	  </xsl:with-param>
						    </xsl:call-template>
					      </xsl:when>
					      <xsl:when test="$displaymode='view' and payment_details_to_beneficiary[.!='']">
					      <xsl:call-template name="big-textarea-wrapper">
					      <xsl:with-param name="label">XSL_PAYMENTS_DETAILS_TO_BENEFICIARY</xsl:with-param>
					      <xsl:with-param name="content"><div class="content">
					        <xsl:value-of select="payment_details_to_beneficiary"/>
					      </div></xsl:with-param>
					     </xsl:call-template>
					     </xsl:when>
				     </xsl:choose>
			    </xsl:if>
			    <!-- beneficiary_reference is not applicable -->
			    <!--<xsl:if test="bulk_ref_id[.!='']">
			    <xsl:call-template name="input-field">
	    			<xsl:with-param name="label">XSL_GENERALDETAILS_BEN_REF</xsl:with-param>	
	    			<xsl:with-param name="name">beneficiary_reference</xsl:with-param>
	  				<xsl:with-param name="size">19</xsl:with-param>
	  				<xsl:with-param name="maxsize">19</xsl:with-param>
	  				<xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_reference"/></xsl:with-param>
	  				<xsl:with-param name="fieldsize">small</xsl:with-param>
		  		</xsl:call-template>
		  		</xsl:if>-->
		  		
			    <xsl:if test="bulk_ref_id[.!=''] and transaction_code and transaction_code/transaction_codes[.!='']">
		    	 <xsl:call-template name="select-field">
								      	<xsl:with-param name="label">XSL_BK_TRANSACTION_CODE</xsl:with-param>
								      	<xsl:with-param name="name">bk_transaction_code</xsl:with-param>
								      	<xsl:with-param name="fieldsize">medium</xsl:with-param>
								      	<xsl:with-param name="required">N</xsl:with-param>
								      	<xsl:with-param name="options">			       		
											<xsl:choose>
												<xsl:when test="$displaymode='edit'">
												<xsl:for-each select="transaction_code/transaction_codes">
												    <option>
													    <xsl:attribute name="value"><xsl:value-of select="transaction_code_id"></xsl:value-of></xsl:attribute>
													    <xsl:value-of select="tranaction_code_des"/>
												    </option>
												</xsl:for-each>
											   </xsl:when>
											</xsl:choose>
								     	</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
				 </xsl:if>
				 <!-- bk_particular is not applicable -->	
				<!--<xsl:if test="bulk_ref_id[.!='']">
				<xsl:call-template name="input-field">
				    <xsl:with-param name="label">XSL_BK_PARTICULARS</xsl:with-param>
				    <xsl:with-param name="name">bk_particular</xsl:with-param>
				    <xsl:with-param name="fieldsize">small</xsl:with-param>
				    <xsl:with-param name="size">12</xsl:with-param>
	   				<xsl:with-param name="maxsize">12</xsl:with-param>	
				</xsl:call-template> 
				</xsl:if>-->	
			    
			    <xsl:if test="$show-sender-to-receiver-info='Y'">
			    	<div>
			    	<xsl:choose>
			    		<xsl:when test="$displaymode='edit'">
						      <xsl:call-template name="textarea-field">
				     			<xsl:with-param name="label">XSL_SENDER_TO_RECEIVER_INFORMATION</xsl:with-param>	
						        <xsl:with-param name="name">sender_to_receiver_info</xsl:with-param>
						        <xsl:with-param name="cols">35</xsl:with-param>
						        <xsl:with-param name="rows">6</xsl:with-param>
						        <xsl:with-param name="maxlines">6</xsl:with-param>
						        <xsl:with-param name="swift-validate">Y</xsl:with-param>			        
						    </xsl:call-template>
					      </xsl:when>
					      <xsl:when test="$displaymode='view' and sender_to_receiver_info[.!='']">
					      <xsl:call-template name="big-textarea-wrapper">
					      <xsl:with-param name="label">XSL_SENDER_TO_RECEIVER_INFORMATION</xsl:with-param>
					      <xsl:with-param name="content"><div class="content">
					        <xsl:value-of select="sender_to_receiver_info"/>
					      </div></xsl:with-param>
					     </xsl:call-template>
					     </xsl:when>
				     </xsl:choose>
				     </div>
			    </xsl:if>
			    </xsl:with-param>
			    </xsl:call-template>
			    
			    <xsl:call-template name="column-wrapper">
				<xsl:with-param name="content">
				<xsl:if test="not(amount_access) or  (amount_access[.='true'])  ">
				<div id="process_request_dates_div">
					<xsl:if test="(($displaymode='edit'  and bulk_ref_id[.='']) or ($displaymode='view'))">
					    <xsl:call-template name="business-date-field">
						    <xsl:with-param name="label">XSL_PROCESSING_DATE</xsl:with-param>
						    <xsl:with-param name="name">iss_date</xsl:with-param>
						    <xsl:with-param name="size">10</xsl:with-param>
						    <xsl:with-param name="maxsize">10</xsl:with-param>
						    <xsl:with-param name="fieldsize">small</xsl:with-param>
						    <xsl:with-param name="type">date</xsl:with-param>
						    <xsl:with-param name="swift-validate">N</xsl:with-param>
						    <xsl:with-param name="required">Y</xsl:with-param>
						    <xsl:with-param name="sub-product-code-widget-id">sub_product_code</xsl:with-param>
						    <xsl:with-param name="bank-abbv-name-widget-id">issuing_bank_abbv_name</xsl:with-param>
						    <xsl:with-param name="cur-code-widget-id">ft_cur_code</xsl:with-param>
						    <xsl:with-param name="override-displaymode">
							    <xsl:choose>
							    	<xsl:when test="bulk_ref_id[.='']">
								    	<xsl:choose>
								    	<xsl:when test="$override-displaymode != '' "><xsl:value-of select="$override-displaymode"/></xsl:when>
								    	<xsl:when test="$displaymode = 'edit'">edit</xsl:when>
								    	<xsl:otherwise>view</xsl:otherwise>
								    	</xsl:choose>
							    	</xsl:when>
							    	<xsl:otherwise>view</xsl:otherwise>
							    </xsl:choose>
						    </xsl:with-param>
					   	</xsl:call-template>
					   	
					   	<!--  Request Date. --> 			   	 
					    <xsl:if test="$show-request-date='Y'">
						   	<xsl:call-template name="business-date-field">
							    <xsl:with-param name="label">XSL_REQUEST_DATE</xsl:with-param>
							    <xsl:with-param name="name">request_date</xsl:with-param>
							    <xsl:with-param name="size">10</xsl:with-param>
							    <xsl:with-param name="maxsize">10</xsl:with-param>
							    <xsl:with-param name="fieldsize">small</xsl:with-param>
							    <xsl:with-param name="type">date</xsl:with-param>
							    <xsl:with-param name="swift-validate">N</xsl:with-param>
							    <xsl:with-param name="required">Y</xsl:with-param>
							    <xsl:with-param name="sub-product-code-widget-id">sub_product_code</xsl:with-param>
							    <xsl:with-param name="bank-abbv-name-widget-id">issuing_bank_abbv_name</xsl:with-param>
							    <xsl:with-param name="cur-code-widget-id">ft_cur_code</xsl:with-param>
							    <xsl:with-param name="override-displaymode">
								    <xsl:choose>
								    	<xsl:when test="bulk_ref_id[.='']">
									    	<xsl:choose>
									    	<xsl:when test="$override-displaymode != '' "><xsl:value-of select="$override-displaymode"/></xsl:when>
									    	<xsl:when test="$override-displaymode ='view'">view</xsl:when>
									    	<xsl:when test="$displaymode = 'edit'">edit</xsl:when>
									    	<xsl:otherwise>view</xsl:otherwise>
									    	</xsl:choose>
								    	</xsl:when>
								    	<xsl:otherwise>view</xsl:otherwise>
								    </xsl:choose>
							    </xsl:with-param>
						   	</xsl:call-template>	
				    	</xsl:if>
			    	</xsl:if>
		    	</div>	
		    	</xsl:if>
		    	<xsl:variable name="pre-approved_beneficiary_only" select="not(securitycheck:hasPermission(utils:getUserACL($rundata),'ft_regular_beneficiary_access',utils:getUserEntities($rundata))) or (defaultresource:getResource('NON_PAB_ALLOWED') = 'false')"/>
		    	<xsl:call-template name="hidden-field">
			   		<xsl:with-param name="id">beneficiary_bank_clearing_code_desc_no_send</xsl:with-param>
			   		<xsl:with-param name="value"><xsl:value-of select ="beneficiary_bank_clearing_code_desc"/></xsl:with-param>
			   	</xsl:call-template>
			   	<xsl:call-template name="hidden-field">
			   		<xsl:with-param name="id">intermediary_bank_clearing_code_desc_no_send</xsl:with-param>
			   		<xsl:with-param name="value"><xsl:value-of select ="intermediary_bank_clearing_code_desc"/></xsl:with-param>
			   	</xsl:call-template>
			   	<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">option_for_tnx</xsl:with-param>
						<xsl:with-param name="value" select="$option"/>
				</xsl:call-template>
			    <xsl:call-template name="hidden-field">
					<xsl:with-param name="name">iss_date_unsigned</xsl:with-param>
			     	<xsl:with-param name="value" select="iss_date"></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">beneficiary_bank_swift_bic_code</xsl:with-param>
			     	<xsl:with-param name="value" select="beneficiary_bank_swift_bic_code"></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">debit_account_for_charges</xsl:with-param>
			     	<xsl:with-param name="value" select="debit_account_for_charges"></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">charge_act_cur_code</xsl:with-param>
			     	<xsl:with-param name="value" select="charge_act_cur_code"></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">charge_act_no</xsl:with-param>
			     	<xsl:with-param name="value" select="charge_act_no"></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">base_cur_code</xsl:with-param>
			     	<xsl:with-param name="value" select="base_cur_code"></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">request_date_unsigned</xsl:with-param>
			     	<xsl:with-param name="value" select="request_date"></xsl:with-param>
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
					<xsl:with-param name="id">currency_res</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="utils:hasCrossCurrencyRestriction(issuing_bank/abbv_name)"/></xsl:with-param>
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
					<xsl:with-param name="name">payment_fee_details</xsl:with-param>
					<xsl:with-param name="id">payment_fee_details</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">has_intermediary</xsl:with-param>
					<xsl:with-param name="id">has_intermediary</xsl:with-param>
				</xsl:call-template>
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
			    <xsl:choose>
			    <xsl:when test="$pre-approved_beneficiary_only ='true'">
			    <xsl:call-template name="hidden-field">
			      <xsl:with-param name="name">pre_approved_beneficiary_status</xsl:with-param>
			     <xsl:with-param name="value">Y</xsl:with-param>
			    </xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
				<xsl:call-template name="hidden-field">
			      <xsl:with-param name="name">pre_approved_beneficiary_status</xsl:with-param>
			     <xsl:with-param name="value">N</xsl:with-param>
			    </xsl:call-template>
				</xsl:otherwise>
				</xsl:choose>
		    	<!--  Debit Account For Charges -->
			    <xsl:if test="$show-debit-account-for-charges='Y'">
			    	<xsl:call-template name="user-account-field">
				  		<xsl:with-param name="label">XSL_DEBIT_ACCOUNT_FOR_CHARGES</xsl:with-param>
				  		<xsl:with-param name="name">charge</xsl:with-param>
				    	<xsl:with-param name="entity-field">entity</xsl:with-param>
				    	<xsl:with-param name="product_types">FT:<xsl:value-of select="sub_product_code"/></xsl:with-param>
				    	<xsl:with-param name="dr-cr">debit</xsl:with-param>
				    	<xsl:with-param name="show-product-types">N</xsl:with-param>
				    	<xsl:with-param name="value"><xsl:value-of select="debit_account_for_charges"/></xsl:with-param>
				    	<xsl:with-param name="ccy-code-fields">ft_cur_code,base_cur_code</xsl:with-param>
			    	</xsl:call-template>
		    	</xsl:if>	
	    	</xsl:with-param>
		   </xsl:call-template>
		  </xsl:with-param>
		 </xsl:call-template>
	   </xsl:with-param>
	</xsl:call-template>
	</xsl:template>   
		 <xsl:variable name="clearing_code" select="defaultresource:getResource('CLEARING_CODE_ENABLED')='true'"/>
	
	<xsl:template name="clearing-code-desc-field">
		<xsl:param name="prefix"/>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="id"><xsl:value-of select="$prefix"/>_clearing_code_section</xsl:with-param>
			
			<xsl:with-param name="content">
		<xsl:if test="$clearing_code='true'">
				<xsl:call-template name="input-field">
			     	<xsl:with-param name="label">XSL_CLEARING_CODE_DESCRIPTION</xsl:with-param>			
				    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_clearing_code</xsl:with-param>
			   		<xsl:with-param name="maxsize">34</xsl:with-param>
			   		<xsl:with-param name="readonly">N</xsl:with-param>
			   		<xsl:with-param name="size">10</xsl:with-param>
			    </xsl:call-template>
			    <xsl:call-template name="select-field">
				    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_clearing_code_desc</xsl:with-param>
				    <xsl:with-param name="fieldsize">s-medium</xsl:with-param>
				    <xsl:with-param name="content-after">
					   <xsl:if test="$displaymode='edit'">
					   	<xsl:call-template name="button-wrapper">
						      <xsl:with-param name="label">XSL_CLEARING_CODE_FORMAT</xsl:with-param>
						      <xsl:with-param name="show-image">Y</xsl:with-param>
						      <xsl:with-param name="show-border">N</xsl:with-param>		      
		    		  				  <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($questionImage)"/></xsl:with-param>
				      		  <xsl:with-param name="onclick">misys.show<xsl:value-of select="$prefix"/>ClearingCodeFormat();return false;</xsl:with-param>
				      		  <xsl:with-param name="non-dijit-button">N</xsl:with-param>
						</xsl:call-template>
					   </xsl:if>
				    </xsl:with-param>
			   	</xsl:call-template>
			   	</xsl:if>
			</xsl:with-param>
		</xsl:call-template>
    </xsl:template>
    
    <xsl:template name="remittance-beneficiary-institution-details">
   		<xsl:param name="beneficiary-header-label">XSL_HEADER_BENEFICIARY_INSTITUTION_DETAILS</xsl:param>
   		<xsl:param name="beneficiary-name-label">XSL_BENEFICIARY_INSTITUTION_NAME</xsl:param>   	 
   		<xsl:param name="beneficiary-account-label">XSL_BENEFICIARY_INSTITUTION_ACCOUNT</xsl:param>    	 
   		<xsl:param name="beneficiary-swiftcode-label">XSL_BENEFICIARY_INSTITUTION_SWIFT_CODE</xsl:param>  	    	 
   		<xsl:param name="beneficiary-bank-address-label">XSL_BENEFICIARY_INSTITUTION_BANK_ADDRESS_NAME</xsl:param>  		
   	    <xsl:param name="show-branch-address">N</xsl:param>
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
					  <xsl:with-param name="label">XSL_SWIFT_BIC_CODE</xsl:with-param>
					  <xsl:with-param name="name">beneficiary_swift_bic_code</xsl:with-param>
	                  <xsl:with-param name="size">11</xsl:with-param>
	                  <xsl:with-param name="maxsize">11</xsl:with-param>
	                  <xsl:with-param name="fieldsize">small</xsl:with-param>
	                  <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>
	                  <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_act_iso_code"/></xsl:with-param>
	                  <xsl:with-param name="content-after">
 		                <xsl:if test="$displaymode='edit'">
			                <xsl:call-template name="button-wrapper">
		                      <xsl:with-param name="show-image">Y</xsl:with-param>
		                      <xsl:with-param name="show-border">N</xsl:with-param>
		                      <xsl:with-param name="onclick">misys.showSearchDialog('bank',"['beneficiary_name', 'beneficiary_address', 'beneficiary_city', 'beneficiary_dom', 'beneficiary_swift_bic_code', '', '','beneficiary_country']", {swiftcode: false, bankcode: false}, '', '', 'width:710px;height:350px;', '<xsl:value-of select="localization:getGTPString($language, 'LIST_TITLE_SDATA_LIST_OF_SWIFT_BANKS')"/>');return false;</xsl:with-param>
		                      <xsl:with-param name="id">beneficiary_iso_img</xsl:with-param>
		                      <xsl:with-param name="non-dijit-button">N</xsl:with-param>
		                    </xsl:call-template>
 	                    </xsl:if>
	                  </xsl:with-param>
	                </xsl:call-template>
			      		<xsl:call-template name="input-field">
						  <xsl:with-param name="label">XSL_BENEFICIARY_INSTITUTION_NAME</xsl:with-param>
						  <xsl:with-param name="name">beneficiary_name</xsl:with-param>		
						  <xsl:with-param name="swift-validate">Y</xsl:with-param>
						  <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_name"/></xsl:with-param>
						  <xsl:with-param name="maxsize">20</xsl:with-param>
						  <xsl:with-param name="required">Y</xsl:with-param>
						  <!-- <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_VALIDATION_REGEX')"/></xsl:with-param> -->
						  <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>
						  <xsl:with-param name="content-after">
							<xsl:if test="$displaymode='edit'">
								<xsl:call-template name="button-wrapper">
								  <xsl:with-param name="label">XSL_ALT_BENEFICIARY</xsl:with-param>
								  <xsl:with-param name="show-image">Y</xsl:with-param>
								  <xsl:with-param name="show-border">N</xsl:with-param>
								  <xsl:with-param name="id">beneficiary_img</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							 <xsl:if test="not($pre-approved_beneficiary_only) and $displaymode='edit'">
						     <xsl:call-template name="button-wrapper">
						      <xsl:with-param name="id">clear_img</xsl:with-param>
						      <xsl:with-param name="label">XSL_ALT_CLEAR</xsl:with-param>
						      <xsl:with-param name="show-image">Y</xsl:with-param>
						      <xsl:with-param name="show-border">N</xsl:with-param>
						      <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($clearImage)"/></xsl:with-param>
						     </xsl:call-template>	
						     </xsl:if>				   
						  </xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="beneficiary-nickname-field-template"/>
						<xsl:call-template name="input-field">
							    <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
							    <xsl:with-param name="name">beneficiary_address</xsl:with-param>
							    <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_address_line_1"/></xsl:with-param>
							    <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>
							    <xsl:with-param name="required">Y</xsl:with-param>
						   </xsl:call-template>
						   	<xsl:call-template name="input-field">
							     <xsl:with-param name="name">beneficiary_city</xsl:with-param>
							     <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_address_line_2"/></xsl:with-param>
							     <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>
						   </xsl:call-template>
						   <xsl:call-template name="input-field">
							     <xsl:with-param name="name">beneficiary_dom</xsl:with-param>
							     <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_dom"/></xsl:with-param>
							     <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>
							</xsl:call-template> 
	                    <xsl:call-template name="input-field">
						    <xsl:with-param name="label">XSL_BENEFICIARY_INSTITUTION_ACCOUNT</xsl:with-param>
						    <xsl:with-param name="name">beneficiary_account</xsl:with-param>	
						    <xsl:with-param name="maxsize">34</xsl:with-param>	
						    <xsl:with-param name="required">N</xsl:with-param>
						    <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_act_no"/></xsl:with-param>
						    <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>
					  	</xsl:call-template>
					  	<div id="pre_approved_row" class="field">
							<span class="label"/>
							<div id="REMITTANCE" class="content">
							   	 <xsl:attribute name="style">
							   	 <xsl:choose>
							   	 	<xsl:when test="pre_approved_status[.='Y']">display:inline</xsl:when>
							   	 	<xsl:otherwise>display:none</xsl:otherwise>
							   	 </xsl:choose>
							   	 </xsl:attribute>
								<xsl:value-of select="localization:getGTPString($language,'XSL_REMITTANCE_PAB')"/>
							</div> 
						</div>
					  	
		      	</xsl:with-param>
		      	</xsl:call-template>
		      	 <xsl:call-template name="column-wrapper">
				   <xsl:with-param name="content">	
					<xsl:call-template name="input-field">
	                  <xsl:with-param name="label">XSL_SWIFT_BIC_CODE</xsl:with-param>
	                  <xsl:with-param name="name">cpty_bank_swift_bic_code</xsl:with-param>
	                  <xsl:with-param name="size">11</xsl:with-param>
	                  <xsl:with-param name="maxsize">11</xsl:with-param>
	                  <xsl:with-param name="fieldsize">small</xsl:with-param>
	                  <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>
	                  <xsl:with-param name="content-after">
 		                <xsl:if test="$displaymode='edit'">
			                <xsl:call-template name="button-wrapper">
		                      <xsl:with-param name="show-image">Y</xsl:with-param>
		                      <xsl:with-param name="show-border">N</xsl:with-param>
		                      <xsl:with-param name="onclick">misys.showSearchDialog('bank',"['cpty_bank_name', 'cpty_bank_address_line_1', 'cpty_bank_address_line_2', 'cpty_bank_dom', 'cpty_bank_swift_bic_code', '', '','cpty_bank_country']", {swiftcode: false, bankcode: false}, '', '', 'width:710px;height:350px;', '<xsl:value-of select="localization:getGTPString($language, 'LIST_TITLE_SDATA_LIST_OF_SWIFT_BANKS')"/>');return false;</xsl:with-param>
		                      <xsl:with-param name="id">bank_iso_img</xsl:with-param>
		                      <xsl:with-param name="non-dijit-button">N</xsl:with-param>
		                    </xsl:call-template>
 	                    </xsl:if>
	                  </xsl:with-param>
	                </xsl:call-template>
	                
			      	<xsl:call-template name="address">	      	
			       		<xsl:with-param name="prefix">cpty_bank</xsl:with-param>		
			       		<xsl:with-param name="show-name">Y</xsl:with-param>   
	          		 	<xsl:with-param name="name-label" select="$beneficiary-bank-address-label"/>
			       		<xsl:with-param name="show-reference">N</xsl:with-param>
			       		<xsl:with-param name="show-contact-name">N</xsl:with-param>
			       		<xsl:with-param name="show-contact-number">N</xsl:with-param>
			       		<xsl:with-param name="show-fax-number">N</xsl:with-param>
			       		<xsl:with-param name="show-email">N</xsl:with-param>	       		    		
			       		<xsl:with-param name="show-country">Y</xsl:with-param>
			       		<xsl:with-param name="swift-validate">N</xsl:with-param>
			       		<xsl:with-param name="readonly">
			       			<xsl:choose>
			       				<xsl:when test="$option_for_app_date='SCRATCH'">N</xsl:when>
			       				<xsl:when test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:when>
			       			</xsl:choose>
			       		</xsl:with-param>
			      	</xsl:call-template>
			      	
			      	<xsl:if test="$show-branch-address='Y'">
			      		<xsl:if test="$displaymode='edit'">
						<xsl:call-template name="multichoice-field">
	          		 		<xsl:with-param name="label">XSL_BRANCH_ADDRESS_CHECKBOX</xsl:with-param>
	          		 		<xsl:with-param name="type">checkbox</xsl:with-param>
	           		 		<xsl:with-param name="name">branch_address_flag</xsl:with-param>	           		 		
		            	</xsl:call-template>
		            	</xsl:if>
		            	<div id="bankBranchContent">	
			            	<xsl:call-template name="address">	      	
					       		<xsl:with-param name="prefix">beneficiary_bank_branch</xsl:with-param>	
					       		<xsl:with-param name="show-name">N</xsl:with-param>      
					       		<xsl:with-param name="address-label">XSL_BRANCH_ADDRESS</xsl:with-param>
					       		<xsl:with-param name="show-reference">N</xsl:with-param>
					       		<xsl:with-param name="show-contact-name">N</xsl:with-param>
					       		<xsl:with-param name="show-contact-number">N</xsl:with-param>
					       		<xsl:with-param name="show-fax-number">N</xsl:with-param>
					       		<xsl:with-param name="show-email">N</xsl:with-param>	 
					       		<xsl:with-param name="swift-validate">N</xsl:with-param>
					       		<xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>
					      	</xsl:call-template>      	
				      	</div>			      		
	            	</xsl:if>	
			      	<xsl:call-template name="clearing-code-desc-field">
		    			<xsl:with-param name="prefix">beneficiary_bank</xsl:with-param>	
		    		</xsl:call-template>
	    			</xsl:with-param>
	    		  </xsl:call-template>
	    		 </xsl:with-param>
	    	</xsl:call-template>
	    </xsl:with-param>
		</xsl:call-template>
	</xsl:template> 
   
	<!-- Swift BIC Code. -->
	<xsl:template name="swift-bic-code-field">
		<xsl:param name="prefix"/>
  	 	<xsl:param name="name-label">XSL_SWIFT_BIC_CODE</xsl:param>
  		<xsl:call-template name="input-field">  		
		     <xsl:with-param name="label" select="$name-label"/>
		    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_swift_bic_code</xsl:with-param>
   			<xsl:with-param name="maxsize">11</xsl:with-param>
   			<xsl:with-param name="fieldsize">small</xsl:with-param>
  		</xsl:call-template>  		
    </xsl:template>	
   	
   
</xsl:stylesheet>