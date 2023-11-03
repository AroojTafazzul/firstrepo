<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Template details for terminate recurring payment

Fund Transfer (FT) Form, Customer Side.

Copyright (c) 2000-2011 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      25/06/12
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
        exclude-result-prefixes="xmlRender localization ftProcessing">
       
  <xsl:param name="nicknameEnabled"/>
  <!-- 
   FT TNX FORM TEMPLATE.
  -->
  <xsl:template match="ft_tnx_record">
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
			
	      <xsl:call-template name="hidden-fields"/>
	      
	      <xsl:call-template name="hidden-fields-extra"/>
		    
	      <xsl:apply-templates select="cross_references" mode="hidden_form"/>

		  <!-- General Details Fieldset. -->
	      <xsl:call-template name="fieldset-wrapper">   		
			    		<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
			    		<xsl:with-param name="button-type">summary-details</xsl:with-param>
			    		<xsl:with-param name="content">
			    		<xsl:call-template name="hidden-field">
					    		<xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
					       		<xsl:with-param name="value">61</xsl:with-param>
					    </xsl:call-template>
					    <xsl:call-template name="hidden-field">
			    		<xsl:with-param name="name">prod_stat_code</xsl:with-param>
			       			<xsl:with-param name="value">39</xsl:with-param>
			    		</xsl:call-template>
			    		<xsl:call-template name="hidden-field">
   							 	<xsl:with-param name="name">ref_id</xsl:with-param>
   						</xsl:call-template>
						<xsl:call-template name="hidden-field">
						   	<xsl:with-param name="name">appl_date</xsl:with-param>
						</xsl:call-template>	
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">iss_date</xsl:with-param>
		     				<xsl:with-param name="value" select="iss_date"></xsl:with-param>
						</xsl:call-template>	
			   			<xsl:call-template name="hidden-field">
		       				<xsl:with-param name="name">recurring_start_date</xsl:with-param>
		        			<xsl:with-param name="value"><xsl:value-of select="recurring_start_date"/></xsl:with-param>
		   				</xsl:call-template>
		   				<xsl:call-template name="hidden-field">
		       				<xsl:with-param name="name">recurring_end_date</xsl:with-param>
		        			<xsl:with-param name="value"><xsl:value-of select="recurring_end_date"/></xsl:with-param>
		   				</xsl:call-template>				    
						<xsl:call-template name="column-container">
							<xsl:with-param name="content">
							 	<!-- column 1 -->		 
							 	<xsl:call-template name="column-wrapper">
								   	<xsl:with-param name="content"> 						   		 
								   		 <div>
							    			<!-- Display Entity -->
											<xsl:call-template name="input-field">
										     	<xsl:with-param name="label">ENTITY_LABEL</xsl:with-param>	
										     	<xsl:with-param name="id">entity_view</xsl:with-param>
		        								<xsl:with-param name="value" select="entity" />
								    			<xsl:with-param name="override-displaymode">view</xsl:with-param>
											</xsl:call-template>
											<!-- Display Debit Account -->
											<xsl:call-template name="input-field">
										     	<xsl:with-param name="label">XSL_DEBIT_ACCOUNT</xsl:with-param>	
										     	<xsl:with-param name="id">applicant_act_name_view</xsl:with-param>
		        								<xsl:with-param name="value" select="applicant_act_name" />
								    			<xsl:with-param name="override-displaymode">view</xsl:with-param>
											</xsl:call-template>
											<xsl:call-template name="nickname-field-template"/>										
											<!-- Display product type -->
											<xsl:call-template name="input-field">
									  			<xsl:with-param name="label">XSL_PRODUCT_TYPE</xsl:with-param>			
									  			<xsl:with-param name="id">sub_product_code_view</xsl:with-param>
		        								<xsl:with-param name="value" select="localization:getDecode($language, 'N047', sub_product_code[.])" />
								    			<xsl:with-param name="override-displaymode">view</xsl:with-param>
									 		</xsl:call-template>
											<!-- Display Customer reference -->
											<xsl:call-template name="input-field">
									  			<xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>			
									  			<xsl:with-param name="id">cust_ref_id_view</xsl:with-param>
		        								<xsl:with-param name="value" select="cust_ref_id" />
								    			<xsl:with-param name="override-displaymode">view</xsl:with-param>
									 		</xsl:call-template>
									 		<!-- Action -->
									 		<xsl:call-template name="input-field">
									  			<xsl:with-param name="label">ACTION_USER_LABEL</xsl:with-param>			
									  			<xsl:with-param name="id">action_view</xsl:with-param>
		        								<xsl:with-param name="value" select="localization:getGTPString($language, 'ACT_TERMINATE')" />
								    			<xsl:with-param name="override-displaymode">view</xsl:with-param>
									 		</xsl:call-template>									 								   	
								   		</div>
							   		</xsl:with-param>
						   		</xsl:call-template>
						   		<!-- column 2 -->		 
						  		<xsl:call-template name="column-wrapper">
							   		<xsl:with-param name="content">						   		
							   		<div>
										<!-- Display Bank -->
										<xsl:call-template name="input-field">
									     	<xsl:with-param name="label">BANK_LABEL</xsl:with-param>
							    			<xsl:with-param name="id">issuing_bank_name_view</xsl:with-param>
		        							<xsl:with-param name="value" select="issuing_bank/name" />
							    			<xsl:with-param name="override-displaymode">view</xsl:with-param>
										</xsl:call-template>			
									    <!-- Display System ID. -->
									     <xsl:call-template name="input-field">
									      	<xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
									     	<xsl:with-param name="id">ref_id_view</xsl:with-param>
		        							<xsl:with-param name="value" select="ref_id" />
									     	 <xsl:with-param name="override-displaymode">view</xsl:with-param>
									     </xsl:call-template>
									    <!-- Display Issue Date -->
									     <xsl:call-template name="input-field">
									      	<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_APPLICATION_DATE</xsl:with-param>
									     	<xsl:with-param name="id">appl_date_view</xsl:with-param>
		        							<xsl:with-param name="value" select="appl_date" />
									     	 <xsl:with-param name="override-displaymode">view</xsl:with-param>
									     </xsl:call-template>
									    <!-- Display Bank Reference -->
									     <xsl:if test="bo_ref_id[.!='']">
										     <xsl:call-template name="input-field">
										      	 <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
										     	 <xsl:with-param name="id">bo_ref_id_view</xsl:with-param>
		        								 <xsl:with-param name="value" select="bo_ref_id" />
										     	 <xsl:with-param name="override-displaymode">view</xsl:with-param>
										     </xsl:call-template>
									     </xsl:if>
								     </div>
								     </xsl:with-param>
							     </xsl:call-template>
							   </xsl:with-param>
							 </xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
					
					<xsl:call-template name="fieldset-wrapper">
						<xsl:with-param name="legend">XSL_RECURRING_PAYMENT_DETAILS</xsl:with-param>
			    		<xsl:with-param name="content">
			    			<xsl:call-template name="column-container">
			    				<xsl:with-param name="content">
			    					<xsl:call-template name="column-wrapper">
								   		<xsl:with-param name="content">
								   			<xsl:call-template name="input-field">
										     	<xsl:with-param name="label">XSL_SO_START_DATE</xsl:with-param>	
										     	<xsl:with-param name="id">recurring_start_date_view</xsl:with-param>
		        								<xsl:with-param name="value" select="recurring_start_date" />
								    			<xsl:with-param name="override-displaymode">view</xsl:with-param>
											</xsl:call-template>
											<xsl:variable name="rec_feq">
							                 	<xsl:value-of select="localization:getDecode($language, 'N416', recurring_frequency)"/>											
											</xsl:variable>
											<xsl:call-template name="input-field">
										     	<xsl:with-param name="label">XSL_FREQUENCY_MODE</xsl:with-param>
										        <xsl:with-param name="id">recurring_frequency_view</xsl:with-param>
		        								<xsl:with-param name="value" select="$rec_feq" />							            
								    			<xsl:with-param name="override-displaymode">view</xsl:with-param>
											</xsl:call-template>
											<xsl:if test="recurring_on[.='01'] and recurring_frequency[.!=''] and recurring_frequency[.!='DAILY'] and recurring_frequency[.!='WEEKLY'] ">
											<xsl:call-template name="input-field">
												<xsl:with-param name="label">XSL_RECUR_ON</xsl:with-param>	
												<xsl:with-param name="id">recurring_on_view</xsl:with-param>
												<xsl:with-param name="value"  select="localization:getGTPString($language, 'XSL_RECUR_ON_EXACT_DAY')"/>
								    			<xsl:with-param name="override-displaymode">view</xsl:with-param>
											</xsl:call-template>
								    	    </xsl:if>
											<xsl:if test="recurring_on[.='02'] and recurring_frequency[.!=''] and recurring_frequency[.!='DAILY'] and recurring_frequency[.!='WEEKLY'] ">
											<xsl:call-template name="input-field">
												<xsl:with-param name="label">XSL_RECUR_ON</xsl:with-param>	
												<xsl:with-param name="id">recurring_on_view</xsl:with-param>
												<xsl:with-param name="value"  select="localization:getGTPString($language, 'XSL_RECUR_ON_LAST_DAY')"/>
								    			<xsl:with-param name="override-displaymode">view</xsl:with-param>
											</xsl:call-template>
								    	    </xsl:if>					   		
								   		</xsl:with-param>
								   	</xsl:call-template>

											<xsl:if test="recurring_on[.='01'] and recurring_frequency[.!=''] and recurring_frequency[.!='DAILY'] and recurring_frequency[.!='WEEKLY'] ">
											<xsl:call-template name="input-field">
												<xsl:with-param name="label">XSL_RECUR_ON</xsl:with-param>	
												<xsl:with-param name="id">recurring_on_view</xsl:with-param>
												<xsl:with-param name="value"  select="localization:getGTPString($language, 'XSL_RECUR_ON_EXACT_DAY')"/>
								    			<xsl:with-param name="override-displaymode">view</xsl:with-param>
											</xsl:call-template>
								    	    </xsl:if>
											<xsl:if test="recurring_on[.='02'] and recurring_frequency[.!=''] and recurring_frequency[.!='DAILY'] and recurring_frequency[.!='WEEKLY'] ">
											<xsl:call-template name="input-field">
												<xsl:with-param name="label">XSL_RECUR_ON</xsl:with-param>	
												<xsl:with-param name="id">recurring_on_view</xsl:with-param>
												<xsl:with-param name="value"  select="localization:getGTPString($language, 'XSL_RECUR_ON_LAST_DAY')"/>
								    			<xsl:with-param name="override-displaymode">view</xsl:with-param>
											</xsl:call-template>
								    	    </xsl:if>									   	

								   	<xsl:call-template name="column-wrapper">
								   		<xsl:with-param name="content">
								   			<xsl:call-template name="input-field">
										     	<xsl:with-param name="label">XSL_NUMBER_OF_TRANSFERS</xsl:with-param>	
										     	<xsl:with-param name="id">recurring_number_transfers_view</xsl:with-param>
		        								<xsl:with-param name="value" select="recurring_number_transfers" />
								    			<xsl:with-param name="override-displaymode">view</xsl:with-param>
											</xsl:call-template>
											<xsl:call-template name="input-field">
										     	<xsl:with-param name="label">XSL_PROCESS_TRANSACTION</xsl:with-param>
										     	<xsl:with-param name="id">recurring_processed_events_no_view</xsl:with-param>
		        								<xsl:with-param name="value" select="recurring_processed_events_no" />													
								    			<xsl:with-param name="override-displaymode">view</xsl:with-param>
											</xsl:call-template>
											<xsl:call-template name="input-field">
										     	<xsl:with-param name="label">XSL_SO_END_DATE</xsl:with-param>	
										     	<xsl:with-param name="id">recurring_end_date_view</xsl:with-param>
		        								<xsl:with-param name="value" select="recurring_end_date" />
								    			<xsl:with-param name="override-displaymode">view</xsl:with-param>
											</xsl:call-template>							   		
								   		</xsl:with-param>
								   	</xsl:call-template>			    				
			    				</xsl:with-param>			    			
			    			</xsl:call-template>			    		
			    		</xsl:with-param>					
					</xsl:call-template>

		  <!-- Transaction Remarks Details Fieldset. -->
      	  <xsl:call-template name="transaction-remarks-details" />
      	  <!-- comments for return -->
     		<xsl:call-template name="comments-for-return">
	  				<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
	   				<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
   	 		</xsl:call-template>
    		
     	  <!-- Display common menu, this time outside the form -->
    	  <xsl:call-template name="menu">
	     			<xsl:with-param name="second-menu">Y</xsl:with-param>
	     			<xsl:with-param name="show-template">N</xsl:with-param>
		       		<xsl:with-param name="show-return">Y</xsl:with-param>
	      </xsl:call-template>
	    		
    	  <script>
			dojo.ready(function(){
				misys._config = (misys._config) || {};
				misys._config.nickname = '<xsl:value-of select="$nicknameEnabled"/>';
				dojo.mixin(misys._config,{
					globalSubmitConfirmationMsg : misys.getLocalization("submitRecurringPaymentTerminationConfirmation")
				});
			});
		  </script> 
	  </xsl:with-param>
	</xsl:call-template>	 

   <xsl:call-template name="realform"/>
  </div>
     
  <!-- Javascript imports  -->
  <xsl:call-template name="js-imports"/> 
 </xsl:template>

 <xsl:template name="hidden-fields-extra">
  <!-- This below parameters are needed for re-authentication in edit mode as these are available only for view mode from ft_common.xsl -->
		    <!-- Start  -->
		    <div class="widgetContainer">
		    <xsl:if test="$displaymode='edit'">		
		    <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">entity</xsl:with-param>
		    </xsl:call-template>
	      	<xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">ft_cur_code</xsl:with-param>
		    </xsl:call-template>
		 
		    <div style="display:none;">
		      <xsl:call-template name="currency-field">
		        <xsl:with-param name="override-currency-name">ft_cur_code</xsl:with-param>
				<xsl:with-param name="override-amt-name">ft_amt</xsl:with-param>
				<xsl:with-param name="override-amt-displaymode">edit</xsl:with-param>
				<xsl:with-param name="show-button">N</xsl:with-param>
				<xsl:with-param name="required">N</xsl:with-param>
			  </xsl:call-template>
			</div>
		    <xsl:call-template name="hidden-field">
		    <xsl:with-param name="name">beneficiary_account</xsl:with-param>
		       <xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_act_no"/></xsl:with-param>
		    </xsl:call-template>
		    </xsl:if>
		    </div>
   <!-- End  -->
 </xsl:template>

  <!-- Real form for Remittance -->
  <xsl:template name="realform">
   <xsl:call-template name="form-wrapper">
    <xsl:with-param name="name">realform</xsl:with-param>
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
       <xsl:with-param name="name">tnxtype</xsl:with-param>
       <xsl:with-param name="value">14</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">attIds</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      
		    
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
       <xsl:with-param name="value">TERMINATE</xsl:with-param>
      </xsl:call-template>
       <xsl:call-template name="e2ee_transaction"/>
      <xsl:call-template name="reauth_params"/>
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>