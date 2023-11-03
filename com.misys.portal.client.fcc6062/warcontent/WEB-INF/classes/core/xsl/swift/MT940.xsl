<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:datetools="xalan://com.misys.portal.common.tools.ConvertTools" exclude-result-prefixes="datetools">
<!--
   Copyright (c) 2000-2008 Misys (http://www.misysbanking.com),
   All Rights Reserved. 
-->
	<xsl:template match="/">
		<xsl:apply-templates select="MeridianMessage[ExternalMessageType = 'MT940']" />
	</xsl:template>

	<xsl:template match="MeridianMessage[ExternalMessageType = 'MT940']">
	<accountStatements>
			<account>		
					<account_no>
						<xsl:value-of select="AccountId" />
					</account_no>
					<xsl:variable name="cur_code">
						<xsl:if test="substring(CloBalF,8,3) = ''">
							<xsl:value-of select="substring(CloBalM,8,3)" />
						</xsl:if>
						<xsl:if test="substring(CloBalM,8,3) = ''">
							<xsl:value-of select="substring(CloBalF,8,3)" />
						</xsl:if>						
					</xsl:variable>
					<cur_code><xsl:value-of select="$cur_code"></xsl:value-of></cur_code>
					<xsl:variable name="iso_code">
						<xsl:if test="substring(SenderAddress,1,8) != ''">
							<xsl:value-of select="substring(SenderAddress,1,8)" />
						</xsl:if>
						<xsl:if test="substring(SenderAddress,10,3) != ''">
							<xsl:value-of select="substring(SenderAddress,10,3)" />
						</xsl:if>
					</xsl:variable>
					<iso_code><xsl:value-of select="$iso_code" /></iso_code>
					<statements>
						<statement>
							<xsl:choose>
								<xsl:when test="contains(NumberSeq,'/')">
									<idx><xsl:value-of select="substring-before(NumberSeq,'/')" /></idx>
									<seq_idx><xsl:value-of select="substring-after(NumberSeq,'/')" /></seq_idx>
								</xsl:when>
								<xsl:otherwise>
									<idx><xsl:value-of select="NumberSeq" /></idx>
									<seq_idx />
									</xsl:otherwise>
							</xsl:choose>
							<type>02</type>
							<reference><xsl:value-of select="TRNO" /></reference>
							<description />
							<xsl:variable name="systemDate"><xsl:value-of select="datetools:getW3CIsoDateTime()"/></xsl:variable>
							<value_date><xsl:value-of select="substring($systemDate,9,2)" />/<xsl:value-of select="substring($systemDate,6,2)" />/<xsl:value-of select="substring($systemDate,1,4)" /><xsl:value-of select="' '"></xsl:value-of><xsl:value-of select="substring($systemDate,12)" /> AM</value_date>
							
							<!-- Opening and closing balances are mandatory -->
							<balances>
								<xsl:apply-templates select="OpBalM" />
								<xsl:apply-templates select="CloBalM" />
								<xsl:apply-templates select="OpBalF" />
								<xsl:apply-templates select="CloBalF" />
								<!-- Closing available is optional -->
								<xsl:apply-templates select="CloAvailBal" />
								<!-- Forward available are optional and recurrent -->
								<xsl:for-each select="FwdAvailableBalance">
									<xsl:apply-templates select="FwdAvailBal" />
								</xsl:for-each>
								<!-- To add ledger balance = Closing Balance if Clsing Balance is given -->
								<xsl:apply-templates select="CloBalF" >
									<xsl:with-param name="LedgBal" select="CloBalF"/>
								</xsl:apply-templates>
							</balances>
							<!-- Statement lines are recurrent -->
							<lines>
							<xsl:for-each select="Statement">
								<xsl:if test="StatementLine">							
									<xsl:apply-templates select="StatementLine">
										<xsl:with-param name="info_acc_owner" select="InfoAccOwner" />
										<xsl:with-param name="cur_code" select="$cur_code" />
									</xsl:apply-templates>  							                   
								</xsl:if>
							</xsl:for-each>
							</lines>
						</statement>
					</statements>			
			</account>
	   </accountStatements>
	</xsl:template>
	
	
<!-- Match any kind of balance, and autodetect type -->    
	<xsl:template match="OpBalF|CloBalF|OpBalM|CloBalM|CloAvailBal|FwdAvailBal">
		<xsl:param name="LedgBal"/>
		<balance>
			<type>
				<xsl:choose>
					<xsl:when test="name()='OpBalF'">01</xsl:when>
					<xsl:when test="name()='CloBalF'">
					<xsl:choose>
					<xsl:when test="not($LedgBal)">02</xsl:when>
					<xsl:otherwise>05</xsl:otherwise>
					</xsl:choose>
					</xsl:when>
					<!-- The OpBalM & CloBalM should not be stored as they are intermediary balances -->
					<xsl:when test="name()='OpBalM'"></xsl:when>
					<xsl:when test="name()='CloBalM'"></xsl:when>
					<xsl:when test="name()='CloAvailBal'">03</xsl:when>
					<xsl:when test="name()='FwdAvailBal'">04</xsl:when>
				</xsl:choose>
			</type>
			
			<xsl:variable name="sign">
	        	<xsl:if test="substring(.,1,1) = 'D'">-</xsl:if>
			</xsl:variable>
			<value_date><xsl:value-of select="substring(.,6,2)" />/<xsl:value-of select="substring(.,4,2)" />/20<xsl:value-of select="substring(.,2,2)" /></value_date>
			<cur_code><xsl:value-of select="substring(.,8,3)" /></cur_code>
			<amt>
				<xsl:value-of select="$sign"/>
				<xsl:value-of select="format-number(translate(substring(.,11),',','.'), '###,###,###,###,##0.000')" />
			</amt>
		</balance>
	</xsl:template>
	
	
	<xsl:template match="StatementLine">
		<xsl:param name="info_acc_owner" />
        <xsl:param name="cur_code" />
		<line>			
			<!-- If the ten first are only numbers, the entry (post) date is present -->
	        <xsl:if test="string-length(translate(substring(.,1,10), '0123456789',''))=0">
	            <value_date><xsl:value-of select="substring(.,5,2)" />/<xsl:value-of select="substring(.,3,2)" />/20<xsl:value-of select="substring(.,1,2)" /></value_date>
	            <post_date><xsl:value-of select="substring(.,9,2)" />/<xsl:value-of select="substring(.,7,2)" />/20<xsl:value-of select="substring(.,1,2)" /></post_date>
	        </xsl:if>
	        
	        <!-- If the ten first aren't only numbers, the entry (post) date is NOT present -->
	        <xsl:if test="string-length(translate(substring(.,1,10), '0123456789',''))!=0">
	            <value_date><xsl:value-of select="substring(.,5,2)" />/<xsl:value-of select="substring(.,3,2)" />/20<xsl:value-of select="substring(.,1,2)" /></value_date>
	            <post_date/>
	        </xsl:if>
	        
	        <xsl:variable name="statementline1">
	            <xsl:if test="string-length(translate(substring(.,1,10), '0123456789',''))=0">
	                <xsl:value-of select="substring(.,11)" />
	            </xsl:if>
	            <xsl:if test="string-length(translate(substring(.,1,10), '0123456789',''))!=0">
	                <xsl:value-of select="substring(.,7)" />
	            </xsl:if>
	        </xsl:variable>
	
	        <!-- Whether the next 3 are all characters or not TODO-->
	        
	        <xsl:variable name="sign">
		        <xsl:if test="string-length(translate(substring($statementline1,1,3), '0123456789,',''))=1">
		            <xsl:value-of select="substring($statementline1,1,1)" />
		        </xsl:if>
		        <xsl:if test="string-length(translate(substring($statementline1,1,3), '0123456789,',''))=2">
		            <xsl:value-of select="substring($statementline1,1,2)" />
		        </xsl:if>        
		        <xsl:if test="string-length(translate(substring($statementline1,1,3), '0123456789,',''))=3">
		            <xsl:value-of select="substring($statementline1,1,1)" />
		        </xsl:if>
	        </xsl:variable>
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
	
				<xsl:if test="$sign = 'D' or starts-with($sign, 'D') ">
					<withdrawal>
						<xsl:value-of
							select="format-number(translate(substring-before($statementline2,$next_char),',','.'), '###,###,###,###,##0.000')" />
					</withdrawal>						
				</xsl:if>
				<xsl:if test="$sign = 'C' or starts-with($sign, 'C')">
					<deposit>
						<xsl:value-of
							select="format-number(translate(substring-before($statementline2,$next_char),',','.'), '###,###,###,###,##0.000')" />
					</deposit>			
				</xsl:if>
				<xsl:if test="$sign = 'RC'">
					<withdrawal>
						<xsl:value-of
							select="format-number(translate(substring-before($statementline2,$next_char),',','.'), '###,###,###,###,##0.000')" />
					</withdrawal>						
				</xsl:if>
				<xsl:if test="$sign = 'RD'">
					<deposit>
						<xsl:value-of
							select="format-number(translate(substring-before($statementline2,$next_char),',','.'), '###,###,###,###,##0.000')" />
					</deposit>			
				</xsl:if>
	        
	        <xsl:variable name="statementline3" select="substring-after($statementline2,$next_char)" />
	        
	        <!-- <type><xsl:value-of select="substring($statementline3,1,3)" /></type> -->
	        <xsl:variable name="statementline4" select="substring($statementline3,4)" />
	
	        <xsl:if test="contains($statementline4,'//')">
	            <cust_ref_id><xsl:value-of select="substring-before($statementline4,'//')" /></cust_ref_id>
	            <xsl:variable name="statementline5" select="substring-after($statementline4,'//')" />
	             <xsl:if test="contains($statementline5,'\n')">
	                	<bo_ref_id>
	                    	<xsl:value-of select="substring-before($statementline5,'\n')" />
	                    </bo_ref_id>
	                    <supplementary_details><xsl:value-of select="substring-after($statementline5,'\n')" /></supplementary_details>
	                </xsl:if>
	                <xsl:if test="not(contains($statementline5,'\n'))">
		                <bo_ref_id>
		                    <xsl:value-of select="$statementline5" />
		                </bo_ref_id>
		                <supplementary_details/>
	                </xsl:if>
	        </xsl:if>
	        <xsl:if test="not(contains($statementline4,'//'))">
	        	<xsl:if test="contains($statementline4,'\n')">
		            <cust_ref_id>
		                <xsl:value-of select="substring-before($statementline4,'\n')" />
		            </cust_ref_id>
		            <statement_line_bo_ref_id />
	                <supplementary_details><xsl:value-of select="substring-after($statementline4,'\n')" /></supplementary_details>
	            </xsl:if>
	            <xsl:if test="not(contains($statementline4,'\n'))">
		            <cust_ref_id>
		                <xsl:value-of select="$statementline4" />
		            </cust_ref_id>
		            <statement_line_bo_ref_id />
		            <supplementary_details/>
	            </xsl:if>
	        </xsl:if>
	        <entry_type>02</entry_type>
	        <cur_code><xsl:value-of select="$cur_code" /></cur_code>
	        <description><xsl:value-of select="$info_acc_owner" /></description>			
		</line>
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
