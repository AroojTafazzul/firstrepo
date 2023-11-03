<?xml version="1.0"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
				exclude-result-prefixes="utils">

	<!-- Get the parameters -->
	<xsl:include href="../../../core/xsl/products/product_params.xsl"/>
	
	<!-- Common elements to save among all products -->
	<xsl:include href="../../../core/xsl/products/save_common.xsl"/>
	
    <!-- TODO: Avengers work on this -->
	<!-- payment term -->
	<xsl:include href="../../../openaccount/xsl/products/po_save_common.xsl"/>
	
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="rp_tnx_record">	
		<result>
						
		<xsl:attribute name="ref_id"><xsl:value-of select="new_loan_ref_id" /></xsl:attribute>
		<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id" /></xsl:attribute>
		<xsl:for-each select="repricing_new_loans/ln_tnx_record">
				<com.misys.portal.product.ln.common.Loan>
				
				<xsl:if test="new_loan_ref_id">
							<ref_id>
								<xsl:value-of select="new_loan_ref_id"/>
							</ref_id>
				</xsl:if>
				
<!-- 				<xsl:if test="sub_tnx_type_code"> -->
					<sub_tnx_type_code>
						<xsl:value-of select="../../sub_tnx_type_code"/>
					</sub_tnx_type_code>
<!-- 				</xsl:if> -->					
					
					<brch_code>
						<xsl:value-of select="../../brch_code"/>
					</brch_code>

				
				
				<xsl:if test="new_loan_entity">
					<entity>
						<xsl:value-of select="new_loan_entity"/>
					</entity>
				</xsl:if>

				<xsl:if test="new_loan_ccy">
					<tnx_cur_code>
						<xsl:value-of select="new_loan_ccy"/>
					</tnx_cur_code>
				</xsl:if>				
								
				<!-- from Loan -->
				<xsl:if test="new_loan_facility_id">
					<bo_facility_id>
						<xsl:value-of select="new_loan_facility_id"/>
					</bo_facility_id>
				</xsl:if>
				<xsl:if test="new_loan_facility_name">
					<bo_facility_name>
						<xsl:value-of select="new_loan_facility_name"/>
					</bo_facility_name>
				</xsl:if>
				<xsl:if test="new_loan_deal_id">
					<bo_deal_id>
						<xsl:value-of select="new_loan_deal_id"/>
					</bo_deal_id>
				</xsl:if>
				<xsl:if test="new_loan_deal_name">
					<bo_deal_name>
						<xsl:value-of select="new_loan_deal_name"/>
					</bo_deal_name>
				</xsl:if>

<!-- 				<xsl:if test="fcn"> -->
					<fcn>
						<xsl:value-of select="../../fcn"/>
					</fcn>
<!-- 				</xsl:if> -->

				<xsl:if test="../../borrower_reference">
					<borrower_reference>
						<xsl:value-of select="utils:decryptApplicantReference(../../borrower_reference)"/>
					</borrower_reference>
				</xsl:if>				

				<xsl:if test="new_loan_effective_date">
					<effective_date>
						<xsl:value-of select="new_loan_effective_date"/>
					</effective_date>
				</xsl:if>
						
				<xsl:if test="new_loan_maturity_date">
					<ln_maturity_date>
						<xsl:value-of select="new_loan_maturity_date"/>
					</ln_maturity_date>
				</xsl:if>				
				<xsl:if test="new_loan_maturity_date">
					<maturity_date>
						<xsl:value-of select="new_loan_maturity_date"/>
					</maturity_date>
				</xsl:if>
				<xsl:if test="new_loan_ccy">
					<ln_cur_code>
						<xsl:value-of select="new_loan_ccy"/>
					</ln_cur_code>
				</xsl:if>
				<xsl:if test="new_loan_outstanding_amt">
					<ln_amt>
						<xsl:value-of select="new_loan_outstanding_amt"/>
					</ln_amt>
				</xsl:if>

				<xsl:if test="new_loan_repricing_riskType">
					<risk_type>
						<xsl:value-of select="new_loan_repricing_riskType"/>
					</risk_type>
				</xsl:if>

				<xsl:if test="new_loan_pricing_option">
					<pricing_option>
						<xsl:value-of select="new_loan_pricing_option"/>
					</pricing_option>
				</xsl:if>
				<xsl:if test="../../match_funding">
					<match_funding>
						<xsl:value-of select="../../match_funding"/>
					</match_funding>
				</xsl:if>

				<xsl:if test="new_loan_repricing_date">
					<repricing_date>
						<xsl:value-of select="new_loan_repricing_date"/>
					</repricing_date>
				</xsl:if>
				<xsl:if test="new_loan_repricing_frequency">
					<repricing_frequency>
						<xsl:value-of select="new_loan_repricing_frequency"/>
					</repricing_frequency>
				</xsl:if>
				
				<xsl:if test="../../company_id">
					<company_id>
						<xsl:value-of select="../../company_id"/>
					</company_id>
				</xsl:if>
				
				
<!-- 				Payement terms -->
<!-- 				<xsl:apply-templates select="payments/payment"> -->
<!-- 					<xsl:with-param name="brchCode" select="brch_code"/> -->
<!-- 					<xsl:with-param name="companyId" select="company_id"/> -->
<!-- 					<xsl:with-param name="refId" select="ref_id"/> -->
<!-- 					<xsl:with-param name="tnxId" select="tnx_id"/> -->
<!-- 					<xsl:with-param name="payment_terms_type" select="payment_terms_type"/> -->
<!-- 				</xsl:apply-templates> -->
				
			
					
				<!-- Security -->
				<xsl:if test="token">
					<additional_field name="token" type="string" scope="none" description="Security token">
						<xsl:value-of select="token"/>
					</additional_field>
				</xsl:if>
				     <!-- Custom additional fields -->
     			<xsl:call-template name="product-additional-fields"/>
				 </com.misys.portal.product.ln.common.Loan>	
			</xsl:for-each>
			
			<xsl:for-each select="linked_loans/loan_ref_id">
				<com.misys.portal.product.common.CrossReference>
					<ref_id><xsl:value-of select="../../ref_id"/></ref_id>
					<tnx_id><xsl:value-of select="../../tnx_id"/></tnx_id>
					<product_code>LN</product_code>
					<child_ref_id><xsl:value-of select="."/></child_ref_id>
					<child_product_code>LN</child_product_code>
					<type_code>09</type_code>
				</com.misys.portal.product.common.CrossReference>
			</xsl:for-each>
			
			
			<com.misys.portal.product.common.Bank role_code="01">
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
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
				<xsl:if test="issuing_bank_abbv_name">
					<abbv_name>
						<xsl:value-of select="issuing_bank_abbv_name"/>
					</abbv_name>
				</xsl:if>
				<xsl:if test="issuing_bank_name">
					<name>
						<xsl:value-of select="issuing_bank_name"/>
					</name>
				</xsl:if>
				<xsl:if test="issuing_bank_address_line_1">
					<address_line_1>
						<xsl:value-of select="issuing_bank_address_line_1"/>
					</address_line_1>
				</xsl:if>
				<xsl:if test="issuing_bank_address_line_2">
					<address_line_2>
						<xsl:value-of select="issuing_bank_address_line_2"/>
					</address_line_2>
				</xsl:if>
				<xsl:if test="issuing_bank_dom">
					<dom>
						<xsl:value-of select="issuing_bank_dom"/>
					</dom>
				</xsl:if>
				<xsl:if test="issuing_bank_iso_code">
					<iso_code>
						<xsl:value-of select="issuing_bank_iso_code"/>
					</iso_code>
				</xsl:if>
				<xsl:if test="issuing_bank_reference">
					<reference>
						<xsl:value-of select="issuing_bank_reference"/>
					</reference>
				</xsl:if>
			</com.misys.portal.product.common.Bank>
			
			
			
			
			
				<xsl:call-template name="AUTHENTICATION"/>
				<!-- collaboration -->
				<xsl:call-template name="collaboration" />
			
			
		</result>
	</xsl:template>
	


     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>
