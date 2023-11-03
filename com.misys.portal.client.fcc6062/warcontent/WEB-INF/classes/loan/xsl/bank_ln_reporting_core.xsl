<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		xmlns:loanIQ="xalan://com.misys.portal.loan.loaniq.LoanIQAdapter"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		xmlns:java="http://xml.apache.org/xalan/java"
		exclude-result-prefixes="localization securityCheck defaultresource loanIQ java">


<!-- Get the language code -->
<xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
<xsl:param name="displaymode">edit</xsl:param>
<xsl:param name="language"/>
<xsl:param name="mode">DRAFT</xsl:param>
<xsl:param name="product-code">LN</xsl:param>
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
	<xsl:apply-templates select="ln_tnx_record"/>
</xsl:template>


<!-- Loan record -->
<xsl:template match="ln_tnx_record">
<xsl:variable name="is_legal"><xsl:value-of select="isLegalTextAccepted"/></xsl:variable>
	<!-- Preloader  -->
	<xsl:call-template name="loading-message"/>
	
	<!-- Javascript imports  -->
	<xsl:call-template name="js-imports" />
	
	<xsl:call-template name="bank-reporting-area">
		<xsl:with-param name="hide-charge-details">Y</xsl:with-param>
	</xsl:call-template>

    <!-- Attachments -->
    <!-- <xsl:call-template name="attachments-file-dojo">
    	<xsl:with-param name="is-bank-reporting">Y</xsl:with-param>
    </xsl:call-template> -->	
    <xsl:call-template name="loan-details-create" />
        <xsl:call-template name="loan_interest" />
    
    <!-- MPS-66714 -->
    <xsl:if test="$displaymode = 'edit'">
     <xsl:call-template name="attachments-file-dojo">
       <xsl:with-param name="existing-attachments" select="attachments/attachment[type = '01']"/>
       <xsl:with-param name="legend">XSL_HEADER_FILE_UPLOAD</xsl:with-param>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
      </xsl:call-template> 
	</xsl:if>
	
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
<xsl:template name="loan-details-create">
<xsl:variable name="interestDetails" select="loanIQ:getInterestDetails(bo_ref_id)"/>

	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_LOAN_DETAILS</xsl:with-param>
		<xsl:with-param name="content">
		
		    <!-- application date -->
    		<xsl:call-template name="input-field">
    			<xsl:with-param name="type">date</xsl:with-param>
    			<xsl:with-param name="name">appl_date</xsl:with-param>
     			<xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
     			<xsl:with-param name="value" select="appl_date" />
     			<xsl:with-param name="override-displaymode">view</xsl:with-param>
    		</xsl:call-template>

		    <!-- issue (effective) date -->
    		<xsl:call-template name="input-field">
    			<xsl:with-param name="label">XSL_LOAN_EFFECTIVE_DATE</xsl:with-param>
     			<xsl:with-param name="name">effective_date</xsl:with-param>
     			<xsl:with-param name="type">date</xsl:with-param>
    			<xsl:with-param name="fieldsize">small</xsl:with-param>
     			<xsl:with-param name="size">10</xsl:with-param>
     			<xsl:with-param name="maxsize">10</xsl:with-param>
     			<xsl:with-param name="required">Y</xsl:with-param>
     			<xsl:with-param name="override-displaymode">view</xsl:with-param>
    		</xsl:call-template>

			<!-- loan amount -->
					<xsl:if test="ln_amt[.!='']">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_LOAN_AMOUNT</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="ln_cur_code" />&#160;<xsl:value-of select="ln_amt" /></xsl:with-param>
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
					</xsl:if>   
				<xsl:if test="fx_conversion_rate[.!=''] and fac_cur_code[.!=''] and (string(ln_cur_code)!=string(fac_cur_code))">
					<xsl:if test="not(tnx_id) or tnx_stat_code[.='04']">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XLS_FX_RATE</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="fx_conversion_rate" /></xsl:with-param>
						</xsl:call-template>
			 		</xsl:if>
			 		<xsl:if test="tnx_id [.!=''] and tnx_stat_code[.!='04']">
			 			<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_INDICATIVE_FX_RATE</xsl:with-param>
							<xsl:with-param name="value">1 <xsl:value-of select="fac_cur_code"/> = <xsl:value-of select="fx_conversion_rate"/>&#160;<xsl:value-of select="ln_cur_code" /></xsl:with-param>
						</xsl:call-template>
						<div style="font-weight:bold;margin-left:245px;font-style:italic;"><xsl:value-of select="localization:getGTPString($language, 'XSL_INDICATIVE_FX_NOTE')"/></div>
					</xsl:if>
 				</xsl:if>
			<!-- pricing option -->
			
			<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_LOAN_PRICING_OPTION</xsl:with-param>
						<xsl:with-param name="value">
							<xsl:value-of select="localization:getCodeData($language,'**','LN','C030', pricing_option)" />
						</xsl:with-param>
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
			

			<!-- Repricing frequency -->
					<xsl:variable name="scalarOfRepricingFrequency">
						<xsl:value-of select="translate(repricing_frequency,'abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLMNOPQRSTUVWXYZ','')"/>
					</xsl:variable>
					<xsl:variable name="unitOfRepricingFrequency">
						<xsl:value-of select="translate(repricing_frequency,'0123456789 ','')"/>
					</xsl:variable>
					<xsl:if test="repricing_frequency[.!='']">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_LOAN_REPRICING_FREQUENCY</xsl:with-param>
							<xsl:with-param name="value">
								<xsl:value-of select="concat($scalarOfRepricingFrequency, ' ', localization:getDecode($language, 'C031', $unitOfRepricingFrequency))"/>
							</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
					</xsl:if>

			<!-- loan repricing date -->
    		<xsl:call-template name="input-field">
    			<xsl:with-param name="type">date</xsl:with-param>
    			<xsl:with-param name="label">XSL_GENERALDETAILS_REPRICING_DATE</xsl:with-param>
     			<xsl:with-param name="name">repricing_date</xsl:with-param>
     			<xsl:with-param name="fieldsize">small</xsl:with-param>
     			<xsl:with-param name="maxsize">10</xsl:with-param>
     			<xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>
     					
			<!-- Risk Type -->
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_LOAN_RISK_TYPE</xsl:with-param>
						<xsl:with-param name="value">
							<xsl:value-of select="localization:getDecode($language,'C032', risk_type)" />
						</xsl:with-param>
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>		

    		<!-- loan maturity date -->
    		<xsl:call-template name="input-field">
    			<xsl:with-param name="type">date</xsl:with-param>
    			<xsl:with-param name="label">XSL_GENERALDETAILS_MATURITY_DATE</xsl:with-param>
     			<xsl:with-param name="name">ln_maturity_date</xsl:with-param>
     			<xsl:with-param name="fieldsize">small</xsl:with-param>
     			<xsl:with-param name="maxsize">10</xsl:with-param>
     			<xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:choose>
	<xsl:when test="(defaultresource:getResource('REMITTANCE_INSTRUCTION_SECTION_REQUIRED')='true' or defaultresource:getResource('REMITTANCE_INSTRUCTION_SECTION_REQUIRED')='mandatory') and tnx_id[.!=''] and sub_tnx_type_code[.!='97'] and tnx_type_code[.!='03'] and sub_tnx_type_code[.!='16'] and  rem_inst_description[.!= '']">
	<xsl:call-template name="saved-remittance-details">
	</xsl:call-template>
	</xsl:when>
	<xsl:when test = "defaultresource:getResource('REMITTANCE_INSTRUCTION_SECTION_REQUIRED')='true' and tnx_id[.!=''] and sub_tnx_type_code[.!='97'] and tnx_type_code[.!='03'] and sub_tnx_type_code[.!='16']  and rem_inst_description[.= '']" >
	<xsl:call-template name="fieldset-wrapper">
	<xsl:with-param name="legend">XSL_HEADER_REMITTANCE_INSTRUCTION_DETAILS</xsl:with-param>
	<xsl:with-param name="content">
	<div id="remmitance_information" align="center">
		<span class="label"><xsl:value-of select="localization:getGTPString($language, 'NO_REMITTANCE_INSTRUCTION')"/></span>
	</div>
	</xsl:with-param>
	</xsl:call-template>
	</xsl:when>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
