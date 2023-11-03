<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for the details of Invoice trade messages, customer side.

Copyright (c) 2000-2011 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      07/09/12
author:    Raja Rao
email:     raja.rao@misys.com

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
       	xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools"
		exclude-result-prefixes="localization securitycheck convertTools">
		
  <!-- 
   TRADE MESSAGE TNX FORM TEMPLATE.
  -->
  <xsl:template match="in_tnx_record | ip_tnx_record">
  
   <xsl:variable name="product-code"><xsl:value-of select="product_code"/></xsl:variable>
   <!-- Lower case product code -->
   <xsl:variable name="lowercase-product-code">
    <xsl:value-of select="translate($product-code,$up,$lo)"/>
   </xsl:variable>

   <xsl:variable name="screen-name">
    <xsl:choose>
     <xsl:when test="product_code[.='IN']">InvoiceScreen</xsl:when>
     <xsl:when test="product_code[.='IP']">InvoicePayableScreen</xsl:when>
    </xsl:choose>
   </xsl:variable>
   <xsl:variable name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$screen-name"/></xsl:variable>

   <!-- Preloader  -->
   <xsl:call-template name="loading-message"/>

   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>

    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
      <!--  Display common menu. -->
      <xsl:call-template name="menu">
       <xsl:with-param name="node-name" select="name(.)"/>
       <xsl:with-param name="screen-name" select="$screen-name"/>
       <xsl:with-param name="show-template">N</xsl:with-param>
       <xsl:with-param name="show-return">Y</xsl:with-param>
      </xsl:call-template>
      
      <!-- Disclaimer Notice -->
      <xsl:call-template name="disclaimer"/>
      
      <!-- Reauthentication -->	
			 	<xsl:call-template name="server-message">
			 		<xsl:with-param name="name">server_message</xsl:with-param>
			 		<xsl:with-param name="content"><xsl:value-of select="message"/></xsl:with-param>
			 		<xsl:with-param name="appendClass">serverMessage</xsl:with-param>
				</xsl:call-template>
	  <xsl:call-template name="reauthentication" />
    
      <xsl:call-template name="hidden-fields">
       <xsl:with-param name="lowercase-product-code" select="$lowercase-product-code"/>
      </xsl:call-template>
      
      <!-- Hidden cross references -->
      <xsl:apply-templates select="cross_references" mode="display_form"/>
      
      <xsl:call-template name="message-general-details">
      	<xsl:with-param name="additional-details">
      		<xsl:if test="product_code[.='IP']">
      		<xsl:call-template name="input-field">
			     <xsl:with-param name="label">XSL_IP_SELLER_NAME_LABEL</xsl:with-param>
			     <xsl:with-param name="name">seller_name</xsl:with-param>
			     <xsl:with-param name="size">35</xsl:with-param>
			     <xsl:with-param name="maxsize">35</xsl:with-param>
			     <xsl:with-param name="required">Y</xsl:with-param>
			     <xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
      		<xsl:call-template name="input-field">
				 <xsl:with-param name="label">XSL_GENERALDETAILS_INVOICE_DATE</xsl:with-param>
				 <xsl:with-param name="name">iss_date1</xsl:with-param>
				 <xsl:with-param name="value"><xsl:value-of select="iss_date"/></xsl:with-param>
				 <xsl:with-param name="type">date</xsl:with-param>
				 <xsl:with-param name="required">Y</xsl:with-param>
				 <xsl:with-param name="fieldsize">small</xsl:with-param>
				 <xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
		    <xsl:if test="product_code[.='IP']">
		  	<xsl:call-template name="input-field">
				 <xsl:with-param name="label">XSL_GENERALDETAILS_DUE_DATE</xsl:with-param>
				 <xsl:with-param name="name">due_date1</xsl:with-param>
				 <xsl:with-param name="value"><xsl:value-of select="due_date"/></xsl:with-param>
				 <xsl:with-param name="type">date</xsl:with-param>
				 <xsl:with-param name="required">Y</xsl:with-param>
				 <xsl:with-param name="fieldsize">small</xsl:with-param>
				 <xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
		    </xsl:if>
	      	<xsl:call-template name="input-field">
			     <xsl:with-param name="label">XSL_GENERALDETAILS_INVOICE_REFERENCE</xsl:with-param>
			     <xsl:with-param name="name">issuer_ref_id</xsl:with-param>
			     <xsl:with-param name="size">35</xsl:with-param>
			     <xsl:with-param name="maxsize">64</xsl:with-param>
			     <xsl:with-param name="required">Y</xsl:with-param>
			     <xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
			<div id="request_amount_div">
			<xsl:call-template name="currency-field"> 
				<xsl:with-param name="label">
					<xsl:choose>
					<xsl:when test="sub_tnx_type_code[.='72' or .='73']">XSL_GENERALDETAILS_IN_INVOICE_AMOUNT</xsl:when>
					<xsl:otherwise>XSL_GENERALDETAILS_IN_INVOICE_AMOUNT</xsl:otherwise>
					</xsl:choose>
   				</xsl:with-param>
      			<xsl:with-param name="product-code">tnx</xsl:with-param>
      			<xsl:with-param name="show-amt">Y</xsl:with-param>
      			<xsl:with-param name="override-currency-value"><xsl:value-of select="total_net_cur_code"/></xsl:with-param>
      			<xsl:with-param name="override-amt-value">
      				<xsl:choose>
		    			<xsl:when test="tnx_amt[.='']"><xsl:value-of select="total_net_amt"/></xsl:when>
		    			<xsl:otherwise><xsl:value-of select="tnx_amt"/></xsl:otherwise>
		    		</xsl:choose>
      			</xsl:with-param>
      			<xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
      			<xsl:with-param name="swift-validate">N</xsl:with-param>
      			<xsl:with-param name="currency-readonly">Y</xsl:with-param>
      			<xsl:with-param name="show-button">N</xsl:with-param>
      			<xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
      			<xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
    		</xsl:call-template>
    		
    		<xsl:if test="product_code ='IP' and $displaymode='view'">
    			<xsl:call-template name="input-field">
			    <xsl:with-param name="label">XSL_REPORTINGDETAILS_PROD_STAT_LABEL</xsl:with-param>
			    <xsl:with-param name="override-displaymode">view</xsl:with-param>
			    <xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N005', prod_stat_code[.])"/></xsl:with-param>
			</xsl:call-template>
    		</xsl:if>
    		 <!-- Financial Eligibility Status for Approved Financing Invoices  -->
        <xsl:if test="product_code ='IN'">
         <xsl:variable name="eligibility_flag">
         	<xsl:value-of select="eligibility_flag"/>
         </xsl:variable>
          <xsl:variable name="org_eligibility_flag">
         	<xsl:value-of select="org_eligibility_flag"/>
         </xsl:variable>
         <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_REPORTINGDETAILS_ELIGIBILITY_STATUS_LABEL</xsl:with-param>
           <xsl:with-param name="id">eligibility_flag_content</xsl:with-param>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
           <xsl:with-param name="content">
             <div class="content" id = "eligibility_content">
            	<xsl:value-of select="localization:getDecode($language, 'N085',$eligibility_flag)"/>
            </div>
           </xsl:with-param>
          </xsl:call-template>
        
         <xsl:call-template name="hidden-field">
	         <xsl:with-param name="name">org_eligibility_flag</xsl:with-param>
	         <xsl:with-param name="value"><xsl:value-of select="org_eligibility_flag"/></xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="hidden-field">
	         <xsl:with-param name="id">org_eligibility_content</xsl:with-param>
	         <xsl:with-param name="value">
	         	<xsl:if test="$org_eligibility_flag != ''">
	         		<xsl:value-of select="localization:getDecode($language, 'N085',$org_eligibility_flag)"/>
	         	</xsl:if>
	         </xsl:with-param>
         </xsl:call-template>
        </xsl:if>
        
         <!-- Financial Eligibility Status for APF - Buyer/Seller Upload Invoices  -->
        <xsl:if test="product_code ='IP'">
         <xsl:variable name="eligibility_flag">
         	<xsl:value-of select="eligibility_flag"/>
         </xsl:variable>
          <xsl:variable name="org_eligibility_flag">
         	<xsl:value-of select="org_eligibility_flag"/>
         </xsl:variable>
         <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_REPORTINGDETAILS_ELIGIBILITY_STATUS_LABEL</xsl:with-param>
           <xsl:with-param name="id">eligibility_flag_content</xsl:with-param>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
           <xsl:with-param name="content">
             <div class="content" id = "eligibility_content">
            	<xsl:value-of select="localization:getDecode($language, 'N085',$eligibility_flag)"/>
            </div>
           </xsl:with-param>
          </xsl:call-template>
        
         <xsl:call-template name="hidden-field">
	         <xsl:with-param name="name">org_eligibility_flag</xsl:with-param>
	         <xsl:with-param name="value"><xsl:value-of select="org_eligibility_flag"/></xsl:with-param>
         </xsl:call-template>
         <xsl:call-template name="hidden-field">
	         <xsl:with-param name="id">org_eligibility_content</xsl:with-param>
	         <xsl:with-param name="value">
	         	<xsl:if test="$org_eligibility_flag != ''">
	         		<xsl:value-of select="localization:getDecode($language, 'N085',$org_eligibility_flag)"/>
	         	</xsl:if>
	         </xsl:with-param>
         </xsl:call-template>
        </xsl:if>
    </div>
			<xsl:if test="(product_code ='IN' and eligibility_flag='E' and action_req_code!='07')">
				<xsl:call-template name="checkbox-field">
	     			<xsl:with-param name="label">XSL_GENERALDETAILS_IN_FINANCE_OFFER_FLAG</xsl:with-param>
	     			<xsl:with-param name="name">finance_offer_flag</xsl:with-param>     
	   			</xsl:call-template>    		
    		</xsl:if>
    		
    		<xsl:if test="(product_code ='IP' and eligibility_flag='E')">
				<xsl:call-template name="checkbox-field">
	     			<xsl:with-param name="label">XSL_GENERALDETAILS_IN_FINANCE_OFFER_FLAG</xsl:with-param>
	     			<xsl:with-param name="name">finance_offer_flag</xsl:with-param>     
	   			</xsl:call-template>    		
    		</xsl:if>
			<xsl:call-template name="hidden-field">
		      <xsl:with-param name="name">tnx_amt</xsl:with-param>  
		      <xsl:with-param name="value">
			      <xsl:choose>
			    	<xsl:when test="tnx_amt[.='']"><xsl:value-of select="total_net_amt"/></xsl:when>
			    	<xsl:otherwise><xsl:value-of select="tnx_amt"/></xsl:otherwise>
			      </xsl:choose>
		    </xsl:with-param>
		    </xsl:call-template>
		    <xsl:call-template name="hidden-field">
		      <xsl:with-param name="name">tnx_cur_code</xsl:with-param>
		      <xsl:with-param name="value">
			      <xsl:choose>
			    	<xsl:when test="tnx_cur_code[.='']"><xsl:value-of select="total_net_cur_code"/></xsl:when>
			    	<xsl:otherwise><xsl:value-of select="tnx_cur_code"/></xsl:otherwise>
			      </xsl:choose>
		   	  </xsl:with-param>
		    </xsl:call-template>
		    <!-- Programme conditions -->
			<xsl:call-template name="hidden-field">
		      <xsl:with-param name="name">conditions</xsl:with-param>
		      <xsl:with-param name="value"><xsl:value-of select="conditions" /></xsl:with-param>
		    </xsl:call-template>
		   <xsl:if test="sub_tnx_type_code[.='72' or .='73'] or product_code='IP'" >
			<xsl:choose>
		     	<xsl:when test="$mode = 'DRAFT'">
		     		<xsl:call-template name="multichoice-field">
				    	<xsl:with-param name="label">
				    		<xsl:choose>
								<xsl:when test="product_code='IP'">XSL_GENERALDETAILS_IP_CHOICE_YES_PRESENTATION</xsl:when>
				    		</xsl:choose>
				    	</xsl:with-param>
				    	<xsl:with-param name="id">request_yes</xsl:with-param>
				    	<xsl:with-param name="name">request</xsl:with-param>
				    	<xsl:with-param name="type">radiobutton</xsl:with-param>
				    	<xsl:with-param name="checked">
				    		<xsl:choose>
				    			<xsl:when test="sub_tnx_type_code='73'">N</xsl:when>
				    			<xsl:otherwise>Y</xsl:otherwise>
				    		</xsl:choose>
				    	</xsl:with-param>
				    	<xsl:with-param name="value">
				    		<xsl:choose>
				    			<xsl:when test="sub_tnx_type_code[.='72' or .='73']">72</xsl:when>
				    			<xsl:otherwise></xsl:otherwise>
				    		</xsl:choose>
				    	</xsl:with-param>
				    	<xsl:with-param name="appendClass">fscmMultiChoiceField</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="sub_tnx_type_code[.='72' or .='73'] or product_code ='IP'">
					<xsl:call-template name="multichoice-field">
				    	<xsl:with-param name="label">
				    		<xsl:choose>
								<xsl:when test="product_code[.='IP']">XSL_GENERALDETAILS_IP_CHOICE_NO_PRESENTATION</xsl:when>
				    			<xsl:when test="product_code[.='IN']">XSL_GENERALDETAILS_IN_CHOICE_NO_FINANCE</xsl:when>
				    		</xsl:choose>
				    	</xsl:with-param>
				    	<xsl:with-param name="name">request</xsl:with-param>
				    	<xsl:with-param name="id">request_no</xsl:with-param>
				    	<xsl:with-param name="type">radiobutton</xsl:with-param>
				    	<xsl:with-param name="checked">
				    		<xsl:choose>
				    			<xsl:when test="sub_tnx_type_code='73'">Y</xsl:when>
				    			<xsl:otherwise>N</xsl:otherwise>
				    		</xsl:choose>
				    	</xsl:with-param>
				    	<xsl:with-param name="value">
				    		<xsl:choose>
				    			<xsl:when test="sub_tnx_type_code[.='72' or .='73']">73</xsl:when>
				    			<xsl:otherwise></xsl:otherwise>
				    		</xsl:choose>
				    	</xsl:with-param>
				    	<xsl:with-param name="appendClass">fscmMultiChoiceField</xsl:with-param>
					</xsl:call-template>
					</xsl:if>
		     	</xsl:when>
		     </xsl:choose>
		   </xsl:if>  
		   <xsl:if test="action_req_code[.!='07']">
			<xsl:call-template name="hidden-field">
			      <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>		      
			    </xsl:call-template> 
		 </xsl:if>
		
		     <xsl:call-template name="hidden-field">
			      <xsl:with-param name="name">action_req_code</xsl:with-param>		      
			 </xsl:call-template> 
		
		 
		    <xsl:call-template name="hidden-field">
		      <xsl:with-param name="name">prod_stat_code</xsl:with-param>
		      	<xsl:with-param name="value">
			      	<xsl:choose>	
	    				<xsl:when test="product_code[.='IP'] and sub_tnx_type_code[.='72']">48</xsl:when>
		    			<xsl:when test="product_code[.='IP'] and sub_tnx_type_code[.='73']">49</xsl:when>
			    	</xsl:choose>
		    	</xsl:with-param>
		    </xsl:call-template>

		     <xsl:if test="action_req_code[.='07']">
		     <xsl:if test="finance_offer_flag='Y'">
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_GENERALDETAILS_IN_FINANCE_OFFER_FLAG_LABEL</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language,'N034_Y')"/></xsl:with-param>
	     			<xsl:with-param name="override-displaymode">view</xsl:with-param>
			   	</xsl:call-template>
			</xsl:if>
			  <xsl:call-template name="select-field">
			     <xsl:with-param name="label">XSL_GENERALDETAILS_CUSTOMER_RESPONSE</xsl:with-param>
			     <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
			     <xsl:with-param name="required">Y</xsl:with-param>
			     <xsl:with-param name="options">
			      <xsl:choose>
				    <xsl:when test="$displaymode='edit'">				      
					    <option value="91">
						    <xsl:value-of select="localization:getGTPString($language, 'XSL_IO_YES')"/>
					    </option>
					   <option value="92">
					        <xsl:value-of select="localization:getGTPString($language, 'XSL_IO_NO')"/>
					   </option>
				    </xsl:when>
			   	  </xsl:choose>
			     </xsl:with-param>
			  </xsl:call-template>
 	    </xsl:if>
		    <br/>
		    <div id="conditions_div">
		    	<xsl:if test="prod_stat_code[.!='60' and .!='53' and .!='49']">
				    <xsl:call-template name="fieldset-wrapper">
				   		<xsl:with-param name="legend">XSL_HEADER_OPTIONAL_PROGRAMME_CONDITIONS</xsl:with-param>
				   		<xsl:with-param name="content">
						    <xsl:call-template name="string_replace">
					        	<xsl:with-param name="input_text" select="conditions"/>
					        </xsl:call-template>
				   		</xsl:with-param>
				   	</xsl:call-template>
			   	</xsl:if>
		   	</div>
		   	
   	
		   	<xsl:call-template name="message-freeformat"/>
		   	<xsl:call-template name="comments-for-return">
				<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
				<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
   	  		</xsl:call-template>
      	</xsl:with-param>
      </xsl:call-template>
      
    </xsl:with-param>
    </xsl:call-template>
    
     <!-- Form #1 : Attach Files -->
     <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
    	<xsl:call-template name="attachments-file-dojo"/>
    </xsl:if>
   
    <!-- Message realform. -->
    <xsl:call-template name="realform">
     <xsl:with-param name="action" select="$action"/>
    </xsl:call-template>
  
    <xsl:call-template name="menu">
     <xsl:with-param name="node-name" select="name(.)"/>
     <xsl:with-param name="screen-name" select="$screen-name"/>
     <xsl:with-param name="show-template">N</xsl:with-param>
     <xsl:with-param name="second-menu">Y</xsl:with-param>
     <xsl:with-param name="show-return">Y</xsl:with-param>
    </xsl:call-template>
   </div>
    
   <!-- Table of Contents -->
   <xsl:call-template name="toc"/>
   
   <!--  Collaboration Window -->     
   <xsl:call-template name="collaboration">
    <xsl:with-param name="editable">true</xsl:with-param>
    <xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>
    <xsl:with-param name="contextPath"><xsl:value-of select="$contextPath"/></xsl:with-param>
    <xsl:with-param name="bank_name_widget_id">issuing_bank_name</xsl:with-param>
	<xsl:with-param name="bank_abbv_name_widget_id">issuing_bank_abbv_name</xsl:with-param>
   </xsl:call-template>

   <!-- Javascript and Dojo imports  -->
   <xsl:call-template name="js-imports">
    <xsl:with-param name="product-code"><xsl:value-of select="$product-code"/></xsl:with-param>
    <xsl:with-param name="lowercase-product-code"><xsl:value-of select="$lowercase-product-code"/></xsl:with-param>
    <xsl:with-param name="action"><xsl:value-of select="$action"/></xsl:with-param>
   </xsl:call-template>
  </xsl:template>

  <!--                                     -->  
  <!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
  <!--                                     -->



  <!-- Additional hidden fields for this form are  -->
  <!-- added here. -->
  <xsl:template name="hidden-fields">
   <xsl:param name="lowercase-product-code"/>
   <xsl:call-template name="common-hidden-fields">
    <xsl:with-param name="show-type">N</xsl:with-param>
    <xsl:with-param name="show-tnx-amt">N</xsl:with-param>
    <xsl:with-param name="additional-fields">
    <xsl:if test="entity and entity[. != '']">
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">entity</xsl:with-param>
     </xsl:call-template>
     </xsl:if>
     
      <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">eligibility_flag</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
     	 <xsl:with-param name="name">product_code</xsl:with-param>
     	 <xsl:with-param name="value"><xsl:value-of select="product_code"/></xsl:with-param>
     </xsl:call-template> 
     <xsl:call-template name="hidden-field">
				<xsl:with-param name="name">liab_total_amt</xsl:with-param>	
				<xsl:with-param name="value"><xsl:value-of select="liab_total_amt"/></xsl:with-param>			
	</xsl:call-template>
	  <xsl:call-template name="hidden-field">
				<xsl:with-param name="name">sub_product_code</xsl:with-param>	
				<xsl:with-param name="value"><xsl:value-of select="sub_product_code"/></xsl:with-param>			
	</xsl:call-template>
  	<xsl:call-template name="hidden-field">
     	 <xsl:with-param name="name">access_opened</xsl:with-param>
     	 <xsl:with-param name="value"><xsl:value-of select="access_opened"/></xsl:with-param>
    </xsl:call-template> 
    
	    <xsl:call-template name="hidden-field">
	     	 <xsl:with-param name="name">public_task_details_counterparty_assignee_name_hidden</xsl:with-param>
	     	 <xsl:with-param name="value">
	     	  <xsl:choose>
	     	 	 <xsl:when test="product_code ='IN'"><xsl:value-of select="seller_name"/></xsl:when>
	     	 	 <xsl:when test="product_code ='IP'"><xsl:value-of select="buyer_name"/></xsl:when>
	     	 	</xsl:choose>
	     	 	</xsl:with-param>
	    </xsl:call-template>
	    
	     <xsl:call-template name="hidden-field">
	     	 <xsl:with-param name="name">counterparty_email_id_hidden</xsl:with-param>
    	</xsl:call-template>  
     <xsl:call-template name="hidden-field">
	     	<xsl:with-param name="name">transaction_counterparty_email</xsl:with-param>
			<xsl:with-param name="value">
	     	 	<xsl:choose>
	     	 	 <xsl:when test="counter_party_email"><xsl:value-of select="counter_party_email"/></xsl:when>
	     	 	 <xsl:when test="transaction_counterparty_email"><xsl:value-of select="transaction_counterparty_email"/></xsl:when>
	     	 	</xsl:choose>
	     	 </xsl:with-param>
    	</xsl:call-template> 
     
      <xsl:call-template name="hidden-field">
     	 <xsl:with-param name="name">public_task_details_counterparty_assignee_abbv_name_nosend</xsl:with-param>
     	 <xsl:with-param name="value">
	     	 <xsl:choose>
	     	 	 <xsl:when test="product_code ='IN'"><xsl:value-of select="seller_abbv_name"/></xsl:when>
	     	 	 <xsl:when test="product_code ='IP'"><xsl:value-of select="ben_comp_abbv_name"/></xsl:when>
	     	 </xsl:choose>
     	 </xsl:with-param>
    	</xsl:call-template> 
    	
    	<xsl:call-template name="hidden-field">
     	 <xsl:with-param name="name">productCode</xsl:with-param>
     	 <xsl:with-param name="value"><xsl:value-of select="product_code"/></xsl:with-param>
   		</xsl:call-template> 
   		
   		 <xsl:call-template name="hidden-field">
     	 <xsl:with-param name="name">seller_name</xsl:with-param>
     	 <xsl:with-param name="value"><xsl:value-of select="seller_name"/></xsl:with-param>
    </xsl:call-template> 
    
     <xsl:call-template name="hidden-field">
     	 <xsl:with-param name="name">buyer_name</xsl:with-param>
     	 <xsl:with-param name="value"><xsl:value-of select="buyer_name"/></xsl:with-param>
    </xsl:call-template> 

   
      <xsl:call-template name="hidden-field">
     	 <xsl:with-param name="name">ben_company_abbv_name</xsl:with-param>
     	  <xsl:with-param name="value"><xsl:value-of select="ben_company_abbv_name"/></xsl:with-param>
    </xsl:call-template> 
    <xsl:call-template name="hidden-field">
     	 <xsl:with-param name="name">issuing_bank_name</xsl:with-param>
     	  <xsl:with-param name="value"><xsl:value-of select="issuing_bank/name"/></xsl:with-param>
    </xsl:call-template> 
    <xsl:call-template name="hidden-field">
     	 <xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
     	  <xsl:with-param name="value"><xsl:value-of select="issuing_bank/abbv_name"/></xsl:with-param>
    </xsl:call-template> 
    <!--  <xsl:call-template name="hidden-field">
     	 <xsl:with-param name="name">public_task_details_counterparty_assignee_name_nosend_img</xsl:with-param>
    </xsl:call-template> -->
   </xsl:with-param>
   </xsl:call-template>
  </xsl:template>

  <!--
   Hidden fields for Message
   -->
  <xsl:template name="realform">
   <xsl:param name="action"/>
   <xsl:call-template name="form-wrapper">
    <xsl:with-param name="name">realform</xsl:with-param>
    <xsl:with-param name="method">POST</xsl:with-param>
    <xsl:with-param name="action" select="$action"/>
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
       <xsl:with-param name="value">13</xsl:with-param>
      </xsl:call-template>
      <xsl:if test="product_code[.='IP'] and sub_tnx_type_code[.='72' or .='73']">
      	<xsl:choose>
   			<xsl:when test="subtnxtype[.='']">
	   			<xsl:call-template name="hidden-field">
		   			<xsl:with-param name="name">subtnxtype</xsl:with-param>
	   				<xsl:with-param name="value"/>
	   			</xsl:call-template>	
   			</xsl:when>
   			<xsl:otherwise>
   				<xsl:call-template name="hidden-field">
		   			<xsl:with-param name="name">subtnxtype</xsl:with-param>
   					<xsl:with-param name="value" select="sub_tnx_type_code"/>
   				</xsl:call-template>		
   			</xsl:otherwise>
   		</xsl:choose>
	  </xsl:if>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">attIds</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:if test="((product_code[.='IC'] or product_code[.='EL']) and ($displaymode='edit' and banks_fx_rates/fx_bank_params and banks_fx_rates/fx_bank_params/fx_product/fx_assign_products[.='Y']))">
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">fxinteresttoken</xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      <xsl:call-template name="e2ee_transaction"/>
      <xsl:call-template name="reauth_params"/>
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <!-- 
   Hidden Collection Document Details
  -->
  <xsl:template name="hidden-document-fields">
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">documents_details_position_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value" select="position()"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">documents_details_document_id_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value" select="document_id"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">documents_details_code_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value" select="code"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">documents_details_name_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value" select="name"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">documents_details_first_mail_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value" select="first_mail"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">documents_details_second_mail_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value" select="second_mail"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">documents_details_total_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value" select="total"/>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="disclaimer-column-wrapper">
<!--   	<xsl:param name="leftStyle">width:245px;</xsl:param> -->
  	<xsl:param name="rightStyle">margin-left: 265px;</xsl:param>
  	<xsl:param name="leftContent">&nbsp;</xsl:param>
  	<xsl:param name="rightContent" />
<!--   	<div class="column-container"> -->
<!-- 		<div> -->
<!-- 			<xsl:attribute name="style"><xsl:value-of select="$leftStyle" /></xsl:attribute> -->
<!-- 			<xsl:value-of select="$leftContent" /> -->
<!-- 		</div> -->
		<div>
			<xsl:attribute name="style"><xsl:value-of select="$rightStyle" /></xsl:attribute>
			<xsl:value-of select="$rightContent" /> 
		</div>
  </xsl:template>
  <!-- comments for return -->
   <xsl:template name="comments-for-return">
    <xsl:param name="value" />
    <xsl:param name="mode" />
   		<xsl:call-template name="fieldset-wrapper">
	  		<xsl:with-param name="legend">XSL_HEADER_MC_COMMENTS_FOR_RETURN</xsl:with-param>
	   		<xsl:with-param name="id">comments-for-return</xsl:with-param>
	   		<xsl:with-param name="content">
			    <xsl:call-template name="textarea-field">
					<xsl:with-param name="label"></xsl:with-param>
					<xsl:with-param name="name">return_comments</xsl:with-param>
					<xsl:with-param name="messageValue"><xsl:value-of select="$value"/></xsl:with-param>
					<xsl:with-param name="rows">5</xsl:with-param>
				   	<xsl:with-param name="cols">50</xsl:with-param>
			   		<xsl:with-param name="maxlines">300</xsl:with-param>
			   		<xsl:with-param name="override-displaymode">
			   			<xsl:choose>
			   				<xsl:when test="$mode = 'UNSIGNED'">edit</xsl:when>
			   				<xsl:otherwise>view</xsl:otherwise>
			   			</xsl:choose>
			   		</xsl:with-param>
			 	</xsl:call-template>
	   		</xsl:with-param>
   		</xsl:call-template>
   </xsl:template>
  
  
</xsl:stylesheet>