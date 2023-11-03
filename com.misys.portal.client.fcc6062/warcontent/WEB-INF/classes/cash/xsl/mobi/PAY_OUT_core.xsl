<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:default="xalan://com.misys.portal.common.resources.DefaultResourceProvider" 
    xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools" 
    xmlns:jetSpeed="xalan://com.misys.portal.core.util.JetspeedResources"
    xmlns:technicalResource="xalan://com.misys.portal.common.resources.TechnicalResourceProvider"
    exclude-result-prefixes="default converttools jetSpeed technicalResource">

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
    
    <!-- Routing Identifier -->
    <xsl:variable name="routing_identifier"> 
    
			    
	    <!--  HVPS Payment Type -->
	    <xsl:if test="./product_code = 'FT' and ./sub_product_code = 'HVPS' ">
	    	<xsl:choose>
	    		<xsl:when test="./additional_field[@name = 'urgent_transfer'] = 'Y'"><xsl:value-of select="jetSpeed:getString('hvps.urgent.routing.identifier')"/></xsl:when>
	    		<xsl:otherwise><xsl:value-of select="jetSpeed:getString('hvps.routing.identifier')"/></xsl:otherwise>
	    	</xsl:choose>	    
	    </xsl:if>

	    <!--  MUPS Payment Type -->
	    <xsl:if test="./product_code = 'FT' and ./sub_product_code = 'MUPS' ">
	    	<xsl:choose>
	    		<xsl:when test="./additional_field[@name = 'clearing_code'] = 'NEFT'">02</xsl:when>
	    		<xsl:when test="./additional_field[@name = 'clearing_code'] = 'RTGS'">04</xsl:when>
	    		<xsl:otherwise></xsl:otherwise>
	    	</xsl:choose>	    	    	
	    </xsl:if>
	    
	    <!--  HVXB Payment Type -->
	    <xsl:if test="./product_code = 'FT' and ./sub_product_code = 'HVXB' ">
	    
	    	<xsl:if test="./additional_field[@name = 'charge_option'] = 'OUR'">
		    	<xsl:choose>
		    		<xsl:when test="./additional_field[@name = 'urgent_transfer'] = 'Y'"><xsl:value-of select="jetSpeed:getString('hvxb.our.urgent.routing.identifier')"/></xsl:when>
		    		<xsl:otherwise><xsl:value-of select="jetSpeed:getString('hvxb.our.routing.identifier')"/></xsl:otherwise>
		    	</xsl:choose>	    	    	
	    	</xsl:if>
	    	
	    	<xsl:if test="./additional_field[@name = 'charge_option'] = 'BEN'">
		    	<xsl:choose>
		    		<xsl:when test="./additional_field[@name = 'urgent_transfer'] = 'Y'"><xsl:value-of select="jetSpeed:getString('hvxb.ben.urgent.routing.identifier')"/></xsl:when>
		    		<xsl:otherwise><xsl:value-of select="jetSpeed:getString('hvxb.ben.routing.identifier')"/></xsl:otherwise>
		    	</xsl:choose>	    	    	
	    	</xsl:if>

	    	<xsl:if test="./additional_field[@name = 'charge_option'] = 'SHA'">
		    	<xsl:choose>
		    		<xsl:when test="./additional_field[@name = 'urgent_transfer'] = 'Y'"><xsl:value-of select="jetSpeed:getString('hvxb.sha.urgent.routing.identifier')"/></xsl:when>
		    		<xsl:otherwise><xsl:value-of select="jetSpeed:getString('hvxb.sha.routing.identifier')"/></xsl:otherwise>
		    	</xsl:choose>	    	    	
	    	</xsl:if>    	
	    
	    </xsl:if>
    </xsl:variable>
    <xsl:variable name="passRefId"><xsl:value-of select="default:getResource('PASS_FBCC_REFID_AS_IFMID')"/></xsl:variable>
  	<!-- Sort Code -->  
    <xsl:variable name="sort_code">
    
		<xsl:choose>
			<!-- SWIFT Payment AND MUPS-->
			<xsl:when test="counterparties/counterparty/cpty_bank_swift_bic_code[. != '']">
            	<xsl:value-of select="counterparties/counterparty/cpty_bank_swift_bic_code" />	                                   
			</xsl:when>       
			<!-- DOM Payment -->                     		
			<xsl:when test="counterparties/counterparty/cpty_branch_code[. != '']">
				<xsl:value-of select="counterparties/counterparty/cpty_branch_code"/>
			</xsl:when>
			<!-- CNAPS Dom and XB Payment -->
			<xsl:when test="./additional_field[@name = 'cnaps_bank_code'] != ''">
				<xsl:value-of select="./additional_field[@name = 'cnaps_bank_code']"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="''"/>
			</xsl:otherwise>
		</xsl:choose>
    
    </xsl:variable>
    
    <xsl:variable name="msgType">
    	<xsl:choose>
    		<xsl:when test="bulk_ref_id[.!='']">BPAY</xsl:when>
    		<xsl:otherwise>PAY</xsl:otherwise>
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
                <Transaction>
                    <AcctTransaction>
                        <PayDate>
                            <ValueDate><xsl:value-of select="converttools:timstampToStringDateYYYYMMDD(converttools:stringDateToTimestamp(iss_date, $language))" /></ValueDate>
                        </PayDate>
						<ExpressPaymentFlag>
							<xsl:choose>
								<!-- We currently don't have CHAPS and FPS. Conditions to set this flag may change -->
								<xsl:when test="ft_type[.='16']">C</xsl:when><!-- CHAPS -->
								<xsl:when test="ft_type[.='17']">F</xsl:when><!-- Faster Sterling Payments -->
								<xsl:otherwise>S</xsl:otherwise><!-- Regular Payments -->
							</xsl:choose>
						</ExpressPaymentFlag>
                        <Credit>
                            <PayType />
		                    <Currency><xsl:value-of select="ft_cur_code" /></Currency>
                            <AcctID>
                            	<AcctIDType>1</AcctIDType>	
                            	<xsl:if test="$sort_code != ''">
									<BIC>
										<SortCode><xsl:value-of select="$sort_code" /></SortCode>
									</BIC>                	
                            	</xsl:if>                            	
                                <AcctNo><xsl:value-of select="counterparties/counterparty/counterparty_act_no" /></AcctNo>
                                <IsNominated>0</IsNominated>
                            </AcctID>
							<xsl:choose>
								<xsl:when test="$passRefId='true'">
		                			<PaymentRef><xsl:value-of select="tnx_id" /></PaymentRef>
				                </xsl:when>
				                <xsl:otherwise>
				                	<PaymentRef><xsl:value-of select="ref_id" /></PaymentRef>
				                </xsl:otherwise>
							</xsl:choose>                            
                            <Amount />
                             <xsl:choose>
                            	<xsl:when test="./product_code = 'FT' and ./sub_product_code ='MUPS'" >
		                            <CustMemo>
		                                <CustMemoLine1><xsl:value-of select="counterparties/counterparty/cpty_bank_name"/></CustMemoLine1>
		                                <CustMemoLine2><xsl:value-of select="counterparties/counterparty/counterparty_name"/></CustMemoLine2>
		                                <CustMemoLine3><xsl:value-of select="./additional_field[@name = 'bene_adv_beneficiary_id']" /></CustMemoLine3>
		                            </CustMemo>
		                        </xsl:when>
		                        <xsl:otherwise>
		                            <CustMemo>
		                                <CustMemoLine1>Online transfer from</CustMemoLine1>
		                                <CustMemoLine2><xsl:value-of select="applicant_act_no" /></CustMemoLine2>
		                                <CustMemoLine3><xsl:value-of select="applicant_name" /></CustMemoLine3>
		                            </CustMemo>		                        
		                        </xsl:otherwise>
		                    </xsl:choose>
                            <BankMemo />
                            <PayeeReference><xsl:value-of select="counterparties/counterparty/counterparty_reference" /></PayeeReference>
                            <PayeeName><xsl:value-of select="counterparties/counterparty/counterparty_name"/></PayeeName>
                        </Credit>
                        <Debit>
                           <PayType>
                            	<xsl:choose>
									<xsl:when test="./sub_product_code = 'HVPS'"><xsl:value-of select="sub_product_code"/></xsl:when>
									<xsl:when test="./sub_product_code = 'HVXB'">XB</xsl:when>
									<xsl:when test="./sub_product_code = 'MUPS'"><xsl:value-of select="sub_product_code"/></xsl:when>
									<xsl:otherwise></xsl:otherwise>
								</xsl:choose>
                            </PayType>
                            <AcctID>
                                <BIC>
                                    <SortCode />
                                </BIC>
                                <AcctNo><xsl:value-of select="applicant_act_no" /></AcctNo>
                            </AcctID>
                            <xsl:choose>
								<xsl:when test="$passRefId='true'">
		                			<PaymentRef><xsl:value-of select="tnx_id" /></PaymentRef>
				                </xsl:when>
				                <xsl:otherwise>
				                	<PaymentRef><xsl:value-of select="ref_id" /></PaymentRef>
				                </xsl:otherwise>
							</xsl:choose>
                            <Amount>
                                <Foreign>
                                    <XRate/>
				                	<FXDealerName/>
			                		<FXQuoteNumber/>	
                                    <XfrAmt><xsl:value-of select="ft_amt" /></XfrAmt>
                                    <XfrCurr><xsl:value-of select="ft_cur_code" /></XfrCurr>
                                </Foreign>
                            </Amount>
                           		 <xsl:choose>
                            		<xsl:when test="./product_code = 'FT' and ./sub_product_code ='MUPS'" >
                            			<CustMemo>
                            				<CustMemoLine1><xsl:value-of select="counterparties/counterparty/counterparty_act_no" /></CustMemoLine1>
			                                <CustMemoLine2><xsl:value-of select="$routing_identifier" /></CustMemoLine2>
			                                <CustMemoLine3><xsl:value-of select="./additional_field[@name = 'mups_description_address_line_1']" /></CustMemoLine3>
			                            	<CustMemoLine4><xsl:value-of select="./additional_field[@name = 'mups_description_address_line_2']" /></CustMemoLine4>
											<CustMemoLine5><xsl:value-of select="./additional_field[@name = 'mups_description_address_line_3']" /></CustMemoLine5>
					                        <CustMemoLine6><xsl:value-of select="./additional_field[@name = 'mups_description_address_line_4']" /></CustMemoLine6>
                            			</CustMemo>	
                            			</xsl:when>
                            			<xsl:otherwise>
                            			<CustMemo>
			                            	<CustMemoLine1>Online transfer to</CustMemoLine1>
			                                <CustMemoLine2><xsl:value-of select="$routing_identifier" /><xsl:value-of select="counterparties/counterparty/counterparty_act_no" /></CustMemoLine2>
			                                <CustMemoLine3><xsl:value-of select="counterparties/counterparty/counterparty_name" /></CustMemoLine3>
			                            	<CustMemoLine4></CustMemoLine4>
											<CustMemoLine5></CustMemoLine5>
					                        <CustMemoLine6></CustMemoLine6>
					                        </CustMemo>
		                        		</xsl:otherwise>
                           			 </xsl:choose>

                            <BankMemo/>
                        </Debit>
                    </AcctTransaction>
                </Transaction>
            </Content>
        </Message>
    </xsl:template>
</xsl:stylesheet>