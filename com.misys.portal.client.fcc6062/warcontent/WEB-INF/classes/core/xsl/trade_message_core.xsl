<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for general trade messages, customer side.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      12/03/08
author:    Cormac Flynn
email:     cormac.flynn@misys.com
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
	    xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		exclude-result-prefixes="xmlRender localization securitycheck utils security">

  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <!-- Columns definition import -->
  <xsl:import href="../../core/xsl/report/report.xsl"/>
  <xsl:param name="rundata"/>
  <xsl:param name="option"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <!--<xsl:param name="option"></xsl:param>-->
  <xsl:param name="Goods_description"/>
  <xsl:param name="Documents_required"/>
  <xsl:param name="Additional_Conditions"/>
  <xsl:param name="Amendment_Narrative"/>
  <xsl:param name="Discrepant_Details"/>
  
  <!-- These params are empty for trade message -->
  <xsl:param name="realform-action"/>
  <xsl:param name="product-code"/>
  
  <!-- Global Imports. -->
  <xsl:include href="common/trade_common.xsl" />
  <xsl:include href="../../core/xsl/common/e2ee_common.xsl"/>
  <xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  
  <xsl:template match="/">
   <xsl:apply-templates/>
  </xsl:template>
  
  <!-- 
   TRADE MESSAGE TNX FORM TEMPLATE.
  -->
  <xsl:template match="lc_tnx_record | ri_tnx_record | se_tnx_record | li_tnx_record | sg_tnx_record | tf_tnx_record | el_tnx_record | ec_tnx_record | ic_tnx_record | ir_tnx_record | si_tnx_record | sr_tnx_record | bg_tnx_record  | br_tnx_record  | po_tnx_record | so_tnx_record | in_tnx_record | ln_tnx_record | fx_tnx_record | xo_tnx_record | sp_tnx_record | fa_tnx_record">
   <xsl:variable name="product-code"><xsl:value-of select="product_code"/></xsl:variable>
   <!-- Lower case product code -->
   <xsl:variable name="lowercase-product-code">
    <xsl:value-of select="translate($product-code,$up,$lo)"/>
   </xsl:variable>
   
   <xsl:variable name="trade_account_source_static">
		<xsl:value-of select="defaultresource:getResource('TRADE_ACCOUNT_SOURCE_STATIC')"/>
	</xsl:variable> 

   <xsl:variable name="screen-name">
    <xsl:choose>
     <xsl:when test="product_code[.='LC']">LetterOfCreditScreen</xsl:when>
     <xsl:when test="product_code[.='RI']">ReceivedLetterOfIndemnityScreen</xsl:when>
     <xsl:when test="product_code[.='SE']">SecureEmailScreen</xsl:when>
     <xsl:when test="product_code[.='SG']">ShippingGuaranteeScreen</xsl:when>
     <xsl:when test="product_code[.='LI']">LetterOfIndemnityScreen</xsl:when>
     <xsl:when test="product_code[.='TF']">FinancingRequestScreen</xsl:when>
     <xsl:when test="product_code[.='EL']">ExportLetterOfCreditScreen</xsl:when>
     <xsl:when test="product_code[.='EC']">ExportCollectionScreen</xsl:when>
     <xsl:when test="product_code[.='IC']">ImportCollectionScreen</xsl:when>
     <xsl:when test="product_code[.='IR']">InwardRemittanceScreen</xsl:when>
     <xsl:when test="product_code[.='SI']">StandbyIssuedScreen</xsl:when>
     <xsl:when test="product_code[.='SR']">StandbyReceivedScreen</xsl:when>
     <xsl:when test="product_code[.='BG']">BankerGuaranteeScreen</xsl:when>
     <xsl:when test="product_code[.='BR']">GuaranteeReceivedScreen</xsl:when>
     <xsl:when test="product_code[.='PO']">PurchaseOrderScreen</xsl:when>
     <xsl:when test="product_code[.='SO']">SellOrderScreen</xsl:when>
     <xsl:when test="product_code[.='IN']">InvoiceScreen</xsl:when>
     <xsl:when test="product_code[.='LN']">LoanScreen</xsl:when>
     <xsl:when test="product_code[.='FX']">ForeignExchangeScreen</xsl:when>
     <xsl:when test="product_code[.='XO']">ForeignExchangeOrderScreen</xsl:when>
     <xsl:when test="product_code[.='SP']">SweepScreen</xsl:when>
     <xsl:when test="product_code[.='FA']">FactoringScreen</xsl:when>
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
    
      <xsl:call-template name="hidden-fields">
       <xsl:with-param name="lowercase-product-code" select="$lowercase-product-code"/>
      </xsl:call-template>
      

      <!-- Hidden cross references -->
      <xsl:apply-templates select="cross_references" mode="hidden_form"/>
      
      <xsl:variable name="isMT798"><xsl:value-of select="is_MT798"/></xsl:variable>
      <xsl:call-template name="message-general-details">
      	<xsl:with-param name="additional-details">
      	  
      	  <!-- Add the communication channel in the page (MT798 or standard)
			   Fields are switched depending on it -->
			   <xsl:if test="$displaymode='edit'">
			    <script>
			    	dojo.ready(function(){
			    		misys._config = misys._config || {};
						misys._config.customerBanksMT798Channel = {};
						<xsl:apply-templates select="avail_main_banks/bank" mode="customer_banks_communication_channel"/>
						dojo.mixin(misys._config,{  
								
							pendingTnxIdArray : new Array(),     
																
							pendingTnxIdArray : [
										<xsl:for-each select="pending_list/pending_record">
											"<xsl:value-of select="tnx_id"></xsl:value-of>"<xsl:if test="position()!=last()">,</xsl:if>
										</xsl:for-each>
							]
								
						});
								
					});
				</script>
			   </xsl:if>
			   <xsl:if test="$displaymode='view'">
			   <script>
			   	dojo.ready(function(){
			    		misys._config = misys._config || {};
						misys._config.customerBanksMT798Channel = {};
						<xsl:apply-templates select="avail_main_banks/bank" mode="customer_banks_communication_channel"/>
					});
			   </script>
			   </xsl:if>
      	  <xsl:if test="product_code[.='EL']">
      	 	<xsl:choose>
	      	 	<xsl:when test="cross_references/cross_reference/type_code[.='01']">
	      		<xsl:call-template name="select-field">
			      <xsl:with-param name="label">XSL_GENERALDETAILS_ACCEPTANCE_INSTRUCTIONS</xsl:with-param>
			      <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
			      <xsl:with-param name="required">Y</xsl:with-param>
			      <xsl:with-param name="options">
			       <xsl:choose>
				    <xsl:when test="$displaymode='edit'">
				    	<xsl:choose>
				    		<xsl:when test="prod_stat_code[.='12']">
				    			<option value="08">
							    	<xsl:value-of select="localization:getDecode($language, 'N003', '08')"/>
							    </option>
						        <option value="09">
						        <xsl:choose>
						        	<xsl:when test="$isMT798 = 'Y'"><xsl:value-of select="localization:getDecode($language, 'N003', 'B0')"/></xsl:when>
									<xsl:otherwise><xsl:value-of select="localization:getDecode($language, 'N003', '09')"/></xsl:otherwise>
						        </xsl:choose>
						        </option>
				    		</xsl:when>
				    		<xsl:otherwise>
				    			<option value="46">
							    	<xsl:value-of select="localization:getDecode($language, 'N003', '46')"/>
							    </option>
						        <option value="47">
						       		 <xsl:value-of select="localization:getDecode($language, 'N003', '47')"/>
						        </option>
				    		</xsl:otherwise>
				    	</xsl:choose>
				    </xsl:when>
				    <xsl:otherwise>
				     <xsl:choose>
				      <xsl:when test="sub_tnx_type_code[.='08']"><xsl:value-of select="localization:getDecode($language, 'N003', '08')"/></xsl:when>
			          <xsl:when test="sub_tnx_type_code[.='09']"><xsl:value-of select="localization:getDecode($language, 'N003', '09')"/></xsl:when>
			          <xsl:when test="sub_tnx_type_code[.='46']"><xsl:value-of select="localization:getDecode($language, 'N003', '46')"/></xsl:when>
			          <xsl:when test="sub_tnx_type_code[.='47']"><xsl:value-of select="localization:getDecode($language, 'N003', '47')"/></xsl:when>
			         </xsl:choose>
				    </xsl:otherwise>
				   </xsl:choose>	   
			      </xsl:with-param>
			     </xsl:call-template>
		     </xsl:when>
		     <xsl:when test="$isMT798='Y'">
		     	<xsl:call-template name="select-field">
			         <xsl:with-param name="label">XSL_GENERALDETAILS_MESSAGE_TYPE</xsl:with-param>
			         <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
			         <xsl:with-param name="required">Y</xsl:with-param>
			         <xsl:with-param name="fieldsize">medium</xsl:with-param>
			         <xsl:with-param name="override-displaymode">
			         	<xsl:choose>
			         		<xsl:when test="$option = 'ACTION_REQUIRED' or action_req_code[.!='']">view</xsl:when>
			         		<xsl:otherwise><xsl:value-of select="$displaymode"/></xsl:otherwise>
			         	</xsl:choose>
			         </xsl:with-param>
			         <xsl:with-param name="options">
				          <xsl:choose>
					           <xsl:when test="$displaymode='edit' and $option != 'ACTION_REQUIRED' and action_req_code[.='']">
						            <option value="24">
						             <xsl:value-of select="localization:getDecode($language, 'N003', '24')"/>
						            </option>
					            	<option value="68">
					             		<xsl:value-of select="localization:getDecode($language, 'N003', '68')"/>
					            	</option>
					           </xsl:when>
					           <xsl:otherwise>
					            <xsl:choose>
					             <xsl:when test="sub_tnx_type_code[.='24']"><xsl:value-of select="localization:getDecode($language, 'N003', '24')"/></xsl:when>
					             <xsl:when test="sub_tnx_type_code[.='68']"><xsl:value-of select="localization:getDecode($language, 'N003', '68')"/></xsl:when>
					            </xsl:choose>
					           </xsl:otherwise>		
				          </xsl:choose>
			         </xsl:with-param>
		        </xsl:call-template>
		     </xsl:when>
			     <xsl:otherwise>
			     	<xsl:call-template name="hidden-field">
			     		<xsl:with-param name="id">sub_tnx_type_code</xsl:with-param>
			     		<xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
			     		<xsl:with-param name="value">24</xsl:with-param>
			     	</xsl:call-template>
			     </xsl:otherwise>
		     </xsl:choose>
		     
		     <div id="bankInst"> 
		  		<xsl:variable name="isMT798"><xsl:value-of select="is_MT798"/></xsl:variable>
		    	<xsl:if test = "$isMT798 = 'Y'">
					 <xsl:call-template name="hidden-field">
					  	<xsl:with-param name="name">adv_send_mode</xsl:with-param>
					  	<xsl:with-param name="value">01</xsl:with-param>
			    	</xsl:call-template>
			  	</xsl:if>
			  	<xsl:call-template name="bank-instructions">
			      	<xsl:with-param name="send-mode-displayed">
			      		<xsl:choose>
			      			<xsl:when test="$isMT798 = 'Y'">N</xsl:when>
			      			<xsl:otherwise>Y</xsl:otherwise>
			      		</xsl:choose>
			      	</xsl:with-param>
					<xsl:with-param name="send-mode-required">N</xsl:with-param>
			        <xsl:with-param name="delivery-to-shown">N</xsl:with-param>
			        <xsl:with-param name="delivery-channel-displayed">Y</xsl:with-param>
			        <xsl:with-param name="principal-acc-displayed">N</xsl:with-param>
			  		<xsl:with-param name="fee-acc-displayed">N</xsl:with-param>
			  		<xsl:with-param name="free-format-text-displayed">N</xsl:with-param>
			  		<xsl:with-param name="is-toc-item">
			         	<xsl:choose>
			         		<xsl:when test="$isMT798 = 'N'">N</xsl:when>
			         		<xsl:otherwise>Y</xsl:otherwise>
			         	</xsl:choose>
			         </xsl:with-param>
			    </xsl:call-template>
		    </div>
	      <xsl:call-template name="hidden-field">
			<xsl:with-param name="name">swiftregexzcharValue</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('SWIFT_VALIDATION_REGEX_ZCHAR')"/></xsl:with-param>
		  </xsl:call-template>
		  
		  <xsl:if test="$option = 'ACTION_REQUIRED' or sub_tnx_type_code[.='66' or .='67']">			
				  <xsl:call-template name="hidden-field">
				  	<xsl:with-param name="name">lc_amt</xsl:with-param>
				  	<xsl:with-param name="value">
						<xsl:if test="lc_amt[.!='']">
							<xsl:value-of select="lc_amt" />
						</xsl:if>	
				  	</xsl:with-param>
				  </xsl:call-template>
		 </xsl:if>						
		  		  
      	  </xsl:if>
      	  
      	  <xsl:if test="product_code[.='LC'] or product_code[.='IC'] or product_code[.='SI'] or product_code[.='TF']">
      	  	
      	  	<xsl:if test="(product_code[.='LC'] and $displaymode='edit') and (((prod_stat_code ='84' or sub_tnx_type_code[.='62' or .='63' or .='25']) and sub_tnx_type_code != '24' and securitycheck:hasPermission($rundata,'lc_claim_access') = 'true') or tnx_type_code[.='13'])">
    	  		<xsl:call-template name="hidden-field">
				  	<xsl:with-param name="name">is_amt_editable</xsl:with-param>
				  	<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('IS_SETTLEMENT_AMT_EDITABLE')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
      	  	<xsl:choose>
	      	  	<xsl:when test="product_code[.='LC'] and (org_previous_file/lc_tnx_record/prod_stat_code[.='78' or .='79'] or sub_tnx_type_code[.='88' or .='89'])">
				  <xsl:call-template name="select-field">
				     <xsl:with-param name="label">XSL_GENERALDETAILS_WORDING_RESPONSE</xsl:with-param>
				     <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
				     <xsl:with-param name="required">Y</xsl:with-param>
				     <xsl:with-param name="options">
				      <xsl:choose>
					    <xsl:when test="$displaymode='edit'"> 		        
					       <xsl:choose>
					       <xsl:when test="org_previous_file/lc_tnx_record/prod_stat_code[.='78']">
						       <option value="88">
							    <xsl:value-of select="localization:getGTPString($language, 'XSL_WUR_YES')"/>
							   </option>
						       <option value="89">
						        <xsl:value-of select="localization:getGTPString($language, 'XSL_WUR_NO')"/>
						       </option>
					       </xsl:when>
					       <xsl:otherwise>
							   <option value="88">
							    <xsl:value-of select="localization:getGTPString($language, 'XSL_FW_YES')"/>
							   </option>
						       <option value="89">
						        <xsl:value-of select="localization:getGTPString($language, 'XSL_FW_NO')"/>
						       </option>
					       </xsl:otherwise>
					       </xsl:choose>
					    </xsl:when>
					    <xsl:otherwise>
					     <xsl:choose>
					         <xsl:when test="sub_tnx_type_code[.='88'] and org_previous_file/lc_tnx_record/prod_stat_code[.='78']"><xsl:value-of select="localization:getGTPString($language, 'XSL_WUR_YES')"/></xsl:when>
					         <xsl:when test="sub_tnx_type_code[.='88'] and org_previous_file/lc_tnx_record/prod_stat_code[.='79']"><xsl:value-of select="localization:getGTPString($language, 'XSL_FW_YES')"/></xsl:when>
					         <xsl:when test="sub_tnx_type_code[.='89'] and org_previous_file/lc_tnx_record/prod_stat_code[.='78']"><xsl:value-of select="localization:getGTPString($language, 'XSL_WUR_NO')"/></xsl:when>
					         <xsl:when test="sub_tnx_type_code[.='89'] and org_previous_file/lc_tnx_record/prod_stat_code[.='79']"><xsl:value-of select="localization:getGTPString($language, 'XSL_FW_NO')"/></xsl:when>
					        </xsl:choose>
					    </xsl:otherwise>
				   	  </xsl:choose>
				     </xsl:with-param>
				  </xsl:call-template>
			 	</xsl:when>
			 	
			 	<xsl:when test="(product_code[.='LC'] or product_code[.='SI'] or product_code[.='BG']) and (prod_stat_code [.='15'] or prod_stat_code [.='98'])">
		      		<xsl:call-template name="select-field">
					     <xsl:with-param name="label">XSL_GENERALDETAILS_MESSAGE_TYPE</xsl:with-param>
					     <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
					     <xsl:with-param name="required">Y</xsl:with-param>
					     <xsl:with-param name="options">
					      <xsl:choose>
						    <xsl:when test="$displaymode='edit'"> 		        
						       <xsl:choose>
						       <xsl:when test="prod_stat_code[.='98']">
							       <option value="88">
								    <xsl:value-of select="localization:getGTPString($language, 'XSL_WUR_YES')"/>
								   </option>
							       <option value="89">
							        <xsl:value-of select="localization:getGTPString($language, 'XSL_WUR_NO')"/>
							       </option>
						       </xsl:when>
						       <xsl:when test="prod_stat_code[.='15']">
							       <option value="62">
								    <xsl:value-of select="localization:getGTPString($language, 'XSL_WUR_YES')"/>
								   </option>
							       <option value="63">
							        <xsl:value-of select="localization:getGTPString($language, 'XSL_WUR_NO')"/>
							       </option>
						       </xsl:when>
						       </xsl:choose>
						    </xsl:when>
						    <xsl:otherwise>
						     <xsl:choose>
						         <xsl:when test="sub_tnx_type_code[.='88']"><xsl:value-of select="localization:getGTPString($language, 'XSL_WUR_YES')"/></xsl:when>
						         <xsl:when test="sub_tnx_type_code[.='89']"><xsl:value-of select="localization:getGTPString($language, 'XSL_WUR_NO')"/></xsl:when>
						         <xsl:when test="sub_tnx_type_code[.='62']"><xsl:value-of select="localization:getGTPString($language, 'XSL_WUR_YES')"/></xsl:when>					         
						         <xsl:when test="sub_tnx_type_code[.='63']"><xsl:value-of select="localization:getGTPString($language, 'XSL_FW_NO')"/></xsl:when>
						     </xsl:choose>
						    </xsl:otherwise>
					   	  </xsl:choose>
					     </xsl:with-param>
					  </xsl:call-template>
	     		</xsl:when>
			 	<!-- LC Claim Presentation -->
			 	<xsl:when test="product_code[.='LC'] and (org_previous_file/lc_tnx_record/prod_stat_code ='84' or sub_tnx_type_code[.='62' or .='63']) and sub_tnx_type_code != '24' and securitycheck:hasPermission($rundata,'lc_claim_access') = 'true'">
			 		<xsl:if test="org_previous_file/lc_tnx_record/claim_present_date[.!='']">
				        <xsl:call-template name="input-field">
				         <xsl:with-param name="label">XSL_CLAIM_PRESENT_DATE_LABEL</xsl:with-param>
				         <xsl:with-param name="id">claim_present_date_view</xsl:with-param>
				         <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/claim_present_date"/>
				         <xsl:with-param name="override-displaymode">view</xsl:with-param>
				        </xsl:call-template>
			        </xsl:if>
			        
			        <xsl:if test="org_previous_file/lc_tnx_record/claim_reference[.!='']">
				        <xsl:call-template name="input-field">
				         <xsl:with-param name="label">XSL_CLAIM_REFERENCE_LABEL</xsl:with-param>
				         <xsl:with-param name="id">claim_reference_view</xsl:with-param>
				         <xsl:with-param name="value" select="org_previous_file/lc_tnx_record/claim_reference"/>
				         <xsl:with-param name="override-displaymode">view</xsl:with-param>
				        </xsl:call-template>
			        </xsl:if>
			        
			        <xsl:if test="org_previous_file/lc_tnx_record/claim_cur_code[.!=''] and org_previous_file/lc_tnx_record/claim_amt[.!='']">
				        <xsl:call-template name="input-field">
				         <xsl:with-param name="label">XSL_CLAIM_AMOUNT_LABEL</xsl:with-param>
				         <xsl:with-param name="id">claim_amt_view</xsl:with-param>
				         <xsl:with-param name="value"><xsl:value-of select="claim_cur_code"/>&nbsp;<xsl:value-of select="org_previous_file/lc_tnx_record/claim_amt"/></xsl:with-param>
				         <xsl:with-param name="override-displaymode">view</xsl:with-param>
				        </xsl:call-template>
				        <xsl:if test="$displaymode='edit'">
					        <xsl:call-template name="hidden-field">
							  	<xsl:with-param name="name">claim_amt</xsl:with-param>
							  	<xsl:with-param name="value"><xsl:value-of select="org_previous_file/lc_tnx_record/claim_amt"/></xsl:with-param>
							</xsl:call-template>
				        </xsl:if>
			        </xsl:if>
			 	
			 		<xsl:choose>
				 		<xsl:when test="$option = 'ACTION_REQUIRED' or sub_tnx_type_code[.='62' or .='63']">
				 			<xsl:call-template name="select-field">
						         <xsl:with-param name="label">XSL_GENERALDETAILS_MESSAGE_TYPE</xsl:with-param>
						         <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
						         <xsl:with-param name="required">Y</xsl:with-param>
						         <xsl:with-param name="fieldsize">medium</xsl:with-param>
						         <xsl:with-param name="override-displaymode">
						         	<xsl:value-of select="$displaymode"/>
						         </xsl:with-param>
						         <xsl:with-param name="options">
						          <xsl:choose>
						           <xsl:when test="$displaymode='edit'">
						            <option value="62">
						             <xsl:value-of select="localization:getDecode($language, 'N003', '62')"/>
						            </option>
						            <option value="63">
						             <xsl:value-of select="localization:getDecode($language, 'N003', '63')"/>
						            </option>
						           </xsl:when>
						           <xsl:otherwise>
						            <xsl:choose>
						             <xsl:when test="sub_tnx_type_code[.='62']"><xsl:value-of select="localization:getDecode($language, 'N003', '62')"/></xsl:when>
						             <xsl:when test="sub_tnx_type_code[.='63']"><xsl:value-of select="localization:getDecode($language, 'N003', '63')"/></xsl:when>
						            </xsl:choose>
						           </xsl:otherwise>
						          </xsl:choose>
						         </xsl:with-param>
						    </xsl:call-template>
				 		</xsl:when>			 		
				 		<xsl:otherwise>
					 		<xsl:call-template name="select-field">
						         <xsl:with-param name="label">XSL_GENERALDETAILS_MESSAGE_TYPE</xsl:with-param>
						         <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
						         <xsl:with-param name="required">Y</xsl:with-param>
						         <xsl:with-param name="fieldsize">medium</xsl:with-param>
						         <xsl:with-param name="override-displaymode">
						         	<xsl:value-of select="$displaymode"/>
					 			 </xsl:with-param>
						         <xsl:with-param name="options">
						          <xsl:choose>
						          <xsl:when test="$displaymode='edit' and action_req_code[.='']">
						            <option value="24">
						             <xsl:value-of select="localization:getDecode($language, 'N003', '24')"/>
						            </option>
						            <option value="25">
						             <xsl:value-of select="localization:getDecode($language, 'N003', '25')"/>
						            </option>
						           </xsl:when>
						           <xsl:otherwise>
						            <xsl:choose>						             
						             <xsl:when test="sub_tnx_type_code[.='24']"><xsl:value-of select="localization:getDecode($language, 'N003', '24')"/></xsl:when>
						             <xsl:when test="sub_tnx_type_code[.='25']"><xsl:value-of select="localization:getDecode($language, 'N003', '25')"/></xsl:when>
						            </xsl:choose>
						           </xsl:otherwise>
						          </xsl:choose>
						         </xsl:with-param>
						        </xsl:call-template>
					    </xsl:otherwise>
				    </xsl:choose>
			 		
				    <xsl:if test="$displaymode='view'">
				        <xsl:call-template name="hidden-field">
						  	<xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
						  	<xsl:with-param name="value"><xsl:value-of select="sub_tnx_type_code"/></xsl:with-param>
						</xsl:call-template>
			        </xsl:if>
			        <xsl:if test="($displaymode='view' and sub_tnx_type_code[.='62']) or ($mode='UNSIGNED' and sub_tnx_type_code[.='25']) or $displaymode='edit'">
			        	<div id="settlement-details">
			            <xsl:call-template name="currency-field">
				         <xsl:with-param name="label">XSL_AMOUNTDETAILS_SETTLEMENT_AMT_LABEL</xsl:with-param>
				         <xsl:with-param name="product-code">lc</xsl:with-param>
				         <xsl:with-param name="override-currency-name">tnx_cur_code</xsl:with-param>
				         <xsl:with-param name="override-amt-name">tnx_amt</xsl:with-param>
				         <xsl:with-param name="show-button">N</xsl:with-param>
				         <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
				         <xsl:with-param name="override-currency-value"><xsl:value-of select="lc_cur_code"/></xsl:with-param>
				         <xsl:with-param name="amt-readonly">
				         	<xsl:choose>
				         	<xsl:when test="defaultresource:getResource('IS_SETTLEMENT_AMT_EDITABLE') = 'true'">N</xsl:when>
				         	<xsl:otherwise>Y</xsl:otherwise>
				         	</xsl:choose>
				         </xsl:with-param>
				         <xsl:with-param name="override-amt-value">
				         	<xsl:choose>
				         		<xsl:when test="tnx_amt[.!='']">
				         			<xsl:value-of select="tnx_amt"/>
				         		</xsl:when>
				         		<xsl:otherwise>
				         			<xsl:value-of select="claim_amt"/>
				         		</xsl:otherwise>
				         	</xsl:choose>
				         </xsl:with-param>
				        </xsl:call-template>
				        <xsl:call-template name="input-field">
						         <xsl:with-param name="label">XSL_AMOUNTDETAILS_FORWARD_CONTRACT_LABEL</xsl:with-param>
						         <xsl:with-param name="name">fwd_contract_no</xsl:with-param>
						         <xsl:with-param name="value" select="//fwd_contract_no"/>
						         <xsl:with-param name="maxsize">34</xsl:with-param>
						        </xsl:call-template>
				        <xsl:choose>
				         <xsl:when test="$trade_account_source_static = 'true'">
						 <xsl:call-template name="principal-account-field">
						       <xsl:with-param name="label">XSL_INSTRUCTIONS_PRINCIPAL_ACT_NO_LABEL</xsl:with-param>
						       <xsl:with-param name="type">account</xsl:with-param>
						       <xsl:with-param name="name">principal_act_no</xsl:with-param>
						       <xsl:with-param name="readonly">Y</xsl:with-param>
						       <xsl:with-param name="size">34</xsl:with-param>
						       <xsl:with-param name="maxsize">34</xsl:with-param>
						       <xsl:with-param name="entity-field">entity</xsl:with-param>
						       <xsl:with-param name="show-product-types">N</xsl:with-param>
						       <xsl:with-param name="prodCode"><xsl:value-of select="$product-code"/></xsl:with-param>
						       <xsl:with-param name="value"><xsl:value-of select="principal_act_no"/></xsl:with-param>
					      </xsl:call-template> 
					      <xsl:call-template name="principal-account-field">
						      <xsl:with-param name="label">XSL_INSTRUCTIONS_FEE_ACT_NO_LABEL</xsl:with-param>
						      <xsl:with-param name="type">account</xsl:with-param>
						      <xsl:with-param name="name">fee_act_no</xsl:with-param>
						      <xsl:with-param name="readonly">Y</xsl:with-param>
						      <xsl:with-param name="size">34</xsl:with-param>
						      <xsl:with-param name="maxsize">34</xsl:with-param>
						      <xsl:with-param name="entity-field">entity</xsl:with-param>
						      <xsl:with-param name="show-product-types">N</xsl:with-param>
					      </xsl:call-template>
					       </xsl:when>
					      <xsl:otherwise>
					      <xsl:call-template name="user-account-field">
							<xsl:with-param name="label">XSL_INSTRUCTIONS_PRINCIPAL_ACT_NO_LABEL</xsl:with-param>
							<xsl:with-param name="name">principal</xsl:with-param>
							<xsl:with-param name="entity-field">entity</xsl:with-param>
							<xsl:with-param name="dr-cr">debit</xsl:with-param>
							<xsl:with-param name="show-product-types">N</xsl:with-param>
							<xsl:with-param name="product_types"><xsl:value-of select="product_code"/></xsl:with-param>
		        			<xsl:with-param name="product-types-required">N</xsl:with-param>
							<xsl:with-param name="required">N</xsl:with-param>
							<xsl:with-param name="trade_internal_account">Y</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="fee_act_no"/></xsl:with-param>
						 </xsl:call-template>
						 <xsl:call-template name="user-account-field">
							<xsl:with-param name="label">XSL_INSTRUCTIONS_FEE_ACT_NO_LABEL</xsl:with-param>
							<xsl:with-param name="name">fee</xsl:with-param>
							<xsl:with-param name="entity-field">entity</xsl:with-param>
							<xsl:with-param name="dr-cr">debit</xsl:with-param>
							<xsl:with-param name="show-product-types">N</xsl:with-param>
							<xsl:with-param name="product_types"><xsl:value-of select="product_code"/></xsl:with-param>
		        			<xsl:with-param name="product-types-required">N</xsl:with-param>
							<xsl:with-param name="required">N</xsl:with-param>
							<xsl:with-param name="trade_internal_account">Y</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="fee_act_no"/></xsl:with-param>
						 </xsl:call-template>
					      </xsl:otherwise>
					      </xsl:choose>
			        	</div>
			        </xsl:if>
				</xsl:when> 
			 	
      	  		<xsl:otherwise>
		      		<xsl:call-template name="select-field">
			         <xsl:with-param name="label">XSL_GENERALDETAILS_MESSAGE_TYPE</xsl:with-param>
			         <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
			         <xsl:with-param name="required">Y</xsl:with-param>
			         <xsl:with-param name="fieldsize">medium</xsl:with-param>
			         <xsl:with-param name="override-displaymode">
			         	<xsl:choose>
			         		<xsl:when test="$option = 'ACTION_REQUIRED' or action_req_code[.!='']">view</xsl:when>
			         		<xsl:otherwise><xsl:value-of select="$displaymode"/></xsl:otherwise>
			         	</xsl:choose>
			         </xsl:with-param>
			         <xsl:with-param name="options">
			          <xsl:choose>
			           <xsl:when test="$displaymode='edit' and $option != 'ACTION_REQUIRED' and action_req_code[.='']">
			            <option value="24">
			             <xsl:value-of select="localization:getDecode($language, 'N003', '24')"/>
			            </option>
			            <option value="25">
			             <xsl:value-of select="localization:getDecode($language, 'N003', '25')"/>
			            </option>
			            <xsl:if test="$isMT798 = 'Y'">
			            	<option value="68">
			             		<xsl:value-of select="localization:getDecode($language, 'N003', '68')"/>
			            	</option>
			            </xsl:if>
			           </xsl:when>
			           <xsl:otherwise>
			            <xsl:choose>
			             <xsl:when test="$option = 'ACTION_REQUIRED' or action_req_code[.!='']"><xsl:value-of select="localization:getDecode($language, 'N043', '01')"/></xsl:when>
			             <xsl:when test="sub_tnx_type_code[.='24']"><xsl:value-of select="localization:getDecode($language, 'N003', '24')"/></xsl:when>
			             <xsl:when test="sub_tnx_type_code[.='25']"><xsl:value-of select="localization:getDecode($language, 'N003', '25')"/></xsl:when>
			             <xsl:when test=" $isMT798 = 'Y' and sub_tnx_type_code[.='68']"><xsl:value-of select="localization:getDecode($language, 'N003', '68')"/></xsl:when>
			            </xsl:choose>
			           </xsl:otherwise>
			          </xsl:choose>
			         </xsl:with-param>
			        </xsl:call-template>
			        <xsl:choose>
			        	<xsl:when test="sub_tnx_type_code[.='25'] and $mode = 'UNSIGNED'">
				        	 <div id="settlement-details">
					        	<xsl:variable name="type_name"><xsl:choose><xsl:when test="product_code[.='TF']">fin</xsl:when><xsl:when test="product_code[.='LC' or .='EL' or .='SI' or .='SR']">lc</xsl:when><xsl:otherwise><xsl:value-of select="$lowercase-product-code"/></xsl:otherwise></xsl:choose>_cur_code</xsl:variable>
					            <xsl:call-template name="hidden-field">
							      <xsl:with-param name="name"><xsl:value-of select="$type_name" /></xsl:with-param>
							    </xsl:call-template>
					            <xsl:call-template name="currency-field">
						         <xsl:with-param name="label">XSL_AMOUNTDETAILS_SETTLEMENT_AMT_LABEL</xsl:with-param>
						         <xsl:with-param name="product-code"><xsl:value-of select="$lowercase-product-code"/></xsl:with-param>
						         <xsl:with-param name="override-currency-name"><xsl:value-of select="$type_name" /></xsl:with-param>
						         <xsl:with-param name="override-amt-name">tnx_amt</xsl:with-param>
						         <xsl:with-param name="show-button">N</xsl:with-param>
						         <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
						        </xsl:call-template>
						        <xsl:call-template name="input-field">
						         <xsl:with-param name="label">XSL_AMOUNTDETAILS_FORWARD_CONTRACT_LABEL</xsl:with-param>
						         <xsl:with-param name="name">fwd_contract_no</xsl:with-param>
						         <xsl:with-param name="value" select="//fwd_contract_no"/>
						         <xsl:with-param name="maxsize">34</xsl:with-param>
						        </xsl:call-template>
				        	<xsl:choose>
						      <xsl:when test="$trade_account_source_static = 'true'">
							 <xsl:call-template name="principal-account-field">
							       <xsl:with-param name="label">XSL_INSTRUCTIONS_PRINCIPAL_ACT_NO_LABEL</xsl:with-param>
							       <xsl:with-param name="type">account</xsl:with-param>
							       <xsl:with-param name="name">principal_act_no</xsl:with-param>
							       <xsl:with-param name="readonly">Y</xsl:with-param>
							       <xsl:with-param name="size">34</xsl:with-param>
							       <xsl:with-param name="maxsize">34</xsl:with-param>
							       <xsl:with-param name="entity-field">entity</xsl:with-param>
							       <xsl:with-param name="show-product-types">N</xsl:with-param>
							       <xsl:with-param name="prodCode"><xsl:value-of select="$product-code"/></xsl:with-param>
							       <xsl:with-param name="value"><xsl:value-of select="principal_act_no"/></xsl:with-param>
						      </xsl:call-template> 
						      <xsl:call-template name="principal-account-field">
							      <xsl:with-param name="label">XSL_INSTRUCTIONS_FEE_ACT_NO_LABEL</xsl:with-param>
							      <xsl:with-param name="type">account</xsl:with-param>
							      <xsl:with-param name="name">fee_act_no</xsl:with-param>
							      <xsl:with-param name="readonly">Y</xsl:with-param>
							      <xsl:with-param name="size">34</xsl:with-param>
							      <xsl:with-param name="maxsize">34</xsl:with-param>
							      <xsl:with-param name="entity-field">entity</xsl:with-param>
							      <xsl:with-param name="show-product-types">N</xsl:with-param>
							       <xsl:with-param name="prodCode"><xsl:value-of select="$product-code"/></xsl:with-param>
							       <xsl:with-param name="value"><xsl:value-of select="fee_act_no"/></xsl:with-param>
						      </xsl:call-template>
						      </xsl:when>
						      <xsl:otherwise>
						      <xsl:call-template name="user-account-field">
								<xsl:with-param name="label">XSL_INSTRUCTIONS_PRINCIPAL_ACT_NO_LABEL</xsl:with-param>
								<xsl:with-param name="name">principal</xsl:with-param>
								<xsl:with-param name="entity-field">entity</xsl:with-param>
								<xsl:with-param name="dr-cr">debit</xsl:with-param>
								<xsl:with-param name="show-product-types">N</xsl:with-param>
								<xsl:with-param name="product_types"><xsl:value-of select="product_code"/></xsl:with-param>
			        			<xsl:with-param name="product-types-required">N</xsl:with-param>
								<xsl:with-param name="required">N</xsl:with-param>
								<xsl:with-param name="trade_internal_account">Y</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select="fee_act_no"/></xsl:with-param>
							 </xsl:call-template>
							 <xsl:call-template name="user-account-field">
								<xsl:with-param name="label">XSL_INSTRUCTIONS_FEE_ACT_NO_LABEL</xsl:with-param>
								<xsl:with-param name="name">fee</xsl:with-param>
								<xsl:with-param name="entity-field">entity</xsl:with-param>
								<xsl:with-param name="dr-cr">debit</xsl:with-param>
								<xsl:with-param name="show-product-types">N</xsl:with-param>
								<xsl:with-param name="product_types"><xsl:value-of select="product_code"/></xsl:with-param>
			        			<xsl:with-param name="product-types-required">N</xsl:with-param>
								<xsl:with-param name="required">N</xsl:with-param>
								<xsl:with-param name="trade_internal_account">Y</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select="fee_act_no"/></xsl:with-param>
							 </xsl:call-template>
						      </xsl:otherwise>
						      </xsl:choose>
					        	</div>
				        	</xsl:when>
				        	<xsl:otherwise>
				        	<div id="settlement-details" style="display:none">
					        	<xsl:variable name="type_name"><xsl:choose><xsl:when test="product_code[.='TF']">fin</xsl:when><xsl:when test="product_code[.='LC' or .='EL' or .='SI' or .='SR']">lc</xsl:when><xsl:otherwise><xsl:value-of select="$lowercase-product-code"/></xsl:otherwise></xsl:choose>_cur_code</xsl:variable>
					            <xsl:call-template name="hidden-field">
							      <xsl:with-param name="name"><xsl:value-of select="$type_name" /></xsl:with-param>
							    </xsl:call-template>
					            <xsl:call-template name="currency-field">
						         <xsl:with-param name="label">XSL_AMOUNTDETAILS_SETTLEMENT_AMT_LABEL</xsl:with-param>
						         <xsl:with-param name="product-code"><xsl:value-of select="$lowercase-product-code"/></xsl:with-param>
						         <xsl:with-param name="override-currency-name"><xsl:value-of select="$type_name" /></xsl:with-param>
						         <xsl:with-param name="override-amt-name">tnx_amt</xsl:with-param>
						         <xsl:with-param name="show-button">N</xsl:with-param>
						         <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
						         <xsl:with-param name="amt-readonly">
						         	<xsl:choose>
						         	<xsl:when test="defaultresource:getResource('IS_SETTLEMENT_AMT_EDITABLE') = 'true'">N</xsl:when>
						         	<xsl:otherwise>Y</xsl:otherwise>
						         	</xsl:choose>
							      </xsl:with-param>
						        </xsl:call-template>
						        <xsl:call-template name="input-field">
						         <xsl:with-param name="label">XSL_AMOUNTDETAILS_FORWARD_CONTRACT_LABEL</xsl:with-param>
						         <xsl:with-param name="name">fwd_contract_no</xsl:with-param>
						         <xsl:with-param name="value" select="//fwd_contract_no"/>
						         <xsl:with-param name="maxsize">34</xsl:with-param>
						        </xsl:call-template>
						        <xsl:choose>
						      <xsl:when test="$trade_account_source_static = 'true'">
							 <xsl:call-template name="principal-account-field">
							       <xsl:with-param name="label">XSL_INSTRUCTIONS_PRINCIPAL_ACT_NO_LABEL</xsl:with-param>
							       <xsl:with-param name="type">account</xsl:with-param>
							       <xsl:with-param name="name">principal_act_no</xsl:with-param>
							       <xsl:with-param name="readonly">Y</xsl:with-param>
							       <xsl:with-param name="size">34</xsl:with-param>
							       <xsl:with-param name="maxsize">34</xsl:with-param>
							       <xsl:with-param name="entity-field">entity</xsl:with-param>
							       <xsl:with-param name="show-product-types">N</xsl:with-param>
							       <xsl:with-param name="prodCode"><xsl:value-of select="$product-code"/></xsl:with-param>
							       <xsl:with-param name="value"><xsl:value-of select="principal_act_no"/></xsl:with-param>
						      </xsl:call-template> 
						      <xsl:call-template name="principal-account-field">
							      <xsl:with-param name="label">XSL_INSTRUCTIONS_FEE_ACT_NO_LABEL</xsl:with-param>
							      <xsl:with-param name="type">account</xsl:with-param>
							      <xsl:with-param name="name">fee_act_no</xsl:with-param>
							      <xsl:with-param name="readonly">Y</xsl:with-param>
							      <xsl:with-param name="size">34</xsl:with-param>
							      <xsl:with-param name="maxsize">34</xsl:with-param>
							      <xsl:with-param name="entity-field">entity</xsl:with-param>
							      <xsl:with-param name="show-product-types">N</xsl:with-param>
							       <xsl:with-param name="prodCode"><xsl:value-of select="$product-code"/></xsl:with-param>
							       <xsl:with-param name="value"><xsl:value-of select="fee_act_no"/></xsl:with-param>
						      </xsl:call-template>
						      </xsl:when>
						      <xsl:otherwise>
						      <xsl:call-template name="user-account-field">
								<xsl:with-param name="label">XSL_INSTRUCTIONS_PRINCIPAL_ACT_NO_LABEL</xsl:with-param>
								<xsl:with-param name="name">principal</xsl:with-param>
								<xsl:with-param name="entity-field">entity</xsl:with-param>
								<xsl:with-param name="dr-cr">debit</xsl:with-param>
								<xsl:with-param name="show-product-types">N</xsl:with-param>
								<xsl:with-param name="product_types"><xsl:value-of select="product_code"/></xsl:with-param>
			        			<xsl:with-param name="product-types-required">N</xsl:with-param>
								<xsl:with-param name="required">N</xsl:with-param>
								<xsl:with-param name="trade_internal_account">Y</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select="fee_act_no"/></xsl:with-param>
							 </xsl:call-template>
							 <xsl:call-template name="user-account-field">
								<xsl:with-param name="label">XSL_INSTRUCTIONS_FEE_ACT_NO_LABEL</xsl:with-param>
								<xsl:with-param name="name">fee</xsl:with-param>
								<xsl:with-param name="entity-field">entity</xsl:with-param>
								<xsl:with-param name="dr-cr">debit</xsl:with-param>
								<xsl:with-param name="show-product-types">N</xsl:with-param>
								<xsl:with-param name="product_types"><xsl:value-of select="product_code"/></xsl:with-param>
			        			<xsl:with-param name="product-types-required">N</xsl:with-param>
								<xsl:with-param name="required">N</xsl:with-param>
								<xsl:with-param name="trade_internal_account">Y</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select="fee_act_no"/></xsl:with-param>
							 </xsl:call-template>
						      </xsl:otherwise>
						      </xsl:choose> 
				        	</div>
			        	</xsl:otherwise>
			        </xsl:choose>
				</xsl:otherwise>
	        </xsl:choose>
	        <xsl:if test="product_code[.='IC']">
		        <xsl:call-template name="hidden-field">
				  	<xsl:with-param name="name">document_amt</xsl:with-param>
				  	<xsl:with-param name="value">
				  		<xsl:choose>
								<xsl:when test="ic_amt[.!='']">
									<xsl:value-of select="ic_amt" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="tnx_amt" />
								</xsl:otherwise>
						</xsl:choose>
				  	</xsl:with-param>
				  </xsl:call-template>
			  </xsl:if>
			  <xsl:if test="product_code[.='LC']">			      
			     <div id="bankInst"> 
			    	<xsl:if test = "$isMT798 = 'Y'">
						 <xsl:call-template name="hidden-field">
						  	<xsl:with-param name="name">adv_send_mode</xsl:with-param>
						  	<xsl:with-param name="value">01</xsl:with-param>
				    	</xsl:call-template>
				  	</xsl:if>
				  	<xsl:call-template name="bank-instructions">
				      	<xsl:with-param name="send-mode-displayed">
				      		<xsl:choose>
				      			<xsl:when test="$isMT798 = 'Y'">N</xsl:when>
				      			<xsl:otherwise>Y</xsl:otherwise>
				      		</xsl:choose>
				      	</xsl:with-param>
						<xsl:with-param name="send-mode-required">N</xsl:with-param>
				        <xsl:with-param name="delivery-to-shown">N</xsl:with-param>
				        <xsl:with-param name="delivery-channel-displayed">Y</xsl:with-param>
				        <xsl:with-param name="principal-acc-displayed">N</xsl:with-param>
				  		<xsl:with-param name="fee-acc-displayed">N</xsl:with-param>
				  		<xsl:with-param name="free-format-text-displayed">N</xsl:with-param>
				  		<xsl:with-param name="is-toc-item">
				         	<xsl:choose>
				         		<xsl:when test="$isMT798 = 'N'">N</xsl:when>
				         		<xsl:otherwise>Y</xsl:otherwise>
				         	</xsl:choose>
				         </xsl:with-param>
				    </xsl:call-template>
			     </div>			    
			      <xsl:call-template name="hidden-field">
			      	<xsl:with-param name="name">document_amt</xsl:with-param>
			      	<xsl:with-param name="value"><xsl:value-of select="lc_liab_amt" /></xsl:with-param>
			      </xsl:call-template>
			      <xsl:call-template name="hidden-field">
					<xsl:with-param name="name">swiftregexValue</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('SWIFT_VALIDATION_REGEX')"/></xsl:with-param>
				  </xsl:call-template>
		      </xsl:if>
	      </xsl:if>
      
	      <xsl:if test="product_code[.='SR']">
	      
		      <xsl:choose>
		 		<xsl:when test="$option = 'ACTION_REQUIRED' or sub_tnx_type_code[.='66' or .='67']">
		 			<xsl:call-template name="select-field">
				         <xsl:with-param name="label">XSL_GENERALDETAILS_MESSAGE_TYPE</xsl:with-param>
				         <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
				         <xsl:with-param name="required">Y</xsl:with-param>
				         <xsl:with-param name="fieldsize">medium</xsl:with-param>
				         <xsl:with-param name="override-displaymode">
				         	<xsl:value-of select="$displaymode"/>
				         </xsl:with-param>
				         <xsl:with-param name="options">
				          <xsl:choose>
				           <xsl:when test="$displaymode='edit'">
				            <option value="66">
				             <xsl:value-of select="localization:getDecode($language, 'N003', '66')"/>
				            </option>
				            <option value="67">
				             <xsl:value-of select="localization:getDecode($language, 'N003', '67')"/>
				            </option>
				           </xsl:when>
				           <xsl:otherwise>
				            <xsl:choose>
				             <xsl:when test="sub_tnx_type_code[.='66']"><xsl:value-of select="localization:getDecode($language, 'N003', '66')"/></xsl:when>
				             <xsl:when test="sub_tnx_type_code[.='67']"><xsl:value-of select="localization:getDecode($language, 'N003', '67')"/></xsl:when>
				            </xsl:choose>
				           </xsl:otherwise>
				          </xsl:choose>
				         </xsl:with-param>
				    </xsl:call-template>
		 		</xsl:when>
		 		<xsl:otherwise>
			 		<xsl:call-template name="select-field">
				         <xsl:with-param name="label">XSL_GENERALDETAILS_MESSAGE_TYPE</xsl:with-param>
				         <xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
				         <xsl:with-param name="required">Y</xsl:with-param>
				         <xsl:with-param name="fieldsize">medium</xsl:with-param>
				         <xsl:with-param name="override-displaymode">
				         	<xsl:value-of select="$displaymode"/>
				         </xsl:with-param>
				         <xsl:with-param name="options">
				          <xsl:choose>
				           <xsl:when test="$displaymode='edit'">
				            <option value="24">
				             <xsl:value-of select="localization:getDecode($language, 'N003', '24')"/>
				            </option>
				           </xsl:when>
				           <xsl:otherwise>
				            <xsl:choose>
				             <xsl:when test="sub_tnx_type_code[.='24']"><xsl:value-of select="localization:getDecode($language, 'N003', '24')"/></xsl:when>
				            </xsl:choose>
				           </xsl:otherwise>
				          </xsl:choose>
				         </xsl:with-param>
				    </xsl:call-template>
			    </xsl:otherwise>
			  </xsl:choose>
		      <xsl:if test="$displaymode='view'">
		        <xsl:call-template name="hidden-field">
				  	<xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
				  	<xsl:with-param name="value"><xsl:value-of select="sub_tnx_type_code"/></xsl:with-param>
				</xsl:call-template>
		      </xsl:if>
      
	      
            <!-- LC Amount -->
            <div id="claimAmt" style="display:none">
			  <xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_AMOUNTDETAILS_LC_AMT_LABEL</xsl:with-param>
				<xsl:with-param name="override-currency-value"><xsl:value-of select="lc_cur_code"/></xsl:with-param>          				
				<xsl:with-param name="override-amt-value">
					<xsl:choose>
							<xsl:when test="lc_amt[.!='']">
								<xsl:value-of select="lc_amt" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="tnx_amt" />
							</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
				<xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
				<xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
				<xsl:with-param name="show-button">N</xsl:with-param>
				<xsl:with-param name="required">N</xsl:with-param>
			  </xsl:call-template>
			  
			  <xsl:call-template name="hidden-field">
			  	<xsl:with-param name="name">document_amt</xsl:with-param>
			  	<xsl:with-param name="value">
					<xsl:choose>
							<xsl:when test="lc_amt[.!='']">
								<xsl:value-of select="lc_amt" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="tnx_amt" />
							</xsl:otherwise>
					</xsl:choose>
			  	</xsl:with-param>
			  </xsl:call-template>
			  <xsl:call-template name="hidden-field">
			  	<xsl:with-param name="name">lc_amt</xsl:with-param>
			  	<xsl:with-param name="value">
					<xsl:if test="lc_amt[.!='']">
						<xsl:value-of select="lc_amt" />
					</xsl:if>	
			  	</xsl:with-param>
			  </xsl:call-template>
      
		      <xsl:call-template name="currency-field">
					<xsl:with-param name="label">XSL_AMOUNTDETAILS_CLAIM_AMT_LABEL</xsl:with-param>
					<xsl:with-param name="override-product-code">claim</xsl:with-param>
					<xsl:with-param name="override-currency-name">claim_cur_code</xsl:with-param>
					<xsl:with-param name="override-currency-value"><xsl:value-of select="lc_cur_code"/></xsl:with-param>   
					<xsl:with-param name="override-amt-value"><xsl:value-of select="tnx_amt"/></xsl:with-param>        			
					<xsl:with-param name="override-amt-name">claim_amt</xsl:with-param>
					<xsl:with-param name="currency-readonly">Y</xsl:with-param>
					<xsl:with-param name="show-button">N</xsl:with-param>
					<xsl:with-param name="required">N</xsl:with-param>
			  </xsl:call-template>
			  </div>
	    
			    <div id="bankInst"> 
			    	<xsl:if test = "$isMT798 = 'Y'">
						 <xsl:call-template name="hidden-field">
						  	<xsl:with-param name="name">adv_send_mode</xsl:with-param>
						  	<xsl:with-param name="value">01</xsl:with-param>
				    	</xsl:call-template>
				  </xsl:if>
				  	<xsl:call-template name="bank-instructions">
				      	<xsl:with-param name="send-mode-displayed">
				      		<xsl:choose>
				      			<xsl:when test="$isMT798 = 'Y'">N</xsl:when>
				      			<xsl:otherwise>Y</xsl:otherwise>
				      		</xsl:choose>
				      	</xsl:with-param>
						<xsl:with-param name="send-mode-required">N</xsl:with-param>
				        <xsl:with-param name="delivery-to-shown">N</xsl:with-param>
				        <xsl:with-param name="delivery-channel-displayed">Y</xsl:with-param>
				        <xsl:with-param name="principal-acc-displayed">N</xsl:with-param>
				  		<xsl:with-param name="fee-acc-displayed">N</xsl:with-param>
				  		<xsl:with-param name="free-format-text-displayed">N</xsl:with-param>
				  		<xsl:with-param name="is-toc-item">
				         	<xsl:choose>
				         		<xsl:when test="$isMT798 = 'N'">N</xsl:when>
				         		<xsl:otherwise>Y</xsl:otherwise>
				         	</xsl:choose>
				         </xsl:with-param>
				    </xsl:call-template>
			    </div>
	      </xsl:if>
      	</xsl:with-param>
      </xsl:call-template>
      
      <xsl:if test=" $isMT798 = 'Y' and $displaymode='edit' and product_code[.= 'LC' or 'EL']"> 
      		<xsl:call-template name="hidden-field">
			     <xsl:with-param name="id">pending_list_count</xsl:with-param>
			     <xsl:with-param name="value"><xsl:value-of select="pending_list_count"/></xsl:with-param>
			</xsl:call-template>
			<!-- <xsl:call-template name="fieldset-wrapper">
    			<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
    			<xsl:with-param name="content"> -->
					<xsl:call-template name="pending-transactions-list"/>	
				<!-- </xsl:with-param>
			</xsl:call-template>	 -->	
	 </xsl:if>

      <xsl:call-template name="message-freeformat">
        <xsl:with-param name="mt798enabled"><xsl:value-of select="$isMT798"/></xsl:with-param>
      </xsl:call-template>
      
       <!-- comments for return - currently making only for choosed product-->
    <xsl:if test="product_code[.='LC' or .='BG' or .='SI' or .='EL' or .='EC'or .='SG' or .='IC' or .='BR' or .='IP' or .='SR' or .='TF' or .='IN' or .='LI' or .='IR'] and tnx_stat_code[.!='03' and .!='04']">
      <xsl:call-template name="comments-for-return">
	  		<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
	   		<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
   	  </xsl:call-template>
   	</xsl:if>
     </xsl:with-param>
    </xsl:call-template>
   
    <!-- Form #1 : Attach Files -->
     <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED') or ($displaymode != 'edit' and $mode = 'VIEW')">
    	<xsl:choose>
    	<xsl:when test="product_code[.='EL' or .='SR']">
    	  <xsl:call-template name="attachments-file-dojo">
    		<xsl:with-param name="callback">if(misys._config.customerBanksMT798Channel[dijit.byId("advising_bank_abbv_name").get("value")] == true &amp;&amp; misys.hasAttachments() &amp;&amp; dijit.byId("adv_send_mode").get("value") == '01'){dijit.byId("delivery_channel").set("disabled", false); dijit.byId("delivery_channel").set("required", true);dijit.byId("delivery_channel").set("readOnly", false);misys.toggleFields(true, null, ["delivery_channel"], false, false);}</xsl:with-param>
    	  	<xsl:with-param name="title-size">35</xsl:with-param>
    	  </xsl:call-template>
    	</xsl:when>
    	<xsl:when test="product_code[.='LC']">
    	  <xsl:call-template name="attachments-file-dojo">
    		<xsl:with-param name="callback">if(misys._config.customerBanksMT798Channel[dijit.byId("issuing_bank_abbv_name").get("value")] == true &amp;&amp; misys.hasAttachments() &amp;&amp; dijit.byId("adv_send_mode").get("value") == '01'){dijit.byId("delivery_channel").set("disabled", false); dijit.byId("delivery_channel").set("required", true);dijit.byId("delivery_channel").set("readOnly", false);misys.toggleFields(true, null, ["delivery_channel"], false, false);}</xsl:with-param>
    	 	<xsl:with-param name="title-size">35</xsl:with-param>
    	  </xsl:call-template>
    	</xsl:when>
    	<xsl:otherwise>
    	  <xsl:call-template name="attachments-file-dojo">
    	  <xsl:with-param name="title-size">35</xsl:with-param>
    	  </xsl:call-template>
    	</xsl:otherwise>
    	</xsl:choose>    	
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
   
   <!-- Template to initialize the product and category map data for dynamic phrase. -->
	<xsl:call-template name="populate-phrase-data"/>
	 
	<script>
		<!-- Instantiate columns arrays -->
		<xsl:call-template name="product-arraylist-initialisation"/>
		
		<!-- Add columns definitions -->
		<xsl:call-template name="Columns_Definitions"/>
		
		<!-- Include some eventual additional columns -->
		<xsl:call-template name="report_addons"/>
	</script>
	
	<!-- Retrieve the javascript products' columns and candidate for every product authorised for the current user -->
	<xsl:call-template name="Products_Columns_Candidates"/>
	
   <!-- Table of Contents -->
   <xsl:call-template name="toc"/>
   
  <!-- Reauthentication -->
  <xsl:call-template name="reauthentication"/>   
   
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

  <!-- Additional JS imports for this form are -->
  <!-- added here. -->
  <xsl:template name="js-imports">
   <xsl:param name="product-code"/>
   <xsl:param name="lowercase-product-code"/>
   <xsl:param name="action"/>

   <xsl:call-template name="common-js-imports">
    <xsl:with-param name="binding">misys.binding.trade.message</xsl:with-param>
    <xsl:with-param name="override-product-code" select="$product-code"/>
    <xsl:with-param name="override-lowercase-product-code" select="$lowercase-product-code"/>
    <xsl:with-param name="override-action" select="$action"/>
    <xsl:with-param name="override-help-access-key"><xsl:value-of select="$product-code"/>_02</xsl:with-param>
   </xsl:call-template>
  </xsl:template>

  <!-- Additional hidden fields for this form are  -->
  <!-- added here. -->
  <xsl:template name="hidden-fields">
   <xsl:param name="lowercase-product-code"/>
   <xsl:call-template name="common-hidden-fields">
    <xsl:with-param name="show-type">N</xsl:with-param>
    <xsl:with-param name="show-tnx-amt">N</xsl:with-param>
    <xsl:with-param name="additional-fields">
     <xsl:if test="$displaymode='edit'">
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">prod_stat_code</xsl:with-param>
      </xsl:call-template>
       <xsl:if test="entity and entity[.!='']">
	     <xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">entity</xsl:with-param>
	     </xsl:call-template>
     </xsl:if>
     <xsl:call-template name="localization-dialog"/>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">product_code</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="product_code"/></xsl:with-param>
     </xsl:call-template>
   <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">tnx_cur_code</xsl:with-param>
    </xsl:call-template>
    <xsl:if test="product_code[.='LC'] or product_code[.='IC']">
	   <xsl:call-template name="hidden-field">
	     <xsl:with-param name="name">action_req_code</xsl:with-param>
	   </xsl:call-template>
    </xsl:if>
    <xsl:if test="product_code[.!='IC' and .!='LC']">
	    <xsl:call-template name="hidden-field">
	     <xsl:with-param name="name">tnx_amt</xsl:with-param>
	    </xsl:call-template>
    </xsl:if>
     <!--Empty the principal and fee accounts-->
<!-- <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">principal_act_no</xsl:with-param>
      <xsl:with-param name="value"/>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">fee_act_no</xsl:with-param>
      <xsl:with-param name="value"/>
     </xsl:call-template> -->
    </xsl:if>

    <!-- Displaying the bank details. -->
    <xsl:choose>
     <xsl:when test="product_code[.='LC' or .='SG' or .='LI' or .='TF' or .='SI' or .='BG' or . = 'FX' or . = 'XO' or . = 'FA']">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
       <xsl:with-param name="value" select="issuing_bank/abbv_name"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">issuing_bank_name</xsl:with-param>
       <xsl:with-param name="value" select="issuing_bank/name"/>
      </xsl:call-template> 
     </xsl:when>
     <xsl:when test="product_code[.='EL' or .='SR' or .='BR']">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">advising_bank_abbv_name</xsl:with-param>
       <xsl:with-param name="value" select="advising_bank/abbv_name"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">advising_bank_name</xsl:with-param>
       <xsl:with-param name="value" select="advising_bank/name"/>
      </xsl:call-template> 
     </xsl:when>
     <xsl:when test="product_code[.='EC' or .='IR']">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">remitting_bank_abbv_name</xsl:with-param>
       <xsl:with-param name="value" select="remitting_bank/abbv_name"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">remitting_bank_name</xsl:with-param>
       <xsl:with-param name="value" select="remitting_bank/name"/>
      </xsl:call-template> 
     </xsl:when>
     <xsl:when test="product_code[.='IC']">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">presenting_bank_abbv_name</xsl:with-param>
       <xsl:with-param name="value" select="presenting_bank/abbv_name"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">presenting_bank_name</xsl:with-param>
       <xsl:with-param name="value" select="presenting_bank/name"/>
      </xsl:call-template> 
     </xsl:when>
    </xsl:choose>
    <xsl:if test="product_code[.='EC' or .='IC']">
     <xsl:for-each select="documents/document">
      <xsl:call-template name="hidden-document-fields"/>
     </xsl:for-each>
    </xsl:if>
    <!-- <xsl:if test="product_code[.='LC']">
	    <xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">adv_send_mode</xsl:with-param>
	      <xsl:with-param name="value"><xsl:value-of select="adv_send_mode"/></xsl:with-param>
	    </xsl:call-template>
    </xsl:if> -->
    <xsl:if test="product_code[.='EL']">
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">bo_tnx_id</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="bo_tnx_id"/></xsl:with-param>
		</xsl:call-template>
    </xsl:if>
    
    <!-- The currency code and amount -->
    
    
    <xsl:if test="product_code[.='EC']">
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">fwd_contract_no</xsl:with-param>
     </xsl:call-template>
    </xsl:if>
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
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">attIds</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">fileActIds</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">selected_tnx</xsl:with-param>
       <xsl:with-param name="value" select="selected_tnx"/>
      </xsl:call-template>
      <xsl:call-template name="e2ee_transaction"/>
      <xsl:call-template name="reauth_params"/>
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="pending-transactions-list">
  	<xsl:choose>
  		<xsl:when test="pending_list/pending_record">
				<div id="pending-list-grid" style="display:none">
					<xsl:call-template name="fieldset-wrapper">
    					<xsl:with-param name="legend">XSL_HEADER_PENDING_LIST</xsl:with-param>
    					<xsl:with-param name="content">
							<div id="userAccountsTableHeaderContainer" style="width:100%;">
								<div class="userAccountsTableCell userAccountsTableCellHeader  userAccountsHeaderSelector" style="width:5%;">
								 </div>
								 <div class="userAccountsTableCell userAccountsTableCellHeader  userAccountColumnCell" >
										<xsl:attribute name="style">width:12%;</xsl:attribute>
										<xsl:value-of select="localization:getGTPString($language, 'TRANSACTIONID')"/>
								</div>
								<div class="userAccountsTableCell userAccountsTableCellHeader  userAccountColumnCell" >
										<xsl:attribute name="style">width:12%;</xsl:attribute>
										<xsl:value-of select="localization:getGTPString($language, 'STATUS')"/>
								</div>
								<div class="userAccountsTableCell userAccountsTableCellHeader  userAccountColumnCell" >
										<xsl:attribute name="style">width:12%;</xsl:attribute>
										<xsl:value-of select="localization:getGTPString($language, 'TYPE')"/>
								</div>
								<div class="userAccountsTableCell userAccountsTableCellHeader  userAccountColumnCell" >
										<xsl:attribute name="style">width:12%;</xsl:attribute>
										<xsl:value-of select="localization:getGTPString($language, 'EVENT_REF')"/>
								</div>
								<div class="userAccountsTableCell userAccountsTableCellHeader  userAccountColumnCell" >
										<xsl:attribute name="style">width:10%;</xsl:attribute>
										<xsl:value-of select="localization:getGTPString($language, 'CURCODE')"/>
								</div>
								<div class="userAccountsTableCell userAccountsTableCellHeader  userAccountColumnCell" >
										<xsl:attribute name="style">width:10%;</xsl:attribute>
										<xsl:value-of select="localization:getGTPString($language, 'AMOUNT')"/>
								</div>
								<div class="userAccountsTableCell userAccountsTableCellHeader  userAccountColumnCell" >
										<xsl:attribute name="style">width:12%;</xsl:attribute>
										<xsl:value-of select="localization:getGTPString($language, 'TRANSACTION_DATE')"/>
								</div>
							</div>	
							<xsl:for-each select="pending_list/pending_record">
							<div style="width:100%;">
								<div class="userAccountsTableCell userAccountsTableCellOdd alignCenterWithPadding userAccountsHeaderSelector" style="width:5%;">
									<input type="radio" dojoType="dijit.form.RadioButton" name="selected_record">
										<xsl:attribute name="id"><xsl:value-of select="tnx_id"/></xsl:attribute>
										<xsl:if test="selected_record[.='Y']">
				    										<xsl:attribute name="checked">checked</xsl:attribute>
				    									</xsl:if>
									</input>
								</div>
								<div class="userAccountsTableCell userAccountsTableCellOdd alignLeftWithPadding" style="width:12%;">
									<xsl:value-of select="tnx_id"/>
								</div>
								<div class="userAccountsTableCell userAccountsTableCellOdd alignLeftWithPadding" style="width:12%;">
									<xsl:value-of select="status"/>
								</div>	
								<div class="userAccountsTableCell userAccountsTableCellOdd alignLeftWithPadding" style="width:12%;">
									<xsl:value-of select="tnx_type_code"/>
								</div>
								<div class="userAccountsTableCell userAccountsTableCellOdd alignLeftWithPadding" style="width:12%;">
									<xsl:value-of select="bo_tnx_id"/>
								</div>
								<div class="userAccountsTableCell userAccountsTableCellOdd alignLeftWithPadding" style="width:10%;">
									<xsl:value-of select="tnx_cur_code"/>
								</div>
								<div class="userAccountsTableCell userAccountsTableCellOdd alignLeftWithPadding" style="width:10%;">
									<xsl:value-of select="tnx_amt"/>
								</div>
								<div class="userAccountsTableCell userAccountsTableCellOdd alignLeftWithPadding" style="width:12%;">
									<xsl:value-of select="tnx_date"/>
								</div>				
							</div>					
							</xsl:for-each>
						</xsl:with-param>		
					</xsl:call-template>			
				</div>
			</xsl:when>
			<xsl:otherwise>
				<div id="pending-list-grid" style="display:none">
					<xsl:call-template name="fieldset-wrapper">
    					<xsl:with-param name="legend">XSL_HEADER_PENDING_LIST</xsl:with-param>
    					<xsl:with-param name="content">
							<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
								No Records Found
							</div>
						</xsl:with-param>
					</xsl:call-template>
				</div>
			</xsl:otherwise>
			</xsl:choose>
  </xsl:template>
  <!-- 
   Hidden Collection Document Details
  -->
  <xsl:template name="hidden-document-fields">
   <div>
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
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">documents_details_mapped_attachment_name_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="mapped_attachment_name"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">documents_details_mapped_attachment_id_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="mapped_attachment_id"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">documents_details_doc_no_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value" select="doc_no"/>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">documents_details_doc_date_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value" select="doc_date"/>
    </xsl:call-template>
   </div>  
  </xsl:template>
</xsl:stylesheet>