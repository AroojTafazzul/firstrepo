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
			    
	    	<!--  INT Payment Type -->
	    	<xsl:if test="./product_code = 'FT' and ./sub_product_code = 'INT' ">
	    		<xsl:value-of select="jetSpeed:getString('int.routing.identifier')"/>
	    	</xsl:if>

		    <!--  TPT Payment Type -->
		    <xsl:if test="./product_code = 'FT' and ./sub_product_code = 'TPT' ">
		    
		    	<!-- Check Beneficiary Account for RA or NRA -->
		    	<xsl:variable name="BeneAccountNo"><xsl:value-of select="counterparties/counterparty/counterparty_act_no"/></xsl:variable>
		    	<xsl:variable name="BeneNRA">
					<xsl:choose>
						<xsl:when test="string-length($BeneAccountNo) = 24">
							<xsl:variable name="BeneAccountCode"><xsl:value-of select="substring($BeneAccountNo,13,10)"/></xsl:variable>
							<xsl:variable name="BeneCustNoPrefix"><xsl:value-of select="substring($BeneAccountNo,4,1)"/></xsl:variable>
					    	<xsl:choose>					    	
								<xsl:when test="($BeneCustNoPrefix='9' or $BeneAccountCode = '2000200008')"><xsl:value-of select="'Y'"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="'N'"/></xsl:otherwise>
					    	</xsl:choose>	    						
						</xsl:when>
						<xsl:otherwise><xsl:value-of select="'N'"/></xsl:otherwise>
					</xsl:choose>
		    	</xsl:variable>
		    
		    	<!-- Check Applicant Account for RA or NRA -->
		    	<xsl:variable name="ApplAccountNo"><xsl:value-of select="applicant_act_no"/></xsl:variable>
		    	<xsl:variable name="ApplNRA">
					<xsl:choose>
						<xsl:when test="string-length($ApplAccountNo) = 24">
							<xsl:variable name="ApplAccountCode"><xsl:value-of select="substring($ApplAccountNo,13,10)"/></xsl:variable>
							<xsl:variable name="ApplCustNoPrefix"><xsl:value-of select="substring($ApplAccountNo,4,1)"/></xsl:variable>
					    	<xsl:choose>					    	
								<xsl:when test="($ApplCustNoPrefix='9' or $ApplAccountCode = '2000200008')"><xsl:value-of select="'Y'"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="'N'"/></xsl:otherwise>
					    	</xsl:choose>	    						
						</xsl:when>
						<xsl:otherwise><xsl:value-of select="'N'"/></xsl:otherwise>
					</xsl:choose>
		    	</xsl:variable>
		    
		    	<!-- Set the routing identifier for TPT -->
		    	<xsl:choose>
		    		<xsl:when test="ft_cur_code = 'CNY' and $ApplNRA = $BeneNRA"><xsl:value-of select="jetSpeed:getString('tpt.stp.routing.identifier')"/></xsl:when>
		    		<xsl:otherwise><xsl:value-of select="jetSpeed:getString('tpt.nonstp.routing.identifier')"/></xsl:otherwise>
		    	</xsl:choose>
		    		    
		    </xsl:if>


    	</xsl:variable>
    
    	<xsl:variable name="passRefId"><xsl:value-of select="default:getResource('PASS_FBCC_REFID_AS_IFMID')"/></xsl:variable>
    	
    	<xsl:variable name="msgType">
	    	<xsl:choose>
	    		<xsl:when test="bulk_ref_id[.!='']">BCIX</xsl:when>
	    		<xsl:otherwise>CIX</xsl:otherwise>
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
                        <Credit>
                            <PayType />
                            <AcctID>
                            	<AcctIDType>1</AcctIDType>
									<BIC>
		                            	<SortCode/>
									</BIC>
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
                            <CustMemo>
                                <CustMemoLine1>Online transfer from</CustMemoLine1>
                                <CustMemoLine2><xsl:value-of select="applicant_act_no" /></CustMemoLine2>
                                <CustMemoLine3><xsl:value-of select="applicant_name" /></CustMemoLine3>
                            </CustMemo>
                            <BankMemo />
                        </Credit>
                        <Debit>
                            <PayType><xsl:value-of select="sub_product_code"/></PayType>
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
                            <CustMemo>
                            	<CustMemoLine1>Online transfer to</CustMemoLine1>
                                <CustMemoLine2><xsl:value-of select="$routing_identifier" /><xsl:value-of select="counterparties/counterparty/counterparty_act_no" /></CustMemoLine2>
                                <CustMemoLine3><xsl:value-of select="counterparties/counterparty/counterparty_name" /></CustMemoLine3>
                            	<CustMemoLine4/>
								<CustMemoLine5/>
		                        <CustMemoLine6/>
                            </CustMemo>
                            <BankMemo/>
                        </Debit>
                    </AcctTransaction>
                </Transaction>
            </Content>
        </Message>
    </xsl:template>
</xsl:stylesheet>