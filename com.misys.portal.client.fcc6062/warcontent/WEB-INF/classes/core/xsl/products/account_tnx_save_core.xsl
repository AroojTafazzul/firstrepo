<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	exclude-result-prefixes="defaultresource">
	<!-- Copyright (c) 2000-2001 NEOMAlogic (http://www.neomalogic.com), All 
		Rights Reserved. -->
	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>
	<!-- Process ACCOUNT -->
	<xsl:template match="static_account">
		<result>
			<com.misys.portal.systemfeatures.common.StaticAccountTnx>
				<!-- keys must be attributes -->
				<xsl:attribute name="account_id"><xsl:value-of select="account_id" /></xsl:attribute>
				<brch_code>
					<xsl:value-of select="brch_code" />
				</brch_code>
				<company_id>
					<xsl:value-of select="company_id" />
				</company_id>
				<entity>
					<xsl:value-of select="entity" />
				</entity>
				<xsl:choose>
					<xsl:when test="product_type and (product_type[.='IAFT'] or product_type[.='TPT'])  and account_no_iaft and account_no_iaft[.!='']">
						<account_no>
							<xsl:value-of select="account_no_iaft" />
						</account_no>					
					</xsl:when>
					<xsl:when test="product_type and product_type[.='MT202'] and account_no_mt202 and account_no_mt202[.!='']">
						<account_no>
							<xsl:value-of select="account_no_mt202" />
						</account_no>					
					</xsl:when>
					<xsl:otherwise>
						<account_no>
							<xsl:value-of select="account_no" />
						</account_no>
					</xsl:otherwise>
				</xsl:choose>
				<active_flag>
					<xsl:value-of select="active_flag" />
				</active_flag>
				<payee_ref>
					<xsl:value-of select="payee_ref" />
				</payee_ref>
				<cust_ref>
					<xsl:value-of select="cust_ref" />
				</cust_ref>
				<description>
					<xsl:value-of select="description" />
				</description>
				<account_type>
					<xsl:value-of select="account_type" />
				</account_type>
				<iso_code>
					<xsl:value-of select="iso_code" />
				</iso_code>
				<xsl:choose>
					<xsl:when test="product_type and product_type[.='MUPS'] and bank_ifsc_name and bank_ifsc_name[.!='']">
						<bank_name>
							<xsl:value-of select="bank_ifsc_name" />
						</bank_name>				
					</xsl:when>
					<xsl:otherwise>
						<bank_name>
							<xsl:value-of select="bank_name" />
						</bank_name>
					</xsl:otherwise>
				</xsl:choose>
				<cur_code>
					<xsl:value-of select="account_cur_code" />
				</cur_code>
						<counterparty_name>
							<xsl:value-of select="counterparty_name" />
						</counterparty_name>
				<counterparty_nickname>
					<xsl:value-of select="counterparty_nickname" />
				</counterparty_nickname>
				<company_name>
					<xsl:value-of select="company_name" />
				</company_name>
						<address_line_1>
							<xsl:value-of select="address_line_1" />
						</address_line_1>
						<address_line_2>
							<xsl:value-of select="address_line_2" />
						</address_line_2>
						<dom>
							<xsl:value-of select="dom" />
						</dom>
				<country>
					<xsl:value-of select="country" />
				</country>
				<xsl:if test="format">
					<format>
						<xsl:value-of select="format" />
					</format>
				</xsl:if>
				<counterparty_name_2>
					<xsl:value-of select="counterparty_name_2" />
				</counterparty_name_2>
				<counterparty_name_3>
					<xsl:value-of select="counterparty_name_3" />
				</counterparty_name_3>
				<xsl:choose>
					<xsl:when test="product_type and product_type[.='MUPS'] and bank_ifsc_address_line_1 and bank_ifsc_address_line_1[.!='']">
						<bank_address_line_1>
							<xsl:value-of select="bank_ifsc_address_line_1" />
						</bank_address_line_1>			
					</xsl:when>
					<xsl:otherwise>
						<bank_address_line_1>
							<xsl:value-of select="bank_address_line_1" />
						</bank_address_line_1>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="product_type and product_type[.='MUPS'] and bank_ifsc_address_line_2 and bank_ifsc_address_line_2[.!='']">
						<bank_address_line_2>
							<xsl:value-of select="bank_ifsc_address_line_2" />
						</bank_address_line_2>			
					</xsl:when>
					<xsl:otherwise>
						<bank_address_line_2>
							<xsl:value-of select="bank_address_line_2" />
						</bank_address_line_2>
					</xsl:otherwise>
				</xsl:choose>	
				<xsl:choose>
					<xsl:when test="product_type and product_type[.='MUPS'] and bank_ifsc_city and bank_ifsc_city[.!='']">
						<bank_dom>
							<xsl:value-of select="bank_ifsc_city" />
						</bank_dom>		
					</xsl:when>
					<xsl:otherwise>
						<bank_dom>
							<xsl:value-of select="bank_dom" />
						</bank_dom>
					</xsl:otherwise>
				</xsl:choose>	
				<bank_code>
					<xsl:value-of select="bank_code" />
				</bank_code>
				<xsl:choose>
					<xsl:when test="product_type and product_type[.='MEPS' or .='RTGS'] and bank_code_country and bank_code_country[.!='']">
						<bank_country>
							<xsl:value-of select="bank_code_country" />
						</bank_country>				
					</xsl:when>
					<xsl:otherwise>
						<bank_country>
							<xsl:value-of select="bank_country" />
						</bank_country>
					</xsl:otherwise>
				</xsl:choose>
				<branch_name>
					<xsl:value-of select="branch_name" />
				</branch_name>
				<branch_address_line_1>
					<xsl:value-of select="branch_address_line_1" />
				</branch_address_line_1>
				<branch_address_line_2>
					<xsl:value-of select="branch_address_line_2" />
				</branch_address_line_2>
				<branch_dom>
					<xsl:value-of select="branch_dom" />
				</branch_dom>
				<address_line_3>
					<xsl:value-of select="address_line_3" />
				</address_line_3>
				<return_comments>
					<xsl:value-of select="return_comments" />
				</return_comments>
				<product_type>
					<xsl:value-of select="product_type" />
				</product_type>
				<xsl:choose>
					<xsl:when test="product_type and product_type[.='MUPS'] and bank_ifsc_code and bank_ifsc_code[.!='']">
						<bank_iso_code>
							<xsl:value-of select="bank_ifsc_code" />
						</bank_iso_code>					
					</xsl:when>
					<xsl:when test="product_type and product_type[.='MEPS'] and bank_iso_code_meps and bank_iso_code_meps[.!='']">
						<bank_iso_code>
							<xsl:value-of select="bank_iso_code_meps" />
						</bank_iso_code>					
					</xsl:when>
					<xsl:when test="product_type and product_type[.='RTGS'] and bank_bic_code_rtgs and bank_bic_code_rtgs[.!='']">
						<bank_iso_code>
							<xsl:value-of select="bank_bic_code_rtgs" />
						</bank_iso_code>					
					</xsl:when>					
					<xsl:otherwise>
						<bank_iso_code>
							<xsl:value-of select="bank_iso_code" />
						</bank_iso_code>
					</xsl:otherwise>
				</xsl:choose>
				<!-- Addendum Fields -->
				<pre_approved>
					<xsl:value-of select="pre_approved" />
				</pre_approved>
				<threshold_cur_code>
					<xsl:value-of select="threshold_cur_code" />
				</threshold_cur_code>
				<threshold_amt>
					<xsl:value-of select="threshold_amt" />
				</threshold_amt>
				<email_1>
					<xsl:value-of select="email_1" />
				</email_1>
				<xsl:choose>
					<xsl:when test="product_type and product_type[.='MEPS'] and additional_email and additional_email[.!='']">
						<email_2>
							<xsl:value-of select="additional_email" />
						</email_2>				
					</xsl:when>
					<xsl:otherwise>
						<email_2>
							<xsl:value-of select="email_2" />
						</email_2>
					</xsl:otherwise>
				</xsl:choose>
				<beneficiary_id>
					<xsl:value-of select="beneficiary_id" />
				</beneficiary_id>
				<mailing_name>
					<xsl:value-of select="mailing_name" />
				</mailing_name>
				<mailing_address_line_1>
					<xsl:value-of select="mailing_address_line_1" />
				</mailing_address_line_1>
				<mailing_address_line_2>
					<xsl:value-of select="mailing_address_line_2" />
				</mailing_address_line_2>
				<mailing_address_line_3>
					<xsl:value-of select="mailing_address_line_3" />
				</mailing_address_line_3>
				<mailing_address_line_4>
					<xsl:value-of select="mailing_address_line_4" />
				</mailing_address_line_4>
				<mailing_address_line_5>
					<xsl:value-of select="mailing_address_line_5" />
				</mailing_address_line_5>
				<postal_code>
					<xsl:value-of select="postal_code" />
				</postal_code>
				<beneficiary_country>
					<xsl:value-of select="beneficiary_country" />
				</beneficiary_country>
				<xsl:choose>
					<xsl:when test="product_type and product_type[.='MEPS'] and additional_fax and additional_fax[.!='']">
						<fax>
							<xsl:value-of select="additional_fax" />
						</fax>				
					</xsl:when>
					<xsl:otherwise>
						<fax>
							<xsl:value-of select="fax" />
						</fax>
					</xsl:otherwise>
				</xsl:choose>
				<phone>
					<xsl:value-of select="phone" />
				</phone>
				<bene_details_postal_code>
					<xsl:value-of select="bene_details_postal_code" />
				</bene_details_postal_code>
				<xsl:choose>
					<xsl:when test="product_type and product_type[.='MEPS' or .='RTGS'] and bene_country and bene_country[.!='']">
						<bene_details_country>
							<xsl:value-of select="bene_country" />
						</bene_details_country>				
					</xsl:when>
					<xsl:otherwise>
						<bene_details_country>
							<xsl:value-of select="bene_details_country" />
						</bene_details_country>
					</xsl:otherwise>
				</xsl:choose>
				
		<!-- Fields for Treasury Beneficiaries -->
				
				<xsl:if test="bank_routing_no">
				<bank_routing_no>
					<xsl:value-of select="bank_routing_no" />
				</bank_routing_no>
				</xsl:if>
						<ordering_customer_name>
							<xsl:value-of select="ordering_customer_name" />
						</ordering_customer_name>	
						<ordering_customer_address_1>
							<xsl:value-of select="ordering_customer_address_1" />
						</ordering_customer_address_1>	
						<ordering_customer_dom>
							<xsl:value-of select="ordering_customer_dom" />
						</ordering_customer_dom>				
				<xsl:if test="ordering_customer_country">
				<ordering_customer_country>
					<xsl:value-of select="ordering_customer_country" />
				</ordering_customer_country>
				</xsl:if>
				<xsl:if test="ordering_customer_act_no">
				<ordering_customer_act_no>
					<xsl:value-of select="ordering_customer_act_no" />
				</ordering_customer_act_no>
				</xsl:if>
				<xsl:if test="swift_charges_type">
				<swift_charges_type>
					<xsl:value-of select="swift_charges_type" />
				</swift_charges_type>
				</xsl:if>
				<xsl:if test="inter_bank_swift">
				<inter_bank_swift>
					<xsl:value-of select="inter_bank_swift" />
				</inter_bank_swift>
				</xsl:if>
				<xsl:if test="inter_bank_name">
				<inter_bank_name>
					<xsl:value-of select="inter_bank_name" />
				</inter_bank_name>
				</xsl:if>
				<xsl:if test="inter_bank_address_1">	
				<inter_bank_address_1>
					<xsl:value-of select="inter_bank_address_1" />
				</inter_bank_address_1>
				</xsl:if>
				<xsl:if test="inter_bank_dom">
				<inter_bank_dom>
					<xsl:value-of select="inter_bank_dom" />
				</inter_bank_dom>
				</xsl:if>
				<xsl:if test="inter_bank_country">
				<inter_bank_country>
					<xsl:value-of select="inter_bank_country" />
				</inter_bank_country>
				</xsl:if>
				<xsl:if test="inter_bank_routing_no">
				<inter_bank_routing_no>
					<xsl:value-of select="inter_bank_routing_no" />
				</inter_bank_routing_no>
				</xsl:if>
				<xsl:if test="special_routing_1">
				<special_routing_1>
					<xsl:value-of select="special_routing_1" />
				</special_routing_1>
				</xsl:if>
				<xsl:if test="special_routing_2">
				<special_routing_2>
					<xsl:value-of select="special_routing_2" />
				</special_routing_2>
				</xsl:if>
				<xsl:if test="special_routing_3">
				<special_routing_3>
					<xsl:value-of select="special_routing_3" />
				</special_routing_3>
				</xsl:if>
				<xsl:if test="special_routing_4">
				<special_routing_4>
					<xsl:value-of select="special_routing_4" />
				</special_routing_4>
				</xsl:if>
				<xsl:if test="special_routing_5">
				<special_routing_5>
					<xsl:value-of select="special_routing_5" />
				</special_routing_5>
				</xsl:if>
				<xsl:if test="special_routing_6">
				<special_routing_6>
					<xsl:value-of select="special_routing_6" />
				</special_routing_6>
				</xsl:if>
				<xsl:if test="payment_detail_1">
				<payment_detail_1>
					<xsl:value-of select="payment_detail_1" />
				</payment_detail_1>
				</xsl:if>
				<xsl:if test="payment_detail_2">
				<payment_detail_2>
					<xsl:value-of select="payment_detail_2" />
				</payment_detail_2>
				</xsl:if>
				<xsl:if test="payment_detail_3">
				<payment_detail_3>
					<xsl:value-of select="payment_detail_3" />
				</payment_detail_3>
				</xsl:if>
				<xsl:if test="payment_detail_4">
				<payment_detail_4>
					<xsl:value-of select="payment_detail_4" />
				</payment_detail_4>
				</xsl:if>
				<xsl:if test="customer_bank">
					<customer_bank>
						<xsl:value-of select="customer_bank" />
					</customer_bank>
				</xsl:if>
				
				<!-- Fields for Multiple Accounts for Beneficiaries -->
				<xsl:if test="beneficiary_group_id">
					<beneficiary_group_id>
						<xsl:value-of select="beneficiary_group_id" />
					</beneficiary_group_id>
				</xsl:if>
				<xsl:if test="account_active_flag">
					<account_active_flag>
						<xsl:value-of select="account_active_flag" />
					</account_active_flag>
				</xsl:if>
				<xsl:if test="default_flag">
					<default_flag>
						<xsl:value-of select="default_flag" />
					</default_flag>
				</xsl:if>
				<!-- End of Fields for Multiple Accounts for Beneficiaries -->
				
				
				<!-- End of Fields for Treasury Beneficiaries -->
				<!-- Fields need to persist when the account type is IAFT for transaction purpose -->
				<xsl:if test="bo_account_id">
					<additional_field name="bo_account_id" type="string"
						scope="master">
						<xsl:value-of select="bo_account_id" />
					</additional_field>
				</xsl:if>
				<xsl:if test="bo_account_type">
					<additional_field name="bo_account_type" type="string"
						scope="master">
						<xsl:value-of select="bo_account_type" />
					</additional_field>
				</xsl:if>
				<xsl:if test="bo_account_currency">
					<additional_field name="bo_account_currency" type="string"
						scope="master">
						<xsl:value-of select="bo_account_currency" />
					</additional_field>
				</xsl:if>
				<xsl:if test="bo_branch_code">
					<additional_field name="bo_branch_code" type="string"
						scope="master">
						<xsl:value-of select="bo_branch_code" />
					</additional_field>
				</xsl:if>
				<xsl:if test="bo_product_type">
					<additional_field name="bo_product_type" type="string"
						scope="master">
						<xsl:value-of select="bo_product_type" />
					</additional_field>
				</xsl:if>
				
				<xsl:if test="bene_country">
					<additional_field name="bene_country" type="string"
						scope="master">
						<xsl:value-of select="bene_country" />
					</additional_field>
				</xsl:if>
				<xsl:if test="inter_bank_address_2">
					<additional_field name="inter_bank_address_2" type="string"
						scope="master">
						<xsl:value-of select="inter_bank_address_2" />
					</additional_field>
				</xsl:if>
				<xsl:if test="ordering_customer_address_2">
					<additional_field name="ordering_customer_address_2" type="string"
						scope="master">
						<xsl:value-of select="ordering_customer_address_2" />
					</additional_field>
				</xsl:if>				
				
				<xsl:if test="bene_details_clrc and product_type[.='TRSRYFXFT']">
					<additional_field name="bene_details_clrc" type="string"
						scope="master">
						<xsl:value-of select="bene_details_clrc" />
					</additional_field>
				</xsl:if>
				
				<xsl:if test="order_details_clrc and product_type[.='TRSRYFXFT']">
					<additional_field name="order_details_clrc" type="string"
						scope="master">
						<xsl:value-of select="order_details_clrc" />
					</additional_field>
				</xsl:if>
				
				<xsl:if test="beneficiary_bank_clrc and product_type[.='TRSRYFXFT']">
					<additional_field name="beneficiary_bank_clrc" type="string"
						scope="master">
						<xsl:value-of select="beneficiary_bank_clrc" />
					</additional_field>
				</xsl:if>
				
				<xsl:if test="inter_bank_clrc and product_type[.='TRSRYFXFT']">
					<additional_field name="inter_bank_clrc" type="string"
						scope="master">
						<xsl:value-of select="inter_bank_clrc" />
					</additional_field>
				</xsl:if>
				
				<xsl:choose>
					<xsl:when test="product_type and product_type[.='MEPS'] and intermediary_bank_meps_swift_bic_code">
						<additional_field name="intermediary_bank_swift_bic_code" type="string" scope="master">
							<xsl:value-of select="intermediary_bank_meps_swift_bic_code"/>
						</additional_field>
					</xsl:when>	
					<xsl:when test="product_type and product_type[.='RTGS'] and intermediary_bank_rtgs_swift_bic_code">
						<additional_field name="intermediary_bank_swift_bic_code" type="string" scope="master">
							<xsl:value-of select="intermediary_bank_rtgs_swift_bic_code"/>
						</additional_field>
					</xsl:when>								
					<xsl:when test="intermediary_bank_swift_bic_code">
						<additional_field name="intermediary_bank_swift_bic_code" type="string" scope="master">
							<xsl:value-of select="intermediary_bank_swift_bic_code"/>
						</additional_field>
					</xsl:when>
				</xsl:choose>
				
				<xsl:choose>
					<xsl:when test="product_type and product_type[.='MEPS'] and intermediary_bank_meps_name">
						<additional_field name="intermediary_bank_name" type="string" scope="master">
							<xsl:value-of select="intermediary_bank_meps_name"/>
						</additional_field>
					</xsl:when>	
					<xsl:when test="product_type and product_type[.='RTGS'] and intermediary_bank_rtgs_name">
						<additional_field name="intermediary_bank_name" type="string" scope="master">
							<xsl:value-of select="intermediary_bank_rtgs_name"/>
						</additional_field>
					</xsl:when>								
					<xsl:when test="intermediary_bank_name">
						<additional_field name="intermediary_bank_name" type="string" scope="master">
							<xsl:value-of select="intermediary_bank_name"/>
						</additional_field>
					</xsl:when>
				</xsl:choose>
				
				<xsl:choose>
					<xsl:when test="product_type and product_type[.='MEPS'] and intermediary_bank_meps_address_line_1">
						<additional_field name="intermediary_bank_address_line_1" type="string" scope="master">
							<xsl:value-of select="intermediary_bank_meps_address_line_1"/>
						</additional_field>
					</xsl:when>	
					<xsl:when test="product_type and product_type[.='RTGS'] and intermediary_bank_rtgs_address_line_1">
						<additional_field name="intermediary_bank_address_line_1" type="string" scope="master">
							<xsl:value-of select="intermediary_bank_rtgs_address_line_1"/>
						</additional_field>
					</xsl:when>								
					<xsl:when test="intermediary_bank_address_line_1">
						<additional_field name="intermediary_bank_address_line_1" type="string" scope="master">
							<xsl:value-of select="intermediary_bank_address_line_1"/>
						</additional_field>
					</xsl:when>
				</xsl:choose>
				
				<xsl:choose>
					<xsl:when test="product_type and product_type[.='MEPS'] and intermediary_bank_meps_address_line_2">
						<additional_field name="intermediary_bank_address_line_2" type="string" scope="master">
							<xsl:value-of select="intermediary_bank_meps_address_line_2"/>
						</additional_field>
					</xsl:when>	
					<xsl:when test="product_type and product_type[.='RTGS'] and intermediary_bank_rtgs_address_line_2">
						<additional_field name="intermediary_bank_address_line_2" type="string" scope="master">
							<xsl:value-of select="intermediary_bank_rtgs_address_line_2"/>
						</additional_field>
					</xsl:when>								
					<xsl:when test="intermediary_bank_address_line_2">
						<additional_field name="intermediary_bank_address_line_2" type="string" scope="master">
							<xsl:value-of select="intermediary_bank_address_line_2"/>
						</additional_field>
					</xsl:when>
				</xsl:choose>
				
				<xsl:choose>
					<xsl:when test="product_type and product_type[.='MEPS'] and intermediary_bank_meps_dom">
						<additional_field name="intermediary_bank_dom" type="string" scope="master">
							<xsl:value-of select="intermediary_bank_meps_dom"/>
						</additional_field>
					</xsl:when>	
					<xsl:when test="product_type and product_type[.='RTGS'] and intermediary_bank_rtgs_dom">
						<additional_field name="intermediary_bank_dom" type="string" scope="master">
							<xsl:value-of select="intermediary_bank_rtgs_dom"/>
						</additional_field>
					</xsl:when>								
					<xsl:when test="intermediary_bank_dom">
						<additional_field name="intermediary_bank_dom" type="string" scope="master">
							<xsl:value-of select="intermediary_bank_dom"/>
						</additional_field>
					</xsl:when>
				</xsl:choose>
				
				<xsl:choose>
					<xsl:when test="product_type and product_type[.='MEPS'] and intermediary_bank_meps_country">
						<additional_field name="intermediary_bank_country" type="string" scope="master">
							<xsl:value-of select="intermediary_bank_meps_country"/>
						</additional_field>
					</xsl:when>	
					<xsl:when test="product_type and product_type[.='RTGS'] and intermediary_bank_rtgs_country">
						<additional_field name="intermediary_bank_country" type="string" scope="master">
							<xsl:value-of select="intermediary_bank_rtgs_country"/>
						</additional_field>
					</xsl:when>								
					<xsl:when test="intermediary_bank_country">
						<additional_field name="intermediary_bank_country" type="string" scope="master">
							<xsl:value-of select="intermediary_bank_country"/>
						</additional_field>
					</xsl:when>
				</xsl:choose>
				
				<xsl:if test="intermediary_bank_clearing_code">
					<additional_field name="intermediary_bank_clearing_code" type="string" scope="master">
						<xsl:value-of select="intermediary_bank_clearing_code"/>
					</additional_field>
				</xsl:if>
				<xsl:if test="intermediary_bank_clearing_code_desc">
					<additional_field name="intermediary_bank_clearing_code_desc" type="string" scope="master">
						<xsl:value-of select="intermediary_bank_clearing_code_desc"/>
					</additional_field>
				</xsl:if>
				 <xsl:if test="mailing_address">
		            <additional_field name="mailing_address" type="string" scope="master">
		                <xsl:value-of select="mailing_address" />
            		</additional_field>
       			</xsl:if>	

				<xsl:if test="bene_nra_flag">
					<additional_field name="bene_nra_flag" type="string" scope="master">
						<xsl:value-of select="bene_nra_flag" />
					</additional_field>
				</xsl:if>
				<xsl:if test="cnaps_bank_code">
		            <additional_field name="cnaps_bank_code" type="string" scope="master">
		                <xsl:value-of select="cnaps_bank_code" />
		            </additional_field>
		        </xsl:if>				
		
		        <xsl:if test="cnaps_bank_name">
		            <additional_field name="cnaps_bank_name" type="string" scope="master">
		                <xsl:value-of select="cnaps_bank_name" />
		            </additional_field>
		        </xsl:if>						
							
		        <xsl:if test="mailing_address">
		            <additional_field name="mailing_address" type="string" scope="master">
		                <xsl:value-of select="mailing_address" />
		            </additional_field>
		        </xsl:if>					

     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.systemfeatures.common.StaticAccountTnx>
		</result>
	</xsl:template>

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
