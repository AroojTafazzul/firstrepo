<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates that are common to all cash screen

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      10/15/10
author:    Pascal Marzin
email:     Pascal.Marzin@misys.com
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
  version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
  xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
  xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
  exclude-result-prefixes="localization defaultresource utils">
  
    <!-- Global Imports. -->
  <xsl:include href="si_payment_details.xsl" />
  <xsl:variable name="swift_flag" select="defaultresource:getResource('OPICS_SWIFT_ENABLED')='true'"/>
  
  <!--
  ########################################################################
  # 1 - TEMPLATES FOR STANDING INSCTRUCTIONS
  # 
  ########################################################################
  -->
  <!-- First tables - Customer Payment Instructions -->
  <xsl:template name="customer-instruction">
	<xsl:param name="legend"/>
	<xsl:param name="prefix"/>
	<xsl:param name="customer-instruction-completed"><xsl:value-of select="PAYMENT_COMPLETED_INDICATOR"/></xsl:param>
		<xsl:choose>
			<xsl:when test="$displaymode!='view' and $customer-instruction-completed!='Y'">
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="toc-item">Y</xsl:with-param>
					<xsl:with-param name="legend"><xsl:value-of select="$legend"/></xsl:with-param>
					<xsl:with-param name="content">
						<div>
							<xsl:attribute name="id"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>customerPayment</xsl:attribute>
							<xsl:attribute name="class">standingInstructionsGrid</xsl:attribute>
						</div>
						<xsl:call-template name="button-wrapper">
							<xsl:with-param name="label">XSL_ACTION_CLEAR</xsl:with-param>
							<xsl:with-param name="onclick">misys.performClear('<xsl:value-of select="$prefix"/>',1);</xsl:with-param>
							<xsl:with-param name="show-text-label">Y</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="toc-item">Y</xsl:with-param>
					<xsl:with-param name="legend" select="$legend" />
					<xsl:with-param name="content">
						<xsl:if test="count(counterparties/counterparty[counterparty_type='03'])">
							<div id="customerpaymentDetailsId">
								<xsl:call-template name="show-customer-payment-details">
									<xsl:with-param name="prefix">review</xsl:with-param>
								</xsl:call-template>
							</div>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
  </xsl:template>
  
  <!-- Second tables - Bank Payment Instructions -->
  <!-- Regular Case -->
  <xsl:template name="si-bank-instructions">
  	<xsl:param name="parse-widg">Y</xsl:param>
	<xsl:param name="legend"/>
	<xsl:param name="prefix"/>
	<xsl:param name="amt"/>
	<xsl:param name="cur_code"/>
	<xsl:param name="beneficiary-cur-code"/>
	<xsl:param name="free-format-only">N</xsl:param>
	<xsl:param name="bank-instruction-completed"><xsl:value-of select="RECEIPT_COMPLETED_INDICATOR"/></xsl:param>
	<xsl:param name="beneficiary-cur-code"/>
	<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
	
	<xsl:choose>
	<xsl:when test="$bank-instruction-completed!='Y' and $override-displaymode='edit'">
		<xsl:choose>
			<xsl:when test="$parse-widg='Y'">
		
<!-- 	<xsl:if test="$bank-instruction-completed!='Y'"> -->
		
				<xsl:choose>
					<xsl:when test="$free-format-only='Y'">
						<xsl:call-template name="si-bank-instruction-detail">
							<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
							<xsl:with-param name="amt"><xsl:value-of select="$amt"/></xsl:with-param>
							<xsl:with-param name="cur_code"><xsl:value-of select="$cur_code"/></xsl:with-param>
							<xsl:with-param name="beneficiary-cur-code"><xsl:value-of select="$beneficiary-cur-code"/></xsl:with-param>
							<xsl:with-param name="free-format-only"><xsl:value-of select="$free-format-only"/></xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
						<xsl:when test="$option='OUTGOING_SCRATCH'">
							<xsl:call-template name="si-bank-instruction-detail">
								<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
								<xsl:with-param name="amt"><xsl:value-of select="$amt"/></xsl:with-param>
								<xsl:with-param name="cur_code"><xsl:value-of select="$cur_code"/></xsl:with-param>
								<xsl:with-param name="beneficiary-cur-code"><xsl:value-of select="$beneficiary-cur-code"/></xsl:with-param>
								<xsl:with-param name="free-format-only"><xsl:value-of select="$free-format-only"/></xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="fieldset-wrapper">
								<xsl:with-param name="toc-item">Y</xsl:with-param>
								<xsl:with-param name="legend"><xsl:value-of select="$legend"/></xsl:with-param>
								<xsl:with-param name="content">
									<xsl:call-template name="si-bank-instruction-detail">
										<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
										<xsl:with-param name="amt"><xsl:value-of select="$amt"/></xsl:with-param>
										<xsl:with-param name="cur_code"><xsl:value-of select="$cur_code"/></xsl:with-param>
										<xsl:with-param name="beneficiary-cur-code"><xsl:value-of select="$beneficiary-cur-code"/></xsl:with-param>
										<xsl:with-param name="free-format-only"><xsl:value-of select="$free-format-only"/></xsl:with-param>
									</xsl:call-template>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$free-format-only='Y'">
						<xsl:call-template name="si-bank-instruction-detail">
							<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
							<xsl:with-param name="amt"><xsl:value-of select="$amt"/></xsl:with-param>
							<xsl:with-param name="cur_code"><xsl:value-of select="$cur_code"/></xsl:with-param>
							<xsl:with-param name="beneficiary-cur-code"><xsl:value-of select="$beneficiary-cur-code"/></xsl:with-param>
							<xsl:with-param name="free-format-only"><xsl:value-of select="$free-format-only"/></xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="si-bank-instruction-detail">
							<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
							<xsl:with-param name="amt"><xsl:value-of select="$amt"/></xsl:with-param>
							<xsl:with-param name="cur_code"><xsl:value-of select="$cur_code"/></xsl:with-param>
							<xsl:with-param name="beneficiary-cur-code"><xsl:value-of select="$beneficiary-cur-code"/></xsl:with-param>
							<xsl:with-param name="free-format-only"><xsl:value-of select="$free-format-only"/></xsl:with-param>
					</xsl:call-template>
					
					
	<!-- 					<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend"><xsl:value-of select="$legend"/></xsl:with-param>
							<xsl:with-param name="parse-widgets">N</xsl:with-param>
							<xsl:with-param name="content">
								<xsl:call-template name="si-bank-instruction-detail">
									<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
									<xsl:with-param name="amt"><xsl:value-of select="$amt"/></xsl:with-param>
									<xsl:with-param name="cur_code"><xsl:value-of select="$cur_code"/></xsl:with-param>
									<xsl:with-param name="free-format-only"><xsl:value-of select="$free-format-only"/></xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
	-->					
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:when>
	<xsl:otherwise>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="toc-item">N</xsl:with-param>
			<xsl:with-param name="legend">XSL_SI_BANK_INSTRUCTION</xsl:with-param>
			<xsl:with-param name="content">
	
				<div id="paymentDetailsId">
					<xsl:call-template name="show-payment-details">
						<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
					</xsl:call-template>
				</div>
	
				<div id="intermediaryDetailsId">
					<xsl:call-template name="show-intermediary-details">
					    <xsl:with-param name="theLegend">XSL_SI_ADDITIONAL_DETAILS_TAB_LABEL</xsl:with-param>
						<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
					</xsl:call-template>
				</div>
				
				<div id="additionalDetailsId">
					<xsl:call-template name="show-additional-details">
						<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
					</xsl:call-template>
				</div>
	
      		</xsl:with-param>
		</xsl:call-template>
	</xsl:otherwise>
	</xsl:choose>
</xsl:template>
  
  
  <xsl:template name="si-bank-instruction-detail">
	<xsl:param name="prefix"/>
	<xsl:param name="amt"/>
	<xsl:param name="cur_code"/>
	<xsl:param name="beneficiary-cur-code"/>
	<xsl:param name="free-format-only"/>
	
			<xsl:if test="$free-format-only='N'">
				<xsl:call-template name="multioption-group">
					<xsl:with-param name="group-label">XSL_SI_RADIO_FIELDS_ACTION_LABEL</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="radio-field">
							<xsl:with-param name="label">XSL_SI_BANK_INSTRUCTIONS_LABEL</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>instructions_type</xsl:with-param>
							<xsl:with-param name="id"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>instructions_type_1</xsl:with-param>
							<xsl:with-param name="value">01</xsl:with-param>
							<xsl:with-param name="checked">
							<xsl:choose>
								<xsl:when test="instructions_type[.='01']">Y</xsl:when>
								<xsl:otherwise>N</xsl:otherwise>
							</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="radio-field">
							<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_LABEL</xsl:with-param>
							<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>instructions_type</xsl:with-param>
							<xsl:with-param name="id"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>instructions_type_2</xsl:with-param>
							<xsl:with-param name="value">02</xsl:with-param>
							<xsl:with-param name="checked">
							<xsl:choose>
								<xsl:when test="instructions_type[.='02']">Y</xsl:when>
								<xsl:otherwise>N</xsl:otherwise>
							</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				<br></br>
			</xsl:if>
						
			<div >
								
			<xsl:attribute name="id"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>bank_instruction_field</xsl:attribute>
			<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="toc-item">N</xsl:with-param>
				<xsl:with-param name="legend">XSL_SI_BANK_INSTRUCTION_TAB_LABEL</xsl:with-param>
				<xsl:with-param name="legend-type">indented-header</xsl:with-param>
				<xsl:with-param name="content">
					<div>
						<xsl:attribute name="id"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>bankPayment</xsl:attribute>
						<xsl:attribute name="class">standingInstructionsGrid</xsl:attribute>
					</div>
					<xsl:choose>
				    <xsl:when test="$displaymode!='view'">
					<xsl:call-template name="button-wrapper">
						<xsl:with-param name="label">XSL_ACTION_CLEAR</xsl:with-param>
						<xsl:with-param name="onclick">misys.performClear('<xsl:value-of select="$prefix"/>',2);</xsl:with-param>
						<xsl:with-param name="show-text-label">Y</xsl:with-param>
					</xsl:call-template>
					</xsl:when>
					 <xsl:otherwise/>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			</div>
			<xsl:choose>
     		 <xsl:when test="$displaymode!='view'">
			<div >
			<xsl:attribute name="id"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>free_format_field</xsl:attribute>

			<div >
			<xsl:attribute name="id"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>freeformatbeneficiarylabel</xsl:attribute>
				<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="toc-item">N</xsl:with-param>
				<xsl:with-param name="legend">XSL_SI_BENEFICIARY_DETAILS_TAB_LABEL</xsl:with-param>
				<xsl:with-param name="legend-type">indented-header</xsl:with-param>
				<xsl:with-param name="content">	
				<xsl:call-template name="get-button">
				  <xsl:with-param name="button-type">beneficiaryFreeFormat</xsl:with-param>
				  <xsl:with-param name="label">XSL_ALT_BENEFICIARY</xsl:with-param>
				  <xsl:with-param name="beneficiary-cur-code"><xsl:value-of select="$beneficiary-cur-code"/></xsl:with-param>
				  <xsl:with-param name="prefix" select="$prefix"/>
				  <xsl:with-param name="non-dijit-button">N</xsl:with-param>
				</xsl:call-template>			
				<div >
					<xsl:attribute name="id"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>freeformatbeneficiary</xsl:attribute>
					<xsl:call-template name="free-format-instruction">
						<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
						<xsl:with-param name="amt"><xsl:value-of select="$amt"/></xsl:with-param>
						<xsl:with-param name="cur_code"><xsl:value-of select="$cur_code"/></xsl:with-param>
					</xsl:call-template>
				</div>
				</xsl:with-param>
				</xsl:call-template>
			</div>

 			<div >
 			<xsl:attribute name="id"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>freeformataddlinstructionslabel</xsl:attribute>
				<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="toc-item">N</xsl:with-param>
				<xsl:with-param name="legend">XSL_SI_ADDITIONAL_INSTRUCTIONS_TAB_LABEL</xsl:with-param>
				<xsl:with-param name="legend-type">indented-header</xsl:with-param>
				<xsl:with-param name="content">
				<div >
				<xsl:attribute name="id"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>freeformataddlinstructions</xsl:attribute>
					<xsl:call-template name="free-format-additional-instructions">
					<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
					</xsl:call-template>
				</div>
				</xsl:with-param>
				</xsl:call-template>
			</div>

		 	<div >
		 	<xsl:attribute name="id"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>freeformatpaymentdetailslabel</xsl:attribute>	
 				<xsl:call-template name="fieldset-wrapper">
 				<xsl:with-param name="toc-item">N</xsl:with-param>
				<xsl:with-param name="legend">XSL_SI_PAYMENT_DETAILS_TAB_LABEL</xsl:with-param>
				<xsl:with-param name="legend-type">indented-header</xsl:with-param>
				<xsl:with-param name="content">
				<div >	
				<xsl:attribute name="id"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>freeformatpaymentdetails</xsl:attribute>
					<xsl:call-template name="free-format-additional-details">
					<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
					</xsl:call-template>
				</div>
				</xsl:with-param>
				</xsl:call-template>
			</div>
			
					<xsl:call-template name="button-wrapper">
						<xsl:with-param name="label">XSL_ACTION_CLEAR</xsl:with-param>
						<xsl:with-param name="onclick">misys.performClear('<xsl:value-of select="$prefix"/>', 3, true);</xsl:with-param>
						<xsl:with-param name="show-text-label">Y</xsl:with-param>
					</xsl:call-template>
			</div>
	 		</xsl:when>
	 		<xsl:otherwise/>
			</xsl:choose>
			<!-- TODO remove hidden fields not needed -->
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>additional_details_line_1_input</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>additional_details_line_2_input</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>additional_details_line_3_input</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>additional_details_line_4_input</xsl:with-param>
			</xsl:call-template>
							
			<xsl:if test="$free-format-only='N'">
				<xsl:call-template name="si-dialog">
					<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">show_bic_code</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('SHOW_BIC_CODE')"/></xsl:with-param>
			</xsl:call-template>
  </xsl:template>

  <!-- Input Fields for regular case-->
  <xsl:template name="bank-instructions-additional-details">
 	<xsl:param name="prefix"/>
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_SI_ADDITIONAL_DETAILS_LINE_1</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>additional_details_line_1_input</xsl:with-param>
		<xsl:with-param name="size">35</xsl:with-param>
		<xsl:with-param name="maxsize">35</xsl:with-param>
		<xsl:with-param name="fieldsize">medium</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_SI_ADDITIONAL_DETAILS_LINE_2</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>additional_details_line_2_input</xsl:with-param>
		<xsl:with-param name="size">35</xsl:with-param>
		<xsl:with-param name="maxsize">35</xsl:with-param>
		<xsl:with-param name="fieldsize">medium</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_SI_ADDITIONAL_DETAILS_LINE_3</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>additional_details_line_3_input</xsl:with-param>
		<xsl:with-param name="size">35</xsl:with-param>
		<xsl:with-param name="maxsize">35</xsl:with-param>
		<xsl:with-param name="fieldsize">medium</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_SI_ADDITIONAL_DETAILS_LINE_4</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>additional_details_line_4_input</xsl:with-param>
		<xsl:with-param name="size">35</xsl:with-param>
		<xsl:with-param name="maxsize">35</xsl:with-param>
		<xsl:with-param name="fieldsize">medium</xsl:with-param>
	</xsl:call-template>
  </xsl:template>
	
  <xsl:template name="free-format-instruction">
	<xsl:param name="prefix"/>
	<xsl:param name="amt"/>
	<xsl:param name="cur_code"/>
	<xsl:param name="product_type"/>
	<xsl:param name="beneficiary-cur-code"/>
	<xsl:param name="override-product-code"/>
	<xsl:param name="beneficiaryTitle"/>
	
	<xsl:if test="$amt and $cur_code">		
 	<!-- <xsl:call-template name="input-field"> -->
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_TYPE</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>input_payment_type</xsl:with-param>
		<xsl:with-param name="size">5</xsl:with-param>
		<xsl:with-param name="maxsize">5</xsl:with-param>
		<xsl:with-param name="fieldsize">medium</xsl:with-param>
		<xsl:with-param name="readonly">Y</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_SI_FREE_FORMAT_INSTRUCTIONS_TYPE_WIRE')"/></xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="hidden-field">
			<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>payment_type</xsl:with-param>
			<xsl:with-param name="value">01</xsl:with-param>
	</xsl:call-template>
	</xsl:if>
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_NAME</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_name</xsl:with-param>
		<xsl:with-param name="size">35</xsl:with-param>
		<xsl:with-param name="maxsize">35</xsl:with-param>
		<xsl:with-param name="fieldsize">medium</xsl:with-param>		
		<xsl:with-param name="value">
		<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.='']">
			<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/counterparty_name"/>
		</xsl:if>
		</xsl:with-param>
		</xsl:call-template>
		<xsl:if test= "$displaymode = 'edit'">
			<xsl:choose>
				<xsl:when test="$swift_flag='true'">
					<xsl:call-template name="button-wrapper">
	    			<xsl:with-param name="label">XSL_ALT_BENEFICIARY</xsl:with-param>
					<xsl:with-param name="show-image">Y</xsl:with-param>
					<xsl:with-param name="show-border">N</xsl:with-param>
					<xsl:with-param name="onclick">misys.showSearchDialog('treasury_beneficiary_accounts',"['<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_name','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_address','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_address_2','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_city','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_country','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>bene_details_clrc','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_account','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_bank_bic','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_bank','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_bank_branch','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_bank_address','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_bank_city','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_bank_country','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_bank_clrc','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_bank_routing_number','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>ordering_cust_name','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>ordering_cust_account','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>ordering_cust_address','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>ordering_cust_address_2','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>ordering_cust_citystate','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>ordering_cust_country','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>order_details_clrc','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>swift_charges_type','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_bic','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_street','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_street_2','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_city','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_country','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>inter_bank_clrc','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_aba','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_instruction_1','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_instruction_2','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_instruction_3','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_instruction_4','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_instruction_5','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_instruction_6','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>free_additional_details_line_1_input','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>free_additional_details_line_2_input','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>free_additional_details_line_3_input','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>free_additional_details_line_4_input']", {swiftcode: false, bankcode: false, entity_name: '<xsl:value-of select="//entity"/>',product_type:'<xsl:if test="$product_type"><xsl:value-of select="$product_type"/></xsl:if>', cur_code:<xsl:choose><xsl:when test="product_code[.='FT']">dijit.byId('payment_cur_code').get('value')</xsl:when><xsl:when test="product_code[.='TD']">dijit.byId('td_cur_code').get('value')</xsl:when><xsl:otherwise>'<xsl:choose><xsl:when test="contract_type[.='01']"><xsl:value-of select="//fx_cur_code"/></xsl:when><xsl:when test="contract_type[.='02']"><xsl:value-of select="//counter_cur_code"/></xsl:when><xsl:otherwise><xsl:value-of select="//fx_cur_code"/></xsl:otherwise></xsl:choose>'</xsl:otherwise></xsl:choose>}, '', '', 'width:710px;height:350px;', '<xsl:value-of select="localization:getGTPString($language, 'TABLE_SUMMARY_COUNTERPARTIES_LIST')"/>');return false;</xsl:with-param>								
					<xsl:with-param name="id">beneficiary_img</xsl:with-param>
					<xsl:with-param name="non-dijit-button">N</xsl:with-param>
				</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="button-wrapper">
	    			<xsl:with-param name="label">XSL_ALT_BENEFICIARY</xsl:with-param>
					<xsl:with-param name="show-image">Y</xsl:with-param>
					<xsl:with-param name="show-border">N</xsl:with-param>
					<xsl:with-param name="onclick">misys.showSearchDialog('treasury_beneficiary_accounts',"['<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_name','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_address','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_address_2','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_city','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_country','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_account','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_bank_bic','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_bank','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_bank_branch','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_bank_address','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_bank_city','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_bank_country','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_bank_routing_number','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>ordering_cust_name','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>ordering_cust_account','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>ordering_cust_address','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>ordering_cust_citystate','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>ordering_cust_country','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>swift_charges_type','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_bic','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_street','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_city','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_country','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_aba','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_instruction_1','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_instruction_2','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_instruction_3','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_instruction_4','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_instruction_5','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_instruction_6','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>free_additional_details_line_1_input','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>free_additional_details_line_2_input','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>free_additional_details_line_3_input','<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>free_additional_details_line_4_input']", {swiftcode: false, bankcode: false, entity_name: '<xsl:value-of select="//entity"/>', cur_code:<xsl:choose><xsl:when test="product_code[.='FT']">dijit.byId('payment_cur_code').get('value')</xsl:when><xsl:when test="product_code[.='TD']">dijit.byId('td_cur_code').get('value')</xsl:when><xsl:otherwise>'<xsl:choose><xsl:when test="contract_type[.='01']"><xsl:value-of select="//fx_cur_code"/></xsl:when><xsl:when test="contract_type[.='02']"><xsl:value-of select="//counter_cur_code"/></xsl:when><xsl:otherwise><xsl:value-of select="//fx_cur_code"/></xsl:otherwise></xsl:choose>'</xsl:otherwise></xsl:choose>}, '', '', 'width:710px;height:350px;', '<xsl:value-of select="localization:getGTPString($language, 'TABLE_SUMMARY_COUNTERPARTIES_LIST')"/>');return false;</xsl:with-param>				
					<xsl:with-param name="id">beneficiary_img</xsl:with-param>
					<xsl:with-param name="non-dijit-button">N</xsl:with-param>
				</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_ADDRESS</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_address</xsl:with-param>
		<xsl:with-param name="size">35</xsl:with-param>
		<xsl:with-param name="maxsize">35</xsl:with-param>
		<xsl:with-param name="fieldsize">medium</xsl:with-param>
		<xsl:with-param name="value">
		<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.='']">
		<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/counterparty_address_line_1"/>
			</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_ADDRESS_2</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_address_2</xsl:with-param>
		<xsl:with-param name="size">35</xsl:with-param>
		<xsl:with-param name="maxsize">35</xsl:with-param>
		<xsl:with-param name="required">N</xsl:with-param>
		<xsl:with-param name="fieldsize">medium</xsl:with-param>
		<xsl:with-param name="value">
		<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.='']">
			<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/counterparty_address_line_2"/>
		</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
	
	<xsl:variable name="DOMlen">
		<xsl:choose>
			<xsl:when test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.='']">
				<xsl:value-of select="string-length(counterparties/counterparty[counterparty_type='04']/counterparty_dom)"/>
			</xsl:when>
			<xsl:otherwise>2</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_CITY</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_city</xsl:with-param>
		<xsl:with-param name="size">32</xsl:with-param>
		<xsl:with-param name="maxsize">32</xsl:with-param>
		<xsl:with-param name="fieldsize">medium</xsl:with-param>
		<xsl:with-param name="value">
		<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.='']">
			<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/counterparty_dom"/>
		</xsl:if>		
		</xsl:with-param>
	</xsl:call-template>
		
	<xsl:call-template name="country-field">
		<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_COUNTRY</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_country</xsl:with-param>
		<xsl:with-param name="prefix"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary</xsl:with-param>
		<xsl:with-param name="readonly">N</xsl:with-param>
		<xsl:with-param name="fieldsize">x-small</xsl:with-param>
	    <xsl:with-param name="size">2</xsl:with-param>
	    <xsl:with-param name="maxsize">2</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty[counterparty_type='04']/counterparty_country"/></xsl:with-param>
	</xsl:call-template>
	
	<div id="bene_details_clrc_div">
	<xsl:call-template name="select-field">
		<xsl:with-param name="name">bene_details_clrc</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_bene_details_clrc"/></xsl:with-param>
	    <xsl:with-param name="label">XSL_CLEARING_CODE</xsl:with-param>	
	   <xsl:with-param name="options">
			<option>
				<xsl:attribute name="value"><xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_bene_details_clrc"/></xsl:attribute>
			   <xsl:value-of select="utils:getDescFromClearingCode(counterparties/counterparty[counterparty_type='04']/cpty_bene_details_clrc,$rundata)"/>
			  </option>
		</xsl:with-param>
	</xsl:call-template>
	</div>
	
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_ACCOUNT</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_account</xsl:with-param>
		<xsl:with-param name="size">33</xsl:with-param>
		<xsl:with-param name="maxsize">33</xsl:with-param>
		<xsl:with-param name="fieldsize">medium</xsl:with-param>
		<xsl:with-param name="value">
			<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.='']">
				<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/counterparty_act_no"/>
			</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BIC</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_bank_bic</xsl:with-param>
		<xsl:with-param name="size">11</xsl:with-param>
		<xsl:with-param name="maxsize">11</xsl:with-param>
		<xsl:with-param name="fieldsize">medium</xsl:with-param>
		<xsl:with-param name="value">
		<!-- Pass value of free format beneficiary bic only if instructions_type is 02 .i.e, only if free format is chosen -->
			<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.=''] and instructions_type[.='02']">
				<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_bank_swift_bic_code"/>
			</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BANK</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_bank</xsl:with-param>
		<xsl:with-param name="size">35</xsl:with-param>
		<xsl:with-param name="maxsize">35</xsl:with-param>
		<xsl:with-param name="fieldsize">medium</xsl:with-param>
		<!-- xsl:with-param name="value" select="beneficiary_bank_account"/ -->
		<xsl:with-param name="value">
		<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.='']">
			<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_bank_name"/>
		</xsl:if>	
		</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BANK_BRANCH</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_bank_branch</xsl:with-param>
		<xsl:with-param name="size">35</xsl:with-param>
		<xsl:with-param name="maxsize">35</xsl:with-param>
		<xsl:with-param name="fieldsize">medium</xsl:with-param>
		<xsl:with-param name="value">
		<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.='']">
			<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_branch_name"/>
		</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BANK_ADRESS</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_bank_address</xsl:with-param>
		<xsl:with-param name="size">35</xsl:with-param>
		<xsl:with-param name="maxsize">35</xsl:with-param>
		<xsl:with-param name="fieldsize">medium</xsl:with-param>
		<xsl:with-param name="value">
		<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.='']">
			<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_branch_address_line_1"/>
		</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
	
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BANK_CITY</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_bank_city</xsl:with-param>
		<xsl:with-param name="size">32</xsl:with-param>
		<xsl:with-param name="maxsize">32</xsl:with-param>
		<xsl:with-param name="fieldsize">medium</xsl:with-param>
		<xsl:with-param name="value">
		<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.='']">
		<xsl:choose>
			<xsl:when test="$swift_flag='true'">
				<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_bank_dom"/>
			</xsl:when>
			<xsl:otherwise>
					<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_branch_address_line_2"/>
			</xsl:otherwise>
		</xsl:choose>
		</xsl:if>
	</xsl:with-param>
	</xsl:call-template>
	
	<xsl:call-template name="country-field">
		<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BANK_COUNTRY</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_bank_country</xsl:with-param>
		<xsl:with-param name="prefix"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_bank</xsl:with-param>
		<xsl:with-param name="readonly">N</xsl:with-param> 
		<xsl:with-param name="fieldsize">x-small</xsl:with-param>
	    <xsl:with-param name="size">2</xsl:with-param>
	    <xsl:with-param name="maxsize">2</xsl:with-param>
		<xsl:with-param name="value">
			<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.='']">
				<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_bank_country"/>
			</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
	<div id="beneficiary_bank_clrc_div">
	<xsl:call-template name="select-field">
		<xsl:with-param name="name">beneficiary_bank_clrc</xsl:with-param>
		<xsl:with-param name="label">XSL_CLEARING_CODE</xsl:with-param>
		<xsl:with-param name="value">
			<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.='']">
				<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_beneficiary_bank_clrc"/>
			</xsl:if>
		</xsl:with-param>
		<xsl:with-param name="options">
			<option>
				<xsl:attribute name="value"><xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_beneficiary_bank_clrc"/></xsl:attribute>
				<xsl:value-of select="utils:getDescFromClearingCode(counterparties/counterparty[counterparty_type='04']/cpty_beneficiary_bank_clrc,$rundata)"/>
			  </option>
		</xsl:with-param>	
	  </xsl:call-template>
	 </div>
	 
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BANK_NUMBER</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>beneficiary_bank_routing_number</xsl:with-param>
		<xsl:with-param name="size">33</xsl:with-param>
		<xsl:with-param name="maxsize">33</xsl:with-param>
		<xsl:with-param name="fieldsize">medium</xsl:with-param>
		<xsl:with-param name="value">
			<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.='']">
				<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_benif_bank_routing_no"/>
			</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
	
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_ORDERING_CUST_NAME</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>ordering_cust_name</xsl:with-param>
		<xsl:with-param name="size">35</xsl:with-param>
		<xsl:with-param name="maxsize">35</xsl:with-param>
		<xsl:with-param name="fieldsize">medium</xsl:with-param>
		<xsl:with-param name="value">
		<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.='']">
			<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_order_cust_name"/>
		</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
	<!-- account no -->
	
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_ORDERING_ACCOUNT_NO</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>ordering_cust_account</xsl:with-param>
		<xsl:with-param name="size">33</xsl:with-param>
		<xsl:with-param name="maxsize">33</xsl:with-param>
		<xsl:with-param name="fieldsize">medium</xsl:with-param>
		<xsl:with-param name="value">
			<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.='']">
				<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_order_account_no"/>
			</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
	
	<!-- end -->
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_ORDERING_CUST_ADDRESS</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>ordering_cust_address</xsl:with-param>
		<xsl:with-param name="size">35</xsl:with-param>
		<xsl:with-param name="maxsize">35</xsl:with-param>
		<xsl:with-param name="fieldsize">medium</xsl:with-param>
		<xsl:with-param name="value">
		<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.='']">
			<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_order_cust_addr"/>
		</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
	<div id="ordering_cust_address_2_div">
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_ORDERING_CUST_ADDRESS_2</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>ordering_cust_address_2</xsl:with-param>
		<xsl:with-param name="size">34</xsl:with-param>
		<xsl:with-param name="maxsize">34</xsl:with-param>
		<xsl:with-param name="fieldsize">medium</xsl:with-param>
		<xsl:with-param name="value">
		<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.='']">
			<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_order_cust_addr_2"/>
		</xsl:if>
		</xsl:with-param>
	</xsl:call-template>	
	</div>
		
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_ORDERING_CUST_CITYSTATE</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>ordering_cust_citystate</xsl:with-param>
		<xsl:with-param name="size">32</xsl:with-param>
		<xsl:with-param name="maxsize">32</xsl:with-param>
		<xsl:with-param name="fieldsize">medium</xsl:with-param>
		<xsl:with-param name="value">
		<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.='']">
			<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_order_cust_city"/>
		</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
	
	<xsl:call-template name="country-field">
		<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_ORDERING_CUST_COUNTRY</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>ordering_cust_country</xsl:with-param>
		<xsl:with-param name="prefix"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>ordering_cust</xsl:with-param>
		<xsl:with-param name="readonly">N</xsl:with-param> 
		<xsl:with-param name="fieldsize">x-small</xsl:with-param>
	    <xsl:with-param name="size">2</xsl:with-param>
	    <xsl:with-param name="maxsize">2</xsl:with-param>
		<xsl:with-param name="value">
			<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.='']">
				<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_order_cust_country"/>
			</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
	<div id="order_details_clrc_div">
	<xsl:call-template name="select-field">
		<xsl:with-param name="name">order_details_clrc</xsl:with-param>
		<xsl:with-param name="value">
			<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.='']">
					<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_order_details_clrc"/>	
			</xsl:if>
			</xsl:with-param>
	    <xsl:with-param name="label">XSL_CLEARING_CODE</xsl:with-param>	
	    <xsl:with-param name="options">
			<option>
				<xsl:attribute name="value"><xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_order_details_clrc"/></xsl:attribute>
				<xsl:value-of select="utils:getDescFromClearingCode(counterparties/counterparty[counterparty_type='04']/cpty_order_details_clrc,$rundata)"/>
			  </option>
		</xsl:with-param>	
	</xsl:call-template>
	</div>
	<xsl:call-template name="multioption-group">
		<xsl:with-param name="group-label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_SWIFT_CHARGE_RADIO_FIELDS_ACTION_LABEL</xsl:with-param>
		<xsl:with-param name="content">
			<xsl:call-template name="radio-field">
				<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_APPLICANT_LABEL</xsl:with-param>
				<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>swift_charges_type</xsl:with-param>
				<xsl:with-param name="id"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>swift_charges_type_1</xsl:with-param>
				<xsl:with-param name="value">01</xsl:with-param>
				<xsl:with-param name="checked">
				<xsl:choose>
					<xsl:when test="counterparties/counterparty[counterparty_type='04']/cpty_swift_charges_paid[.=''] or not(counterparties/counterparty[counterparty_type='04']/cpty_swift_charges_paid) or counterparties/counterparty[counterparty_type='04']/cpty_swift_charges_paid[.='01']">Y</xsl:when>
					<xsl:otherwise>N</xsl:otherwise>
				</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="radio-field">
				<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_LABEL</xsl:with-param>
				<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>swift_charges_type</xsl:with-param>
				<xsl:with-param name="id"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>swift_charges_type_2</xsl:with-param>
				<xsl:with-param name="value">02</xsl:with-param>
				<xsl:with-param name="checked">
				<xsl:choose>
					<xsl:when test="counterparties/counterparty[counterparty_type='04']/cpty_swift_charges_paid[.='02']">Y</xsl:when>
					<xsl:otherwise>N</xsl:otherwise>
				</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			
			<xsl:if test="defaultresource:getResource('FX_SSI_SHARE_OPTION') = 'true'">
			<xsl:call-template name="radio-field">
				<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_SHARED_LABEL</xsl:with-param>
				<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>swift_charges_type</xsl:with-param>
				<xsl:with-param name="id"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>swift_charges_type_3</xsl:with-param>
				<xsl:with-param name="value">05</xsl:with-param>
				<xsl:with-param name="checked">
				<xsl:choose>
					<xsl:when test="counterparties/counterparty[counterparty_type='04']/cpty_swift_charges_paid[.='05']">Y</xsl:when>
					<xsl:otherwise>N</xsl:otherwise>
				</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
	
	
  </xsl:template>
	
  <xsl:template name="free-format-additional-details">
	<xsl:param name="prefix"/>
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_SI_ADDITIONAL_DETAILS_LINE_1</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>free_additional_details_line_1_input</xsl:with-param>
		<xsl:with-param name="size">35</xsl:with-param>
		<xsl:with-param name="maxsize">35</xsl:with-param>
		<xsl:with-param name="fieldsize">medium</xsl:with-param>
		<xsl:with-param name="value">
			<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.='']">
				<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_1"/>
			</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_SI_ADDITIONAL_DETAILS_LINE_2</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>free_additional_details_line_2_input</xsl:with-param>
		<xsl:with-param name="size">35</xsl:with-param>
		<xsl:with-param name="maxsize">35</xsl:with-param>
		<xsl:with-param name="fieldsize">medium</xsl:with-param>
		<xsl:with-param name="value">
			<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.='']">
				<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_2"/>
			</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_SI_ADDITIONAL_DETAILS_LINE_3</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>free_additional_details_line_3_input</xsl:with-param>
		<xsl:with-param name="size">35</xsl:with-param>
		<xsl:with-param name="maxsize">35</xsl:with-param>
		<xsl:with-param name="fieldsize">medium</xsl:with-param>
		<xsl:with-param name="value">
			<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.='']">
				<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_3"/>
			</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_SI_ADDITIONAL_DETAILS_LINE_4</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>free_additional_details_line_4_input</xsl:with-param>
		<xsl:with-param name="size">35</xsl:with-param>
		<xsl:with-param name="maxsize">35</xsl:with-param>
		<xsl:with-param name="fieldsize">medium</xsl:with-param>
		<xsl:with-param name="value">
			<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.='']">
				<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_4"/>
			</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
  </xsl:template>
	
<xsl:template name="free-format-additional-instructions">
	<xsl:param name="prefix"/>
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK_BIC</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_bic</xsl:with-param>
		<xsl:with-param name="size">11</xsl:with-param>
		<xsl:with-param name="maxsize">11</xsl:with-param>
		<xsl:with-param name="fieldsize">medium</xsl:with-param>
		<xsl:with-param name="value">
			<!-- Pass value of free format intermediary bic only if instructions_type is 02 .i.e, only if free format is chosen -->
			<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.=''] and instructions_type[.='02']">
				<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_inter_swift_bic_code"/>
			</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank</xsl:with-param>
		<xsl:with-param name="size">35</xsl:with-param>
		<xsl:with-param name="maxsize">35</xsl:with-param>
		<xsl:with-param name="fieldsize">medium</xsl:with-param>
		<xsl:with-param name="value">
		<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.='']">
			<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_inter_bank_name"/>
		</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK_STREET</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_street</xsl:with-param>
		<xsl:with-param name="size">35</xsl:with-param>
		<xsl:with-param name="maxsize">35</xsl:with-param>
		<xsl:with-param name="fieldsize">medium</xsl:with-param>
		<xsl:with-param name="value">
			<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_inter_bank_addr"/>
		</xsl:with-param>
	</xsl:call-template>
	<div id="intermediary_bank_street_2_div">
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK_LOCALITY</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_street_2</xsl:with-param>
		<xsl:with-param name="size">34</xsl:with-param>
		<xsl:with-param name="maxsize">34</xsl:with-param>
		<xsl:with-param name="fieldsize">medium</xsl:with-param>
		<xsl:with-param name="value">
		<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.='']">
		<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_inter_bank_addr_2"/>
		</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
	</div>
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK_CITY</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_city</xsl:with-param>
		<xsl:with-param name="size">32</xsl:with-param>
		<xsl:with-param name="maxsize">32</xsl:with-param>
		<xsl:with-param name="fieldsize">medium</xsl:with-param>
		<xsl:with-param name="value">
		<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.='']">
			<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_inter_city_state"/>
		</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
	
	<xsl:call-template name="country-field">
		<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK_COUNTRY</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_country</xsl:with-param>
		<xsl:with-param name="prefix"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank</xsl:with-param>
		<xsl:with-param name="readonly">N</xsl:with-param>
		<xsl:with-param name="fieldsize">x-small</xsl:with-param>
	    <xsl:with-param name="size">2</xsl:with-param>
	    <xsl:with-param name="maxsize">2</xsl:with-param>
		<xsl:with-param name="value">
			<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.='']">
				<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_inter_country"/>
			</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
	
	<div id="inter_bank_clrc_div">
	<xsl:call-template name="select-field">
		<xsl:with-param name="name">inter_bank_clrc</xsl:with-param>
		<xsl:with-param name="value">
		<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.='']">
			<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_inter_bank_clrc"/>
			</xsl:if></xsl:with-param>
	    <xsl:with-param name="label">XSL_CLEARING_CODE</xsl:with-param>	
	    <xsl:with-param name="options">
			<option>
				<xsl:attribute name="value"><xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_inter_bank_clrc"/></xsl:attribute>
				<xsl:value-of select="utils:getDescFromClearingCode(counterparties/counterparty[counterparty_type='04']/cpty_inter_bank_clrc,$rundata)"/>
			  </option>
		</xsl:with-param>	
	</xsl:call-template>
	</div>
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK_ABA</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_aba</xsl:with-param>
		<xsl:with-param name="size">33</xsl:with-param>
		<xsl:with-param name="maxsize">33</xsl:with-param>
		<xsl:with-param name="fieldsize">medium</xsl:with-param>
		<xsl:with-param name="value">
			<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.='']">
				<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_inter_routing_no"/>
			</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_SI_FREE_FORMAT_ROUTING_INSTRUCTION_1</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_instruction_1</xsl:with-param>
		<xsl:with-param name="size">35</xsl:with-param>
		<xsl:with-param name="maxsize">35</xsl:with-param>
		<xsl:with-param name="fieldsize">medium</xsl:with-param>
		<xsl:with-param name="value">
			<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.='']">
				<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_special_routing_1"/>
			</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_SI_FREE_FORMAT_ROUTING_INSTRUCTION_2</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_instruction_2</xsl:with-param>
		<xsl:with-param name="size">35</xsl:with-param>
		<xsl:with-param name="maxsize">35</xsl:with-param>
		<xsl:with-param name="fieldsize">medium</xsl:with-param>
		<xsl:with-param name="value">
			<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.='']">
				<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_special_routing_2"/>
			</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
		<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_SI_FREE_FORMAT_ROUTING_INSTRUCTION_3</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_instruction_3</xsl:with-param>
		<xsl:with-param name="size">35</xsl:with-param>
		<xsl:with-param name="maxsize">35</xsl:with-param>
		<xsl:with-param name="fieldsize">medium</xsl:with-param>
		<xsl:with-param name="value">
			<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.='']">
				<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_special_routing_3"/>
			</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
		<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_SI_FREE_FORMAT_ROUTING_INSTRUCTION_4</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_instruction_4</xsl:with-param>
		<xsl:with-param name="size">35</xsl:with-param>
		<xsl:with-param name="maxsize">35</xsl:with-param>
		<xsl:with-param name="fieldsize">medium</xsl:with-param>
		<xsl:with-param name="value">
			<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.='']">
				<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_special_routing_4"/>
			</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
		<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_SI_FREE_FORMAT_ROUTING_INSTRUCTION_5</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_instruction_5</xsl:with-param>
		<xsl:with-param name="size">35</xsl:with-param>
		<xsl:with-param name="maxsize">35</xsl:with-param>
		<xsl:with-param name="fieldsize">medium</xsl:with-param>
		<xsl:with-param name="value">
			<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.='']">
				<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_special_routing_5"/>
			</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
		<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_SI_FREE_FORMAT_ROUTING_INSTRUCTION_6</xsl:with-param>
		<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>intermediary_bank_instruction_6</xsl:with-param>
		<xsl:with-param name="size">35</xsl:with-param>
		<xsl:with-param name="maxsize">35</xsl:with-param>
		<xsl:with-param name="fieldsize">medium</xsl:with-param>
		<xsl:with-param name="value">
			<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.='']">
				<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_special_routing_6"/>
			</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
	
  </xsl:template>

<xsl:template name="si-dialog">
 <xsl:param name="prefix"/>
 <div class="widgetContainer">
	<xsl:call-template name="dialog">
		<xsl:with-param name="id"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>siDialog</xsl:with-param>
	    <xsl:with-param name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_SI_DIALOG_TITLE')"/></xsl:with-param>
	    <xsl:with-param name="content">
			<xsl:call-template name="paymentDetails">
				<xsl:with-param name="mode">POPUP</xsl:with-param>
				<xsl:with-param name="prefix">summary_<xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>si</xsl:with-param>
                <xsl:with-param name="paymentBeneficiaryDiv">paymentBeneficiaryPopup</xsl:with-param>
                <xsl:with-param name="additionalDetailsDiv">additionalDetailsPopup</xsl:with-param>
				<xsl:with-param name="paymentDetailsDiv">paymentDetailsPopup</xsl:with-param>				
			</xsl:call-template>
	    </xsl:with-param>
		<xsl:with-param name="buttons">
		   	<xsl:call-template name="row-wrapper">
				<xsl:with-param name="content">
					<xsl:call-template name="button-wrapper">
						<xsl:with-param name="id"><xsl:if test="$prefix"><xsl:value-of select="$prefix"/>_</xsl:if>sendOk</xsl:with-param>
						<xsl:with-param name="label">XSL_ACTION_OK</xsl:with-param>
						<xsl:with-param name="onclick">misys.closeSiDialog('<xsl:value-of select="$prefix"/>');</xsl:with-param>
						<xsl:with-param name="show-text-label">Y</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
	    </xsl:with-param>		
	</xsl:call-template>
	</div>
</xsl:template>

  <!--
  ########################################################################
  # 2 - TEMPLATES FOR ACCOUNT POPUP
  # 
  ########################################################################
  -->
  <xsl:template name="account-popup">
 	<xsl:param name="id"/>
 	<div class="widgetContainer">
 	<xsl:call-template name="dialog">
 		<xsl:with-param name="id"><xsl:value-of select="$id"/></xsl:with-param>
    	<xsl:with-param name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACCOUNT_DIALOG_TITLE')" /></xsl:with-param>
	    <xsl:with-param name="content">
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_ACCOUNT_NUMBER_SEARCH_LABEL</xsl:with-param>
				<xsl:with-param name="name"><xsl:value-of select="$id"/>_number_acct_search</xsl:with-param>
				<xsl:with-param name="fieldsize">small</xsl:with-param>
				<xsl:with-param name="size">15</xsl:with-param>
				<xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('ACCOUNT_NUMBER_LENGTH')"/></xsl:with-param>
			</xsl:call-template>
	    	<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_ACCOUNT_DESC_SEARCH_LABEL</xsl:with-param>
				<xsl:with-param name="name"><xsl:value-of select="$id"/>_desc_acct_search</xsl:with-param>
				<xsl:with-param name="fieldsize">small</xsl:with-param>
				<xsl:with-param name="button-type">account_search_popup</xsl:with-param>
				<xsl:with-param name="size">15</xsl:with-param>
				<xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('ACCOUNT_NUMBER_LENGTH')"/></xsl:with-param>
			</xsl:call-template>
	    	<div>
	    		<xsl:attribute name="id"><xsl:value-of select="$id"/>_div</xsl:attribute>
	    	</div>
	    </xsl:with-param>
	    <!-- No button for this dialog -->
	    <xsl:with-param name="buttons"/>
 	</xsl:call-template>
 	</div>
  </xsl:template>
  
  
  <!--
   FT General Details Fieldset.
    
   Common General Details, Applicant Details, Beneficiary Details.
  -->
  <xsl:template name="cash-general-details">
    <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <div id="generaldetails">
      <!-- Common general details. -->
				
		 <!--  System ID. -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
    <xsl:with-param name="id">general_ref_id_view</xsl:with-param>
    <xsl:with-param name="value" select="ref_id" />
    <xsl:with-param name="override-displaymode">view</xsl:with-param>
   </xsl:call-template>

    	<!-- Customer reference -->
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>
			<xsl:with-param name="name">cust_ref_id</xsl:with-param>
			<xsl:with-param name="size">20</xsl:with-param>
			<xsl:with-param name="maxsize">64</xsl:with-param>
	    </xsl:call-template>
	    
    <!-- product code -->
		<xsl:call-template name="display-and-hidden-field">
			<xsl:with-param name="label">XSL_TRANSACTIONDETAILS_PRODUCT_CODE</xsl:with-param>
			<xsl:with-param name="name">product_code</xsl:with-param>
			<xsl:with-param name="value" select="localization:getDecode($language, 'N001', product_code[.])" />
		</xsl:call-template>
     
    <!--  Application date. -->
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
     <xsl:with-param name="id">appl_date_view</xsl:with-param>
     <xsl:with-param name="value" select="appl_date" />
	 <xsl:with-param name="type">date</xsl:with-param>
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
	    
	    
		<!-- fx deal number -->
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="label">XSL_GENERALDETAILS_BO_FX_ID</xsl:with-param>
		    <xsl:with-param name="name">fx_deal_no</xsl:with-param>
		</xsl:call-template>
		
  		<xsl:choose>
	 		<xsl:when test="$swift_flag='true'">
    			<xsl:call-template name="hidden-field">
	    			<xsl:with-param name="name">product_type</xsl:with-param>
	    			<xsl:with-param name="value">TRSRYFXFT</xsl:with-param>
	   			</xsl:call-template>
	   		</xsl:when>
	   		<xsl:otherwise>
	   			<xsl:call-template name="hidden-field">
	    			<xsl:with-param name="name">product_type</xsl:with-param>
	    			<xsl:with-param name="value">TRSRY</xsl:with-param>
	   			</xsl:call-template>
	   		</xsl:otherwise>
	   	</xsl:choose>
		
		
		<!-- Applicant Details -->
			<xsl:choose>
				<xsl:when test="entities[.!='0'] and $displaymode='edit' and (product_code != 'FT' or $mode != 'DRAFT')">
					<xsl:call-template name="fieldset-wrapper">
						<xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
						<xsl:with-param name="legend-type">indented-header</xsl:with-param>
						<xsl:with-param name="content">
							<xsl:if test="$displaymode='edit'">
								<script>
									dojo.ready(function(){
										misys._config = misys._config || {};
										misys._config.customerReferences = {};
										<xsl:apply-templates select="avail_main_banks/bank" mode="customer_references"/>
									});
								</script>
							</xsl:if>
							<!-- Applicant Details -->					
							<xsl:call-template name="address">
								<xsl:with-param name="show-entity">Y</xsl:with-param>
								<xsl:with-param name="readonly">Y</xsl:with-param>
								<xsl:with-param name="prefix">applicant</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="$mode != 'DRAFT' and $displaymode='edit'">			<!-- Hidden fields since show-name and show-address disabled after -->
					<xsl:call-template name="fieldset-wrapper">
						<xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
						<xsl:with-param name="legend-type">indented-header</xsl:with-param>
						<xsl:with-param name="content">
							<xsl:call-template name="hidden-field">
						      <xsl:with-param name="name">applicant_name</xsl:with-param>
						      <xsl:with-param name="value" select="applicant_name"/>
						     </xsl:call-template>
							<xsl:call-template name="hidden-field">
						      <xsl:with-param name="name">applicant_address_line_1</xsl:with-param>
						      <xsl:with-param name="value" select="applicant_address_line_1"/>
						     </xsl:call-template>
							<xsl:call-template name="hidden-field">
						      <xsl:with-param name="name">applicant_address_line_2</xsl:with-param>
						      <xsl:with-param name="value" select="applicant_address_line_2"/>
						     </xsl:call-template>
							<xsl:call-template name="hidden-field">
						      <xsl:with-param name="name">applicant_dom</xsl:with-param>
						      <xsl:with-param name="value" select="applicant_dom"/>
						     </xsl:call-template>
							<!-- Applicant Details -->					
							<xsl:call-template name="address">
								<xsl:with-param name="show-entity">Y</xsl:with-param>
								<xsl:with-param name="name-label">XSL_CONTRACT_FX_TRADE_APPLICANT_NAME_LABEL</xsl:with-param>
								<xsl:with-param name="override-displaymode">view</xsl:with-param>
			 					<xsl:with-param name="prefix">applicant</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="applicant_name != ''">
						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="content">
								<xsl:call-template name="hidden-field">
							      <xsl:with-param name="name">applicant_name</xsl:with-param>
							      <xsl:with-param name="value" select="applicant_name"/>
							     </xsl:call-template>
								<xsl:call-template name="hidden-field">
							      <xsl:with-param name="name">applicant_address_line_1</xsl:with-param>
							      <xsl:with-param name="value" select="applicant_address_line_1"/>
							     </xsl:call-template>
								<xsl:call-template name="hidden-field">
							      <xsl:with-param name="name">applicant_address_line_2</xsl:with-param>
							      <xsl:with-param name="value" select="applicant_address_line_2"/>
							     </xsl:call-template>
								<xsl:call-template name="hidden-field">
							      <xsl:with-param name="name">applicant_dom</xsl:with-param>
							      <xsl:with-param name="value" select="applicant_dom"/>
							     </xsl:call-template>
								<!-- Applicant Details -->				
								<xsl:call-template name="address">
									<xsl:with-param name="show-entity">Y</xsl:with-param>
									<xsl:with-param name="show-country">N</xsl:with-param>
									<xsl:with-param name="name-label">XSL_CONTRACT_FX_TRADE_APPLICANT_NAME_LABEL</xsl:with-param>
									<xsl:with-param name="override-displaymode">view</xsl:with-param>
				 					<xsl:with-param name="prefix">applicant</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
	
		
			<!-- Application reference selected when you click on the debit account (On FT) -->
			<xsl:if test="product_code!='FT' and $displaymode != 'view'">
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_BANKDETAILS_TAB_ISSUING_BANK</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="issuing-bank-tabcontent"/>    
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>		
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="customer_and_bank_instruction_view">
		<xsl:param name="prefix" />
		<xsl:if
			test="$displaymode='view' and (count(counterparties/counterparty[counterparty_type='04']) or count(counterparties/counterparty[counterparty_type='03']) or count(counterparties/counterparty[counterparty_type='02'])) ">
			<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="toc-item">N</xsl:with-param>
				<xsl:with-param name="legend">XSL_HEADER_SETTLEMENT_DETAILS</xsl:with-param>
				<xsl:with-param name="content">
					<xsl:if
						test="count(counterparties/counterparty[counterparty_type='02'])">
						<div id="beneficiaryTransferDetailsId">
							<xsl:call-template name="show-beneficiary-transfer-details">
								<xsl:with-param name="prefix">review</xsl:with-param>
							</xsl:call-template>
						</div>
					</xsl:if>
					
					<xsl:if
						test="count(counterparties/counterparty[counterparty_type='03']) and (counterparties/counterparty/counterparty_act_no[.!=''] or counterparties/counterparty/counterparty_name[.!=''] or counterparties/counterparty/settlement_mean[.!='']) and counterparties/counterparty/counterparty_cur_code[.!='']">
						<div id="customerpaymentDetailsId">
							<xsl:call-template name="show-customer-payment-details">
								<xsl:with-param name="prefix">review</xsl:with-param>
							</xsl:call-template>
						</div>
					</xsl:if>

					<xsl:if
						test="count(counterparties/counterparty[counterparty_type='04']) and (counterparties/counterparty/counterparty_act_no[.!=''] or counterparties/counterparty/counterparty_name[.!=''] or counterparties/counterparty/settlement_mean[.!='']) and counterparties/counterparty/counterparty_cur_code[.!='']">
						<div id="paymentDetailsId">
							<xsl:call-template name="show-payment-details">
								<xsl:with-param name="prefix"><xsl:value-of select="$prefix" /></xsl:with-param>
							</xsl:call-template>
						</div>

						<div id="intermediaryDetailsId">
							<xsl:call-template name="show-intermediary-details">
								<xsl:with-param name="theLegend">XSL_SI_ADDITIONAL_INSTRUCTIONS_TAB_LABEL</xsl:with-param>
								<xsl:with-param name="prefix"><xsl:value-of select="$prefix" /></xsl:with-param>
							</xsl:call-template>
						</div>

						<div id="additionalDetailsId">
							<xsl:call-template name="show-additional-details">
								<xsl:with-param name="prefix"><xsl:value-of select="$prefix" /></xsl:with-param>
							</xsl:call-template>
						</div>
					</xsl:if>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
  
  
  <!-- Given input produces input display field and hidden field to provide 
		to form to include value in submit ** Notes ** 1. If no value is given for 
		hidden-value, the hidden-value is set to value. ************ -->
	<xsl:template name="display-and-hidden-field">
		<xsl:param name="label" />
		<xsl:param name="prefix" />
		<xsl:param name="name" />
		<xsl:param name="value" select="//*[name()=$name]" />
		<xsl:param name="hidden-value" select="$value" />
		<xsl:param name="hidden-field-required">Y</xsl:param>
		<xsl:param name="input-field-required">Y</xsl:param>

		<xsl:if test="$input-field-required='Y'">
			<xsl:call-template name="input-field">
				<xsl:with-param name="label"><xsl:value-of select="$label" /></xsl:with-param>
				<xsl:with-param name="name"><xsl:if test="$prefix"><xsl:value-of select="$prefix" />_</xsl:if><xsl:value-of select="$name" /></xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="$value" /></xsl:with-param>
			</xsl:call-template>
		</xsl:if>

		<xsl:if test="$hidden-field-required='Y'">
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name"><xsl:value-of select="$name" /></xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="$hidden-value" /></xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="show-beneficiary-transfer-details">
		<xsl:param name="prefix" />
			<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="toc-item">N</xsl:with-param>
				<xsl:with-param name="legend">XSL_HEADER_BENEFICIARY_DETAILS</xsl:with-param>
				<xsl:with-param name="legend-type">indented-header</xsl:with-param>
				<xsl:with-param name="content">
					<xsl:if test="tnx_stat_code[.!='01']">
						<xsl:call-template name="display-and-hidden-field">
							<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SETTLEMENT_BENEFICIARY_DETAILS</xsl:with-param>
							<xsl:with-param name="prefix"><xsl:value-of select="$prefix" /></xsl:with-param>
							<xsl:with-param name="name">beneficiary_name</xsl:with-param>
							<xsl:with-param name="value">
								<xsl:value-of select="counterparties/counterparty[counterparty_type='02']/counterparty_reference" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					<xsl:call-template name="display-and-hidden-field">
						<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_BENEFICIARY_ACCOUNT</xsl:with-param>
						<xsl:with-param name="prefix">
							<xsl:value-of select="$prefix" />
						</xsl:with-param>
						<xsl:with-param name="name">beneficiary_account</xsl:with-param>
						<xsl:with-param name="value">
							<xsl:value-of select="counterparties/counterparty[counterparty_type='02']/counterparty_act_no" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="show-customer-payment-details">
		<xsl:param name="prefix" />
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="toc-item">N</xsl:with-param>
			<xsl:with-param name="legend">XSL_SI_CUSTOMER_INSTRUCTION</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="display-and-hidden-field">
					<xsl:with-param name="label">XSL_SI_CUSTOMER_INSTRUCTIONS_PAYMENT_CURRENCY</xsl:with-param>
					<xsl:with-param name="prefix"><xsl:value-of select="$prefix" /></xsl:with-param>
					<xsl:with-param name="name">cust_payment_cur_code</xsl:with-param>
					<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='03']/counterparty_cur_code" />
				</xsl:call-template>
				<xsl:if test="counterparties/counterparty[counterparty_type='03']/counterparty_act_no[.!='']">
					<xsl:call-template name="display-and-hidden-field">
						<xsl:with-param name="label">XSL_SI_CUSTOMER_INSTRUCTIONS_PAYMENT_ACCOUNT</xsl:with-param>
						<xsl:with-param name="prefix"><xsl:value-of select="$prefix" /></xsl:with-param>
						<xsl:with-param name="name">cust_payment_account</xsl:with-param>
						<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='03']/counterparty_act_no" />
					</xsl:call-template>
				</xsl:if>
				
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">cust_payment_account_act_name</xsl:with-param>
					<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='03']/counterparty_name"></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">cust_payment_account_act_cur_code</xsl:with-param>
					<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='03']/counterparty_cur_code"></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">cust_payment_account_act_no</xsl:with-param>
					<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='03']/counterparty_act_no"></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">cust_settlement_mean</xsl:with-param>
					<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='03']/settlement_mean"></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">cust_settlement_account</xsl:with-param>
					<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='03']/settlement_account"></xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
  	<xsl:template name="show-payment-details">
		<xsl:param name="prefix" />
		<xsl:param name="product_type"/>
		<xsl:choose>
			<xsl:when test="not(counterparties/counterparty)">
				<!-- no counterparty tag so do not show header -->
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when
						test="(counterparties/counterparty[counterparty_type='04']/counterparty_amt[.=''])
						and (counterparties/counterparty[counterparty_type='04']/counterparty_name[.=''])
						and (counterparties/counterparty[counterparty_type='04']/counterparty_address_line_1[.=''])
						and (counterparties/counterparty[counterparty_type='04']/counterparty_address_line_2[.=''])
						and (counterparties/counterparty[counterparty_type='04']/counterparty_dom[.=''])
						and (counterparties/counterparty[counterparty_type='04']/counterparty_act_no[.=''])
						and (counterparties/counterparty[counterparty_type='04']/cpty_bank_swift_bic_code[.=''])
						and (counterparties/counterparty[counterparty_type='04']/cpty_bank_name[.=''])
						and (counterparties/counterparty[counterparty_type='04']/cpty_branch_name[.=''])
						and (counterparties/counterparty[counterparty_type='04']/cpty_branch_address_line_1[.=''])
						and (counterparties/counterparty[counterparty_type='04']/beneficiary_bank_city[.=''])
						and (counterparties/counterparty[counterparty_type='04']/cpty_bank_country[.=''])
						and (counterparties/counterparty[counterparty_type='04']/cpty_benif_account[.=''])
						and (counterparties/counterparty[counterparty_type='04']/counterparty_country[.=''])
						and (counterparties/counterparty[counterparty_type='04']/cpty_benif_bank_routing_no[.=''])
						and (counterparties/counterparty[counterparty_type='04']/cpty_order_cust_name[.=''])
						and (counterparties/counterparty[counterparty_type='04']/cpty_order_cust_addr[.=''])
						and (counterparties/counterparty[counterparty_type='04']/cpty_order_cust_city[.=''])
						and (counterparties/counterparty[counterparty_type='04']/cpty_order_cust_country[.=''])
						and (counterparties/counterparty[counterparty_type='04']/cpty_instruction_indicator[.=''])
						and (counterparties/counterparty[counterparty_type='04']/usual_id[.=''])
						and (counterparties/counterparty[counterparty_type='04']/settlement_mean[.=''])
						and (counterparties/counterparty[counterparty_type='04']/settlement_account[.=''])">
						<!-- no counterparty data so do not show header -->
					</xsl:when>
					<xsl:otherwise>
						<!-- show -->
						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="toc-item">N</xsl:with-param>
							<xsl:with-param name="legend">XSL_HEADER_BENEFICIARY_DETAILS</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="content">
								<xsl:call-template name="display-and-hidden-field">
									<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SETTLEMENT_MEANS</xsl:with-param>
									<xsl:with-param name="prefix"><xsl:value-of select="$prefix" /></xsl:with-param>
									<xsl:with-param name="name">settlement_mean</xsl:with-param>
									<xsl:with-param name="value">
										<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/settlement_mean" />
									</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="display-and-hidden-field">
									<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_SETTLEMENT_ACCOUNTNUMBER</xsl:with-param>
									<xsl:with-param name="prefix">
										<xsl:value-of select="$prefix" />
									</xsl:with-param>
									<xsl:with-param name="name">settlement_account</xsl:with-param>
									<xsl:with-param name="value">
										<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/settlement_account" />
									</xsl:with-param>
								</xsl:call-template>
								<!-- There is no need to display the Payment Amount -->
								<!-- <xsl:choose> -->
								<!-- <xsl:when test="$product-code='FX'"> -->
								<!-- <xsl:call-template name="display-and-hidden-field"> -->
								<!-- <xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_PAYEMENT_AMOUNT</xsl:with-param> -->
								<!-- <xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param> -->
								<!-- <xsl:with-param name="name">paymentAmount</xsl:with-param> -->
								<!-- <xsl:with-param name="value"> -->
								<!-- <xsl:choose> -->
								<!-- <xsl:when test="tnx_amt[.!='']"> -->
								<!-- <xsl:value-of select="fx_cur_code"/>&nbsp;<xsl:value-of select="tnx_amt"/> -->
								<!-- </xsl:when> -->
								<!-- <xsl:otherwise> -->
								<!-- <xsl:value-of select="fx_cur_code"/>&nbsp;<xsl:value-of select="fx_amt"/> -->
								<!-- </xsl:otherwise> -->
								<!-- </xsl:choose> -->
								<!-- </xsl:with-param> -->
								<!-- <xsl:with-param name="hidden-field-required">N</xsl:with-param> -->
								<!-- </xsl:call-template> -->
								<!-- </xsl:when> -->
								<!-- <xsl:when test="$product-code='TD'"> -->
								<!-- <xsl:call-template name="display-and-hidden-field"> -->
								<!-- <xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_PAYEMENT_AMOUNT</xsl:with-param> -->
								<!-- <xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param> -->
								<!-- <xsl:with-param name="name">paymentAmount</xsl:with-param> -->
								<!-- <xsl:with-param name="value"> -->
								<!-- <xsl:value-of select="td_cur_code"/>&nbsp;<xsl:value-of select="td_amt"/> -->
								<!-- </xsl:with-param> -->
								<!-- <xsl:with-param name="hidden-field-required">N</xsl:with-param> -->
								<!-- </xsl:call-template> -->
								<!-- </xsl:when> -->
								<!-- <xsl:when test="$product-code='LA'"> -->
								<!-- <xsl:call-template name="display-and-hidden-field"> -->
								<!-- <xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_PAYEMENT_AMOUNT</xsl:with-param> -->
								<!-- <xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param> -->
								<!-- <xsl:with-param name="name">paymentAmount</xsl:with-param> -->
								<!-- <xsl:with-param name="value"> -->
								<!-- <xsl:value-of select="la_cur_code"/>&nbsp;<xsl:value-of select="la_amt"/> -->
								<!-- </xsl:with-param> -->
								<!-- <xsl:with-param name="hidden-field-required">N</xsl:with-param> -->
								<!-- </xsl:call-template> -->
								<!-- </xsl:when> -->
								<!-- <xsl:otherwise> -->
								<!-- <xsl:call-template name="display-and-hidden-field"> -->
								<!-- <xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_PAYEMENT_AMOUNT</xsl:with-param> -->
								<!-- <xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param> -->
								<!-- <xsl:with-param name="name">paymentAmount</xsl:with-param> -->
								<!-- <xsl:with-param name="value"> -->
								<!-- <xsl:value-of select="counterparties/counterparty[counterparty_type='04']/counterparty_cur_code"/>&nbsp;<xsl:value-of 
									select="counterparties/counterparty[counterparty_type='04']/counterparty_amt"/> -->
								<!-- </xsl:with-param> -->
								<!-- <xsl:with-param name="hidden-field-required">N</xsl:with-param> -->
								<!-- </xsl:call-template> -->
								<!-- </xsl:otherwise> -->
								<!-- </xsl:choose> -->
							<xsl:call-template name="display-and-hidden-field">
								<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_NAME</xsl:with-param>
								<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
								<xsl:with-param name="name">beneficiary_name</xsl:with-param>
								<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/counterparty_name"/>
								<xsl:with-param name="input-field-required">
								<!-- Display an input field if there is a value, by default a hidden field will always be created -->
									<xsl:choose>
										<xsl:when test="normalize-space(counterparties/counterparty[counterparty_type='04']/counterparty_name)!=''">Y</xsl:when>
										<xsl:otherwise>N</xsl:otherwise>
									</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>	
			 <xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_ADDRESS</xsl:with-param>
				<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
				<xsl:with-param name="name">beneficiary_address</xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/counterparty_address_line_1"/>
			</xsl:call-template>	
			 <xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_ADDRESS_2</xsl:with-param>
				<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
				<xsl:with-param name="name">beneficiary_city</xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/counterparty_address_line_2"/>
			</xsl:call-template>
	    	 <xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_CITY</xsl:with-param>
				<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
				<xsl:with-param name="name">beneficiary_dom</xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/counterparty_dom"/>
			</xsl:call-template>
			<xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_COUNTRY</xsl:with-param>
				<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
				<xsl:with-param name="name">beneficiary_country</xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/counterparty_country"/>
			</xsl:call-template>
			 <xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_CLEARING_CODE</xsl:with-param>
				<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
				<xsl:with-param name="name">bene_details_clrc</xsl:with-param>
				<xsl:with-param name="value">
					<xsl:choose>
					<xsl:when test="utils:getDescFromClearingCode(counterparties/counterparty[counterparty_type='04']/cpty_bene_details_clrc,$rundata)!=''">
					<xsl:value-of select="utils:getDescFromClearingCode(counterparties/counterparty[counterparty_type='04']/cpty_bene_details_clrc,$rundata)" />
					</xsl:when>
					<xsl:otherwise>
					 <xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_bene_details_clrc" />
					</xsl:otherwise>
				</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_BENEFICIARY_ACCOUNT</xsl:with-param>
				<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
				<xsl:with-param name="name">beneficiary_account</xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/counterparty_act_no"/>
			</xsl:call-template>
			<xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BIC</xsl:with-param>
				<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
				<xsl:with-param name="name">beneficiary_bank_bic</xsl:with-param>
				<!-- <xsl:with-param name="value" select="beneficiary_bank_bic"/> -->
				<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_bank_swift_bic_code"/>
			</xsl:call-template>	
			 <xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_BANK</xsl:with-param>
				<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
				<xsl:with-param name="name">beneficiary_bank</xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_bank_name"/>
			</xsl:call-template>
	    	 
	    	 <xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_BANK_BRANCH</xsl:with-param>
				<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
				<xsl:with-param name="name">beneficiary_bank_branch</xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_branch_name"/>
			</xsl:call-template>
	    	 			
			
			<!-- artf1076027 This is a temporary fix until a more comprehensive strategic fix can be agreed -->
			 <xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BANK_ADRESS</xsl:with-param>
				<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
				<xsl:with-param name="name">beneficiary_bank_address</xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_branch_address_line_1" />
			</xsl:call-template>
	    	 <xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BANK_CITY</xsl:with-param>
				<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
				<xsl:with-param name="name">beneficiary_bank_city</xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_bank_dom"/>
			</xsl:call-template>
			<xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BANK_COUNTRY</xsl:with-param>
				<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
				<xsl:with-param name="name">beneficiary_bank_country</xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_bank_country"/>
			</xsl:call-template>
			<xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_CLEARING_CODE</xsl:with-param>
				<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
				<xsl:with-param name="name">beneficiary_bank_clrc</xsl:with-param>
				<xsl:with-param name="value">
					<xsl:choose>
					<xsl:when test="utils:getDescFromClearingCode(counterparties/counterparty[counterparty_type='04']/cpty_beneficiary_bank_clrc,$rundata)!=''">
					<xsl:value-of select="utils:getDescFromClearingCode(counterparties/counterparty[counterparty_type='04']/cpty_beneficiary_bank_clrc,$rundata)" />
					</xsl:when>
					<xsl:otherwise>
					 <xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_beneficiary_bank_clrc" />
					</xsl:otherwise>
				</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:choose>
				<xsl:when test="starts-with(counterparties/counterparty[counterparty_type='04']/cpty_benif_account, '/')">
					<xsl:call-template name="display-and-hidden-field">
					<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_BANK_ACCOUNT</xsl:with-param>
					<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
					<xsl:with-param name="name">cpty_benif_account</xsl:with-param>
					<xsl:with-param name="value" select="translate(counterparties/counterparty[counterparty_type='04']/cpty_benif_account, '/','')"/>
				</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
				<xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_BENEFICIARY_BANK_ACCOUNT</xsl:with-param>
					<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
					<xsl:with-param name="name">cpty_benif_account</xsl:with-param>
					<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_benif_account"/>
				</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
			
			<xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_BANK_NUMBER</xsl:with-param>
				<xsl:with-param name="name">beneficiary_bank_routing_number</xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_benif_bank_routing_no"/>
			</xsl:call-template>
			
			<xsl:call-template name="hidden-field">
		            <xsl:with-param name="name">swift_charges_type</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_swift_charges_paid"/></xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_ORDERING_CUST_NAME</xsl:with-param>
				<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
				<xsl:with-param name="name">ordering_cust_name</xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_order_cust_name"/>
			</xsl:call-template>
			<xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_ORDERING_ACCOUNT_NO</xsl:with-param>
				<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
				<xsl:with-param name="name">ordering_cust_account</xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_order_account_no"/>
			</xsl:call-template>
			<xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_ORDERING_CUST_ADDRESS</xsl:with-param>
				<xsl:with-param name="name">ordering_cust_address</xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_order_cust_addr"/>
			</xsl:call-template>
			<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_order_cust_addr_2[.!='']">
			<xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_ORDERING_CUST_ADDRESS_2</xsl:with-param>
				<xsl:with-param name="name">ordering_cust_address_2</xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_order_cust_addr_2"/>
			</xsl:call-template>
			</xsl:if>
			
			<xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_ORDERING_CUST_CITYSTATE</xsl:with-param>
				<!--xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_ORDERING_CITY</xsl:with-param-->
				<xsl:with-param name="name">ordering_cust_citystate</xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_order_cust_city"/>
			</xsl:call-template>
				
			<xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_ORDERING_CUST_COUNTRY</xsl:with-param>
				<!-- xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_ORDERING_COUNTRY</xsl:with-param-->
				<xsl:with-param name="name">ordering_cust_country</xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_order_cust_country"/>
			</xsl:call-template>
			
 			<xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_CLEARING_CODE</xsl:with-param>
				<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
				<xsl:with-param name="name">order_details_clrc</xsl:with-param>
				<xsl:with-param name="value">
				<xsl:choose>
					<xsl:when test="utils:getDescFromClearingCode(counterparties/counterparty[counterparty_type='04']/cpty_order_details_clrc,$rundata)!=''">
					<xsl:value-of select="utils:getDescFromClearingCode(counterparties/counterparty[counterparty_type='04']/cpty_order_details_clrc,$rundata)" />
					</xsl:when>
					<xsl:otherwise>
					 <xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_order_details_clrc" />
					</xsl:otherwise>
				</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_FT_DEAL_SUMMARY_LABEL_SWIFT_CHARGES_TYPE</xsl:with-param>
				<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
				<xsl:with-param name="name">swift_charges_type</xsl:with-param>
				<xsl:with-param name="value">
					<xsl:if test="counterparties/counterparty[counterparty_type='04']/cpty_swift_charges_paid[.!='']">
						<xsl:value-of select="localization:getDecode($language, 'N017', counterparties/counterparty[counterparty_type='04']/cpty_swift_charges_paid)"/>
					</xsl:if>
				</xsl:with-param>
				<xsl:with-param name="hidden-field-required">N</xsl:with-param>
			</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
  
  <xsl:template name="show-intermediary-details">
		<xsl:param name="prefix" />
		<xsl:param name="theLegend" />

		<xsl:if test="(counterparties/counterparty[counterparty_type='04']/cpty_inter_swift_bic_code[.!='']) 
		or (counterparties/counterparty[counterparty_type='04']/cpty_inter_bank_name[.!=''])
	 	or (counterparties/counterparty[counterparty_type='04']/cpty_inter_bank_addr[.!=''])
	 	or (counterparties/counterparty[counterparty_type='04']/cpty_inter_city_state[.!=''])
	 	or (counterparties/counterparty[counterparty_type='04']/cpty_inter_country[.!=''])
	 	or starts-with(counterparties/counterparty[counterparty_type='04']/cpty_inter_routing_no, '/')
	 	or (counterparties/counterparty[counterparty_type='04']/cpty_inter_routing_no[.!=''])
	 	or (counterparties/counterparty[counterparty_type='04']/cpty_special_routing_1[.!=''])
	 	or (counterparties/counterparty[counterparty_type='04']/cpty_special_routing_2[.!=''])
	 	or (counterparties/counterparty[counterparty_type='04']/cpty_special_routing_3[.!=''])
	 	or (counterparties/counterparty[counterparty_type='04']/cpty_special_routing_4[.!=''])
	 	or (counterparties/counterparty[counterparty_type='04']/cpty_special_routing_5[.!=''])
	 	or (counterparties/counterparty[counterparty_type='04']/cpty_special_routing_6[.!=''])">
	 	
	<xsl:call-template name="fieldset-wrapper">
	<xsl:with-param name="toc-item">N</xsl:with-param>
		<xsl:with-param name="legend"><xsl:value-of select="$theLegend"/></xsl:with-param>
		<xsl:with-param name="legend-type">indented-header</xsl:with-param>
		<xsl:with-param name="content">
			<xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK_BIC</xsl:with-param>
				<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
				<xsl:with-param name="name">intermediary_bank_bic</xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_inter_swift_bic_code" />
			</xsl:call-template>
			
			
			<xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK</xsl:with-param>
				<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
				<xsl:with-param name="name">intermediary_bank</xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_inter_bank_name" />
			</xsl:call-template>
			
		<xsl:choose>    
	    	 <xsl:when test="not(normalize-space(counterparties/counterparty[counterparty_type='04']/cpty_inter_bank_addr)) and not(normalize-space(counterparties/counterparty[counterparty_type='04']/cpty_inter_city_state)) and not(normalize-space(counterparties/counterparty[counterparty_type='04']/cpty_inter_country))">
	         <!-- nothing to display -->
	    	 </xsl:when>
	    	 <xsl:otherwise>
	    	 
	    	 <xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK_STREET</xsl:with-param>
				<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
				<xsl:with-param name="name">intermediary_bank_street</xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_inter_bank_addr" />
			</xsl:call-template>
	    	<xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK_CITY</xsl:with-param>
				<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
				<xsl:with-param name="name">intermediary_bank_city</xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_inter_city_state"/>
			</xsl:call-template>
	    	<xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK_COUNTRY</xsl:with-param>
				<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
				<xsl:with-param name="name">intermediary_bank_country</xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_inter_country"/>
			</xsl:call-template>
			</xsl:otherwise>			    	 
		</xsl:choose>
		<xsl:call-template name="display-and-hidden-field">
			<xsl:with-param name="label">XSL_CLEARING_CODE</xsl:with-param>
			<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
			<xsl:with-param name="name">inter_bank_clrc</xsl:with-param>
			<xsl:with-param name="value">
				<xsl:choose>
					<xsl:when test="utils:getDescFromClearingCode(counterparties/counterparty[counterparty_type='04']/cpty_inter_bank_clrc,$rundata)!=''">
						<xsl:value-of select="utils:getDescFromClearingCode(counterparties/counterparty[counterparty_type='04']/cpty_inter_bank_clrc,$rundata)" />
					</xsl:when>
					<xsl:otherwise>
					 	<xsl:value-of select="counterparties/counterparty[counterparty_type='04']/cpty_inter_bank_clrc" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
	     <xsl:choose>
				<xsl:when test="starts-with(counterparties/counterparty[counterparty_type='04']/cpty_inter_routing_no, '/')">
				<xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK_ABA</xsl:with-param>
				<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
				<xsl:with-param name="name">intermediary_bank_aba</xsl:with-param>
				<xsl:with-param name="value" select="translate(counterparties/counterparty[counterparty_type='04']/cpty_inter_routing_no, '/','')"/>
			</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK_ABA</xsl:with-param>
				<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
				<xsl:with-param name="name">intermediary_bank_aba</xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_inter_routing_no"/>
			</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>		
			<xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_SI_FREE_FORMAT_ROUTING_INSTRUCTION_1</xsl:with-param>
				<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
				<xsl:with-param name="name">intermediary_bank_instruction_1</xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_special_routing_1"/>
			</xsl:call-template>
			<xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_SI_FREE_FORMAT_ROUTING_INSTRUCTION_2</xsl:with-param>
				<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
				<xsl:with-param name="name">intermediary_bank_instruction_2</xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_special_routing_2"/>
			</xsl:call-template>
			<xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_SI_FREE_FORMAT_ROUTING_INSTRUCTION_3</xsl:with-param>
				<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
				<xsl:with-param name="name">intermediary_bank_instruction_3</xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_special_routing_3"/>
			</xsl:call-template>
			<xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_SI_FREE_FORMAT_ROUTING_INSTRUCTION_4</xsl:with-param>
				<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
				<xsl:with-param name="name">intermediary_bank_instruction_4</xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_special_routing_4"/>
			</xsl:call-template>
			<xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_SI_FREE_FORMAT_ROUTING_INSTRUCTION_5</xsl:with-param>
				<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
				<xsl:with-param name="name">intermediary_bank_instruction_5</xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_special_routing_5"/>
			</xsl:call-template>
			<xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_SI_FREE_FORMAT_ROUTING_INSTRUCTION_6</xsl:with-param>
				<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
				<xsl:with-param name="name">intermediary_bank_instruction_6</xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_special_routing_6"/>
			</xsl:call-template>				
		</xsl:with-param>
	</xsl:call-template>
	
	</xsl:if>
	</xsl:template>
  
  <xsl:template name="show-additional-details">
	<xsl:param name="prefix"/>
	    <xsl:choose> 
			<xsl:when test="not(counterparties/counterparty)">
			<!--  no counterparty tag so do not show header -->
			</xsl:when>
			<xsl:otherwise> 
            <xsl:choose> 
            <xsl:when test="(counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_1[.='']) and (counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_2[.='']) and (counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_3[.='']) and (counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_4[.=''])"> 
                <!--  no counterparty data so do not show header -->
			</xsl:when>
			<xsl:otherwise>
                <!-- show --> 
        <xsl:call-template name="fieldset-wrapper">
        <xsl:with-param name="toc-item">N</xsl:with-param>
		<xsl:with-param name="legend">XSL_SI_PAYMENT_DETAILS_TAB_LABEL</xsl:with-param>
		<xsl:with-param name="legend-type">indented-header</xsl:with-param>
		<xsl:with-param name="content">
			<xsl:call-template name="display-and-hidden-field">		
				<xsl:with-param name="label">XSL_SI_ADDITIONAL_DETAILS_LINE_1</xsl:with-param>
				<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
				<xsl:with-param name="name">free_additional_details_line_1_input</xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_1"/>
			</xsl:call-template>	
			<xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_SI_ADDITIONAL_DETAILS_LINE_2</xsl:with-param>
				<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
				<xsl:with-param name="name">free_additional_details_line_2_input</xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_2"/>
			</xsl:call-template>
			<xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_SI_ADDITIONAL_DETAILS_LINE_3</xsl:with-param>
				<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
				<xsl:with-param name="name">free_additional_details_line_3_input</xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_3"/>
			</xsl:call-template>
			<xsl:call-template name="display-and-hidden-field">
				<xsl:with-param name="label">XSL_SI_ADDITIONAL_DETAILS_LINE_4</xsl:with-param>
				<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
				<xsl:with-param name="name">free_additional_details_line_4_input</xsl:with-param>
				<xsl:with-param name="value" select="counterparties/counterparty[counterparty_type='04']/cpty_payment_detail_4"/>
			</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>   
			</xsl:otherwise>
			</xsl:choose>
			</xsl:otherwise> 
			</xsl:choose> 		
</xsl:template>
  <xsl:template name="cash-rate-progress-bar">
		<xsl:call-template name="row-wrapper">
			<xsl:with-param name="content">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_RATES_DISCLAIMER')"/>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="row-wrapper">
			<xsl:with-param name="content">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_CONTRACT_FX_RATE_VALIDITY_DISCLAIMER_PREFIX')"/>
				<span id="validitySpan"></span>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="row-wrapper">
			<xsl:with-param name="content">
			<div id="progressBarCash" align="center">
				<div dojoType="dijit.ProgressBar" style="width:300px" jsId="jsProgress" id="countdownProgress" maximum="10"></div>
			</div>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	  
</xsl:stylesheet>