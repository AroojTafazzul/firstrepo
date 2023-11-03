<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:default="xalan://com.misys.portal.common.resources.DefaultResourceProvider" 
    xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools" 
    xmlns:jetSpeed="xalan://com.misys.portal.core.util.JetspeedResources"
    xmlns:technicalResource="xalan://com.misys.portal.common.resources.TechnicalResourceProvider"
    xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
    exclude-result-prefixes="default converttools jetSpeed technicalResource utils">

    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    
    <!-- Get the interface environment -->
    <xsl:param name="context"/>
    <xsl:param name="language">en</xsl:param>
    
    <!--
    Copyright (c) 2000-2012 Misys (http://www.misys.com),
    All Rights Reserved. 
    -->
    
    <!-- Match template -->
    <xsl:template match="/">
        <xsl:apply-templates select="ft_tnx_record"/>
    </xsl:template>

    <xsl:template match="ft_tnx_record">
     <xsl:variable name="passRefId"><xsl:value-of select="default:getResource('PASS_FBCC_REFID_AS_IFMID')"/></xsl:variable>
     <xsl:variable name="msgType">
    	<xsl:choose>
    		<xsl:when test="bulk_ref_id[.!='']">BSWF</xsl:when>
    		<xsl:otherwise>SWF</xsl:otherwise>
    	</xsl:choose>
    </xsl:variable>
		<Message>
		    <Header>
				<MsgType><xsl:value-of select="$msgType"></xsl:value-of> </MsgType>
		        <MsgID>
					<xsl:choose>
                		<xsl:when test="$passRefId='true'">  
	                	<IFMid><xsl:value-of select="ref_id" /></IFMid>
		                </xsl:when>
		                <xsl:otherwise>
		                	<IFMid><xsl:value-of select="tnx_id" /></IFMid>
		                </xsl:otherwise>
                	</xsl:choose>
		        </MsgID>
		        <Resend>0</Resend>
		        <CustId><xsl:value-of select="applicant_reference" /></CustId>
		    </Header>
		    <Content>
		        <Swift>
		            <MT103>
		                <TransactionRef>1</TransactionRef>
		                <IsValidatedPayee>0</IsValidatedPayee>
		                 <xsl:choose>
							<xsl:when test="$passRefId='true'">
	                			<PaymentRef><xsl:value-of select="tnx_id" /></PaymentRef>
			                </xsl:when>
			                <xsl:otherwise>
			                	<PaymentRef><xsl:value-of select="ref_id" /></PaymentRef>
			                </xsl:otherwise>
						</xsl:choose>	
		                <f33B_InstructedAmt>
                			<Currency><xsl:value-of select="ft_cur_code" /></Currency>
                    		<InstructedAmount><xsl:value-of select="ft_amt" /></InstructedAmount>
		                    <DeductChargesFromInstructedAmount>1</DeductChargesFromInstructedAmount>
		                </f33B_InstructedAmt>
		                <f36_ExchangeRate><xsl:value-of select="additional_field[@name='fx_exchange_rate']" /></f36_ExchangeRate>
                		<FXDealerName/>
                		<FXQuoteNumber/>	
		                <f50A_DebitAccount>
		                    <AcctNo><xsl:value-of select="applicant_act_no" /></AcctNo>
		                </f50A_DebitAccount>
		                <!-- The intermediary institution should be stored in the pay through bank -->
		                <!-- There seems to be two kinds of implementation. One uses details in additional fields, the other 
		                uses the pay through bank in the file object. The second one seems more appropriate. The code below
		                using additional_fields was left in place for now to handle the current screens. -->
		                <xsl:choose>
		                  <xsl:when test="additional_field[@name='intermediary_bank_swift_bic_code']">
		                	<f56A_IntermediaryInst>
								<PartyIdentifier>
									<AccountNumber>
										<PIValue><xsl:value-of select="additional_field[@name='intermediary_bank_swift_bic_code']" /></PIValue>
									</AccountNumber>
									<PIData>
										<CountryCode><xsl:value-of select="additional_field[@name='intermediary_bank_country']"/></CountryCode>
									</PIData>
								</PartyIdentifier>
								<BIC>
									<BICcode><xsl:value-of select="additional_field[@name='intermediary_bank_swift_bic_code']" /></BICcode>
								</BIC>
								<NameAddress>
	                        		<Name><xsl:value-of select="additional_field[@name='intermediary_bank_name']" /></Name>
	                        		<AddressLine1><xsl:value-of select="additional_field[@name='intermediary_bank_address_line_1']" /></AddressLine1>
	                       			<AddressLine2><xsl:value-of select="additional_field[@name='intermediary_bank_address_line_2']" /></AddressLine2>
									<AddressLine3><xsl:value-of select="additional_field[@name='intermediary_bank_dom']" /></AddressLine3>
	                        		<CountryCode><xsl:value-of select="additional_field[@name='intermediary_bank_country']" /></CountryCode>
	                    		</NameAddress>
	                        </f56A_IntermediaryInst>
		                 </xsl:when>
		                 <xsl:when test="pay_through_bank/iso_code">
				            	<f56A_IntermediaryInst>
									<PartyIdentifier>
										<AccountNumber>
											<PIValue><xsl:value-of select="pay_through_bank/iso_code" /></PIValue>
										</AccountNumber>
										<PIData>
											<CountryCode><xsl:value-of select="pay_through_bank/country"/></CountryCode>
										</PIData>
									</PartyIdentifier>
									<BIC>
										<BICcode><xsl:value-of select="pay_through_bank/iso_code" /></BICcode>
									</BIC>
									<NameAddress>
		                        		<Name><xsl:value-of select="pay_through_bank/name" /></Name>
		                        		<AddressLine1><xsl:value-of select="pay_through_bank/address_line_1" /></AddressLine1>
		                       			<AddressLine2><xsl:value-of select="pay_through_bank/address_line_1" /></AddressLine2>
										<AddressLine3><xsl:value-of select="pay_through_bank/dom" /></AddressLine3>
		                        		<CountryCode><xsl:value-of select="pay_through_bank/country" /></CountryCode>
		                    		</NameAddress>
		                        </f56A_IntermediaryInst>
		                	</xsl:when>
		                </xsl:choose>

						<!-- The account with details are the details of the beneficiary bank -->
						<f57A_AccountWithInst>
								<PartyIdentifier> 
									<AccountNumber>
										<PIValue><xsl:value-of select="counterparties/counterparty/cpty_bank_swift_bic_code" /></PIValue> 
									</AccountNumber>
									<PIData>
										<CountryCode><xsl:value-of select="counterparties/counterparty/cpty_bank_country" /></CountryCode>
									</PIData>
								</PartyIdentifier>
								<BIC>
									<BICcode><xsl:value-of select="counterparties/counterparty/cpty_bank_swift_bic_code" /></BICcode>
								</BIC>
							<NameAddress>
								<Name><xsl:value-of select="counterparties/counterparty/cpty_bank_name" /></Name>
								<AddressLine1><xsl:value-of select="counterparties/counterparty/cpty_bank_address_line_1" /></AddressLine1>
								<AddressLine2><xsl:value-of select="counterparties/counterparty/cpty_bank_address_line_2" /></AddressLine2>
								<AddressLine3><xsl:value-of select="counterparties/counterparty/cpty_bank_dom" /></AddressLine3>
								<CountryCode><xsl:value-of select="counterparties/counterparty/cpty_bank_country" /></CountryCode>
							</NameAddress>
		                </f57A_AccountWithInst>

						<f59A_BeneficiaryCust>
							<BeneficiaryAccountName><xsl:value-of select="counterparties/counterparty/counterparty_name" /></BeneficiaryAccountName>
							<AcctNo><xsl:value-of select="counterparties/counterparty/counterparty_act_no" /></AcctNo>
							<IBAN><xsl:value-of select="counterparties/counterparty/counterparty_act_no" /></IBAN>
		                    <BIC>
		                        <BICcode><xsl:value-of select="counterparties/counterparty/cpty_bank_swift_bic_code" /></BICcode>
		                        <SortCode><xsl:value-of select="counterparties/counterparty/cpty_branch_code" /></SortCode>
		                    </BIC>
		                    <NameAddress>
		                        <Name><xsl:value-of select="counterparties/counterparty/counterparty_name" /></Name>
	                        	<AddressLine1><xsl:value-of select="counterparties/counterparty/counterparty_address_line_1" /></AddressLine1>
		                        <AddressLine2><xsl:value-of select="counterparties/counterparty/counterparty_address_line_2" /></AddressLine2>
	                        	<AddressLine3><xsl:value-of select="counterparties/counterparty/counterparty_dom" /></AddressLine3>
		                        <CountryCode><xsl:value-of select="counterparties/counterparty/counterparty_country" /></CountryCode>
		                    </NameAddress>
							<Currency><xsl:value-of select="counterparties/counterparty/counterparty_cur_code" /></Currency>
		                </f59A_BeneficiaryCust>
		                <f70_RemittanceInfo>
		                    <ROC>
								<Ref><xsl:value-of select="additional_instructions" /></Ref>
		                        <Rate />
		                    </ROC>
			            	<Line1/>
							<Line2/>
                          	<Line3/>
                          	<Line4/>
		                </f70_RemittanceInfo>
		                <f71A_ChargingInstr>
		                	<!-- 
		                	<xsl:if test="open_chrg_brn_by_code[. = '01']">SHA</xsl:if>
		                	<xsl:if test="open_chrg_brn_by_code[. = '02']">OUR</xsl:if>
		                	<xsl:if test="open_chrg_brn_by_code[. = '03']">BEN</xsl:if> 
		                	-->
		                	      <!-- below line is added for MPS-36927 -->
		                	<xsl:value-of select="additional_field[@name='charge_option']"/>
		                </f71A_ChargingInstr>
						<f71A_ChargeAmount>
							<!-- 
							<xsl:if test="open_chrg_brn_by_code[. = '01']">A</xsl:if>
							<xsl:if test="open_chrg_brn_by_code[. = '02']">A</xsl:if>
			                <xsl:if test="open_chrg_brn_by_code[. = '03']">D</xsl:if> 
			                -->
			                <!-- below 3 lines added for MPS-36927 -->
			                <xsl:if test="additional_field[@name='charge_option'][.='SHA']">A</xsl:if>
			                <xsl:if test="additional_field[@name='charge_option'][.='OUR']">A</xsl:if>
			                <xsl:if test="additional_field[@name='charge_option'][.='BEN']">D</xsl:if>
						</f71A_ChargeAmount>
						<f72_CustMemo>
							<Line1/>
							<Line2/>
							<Line3/>
							<Line4/>
							<Line5/>
							<Line6/>
						</f72_CustMemo>
						<Narrative>
							<Line1><xsl:value-of select="cust_ref_id" /></Line1>
			            	<Line2><xsl:value-of select="additional_field[@name='instruction_to_bank']" /></Line2>
					 		<Line3><xsl:value-of select="additional_field[@name='payment_details_to_beneficiary']"/></Line3>
							<Line4 />
						</Narrative>
						<f77B_RegRep>
							<CountryCode />
							<ORDERRES />
							<BENEFRES />
							<Line1/>
							<Line2 />
							<Line3 />
						</f77B_RegRep>
						<DeliveryMethod/>
		            </MT103>
		        </Swift>
		    </Content>
		</Message>
	</xsl:template>
</xsl:stylesheet>