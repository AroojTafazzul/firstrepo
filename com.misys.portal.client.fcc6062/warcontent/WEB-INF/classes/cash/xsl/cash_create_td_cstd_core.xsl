<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Request for term Deposit (TD) Form, Customer Side.

Copyright (c) 2000-2010 Misys (http://www.misys.com),
All Rights Reserved.  

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
        xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
        xmlns:collabutils="xalan://com.misys.portal.common.tools.CollaborationUtils"
        exclude-result-prefixes="localization security utils collabutils">

  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">TD</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TermDepositScreen</xsl:param>
  <xsl:param name="issuing_bank_ref"/>
  <xsl:param name="isMultiBank">N</xsl:param>
   <xsl:param name="optionmode">edit</xsl:param>
   <xsl:param name="option_for_app_date">PENDING</xsl:param>
    <xsl:param name="nicknameEnabled"/>
  
  <!-- Global Imports. -->
   <xsl:include href="../../core/xsl/common/bk_upl_trade_common.xsl" />
   <xsl:include href="../../core/xsl/common/fx_common_multibank.xsl" />
   <xsl:include href="../../core/xsl/common/e2ee_common.xsl"/>
   <xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
   
   <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="td_tnx_record"/>
  </xsl:template>
  
  <!-- 
   FX TNX FORM TEMPLATE.
  -->
  <xsl:template match="td_tnx_record">
   <!-- Preloader  -->
   <xsl:call-template name="loading-message"/>
   <xsl:apply-templates select="deposit_details"/>
   <script>
		dojo.ready(function(){
			misys._config = misys._config || {};
			misys._config.nickname = '<xsl:value-of select="$nicknameEnabled"/>';
			misys._config.option_for_app_date = "<xsl:value-of select="$option_for_app_date"/>"	;	
			dojo.mixin(misys._config, {
				maturityCodes :  new Array(),
				maturityCodesDescription : new Array(),
				maturityMandatoryFlag : new Array()
			});
			misys._config.businessDateForBank = misys._config.businessDateForBank || 
					{
						<xsl:value-of select="utils:getAllBankBusinessDate($rundata)"/>
					};
			<xsl:for-each select="maturity_instructions/deposit_type">
					<xsl:variable name="depositName"><xsl:value-of select="deposit_name"/></xsl:variable>
						misys._config.maturityCodes["<xsl:value-of select="$depositName"/>"] = new Array(<xsl:value-of select="count(maturity_instruction)"/>);
						misys._config.maturityCodesDescription["<xsl:value-of select="$depositName"/>"] = new Array(<xsl:value-of select="count(maturity_instruction)"/>);
						misys._config.maturityMandatoryFlag["<xsl:value-of select="$depositName"/>"] = new Array(<xsl:value-of select="count(maturity_instruction)"/>);
						<xsl:for-each select="maturity_instruction">
							<xsl:variable name="position" select="position() - 1" />
							misys._config.maturityCodes["<xsl:value-of select="$depositName"/>"][<xsl:value-of select="$position"/>]="<xsl:value-of select="maturity_code"/>";
	        				misys._config.maturityCodesDescription["<xsl:value-of select="$depositName"/>"][<xsl:value-of select="$position"/>]="<xsl:value-of select="maturity_name"/>";
	        				misys._config.maturityMandatoryFlag["<xsl:value-of select="$depositName"/>"][<xsl:value-of select="$position"/>]="<xsl:value-of select="mandatory_flag"/>";
						</xsl:for-each>
			</xsl:for-each>
			
			misys._config.subProductCode = '<xsl:value-of select="sub_product_code"/>';
			misys._config.isMultiBank =<xsl:choose>
								 			<xsl:when test="$isMultiBank='Y'">true</xsl:when>
								 			<xsl:otherwise>false</xsl:otherwise>
								 		</xsl:choose>;
            <xsl:if test="$isMultiBank='Y'">
	            dojo.mixin(misys._config, {
					entityBanksCollection : {
			   			<xsl:if test="count(/td_tnx_record/avail_main_banks/entities_banks_list/entity_banks/mb_entity) > 0" >
			        		<xsl:for-each select="/td_tnx_record/avail_main_banks/entities_banks_list/entity_banks/mb_entity" >
			        			<xsl:variable name="mb_entity" select="self::node()/text()" />
			  						<xsl:value-of select="."/>: [
			   						<xsl:for-each select="/td_tnx_record/avail_main_banks/entities_banks_list/entity_banks[mb_entity=$mb_entity]/customer_bank" >
			   							{ value:"<xsl:value-of select="."/>",
					         				name:"<xsl:value-of select="."/>"},
			   						</xsl:for-each>
			   						]<xsl:if test="not(position()=last())">,</xsl:if>
			         		</xsl:for-each>
			       		</xsl:if>
					},
					<!-- Banks for without entity customers.  -->
					wildcardLinkedBanksCollection : {
			   			<xsl:if test="count(/td_tnx_record/avail_main_banks/bank/abbv_name) > 0" >
			  						"customerBanksForWithoutEntity" : [
				        			<xsl:for-each select="/td_tnx_record/avail_main_banks/bank[customer_reference != '']/abbv_name" >
				   							{ value:"<xsl:value-of select="."/>",
						         				name:"<xsl:value-of select="."/>"},
				         			</xsl:for-each>
			   						]
			       		</xsl:if>
					},
					
					customerBankDetails : {
			       		<xsl:if test="count(/td_tnx_record/customer_banks_details/bank_abbv_desc/bank_abbv_name) > 0" >
			        		<xsl:for-each select="/td_tnx_record/customer_banks_details/bank_abbv_desc/bank_abbv_name" >
			        			<xsl:variable name="bank_abbv_name" select="self::node()/text()" />
			  						<xsl:value-of select="."/>: [
			   						<xsl:for-each select="/td_tnx_record/customer_banks_details/bank_abbv_desc[bank_abbv_name=$bank_abbv_name]/bank_desc" >
			   							{ value:"<xsl:value-of select="."/>",
					         				name:"<xsl:value-of select="."/>"},
			   						</xsl:for-each>
			   						]<xsl:if test="not(position()=last())">,</xsl:if>
			         		</xsl:for-each>
			       		</xsl:if>
					}
				});
			</xsl:if>
		});
	</script>
   <div >
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>

    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
     
     <xsl:if test="$displaymode='edit' and tnx_type_code and tnx_type_code[.='13']">
			<xsl:call-template name="simple-disclaimer">
				<xsl:with-param name="label">TD_BREAK_DISCLAIMER_LABEL</xsl:with-param>
			</xsl:call-template>
	</xsl:if>
     	
      <!--  Display common menu. -->
      <xsl:call-template name="menu">
       <xsl:with-param name="show-template">N</xsl:with-param>
       <xsl:with-param name="show-return">Y</xsl:with-param>
       
          	<xsl:with-param name="show-reject">
								<xsl:choose>
									<xsl:when test="$optionmode='CANCEL'">Y</xsl:when>
									<xsl:otherwise>N</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="show-return">
								<xsl:choose>
									<xsl:when test="$optionmode='CANCEL'">N</xsl:when>
									<xsl:otherwise>Y</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="show-submit">
								<xsl:choose>
									<xsl:when test="$optionmode='CANCEL'or ($mode='UNSIGNED' and modifiedBeneficiary[.='Y'])">N</xsl:when>
									<xsl:otherwise>Y</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="show-save">
								<xsl:choose>
									<xsl:when test="$optionmode='CANCEL'">N</xsl:when>
									<xsl:otherwise>Y</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="show-template">
								<xsl:choose>
									<xsl:when test="bulk_ref_id[.!='']">N</xsl:when>
									<xsl:when test="$optionmode='CANCEL'">N</xsl:when>
									<xsl:otherwise>N</xsl:otherwise>
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
      
      <!-- Disclaimer Notice -->
      <xsl:call-template name="disclaimer"/>
     
      <xsl:apply-templates select="cross_references" mode="hidden_form"/>
      <xsl:call-template name="hidden-fields"/>
      <xsl:call-template name="td-general-details"/>
      <div id ="td-transaction-details">
      <xsl:call-template name="td-transaction-details"/>
      </div>
      <div class="clear"/><!-- sadly, after a bi columns section, we need to clear. -->
      <div id="td-fx-section">
	      <!-- FX Snippets Start -->
	      						
		  <xsl:if test="$displaymode='edit' and banks_fx_rates/fx_bank_params and banks_fx_rates/fx_bank_params/fx_bank_product_details/fx_bank_properties/fx_assign_products[.='Y']">  
		     <xsl:call-template name="fx-template"/>
		  </xsl:if>  
		  <xsl:if test="$displaymode='view' and fx_rates_type and fx_rates_type[.!='']">	  
		    <xsl:call-template name="fx-details-for-view" /> 
		  </xsl:if>
	
	  </div>
	  <!-- comments for return -->
	  	<xsl:choose>
		<xsl:when test="$optionmode !='CANCEL'">
      <xsl:call-template name="comments-for-return">
	  		<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
	   		<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
   	  </xsl:call-template>
   	  </xsl:when>
   	  </xsl:choose>
	  <!-- FX Snippets End -->	  
	  <div id ="td-interest-rate-details">
	  <xsl:if test="interest_inquiry_impl[.='Y']">	 
      <xsl:call-template name="td-interest-rate-details"/>
      </xsl:if>
      </div>
      <xsl:if test="tnx_type_code[.!='13']">
        <div id ="td-remarks">
      	 <xsl:call-template name="transactional-remarks-details"/>
      	</div>
      </xsl:if>
     </xsl:with-param>
    </xsl:call-template>

    <xsl:call-template name="realform"/>
         
    <xsl:call-template name="menu">
	    <xsl:with-param name="show-template">N</xsl:with-param>    
	    <xsl:with-param name="second-menu">Y</xsl:with-param>
	    <xsl:with-param name="show-return">Y</xsl:with-param>
	       	<xsl:with-param name="show-reject">
								<xsl:choose>
									<xsl:when test="$optionmode='CANCEL'">Y</xsl:when>
									<xsl:otherwise>N</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="show-return">
								<xsl:choose>
									<xsl:when test="$optionmode='CANCEL'">N</xsl:when>
									<xsl:otherwise>Y</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="show-submit">
								<xsl:choose>
									<xsl:when test="$optionmode='CANCEL'or ($mode='UNSIGNED' and modifiedBeneficiary[.='Y'])">N</xsl:when>
									<xsl:otherwise>Y</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="show-save">
								<xsl:choose>
									<xsl:when test="$optionmode='CANCEL'">N</xsl:when>
									<xsl:otherwise>Y</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="show-template">
								<xsl:choose>
									<xsl:when test="bulk_ref_id[.!='']">N</xsl:when>
									<xsl:when test="$optionmode='CANCEL'">N</xsl:when>
									<xsl:otherwise>N</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
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
		<script>
			dojo.ready(function(){			
         	  	misys._config = misys._config || {};			
				misys._config.task_mode = '<xsl:value-of select="collabutils:getProductTaskMode($rundata, $product-code, sub_product_code)"/>';
			});
	  	</script>
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
   <xsl:with-param name="binding">misys.binding.cash.create_td_cstd</xsl:with-param>
   <xsl:with-param name="override-help-access-key">
     <xsl:choose>
       <xsl:when test="tnx_type_code ='01'">TD_01</xsl:when>
       <xsl:when test="tnx_type_code ='03'">TD_02</xsl:when>
       <xsl:when test="tnx_type_code ='13'">TD_03</xsl:when>
       <xsl:otherwise>TD_01</xsl:otherwise>
     </xsl:choose>
   </xsl:with-param> 
  </xsl:call-template>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are  -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
    <xsl:call-template name="common-hidden-fields">
	    <xsl:with-param name="show-type">N</xsl:with-param>
	    <xsl:with-param name="additional-fields">
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">applicant_act_name1</xsl:with-param>
			<xsl:with-param name="value" select="applicant_act_name"/>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">applicant_act_nickname</xsl:with-param>
		</xsl:call-template>
	    </xsl:with-param>
    </xsl:call-template>
 </xsl:template>

  	<xsl:template name="td-general-details">
	  	<!-- General details for fx order -->
	  	<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
			   <xsl:call-template name="column-container">
				 <xsl:with-param name="content">
				  <!-- column 1 -->		 
				  <xsl:call-template name="column-wrapper">
				   <xsl:with-param name="content">
						<!-- Entity Field -->
						<xsl:choose>
							<xsl:when test="tnx_type_code[.='01'] or (security:isBank($rundata) and not(tnx_type_code))">
								 <xsl:call-template name="address">
							        <xsl:with-param name="show-entity">Y</xsl:with-param>
							        <xsl:with-param name="show-name">N</xsl:with-param>
							        <xsl:with-param name="show-address">N</xsl:with-param>
							        <xsl:with-param name="prefix">applicant</xsl:with-param>
							        <xsl:with-param name="required">Y</xsl:with-param>
							      </xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
							      <xsl:when test="(tnx_type_code[.!='03' and .!='13'] and (entities[number(.) &gt; 1]))or (security:isBank($rundata) and not(tnx_type_code))">
								       <xsl:if test="$displaymode='edit'">
								        <script>
								        dojo.ready(function(){
								        	misys._config = misys._config || {};
											misys._config.customerReferences = {};
											<xsl:apply-templates select="avail_main_banks/bank" mode="customer_references"/>
										});
										</script>
								       </xsl:if>
								       <xsl:call-template name="input-field">
										     <xsl:with-param name="label">XSL_PARTIESDETAILS_ENTITY</xsl:with-param>
										     <xsl:with-param name="id">entity</xsl:with-param>
										     <xsl:with-param name="name">entity</xsl:with-param>
										     <xsl:with-param name="required">Y</xsl:with-param>
										     <xsl:with-param name="readonly">Y</xsl:with-param>
										     <xsl:with-param name="button-type">set-entity</xsl:with-param>
										     <xsl:with-param name="override-product-code">TD</xsl:with-param>
										     <xsl:with-param name="override-applicant-reference"><xsl:value-of select="applicant_reference"/></xsl:with-param>
										</xsl:call-template>
							       </xsl:when>
							       <xsl:otherwise>
							       			<xsl:if test="(entities[number(.) &gt; 0] and tnx_type_code[.='03' or .='13']) or not(tnx_type_code)">
										         <xsl:call-template name="input-field">
										       		<xsl:with-param name="label">XSL_PARTIESDETAILS_ENTITY</xsl:with-param>
										       		<xsl:with-param name="id">entity_view</xsl:with-param>
										       		<xsl:with-param name="value"><xsl:value-of select="entity"/></xsl:with-param>
										        	<xsl:with-param name="override-displaymode">view</xsl:with-param>
										         </xsl:call-template>
										         <xsl:call-template name="hidden-field">
												     <xsl:with-param name="name">entity</xsl:with-param>
											     </xsl:call-template>
									        </xsl:if>
							       </xsl:otherwise>
							       </xsl:choose>
							
							</xsl:otherwise>
						</xsl:choose>
						
						<!-- Bank to which beneficiary needs to be linked to. -->
						<xsl:if test="$isMultiBank='Y'">
							  <xsl:call-template name="customer-bank-field"/>
						</xsl:if>
						
				      <!-- Debit Account --> 
				      <xsl:choose>
				     		<xsl:when test="tnx_type_code[.='01'] or (security:isBank($rundata) and not(tnx_type_code))">
				     			<xsl:call-template name="user-account-field">
								  	<xsl:with-param name="label">XSL_TD_DEBIT_ACCOUNT</xsl:with-param>
								  	<xsl:with-param name="name">applicant</xsl:with-param>
								    <xsl:with-param name="entity-field">entity</xsl:with-param>
								    <xsl:with-param name="dr-cr">debit</xsl:with-param>
								    <xsl:with-param name="product_types">TD:CSTD</xsl:with-param>
								    <xsl:with-param name="required">Y</xsl:with-param>
								    <xsl:with-param name="disabled">Y</xsl:with-param>
								    <xsl:with-param name="show-product-types">N</xsl:with-param>
								    <xsl:with-param name="value"><xsl:value-of select="applicant_act_name"/></xsl:with-param>
								 	<xsl:with-param name="isMultiBankParam">
							    		<xsl:choose>
							    			<xsl:when test="$isMultiBank='Y'">Y</xsl:when>
											<xsl:otherwise>N</xsl:otherwise>
							    		</xsl:choose>
				    				</xsl:with-param>	
								  </xsl:call-template>	
				     		</xsl:when>
				     		<xsl:when test="tnx_type_code[.='03'] or tnx_type_code[.='13'] or not(tnx_type_code)">
				     			<xsl:call-template name="input-field">
								  	<xsl:with-param name="label">XSL_TD_DEBIT_ACCOUNT</xsl:with-param>
					    			<xsl:with-param name="id">applicant_act_name_view</xsl:with-param>
								  	<xsl:with-param name="name">applicant_act_name</xsl:with-param>
					    			<xsl:with-param name="override-displaymode">view</xsl:with-param>
							  	</xsl:call-template>
							  	<xsl:call-template name="hidden-field">
							  	 <xsl:with-param name="name">applicant_act_no</xsl:with-param>
							  	</xsl:call-template>
							  	<xsl:call-template name="hidden-field">
							  	 <xsl:with-param name="name">applicant_act_name</xsl:with-param>
							  	</xsl:call-template>
							  	<xsl:call-template name="hidden-field">
							  	<xsl:with-param name="name">applicant_act_cur_code</xsl:with-param>
							  	</xsl:call-template>
							  	<xsl:call-template name="hidden-field">
							  	<xsl:with-param name="name">applicant_act_description</xsl:with-param>
							  	</xsl:call-template>
							  	<xsl:call-template name="hidden-field">
					    			<xsl:with-param name="name">maturity_date</xsl:with-param>
					    		</xsl:call-template>				  								  								  	
				     		</xsl:when>
				     	</xsl:choose>
				      <xsl:call-template name="nickname-field-template"/>
				     				   
				   </xsl:with-param>
				  </xsl:call-template>
				  
				  <!-- column 2 -->		 
				  <xsl:call-template name="column-wrapper">
				   <xsl:with-param name="content">
					  <xsl:call-template name="input-field">
					    <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
					    <xsl:with-param name="id">ref_id_view</xsl:with-param>
					    <xsl:with-param name="value" select="ref_id" />
					    <xsl:with-param name="override-displaymode">view</xsl:with-param>
					  </xsl:call-template>
					  <xsl:call-template name="input-field">
					    <xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
					    <xsl:with-param name="id">appl_date_view</xsl:with-param>
					    <xsl:with-param name="value" select="appl_date" />
					    <xsl:with-param name="override-displaymode">view</xsl:with-param>
					  </xsl:call-template>
						 	<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">sub_product_code</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="sub_product_code"/></xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">value_date_unsigned</xsl:with-param>
					     	<xsl:with-param name="value" select="value_date"></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">display_entity_unsigned</xsl:with-param>
					     	<xsl:with-param name="value" select="entity"></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">sub_product_code_unsigned</xsl:with-param>
					     	<xsl:with-param name="value" select="sub_product_code"></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">td_cur_code_unsigned</xsl:with-param>
					     	<xsl:with-param name="value" select="td_cur_code"></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">td_amt_unsigned</xsl:with-param>
					     	<xsl:with-param name="value" select="td_amt"></xsl:with-param>
						</xsl:call-template>			
					<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">ref_id</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="ref_id"/></xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
					      <xsl:with-param name="name">tnx_type_code</xsl:with-param>
				    </xsl:call-template>
					<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">placement_account_enabled</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="Placement_account_enabled"/></xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">currency_res</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="utils:hasCrossCurrencyRestriction(issuing_bank/abbv_name)"/></xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">service_enabled</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="interest_inquiry_impl"/></xsl:with-param>
					</xsl:call-template>
					<xsl:if test="tnx_type_code[.='03']">
				    	<xsl:call-template name="hidden-field">
				   		 <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
				  		</xsl:call-template>
					</xsl:if>			
					<xsl:call-template name="hidden-field">
			        <xsl:with-param name="name">issuing_bank_name</xsl:with-param>
			        <xsl:with-param name="value"><xsl:value-of select="issuing_bank/name"/></xsl:with-param>
			       </xsl:call-template>
			       <xsl:call-template name="hidden-field">
			        <xsl:with-param name="name">issuing_bank_ref</xsl:with-param>
			        <xsl:with-param name="value"><xsl:value-of select="issuing_bank_ref"/></xsl:with-param>
			       </xsl:call-template>
			        <xsl:call-template name="hidden-field">
				      <xsl:with-param name="name">applicant_reference</xsl:with-param>
				      <xsl:with-param name="value" select="applicant_reference"/>
				   </xsl:call-template>
				   <xsl:call-template name="hidden-field">
			        <xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
			        <xsl:with-param name="value"><xsl:value-of select="issuing_bank/abbv_name"/></xsl:with-param>
			       </xsl:call-template> 
					<!-- Applicant Details -->
					<!-- Hidden fields since show-name and show-address disabled after -->
					<xsl:call-template name="hidden-field">
				      <xsl:with-param name="name">applicant_name</xsl:with-param>
				      <xsl:with-param name="value" select="applicant_name"/>
				     </xsl:call-template>
					<xsl:call-template name="hidden-field">
				      <xsl:with-param name="name">applicant_address_line_1</xsl:with-param>
				      <xsl:with-param name="value" select="applicant_address_line_1"/>
				     </xsl:call-template>
					<xsl:call-template name="hidden-field">
				      <xsl:with-param name="name">applicant_address_line_2</xsl:with-param>
				      <xsl:with-param name="value" select="applicant_address_line_2"/>
				     </xsl:call-template>
					<xsl:call-template name="hidden-field">
				      <xsl:with-param name="name">applicant_dom</xsl:with-param>
				      <xsl:with-param name="value" select="applicant_dom"/>
				     </xsl:call-template>
				    <xsl:call-template name="hidden-field">
				      <xsl:with-param name="name">appl_date</xsl:with-param>
				      <xsl:with-param name="value" select="appl_date"/>
				    </xsl:call-template> 
				    <xsl:call-template name="hidden-field">
				      <xsl:with-param name="name">selected_td_type</xsl:with-param>
				      <xsl:with-param name="value" select="td_type"/>
				    </xsl:call-template> 
				    <xsl:if test="tnx_type_code[.!='13']">
				    <xsl:call-template name="hidden-field">
				      <xsl:with-param name="name">selected_tenor_type</xsl:with-param>
				      <xsl:with-param name="value"><xsl:value-of select="value_date_term_number"/>_<xsl:value-of select="value_date_term_code"/></xsl:with-param>
				    </xsl:call-template> 
				    <xsl:call-template name="hidden-field">
				      <xsl:with-param name="name">selected_maturity_type</xsl:with-param>
				      <xsl:with-param name="value" select="maturity_instruction"/>
				    </xsl:call-template>	
				     <xsl:if test="tnx_type_code[.='03' or .='13']">
				    	 <xsl:call-template name="hidden-field">
				     		 <xsl:with-param name="name">value_date_term_number</xsl:with-param>
				      		 <xsl:with-param name="value" select="value_date_term_number"/>
				    	 </xsl:call-template>
				    	 <xsl:call-template name="hidden-field">
				      	   <xsl:with-param name="name">value_date_term_code</xsl:with-param>
				      	   <xsl:with-param name="value" select="value_date_term_code"/>
				    	 </xsl:call-template>
				    </xsl:if>							    
				    <xsl:call-template name="hidden-field">
				      <xsl:with-param name="name">maturity_mandatory</xsl:with-param>
				      <xsl:with-param name="value" select="maturity_mandatory"/>
				    </xsl:call-template>				    
				    <xsl:call-template name="hidden-field">
				      <xsl:with-param name="name">selected_td_cur</xsl:with-param>
				      <xsl:with-param name="value" select="td_cur_code"/>
				    </xsl:call-template>  
				    <xsl:call-template name="hidden-field">
						<xsl:with-param name="name">tnxId</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="tnx_type_code"/></xsl:with-param>
				   </xsl:call-template>
				   </xsl:if>
				   <xsl:if test="tnx_type_code[.='13']">
				   <xsl:call-template name="hidden-field">
				      <xsl:with-param name="name">td_type</xsl:with-param>
				      <xsl:with-param name="value" select="td_type"/>
				    </xsl:call-template>
				     </xsl:if>
				    <xsl:if test="tnx_type_code[.='03'] or tnx_type_code[.='13']">
				    <xsl:call-template name="hidden-field">
				      <xsl:with-param name="name">value_date_term_number</xsl:with-param>
				      <xsl:with-param name="value" select="value_date_term_number"/>
				    </xsl:call-template>
				   
				    <xsl:call-template name="hidden-field">
				      <xsl:with-param name="name">value_date_term_code</xsl:with-param>
				      <xsl:with-param name="value" select="value_date_term_code"/>
				    </xsl:call-template>
				   </xsl:if>
				    <xsl:call-template name="hidden-field">
				      <xsl:with-param name="name">DueWtdrwDt</xsl:with-param>
				      <xsl:with-param name="value" select="DueWtdrwDt"/>
				    </xsl:call-template>
				    <xsl:call-template name="hidden-field">
				      <xsl:with-param name="name">HoldCode</xsl:with-param>
				      <xsl:with-param name="value" select="HoldCode"/>
				    </xsl:call-template>
				    <xsl:call-template name="hidden-field">
				      <xsl:with-param name="name">PledgeBranchCode</xsl:with-param>
				      <xsl:with-param name="value" select="PledgeBranchCode"/>
				    </xsl:call-template>
				    <xsl:call-template name="hidden-field">
				      <xsl:with-param name="name">FundValDate</xsl:with-param>
				      <xsl:with-param name="value" select="FundValDate"/>
				    </xsl:call-template>
				    <xsl:call-template name="hidden-field">
				      <xsl:with-param name="name">ReplCost</xsl:with-param>
				      <xsl:with-param name="value" select="ReplCost"/>
				    </xsl:call-template>
				    <xsl:call-template name="hidden-field">
				      <xsl:with-param name="name">SibidSibor</xsl:with-param>
				      <xsl:with-param name="value" select="SibidSibor"/>
				    </xsl:call-template>
				    <xsl:call-template name="hidden-field">
				      <xsl:with-param name="name">WaiveIndicator</xsl:with-param>
				      <xsl:with-param name="value" select="WaiveIndicator"/>
				    </xsl:call-template>
				    <xsl:call-template name="hidden-field">
				      <xsl:with-param name="name">TranchNum</xsl:with-param>
				      <xsl:with-param name="value" select="TranchNum"/>
				    </xsl:call-template>
				    <xsl:call-template name="hidden-field">
				      <xsl:with-param name="name">MinAmt</xsl:with-param>
				      <xsl:with-param name="value" select="MinAmt"/>
				    </xsl:call-template>
				    <xsl:call-template name="hidden-field">
				      <xsl:with-param name="name">SgdDepAmt</xsl:with-param>
				      <xsl:with-param name="value" select="SgdDepAmt"/>
				    </xsl:call-template>
				     <xsl:call-template name="hidden-field">
				      <xsl:with-param name="name">SgdXchgRate</xsl:with-param>
				      <xsl:with-param name="value" select="SgdXchgRate"/>
				    </xsl:call-template>
				     <xsl:call-template name="hidden-field">
				      <xsl:with-param name="name">ConvertedAmt</xsl:with-param>
				      <xsl:with-param name="value" select="ConvertedAmt"/>
				    </xsl:call-template>
				     <xsl:call-template name="hidden-field">
				      <xsl:with-param name="name">CtrRate</xsl:with-param>
				      <xsl:with-param name="value" select="CtrRate"/>
				    </xsl:call-template>
				    <xsl:call-template name="hidden-field">
				      <xsl:with-param name="name">FcfdAmt</xsl:with-param>
				      <xsl:with-param name="value" select="FcfdAmt"/>
				    </xsl:call-template>
				    <xsl:call-template name="hidden-field">
				      <xsl:with-param name="name">bank_value_date</xsl:with-param>
				      <xsl:with-param name="value" select="bank_value_date"/>
				    </xsl:call-template>
				    <!-- <xsl:call-template name="hidden-field">
				      <xsl:with-param name="name">applicant_act_no</xsl:with-param>
				      <xsl:with-param name="value" select="applicant_act_no"/>
				    </xsl:call-template> -->
				    <xsl:call-template name="hidden-field">
				      <xsl:with-param name="name">applicant_act_name</xsl:with-param>
				      <xsl:with-param name="value" select="applicant_act_name"/>
				    </xsl:call-template>
				    <xsl:call-template name="hidden-field">
				      <xsl:with-param name="name">applicant_act_cur_code</xsl:with-param>
				      <xsl:with-param name="value" select="applicant_act_cur_code"/>
				    </xsl:call-template>
				    <xsl:call-template name="hidden-field">
						<xsl:with-param name="name">currency_res</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="utils:hasCrossCurrencyRestriction(issuing_bank/abbv_name)"/></xsl:with-param>
					</xsl:call-template>
				    </xsl:with-param>
				  </xsl:call-template>
				  
				 </xsl:with-param>
			  </xsl:call-template> 
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="td-transaction-details">

		<!-- Transaction Details -->
	  	<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_TRANSACTION_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				  <!-- column 1 -->		 
				  <xsl:call-template name="column-wrapper">
				   <xsl:with-param name="content">
				   <!-- Deposit Type -->
				   <xsl:if test="tnx_type_code[.='01']">
				   		<xsl:call-template name="fd-acct-number"/>
				   </xsl:if>
				   
				   <!-- Placement Account --> 
				     <xsl:if test="tnx_type_code[.='01'] or (security:isBank($rundata) and not(tnx_type_code))">
				   	 <div id="placment-div">
					 <xsl:call-template name="user-account-field">
					  	<xsl:with-param name="label">XSL_FD_ACCOUNTT_NUMBER</xsl:with-param>
					  	<xsl:with-param name="name">placement</xsl:with-param>
					    <xsl:with-param name="entity-field">entity</xsl:with-param>
					    <xsl:with-param name="dr-cr">placement</xsl:with-param>
					    <xsl:with-param name="product_types">TD:CSTD</xsl:with-param>
					     <xsl:with-param name="required">
					    	<xsl:choose>
								<xsl:when test="Placement_account_enabled[.='Y']">Y</xsl:when>
								<xsl:otherwise>N</xsl:otherwise>			    	
					    	</xsl:choose>
					    </xsl:with-param>
					    <xsl:with-param name="show-product-types">N</xsl:with-param>
					    <xsl:with-param name="value"><xsl:value-of select="placement_act_name"/></xsl:with-param>
					    <xsl:with-param name="parameter">td_type</xsl:with-param>
					 </xsl:call-template>
					 </div>						 
				    </xsl:if>
				    
				    <!-- Maturity Instructions -->				   
				    <xsl:choose>
			      	 <xsl:when test="$displaymode='edit' and tnx_type_code[.!='13']">
				      <xsl:call-template name="select-field">
					   <xsl:with-param name="label">
			   			<xsl:choose>
							<xsl:when test="tnx_type_code[.='01'] or (security:isBank($rundata) and not(tnx_type_code))">XSL_TD_MATURITY_INSTRUCTIONS</xsl:when>
							<xsl:when test="tnx_type_code[.='03']">XSL_TD_MODIFY_MATURITY_INSTRUCTIONS</xsl:when>
						</xsl:choose>
					   </xsl:with-param>
					    <xsl:with-param name="id">maturity_instruction</xsl:with-param>
					    <xsl:with-param name="required">Y</xsl:with-param>
					    <xsl:with-param name="fieldsize">medium</xsl:with-param>
					    <xsl:with-param name="value">
					    <xsl:choose>
					    	<xsl:when test="(tnx_type_code[.='01'] or tnx_type_code[.='03'] or (security:isBank($rundata) and not(tnx_type_code)))and maturity_instruction[.!='']"><xsl:value-of select="maturity_instruction"/></xsl:when>
					    	<xsl:otherwise></xsl:otherwise>
					    </xsl:choose>
					    </xsl:with-param>
				     </xsl:call-template>
				    </xsl:when>
				   	<xsl:when test="$displaymode='view' and tnx_type_code[.!='13']">
					 <xsl:call-template name="input-field">
					  <xsl:with-param name="label">
						<xsl:choose>
							<xsl:when test="tnx_type_code[.='01'] or (security:isBank($rundata) and not(tnx_type_code))">XSL_TD_MATURITY_INSTRUCTIONS</xsl:when>
							<xsl:when test="tnx_type_code[.='03']">XSL_TD_MODIFY_MATURITY_INSTRUCTIONS</xsl:when>
						</xsl:choose>
					   </xsl:with-param>
					   <xsl:with-param name="value">
						<xsl:choose>
						   <xsl:when test="((tnx_type_code[.='01'] or tnx_type_code[.='03'] or (security:isBank($rundata) and not(tnx_type_code))) or (tnx_type_code[.='03'] and prod_stat_code[.=''])) and maturity_instruction[.!='']"><xsl:value-of select="maturity_instruction_name"/></xsl:when>
						   <xsl:otherwise></xsl:otherwise>
						</xsl:choose>
					    </xsl:with-param>
					 </xsl:call-template>
				    </xsl:when>
				   </xsl:choose>
				   
				   <!-- Value Date -->				
				   <xsl:if test="tnx_type_code[.='01']">
					  <xsl:call-template name="business-date-field">
							<xsl:with-param name="label">XSL_TD_VALUE_DATE</xsl:with-param>
							<xsl:with-param name="name">value_date</xsl:with-param>
							<xsl:with-param name="size">10</xsl:with-param>
							<xsl:with-param name="maxsize">10</xsl:with-param>
							<xsl:with-param name="required">Y</xsl:with-param>
							<xsl:with-param name="fieldsize">small</xsl:with-param>
							<xsl:with-param name="sub-product-code-widget-id">sub_product_code</xsl:with-param>
							<xsl:with-param name="bank-abbv-name-widget-id">issuing_bank_abbv_name</xsl:with-param>
							<xsl:with-param name="cur-code-widget-id">td_cur_code</xsl:with-param>
							<xsl:with-param name="override-displaymode">
								<xsl:choose>
									<xsl:when test="$displaymode = 'edit'">edit</xsl:when>
		    						<xsl:otherwise>view</xsl:otherwise>
								</xsl:choose>
		  					</xsl:with-param>
						</xsl:call-template>
					</xsl:if>				   	
				   </xsl:with-param>
				  </xsl:call-template>
				  				  
				  <!-- column 2 -->		 
				  <xsl:call-template name="column-wrapper">
				   <xsl:with-param name="content">
				   
				   	<!-- Tenor days -->
					  <xsl:if test="tnx_type_code[.='01']">	
						  <xsl:choose>
						   <xsl:when test="$displaymode='view'">
							  <xsl:call-template name="input-field">
							    <xsl:with-param name="label">XSL_GENERALDETAILS_TENOR</xsl:with-param>
							    <xsl:with-param name="id">tenor_term_code</xsl:with-param>
							    <xsl:with-param name="required">Y</xsl:with-param>
							     <xsl:with-param name="value"><xsl:value-of select="value_date_term_number"/>&nbsp;<xsl:value-of select="localization:getDecode($language, 'N413', value_date_term_code)"/></xsl:with-param>
							     <xsl:with-param name="override-displaymode">view</xsl:with-param>
							  </xsl:call-template>   
					       </xsl:when>
					       <xsl:otherwise>
					        <div class="field">
							  <xsl:call-template name="select-field">
							    <xsl:with-param name="label">XSL_GENERALDETAILS_TENOR</xsl:with-param>
							    <xsl:with-param name="id">tenor_term_code</xsl:with-param>
							    <xsl:with-param name="required">Y</xsl:with-param>
							    <xsl:with-param name="appendClass">inlineComponent</xsl:with-param>
							    <xsl:with-param name="value"><xsl:value-of select="value_date_term_number"/>_<xsl:value-of select="value_date_term_code"/></xsl:with-param>
							  </xsl:call-template>  
							  (<a class="InterestRatesAlink" target="_blank">
								 <xsl:attribute name="href"><xsl:value-of select="interest_rates_url"/></xsl:attribute>
								 <xsl:value-of select="localization:getGTPString($language, 'XSL_TD_VIEW_INTEREST_RATES_LINK')"/>
							  </a>)
							  </div>
					       </xsl:otherwise>
					      </xsl:choose>	
				      </xsl:if>		 
					
					<!-- Placement Amount -->
					<xsl:choose>
						<xsl:when test="tnx_type_code[.='01' or .='03' or .='13'] or (security:isBank($rundata) and not(tnx_type_code))">
							<xsl:call-template name="td-placement-amt-details">
						       <xsl:with-param name="override-product-code">td</xsl:with-param>
						    </xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							  <xsl:call-template name="hidden-field">
							      <xsl:with-param name="name">td_amt</xsl:with-param>
							      <xsl:with-param name="value" select="td_amt"/>
							  </xsl:call-template>
							  <xsl:call-template name="hidden-field">
							      <xsl:with-param name="name">td_cur_code</xsl:with-param>
							      <xsl:with-param name="value" select="td_cur_code"/>
							  </xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
					
				  <xsl:if test="$displaymode='edit' and banks_fx_rates/fx_bank_params and banks_fx_rates/fx_bank_params/fx_bank_product_details/fx_bank_properties/fx_assign_products[.='Y']">
				    <xsl:call-template name="hidden-field">
				      <xsl:with-param name="name">fx_rates_type_temp</xsl:with-param>
				      <xsl:with-param name="value"><xsl:value-of select="fx_rates_type"></xsl:value-of></xsl:with-param>
				     </xsl:call-template>
				     <xsl:call-template name="hidden-field">
				      <xsl:with-param name="name">fx_master_currency</xsl:with-param>
				     <xsl:with-param name="value"><xsl:value-of select="fx_contract_nbr_cur_code_1"></xsl:value-of></xsl:with-param>
				    </xsl:call-template>    
			      </xsl:if>		
			      
			         <!-- Tenor -->
		 <xsl:if test="value_date_term_code[. != ''] and tnx_type_code[.!='01'] and $displaymode='view' or (not(tnx_type_code) and prod_stat_code[.='03'] and security:isCustomer($rundata))">	
	   <xsl:call-template name="row-wrapper">
	    <xsl:with-param name="label">XSL_GENERALDETAILS_TENOR</xsl:with-param>
	    <xsl:with-param name="id">td_common_value_date_term_number_view</xsl:with-param>
	    <xsl:with-param name="content"><div class="content">
	        <xsl:value-of select="value_date_term_number"/>&nbsp;<xsl:value-of select="localization:getDecode($language, 'N413', value_date_term_code)"/>
	    	<!--<xsl:choose>
	    	<xsl:when test="value_date_term_code[.='01']">1 Month</xsl:when>
	    	<xsl:when test="value_date_term_code[.='02']">2 Month</xsl:when>
	    	</xsl:choose>
          --></div></xsl:with-param>
	  </xsl:call-template>
		</xsl:if>	      		  
				<!-- Credit Account -->
				<xsl:call-template name="user-account-field">
				  	<xsl:with-param name="label">XSL_TD_CREDIT_ACCOUNT</xsl:with-param>
				  	<xsl:with-param name="name">credit</xsl:with-param>
				    <xsl:with-param name="entity-field">entity</xsl:with-param>
				    <xsl:with-param name="dr-cr">credit</xsl:with-param>
				    <xsl:with-param name="product_types">TD:CSTD</xsl:with-param>
				    <xsl:with-param name="required">Y</xsl:with-param>
				    <xsl:with-param name="show-product-types">N</xsl:with-param>
				    <xsl:with-param name="value">
					<xsl:choose>
					 <xsl:when test="$displaymode = 'edit'">
					  <xsl:choose>
					   <xsl:when test="(tnx_type_code[.='01'] or (security:isBank($rundata) and not(tnx_type_code))) or (tnx_type_code[.='03']) or (tnx_type_code[.='13'] and prod_stat_code[.=''])">
					   <xsl:value-of select="credit_act_name"/></xsl:when>
     				  </xsl:choose>
					  </xsl:when>
					  <xsl:otherwise>
					   <xsl:value-of select="credit_act_name"/>
					  </xsl:otherwise>	
				   </xsl:choose>
				   </xsl:with-param>	
				 </xsl:call-template>	
				 
				</xsl:with-param>
			   </xsl:call-template>		
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="td-interest-rate-details">
		<!-- Interest Rate Details-->
	  	<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_TD_INTEREST_RATE_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
			 <xsl:call-template name="column-wrapper">
				   <xsl:with-param name="content">
				<!-- Interest Rate -->
			     <xsl:choose>
				  <xsl:when test="tnx_type_code[.='03'] or tnx_type_code[.='13']">
				 	<xsl:call-template name="input-field">
				     <xsl:with-param name="label">XSL_TD_INTEREST_RATE_PA</xsl:with-param>
				     <xsl:with-param name="name">interest</xsl:with-param>
				     <xsl:with-param name="content-after">%</xsl:with-param>
				     <xsl:with-param name="override-displaymode">view</xsl:with-param>
				    </xsl:call-template>
				  </xsl:when>
				  <xsl:otherwise>
				   <div>
				 	<xsl:choose>
				     <xsl:when test="$displaymode='edit'">
					    <xsl:call-template name="input-field">
					     <xsl:with-param name="label">XSL_TD_INTEREST_RATE_PA</xsl:with-param>
					     <xsl:with-param name="name">display_interest</xsl:with-param>
					     <xsl:with-param name="fieldsize">x-small</xsl:with-param>
					     <xsl:with-param name="size">5</xsl:with-param>
					     <xsl:with-param name="maxsize">5</xsl:with-param>
					     <xsl:with-param name="required">Y</xsl:with-param>
					     <xsl:with-param name="readonly">Y</xsl:with-param>
					     <xsl:with-param name="content-after">%</xsl:with-param>
					     <xsl:with-param name="value"><xsl:value-of select="interest"/></xsl:with-param>
					     <xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
					    </xsl:call-template>
				        <span id="interestLink">
					      (<a>
					         <xsl:attribute name="href">javascript:void(0)</xsl:attribute>
					         <xsl:attribute name="onclick">javascript:misys.getInterestDetails();</xsl:attribute>
					         <xsl:attribute name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_TD_RETRIEVE_INTEREST_RATES_LINK')"/></xsl:attribute>
					         <xsl:value-of select="localization:getGTPString($language, 'XSL_TD_RETRIEVE_INTEREST_RATES_LINK')"/>
					        </a>)
					    </span>
					    <xsl:call-template name="hidden-field">
						     <xsl:with-param name="name">interest</xsl:with-param>
						</xsl:call-template>   					   		
				    </xsl:when>
				    <xsl:otherwise>
				         <xsl:call-template name="input-field">
					     <xsl:with-param name="label">XSL_TD_INTEREST_RATE_PA</xsl:with-param>
					     <xsl:with-param name="name">interest</xsl:with-param>
					     <xsl:with-param name="value"><xsl:value-of select="interest * 100"/></xsl:with-param>
					     <xsl:with-param name="content-after">%</xsl:with-param>
					     <xsl:with-param name="override-displaymode">view</xsl:with-param>
					    </xsl:call-template>					   	
				    </xsl:otherwise>
				   </xsl:choose>
			      </div>
				 </xsl:otherwise>
				 </xsl:choose>
				 <xsl:choose>
				 <xsl:when test="$displaymode='edit'"> 
				   <div id="equivalent-contract-amt">
					<xsl:call-template name="currency-field">
				      	<xsl:with-param name="label">XSL_TD_EQUIVALENT_CONTRACT_AMOUNT</xsl:with-param>
					   	<xsl:with-param name="product-code">contract</xsl:with-param>
					   	<xsl:with-param name="currency-readonly">Y</xsl:with-param>
   						<xsl:with-param name="amt-readonly">Y</xsl:with-param>	
   						<xsl:with-param name="show-button">N</xsl:with-param>
				    </xsl:call-template>
				   </div>
				 </xsl:when>
				 <xsl:otherwise>				
				 <xsl:variable name="field-name">contract_amt</xsl:variable>
				     <xsl:call-template name="input-field">					      
				       <xsl:with-param name="label">XSL_TD_EQUIVALENT_CONTRACT_AMOUNT</xsl:with-param>
				       <xsl:with-param name="name"><xsl:value-of select="$field-name"/></xsl:with-param>
				       <xsl:with-param name="override-displaymode">view</xsl:with-param>
				       <xsl:with-param name="value">
				         <xsl:variable name="field-value"><xsl:value-of select="fx_total_utilise_amt"/></xsl:variable>
				         <xsl:variable name="curcode-field-name">contract_cur_code</xsl:variable>
				         <xsl:variable name="curcode-field-value"><xsl:value-of select="applicant_act_cur_code"/></xsl:variable>
					     <xsl:if test="$field-value !=''">
					      <xsl:value-of select="$curcode-field-value"/>&nbsp;<xsl:value-of select="$field-value"/>
					     </xsl:if>
					   </xsl:with-param>
					 </xsl:call-template>	
				 </xsl:otherwise>
				 </xsl:choose>				  	 
				</xsl:with-param>
			   </xsl:call-template>			
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!-- Placement Amount Fields -->
	<xsl:template name="td-placement-amt-details">
	  <xsl:param name="override-product-code" select="$lowercase-product-code"/>
	  <div>
	     <xsl:choose>
	     <xsl:when test="$displaymode='edit'">
	     	<xsl:choose>
	     		<xsl:when test="tnx_type_code[.!='03'] and tnx_type_code[.!='13']">
	     			<xsl:call-template name="select-field">
					     <xsl:with-param name="label">XSL_TD_PLACEMENT_AMOUNT</xsl:with-param>
					     <xsl:with-param name="name">td_cur_code</xsl:with-param>
					     <xsl:with-param name="fieldsize">x-small</xsl:with-param>
					     <xsl:with-param name="size">3</xsl:with-param>
					     <xsl:with-param name="maxsize">3</xsl:with-param>
					     <xsl:with-param name="required">Y</xsl:with-param>
					     <xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
					     <xsl:with-param name="value"><xsl:value-of select="td_cur_code"/></xsl:with-param>
				     </xsl:call-template>
				     <xsl:call-template name="currency-field">
					     <xsl:with-param name="fieldsize">small</xsl:with-param>
					     <xsl:with-param name="product-code">td</xsl:with-param>
					     <xsl:with-param name="required">Y</xsl:with-param>
					     <xsl:with-param name="show-currency">N</xsl:with-param>
					     <xsl:with-param name="show-button">N</xsl:with-param>
					     <xsl:with-param name="appendClass">inlineBlock inlineBlockNoLabel NoAsterik</xsl:with-param>
					     <xsl:with-param name="value"><xsl:value-of select="td_amt"/></xsl:with-param>
					     <xsl:with-param name="override-amt-name">td_amt</xsl:with-param>
				     </xsl:call-template>
	     		</xsl:when>
	     		<xsl:otherwise>
	     			<xsl:call-template name="hidden-field">
					      <xsl:with-param name="name">td_amt</xsl:with-param>
					      <xsl:with-param name="value" select="td_amt"/>
					</xsl:call-template>
	     			<xsl:call-template name="hidden-field">
					      <xsl:with-param name="name">td_cur_code</xsl:with-param>
					      <xsl:with-param name="value" select="td_cur_code"/>
					</xsl:call-template>
	     		</xsl:otherwise>
	     	</xsl:choose>
	     </xsl:when>
	     <xsl:when test="$displaymode='view'">
	      <xsl:variable name="field-name"><xsl:value-of select="$override-product-code"/>_amt</xsl:variable>
	      <xsl:call-template name="input-field">
	       <xsl:with-param name="label">XSL_TD_PLACEMENT_AMOUNT</xsl:with-param>
	       <xsl:with-param name="name"><xsl:value-of select="$override-product-code"/>_amt</xsl:with-param>
	       <xsl:with-param name="override-displaymode">view</xsl:with-param>
	       <xsl:with-param name="value">
	         <xsl:variable name="field-value"><xsl:value-of select="//*[name()=$field-name]"/></xsl:variable>
	         <xsl:variable name="curcode-field-name"><xsl:value-of select="$override-product-code"/>_cur_code</xsl:variable>
	         <xsl:variable name="curcode-field-value"><xsl:value-of select="//*[name()=$curcode-field-name]"/></xsl:variable>
		     <xsl:if test="$field-value !=''">
		      <xsl:value-of select="$curcode-field-value"></xsl:value-of>&nbsp;<xsl:value-of select="$field-value"></xsl:value-of>
		     </xsl:if>
		   </xsl:with-param>
	      </xsl:call-template>
		  <xsl:call-template name="hidden-field">
		      <xsl:with-param name="name">td_amt</xsl:with-param>
		      <xsl:with-param name="value" select="td_amt"/>
		  </xsl:call-template>
		  <xsl:call-template name="hidden-field">
		      <xsl:with-param name="name">td_cur_code</xsl:with-param>
		      <xsl:with-param name="value" select="td_cur_code"/>
		  </xsl:call-template>
	     </xsl:when>
	     </xsl:choose>
	  </div>
	  </xsl:template>
  
	<!-- Deposit Type Template -->
	<xsl:template name="fd-acct-number">
		<xsl:choose>	
			<xsl:when test="$displaymode='edit'">
			    <xsl:call-template name="select-field">
			    <xsl:with-param name="label">XSL_TD_DEPOSIT_TYPE</xsl:with-param>
			    <xsl:with-param name="name">td_type</xsl:with-param>
			    <xsl:with-param name="required">Y</xsl:with-param>
			    <xsl:with-param name="value" select="td_type"/>
			  	</xsl:call-template>
		  	</xsl:when>
		  	<xsl:otherwise>
			  <xsl:choose>
				<xsl:when test="$displaymode='view'">
				  <xsl:call-template name="input-field">
				  <xsl:with-param name="label">XSL_TD_DEPOSIT_TYPE</xsl:with-param>
				  <xsl:with-param name="required">Y</xsl:with-param>
				  <xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N414', td_type)"/></xsl:with-param>
				  </xsl:call-template>
				</xsl:when>
			  </xsl:choose>
		  	</xsl:otherwise>
	  	</xsl:choose>
  </xsl:template>
  
   <!--
   Hidden fields for TD placement
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
      <xsl:with-param name="name">tnxtype</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="tnx_type_code"/></xsl:with-param>
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
      <xsl:with-param name="value">
      <xsl:choose>
      <xsl:when test="$optionmode='CANCEL'">CANCEL</xsl:when>
      </xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
     <xsl:if test="tnx_type_code[.='01']">
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">interestToken</xsl:with-param>
     </xsl:call-template>
     </xsl:if>
     <xsl:if test="$displaymode='edit' and banks_fx_rates/fx_bank_params and banks_fx_rates/fx_bank_params/fx_bank_product_details/fx_bank_properties/fx_assign_products[.='Y']">
      <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">fxinteresttoken</xsl:with-param>
     </xsl:call-template>
     </xsl:if>
     <xsl:call-template name="e2ee_transaction"/>
     <xsl:call-template name="reauth_params"/>
     <xsl:call-template name="localization-dialog"/>
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <!-- Transactional Remarks -->
  <xsl:template name="transactional-remarks-details">
  	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_TD_TRANSACTION_REMARKS</xsl:with-param>
		<xsl:with-param name="content">
		<xsl:call-template name="row-wrapper">
		      <xsl:with-param name="type">textarea</xsl:with-param>
		      <xsl:with-param name="content">
		       <xsl:call-template name="textarea-field">
		        <xsl:with-param name="name">remarks</xsl:with-param>
		        <xsl:with-param name="rows">2</xsl:with-param>
				<xsl:with-param name="cols">114</xsl:with-param>
				<xsl:with-param name="maxlines">2</xsl:with-param>
		       </xsl:call-template>
		      </xsl:with-param>
     		</xsl:call-template> 
		</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="input-field">
	        <xsl:with-param name="label">XSL_TD_NOTE</xsl:with-param>
	        <xsl:with-param name="id">td_note_view</xsl:with-param>
	        <xsl:with-param name="value">
				<xsl:value-of select="localization:getGTPString($language,'XSL_TD_LABEL')"/>
			</xsl:with-param>
	        <xsl:with-param name="override-displaymode">view</xsl:with-param>
	  </xsl:call-template>
	</xsl:template>
  
  <xsl:template match="deposit_details">
     <xsl:apply-templates select="deposit_type"/>
   </xsl:template>

	<xsl:template match="deposit_type">
	<script>
	dojo.ready(function(){
	misys._config = misys._config || {};
	misys._config.depositTypes = misys._config.depositTypes || [];
	misys._config.depositTypes.push("<xsl:value-of select="deposit_name"/>,<xsl:value-of select="localization:getDecode($language, 'N414', deposit_name)"/>");
	misys._config.depositTypes['<xsl:value-of select="deposit_name"/>'] = misys._config.depositTypes['<xsl:value-of select="deposit_name"/>'] || [];
	<xsl:apply-templates select="tenor_type" />
	});
	</script>
	</xsl:template>

	<xsl:template match="tenor_type">
	misys._config.depositTypes['<xsl:value-of select="../deposit_name"/>'].tenor = misys._config.depositTypes['<xsl:value-of select="../deposit_name"/>'].tenor || [];
	misys._config.depositTypes['<xsl:value-of select="../deposit_name"/>'].tenor.push("<xsl:value-of select="tenor_number"/>_<xsl:value-of select="tenor_code"/>");
	misys._config.depositTypes['<xsl:value-of select="../deposit_name"/>'].tenor['<xsl:value-of select="tenor_number"/>_<xsl:value-of select="tenor_code"/>'] = misys._config.depositTypes['<xsl:value-of select="../deposit_name"/>'].tenor['<xsl:value-of select="tenor_number"/>_<xsl:value-of select="tenor_code"/>'] || [];
	misys._config.depositTypes['<xsl:value-of select="../deposit_name"/>'].tenor['<xsl:value-of select="tenor_number"/>_<xsl:value-of select="tenor_code"/>'].key = "<xsl:value-of select="tenor_number"/>_<xsl:value-of select="tenor_code"/>";
	<xsl:choose>
	<xsl:when test="tenor_number [.='1']">
			misys._config.depositTypes['<xsl:value-of select="../deposit_name"/>'].tenor['<xsl:value-of select="tenor_number"/>_<xsl:value-of select="tenor_code"/>'].value = "<xsl:value-of select="tenor_number"/>&nbsp;<xsl:value-of select="localization:getDecode($language, 'N413_S', tenor_code)"/>"
	</xsl:when>
	<xsl:otherwise>
		misys._config.depositTypes['<xsl:value-of select="../deposit_name"/>'].tenor['<xsl:value-of select="tenor_number"/>_<xsl:value-of select="tenor_code"/>'].value = "<xsl:value-of select="tenor_number"/>&nbsp;<xsl:value-of select="localization:getDecode($language, 'N413', tenor_code)"/>"
	</xsl:otherwise>
	</xsl:choose>
	<xsl:apply-templates select="currency_code" />
	</xsl:template>
	
	<xsl:template match="currency_code">
	misys._config.depositTypes['<xsl:value-of select="../../deposit_name"/>'].tenor['<xsl:value-of select="../tenor_number"/>_<xsl:value-of select="../tenor_code"/>'].currency = misys._config.depositTypes['<xsl:value-of select="../../deposit_name"/>'].tenor['<xsl:value-of select="../tenor_number"/>_<xsl:value-of select="../tenor_code"/>'].currency || [];
	misys._config.depositTypes['<xsl:value-of select="../../deposit_name"/>'].tenor['<xsl:value-of select="../tenor_number"/>_<xsl:value-of select="../tenor_code"/>'].currency.push("<xsl:value-of select="."/>");
	</xsl:template>
	
	<xsl:template name="simple-disclaimer">
		<xsl:param name="label"/>
		<div><xsl:value-of select="localization:getGTPString($language, $label)" disable-output-escaping="yes" /></div>
	</xsl:template>
	
	<xsl:template name="customer-bank-field">
		<xsl:choose>
			<xsl:when test="$displaymode = 'edit' and tnx_type_code[.!='03' and .!='13']">
				<xsl:call-template name="select-field">
				<xsl:with-param name="label">CUSTOMER_BANK_LABEL</xsl:with-param>
				<xsl:with-param name="name">customer_bank</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
			</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				 <xsl:if test="issuing_bank/name">
					<xsl:call-template name="row-wrapper">
						<xsl:with-param name="label">CUSTOMER_BANK_LABEL</xsl:with-param>
						<xsl:with-param name="id">issuing_bank_name_view</xsl:with-param>
						<xsl:with-param name="content">
							<div class="content">
								<xsl:value-of select="issuing_bank/name" />
							</div>
						</xsl:with-param>          
					</xsl:call-template>
			</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="tnx_type_code[.='03' or .='13']">
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">customer_bank</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="customer_bank"/></xsl:with-param>
			</xsl:call-template>
		</xsl:if>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">customer_bank_hidden</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="customer_bank"/></xsl:with-param>
		</xsl:call-template>
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