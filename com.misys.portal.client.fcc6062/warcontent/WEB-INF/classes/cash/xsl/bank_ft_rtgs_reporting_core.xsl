<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
	xmlns:ftProcessing="xalan://com.misys.portal.cash.common.services.FTProcessing"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	exclude-result-prefixes="xmlRender localization ftProcessing securitycheck utils security defaultresource">

	<!-- 
	Global Parameters.
	These are used in the imported XSL, and to set global params in the JS 
	-->
	<xsl:param name="rundata"/>
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="mode">DRAFT</xsl:param>
	<xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
	<xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
	<xsl:param name="product-code">FT</xsl:param> 
	<xsl:param name="main-form-name">fakeform1</xsl:param>
	<xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TradeAdminScreen</xsl:param>

	  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/bank_common.xsl" /> 
  <xsl:include href="./common/ft_common.xsl" />
  <xsl:include href="../../core/xsl/common/beneficiary_advices_common.xsl" />
  <xsl:include href="../../core/xsl/common/bank_fx_common.xsl" />
  <xsl:include href="../../collaboration/xsl/collaboration.xsl" />
  
	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
	<xsl:template match="/">
		<xsl:apply-templates select="ft_tnx_record"/>
	</xsl:template>
	
	<xsl:template match="ft_tnx_record">
		<xsl:call-template name="loading-message"/>
		<div>
			<xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
			
			<!-- Display common reporting area -->
    		<xsl:call-template name="bank-reporting-area">
    		<xsl:with-param name="hide-reporting-message-details"><xsl:if test="tnx_type_code='54' or bulk_ref_id[.!='']">Y</xsl:if></xsl:with-param>
    		<xsl:with-param name="hide-charge-details"><xsl:if test="tnx_type_code='54' or bulk_ref_id[.!='']">Y</xsl:if></xsl:with-param>
    		 <xsl:with-param name="ftbulk-bank-cancel"><xsl:if test="tnx_type_code='54' or bulk_ref_id[.!='']">Y</xsl:if></xsl:with-param>
    		</xsl:call-template>
    		
    		<!-- Attachments -->
    		<xsl:if test="tnx_type_code!='54' and bulk_ref_id[.='']">
			    <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
			    	 <xsl:call-template name="attachments-file-dojo">
				       <xsl:with-param name="existing-attachments" select="attachments/attachment[type = '02']"/>
				       <xsl:with-param name="legend">XSL_HEADER_FILE_UPLOAD</xsl:with-param>
			      	</xsl:call-template> 
				</xsl:if>
			</xsl:if>
			
			 <!-- Link to display transaction contents -->
      		<xsl:call-template name="transaction-details-link"/>
      		
            <div id="transactionDetails">
      		 <xsl:call-template name="form-wrapper">
		        <xsl:with-param name="name" select="$main-form-name"/>
		        <xsl:with-param name="validating">Y</xsl:with-param>
		        <xsl:with-param name="content">
         		<h2 class="toplevel-title"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_SHOW_TRANSACTION')"/></h2>
         
		         <!-- Disclaimer Notice -->
		         <xsl:call-template name="disclaimer"/>
		         
		         <xsl:call-template name="hidden-fields"/>
			
		  			<xsl:call-template name="rtgs-general-details"/>
		  			<xsl:call-template name="recurring_content">
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
						<xsl:with-param name="isBankReporting">Y</xsl:with-param>
					</xsl:call-template>	  		
					<xsl:call-template name="transfer-beneficiary-details"/>  
					<xsl:call-template name="intermediary-bank-details"/>
					<xsl:call-template name="transaction-details" />
					<!-- bulk amount access handling -->
	      			<xsl:if test="not(amount_access) or  (amount_access[.='true'])  ">
			      		<xsl:if test="fx_rates_type and fx_rates_type[.!='']">
	        				<xsl:call-template name="bank-fx-template">
	        					<xsl:with-param name="override-displaymode">view</xsl:with-param>
	        				</xsl:call-template>
	        			</xsl:if>  
	        		</xsl:if> 
			      	<xsl:call-template name="payment-narrative-details" />
			      	<xsl:call-template name="instruction-to-bank-details" />
       			 </xsl:with-param>
      		 </xsl:call-template>
     	  </div>
       	  <xsl:call-template name="menu">
	     	  <xsl:with-param name="show-template">N</xsl:with-param>
	      	  <xsl:with-param name="second-menu">Y</xsl:with-param>
	      	  <xsl:with-param name="cash-bankft-bulk-cancel"><xsl:if test="tnx_type_code='54' or bulk_ref_id[.!='']">Y</xsl:if></xsl:with-param>
   		  </xsl:call-template>
  		</div>
		
		<!--  Collaboration Window -->   
	   <xsl:if test="$collaborationmode != 'none'">
	   	<xsl:call-template name="collaboration">
		    <xsl:with-param name="editable">true</xsl:with-param>
		    <xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>
		    <xsl:with-param name="contextPath"><xsl:value-of select="$contextPath"/></xsl:with-param>
		    <xsl:with-param name="bank_name_widget_id">issuing_bank_name</xsl:with-param>
			<xsl:with-param name="bank_abbv_name_widget_id">issuing_bank_abbv_name</xsl:with-param>
		</xsl:call-template>
	   </xsl:if>	
		
	  <!-- Javascript imports  -->
	  <xsl:call-template name="js-imports"/>
 </xsl:template>
 
  <!--                                     -->  
 <!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
 <!--                                     -->

<!-- Additional JS imports for this form are -->
	<!-- added here. -->
	<xsl:template name="js-imports">
		<xsl:call-template name="common-js-imports">
 			<xsl:with-param name="binding">misys.binding.bank.report_ft_rtgs</xsl:with-param>
 			 <xsl:with-param name="override-help-access-key">
			   <xsl:choose>
			   	<xsl:when test="$option ='EXISTING'">ER_01</xsl:when>
			   	<xsl:otherwise>PR_01</xsl:otherwise>
			   </xsl:choose>
	  		</xsl:with-param>
		</xsl:call-template>
		<script>
			dojo.ready(function(){
				misys._config = (misys._config) || {};
				misys._config.offset = misys._config.offset ||
				[{
					<xsl:for-each select="start_dt_offset/offset">
						'<xsl:value-of select="sub_prod_type_offset" />':[<xsl:value-of select="minimum_offset" />,<xsl:value-of select="maximum_offset" />]
						<xsl:if test="position()!=last()">,</xsl:if>
					</xsl:for-each>	
				}];
			misys._config.recurring_product = misys._config.recurring_product || 
			{
			<xsl:for-each select="recurring_payment/recurring_product">
					'<xsl:value-of select="sub_prod_type" />':'<xsl:value-of select="flag" />'
					<xsl:if test="position()!=last()">,</xsl:if>
			</xsl:for-each>	
			};
			misys._config.frequency_mode = misys._config.frequency_mode || 
			[
			{
			<xsl:for-each select="frequency/frequency_mode">
				'<xsl:value-of select="frequency_type"/>':['<xsl:value-of select="exact_flag" />','<xsl:value-of select="last_flag" />','<xsl:value-of select="transfer_limit" />']
            	<xsl:if test="position()!=last()">,</xsl:if>
            </xsl:for-each>
            }
            ];				
		});
		</script>
 	</xsl:template>
 	
 	<!-- General Details -->
 	<xsl:template name="rtgs-general-details">
		<xsl:call-template name="fieldset-wrapper">   		
				   		<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
				   		<xsl:with-param name="content">
				   		<xsl:call-template name="input-field">
					     	<xsl:with-param name="label">ENTITY_LABEL</xsl:with-param>	
					     	<xsl:with-param name="id">entity_view</xsl:with-param>
					     	<xsl:with-param name="disabled">Y</xsl:with-param>	
							<xsl:with-param name="fieldsize">small</xsl:with-param>
				   			<xsl:with-param name="value" select="entity" />
				   			<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
							
						<xsl:call-template name="input-field">
					     	<xsl:with-param name="label">XSL_TRANSFER_FROM</xsl:with-param>	
					     	<xsl:with-param name="id">transfer_from_view</xsl:with-param>
							<xsl:with-param name="fieldsize">small</xsl:with-param>
			    			<xsl:with-param name="value" select="applicant_act_name" />
			    			<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="input-field">
					     	<xsl:with-param name="label">BANK_LABEL</xsl:with-param>
					     	<xsl:with-param name="name">issuing_bank_name</xsl:with-param>	
							<xsl:with-param name="fieldsize">small</xsl:with-param>
				   			<xsl:with-param name="value" select="issuing_bank/name" />
				   			<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>	
						
						<xsl:call-template name="input-field">
					     	<xsl:with-param name="label">XSL_PRODUCT_TYPE</xsl:with-param>			
						    <xsl:with-param name="name">product_type</xsl:with-param>
				   			<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N047', sub_product_code[.])"/></xsl:with-param>
				   			<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
					  	<xsl:call-template name="common-general-details">
					  		<xsl:with-param name="show-template-id">N</xsl:with-param>
				     		<xsl:with-param name="show-cust-ref-id">N</xsl:with-param>			     		
				  		</xsl:call-template>
						</xsl:with-param>
			  		</xsl:call-template>
		  		</xsl:template>
	
	  	<xsl:template name="transfer-beneficiary-details">
   		<xsl:param name="beneficiary-header-label">XSL_HEADER_BENEFICIARY_DETAILS</xsl:param>   			
   		<xsl:param name="beneficiary-name-label">XSL_PARTIESDETAILS_BENEFICIARY_NAME</xsl:param>   	 
   		<xsl:param name="beneficiary-account-label">XSL_BENEFICIARY_ACCOUNT</xsl:param>    	 
   		<xsl:param name="beneficiary-swiftcode-label">XSL_SWIFT_BIC_CODE</xsl:param>  	    	 
   		<xsl:param name="beneficiary-bank-address-label">XSL_BENEFICIARY_BANK_NAME</xsl:param>  		
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
						  <xsl:with-param name="label">XSL_PARTIESDETAILS_BENEFICIARY_NAME</xsl:with-param>
						  <xsl:with-param name="name">beneficiary_name</xsl:with-param>		
						  <xsl:with-param name="swift-validate">N</xsl:with-param>
						  <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_name"/></xsl:with-param>
						  <xsl:with-param name="maxsize">33</xsl:with-param>
						  <xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							    <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
							    <xsl:with-param name="name">beneficiary_address</xsl:with-param>
							    <xsl:with-param name="maxsize">33</xsl:with-param>
							    <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_address_line_1"/></xsl:with-param>
						 		<xsl:with-param name="override-displaymode">view</xsl:with-param>
						   </xsl:call-template>
						   <xsl:call-template name="input-field">
							     <xsl:with-param name="name">beneficiary_city</xsl:with-param>
								 <xsl:with-param name="maxsize">33</xsl:with-param>
							     <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_address_line_2"/></xsl:with-param>
							     <xsl:with-param name="override-displaymode">view</xsl:with-param>
						   </xsl:call-template>
						   <xsl:call-template name="input-field">
							     <xsl:with-param name="name">beneficiary_dom</xsl:with-param>
							      <xsl:with-param name="maxsize">30</xsl:with-param>
							     <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_dom"/></xsl:with-param>
							     <xsl:with-param name="override-displaymode">view</xsl:with-param>
							</xsl:call-template> 

							<xsl:call-template name="country-field">
				    			<xsl:with-param name="label">XSL_BENEFICIARY_COUNTRY</xsl:with-param>
				      			<xsl:with-param name="name">beneficiary_country</xsl:with-param>
				      			<xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_country"/></xsl:with-param>
				      			<xsl:with-param name="prefix">beneficiary</xsl:with-param>
							     <xsl:with-param name="override-displaymode">view</xsl:with-param>
				    		</xsl:call-template>
						
	                    <xsl:call-template name="input-field">
						    <xsl:with-param name="label">XSL_BENEFICIARY_ACCOUNT</xsl:with-param>
						    <xsl:with-param name="name">beneficiary_account</xsl:with-param>	
						    <xsl:with-param name="maxsize">33</xsl:with-param>	
						    <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_act_no"/></xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
					  	</xsl:call-template>
					  	
					  	<div id="pre_approved_row" class="field">
							<span class="label"/>
							<div id="PAB" class="content">
							   	 <xsl:attribute name="style">
							   	 <xsl:choose>
							   	 	<xsl:when test="pre_approved_status[.='Y']">display:inline</xsl:when>
							   	 	<xsl:otherwise>display:none</xsl:otherwise>
							   	 </xsl:choose>
							   	 </xsl:attribute>
								<xsl:value-of select="localization:getGTPString($language,'XSL_RTGS_PAB')"/>
							</div> 
						</div>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">bene_email_1</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">bene_email_2</xsl:with-param>
					</xsl:call-template>
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
					  <xsl:with-param name="override-displaymode">view</xsl:with-param>
	                </xsl:call-template>
	                
	                <xsl:call-template name="input-field">
	                  <xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
	                  <xsl:with-param name="name">cpty_bank_name</xsl:with-param>
	                  <xsl:with-param name="fieldsize">small</xsl:with-param>
					  <xsl:with-param name="override-displaymode">view</xsl:with-param>
	                </xsl:call-template>
	                <xsl:call-template name="input-field">
	                  <xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_ADDRESS</xsl:with-param>
	                  <xsl:with-param name="name">cpty_bank_address_line_1</xsl:with-param>
	                  <xsl:with-param name="fieldsize">small</xsl:with-param>
					  <xsl:with-param name="override-displaymode">view</xsl:with-param>
	                </xsl:call-template>
	                <xsl:call-template name="input-field">
	                  <xsl:with-param name="name">cpty_bank_address_line_2</xsl:with-param>
	                  <xsl:with-param name="fieldsize">small</xsl:with-param>
					  <xsl:with-param name="override-displaymode">view</xsl:with-param>
	                </xsl:call-template>
	                <xsl:call-template name="input-field">
	                  <xsl:with-param name="name">cpty_bank_dom</xsl:with-param>
	                  <xsl:with-param name="fieldsize">small</xsl:with-param>
					  <xsl:with-param name="override-displaymode">view</xsl:with-param>
	                </xsl:call-template>
	                
	                <xsl:call-template name="input-field">
	                  <xsl:with-param name="name">cpty_bank_country</xsl:with-param>
	                  <xsl:with-param name="fieldsize">small</xsl:with-param>
					  <xsl:with-param name="override-displaymode">view</xsl:with-param>
	                </xsl:call-template>
	                
			      	<xsl:if test="$show-branch-address='Y'">
						<xsl:call-template name="multichoice-field">
	          		 		<xsl:with-param name="label">XSL_BRANCH_ADDRESS_CHECKBOX</xsl:with-param>
	          		 		<xsl:with-param name="type">checkbox</xsl:with-param>
	           		 		<xsl:with-param name="name">branch_address_flag</xsl:with-param>	
	           		 		<xsl:with-param name="override-displaymode">view</xsl:with-param>
		            	</xsl:call-template>
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
							     <xsl:with-param name="override-displaymode">view</xsl:with-param>
					      	</xsl:call-template>
				      	</div>			      		
	            	</xsl:if>	
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
	                  <xsl:with-param name="fieldsize">small</xsl:with-param>
					  <xsl:with-param name="override-displaymode">view</xsl:with-param>
	                </xsl:call-template>
			   		
					<xsl:call-template name="input-field">
	                  <xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
	                  <xsl:with-param name="name">intermediary_bank_name</xsl:with-param>
					  <xsl:with-param name="override-displaymode">view</xsl:with-param>
	                </xsl:call-template>
	                <xsl:call-template name="input-field">
	                  <xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_ADDRESS</xsl:with-param>
	                  <xsl:with-param name="name">intermediary_bank_address_line_1</xsl:with-param>
					  <xsl:with-param name="override-displaymode">view</xsl:with-param>
	                </xsl:call-template>
	                <xsl:call-template name="input-field">
	                  <xsl:with-param name="name">intermediary_bank_address_line_2</xsl:with-param>
					  <xsl:with-param name="override-displaymode">view</xsl:with-param>
	                </xsl:call-template>
	                <xsl:call-template name="input-field">
	                  <xsl:with-param name="name">intermediary_bank_dom</xsl:with-param>
					  <xsl:with-param name="override-displaymode">view</xsl:with-param>
	                </xsl:call-template>
	                
	                <xsl:call-template name="input-field">
	                  <xsl:with-param name="name">intermediary_bank_country</xsl:with-param>
					  <xsl:with-param name="override-displaymode">view</xsl:with-param>
	                </xsl:call-template> 	
			      	</xsl:with-param>
			      	</xsl:call-template>
			  </xsl:with-param>
			  </xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
   	</xsl:template>

   	<xsl:template name="instruction-to-bank-details">
   		<xsl:call-template name="fieldset-wrapper">
	     	<xsl:with-param name="legend">XSL_HEADER_INSTRUCTION_TO_BANK_DETAILS</xsl:with-param>
	     	<xsl:with-param name="content">
	    		<xsl:call-template name="textarea-field">	
			        <xsl:with-param name="name">instruction_to_bank</xsl:with-param>
			        <xsl:with-param name="cols">35</xsl:with-param>
			        <xsl:with-param name="rows">2</xsl:with-param>
			        <xsl:with-param name="maxlines">2</xsl:with-param>
			        <xsl:with-param name="swift-validate">N</xsl:with-param>
			        <xsl:with-param name="override-displaymode">view</xsl:with-param>		        
			    </xsl:call-template>
			</xsl:with-param>
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
   		<xsl:param name="override-displaymode"/>
   		<xsl:call-template name="fieldset-wrapper">
	     	<xsl:with-param name="legend">XSL_HEADER_TRANSACTION_DETAILS</xsl:with-param>
	     	<xsl:with-param name="content">
	     	<xsl:call-template name="column-container">
				 <xsl:with-param name="content">			 
				  <xsl:call-template name="column-wrapper">
				   <xsl:with-param name="content">	
	     			 <xsl:if test="not(amount_access) or  (amount_access[.='true'])  ">
						<xsl:call-template name="currency-field">
					      	<xsl:with-param name="label">XSL_PARTIESDETAILS_FT_AMT_LABEL</xsl:with-param>
						   	<xsl:with-param name="product-code">ft</xsl:with-param>
						   	<xsl:with-param name="currency-readonly">Y</xsl:with-param>
						   	<xsl:with-param name="show-button">N</xsl:with-param>
						   	<xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
							<xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
					    </xsl:call-template>
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
					     		 <xsl:when test="charge_option[. = 'SHA']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_OPTION_SHA_RTGS')"/></xsl:when>
							     <xsl:when test="charge_option[. = 'OUR']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_OPTION_OUR_RTGS')"/></xsl:when>								     
							     <xsl:when test="charge_option[. = 'BEN']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_OPTION_BEN_RTGS')"/></xsl:when>
					     	</xsl:choose>
					     	</xsl:with-param>
		   					<xsl:with-param name="override-displaymode">view</xsl:with-param>
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
		   				<xsl:with-param name="override-displaymode">view</xsl:with-param>
		    		</xsl:call-template>
			       </xsl:with-param>
			      </xsl:call-template>
			    
			    <xsl:call-template name="column-wrapper">
				<xsl:with-param name="content">
				<xsl:if test="not(amount_access) or  (amount_access[.='true'])  ">
				<div id="process_request_dates_div">
					<xsl:if test="(($displaymode='edit' and bulk_ref_id[.='']) or ($displaymode='view' and recurring_payment_enabled[.='N']))">
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
						    <xsl:with-param name="override-displaymode">view</xsl:with-param>
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
							    <xsl:with-param name="override-displaymode">view</xsl:with-param>
						   	</xsl:call-template>	
				    	</xsl:if>
			    	</xsl:if>
		    	</div>	
		    	</xsl:if>
    			<xsl:if test="transfer_purpose[.!='']">
					<xsl:variable name="transfer_purpose_code"><xsl:value-of select="transfer_purpose"></xsl:value-of></xsl:variable>
					 <xsl:call-template name="input-field">
					 	<xsl:with-param name="label">XSL_TRANSFER_PURPOSE</xsl:with-param>
					 	<xsl:with-param name="name">transfer_purpose</xsl:with-param>
					 	<xsl:with-param name="override-displaymode">view</xsl:with-param>
					 	<xsl:with-param name="value"><xsl:value-of select="utils:retrieveTransferPurposeDescRTGS($rundata, $transfer_purpose_code)"/></xsl:with-param>	
					 </xsl:call-template>
				</xsl:if>
		    	<xsl:variable name="pre-approved_beneficiary_only" select="not(securitycheck:hasPermission(utils:getUserACL($rundata),'ft_regular_beneficiary_access',utils:getUserEntities($rundata))) or (defaultresource:getResource('NON_PAB_ALLOWED') = 'false')"/>
			   	<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">option_for_tnx</xsl:with-param>
						<xsl:with-param name="value" select="$option"/>
				</xsl:call-template>
			    <xsl:call-template name="hidden-field">
					<xsl:with-param name="name">iss_date_unsigned</xsl:with-param>
			     	<xsl:with-param name="value" select="iss_date"></xsl:with-param>
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
	    	</xsl:with-param>
		   </xsl:call-template>
		  </xsl:with-param>
		 </xsl:call-template>
	   </xsl:with-param>
	</xsl:call-template>
	</xsl:template>   

	<!--
  	 Payment Narrative Details Fieldset. 
   	-->
   	<xsl:template name="payment-narrative-details">
   		<xsl:param name="override-displaymode"/>
   		<xsl:call-template name="fieldset-wrapper">
	     	<xsl:with-param name="legend">XSL_HEADER_PAYMENT_NARRATIVE_DETAILS</xsl:with-param>
	     	<xsl:with-param name="content">
	    		<xsl:call-template name="textarea-field">	
			        <xsl:with-param name="name">payment_details_to_beneficiary</xsl:with-param>
			        <xsl:with-param name="cols">69</xsl:with-param>
			        <xsl:with-param name="rows">2</xsl:with-param>
			        <xsl:with-param name="swift-validate">N</xsl:with-param>
			        <xsl:with-param name="override-displaymode">view</xsl:with-param>
			    </xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
</xsl:stylesheet>
