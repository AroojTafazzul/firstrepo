<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:loaniq="xalan://com.misys.portal.loan.loaniq.LoanIQAdapter"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		exclude-result-prefixes="localization securityCheck loaniq">


<!-- Get the language code -->
<xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
<xsl:param name="displaymode">edit</xsl:param>
<xsl:param name="language"/>
<xsl:param name="mode">DRAFT</xsl:param>
<xsl:param name="product-code">BK</xsl:param>
<xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/TradeAdminScreen</xsl:param>
<xsl:param name="rundata"/>
<xsl:param name = "optionCode">OTHERS</xsl:param>
<xsl:param name = "reviewandprint">false</xsl:param>

<!-- includes -->
<xsl:include href="../../core/xsl/common/bank_common.xsl" />
<xsl:include href="../../core/xsl/common/ln_common.xsl" />


<!-- output -->
<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />


<!-- main -->
<xsl:template match="/">
	<xsl:apply-templates select="bk_tnx_record"/>
</xsl:template>


<!-- Loan record -->
<xsl:template match="bk_tnx_record">
<xsl:variable name="is_legal"><xsl:value-of select="isLegalTextAccepted"/></xsl:variable>
	<!-- Preloader  -->
	<xsl:call-template name="loading-message"/>
	
	<!-- Javascript imports  -->
	<xsl:call-template name="js-imports" />
	
	<xsl:call-template name="bank-reporting-area">
		<xsl:with-param name="hide-charge-details">Y</xsl:with-param>
	</xsl:call-template>

    <!-- Attachments -->
    <xsl:call-template name="attachments-file-dojo">
    	<xsl:with-param name="is-bank-reporting">Y</xsl:with-param>
    </xsl:call-template>
    
	 <xsl:if test="legal_text_value != '' and $is_legal != 'N' and ($mode = 'RELEASE' or $reviewandprint = 'true' or $optionCode = 'SNAPSHOT')" >
		    <xsl:call-template name="bank_legal_text_template" >
		    <xsl:with-param name="legal"><xsl:value-of select="legal_text_value"/></xsl:with-param>
		    </xsl:call-template>
	</xsl:if>
	
	<xsl:if test="$optionCode = 'SNAPSHOT' or $mode = 'RELEASE' or $reviewandprint = 'true' and $is_legal != 'N'">
		<xsl:call-template name="display-authorizer-name">
			<xsl:with-param name="list"><xsl:value-of select="authorizer_id"/></xsl:with-param>
		</xsl:call-template>
	</xsl:if>

	<xsl:call-template name="form-wrapper">
		<xsl:with-param name="name">fakeform1</xsl:with-param>
		<xsl:with-param name="validating">Y</xsl:with-param>
		<xsl:with-param name="content">
			<xsl:call-template name="common-hidden-fields" />
		</xsl:with-param>
	</xsl:call-template>	

    <!-- buttons -->
	<xsl:call-template name="menu">
		<xsl:with-param name="show-template">N</xsl:with-param>
		<xsl:with-param name="second-menu">Y</xsl:with-param>
	</xsl:call-template>
		    
</xsl:template>


<!-- Additional JS imports for this form -->
<xsl:template name="js-imports">
	<xsl:call-template name="common-js-imports">
	<xsl:with-param name="binding">misys.binding.loan.bank_reporting_ln</xsl:with-param>
	<xsl:with-param name="show-period-js">Y</xsl:with-param>
	</xsl:call-template>
</xsl:template>


</xsl:stylesheet>
