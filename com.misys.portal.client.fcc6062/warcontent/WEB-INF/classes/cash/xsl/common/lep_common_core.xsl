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
		exclude-result-prefixes="localization securitycheck utils">
		
<xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
<xsl:param name="clearImage"><xsl:value-of select="$images_path"/>pic_clear.gif</xsl:param>		
	
	<xsl:template name="lep-transfer-to-details">
	
		<xsl:variable name="pre-approved_beneficiary_only" select="not(securitycheck:hasPermission(utils:getUserACL($rundata),'ft_regular_beneficiary_access',utils:getUserEntities($rundata)))"/>
		   
	   	<!-- Transfer to options for IAFT -->
		<xsl:call-template name="fieldset-wrapper">
		  <xsl:with-param name="legend">XSL_HEADER_TRANSFER_TO_DETAILS</xsl:with-param>
			 <xsl:with-param name="content">	
			<!-- Transfer to my account or beneficiary account -->
				 <xsl:if test="not($pre-approved_beneficiary_only)">
				  <div class="IAFT">
				 	<xsl:choose>
					 	<xsl:when test="$displaymode = 'edit'">		
							<xsl:call-template name="multioption-inline-wrapper">
						      <xsl:with-param name="group-label">XSL_TRANSFER_TO</xsl:with-param>
						      <xsl:with-param name="content">
						        <xsl:call-template name="multichoice-field">
						        	<xsl:with-param name="group-label" select="XSL_TRANSFER_TO"/>			  
							    	<xsl:with-param name="label">XSL_TRANSFER_TO_MY_ACCOUNT</xsl:with-param>
							        <xsl:with-param name="name">transfer_to</xsl:with-param>
							        <xsl:with-param name="id">my_account</xsl:with-param>
							        <xsl:with-param name="value">01</xsl:with-param>		
							        <xsl:with-param name="checked">Y</xsl:with-param>	  
							        <xsl:with-param name="type">radiobutton</xsl:with-param>
							        <xsl:with-param name="inline">Y</xsl:with-param>
							     </xsl:call-template>						    
							     <xsl:call-template name="multichoice-field">			  
							    	<xsl:with-param name="label">XSL_TRANSFER_TO_MY_BENEFICIARY</xsl:with-param>
							        <xsl:with-param name="name">transfer_to</xsl:with-param>
							        <xsl:with-param name="id">ben_account</xsl:with-param>
							        <xsl:with-param name="value">02</xsl:with-param>			  
							        <xsl:with-param name="type">radiobutton</xsl:with-param>
							        <xsl:with-param name="inline">Y</xsl:with-param>
							     </xsl:call-template>						    
					    	  </xsl:with-param>
					        </xsl:call-template>	 
					    </xsl:when>
					    <xsl:otherwise>
						    <xsl:if test="sub_product_code[.='IAFT']">
						       	<xsl:call-template name="input-field">
								 <xsl:with-param name="label">XSL_TRANSFER_TO</xsl:with-param>
								 <xsl:with-param name="name">transfer_to</xsl:with-param>							
								 <xsl:with-param name="value">
								  <xsl:choose>
								    <xsl:when test="beneficiary_mode = '01'">
								    	 <xsl:value-of select="localization:getGTPString($language,'XSL_TRANSFER_TO_MY_ACCOUNT')"/>
								    </xsl:when>
								    <xsl:otherwise>
								    	 <xsl:value-of select="localization:getGTPString($language,'XSL_TRANSFER_TO_BENEFICIARY')"/>
								    </xsl:otherwise>
								  </xsl:choose>
								 </xsl:with-param>
								</xsl:call-template>				 
						   </xsl:if>      
					   </xsl:otherwise>
					</xsl:choose>
				 </div>
				</xsl:if>	        
		        
		    <xsl:call-template name="column-container">
			 <xsl:with-param name="content">
			 <!-- column 1 -->		 
			  <xsl:call-template name="column-wrapper">
			   <xsl:with-param name="content"> 
			  		 <!-- Beneficiary name -->
				   	<xsl:call-template name="input-field">
					 <xsl:with-param name="label">XSL_PARTIESDETAILS_BENEFICIARY_NAME_LEP</xsl:with-param>
					 <xsl:with-param name="name">beneficiary_name</xsl:with-param>		
					 <xsl:with-param name="swift-validate">Y</xsl:with-param>
					 <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_name"/></xsl:with-param>
					 <xsl:with-param name="required">Y</xsl:with-param>	
					 <xsl:with-param name="maxsize">
					 	 <xsl:choose>
						    <xsl:when test="sub_product_code[.='IBG' or 'IBGEX']">20</xsl:when>
						    <xsl:otherwise>35</xsl:otherwise>
						</xsl:choose>
					 </xsl:with-param>
					 <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>				
					</xsl:call-template>	
					<xsl:if test="$displaymode='edit'">	
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
					      <xsl:with-param name="img-height">16</xsl:with-param>
					      <xsl:with-param name="img-width">13</xsl:with-param>
					     </xsl:call-template>					   
				       </xsl:if>
                    </xsl:if>
                     <!-- Beneficiary Address, display in case of MEPS but hide in other cases-->
					 <div class="MEPS">
						<xsl:call-template name="input-field">
						    <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
						    <xsl:with-param name="name">beneficiary_address</xsl:with-param>
						    <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_address_line_1"/></xsl:with-param>
						    <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>				
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
					 </div>	
					<xsl:if test="$displaymode = 'edit' or ($displaymode ='view' and counterparties/counterparty/counterparty_act_no[.!=''])">
						<span class="label"> 
						 	<span class="required-field-symbol"><xsl:value-of select="localization:getGTPString($language, 'REQUIRED_PREFIX')"/></span>
							<xsl:value-of select="localization:getGTPString($language,'XSL_BENEFICIARY_ACCOUNT_LEP')"/>
						</span>
					</xsl:if>

					<xsl:if test="$displaymode = 'edit' or ($displaymode ='view' and sub_product_code[.='IAFT'])">
					 	<div>
					 	   <xsl:attribute name="class">CUR <xsl:if test="$displaymode !='edit'"> inlineBlock</xsl:if></xsl:attribute>
					 	   <xsl:choose>
					 		<xsl:when test="$displaymode = 'edit'">
						 	 <div name="beneficiary_act_cur_code" id="beneficiary_act_cur_code" trim="true" uppercase="true" dojoType="dijit.form.ValidationTextBox" regExp="^[a-zA-Z]*$" class="xx-small inlineBlock inlineBlockNoLabel" maxLength="3">										
								<xsl:attribute name="value"><xsl:value-of select="counterparties/counterparty/counterparty_cur_code"/></xsl:attribute>
								<xsl:attribute name="displayedValue"><xsl:value-of select="counterparties/counterparty/counterparty_cur_code"/></xsl:attribute>
								<xsl:attribute name="readOnly">Y</xsl:attribute>
							</div>
						   </xsl:when>
						   <xsl:otherwise>
						   	   <div style="display:none;">
								   <div name="beneficiary_act_cur_code" id="beneficiary_act_cur_code" trim="true" uppercase="true" dojoType="dijit.form.ValidationTextBox" regExp="^[a-zA-Z]*$" class="xx-small inlineBlock inlineBlockNoLabel" maxLength="3">										
										<xsl:attribute name="value"><xsl:value-of select="counterparties/counterparty/counterparty_cur_code"/></xsl:attribute>
										<xsl:attribute name="displayedValue"><xsl:value-of select="counterparties/counterparty/counterparty_cur_code"/></xsl:attribute>
										<xsl:attribute name="readOnly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:attribute>
									</div>
								</div>
						   		<span class="content" style="padding-left: 8px;"><xsl:value-of select="counterparties/counterparty/counterparty_cur_code"/></span>
						   </xsl:otherwise>
						  </xsl:choose>
						 	<!-- Hidden fields to store information related to Beneficary Account Validation when product type is IAFT -->
						   <xsl:call-template name="hidden-field">
						    <xsl:with-param name="name">bo_account_id</xsl:with-param>
						   </xsl:call-template>
						   <xsl:call-template name="hidden-field">
						    <xsl:with-param name="name">bo_account_type</xsl:with-param>
						   </xsl:call-template>
						   <xsl:call-template name="hidden-field">
						    <xsl:with-param name="name">bo_account_currency</xsl:with-param>
						   </xsl:call-template>
						   <xsl:call-template name="hidden-field">
						    <xsl:with-param name="name">bo_branch_code</xsl:with-param>
						   </xsl:call-template>
						   <xsl:call-template name="hidden-field">
						    <xsl:with-param name="name">bo_product_type</xsl:with-param>
						   </xsl:call-template>    
				    	</div>	
				    </xsl:if>	
				  	    			        
			        <xsl:call-template name="input-field">
					    <xsl:with-param name="type">account</xsl:with-param>
					    <xsl:with-param name="name">beneficiary_account</xsl:with-param>	
					    <xsl:with-param name="maxsize">11</xsl:with-param>	
					    <xsl:with-param name="required">Y</xsl:with-param>	
					    <xsl:with-param name="appendClass">inlineBlock inlineBlockNoLabel</xsl:with-param>
					    <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_act_no"/></xsl:with-param>
					    <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>
				  	</xsl:call-template>	
				  	<!-- This Empty div is to show inline for IAFT product , used in JS -->				
				  	 <div class="CUR">
				  	 </div>			    
				  	<div id="pre_approved_row" class="field">
						<span class="label"/>
						<div id="PAB" class="content">
						   	 <xsl:attribute name="style">
						   	 <xsl:choose>
						   	 	<xsl:when test="pre_approved_status[.='Y']">display:inline</xsl:when>
						   	 	<xsl:otherwise>display:none</xsl:otherwise>
						   	 </xsl:choose>
						   	 </xsl:attribute>
							<xsl:value-of select="localization:getGTPString($language,'XSL_LEP_PAB')"/>
						</div> 
					</div>
			   </xsl:with-param>
			  </xsl:call-template>
			  <!-- column 2 -->		 
			  <xsl:call-template name="column-wrapper">
			   <xsl:with-param name="content">		   		
			   	<div class="IBG"> 			   	
       			 <xsl:call-template name="input-field">
			      	 <xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_BRANCH_CODE</xsl:with-param>
				     <xsl:with-param name="name">cpty_bank_code</xsl:with-param>
				     <xsl:with-param name="maxsize">4</xsl:with-param>	
				     <xsl:with-param name="fieldsize">xx-small</xsl:with-param>
                     <xsl:with-param name="appendClass">inlineBlock</xsl:with-param>	
                     <xsl:with-param name="value"><xsl:if test="sub_product_code = 'IBG'"><xsl:value-of select="counterparties/counterparty/cpty_bank_code"/></xsl:if></xsl:with-param>	
                     <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>	     			  
				 </xsl:call-template>	
				 <xsl:call-template name="input-field">
				     <xsl:with-param name="name">cpty_branch_code</xsl:with-param>	
			   		 <xsl:with-param name="maxsize">3</xsl:with-param>	
			   		 <xsl:with-param name="fieldsize">xx-small</xsl:with-param>
                     <xsl:with-param name="appendClass">inlineBlock inlineBlockNoLabel</xsl:with-param>
                     <xsl:with-param name="value"><xsl:if test="sub_product_code = 'IBG'"><xsl:value-of select="counterparties/counterparty/cpty_branch_code"/></xsl:if></xsl:with-param>
                     <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>
                 </xsl:call-template>	
                 <xsl:choose>
                 	<xsl:when test="bulk_ref_id[.!='']">
				     <xsl:if test="not($pre-approved_beneficiary_only) and $displaymode='edit'">	
						<xsl:call-template name="button-wrapper">
							<xsl:with-param name="show-image">Y</xsl:with-param>
							<xsl:with-param name="show-border">N</xsl:with-param>
							<xsl:with-param name="onclick">misys.showBankBranchCodeDialog('bank_branch_code', "['cpty_bank_code', 'cpty_branch_code', 'cpty_branch_name','cpty_bank_name']", '', '', '', '', 'width:710px;height:350px;', '<xsl:value-of select="localization:getGTPString($language, 'LIST_TITLE_SDATA_LIST_OF_BANKS')"/>',false);return false;</xsl:with-param>
							<xsl:with-param name="id">bank_img</xsl:with-param>
							<xsl:with-param name="non-dijit-button">N</xsl:with-param>
						</xsl:call-template>
	               	</xsl:if>	
	              </xsl:when> 
	              <xsl:otherwise>
	                 <xsl:if test="not($pre-approved_beneficiary_only) and $displaymode='edit'">	
						<xsl:call-template name="button-wrapper">
							<xsl:with-param name="show-image">Y</xsl:with-param>
							<xsl:with-param name="show-border">N</xsl:with-param>
							<xsl:with-param name="onclick">misys.showBankBranchCodeDialog('bank_branch_code', "['cpty_bank_code', 'cpty_branch_code', 'cpty_branch_name','cpty_bank_name']", '', '', 'N', '', 'width:710px;height:350px;', '<xsl:value-of select="localization:getGTPString($language, 'LIST_TITLE_SDATA_LIST_OF_BANKS')"/>',false);return false;</xsl:with-param>
							<xsl:with-param name="id">bank_img</xsl:with-param>
							<xsl:with-param name="non-dijit-button">N</xsl:with-param>
						</xsl:call-template>
	               	</xsl:if>	
	              </xsl:otherwise>
               	</xsl:choose>	
               	</div>
				<!-- todo: swift bic code lookup for MEPS -->
				<div class="MEPS">
				  <xsl:if test="not($pre-approved_beneficiary_only)">		
					<xsl:call-template name="input-field">
	                  <xsl:with-param name="label">XSL_SWIFT_BIC_CODE</xsl:with-param>
	                  <xsl:with-param name="name">cpty_bank_swift_bic_code</xsl:with-param>
	                  <xsl:with-param name="size">11</xsl:with-param>
	                  <xsl:with-param name="maxsize">11</xsl:with-param>
	                  <xsl:with-param name="fieldsize">small</xsl:with-param>
	                  <xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
	                  <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>
	                </xsl:call-template>
	               </xsl:if>
	               <xsl:if test="$displaymode= 'edit'">
	                <xsl:call-template name="button-wrapper">
                      <xsl:with-param name="show-image">Y</xsl:with-param>
                      <xsl:with-param name="show-border">N</xsl:with-param>
                      <xsl:with-param name="onclick">misys.showListOfBanks();return false;</xsl:with-param>
                      <xsl:with-param name="id">bank_iso_img</xsl:with-param>
                      <xsl:with-param name="non-dijit-button">N</xsl:with-param>
                    </xsl:call-template>
                    </xsl:if>
	           </div>
				<!-- common for IBG and MEPS -->
				<div class="IBG MEPS">
				  <xsl:call-template name="input-field">
				    <xsl:with-param name="label">XSL_BENEFICIARY_BANK_NAME_WITH_ADDRESS</xsl:with-param>
				    <xsl:with-param name="name">cpty_bank_name</xsl:with-param>
				    <xsl:with-param name="fieldsize">medium</xsl:with-param>		
				    <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>		  
				  	<xsl:with-param name="swift-validate">N</xsl:with-param>
				  </xsl:call-template>
				</div> 
				<div class="IBG">  
		      	  <xsl:call-template name="input-field">
				    <xsl:with-param name="label">XSL_PARTIESDETAILS_BRANCH_NAME</xsl:with-param>
				    <xsl:with-param name="name">cpty_branch_name</xsl:with-param>	
				    <xsl:with-param name="fieldsize">medium</xsl:with-param>		
				    <xsl:with-param name="readonly"><xsl:if test="$pre-approved_beneficiary_only or pre_approved_status ='Y'">Y</xsl:if></xsl:with-param>		  
				  	<xsl:with-param name="swift-validate">N</xsl:with-param>
				  </xsl:call-template>
				</div>			
			    <div class="MEPS">		
					<xsl:call-template name="input-field">
					    <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
					    <xsl:with-param name="name">cpty_bank_address_line_1</xsl:with-param>
					    <xsl:with-param name="value"><xsl:if test="sub_product_code = 'MEPS'"><xsl:value-of select="counterparties/counterparty/cpty_bank_address_line_1"/></xsl:if></xsl:with-param>
					    <xsl:with-param name="readonly">Y</xsl:with-param>		
				   </xsl:call-template>
				   <xsl:call-template name="input-field">
					    <xsl:with-param name="name">cpty_bank_address_line_2</xsl:with-param>
					    <xsl:with-param name="value"><xsl:if test="sub_product_code = 'MEPS'"><xsl:value-of select="counterparties/counterparty/cpty_bank_address_line_2"/></xsl:if></xsl:with-param>
					    <xsl:with-param name="readonly">Y</xsl:with-param>		   				     
				   </xsl:call-template>
				   <xsl:call-template name="input-field">
					    <xsl:with-param name="name">cpty_bank_dom</xsl:with-param>		
					    <xsl:with-param name="value"><xsl:if test="sub_product_code = 'MEPS'"><xsl:value-of select="counterparties/counterparty/cpty_bank_dom"/></xsl:if></xsl:with-param>			   
					    <xsl:with-param name="readonly">Y</xsl:with-param>		     		     
				   </xsl:call-template>
				   <xsl:call-template name="hidden-field">
					    <xsl:with-param name="name">cpty_bank_country</xsl:with-param>		
					    <xsl:with-param name="value"><xsl:if test="sub_product_code = 'MEPS'"><xsl:value-of select="counterparties/counterparty/cpty_bank_country"/></xsl:if></xsl:with-param>			   
				   </xsl:call-template>
   			    </div>		
			   </xsl:with-param>
			  </xsl:call-template>
			 </xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">bk_sub_product_code</xsl:with-param>
		    </xsl:call-template>
		  </xsl:with-param>
		</xsl:call-template>
	</xsl:template>
    
  <xsl:template name="lep-transaction-details">	 	
	<xsl:call-template name="fieldset-wrapper">
	   <xsl:with-param name="legend">XSL_HEADER_TRANSACTION_DETAILS</xsl:with-param>
	     <xsl:with-param name="content">
		  <xsl:call-template name="column-container">
	 	   <xsl:with-param name="content">
	 	    <xsl:call-template name="column-wrapper">
	    	 <xsl:with-param name="content">
			    <!-- LEP Transaction Amount Field -->
			   <xsl:if test="not(amount_access) or  (amount_access[.='true'])  ">
				    <xsl:call-template name="currency-field">
				      	<xsl:with-param name="label">XSL_AMOUNTDETAILS_TRANSFER</xsl:with-param>
					   	<xsl:with-param name="product-code">ft</xsl:with-param>
					   	<xsl:with-param name="required">Y</xsl:with-param>
					   	<xsl:with-param name="currency-readonly">
					   	<xsl:choose>
					   		<xsl:when test="bulk_ref_id[.!='']">Y</xsl:when>
					   		<xsl:otherwise>N</xsl:otherwise>
					   	</xsl:choose>				   		
					   	</xsl:with-param>
					   	<xsl:with-param name="show-button">
					   	<xsl:choose>
					   		<xsl:when test="bulk_ref_id[.!='']">N</xsl:when>
					   		<xsl:otherwise>Y</xsl:otherwise>
					   	</xsl:choose>
					   	</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
		    	<xsl:call-template name="input-field">
	     			<xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>	
		    		<xsl:with-param name="name">cust_ref_id</xsl:with-param>
	   				<xsl:with-param name="size">16</xsl:with-param>
	   				<xsl:with-param name="maxsize">64</xsl:with-param>
	   				<xsl:with-param name="fieldsize">small</xsl:with-param>
	   			</xsl:call-template>
	   			<xsl:if test="bulk_ref_id[.!=''] and sub_product_code [.='IBG' or .='IBGEX']">
				<xsl:call-template name="input-field">
				    <xsl:with-param name="label">XSL_BK_PARTICULARS</xsl:with-param>
				    <xsl:with-param name="name">bk_particular</xsl:with-param>
				    <xsl:with-param name="fieldsize">small</xsl:with-param>
				    <xsl:with-param name="size">12</xsl:with-param>
	   				<xsl:with-param name="maxsize">12</xsl:with-param>	
				</xsl:call-template> 
				</xsl:if>
				<!-- Verifying amount access from bulk -->
	   			<xsl:if test="not(amount_access) or  (amount_access[.='true'])  ">				   				    						   				    		
				<div class="MEPS">
				    <xsl:call-template name="textarea-field">	
				       	<xsl:with-param name="label">XSL_GENERALDETAILS_PAYMENT_DETAILS</xsl:with-param>	
				        <xsl:with-param name="name">narrative_additional_instructions</xsl:with-param>
				        <xsl:with-param name="cols">35</xsl:with-param>			     
				        <xsl:with-param name="rows">4</xsl:with-param>
				        <xsl:with-param name="maxlines">4</xsl:with-param>	
				        <xsl:with-param name="swift-validate">Y</xsl:with-param>
		    		</xsl:call-template>
	    		</div>
	    		</xsl:if>
	    		<xsl:call-template name="hidden-field">
			      <xsl:with-param name="name">fx_rates_type_temp</xsl:with-param>
			      <xsl:with-param name="value"><xsl:value-of select="fx_rates_type"></xsl:value-of></xsl:with-param>
			     </xsl:call-template>
			     <xsl:call-template name="hidden-field">
			      <xsl:with-param name="name">fx_master_currency</xsl:with-param>
			     <xsl:with-param name="value"><xsl:value-of select="fx_contract_nbr_cur_code_1"></xsl:value-of></xsl:with-param>
			    </xsl:call-template>			       	
		 	 </xsl:with-param>
		   </xsl:call-template>	
	    <xsl:call-template name="column-wrapper">
    	 <xsl:with-param name="content">
	    	<div id="transfer_date_div">
	    	 	<xsl:choose>
			      	<xsl:when test="$displaymode='edit' and bulk_ref_id[.='']">
						<xsl:call-template name="business-date-field">
						    <xsl:with-param name="label">XSL_GENERALDETAILS_TRANSFER_DATE</xsl:with-param>
						    <xsl:with-param name="name">iss_date</xsl:with-param>
						    <xsl:with-param name="size">10</xsl:with-param>
						    <xsl:with-param name="maxsize">10</xsl:with-param>
						    <xsl:with-param name="required">Y</xsl:with-param>
						    <xsl:with-param name="fieldsize">small</xsl:with-param>
						    <xsl:with-param name="sub-product-code-widget-id">sub_product_code_custom</xsl:with-param>
						     <xsl:with-param name="bank-abbv-name-widget-id">issuing_bank_abbv_name</xsl:with-param>
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
						<xsl:call-template name="hidden-field">
					      <xsl:with-param name="name">sub_product_code_custom</xsl:with-param>
					    </xsl:call-template>
					</xsl:when>
					<xsl:when test="$displaymode='view'">				
						<xsl:if test="recurring_payment_enabled[.='N']">
							<xsl:call-template name="business-date-field">
							    <xsl:with-param name="label">XSL_GENERALDETAILS_TRANSFER_DATE</xsl:with-param>
							    <xsl:with-param name="name">iss_date</xsl:with-param>
							    <xsl:with-param name="size">10</xsl:with-param>
							    <xsl:with-param name="maxsize">10</xsl:with-param>
							    <xsl:with-param name="required">Y</xsl:with-param>
							    <xsl:with-param name="fieldsize">small</xsl:with-param>
							    <xsl:with-param name="sub-product-code-widget-id">sub_product_code_custom</xsl:with-param>
							     <xsl:with-param name="bank-abbv-name-widget-id">issuing_bank_abbv_name</xsl:with-param>
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
							<xsl:call-template name="hidden-field">
						      <xsl:with-param name="name">sub_product_code_custom</xsl:with-param>
						    </xsl:call-template>					
						</xsl:if>
					</xsl:when>
				</xsl:choose>	
			</div>
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
				<xsl:with-param name="name">applicant_act_cur_code_unsigned</xsl:with-param>
		     	<xsl:with-param name="value" select="applicant_act_cur_code"></xsl:with-param>
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
				<xsl:with-param name="name">base_cur_code</xsl:with-param>
			    <xsl:with-param name="value" select="base_cur_code"></xsl:with-param>
			</xsl:call-template>
			<!-- Verifying amount access from bulk -->
	   		<xsl:if test="not(amount_access) or  (amount_access[.='true'])  ">
			<div class="IAFT IBG">
		    	<xsl:call-template name="input-field">
	    			<xsl:with-param name="label">XSL_GENERALDETAILS_BEN_REF</xsl:with-param>	
	    			<xsl:with-param name="name">beneficiary_reference</xsl:with-param>
	    			<xsl:with-param name="size">
		    			<xsl:choose>
			  		       <xsl:when test="sub_product_code[.='IBG']">12</xsl:when>
			  		        <xsl:otherwise>19</xsl:otherwise>
			  		     </xsl:choose>
	    			</xsl:with-param>
	    			<xsl:with-param name="maxsize">
		    			<xsl:choose>
			  		       <xsl:when test="sub_product_code[.='IBG']">12</xsl:when>
			  		        <xsl:otherwise>19</xsl:otherwise>
			  		     </xsl:choose>
	    			</xsl:with-param>
	  				<xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_reference"/></xsl:with-param>
	  				<xsl:with-param name="fieldsize">small</xsl:with-param>
		  		</xsl:call-template>
		  	    <xsl:if test="bulk_ref_id[.!='']">
		  		 <xsl:variable name="transactionCodeRequired">
		  		    <xsl:choose>
		  		       <xsl:when test="sub_product_code[.='IBGEX'] or sub_product_code[.='IBG']">
		  		            <xsl:value-of select="'Y'"></xsl:value-of>
		  		       </xsl:when>
		  		       <xsl:otherwise>
		  		        	<xsl:value-of select="'N'"></xsl:value-of>
		  		       </xsl:otherwise>
		  		    </xsl:choose>
		  		 </xsl:variable>
		    	 <xsl:call-template name="select-field">
								      	<xsl:with-param name="label">XSL_BK_TRANSACTION_CODE</xsl:with-param>
								      	<xsl:with-param name="name">bk_transaction_code</xsl:with-param>
								      	<xsl:with-param name="fieldsize">medium</xsl:with-param>
								      	<xsl:with-param name="required"><xsl:value-of select="$transactionCodeRequired"/></xsl:with-param>
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
		  	</div>
		  </xsl:if>
	    </xsl:with-param>
	   </xsl:call-template>
	  </xsl:with-param>
	 </xsl:call-template>
 	</xsl:with-param>
   </xsl:call-template>				
  </xsl:template>
</xsl:stylesheet>