<?xml version="1.0"?>
<!--
   Copyright (c) 2000-2011 Misys (http://www.misys.com),
   All Rights Reserved. 
-->
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools" 
	exclude-result-prefixes="convertTools">
	
	<!-- Removal of general V4-specific fields -->
	<!-- <xsl:template match="bo_tnx_id"/> -->
	<xsl:template match="dest_master_version"/>
	<xsl:template match="latest_answer_date"/>
	<xsl:template match="master_version"/>
	<xsl:template match="cross_references"/>
	<xsl:template match="action_req_code"/>
	<!-- xsl:template match="drawee_country"/>  -->
	<xsl:template match="drawer_country"/>
	<xsl:template match="applicant_country"/>
	<!-- MPS-22499 : Portal Initiated Banker's Guarantee XML does not contain a beneficiary_country tag  -->
	<!-- 
	<xsl:template match="beneficiary_country"/>
	 -->
	<!-- End : MPS-22499 -->	
	<!-- Removal of LC & SI V4-specific fields -->
<!-- 	<xsl:template match="advise_renewal_flag"/>
	<xsl:template match="advise_renewal_days_nb"/> -->
	<xsl:template match="lc_outstanding_amt"/>
	<!-- <xsl:template match="renew_flag"/>
	<xsl:template match="renew_on_code"/>
	<xsl:template match="renewal_calendar_date"/>
	<xsl:template match="renew_for_nb"/>
	<xsl:template match="renew_for_period"/>
	<xsl:template match="rolling_renewal_flag"/>
	<xsl:template match="rolling_renewal_nb"/>
	<xsl:template match="rolling_cancellation_days"/>
	<xsl:template match="renew_amt_code"/> -->
	<xsl:template match="advising_bank_lc_ref_id"/>
	<!--
	<xsl:template match="tenor_days"/>
	<xsl:template match="tenor_days_type"/>
	<xsl:template match="tenor_from_after"/>
	<xsl:template match="tenor_period"/>
	<xsl:template match="tenor_type"/>
	<xsl:template match="tenor_type_details"/>
	-->
	<!--
	<xsl:template match="tenor_maturity_date">
		<xsl:call-template name="remove_element"><xsl:with-param name="productCode">LC</xsl:with-param></xsl:call-template>
	</xsl:template>
	-->
	<!-- <xsl:template match="fwd_contract_no">
		<xsl:call-template name="remove_element"><xsl:with-param name="productCode">LC</xsl:with-param></xsl:call-template>
	</xsl:template> -->
	<xsl:template match="fwd_contract_no">
		<xsl:choose>
				<xsl:when test="product_code[. = 'TF']">
					<xsl:call-template name="remove_element">
						<xsl:with-param name="productCode">TF</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="remove_element">
						<xsl:with-param name="productCode">LC</xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
	</xsl:template>
	<!-- Removal of SI V4-specific fields -->
	<xsl:template match="tenor_maturity_date">
		<xsl:call-template name="remove_element"><xsl:with-param name="productCode">SI</xsl:with-param></xsl:call-template>
	</xsl:template>
	
	<!-- Removal of EC V4-specific fields -->
	<xsl:template match="ec_outstanding_amt"/>
	<xsl:template match="needs_refer_to"/>
	<xsl:template match="needs_instr_by_code"/>

	<!-- Removal of EL & SR V4-specific fields -->
	<xsl:template match="sec_beneficiary_name">
		<xsl:call-template name="sec_beneficiary_to_sec_beneficiary"/>
	</xsl:template>
	<xsl:template match="sec_beneficiary_address_line_1">
		<xsl:call-template name="sec_beneficiary_to_sec_beneficiary"/>
	</xsl:template>
	<xsl:template match="sec_beneficiary_address_line_2">
		<xsl:call-template name="sec_beneficiary_to_sec_beneficiary"/>
	</xsl:template>
	<xsl:template match="sec_beneficiary_dom">
		<xsl:call-template name="sec_beneficiary_to_sec_beneficiary"/>
	</xsl:template>
	<xsl:template match="sec_beneficiary_reference">
		<xsl:call-template name="sec_beneficiary_to_sec_beneficiary"/>
	</xsl:template>
	<xsl:template match="assignee_name">
		<xsl:call-template name="assignee_to_sec_beneficiary"><xsl:with-param name="field">name</xsl:with-param></xsl:call-template>
	</xsl:template>
	<xsl:template match="assignee_address_line_1">
		<xsl:call-template name="assignee_to_sec_beneficiary"><xsl:with-param name="field">address_line_1</xsl:with-param></xsl:call-template>
	</xsl:template>
	<xsl:template match="assignee_address_line_2">
		<xsl:call-template name="assignee_to_sec_beneficiary"><xsl:with-param name="field">address_line_2</xsl:with-param></xsl:call-template>
	</xsl:template>
	<xsl:template match="assignee_dom">
		<xsl:call-template name="assignee_to_sec_beneficiary"><xsl:with-param name="field">dom</xsl:with-param></xsl:call-template>
	</xsl:template>
	<xsl:template match="assignee_country">
		<xsl:call-template name="assignee_to_sec_beneficiary"><xsl:with-param name="field">country</xsl:with-param></xsl:call-template>
	</xsl:template>
	<xsl:template match="assignee_reference">
		<xsl:call-template name="assignee_to_sec_beneficiary"><xsl:with-param name="field">reference</xsl:with-param></xsl:call-template>
	</xsl:template>
	<!-- MPS-21970 : Missing XML tags for various transfer details in Portal caused inconsistent value mapping in TI for an ELC transfer event -->
	<!-- As per the above request commenting the below lines -->
	<!--  
	<xsl:template match="notify_amendment_flag"/>
	<xsl:template match="substitute_invoice_flag"/>
	-->
	<!-- End : MPS-21970 -->
	<!-- <xsl:template match="advise_mode_code"/> -->
	<!-- MPS-22487 : - Cty Code tag not available in Portal's Outgoing XML for an ELC & ESB Transfer events -->
	<!--  
	<xsl:template match="sec_beneficiary_country"/>
	-->
	<!-- End : MPS-22487 -->
	<!-- Removal of IC V4-specific fields -->
	<xsl:template match="ic_outstanding_amt"/>
	
	<!-- Removal of BG V4-specific fields -->
	<xsl:template match="bg_code"/>
	<xsl:template match="bg_outstanding_amt"/>
	<xsl:template match="bg_text_details_code"/>
	<!-- MPS-22587 : Portal initiated Banker's Guarantee does not generate XML fields for Portal field 'Text Language' -->
	<!-- 
	<xsl:template match="text_language"/>
	<xsl:template match="text_language_other"/>
	 -->
	<!-- End : MPS-22587  -->
	<!-- Removal of TF V4-specific fields -->
	<xsl:template match="fin_outstanding_amt"/>
	<!-- <xsl:template match="fwd_contract_no">
		<xsl:call-template name="remove_element"><xsl:with-param name="productCode">TF</xsl:with-param></xsl:call-template>
	</xsl:template> -->
	
	<!-- Removal of SG V4-specific fields -->
	<xsl:template match="sg_outstanding_amt"/>
	
	<!-- Removal of IR V4-specific fields -->
	<xsl:template match="ir_outstanding_amt"/>
	<xsl:template match="remitter_country"/>
	
	<!-- 
	<xsl:template match="advise_thru_bank"/>
	<xsl:template match="amd_details"/>
	 -->
	
	<!-- Translate financing type for Financing Request -->
	<xsl:template match="fin_type">
		<xsl:choose>
			<xsl:when test="../product_code = 'TF'">
				<xsl:choose>
					<xsl:when test=". = '01' and ../sub_product_code = 'ITRPT'">
						<fin_type>01</fin_type>
					</xsl:when>
					<xsl:when test=". = '01' and ../sub_product_code = 'ILNLC'">
						<fin_type>02</fin_type>
					</xsl:when>
					<xsl:when test=". = '01' and ../sub_product_code = 'ILNIC'">
						<fin_type>03</fin_type>
					</xsl:when>
					<xsl:when test=". = '01' and ../sub_product_code = 'IBCLC'">
						<fin_type>04</fin_type>
					</xsl:when>
					<xsl:when test=". = '01' and ../sub_product_code = 'IOTHF'">
						<fin_type>83</fin_type>
					</xsl:when>
					<xsl:when test=". = '02' and ../sub_product_code = 'ECRBP'">
						<fin_type>20</fin_type>
					</xsl:when>
					<xsl:when test=". = '02' and ../sub_product_code = 'EDILC'">
						<fin_type>21</fin_type>
					</xsl:when>
					<xsl:when test=". = '02' and ../sub_product_code = 'EBEXP'">
						<fin_type>22</fin_type>
					</xsl:when>
					<xsl:when test=". = '02' and ../sub_product_code = 'EDIEC'">
						<fin_type>23</fin_type>
					</xsl:when>
					<xsl:when test=". = '02' and ../sub_product_code = 'EPCKC'">
						<fin_type>24</fin_type>
					</xsl:when>
					<xsl:when test=". = '02' and ../sub_product_code = 'EOTHF'">
						<fin_type>86</fin_type>
					</xsl:when>
					<xsl:when test=". = '99' and ../sub_product_code = 'OTHER'">
						<fin_type>99</fin_type>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<fin_type><xsl:value-of select="."/></fin_type>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
		
	<!-- Add additional fields at the End -->
	<xsl:template match="/*">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
			
			<xsl:choose>
				<xsl:when test="product_code[. = 'LC']">
					<xsl:call-template name="addition_field_lc"></xsl:call-template>
				</xsl:when>
				<xsl:when test="product_code[. = 'EC']">
					<xsl:call-template name="addition_field_ec"></xsl:call-template>
				</xsl:when>
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template name="addition_field_lc">
		<xsl:apply-templates select="*[local-name()='advise_renewal_days_nb']" mode="element_to_add"/>
		<xsl:apply-templates select="*[local-name()='advise_renewal_flag']" mode="element_to_add"/>
		<xsl:apply-templates select="*[local-name()='renew_amt_code']" mode="element_to_add"/>
		<xsl:apply-templates select="*[local-name()='renew_flag']" mode="element_to_add"/>
		<xsl:apply-templates select="*[local-name()='renew_for_nb']" mode="element_to_add"/>
		<xsl:apply-templates select="*[local-name()='renew_for_period']" mode="element_to_add"/>
		<xsl:apply-templates select="*[local-name()='renew_on_code']" mode="element_to_add"/>
		<xsl:apply-templates select="*[local-name()='renewal_calendar_date']" mode="element_to_add"/>
		<xsl:apply-templates select="*[local-name()='rolling_cancellation_days']" mode="element_to_add"/>
		<xsl:apply-templates select="*[local-name()='rolling_renewal_flag']" mode="element_to_add"/>
		<xsl:apply-templates select="*[local-name()='rolling_renewal_nb']" mode="element_to_add"/>
		<xsl:apply-templates select="*[local-name()='advising_bank_lc_ref_id']" mode="element_to_add"/>
		<xsl:apply-templates select="*[contains(local-name(),'tenor')]" mode="element_to_add"/>
	</xsl:template>
	
	<xsl:template name="addition_field_ec">
		<xsl:apply-templates select="*[local-name()='needs_refer_to']" mode="element_to_add"/>
		<xsl:apply-templates select="*[local-name()='needs_instr_by_code']" mode="element_to_add"/>
	</xsl:template>

	<!-- ******* FUNCTIONS *******-->
	
	<!-- Element => Additional Field -->
	<xsl:template match="*" mode="element_to_add">
		<additional_field name="{local-name(.)}" type="string" scope="master"><xsl:value-of select="."/></additional_field>
	</xsl:template>	
	
	<xsl:template name="remove_element">
		<xsl:param name="productCode"/>
		<xsl:choose>
			<xsl:when test="../product_code[. = $productCode]"/>
			<xsl:otherwise>
				<xsl:copy>
					<xsl:apply-templates select="@*|node()"/>
	  			</xsl:copy>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- recursive copy of all elements and attributes -->
	<xsl:template match="@*|node()">
	  <xsl:copy>
		<xsl:apply-templates select="@*|node()"/>
	  </xsl:copy>
	</xsl:template>

	<!-- preserve line breaks on narrative fields-->
	<xsl:template match="*[starts-with(local-name(),'narrative')]">
		<xsl:call-template name="normalizeXML">
			<xsl:with-param name="text"><xsl:value-of select="."/></xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
    <xsl:template name="normalizeXML">
    	<xsl:param name="text"/>
    	<xsl:copy>
    		<xsl:value-of disable-output-escaping="yes" select="convertTools:normalizeExportedXML($text)"/>
    	</xsl:copy>
    </xsl:template>
    
    <xsl:template name="assignee_to_sec_beneficiary">
		<xsl:param name="field"/>
		<xsl:choose>
			<xsl:when test="../sub_tnx_type_code[. = '19']">
				<xsl:choose>
					<xsl:when test="$field = 'name'">
						<sec_beneficiary_name><xsl:value-of select="."/></sec_beneficiary_name>
					</xsl:when>
					<xsl:when test="$field = 'address_line_1'">
						<sec_beneficiary_address_line_1><xsl:value-of select="."/></sec_beneficiary_address_line_1>
					</xsl:when>
					<xsl:when test="$field = 'address_line_2'">
						<sec_beneficiary_address_line_2><xsl:value-of select="."/></sec_beneficiary_address_line_2>
					</xsl:when>
					<xsl:when test="$field = 'dom'">
						<sec_beneficiary_dom><xsl:value-of select="."/></sec_beneficiary_dom>
					</xsl:when>
					<xsl:when test="$field = 'country'">
						<sec_beneficiary_country><xsl:value-of select="."/></sec_beneficiary_country>
					</xsl:when>
					<xsl:when test="$field = 'reference'">
						<sec_beneficiary_reference><xsl:value-of select="."/></sec_beneficiary_reference>
					</xsl:when>
					<xsl:otherwise/>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise/>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="sec_beneficiary_to_sec_beneficiary">
		<xsl:choose>
			<xsl:when test="../sub_tnx_type_code[. = '12']">
				<xsl:copy>
					<xsl:apply-templates select="@*|node()"/>
	  			</xsl:copy>
			</xsl:when>
			<xsl:otherwise/>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="bank_payment_obligation/PmtOblgtn/PmtTerms/PmtTerms" >
		<PmtTerm>
			<xsl:copy-of select="node()"/>
		</PmtTerm>
	</xsl:template>
</xsl:stylesheet>