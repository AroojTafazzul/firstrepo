<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools"
	exclude-result-prefixes="tools">


<!--
   Copyright (c) 2000-2006 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->

	
	<!-- Buyer Defined Information template-->
	<xsl:template name="BUYER_DEFINED_INFORMATION">
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="refId"/>
		<xsl:param name="tnxId"/>
		<com.misys.portal.openaccount.product.baseline.util.UserInfo>
			<xsl:if test="$refId">
				<xsl:attribute name="ref_id"><xsl:value-of select="$refId"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="$tnxId">
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnxId"/></xsl:attribute>
			</xsl:if>
			<xsl:attribute name="user_info_id"><xsl:value-of select="info_id"/></xsl:attribute>

			<xsl:if test="$brchCode">
				<brch_code><xsl:value-of select="$brchCode"/></brch_code>
			</xsl:if>
			<xsl:if test="$companyId">
				<company_id><xsl:value-of select="$companyId"/></company_id>
			</xsl:if>
			<xsl:element name="type">01</xsl:element>
			<xsl:if test="label">
					<label><xsl:value-of select="label"/></label>
			</xsl:if>
			<xsl:if test="information">
					<information><xsl:value-of select="information"/></information>
			</xsl:if>
			<xsl:if test="is_valid">
					<is_valid><xsl:value-of select="is_valid"/></is_valid>
			</xsl:if>
		</com.misys.portal.openaccount.product.baseline.util.UserInfo>
	</xsl:template>	
	
	<!-- Seller Defined Information template -->
	<xsl:template name="SELLER_DEFINED_INFORMATION">
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="refId"/>
		<xsl:param name="tnxId"/>
			<com.misys.portal.openaccount.product.baseline.util.UserInfo>
				<xsl:if test="$refId">
					<xsl:attribute name="ref_id"><xsl:value-of select="$refId"/></xsl:attribute>
				</xsl:if>
				<xsl:if test="$tnxId">
					<xsl:attribute name="tnx_id"><xsl:value-of select="$tnxId"/></xsl:attribute>
				</xsl:if>
				<xsl:attribute name="user_info_id">
					<xsl:value-of select="info_id"/>
				</xsl:attribute>
				
				<xsl:if test="$brchCode">
					<brch_code><xsl:value-of select="$brchCode"/></brch_code>
				</xsl:if>
				<xsl:if test="$companyId">
					<company_id><xsl:value-of select="$companyId"/></company_id>
				</xsl:if>
				<xsl:element name="type">02</xsl:element>
				<xsl:if test="label">
					<label><xsl:value-of select="label"/></label>
				</xsl:if>
				<xsl:if test="information">
						<information><xsl:value-of select="information"/></information>
				</xsl:if>
				<xsl:if test="is_valid">
					<is_valid><xsl:value-of select="is_valid"/></is_valid>
				</xsl:if>
			</com.misys.portal.openaccount.product.baseline.util.UserInfo>
	</xsl:template>	
	
	<!-- Seller Information -->
	<xsl:template match="seller_defined_informations/seller_defined_information">
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="refId"/>
		<xsl:param name="tnxId"/>
		
		<xsl:call-template name="SELLER_DEFINED_INFORMATION">
			<xsl:with-param name="brchCode" select="$brchCode"/>
			<xsl:with-param name="companyId" select="$companyId"/>
			<xsl:with-param name="refId" select="$refId"/>
			<xsl:with-param name="tnxId" select="$tnxId"/>
		</xsl:call-template>
	</xsl:template>
	
	<!-- Buyer Information -->
	<xsl:template match="buyer_defined_informations/buyer_defined_information">
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="refId"/>
		<xsl:param name="tnxId"/>
		
		<xsl:call-template name="BUYER_DEFINED_INFORMATION">
			<xsl:with-param name="brchCode" select="$brchCode"/>
			<xsl:with-param name="companyId" select="$companyId"/>
			<xsl:with-param name="refId" select="$refId"/>
			<xsl:with-param name="tnxId" select="$tnxId"/>
		</xsl:call-template>
	</xsl:template>
	
	<!-- Contact Information -->
	<xsl:template match="contacts/contact">
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="refId"/>
		<xsl:param name="tnxId"/>
		
		<xsl:call-template name="CONTACT">
			<xsl:with-param name="brchCode" select="$brchCode"/>
			<xsl:with-param name="companyId" select="$companyId"/>
			<xsl:with-param name="refId" select="$refId"/>
			<xsl:with-param name="tnxId" select="$tnxId"/>
		</xsl:call-template>
	</xsl:template>
	
	<!-- Incoterm -->
	<xsl:template match="incoterms/incoterm">
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="refId"/>
		<xsl:param name="tnxId"/>
		<com.misys.portal.openaccount.product.baseline.util.IncoTerm>
			<xsl:if test="$refId">
				<xsl:attribute name="ref_id"><xsl:value-of select="$refId"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="$tnxId">
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnxId"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="inco_term_id">
				<xsl:attribute name="inco_term_id">
					<xsl:value-of select="inco_term_id"/>
				</xsl:attribute>
			</xsl:if>

			<xsl:if test="$brchCode">
				<brch_code><xsl:value-of select="$brchCode"/></brch_code>
			</xsl:if>
			<xsl:if test="$companyId">
				<company_id><xsl:value-of select="$companyId"/></company_id>
			</xsl:if>
			<xsl:if test="code">
				<code>
					<xsl:value-of select="code"/>
				</code>
			</xsl:if>
			<xsl:if test="other">
				<other>
					<xsl:value-of select="other"/>
				</other>
			</xsl:if>						
			<xsl:if test="location">
				<location>
					<xsl:value-of select="location"/>
				</location>
			</xsl:if>
			<xsl:if test="is_valid">
				<is_valid>
					<xsl:value-of select="is_valid"/>
				</is_valid>
			</xsl:if>
		</com.misys.portal.openaccount.product.baseline.util.IncoTerm>
	</xsl:template>
	
	<!-- payments -->
	<xsl:template match="payments/payment">
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="refId"/>
		<xsl:param name="tnxId"/>
		<xsl:param name="payment_terms_type"/>
		
		<xsl:call-template name="PAYMENT">
			<xsl:with-param name="brchCode" select="$brchCode"/>
			<xsl:with-param name="companyId" select="$companyId"/>
			<xsl:with-param name="refId" select="$refId"/>
			<xsl:with-param name="tnxId" select="$tnxId"/>
			<xsl:with-param name="payment_terms_type" select="$payment_terms_type"/>
		</xsl:call-template>
	</xsl:template>
	
	<!-- Adjustment -->
	<xsl:template match="adjustments/adjustment | adjustments/allowance">
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="refId"/>
		<xsl:param name="tnxId"/>
		<xsl:call-template name="ALLOWANCE">
			<xsl:with-param name="brchCode" select="$brchCode"/>
			<xsl:with-param name="companyId" select="$companyId"/>
			<xsl:with-param name="refId" select="$refId"/>
			<xsl:with-param name="tnxId" select="$tnxId"/>
			<xsl:with-param name="allowanceType">02</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!-- Tax -->
	<xsl:template match="taxes/tax | taxes/allowance">
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="refId"/>
		<xsl:param name="tnxId"/>
		<xsl:call-template name="ALLOWANCE">
			<xsl:with-param name="brchCode" select="$brchCode"/>
			<xsl:with-param name="companyId" select="$companyId"/>
			<xsl:with-param name="refId" select="$refId"/>
			<xsl:with-param name="tnxId" select="$tnxId"/>
			<xsl:with-param name="allowanceType">01</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	
	
	<!-- Freight Charge -->
	<xsl:template match="freightCharges/freightCharge | freight_charges/allowance">
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="refId"/>
		<xsl:param name="tnxId"/>
		<xsl:call-template name="ALLOWANCE">
			<xsl:with-param name="brchCode" select="$brchCode"/>
			<xsl:with-param name="companyId" select="$companyId"/>
			<xsl:with-param name="refId" select="$refId"/>
			<xsl:with-param name="tnxId" select="$tnxId"/>
			<xsl:with-param name="allowanceType">03</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!-- Allowance common template -->
	<xsl:template name="ALLOWANCE">
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="refId"/>
		<xsl:param name="tnxId"/>
		<xsl:param name="allowanceType"/>
		
		<com.misys.portal.openaccount.product.baseline.util.Allowance>
			<xsl:if test="$refId">
				<xsl:attribute name="ref_id"><xsl:value-of select="$refId"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="$tnxId">
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnxId"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="id">
				<xsl:attribute name="allowance_id">
					<xsl:value-of select="id"/>
				</xsl:attribute>
			</xsl:if>

			<xsl:if test="$brchCode">
				<brch_code><xsl:value-of select="$brchCode"/></brch_code>
			</xsl:if>
			<xsl:if test="$companyId">
				<company_id><xsl:value-of select="$companyId"/></company_id>
			</xsl:if>
			<allowance_type><xsl:value-of select="$allowanceType"/></allowance_type>
			<xsl:if test="type">
				<type><xsl:value-of select="type"/></type>
			</xsl:if>
			<xsl:if test="other_type">
				<other_type><xsl:value-of select="other_type"/></other_type>
			</xsl:if>						
			<xsl:if test="amt">
				<amt><xsl:value-of select="amt"/></amt>
			</xsl:if>
			<xsl:if test="cur_code">
				<cur_code><xsl:value-of select="cur_code"/></cur_code>
			</xsl:if>
			<xsl:if test="rate">
				<rate><xsl:value-of select="rate"/></rate>
			</xsl:if>
			<xsl:if test="direction">
				<direction><xsl:value-of select="direction"/></direction>
			</xsl:if>
			<xsl:if test="is_valid">
				<is_valid><xsl:value-of select="is_valid"/></is_valid> 
			</xsl:if>
			<xsl:if test="cn_reference_id">
				<cn_reference_id><xsl:value-of select="cn_reference_id"/></cn_reference_id> 
			</xsl:if>
			<xsl:if test="discount_exp_date">
				<discount_exp_date><xsl:value-of select="discount_exp_date"/></discount_exp_date> 
			</xsl:if>
		</com.misys.portal.openaccount.product.baseline.util.Allowance>
	</xsl:template>
	
		<!-- INCOTERM  -->
	<xsl:template name="INCOTERM">
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="refId"/>
		<xsl:param name="tnxId"/>
		
		<com.misys.portal.openaccount.product.baseline.util.IncoTerm>
			<xsl:if test="$refId">
				<xsl:attribute name="ref_id"><xsl:value-of select="$refId"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="$tnxId">
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnxId"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="inco_term_id">
				<xsl:attribute name="inco_term_id">
					<xsl:value-of select="inco_term_id"/>
				</xsl:attribute>
			</xsl:if>

			<xsl:if test="$brchCode">
				<brch_code><xsl:value-of select="$brchCode"/></brch_code>
			</xsl:if>
			<xsl:if test="$companyId">
				<company_id><xsl:value-of select="$companyId"/></company_id>
			</xsl:if>
			<xsl:if test="code">
				<code>
					<xsl:value-of select="code"/>
				</code>
			</xsl:if>
			<xsl:if test="other">
				<other>
					<xsl:value-of select="other"/>
				</other>
			</xsl:if>						
			<xsl:if test="location">
				<location>
					<xsl:value-of select="location"/>
				</location>
			</xsl:if>
			<xsl:if test="is_valid">
				<is_valid>
					<xsl:value-of select="is_valid"/>
				</is_valid>
			</xsl:if>
		</com.misys.portal.openaccount.product.baseline.util.IncoTerm>
	</xsl:template>

	<!-- Contact template -->
	<xsl:template name="CONTACT">
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="refId"/>
		<xsl:param name="tnxId"/>

		<com.misys.portal.openaccount.product.baseline.util.ContactPerson>
				<xsl:if test="$refId">
					<xsl:attribute name="ref_id"><xsl:value-of select="$refId"/></xsl:attribute>
				</xsl:if>
				<xsl:if test="$tnxId">
					<xsl:attribute name="tnx_id"><xsl:value-of select="$tnxId"/></xsl:attribute>
				</xsl:if>
				<xsl:if test="ctcprsn_id">
					<xsl:attribute name="ctcprsn_id">
						<xsl:value-of select="ctcprsn_id"/>
					</xsl:attribute>
				</xsl:if>

				<xsl:if test="$brchCode">
					<brch_code><xsl:value-of select="$brchCode"/></brch_code>
				</xsl:if>
				<xsl:if test="$companyId">
					<company_id><xsl:value-of select="$companyId"/></company_id>
				</xsl:if>
				<xsl:if test="type">
					<type>
						<xsl:value-of select="type"/>
					</type>
				</xsl:if>
				<xsl:if test="bic">
					<bic>
						<xsl:value-of select="bic"/>
					</bic>
				</xsl:if>
				<xsl:if test="name_value">
					<name>
						<xsl:value-of select="name_value"/>
					</name>
				</xsl:if>
				<xsl:if test="name_prefix">
					<name_prefix>
						<xsl:value-of select="name_prefix"/>
					</name_prefix>
				</xsl:if>
				<xsl:if test="given_name">
					<given_name>
						<xsl:value-of select="given_name"/>
					</given_name>
				</xsl:if>
				<xsl:if test="role">
					<role>
						<xsl:value-of select="role"/>
					</role>
				</xsl:if>
				<xsl:if test="phone_number">
					<phone_number>
						<xsl:value-of select="phone_number"/>
					</phone_number>
				</xsl:if>
				<xsl:if test="fax_number">
					<fax_number>
						<xsl:value-of select="fax_number"/>
					</fax_number>
				</xsl:if>
				<xsl:if test="email">
					<email>
						<xsl:value-of select="email"/>
					</email>
				</xsl:if>
				<xsl:if test="is_valid">
					<is_valid>
						<xsl:value-of select="is_valid"/>
					</is_valid>
				</xsl:if>
			</com.misys.portal.openaccount.product.baseline.util.ContactPerson>
	</xsl:template>
				
	<!-- Payment template -->
	<xsl:template name="PAYMENT">
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="refId"/>
		<xsl:param name="tnxId"/>
		<xsl:param name="paymentId"/>

		<com.misys.portal.openaccount.product.baseline.util.PaymentTerm>
				<xsl:if test="$refId">
					<xsl:attribute name="ref_id"><xsl:value-of select="$refId"/></xsl:attribute>
				</xsl:if>
				<xsl:if test="$tnxId">
					<xsl:attribute name="tnx_id"><xsl:value-of select="$tnxId"/></xsl:attribute>
				</xsl:if>				
				<xsl:if test="$paymentId">										
					<xsl:attribute name="payment_id"><xsl:value-of select="$paymentId"/></xsl:attribute>					
				</xsl:if>
				<xsl:if test="$brchCode">
					<brch_code><xsl:value-of select="$brchCode"/></brch_code>
				</xsl:if>
				<xsl:if test="$companyId">
					<company_id><xsl:value-of select="$companyId"/></company_id>
				</xsl:if>
				<xsl:if test="other_paymt_terms">
					<other_paymt_terms>
						<xsl:value-of select="other_paymt_terms"/>
					</other_paymt_terms>
				</xsl:if>
				<xsl:if test="code">
					<code>
						<xsl:value-of select="code"/>
					</code>
				</xsl:if>
				<xsl:if test="nb_days">
					<nb_days>
						<xsl:value-of select="nb_days"/>
					</nb_days>
				</xsl:if>
				<xsl:if test="amt">
					<amt>
						<xsl:value-of select="amt"/>
					</amt>
				</xsl:if>
				<xsl:if test="cur_code">
					<cur_code>
						<xsl:value-of select="cur_code"/>
					</cur_code>
				</xsl:if>
				<xsl:if test="pct">
					<pct>
						<xsl:value-of select="pct"/>
					</pct>
				</xsl:if>

				<!-- payment date -->
				<xsl:choose>
				  	<xsl:when test="paymt_date">
  						<paymt_date>
							<xsl:value-of select="paymt_date"/>
						</paymt_date>
				  	</xsl:when>
				  	<xsl:when test="payment_date">
						<paymt_date>
							<xsl:value-of select="payment_date"/>
						</paymt_date>
					</xsl:when>
				</xsl:choose>

				<xsl:if test="details_created_in_session">
					<created_in_session>
						<xsl:value-of select="details_created_in_session"/>
					</created_in_session>
				</xsl:if>
				<xsl:if test="is_valid">
					<is_valid>
						<xsl:value-of select="is_valid"/>
					</is_valid>
				</xsl:if>
				<xsl:if test="itp_payment_amt">
					<itp_payment_amt>
						<xsl:value-of select="itp_payment_amt"/>
					</itp_payment_amt>
				</xsl:if>
				<xsl:if test="itp_payment_date">
					<itp_payment_date>
						<xsl:value-of select="itp_payment_date"/>
					</itp_payment_date>
				</xsl:if>
				<!--  Not in widget ?? -->
			</com.misys.portal.openaccount.product.baseline.util.PaymentTerm>
	</xsl:template>

	<xsl:template match="transports/transport">
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="refId"/>
		<xsl:param name="tnxId"/>
		<xsl:param name="transport_type"/>
	

			<com.misys.portal.openaccount.product.baseline.util.Transport>
				<xsl:if test="$refId">
					<xsl:attribute name="ref_id"><xsl:value-of select="$refId"/></xsl:attribute>
				</xsl:if>
				<xsl:if test="$tnxId">
					<xsl:attribute name="tnx_id"><xsl:value-of select="$tnxId"/></xsl:attribute>
				</xsl:if>
				<xsl:if test="transport_id != ''">
					<xsl:attribute name="transport_id"><xsl:value-of select="transport_id"/></xsl:attribute>
				</xsl:if>

				<xsl:if test="$brchCode">
					<brch_code><xsl:value-of select="$brchCode"/></brch_code>
				</xsl:if>
				<xsl:if test="$companyId">
					<company_id><xsl:value-of select="$companyId"/></company_id>
				</xsl:if>
				<xsl:if test="$transport_type">
					<transport_type>
						<xsl:value-of select="$transport_type"/>
					</transport_type>
				</xsl:if>
				<xsl:if test="transport_mode">
					<transport_mode>
						<xsl:value-of select="transport_mode"/>
					</transport_mode>
				</xsl:if>
				<xsl:if test="transport_sub_type">
					<transport_sub_type>
						<xsl:value-of select="transport_sub_type"/>
					</transport_sub_type>
				</xsl:if>
				<transport_group>
				<!-- //TODO 
					<xsl:value-of select="$parentTransportPosition"/>
					-->
				</transport_group>
						<!-- AIR mode -->
				<xsl:if test="airport_code">
					<xsl:choose>
						<xsl:when test="transport_sub_type[.='01']">
							<airport_loading_code>
								<xsl:value-of select="airport_code"/>
							</airport_loading_code>
						</xsl:when>
						<xsl:when test="transport_sub_type[.='02']">
							<airport_discharge_code>
								<xsl:value-of select="airport_code"/>
							</airport_discharge_code>
						</xsl:when>
					</xsl:choose>
				</xsl:if>					
				<xsl:if test="town">
					<xsl:choose>
						<xsl:when test="transport_sub_type[.='01']">
							<town_loading>
								<xsl:value-of select="town"/>
							</town_loading>
						</xsl:when>
						<xsl:when test="transport_sub_type[.='02']">
							<town_discharge>
								<xsl:value-of select="town"/>
							</town_discharge>
						</xsl:when>
					</xsl:choose>
				</xsl:if>						
				<xsl:if test="airport_name">
					<xsl:choose>
						<xsl:when test="transport_sub_type[.='01']">
							<airport_loading_name>
								<xsl:value-of select="airport_name"/>
							</airport_loading_name>
						</xsl:when>
						<xsl:when test="transport_sub_type[.='02']">
							<airport_discharge_name>
								<xsl:value-of select="airport_name"/>
							</airport_discharge_name>
						</xsl:when>
					</xsl:choose>
				</xsl:if>
				<!-- Sea mode -->
				<xsl:if test="port_name">
					<xsl:choose>
						<xsl:when test="transport_sub_type[.='01']">
							<port_loading>
								<xsl:value-of select="port_name"/>
							</port_loading>
						</xsl:when>
						<xsl:when test="transport_sub_type[.='02']">
							<port_discharge>
								<xsl:value-of select="port_name"/>
							</port_discharge>
						</xsl:when>
					</xsl:choose>
				</xsl:if>
				<!-- Road, rail , place mode -->
				<xsl:if test="place_name">
					<xsl:choose>
						<xsl:when test="transport_sub_type[.='01']">
							<place_receipt>
								<xsl:value-of select="place_name"/>
							</place_receipt>
						</xsl:when>
						<xsl:when test="transport_sub_type[.='02']">
							<place_delivery>
								<xsl:value-of select="place_name"/>
							</place_delivery>
						</xsl:when>
					</xsl:choose>
				</xsl:if>
				<!-- taking in charge mode -->
				<xsl:if test="taking_in">
					<taking_in_charge>
						<xsl:value-of select="taking_in"/>
					</taking_in_charge>
				</xsl:if>
				<!-- Final destination mode -->
				<xsl:if test="final_place_name">
					<place_final_dest>
						<xsl:value-of select="final_place_name"/>
					</place_final_dest>
				</xsl:if>
				<xsl:if test="is_valid">
					<is_valid>
						<xsl:value-of select="is_valid"/>
					</is_valid>
				</xsl:if>
				
				<!--  TODO  -->
<!-- 				<xsl:if test="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_air_',$parentTransportPosition,'_',$subStructureName,'_airport_details_place_', $position))]"> -->
<!-- 					<xsl:choose> -->
<!-- 						<xsl:when test="$transport_sub_type = '01'"> -->
<!-- 							<place_receipt> -->
<!-- 								<xsl:value-of select="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_air_',$parentTransportPosition,'_',$subStructureName,'_airport_details_place_', $position))]"/> -->
<!-- 							</place_receipt> -->
<!-- 						</xsl:when> -->
<!-- 						<xsl:when test="$transport_sub_type = '02'"> -->
<!-- 							<place_delivery> -->
<!-- 								<xsl:value-of select="//*[starts-with(name(), concat($structureName, '_routing_summary_individual_air_',$parentTransportPosition,'_',$subStructureName,'_airport_details_place_', $position))]"/> -->
<!-- 							</place_delivery> -->
<!-- 						</xsl:when> -->
<!-- 					</xsl:choose> -->
<!-- 				</xsl:if>																										 -->
			</com.misys.portal.openaccount.product.baseline.util.Transport>
	</xsl:template>

	<!-- Rename a node. Used for dynamic structure -->
	<xsl:template name="rename_structured_field">
		<xsl:param name="prefix"/>
		<xsl:element name="{substring-after(name(), concat($prefix, '_'))}">
			<xsl:copy-of select="child::node()"/>
		</xsl:element>
	</xsl:template>
	
	<xsl:template name="rename_field">
		<xsl:param name="new_name"/>
		<xsl:element name="{$new_name}">
			<xsl:copy-of select="child::node()"/>
		</xsl:element>
	</xsl:template>


     <xsl:template name="product-additional-fields"/>
     
     <!-- Bank Payment Obligations -->
	<xsl:template match="bank_payment_obligation/bpo_xml/PmtOblgtn">
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="refId"/>
		<xsl:param name="tnxId"/>
		
		<xsl:call-template name="PmtOblgtn">
			<xsl:with-param name="brchCode" select="$brchCode"/>
			<xsl:with-param name="companyId" select="$companyId"/>
			<xsl:with-param name="refId" select="$refId"/>
			<xsl:with-param name="tnxId" select="$tnxId"/>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="PmtOblgtn">
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>
		<xsl:param name="refId"/>
		<xsl:param name="tnxId"/>
		<com.misys.portal.openaccount.product.baseline.util.BankPaymentObligation>
			<xsl:if test="$refId">
				<xsl:attribute name="ref_id"><xsl:value-of select="$refId"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="$tnxId">
				<xsl:attribute name="tnx_id"><xsl:value-of select="$tnxId"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="bpo_id">
				<xsl:attribute name="bpo_id">
					<xsl:value-of select="bpo_id"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="$brchCode">
				<brch_code><xsl:value-of select="$brchCode"/></brch_code>
			</xsl:if>
			<xsl:if test="$companyId">
				<company_id><xsl:value-of select="$companyId"/></company_id>
			</xsl:if>
			<xsl:if test="OblgrBk/BIC">
				<obligor_bank_bic>
					<xsl:value-of select="OblgrBk/BIC" />
				</obligor_bank_bic>
			</xsl:if>
			<xsl:if test="RcptBk/BIC">
				<recipient_bank_bic>
					<xsl:value-of select="RcptBk/BIC" />
				</recipient_bank_bic>
			</xsl:if>
			<xsl:if test="XpryDt">
				<expiry_date>
					<xsl:value-of select="tools:convertISODate2MTPDate(XpryDt,'en')" />
				</expiry_date>
			</xsl:if>
			<xsl:if test="AplblLaw">
				<applicable_law>
					<xsl:value-of select="AplblLaw" />
				</applicable_law>
			</xsl:if>
			<xsl:if test="SttlmTerms/CdtrAgt/BIC">
				<creditor_agent_bic>
					<xsl:value-of select="SttlmTerms/CdtrAgt/BIC" />
				</creditor_agent_bic>
			</xsl:if>
			<xsl:if test="SttlmTerms/CdtrAgt/NmAndAdr/Nm">
				<creditor_agent_name>
					<xsl:value-of select="SttlmTerms/CdtrAgt/NmAndAdr/Nm" />
				</creditor_agent_name>
			</xsl:if>
			<xsl:variable name="idIban"><xsl:value-of select="SttlmTerms/CdtrAcct/Id/IBAN" /></xsl:variable>
			<xsl:variable name="idBban"><xsl:value-of select="SttlmTerms/CdtrAcct/Id/BBAN" /></xsl:variable>
			<xsl:variable name="idUpic"><xsl:value-of select="SttlmTerms/CdtrAcct/Id/UPIC" /></xsl:variable>
			<xsl:variable name="idProp"><xsl:value-of select="SttlmTerms/CdtrAcct/Id/PrtryAcct/Id" /></xsl:variable>
			<xsl:choose>
				<xsl:when test="$idIban != ''">
					<creditor_account_id>
						<xsl:value-of select="$idIban" />
					</creditor_account_id>
				</xsl:when>
				<xsl:when test="$idBban != ''">
					<creditor_account_id>
						<xsl:value-of select="$idBban" />
					</creditor_account_id>
				</xsl:when>
				<xsl:when test="$idUpic != ''">
					<creditor_account_id>
						<xsl:value-of select="$idUpic" />
					</creditor_account_id>
				</xsl:when>
				<xsl:when test="$idProp != ''">
					<creditor_account_id>
						<xsl:value-of select="$idProp" />
					</creditor_account_id>
				</xsl:when>
			</xsl:choose>
			<xsl:variable name="accountTypeCode"><xsl:value-of select="SttlmTerms/CdtrAcct/Tp/Cd" /></xsl:variable>
			<xsl:variable name="accountTypeProp"><xsl:value-of select="SttlmTerms/CdtrAcct/Tp/Prtry" /></xsl:variable>
			<xsl:choose>
				<xsl:when test="$accountTypeCode != ''">
					<creditor_account_code>
						<xsl:value-of select="$accountTypeCode" />
					</creditor_account_code>
				</xsl:when>
				<xsl:when test="$accountTypeProp !=''">
					<creditor_account_code>
						<xsl:value-of select="$accountTypeProp" />
					</creditor_account_code>
				</xsl:when>
			</xsl:choose>
			<xsl:if test="SttlmTerms/CdtrAcct/Nm">
				<creditor_account_name>
					<xsl:value-of select="SttlmTerms/CdtrAcct/Nm" />
				</creditor_account_name>
			</xsl:if>
			<xsl:if test="SttlmTerms/CdtrAcct/Ccy">
				<creditor_account_currency>
					<xsl:value-of select="SttlmTerms/CdtrAcct/Ccy" />
				</creditor_account_currency>
			</xsl:if>
			<xsl:if test="Amt">
				<bpo_amount>
					<xsl:value-of select="Amt" />
				</bpo_amount>
			</xsl:if>
			<xsl:if test="Pctg">
				<bpo_percent>
					<xsl:value-of select="Pctg" />
				</bpo_percent>
			</xsl:if>
			<bpo_outstanding_amt>
			</bpo_outstanding_amt>
 			<xsl:if test="is_valid">
					<is_valid><xsl:value-of select="is_valid"/></is_valid>
			</xsl:if>
			</com.misys.portal.openaccount.product.baseline.util.BankPaymentObligation>
	</xsl:template>
</xsl:stylesheet>