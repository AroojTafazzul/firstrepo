<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
	version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	exclude-result-prefixes="localization utils">
	

	<xsl:template name="settlement-details">
		<xsl:call-template name="table_template">
			<xsl:with-param name="text">
   				<xsl:call-template name="title">
					<xsl:with-param name="text">
					<xsl:value-of
							select="localization:getGTPString($language, 'XSL_HEADER_SETTLEMENT_DETAILS')" />
					</xsl:with-param>
				</xsl:call-template>
				
				<xsl:apply-templates select="counterparties/counterparty" /> 
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>


<xsl:template match="counterparty">
<xsl:param name="product_type"/>
		<xsl:choose>
			<!-- customer -->	
			<xsl:when test="counterparty_type='03' and counterparty_cur_code[.!=''] ">
				<xsl:call-template name="subtitle">
					<xsl:with-param name="text">
						<xsl:value-of
								select="localization:getGTPString($language, 'XSL_SI_CUSTOMER_INSTRUCTION')" />
					</xsl:with-param>
				</xsl:call-template>
		
	   			<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_SI_CUSTOMER_INSTRUCTIONS_PAYMENT_CURRENCY')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
							<xsl:value-of
								select="counterparty_cur_code" />
						</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="counterparty_act_no[.!='']">	
					<xsl:call-template name="table_cell">
						<xsl:with-param name="left_text">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_SI_CUSTOMER_INSTRUCTIONS_PAYMENT_ACCOUNT')" />
						</xsl:with-param>
						<xsl:with-param name="right_text">
								<xsl:value-of
									select="counterparty_act_no" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:when>
		
		<!-- Bank -->	
			<xsl:when test="counterparty_type='04' and counterparty_cur_code[.!=''] and counterparty_name[.!='']">
				<xsl:call-template name="subtitle">
						<xsl:with-param name="text">
						<xsl:value-of
								select="localization:getGTPString($language, 'XSL_HEADER_BENEFICIARY_DETAILS')" />
						</xsl:with-param>
				<!-- <xsl:with-param name="text">
						<xsl:call-template name="beneficiary-fields" />
				</xsl:with-param> -->
				</xsl:call-template>
				
		
	<!-- settlement means -->
	<xsl:choose>
		<xsl:when test="settlement_mean !=''">	
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_SETTLEMENT_DETAILS_SETTLEMENT_MEANS')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:value-of
						select="settlement_mean" />
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
	</xsl:choose>

	<!-- settlement account -->	
	<xsl:choose>
		<xsl:when test="settlement_account !=''">	
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of
					select="localization:getGTPString($language, 'XSL_SETTLEMENT_DETAILS_SETTLEMENT_ACCOUNTNUMBER')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
				<xsl:value-of
					select="settlement_account" />
				</xsl:with-param>
			</xsl:call-template>
	</xsl:when>
	</xsl:choose>			
	
	<!-- beneficiary name number -->	
	<xsl:if test="counterparty_name !=''">	
	<xsl:choose>
	<xsl:when test="starts-with(counterparty_name,'/')">
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of
					select="localization:getGTPString($language, 'XSL_SETTLEMENT_DETAILS_SETTLEMENT_BENEFICIARY_DETAILS')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
				<xsl:value-of
					select="substring(counterparty_name,7)" />
				</xsl:with-param>
			</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of
					select="localization:getGTPString($language, 'XSL_SETTLEMENT_DETAILS_SETTLEMENT_BENEFICIARY_DETAILS')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
				<xsl:value-of
					select="counterparty_name" />
				</xsl:with-param>
			</xsl:call-template>
			</xsl:otherwise>
	</xsl:choose>
	</xsl:if>
	
	<!-- beneficiary address -->
	<xsl:choose>    
	    	 <xsl:when test="not(normalize-space(counterparty_address_line_1)) and not(normalize-space(counterparty_address_line_2)) and not(normalize-space(counterparty_dom))">
	         <!-- nothing to display -->
	    	 </xsl:when>
	    	 <xsl:otherwise>
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of
					select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_ADDRESS')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
						<xsl:choose>
							<xsl:when test="normalize-space(counterparty_address_line_1) != ''">
								<xsl:choose>
								<xsl:when test="starts-with(counterparty_address_line_1,'/')">
									<xsl:value-of select="substring(counterparty_address_line_1,7)"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="counterparty_address_line_1"/>
								</xsl:otherwise>
							</xsl:choose>								
							</xsl:when>
							<xsl:otherwise>&nbsp;<!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
						</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:if test="counterparty_address_line_2[.!='']">
			<xsl:call-template name="table_cell">
			<xsl:with-param name="left_text">
					<xsl:value-of
					select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_ADDRESS_2')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:choose>
						<xsl:when test="normalize-space(counterparty_address_line_2) != ''">
						<xsl:choose>
								<xsl:when test="starts-with(counterparty_address_line_2,'/')">
									<xsl:value-of select="substring(counterparty_address_line_2,7)"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="counterparty_address_line_2"/>
								</xsl:otherwise>
							</xsl:choose>
							</xsl:when>
							<xsl:otherwise>&nbsp;<!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
						</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
			<xsl:if test="counterparty_dom[.!='']">
			<xsl:call-template name="table_cell">
			<xsl:with-param name="left_text">
					<xsl:value-of
					select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_CITY')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:choose>
						<xsl:when test="normalize-space(counterparty_dom) != ''">
								<xsl:choose>
								<xsl:when test="starts-with(counterparty_dom,'/' )">
									<xsl:value-of select="substring(counterparty_dom,7)"/>
								</xsl:when>
								<xsl:otherwise>
								<xsl:value-of select="counterparty_dom"/>
								</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>&nbsp;<!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
						</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
			<xsl:if test="counterparty_country[.!='']">
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of
						select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_COUNTRY')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:choose>
							<xsl:when test="normalize-space(counterparty_country) != ''">
									<xsl:value-of select="counterparty_country"/>
							</xsl:when>
							<xsl:otherwise>&nbsp;<!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
							</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>			
			<xsl:if test="cpty_bene_details_clrc[.!='']">
			<xsl:call-template name="table_cell">
			<xsl:with-param name="left_text">
					<xsl:value-of
					select="localization:getGTPString($language, 'XSL_CLEARING_CODE')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:choose>
						<xsl:when test="normalize-space(cpty_bene_details_clrc) != ''">
						<xsl:choose>
						<xsl:when test="starts-with(cpty_bene_details_clrc,'/') and utils:getDescFromClearingCode(substring(cpty_bene_details_clrc,7),$rundata)!=''">
								<xsl:value-of select="utils:getDescFromClearingCode(substring(cpty_bene_details_clrc,7),$rundata)"/>
						</xsl:when>
						<xsl:when test="starts-with(cpty_bene_details_clrc,'/')">
								<xsl:value-of select="substring(cpty_bene_details_clrc,7)"/>
						</xsl:when>
						<xsl:otherwise>
								<xsl:value-of select="utils:getDescFromClearingCode(cpty_bene_details_clrc,$rundata)"/>
						</xsl:otherwise>
						</xsl:choose>
							</xsl:when>
							<xsl:otherwise>&nbsp;<!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
						</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
		</xsl:otherwise>
	</xsl:choose>
				
	<!-- beneficiary account number -->	
	<xsl:choose>
		<xsl:when test="counterparty_act_no !=''">	
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of
					select="localization:getGTPString($language, 'XSL_SETTLEMENT_DETAILS_BENEFICIARY_ACCOUNT')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
				<xsl:value-of
					select="counterparty_act_no" />
				</xsl:with-param>
			</xsl:call-template>
	</xsl:when>
	</xsl:choose>
	
	<!-- bank BIC/SWIFT code -->
	<xsl:choose>
		<xsl:when test="cpty_bank_swift_bic_code !=''">	
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of
					select="localization:getGTPString($language, 'XSL_SETTLEMENT_DETAILS_BENEFICIARY_BANK_BIC_CODE_SWIFT')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
				<xsl:value-of
					select="cpty_bank_swift_bic_code" />
				</xsl:with-param>
			</xsl:call-template>
	</xsl:when>
	</xsl:choose>
	
	<!-- bank BIC/SWIFT code -->
	<xsl:choose>
		<xsl:when test="cpty_bank_name !='' and starts-with(cpty_bank_name,'/')">	
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of
					select="localization:getGTPString($language, 'XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_BANK')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
				<xsl:value-of
					select="substring(cpty_bank_name,7)" />
				</xsl:with-param>
			</xsl:call-template>
	</xsl:when>
	<xsl:otherwise>
	<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of
					select="localization:getGTPString($language, 'XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_BANK')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
				<xsl:value-of
					select="cpty_bank_name" />
				</xsl:with-param>
			</xsl:call-template>
	</xsl:otherwise>
	</xsl:choose>
	
	<!-- bank branch name -->
	<xsl:choose>
		<xsl:when test="cpty_branch_name !=''">	
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BANK_BRANCH')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
				<xsl:choose>
				<xsl:when test="starts-with(cpty_branch_name,'/')">
					<xsl:value-of select="substring(cpty_branch_name,7)" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="cpty_branch_name" />
				</xsl:otherwise>
				</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
	</xsl:when>
	</xsl:choose>
		
		<xsl:if test="cpty_branch_address_line_1 !=''">
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BANK_ADRESS')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
				<xsl:choose>
				<xsl:when test="starts-with(cpty_branch_address_line_1,'/')">
				<xsl:value-of select="substring(cpty_branch_address_line_1,7)" />
				</xsl:when>
				<xsl:otherwise>
				<xsl:value-of select="cpty_branch_address_line_1" />
				</xsl:otherwise>
				</xsl:choose>
				
				</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
			<xsl:if test="cpty_branch_address_line_2[.!='']">	
			<xsl:call-template name="table_cell">
			<xsl:with-param name="left_text">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BANK_CITY')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:choose>
						<xsl:when test="normalize-space(cpty_branch_address_line_2) != ''">
								<xsl:choose>
										<xsl:when test="starts-with(cpty_branch_address_line_2,'/')">
											<xsl:value-of select="substring(cpty_branch_address_line_2,7)" />
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="cpty_branch_address_line_2" />
										</xsl:otherwise>
										</xsl:choose>
							</xsl:when>
							<xsl:otherwise>&nbsp;<!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
						</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
			<xsl:if test="cpty_bank_dom !=''">	
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of
					select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BANK_CITY')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
						<xsl:choose>
							<xsl:when test="normalize-space(cpty_bank_dom) != ''">
								<xsl:choose>
										<xsl:when test="starts-with(cpty_bank_dom,'/')">
											<xsl:value-of select="substring(cpty_bank_dom,7)" />
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="cpty_bank_dom" />
										</xsl:otherwise>
								</xsl:choose>
							</xsl:when>
							<xsl:otherwise>&nbsp;<!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
						</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
			
			<xsl:if test="cpty_bank_country[.!='']">	
			<xsl:call-template name="table_cell">
			<xsl:with-param name="left_text">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BANK_COUNTRY')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:choose>
						<xsl:when test="normalize-space(cpty_bank_country) != ''">
								<xsl:value-of select="cpty_bank_country"/>
							</xsl:when>
							<xsl:otherwise>&nbsp;<!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
						</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
			
			<xsl:if test="cpty_beneficiary_bank_clrc[.!='']">	
			<xsl:call-template name="table_cell">
			<xsl:with-param name="left_text">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_CLEARING_CODE')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:choose>
						<xsl:when test="normalize-space(cpty_beneficiary_bank_clrc) != ''">
								<xsl:choose>
										<xsl:when test="starts-with(cpty_beneficiary_bank_clrc,'/') and utils:getDescFromClearingCode(substring(cpty_beneficiary_bank_clrc,7),$rundata)!=''">
												<xsl:value-of select="utils:getDescFromClearingCode(substring(cpty_beneficiary_bank_clrc,7),$rundata)"/>
										</xsl:when>
										<xsl:when test="starts-with(cpty_beneficiary_bank_clrc,'/')">
												<xsl:value-of select="substring(cpty_beneficiary_bank_clrc,7)"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="utils:getDescFromClearingCode(cpty_beneficiary_bank_clrc,$rundata)" />
										</xsl:otherwise>
										</xsl:choose>
							</xsl:when>
							<xsl:otherwise>&nbsp;<!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
						</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
	
	
	<!-- bank routing number -->
	<xsl:choose>
		<xsl:when test="cpty_benif_bank_routing_no !=''">	
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of
					select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BANK_NUMBER')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
				<xsl:value-of
					select="cpty_benif_bank_routing_no" />
				</xsl:with-param>
			</xsl:call-template>
	</xsl:when>
	</xsl:choose>
	
	<!-- ordering customer account number -->
	<xsl:choose>
		<xsl:when test="cpty_order_act_no !=''">	
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of
					select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INSTRUCTIONS_ORDERING_ACCOUNT_NO')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
				<xsl:value-of
					select="cpty_order_act_no" />
				</xsl:with-param>
			</xsl:call-template>
	</xsl:when>
	</xsl:choose>
		<xsl:choose>
		<xsl:when test="cpty_order_cust_name !=''">	
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of
					select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INSTRUCTIONS_ORDERING_CUST_NAME')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
				<xsl:choose>
				<xsl:when test="starts-with(cpty_order_cust_name,'/')">
				<xsl:value-of select="substring(cpty_order_cust_name,7)" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="cpty_order_cust_name" />
				</xsl:otherwise>
				</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
	</xsl:when>
	</xsl:choose>
	<xsl:choose>
		<xsl:when test="cpty_order_cust_addr!=''">	
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of
					select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INSTRUCTIONS_ORDERING_CUST_ADDRESS')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
				<xsl:choose>
				<xsl:when test="starts-with(cpty_order_cust_addr,'/')">
				<xsl:value-of select="substring(cpty_order_cust_addr,7)" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="cpty_order_cust_addr" />
				</xsl:otherwise>
				</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			
			<xsl:if test="cpty_order_cust_addr_2 !=''">
			<xsl:call-template name="table_cell">
			<xsl:with-param name="left_text">
				<xsl:value-of
					select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INSTRUCTIONS_ORDERING_CUST_ADDRESS_2')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
						<xsl:choose>
							<xsl:when test="normalize-space(cpty_order_cust_addr_2) != ''">
							<xsl:choose>
								<xsl:when test="starts-with(cpty_order_cust_addr_2,'/')">
									<xsl:value-of select="substring(cpty_order_cust_addr_2,7)"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="cpty_order_cust_addr_2"/>
								</xsl:otherwise>
							</xsl:choose>
														
							</xsl:when>
							<xsl:otherwise>&nbsp;<!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
						</xsl:choose>
				</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
			
			<xsl:if test="cpty_order_cust_city !=''">		
			<xsl:call-template name="table_cell">
			<xsl:with-param name="left_text">
					<xsl:value-of
					select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INSTRUCTIONS_ORDERING_CUST_CITYSTATE')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:choose>
						<xsl:when test="normalize-space(cpty_order_cust_city) != ''">
								<xsl:choose>
								<xsl:when test="starts-with(cpty_order_cust_city,'/')">
									<xsl:value-of select="substring(cpty_order_cust_city,7)"/>
								</xsl:when>
								<xsl:otherwise>               
									<xsl:value-of select="cpty_order_cust_city"/>
								</xsl:otherwise>
							</xsl:choose>
							</xsl:when>
							<xsl:otherwise>
								&nbsp;<!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not -->
							</xsl:otherwise>
						</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
			<xsl:call-template name="table_cell">
			<xsl:with-param name="left_text">
					<xsl:value-of
					select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INSTRUCTIONS_ORDERING_CUST_COUNTRY')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:choose>
						<xsl:when test="normalize-space(cpty_order_cust_country) != ''">
							<xsl:choose>
							<xsl:when test="starts-with(cpty_order_cust_country,'/')">
								<xsl:value-of select="substring(cpty_order_cust_country,7)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="cpty_order_cust_country"/>
							</xsl:otherwise>
							</xsl:choose>
							</xsl:when>
							<xsl:otherwise>&nbsp;<!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
						</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
	</xsl:when>
	</xsl:choose>

	<xsl:if test="cpty_order_details_clrc[.!='']">
	<xsl:call-template name="table_cell">
			<xsl:with-param name="left_text">
				<xsl:value-of
					select="localization:getGTPString($language, 'XSL_CLEARING_CODE')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
						<xsl:choose>
							<xsl:when test="normalize-space(cpty_order_details_clrc) != ''">
							<xsl:choose>
								<xsl:when test="starts-with(cpty_order_details_clrc,'/') and utils:getDescFromClearingCode(substring(cpty_order_details_clrc,7),$rundata)!=''">
										<xsl:value-of select="utils:getDescFromClearingCode(substring(cpty_order_details_clrc,7),$rundata)"/>
								</xsl:when>
								<xsl:when test="starts-with(cpty_order_details_clrc,'/')">
										<xsl:value-of select="substring(cpty_order_details_clrc,7)"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="utils:getDescFromClearingCode(cpty_order_details_clrc,$rundata)"/>
								</xsl:otherwise>
							</xsl:choose>								
							</xsl:when>
							<xsl:otherwise>&nbsp;<!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
						</xsl:choose>
				</xsl:with-param>
	</xsl:call-template>
	</xsl:if>
	
	<xsl:choose>
		<xsl:when test="cpty_order_account_no !=''">	
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of
					select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INSTRUCTIONS_ORDERING_ACCOUNT_NO')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
				<xsl:value-of
					select="cpty_order_account_no" />
				</xsl:with-param>
			</xsl:call-template>
			</xsl:when>
	</xsl:choose>
	
	<!-- swift charge -->
	<xsl:choose>
		<xsl:when test="cpty_swift_charges_paid !=''">	
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of
					select="localization:getGTPString($language, 'XSL_FT_DEAL_SUMMARY_LABEL_SWIFT_CHARGES_TYPE')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:value-of select="localization:getDecode($language,'N017',cpty_swift_charges_paid)"/>
				</xsl:with-param>
			</xsl:call-template>
	</xsl:when>
	</xsl:choose>
	
	<!-- End of beneficiary-fields -->
			
	<!--                                          -->
	<!-- Start free format settlement additional fields -->
	<!--                                          -->			
	<!-- <xsl:choose>
		<xsl:when test="not(normalize-space(cpty_inter_swift_bic_code)) and not(normalize-space(cpty_inter_bank_name)) and not(normalize-space(cpty_inter_bank_addr)) and not(normalize-space(cpty_inter_city_state)) and not(normalize-space(cpty_inter_country)) and
		not(normalize-space(cpty_inter_routing_no)) and not(normalize-space(cpty_inter_routing_1)) and not(normalize-space(cpty_inter_routing_2)) and not(normalize-space(cpty_inter_routing_3))  
		and normalize-space(cpty_inter_routing_4) and normalize-space(cpty_inter_routing_5) and normalize-space(cpty_inter_routing_6)"> 	
			 -->
			 
<xsl:choose>
		<!-- <xsl:when test="normalize-space(cpty_inter_swift_bic_code) !='' or normalize-space(cpty_inter_bank_name) !='' or 
		normalize-space(cpty_inter_bank_addr) !='' or normalize-space(cpty_inter_city_state) !='' or normalize-space(cpty_inter_country) !='' or 
		normalize-space(cpty_inter_routing_no) !='' or normalize-space(cpty_special_routing_1) !='' or normalize-space(cpty_special_routing_2) !='' or 
		normalize-space(cpty_inter_routing_3) !='' or normalize-space(cpty_inter_routing_4) !='' or normalize-space(cpty_inter_routing_5) !='' or 
		normalize-space(cpty_inter_routing_6) !=''">  -->	
		
	<xsl:when test="(cpty_inter_swift_bic_code[.!='']) 
		or (cpty_inter_bank_name[.!=''])
	 	or (cpty_inter_bank_addr[.!=''])
	 	or (cpty_inter_bank_addr_2[.!=''])
	 	or (cpty_inter_city_state[.!=''])
	 	or (cpty_inter_country[.!=''])
	 	or (cpty_inter_bank_clrc[.!=''])
	 	or starts-with(cpty_inter_routing_no, '/')
	 	or (cpty_inter_routing_no[.!=''])
	 	or (cpty_special_routing_1[.!=''])
	 	or (cpty_special_routing_2[.!=''])
	 	or (cpty_special_routing_3[.!=''])
	 	or (cpty_special_routing_4[.!=''])
	 	or (cpty_special_routing_5[.!=''])
	 	or (cpty_special_routing_6[.!=''])">
	 	
		<xsl:call-template name="subtitle">
		
			<xsl:with-param name="text">
				<xsl:value-of
								select="localization:getGTPString($language, 'XSL_SI_ADDITIONAL_INSTRUCTIONS_TAB_LABEL')" />
				</xsl:with-param>
				<!-- <xsl:with-param name="text">
						<xsl:call-template name="settlement-additional-fields" />
				</xsl:with-param> -->
		</xsl:call-template>
		
		<!-- intermediary bank BIC/SWIFT code -->
		<xsl:choose>
			<xsl:when test="cpty_inter_swift_bic_code !=''">	
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK_BIC')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
						<xsl:value-of
							select="cpty_inter_swift_bic_code" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
		
		<!-- intermediary bank name -->
		<xsl:choose>
			<xsl:when test="cpty_inter_bank_name !=''">	
				<xsl:call-template name="table_cell">
					<xsl:with-param name="left_text">
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK')" />
					</xsl:with-param>
					<xsl:with-param name="right_text">
					<xsl:choose>
					<xsl:when test="starts-with(cpty_inter_bank_name,'/')">
					<xsl:value-of select="substring(cpty_inter_bank_name,7)" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="cpty_inter_bank_name" />
					</xsl:otherwise>
					</xsl:choose>
						
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
		</xsl:choose>
	<!-- beneficiary address -->
	<xsl:choose>    
	    	 <xsl:when test="not(normalize-space(cpty_inter_bank_addr)) and not(normalize-space(cpty_inter_city_state)) and not(normalize-space(cpty_inter_country))">
	         <!-- nothing to display -->
	    	 </xsl:when>
	    	 <xsl:otherwise> 
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of
					select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK_STREET')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
						<xsl:choose>
							<xsl:when test="normalize-space(cpty_inter_bank_addr) != ''">
							<xsl:choose>
									<xsl:when test="starts-with(cpty_inter_bank_addr,'/')">
									<xsl:value-of select="substring(cpty_inter_bank_addr,7)"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="cpty_inter_bank_addr" />
									</xsl:otherwise>
									</xsl:choose>
								
							</xsl:when>
							<xsl:otherwise>&nbsp;<!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
						</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			
			<xsl:if test="cpty_inter_bank_addr_2 !='' ">
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of
					select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK_LOCALITY')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
						<xsl:choose>
							<xsl:when test="normalize-space(cpty_inter_bank_addr_2) != '' ">
								<xsl:choose>
									<xsl:when test="starts-with(cpty_inter_bank_addr_2,'/')">
									<xsl:value-of select="substring(cpty_inter_bank_addr_2,7)"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="cpty_inter_bank_addr_2" />
									</xsl:otherwise>
									</xsl:choose>
							</xsl:when>
							<xsl:otherwise>&nbsp;<!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
						</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
			
			<xsl:call-template name="table_cell">
			<xsl:with-param name="left_text">
					<xsl:value-of
					select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK_CITY')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:choose>
						<xsl:when test="normalize-space(cpty_inter_city_state) != ''">
								<xsl:choose>
									<xsl:when test="starts-with(cpty_inter_city_state,'/')">
									<xsl:value-of select="substring(cpty_inter_city_state,7)"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="cpty_inter_city_state" />
									</xsl:otherwise>
									</xsl:choose>
							</xsl:when>
							<xsl:otherwise>&nbsp;<!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
						</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="table_cell">
			<xsl:with-param name="left_text">
					<xsl:value-of
					select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK_COUNTRY')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:choose>
						<xsl:when test="normalize-space(cpty_inter_country) != ''">
							<xsl:choose>
							<xsl:when test="starts-with(cpty_inter_country,'/')">
								<xsl:value-of select="substring(cpty_inter_country,7)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="cpty_inter_country"/>
							</xsl:otherwise>
							</xsl:choose>
							</xsl:when>
							<xsl:otherwise>&nbsp;<!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
						</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			
			<xsl:if test="cpty_inter_bank_clrc[.!='']">
			<xsl:call-template name="table_cell">
			<xsl:with-param name="left_text">
				<xsl:value-of
					select="localization:getGTPString($language, 'XSL_CLEARING_CODE')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
						<xsl:choose>
							<xsl:when test="normalize-space(cpty_inter_bank_clrc) != ''">
							<xsl:choose>
								<xsl:when test="starts-with(cpty_inter_bank_clrc,'/') and utils:getDescFromClearingCode(substring(cpty_inter_bank_clrc,7),$rundata)!=''">
										<xsl:value-of select="utils:getDescFromClearingCode(substring(cpty_inter_bank_clrc,7),$rundata)"/>
								</xsl:when>
								<xsl:when test="starts-with(cpty_inter_bank_clrc,'/')">
										<xsl:value-of select="substring(cpty_inter_bank_clrc,7)"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="utils:getDescFromClearingCode(cpty_inter_bank_clrc,$rundata)"/>
								</xsl:otherwise>
							</xsl:choose>								
							</xsl:when>
							<xsl:otherwise>&nbsp;<!--Set value to a white space forcing the beneficiary bank address to always appear regardless if its set or not --></xsl:otherwise>
						</xsl:choose>
				</xsl:with-param>
	</xsl:call-template>
	</xsl:if>
		</xsl:otherwise>
	</xsl:choose> 
		
	
	<!-- intermediary bank routing number -->
	<xsl:choose>
			<xsl:when test="cpty_inter_routing_no !=''">	
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK_ABA')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:value-of
						select="cpty_inter_routing_no" />
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
	</xsl:choose>
					
	<!-- special routing instruction 1 -->
	<xsl:choose>
		<xsl:when test="cpty_special_routing_1 !=''">	
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_ROUTING_INSTRUCTION_1')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:value-of
						select="cpty_special_routing_1" />
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
	</xsl:choose>		
		
	<!-- special routing instruction 2 -->
	<xsl:choose>
		<xsl:when test="cpty_special_routing_2 !=''">	
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_ROUTING_INSTRUCTION_2')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:value-of
						select="cpty_special_routing_2" />
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
	</xsl:choose>	
		
		
	<!-- special routing instruction 3 -->
	<xsl:choose>
		<xsl:when test="cpty_special_routing_3 !=''">	
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_ROUTING_INSTRUCTION_3')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:value-of
						select="cpty_special_routing_3" />
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
	</xsl:choose>	
	
	<!-- special routing instruction 4 -->
	<xsl:choose>
		<xsl:when test="cpty_special_routing_4 !=''">	
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_ROUTING_INSTRUCTION_4')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:value-of
						select="cpty_special_routing_4" />
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
	</xsl:choose>	
	
	<!-- special routing instruction 5 -->
	<xsl:choose>
		<xsl:when test="cpty_special_routing_5 !=''">	
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_ROUTING_INSTRUCTION_5')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:value-of
						select="cpty_special_routing_5" />
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
	</xsl:choose>
	
	<!-- special routing instruction 6 -->
	<xsl:choose>
		<xsl:when test="cpty_special_routing_6 !=''">	
			<xsl:call-template name="table_cell">
				<xsl:with-param name="left_text">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_ROUTING_INSTRUCTION_6')" />
				</xsl:with-param>
				<xsl:with-param name="right_text">
					<xsl:value-of
						select="cpty_special_routing_6" />
				</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
	</xsl:choose>
		
		
		</xsl:when>
	</xsl:choose>
	
<!-- End of addtional -->	

<!--                                       -->
	<!-- free format settlement payment fields -->
<!--                                       -->
			<xsl:choose>
					<xsl:when test="normalize-space(cpty_payment_detail_1) or normalize-space(cpty_payment_detail_2) or normalize-space(cpty_payment_detail_3) or normalize-space(cpty_payment_detail_4)">		
					<xsl:call-template name="subtitle">
						<xsl:with-param name="text">
							<xsl:value-of
											select="localization:getGTPString($language, 'XSL_SI_PAYMENT_DETAILS_TAB_LABEL')" />
							</xsl:with-param>
							<!-- <xsl:with-param name="text">
									<xsl:call-template name="settlement-additional-fields" />
							</xsl:with-param> -->
					</xsl:call-template>
					
					<!-- payment detail 1 -->
					<xsl:choose>
						<xsl:when test="cpty_payment_detail_1 !=''">	
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_SI_ADDITIONAL_DETAILS_LINE_1')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of
										select="cpty_payment_detail_1" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
					</xsl:choose>
					
					<!-- payment detail 2 -->
					<xsl:choose>
						<xsl:when test="cpty_payment_detail_2 !=''">	
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_SI_ADDITIONAL_DETAILS_LINE_2')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of
										select="cpty_payment_detail_2" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
					</xsl:choose>
					
					<!-- payment detail 3 -->
					<xsl:choose>
						<xsl:when test="cpty_payment_detail_3 !=''">	
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_SI_ADDITIONAL_DETAILS_LINE_3')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of
										select="cpty_payment_detail_3" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
					</xsl:choose>
					
					<!-- payment detail 4 -->
					<xsl:choose>
						<xsl:when test="cpty_payment_detail_4 !=''">	
							<xsl:call-template name="table_cell">
								<xsl:with-param name="left_text">
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_SI_ADDITIONAL_DETAILS_LINE_4')" />
								</xsl:with-param>
								<xsl:with-param name="right_text">
									<xsl:value-of
										select="cpty_payment_detail_4" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
					</xsl:choose>
					
			</xsl:when>
		</xsl:choose>		
					 
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	

<xsl:template name="beneficiary-fields">
	
	<!-- settlement means -->	
	<xsl:call-template name="table_cell">
		<xsl:with-param name="left_text">
			<xsl:value-of
				select="localization:getGTPString($language, 'XSL_SETTLEMENT_DETAILS_SETTLEMENT_MEANS')" />
		</xsl:with-param>
		<xsl:with-param name="right_text">
			<xsl:value-of
				select="settlement_mean" />
		</xsl:with-param>
	</xsl:call-template>
	
	<!-- settlement account -->	
	<xsl:call-template name="table_cell">
		<xsl:with-param name="left_text">
			<xsl:value-of
				select="localization:getGTPString($language, 'XSL_SETTLEMENT_DETAILS_SETTLEMENT_ACCOUNTNUMBER')" />
		</xsl:with-param>
		<xsl:with-param name="right_text">
			<xsl:value-of select="settlement_account" />
		</xsl:with-param>
	</xsl:call-template>
	
</xsl:template>
</xsl:stylesheet>