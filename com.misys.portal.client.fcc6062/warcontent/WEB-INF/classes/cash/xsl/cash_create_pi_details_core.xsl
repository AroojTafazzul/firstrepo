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
        xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
        xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
        xmlns:ftProcessing="xalan://com.misys.portal.cash.common.services.FTProcessing"
        xmlns:collabutils="xalan://com.misys.portal.common.tools.CollaborationUtils"
        exclude-result-prefixes="xmlRender localization ftProcessing collabutils">
        
        <xsl:param name="isMultiBank">N</xsl:param>
        
<!-- 
   FT TNX FORM TEMPLATE.
  -->
  <xsl:template match="ft_tnx_record">
	  <script>
			dojo.ready(function(){
			
         	  	misys._config = (misys._config) || {};	
	            misys._config.isMultiBank =<xsl:choose>
									 			<xsl:when test="$isMultiBank='Y'">true</xsl:when>
									 			<xsl:otherwise>false</xsl:otherwise>
									 		</xsl:choose>;
	            <xsl:if test="$isMultiBank='Y'">
	            dojo.mixin(misys._config, {
					bankBaseCurCode :	{
						<xsl:for-each select="/ft_tnx_record/avail_main_banks/bank">
		  						"<xsl:value-of select="abbv_name"/>": "<xsl:value-of select="bank_base_cur_code"/>"
		   						<xsl:if test="not(position()=last())">,</xsl:if>
		         		</xsl:for-each>
		         	}
				});
				misys._config.frequency_mode = misys._config.frequency_mode || 
			            [
			            {
			            <xsl:for-each select="/ft_tnx_record/frequency/frequency_per_bank">
				   						<xsl:for-each select="frequency_mode">
											'<xsl:value-of select="frequency_type"/>_<xsl:value-of select="bank_abbv_name"/>':['<xsl:value-of select="exact_flag" />','<xsl:value-of select="last_flag" />','<xsl:value-of select="transfer_limit" />']
				            					<xsl:if test="position()!=last()">,</xsl:if>
				            			</xsl:for-each>
				            			<xsl:if test="count(frequency_mode) > 0">
				            				<xsl:if test="position()!=last()">,</xsl:if>
				            			</xsl:if>
			         	</xsl:for-each>
			         	}
			         	];
				<xsl:call-template name="per-bank-recurring" />
				<xsl:call-template name="per-bank-recurring-frequency" />
				</xsl:if>
			});

	  </script>
   <!-- Preloader  -->
   <xsl:call-template name="loading-message"/>
     
   <div>
   	<xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>

    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     	<xsl:with-param name="content">
                      
      		<!-- Disclaimer Notice -->
      		<xsl:call-template name="disclaimer"/>      
	      	<xsl:call-template name="hidden-fields"/>	      	    
			  
	      	<xsl:if test="$displaymode='edit'">    		        	
	      		   			      				      		
	      			
	      			 <xsl:if test="$displaymode='edit'">
		      		  <div id="PIDD_DISCLAIMER" class="piDisclaimer" style="display:none;">
		      			<xsl:call-template name="simple-disclaimer">
		      				<xsl:with-param name="label">XSL_PIDD_DISCLAIMER</xsl:with-param>
	      				</xsl:call-template>	      				
		      		  </div>	  	
		      		  <div id="PICO_DISCLAIMER" class="piDisclaimer" style="display:none;">
		      			<xsl:call-template name="simple-disclaimer">
		      				<xsl:with-param name="label">XSL_PICO_DISCLAIMER</xsl:with-param>
	      				</xsl:call-template>	      				
		      		  </div>
		      		 </xsl:if>	  		      	 				      			       			 
	      		
	      		</xsl:if>
		      	      		
	      			<!--  Display common menu. -->
	      		
					<xsl:call-template name="menu" >
						<xsl:with-param name="show-return">Y</xsl:with-param>
						<xsl:with-param name="show-submit">
							<xsl:choose>
								<xsl:when test="($mode='UNSIGNED' and modifiedBeneficiary[.='Y'])">N</xsl:when>
								<xsl:otherwise>Y</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
			 		</xsl:call-template>
	      			
	      			<!-- Reauthentication -->	
				 	<xsl:call-template name="server-message">
				 		<xsl:with-param name="name">server_message</xsl:with-param>
				 		<xsl:with-param name="content"><xsl:value-of select="message"/></xsl:with-param>
				 		<xsl:with-param name="appendClass">serverMessage</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="reauthentication" />
					
					<xsl:call-template name="pi-general-details" />
			      	<xsl:call-template name="recurring_content">
			      		<xsl:with-param name="override-displaymode"><xsl:value-of select="$displaymode"/></xsl:with-param>
			      	</xsl:call-template>
			      
			      	<xsl:call-template name="pi-transfer-to-details"/>
			      	<xsl:call-template name="pi-transaction-details"/>	
			      	<!-- FX Snippets Start -->
			      	<xsl:if test="not(amount_access) or  (amount_access[.='true'])  ">
				      	<xsl:if test="$displaymode='edit' and banks_fx_rates/fx_bank_params and banks_fx_rates/fx_bank_params/fx_bank_product_details/fx_bank_properties/fx_assign_products[.='Y']">  
				        	<xsl:call-template name="fx-template"/>
				        </xsl:if>  
				        
				        <xsl:if test="$displaymode='view' and fx_rates_type and fx_rates_type[.!='']">
				            <xsl:call-template name="fx-details-for-view" /> 
				        </xsl:if>
			        </xsl:if>
			        <!-- FX Snippets End -->
			        <xsl:call-template name="beneficiary-advices-section">
			      		<xsl:with-param name="sub-product-code-widget-id">sub_product_code</xsl:with-param>
			      		<xsl:with-param name="entity-widget-id">entity</xsl:with-param>
			      		<xsl:with-param name="bank-abbv-name-widget-id">issuing_bank_abbv_name</xsl:with-param>
			      	</xsl:call-template>			      
		      		<xsl:call-template name="transaction-remarks-details" />
		      		<!-- comments for return -->
     				<xsl:call-template name="comments-for-return">
	  					<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
	   					<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
   	 				</xsl:call-template>		
		      			
	     		<!-- Display common menu, this time outside the form -->
	    		<xsl:call-template name="menu">
	     			<xsl:with-param name="second-menu">Y</xsl:with-param>
	     			<xsl:with-param name="show-return">Y</xsl:with-param>
	     			<xsl:with-param name="show-submit">
						<xsl:choose>
							<xsl:when test="($mode='UNSIGNED' and modifiedBeneficiary[.='Y'])">N</xsl:when>
							<xsl:otherwise>Y</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
	     			<xsl:with-param name="show-template">
	     			<xsl:choose>
	     			<xsl:when test="bulk_ref_id[.='']">Y</xsl:when>	
	     			<xsl:otherwise>N</xsl:otherwise>
	     			</xsl:choose>
	     			</xsl:with-param>
	    		</xsl:call-template>	    		
	     		
	     </xsl:with-param>
	 </xsl:call-template>	 	 
   <xsl:call-template name="realform"/>
    
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
	<script>
		dojo.ready(function(){			
        	  	misys._config = misys._config || {};			
			misys._config.task_mode = '<xsl:value-of select="collabutils:getProductTaskMode($rundata, $product-code, sub_product_code)"/>';
		});
  	</script>
   </xsl:if>     
       
  <!-- Javascript imports  -->
  <xsl:call-template name="js-imports"/> 
  
  <!-- Bene Advice Dialog and GridMultipleItem Template Node -->
  <xsl:call-template name="bene-advices-dialog-template"/>
 </xsl:template>
 
 <!--
   Real form for Local Electronic Payment
   -->
  <xsl:template name="realform">
   <xsl:call-template name="form-wrapper">
    <xsl:with-param name="name">realform</xsl:with-param>
    <xsl:with-param name="method">POST</xsl:with-param>
    <xsl:with-param name="action" select="$realform-action"/>
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
       <xsl:with-param name="name">option_for_app_date</xsl:with-param>
       <xsl:with-param name="value" select="$option"/>
      </xsl:call-template>   
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
       <xsl:with-param name="value">PI</xsl:with-param>
      </xsl:call-template>      
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">tnxtype</xsl:with-param>
       <xsl:with-param name="value">01</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">attIds</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:if test="$displaymode='edit' and banks_fx_rates/fx_bank_params and banks_fx_rates/fx_bank_params/fx_bank_product_details/fx_bank_properties/fx_assign_products[.='Y']">
	      <xsl:call-template name="hidden-field">
	       <xsl:with-param name="name">fxinteresttoken</xsl:with-param>
	      </xsl:call-template>
      </xsl:if>
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
  
  
  	<xsl:template name="pi-general-details">
		<xsl:param name="show-template-id">Y</xsl:param>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
			  <xsl:call-template name="column-container">
				 <xsl:with-param name="content">			 
			  <xsl:call-template name="column-wrapper">
			     <xsl:with-param name="content">
				<xsl:choose>
					<xsl:when test="bulk_ref_id[.!='']">
						<div id="display_bulk_ref_id_row" class="field">
							<span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_BK_REF_ID')"/>&nbsp;</span>
							<div class="content"><xsl:value-of select="bulk_ref_id"/></div> 
						</div>
						<xsl:if test="entities[number(.) &gt; 0]">
							<div id="display_entity_row" class="field">
								<span class="label"><xsl:value-of select="localization:getGTPString($language, 'ENTITY_LABEL')"/></span>
								<div class="content"><xsl:value-of select="entity"/></div> 
							</div>
							<xsl:call-template name="hidden-field">
						       <xsl:with-param name="name">entity</xsl:with-param>
						    </xsl:call-template>
						</xsl:if>
						<xsl:call-template name="user-account-field">
				           <xsl:with-param name="label">XSL_TRANSFER_FROM</xsl:with-param>
				          <xsl:with-param name="name">applicant</xsl:with-param>
				          <xsl:with-param name="entity-field">entity</xsl:with-param>
				          <xsl:with-param name="dr-cr">debit</xsl:with-param>
				          <xsl:with-param name="show-product-types">N</xsl:with-param>
				          <xsl:with-param name="product_types">FT:<xsl:value-of select="sub_product_code"/></xsl:with-param>
				          <xsl:with-param name="product-types-required">Y</xsl:with-param>
				          <xsl:with-param name="required">Y</xsl:with-param>
				           <xsl:with-param name="override-displaymode">view</xsl:with-param>
				         </xsl:call-template>
						 <div id="display_sub_product_code_row" class="field">
							<span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_SUB_PRODUCT')"/>&nbsp;</span>
							<div class="content"><xsl:if test="sub_product_code[.!='']"><xsl:value-of select="localization:getDecode($language, 'N047', concat(sub_product_code,'_BK'))"/></xsl:if></div> 
						</div>
					</xsl:when>
					<xsl:otherwise>
					<xsl:if test="$displaymode='view' and entity[.!=''] and sub_prod_code[.!='PICO']">                                     
 	 	 				  <div id="display_entity_row" class="field">
 	 	 				  <span class="label"><xsl:value-of select="localization:getGTPString($language, 'ENTITY_LABEL')"/></span>
 	 	 				  <div class="content"><xsl:value-of select="entity"/></div> 
 	 	 				  </div>                                                  
 	 	 		   </xsl:if>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_JURISDICTION_SUB_PRODUCT</xsl:with-param>	
							<xsl:with-param name="id">sub_product_code_view</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N047', sub_product_code)"/></xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="$displaymode='edit' and entities[number(.) &gt; 0]">
							<xsl:call-template name="entity-field">
								<xsl:with-param name="required">Y</xsl:with-param>
							    <xsl:with-param name="button-type">entity</xsl:with-param>
							    <xsl:with-param name="prefix">applicant</xsl:with-param>
							    <xsl:with-param name="override-sub-product-code">FT:<xsl:value-of select="sub_product_code"/></xsl:with-param>
						    </xsl:call-template>
						</xsl:if>
						
						<!-- Customer Bank for which Paper Instrument Cashier's Order(PICO) or Demand Draft(PIDD) needs to be performed. -->
						<xsl:if test="$isMultiBank='Y'">
							  <xsl:call-template name="customer-bank-field"/>
						</xsl:if>
						
				    	<xsl:call-template name="user-account-field">
					     	<xsl:with-param name="label">XSL_TRANSFER_FROM</xsl:with-param>
						    <xsl:with-param name="name">applicant</xsl:with-param>
						    <xsl:with-param name="entity-field">entity</xsl:with-param>
						    <xsl:with-param name="dr-cr">debit</xsl:with-param>
						    <xsl:with-param name="show-product-types">N</xsl:with-param>
						    <xsl:with-param name="product_types">FT:<xsl:value-of select="sub_product_code"/></xsl:with-param>
						    <xsl:with-param name="product-types-required">Y</xsl:with-param>
						    <xsl:with-param name="required">Y</xsl:with-param>
					    	<xsl:with-param name="isMultiBankParam">
					    		<xsl:choose>
					    			<xsl:when test="$isMultiBank='Y'">Y</xsl:when>
									<xsl:otherwise>N</xsl:otherwise>
					    		</xsl:choose>
					    	</xsl:with-param>
				    	</xsl:call-template>
				    	<xsl:call-template name="nickname-field-template"/>
					</xsl:otherwise>
				</xsl:choose>
			     <xsl:if test="$displaymode='edit'">
			        <script>
			        	dojo.ready(function(){
			        		misys._config = misys._config || {};
							misys._config.customerReferences = {};
							<xsl:apply-templates select="avail_main_banks/bank" mode="customer_references"/>
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
				</xsl:if>
				<xsl:if test="$displaymode='edit'">
									<xsl:call-template name="recurring_checkbox" />
								</xsl:if>
				</xsl:with-param>
			 </xsl:call-template>
				 <xsl:call-template name="column-wrapper">
				 <xsl:with-param name="content">
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">BANK_LABEL</xsl:with-param>	
					<xsl:with-param name="id">issuing_bank_name_view</xsl:with-param>
					<xsl:with-param name="fieldsize">small</xsl:with-param>
					<xsl:with-param name="value" select="issuing_bank/name" />
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="common-general-details">
					<xsl:with-param name="show-cust-ref-id">N</xsl:with-param>
					<xsl:with-param name="show-template-id">
						<xsl:choose>
							<xsl:when test="bulk_ref_id[.!='']">N</xsl:when>
							<xsl:otherwise><xsl:value-of select="$show-template-id"/></xsl:otherwise>
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
  
  
  
</xsl:stylesheet>
