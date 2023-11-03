<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:tools="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	exclude-result-prefixes="tools utils">

    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" />
    <!-- Get the interface environment -->
    <xsl:param name="context" />
    <xsl:param name="language">en</xsl:param>
    <!--
    	Copyright (c) 2000-2010 Misys (http://www.misys.com),
    	All Rights Reserved. 
    -->
    <!-- Match template -->
    <xsl:template match="/">
        <xsl:apply-templates select="user" />
    </xsl:template>
    <xsl:template match="user">
        <Message>
            <Header>
                <MsgType>PMB</MsgType>
                <MsgID>
                  <IFMid><xsl:value-of select="tools:generateCustomerReferenceMhubId()" /></IFMid>
                </MsgID>
            </Header>
            <Content>
				<Request>
	                <RequestType>PRINT</RequestType>
	                <PrintRequest>
	                    <PrintRequestType>3</PrintRequestType>
	                    <PrintRequestArgs>
	                        <PrintRequestArg>
	                            <PrintRequestArgName>LOGONID</PrintRequestArgName>
	                            <PrintRequestArgValue><xsl:value-of select="substring(login_id, 1, 100)" /></PrintRequestArgValue>
	                        </PrintRequestArg>
	                        <PrintRequestArg>
	                            <PrintRequestArgName>PASSWORD</PrintRequestArgName>
	                            <PrintRequestArgValue><xsl:value-of select="tools:encryptForMHUB(substring(password_value, 1, 100))" /></PrintRequestArgValue>
	                        </PrintRequestArg>
							<!-- 
	                        <PrintRequestArg>
	                            <PrintRequestArgName>REFID</PrintRequestArgName>
	                            <PrintRequestArgValue></PrintRequestArgValue>
	                        </PrintRequestArg>
	                         -->
	                        <PrintRequestArg>
	                            <PrintRequestArgName>HOSTCUSTID</PrintRequestArgName>
	                            <PrintRequestArgValue>
	                                <xsl:value-of select="substring(default_contract_id, 1, 100)" />
	                            </PrintRequestArgValue>
	                        </PrintRequestArg>
							<PrintRequestArg>
	                            <PrintRequestArgName>CUSTNAME</PrintRequestArgName>
	                            <PrintRequestArgValue><xsl:value-of select="substring(first_name, 1, 100)" />&#160;<xsl:value-of select="substring(last_name, 1, 100)" /></PrintRequestArgValue>
	                        </PrintRequestArg>
	                        <PrintRequestArg>
	                            <PrintRequestArgName>CUSTCONTACTNAME</PrintRequestArgName>
	                            <PrintRequestArgValue><xsl:value-of select="substring(first_name, 1, 100)" />&#160;<xsl:value-of select="substring(last_name, 1, 100)" /></PrintRequestArgValue>
	                        </PrintRequestArg>
	                        <PrintRequestArg>
	                            <PrintRequestArgName>CUSTCONTACTADDR1</PrintRequestArgName>
	                            <PrintRequestArgValue><xsl:value-of select="substring(address_line_1, 1, 100)" /></PrintRequestArgValue>
	                        </PrintRequestArg>
	                        <PrintRequestArg>
	                            <PrintRequestArgName>CUSTCONTACTADDR2</PrintRequestArgName>
	                            <PrintRequestArgValue><xsl:value-of select="substring(address_line_2, 1, 100)" /></PrintRequestArgValue>
	                        </PrintRequestArg>
	                        <PrintRequestArg>
	                            <PrintRequestArgName>CUSTCONTACTCITY</PrintRequestArgName>
	                            <PrintRequestArgValue><xsl:value-of select="substring(dom, 1, 100)" /></PrintRequestArgValue>
	                        </PrintRequestArg>
							<PrintRequestArg>
	                            <PrintRequestArgName>CUSTCONTACTCOUNTY</PrintRequestArgName>
	                            <PrintRequestArgValue></PrintRequestArgValue>
	                        </PrintRequestArg>
	                        <PrintRequestArg>
	                            <PrintRequestArgName>CUSTCONTACTCOUNTRY</PrintRequestArgName>
	                            <PrintRequestArgValue><xsl:value-of select="utils:getOwnerBankCountryCodeForUser(user_id)" /></PrintRequestArgValue>
	                        </PrintRequestArg>
	                        <PrintRequestArg>
	                            <PrintRequestArgName>CUSTCONTACTPOSTCODE</PrintRequestArgName>
	                            <PrintRequestArgValue></PrintRequestArgValue>
	                        </PrintRequestArg>
	                        <PrintRequestArg>
	                            <PrintRequestArgName>CUSTCONTACTEMAIL</PrintRequestArgName>
	                            <PrintRequestArgValue><xsl:value-of select="substring(email, 1, 100)" /></PrintRequestArgValue>
	                        </PrintRequestArg>
	                        <PrintRequestArg>
	                            <PrintRequestArgName>CUSTCONTACTPHONE</PrintRequestArgName>
	                            <PrintRequestArgValue><xsl:value-of select="substring(phone, 1, 100)" /></PrintRequestArgValue>
	                        </PrintRequestArg>
							<!-- 
	                        <PrintRequestArg>
	                            <PrintRequestArgName>USERNAME</PrintRequestArgName>
	                            <PrintRequestArgValue></PrintRequestArgValue>
	                        </PrintRequestArg>
	                        <PrintRequestArg>
	                            <PrintRequestArgName>USERMOBILECC</PrintRequestArgName>
	                            <PrintRequestArgValue></PrintRequestArgValue>
	                        </PrintRequestArg>
	                        <PrintRequestArg>
	                            <PrintRequestArgName>USERMOBILENUMBER</PrintRequestArgName>
	                            <PrintRequestArgValue></PrintRequestArgValue>
	                        </PrintRequestArg>
	                        <PrintRequestArg>
	                            <PrintRequestArgName>USEREMAIL</PrintRequestArgName>
	                            <PrintRequestArgValue></PrintRequestArgValue>
	                        </PrintRequestArg>
	                        <PrintRequestArg>
	                            <PrintRequestArgName>LETTERDATETIME</PrintRequestArgName>
	                            <PrintRequestArgValue></PrintRequestArgValue>
	                        </PrintRequestArg>
	                        <PrintRequestArg>
	                            <PrintRequestArgName>MOBILEACTIVATECODE</PrintRequestArgName>
	                            <PrintRequestArgValue></PrintRequestArgValue>
	                        </PrintRequestArg>
	                        <PrintRequestArg>
	                            <PrintRequestArgName>MOBILEPIN</PrintRequestArgName>
	                            <PrintRequestArgValue></PrintRequestArgValue>
	                        </PrintRequestArg>
	                        -->
	                    </PrintRequestArgs>
	                </PrintRequest>
                </Request>
            </Content>
        </Message>
    </xsl:template>
</xsl:stylesheet>
