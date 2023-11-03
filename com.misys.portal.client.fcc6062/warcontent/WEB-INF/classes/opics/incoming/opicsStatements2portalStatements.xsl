<?xml version="1.0"?>
<!--
   Copyright (c) 2000-2011 Misys (http://www.misys.com),
   All Rights Reserved. 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
				xmlns:tools="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
				exclude-result-prefixes="tools">

		
	<!-- Statements -->
	<xsl:template match="Publications" mode="statements">
		<accountStatements>
			<xsl:apply-templates select="Publication/ItemArray/anyType" mode="statement"/>
		</accountStatements>
	</xsl:template>
	<!-- Balances -->
	<xsl:template match="Publications" mode="balances">
		<accountStatements>
			<xsl:apply-templates select="Publication/ItemArray/anyType" mode="balance"/>
		</accountStatements>
	</xsl:template>
	
	<!-- Processing statements -->
		<xsl:template match="anyType" mode="statement">
		<xsl:variable name="product_code" select="'FX'"/>
		<xsl:variable name="cust_ref_id" ><xsl:value-of select="CNO"/></xsl:variable>
		<xsl:variable name="companyInfos" select="tools:retrieveCompanyInfosFrom($product_code, $cust_ref_id)"/>
		<xsl:variable name="customerBankRef" select="$companyInfos/references/customer_bank_reference"/>
		
		<xsl:if test="ACCOUNTNO != ''">
		<xsl:variable name="acctid"><xsl:value-of select="tools:retrieveAccountIdFromAccountNumber(ACCOUNTNO, $customerBankRef)"/></xsl:variable>
		<xsl:if test="$acctid != ''">
		<account>		
			<account_no><xsl:value-of select="ACCOUNTNO"/></account_no>
			<cur_code><xsl:value-of select="CCY"/></cur_code>
			<bo_cust_number><xsl:value-of select="$customerBankRef"/></bo_cust_number>
			<statements>
				<statement>
					<xsl:if test="BR and CNO">
						<customer_reference>
							<xsl:value-of select="BR"/>/<xsl:value-of select="CNO"/>
						</customer_reference>
					</xsl:if>
					
					<statement_id><xsl:value-of select="tools:retrieveStatementIdFrom($customerBankRef, ACCOUNTNO)"/></statement_id>
					
					<xsl:if test="BR and CNO">
						<account_id>
							<xsl:value-of select="$acctid"/>
						</account_id>
					</xsl:if>
								
					<type>02</type>
					<brch_code>00001</brch_code>
					<idx>1</idx>
					<seq_idx>1</seq_idx>
									
					<balances/>
					
					<lines>
						<xsl:call-template name="line-details">
							<xsl:with-param name="statement_id">
								<xsl:value-of select="tools:retrieveStatementIdFrom($customerBankRef, ACCOUNTNO)"/>
							</xsl:with-param>
						</xsl:call-template>
					</lines>
				</statement>
			</statements>
		</account>
		</xsl:if>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="line-details">
		<xsl:param name="statement_id"/>
		<line>
			<statement_id>
				<xsl:value-of select="$statement_id"/>
			</statement_id>
			
			<line_id><xsl:if test="$statement_id!=''"><xsl:value-of select="tools:retrieveLineIdFrom($statement_id, DEALNO)"/></xsl:if></line_id>
			
			<xsl:if test="DEALDATE">
				<post_date>
					<xsl:call-template name="opicsDateStatement2portalDate">
						<xsl:with-param name="date"><xsl:value-of select="DEALDATE"/></xsl:with-param>
					</xsl:call-template>
				</post_date>
			</xsl:if>
			<xsl:if test="VDATE">
				<value_date>
					<xsl:call-template name="opicsDateStatement2portalDate">
						<xsl:with-param name="date"><xsl:value-of select="VDATE"/></xsl:with-param>
					</xsl:call-template>
				</value_date>
			</xsl:if>
			<xsl:if test="CCY">
				<cur_code>
					<xsl:value-of select="CCY"/>
				</cur_code>
			</xsl:if>
			<xsl:if test="CCYAMOUNT">
				<xsl:choose>
					<xsl:when test="CCYAMOUNT &lt; 0">
						<withdrawal>
							<xsl:call-template name="format-and-absolute-amount">
								<xsl:with-param name="amount"><xsl:value-of select="CCYAMOUNT"/></xsl:with-param>
							</xsl:call-template>
						</withdrawal>
						<deposit/>
						<type>900</type>
					</xsl:when>
					<xsl:otherwise>
						<withdrawal/>
						<deposit>
							<xsl:call-template name="format-and-absolute-amount">
								<xsl:with-param name="amount"><xsl:value-of select="CCYAMOUNT"/></xsl:with-param>
							</xsl:call-template>
						</deposit>
						<type>910</type>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			<xsl:if test="CUSTREFNO1">
				<cust_ref_id>
					<xsl:value-of select="CUSTREFNO1"/>
				</cust_ref_id>
			</xsl:if>
			<xsl:if test="DEALNO">
				<bo_ref_id>
					<xsl:value-of select="DEALNO"/>
				</bo_ref_id>
			</xsl:if>
			<entry_type>02</entry_type>
			<xsl:if test="EXTDESCR">
				<description>
					<xsl:value-of select="EXTDESCR"/>
				</description>
			</xsl:if>
			<runbal_booked/>
			<runbal_cleared/>
			<xsl:if test="ASTMTTEXT1">
				<reference_1>
					<xsl:value-of select="ASTMTTEXT1"/>
				</reference_1>
			</xsl:if>
			<xsl:if test="ASTMTTEXT2">
				<reference_2>
					<xsl:value-of select="ASTMTTEXT2"/>
				</reference_2>
			</xsl:if>
			<xsl:if test="ASTMTTEXT3">
				<reference_3>
					<xsl:value-of select="ASTMTTEXT3"/>
				</reference_3>
			</xsl:if>
			<xsl:if test="ASTMTTEXT4">
				<reference_4>
					<xsl:value-of select="ASTMTTEXT4"/>
				</reference_4>
			</xsl:if>
			<xsl:if test="ASTMTTEXT5">
				<reference_5>
					<xsl:value-of select="ASTMTTEXT5"/>
				</reference_5>
			</xsl:if>
			<xsl:if test="DESCRIPTION">
				<supplementary_details>
					<xsl:value-of select="DESCRIPTION"/>
				</supplementary_details>
			</xsl:if>
		
			<!-- elements for settlement details -->
			<!-- Settlement details -->
			<!-- <xsl:call-template name="opicsCMDTAccountStatement2portal"/> -->				
			 																						
		</line>
	</xsl:template>
	
	<!-- Processing balances -->
	<xsl:template match="anyType" mode="balance">	
		<xsl:variable name="product_code" select="'FX'"/>
		<xsl:variable name="cust_ref_id" ><xsl:value-of select="CNO"/></xsl:variable>
		<xsl:variable name="companyInfos" select="tools:retrieveCompanyInfosFrom($product_code, $cust_ref_id)"/>
		<xsl:variable name="customerBankRef" select="$companyInfos/references/customer_bank_reference"/>
		
		<xsl:variable name="acctid"><xsl:value-of select="tools:retrieveAccountIdFromAccountNumber(ACCOUNTNO, $customerBankRef)"/></xsl:variable>
		<xsl:if test="$acctid != ''">
		<account>
			<account_no><xsl:value-of select="ACCOUNTNO"/></account_no>
			<cur_code><xsl:value-of select="CCY"/></cur_code>
			<bo_cust_number><xsl:value-of select="$customerBankRef"/></bo_cust_number>
			<statements>
				<statement>			
					<xsl:if test="BR and CNO">
						<customer_reference>
							<xsl:value-of select="BR"/>/<xsl:value-of select="CNO"/>
						</customer_reference>
					</xsl:if>
					
					<statement_id><xsl:value-of select="tools:retrieveStatementIdFrom($customerBankRef, ACCOUNTNO)"/></statement_id>
					
					<xsl:if test="BR and CNO and ACCOUNTNO">
						<account_id>
							<xsl:value-of select="tools:retrieveAccountIdFromAccountNumber(ACCOUNTNO, $customerBankRef)"/>
						</account_id>
					</xsl:if>
					<type>02</type>
					<brch_code>00001</brch_code>
					<idx>1</idx>
					<seq_idx>1</seq_idx>			
					<balances>
						<xsl:call-template name="balance-details">
							<xsl:with-param name="statement_id">
								<xsl:value-of select="tools:retrieveStatementIdFrom($customerBankRef, ACCOUNTNO)"/>
							</xsl:with-param>
						</xsl:call-template>
					</balances>			
					<lines/>			
				</statement>
			</statements>
		</account>
		</xsl:if>
	</xsl:template>
	
	<!-- Processing Balances -->
	<xsl:template name="balance-details">
		<xsl:param name="statement_id"/>
		<xsl:if test="OPENBALANCE">
		<balance>
			<statement_id><xsl:value-of select="$statement_id"/></statement_id>
			<balance_id><xsl:value-of select="tools:retrieveBalanceIdFrom($statement_id, '01')"/></balance_id>
			<type>01</type>			
			<xsl:if test="POSTDATE">
				<value_date>
					<xsl:call-template name="opicsDateStatement2portalDate">
						<xsl:with-param name="date"><xsl:value-of select="POSTDATE"/></xsl:with-param>
					</xsl:call-template>
				</value_date>
			</xsl:if>
			<xsl:if test="CCY">
				<cur_code>
					<xsl:value-of select="CCY"/>
				</cur_code>
			</xsl:if>
			<amt>
				<xsl:value-of select='format-number(OPENBALANCE, "###,###,##0.00")' />
			</amt>
		</balance>
		</xsl:if>
		<xsl:if test="CURBALANCE">
		<balance>
			<statement_id><xsl:value-of select="$statement_id"/></statement_id>
			<balance_id><xsl:value-of select="tools:retrieveBalanceIdFrom($statement_id, '03')"/></balance_id>
			<type>03</type>			
			<xsl:if test="POSTDATE">
				<value_date>
					<xsl:call-template name="opicsDateStatement2portalDate">
						<xsl:with-param name="date"><xsl:value-of select="POSTDATE"/></xsl:with-param>
					</xsl:call-template>
				</value_date>
			</xsl:if>
			<xsl:if test="CCY">
				<cur_code>
					<xsl:value-of select="CCY"/>
				</cur_code>
			</xsl:if>			
			<amt>
				<xsl:value-of select='format-number(CURBALANCE, "###,###,##0.00")' />
			</amt>			
		</balance>
		</xsl:if><xsl:if test="CURBALANCE">
		<balance>
			<statement_id><xsl:value-of select="$statement_id"/></statement_id>
			<balance_id><xsl:value-of select="tools:retrieveBalanceIdFrom($statement_id, '05')"/></balance_id>
			<type>05</type>			
			<xsl:if test="POSTDATE">
				<value_date>
					<xsl:call-template name="opicsDateStatement2portalDate">
						<xsl:with-param name="date"><xsl:value-of select="POSTDATE"/></xsl:with-param>
					</xsl:call-template>
				</value_date>
			</xsl:if>
			<xsl:if test="CCY">
				<cur_code>
					<xsl:value-of select="CCY"/>
				</cur_code>
			</xsl:if>			
			<amt>
				<xsl:value-of select='format-number(CURBALANCE, "###,###,##0.00")' />
			</amt>			
		</balance>
		</xsl:if>
	</xsl:template>
	
	
	<!-- Mapping of Opics date type  (change to 'YYYY-MMM-DD' or 'YYYY-MM-DD' for DB store if not displayed) -->
	<xsl:template name="opicsDateStatement2portalDate">
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
				<xsl:otherwise>
					<xsl:value-of select="substring($date, 1, 10)"/>
				</xsl:otherwise>
			</xsl:choose>
	</xsl:template>	

	<xsl:template name="opicsCMDTAccountStatement2portal">
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
									
						<beneficiary_city><xsl:value-of select="BENDETAILS/C3" /></beneficiary_city>
						<beneficiary_country_text><xsl:value-of select="BENDETAILS/C4" /></beneficiary_country_text>
						<!-- <beneficiary_address_line_1><xsl:value-of select="BENDETAILS/C2" /></beneficiary_address_line_1> -->
						<beneficiary_address><xsl:value-of select="BENDETAILS/C2" /></beneficiary_address>
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
					<intermediary_bank_country><xsl:value-of select="INTERMEDIARY/C4"/></intermediary_bank_country>
					
					<intermediary_bank_bic><xsl:value-of select="INTERMEDIARY/BIC"/></intermediary_bank_bic>
					
					<intermediary_bank_aba><xsl:value-of select="INTERMEDIARY/ACCOUNT"/></intermediary_bank_aba>
			</xsl:if>			
			<xsl:if test="ORDERING">			
					<ordering_cust_name><xsl:value-of select="ORDERING/C1"/></ordering_cust_name>
					<ordering_cust_address><xsl:value-of select="ORDERING/C2"/></ordering_cust_address>
					<ordering_cust_citystate><xsl:value-of select="ORDERING/C3"/></ordering_cust_citystate>
					<ordering_cust_country><xsl:value-of select="ORDERING/C4"/></ordering_cust_country>
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
				<beneficiary_bank_city><xsl:value-of select="AWBANK/C4" /></beneficiary_bank_city>
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