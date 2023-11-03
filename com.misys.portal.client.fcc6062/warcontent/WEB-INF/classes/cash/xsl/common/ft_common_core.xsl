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
		xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools"
		exclude-result-prefixes="localization securitycheck utils security defaultresource converttools">
	
	<xsl:include href="recurring_common.xsl" />
	<xsl:param name="transaction_confirmation_details_enable"/>
 	<xsl:param name="isMultiBank">N</xsl:param>
 	<xsl:param name="nicknameEnabled">false</xsl:param>
 	
	<xsl:template name="multibank-common-details">					 		
		dojo.mixin(misys._config, {
					entityBanksCollection : {
			   			<xsl:if test="count(/ft_tnx_record/avail_main_banks/entities_banks_list/entity_banks/mb_entity) > 0" >
			        		<xsl:for-each select="/ft_tnx_record/avail_main_banks/entities_banks_list/entity_banks/mb_entity" >
			        			<xsl:variable name="mb_entity" select="self::node()/text()" />
			  						<xsl:value-of select="."/>: [
			   						<xsl:for-each select="/ft_tnx_record/avail_main_banks/entities_banks_list/entity_banks[mb_entity=$mb_entity]/customer_bank" >
			   							{ value:"<xsl:value-of select="."/>",
					         				name:"<xsl:value-of select="."/>"},
			   						</xsl:for-each>
			   						]<xsl:if test="not(position()=last())">,</xsl:if>
			         		</xsl:for-each>
			       		</xsl:if>
					},
					<!-- Banks for without entity customers.  -->
					wildcardLinkedBanksCollection : {
			   			<xsl:if test="count(/ft_tnx_record/avail_main_banks/bank/abbv_name) > 0" >
			  						"customerBanksForWithoutEntity" : [
				        			<xsl:for-each select="/ft_tnx_record/avail_main_banks/bank[customer_reference != '']/abbv_name" >
			   							{ value:"<xsl:value-of select="."/>",
					         				name:"<xsl:value-of select="."/>"},
				         			</xsl:for-each>
			   						]
			       		</xsl:if>
					},
					customerBankDetails : {
			       		<xsl:if test="count(/ft_tnx_record/customer_banks_details/bank_abbv_desc/bank_abbv_name) > 0" >
			        		<xsl:for-each select="/ft_tnx_record/customer_banks_details/bank_abbv_desc/bank_abbv_name" >
			        			<xsl:variable name="bank_abbv_name" select="self::node()/text()" />
			  						<xsl:value-of select="."/>: [
			   						<xsl:for-each select="/ft_tnx_record/customer_banks_details/bank_abbv_desc[bank_abbv_name=$bank_abbv_name]/bank_desc" >
			   							{ value:"<xsl:value-of select="."/>",
					         				name:"<xsl:value-of select="."/>"},
			   						</xsl:for-each>
			   						]<xsl:if test="not(position()=last())">,</xsl:if>
			         		</xsl:for-each>
			       		</xsl:if>
					}
				});
	</xsl:template>									 		
 	
	
	 <!--Initiate fieldset -->
	 <xsl:template name="intermediary-section">
	 	<xsl:param name="sub-product-label"/>
	 	<xsl:param name="transfer-from-label">XSL_TRANSFER_FROM</xsl:param>
	 	<xsl:param name="recurring-disabled">Y</xsl:param> 
	 	<xsl:param name="recurring-displaymode">view</xsl:param>
	 	<xsl:param name="product_types"/>
	 	<xsl:param name="show-product-types">Y</xsl:param>
	 	
	 	<xsl:call-template name="fieldset-wrapper">
    		<xsl:with-param name="content">
    			<div>    	
				  	<xsl:call-template name="entity-field">
					    <xsl:with-param name="required">Y</xsl:with-param>
					    <xsl:with-param name="button-type">
						    <xsl:choose>
					    		 <xsl:when test="sub_product_code='BILLP' or sub_product_code='BILLS'">entity-basic</xsl:when>
					    		 <xsl:otherwise>entity</xsl:otherwise>
					    	</xsl:choose>
				    	</xsl:with-param>
					    <xsl:with-param name="prefix">applicant</xsl:with-param>
					    <xsl:with-param name="override_company_abbv_name"><xsl:value-of select="customer_payee/customer_payee_record/bank_abbv_name"/></xsl:with-param>
					    <xsl:with-param name="override-sub-product-code">
						    <xsl:choose>
						    	<xsl:when test="sub_product_code !=''">
						    		<xsl:value-of select="sub_product_code"/>
						    	</xsl:when>
						    	<xsl:otherwise>
						    		<xsl:value-of select="$product_types"/>
						    	</xsl:otherwise>
						    </xsl:choose>
					    </xsl:with-param>					    
				    </xsl:call-template>	
				    <xsl:if test="$isMultiBank='Y'">
				    	<xsl:call-template name="input-field">
				    		<xsl:with-param name="label">BANK_LABEL</xsl:with-param>	
							<xsl:with-param name="fieldsize">small</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="/ft_tnx_record/customer_payee/customer_payee_record/bank_abbv_name"></xsl:value-of></xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="name">customer_bank</xsl:with-param>
							<xsl:with-param name="override-product-code"><xsl:value-of select="product_code"/></xsl:with-param>
							<xsl:with-param name="override-sub-product-code">
		   						<xsl:choose>
							      	<xsl:when test="sub_product_code[.='BILLP'] or sub_product_code[.='BILLS']"><xsl:value-of select="product_code"/></xsl:when>
							      	<xsl:otherwise>none</xsl:otherwise>
							     </xsl:choose>
		   					</xsl:with-param>
				    	</xsl:call-template>	
				    </xsl:if>
			    	<xsl:call-template name="user-account-field">
				     	<xsl:with-param name="label" select = "$transfer-from-label"/>			
					    <xsl:with-param name="name">applicant</xsl:with-param>
					    <xsl:with-param name="entity-field">entity</xsl:with-param>
					    <xsl:with-param name="dr-cr">debit</xsl:with-param>
					    <xsl:with-param name="show-product-types" select = "$show-product-types"/>
					    <xsl:with-param name="product_types"><xsl:value-of select="$product_types"/></xsl:with-param>
					    <xsl:with-param name="product-types-required">Y</xsl:with-param>
					    <xsl:with-param name="required">Y</xsl:with-param>
			    	</xsl:call-template>
				   <div id="recurring_payment_checkbox_div">
				   <xsl:call-template name="multichoice-field">
          		 		<xsl:with-param name="label">XSL_RECURRING_PAYMENT</xsl:with-param>
          		 		<xsl:with-param name="type">checkbox</xsl:with-param>
           		 		<xsl:with-param name="name">recurring_flag</xsl:with-param>
           		 		<xsl:with-param name="disabled" select = "$recurring-disabled"/>	           		 		
           		 		<xsl:with-param name="override-displaymode" select = "$recurring-displaymode"/>	           		 		
	            	</xsl:call-template>
	               </div>
			   </div>
			   <div id="initButtons" style="text-align:center;">
					<button dojoType="dijit.form.Button" id="button_intrmdt_ok">
						<xsl:value-of select="localization:getGTPString($language, 'OK')"/>
					</button>
     		  </div>
		     <xsl:if test="$displaymode='edit'">
		        <script>
		        	dojo.ready(function(){
		        		misys._config = misys._config || {};
						misys._config.customerReferences = {};
						<xsl:apply-templates select="avail_main_banks/bank" mode="customer_references"/>
					});
				</script>
		     </xsl:if>
	   		</xsl:with-param>
   		</xsl:call-template>
	 </xsl:template>
		
	<!--
  	 General Details Fieldset. 
   	-->
  	 <xsl:template name="general-details">
  		 <xsl:param name="show-template-id">Y</xsl:param>
  		 <xsl:param name="transfer-from-label">XSL_TRANSFER_FROM</xsl:param>
	   	 <xsl:call-template name="fieldset-wrapper">   		
	   		<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
	   		<xsl:with-param name="content"> 	   			
	   			<xsl:call-template name="column-container">
				 <xsl:with-param name="content">			 
				  <xsl:call-template name="column-wrapper">
				   <xsl:with-param name="content">
				   		<xsl:if test="bulk_ref_id[.!='']">
							<div id="display_bulk_ref_id_row" class="field">
								<span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_BK_REF_ID')"/>&nbsp;</span>
								<div class="content"><xsl:value-of select="bulk_ref_id"/></div> 
							</div>
						</xsl:if>
						<xsl:if test="entities[number(.) &gt; 0] and $displaymode='edit'">
							<div id="display_entity_row" class="field">
								<span class="label"><xsl:value-of select="localization:getGTPString($language, 'ENTITY_LABEL')"/></span>
								<div class="content"><xsl:value-of select="entity"/></div> 
							</div>						
							</xsl:if>
						<div id="display_account_row" class="field">
							<span class="label"><xsl:value-of select="localization:getGTPString($language, $transfer-from-label)"/>&nbsp;</span>
							<div class="content"><xsl:value-of select="applicant_act_name"/></div> 
						</div>
						<xsl:if test="security:isCustomer($rundata) and securitycheck:hasPermission($rundata,'sy_account_nickname_access') ">
						<xsl:call-template name="nickname-field-template"/>
						</xsl:if>
					   <!-- Bulk Specific FT Types -->
					  <xsl:choose>
					   <xsl:when test="bulk_ref_id[.=''] and sub_product_code[.!='BANKB']">
						<div id="display_sub_product_code_row" class="field">
							<span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_SUB_PRODUCT')"/>&nbsp;</span>
							<div class="content"><xsl:if test="sub_product_code[.!='']"><xsl:value-of select="localization:getDecode($language, 'N047', sub_product_code)"/></xsl:if></div> 
						</div>
					   </xsl:when>
					   <xsl:otherwise>
					    <div id="display_sub_product_code_row" class="field">
							<span class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_SUB_PRODUCT')"/>&nbsp;</span>
							<div class="content"><xsl:if test="sub_product_code[.!='']"><xsl:value-of select="localization:getDecode($language, 'N047', concat(sub_product_code,'_BK'))"/></xsl:if></div> 
						</div>
					   </xsl:otherwise>
					  </xsl:choose>
					  

				   </xsl:with-param>
			      </xsl:call-template>			 	
				  <xsl:call-template name="column-wrapper">
				   <xsl:with-param name="content">	
						<xsl:call-template name="input-field">
					     	<xsl:with-param name="label">BANK_LABEL</xsl:with-param>	
							<xsl:with-param name="fieldsize">small</xsl:with-param>
				   			<xsl:with-param name="override-displaymode">view</xsl:with-param>
				   			<xsl:with-param name="value">
								<xsl:choose>
	      							<xsl:when test="sub_product_code='BILLS'">
	      								<xsl:value-of select="/ft_tnx_record/customer_banks_details/bank_abbv_desc/bank_desc"/>
	      							</xsl:when>
	      							<xsl:when test="sub_product_code='BILLP'">
	      								<xsl:value-of select="issuing_bank/name"/>
	      							</xsl:when>
	      							<xsl:otherwise><xsl:value-of select="issuing_bank/name"/></xsl:otherwise>
	      						</xsl:choose>
							</xsl:with-param>
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
	
	<!--
  	 Foreign Exchange Details Fieldset. 
   	-->
   	<xsl:template name="forex-details">
   		<xsl:call-template name="fieldset-wrapper">
	     	<xsl:with-param name="legend">XSL_HEADER_FOREIGN_EXCHANGE_DETAILS</xsl:with-param>
	     	<xsl:with-param name="content">
	     	</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!--
  	 Beneficiary Advice Details Fieldset. 
   	-->
   	<xsl:template name="beneficiary-advice-details">
   	<xsl:if test="bene_adv_flag[.='Y']">
   		<xsl:call-template name="fieldset-wrapper">
	     	<xsl:with-param name="legend">XSL_HEADER_BENEFICIARY_ADVICE_DETAILS</xsl:with-param>
	     	<xsl:with-param name="content">
	     	</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
	</xsl:template>
	
	<!--
  	 Transaction Remarks Details Fieldset. 
   	-->
      	<xsl:template name="transaction-remarks-details">
   		<xsl:param name="override-displaymode"/>
   		<xsl:call-template name="fieldset-wrapper">
	     	<xsl:with-param name="legend">
	     		<xsl:choose>
		<xsl:when test="sub_product_code ='HVPS' or sub_product_code ='HVXB'">XSL_HEADER_TRANSACTION_PAYMENT_NARRATIVE</xsl:when>
	     			<xsl:otherwise>XSL_HEADER_TRANSACTION_REMARKS_DETAILS</xsl:otherwise>
	     		</xsl:choose>
	     	</xsl:with-param>

	     	<xsl:with-param name="content">
		     	<xsl:choose>

		     		<xsl:when test="sub_product_code ='HVPS' or sub_product_code ='HVXB'">
			    		<xsl:call-template name="textarea-field">	
			        <xsl:with-param name="name">free_format_text</xsl:with-param>
					        <xsl:with-param name="cols">64</xsl:with-param>
					        <xsl:with-param name="rows">2</xsl:with-param>
					        <xsl:with-param name="required">Y</xsl:with-param>
					        <xsl:with-param name="maxlines">2</xsl:with-param>
					        <xsl:with-param name="swift-validate">N</xsl:with-param>
					        <xsl:with-param name="override-displaymode">
								<xsl:choose>
								   	<xsl:when test="$override-displaymode != '' "><xsl:value-of select="$override-displaymode"/></xsl:when>
									<xsl:otherwise><xsl:value-of select="$displaymode"/></xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>					
					</xsl:when>
					
					<xsl:otherwise>
			    		<xsl:call-template name="textarea-field">	
					        <xsl:with-param name="name">free_format_text</xsl:with-param>
			        <xsl:with-param name="cols">114</xsl:with-param>
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
					</xsl:otherwise>	
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>	
	 
	 <!-- Bank Message -->
    <xsl:template name="bank-message">
      <xsl:if test="tnx_stat_code[.='04'] or (tnx_stat_code[.='03'] and sub_tnx_stat_code[.='89' or .='90' or .='91']) or security:isBank($rundata)">
       <xsl:call-template name="fieldset-wrapper">
        <xsl:with-param name="legend">XSL_HEADER_BANK_MESSAGE</xsl:with-param>
        <xsl:with-param name="legend-type">indented-header</xsl:with-param>
        <xsl:with-param name="parse-widgets">N</xsl:with-param>
        <xsl:with-param name="content">
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_TRANSACTIONDETAILS_DTTM</xsl:with-param>
           <xsl:with-param name="id">bank_message_bo_release_dttm_view</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="converttools:formatReportDate(bo_release_dttm,$rundata)"/>
           </div></xsl:with-param>
          </xsl:call-template>

          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_REPORTINGDETAILS_PROD_STAT_LABEL</xsl:with-param>
           <xsl:with-param name="id">bank_message_prod_stat_view</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="localization:getDecode($language, 'N005', prod_stat_code[.])"/>
           </div></xsl:with-param>
          </xsl:call-template>

        <!--  Back-Office comment  -->
        <!--  MPS-66375 changes for FCC-GPP  -->
        
        <xsl:choose>
				<xsl:when test="bo_comment[.=''] and ((defaultresource:getResource('GPP_FT_INTERFACE') = 'gppxmlout') or (defaultresource:getResource('GPP_BULK_INTERFACE') = 'bulkgppxmlout')) and sub_tnx_stat_code[.='08' or .='89' or .='92' or .='93']">
        			<xsl:call-template name="big-textarea-wrapper">
           						<xsl:with-param name="label">XSL_REPORTINGDETAILS_COMMENT_BANK</xsl:with-param>
          						<xsl:with-param name="id">bank_message_bo_comment_view</xsl:with-param>
           						<xsl:with-param name="content"><div class="content">
           						<xsl:choose>
           							 <xsl:when test ="sub_tnx_stat_code[.='89']">
             							<xsl:value-of select="localization:getGTPString($language,'GPP_DEBIT_POSTING_STS_N_ERROR')"/>
             						</xsl:when>
             						<xsl:when test ="sub_tnx_stat_code[.='08']">
             							<xsl:value-of select="localization:getGTPString($language,'GPP_DEBIT_POSTING_STS_R_ERROR')"/>
             						</xsl:when>
             						<xsl:when test ="sub_tnx_stat_code[.='92']">
             							<xsl:value-of select="localization:getGTPString($language,'GPP_DEBIT_POSTING_STS_L_ERROR')"/>
             						</xsl:when>
             						<xsl:when test ="sub_tnx_stat_code[.='93']">
             							<xsl:value-of select="localization:getGTPString($language,'GPP_CREDIT_POSTING_STS_L_ERROR')"/>
             						</xsl:when>
             					</xsl:choose>
           						</div></xsl:with-param>
          			</xsl:call-template>
        		</xsl:when>
        		<xsl:otherwise>
        			<xsl:if test="bo_comment[.!='']">
          					<xsl:call-template name="big-textarea-wrapper">
           						<xsl:with-param name="label">XSL_REPORTINGDETAILS_COMMENT_BANK</xsl:with-param>
          						<xsl:with-param name="id">bank_message_bo_comment_view</xsl:with-param>
           						<xsl:with-param name="content"><div class="content">
             							<xsl:value-of select="bo_comment"/>
           						</div></xsl:with-param>
          				</xsl:call-template>
          			</xsl:if>
	    		</xsl:otherwise>
        </xsl:choose>
        
          <xsl:if test="sub_product_code[.!='TRTD'] and bo_ref_id[.!='']">
	       <xsl:call-template name="row-wrapper">
	        <xsl:with-param name="id">event_summary_bo_ref_id_view</xsl:with-param>
	        <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
	        <xsl:with-param name="content"><div class="content">
	          <xsl:value-of select="bo_ref_id"/>
	        </div></xsl:with-param>
	       </xsl:call-template>
      	 </xsl:if>

          <xsl:if test="action_req_code[.!=''] and product_code[.!='FX']">
           <xsl:call-template name="row-wrapper">
            <xsl:with-param name="label">XSL_REPORTINGDETAILS_ACTION_REQUIRED</xsl:with-param>
            <xsl:with-param name="id">bank_message_action_req_view</xsl:with-param>
            <xsl:with-param name="content"><div class="content">
              <xsl:value-of select="localization:getDecode($language, 'N042', action_req_code)"/>
            </div></xsl:with-param>
           </xsl:call-template>
          </xsl:if>
           
           <xsl:call-template name="attachments-file-dojo">
            <xsl:with-param name="existing-attachments" select="attachments/attachment[type = '02']"/>
            <xsl:with-param name="legend">XSL_HEADER_BANK_FILE_UPLOAD</xsl:with-param>
            <xsl:with-param name="attachment-group">summarybank</xsl:with-param>
           </xsl:call-template> 
        </xsl:with-param>
       </xsl:call-template>
      </xsl:if>
 	 </xsl:template>
	<!-- for disclaimers -->
	<xsl:template name="simple-disclaimer">
		<xsl:param name="label"/>
		<div><xsl:value-of select="localization:getGTPString($language, $label)" disable-output-escaping="yes" /></div>
	</xsl:template>  
	
	<xsl:template name="customer-bank-field">
		<xsl:choose>
			<xsl:when test="bulk_ref_id[.!='']">
				<xsl:call-template name="input-field">
					<xsl:with-param name="name">customer_bank</xsl:with-param>
			     	<xsl:with-param name="label">CUSTOMER_BANK_LABEL</xsl:with-param>	
					<xsl:with-param name="fieldsize">small</xsl:with-param>
		   			<xsl:with-param name="value" select="issuing_bank/name" />
		   			<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>			
			</xsl:when>
			<xsl:when test="$displaymode = 'edit'">
				<xsl:choose>
					<xsl:when test="banks[number(.) &gt; 1]">
						<xsl:call-template name="select-field">
							<xsl:with-param name="label">CUSTOMER_BANK_LABEL</xsl:with-param>
							<xsl:with-param name="name">customer_bank</xsl:with-param>
							<xsl:with-param name="required">Y</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">CUSTOMER_BANK_LABEL</xsl:with-param>
							<xsl:with-param name="name">customer_bank</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="customer_bank"/></xsl:with-param>
							<xsl:with-param name="readonly">Y</xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise></xsl:otherwise>
		</xsl:choose>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">customer_bank_hidden</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="customer_bank"/></xsl:with-param>
		</xsl:call-template>
	</xsl:template> 
    
  <!-- Additional hidden fields for this form are  -->
  <!-- added here. -->
  <xsl:template name="hidden-fields">
	<xsl:call-template name="common-hidden-fields">
	<xsl:with-param name="show-cust_ref_id">N</xsl:with-param>
		<xsl:with-param name="additional-fields">			
			<xsl:call-template name="hidden-field">
			   <xsl:with-param name="name">bulk_template_id</xsl:with-param>
			</xsl:call-template>
		    <xsl:call-template name="hidden-field">
			   <xsl:with-param name="name">bulk_ref_id</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
			   <xsl:with-param name="name">bulk_tnx_id</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">issuing_bank_name</xsl:with-param>
		       <xsl:with-param name="value"><xsl:value-of select="issuing_bank/name"/></xsl:with-param>
		    </xsl:call-template>
			<xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
		       <xsl:with-param name="value"><xsl:value-of select="issuing_bank/abbv_name"/></xsl:with-param>
		    </xsl:call-template>
		    <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">issuing_bank_iso_code</xsl:with-param>
		       <xsl:with-param name="value"><xsl:value-of select="issuing_bank/iso_code"/></xsl:with-param>
		    </xsl:call-template>
		    <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">counterparty_id</xsl:with-param>
		    </xsl:call-template>	
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">beneficiary_mode</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">sub_product_code</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">applicant_name</xsl:with-param>
		    </xsl:call-template>
			<xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">applicant_address_line_1</xsl:with-param>
		    </xsl:call-template>
			<xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">applicant_address_line_2</xsl:with-param>
		    </xsl:call-template>
			<xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">applicant_dom</xsl:with-param>
		    </xsl:call-template>
		    <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">applicant_abbv_name</xsl:with-param>
		    </xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">modifiedBeneficiary</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="modifiedBeneficiary" /></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">applicant_reference</xsl:with-param>
		    </xsl:call-template>
		    <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">pre_approved</xsl:with-param>
		    </xsl:call-template>	
		    <xsl:call-template name="hidden-field">
		     <xsl:with-param name="name">swiftregexValue</xsl:with-param>
			 <xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('SWIFT_VALIDATION_REGEX')"/></xsl:with-param>
			</xsl:call-template>
		    <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">pre_approved_status</xsl:with-param>
		    </xsl:call-template>
		    <xsl:call-template name="hidden-field">
				<xsl:with-param name="name">fx_tolerance_rate_value</xsl:with-param>
				<xsl:with-param name="value" select="fx_tolerance_rate"/>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">applicant_act_nickname</xsl:with-param>
				<xsl:with-param name="value" select="applicant_act_nickname"/>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">beneficiary_nickname</xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty/beneficiary_nickname"/>
			</xsl:call-template>			
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">beneficiary_act_nickname</xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty/counterparty_act_nickname"/>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">applicant_act_name1</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">beneficiary_account_name1</xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty/counterparty_name"/>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">fx_tolerance_rate_amt_value</xsl:with-param>
				<xsl:with-param name="value" select="fx_tolerance_rate_amt"/>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">intermediary_flag</xsl:with-param>
				<xsl:with-param name="value" select="intermediary_flag"/>
			</xsl:call-template>			
		     <xsl:choose>
				<xsl:when test="security:isBank($rundata) and (sub_product_code !='' and (sub_product_code ='TPT' or sub_product_code ='INT' or  sub_product_code='DOM' or  sub_product_code='MUPS'))">
		    	<xsl:call-template name="hidden-field">
			      <xsl:with-param name="name">fx_rates_type_temp</xsl:with-param>
			      <xsl:with-param name="value"><xsl:value-of select="fx_rates_type"></xsl:value-of></xsl:with-param>
			     </xsl:call-template>
			     <xsl:call-template name="hidden-field">
			      <xsl:with-param name="name">fx_master_currency</xsl:with-param>
			     <xsl:with-param name="value"><xsl:value-of select="fx_contract_nbr_cur_code_1"></xsl:value-of></xsl:with-param>
			    </xsl:call-template>			    
				</xsl:when>
				<xsl:when test="not(security:isBank($rundata)) and  (sub_product_code !='' and (sub_product_code ='TPT' or sub_product_code ='INT' or  sub_product_code='DOM'or  sub_product_code='MUPS'))">
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
			<xsl:if test="$transaction_confirmation_details_enable = 'true' ">
			<div class="widgetContainer">
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">transaction_confirmation_details</xsl:with-param>
					<xsl:with-param name="value">Y</xsl:with-param>
				</xsl:call-template>
			</div>
			</xsl:if>
		    

		    <!-- This below parameters are needed for re-authentication in view mode -->
		    <!-- Start  -->
		    <xsl:if test="$displaymode!='edit'">		
		    <xsl:if test="sub_product_code !='' and not(sub_product_code ='TPT' or sub_product_code ='INT' or  sub_product_code='DOM' or sub_product_code = 'MT103' or sub_product_code = 'MT101' or sub_product_code = 'FI103' or sub_product_code ='FI202' or sub_product_code = 'PICO' or sub_product_code = 'PIDD')">
				<xsl:call-template name="hidden-field">
			       <xsl:with-param name="name">entity</xsl:with-param>
			    </xsl:call-template>
		    </xsl:if>
	      	<xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">ft_cur_code</xsl:with-param>
		    </xsl:call-template>
		    <div style="display:none;">
		      <xsl:call-template name="currency-field">
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
		    <!-- End  -->
		    
		</xsl:with-param>
	</xsl:call-template>
	<script>
	   dojo.ready(function(){
		        	misys._config = misys._config || {};
		        	misys._config.beneficiarynickname = '<xsl:value-of select="$beneficiaryNicknameEnabled"/>';
					misys._config.non_pab_allowed = <xsl:value-of select="defaultresource:getResource('NON_PAB_ALLOWED') = 'true' and securitycheck:hasPermission(utils:getUserACL($rundata),'ft_regular_beneficiary_access',utils:getUserEntities($rundata))"/>;	
					misys._config.businessDateForBank = misys._config.businessDateForBank || 
					{
						<xsl:value-of select="utils:getAllBankBusinessDate($rundata)"/>
					};
				});
	</script>
  </xsl:template>  
  
  <xsl:template name="per-bank-recurring">
  	 dojo.mixin(misys._config, {
  	 	perBankRecurringAllowed : {
			       		<xsl:if test="count(/ft_tnx_record/per_bank_recurrings/per_bank_recurring) > 0">
			        		<xsl:for-each select="/ft_tnx_record/per_bank_recurrings/per_bank_recurring">
			  						"<xsl:value-of select="bank"/>": "<xsl:value-of select="flag"/>"
			   						<xsl:if test="not(position()=last())">,</xsl:if>
			         		</xsl:for-each>
			       		</xsl:if>
					}
  	 });
  </xsl:template>
  <xsl:template name="per-bank-recurring-frequency">
  	 dojo.mixin(misys._config, {
  	 	perBankFrequency : {
			       		<xsl:if test="count(/ft_tnx_record/frequency/frequency_per_bank) > 0">
			        		<xsl:for-each select="/ft_tnx_record/frequency/frequency_per_bank">
			  						"<xsl:value-of select="bank"/>":[
			   						<xsl:for-each select="frequency_mode" >
			   							<xsl:variable name="recurring_frequency_type"><xsl:value-of select="frequency_type"/></xsl:variable>
			   							{ 
			   								value:"<xsl:value-of select="$recurring_frequency_type"/>",
					         				name:"<xsl:value-of select="localization:getDecode($language, 'N416', $recurring_frequency_type)"/>"},
			   						</xsl:for-each>
			   						]<xsl:if test="not(position()=last())">,</xsl:if>
			         		</xsl:for-each>
			       		</xsl:if>
					}
  	 });
  </xsl:template>
  
  
 
</xsl:stylesheet>
 