<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!-- Copyright (c) 2000-2008 Misys (http://www.misys.com),
   All Rights Reserved.  -->
    <xsl:template match="/">
        <xsl:apply-templates select="MeridianMessage" />
    </xsl:template>
    <xsl:template match="MeridianMessage">
        <account_statement xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/accountStatement.xsd">
            <swift_message_type><xsl:value-of select="ExternalMessageType" /></swift_message_type>
            <account_no><xsl:value-of select="AccountId" /></account_no>
            <statement_type>01</statement_type>
            <xsl:choose>
                <xsl:when test="contains(NumberSeq,'/')">
                    <statement_number><xsl:value-of select="substring-before(NumberSeq,'/')" /></statement_number>
                    <statement_sequence_number><xsl:value-of select="substring-after(NumberSeq,'/')" /></statement_sequence_number>
                </xsl:when>
                <xsl:otherwise>
                    <statement_number><xsl:value-of select="NumberSeq" /></statement_number>
                    <statement_sequence_number />
                </xsl:otherwise>
            </xsl:choose>
            <statement_reference><xsl:value-of select="TRNO" /></statement_reference>
            <statement_description></statement_description>
            <!-- TODO verify how to handle timezone info -->
            <statement_date><xsl:if test="DateTimeIndicaton!=''"><xsl:value-of select="substring(DateTimeIndicaton,5,2)" />/<xsl:value-of select="substring(DateTimeIndicaton,3,2)" />/20<xsl:value-of select="substring(DateTimeIndicaton,1,2)" /><xsl:text> </xsl:text><xsl:value-of select="substring(DateTimeIndicaton,7,2)" />:<xsl:value-of select="substring(DateTimeIndicaton,9,2)" />:00</xsl:if></statement_date>
            <account_balances>
                <!-- Opening and closing balances are mandatory -->
                <xsl:apply-templates select="OpeningBalance" />
                <xsl:apply-templates select="ClosingBalanceBookedFunds" />
                <!-- Closing available is optional -->
                <xsl:apply-templates select="ClosingAvailableBalance" />
                <!-- Forward available are optional and recurrent -->
                <xsl:for-each select="ForwardBalance">
                    <xsl:apply-templates select="ForwardAvailableBalance" />
                </xsl:for-each>
            </account_balances>

            <!-- Statement lines are recurrent -->
            <account_statement_lines />
        </account_statement>
    </xsl:template>
    
    <!-- Match any kind of balance, and autodetect type -->    
    <xsl:template match="OpeningBalance|ClosingBalanceBookedFunds|ClosingAvailableBalance|ForwardAvailableBalance">
        <account_balance>
            <balance_type>
                <xsl:choose>
                    <xsl:when test="name()='OpeningBalance'">01</xsl:when>
                    <xsl:when test="name()='ClosingBalanceBookedFunds'">02</xsl:when>
                    <xsl:when test="name()='ClosingAvailableBalance'">03</xsl:when>
                    <xsl:when test="name()='ForwardAvailableBalance'">04</xsl:when>
                </xsl:choose>
            </balance_type>
            <balance_sign><xsl:value-of select="substring(.,1,1)" /></balance_sign>
            <balance_date><xsl:value-of select="substring(.,6,2)" />/<xsl:value-of select="substring(.,4,2)" />/20<xsl:value-of select="substring(.,2,2)" /></balance_date>
            <balance_cur_code><xsl:value-of select="substring(.,8,3)" /></balance_cur_code>
            <balance_amt><xsl:value-of select="format-number(translate(substring(.,11),',','.'), '###,###,###,###,##0.000')" /></balance_amt>
        </account_balance>
    </xsl:template>
</xsl:stylesheet>
