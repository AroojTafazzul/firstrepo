<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
	xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
	xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools"
	xmlns:business_codes="xalan://com.misys.portal.common.resources.BusinessCodesResourceProvider"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	exclude-result-prefixes="localization securityCheck security converttools business_codes defaultresource utils">

<!--
   Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->

	<!-- Import custom columns -->
	<xsl:import href="report_addons.xsl"/>

	<!-- Global Imports -->
	<xsl:include href="../common/trade_common.xsl" />
	<xsl:include href="../common/e2ee_common.xsl" />

	<!-- Stylesheet parameters -->
	<xsl:param name="language"/>
	<xsl:param name="rundata"/>
	<xsl:param name="languages"/>
	<xsl:param name="all_banks_flag"/>
	<xsl:param name="isTemplate"/>
	<xsl:param name="isBankTemplate"/>
	<xsl:param name="nextscreen"/>
	<xsl:param name="availableProducts"/>
	<xsl:param name="reportId"/>
	<xsl:param name="main-form-name">fakeform0</xsl:param>
	<xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
    <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
	<xsl:param name="realform-action">
		<xsl:if test="security:isBank($rundata)">
			<xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/BankSystemFeaturesScreen</xsl:if>
		<xsl:if test="security:isCustomer($rundata)">
			<xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/CustomerSystemFeaturesScreen</xsl:if>
	</xsl:param>
	<xsl:param name="product-code"/> 
	<xsl:param name="mode"/> 
	<xsl:param name="operation">REPORT_SAVE</xsl:param>
	<xsl:param name="option">BANK_TEMPLATE</xsl:param>
	<xsl:param name="token"/>
	<xsl:variable name="swift2019Enabled" select="defaultresource:isSwift2019Enabled()"/>
	
	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
	
	<xsl:key name="column" match="//listdef/column" use="@name"/>
               
	<xsl:template match="/">
		<xsl:apply-templates select="report"/>
	</xsl:template>

	
	<!-- ************************************************************************* -->
	<!--                          PRODUCTS - START                                 -->
	<!-- ************************************************************************* -->
	<xsl:template name="build-products-dojo-items">
		<xsl:param name="items"/>
		<xsl:param name="initialProcessing">true</xsl:param>
		
		<xsl:choose>
			<xsl:when test="$initialProcessing = 'true'">
				<div dojoType="misys.report.widget.Products" dialogId="product-dialog-template" gridId="products-grid" id="products">
					<xsl:attribute name="headers">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_PRODUCTS')"/>
					</xsl:attribute>
					<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_ADD_PRODUCT')"/></xsl:attribute>
					<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UPDATE_PRODUCT')"/></xsl:attribute>
					<xsl:call-template name="build-products-dojo-items">
						<xsl:with-param name="items" select="$items"/>
						<xsl:with-param name="initialProcessing">false</xsl:with-param>
					</xsl:call-template>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="product"><xsl:value-of select="substring-before($items, ',')"/></xsl:variable>
				<xsl:if test="string-length($product) > 0">
					<div dojoType="misys.report.widget.Product">
						<xsl:attribute name="product"><xsl:value-of select="$product"/></xsl:attribute>
					</div>
					<xsl:variable name="products"><xsl:value-of select="substring-after($items, ',')"/></xsl:variable>
					<xsl:choose>
						<!-- Still a product to process -->
						<xsl:when test="string-length($products) > 0">
							<xsl:call-template name="build-products-dojo-items">
								<xsl:with-param name="items" select="$products"/>
								<xsl:with-param name="initialProcessing">false</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<!-- Otherwise stop the process -->
						<xsl:otherwise/>
					</xsl:choose>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>

	<xsl:template name="single-product-codes">
	
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'LC')">
			<option value="LC"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LC')"/></option>
			<option value="LCTnx"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LC_TNX')"/></option>
			<option value="LCTemplate"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LC_TEMPLATE')"/></option>
		</xsl:if>
		
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'LS')">
			<option value="LS"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LS')"/></option>
			<option value="LSTnx"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LS_TNX')"/></option>
			<option value="LSTemplate"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LS_TEMPLATE')"/></option>
		</xsl:if>
		
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'RI')">
			<option value="RI"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_RI')"/></option>
			<option value="RITnx"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_RI_TNX')"/></option>
			<option value="RITemplate"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_RI_TEMPLATE')"/></option>
		</xsl:if>
		
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'SE')">
			<option value="SE"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SE')"/></option>
			<option value="SETnx"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SE_TNX')"/></option>
			<!-- <option value="SETemplate"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SE_TEMPLATE')"/></option>-->
		</xsl:if>
		
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'LI')">
			<option value="LI"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LI')"/></option>
			<option value="LITnx"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LI_TNX')"/></option>
		</xsl:if>
		
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'EL')">
			<option value="EL"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EL')"/></option>
			<option value="ELTnx"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EL_TNX')"/></option>
		</xsl:if>
		
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'SI')">
			<option value="SI"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SI')"/></option>
			<option value="SITnx"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SI_TNX')"/></option>
		</xsl:if>
		
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'SR')">
			<option value="SR"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SR')"/></option>
			<option value="SRTnx"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SR_TNX')"/></option>
		</xsl:if>
				
		<xsl:choose>	
		<xsl:when test="$swift2019Enabled">
			<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'BG')">
				<option value="BG"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IU')"/></option>
				<option value="BGTnx"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IU_TNX')"/></option>
				<option value="BGTemplate"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IU_TEMPLATE')"/></option>
			</xsl:if>
		</xsl:when>
		<xsl:otherwise>
			<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'BG')">
				<option value="BG"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BG')"/></option>
				<option value="BGTnx"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BG_TNX')"/></option>
				<option value="BGTemplate"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BG_TEMPLATE')"/></option>
			</xsl:if>
		</xsl:otherwise>
		</xsl:choose>
			
		<xsl:choose>
			<xsl:when test="$swift2019Enabled">
				<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'BR')">
					<option value="BR"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_RU')"/></option>
					<option value="BRTnx"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_RU_TNX')"/></option>
			    </xsl:if>
			</xsl:when>
			<xsl:otherwise>
					<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'BR')">
						<option value="BR"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BR')"/></option>
						<option value="BRTnx"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BR_TNX')"/></option>
					</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'BK')">
			<option value="BK"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BK')"/></option>
			<option value="BKTnx"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BK_TNX')"/></option>
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'SG')">
			<option value="SG"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SG')"/></option>
			<option value="SGTnx"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SG_TNX')"/></option>
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'EC')">
			<option value="EC"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EC')"/></option>
			<option value="ECTnx"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EC_TNX')"/></option>
			<option value="ECTemplate"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EC_TEMPLATE')"/></option>
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'IC')">
			<option value="IC"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IC')"/></option>
			<option value="ICTnx"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IC_TNX')"/></option>
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'TF')">
			<option value="TF"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_TF')"/></option>
			<option value="TFTnx"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_TF_TNX')"/></option>
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'FA')">
			<option value="FA"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FA')"/></option>
			<option value="FATnx"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FA_TNX')"/></option>
		</xsl:if>		
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'FT')">
			<option value="FT"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FT')"/></option>
			<option value="FTTnx"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FT_TNX')"/></option>
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'IR')">
			<option value="IR"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IR')"/></option>
			<option value="IRTnx"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IR_TNX')"/></option>
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'PO')">
			<option value="PO"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_PO')"/></option>
			<option value="POTnx"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_PO_TNX')"/></option>
			<option value="POTemplate"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_PO_TEMPLATE')"/></option>
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'IO')">
			<option value="IO"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IO')"/></option>
			<option value="IOTnx"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IO_TNX')"/></option>
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'EA')">
			<option value="EA"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EA')"/></option>
			<option value="EATnx"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EA_TNX')"/></option>
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'IN')">
			<option value="IN"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IN')"/></option>
			<option value="INTnx"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IN_TNX')"/></option>			
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'IP')">
			<option value="IP"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IP')"/></option>
			<option value="IPTnx"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IP_TNX')"/></option>			
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'FX') and security:isCustomer($rundata)">
			<option value="FX"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FX')"/></option>
			<option value="FXTnx"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FX_TNX')"/></option>
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'LN')">
			<option value="LN"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LN')"/></option>
			<option value="LNTnx"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LN_TNX')"/></option>
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'TD')">
			<option value="TD"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_TD')"/></option>
			<option value="TDTnx"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_TD_TNX')"/></option>
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'CN')">
 		     <option value="CN"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CN')"/></option>
 	         <option value="CNTnx"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CN_TNX')"/></option>
             <option value="CNTemplate"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CN_TEMPLATE')"/></option>
 	    </xsl:if>
 		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'CR')">
 	          <option value="CR"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CR')"/></option>
 		      <option value="CRTnx"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CR_TNX')"/></option>
 	          <option value="CRTemplate"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CR_TEMPLATE')"/></option>
 		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'FX') or securityCheck:hasCompanyProductPermission($rundata,'TD') or securityCheck:hasCompanyProductPermission($rundata,'LA')">
			<option value="AccountStatementLine"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_ACCOUNT_STATEMENT_LINE')"/></option>
		</xsl:if>
		
		<xsl:if test="securityCheck:hasCompanyPermission($rundata,'audit_access')">
			<option value="Audit"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_AUDIT')"/></option>
		</xsl:if>	
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'FX') or securityCheck:hasCompanyProductPermission($rundata,'TD') or securityCheck:hasCompanyProductPermission($rundata,'LA')">
			<option value="AccountStatement"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_ACCOUNT_STATEMENT')"/></option>
		</xsl:if>	
	</xsl:template>
	
	<xsl:template name="system-feture-codes">
		<xsl:if test="securityCheck:hasPermission($rundata,'company_role_access')">
			<option value="CompanyRolePermission"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COMPANY_ENTITY_USER_ROLE')"/></option>
		</xsl:if>		
		<xsl:if test="securityCheck:hasPermission($rundata,'sy_bank_facility_access')">
			<option value="FacilityLimitMaintenance"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FACILITY_LIMIT_MAINTENANCE')"/></option>
		</xsl:if>
		<xsl:if test="securityCheck:hasPermission($rundata,'sy_cust_facility_access')">
			<option value="FacilityLimitMaintenance"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FACILITY_LIMIT_MAINTENANCE')"/></option>
		</xsl:if>	
		<xsl:if test="securityCheck:hasPermission($rundata,'access_user_mc')">
			<option value="UserProfile"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_USER')"/></option>
		</xsl:if>	
		<xsl:if test="securityCheck:hasPermission($rundata,'access_customer_mc')">
			<option value="CompanyProfile"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COMPANY_ENTITY')"/></option>
		</xsl:if>
		</xsl:template>	
			
	<xsl:template name="product-codes">
		
		availableProductCodes = [];
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'LC')">
			availableProductCodes.push( {product: "LC", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LC')"/>"} );
			availableProductCodes.push( {product: "LCTnx", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LC_TNX')"/>"} );
			availableProductCodes.push( {product: "LCTemplate", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LC_TEMPLATE')"/>"} );
		</xsl:if>
		
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'LS')">
			availableProductCodes.push( {product: "LS", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LS')"/>"} );
			availableProductCodes.push( {product: "LSTnx", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LS_TNX')"/>"} );
			availableProductCodes.push( {product: "LSTemplate", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LS_TEMPLATE')"/>"} );
		</xsl:if>
		
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'RI')">
			availableProductCodes.push( {product: "RI", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_RI')"/>"} );
			availableProductCodes.push( {product: "RITnx", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_RI_TNX')"/>"} );
			availableProductCodes.push( {product: "RITemplate", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_RI_TEMPLATE')"/>"} );
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'SE')">
			availableProductCodes.push( {product: "SE", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SE')"/>"} );
			availableProductCodes.push( {product: "SETnx", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SE_TNX')"/>"} );
			<!-- availableProductCodes.push( {product: "SETemplate", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SE_TEMPLATE')"/>"} ); -->
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'LI')">
			availableProductCodes.push( {product: "LI", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LI')"/>"} );
			availableProductCodes.push( {product: "LITnx", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LI_TNX')"/>"} );
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'EL')">
			availableProductCodes.push( {product: "EL", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EL')"/>"} );
			availableProductCodes.push( {product: "ELTnx", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EL_TNX')"/>"} );
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'SI')">
			availableProductCodes.push( {product: "SI", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SI')"/>"} );
			availableProductCodes.push( {product: "SITnx", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SI_TNX')"/>"} );
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'SR')">
			availableProductCodes.push( {product: "SR", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SR')"/>"} );
			availableProductCodes.push( {product: "SRTnx", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SR_TNX')"/>"} );
		</xsl:if>
		<xsl:choose>	
			<xsl:when test="$swift2019Enabled">
				<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'BG')">
					availableProductCodes.push( {product: "BG", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IU')"/>"} );
					availableProductCodes.push( {product: "BGTnx", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IU_TNX')"/>"} );
					availableProductCodes.push( {product: "BGTemplate", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IU_TEMPLATE')"/>"} );
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'BG')">
					availableProductCodes.push( {product: "BG", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BG')"/>"} );
					availableProductCodes.push( {product: "BGTnx", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BG_TNX')"/>"} );
					availableProductCodes.push( {product: "BGTemplate", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BG_TEMPLATE')"/>"} );
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		
		<xsl:choose>
			<xsl:when test="$swift2019Enabled">
				<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'BR')">
					availableProductCodes.push( {product: "BR", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_RU')"/>"} );
					availableProductCodes.push( {product: "BRTnx", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_RU_TNX')"/>"} );
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'BR')">
					availableProductCodes.push( {product: "BR", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BR')"/>"} );
					availableProductCodes.push( {product: "BRTnx", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BR_TNX')"/>"} );
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
		
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'BK')">
			availableProductCodes.push( {product: "BK", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BK')"/>"} );
			availableProductCodes.push( {product: "BKTnx", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BK_TNX')"/>"} );
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'SG')">
			availableProductCodes.push( {product: "SG", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SG')"/>"} );
			availableProductCodes.push( {product: "SGTnx", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SG_TNX')"/>"} );
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'EC')">
			availableProductCodes.push( {product: "EC", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EC')"/>"} );
			availableProductCodes.push( {product: "ECTnx", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EC_TNX')"/>"} );
			availableProductCodes.push( {product: "ECTemplate", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EC_TEMPLATE')"/>"} );
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'IC')">
			availableProductCodes.push( {product: "IC", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IC')"/>"} );
			availableProductCodes.push( {product: "ICTnx", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IC_TNX')"/>"} );
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'TF')">
			availableProductCodes.push( {product: "TF", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_TF')"/>"} );
			availableProductCodes.push( {product: "TFTnx", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_TF_TNX')"/>"} );
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'FA')">
			availableProductCodes.push( {product: "FA", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FA')"/>"} );
			availableProductCodes.push( {product: "FATnx", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FA_TNX')"/>"} );
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'FT')">
			availableProductCodes.push( {product: "FT", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FT')"/>"} );
			availableProductCodes.push( {product: "FTTnx", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FT_TNX')"/>"} );
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'IR')">
			availableProductCodes.push( {product: "IR", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IR')"/>"} );
			availableProductCodes.push( {product: "IRTnx", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IR_TNX')"/>"} );
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'PO')">
			availableProductCodes.push( {product: "PO", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_PO')"/>"} );
			availableProductCodes.push( {product: "POTnx", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_PO_TNX')"/>"} );
			availableProductCodes.push( {product: "POTemplate", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_PO_TEMPLATE')"/>"} );
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'IO')">
			availableProductCodes.push( {product: "IO", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IO')"/>"} );
			availableProductCodes.push( {product: "IOTnx", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IO_TNX')"/>"} );
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'EA')">
			availableProductCodes.push( {product: "EA", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EA')"/>"} );
			availableProductCodes.push( {product: "EATnx", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EA_TNX')"/>"} );
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'IN')">
			availableProductCodes.push( {product: "IN", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IN')"/>"} );
			availableProductCodes.push( {product: "INTnx", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IN_TNX')"/>"} );			
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'IP')">
			availableProductCodes.push( {product: "IP", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IP')"/>"} );
			availableProductCodes.push( {product: "IPTnx", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IP_TNX')"/>"} );			
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'CN')">
			availableProductCodes.push( {product: "CN", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CN')"/>"} );
			availableProductCodes.push( {product: "CNTnx", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CN_TNX')"/>"} );
			availableProductCodes.push( {product: "CNTemplate", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CN_TEMPLATE')"/>"} );
		</xsl:if>
	    <xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'CR')">
			availableProductCodes.push( {product: "CR", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CR')"/>"} );
			availableProductCodes.push( {product: "CRTnx", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CR_TNX')"/>"} );
			availableProductCodes.push( {product: "CRTemplate", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CR_TEMPLATE')"/>"} );
		</xsl:if>	 	
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'FX') and security:isCustomer($rundata)">
			availableProductCodes.push( {product: "FX", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FX')"/>"} );
			availableProductCodes.push( {product: "FXTnx", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FX_TNX')"/>"} );
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'LN')">
			availableProductCodes.push( {product: "LN", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LN')"/>"} );
			availableProductCodes.push( {product: "LNTnx", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LN_TNX')"/>"} );
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'TD')">
			availableProductCodes.push( {product: "TD", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_TD')"/>"} );
			availableProductCodes.push( {product: "TDTnx", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_TD_TNX')"/>"} );
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'FX') or securityCheck:hasCompanyProductPermission($rundata,'TD') or securityCheck:hasCompanyProductPermission($rundata,'LA')">
			availableProductCodes.push( {product: "AccountStatementLine", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_ACCOUNT_STATEMENT_LINE')"/>"} );
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyPermission($rundata,'audit_access')">
			availableProductCodes.push( {product: "Audit", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_AUDIT')"/>"} );
		</xsl:if>
		
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'FX') or securityCheck:hasCompanyProductPermission($rundata,'TD') or securityCheck:hasCompanyProductPermission($rundata,'LA')">
			availableProductCodes.push( {product: "AccountStatement", description:"<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_ACCOUNT_STATEMENT')"/>"} );
		</xsl:if>
		
	</xsl:template>			

	<!-- ************************************************************************* -->
	<!--                          PRODUCTS - END                                   -->
	<!-- ************************************************************************* -->





	<!-- ************************************************************************* -->
	<!--                          COLUMNS - START                                  -->
	<!-- ************************************************************************* -->
	<xsl:template name="build-columns-dojo-items">
		<xsl:param name="items"/>
		
		<div dojoType="misys.report.widget.Columns" dialogId="column-dialog-template" gridId="columns-grid" id="columns">
			<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_DISPCOL_TABLE_DESC')"/>,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_DISPCOL_TABLE_COLUMN')"/>
			</xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_ADD_COLUMN')"/></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UPDATE_COLUMN')"/></xsl:attribute>
			<xsl:for-each select="$items">
				<xsl:variable name="column" select="."/>
				<div dojoType="misys.report.widget.Column">
					<xsl:for-each select="$languages/languages/language">
						<xsl:variable name="lang" select="."/>
						<xsl:attribute name="{concat('label_', $lang)}"><xsl:value-of select="$column/description[@locale = $lang]"/></xsl:attribute>
					</xsl:for-each>
					<xsl:variable name="widthC">
				<xsl:choose>
				<xsl:when test="contains($column/@width, '%')">
				<xsl:value-of select="substring-before($column/@width, '%')"/>
				</xsl:when>
				<xsl:otherwise>
				<xsl:value-of select="substring-before($column/@width, 'em')"/>
				</xsl:otherwise>
				
				</xsl:choose>
					</xsl:variable>
					<xsl:attribute name="alignment"><xsl:value-of select="$column/@align"/></xsl:attribute>
					<xsl:attribute name="width"><xsl:value-of select="$widthC"/></xsl:attribute>
					<xsl:attribute name="eqv_cur_code"><xsl:value-of select="$column/@cur"/></xsl:attribute>
					<xsl:attribute name="abbreviation"><xsl:value-of select="$column/@abbreviation"/></xsl:attribute>
					<xsl:choose>
						<xsl:when test="$column/@computation != ''">
							<xsl:attribute name="column"><xsl:value-of select="$column/column[1]/@name"/></xsl:attribute>
							<xsl:attribute name="operand"><xsl:value-of select="$column/column[2]/@name"/></xsl:attribute>
							<xsl:attribute name="computed_field_id"><xsl:value-of select="$column/@name"/></xsl:attribute>
							<xsl:attribute name="operation"><xsl:value-of select="$column/@computation"/></xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="column"><xsl:value-of select="$column/@name"/></xsl:attribute>
							<xsl:attribute name="operand"/>
							<xsl:attribute name="computed_field_id"/>
							<xsl:attribute name="operation"/>
						</xsl:otherwise>
					</xsl:choose>
				</div>
			</xsl:for-each>
		</div>
		
	</xsl:template>
	

	<!-- ************************************************************************* -->
	<!--                          COLUMNS - END                                    -->
	<!-- ************************************************************************* -->

	<!-- **************************************************************************** -->
	<!--                          PARAMETERS - START                                  -->
	<!-- **************************************************************************** -->
	<xsl:template name="build-parameters-dojo-items">
		<xsl:param name="items"/>

		<div dojoType="misys.report.widget.Parameters" dialogId="parameter-dialog-template" gridId="parameters-grid" id="parameters">
			<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_PARAMETER_TABLE_NAME')"/>,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_PARAMETER_TABLE_DESC')"/>
			</xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_ADD_PARAMETER')"/></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UPDATE_PARAMETER')"/></xsl:attribute>
			<xsl:for-each select="$items">
				<xsl:variable name="parameter" select="."/>
				<div dojoType="misys.report.widget.Parameter">
					<xsl:attribute name="parameter_name"><xsl:value-of select="$parameter/@name"/></xsl:attribute>
					<xsl:attribute name="mandatory">
						<xsl:choose>
							<xsl:when test="$parameter/@mandatory = 'true'">Y</xsl:when>
							<xsl:otherwise>N</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<xsl:for-each select="$languages/languages/language">
						<xsl:variable name="lang" select="."/>
						<xsl:attribute name="{concat('label_', $lang)}"><xsl:value-of select="$parameter/description[@locale = $lang]"/></xsl:attribute>
					</xsl:for-each>
				</div>
			</xsl:for-each>
		</div>
		
	</xsl:template>
	
	<!-- ************************************************************************** -->
	<!--                          PRODUCTS - END                                    -->
	<!-- ************************************************************************** -->






	<!-- ************************************************************************** -->
	<!--                          CRITERIA - START                                  -->
	<!-- ************************************************************************** -->
	<xsl:template name="build-criteria-data-store">
		<xsl:param name="items"/>
		
		<xsl:for-each select="$items">
			<xsl:variable name="criterium" select="."/>
			<xsl:if test="position() > 1">,</xsl:if>
			{ column: "<xsl:value-of select="$criterium/column/@name"/>",
			  operator: "<xsl:value-of select="$criterium/operator/@type"/>",
			  valueType: "<xsl:value-of select="$criterium/value/@type"/>",
			  value: "<xsl:value-of select="$criterium/value"/>"
			}
		</xsl:for-each>

	</xsl:template>

	<xsl:template name="build-criteria-layout">
		{ name: '<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FILTER_TABLE_COLUMN')"/>', field: 'column', formatter: fncGetColumnDecode, width: '200px' },
		{ name: '<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FILTER_TABLE_OPERATOR')"/>', field: 'operator', width: '200px' },
		{ name: '<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FILTER_TABLE_VALUE')"/>', field: 'value', width: '200px' },
		{ name: '', field: 'name', headerStyles: 'display:none', cellStyles: 'display:none' },
	</xsl:template>
	

	<!-- ************************************************************************** -->
	<!--                          CRITERIA - END                                    -->
	<!-- ************************************************************************** -->

	<!-- Template for the initial set up of arrCandidate, arrCandidateName, candidate and candidateType -->
	<xsl:template match="definition" mode="init">
			
		<!-- <xsl:choose>
			<xsl:when test="count(candidate) = 0">
				var candidate = '';
			</xsl:when>
			<xsl:when test="count(candidate) = 1 and multiProduct = 'N'"> 
				var candidate = '<xsl:value-of select="candidate/@name"/>';
			</xsl:when>
			<xsl:when test="count(candidate) > 1 or multiProduct = 'Y'">
				<xsl:if test="candidate[1][@name = 'LCTnx'] or candidate[1][@name = 'ELTnx'] or candidate[1][@name = 'SITnx'] or candidate[1][@name = 'SRTnx'] or candidate[1][@name = 'SGTnx'] or candidate[1][@name = 'TFTnx'] or candidate[1][@name = 'BGTnx'] or candidate[1][@name = 'ECTnx'] or candidate[1][@name = 'ICTnx'] or candidate[1][@name = 'IRTnx'] or candidate[1][@name = 'FTTnx'] or candidate[1][@name = 'LITnx'] or candidate[1][@name = 'POTnx'] or candidate[1][@name = 'INTnx'] or candidate[1][@name = 'SOTnx'] or candidate[1][@name = 'LTTnx']">
					var candidate = 'AllTnx';
				</xsl:if>
				<xsl:if test="candidate[1][@name = 'LC'] or candidate[1][@name = 'EL'] or candidate[1][@name = 'SI'] or candidate[1][@name = 'SR'] or candidate[1][@name = 'SG'] or candidate[1][@name = 'TF'] or candidate[1][@name = 'BG'] or candidate[1][@name = 'EC'] or candidate[1][@name = 'IC'] or candidate[1][@name = 'IR'] or candidate[1][@name = 'FT'] or candidate[1][@name = 'LI'] or candidate[1][@name = 'PO'] or candidate[1][@name = 'IN'] or candidate[1][@name = 'SO'] or candidate[1][@name = 'LT']">
					var candidate = 'AllMaster';
				</xsl:if>
				<xsl:if test="candidate[1][@name = 'LCTemplate'] or candidate[1][@name = 'SITemplate'] or candidate[1][@name = 'BGTemplate'] or candidate[1][@name = 'ECTemplate'] or candidate[1][@name = 'FTTemplate']">
					var candidate = 'AllTemplate';
				</xsl:if>
			</xsl:when>
		</xsl:choose>-->
		<xsl:call-template name="candidate-initialization"/>
		
	</xsl:template>	
		
	<xsl:template name="candidate-initialization">
	
		// Set candidate type
		var candidateType = 
		<xsl:choose>
			<xsl:when test="count(candidate) != 0">
				<xsl:if test="candidate[1][@name = 'LC'] or candidate[1][@name = 'LS'] or candidate[1][@name = 'RI'] or candidate[1][@name = 'SE'] or candidate[1][@name = 'EL'] or candidate[1][@name = 'SI'] or candidate[1][@name = 'SR'] or candidate[1][@name = 'SG'] or candidate[1][@name = 'TF'] or candidate[1][@name = 'BG'] or candidate[1][@name = 'BR'] or candidate[1][@name = 'BK'] or candidate[1][@name = 'EC'] or candidate[1][@name = 'IC'] or candidate[1][@name = 'IR'] or candidate[1][@name = 'FT'] or candidate[1][@name = 'LI'] or candidate[1][@name = 'TU'] or candidate[1][@name = 'BN'] or candidate[1][@name = 'SO'] or candidate[1][@name = 'PO'] or candidate[1][@name = 'IO'] or candidate[1][@name = 'EA'] or candidate[1][@name = 'IN'] or candidate[1][@name = 'FX'] or candidate[1][@name = 'TD'] or candidate[1][@name = 'LA'] or candidate[1][@name = 'AccountStatementLine']  or candidate[1][@name = 'AccountStatement'] or candidate[1][@name = 'SP'] or candidate[1][@name = 'CN'] or candidate[1][@name = 'CR']">
					1
				</xsl:if>
				<xsl:if test="candidate[1][@name = 'LCTnx'] or candidate[1][@name = 'LSTnx'] or candidate[1][@name = 'RITnx'] or candidate[1][@name = 'SETnx'] or candidate[1][@name = 'ELTnx'] or candidate[1][@name = 'SITnx'] or candidate[1][@name = 'SRTnx'] or candidate[1][@name = 'SGTnx'] or candidate[1][@name = 'TFTnx'] or candidate[1][@name = 'BGTnx'] or candidate[1][@name = 'BRTnx'] or candidate[1][@name = 'BKTnx'] or candidate[1][@name = 'ECTnx'] or candidate[1][@name = 'ICTnx'] or candidate[1][@name = 'IRTnx'] or candidate[1][@name = 'FTTnx'] or candidate[1][@name = 'LITnx'] or candidate[1][@name = 'TUTnx'] or candidate[1][@name = 'SOTnx'] or candidate[1][@name = 'POTnx'] or candidate[1][@name = 'EATnx'] or candidate[1][@name = 'INTnx'] or candidate[1][@name = 'TUTnx'] or candidate[1][@name = 'SOTnx'] or candidate[1][@name = 'POTnx'] or candidate[1][@name = 'IOTnx'] or candidate[1][@name = 'INTnx'] or candidate[1][@name = 'IPTnx'] or candidate[1][@name = 'FXTnx'] or candidate[1][@name = 'TDTnx'] or candidate[1][@name = 'LATnx'] or candidate[1][@name = 'SPTnx'] or candidate[1][@name = 'CNTnx'] or candidate[1][@name = 'CRTnx']">
					2
				</xsl:if>
				<xsl:if test="candidate[1][@name = 'LCTemplate'] or candidate[1][@name = 'LSTemplate'] or candidate[1][@name = 'RITemplate'] or candidate[1][@name = 'SETemplate'] or candidate[1][@name = 'SITemplate'] or candidate[1][@name = 'BGTemplate'] or candidate[1][@name = 'ECTemplate'] or candidate[1][@name = 'FTTemplate'] or candidate[1][@name = 'CNTemplate']  or candidate[1][@name = 'CRTemplate']">
					3
				</xsl:if>
				<xsl:if test="candidate[1][@name = 'Audit']">
					4
				</xsl:if>
				<xsl:if test="candidate[1][@name = 'CompanyRolePermission'] or candidate[1][@name = 'Companyprofile'] or candidate[1][@name = 'UserProfile']">
					5
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>''</xsl:otherwise>
		</xsl:choose>;

		// Set the candidate names array
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'LC')">
			arrCandidateName['LC'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LC')"/>";
			arrCandidate[0] = new Array("LC", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LC')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'LC']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);

			arrCandidateName['LCTnx'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LC_TNX')"/>";
			arrCandidate[1] = new Array("LCTnx", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LC_TNX')"/>", 2, <xsl:choose><xsl:when test="count(candidate[@name = 'LCTnx']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);

			<xsl:if test="security:isCustomer($rundata) or $isTemplate='true'">
				arrCandidateName['LCTemplate'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LC_TEMPLATE')"/>";
				arrCandidate[2] = new Array("LCTemplate", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LC_TEMPLATE')"/>", 3, <xsl:choose><xsl:when test="count(candidate[@name = 'LCTemplate']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
			</xsl:if>
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'LS')">
			arrCandidateName['LS'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LS')"/>";
			arrCandidate[3] = new Array("LS", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LS')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'LS']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);

			arrCandidateName['LSTnx'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LS_TNX')"/>";
			arrCandidate[4] = new Array("LSTnx", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LS_TNX')"/>", 2, <xsl:choose><xsl:when test="count(candidate[@name = 'LSTnx']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);

			<xsl:if test="security:isCustomer($rundata) or $isTemplate='true'">
				arrCandidateName['LSTemplate'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LS_TEMPLATE')"/>";
				arrCandidate[5] = new Array("LSTemplate", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LS_TEMPLATE')"/>", 3, <xsl:choose><xsl:when test="count(candidate[@name = 'LSTemplate']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
			</xsl:if>
			
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'RI')">
			arrCandidateName['RI'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_RI')"/>";
			arrCandidate[6] = new Array("RI", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_RI')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'RI']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);

			arrCandidateName['RITnx'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_RI_TNX')"/>";
			arrCandidate[7] = new Array("RITnx", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_RI_TNX')"/>", 2, <xsl:choose><xsl:when test="count(candidate[@name = 'RITnx']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);

			<xsl:if test="security:isCustomer($rundata) or $isTemplate='true'">
				arrCandidateName['RITemplate'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_RI_TEMPLATE')"/>";
				arrCandidate[8] = new Array("RITemplate", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_RI_TEMPLATE')"/>", 3, <xsl:choose><xsl:when test="count(candidate[@name = 'RITemplate']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
			</xsl:if>
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'SE')">
			arrCandidateName['SE'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SE')"/>";
			arrCandidate[9] = new Array("SE", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SE')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'SE']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);

			arrCandidateName['SETnx'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SE_TNX')"/>";
			arrCandidate[10] = new Array("SETnx", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SE_TNX')"/>", 2, <xsl:choose><xsl:when test="count(candidate[@name = 'SETnx']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);

			<xsl:if test="security:isCustomer($rundata) or $isTemplate='true'">
				arrCandidateName['SETemplate'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SE_TEMPLATE')"/>";
				arrCandidate[11] = new Array("SETemplate", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SE_TEMPLATE')"/>", 3, <xsl:choose><xsl:when test="count(candidate[@name = 'SETemplate']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
			</xsl:if>
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'EL')">
			arrCandidateName['EL'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EL')"/>";
			arrCandidate[12] = new Array("EL", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EL')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'EL']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);

			arrCandidateName['ELTnx'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EL_TNX')"/>";
			arrCandidate[13] = new Array("ELTnx", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EL_TNX')"/>", 2, <xsl:choose><xsl:when test="count(candidate[@name = 'ELTnx']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'SI')">
			arrCandidateName['SI'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SI')"/>";
			arrCandidate[14] = new Array("SI", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SI')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'SI']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);

			arrCandidateName['SITnx'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SI_TNX')"/>";
			arrCandidate[15] = new Array("SITnx", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SI_TNX')"/>", 2, <xsl:choose><xsl:when test="count(candidate[@name = 'SITnx']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);

			<xsl:if test="security:isCustomer($rundata) or $isTemplate='true'">
				arrCandidateName['SITemplate'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SI_TEMPLATE')"/>";
				arrCandidate[16] = new Array("SITemplate", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SI_TEMPLATE')"/>", 3, <xsl:choose><xsl:when test="count(candidate[@name = 'SITemplate']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
			</xsl:if>
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'SR')">
			arrCandidateName['SR'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SR')"/>";
			arrCandidate[17] = new Array("SR", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SR')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'SR']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);

			arrCandidateName['SRTnx'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SR_TNX')"/>";
			arrCandidate[18] = new Array("SRTnx", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SR_TNX')"/>", 2, <xsl:choose><xsl:when test="count(candidate[@name = 'SRTnx']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'SG')">
			arrCandidateName['SG'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SG')"/>";
			arrCandidate[19] = new Array("SG", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SG')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'SG']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);

			arrCandidateName['SGTnx'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SG_TNX')"/>";
			arrCandidate[20] = new Array("SGTnx", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SG_TNX')"/>", 2, <xsl:choose><xsl:when test="count(candidate[@name = 'SGTnx']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'TF')">
			arrCandidateName['TF'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_TF')"/>";
			arrCandidate[21] = new Array("TF", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_TF')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'TF']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);

			arrCandidateName['TFTnx'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_TF_TNX')"/>";
			arrCandidate[22] = new Array("TFTnx", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_TF_TNX')"/>", 2, <xsl:choose><xsl:when test="count(candidate[@name = 'TFTnx']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
		</xsl:if>
		<xsl:choose>	
			<xsl:when test="$swift2019Enabled">
			<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'BG')">
				arrCandidateName['BG'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IU')"/>";
				arrCandidate[88] = new Array("BG", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IU')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'BG']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
	
				arrCandidateName['BGTnx'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IU_TNX')"/>";
				arrCandidate[89] = new Array("BGTnx", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IU_TNX')"/>", 2, <xsl:choose><xsl:when test="count(candidate[@name = 'BGTnx']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
				<xsl:if test="security:isCustomer($rundata) or $isTemplate='true'">
					arrCandidateName['BGTemplate'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IU_TEMPLATE')"/>";
					arrCandidate[90] = new Array("BGTemplate", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IU_TEMPLATE')"/>", 3, <xsl:choose><xsl:when test="count(candidate[@name = 'BGTemplate']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
				</xsl:if>
			</xsl:if>
			</xsl:when>
		<xsl:otherwise>
			<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'BG')">
				arrCandidateName['BG'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BG')"/>";
				arrCandidate[23] = new Array("BG", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BG')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'BG']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
	
				arrCandidateName['BGTnx'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BG_TNX')"/>";
				arrCandidate[24] = new Array("BGTnx", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BG_TNX')"/>", 2, <xsl:choose><xsl:when test="count(candidate[@name = 'BGTnx']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
				<xsl:if test="security:isCustomer($rundata) or $isTemplate='true'">
					arrCandidateName['BGTemplate'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BG_TEMPLATE')"/>";
					arrCandidate[25] = new Array("BGTemplate", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BG_TEMPLATE')"/>", 3, <xsl:choose><xsl:when test="count(candidate[@name = 'BGTemplate']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
				</xsl:if>
			</xsl:if>
		</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'EC')">
			arrCandidateName['EC'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EC')"/>";
			arrCandidate[26] = new Array("EC", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EC')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'EC']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);

			arrCandidateName['ECTnx'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EC_TNX')"/>";
			arrCandidate[27] = new Array("ECTnx", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EC_TNX')"/>", 2, <xsl:choose><xsl:when test="count(candidate[@name = 'ECTnx']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
			<xsl:if test="security:isCustomer($rundata) or $isTemplate='true'">
				arrCandidateName['ECTemplate'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EC_TEMPLATE')"/>";
			arrCandidate[28] = new Array("ECTemplate", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EC_TEMPLATE')"/>", 3, <xsl:choose><xsl:when test="count(candidate[@name = 'ECTemplate']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
			</xsl:if>
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'IC')">
			arrCandidateName['IC'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IC')"/>";
			arrCandidate[29] = new Array("IC", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IC')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'IC']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);

			arrCandidateName['ICTnx'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IC_TNX')"/>";
			arrCandidate[30] = new Array("ICTnx", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IC_TNX')"/>", 2, <xsl:choose><xsl:when test="count(candidate[@name = 'ICTnx']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'FT')">
			arrCandidateName['FT'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FT')"/>";
			arrCandidate[31] = new Array("FT", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FT')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'FT']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);

			arrCandidateName['FTTnx'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FT_TNX')"/>";
			arrCandidate[32] = new Array("FTTnx", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FT_TNX')"/>", 2, <xsl:choose><xsl:when test="count(candidate[@name = 'FTTnx']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
			<xsl:if test="security:isCustomer($rundata) or $isTemplate='true'">
				arrCandidateName['FTTemplate'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FT_TEMPLATE')"/>";
				arrCandidate[33] = new Array("FTTemplate", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FT_TEMPLATE')"/>", 3, <xsl:choose><xsl:when test="count(candidate[@name = 'FTTemplate']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
			</xsl:if>
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'LI')">
			arrCandidateName['LI'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LI')"/>";
			arrCandidate[34] = new Array("LI", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LI')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'LI']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);

			arrCandidateName['LITnx'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LI_TNX')"/>";
			arrCandidate[35] = new Array("LITnx", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LI_TNX')"/>", 2, <xsl:choose><xsl:when test="count(candidate[@name = 'LITnx']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'PO')">
			arrCandidateName['PO'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_PO')"/>";
			arrCandidate[36] = new Array("PO", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_PO')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'PO']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);

			arrCandidateName['POTnx'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_PO_TNX')"/>";
			arrCandidate[37] = new Array("POTnx", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_PO_TNX')"/>", 2, <xsl:choose><xsl:when test="count(candidate[@name = 'POTnx']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
			
			<xsl:if test="security:isCustomer($rundata) or $isTemplate='true'">
				arrCandidateName['POTemplate'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_PO_TEMPLATE')"/>";
				arrCandidate[38] = new Array("POTemplate", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_PO_TEMPLATE')"/>", 3, <xsl:choose><xsl:when test="count(candidate[@name = 'POTemplate']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
			</xsl:if>
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'IN')">
			arrCandidateName['IN'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IN')"/>";
			arrCandidate[39] = new Array("IN", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IN')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'IN']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);

			arrCandidateName['INTnx'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IN_TNX')"/>";
			arrCandidate[40] = new Array("INTnx", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IN_TNX')"/>", 2, <xsl:choose><xsl:when test="count(candidate[@name = 'INTnx']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);			

		</xsl:if>		
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'IP')">
			arrCandidateName['IP'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IP')"/>";
			arrCandidate[42] = new Array("IP", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IP')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'IP']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);

			arrCandidateName['IPTnx'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IP_TNX')"/>";
			arrCandidate[43] = new Array("IPTnx", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IP_TNX')"/>", 2, <xsl:choose><xsl:when test="count(candidate[@name = 'IPTnx']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);		
	
		</xsl:if>						
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'IN')">
			arrCandidateName['SO'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SO')"/>";
			arrCandidate[45] = new Array("SO", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SO')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'SO']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);

			arrCandidateName['SOTnx'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SO_TNX')"/>";
			arrCandidate[46] = new Array("SOTnx", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SO_TNX')"/>", 2, <xsl:choose><xsl:when test="count(candidate[@name = 'SOTnx']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'PO') or  securityCheck:hasCompanyProductPermission($rundata,'IN') or securityCheck:hasCompanyProductPermission($rundata,'SO') or securityCheck:hasCompanyProductPermission($rundata,'IO') or securityCheck:hasCompanyProductPermission($rundata,'EA')">
			arrCandidateName['LT'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LT')"/>";
			arrCandidate[47] = new Array("LT", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LT')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'LT']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);

			arrCandidateName['LTTnx'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LT_TNX')"/>";
			arrCandidate[48] = new Array("LTTnx", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LT_TNX')"/>", 2, <xsl:choose><xsl:when test="count(candidate[@name = 'LTTnx']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
			
			<xsl:if test="security:isCustomer($rundata) or $isTemplate='true'">
				arrCandidateName['LTTemplate'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LT_TEMPLATE')"/>";
				arrCandidate[49] = new Array("LTTemplate", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LT_TEMPLATE')"/>", 3, <xsl:choose><xsl:when test="count(candidate[@name = 'LTTemplate']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
			</xsl:if>
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'TU')">
			arrCandidateName['TU'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_TU')"/>";
			arrCandidate[50] = new Array("TU", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_TU')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'TU']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);

			arrCandidateName['TUTnx'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_TU_TNX')"/>";
			arrCandidate[51] = new Array("TUTnx", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_TU_TNX')"/>", 2, <xsl:choose><xsl:when test="count(candidate[@name = 'TUTnx']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'TU')">
			arrCandidateName['BN'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BN')"/>";
			arrCandidate[52] = new Array("BN", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BN')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'BN']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'IR')">
			arrCandidateName['IR'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IR')"/>";
			arrCandidate[53] = new Array("IR", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IR')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'IR']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);

			arrCandidateName['IRTnx'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IR_TNX')"/>";
			arrCandidate[54] = new Array("IRTnx", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IR_TNX')"/>", 2, <xsl:choose><xsl:when test="count(candidate[@name = 'IRTnx']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'FX')">
			arrCandidateName['FX'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FX')"/>";
			arrCandidate[55] = new Array("FX", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FX')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'FX']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);

			arrCandidateName['FXTnx'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FX_TNX')"/>";
			arrCandidate[56] = new Array("FXTnx", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FX_TNX')"/>", 2, <xsl:choose><xsl:when test="count(candidate[@name = 'FXTnx']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'LN')">
			arrCandidateName['LN'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LN')"/>";
			arrCandidate[57] = new Array("LN", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LN')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'LN']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);

			arrCandidateName['LNTnx'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LN_TNX')"/>";
			arrCandidate[58] = new Array("LNTnx", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LN_TNX')"/>", 2, <xsl:choose><xsl:when test="count(candidate[@name = 'LNTnx']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'TD')">
			arrCandidateName['TD'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_TD')"/>";
			arrCandidate[59] = new Array("TD", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_TD')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'TD']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);

			arrCandidateName['TDTnx'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_TD_TNX')"/>";
			arrCandidate[60] = new Array("TDTnx", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_TD_TNX')"/>", 2, <xsl:choose><xsl:when test="count(candidate[@name = 'TDTnx']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
		</xsl:if>

		<xsl:if test="securityCheck:hasCompanyPermission($rundata,'audit_access')">
			arrCandidateName['Audit'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_AUDIT')"/>";
			arrCandidate[65] = new Array("Audit", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_AUDIT')"/>", 4, <xsl:choose><xsl:when test="count(candidate[@name = 'Audit']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
		</xsl:if>
		
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'FX') or securityCheck:hasCompanyProductPermission($rundata,'TD') or securityCheck:hasCompanyProductPermission($rundata,'LA')">
			arrCandidateName['AccountStatementLine'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_ACCOUNT_STATEMENT_LINE')"/>";
			arrCandidate[66] = new Array("AccountStatementLine", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_ACCOUNT_STATEMENT_LINE')"/>", 5, <xsl:choose><xsl:when test="count(candidate[@name = 'AccountStatementLine']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'FA')">
			arrCandidateName['FA'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FA')"/>";
			arrCandidate[67] = new Array("FA", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FA')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'FA']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);

			arrCandidateName['FATnx'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FA_TNX')"/>";
			arrCandidate[68] = new Array("FATnx", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FA_TNX')"/>", 2, <xsl:choose><xsl:when test="count(candidate[@name = 'FATnx']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
		</xsl:if>
		<xsl:choose>	
			<xsl:when test="$swift2019Enabled">
				<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'BR')">
						arrCandidateName['BR'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_RU')"/>";
						arrCandidate[91] = new Array("BR", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_RU')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'BR']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);

						arrCandidateName['BRTnx'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_RU_TNX')"/>";
						arrCandidate[92] = new Array("BRTnx", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_RU_TNX')"/>", 2, <xsl:choose><xsl:when test="count(candidate[@name = 'BRTnx']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'BR')">
						arrCandidateName['BR'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BR')"/>";
						arrCandidate[69] = new Array("BR", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BR')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'BR']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);

						arrCandidateName['BRTnx'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BR_TNX')"/>";
						arrCandidate[70] = new Array("BRTnx", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BR_TNX')"/>", 2, <xsl:choose><xsl:when test="count(candidate[@name = 'BRTnx']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>	
		<xsl:if test="securityCheck:hasPermission($rundata,'company_role_access')">
			arrCandidateName['CompanyRolePermission'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COMPANY_ENTITY_USER_ROLE')"/>";
			arrCandidate[71] = new Array("CompanyRolePermission", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COMPANY_ENTITY_USER_ROLE')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'CompanyRolePermission']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'IO')">
			arrCandidateName['IO'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IO')"/>";
			arrCandidate[72] = new Array("IO", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IO')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'IO']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
	
			arrCandidateName['IOTnx'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IO_TNX')"/>";
			arrCandidate[73] = new Array("IOTnx", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IO_TNX')"/>", 2, <xsl:choose><xsl:when test="count(candidate[@name = 'IOTnx']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
		</xsl:if>
		<xsl:if test="securityCheck:hasPermission($rundata,'company_role_access')">
			arrCandidateName['FacilityLimitMaintenance'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FACILITY_LIMIT_MAINTENANCE')"/>";
			arrCandidate[74] = new Array("FacilityLimitMaintenance", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FACILITY_LIMIT_MAINTENANCE')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'FacilityLimitMaintenance']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'EA')">
			arrCandidateName['EA'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EA')"/>";
			arrCandidate[75] = new Array("EA", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EA')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'EA']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
	
			arrCandidateName['EATnx'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EA_TNX')"/>";
			arrCandidate[76] = new Array("EATnx", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EA_TNX')"/>", 2, <xsl:choose><xsl:when test="count(candidate[@name = 'EATnx']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
		</xsl:if>
			<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'BK')">
			arrCandidateName['BK'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BK')"/>";
			arrCandidate[77] = new Array("BK", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BK')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'BK']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
	
			arrCandidateName['BKTnx'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BK_TNX')"/>";
			arrCandidate[78] = new Array("BKTnx", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BK_TNX')"/>", 2, <xsl:choose><xsl:when test="count(candidate[@name = 'BKTnx']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
		</xsl:if>
			<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'CN')">
			arrCandidateName['CN'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CN')"/>";
			arrCandidate[79] = new Array("CN", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CN')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'CN']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
	
			arrCandidateName['CNTnx'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CN_TNX')"/>";
			arrCandidate[80] = new Array("CNTnx", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CN_TNX')"/>", 2, <xsl:choose><xsl:when test="count(candidate[@name = 'CNTnx']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
		    <xsl:if test="security:isCustomer($rundata) or $isTemplate='true'">
				arrCandidateName['CNTemplate'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CN_TEMPLATE')"/>";
				arrCandidate[81] = new Array("CNTemplate", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CN_TEMPLATE')"/>", 3, <xsl:choose><xsl:when test="count(candidate[@name = 'CNTemplate']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
			</xsl:if>
		
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'CR')">
			arrCandidateName['CR'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CR')"/>";
			arrCandidate[82] = new Array("CR", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CR')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'CR']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
	
			arrCandidateName['CRTnx'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CR_TNX')"/>";
			arrCandidate[83] = new Array("CRTnx", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CR_TNX')"/>", 2, <xsl:choose><xsl:when test="count(candidate[@name = 'CRTnx']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
		    <xsl:if test="security:isCustomer($rundata) or $isTemplate='true'">
				arrCandidateName['CRTemplate'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CR_TEMPLATE')"/>";
				arrCandidate[84] = new Array("CRTemplate", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CR_TEMPLATE')"/>", 3, <xsl:choose><xsl:when test="count(candidate[@name = 'CRTemplate']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
			</xsl:if>
		
		</xsl:if>
		<xsl:if test="securityCheck:hasPermission($rundata,'sy_cust_facility_access')">
			arrCandidateName['FacilityLimitMaintenance'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FACILITY_LIMIT_MAINTENANCE')"/>";
			arrCandidate[84] = new Array("FacilityLimitMaintenance", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FACILITY_LIMIT_MAINTENANCE')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'FacilityLimitMaintenance']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
		</xsl:if>
		<xsl:if test="securityCheck:hasPermission($rundata,'company_role_access')">
			arrCandidateName['UserProfile'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_USER')"/>";
			arrCandidate[85] = new Array("UserProfile", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_USER')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'UserProfile']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
		</xsl:if>
		<xsl:if test="securityCheck:hasPermission($rundata,'company_role_access')">
			arrCandidateName['CompanyProfile'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COMPANY_ENTITY')"/>";
			arrCandidate[87] = new Array("CompanyProfile", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COMPANY_ENTITY')"/>", 1, <xsl:choose><xsl:when test="count(candidate[@name = 'CompanyProfile']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'FX') or securityCheck:hasCompanyProductPermission($rundata,'TD') or securityCheck:hasCompanyProductPermission($rundata,'LA')">
			arrCandidateName['AccountStatement'] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_ACCOUNT_STATEMENT')"/>";
			arrCandidate[87] = new Array("AccountStatement", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_ACCOUNT_STATEMENT')"/>", 5, <xsl:choose><xsl:when test="count(candidate[@name = 'AccountStatement']) != 0">true</xsl:when><xsl:otherwise>false</xsl:otherwise></xsl:choose>);
		</xsl:if>
			
	</xsl:template>


	<xsl:template name="js-imports">
		<xsl:call-template name="common-js-imports">
			<xsl:with-param name="binding">misys.binding.system.create_report</xsl:with-param>
			<xsl:with-param name="xml-tag-name">report</xsl:with-param>
			<!-- <xsl:with-param name="override-help-access-key">SY_RD</xsl:with-param> -->
			<xsl:with-param name="override-help-access-key">
			 <xsl:choose>
	   	<xsl:when test="security:isBank($rundata)">SY_RD_BANK</xsl:when>
	   	<xsl:when test="security:isCustomer($rundata)">SY_RD_C</xsl:when>
	   </xsl:choose>
	  </xsl:with-param>
		</xsl:call-template>
	</xsl:template>


	<!--TEMPLATE Main-->
	<xsl:template match="report">
	 


		<script><xsl:call-template name="product-arraylist-initialisation"/></script>
		<script>
		   dojo.ready(function(){
		  		misys._config = misys._config || {};
		  		dojo.mixin(misys._config, {
		  			productResourceMapping : {
	    			<xsl:if test="count(/report/mapping_elements/mapping_element) > 0" >
		        		<xsl:for-each select="/report/mapping_elements/mapping_element/product" >
		        			<xsl:variable name="productCode" select="self::node()/text()" />
	   						<xsl:value-of select="."/>: [
		   						<xsl:for-each select="/report/mapping_elements/mapping_element[product=$productCode]/source" >
		   							{ value:"<xsl:value-of select="value"/>",
				         				name:"<xsl:value-of select="name"/>"},
		   						</xsl:for-each>
	   								]<xsl:if test="not(position()=last())">,</xsl:if>
		         		</xsl:for-each>
	         		</xsl:if>
						}
					});
		   		});
  		</script>
		
		<!-- Define general variables -->	
		<script>

			<!-- Build candidate array, column array, column definition array, set of values array, aggregate fields -->
			
			<!-- Set language -->
			var language = "<xsl:value-of select="$language"/>";
			<!-- Set languages -->
			var languages = [];
 			<xsl:for-each select="$languages/languages/language">
				languages[<xsl:value-of select="position()-1"/>] = '<xsl:value-of select="."/>';
			</xsl:for-each>
			// Set some localized labels used within javascript (hence localized resource stays on the server)
			<!-- TODO uncomment 
			var computedLabel = '<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_DISPCOL_COMPUTED')"/>';-->
			// Set screen
			var screenName = '<xsl:value-of select="$nextscreen"/>';
			// Define array of products available
			<xsl:call-template name="product-codes"/>
			<xsl:apply-templates select="definition" mode="init"/>
		</script>
		
		<!-- Javascript and Dojo imports -->
	 	<xsl:call-template name="js-imports"/>

		<!-- generate the column definitions -->
		<script><xsl:call-template name="Columns_Definitions"/></script>

		<!-- Retrieve the javascript products' columns and candidate for every product authorised for the current user -->
		<xsl:call-template name="Products_Columns_Candidates"/>


		<script>
			<!-- Populate the computed field ids -->
			<xsl:variable name="counter">0</xsl:variable>
			<xsl:for-each select="column[./@computation]">
				arrComputedFieldId[<xsl:value-of select="$counter"/>] = '<xsl:value-of select="@name"/>';
				arrColumn["<xsl:value-of select="@name"/>"] = new Array(arrColumn["<xsl:value-of select="./column[1]/@name"/>"][0], "<xsl:value-of select="@name"/>");
				<xsl:variable name="counter"><xsl:value-of select="number($counter) + 1"/></xsl:variable>
			</xsl:for-each>

			<!-- Include some eventual additional columns -->
			<xsl:call-template name="report_addons">
				<xsl:with-param name="isTemplate"><xsl:value-of select="$isTemplate"/></xsl:with-param>
			</xsl:call-template>

		</script>

        <!-- Preloader    -->
        <xsl:call-template name="loading-message"/>


		<!-- ******** -->
		<!-- Products -->
		<!-- ******** -->
		<!-- Dialog Start -->
		<div id="product-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
				<xsl:call-template name="select-field">
					<xsl:with-param name="label">XSL_REPORT_PRODUCT</xsl:with-param>
					<xsl:with-param name="name">product</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
				</xsl:call-template>
				<div class="dijitDialogPaneActionBar">				
					<xsl:call-template name="label-wrapper">
						<xsl:with-param name="content">
							<button dojoType="dijit.form.Button" type="button">
								<xsl:attribute name="id">product-ok</xsl:attribute>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')"/>
							</button>
							<button dojoType="dijit.form.Button" type="button">
								<xsl:attribute name="id">product-cancel</xsl:attribute>
								<xsl:attribute name="onClick">dijit.byId('product-dialog-template').hide();</xsl:attribute>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')"/>
							</button>
						</xsl:with-param>
					</xsl:call-template>
				</div>
		</div>
		<!-- Dialog End -->
		<div id="products-template" style="display:none">
			<div class="clear">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_NO_PRODUCT')"/>
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode"/>
				</div>
				<p><br/></p>
				<button dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem" type="button">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_ADD_PRODUCT')"/>
				</button>
			</div>
		</div>

		<!-- ******* -->
		<!-- Columns -->
		<!-- ******* -->
		<!-- Dialog Start -->
		<div id="column-dialog-template" style="display:none;" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
				<!-- Column -->
				<xsl:call-template name="select-field">
					<xsl:with-param name="label">XSL_REPORT_DISPCOLDETAILS_COLUMN</xsl:with-param>
					<xsl:with-param name="name">column</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
					<xsl:with-param name="type">filter</xsl:with-param>
				</xsl:call-template>
				<!-- Label in the default language -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label" select="concat('XSL_REPORT_DISPCOLDETAILS_LABEL_', $language)"/>
					<xsl:with-param name="required">Y</xsl:with-param>
					<xsl:with-param name="name" select="concat('label_', $language)"/>
					<xsl:with-param name="swift-validate">N</xsl:with-param>
					<xsl:with-param name="button-type">report-language</xsl:with-param>
					<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('REPORT_DESIGNER_DISPLAYED_COLUMN_LABEL_REGEX')"/></xsl:with-param>
				</xsl:call-template>
				
				<!-- Labels in other languages -->
				<div id="displayed_column_labels_other_languages" style="display: none">
					<xsl:for-each select="$languages/languages/language">
						<xsl:variable name="selectedLanguage" select="."/>
						<xsl:if test="$selectedLanguage != $language">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label" select="concat('XSL_REPORT_DISPCOLDETAILS_LABEL_', $selectedLanguage)"/>
								<xsl:with-param name="name" select="concat('label_', $selectedLanguage)"/>
								<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('REPORT_DESIGNER_DISPLAYED_COLUMN_LABEL_REGEX')"/></xsl:with-param>
						</xsl:call-template>
						</xsl:if>
					</xsl:for-each>
				</div>
				<!-- Alignment -->
				<xsl:call-template name="select-field">
					<xsl:with-param name="label">XSL_REPORT_DISPCOLDETAILS_ALIGNMENT</xsl:with-param>
					<xsl:with-param name="name">alignment</xsl:with-param>
					<xsl:with-param name="type">filter</xsl:with-param>
					<xsl:with-param name="options">
						<option value=""/>
						<option value="center">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_DISPCOLDETAILS_ALIGNMENT_MIDDLE')"/>
						</option>
						<option value="left">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_DISPCOLDETAILS_ALIGNMENT_LEFT')"/>
						</option>
						<option value="right">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_DISPCOLDETAILS_ALIGNMENT_RIGHT')"/>
						</option>
					</xsl:with-param>
				</xsl:call-template>
				<div id="width-to-computed-field-div">
				<!-- Column width -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_REPORT_DISPCOLDETAILS_WIDTH</xsl:with-param>
					<xsl:with-param name="name">width</xsl:with-param>
					<xsl:with-param name="swift-validate">N</xsl:with-param>
					<xsl:with-param name="size">5</xsl:with-param>
					<xsl:with-param name="maxsize">5</xsl:with-param>
					<xsl:with-param name="type">number</xsl:with-param>
					<xsl:with-param name="override-constraints">{min:0,max:100,pattern: '###'}</xsl:with-param>
				</xsl:call-template>
				<!-- Equivalent currency section -->
				<div id="eqv_currency_section" style="display:block">
					<xsl:call-template name="currency-field">
			         <xsl:with-param name="label">XSL_REPORT_DISPCOLDETAILS_EQV_CURRENCY</xsl:with-param>
			         <xsl:with-param name="product-code">eqv</xsl:with-param>
					 <xsl:with-param name="show-amt">N</xsl:with-param>
			        </xsl:call-template>
		
				</div>
				<!-- Abbreviation -->
				<xsl:call-template name="checkbox-field">
					<xsl:with-param name="label">XSL_REPORT_DISPCOLDETAILS_USE_ABBREVIATION</xsl:with-param>
					<xsl:with-param name="name">abbreviation</xsl:with-param>
				</xsl:call-template>
				<!-- Computed field -->
				<xsl:call-template name="checkbox-field">
					<xsl:with-param name="label">XSL_REPORT_DISPCOLDETAILS_COMPUTED_FIELD</xsl:with-param>
					<xsl:with-param name="name">computed_field</xsl:with-param>
				</xsl:call-template>
				<div id="computation_section">
					<!-- Computed field identifier -->
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_REPORT_DISPCOLDETAILS_COMPUTED_FIELD_ID</xsl:with-param>
						<xsl:with-param name="name">computed_field_id</xsl:with-param>
						<xsl:with-param name="swift-validate">N</xsl:with-param>
						<xsl:with-param name="size">20</xsl:with-param>
						<xsl:with-param name="maxsize">20</xsl:with-param>
					</xsl:call-template>
					<!-- Operation -->
					<xsl:call-template name="select-field">
						<xsl:with-param name="label">XSL_REPORT_DISPCOLDETAILS_OPERATION</xsl:with-param>
						<xsl:with-param name="name">operation</xsl:with-param>
						<xsl:with-param name="type">filter</xsl:with-param>
					</xsl:call-template>
					<!-- Operand -->
					<xsl:call-template name="select-field">
						<xsl:with-param name="label">XSL_REPORT_DISPCOLDETAILS_OPERAND_FIELD</xsl:with-param>
						<xsl:with-param name="name">operand</xsl:with-param>
						<xsl:with-param name="type">filter</xsl:with-param>
					</xsl:call-template>
				</div>
				</div>
				<div class="dijitDialogPaneActionBar">
					<xsl:call-template name="label-wrapper">
						<xsl:with-param name="content">
							<button dojoType="dijit.form.Button" type="button" id="addColumnOkButton" onClick="misys.submitDialog('column-dialog-template')">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')"/>
							</button>
							<button dojoType="dijit.form.Button" type="button" onClick="dijit.byId('column-dialog-template').hide();">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')"/>
							</button>
						</xsl:with-param>
					</xsl:call-template>
				</div>
		</div>
		<!-- Dialog End -->
		<div id="columns-template" style="display:none">
			<div class="clear">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_NO_DISPLAYED_COLUMNS')"/>
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode"/>
				</div>
				<p><br/></p>
				<button dojoType="dijit.form.Button" type="button" dojoAttachEvent="onClick: addItem" id="addColumnButton">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_ADD_COLUMN')"/>
				</button>
				<p><br/></p>
			</div>
		</div>

		<!-- ********** -->
		<!-- Parameters -->
		<!-- ********** -->
		<!-- Dialog Start -->
		<div id="parameter-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
				<!-- Name -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_REPORT_PARAMETERDETAILS_NAME</xsl:with-param>
					<xsl:with-param name="name">parameter_name</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
					<xsl:with-param name="swift-validate">N</xsl:with-param>
					<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('REPORT_DESIGNER_PARAMETERS_PARAMETER_NAME_REGEX')"/></xsl:with-param>
				</xsl:call-template>
				<!-- Label in the default language -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label" select="concat('XSL_REPORT_DISPCOLDETAILS_LABEL_', $language)"/>
					<xsl:with-param name="required">Y</xsl:with-param>
					<xsl:with-param name="name" select="concat('parameter_label_', $language)"/>
					<xsl:with-param name="swift-validate">N</xsl:with-param>
					<xsl:with-param name="button-type">report-parameter</xsl:with-param>
					<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('REPORT_DESIGNER_DISPLAYED_COLUMN_LABEL_REGEX')"/></xsl:with-param>
				</xsl:call-template>
				
				<!-- Labels in other languages -->
				<div id="parameter_labels_other_languages" style="display: none">
					<xsl:for-each select="$languages/languages/language">
						<xsl:variable name="selectedLanguage" select="."/>
						<xsl:if test="$selectedLanguage != $language">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label" select="concat('XSL_REPORT_DISPCOLDETAILS_LABEL_', $selectedLanguage)"/>
								<xsl:with-param name="name" select="concat('parameter_label_', $selectedLanguage)"/>
								<xsl:with-param name="swift-validate">N</xsl:with-param>
								<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('REPORT_DESIGNER_DISPLAYED_COLUMN_LABEL_REGEX')"/></xsl:with-param>
							</xsl:call-template>
						</xsl:if>
					</xsl:for-each>
				</div>
		
				<xsl:call-template name="multioption-group">
					<xsl:with-param name="group-label"/>
					<xsl:with-param name="content">
						<!-- Mandatory parameter -->
						<xsl:call-template name="checkbox-field">
							<xsl:with-param name="label">XSL_REPORT_PARAMETERDETAILS_MANDATORY</xsl:with-param>
							<xsl:with-param name="name">parameter_mandatory</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				
				<div class="dijitDialogPaneActionBar">
					<xsl:call-template name="label-wrapper">
						<xsl:with-param name="content">
							<button dojoType="dijit.form.Button" type="button" onClick="misys.submitDialog('parameter-dialog-template')">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')"/>
							</button>
							<button dojoType="dijit.form.Button" type="button">
								<xsl:attribute name="onClick">dijit.byId('parameter-dialog-template').hide();</xsl:attribute>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')"/>
							</button>
						</xsl:with-param>
					</xsl:call-template>
				</div>
		</div>
		<!-- Dialog End -->
		<div id="parameters-template" style="display:none">
			<div class="clear">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_NO_PARAMETERS')"/>
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode"/>
				</div>
				<p><br/></p>
				<button dojoType="dijit.form.Button" type="button" dojoAttachEvent="onClick: addItem">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_ADD_PARAMETER')"/>
				</button>
			</div>
		</div>

		<!-- ******** -->
		<!-- Criteria -->
		<!-- ******** -->
		<!-- Dialog Start -->
		<div id="criterium-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
		
					<!-- Column -->
					<xsl:call-template name="select-field">
						<xsl:with-param name="label">XSL_REPORT_FILTERDETAILS_COLUMN</xsl:with-param>
						<xsl:with-param name="name">criterium_column</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
						<xsl:with-param name="type">filter</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">criterium_value_set_value</xsl:with-param>
					</xsl:call-template>
					<!-- Column type -->
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">criterium_column_type</xsl:with-param>
					</xsl:call-template>						
					<!-- Operator -->
					<xsl:call-template name="select-field">
						<xsl:with-param name="label">XSL_REPORT_FILTERDETAILS_OPERATOR</xsl:with-param>
						<xsl:with-param name="name">criterium_operator</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
						<xsl:with-param name="type">filter</xsl:with-param>
					</xsl:call-template>
					<div id="criterium_operand_type_section" style="display:none">
						<xsl:call-template name="multioption-group">
							<xsl:with-param name="group-label"/>
							<xsl:with-param name="content">
								<!-- Parameter/value type -->
								<div id="criterium_operand_type_section_1">
								<xsl:call-template name="radio-field">
									<xsl:with-param name="label">XSL_REPORT_FILTERDETAILS_PARAMETER_CHOICE</xsl:with-param>
									<xsl:with-param name="name">criterium_operand_type</xsl:with-param>
									<xsl:with-param name="id">criterium_value_type_1</xsl:with-param>
									<xsl:with-param name="value">01</xsl:with-param>
								</xsl:call-template>
								</div>
								<div id="criterium_operand_type_section_2">
								<xsl:call-template name="radio-field">
									<xsl:with-param name="label">XSL_REPORT_FILTERDETAILS_VALUE_CHOICE</xsl:with-param>
									<xsl:with-param name="name">criterium_operand_type</xsl:with-param>
									<xsl:with-param name="id">criterium_value_type_2</xsl:with-param>
									<xsl:with-param name="value">02</xsl:with-param>
								</xsl:call-template>
								</div>
								<div id="criterium_operand_type_section_3">
								<xsl:call-template name="radio-field">
									<xsl:with-param name="label">XSL_REPORT_FILTERDETAILS_PREDEFINED_VALUE_CHOICE</xsl:with-param>
									<xsl:with-param name="name">criterium_operand_type</xsl:with-param>
									<xsl:with-param name="id">criterium_value_type_3</xsl:with-param>
									<xsl:with-param name="value">03</xsl:with-param>
								</xsl:call-template>
								</div>
							</xsl:with-param>
						</xsl:call-template>
					</div>
					<!-- Parameter -->
					<div id="criterium_parameter_section" style="display:none">
						<!-- Parameter -->
						<xsl:call-template name="select-field">
							<xsl:with-param name="label">XSL_REPORT_FILTERDETAILS_PARAMETER</xsl:with-param>
							<xsl:with-param name="name">criterium_parameter</xsl:with-param>
							<xsl:with-param name="type">filter</xsl:with-param>
						</xsl:call-template>							
					
		
					<!-- Parameter - Default String value -->
					<div id="criterium_parameter_default_string_section" style="display:none">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_REPORT_CRITERIUM_PARAMETER_DEFAULT_VALUE</xsl:with-param>
							<xsl:with-param name="name">criterium_parameter_default_string_value</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="swift-validate">N</xsl:with-param>
						</xsl:call-template>
					</div>
		
					<!-- Parameter - Default Number value -->
					<div id="criterium_parameter_default_number_section" style="display:none">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_REPORT_CRITERIUM_PARAMETER_DEFAULT_VALUE</xsl:with-param>
							<xsl:with-param name="name">criterium_parameter_default_number_value</xsl:with-param>
							<xsl:with-param name="maxsize">3</xsl:with-param>
							<xsl:with-param name="swift-validate">N</xsl:with-param>
						</xsl:call-template>
					</div>
		
					<!-- Parameter - Default Amount value -->
					<div id="criterium_parameter_default_amount_section" style="display:none">
						<xsl:call-template name="currency-field">
							<xsl:with-param name="label">XSL_REPORT_CRITERIUM_PARAMETER_DEFAULT_VALUE</xsl:with-param>
							<xsl:with-param name="product-code">criterium_parameter_default_amount</xsl:with-param>
							<xsl:with-param name="override-amt-name">criterium_parameter_default_amount_value</xsl:with-param>
							<xsl:with-param name="required">N</xsl:with-param>
							<xsl:with-param name="show-currency">N</xsl:with-param>
							<xsl:with-param name="show-button">N</xsl:with-param>
						</xsl:call-template>
					</div>
		
					<!-- Parameter - Default Date value -->
					<div id="criterium_parameter_default_date_section" style="display:none">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_REPORT_CRITERIUM_PARAMETER_DEFAULT_VALUE</xsl:with-param>
							<xsl:with-param name="name">criterium_parameter_default_date_value</xsl:with-param>
							<xsl:with-param name="size">10</xsl:with-param>
							<xsl:with-param name="maxsize">10</xsl:with-param>
							<xsl:with-param name="fieldsize">small</xsl:with-param>
							<xsl:with-param name="type">date</xsl:with-param>
							<xsl:with-param name="swift-validate">N</xsl:with-param>
						</xsl:call-template>
					</div>
		
					<!-- Parameter - Default Values set value -->
					<div id="criterium_parameter_default_values_set_section" style="display:none">
						<xsl:call-template name="select-field">
							<xsl:with-param name="label">XSL_REPORT_CRITERIUM_PARAMETER_DEFAULT_VALUE</xsl:with-param>
							<xsl:with-param name="name">criterium_parameter_default_values_set</xsl:with-param>
						</xsl:call-template>							
					</div>
					</div>
		
					<!-- String value -->
					<div id="criterium_string_section" style="display:none">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_REPORT_FILTERDETAILS_VALUE</xsl:with-param>
							<xsl:with-param name="name">criterium_string_value</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="swift-validate">N</xsl:with-param>
						</xsl:call-template>
					</div>
		
					<!-- Number value -->
					<div id="criterium_number_section" style="display:none">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_REPORT_FILTERDETAILS_VALUE</xsl:with-param>
							<xsl:with-param name="name">criterium_number_value</xsl:with-param>
							<xsl:with-param name="maxsize">3</xsl:with-param>
							<xsl:with-param name="swift-validate">N</xsl:with-param>
						</xsl:call-template>
					</div>
		
					<!-- Amount value -->
					<div id="criterium_amount_section" style="display:none">
						<xsl:call-template name="currency-field">
							<xsl:with-param name="label">XSL_REPORT_FILTERDETAILS_AMOUNT</xsl:with-param>
							<xsl:with-param name="override-amt-name">criterium_amount_value</xsl:with-param>
							<xsl:with-param name="product-code">criterium_amount</xsl:with-param>
							<xsl:with-param name="show-button">N</xsl:with-param>
							<xsl:with-param name="show-currency">N</xsl:with-param>
						</xsl:call-template>
					</div>
		
					<!-- Amount value -->
					<div id="account_no_section" style="display:none">
						<xsl:call-template name="select-field">
				   		<xsl:with-param name="label">XSL_REPORT_FILTERDETAILS_ACCOUNT_NO</xsl:with-param>
						<xsl:with-param name="name">criterium_account_no</xsl:with-param>
	     				<xsl:with-param name="size">20</xsl:with-param>
				      	<xsl:with-param name="options">
				    		<xsl:for-each select="account_no">
				     			<option>
					     			<xsl:value-of select="account_no"></xsl:value-of>
				    			</option>
				    		 </xsl:for-each>
				      	</xsl:with-param>
					 </xsl:call-template>
					</div>
					<!-- Date value -->
					<div id="criterium_date_section" style="display:none">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_REPORT_FILTERDETAILS_DATE</xsl:with-param>
							<xsl:with-param name="name">criterium_date_value</xsl:with-param>
							<xsl:with-param name="size">10</xsl:with-param>
							<xsl:with-param name="maxsize">10</xsl:with-param>
							<xsl:with-param name="fieldsize">small</xsl:with-param>
							<xsl:with-param name="type">date</xsl:with-param>
							<xsl:with-param name="swift-validate">N</xsl:with-param>
						</xsl:call-template>
					</div>
		
					<!-- Values set value -->
					<div id="criterium_values_set_section" style="display:none">
						<xsl:call-template name="select-field">
							<xsl:with-param name="label">XSL_REPORT_FILTERDETAILS_VALUE</xsl:with-param>
							<xsl:with-param name="name">criterium_values_set</xsl:with-param>
						</xsl:call-template>							
					</div>
		
					<!-- Pre-defined value section (valid for columns of type Date only) -->
					<div id="criterium_pre_defined_value_section" style="display:none">
					 <xsl:call-template name="multioption-group">
		     				  <xsl:with-param name="group-label">XSL_REPORT_FILTERDETAILS_PREDEFINED_VALUE_PLEASE_CHOOSE</xsl:with-param>
		     				  <xsl:with-param name="content">
		     				  <table>
 	 	 	 	              <tr>
		     				  <div id="criterium_parameter_default_date_1_row" class="field radio">
		     				  <td width="200px">
		     				   <label for="criterium_parameter_default_date_type_1">
		     				    <input dojoType="dijit.form.RadioButton" type="radio" name="criterium_parameter_default_date_type" id="criterium_parameter_default_date_type_1" value="01"/>
		     				    <xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CRITERIUM_PARAMETER_DATE_REPORT_EXECUTION_DATE')"/>
		     				   </label>
		     				    </td>
 	 	 	 	                <td>
		     				   <label for="criterium_parameter_default_date_report_exec_date_offset_1">
		     				     <input dojoType="dijit.form.RadioButton" disabled="true" type="radio" name="criterium_parameter_default_date_report_exec_date_offset" id="criterium_parameter_default_date_report_exec_date_offset_1" value="01"/>
		     				     +
		     				   </label>
		     				   </td>
		     				   <td>
		     				   <label for="criterium_parameter_default_date_report_exec_date_offset_2">
		     				     <input dojoType="dijit.form.RadioButton" disabled="true" type="radio" name="criterium_parameter_default_date_report_exec_date_offset" id="criterium_parameter_default_date_report_exec_date_offset_2" value="02"/>
		     				     -
		     				   </label>
		     				   </td>
		     				   <td>
		     				   <label for="criterium_parameter_default_date_report_exec_date_offset_days">
		     				     <div class="x-small" maxLength="3" disabled="true" id="criterium_parameter_default_date_report_exec_date_offset_days" name="criterium_parameter_default_date_report_exec_date_offset_days" dojoType="dijit.form.NumberTextBox" trim="true"/>
						 <xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CRITERIUM_PARAMETER_DEFAULT_VALUE_DAYS')"/>
		     				   </label>
		     				   </td>	
					  		</div>
					  		 </tr>
 	 	 	 	             <tr>
		     				  <div id="criterium_parameter_default_date_2_row" class="field radio">
		     				  <td width="200px">
		     				   <label for="criterium_parameter_default_date_type_2">
		     				    <input dojoType="dijit.form.RadioButton" type="radio" name="criterium_parameter_default_date_type" id="criterium_parameter_default_date_type_2" value="02"/>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CRITERIUM_PARAMETER_DATE_FIRST_DAY_OF_CURRENT_MONTH')"/>
		     				   </label>
		     				    </td>
 	 	 	 	                <td>
		     				   <label for="criterium_parameter_default_date_first_day_of_month_offset_1">
		     				    <input dojoType="dijit.form.RadioButton" disabled="true" type="radio" name="criterium_parameter_default_date_first_day_of_month_offset" id="criterium_parameter_default_date_first_day_of_month_offset_1" value="01"/>
		     				    +
		     				   </label>
		     				   </td>
 	 	 	 	               <td>
		     				   <label for="criterium_parameter_default_date_first_day_of_month_offset_2">
		     				    <input dojoType="dijit.form.RadioButton" disabled="true" type="radio" name="criterium_parameter_default_date_first_day_of_month_offset" id="criterium_parameter_default_date_first_day_of_month_offset_2" value="02"/>
		     				    -
		     				   </label>
		     				    </td>
 	 	 	 	                <td>
		     				   <label for="criterium_parameter_default_date_first_day_of_month_offset_days">
		     				    <div class="x-small" maxLength="3" disabled="true" id="criterium_parameter_default_date_first_day_of_month_offset_days" name="criterium_parameter_default_date_first_day_of_month_offset_days" dojoType="dijit.form.NumberTextBox" trim="true" value=""/>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CRITERIUM_PARAMETER_DEFAULT_VALUE_DAYS')"/>
		     				   </label>	
		     				   </td>   
					  </div>
					   </tr>
 	 	 	 	       <tr>
					  <div id="criterium_parameter_default_date_3_row" class="field radio">
					  <td width="200px">
					   <label for="criterium_parameter_default_date_type_3">
					    <input dojoType="dijit.form.RadioButton" type="radio" name="criterium_parameter_default_date_type" id="criterium_parameter_default_date_type_3" value="03"/>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CRITERIUM_PARAMETER_DATE_LAST_DAY_OF_CURRENT_MONTH')"/>
					   </label>
					    </td>
 	 	 	 	        <td>
					   <label for="criterium_parameter_default_date_last_day_of_month_offset_1">
					    <input dojoType="dijit.form.RadioButton" disabled="true" type="radio" name="criterium_parameter_default_date_last_day_of_month_offset" id="criterium_parameter_default_date_last_day_of_month_offset_1" value="01"/>
					    +
					   </label>
					    </td>
 	 	 	 	        <td>
					   <label for="criterium_parameter_default_date_last_day_of_month_offset_2">
					    <input dojoType="dijit.form.RadioButton" disabled="true" type="radio" name="criterium_parameter_default_date_last_day_of_month_offset" id="criterium_parameter_default_date_last_day_of_month_offset_2" value="02"/>
					    -
					   </label>
					   </td>
 	 	 	 	       <td>
					   <label for="criterium_parameter_default_date_last_day_of_month_offset_days">
					    <div class="x-small" maxLength="3" disabled="true" id="criterium_parameter_default_date_last_day_of_month_offset_days" name="criterium_parameter_default_date_last_day_of_month_offset_days" dojoType="dijit.form.NumberTextBox" trim="true" value=""/>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CRITERIUM_PARAMETER_DEFAULT_VALUE_DAYS')"/>
					   </label>
					   </td>
					  </div>
					   </tr>
 	 	 	 	       <tr>
					  <div id="criterium_parameter_default_date_4_row" class="field radio">
					  <td>
					   <label for="criterium_parameter_default_date_type">
					    <input dojoType="dijit.form.RadioButton" type="radio" name="criterium_parameter_default_date_type" id="criterium_parameter_default_date_type_4" value="04"/>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CRITERIUM_PARAMETER_DATE_TODAY')"/>
					   </label>
					   </td>
					  </div>
					  </tr>
 	 	 	 	      <tr>
					  <div id="criterium_parameter_default_date_5_row" class="field radio">
					  <td>
					   <label for="criterium_parameter_default_date_type">
					    <input dojoType="dijit.form.RadioButton" type="radio" name="criterium_parameter_default_date_type" id="criterium_parameter_default_date_type_5" value="05"/>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CRITERIUM_PARAMETER_DATE_TOMORROW')"/>
					   </label>
					   </td>
					  </div>
					  </tr>
 	 	 	 	      <tr>
					  <div id="criterium_parameter_default_date_6_row" class="field radio">
					  <td>
					   <label for="criterium_parameter_default_date_type">
						 <input dojoType="dijit.form.RadioButton" type="radio" name="criterium_parameter_default_date_type" id="criterium_parameter_default_date_type_6" value="06"/>
						 <xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CRITERIUM_PARAMETER_DATE_YESTERDAY')"/>
					   </label>
					   </td>
					  </div>
					  </tr>
 	 	 	 	    </table>
		     				  </xsl:with-param>
		     				 </xsl:call-template>
					</div>
					<p><br/></p>	<!-- TODO: remove this. Should be CSS -->
					<div class="dijitDialogPaneActionBar">
						<xsl:call-template name="label-wrapper">
							<xsl:with-param name="content">
								<button dojoType="dijit.form.Button" type="button" onClick="misys.submitCriteriumDialog()">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')"/>
								</button>
								<button dojoType="dijit.form.Button" type="button">
									<xsl:attribute name="onClick">dijit.byId('criterium-dialog-template').hide();</xsl:attribute>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')"/>
								</button>
							</xsl:with-param>
						</xsl:call-template>
					</div>
		</div>
		<!-- Dialog End -->
		<div id="criteria-template" style="display:none">
			<div class="clear">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_NO_CRITERIUM')"/>
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode"/>
				</div>
				<p><br/></p>
				<button dojoType="dijit.form.Button" type="button" dojoAttachEvent="onClick: addItem">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_ADD_CRITERIUM')"/>
				</button>
			</div>
		</div>
		
		<!-- ********** -->
		<!-- Aggregates -->
		<!-- ********** -->
		<!-- Dialog Start -->
		<div id="aggregate-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
				<!-- Column -->
				<xsl:call-template name="select-field">
					<xsl:with-param name="label">XSL_REPORT_GROUPINGDETAILS_COLUMN</xsl:with-param>
					<xsl:with-param name="name">aggregate_column</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
					<xsl:with-param name="options">
						<option value=""/>
					</xsl:with-param>
				</xsl:call-template>
				<!-- Type -->
				<xsl:call-template name="select-field">
					<xsl:with-param name="label">XSL_REPORT_GROUPINGDETAILS_AGGREGATE</xsl:with-param>
					<xsl:with-param name="name">aggregate_type</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
					<xsl:with-param name="options">
						<option value=""/>
					</xsl:with-param>
				</xsl:call-template>
				<!-- Equivalent currency -->
				<div id="aggregate_eqv_currency_section" style="display:none">
				   <xsl:call-template name="row-wrapper">
						<xsl:with-param name="label">XSL_REPORT_AGGREGATE_EQV_CURRENCY</xsl:with-param>
						<xsl:with-param name="id">aggregate_eqv_cur_code</xsl:with-param>
						<xsl:with-param name="content">
							<div trim="true" uppercase="true" dojoType="dijit.form.ValidationTextBox" class="x-small">
								<xsl:attribute name="name">aggregate_eqv_cur_code</xsl:attribute>
								<xsl:attribute name="id">aggregate_eqv_cur_code</xsl:attribute>
								<xsl:attribute name="maxLength">3</xsl:attribute>       
							</div>
							<xsl:call-template name="get-button">
								<xsl:with-param name="button-type">currency</xsl:with-param>
								<xsl:with-param name="id">aggregate_currency</xsl:with-param>
								<xsl:with-param name="override-product-code">aggregate_eqv</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</div>
		
				<xsl:call-template name="multioption-group">
					<xsl:with-param name="group-label"/>
					<xsl:with-param name="content">
						<!-- Auto-determine currency -->
						<div id="auto_determine_currency_section" style="display:none">
							<xsl:call-template name="checkbox-field">
								<xsl:with-param name="label">XSL_REPORT_AGGREGATE_USE_PRODUCT_CURRENCY</xsl:with-param>
								<xsl:with-param name="name">aggregate_use_product_currency</xsl:with-param>
							</xsl:call-template>
						</div>
					</xsl:with-param>
				</xsl:call-template>
		
				<!-- Label in the default language -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label" select="concat('XSL_REPORT_AGGREGATEDETAILS_LABEL_', $language)"/>
					<xsl:with-param name="required">Y</xsl:with-param>
					<xsl:with-param name="name" select="concat('aggregate_label_', $language)"/>
					<xsl:with-param name="swift-validate">N</xsl:with-param>
				    <xsl:with-param name="button-type">report-aggregate</xsl:with-param>					
				</xsl:call-template>
				
				<!-- Labels in other languages -->
				<div id="aggregate_labels_other_languages" style="display: none">
					<xsl:for-each select="$languages/languages/language">
						<xsl:variable name="selectedLanguage" select="."/>
						<xsl:if test="$selectedLanguage != $language">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label" select="concat('XSL_REPORT_AGGREGATEDETAILS_LABEL_', $selectedLanguage)"/>
								<xsl:with-param name="name" select="concat('aggregate_label_', $selectedLanguage)"/>
							</xsl:call-template>
						</xsl:if>
					</xsl:for-each>
				</div>
				<div class="dijitDialogPaneActionBar">
					<xsl:call-template name="label-wrapper">
						<xsl:with-param name="content">
							<button dojoType="dijit.form.Button" type="button" onClick="misys.submitDialog('aggregate-dialog-template')">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')"/>
							</button>
							<button dojoType="dijit.form.Button" type="button">
								<xsl:attribute name="onClick">dijit.byId('aggregate-dialog-template').hide();</xsl:attribute>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')"/>
							</button>
						</xsl:with-param>
					</xsl:call-template>
				</div>
		</div>
		<!-- Dialog End -->
		<div id="aggregates-template" style="display:none">
			<div class="clear">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_NO_AGGREGATE')"/>
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode"/>
				</div>
				<p><br/></p>
				<button dojoType="dijit.form.Button" type="button" dojoAttachEvent="onClick: addItem" dojoAttachPoint="addButtonNode">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_ADD_AGGREGATE')"/>
				</button>
			</div>
		</div>
		
		<div id="filter-template" style="display:none">
			<div>
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_REPORT_FILTER</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="button-type">remove-item</xsl:with-param>
					<xsl:with-param name="content">
						&nbsp;
						<div dojoAttachPoint="criteriaNode"/>
					</xsl:with-param>
				</xsl:call-template>
			</div>
		</div>
		
		<div id="filters-template" style="display:none">
			<div>
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_NO_FILTER')"/>
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode"/>
				</div>
				<p><br/></p>
				<button dojoType="dijit.form.Button" type="button" dojoAttachEvent="onClick: addItem">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_ADD_FILTER')"/>
				</button>
			</div>
		</div>

		<!-- ********* -->
		<!-- Entity -->
		<!-- ********* -->
		<!-- Dialog Start -->
		<div id="entity-dialog-template" style="display:none" class="widgetContainer">
				<xsl:attribute name="title">Confirmation</xsl:attribute>
				<!-- Customer entity -->
				 <xsl:call-template name="entity-field">
				 	<xsl:with-param name="name">report_entity</xsl:with-param>
		       		<xsl:with-param name="button-type">entity</xsl:with-param>
		       		<xsl:with-param name="entity-label">XSL_JURISDICTION_ENTITY</xsl:with-param>
		      		<xsl:with-param name="required">Y</xsl:with-param>
		      </xsl:call-template>
				<div class="dijitDialogPaneActionBar">
					<xsl:call-template name="label-wrapper">
						<xsl:with-param name="content">
							<button dojoType="dijit.form.Button" type="button" id="entityOkButton" onClick="misys.submitDialog('entity-dialog-template')">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')"/>
							</button>
							<button dojoType="dijit.form.Button" type="button" id="entityCancelButton">
								<xsl:attribute name="onmouseup">dijit.byId('entity-dialog-template').hide();</xsl:attribute>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')"/>
							</button>
						</xsl:with-param>
					</xsl:call-template>
				</div>
		</div>
		<!-- Dialog End -->
		<div id="entities-template" style="display:none">
			<div class="clear">
				<p dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_GUARANTEE_NO_ENTITY_SETUP')"/>
				</p>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode"/>
				</div>
				<div dojoType="dijit.form.Button" type="button" id="addEntityButton" dojoAttachEvent="onClick: addItem" dojoAttachPoint="addButtonNode">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_GUARANTEE_ADD_ENTITY')"/>
				</div>
			</div>
		</div>
		<div>
         <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>


		<xsl:call-template name="form-wrapper">
			<xsl:with-param name="name" select="$main-form-name"/>
			<xsl:with-param name="validating">Y</xsl:with-param>
			<xsl:with-param name="content">

				<!--  Display common menu.  -->
				<xsl:call-template name="system-menu">
				 <xsl:with-param name="submit-type">
				  <xsl:choose>
				   <xsl:when test="$isTemplate = 'true'">SAVE_REPORT_TEMPLATE</xsl:when>
				   <xsl:when test="$isBankTemplate = 'true'">SAVE_REPORT_TEMPLATE</xsl:when>
				   <xsl:otherwise>SYSTEM_SUBMIT</xsl:otherwise>
				  </xsl:choose>
				 </xsl:with-param>
				</xsl:call-template>
   		      
				<xsl:call-template name="general-details"/>
				<xsl:call-template name="entities"/>
				
				<xsl:call-template name="products"/>
				
				<xsl:call-template name="inputsources"/>	
				
				<xsl:call-template name="columns"/>
				
				
				
				<xsl:call-template name="parameters"/>
				
				<xsl:call-template name="filters"/>
				
				<xsl:call-template name="overall-aggregates"/>
				
				<xsl:call-template name="grouping"/>
				
				<xsl:call-template name="chart"/>

				<xsl:call-template name="system-menu">
					<xsl:with-param name="second-menu">Y</xsl:with-param>
					<xsl:with-param name="submit-type">
				  <xsl:choose>
				    <xsl:when test="$isTemplate = 'true'">SAVE_REPORT_TEMPLATE</xsl:when>
				   <xsl:when test="$isBankTemplate = 'true'">SAVE_REPORT_TEMPLATE</xsl:when>
				   <xsl:otherwise>SYSTEM_SUBMIT</xsl:otherwise>
				  </xsl:choose>
				 </xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		
	    <!-- The form that's submitted -->
	    <xsl:call-template name="realform"/>


		<!-- 
		<table border="0" width="100%" style="display:none">
			<tr>
				<td align="center">
					<table border="0">
						<tr>
							<td align="left">
								<p>
									<br/>
								</p>
								
								<form name="fakeform0" onsubmit="return false;">
									<table border="0" width="570" cellpadding="0" cellspacing="0">
										<tr>
											<td class="FORMH1" colspan="3">
												<b>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_GENERAL_DETAILS')"/>
												</b>
											</td>
										</tr>
									</table>
									<br/>
									<table border="0" width="570" cellpadding="0" cellspacing="0">
										<tr>
											<td width="40">&nbsp;</td>
											<td width="150">
												<font class="FORMMANDATORY">
													<xsl:choose>
														<xsl:when test="($isTemplate = 'true') or ($isBankTemplate = 'true')">
															<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_TEMPLATE_NAME')"/>
														</xsl:when>
														<xsl:otherwise>
															<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_NAME')"/>
														</xsl:otherwise>
													</xsl:choose>
												</font>
											</td>
											<td>
												<input type="text" size="35" maxlength="35" name="report_name" onblur="fncRestoreInputStyle('fakeform0','report_name');">
													<xsl:attribute name="value"><xsl:value-of select="name"/></xsl:attribute>
												</input>
												<input type="hidden" name="report_id">
													<xsl:attribute name="value"><xsl:value-of select="report_id"/></xsl:attribute>
												</input>
											</td>
										</tr>
										<tr>
											<td width="40">&nbsp;</td>
											<td colspan="2">

											</td>
										</tr>
										<tr><td colspan="3">&nbsp;</td></tr>
										<tr><td colspan="3">&nbsp;</td></tr>
										<tr>
											<td width="40">&nbsp;</td>
											<td colspan="2">
												<input type="checkbox" name="executable_enable">
													<xsl:if test="executable_flag[.='Y']">
														<xsl:attribute name="checked"/>
													</xsl:if>
												</input>
												<xsl:choose>
													<xsl:when test="($isTemplate = 'true') or ($isBankTemplate = 'true')">
														<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_TEMPLATE_EXECUTABLE_FLAG')"/>
													</xsl:when>
													<xsl:otherwise>
														<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EXECUTABLE_FLAG')"/>
													</xsl:otherwise>
												</xsl:choose>
											</td>
										</tr>
										<xsl:if test="($isTemplate != 'true') and ($isBankTemplate != 'true') and ($all_banks_flag = 'Y')">
											<tr>
												<td width="40">&nbsp;</td>
												<td colspan="2">
													<input type="checkbox" name="all_banks">
														<xsl:if test="all_banks_flag = 'Y'">
															<xsl:attribute name="checked"/>
														</xsl:if>
													</input>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BANKGROUP_DISPLAY_ALL_BANKS')"/>
												</td>
											</tr>
										</xsl:if>
										</table>
										
										<table>
										<tr><td colspan="3">&nbsp;</td></tr>
										<tr>
											<td width="40">&nbsp;</td>
											<td width="150">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_MAX_NB_LINES')"/>
											</td>
											<td>
												<table border="0" width="100%" cellpadding="0" cellspacing="0">
													<tr>
														<td>
															<input type="text" size="3" maxlength="3" name="max_nb_lines" onblur="fncRestoreInputStyle('fakeform0','max_nb_lines'); fncCheckMaximumNbOfLines(this);">
																<xsl:attribute name="value">
																	<xsl:choose>
																		<xsl:when test="not(@page) or @page[.='']">25</xsl:when>
																		<xsl:otherwise><xsl:value-of select="@page"/></xsl:otherwise>
																	</xsl:choose>
																</xsl:attribute>
															</input>
														</td>
														<td align="right">
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
									<p>
										<br/>
									</p>
									
									<xsl:apply-templates select="definition"/>
									
								</form>
								
								<form name="realform" method="POST">
										<xsl:if test="security:isBank($rundata)">
											<xsl:attribute name="action">/gtp/screen/BankSystemFeaturesScreen</xsl:attribute>
										</xsl:if>
										<xsl:if test="security:isCustomer($rundata)">
											<xsl:attribute name="action">/gtp/screen/CustomerSystemFeaturesScreen</xsl:attribute>
										</xsl:if>
										<xsl:if test="$isBankTemplate ='true'">
											<input type="hidden" name="option" value="BANK_TEMPLATE"/>
										</xsl:if>
										<input type="hidden" name="operation" value="REPORT_SAVE"/>
										<input type="hidden" name="TransactionData"/>
								</form>
									
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>-->
		
    </div>		
	</xsl:template>
	
	<!--
	Report Realform.
	-->
	<xsl:template name="realform">
		<xsl:call-template name="form-wrapper">
			<xsl:with-param name="name">realform</xsl:with-param>
			<xsl:with-param name="action" select="$realform-action"/>
			<xsl:with-param name="content">
				<div class="widgetContainer">
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">operation</xsl:with-param>
					<xsl:with-param name="id">realform_operation</xsl:with-param>
					<xsl:with-param name="value">
						<xsl:value-of select="$operation"/>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="$isBankTemplate = 'true'">
				 <xsl:call-template name="hidden-field">
					<xsl:with-param name="name">option</xsl:with-param>
					<xsl:with-param name="value">BANK_TEMPLATE</xsl:with-param>
				 </xsl:call-template>
				</xsl:if>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">TransactionData</xsl:with-param>
					<xsl:with-param name="value"/>
				</xsl:call-template>
				<xsl:call-template name="e2ee_transaction"/>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">swiftregexValue</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('SWIFT_VALIDATION_REGEX')"/></xsl:with-param>
				</xsl:call-template>
				</div>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!--
	General Details Fieldset. 
	-->
	<xsl:template name="general-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="report-general-details"/>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="report-general-details">
		<div>
		
		<xsl:variable name="actualReportId">
			<xsl:choose>
				<xsl:when test="string-length(report_id) = 0"><xsl:value-of select="$reportId"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="report_id"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		
		<!-- Report Id (hidden field) -->
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">report_id</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="$actualReportId"/></xsl:with-param>
		</xsl:call-template>
		
		<!-- Security token (hidden field) -->
		<xsl:call-template name="hidden-field">
	       	<xsl:with-param name="name">token</xsl:with-param>
	       	<xsl:with-param name="value"><xsl:value-of select="$token"/></xsl:with-param>
	    </xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">duplicateColumnsAllowed</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('REPORT_DUPLICATE_COLUMNS_ALLOWED')"/></xsl:with-param>
			</xsl:call-template>
		<!-- Equivalent currency (hidden field) -->
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">equivalent_currency</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="equivalentCurrency"/></xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="localization-dialog"/>
		
		<xsl:call-template name="hidden-field">
       		<xsl:with-param name="name">isSwift2019Enabled</xsl:with-param>
	      	<xsl:with-param name="value"><xsl:value-of select="defaultresource:isSwift2019Enabled()"/></xsl:with-param>
      	</xsl:call-template>
		
		<!-- Languages (hidden fields) -->
		<xsl:for-each select="$languages/languages/language">
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">language_<xsl:value-of select="."/></xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="."/></xsl:with-param>
			</xsl:call-template>
		</xsl:for-each>
		
		<!-- Report Name / Report Template Name-->
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">
				<xsl:choose>
					<xsl:when test="($isTemplate = 'true') or ($isBankTemplate = 'true')">XSL_REPORT_TEMPLATE_NAME</xsl:when>
					<xsl:otherwise>XSL_REPORT_NAME</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
			<xsl:with-param name="name">report_name</xsl:with-param>
			<xsl:with-param name="required">Y</xsl:with-param>
			<xsl:with-param name="maxsize">35</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="name"/></xsl:with-param>
			<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('REPORT_DESIGNER_REPORT_NAME_REGEX')"/></xsl:with-param>
		</xsl:call-template>
		
		<!-- Report Description / Report Template Description-->
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">
				<xsl:choose>
					<xsl:when test="($isTemplate = 'true') or ($isBankTemplate = 'true')">XSL_REPORT_TEMPLATE_DESCRIPTION</xsl:when>
					<xsl:otherwise>XSL_REPORT_DESCRIPTION</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
			<xsl:with-param name="name">report_desc</xsl:with-param>
			<xsl:with-param name="required">Y</xsl:with-param>
			<xsl:with-param name="size">45</xsl:with-param>
			<xsl:with-param name="maxsize">255</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="description"/></xsl:with-param>
			<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('REPORT_DESIGNER_REPORT_DESCRIPTION_REGEX')"/></xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="multioption-group">
			<xsl:with-param name="group-label"/>
			<xsl:with-param name="content">
	
				<!-- Executable Report -->
				<xsl:call-template name="checkbox-field">
					<xsl:with-param name="label">
						<xsl:choose>
							<xsl:when test="($isTemplate = 'true') or ($isBankTemplate = 'true')">XSL_REPORT_TEMPLATE_EXECUTABLE_FLAG</xsl:when>
							<xsl:otherwise>XSL_REPORT_EXECUTABLE_FLAG</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
					<xsl:with-param name="name">executable_flag</xsl:with-param>
				</xsl:call-template>

				<!-- Report executable by all banks (for bankgroup users only) -->
				<xsl:if test="($isTemplate != 'true') and ($isBankTemplate != 'true') and ($all_banks_flag = 'Y')">
					<xsl:call-template name="checkbox-field">
						<xsl:with-param name="label">XSL_REPORT_BANKGROUP_DISPLAY_ALL_BANKS</xsl:with-param>
						<xsl:with-param name="name">all_banks_flag</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
		
			</xsl:with-param>
		</xsl:call-template>
		
		<!-- Number of Lines Per Page -->
		<div id="max-nb-lines-section">
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_REPORT_MAX_NB_LINES</xsl:with-param>
			<xsl:with-param name="name">max_nb_lines</xsl:with-param>
			<xsl:with-param name="required">N</xsl:with-param>
			<xsl:with-param name="size">2</xsl:with-param>
			<xsl:with-param name="maxsize">3</xsl:with-param>
			<!-- <xsl:with-param name="required">Y</xsl:with-param> -->
			<xsl:with-param name="fieldsize">small</xsl:with-param>
			<xsl:with-param name="value">
				<xsl:choose>
					<xsl:when test="not(definition/listdef/@page) or definition/listdef/@page[.='']">25</xsl:when>
					<xsl:otherwise><xsl:value-of select="definition/listdef/@page"/></xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
			<xsl:with-param name="type">integer</xsl:with-param>
			<xsl:with-param name="override-constraints">{min:1,pattern: '###'}</xsl:with-param>
		</xsl:call-template>
		</div>
		
			<div id="choose-product">
		<xsl:if test="(securityCheck:hasPermission($rundata,'system_feature_report_bank_access')  and (security:isCustomer($rundata) != 'true')) or (securityCheck:hasPermission($rundata,'system_feature_report_cust_access') and security:isCustomer($rundata)) ">
				<xsl:call-template name="multioption-group">
					<xsl:with-param name="content">
					     <xsl:call-template name="radio-field">
					      <xsl:with-param name="label">XSL_REPORT_OPTION_PRODUCT</xsl:with-param>
					      <xsl:with-param name="name">product_type</xsl:with-param>
					      <xsl:with-param name="id">product_type</xsl:with-param>
					      <xsl:with-param name="value">01</xsl:with-param>
					     </xsl:call-template>
					     <xsl:call-template name="radio-field">
					      <xsl:with-param name="label">XSL_REPORT_OPTION_SYSTEM</xsl:with-param>
					      <xsl:with-param name="name">product_type</xsl:with-param>
					      <xsl:with-param name="id">system_type</xsl:with-param>
					      <xsl:with-param name="value">02</xsl:with-param>
					     </xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				  <xsl:call-template name="hidden-field">
       						<xsl:with-param name="name">report_type</xsl:with-param>
       						<xsl:with-param name="value"><xsl:value-of select="report_type"/></xsl:with-param>
      				</xsl:call-template>
					
			  </div>
			  
			  
		</div>
	</xsl:template>
  
  <!-- ************************************************************************** -->
	<!--                          CUSTOMERS - START                                 -->
	<!-- ************************************************************************** -->
	<xsl:template name="build-entities-dojo-items">
		<xsl:param name="items"/>
		
		<div dojoType="misys.report.widget.Entities" dialogId="entity-dialog-template" gridId="entities-grid" id="entities">
			<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'ENTITY')"/>
			</xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_GUARANTEE_ADD_ENTITY')"/></xsl:attribute>
			<xsl:for-each select="$items">
				<xsl:variable name="entity" select="."/>
				<xsl:variable name="position" select="position()" />
				<div dojoType="misys.report.widget.Entity">
					<xsl:attribute name="Id">entity_<xsl:value-of select="$position"/></xsl:attribute>
					<xsl:attribute name="abbv_name"><xsl:value-of select="$entity/abbv_name"/></xsl:attribute>
				</div>
			</xsl:for-each>
		</div>
		
	</xsl:template>
	<!--
	Products Fieldset. 
	-->
	<xsl:template name="products">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_REPORT_PRODUCTS</xsl:with-param>
			<xsl:with-param name="content">

				<xsl:call-template name="multioption-group">
					<xsl:with-param name="group-label"/>
					<xsl:with-param name="content">
						<!-- Multi-product -->
						<xsl:call-template name="checkbox-field">
							<xsl:with-param name="label">XSL_REPORT_MULTI_PRODUCT</xsl:with-param>
							<xsl:with-param name="name">multi_product</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="definition/listdef/multiProduct"/></xsl:with-param>
							<!-- <xsl:with-param name="checked"><xsl:value-of select="listdef/multiProduct"/></xsl:with-param>-->
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>					
				<!-- Multi-Product items -->
				<div id="multi_product_section" style="display:none">
					<xsl:variable name="productItems">
							<xsl:for-each select="definition/listdef/candidate"><xsl:value-of select="@name"/>,</xsl:for-each>
					</xsl:variable>
					<xsl:call-template name="build-products-dojo-items">
						<xsl:with-param name="items" select="$productItems"/>
					</xsl:call-template>
				</div>
				<!-- Single Product -->
				<div id="single_product_section" style="display:none">
					<xsl:call-template name="select-field">
						<xsl:with-param name="label">XSL_REPORT_PRODUCT</xsl:with-param>
						<xsl:with-param name="name">single_product</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
						<xsl:with-param name="options">
							<xsl:call-template name="single-product-codes"/>
						</xsl:with-param>
						<xsl:with-param name="value">
							<xsl:if test="definition/listdef/multiProduct != 'Y'">
								<xsl:variable name="singleProductCode">
									<xsl:value-of select="substring-before(definition/listdef/candidate/@name, ',')"/>
								</xsl:variable>
								<xsl:choose>
									<xsl:when test="$singleProductCode != ''">
										<xsl:value-of select="$singleProductCode"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="definition/listdef/candidate/@name"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:if>
						</xsl:with-param>
					</xsl:call-template>							
				</div>
				
				
				<div id="system_feture_section" style="display:none">
				
					<xsl:call-template name="select-field">
						<xsl:with-param name="label">XSL_REPORT_SYFEATURE</xsl:with-param>
						<xsl:with-param name="name">system_product</xsl:with-param>
						<xsl:with-param name="required">Y</xsl:with-param>
						<xsl:with-param name="options">
							<xsl:call-template name="system-feture-codes"/>
						</xsl:with-param>
						<xsl:with-param name="value">
							<xsl:if test="definition/listdef/multiProduct != 'Y'">
								<xsl:variable name="systemProductCode">
									<xsl:value-of select="substring-before(definition/listdef/product_code, ',')"/>
								</xsl:variable>
								<xsl:choose>
									<xsl:when test="$systemProductCode != ''">
										<xsl:value-of select="$systemProductCode"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="definition/listdef/product_code"/>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:if>
						</xsl:with-param>
					</xsl:call-template>
											
				</div>
			
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!--
	Columns Fieldset. 
	-->
	<xsl:template name="columns">
		<div id="columns-section" style="display:none">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_REPORT_DISPLAYED_COLUMNS</xsl:with-param>
			<xsl:with-param name="content">
				<!-- Executable Report -->
				<xsl:call-template name="checkbox-field">
					<xsl:with-param name="label">XSL_REPORT_USE_ABSOLUTE_COLUMN_WIDTH</xsl:with-param>
					<xsl:with-param name="name">use_absolute_width</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="definition/listdef/use_absolute_width"/></xsl:with-param>
				</xsl:call-template>
				<!-- Products grid -->
				<xsl:call-template name="build-columns-dojo-items">
					<xsl:with-param name="items" select="definition/listdef/column[not(@hidden)]"/>
				</xsl:call-template>
				<!-- Order list -->
				<xsl:call-template name="checkbox-field">
					<xsl:with-param name="label">XSL_REPORT_ORDER_LIST_BY_DEFAULT</xsl:with-param>
					<xsl:with-param name="name">order_list_by_default</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="definition/listdef/order_list_by_default"/></xsl:with-param>
				</xsl:call-template>
				<!-- Order list section -->
				<div id="order_details_section" style="display:none">
					<!-- Order column -->
					<xsl:call-template name="select-field">
						<xsl:with-param name="label">XSL_REPORT_ORDER_COLUMN</xsl:with-param>
						<xsl:with-param name="name">order_column</xsl:with-param>
						<xsl:with-param name="options">
							<option value=""/>
						</xsl:with-param>
					</xsl:call-template>
					<!-- Select values are not created until the page is loaded, so we set value in an onLoad -->
					<script>
					 dojo.subscribe('formOnLoadEventsPerformed', function(){
					  if(dijit.byId('order_list_by_default').get('checked')) {
					   dijit.byId('order_column').set('value', '<xsl:value-of select="definition/listdef/@default_order"/>');
					  }
					 });
					</script>
					<!-- Order type -->
					<xsl:call-template name="select-field">
						<xsl:with-param name="label">XSL_REPORT_ORDER_TYPE</xsl:with-param>
						<xsl:with-param name="name">order_type</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="definition/listdef/@default_order_type"/></xsl:with-param>
						<xsl:with-param name="options">
							<option value="a">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_ORDER_ASCENDING')"/>
							</option>
							<option value="d">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_ORDER_DESCENDING')"/>
							</option>
						</xsl:with-param>
					</xsl:call-template>
				</div>
			</xsl:with-param>
		</xsl:call-template>
		</div>
	</xsl:template>
	
	<xsl:template name="inputsources">
		<div id="input-source-section" style="display:none">
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_REPORT_INPUT_SOURCES</xsl:with-param>
					<xsl:with-param name="content">
						<div id="input_source_section">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_REPORT_INPUT_SOURCE_TYPE</xsl:with-param>
								<xsl:with-param name="name">input_source_type</xsl:with-param>
							</xsl:call-template>
						</div>
					</xsl:with-param>
				</xsl:call-template>
		</div>
	</xsl:template>
	
	<!--
	Columns Fieldset. 
	-->
	<xsl:template name="entities">
		<div id="entities-section">
		<xsl:if test="security:isCustomer($rundata)">
			<xsl:if test="utils:getUserEntitiesSize($rundata)">
				<xsl:if test="securityCheck:hasPermission($rundata,'report_entity_modify')">
					<xsl:call-template name="fieldset-wrapper">
						<xsl:with-param name="legend">XSL_REPORT_DISPLAYED_ENTITY</xsl:with-param>
						<xsl:with-param name="content">
							<!-- Executable Report -->
							<!-- <xsl:call-template name="checkbox-field">
								<xsl:with-param name="label">XSL_REPORT_USE_ABSOLUTE_COLUMN_WIDTH</xsl:with-param>
								<xsl:with-param name="name">use_absolute_width_1</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select="definition/listdef/use_absolute_width"/></xsl:with-param>
							</xsl:call-template> -->
							<div style="display:none;">entitie</div>
							<xsl:call-template name="build-entities-dojo-items">
								<xsl:with-param name="items" select="entities/entity"/>
							</xsl:call-template> 
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:if>
		</xsl:if>
				
		</div>
	 </xsl:template>
		


	<!--
	Parameters Fieldset. 
	-->
	<xsl:template name="parameters">
		<div id="parameters-section" style="display:none">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_REPORT_PARAMETERS</xsl:with-param>
			<xsl:with-param name="content">
				&nbsp;
				<xsl:call-template name="build-parameters-dojo-items">
					<xsl:with-param name="items" select="definition/listdef/parameter[@name != 'export_list' and not(@autogenerated)]"/>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		</div>
	</xsl:template>

	
	<!--
	Filters Fieldset. 
	-->
	<xsl:template name="filters">
		<div id="filters-section" style="display:none">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_REPORT_FILTERS</xsl:with-param>
			<xsl:with-param name="content">
				&nbsp;
				<xsl:call-template name="report-filters"/>
			</xsl:with-param>
		</xsl:call-template>
		</div>
	</xsl:template>

	<xsl:template name="report-filters">
		<div dojotype="misys.report.widget.Filters" id="filters">
			<xsl:apply-templates select="definition/listdef/candidate[1]/filter"/>
		</div>
		
	</xsl:template>

	<xsl:template match="filter">
		<div dojotype="misys.report.widget.Filter">
			<div dojotype="misys.report.widget.Criteria" dialogId="criterium-dialog-template">
				<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_ADD_CRITERIUM')"/></xsl:attribute>
				<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UPDATE_CRITERIUM')"/></xsl:attribute>
				<xsl:apply-templates select="./criteria"/>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template match="criteria">
		<xsl:variable name="parameterValue"><xsl:value-of select="value"/></xsl:variable>
		<div dojotype="misys.report.widget.Criterium">
			<xsl:attribute name="column"><xsl:value-of select="column/@name"/></xsl:attribute>
			<xsl:attribute name="column_type"><xsl:value-of select="column/@type"/></xsl:attribute>
			<xsl:attribute name="operator"><xsl:value-of select="operator/@type"/></xsl:attribute>
			<xsl:attribute name="value_type"><xsl:value-of select="value/@type"/></xsl:attribute>
			<xsl:attribute name="parameter">
				<xsl:if test="value/@type = 'parameter' and count(//report/definition/listdef/parameter[@name = $parameterValue and @autogenerated='y']) = 0">
					<xsl:value-of select="value"/>
				</xsl:if>
			</xsl:attribute>
			<xsl:attribute name="string_value">
				<xsl:if test="value/@type = 'string'">
					<xsl:value-of select="value"/>
				</xsl:if>
			</xsl:attribute>
			<xsl:attribute name="number_value"/>
			<xsl:variable name="amValue" select="substring-before(value,'@')"/>
     		<xsl:attribute name="amount_value">
			<xsl:if test="column/@type = 'Amount'">
		    	<xsl:value-of select="utils:bigDecimalToAmountString($amValue,'',$language)"/>
			</xsl:if>
			</xsl:attribute>
			<xsl:attribute name="date_value"/>
			<xsl:attribute name="values_set"/>
			
			<!-- Pre-defined values for dates only -->
			<xsl:if test="value/@type = 'parameter' and count(//report/definition/listdef/parameter[@name = $parameterValue and @autogenerated='y']) = 1">
				<xsl:variable name="autogeneratedParameter" select="//report/definition/listdef/parameter[@name = $parameterValue and @autogenerated='y']"/>

				<xsl:choose>
					<xsl:when test="count($autogeneratedParameter/default/execution_date) = 1">
						<xsl:attribute name="default_date_type">01</xsl:attribute>
						<xsl:if test="$autogeneratedParameter/default/execution_date/@day_offset[. != '']">
							<xsl:choose>
								<xsl:when test="starts-with($autogeneratedParameter/default/execution_date/@day_offset, '-')">
									<xsl:attribute name="default_date_report_exec_date_offset">02</xsl:attribute>
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute name="default_date_report_exec_date_offset">01</xsl:attribute>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:attribute name="default_date_report_exec_date_offset_days">
								<xsl:value-of select="translate($autogeneratedParameter/default/execution_date/@day_offset, '-', '')"/>
							</xsl:attribute>
						</xsl:if>
					</xsl:when>
					<xsl:when test="count($autogeneratedParameter/default/first_day) = 1">
						<xsl:attribute name="default_date_type">02</xsl:attribute>
						<xsl:if test="$autogeneratedParameter/default/first_day/@day_offset[. != '']">
							<xsl:choose>
								<xsl:when test="starts-with($autogeneratedParameter/default/first_day/@day_offset, '-')">
									<xsl:attribute name="default_date_first_day_of_month_offset">02</xsl:attribute>
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute name="default_date_first_day_of_month_offset">01</xsl:attribute>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:attribute name="default_date_first_day_of_month_offset_days">
								<xsl:value-of select="translate($autogeneratedParameter/default/first_day/@day_offset, '-', '')"/>
							</xsl:attribute>
						</xsl:if>
					</xsl:when>
					<xsl:when test="count($autogeneratedParameter/default/last_day) = 1">
						<xsl:attribute name="default_date_type">03</xsl:attribute>
						<xsl:if test="$autogeneratedParameter/default/last_day/@day_offset[. != '']">	
							<xsl:choose>
								<xsl:when test="starts-with($autogeneratedParameter/default/last_day/@day_offset, '-')">
									<xsl:attribute name="default_date_last_day_of_month_offset">02</xsl:attribute>
								</xsl:when>
								<xsl:otherwise>
									<xsl:attribute name="default_date_last_day_of_month_offset">01</xsl:attribute>
								</xsl:otherwise>
							</xsl:choose>
							<xsl:attribute name="default_date_last_day_of_month_offset_days">
								<xsl:value-of select="translate($autogeneratedParameter/default/last_day/@day_offset, '-', '')"/>
							</xsl:attribute>
						</xsl:if>
					</xsl:when>
					<xsl:when test="count($autogeneratedParameter/default/today) = 1">
						<xsl:attribute name="default_date_type">04</xsl:attribute>
					</xsl:when>
					<xsl:when test="count($autogeneratedParameter/default/tomorrow) = 1">
						<xsl:attribute name="default_date_type">05</xsl:attribute>
					</xsl:when>
					<xsl:when test="count($autogeneratedParameter/default/yesterday) = 1">
						<xsl:attribute name="default_date_type">06</xsl:attribute>
					</xsl:when>
				</xsl:choose>
			</xsl:if>
			<!-- Defaut values in case of use of a parameter -->
			
			<xsl:attribute name="default_string_value">
				<xsl:value-of select="//report/definition/listdef/parameter[@name = $parameterValue]/@default"/>
			</xsl:attribute>
			<xsl:attribute name="default_number_value"/>
		<!-- 	<xsl:attribute name="default_amount_cur_code">
			<xsl:value-of select="//report/definition/listdef/parameter[@name = $parameterValue]/@currency"/>
			</xsl:attribute> -->
			<xsl:attribute name="default_amount_value"/>
			<xsl:attribute name="default_values_set"/>
			<!-- <xsl:attribute name="default_date_type">
				<xsl:value-of select="//report/definition/listdef/parameter[@name = $parameterValue]/default/@type"/>
			</xsl:attribute>
			<xsl:attribute name="default_date_report_exec_date_offset">
				<xsl:if test="//report/definition/listdef/parameter[@name = $parameterValue]/default/@type = '01'">
					<xsl:value-of select="//report/definition/listdef/parameter[@name = $parameterValue]/default/offset/@type"/>
				</xsl:if>
			</xsl:attribute>
			<xsl:attribute name="default_date_report_exec_date_offset_days">
				<xsl:if test="//report/definition/listdef/parameter[@name = $parameterValue]/default/@type = '01'">
					<xsl:value-of select="//report/definition/listdef/parameter[@name = $parameterValue]/default/offset/@nbdays"/>
				</xsl:if>
			</xsl:attribute>
			<xsl:attribute name="default_date_first_day_of_month_offset">
				<xsl:if test="//report/definition/listdef/parameter[@name = $parameterValue]/default/@type = '02'">
					<xsl:value-of select="//report/definition/listdef/parameter[@name = $parameterValue]/default/offset/@type"/>
				</xsl:if>
			</xsl:attribute>
			<xsl:attribute name="default_date_first_day_of_month_offset_days">
				<xsl:if test="//report/definition/listdef/parameter[@name = $parameterValue]/default/@type = '02'">
					<xsl:value-of select="//report/definition/listdef/parameter[@name = $parameterValue]/default/offset/@nbdays"/>
				</xsl:if>
			</xsl:attribute>
			<xsl:attribute name="default_date_last_day_of_month_offset">
				<xsl:if test="//report/definition/listdef/parameter[@name = $parameterValue]/default/@type = '03'">
					<xsl:value-of select="//report/definition/listdef/parameter[@name = $parameterValue]/default/offset/@type"/>
				</xsl:if>
			</xsl:attribute>
			<xsl:attribute name="default_date_last_day_of_month_offset_days">
				<xsl:if test="//report/definition/listdef/parameter[@name = $parameterValue]/default/@type = '03'">
					<xsl:value-of select="//report/definition/listdef/parameter[@name = $parameterValue]/default/offset/@nbdays"/>
				</xsl:if>
			</xsl:attribute>-->
			<xsl:attribute name="default_date_value"/>
		</div>
	</xsl:template>

	<!--
	Aggregates Fieldset. 
	-->
	<xsl:template name="overall-aggregates">
		<div id="overall-aggregates-section" style="display:none">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_REPORT_AGGREGATE</xsl:with-param>
			<xsl:with-param name="content">
				&nbsp;
				<xsl:call-template name="build-overall-aggregates-dojo-items">
					<xsl:with-param name="items" select="definition/listdef/aggregate"/>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		</div>
	</xsl:template>

	<xsl:template name="build-overall-aggregates-dojo-items">
		<xsl:param name="items"/>
		
		<div dojoType="misys.report.widget.Aggregates" dialogId="aggregate-dialog-template" gridId="overall-aggregates-grid" id="overall-aggregates">
			<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_AGGREGATE_TABLE_COLUMN')"/>,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_AGGREGATE_TABLE_AGGREGATE')"/>
			</xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_ADD_AGGREGATE')"/></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UPDATE_AGGREGATE')"/></xsl:attribute>
			<xsl:for-each select="$items">
				<xsl:variable name="aggregate" select="."/>
				<div dojoType="misys.report.widget.Aggregate">
					<xsl:attribute name="column"><xsl:value-of select="$aggregate/column/@name"/></xsl:attribute>
					<xsl:attribute name="type"><xsl:value-of select="$aggregate/@type"/></xsl:attribute>
					<xsl:attribute name="eqv_cur_code"><xsl:value-of select="$aggregate/@cur"/></xsl:attribute>
					<xsl:for-each select="$languages/languages/language">
						<xsl:variable name="lang" select="."/>
						<xsl:attribute name="{concat('label_', $lang)}"><xsl:value-of select="$aggregate/description[@locale = $lang]"/></xsl:attribute>
					</xsl:for-each>
				</div>
			</xsl:for-each>
		</div>
		
	</xsl:template>


	<!--
	Grouping Fieldset. 
	-->
	<xsl:template name="grouping">
		<div id="grouping-section" style="display:none">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_REPORT_GROUPING</xsl:with-param>
			<xsl:with-param name="content">
				<!-- Grouping checkbox -->
				<xsl:call-template name="checkbox-field">
					<xsl:with-param name="label">XSL_REPORT_GROUPING_ENABLE</xsl:with-param>
					<xsl:with-param name="name">grouping_enable</xsl:with-param>
					<xsl:with-param name="checked">
						<xsl:if test="count(definition/listdef/group[not(@graph)]/column) != 0">Y</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
				<div id="grouping_details_section" style="display:none">
					<!-- Show individual records -->
					<!-- commenting this because there is no implemetation for this feature -->
					<!-- <xsl:call-template name="checkbox-field">
						<xsl:with-param name="label">XSL_REPORT_GROUPING_DISPLAY_RECORDS</xsl:with-param>
						<xsl:with-param name="name">grouping_display_records</xsl:with-param>
						<xsl:with-param name="checked">
							<xsl:if test="definition/listdef/group[not(@graph)]/@details = 'Y'">Y</xsl:if>
						</xsl:with-param>
					</xsl:call-template> -->
					<!-- Grouping column -->
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">hidden_grouping_column</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="definition/listdef/group[@graph != '']/column/@name"/></xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="select-field">
						<xsl:with-param name="label">XSL_REPORT_GROUPING_COLUMN</xsl:with-param>
						<xsl:with-param name="name">grouping_column</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="definition/listdef/group[@graph != '']/column/@name"/></xsl:with-param>
					</xsl:call-template>
					<script>
					 dojo.subscribe('formOnLoadEventsPerformed', function(){
					  if(dijit.byId('grouping_enable').get('checked')) {
					   dijit.byId('grouping_column').set('value', '<xsl:value-of select="definition/listdef/group[@graph != '']/column/@name"/>');
					   var groupingColumn = dijit.byId('grouping_column').get('value');
					   dijit.byId('grouping_column_scale').set('required', (groupingColumn != '' &amp;&amp; arrColumn[groupingColumn][0] == 'Date'));
					  }
					 });
					</script>

					<!-- Grouping column scale -->
					<!-- Select values are not created until the page is loaded, so we set value in an onLoad -->
					<!-- Grouping column Scale -->
					<div id="group-scale-section" style="display:none">
					<xsl:call-template name="select-field">
						<xsl:with-param name="label">XSL_REPORT_GROUPING_COLUMN_SCALE</xsl:with-param>
						<xsl:with-param name="name">grouping_column_scale</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="definition/listdef/group[@graph != '']/column/@hierarchy"/></xsl:with-param>
						<xsl:with-param name="options">
							<option value="day">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CHART_SCALE_DAY')"/>
							</option>
							<option value="month">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CHART_SCALE_MONTH')"/>
							</option>
							<!--<option value="trimester">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CHART_SCALE_TRIMESTER')"/>
							</option>-->
							<option value="year">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CHART_SCALE_YEAR')"/>
							</option>
						</xsl:with-param>
					</xsl:call-template>
					</div>
					
					
					<p><br/></p>
					<!-- Grouping Aggregates -->
					<xsl:call-template name="build-group-aggregates-dojo-items">
						<xsl:with-param name="items" select="definition/listdef/group[not(@graph)]/aggregate"/>
					</xsl:call-template>
				</div>
				
			</xsl:with-param>
		</xsl:call-template>
		</div>
	</xsl:template>
 
	<xsl:template name="build-group-aggregates-dojo-items">
		<xsl:param name="items"/>
		
		<div dojoType="misys.report.widget.GroupingAggregates" dialogId="aggregate-dialog-template" gridId="group-aggregates-grid" id="group-aggregates">
			<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_AGGREGATE_TABLE_COLUMN')"/>,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_AGGREGATE_TABLE_AGGREGATE')"/>
			</xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_ADD_AGGREGATE')"/></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UPDATE_AGGREGATE')"/></xsl:attribute>
			<xsl:for-each select="$items">
				<xsl:variable name="aggregate" select="."/>
				<div dojoType="misys.report.widget.Aggregate">
					<xsl:attribute name="column"><xsl:value-of select="$aggregate/column/@name"/></xsl:attribute>
					<xsl:attribute name="type"><xsl:value-of select="$aggregate/@type"/></xsl:attribute>
					<xsl:attribute name="eqv_cur_code"><xsl:value-of select="$aggregate/@cur"/></xsl:attribute>
					<xsl:for-each select="$languages/languages/language">
						<xsl:variable name="lang" select="."/>
						<xsl:attribute name="{concat('label_', $lang)}"><xsl:value-of select="$aggregate/description[@locale = $lang]"/></xsl:attribute>
					</xsl:for-each>
				</div>
			</xsl:for-each>
		</div>
		
	</xsl:template>


	<!--
	Chart Fieldset. 
	-->
	<xsl:template name="chart">
		<div id="chart-section" style="display:none">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_REPORT_CHART</xsl:with-param>
			<xsl:with-param name="content">
			   <!-- Chart -->
				<xsl:call-template name="checkbox-field">
					<xsl:with-param name="label">XSL_REPORT_CHART_FLAG</xsl:with-param>
					<xsl:with-param name="value">
						<xsl:choose>
							<xsl:when test="definition/listdef/group/@graph">Y</xsl:when>
							<xsl:otherwise>N</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
					<xsl:with-param name="name">chart_flag</xsl:with-param>
				</xsl:call-template>
			
				<div id="chart-fields" style="display:block">
			
				<!-- Render As -->
				<xsl:call-template name="select-field">
					<xsl:with-param name="label">XSL_REPORT_CHART_RENDERING</xsl:with-param>
					<xsl:with-param name="name">chart_rendering</xsl:with-param>
					<xsl:with-param name="value" select="definition/listdef/group/@graph" />
					<xsl:with-param name="options">
						<option value="pie">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CHART_RENDERING_PIE')"/>
						</option>
						<option value="pie3d">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CHART_RENDERING_PIE_3D')"/>
						</option>
						<option value="bar">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CHART_RENDERING_BAR')"/>
						</option>
						<option value="bar3d">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CHART_RENDERING_BAR_3D')"/>
						</option>
						<option value="line">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CHART_RENDERING_LINE')"/>
						</option>
						<!-- <option value="time">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CHART_RENDERING_TIME')"/>
						</option>
						<option value="area">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CHART_RENDERING_AREA')"/>
						</option>
						<option value="stackedbar">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CHART_RENDERING_STACKED_BAR')"/>
						</option>
						<option value="point">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CHART_RENDERING_POINT')"/>
						</option>
						<option value="step">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CHART_RENDERING_STEP')"/>
						</option> -->
					</xsl:with-param>
				</xsl:call-template>
				<!-- Chart Axis X -->
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">hidden_chart_axis_x</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="definition/listdef/group[@graph != '']/column/@name"/></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="select-field">
					<xsl:with-param name="label">XSL_REPORT_CHART_AXIS_X</xsl:with-param>
					<xsl:with-param name="name">chart_axis_x</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="definition/listdef/group[@graph != '']/column/@name"/></xsl:with-param>
				</xsl:call-template>
				<!-- Select values are not created until the page is loaded, so we set value in an onLoad -->
				<script>
					dojo.subscribe('formOnLoadEventsPerformed', function(){
						if(dijit.byId('chart_flag').get('checked')) {
							dijit.byId('chart_axis_x').set('value', '<xsl:value-of select="definition/listdef/group[@graph != '']/column/@name"/>');
							var axisX = dijit.byId('chart_axis_x').get('value');
							dijit.byId('chart_axis_x_scale').set('required', (axisX != '' &amp;&amp; arrColumn[axisX][0] == 'Date'));
						}
					});
				</script>
				<!-- Chart Axis X Scale -->
				<div id="chart-x-scale-section" style="display:none">
				<xsl:call-template name="select-field">
					<xsl:with-param name="label">XSL_REPORT_CHART_AXIS_X_SCALE</xsl:with-param>
					<xsl:with-param name="name">chart_axis_x_scale</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="definition/listdef/group[@graph != '']/column/@hierarchy"/></xsl:with-param>
					<xsl:with-param name="options">
						<option value="day">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CHART_SCALE_DAY')"/>
						</option>
						<option value="month">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CHART_SCALE_MONTH')"/>
						</option>
						<!-- <option value="trimester">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CHART_SCALE_TRIMESTER')"/>
						</option>-->
						<option value="year">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CHART_SCALE_YEAR')"/>
						</option>
					</xsl:with-param>
				</xsl:call-template>
				</div>
				<!-- Chart Axis Y -->
				<!-- <xsl:call-template name="hidden-field">
					<xsl:with-param name="name">hidden_chart_axis_y</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="definition/listdef/group/aggregate/column/@name"/></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="select-field">
					<xsl:with-param name="label">XSL_REPORT_CHART_AXIS_Y</xsl:with-param>
					<xsl:with-param name="name">chart_axis_y</xsl:with-param>
					<xsl:with-param name="options">
						<option value=""/>
					</xsl:with-param>
				</xsl:call-template>-->

				<!-- Chart Aggregates -->
				<xsl:call-template name="build-chart-aggregates-dojo-items">
					<xsl:with-param name="items" select="definition/listdef/group[@graph != '']/aggregate"/>
				</xsl:call-template>
				</div>
			</xsl:with-param>
		</xsl:call-template>
	  </div>
	</xsl:template>

	<xsl:template name="build-chart-aggregates-dojo-items">
		<xsl:param name="items"/>
		
		<div dojoType="misys.report.widget.ChartAggregates" dialogId="aggregate-dialog-template" gridId="chart-aggregates-grid" id="chart-aggregates">
			<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CHART_TABLE_AXIS_Y')"/>,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_AGGREGATE_TABLE_AGGREGATE')"/>
			</xsl:attribute>
			<xsl:attribute name="noItemLabel"/>
			<xsl:attribute name="addButtonLabel"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CHART_ADD_AXIS_Y')"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CHART_ADD_AXIS_Y')"/></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CHART_UPDATE_AXIS_Y')"/></xsl:attribute>
			<xsl:for-each select="$items">
				<xsl:variable name="aggregate" select="."/>
				<div dojoType="misys.report.widget.Aggregate">
					<xsl:attribute name="column"><xsl:value-of select="$aggregate/column/@name"/></xsl:attribute>
					<xsl:attribute name="type"><xsl:value-of select="$aggregate/@type"/></xsl:attribute>
					<xsl:attribute name="eqv_cur_code"><xsl:value-of select="$aggregate/@cur"/></xsl:attribute>
					<xsl:for-each select="$languages/languages/language">
						<xsl:variable name="lang" select="."/>
						<xsl:attribute name="{concat('label_', $lang)}"><xsl:value-of select="$aggregate/description[@locale = $lang]"/></xsl:attribute>
					</xsl:for-each>
				</div>
			</xsl:for-each>
		</div>
		
	</xsl:template>
















	
	<!--*************************-->
	<!-- LC Transaction columns *-->
	<!--*************************-->
	<xsl:template name="LCTnx_Columns">
		<xsl:param name="isTemplate"/>
		
		<xsl:if test="$isTemplate!='true'">
			<xsl:choose>
			<!-- Bank only -->
				<xsl:when test="security:isBank($rundata)">
					arrProductColumn["LCTnx"][150] = "company_name";
					arrProductColumn["LCTnx"][151] = "BOInputter@last_name";
					arrProductColumn["LCTnx"][152] = "BOInputter@first_name";
					arrProductColumn["LCTnx"][153] = "bo_inp_dttm";
					arrProductColumn["LCTnx"][154] = "BOController@last_name";
					arrProductColumn["LCTnx"][155] = "BOController@first_name";
					<!-- arrProductColumn["LCTnx"][156] = "bo_ctl_dttm"; -->
					arrProductColumn["LCTnx"][157] = "BOReleaser@last_name";
					arrProductColumn["LCTnx"][158] = "BOReleaser@first_name";

					<xsl:if test="defaultresource:getResource('CHARGE_FIELDS_LC') = 'true'">
						arrProductColumn["LCTnx"][139] = "Charge@chrg_code";
						arrProductColumn["LCTnx"][140] = "Charge@amt";
						arrProductColumn["LCTnx"][141] = "Charge@cur_code";
						arrProductColumn["LCTnx"][142] = "Charge@status";
						arrProductColumn["LCTnx"][143] = "Charge@additional_comment";
						arrProductColumn["LCTnx"][144] = "Charge@settlement_date";
						arrProductColumn["LCTnx"][147] = "Charge@chrg_type";
					</xsl:if>

					<xsl:if test="defaultresource:getResource('CHARGE_SPLITTING_LC') = 'true'">
						arrProductColumn["LCTnx"][170] = "open_chrg_applicant";
						arrProductColumn["LCTnx"][171] = "open_chrg_beneficiary";
						arrProductColumn["LCTnx"][172] = "corr_chrg_applicant";
						arrProductColumn["LCTnx"][173] = "corr_chrg_beneficiary";
						arrProductColumn["LCTnx"][174] = "cfm_chrg_applicant";
						arrProductColumn["LCTnx"][175] = "cfm_chrg_beneficiary";			
					</xsl:if>
				</xsl:when>
				<!-- customer -->
				<xsl:otherwise>
					<xsl:if test="defaultresource:getResource('CHARGE_FIELDS_LC') = 'true'">
						arrProductColumn["LCTnx"][139] = "Charge@chrg_code";
						arrProductColumn["LCTnx"][140] = "Charge@amt";
						arrProductColumn["LCTnx"][141] = "Charge@cur_code";
						arrProductColumn["LCTnx"][142] = "Charge@status";
						arrProductColumn["LCTnx"][143] = "Charge@additional_comment";
						arrProductColumn["LCTnx"][144] = "Charge@settlement_date";
						arrProductColumn["LCTnx"][147] = "Charge@chrg_type";
					</xsl:if>
					<xsl:if test="defaultresource:getResource('CHARGE_SPLITTING_LC') = 'true'">
						arrProductColumn["LCTnx"][170] = "open_chrg_applicant";
						arrProductColumn["LCTnx"][171] = "open_chrg_beneficiary";
						arrProductColumn["LCTnx"][172] = "corr_chrg_applicant";
						arrProductColumn["LCTnx"][173] = "corr_chrg_beneficiary";
						arrProductColumn["LCTnx"][174] = "cfm_chrg_applicant";
						arrProductColumn["LCTnx"][175] = "cfm_chrg_beneficiary";			
					</xsl:if>	
					<xsl:if test="securityCheck:hasCompanyPermission($rundata,'lc_display_po_reference') and defaultresource:getResource('PURCHASE_ORDER_REFERENCE_ENABLED') = 'true'">
					arrProductColumn["LCTnx"][176]= "ObjectDataString@purchase_order";
					</xsl:if>
								
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		
		<!-- Object Data -->
		<xsl:if test="securityCheck:hasCompanyPermission($rundata,'lc_display_po') or $isTemplate='true'">
			arrProductColumn["LCTnx"][159] = "ObjectDataString@po_ref_id";
		</xsl:if>
		<!-- SWIFT 2018 -->
		<xsl:if test="$swift2018Enabled">
			arrProductColumn["LCTnx"][201] = "period_presentation_days";
			arrProductColumn["LCTnx"][202] = "req_conf_party_flag";
			arrProductColumn["LCTnx"][203] = "RequestedConfirmationParty@name";
			arrProductColumn["LCTnx"][204] = "RequestedConfirmationParty@address_line_1";
			arrProductColumn["LCTnx"][205] = "RequestedConfirmationParty@address_line_2";
			arrProductColumn["LCTnx"][206] = "RequestedConfirmationParty@dom"; 
			arrProductColumn["LCTnx"][207] = "RequestedConfirmationParty@iso_code";
			arrProductColumn["LCTnx"][210] = "amd_chrg_brn_by_code";
			arrProductColumn["LCTnx"][211] = "Narrative@amendCharges";
			arrProductColumn["LCTnx"][212] = "Narrative@legacyPartialShipment";
			arrProductColumn["LCTnx"][213] = "Narrative@legacyTranShipment";
			arrProductColumn["LCTnx"][214] = "Narrative@legacyPeriodOfPresentation";
			arrProductColumn["LCTnx"][215] = "Narrative@legacyMaxCreditAmount";
			arrProductColumn["LCTnx"][216] = "related_ref_id";
		</xsl:if>
		<xsl:if test="not($swift2018Enabled)">
			arrProductColumn["LCTnx"][104] = "Narrative@goodsDesc";
			arrProductColumn["LCTnx"][105] = "Narrative@docsRequired";
			arrProductColumn["LCTnx"][106] = "Narrative@additionalInstructions"
			arrProductColumn["LCTnx"][53] = "max_cr_desc_code";
		</xsl:if>
		
		
	</xsl:template>
	

	<!--********************-->
	<!-- LC Master columns *-->
	<!--********************-->
	<xsl:template name="LC_Columns">
		<xsl:param name="isTemplate"/>
		<xsl:if test="$isTemplate!='true'">
			<xsl:choose>	
				<!-- Bank only -->	
				<xsl:when test="security:isBank($rundata)">
					arrProductColumn["LC"][120] = "company_name";
					
					<xsl:if test="defaultresource:getResource('CHARGE_FIELDS_LC') = 'true'">
						arrProductColumn["LC"][139] = "Charge@chrg_code";
						arrProductColumn["LC"][140] = "Charge@amt";
						arrProductColumn["LC"][141] = "Charge@cur_code";
						arrProductColumn["LC"][142] = "Charge@status";
						arrProductColumn["LC"][143] = "Charge@additional_comment";
						arrProductColumn["LC"][144] = "Charge@settlement_date";
						arrProductColumn["LC"][147] = "Charge@chrg_type";
					</xsl:if>
					
					<xsl:if test="defaultresource:getResource('CHARGE_SPLITTING_LC') = 'true'">
						arrProductColumn["LC"][133] = "open_chrg_applicant";
						arrProductColumn["LC"][134] = "open_chrg_beneficiary";
						arrProductColumn["LC"][135] = "corr_chrg_applicant";
						arrProductColumn["LC"][136] = "corr_chrg_beneficiary";
						arrProductColumn["LC"][137] = "cfm_chrg_applicant";
						arrProductColumn["LC"][138] = "cfm_chrg_beneficiary";
					</xsl:if>
				</xsl:when>
				<!-- Customer -->
				<xsl:otherwise>
				<xsl:if test="defaultresource:getResource('CHARGE_FIELDS_LC') = 'true'">
						arrProductColumn["LC"][139] = "Charge@chrg_code";
						arrProductColumn["LC"][140] = "Charge@amt";
						arrProductColumn["LC"][141] = "Charge@cur_code";
						arrProductColumn["LC"][142] = "Charge@status";
						arrProductColumn["LC"][143] = "Charge@additional_comment";
						arrProductColumn["LC"][144] = "Charge@settlement_date";
						arrProductColumn["LC"][147] = "Charge@chrg_type";
					</xsl:if>
					<xsl:if test="defaultresource:getResource('CHARGE_SPLITTING_LC') = 'true'">
						arrProductColumn["LC"][133] = "open_chrg_applicant";
						arrProductColumn["LC"][134] = "open_chrg_beneficiary";
						arrProductColumn["LC"][135] = "corr_chrg_applicant";
						arrProductColumn["LC"][136] = "corr_chrg_beneficiary";
						arrProductColumn["LC"][137] = "cfm_chrg_applicant";
						arrProductColumn["LC"][138] = "cfm_chrg_beneficiary";
					</xsl:if>
					<xsl:if test="securityCheck:hasCompanyPermission($rundata,'lc_display_po_reference') and defaultresource:getResource('PURCHASE_ORDER_REFERENCE_ENABLED') = 'true'">
					arrProductColumn["LC"][151]= "ObjectDataString@purchase_order";
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
		
		<!-- Object Data -->
		<xsl:if test="securityCheck:hasCompanyPermission($rundata,'lc_display_po') or $isTemplate='true'">
			arrProductColumn["LC"][121] = "ObjectDataString@po_ref_id";
		</xsl:if>
		<xsl:if test="$swift2018Enabled">
			arrProductColumn["LC"][151] = "req_conf_party_flag";
			arrProductColumn["LC"][152] = "RequestedConfirmationParty@name";
			arrProductColumn["LC"][153] = "RequestedConfirmationParty@address_line_1";
			arrProductColumn["LC"][154] = "RequestedConfirmationParty@address_line_2";
			arrProductColumn["LC"][155] = "RequestedConfirmationParty@dom";
			arrProductColumn["LC"][156] = "RequestedConfirmationParty@iso_code";
			arrProductColumn["LC"][159] = "period_presentation_days";
			arrProductColumn["LC"][160] = "amd_chrg_brn_by_code";
			arrProductColumn["LC"][161] = "Narrative@amendCharges";
			arrProductColumn["LC"][162] = "Narrative@legacyPartialShipment";
			arrProductColumn["LC"][163] = "Narrative@legacyTranShipment";
			arrProductColumn["LC"][164] = "Narrative@legacyPeriodOfPresentation";
			arrProductColumn["LC"][165] = "Narrative@legacyMaxCreditAmount";
		</xsl:if>
		<xsl:if test="not($swift2018Enabled)">
			arrProductColumn["LC"][104] = "Narrative@goodsDesc";
			arrProductColumn["LC"][105] = "Narrative@docsRequired";
			arrProductColumn["LC"][106] = "Narrative@additionalInstructions";
			arrProductColumn["LC"][53] = "max_cr_desc_code";
		</xsl:if>
		
	</xsl:template>


	<!--**********************-->
	<!-- LC Template columns *-->
	<!--**********************-->
	<xsl:template name="LCTemplate_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata)and $isTemplate!='true'">
			arrProductColumn["LCTemplate"][113] = "company_name";
		</xsl:if>

		<!-- Object Data -->
		<xsl:if test="securityCheck:hasCompanyPermission($rundata,'lc_display_po') or $isTemplate='true'">
			arrProductColumn["LCTemplate"][114] = "ObjectDataString@po_ref_id";
		</xsl:if>
		<!-- SWIFT 2018 -->
		<xsl:if test="$swift2018Enabled">
			arrProductColumn["LCTemplate"][127] = "period_presentation_days";
			arrProductColumn["LCTemplate"][128] = "req_conf_party_flag";
			arrProductColumn["LCTemplate"][129] = "RequestedConfirmationParty@name";
			arrProductColumn["LCTemplate"][130] = "RequestedConfirmationParty@address_line_1";
			arrProductColumn["LCTemplate"][131] = "RequestedConfirmationParty@address_line_2";
			arrProductColumn["LCTemplate"][132] = "RequestedConfirmationParty@dom"; 
			arrProductColumn["LCTemplate"][133] = "RequestedConfirmationParty@iso_code"; 
		</xsl:if>
		<xsl:if test="not($swift2018Enabled)">
			arrProductColumn["LCTemplate"][104] = "Narrative@goodsDesc";
			arrProductColumn["LCTemplate"][105] = "Narrative@docsRequired";
			arrProductColumn["LCTemplate"][106] = "Narrative@additionalInstructions";
			arrProductColumn["LCTemplate"][53] = "max_cr_desc_code";
		</xsl:if>
		
	</xsl:template>
	
	
	
	<!--*************************-->
	<!-- LS Transaction columns *-->
	<!--*************************-->
	<xsl:template name="LSTnx_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["LSTnx"][201] = "company_name";
			arrProductColumn["LSTnx"][202] = "BOInputter@last_name";
			arrProductColumn["LSTnx"][203] = "BOInputter@first_name";
			arrProductColumn["LSTnx"][204] = "bo_inp_dttm";
			arrProductColumn["LSTnx"][205] = "BOController@last_name";
			arrProductColumn["LSTnx"][206] = "BOController@first_name";
			arrProductColumn["LSTnx"][207] = "bo_ctl_dttm";
			arrProductColumn["LSTnx"][208] = "BOReleaser@last_name";
			arrProductColumn["LSTnx"][209] = "BOReleaser@first_name";
		</xsl:if>

		<!-- Object Data -->
		<xsl:if test="securityCheck:hasCompanyPermission($rundata,'ls_display_po') or $isTemplate='true'">
			arrProductColumn["LSTnx"][210] = "ObjectDataString@po_ref_id";
		</xsl:if>
		
	</xsl:template>
	

	<!--********************-->
	<!-- LS Master columns *-->
	<!--********************-->
	<xsl:template name="LS_Columns">
		<xsl:param name="isTemplate"/>
		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata)and $isTemplate!='true'">
			arrProductColumn["LS"][130] = "company_name";
		</xsl:if>
		
		<!-- Object Data -->
		<xsl:if test="securityCheck:hasCompanyPermission($rundata,'ls_display_po') or $isTemplate='true'">
			arrProductColumn["LS"][131] = "ObjectDataString@po_ref_id";
		</xsl:if>
	</xsl:template>
	
	<!--**********************-->
	<!-- LS Template columns *-->
	<!--**********************-->
	<xsl:template name="LSTemplate_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata)and $isTemplate!='true'">
			arrProductColumn["LSTemplate"][113] = "company_name";
		</xsl:if>

		<!-- Object Data -->
		<xsl:if test="securityCheck:hasCompanyPermission($rundata,'ls_display_po') or $isTemplate='true'">
			arrProductColumn["LSTemplate"][114] = "ObjectDataString@po_ref_id";
		</xsl:if>

	</xsl:template>
	
	
	<!--*************************-->
	<!-- RI Transaction columns *-->
	<!--*************************-->
	<xsl:template name="RITnx_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
      		arrProductColumn["RITnx"][17] = "tnx_stat_code";
			arrProductColumn["RITnx"][150] = "company_name";
			arrProductColumn["RITnx"][151] = "BOInputter@last_name";
			arrProductColumn["RITnx"][152] = "BOInputter@first_name";
			arrProductColumn["RITnx"][153] = "bo_inp_dttm";
			arrProductColumn["RITnx"][154] = "BOController@last_name";
			arrProductColumn["RITnx"][155] = "BOController@first_name";
			arrProductColumn["RITnx"][156] = "bo_ctl_dttm";
			arrProductColumn["RITnx"][157] = "BOReleaser@last_name";
			arrProductColumn["RITnx"][158] = "BOReleaser@first_name";
		</xsl:if>

		<!-- Object Data -->
		<xsl:if test="securityCheck:hasCompanyPermission($rundata,'ri_display_po') or $isTemplate='true'">
			arrProductColumn["RITnx"][159] = "ObjectDataString@po_ref_id";
		</xsl:if>
		
	</xsl:template>
	

	<!--********************-->
	<!-- LC Master columns *-->
	<!--********************-->
	<xsl:template name="RI_Columns">
		<xsl:param name="isTemplate"/>
		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata)and $isTemplate!='true'">
			arrProductColumn["RI"][120] = "company_name";
		</xsl:if>
		
		<!-- Object Data -->
		<xsl:if test="securityCheck:hasCompanyPermission($rundata,'ri_display_po') or $isTemplate='true'">
			arrProductColumn["RI"][121] = "ObjectDataString@po_ref_id";
		</xsl:if>
	</xsl:template>


	<!--**********************-->
	<!-- RI Template columns *-->
	<!--**********************-->
	<xsl:template name="RITemplate_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata)and $isTemplate!='true'">
			arrProductColumn["RITemplate"][113] = "company_name";
		</xsl:if>

		<!-- Object Data -->
		<xsl:if test="securityCheck:hasCompanyPermission($rundata,'ri_display_po') or $isTemplate='true'">
			arrProductColumn["RITemplate"][114] = "ObjectDataString@po_ref_id";
		</xsl:if>

	</xsl:template>
		

	<!--*************************-->
	<!-- SE Transaction columns *-->
	<!--*************************-->
	<xsl:template name="SETnx_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
      		<!-- arrProductColumn["SETnx"][17] = "tnx_stat_code"; -->
			arrProductColumn["SETnx"][150] = "company_name";
			arrProductColumn["SETnx"][151] = "BOInputter@last_name";
			arrProductColumn["SETnx"][152] = "BOInputter@first_name";
			arrProductColumn["SETnx"][153] = "bo_inp_dttm";
			arrProductColumn["SETnx"][154] = "BOController@last_name";
			arrProductColumn["SETnx"][155] = "BOController@first_name";
			arrProductColumn["SETnx"][156] = "bo_ctl_dttm";
			arrProductColumn["SETnx"][157] = "BOReleaser@last_name";
			arrProductColumn["SETnx"][158] = "BOReleaser@first_name";
		</xsl:if>
		
	</xsl:template>
	
	
	<!--********************-->
	<!-- SE Master columns *-->
	<!--********************-->
	<xsl:template name="SE_Columns">
		<xsl:param name="isTemplate"/>
		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata)and $isTemplate!='true'">
			arrProductColumn["SE"][120] = "company_name";
		</xsl:if>
		
	</xsl:template>


	<!--**********************-->
	<!-- SE Template columns *-->
	<!--**********************-->
	<xsl:template name="SETemplate_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata)and $isTemplate!='true'">
			arrProductColumn["SETemplate"][113] = "company_name";
		</xsl:if>

		<!-- Object Data -->
		<xsl:if test="securityCheck:hasCompanyPermission($rundata,'se_display_po') or $isTemplate='true'">
			arrProductColumn["SETemplate"][114] = "ObjectDataString@po_ref_id";
		</xsl:if>
	
	</xsl:template>



	<!--*************************-->
	<!-- EL Transaction columns *-->
	<!--*************************-->
	<xsl:template name="ELTnx_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["ELTnx"][150] = "company_name";
			arrProductColumn["ELTnx"][151] = "BOInputter@last_name";
			arrProductColumn["ELTnx"][152] = "BOInputter@first_name";
			arrProductColumn["ELTnx"][153] = "bo_inp_dttm";
			arrProductColumn["ELTnx"][154] = "BOController@last_name";
			arrProductColumn["ELTnx"][155] = "BOController@first_name";
			arrProductColumn["ELTnx"][156] = "bo_ctl_dttm";
			arrProductColumn["ELTnx"][157] = "BOReleaser@last_name";
			arrProductColumn["ELTnx"][158] = "BOReleaser@first_name";			
		</xsl:if>	
		<!-- SWIFT 2018 -->
		<xsl:if test="$swift2018Enabled">
			arrProductColumn["ELTnx"][161] = "RequestedConfirmationParty@name";
			arrProductColumn["ELTnx"][162] = "RequestedConfirmationParty@address_line_1";
			arrProductColumn["ELTnx"][163] = "RequestedConfirmationParty@address_line_2";
			arrProductColumn["ELTnx"][164] = "RequestedConfirmationParty@dom";
			arrProductColumn["ELTnx"][165] = "RequestedConfirmationParty@iso_code";
			arrProductColumn["ELTnx"][166] = "period_presentation_days"; 
			arrProductColumn["ELTnx"][167] = "req_conf_party_flag";	
			arrProductColumn["ELTnx"][171] = "Narrative@legacyPartialShipment";
			arrProductColumn["ELTnx"][172] = "Narrative@legacyTranShipment";
			arrProductColumn["ELTnx"][173] = "Narrative@legacyPeriodOfPresentation";
			arrProductColumn["ELTnx"][174] = "Narrative@legacyMaxCreditAmount";
		</xsl:if>
		<xsl:if test="not($swift2018Enabled)">
			arrProductColumn["ELTnx"][104] = "Narrative@goodsDesc";
			arrProductColumn["ELTnx"][105] = "Narrative@docsRequired";
			arrProductColumn["ELTnx"][106] = "Narrative@additionalInstructions";
			arrProductColumn["ELTnx"][56] = "max_cr_desc_code";
		</xsl:if>
		arrProductColumn["ELTnx"][168] = "Narrative@senderToReceiver";
		arrProductColumn["ELTnx"][169] = "Narrative@paymentInstructions";
		arrProductColumn["ELTnx"][170] = "Narrative@additionalAmount"
		
	</xsl:template>


	<!--********************-->
	<!-- EL Master columns *-->
	<!--********************-->
	<xsl:template name="EL_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["EL"][120] = "company_name";	
		</xsl:if>
		<!-- SWIFT 2018 -->
		<xsl:if test="$swift2018Enabled">
			arrProductColumn["EL"][123] = "RequestedConfirmationParty@name";
			arrProductColumn["EL"][124] = "RequestedConfirmationParty@address_line_1";
			arrProductColumn["EL"][125] = "RequestedConfirmationParty@address_line_2";
			arrProductColumn["EL"][126] = "RequestedConfirmationParty@dom";
			arrProductColumn["EL"][127] = "RequestedConfirmationParty@iso_code";
			arrProductColumn["EL"][128] = "period_presentation_days";
			arrProductColumn["EL"][129] = "req_conf_party_flag";
			arrProductColumn["EL"][133] = "Narrative@legacyPartialShipment";
			arrProductColumn["EL"][134] = "Narrative@legacyTranShipment";
			arrProductColumn["EL"][135] = "Narrative@legacyPeriodOfPresentation";
			arrProductColumn["EL"][136] = "Narrative@legacyMaxCreditAmount";
		</xsl:if>
		<xsl:if test="not($swift2018Enabled)">
			arrProductColumn["EL"][104] = "Narrative@goodsDesc";
			arrProductColumn["EL"][105] = "Narrative@docsRequired";
			arrProductColumn["EL"][106] = "Narrative@additionalInstructions";
			arrProductColumn["EL"][53] = "max_cr_desc_code";
		</xsl:if>
		arrProductColumn["EL"][130] = "Narrative@senderToReceiver";
		arrProductColumn["EL"][131] = "Narrative@paymentInstructions";
		arrProductColumn["EL"][132] = "Narrative@additionalAmount"
	

	</xsl:template>


	<!--*************************-->
	<!-- BG Transaction columns *-->
	<!--*************************-->
	<xsl:template name="BGTnx_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["BGTnx"][150] = "company_name";
			arrProductColumn["BGTnx"][151] = "BOInputter@last_name";
			arrProductColumn["BGTnx"][152] = "BOInputter@first_name";
			arrProductColumn["BGTnx"][153] = "bo_inp_dttm";
			arrProductColumn["BGTnx"][154] = "BOController@last_name";
			arrProductColumn["BGTnx"][155] = "BOController@first_name";
			arrProductColumn["BGTnx"][156] = "bo_ctl_dttm";
			arrProductColumn["BGTnx"][157] = "BOReleaser@last_name";
			arrProductColumn["BGTnx"][158] = "BOReleaser@first_name";
		</xsl:if>

	</xsl:template>


	<!--********************-->
	<!-- BG Master columns *-->
	<!--********************-->
	<xsl:template name="BG_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["BG"][120] = "company_name";
		</xsl:if>
		
	</xsl:template>
	
	
	<!--**********************-->
	<!-- BG Template columns *-->
	<!--**********************-->
	<xsl:template name="BGTemplate_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["BGTemplate"][110] = "company_name";
		</xsl:if>

	</xsl:template>
	
	<!--*************************-->
	<!-- BK Transaction columns *-->
	<!--*************************-->
	<xsl:template name="BKTnx_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["BKTnx"][150] = "company_name";
			arrProductColumn["BKTnx"][151] = "BOInputter@last_name";
			arrProductColumn["BKTnx"][152] = "BOInputter@first_name";
			arrProductColumn["BKTnx"][153] = "bo_inp_dttm";
			arrProductColumn["BKTnx"][154] = "BOController@last_name";
			arrProductColumn["BKTnx"][155] = "BOController@first_name";
			arrProductColumn["BKTnx"][156] = "bo_ctl_dttm";
			arrProductColumn["BKTnx"][157] = "BOReleaser@last_name";
			arrProductColumn["BKTnx"][158] = "BOReleaser@first_name";
			
			arrProductCriteriaColumn["BKTnx"][151] = "BOInputter@last_name";
			arrProductCriteriaColumn["BKTnx"][152] = "BOInputter@first_name";
			arrProductCriteriaColumn["BKTnx"][154] = "BOController@last_name";
			arrProductCriteriaColumn["BKTnx"][155] = "BOController@first_name";
			arrProductCriteriaColumn["BKTnx"][156] = "bo_ctl_dttm";
			arrProductCriteriaColumn["BKTnx"][157] = "BOReleaser@last_name";
			arrProductCriteriaColumn["BKTnx"][158] = "BOReleaser@first_name";
			arrProductCriteriaColumn["BKTnx"][100] = "company_name";
			arrProductGroupColumn["BKTnx"][100] = "company_name";
			arrProductChartXAxisColumn["BKTnx"][100] = "company_name";
			arrProductAggregateColumn["BKTnx"][100] = "company_name";
	</xsl:if>
	
	<!-- Entity -->
	<xsl:if test="securityCheck:hasEntities($rundata)">
		arrProductColumn["BKTnx"][159] = "entity";
	</xsl:if>
	</xsl:template>
	<!--********************-->
	<!-- BK Master columns *-->
	<!--********************-->
	<xsl:template name="BK_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["BK"][120] = "company_name";
			arrProductCriteriaColumn["BK"][100] = "company_name";
			arrProductGroupColumn["BK"][100] = "company_name";
			arrProductChartXAxisColumn["BK"][100] = "company_name";
			arrProductAggregateColumn["BK"][100] = "company_name";

			
		</xsl:if>
		
		<!-- Entity -->
		<xsl:if test="securityCheck:hasEntities($rundata)">
			arrProductColumn["BK"][121] = "entity";
		</xsl:if>
		
		
	</xsl:template>


	<!--*************************-->
	<!-- BR Transaction columns *-->
	<!--*************************-->
	<xsl:template name="BRTnx_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["BRTnx"][150] = "company_name";
			arrProductColumn["BRTnx"][151] = "BOInputter@last_name";
			arrProductColumn["BRTnx"][152] = "BOInputter@first_name";
			arrProductColumn["BRTnx"][153] = "bo_inp_dttm";
			arrProductColumn["BRTnx"][154] = "BOController@last_name";
			arrProductColumn["BRTnx"][155] = "BOController@first_name";
			arrProductColumn["BRTnx"][156] = "bo_ctl_dttm";
			arrProductColumn["BRTnx"][157] = "BOReleaser@last_name";
			arrProductColumn["BRTnx"][158] = "BOReleaser@first_name";
		</xsl:if>

	</xsl:template>


	<!--********************-->
	<!-- BR Master columns *-->
	<!--********************-->
	<xsl:template name="BR_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["BR"][110] = "company_name";
		</xsl:if>
		
	</xsl:template>
	
	
	<!--*************************-->
	<!-- SG Transaction columns *-->
	<!--*************************-->
	<xsl:template name="SGTnx_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["SGTnx"][150] = "company_name";
			arrProductColumn["SGTnx"][151] = "BOInputter@last_name";
			arrProductColumn["SGTnx"][152] = "BOInputter@first_name";
			arrProductColumn["SGTnx"][153] = "bo_inp_dttm";
			arrProductColumn["SGTnx"][154] = "BOController@last_name";
			arrProductColumn["SGTnx"][155] = "BOController@first_name";
			arrProductColumn["SGTnx"][156] = "bo_ctl_dttm";
			arrProductColumn["SGTnx"][157] = "BOReleaser@last_name";
			arrProductColumn["SGTnx"][158] = "BOReleaser@first_name";
		</xsl:if>

	</xsl:template>


	<!--**********************-->
	<!-- SG Master columns *-->
	<!--**********************-->
	<xsl:template name="SG_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["SG"][110] = "company_name";
		</xsl:if>
	</xsl:template>


	<!--*************************-->
	<!-- TF Transaction columns *-->
	<!--*************************-->
	<xsl:template name="TFTnx_Columns">
		<xsl:param name="isTemplate"/>
		
		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
      arrProductColumn["TFTnx"][17] = "tnx_stat_code";
			arrProductColumn["TFTnx"][150] = "company_name";
			arrProductColumn["TFTnx"][151] = "BOInputter@last_name";
			arrProductColumn["TFTnx"][152] = "BOInputter@first_name";
			arrProductColumn["TFTnx"][153] = "bo_inp_dttm";
			arrProductColumn["TFTnx"][154] = "BOController@last_name";
			arrProductColumn["TFTnx"][155] = "BOController@first_name";
			arrProductColumn["TFTnx"][156] = "bo_ctl_dttm";
			arrProductColumn["TFTnx"][157] = "BOReleaser@last_name";
			arrProductColumn["TFTnx"][158] = "BOReleaser@first_name";
		</xsl:if>

	</xsl:template>


	<!--********************-->
	<!-- TF Master columns *-->
	<!--********************-->
	<xsl:template name="TF_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["TF"][110] = "company_name";
		</xsl:if>
	</xsl:template>


	<!--*************************-->
	<!-- FT Transaction columns *-->
	<!--*************************-->
	<xsl:template name="FTTnx_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
      <!-- arrProductColumn["FTTnx"][17] = "tnx_stat_code"; -->
			arrProductColumn["FTTnx"][150] = "company_name";
			arrProductColumn["FTTnx"][151] = "BOInputter@last_name";
			arrProductColumn["FTTnx"][152] = "BOInputter@first_name";
			arrProductColumn["FTTnx"][154] = "BOController@last_name";
			arrProductColumn["FTTnx"][155] = "BOController@first_name";
			arrProductColumn["FTTnx"][156] = "bo_ctl_dttm";
			arrProductColumn["FTTnx"][157] = "BOReleaser@last_name";
			arrProductColumn["FTTnx"][158] = "BOReleaser@first_name";
			arrProductCriteriaColumn["FTTnx"][151] = "BOInputter@last_name";
			arrProductCriteriaColumn["FTTnx"][152] = "BOInputter@first_name";
			arrProductCriteriaColumn["FTTnx"][154] = "BOController@last_name";
			arrProductCriteriaColumn["FTTnx"][155] = "BOController@first_name";
			arrProductCriteriaColumn["FTTnx"][156] = "bo_ctl_dttm";
			arrProductCriteriaColumn["FTTnx"][157] = "BOReleaser@last_name";
			arrProductCriteriaColumn["FTTnx"][158] = "BOReleaser@first_name";
			arrProductCriteriaColumn["FTTnx"][100] = "company_name";
			arrProductGroupColumn["FTTnx"][100] = "company_name";
			arrProductChartXAxisColumn["FTTnx"][100] = "company_name";
			arrProductAggregateColumn["FTTnx"][100] = "company_name";
		</xsl:if>
		
		<xsl:if test="securityCheck:hasEntities($rundata)">
			arrProductColumn["FTTnx"][159] = "entity";
		</xsl:if>
	</xsl:template>


	<!--********************-->
	<!-- FT Master columns *-->
	<!--********************-->
	<xsl:template name="FT_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["FT"][110] = "company_name";
			arrProductCriteriaColumn["FT"][100] = "company_name";
			arrProductGroupColumn["FT"][100] = "company_name";
			arrProductChartXAxisColumn["FT"][100] = "company_name";
			arrProductAggregateColumn["FT"][100] = "company_name";
		</xsl:if>
		<!-- Entity -->
		<xsl:if test="securityCheck:hasEntities($rundata)">
			arrProductColumn["FT"][111] = "entity";
		</xsl:if>
		</xsl:template>

	<!--**********************-->
	<!-- FT Template columns *-->
	<!--**********************-->
	<xsl:template name="FTTemplate_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["FTTemplate"][113] = "company_name";
		</xsl:if>
		<xsl:if test="securityCheck:hasEntities($rundata)">
			arrProductColumn["FTTemplate"][114] = "entity";
		</xsl:if>

	</xsl:template>


	<!--*************************-->
	<!-- EC Transaction columns *-->
	<!--*************************-->
	<xsl:template name="ECTnx_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["ECTnx"][150] = "company_name";
			arrProductColumn["ECTnx"][151] = "BOInputter@last_name";
			arrProductColumn["ECTnx"][152] = "BOInputter@first_name";
			arrProductColumn["ECTnx"][153] = "bo_inp_dttm";
			arrProductColumn["ECTnx"][154] = "BOController@last_name";
			arrProductColumn["ECTnx"][155] = "BOController@first_name";
			arrProductColumn["ECTnx"][156] = "bo_ctl_dttm";
			arrProductColumn["ECTnx"][157] = "BOReleaser@last_name";
			arrProductColumn["ECTnx"][158] = "BOReleaser@first_name";
		</xsl:if>

	</xsl:template>


	<!--********************-->
	<!-- EC Master columns *-->
	<!--********************-->
	<xsl:template name="EC_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["EC"][115] = "company_name";
		</xsl:if>
	</xsl:template>


	<!--**********************-->
	<!-- EC Template columns *-->
	<!--**********************-->
	<xsl:template name="ECTemplate_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["ECTemplate"][115] = "company_name";
		</xsl:if>
	</xsl:template>


	<!--*************************-->
	<!-- IC Transaction columns *-->
	<!--*************************-->
	<xsl:template name="ICTnx_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["ICTnx"][150] = "company_name";
			arrProductColumn["ICTnx"][151] = "BOInputter@last_name";
			arrProductColumn["ICTnx"][152] = "BOInputter@first_name";
			arrProductColumn["ICTnx"][153] = "bo_inp_dttm";
			arrProductColumn["ICTnx"][154] = "BOController@last_name";
			arrProductColumn["ICTnx"][155] = "BOController@first_name";
			arrProductColumn["ICTnx"][156] = "bo_ctl_dttm";
			arrProductColumn["ICTnx"][157] = "BOReleaser@last_name";
			arrProductColumn["ICTnx"][158] = "BOReleaser@first_name";
		</xsl:if>

	</xsl:template>
	
	<!--********************-->
	<!-- IC Master columns *-->
	<!--********************-->
	<xsl:template name="IC_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["IC"][115] = "company_name";
		</xsl:if>
	</xsl:template>

	<!--*************************-->
	<!-- IR Transaction columns *-->
	<!--*************************-->
	<xsl:template name="IRTnx_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
     <!--  arrProductColumn["IRTnx"][17] = "tnx_stat_code"; -->
			arrProductColumn["IRTnx"][150] = "company_name";
			arrProductColumn["IRTnx"][151] = "BOInputter@last_name";
			arrProductColumn["IRTnx"][152] = "BOInputter@first_name";
			arrProductColumn["IRTnx"][153] = "bo_inp_dttm";
			arrProductColumn["IRTnx"][154] = "BOController@last_name";
			arrProductColumn["IRTnx"][155] = "BOController@first_name";
			arrProductColumn["IRTnx"][156] = "bo_ctl_dttm";
			arrProductColumn["IRTnx"][157] = "BOReleaser@last_name";
			arrProductColumn["IRTnx"][158] = "BOReleaser@first_name";
		</xsl:if>

	</xsl:template>
	
	<!--********************-->
	<!-- IR Master columns *-->
	<!--********************-->
	<xsl:template name="IR_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["IR"][115] = "company_name";
		</xsl:if>
	</xsl:template>

	<!--*************************-->
	<!-- SI Transaction columns *-->
	<!--*************************-->
	<xsl:template name="SITnx_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["SITnx"][150] = "company_name";
			arrProductColumn["SITnx"][151] = "BOInputter@last_name";
			arrProductColumn["SITnx"][152] = "BOInputter@first_name";
			arrProductColumn["SITnx"][153] = "bo_inp_dttm";
			arrProductColumn["SITnx"][154] = "BOController@last_name";
			arrProductColumn["SITnx"][155] = "BOController@first_name";
			arrProductColumn["SITnx"][156] = "bo_ctl_dttm";
			arrProductColumn["SITnx"][157] = "BOReleaser@last_name";
			arrProductColumn["SITnx"][158] = "BOReleaser@first_name";
		</xsl:if>

		<xsl:if test="securityCheck:hasCompanyPermission($rundata,'lc_display_po') or $isTemplate='true'">
			arrProductColumn["SITnx"][203] = "ObjectDataString@po_ref_id";
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyPermission($rundata,'si_display_po_reference') and defaultresource:getResource('PURCHASE_ORDER_REFERENCE_ENABLED') = 'true'">
		arrProductColumn["SITnx"][176]= "ObjectDataString@purchase_order";
		</xsl:if>
		<xsl:if test="$swift2018Enabled">
			arrProductColumn["SITnx"][206] = "period_presentation_days";
			arrProductColumn["SITnx"][207] = "req_conf_party_flag";
			arrProductColumn["SITnx"][208] = "RequestedConfirmationParty@name";
			arrProductColumn["SITnx"][209] = "RequestedConfirmationParty@address_line_1";
			arrProductColumn["SITnx"][210] = "RequestedConfirmationParty@address_line_2";
			arrProductColumn["SITnx"][211] = "RequestedConfirmationParty@dom"; 
			arrProductColumn["SITnx"][212] = "RequestedConfirmationParty@iso_code";
			arrProductColumn["SITnx"][213] = "amd_chrg_brn_by_code";
			arrProductColumn["SITnx"][214] = "Narrative@amendCharges";
			arrProductColumn["SITnx"][215] = "Narrative@legacyPartialShipment";
			arrProductColumn["SITnx"][216] = "Narrative@legacyTranShipment";
			arrProductColumn["SITnx"][217] = "Narrative@legacyPeriodOfPresentation";
			arrProductColumn["SITnx"][218] = "Narrative@legacyMaxCreditAmount";
			arrProductColumn["SITnx"][219] = "related_ref_id";
		</xsl:if>
		<!-- Swift 2020 SI Columns -->
		<xsl:choose>	
			<xsl:when test="$swift2019Enabled">
				arrProductColumn["SITnx"][220] = "Narrative@transferDetails";
				arrProductColumn["SITnx"][221] = "Narrative@deliveryTo";
				arrProductColumn["SITnx"][194] = "lc_govern_country";
				arrProductColumn["SITnx"][195] = "lc_govern_text";
				arrProductColumn["SITnx"][196] = "lc_exp_date_type_code";
				arrProductColumn["SITnx"][197] = "delv_org";
				arrProductColumn["SITnx"][198] = "delv_org_text";
				arrProductColumn["SITnx"][199] = "delivery_to";
				arrProductColumn["SITnx"][200] = "exp_event";
		</xsl:when>
		</xsl:choose>
		<xsl:if test="not($swift2018Enabled)">
			arrProductColumn["SITnx"][124] = "Narrative@goodsDesc";
			arrProductColumn["SITnx"][125] = "Narrative@docsRequired";
			arrProductColumn["SITnx"][126] = "Narrative@additionalInstructions";
			arrProductColumn["SITnx"][53] = "max_cr_desc_code";
		</xsl:if>

	</xsl:template>
	
	
	<!--********************-->
	<!-- SI Master columns *-->
	<!--********************-->
	<xsl:template name="SI_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["SI"][201] = "company_name";
		</xsl:if>

		 <xsl:if test="securityCheck:hasCompanyPermission($rundata,'lc_display_po') or $isTemplate='true'">
			arrProductColumn["SI"][202] = "ObjectDataString@po_ref_id";
		</xsl:if> 
		<xsl:if test="$swift2018Enabled">
			arrProductColumn["SI"][205] = "period_presentation_days";
			arrProductColumn["SI"][206] = "req_conf_party_flag";
			arrProductColumn["SI"][207] = "RequestedConfirmationParty@name";
			arrProductColumn["SI"][208] = "RequestedConfirmationParty@address_line_1";
			arrProductColumn["SI"][209] = "RequestedConfirmationParty@address_line_2";
			arrProductColumn["SI"][210] = "RequestedConfirmationParty@dom"; 
			arrProductColumn["SI"][211] = "RequestedConfirmationParty@iso_code";
			arrProductColumn["SI"][212] = "amd_chrg_brn_by_code";
			arrProductColumn["SI"][213] = "Narrative@amendCharges";
			arrProductColumn["SI"][214] = "Narrative@legacyPartialShipment";
			arrProductColumn["SI"][215] = "Narrative@legacyTranShipment";
			arrProductColumn["SI"][216] = "Narrative@legacyPeriodOfPresentation";
			arrProductColumn["SI"][217] = "Narrative@legacyMaxCreditAmount";
		</xsl:if>
		<!-- Swift 2020 SI Columns -->
		<xsl:choose>	
			<xsl:when test="$swift2019Enabled">
				arrProductColumn["SI"][218] = "Narrative@transferDetails";
				arrProductColumn["SI"][219] = "Narrative@deliveryTo";
				arrProductColumn["SI"][192] = "lc_govern_country";
				arrProductColumn["SI"][193] = "lc_govern_text";
				arrProductColumn["SI"][194] = "lc_exp_date_type_code";
				arrProductColumn["SI"][195] = "delv_org";
				arrProductColumn["SI"][196] = "delv_org_text";
				arrProductColumn["SI"][197] = "delivery_to";
				arrProductColumn["SI"][198] = "exp_event";
				
			</xsl:when>
		</xsl:choose>
		<xsl:if test="not($swift2018Enabled)">
			arrProductColumn["SI"][114] = "Narrative@goodsDesc";
			arrProductColumn["SI"][115] = "Narrative@docsRequired";
			arrProductColumn["SI"][116] = "Narrative@additionalInstructions";
			arrProductColumn["SI"][53] = "max_cr_desc_code";
		</xsl:if>
		<xsl:if test="securityCheck:hasCompanyPermission($rundata,'si_display_po_reference') and defaultresource:getResource('PURCHASE_ORDER_REFERENCE_ENABLED') = 'true'">
		arrProductColumn["SI"][176]= "ObjectDataString@purchase_order";
		</xsl:if>
	</xsl:template>


	<!--**********************-->
	<!-- SI Template columns *-->
	<!--**********************-->
	<xsl:template name="SITemplate_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata)and $isTemplate!='true'">
			arrProductColumn["SITemplate"][113] = "company_name";
		</xsl:if>

		<xsl:if test="securityCheck:hasCompanyPermission($rundata,'lc_display_po') or $isTemplate='true'">
			arrProductColumn["SITemplate"][202] = "ObjectDataString@po_ref_id";
		</xsl:if>

	</xsl:template>


	<!--*************************-->
	<!-- SR Transaction columns *-->
	<!--*************************-->
	<xsl:template name="SRTnx_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["SRTnx"][160] = "company_name";
			arrProductColumn["SRTnx"][161] = "BOInputter@last_name";
			arrProductColumn["SRTnx"][162] = "BOInputter@first_name";
			arrProductColumn["SRTnx"][163] = "bo_inp_dttm";
			arrProductColumn["SRTnx"][164] = "BOController@last_name";
			arrProductColumn["SRTnx"][165] = "BOController@first_name";
			arrProductColumn["SRTnx"][166] = "bo_ctl_dttm";
			arrProductColumn["SRTnx"][167] = "BOReleaser@last_name";
			arrProductColumn["SRTnx"][168] = "BOReleaser@first_name";
		</xsl:if>
		<xsl:if test="$swift2018Enabled">
			arrProductColumn["SRTnx"][171] = "RequestedConfirmationParty@name";
			arrProductColumn["SRTnx"][172] = "RequestedConfirmationParty@address_line_1";
			arrProductColumn["SRTnx"][173] = "RequestedConfirmationParty@address_line_2";
			arrProductColumn["SRTnx"][174] = "RequestedConfirmationParty@dom";
			arrProductColumn["SRTnx"][175] = "RequestedConfirmationParty@iso_code";
			arrProductColumn["SRTnx"][176] = "period_presentation_days"; 
			arrProductColumn["SRTnx"][177] = "req_conf_party_flag";
			arrProductColumn["SRTnx"][178] = "amd_chrg_brn_by_code";
			arrProductColumn["SRTnx"][179] = "Narrative@amendCharges";
			arrProductColumn["SRTnx"][182] = "Narrative@legacyPartialShipment";
			arrProductColumn["SRTnx"][183] = "Narrative@legacyTranShipment";
			arrProductColumn["SRTnx"][184] = "Narrative@legacyPeriodOfPresentation";
			arrProductColumn["SRTnx"][186] = "Narrative@legacyMaxCreditAmount";
		</xsl:if>
		<xsl:if test="not($swift2018Enabled)">
			arrProductColumn["SRTnx"][104] = "Narrative@goodsDesc";
			arrProductColumn["SRTnx"][105] = "Narrative@docsRequired";
			arrProductColumn["SRTnx"][106] = "Narrative@additionalInstructions";
			arrProductColumn["SRTnx"][53] = "max_cr_desc_code";
		</xsl:if>
		
		<xsl:if test="$swift2019Enabled">
		arrProductColumn["SRTnx"][220] = "Narrative@transferDetails";
				arrProductColumn["SRTnx"][221] = "Narrative@deliveryTo";
				arrProductColumn["SRTnx"][194] = "lc_govern_country";
				arrProductColumn["SRTnx"][195] = "lc_govern_text";
				arrProductColumn["SRTnx"][196] = "lc_exp_date_type_code";
				arrProductColumn["SRTnx"][197] = "delv_org";
				arrProductColumn["SRTnx"][198] = "delv_org_text";
				arrProductColumn["SRTnx"][199] = "delivery_to";
				arrProductColumn["SRTnx"][200] = "exp_event";
		</xsl:if>
		arrProductColumn["SRTnx"][180] = "Narrative@senderToReceiver";
		arrProductColumn["SRTnx"][181] = "Narrative@paymentInstructions";
		arrProductColumn["SRTnx"][185] = "Narrative@additionalAmount";

	</xsl:template>


	<!--********************-->
	<!-- SR Master columns *-->
	<!--********************-->
	<xsl:template name="SR_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["SR"][120] = "company_name";
		</xsl:if>
		<xsl:if test="$swift2018Enabled">
			arrProductColumn["SR"][133] = "RequestedConfirmationParty@name";
			arrProductColumn["SR"][134] = "RequestedConfirmationParty@address_line_1";
			arrProductColumn["SR"][135] = "RequestedConfirmationParty@address_line_2";
			arrProductColumn["SR"][136] = "RequestedConfirmationParty@dom";
			arrProductColumn["SR"][137] = "RequestedConfirmationParty@iso_code";
			arrProductColumn["SR"][138] = "period_presentation_days"; 
			arrProductColumn["SR"][139] = "req_conf_party_flag";
			arrProductColumn["SR"][140] = "amd_chrg_brn_by_code";
			arrProductColumn["SR"][141] = "Narrative@amendCharges";
			arrProductColumn["SR"][144] = "Narrative@legacyPartialShipment";
			arrProductColumn["SR"][145] = "Narrative@legacyTranShipment";
			arrProductColumn["SR"][146] = "Narrative@legacyPeriodOfPresentation";
			arrProductColumn["SR"][148] = "Narrative@legacyMaxCreditAmount";
		</xsl:if>
		<xsl:if test="not($swift2018Enabled)">
			arrProductColumn["SR"][104] = "Narrative@goodsDesc";
			arrProductColumn["SR"][105] = "Narrative@docsRequired";
			arrProductColumn["SR"][106] = "Narrative@additionalInstructions";
			arrProductColumn["SR"][53] = "max_cr_desc_code";
		</xsl:if>
		<xsl:if test="$swift2019Enabled">
				arrProductColumn["SR"][218] = "Narrative@transferDetails";
				arrProductColumn["SR"][219] = "Narrative@deliveryTo";
				arrProductColumn["SR"][192] = "lc_govern_country";
				arrProductColumn["SR"][193] = "lc_govern_text";
				arrProductColumn["SR"][194] = "lc_exp_date_type_code";
				arrProductColumn["SR"][195] = "delv_org";
				arrProductColumn["SR"][196] = "delv_org_text";
				arrProductColumn["SR"][197] = "delivery_to";
				arrProductColumn["SR"][198] = "exp_event";
		</xsl:if>
		arrProductColumn["SR"][142] = "Narrative@senderToReceiver";
		arrProductColumn["SR"][143] = "Narrative@paymentInstructions";
		arrProductColumn["SR"][147] = "Narrative@additionalAmount";
	</xsl:template>
	

	<!--*************************-->
	<!-- LI Transaction columns *-->
	<!--*************************-->
	<xsl:template name="LITnx_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
      		arrProductColumn["LITnx"][17] = "tnx_stat_code";
			arrProductColumn["LITnx"][150] = "company_name";
			arrProductColumn["LITnx"][151] = "BOInputter@last_name";
			arrProductColumn["LITnx"][152] = "BOInputter@first_name";
			arrProductColumn["LITnx"][153] = "bo_inp_dttm";
			arrProductColumn["LITnx"][154] = "BOController@last_name";
			arrProductColumn["LITnx"][155] = "BOController@first_name";
			arrProductColumn["LITnx"][156] = "bo_ctl_dttm";
			arrProductColumn["LITnx"][157] = "BOReleaser@last_name";
			arrProductColumn["LITnx"][158] = "BOReleaser@first_name";
		</xsl:if>
		
	</xsl:template>


	<!--********************-->
	<!-- LI Master columns *-->
	<!--********************-->
	<xsl:template name="LI_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["LI"][120] = "company_name";
		</xsl:if>
	</xsl:template>


	<!--*************************-->
	<!-- PO Transaction columns *-->
	<!--*************************-->
	<xsl:template name="POTnx_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["POTnx"][17] = "tnx_stat_code";
			arrProductColumn["POTnx"][150] = "company_name";
			arrProductColumn["POTnx"][151] = "BOInputter@last_name";
			arrProductColumn["POTnx"][152] = "BOInputter@first_name";
			arrProductColumn["POTnx"][153] = "bo_inp_dttm";
			arrProductColumn["POTnx"][154] = "BOController@last_name";
			arrProductColumn["POTnx"][155] = "BOController@first_name";
			arrProductColumn["POTnx"][156] = "bo_ctl_dttm";
			arrProductColumn["POTnx"][157] = "BOReleaser@last_name";
			arrProductColumn["POTnx"][158] = "BOReleaser@first_name";
		</xsl:if>

	</xsl:template>
	
	
	<!--********************-->
	<!-- PO Master columns *-->
	<!--********************-->
	<xsl:template name="PO_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["PO"][120] = "company_name";
		</xsl:if>

	</xsl:template>
	
	<!--*************************-->
	<!-- IO Transaction columns *-->
	<!--*************************-->
	<xsl:template name="IOTnx_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["IOTnx"][17] = "tnx_stat_code";
			arrProductColumn["IOTnx"][150] = "company_name";
			arrProductColumn["IOTnx"][151] = "BOInputter@last_name";
			arrProductColumn["IOTnx"][152] = "BOInputter@first_name";
			arrProductColumn["IOTnx"][153] = "bo_inp_dttm";
			arrProductColumn["IOTnx"][154] = "BOController@last_name";
			arrProductColumn["IOTnx"][155] = "BOController@first_name";
			arrProductColumn["IOTnx"][156] = "bo_ctl_dttm";
			arrProductColumn["IOTnx"][157] = "BOReleaser@last_name";
			arrProductColumn["IOTnx"][158] = "BOReleaser@first_name";
		</xsl:if>

	</xsl:template>
	
	
	<!--********************-->
	<!-- IO Master columns *-->
	<!--********************-->
	<xsl:template name="IO_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["IO"][120] = "company_name";
		</xsl:if>

	</xsl:template>
	
	<!--*************************-->
	<!-- EA Transaction columns *-->
	<!--*************************-->
	<xsl:template name="EATnx_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["EATnx"][17] = "tnx_stat_code";
			arrProductColumn["EATnx"][150] = "company_name";
			arrProductColumn["EATnx"][151] = "BOInputter@last_name";
			arrProductColumn["EATnx"][152] = "BOInputter@first_name";
			arrProductColumn["EATnx"][153] = "bo_inp_dttm";
			arrProductColumn["EATnx"][154] = "BOController@last_name";
			arrProductColumn["EATnx"][155] = "BOController@first_name";
			arrProductColumn["EATnx"][156] = "bo_ctl_dttm";
			arrProductColumn["EATnx"][157] = "BOReleaser@last_name";
			arrProductColumn["EATnx"][158] = "BOReleaser@first_name";
		</xsl:if>

	</xsl:template>
	
	<!--********************-->
	<!-- EA Master columns *-->
	<!--********************-->
	<xsl:template name="EA_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["EA"][120] = "company_name";
		</xsl:if>

	</xsl:template>


	<!--**********************-->
	<!-- PO Template columns *-->
	<!--**********************-->
	<xsl:template name="POTemplate_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata)and $isTemplate!='true'">
			arrProductColumn["POTemplate"][113] = "company_name";
		</xsl:if>

	</xsl:template>
	
	<!--*************************-->
	<!-- IN Transaction columns *-->
	<!--*************************-->
	<xsl:template name="INTnx_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["INTnx"][17] = "tnx_stat_code";
			arrProductColumn["INTnx"][150] = "company_name";
			arrProductColumn["INTnx"][151] = "BOInputter@last_name";
			arrProductColumn["INTnx"][152] = "BOInputter@first_name";
			arrProductColumn["INTnx"][153] = "bo_inp_dttm";
			arrProductColumn["INTnx"][154] = "BOController@last_name";
			arrProductColumn["INTnx"][155] = "BOController@first_name";
			arrProductColumn["INTnx"][156] = "bo_ctl_dttm";
			arrProductColumn["INTnx"][157] = "BOReleaser@last_name";
			arrProductColumn["INTnx"][158] = "BOReleaser@first_name";
		</xsl:if>

	</xsl:template>
	
	
	<!--********************-->
	<!-- IN Master columns *-->
	<!--********************-->
	<xsl:template name="IN_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["IN"][120] = "company_name";
		</xsl:if>

	</xsl:template>
		
	<!--*************************-->
	<!-- IP Transaction columns *-->
	<!--*************************-->
	<xsl:template name="IPTnx_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["IPTnx"][150] = "company_name";
			arrProductColumn["IPTnx"][151] = "BOInputter@last_name";
			arrProductColumn["IPTnx"][152] = "BOInputter@first_name";
			arrProductColumn["IPTnx"][153] = "bo_inp_dttm";
			arrProductColumn["IPTnx"][154] = "BOController@last_name";
			arrProductColumn["IPTnx"][155] = "BOController@first_name";
			arrProductColumn["IPTnx"][156] = "bo_ctl_dttm";
			arrProductColumn["IPTnx"][157] = "BOReleaser@last_name";
			arrProductColumn["IPTnx"][158] = "BOReleaser@first_name";
		</xsl:if>
		
	</xsl:template>
		
	<!--********************-->
	<!-- IP Master columns *-->
	<!--********************-->
	<xsl:template name="IP_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["IP"][120] = "company_name";
		</xsl:if>

	</xsl:template>

	<!--*************************-->
	<!-- LT Transaction columns *-->
	<!--*************************-->
	<xsl:template name="LTTnx_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["LTTnx"][17] = "tnx_stat_code";
			arrProductColumn["LTTnx"][150] = "company_name";
			arrProductColumn["LTTnx"][151] = "BOInputter@last_name";
			arrProductColumn["LTTnx"][152] = "BOInputter@first_name";
			arrProductColumn["LTTnx"][153] = "bo_inp_dttm";
			arrProductColumn["LTTnx"][154] = "BOController@last_name";
			arrProductColumn["LTTnx"][155] = "BOController@first_name";
			arrProductColumn["LTTnx"][156] = "bo_ctl_dttm";
			arrProductColumn["LTTnx"][157] = "BOReleaser@last_name";
			arrProductColumn["LTTnx"][158] = "BOReleaser@first_name";
		</xsl:if>

	</xsl:template>
	
	
	<!--********************-->
	<!-- LT Master columns *-->
	<!--********************-->
	<xsl:template name="LT_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["LT"][120] = "company_name";
		</xsl:if>

	</xsl:template>


	<!--**********************-->
	<!-- LT Template columns *-->
	<!--**********************-->
	<xsl:template name="LTTemplate_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata)and $isTemplate!='true'">
			arrProductColumn["LTTemplate"][113] = "company_name";
		</xsl:if>

	</xsl:template>


	<!--*************************-->
	<!-- SO Transaction columns *-->
	<!--*************************-->
	<xsl:template name="SOTnx_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["SOTnx"][17] = "tnx_stat_code";
			arrProductColumn["SOTnx"][150] = "company_name";
			arrProductColumn["SOTnx"][151] = "BOInputter@last_name";
			arrProductColumn["SOTnx"][152] = "BOInputter@first_name";
			arrProductColumn["SOTnx"][153] = "bo_inp_dttm";
			arrProductColumn["SOTnx"][154] = "BOController@last_name";
			arrProductColumn["SOTnx"][155] = "BOController@first_name";
			arrProductColumn["SOTnx"][156] = "bo_ctl_dttm";
			arrProductColumn["SOTnx"][157] = "BOReleaser@last_name";
			arrProductColumn["SOTnx"][158] = "BOReleaser@first_name";
		</xsl:if>

	</xsl:template>


	<!--********************-->
	<!-- SO Master columns *-->
	<!--********************-->
	<xsl:template name="SO_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["SO"][120] = "company_name";
		</xsl:if>
	</xsl:template>
	
	<!--*************************-->
	<!-- TU Transaction columns *-->
	<!--*************************-->
	<xsl:template name="TUTnx_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
      	arrProductColumn["TUTnx"][17] = "tnx_stat_code";
			arrProductColumn["TUTnx"][150] = "company_name";
			arrProductColumn["TUTnx"][151] = "BOInputter@last_name";
			arrProductColumn["TUTnx"][152] = "BOInputter@first_name";
			arrProductColumn["TUTnx"][153] = "bo_inp_dttm";
			arrProductColumn["TUTnx"][154] = "BOController@last_name";
			arrProductColumn["TUTnx"][155] = "BOController@first_name";
			arrProductColumn["TUTnx"][156] = "bo_ctl_dttm";
			arrProductColumn["TUTnx"][157] = "BOReleaser@last_name";
			arrProductColumn["TUTnx"][158] = "BOReleaser@first_name";
		</xsl:if>

		<!-- Object Data -->
		
	</xsl:template>
	

	<!--********************-->
	<!-- TU Master columns *-->
	<!--********************-->
	<xsl:template name="TU_Columns">
		<xsl:param name="isTemplate"/>
		
		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata)and $isTemplate!='true'">
			arrProductColumn["TU"][120] = "company_name";
		</xsl:if>
		
		<!-- Object Data -->
		
	</xsl:template>
	
	<!--********************-->
	<!-- BN Master columns *-->
	<!--********************-->
	<xsl:template name="BN_Columns">
		<xsl:param name="isTemplate"/>
		
		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata)and $isTemplate!='true'">
			arrProductColumn["BN"][120] = "company_name";
		</xsl:if>
		
		<!-- Object Data -->
		
	</xsl:template>
	
	
	<!--*************************-->
	<!-- FX Transaction columns *-->
	<!--*************************-->
	<xsl:template name="FXTnx_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["FXTnx"][17] = "tnx_stat_code";
			arrProductColumn["FXTnx"][150] = "company_name";
			arrProductColumn["FXTnx"][151] = "BOInputter@last_name";
			arrProductColumn["FXTnx"][152] = "BOInputter@first_name";
			arrProductColumn["FXTnx"][153] = "bo_inp_dttm";
			arrProductColumn["FXTnx"][154] = "BOController@last_name";
			arrProductColumn["FXTnx"][155] = "BOController@first_name";
			arrProductColumn["FXTnx"][156] = "bo_ctl_dttm";
			arrProductColumn["FXTnx"][157] = "BOReleaser@last_name";
			arrProductColumn["FXTnx"][158] = "BOReleaser@first_name";
		</xsl:if>

	</xsl:template>

	<!--********************-->
	<!-- FX Master columns *-->
	<!--********************-->
	<xsl:template name="FX_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["FX"][120] = "company_name";
		</xsl:if>
	</xsl:template>

	
	<!--*************************-->
	<!-- LN Transaction columns *-->
	<!--*************************-->
	<xsl:template name="LNTnx_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["LNTnx"][17]  = "tnx_stat_code";
			arrProductColumn["LNTnx"][150] = "company_name";
			arrProductColumn["LNTnx"][151] = "BOInputter@last_name";
			arrProductColumn["LNTnx"][152] = "BOInputter@first_name";
			arrProductColumn["LNTnx"][153] = "bo_inp_dttm";
			arrProductColumn["LNTnx"][154] = "BOController@last_name";
			arrProductColumn["LNTnx"][155] = "BOController@first_name";
			arrProductColumn["LNTnx"][156] = "bo_ctl_dttm";
			arrProductColumn["LNTnx"][157] = "BOReleaser@last_name";
			arrProductColumn["LNTnx"][158] = "BOReleaser@first_name";
		</xsl:if>

	</xsl:template>

	<!--********************-->
	<!-- LN Master columns *-->
	<!--********************-->
	<xsl:template name="LN_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["LN"][120] = "company_name";
		</xsl:if>
	</xsl:template>
		
	<!--*************************-->
	<!-- TD Transaction columns *-->
	<!--*************************-->
	<xsl:template name="TDTnx_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["TDTnx"][150] = "company_name";
			arrProductColumn["TDTnx"][151] = "BOInputter@last_name";
			arrProductColumn["TDTnx"][152] = "BOInputter@first_name";
			arrProductColumn["TDTnx"][154] = "BOController@last_name";
			arrProductColumn["TDTnx"][155] = "BOController@first_name";
			arrProductColumn["TDTnx"][156] = "bo_ctl_dttm";
			arrProductColumn["TDTnx"][157] = "BOReleaser@last_name";
			arrProductColumn["TDTnx"][158] = "BOReleaser@first_name";
			
			
			arrProductCriteriaColumn["TDTnx"][151] = "BOInputter@last_name";
			arrProductCriteriaColumn["TDTnx"][152] = "BOInputter@first_name";
			arrProductCriteriaColumn["TDTnx"][154] = "BOController@last_name";
			arrProductCriteriaColumn["TDTnx"][155] = "BOController@first_name";
			arrProductCriteriaColumn["TDTnx"][156] = "bo_ctl_dttm";
			arrProductCriteriaColumn["TDTnx"][157] = "BOReleaser@last_name";
			arrProductCriteriaColumn["TDTnx"][158] = "BOReleaser@first_name";
			
			
			arrProductCriteriaColumn["TDTnx"][100] = "company_name";
			arrProductGroupColumn["TDTnx"][100] = "company_name";
			arrProductChartXAxisColumn["TDTnx"][100] = "company_name";
			arrProductAggregateColumn["TDTnx"][100] = "company_name";
		</xsl:if>
		
		
		<xsl:if test="securityCheck:hasEntities($rundata)">
			arrProductColumn["TDTnx"][159] = "entity";
		</xsl:if>

	</xsl:template>

	<!--********************-->
	<!-- TD Master columns *-->
	<!--********************-->
	<xsl:template name="TD_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["TD"][120] = "company_name";
			arrProductCriteriaColumn["TD"][100] = "company_name";
			arrProductGroupColumn["TD"][100] = "company_name";
			arrProductChartXAxisColumn["TD"][100] = "company_name";
			arrProductAggregateColumn["TD"][100] = "company_name";
		</xsl:if>
		
		<xsl:if test="securityCheck:hasEntities($rundata)">
			arrProductColumn["TD"][121] = "entity";
		</xsl:if>
		
	</xsl:template>
	
	<!--*************************-->
	<!-- LA Transaction columns *-->
	<!--*************************-->
	<xsl:template name="LATnx_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["LATnx"][17] = "tnx_stat_code";
			arrProductColumn["LATnx"][150] = "company_name";
			arrProductColumn["LATnx"][151] = "BOInputter@last_name";
			arrProductColumn["LATnx"][152] = "BOInputter@first_name";
			arrProductColumn["LATnx"][153] = "bo_inp_dttm";
			arrProductColumn["LATnx"][154] = "BOController@last_name";
			arrProductColumn["LATnx"][155] = "BOController@first_name";
			arrProductColumn["LATnx"][156] = "bo_ctl_dttm";
			arrProductColumn["LATnx"][157] = "BOReleaser@last_name";
			arrProductColumn["LATnx"][158] = "BOReleaser@first_name";
		</xsl:if>

	</xsl:template>

	<!--********************-->
	<!-- LA Master columns *-->
	<!--********************-->
	<xsl:template name="LA_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["LA"][120] = "company_name";
		</xsl:if>
	</xsl:template>
	
	
	
	<!--*************************-->
	<!-- SP Transaction columns *-->
	<!--*************************-->
	<xsl:template name="SPTnx_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["SPTnx"][17] = "tnx_stat_code";
			arrProductColumn["SPTnx"][150] = "company_name";
			arrProductColumn["SPTnx"][151] = "BOInputter@last_name";
			arrProductColumn["SPTnx"][152] = "BOInputter@first_name";
			arrProductColumn["SPTnx"][153] = "bo_inp_dttm";
			arrProductColumn["SPTnx"][154] = "BOController@last_name";
			arrProductColumn["SPTnx"][155] = "BOController@first_name";
			arrProductColumn["SPTnx"][156] = "bo_ctl_dttm";
			arrProductColumn["SPTnx"][157] = "BOReleaser@last_name";
			arrProductColumn["SPTnx"][158] = "BOReleaser@first_name";
		</xsl:if>

	</xsl:template>

	<!--********************-->
	<!-- SP Master columns *-->
	<!--********************-->
	<xsl:template name="SP_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["SP"][120] = "company_name";
		</xsl:if>
	</xsl:template>
	
	<!--*************************-->
	<!-- CN Transaction columns *-->
	<!--*************************-->
	<xsl:template name="CNTnx_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["CNTnx"][17] = "tnx_stat_code";
			arrProductColumn["CNTnx"][150] = "company_name";
		</xsl:if>

	</xsl:template>
	
	
	<!--********************-->
	<!-- CN Master columns *-->
	<!--********************-->
	<xsl:template name="CN_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["CN"][120] = "company_name";
		</xsl:if>

	</xsl:template>


	<!--**********************-->
	<!-- CN Template columns *-->
	<!--**********************-->
	<xsl:template name="CNTemplate_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata)and $isTemplate!='true'">
			arrProductColumn["CNTemplate"][113] = "company_name";
		</xsl:if>

	</xsl:template>
	
	<!--*************************-->
	<!-- CR Transaction columns *-->
	<!--*************************-->
	<xsl:template name="CRTnx_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["CRTnx"][17] = "tnx_stat_code";
			arrProductColumn["CRTnx"][150] = "company_name";
		</xsl:if>

	</xsl:template>
	
	
	<!--********************-->
	<!-- CR Master columns *-->
	<!--********************-->
	<xsl:template name="CR_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata) and $isTemplate!='true'">
			arrProductColumn["CR"][120] = "company_name";
		</xsl:if>

	</xsl:template>


	<!--**********************-->
	<!-- CR Template columns *-->
	<!--**********************-->
	<xsl:template name="CRTemplate_Columns">
		<xsl:param name="isTemplate"/>

		<!-- Bank only -->
		<xsl:if test="security:isBank($rundata)and $isTemplate!='true'">
			arrProductColumn["CRTemplate"][113] = "company_name";
		</xsl:if>

	</xsl:template>
	
	<!--*************************************************************************-->
	<!-- Template used that returns the localized description of a business code -->
	<!--*************************************************************************-->
	<xsl:template name="Column_Value_Description">
		<xsl:param name="columnName"></xsl:param>
		<xsl:param name="columnValue"></xsl:param><!--  UNUSED ... -->
		<xsl:param name="prefix"><xsl:value-of select="business_codes:getCode($columnName)"/></xsl:param>
		
		<xsl:value-of select="localization:getDecode($language, $prefix, $columnValue)"/>
			
		<!-- Add specific columns processing -->
		<xsl:call-template name="Specific_Column_Value_Description">
			<xsl:with-param name="columnName"></xsl:with-param>
			<xsl:with-param name="columnValue"></xsl:with-param>
		</xsl:call-template>

	</xsl:template>

	<!--*************************************************************************-->
	<!-- Template that returns the product description based on the candidate    -->
	<!--*************************************************************************-->
	<xsl:template name="PRODUCT_DESCRIPTION">
		<xsl:choose>
			<xsl:when test="./@name = 'LCTnx'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LC_TNX')"/>
			</xsl:when>
			<xsl:when test="./@name = 'LC'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LC')"/>
			</xsl:when>
			<xsl:when test="./@name = 'LCTemplate'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LC_TEMPLATE')"/>
			</xsl:when>
			
			<xsl:when test="./@name = 'LSTnx'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LS_TNX')"/>
			</xsl:when>
			<xsl:when test="./@name = 'LS'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LS')"/>
			</xsl:when>
			<xsl:when test="./@name = 'LSTemplate'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LS_TEMPLATE')"/>
			</xsl:when>
			
			<xsl:when test="./@name = 'RITnx'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_RI_TNX')"/>
			</xsl:when>
			<xsl:when test="./@name = 'RI'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_RI')"/>
			</xsl:when>
			<xsl:when test="./@name = 'RITemplate'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_RI_TEMPLATE')"/>
			</xsl:when>
			<xsl:when test="./@name = 'SETnx'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SE_TNX')"/>
			</xsl:when>
			<xsl:when test="./@name = 'SE'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SE')"/>
			</xsl:when>
			<xsl:when test="./@name = 'SETemplate'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SE_TEMPLATE')"/>
			</xsl:when>
			<xsl:when test="./@name = 'EL'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EL')"/>
			</xsl:when>
			<xsl:when test="./@name = 'ELTnx'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EL_TNX')"/>
			</xsl:when>
			<xsl:when test="./@name = 'SI'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SI')"/>
			</xsl:when>
			<xsl:when test="./@name = 'SITnx'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SI_TNX')"/>
			</xsl:when>
			<xsl:when test="./@name = 'SITemplate'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SI_TEMPLATE')"/>
			</xsl:when>
			<xsl:when test="./@name = 'SR'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SR')"/>
			</xsl:when>
			<xsl:when test="./@name = 'SRTnx'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SR_TNX')"/>
			</xsl:when>
			<xsl:when test="./@name = 'SG'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SG')"/>
			</xsl:when>
			<xsl:when test="./@name = 'SGTnx'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SG_TNX')"/>
			</xsl:when>
			<xsl:when test="./@name = 'TF'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_TF')"/>
			</xsl:when>
			<xsl:when test="./@name = 'TFTnx'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_TF_TNX')"/>
			</xsl:when>
			<xsl:when test="./@name = 'FA'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FA')"/>
			</xsl:when>
			<xsl:when test="./@name = 'FATnx'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FA_TNX')"/>
			</xsl:when>
			<xsl:when test="./@name = 'BGTnx'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BG_TNX')"/>
			</xsl:when>
			<xsl:when test="./@name = 'BG'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BG')"/>
			</xsl:when>
			<xsl:when test="./@name = 'BGTemplate'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BG_TEMPLATE')"/>
			</xsl:when>
			<xsl:when test="./@name = 'BRTnx'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BR_TNX')"/>
			</xsl:when>
			<xsl:when test="./@name = 'BR'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BR')"/>
			</xsl:when>
			<xsl:when test="./@name = 'BKTnx'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BK_TNX')"/>
			</xsl:when>
			<xsl:when test="./@name = 'BK'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BK')"/>
			</xsl:when>
			<xsl:when test="./@name = 'ECTnx'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EC_TNX')"/>
			</xsl:when>
			<xsl:when test="./@name = 'EC'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EC')"/>
			</xsl:when>
			<xsl:when test="./@name = 'ECTemplate'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EC_TEMPLATE')"/>
			</xsl:when>
			<xsl:when test="./@name = 'IC'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IC')"/>
			</xsl:when>
			<xsl:when test="./@name = 'ICTnx'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IC_TNX')"/>
			</xsl:when>
			<xsl:when test="./@name = 'IR'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IR')"/>
			</xsl:when>
			<xsl:when test="./@name = 'IRTnx'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IR_TNX')"/>
			</xsl:when>
			<xsl:when test="./@name = 'FT'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FT')"/>
			</xsl:when>
			<xsl:when test="./@name = 'FTTnx'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FT_TNX')"/>
			</xsl:when>
			<xsl:when test="./@name = 'FTTemplate'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FT_TEMPLATE')"/>
			</xsl:when>
			<xsl:when test="./@name = 'LI'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LI')"/>
			</xsl:when>
			<xsl:when test="./@name = 'LITnx'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LI_TNX')"/>
			</xsl:when>
			<xsl:when test="./@name = 'TU'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_TU')"/>
			</xsl:when>
			<xsl:when test="./@name = 'TUTnx'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_TU_TNX')"/>
			</xsl:when>
			<xsl:when test="./@name = 'BN'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BN')"/>
			</xsl:when>
			<xsl:when test="./@name = 'Audit'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_AUDIT')"/>
			</xsl:when>
			<xsl:when test="./@name = 'POTnx'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_PO_TNX')"/>
			</xsl:when>
			<xsl:when test="./@name = 'PO'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_PO')"/>
			</xsl:when>
			<xsl:when test="./@name = 'POTemplate'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_PO_TEMPLATE')"/>
			</xsl:when>
			<xsl:when test="./@name = 'IOTnx'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IO_TNX')"/>
			</xsl:when>
			<xsl:when test="./@name = 'IO'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IO')"/>
			</xsl:when>
			<xsl:when test="./@name = 'EATnx'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EA_TNX')"/>
			</xsl:when>
			<xsl:when test="./@name = 'EA'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EA')"/>
			</xsl:when>
			<xsl:when test="./@name = 'INTnx'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IN_TNX')"/>
			</xsl:when>
			<xsl:when test="./@name = 'IN'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IN')"/>
			</xsl:when>
			<xsl:when test="./@name = 'IPTnx'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IP_TNX')"/>
			</xsl:when>
			<xsl:when test="./@name = 'IP'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_IP')"/>
			</xsl:when>
			<xsl:when test="./@name = 'SOTnx'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SO_TNX')"/>
			</xsl:when>
			<xsl:when test="./@name = 'SO'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SO')"/>
			</xsl:when>	
			<xsl:when test="./@name = 'LTTnx'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LT_TNX')"/>
			</xsl:when>
			<xsl:when test="./@name = 'LT'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LT')"/>
			</xsl:when>
			<xsl:when test="./@name = 'LTTemplate'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LT_TEMPLATE')"/>
			</xsl:when>
			<xsl:when test="./@name = 'FXTnx'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FX_TNX')"/>
			</xsl:when>
			<xsl:when test="./@name = 'FX'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FX')"/>
			</xsl:when>
			<xsl:when test="./@name = 'LN'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LN')"/>
			</xsl:when>
			<xsl:when test="./@name = 'TDTnx'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_TD_TNX')"/>
			</xsl:when>
			<xsl:when test="./@name = 'TD'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_TD')"/>
			</xsl:when>
			<xsl:when test="./@name = 'CN'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CN')"/>
			</xsl:when>
			<xsl:when test="./@name = 'CNTemplate'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CN_TEMPLATE')"/>
			</xsl:when>
			<xsl:when test="./@name = 'CNTnx'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CN_TNX')"/>
			</xsl:when>
			<xsl:when test="./@name = 'CR'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CR')"/>
			</xsl:when>
			<xsl:when test="./@name = 'CRTemplate'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CR_TEMPLATE')"/>
			</xsl:when>
			<xsl:when test="./@name = 'CRTnx'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CR_TNX')"/>
			</xsl:when>
			<xsl:when test="./@name = 'AccountStatementLine'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_ACCOUNT_STATEMENT_LINE')"/>
			</xsl:when>	
			<xsl:when test="./@name = 'CompanyRolePermission'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COMPANY_ENTITY_USER_ROLE')"/>
			</xsl:when>
			<xsl:when test="./@name = 'FacilityLimitMaintenance'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FACILITY_LIMIT_MAINTENANCE')"/>
			</xsl:when>	
			<xsl:when test="./@name = 'AccountStatement'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_ACCOUNT_STATEMENT')"/>
			</xsl:when>	
			<xsl:when test="./@name = 'UserProfile'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_USER')"/>
			</xsl:when>
			<xsl:when test="./@name = 'CompanyProfile'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COMPANY_ENTITY')"/>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	
  
	<xsl:template name="Columns_Definitions">
    <xsl:param name="isTemplate"/>
    
		//
		// Definition of columns
		//
		
		// Translated (cross product) columns
		
		arrColumn["FundTransfer@ref_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_FundTransfer@ref_id')"/>");
		arrColumn["FundTransfer@tnx_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_FundTransfer@tnx_id')"/>");
		arrColumn["FundTransfer@ft_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_FundTransfer@ft_amt')"/>");
		arrColumn["FundTransfer@Counterparty@counterparty_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_FundTransfer@Counterparty@counterparty_name')"/>");
		arrColumn["FundTransfer@Counterparty@counterparty_act_no"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_FundTransfer@Counterparty@counterparty_act_no')"/>");
		arrColumn["FundTransfer@Counterparty@cpty_bank_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_FundTransfer@Counterparty@cpty_bank_name')"/>");
		arrColumn["FundTransfer@Counterparty@counterparty_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_FundTransfer@Counterparty@counterparty_cur_code')"/>");
		arrColumn["FundTransfer@Counterparty@cpty_bank_swift_bic_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_FundTransfer@Counterparty@cpty_bank_swift_bic_code')"/>");
		arrColumn["cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cur_code')"/>", "Currency");
		arrColumn["amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_amt')"/>");
		arrColumn["liab_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_liab_amt')"/>");
		arrColumn["outstanding_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_outstanding_amt')"/>");
		arrColumn["customer_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_customer_name')"/>");
		arrColumn["customer_address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_customer_address_line_1')"/>");
		arrColumn["customer_address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_customer_address_line_2')"/>");
		arrColumn["customer_dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_customer_dom')"/>");
		arrColumn["customer_reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_customer_reference')"/>");
		arrColumn["counterparty_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_counterparty_name')"/>");
		arrColumn["counterparty_address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_counterparty_address_line_1')"/>");
		arrColumn["counterparty_address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_counterparty_address_line_2')"/>");
		arrColumn["counterparty_dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_counterparty_dom')"/>");
		//arrColumn["counterparty_country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_counterparty_country')"/>");
		arrColumn["counterparty_reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_counterparty_reference')"/>");
		arrColumn["MainBank@name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_MainBank@name')"/>");
		arrColumn["MainBank@address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_MainBank@address_line_1')"/>");
		arrColumn["MainBank@address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_MainBank@address_line_2')"/>");
		arrColumn["MainBank@dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_MainBank@dom')"/>");
		<!-- Swift 2020 SI Columns -->
		<xsl:choose>	
			<xsl:when test="$swift2019Enabled">
				arrColumn["lc_govern_country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_lc_govern_country')"/>");
				arrColumn["lc_govern_text"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_lc_govern_text')"/>");
				arrColumn["lc_exp_date_type_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_lc_exp_date_type_code')"/>");
				arrColumn["delv_org"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_delv_org')"/>");
				arrColumn["delv_org_text"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_delv_org_text')"/>");
				arrColumn["delivery_to"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_delivery_to')"/>");
				arrColumn["exp_event"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_exp_event')"/>");
				arrColumn["demand_indicator"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_demand_indicator')"/>");
			</xsl:when>
		</xsl:choose>
		// Other
		arrColumn["ref_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ref_id')"/>");
		arrColumn["entity"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_entity')"/>");
		arrColumn["product_type"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_product_type')"/>");
		arrColumn["product_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_product_code')"/>");
		arrColumn["template_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_template_id')"/>");
		arrColumn["template_description"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_template_description')"/>");
		arrColumn["bo_ref_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bo_ref_id')"/>");
		arrColumn["fin_bo_ref_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_fin_bo_ref_id')"/>");
		arrColumn["bo_tnx_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bo_tnx_id')"/>");
		arrColumn["related_ref_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_related_ref_id')"/>");
		arrColumn["cust_ref_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cust_ref_id')"/>");
		arrColumn["adv_send_mode"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_adv_send_mode')"/>");
		arrColumn["tnx_type_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_tnx_type_code')"/>");
		arrColumn["sub_tnx_type_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_sub_tnx_type_code')"/>");
		arrColumn["prod_stat_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_prod_stat_code')"/>");
		arrColumn["inp_dttm"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_inp_dttm')"/>");
		arrColumn["LastController@LastControllerUser@first_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_first_name')"/>");
		arrColumn["LastController@LastControllerUser@last_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_last_name')"/>");
		arrColumn["LastController@validation_dttm"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ctl_dttm')"/>");
		arrColumn["release_dttm"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_release_dttm')"/>");
		arrColumn["tnx_val_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_tnx_val_date')"/>");
		arrColumn["tnx_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_tnx_amt')"/>");
		arrColumn["tnx_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_tnx_cur_code')"/>", "Currency");
		arrColumn["appl_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_appl_date')"/>");
		arrColumn["iss_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_iss_date')"/>");
		arrColumn["exp_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_exp_date')"/>");
		arrColumn["amd_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_amd_date')"/>");
		arrColumn["due_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_due_date')"/>");
		arrColumn["amd_no"] = new Array("Number", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_amd_no')"/>");
		arrColumn["last_ship_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_last_ship_date')"/>");
		arrColumn["lc_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_lc_cur_code')"/>", "Currency");
		arrColumn["lc_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_lc_amt')"/>");
		arrColumn["ri_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ri_cur_code')"/>", "Currency");
		arrColumn["ri_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ri_amt')"/>");
		arrColumn["fwd_contract_no"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_fwd_contract_no')"/>");
		arrColumn["latest_answer_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_latest_answer_date')"/>");
		arrColumn["doc_ref_no"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_doc_ref_no')"/>");
		arrColumn["related_ref"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_related_ref')"/>");
		arrColumn["lc_liab_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_lc_liab_amt')"/>");
		arrColumn["ri_liab_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ri_liab_amt')"/>");
		arrColumn["lc_type"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_lc_type')"/>");
		arrColumn["beneficiary_act_no"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_beneficiary_act_no')"/>");		
		<!-- added localization for Report Designer Issue -->
		arrColumn["ObjectDataString@beneficiary_act_no"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_beneficiary_act_no')"/>");

		arrColumn["se_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_se_cur_code')"/>", "Currency");
		arrColumn["se_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_se_amt')"/>");
		arrColumn["se_liab_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_se_liab_amt')"/>");
		arrColumn["se_type"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_se_type')"/>");
		arrColumn["ObjectDataString@credit_act_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_credit_act_name')"/>");
		arrColumn["remarks"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_remarks')"/>");
		arrColumn["act_no"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_act_no')"/>");	
		arrColumn["topic"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_topic')"/>");
		arrColumn["ObjectDataString@upload_file_type"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_UPLOAD_FILE_TYPE')"/>");
		
		arrColumn["beneficiary_abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_beneficiary_abbv_name')"/>");
		arrColumn["beneficiary_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_beneficiary_name')"/>");
		arrColumn["ObjectDataString@beneficiary_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_beneficiary_name')"/>");
		arrColumn["beneficiary_address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_beneficiary_address_line_1')"/>");
		arrColumn["beneficiary_address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_beneficiary_address_line_2')"/>");
		arrColumn["beneficiary_dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_beneficiary_dom')"/>");
		arrColumn["ObjectDataString@beneficiary_dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_beneficiary_dom')"/>");
		arrColumn["beneficiary_country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_beneficiary_country')"/>");
		arrColumn["beneficiary_reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_beneficiary_reference')"/>");
		arrColumn["ObjectDataString@beneficiary_reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_beneficiary_reference')"/>");
		arrColumn["beneficiary_reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_beneficiary_reference')"/>");
		arrColumn["beneficiary_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_beneficiary_cur_code')"/>", "Currency");
		arrColumn["sec_beneficiary_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_sec_beneficiary_name')"/>");
		arrColumn["sec_beneficiary_address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_sec_beneficiary_address_line_1')"/>");
		arrColumn["sec_beneficiary_address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_sec_beneficiary_address_line_2')"/>");
		arrColumn["sec_beneficiary_dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_sec_beneficiary_dom')"/>");
		//arrColumn["sec_beneficiary_country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_sec_beneficiary_country')"/>");
		arrColumn["sec_beneficiary_reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_sec_beneficiary_reference')"/>");
		arrColumn["applicant_act_no"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_applicant_act_no')"/>");		
		arrColumn["applicant_abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_applicant_abbv_name')"/>");
		arrColumn["applicant_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_applicant_name')"/>");
		arrColumn["applicant_address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_applicant_address_line_1')"/>");
		arrColumn["applicant_address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_applicant_address_line_2')"/>");
		arrColumn["applicant_dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_applicant_dom')"/>");
		arrColumn["applicant_country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_applicant_country')"/>");
		arrColumn["applicant_reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_applicant_reference')"/>");
		arrColumn["expiry_place"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_expiry_place')"/>");
		arrColumn["inco_term"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_inco_term')"/>");
		arrColumn["inco_term_year"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_INCO_TERM_YEAR')"/>");
		arrColumn["inco_place"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_inco_place')"/>");
		arrColumn["part_ship_detl"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_part_ship_detl')"/>");
		arrColumn["tran_ship_detl"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_tran_ship_detl')"/>");
		arrColumn["ship_from"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ship_from')"/>");
		arrColumn["ship_loading"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ship_loading')"/>");
		arrColumn["ship_discharge"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ship_discharge')"/>");
		arrColumn["ship_to"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ship_to')"/>");
		arrColumn["draft_term"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_draft_term')"/>");
		arrColumn["cty_of_dest"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cty_of_dest')"/>");
		
		arrColumn["rvlv_lc_type_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_rvlv_lc_type_code')"/>");
		arrColumn["max_no_of_rvlv"] = new Array("Number", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_max_no_of_rvlv')"/>");
		arrColumn["neg_tol_pct"] = new Array("Number", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_neg_tol_pct')"/>");
		arrColumn["pstv_tol_pct"] = new Array("Number", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_pstv_tol_pct')"/>");
		arrColumn["max_cr_desc_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_max_cr_desc_code')"/>");
		arrColumn["cr_avl_by_code"] = new Array("AvailableCreditCode", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cr_avl_by_code')"/>");
		arrColumn["dir_reim_flag"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_dir_reim_flag')"/>");
		arrColumn["irv_flag"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_irv_flag')"/>");
		arrColumn["ntf_flag"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ntf_flag')"/>");
		arrColumn["ntrf_flag"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ntrf_flag')"/>");
		arrColumn["stnd_by_lc_flag"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_stnd_by_lc_flag')"/>");
		arrColumn["release_amt"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_release_amt')"/>");
		arrColumn["lc_release_flag"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_lc_release_flag')"/>");
		arrColumn["cfm_inst_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cfm_inst_code')"/>");
		arrColumn["cfm_flag"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cfm_flag')"/>");
		arrColumn["cfm_chrg_brn_by_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cfm_chrg_brn_by_code')"/>");
		arrColumn["corr_chrg_brn_by_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_corr_chrg_brn_by_code')"/>");
		arrColumn["open_chrg_brn_by_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_open_chrg_brn_by_code')"/>");
		arrColumn["amd_chrg_brn_by_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_amd_chrg_brn_by_code')"/>");

		arrColumn["renew_flag"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_renew_flag')"/>");
		arrColumn["renew_on_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_renew_on_code')"/>");
		arrColumn["renewal_calendar_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_renewal_calendar_date')"/>");
		arrColumn["renew_for_nb"] = new Array("Number", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_renew_for_nb')"/>");
		arrColumn["renew_for_period"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_renew_for_period')"/>");
		arrColumn["advise_renewal_flag"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_advise_renewal_flag')"/>");
		arrColumn["advise_renewal_days_nb"] = new Array("Number", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_advise_renewal_days_nb')"/>");
		arrColumn["rolling_renewal_flag"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_rolling_renewal_flag')"/>");
		arrColumn["rolling_renewal_nb"] = new Array("Number", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_rolling_renewal_nb')"/>");
		arrColumn["rolling_cancellation_days"] = new Array("Number", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_rolling_cancellation_days')"/>");
		arrColumn["renew_amt_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_renew_amt_code')"/>");
		arrColumn["rolling_renew_on_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_rolling_renewal_on_code')"/>");
		arrColumn["rolling_renew_for_nb"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_rolling_renew_for_nb')"/>");
		arrColumn["rolling_renew_for_period"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_rolling_renew_for_period')"/>");
		arrColumn["rolling_day_in_month"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_rolling_day_in_month')"/>");
		
		arrColumn["revolving_flag"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_revolving_flag')"/>");
		arrColumn["revolve_period"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_revolve_period')"/>");
		arrColumn["revolve_frequency"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_revolve_frequency')"/>");
		arrColumn["revolve_time_no"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_revolve_time_no')"/>");
		arrColumn["cumulative_flag"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cumulative_flag')"/>");
		arrColumn["next_revolve_date"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_next_revolve_date')"/>");
		arrColumn["notice_days"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_notice_days')"/>");
		arrColumn["charge_upto"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_charge_upto')"/>");

		arrColumn["principal_act_no"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_principal_act_no')"/>");
		arrColumn["fee_act_no"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_fee_act_no')"/>");
		//arrColumn["bo_comment"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bo_comment')"/>");
		arrColumn["free_format_text"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_free_format_text')"/>");
		arrColumn["amd_details"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_amd_details')"/>");
		arrColumn["tnx_stat_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_tnx_stat_code')"/>");
		arrColumn["sub_tnx_stat_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_sub_tnx_stat_code')"/>");
		arrColumn["claim_cur_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_claim_cur_code')"/>");
		arrColumn["claim_amt"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_claim_amt')"/>");
		arrColumn["claim_reference"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_claim_reference')"/>");
		arrColumn["claim_present_date"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_claim_present_date')"/>");
		arrColumn["company_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_company_name')"/>");
		arrColumn["bo_inp_dttm"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bo_inp_dttm')"/>");
		arrColumn["bo_release_dttm"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bo_release_dttm')"/>");
		arrColumn["iss_date_type_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_effective_date_type_code')"/>");
		arrColumn["iss_date_type_details"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_iss_date_type_details')"/>");
		arrColumn["exp_date_type_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_exp_date_type_code')"/>");
		arrColumn["exp_event"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_exp_event')"/>", "Currency");
		arrColumn["text_language"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_text_language')"/>");
		arrColumn["text_language_other"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_text_language_other')"/>");
		arrColumn["imp_bill_ref_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_imp_bill_ref_id')"/>");
		arrColumn["issuing_bank_type_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_issuing_bank_type_code')"/>");
		arrColumn["contract_ref"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_contract_ref')"/>");
		arrColumn["contract_narrative"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_contract_narrative')"/>");
		arrColumn["tender_expiry_date"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_tender_expiry_date')"/>");
		arrColumn["contract_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_contract_date')"/>");
		arrColumn["contract_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_contract_amt')"/>");
		arrColumn["contract_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_contract_cur_code')"/>", "Currency");
		arrColumn["contract_pct"] = new Array("Number", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_contract_pct')"/>");
		arrColumn["sg_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_sg_cur_code')"/>", "Currency");
		arrColumn["sg_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_sg_amt')"/>");
		arrColumn["sg_liab_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_sg_liab_amt')"/>");
		//arrColumn["goods_desc"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_goods_desc')"/>");
		arrColumn["bol_number"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bol_number')"/>");
		arrColumn["shipping_mode"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_shipping_mode')"/>");
		arrColumn["shipping_by"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_shipping_by')"/>");
		arrColumn["fin_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_fin_cur_code')"/>", "Currency");
		arrColumn["fin_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_fin_amt')"/>");
		arrColumn["fin_liab_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_fin_liab_amt')"/>");
		arrColumn["fin_type"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_fin_type')"/>");
		<!-- arrColumn["tenor"] = new Array("Number", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_tenor')"/>"); -->
		arrColumn["term_code"] = new Array("Number", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_tenor')"/>");
		arrColumn["maturity_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_maturity_date')"/>");
		arrColumn["provisional_status"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_provisional_status')"/>");
		arrColumn["req_pct"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_req_pct')"/>");
		arrColumn["req_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_req_amt')"/>");
		arrColumn["req_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_req_cur_code')"/>");
		arrColumn["ft_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ft_cur_code')"/>", "Currency");
		arrColumn["ft_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ft_amt')"/>");
		arrColumn["ft_type"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ft_type')"/>");
		arrColumn["fwd_contract_no"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_fwd_contract_no')"/>");
		arrColumn["act_no"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_act_no')"/>");
		arrColumn["remittance_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_remittance_date')"/>");
		arrColumn["ec_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ec_cur_code')"/>", "Currency");
		arrColumn["ec_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ec_amt')"/>");
		arrColumn["ec_liab_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ec_liab_amt')"/>");
		arrColumn["ec_type_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ec_type_code')"/>");
		arrColumn["drawee_abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_drawee_abbv_name')"/>");
		arrColumn["drawee_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_drawee_name')"/>");
		arrColumn["drawee_address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_drawee_address_line_1')"/>");
		arrColumn["drawee_address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_drawee_address_line_2')"/>");
		arrColumn["drawee_dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_drawee_dom')"/>");
		//arrColumn["drawee_country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_drawee_country')"/>");
		arrColumn["drawee_reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_drawee_reference')"/>");
		arrColumn["drawer_abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_drawer_abbv_name')"/>");
		arrColumn["drawer_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_drawer_name')"/>");
		arrColumn["drawer_address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_drawer_address_line_1')"/>");
		arrColumn["drawer_address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_drawer_address_line_2')"/>");
		arrColumn["drawer_dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_drawer_dom')"/>");
		//arrColumn["drawer_country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_drawer_country')"/>");
		arrColumn["drawer_reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_drawer_reference')"/>");
		arrColumn["remitter_abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_remitter_abbv_name')"/>");
		arrColumn["remitter_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_remitter_name')"/>");
		arrColumn["remitter_address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_remitter_address_line_1')"/>");
		arrColumn["remitter_address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_remitter_address_line_2')"/>");
		arrColumn["remitter_dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_remitter_dom')"/>");
		//arrColumn["remitter_country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_remitter_country')"/>");
		arrColumn["remitter_reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_remitter_reference')"/>");
		<!-- arrColumn["term_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_term_code')"/>");-->
		arrColumn["docs_send_mode"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_docs_send_mode')"/>");
		arrColumn["dir_coll_letter_flag"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_dir_coll_letter_flag')"/>");
		arrColumn["accpt_adv_send_mode"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_accpt_adv_send_mode')"/>");
		arrColumn["protest_non_paymt"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_protest_non_paymt')"/>");
		arrColumn["protest_non_accpt"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_protest_non_accpt')"/>");
		arrColumn["protest_adv_send_mode"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_protest_adv_send_mode')"/>");
		arrColumn["accpt_defd_flag"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_accpt_defd_flag')"/>");
		arrColumn["store_goods_flag"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_store_goods_flag')"/>");
		
		arrColumn["needs_refer_to"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_needs_refer_to')"/>");
		arrColumn["needs_instr_by_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_needs_instr_by_code')"/>");
		
		arrColumn["paymt_adv_send_mode"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_paymt_adv_send_mode')"/>");
		arrColumn["tenor_desc"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_tenor_desc')"/>");
		arrColumn["tenor_unit"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_tenor_unit')"/>");
		arrColumn["tenor_event"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_tenor_event')"/>");
		arrColumn["tenor_start_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_tenor_start_date')"/>");
		arrColumn["tenor_maturity_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_tenor_maturity_date')"/>");
		
		arrColumn["tenor"] = new Array("Number", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_tenor_in_days')"/>");
		arrColumn["tenor_base_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_tenor_base_date')"/>");
		<!-- arrColumn["tenor_type"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_tenor_type')"/>"); -->
		arrColumn["tenor_type"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_draft_against')"/>");
		arrColumn["tenor_days"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_tenor_days')"/>");
		arrColumn["tenor_period"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_tenor_period')"/>");
		arrColumn["tenor_from_after"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_tenor_from_after')"/>");
		arrColumn["tenor_days_type"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_tenor_days_type')"/>");
		arrColumn["tenor_type_details"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_tenor_type_details')"/>");
		
		arrColumn["waive_chrg_flag"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_waive_chrg_flag')"/>");
		arrColumn["int_rate"] = new Array("Number", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_int_rate')"/>");
		arrColumn["int_start_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_int_start_date')"/>");
		arrColumn["int_maturity_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_int_maturity_date')"/>");
		arrColumn["insr_req_flag"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_insr_req_flag')"/>");
		arrColumn["ic_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ic_cur_code')"/>", "Currency");
		arrColumn["ic_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ic_amt')"/>");
		arrColumn["ic_liab_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ic_liab_amt')"/>");
		arrColumn["ic_type_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ic_type_code')"/>");
		
		arrColumn["ir_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ir_cur_code')"/>", "Currency");
		arrColumn["ir_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ir_amt')"/>");
		arrColumn["ir_liab_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ir_liab_amt')"/>");
		arrColumn["ir_type_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ir_type_code')"/>");
		
		arrColumn["bol_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bol_date')"/>");
		arrColumn["deal_ref_id"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_deal_ref_id')"/>");
		arrColumn["countersign_flag"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_countersign_flag')"/>");
		arrColumn["trans_doc_type_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_trans_doc_type_code')"/>");
		arrColumn["bene_type_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bene_type_code')"/>");
		arrColumn["bene_type_other"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bene_type_other')"/>");
		arrColumn["li_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_li_cur_code')"/>", "Currency");
		arrColumn["li_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_li_amt')"/>");
		arrColumn["li_liab_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_li_liab_amt')"/>");		
		arrColumn["creation_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_creation_date')"/>");		
		arrColumn["tid"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_tid')"/>");		
		arrColumn["po_ref_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_po_ref_id')"/>");		
		arrColumn["cpty_ref_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cpty_ref_id')"/>");		
		arrColumn["cpty_bank"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cpty_bank')"/>");		
		arrColumn["role"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_role')"/>");		
		arrColumn["buyer_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_buyer_name')"/>");		
		arrColumn["seller_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_seller_name')"/>");		
		arrColumn["ordered_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ordered_amt')"/>");		
		arrColumn["baseline_stat_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_baseline_stat_code')"/>");		
		arrColumn["baseline_ref_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_baseline_ref_id')"/>");		
		arrColumn["request_for_action"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_request_for_action')"/>");		
		arrColumn["message_type"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_message_type')"/>");
		<!-- SWIFT 2018 -->
		arrColumn["period_presentation_days"] = new Array("Number", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_period_presentation_days')"/>");
		arrColumn["req_conf_party_flag"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_req_conf_party_flag')"/>");
		<!-- LS Columns -->
		
		arrColumn["allow_multi_cur"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_allow_multi_cur')"/>");
		arrColumn["valid_for_period"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_valid_for_period')"/>");
		arrColumn["valid_for_nb"] = new Array("Number", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_valid_for_nb')"/>");
		arrColumn["valid_from_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_valid_from_date')"/>");
		arrColumn["valid_to_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_valid_to_date')"/>");
		arrColumn["reg_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_reg_date')"/>");
		arrColumn["reg_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_reg_date')"/>");
		arrColumn["original_xml"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_original_xml')"/>");
		arrColumn["master_version"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_master_version')"/>");
		arrColumn["latest_payment_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_latest_payment_date')"/>");
		arrColumn["origin_country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_origin_country')"/>");
		arrColumn["supply_country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_supply_country')"/>");
		arrColumn["bulk_ref_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bulk_ref_id')"/>");
		arrColumn["brch_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_brch_code')"/>");
		arrColumn["auth_reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_auth_reference')"/>");
		arrColumn["further_identification"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_further_identification')"/>");
		arrColumn["additional_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_additional_cur_code')"/>", "Currency");
		arrColumn["ls_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ls_cur_code')"/>", "Currency");
		arrColumn["ls_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ls_amt')"/>");
		arrColumn["ls_def_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ls_def_id')"/>");		
		arrColumn["ls_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ls_name')"/>");
		arrColumn["ls_number"] = new Array("Number", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ls_number')"/>");
		arrColumn["ls_outstanding_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ls_outstanding_amt')"/>");		
		arrColumn["ls_type"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ls_type')"/>");
		arrColumn["ls_liab_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ls_liab_amt')"/>");
		
		<!-- LSTnx Column -->	
		arrColumn["tnx_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_tnx_id')"/>");
		arrColumn["action_req_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_action_req_code')"/>");
		arrColumn["additional_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_additional_amt')"/>");
		arrColumn["bo_tnx_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bo_tnx_id')"/>");
		arrColumn["bo_inp_user_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bo_inp_user_id')"/>");
		arrColumn["bo_release_user_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bo_release_user_id')"/>");
		arrColumn["dest_master_version"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_dest_master_version')"/>");
		arrColumn["inp_user_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_inp_user_id')"/>");
		arrColumn["release_user_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_release_user_id')"/>");
		
		
		
		
		arrColumn["reduction_authorised"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_reduction_authorised')"/>");
		arrColumn["reduction_clause"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_reduction_clause')"/>");
		arrColumn["reduction_clause_other"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_reduction_clause_other')"/>");
		arrColumn["contact_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_contact_name')"/>");
		arrColumn["contact_address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_contact_address_line_1')"/>");
		arrColumn["contact_address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_contact_address_line_2')"/>");
		arrColumn["contact_dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_contact_dom')"/>");
		arrColumn["contact_country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_contact_country')"/>");
		arrColumn["for_account"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_for_account')"/>");
		arrColumn["alt_applicant_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_alt_applicant_name')"/>");
		arrColumn["alt_applicant_address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_alt_applicant_address_line_1')"/>");
		arrColumn["alt_applicant_address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_alt_applicant_address_line_2')"/>");
		arrColumn["alt_applicant_dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_alt_applicant_dom')"/>");
		arrColumn["alt_applicant_country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_alt_applicant_country')"/>");
		arrColumn["consortium"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_consortium')"/>");
		arrColumn["net_exposure_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_net_exposure_cur_code')"/>", "Currency");
		arrColumn["net_exposure_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_net_exposure_amt')"/>");
		arrColumn["adv_bank_conf_req"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_adv_bank_conf_req')"/>");
		arrColumn["character_commitment"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_character_commitment')"/>");
		arrColumn["delivery_to"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_delivery_to')"/>");
		arrColumn["delivery_to_other"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_delivery_to_other')"/>");
			
		
		// Inputer/Controler full mane
		arrColumn["Inputter@last_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Inputter@last_name')"/>");
		arrColumn["Inputter@first_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Inputter@first_name')"/>");
		arrColumn["Controller@last_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Controller@last_name')"/>");
		arrColumn["Controller@first_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Controller@first_name')"/>");
		arrColumn["Releaser@last_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Releaser@last_name')"/>");
		arrColumn["Releaser@first_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Releaser@first_name')"/>");
		arrColumn["BOInputter@last_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_BOInputter@last_name')"/>");
		arrColumn["BOInputter@first_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_BOInputter@first_name')"/>");
		arrColumn["BOReleaser@last_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_BOReleaser@last_name')"/>");
		arrColumn["BOReleaser@first_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_BOReleaser@first_name')"/>");
			
		arrColumn["IssuingBank@abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_IssuingBank@abbv_name')"/>");
		arrColumn["IssuingBank@name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_IssuingBank@name')"/>");
		arrColumn["IssuingBank@address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_IssuingBank@address_line_1')"/>");
		arrColumn["IssuingBank@address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_IssuingBank@address_line_2')"/>");
		arrColumn["IssuingBank@dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_IssuingBank@dom')"/>");
		arrColumn["IssuingBank@reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_IssuingBank@reference')"/>");
		arrColumn["IssuingBank@country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_IssuingBank@country')"/>");
		arrColumn["IssuingBank@address_line_4"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_IssuingBank@address_line_4')"/>");

		arrColumn["AdvisingBank@abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AdvisingBank@abbv_name')"/>");
		arrColumn["AdvisingBank@name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AdvisingBank@name')"/>");
		arrColumn["AdvisingBank@address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AdvisingBank@address_line_1')"/>");
		arrColumn["AdvisingBank@address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AdvisingBank@address_line_2')"/>");
		arrColumn["AdvisingBank@dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AdvisingBank@dom')"/>");
		arrColumn["AdvisingBank@reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AdvisingBank@reference')"/>");
		arrColumn["AdvisingBank@country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AdvisingBank@country')"/>");
		arrColumn["AdvisingBank@address_line_4"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AdvisingBank@address_line_4')"/>");

		arrColumn["AdviseThruBank@abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AdviseThruBank@abbv_name')"/>");
		arrColumn["AdviseThruBank@name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AdviseThruBank@name')"/>");
		arrColumn["AdviseThruBank@address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AdviseThruBank@address_line_1')"/>");
		arrColumn["AdviseThruBank@address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AdviseThruBank@address_line_2')"/>");
		arrColumn["AdviseThruBank@dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AdviseThruBank@dom')"/>");
		arrColumn["AdviseThruBank@reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AdviseThruBank@reference')"/>");
		arrColumn["AdviseThruBank@country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AdviseThruBank@country')"/>");

		arrColumn["CreditAvailableWithBank@abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_CreditAvailableWithBank@abbv_name')"/>");
		arrColumn["CreditAvailableWithBank@name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_CreditAvailableWithBank@name')"/>");
		arrColumn["CreditAvailableWithBank@address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_CreditAvailableWithBank@address_line_1')"/>");
		arrColumn["CreditAvailableWithBank@address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_CreditAvailableWithBank@address_line_2')"/>");
		arrColumn["CreditAvailableWithBank@dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_CreditAvailableWithBank@dom')"/>");
		arrColumn["CreditAvailableWithBank@reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_CreditAvailableWithBank@reference')"/>");
		arrColumn["CreditAvailableWithBank@country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_CreditAvailableWithBank@country')"/>");

		arrColumn["DraweeDetailsBank@abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_DraweeDetailsBank@abbv_name')"/>");
		arrColumn["DraweeDetailsBank@name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_DraweeDetailsBank@name')"/>");
		arrColumn["DraweeDetailsBank@address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_DraweeDetailsBank@address_line_1')"/>");
		arrColumn["DraweeDetailsBank@address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_DraweeDetailsBank@address_line_2')"/>");
		arrColumn["DraweeDetailsBank@dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_DraweeDetailsBank@dom')"/>");
		arrColumn["DraweeDetailsBank@reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_DraweeDetailsBank@reference')"/>");
		arrColumn["DraweeDetailsBank@country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_DraweeDetailsBank@country')"/>");

		arrColumn["RemittingBank@abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_RemittingBank@abbv_name')"/>");
		arrColumn["RemittingBank@name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_RemittingBank@name')"/>");
		arrColumn["RemittingBank@address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_RemittingBank@address_line_1')"/>");
		arrColumn["RemittingBank@address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_RemittingBank@address_line_2')"/>");
		arrColumn["RemittingBank@dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_RemittingBank@dom')"/>");
		arrColumn["RemittingBank@reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_RemittingBank@reference')"/>");
		arrColumn["RemittingBank@country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_RemittingBank@country')"/>");

		arrColumn["CollectingBank@abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_CollectingBank@abbv_name')"/>");
		arrColumn["CollectingBank@name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_CollectingBank@name')"/>");
		arrColumn["CollectingBank@address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_CollectingBank@address_line_1')"/>");
		arrColumn["CollectingBank@address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_CollectingBank@address_line_2')"/>");
		arrColumn["CollectingBank@dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_CollectingBank@dom')"/>");
		arrColumn["CollectingBank@reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_CollectingBank@reference')"/>");
		arrColumn["CollectingBank@country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_CollectingBank@country')"/>");

		arrColumn["PresentingBank@abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_PresentingBank@abbv_name')"/>");
		arrColumn["PresentingBank@name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_PresentingBank@name')"/>");
		arrColumn["PresentingBank@address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_PresentingBank@address_line_1')"/>");
		arrColumn["PresentingBank@address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_PresentingBank@address_line_2')"/>");
		arrColumn["PresentingBank@dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_PresentingBank@dom')"/>");
		arrColumn["PresentingBank@reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_PresentingBank@reference')"/>");
		arrColumn["PresentingBank@country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_PresentingBank@country')"/>");

		arrColumn["RecipientBank@abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_RecipientBank@abbv_name')"/>");
		arrColumn["RecipientBank@name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_RecipientBank@name')"/>");
		arrColumn["RecipientBank@address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_RecipientBank@address_line_1')"/>");
		arrColumn["RecipientBank@address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_RecipientBank@address_line_2')"/>");
		arrColumn["RecipientBank@dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_RecipientBank@dom')"/>");
		arrColumn["RecipientBank@reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_RecipientBank@reference')"/>");
		arrColumn["RecipientBank@country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_RecipientBank@country')"/>");
		
		arrColumn["ConfirmingBank@abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ConfirmingBank@abbv_name')"/>");
		arrColumn["ConfirmingBank@name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ConfirmingBank@name')"/>");
		arrColumn["ConfirmingBank@address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ConfirmingBank@address_line_1')"/>");
		arrColumn["ConfirmingBank@address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ConfirmingBank@address_line_2')"/>");
		arrColumn["ConfirmingBank@dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ConfirmingBank@dom')"/>");
		arrColumn["ConfirmingBank@reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ConfirmingBank@reference')"/>");
		arrColumn["ConfirmingBank@country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ConfirmingBank@country')"/>");
		arrColumn["ConfirmingBank@address_line_4"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ConfirmingBank@address_line_4')"/>");

		arrColumn["AccountWithBank@abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AccountWithBank@abbv_name')"/>");
		arrColumn["AccountWithBank@name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AccountWithBank@name')"/>");
		arrColumn["AccountWithBank@address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AccountWithBank@address_line_1')"/>");
		arrColumn["AccountWithBank@address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AccountWithBank@address_line_2')"/>");
		arrColumn["AccountWithBank@dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AccountWithBank@dom')"/>");
		arrColumn["AccountWithBank@reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AccountWithBank@reference')"/>");
		arrColumn["AccountWithBank@country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AccountWithBank@country')"/>");

		arrColumn["PayThroughBank@abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_PayThroughBank@abbv_name')"/>");
		arrColumn["PayThroughBank@name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_PayThroughBank@name')"/>");
		arrColumn["PayThroughBank@address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_PayThroughBank@address_line_1')"/>");
		arrColumn["PayThroughBank@address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_PayThroughBank@address_line_2')"/>");
		arrColumn["PayThroughBank@dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_PayThroughBank@dom')"/>");
		arrColumn["PayThroughBank@reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_PayThroughBank@reference')"/>");
		arrColumn["PayThroughBank@country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_PayThroughBank@country')"/>");

		arrColumn["CorrespondentBank@abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_CorrespondentBank@abbv_name')"/>");
		arrColumn["CorrespondentBank@name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_CorrespondentBank@name')"/>");
		arrColumn["CorrespondentBank@address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_CorrespondentBank@address_line_1')"/>");
		arrColumn["CorrespondentBank@address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_CorrespondentBank@address_line_2')"/>");
		arrColumn["CorrespondentBank@dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_CorrespondentBank@dom')"/>");
		arrColumn["CorrespondentBank@reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_CorrespondentBank@reference')"/>");
		arrColumn["CorrespondentBank@country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_CorrespondentBank@country')"/>");

		arrColumn["BuyerBank@abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_BuyerBank@abbv_name')"/>");
		arrColumn["BuyerBank@name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_BuyerBank@name')"/>");
		arrColumn["BuyerBank@address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_BuyerBank@address_line_1')"/>");
		arrColumn["BuyerBank@address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_BuyerBank@address_line_2')"/>");
		arrColumn["BuyerBank@dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_BuyerBank@dom')"/>");
		arrColumn["BuyerBank@reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_BuyerBank@reference')"/>");
		arrColumn["BuyerBank@country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_BuyerBank@country')"/>");

		arrColumn["SellerBank@abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_SellerBank@abbv_name')"/>");
		arrColumn["SellerBank@name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_SellerBank@name')"/>");
		arrColumn["SellerBank@address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_SellerBank@address_line_1')"/>");
		arrColumn["SellerBank@address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_SellerBank@address_line_2')"/>");
		arrColumn["SellerBank@dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_SellerBank@dom')"/>");
		arrColumn["SellerBank@reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_SellerBank@reference')"/>");
		arrColumn["SellerBank@country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_SellerBank@country')"/>");
		
		<xsl:if test="$swift2019Enabled">
			arrColumn["req_conf_party"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_req_conf_party_flag')"/>");
		</xsl:if>
		
		<!-- SWIFT 2018 -->
		arrColumn["RequestedConfirmationParty@abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_RequestedConfirmationParty@abbv_name')"/>");
		arrColumn["RequestedConfirmationParty@name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_RequestedConfirmationParty@name')"/>");
		arrColumn["RequestedConfirmationParty@address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_RequestedConfirmationParty@address_line_1')"/>");
		arrColumn["RequestedConfirmationParty@address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_RequestedConfirmationParty@address_line_2')"/>");
		arrColumn["RequestedConfirmationParty@dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_RequestedConfirmationParty@dom')"/>");
		<xsl:if test="$swift2019Enabled">
			arrColumn["RequestedConfirmationParty@address_line_4"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_RequestedConfirmationParty@address_line_4')"/>");
		</xsl:if>
		arrColumn["RequestedConfirmationParty@iso_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_RequestedConfirmationParty@iso_code')"/>");
		arrColumn["RequestedConfirmationParty@reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_RequestedConfirmationParty@reference')"/>");
		arrColumn["RequestedConfirmationParty@country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_RequestedConfirmationParty@country')"/>");

		arrColumn["Narrative@goodsDesc"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Narrative@goodsDesc')"/>", "CLOB");
		arrColumn["Narrative@docsRequired"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Narrative@docsRequired')"/>", "CLOB");
		arrColumn["Narrative@additionalInstructions"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Narrative@additionalInstructions')"/>", "CLOB");
		<!-- SWIFT 2018 -->
		arrColumn["Narrative@splPaymentBeneficiary"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Narrative@splPaymentBeneficiary')"/>", "CLOB");
		arrColumn["Narrative@splPaymentReceiving"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Narrative@splPaymentReceiving')"/>", "CLOB");
		arrColumn["Narrative@legacyPartialShipment"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Narrative@legacyPartialShipment')"/>", "CLOB");
		arrColumn["Narrative@legacyTranShipment"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Narrative@legacyTranShipment')"/>", "CLOB");
		arrColumn["Narrative@legacyPeriodOfPresentation"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Narrative@legacyPeriodOfPresentation')"/>", "CLOB");
		arrColumn["Narrative@legacyMaxCreditAmount"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Narrative@legacyMaxCreditAmount')"/>", "CLOB");
		arrColumn["Narrative@chargesDetails"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Narrative@chargesDetails')"/>", "CLOB");
		arrColumn["Narrative@additionalAmount"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Narrative@additionalAmount')"/>", "CLOB");
		arrColumn["Narrative@paymentInstructions"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Narrative@paymentInstructions')"/>", "CLOB");
		arrColumn["Narrative@periodOfPresentation"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Narrative@periodOfPresentation')"/>", "CLOB");
		arrColumn["Narrative@shipmentPeriod"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Narrative@shipmentPeriod')"/>", "CLOB");
		arrColumn["Narrative@senderToReceiver"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Narrative@senderToReceiver')"/>", "CLOB");
		arrColumn["Narrative@fullDetails"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Narrative@fullDetails')"/>", "CLOB");
		arrColumn["Narrative@boComment"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Narrative@boComment')"/>", "CLOB");
		arrColumn["Narrative@freeFormatText"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Narrative@freeFormatText')"/>", "CLOB");
		arrColumn["Narrative@amdDetails"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Narrative@amdDetails')"/>", "CLOB");
		arrColumn["Narrative@goodsDesc"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Narrative@goodsDesc')"/>", "CLOB");
		arrColumn["Narrative@return_comments"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Narrative@return_comments')"/>", "CLOB");
		arrColumn["Narrative@amendCharges"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Narrative@amendCharges')"/>", "CLOB");
		<!-- Swift 2020 SI Columns -->
		<xsl:choose>	
			<xsl:when test="$swift2019Enabled">
				arrColumn["Narrative@transferDetails"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Narrative@transferDetails')"/>", "CLOB");
				arrColumn["Narrative@deliveryTo"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Narrative@deliveryTo')"/>", "CLOB");
				arrColumn["Narrative@underlyingTransactionDetails"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Narrative@underlyingTransactionDetails')"/>", "CLOB");
				arrColumn["Narrative@textOfUndertaking"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Narrative@textOfUndertaking')"/>", "CLOB");
			</xsl:when>
		</xsl:choose>
		arrColumn["AllowanceTaxMaster@amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AllowanceTaxMaster@amt')"/>");
		arrColumn["AllowanceTaxMaster@cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AllowanceTaxMaster@cur_code')"/>","Currency");
		arrColumn["AllowanceTaxMaster@rate"] = new Array("Number", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AllowanceTaxMaster@rate')"/>");
		arrColumn["AllowanceTaxMaster@type"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AllowanceTaxMaster@type')"/>");
		arrColumn["AllowanceTax@amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AllowanceTaxMaster@amt')"/>");
		arrColumn["AllowanceTax@cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AllowanceTaxMaster@cur_code')"/>","Currency");
		arrColumn["AllowanceTax@rate"] = new Array("Number", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AllowanceTaxMaster@rate')"/>");
		arrColumn["AllowanceTax@type"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AllowanceTaxMaster@type')"/>");
		
		arrColumn["Charge@chrg_code"] = new Array("AvailableChargeCode", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Charge@chrg_code')"/>");
		arrColumn["Charge@amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Charge@amt')"/>");
		arrColumn["Charge@cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Charge@cur_code')"/>", "Currency");
		arrColumn["Charge@status"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Charge@status')"/>");
		arrColumn["Charge@additional_comment"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Charge@additional_comment')"/>");
		arrColumn["Charge@settlement_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Charge@settlement_date')"/>");
		arrColumn["Charge@chrg_type"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Charge@chrg_type')"/>");
		
		arrColumn["Document@code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Document@code')"/>");
		arrColumn["Document@name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Document@name')"/>");
		arrColumn["Document@first_mail"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Document@first_mail')"/>");
		arrColumn["Document@second_mail"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Document@second_mail')"/>");
		arrColumn["Document@total"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Document@total')"/>");
		arrColumn["Document@doc_no"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Document@doc_no')"/>");
		arrColumn["Document@doc_date"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Document@doc_date')"/>");
		
		// Object Data
		arrColumn["ObjectDataString@po_ref_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ObjectDataString@po_ref_id')"/>");
		arrColumn["ObjectDataNumber@counterparty_nb"] = new Array("Number", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ObjectDataNumber@counterparty_nb')"/>");
		arrColumn["ObjectDataString@objectdata_counterparty_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ObjectDataString@objectdata_counterparty_name')"/>");
		arrColumn["TemplateObjectDataString@objectdata_counterparty_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_TemplateObjectDataString@objectdata_counterparty_name')"/>");
		arrColumn["TemplateObjectDataNumber@counterparty_nb"] = new Array("Number", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_TemplateObjectDataNumber@counterparty_nb')"/>");
		arrColumn["ObjectDataString@purchase_order"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_purchase_order')"/>");
				
		
		
    	// Audit columns
    	arrColumn["date_time"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_date_time')"/>");
		arrColumn["action_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_action_code')"/>");
		arrColumn["action_code_derived"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_action_code_derived')"/>");
		arrColumn["result"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_result')"/>");
		arrColumn["AuditItem@context"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_context')"/>");
		arrColumn["User@login_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_User@login_id')"/>");
		arrColumn["User@first_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_User@first_name')"/>");
		arrColumn["User@last_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_User@last_name')"/>");
		arrColumn["Company@abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Company@abbv_name')"/>");
		arrColumn["Company@name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Company@name')"/>");
		arrColumn["ip_addr"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'AUDIT_IPADDRESS')"/>");
   		 <!-- counterparty columns -->
		arrColumn["Counterparty@counterparty_act_no"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_counterparty_act_no')"/>");
		arrColumn["Counterparty@counterparty_reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_counterparty_reference')"/>");
		arrColumn["Counterparty@counterparty_address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_counterparty_address_line_1')"/>");
		arrColumn["Counterparty@counterparty_address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_counterparty_address_line_2')"/>");
		arrColumn["Counterparty@counterparty_country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_counterparty_country')"/>");
		arrColumn["Counterparty@counterparty_abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_counterparty_abbv_name')"/>");
		arrColumn["Counterparty@counterparty_act_iso_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_counterparty_act_iso_code')"/>");
		arrColumn["Counterparty@counterparty_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_counterparty_name')"/>");
		arrColumn["Counterparty@counterparty_dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_counterparty_dom')"/>");
		arrColumn["Counterparty@counterparty_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_counterparty_amt')"/>");
		arrColumn["Counterparty@counterparty_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_counterparty_cur_code')"/>");
		arrColumn["Counterparty@cpty_bank_swift_bic_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cpty_bank_swift_bic_code')"/>");
		arrColumn["Counterparty@cpty_bank_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cpty_bank_code')"/>");
		arrColumn["Counterparty@cpty_bank_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cpty_bank_name')"/>");
		arrColumn["Counterparty@cpty_bank_address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cpty_bank_address_line_1')"/>");
		arrColumn["Counterparty@cpty_bank_address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cpty_bank_address_line_2')"/>");
		arrColumn["Counterparty@cpty_bank_dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cpty_bank_dom')"/>");
		arrColumn["Counterparty@cpty_branch_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cpty_branch_code')"/>");
		arrColumn["Counterparty@cpty_branch_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cpty_branch_name')"/>");
		arrColumn["Counterparty@cpty_branch_address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cpty_branch_address_line_1')"/>");
		arrColumn["Counterparty@cpty_branch_address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cpty_branch_address_line_2')"/>");

		// Purchase Order columns
		arrColumn["link_ref_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_link_ref_id')"/>");
		arrColumn["issuer_ref_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_issuer_ref_id')"/>");
 		arrColumn["issuer_ref_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_invoice_ref')"/>");
		arrColumn["buyer_abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_buyer_abbv_name')"/>");
		arrColumn["buyer_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_buyer_name')"/>");
		arrColumn["buyer_bei"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_buyer_bei')"/>");
		arrColumn["buyer_bank_bic"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_buyer_bank_bic')"/>");
		arrColumn["buyer_street_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_buyer_street_name')"/>");
		arrColumn["buyer_post_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_buyer_post_code')"/>");
		arrColumn["buyer_town_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_buyer_town_name')"/>");
		arrColumn["buyer_country_sub_div"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_buyer_country_sub_div')"/>");
		arrColumn["buyer_country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_buyer_country')"/>");
		arrColumn["buyer_reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_buyer_reference')"/>");
		arrColumn["seller_abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_seller_abbv_name')"/>");
		arrColumn["seller_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_seller_name')"/>");
		arrColumn["seller_bei"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_seller_bei')"/>");
		arrColumn["seller_bank_bic"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_seller_bank_bic')"/>");
		arrColumn["seller_street_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_seller_street_name')"/>");
		arrColumn["seller_post_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_seller_post_code')"/>");
		arrColumn["seller_town_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_seller_town_name')"/>");
		arrColumn["seller_country_sub_div"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_seller_country_sub_div')"/>");
		arrColumn["seller_country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_seller_country')"/>");
		arrColumn["seller_reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_seller_reference')"/>");
		arrColumn["bill_to_abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bill_to_abbv_name')"/>");
		arrColumn["bill_to_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bill_to_name')"/>");
		arrColumn["bill_to_bei"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bill_to_bei')"/>");
		arrColumn["bill_to_street_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bill_to_street_name')"/>");
		arrColumn["bill_to_post_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bill_to_post_code')"/>");
		arrColumn["bill_to_town_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bill_to_town_name')"/>");
		arrColumn["bill_to_country_sub_div"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bill_to_country_sub_div')"/>");
		arrColumn["bill_to_country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bill_to_country')"/>");
		arrColumn["ship_to_abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ship_to_abbv_name')"/>");
		arrColumn["ship_to_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ship_to_name')"/>");
		arrColumn["ship_to_bei"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ship_to_bei')"/>");
		arrColumn["ship_to_street_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ship_to_street_name')"/>");
		arrColumn["ship_to_post_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ship_to_post_code')"/>");
		arrColumn["ship_to_town_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ship_to_town_name')"/>");
		arrColumn["ship_to_country_sub_div"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ship_to_country_sub_div')"/>");
		arrColumn["ship_to_country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ship_to_country')"/>");
		arrColumn["consgn_abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_consgn_abbv_name')"/>");
		arrColumn["consgn_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_consgn_name')"/>");
		arrColumn["consgn_bei"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_consgn_bei')"/>");
		arrColumn["consgn_street_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_consgn_street_name')"/>");
		arrColumn["consgn_post_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_consgn_post_code')"/>");
		arrColumn["consgn_town_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_consgn_town_name')"/>");
		arrColumn["consgn_country_sub_div"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_consgn_country_sub_div')"/>");
		arrColumn["consgn_country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_consgn_country')"/>");
		arrColumn["goods_desc"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_goods_desc')"/>");
		arrColumn["part_ship"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_part_ship')"/>");
		arrColumn["tran_ship"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_tran_ship')"/>");
		arrColumn["last_ship_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_last_ship_date')"/>");
		arrColumn["nb_mismatch"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_nb_mismatch')"/>");
		arrColumn["full_match"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_full_match')"/>");
		arrColumn["total_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_total_amt')"/>");
		arrColumn["total_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_total_cur_code')"/>");
		arrColumn["total_net_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_total_net_amt')"/>");
		arrColumn["total_net_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_total_net_cur_code')"/>");
		arrColumn["order_total_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_order_total_amt')"/>");
		arrColumn["order_total_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_order_total_cur_code')"/>");
		arrColumn["order_total_net_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_order_total_net_amt')"/>");
		arrColumn["order_total_net_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_order_total_net_cur_code')"/>");
		arrColumn["accpt_total_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_accpt_total_amt')"/>");
		arrColumn["accpt_total_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_accpt_total_cur_code')"/>");
		arrColumn["accpt_total_net_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_accpt_total_net_amt')"/>");
		arrColumn["accpt_total_net_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_accpt_total_net_cur_code')"/>");
		arrColumn["liab_total_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_liab_total_amt')"/>");
		arrColumn["liab_total_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_liab_total_cur_code')"/>");
		arrColumn["liab_total_net_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_liab_total_net_amt')"/>");
		arrColumn["liab_total_net_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_liab_total_net_cur_code')"/>");
		arrColumn["fin_inst_bic"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_fin_inst_bic')"/>");
		arrColumn["fin_inst_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_fin_inst_name')"/>");
		arrColumn["fin_inst_street_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_fin_inst_street_name')"/>");
		arrColumn["fin_inst_post_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_fin_inst_post_code')"/>");
		arrColumn["fin_inst_town_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_fin_inst_town_name')"/>");
		arrColumn["fin_inst_country_sub_div"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_fin_inst_country_sub_div')"/>");
		arrColumn["fin_inst_country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_fin_inst_country')"/>");
		arrColumn["seller_account_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_seller_account_name')"/>");
		arrColumn["seller_account_iban"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_seller_account_iban')"/>");
		arrColumn["seller_account_bban"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_seller_account_bban')"/>");
		arrColumn["seller_account_upic"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_seller_account_upic')"/>");
		arrColumn["seller_account_dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_seller_account_dom')"/>");
		arrColumn["seller_account_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_seller_account_id')"/>");
		arrColumn["reqrd_commercial_dataset"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_reqrd_commercial_dataset')"/>");
		arrColumn["reqrd_transport_dataset"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_reqrd_transport_dataset')"/>");
		arrColumn["last_match_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_last_match_date')"/>");
		//arrColumn["submitr_bic"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_submitr_bic')"/>");
		//arrColumn["data_set_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_data_set_id')"/>");
		arrColumn["freight_charges_type"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_freight_charges_type')"/>");
		//arrColumn["version"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_version')"/>");
		arrColumn["line_item_number"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_line_item_number')"/>");
		arrColumn["po_ref_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_po_ref_id')"/>");
		arrColumn["qty_unit_measr_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_qty_unit_measr_code')"/>");
		arrColumn["qty_other_unit_measr"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_qty_other_unit_measr')"/>");
		arrColumn["qty_val"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_qty_val')"/>");
		arrColumn["qty_factor"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_qty_factor')"/>");
		arrColumn["qty_tol_pstv_pct"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_qty_tol_pstv_pct')"/>");
		arrColumn["qty_tol_neg_pct"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_qty_tol_neg_pct')"/>");
		arrColumn["price_unit_measr_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_price_unit_measr_code')"/>");
		arrColumn["price_other_unit_measr"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_price_other_unit_measr')"/>");
		arrColumn["price_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_price_amt')"/>");
		arrColumn["price_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_price_cur_code')"/>");
		arrColumn["price_factor"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_price_factor')"/>");
		arrColumn["price_tol_pstv_pct"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_price_tol_pstv_pct')"/>");
		arrColumn["price_tol_neg_pct"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_price_tol_neg_pct')"/>");
		arrColumn["product_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_product_name')"/>");
		arrColumn["product_orgn"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_product_orgn')"/>");
		
		//New Invoice columns
		arrColumn["adjustment_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_adjustment_cur_code')"/>");
		arrColumn["adjustment_direction"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_adjustment_direction')"/>");
		arrColumn["charges_repayment_amt"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_charges_repayment_amt')"/>");
		arrColumn["charges_repayment_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_charges_repayment_cur_code')"/>");
		arrColumn["face_total_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_face_total_cur_code')"/>");
		arrColumn["finance_repayment_action"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_finance_repayment_action')"/>");
		arrColumn["finance_repayment_amt"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_finance_repayment_amt')"/>");
		arrColumn["finance_repayment_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_finance_repayment_cur_code')"/>");
		arrColumn["finance_repayment_eligible"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_finance_repayment_eligible')"/>");
		arrColumn["finance_requested_amt"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_finance_requested_amt')"/>");
		arrColumn["finance_requested_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_finance_requested_cur_code')"/>");
		arrColumn["fin_date"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_fin_date')"/>");
		arrColumn["fin_due_date"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_fin_due_date')"/>");
		arrColumn["interest_repayment_amt"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_interest_repayment_amt')"/>");
		arrColumn["interest_repayment_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_interest_repayment_cur_code')"/>");
		arrColumn["outstanding_repayment_amt"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_outstanding_repayment_amt')"/>");
		arrColumn["outstanding_repayment_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_outstanding_repayment_cur_code')"/>");		
		arrColumn["repay_date"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_repay_date')"/>");
		arrColumn["total_repaid_amt"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_total_repaid_amt')"/>");
		arrColumn["total_repaid_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_total_repaid_cur_code')"/>");
		arrColumn["total_adjustments"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_total_adjustments')"/>");
		arrColumn["inv_eligible_amt"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_inv_eligible_amt')"/>");
		arrColumn["inv_eligible_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_inv_eligible_cur_code')"/>");
		arrColumn["inv_eligible_pct"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_inv_eligible_pct')"/>");
		arrColumn["bulk_ref_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bulk_ref_id')"/>");
		arrColumn["bulk_tnx_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bulk_tnx_id')"/>");
		arrColumn["finance_amt"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_finance_amt')"/>");
		arrColumn["finance_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_finance_cur_code')"/>");
		arrColumn["finance_requested_flag"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_finance_requested_flag')"/>");
        // IP- Settlement - Collections
        arrColumn["settlement_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_settlement_amt')"/>");
		arrColumn["settlement_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_settlement_cur_code')"/>");
		arrColumn["settlement_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_settlement_date')"/>");
		arrColumn["settlement_percentage"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_settlement_percentage')"/>");
		arrColumn["collection_req_flag"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_collection_req_flag')"/>");
        //CREDIT NOTE Columns
        arrColumn["cn_reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cn_reference')"/>");
        arrColumn["cn_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cn_amt')"/>");
        arrColumn["cn_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cn_cur_code')"/>");
        arrColumn["tnx_val_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_tnx_val_date')"/>");
        // credit note Invoices
        arrColumn["credit_note_invoice@invoice_ref_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_credit_note_invoice@invoice_ref_id')"/>");
        arrColumn["credit_note_invoice@invoice_reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_credit_note_invoice@invoice_reference')"/>");
        arrColumn["credit_note_invoice@invoice_currency"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_credit_note_invoice@invoice_currency')"/>");
        arrColumn["credit_note_invoice@invoice_amount"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_credit_note_invoice@invoice_amount')"/>");
        arrColumn["credit_note_invoice@invoice_settlement_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_credit_note_invoice@invoice_settlement_amt')"/>");
        
		arrColumn["ObjectDataString@mur_codes_sent"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ObjectDataString@mur_codes_sent')"/>");
		arrColumn["ObjectDataString@mur_codes_ack"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ObjectDataString@mur_codes_ack')"/>");	
		arrColumn["ObjectDataString@mur_codes_nak"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ObjectDataString@mur_codes_nak')"/>");
		arrColumn["ObjectDataString@delivery_notification"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ObjectDataString@delivery_notification')"/>");

		// Cash columns
		arrColumn["fx_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_fx_cur_code')"/>");
		arrColumn["fx_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_fx_amt')"/>");
		arrColumn["near_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_near_amt')"/>");
		arrColumn["fx_liab_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_fx_liab_amt')"/>");
		arrColumn["fx_type"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_fx_type')"/>");
		arrColumn["counter_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_counter_cur_code')"/>");
		arrColumn["counter_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_counter_amt')"/>");
		arrColumn["near_counter_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_near_counter_amt')"/>");
		arrColumn["rate"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_rate')"/>");
		arrColumn["near_rate"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_near_rate')"/>");
		arrColumn["contract_type"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_contract_type')"/>");
		arrColumn["trade_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_trade_id')"/>");
		arrColumn["near_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_near_date')"/>");
		arrColumn["option_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_option_date')"/>");
		
		// Loan columns
		arrColumn["borrower_abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_borrower_abbv_name')"/>");
		arrColumn["borrower_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_borrower_name')"/>");
		arrColumn["borrower_address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_borrower_address_line_1')"/>");
		arrColumn["borrower_address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_borrower_address_line_2')"/>");
		arrColumn["borrower_dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_borrower_dom')"/>");
		//arrColumn["borrower_country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_borrower_country')"/>");
		arrColumn["borrower_reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_borrower_reference')"/>");
		arrColumn["fcn"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_fcn')"/>");
		arrColumn["ln_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ln_amt')"/>");
		arrColumn["ln_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ln_cur_code')"/>");		
		arrColumn["ln_liab_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ln_liab_amt')"/>");
		arrColumn["ln_maturity_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ln_maturity_date')"/>");		
		arrColumn["pricing_option"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_pricing_option')"/>");
		arrColumn["repricing_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_repricing_date')"/>");
		arrColumn["repricing_frequency"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_repricing_frequency')"/>");		
		arrColumn["risk_type"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_risk_type')"/>");
		arrColumn["effective_date"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_effective_date')"/>");
		arrColumn["bo_ref_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bo_ref_id')"/>");

		// Term Deposit columns
		arrColumn["td_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_td_cur_code')"/>");
		arrColumn["td_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_td_amt')"/>");
		arrColumn["td_liab_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_td_liab_amt')"/>");
		arrColumn["td_type"] = new Array("AvailableTDType", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_td_type')"/>");
		arrColumn["interest"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_interest')"/>");
		arrColumn["total_with_interest"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_total_with_interest')"/>");
		arrColumn["interest_capitalisation"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_interest_capitalisation')"/>");
		arrColumn["la_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_la_cur_code')"/>");
		arrColumn["la_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_la_amt')"/>");
		arrColumn["la_liab_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_la_liab_amt')"/>");
		arrColumn["la_type"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_la_type')"/>");
		arrColumn["ObjectDataString@maturity_instruction_name"] = new Array("AvailableTDInstructionsType", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_maturity_instruction')"/>");
		arrColumn["value_date_term_number"] = new Array("AvailableTDTenorNumber", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_value_date_term_number')"/>");
		arrColumn["value_date_term_code"] = new Array("AvailableTDTenorCode", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_value_date_term_code')"/>");
		
		//Bulk columns
		arrColumn["action_req_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_action_req_code')"/>");
		arrColumn["applicant_act_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_applicant_act_cur_code')"/>");
		arrColumn["applicant_act_desc"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_applicant_act_desc')"/>");
		arrColumn["applicant_act_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_applicant_act_name')"/>");
		arrColumn["record_number"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_record_number')"/>");
		arrColumn["description"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_description')"/>");
		arrColumn["child_product_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_child_product_code')"/>");
		arrColumn["child_sub_product_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_child_sub_product_code')"/>");
		arrColumn["bk_highest_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bk_highest_amt')"/>");
		arrColumn["bk_total_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bk_total_amt')"/>");
		arrColumn["bk_type"] = new Array("AvailableBulkType", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bk_type')"/>");
		arrColumn["ObjectDataString@payroll_type"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_payroll_type')"/>");
		arrColumn["bulk_ref_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bulk_ref_id')"/>");
		arrColumn["template_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_template_id')"/>");
		arrColumn["applicant_abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_applicant_abbv_name')"/>");
		arrColumn["upload_file_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_upload_file_id')"/>");
		arrColumn["value_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_value_date')"/>");
		arrColumn["batch_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_batch_id')"/>");
		arrColumn["bulk_tnx_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bulk_tnx_id')"/>");
		//New Bulk columns		
		arrColumn["bk_fin_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bk_fin_amt')"/>");
		arrColumn["bk_fin_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bk_fin_cur_code')"/>");
		arrColumn["child_product_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_child_product_code')"/>");
		arrColumn["bk_repay_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bk_repay_date')"/>");
		arrColumn["bk_repaid_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bk_repaid_amt')"/>");
		arrColumn["bk_repaid_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bk_repaid_cur_code')"/>");
				
		// Account Statement Line columns
		//arrColumn["line_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ACCOUNT_STATEMENT_LINE_ID')"/>");
		arrColumn["post_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ACCOUNT_STATEMENT_LINE_POST_DATE')"/>");
		arrColumn["type"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ACCOUNT_STATEMENT_LINE_TYPE')"/>");
		arrColumn["entry_type"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ACCOUNT_STATEMENT_LINE_ENTRY_TYPE')"/>");
		arrColumn["description"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ACCOUNT_STATEMENT_LINE_DESCRIPTION')"/>");
		arrColumn["runbal_booked"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ACCOUNT_STATEMENT_LINE_RUNBAL_BOOKED')"/>");
		arrColumn["runbal_cleared"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ACCOUNT_STATEMENT_LINE_RUNBAL_CLEARED')"/>");
		//arrColumn["Statement@statement_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ACCOUNT_STATEMENT_ID')"/>");
		arrColumn["Statement@type"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ACCOUNT_STATEMENT_TYPE')"/>");
		arrColumn["Statement@reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ACCOUNT_STATEMENT_REF')"/>");
		arrColumn["Statement@description"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ACCOUNT_STATEMENT_DESC')"/>");
		arrColumn["reference_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ACCOUNT_STATEMENT_REFERENCE_1')"/>");
		arrColumn["reference_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ACCOUNT_STATEMENT_REFERENCE_2')"/>");
		arrColumn["reference_3"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ACCOUNT_STATEMENT_REFERENCE_3')"/>");
		arrColumn["reference_4"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ACCOUNT_STATEMENT_REFERENCE_4')"/>");
		arrColumn["reference_5"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ACCOUNT_STATEMENT_REFERENCE_5')"/>");
		arrColumn["deposit"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_DEPOSIT')"/>");
		arrColumn["withdrawal"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_WITHDRAWAL')"/>");
        arrColumn["Statement@Account@account_no"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ACCOUNT_NO')"/>");
		arrColumn["bo_ref_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bo_ref_id1')"/>");
		
		// Account Statement columns
		arrColumn["account@account_no"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ACCOUNT_NO')"/>");
		arrColumn["line@value_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_value_date')"/>");
		arrColumn["line@cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cur_code')"/>", "Currency");
		arrColumn["line@amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_amt')"/>");
		arrColumn["line@type"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ACCOUNT_STATEMENT_LINE_TYPE')"/>");
		arrColumn["line@cust_ref_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cust_ref_id')"/>");
		arrColumn["line@bo_ref_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bo_ref_id')"/>");
		arrColumn["line@entry_type"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ACCOUNT_STATEMENT_LINE_ENTRY_TYPE')"/>");
		arrColumn["line@description"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ACCOUNT_STATEMENT_LINE_DESCRIPTION')"/>");
		arrColumn["line@runbal_booked"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ACCOUNT_STATEMENT_LINE_RUNBAL_BOOKED')"/>");
		arrColumn["line@runbal_cleared"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ACCOUNT_STATEMENT_LINE_RUNBAL_CLEARED')"/>");
		arrColumn["line@post_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ACCOUNT_STATEMENT_LINE_POST_DATE')"/>");
		arrColumn["line@deposit"] = new Array("Amount", "Deposit");
		arrColumn["line@withdrawal"] = new Array("Amount", "Withdrawl");
		arrColumn["line@entity"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_entity')"/>");

		
		// Sweep columns
		arrColumn["concentration_account_no"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SP_CONCENTRATIION_ACCT')"/>");
		arrColumn["concentration_account_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SP_CONCENTRATIION_CUR_CODE')"/>");
		arrColumn["sweeping_description"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SP_DESCRIPTION')"/>");
		arrColumn["sweep_method"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SP_METHOD')"/>");
		arrColumn["start_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SP_START_DATE')"/>");
		arrColumn["end_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SP_END_DATE')"/>");
		arrColumn["ceiling_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SP_CEILING_AMT')"/>");
		arrColumn["ceiling_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SP_CEILING_CUR_CODE')"/>");
		arrColumn["floor_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SP_FLOOR_AMT')"/>");
		arrColumn["floor_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_SP_FLOOR_CUR_CODE')"/>");
		arrColumn["ObjectDataString@sub_product_code_text"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ObjectDataString@sub_product_code_text')"/>");
		
		arrColumn["ObjectDataDate@extend_pay_date"]    = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_extend_pay_date')"/>");
		arrColumn["ObjectDataDate@latest_date_reply"]    = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_latest_date_reply')"/>");	
		// Attchment columns
		arrColumn["Attachment@title"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Attachment@title')"/>");
		arrColumn["Attachment@description"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Attachment@description')"/>");
		arrColumn["Attachment@file_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Attachment@file_name')"/>");
		arrColumn["Attachment@type"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Attachment@type')"/>");
		arrColumn["Attachment@status"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Attachment@status')"/>");
		// Issued Stand by LC type columns
		arrColumn["product_type_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'STANDBY_ISSUED_TYPE')"/>");
		arrColumn["stand_by_lc_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'STANDBY_ISSUED_ID')"/>");
		arrColumn["standby_rule_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'RULE_APPLICABLE')"/>");
		arrColumn["final_expiry_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'RENEWAL_FINAL_EXPIRY_DATE')"/>");
		arrColumn["projected_expiry_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'RENEWAL_PROJECTED_EXPIRY_DATE')"/>");
		
		arrColumn["abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_abbv_name')"/>");
		arrColumn["actv_flag"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_ACTV_FLAG')"/>");
		arrColumn["address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_ADDRESS_LINE_1')"/>");
		arrColumn["address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_ADDRESS_LINE_2')"/>");
		arrColumn["base_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_BASE_CUR_CODE')"/>");
		arrColumn["company_group"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COMPANY_GROUP')"/>");
		arrColumn["country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COUNTRY')"/>");
		arrColumn["dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_DOM')"/>");
		arrColumn["iso_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_ISO_CODE')"/>");
		arrColumn["language"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LANGUAGE')"/>");
		arrColumn["owner_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_OWNER_ID')"/>");
		arrColumn["phone"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_PHONE')"/>");
		arrColumn["rolename"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_ROLENAME')"/>");
		arrColumn["permission"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_permission')"/>");
		arrColumn["role_description"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_role_description')"/>");
		arrColumn["EntityRolePermission@entity_abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EntityRolePermission@entity_abbv_name')"/>");
		arrColumn["EntityRolePermission@address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EntityRolePermission@ADDRESS_LINE_1')"/>");
		arrColumn["EntityRolePermission@address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EntityRolePermission@ADDRESS_LINE_2')"/>");
		arrColumn["EntityRolePermission@dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EntityRolePermission@DOM')"/>");
		arrColumn["EntityRolePermission@country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EntityRolePermission@COUNTRY')"/>");
		arrColumn["EntityRolePermission@bei"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EntityRolePermission@BEI')"/>");
		arrColumn["EntityRolePermission@post_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EntityRolePermission@POST_CODE')"/>");
		arrColumn["EntityRolePermission@town_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EntityRolePermission@TOWN_NAME')"/>");
		arrColumn["EntityRolePermission@country_sub_div"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EntityRolePermission@COUNTRY_SUB_DIV')"/>");
		arrColumn["EntityRolePermission@crm_email"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EntityRolePermission@CRM_EMAIL')"/>");
		arrColumn["UserRolePermission@actv_flag"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UserRolePermission@ACTV_FLAG')"/>");
		arrColumn["UserRolePermission@address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UserRolePermission@ADDRESS_LINE_1')"/>");
		arrColumn["UserRolePermission@address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UserRolePermission@ADDRESS_LINE_2')"/>");
		arrColumn["UserRolePermission@country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UserRolePermission@COUNTRY')"/>");
		arrColumn["UserRolePermission@cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UserRolePermission@CUR_CODE')"/>");
		arrColumn["UserRolePermission@email"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UserRolePermission@EMAIL')"/>");
		arrColumn["UserRolePermission@pending_trans_notify"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UserRolePermission@PENDING_TRANS_NOTIFY')"/>");
		arrColumn["UserRolePermission@language"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UserRolePermission@LANGUAGE')"/>");
		arrColumn["UserRolePermission@login_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UserRolePermission@LOGIN_ID')"/>");
		arrColumn["UserRolePermission@phone"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UserRolePermission@PHONE')"/>");
		arrColumn["UserRolePermission@time_zone"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UserRolePermission@TIME_ZONE')"/>");
		arrColumn["UserRolePermission@country_sub_div"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UserRolePermission@COUNTRY_SUB_DIV')"/>");
		arrColumn["UserRolePermission@county"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UserRolePermission@COUNTY')"/>");
		arrColumn["UserRolePermission@country_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UserRolePermission@COUNTRY_NAME')"/>");
		arrColumn["UserRolePermission@first_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UserRolePermission@first_name')"/>");
		arrColumn["UserRolePermission@last_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UserRolePermission@last_name')"/>");
		arrColumn["LinkedBank@bank_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LinkedBank@bank_name')"/>");
		arrColumn["finance_offer_flag"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_fin_offer_flag')"/>");
		
		
		//Company profile columns
		arrColumn["name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_company_name')"/>");
		arrColumn["actv_flag"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_ACTV_FLAG')"/>");	
		arrColumn["contact_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_contact_name')"/>");
		arrColumn["email"] =  new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CompanyProfile@email')"/>");
		arrColumn["fax"] =  new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CompanyProfile@fax')"/>");
		arrColumn["telex"] =  new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CompanyProfile@telex')"/>");
		arrColumn["authorize_own_transaction"] =  new Array("AvailableBooleanStrings", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CompanyProfile@authorize_own_transaction')"/>");
		arrColumn["contract_reference"] =  new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_contract_ref')"/>");
		arrColumn["NewsChannel@channel_name"] =  new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_internal_channel')"/>");
		arrColumn["dual_control"] =  new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CompanyProfile@dualcontrol')"/>");
		arrColumn["web_address"] =  new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CompanyProfile@webaddress')"/>");
		arrColumn["bei"] =  new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CompanyProfile@bei')"/>");
		arrColumn["street_name"] =  new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CompanyProfile@street_name')"/>");
		arrColumn["post_code"] =  new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CompanyProfile@post_code')"/>");
		arrColumn["town_name"] =  new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CompanyProfile@town_name')"/>");
		arrColumn["country_sub_div"] =  new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CompanyProfile@country_sub_div')"/>");
		arrColumn["crm_email"] =  new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CompanyProfile@crm_email')"/>");
		arrColumn["country_name"] =  new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CompanyProfile@country_name')"/>");
		arrColumn["CustomerReference@reference"] =  new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CompanyProfile@reference')"/>");
		arrColumn["CustomerReference@description"] =  new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CompanyProfile@description')"/>");
		arrColumn["CustomerAccount@Account@account_no"] =  new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CompanyProfile@CustomerAccount@Account@account_no')"/>"); 
		arrColumn["CustomerAccount@Account@acct_name"] =  new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CompanyProfile@CustomerAccount@Account@acct_name')"/>"); 
		arrColumn["CustomerAccount@Account@description"] =  new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CompanyProfile@CustomerAccount@Account@description')"/>");   	
		arrColumn["legal_id_no"] =  new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CompanyProfile@legal_id_no')"/>");
		arrColumn["legal_id_type"] =  new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CompanyProfile@legal_id_type')"/>");
		arrColumn["country_legalid"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CompanyProfile@country_legalid')"/>");
		
		
		//User profile columns
        arrColumn["User@actv_flag"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UserRolePermission@ACTV_FLAG')"/>");
		arrColumn["User@address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UserRolePermission@ADDRESS_LINE_1')"/>");
		arrColumn["User@address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UserRolePermission@ADDRESS_LINE_2')"/>");
		arrColumn["User@country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UserRolePermission@COUNTRY')"/>");
		arrColumn["User@cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UserRolePermission@CUR_CODE')"/>");
		arrColumn["User@email"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UserRolePermission@EMAIL')"/>");
		arrColumn["User@pending_trans_notify"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UserRolePermission@PENDING_TRANS_NOTIFY')"/>");
		arrColumn["User@language"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UserRolePermission@LANGUAGE')"/>");
		arrColumn["User@login_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UserRolePermission@LOGIN_ID')"/>");
		arrColumn["User@phone"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UserRolePermission@PHONE')"/>");
		arrColumn["User@time_zone"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UserRolePermission@TIME_ZONE')"/>");
		arrColumn["User@country_sub_div"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UserRolePermission@COUNTRY_SUB_DIV')"/>");
		arrColumn["User@county"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UserRolePermission@COUNTY')"/>");
		arrColumn["User@country_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UserRolePermission@COUNTRY_NAME')"/>");
		arrColumn["User@first_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UserRolePermission@first_name')"/>");
		arrColumn["User@last_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UserRolePermission@last_name')"/>");
		arrColumn["User@employee_no"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_User@employee_no')"/>");
		arrColumn["User@employee_department"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_User@employee_department')"/>");
		arrColumn["User@fax"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_User@FAX')"/>");
		arrColumn["User@pending_trans_notify"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_User@pending_trans_notify')"/>");
		arrColumn["User@dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_User@dom')"/>");
		arrColumn["User@company_abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_User@company_abbv_name')"/>");
		arrColumn["UserGroupRole@Role@rolename"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UserGroupRole@Role@rolename')"/>");
		arrColumn["UserGroupRole@limit_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_UserGroupRole@limit_amt')"/>");
		arrColumn["User@legal_country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_User@legal_country')"/>");
		arrColumn["User@legal_no"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_User@legal_no')"/>");
		arrColumn["User@legal_type"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_User@legal_type')"/>");
		
		//Entity Columns
		arrColumn["Entity@name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_Entity@name')"/>");
		arrColumn["Entity@abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EntityRolePermission@entity_abbv_name')"/>");
		arrColumn["Entity@address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EntityRolePermission@ADDRESS_LINE_1')"/>");
		arrColumn["Entity@address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EntityRolePermission@ADDRESS_LINE_2')"/>");
		arrColumn["Entity@dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EntityRolePermission@DOM')"/>");
		arrColumn["Entity@country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EntityRolePermission@COUNTRY')"/>");
		arrColumn["Entity@bei"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EntityRolePermission@BEI')"/>");
		arrColumn["Entity@post_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EntityRolePermission@POST_CODE')"/>");
		arrColumn["Entity@town_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EntityRolePermission@TOWN_NAME')"/>");
		arrColumn["Entity@country_sub_div"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EntityRolePermission@COUNTRY_SUB_DIV')"/>");
		arrColumn["Entity@ObjectDataString@authorize_own_transaction"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_Entity@authorize_own_transaction')"/>");
		arrColumn["Entity@crm_email"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_EntityRolePermission@CRM_EMAIL')"/>");
		arrColumn["Entity@EntityReference@reference"] =  new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_Entity@reference')"/>");
		arrColumn["Entity@EntityReference@description"] =  new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_Entity@description')"/>");
		arrColumn["Entity@company_abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_Entity@company_abbv_name')"/>");
		arrColumn["Entity@ObjectDataString@legal_id_type"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_Entity@legal_id_type')"/>");
		arrColumn["Entity@ObjectDataString@legal_id_no"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_Entity@legal_id_no')"/>");
		arrColumn["Entity@ObjectDataString@country_legalid"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_Entity@country_legalid')"/>");
		
		//Facility Limit Columns
		arrColumn["facility_reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_facility_reference')"/>");
		arrColumn["company_abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_abbv_name')"/>");
		arrColumn["bank_abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_bank_abbv_name')"/>");
		arrColumn["facility_description"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'FACILITY_DESCRIPTION')"/>");
		arrColumn["facility_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'FACILITY_AMT')"/>");
		arrColumn["utilised_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_utilised_amt')"/>");
		arrColumn["outstanding_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_outstanding_amt')"/>");
		arrColumn["review_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_review_date')"/>");
		arrColumn["facility_pricing_details"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_facility_facility_pricing_details')"/>");
		arrColumn["bo_reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_facility_bo_reference')"/>");
		arrColumn["facility_status"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_facility_status')"/>");
		arrColumn["facility_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_facility_cur_code')"/>");
		arrColumn["FacilityEntity@entity_abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FACILITY_ENTITY')"/>");
		
		arrColumn["LimitMaster@limit_reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_limit_reference')"/>");
		arrColumn["LimitMaster@limit_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_limit_cur_code')"/>");
		arrColumn["LimitMaster@limit_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_limit_amt')"/>");
		arrColumn["LimitMaster@utilised_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_utilised_amt')"/>");
		arrColumn["LimitMaster@outstanding_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_LIMIT_OUTSTANDING')"/>");
		arrColumn["LimitMaster@review_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LIMIT_review_date')"/>");
		arrColumn["LimitMaster@limit_pricing_details"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_limit_pricing_details')"/>");
		arrColumn["LimitMaster@product_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_LIMIT_PRODUCT_HEADER')"/>");
		arrColumn["LimitMaster@sub_product_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_LIMIT_SUB_PRODUCT_HEADER')"/>");
		arrColumn["LimitMaster@product_type_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_product_type_code')"/>");
		arrColumn["LimitMaster@product_template"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_LIMIT_PRODUCT_TEMPLATE')"/>");
		arrColumn["LimitMaster@counterparty"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LIMIT_counterparty')"/>");
		arrColumn["LimitMaster@country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LIMIT_country')"/>");
		arrColumn["LimitMaster@status"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_FACILITY_LIMIT_STATUS')"/>");

		arrColumn["LimitMaster@LimitEntity@entity_abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_LIMIT_ENTITY')"/>");
		
		arrColumn["sub_product_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_sub_product_code')"/>");
		arrColumn["original_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_original_amt')"/>");
		arrColumn["original_counter_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_original_counter_amt')"/>");
		arrColumn["applicant_act_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_applicant_act_name')"/>");
		arrColumn["applicant_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_applicant_name')"/>");

				arrColumn["applicant_act_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_applicant_act_cur_code')"/>");
		arrColumn["applicant_act_description"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_applicant_act_description')"/>");
		
		//CREDIT NOTE Columns
 	    arrColumn["cn_reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cn_reference')"/>");
 		arrColumn["cn_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cn_amt')"/>");
 	    arrColumn["cn_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cn_cur_code')"/>");
 	    arrColumn["tnx_val_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_tnx_val_date')"/>");
 	    arrColumn["credit_note_invoice@invoice_ref_id"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_credit_note_invoice@invoice_ref_id')"/>");
        arrColumn["credit_note_invoice@invoice_reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_credit_note_invoice@invoice_reference')"/>");
        arrColumn["credit_note_invoice@invoice_currency"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_credit_note_invoice@invoice_currency')"/>");
        arrColumn["credit_note_invoice@invoice_amount"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_credit_note_invoice@invoice_amount')"/>");
 		arrColumn["credit_note_invoice@invoice_settlement_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_credit_note_invoice@invoice_settlement_amt')"/>");
 		       
		arrColumn["inc_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_inc_amt')"/>");
		arrColumn["dec_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_dec_amt')"/>");
		arrColumn["org_lc_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_org_lc_amt')"/>");
		<!-- MPS-41651  Available Amount -->
		arrColumn["bg_available_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bg_available_amt')"/>");
		arrColumn["lc_available_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_lc_available_amt')"/>");
		arrColumn["fin_outstanding_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_fin_outstanding_amt')"/>");
		arrColumn["ic_outstanding_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ic_outstanding_amt')"/>");
		arrColumn["ec_outstanding_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ec_outstanding_amt')"/>");
		arrColumn["applicable_rules"]  = new Array("arrValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'RULE_APPLICABLE')"/>");
		
		<!-- Swift 2020 IU Columns -->
		<xsl:choose>	
		<xsl:when test="$swift2019Enabled">
			arrColumn["bg_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Undertaking_amt')"/>");
			arrColumn["bg_available_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Undertaking_available_amt')"/>");
			arrColumn["bg_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Undertaking_cur_code')"/>");
			
			arrColumn["bg_release_flag"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Undertaking_release_flag')"/>");
			arrColumn["bg_rule"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Undertaking_rule')"/>");
			arrColumn["bg_rule_other"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Undertaking_rule_other')"/>");
			arrColumn["bg_text_type_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Undertaking_text_type_code')"/>");
			arrColumn["bg_text_type_details"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Undertaking_text_type_details')"/>");
			arrColumn["bg_type_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Undertaking_type_code')"/>");
			arrColumn["bg_type_details"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Undertaking_type_details')"/>");
			arrColumn["contact_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bene_contact_name')"/>");
			arrColumn["contact_address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bene_contact_address_line_1')"/>");
			arrColumn["contact_address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bene_contact_address_line_2')"/>");
			arrColumn["contact_dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bene_contact_dom')"/>");
			arrColumn["contact_country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bene_contact_country')"/>");
			arrColumn["contact_address_line_4"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bene_contact_address_line_4')"/>");
			arrColumn["RecipientBank@iso_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_RecipientBank@identifier')"/>");
			arrColumn["bg_outstanding_amt"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Undertaking_outstanding_amt')"/>");
			arrColumn["bg_liab_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Undertaking_liab_amt')"/>");
		</xsl:when>
		<xsl:otherwise>
			arrColumn["bg_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bg_amt')"/>");
			arrColumn["bg_available_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bg_available_amt')"/>");
			arrColumn["bg_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bg_cur_code')"/>", "Currency");
			arrColumn["bg_liab_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bg_liab_amt')"/>");
			arrColumn["bg_release_flag"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bg_release_flag')"/>");
			arrColumn["bg_rule"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bg_rule')"/>");
			arrColumn["bg_rule_other"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bg_rule_other')"/>");
			arrColumn["bg_text_type_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bg_text_type_code')"/>");
			arrColumn["bg_text_type_details"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bg_text_type_details')"/>");
			arrColumn["bg_type_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bg_type_code')"/>");
			arrColumn["bg_type_details"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bg_type_details')"/>");
			arrColumn["contact_address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_contact_address_line_1')"/>");
			arrColumn["contact_address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_contact_address_line_2')"/>");
			arrColumn["contact_dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_contact_dom')"/>");
			arrColumn["contact_country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_contact_country')"/>");
			arrColumn["contact_address_line_4"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_contact_address_line_4')"/>");
			arrColumn["RecipientBank@iso_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_RecipientBank@iso_code')"/>");
			arrColumn["bg_outstanding_amt"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bg_outstanding_amt')"/>");
		</xsl:otherwise>
		</xsl:choose>
		
		arrColumn["AdviseThruBank@name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AdviseThruBank@name')"/>");
		arrColumn["AdviseThruBank@address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AdviseThruBank@address_line_1')"/>");
		arrColumn["AdviseThruBank@address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AdviseThruBank@address_line_2')"/>");
		arrColumn["AdviseThruBank@dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AdviseThruBank@dom')"/>");
		arrColumn["AdviseThruBank@address_line_4"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AdviseThruBank@address_line_4')"/>");
		
		arrColumn["ProcessingBank@name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ProcessingBank@name')"/>");
		arrColumn["ProcessingBank@address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ProcessingBank@address_line_1')"/>");
		arrColumn["ProcessingBank@address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ProcessingBank@address_line_2')"/>");
		arrColumn["ProcessingBank@dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ProcessingBank@dom')"/>");
		arrColumn["ProcessingBank@address_line_4"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ProcessingBank@address_line_4')"/>");
		
		<xsl:if test="$swift2019Enabled">
			arrColumn["additional_cust_ref"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_iu_additional_cust_ref')"/>");
			arrColumn["purpose"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Undertaking_purpose')"/>");
			arrColumn["approx_expiry_date"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Undertaking_approx_exp_date')"/>");
			arrColumn["bei_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Undertaking_bei_CODE')"/>");
			arrColumn["bg_conf_instructions"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Undertaking_confirmation_instructions')"/>");
			arrColumn["bg_govern_country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Undertaking_governing_law_country')"/>");
			arrColumn["bg_govern_text"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Undertaking_governing_law_text')"/>");
		</xsl:if>
		
		arrColumn["bg_transfer_indicator"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_transfer_indicator')"/>");
		
		<xsl:if test="$swift2019Enabled">
			arrColumn["bg_demand_indicator"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Undertaking_demand_indicator')"/>");
			arrColumn["bg_special_terms"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Undertaking_special_terms')"/>");
			arrColumn["send_attachments_by"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_iu_send_attachments_by')"/>");
			arrColumn["cu_effective_date_type_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_effective_date')"/>");
			arrColumn["cu_exp_date_type_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_expiry_type')"/>");
			arrColumn["cu_exp_date"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_expiry_date')"/>");
			arrColumn["cu_effective_date_type_details"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_expiry_date_details')"/>");
			arrColumn["cu_beneficiary_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_bene_name')"/>");
			arrColumn["cu_bei_Code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_bene_bic_code')"/>");
			arrColumn["cu_beneficiary_address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_bene_address_line_1')"/>");
			arrColumn["cu_beneficiary_address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_bene_address_line_2')"/>");
			arrColumn["cu_beneficiary_dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_bene_dom')"/>");
			arrColumn["cu_beneficiary_address_line_4"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_bene_address_line_4')"/>");
			arrColumn["cu_beneficiary_country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_bene_country')"/>");
			arrColumn["cu_contact_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_contact_name')"/>");
			arrColumn["cu_contact_address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_contact_addr_1')"/>");
			arrColumn["cu_contact_address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_contact_addr_2')"/>");
			arrColumn["cu_contact_dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_contact_addr_3')"/>");
			arrColumn["cu_contact_address_line_4"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_contact_addr_4')"/>");
			arrColumn["cu_sub_product_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_form_of_undertaking')"/>");
			arrColumn["cu_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_undertaking_curr')"/>");
			arrColumn["cu_amt"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_undertaking_amt')"/>");
			arrColumn["cu_tolerance_positive_pct"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_undertaking_amt_tolerance_pos')"/>");
			arrColumn["cu_tolerance_negative_pct"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_undertaking_amt_tolerance_neg')"/>");
			arrColumn["cu_consortium"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_consortium')"/>");
			arrColumn["cu_net_exposure_amt"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_net_exposure_amt')"/>");
			arrColumn["cu_net_exposure_cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_net_exposure_curr')"/>");
			arrColumn["cu_renew_flag"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_renew_flag')"/>");
			arrColumn["cu_renew_on_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_renew_on')"/>");
			arrColumn["cu_renewal_calendar_date"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_renew_on_date')"/>");
			arrColumn["cu_renew_for_nb"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_renew_for')"/>");
			arrColumn["cu_renew_for_period"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_renew_period')"/>");
			arrColumn["cu_advise_renewal_flag"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_advise_renewal_flag')"/>");
			arrColumn["cu_advise_renewal_days_nb"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_advise_days_notice')"/>");
			arrColumn["cu_rolling_renewal_flag"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_rolling_renewal')"/>");
			arrColumn["cu_rolling_renew_on_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_rolling_renew_on')"/>");
			arrColumn["cu_rolling_renew_for_period"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_frequency_months')"/>");
			arrColumn["cu_rolling_day_in_month"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_days_in_months')"/>");
			arrColumn["cu_rolling_renew_for_nb"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_frequency_days')"/>");
			arrColumn["cu_rolling_cancellation_days"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_cancellation_days_notice')"/>");
			arrColumn["cu_renew_amt_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_renewal_amt')"/>");
			arrColumn["cu_final_expiry_date"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_renewal_final_exp_rate')"/>");
			arrColumn["cu_rolling_renewal_nb"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_numb_of_renewals')"/>");
			arrColumn["cu_type_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_type_of_undertaking')"/>");
			arrColumn["cu_rule"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_rules_applicable')"/>");
			arrColumn["cu_rule_other"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_rules_applicable_text')"/>");
			arrColumn["cu_govern_country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_governing_law_country')"/>");
			arrColumn["cu_govern_text"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_governing_law_text')"/>");
			arrColumn["cu_text_language"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_text_lang')"/>");
			arrColumn["cu_text_language_other"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_text_lang_other')"/>");
		</xsl:if>
		
		arrColumn["applicant_address_line_4"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_applicant_address_line_4')"/>");
		arrColumn["alt_applicant_address_line_4"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_alt_applicant_address_line_4')"/>");
		arrColumn["beneficiary_address_line_4"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_beneficiary_address_line_4')"/>");
		arrColumn["adv_send_mode_text"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_adv_send_mode_text')"/>");
		<xsl:if test="$swift2019Enabled">
			arrColumn["CURecipientBank@abbv_name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_recipient_name')"/>");
			arrColumn["CURecipientBank@address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_recipient_addr_line_1')"/>");
			arrColumn["CURecipientBank@address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_recipient_addr_line_2')"/>");
			arrColumn["CURecipientBank@dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_recipient_dom')"/>");
			arrColumn["CURecipientBank@address_line_4"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_recipient_addr_line_4')"/>");
			arrColumn["CURecipientBank@iso_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_recipient_bic_code')"/>");
			arrColumn["CURecipientBank@reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_reference')"/>");
			arrColumn["CUBeneProductPartyDetails@name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_bene_name')"/>");
			arrColumn["CUBeneProductPartyDetails@bei_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_bene_bic_code')"/>");
			arrColumn["CUBeneProductPartyDetails@address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_bene_address_line_1')"/>");
			arrColumn["CUBeneProductPartyDetails@address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_bene_address_line_2')"/>");
			arrColumn["CUBeneProductPartyDetails@dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_bene_dom')"/>");
			arrColumn["CUBeneProductPartyDetails@address_line_4"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_bene_address_line_4')"/>");
			arrColumn["CUBeneProductPartyDetails@country"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_bene_country')"/>");
			
			arrColumn["CUContactProductPartyDetails@name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_contact_name')"/>");
			arrColumn["CUContactProductPartyDetails@address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_contact_addr_1')"/>");
			arrColumn["CUContactProductPartyDetails@address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_contact_addr_2')"/>");
			arrColumn["CUContactProductPartyDetails@dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_contact_addr_3')"/>");
			arrColumn["CUContactProductPartyDetails@address_line_4"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_contact_addr_4')"/>");
			arrColumn["cu_demand_indicator"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_demand_indicator')"/>");
			arrColumn["cu_transfer_indicator"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_transfer_indicator')"/>");
			arrColumn["cu_text_type_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_text_type_code')"/>");
			arrColumn["cu_text_type_details"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_text_type_details')"/>");
			arrColumn["adv_send_mode_text"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_adv_send_mode_text')"/>");
			arrColumn["delv_org_undertaking"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_del_original_undertaking')"/>");
			arrColumn["delv_org_undertaking_text"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_del_original_undertaking_text')"/>");
		</xsl:if>
		
		arrColumn["IssuingBank@iso_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_IssuingBank@iso_code')"/>");
		arrColumn["AdvisingBank@iso_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AdvisingBank@iso_code')"/>");
		arrColumn["ConfirmingBank@iso_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ConfirmingBank@iso_code')"/>");
		arrColumn["AdviseThruBank@iso_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AdviseThruBank@iso_code')"/>");
		arrColumn["ProcessingBank@iso_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_ProcessingBank@iso_code')"/>");
		
		<xsl:if test="$swift2019Enabled">
			arrColumn["IssuedUndertaking@sub_product_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_IssuedUndertaking@form_of_undertaking')"/>");
			arrColumn["IssuingBankIU@dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_IssuingBankIU@dom')"/>");
			arrColumn["AdvisingBankIU@dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_AdvisingBankIU@dom')"/>");
			arrColumn["RecipientBankIU@dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_RecipientBankIU@dom')"/>");
			arrColumn["IssuedUndertaking@alt_applicant_dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_IssuedUndertaking@alt_applicant_dom')"/>");
			arrColumn["lead_bank_flag"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_lead_bank_flag')"/>");
			arrColumn["cu_conf_instructions"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_conf_instructions')"/>");
					
			arrColumn["tolerance_positive_pct"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Undertaking_amt_tolerance_pos')"/>");
			arrColumn["tolerance_negative_pct"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Undertaking_amt_tolerance_neg')"/>");
			arrColumn["extended_date"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_EXTENDED_DATE')"/>");
			
			arrColumn["Variation@advise_flag"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Variation@advise_flag')"/>");
			arrColumn["Variation@advise_reduction_days"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Variation@advise_reduction_days')"/>");
			arrColumn["Variation@amount"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Variation@amount')"/>");
			arrColumn["Variation@cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Variation@cur_code')"/>");
			arrColumn["Variation@day_in_month"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Variation@day_in_month')"/>");
			arrColumn["Variation@first_date"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Variation@first_date')"/>");
			arrColumn["Variation@frequency"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Variation@frequency')"/>");
			arrColumn["Variation@maximum_nb_days"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Variation@maximum_nb_days')"/>");
			arrColumn["Variation@operation"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Variation@operation')"/>");
			arrColumn["Variation@percentage"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Variation@percent')"/>");
			arrColumn["Variation@period"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Variation@period')"/>");
			arrColumn["Variation@section_type"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Variation@section_type')"/>");
			arrColumn["Variation@type"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Variation@type')"/>");
			
			arrColumn["RuVariation@advise_flag"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Variation@advise_flag')"/>");
			arrColumn["RuVariation@advise_reduction_days"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Variation@advise_reduction_days')"/>");
			arrColumn["RuVariation@amount"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Variation@amount')"/>");
			arrColumn["RuVariation@cur_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Variation@cur_code')"/>");
			arrColumn["RuVariation@day_in_month"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Variation@day_in_month')"/>");
			arrColumn["RuVariation@first_date"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Variation@first_date')"/>");
			arrColumn["RuVariation@frequency"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Variation@frequency')"/>");
			arrColumn["RuVariation@maximum_nb_days"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Variation@maximum_nb_days')"/>");
			arrColumn["RuVariation@operation"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Variation@operation')"/>");
			arrColumn["RuVariation@percentage"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Variation@percent')"/>");
			arrColumn["RuVariation@period"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Variation@period')"/>");
			arrColumn["RuVariation@section_type"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Variation@section_type')"/>");
			arrColumn["RuVariation@type"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Variation@type')"/>");
			
			arrColumn["renewal_type"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_renewal_type')"/>");
			arrColumn["cu_renewal_type"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_renewal_type')"/>");
			arrColumn["bg_tolerance_positive_pct"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bg_tolerance_positive_pct')"/>");
			arrColumn["bg_tolerance_negative_pct"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_bg_tolerance_negative_pct')"/>");
			arrColumn["part_ship"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_part_ship')"/>");
			arrColumn["tran_ship"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_tran_ship')"/>");
			arrColumn["cu_cr_avl_by_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_cr_avl_by_code')"/>");
			
			arrColumn["CreditAvailableWithBank@name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_CreditAvaialbleWithBank@name')"/>");
			arrColumn["CreditAvailableWithBank@address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_CreditAvaialbleWithBank@address_line_1')"/>");
			arrColumn["CreditAvailableWithBank@address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_CreditAvaialbleWithBank@address_line_2')"/>");
			arrColumn["CreditAvailableWithBank@dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_CreditAvaialbleWithBank@dom')"/>");
			arrColumn["CreditAvailableWithBank@address_line_4"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_CreditAvaialbleWithBank@address_line_4')"/>");
			arrColumn["CreditAvailableWithBank@iso_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_CreditAvaialbleWithBank@iso_code')"/>");
			
			arrColumn["CUCreditAvailableWithBank@name"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_CUCreditAvaialbleWithBank@name')"/>");
			arrColumn["CUCreditAvailableWithBank@address_line_1"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_CUCreditAvaialbleWithBank@address_line_1')"/>");
			arrColumn["CUCreditAvailableWithBank@address_line_2"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_CUCreditAvaialbleWithBank@address_line_2')"/>");
			arrColumn["CUCreditAvailableWithBank@dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_CUCreditAvaialbleWithBank@dom')"/>");
			arrColumn["CUCreditAvailableWithBank@address_line_4"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_CUCreditAvaialbleWithBank@address_line_4')"/>");
			arrColumn["CUCreditAvailableWithBank@iso_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_CUCreditAvaialbleWithBank@iso_code')"/>");
			
			arrColumn["maturity_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_maturity_date')"/>");
			arrColumn["latest_response_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_latest_response_date')"/>");
			arrColumn["advise_date"] = new Array("Date", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_advise_date')"/>");
			arrColumn["issuing_bank_reference"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_issuing_bank_reference')"/>");
			arrColumn["action_req_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_action_req_code')"/>");
			arrColumn["cu_liab_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_liab_amt')"/>");
			arrColumn["cu_available_amt"] = new Array("Amount", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_availabe_amt')"/>");
		</xsl:if>
		<xsl:choose>	
			<xsl:when test="$swift2019Enabled">
			arrColumn["ReceivedUndertaking@sub_product_code"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_Form_of_undertaking')"/>");
			arrColumn["IssuingBank@dom"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_IssuingBank@AddressLine3')"/>");
			arrColumn["conf_chrg_brn_by_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_iu_conf_chrg_brn_by_code')"/>");
			arrColumn["open_chrg_brn_by_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_iu_open_chrg_brn_by_code')"/>");
			arrColumn["corr_chrg_brn_by_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_iu_corr_chrg_brn_by_code')"/>");
			arrColumn["cu_open_chrg_brn_by_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_open_chrg_brn_by_code')"/>");
			arrColumn["cu_conf_chrg_brn_by_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_conf_chrg_brn_by_code')"/>");
			arrColumn["cu_corr_chrg_brn_by_code"] = new Array("ValuesSet", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_cu_corr_chrg_brn_by_code')"/>");	
			arrColumn["contract_ref"] = new Array("String", "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_COL_contract_type')"/>");
			</xsl:when>
		</xsl:choose>
		<xsl:call-template name="Client_Columns_Definitions"/>
	<!--
		//
		// Definition of set of values
		//

		arrValuesSet["bene_type_code"] = new Array(
										["01", "<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_TYPE_01_SHIPPER')"/>"],
										["02", "<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_TYPE_02_BUYER')"/>"],
										["03", "<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_TYPE_99_OTHER')"/>"]);

		-->
		
		
		arrValuesSet["Charge@chrg_code"] = new Array(
										["ISSFEE", "<xsl:value-of select="localization:getDecode($language, 'N006', 'ISSFEE')"/>"],
										["COMMISSION", "<xsl:value-of select="localization:getDecode($language, 'N006', 'COMMISSION')"/>"],
										//["POSTAGE", "<xsl:value-of select="localization:getDecode($language, 'N006', 'POSTAGE')"/>"],
										["OTHER", "<xsl:value-of select="localization:getDecode($language, 'N006', 'OTHER')"/>"]);
		arrValuesSet["value_date_term_code"] = new Array(
										["D", "<xsl:value-of select="localization:getDecode($language, 'N413', 'D')"/>"],
										["W", "<xsl:value-of select="localization:getDecode($language, 'N413', 'W')"/>"],
										["M", "<xsl:value-of select="localization:getDecode($language, 'N413', 'M')"/>"],
										["Y", "<xsl:value-of select="localization:getDecode($language, 'N413', 'Y')"/>"]);
		arrValuesSet["value_date_term_number"] = new Array(
										["1", "<xsl:value-of select="1"/>"],
										["2", "<xsl:value-of select="2"/>"],
										["3", "<xsl:value-of select="3"/>"],
										["4", "<xsl:value-of select="4"/>"],
										["5", "<xsl:value-of select="5"/>"],
										["6", "<xsl:value-of select="6"/>"],
										["7", "<xsl:value-of select="7"/>"],
										["8", "<xsl:value-of select="8"/>"],
										["9", "<xsl:value-of select="9"/>"],
										["10", "<xsl:value-of select="10"/>"],
										["11", "<xsl:value-of select="11"/>"],
										["12", "<xsl:value-of select="12"/>"]);
		
		
		arrValuesSet["Charge@status"] = new Array(
										["01", "<xsl:value-of select="localization:getDecode($language, 'N057', '01')"/>"],
										["02", "<xsl:value-of select="localization:getDecode($language, 'N057', '02')"/>"],
										["03", "<xsl:value-of select="localization:getDecode($language, 'N057', '03')"/>"],
										["99", "<xsl:value-of select="localization:getDecode($language, 'N057', '99')"/>"]);
										
		arrValuesSet["AllowanceTaxMaster@type"] = new Array(
										["COAX", "<xsl:value-of select="localization:getDecode($language, 'N210', 'COAX')"/>"],
										["CUST", "<xsl:value-of select="localization:getDecode($language, 'N210', 'CUST')"/>"],
										["NATI", "<xsl:value-of select="localization:getDecode($language, 'N210', 'NATI')"/>"],
										["PROV", "<xsl:value-of select="localization:getDecode($language, 'N210', 'PROV')"/>"],
										["STAM", "<xsl:value-of select="localization:getDecode($language, 'N210', 'STAM')"/>"],
										["STAT", "<xsl:value-of select="localization:getDecode($language, 'N210', 'STAT')"/>"],
										["VATA", "<xsl:value-of select="localization:getDecode($language, 'N210', 'VATA')"/>"],
										["WITH", "<xsl:value-of select="localization:getDecode($language, 'N210', 'WITH')"/>"]);
																				
		 arrValuesSet["AllowanceTax@type"] = new Array(
										["COAX", "<xsl:value-of select="localization:getDecode($language, 'N210', 'COAX')"/>"],
										["CUST", "<xsl:value-of select="localization:getDecode($language, 'N210', 'CUST')"/>"],
										["NATI", "<xsl:value-of select="localization:getDecode($language, 'N210', 'NATI')"/>"],
										["PROV", "<xsl:value-of select="localization:getDecode($language, 'N210', 'PROV')"/>"],
										["STAM", "<xsl:value-of select="localization:getDecode($language, 'N210', 'STAM')"/>"],
										["STAT", "<xsl:value-of select="localization:getDecode($language, 'N210', 'STAT')"/>"],
										["VATA", "<xsl:value-of select="localization:getDecode($language, 'N210', 'VATA')"/>"],
										["WITH", "<xsl:value-of select="localization:getDecode($language, 'N210', 'WITH')"/>"]);
										
		arrValuesSet["Document@code"] = new Array(

										["01", "<xsl:value-of select="localization:getDecode($language, 'C064', '01')"/>"],
										["02", "<xsl:value-of select="localization:getDecode($language, 'C064', '02')"/>"],
										["03", "<xsl:value-of select="localization:getDecode($language, 'C064', '03')"/>"],
										["04", "<xsl:value-of select="localization:getDecode($language, 'C064', '04')"/>"],
										["05", "<xsl:value-of select="localization:getDecode($language, 'C064', '05')"/>"],
										["06", "<xsl:value-of select="localization:getDecode($language, 'C064', '06')"/>"],
										["07", "<xsl:value-of select="localization:getDecode($language, 'C064', '07')"/>"],
										["08", "<xsl:value-of select="localization:getDecode($language, 'C064', '08')"/>"],
										["09", "<xsl:value-of select="localization:getDecode($language, 'C064', '09')"/>"],
										["10", "<xsl:value-of select="localization:getDecode($language, 'C064', '10')"/>"],
										["11", "<xsl:value-of select="localization:getDecode($language, 'C064', '11')"/>"],
										["12", "<xsl:value-of select="localization:getDecode($language, 'C064', '12')"/>"],
										["13", "<xsl:value-of select="localization:getDecode($language, 'C064', '13')"/>"],
										["14", "<xsl:value-of select="localization:getDecode($language, 'C064', '14')"/>"],
										["15", "<xsl:value-of select="localization:getDecode($language, 'C064', '15')"/>"],
										["99", "<xsl:value-of select="localization:getDecode($language, 'C064', '99')"/>"]);

		arrValuesSet["result"] = new Array(
        					            ["Y", "<xsl:value-of select="localization:getDecode($language, 'N019', 'Y')"/>"],
										["N", "<xsl:value-of select="localization:getDecode($language, 'N019', 'N')"/>"],
										["E", "<xsl:value-of select="localization:getDecode($language, 'N019', 'E')"/>"]);
		
		arrValuesSet["fx_type"] = new Array(
        					            ["SPOT", "<xsl:value-of select="localization:getDecode($language, 'N410', 'SPOT')"/>"],
        					            ["FORWARD", "<xsl:value-of select="localization:getDecode($language, 'N410', 'FORWARD')"/>"],
										["SWAP", "<xsl:value-of select="localization:getDecode($language, 'N410', 'SWAP')"/>"],
										["DELIVERY_OPTION", "<xsl:value-of select="localization:getDecode($language, 'N410', 'DELIVERY_OPTION')"/>"]);

		arrValuesSet["contact_type"] = new Array(
        					            ["01", "<xsl:value-of select="localization:getDecode($language, 'N411', '01')"/>"],
										["02", "<xsl:value-of select="localization:getDecode($language, 'N411', '02')"/>"],
										["03", "<xsl:value-of select="localization:getDecode($language, 'N411', '03')"/>"]);

		arrValuesSet["la_type"] = new Array(
        					            ["LOAN", "<xsl:value-of select="localization:getDecode($language, 'N415', 'LOAN')"/>"]);
		
		arrValuesSet["sweep_method"] = new Array(
        					            ["DEFICIT", "<xsl:value-of select="localization:getDecode($language, 'N418', 'DEFICIT')"/>"],
        					            ["SURPLUS", "<xsl:value-of select="localization:getDecode($language, 'N418', 'SURPLUS')"/>"],
										["DEFICIT_AND_SURPLUS", "<xsl:value-of select="localization:getDecode($language, 'N418', 'DEFICIT_AND_SURPLUS')"/>"]);
		
		arrValuesSet["Attachment@type"] = new Array(
										["01", "<xsl:value-of select="localization:getDecode($language, 'N011', '01')"/>"],
										["02", "<xsl:value-of select="localization:getDecode($language, 'N011', '02')"/>"],
										["03", "<xsl:value-of select="localization:getDecode($language, 'N011', '03')"/>"],
										["04", "<xsl:value-of select="localization:getDecode($language, 'N011', '04')"/>"],
										["05", "<xsl:value-of select="localization:getDecode($language, 'N011', '05')"/>"],
										["06", "<xsl:value-of select="localization:getDecode($language, 'N011', '06')"/>"]);
										
		arrValuesSet["Attachment@status"] = new Array(
										["01", "<xsl:value-of select="localization:getDecode($language, 'N804', '01')"/>"],
										["02", "<xsl:value-of select="localization:getDecode($language, 'N804', '02')"/>"],
										["03", "<xsl:value-of select="localization:getDecode($language, 'N804', '03')"/>"],
										["04", "<xsl:value-of select="localization:getDecode($language, 'N804', '04')"/>"],
										["05", "<xsl:value-of select="localization:getDecode($language, 'N804', '05')"/>"],
										["06", "<xsl:value-of select="localization:getDecode($language, 'N804', '06')"/>"]);
										
		arrValuesSet["finance_offer_flag"] = new Array(
										["Y", "<xsl:value-of select="localization:getDecode($language, 'N034', 'YES')"/>"],
										["N", "<xsl:value-of select="localization:getDecode($language, 'N034', 'NO')"/>"]);
																											
		arrValuesSet["UserRolePermission@pending_trans_notify"] = new Array(
										["Y", "<xsl:value-of select="localization:getDecode($language, 'N034', 'YES')"/>"],
										["N", "<xsl:value-of select="localization:getDecode($language, 'N034', 'NO')"/>"]);
										
		arrValuesSet["applicable_rules"] = new Array(
										["01", "<xsl:value-of select="localization:getDecode($language, 'N065', '01')"/>"],
										["02", "<xsl:value-of select="localization:getDecode($language, 'N065', '02')"/>"],
										["03", "<xsl:value-of select="localization:getDecode($language, 'N065', '03')"/>"],
										["04", "<xsl:value-of select="localization:getDecode($language, 'N065', '04')"/>"],
										["05", "<xsl:value-of select="localization:getDecode($language, 'N065', '05')"/>"],
										["09", "<xsl:value-of select="localization:getDecode($language, 'N065', '09')"/>"],
										["99", "<xsl:value-of select="localization:getDecode($language, 'N065', '99')"/>"]);
										
		arrValuesSet["authorize_own_transaction"] = new Array(
										["", "<xsl:value-of select="localization:getDecode($language, 'N034', '')"/>"],
										["Y", "<xsl:value-of select="localization:getDecode($language, 'N034', 'YES')"/>"],
										["N", "<xsl:value-of select="localization:getDecode($language, 'N034', 'NO')"/>"]);
										
		arrValuesSet["ObjectDataString@clearing_code"] = new Array(
										["NEFT", "<xsl:value-of select="localization:getDecode($language, 'N503', '02')"/>"],
										["RTGS", "<xsl:value-of select="localization:getDecode($language, 'N503', '04')"/>"]);
		
		arrValuesSet["ObjectDataString@recurring_payment_enabled"] = new Array(
										["Y", "<xsl:value-of select="localization:getDecode($language, 'N034', 'YES')"/>"],
										["N", "<xsl:value-of select="localization:getDecode($language, 'N034', 'NO')"/>"]);																			
		//
		// Definition of aggregate operators
		//
		aggregateOperators = {
			sum: "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_AGGREGATE_sum')"/>",
			count: "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_AGGREGATE_count')"/>",
			average: "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_AGGREGATE_average')"/>",
			minimum: "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_AGGREGATE_minimum')"/>",
			maximum: "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_AGGREGATE_maximum')"/>",
			variance: "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_AGGREGATE_variance')"/>",
			stdDeviation: "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_AGGREGATE_stdDeviation')"/>"
		};

		//
		// Definition of criteria operators
		//
		criteriaOperators = {
			different: "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CRITERIUM_different')"/>",
			equal: "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CRITERIUM_equal')"/>",
			infOrEqual: "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CRITERIUM_infOrEqual')"/>",
			supOrEqual: "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CRITERIUM_supOrEqual')"/>",
			inferior: "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CRITERIUM_inferior')"/>",
			superior: "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CRITERIUM_superior')"/>",
			like: "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CRITERIUM_like')"/>",
			notLike: "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CRITERIUM_notLike')"/>",
			isNull: "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CRITERIUM_isNull')"/>",
			isNotNull: "<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_CRITERIUM_isNotNull')"/>"
		};
 		 
  		<xsl:call-template name="arr_values_set"><xsl:with-param name="isTemplate"><xsl:value-of select="$isTemplate"/></xsl:with-param></xsl:call-template>
  		
  </xsl:template>
  
	<!--  -->
  <xsl:template name="arr_values_set">
  	<xsl:param name="isTemplate"/>
  	<xsl:variable name="fields_values" select="business_codes:getNodeValues()"/>
  	<xsl:apply-templates select="$fields_values/code"><xsl:with-param name="isTemplate"><xsl:value-of select="$isTemplate"/></xsl:with-param></xsl:apply-templates>
  </xsl:template>
  
  <!-- Place holder for Client Customisation -->
  <xsl:template name="Client_Columns_Definitions"/>
 	
  <xsl:template match="code">
  	<xsl:param name="isTemplate"/>
  	<xsl:choose>
  		<xsl:when test="@field='tnx_stat_code' and not(security:isBank($rundata) and $isTemplate!='true')">
	  		arrValuesSet["tnx_stat_code"] = new Array(
	  		["01", "<xsl:value-of select="localization:getGTPString($language, 'XSL_TNXSTATCODE_01_INCOMPLETE')"/>"],
			["02", "<xsl:value-of select="localization:getGTPString($language, 'XSL_TNXSTATCODE_02_UNCONTROLLED')"/>"],
			["04", "<xsl:value-of select="localization:getGTPString($language, 'XSL_TNXSTATCODE_04_ACKNOWLEDGED')"/>"]);
	  	</xsl:when>
	  	<xsl:when test="@field='tnx_stat_code' and security:isBank($rundata) and $isTemplate!='true'">
		  arrValuesSet["tnx_stat_code"] = new Array(
		  	["01", "<xsl:value-of select="localization:getGTPString($language, 'XSL_TNXSTATCODE_01_INCOMPLETE')"/>"],
		  	["02", "<xsl:value-of select="localization:getGTPString($language, 'XSL_TNXSTATCODE_02_UNCONTROLLED')"/>"],
		  	["03", "<xsl:value-of select="localization:getGTPString($language, 'XSL_TNXSTATCODE_03_CONTROLLED')"/>"],
		  	["04", "<xsl:value-of select="localization:getGTPString($language, 'XSL_TNXSTATCODE_04_ACKNOWLEDGED')"/>"],
			["05", "<xsl:value-of select="localization:getGTPString($language, 'XSL_TNXSTATCODE_05_INCOMPLETE_BANK')"/>"],
			["06", "<xsl:value-of select="localization:getGTPString($language, 'XSL_TNXSTATCODE_06_UNCONTROLLED_BANK')"/>"]);
		 </xsl:when>
		 <xsl:when test="@field='bg_type_code' and $isTemplate!='true'">
		  arrValuesSet["bg_type_code"] = new Array(

										["01", "<xsl:value-of select="localization:getDecode($language, 'C011', '01')"/>"],
										["02", "<xsl:value-of select="localization:getDecode($language, 'C011', '02')"/>"],
										["03", "<xsl:value-of select="localization:getDecode($language, 'C011', '03')"/>"],
										["04", "<xsl:value-of select="localization:getDecode($language, 'C011', '04')"/>"],
										["05", "<xsl:value-of select="localization:getDecode($language, 'C011', '05')"/>"],
										["06", "<xsl:value-of select="localization:getDecode($language, 'C011', '06')"/>"],
										["07", "<xsl:value-of select="localization:getDecode($language, 'C011', '07')"/>"],
										["08", "<xsl:value-of select="localization:getDecode($language, 'C011', '08')"/>"],
										["09", "<xsl:value-of select="localization:getDecode($language, 'C011', '09')"/>"],
										["10", "<xsl:value-of select="localization:getDecode($language, 'C011', '10')"/>"],
										["11", "<xsl:value-of select="localization:getDecode($language, 'C011', '11')"/>"],
										["12", "<xsl:value-of select="localization:getDecode($language, 'C011', '12')"/>"],
										["13", "<xsl:value-of select="localization:getDecode($language, 'C011', '13')"/>"],
										["14", "<xsl:value-of select="localization:getDecode($language, 'C011', '14')"/>"],
										["15", "<xsl:value-of select="localization:getDecode($language, 'C011', '15')"/>"],
										["16", "<xsl:value-of select="localization:getDecode($language, 'C011', '16')"/>"],
										["99", "<xsl:value-of select="localization:getDecode($language, 'C011', '99')"/>"]);
		
		 </xsl:when>
		 <xsl:when test="@field='bg_rule' and $isTemplate!='true'">
		  arrValuesSet["bg_rule"] = new Array(

										["01", "<xsl:value-of select="localization:getDecode($language, 'C013', '01')"/>"],
										["02", "<xsl:value-of select="localization:getDecode($language, 'C013', '02')"/>"],
										["03", "<xsl:value-of select="localization:getDecode($language, 'C013', '03')"/>"],
										["04", "<xsl:value-of select="localization:getDecode($language, 'C013', '04')"/>"],
										["05", "<xsl:value-of select="localization:getDecode($language, 'C013', '05')"/>"],
										["06", "<xsl:value-of select="localization:getDecode($language, 'C013', '06')"/>"],
										["07", "<xsl:value-of select="localization:getDecode($language, 'C013', '07')"/>"],
										["08", "<xsl:value-of select="localization:getDecode($language, 'C013', '08')"/>"],
										["09", "<xsl:value-of select="localization:getDecode($language, 'C013', '09')"/>"],
										["99", "<xsl:value-of select="localization:getDecode($language, 'C013', '99')"/>"]);
		
		 </xsl:when>
		<xsl:when test="@field='td_type' and $isTemplate!='true'">
		<!-- Deposit type -->
		   	<xsl:variable name="td_type_list" select="utils:getReportDesignerTDtypeListXML($rundata,$language)"/>
			   	arrValuesSet["td_type"]	= new Array(
			 	 <xsl:apply-templates select="$td_type_list/value">
	  			<xsl:with-param name="code">N414</xsl:with-param>
	  	  	</xsl:apply-templates>);
	  	  	<!-- Maturity Instructions -->
	  	  	<xsl:variable name="instruction_list" select="utils:getReportDesignerTDInstructionListXML($rundata,$language)"/>
			   	arrValuesSet["ObjectDataString@maturity_instruction_name"]	= new Array(
			 	 <xsl:apply-templates select="$instruction_list/value">
		  			<xsl:with-param name="code">N414</xsl:with-param>
	  	  	</xsl:apply-templates>);
		</xsl:when>
		
		<xsl:when test="@field='sub_product_code' and $isTemplate!='true'">
		   	<xsl:variable name="product_sub_product_list" select="utils:getReportDesignerSubProductCodeXML($rundata,$language)"/>
		   	arrValuesSetProduct["sub_product_code"] = [];
		  	<xsl:apply-templates select="$product_sub_product_list/sub_product_codes"/>
			
			<!-- 'All' is for Multi-product -->
			arrValuesSetProduct["sub_product_code"]["All"]	= new Array(
		 	 <xsl:apply-templates select="$product_sub_product_list/sub_product_codes[@product != 'SE']/value">
	  			<xsl:with-param name="code">N047</xsl:with-param>
	  	  	</xsl:apply-templates>);
		</xsl:when>
		
		
	    <xsl:otherwise>
	  	arrValuesSet["<xsl:value-of select="@field"/>"] = new Array(<xsl:apply-templates select="value">
	  	<xsl:with-param name="code"><xsl:value-of select="@prefix"/></xsl:with-param>
	  	</xsl:apply-templates>);
	  </xsl:otherwise>	
	</xsl:choose>
  </xsl:template>
  
  <xsl:template match="value">
  	<xsl:param name="code"/>
  	<xsl:variable name="value" select="."/>
  	["<xsl:value-of select="$value"/>", "<xsl:value-of select="localization:getDecode($language, $code, $value)"/>"]<xsl:if test="position() != last()">,</xsl:if>
  </xsl:template>
  
  <xsl:template match = "sub_product_codes">
			<xsl:if test="count(value)!=0">
					arrValuesSetProduct["sub_product_code"]["<xsl:value-of select="@product"/>"]	= new Array(
		 	 <xsl:apply-templates select="value">
	  			<xsl:with-param name="code">N047</xsl:with-param>
	  	  	</xsl:apply-templates>);
		</xsl:if>
	</xsl:template>
  
  <xsl:template match="listdef" mode="init">
			
			<xsl:choose>
				<xsl:when test="count(candidate) = 0">
					var candidate = '';
				</xsl:when>
				<xsl:when test="count(candidate) = 1 and multiProduct = 'N'"> <!-- not if multiproduct report! -->
					var candidate = '<xsl:value-of select="candidate/@name"/>';
				</xsl:when>
				<xsl:when test="count(candidate) > 1 or multiProduct = 'Y'">
					<xsl:if test="candidate[1][@name = 'LCTnx'] or candidate[1][@name = 'LSTnx'] or candidate[1][@name = 'SETnx'] or candidate[1][@name = 'ELTnx'] or candidate[1][@name = 'SITnx'] or candidate[1][@name = 'SRTnx'] or candidate[1][@name = 'SGTnx'] or candidate[1][@name = 'TFTnx'] or candidate[1][@name = 'BGTnx'] or candidate[1][@name = 'BRTnx'] or candidate[1][@name = 'BKTnx'] or candidate[1][@name = 'ECTnx'] or candidate[1][@name = 'ICTnx'] or candidate[1][@name = 'IRTnx'] or candidate[1][@name = 'FTTnx'] or candidate[1][@name = 'LITnx'] or candidate[1][@name = 'POTnx'] or candidate[1][@name = 'IOTnx'] or candidate[1][@name = 'EATnx'] or candidate[1][@name = 'INTnx'] or candidate[1][@name = 'IPTnx'] or candidate[1][@name = 'SOTnx'] or candidate[1][@name = 'LTTnx'] or candidate[1][@name = 'FXTnx'] or candidate[1][@name = 'TDTnx'] or candidate[1][@name = 'CNTnx'] or candidate[1][@name = 'CRTnx']">
						var candidate = 'AllTnx';
					</xsl:if>
					<xsl:if test="candidate[1][@name = 'LC'] or candidate[1][@name = 'LS'] or candidate[1][@name = 'SE'] or candidate[1][@name = 'EL'] or candidate[1][@name = 'SI'] or candidate[1][@name = 'SR'] or candidate[1][@name = 'SG'] or candidate[1][@name = 'TF'] or candidate[1][@name = 'BG'] or candidate[1][@name = 'BR'] or candidate[1][@name = 'BK'] or candidate[1][@name = 'EC'] or candidate[1][@name = 'IC'] or candidate[1][@name = 'IR'] or candidate[1][@name = 'FT'] or candidate[1][@name = 'LI'] or candidate[1][@name = 'PO'] or candidate[1][@name = 'IO'] or candidate[1][@name = 'EA'] or candidate[1][@name = 'IN']  or candidate[1][@name = 'IP'] or candidate[1][@name = 'SO'] or candidate[1][@name = 'LT'] or candidate[1][@name = 'FX'] or candidate[1][@name = 'TD'] or candidate[1][@name = 'CN'] or candidate[1][@name = 'CR']">
						var candidate = 'AllMaster';
					</xsl:if>
					<xsl:if test="candidate[1][@name = 'LCTemplate'] or candidate[1][@name = 'LSTemplate'] or  candidate[1][@name = 'SETemplate'] or candidate[1][@name = 'SITemplate'] or candidate[1][@name = 'BGTemplate'] or candidate[1][@name = 'ECTemplate'] or candidate[1][@name = 'FTTemplate'] or candidate[1][@name = 'CNTemplate'] or candidate[1][@name = 'CRTemplate']">
						var candidate = 'AllTemplate';
					</xsl:if>
				</xsl:when>
			</xsl:choose>
			
			<xsl:call-template name="candidate-initialization"/>
			
</xsl:template>

		
	<!--*****************************************************-->
	<!-- Product columns based on the user's authorisations *-->
	<!--*****************************************************-->
	<xsl:template name="Products_Columns_Candidates">
	 <script>
	   initialiseProductArrays = function(/*String*/ productCode){
	    switch(productCode) {
		    <xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'LC')">
		     case 'lc':
			  <xsl:call-template name="LC_Columns"/>
			  <xsl:call-template name="LCTnx_Columns"/>
			  break;
			 
			 <xsl:if test="security:isCustomer($rundata) or $isTemplate='true'">
			  case 'lc_template':
			   <xsl:call-template name="LCTemplate_Columns"/>
			   break;
			 </xsl:if>
		    </xsl:if>
		    
		    
		    <xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'LS')">
		     case 'ls':
			  <xsl:call-template name="LS_Columns"/>
			  <xsl:call-template name="LSTnx_Columns"/>
			  break;
			 
			 <xsl:if test="security:isCustomer($rundata) or $isTemplate='true'">
			  case 'ls_template':
			   <xsl:call-template name="LSTemplate_Columns"/>
			   break;
			 </xsl:if>
		    </xsl:if>
		    
		    <xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'SE')">
		     case 'se':
			  <xsl:call-template name="SE_Columns"/>
			  <xsl:call-template name="SETnx_Columns"/>
			  break;
			 
			 <xsl:if test="security:isCustomer($rundata) or $isTemplate='true'">
			  case 'se_template':
			   <xsl:call-template name="SETemplate_Columns"/>
			   break;
			 </xsl:if>
		    </xsl:if>
		    
		    <xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'EL')">
		     case 'el':
			  <xsl:call-template name="EL_Columns"/>
			  <xsl:call-template name="ELTnx_Columns"/>
			  break; 
		    </xsl:if>
		    
			<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'SG')">
			 case 'sg':
			  <xsl:call-template name="SG_Columns"/>
			  <xsl:call-template name="SGTnx_Columns"/>
			  break;
		    </xsl:if>
		    
			<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'BG')">
			 case 'bg':
			  <xsl:call-template name="BG_Columns"/>
			  <xsl:call-template name="BGTnx_Columns"/>
			  break;
			  
			  <xsl:if test="security:isCustomer($rundata) or $isTemplate='true'">
			  case 'bg_template':
			   <xsl:call-template name="BGTemplate_Columns"/>
			   break;
			  </xsl:if>
		    </xsl:if>
		    
			<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'BR')">
			 case 'br':
			  <xsl:call-template name="BR_Columns"/>
			  <xsl:call-template name="BRTnx_Columns"/>
			  break;
		    </xsl:if>
		    
		    <xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'BK')">
			 case 'bk':
			  <xsl:call-template name="BK_Columns"/>
			  <xsl:call-template name="BKTnx_Columns"/>
			  break;
		    </xsl:if>

		    <xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'TF')">
		     case 'tf':
			  <xsl:call-template name="TF_Columns"/>
			  <xsl:call-template name="TFTnx_Columns"/>
			  break;
		    </xsl:if>
		    
			<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'EC')">
			 case 'ec':
			  <xsl:call-template name="EC_Columns"/>
			  <xsl:call-template name="ECTnx_Columns"/>
			  break;
			  
			  <xsl:if test="security:isCustomer($rundata) or $isTemplate='true'">
			  case 'ec_template':
			   <xsl:call-template name="ECTemplate_Columns"/>
			   break;
			  </xsl:if>
		    </xsl:if>
		    
			<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'IC')">
			 case 'ic':
			  <xsl:call-template name="IC_Columns"/>
			  <xsl:call-template name="ICTnx_Columns"/>
			  break;
		    </xsl:if>
		    
			<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'IR')">
			 case 'ir':
			  <xsl:call-template name="IR_Columns"/>
			  <xsl:call-template name="IRTnx_Columns"/>
			  break;
		    </xsl:if>
		    
			<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'FT')">
			 case 'ft':
			  <xsl:call-template name="FT_Columns"/>
			  <xsl:call-template name="FTTnx_Columns"/>
			  break;
			  
			  <xsl:if test="security:isCustomer($rundata) or $isTemplate='true'">
			  case 'ft_template':
			   <xsl:call-template name="FTTemplate_Columns"/>
			   break;
			  </xsl:if>
			</xsl:if>
			
			<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'SI')">
			 case 'si':
			  <xsl:call-template name="SI_Columns"/>
			  <xsl:call-template name="SITnx_Columns"/>
			  break;
			  
			  <xsl:if test="security:isCustomer($rundata) or $isTemplate='true'">
			  case 'si_template':
			   <xsl:call-template name="SITemplate_Columns"/>
			   break;
			  </xsl:if>
			</xsl:if>
			
			<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'SR')">
			 case 'sr':
			  <xsl:call-template name="SR_Columns"/>
			  <xsl:call-template name="SRTnx_Columns"/>
			  break;
		    </xsl:if>
		    
			<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'LI')">
			 case 'li':
			  <xsl:call-template name="LI_Columns"/>
			  <xsl:call-template name="LITnx_Columns"/>
			  break;
			</xsl:if>
		
			<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'PO')">
			 case 'po':
			  <xsl:call-template name="PO_Columns"/>
			  <xsl:call-template name="POTnx_Columns"/>
			  break;
			  
			  <xsl:if test="security:isCustomer($rundata) or $isTemplate='true'">
			  case 'po_template':
			   <xsl:call-template name="POTemplate_Columns"/>
			   break;
			  </xsl:if>
			</xsl:if>
			
			<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'IO')">
			 case 'io':
			  <xsl:call-template name="IO_Columns"/>
			  <xsl:call-template name="IOTnx_Columns"/>
			  break;
			</xsl:if>
			
			<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'EA')">
			 case 'ea':
			  <xsl:call-template name="EA_Columns"/>
			  <xsl:call-template name="EATnx_Columns"/>
			  break;
			</xsl:if>
			
			<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'IN')">
			 case 'in':
			  <xsl:call-template name="IN_Columns"/>
			  <xsl:call-template name="INTnx_Columns"/>
			  break;
			</xsl:if>
			
			
			<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'IP')">
			 case 'ip':
			  <xsl:call-template name="IP_Columns"/>
			  <xsl:call-template name="IPTnx_Columns"/>
			  break;
			  </xsl:if>
			
			
			<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'SO')">
			 case 'so':
			  <xsl:call-template name="SO_Columns"/>
			  <xsl:call-template name="SOTnx_Columns"/>
			  break;
			</xsl:if>

			<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'TU')">
			 case 'tu':
			   <xsl:call-template name="TU_Columns"/>
			   <xsl:call-template name="TUTnx_Columns"/>
			   break;
			</xsl:if>
			
			<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'BN')">
			 case 'bn':
			  <xsl:call-template name="BN_Columns"/>
			  break;	
			</xsl:if>
			
			<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'FX')">
			 case 'fx':
			  <xsl:call-template name="FX_Columns"/>
			  <xsl:call-template name="FXTnx_Columns"/>
			  break;
			</xsl:if>
			
			<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'LN')">
			 case 'ln':
			  <xsl:call-template name="LN_Columns"/>
			  <xsl:call-template name="LNTnx_Columns"/>
			  break;
			</xsl:if>
			
			<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'TD')">
			 case 'td':
			  <xsl:call-template name="TD_Columns"/>
			  <xsl:call-template name="TDTnx_Columns"/>
			  break;
			</xsl:if>
			
			<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'LA')">
			 case 'la':
			  <xsl:call-template name="LA_Columns"/>
			  <xsl:call-template name="LATnx_Columns"/>
			  break;
			</xsl:if>
			
			<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'SP')">
			 case 'sp':
			  <xsl:call-template name="SP_Columns"/>
			  <xsl:call-template name="SPTnx_Columns"/>
			  break;
			</xsl:if>
			
			<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'CN')">
			 case 'cn':
			  <xsl:call-template name="CN_Columns"/>
			  <xsl:call-template name="CNTnx_Columns"/>
			  break;
			  <xsl:if test="security:isCustomer($rundata) or $isTemplate='true'">
			  case 'cn_template':
			   <xsl:call-template name="CNTemplate_Columns"/>
			   break;
			  </xsl:if>
			</xsl:if>
			
			<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'CR')">
			 case 'cr':
			  <xsl:call-template name="CR_Columns"/>
			  <xsl:call-template name="CRTnx_Columns"/>
			  break;
			   <xsl:if test="security:isCustomer($rundata) or $isTemplate='true'">
			  case 'cr_template':
			   <xsl:call-template name="CRTemplate_Columns"/>
			   break;
			  </xsl:if>
			</xsl:if> 
			
			default:
			 break;
		}
		
		<xsl:if test="securityCheck:hasCompanyProductPermission($rundata,'PO') or securityCheck:hasCompanyProductPermission($rundata,'SO') or securityCheck:hasCompanyProductPermission($rundata,'IN') or securityCheck:hasCompanyProductPermission($rundata,'IO') or securityCheck:hasCompanyProductPermission($rundata,'EA')">
		 if(productCode == 'po' || productCode == 'so' || productCode == 'in' || productCode == 'io' || productCode == 'ea') {
		   <xsl:call-template name="LT_Columns"/>
		   <xsl:call-template name="LTTnx_Columns"/>
		 }
		 <xsl:if test="security:isCustomer($rundata) or $isTemplate='true'">
		  if(productCode == 'po_template' || productCode == 'so_template' || productCode == 'in_template') {
		   <xsl:call-template name="LTTemplate_Columns"/>
		  }
		 </xsl:if>
		</xsl:if>
	};
	 </script>
	</xsl:template>
	
	<xsl:template name="product-arraylist-initialisation">
		var arrProductColumn = [];
		
		var arrCandidateName = [];
			
		var arrColumn = [];
		var arrValuesSet = [];
		var arrCandidate = [];
		var arrComputedFieldId = [];
		var arrValuesSetProduct = [];
		
		
		<!-- Register custom ConstrainedParameter type  -->
		
		var arrConstrainedParameterType = new Array("AvailableMasterProducts", "AvaliableSubProductType", "ValuesSet",
										"AvaliableProductStatus","AvaliableTransactionStatus","AvailableSubTransactionStatus",
										"AvailableTransactionType","AvailableFundTransferType","AvailableBulkType","AvailableTDType", 
										"AvailableBooleanStrings","AvailableChargeCode","AvailableClearingCode",
										"AvailableTDInstructionsType","AvailableTDTenorNumber","AvailableTDTenorCode","AvailableCreditCode");
		
		arrProductColumn["EC"] = [];
		arrProductColumn["ECTnx"] = [];
		arrProductColumn["AccountStatementLine"] = [];
		arrProductColumn["AccountStatement"] = [];
		arrProductColumn["AllMaster"] = [];
		arrProductColumn["AllTnx"] = [];
		arrProductColumn["AllTemplate"] = [];
		arrProductColumn["Audit"] = [];
		arrProductColumn["BG"] = [];
		arrProductColumn["BGTnx"] = [];
		arrProductColumn["BGTemplate"] = [];
		arrProductColumn["BR"] = [];
		arrProductColumn["BRTnx"] = [];
		arrProductColumn["BN"] = [];
		arrProductColumn["ECTemplate"] = [];
		arrProductColumn["EL"] = [];
		arrProductColumn["ELTnx"] = [];
		arrProductColumn["FT"] = [];
		arrProductColumn["FTTnx"] = [];
		arrProductColumn["FTTemplate"] = [];
		arrProductColumn["FX"] = [];
		arrProductColumn["FXTnx"] = [];
		arrProductColumn["IC"] = [];
		arrProductColumn["ICTnx"] = [];
		arrProductColumn["IN"] = [];
		arrProductColumn["INTnx"] = [];
		arrProductColumn["IO"] = [];
		arrProductColumn["IOTnx"] = [];
		arrProductColumn["IP"] = [];
		arrProductColumn["IPTnx"] = [];
		arrProductColumn["IPTemplate"] = [];
		arrProductColumn["IR"] = [];
		arrProductColumn["IRTnx"] = [];
		arrProductColumn["LA"] = [];
		arrProductColumn["LATnx"] = [];
		arrProductColumn["LC"] = [];
		arrProductColumn["LCTnx"] = [];
		arrProductColumn["LCTemplate"] = [];
		
		arrProductColumn["LS"] = [];
		arrProductColumn["LSTnx"] = [];
		arrProductColumn["LSTemplate"] = [];
		
		arrProductColumn["LI"] = [];
		arrProductColumn["LITnx"] = [];
		arrProductColumn["LN"] = [];
		arrProductColumn["LNTnx"] = [];
		arrProductColumn["LT"] = [];
		arrProductColumn["LTTnx"] = [];
		arrProductColumn["LTTemplate"] = [];
		arrProductColumn["PO"] = [];
		arrProductColumn["POTnx"] = [];
		arrProductColumn["POTemplate"] = [];
		arrProductColumn["RI"] = [];
		arrProductColumn["RITnx"] = [];
		arrProductColumn["SE"] = [];
		arrProductColumn["SETnx"] = [];
		arrProductColumn["SG"] = [];
		arrProductColumn["SGTnx"] = [];
		arrProductColumn["SI"] = [];
		arrProductColumn["SITnx"] = [];
		arrProductColumn["SITemplate"] = [];
		arrProductColumn["SO"] = [];
		arrProductColumn["SOTnx"] = [];
		arrProductColumn["SP"] = [];
		arrProductColumn["SPTnx"] = [];
		arrProductColumn["SR"] = [];
		arrProductColumn["SRTnx"] = [];
		arrProductColumn["TD"] = [];
		arrProductColumn["TDTnx"] = [];
		arrProductColumn["TF"] = [];
		arrProductColumn["TFTnx"] = [];
		arrProductColumn["FA"] = [];
		arrProductColumn["FATnx"] = [];
		arrProductColumn["TU"] = [];
		arrProductColumn["TUTnx"] = [];
		arrProductColumn["EA"] = [];
		arrProductColumn["EATnx"] = [];
		arrProductColumn["BK"] = [];
		arrProductColumn["BKTnx"] = [];
		arrProductColumn["CN"] = [];
		arrProductColumn["CNTnx"] = [];
		arrProductColumn["CNTemplate"] = [];
		arrProductColumn["CR"] = [];
		arrProductColumn["CRTnx"] = [];
		arrProductColumn["CRTemplate"] = [];
	
		<!-- Criteria columns initialization -->
		
		var arrProductCriteriaColumn = [];
		
			arrProductCriteriaColumn["EC"] = [];
		arrProductCriteriaColumn["ECTnx"] = [];
		arrProductCriteriaColumn["AccountStatementLine"] = [];
		arrProductCriteriaColumn["AllMaster"] = [];
		arrProductCriteriaColumn["AllTnx"] = [];
		arrProductCriteriaColumn["AllTemplate"] = [];
		arrProductCriteriaColumn["Audit"] = [];
		arrProductCriteriaColumn["BG"] = [];
		arrProductCriteriaColumn["BGTnx"] = [];
		arrProductCriteriaColumn["BGTemplate"] = [];
		arrProductCriteriaColumn["BR"] = [];
		arrProductCriteriaColumn["BRTnx"] = [];
		arrProductCriteriaColumn["BN"] = [];
		arrProductCriteriaColumn["ECTemplate"] = [];
		arrProductCriteriaColumn["EL"] = [];
		arrProductCriteriaColumn["ELTnx"] = [];
		arrProductCriteriaColumn["FT"] = [];
		arrProductCriteriaColumn["FTTnx"] = [];
		arrProductCriteriaColumn["FTTemplate"] = [];
		arrProductCriteriaColumn["FX"] = [];
		arrProductCriteriaColumn["FXTnx"] = [];
		arrProductCriteriaColumn["IC"] = [];
		arrProductCriteriaColumn["ICTnx"] = [];
		arrProductCriteriaColumn["IN"] = [];
		arrProductCriteriaColumn["INTnx"] = [];
		arrProductCriteriaColumn["IO"] = [];
		arrProductCriteriaColumn["IOTnx"] = [];
		arrProductCriteriaColumn["IP"] = [];
		arrProductCriteriaColumn["IPTnx"] = [];
		arrProductCriteriaColumn["IPTemplate"] = [];
		arrProductCriteriaColumn["IR"] = [];
		arrProductCriteriaColumn["IRTnx"] = [];
		arrProductCriteriaColumn["LA"] = [];
		arrProductCriteriaColumn["LATnx"] = [];
		arrProductCriteriaColumn["LC"] = [];
		arrProductCriteriaColumn["LCTnx"] = [];
		arrProductCriteriaColumn["LCTemplate"] = [];
		
		arrProductCriteriaColumn["LS"] = [];
		arrProductCriteriaColumn["LSTnx"] = [];
		arrProductCriteriaColumn["LSTemplate"] = [];
		
		arrProductCriteriaColumn["LI"] = [];
		arrProductCriteriaColumn["LITnx"] = [];
		arrProductCriteriaColumn["LN"] = [];
		arrProductCriteriaColumn["LNTnx"] = [];
		arrProductCriteriaColumn["LT"] = [];
		arrProductCriteriaColumn["LTTnx"] = [];
		arrProductCriteriaColumn["LTTemplate"] = [];
		arrProductCriteriaColumn["PO"] = [];
		arrProductCriteriaColumn["POTnx"] = [];
		arrProductCriteriaColumn["POTemplate"] = [];
		arrProductCriteriaColumn["RI"] = [];
		arrProductCriteriaColumn["RITnx"] = [];
		arrProductCriteriaColumn["SE"] = [];
		arrProductCriteriaColumn["SETnx"] = [];
		arrProductCriteriaColumn["SG"] = [];
		arrProductCriteriaColumn["SGTnx"] = [];
		arrProductCriteriaColumn["SI"] = [];
		arrProductCriteriaColumn["SITnx"] = [];
		arrProductCriteriaColumn["SITemplate"] = [];
		arrProductCriteriaColumn["SO"] = [];
		arrProductCriteriaColumn["SOTnx"] = [];
		arrProductCriteriaColumn["SP"] = [];
		arrProductCriteriaColumn["SPTnx"] = [];
		arrProductCriteriaColumn["SR"] = [];
		arrProductCriteriaColumn["SRTnx"] = [];
		arrProductCriteriaColumn["TD"] = [];
		arrProductCriteriaColumn["TDTnx"] = [];
		arrProductCriteriaColumn["TF"] = [];
		arrProductCriteriaColumn["TFTnx"] = [];
		arrProductCriteriaColumn["FA"] = [];
		arrProductCriteriaColumn["FATnx"] = [];
		arrProductCriteriaColumn["TU"] = [];
		arrProductCriteriaColumn["TUTnx"] = [];
		arrProductCriteriaColumn["BK"] = [];
		arrProductCriteriaColumn["BKTnx"] = [];
		
		
		<!-- Order column array initialization  -->
		
		var arrProductOrderColumn = [];
		
				arrProductOrderColumn["EC"] = [];
		arrProductOrderColumn["ECTnx"] = [];
		arrProductOrderColumn["AccountStatementLine"] = [];
		arrProductOrderColumn["AllMaster"] = [];
		arrProductOrderColumn["AllTnx"] = [];
		arrProductOrderColumn["AllTemplate"] = [];
		arrProductOrderColumn["Audit"] = [];
		arrProductOrderColumn["BG"] = [];
		arrProductOrderColumn["BGTnx"] = [];
		arrProductOrderColumn["BGTemplate"] = [];
		arrProductOrderColumn["BR"] = [];
		arrProductOrderColumn["BRTnx"] = [];
		arrProductOrderColumn["BN"] = [];
		arrProductOrderColumn["ECTemplate"] = [];
		arrProductOrderColumn["EL"] = [];
		arrProductOrderColumn["ELTnx"] = [];
		arrProductOrderColumn["FT"] = [];
		arrProductOrderColumn["FTTnx"] = [];
		arrProductOrderColumn["FTTemplate"] = [];
		arrProductOrderColumn["FX"] = [];
		arrProductOrderColumn["FXTnx"] = [];
		arrProductOrderColumn["IC"] = [];
		arrProductOrderColumn["ICTnx"] = [];
		arrProductOrderColumn["IN"] = [];
		arrProductOrderColumn["INTnx"] = [];
		arrProductOrderColumn["IO"] = [];
		arrProductOrderColumn["IOTnx"] = [];
		arrProductOrderColumn["IP"] = [];
		arrProductOrderColumn["IPTnx"] = [];
		arrProductOrderColumn["IPTemplate"] = [];
		arrProductOrderColumn["IR"] = [];
		arrProductOrderColumn["IRTnx"] = [];
		arrProductOrderColumn["LA"] = [];
		arrProductOrderColumn["LATnx"] = [];
		arrProductOrderColumn["LC"] = [];
		arrProductOrderColumn["LCTnx"] = [];
		arrProductOrderColumn["LCTemplate"] = [];
		
		arrProductOrderColumn["LS"] = [];
		arrProductOrderColumn["LSTnx"] = [];
		arrProductOrderColumn["LSTemplate"] = [];
		
		arrProductOrderColumn["LI"] = [];
		arrProductOrderColumn["LITnx"] = [];
		arrProductOrderColumn["LN"] = [];
		arrProductOrderColumn["LNTnx"] = [];
		arrProductOrderColumn["LT"] = [];
		arrProductOrderColumn["LTTnx"] = [];
		arrProductOrderColumn["LTTemplate"] = [];
		arrProductOrderColumn["PO"] = [];
		arrProductOrderColumn["POTnx"] = [];
		arrProductOrderColumn["POTemplate"] = [];
		arrProductOrderColumn["RI"] = [];
		arrProductOrderColumn["RITnx"] = [];
		arrProductOrderColumn["SE"] = [];
		arrProductOrderColumn["SETnx"] = [];
		arrProductOrderColumn["SG"] = [];
		arrProductOrderColumn["SGTnx"] = [];
		arrProductOrderColumn["SI"] = [];
		arrProductOrderColumn["SITnx"] = [];
		arrProductOrderColumn["SITemplate"] = [];
		arrProductOrderColumn["SO"] = [];
		arrProductOrderColumn["SOTnx"] = [];
		arrProductOrderColumn["SP"] = [];
		arrProductOrderColumn["SPTnx"] = [];
		arrProductOrderColumn["SR"] = [];
		arrProductOrderColumn["SRTnx"] = [];
		arrProductOrderColumn["TD"] = [];
		arrProductOrderColumn["TDTnx"] = [];
		arrProductOrderColumn["TF"] = [];
		arrProductOrderColumn["TFTnx"] = [];
		arrProductOrderColumn["FA"] = [];
		arrProductOrderColumn["FATnx"] = [];
		arrProductOrderColumn["TU"] = [];
		arrProductOrderColumn["TUTnx"] = [];
		arrProductOrderColumn["BK"] = [];
		arrProductOrderColumn["BKTnx"] = [];
		
		<!-- Grouping column array initialization -->

		var arrProductGroupColumn = [];
		
				arrProductGroupColumn["EC"] = [];
		arrProductGroupColumn["ECTnx"] = [];
		arrProductGroupColumn["AccountStatementLine"] = [];
		arrProductGroupColumn["AllMaster"] = [];
		arrProductGroupColumn["AllTnx"] = [];
		arrProductGroupColumn["AllTemplate"] = [];
		arrProductGroupColumn["Audit"] = [];
		arrProductGroupColumn["BG"] = [];
		arrProductGroupColumn["BGTnx"] = [];
		arrProductGroupColumn["BGTemplate"] = [];
		arrProductGroupColumn["BR"] = [];
		arrProductGroupColumn["BRTnx"] = [];
		arrProductGroupColumn["BN"] = [];
		arrProductGroupColumn["ECTemplate"] = [];
		arrProductGroupColumn["EL"] = [];
		arrProductGroupColumn["ELTnx"] = [];
		arrProductGroupColumn["FT"] = [];
		arrProductGroupColumn["FTTnx"] = [];
		arrProductGroupColumn["FTTemplate"] = [];
		arrProductGroupColumn["FX"] = [];
		arrProductGroupColumn["FXTnx"] = [];
		arrProductGroupColumn["IC"] = [];
		arrProductGroupColumn["ICTnx"] = [];
		arrProductGroupColumn["IN"] = [];
		arrProductGroupColumn["INTnx"] = [];
		arrProductGroupColumn["IO"] = [];
		arrProductGroupColumn["IOTnx"] = [];
		arrProductGroupColumn["IP"] = [];
		arrProductGroupColumn["IPTnx"] = [];
		arrProductGroupColumn["IPTemplate"] = [];
		arrProductGroupColumn["IR"] = [];
		arrProductGroupColumn["IRTnx"] = [];
		arrProductGroupColumn["LA"] = [];
		arrProductGroupColumn["LATnx"] = [];
		arrProductGroupColumn["LC"] = [];
		arrProductGroupColumn["LCTnx"] = [];
		arrProductGroupColumn["LCTemplate"] = [];
		
		arrProductGroupColumn["LS"] = [];
		arrProductGroupColumn["LSTnx"] = [];
		arrProductGroupColumn["LSTemplate"] = [];
		
		arrProductGroupColumn["LI"] = [];
		arrProductGroupColumn["LITnx"] = [];
		arrProductGroupColumn["LN"] = [];
		arrProductGroupColumn["LNTnx"] = [];
		arrProductGroupColumn["LT"] = [];
		arrProductGroupColumn["LTTnx"] = [];
		arrProductGroupColumn["LTTemplate"] = [];
		arrProductGroupColumn["PO"] = [];
		arrProductGroupColumn["POTnx"] = [];
		arrProductGroupColumn["POTemplate"] = [];
		arrProductGroupColumn["RI"] = [];
		arrProductGroupColumn["RITnx"] = [];
		arrProductGroupColumn["SE"] = [];
		arrProductGroupColumn["SETnx"] = [];
		arrProductGroupColumn["SG"] = [];
		arrProductGroupColumn["SGTnx"] = [];
		arrProductGroupColumn["SI"] = [];
		arrProductGroupColumn["SITnx"] = [];
		arrProductGroupColumn["SITemplate"] = [];
		arrProductGroupColumn["SO"] = [];
		arrProductGroupColumn["SOTnx"] = [];
		arrProductGroupColumn["SP"] = [];
		arrProductGroupColumn["SPTnx"] = [];
		arrProductGroupColumn["SR"] = [];
		arrProductGroupColumn["SRTnx"] = [];
		arrProductGroupColumn["TD"] = [];
		arrProductGroupColumn["TDTnx"] = [];
		arrProductGroupColumn["TF"] = [];
		arrProductGroupColumn["TFTnx"] = [];
		arrProductGroupColumn["FA"] = [];
		arrProductGroupColumn["FATnx"] = [];
		arrProductGroupColumn["TU"] = [];
		arrProductGroupColumn["TUTnx"] = [];
		arrProductGroupColumn["BK"] = [];
		arrProductGroupColumn["BKTnx"] = [];
		
		var arrProductChartXAxisColumn = [];
		
				arrProductChartXAxisColumn["EC"] = [];
		arrProductChartXAxisColumn["ECTnx"] = [];
		arrProductChartXAxisColumn["AccountStatementLine"] = [];
		arrProductChartXAxisColumn["AllMaster"] = [];
		arrProductChartXAxisColumn["AllTnx"] = [];
		arrProductChartXAxisColumn["AllTemplate"] = [];
		arrProductChartXAxisColumn["Audit"] = [];
		arrProductChartXAxisColumn["BG"] = [];
		arrProductChartXAxisColumn["BGTnx"] = [];
		arrProductChartXAxisColumn["BGTemplate"] = [];
		arrProductChartXAxisColumn["BR"] = [];
		arrProductChartXAxisColumn["BRTnx"] = [];
		arrProductChartXAxisColumn["BN"] = [];
		arrProductChartXAxisColumn["ECTemplate"] = [];
		arrProductChartXAxisColumn["EL"] = [];
		arrProductChartXAxisColumn["ELTnx"] = [];
		arrProductChartXAxisColumn["FT"] = [];
		arrProductChartXAxisColumn["FTTnx"] = [];
		arrProductChartXAxisColumn["FTTemplate"] = [];
		arrProductChartXAxisColumn["FX"] = [];
		arrProductChartXAxisColumn["FXTnx"] = [];
		arrProductChartXAxisColumn["IC"] = [];
		arrProductChartXAxisColumn["ICTnx"] = [];
		arrProductChartXAxisColumn["IN"] = [];
		arrProductChartXAxisColumn["INTnx"] = [];
		arrProductChartXAxisColumn["IO"] = [];
		arrProductChartXAxisColumn["IOTnx"] = [];
		arrProductChartXAxisColumn["IP"] = [];
		arrProductChartXAxisColumn["IPTnx"] = [];
		arrProductChartXAxisColumn["IPTemplate"] = [];
		arrProductChartXAxisColumn["IR"] = [];
		arrProductChartXAxisColumn["IRTnx"] = [];
		arrProductChartXAxisColumn["LA"] = [];
		arrProductChartXAxisColumn["LATnx"] = [];
		arrProductChartXAxisColumn["LC"] = [];
		arrProductChartXAxisColumn["LCTnx"] = [];
		arrProductChartXAxisColumn["LCTemplate"] = [];
		
		arrProductChartXAxisColumn["LS"] = [];
		arrProductChartXAxisColumn["LSTnx"] = [];
		arrProductChartXAxisColumn["LSTemplate"] = [];
		
		arrProductChartXAxisColumn["LI"] = [];
		arrProductChartXAxisColumn["LITnx"] = [];
		arrProductChartXAxisColumn["LN"] = [];
		arrProductChartXAxisColumn["LNTnx"] = [];
		arrProductChartXAxisColumn["LT"] = [];
		arrProductChartXAxisColumn["LTTnx"] = [];
		arrProductChartXAxisColumn["LTTemplate"] = [];
		arrProductChartXAxisColumn["PO"] = [];
		arrProductChartXAxisColumn["POTnx"] = [];
		arrProductChartXAxisColumn["POTemplate"] = [];
		arrProductChartXAxisColumn["RI"] = [];
		arrProductChartXAxisColumn["RITnx"] = [];
		arrProductChartXAxisColumn["SE"] = [];
		arrProductChartXAxisColumn["SETnx"] = [];
		arrProductChartXAxisColumn["SG"] = [];
		arrProductChartXAxisColumn["SGTnx"] = [];
		arrProductChartXAxisColumn["SI"] = [];
		arrProductChartXAxisColumn["SITnx"] = [];
		arrProductChartXAxisColumn["SITemplate"] = [];
		arrProductChartXAxisColumn["SO"] = [];
		arrProductChartXAxisColumn["SOTnx"] = [];
		arrProductChartXAxisColumn["SP"] = [];
		arrProductChartXAxisColumn["SPTnx"] = [];
		arrProductChartXAxisColumn["SR"] = [];
		arrProductChartXAxisColumn["SRTnx"] = [];
		arrProductChartXAxisColumn["TD"] = [];
		arrProductChartXAxisColumn["TDTnx"] = [];
		arrProductChartXAxisColumn["TF"] = [];
		arrProductChartXAxisColumn["TFTnx"] = [];
		arrProductChartXAxisColumn["FA"] = [];
		arrProductChartXAxisColumn["FATnx"] = [];
		arrProductChartXAxisColumn["TU"] = [];
		arrProductChartXAxisColumn["TUTnx"] = [];
		arrProductChartXAxisColumn["BK"] = [];
		arrProductChartXAxisColumn["BKTnx"] = [];
		
		var arrProductAggregateColumn = [];
		
				arrProductAggregateColumn["EC"] = [];
		arrProductAggregateColumn["ECTnx"] = [];
		arrProductAggregateColumn["AccountStatementLine"] = [];
		arrProductAggregateColumn["AllMaster"] = [];
		arrProductAggregateColumn["AllTnx"] = [];
		arrProductAggregateColumn["AllTemplate"] = [];
		arrProductAggregateColumn["Audit"] = [];
		arrProductAggregateColumn["BG"] = [];
		arrProductAggregateColumn["BGTnx"] = [];
		arrProductAggregateColumn["BGTemplate"] = [];
		arrProductAggregateColumn["BR"] = [];
		arrProductAggregateColumn["BRTnx"] = [];
		arrProductAggregateColumn["BN"] = [];
		arrProductAggregateColumn["ECTemplate"] = [];
		arrProductAggregateColumn["EL"] = [];
		arrProductAggregateColumn["ELTnx"] = [];
		arrProductAggregateColumn["FT"] = [];
		arrProductAggregateColumn["FTTnx"] = [];
		arrProductAggregateColumn["FTTemplate"] = [];
		arrProductAggregateColumn["FX"] = [];
		arrProductAggregateColumn["FXTnx"] = [];
		arrProductAggregateColumn["IC"] = [];
		arrProductAggregateColumn["ICTnx"] = [];
		arrProductAggregateColumn["IN"] = [];
		arrProductAggregateColumn["INTnx"] = [];
		arrProductAggregateColumn["IO"] = [];
		arrProductAggregateColumn["IOTnx"] = [];
		arrProductAggregateColumn["IP"] = [];
		arrProductAggregateColumn["IPTnx"] = [];
		arrProductAggregateColumn["IPTemplate"] = [];
		arrProductAggregateColumn["IR"] = [];
		arrProductAggregateColumn["IRTnx"] = [];
		arrProductAggregateColumn["LA"] = [];
		arrProductAggregateColumn["LATnx"] = [];
		arrProductAggregateColumn["LC"] = [];
		arrProductAggregateColumn["LCTnx"] = [];
		arrProductAggregateColumn["LCTemplate"] = [];
		
		arrProductAggregateColumn["LS"] = [];
		arrProductAggregateColumn["LSTnx"] = [];
		arrProductAggregateColumn["LSTemplate"] = [];
		
		arrProductAggregateColumn["LI"] = [];
		arrProductAggregateColumn["LITnx"] = [];
		arrProductAggregateColumn["LN"] = [];
		arrProductAggregateColumn["LNTnx"] = [];
		arrProductAggregateColumn["LT"] = [];
		arrProductAggregateColumn["LTTnx"] = [];
		arrProductAggregateColumn["LTTemplate"] = [];
		arrProductAggregateColumn["PO"] = [];
		arrProductAggregateColumn["POTnx"] = [];
		arrProductAggregateColumn["POTemplate"] = [];
		arrProductAggregateColumn["RI"] = [];
		arrProductAggregateColumn["RITnx"] = [];
		arrProductAggregateColumn["SE"] = [];
		arrProductAggregateColumn["SETnx"] = [];
		arrProductAggregateColumn["SG"] = [];
		arrProductAggregateColumn["SGTnx"] = [];
		arrProductAggregateColumn["SI"] = [];
		arrProductAggregateColumn["SITnx"] = [];
		arrProductAggregateColumn["SITemplate"] = [];
		arrProductAggregateColumn["SO"] = [];
		arrProductAggregateColumn["SOTnx"] = [];
		arrProductAggregateColumn["SP"] = [];
		arrProductAggregateColumn["SPTnx"] = [];
		arrProductAggregateColumn["SR"] = [];
		arrProductAggregateColumn["SRTnx"] = [];
		arrProductAggregateColumn["TD"] = [];
		arrProductAggregateColumn["TDTnx"] = [];
		arrProductAggregateColumn["TF"] = [];
		arrProductAggregateColumn["TFTnx"] = [];
		arrProductAggregateColumn["FA"] = [];
		arrProductAggregateColumn["FATnx"] = [];
		arrProductAggregateColumn["TU"] = [];
		arrProductAggregateColumn["TUTnx"] = [];
		arrProductAggregateColumn["BK"] = [];
		arrProductAggregateColumn["BKTnx"] = [];
		
		
		
	</xsl:template>
	
</xsl:stylesheet>