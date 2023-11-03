<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
        xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
        xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
        xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
        xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
        exclude-result-prefixes="xmlRender securityCheck utils defaultresource">
        
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> 
  <xsl:param name="collaborationmode">none</xsl:param>  
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="nextscreen"/>
  <xsl:param name="option"/>
  <xsl:param name="token"/>
  <xsl:param name="draftMode"/>
  <xsl:param name="operation">SAVE_FEATURES</xsl:param>
  <xsl:param name="processdttm"/>
  
    <!-- Global Imports. -->
   <xsl:include href="../../core/xsl/common/system_common.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  
 <xsl:template match="/">
	<xsl:apply-templates select="entity_account_record"/>
 </xsl:template>
	
 <xsl:template match="entity_account_record">
		<xsl:call-template name="loading-message"/>
		<div>
			<xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
			    
			<xsl:call-template name="server-message">
		 		<xsl:with-param name="name">server_message</xsl:with-param>
		 		<xsl:with-param name="content"><xsl:value-of select="message"/></xsl:with-param>
		 		<xsl:with-param name="appendClass">serverMessage</xsl:with-param>
			</xsl:call-template>
			
			<!-- Form #0 : Main Form -->
			<xsl:call-template name="form-wrapper">
			     <xsl:with-param name="name" select="$main-form-name"/>
			     <xsl:with-param name="validating">Y</xsl:with-param>
			     <xsl:with-param name="content">
			     	 <xsl:call-template name="company-details"/>
			     	 <xsl:call-template name="general-account-details"/>
                         
					<xsl:choose>
    					<xsl:when test="account_type[.='01']">
    						<xsl:call-template name="current-account-details"/>
    						<xsl:if test="defaultresource:getResource('LIQUIDITY_BACK_OFFICE_KTP') ='false'">
    							<xsl:call-template name="liquidity-details"/>
    						</xsl:if>				
    					</xsl:when>
    					<xsl:when test="account_type[.='02']">
    						<xsl:call-template name="deposit-account-details"/>
    					</xsl:when>
    					<xsl:when test="account_type[.='03']">
    						<xsl:call-template name="saving-account-details"/>
    						<xsl:if test="defaultresource:getResource('LIQUIDITY_BACK_OFFICE_KTP') ='false'">
    							<xsl:call-template name="liquidity-details"/>
    						</xsl:if>
    					</xsl:when>
    					<xsl:when test="account_type[.='04']">
    						<xsl:call-template name="bank-details"/>
    						<xsl:call-template name="loan-account-details"/>
    					</xsl:when>
    					<xsl:when test="account_type[.='05']">
    						<xsl:call-template name="bank-details"/>
    						<xsl:call-template name="term-deposit-account-details"/>
    					</xsl:when>
       					<xsl:when test="account_type[.='07']">
       						<xsl:call-template name="call-and-notice-account-details"/>
       					</xsl:when>
   					    <xsl:otherwise/>
					</xsl:choose>
                    <xsl:call-template name="account-rate-details"/>
			     </xsl:with-param>
		    </xsl:call-template>
			
		    <xsl:call-template name="realform"/>
	    </div>
		<!-- Javascript imports  -->
   		<xsl:call-template name="js-imports"/>   
 </xsl:template>
 
  <!-- Additional JS imports for this form are -->
 <!-- added here. -->
 <xsl:template name="js-imports">
  <xsl:call-template name="system-common-js-imports">
   <xsl:with-param name="override-home-url">'/screen/<xsl:value-of select="$nextscreen"/>?option=ENTITY_ACCOUNT_LIST_DISPLAY&amp;entity=<xsl:value-of select="entity/entity_id"/>&amp;company=<xsl:value-of select="entity/company_abbv_name"/>'</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <xsl:template name="company-details">
 <xsl:if test="entity/abbv_name[.!='']">
 <xsl:call-template name="fieldset-wrapper">
   		<xsl:with-param name="legend">XSL_HEADER_ENTITY_DETAILS</xsl:with-param>
   		<xsl:with-param name="content">
     	<xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_ENTITY_ABBV_NAME</xsl:with-param>
      			<xsl:with-param name="id">entity_abbv_name_view</xsl:with-param>
      			<xsl:with-param name="value"><xsl:value-of select="entity/abbv_name"/></xsl:with-param>
      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
     	</xsl:call-template>
		<xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_ENTITY_NAME</xsl:with-param>
      			<xsl:with-param name="id">entity_name_view</xsl:with-param>
      			<xsl:with-param name="value"><xsl:value-of select="entity/name"/></xsl:with-param>
      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
     	</xsl:call-template>
   		</xsl:with-param>
  </xsl:call-template>
</xsl:if>  
 </xsl:template>
  <xsl:template name="account-hold-details">
      <xsl:call-template name="fieldset-wrapper">
          <xsl:with-param name="legend">XSL_ACCOUNT_HOLDS_DETAILS_LABEL</xsl:with-param>
            <xsl:with-param name="content">
               <xsl:call-template name="input-field">
                 <xsl:with-param name="label">XSL_ACCOUNT_HOLD_START_DATE</xsl:with-param>
                 <xsl:with-param name="id">hold_description</xsl:with-param>
                 <xsl:with-param name="value"><xsl:value-of select="account_hold/hold_start_date"/></xsl:with-param>
                 <xsl:with-param name="override-displaymode">view</xsl:with-param>
               </xsl:call-template>       
               <xsl:call-template name="input-field">
                 <xsl:with-param name="label">XSL_ACCOUNT_HOLD_EXPIRY_DATE</xsl:with-param>
                 <xsl:with-param name="id">hold_description</xsl:with-param>
                 <xsl:with-param name="value"><xsl:value-of select="account_hold/hold_expiry_date"/></xsl:with-param>
                 <xsl:with-param name="override-displaymode">view</xsl:with-param>
               </xsl:call-template>                     
               <xsl:call-template name ="account-hold-description"/>                                                            
            </xsl:with-param>
      </xsl:call-template>
 </xsl:template>
 
 <xsl:template name="account-rate-details">
     <xsl:call-template name="fieldset-wrapper">
         <xsl:with-param name="legend">XSL_ACCOUNT_RATE_DETAILS</xsl:with-param>
         <xsl:with-param name="content">
               <xsl:call-template name="input-field">
                 <xsl:with-param name="label">XSL_DEBIT_BASE_RATE</xsl:with-param>
                 <xsl:with-param name="id">debit_base_rate</xsl:with-param>
                 <xsl:with-param name="value"><xsl:value-of select="rates/debit_base_rate"/></xsl:with-param>
                 <xsl:with-param name="override-displaymode">view</xsl:with-param>
               </xsl:call-template>        
               <xsl:call-template name="input-field">
                 <xsl:with-param name="label">XSL_DEBIT_DIFF_RATE</xsl:with-param>
                 <xsl:with-param name="id">debbit_diff_rate</xsl:with-param>
                 <xsl:with-param name="value"><xsl:value-of select="rates/debit_diff_rate"/></xsl:with-param>
                 <xsl:with-param name="override-displaymode">view</xsl:with-param>
               </xsl:call-template>           
         </xsl:with-param>
     </xsl:call-template>
 </xsl:template>
 
 
  <!--
  Main Details of the Accounts
  -->
 <xsl:template name="general-account-details">
	<xsl:variable name="current"><xsl:value-of select="static_company/language"/></xsl:variable>
  	<xsl:call-template name="fieldset-wrapper">
   		<xsl:with-param name="legend">XSL_ACCOUNT_NAME_LABEL</xsl:with-param>
   		<xsl:with-param name="content">
   			 <xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_ACCOUNT_NAME</xsl:with-param>
      			<xsl:with-param name="id">acct_name_view</xsl:with-param>
      			<xsl:with-param name="value">
      				<xsl:choose>
	      				<xsl:when test="nickname[.!='']"><xsl:value-of select="nickname"/></xsl:when>
	      				<xsl:otherwise><xsl:value-of select="acct_name"/></xsl:otherwise>
      				</xsl:choose>
      			</xsl:with-param>
      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>
     		 <xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_ACCOUNT_NUMBER</xsl:with-param>
      			<xsl:with-param name="id">acct_no_view</xsl:with-param>
      			<xsl:with-param name="value"><xsl:value-of select="account_no"/></xsl:with-param>
      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>
     		<xsl:call-template name="input-field">
       	  		<xsl:with-param name="label">XSL_ACCOUNT_CURRENCY</xsl:with-param>
       	  		<xsl:with-param name="id">acct_cur_code_view</xsl:with-param>
       	  		<xsl:with-param name="value"><xsl:value-of select="cur_code"/></xsl:with-param>
           		<xsl:with-param name="override-displaymode">view</xsl:with-param>
        	 </xsl:call-template>
			<xsl:call-template name="input-field">
      			 <xsl:with-param name="label">XSL_ACCOUNT_DESCRIPTION</xsl:with-param>
      			 <xsl:with-param name="id">acct_description_view</xsl:with-param>
      			 <xsl:with-param name="value"><xsl:value-of select="description"/></xsl:with-param>
      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>
     		<xsl:call-template name="input-field">
      			 <xsl:with-param name="label">XSL_JURISDICTION_ACTIVE_LABEL</xsl:with-param>
      			 <xsl:with-param name="id">active_status_view</xsl:with-param>
      			 <xsl:with-param name="value">
      			 <xsl:choose>
	      			 <xsl:when test="actv_flag[.='Y']"><xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_ACTIVE_YES')"/></xsl:when>
	      			 <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_ACTIVE_NO')"/></xsl:otherwise>
      			 </xsl:choose>
      			 </xsl:with-param>
      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>
     			<xsl:if test="(account_type[.='04']) or (account_type[.='05'])"> 
                <xsl:call-template name="input-field"> 
                       <xsl:with-param name="label">XSL_BANK_CUST_NUMBER</xsl:with-param> 
                       <xsl:with-param name="id">bo_cust_numb</xsl:with-param> 
                       <xsl:with-param name="value"><xsl:value-of select="bo_cust_number"/></xsl:with-param> 
                       <xsl:with-param name="override-displaymode">view</xsl:with-param> 
            	</xsl:call-template> 
            	<xsl:call-template name="input-field"> 
	                  <xsl:with-param name="label">XSL_AB_BRANCH_NO</xsl:with-param> 
	                  <xsl:with-param name="id">brch_code_view</xsl:with-param> 
	                  <xsl:with-param name="value"><xsl:value-of select="branch_no"/></xsl:with-param> 
	                  <xsl:with-param name="override-displaymode">view</xsl:with-param> 
           	 </xsl:call-template> 
           </xsl:if> 
	   </xsl:with-param>
	 </xsl:call-template>
 </xsl:template>


 <!-- Current Account Details  -->
 <xsl:template name="current-account-details">
	<xsl:variable name="current"><xsl:value-of select="static_company/language"/></xsl:variable>
  	<xsl:call-template name="fieldset-wrapper">
   		<xsl:with-param name="legend">XSL_CURRENT_ACCOUNT_DETAILS_LABEL</xsl:with-param>
   		<xsl:with-param name="content">
   			 <xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_AB_BANK_NAME</xsl:with-param>
      			<xsl:with-param name="id">bank_name_view</xsl:with-param>
      			<xsl:with-param name="value"><xsl:value-of select="bank_name"/></xsl:with-param>
      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>
     		 <xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_AB_BANK_ADDRESS_1</xsl:with-param>
      			<xsl:with-param name="id">bank_address_line_1_view</xsl:with-param>
      			<xsl:with-param name="value"><xsl:value-of select="bank_address_line_1"/></xsl:with-param>
      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>
     		<xsl:call-template name="input-field">
       	  		<xsl:with-param name="label">XSL_AB_BANK_ADDRESS_2</xsl:with-param>
       	  		<xsl:with-param name="id">bank_address_line_2_view</xsl:with-param>
       	  		<xsl:with-param name="value"><xsl:value-of select="bank_address_line_2"/></xsl:with-param>
           		<xsl:with-param name="override-displaymode">view</xsl:with-param>
        	 </xsl:call-template>
			<xsl:call-template name="input-field">
      			 <xsl:with-param name="label">XSL_AB_BANK_ACCOUNT_PRODUCT_TYPE</xsl:with-param>
      			 <xsl:with-param name="id">bank_account_product_type_view</xsl:with-param>
      			 <xsl:with-param name="value"><xsl:value-of select="bank_account_product_type"/></xsl:with-param>
      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>
     		<xsl:call-template name="input-field">
      			 <xsl:with-param name="label">XSL_AB_BANK_ACCOUNT_TYPE</xsl:with-param>
      			 <xsl:with-param name="id">bank_account_type_view</xsl:with-param>
      			 <xsl:with-param name="value"><xsl:value-of select="bank_account_type"/></xsl:with-param>
      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>         	 
			<xsl:call-template name="input-field">
      			 <xsl:with-param name="label">XSL_AB_ISO_CODE</xsl:with-param>
      			 <xsl:with-param name="id">iso_code_view</xsl:with-param>
      			 <xsl:with-param name="value"><xsl:value-of select="iso_code"/></xsl:with-param>
      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>
			<xsl:call-template name="input-field">
      			 <xsl:with-param name="label">XSL_AB_ROUTING_CODE</xsl:with-param>
      			 <xsl:with-param name="id">routing_bic_view</xsl:with-param>
      			 <xsl:with-param name="value"><xsl:value-of select="routing_bic"/></xsl:with-param>
      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>
			<xsl:call-template name="input-field">
      			 <xsl:with-param name="label">XSL_AB_OVERDRAFT_LIMIT</xsl:with-param>
      			 <xsl:with-param name="id">overdraft_limit_view</xsl:with-param>
      			 <xsl:with-param name="value"><xsl:value-of select="overdraft_limit"/></xsl:with-param>
      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template> 
     		<!-- <xsl:call-template name="input-field">
      			 <xsl:with-param name="label">XSL_AB_INTEREST_CREDIT</xsl:with-param>
      			 <xsl:with-param name="id">interest_rate_credit_view</xsl:with-param>
      			 <xsl:with-param name="value"><xsl:value-of select="interest_rate_credit"/></xsl:with-param>
      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>   -->
     		<!-- Commenting the Branch code as it is not required to display the portal specific branch code (00001) which we have to make in core also as discussed with BA
     		<xsl:call-template name="input-field">
      			 <xsl:with-param name="label">XSL_AB_BRANCH_CODE</xsl:with-param>
      			 <xsl:with-param name="id">brch_code_view</xsl:with-param>
      			 <xsl:with-param name="value"><xsl:value-of select="brch_code"/></xsl:with-param>
      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template> -->
            <xsl:call-template name="input-field">
                 <xsl:with-param name="label">XSL_ACCOUNT_ADDITIONAL_DETAIL_DR_TIER_RATE</xsl:with-param>
                 <xsl:with-param name="id">hold_description</xsl:with-param>
                 <xsl:with-param name="value"><xsl:value-of select="account_additional_details/dr_actual_rate"/>&nbsp;%</xsl:with-param>
                 <xsl:with-param name="override-displaymode">view</xsl:with-param>
            </xsl:call-template>       
            <xsl:call-template name="input-field">
                 <xsl:with-param name="label">XSL_ACCOUNT_ADDITIONAL_DETAIL_CR_TIER_RATE</xsl:with-param>
                 <xsl:with-param name="id">hold_description</xsl:with-param>
                 <xsl:with-param name="value"><xsl:value-of select="account_additional_details/cr_actual_rate"/>&nbsp;%</xsl:with-param>
                 <xsl:with-param name="override-displaymode">view</xsl:with-param>
            </xsl:call-template>
     		<xsl:call-template name="input-field">
      			 <xsl:with-param name="label">XSL_AB_BRANCH_NO</xsl:with-param>
      			 <xsl:with-param name="id">branch_no_view</xsl:with-param>
      			 <xsl:with-param name="value"><xsl:value-of select="branch_no"/></xsl:with-param>
      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>  


	   </xsl:with-param>
	 </xsl:call-template>
 </xsl:template>


 <!-- Deposit  Account Details  -->
 <xsl:template name="deposit-account-details">
	<xsl:variable name="current"><xsl:value-of select="static_company/language"/></xsl:variable>
  	<xsl:call-template name="fieldset-wrapper">
   		<xsl:with-param name="legend">XSL_DEPOSIT_ACCOUNT_DETAILS_LABEL</xsl:with-param>
   		<xsl:with-param name="content">
   			 <xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_AB_BANK_NAME</xsl:with-param>
      			<xsl:with-param name="id">bank_name_view</xsl:with-param>
      			<xsl:with-param name="value"><xsl:value-of select="bank_abbv_name"/></xsl:with-param>
      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>
     		 <xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_AB_BANK_ADDRESS_1</xsl:with-param>
      			<xsl:with-param name="id">bank_address_line_1_view</xsl:with-param>
      			<xsl:with-param name="value"><xsl:value-of select="bank_address_line_1"/></xsl:with-param>
      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>
     		<xsl:call-template name="input-field">
       	  		<xsl:with-param name="label">XSL_AB_BANK_ADDRESS_2</xsl:with-param>
       	  		<xsl:with-param name="id">bank_address_line_2_view</xsl:with-param>
       	  		<xsl:with-param name="value"><xsl:value-of select="bank_address_line_2"/></xsl:with-param>
           		<xsl:with-param name="override-displaymode">view</xsl:with-param>
        	 </xsl:call-template>
			<xsl:call-template name="input-field">
      			 <xsl:with-param name="label">XSL_AB_BANK_ACCOUNT_PRODUCT_TYPE</xsl:with-param>
      			 <xsl:with-param name="id">bank_account_product_type_view</xsl:with-param>
      			 <xsl:with-param name="value"><xsl:value-of select="bank_account_product_type"/></xsl:with-param>
      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>
     		<xsl:call-template name="input-field">
      			 <xsl:with-param name="label">XSL_AB_BANK_ACCOUNT_TYPE</xsl:with-param>
      			 <xsl:with-param name="id">bank_account_type_view</xsl:with-param>
      			 <xsl:with-param name="value"><xsl:value-of select="bank_account_type"/></xsl:with-param>
      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>        	 
			<xsl:call-template name="input-field">
      			 <xsl:with-param name="label">XSL_AB_ISO_CODE</xsl:with-param>
      			 <xsl:with-param name="id">iso_code_view</xsl:with-param>
      			 <xsl:with-param name="value"><xsl:value-of select="iso_code"/></xsl:with-param>
      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>
			<xsl:call-template name="input-field">
      			 <xsl:with-param name="label">XSL_AB_ROUTING_CODE</xsl:with-param>
      			 <xsl:with-param name="id">routing_bic_view</xsl:with-param>
      			 <xsl:with-param name="value"><xsl:value-of select="routing_bic"/></xsl:with-param>
      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>
			<xsl:call-template name="input-field">
      			 <xsl:with-param name="label">XSL_AB_OVERDRAFT_LIMIT</xsl:with-param>
      			 <xsl:with-param name="id">overdraft_limit_view</xsl:with-param>
      			 <xsl:with-param name="value"><xsl:value-of select="overdraft_limit"/></xsl:with-param>
      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template> 
     		<!-- <xsl:call-template name="input-field">
      			 <xsl:with-param name="label">XSL_AB_INTEREST_CREDIT</xsl:with-param>
      			 <xsl:with-param name="id">interest_rate_credit_view</xsl:with-param>
      			 <xsl:with-param name="value"><xsl:value-of select="interest_rate_credit"/></xsl:with-param>
      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>   -->
     		<!-- Commenting the Branch code as it is not required to display the portal specific branch code (00001) which we have to make in core also as discussed with BA
     		<xsl:call-template name="input-field">
      			 <xsl:with-param name="label">XSL_AB_BRANCH_CODE</xsl:with-param>
      			 <xsl:with-param name="id">brch_code_view</xsl:with-param>
      			 <xsl:with-param name="value"><xsl:value-of select="brch_code"/></xsl:with-param>
      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>  -->
     		<xsl:call-template name="input-field">
      			 <xsl:with-param name="label">XSL_AB_BRANCH_NO</xsl:with-param>
      			 <xsl:with-param name="id">branch_no_view</xsl:with-param>
      			 <xsl:with-param name="value"><xsl:value-of select="branch_no"/></xsl:with-param>
      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>  
	   </xsl:with-param>
	 </xsl:call-template>
 </xsl:template>

 <!-- Saving  Account Details  -->
 <xsl:template name="saving-account-details">
	<xsl:variable name="current"><xsl:value-of select="static_company/language"/></xsl:variable>
  	<xsl:call-template name="fieldset-wrapper">
   		<xsl:with-param name="legend">XSL_SAVING_ACCOUNT_DETAILS_LABEL</xsl:with-param>
   		<xsl:with-param name="content">
  			 <xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_AB_BANK_NAME</xsl:with-param>
      			<xsl:with-param name="id">bank_name_view</xsl:with-param>
      			<xsl:with-param name="value"><xsl:value-of select="bank_abbv_name"/></xsl:with-param>
      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>
     		 <xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_AB_BANK_ADDRESS_1</xsl:with-param>
      			<xsl:with-param name="id">bank_address_line_1_view</xsl:with-param>
      			<xsl:with-param name="value"><xsl:value-of select="bank_address_line_1"/></xsl:with-param>
      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>
     		<xsl:call-template name="input-field">
       	  		<xsl:with-param name="label">XSL_AB_BANK_ADDRESS_2</xsl:with-param>
       	  		<xsl:with-param name="id">bank_address_line_2_view</xsl:with-param>
       	  		<xsl:with-param name="value"><xsl:value-of select="bank_address_line_2"/></xsl:with-param>
           		<xsl:with-param name="override-displaymode">view</xsl:with-param>
        	 </xsl:call-template>
			<xsl:call-template name="input-field">
      			 <xsl:with-param name="label">XSL_AB_BANK_ACCOUNT_PRODUCT_TYPE</xsl:with-param>
      			 <xsl:with-param name="id">bank_account_product_type_view</xsl:with-param>
      			 <xsl:with-param name="value"><xsl:value-of select="bank_account_product_type"/></xsl:with-param>
      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>
     		<xsl:call-template name="input-field">
      			 <xsl:with-param name="label">XSL_AB_BANK_ACCOUNT_TYPE</xsl:with-param>
      			 <xsl:with-param name="id">bank_account_type_view</xsl:with-param>
      			 <xsl:with-param name="value"><xsl:value-of select="bank_account_type"/></xsl:with-param>
      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>        	 
			<xsl:call-template name="input-field">
      			 <xsl:with-param name="label">XSL_AB_ISO_CODE</xsl:with-param>
      			 <xsl:with-param name="id">iso_code_view</xsl:with-param>
      			 <xsl:with-param name="value"><xsl:value-of select="iso_code"/></xsl:with-param>
      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>
     		<!-- <xsl:call-template name="input-field">
      			 <xsl:with-param name="label">XSL_AB_INTEREST_CREDIT</xsl:with-param>
      			 <xsl:with-param name="id">interest_rate_credit_view</xsl:with-param>
      			 <xsl:with-param name="value"><xsl:value-of select="interest_rate_credit"/></xsl:with-param>
      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>   -->
     		<!-- Commenting the Branch code as it is not required to display the portal specific branch code (00001) which we have to make in core also as discussed with BA
     		<xsl:call-template name="input-field">
      			 <xsl:with-param name="label">XSL_AB_BRANCH_CODE</xsl:with-param>
      			 <xsl:with-param name="id">brch_code_view</xsl:with-param>
      			 <xsl:with-param name="value"><xsl:value-of select="brch_code"/></xsl:with-param>
      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template> -->    
            <xsl:call-template name="input-field">
                 <xsl:with-param name="label">XSL_ACCOUNT_ADDITIONAL_DETAIL_CR_TIER_RATE</xsl:with-param>
                 <xsl:with-param name="id">hold_description</xsl:with-param>
                 <xsl:with-param name="value"><xsl:value-of select="account_additional_details/cr_actual_rate"/>&nbsp;%</xsl:with-param>
                 <xsl:with-param name="override-displaymode">view</xsl:with-param>
            </xsl:call-template>
     		<xsl:call-template name="input-field">
      			 <xsl:with-param name="label">XSL_AB_BRANCH_NO</xsl:with-param>
      			 <xsl:with-param name="id">branch_no_view</xsl:with-param>
      			 <xsl:with-param name="value"><xsl:value-of select="branch_no"/></xsl:with-param>
      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>  

	   </xsl:with-param>
	 </xsl:call-template>
 </xsl:template>
 
  <!-- Loan  Account Details  -->
  <xsl:template name="loan-account-details">
	<xsl:variable name="current"><xsl:value-of select="static_company/language"/></xsl:variable>
  	<xsl:call-template name="fieldset-wrapper">
   		<xsl:with-param name="legend">XSL_LOAN_ACCOUNT_DETAILS_LABEL</xsl:with-param>
   		<xsl:with-param name="content">
  		        <xsl:if test="overdraft_limit[.!='']">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_OVERDRAFT_LIMIT</xsl:with-param>
						<xsl:with-param name="name">overdraft_limit</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="cur_code"/>&nbsp;<xsl:value-of select="overdraft_limit"/></xsl:with-param>
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="principal_amount[.!='']">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_PRINCIPLE_AMOUNT</xsl:with-param>
							<xsl:with-param name="name">principal_amount</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="cur_code"/>&nbsp;<xsl:value-of select="principal_amount"/></xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
				</xsl:if>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_START_DATE</xsl:with-param>
					<xsl:with-param name="name">start_date</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="end_date[.!='']">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_END_DATE</xsl:with-param>
						<xsl:with-param name="name">end_date</xsl:with-param>
						<xsl:with-param name="value">
							<xsl:choose>
							    <xsl:when test="end_date[.='01/01/3000']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_MATURITY_OPEN')"/>
								</xsl:when>
								<xsl:otherwise>
							    	<xsl:value-of select="end_date"/>
						    	</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="interest_on_maturity[.!=''] and defaultresource:getResource('TD_INTEREST_AMT_DISPLAY') = 'true'">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_INTEREST_ON_MATURITY</xsl:with-param>
						<xsl:with-param name="name">interest_on_maturity</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="cur_code"/>&nbsp;<xsl:value-of select="interest_on_maturity"/></xsl:with-param>
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="maturity_amount[.!='']">
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_MATURITY_AMOUNT</xsl:with-param>
						<xsl:with-param name="name">maturity_amount</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="cur_code"/>&nbsp;<xsl:value-of select="maturity_amount"/></xsl:with-param>
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_INTEREST_RATE_CREDIT</xsl:with-param>
					<xsl:with-param name="name">interest_rate_credit</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="interest_rate_credit"/><xsl:if test="interest_rate_credit[.!='']">
					<xsl:text>%</xsl:text>
					</xsl:if></xsl:with-param>
					
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_INTEREST_RATE_DEBIT</xsl:with-param>
					<xsl:with-param name="name">interest_rate_debit</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="interest_rate_debit"/><xsl:if test="interest_rate_debit[.!='']">
					<xsl:text>%</xsl:text>
					</xsl:if></xsl:with-param>
				</xsl:call-template>
     		  
	   </xsl:with-param>
	 </xsl:call-template>
 </xsl:template>
 
  <!-- Term  Account Details  -->
 <xsl:template name="term-deposit-account-details">
	<xsl:variable name="current"><xsl:value-of select="static_company/language"/></xsl:variable>
  	<xsl:call-template name="fieldset-wrapper">
   		<xsl:with-param name="legend">XSL_TERM_ACCOUNT_DETAILS_LABEL</xsl:with-param>
   		<xsl:with-param name="content">
     		<xsl:if test="overdraft_limit[.!='']">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_OVERDRAFT_LIMIT</xsl:with-param>
						<xsl:with-param name="name">overdraft_limit</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="cur_code"/>&nbsp;<xsl:value-of select="overdraft_limit"/></xsl:with-param>
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="principal_amount[.!='']">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_PRINCIPLE_AMOUNT</xsl:with-param>
							<xsl:with-param name="name">principal_amount</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="cur_code"/>&nbsp;<xsl:value-of select="principal_amount"/></xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
				</xsl:if>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_START_DATE</xsl:with-param>
					<xsl:with-param name="name">start_date</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="end_date[.!='']">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_END_DATE</xsl:with-param>
						<xsl:with-param name="name">end_date</xsl:with-param>
						<xsl:with-param name="value">
							<xsl:choose>
							    <xsl:when test="end_date[.='01/01/3000']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_ACCOUNT_MATURITY_OPEN')"/>
								</xsl:when>
								<xsl:otherwise>
							    	<xsl:value-of select="end_date"/>
						    	</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="interest_on_maturity[.!=''] and defaultresource:getResource('TD_INTEREST_AMT_DISPLAY') = 'true'">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_INTEREST_ON_MATURITY</xsl:with-param>
						<xsl:with-param name="name">interest_on_maturity</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="cur_code"/>&nbsp;<xsl:value-of select="interest_on_maturity"/></xsl:with-param>
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="maturity_amount[.!='']">
						<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">maturity_amount</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="cur_code"/>&nbsp;<xsl:value-of select="maturity_amount"/></xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_INTEREST_RATE_CREDIT</xsl:with-param>
					<xsl:with-param name="name">interest_rate_credit</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="interest_rate_credit"/><xsl:if test="interest_rate_credit[.!='']">
					<xsl:text>%</xsl:text>
					</xsl:if></xsl:with-param>
					
				</xsl:call-template>
				<!-- TODO: Need to check if these fields are really required-->
				<!-- <xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_FUNDING_ACCOUNT_NO</xsl:with-param>
					<xsl:with-param name="name">funding_account_no</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_MONTHLY_PAYMENT</xsl:with-param>
					<xsl:with-param name="name">monthly_payment</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_NEXT_PAYMENT_DATE</xsl:with-param>
					<xsl:with-param name="name">next_payment_date</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_REPAYMENT_DATE</xsl:with-param>
					<xsl:with-param name="name">repayment_date</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
				</xsl:call-template> -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_INTEREST_RATE_DEBIT</xsl:with-param>
					<xsl:with-param name="name">interest_rate_debit</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="interest_rate_debit"/><xsl:if test="interest_rate_debit[.!='']">
					<xsl:text>%</xsl:text>
					</xsl:if></xsl:with-param>
				</xsl:call-template>
	   </xsl:with-param>
	 </xsl:call-template>
 </xsl:template> 
 
 <!-- CN Account Details  -->
 <xsl:template name="call-and-notice-account-details">
	<xsl:variable name="current"><xsl:value-of select="static_company/language"/></xsl:variable>
  	<xsl:call-template name="fieldset-wrapper">
   		<xsl:with-param name="legend">XSL_CN_ACCOUNT_DETAILS_LABEL</xsl:with-param>
   		<xsl:with-param name="content">
  			 <xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_AB_BANK_NAME</xsl:with-param>
      			<xsl:with-param name="id">bank_name_view</xsl:with-param>
      			<xsl:with-param name="value"><xsl:value-of select="bank_abbv_name"/></xsl:with-param>
      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>
     		 <xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_AB_BANK_ADDRESS_1</xsl:with-param>
      			<xsl:with-param name="id">bank_address_line_1_view</xsl:with-param>
      			<xsl:with-param name="value"><xsl:value-of select="bank_address_line_1"/></xsl:with-param>
      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>
     		<xsl:call-template name="input-field">
       	  		<xsl:with-param name="label">XSL_AB_BANK_ADDRESS_2</xsl:with-param>
       	  		<xsl:with-param name="id">bank_address_line_2_view</xsl:with-param>
       	  		<xsl:with-param name="value"><xsl:value-of select="bank_address_line_2"/></xsl:with-param>
           		<xsl:with-param name="override-displaymode">view</xsl:with-param>
        	 </xsl:call-template>
			<xsl:call-template name="input-field">
      			 <xsl:with-param name="label">XSL_AB_BANK_ACCOUNT_PRODUCT_TYPE</xsl:with-param>
      			 <xsl:with-param name="id">bank_account_product_type_view</xsl:with-param>
      			 <xsl:with-param name="value"><xsl:value-of select="bank_account_product_type"/></xsl:with-param>
      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>
     		<xsl:call-template name="input-field">
      			 <xsl:with-param name="label">XSL_AB_BANK_ACCOUNT_TYPE</xsl:with-param>
      			 <xsl:with-param name="id">bank_account_type_view</xsl:with-param>
      			 <xsl:with-param name="value"><xsl:value-of select="bank_account_type"/></xsl:with-param>
      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>        	 
			<xsl:call-template name="input-field">
      			 <xsl:with-param name="label">XSL_AB_ISO_CODE</xsl:with-param>
      			 <xsl:with-param name="id">iso_code_view</xsl:with-param>
      			 <xsl:with-param name="value"><xsl:value-of select="iso_code"/></xsl:with-param>
      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>
     		<!-- <xsl:call-template name="input-field">
      			 <xsl:with-param name="label">XSL_AB_INTEREST_CREDIT</xsl:with-param>
      			 <xsl:with-param name="id">interest_rate_credit_view</xsl:with-param>
      			 <xsl:with-param name="value"><xsl:value-of select="interest_rate_credit"/></xsl:with-param>
      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>   -->
     		<!-- Commenting the Branch code as it is not required to display the portal specific branch code (00001) which we have to make in core also as discussed with BA
     		<xsl:call-template name="input-field">
      			 <xsl:with-param name="label">XSL_AB_BRANCH_CODE</xsl:with-param>
      			 <xsl:with-param name="id">brch_code_view</xsl:with-param>
      			 <xsl:with-param name="value"><xsl:value-of select="brch_code"/></xsl:with-param>
      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>  -->
     		<xsl:call-template name="input-field">
      			 <xsl:with-param name="label">XSL_AB_BRANCH_NO</xsl:with-param>
      			 <xsl:with-param name="id">branch_no_view</xsl:with-param>
      			 <xsl:with-param name="value"><xsl:value-of select="branch_no"/></xsl:with-param>
      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>  

	   </xsl:with-param>
	 </xsl:call-template>
 </xsl:template>
 	
 <!-- Realform -->
 <xsl:template name="realform">
  <xsl:call-template name="form-wrapper">
   <xsl:with-param name="name">realform</xsl:with-param>
   <xsl:with-param name="method">POST</xsl:with-param>
   <xsl:with-param name="action">
    <xsl:choose>
     <xsl:when test="$nextscreen"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$nextscreen"/></xsl:when>
    </xsl:choose>
   </xsl:with-param>
    <xsl:with-param name="content">
     <div class="widgetContainer">
      <xsl:call-template name="localization-dialog"/>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">operation</xsl:with-param>
       <xsl:with-param name="id">realform_operation</xsl:with-param>
       <xsl:with-param name="value">SAVE_FEATURES</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
       <xsl:with-param name="value">SAVE_ACCOUNTS_NICKNAME_MAINTENANCE</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
	  <xsl:call-template name="hidden-field">
    	<xsl:with-param name="name">featureid</xsl:with-param>
    	<xsl:with-param name="value"><xsl:value-of select="account_no"/></xsl:with-param>
   	  </xsl:call-template>
   	  <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">token</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$token"/></xsl:with-param>
      </xsl:call-template>
	  <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">mode</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$draftMode"/></xsl:with-param>
      </xsl:call-template>
      <xsl:if test="entity/entity_id">
	      <xsl:call-template name="hidden-field">
	       	<xsl:with-param name="name">entity</xsl:with-param>
	       	<xsl:with-param name="value"><xsl:value-of select="entity/entity_id"/></xsl:with-param>
	      </xsl:call-template>
	  </xsl:if>
	   <xsl:if test="entity/company_abbv_name">
   	  	<xsl:call-template name="hidden-field">
       		<xsl:with-param name="name">company</xsl:with-param>
       		<xsl:with-param name="value"><xsl:value-of select="entity/company_abbv_name"/></xsl:with-param>
      	</xsl:call-template>
      	</xsl:if>
     </div>
    </xsl:with-param>
   </xsl:call-template>
 </xsl:template>

 <xsl:template name="account-hold-description">
      <xsl:call-template name="input-field">
          <xsl:with-param name="label">XSL_HOLD_DESCRIPTION</xsl:with-param>
          <xsl:with-param name="id">hold_description</xsl:with-param>
          <xsl:with-param name="value"><xsl:value-of select="account_hold/hold_description"/></xsl:with-param>
          <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="input-field">
          <xsl:with-param name="id">hold_description</xsl:with-param>
          <xsl:with-param name="value"><xsl:value-of select="account_hold/hold_description_line_1"/></xsl:with-param>
          <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="input-field">
           <xsl:with-param name="id">hold_description</xsl:with-param>
           <xsl:with-param name="value"><xsl:value-of select="account_hold/hold_description_line_2"/></xsl:with-param>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="input-field">
           <xsl:with-param name="id">hold_description</xsl:with-param>
           <xsl:with-param name="value"><xsl:value-of select="account_hold/hold_description_line_2"/></xsl:with-param>
           <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template>   
 </xsl:template>
 
 <xsl:template name="liquidity-details">
 <xsl:call-template name="fieldset-wrapper">
	 	<xsl:with-param name="legend">XSL_LIQUIDITY_DETAILS_WRAPPER_LABEL</xsl:with-param>
	 	<xsl:with-param name="content">
   			 <xsl:if test="sweeping_enabled!=''">
	   			 <xsl:call-template name="input-field">
	      			 <xsl:with-param name="label">XSL_SWEEPING_ENABLED</xsl:with-param>
	      			 <xsl:with-param name="id">sweeping_enabled</xsl:with-param>
	      			 <xsl:with-param name="value">
	      			 <xsl:choose>
		      			 <xsl:when test="sweeping_enabled[.='Y']"><xsl:value-of select="localization:getGTPString($language, 'XSL_YES')"/></xsl:when>
		      			 <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_NO')"/></xsl:otherwise>
	      			 </xsl:choose>
	      			 </xsl:with-param>
	      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
	     		</xsl:call-template>
     		</xsl:if>
     		<xsl:if test="pooling_enabled!=''">
	     		<xsl:call-template name="input-field">
	      			 <xsl:with-param name="label">XSL_POOLING_ENABLED</xsl:with-param>
	      			 <xsl:with-param name="id">pooling_enabled</xsl:with-param>
	      			 <xsl:with-param name="value">
	      			 <xsl:choose>
		      			 <xsl:when test="pooling_enabled[.='Y']"><xsl:value-of select="localization:getGTPString($language, 'XSL_YES')"/></xsl:when>
		      			 <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_NO')"/></xsl:otherwise>
	      			 </xsl:choose>
	      			 </xsl:with-param>
	      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
	     		</xsl:call-template>
     		</xsl:if>
     		<xsl:if test="charge_account_for_liq!=''">
	     		<xsl:call-template name="input-field">
	      			 <xsl:with-param name="label">XSL_CHARGE_ACCOUNT_FOR_LIQUIDITY</xsl:with-param>
	      			 <xsl:with-param name="id">charge_account_for_liq</xsl:with-param>
	      			 <xsl:with-param name="value">
	      			 <xsl:choose>
		      			 <xsl:when test="charge_account_for_liq[.='Y']"><xsl:value-of select="localization:getGTPString($language, 'XSL_YES')"/></xsl:when>
		      			 <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_NO')"/></xsl:otherwise>
	      			 </xsl:choose>
	      			 </xsl:with-param>
	      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
	     		</xsl:call-template>
     		</xsl:if>
     	</xsl:with-param>	
	 </xsl:call-template>
 </xsl:template>
 
 <xsl:template name="bank-details">
	<xsl:variable name="current"><xsl:value-of select="static_company/language"/></xsl:variable>
  	<xsl:call-template name="fieldset-wrapper">
   		<xsl:with-param name="legend">XSL_BANK_DETAILS_LABEL</xsl:with-param>
   		<xsl:with-param name="content">
   			 <xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_AB_BANK_NAME</xsl:with-param>
      			<xsl:with-param name="id">bank_name_view</xsl:with-param>
      			<xsl:with-param name="value"><xsl:value-of select="bank_name"/></xsl:with-param>
      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>
     		 <xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_AB_BANK_ADDRESS_1</xsl:with-param>
      			<xsl:with-param name="id">bank_address_line_1_view</xsl:with-param>
      			<xsl:with-param name="value"><xsl:value-of select="bank_address_line_1"/></xsl:with-param>
      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>
     		<xsl:call-template name="input-field">
       	  		<xsl:with-param name="label">XSL_AB_BANK_ADDRESS_2</xsl:with-param>
       	  		<xsl:with-param name="id">bank_address_line_2_view</xsl:with-param>
       	  		<xsl:with-param name="value"><xsl:value-of select="bank_address_line_2"/></xsl:with-param>
           		<xsl:with-param name="override-displaymode">view</xsl:with-param>
        	 </xsl:call-template>
			<xsl:call-template name="input-field">
      			 <xsl:with-param name="label">XSL_BANK_DOM</xsl:with-param>
      			 <xsl:with-param name="id">bank_dom</xsl:with-param>
      			 <xsl:with-param name="value"><xsl:value-of select="bank_dom"/></xsl:with-param>
      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>
    </xsl:with-param>
	 </xsl:call-template>
 </xsl:template>

</xsl:stylesheet>