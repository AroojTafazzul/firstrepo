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
            <statement_date><xsl:value-of select="substring(DateTimeIndicaton,5,2)" />/<xsl:value-of select="substring(DateTimeIndicaton,3,2)" />/20<xsl:value-of select="substring(DateTimeIndicaton,1,2)" /><xsl:text> </xsl:text><xsl:value-of select="substring(DateTimeIndicaton,7,2)" />:<xsl:value-of select="substring(DateTimeIndicaton,9,2)" />:00</statement_date>
            <account_balances />
            <xsl:variable name="cur_code" select="substring(FloorLimitIndicator1,1,3)" />
            <!-- Statement lines are recurrent -->
            <account_statement_lines>
                <xsl:for-each select="StmtLines">
                    <account_statement_line>
                        <xsl:apply-templates select="StatementLine">
                            <xsl:with-param name="info_acc_owner" select="InfoAccOwner" />
                            <xsl:with-param name="cur_code" select="$cur_code" />
                        </xsl:apply-templates>                           
                    </account_statement_line>                    
                </xsl:for-each>
            </account_statement_lines>
        </account_statement>
    </xsl:template>
   
    <!-- Parse a statement line:
        a bit complicated because of optional subfields  -->    
    <xsl:template match="StatementLine">
        <!-- Subfield Format Name 
        1 6!n Value Date (YYMMDD) 
        2 [4!n] Entry Date (MMDD) 
        3 2a Debit/Credit Mark 
        4 [1!a] Funds Code (3rd character of the currency code, if needed) 
        5 15d Amount 
        6 1!a3!c Transaction Type Identification Code 
        7 16x Reference for the Account Owner 
        8 [//16x] Account Servicing Institution's Reference 
        9 [34x] Supplementary Details -->
        <xsl:param name="info_acc_owner" />
        <xsl:param name="cur_code" />
        
        <!-- If the ten first are only numbers, the entry (post) date is present -->
        <xsl:if test="string-length(translate(substring(.,1,10), '0123456789',''))=0">
            <statement_line_value_date><xsl:value-of select="substring(.,5,2)" />/<xsl:value-of select="substring(.,3,2)" />/20<xsl:value-of select="substring(.,1,2)" /></statement_line_value_date>
            <statement_line_post_date><xsl:value-of select="substring(.,9,2)" />/<xsl:value-of select="substring(.,7,2)" />/20<xsl:value-of select="substring(.,1,2)" /></statement_line_post_date>
        </xsl:if>
        
        <!-- If the ten first aren't only numbers, the entry (post) date is NOT present -->
        <xsl:if test="string-length(translate(substring(.,1,10), '0123456789',''))!=0">
            <statement_line_value_date><xsl:value-of select="substring(.,5,2)" />/<xsl:value-of select="substring(.,3,2)" />/20<xsl:value-of select="substring(.,1,2)" /></statement_line_value_date>
            <statement_line_post_date />
        </xsl:if>
        <xsl:variable name="statementline1">
            <xsl:if test="string-length(translate(substring(.,1,10), '0123456789',''))=0">
                <xsl:value-of select="substring(.,11)" />
            </xsl:if>
            <xsl:if test="string-length(translate(substring(.,1,10), '0123456789',''))!=0">
                <xsl:value-of select="substring(.,7)" />
            </xsl:if>
        </xsl:variable>

        <!-- Whether the next 3 are all characters or not -->
        <xsl:if test="string-length(translate(substring($statementline1,1,3), '0123456789,',''))=1">
            <statement_line_dr_cr_flag><xsl:value-of select="substring($statementline1,1,1)" /></statement_line_dr_cr_flag>
        </xsl:if>
        <xsl:if test="string-length(translate(substring($statementline1,1,3), '0123456789,',''))=2">
            <statement_line_dr_cr_flag><xsl:value-of select="substring($statementline1,1,2)" /></statement_line_dr_cr_flag>
        </xsl:if>        
        <xsl:if test="string-length(translate(substring($statementline1,1,3), '0123456789,',''))=3">
            <statement_line_dr_cr_flag><xsl:value-of select="substring($statementline1,1,2)" /></statement_line_dr_cr_flag>
        </xsl:if>
        <xsl:variable name="statementline2">
            <xsl:if test="string-length(translate(substring($statementline1,1,3), '0123456789,',''))=1">
                <xsl:value-of select="substring($statementline1,2)" />
            </xsl:if>
            <xsl:if test="string-length(translate(substring($statementline1,1,3), '0123456789,',''))=2">
                <xsl:value-of select="substring($statementline1,3)" />
            </xsl:if>
            <xsl:if test="string-length(translate(substring($statementline1,1,3), '0123456789,',''))=3">
                <xsl:value-of select="substring($statementline1,4)" />
            </xsl:if>
        </xsl:variable>
        
        <!-- Retrieve next character after value, so we can know where amount field ends 
            Calls a recursive template that returns which is the next delimiter, that may be a F, N or S -->
        <xsl:variable name="next_char">
            <xsl:call-template name="nextChar">
                <xsl:with-param name="string" select="$statementline2" />
            </xsl:call-template>
        </xsl:variable>
        
        <statement_line_amt><xsl:value-of select="format-number(translate(substring-before($statementline2,$next_char),',','.'), '###,###,###,###,##0.000')" /></statement_line_amt>
        <xsl:variable name="statementline3" select="substring-after($statementline2,$next_char)" />
        
        <statement_line_type><xsl:value-of select="substring($statementline3,1,3)" /></statement_line_type>
        <xsl:variable name="statementline4" select="substring($statementline3,4)" />

        <xsl:if test="contains($statementline4,'//')">
            <statement_line_cust_ref_id><xsl:value-of select="substring-before($statementline4,'//')" /></statement_line_cust_ref_id>
            <xsl:variable name="statementline5" select="substring-after($statementline4,'//')" />
            <statement_line_bo_ref_id>
                <xsl:if test="contains($statementline5,'\n')">
                    <xsl:value-of select="substring-before($statementline5,'\n')" />
                </xsl:if>
                <xsl:if test="not(contains($statementline5,'\n'))">
                    <xsl:value-of select="$statementline5" />
                </xsl:if>
            </statement_line_bo_ref_id>
        </xsl:if>
        <xsl:if test="not(contains($statementline4,'//'))">
        	<xsl:if test="contains($statementline4,'\n')">
	            <statement_line_cust_ref_id>
	                <xsl:value-of select="substring-before($statementline4,'\n')" />
	            </statement_line_cust_ref_id>
	            <statement_line_bo_ref_id />
            </xsl:if>
            <xsl:if test="not(contains($statementline4,'\n'))">
	            <statement_line_cust_ref_id>
	                <xsl:value-of select="$statementline4" />
	            </statement_line_cust_ref_id>
	            <statement_line_bo_ref_id />
            </xsl:if>
        </xsl:if>

        <statement_line_entry_type>02</statement_line_entry_type>
        <statement_line_cur_code><xsl:value-of select="$cur_code" /></statement_line_cur_code>
        <statement_line_description><xsl:value-of select="$info_acc_owner" /></statement_line_description>
        <statement_line_attachment_id></statement_line_attachment_id>
    </xsl:template>
    
    <!-- Recursive template -->
    <xsl:template name="nextChar">
        <xsl:param name="string" />
        <xsl:choose>
            <xsl:when test="string-length(translate(substring($string,1,1), 'FNS',''))=0">
                <xsl:value-of select="substring($string,1,1)" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="nextChar">
                    <xsl:with-param name="string" select="substring($string, 2)" />
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
