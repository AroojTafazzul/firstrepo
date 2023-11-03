<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		exclude-result-prefixes="defaultresource">
<!--
   Copyright (c) 2000-2012 Misys,
   All Rights Reserved. 
   
   This stylesheet regroups common templates for product/incoming saving stylesheets
-->
	
	<!-- bank instructions -->
	<xsl:template name="free-format">
		<xsl:param name="prefix"/>
		<xsl:param name="product_type"/>
		<xsl:param name="countryText">N</xsl:param>
					
				<xsl:variable name="prefix_name">
					<xsl:choose>
						<xsl:when test="$prefix">
							<xsl:value-of select="concat($prefix,'_')"/>
						</xsl:when>
						<xsl:otherwise></xsl:otherwise>
					</xsl:choose>
				</xsl:variable>

				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:if test="brch_code"> 
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>

				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'settlement_account'))]">
					<settlement_account>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'settlement_account'))]"/>
					</settlement_account>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'settlement_mean'))]">
					<settlement_mean>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'settlement_mean'))]"/>
					</settlement_mean>
				</xsl:if>

				<!--  Begin of : Beneficiary  -->
				<!-- Whenever 'near' or 'far' payment of treasury module is implemented, handle the '$prefix_name' accordingly -->
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'beneficiary_iso_code'))]"> 
					<counterparty_act_iso_code>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'beneficiary_iso_code'))]"/>
					</counterparty_act_iso_code>
				</xsl:if>			
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'beneficiary_account'))]">
					<counterparty_act_no>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'beneficiary_account'))]"/>
					</counterparty_act_no>
				</xsl:if>	
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'beneficiary_name'))]">
					<counterparty_name>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'beneficiary_name'))]"/>
					</counterparty_name>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'beneficiary_address'))]">
					<counterparty_address_line_1>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'beneficiary_address'))]"/>
					</counterparty_address_line_1>
				</xsl:if>
				 <xsl:if test="//*[starts-with(name(), concat($prefix_name,'beneficiary_address_2'))]">
					<counterparty_address_line_2>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'beneficiary_address_2'))]"/>
					</counterparty_address_line_2>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'beneficiary_city'))]">
					<counterparty_dom>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'beneficiary_city'))]"/>
					</counterparty_dom>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bene_details_clrc'))]">
					<cpty_bene_details_clrc>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bene_details_clrc'))]" />
					</cpty_bene_details_clrc>
				</xsl:if>
				
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'beneficiary_country'))]">
					<counterparty_country>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'beneficiary_country'))]" />
					</counterparty_country>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="//*[starts-with(name(), concat($prefix_name,'payment_amt'))]">
						<counterparty_amt>
							<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'payment_amt'))]"/>
						</counterparty_amt>
					</xsl:when>
					<xsl:when test="//*[starts-with(name(), concat($prefix_name,'credit_amt'))]">
						<counterparty_amt>
							<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'credit_amt'))]"/>
						</counterparty_amt>
					</xsl:when>
				</xsl:choose>											
				<xsl:choose>
					<xsl:when test="//*[starts-with(name(), concat($prefix_name,'fx_cur_code'))]">
						<counterparty_cur_code>
							<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'fx_cur_code'))]"/>
						</counterparty_cur_code>
					</xsl:when>
					<xsl:when test="payment_cur_code and sub_product_code [.= 'TRTPT']">
						<counterparty_cur_code>
							<xsl:value-of select="payment_cur_code"/>
						</counterparty_cur_code>
					</xsl:when>
					<xsl:when test="//*[starts-with(name(), concat($prefix_name,'td_cur_code'))]">
						<counterparty_cur_code>
							<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'td_cur_code'))]"/>
						</counterparty_cur_code>
					</xsl:when>
				</xsl:choose>
				<!-- insert counterparty_iss_date -->
				<!-- insert counterparty_label -->
				<!-- End of : Beneficiary Section -->

				<!-- Begin of : Beneficiary Bank -->
				<xsl:if test="//*[substring(name(), string-length(name()) - (string-length(concat($prefix_name,'beneficiary_bank'))+1)) = concat($prefix_name,'beneficiary_bank')]">
					<cpty_bank_name>
						<xsl:value-of select="//*[substring(name(), string-length(name()) - (string-length(concat($prefix_name,'beneficiary_bank'))+1)) = concat($prefix_name,'beneficiary_bank')]"/>
					</cpty_bank_name>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'beneficiary_bank_branch'))]">
					<cpty_branch_name>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'beneficiary_bank_branch'))]"/>
					</cpty_branch_name>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'beneficiary_bank_address'))]">
					<cpty_branch_address_line_1>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'beneficiary_bank_address'))]"/>
					</cpty_branch_address_line_1>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'beneficiary_bank_address_2'))]">
					<cpty_branch_address_line_2>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'beneficiary_bank_address_2'))]"/>
					</cpty_branch_address_line_2>
				</xsl:if>	
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'beneficiary_bank_city'))]">
					<cpty_bank_dom>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'beneficiary_bank_city'))]"/>
					</cpty_bank_dom>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'beneficiary_bank_clrc'))]">
					<cpty_beneficiary_bank_clrc>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'beneficiary_bank_clrc'))]" />
					</cpty_beneficiary_bank_clrc>
				</xsl:if>				
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'beneficiary_bank_bic'))]">
					<cpty_bank_swift_bic_code>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'beneficiary_bank_bic'))]"/>
					</cpty_bank_swift_bic_code>	
				</xsl:if>
							
				
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'beneficiary_bank_country'))]">
					<cpty_bank_country>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'beneficiary_bank_country'))]" />
					</cpty_bank_country>
				</xsl:if>			
								
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'cpty_account_institution'))]">
					<cpty_account_institution>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'cpty_account_institution'))]"/>
					</cpty_account_institution>
				</xsl:if>				

				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'beneficiary_bank_routing_number'))]">
					<cpty_benif_bank_routing_no>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'beneficiary_bank_routing_number'))]"/>
					</cpty_benif_bank_routing_no>
				</xsl:if>
				<!--  End of : Beneficiary Bank Section -->
								
				<!-- Begin of : Intermediate Bank Section -->
				<xsl:if test="//*[substring(name(), string-length(name()) - (string-length(concat($prefix_name,'intermediary_bank'))+1)) = concat($prefix_name,'intermediary_bank')]">
					<cpty_inter_bank_name>
						<xsl:value-of select="//*[substring(name(), string-length(name()) - (string-length(concat($prefix_name,'intermediary_bank'))+1)) = concat($prefix_name,'intermediary_bank')]"/>
					</cpty_inter_bank_name>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'intermediary_bank_street'))]">
					<cpty_inter_bank_addr>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'intermediary_bank_street'))]"/>
					</cpty_inter_bank_addr>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'intermediary_bank_street_2'))]">
					<cpty_inter_bank_addr_2>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'intermediary_bank_street_2'))]"/>
					</cpty_inter_bank_addr_2>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'intermediary_bank_city'))]">
					<cpty_inter_city_state>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'intermediary_bank_city'))]"/>
					</cpty_inter_city_state>
				</xsl:if>	
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'inter_bank_clrc'))]">
					<cpty_inter_bank_clrc>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'inter_bank_clrc'))]"/>
					</cpty_inter_bank_clrc>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'intermediary_bank_aba'))]"> <!-- intermediary_aba  -->
					<cpty_inter_routing_no>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'intermediary_bank_aba'))]"/>
					</cpty_inter_routing_no>
				</xsl:if>		
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'intermediary_bank_country'))]">
					<cpty_inter_country>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'intermediary_bank_country'))]"/>
					</cpty_inter_country>
				</xsl:if>
									
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'intermediary_bank_bic'))]"> <!-- intermediary_bank_aba -->
					<cpty_inter_swift_bic_code>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'intermediary_bank_bic'))]"/>
					</cpty_inter_swift_bic_code>
				</xsl:if>
				<!-- End of : Intermediate Bank Section -->

				<!-- counterparty special routing instruction -->
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'intermediary_bank_instruction_1'))]">
					<cpty_special_routing_1>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'intermediary_bank_instruction_1'))]"/>
					</cpty_special_routing_1>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'intermediary_bank_instruction_2'))]">
					<cpty_special_routing_2>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'intermediary_bank_instruction_2'))]"/>
					</cpty_special_routing_2>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'intermediary_bank_instruction_3'))]">
					<cpty_special_routing_3>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'intermediary_bank_instruction_3'))]"/>
					</cpty_special_routing_3>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'intermediary_bank_instruction_4'))]">
					<cpty_special_routing_4>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'intermediary_bank_instruction_4'))]"/>
					</cpty_special_routing_4>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'intermediary_bank_instruction_5'))]">
					<cpty_special_routing_5>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'intermediary_bank_instruction_5'))]"/>
					</cpty_special_routing_5>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'intermediary_bank_instruction_6'))]">
					<cpty_special_routing_6>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'intermediary_bank_instruction_6'))]"/>
					</cpty_special_routing_6>
				</xsl:if>
				<!-- end -->		
				
				<!-- counterparty payment section -->
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'free_additional_details_line_1_input'))]">
					<cpty_payment_detail_1>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'free_additional_details_line_1_input'))]"/>
					</cpty_payment_detail_1>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'free_additional_details_line_2_input'))]">
					<cpty_payment_detail_2>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'free_additional_details_line_2_input'))]"/>
					</cpty_payment_detail_2>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'free_additional_details_line_3_input'))]">
					<cpty_payment_detail_3>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'free_additional_details_line_3_input'))]"/>
					</cpty_payment_detail_3>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'free_additional_details_line_4_input'))]">
					<cpty_payment_detail_4>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'free_additional_details_line_4_input'))]"/>
					</cpty_payment_detail_4>
				</xsl:if>
				<!-- end -->				
				
				<!-- counterparty ordering customer section -->
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'ordering_cust_name'))]">
					<cpty_order_cust_name>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'ordering_cust_name'))]"/>
					</cpty_order_cust_name>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'ordering_cust_address'))]">
					<cpty_order_cust_addr>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'ordering_cust_address'))]"/>
					</cpty_order_cust_addr>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'ordering_cust_address_2'))]">
					<cpty_order_cust_addr_2>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'ordering_cust_address_2'))]"/>
					</cpty_order_cust_addr_2>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'ordering_cust_citystate'))]">
					<cpty_order_cust_city>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'ordering_cust_citystate'))]"/>
					</cpty_order_cust_city>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'order_details_clrc'))]">
					<cpty_order_details_clrc>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'order_details_clrc'))]"/>
					</cpty_order_details_clrc>
				</xsl:if>				
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'ordering_cust_account'))]">
					<cpty_order_account_no>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'ordering_cust_account'))]"/>
					</cpty_order_account_no>
				</xsl:if>
				
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'ordering_cust_country'))]">
					<cpty_order_cust_country>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'ordering_cust_country'))]"/>
					</cpty_order_cust_country>
				</xsl:if>
				
				<!-- end -->
					
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'swift_charges_type'))]">
					<cpty_swift_charges_paid>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'swift_charges_type'))]"/>
					</cpty_swift_charges_paid>
				</xsl:if>
	</xsl:template>


	<xsl:template name="bank-payment">
	
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="beneficiary_iso_code">
					<counterparty_act_iso_code>
						<xsl:value-of select="beneficiary_iso_code"/>
					</counterparty_act_iso_code>
				</xsl:if>			
				<xsl:if test="bank_payment/additionalBankInstructions/beneficiary_account">
					<counterparty_act_no>
						<xsl:value-of select="bank_payment/additionalBankInstructions/beneficiary_account"/>
					</counterparty_act_no>
				</xsl:if>					
				<xsl:if test="bank_payment/additionalBankInstructions/beneficiary_address">
					<counterparty_address_line_1>
						<xsl:value-of select="bank_payment/additionalBankInstructions/beneficiary_address"/>
					</counterparty_address_line_1>
					
				</xsl:if>
				<xsl:if test="bank_payment/additionalBankInstructions/beneficiary_city">
					<counterparty_address_line_2>
						<xsl:value-of select="bank_payment/additionalBankInstructions/beneficiary_city"/>
					</counterparty_address_line_2>
				</xsl:if>				
				<!-- insert counterparty_address_line_2 -->
				<xsl:if test="credit_amt">
					<counterparty_amt>
						<xsl:value-of select="credit_amt"/>
					</counterparty_amt>
				</xsl:if>
				<xsl:if test="bank_payment/additionalBankInstructions/beneficiary_country_code">
					<counterparty_dom>
						<xsl:value-of select="bank_payment/additionalBankInstructions/beneficiary_country_code"/>
					</counterparty_dom>
				</xsl:if>
				<xsl:if test="bank_payment/additionalBankInstructions/bene_details_clrc">
					<cpty_bene_details_clrc>
						<xsl:value-of select="bank_payment/additionalBankInstructions/bene_details_clrc"/>
					</cpty_bene_details_clrc>
				</xsl:if>
				<xsl:if test="bank_payment/currency">
					<counterparty_cur_code>
						<xsl:value-of select="bank_payment/currency"/>
					</counterparty_cur_code>
				</xsl:if>
				<!-- 
				<xsl:if test="bank_payment/additionalBankInstructions/beneficiary_city">
					<counterparty_dom>
						<xsl:value-of select="bank_payment/additionalBankInstructions/beneficiary_city"/>
					</counterparty_dom>
				</xsl:if>
				 -->
				<!-- insert counterparty_iss_date -->
				<!-- insert counterparty_label -->
				 <xsl:choose> 
					<xsl:when test="bank_payment/beneficiary_name">
						<counterparty_name>
							<xsl:value-of select="bank_payment/beneficiary_name"/>
						</counterparty_name>				
					</xsl:when>
					<xsl:otherwise>
						<counterparty_name>
							<xsl:value-of select="bank_payment/additionalBankInstructions/beneficiary_name"/>
						</counterparty_name>
					</xsl:otherwise>
				</xsl:choose>
				<!-- insert counterparty_reference -->
				<!-- insert open_chrg_brn_by_code -->
				
				<!-- insert regulatory_reporting_code -->
				<!-- insert regulatory_reporting_country -->

				<xsl:if test="bank_payment/account_with_institution_BIC"> <!-- beneficiary_bank_bic -->
					<cpty_bank_swift_bic_code name="cpty_bank_swift_bic_code" type="text" scope="master">
						<xsl:value-of select="bank_payment/account_with_institution_BIC"/>
					</cpty_bank_swift_bic_code>
				</xsl:if>
				<cpty_bank_name>
						<xsl:value-of select="bank_payment/institution_account"/>
				</cpty_bank_name>
				<!-- insert cpty_bank_address_line_1  -->
				<!-- insert cpty_bank_address_line_2  -->
				<!-- ctpy_bank_dom not used -->
				<!--xsl:if test="bank_payment/additionalBankInstructions/beneficiary_bank_country_code">
					<cpty_bank_dom>
						<xsl:value-of select="bank_payment/additionalBankInstructions/beneficiary_bank_country_code"/>
					</cpty_bank_dom>
				</xsl:if-->
				<!-- insert cpty_branch_code  -->
				<xsl:if test="bank_payment/additionalBankInstructions/beneficiary_bank_branch">
					<cpty_branch_name>
						<xsl:value-of select="bank_payment/additionalBankInstructions/beneficiary_bank_branch"/>
					</cpty_branch_name>
				</xsl:if>
				<xsl:if test="bank_payment/additionalBankInstructions/beneficiary_bank_address">
					<cpty_branch_address_line_1>
						<xsl:value-of select="bank_payment/additionalBankInstructions/beneficiary_bank_address"/>
					</cpty_branch_address_line_1>
				</xsl:if>
				<xsl:if test="bank_payment/additionalBankInstructions/beneficiary_bank_city">
					<cpty_branch_address_line_2>
						<xsl:value-of select="bank_payment/additionalBankInstructions/beneficiary_bank_city"/>
					</cpty_branch_address_line_2>
				</xsl:if>
				<!-- insert cpty_branch_dom  -->			
				<!-- insert cpty_branch_country  -->	
				<xsl:if test="bank_payment/additionalBankInstructions/beneficiary_bank_country">
					<cpty_bank_country>
						<xsl:value-of select="bank_payment/additionalBankInstructions/beneficiary_bank_country"/>
					</cpty_bank_country>
				</xsl:if>
				<xsl:if test="bank_payment/additionalBankInstructions/beneficiary_bank_clrc">
					<cpty_beneficiary_bank_clrc>
						<xsl:value-of select="bank_payment/additionalBankInstructions/beneficiary_bank_clrc"/>
					</cpty_beneficiary_bank_clrc>
				</xsl:if>
				<xsl:if test="bank_payment/instruction_indicator">
					<cpty_instruction_indicator>
						<xsl:value-of select="bank_payment/instruction_indicator"/>
					</cpty_instruction_indicator>
				</xsl:if>
				<xsl:if test="bank_payment/additionalBankInstructions/cpty_benificiary_institution">
					<cpty_benif_institution>
						<xsl:value-of select="bank_payment/additionalBankInstructions/cpty_benificiary_institution"/>
					</cpty_benif_institution>
				</xsl:if>
				<xsl:if test="bank_payment/additionalBankInstructions/beneficiary_bank_account">
					<cpty_benif_bank_routing_no>
						<xsl:value-of select="bank_payment/additionalBankInstructions/beneficiary_bank_account"/>
					</cpty_benif_bank_routing_no>
				</xsl:if>
				<xsl:if test="bank_payment/institution_account">
					<cpty_account_institution>
						<xsl:value-of select="bank_payment/institution_account"/>
					</cpty_account_institution>
				</xsl:if>

				<!--  swift charges -->				
				<xsl:choose>
					<xsl:when test="bank_payment/additionalBankInstructions/swift_charges_type = 'OUR' ">
						<cpty_swift_charges_paid>01</cpty_swift_charges_paid>
					</xsl:when>
					<xsl:when test="bank_payment/additionalBankInstructions/swift_charges_type = 'BEN' ">
						<cpty_swift_charges_paid>02</cpty_swift_charges_paid>
					</xsl:when>
					<xsl:when test="bank_payment/additionalBankInstructions/swift_charges_type = 'SHA' ">
						<cpty_swift_charges_paid>05</cpty_swift_charges_paid>
					</xsl:when>					
					<xsl:otherwise>					
					</xsl:otherwise>
				</xsl:choose>
							
				<!-- intermediary section -->
				<xsl:if test="bank_payment/additionalBankInstructions/intermediary_bic"> <!-- intermediary_swift / intermediary_bic  -->
					<cpty_inter_swift_bic_code>
						<xsl:value-of select="bank_payment/additionalBankInstructions/intermediary_bic"/>
					</cpty_inter_swift_bic_code>
				</xsl:if>
				<xsl:if test="bank_payment/additionalBankInstructions/intermediary_bank">
					<cpty_inter_bank_name>
						<xsl:value-of select="bank_payment/additionalBankInstructions/intermediary_bank"/>
					</cpty_inter_bank_name>
				</xsl:if>
				<xsl:if test="bank_payment/additionalBankInstructions/intermediary_address">
					<cpty_inter_bank_addr>
						<xsl:value-of select="bank_payment/additionalBankInstructions/intermediary_address"/>
					</cpty_inter_bank_addr>
				</xsl:if>
				<xsl:if test="bank_payment/additionalBankInstructions/intermediary_address_2">
					<cpty_inter_bank_addr_2>
						<xsl:value-of select="bank_payment/additionalBankInstructions/intermediary_address_2"/>
					</cpty_inter_bank_addr_2>
				</xsl:if>
				<xsl:if test="bank_payment/additionalBankInstructions/intermediary_city">
					<cpty_inter_city_state>
						<xsl:value-of select="bank_payment/additionalBankInstructions/intermediary_city"/>
					</cpty_inter_city_state>
				</xsl:if>
				<xsl:if test="bank_payment/additionalBankInstructions/intermediary_country_code">
					<cpty_inter_country>
						<xsl:value-of select="bank_payment/additionalBankInstructions/intermediary_country_code"/>
					</cpty_inter_country>
				</xsl:if>
				<xsl:if test="bank_payment/additionalBankInstructions/inter_bank_clrc">
					<cpty_inter_bank_clrc>
						<xsl:value-of select="bank_payment/additionalBankInstructions/inter_bank_clrc"/>
					</cpty_inter_bank_clrc>
				</xsl:if>
				<xsl:if test="bank_payment/additionalBankInstructions/intermediary_bank_account_number"> <!-- intermediary account -->
					<cpty_inter_routing_no>
						<xsl:value-of select="bank_payment/additionalBankInstructions/intermediary_bank_account_number"/>
					</cpty_inter_routing_no>
				</xsl:if>				
				
				<xsl:if test="bank_payment/additionalBankInstructions/routing_instructions_1">
					<cpty_special_routing_1>
						<xsl:value-of select="bank_payment/additionalBankInstructions/routing_instructions_1"/>
					</cpty_special_routing_1>
				</xsl:if>
				<xsl:if test="bank_payment/additionalBankInstructions/routing_instructions_2">
					<cpty_special_routing_2>
						<xsl:value-of select="bank_payment/additionalBankInstructions/routing_instructions_2"/>
					</cpty_special_routing_2>
				</xsl:if>
				<xsl:if test="bank_payment/additionalBankInstructions/routing_instructions_3">
					<cpty_special_routing_3>
						<xsl:value-of select="bank_payment/additionalBankInstructions/routing_instructions_3"/>
					</cpty_special_routing_3>
				</xsl:if>
				<xsl:if test="bank_payment/additionalBankInstructions/routing_instructions_4">
					<cpty_special_routing_4>
						<xsl:value-of select="bank_payment/additionalBankInstructions/routing_instructions_4"/>
					</cpty_special_routing_4>
				</xsl:if>
				<xsl:if test="bank_payment/additionalBankInstructions/routing_instructions_5">
					<cpty_special_routing_5>
						<xsl:value-of select="bank_payment/additionalBankInstructions/routing_instructions_5"/>
					</cpty_special_routing_5>
				</xsl:if>
				<xsl:if test="bank_payment/additionalBankInstructions/routing_instructions_6">
					<cpty_special_routing_6>
						<xsl:value-of select="bank_payment/additionalBankInstructions/routing_instructions_6"/>
					</cpty_special_routing_6>
				</xsl:if>
				
				<xsl:if test="bank_payment/additionalBankInstructions/payment_details_1">
					<cpty_payment_detail_1>
						<xsl:value-of select="bank_payment/additionalBankInstructions/payment_details_1"/>
					</cpty_payment_detail_1>
				</xsl:if>
				<xsl:if test="bank_payment/additionalBankInstructions/payment_details_2">
					<cpty_payment_detail_2>
						<xsl:value-of select="bank_payment/additionalBankInstructions/payment_details_2"/>
					</cpty_payment_detail_2>
				</xsl:if>
				<xsl:if test="bank_payment/additionalBankInstructions/payment_details_3">
					<cpty_payment_detail_3>
						<xsl:value-of select="bank_payment/additionalBankInstructions/payment_details_3"/>
					</cpty_payment_detail_3>
				</xsl:if>
				<xsl:if test="bank_payment/additionalBankInstructions/payment_details_4">
					<cpty_payment_detail_4>
						<xsl:value-of select="bank_payment/additionalBankInstructions/payment_details_4"/>
					</cpty_payment_detail_4>
				</xsl:if>
				
				<xsl:if test="bank_payment/additionalBankInstructions/ordering_cust_name">
					<cpty_order_cust_name>
						<xsl:value-of select="bank_payment/additionalBankInstructions/ordering_cust_name"/>
					</cpty_order_cust_name>
				</xsl:if>
				<xsl:if test="bank_payment/additionalBankInstructions/ordering_cust_account">
					<cpty_order_account_no>
						<xsl:value-of select="bank_payment/additionalBankInstructions/ordering_cust_account"/>
					</cpty_order_account_no>
				</xsl:if>
				<xsl:if test="bank_payment/additionalBankInstructions/ordering_cust_address">
					<cpty_order_cust_addr>
						<xsl:value-of select="bank_payment/additionalBankInstructions/ordering_cust_address"/>
					</cpty_order_cust_addr>
				</xsl:if>
				<xsl:if test="bank_payment/additionalBankInstructions/ordering_cust_address_2">
					<cpty_order_cust_addr_2>
						<xsl:value-of select="bank_payment/additionalBankInstructions/ordering_cust_address_2"/>
					</cpty_order_cust_addr_2>
				</xsl:if>
				<xsl:if test="bank_payment/additionalBankInstructions/ordering_cust_citystate">
					<cpty_order_cust_city>
						<xsl:value-of select="bank_payment/additionalBankInstructions/ordering_cust_citystate"/>
					</cpty_order_cust_city>
				</xsl:if>
				<xsl:if test="bank_payment/additionalBankInstructions/ordering_cust_country">
					<cpty_order_cust_country>
						<xsl:value-of select="bank_payment/additionalBankInstructions/ordering_cust_country"/>
					</cpty_order_cust_country>
				</xsl:if>
				<xsl:if test="bank_payment/additionalBankInstructions/order_details_clrc">
					<cpty_order_details_clrc>
						<xsl:value-of select="bank_payment/additionalBankInstructions/order_details_clrc"/>
					</cpty_order_details_clrc>
				</xsl:if>
                <xsl:if test="bank_payment/account">
			         <settlement_account><xsl:value-of select="bank_payment/account"/></settlement_account>
			    </xsl:if>				
				<xsl:if test="bank_payment/settlementMeans">
			          <settlement_mean><xsl:value-of select="bank_payment/settlementMeans"/></settlement_mean>
			    </xsl:if>
	</xsl:template>


	<xsl:template name="near-bank-payment">
	
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="near_beneficiary_iso_code">
					<counterparty_act_iso_code>
						<xsl:value-of select="near_beneficiary_iso_code"/>
					</counterparty_act_iso_code>
				</xsl:if>			
				<xsl:if test="near_bank_payment/additionalBankInstructions/beneficiary_account">
					<counterparty_act_no>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/beneficiary_account"/>
					</counterparty_act_no>
				</xsl:if>					
				<xsl:if test="near_bank_payment/additionalBankInstructions/beneficiary_address">
					<counterparty_address_line_1>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/beneficiary_address"/>
					</counterparty_address_line_1>
				</xsl:if>
				<xsl:if test="near_bank_payment/additionalBankInstructions/beneficiary_city">
					<counterparty_address_line_2>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/beneficiary_city"/>
					</counterparty_address_line_2>
				</xsl:if>				
				<!-- insert counterparty_address_line_2 -->
				<xsl:if test="near_payment_amt">
					<counterparty_amt>
						<xsl:value-of select="near_payment_amt"/>
					</counterparty_amt>
				</xsl:if>
				<xsl:if test="near_bank_payment/additionalBankInstructions/beneficiary_country_code">
					<counterparty_dom>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/beneficiary_country_code"/>
					</counterparty_dom>
				</xsl:if>
				<xsl:if test="near_bank_payment/additionalBankInstructions/bene_details_clrc">
					<cpty_bene_details_clrc>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/bene_details_clrc"/>
					</cpty_bene_details_clrc>
				</xsl:if>
				<xsl:if test="near_bank_payment/currency">
					<counterparty_cur_code>
						<xsl:value-of select="near_bank_payment/currency"/>
					</counterparty_cur_code>
				</xsl:if>
				<!-- 
				<xsl:if test="near_bank_payment/additionalBankInstructions/beneficiary_city">
					<counterparty_dom>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/beneficiary_city"/>
					</counterparty_dom>
				</xsl:if>
				 -->
				<!-- insert counterparty_iss_date -->
				<!-- insert counterparty_label -->
				 <xsl:choose> 
					<xsl:when test="near_bank_payment/beneficiary_name">
						<counterparty_name>
							<xsl:value-of select="near_bank_payment/beneficiary_name"/>
						</counterparty_name>				
					</xsl:when>
					<xsl:otherwise>
						<counterparty_name>
							<xsl:value-of select="near_bank_payment/additionalBankInstructions/beneficiary_name"/>
						</counterparty_name>
					</xsl:otherwise>
				</xsl:choose>
				<!-- insert counterparty_reference -->
				<!-- insert open_chrg_brn_by_code -->
				
				<!-- insert regulatory_reporting_code -->
				<!-- insert regulatory_reporting_country -->

				<xsl:if test="near_bank_payment/account_with_institution_BIC"> <!-- beneficiary_bank_bic -->
					<cpty_bank_swift_bic_code name="cpty_bank_swift_bic_code" type="text" scope="master">
						<xsl:value-of select="near_bank_payment/account_with_institution_BIC"/>
					</cpty_bank_swift_bic_code>	
				</xsl:if>

				<xsl:if test="near_bank_payment/institution_account"> <!-- beneficiary_bank -->
					<cpty_bank_name>
						<xsl:value-of select="near_bank_payment/institution_account"/>
					</cpty_bank_name>
				</xsl:if>
				<!-- insert cpty_bank_address_line_1  -->
				<!-- insert cpty_bank_address_line_2  -->

				<!--xsl:if test="near_bank_payment/additionalBankInstructions/beneficiary_bank_country_code">
					<cpty_bank_dom>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/beneficiary_bank_country_code"/>
					</cpty_bank_dom>
				</xsl:if-->
				<!-- insert cpty_branch_code  -->
				<xsl:if test="near_bank_payment/additionalBankInstructions/beneficiary_bank_branch">
					<cpty_branch_name>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/beneficiary_bank_branch"/>
					</cpty_branch_name>
				</xsl:if>
				<xsl:if test="near_bank_payment/additionalBankInstructions/beneficiary_bank_address">
					<cpty_branch_address_line_1>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/beneficiary_bank_address"/>
					</cpty_branch_address_line_1>
				</xsl:if>
				<xsl:if test="bank_payment/additionalBankInstructions/beneficiary_bank_city">
					<cpty_branch_address_line_2>
						<xsl:value-of select="bank_payment/additionalBankInstructions/beneficiary_bank_city"/>
					</cpty_branch_address_line_2>
				</xsl:if>
				<!-- insert cpty_branch_dom  -->
				<!-- insert cpty_branch_country  -->	
				<xsl:if test="near_bank_payment/additionalBankInstructions/beneficiary_bank_country">
					<cpty_bank_country>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/beneficiary_bank_country"/>
					</cpty_bank_country>
				</xsl:if>
				<xsl:if test="near_bank_payment/additionalBankInstructions/beneficiary_bank_clrc">
					<cpty_beneficiary_bank_clrc>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/beneficiary_bank_clrc"/>
					</cpty_beneficiary_bank_clrc>
				</xsl:if>
				<xsl:if test="near_bank_payment/instruction_indicator">
					<cpty_instruction_indicator>
						<xsl:value-of select="near_bank_payment/instruction_indicator"/>
					</cpty_instruction_indicator>
				</xsl:if>
				<xsl:if test="near_bank_payment/additionalBankInstructions/cpty_benificiary_institution">
					<cpty_benif_institution>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/cpty_benificiary_institution"/>
					</cpty_benif_institution>
				</xsl:if>
				<xsl:if test="near_bank_payment/additionalBankInstructions/beneficiary_bank_account">
					<cpty_benif_account>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/beneficiary_bank_account"/>
					</cpty_benif_account>
				</xsl:if>
				<xsl:if test="near_bank_payment/institution_account">
					<cpty_account_institution>
						<xsl:value-of select="near_bank_payment/institution_account"/>
					</cpty_account_institution>
				</xsl:if>
				<xsl:if test="near_bank_payment/additionalBankInstructions/beneficiary_bank_routing_number">
					<cpty_benif_bank_routing_no>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/beneficiary_bank_routing_number"/>
					</cpty_benif_bank_routing_no>
				</xsl:if>

				<!--  swift charges -->				
				<xsl:choose>
					<xsl:when test="near_bank_payment/additionalBankInstructions/swift_charges_type = 'OUR' ">
						<cpty_swift_charges_paid>01</cpty_swift_charges_paid>
					</xsl:when>
					<xsl:when test="near_bank_payment/additionalBankInstructions/swift_charges_type = 'BEN' ">
						<cpty_swift_charges_paid>02</cpty_swift_charges_paid>
					</xsl:when>
					<xsl:when test="near_bank_payment/additionalBankInstructions/swift_charges_type = 'SHA' ">
						<cpty_swift_charges_paid>05</cpty_swift_charges_paid>
					</xsl:when>					
					<xsl:otherwise>					
					</xsl:otherwise>
				</xsl:choose>
							
				<!-- intermediary section -->
				<xsl:if test="near_bank_payment/additionalBankInstructions/intermediary_bic"> <!-- intermediary_swift / intermediary_bic  -->
					<cpty_inter_swift_bic_code>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/intermediary_bic"/>
					</cpty_inter_swift_bic_code>
				</xsl:if>
				<xsl:if test="near_bank_payment/additionalBankInstructions/intermediary_bank">
					<cpty_inter_bank_name>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/intermediary_bank"/>
					</cpty_inter_bank_name>
				</xsl:if>
				<xsl:if test="near_bank_payment/additionalBankInstructions/intermediary_address">
					<cpty_inter_bank_addr>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/intermediary_address"/>
					</cpty_inter_bank_addr>
				</xsl:if>
				<xsl:if test="near_bank_payment/additionalBankInstructions/intermediary_address_2">
					<cpty_inter_bank_addr_2>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/intermediary_address_2"/>
					</cpty_inter_bank_addr_2>
				</xsl:if>
				<xsl:if test="near_bank_payment/additionalBankInstructions/intermediary_city">
					<cpty_inter_city_state>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/intermediary_city"/>
					</cpty_inter_city_state>
				</xsl:if>
				<xsl:if test="near_bank_payment/additionalBankInstructions/intermediary_country_code">
					<cpty_inter_country>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/intermediary_country_code"/>
					</cpty_inter_country>
				</xsl:if>
				<xsl:if test="near_bank_payment/additionalBankInstructions/inter_bank_clrc">
					<cpty_inter_bank_clrc>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/inter_bank_clrc"/>
					</cpty_inter_bank_clrc>
				</xsl:if>
				<xsl:if test="near_bank_payment/additionalBankInstructions/intermediary_bank_account_number"> <!-- intermediary account -->
					<cpty_inter_routing_no>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/intermediary_bank_account_number"/>
					</cpty_inter_routing_no>
				</xsl:if>				
				
				<xsl:if test="near_bank_payment/additionalBankInstructions/routing_instructions_1">
					<cpty_special_routing_1>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/routing_instructions_1"/>
					</cpty_special_routing_1>
				</xsl:if>
				<xsl:if test="near_bank_payment/additionalBankInstructions/routing_instructions_2">
					<cpty_special_routing_2>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/routing_instructions_2"/>
					</cpty_special_routing_2>
				</xsl:if>
				<xsl:if test="near_bank_payment/additionalBankInstructions/routing_instructions_3">
					<cpty_special_routing_3>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/routing_instructions_3"/>
					</cpty_special_routing_3>
				</xsl:if>
				<xsl:if test="near_bank_payment/additionalBankInstructions/routing_instructions_4">
					<cpty_special_routing_4>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/routing_instructions_4"/>
					</cpty_special_routing_4>
				</xsl:if>
				<xsl:if test="near_bank_payment/additionalBankInstructions/routing_instructions_5">
					<cpty_special_routing_5>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/routing_instructions_5"/>
					</cpty_special_routing_5>
				</xsl:if>
				<xsl:if test="near_bank_payment/additionalBankInstructions/routing_instructions_6">
					<cpty_special_routing_6>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/routing_instructions_6"/>
					</cpty_special_routing_6>
				</xsl:if>
				
				<xsl:if test="near_bank_payment/additionalBankInstructions/payment_details_1">
					<cpty_payment_detail_1>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/payment_details_1"/>
					</cpty_payment_detail_1>
				</xsl:if>
				<xsl:if test="near_bank_payment/additionalBankInstructions/payment_details_2">
					<cpty_payment_detail_2>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/payment_details_2"/>
					</cpty_payment_detail_2>
				</xsl:if>
				<xsl:if test="near_bank_payment/additionalBankInstructions/payment_details_3">
					<cpty_payment_detail_3>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/payment_details_3"/>
					</cpty_payment_detail_3>
				</xsl:if>
				<xsl:if test="near_bank_payment/additionalBankInstructions/payment_details_4">
					<cpty_payment_detail_4>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/payment_details_4"/>
					</cpty_payment_detail_4>
				</xsl:if>
				
				<xsl:if test="near_bank_payment/additionalBankInstructions/ordering_cust_name">
					<cpty_order_cust_name>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/ordering_cust_name"/>
					</cpty_order_cust_name>
				</xsl:if>
				<xsl:if test="near_bank_payment/additionalBankInstructions/ordering_cust_account">
					<cpty_order_account_no>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/ordering_cust_account"/>
					</cpty_order_account_no>
				</xsl:if>
				<xsl:if test="near_bank_payment/additionalBankInstructions/ordering_cust_address">
					<cpty_order_cust_addr>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/ordering_cust_address"/>
					</cpty_order_cust_addr>
				</xsl:if>
				<xsl:if test="near_bank_payment/additionalBankInstructions/ordering_cust_address_2">
					<cpty_order_cust_addr_2>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/ordering_cust_address_2"/>
					</cpty_order_cust_addr_2>
				</xsl:if>
				<xsl:if test="near_bank_payment/additionalBankInstructions/ordering_cust_citystate">
					<cpty_order_cust_city>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/ordering_cust_citystate"/>
					</cpty_order_cust_city>
				</xsl:if>
				<xsl:if test="near_bank_payment/additionalBankInstructions/ordering_cust_country">
					<cpty_order_cust_country>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/ordering_cust_country"/>
					</cpty_order_cust_country>
				</xsl:if>
				<xsl:if test="near_bank_payment/additionalBankInstructions/order_details_clrc">
					<cpty_order_details_clrc>
						<xsl:value-of select="near_bank_payment/additionalBankInstructions/order_details_clrc"/>
					</cpty_order_details_clrc>
				</xsl:if>
				
	</xsl:template>

	<xsl:template name="far-bank-payment">
	
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="far_beneficiary_iso_code">
					<counterparty_act_iso_code>
						<xsl:value-of select="far_beneficiary_iso_code"/>
					</counterparty_act_iso_code>
				</xsl:if>			
				<xsl:if test="far_bank_payment/additionalBankInstructions/beneficiary_account">
					<counterparty_act_no>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/beneficiary_account"/>
					</counterparty_act_no>
				</xsl:if>					
				<xsl:if test="far_bank_payment/additionalBankInstructions/beneficiary_address">
					<counterparty_address_line_1>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/beneficiary_address"/>
					</counterparty_address_line_1>
				</xsl:if>
				<xsl:if test="far_bank_payment/additionalBankInstructions/beneficiary_city">
					<counterparty_address_line_2>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/beneficiary_city"/>
					</counterparty_address_line_2>
				</xsl:if>				
				<!-- insert counterparty_address_line_2 -->
				<xsl:if test="far_payment_amt">
					<counterparty_amt>
						<xsl:value-of select="far_payment_amt"/>
					</counterparty_amt>
				</xsl:if>
				<xsl:if test="far_bank_payment/additionalBankInstructions/beneficiary_country_code">
					<counterparty_dom>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/beneficiary_country_code"/>
					</counterparty_dom>
				</xsl:if>
				<xsl:if test="far_bank_payment/additionalBankInstructions/bene_details_clrc">
					<cpty_bene_details_clrc>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/bene_details_clrc"/>
					</cpty_bene_details_clrc>
				</xsl:if>
				<xsl:if test="far_bank_payment/currency">
					<counterparty_cur_code>
						<xsl:value-of select="far_bank_payment/currency"/>
					</counterparty_cur_code>
				</xsl:if>
				<!-- 
				<xsl:if test="far_bank_payment/additionalBankInstructions/beneficiary_city">
					<counterparty_dom>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/beneficiary_city"/>
					</counterparty_dom>
				</xsl:if>
				 -->
				<!-- insert counterparty_iss_date -->
				<!-- insert counterparty_label -->
				 <xsl:choose> 
					<xsl:when test="far_bank_payment/beneficiary_name">
						<counterparty_name>
							<xsl:value-of select="far_bank_payment/beneficiary_name"/>
						</counterparty_name>				
					</xsl:when>
					<xsl:otherwise>
						<counterparty_name>
							<xsl:value-of select="far_bank_payment/additionalBankInstructions/beneficiary_name"/>
						</counterparty_name>
					</xsl:otherwise>
				</xsl:choose>
				<!-- insert counterparty_reference -->
				<!-- insert open_chrg_brn_by_code -->
				
				<!-- insert regulatory_reporting_code -->
				<!-- insert regulatory_reporting_country -->

				<xsl:if test="far_bank_payment/account_with_institution_BIC"> <!-- beneficiary_bank_bic -->
					<cpty_bank_swift_bic_code name="cpty_bank_swift_bic_code" type="text" scope="master">
						<xsl:value-of select="far_bank_payment/account_with_institution_BIC"/>
					</cpty_bank_swift_bic_code>	
				</xsl:if>

				<xsl:if test="far_bank_payment/institution_account"> <!-- beneficiary_bank -->
					<cpty_bank_name>
						<xsl:value-of select="far_bank_payment/institution_account"/>
					</cpty_bank_name>
				</xsl:if>
				<!-- insert cpty_bank_address_line_1  -->
				<!-- insert cpty_bank_address_line_2  -->

				<!--xsl:if test="far_bank_payment/additionalBankInstructions/beneficiary_bank_country_code">
					<cpty_bank_dom>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/beneficiary_bank_country_code"/>
					</cpty_bank_dom>
				</xsl:if-->
				<!-- insert cpty_branch_code  -->
				<xsl:if test="far_bank_payment/additionalBankInstructions/beneficiary_bank_branch">
					<cpty_branch_name>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/beneficiary_bank_branch"/>
					</cpty_branch_name>
				</xsl:if>
				<xsl:if test="far_bank_payment/additionalBankInstructions/beneficiary_bank_address">
					<cpty_branch_address_line_1>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/beneficiary_bank_address"/>
					</cpty_branch_address_line_1>
				</xsl:if>
				<xsl:if test="bank_payment/additionalBankInstructions/beneficiary_bank_city">
					<cpty_branch_address_line_2>
						<xsl:value-of select="bank_payment/additionalBankInstructions/beneficiary_bank_city"/>
					</cpty_branch_address_line_2>
				</xsl:if>
				<!-- insert cpty_branch_dom  -->
				<!-- insert cpty_branch_country  -->	
				<xsl:if test="far_bank_payment/additionalBankInstructions/beneficiary_bank_country">
					<cpty_bank_country>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/beneficiary_bank_country"/>
					</cpty_bank_country>
				</xsl:if>
				<xsl:if test="far_bank_payment/additionalBankInstructions/beneficiary_bank_clrc">
					<cpty_beneficiary_bank_clrc>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/beneficiary_bank_clrc"/>
					</cpty_beneficiary_bank_clrc>
				</xsl:if>
				<xsl:if test="far_bank_payment/instruction_indicator">
					<cpty_instruction_indicator>
						<xsl:value-of select="far_bank_payment/instruction_indicator"/>
					</cpty_instruction_indicator>
				</xsl:if>
				<xsl:if test="far_bank_payment/additionalBankInstructions/cpty_benificiary_institution">
					<cpty_benif_institution>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/cpty_benificiary_institution"/>
					</cpty_benif_institution>
				</xsl:if>
				<xsl:if test="far_bank_payment/additionalBankInstructions/beneficiary_bank_account">
					<cpty_benif_account>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/beneficiary_bank_account"/>
					</cpty_benif_account>
				</xsl:if>
				<xsl:if test="far_bank_payment/institution_account">
					<cpty_account_institution>
						<xsl:value-of select="far_bank_payment/institution_account"/>
					</cpty_account_institution>
				</xsl:if>
				<xsl:if test="far_bank_payment/additionalBankInstructions/beneficiary_bank_routing_number">
					<cpty_benif_bank_routing_no>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/beneficiary_bank_routing_number"/>
					</cpty_benif_bank_routing_no>
				</xsl:if>

				<!--  swift charges -->				
				<xsl:choose>
					<xsl:when test="far_bank_payment/additionalBankInstructions/swift_charges_type = 'OUR' ">
						<cpty_swift_charges_paid>01</cpty_swift_charges_paid>
					</xsl:when>
					<xsl:when test="far_bank_payment/additionalBankInstructions/swift_charges_type = 'BEN' ">
						<cpty_swift_charges_paid>02</cpty_swift_charges_paid>
					</xsl:when>
					<xsl:when test="far_bank_payment/additionalBankInstructions/swift_charges_type = 'SHA' ">
						<cpty_swift_charges_paid>05</cpty_swift_charges_paid>
					</xsl:when>					
					<xsl:otherwise>					
					</xsl:otherwise>
				</xsl:choose>
							
				<!-- intermediary section -->
				<xsl:if test="far_bank_payment/additionalBankInstructions/intermediary_bic"> <!-- intermediary_swift / intermediary_bic  -->
					<cpty_inter_swift_bic_code>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/intermediary_bic"/>
					</cpty_inter_swift_bic_code>
				</xsl:if>
				<xsl:if test="far_bank_payment/additionalBankInstructions/intermediary_bank">
					<cpty_inter_bank_name>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/intermediary_bank"/>
					</cpty_inter_bank_name>
				</xsl:if>
				<xsl:if test="far_bank_payment/additionalBankInstructions/intermediary_address">
					<cpty_inter_bank_addr>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/intermediary_address"/>
					</cpty_inter_bank_addr>
				</xsl:if>
				<xsl:if test="far_bank_payment/additionalBankInstructions/intermediary_address_2">
					<cpty_inter_bank_addr_2>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/intermediary_address_2"/>
					</cpty_inter_bank_addr_2>
				</xsl:if>
				<xsl:if test="far_bank_payment/additionalBankInstructions/intermediary_city">
					<cpty_inter_city_state>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/intermediary_city"/>
					</cpty_inter_city_state>
				</xsl:if>
				<xsl:if test="far_bank_payment/additionalBankInstructions/intermediary_country_code">
					<cpty_inter_country>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/intermediary_country_code"/>
					</cpty_inter_country>
				</xsl:if>
				<xsl:if test="far_bank_payment/additionalBankInstructions/inter_bank_clrc">
					<cpty_inter_bank_clrc>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/inter_bank_clrc"/>
					</cpty_inter_bank_clrc>
				</xsl:if>
				<xsl:if test="far_bank_payment/additionalBankInstructions/intermediary_bank_account_number"> <!-- intermediary account -->
					<cpty_inter_routing_no>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/intermediary_bank_account_number"/>
					</cpty_inter_routing_no>
				</xsl:if>				
				
				<xsl:if test="far_bank_payment/additionalBankInstructions/routing_instructions_1">
					<cpty_special_routing_1>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/routing_instructions_1"/>
					</cpty_special_routing_1>
				</xsl:if>
				<xsl:if test="far_bank_payment/additionalBankInstructions/routing_instructions_2">
					<cpty_special_routing_2>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/routing_instructions_2"/>
					</cpty_special_routing_2>
				</xsl:if>
				<xsl:if test="far_bank_payment/additionalBankInstructions/routing_instructions_3">
					<cpty_special_routing_3>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/routing_instructions_3"/>
					</cpty_special_routing_3>
				</xsl:if>
				<xsl:if test="far_bank_payment/additionalBankInstructions/routing_instructions_4">
					<cpty_special_routing_4>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/routing_instructions_4"/>
					</cpty_special_routing_4>
				</xsl:if>
				<xsl:if test="far_bank_payment/additionalBankInstructions/routing_instructions_5">
					<cpty_special_routing_5>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/routing_instructions_5"/>
					</cpty_special_routing_5>
				</xsl:if>
				<xsl:if test="far_bank_payment/additionalBankInstructions/routing_instructions_6">
					<cpty_special_routing_6>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/routing_instructions_6"/>
					</cpty_special_routing_6>
				</xsl:if>
				
				<xsl:if test="far_bank_payment/additionalBankInstructions/payment_details_1">
					<cpty_payment_detail_1>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/payment_details_1"/>
					</cpty_payment_detail_1>
				</xsl:if>
				<xsl:if test="far_bank_payment/additionalBankInstructions/payment_details_2">
					<cpty_payment_detail_2>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/payment_details_2"/>
					</cpty_payment_detail_2>
				</xsl:if>
				<xsl:if test="far_bank_payment/additionalBankInstructions/payment_details_3">
					<cpty_payment_detail_3>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/payment_details_3"/>
					</cpty_payment_detail_3>
				</xsl:if>
				<xsl:if test="far_bank_payment/additionalBankInstructions/payment_details_4">
					<cpty_payment_detail_4>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/payment_details_4"/>
					</cpty_payment_detail_4>
				</xsl:if>
				
				<xsl:if test="far_bank_payment/additionalBankInstructions/ordering_cust_name">
					<cpty_order_cust_name>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/ordering_cust_name"/>
					</cpty_order_cust_name>
				</xsl:if>
				<xsl:if test="far_bank_payment/additionalBankInstructions/ordering_cust_account">
					<cpty_order_account_no>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/ordering_cust_account"/>
					</cpty_order_account_no>
				</xsl:if>
				<xsl:if test="far_bank_payment/additionalBankInstructions/ordering_cust_address">
					<cpty_order_cust_addr>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/ordering_cust_address"/>
					</cpty_order_cust_addr>
				</xsl:if>
				<xsl:if test="far_bank_payment/additionalBankInstructions/ordering_cust_address_2">
					<cpty_order_cust_addr_2>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/ordering_cust_address_2"/>
					</cpty_order_cust_addr_2>
				</xsl:if>
				<xsl:if test="far_bank_payment/additionalBankInstructions/ordering_cust_citystate">
					<cpty_order_cust_city>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/ordering_cust_citystate"/>
					</cpty_order_cust_city>
				</xsl:if>
				<xsl:if test="far_bank_payment/additionalBankInstructions/ordering_cust_country">
					<cpty_order_cust_country>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/ordering_cust_country"/>
					</cpty_order_cust_country>
				</xsl:if>
				<xsl:if test="far_bank_payment/additionalBankInstructions/order_details_clrc">
					<cpty_order_details_clrc>
						<xsl:value-of select="far_bank_payment/additionalBankInstructions/order_details_clrc"/>
					</cpty_order_details_clrc>
				</xsl:if>
	</xsl:template>
	
	<!-- should refactor to use this more generic template -->
	<!-- Not used ? -->
	 <xsl:template name="prefix-bank-payment">
		<xsl:param name="prefix"/>
	
				<xsl:variable name="prefix_name">
					<xsl:choose>
						<xsl:when test="$prefix">
							<xsl:value-of select="concat($prefix,'_')"/>
						</xsl:when>
					</xsl:choose>
				</xsl:variable>	
	
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'beneficiary_iso_code'))]">
					<counterparty_act_iso_code>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'beneficiary_iso_code'))]"/>
					</counterparty_act_iso_code>
				</xsl:if>			
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/beneficiary_account'))]">
					<counterparty_act_no>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/beneficiary_account'))]"/>
					</counterparty_act_no>
				</xsl:if>					
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/beneficiary_address'))]">
					<counterparty_address_line_1>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/beneficiary_address'))]"/>
					</counterparty_address_line_1>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/beneficiary_city'))]">
					<counterparty_address_line_2>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/beneficiary_city'))]"/>
					</counterparty_address_line_2>
				</xsl:if>				
				<!-- insert counterparty_address_line_2 -->
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'payment_amt'))]">
					<counterparty_amt>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'payment_amt'))]"/>
					</counterparty_amt>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/beneficiary_country_code'))]">
					<counterparty_dom>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/beneficiary_country_code'))]"/>
					</counterparty_dom>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/bene_details_clrc'))]">
					<cpty_bene_details_clrc>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/bene_details_clrc'))]"/>
					</cpty_bene_details_clrc>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/currency'))]">
					<counterparty_cur_code>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/currency'))]"/>
					</counterparty_cur_code>
				</xsl:if>
				<!-- 
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/beneficiary_city'))]">
					<counterparty_dom>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/beneficiary_city'))]"/>
					</counterparty_dom>
				</xsl:if>
				 -->
				<!-- insert counterparty_iss_date -->
				<!-- insert counterparty_label -->
				 <xsl:choose> 
					<xsl:when test="//*[starts-with(name(), concat($prefix_name,'bank_payment/beneficiary_name'))]">
						<counterparty_name>
							<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/beneficiary_name'))]"/>
						</counterparty_name>				
					</xsl:when>
					<xsl:otherwise>
						<counterparty_name>
							<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/beneficiary_name'))]"/>
						</counterparty_name>
					</xsl:otherwise>
				</xsl:choose>
				<!-- insert counterparty_reference -->
				<!-- insert open_chrg_brn_by_code -->
				
				<!-- insert regulatory_reporting_code -->
				<!-- insert regulatory_reporting_country -->

				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/account_with_institution_BIC'))]"> <!-- beneficiary_bank_bic -->
					<cpty_bank_swift_bic_code name="cpty_bank_swift_bic_code" type="text" scope="master">
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/account_with_institution_BIC'))]"/>
					</cpty_bank_swift_bic_code>	
				</xsl:if>

				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/institution_account'))]"> <!-- beneficiary_bank -->
					<cpty_bank_name>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/institution_account'))]"/>
					</cpty_bank_name>
				</xsl:if>
				<!-- insert cpty_bank_address_line_1  -->
				<!-- insert cpty_bank_address_line_2  -->

				<!--xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/beneficiary_bank_country_code'))]">
					<cpty_bank_dom>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/beneficiary_bank_country_code'))]"/>
					</cpty_bank_dom>
				</xsl:if-->
				<!-- insert cpty_branch_code  -->
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/beneficiary_bank_branch'))]">
					<cpty_branch_name>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/beneficiary_bank_branch'))]"/>
					</cpty_branch_name>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/beneficiary_bank_address'))]">
					<cpty_branch_address_line_1>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/beneficiary_bank_address'))]"/>
					</cpty_branch_address_line_1>
				</xsl:if>
				<xsl:if test="bank_payment/additionalBankInstructions/beneficiary_bank_city">
					<cpty_branch_address_line_2>
						<xsl:value-of select="bank_payment/additionalBankInstructions/beneficiary_bank_city"/>
					</cpty_branch_address_line_2>
				</xsl:if>
				<!-- insert cpty_branch_dom  -->
				<!-- insert cpty_branch_country  -->	
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/beneficiary_bank_country'))]">
					<cpty_bank_country>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/beneficiary_bank_country'))]"/>
					</cpty_bank_country>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/beneficiary_bank_clrc'))]">
					<cpty_beneficiary_bank_clrc>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/beneficiary_bank_clrc'))]"/>
					</cpty_beneficiary_bank_clrc>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/instruction_indicator'))]">
					<cpty_instruction_indicator>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/instruction_indicator'))]"/>
					</cpty_instruction_indicator>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/cpty_benificiary_institution'))]">
					<cpty_benif_institution>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/cpty_benificiary_institution'))]"/>
					</cpty_benif_institution>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/beneficiary_bank_account'))]">
					<cpty_benif_account>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/beneficiary_bank_account'))]"/>
					</cpty_benif_account>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/institution_account'))]">
					<cpty_account_institution>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/institution_account'))]"/>
					</cpty_account_institution>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/beneficiary_bank_routing_number'))]">
					<cpty_benif_bank_routing_no>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/beneficiary_bank_routing_number'))]"/>
					</cpty_benif_bank_routing_no>
				</xsl:if>

				<!--  swift charges -->				
				<xsl:choose>
					<xsl:when test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/swift_charges_type'))] = 'OUR' ">
						<cpty_swift_charges_paid>01</cpty_swift_charges_paid>
					</xsl:when>
					<xsl:when test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/swift_charges_type'))] = 'BEN' ">
						<cpty_swift_charges_paid>02</cpty_swift_charges_paid>
					</xsl:when>
					<xsl:when test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/swift_charges_type'))] = 'SHA' ">
						<cpty_swift_charges_paid>05</cpty_swift_charges_paid>
					</xsl:when>					
					<xsl:otherwise>					
					</xsl:otherwise>
				</xsl:choose>
							
				<!-- intermediary section -->
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/intermediary_bic'))]"> <!-- intermediary_swift / intermediary_bic  -->
					<cpty_inter_swift_bic_code>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/intermediary_bic'))]"/>
					</cpty_inter_swift_bic_code>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/intermediary_bank'))]">
					<cpty_inter_bank_name>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/intermediary_bank'))]"/>
					</cpty_inter_bank_name>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/intermediary_address'))]">
					<cpty_inter_bank_addr>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/intermediary_address'))]"/>
					</cpty_inter_bank_addr>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/intermediary_address_2'))]">
					<cpty_inter_bank_addr_2>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/intermediary_address_2'))]"/>
					</cpty_inter_bank_addr_2>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/intermediary_city'))]">
					<cpty_inter_city_state>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/intermediary_city'))]"/>
					</cpty_inter_city_state>
				</xsl:if>
				<xsl:if test="bank_payment/additionalBankInstructions/intermediary_country_code">
					<cpty_inter_country>
						<xsl:value-of select="bank_payment/additionalBankInstructions/intermediary_country_code"/>
					</cpty_inter_country>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/inter_bank_clrc'))]">
					<cpty_inter_bank_clrc>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/inter_bank_clrc'))]"/>
					</cpty_inter_bank_clrc>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/intermediary_bank_account_number'))]"> <!-- intermediary account -->
					<cpty_inter_routing_no>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/intermediary_bank_account_number'))]"/>
					</cpty_inter_routing_no>
				</xsl:if>				
				
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/routing_instructions_1'))]">
					<cpty_special_routing_1>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/routing_instructions_1'))]"/>
					</cpty_special_routing_1>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/routing_instructions_2'))]">
					<cpty_special_routing_2>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/routing_instructions_2'))]"/>
					</cpty_special_routing_2>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/routing_instructions_3'))]">
					<cpty_special_routing_3>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/routing_instructions_3'))]"/>
					</cpty_special_routing_3>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/routing_instructions_4'))]">
					<cpty_special_routing_4>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/routing_instructions_4'))]"/>
					</cpty_special_routing_4>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/routing_instructions_5'))]">
					<cpty_special_routing_5>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/routing_instructions_5'))]"/>
					</cpty_special_routing_5>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/routing_instructions_6'))]">
					<cpty_special_routing_6>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/routing_instructions_6'))]"/>
					</cpty_special_routing_6>
				</xsl:if>
				
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/payment_details_1'))]">
					<cpty_payment_detail_1>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/payment_details_1'))]"/>
					</cpty_payment_detail_1>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/payment_details_2'))]">
					<cpty_payment_detail_2>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/payment_details_2'))]"/>
					</cpty_payment_detail_2>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/payment_details_3'))]">
					<cpty_payment_detail_3>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/payment_details_3'))]"/>
					</cpty_payment_detail_3>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/payment_details_4'))]">
					<cpty_payment_detail_4>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/payment_details_4'))]"/>
					</cpty_payment_detail_4>
				</xsl:if>
				
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/ordering_cust_name'))]">
					<cpty_order_cust_name>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/ordering_cust_name'))]"/>
					</cpty_order_cust_name>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/ordering_cust_account'))]">
					<cpty_order_account_no>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/ordering_cust_account'))]"/>
					</cpty_order_account_no>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/ordering_cust_address'))]">
					<cpty_order_cust_addr>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/ordering_cust_address'))]"/>
					</cpty_order_cust_addr>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/ordering_cust_address_2'))]">
					<cpty_order_cust_addr_2>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/ordering_cust_address_2'))]"/>
					</cpty_order_cust_addr_2>
				</xsl:if>
				<xsl:if test="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/ordering_cust_citystate'))]">
					<cpty_order_cust_city>
						<xsl:value-of select="//*[starts-with(name(), concat($prefix_name,'bank_payment/additionalBankInstructions/ordering_cust_citystate'))]"/>
					</cpty_order_cust_city>
				</xsl:if>
				<xsl:if test="bank_payment/additionalBankInstructions/ordering_cust_country">
					<cpty_order_cust_country>
						<xsl:value-of select="bank_payment/additionalBankInstructions/ordering_cust_country"/>
					</cpty_order_cust_country>
				</xsl:if>
				<xsl:if test="bank_payment/additionalBankInstructions/order_details_clrc">
					<cpty_order_details_clrc>
						<xsl:value-of select="bank_payment/additionalBankInstructions/order_details_clrc"/>
					</cpty_order_details_clrc>
				</xsl:if>
	</xsl:template>
	
	<xsl:template name="prefix-customer-payment">		
		<xsl:param name="prefix"/>
				<xsl:variable name="prefix_name">
					<xsl:choose>
						<xsl:when test="$prefix">
							<xsl:value-of select="concat($prefix,'_')"/>
						</xsl:when>
					</xsl:choose>
				</xsl:variable>	
				
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="concat($prefix_name,'customer_payment/instruction_indicator')">
					<cpty_instruction_indicator>
						<xsl:value-of select="concat($prefix_name,'customer_payment/instruction_indicator')"/>
					</cpty_instruction_indicator>
				</xsl:if>
				<xsl:if test="concat($prefix_name,'customer_payment/currency')">
					<counterparty_cur_code>
						<xsl:value-of select="concat($prefix_name,'customer_payment/currency')"/>
					</counterparty_cur_code>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="concat($prefix_name,'customer_payment/account') != ''">
						<counterparty_act_no>
							<xsl:value-of select="concat($prefix_name,'customer_payment/account')"/>
						</counterparty_act_no>
					</xsl:when>
					<xsl:otherwise>
						<!-- either counterparty_act_no or counterparty_name is needed to be a valid counterparty, use indicator for name if no account id exists -->
						<xsl:if test="concat($prefix_name,'customer_payment/instruction_indicator')">
							<counterparty_name>
								<xsl:value-of select="concat($prefix_name,'customer_payment/instruction_indicator')"/>
							</counterparty_name>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
	</xsl:template>
	
	<xsl:template name="customer-payment">		
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="customer_payment/instruction_indicator">
					<cpty_instruction_indicator>
						<xsl:value-of select="customer_payment/instruction_indicator"/>
					</cpty_instruction_indicator>
				</xsl:if>
				<xsl:if test="customer_payment/currency">
					<counterparty_cur_code>
						<xsl:value-of select="customer_payment/currency"/>
					</counterparty_cur_code>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="customer_payment/account != ''">
						<counterparty_act_no>
							<xsl:value-of select="customer_payment/account"/>
						</counterparty_act_no>
					</xsl:when>
					<xsl:otherwise>
						<!-- either counterparty_act_no or counterparty_name is needed to be a valid counterparty, use indicator for name if no account id exists -->
						<xsl:if test="customer_payment/instruction_indicator">
							<counterparty_name>
								<xsl:value-of select="customer_payment/instruction_indicator"/>
							</counterparty_name>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
	</xsl:template>
	
	<xsl:template name="incoming-customer-payment">		
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				
				<xsl:if test="settlement_cust_smeans">
					<settlement_mean>
						<xsl:value-of select="settlement_cust_smeans"/>
					</settlement_mean>
				</xsl:if>
				
				<xsl:if test="settlement_cust_cur_code">
					<counterparty_cur_code>
						<xsl:value-of select="settlement_cust_cur_code"/>
					</counterparty_cur_code>
				</xsl:if>
				
				<xsl:if test="settlement_cust_account">
					<counterparty_act_no>
						<xsl:value-of select="settlement_cust_account"/>
					</counterparty_act_no>
				</xsl:if>
				<!-- either counterparty_act_no or counterparty_name is needed to be a valid counterparty, use indicator for name if no account id exists -->
				<!--changing as counterparty_name is required in draft mode to retrieve counterparty details in portal  -->
				<xsl:if test="settlement_cust_ref">
					<counterparty_name>
						<xsl:value-of select="settlement_cust_ref"/>
					</counterparty_name>
				</xsl:if>
					
	</xsl:template>
	
	<!-- Customer Payment created from a local DDA account -->
	<xsl:template name="dda-customer-payment">		
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:if test="brch_code">
					<brch_code>
						<xsl:value-of select="brch_code"/>
					</brch_code>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="cust_settlement_mean">
					<settlement_mean>
						<xsl:value-of select="cust_settlement_mean"/>
					</settlement_mean>
				</xsl:if>
				<xsl:if test="cust_settlement_account">
					<settlement_account>
						<xsl:value-of select="cust_settlement_account"/>
					</settlement_account>
				</xsl:if>
				<xsl:if test="cust_payment_cur_code">
					<counterparty_cur_code>
						<xsl:value-of select="cust_payment_cur_code"/>
					</counterparty_cur_code>
				</xsl:if>
				<!-- <xsl:if test="tnx_cur_code">
					<counterparty_cur_code>
						<xsl:value-of select="tnx_cur_code"/>
					</counterparty_cur_code>
				</xsl:if> -->
				<xsl:if test="cust_payment_account_act_no != ''">
					<counterparty_act_no>
						<xsl:value-of select="cust_payment_account_act_no"/>
					</counterparty_act_no>
				</xsl:if>
				<xsl:if test="cust_payment_account_act_name != ''">
					<counterparty_name>
						<xsl:value-of select="cust_payment_account_act_name"/>
					</counterparty_name>
				</xsl:if>
	</xsl:template>
	
	<xsl:template name="near-customer-payment">		
			<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
			<xsl:if test="brch_code">
				<brch_code>
					<xsl:value-of select="brch_code"/>
				</brch_code>
			</xsl:if>
			<xsl:if test="company_id">
				<company_id>
					<xsl:value-of select="company_id"/>
				</company_id>
			</xsl:if>
			<xsl:if test="near_customer_payment/instruction_indicator">
				<cpty_instruction_indicator>
					<xsl:value-of select="near_customer_payment/instruction_indicator"/>
				</cpty_instruction_indicator>
			</xsl:if>
			<xsl:if test="near_customer_payment/currency">
				<counterparty_cur_code>
					<xsl:value-of select="near_customer_payment/currency"/>
				</counterparty_cur_code>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="near_customer_payment/account != ''">
					<counterparty_act_no>
						<xsl:value-of select="near_customer_payment/account"/>
					</counterparty_act_no>
				</xsl:when>
				<xsl:otherwise>
					<!-- either counterparty_act_no or counterparty_name is needed to be a valid counterparty, use indicator for name if no account id exists -->
					<xsl:if test="near_customer_payment/instruction_indicator">
						<counterparty_name>
							<xsl:value-of select="near_customer_payment/instruction_indicator"/>
						</counterparty_name>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
	</xsl:template>


	<xsl:template name="far-customer-payment">		
			<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
			<xsl:if test="brch_code">
				<brch_code>
					<xsl:value-of select="brch_code"/>
				</brch_code>
			</xsl:if>
			<xsl:if test="company_id">
				<company_id>
					<xsl:value-of select="company_id"/>
				</company_id>
			</xsl:if>
			<xsl:if test="far_customer_payment/instruction_indicator">
				<cpty_instruction_indicator>
					<xsl:value-of select="far_customer_payment/instruction_indicator"/>
				</cpty_instruction_indicator>
			</xsl:if>
			<xsl:if test="far_customer_payment/currency">
				<counterparty_cur_code>
					<xsl:value-of select="far_customer_payment/currency"/>
				</counterparty_cur_code>
			</xsl:if>
			<xsl:choose>
				<xsl:when test="far_customer_payment/account != ''">
					<counterparty_act_no>
						<xsl:value-of select="far_customer_payment/account"/>
					</counterparty_act_no>
				</xsl:when>
				<xsl:otherwise>
					<!-- either counterparty_act_no or counterparty_name is needed to be a valid counterparty, use indicator for name if no account id exists -->
					<xsl:if test="far_customer_payment/instruction_indicator">
						<counterparty_name>
							<xsl:value-of select="far_customer_payment/instruction_indicator"/>
						</counterparty_name>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
	</xsl:template>

</xsl:stylesheet>