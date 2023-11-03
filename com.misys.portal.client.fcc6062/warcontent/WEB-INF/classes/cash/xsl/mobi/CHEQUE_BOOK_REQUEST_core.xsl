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
        <xsl:apply-templates select="se_tnx_record"/>
    </xsl:template>

    <xsl:template match="se_tnx_record">
        <xsl:variable name="passRefId"><xsl:value-of select="default:getResource('PASS_FBCC_REFID_AS_IFMID')"/></xsl:variable>
    
        <Message>
            <Header>
                <MsgType>REQUEST</MsgType>
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
            </Header>
            <Content>
              <Request>	
		             <RequestOwner>
			               <AcctID>
							<AcctNo>
								<xsl:value-of select="./additional_field[@name='applicant_act_no']" />
							</AcctNo>
						  </AcctID>
			               <BMCustNo><xsl:value-of select="company_id"/></BMCustNo>
		             </RequestOwner>
		             <RequestType>CHEQUE-BOOK</RequestType>
		        <ChequeBookData>
						<ChequeBookType>
							<xsl:value-of select="./additional_field[@name='cheque_type']" />
						</ChequeBookType>
						<NoCopies>
							<xsl:value-of select="./additional_field[@name='no_of_cheque_books']" />
						</NoCopies>
						<CollectionPoint>n/a</CollectionPoint>
						<CollectionDateTime>n/a</CollectionDateTime>
					</ChequeBookData>
					<DateTime>
						<xsl:value-of select="./additional_field[@name='date_time']" />
					</DateTime>
             </Request>
            </Content>
        </Message>
    </xsl:template>
</xsl:stylesheet>
