<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:manager="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	xmlns:tools="xalan://com.misys.portal.common.tools.ConvertTools"
	xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	xmlns:businesscode="xalan://com.misys.portal.common.resources.BusinessCodesResourceProvider" 
	exclude-result-prefixes="manager utils tools security localization defaultresource businesscode">
	
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	
	<xsl:param name="banks"/>
	<xsl:param name="language">en</xsl:param>
	<!--
	Copyright (c) 2000-2012 Misys (http://www.misys.com),
	All Rights Reserved. 
	-->
	<xsl:template match="Message/Content/Account/AcctDetail">
		<xsl:variable name="references" select="manager:manageCompanyReferences(BMCustNo, $banks, 'FT')"/>
		<xsl:variable name="company_id" select="$references/references/company_id"/>
		<xsl:variable name="bank_abbv_name" select="$references/references/main_bank_abbv_name"/>
		<xsl:variable name="bank_name" select="$references/references/main_bank_name"/>
		<xsl:variable name="address_line_1" select="$references/references/address_line_1"/>
		<xsl:variable name="address_line_2" select="$references/references/address_line_2"/>
		<xsl:variable name="dom" select="$references/references/dom"/>
		<xsl:variable name="iso_code" select="$references/references/iso_code"/>
		<xsl:variable name="country" select="$references/references/country"/>
        <xsl:variable name="accType">
            <xsl:choose>
                <xsl:when test="AcctType">
                   <xsl:value-of select="utils:trimTheValue(AcctType)"/>
                </xsl:when>
                <xsl:otherwise>
                   <xsl:value-of select="utils:getAccountType(AcctID/AcctNo)"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
		<xsl:variable name="internalAcctType" select="utils:retrieveInternalAccountType($accType, $company_id)"/>
		<xsl:variable name="acctStmtReferences" select="manager:manageAccountStatementReferences(AcctID/AcctNo, BMCustNo,$banks,'FT')" />
		<xsl:variable name="bmCustNo" select="manager:getDefCustRef(BMCustNo,$banks,'FT')"/>
		<xsl:variable name="accountNRA" select="AcctID/AcctNo"/>
		<result>
			<com.misys.portal.interfaces.incoming.AccountSet>
            <xsl:choose>
                <xsl:when test="AccountHolds">
                     <xsl:apply-templates select="AccountHolds">
                         <xsl:with-param name="internalAcctType" select="$internalAcctType"/>
                         <xsl:with-param name="acctId" select="$acctStmtReferences/references/account_id"/>
                     </xsl:apply-templates>
                 </xsl:when>
                 <xsl:when test="AccountAddlDetails">
					<xsl:call-template name="accounts">
						<xsl:with-param name="acctId" select="$acctStmtReferences/references/account_id"/>
						<xsl:with-param name="acctStmtReferences" select="$acctStmtReferences"/>
                 	 	<xsl:with-param name="internalAcctType" select="$internalAcctType"/>
                 	 	<xsl:with-param name="country" select="$country"/>
                 	 	<xsl:with-param name="bank_abbv_name" select="$bank_abbv_name"/>
                 	 	<xsl:with-param name="bank_name" select="$bank_name"/>
                 	 	<xsl:with-param name="address_line_1" select="$address_line_1"/>
                 	 	<xsl:with-param name="address_line_2" select="$address_line_2"/>
                 	 	<xsl:with-param name="dom" select="$dom"/>
                 	 	<xsl:with-param name="iso_code" select="$iso_code"/>
                 	 	<xsl:with-param name="bmCustNo" select="$bmCustNo"/>
                 	 	<xsl:with-param name="accType" select="$accType"/>
                 	 	<xsl:with-param name="acctAddlDetailsTag">Y</xsl:with-param>
                 	 	<xsl:with-param name="accountNRA" select="$accountNRA"/>
                 	 </xsl:call-template>	
                 </xsl:when>
                 <xsl:when test="AccountNoticeWithdrawal">
                     <xsl:apply-templates select="AccountNoticeWithdrawal">
                         <xsl:with-param name="internalAcctType" select="$internalAcctType"/>
                         <xsl:with-param name="acctId" select="$acctStmtReferences/references/account_id"/>
                     </xsl:apply-templates>
                 </xsl:when>
                <xsl:otherwise>
                	<xsl:call-template name="accounts">
						<xsl:with-param name="acctId" select="$acctStmtReferences/references/account_id"/>
						<xsl:with-param name="acctStmtReferences" select="$acctStmtReferences"/>
                 	 	<xsl:with-param name="internalAcctType" select="$internalAcctType"/>
                 	 	<xsl:with-param name="country" select="$country"/>
                 	 	<xsl:with-param name="bank_abbv_name" select="$bank_abbv_name"/>
                 	 	<xsl:with-param name="bank_name" select="$bank_name"/>
                 	 	<xsl:with-param name="address_line_1" select="$address_line_1"/>
                 	 	<xsl:with-param name="address_line_2" select="$address_line_2"/>
                 	 	<xsl:with-param name="dom" select="$dom"/>
                 	 	<xsl:with-param name="iso_code" select="$iso_code"/>
                 	 	<xsl:with-param name="bmCustNo" select="$bmCustNo"/>
                 	 	<xsl:with-param name="accType" select="$accType"/>
                 	 	<xsl:with-param name="acctAddlDetailsTag">N</xsl:with-param>
                 	 	<xsl:with-param name="accountNRA" select="$accountNRA"/>
                 	 </xsl:call-template>    
	                <xsl:if  test="DebitCardDetails">
	                 <com.misys.portal.interfaces.incoming.Parameter>
	                  <company_id><xsl:value-of select="$company_id"/></company_id>
	                  <parm_id>P400</parm_id>
	                  <key_1><xsl:value-of select="AcctID/AcctNo"/></key_1>
	                  <key_2><xsl:value-of select="DebitCardDetails/DebitCardNumber"/></key_2>
	                  <key_3><xsl:value-of select="DebitCardDetails/CardStatus"/></key_3>
	                  <key_4><xsl:value-of select="DebitCardDetails/CardStatusReason"/></key_4>
	                  <key_5>**</key_5>
	                  <key_6>**</key_6>
	                  <key_7>**</key_7>
	                  <key_8>**</key_8>
	                  <key_9>**</key_9>
	                  <key_10>**</key_10>
	                  <wild_card_ind>**</wild_card_ind>
	                 </com.misys.portal.interfaces.incoming.Parameter>
	                </xsl:if> 
                  
                </xsl:otherwise>
            </xsl:choose>
			</com.misys.portal.interfaces.incoming.AccountSet>
		</result>
	</xsl:template>
 
    <xsl:template match="AccountAddlDetails">
      <xsl:param name="acctId"/>
      <com.misys.portal.cash.product.ab.common.AccountAdditionalDetails>
      <account_id><xsl:value-of select="$acctId"/></account_id>
        <xsl:if test="AccountInterestStatus/Debit/LastCycleToNextBusDate">
            <dr_last_cyc_to_next_bussdate>
                <xsl:value-of select="normalize-space(AccountInterestStatus/Debit/LastCycleToNextBusDate)"/>
            </dr_last_cyc_to_next_bussdate>
        </xsl:if>
        <xsl:if test="not(AccountInterestStatus/Debit/LastCycleToNextBusDate)">
           <dr_last_cyc_to_next_bussdate/>
        </xsl:if>      
        <xsl:if test="AccountInterestStatus/Debit/AdjustedButNotYetPosted">
            <dr_adjusted_but_not_posted>
                <xsl:value-of select="normalize-space(AccountInterestStatus/Debit/AdjustedButNotYetPosted)"/>
            </dr_adjusted_but_not_posted>
        </xsl:if>
        <xsl:if test="not(AccountInterestStatus/Debit/AdjustedButNotYetPosted)">
           <dr_adjusted_but_not_posted/>
        </xsl:if>
        <xsl:if test="AccountInterestStatus/Debit/BaseRateCode">
            <dr_base_rate_code>
                <xsl:value-of select="normalize-space(AccountInterestStatus/Debit/BaseRateCode)"/>
            </dr_base_rate_code>
        </xsl:if>
        <xsl:if test="not(AccountInterestStatus/Debit/BaseRateCode)">
           <dr_base_rate_code/>
        </xsl:if>
        <xsl:if test="AccountInterestStatus/Debit/DifferentialRateCode">
            <dr_diff_rate_code>
                <xsl:value-of select="normalize-space(AccountInterestStatus/Debit/DifferentialRateCode)"/>
            </dr_diff_rate_code>
        </xsl:if>
        <xsl:if test="not(AccountInterestStatus/Debit/DifferentialRateCode)">
           <dr_diff_rate_code/>
        </xsl:if>
        <xsl:if test="AccountInterestStatus/Debit/TierRateCode">
            <dr_tier_rate_code>
                <xsl:value-of select="normalize-space(AccountInterestStatus/Debit/TierRateCode)"/>
            </dr_tier_rate_code>
        </xsl:if>
        <xsl:if test="not(AccountInterestStatus/Debit/TierRateCode)">
           <dr_tier_rate_code/>
        </xsl:if>
        <xsl:if test="AccountInterestStatus/Debit/ActualRate">
            <dr_actual_rate>
                <xsl:value-of select="normalize-space(AccountInterestStatus/Debit/ActualRate)"/>
            </dr_actual_rate>
        </xsl:if>
        <xsl:if test="not(AccountInterestStatus/Debit/ActualRate)">
           <dr_actual_rate/>
        </xsl:if> 
        
        <!-- credit and debit are separate messages --> 
        <xsl:if test="AccountInterestStatus/Credit/LastCycleToNextBusDate">
            <cr_last_cyc_to_next_bussdate>
                <xsl:value-of select="normalize-space(AccountInterestStatus/Credit/LastCycleToNextBusDate)"/>
            </cr_last_cyc_to_next_bussdate>
        </xsl:if>
        <xsl:if test="not(AccountInterestStatus/Credit/LastCycleToNextBusDate)">
           <cr_last_cyc_to_next_bussdate/>
        </xsl:if>      
        <xsl:if test="AccountInterestStatus/Credit/AdjustedButNotYetPosted">
            <cr_adjusted_but_not_posted>
                <xsl:value-of select="normalize-space(AccountInterestStatus/Credit/AdjustedButNotYetPosted)"/>
            </cr_adjusted_but_not_posted>
        </xsl:if>
        <xsl:if test="not(AccountInterestStatus/Credit/AdjustedButNotYetPosted)">
           <cr_adjusted_but_not_posted/>
        </xsl:if>
        <xsl:if test="AccountInterestStatus/Credit/BaseRateCode">
            <cr_base_rate_code>
                <xsl:value-of select="normalize-space(AccountInterestStatus/Credit/BaseRateCode)"/>
            </cr_base_rate_code>
        </xsl:if>
        <xsl:if test="not(AccountInterestStatus/Credit/BaseRateCode)">
           <cr_base_rate_code/>
        </xsl:if>
        <xsl:if test="AccountInterestStatus/Credit/DifferentialRateCode">
            <cr_diff_rate_code>
                <xsl:value-of select="normalize-space(AccountInterestStatus/Credit/DifferentialRateCode)"/>
            </cr_diff_rate_code>
        </xsl:if>
        <xsl:if test="not(AccountInterestStatus/Credit/DifferentialRateCode)">
           <cr_diff_rate_code/>
        </xsl:if>
        <xsl:if test="AccountInterestStatus/Credit/TierRateCode">
            <cr_tier_rate_code>
                <xsl:value-of select="normalize-space(AccountInterestStatus/Credit/TierRateCode)"/>
            </cr_tier_rate_code>
        </xsl:if>
        <xsl:if test="not(AccountInterestStatus/Debit/TierRateCode)">
           <cr_tier_rate_code/>
        </xsl:if>
        <xsl:if test="AccountInterestStatus/Credit/ActualRate">
            <cr_actual_rate>
                <xsl:value-of select="normalize-space(AccountInterestStatus/Credit/ActualRate)"/>
            </cr_actual_rate>
        </xsl:if>
        <xsl:if test="not(AccountInterestStatus/Credit/ActualRate)">
           <cr_actual_rate/>
        </xsl:if>
        <xsl:if test="AccountSplConditions/SplConditionSC080">
            <spl_cond_sc080>
                <xsl:value-of select="AccountSplConditions/SplConditionSC080"/>
            </spl_cond_sc080>
        </xsl:if>
        <xsl:if test="not(AccountSplConditions/SplConditionSC080)">
           <spl_cond_sc080/>
        </xsl:if>
        <xsl:if test="AccountSplConditions/SplConditionSC081">
            <spl_cond_sc081>
                <xsl:value-of select="AccountSplConditions/SplConditionSC081"/>
            </spl_cond_sc081>
        </xsl:if>
        <xsl:if test="not(AccountSplConditions/SplConditionSC081)">
           <spl_cond_sc081/>
        </xsl:if>
        <xsl:if test="AccountSplConditions/SplConditionSC082">
            <spl_cond_sc082>
                <xsl:value-of select="AccountSplConditions/SplConditionSC082"/>
            </spl_cond_sc082>
        </xsl:if>
        <xsl:if test="not(AccountSplConditions/SplConditionSC082)">
           <spl_cond_sc082/>
        </xsl:if>
        <xsl:if test="AccountSplConditions/SplConditionSC083">
            <spl_cond_sc083>
                <xsl:value-of select="AccountSplConditions/SplConditionSC083"/>
            </spl_cond_sc083>
        </xsl:if>
        <xsl:if test="not(AccountSplConditions/SplConditionSC083)">
           <spl_cond_sc083/>
        </xsl:if>
        <xsl:if test="AccountSplConditions/SplConditionSC084">
            <spl_cond_sc084>
                <xsl:value-of select="AccountSplConditions/SplConditionSC084"/>
            </spl_cond_sc084>
        </xsl:if>
        <xsl:if test="not(AccountSplConditions/SplConditionSC084)">
           <spl_cond_sc084/>
        </xsl:if>
        <xsl:if test="AccountSplConditions/SplConditionSC085">
            <spl_cond_sc085>
                <xsl:value-of select="AccountSplConditions/SplConditionSC085"/>
            </spl_cond_sc085>
        </xsl:if>
        <xsl:if test="not(AccountSplConditions/SplConditionSC085)">
           <spl_cond_sc085/>
        </xsl:if>
        <xsl:if test="AccountSplConditions/SplConditionSC086">
            <spl_cond_sc086>
                <xsl:value-of select="AccountSplConditions/SplConditionSC086"/>
            </spl_cond_sc086>
        </xsl:if>
        <xsl:if test="not(AccountSplConditions/SplConditionSC086)">
           <spl_cond_sc086/>
        </xsl:if>
        <xsl:if test="AccountSplConditions/SplConditionSC087">
            <spl_cond_sc087>
                <xsl:value-of select="AccountSplConditions/SplConditionSC087"/>
            </spl_cond_sc087>
        </xsl:if>
        <xsl:if test="not(AccountSplConditions/SplConditionSC087)">
           <spl_cond_sc087/>
        </xsl:if>
        <!-- special condition 90's -->
        <xsl:if test="AccountSplConditions/SplConditionSC090">
            <spl_cond_sc090>
                <xsl:value-of select="AccountSplConditions/SplConditionSC090"/>
            </spl_cond_sc090>
        </xsl:if>
        <xsl:if test="not(AccountSplConditions/SplConditionSC090)">
           <spl_cond_sc090/>
        </xsl:if>
        <xsl:if test="AccountSplConditions/SplConditionSC091">
            <spl_cond_sc091>
                <xsl:value-of select="AccountSplConditions/SplConditionSC091"/>
            </spl_cond_sc091>
        </xsl:if>
        <xsl:if test="not(AccountSplConditions/SplConditionSC091)">
           <spl_cond_sc091/>
        </xsl:if>
        <xsl:if test="AccountSplConditions/SplConditionSC092">
            <spl_cond_sc092>
                <xsl:value-of select="AccountSplConditions/SplConditionSC092"/>
            </spl_cond_sc092>
        </xsl:if>
        <xsl:if test="not(AccountSplConditions/SplConditionSC092)">
           <spl_cond_sc092/>
        </xsl:if>
        <xsl:if test="AccountSplConditions/SplConditionSC093">
            <spl_cond_sc093>
                <xsl:value-of select="AccountSplConditions/SplConditionSC093"/>
            </spl_cond_sc093>
        </xsl:if>
        <xsl:if test="not(AccountSplConditions/SplConditionSC093)">
           <spl_cond_sc093/>
        </xsl:if>
        <xsl:if test="AccountSplConditions/SplConditionSC094">
            <spl_cond_sc094>
                <xsl:value-of select="AccountSplConditions/SplConditionSC094"/>
            </spl_cond_sc094>
        </xsl:if>
        <xsl:if test="not(AccountSplConditions/SplConditionSC094)">
           <spl_cond_sc094/>
        </xsl:if>
        <xsl:if test="AccountSplConditions/SplConditionSC095">
            <spl_cond_sc095>
                <xsl:value-of select="AccountSplConditions/SplConditionSC095"/>
            </spl_cond_sc095>
        </xsl:if>
        <xsl:if test="not(AccountSplConditions/SplConditionSC095)">
           <spl_cond_sc095/>
        </xsl:if>
        <xsl:if test="AccountSplConditions/SplConditionSC096">
            <spl_cond_sc096>
                <xsl:value-of select="AccountSplConditions/SplConditionSC096"/>
            </spl_cond_sc096>
        </xsl:if>
        <xsl:if test="not(AccountSplConditions/SplConditionSC096)">
           <spl_cond_sc096/>
        </xsl:if>
        <xsl:if test="AccountSplConditions/SplConditionSC097">
            <spl_cond_sc097>
                <xsl:value-of select="AccountSplConditions/SplConditionSC097"/>
            </spl_cond_sc097>
        </xsl:if>
        <xsl:if test="not(AccountSplConditions/SplConditionSC097)">
           <spl_cond_sc097/>
        </xsl:if>
        <xsl:if test="AccountSplConditions/SplConditionSC060">
            <spl_cond_sc060>
                <xsl:value-of select="AccountSplConditions/SplConditionSC060"/>
            </spl_cond_sc060>
        </xsl:if>
        <xsl:if test="not(AccountSplConditions/SplConditionSC060)">
           <spl_cond_sc060/>
        </xsl:if>
        <xsl:if test="AccountSplConditions/SplConditionSC061">
            <spl_cond_sc061>
                <xsl:value-of select="AccountSplConditions/SplConditionSC061"/>
            </spl_cond_sc061>
        </xsl:if>
        <xsl:if test="not(AccountSplConditions/SplConditionSC061)">
           <spl_cond_sc061/>
        </xsl:if>
        <xsl:if test="AccountSplConditions/SplConditionSC062">
            <spl_cond_sc062>
                <xsl:value-of select="AccountSplConditions/SplConditionSC062"/>
            </spl_cond_sc062>
        </xsl:if>
        <xsl:if test="not(AccountSplConditions/SplConditionSC062)">
           <spl_cond_sc062/>
        </xsl:if>
        <xsl:if test="AccountSplConditions/SplConditionSC063">
            <spl_cond_sc063>
                <xsl:value-of select="AccountSplConditions/SplConditionSC063"/>
            </spl_cond_sc063>
        </xsl:if>
        <xsl:if test="not(AccountSplConditions/SplConditionSC063)">
           <spl_cond_sc063/>
        </xsl:if>
        <xsl:if test="AccountSplConditions/SplConditionSC064">
            <spl_cond_sc064>
                <xsl:value-of select="AccountSplConditions/SplConditionSC064"/>
            </spl_cond_sc064>
        </xsl:if>
        <xsl:if test="not(AccountSplConditions/SplConditionSC064)">
           <spl_cond_sc064/>
        </xsl:if>
        <xsl:if test="AccountSplConditions/SplConditionSC065">
            <spl_cond_sc065>
                <xsl:value-of select="AccountSplConditions/SplConditionSC065"/>
            </spl_cond_sc065>
        </xsl:if>
        <xsl:if test="not(AccountSplConditions/SplConditionSC065)">
           <spl_cond_sc065/>
        </xsl:if>
        <xsl:if test="AccountSplConditions/SplConditionSC066">
            <spl_cond_sc066>
                <xsl:value-of select="AccountSplConditions/SplConditionSC066"/>
            </spl_cond_sc066>
        </xsl:if>
        <xsl:if test="not(AccountSplConditions/SplConditionSC066)">
           <spl_cond_sc066/>
        </xsl:if>
        <xsl:if test="AccountSplConditions/SplConditionSC067">
            <spl_cond_sc067>
                <xsl:value-of select="AccountSplConditions/SplConditionSC067"/>
            </spl_cond_sc067>
        </xsl:if>
        <xsl:if test="not(AccountSplConditions/SplConditionSC067)">
           <spl_cond_sc067/>
        </xsl:if>
     </com.misys.portal.cash.product.ab.common.AccountAdditionalDetails>                                    
    </xsl:template>
    
    <xsl:template match="AccountHolds">
     <xsl:param name="acctId"/>
     <com.misys.portal.cash.product.ab.common.AccountHold>     
        <xsl:if test="ResponsibilityCode">
            <responsibility_code><xsl:value-of select="ResponsibilityCode"/></responsibility_code>
        </xsl:if>
        <xsl:if test="not(ResponsibilityCode)">
           <responsibility_code/>
        </xsl:if>
        <account_id><xsl:value-of select="$acctId"/></account_id>
        <xsl:if test="HoldNumber">
            <hold_number><xsl:value-of select="HoldNumber"/></hold_number>
        </xsl:if>
        <xsl:if test="not(HoldNumber)">
           <hold_number/>
        </xsl:if>
       
        <xsl:if test="StartDate">
            <hold_start_date><xsl:value-of select="tools:stringInternalToDateTimeString(StartDate)"/></hold_start_date>
        </xsl:if>
        <xsl:if test="not(StartDate)">
           <hold_start_date/>
        </xsl:if>
        <xsl:if test="ExpiryDate">
            <hold_expiry_date><xsl:value-of select="tools:stringInternalToDateTimeString(ExpiryDate)"/></hold_expiry_date>
        </xsl:if>
        <xsl:if test="not(ExpiryDate)">
           <hold_expiry_date/>
        </xsl:if>
        <xsl:if test="HoldDescription">
            <hold_description><xsl:value-of select="HoldDescription"/></hold_description>
        </xsl:if>
        <xsl:if test="not(HoldDescription)">
           <hold_description/>
        </xsl:if>
         <xsl:if test="HoldDescriptionLine1">
            <hold_description_line_1><xsl:value-of select="HoldDescriptionLine1"/></hold_description_line_1>
        </xsl:if>
        <xsl:if test="not(HoldDescriptionLine1)">
           <hold_description_line_1/>
        </xsl:if>
         <xsl:if test="HoldDescriptionLine2">
            <hold_description_line_2><xsl:value-of select="HoldDescriptionLine2"/></hold_description_line_2>
        </xsl:if>
        <xsl:if test="not(HoldDescriptionLine2)">
           <hold_description_line_2/>
        </xsl:if>
         <xsl:if test="HoldDescriptionLine3">
            <hold_description_line_3><xsl:value-of select="HoldDescriptionLine3"/></hold_description_line_3>
        </xsl:if>
        <xsl:if test="not(HoldDescriptionLine3)">
           <hold_description_line_3/>
        </xsl:if>
         <xsl:if test="HoldDescriptionLine4">
            <hold_description_line_4><xsl:value-of select="HoldDescriptionLine4"/></hold_description_line_4>
        </xsl:if>
        <xsl:if test="not(HoldDescriptionLine4)">
           <hold_description_line_4/>
        </xsl:if>
      </com.misys.portal.cash.product.ab.common.AccountHold>
    </xsl:template>
    
    <xsl:template match="AccountNoticeWithdrawal">
      <xsl:param name="acctId"/>                 
        <com.misys.portal.cash.product.ab.common.AccountNoticeWithdrawals>
           <account_id><xsl:value-of select="$acctId"/></account_id>
           <xsl:if test="AccountType">
              <account_type><xsl:value-of select="AccountType"/></account_type>
           </xsl:if>
           <xsl:if test="not(AccountType)">
              <account_type/>
           </xsl:if>
           <xsl:if test="DebitCurrency">
              <cur_code><xsl:value-of select="DebitCurrency"/></cur_code>
           </xsl:if>
           <xsl:if test="not(DebitCurrency)">
              <cur_code/>
           </xsl:if>
           <xsl:if test="EffectiveDate">
              <eff_date><xsl:value-of select="EffectiveDate"/></eff_date>
           </xsl:if>
           <xsl:if test="not(EffectiveDate)">
              <eff_date/>
           </xsl:if>
           <xsl:if test="WithdrawalType">
              <withdraw_type><xsl:value-of select="WithdrawalType"/></withdraw_type>
           </xsl:if>
           <xsl:if test="not(WithdrawalType)">
              <withdraw_type/>
           </xsl:if>
           <xsl:if test="DateNoticeGiven">
              <date_not_given><xsl:value-of select="DateNoticeGiven"/></date_not_given>
           </xsl:if>
           <xsl:if test="not(DateNoticeGiven)">
              <date_not_given/>
           </xsl:if>
           <xsl:if test="WithdrawalDate">
              <withdraw_date><xsl:value-of select="WithdrawalDate"/></withdraw_date>
           </xsl:if>
           <xsl:if test="not(WithdrawalDate)">
              <withdraw_date/>
           </xsl:if>
           <xsl:if test="NoticeWithdrawalReference">
              <not_withdraw_ref><xsl:value-of select="NoticeWithdrawalReference"/></not_withdraw_ref>
           </xsl:if>
           <xsl:if test="not(NoticeWithdrawalReference)">
              <not_withdraw_ref/>
           </xsl:if>
           <xsl:if test="NoticeDealReference">
              <not_deal_ref><xsl:value-of select="NoticeDealReference"/></not_deal_ref>
           </xsl:if>
           <xsl:if test="not(NoticeDealReference)">
              <not_deal_ref/>
           </xsl:if>
           <xsl:if test="WithdrawalAmountRequested">
              <withdraw_amt_req><xsl:value-of select="WithdrawalAmountRequested"/></withdraw_amt_req>
           </xsl:if>
           <xsl:if test="not(WithdrawalAmountRequested)">
              <withdraw_amt_req/>
           </xsl:if>
           <xsl:if test="WithdrawalAmountCalculated">
              <withdraw_amt_cal><xsl:value-of select="WithdrawalAmountCalculated"/></withdraw_amt_cal>
           </xsl:if>
           <xsl:if test="not(WithdrawalAmountCalculated)">
              <withdraw_amt_cal/>
           </xsl:if>
           <xsl:if test="TotalDebitRequested">
              <total_deb_req><xsl:value-of select="TotalDebitRequested"/></total_deb_req>
           </xsl:if>
           <xsl:if test="not(TotalDebitRequested)">
              <total_deb_req/>
           </xsl:if>
           <xsl:if test="TotalDebitCalculated">
              <total_deb_cal><xsl:value-of select="TotalDebitCalculated"/></total_deb_cal>
           </xsl:if>
           <xsl:if test="not(TotalDebitCalculated)">
              <total_deb_cal/>
           </xsl:if>
        </com.misys.portal.cash.product.ab.common.AccountNoticeWithdrawals>
    </xsl:template>
	
    <xsl:template match="CurrentAcctDetail | FixedDepositAcctDetail | LoanAcctDetail">
    	<xsl:param name="internalAcctType"/> 
		<xsl:variable name="boLoanAmtConversionFlag" select="defaultresource:getResource('BO_NEGATE_LOAN_AMOUNT')" />
		<xsl:variable name="boLoanAmtConversionActType" select="businesscode:getValueOfBusinessCode('N068_LOAN_ACCOUNT')" />
		<xsl:if test="OverDraftLimit">
		    <overdraft_limit><xsl:value-of select="tools:getDefaultAmountRepresentation(OverDraftLimit, $language)" /></overdraft_limit>
		</xsl:if>
		<xsl:if test="not(OverDraftLimit)">
		    <overdraft_limit />
		</xsl:if>
		<interest_rate_credit><xsl:value-of select="utils:trimTheValue(InterestRate/CreditRate)" /></interest_rate_credit>
		<interest_rate_debit><xsl:value-of select="utils:trimTheValue(InterestRate/DebitRate)" /></interest_rate_debit>
		<!-- For Loan Account : PrincipALamount is used, please refer IFM Boeing schema -->
        <xsl:if test="PrincipalAmount">
       	<xsl:choose>
        	<xsl:when test="($internalAcctType = $boLoanAmtConversionActType) and ($boLoanAmtConversionFlag = 'true')">
                    <principal_amount><xsl:value-of select="tools:getDefaultAmountRepresentation(-1 * PrincipalAmount, $language)" /></principal_amount>
            </xsl:when>
            <xsl:otherwise>
            		<principal_amount><xsl:value-of select="tools:getDefaultAmountRepresentation(PrincipalAmount, $language)" /></principal_amount>                    
            </xsl:otherwise>                  
       </xsl:choose>
       </xsl:if>
        <!--  For FD Account : PrincipLEamount is used.please refer IFM Boeing schema -->
        <xsl:if test="PrincipleAmount">
            <principal_amount><xsl:value-of select="tools:getDefaultAmountRepresentation(PrincipleAmount, $language)" /></principal_amount>
        </xsl:if>
        <xsl:if test="StartDate">
            <start_date><xsl:value-of select="tools:stringInternalToDateTimeString(StartDate)" /></start_date>
        </xsl:if>
        <xsl:if test="not(StartDate)">
            <start_date />
        </xsl:if>
        <xsl:if test="EndDate">
            <end_date><xsl:value-of select="tools:stringInternalToDateTimeString(EndDate)" /></end_date>
        </xsl:if>
        <xsl:if test="MaturityDate">
            <end_date><xsl:value-of select="tools:stringInternalToDateTimeString(MaturityDate)" /></end_date>
        </xsl:if>
        <xsl:if test="not(EndDate) and not(MaturityDate)">
            <end_date />
        </xsl:if>
		<interest_rate />
        <xsl:if test="InterestNewMaturity">
        	<additional_field name="interest_on_maturity" type="string" scope="master">
            	<xsl:value-of select="tools:getDefaultAmountRepresentation(InterestNewMaturity, $language)" />
            </additional_field>
        </xsl:if>
        <xsl:if test="MaturityAmount">
            <maturity_amount><xsl:value-of select="tools:getDefaultAmountRepresentation(MaturityAmount, $language)" /></maturity_amount>
        </xsl:if>
        <xsl:if test="not(MaturityAmount)">
            <maturity_amount />
        </xsl:if>
        <xsl:if test="DealReference">
            <deal_reference><xsl:value-of select="DealReference" /></deal_reference>
        </xsl:if>
        <xsl:if test="not(DealReference)">
            <deal_reference />
        </xsl:if>
        <xsl:if test="AcctLinked">
            <acct_linked><xsl:value-of select="AcctLinked" /></acct_linked>
        </xsl:if>
        <xsl:if test="not(AcctLinked)">
            <acct_linked />
        </xsl:if>                 
        <xsl:if test="PaymentAccountNo">
        	<additional_field name="funding_account_no" type="string" scope="master">
            	<xsl:value-of select="PaymentAccountNo" />
            </additional_field>
        </xsl:if>
        <xsl:if test="MonthlyPayment">
        	<additional_field name="monthly_payment" type="string" scope="master">
            		<xsl:value-of select="tools:getDefaultAmountRepresentation(MonthlyPayment, $language)" />
			</additional_field>
        </xsl:if>
        <xsl:if test="NextPaymentDate">
        	<additional_field name="next_payment_date" type="string" scope="master">
            	<xsl:value-of select="tools:stringInternalToDateTimeString(NextPaymentDate)" />
            </additional_field>
        </xsl:if>
        <xsl:if test="RepaymentDate">
        	<additional_field name="repayment_date" type="string" scope="master">
            	<xsl:value-of select="tools:stringInternalToDateTimeString(RepaymentDate)" />
            </additional_field>
        </xsl:if>
    </xsl:template>
    	
    <xsl:template match="AlternateAccountNumbers">
    	<xsl:if test="AlternateAccountNumber1">
    		<additional_field name="alternate_account_no1" type="string"
						scope="master">
					<xsl:value-of select="AlternateAccountNumber1" />
			</additional_field>
        </xsl:if>
    </xsl:template>

	<xsl:template match="Balance/AcctBalance" mode="acctBalance">
		<xsl:param name="acctStmtReferences" />
		<xsl:param name="bo_cust_number" />
		<xsl:param name="cur_code" />
		<xsl:param name="internalAcctType"/> 
		<xsl:variable name="boLoanAmtConversionFlag" select="defaultresource:getResource('BO_NEGATE_LOAN_AMOUNT')" />
		<xsl:variable name="boLoanAmtConversionActType" select="businesscode:getValueOfBusinessCode('N068_LOAN_ACCOUNT')" />
		<com.misys.portal.cash.product.ab.common.AccountStatement>
			<xsl:if test="$acctStmtReferences/references/statement_id">
				<statement_id><xsl:value-of select="$acctStmtReferences/references/statement_id"/></statement_id>
			</xsl:if>
			<xsl:if test="$acctStmtReferences/references/account_id">
				<account_id><xsl:value-of select="$acctStmtReferences/references/account_id"/></account_id>
			</xsl:if>
			<type>02</type>
			<brch_code>00001</brch_code>
			<idx>1</idx>
			<seq_idx>2</seq_idx>
			<description></description>
			<value_date></value_date>
			<xsl:if test="../../Transaction">
				<xsl:variable name="RemoveFromDate" select="../../Transaction/RemoveTransactions/RemoveFromDate"/>
				<xsl:if test="$RemoveFromDate">
					<additional_field name="remove_from_date" type="string"
						scope="master">
	                	<xsl:value-of select="tools:stringInternalToDateTimeString($RemoveFromDate)" />
	                </additional_field>
				</xsl:if>
			</xsl:if>
			<!-- Opening and closing balances are mandatory -->
			<!-- Opening Balance-->
			<com.misys.portal.cash.product.ab.common.AccountBalance>
				<xsl:if test="$acctStmtReferences/references/statement_id">
					<statement_id><xsl:value-of select="$acctStmtReferences/references/statement_id"/></statement_id>		
				</xsl:if>
				<xsl:variable name ="balanceType">05</xsl:variable><!-- 05 == Ledger, Suspect it is the same as booked -->
		   		<type><xsl:value-of select="$balanceType"></xsl:value-of></type>
		   		<xsl:if test="$acctStmtReferences/references/balances/balance_id[@type = $balanceType]">
					<balance_id>
						<xsl:value-of select="$acctStmtReferences/references/balances/balance_id[@type = $balanceType]"/>
					</balance_id>			
				</xsl:if>
		   		<xsl:variable name="balanceSign">
					<xsl:choose>
						<xsl:when test="($internalAcctType = $boLoanAmtConversionActType) and ($boLoanAmtConversionFlag = 'true')">
							<xsl:if test="contains(Booked, '-')">C</xsl:if>
							<xsl:if test="not(contains(Booked, '-'))">D</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<xsl:if test="contains(Booked, '-')">D</xsl:if>
							<xsl:if test="not(contains(Booked, '-'))">C</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
		   		</xsl:variable>
				<xsl:if test="DateTime">
					<value_date><xsl:value-of select="tools:stringInternalToDateTimeString(DateTime)" /></value_date>
				</xsl:if>
				<cur_code><xsl:value-of select="$cur_code" /></cur_code>
				
				<!-- Calling to remove commas in CDATA-->
				<xsl:variable name="bookedValue">
					<xsl:call-template name="remove-commas">
						<xsl:with-param name="list" select="Booked"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="defaultAmount">
					<xsl:value-of select="tools:getDefaultAmountRepresentation($bookedValue * (1 - 2 * ($bookedValue &lt; 0)), $language)" />
				</xsl:variable>
				<amt><xsl:value-of select="tools:getAmountRepresentation($defaultAmount, $balanceSign)" /></amt>
			</com.misys.portal.cash.product.ab.common.AccountBalance>
			<com.misys.portal.cash.product.ab.common.AccountBalance>
				<xsl:if test="$acctStmtReferences/references/statement_id">
					<statement_id><xsl:value-of select="$acctStmtReferences/references/statement_id"/></statement_id>		
				</xsl:if>
				<xsl:variable name ="balanceType">03</xsl:variable><!-- 03 == Available == Cleared -->
				<type><xsl:value-of select="$balanceType"></xsl:value-of></type>
				<xsl:if test="$acctStmtReferences/references/balances/balance_id[@type = $balanceType]">
					<balance_id>
						<xsl:value-of select="$acctStmtReferences/references/balances/balance_id[@type = $balanceType]"/>
					</balance_id>			
				</xsl:if>
				<xsl:variable name="balanceSign">
					<xsl:choose>
						<xsl:when test="($internalAcctType = $boLoanAmtConversionActType) and ($boLoanAmtConversionFlag = 'true')">
							<xsl:if test="contains(Cleared, '-')">C</xsl:if>
							<xsl:if test="not(contains(Cleared, '-'))">D</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<xsl:if test="contains(Cleared, '-')">D</xsl:if>
							<xsl:if test="not(contains(Cleared, '-'))">C</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
		   		</xsl:variable>
				<xsl:if test="DateTime">
					<value_date><xsl:value-of select="tools:stringInternalToDateTimeString(DateTime)" /></value_date>
				</xsl:if>
				<cur_code><xsl:value-of select="$cur_code" /></cur_code>
				<!-- Calling to remove commas in CDATA-->
				<xsl:variable name="clearedValue">
					<xsl:call-template name="remove-commas">
						<xsl:with-param name="list" select="Cleared"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="defaultAmount">
					<xsl:value-of select="tools:getDefaultAmountRepresentation($clearedValue * (1 - 2 * ($clearedValue &lt; 0)), $language)" />
				</xsl:variable>
				<amt><xsl:value-of select="tools:getAmountRepresentation($defaultAmount, $balanceSign)" /></amt>
			</com.misys.portal.cash.product.ab.common.AccountBalance>
			<com.misys.portal.cash.product.ab.common.AccountBalance>
				<xsl:if test="$acctStmtReferences/references/statement_id">
					<statement_id><xsl:value-of select="$acctStmtReferences/references/statement_id"/></statement_id>		
				</xsl:if>
				<xsl:variable name ="balanceType">06</xsl:variable><!-- 06 == Reserved == ReservedBalance -->
				<type><xsl:value-of select="$balanceType"></xsl:value-of></type>
				<xsl:if test="$acctStmtReferences/references/balances/balance_id[@type = $balanceType]">
					<balance_id>
						<xsl:value-of select="$acctStmtReferences/references/balances/balance_id[@type = $balanceType]"/>
					</balance_id>			
				</xsl:if>
				<xsl:variable name="balanceSign">
					<xsl:choose>
						<xsl:when test="($internalAcctType = $boLoanAmtConversionActType) and ($boLoanAmtConversionFlag = 'true')">
							<xsl:if test="contains(Reserved, '-')">C</xsl:if>
							<xsl:if test="not(contains(Reserved, '-'))">D</xsl:if>
						</xsl:when>
						<xsl:otherwise>
							<xsl:if test="contains(Reserved, '-')">D</xsl:if>
							<xsl:if test="not(contains(Reserved, '-'))">C</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
		   		</xsl:variable>
				<xsl:if test="DateTime">
					<value_date><xsl:value-of select="tools:stringInternalToDateTimeString(DateTime)" /></value_date>
				</xsl:if>
				<cur_code><xsl:value-of select="$cur_code" /></cur_code>
				<!-- Calling to remove commas in CDATA-->
				<xsl:variable name="reservedValue">
					<xsl:call-template name="remove-commas">
						<xsl:with-param name="list" select="Reserved"/>
					</xsl:call-template>
				</xsl:variable>
				<xsl:variable name="defaultAmount">
					<xsl:value-of select="tools:getDefaultAmountRepresentation($reservedValue * (1 - 2 * ($reservedValue &lt; 0)), $language)" />
				</xsl:variable>
				<amt><xsl:value-of select="tools:getAmountRepresentation($defaultAmount, $balanceSign)" /></amt>
			</com.misys.portal.cash.product.ab.common.AccountBalance>
			
			
			
			<xsl:apply-templates select="../../Transaction/AcctTransaction" mode="acctTran">
				<xsl:with-param name="cur_code" select="$cur_code" />
				<xsl:with-param name="bo_cust_number" select="$bo_cust_number" />
			</xsl:apply-templates>
		</com.misys.portal.cash.product.ab.common.AccountStatement>
	</xsl:template>
			
	<xsl:template match="Transaction/AcctTransaction" mode="acctTran">
		<xsl:param name="cur_code" />
		<xsl:param name="bo_cust_number" />
		<com.misys.portal.cash.product.ab.common.AccountStatementLine>
			<xsl:call-template name="AcctTransaction" >
				<xsl:with-param name="cur_code" select="$cur_code" />
			</xsl:call-template>
		</com.misys.portal.cash.product.ab.common.AccountStatementLine>
	</xsl:template>
	
	<xsl:template name="AcctTransaction">
		<xsl:param name="cur_code" />
		<xsl:if test="PayDate/ValueDate">
			<value_date><xsl:value-of select="tools:stringInternalToDateTimeString(PayDate/ValueDate)" /></value_date>
		</xsl:if>
		<xsl:if test="PayDate/EntryDate">
			<post_date><xsl:value-of select="tools:stringInternalToDateTimeString(PayDate/EntryDate)" /></post_date>
		</xsl:if>
		<xsl:apply-templates select="Credit" mode="creditDebit">
			<xsl:with-param name="cur_code" select="$cur_code" />
		</xsl:apply-templates>
		<xsl:apply-templates select="Debit" mode="creditDebit">
			<xsl:with-param name="cur_code" select="$cur_code" />
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template match="Credit|Debit" mode="creditDebit">
		<xsl:param name="cur_code" />
		<xsl:variable name="debitCreditFlag">
			<xsl:if test="name()='Credit'">C</xsl:if>
			<xsl:if test="name()='Debit'">D</xsl:if>
		</xsl:variable>
		<!-- Calling to remove commas in CDATA-->
		
		<!-- statement_line_amt column not available in DB -->
		<xsl:variable name="cdAmountValue">
			<xsl:call-template name="remove-commas">
				<xsl:with-param name="list" select="Amount/Value"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="cdAmount">
			<xsl:value-of select="format-number($cdAmountValue * (1 - 2 * ($cdAmountValue &lt; 0)), '###,###,###,###,##0.000')" />
		</xsl:variable>
		<xsl:if test="name()='Credit'">
			<deposit><xsl:value-of select="$cdAmount" /></deposit>
		</xsl:if>
		<xsl:if test="name()='Debit'">
			<withdrawal><xsl:value-of select="$cdAmount" /></withdrawal>
		</xsl:if>
 		<tnx_type>
			<xsl:if test="name()='Credit'">910</xsl:if>
			<xsl:if test="name()='Debit'">900</xsl:if>
		</tnx_type>
		<xsl:if test="CustMemo/CustMemoLine1[normalize-space(.)!='']">
	        <cust_ref_id><xsl:value-of select="substring(CustMemo/CustMemoLine1,0,60)" /></cust_ref_id>
	    </xsl:if>
		<xsl:if test="BankMemo[normalize-space(.)!='']">
	        <bo_ref_id><xsl:value-of select="substring(BankMemo,0,60)" /></bo_ref_id>
	    </xsl:if>
		<entry_type>02</entry_type>
		<cur_code><xsl:value-of select="$cur_code" /></cur_code>
		<xsl:if test="CustMemo/CustMemoLine2[normalize-space(.)!='']">
	        <reference_1><xsl:value-of select="substring(CustMemo/CustMemoLine2,0,65)" /></reference_1>
	    </xsl:if>
		<xsl:if test="CustMemo/CustMemoLine3[normalize-space(.)!='']">
	        <reference_2><xsl:value-of select="substring(CustMemo/CustMemoLine3,0,65)" /></reference_2>
	    </xsl:if>
		<xsl:if test="PaymentRef[normalize-space(.)!='']">
	        <reference_3><xsl:value-of select="substring(PaymentRef,0,65)" /></reference_3>
	    </xsl:if>
		
		<!-- Calling to remove commas in CDATA-->
		<xsl:variable name="runningBalBookedValue">
			<xsl:call-template name="remove-commas">
				<xsl:with-param name="list" select="RunningBalance/Booked"/>
			</xsl:call-template>
		</xsl:variable>
		<runbal_booked><xsl:value-of select="format-number($runningBalBookedValue , '###,###,###,###,##0.000')" /></runbal_booked>

		<xsl:if test="RunningBalance/Cleared">
		    <!-- Calling to remove commas in CDATA-->
			<xsl:variable name="runningBalClearedValue">
				<xsl:call-template name="remove-commas">
					<xsl:with-param name="list" select="RunningBalance/Cleared"/>
				</xsl:call-template>
			</xsl:variable>
			<runbal_cleared><xsl:value-of select="format-number($runningBalClearedValue , '###,###,###,###,##0.000')" /></runbal_cleared>
		</xsl:if>
		<!-- <statement_line_transaction_id>
        	<xsl:value-of select = "TransactionId" />
        </statement_line_transaction_id> -->
        <bo_tnx_id><xsl:value-of select = "TransactionId" /></bo_tnx_id>
	</xsl:template>

	<!-- Template for trimming strings -->
	<xsl:template name="left-trim">
		<xsl:param name="s" />
		<xsl:choose>
			<xsl:when test="substring($s, 1, 1) = ''">
				<xsl:value-of select="$s" />
			</xsl:when>
			<xsl:when test="normalize-space(substring($s, 1, 1)) = ''">
				<xsl:call-template name="left-trim">
					<xsl:with-param name="s" select="substring($s, 2)" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$s" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="right-trim">
		<xsl:param name="s" />
		<xsl:choose>
			<xsl:when test="substring($s, 1, 1) = ''">
				<xsl:value-of select="$s" />
			</xsl:when>
			<xsl:when test="normalize-space(substring($s, string-length($s))) = ''">
				<xsl:call-template name="right-trim">
					<xsl:with-param name="s" select="substring($s, 1, string-length($s) - 1)" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$s" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="trim">
		<xsl:param name="s" />
		<xsl:call-template name="right-trim">
			<xsl:with-param name="s">
				<xsl:call-template name="left-trim">
					<xsl:with-param name="s" select="$s" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
		
	<xsl:template name="remove-commas">
		<xsl:param name="list" />
		<xsl:choose>
			<xsl:when test="contains($list,',')">
				<xsl:variable name="first" select="substring-before($list,',')" />
				<xsl:variable name="remaining" select="substring-after($list,',')" />
					
				<xsl:value-of select="$first" />
				
				<xsl:if test="$remaining">
					<xsl:call-template name="remove-commas">
				       	<xsl:with-param name="list" select="$remaining" />
				   	</xsl:call-template>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
					<xsl:value-of select="$list" />			
			</xsl:otherwise>	
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="accounts">
		<xsl:param name="acctId"/>
		<xsl:param name="acctStmtReferences"/>
		<xsl:param name="internalAcctType"/>
		<xsl:param name="country"/>
		<xsl:param name="bank_abbv_name"/>
		<xsl:param name="bank_name"/>
		<xsl:param name="address_line_1"/>
		<xsl:param name="address_line_2"/>
		<xsl:param name="dom"/>
		<xsl:param name="iso_code"/>
		<xsl:param name="bmCustNo"/>
		<xsl:param name="accType"/>
		<xsl:param name="acctAddlDetailsTag"/>
		<xsl:param name="accountNRA"/>
		
		<xsl:variable name="acctAddlDetailsTagExists">
			<xsl:value-of select="$acctAddlDetailsTag" />
		</xsl:variable>
		
		<com.misys.portal.cash.product.ab.common.Account>
			<brch_code>00001</brch_code>
			<account_id><xsl:value-of select="$acctStmtReferences/references/account_id" /></account_id>
			<owner_type>01</owner_type>
			<account_type><xsl:value-of select="$internalAcctType" /></account_type>
                  <xsl:if test="AcctName">
                     <description><xsl:value-of select="substring(AcctName,0,100)" /></description>
                  </xsl:if>					
			<actv_flag>
				<xsl:if test="AcctStatus[. = 'LIVE']">Y</xsl:if>
				<xsl:if test="AcctStatus[. != 'LIVE']">N</xsl:if>
			</actv_flag>
			<cur_code><xsl:value-of select="Currency" /></cur_code>
			<country><xsl:value-of select="$country" /></country>
			<format>04</format>
			<account_no><xsl:value-of select="AcctID/AcctNo" /></account_no>
			<branch_no><xsl:if test="BranchCode[.! = '']"><xsl:value-of select="BranchCode" /></xsl:if></branch_no>
			<name><xsl:value-of select="substring(AcctName,0,35)" /></name>
			<!-- Account display name, currently concatenates currency, account number and the internal account type description -->
			<acct_name>
				<xsl:value-of select="Currency" /><xsl:text> </xsl:text>
				<xsl:value-of select="AcctID/AcctNo" /><xsl:text> </xsl:text>
				<xsl:value-of select="localization:getDecode(language, 'N068', $internalAcctType)" />
			</acct_name>
			<address_line_1/>
			<address_line_2/>
			<dom/>
			<bank_abbv_name><xsl:value-of select="$bank_abbv_name" /></bank_abbv_name>
			<bank_name><xsl:value-of select="$bank_name" /></bank_name>
			<bank_address_line_1><xsl:value-of select="$address_line_1" /></bank_address_line_1>
			<bank_address_line_2><xsl:value-of select="$address_line_2" /></bank_address_line_2>
			<bank_dom><xsl:value-of select="$dom" /></bank_dom>
			<iso_code><xsl:value-of select="$iso_code" /></iso_code>
			<routing_bic><xsl:value-of select="$iso_code" /></routing_bic>
			<xsl:apply-templates select="CurrentAcctDetail">
				<xsl:with-param name="internalAcctType" select="$internalAcctType"/>
			</xsl:apply-templates>
			<xsl:apply-templates select="FixedDepositAcctDetail" >
				<xsl:with-param name="internalAcctType" select="$internalAcctType"/>
			</xsl:apply-templates>
			<xsl:apply-templates select="LoanAcctDetail" >
				<xsl:with-param name="internalAcctType" select="$internalAcctType"/>
			</xsl:apply-templates>
			<xsl:if  test="not(CurrentAcctDetail) and not(FixedDepositAcctDetail) and not(LoanAcctDetail)">
				<overdraft_limit />
				<interest_rate_credit><xsl:value-of select="utils:trimTheValue(InterestRate/CreditRate)" /></interest_rate_credit>
				<interest_rate_debit><xsl:value-of select="utils:trimTheValue(InterestRate/DebitRate)" /></interest_rate_debit>
				<principal_amount />
				<start_date />
				<end_date />
				<interest_rate />
				<xsl:if test="InterestNewMaturity">
					<additional_field name="interest_on_maturity" type="string" scope="master">
						<xsl:value-of select="tools:getDefaultAmountRepresentation(InterestNewMaturity, $language)" />
					</additional_field>
				</xsl:if>
				<maturity_amount />	            
				<xsl:if test="PaymentAccountNo">
					<additional_field name="funding_account_no" type="string" scope="master">
						<xsl:value-of select="PaymentAccountNo" />
					</additional_field>
				</xsl:if>
				<xsl:if test="MonthlyPayment">
					<additional_field name="monthly_payment" type="string" scope="master">
						<xsl:value-of select="tools:getDefaultAmountRepresentation(MonthlyPayment, $language)" />
					</additional_field>
				</xsl:if>
				<xsl:if test="NextPaymentDate">
					<additional_field name="next_payment_date" type="string" scope="master">
						<xsl:value-of select="tools:stringInternalToDateTimeString(NextPaymentDate)" />
					</additional_field>
				</xsl:if>
				<xsl:if test="RepaymentDate">
					<additional_field name="repayment_date" type="string" scope="master">
						<xsl:value-of select="tools:stringInternalToDateTimeString(RepaymentDate)" />
					</additional_field>
				</xsl:if>	            
			</xsl:if>
			<bo_cust_number><xsl:value-of select="$bmCustNo" /></bo_cust_number>    
			<bo_type><xsl:value-of select="$accType" /></bo_type>
			<xsl:if test="AcctType">
				<additional_field name="bank_account_type" type="string" scope="master">
					<xsl:value-of select="$accType" />
				</additional_field>
			</xsl:if>
			<xsl:if test="$acctAddlDetailsTagExists = 'Y'">
				<xsl:apply-templates select="AccountAddlDetails">
	                <xsl:with-param name="internalAcctType" select="$internalAcctType"/>
	                <xsl:with-param name="acctId" select="$acctStmtReferences/references/account_id"/>
	            </xsl:apply-templates>
            </xsl:if> 
			<additional_field name="customer_account_type" type="string" scope="master">*</additional_field>
			<additional_field name="bank_account_product_type" type="string" scope="master">*</additional_field>
			
			<additional_field name="td_type" type="string" scope="master">*</additional_field>
			<additional_field name="nra" type="string" scope="master">
				<xsl:choose>
					<xsl:when test="(substring($accountNRA,4,1)= '9' or substring($accountNRA,13,10)= '2000200008')">Y</xsl:when>
					<xsl:otherwise>N</xsl:otherwise>
				</xsl:choose>
			</additional_field>
			<additional_field name="to_be_removed" type="string" scope="master">
				<xsl:if test="AcctStatus[. = 'DELETE'] and ($internalAcctType = '02' or $internalAcctType = '04' or $internalAcctType = '05')">Y</xsl:if>
				<xsl:if test="not(AcctStatus[. = 'DELETE'] and ($internalAcctType = '02' or $internalAcctType = '04' or $internalAcctType = '05'))">N</xsl:if>
			</additional_field>
			<xsl:apply-templates select="AlternateAccountNumbers" />
			<xsl:apply-templates select="../../Balance/AcctBalance" mode="acctBalance"> 
				<xsl:with-param name="acctStmtReferences" select="$acctStmtReferences" />
				<xsl:with-param name="bo_cust_number" select="$bmCustNo" />
				<xsl:with-param name="cur_code" select="Currency" />
				<xsl:with-param name="internalAcctType" select="$internalAcctType"/>
			</xsl:apply-templates>
		</com.misys.portal.cash.product.ab.common.Account>
	</xsl:template>
	
</xsl:stylesheet>