<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE xsl:stylesheet [
<!ENTITY nbsp "&#160;">
<!ENTITY amp "&#38;">
]>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:axsl="http://www.w3.org/1999/XSL/TransformAlias"
                xmlns:html="http://www.w3.org/1999/xhtml"
                xmlns:field="xalan://com.misys.portal.report.field.FieldFactory"
                exclude-result-prefixes="field">

	<xsl:output method="xml"
              version="1.0"
              encoding="UTF-8"
              indent="no"/>
	<xsl:namespace-alias stylesheet-prefix="axsl" result-prefix="xsl"/>

	<xsl:template match="html">
		<axsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
        xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
        xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools"
        xmlns:utils="com.misys.portal.common.tools.Utils"
        exclude-result-prefixes="defaultresource localization converttools utils">

			<axsl:param name="productcode"/>
			<axsl:param name="language"/>
			<axsl:param name="up">ABCDEFGHIJKLMNOPQRSTUVWXYZ</axsl:param>
 			<axsl:param name="lo">abcdefghijklmnopqrstuvwxyz</axsl:param>
			<axsl:template match="/">
				<axsl:apply-templates />
			</axsl:template>
			<axsl:template match="//*[name()=concat($productcode, '_tnx_record')]">
				<xsl:apply-templates/>
			</axsl:template>
		</axsl:stylesheet>

	</xsl:template>  

	<xsl:template match="input">
		<xsl:if test="@type = 'button'">
			<xsl:variable name="fieldType">
				<xsl:value-of select="@field-type"/>
			</xsl:variable>
			<axsl:choose>
				<axsl:when>
					<xsl:attribute name="test">
						<xsl:call-template name="translateFieldName">
							<xsl:with-param name="fieldName">
								<xsl:value-of select="@id"/>
							</xsl:with-param>
						</xsl:call-template></xsl:attribute>

					<xsl:choose>
						<xsl:when test="$fieldType = 'ValuesSet'">
							<axsl:value-of>
								<xsl:attribute name="select">
									<xsl:value-of select="@id"/>
								</xsl:attribute>
							</axsl:value-of>
						</xsl:when>
						<xsl:when test="$fieldType = 'Amount'">
							<axsl:variable name="currencyName">
								<axsl:value-of>
									<xsl:attribute name="select">utils:getCurrencyFieldFromAmountFieldString(translate($productcode,$lo,$up), '<xsl:value-of select="@id"/>')</xsl:attribute>
								</axsl:value-of>
							</axsl:variable>
							<axsl:value-of>
								<xsl:attribute name="select">
									<xsl:value-of select="@id"/>
								</xsl:attribute>
							</axsl:value-of>
						</xsl:when>
						<xsl:when test="$fieldType = 'Date'">
							<axsl:value-of>
								<xsl:attribute name="select">converttools:getLocaleTimestampRepresentation(<xsl:value-of select="@id"/>, $language)</xsl:attribute>
							</axsl:value-of>
						</xsl:when>
						<xsl:otherwise>
							<axsl:value-of>
								<xsl:attribute name="select">
									<xsl:call-template name="translateFieldName">
										<xsl:with-param name="fieldName">
											<xsl:value-of select="@id"/>
										</xsl:with-param>
									</xsl:call-template>
								</xsl:attribute>
							</axsl:value-of>
						</xsl:otherwise>
					</xsl:choose>
				</axsl:when>
				<axsl:otherwise>
					<axsl:value-of>
						<xsl:attribute name="select">concat('[',localization:getString($language, 'XSL_REPORT_COL_<xsl:value-of select="@id"/>'),']')</xsl:attribute>
					</axsl:value-of>
				</axsl:otherwise>
			</axsl:choose>
		</xsl:if>

	</xsl:template>
	
	<xsl:template match="br">
		<axsl:text>dynamicallyPhraseNewLine</axsl:text>
	</xsl:template>

	<xsl:template name="translateFieldName">
		<xsl:param name="fieldName"/>

		<xsl:choose>
			<xsl:when test="contains($fieldName, 'IssuingBank@')">issuing_bank/<xsl:value-of select="substring-after($fieldName, 'IssuingBank@')"/>
			</xsl:when>
			<xsl:when test="contains($fieldName, 'AdvisingBank@')">advising_bank/<xsl:value-of select="substring-after($fieldName, 'AdvisingBank@')"/>
			</xsl:when>
			<xsl:when test="contains($fieldName, 'AdviseThruBank@')">advise_thru_bank/<xsl:value-of select="substring-after($fieldName, 'AdviseThruBank@')"/>
			</xsl:when>
			<xsl:when test="contains($fieldName, 'CreditAvailableWithBank@')">credit_available_with_bank/<xsl:value-of select="substring-after($fieldName, 'CreditAvailableWithBank@')"/>
			</xsl:when>
			<xsl:when test="contains($fieldName, 'DraweeDetailsBank@')">drawee_details_bank/<xsl:value-of select="substring-after($fieldName, 'DraweeDetailsBank@')"/>
			</xsl:when>
			<xsl:when test="contains($fieldName, 'RemittingBank@')">remitting_bank/<xsl:value-of select="substring-after($fieldName, 'RemittingBank@')"/>
			</xsl:when>
			<xsl:when test="contains($fieldName, 'CollectingBank@')">collecting_bank/<xsl:value-of select="substring-after($fieldName, 'CollectingBank@')"/>
			</xsl:when>
			<xsl:when test="contains($fieldName, 'PresentingBank@')">presenting_bank/<xsl:value-of select="substring-after($fieldName, 'PresentingBank@')"/>
			</xsl:when>
			<xsl:when test="contains($fieldName, 'RecipientBank@')">recipient_bank/<xsl:value-of select="substring-after($fieldName, 'RecipientBank@')"/>
			</xsl:when>
			<xsl:when test="contains($fieldName, 'ConfirmingBank@')">confirming_bank/<xsl:value-of select="substring-after($fieldName, 'ConfirmingBank@')"/>
			</xsl:when>
			<xsl:when test="contains($fieldName, 'AccountWithBank@')">account_with_bank/<xsl:value-of select="substring-after($fieldName, 'AccountWithBank@')"/>
			</xsl:when>
			<xsl:when test="contains($fieldName, 'PayThroughBank@')">pay_through_bank/<xsl:value-of select="substring-after($fieldName, 'PayThroughBank@')"/>
			</xsl:when>
			<xsl:when test="contains($fieldName, 'CorrespondentBank@')">correspondent_bank/<xsl:value-of select="substring-after($fieldName, 'CorrespondentBank@')"/>
			</xsl:when>
			<xsl:when test="contains($fieldName, 'BuyerBank@')">buyer_bank/<xsl:value-of select="substring-after($fieldName, 'BuyerBank@')"/>
			</xsl:when>
			<xsl:when test="contains($fieldName, 'SellerBank@')">seller_bank/<xsl:value-of select="substring-after($fieldName, 'SellerBank@')"/>
			</xsl:when>
			<xsl:when test="contains($fieldName, 'Narrative@goodsDesc')">narrative_description_goods</xsl:when>
			<xsl:when test="contains($fieldName, 'Narrative@docsRequired')">narrative_documents_required</xsl:when>
			<xsl:when test="contains($fieldName, 'Narrative@additionalInstructions')">narrative_additional_instructions</xsl:when>
			<xsl:when test="contains($fieldName, 'Narrative@chargesDetails')">narrative_charges</xsl:when>
			<xsl:when test="contains($fieldName, 'Narrative@additionalAmount')">narrative_additional_amount</xsl:when>
			<xsl:when test="contains($fieldName, 'Narrative@paymentInstructions')">narrative_payment_instructions</xsl:when>
			<xsl:when test="contains($fieldName, 'Narrative@periodOfPresentation')">narrative_period_presentation</xsl:when>
			<xsl:when test="contains($fieldName, 'Narrative@shipmentPeriod')">narrative_shipment_period</xsl:when>
			<xsl:when test="contains($fieldName, 'Narrative@senderToReceiver')">narrative_sender_to_receiver</xsl:when>
			<xsl:when test="contains($fieldName, 'Narrative@fullDetails')">narrative_full_details</xsl:when>
			<xsl:when test="contains($fieldName, 'Narrative@boComment')">bo_comment</xsl:when>
			<xsl:when test="contains($fieldName, 'Narrative@free_format_text')">free_format_text</xsl:when>
			<xsl:when test="contains($fieldName, 'Narrative@amd_details')">amd_details</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$fieldName"/>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>
</xsl:stylesheet>