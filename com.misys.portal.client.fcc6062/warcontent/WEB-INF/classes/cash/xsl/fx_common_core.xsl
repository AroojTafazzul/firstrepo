<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates that are common to all 

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      10/15/10
author:    Pascal Marzin
email:     Pascal.Marzin@misys.com
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
 version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
  xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
  xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
  xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
  xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
  exclude-result-prefixes="localization utils security securitycheck defaultresource">
  <!--
  ########################################################################
  #1 - COMMON TEMPLATES FOR ALL SCREENS
  # 
  ########################################################################
  -->
  <!--
    FX General Details Fieldset.
  -->
  <xsl:variable name="swift_flag" select="defaultresource:getResource('OPICS_SWIFT_ENABLED')='true'"/>
  <xsl:template name="fx-general-details">
   	<div class="widgetContainer">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
		<xsl:with-param name="content">
			<!-- Common general details. -->
			<xsl:choose>
			<xsl:when test="product_code[.!='TD'] and sub_product_code[.!='TRTD']">
				<xsl:call-template name="common-general-details">
					<xsl:with-param name="show-template-id">N</xsl:with-param>
					<xsl:with-param name="show-product-code">Y</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="common-general-details">
					<xsl:with-param name="show-template-id">N</xsl:with-param>
					<xsl:with-param name="show-sub-product-code">Y</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
			</xsl:choose>
						
			<!-- Applicant Details -->
   			<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
				<xsl:with-param name="legend-type">indented-header</xsl:with-param>
				<xsl:with-param name="content">
					<xsl:call-template name="address">
						<xsl:with-param name="show-entity">Y</xsl:with-param>
						<xsl:with-param name="prefix">applicant</xsl:with-param>
					</xsl:call-template>
    			</xsl:with-param>
   			</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
	</div>
  </xsl:template> 
  
  <xsl:template name="bank-details">
   	<div class="widgetContainer">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_BANK_DETAILS</xsl:with-param>
		<xsl:with-param name="content">
			<!-- Bank Name -->
			<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="legend">XSL_BANKDETAILS_TAB_ISSUING_BANK</xsl:with-param>
				<xsl:with-param name="legend-type">indented-header</xsl:with-param>
				<xsl:with-param name="content">
					<xsl:call-template name="issuing-bank-tabcontent"/>    
				</xsl:with-param>
			</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
	</div>
  </xsl:template> 
  
  <!-- Template to choose the contract option (purchase / sale) -->
  <xsl:template name="fx-contract-type-option">
	<xsl:call-template name="multioption-group">
    	<xsl:with-param name="group-label">XSL_CONTRACT_FX_CONTRACT_TYPE_LABEL</xsl:with-param>
    	<xsl:with-param name="content">
	     	<xsl:call-template name="radio-field">
	      		<xsl:with-param name="label">XSL_CONTRACT_FX_CONTRACT_TYPE_PURCHASE_LABEL</xsl:with-param>
	      		<xsl:with-param name="name">contract_type</xsl:with-param>
	      		<xsl:with-param name="id">contract_type_1</xsl:with-param>
	      		<xsl:with-param name="value">01</xsl:with-param>
	      		<xsl:with-param name="checked">
	      		<xsl:if test="not(contract_type) or contract_type[.=''] or contract_type[.='01']">Y</xsl:if>
	      		</xsl:with-param>
	     	</xsl:call-template>
	     	<xsl:call-template name="radio-field">
	      		<xsl:with-param name="label">XSL_CONTRACT_FX_CONTRACT_TYPE_SALE_LABEL</xsl:with-param>
	      		<xsl:with-param name="name">contract_type</xsl:with-param>
	      		<xsl:with-param name="id">contract_type_2</xsl:with-param>
	      		<xsl:with-param name="value">02</xsl:with-param>
	     	</xsl:call-template>
    	</xsl:with-param>
   	</xsl:call-template>
  </xsl:template>


	<xsl:template name="fx-contract-type-sale">		
		<xsl:call-template name="input-field">
	    	<xsl:with-param name="label">XSL_CONTRACT_FX_CONTRACT_TYPE_LABEL</xsl:with-param>
	        <xsl:with-param name="value" select="localization:getGTPString($language, 'XSL_CONTRACT_FX_CONTRACT_TYPE_SALE_LABEL')"/>
	        <xsl:with-param name="override-displaymode">view</xsl:with-param>
	    </xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">contract_type</xsl:with-param>
			<xsl:with-param name="id">contract_type</xsl:with-param>
			<xsl:with-param name="value">01</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="fx-contract-type-purchase">	
	<xsl:call-template name="input-field">
	    	<xsl:with-param name="label">XSL_CONTRACT_FX_CONTRACT_TYPE_LABEL</xsl:with-param>
	        <xsl:with-param name="value" select="localization:getGTPString($language, 'XSL_CONTRACT_FX_CONTRACT_TYPE_PURCHASE_LABEL')"/>
	        <xsl:with-param name="override-displaymode">view</xsl:with-param>
	    </xsl:call-template>	
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">contract_type</xsl:with-param>
			<xsl:with-param name="id">contract_type</xsl:with-param>
			<xsl:with-param name="value">02</xsl:with-param>
		</xsl:call-template>
	</xsl:template>     
  
  
  
  <!-- Template to display request & clear buttons -->
  <xsl:template name="fx-action-button">
  	<xsl:if test="$displaymode='edit'">
		<xsl:call-template name="row-wrapper">
			<xsl:with-param name="content">
				<xsl:call-template name="button-wrapper">
					<xsl:with-param name="id">request_button</xsl:with-param>
					<xsl:with-param name="label">XSL_ACTION_REQUEST</xsl:with-param>
					<xsl:with-param name="onclick">misys.fncPerformRequest();return false;</xsl:with-param>
					<xsl:with-param name="show-text-label">Y</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="button-wrapper">
					<xsl:with-param name="id">request_clear_button</xsl:with-param>
					<xsl:with-param name="label">XSL_ACTION_CLEAR</xsl:with-param>
					<xsl:with-param name="onclick">misys.fncPerformClearWithDialog();</xsl:with-param>
					<xsl:with-param name="show-text-label">Y</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:if>
  </xsl:template>
  
  <xsl:template name="fx-contract-type-label">
	<xsl:call-template name="input-field">
    	<xsl:with-param name="label">XSL_CONTRACT_FX_TYPE_LABEL</xsl:with-param>
        <xsl:with-param name="value" select="localization:getGTPString($language, concat('FX_CONTRACT_TYPE_', sub_product_code))"/>
        <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
		<xsl:with-param name="name">sub_product_code</xsl:with-param>
		<xsl:with-param name="value" select="sub_product_code"/>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="fx-accept-button">
  	<xsl:call-template name="row-wrapper">
		<xsl:with-param name="content">
	       <xsl:call-template name="button-wrapper">
	       		<xsl:with-param name="id">buttonAcceptRequest</xsl:with-param>
		       <xsl:with-param name="label">XSL_ACTION_ACCEPT</xsl:with-param>
		       <xsl:with-param name="show-text-label">Y</xsl:with-param>
	       </xsl:call-template>
	       <xsl:call-template name="button-wrapper">
		       <xsl:with-param name="label">XSL_ACTION_REJECT</xsl:with-param>
		       <xsl:with-param name="id">buttonCancelRequest</xsl:with-param>
		       <xsl:with-param name="show-text-label">Y</xsl:with-param>
	       </xsl:call-template>
       </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
  
  <!--
  ########################################################################
  #2 - SPECIFICS TEMPLATES USE BY TWO OR MORE SCREENS
  #
  ########################################################################
  -->
  <!--  -->
  <xsl:template name="fx-currencies-fields">
  <!-- Currency amount -->
	<xsl:call-template name="currency-field">
	    <xsl:with-param name="label">XSL_CONTRACT_FX_CONTRACT_AMOUNT_LABEL</xsl:with-param>
	    <xsl:with-param name="product-code">input_fx</xsl:with-param>
	    <xsl:with-param name="override-currency-value"><xsl:value-of select="fx_cur_code"/></xsl:with-param>
     	<xsl:with-param name="override-amt-value"><xsl:value-of select="fx_amt"/></xsl:with-param>
	    <xsl:with-param name="required">Y</xsl:with-param>
   	</xsl:call-template>
   	<!-- Counter currency -->
	
	<xsl:choose> 
	<xsl:when test="defaultresource:getResource('ENABLE_FX_COUNTER_AMOUNT') = 'true'"> 	
	  	<xsl:call-template name="currency-field">
		    <xsl:with-param name="label">XSL_CONTRACT_FX_SETTLEMENT_CTAMOUNT_LABEL</xsl:with-param>
		    <xsl:with-param name="product-code">input_counter</xsl:with-param>
		    <xsl:with-param name="required">Y</xsl:with-param>
			<xsl:with-param name="override-currency-value"><xsl:value-of select="counter_cur_code"/></xsl:with-param>
			<xsl:with-param name="override-amt-value"><xsl:value-of select="counter_amt"/></xsl:with-param>
		</xsl:call-template>
	</xsl:when>
	<xsl:otherwise>
	   	<xsl:call-template name="currency-field">
		    <xsl:with-param name="label">XSL_CONTRACT_FX_SETTLEMENT_CURRENCY_LABEL</xsl:with-param>
		    <xsl:with-param name="product-code">input_counter</xsl:with-param>
		    <xsl:with-param name="required">Y</xsl:with-param>
			<xsl:with-param name="show-amt">N</xsl:with-param>
			<xsl:with-param name="override-currency-value"><xsl:value-of select="counter_cur_code"/></xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">input_counter_amt</xsl:with-param>
		</xsl:call-template>
	</xsl:otherwise>
	</xsl:choose>
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">fx_cur_code</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">fx_amt</xsl:with-param>
	</xsl:call-template>
  </xsl:template>
 
 <xsl:template name="fx-currencies-amount-fields">  		
	<xsl:call-template name="currency-field">
	    <xsl:with-param name="label">XSL_CONTRACT_FX_ORG_CUR_AMT_LABEL</xsl:with-param>
	    <xsl:with-param name="product-code">input_fx</xsl:with-param>
	    <xsl:with-param name="override-currency-value"><xsl:value-of select="fx_cur_code"/></xsl:with-param>
     	<xsl:with-param name="override-amt-value"><xsl:value-of select="fx_amt"/></xsl:with-param>
	    <xsl:with-param name="required">Y</xsl:with-param>
   	</xsl:call-template>
	<xsl:call-template name="currency-field">
	    <xsl:with-param name="label">XSL_CONTRACT_FX_CONTRACT_AMOUNT_LABEL</xsl:with-param>
	    <xsl:with-param name="product-code">input_fx</xsl:with-param>
	    <xsl:with-param name="override-currency-value"><xsl:value-of select="tnx_cur_code"/></xsl:with-param>
     	<xsl:with-param name="override-amt-value"><xsl:value-of select="tnx_amt"/></xsl:with-param>
	    <xsl:with-param name="required">Y</xsl:with-param>
   	</xsl:call-template>   	
 </xsl:template>

 <xsl:template name="fx-spot-forward-currencies-amount-fields">  		
	<xsl:call-template name="currency-field">
	    <xsl:with-param name="label">XSL_CONTRACT_FX_CONTRACT_AMOUNT_LABEL</xsl:with-param>
	    <xsl:with-param name="product-code">input_fx</xsl:with-param>
	    <xsl:with-param name="override-currency-value"><xsl:value-of select="fx_cur_code"/></xsl:with-param>
     	<xsl:with-param name="override-amt-value"><xsl:value-of select="fx_amt"/></xsl:with-param>
	    <xsl:with-param name="required">Y</xsl:with-param>
   	</xsl:call-template>   	
 </xsl:template>
 
  
  <xsl:template name="fx-settlement-details">
    <div class="widgetContainer">
    	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_SETTLEMENT_DETAILS</xsl:with-param>
		<xsl:with-param name="content">
			<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="legend">XSL_HEADER_PAYMENT_BENEFICIARY_DETAILS</xsl:with-param>
				<xsl:with-param name="legend-type">indented-header</xsl:with-param>
				<xsl:with-param name="content">
					<!-- 				
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">smean</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SETTLEMENT_MEANS</xsl:with-param>
						<xsl:with-param name="value" select="SMEANS"/>
					</xsl:call-template>
					 -->
											 
 					<xsl:call-template name="input-field">
						<xsl:with-param name="name">saccount</xsl:with-param>
						<!-- <xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SETTLEMENT_ACCOUNTNUMBER</xsl:with-param> -->
						<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_ACCOUNT</xsl:with-param>						
						<xsl:with-param name="value" select="SACCOUNT"/>
					</xsl:call-template> 
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">bendetails</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SETTLEMENT_BENEFICIARY_DETAILS</xsl:with-param>
						<xsl:with-param name="value" select="COUNTERPARTY_NAME"/>
						<!-- <xsl:with-param name="value" select="BENDETAILS"/> -->
					</xsl:call-template>	
					
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">bendeaddress1</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SETTLEMENT_BENEFICIARY_ADDRESS</xsl:with-param>
						<!-- <xsl:with-param name="value" select="BENDETAILS"/>  -->
						<xsl:with-param name="value" select="COUNTERPARTY_ADD_LINE_1"/> 
					</xsl:call-template>					
	
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">bendeaddline2</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SETTLEMENT_BENEFICIARY_CITY</xsl:with-param>
						<xsl:with-param name="value" select="COUNTERPARTY_ADD_LINE_2"/> 
					</xsl:call-template>

					<xsl:call-template name="input-field">
						<xsl:with-param name="name">bendedom</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SETTLEMENT_BENEFICIARY_COUNTRY</xsl:with-param>
						<xsl:with-param name="value" select="COUNTERPARTY_DOM"/> 
					</xsl:call-template>
					<xsl:if test="$swift_flag='true'">
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">bene_details_clrc</xsl:with-param>
						<xsl:with-param name="label">XSL_CLEARING_CODE</xsl:with-param>
						<xsl:with-param name="value" select="BENE_DETAILS_CLRC"/>
					</xsl:call-template>
					</xsl:if>
		
					<!-- <xsl:call-template name="input-field">
						<xsl:with-param name="name">bencountry</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SETTLEMENT_BENEFICIARY_COUNTRY</xsl:with-param>
						<xsl:with-param name="value" select="COUNTERPARTY_COUNTRY"/> 
					</xsl:call-template> -->				

					<!-- <xsl:call-template name="input-field">
						<xsl:with-param name="name">benbiccode</xsl:with-param>
						<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BIC_CODE_SWIFT</xsl:with-param>
						<xsl:with-param name="value" select="CPTY_INTER_SWIFT_BIC_CODE"/> 
					</xsl:call-template> -->				
					
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">beneficiaryAccount</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_BENEFICIARY_ACCOUNT</xsl:with-param>
						<xsl:with-param name="value" select="BENEFICIARY_ACCOUNT"/>
					</xsl:call-template>			
									
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">awbank</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_BENEFICIARY_BANK_NAME</xsl:with-param>
						<xsl:with-param name="value" select="AWBANK"/>
					</xsl:call-template>			

					<xsl:call-template name="input-field">
						<xsl:with-param name="name">awbankaddress2</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_BENEFICIARY_BANK_BRANCH</xsl:with-param>
						<xsl:with-param name="value" select="CPTY_BRANCH_NAME"/>
					</xsl:call-template>

					<xsl:call-template name="input-field">
						<xsl:with-param name="name">awbankbranchName</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_BENEFICIARY_BANK_ADRESS</xsl:with-param>
						<xsl:with-param name="value" select="CPTY_BRANCH_ADDRESS_LINE_1"/>
					</xsl:call-template>

					<xsl:call-template name="input-field">
						<xsl:with-param name="name">awbankbranchadd3</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_BENEFICIARY_BANK_CITY</xsl:with-param>
						<xsl:with-param name="value" select="CPTY_BANK_DOM"/>
					</xsl:call-template>

					<xsl:call-template name="input-field">
						<xsl:with-param name="name">awbankbiccode</xsl:with-param>
						<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BIC</xsl:with-param>
						<xsl:with-param name="value" select="CPTY_BANK_SWIFT_BIC_CODE"/>
					</xsl:call-template>
					<xsl:if test="$swift_flag='true'">
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">beneficiary_bank_clrc</xsl:with-param>
							<xsl:with-param name="label">XSL_CLEARING_CODE</xsl:with-param>
							<xsl:with-param name="value" select="BENEFICIARY_BANK_CLRC"/>
						</xsl:call-template>
					</xsl:if>
				<xsl:call-template name="input-field">
						<xsl:with-param name="name">awbankbankcode</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_BENEFICIARY_BANK_ACCOUNT</xsl:with-param>
						<xsl:with-param name="value" select="AWBANKCODE"/>
					</xsl:call-template>	
					
					
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">orderingCustomerName</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_ORDERING</xsl:with-param>
						<xsl:with-param name="value" select="ORDERING_CUSTOMER_NAME"/>
					</xsl:call-template>			
				
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">orderingCustomerAddress</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_ORDERING_ADDRESS</xsl:with-param>
						<xsl:with-param name="value" select="ORDERING_CUSTOMER_ADDRESS"/>
					</xsl:call-template>
					<xsl:if test="$swift_flag='true'">
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">orderingCustomerAddress2</xsl:with-param>
							<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_ORDERING_ADDRESS_2</xsl:with-param>
							<xsl:with-param name="value" select="ORDERING_CUSTOMER_ADDRESS_2"/>
						</xsl:call-template>			
					</xsl:if>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">orderingCustomerCity</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_ORDERING_CITY</xsl:with-param>
						<xsl:with-param name="value" select="ORDERING_CUSTOMER_CITY"/>
					</xsl:call-template>			

					<xsl:call-template name="input-field">
						<xsl:with-param name="name">orderingCustomerCountry</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_ORDERING_COUNTRY</xsl:with-param>
						<xsl:with-param name="value" select="ORDERING_CUSTOMER_COUNTRY"/>
					</xsl:call-template>
					<xsl:if test="$swift_flag='true'">
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">order_details_clrc</xsl:with-param>
							<xsl:with-param name="label">XSL_CLEARING_CODE</xsl:with-param>
							<xsl:with-param name="value" select="ORDER_DETAILS_CLRC"/>
						</xsl:call-template>
					</xsl:if>
						<xsl:choose>
							<xsl:when test="SWIFT_CHARGES[.='01']">
								<xsl:call-template name="input-field">
									<xsl:with-param name="name">swiftCharges</xsl:with-param>
									<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SWIFT_CHARGES</xsl:with-param>
									
									<xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INSTRUCTIONS_APPLICANT_LABEL')"/></xsl:with-param>
								</xsl:call-template>								
							</xsl:when>
							<xsl:when test="SWIFT_CHARGES[.='02']">
								<xsl:call-template name="input-field">
									<xsl:with-param name="name">swiftCharges</xsl:with-param>
									<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SWIFT_CHARGES</xsl:with-param>
									<xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_LABEL')"/></xsl:with-param>
								</xsl:call-template>
							</xsl:when>
							<xsl:when test="SWIFT_CHARGES[.='05']">
							<!-- <xsl:variable name="SSIShareOption"><xsl:value-of select="jetSpeedResources:getBoolean('FX.enable.SSI.ShareOption')"/></xsl:variable>
								<xsl:if test="$SSIShareOption = 'true'"> -->										
									<xsl:call-template name="input-field">
									<xsl:with-param name="name">swiftCharges</xsl:with-param>
									<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SWIFT_CHARGES</xsl:with-param>
									<xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INSTRUCTIONS_SHARED_LABEL')"/></xsl:with-param>
								</xsl:call-template>
								<!-- </xsl:if> -->							
							</xsl:when>
							<xsl:otherwise>
							</xsl:otherwise>
						</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			<div>
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_ADDITIONAL_DETAILS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">

					<xsl:call-template name="input-field">
						<xsl:with-param name="name">interBankName</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_INTERMEDIARY_BANK</xsl:with-param>
						<xsl:with-param name="value" select="INTER_BANK_NAME"/>
					</xsl:call-template>			

					<xsl:call-template name="input-field">
						<xsl:with-param name="name">interBankStreet</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_INTERMEDIARY_BANK_STREET</xsl:with-param>
						<xsl:with-param name="value" select="INTER_BANK_STREET"/>
					</xsl:call-template>				
				
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">interBankCity</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_INTERMEDIARY_BANK_CITY</xsl:with-param>
						<xsl:with-param name="value" select="INTER_BANK_CITY"/>
					</xsl:call-template>			

					<xsl:call-template name="input-field">
						<xsl:with-param name="name">interBankCountry</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_INTERMEDIARY_BANK_COUNTRY</xsl:with-param>
						<xsl:with-param name="value" select="INTER_BANK_COUNTRY"/>
					</xsl:call-template>
					<xsl:if test="$swift_flag='true'">	
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">inter_bank_clrc</xsl:with-param>
							<xsl:with-param name="label">XSL_CLEARING_CODE</xsl:with-param>
							<xsl:with-param name="value" select="INTER_BANK_CLRC"/>
						</xsl:call-template>			
					</xsl:if>

					<xsl:call-template name="input-field">
						<xsl:with-param name="name">interbankbiccode</xsl:with-param>
						<xsl:with-param name="label">XSL_SI_BANK_INSTRUCTIONS_INTERMEDIARY_BIC_CODE_SWIFT</xsl:with-param>
						<xsl:with-param name="value" select="CPTY_INTER_SWIFT_BIC_CODE"/> 
					</xsl:call-template>
					
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">interBankAccount</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_INTERMEDIARY_BANK_ACCOUNT</xsl:with-param>
						<xsl:with-param name="value" select="INTER_BANK_ACCOUNT"/>
					</xsl:call-template>				
					
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">r1</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SPECIAL_ROUTING_INSTR_1</xsl:with-param>
						<xsl:with-param name="value" select="SENDERTORECEIVER_R1"/>
					</xsl:call-template>													

					<xsl:call-template name="input-field">
						<xsl:with-param name="name">r2</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SPECIAL_ROUTING_INSTR_2</xsl:with-param>
						<xsl:with-param name="value" select="SENDERTORECEIVER_R2"/>
					</xsl:call-template>													
					
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">r3</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SPECIAL_ROUTING_INSTR_3</xsl:with-param>
						<xsl:with-param name="value" select="SENDERTORECEIVER_R3"/>
					</xsl:call-template>													
					
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">r4</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SPECIAL_ROUTING_INSTR_4</xsl:with-param>
						<xsl:with-param name="value" select="SENDERTORECEIVER_R4"/>
					</xsl:call-template>	

					<xsl:call-template name="input-field">
						<xsl:with-param name="name">r5</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SPECIAL_ROUTING_INSTR_5</xsl:with-param>
						<xsl:with-param name="value" select="SENDERTORECEIVER_R5"/>
					</xsl:call-template>	

					<xsl:call-template name="input-field">
						<xsl:with-param name="name">r6</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SPECIAL_ROUTING_INSTR_6</xsl:with-param>
						<xsl:with-param name="value" select="SENDERTORECEIVER_R6"/>
					</xsl:call-template>	

					</xsl:with-param>
				</xsl:call-template>
			</div>
			<div>
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_SI_PAYMENT_DETAILS_TAB_LABEL</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
					
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_SI_ADDITIONAL_DETAILS_LINE_1</xsl:with-param>
							<xsl:with-param name="name">review_additional_detail_1</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value" select="PAYMENT_DETAIL_1"/>
						</xsl:call-template>						
						
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_SI_ADDITIONAL_DETAILS_LINE_2</xsl:with-param>
							<xsl:with-param name="name">review_additional_detail_2</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value" select="PAYMENT_DETAIL_2"/>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_SI_ADDITIONAL_DETAILS_LINE_3</xsl:with-param>
							<xsl:with-param name="name">review_additional_detail_3</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value" select="PAYMENT_DETAIL_3"/>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_SI_ADDITIONAL_DETAILS_LINE_4</xsl:with-param>
							<xsl:with-param name="name">review_additional_detail_4</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value" select="PAYMENT_DETAIL_4"/>
						</xsl:call-template>
					
						<!-- 
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">review_fee_account</xsl:with-param>
							<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_INTERMEDIARY_BANK</xsl:with-param>
							<xsl:with-param name="value" select="INTER_BANK_NAME"/>
						</xsl:call-template>			
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">review_fee_account</xsl:with-param>
							<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_INTERMEDIARY_BANK_STREET</xsl:with-param>
							<xsl:with-param name="value" select="INTER_BANK_STREET"/>
						</xsl:call-template>			
						<xsl:call-template name="input-field">
						<xsl:with-param name="name">review_fee_account</xsl:with-param>
							<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_BENEFICIARY_BANK</xsl:with-param>
							<xsl:with-param name="value" select="AWBANK"/>
						</xsl:call-template>								
						
						<xsl:call-template name="input-field">
						<xsl:with-param name="name">review_fee_account</xsl:with-param>
							<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_AWACCOUNT</xsl:with-param>
							<xsl:with-param name="value" select="AWACCOUNT"/>
						</xsl:call-template>								
						
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">review_fee_account</xsl:with-param>
							<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SENDER_TO_RECEIVER</xsl:with-param>
							<xsl:with-param name="value" select="SENDER_TO_RECEIVER"/>
						</xsl:call-template>	
						
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">review_fee_account</xsl:with-param>
							<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_BENEFICIARY_BANK_ROUTING</xsl:with-param>
							<xsl:with-param name="value" select="PAYMENTDETAILS"/>
						</xsl:call-template>					
						 -->					
																
					</xsl:with-param>
				</xsl:call-template>
			</div>			
	</xsl:with-param>
	</xsl:call-template>
    		</div> 	
  </xsl:template>
  
  <!--  -->
  <xsl:template name="fx-trade-details">
  	<div id="trade-details">
		<xsl:if test="$displaymode='edit'">
			<xsl:attribute name="style">display:none</xsl:attribute>
		</xsl:if>
	   <xsl:call-template name="fieldset-wrapper">
	    <xsl:with-param name="legend">XSL_HEADER_CONTRACT_DETAILS</xsl:with-param>
	    <xsl:with-param name="parseWidgets">N</xsl:with-param>
	    <xsl:with-param name="content"> 	
				<xsl:call-template name="input-field">
					<xsl:with-param name="name">trade_id_report</xsl:with-param>
					<xsl:with-param name="label">XSL_CONTRACT_FX_TRADE_ID_LABEL</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
					<xsl:with-param name="value">
						<xsl:choose>
							<xsl:when test="$displaymode='edit'">setByFncPerformRequest</xsl:when>
							<xsl:otherwise><xsl:value-of select="trade_id"/></xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">trade_id</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">rec_id</xsl:with-param>
				</xsl:call-template>
				
				<xsl:call-template name="input-field">
					<xsl:with-param name="name">fx_amt_report</xsl:with-param>
					<xsl:with-param name="label">XSL_CONTRACT_FX_CONTRACT_AMOUNT_LABEL</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
					<xsl:with-param name="value">
						<xsl:choose>
							<xsl:when test="$displaymode='edit'">setByFncPerformRequest</xsl:when>
							<xsl:otherwise><xsl:value-of select="normalize-space(concat(fx_cur_code, ' ', fx_amt))"/></xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
				
				<xsl:call-template name="input-field">
					<xsl:with-param name="name">rate_report</xsl:with-param>
					<xsl:with-param name="label">XSL_CONTRACT_FX_RATE_LABEL</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
					<xsl:with-param name="type">ratenumber</xsl:with-param>
					<xsl:with-param name="value">
						<xsl:choose>
							<xsl:when test="$displaymode='edit'">setByFncPerformRequest</xsl:when>
							<xsl:otherwise><xsl:value-of select="rate"/></xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
					<xsl:with-param name="appendClass">strong_rate</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">rate</xsl:with-param>
				</xsl:call-template>

				<xsl:call-template name="input-field">
					<xsl:with-param name="name">counter_amt_report</xsl:with-param>
					<xsl:with-param name="label">XSL_CONTRACT_FX_SETTLEMENT_AMOUNT_LABEL</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
					<xsl:with-param name="value">
						<xsl:choose>
							<xsl:when test="$displaymode='edit'">setByFncPerformRequest</xsl:when>
							<xsl:otherwise><xsl:value-of select="normalize-space(concat(counter_cur_code, ' ', counter_amt))"/></xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">counter_cur_code</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">counter_amt</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="sub_product_code[.='DOPT']">
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">option_date_report</xsl:with-param>
						<xsl:with-param name="label">XSL_CONTRACT_FX_SETTLEMENT_OPTION_LABEL</xsl:with-param>
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
						<xsl:with-param name="value">
							<xsl:choose>
								<xsl:when test="$displaymode='edit'">setByFncPerformRequest</xsl:when>
								<xsl:otherwise><xsl:value-of select="option_date"/></xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">option_date</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="sub_product_code[.='WFWD']">
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">option_date_report</xsl:with-param>
						<xsl:with-param name="label">XSL_CONTRACT_FX_SETTLEMENT_OPTION_LABEL</xsl:with-param>
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
						<xsl:with-param name="value">
							<xsl:choose>
								<xsl:when test="$displaymode='edit'">setByFncPerformRequest</xsl:when>
								<xsl:otherwise><xsl:value-of select="option_date"/></xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">option_date</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:call-template name="input-field">
					<xsl:with-param name="name">maturity_date_report</xsl:with-param>
					<xsl:with-param name="label">
					<xsl:choose>
						<xsl:when test="(sub_product_code[.='DOPT']) or (sub_product_code[.='SPOT']) or (sub_product_code[.='FWD']) or (sub_product_code[.='WFWD'])">XSL_CONTRACT_FX_VALUE_DATE_LABEL</xsl:when>
						<xsl:otherwise>XSL_CONTRACT_FX_SETTLEMENT_DATE_LABEL</xsl:otherwise>
					</xsl:choose>
					</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
					<xsl:with-param name="value">
						<xsl:choose>
							<xsl:when test="$displaymode='edit'">setByFncPerformRequest</xsl:when>
							<xsl:when test="sub_product_code[.='DOPT'] or (sub_product_code[.='WFWD'])"><xsl:value-of select="value_date"/></xsl:when>
							<xsl:otherwise><xsl:value-of select="maturity_date"/></xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">value_date</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">maturity_date</xsl:with-param>
				</xsl:call-template>
				
				<div id="traderRemarksContainer">
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">trader_remarks_report</xsl:with-param>
						<xsl:with-param name="label">XSL_FX_TRADER_REMARKS</xsl:with-param>
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
						<xsl:with-param name="value">
							<xsl:choose>
								<xsl:when test="$displaymode='edit'">setByFncPerformRequest</xsl:when>
								<xsl:otherwise><xsl:value-of select="trader_remarks"/></xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</div>				
					
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">trader_remarks</xsl:with-param>
				</xsl:call-template>
		      	
		      	<xsl:if test="$displaymode='edit'">
					<xsl:call-template name="cash-rate-progress-bar"/>
					<xsl:call-template name="fx-accept-button"/>
					<xsl:call-template name="input-field">
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
						<xsl:with-param name="value" select="localization:getGTPString($language, 'XSL_CONTRACT_FX_COMMITMENT_TO_CONTRACT')"/>
					</xsl:call-template>
		      	</xsl:if>
		</xsl:with-param>
		</xsl:call-template>
	</div>
  </xsl:template>

  <!--
  ########################################################################
  #3 - TEMPLATES USE BY THE REVIEW MODE OF AN FX UPDATE
  #
  ########################################################################
  -->
  <xsl:template name="fx-update-review">
  	<xsl:param name="originalDeal" select="org_previous_file/fx_tnx_record"/>
  		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_REQUEST_FOR_QUOTE_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
			  	<!-- Original deal -->
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_CONTRACT_FX_ORG_DEAL_LABEL</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">original_trade_id</xsl:with-param>
							<xsl:with-param name="label">XSL_CONTRACT_FX_TRADE_ID_LABEL</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="$originalDeal/trade_id"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">original_amt</xsl:with-param>
							<xsl:with-param name="label">XSL_CONTRACT_FX_AMOUNT_LABEL</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="$originalDeal/fx_cur_code"/>&nbsp;<xsl:value-of select="$originalDeal/fx_amt"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">original_rate</xsl:with-param>
							<xsl:with-param name="label">XSL_CONTRACT_FX_RATE_LABEL</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="$originalDeal/rate"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">original_counter_amt</xsl:with-param>
							<xsl:with-param name="label">XSL_CONTRACT_FX_SETTLEMENT_AMOUNT_LABEL</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="$originalDeal/counter_cur_code"/>&nbsp;<xsl:value-of select="$originalDeal/counter_amt"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">original_value_date</xsl:with-param>
							<xsl:with-param name="label">XSL_CONTRACT_FX_VALUE_DATE_LABEL</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="$originalDeal/value_date"/></xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				<!-- New deal -->
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_CONTRACT_FX_NEW_DEAL_LABEL</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">trade_id</xsl:with-param>
							<xsl:with-param name="label">XSL_CONTRACT_FX_TRADE_ID_LABEL</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="trade_id"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">amt</xsl:with-param>
							<xsl:with-param name="label">XSL_CONTRACT_FX_AMOUNT_LABEL</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="fx_cur_code"/>&nbsp;<xsl:value-of select="fx_amt"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">rate</xsl:with-param>
							<xsl:with-param name="label">XSL_CONTRACT_FX_RATE_LABEL</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="rate"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">counter_amt</xsl:with-param>
							<xsl:with-param name="label">XSL_CONTRACT_FX_SETTLEMENT_AMOUNT_LABEL</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="counter_cur_code"/>&nbsp;<xsl:value-of select="counter_amt"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">value_date</xsl:with-param>
							<xsl:with-param name="label">XSL_CONTRACT_FX_VALUE_DATE_LABEL</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="value_date"/></xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
  </xsl:template>
</xsl:stylesheet>