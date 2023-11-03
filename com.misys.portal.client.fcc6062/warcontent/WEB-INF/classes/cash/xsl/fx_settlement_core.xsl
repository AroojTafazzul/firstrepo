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
  xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
  xmlns:jetSpeedResources="xalan://com.misys.portal.core.util.JetspeedResources"
  exclude-result-prefixes="localization securityCheck jetSpeedResources">

   
  <!--
  ########################################################################
  #1 - COMMON SETTLMENT TEMPLATES FOR ALL SCREENS
  # 
  ########################################################################
  -->
 	 <xsl:variable name="swift_flag" select="defaultresource:getResource('OPICS_SWIFT_ENABLED')='true'"/>
    <xsl:template name="fx-settlement-details-section">
      <div class="widgetContainer">
    	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_SETTLEMENT_DETAILS</xsl:with-param>
		<xsl:with-param name="content">
			<xsl:choose>    
    	 <xsl:when test="not(settlement_mean) and not(settlement_account) and not(counterparty_name) and not(counterparty_address_line_1) and not(counterparty_address_line_2) and not(counterparty_dom) and not(counterparty_act_no) and not(counterparty_act_iso_code) and not(cpty_bank_name) and not(cpty_branch_name) and not(cpty_branch_address_line_1) and not(cpty_bank_dom) and not(cpty_bank_swift_bic_code) and not(cpty_benif_bank_routing_no) and not(cpty_order_cust_name) and not(cpty_order_cust_addr) and not(cpty_order_cust_addr_2) and not(cpty_order_cust_city) and not(cpty_order_cust_country)">
         <!-- nothing to display -->
    	 </xsl:when>
    	 <xsl:otherwise>
			<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="legend">XSL_HEADER_PAYMENT_BENEFICIARY_DETAILS</xsl:with-param>
				<xsl:with-param name="legend-type">indented-header</xsl:with-param>
				<xsl:with-param name="content">
					
					<xsl:if test="settlement_account">
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">smean</xsl:with-param>
							<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SETTLEMENT_MEANS</xsl:with-param>
							<xsl:with-param name="value" select="settlement_mean"/>
						</xsl:call-template>										 
	 					<xsl:call-template name="input-field">
							<xsl:with-param name="name">saccount</xsl:with-param>
							<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SETTLEMENT_ACCOUNTNUMBER</xsl:with-param>						
							<xsl:with-param name="value" select="settlement_account"/>
						</xsl:call-template>
					</xsl:if> 				
					 
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">bendetails</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SETTLEMENT_BENEFICIARY_DETAILS</xsl:with-param>
						<xsl:with-param name="value" select="counterparty_name"/>
						<!-- <xsl:with-param name="value" select="BENDETAILS"/> -->
					</xsl:call-template>	
					
	
		<xsl:choose>    
	    	 <xsl:when test="not(normalize-space(counterparty_address_line_1)) and not(normalize-space(counterparty_address_line_2)) and not(normalize-space(counterparty_dom))">
	         <!-- nothing to display -->
	    	 </xsl:when>
	    	 <xsl:otherwise>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">bendeaddress1</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SETTLEMENT_BENEFICIARY_ADDRESS</xsl:with-param>
						<!-- <xsl:with-param name="value" select="BENDETAILS"/>  -->
						<xsl:with-param name="value">
						<xsl:choose>
							<xsl:when test="normalize-space(counterparty_address_line_1) != ''"><xsl:value-of select="counterparty_address_line_1"/></xsl:when>
							<xsl:otherwise>&nbsp;<!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
						</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>					
	
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">bendeaddline2</xsl:with-param>
<!-- 						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SETTLEMENT_BENEFICIARY_CITY</xsl:with-param> -->
						<xsl:with-param name="value" select="counterparty_address_line_2"/> 
					</xsl:call-template>

					<xsl:call-template name="input-field">
						<xsl:with-param name="name">bendedom</xsl:with-param>
<!-- 						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SETTLEMENT_BENEFICIARY_COUNTRY</xsl:with-param> -->
						<xsl:with-param name="value" select="counterparty_dom"/> 
					</xsl:call-template>		
			</xsl:otherwise>			    	 
		</xsl:choose>								
		<xsl:choose>
				<xsl:when test="starts-with(counterparty_act_no, '/')">
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">beneficiaryAccount</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_BENEFICIARY_ACCOUNT</xsl:with-param>
						<xsl:with-param name="value" select="translate(counterparty_act_no, '/','')"/>
					</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">beneficiaryAccount</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_BENEFICIARY_ACCOUNT</xsl:with-param>
						<xsl:with-param name="value" select="counterparty_act_no"/>
					</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">beneficiaryAccountBic</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_BENEFICIARY_BIC_CODE_SWIFT</xsl:with-param>
						<xsl:with-param name="value" select="counterparty_act_iso_code"/>
					</xsl:call-template>									
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">awbank</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_BENEFICIARY_BANK_NAME</xsl:with-param>
						<xsl:with-param name="value" select="cpty_bank_name"/>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">awbankaddress2</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_BENEFICIARY_BANK_BRANCH</xsl:with-param>
						<xsl:with-param name="value" select="cpty_branch_name"/>
					</xsl:call-template>
		<xsl:choose>    
				<xsl:when test="not(normalize-space(cpty_branch_address_line_1)) and not(normalize-space(cpty_bank_dom))">
			    <!-- nothing to display -->
			    </xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">awbankbranchName</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_BENEFICIARY_BANK_ADRESS</xsl:with-param>
						<xsl:with-param name="value">
						<xsl:choose>
							<xsl:when test="normalize-space(cpty_branch_address_line_1) != ''"><xsl:value-of select="cpty_branch_address_line_1"/></xsl:when>
							<xsl:otherwise>&nbsp;<!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
						</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">awbankbranchadd3</xsl:with-param>
<!-- 						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_BENEFICIARY_BANK_CITY</xsl:with-param> -->
						<xsl:with-param name="value" select="cpty_bank_dom"/>
					</xsl:call-template>
				</xsl:otherwise>			    	 
		</xsl:choose>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">awbankbiccode</xsl:with-param>
						<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BIC</xsl:with-param>
						<!-- <xsl:with-param name="value" select="CPTY_BANK_SWIFT_BIC_CODE"/> -->
						<xsl:with-param name="value" select="cpty_bank_swift_bic_code"/>						
					</xsl:call-template>
		<xsl:choose>
				<xsl:when test="starts-with(cpty_benif_bank_routing_no, '/')">
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">awbankbankcode</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_BENEFICIARY_BANK_ACCOUNT</xsl:with-param>
						<xsl:with-param name="value" select="translate(cpty_benif_bank_routing_no, '/','')"/>
					</xsl:call-template>						
			</xsl:when>
			<xsl:otherwise>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">awbankbankcode</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_BENEFICIARY_BANK_ACCOUNT</xsl:with-param>
						<xsl:with-param name="value" select="cpty_benif_bank_routing_no"/>
					</xsl:call-template>	
			</xsl:otherwise>
		</xsl:choose>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">orderingCustomerName</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_ORDERING</xsl:with-param>
						<xsl:with-param name="value" select="cpty_order_cust_name"/>
					</xsl:call-template>				
		<xsl:choose>    
	    	 <xsl:when test="not(normalize-space(cpty_order_cust_addr)) and not(normalize-space(cpty_order_cust_addr_2)) and not(normalize-space(cpty_order_cust_city)) and not(normalize-space(cpty_order_cust_country))">
	         <!-- nothing to display -->
	    	 </xsl:when>
	    	 <xsl:otherwise>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">orderingCustomerAddress</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_ORDERING_ADDRESS</xsl:with-param>
						<xsl:with-param name="value">
						<xsl:choose>
							<xsl:when test="normalize-space(cpty_order_cust_addr) != ''"><xsl:value-of select="cpty_order_cust_addr"/></xsl:when>
							<xsl:otherwise>&nbsp;<!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
						</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="$swift_flag='true'">
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">orderingCustomerAddress2</xsl:with-param>
							<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_ORDERING_ADDRESS_2</xsl:with-param>
							<xsl:with-param name="value">
							<xsl:choose>
								<xsl:when test="normalize-space(cpty_order_cust_addr_2) != ''"><xsl:value-of select="cpty_order_cust_addr_2"/></xsl:when>
								<xsl:otherwise>&nbsp;<!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
							</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>							
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">orderingCustomerCity</xsl:with-param>
<!-- 						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_ORDERING_CITY</xsl:with-param> -->
						<xsl:with-param name="value" select="cpty_order_cust_city"/>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">orderingCustomerCountry</xsl:with-param>
<!-- 						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_ORDERING_COUNTRY</xsl:with-param> -->
						<xsl:with-param name="value" select="cpty_order_cust_country"/>
					</xsl:call-template>
			</xsl:otherwise>			    	 
		</xsl:choose>	
						<xsl:choose>
							<xsl:when test="cpty_swift_charges_paid[.='01' or .='02' or .='05']">
								<xsl:call-template name="input-field">
									<xsl:with-param name="name">swiftCharges</xsl:with-param>
									<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SWIFT_CHARGES</xsl:with-param>
									<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language,'N017',cpty_swift_charges_paid)"/></xsl:with-param>
								</xsl:call-template>							
							</xsl:when>
							<xsl:otherwise>
							</xsl:otherwise>
						</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
    	 </xsl:otherwise>
    	 </xsl:choose>
			<div>
<xsl:choose>    
    	 <xsl:when test="not(cpty_inter_bank_nam) and not(cpty_inter_bank_addr) and not(cpty_inter_city_state) and not(cpty_inter_country) and not(cpty_inter_swift_bic_code) and not(cpty_inter_routing_no) and not(cpty_special_routing_1) and not(cpty_special_routing_2) and not(cpty_special_routing_3) and not(cpty_special_routing_4) and not(cpty_special_routing_5) and not(cpty_special_routing_6)">      
<!-- nothing to display -->
    	 </xsl:when>
    	 <xsl:otherwise>
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_ADDITIONAL_DETAILS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">

					<xsl:call-template name="input-field">
						<xsl:with-param name="name">interBankName</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_INTERMEDIARY_BANK</xsl:with-param>
						<xsl:with-param name="value" select="cpty_inter_bank_name"/>
					</xsl:call-template>
		<xsl:choose>    
	    	 <xsl:when test="not(normalize-space(cpty_inter_bank_addr)) and not(normalize-space(cpty_inter_city_state)) and not(normalize-space(cpty_inter_country))">
	         <!-- nothing to display -->
	    	 </xsl:when>
	    	 <xsl:otherwise>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">interBankStreet</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_INTERMEDIARY_BANK_STREET</xsl:with-param>
						<xsl:with-param name="value">
						<xsl:choose>
							<xsl:when test="normalize-space(cpty_inter_bank_addr) != ''"><xsl:value-of select="cpty_inter_bank_addr"/></xsl:when>
							<xsl:otherwise>&nbsp;<!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
						</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>				
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">interBankCity</xsl:with-param>
<!-- 						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_INTERMEDIARY_BANK_CITY</xsl:with-param> -->
						<xsl:with-param name="value" select="cpty_inter_city_state"/>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">interBankCountry</xsl:with-param>
<!-- 						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_INTERMEDIARY_BANK_COUNTRY</xsl:with-param> -->
						<xsl:with-param name="value" select="cpty_inter_country"/>
					</xsl:call-template>
			</xsl:otherwise>			    	 
		</xsl:choose>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">interbankBicCode</xsl:with-param>
						<xsl:with-param name="label">XSL_SI_BANK_INSTRUCTIONS_INTERMEDIARY_BIC_CODE_SWIFT</xsl:with-param>
						<xsl:with-param name="value" select="cpty_inter_swift_bic_code"/> 
					</xsl:call-template>					
	     <xsl:choose>
				<xsl:when test="starts-with(cpty_inter_routing_no, '/')">
				<xsl:call-template name="input-field">
						<xsl:with-param name="name">interBankAccount</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_INTERMEDIARY_BANK_ACCOUNT</xsl:with-param>
						<!-- <xsl:with-param name="value" select="cpty_inter_bank_name"/> -->
						<xsl:with-param name="value" select="translate(cpty_inter_routing_no, '/','')"/>
					</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="input-field">
						<xsl:with-param name="name">interBankAccount</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_INTERMEDIARY_BANK_ACCOUNT</xsl:with-param>
						<!-- <xsl:with-param name="value" select="cpty_inter_bank_name"/> -->
						<xsl:with-param name="value" select="cpty_inter_routing_no"/>
					</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>						
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">r1</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SPECIAL_ROUTING_INSTR_1</xsl:with-param>
						<xsl:with-param name="value" select="cpty_special_routing_1"/>
					</xsl:call-template>													
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">r2</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SPECIAL_ROUTING_INSTR_2</xsl:with-param>
						<xsl:with-param name="value" select="cpty_special_routing_2"/>
					</xsl:call-template>																		
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">r3</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SPECIAL_ROUTING_INSTR_3</xsl:with-param>
						<xsl:with-param name="value" select="cpty_special_routing_3"/>
					</xsl:call-template>					
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">r4</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SPECIAL_ROUTING_INSTR_4</xsl:with-param>
						<xsl:with-param name="value" select="cpty_special_routing_4"/>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">r5</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SPECIAL_ROUTING_INSTR_5</xsl:with-param>
						<xsl:with-param name="value" select="cpty_special_routing_5"/>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">r6</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SPECIAL_ROUTING_INSTR_6</xsl:with-param>
						<xsl:with-param name="value" select="cpty_special_routing_6"/>
					</xsl:call-template>	

					</xsl:with-param>
				</xsl:call-template>
    	 </xsl:otherwise>  
    	 </xsl:choose>
			</div>
			<div>
			<xsl:choose>    
    	 <xsl:when test="not(cpty_payment_detail_1) and not(cpty_payment_detail_2) and not(cpty_payment_detail_3) and not(cpty_payment_detail_4)">      
         <!-- nothing to display -->
    	 </xsl:when>
    	 <xsl:otherwise>
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_SI_PAYMENT_DETAILS_TAB_LABEL</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
					
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_SI_ADDITIONAL_DETAILS_LINE_1</xsl:with-param>
							<xsl:with-param name="name">review_additional_detail_1</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<!-- <xsl:with-param name="value" select="PAYMENT_DETAIL_1"/> -->
							<xsl:with-param name="value" select="cpty_payment_detail_1"/>							
						</xsl:call-template>						
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_SI_ADDITIONAL_DETAILS_LINE_2</xsl:with-param>
							<xsl:with-param name="name">review_additional_detail_2</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value" select="cpty_payment_detail_2"/>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_SI_ADDITIONAL_DETAILS_LINE_3</xsl:with-param>
							<xsl:with-param name="name">review_additional_detail_3</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value" select="cpty_payment_detail_3"/>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_SI_ADDITIONAL_DETAILS_LINE_4</xsl:with-param>
							<xsl:with-param name="name">review_additional_detail_4</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value" select="cpty_payment_detail_4"/>
						</xsl:call-template>																
					</xsl:with-param>
				</xsl:call-template>
    	 </xsl:otherwise>
    	 </xsl:choose>
			</div>			
	</xsl:with-param>
	</xsl:call-template>
	</div>  
  </xsl:template>


<!-- Settlement details section by using counterparty object -->

 
    <xsl:template name="fx-settlement-details-countertparty">
      <div class="widgetContainer">
      <xsl:if test="count(counterparties/counterparty[counterparty_type='04']) = 0">
      	<xsl:attribute name="style">display:none;</xsl:attribute>
      </xsl:if>
    	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_SETTLEMENT_DETAILS</xsl:with-param>
		<xsl:with-param name="content">
			<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="legend">XSL_HEADER_PAYMENT_BENEFICIARY_DETAILS</xsl:with-param>
				<xsl:with-param name="legend-type">indented-header</xsl:with-param>
				<xsl:with-param name="content">
					
                        <xsl:choose>
							<xsl:when test="counterparties/counterparty[counterparty_type='04']/settlement_account">
                        <xsl:call-template name="input-field">
							<xsl:with-param name="name">smean</xsl:with-param>
							<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SETTLEMENT_MEANS</xsl:with-param>
							<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/settlement_mean"/>
						</xsl:call-template>										 
	 					<xsl:call-template name="input-field">
							<xsl:with-param name="name">saccount</xsl:with-param>
							<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SETTLEMENT_ACCOUNTNUMBER</xsl:with-param>						
							<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/settlement_account"/>
						</xsl:call-template>							
							</xsl:when>
							<xsl:otherwise>
					<xsl:if test="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/settlement_account">
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">smean</xsl:with-param>
							<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SETTLEMENT_MEANS</xsl:with-param>
							<xsl:with-param name="value" select="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/settlement_mean"/>
						</xsl:call-template>										 
	 					<xsl:call-template name="input-field">
							<xsl:with-param name="name">saccount</xsl:with-param>
							<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SETTLEMENT_ACCOUNTNUMBER</xsl:with-param>						
							<xsl:with-param name="value" select="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/settlement_account"/>
						</xsl:call-template>
					</xsl:if> 											
							</xsl:otherwise>
						</xsl:choose>
	<xsl:choose>
		<xsl:when
			test="normalize-space(counterparties/counterparty[counterparty_type='04']/counterparty_name) != ''">
                    <xsl:call-template name="input-field">
						<xsl:with-param name="name">bendetails</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SETTLEMENT_BENEFICIARY_DETAILS</xsl:with-param>
						<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/counterparty_name"/>
						<!-- <xsl:with-param name="value" select="BENDETAILS"/> -->
					</xsl:call-template>	
		</xsl:when>
		<xsl:when test="normalize-space(org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/counterparty_name) != ''">
                    <xsl:call-template name="input-field">
						<xsl:with-param name="name">bendetails</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SETTLEMENT_BENEFICIARY_DETAILS</xsl:with-param>
						<xsl:with-param name="value" select="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/counterparty_name"/>
						<!-- <xsl:with-param name="value" select="BENDETAILS"/> -->
					</xsl:call-template>	
		</xsl:when>
	</xsl:choose>
	<!-- artf1076027 This is a temporary fix until a more comprehensive strategic fix can be agreed -->										 
	<xsl:variable name="counter_address_line_1">
	<xsl:choose>
		<xsl:when test="counterparties/counterparty[counterparty_type='04']/counterparty_address_line_1">
			<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/counterparty_address_line_1"/>	
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/counterparty_address_line_1"/>
		</xsl:otherwise>
	</xsl:choose>
	</xsl:variable> 
	<xsl:variable name="counter_address_line_2">
	<xsl:choose>
		<xsl:when test="counterparties/counterparty[counterparty_type='04']/counterparty_address_line_2">
			<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/counterparty_address_line_2"/>	
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/counterparty_address_line_2"/>
		</xsl:otherwise>											 
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="counter_dom">
	<xsl:choose>
		<xsl:when test="counterparties/counterparty[counterparty_type='04']/counterparty_dom">
			<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/counterparty_dom"/>	
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/counterparty_dom"/>
		</xsl:otherwise>
	</xsl:choose>
	</xsl:variable>
	<xsl:choose>
    	 <xsl:when test="not(normalize-space($counter_address_line_1)) and not(normalize-space($counter_address_line_2)) and not(normalize-space($counter_dom))">
         <!-- nothing to display -->
		</xsl:when>
		<xsl:otherwise>
					<xsl:call-template name="input-field">
					<xsl:with-param name="name">bendeaddress1</xsl:with-param>
					<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_ADDRESS</xsl:with-param>
					<xsl:with-param name="value">
					<xsl:choose>
						<xsl:when test="normalize-space($counter_address_line_1) != ''"><xsl:value-of select="$counter_address_line_1"/></xsl:when>
						<xsl:otherwise>&nbsp;<!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
					</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="name">bendeaddline2</xsl:with-param>
			<!-- 						<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_CITY</xsl:with-param> -->
					<xsl:with-param name="value" select="$counter_address_line_2"/> 
				</xsl:call-template>
				<xsl:call-template name="input-field">
						<xsl:with-param name="name">bendedom</xsl:with-param>
			<!-- 						<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_COUNTRY</xsl:with-param> -->
					<xsl:with-param name="value" select="$counter_dom"/> 
					</xsl:call-template>		
		</xsl:otherwise>
	</xsl:choose>
	<xsl:choose>
		<xsl:when
			test="counterparties/counterparty[counterparty_type='04']/counterparty_act_no">
	    <xsl:choose>
				<xsl:when test="starts-with(counterparties/counterparty[counterparty_type='04']/counterparty_act_no, '/')">
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">beneficiaryAccount</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_BENEFICIARY_ACCOUNT</xsl:with-param>
						<xsl:with-param name="value" select="translate(counterparties/counterparty[counterparty_type='04']/counterparty_act_no, '/','')"/>
					</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
                    <xsl:call-template name="input-field">
						<xsl:with-param name="name">beneficiaryAccount</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_BENEFICIARY_ACCOUNT</xsl:with-param>
						<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/counterparty_act_no"/>
					</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
		</xsl:when>
		<xsl:otherwise>
        <xsl:choose>
				<xsl:when test="starts-with(org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/counterparty_act_no, '/')">
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">beneficiaryAccount</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_BENEFICIARY_ACCOUNT</xsl:with-param>
						<xsl:with-param name="value" select="translate(org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/counterparty_act_no, '/','')"/>
					</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
                    <xsl:call-template name="input-field">
						<xsl:with-param name="name">beneficiaryAccount</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_BENEFICIARY_ACCOUNT</xsl:with-param>
						<xsl:with-param name="value" select="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/counterparty_act_no"/>
					</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
		</xsl:otherwise>
	</xsl:choose>
	<xsl:choose>
		<xsl:when
			test="counterparties/counterparty[counterparty_type='04']/counterparty_act_iso_code">
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">beneficiaryAccountBic</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_BENEFICIARY_BIC_CODE_SWIFT</xsl:with-param>
						<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/counterparty_act_iso_code"/>
					</xsl:call-template>									
		</xsl:when>
		<xsl:otherwise>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">beneficiaryAccountBic</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_BENEFICIARY_BIC_CODE_SWIFT</xsl:with-param>
						<xsl:with-param name="value" select="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/counterparty_act_iso_code"/>
					</xsl:call-template>									
		</xsl:otherwise>
	</xsl:choose>
	<xsl:choose>
		<xsl:when
			test="counterparties/counterparty[counterparty_type='04']/cpty_branch_name">
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">awbank</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_BENEFICIARY_BANK_NAME</xsl:with-param>
						<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_bank_name"/>
					</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">awbank</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_BENEFICIARY_BANK_NAME</xsl:with-param>
						<xsl:with-param name="value" select="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_bank_name"/>
					</xsl:call-template>
		</xsl:otherwise>
	</xsl:choose>					
	<xsl:choose>
		<xsl:when
			test="counterparties/counterparty[counterparty_type='04']/settlement_account">
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">awbankaddress2</xsl:with-param>
						<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BANK_BRANCH</xsl:with-param>
						<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_branch_name"/>
					</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">awbankaddress2</xsl:with-param>
						<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BANK_BRANCH</xsl:with-param>
						<xsl:with-param name="value" select="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_branch_name"/>
					</xsl:call-template>
		</xsl:otherwise>
	</xsl:choose>										 
	<!-- artf1076027 This is a temporary fix until a more comprehensive strategic fix can be agreed -->										 
	<xsl:variable name="address_line_1">
	<xsl:choose>
		<xsl:when test="counterparties/counterparty[counterparty_type='04']/cpty_branch_address_line_1">
			<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_branch_address_line_1"/>	
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_branch_address_line_1"/>
		</xsl:otherwise>
	</xsl:choose>										 
	</xsl:variable>
	<xsl:variable name="address_line_2">
	<xsl:choose>
		<xsl:when test="counterparties/counterparty[counterparty_type='04']/cpty_branch_address_line_2">
			<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_branch_address_line_2"/>	
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_branch_address_line_2"/>
		</xsl:otherwise>											 
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="bank_country">
	<xsl:choose>
		<xsl:when test="counterparties/counterparty[counterparty_type='04']/cpty_bank_country">
			<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_bank_country"/>	
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_bank_country"/>
		</xsl:otherwise>
	</xsl:choose>										 
	</xsl:variable>
		<xsl:choose>    
	    	 <xsl:when test="not(normalize-space($address_line_1)) and not(normalize-space($address_line_1)) and not(normalize-space($address_line_2))">
	         <!-- nothing to display -->
		</xsl:when>
		<xsl:otherwise>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">awbankbranchName</xsl:with-param>
						<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BANK_ADRESS</xsl:with-param>
						<xsl:with-param name="value">
						<xsl:choose>
							<xsl:when test="normalize-space($address_line_1) != ''"><xsl:value-of select="$address_line_1"/></xsl:when>
							<xsl:otherwise>&nbsp;<!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
						</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>	
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">cptybranchaddressline2</xsl:with-param>
			<!-- 						<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BANK_CITY</xsl:with-param> -->
						<xsl:with-param name="value" select="$address_line_2"/>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">cptybankcountry</xsl:with-param>
			<!-- 						<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BANK_COUNTRY</xsl:with-param> -->
						<xsl:with-param name="value" select="$bank_country"/>
					</xsl:call-template>
		</xsl:otherwise>
	</xsl:choose>										 						
	<xsl:choose>
		<xsl:when
			test="counterparties/counterparty[counterparty_type='04']/cpty_bank_swift_bic_code">
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">awbankbiccode</xsl:with-param>
						<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BIC</xsl:with-param>
						<!-- <xsl:with-param name="value" select="CPTY_BANK_SWIFT_BIC_CODE"/> -->
						<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_bank_swift_bic_code"/>						
					</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">awbankbiccode</xsl:with-param>
						<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BIC</xsl:with-param>
						<!-- <xsl:with-param name="value" select="CPTY_BANK_SWIFT_BIC_CODE"/> -->
						<xsl:with-param name="value" select="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_bank_swift_bic_code"/>						
					</xsl:call-template>
		</xsl:otherwise>
	</xsl:choose>										
	<xsl:choose>
		<xsl:when
			test="counterparties/counterparty[counterparty_type='04']/cpty_benif_bank_routing_no">
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">awbankbankcode</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_BENEFICIARY_BANK_ACCOUNT</xsl:with-param>
						<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_benif_bank_routing_no"/>
					</xsl:call-template>	
		</xsl:when>
		<xsl:otherwise>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">awbankbankcode</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_BENEFICIARY_BANK_ACCOUNT</xsl:with-param>
						<xsl:with-param name="value" select="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_benif_bank_routing_no"/>
					</xsl:call-template>	
		</xsl:otherwise>
	</xsl:choose>										
	<xsl:choose>
		<xsl:when
			test="counterparties/counterparty[counterparty_type='04']/cpty_order_cust_name">
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">orderingCustomerName</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_ORDERING</xsl:with-param>
						<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_order_cust_name"/>
					</xsl:call-template>				
		</xsl:when>
		<xsl:otherwise>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">orderingCustomerName</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_ORDERING</xsl:with-param>
						<xsl:with-param name="value" select="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_order_cust_name"/>
					</xsl:call-template>				
		</xsl:otherwise>
	</xsl:choose>					
	<!-- artf1076027 This is a temporary fix until a more comprehensive strategic fix can be agreed -->										 
	<xsl:variable name="order_cust_addr">
	<xsl:choose>
		<xsl:when test="counterparties/counterparty[counterparty_type='04']/cpty_order_cust_addr">
			<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_order_cust_addr"/>	
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_order_cust_addr"/>
		</xsl:otherwise>											 
	</xsl:choose>
	</xsl:variable>
	 
	<xsl:variable name="order_cust_addr_2">
	<xsl:choose>
		<xsl:when test="counterparties/counterparty[counterparty_type='04']/cpty_order_cust_addr_2">
			<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_order_cust_addr_2"/>	
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_order_cust_addr_2"/>
		</xsl:otherwise>											 
	</xsl:choose>
	</xsl:variable> 
	<xsl:variable name="order_cust_city">
	<xsl:choose>
		<xsl:when test="counterparties/counterparty[counterparty_type='04']/cpty_order_cust_city">
			<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_order_cust_city"/>	
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_order_cust_city"/>
		</xsl:otherwise>											 
	</xsl:choose>
	</xsl:variable>
	<xsl:variable name="order_cust_country">
	<xsl:choose>
		<xsl:when test="counterparties/counterparty[counterparty_type='04']/cpty_order_cust_country">
			<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_order_cust_country"/>	
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_order_cust_country"/>
		</xsl:otherwise>											 
	</xsl:choose>
	</xsl:variable>
	<xsl:choose>    
    	 <xsl:when test="not(normalize-space($order_cust_addr)) and not(normalize-space($order_cust_city)) and not(normalize-space($order_cust_country))">
         <!-- nothing to display -->
    	 </xsl:when>
    	 <xsl:otherwise>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">orderingCustomerAddress</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_ORDERING_ADDRESS</xsl:with-param>
					<xsl:with-param name="value">
					<xsl:choose>
						<xsl:when test="normalize-space($order_cust_addr) != ''"><xsl:value-of select="$order_cust_addr"/></xsl:when>
						<xsl:otherwise>&nbsp;<!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
					</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="$swift_flag='true'">				
					<xsl:call-template name="input-field">
							<xsl:with-param name="name">orderingCustomerAddress2</xsl:with-param>
							<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_ORDERING_ADDRESS_2</xsl:with-param>
						<xsl:with-param name="value">
						<xsl:choose>
							<xsl:when test="normalize-space($order_cust_addr_2) != ''"><xsl:value-of select="$order_cust_addr_2"/></xsl:when>
							<xsl:otherwise>&nbsp;<!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
						</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">orderingCustomerCity</xsl:with-param>
<!-- 						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_ORDERING_CITY</xsl:with-param> -->
					<xsl:with-param name="value" select="$order_cust_city"/>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">orderingCustomerCountry</xsl:with-param>
<!-- 						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_ORDERING_COUNTRY</xsl:with-param> -->
						<xsl:with-param name="value" select="$order_cust_country"/>
					</xsl:call-template>
		</xsl:otherwise>
	</xsl:choose>					
	<xsl:choose>
		<xsl:when
			test="counterparties/counterparty[counterparty_type='04']/cpty_order_cust_country">
						<xsl:choose>
							<xsl:when test="counterparties/counterparty[counterparty_type='04']/cpty_swift_charges_paid[.='01' or .='02']">
								<xsl:call-template name="input-field">
									<xsl:with-param name="name">swiftCharges</xsl:with-param>
									<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SWIFT_CHARGES</xsl:with-param>
									
									<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N017', counterparties/counterparty[counterparty_type='04']/cpty_swift_charges_paid)"/></xsl:with-param>
								</xsl:call-template>								
							</xsl:when>
							<xsl:when test="counterparties/counterparty[counterparty_type='04']/cpty_swift_charges_paid[.='05']">
								<xsl:variable name="SSIShareOption"><xsl:value-of select="jetSpeedResources:getBoolean('FX.enable.SSI.ShareOption')"/></xsl:variable>
								<xsl:if test="$SSIShareOption = 'true'">				
							
								<xsl:call-template name="input-field">
									<xsl:with-param name="name">swiftCharges</xsl:with-param>
									<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SWIFT_CHARGES</xsl:with-param>
									<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N017', counterparties/counterparty[counterparty_type='04']/cpty_swift_charges_paid)"/></xsl:with-param>
								</xsl:call-template>	
								</xsl:if>						
							</xsl:when>
							<xsl:otherwise>
							</xsl:otherwise>
						</xsl:choose>
		</xsl:when>
		<xsl:otherwise>
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">orderingCustomerCountry</xsl:with-param>
						<xsl:with-param name="label"></xsl:with-param>
						<xsl:with-param name="value" select="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_order_cust_country"/>
					</xsl:call-template>
						<xsl:choose>
							<xsl:when test="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_swift_charges_paid[.='01' or .='02' or .='05']">
								<xsl:call-template name="input-field">
									<xsl:with-param name="name">swiftCharges</xsl:with-param>
									<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SWIFT_CHARGES</xsl:with-param>
									
									<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N017', org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_swift_charges_paid)"/></xsl:with-param>
								</xsl:call-template>								
							</xsl:when>
							<xsl:otherwise>
							</xsl:otherwise>
						</xsl:choose>
		</xsl:otherwise>
	</xsl:choose>					
				
<!-- 					<xsl:call-template name="input-field">
						<xsl:with-param name="name">bencountry</xsl:with-param>
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SETTLEMENT_BENEFICIARY_COUNTRY</xsl:with-param>
						<xsl:with-param name="value" select="COUNTERPARTY_COUNTRY"/> 
					</xsl:call-template> -->			
				</xsl:with-param>
			</xsl:call-template>
			<div>
		<xsl:choose>
		<xsl:when
			test="counterparties/counterparty[counterparty_type='04']/counterparty_id">
       <xsl:if test="(counterparties/counterparty[counterparty_type='04']/cpty_inter_swift_bic_code[.!='']) 
		or (counterparties/counterparty[counterparty_type='04']/cpty_inter_bank_name[.!=''])
	 	or (counterparties/counterparty[counterparty_type='04']/cpty_inter_bank_addr[.!=''])
	 	or (counterparties/counterparty[counterparty_type='04']/cpty_inter_city_state[.!=''])
	 	or (counterparties/counterparty[counterparty_type='04']/cpty_inter_country[.!=''])
	 	or starts-with(counterparties/counterparty[counterparty_type='04']/cpty_inter_routing_no, '/')
	 	or (counterparties/counterparty[counterparty_type='04']/cpty_inter_routing_no[.!=''])
	 	or (counterparties/counterparty[counterparty_type='04']/cpty_special_routing_1[.!=''])
	 	or (counterparties/counterparty[counterparty_type='04']/cpty_special_routing_2[.!=''])
	 	or (counterparties/counterparty[counterparty_type='04']/cpty_special_routing_3[.!=''])
	 	or (counterparties/counterparty[counterparty_type='04']/cpty_special_routing_4[.!=''])
	 	or (counterparties/counterparty[counterparty_type='04']/cpty_special_routing_5[.!=''])
	 	or (counterparties/counterparty[counterparty_type='04']/cpty_special_routing_6[.!=''])">			
					<xsl:call-template name="fieldset-wrapper">
						<xsl:with-param name="legend">XSL_HEADER_ADDITIONAL_DETAILS</xsl:with-param>
						<xsl:with-param name="legend-type">indented-header</xsl:with-param>
						<xsl:with-param name="content">
	
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">interBankName</xsl:with-param>
							<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_INTERMEDIARY_BANK</xsl:with-param>
							<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_inter_bank_name"/>
						</xsl:call-template>
						<!-- artf1076027 This is a temporary fix until a more comprehensive strategic fix can be agreed -->
						<xsl:variable name="inter_bank_addr"><xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_inter_bank_addr"/></xsl:variable>			

		<xsl:choose>    
	    	 <xsl:when test="not(normalize-space($inter_bank_addr)) and not(normalize-space(counterparties/counterparty[counterparty_type='04']/cpty_inter_city_state)) and not(normalize-space(counterparties/counterparty[counterparty_type='04']/cpty_inter_country))">
	         <!-- nothing to display -->
	    	 </xsl:when>
	    	 <xsl:otherwise>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">interBankStreet</xsl:with-param>
							<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK_STREET</xsl:with-param>
							<xsl:with-param name="value">
							<xsl:choose>
								<xsl:when test="normalize-space($inter_bank_addr) != ''"><xsl:value-of select="$inter_bank_addr"/></xsl:when>
								<xsl:otherwise>&nbsp;<!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
							</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>				
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">interBankCity</xsl:with-param>
<!-- 							<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK_CITY</xsl:with-param> -->
							<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_inter_city_state"/>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">interBankCountry</xsl:with-param>
<!-- 							<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK_COUNTRY</xsl:with-param> -->
							<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_inter_country"/>
						</xsl:call-template>
			</xsl:otherwise>			    	 
		</xsl:choose>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">interbankBicCode</xsl:with-param>
							<xsl:with-param name="label">XSL_SI_BANK_INSTRUCTIONS_INTERMEDIARY_BIC_CODE_SWIFT</xsl:with-param>
							<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_inter_swift_bic_code"/> 
						</xsl:call-template>
					     <xsl:choose>
								<xsl:when test="starts-with(counterparties/counterparty[counterparty_type='04']/cpty_inter_routing_no, '/')">
									<xsl:call-template name="input-field">
										<xsl:with-param name="name">interBankAccount</xsl:with-param>
										<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_INTERMEDIARY_BANK_ACCOUNT</xsl:with-param>
										<xsl:with-param name="value" select="translate(counterparties/counterparty[counterparty_type='04']/cpty_inter_routing_no, '/','')"/>
									</xsl:call-template>											
							</xsl:when>
							<xsl:otherwise>
									<xsl:call-template name="input-field">
										<xsl:with-param name="name">interBankAccount</xsl:with-param>
										<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_INTERMEDIARY_BANK_ACCOUNT</xsl:with-param>
										<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_inter_routing_no"/>
									</xsl:call-template>											
							</xsl:otherwise>
						</xsl:choose>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">r1</xsl:with-param>
							<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SPECIAL_ROUTING_INSTR_1</xsl:with-param>
							<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_special_routing_1"/>
						</xsl:call-template>													
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">r2</xsl:with-param>
							<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SPECIAL_ROUTING_INSTR_2</xsl:with-param>
							<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_special_routing_2"/>
						</xsl:call-template>																		
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">r3</xsl:with-param>
							<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SPECIAL_ROUTING_INSTR_3</xsl:with-param>
							<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_special_routing_3"/>
						</xsl:call-template>					
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">r4</xsl:with-param>
							<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SPECIAL_ROUTING_INSTR_4</xsl:with-param>
							<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_special_routing_4"/>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">r5</xsl:with-param>
							<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SPECIAL_ROUTING_INSTR_5</xsl:with-param>
							<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_special_routing_5"/>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">r6</xsl:with-param>
							<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SPECIAL_ROUTING_INSTR_6</xsl:with-param>
							<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_special_routing_6"/>
						</xsl:call-template>	
						</xsl:with-param>
					</xsl:call-template>
	    	 </xsl:if>	
		</xsl:when>
		<xsl:otherwise>
        <xsl:choose>    
	    	 <xsl:when test="not(org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_inter_bank_name) and not(org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_inter_bank_addr) and not(org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_inter_city_state) and not(org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_inter_country) and not(org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_inter_swift_bic_code) and not(org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_inter_routing_no) and not(org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_special_routing_1) and not(org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_special_routing_2) and not(org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_special_routing_3) and not(org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_special_routing_4) and not(org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_special_routing_5) and not(org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_special_routing_6)">      
	               <!-- nothing to display -->
	    	 </xsl:when>
	    	 <xsl:otherwise>			
					<xsl:call-template name="fieldset-wrapper">
						<xsl:with-param name="legend">XSL_HEADER_ADDITIONAL_DETAILS</xsl:with-param>
						<xsl:with-param name="legend-type">indented-header</xsl:with-param>
						<xsl:with-param name="content">
	
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">interBankName</xsl:with-param>
							<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_INTERMEDIARY_BANK</xsl:with-param>
							<xsl:with-param name="value" select="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_inter_bank_name"/>
						</xsl:call-template>
						<xsl:variable name="inter_bank_addr"><xsl:value-of select="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_inter_bank_addr"/></xsl:variable>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">interBankStreet</xsl:with-param>
							<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_INTERMEDIARY_BANK_STREET</xsl:with-param>
							<xsl:with-param name="value">
							<xsl:choose>
								<xsl:when test="normalize-space($inter_bank_addr) != ''"><xsl:value-of select="$inter_bank_addr"/></xsl:when>
								<xsl:otherwise>&nbsp;<!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
							</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>				
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">interBankCity</xsl:with-param>
<!-- 							<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_INTERMEDIARY_BANK_CITY</xsl:with-param> -->
							<xsl:with-param name="value" select="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_inter_city_state"/>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">interBankCountry</xsl:with-param>
<!-- 							<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_INTERMEDIARY_BANK_COUNTRY</xsl:with-param> -->
							<xsl:with-param name="value" select="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_inter_country"/>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">interbankBicCode</xsl:with-param>
							<xsl:with-param name="label">XSL_SI_BANK_INSTRUCTIONS_INTERMEDIARY_BIC_CODE_SWIFT</xsl:with-param>
							<xsl:with-param name="value" select="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_inter_swift_bic_code"/> 
						</xsl:call-template>
					     <xsl:choose>
								<xsl:when test="starts-with(org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_inter_routing_no, '/')">
									<xsl:call-template name="input-field">
										<xsl:with-param name="name">interBankAccount</xsl:with-param>
										<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_INTERMEDIARY_BANK_ACCOUNT</xsl:with-param>
										<xsl:with-param name="value" select="translate(org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_inter_routing_no, '/','')"/>
									</xsl:call-template>											
							</xsl:when>
							<xsl:otherwise>
									<xsl:call-template name="input-field">
										<xsl:with-param name="name">interBankAccount</xsl:with-param>
										<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_INTERMEDIARY_BANK_ACCOUNT</xsl:with-param>
										<xsl:with-param name="value" select="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_inter_routing_no"/>
									</xsl:call-template>											
							</xsl:otherwise>
						</xsl:choose>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">r1</xsl:with-param>
							<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SPECIAL_ROUTING_INSTR_1</xsl:with-param>
							<xsl:with-param name="value" select="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_special_routing_1"/>
						</xsl:call-template>													
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">r2</xsl:with-param>
							<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SPECIAL_ROUTING_INSTR_2</xsl:with-param>
							<xsl:with-param name="value" select="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_special_routing_2"/>
						</xsl:call-template>																		
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">r3</xsl:with-param>
							<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SPECIAL_ROUTING_INSTR_3</xsl:with-param>
							<xsl:with-param name="value" select="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_special_routing_3"/>
						</xsl:call-template>					
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">r4</xsl:with-param>
							<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SPECIAL_ROUTING_INSTR_4</xsl:with-param>
							<xsl:with-param name="value" select="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_special_routing_4"/>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">r5</xsl:with-param>
							<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SPECIAL_ROUTING_INSTR_5</xsl:with-param>
							<xsl:with-param name="value" select="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_special_routing_5"/>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">r6</xsl:with-param>
							<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SPECIAL_ROUTING_INSTR_6</xsl:with-param>
							<xsl:with-param name="value" select="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_special_routing_6"/>
						</xsl:call-template>	
						</xsl:with-param>
					</xsl:call-template>
	    	 </xsl:otherwise>  
    	 </xsl:choose>	
		</xsl:otherwise>
 	    </xsl:choose>
			</div>
			<div>
		<xsl:choose>
		<xsl:when test="counterparties/counterparty[counterparty_type='04']/counterparty_id">
        	 <xsl:if test="(counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_1[.!='']) or (counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_2[.!='']) or (counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_3[.!='']) or (counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_4[.!=''])">     
					<xsl:call-template name="fieldset-wrapper">
						<xsl:with-param name="legend">XSL_SI_PAYMENT_DETAILS_TAB_LABEL</xsl:with-param>
						<xsl:with-param name="legend-type">indented-header</xsl:with-param>
						<xsl:with-param name="content">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_SI_ADDITIONAL_DETAILS_LINE_1</xsl:with-param>
								<xsl:with-param name="name">review_additional_detail_1</xsl:with-param>
								<xsl:with-param name="override-displaymode">view</xsl:with-param>
								<!-- <xsl:with-param name="value" select="PAYMENT_DETAIL_1"/> -->
								<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_1"/>							
							</xsl:call-template>						
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_SI_ADDITIONAL_DETAILS_LINE_2</xsl:with-param>
								<xsl:with-param name="name">review_additional_detail_2</xsl:with-param>
								<xsl:with-param name="override-displaymode">view</xsl:with-param>
								<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_2"/>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_SI_ADDITIONAL_DETAILS_LINE_3</xsl:with-param>
								<xsl:with-param name="name">review_additional_detail_3</xsl:with-param>
								<xsl:with-param name="override-displaymode">view</xsl:with-param>
								<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_3"/>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_SI_ADDITIONAL_DETAILS_LINE_4</xsl:with-param>
								<xsl:with-param name="name">review_additional_detail_4</xsl:with-param>
								<xsl:with-param name="override-displaymode">view</xsl:with-param>
								<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_4"/>
							</xsl:call-template>																
						</xsl:with-param>
					</xsl:call-template>
			</xsl:if>
		</xsl:when>
		<xsl:otherwise>
        <xsl:choose>    
    	 <xsl:when test="not(org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_1) or not(org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_2) or not(org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_3) or not(org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_4)">      
               <!-- nothing to display -->
    	 </xsl:when>
    	 <xsl:otherwise>	
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_SI_PAYMENT_DETAILS_TAB_LABEL</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_SI_ADDITIONAL_DETAILS_LINE_1</xsl:with-param>
							<xsl:with-param name="name">review_additional_detail_1</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<!-- <xsl:with-param name="value" select="PAYMENT_DETAIL_1"/> -->
							<xsl:with-param name="value" select="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_1"/>							
						</xsl:call-template>						
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_SI_ADDITIONAL_DETAILS_LINE_2</xsl:with-param>
							<xsl:with-param name="name">review_additional_detail_2</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value" select="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_2"/>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_SI_ADDITIONAL_DETAILS_LINE_3</xsl:with-param>
							<xsl:with-param name="name">review_additional_detail_3</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value" select="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_3"/>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_SI_ADDITIONAL_DETAILS_LINE_4</xsl:with-param>
							<xsl:with-param name="name">review_additional_detail_4</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
							<xsl:with-param name="value" select="org_previous_file/fx_tnx_record/counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_4"/>
						</xsl:call-template>																
					</xsl:with-param>
				</xsl:call-template>
    	 </xsl:otherwise>  
    	 </xsl:choose>	
		</xsl:otherwise>
 	    </xsl:choose>
			</div>			
	</xsl:with-param>
	</xsl:call-template>
	</div>  
  </xsl:template>


<!-- End of Settlement details section by using counterparty object  -->

</xsl:stylesheet>