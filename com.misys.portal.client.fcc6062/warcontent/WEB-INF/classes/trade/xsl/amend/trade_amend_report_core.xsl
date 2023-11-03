<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Import Letter of Credit (LC) Form, Customer Side.
 
 Note: Templates beginning with lc_ are in lc_common.xsl

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

##########################################################
-->
<!DOCTYPE xsl:stylesheet [
<!ENTITY nbsp "&#160;"> 
]>

<xsl:stylesheet 
  version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xd="http://www.pnp-software.com/XSLTdoc"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	xmlns:common="http://exslt.org/common"
	xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
	xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
	exclude-result-prefixes="localization utils common">

	<!-- Global Imports. -->
	<xsl:include href="../../../core/xsl/common/trade_common.xsl" />
	<xsl:include href="../../../core/xsl/common/static_document_upload_templates.xsl" />
	<xsl:include href="../../../core/xsl/system/sy_reauthenticationdialog.xsl" />
	<xsl:include href="../../../trade/xsl/amend/amend_report_common.xsl" />
	<xsl:include href="../../../core/xsl/common/bank_common.xsl"/>
	
	<!-- 
   		TNX FORM TEMPLATE.
  	-->
	<xsl:template match="lc_tnx_record | si_tnx_record | el_tnx_record | sr_tnx_record ">

		<!-- Preloader  -->
		<xsl:call-template name="loading-message"/>
		<xsl:call-template name="static-document-dialog"/>
		<div>
			<xsl:attribute name="id">
				<xsl:value-of select="$displaymode"/>
			</xsl:attribute>

			<!-- Form #0 : Main Form -->    
			<xsl:call-template name="form-wrapper">
				<xsl:with-param name="name" select="$main-form-name"/>
				<xsl:with-param name="validating">Y</xsl:with-param>
				<xsl:with-param name="content">
		            
		            <!-- Display common reporting area -->
		            <xsl:if test="product_code[.='SI' or .='LC'] and security:isBank($rundata)">
   				    <xsl:call-template name="bank-reporting-area"/>
   				    </xsl:if>
   				    
					<xsl:call-template name="amend-view-general-details" />

					<xsl:call-template name="amend-view-applicant-details"/>      
					<xsl:call-template name="amend-view-alt-applicant-details"/>      	
					<xsl:call-template name="amend-view-beneficiary-details"/>     
					<xsl:if test="product_code[.='SR' or .='EL' ]">	 
						<xsl:call-template name="amend-view-issuing-bank-details"/>  
					</xsl:if>
					<xsl:call-template name="amend-view-charges"/>
					<xsl:call-template name="amend-view-amt-details-header"/>
					<!-- <xsl:call-template name="requested_confirmation_party" /> -->
					<xsl:if test="revolving_flag[.='Y']">
					<xsl:call-template name="amend-view-revolving-details-header"/> 
					</xsl:if>
					<xsl:call-template name="amend-view-payment-details-header"/>
					<xsl:if test="product_code[.='SI' or .='SR']">
						<xsl:call-template name="amend-view-renewal-details"/>	
					</xsl:if>
					<xsl:if test="product_code[.='LC'] and stnd_by_lc_flag[. ='Y'] and security:isBank($rundata)">
						<xsl:call-template name="amend-view-renewal-details"/>	
					</xsl:if>
					<xsl:call-template name="amend-view-shipment-details-header"/>
					<xsl:if test="product_code[.!='SR' and .!='EL' ]">				
						<xsl:call-template name="amend-view-bank-details"/>
					</xsl:if>
					<xsl:if test="product_code[.='SI']">		
						<xsl:call-template name="amend-view-standby-details"/>
					</xsl:if>
					<xsl:if test="securitycheck:hasPermission($rundata,'ls_access') = 'true'">
					<xsl:call-template name="amend-view-linked-ls-declaration"/>
					</xsl:if>
					<!-- <xsl:call-template name="amend-view-linked-licenses"/> -->
					<xsl:call-template name="amend-view-narrative-details">
						<xsl:with-param name="securityEnabled">
							<xsl:choose>
								<xsl:when test = "security:isBank($rundata)">N</xsl:when>
								<xsl:otherwise>Y</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>										
					<xsl:call-template name="amend-view-narrative-period"/>
					<xsl:call-template name="amend-view-period-for-presentation"/>
					<xsl:call-template name="amend-view-narrative-charges"/>
					<xsl:call-template name="amend-view-bank-instructions-header">
						<xsl:with-param name="send-mode-required">Y</xsl:with-param>
						<xsl:with-param name="delivery-channel-displayed">Y</xsl:with-param>
					</xsl:call-template>

				</xsl:with-param>
			</xsl:call-template>
		</div>
	</xsl:template>

	<!-- This template displays the disclamer for the updated details -->
	<xsl:template name="amend-view-disclaimer">
		<div class="disclaimer">
			<h2>
				<xsl:value-of select="localization:getGTPString($language, 'XSL_AMEND_DISCLAIMER')"/>
			</h2>
		</div>
	</xsl:template>

	<!-- This template displays the general details fieldset of the transaction -->
	<xd:doc>
		<xd:short>General details.</xd:short>
		<xd:detail>
		This template displays the general details fieldset of the transaction
		</xd:detail>
	</xd:doc>
	<xsl:template name="amend-view-general-details">		
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="amend-view-disclaimer"/>
				<xsl:call-template name="column-container">
					<xsl:with-param name="content">
						<!-- master Column -->
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="appendClass">contentGray</xsl:with-param>
							<xsl:with-param name="content">
								<!-- Common general details. -->
								<xsl:call-template name="common-general-details-amend">
									<xsl:with-param name="path" select="$prev_path"/> 
									<xsl:with-param name="org_path" select="$prev_path"/>
									<xsl:with-param name="org_path1" select="$tnx_path"/>  
								</xsl:call-template>
								<!-- LC Details. -->
								<xsl:call-template name="lc-general-details-amend">
									<xsl:with-param name="path" select="$prev_path"/>
									<xsl:with-param name="org_path" select="$prev_path"/>
									<xsl:with-param name="org_path1" select="$tnx_path"/> 
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						<!-- tnx Column -->
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="content">
								<!-- Common general details. -->
								<xsl:call-template name="common-general-details-amend">
									<xsl:with-param name="path" select="$tnx_path"/> 
									<xsl:with-param name="org_path" select="$prev_path"/>
								</xsl:call-template>
								<!-- LC Details. -->
								<xsl:call-template name="lc-general-details-amend">
									<xsl:with-param name="path" select="$tnx_path"/>
									<xsl:with-param name="org_path" select="$prev_path"/> 
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>  
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xd:doc>
		<xd:short>charges.</xd:short>
		<xd:detail>
		This template displays the general details fieldset of the transaction
		</xd:detail>
	</xd:doc>
	<xsl:template name="amend-view-charges">		
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_PRODUCT_CHARGE_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="column-container">
					<xsl:with-param name="content">
						<!-- master Column -->
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="appendClass">contentGray</xsl:with-param>
							<xsl:with-param name="content">
								<xsl:call-template name="amend-charges-details">
									<xsl:with-param name="path" select="$prev_path"/>
									<xsl:with-param name="org_path" select="$prev_path"/>
									<xsl:with-param name="org_path1" select="$tnx_path"/>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						<!-- tnx Column -->
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="content">
								<xsl:call-template name="amend-charges-details">
									<xsl:with-param name="path" select="$tnx_path"/>
									<xsl:with-param name="org_path" select="$prev_path"/>
									<xsl:with-param name="in_sesion">Y</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>  
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- This template displays the applicant details section of the transaction -->
	<xd:doc>
		<xd:short>Applicant Details.</xd:short>
		<xd:detail>
		This template displays the applicant details section of the transaction.
		</xd:detail>
	</xd:doc>
	<xsl:template name="amend-view-applicant-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="column-container">
					<xsl:with-param name="content">	 
						<!-- master column -->
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="appendClass">contentGray</xsl:with-param>
							<xsl:with-param name="content">                         
								<xsl:call-template name="applicantaddress">
									<xsl:with-param name="path" select="$prev_path"/> 
									<xsl:with-param name="org_path" select="$prev_path"/>
									<xsl:with-param name="org_path1" select="$tnx_path"/>
								</xsl:call-template>			      
							</xsl:with-param>
						</xsl:call-template>
						<!-- tnx column -->
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="content">
								<xsl:call-template name="applicantaddress">
									<xsl:with-param name="path" select="$tnx_path"/> 
									<xsl:with-param name="org_path" select="$prev_path"/>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- This template displays the applicant details section of the transaction -->
	<xd:doc>
		<xd:short>Alternate Applicant Details.</xd:short>
		<xd:detail>
		This template displays the alternate applicant details section of the transaction.
		</xd:detail>
	</xd:doc>
	<xsl:template name="amend-view-alt-applicant-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_ALTERNATE_PARTY_DETAILS</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="column-container">
					<xsl:with-param name="content">	 
						<!-- master column -->
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="appendClass">contentGray</xsl:with-param>
							<xsl:with-param name="content">                         
								<xsl:call-template name="alt-applicantaddress">
									<xsl:with-param name="path" select="$prev_path"/> 
									<xsl:with-param name="org_path" select="$prev_path"/>
									<xsl:with-param name="org_path1" select="$tnx_path"/>
								</xsl:call-template>			      
							</xsl:with-param>
						</xsl:call-template>
						<!-- tnx column -->
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="content">
								<xsl:call-template name="alt-applicantaddress">
									<xsl:with-param name="path" select="$tnx_path"/> 
									<xsl:with-param name="org_path" select="$prev_path"/>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- This template displays the beneficiary details fieldset of the transaction -->
	<xd:doc>
		<xd:short>Beneficiary details.</xd:short>
		<xd:detail>
		This template displays the beneficiary details fieldset of the transaction.
		</xd:detail>
	</xd:doc>
	<xsl:template name="amend-view-beneficiary-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_BENEFICIARY_DETAILS</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="button-type"/>
			<xsl:with-param name="content">
				<xsl:call-template name="column-container">
					<xsl:with-param name="content">
						<!-- master column -->
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="appendClass">contentGray</xsl:with-param>
							<xsl:with-param name="content">
								<xsl:call-template name="beneficiaryaddressAmend">
									<xsl:with-param name="path" select="$prev_path"/>
									<xsl:with-param name="org_path" select="$prev_path"/>
									<xsl:with-param name="org_path1" select="$tnx_path"/>
								</xsl:call-template>     
							</xsl:with-param>
						</xsl:call-template>
						<!-- tnx column -->
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="content">
								<xsl:call-template name="beneficiaryaddressAmend">
									<xsl:with-param name="path" select="$tnx_path"/>
									<xsl:with-param name="org_path" select="$prev_path"/>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>  
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- This template displays the LC amount details fieldset of the transaction -->
	<xd:doc>
		<xd:short>Amount Details .</xd:short>
		<xd:detail>
		This template displays the LC amount details fieldset of the transaction
		</xd:detail>
	</xd:doc>
	<xsl:template name="amend-view-amt-details-header">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_AMOUNT_CONFIRMATION_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="column-container">
					<xsl:with-param name="content">  
						<!-- master column -->   
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="appendClass">contentGray</xsl:with-param>
							<xsl:with-param name="content">
								<xsl:call-template name="lc-amt-details-amend">
									<xsl:with-param name="show-standby">
										<xsl:choose>
											<xsl:when test="product_code[.='SR' or .='SI']">N</xsl:when>
											<xsl:otherwise>Y</xsl:otherwise>		
										</xsl:choose>
									</xsl:with-param>
									<xsl:with-param name="show-release-amt">
										<xsl:choose>
											<xsl:when test="product_code[.='SI']">Y</xsl:when>
											<xsl:otherwise>N</xsl:otherwise>		
										</xsl:choose>
									</xsl:with-param>
									<xsl:with-param name="show-revolving">Y</xsl:with-param>
									<xsl:with-param name="show-bank-confirmation">Y</xsl:with-param>
									<xsl:with-param name="path" select="$prev_path"/>
									<xsl:with-param name="org_path" select="$prev_path"/>
									<xsl:with-param name="org_path1" select="$tnx_path"/> 
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						<!-- tnx column -->
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="content">
								<xsl:call-template name="lc-amt-details-amend">
									<xsl:with-param name="show-standby">
										<xsl:choose>
											<xsl:when test="product_code[.='SR' or .='SI']">N</xsl:when>
											<xsl:otherwise>Y</xsl:otherwise>		
										</xsl:choose>
									</xsl:with-param>
									<xsl:with-param name="show-release-amt">
										<xsl:choose>
											<xsl:when test="product_code[.='SI']">Y</xsl:when>
											<xsl:otherwise>N</xsl:otherwise>		
										</xsl:choose>
									</xsl:with-param>
									<xsl:with-param name="show-revolving">Y</xsl:with-param>
									<xsl:with-param name="show-bank-confirmation">Y</xsl:with-param>
									<xsl:with-param name="path" select="$tnx_path"/> 
									<xsl:with-param name="org_path" select="$prev_path"/> 
								</xsl:call-template>     
							</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="product_code[.='SR' or .='EL']">				
							<xsl:call-template name="requested_confirmation_party" />	
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>  
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- This template displays the LC revolving details fieldset of the transaction -->
	<xd:doc>
		<xd:short>Revolving Details.</xd:short>
		<xd:detail>
		This template displays the LC revolving details fieldset of the transaction
		</xd:detail>
	</xd:doc>
	<xsl:template name="amend-view-revolving-details-header">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_REVOLVING_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="column-container">
					<xsl:with-param name="content">
						<!-- master Column -->
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="appendClass">contentGray</xsl:with-param>
							<xsl:with-param name="content">
								<xsl:call-template name="lc-revolving-details-amend">
									<xsl:with-param name="path" select="$prev_path"/>
									<xsl:with-param name="org_path" select="$prev_path"/>
									<xsl:with-param name="org_path1" select="$tnx_path"/>
									<xsl:with-param name="master">Y</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						<!-- tnx Column -->
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="content">
								<xsl:call-template name="lc-revolving-details-amend">
									<xsl:with-param name="path" select="$tnx_path"/>
									<xsl:with-param name="org_path" select="$prev_path"/> 
								</xsl:call-template>     
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>  
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- This template displays the payment details section of the transaction -->
	<xd:doc>
		<xd:short>Payment Details.</xd:short>
		<xd:detail>
		This template displays the payment details section of the transaction.
		</xd:detail>
	</xd:doc>
	<xsl:template name="amend-view-payment-details-header">	
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_PAYMENT_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<!-- Credit Available With -->
				<xsl:call-template name="credit_available_with_bank" />
				<!-- Credit Available By -->
				<xsl:call-template name="credit-available-by-header"/>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>	

	<!-- This template displays the credit-available-by-header fieldset of the transaction -->
	<xsl:template name="credit-available-by-header">
		<xsl:call-template name="column-container">
			<xsl:with-param name="content">
				<!-- master column -->
				<xsl:call-template name="column-wrapper">
					<xsl:with-param name="appendClass">contentGray</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="credit-available-by-amend">
							<xsl:with-param name="path" select="$prev_path"/>
							<xsl:with-param name="org_path" select="$prev_path"/>
							<xsl:with-param name="org_path1" select="$tnx_path"/>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				<!-- tnx column -->
				<xsl:call-template name="column-wrapper">
					<xsl:with-param name="content">
						<xsl:call-template name="credit-available-by-amend">
							<xsl:with-param name="path" select="$tnx_path"/>
							<xsl:with-param name="org_path" select="$prev_path"/>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!-- This template displays the shipment details fieldset of the transaction -->
	<xd:doc>
		<xd:short>Shipment Details.</xd:short>
		<xd:detail>
		This template displays the shipment details fieldset of the transaction
		</xd:detail>
	</xd:doc>
	<xsl:template name="amend-view-shipment-details-header">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_SHIPMENT_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="column-container">
					<xsl:with-param name="content">
						<!-- master Column -->
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="appendClass">contentGray</xsl:with-param>
							<xsl:with-param name="content">
								<xsl:call-template name="lc-shipment-details-amend">
									<xsl:with-param name="path" select="$prev_path"/> 
									<xsl:with-param name="org_path" select="$prev_path"/> 
									<xsl:with-param name="org_path1" select="$tnx_path"/> 
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						<!-- tnx Column -->
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="content">
								<xsl:call-template name="lc-shipment-details-amend">
									<xsl:with-param name="path" select="$tnx_path"/>
									<xsl:with-param name="org_path" select="$prev_path"/> 
								</xsl:call-template>     
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>  
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>	

	<!-- This template displays the bank details of the transaction -->
	<xd:doc>
		<xd:short>Bank Details.</xd:short>
		<xd:detail>
		This template displays the bank details of the transaction
		</xd:detail>
	</xd:doc>
	<xsl:template name="amend-view-bank-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_BANK_DETAILS_LC</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="bank_info">
					<xsl:with-param name="nodeName">advising_bank</xsl:with-param>
					<xsl:with-param name="legend">XSL_BANKDETAILS_TAB_ADVISING_BANK</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="bank_info">
					<xsl:with-param name="nodeName">advise_thru_bank</xsl:with-param>
					<xsl:with-param name="legend">XSL_BANKDETAILS_TAB_ADVISE_THRU_BANK</xsl:with-param>				
				</xsl:call-template>
				<xsl:call-template name="requested_confirmation_party" />
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	
	
	<!-- This template displays the bank details of the transaction -->
	<xd:doc>
		<xd:short>Stand by LC Details</xd:short>
		<xd:detail>
		This template displays the stand by LC details section for SI
		</xd:detail>
	</xd:doc>
	
	<xsl:template name="amend-view-standby-details">	
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_STANDBY_LC_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="column-container">
					<xsl:with-param name="content">
						<!-- master Column -->
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="appendClass">contentGray</xsl:with-param>
							<xsl:with-param name="content">
								<xsl:call-template name="stand-by-details-amend">
									<xsl:with-param name="path" select="$prev_path"/> 
									<xsl:with-param name="org_path" select="$prev_path"/> 
									<xsl:with-param name="org_path1" select="$tnx_path"/> 
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						<!-- tnx Column -->
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="content">
								<xsl:call-template name="stand-by-details-amend">
									<xsl:with-param name="path" select="$tnx_path"/>
									<xsl:with-param name="org_path" select="$prev_path"/> 
								</xsl:call-template>     
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>  
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- This template displays the linked license details section of the transaction -->
	<xd:doc>
		<xd:short>License Details.</xd:short>
		<xd:detail>
		This template displays the linked license details section of the transaction.
		</xd:detail>
	</xd:doc>
	<xsl:template name="amend-view-linked-ls-declaration">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_LINKED_LICENSES</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="column-container">
					<xsl:with-param name="content">
						<!-- master Column -->
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="appendClass">contentGray</xsl:with-param>
							<xsl:with-param name="content">
								<xsl:call-template name="linkedlsdeclaration">
									<xsl:with-param name="path" select="$prev_path"/> 
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						<!-- tnx Column -->
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="content">
								<xsl:call-template name="linkedlsdeclaration">
									<xsl:with-param name="path" select="$tnx_path"/>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>  
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- This template displays the linked license details section of the transaction -->
	<xd:doc>
		<xd:short>License Details.</xd:short>
		<xd:detail>
		This template displays the linked license details section of the transaction.
		</xd:detail>
	</xd:doc>
	<xsl:template name="amend-view-linked-licenses">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_LINKED_LICENSES</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="column-container">
					<xsl:with-param name="content">
						<!-- master Column -->
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="appendClass">contentGray</xsl:with-param>
							<xsl:with-param name="content">
								<xsl:call-template name="linked-licenses-new">
									<xsl:with-param name="path" select="$prev_path"/>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						<!-- tnx Column -->
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="content">
								<xsl:call-template name="linked-licenses-new">
									<xsl:with-param name="path" select="$tnx_path"/>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>  
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>	

	<!-- This template displays the narrative details section of the transaction -->
	<xd:doc>
		<xd:short>Narrative Details.</xd:short>
		<xd:detail>
		This template displays the narrative details section of the transaction.
		</xd:detail>
	</xd:doc>
	<xsl:template name="amend-view-narrative-details">
	<xsl:param name="securityEnabled">N</xsl:param>
	<xsl:call-template name="fieldset-wrapper">
	    <xsl:with-param name="legend">XSL_HEADER_NARRATIVE_DETAILS</xsl:with-param>
	    <xsl:with-param name="button-type">extended-preview-issuance</xsl:with-param>
	    <xsl:with-param name="content">
			<xsl:call-template name="narrative-amend-content">
				<xsl:with-param name="id">narrative_description_goods</xsl:with-param>
				<xsl:with-param name="header">XSL_NARRATIVEDETAILS_TAB_DESCRIPTION_GOODS</xsl:with-param>
				<xsl:with-param name="text" select="common:node-set($tnx_path)/narrative_description_goods" />
				<xsl:with-param name="org-text" select="common:node-set($prev_path)/narrative_description_goods" />				
			</xsl:call-template>
			<xsl:call-template name="narrative-amend-content">
				<xsl:with-param name="id">narrative_documents_required</xsl:with-param>
				<xsl:with-param name="header">XSL_NARRATIVEDETAILS_TAB_DOCUMENTS_REQUIRED</xsl:with-param>
				<xsl:with-param name="text" select="common:node-set($tnx_path)/narrative_documents_required" />
				<xsl:with-param name="org-text" select="common:node-set($prev_path)/narrative_documents_required" />				
			</xsl:call-template>
			<xsl:call-template name="narrative-amend-content">
				<xsl:with-param name="id">narrative_additional_instructions</xsl:with-param>
				<xsl:with-param name="header">XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_INSTRUCTIONS</xsl:with-param>
				<xsl:with-param name="text" select="common:node-set($tnx_path)/narrative_additional_instructions" />
				<xsl:with-param name="org-text" select="common:node-set($prev_path)/narrative_additional_instructions" />				
			</xsl:call-template>
			<xsl:call-template name="narrative-amend-content">
				<xsl:with-param name="id">narrative_special_beneficiary</xsl:with-param>
				<xsl:with-param name="header">XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_BENEF</xsl:with-param>
				<xsl:with-param name="text" select="common:node-set($tnx_path)/narrative_special_beneficiary" />
				<xsl:with-param name="org-text" select="common:node-set($prev_path)/narrative_special_beneficiary" />				
			</xsl:call-template>
			<xsl:if test="$securityEnabled = 'N'">
				<xsl:call-template name="narrative-amend-content">
					<xsl:with-param name="id">narrative_special_recvbank</xsl:with-param>
					<xsl:with-param name="header">XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_RECEIV</xsl:with-param>
					<xsl:with-param name="text" select="common:node-set($tnx_path)/narrative_special_recvbank" />
					<xsl:with-param name="org-text" select="common:node-set($prev_path)/narrative_special_recvbank" />				
				</xsl:call-template>
			</xsl:if>
		</xsl:with-param>
	</xsl:call-template>
	</xsl:template>

	<xsl:template name="amend-view-period-for-presentation">
		<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="content">
		
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_TAB_PERIOD_PRESENTATION_IN_DAYS</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="column-container">
					<xsl:with-param name="content">

						<!-- master Column -->
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="appendClass">contentGray</xsl:with-param>
							<xsl:with-param name="content">
								<xsl:call-template name="amend-input-field">
								    <xsl:with-param name="label">XSL_PERIOD_NO_OF_DAYS</xsl:with-param>    
									<xsl:with-param name="text"><xsl:value-of select="common:node-set($prev_path)/period_presentation_days"/></xsl:with-param>
									<xsl:with-param name="org-text"><xsl:value-of select="common:node-set($prev_path)/period_presentation_days"/></xsl:with-param>
									<xsl:with-param name="tnx-text"><xsl:value-of select="common:node-set($tnx_path)/period_presentation_days"/></xsl:with-param>
									<xsl:with-param name="master">Y</xsl:with-param>
								</xsl:call-template>							
								<xsl:call-template name="amend-input-field">
								    <xsl:with-param name="label">XSL_TAB_PERIOD_DESCRIPTION</xsl:with-param>    
									<xsl:with-param name="text"><xsl:value-of select="common:node-set($prev_path)/narrative_period_presentation/text"/></xsl:with-param>
									<xsl:with-param name="org-text"><xsl:value-of select="common:node-set($prev_path)/narrative_period_presentation/text"/></xsl:with-param>
									<xsl:with-param name="tnx-text"><xsl:value-of select="common:node-set($tnx_path)/narrative_period_presentation/text"/></xsl:with-param>
									<xsl:with-param name="master">Y</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						<!-- tnx Column -->
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="content">
								<xsl:call-template name="amend-input-field">
								    <xsl:with-param name="label">XSL_PERIOD_NO_OF_DAYS</xsl:with-param>    
									<xsl:with-param name="text"><xsl:value-of select="common:node-set($tnx_path)/period_presentation_days"/></xsl:with-param>
									<xsl:with-param name="org-text"><xsl:value-of select="common:node-set($prev_path)/period_presentation_days"/></xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="amend-input-field">
								    <xsl:with-param name="label">XSL_TAB_PERIOD_DESCRIPTION</xsl:with-param>    
									<xsl:with-param name="text"><xsl:value-of select="common:node-set($tnx_path)/narrative_period_presentation/text"/></xsl:with-param>
									<xsl:with-param name="org-text"><xsl:value-of select="common:node-set($prev_path)/narrative_period_presentation/text"/></xsl:with-param>
								</xsl:call-template>								
							</xsl:with-param>
						</xsl:call-template>
						
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		
		</xsl:with-param>
		</xsl:call-template>
	</xsl:template>


	<!-- This template displays the narrative period presentation details section of the transaction -->
	<xd:doc>
		<xd:short>Narrative perid Details.</xd:short>
		<xd:detail>
		This template displays the narrative period presentation details section of the transaction.
		</xd:detail>
	</xd:doc>
	<xsl:template name="amend-view-narrative-period">
		<xsl:param name="in-fieldset">Y</xsl:param>
		<xsl:call-template name="tabgroup-wrapper">
			<xsl:with-param name="in-fieldset">
				<xsl:value-of select="$in-fieldset"/>
			</xsl:with-param>
			<xsl:with-param name="tabgroup-id">narrative-period-tabcontainer</xsl:with-param>

			<!-- Tab 0 - Period Presentation  -->
			<!-- <xsl:with-param name="tab0-label">XSL_NARRATIVEDETAILS_TAB_PERIOD_PRESENTATION</xsl:with-param>
			<xsl:with-param name="tab0-content">
				<xsl:call-template name="narrative-tab-content">
					<xsl:with-param name="text" select="common:node-set($tnx_path)/narrative_period_presentation/text" />
					<xsl:with-param name="org-text" select="common:node-set($prev_path)/narrative_period_presentation/text" />
				</xsl:call-template>
			</xsl:with-param> -->

			<!-- Tab 1 - Shipment Period  -->
			<xsl:with-param name="tab1-label">XSL_NARRATIVEDETAILS_TAB_SHIPMENT_PERIOD</xsl:with-param>
			<xsl:with-param name="tab1-content">
				<xsl:call-template name="narrative-tab-content">
					<xsl:with-param name="text" select="common:node-set($tnx_path)/narrative_shipment_period/text" />
					<xsl:with-param name="org-text" select="common:node-set($prev_path)/narrative_shipment_period/text" />				
				</xsl:call-template> 				
			</xsl:with-param>

			<!-- Tab 2 - Additional Amount  -->
			<xsl:with-param name="tab2-label">XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_AMOUNT</xsl:with-param>
			<xsl:with-param name="tab2-content">
				<xsl:call-template name="narrative-tab-content">
					<xsl:with-param name="text" select="common:node-set($tnx_path)/narrative_additional_amount/text" />
					<xsl:with-param name="org-text" select="common:node-set($prev_path)/narrative_additional_amount/text" />				
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- This template displays the charges/payment instruction/other details section of the transaction -->
	<xd:doc>
		<xd:short>Charges/Payment Details.</xd:short>
		<xd:detail>
		This template displays the charges/payment instruction/other details section of the transaction.
		</xd:detail>
	</xd:doc>
	<xsl:template name="amend-view-narrative-charges">
		<!-- Tabgroup #1 : Narrative Details (3 Tabs) -->
		<xsl:call-template name="tabgroup-wrapper">
			<!-- Tab 0 - Description of Goods  -->
			<xsl:with-param name="tab0-label">XSL_NARRATIVEDETAILS_TAB_CHARGES</xsl:with-param>
			<xsl:with-param name="tab0-content">
				<xsl:call-template name="narrative-tab-content">
					<xsl:with-param name="text" select="common:node-set($tnx_path)/narrative_charges/text" />
					<xsl:with-param name="org-text" select="common:node-set($prev_path)/narrative_charges/text" />				
				</xsl:call-template> 
			</xsl:with-param>

			<!-- Tab 1 - Documents Required  -->
			<xsl:with-param name="tab1-label">XSL_NARRATIVEDETAILS_TAB_SENDER_TO_RECEIVER</xsl:with-param>
			<xsl:with-param name="tab1-content">
				<xsl:call-template name="narrative-tab-content">
					<xsl:with-param name="text" select="common:node-set($tnx_path)/narrative_sender_to_receiver/text" />
					<xsl:with-param name="org-text" select="common:node-set($prev_path)/narrative_sender_to_receiver/text" />				
				</xsl:call-template> 			
			</xsl:with-param>

			<!-- Tab 2 - Additional Instructions  -->
			<xsl:with-param name="tab2-label">XSL_NARRATIVEDETAILS_TAB_PAYMT_INSTRUCTIONS</xsl:with-param>
			<xsl:with-param name="tab2-content">
				<xsl:call-template name="narrative-tab-content">
					<xsl:with-param name="text" select="common:node-set($tnx_path)/narrative_payment_instructions/text" />
					<xsl:with-param name="org-text" select="common:node-set($prev_path)/narrative_payment_instructions/text" />				
				</xsl:call-template> 			
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>	

	<!-- This template displays the bank instruction details fieldset of the transaction -->
	<xd:doc>
		<xd:short>Bank instruction Details.</xd:short>
		<xd:detail>
		This template displays the bank instruction details fieldset of the transaction.
		</xd:detail>
	</xd:doc>
	<xsl:template name="amend-view-bank-instructions-header">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_INSTRUCTIONS</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="column-container">
					<xsl:with-param name="content">
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="content">
								<!-- LC details. -->
								<xsl:call-template name="bank-instructions-amend">
									<xsl:with-param name="path" select="$tnx_path"/> 
								</xsl:call-template>     
							</xsl:with-param>
						</xsl:call-template>
						<!-- second Column -->
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="content">
								<!-- Common general details. -->
								<xsl:call-template name="bank-instructions-amend">
									<xsl:with-param name="path" select="$prev_path"/> 
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>  
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- This template displays the applicant details section of the transaction -->
	<xd:doc>
		<xd:short>Applicant Details.</xd:short>
		<xd:detail>
		This template displays the applicant details section of the transaction.
		</xd:detail>
	</xd:doc>
	<xsl:template name="amend-view-renewal-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_RENEWAL_DETAILS_LABEL</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="column-container">
					<xsl:with-param name="content">	 
						<!-- master column -->
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="appendClass">contentGray</xsl:with-param>
							<xsl:with-param name="content">                         
								<xsl:call-template name="renewaldetails">
									<xsl:with-param name="path" select="$prev_path"/> 
									<xsl:with-param name="org_path" select="$prev_path"/>
									<xsl:with-param name="org_path1" select="$tnx_path"/>
								</xsl:call-template>			      
							</xsl:with-param>
						</xsl:call-template>
						<!-- tnx column -->
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="content">
								<xsl:call-template name="renewaldetails">
									<xsl:with-param name="path" select="$tnx_path"/> 
									<xsl:with-param name="org_path" select="$prev_path"/>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>


</xsl:stylesheet>