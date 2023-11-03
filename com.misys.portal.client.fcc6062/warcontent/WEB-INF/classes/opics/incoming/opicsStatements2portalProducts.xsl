<?xml version="1.0"?>
<!--
   Copyright (c) 2000-2011 Misys (http://www.misys.com),
   All Rights Reserved. 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:tools="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
				xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
				xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
				exclude-result-prefixes="tools utils defaultresource">
				
	<xsl:param name="bo_type" />
	<xsl:param name="banks" />
	
	<xsl:variable name="swift_flag" select="defaultresource:getResource('OPICS_SWIFT_ENABLED')"/>
	<xsl:variable name="name_codeword" select="defaultresource:getResource('SWIFT_NAME_CODEWORD')"/>
	<xsl:variable name="add1_codeword" select="defaultresource:getResource('SWIFT_ADD1_CODEWORD')"/>
	<xsl:variable name="add2_codeword" select="defaultresource:getResource('SWIFT_ADD2_CODEWORD')"/>
	<xsl:variable name="city_codeword" select="defaultresource:getResource('SWIFT_CITY_CODEWORD')"/>
	<xsl:variable name="clrc_codeword" select="defaultresource:getResource('SWIFT_CLRC_CODEWORD')"/>
				
	<!-- Products -->
	<xsl:template match="Publications" mode="products">
		<xsl:apply-templates select="Publication/ItemArray/anyType" mode="all"/>
	</xsl:template>
	
	<xsl:template match="anyType" mode="all">
		
		<xsl:variable name="tradeIdVar"><xsl:value-of select="REQUESTNO"/></xsl:variable> 
		<xsl:variable name="isExistingFTDealOnFCC" select="utils:checkIfExistingFTDeal($tradeIdVar)"/>
		<xsl:choose>
			<xsl:when test="$isExistingFTDealOnFCC and defaultresource:getResource('SFX_APPLICATION_ENABLED') = 'true'">
				<xsl:if test="SYST[.='FXDH']">
					<xsl:apply-templates select="." mode="ft_fxdeal" />
				</xsl:if>
				<xsl:if test="SYST[.='ACCT'] and PRODUCT[.='CALL'] ">
					<xsl:apply-templates select="."
						mode="ft_CreditDebit" />
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if	test="SYST[.='FXDH']">
					<xsl:apply-templates select="." mode="fx" />
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		
		
		<xsl:if test="SYST[.='DLDT'] and PSALIND[.='L']">
			<xsl:apply-templates select="." mode="td"/>
		</xsl:if>
		<xsl:if test="SYST[.='DLDT'] and PSALIND[.='A']">
			<xsl:apply-templates select="." mode="la"/>
		</xsl:if>
		<!-- FTs should be processed only for reversals -->
		<!-- <xsl:if test="SYST[.='ACCT'] and REVDATE[.!='']">
			<xsl:apply-templates select="." mode="ft_revert"/>
		</xsl:if> -->
		
	</xsl:template>
	
	
	<!-- Processing Fx -->
	<xsl:template match="anyType" mode="fx">
		<!-- Getting the FT in case of reversal -->
<!-- 		<xsl:variable name="ftReferences" select="tools:createFTRefIdTnxStatCodeNode(REQUESTNO)"/>
		<xsl:variable name="retrieve_ft_ref_id" select="$ftReferences/references/ref_id"/>
		<xsl:variable name="retrieve_ft_tnx_id" select="$ftReferences/references/tnx_id"/>
		<xsl:variable name="retrieve_ft_tnx_stat_code" select="$ftReferences/references/tnx_stat_code"/> -->
		<fx_tnx_record>	
				
				<xsl:variable name="tnx_stat_code" select="'04'"/>
				<xsl:variable name="product_code" select="'FX'"/>
				<xsl:variable name="cust_ref_id" ><xsl:value-of select="CNO"/></xsl:variable>
				<xsl:variable name="bo_ref_id" ><xsl:value-of select="DEALNO"/></xsl:variable>
				<xsl:variable name="companyInfos" select="tools:retrieveCompanyInfosFrom($product_code, $cust_ref_id)"/>
				<xsl:variable name="company_id" select="$companyInfos/references/company_id"/>
				<xsl:variable name="company_name" select="$companyInfos/references/company_name"/>
				<xsl:variable name="companyAddress" select="tools:retrieveCompanyAddressNodesFromBORef($bo_ref_id, $product_code, $company_id)"/>
				<xsl:variable name="company_address_name" select="$companyAddress/references/company_name"/>
				<xsl:variable name="company_address_1" select="$companyAddress/references/company_adress_1"/>
				<xsl:variable name="company_address_2" select="$companyAddress/references/company_adress_2"/>
				<xsl:variable name="company_address_dom" select="$companyAddress/references/company_dom"/>
				
				<xsl:variable name="transaction_type">
				<xsl:choose>
					<xsl:when test="TRANSTYPE[.='WO' or .='TD']">WFWD</xsl:when>
					<xsl:when test="TRANSTYPE[.='SF']">FWD</xsl:when>
					<xsl:when test="TRANSTYPE[.='SW']">SWAP</xsl:when>
					<!--  should be confirm -->
					<xsl:otherwise></xsl:otherwise>
				</xsl:choose>
				</xsl:variable>
				
				<brch_code><xsl:value-of select="$brch_code"/></brch_code>
				<ref_id/>
				<bo_ref_id><xsl:value-of select="DEALNO"/></bo_ref_id>
				<bo_tnx_id><xsl:value-of select="SEQ"/></bo_tnx_id>
				<company_id><xsl:value-of select="$company_id"/></company_id>
				<company_name><xsl:value-of select="$company_name"/></company_name>
				<tnx_type_code>
					<!-- *SEQ = 0 => New -->
					<!-- *SEQ > 0 => Message -->
					<xsl:choose>
						<xsl:when test="REVDATE[.!='']">11</xsl:when>
						<xsl:when test="TRANSTYPE[.='SW'] or TRANSTYPE[.='WO'] or (TRANSTYPE[.='SF'] and number(SEQ) = 0)">01</xsl:when>
						<xsl:when test="TRANSTYPE[.='TD'] or TRANSTYPE[.='SP'] or (TRANSTYPE[.='SF'] and number(SEQ) &gt; 0)">13</xsl:when>
						<!--  should be confirm -->
						<xsl:otherwise></xsl:otherwise>
					</xsl:choose>
				</tnx_type_code>
				
				<sub_tnx_type_code>
					<xsl:choose>
						<xsl:when test="TRANSTYPE[.='TD']">31</xsl:when>
						<xsl:when test="TRANSTYPE[.='SP']">34</xsl:when>
						<xsl:when test="TRANSTYPE[.='SF'] and number(SEQ) &gt; 0">93</xsl:when>
						<xsl:otherwise></xsl:otherwise>
					</xsl:choose>
				</sub_tnx_type_code>
		
						
				<prod_stat_code>
					<xsl:choose>
						<xsl:when test="(SEQ[.='0'] or SEQ[.='']) and REVDATE[.='']">03</xsl:when>
						<xsl:when test="REVDATE[.!='']">10</xsl:when>
						<xsl:otherwise>07</xsl:otherwise>
					</xsl:choose>
				</prod_stat_code>				
				
				<!-- tnx stat code is not currently changed in the case of a Reversal -->
				<!-- <xsl:choose>
					<xsl:when test="$retrieve_ft_tnx_stat_code = '02' ">
						<tnx_stat_code>03</tnx_stat_code>					
					</xsl:when>
					<xsl:when test="$retrieve_ft_tnx_stat_code = '04' ">
						<tnx_stat_code>04</tnx_stat_code>					
					</xsl:when>
					<xsl:otherwise>
						<tnx_stat_code><xsl:value-of select="$tnx_stat_code"/></tnx_stat_code>
					</xsl:otherwise>
				</xsl:choose> -->
				
				<tnx_stat_code><xsl:value-of select="$tnx_stat_code"/></tnx_stat_code>

				<product_code>FX</product_code>
				
				<xsl:if test="DEALDATE">
					<appl_date>
						<xsl:call-template name="opicsDateProduct2portalDate">
							<xsl:with-param name="date"><xsl:value-of select="DEALDATE"/></xsl:with-param>
						</xsl:call-template>
					</appl_date>
				</xsl:if>
				
								
				<xsl:if test="DEALDATE">
					<iss_date>
						<xsl:call-template name="opicsDateProduct2portalDate">
							<xsl:with-param name="date"><xsl:value-of select="DEALDATE"/></xsl:with-param>
						</xsl:call-template>
					</iss_date>
				</xsl:if>
				
				
				<tnx_cur_code><xsl:value-of select="CCY"/></tnx_cur_code>
				<tnx_amt>
					<xsl:call-template name="format-and-absolute-amount">
						<xsl:with-param name="amount"><xsl:value-of select="CCYAMOUNT"/></xsl:with-param>
					</xsl:call-template>
				</tnx_amt>
							
				<tnx_counter_amt>
					<xsl:call-template name="format-and-absolute-amount">
						<xsl:with-param name="amount"><xsl:value-of select="CTRAMOUNT"/></xsl:with-param>
					</xsl:call-template>
				</tnx_counter_amt>
				
				<tnx_counter_cur_code><xsl:value-of select="CTRCCY"/></tnx_counter_cur_code>
				
				<original_amt>
					<xsl:call-template name="format-and-absolute-amount">
						<xsl:with-param name="amount"><xsl:value-of select="ORIGTOTAMT"/></xsl:with-param>
					</xsl:call-template>
				</original_amt>
				
				
				<fx_cur_code><xsl:value-of select="CCY"/></fx_cur_code>
				<counter_cur_code><xsl:value-of select="CTRCCY"/></counter_cur_code>
				<xsl:if test="TRANSTYPE[.!='TD']">
					
					<fx_amt>
						<xsl:call-template name="format-and-absolute-amount">
							<xsl:with-param name="amount"><xsl:value-of select="CCYAMOUNT"/></xsl:with-param>
						</xsl:call-template>
					</fx_amt>
					<counter_amt>
						<xsl:call-template name="format-and-absolute-amount">
							<xsl:with-param name="amount"><xsl:value-of select="CTRAMOUNT"/></xsl:with-param>
						</xsl:call-template>
					</counter_amt>
					
					<!-- need to be update for takedown -->
					<fx_liab_amt>
						<xsl:call-template name="format-and-absolute-amount">
							<xsl:with-param name="amount"><xsl:value-of select="CCYAMOUNT"/></xsl:with-param>
						</xsl:call-template>
					</fx_liab_amt>
				</xsl:if>
				
				<xsl:if test="RATE">
					<rate>
						<xsl:value-of select='format-number(RATE, "################0.00000000")' />
					</rate>
				</xsl:if>
				
<!-- 				<fx_type>
				<xsl:choose>
					<xsl:when test="ADDUPDIND[.='A'] or ADDUPDIND[.='U']"><xsl:value-of select="$transaction_type"/></xsl:when>
					<xsl:otherwise></xsl:otherwise>
				</xsl:choose>
				</fx_type> -->
				<xsl:variable name="boRefId"><xsl:value-of select="DEALNO"/></xsl:variable>			
				<xsl:variable name="subProdCode"><xsl:value-of select="tools:retrieveSubProdCodeFromBoRefId($boRefId, $product_code, null, '01')"/></xsl:variable>
				<xsl:variable name="tradeIdVar"><xsl:value-of select="REQUESTNO"/></xsl:variable>
				
				<xsl:variable name="subProdCodeUsingTradeId">
					<xsl:if test="not($subProdCode and $subProdCode != '')">
						<xsl:value-of select="tools:retrieveSubProdCodeFromTradeId($tradeIdVar ,$product_code, null, '01')"/>
					</xsl:if>
				</xsl:variable>
				
				<sub_product_code>
				<xsl:choose>
					<xsl:when test="$subProdCode and $subProdCode != ''"><xsl:value-of select="$subProdCode"/></xsl:when>
					<xsl:when test="$subProdCodeUsingTradeId and $subProdCodeUsingTradeId != ''">
						<xsl:value-of select="$subProdCodeUsingTradeId"/>
					</xsl:when>
					<xsl:when test="ADDUPDIND[.='A'] or ADDUPDIND[.='U']"><xsl:value-of select="$transaction_type"/></xsl:when>
					<xsl:otherwise></xsl:otherwise>
				</xsl:choose>
				</sub_product_code>
				<xsl:if test="PSALIND">
					<contract_type>
						<xsl:choose>
							<xsl:when test="PSALIND='P'">01</xsl:when>
							<xsl:when test="PSALIND='S'">02</xsl:when>
							<xsl:when test="PSALIND='C'">03</xsl:when>
						</xsl:choose>
					</contract_type>
				</xsl:if>
				
				
				<applicant_abbv_name><xsl:value-of select="$company_name"/></applicant_abbv_name>
				<applicant_name><xsl:value-of select="$company_address_name"/></applicant_name>
				<applicant_address_line_1><xsl:value-of select="$company_address_1"/></applicant_address_line_1>
				<applicant_address_line_2><xsl:value-of select="$company_address_2"/></applicant_address_line_2>
				<applicant_dom><xsl:value-of select="$company_address_dom"/></applicant_dom>
				<applicant_reference><xsl:value-of select="tools:getDefCustRef($cust_ref_id, null, 'FX')"/></applicant_reference>
				
				
				<xsl:choose>
					<xsl:when test="TRANSTYPE[.='TD']">
						<takedown_value_date>
							<xsl:call-template name="opicsDateProduct2portalDate">
								<xsl:with-param name="date"><xsl:value-of select="VDATE"/></xsl:with-param>
							</xsl:call-template>
						</takedown_value_date>
					</xsl:when>
					<xsl:otherwise>
						<value_date>
							<xsl:call-template name="opicsDateProduct2portalDate">
								<xsl:with-param name="date"><xsl:value-of select="VDATE"/></xsl:with-param>
							</xsl:call-template>
						</value_date>
					</xsl:otherwise>
				</xsl:choose>

				<xsl:choose>
					<xsl:when test="$transaction_type='WFWD'">
						<option_date>
							<xsl:call-template name="opicsDateProduct2portalDate">
								<xsl:with-param name="date"><xsl:value-of select="MDATE"/></xsl:with-param>
							</xsl:call-template>
						</option_date>
						<maturity_date>
							<xsl:call-template name="opicsDateProduct2portalDate">
								<xsl:with-param name="date"><xsl:value-of select="VDATE"/></xsl:with-param>
							</xsl:call-template>
						</maturity_date>
					</xsl:when>
					<xsl:otherwise>
						<maturity_date>
							<xsl:call-template name="opicsDateProduct2portalDate">
								<xsl:with-param name="date"><xsl:value-of select="VDATE"/></xsl:with-param>
							</xsl:call-template>
						</maturity_date>
					</xsl:otherwise>
				</xsl:choose>
				
				<xsl:if test="REQUESTNO">
					<trade_id><xsl:value-of select="REQUESTNO"/></trade_id>
				</xsl:if>
				
				<xsl:choose>
					<xsl:when test="REVDATE[.!='']">
						<action_req_code/>
					</xsl:when>
					<xsl:when test="INSTRUCTIONIND[.='I']">
						<action_req_code>80</action_req_code>
					</xsl:when>
					<xsl:when test="INSTRUCTIONIND[.='P']">
						<action_req_code>81</action_req_code>
					</xsl:when>
					<xsl:when test="INSTRUCTIONIND[.='R']">
						<action_req_code>82</action_req_code>
					</xsl:when>						
					<xsl:when test="INSTRUCTIONIND[.='C']">
						<action_req_code></action_req_code>
					</xsl:when>
				</xsl:choose>
				<xsl:if test="PRODUCT">
					<prod_code><xsl:value-of select="PRODUCT"/></prod_code>
				</xsl:if>
				<xsl:if test="PRODTYPE">
					<prod_type><xsl:value-of select="PRODTYPE"/></prod_type>
				</xsl:if>
				
				<xsl:if test="RECID">
					<orderNumber><xsl:value-of select="floor(RECID)"/></orderNumber>
				</xsl:if>
				
				<xsl:if test="PSALIND">
					<ctrps><xsl:choose>
							<xsl:when test="PSALIND='P'">S</xsl:when>
							<xsl:when test="PSALIND='S'">P</xsl:when>
							<xsl:when test="PSALIND='C'">C</xsl:when>
						</xsl:choose>
					</ctrps>
				</xsl:if>
				
				<!--  If Instruction is complete we try to complete the existing cross ref in fx.xsl -->
				<xsl:call-template name="cross_ref">
					<xsl:with-param name="brch_code"><xsl:value-of select="$brch_code"/></xsl:with-param>
					<xsl:with-param name="ref_id"></xsl:with-param>
					<xsl:with-param name="tnx_id"></xsl:with-param>
					<xsl:with-param name="product_code">FX</xsl:with-param>
				</xsl:call-template>
				
				<!-- elements for settlement details -->
				<xsl:choose>
					<xsl:when test="$swift_flag='true'">
						<xsl:call-template name="opicsCMDTSettlement2portalSWIFT" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="opicsCMDTSettlement2portal" />
					</xsl:otherwise>
				</xsl:choose>
				

		</fx_tnx_record>	
		
		<!-- Update the ft with a new prod_stat_code -->
<!-- 		<xsl:if test="(SEQ[.='0'] or SEQ[.='']) and REVDATE[.!=''] and $retrieve_ft_ref_id !=''">
			<ft_tnx_record>	
			<xsl:variable name="applicant_reference" ><xsl:value-of select="BR"/>/<xsl:value-of select="CNO"/></xsl:variable>
				<brch_code><xsl:value-of select="$brch_code"/></brch_code>
				<ref_id><xsl:value-of select="$retrieve_ft_ref_id"/></ref_id>
				<tnx_id><xsl:value-of select="$retrieve_ft_tnx_id" /></tnx_id>
				<prod_stat_code>10</prod_stat_code>
				<tnx_type_code>11</tnx_type_code>
				<product_code>FT</product_code>
				<applicant_reference><xsl:value-of select="$applicant_reference"/></applicant_reference>					
			</ft_tnx_record>
		</xsl:if> -->
		
	</xsl:template>
	
	
	
	<xsl:template match="anyType" mode="ft_fxdeal">
		<ft_tnx_record>
				<xsl:variable name="tnx_stat_code" select="'04'"/>
				<xsl:variable name="trade_id" ><xsl:value-of select="REQUESTNO"/></xsl:variable>
				<xsl:variable name="bo_ref_id" ><xsl:value-of select="REQUESTNO"/></xsl:variable>
				<xsl:variable name="fx_dealno" ><xsl:value-of select="DEALNO"/></xsl:variable>
				<fx_deal_no><xsl:value-of select="DEALNO"/></fx_deal_no>
				<xsl:variable name="product_code" select="'FT'"/>
				<xsl:variable name="cust_ref_id" ><xsl:value-of select="CNO"/></xsl:variable>
				<product_code>FT</product_code>
				<tnx_stat_code>04</tnx_stat_code>
				<tnx_type_code>01</tnx_type_code>
				<prod_stat_code>04</prod_stat_code>		
				<xsl:variable name="companyInfos" select="tools:retrieveCompanyInfosFrom($product_code, $cust_ref_id)"/>
				<xsl:variable name="company_id" select="$companyInfos/references/company_id"/>
				<xsl:variable name="company_name" select="$companyInfos/references/company_name"/>
				<xsl:variable name="companyAddress" select="tools:retrieveCompanyAddressNodesFromBORef($bo_ref_id, $product_code, $company_id)"/>
				<xsl:variable name="company_address_name" select="$companyAddress/references/company_name"/>
				<xsl:variable name="company_address_1" select="$companyAddress/references/company_adress_1"/>
				<xsl:variable name="company_address_2" select="$companyAddress/references/company_adress_2"/>
				<xsl:variable name="company_address_dom" select="$companyAddress/references/company_dom"/>
				
				<company_id><xsl:value-of select="$company_id"/></company_id>
				<company_name><xsl:value-of select="$company_name"/></company_name>
				<applicant_abbv_name><xsl:value-of select="$company_name"/></applicant_abbv_name>
				<applicant_name><xsl:value-of select="$company_address_name"/></applicant_name>
				<applicant_address_line_1><xsl:value-of select="$company_address_1"/></applicant_address_line_1>
				<applicant_address_line_2><xsl:value-of select="$company_address_2"/></applicant_address_line_2>
				<applicant_dom><xsl:value-of select="$company_address_dom"/></applicant_dom>
				<applicant_reference><xsl:value-of select="tools:getDefCustRef($cust_ref_id, null, 'FT')"/></applicant_reference>
				<bo_ref_id><xsl:value-of select="$bo_ref_id"/></bo_ref_id>		
							
		</ft_tnx_record>
	</xsl:template>
	
	<xsl:template match="anyType" mode="ft_CreditDebit">
		<ft_tnx_record>
				<xsl:variable name="tnx_stat_code" select="'04'"/>
				<xsl:variable name="product_code" select="'FT'"/>
				<xsl:variable name="cust_ref_id" ><xsl:value-of select="CNO"/></xsl:variable>
				<xsl:variable name="trade_id" ><xsl:value-of select="REQUESTNO"/></xsl:variable>
				<xsl:variable name="bo_ref_id" ><xsl:value-of select="REQUESTNO"/></xsl:variable>
				<xsl:variable name="fx_dealno" ><xsl:value-of select="DEALNO"/></xsl:variable>
				<xsl:variable name="ccy" ><xsl:value-of select="CCY"/></xsl:variable>
				<xsl:variable name="companyInfos" select="tools:retrieveCompanyInfosFrom($product_code, $cust_ref_id)"/>
				<xsl:variable name="company_id" select="$companyInfos/references/company_id"/>
				<xsl:variable name="company_name" select="$companyInfos/references/company_name"/>
				<xsl:variable name="companyAddress" select="tools:retrieveCompanyAddressNodesFromBORef($bo_ref_id, $product_code, $company_id)"/>
				<xsl:variable name="company_address_name" select="$companyAddress/references/company_name"/>
				<xsl:variable name="company_address_1" select="$companyAddress/references/company_adress_1"/>
				<xsl:variable name="company_address_2" select="$companyAddress/references/company_adress_2"/>
				<xsl:variable name="company_address_dom" select="$companyAddress/references/company_dom"/>
				
				<company_id><xsl:value-of select="$company_id"/></company_id>
				<company_name><xsl:value-of select="$company_name"/></company_name>
				<applicant_abbv_name><xsl:value-of select="$company_name"/></applicant_abbv_name>
				<applicant_name><xsl:value-of select="$company_address_name"/></applicant_name>
				<applicant_address_line_1><xsl:value-of select="$company_address_1"/></applicant_address_line_1>
				<applicant_address_line_2><xsl:value-of select="$company_address_2"/></applicant_address_line_2>
				<applicant_dom><xsl:value-of select="$company_address_dom"/></applicant_dom>
				<applicant_reference><xsl:value-of select="tools:getDefCustRef($cust_ref_id, null, 'FT')"/></applicant_reference>
				<bo_ref_id><xsl:value-of select="$bo_ref_id"/></bo_ref_id>	
				
				
				<xsl:variable name="isDebitDeal" select="utils:isDebitSideOftheFundTransfer($trade_id, $ccy)"></xsl:variable>
				<xsl:choose>
				<xsl:when test="$isDebitDeal">
					<payment_deal_no>
						<xsl:value-of select="DEALNO" />
					</payment_deal_no>
				</xsl:when>
				<xsl:otherwise>
					<xfer_deal_no><xsl:value-of select="DEALNO"/></xfer_deal_no>
				</xsl:otherwise>
			</xsl:choose>
			<product_code>FT</product_code>
			<tnx_stat_code>04</tnx_stat_code>
			<tnx_type_code>01</tnx_type_code>	
			<prod_stat_code>04</prod_stat_code>				
		</ft_tnx_record>
	</xsl:template>
	
	<!-- Processing TD -->
	<xsl:template match="anyType" mode="td">
		<td_tnx_record>	
				
				<xsl:variable name="tnx_stat_code" select="'04'"/>
				<xsl:variable name="tnx_type_code" select="'01'"/>
				<xsl:variable name="product_code" select="'TD'"/>
				<xsl:variable name="sub_product_code" select="'TRTD'"/>
				<xsl:variable name="cust_ref_id" ><xsl:value-of select="CNO"/></xsl:variable>
				<xsl:variable name="bo_ref_id" ><xsl:value-of select="DEALNO"/></xsl:variable>
				<xsl:variable name="companyInfos" select="tools:retrieveCompanyInfosFrom($product_code, $cust_ref_id)"/>
				<xsl:variable name="company_id" select="$companyInfos/references/company_id"/>
				<xsl:variable name="company_name" select="$companyInfos/references/company_name"/>
				<xsl:variable name="companyAddress" select="tools:retrieveCompanyAddressNodesFromBORef($bo_ref_id, $product_code, $company_id)"/>
				<xsl:variable name="company_address_name" select="$companyAddress/references/company_name"/>
				<xsl:variable name="company_address_1" select="$companyAddress/references/company_adress_1"/>
				<xsl:variable name="company_address_2" select="$companyAddress/references/company_adress_2"/>
				<xsl:variable name="company_address_dom" select="$companyAddress/references/company_dom"/>
				
				<brch_code><xsl:value-of select="$brch_code"/></brch_code>
				<ref_id/>
				<bo_ref_id><xsl:value-of select="DEALNO"/></bo_ref_id>
				<bo_tnx_id><xsl:value-of select="SEQ"/></bo_tnx_id>
				<company_id><xsl:value-of select="$company_id"/></company_id>
				<company_name><xsl:value-of select="$company_name"/></company_name>
				
				<tnx_type_code><xsl:value-of select="$tnx_type_code"/></tnx_type_code>
					<!-- <xsl:choose>
						<xsl:when test="TRANSTYPE[.='RO']">01</xsl:when>
						 should be confirm
						<xsl:otherwise>01</xsl:otherwise>
					</xsl:choose> 
				</tnx_type_code>-->
				
				<sub_tnx_type_code>
					<xsl:choose>
						<xsl:when test="TRANSTYPE[.='RO']">28</xsl:when>
						<xsl:otherwise></xsl:otherwise>
					</xsl:choose>
				</sub_tnx_type_code>
		
						
				<prod_stat_code>
					<xsl:choose>
					<!-- In case of rollover the status of deal should be moved to rollovered -->
						<xsl:when test="TRANSTYPE[.='RO']">03</xsl:when>
						<xsl:when test="(SEQ[.='0'] or SEQ[.='']) and REVDATE[.='']">03</xsl:when>
						<xsl:when test="(SEQ[.='0'] or SEQ[.='']) and REVDATE[.!='']">06</xsl:when>
						<xsl:otherwise>07</xsl:otherwise>
					</xsl:choose>
				</prod_stat_code>				

				<!-- tnx stat code is not currently changed in the case of a Reversal -->
				<tnx_stat_code><xsl:value-of select="$tnx_stat_code"/></tnx_stat_code>
				
				
				<product_code><xsl:value-of select="$product_code"/></product_code>
				
				<sub_product_code><xsl:value-of select="$sub_product_code"/></sub_product_code>
				
				<xsl:if test="DEALDATE">
					<appl_date><xsl:call-template name="opicsDateProduct2portalDate">
							<xsl:with-param name="date"><xsl:value-of select="DEALDATE"/></xsl:with-param>
						</xsl:call-template>
					</appl_date>
				</xsl:if>
				
				<xsl:if test="DEALDATE">
					<iss_date>
						<xsl:call-template name="opicsDateProduct2portalDate">
							<xsl:with-param name="date"><xsl:value-of select="DEALDATE"/></xsl:with-param>
						</xsl:call-template>
					</iss_date>
				</xsl:if>
				
				<tnx_amt>
					<xsl:call-template name="format-and-absolute-amount">
						<xsl:with-param name="amount"><xsl:value-of select="CCYAMOUNT"/></xsl:with-param>
					</xsl:call-template>
				</tnx_amt>

				<original_amt>
					<xsl:call-template name="format-and-absolute-amount">
						<xsl:with-param name="amount"><xsl:value-of select="ORIGTOTAMT"/></xsl:with-param>
					</xsl:call-template>
				</original_amt>

				
				<td_cur_code><xsl:value-of select="CCY"/></td_cur_code>
				<tnx_cur_code><xsl:value-of select="CCY"/></tnx_cur_code>
				
				<td_amt>
					<xsl:call-template name="format-and-absolute-amount">
						<xsl:with-param name="amount"><xsl:value-of select="CCYAMOUNT"/></xsl:with-param>
					</xsl:call-template>
				</td_amt>
				
				<td_liab_amt>
					<xsl:call-template name="format-and-absolute-amount">
						<xsl:with-param name="amount"><xsl:value-of select="CCYAMOUNT"/></xsl:with-param>
					</xsl:call-template>
				</td_liab_amt>
				
				
				<xsl:if test="RATE">
					<rate>
						<xsl:value-of select='format-number(RATE, "################0.00000000")' />
					</rate>
				</xsl:if>
				
				<interest>
					<xsl:call-template name="format-and-absolute-interest">
						<xsl:with-param name="amount"><xsl:value-of select="INTAMT"/></xsl:with-param>
					</xsl:call-template>
				</interest>
			
				<total_with_interest>
					<xsl:call-template name="format-and-absolute-interest">
						<xsl:with-param name="amount"><xsl:value-of select="ORIGTOTAMT"/></xsl:with-param>
					</xsl:call-template>
				</total_with_interest>
				
				<value_date><xsl:call-template name="opicsDateProduct2portalDate">
						<xsl:with-param name="date"><xsl:value-of select="VDATE"/></xsl:with-param>
					</xsl:call-template>
				</value_date>
				
				<td_type>
				<xsl:choose>
					<xsl:when test="TRANSTYPE[.='RO']">ROLLOVER</xsl:when>
					<xsl:otherwise>SCRATCH</xsl:otherwise>
				</xsl:choose>
				</td_type>
				
					
				<applicant_abbv_name><xsl:value-of select="$company_name"/></applicant_abbv_name>
				<applicant_name><xsl:value-of select="$company_address_name"/></applicant_name>
				<applicant_address_line_1><xsl:value-of select="$company_address_1"/></applicant_address_line_1>
				<applicant_address_line_2><xsl:value-of select="$company_address_2"/></applicant_address_line_2>
				<applicant_dom><xsl:value-of select="$company_address_dom"/></applicant_dom>
				<applicant_reference><xsl:value-of select="tools:getDefCustRef($cust_ref_id, null, 'FX')"/></applicant_reference>
								
				
				<maturity_date>
					<xsl:call-template name="opicsDateProduct2portalDate">
						<xsl:with-param name="date"><xsl:value-of select="MDATE"/></xsl:with-param>
					</xsl:call-template>
				</maturity_date>

				
				<xsl:choose>
					<xsl:when test="INSTRUCTIONIND[.='I']">
						<action_req_code>80</action_req_code>
					</xsl:when>
					<xsl:when test="INSTRUCTIONIND[.='P']">
						<action_req_code>81</action_req_code>
					</xsl:when>
					<xsl:when test="INSTRUCTIONIND[.='R']">
						<action_req_code>82</action_req_code>
					</xsl:when>						
					<xsl:when test="INSTRUCTIONIND[.='C']">
						<action_req_code></action_req_code>
					</xsl:when>
				</xsl:choose>
				
				<xsl:if test="PRODUCT">
					<prod_code><xsl:value-of select="PRODUCT"/></prod_code>
				</xsl:if>
				<xsl:if test="PRODTYPE">
					<prod_type><xsl:value-of select="PRODTYPE"/></prod_type>
				</xsl:if>
				
				<xsl:if test="RECID">
					<rec_id><xsl:value-of select="RECID"/></rec_id>
				</xsl:if>
				
				<xsl:if test="REQUESTNO">
					<trade_id><xsl:value-of select="REQUESTNO"/></trade_id>
				</xsl:if>
				
				<!--  If Instruction is complete we try to complete the existing cross ref in td.xsl -->
				<xsl:call-template name="cross_ref">
					<xsl:with-param name="brch_code"><xsl:value-of select="$brch_code"/></xsl:with-param>
					<xsl:with-param name="ref_id"></xsl:with-param>
					<xsl:with-param name="tnx_id"></xsl:with-param>
					<xsl:with-param name="product_code">TD</xsl:with-param>
				</xsl:call-template>

				<!-- elements for settlement details -->
				<xsl:choose>
					<xsl:when test="$swift_flag='true'">
						<xsl:call-template name="opicsCMDTSettlement2portalSWIFT" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="opicsCMDTSettlement2portal" />
					</xsl:otherwise>
				</xsl:choose>				
					
		</td_tnx_record>	
	</xsl:template>
	

	<!-- 	Processing La
	<xsl:template match="anyType" mode="la">
		<la_tnx_record>	
				<xsl:variable name="tnx_stat_code" select="'04'"/>
				<xsl:variable name="product_code" select="'LA'"/>
				<xsl:variable name="cust_ref_id" ><xsl:value-of select="CNO"/></xsl:variable>
				<xsl:variable name="companyInfos" select="tools:retrieveCompanyInfosFrom($product_code, $cust_ref_id)"/>
				<xsl:variable name="company_id" select="$companyInfos/references/company_id"/>
				<xsl:variable name="company_name" select="$companyInfos/references/company_name"/>
				<xsl:variable name="companyAddress" select="tools:retrieveCompanyAddressNodesFromCompanyId($company_id)"/>
				<xsl:variable name="company_address_name" select="$companyAddress/references/company_name"/>
				<xsl:variable name="company_address_1" select="$companyAddress/references/company_adress_1"/>
				<xsl:variable name="company_address_2" select="$companyAddress/references/company_adress_2"/>
				<xsl:variable name="company_address_dom" select="$companyAddress/references/company_dom"/>
				
				<brch_code><xsl:value-of select="$brch_code"/></brch_code>
				<ref_id/>
				<bo_ref_id><xsl:value-of select="DEALNO"/></bo_ref_id>
				<bo_tnx_id><xsl:value-of select="SEQ"/></bo_tnx_id>
				
				<company_id><xsl:value-of select="$company_id"/></company_id>
				<company_name><xsl:value-of select="$company_name"/></company_name>
				<tnx_type_code>01</tnx_type_code>
				
				<sub_tnx_type_code>
					<xsl:choose>
						<xsl:when test="TRANSTYPE[.='RO']">31</xsl:when>
						 should be confirm
						<xsl:otherwise></xsl:otherwise>
					</xsl:choose>
				</sub_tnx_type_code>
		
						
				<prod_stat_code>
					<xsl:choose>
						<xsl:when test="(SEQ[.='0'] or SEQ[.='']) and REVDATE[.='']">03</xsl:when>
						<xsl:when test="(SEQ[.='0'] or SEQ[.='']) and REVDATE[.!='']">06</xsl:when>
						<xsl:otherwise>07</xsl:otherwise>
					</xsl:choose>
				</prod_stat_code>				
		
				tnx stat code is not currently changed in the case of a Reversal
				<tnx_stat_code><xsl:value-of select="$tnx_stat_code"/></tnx_stat_code>
				
				
				<product_code><xsl:value-of select="$product_code"/></product_code>
				
				<xsl:if test="DEALDATE">
					<appl_date>
						<xsl:call-template name="opicsDateProduct2portalDate">
							<xsl:with-param name="date"><xsl:value-of select="DEALDATE"/></xsl:with-param>
						</xsl:call-template>
					</appl_date>
				</xsl:if>
				
				<xsl:if test="DEALDATE">
					<iss_date>
						<xsl:call-template name="opicsDateProduct2portalDate">
							<xsl:with-param name="date"><xsl:value-of select="DEALDATE"/></xsl:with-param>
						</xsl:call-template>
					</iss_date>
				</xsl:if>
				
				<original_amt>
					<xsl:call-template name="format-and-absolute-amount">
						<xsl:with-param name="amount"><xsl:value-of select="ORIGTOTAMT"/></xsl:with-param>
					</xsl:call-template>
				</original_amt>
				
				<tnx_amt>
					<xsl:call-template name="format-and-absolute-amount">
						<xsl:with-param name="amount"><xsl:value-of select="CCYAMOUNT"/></xsl:with-param>
					</xsl:call-template>
				</tnx_amt>
			
				<la_cur_code><xsl:value-of select="CCY"/></la_cur_code>
				
				<la_amt>
					<xsl:call-template name="format-and-absolute-amount">
						<xsl:with-param name="amount"><xsl:value-of select="CCYAMOUNT"/></xsl:with-param>
					</xsl:call-template>
				</la_amt>
				
				
				<la_liab_amt>
					<xsl:call-template name="format-and-absolute-amount">
						<xsl:with-param name="amount"><xsl:value-of select="CCYAMOUNT"/></xsl:with-param>
					</xsl:call-template>
				</la_liab_amt>
				
				<xsl:if test="RATE">
					<rate>
						<xsl:value-of select='format-number(RATE, "################0.00000000")' />
					</rate>
				</xsl:if>
				
				<interest>
					<xsl:call-template name="format-and-absolute-amount">
						<xsl:with-param name="amount"><xsl:value-of select="INTAMT"/></xsl:with-param>
					</xsl:call-template>
				</interest>
			
				<total_with_interest>
					<xsl:call-template name="format-and-absolute-amount">
						<xsl:with-param name="amount"><xsl:value-of select="ORIGTOTAMT"/></xsl:with-param>
					</xsl:call-template>
				</total_with_interest>
				
				<applicant_abbv_name><xsl:value-of select="$company_name"/></applicant_abbv_name>
				<applicant_name><xsl:value-of select="$company_address_name"/></applicant_name>
				<applicant_address_line_1><xsl:value-of select="$company_address_1"/></applicant_address_line_1>
				<applicant_address_line_2><xsl:value-of select="$company_address_2"/></applicant_address_line_2>
				<applicant_dom><xsl:value-of select="$company_address_dom"/></applicant_dom>
				<applicant_reference><xsl:value-of select="$cust_ref_id"/></applicant_reference>
				
				
				<maturity_date>
					<xsl:call-template name="opicsDateProduct2portalDate">
						<xsl:with-param name="date"><xsl:value-of select="MDATE"/></xsl:with-param>
					</xsl:call-template>
				</maturity_date>		
				<value_date>
					<xsl:call-template name="opicsDateProduct2portalDate">
						<xsl:with-param name="date"><xsl:value-of select="VDATE"/></xsl:with-param>
					</xsl:call-template>
				</value_date>
				
				<xsl:choose>
					<xsl:when test="INSTRUCTIONIND[.='I']">
						<action_req_code>80</action_req_code>
					</xsl:when>
					<xsl:when test="INSTRUCTIONIND[.='P']">
						<action_req_code>80</action_req_code>
					</xsl:when>
					<xsl:when test="INSTRUCTIONIND[.='R']">
						<action_req_code>80</action_req_code>
					</xsl:when>						
					<xsl:when test="INSTRUCTIONIND[.='C']">
						<action_req_code></action_req_code>
					</xsl:when>
				</xsl:choose>
				
				<xsl:if test="PRODUCT">
					<prod_code><xsl:value-of select="PRODUCT"/></prod_code>
				</xsl:if>
				<xsl:if test="PRODTYPE">
					<prod_type><xsl:value-of select="PRODTYPE"/></prod_type>
				</xsl:if>
				
				<xsl:if test="RECID">
					<orderNumber><xsl:value-of select="RECID"/></orderNumber>
				</xsl:if>
				
				 If Instruction is complete we try to complete the existing cross ref in la.xsl
				<xsl:call-template name="cross_ref">
					<xsl:with-param name="brch_code"><xsl:value-of select="$brch_code"/></xsl:with-param>
					<xsl:with-param name="ref_id"></xsl:with-param>
					<xsl:with-param name="tnx_id"></xsl:with-param>
					<xsl:with-param name="product_code">LA</xsl:with-param>
				</xsl:call-template>
			
				elements for settlement details
				<xsl:call-template name="opicsCMDTSettlement2portal"/>
				
		</la_tnx_record>	
	</xsl:template>
	
	Processing FT Reversal
	<xsl:template match="anyType" mode="ft_revert">
		<ft_tnx_record>	
				
				<xsl:variable name="tnx_stat_code" select="'04'"/>
				<xsl:variable name="product_code" select="'FT'"/>
				<xsl:variable name="applicant_reference" ><xsl:value-of select="BR"/>/<xsl:value-of select="CNO"/></xsl:variable>
							
				
				<brch_code><xsl:value-of select="$brch_code"/></brch_code>
				<bo_tnx_id><xsl:value-of select="SEQ"/></bo_tnx_id>
				<bo_ref_id><xsl:value-of select="REQUESTNO"/></bo_ref_id>
				
				<tnx_type_code>11</tnx_type_code>
				<prod_stat_code>10</prod_stat_code>
				<tnx_stat_code><xsl:value-of select="$tnx_stat_code"/></tnx_stat_code>
				<product_code><xsl:value-of select="$product_code"/></product_code>

				<applicant_reference><xsl:value-of select="$applicant_reference"/></applicant_reference>
				
		</ft_tnx_record>	
	</xsl:template>
	-->
	
	<xsl:template name="opicsDesc2portalRate">
		<xsl:param name="desc"/>
			<xsl:choose>
				<!-- FX case : PUR EUR/USD 1.35980000 -->
				<xsl:when test="substring($desc, 1,3) = 'PUR'">
					<xsl:value-of select="substring($desc, 13,10)"/>
				</xsl:when>
				<!-- TD case : TIME DEPOSIT TAKEN 5.00000000 -->
				<xsl:when test="substring($desc, 1, 18) = 'TIME DEPOSIT TAKEN'">
					<xsl:value-of select="substring($desc, 20, 10)"/>
				</xsl:when>
			</xsl:choose>
	</xsl:template> 
	
	<!-- Mapping of Opics date type -->
	<xsl:template name="opicsDateProduct2portalDate">
		<xsl:param name="date"/>
			<xsl:choose>
				<!-- case m/dd/yyyy -->
				<xsl:when test="substring($date, 2, 1) = '/' and substring($date, 5, 1) = '/'"><xsl:value-of select="substring($date, 3, 2)"/>/0<xsl:value-of select="substring($date, 1, 1)"/>/<xsl:value-of select="substring($date, 6, 4)"/></xsl:when>
				<!-- case m/d/yyyy -->
				<xsl:when test="substring($date, 2, 1) = '/' and substring($date, 4, 1) = '/'">0<xsl:value-of select="substring($date, 3, 1)"/>/0<xsl:value-of select="substring($date, 1, 1)"/>/<xsl:value-of select="substring($date, 5, 4)"/></xsl:when>
				<!-- case mm/d/yyyy -->
				<xsl:when test="substring($date, 3, 1) = '/' and substring($date, 5, 1) = '/'">0<xsl:value-of select="substring($date, 4, 1)"/>/<xsl:value-of select="substring($date, 1, 2)"/>/<xsl:value-of select="substring($date, 6, 4)"/></xsl:when>
				<!-- case mm/dd/yyyy -->
				<xsl:when test="substring($date, 3, 1) = '/' and substring($date, 6, 1) = '/'"><xsl:value-of select="substring($date, 4, 2)"/>/<xsl:value-of select="substring($date, 1, 2)"/>/<xsl:value-of select="substring($date, 7, 4)"/></xsl:when>				
				<xsl:otherwise><xsl:value-of select="substring($date, 1, 10)"/></xsl:otherwise>
			</xsl:choose>
	</xsl:template>
	
	<xsl:template name="format-and-absolute-amount">
		<xsl:param name="amount"/>
		<xsl:variable name="absolute_amount"><xsl:value-of select="$amount*($amount >=0) - $amount*($amount &lt; 0)"/></xsl:variable>
		<xsl:choose>
			<xsl:when test="$absolute_amount=0">0.00</xsl:when>
			<xsl:otherwise><xsl:value-of select="format-number($absolute_amount, '###,###,###.00')"/></xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>
	
	<xsl:template name="format-and-absolute-interest">
		<xsl:param name="amount"/>
		<xsl:variable name="absolute_amount"><xsl:value-of select="$amount*($amount >=0) - $amount*($amount &lt; 0)"/></xsl:variable>
		<xsl:variable name="format_amount"><xsl:value-of select="format-number($absolute_amount, '###,###,###.00')"/></xsl:variable>
		<xsl:choose>
			<xsl:when test="starts-with($format_amount, '.')">
				<xsl:value-of select="format-number($absolute_amount, '0.00')"/>
			</xsl:when>
			<xsl:when test="$absolute_amount=0">0.00</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$format_amount"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="cross_ref">
		<xsl:param name="brch_code"><xsl:value-of select="$brch_code"/></xsl:param>
		<xsl:param name="ref_id"></xsl:param>
		<xsl:param name="tnx_id"></xsl:param>
		<xsl:param name="product_code"></xsl:param>
		<xsl:param name="child_tnx_id"></xsl:param>
		
			<cross_references>
					<cross_reference>
						<brch_code><xsl:value-of select="$brch_code"/></brch_code>
						<ref_id><xsl:value-of select="$ref_id"/></ref_id>
						<tnx_id><xsl:value-of select="$tnx_id"/></tnx_id>
						<cross_reference_id></cross_reference_id>
						<product_code><xsl:value-of select="$product_code"/></product_code>
						<child_product_code><xsl:value-of select="$product_code"/></child_product_code>
						<child_ref_id><xsl:value-of select="$ref_id"/></child_ref_id>
						<child_tnx_id><xsl:value-of select="$child_tnx_id"/></child_tnx_id>
						<type_code>01</type_code>
					</cross_reference>
			</cross_references>
			
	</xsl:template>

	<xsl:template name="opicsCMDTSettlement2portal">
			<!-- Customer Part -->
	
			<xsl:if test="CUSTREFNO1">			
						<settlement_cust_ref><xsl:value-of select="CUSTREFNO1"/></settlement_cust_ref>
			</xsl:if>
			<xsl:if test="CUSTPAYSMEANS">
						<settlement_cust_smeans><xsl:value-of select="CUSTPAYSMEANS"/></settlement_cust_smeans>			
			</xsl:if>
			<xsl:if test="CUSTPAYSACCOUNT">
						<settlement_cust_account><xsl:value-of select="CUSTPAYSACCOUNT"/></settlement_cust_account>			
			</xsl:if>
						
			<xsl:choose>
				<xsl:when test="PSALIND='P'">
				<!-- customer currency -->
					<settlement_cust_cur_code>
						<xsl:value-of select="CTRCCY"/>
					</settlement_cust_cur_code>
					
				<!-- bank currency -->
				
					<payment_cur_code>
						<xsl:value-of select="CCY"/>
					</payment_cur_code>
				</xsl:when>
				<xsl:when test="PSALIND='S'">
				<!-- customer currency -->
					<settlement_cust_cur_code>
						<xsl:value-of select="CCY"/>
					</settlement_cust_cur_code>
				<!-- bank currency -->
					<payment_cur_code>
						<xsl:value-of select="CTRCCY"/>		
					</payment_cur_code>
				</xsl:when>		
			</xsl:choose>
			
			<!-- Bank part -->
	
			<xsl:if test="SMEANS">			
						<!-- <near_beneficiary_bank><xsl:value-of select="SMEANS"/></near_beneficiary_bank> -->
						<settlement_mean><xsl:value-of select="SMEANS"/></settlement_mean>
			</xsl:if>
			<xsl:if test="SACCOUNT">
						<settlement_account><xsl:value-of select="SACCOUNT"/></settlement_account>			
						<!-- <beneficiary_account><xsl:value-of select="SACCOUNT"/></beneficiary_account> -->
			</xsl:if>
			<xsl:if test="BENDETAILS">			
						<beneficiary_account><xsl:value-of select="BENDETAILS/ACCOUNT"/></beneficiary_account>			
						<beneficiary_iso_code><xsl:value-of select="BENDETAILS/BIC"/></beneficiary_iso_code>
								
						<xsl:choose>
							<xsl:when test="BENDETAILS/C1[.!='']">				
								<beneficiary_name><xsl:value-of select="BENDETAILS/C1" /></beneficiary_name>
							</xsl:when>
							<xsl:otherwise>
								<beneficiary_name><xsl:value-of select="BENDETAILS/SN" /></beneficiary_name>
							</xsl:otherwise>
						</xsl:choose>
						<beneficiary_address><xsl:value-of select="BENDETAILS/C2" /></beneficiary_address>
						<beneficiary_address_2><xsl:value-of select="BENDETAILS/C3" /></beneficiary_address_2>
						<xsl:variable name="benCountry"><xsl:value-of select="utils:extractCountryCode(BENDETAILS/C4)"/></xsl:variable>
						<beneficiary_city>
							<xsl:call-template name="extract-dom">
								<xsl:with-param name="countryText"><xsl:value-of select="BENDETAILS/C4" /></xsl:with-param>
								<xsl:with-param name="countryCode"><xsl:value-of select="$benCountry" /></xsl:with-param>
							</xsl:call-template>
						</beneficiary_city>						
						<xsl:if test="$benCountry != ''">
							<beneficiary_country>
									<xsl:value-of select="$benCountry" />
							</beneficiary_country>
						</xsl:if>
			</xsl:if>
			<xsl:if test="INTERMEDIARY">
					<xsl:choose>
						<xsl:when test="INTERMEDIARY/C1[.!='']">
							<intermediary_bank><xsl:value-of select="INTERMEDIARY/C1"/></intermediary_bank>
						</xsl:when>
						<xsl:otherwise>
							<intermediary_bank><xsl:value-of select="INTERMEDIARY/SN"/></intermediary_bank>
						</xsl:otherwise>
					</xsl:choose>					
					<intermediary_bank_street><xsl:value-of select="INTERMEDIARY/C2"/></intermediary_bank_street>
					<intermediary_bank_city><xsl:value-of select="INTERMEDIARY/C3"/></intermediary_bank_city>
					<xsl:variable name="interCountry"><xsl:value-of select="utils:extractCountryCode(INTERMEDIARY/C4)"/></xsl:variable>
					<xsl:if test="$interCountry != ''">
						<intermediary_bank_country>
							<xsl:value-of select="$interCountry" />
						</intermediary_bank_country>
					</xsl:if>
				
					<intermediary_bank_bic><xsl:value-of select="INTERMEDIARY/BIC"/></intermediary_bank_bic>
					
					<intermediary_bank_aba><xsl:value-of select="INTERMEDIARY/ACCOUNT"/></intermediary_bank_aba>
			</xsl:if>			
			<xsl:if test="ORDERING">			
					<ordering_cust_name><xsl:value-of select="ORDERING/C1"/></ordering_cust_name>
					<ordering_cust_address><xsl:value-of select="ORDERING/C2"/></ordering_cust_address>
					<ordering_cust_citystate><xsl:value-of select="ORDERING/C3"/></ordering_cust_citystate>
					<xsl:variable name="orderCountry"><xsl:value-of select="utils:extractCountryCode(ORDERING/C4)"/></xsl:variable>
					<xsl:if test="$orderCountry != ''">
						<ordering_cust_country>
							<xsl:value-of select="$orderCountry" />
						</ordering_cust_country>
					</xsl:if>
					<ordering_cust_account><xsl:value-of select="ORDERING/ACCOUNT"/></ordering_cust_account>
			<!-- 		<intermediary_bank_aba><xsl:value-of select="ORDERING/SN"/></intermediary_bank_aba> -->
			</xsl:if>						
			<xsl:if test="DETCHARGES">			
					<!-- <swift_charges_type><xsl:value-of select="DETCHARGES"/></swift_charges_type> -->
					<xsl:choose>
						<xsl:when test="DETCHARGES[.='OUR']">
							<swift_charges_type>01</swift_charges_type>
						</xsl:when>
						<xsl:when test="DETCHARGES[.='BEN']">
							<swift_charges_type>02</swift_charges_type>
						</xsl:when>
						<xsl:when test="DETCHARGES[.='SHA']">
							<swift_charges_type>05</swift_charges_type>
						</xsl:when>						
						<xsl:otherwise>
							
						</xsl:otherwise>					
					</xsl:choose>
			</xsl:if>

			 <xsl:if test="AWBANK">
				<xsl:choose>
					<xsl:when test="AWBANK/BIC[.!='']">
						<cpty_account_institution><xsl:value-of select="AWBANK/BIC" /></cpty_account_institution>
					</xsl:when>
					<xsl:otherwise>
						<cpty_account_institution><xsl:value-of select="AWBANK/C1" /></cpty_account_institution>
					</xsl:otherwise>
			 	</xsl:choose>
				<xsl:choose>
					<xsl:when test="AWBANK/C1[.!='']">
						<beneficiary_bank><xsl:value-of select="AWBANK/C1" /></beneficiary_bank> 
					</xsl:when>
					<xsl:otherwise>
						<beneficiary_bank><xsl:value-of select="AWBANK/SN" /></beneficiary_bank> 
					</xsl:otherwise>
				</xsl:choose>				
				<beneficiary_bank_branch><xsl:value-of select="AWBANK/C2" /></beneficiary_bank_branch> 
				<beneficiary_bank_address><xsl:value-of select="AWBANK/C3" /></beneficiary_bank_address>
				<xsl:variable name="bankCountry"><xsl:value-of select="utils:extractCountryCode(AWBANK/C4)"/></xsl:variable>
				<beneficiary_bank_city>
					<xsl:call-template name="extract-dom">
						<xsl:with-param name="countryText"><xsl:value-of select="AWBANK/C4" /></xsl:with-param>
						<xsl:with-param name="countryCode"><xsl:value-of select="$bankCountry" /></xsl:with-param>
					</xsl:call-template>
				</beneficiary_bank_city>
				<xsl:if test="$bankCountry != ''">
					<beneficiary_bank_country>
						<xsl:value-of select="$bankCountry" />
					</beneficiary_bank_country>
				</xsl:if>
				<beneficiary_bank_bic><xsl:value-of select="AWBANK/BIC" /></beneficiary_bank_bic>
				<beneficiary_bank_routing_number><xsl:value-of select="AWBANK/ACCOUNT" /></beneficiary_bank_routing_number>				
			 </xsl:if>
			 <xsl:if test="SENDERTORECEIVER">
						<xsl:if test="SENDERTORECEIVER/R1">												
							<intermediary_bank_instruction_1><xsl:value-of select="SENDERTORECEIVER/R1"/></intermediary_bank_instruction_1> 
						</xsl:if>
						<xsl:if test="SENDERTORECEIVER/R2">												
							<intermediary_bank_instruction_2><xsl:value-of select="SENDERTORECEIVER/R2"/></intermediary_bank_instruction_2>
						</xsl:if>
						<xsl:if test="SENDERTORECEIVER/R3">												
							<intermediary_bank_instruction_3><xsl:value-of select="SENDERTORECEIVER/R3"/></intermediary_bank_instruction_3>
						</xsl:if>				
						<xsl:if test="SENDERTORECEIVER/R4">												
							<intermediary_bank_instruction_4><xsl:value-of select="SENDERTORECEIVER/R4"/></intermediary_bank_instruction_4>
						</xsl:if>
						<xsl:if test="SENDERTORECEIVER/R5">												
							<intermediary_bank_instruction_5><xsl:value-of select="SENDERTORECEIVER/R5"/></intermediary_bank_instruction_5>
						</xsl:if>
						<xsl:if test="SENDERTORECEIVER/R6">												
							<intermediary_bank_instruction_6><xsl:value-of select="SENDERTORECEIVER/R6"/></intermediary_bank_instruction_6>
						</xsl:if>												
			 </xsl:if>
			 <xsl:if test="PAYMENTDETAILS">
					<xsl:if test="PAYMENTDETAILS/P1">												
						<free_additional_details_line_1_input><xsl:value-of select="PAYMENTDETAILS/P1"/></free_additional_details_line_1_input> 
					</xsl:if>			 
					<xsl:if test="PAYMENTDETAILS/P2">												
						<free_additional_details_line_2_input><xsl:value-of select="PAYMENTDETAILS/P2"/></free_additional_details_line_2_input> 
					</xsl:if>			 
					<xsl:if test="PAYMENTDETAILS/P3">												
						<free_additional_details_line_3_input><xsl:value-of select="PAYMENTDETAILS/P3"/></free_additional_details_line_3_input> 
					</xsl:if>			 					
					<xsl:if test="PAYMENTDETAILS/P4">												
						<free_additional_details_line_4_input><xsl:value-of select="PAYMENTDETAILS/P4"/></free_additional_details_line_4_input> 
					</xsl:if>			 
			 </xsl:if>
	</xsl:template>	
	
	<xsl:template name="extract-dom">
		<xsl:param name="countryText"/>
		<xsl:param name="countryCode"/>
		<xsl:variable name="domLen"><xsl:value-of select="string-length($countryText)"/></xsl:variable>
		<xsl:choose>
			<xsl:when test="$countryCode = ''">
				<xsl:value-of select="$countryText"/>
			</xsl:when>
			<xsl:when test="$domLen > 2"><xsl:value-of select="substring($countryText, 1, ($domLen - 3))"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="$countryText"/></xsl:otherwise>	
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="opicsCMDTSettlement2portalSWIFT">
			<!-- Customer Part -->
	
			<xsl:if test="CUSTREFNO1">			
						<settlement_cust_ref><xsl:value-of select="CUSTREFNO1"/></settlement_cust_ref>
			</xsl:if>
			<xsl:if test="CUSTPAYSMEANS">
						<settlement_cust_smeans><xsl:value-of select="CUSTPAYSMEANS"/></settlement_cust_smeans>			
			</xsl:if>
			<xsl:if test="CUSTPAYSACCOUNT">
						<settlement_cust_account><xsl:value-of select="CUSTPAYSACCOUNT"/></settlement_cust_account>			
			</xsl:if>
						
			<xsl:choose>
				<xsl:when test="PSALIND='P'">
				<!-- customer currency -->
					<settlement_cust_cur_code>
						<xsl:value-of select="CTRCCY"/>
					</settlement_cust_cur_code>
					
				<!-- bank currency -->
				
					<payment_cur_code>
						<xsl:value-of select="CCY"/>
					</payment_cur_code>
				</xsl:when>
				<xsl:when test="PSALIND='S'">
				<!-- customer currency -->
					<settlement_cust_cur_code>
						<xsl:value-of select="CCY"/>
					</settlement_cust_cur_code>
				<!-- bank currency -->
					<payment_cur_code>
						<xsl:value-of select="CTRCCY"/>		
					</payment_cur_code>
				</xsl:when>		
			</xsl:choose>
			
			<!-- Bank part -->
	
			<xsl:if test="SMEANS">			
						<!-- <near_beneficiary_bank><xsl:value-of select="SMEANS"/></near_beneficiary_bank> -->
						<settlement_mean><xsl:value-of select="SMEANS"/></settlement_mean>
			</xsl:if>
			<xsl:if test="SACCOUNT">
						<settlement_account><xsl:value-of select="SACCOUNT"/></settlement_account>			
						<!-- <beneficiary_account><xsl:value-of select="SACCOUNT"/></beneficiary_account> -->
			</xsl:if>
			<xsl:if test="BENDETAILS">			
						<beneficiary_account><xsl:value-of select="BENDETAILS/ACCOUNT"/></beneficiary_account>			
						<beneficiary_iso_code><xsl:value-of select="BENDETAILS/BIC"/></beneficiary_iso_code>
								
						<xsl:choose>
							<xsl:when test="BENDETAILS/C1[.!='']">	
								<beneficiary_name><xsl:value-of select="utils:removeOpicsCodeWrdIfExists(BENDETAILS/C1,$name_codeword)"/></beneficiary_name>		
							</xsl:when>
							<xsl:otherwise>
								<beneficiary_name><xsl:value-of select="BENDETAILS/SN" /></beneficiary_name>
							</xsl:otherwise>
						</xsl:choose>
						<beneficiary_address><xsl:value-of select="utils:removeOpicsCodeWrdIfExists(BENDETAILS/C2,$add1_codeword)" /></beneficiary_address>
						<beneficiary_address_2><xsl:value-of select="utils:removeOpicsCodeWrdIfExists(BENDETAILS/C3,$add2_codeword)" /></beneficiary_address_2>
						<xsl:variable name="benCountryVar"><xsl:value-of select="utils:removeOpicsCodeWrdIfExists(BENDETAILS/C4,$city_codeword)"/></xsl:variable>
						<xsl:variable name="benCountry"><xsl:value-of select="utils:extractCountryCode($benCountryVar)"/></xsl:variable>
						<beneficiary_city>
							<xsl:call-template name="extract-dom">
								<xsl:with-param name="countryText"><xsl:value-of select="$benCountryVar" /></xsl:with-param>
								<xsl:with-param name="countryCode"><xsl:value-of select="$benCountry" /></xsl:with-param>
							</xsl:call-template>
						</beneficiary_city>						
						<xsl:if test="$benCountry != ''">
							<beneficiary_country>
									<xsl:value-of select="$benCountry" />
							</beneficiary_country>
						</xsl:if>
			</xsl:if>
			<xsl:if test="INTERMEDIARY">
					<xsl:choose>
						<xsl:when test="INTERMEDIARY/C1[.!='']">
							<intermediary_bank><xsl:value-of select="utils:removeOpicsCodeWrdIfExists(INTERMEDIARY/C1,$name_codeword)"/></intermediary_bank>
						</xsl:when>
						<xsl:otherwise>
							<intermediary_bank><xsl:value-of select="INTERMEDIARY/SN"/></intermediary_bank>
						</xsl:otherwise>
					</xsl:choose>					
					<intermediary_bank_street><xsl:value-of select="utils:removeOpicsCodeWrdIfExists(INTERMEDIARY/C2,$add1_codeword)"/></intermediary_bank_street>
					<intermediary_bank_city><xsl:value-of select="utils:removeOpicsCodeWrdIfExists(INTERMEDIARY/C3,$add2_codeword)"/></intermediary_bank_city>
					<xsl:variable name="interCountryVar"><xsl:value-of select="utils:removeOpicsCodeWrdIfExists(INTERMEDIARY/C4,$city_codeword)"/></xsl:variable>
					<xsl:variable name="interCountry"><xsl:value-of select="utils:extractCountryCode($interCountryVar)"/></xsl:variable>
					<xsl:if test="$interCountry != ''">
						<intermediary_bank_country>
							<xsl:value-of select="$interCountry" />
						</intermediary_bank_country>
					</xsl:if>
				
					<intermediary_bank_bic><xsl:value-of select="INTERMEDIARY/BIC"/></intermediary_bank_bic>
					
					<intermediary_bank_aba><xsl:value-of select="INTERMEDIARY/ACCOUNT"/></intermediary_bank_aba>
			</xsl:if>			
			<xsl:if test="ORDERING">			
					<ordering_cust_name><xsl:value-of select="utils:removeOpicsCodeWrdIfExists(ORDERING/C1,$name_codeword)"/></ordering_cust_name>
					<ordering_cust_address><xsl:value-of select="utils:removeOpicsCodeWrdIfExists(ORDERING/C2,$add1_codeword)"/></ordering_cust_address>
					<ordering_cust_citystate><xsl:value-of select="utils:removeOpicsCodeWrdIfExists(ORDERING/C3,$add2_codeword)"/></ordering_cust_citystate>
					<xsl:variable name="orderCountryVar"><xsl:value-of select="utils:removeOpicsCodeWrdIfExists(ORDERING/C4,$city_codeword)"/></xsl:variable>
					<xsl:variable name="orderCountry"><xsl:value-of select="utils:extractCountryCode($orderCountryVar)"/></xsl:variable>
					<xsl:if test="$orderCountry != ''">
						<ordering_cust_country>
							<xsl:value-of select="$orderCountry" />
						</ordering_cust_country>
					</xsl:if>
					<ordering_cust_account><xsl:value-of select="ORDERING/ACCOUNT"/></ordering_cust_account>
			<!-- 		<intermediary_bank_aba><xsl:value-of select="ORDERING/SN"/></intermediary_bank_aba> -->
			</xsl:if>						
			<xsl:if test="DETCHARGES">			
					<!-- <swift_charges_type><xsl:value-of select="DETCHARGES"/></swift_charges_type> -->
					<xsl:choose>
						<xsl:when test="DETCHARGES[.='OUR']">
							<swift_charges_type>01</swift_charges_type>
						</xsl:when>
						<xsl:when test="DETCHARGES[.='BEN']">
							<swift_charges_type>02</swift_charges_type>
						</xsl:when>
						<xsl:when test="DETCHARGES[.='SHA']">
							<swift_charges_type>05</swift_charges_type>
						</xsl:when>						
						<xsl:otherwise>
							
						</xsl:otherwise>					
					</xsl:choose>
			</xsl:if>

			 <xsl:if test="AWBANK">
				<xsl:choose>
					<xsl:when test="AWBANK/BIC[.!='']">
						<cpty_account_institution><xsl:value-of select="AWBANK/BIC" /></cpty_account_institution>
					</xsl:when>
					<xsl:otherwise>
						<cpty_account_institution><xsl:value-of select="utils:removeOpicsCodeWrdIfExists(AWBANK/C1,$name_codeword)" /></cpty_account_institution>
					</xsl:otherwise>
			 	</xsl:choose>
				<xsl:choose>
					<xsl:when test="AWBANK/C1[.!='']">
						<beneficiary_bank><xsl:value-of select="utils:removeOpicsCodeWrdIfExists(AWBANK/C1,$name_codeword)" /></beneficiary_bank> 
					</xsl:when>
					<xsl:otherwise>
						<beneficiary_bank><xsl:value-of select="AWBANK/SN" /></beneficiary_bank> 
					</xsl:otherwise>
				</xsl:choose>				
				<beneficiary_bank_branch><xsl:value-of select="utils:removeOpicsCodeWrdIfExists(AWBANK/C2,$add1_codeword)" /></beneficiary_bank_branch> 
				<beneficiary_bank_address><xsl:value-of select="utils:removeOpicsCodeWrdIfExists(AWBANK/C3,$add2_codeword)" /></beneficiary_bank_address>
				<xsl:variable name="bankCountryVar"><xsl:value-of select="utils:removeOpicsCodeWrdIfExists(AWBANK/C4,$city_codeword)"/></xsl:variable>
				<xsl:variable name="bankCountry"><xsl:value-of select="utils:extractCountryCode($bankCountryVar)"/></xsl:variable>
				<beneficiary_bank_city>
					<xsl:call-template name="extract-dom">
						<xsl:with-param name="countryText"><xsl:value-of select="$bankCountryVar" /></xsl:with-param>
						<xsl:with-param name="countryCode"><xsl:value-of select="$bankCountry" /></xsl:with-param>
					</xsl:call-template>
				</beneficiary_bank_city>
				<xsl:if test="$bankCountry != ''">
					<beneficiary_bank_country>
						<xsl:value-of select="$bankCountry" />
					</beneficiary_bank_country>
				</xsl:if>
				<beneficiary_bank_bic><xsl:value-of select="AWBANK/BIC" /></beneficiary_bank_bic>
				<beneficiary_bank_routing_number><xsl:value-of select="AWBANK/ACCOUNT" /></beneficiary_bank_routing_number>				
			 </xsl:if>
			 <xsl:if test="SENDERTORECEIVER">
						<xsl:if test="SENDERTORECEIVER/R1">												
							<intermediary_bank_instruction_1><xsl:value-of select="SENDERTORECEIVER/R1"/></intermediary_bank_instruction_1> 
						</xsl:if>
						<xsl:if test="SENDERTORECEIVER/R2">												
							<intermediary_bank_instruction_2><xsl:value-of select="SENDERTORECEIVER/R2"/></intermediary_bank_instruction_2>
						</xsl:if>
						<xsl:if test="SENDERTORECEIVER/R3">												
							<intermediary_bank_instruction_3><xsl:value-of select="SENDERTORECEIVER/R3"/></intermediary_bank_instruction_3>
						</xsl:if>				
						<xsl:if test="SENDERTORECEIVER/R4">												
							<intermediary_bank_instruction_4><xsl:value-of select="SENDERTORECEIVER/R4"/></intermediary_bank_instruction_4>
						</xsl:if>
						<xsl:if test="SENDERTORECEIVER/R5">												
							<intermediary_bank_instruction_5><xsl:value-of select="SENDERTORECEIVER/R5"/></intermediary_bank_instruction_5>
						</xsl:if>
						<xsl:if test="SENDERTORECEIVER/R6">												
							<intermediary_bank_instruction_6><xsl:value-of select="SENDERTORECEIVER/R6"/></intermediary_bank_instruction_6>
						</xsl:if>												
			 </xsl:if>
			 <xsl:if test="PAYMENTDETAILS">
					<xsl:if test="PAYMENTDETAILS/P1">												
						<free_additional_details_line_1_input><xsl:value-of select="PAYMENTDETAILS/P1"/></free_additional_details_line_1_input> 
					</xsl:if>			 
					<xsl:if test="PAYMENTDETAILS/P2">												
						<free_additional_details_line_2_input><xsl:value-of select="PAYMENTDETAILS/P2"/></free_additional_details_line_2_input> 
					</xsl:if>			 
					<xsl:if test="PAYMENTDETAILS/P3">												
						<free_additional_details_line_3_input><xsl:value-of select="PAYMENTDETAILS/P3"/></free_additional_details_line_3_input> 
					</xsl:if>			 					
					<xsl:if test="PAYMENTDETAILS/P4">												
						<free_additional_details_line_4_input><xsl:value-of select="PAYMENTDETAILS/P4"/></free_additional_details_line_4_input> 
					</xsl:if>			 
			 </xsl:if>
	</xsl:template>	
	
	
</xsl:stylesheet>