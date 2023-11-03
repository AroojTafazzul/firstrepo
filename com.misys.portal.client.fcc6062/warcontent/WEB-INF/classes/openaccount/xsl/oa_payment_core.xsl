<?xml version="1.0" encoding="UTF-8" ?>

<!DOCTYPE xsl:stylesheet [
<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:xd="http://www.pnp-software.com/XSLTdoc"
	exclude-result-prefixes="localization defaultresource">

	
	<!-- **************** -->
	<!-- Common Templates -->
	<!-- **************** -->
	<xd:doc>
		<xd:short>Issuer Details Sub-section in a widget</xd:short>
		<xd:detail>
			This templates displays Issuer Details sub-section in a widget.
 		</xd:detail>
 		<xd:param name="fieldPrefix">Holds the prefix for the name field.In this case it is issuer</xd:param>
 		<xd:param name="issuerName">Name of the issuer field used in form submission. <b>Mandatory</b></xd:param>
  		<xd:param name="issuerPropId">Proprietary ID of the issuer field used in form submission.</xd:param>
  		<xd:param name="issuerPropType">Proprietary Type of the issuer field used in form submission.</xd:param>
  		<xd:param name="issuerStreetNm">street name of the issuer postal address.</xd:param>
  		<xd:param name="issuerPostCode">post code of issuer postal address.</xd:param>
  		<xd:param name="issuerTownNm">Town Name of issuer postal address.</xd:param>
  		<xd:param name="issuerCountrySubDiv"> Country Sub Division of issuer postal address.</xd:param>
  		<xd:param name="issuerCountry">Country Code of Issuer. <b>Mandatory</b></xd:param>
 	</xd:doc>
	<xsl:template name="issuer-details-widget">
		<xsl:param name="fieldPrefix"/>
		<xsl:param name="issuerName"/>
		<xsl:param name="issuerPropId"/>
		<xsl:param name="issuerPropType"/>
		<xsl:param name="issuerStreetNm"/>
		<xsl:param name="issuerPostCode"/>
		<xsl:param name="issuerTownNm"/>
		<xsl:param name="issuerCountrySubDiv"/>
		<xsl:param name="issuerCountry"/>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_ISSUER_DETAILS</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="toc-item">N</xsl:with-param>
			<xsl:with-param name="content">
					<xsl:choose>
						<xsl:when test="$displaymode = 'edit'">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_ISSUER_NAME</xsl:with-param>
								<xsl:with-param name="name"><xsl:value-of select="$fieldPrefix"/>_name</xsl:with-param>
								<xsl:with-param name="required">Y</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_DETAILS_PO_PROPRIETARY_IDENTIFICATION</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="toc-item">N</xsl:with-param>
							<xsl:with-param name="content">
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_PROPRIETARY_ID</xsl:with-param>
									<xsl:with-param name="name"><xsl:value-of select="$fieldPrefix"/>_prpty_id</xsl:with-param>
									<xsl:with-param name="size">35</xsl:with-param>
									<xsl:with-param name="maxsize">35</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_PROPRIETARY_TYPE</xsl:with-param>
									<xsl:with-param name="name"><xsl:value-of select="$fieldPrefix"/>_prpty_id_type</xsl:with-param>
									<xsl:with-param name="size">35</xsl:with-param>
									<xsl:with-param name="maxsize">35</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_PO_PARTIESDETAILS_POSTAL_ADDRESS</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="toc-item">N</xsl:with-param>
							<xsl:with-param name="content">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_STREET</xsl:with-param>
								<xsl:with-param name="name"><xsl:value-of select="$fieldPrefix"/>_addr_street_nm</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_POST_CODE</xsl:with-param>
								<xsl:with-param name="name"><xsl:value-of select="$fieldPrefix"/>_addr_code</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_TOWN</xsl:with-param>
								<xsl:with-param name="name"><xsl:value-of select="$fieldPrefix"/>_addr_town</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION</xsl:with-param>
								<xsl:with-param name="name"><xsl:value-of select="$fieldPrefix"/>_addr_ctry_sub_div</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_COUNTRY</xsl:with-param>
								<xsl:with-param name="name"><xsl:value-of select="$fieldPrefix"/>_addr_ctry</xsl:with-param>
								<xsl:with-param name="required">Y</xsl:with-param>
							</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:when>
						<xsl:when test="$displaymode='view'">
						 <xsl:if test="$issuerName !=''">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_ISSUER_NAME</xsl:with-param>
								<xsl:with-param name="name"><xsl:value-of select="$fieldPrefix"/>_issuer_name</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select ="$issuerName"/></xsl:with-param>
								<xsl:with-param name="override-displaymode">edit</xsl:with-param>
								<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
							<xsl:call-template name="fieldset-wrapper">
								<xsl:with-param name="legend">XSL_DETAILS_PO_PROPRIETARY_IDENTIFICATION</xsl:with-param>
								<xsl:with-param name="legend-type">indented-header</xsl:with-param>
								<xsl:with-param name="toc-item">N</xsl:with-param>
								<xsl:with-param name="content">
									<xsl:if test= "$issuerPropId !=''">
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_PROPRIETARY_ID</xsl:with-param>
											<xsl:with-param name="name"><xsl:value-of select="$fieldPrefix"/>_prpty_id</xsl:with-param>
											<xsl:with-param name="value"><xsl:value-of select ="$issuerPropId"/></xsl:with-param>
											<xsl:with-param name="override-displaymode">edit</xsl:with-param>
											<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										</xsl:call-template>
									</xsl:if>
									<xsl:if test= "$issuerPropType !=''">
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_PROPRIETARY_TYPE</xsl:with-param>
											<xsl:with-param name="name"><xsl:value-of select="$fieldPrefix"/>_prpty_id_type</xsl:with-param>
											<xsl:with-param name="value"><xsl:value-of select ="$issuerPropType"/></xsl:with-param>
											<xsl:with-param name="override-displaymode">edit</xsl:with-param>
											<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										</xsl:call-template>
									</xsl:if>
								</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="fieldset-wrapper">
								<xsl:with-param name="legend">XSL_PO_PARTIESDETAILS_POSTAL_ADDRESS</xsl:with-param>
								<xsl:with-param name="legend-type">indented-header</xsl:with-param>
								<xsl:with-param name="toc-item">N</xsl:with-param>
								<xsl:with-param name="content">
									<xsl:if test= "$issuerStreetNm !=''">
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_STREET</xsl:with-param>
											<xsl:with-param name="name"><xsl:value-of select="$fieldPrefix"/>_addr_street_nm</xsl:with-param>
											<xsl:with-param name="value"><xsl:value-of select ="$issuerStreetNm"/></xsl:with-param>
											<xsl:with-param name="override-displaymode">edit</xsl:with-param>
											<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										</xsl:call-template>
									</xsl:if>
									<xsl:if test= "$issuerPostCode !=''">
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_POST_CODE</xsl:with-param>
											<xsl:with-param name="name"><xsl:value-of select="$fieldPrefix"/>_addr_code</xsl:with-param>
											<xsl:with-param name="value"><xsl:value-of select ="$issuerPostCode"/></xsl:with-param>
											<xsl:with-param name="override-displaymode">edit</xsl:with-param>
											<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										</xsl:call-template>
									</xsl:if>
									<xsl:if test= "$issuerTownNm !=''">
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_TOWN</xsl:with-param>
											<xsl:with-param name="name"><xsl:value-of select="$fieldPrefix"/>_addr_town</xsl:with-param>
											<xsl:with-param name="value"><xsl:value-of select ="$issuerTownNm"/></xsl:with-param>
											<xsl:with-param name="override-displaymode">edit</xsl:with-param>
											<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										</xsl:call-template>
									</xsl:if>
									<xsl:if test= "$issuerCountrySubDiv !=''">
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION</xsl:with-param>
											<xsl:with-param name="name"><xsl:value-of select="$fieldPrefix"/>_addr_ctry_sub_div</xsl:with-param>
											<xsl:with-param name="value"><xsl:value-of select ="$issuerCountrySubDiv"/></xsl:with-param>
											<xsl:with-param name="override-displaymode">edit</xsl:with-param>
											<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										</xsl:call-template>
									</xsl:if>
									<xsl:if test= "$issuerCountry!=''">
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_COUNTRY</xsl:with-param>
											<xsl:with-param name="name"><xsl:value-of select="$fieldPrefix"/>_addr_ctry</xsl:with-param>
											<xsl:with-param name="value"><xsl:value-of select ="$issuerCountry"/></xsl:with-param>
											<xsl:with-param name="override-displaymode">edit</xsl:with-param>
											<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										</xsl:call-template>
									</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise></xsl:otherwise>
				</xsl:choose>
				&nbsp;
			 </xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Dataset Identification Sub-section</xd:short>
		<xd:detail>
			This templates displays dataset identification sub-section.
 		</xd:detail>
 		<xd:param name="fieldPrefix">Provides the prefix for the dynamic value, the identifier of the dataset, eg: transport or insurance etc.</xd:param>
 		<xd:param name="dataSetId">Provides the value of dataset Id.</xd:param>
 		<xd:param name="dataSetVersion">Provides the value of dataset version.</xd:param>
 		<xd:param name="dataSetSubmitterBic">Provides the value of dataset submitter BIC.</xd:param>
 	</xd:doc>
	<xsl:template name="dataset-identification">
		<xsl:param name="fieldPrefix"/>
		<xsl:param name="dataSetId"/>
		<xsl:param name="dataSetVersion"/>
		<xsl:param name="dataSetSubmitterBic"/>
		<xsl:param name="isWidget">N</xsl:param>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_DATA_SET_IDENTIFICATION</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="toc-item">N</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:choose>
					<xsl:when test="$isWidget='Y'">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DATA_SET_ID</xsl:with-param>
							<xsl:with-param name="name"><xsl:value-of select="$fieldPrefix"/>_dataset_id</xsl:with-param>
		            		<xsl:with-param name="value" select="$dataSetId"/>
		           			<xsl:with-param name="override-displaymode">edit</xsl:with-param>
		           			<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DATA_SET_VERSION</xsl:with-param>
							<xsl:with-param name="name"><xsl:value-of select="$fieldPrefix"/>_dataset_version</xsl:with-param>
		            		<xsl:with-param name="value" select="$dataSetVersion"/>
		            		<xsl:with-param name="override-displaymode">edit</xsl:with-param>
		            		<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DETAILS_SUBMITTER_BIC</xsl:with-param>
							<xsl:with-param name="name"><xsl:value-of select="$fieldPrefix"/>_submitter_bic</xsl:with-param>
		            		<xsl:with-param name="value" select="$dataSetSubmitterBic"/>
		            		<xsl:with-param name="override-displaymode">edit</xsl:with-param>
		            		<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DATA_SET_ID</xsl:with-param>
							<xsl:with-param name="name"><xsl:value-of select="$fieldPrefix"/>_dataset_id</xsl:with-param>
		            		<xsl:with-param name="value" select="$dataSetId"/>
						</xsl:call-template>
						
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DATA_SET_VERSION</xsl:with-param>
							<xsl:with-param name="name"><xsl:value-of select="$fieldPrefix"/>_dataset_version</xsl:with-param>
		            		<xsl:with-param name="value" select="$dataSetVersion"/>
						</xsl:call-template>
						
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DETAILS_SUBMITTER_BIC</xsl:with-param>
							<xsl:with-param name="name"><xsl:value-of select="$fieldPrefix"/>_submitter_bic</xsl:with-param>
		            		<xsl:with-param name="value" select="$dataSetSubmitterBic"/>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!-- **************** -->
	<!-- Common Templates -->
	<!-- **************** -->
	
	<!-- *********************************** -->
	<!-- Payment Transport Dataset Templates -->
	<!-- *********************************** -->
				
	<xd:doc>
		<xd:short>Payment Transport Dataset dialog</xd:short>
		<xd:detail>
			This templates displays freight Payment Transport Dataset sub-section.
 		</xd:detail>
 	</xd:doc>
	<xsl:template name="payment-transport-dataset">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_TRANSPORT_DATASET</xsl:with-param>
			<xsl:with-param name="content">
				
				<xsl:call-template name="dataset-identification">
					<xsl:with-param name="fieldPrefix">payment_transport</xsl:with-param>
					<xsl:with-param name="dataSetId"><xsl:value-of select="payment_transport_dataset/TrnsprtDataSet/DataSetId/Id"/></xsl:with-param>
					<xsl:with-param name="dataSetVersion"><xsl:value-of select="payment_transport_dataset/TrnsprtDataSet/DataSetId/Vrsn"/></xsl:with-param>
					<xsl:with-param name="dataSetSubmitterBic"><xsl:value-of select="payment_transport_dataset/TrnsprtDataSet/DataSetId/Submitr/BIC"/></xsl:with-param>
				</xsl:call-template>

				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_DATA_TRANSPORT_INFORMATION</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="toc-item">N</xsl:with-param>
					<xsl:with-param name="content">

					    <xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_HEADER_TRANSPORT_DOC_REFERENCE</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="toc-item">N</xsl:with-param>
							<xsl:with-param name="content">
								&nbsp;
								<xsl:call-template name="build-transport-document-ref-dojo-items">
									<xsl:with-param name="items" select="payment_transport_dataset/TrnsprtDataSet/TrnsprtInf/TrnsprtDocRef" />
									<xsl:with-param name="id" select="payment_tds_dataset_transport_doc_ref" />
							</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_HEADER_TRANSPORTED_GOODS</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="toc-item">N</xsl:with-param>
							<xsl:with-param name="content">
								&nbsp;
								<xsl:call-template name="build-transported-goods-dojo-items">
									<xsl:with-param name="items" select="payment_transport_dataset/TrnsprtDataSet/TrnsprtInf/TrnsprtdGoods" />
									<xsl:with-param name="id" select="payment_tds_dataset_transported_goods" />
							</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_HEADER_CONSIGNMENT_DETAILS</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="toc-item">N</xsl:with-param>
							<xsl:with-param name="content">
								<!-- Quantity Details -->								
								<xsl:call-template name="consignment-details">
									<xsl:with-param name="legend">XSL_HEADER_CONSIGNMENT_QTY</xsl:with-param>
									<xsl:with-param name="prefix">pmt_tds_qty</xsl:with-param>
									<xsl:with-param name="codeLabel">XSL_DETAILS_LINE_ITEMS_QUANTITY_CODE</xsl:with-param>
									<xsl:with-param name="otherLabel">XSL_DETAILS_LINE_ITEMS_QUANTITY_OTHER</xsl:with-param>
									<xsl:with-param name="unitOfMeasureCode"><xsl:value-of select="payment_transport_dataset/TrnsprtDataSet/TrnsprtInf/Consgnmt/TtlQty/UnitOfMeasrCd"/></xsl:with-param>
									<xsl:with-param name="otherUnitOfMeasure"><xsl:value-of select="payment_transport_dataset/TrnsprtDataSet/TrnsprtInf/Consgnmt/TtlQty/OthrUnitOfMeasr"/></xsl:with-param>
									<xsl:with-param name="value"><xsl:value-of select="payment_transport_dataset/TrnsprtDataSet/TrnsprtInf/Consgnmt/TtlQty/Val"/></xsl:with-param>
								</xsl:call-template>
								<!-- Volume Details -->
								<xsl:call-template name="consignment-details">
									<xsl:with-param name="legend">XSL_HEADER_CONSIGNMENT_VOL</xsl:with-param>
									<xsl:with-param name="prefix">pmt_tds_vol</xsl:with-param>
									<xsl:with-param name="codeLabel">XSL_DETAILS_CONSIGNMENT_VOL_CODE</xsl:with-param>
									<xsl:with-param name="otherLabel">XSL_DETAILS_LINE_ITEMS_QUANTITY_OTHER</xsl:with-param>
									<xsl:with-param name="unitOfMeasureCode"><xsl:value-of select="payment_transport_dataset/TrnsprtDataSet/TrnsprtInf/Consgnmt/TtlVol/UnitOfMeasrCd"/></xsl:with-param>
									<xsl:with-param name="otherUnitOfMeasure"><xsl:value-of select="payment_transport_dataset/TrnsprtDataSet/TrnsprtInf/Consgnmt/TtlVol/OthrUnitOfMeasr"/></xsl:with-param>
									<xsl:with-param name="value"><xsl:value-of select="payment_transport_dataset/TrnsprtDataSet/TrnsprtInf/Consgnmt/TtlVol/Val"/></xsl:with-param>
								</xsl:call-template>
								<!-- Weight Details -->
								<xsl:call-template name="consignment-details">
									<xsl:with-param name="legend">XSL_HEADER_CONSIGNMENT_WEIGHT</xsl:with-param>
									<xsl:with-param name="prefix">pmt_tds_wgt</xsl:with-param>
									<xsl:with-param name="codeLabel">XSL_DETAILS_CONSIGNMENT_WGT_CODE</xsl:with-param>
									<xsl:with-param name="otherLabel">XSL_DETAILS_LINE_ITEMS_QUANTITY_OTHER</xsl:with-param>
									<xsl:with-param name="unitOfMeasureCode"><xsl:value-of select="payment_transport_dataset/TrnsprtDataSet/TrnsprtInf/Consgnmt/TtlWght/UnitOfMeasrCd"/></xsl:with-param>
									<xsl:with-param name="otherUnitOfMeasure"><xsl:value-of select="payment_transport_dataset/TrnsprtDataSet/TrnsprtInf/Consgnmt/TtlWght/OthrUnitOfMeasr"/></xsl:with-param>
									<xsl:with-param name="value"><xsl:value-of select="payment_transport_dataset/TrnsprtDataSet/TrnsprtInf/Consgnmt/TtlWght/Val"/></xsl:with-param>
								</xsl:call-template>	
							</xsl:with-param>
						</xsl:call-template>

						<!--Proposed Ship Date -->
					 	<xsl:call-template name="date-details">
					 		<xsl:with-param name="label">XSL_PROPOSED_SHIP_DATE</xsl:with-param>
					 		<xsl:with-param name="fieldPrefix">payment_tds_prop</xsl:with-param>
					 		<xsl:with-param name="date"><xsl:value-of select="payment_transport_dataset/TrnsprtDataSet/TrnsprtInf/PropsdShipmntDt"/></xsl:with-param>
					 	</xsl:call-template>
					 	
					 	<!--Actual Ship Date -->
					 	<xsl:call-template name="date-details">
					 		<xsl:with-param name="label">XSL_ACTUAL_SHIP_DATE</xsl:with-param>
					 		<xsl:with-param name="fieldPrefix">payment_tds_actual</xsl:with-param>
					 		<xsl:with-param name="date"><xsl:value-of select="payment_transport_dataset/TrnsprtDataSet/TrnsprtInf/ActlShipmntDt"/></xsl:with-param>
					 	</xsl:call-template>

						<!-- Incoterms -->
						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_HEADER_INCO_TERMS_DETAILS</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="toc-item">N</xsl:with-param>
							<xsl:with-param name="content">
								<xsl:choose>
									<xsl:when test="$displaymode = 'edit'">
										<xsl:call-template name="hidden-field">
											<xsl:with-param name="name">payment_tds_incoterm_code_label</xsl:with-param>							
											<xsl:with-param name="value">
												<xsl:choose>
													<xsl:when test="payment_tds_incoterm_code"><xsl:value-of select="localization:getDecode($language, 'N212', incoterm_code)" /></xsl:when>
													<xsl:otherwise></xsl:otherwise>
												</xsl:choose>
											</xsl:with-param>							
										</xsl:call-template>
										<xsl:call-template name="select-field">
											<xsl:with-param name="label">XSL_DETAILS_PO_INCO_TERMS_CODE</xsl:with-param>
											<xsl:with-param name="name">payment_tds_incoterm_code</xsl:with-param>
											<xsl:with-param name="required">Y</xsl:with-param>
											<xsl:with-param name="options">
												<xsl:call-template name="incoterm-codes" >
													<xsl:with-param name="field-name">payment_tds_incoterm_code</xsl:with-param>
												</xsl:call-template>
											</xsl:with-param>
										</xsl:call-template>
									</xsl:when>
									<xsl:otherwise>
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_DETAILS_PO_INCO_TERMS_CODE</xsl:with-param>
											<xsl:with-param name="name">payment_tds_incoterm_code_label</xsl:with-param>
											<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N212', payment_transport_dataset/TrnsprtDataSet/TrnsprtInf/Incotrms/Cd)"/></xsl:with-param>
											<xsl:with-param name="swift-validate">N</xsl:with-param>
											<xsl:with-param name="size">35</xsl:with-param>
											<xsl:with-param name="maxsize">35</xsl:with-param>
											<xsl:with-param name="readonly">Y</xsl:with-param>
											<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
										</xsl:call-template>
									</xsl:otherwise>
								</xsl:choose>
								
								<!-- Incoterm other code -->
								<xsl:call-template name="input-field">
									<xsl:with-param name="label"></xsl:with-param>
									<xsl:with-param name="name">payment_tds_incoterm_other</xsl:with-param>
									<xsl:with-param name="value"><xsl:value-of select="payment_transport_dataset/TrnsprtDataSet/TrnsprtInf/Incotrms/Othr"/></xsl:with-param>
									<xsl:with-param name="swift-validate">N</xsl:with-param>
									<xsl:with-param name="size">35</xsl:with-param>
									<xsl:with-param name="maxsize">35</xsl:with-param>
									<xsl:with-param name="readonly">Y</xsl:with-param>
									<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
								</xsl:call-template>
								<!-- Incoterm location -->
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_INCO_TERMS_LOCATION</xsl:with-param>
									<xsl:with-param name="name">payment_tds_incoterm_location</xsl:with-param>
									<xsl:with-param name="value"><xsl:value-of select="payment_transport_dataset/TrnsprtDataSet/TrnsprtInf/Incotrms/Lctn"/></xsl:with-param>
									<xsl:with-param name="swift-validate">N</xsl:with-param>
									<xsl:with-param name="size">35</xsl:with-param>
									<xsl:with-param name="maxsize">35</xsl:with-param>
									<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						
						<!-- Freight Charges -->
						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_HEADER_FREIGHT_CHARGES_DETAILS</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="content">
								<!-- Price unit measure code -->
								<xsl:call-template name="select-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_FREIGHT_CHARGES_TYPE</xsl:with-param>
									<xsl:with-param name="name">payment_tds_freight_charges_type</xsl:with-param>
									<xsl:with-param name="value"><xsl:value-of select="payment_transport_dataset/TrnsprtDataSet/TrnsprtInf/FrghtChrgs/Tp" /></xsl:with-param>
									<xsl:with-param name="options">
									 <xsl:choose>
				      						<xsl:when test="$displaymode='edit'">
				       						<option value="">&nbsp;</option>
											<option value="CLCT">
												<xsl:value-of
													select="localization:getDecode($language, 'N211', 'CLCT')" />
												<xsl:if test="payment_tds_freight_charges_type[. = 'CLCT']">
													<xsl:attribute name="selected" />
												</xsl:if>
											</option>
											<option value="PRPD">
												<xsl:value-of
													select="localization:getDecode($language, 'N211', 'PRPD')" />
												<xsl:if test="payment_tds_freight_charges_type[. = 'PRPD']">
													<xsl:attribute name="selected" />
												</xsl:if>
											</option>
										</xsl:when>
								        <xsl:otherwise>
									        <xsl:choose>
										        <xsl:when test="payment_tds_freight_charges_type[. = 'CLCT']"><xsl:value-of select="localization:getDecode($language, 'N211', 'CLCT')" /></xsl:when>
										        <xsl:when test="payment_tds_freight_charges_type[. = 'PRPD']"><xsl:value-of select="localization:getDecode($language, 'N211', 'PRPD')" /></xsl:when>
									        </xsl:choose>
								        </xsl:otherwise>
								       </xsl:choose>
									</xsl:with-param>
								</xsl:call-template>
								&nbsp;
								<xsl:call-template name="build-payment-tds-freight-charges-dojo-items">
									<xsl:with-param name="items"
										select="payment_transport_dataset/TrnsprtDataSet/TrnsprtInf/FrghtChrgs/Chrgs" />
									<xsl:with-param name="id">payment_tds_freight_charges</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="payment-routing-summary"/>
									
					  </xsl:with-param>
				</xsl:call-template>
				
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Payment Transport Freight Charge dialog</xd:short>
		<xd:detail>
			This templates displays freight charges type,amount,rate label and its properties such as size etc,also adds cancel and ok button in the dialog box.
 		</xd:detail>
 	</xd:doc>
	<xsl:template name="payment-transport-freight-charge-dialog-declaration">
		<div id="payment-transport-freight-charge-dialog-template" style="display:none"
			class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
					<div>
						<!-- Tax Code -->
						<xsl:choose>
							<xsl:when test="$displaymode='edit'">
								<xsl:call-template name="select-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_FREIGHT_CHARGES_TYPE</xsl:with-param>
									<xsl:with-param name="name">payment_transport_freight_charge_type</xsl:with-param>
									<xsl:with-param name="required">Y</xsl:with-param>
									<xsl:with-param name="options">
										<xsl:call-template name="freight-charge-codes" >
											<xsl:with-param name="field-name">payment_transport_freight_charge_type</xsl:with-param>
										</xsl:call-template>
									</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="hidden-field">
									<xsl:with-param name="name">payment_transport_freight_charge_type_label</xsl:with-param>							
									<xsl:with-param name="value">										
									<xsl:choose>
										<xsl:when test="payment_transport_freight_charge_type[.='OTHR']"><xsl:value-of select="payment_transport_freight_charge_other_type" /></xsl:when>
										<xsl:otherwise><xsl:value-of select="localization:getDecode($language, 'N210', freight_charge_type)" /></xsl:otherwise>
								</xsl:choose>
									</xsl:with-param>							
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_FREIGHT_CHARGES_TYPE</xsl:with-param>
									<xsl:with-param name="name">payment_transport_freight_charge_type_label</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
						
						<!-- Tax other type -->
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DETAILS_PO_FREIGHT_CHARGES_TYPE</xsl:with-param>
							<xsl:with-param name="name">payment_transport_freight_charge_other_type</xsl:with-param>
							<xsl:with-param name="value" select="payment_transport_dataset/TrnsprtDataSet/TrnsprtInf/FrghtChrgs/Chrgs/OthrChrgsTp"/>
							<xsl:with-param name="swift-validate">N</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="readonly">Y</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>
						<!-- Amount -->
						<xsl:choose>
							<xsl:when test="$displaymode='edit'">
								<xsl:call-template name="currency-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_FREIGHT_CHARGES_AMT</xsl:with-param>
									<xsl:with-param name="override-currency-name">payment_transport_freight_charge_cur_code</xsl:with-param>
									<xsl:with-param name="override-amt-name">payment_transport_freight_charge_amt</xsl:with-param>
									<xsl:with-param name="override-product-code">payment_transport_freight_charge</xsl:with-param>
									<xsl:with-param name="required">Y</xsl:with-param>
									<xsl:with-param name="currency-readonly">Y</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="show-button">N</xsl:with-param>
									<xsl:with-param name="regular-expression">^(?:\d{1,18}|(?=.*\.)(?!.*\..*\.)[\d.]{1,19})$</xsl:with-param>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="currency-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_FREIGHT_CHARGES_AMT</xsl:with-param>
									<xsl:with-param name="override-currency-name">payment_transport_freight_charge_cur_code</xsl:with-param>
									<xsl:with-param name="override-amt-name">payment_transport_freight_charge_amt</xsl:with-param>
									<xsl:with-param name="value" select="payment_transport_dataset/TrnsprtDataSet/TrnsprtInf/FrghtChrgs/Chrgs/Amt"/>
									<xsl:with-param name="show-button">N</xsl:with-param>
									<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									<xsl:with-param name="currency-readonly">Y</xsl:with-param>
									<xsl:with-param name="override-currency-displaymode">edit</xsl:with-param>
									<xsl:with-param name="amt-readonly">Y</xsl:with-param>
									<xsl:with-param name="override-amt-displaymode">edit</xsl:with-param>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
						<div class="dijitDialogPaneActionBar">
						<xsl:call-template name="label-wrapper">
							<xsl:with-param name="content">
								<button type="button" dojoType="dijit.form.Button">
									<xsl:attribute name="onmouseup">dijit.byId('payment-transport-freight-charge-dialog-template').hide();</xsl:attribute>
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
								</button>							
								<xsl:if test="$displaymode = 'edit'">
									<button dojoType="dijit.form.Button">
										<xsl:attribute name="onClick">dijit.byId('payment-transport-freight-charge-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
									</button>
								</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
						</div>
					</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Payment Transport Freight Charge declaration</xd:short>
		<xd:detail>
			This templates displays message of no freight charges and add button of add freight charges.
 		</xd:detail>
 	</xd:doc>
	<xsl:template name="payment-transport-freight-charges-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="payment-transport-freight-charge-dialog-declaration" />
		<!-- Dialog End -->
		<div id="payment-transport-freight-charges-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_DETAILS_PO_NO_FREIGHT_CHARGES')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_FREIGHT_CHARGES')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Build Payment Transport Freight Charge</xd:short>
		<xd:detail>
			This templates displays header for the payment transport freight charge in case of add edit and view mode,displayes header for the grid and adds different attributes to the freight charges.
 		</xd:detail>
 		<xd:param name="items"> Items to be build to form display </xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">Overridden display mode.Shows in edit mode of the parent form</xd:param>
 	</xd:doc>
	<xsl:template name="build-payment-tds-freight-charges-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
		
		<div dojoType="misys.openaccount.widget.PaymentTransportFreightCharges" dialogId="payment-transport-freight-charge-dialog-template">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_FREIGHT_CHARGES')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_EDIT_FREIGHT_CHARGES')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_VIEW_FREIGHT_CHARGES')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_FREIGHT_CHARGES_TYPE')" />,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_FREIGHT_CHARGES_CUR_CODE')" />,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_FREIGHT_CHARGES_AMOUNT_OR_RATE')" />
			</xsl:attribute>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
			 <xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="freightCharge" select="." />
					<div dojoType="misys.openaccount.widget.PaymentTransportFreightCharge">
						<xsl:attribute name="type"><xsl:value-of
							select="$freightCharge/Tp" /></xsl:attribute>
						<xsl:attribute name="type_label">
							<xsl:value-of select="localization:getDecode($language, 'N210', $freightCharge/Tp)" />
							</xsl:attribute>
						<xsl:attribute name="other_type"><xsl:value-of
							select="$freightCharge/OthrChrgsTp" /></xsl:attribute>
							<xsl:attribute name="type_hidden">
							<xsl:choose>
								<xsl:when test="$freightCharge[.='OTHR']"><xsl:value-of select="$freightCharge/OthrChrgsTp" /></xsl:when>
								<xsl:otherwise><xsl:value-of select="localization:getDecode($language, 'N210', $freightCharge/Tp)" /></xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
						<xsl:attribute name="cur_code"><xsl:value-of
							select="$freightCharge/Amt/@Ccy" /></xsl:attribute>
						<xsl:attribute name="amt"><xsl:value-of select="tools:convertTSUAmount2MTPAmount($freightCharge/Amt)" />
							</xsl:attribute>						
					</div>
				</xsl:for-each>
			</xsl:if>
		</div>
	</xsl:template>

	<xd:doc>
		<xd:short>Consignment Details</xd:short>
		<xd:detail>
			This templates displays the consignment details for different types, eg: quantity, volume etc.
 		</xd:detail>
 		<xd:param name="legend"> The legend header name to be displayed.</xd:param>
 		<xd:param name="prefix">The value which is the unique identifier, prefixed to the field name to make it unique.</xd:param>
 		<xd:param name="codeLabel">The code label value to be displayed in UI.</xd:param>
 		<xd:param name="otherLabel">The other label value to be displayed in UI.</xd:param>
 		<xd:param name="unitOfMeasureCode">The unit of measure code value to be displayed in UI.</xd:param>
 		<xd:param name="otherUnitOfMeasure">The other unit of measure value to be displayed in UI.</xd:param>
 	</xd:doc>
	<xsl:template name="consignment-details">
		<xsl:param name="legend"/>
		<xsl:param name="prefix"/>
		<xsl:param name="codeLabel"/>
		<xsl:param name="otherLabel"/>
		<xsl:param name="unitOfMeasureCode"/>
		<xsl:param name="otherUnitOfMeasure"/>
		<xsl:param name="value"/>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend"><xsl:value-of select="$legend"/></xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="toc-item">N</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:choose>					
					<xsl:when test="$displaymode = 'edit'">
						<xsl:call-template name="select-field">
							<xsl:with-param name="label"><xsl:value-of select="$codeLabel"/></xsl:with-param>
							<xsl:with-param name="name"><xsl:value-of select="$prefix"/>_unit_measr_code</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="required">Y</xsl:with-param>
							<xsl:with-param name="options">
								<xsl:call-template name="quantity-unit-measure-codes">
									<xsl:with-param name="field-name"><xsl:value-of select="$prefix"/>_unit_measr_code</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name"><xsl:value-of select="$prefix"/>_unit_measr_label</xsl:with-param>							
							<xsl:with-param name="value">
								<xsl:choose>
									<xsl:when test="$unitOfMeasureCode!=''"><xsl:value-of select="localization:getDecode($language, 'N202', $unitOfMeasureCode)" /></xsl:when>
									<xsl:otherwise></xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>							
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label"><xsl:value-of select="$codeLabel"/></xsl:with-param>
							<xsl:with-param name="name"><xsl:value-of select="$prefix"/>_unit_measr_label</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N202', $unitOfMeasureCode)" /></xsl:with-param>
							<xsl:with-param name="swift-validate">N</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
				
				<!-- unit measure: Other -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label"><xsl:value-of select="$otherLabel"/></xsl:with-param>
					<xsl:with-param name="name"><xsl:value-of select="$prefix"/>_unit_measr_other</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="$otherUnitOfMeasure" /></xsl:with-param>
					<xsl:with-param name="size">35</xsl:with-param>
					<xsl:with-param name="maxsize">35</xsl:with-param>
					<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
				</xsl:call-template>
				
				<!-- value -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_QUANTITY_VALUE</xsl:with-param>
					<xsl:with-param name="name"><xsl:value-of select="$prefix"/>_val</xsl:with-param>
					<xsl:with-param name="value" select="$value"/>
					<xsl:with-param name="swift-validate">N</xsl:with-param>
					<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
					<xsl:with-param name="regular-expression">^(?:\d{1,18}|(?=.*\.)(?!.*\..*\.)[\d.]{1,19})$</xsl:with-param>
					<xsl:with-param name="fieldsize">small</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<!-- ***************************************** -->
	<!-- END : Payment Transport Dataset Templates -->
	<!-- ***************************************** -->
	

	<!-- *********************************** -->
	<!-- Payment Insurance Dataset Templates -->
	<!-- *********************************** -->
	<xd:doc>
		<xd:short>Issuer Details Sub-section</xd:short>
		<xd:detail>
			This templates displays Issuer Details sub-section.
 		</xd:detail>
 		<xd:param name="fieldPrefix">Holds the prefix for the name field.In this case it is issuer</xd:param>
 		<xd:param name="issuerName">Name of the issuer field used in form submission. <b>Mandatory</b></xd:param>
  		<xd:param name="issuerPropId">Proprietary ID of the issuer field used in form submission.</xd:param>
  		<xd:param name="issuerPropType">Proprietary Type of the issuer field used in form submission.</xd:param>
  		<xd:param name="issuerStreetNm">street name of the issuer postal address.</xd:param>
  		<xd:param name="issuerPostCode">post code of issuer postal address.</xd:param>
  		<xd:param name="issuerTownNm">Town Name of issuer postal address.</xd:param>
  		<xd:param name="issuerCountrySubDiv"> Country Sub Division of issuer postal address.</xd:param>
  		<xd:param name="issuerCountry">Country Code of Issuer. <b>Mandatory</b></xd:param>
 	</xd:doc>
	<xsl:template name="issuer-details">
		<xsl:param name="fieldPrefix"/>
		<xsl:param name="issuerName"/>
		<xsl:param name="issuerPropId"/>
		<xsl:param name="issuerPropType"/>
		<xsl:param name="issuerStreetNm"/>
		<xsl:param name="issuerPostCode"/>
		<xsl:param name="issuerTownNm"/>
		<xsl:param name="issuerCountrySubDiv"/>
		<xsl:param name="issuerCountry"/>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_ISSUER_DETAILS</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="toc-item">N</xsl:with-param>
			<xsl:with-param name="content">
					<xsl:choose>
						<xsl:when test="$displaymode = 'edit'">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_ISSUER_NAME</xsl:with-param>
								<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_name</xsl:with-param>
								<xsl:with-param name="required">Y</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_DETAILS_PO_PROPRIETARY_IDENTIFICATION</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="toc-item">N</xsl:with-param>
							<xsl:with-param name="content">
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_PROPRIETARY_ID</xsl:with-param>
									<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_proprietary_id</xsl:with-param>
									<xsl:with-param name="size">35</xsl:with-param>
									<xsl:with-param name="maxsize">35</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_PROPRIETARY_TYPE</xsl:with-param>
									<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_proprietary_type</xsl:with-param>
									<xsl:with-param name="size">35</xsl:with-param>
									<xsl:with-param name="maxsize">35</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_PO_PARTIESDETAILS_POSTAL_ADDRESS</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="toc-item">N</xsl:with-param>
							<xsl:with-param name="content">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_STREET</xsl:with-param>
								<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_street_name</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_POST_CODE</xsl:with-param>
								<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_postcode</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_TOWN</xsl:with-param>
								<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_town_name</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION</xsl:with-param>
								<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_country_subdivision</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_COUNTRY</xsl:with-param>
								<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_country</xsl:with-param>
								<xsl:with-param name="required">Y</xsl:with-param>
							</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:when>
						<xsl:when test="$displaymode='view'">
						 <xsl:if test="$issuerName !=''">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_ISSUER_NAME</xsl:with-param>
								<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_name</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select ="$issuerName"/></xsl:with-param>
							</xsl:call-template>
						</xsl:if>
							<xsl:call-template name="fieldset-wrapper">
								<xsl:with-param name="legend">XSL_DETAILS_PO_PROPRIETARY_IDENTIFICATION</xsl:with-param>
								<xsl:with-param name="legend-type">indented-header</xsl:with-param>
								<xsl:with-param name="toc-item">N</xsl:with-param>
								<xsl:with-param name="content">
									<xsl:if test= "$issuerPropId !=''">
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_PROPRIETARY_ID</xsl:with-param>
											<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_proprietary_id</xsl:with-param>
											<xsl:with-param name="value"><xsl:value-of select ="$issuerPropId"/></xsl:with-param>
										</xsl:call-template>
									</xsl:if>
									<xsl:if test= "$issuerPropType !=''">
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_PROPRIETARY_TYPE</xsl:with-param>
											<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_>proprietary_type</xsl:with-param>
											<xsl:with-param name="value"><xsl:value-of select ="$issuerPropType"/></xsl:with-param>
										</xsl:call-template>
									</xsl:if>
								</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="fieldset-wrapper">
								<xsl:with-param name="legend">XSL_PO_PARTIESDETAILS_POSTAL_ADDRESS</xsl:with-param>
								<xsl:with-param name="legend-type">indented-header</xsl:with-param>
								<xsl:with-param name="toc-item">N</xsl:with-param>
								<xsl:with-param name="content">
									<xsl:if test= "$issuerStreetNm !=''">
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_STREET</xsl:with-param>
											<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_street_name</xsl:with-param>
											<xsl:with-param name="value"><xsl:value-of select ="$issuerStreetNm"/></xsl:with-param>
										</xsl:call-template>
									</xsl:if>
									<xsl:if test= "$issuerPostCode !=''">
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_POST_CODE</xsl:with-param>
											<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_postcode</xsl:with-param>
											<xsl:with-param name="value"><xsl:value-of select ="$issuerPostCode"/></xsl:with-param>
										</xsl:call-template>
									</xsl:if>
									<xsl:if test= "$issuerTownNm !=''">
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_TOWN</xsl:with-param>
											<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_town_name</xsl:with-param>
											<xsl:with-param name="value"><xsl:value-of select ="$issuerTownNm"/></xsl:with-param>
										</xsl:call-template>
									</xsl:if>
									<xsl:if test= "$issuerCountrySubDiv !=''">
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION</xsl:with-param>
											<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_country_subdivision</xsl:with-param>
											<xsl:with-param name="value"><xsl:value-of select ="$issuerCountrySubDiv"/></xsl:with-param>
										</xsl:call-template>
									</xsl:if>
									<xsl:if test= "$issuerCountry!=''">
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_COUNTRY</xsl:with-param>
											<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_country</xsl:with-param>
											<xsl:with-param name="value"><xsl:value-of select ="$issuerCountry"/></xsl:with-param>
										</xsl:call-template>
									</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise></xsl:otherwise>
				</xsl:choose>
			 </xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Date details</xd:short>
		<xd:detail>
			This templates displays date details
 		</xd:detail>
 		<xd:param name="date">Issue Date and effective of the document which is of ISODate type.Issue date is <b>Mandatory</b></xd:param>
 		<xd:param name="fieldPrefix">Holds the prefix for the name field.In this case it is issue or effective</xd:param>
 		<xd:param name="label">Holds the label for the date field</xd:param>
 	</xd:doc>
 	<xsl:template name="date-details">
 	<xsl:param name="date"/>
 	<xsl:param name ="fieldPrefix"/>
 	<xsl:param name ="label"/>
 		<xsl:if test= "$date !=''">
 			<xsl:choose>
 	 			<xsl:when test="$displaymode='edit'">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label"><xsl:value-of select="$label"/></xsl:with-param>
						<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_date</xsl:with-param>
						<xsl:with-param name="type">date</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="$displaymode='view'">
					 <xsl:call-template name="input-field">
					 	<xsl:with-param name="label"><xsl:value-of select="$label"/></xsl:with-param>
						<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_date</xsl:with-param>
						<xsl:with-param name="type">date</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="tools:convertISODate2MTPDate($date,'en')" /></xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
		</xsl:if>
 	</xsl:template>

 	<xd:doc>
		<xd:short>Place of Issue</xd:short>
		<xd:detail>
			This templates displays place as to where insurance certificate was issued
 		</xd:detail>
 		<xd:param name="poiStreetNm">street name of the place where insurance certificate was issued.</xd:param>
  		<xd:param name="poiPostCode">post code of the place where insurance certificate was issued.</xd:param>
  		<xd:param name="poiTownNm">Town Name of the place where insurance certificate was issued.</xd:param>
  		<xd:param name="poiCtrySubDiv"> Country Sub Divisionthe place where insurance certificate was issued.</xd:param>
  		<xd:param name="poiCtry">Country Code of the place where insurance certificate was issued. <b>Mandatory</b></xd:param>
 	</xd:doc>
 	<xsl:template name="place-of-issue">
 		<xsl:param name="fieldPrefix"/>
		<xsl:param name="poiStreetNm"/>
		<xsl:param name="poiPostCode"/>
		<xsl:param name="poiTownNm"/>
		<xsl:param name="poiCtrySubDiv"/>
		<xsl:param name="poiCtry"/>
 			<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_PLACE_OF_ISSUE</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
					<xsl:choose>
						 <xsl:when test="$displaymode='edit'"> 
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_STREET</xsl:with-param>
								<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_street_name</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_POST_CODE</xsl:with-param>
								<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_postcode</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_TOWN</xsl:with-param>
								<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_town_name</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION</xsl:with-param>
								<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_country_subdivision</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_COUNTRY</xsl:with-param>
								<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_country</xsl:with-param>
								<xsl:with-param name="required">Y</xsl:with-param>
							</xsl:call-template>
						 </xsl:when>
						<xsl:when test="$displaymode='view'">
							<xsl:if test= "$poiStreetNm !=''">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_STREET</xsl:with-param>
								<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_street_name</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select ="$poiStreetNm"/></xsl:with-param>
							</xsl:call-template>
							</xsl:if>
							<xsl:if test= "$poiPostCode !=''">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_POST_CODE</xsl:with-param>
								<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_postcode</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select ="$poiPostCode"/></xsl:with-param>
							</xsl:call-template>
							</xsl:if>
							<xsl:if test= "$poiTownNm !=''">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_TOWN</xsl:with-param>
								<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_town_name</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select ="$poiTownNm"/></xsl:with-param>
							</xsl:call-template>
							</xsl:if>
							<xsl:if test= "$poiCtrySubDiv !=''">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION</xsl:with-param>
								<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_country_subdivision</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select ="$poiCtrySubDiv"/></xsl:with-param>
							</xsl:call-template>
							</xsl:if>
							<xsl:if test= "$poiCtry !=''">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_COUNTRY</xsl:with-param>
								<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_country</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select ="$poiCtry"/></xsl:with-param>
							</xsl:call-template>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise></xsl:otherwise>
						</xsl:choose>
			 		</xsl:with-param>
			 </xsl:call-template>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Insurance Doc Id</xd:short>
		<xd:detail>
			This templates displays Insurance Doc Id
 		</xd:detail>
 		<xd:param name="insuranceDocId">Insurance Document Id holds unique identifier of the document. <b>Mandatory</b></xd:param>
 	</xd:doc>
 	<xsl:template name="insurance-doc-id">
 		<xsl:param name="insuranceDocId"/>
 		<xsl:choose>
 			<xsl:when test="$displaymode='edit'">
					<xsl:if test= "$insuranceDocId !=''">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_INSURANCE_DOC_ID</xsl:with-param>
								<xsl:with-param name="name">insurance_doc_id</xsl:with-param>
							</xsl:call-template>
					</xsl:if>
				</xsl:when>
				<xsl:when test="$displaymode='view'">
					<xsl:if test= "$insuranceDocId !=''">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_INSURANCE_DOC_ID</xsl:with-param>
								<xsl:with-param name="name">insurance_doc_id</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select ="$insuranceDocId"/></xsl:with-param>
							</xsl:call-template>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise></xsl:otherwise>
				</xsl:choose>
 	</xsl:template>
 	
 	<xd:doc>
		<xd:short>Insurance Amount</xd:short>
		<xd:detail>
			This templates displays Insurance Amount
 		</xd:detail>
 		<xd:param name="insuranceAmt">Insurance Amount holds Value of the goods as insured under the insurance policy. <b>Mandatory</b></xd:param>
 	</xd:doc>
 	<xsl:template name="insurance-amt">
 		<xsl:param name="insuranceAmt"/>
 		<xsl:choose>
 			<xsl:when test="$displaymode='edit'">
				<xsl:if test= "$insuranceAmt !=''">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_INSURED_AMOUNT</xsl:with-param>
							<xsl:with-param name="name">insured_amt</xsl:with-param>
						</xsl:call-template>
				</xsl:if>
			</xsl:when>
			<xsl:when test="$displaymode='view'">
				<xsl:if test= "$insuranceAmt !=''">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_INSURED_AMOUNT</xsl:with-param>
							<xsl:with-param name="name">insured_amt</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select ="$insuranceAmt"/></xsl:with-param>
						</xsl:call-template>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise></xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Insurance Goods Desc</xd:short>
		<xd:detail>
			This templates displays Insurance Goods Desc
 		</xd:detail>
 		<xd:param name="insuranceGoodsDesc">Insurance Goods Description holds information about the goods and/or services of a trade transaction.</xd:param>
 	</xd:doc>
	<xsl:template name="insurance-goods-desc">
 		<xsl:param name="insuranceGoodsDesc"/>
 		<xsl:choose>
			<xsl:when test="$displaymode='edit'">
					<xsl:if test= "$insuranceGoodsDesc !=''">
							<xsl:call-template name="textarea-field">
								<xsl:with-param name="label">XSL_INSURANCE_GOODS_DESC</xsl:with-param>
								<xsl:with-param name="name">insured_goods_desc</xsl:with-param>
								<xsl:with-param name="maxlines">2</xsl:with-param>
								<xsl:with-param name="cols">35</xsl:with-param>
								<xsl:with-param name="rows">5</xsl:with-param>
								<xsl:with-param name="maxlength">69</xsl:with-param>
							</xsl:call-template>
					</xsl:if>
			</xsl:when>
			<xsl:when test="$displaymode='view'">
					<xsl:if test= "$insuranceGoodsDesc !=''">
							<xsl:call-template name="big-textarea-wrapper">
								<xsl:with-param name="label">XSL_INSURANCE_GOODS_DESC</xsl:with-param>
								<xsl:with-param name="name">insured_goods_desc</xsl:with-param>
								<xsl:with-param name="content"><div class="content">
						        <xsl:value-of select="$insuranceGoodsDesc"/>
						      </div></xsl:with-param>
							</xsl:call-template>
					</xsl:if>
			</xsl:when>
			<xsl:otherwise></xsl:otherwise>
		</xsl:choose>
	</xsl:template>
		
	<xd:doc>
		<xd:short>Insurance Assuer Details</xd:short>
		<xd:detail>
			This templates displays Insurance Assuer Details
 		</xd:detail>
 		<xd:param name="insuranceAssuerBic"> Assuer Bank Identifier Code. <b>Mandatory</b></xd:param>
 		<xd:param name="insuranceAssuerNmAddr">Identifies the name and address of assuer, <b>Mandatory</b></xd:param>
 		<xd:param name="insuranceAssuerNm">Name by which a party is known and which is usually used to identify that party.</xd:param>
  		<xd:param name="insuranceAssuerPropId">Unique and unambiguous identifier assigned to a party using a proprietary identification scheme..</xd:param>
  		<xd:param name="insuranceAssuerPropType">Proprietary Type of the issuer field used in form submission.</xd:param>
  		<xd:param name="insuranceAssuerStreetNm">street name of the assuer postal address.</xd:param>
  		<xd:param name="insuranceAssuerPostCode">Identifier consisting of a group of letters and/or numbers that is added to a postal address to assist the sorting of mail.</xd:param>
  		<xd:param name="insuranceAssuerTownNm">Town Name of assuer postal address.</xd:param>
  		<xd:param name="insuranceAssuerCtrySubDivision"> Identifies a subdivision of a country of assuer postal address.</xd:param>
  		<xd:param name="insuranceAssuerCtry">Country Code of assuer. <b>Mandatory</b></xd:param>
 	</xd:doc>		
				
	<xsl:template name="insurance-assurance-details">
		<xsl:param name="fieldPrefix"/>
		<xsl:param name="insuranceAssuerBic"/>
		<xsl:param name="insuranceAssuerNmAddr"/>
		<xsl:param name="insuranceAssuerNm"/>
		<xsl:param name="insuranceAssuerPropId"/>
		<xsl:param name="insuranceAssuerPropType"/>
		<xsl:param name="insuranceAssuerStreetNm"/>
		<xsl:param name="insuranceAssuerPostCode"/>
		<xsl:param name="insuranceAssuerTownNm"/>
		<xsl:param name="insuranceAssuerCtrySubDivision"/>
		<xsl:param name="insuranceAssuerCtry"/>			
			<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_ASSURANCE_DETAILS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
					<xsl:choose>
						<xsl:when test="$displaymode = 'edit'">
				     			<xsl:call-template name="multioption-group">
				     				<xsl:with-param name="label">XSL_HEADER_ASSURANCE_DETAILS</xsl:with-param>
						      		<xsl:with-param name="content">
							      	<xsl:call-template name="radio-field">
								         <xsl:with-param name="label">XSL_ASSUER_BIC</xsl:with-param>
								         <xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_bic</xsl:with-param>
								         <xsl:with-param name="id">assurer_bic</xsl:with-param>
								         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
								         <xsl:with-param name="value">01</xsl:with-param>
								         <xsl:with-param name="readonly">N</xsl:with-param>
								         <xsl:with-param name="checked">
								         	<xsl:choose>
								         		<xsl:when test="assuer_fin_inst_bic[.!='']">Y</xsl:when>
								         		<xsl:otherwise>N</xsl:otherwise>
								         	</xsl:choose>
										 </xsl:with-param>
							        </xsl:call-template>
							        <div id="insurance_assuer_bic" style="display:none">
								        <xsl:call-template name="input-field">
									         <xsl:with-param name="label">XSL_PURCHASE_ORDER_SUBMITTER_BIC</xsl:with-param>
									         <xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_fin_inst_bic</xsl:with-param>
									         <xsl:with-param name="id">assuer_fin_inst_bic</xsl:with-param>
									         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
									         <xsl:with-param name="type">text</xsl:with-param>
									         <xsl:with-param name="size">11</xsl:with-param>
									         <xsl:with-param name="maxsize">11</xsl:with-param>
									         <xsl:with-param name="fieldsize">small</xsl:with-param>
									         <xsl:with-param name="required">Y</xsl:with-param>
									         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								        </xsl:call-template>
							        </div>
							        <xsl:call-template name="radio-field">
								         <xsl:with-param name="label">XSL_LABEL_NAME_AND_ADDRESS</xsl:with-param>
								         <xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_name_address</xsl:with-param>
								         <xsl:with-param name="id">assuer_name_address</xsl:with-param>
								         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
								         <xsl:with-param name="value">02</xsl:with-param>
								         <xsl:with-param name="readonly">N</xsl:with-param>
								         <xsl:with-param name="checked">
								         	<xsl:choose>
								         		<xsl:when test="assuer_fin_inst_name[.!='']">Y</xsl:when>
								         		<xsl:otherwise>N</xsl:otherwise>
								         	</xsl:choose>
										 </xsl:with-param>
							        </xsl:call-template>
							        <div id="insurance_assurer_name" style="display:none">
								        <xsl:call-template name="input-field">
									         <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_NAME</xsl:with-param>
									         <xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_fin_inst_name</xsl:with-param>
									         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
									         <xsl:with-param name="type">text</xsl:with-param>
									         <xsl:with-param name="maxsize">70</xsl:with-param>
									         <xsl:with-param name="required">Y</xsl:with-param>
									         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									         <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
								        </xsl:call-template>
								        <xsl:call-template name="fieldset-wrapper">
											<xsl:with-param name="legend">XSL_DETAILS_PO_PROPRIETARY_IDENTIFICATION</xsl:with-param>
											<xsl:with-param name="legend-type">indented-header</xsl:with-param>
											<xsl:with-param name="toc-item">N</xsl:with-param>
											<xsl:with-param name="content">
												<xsl:call-template name="input-field">
									         		<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_PROPRIETARY_ID</xsl:with-param>
									        	 	<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_fin_inst_prop_id</xsl:with-param>
									         		<xsl:with-param name="type">text</xsl:with-param>
								        		</xsl:call-template>
								        		<xsl:call-template name="input-field">
									        		 <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_PROPRIETARY_TYPE</xsl:with-param>
									        		 <xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_fin_inst_prop_type</xsl:with-param>
									        		 <xsl:with-param name="name">assuer_fin_prop_type</xsl:with-param>
									       			 <xsl:with-param name="type">text</xsl:with-param>
								        		</xsl:call-template>
								        	</xsl:with-param>
										</xsl:call-template>
										<xsl:call-template name="fieldset-wrapper">
											<xsl:with-param name="legend">XSL_PO_PARTIESDETAILS_POSTAL_ADDRESS</xsl:with-param>
											<xsl:with-param name="legend-type">indented-header</xsl:with-param>
											<xsl:with-param name="toc-item">N</xsl:with-param>
											<xsl:with-param name="content">
								         		<xsl:call-template name="input-field">
									        		<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_STREET</xsl:with-param>
									         		<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_fin_inst_street_name</xsl:with-param>
									         		<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									         		<xsl:with-param name="type">text</xsl:with-param>
									         		<xsl:with-param name="maxsize">70</xsl:with-param>
									        		<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									        		<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
								        		</xsl:call-template>
								        		<xsl:call-template name="input-field">
									         		<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_POST_CODE</xsl:with-param>
									         		<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_fin_inst_post_code</xsl:with-param>
									         		<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									         		<xsl:with-param name="type">text</xsl:with-param>
									         		<xsl:with-param name="required">Y</xsl:with-param>
									         		<xsl:with-param name="maxsize">16</xsl:with-param>
									         		<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								       		 	</xsl:call-template>
								        		<xsl:call-template name="input-field">
									         		<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_TOWN</xsl:with-param>
									        	 	<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_fin_inst_town_name</xsl:with-param>
									         		<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									         		<xsl:with-param name="type">text</xsl:with-param>
									         		<xsl:with-param name="required">Y</xsl:with-param>
									         		<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									         		<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
								        		</xsl:call-template>
								        		<xsl:call-template name="input-field">
									         		<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION</xsl:with-param>
									         		<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_fin_inst_country_sub_div</xsl:with-param>
									         		<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									         		<xsl:with-param name="type">text</xsl:with-param>
									         		<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								        		</xsl:call-template>
								        		<xsl:call-template name="country-field">
								          			<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_fin_inst_country</xsl:with-param>
													<xsl:with-param name="prefix">assuer_fin_inst</xsl:with-param>
													<xsl:with-param name="override-displaymode">edit</xsl:with-param>
													<xsl:with-param name="required">Y</xsl:with-param>
													<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
												</xsl:call-template>
											</xsl:with-param>
										</xsl:call-template>
										</div>
									</xsl:with-param>
					        		</xsl:call-template>
					        		</xsl:when>
									<xsl:when test="$displaymode = 'view'">
					        			<xsl:call-template name="input-field">
									         <xsl:with-param name="label">XSL_PURCHASE_ORDER_SUBMITTER_BIC</xsl:with-param>
									         <xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_fin_inst_bic</xsl:with-param>
									         <xsl:with-param name="type">text</xsl:with-param>
									         <xsl:with-param name="required">Y</xsl:with-param>
									         <xsl:with-param name="value"><xsl:value-of select ="$insuranceAssuerBic"/></xsl:with-param>
									         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								        </xsl:call-template>
								        <xsl:call-template name="input-field">
									         <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_NAME</xsl:with-param>
									         <xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_fin_inst_name</xsl:with-param>
									         <xsl:with-param name="type">text</xsl:with-param>
									         <xsl:with-param name="value"><xsl:value-of select ="$insuranceAssuerNm"/></xsl:with-param>
									         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								        </xsl:call-template>
								        <xsl:call-template name="fieldset-wrapper">
											<xsl:with-param name="legend">XSL_DETAILS_PO_PROPRIETARY_IDENTIFICATION</xsl:with-param>
											<xsl:with-param name="legend-type">indented-header</xsl:with-param>
											<xsl:with-param name="toc-item">N</xsl:with-param>
											<xsl:with-param name="content">
								        		<xsl:call-template name="input-field">
									         		<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_PROPRIETARY_ID</xsl:with-param>
									         		<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_fin_inst_prop_id</xsl:with-param>
									         		<xsl:with-param name="type">text</xsl:with-param>
									         		<xsl:with-param name="value"><xsl:value-of select ="$insuranceAssuerPropId"/></xsl:with-param>
									         		<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								        		</xsl:call-template>
								        		<xsl:call-template name="input-field">
									         		<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_PROPRIETARY_TYPE</xsl:with-param>
									         		<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_fin_fin_prop_type</xsl:with-param>
									         		<xsl:with-param name="name">assuer_fin_prop_type</xsl:with-param>
									         		<xsl:with-param name="type">text</xsl:with-param>
									         		<xsl:with-param name="value"><xsl:value-of select ="$insuranceAssuerPropType"/></xsl:with-param>
									         		<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								        		</xsl:call-template>
								        	</xsl:with-param>
								        </xsl:call-template>
								        <xsl:call-template name="fieldset-wrapper">
											<xsl:with-param name="legend">XSL_PO_PARTIESDETAILS_POSTAL_ADDRESS</xsl:with-param>
											<xsl:with-param name="legend-type">indented-header</xsl:with-param>
											<xsl:with-param name="toc-item">N</xsl:with-param>
											<xsl:with-param name="content">
								         		<xsl:call-template name="input-field">
									         		<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_STREET</xsl:with-param>
									         		<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_fin_inst_street_name</xsl:with-param>
									         		<xsl:with-param name="type">text</xsl:with-param>
									         		<xsl:with-param name="value"><xsl:value-of select ="$insuranceAssuerStreetNm"/></xsl:with-param>
									         		<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									         		<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
								        		</xsl:call-template>
								        		<xsl:call-template name="input-field">
									         		<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_POST_CODE</xsl:with-param>
									         		<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_fin_inst_post_code</xsl:with-param>
									         		<xsl:with-param name="type">text</xsl:with-param>
									         		<xsl:with-param name="value"><xsl:value-of select ="$insuranceAssuerPostCode"/></xsl:with-param>
									         		<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								        		</xsl:call-template>
								        		<xsl:call-template name="input-field">
									         		<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_TOWN</xsl:with-param>
									         		<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_fin_inst_town_name</xsl:with-param>
									         		<xsl:with-param name="type">text</xsl:with-param>		
									         		<xsl:with-param name="value"><xsl:value-of select ="$insuranceAssuerTownNm"/></xsl:with-param>							       
									         		<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								        		</xsl:call-template>
								        		<xsl:call-template name="input-field">
									        		<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION</xsl:with-param>
									         		<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_fin_inst_country_sub_div</xsl:with-param>
									         		<xsl:with-param name="type">text</xsl:with-param>
									         		<xsl:with-param name="value"><xsl:value-of select ="$insuranceAssuerCtrySubDivision"/></xsl:with-param>
									         		<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								        		</xsl:call-template>
								        		<xsl:call-template name="country-field">
								        			<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_fin_inst_country</xsl:with-param>
													<xsl:with-param name="prefix">assuer_fin_inst</xsl:with-param>
													<xsl:with-param name="required">Y</xsl:with-param>
													<xsl:with-param name="value"><xsl:value-of select ="$insuranceAssuerCtry"/></xsl:with-param>
													<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
												</xsl:call-template>
											</xsl:with-param>
											</xsl:call-template>
										</xsl:when>
					        		<xsl:otherwise></xsl:otherwise>
					        	</xsl:choose>
				        	</xsl:with-param>
					     </xsl:call-template>
		</xsl:template>
	<xd:doc>
		<xd:short>Insurance Claims Payable At Details</xd:short>
		<xd:detail>
			This templates displays Insurance Claims Payable At Details,a place where claims under the insurance policy will be paid.
 		</xd:detail>
 		<xd:param name="claimsPayableAtStreetNm">street name at which claims under the insurance policy will be paid at.</xd:param>
  		<xd:param name="claimsPayableAtPstCdId">Identifier consisting of a group of letters and/or numbers that is added to a postal address to assist the sorting
		of mail.</xd:param>
  		<xd:param name="claimsPayableAtTwnNm">Town Name at which claims under the insurance policy will be paid at.</xd:param>
  		<xd:param name="claimsPayableAtCtrySubDvsn"> Identifies a subdivision of a country at which claims under the insurance policy will be paid at.</xd:param>
  		<xd:param name="claimsPayableAtCtry">Country Code of assuer. <b>Mandatory</b></xd:param>
 	</xd:doc>
	
	<xsl:template name="insurance-claims-payable-at"> 
		<xsl:param name="claimsPayableAtStreetNm"/>
		<xsl:param name="claimsPayableAtPstCdId"/>
		<xsl:param name="claimsPayableAtTwnNm"/>
		<xsl:param name="claimsPayableAtCtrySubDvsn"/>
		<xsl:param name="claimsPayableAtCtry"/>
		<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_CLAIMS_PAYABLE_AT</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
					<xsl:choose>
						<xsl:when test="$displaymode='edit'">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_STREET</xsl:with-param>
								<xsl:with-param name="name">claims_payable_at_street_name</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_POST_CODE</xsl:with-param>
								<xsl:with-param name="name">claims_payable_at_postcode</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_TOWN</xsl:with-param>
								<xsl:with-param name="name">claims_payable_at_town_name</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION</xsl:with-param>
								<xsl:with-param name="name">claims_payable_at_country_subdivision</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_COUNTRY</xsl:with-param>
								<xsl:with-param name="name">claims_payable_at_country</xsl:with-param>
								<xsl:with-param name="required">Y</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="$displaymode='view'">
							<xsl:if test= "$claimsPayableAtStreetNm !=''">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_STREET</xsl:with-param>
								<xsl:with-param name="name">claims_payable_at_street_name</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select ="$claimsPayableAtStreetNm"/></xsl:with-param>
							</xsl:call-template>
							</xsl:if>
							<xsl:if test= "$claimsPayableAtPstCdId !=''">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_POST_CODE</xsl:with-param>
								<xsl:with-param name="name">claims_payable_at_postcode</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select ="$claimsPayableAtPstCdId"/></xsl:with-param>
							</xsl:call-template>
							</xsl:if>
							<xsl:if test= "$claimsPayableAtTwnNm !=''">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_TOWN</xsl:with-param>
								<xsl:with-param name="name">claims_payable_at_town_name</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select ="$claimsPayableAtTwnNm"/></xsl:with-param>
							</xsl:call-template>
							</xsl:if>
							<xsl:if test= "$claimsPayableAtCtrySubDvsn !=''">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION</xsl:with-param>
								<xsl:with-param name="name">claims_payable_at_country_subdivision</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select ="$claimsPayableAtCtrySubDvsn"/></xsl:with-param>
							</xsl:call-template>
							</xsl:if>
							<xsl:if test= "$claimsPayableAtCtry !=''">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_COUNTRY</xsl:with-param>
								<xsl:with-param name="name">claims_payable_at_country</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select ="$claimsPayableAtCtry"/></xsl:with-param>
							</xsl:call-template>
							</xsl:if>
						</xsl:when>
						<xsl:otherwise></xsl:otherwise>
						</xsl:choose>
			 		</xsl:with-param>
			 	</xsl:call-template>
	</xsl:template>
	
		<xd:doc>
		<xd:short>Insurance Claims Payable In</xd:short>
		<xd:detail>
			This templates displays Insurance Claims Payable in
 		</xd:detail>
 		<xd:param name="insuranceClaimsPayableIn">insurance Claims Payable In holds Currency in which claims, if valid, will be paid. <b>Mandatory</b></xd:param>
 	</xd:doc>
	<xsl:template name="insurance-claims-payable-in">
		<xsl:param name="insuranceClaimsPayableIn"/>
		<xsl:choose>
			<xsl:when test="$displaymode='edit'">
				<xsl:if test= "$insuranceClaimsPayableIn !=''">
			 		<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_INSURANCE_PAYABLE_IN</xsl:with-param>
								<xsl:with-param name="name">insurance_claims_payable_in</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			 </xsl:when>
			 <xsl:when test="$displaymode='view'">
			 	<xsl:if test= "$insuranceClaimsPayableIn !=''">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_INSURANCE_PAYABLE_IN</xsl:with-param>
							<xsl:with-param name="name">insurance_claims_payable_in</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select ="$insuranceClaimsPayableIn"/></xsl:with-param>
						</xsl:call-template>
				</xsl:if>
			</xsl:when>
			</xsl:choose>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Payment Insurance Dataset Details</xd:short>
		<xd:detail>
			This template contains Insurance Dataset Details Section.
		</xd:detail>
	</xd:doc>
	<xsl:template name="payment-insurance-dataset-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_PURCHASE_ORDER_INSURANCE_DATASET_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
			 	<xsl:call-template name="dataset-identification">
                         <xsl:with-param name="fieldPrefix">insurance</xsl:with-param>
                         <xsl:with-param name="dataSetId"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/DataSetId/Id"/></xsl:with-param>
                         <xsl:with-param name="dataSetVersion"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/DataSetId/Vrsn"/></xsl:with-param>
                         <xsl:with-param name="dataSetSubmitterBic"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/DataSetId/Submitr/BIC"/></xsl:with-param>
                </xsl:call-template>
			 	<!-- Insurance dataset issuer details  -->
			 	<xsl:call-template name="issuer-details">
			 			<xsl:with-param name="fieldPrefix">issuer</xsl:with-param>
						<xsl:with-param name="issuerName"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/Issr/Nm"/></xsl:with-param>
						<xsl:with-param name="issuerPropId"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/Issr/PrtryId/Id"/></xsl:with-param>
						<xsl:with-param name="issuerPropType"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/Issr/PrtryId/IdTp"/></xsl:with-param>
						<xsl:with-param name="issuerStreetNm"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/Issr/PstlAdr/StrtNm"/></xsl:with-param>
						<xsl:with-param name="issuerPostCode"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/Issr/PstlAdr/PstCdId"/></xsl:with-param>
						<xsl:with-param name="issuerTownNm"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/Issr/PstlAdr/TwnNm"/></xsl:with-param>
						<xsl:with-param name="issuerCountrySubDiv"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/Issr/PstlAdr/CtrySubDvsn"/></xsl:with-param>
						<xsl:with-param name="issuerCountry"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/Issr/PstlAdr/Ctry"/></xsl:with-param>
			 	</xsl:call-template>
			 	
			 	<!--Issue Date -->
			 	<xsl:call-template name="date-details">
			 		<xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
			 		<xsl:with-param name="fieldPrefix">issue</xsl:with-param>
			 		<xsl:with-param name="date"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/IsseDt"/></xsl:with-param>
			 	</xsl:call-template>
			 	 			 	
				<!-- Effective date  -->
				<xsl:call-template name="date-details">
			 		<xsl:with-param name="label">XSL_GENERALDETAILS_EFFECTIVE_DATE</xsl:with-param>
			 		<xsl:with-param name="fieldPrefix">effective</xsl:with-param>
			 		<xsl:with-param name="date"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/FctvDt"/></xsl:with-param>
			 	</xsl:call-template>
		
				<!-- place of issue -->
				<xsl:call-template name="place-of-issue">
					<xsl:with-param name="fieldPrefix">poi</xsl:with-param>
					<xsl:with-param name="poiStreetNm"><xsl:value-of select ="payment_insurance_dataset/InsrncDataSet/PlcOfIsse/StrtNm"/></xsl:with-param>
					<xsl:with-param name="poiPostCode"><xsl:value-of select ="payment_insurance_dataset/InsrncDataSet/PlcOfIsse/PstCdId"/></xsl:with-param>
					<xsl:with-param name="poiTownNm"><xsl:value-of select ="payment_insurance_dataset/InsrncDataSet/PlcOfIsse/TwnNm"/></xsl:with-param>
					<xsl:with-param name="poiCtrySubDiv"><xsl:value-of select ="payment_insurance_dataset/InsrncDataSet/PlcOfIsse/CtrySubDvsn"/></xsl:with-param>
					<xsl:with-param name="poiCtry"><xsl:value-of select ="payment_insurance_dataset/InsrncDataSet/PlcOfIsse/Ctry"/></xsl:with-param>
				</xsl:call-template>
			
			 	<!-- Insurance Document identification -->
			 	<xsl:call-template name="insurance-doc-id">
					<xsl:with-param name="insuranceDocId"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/InsrncDocId"/></xsl:with-param>
				</xsl:call-template>
				
				<!--Insurance Routing summary Transport Details -->
				<xsl:call-template name="payment-insurance-routing-summary-details"></xsl:call-template>
		
				<!-- Insured amount -->
				<xsl:call-template name="insurance-amt">
					<xsl:with-param name="insuranceAmt"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/InsrdAmt"/></xsl:with-param>
				</xsl:call-template>
			
				<!-- Insured goods description  -->
				<xsl:call-template name="insurance-goods-desc">
					<xsl:with-param name="insuranceGoodsDesc"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/InsrdGoodsDesc"/></xsl:with-param>
				</xsl:call-template>
			
				<!-- Insurance Clauses  -->
				 <xsl:choose>
					<xsl:when test="$displaymode='edit'">
						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_DETAILS_PO_CLAUSES_REQUIRED_HEADER</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="toc-item">N</xsl:with-param>
							<xsl:with-param name="content">
						&nbsp;
								<xsl:call-template name="build-payment-required-clause-dojo-items">
									<xsl:with-param name="items" select="payment_insurance_dataset/InsrncDataSet/InsrncClauses" /> 
									<xsl:with-param name="id">payment_insurance_dataset_req_clause</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template> 
					</xsl:when>
					<xsl:when test="$displaymode='view'">
						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_DETAILS_PO_CLAUSES_REQUIRED_HEADER</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="toc-item">N</xsl:with-param>
							<xsl:with-param name="content">
						&nbsp;
							<xsl:call-template name="build-payment-required-clause-dojo-items">
								 <xsl:with-param name="items" select="payment_insurance_dataset/InsrncDataSet/InsrncClauses" /> 
								<xsl:with-param name="id">payment_insurance_dataset_req_clause</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template> 
				</xsl:when>
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose> 
			<!-- Insurance Conditions -->
			<xsl:choose>
			<xsl:when test="$displaymode='edit'">
			 	<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_DETAILS_PO_CONDITIONS_REQUIRED_HEADER</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="toc-item">N</xsl:with-param>
					<xsl:with-param name="content">
					&nbsp;
						<xsl:call-template name="build-payment-required-condition-dojo-items">
							<xsl:with-param name="items" select="payment_insurance_dataset/InsrncDataSet/InsrncConds" />
							<xsl:with-param name="id">payment_insurance_dataset_req_condition</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$displaymode='view'">
			 	<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_DETAILS_PO_CONDITIONS_REQUIRED_HEADER</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="toc-item">N</xsl:with-param>
					<xsl:with-param name="content">
					&nbsp;
						<xsl:call-template name="build-payment-required-condition-dojo-items">
							<xsl:with-param name="items" select="payment_insurance_dataset/InsrncDataSet/InsrncConds" />
							<xsl:with-param name="id">payment_insurance_dataset_req_condition</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template> 
			</xsl:when>
			<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
			<!-- Assurance Details  -->
				<xsl:call-template name="insurance-assurance-details">
					<xsl:with-param name="fieldPrefix">assuer</xsl:with-param>
					<xsl:with-param name="insuranceAssuerBic"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/Assrd/BIC"/></xsl:with-param>
					<xsl:with-param name="insuranceAssuerNmAddr"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/Assrd/NmAndAdr"/></xsl:with-param>
					<xsl:with-param name="insuranceAssuerNm"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/Assrd/NmAndAdr/Nm"/></xsl:with-param>
					<xsl:with-param name="insuranceAssuerPropId"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/Assrd/NmAndAdr/PrtryId/Id"/></xsl:with-param>
					<xsl:with-param name="insuranceAssuerPropType"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/Assrd/NmAndAdr/PrtryId/IdTp"/></xsl:with-param>
					<xsl:with-param name="insuranceAssuerStreetNm"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/Assrd/NmAndAdr/PstlAdr/StrtNm"/></xsl:with-param>
					<xsl:with-param name="insuranceAssuerPostCode"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/Assrd/NmAndAdr/PstlAdr/PstCdId"/></xsl:with-param>
					<xsl:with-param name="insuranceAssuerTownNm"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/Assrd/NmAndAdr/PstlAdr/TwnNm"/></xsl:with-param>
					<xsl:with-param name="insuranceAssuerCtrySubDivision"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/Assrd/NmAndAdr/PstlAdr/CtrySubDvsn"/></xsl:with-param>
					<xsl:with-param name="insuranceAssuerCtry"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/Assrd/NmAndAdr/PstlAdr/Ctry"/></xsl:with-param>
				</xsl:call-template>
			 	<!-- Claims Payable At Details -->
			 	<xsl:call-template name="insurance-claims-payable-at">
			 		<xsl:with-param name="claimsPayableAtStreetNm"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/ClmsPyblAt/StrtNm"/></xsl:with-param>
			 		<xsl:with-param name="claimsPayableAtPstCdId"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/ClmsPyblAt/PstCdId"/></xsl:with-param>
			 		<xsl:with-param name="claimsPayableAtTwnNm"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/ClmsPyblAt/TwnNm"/></xsl:with-param>
			 		<xsl:with-param name="claimsPayableAtCtrySubDvsn"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/ClmsPyblAt/CtrySubDvsn"/></xsl:with-param>
			 		<xsl:with-param name="claimsPayableAtCtry"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/ClmsPyblAt/Ctry"/></xsl:with-param>
			 	</xsl:call-template>
			 	<!-- claims payable in  -->
			 	<xsl:call-template name="insurance-claims-payable-in">
			 		<xsl:with-param name="insuranceClaimsPayableIn"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/ClmsPyblIn"/></xsl:with-param>
			 	</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Payment Clause Required</xd:short>
		<xd:detail>
			This templates defines 3 variable with different value and fills the value of a attribute based on these values, displays codes of the clauses based on parameter C022
 		</xd:detail>	
 	</xd:doc>
	<xsl:template match="payment_insurance_dataset/InsrncDataSet/InsrncClauses">
		<xsl:variable name="code_type"><xsl:value-of select="."></xsl:value-of></xsl:variable>
		<xsl:variable name="parameterId">C022</xsl:variable>
		<xsl:variable name="code_type_desc"><xsl:value-of select="localization:getCodeData($language,'*', product_code, $parameterId, $code_type)"/></xsl:variable>
		<div dojoType="misys.openaccount.widget.PaymentInsuranceRequiredClause">
			<xsl:attribute name="payment_ids_clauses_required"><xsl:value-of select="."/></xsl:attribute>
			<xsl:attribute name="payment_ids_clauses_required_hidden"><xsl:value-of select="$code_type_desc"/></xsl:attribute>
		</div>
	</xsl:template>
	<!--Payment Insurance Required Clause Dialog declaration  -->
	<xd:doc>
		<xd:short>Payment Insurance Required Clause Dialog declaration</xd:short>
		<xd:detail>
			This templates adds a title attributes and and fills it with it Confirmation,it also defines variables and sets the parameters of Clause required field in Insurence dataset based on these
			variables in input and select field.It also adds parameter of the hidden field and adds Cancel and Ok button to the clause dialog box
 		</xd:detail>	
 	</xd:doc>
	<xsl:template name="payment-insurance-required-clause-dialog-declaration">
		<div id="payment-insurance-required-clause-dialog-template" style="display:none"
			class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
			<div>
				<xsl:variable name="code_type"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/InsrncClauses"></xsl:value-of></xsl:variable>
				<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
				<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
				<xsl:variable name="parameterId">C022</xsl:variable>
				<xsl:choose>
				 <xsl:when test="$displaymode='view' ">
					<xsl:if test="$code_type != ''">
						<xsl:variable name="code_type"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/InsrncClauses"></xsl:value-of></xsl:variable>
						<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
						<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
						<xsl:variable name="parameterId">C022</xsl:variable>
							<xsl:call-template name="input-field">
							 	<xsl:with-param name="label">XSL_DETAILS_PO_CLAUSES_REQUIRED</xsl:with-param>
							 	<xsl:with-param name="name">payment_ids_clauses_required_hidden</xsl:with-param>
							 	<xsl:with-param name="override-displaymode">edit</xsl:with-param>	
							 	<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							 	<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $code_type)"/></xsl:with-param>
							</xsl:call-template>
					</xsl:if>
			 	</xsl:when> 
				<xsl:otherwise>
					<xsl:call-template name="select-field">
						<xsl:with-param name="label">XSL_DETAILS_PO_CLAUSES_REQUIRED</xsl:with-param>
						<xsl:with-param name="name">payment_ids_clauses_required</xsl:with-param>
						<xsl:with-param name="override-displaymode">edit</xsl:with-param>
						<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
						<xsl:with-param name="required">N</xsl:with-param>
						<xsl:with-param name="options">
							 <xsl:call-template name="ids-clauses-required-codes" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
				
		  	<xsl:call-template name="hidden-field">
	    		<xsl:with-param name="name">payment_ids_clauses_required_hidden</xsl:with-param>	    
	     		<xsl:with-param name="value">
	     	 		<xsl:if test="payment_insurance_dataset/InsrncDataSet/InsrncClauses[.!='']">
	     	 			<xsl:value-of select="localization:getCodeData($language,'*', $productCode, $parameterId, $code_type)"/>
	     			</xsl:if>
	     		</xsl:with-param>  
	     	</xsl:call-template>
				
			<div class="dijitDialogPaneActionBar">
				<xsl:call-template name="label-wrapper">
					<xsl:with-param name="content">
						<button type="button" dojoType="dijit.form.Button">
							<xsl:attribute name="onmouseup">dijit.byId('payment-insurance-required-clause-dialog-template').hide();</xsl:attribute>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
						</button>							
						<xsl:if test="$displaymode = 'edit'">
							<button dojoType="dijit.form.Button">
								<xsl:attribute name="onClick">dijit.byId('payment-insurance-required-clause-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
							</button>
						</xsl:if>
					</xsl:with-param>
			</xsl:call-template>
		</div>
		</div>
	</div>
	</xsl:template>
	
		<!--Payment Insurance required clauses  -->
	<xd:doc>
		<xd:short>Payment Insurance Required Clause Declaration</xd:short>
		<xd:detail>
			This templates displayes no clause required message or add clause required button.
 		</xd:detail>	
 	</xd:doc>
	<xsl:template name="payment-insurance-required-clause-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="payment-insurance-required-clause-dialog-declaration" />
		<!-- Dialog End -->
		<div id="payment-insurance-required-clause-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_NO_CLAUSE_REQ')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_ADD_CLAUSE_REQ')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Build Insurance required clause</xd:short>
		<xd:detail>
			This templates displays header for diplaying clause field in insurence dataset in add,edit and view mode,also displayes header of the clause table.
			It also defines variables and adds attributes of different fields in clause dialog fills it with given value.
 		</xd:detail>
 		<xd:param name="items"> </xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">Overridden display mode.</xd:param>		
 	</xd:doc>
	<xsl:template name="build-payment-required-clause-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
		
		<div dojoType="misys.openaccount.widget.PaymentInsuranceRequiredClauses" dialogId="payment-insurance-required-clause-dialog-template">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_ADD_CLAUSE_REQ')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_EDIT_CLAUSE_REQ')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_VIEW_CLAUSE_REQ')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_LABEL_CLAUSE_REQ')" />
			</xsl:attribute>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
			 <xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="InsuranceDataset" select="." />
					<div dojoType="misys.openaccount.widget.PaymentInsuranceRequiredClause">
					<xsl:attribute name="payment_ids_clauses_required"><xsl:value-of
						select="$InsuranceDataset" />
					</xsl:attribute> 
					<xsl:attribute name="payment_ids_clauses_required_hidden"><xsl:value-of
						select="localization:getDecode($language, 'C022', $InsuranceDataset)" />
					</xsl:attribute>  
					</div>
				</xsl:for-each>
			</xsl:if>
		</div>
	</xsl:template>
	
	<!--Payment Insurance Required Condition Dialog declaration  -->
	<xd:doc>
		<xd:short>Payment Insurance Required Condition Dialog declaration</xd:short>
		<xd:detail>
			This templates adds a title attributes and and fills it with it Confirmation,it also defines variables and sets the parameters of Condition field in Insurence dataset based on these
			variables in input and select field.It also adds parameter of the hidden field and adds Cancel and Ok button to the clause dialog box
 		</xd:detail>	
 	</xd:doc>
	<xsl:template name="payment-insurance-required-conditions-dialog-declaration">
		<div id="payment-insurance-required-condition-dialog-template" style="display:none"
			class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
				<div>
				 <xsl:choose>
					<xsl:when test="$displaymode='view' ">
 						<xsl:if test="payment_insurance_dataset/InsrncDataSet/InsrncConds[.!='']">
							<xsl:variable name="condValue"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/InsrncConds"></xsl:value-of></xsl:variable>
								<xsl:call-template name="input-field">
									 <xsl:with-param name="label">XSL_DETAILS_PO_CONDITION_REQUIRED</xsl:with-param>
									 <xsl:with-param name="name">payment_ids_conditions_required</xsl:with-param>
									 <xsl:with-param name="value"><xsl:value-of select="$condValue"/></xsl:with-param>
									 <xsl:with-param name="override-displaymode">edit</xsl:with-param>
									 <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>	
								</xsl:call-template>
						</xsl:if>
					 </xsl:when> 
					<xsl:otherwise>
						<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_DETAILS_PO_CONDITION_REQUIRED</xsl:with-param>
								<xsl:with-param name="name">payment_ids_conditions_required</xsl:with-param>
								<xsl:with-param name="override-displaymode">edit</xsl:with-param>
								<xsl:with-param name="required">N</xsl:with-param>
								<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
						
				<div class="dijitDialogPaneActionBar">
					<xsl:call-template name="label-wrapper">
						<xsl:with-param name="content">
							<button type="button" dojoType="dijit.form.Button">
								<xsl:attribute name="onmouseup">dijit.byId('payment-insurance-required-condition-dialog-template').hide();</xsl:attribute>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
								</button>							
								<xsl:if test="$displaymode = 'edit'">
									<button dojoType="dijit.form.Button">
										<xsl:attribute name="onClick">dijit.byId('payment-insurance-required-condition-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
										<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
									</button>
								</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
					</div>
				</div>
		</div>
	</xsl:template>
	<!--Payment Insurance conditions  -->
	<xd:doc>
		<xd:short>Payment Insurance Conditions Declaration</xd:short>
		<xd:detail>
			This templates displayes no conditions required message or add conditions required button.
 		</xd:detail>	
 	</xd:doc>
	<xsl:template name="payment-insurance-required-conditions-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="payment-insurance-required-conditions-dialog-declaration" />
		<!-- Dialog End -->
		<div id="payment-insurance-required-conditions-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_NO_CONDITION_REQ')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_ADD_CONDITION_REQ')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template name="build-payment-required-condition-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
		<div dojoType="misys.openaccount.widget.PaymentInsuranceRequiredConditions" dialogId="payment-insurance-required-condition-dialog-template">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_ADD_CONDITION_REQ')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_EDIT_CONDITION_REQ')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_VIEW_CONDITION_REQ')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_LABEL_CONDITION_REQ')" />
			</xsl:attribute>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
			 <xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="InsuranceDataset" select="." />
					<div dojoType="misys.openaccount.widget.PaymentInsuranceRequiredCondition">
					<xsl:attribute name="payment_ids_conditions_required"><xsl:value-of
						select="$InsuranceDataset" />
					</xsl:attribute>  
					</div>
				</xsl:for-each>
			</xsl:if>
		</div>
	</xsl:template>
	<!-- ***************************************** -->
	<!-- END : Payment Insurance Dataset Templates -->
	<!-- ***************************************** -->
	
	
	<!-- ***************************************** -->
	<!-- START : Payment Other Certificate Dataset -->
	<!-- ***************************************** -->
	
	<!-- Template for the declaration of line items -->
	 <xd:doc>
		<xd:short>The payment other certificate dataset dialog declaration.</xd:short>
		<xd:detail>
 		Payment other certificate dataset form is displayed containing Certificate Id, Certificate Type etc.Calls different template for displaying different section such as '' ,'quantity-unit-measure-codes' etc
		</xd:detail>
	</xd:doc> 
	<xsl:template name="payment-other-cds-dialog-declaration">
		<div id="payment-other-cds-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
				<div id="payment-other-cds-dialog-template-content">
					<div>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_CERTIFICATE_ID</xsl:with-param>
							<xsl:with-param name="name">payment_other_cert_id</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="payment_other_certificate_dataset/OthrCertDataSet/CertId"/></xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="swift-validate">N</xsl:with-param>
							<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
							<xsl:with-param name="size">64</xsl:with-param>
							<xsl:with-param name="maxsize">64</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>
						<xsl:variable name="code_type"><xsl:value-of select="payment_other_certificate_dataset/OthrCertDataSet/CertTp"></xsl:value-of></xsl:variable>
						<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
						<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
						<xsl:variable name="parameterId">C024</xsl:variable>
						<xsl:choose>
							<xsl:when test="$displaymode='view' ">
								<xsl:if test="code_type != ''">
										<xsl:call-template name="input-field">
										 	<xsl:with-param name="label">XSL_CERIFICATE_TYPE</xsl:with-param>
										 	<xsl:with-param name="name">payment_other_cds_type</xsl:with-param>
										 	<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $code_type)"/></xsl:with-param>
										 	<xsl:with-param name="override-displaymode">edit</xsl:with-param>
										 	<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										 	<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>	
										</xsl:call-template>
								</xsl:if>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="select-field">
									<xsl:with-param name="label">XSL_CERIFICATE_TYPE</xsl:with-param>
									<xsl:with-param name="name">payment_other_cds_type</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="required">N</xsl:with-param>
									<xsl:with-param name="options">
										 <xsl:call-template name="ocds-cert-type-codes" />
									</xsl:with-param>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:call-template name="hidden-field">
					    	<xsl:with-param name="name">payment_other_cds_cert_type_hidden</xsl:with-param>	    
					     	<xsl:with-param name="value">
					     	 <xsl:if test="code_type != ''">
					     	 <xsl:value-of select="localization:getCodeData($language,'*', $productCode, $parameterId, $code_type)"/>
					     	 </xsl:if>
					     	</xsl:with-param>  
					     </xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DATA_SET_ISS_DATE</xsl:with-param>
							<xsl:with-param name="name">payment_other_cert_issue_date</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="payment_other_certificate_dataset/OthrCertDataSet/IsseDt"/></xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="swift-validate">N</xsl:with-param>
							<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>
				       
                   		<xsl:call-template name="dataset-identification">
                   			<xsl:with-param name="fieldPrefix">payment_other_cert</xsl:with-param>
							<xsl:with-param name="dataSetId"><xsl:value-of select="payment_other_certificate_dataset/OthrCertDataSet/DataSetId/Id"/></xsl:with-param>
                          	<xsl:with-param name="dataSetVersion"><xsl:value-of select="payment_other_certificate_dataset/OthrCertDataSet/DataSetId/Vrsn"/></xsl:with-param>
                          	<xsl:with-param name="dataSetSubmitterBic"><xsl:value-of select="payment_other_certificate_dataset/OthrCertDataSet/DataSetId/Submitr/BIC"/></xsl:with-param>
                          	<xsl:with-param name="isWidget">Y</xsl:with-param>
						</xsl:call-template>
						                   		
						<xsl:call-template name="issuer-details-widget">
							<xsl:with-param name="fieldPrefix">payment_other_cert</xsl:with-param>
			              	<xsl:with-param name="issuerName"><xsl:value-of select="payment_other_certificate_dataset/OthrCertDataSet/Issr/Nm"/></xsl:with-param>
			              	<xsl:with-param name="issuerPropId"><xsl:value-of select="payment_other_certificate_dataset/OthrCertDataSet/Issr/PrtryId/Id"/></xsl:with-param>
			              	<xsl:with-param name="issuerPropType"><xsl:value-of select="payment_other_certificate_dataset/OthrCertDataSet/Issr/PrtryId/IdTp"/></xsl:with-param>
			              	<xsl:with-param name="issuerStreetNm"><xsl:value-of select="payment_other_certificate_dataset/OthrCertDataSet/Issr/PstlAdr/StrtNm"/></xsl:with-param>
			              	<xsl:with-param name="issuerPostCode"><xsl:value-of select="payment_other_certificate_dataset/OthrCertDataSet/Issr/PstlAdr/PstCdId"/></xsl:with-param>
			              	<xsl:with-param name="issuerTownNm"><xsl:value-of select="payment_other_certificate_dataset/OthrCertDataSet/Issr/PstlAdr/TwnNm"/></xsl:with-param>
			              	<xsl:with-param name="issuerCountrySubDiv"><xsl:value-of select="payment_other_certificate_dataset/OthrCertDataSet/Issr/PstlAdr/CtrySubDvsn"/></xsl:with-param>
			              	<xsl:with-param name="issuerCountry"><xsl:value-of select="payment_other_certificate_dataset/OthrCertDataSet/Issr/PstlAdr/Ctry"/></xsl:with-param>
						</xsl:call-template>
								
						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_HEADER_INCO_TERMS_DETAILS</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="toc-item">N</xsl:with-param>
							<xsl:with-param name="content"> 
							&nbsp; 
								<xsl:call-template name="build-pmt-other-cds-info-dojo-items">
									<xsl:with-param name="id">payment_other_cert_ds_info</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>

				<div class="dijitDialogPaneActionBar">
					<xsl:call-template name="label-wrapper">
						<xsl:with-param name="content">
							<button type="button" dojoType="dijit.form.Button">
								<xsl:attribute name="onmouseup">dijit.byId('payment-other-cds-dialog-template').hide();</xsl:attribute>
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
							</button>
							<xsl:if test="$displaymode = 'edit'">
								<button dojoType="dijit.form.Button">
									<xsl:attribute name="onClick">dijit.byId('payment-other-cds-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
								</button>
							</xsl:if>										
						</xsl:with-param>
					</xsl:call-template>
				</div>
			</div>
		</div>
	</div>
</xsl:template>	
	 <xd:doc>
		<xd:short>Declares the Payment Other Certificate Info</xd:short>
		<xd:detail>
		Creates the buttons for adding payment other certificate details and displays no other certificate details if not present
 		</xd:detail>
	</xd:doc>
	<xsl:template name="payment-other-cds-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="payment-other-cds-dialog-declaration" /> 
		<!-- Dialog End -->
		<div id="payment-other-cds-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PAYMENT_OTR_CERT')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<!--
				TODO: Only possible if PO currency is selected (total_cur_code)
				-->
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_ADD_PAYMENT_OTR_CERT')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	<!-- Payment Other Certificate Dataset - Dojo objects -->
	<xd:doc>
		<xd:short>Build Payment Other Certificate Dataset</xd:short>
		<xd:detail>
			This templates displays header for the payment other certificate dataset.In case of add edit and view mode,displayes header for the grid and adds different attributes to the dataset.
 		</xd:detail>
 		<xd:param name="items"> Items to be build to form display </xd:param>
 		<xd:param name="override-displaymode">Overridden display mode.Shows in edit mode of the parent form</xd:param>
 	</xd:doc>
	<xsl:template name="build-payment-other-cds-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
		<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
		<div dojoType="misys.openaccount.widget.PaymentOtherCertificateDatasets" dialogId="payment-other-cds-dialog-template">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_ADD_PAYMENT_OTR_CERT')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_EDIT_PAYMENT_OTR_CERT')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_VIEW_PAYMENT_OTR_CERT')" /></xsl:attribute>
			<xsl:attribute name="headers">
			<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_OTHER_CERIFICATE_TYPE')" />
			</xsl:attribute>
			<xsl:for-each select="$items">
				<xsl:variable name="paymentOtherCds" select="." />
				<xsl:variable name="code_type"><xsl:value-of select="./CertTp"></xsl:value-of></xsl:variable>
				<xsl:variable name="parameterId">C024</xsl:variable>
				<xsl:variable name="code_type_desc"><xsl:value-of select="localization:getCodeData($language,'*', product_code, $parameterId, $code_type)"/></xsl:variable>
				<div dojoType="misys.openaccount.widget.PaymentOtherCertificateDataset">
					<xsl:attribute name="payment_other_cds_type"><xsl:value-of
						select="$paymentOtherCds/CertTp" /></xsl:attribute>
						<xsl:attribute name="payment_other_cds_cert_type_hidden"><xsl:value-of select="$code_type_desc" /></xsl:attribute>
						<xsl:attribute name="payment_other_cert_dataset_id"><xsl:value-of
						select="$paymentOtherCds/DataSetId/Id" /></xsl:attribute>
						<xsl:attribute name="payment_other_cert_dataset_version"><xsl:value-of
						select="$paymentOtherCds/DataSetId/Vrsn" /></xsl:attribute>
						<xsl:attribute name="payment_other_cert_submitter_bic"><xsl:value-of
						select="$paymentOtherCds/DataSetId/Submitr/BIC" /></xsl:attribute>
						<xsl:attribute name="payment_other_cert_id"><xsl:value-of
						select="$paymentOtherCds/CertId" /></xsl:attribute>
						<xsl:attribute name="payment_other_cert_issue_date"><xsl:value-of
						select="tools:convertISODate2MTPDate($paymentOtherCds/IsseDt,'en')" /></xsl:attribute>
						<xsl:attribute name="payment_other_cert_issuer_name"><xsl:value-of
						select="$paymentOtherCds/Issr/Nm" /></xsl:attribute>
						<xsl:attribute name="payment_other_cert_prpty_id"><xsl:value-of
						select="$paymentOtherCds/Issr/PrtryId/Id" /></xsl:attribute>
						<xsl:attribute name="payment_other_cert_prpty_id_type"><xsl:value-of
						select="$paymentOtherCds/Issr/PrtryId/IdTp" /></xsl:attribute>
						<xsl:attribute name="payment_other_cert_addr_street_nm"><xsl:value-of
						select="$paymentOtherCds/Issr/PstlAdr/StrtNm" /></xsl:attribute>					
						<xsl:attribute name="payment_other_cert_addr_code"><xsl:value-of
						select="$paymentOtherCds/Issr/PstlAdr/PstCdId" /></xsl:attribute>
						<xsl:attribute name="payment_other_cert_addr_town"><xsl:value-of
						select="$paymentOtherCds/Issr/PstlAdr/TwnNm" /></xsl:attribute>
						<xsl:attribute name="payment_other_cert_addr_ctry_sub_div"><xsl:value-of
						select="$paymentOtherCds/Issr/PstlAdr/CtrySubDvsn" /></xsl:attribute>
						<xsl:attribute name="payment_other_cert_addr_ctry"><xsl:value-of
						select="$paymentOtherCds/Issr/PstlAdr/Ctry" /></xsl:attribute>
						<div dojoType="misys.openaccount.widget.PaymentOtherCertificateInfos">
							<xsl:for-each select="$paymentOtherCds/CertInf">
								<div dojoType="misys.openaccount.widget.PaymentOtherCertificateInfo">
									<xsl:attribute name="payment_other_cert_info"><xsl:value-of select="."/></xsl:attribute>
								</div>
							</xsl:for-each>
						</div>
						
				</div>
			</xsl:for-each>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Payment Other Certificate Information declaration</xd:short>
		<xd:detail>
			This templates displays message NO Other Certificate Information if not present or provide a button to ADD in dialog box
 		</xd:detail>		
 	</xd:doc>
	<xsl:template name="pmt-other-cds-info-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="pmt-other-cds-info-dialog-declaration" />
		<!-- Dialog End -->
		<div id="pmt-other-cds-info-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_DETAILS_PAYMENT_OTR_CERT_INFO')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_DETAILS_ADD_PAYMENT_OTR_CERT_INFO')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Payment Other Certificate Information dialog declaration</xd:short>
		<xd:detail>
			This templates adds attribute title and fills it with Confirmation value,It also calls input field template for Information in other certificate dialog
			and sets it parameters with different value.it also adds button of OK and CANCEL in the dialog box.
 		</xd:detail>	
 	</xd:doc>
	<xsl:template name="pmt-other-cds-info-dialog-declaration">
		<div id="pmt-other-cds-info-dialog-template" style="display:none"
			class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
					<div>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_CERTIFICATE_INFO</xsl:with-param>
							<xsl:with-param name="name">payment_other_cert_info</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="size">350</xsl:with-param>
							<xsl:with-param name="maxsize">350</xsl:with-param>
							<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">N</xsl:if></xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>
						<div class="dijitDialogPaneActionBar">
						<xsl:call-template name="label-wrapper">
							<xsl:with-param name="content">
								<button type="button" dojoType="dijit.form.Button">
									<xsl:attribute name="onmouseup">dijit.byId('pmt-other-cds-info-dialog-template').hide();</xsl:attribute>
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
								</button>							
								<xsl:if test="$displaymode = 'edit'">
									<button dojoType="dijit.form.Button">
										<xsl:attribute name="onClick">dijit.byId('pmt-other-cds-info-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
									</button>
								</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
						</div>
					</div>
				</div>
	</xsl:template>	
	
	<xsl:template name="build-pmt-other-cds-info-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
		<div dojoType="misys.openaccount.widget.PaymentOtherCertificateInfos" dialogId="pmt-other-cds-info-dialog-template">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_ADD_PAYMENT_OTR_CERT_INFO')" /></xsl:attribute>
		<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_EDIT_PAYMENT_OTR_CERT_INFO')" /></xsl:attribute>
		<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_VIEW_PAYMENT_OTR_CERT_INFO')" /></xsl:attribute>
			<xsl:attribute name="headers"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_CERTIFICATE_INFO')" /></xsl:attribute>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
			<xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="otherCdsInfo" select="." />
					<div dojoType="misys.openaccount.widget.PaymentOtherCertificateInfo">
						<xsl:attribute name="payment_other_cert_info"><xsl:value-of select="$otherCdsInfo"/></xsl:attribute>
					</div>
				</xsl:for-each>
			</xsl:if>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Payment Other Certificate Info</xd:short>
		<xd:detail>
			This templates defines 3 variable with different value and fills the value of a attribute based on these values, displays codes of the clauses based on parameter C022
 		</xd:detail>	
 	</xd:doc>
	<xsl:template match="payment_other_certificate_dataset/OthrCertDataSet/CertInf">
		<div dojoType="misys.openaccount.widget.PaymentOtherCertificateInfo">
			<xsl:attribute name="payment_other_cert_info"><xsl:value-of select="CertInf"/></xsl:attribute>
		</div>
	</xsl:template>
	
	

	
	<!-- ***************************************** -->
	<!-- END : Payment Other Certificate Dataset -->
	<!-- ***************************************** -->
	
	
    <!-- *********************************** -->
  	<!-- START : PAYMENT CERTIFICATE DATASET -->
    <!-- *********************************** -->
    
    <xd:doc>
		<xd:short>Manufacturer Details Sub-section</xd:short>
		<xd:detail>
			This templates displays Manufacturer Details sub-section.
 		</xd:detail>
 		<xd:param name="fieldPrefix">Holds the prefix for the name field.In this case it is issuer</xd:param>
 		<xd:param name="manufacturerName">Name of the manufacturer field used in form submission. <b>Mandatory</b></xd:param>
  		<xd:param name="manufacturerPropId">Proprietary ID of the manufacturer field used in form submission.</xd:param>
  		<xd:param name="manufacturerPropType">Proprietary Type of the manufacturer field used in form submission.</xd:param>
  		<xd:param name="manufacturerStreetNm">street name of the manufacturer postal address.</xd:param>
  		<xd:param name="manufacturerPostCode">post code of manufacturer postal address.</xd:param>
  		<xd:param name="manufacturerTownNm">Town Name of manufacturer postal address.</xd:param>
  		<xd:param name="manufacturerCountrySubDiv"> Country Sub Division of manufacturer postal address.</xd:param>
  		<xd:param name="manufacturerCountry">Country Code of manufacturer. <b>Mandatory</b></xd:param>
 	</xd:doc>
	<xsl:template name="manufacturer-details">
		<xsl:param name="fieldPrefix"/>
		<xsl:param name="manufacturerName"/>
		<xsl:param name="manufacturerPropId"/>
		<xsl:param name="manufacturerPropType"/>
		<xsl:param name="manufacturerStreetNm"/>
		<xsl:param name="manufacturerPostCode"/>
		<xsl:param name="manufacturerTownNm"/>
		<xsl:param name="manufacturerCountrySubDiv"/>
		<xsl:param name="manufacturerCountry"/>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_MANUFACTURER_DETAILS</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="toc-item">N</xsl:with-param>
			<xsl:with-param name="content">
					<xsl:choose>
						<xsl:when test="$displaymode = 'edit'">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_DETAILS_PO_MANFCTR_NM</xsl:with-param>
								<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_name</xsl:with-param>
								<xsl:with-param name="required">Y</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_DETAILS_PO_PROPRIETARY_IDENTIFICATION</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="toc-item">N</xsl:with-param>
							<xsl:with-param name="content">
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_ISSUER_PRTRY_ID</xsl:with-param>
									<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_proprietary_id</xsl:with-param>
									<xsl:with-param name="size">35</xsl:with-param>
									<xsl:with-param name="maxsize">35</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_ISSUER_PRTRY_ID_TYPE</xsl:with-param>
									<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_proprietary_type</xsl:with-param>
									<xsl:with-param name="size">35</xsl:with-param>
									<xsl:with-param name="maxsize">35</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_DETAILS_PO_PSTL_ADDR</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="toc-item">N</xsl:with-param>
							<xsl:with-param name="content">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_DETAILS_PO_STREET_NAME</xsl:with-param>
								<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_street_name</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_DETAILS_POST_CODE_IDENTIFICATION</xsl:with-param>
								<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_postcode</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_DETAILS_PO_TOWN_NAME</xsl:with-param>
								<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_town_name</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_DETAILS_PO_CNTRY_SUB_DVSN</xsl:with-param>
								<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_country_subdivision</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_DETAILS_PO_CTRY</xsl:with-param>
								<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_country</xsl:with-param>
								<xsl:with-param name="required">Y</xsl:with-param>
							</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						</xsl:when>
						<xsl:when test="$displaymode='view'">
						 <xsl:if test="$manufacturerName !=''">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_DETAILS_PO_MANFCTR_NM</xsl:with-param>
								<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_name</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select ="$manufacturerName"/></xsl:with-param>
							</xsl:call-template>
						</xsl:if>
							<xsl:call-template name="fieldset-wrapper">
								<xsl:with-param name="legend">XSL_HEADER_PO_PRTRY_IDENTIFICATION</xsl:with-param>
								<xsl:with-param name="legend-type">indented-header</xsl:with-param>
								<xsl:with-param name="toc-item">N</xsl:with-param>
								<xsl:with-param name="content">
									<xsl:if test= "$manufacturerPropId !=''">
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_PROPRIETARY_ID</xsl:with-param>
											<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_proprietary_id</xsl:with-param>
											<xsl:with-param name="value"><xsl:value-of select ="$manufacturerPropId"/></xsl:with-param>
										</xsl:call-template>
									</xsl:if>
									<xsl:if test= "$manufacturerPropType !=''">
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_PROPRIETARY_TYPE</xsl:with-param>
											<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_>proprietary_type</xsl:with-param>
											 <xsl:with-param name="value"><xsl:value-of select ="$manufacturerPropType"/></xsl:with-param>
										</xsl:call-template>
									</xsl:if>
								</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="fieldset-wrapper">
								<xsl:with-param name="legend">XSL_PO_PARTIESDETAILS_POSTAL_ADDRESS</xsl:with-param>
								<xsl:with-param name="legend-type">indented-header</xsl:with-param>
								<xsl:with-param name="toc-item">N</xsl:with-param>
								<xsl:with-param name="content">
									<xsl:if test= "$manufacturerStreetNm !=''">
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_STREET</xsl:with-param>
											<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_street_name</xsl:with-param>
											<xsl:with-param name="value"><xsl:value-of select ="$manufacturerStreetNm"/></xsl:with-param>
										</xsl:call-template>
									</xsl:if>
									<xsl:if test= "$manufacturerPostCode !=''">
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_POST_CODE</xsl:with-param>
											<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_postcode</xsl:with-param>
											<xsl:with-param name="value"><xsl:value-of select ="$manufacturerPostCode"/></xsl:with-param>
										</xsl:call-template>
									</xsl:if>
									<xsl:if test= "$manufacturerTownNm !=''">
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_TOWN</xsl:with-param>
											<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_town_name</xsl:with-param>
											<xsl:with-param name="value"><xsl:value-of select ="$manufacturerTownNm"/></xsl:with-param>
										</xsl:call-template>
									</xsl:if>
									<xsl:if test= "$manufacturerCountrySubDiv !=''">
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION</xsl:with-param>
											<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_country_subdivision</xsl:with-param>
											<xsl:with-param name="value"><xsl:value-of select ="$manufacturerCountrySubDiv"/></xsl:with-param>
										</xsl:call-template>
									</xsl:if>
									<xsl:if test= "$manufacturerCountry!=''">
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_COUNTRY</xsl:with-param>
											<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_country</xsl:with-param>
											<xsl:with-param name="value"><xsl:value-of select ="$manufacturerCountry"/></xsl:with-param>
										</xsl:call-template>
									</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise></xsl:otherwise>
				</xsl:choose>
			 </xsl:with-param>
		</xsl:call-template>
	</xsl:template>
   
    <xd:doc>
		<xd:short>Certified Characteristics Sub-section</xd:short>
		<xd:detail>
			This templates displays Certified Characteristics sub-section.
 		</xd:detail>
 		<xd:param name="fieldPrefix">Holds the prefix for the name field.In this case it is issuer</xd:param>
 		<xd:param name="certfdChrtcsOrgn">Name of the country of the origin of goods <b>Mandatory</b></xd:param>
  		<xd:param name="certfdChrtcsQlty">Quality of the goods.<b>Mandatory</b></xd:param>
  		<xd:param name="certfdChrtcsAnlys">Analysis of the goods.<b>Mandatory</b>.</xd:param>
  		<xd:param name="certfdChrtcsWghtUnit">Weight of the goods measured in unit.<b>Mandatory</b></xd:param>
  		<xd:param name="certfdChrtcsWghtOthrUnit">Identifies the unit of measure<b>Mandatory</b></xd:param>
  		<xd:param name="certfdChrtcsWghtValue">Quantity of a product on a line specified by a number.<b>Mandatory</b></xd:param>
  		<xd:param name="certfdChrtcsWghtFactor"> Multiplication factor of measurement values.<b>Mandatory</b></xd:param>
  		<xd:param name="certfdChrtcsQtyUnitOfMeasrCode">Specifies the unit of measurement. <b>Mandatory</b></xd:param>
  		<xd:param name="certfdChrtcsQtyOthrUnitOfMeasr">Identifies the unit of measure not present in the code list.<b>Mandatory</b></xd:param>
  		<xd:param name="certfdChrtcsQtyValue">Quantity of a product on a line specified by a number.<b>Mandatory</b></xd:param>
  		<xd:param name="certfdChrtcsQtyFactor">Multiplication factor of measurement values.</xd:param>
  		<xd:param name="certfdChrtcsHealthIndctn">Indicates if the goods have passed the health check.<b>Mandatory</b></xd:param>
  		<xd:param name="certfdChrtcsPhytosntryIndctn">Indicates if the goods have passed the phytosanitary check.<b>Mandatory</b></xd:param>
  	</xd:doc>
   	<xsl:template name="certified-characteristics">
		<xsl:param name="fieldPrefix"/>
		<xsl:param name="certfdChrtcsOrgn"/>
		<xsl:param name="certfdChrtcsQlty"/>
		<xsl:param name="certfdChrtcsAnlys"/>
		<xsl:param name="certfdChrtcsWghtUnit"/>
		<xsl:param name="certfdChrtcsWghtOthrUnit"/>
		<xsl:param name="certfdChrtcsWghtValue"/>
		<xsl:param name="certfdChrtcsWghtFactor"/>
		<xsl:param name="certfdChrtcsQtyUnitOfMeasrCode"/>
		<xsl:param name="certfdChrtcsQtyOthrUnitOfMeasr"/>
		<xsl:param name="certfdChrtcsQtyValue"/>
		<xsl:param name="certfdChrtcsQtyFactor"/>
		<xsl:param name="certfdChrtcsHealthIndctn"/>
		<xsl:param name="certfdChrtcsPhytosntryIndctn"/>
		<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_DETAILS_PO_CERTIFIED_CHARACTERISTICS</xsl:with-param>
		<xsl:with-param name="legend-type">indented-header</xsl:with-param>
		<xsl:with-param name="toc-item">N</xsl:with-param>
			<xsl:with-param name="content">
			<xsl:choose>
				<xsl:when test="$displaymode = 'edit'">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_DETAILS_PO_CERTIFIED_CHARACTERISTICS_ORIGIN</xsl:with-param>
						<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_payment_ceds_certfdchrtcs_origin</xsl:with-param>
	            	</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_DETAILS_PO_CERTIFIED_CHARACTERISTICS_QUALITY</xsl:with-param>
						<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_payment_ceds_certfdchrtcs_qlty</xsl:with-param>
	            	</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_DETAILS_PO_CERTIFIED_CHARACTERISTICS_ANALYSIS</xsl:with-param>
						<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_payment_ceds_certfdchrtcs_anlys</xsl:with-param>
	            	</xsl:call-template>
					<xsl:call-template name="fieldset-wrapper">
				    <xsl:with-param name="legend">XSL_DETAILS_PO_CERTIFIED_CHARACTERISTICS_WEIGHT</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="toc-item">N</xsl:with-param>
					<xsl:with-param name="content">	
						<xsl:call-template name="input-field">
                               <xsl:with-param name="label">XSL_DETAILS_PO_CERTIFIED_CHARACTERISTICS_WEIGHT_UNIT</xsl:with-param>
                               <xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_payment_ceds_certfdchrtcs_wt_unit</xsl:with-param>
                               <xsl:with-param name="required">Y</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
                               <xsl:with-param name="label">XSL_DETAILS_PO_CERTIFIED_CHARACTERISTICS_WEIGHT_OTHRUNIT</xsl:with-param>
                               <xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_payment_ceds_certfdchrtcs_wt_othrunit</xsl:with-param>
                               <xsl:with-param name="required">Y</xsl:with-param>
                        </xsl:call-template>					
						<xsl:call-template name="input-field">
                               <xsl:with-param name="label">XSL_DETAILS_PO_CERTIFIED_CHARACTERISTICS_WEIGHT_VAL</xsl:with-param>
                               <xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_payment_ceds_certfdchrtcs_wt_val</xsl:with-param>
                               <xsl:with-param name="required">Y</xsl:with-param>
						</xsl:call-template>	
	               		<xsl:call-template name="input-field">
                               <xsl:with-param name="label">XSL_DETAILS_PO_CERTIFIED_CHARACTERISTICS_WEIGHT_FACTOR</xsl:with-param>
                               <xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_payment_ceds_certfdchrtcs_wt_fctr</xsl:with-param>
						</xsl:call-template>	
            		 </xsl:with-param>
	          	</xsl:call-template>
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_DETAILS_PO_CERTIFIED_CHARACTERISTICS_QUANTITY</xsl:with-param>
						<xsl:with-param name="legend-type">indented-header</xsl:with-param>
						<xsl:with-param name="toc-item">N</xsl:with-param>
						<xsl:with-param name="content">	
							<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_CERTIFIED_CHARACTERISTICS_QUANTITY_UNITOFMEASRCODE</xsl:with-param>
									<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_payment_ceds_certfdchrtcs_qty_unitofmeasrcode</xsl:with-param>
									<xsl:with-param name="required">Y</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_CERTIFIED_CHARACTERISTICS_QUANTITY_OTHRUNITOFMEASR</xsl:with-param>
									<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_payment_ceds_certfdchrtcs_qty_othrunitofmeasr</xsl:with-param>
									<xsl:with-param name="required">Y</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_CERTIFIED_CHARACTERISTICS_QUANTITY_VALUE</xsl:with-param>
									<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_payment_ceds_certfdchrtcs_qty_val</xsl:with-param>
									<xsl:with-param name="required">Y</xsl:with-param>
									<xsl:with-param name="maxsize">35</xsl:with-param>
							</xsl:call-template>
							<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_CERTIFIED_CHARACTERISTICS_QUANTITY_FACTOR</xsl:with-param>
									<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_payment_ceds_certfdchrtcs_qty_factor</xsl:with-param>
									<xsl:with-param name="maxsize">15</xsl:with-param>
							</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>	
				<xsl:call-template name="input-field">
				     <xsl:with-param name="label">XSL_DETAILS_PO_CERTIFIED_CHARACTERISTICS_HEALTH_INDICATION</xsl:with-param>
				     <xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_payment_ceds_health_indctn_flag</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
				     <xsl:with-param name="label">XSL_DETAILS_PO_CERTIFIED_CHARACTERISTICS_PHYTO_SANITARY_INDICATION</xsl:with-param>
				     <xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_payment_ceds_phyto_sntry_indctn_flag</xsl:with-param>
				</xsl:call-template>
				</xsl:when>
				<xsl:when test="$displaymode='view'">
					 <xsl:if test="$certfdChrtcsOrgn !=''">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DETAILS_PO_CERTIFIED_CHARACTERISTICS_ORIGIN</xsl:with-param>
							<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_payment_ceds_certfdchrtcs_origin</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select ="$certfdChrtcsOrgn"/></xsl:with-param>
						</xsl:call-template>
	            	</xsl:if>
	            	 <xsl:if test="$certfdChrtcsQlty !=''">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DETAILS_PO_CERTIFIED_CHARACTERISTICS_QUALITY</xsl:with-param>
							<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_payment_ceds_certfdchrtcs_qlty</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select ="$certfdChrtcsQlty"/></xsl:with-param>
		            	</xsl:call-template>
		            </xsl:if>	
		            <xsl:if test="$certfdChrtcsAnlys !=''">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DETAILS_PO_CERTIFIED_CHARACTERISTICS_ANALYSIS</xsl:with-param>
							<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_payment_ceds_certfdchrtcs_anlys</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select ="$certfdChrtcsQlty"/></xsl:with-param>
						</xsl:call-template>
					</xsl:if>	
					<xsl:call-template name="fieldset-wrapper">
				    <xsl:with-param name="legend">XSL_DETAILS_PO_CERTIFIED_CHARACTERISTICS_WEIGHT</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="toc-item">N</xsl:with-param>
					<xsl:with-param name="content">	
					<xsl:if test="$certfdChrtcsWghtUnit != ''">
						<xsl:call-template name="input-field">
                               <xsl:with-param name="label">XSL_DETAILS_PO_CERTIFIED_CHARACTERISTICS_WEIGHT_UNIT</xsl:with-param>
                               <xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_payment_ceds_certfdchrtcs_wt_unit</xsl:with-param>
                               <xsl:with-param name="value"><xsl:value-of select ="$certfdChrtcsWghtUnit"/></xsl:with-param>
                               <xsl:with-param name="required">Y</xsl:with-param>
						</xsl:call-template>
					</xsl:if>	
					<xsl:if test="$certfdChrtcsWghtOthrUnit != ''">
						<xsl:call-template name="input-field">
                               <xsl:with-param name="label">XSL_DETAILS_PO_CERTIFIED_CHARACTERISTICS_WEIGHT_OTHRUNIT</xsl:with-param>
                               <xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_payment_ceds_certfdchrtcs_wt_othrunit</xsl:with-param>
                               <xsl:with-param name="value"><xsl:value-of select ="$certfdChrtcsWghtOthrUnit"/></xsl:with-param>
                               <xsl:with-param name="required">Y</xsl:with-param>
                        </xsl:call-template>
                    </xsl:if> 
                    <xsl:if test="$certfdChrtcsWghtValue != ''">					
						<xsl:call-template name="input-field">
                               <xsl:with-param name="label">XSL_DETAILS_PO_CERTIFIED_CHARACTERISTICS_WEIGHT_VAL</xsl:with-param>
                               <xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_payment_ceds_certfdchrtcs_wt_val</xsl:with-param>
                               <xsl:with-param name="value"><xsl:value-of select ="$certfdChrtcsWghtValue"/></xsl:with-param>
                               <xsl:with-param name="required">Y</xsl:with-param>
						</xsl:call-template>
					</xsl:if>	
					<xsl:if test="$certfdChrtcsWghtFactor != ''">	
	               		<xsl:call-template name="input-field">
                               <xsl:with-param name="label">XSL_DETAILS_PO_CERTIFIED_CHARACTERISTICS_WEIGHT_FACTOR</xsl:with-param>
                               <xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_payment_ceds_certfdchrtcs_wt_fctr</xsl:with-param>
                               <xsl:with-param name="value"><xsl:value-of select ="$certfdChrtcsWghtFactor"/></xsl:with-param>
						</xsl:call-template>	
					</xsl:if>	
            	 </xsl:with-param>
	          	</xsl:call-template>
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_DETAILS_PO_CERTIFIED_CHARACTERISTICS_QUANTITY</xsl:with-param>
						<xsl:with-param name="legend-type">indented-header</xsl:with-param>
						<xsl:with-param name="toc-item">N</xsl:with-param>
						<xsl:with-param name="content">	
							<xsl:if test="$certfdChrtcsQtyUnitOfMeasrCode != ''">
								<xsl:call-template name="input-field">
										<xsl:with-param name="label">XSL_DETAILS_PO_CERTIFIED_CHARACTERISTICS_QUANTITY_UNITOFMEASRCODE</xsl:with-param>
										<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_payment_ceds_certfdchrtcs_qty_unitofmeasrcode</xsl:with-param>
										<xsl:with-param name="value"><xsl:value-of select ="$certfdChrtcsQtyUnitOfMeasrCode"/></xsl:with-param>
										<xsl:with-param name="required">Y</xsl:with-param>
								</xsl:call-template>
							</xsl:if>	
							<xsl:if test="$certfdChrtcsQtyOthrUnitOfMeasr != ''">
								<xsl:call-template name="input-field">
										<xsl:with-param name="label">XSL_DETAILS_PO_CERTIFIED_CHARACTERISTICS_QUANTITY_OTHRUNITOFMEASR</xsl:with-param>
										<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_payment_ceds_certfdchrtcs_qty_othrunitofmeasr</xsl:with-param>
										<xsl:with-param name="value"><xsl:value-of select ="$certfdChrtcsQtyOthrUnitOfMeasr"/></xsl:with-param>
										<xsl:with-param name="required">Y</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="$certfdChrtcsQtyValue != ''">	
								<xsl:call-template name="input-field">
										<xsl:with-param name="label">XSL_DETAILS_PO_CERTIFIED_CHARACTERISTICS_QUANTITY_VALUE</xsl:with-param>
										<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_payment_ceds_certfdchrtcs_qty_val</xsl:with-param>
										<xsl:with-param name="value"><xsl:value-of select ="$certfdChrtcsQtyValue"/></xsl:with-param>
										<xsl:with-param name="required">Y</xsl:with-param>
										<xsl:with-param name="maxsize">35</xsl:with-param>
										<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
								</xsl:call-template>
							</xsl:if>	
							<xsl:if test="$certfdChrtcsQtyFactor != ''">	
								<xsl:call-template name="input-field">
										<xsl:with-param name="label">XSL_DETAILS_PO_CERTIFIED_CHARACTERISTICS_QUANTITY_FACTOR</xsl:with-param>
										<xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_payment_ceds_certfdchrtcs_qty_factor</xsl:with-param>
										<xsl:with-param name="value"><xsl:value-of select ="$certfdChrtcsQtyFactor"/></xsl:with-param>
										<xsl:with-param name="maxsize">15</xsl:with-param>
								</xsl:call-template>
							</xsl:if>	
					</xsl:with-param>
				</xsl:call-template>
				<xsl:if test="$certfdChrtcsHealthIndctn != ''">	
					<xsl:call-template name="input-field">
					     <xsl:with-param name="label">XSL_DETAILS_PO_CERTIFIED_CHARACTERISTICS_HEALTH_INDICATION</xsl:with-param>
					     <xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_payment_ceds_health_indctn_flag</xsl:with-param>
					     <xsl:with-param name="value"><xsl:value-of select ="$certfdChrtcsHealthIndctn"/></xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="$certfdChrtcsPhytosntryIndctn != ''">
					<xsl:call-template name="input-field">
					     <xsl:with-param name="label">XSL_DETAILS_PO_CERTIFIED_CHARACTERISTICS_PHYTO_SANITARY_INDICATION</xsl:with-param>
					     <xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_payment_ceds_phyto_sntry_indctn_flag</xsl:with-param>
					     <xsl:with-param name="value"><xsl:value-of select ="$certfdChrtcsPhytosntryIndctn"/></xsl:with-param>
					</xsl:call-template>
				</xsl:if>	
				</xsl:when>
					<xsl:otherwise></xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	
		<xd:doc>
		<xd:short>Payment Cerificate Authorised Inspection Indicator</xd:short>
		<xd:detail>
			This templates displays Payment Cerificate Authorised Inspection Indicator
 		</xd:detail>
 		<xd:param name="paymentAthrsdInspctnInd">Payment Cerificate Authorised Inspection Indicator, indicates that the inspection has been performed by an authorised inspector </xd:param>
 	</xd:doc>
 	<xsl:template name="payment-Authorised-Inspection-Indicator">
 		<xsl:param name="paymentAthrsdInspctnInd"/>
 		<xsl:choose>
 			<xsl:when test="$displaymode='edit'">
					<xsl:if test= "$paymentAthrsdInspctnInd !=''">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_DETAILS_AUTHRSD_INSPCTN_IND</xsl:with-param>
								<xsl:with-param name="name">payment_po_authorised_inspctn_ind</xsl:with-param>
							</xsl:call-template>
					</xsl:if>
				</xsl:when>
				<xsl:when test="$displaymode='view'">
					<xsl:if test= "$paymentAthrsdInspctnInd !=''">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_DETAILS_AUTHRSD_INSPCTN_IND</xsl:with-param>
								<xsl:with-param name="name">payment_po_authorised_inspctn_ind</xsl:with-param>
								<xsl:with-param name="required">N</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select ="$paymentAthrsdInspctnInd"/></xsl:with-param>
							</xsl:call-template>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise></xsl:otherwise>
				</xsl:choose>
 	</xsl:template>
	
	
	<xd:doc>
		<xd:short>Payment Cerificate Identification</xd:short>
		<xd:detail>
			This templates displays Payment Cerificate Identification
 		</xd:detail>
 		<xd:param name="paymentCertId">Payment Cerificate Identification holds unique identifier of the document. <b>Mandatory</b></xd:param>
 	</xd:doc>
 	<xsl:template name="payment-Cert-Id">
 		<xsl:param name="paymentCertId"/>
 		<xsl:choose>
 			<xsl:when test="$displaymode='edit'">
					<xsl:if test= "$paymentCertId !=''">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_DETAILS_CERT_ID</xsl:with-param>
								<xsl:with-param name="name">payment_po_cert_id</xsl:with-param>
							</xsl:call-template>
					</xsl:if>
				</xsl:when>
				<xsl:when test="$displaymode='view'">
					<xsl:if test= "$paymentCertId !=''">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_DETAILS_CERT_ID</xsl:with-param>
								<xsl:with-param name="name">payment_po_cert_id</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select ="$paymentCertId"/></xsl:with-param>
							</xsl:call-template>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise></xsl:otherwise>
				</xsl:choose>
 	</xsl:template>
 	
 	<xd:doc>
		<xd:short>Payment Cerificate Goods Description</xd:short>
		<xd:detail>
			This templates displays Payment Goods Description
 		</xd:detail>
 		<xd:param name="paymentGoodsDesc">Payment Goods Description holds description of the goods.</xd:param>
 	</xd:doc>
 	<xsl:template name="payment-Goods-Description">
 		<xsl:param name="paymentGoodsDesc"/>
 		<xsl:choose>
 			<xsl:when test="$displaymode='edit'">
					<xsl:if test= "$paymentGoodsDesc !=''">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_DETAILS_GOODS_DESC</xsl:with-param>
								<xsl:with-param name="name">payment_ceds_po_goods_desc</xsl:with-param>
								<xsl:with-param name="maxsize">70</xsl:with-param>
								<xsl:with-param name="type">text</xsl:with-param>
								<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
							</xsl:call-template>
					</xsl:if>
				</xsl:when>
				<xsl:when test="$displaymode='view'">
					<xsl:if test= "$paymentGoodsDesc !=''">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_DETAILS_GOODS_DESC</xsl:with-param>
								<xsl:with-param name="name">payment_ceds_po_goods_desc</xsl:with-param>
								<xsl:with-param name="value"><xsl:value-of select ="$paymentGoodsDesc"/></xsl:with-param>
								<xsl:with-param name="maxsize">70</xsl:with-param>
								<xsl:with-param name="type">text</xsl:with-param>
							</xsl:call-template>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise></xsl:otherwise>
				</xsl:choose>
 	</xsl:template>

    <xd:doc>
		<xd:short>Payment Certificate Dataset</xd:short>
		<xd:detail>
			This template contains Payment Certificate dataset section .
 		</xd:detail>
	</xd:doc>
	<xsl:template name="payment-certificate-ds-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_PURCHASE_ORDER_CERTIFICATE_DATASET_DETAILS</xsl:with-param>
			<xsl:with-param name="content">
			&nbsp;
				<xsl:call-template name="build-payment-certificate-ds-details-dojo-items">
					<xsl:with-param name="items" select="payment_certificate_dataset/CertDataSet" />
					<xsl:with-param name="id" select="payment-certificate-ds" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Build Payment Certificate dataset</xd:short>
		<xd:detail>
			This templates displays header for diplaying dataset in add,edit and view mode,also displayes header of the payment certificate dataset table.
			It also adds defines variables and adds attributes of different fields in certificate dataset dialog under matcher issuer section,Properitry Id etc
			 fills it with given value.
 		</xd:detail>
 		<xd:param name="items"> Items to be build to form display</xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">display mode can be overriden in edit form.</xd:param>		
 	</xd:doc>
	<xsl:template name="build-payment-certificate-ds-details-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/>

		<div dojoType="misys.openaccount.widget.PaymentCertificateDatasetDetails" dialogId="payment-certificate-ds-details-dialog-template" id="payment-certificate-ds-details">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ADD_CERTIFICATE_DATASET')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_EDIT_CERTIFICATE_DATASET')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_VIEW_CERTIFICATE_DATASET')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of
						select="localization:getGTPString($language, 'XSL_LABEL_CERTIFICATE_TYPE')" />
			</xsl:attribute>
			<xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="CertDataSet" select="." />
					<div dojoType="misys.openaccount.widget.PaymentCertificateDatasetDetail">
						<xsl:attribute name="payment_ceds_cert_type"><xsl:value-of select="$CertDataSet/CertTp"/></xsl:attribute>
						<div dojoType="misys.openaccount.widget.PaymentCertificateAddtnlInfs">
							<xsl:for-each select="$CertDataSet/AddtlInf">
								<div dojoType="misys.openaccount.widget.PaymentCertificateAddtnlInf">
									<xsl:attribute name="payment_ceds_addtl_inf"><xsl:value-of select="."/></xsl:attribute>
								</div>
							</xsl:for-each>
						</div>
						<div dojoType="misys.openaccount.widget.PaymentCertificateLineItems">
							<xsl:for-each select="$CertDataSet/LineItm">
								<xsl:variable name="LineItm" select="." />
								<div dojoType="misys.openaccount.widget.PaymentCertificateLineItem">
									<xsl:attribute name="purchaseOrderRefId"><xsl:value-of select="$LineItm/PurchsOrdrRef/Id"/></xsl:attribute>
									<xsl:attribute name="purchaseOrderIssDate"><xsl:value-of select="tools:convertISODate2MTPDate($LineItm/PurchsOrdrRef/DtOfIsse,'en')" /></xsl:attribute>
									<div dojoType="misys.openaccount.widget.PaymentCertificateLineItemIdentifications">
											<xsl:for-each select="$LineItm/LineItmId">
												<xsl:variable name="LineItmId" select="." />
												<div dojoType="misys.openaccount.widget.PaymentCertificateLineItemIdentification">
													<xsl:attribute name="payment_ceds_line_item_id"><xsl:value-of select="$LineItmId"/></xsl:attribute>
												</div>
											</xsl:for-each>
									</div>
								</div>
							</xsl:for-each>
						</div>
					</div>
				</xsl:for-each>
			</xsl:if>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Payment Certificate Dataset detail declaration</xd:short>
		<xd:detail>
			This templates displays no payment certificate dataset message if there is no value in payment certificate dataset or adds button to add a payment certificate dataset.
 		</xd:detail>		
 	</xd:doc>
	<xsl:template name="payment-certificate-ds-details-declaration">
		<xsl:call-template name="payment-certificate-ds-details-dialog-declaration" />
		<div id="payment-certificate-ds-details-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_DETAILS_PO_NO_CERTIFICATE_DATASET')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_PURCHASE_ORDER_ADD_CERTIFICATE_DATASET')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Payment Certificate Dataset dialog declaration</xd:short>
		<xd:detail>
			This templates displays labels for BIC,Certificate type,match issuer(name and country) etc and sets its parameters such as name,value,size of these field.
			This template also adds button cancel and OK button in dialog box.
 		</xd:detail>		
 	</xd:doc>
	<xsl:template name="payment-certificate-ds-details-dialog-declaration">
		<div id="payment-certificate-ds-details-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
			<div class="standardPODialogContent">
				<xsl:variable name="code_type"><xsl:value-of select="payment_certificate_dataset/CertDataSet/CertTp"></xsl:value-of></xsl:variable>
				<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
				<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
				<xsl:variable name="parameterId">C021</xsl:variable>
				<xsl:choose>
					<xsl:when test="$displaymode='view' ">
						<xsl:if test="payment_certificate_dataset/CertDataSet/CertTp[.!='']">
								<xsl:call-template name="input-field">
								 	<xsl:with-param name="label">XSL_DETAILS_PO_CERTIFICATE_TYPE</xsl:with-param>
								 	<xsl:with-param name="name">payment_ceds_cert_type</xsl:with-param>
								 	<xsl:with-param name="value"><xsl:value-of select="payment_certificate_dataset/CertDataSet/CertTp"/></xsl:with-param>
								 	<xsl:with-param name="override-displaymode">edit</xsl:with-param>
								 	<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>	
								</xsl:call-template>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="select-field">
							<xsl:with-param name="label">XSL_DETAILS_PO_CERTIFICATE_TYPE</xsl:with-param>
							<xsl:with-param name="name">payment_ceds_cert_type</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="required">N</xsl:with-param>
							<xsl:with-param name="options">
								 <xsl:call-template name="ceds-cert-type-codes" />
							</xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
			  	</xsl:choose>
			  	
			  	<!-- Inspection Date -->
			  	<xsl:call-template name="payment-Authorised-Inspection-Indicator">
					<xsl:with-param name="paymentAthrsdInspctnInd"><xsl:value-of select="payment_certificate_dataset/CertDataSet/AuthrsdInspctrInd"/></xsl:with-param>
				</xsl:call-template>
					        
		        <!-- Certificate Identification -->
		        <xsl:call-template name="payment-Cert-Id">
					<xsl:with-param name="paymentCertId"><xsl:value-of select="payment_certificate_dataset/CertDataSet/CertId"/></xsl:with-param>
				</xsl:call-template>
		        
		       <!--  Goods Description -->
		        <xsl:call-template name="payment-Goods-Description">
					<xsl:with-param name="paymentgoodsdesc"><xsl:value-of select="payment_certificate_dataset/CertDataSet/GoodsDesc"/></xsl:with-param>
				</xsl:call-template>
		    		      	
		       	<!--Issue Date -->
			 	<xsl:call-template name="date-details">
			 		<xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
			 		<xsl:with-param name="fieldPrefix">issue</xsl:with-param>
			 		<xsl:with-param name="date"><xsl:value-of select="payment_certificate_dataset/CertDataSet/IsseDt"/></xsl:with-param>
			 	</xsl:call-template>
          		
          		<!-- Data Set Identifications    -->      	   		
				<xsl:call-template name="dataset-identification">
                    <xsl:with-param name="fieldPrefix">certificate</xsl:with-param>
                    <xsl:with-param name="dataSetId"><xsl:value-of select="payment_certificate_dataset/CertDataSet/DataSetId/Id"/></xsl:with-param>
                    <xsl:with-param name="dataSetVersion"><xsl:value-of select="payment_certificate_dataset/CertDataSet/DataSetId/Vrsn"/></xsl:with-param>
                    <xsl:with-param name="dataSetSubmitterBic"><xsl:value-of select="payment_certificate_dataset/CertDataSet/DataSetId/Submitr/BIC"/></xsl:with-param>
                </xsl:call-template>
                 
             	 <!--  Calling Payment Certificate Line Item  -->
                <xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_PAYMENT_CERTIFICATE_LINE_ITEMS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="toc-item">N</xsl:with-param>
					<xsl:with-param name="content">
						&nbsp;
						<xsl:call-template name="build-payment-certificate-line-item-dojo-items">
							<xsl:with-param name="id">line_item_payment_certificate</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				
				<!-- Certified Characteristics -->
				<xsl:call-template name="certified-characteristics">
                    <xsl:with-param name="fieldPrefix">certificate</xsl:with-param>
                    <xsl:with-param name="certfdChrtcsOrgn"><xsl:value-of select="payment_certificate_dataset/CertDataSet/CertfdChrtcs/Orgn"/></xsl:with-param>
                    <xsl:with-param name="certfdChrtcsQlty"><xsl:value-of select="payment_certificate_dataset/CertDataSet/CertfdChrtcs/Qlty"/></xsl:with-param>
                    <xsl:with-param name="certfdChrtcsAnlys"><xsl:value-of select="payment_certificate_dataset/CertDataSet/CertfdChrtcs/Anlys"/></xsl:with-param>
					<xsl:with-param name="certfdChrtcsWghtUnit"><xsl:value-of select="payment_certificate_dataset/CertDataSet/CertfdChrtcs/Wght/UnitOfMeasrCd"/></xsl:with-param>
                    <xsl:with-param name="certfdChrtcsWghtOthrUnit"><xsl:value-of select="payment_certificate_dataset/CertDataSet/CertfdChrtcs/Wght/OthrUnitOfMeasr"/></xsl:with-param>
                    <xsl:with-param name="certfdChrtcsWghtValue"><xsl:value-of select="payment_certificate_dataset/CertDataSet/CertfdChrtcs/Wght/Val"/></xsl:with-param>
					<xsl:with-param name="certfdChrtcsWghtFactor"><xsl:value-of select="payment_certificate_dataset/CertDataSet/CertfdChrtcs/Wght/Fctr"/></xsl:with-param>
                    <xsl:with-param name="certfdChrtcsQtyUnitOfMeasrCode"><xsl:value-of select="payment_certificate_dataset/CertDataSet/CertfdChrtcs/Qty/UnitOfMeasrCd"/></xsl:with-param>
                    <xsl:with-param name="certfdChrtcsQtyOthrUnitOfMeasr"><xsl:value-of select="payment_certificate_dataset/CertDataSet/CertfdChrtcs/Qty/OthrUnitOfMeasr"/></xsl:with-param>
					<xsl:with-param name="certfdChrtcsQtyValue"><xsl:value-of select="payment_certificate_dataset/CertDataSet/CertfdChrtcs/Qty/Val"/></xsl:with-param>
                    <xsl:with-param name="certfdChrtcsQtyFactor"><xsl:value-of select="payment_certificate_dataset/CertDataSet/CertfdChrtcs/Qty/Fctr"/></xsl:with-param>
					<xsl:with-param name="certfdChrtcsHealthIndctn"><xsl:value-of select="payment_certificate_dataset/CertDataSet/CertfdChrtcs/Qty/HealthIndctn"/></xsl:with-param>
					<xsl:with-param name="certfdChrtcsPhytosntryIndctn"><xsl:value-of select="payment_certificate_dataset/CertDataSet/CertfdChrtcs/Qty/PhytosntryIndctn"/></xsl:with-param>
				</xsl:call-template>
				
				<!-- Place of Issue -->
				<xsl:call-template name="place-of-issue">
					<xsl:with-param name="fieldPrefix">place_of_issue</xsl:with-param>
					<xsl:with-param name="poiStreetNm"><xsl:value-of select ="payment_certificate_dataset/CertDataSet/PlcOfIsse/StrtNm"/></xsl:with-param>
					<xsl:with-param name="poiPostCode"><xsl:value-of select ="payment_certificate_dataset/CertDataSet/PlcOfIsse/PstCdId"/></xsl:with-param>
					<xsl:with-param name="poiTownNm"><xsl:value-of select ="payment_certificate_dataset/CertDataSet/PlcOfIsse/TwnNm"/></xsl:with-param>
					<xsl:with-param name="poiCtrySubDiv"><xsl:value-of select ="payment_certificate_dataset/CertDataSet/PlcOfIsse/CtrySubDvsn"/></xsl:with-param>
					<xsl:with-param name="poiCtry"><xsl:value-of select ="payment_certificate_dataset/CertDataSet/PlcOfIsse/Ctry"/></xsl:with-param>
				</xsl:call-template>
		 
		 		<!-- Issuer Details -->
				<xsl:call-template name="issuer-details">
							<xsl:with-param name="fieldPrefix">issuer</xsl:with-param>
			              	<xsl:with-param name="issuerName"><xsl:value-of select="payment_certificate_dataset/CertDataSet/Issr/Nm"/></xsl:with-param>
			              	<xsl:with-param name="issuerPropId"><xsl:value-of select="payment_certificate_dataset/CertDataSet/Issr/PrtryId/Id"/></xsl:with-param>
			              	<xsl:with-param name="issuerPropType"><xsl:value-of select="payment_certificate_dataset/CertDataSet/Issr/PrtryId/IdTp"/></xsl:with-param>
			              	<xsl:with-param name="issuerStreetNm"><xsl:value-of select="payment_certificate_dataset/CertDataSet/Issr/PstlAdr/StrtNm"/></xsl:with-param>
			              	<xsl:with-param name="issuerPostCode"><xsl:value-of select="payment_certificate_dataset/CertDataSet/Issr/PstlAdr/PstCdId"/></xsl:with-param>
			              	<xsl:with-param name="issuerTownNm"><xsl:value-of select="payment_certificate_dataset/CertDataSet/Issr/PstlAdr/TwnNm"/></xsl:with-param>
			              	<xsl:with-param name="issuerCountrySubDiv"><xsl:value-of select="payment_certificate_dataset/CertDataSet/Issr/PstlAdr/CtrySubDvsn"/></xsl:with-param>
			              	<xsl:with-param name="issuerCountry"><xsl:value-of select="payment_certificate_dataset/CertDataSet/Issr/PstlAdr/Ctry"/></xsl:with-param>
				</xsl:call-template>
				
				<!-- Inspection Date -->
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_DETAILS_PO_INSPCTN_DATE</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="toc-item">N</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="input-field">
	                         <xsl:with-param name="label">XSL_DETAILS_INSPCTN_FR_DT</xsl:with-param>
	                         <xsl:with-param name="name">payment_ceds_po_inspctn_fr_dt</xsl:with-param>
	                         <xsl:with-param name="required">Y</xsl:with-param>
	                         <xsl:with-param name="type">date</xsl:with-param>
	                         <xsl:with-param name="value" select="tools:convertISODate2MTPDate(payment_certificate_dataset/CertDataSet/InspctnDt/FrDt,'en')"/>
	        			</xsl:call-template>
	           			<xsl:call-template name="input-field">
	                         <xsl:with-param name="label">XSL_DETAILS_INSPCTN_TO_DT</xsl:with-param>
	                         <xsl:with-param name="name">payment_ceds_po_inspctn_to_dt</xsl:with-param>
	                         <xsl:with-param name="required">Y</xsl:with-param>
	                         <xsl:with-param name="type">date</xsl:with-param>
	                         <xsl:with-param name="value" select="tools:convertISODate2MTPDate(payment_certificate_dataset/CertDataSet/InspctnDt/ToDt,'en')"/>
	           			</xsl:call-template>				
					</xsl:with-param>
				</xsl:call-template>
				
				<!-- Certificate Routing Summary details -->
				<xsl:call-template name="payment-certificate-routing-summary-details"></xsl:call-template>
				
				<!-- Manufacturer Details -->
				<xsl:call-template name="manufacturer-details">
							<xsl:with-param name="fieldPrefix">manufacturer</xsl:with-param>
			              	<xsl:with-param name="manufacturerName"><xsl:value-of select="payment_certificate_dataset/CertDataSet/Manfctr/Nm"/></xsl:with-param>
			              	<xsl:with-param name="manufacturerPropId"><xsl:value-of select="payment_certificate_dataset/CertDataSet/Manfctr/PrtryId/Id"/></xsl:with-param>
			              	<xsl:with-param name="manufacturerPropType"><xsl:value-of select="payment_certificate_dataset/CertDataSet/Manfctr/PrtryId/IdTp"/></xsl:with-param>
			              	<xsl:with-param name="manufacturerStreetNm"><xsl:value-of select="payment_certificate_dataset/CertDataSet/Manfctr/PstlAdr/StrtNm"/></xsl:with-param>
			              	<xsl:with-param name="manufacturerPostCode"><xsl:value-of select="payment_certificate_dataset/CertDataSet/Manfctr/PstlAdr/PstCdId"/></xsl:with-param>
			              	<xsl:with-param name="manufacturerTownNm"><xsl:value-of select="payment_certificate_dataset/CertDataSet/Manfctr/PstlAdr/TwnNm"/></xsl:with-param>
			              	<xsl:with-param name="manufacturerCountrySubDiv"><xsl:value-of select="payment_certificate_dataset/CertDataSet/Manfctr/PstlAdr/CtrySubDvsn"/></xsl:with-param>
			              	<xsl:with-param name="manufacturerCountry"><xsl:value-of select="payment_certificate_dataset/CertDataSet/Manfctr/PstlAdr/Ctry"/></xsl:with-param>
				</xsl:call-template>
				
				<!-- Additional Information -->
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_LABEL_ADDITIONAL_INF</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="toc-item">N</xsl:with-param>
					<xsl:with-param name="content">
						&nbsp;
						<div>
							<xsl:call-template name="build-payment-certificate-addtl-inf-dojo-items">
								<xsl:with-param name="id">payment_certificate_ds_addtl_inf</xsl:with-param>
							</xsl:call-template>
						</div>	
					</xsl:with-param>
			  </xsl:call-template>
			</div>
		</div>
	</xsl:template>
    
    
    <xd:doc>
		<xd:short>Build Payment Certificate Additional Information</xd:short>
		<xd:detail>
			This templates displays Additional Information header inside payment certificate dataset in add,edit and view mode.
			It also defines variables and adds attributes and fills it with given selected value.
 		</xd:detail>
 		<xd:param name="items"> Items to be build to form display</xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">display mode can be overriden in edit form.</xd:param>		
 	</xd:doc>
	<xsl:template name="build-payment-certificate-addtl-inf-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
		<div dojoType="misys.openaccount.widget.PaymentCertificateAddtnlInfs" dialogId="payment-certificate-addtl-inf-dialog-template">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_ADD_ADDTNL_INF')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_EDIT_ADDTNL_INF')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_VIEW_ADDTNL_INF')" /></xsl:attribute>
			<xsl:attribute name="headers"><xsl:value-of select="localization:getGTPString($language, 'XSL_LABEL_ADDITIONAL_INF')" /></xsl:attribute>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
			<xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="AddtlInf" select="." />
					<div dojoType="misys.openaccount.widget.PaymentCertificateAddtnlInf">
						<xsl:attribute name="payment_ceds_addtl_inf"><xsl:value-of select="$AddtlInf"/></xsl:attribute>
					</div>
				</xsl:for-each>
			</xsl:if>
		</div>
	</xsl:template>
	
    <xd:doc>
		<xd:short>Build Payment Certificate dataset Addnl info</xd:short>
		<xd:detail>
			This templates adds BIC field id attributes in certificate dataset and fills it with value from BIC.
		</xd:detail>		
 	</xd:doc>
	<xsl:template match="payment_certificate_dataset/CertDataSet/AddtlInf">
		<div dojoType="misys.openaccount.widget.PaymentCertificateAddtnlInf">
			<xsl:attribute name="payment_ceds_addtl_inf"><xsl:value-of select="AddtlInf"/></xsl:attribute>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Payment Certificate Additional Information dialog declaration</xd:short>
		<xd:detail>
			This templates adds attribute title and fills it with Confirmation value,It also calls input field template for Additional Information in certificate dialog
			and sets it parameters with different value.it also adds button of OK and CANCEL in the dialog box.
 		</xd:detail>	
 	</xd:doc>
	<xsl:template name="payment-certificate-addtl-inf-dialog-declaration">
		<div id="payment-certificate-addtl-inf-dialog-template" style="display:none"
			class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>

					<div>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_DETAILS_ADDITIONAL_INF</xsl:with-param>
						<xsl:with-param name="name">payment_ceds_addtl_inf</xsl:with-param>
						<xsl:with-param name="override-displaymode">edit</xsl:with-param>
						<xsl:with-param name="size">350</xsl:with-param>
						<xsl:with-param name="maxsize">350</xsl:with-param>
						<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">N</xsl:if></xsl:with-param>
						<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
						<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
					</xsl:call-template>
					<div class="dijitDialogPaneActionBar">
					<xsl:call-template name="label-wrapper">
						<xsl:with-param name="content">
							<button type="button" dojoType="dijit.form.Button">
								<xsl:attribute name="onmouseup">dijit.byId('payment-certificate-addtl-inf-dialog-template').hide();</xsl:attribute>
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
							</button>							
							<xsl:if test="$displaymode = 'edit'">
								<button dojoType="dijit.form.Button">
									<xsl:attribute name="onClick">dijit.byId('payment-certificate-addtl-inf-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
								</button>
							</xsl:if>
						</xsl:with-param>
					</xsl:call-template>
					</div>
					</div>
				</div>
	</xsl:template>	
	
	<xd:doc>
		<xd:short>Payment Certificate Additional Information declaration</xd:short>
		<xd:detail>
			This templates displays message NO Additional Information if no Additional Information is there or provide a button to ADD Additional Information in dialog box
 		</xd:detail>		
 	</xd:doc>
	<xsl:template name="payment-certificate-addtl-inf-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="payment-certificate-addtl-inf-dialog-declaration" />
		<!-- Dialog End -->
		<div id="payment-certificate-addtl-inf-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_NO_ADDTNL_INF')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_ADD_ADDTNL_INF')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	<!-- Payment Certificate Additional Info widget ends here  -->
	
	<!-- Payment Certificate LineItem widget starts from here  -->
	
	  <xd:doc>
		<xd:short>Payment Certificate Line Item Declaration</xd:short>
		<xd:detail>
			This template displayes message if there is no Line Item and adds button to add Line Item. 
 		</xd:detail>
 	</xd:doc>
	<xsl:template name="payment-certificate-line-item-declaration">
		
		<xsl:call-template name="payment-certificate-line-item-dialog-declaration" />
		
		<div id="payment-certificate-line-item-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_DETAILS_PO_NO_LINE_ITEM')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_LINE_ITEM')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	<!-- Building the dojo items for payment certificate Line Items -->
	
	<xd:doc>
		<xd:short>Payment Certificate Line Item dojo items </xd:short>
			<xd:detail>
				This selects values to add,update or view the Payment Certificate Line Item,it also adds different attributes to widget Payment Certificate Line Item.
	 		</xd:detail>
 		<xd:param name="items"> Items to be build to form display </xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">Overridden display mode.</xd:param>
 	</xd:doc>
	<xsl:template name="build-payment-certificate-line-item-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->

		<div dojoType="misys.openaccount.widget.PaymentCertificateLineItems" dialogId="payment-certificate-line-item-dialog-template">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_ADD_LINE_ITEM')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_EDIT_LINE_ITEM')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_VIEW_LINE_ITEM')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'PO_REFERENCE')" />,
				<xsl:value-of select="localization:getGTPString($language, 'PO_ISSUE_DATE')" />
			</xsl:attribute>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
			<xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="LineItm" select="." />
						<div dojoType="misys.openaccount.widget.PaymentCertificateLineItem">
							<xsl:attribute name="purchaseOrderRefId"><xsl:value-of select="$LineItm/PurchsOrdrRef/Id" /></xsl:attribute>
							<xsl:attribute name="purchaseOrderIssDate"><xsl:value-of select="$LineItm/PurchsOrdrRef/DtOfIsse" /></xsl:attribute>
									<div dojoType="misys.openaccount.widget.PaymentCertificateLineItemIdentifications">
											<xsl:for-each select="$LineItm/LineItmId">
												<div dojoType="misys.openaccount.widget.PaymentCertificateLineItemIdentification">
													<xsl:attribute name="payment_ceds_line_item_id"><xsl:value-of select="."/></xsl:attribute>
												</div>
											</xsl:for-each>
									</div>
						</div>
				</xsl:for-each>
			</xsl:if>
		</div>
	</xsl:template>
	
	<!-- Template for the declaration of Payment Certificate line items -->
	
	<xd:doc>
		<xd:short>Payment Certificate Line Items Dialog</xd:short>
		<xd:detail>
			This template calls various templates and sets different parameters of these different field.Also adds OK and CANCEL button at end of dialog
 		</xd:detail>
 		<xd:param name="field-name">Name of the field in the form submission</xd:param>
	</xd:doc>
	<xsl:template name="payment-certificate-line-item-dialog-declaration">
		<div id="payment-certificate-line-item-dialog-template" style="display:none"
			class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
				<div class="standardPODialogContent">
					<div>
						<!-- PO Reference ID -->
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_HEADER_PAYMENT_CERTIFICATE_PO_REF_ID</xsl:with-param>
			                <xsl:with-param name="name">purchaseOrderRefId</xsl:with-param>
			                <xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="size">70</xsl:with-param>
							<xsl:with-param name="maxsize">70</xsl:with-param>
							<xsl:with-param name="required">Y></xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
						</xsl:call-template>
						<!-- PO Issue Date -->
				        <xsl:call-template name="input-field">
		                    <xsl:with-param name="label">XSL_HEADER_PAYMENT_CERTIFICATE_PO_ISSUE_DATE</xsl:with-param>
		                    <xsl:with-param name="name">purchaseOrderIssDate</xsl:with-param>
		                    <xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="size">70</xsl:with-param>
							<xsl:with-param name="maxsize">70</xsl:with-param>
							<xsl:with-param name="required">Y></xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
				        </xsl:call-template>
				        
				       <!--  Calling dojo build for Line Item Identification  -->
						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_HEADER_PAYMENT_CERTIFICATE_LINE_ITEM_IDENTIFICATION</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="toc-item">N</xsl:with-param>
							<xsl:with-param name="content">
									&nbsp;
								<xsl:call-template name="build-payment-certificate-line-item-identification-dojo-items">
									<xsl:with-param name="id">line_item_id_payment_certificate</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						<div class="dijitDialogPaneActionBar">
							<xsl:call-template name="label-wrapper">
								<xsl:with-param name="content">
									<button type="button" dojoType="dijit.form.Button">
										<xsl:attribute name="onmouseup">dijit.byId('payment-certificate-line-item-dialog-template').hide();</xsl:attribute>
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
									</button>
									<xsl:if test="$displaymode = 'edit'">
										<button dojoType="dijit.form.Button">
											<xsl:attribute name="onClick">dijit.byId('payment-certificate-line-item-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
										</button>
									</xsl:if>								
								</xsl:with-param>
							</xsl:call-template>
						</div>
				     </div>  						
				</div>
		</div>
    </xsl:template>
    
    <!-- Templates for Line Item identification starts here -->
	
	<xd:doc>
		<xd:short>Build Payment Certificate Line Item identification</xd:short>
		<xd:detail>
			This templates displays Line Item identification header inside payment certificate dataset in add,edit and view mode.
			It also defines variables and adds attributes and fills it with given selected value.
 		</xd:detail>
 		<xd:param name="items"> Items to be build to form display</xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">display mode can be overriden in edit form.</xd:param>		
 	</xd:doc>
	<xsl:template name="build-payment-certificate-line-item-identification-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
		<div dojoType="misys.openaccount.widget.PaymentCertificateLineItemIdentifications" dialogId="payment-certificate-line-item-id-dialog-template">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_ADD_LINE_ITEM_ID')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_EDIT_LINE_ITEM_ID')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_VIEW_LINE_ITEM_ID')" /></xsl:attribute>
			<xsl:attribute name="headers"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PAYMENT_CERTIFICATE_LINE_ITEM_IDENTIFICATION')" /></xsl:attribute>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
			<xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="LineItmId" select="." />
					<div dojoType="misys.openaccount.widget.PaymentCertificateLineItemIdentification">
						<xsl:attribute name="payment_ceds_line_item_id"><xsl:value-of select="$LineItmId"/></xsl:attribute>
					</div>
				</xsl:for-each>
			</xsl:if>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Payment Certificate LineItem Identification declaration</xd:short>
		<xd:detail>
			This templates displays message NO LineItem Id if no LineItem Id is there or provide a button to ADD LineItem Id in dialog box
 		</xd:detail>		
 	</xd:doc>
	<xsl:template name="payment-certificate-line-item-id-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="payment-certificate-line-item-id-dialog-declaration" />
		<!-- Dialog End -->
		<div id="payment-certificate-line-item-id-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_NO_LINE_ITEM_ID')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_ADD_LINE_ITEM_ID')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Payment Certificate Line Item Identification dialog declaration</xd:short>
		<xd:detail>
			This templates adds attribute title and fills it with Confirmation value,It also calls input field template for Additional Information in certificate dialog
			and sets it parameters with different value.it also adds button of OK and CANCEL in the dialog box.
 		</xd:detail>	
 	</xd:doc>
	<xsl:template name="payment-certificate-line-item-id-dialog-declaration">
		<div id="payment-certificate-line-item-id-dialog-template" style="display:none"
			class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>

					<div>
						<!-- LineItem Identification -->
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_LABEL_LINE_ITEM_ID</xsl:with-param>
							<xsl:with-param name="name">payment_ceds_line_item_id</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="size">70</xsl:with-param>
							<xsl:with-param name="maxsize">70</xsl:with-param>
							<xsl:with-param name="required">Y></xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>
						<div class="dijitDialogPaneActionBar">
							<xsl:call-template name="label-wrapper">
								<xsl:with-param name="content">
									<button type="button" dojoType="dijit.form.Button">
										<xsl:attribute name="onmouseup">dijit.byId('payment-certificate-line-item-id-dialog-template').hide();</xsl:attribute>
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
									</button>							
									<xsl:if test="$displaymode = 'edit'">
										<button dojoType="dijit.form.Button">
											<xsl:attribute name="onClick">dijit.byId('payment-certificate-line-item-id-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
										</button>
									</xsl:if>
								</xsl:with-param>
							</xsl:call-template>
						</div>
				  </div>
				</div>
	</xsl:template>	
	
	<!-- Template for LineItem Identificaton Ends here  --> 
	
	
  	<!-- ********************************* -->
  	<!-- END : PAYMENT CERTIFICATE DATASET -->
    <!-- ********************************* -->
    
    <!-- ******************************************* -->
  	<!-- START : TRANSPORT ROUTING SUMMARY TEMPLATES -->
    <!-- ******************************************* -->
    <xsl:template name="payment-routing-summary">
		<xsl:param name="prefix"/>
		<xsl:param name="toc-item" />
		<xsl:call-template name="payment-routing-summary-individual">
			<xsl:with-param name="prefix"><xsl:value-of select="$prefix" /></xsl:with-param>
			<xsl:with-param name="toc-item" select="$toc-item"/>
			<xsl:with-param name="label">XSL_HEADER_PMT_TDS_ROUTING_SUMMARY_IND_DETAILS</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="payment-routing-summary-multimodal">
			<xsl:with-param name="prefix"><xsl:value-of select="$prefix" /></xsl:with-param>
			<xsl:with-param name="toc-item" select="$toc-item"/>
			<xsl:with-param name="label">XSL_HEADER_PMT_TDS_ROUTING_SUMMARY_MULTIMODAL_DETAILS</xsl:with-param>
		</xsl:call-template>
		
	</xsl:template>
	
	<!-- Routing summary Fieldset. -->
	<xd:doc>
		<xd:short>Payment Transport Routing Summary Individual</xd:short>
		<xd:detail>
			This templates sets parameter for Payment Transport Routing summary individual details and gets the content from template individual routing summary div
 		</xd:detail>	
 		<xd:param name="prefix">A part of identifier for the field.</xd:param>
 		<xd:param name="toc-item">A Flag that indicates whether the header section label to be added as a tic-toc content on the floating navigation widget. </xd:param>
 	</xd:doc>
	<xsl:template name="payment-routing-summary-individual">
		<xsl:param name="prefix"/>
		<xsl:param name="toc-item" />
		<xsl:param name="label">XSL_HEADER_ROUTING_SUMMARY_IND_DETAILS</xsl:param>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend" select="$label"/>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="toc-item" select="$toc-item"/>
			<xsl:with-param name="content">
				<xsl:call-template name="payment-individual-routing-summary-div">
					<xsl:with-param name="prefix"><xsl:value-of select="$prefix" /></xsl:with-param>
					<xsl:with-param name="isWidgetContainer">N</xsl:with-param>
					<xsl:with-param name="hidden">N</xsl:with-param>
					<xsl:with-param name="toc-item" select="$toc-item" />
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Payment Transport Routing Summary Multimodal</xd:short>
		<xd:detail>
			This templates sets parameter for Payment Transport Routing summary multimodal details,calls input-field template for taking in charge and place of final destination and sets different parameters
			such as name,label,value etc
 		</xd:detail>	
 		<xd:param name="prefix">A part of identifier for the field.</xd:param>
 		<xd:param name="toc-item">A Flag that indicates whether the header section label to be added as a tic-toc content on the floating navigation widget. </xd:param>
 	</xd:doc>
	<xsl:template name="payment-routing-summary-multimodal">
		<xsl:param name="prefix"/>
		<xsl:param name="toc-item" />
		<xsl:param name="label">XSL_HEADER_ROUTING_SUMMARY_MULTIMODAL_DETAILS</xsl:param>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend" select="$label"/>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="toc-item" select="$toc-item"/>
			<xsl:with-param name="content">
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_TAKING_IN_CHARGE</xsl:with-param>
					<xsl:with-param name="name">payment_transport_taking_in_charge</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="payment_transport_dataset/TrnsprtDataSet/TrnsprtInf/RtgSummry/MltmdlTrnsprt/TakngInChrg" /></xsl:with-param>
					<xsl:with-param name="size">35</xsl:with-param>
					<xsl:with-param name="maxsize">35</xsl:with-param>
					<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
				</xsl:call-template>

				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_PLACE_OF_FINAL_DEST</xsl:with-param>
					<xsl:with-param name="name">payment_transport_final_dest_place</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="payment_transport_dataset/TrnsprtDataSet/TrnsprtInf/RtgSummry/MltmdlTrnsprt/PlcOfFnlDstn" /></xsl:with-param>
					<xsl:with-param name="size">35</xsl:with-param>
					<xsl:with-param name="maxsize">35</xsl:with-param>
					<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	
	<xd:doc>
		<xd:short>Payment Transport Individual Routing summary declaration</xd:short>
		<xd:detail>
			This templates calls different templates and sets parameters of these templates
 		</xd:detail>	
 	</xd:doc>
	<xsl:template name="payment-individual-routing-summary-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="payment-individual-routing-summary-dialog-declaration"/>
		<!-- Dialog End -->
		<!-- Air  -->
		<xsl:call-template name="individual-routing-summary-generic-declaration">
			<xsl:with-param name="label-add-button">XSL_DETAILS_PO_ADD_ROUTING_SUMMARY_TRANSPORT_MODE_AIR</xsl:with-param>
			<xsl:with-param name="label-no-item">XSL_DETAILS_PO_NO_ROUTING_SUMMARY_TRANSPORT_MODE_AIR</xsl:with-param>
			<xsl:with-param name="div-id">payment-routing-summary-air-template</xsl:with-param>
		</xsl:call-template>
		<!-- Sea  -->
		 <xsl:call-template name="individual-routing-summary-generic-declaration">
			<xsl:with-param name="label-add-button">XSL_DETAILS_PO_ADD_ROUTING_SUMMARY_TRANSPORT_MODE_SEA</xsl:with-param>
			<xsl:with-param name="label-no-item">XSL_DETAILS_PO_NO_ROUTING_SUMMARY_TRANSPORT_MODE_SEA</xsl:with-param>
			<xsl:with-param name="div-id">payment-routing-summary-sea-template</xsl:with-param>
		</xsl:call-template>
		<!-- Road  -->
		<xsl:call-template name="individual-routing-summary-generic-declaration">
			<xsl:with-param name="label-add-button">XSL_DETAILS_PO_ADD_ROUTING_SUMMARY_TRANSPORT_MODE_ROAD</xsl:with-param>
			<xsl:with-param name="label-no-item">XSL_DETAILS_PO_NO_ROUTING_SUMMARY_TRANSPORT_MODE_ROAD</xsl:with-param>
			<xsl:with-param name="div-id">payment-routing-summary-road-template</xsl:with-param>
		</xsl:call-template>
		<!-- Rail -->
		<xsl:call-template name="individual-routing-summary-generic-declaration">
			<xsl:with-param name="label-add-button">XSL_DETAILS_PO_ADD_ROUTING_SUMMARY_TRANSPORT_MODE_RAIL</xsl:with-param>
			<xsl:with-param name="label-no-item">XSL_DETAILS_PO_NO_ROUTING_SUMMARY_TRANSPORT_MODE_RAIL</xsl:with-param>
			<xsl:with-param name="div-id">payment-routing-summary-rail-template</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	

	<!-- Template for the declaration of routing summary -->
	<xd:doc>
		<xd:short>Payment Transport Individual Routing summary dialog declaration</xd:short>
		<xd:detail>
			This templates calls different template of individual routing summary of different modes.
 		</xd:detail>
 		<xd:param name="toc-item">A Flag that indicates whether the header section label to be added as a tic-toc content on the floating navigation widget. </xd:param>
 	</xd:doc>
	<xsl:template name="payment-individual-routing-summary-dialog-declaration">
		<xsl:param name="toc-item">N</xsl:param>
		<xsl:call-template name="payment-individual-routing-summary-air-dialog-declaration">
			<xsl:with-param name="toc-item" select="$toc-item" />
		</xsl:call-template>
		<xsl:call-template name="payment-individual-routing-summary-sea-dialog-declaration">
			<xsl:with-param name="toc-item" select="$toc-item" />
		</xsl:call-template>
		<xsl:call-template name="payment-individual-routing-summary-road-dialog-declaration">
			<xsl:with-param name="toc-item" select="$toc-item" />
		</xsl:call-template>
		<xsl:call-template name="payment-individual-routing-summary-rail-dialog-declaration">
			<xsl:with-param name="toc-item" select="$toc-item" />
		</xsl:call-template>
	</xsl:template>
	<xd:doc>
		<xd:short>Payment Transport Individual routing summary</xd:short>
		<xd:detail>
			This templates adds different attribute and fill it with value from given field.It also sets the value of parameters of different templates called under this. 
 		</xd:detail>
 		<xd:param name="hidden">hidden field in routing summary</xd:param>
 		<xd:param name="prefix">Forms an id of the field when this is included</xd:param>
 		<xd:param name="no-items">Value from this is filled when an in no-item attribute</xd:param>
 		<xd:param name="isWidgetContainer">adds class attributes and fill it with WidgetContainer if its value is set to Y</xd:param>
 	</xd:doc>
	<xsl:template name="payment-individual-routing-summary-div">
	<xsl:param name="hidden">Y</xsl:param>
	<xsl:param name="prefix"></xsl:param>
	<xsl:param name="no-items">N</xsl:param>
	<xsl:param name="isWidgetContainer">Y</xsl:param>
	<xsl:param name="toc-item">Y</xsl:param>
	
	<xsl:variable name="airVarItems" select="payment_transport_dataset/TrnsprtDataSet/TrnsprtInf/RtgSummry/IndvTrnsprt/TrnsprtByAir"></xsl:variable>
	<xsl:variable name="seaVarItems" select="payment_transport_dataset/TrnsprtDataSet/TrnsprtInf/RtgSummry/IndvTrnsprt/TrnsprtBySea"></xsl:variable>
	<xsl:variable name="roadVarItems" select="payment_transport_dataset/TrnsprtDataSet/TrnsprtInf/RtgSummry/IndvTrnsprt/TrnsprtByRoad"></xsl:variable>
	<xsl:variable name="railVarItems" select="payment_transport_dataset/TrnsprtDataSet/TrnsprtInf/RtgSummry/IndvTrnsprt/TrnsprtByRail"></xsl:variable> 
	
	<div>
		<xsl:if test="$isWidgetContainer='Y'">
				<xsl:attribute name="class">widgetContainer</xsl:attribute>
		</xsl:if>
		<xsl:if test="$hidden='Y'">
				<xsl:attribute name="style">display:none</xsl:attribute>
		</xsl:if>
		<xsl:attribute name="id"><xsl:value-of select ="$prefix"/>payment-individual-routing-summary-div</xsl:attribute>
		<!-- Air widget -->
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_AIR</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="toc-item" select="$toc-item" />
			<xsl:with-param name="content">
			<!-- magical nbsp without it this widget is not parse!  -->
			<div>&nbsp;</div>
				<xsl:call-template name="build-payment-individual-routing-summary-dojo-items">
						<xsl:with-param name="items" select="$airVarItems"/>
						<xsl:with-param name="items-filter">01</xsl:with-param>
						<xsl:with-param name="type-filter">01</xsl:with-param>
						<xsl:with-param name="no-items"><xsl:value-of select ="$no-items"/></xsl:with-param>
						<xsl:with-param name="id"><xsl:value-of select ="$prefix"/>payment_air_routing_summaries</xsl:with-param>
						<xsl:with-param name="widget">misys.openaccount.widget.PaymentAirRoutingSummaries</xsl:with-param>
				</xsl:call-template> 
			</xsl:with-param>
		</xsl:call-template>
				
		<!-- Sea widget -->
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_SEA</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="toc-item" select="$toc-item" />
			<xsl:with-param name="content">
			<!-- magical nbsp without it this widget is not parse!  -->
			<div>&nbsp;</div>
			<xsl:call-template name="build-payment-individual-routing-summary-dojo-items">
					<xsl:with-param name="items" select="$seaVarItems"/>
					<xsl:with-param name="items-filter">02</xsl:with-param>
					<xsl:with-param name="no-items"><xsl:value-of select ="$no-items"/></xsl:with-param>
					<xsl:with-param name="type-filter">01</xsl:with-param>
					<xsl:with-param name="id"><xsl:value-of select ="$prefix"/>payment_sea_routing_summaries</xsl:with-param>
					<xsl:with-param name="widget">misys.openaccount.widget.PaymentSeaRoutingSummaries</xsl:with-param>
			</xsl:call-template> 
			</xsl:with-param>
		</xsl:call-template>
		
		<!-- Road widget -->
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_ROAD</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="toc-item" select="$toc-item" />
			<xsl:with-param name="content">
			<!-- magical nbsp without it this widget is not parse!  -->
			<div>&nbsp;</div>
			<xsl:call-template name="build-payment-individual-routing-summary-dojo-items">
					<xsl:with-param name="items" select="$roadVarItems"/>
					<xsl:with-param name="items-filter">03</xsl:with-param>
					<xsl:with-param name="no-items"><xsl:value-of select ="$no-items"/></xsl:with-param>
					<xsl:with-param name="type-filter">01</xsl:with-param>
					<xsl:with-param name="id"><xsl:value-of select ="$prefix"/>payment_road_routing_summaries</xsl:with-param>
					<xsl:with-param name="widget">misys.openaccount.widget.PaymentRoadRoutingSummaries</xsl:with-param>
			</xsl:call-template> 
			</xsl:with-param>
		</xsl:call-template>
		
		<!-- Rail widget -->
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_RAIL</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="toc-item" select="$toc-item" />
			<xsl:with-param name="content">
			<!-- magical nbsp without it this widget is not parse!  -->
			<div>&nbsp;</div>
			<xsl:call-template name="build-payment-individual-routing-summary-dojo-items">
					<xsl:with-param name="items" select="$railVarItems"/>
					<xsl:with-param name="items-filter">04</xsl:with-param>
					<xsl:with-param name="no-items"><xsl:value-of select ="$no-items"/></xsl:with-param>
					<xsl:with-param name="type-filter">01</xsl:with-param>
					<xsl:with-param name="id"><xsl:value-of select ="$prefix"/>payment_rail_routing_summaries</xsl:with-param>
					<xsl:with-param name="widget">misys.openaccount.widget.PaymentRailRoutingSummaries</xsl:with-param>
			</xsl:call-template> 
			</xsl:with-param>
		</xsl:call-template>
	</div>
	</xsl:template>

	<xd:doc>
		<xd:short>Payment Individual routing summary</xd:short>
		<xd:detail>
			This templates adds attribute and fill it with value from the given selected field based on the condition(if some condition is present).It also sets the value of parameters of different templates called under this. 
 		</xd:detail>
 		<xd:param name="items"> Items to be build to form display</xd:param>
 		<xd:param name="items-filter"> Items to be filter based on mode</xd:param>
 		<xd:param name="type-filter">Types to be filter based on mode</xd:param>
 		<xd:param name="no-items">Value from this is filled when an in no-item attribute</xd:param>
 		<xd:param name="id">Id of the form field for submission</xd:param>
 		<xd:param name="widget">This is added in dojotype</xd:param>
 		<xd:param name="override-displaymode">display mode can be overriden</xd:param>
 	</xd:doc>
	<xsl:template name="build-payment-individual-routing-summary-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="items-filter" /><!-- transport mode numbre or PLACE,FINALDEST,TAKINGIN -->
		<xsl:param name="type-filter" /><!-- transport mode numbre or PLACE,FINALDEST,TAKINGIN -->
		<xsl:param name="no-items">N</xsl:param>
		<xsl:param name="id" />
		<xsl:param name="widget"/>
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
		<div>
			<xsl:attribute name="dialogAddItemTitle">

				<!-- Dialog Header Selection for Transport Type - Individual -->
				<xsl:if test="contains($id,'payment_air_routing_summaries')">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_ROUTING_SUMMARY_TRANSPORT_MODE_AIR')" />
				</xsl:if>
				<xsl:if test="contains($id,'payment_sea_routing_summaries')">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_ROUTING_SUMMARY_TRANSPORT_MODE_SEA')" />
				</xsl:if>
				<xsl:if test="contains($id,'payment_rail_routing_summaries')">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_ROUTING_SUMMARY_TRANSPORT_MODE_RAIL')" />
				</xsl:if>
				<xsl:if test="contains($id,'payment_road_routing_summaries')">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_ROUTING_SUMMARY_TRANSPORT_MODE_ROAD')" />
				</xsl:if>
			</xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle">
				<!-- Upon Revisit/Update/Edit: Dialog Header Selection for Transport Type - Individual -->
				<xsl:if test="contains($id,'payment_air_routing_summaries')">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_EDIT_ROUTING_SUMMARY_TRANSPORT_MODE_AIR')" />
				</xsl:if>
				<xsl:if test="contains($id,'payment_sea_routing_summaries')">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_EDIT_ROUTING_SUMMARY_TRANSPORT_MODE_SEA')" />
				</xsl:if>
				<xsl:if test="contains($id,'payment_rail_routing_summaries')">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_EDIT_ROUTING_SUMMARY_TRANSPORT_MODE_RAIL')" />
				</xsl:if>
				<xsl:if test="contains($id,'payment_road_routing_summaries')">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_EDIT_ROUTING_SUMMARY_TRANSPORT_MODE_ROAD')" />
				</xsl:if>
			</xsl:attribute>
			
			<xsl:attribute name="dialogViewItemTitle">
				<!-- Upon Revisit/Update/Edit: Dialog Header Selection for Transport Type - Individual -->
				<xsl:if test="contains($id,'payment_air_routing_summaries')">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSPORT_BY_AIR_VIEW_DATASET')" />
				</xsl:if>
				<xsl:if test="contains($id,'payment_sea_routing_summaries')">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSPORT_BY_SEA_VIEW_DATASET')" />
				</xsl:if>
				<xsl:if test="contains($id,'payment_rail_routing_summaries')">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSPORT_BY_RAIL_VIEW_DATASET')" />
				</xsl:if>
				<xsl:if test="contains($id,'payment_road_routing_summaries')">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSPORT_BY_ROAD_VIEW_DATASET')" />
				</xsl:if>
			</xsl:attribute>
						
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dojoType"><xsl:value-of select="$widget" /></xsl:attribute>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
			<xsl:if test="$no-items='N'">
			 <xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="routingSummary" select="." />
						<div dojoType="misys.openaccount.widget.PaymentRoutingSummary">
							<xsl:attribute name="id"><xsl:value-of select="concat($id, '_', 'misys_openaccount_widget_RoutingSummary_', position())" /></xsl:attribute>
								<xsl:attribute name="payment_transport_air_carrier_name">
									<xsl:value-of select="$routingSummary/AirCrrierNm" />
								</xsl:attribute>
								<xsl:attribute name="payment_transport_dept_airport_code">
									<xsl:value-of select="$routingSummary/DprtureAirprt/AirprtCd" />
								</xsl:attribute>
								<xsl:attribute name="payment_transport_dept_air_town">
									<xsl:value-of select="$routingSummary/DprtureAirprt/OthrAirprtDesc/Twn" />
								</xsl:attribute>
								<xsl:attribute name="payment_transport_dept_airport_name">
									<xsl:value-of select="$routingSummary/DprtureAirprt/OthrAirprtDesc/AirprtNm" />
								</xsl:attribute>
								<xsl:attribute name="payment_transport_dest_airport_code">
									<xsl:value-of select="$routingSummary/DstnAirprt/AirprtCd" />
								</xsl:attribute>
								<xsl:attribute name="payment_transport_dest_air_town">
									<xsl:value-of select="$routingSummary/DstnAirprt/OthrAirprtDesc/Twn" />
								</xsl:attribute>
								<xsl:attribute name="payment_transport_dest_airport_name">
									<xsl:value-of select="$routingSummary/DstnAirprt/OthrAirprtDesc/AirprtNm" />
								</xsl:attribute>
								<xsl:attribute name="payment_transport_sea_carrier_name">
									<xsl:value-of select="$routingSummary/SeaCrrierNm" />
								</xsl:attribute>
								<xsl:attribute name="payment_transport_sea_loading_port">
									<xsl:value-of select="$routingSummary/PortOfLoadng" />
								</xsl:attribute>
								<xsl:attribute name="payment_transport_sea_discharge_port">
									<xsl:value-of select="$routingSummary/PortOfDschrge" />
								</xsl:attribute>
								<xsl:attribute name="payment_transport_sea_vessel_name">
									<xsl:value-of select="$routingSummary/VsslNm" />
								</xsl:attribute>
								<xsl:attribute name="payment_transport_rail_carrier_name">
									<xsl:value-of select="$routingSummary/RailCrrierNm" />
								</xsl:attribute>
								<xsl:attribute name="payment_transport_rail_place_of_receipt">
									<xsl:value-of select="$routingSummary/PlcOfRct" />
								</xsl:attribute>
								<xsl:attribute name="payment_transport_rail_place_of_delivery">
									<xsl:value-of select="$routingSummary/PlcOfDlvry" />
								</xsl:attribute>
								<xsl:attribute name="payment_transport_road_carrier_name">
									<xsl:value-of select="$routingSummary/RoadCrrierNm" />
								</xsl:attribute>
								<xsl:attribute name="payment_transport_road_place_of_receipt">
									<xsl:value-of select="$routingSummary/PlcOfRct" />
								</xsl:attribute>
								<xsl:attribute name="payment_transport_road_place_of_delivery">
									<xsl:value-of select="$routingSummary/PlcOfDlvry" />
								</xsl:attribute>
						</div>
				</xsl:for-each>
			</xsl:if>
			</xsl:if>
		</div>
	</xsl:template>
	<!-- ****************************************** -->
			<!-- Routing summary by AIR -->
	<!-- ****************************************** -->
	<xd:doc>
		<xd:short>Individual Routing Summary air dialog declaration</xd:short>
		<xd:detail>
			This templates sets parameters of different template called in this,adds OK and CANCEL button in Transport by air dialog.
 		</xd:detail>
 		<xd:param name="toc-item">A Flag that indicates whether the header section label to be added as a tic-toc content on the floating navigation widget. </xd:param>
 	</xd:doc>
	<xsl:template name="payment-individual-routing-summary-air-dialog-declaration">
		<xsl:param name="toc-item"/>
		<div id="payment-routing-summary-air-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
				<div id="payment-routing-summary-air-dialog-template" class="standardPODialogContent">
					<div>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_CARRIER_NAME</xsl:with-param>
							<xsl:with-param name="name">payment_transport_air_carrier_name</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_HEADER_DEPARTURE</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="toc-item" select="$toc-item"/>
							<xsl:with-param name="content">
								<xsl:call-template name="payment-transport-air-details">
									<xsl:with-param name="prefix">payment_transport_dept</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_HEADER_DESTINATION</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="toc-item" select="$toc-item"/>
							<xsl:with-param name="content">
								<xsl:call-template name="payment-transport-air-details">
									<xsl:with-param name="prefix">payment_transport_dest</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						
						<div class="dijitDialogPaneActionBar">
						<xsl:call-template name="label-wrapper">
							<xsl:with-param name="content">
								<button type="button" dojoType="dijit.form.Button">
									<xsl:attribute name="onmouseup">dijit.byId('payment-routing-summary-air-dialog-template').hide();</xsl:attribute>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
								</button>
								<xsl:if test="$displaymode = 'edit'">
								<button dojoType="dijit.form.Button">
									<xsl:attribute name="onClick">dijit.byId('payment-routing-summary-air-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
								</button>
								</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
						</div>
					</div>
				</div>
			</div>	
	</xsl:template>
	
	<!-- ****************************************** -->
			<!-- Routing summary by AIR -->
	<!-- ****************************************** -->
	
	<!-- ****************************************** -->
			<!-- Routing summary by SEA -->
	<!-- ****************************************** -->
	<xd:doc>
		<xd:short>Individual Routing Summary sea dialog declaration</xd:short>
		<xd:detail>
			This template add attribute title with value Confirmation,sets parameters of different template called under this template,adds OK and CANCEL button in Transport by sea dialog.
 		</xd:detail>
 		<xd:param name="toc-item">A Flag that indicates whether the header section label to be added as a tic-toc content on the floating navigation widget. </xd:param>
 	</xd:doc>
	<xsl:template name="payment-individual-routing-summary-sea-dialog-declaration">
		<xsl:param name="toc-item" />
		<div id="payment-routing-summary-sea-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
				<div id="routing-summary-sea-dialog-template-content" class="standardPODialogContent">
					<div>
						<xsl:call-template name="payment-transport-sea-details">
							<xsl:with-param name="prefix">payment_transport_sea</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
						</xsl:call-template>
						
				<div class="dijitDialogPaneActionBar">
				<xsl:call-template name="label-wrapper">
					<xsl:with-param name="content">
						<button type="button" dojoType="dijit.form.Button">
							<xsl:attribute name="onmouseup">dijit.byId('payment-routing-summary-sea-dialog-template').hide();</xsl:attribute>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
						</button>	
						<xsl:if test="$displaymode = 'edit'">						
						<button dojoType="dijit.form.Button">
							<xsl:attribute name="onClick">dijit.byId('payment-routing-summary-sea-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
						</button>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
				</div>
			</div>	
		</div>
	</div>
	</xsl:template>
	
	<!-- ****************************************** -->
			<!-- Routing summary by SEA -->
	<!-- ****************************************** -->
<!-- ****************************************** -->
			<!-- Routing summary by ROAD -->
	<!-- ****************************************** -->
	<xd:doc>
		<xd:short>Payment Transport Individual Routing Summary road dialog declaration</xd:short>
		<xd:detail>
			This templates sets parameters of different template called under this,adds OK and CANCEL button in Transport by road dialog.
 		</xd:detail>
 		<xd:param name="toc-item">A Flag that indicates whether the header section label to be added as a tic-toc content on the floating navigation widget. </xd:param>
 	</xd:doc>
	<xsl:template name="payment-individual-routing-summary-road-dialog-declaration">
		<xsl:param name="toc-item" />
		<div id="payment-routing-summary-road-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
				<div id="payment-routing-summary-road-dialog-template-content" class="standardPODialogContent">
					<div>
						<xsl:call-template name="payment-transport-road-rail-details">
							<xsl:with-param name="prefix">payment_transport_road</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
						</xsl:call-template>
					<div class="dijitDialogPaneActionBar">
						<xsl:call-template name="label-wrapper">
							<xsl:with-param name="content">
								<button type="button" dojoType="dijit.form.Button">
									<xsl:attribute name="onmouseup">dijit.byId('payment-routing-summary-road-dialog-template').hide();</xsl:attribute>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
								</button>
								<xsl:if test="$displaymode = 'edit'">								
								<button dojoType="dijit.form.Button">
									<xsl:attribute name="onClick">dijit.byId('payment-routing-summary-road-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
								</button>
								</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
					</div>
				</div>
			</div>
		</div>
	</xsl:template>
	<!-- ****************************************** -->
			<!-- Routing summary by ROAD -->
	<!-- ****************************************** -->
	<!-- ****************************************** -->
			<!-- Routing summary by RAIL -->
	<!-- ****************************************** -->
	<xd:doc>
		<xd:short>Payment Transport Individual Routing Summary rail dialog declaration</xd:short>
		<xd:detail>
			This template add attribute title with value Confirmation,sets parameters of different template called under this template,adds OK and CANCEL button in Transport by rail dialog.
 		</xd:detail>
 		<xd:param name="toc-item">A Flag that indicates whether the header section label to be added as a tic-toc content on the floating navigation widget. </xd:param>
 	</xd:doc>
	<xsl:template name="payment-individual-routing-summary-rail-dialog-declaration">
		<xsl:param name="toc-item" />
		<div id="payment-routing-summary-rail-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
				<div id="payment-routing-summary-rail-dialog-template-content" class="standardPODialogContent">
					<div>
						<xsl:call-template name="payment-transport-road-rail-details">
							<xsl:with-param name="prefix">payment_transport_rail</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
						</xsl:call-template>
						
					<div class="dijitDialogPaneActionBar">
						<xsl:call-template name="label-wrapper">
							<xsl:with-param name="content">
								<button type="button" dojoType="dijit.form.Button">
									<xsl:attribute name="onmouseup">dijit.byId('payment-routing-summary-rail-dialog-template').hide();</xsl:attribute>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
								</button>
								<xsl:if test="$displaymode = 'edit'">								
								<button dojoType="dijit.form.Button">
									<xsl:attribute name="onClick">dijit.byId('payment-routing-summary-rail-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
								</button>
								</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
					</div>
				</div>
			</div>
		</div>
	</xsl:template>
	

	<!-- ****************************************** -->
			<!-- Routing summary by RAIL -->
	<!-- ****************************************** -->
	<xd:doc>
		<xd:short>Air routing summary details template</xd:short>
		<xd:detail>
			This template defines the fields for air routing summary.
 		</xd:detail>
 		<xd:param name="prefix">Value which identifies whether it is departure or destination details.</xd:param>
 		<xd:param name="carrierNameValue">Carrier Name Value.</xd:param>
 		<xd:param name="loadingPortValue">Loading Port Value.</xd:param>
 		<xd:param name="dischargePortValue">Discharge Port Value.</xd:param>
 		<xd:param name="vesselNameValue">Vessel Name Value.</xd:param>
 		<xd:param name="override-displaymode">Value of displaymode.</xd:param>
 	</xd:doc>
	
    <xsl:template name="payment-transport-air-details">
    	<xsl:param name="prefix"/>
    	<xsl:param name="carrierNameValue"/>
    	<xsl:param name="airportCodeValue"/>
    	<xsl:param name="townValue"/>
    	<xsl:param name="airportNameValue"/>
    	<xsl:param name="override-displaymode"/>
    	<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_DETAILS_PO_ROUTING_SUMMARY_AIRPORT_CODE</xsl:with-param>
			<xsl:with-param name="name"><xsl:value-of select="$prefix"/>_airport_code</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="$airportCodeValue"/></xsl:with-param>
			<xsl:with-param name="maxsize">6</xsl:with-param>
			<xsl:with-param name="fieldsize">x-small</xsl:with-param>
			<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
			<xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
			<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_DETAILS_PO_ROUTING_SUMMARY_TOWN</xsl:with-param>
			<xsl:with-param name="name"><xsl:value-of select="$prefix"/>_air_town</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="$townValue"/></xsl:with-param>
			<xsl:with-param name="maxsize">35</xsl:with-param>
			<xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
			<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
			<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
			<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_DETAILS_PO_ROUTING_SUMMARY_AIRPORT_NAME</xsl:with-param>
			<xsl:with-param name="name"><xsl:value-of select="$prefix"/>_airport_name</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="$airportNameValue"/></xsl:with-param>
			<xsl:with-param name="maxsize">35</xsl:with-param>
			<xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
			<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
			<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
		</xsl:call-template>
    </xsl:template>
    
    <xd:doc>
		<xd:short>Rail/Road routing summary details template</xd:short>
		<xd:detail>
			This template defines the fields for road/rail routing summary.
 		</xd:detail>
 		<xd:param name="prefix">Value which identifies whether it is rail or road details.</xd:param>
 		<xd:param name="carrierNameValue">Carrier Name Value.</xd:param>
 		<xd:param name="loadingPortValue">Loading Port Value.</xd:param>
 		<xd:param name="dischargePortValue">Discharge Port Value.</xd:param>
 		<xd:param name="vesselNameValue">Vessel Name Value.</xd:param>
 		<xd:param name="override-displaymode">Value of displaymode.</xd:param>
 	</xd:doc>
    <xsl:template name="payment-transport-sea-details">
    	<xsl:param name="prefix"/>
    	<xsl:param name="carrierNameValue"/>
    	<xsl:param name="loadingPortValue"/>
    	<xsl:param name="dischargePortValue"/>
    	<xsl:param name="vesselNameValue"/>
    	<xsl:param name="override-displaymode"/>
    		<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_CARRIER_NAME</xsl:with-param>
				<xsl:with-param name="name"><xsl:value-of select="$prefix"/>_carrier_name</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="$carrierNameValue"/></xsl:with-param>
				<xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
				<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
				<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
			</xsl:call-template>
			
			<xsl:call-template name="input-field">
		         <xsl:with-param name="label">XSL_ROUTING_SUMMARY_LOADING_PORT</xsl:with-param>
		         <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_loading_port</xsl:with-param>
		         <xsl:with-param name="value"><xsl:value-of select="$loadingPortValue"/></xsl:with-param>
		         <xsl:with-param name="type">text</xsl:with-param>
		         <xsl:with-param name="maxsize">35</xsl:with-param>
		         <xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
				<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
				<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="input-field">
		         <xsl:with-param name="label">XSL_ROUTING_SUMMARY_DISCHARGE_PORT</xsl:with-param>
		         <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_discharge_port</xsl:with-param>
		         <xsl:with-param name="value"><xsl:value-of select="$dischargePortValue"/></xsl:with-param>
		         <xsl:with-param name="type">text</xsl:with-param>
		         <xsl:with-param name="maxsize">35</xsl:with-param>
		         <xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
				<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
				<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="input-field">
		         <xsl:with-param name="label">XSL_DOCUMENT_VESSEL</xsl:with-param>
		         <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_vessel_name</xsl:with-param>
		         <xsl:with-param name="value"><xsl:value-of select="$vesselNameValue"/></xsl:with-param>
		         <xsl:with-param name="type">text</xsl:with-param>
		         <xsl:with-param name="maxsize">35</xsl:with-param>
		         <xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
				<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
				<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
			</xsl:call-template>
	</xsl:template>
	
    <xd:doc>
		<xd:short>Rail/Road routing summary details template</xd:short>
		<xd:detail>
			This template defines the fields for road/rail routing summary.
 		</xd:detail>
 		<xd:param name="prefix">Value which identifies whether it is rail or road details.</xd:param>
 		<xd:param name="carrierNameValue">Carrier Name Value.</xd:param>
 		<xd:param name="receiptPlaceValue">Receipt Place Value.</xd:param>
 		<xd:param name="deliveryPlaceValue">Delivery Place Value.</xd:param>
 		<xd:param name="override-displaymode">Value of displaymode.</xd:param>
 	</xd:doc>
    <xsl:template name="payment-transport-road-rail-details">
    	<xsl:param name="prefix"/>
    	<xsl:param name="carrierNameValue"/>
    	<xsl:param name="receiptPlaceValue"/>
    	<xsl:param name="deliveryPlaceValue"/>
    	<xsl:param name="override-displaymode"/>
   			<xsl:call-template name="input-field">
		         <xsl:with-param name="label">XSL_CARRIER_NAME</xsl:with-param>
		         <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_carrier_name</xsl:with-param>
		         <xsl:with-param name="value"><xsl:value-of select="$carrierNameValue"/></xsl:with-param>
		         <xsl:with-param name="type">text</xsl:with-param>
		         <xsl:with-param name="maxsize">35</xsl:with-param>
	         	 <xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
				<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
				<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
			</xsl:call-template>
	    	<xsl:call-template name="input-field">
		         <xsl:with-param name="label">XSL_TRANSPORT_BY_RAIL_RECEIPT_PLACE</xsl:with-param>
		         <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_place_of_receipt</xsl:with-param>
		         <xsl:with-param name="value"><xsl:value-of select="$receiptPlaceValue"/></xsl:with-param>
		         <xsl:with-param name="type">text</xsl:with-param>
		         <xsl:with-param name="maxsize">35</xsl:with-param>
		         <xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
				<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
				<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="input-field">
		         <xsl:with-param name="label">XSL_TRANSPORT_BY_RAIL_DELIVERY_PLACE</xsl:with-param>
		         <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_place_of_delivery</xsl:with-param>
		         <xsl:with-param name="value"><xsl:value-of select="$deliveryPlaceValue"/></xsl:with-param>
		         <xsl:with-param name="type">text</xsl:with-param>
		         <xsl:with-param name="maxsize">35</xsl:with-param>
		         <xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
				 <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
				 <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
			</xsl:call-template>
	</xsl:template>
    
    <!-- ******************************************* -->
  	<!-- START : TRANSPORT ROUTING SUMMARY TEMPLATES -->
    <!-- ******************************************* -->
    
    <!-- ********************************************************* -->
	<!-- START: Payment Insurance Dataset Routing Summary Details  -->
	<!-- ********************************************************* -->
	
	<xd:doc>
		<xd:short>Insurance Transport Routing summary details</xd:short>
		<xd:detail>
			This templates displays Insurance Dataset Routing summary Details
 		</xd:detail>
 	</xd:doc>
	<xsl:template name="payment-insurance-routing-summary-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_ROUTING_SUMMARY_DETAILS</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="content">
				<!-- Transport by Air --> 
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_AIR</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="input-field">
							         <xsl:with-param name="label">XSL_CARRIER_NAME</xsl:with-param>
							         <xsl:with-param name="name"><xsl:value-of select="fieldPrefix"/>_carrier_name</xsl:with-param>
							         <xsl:with-param name="type">text</xsl:with-param>
							         <xsl:with-param name="value"><xsl:value-of select ="payment_insurance_dataset/InsrncDataSet/Trnsprt/TrnsprtByAir/AirCrrierNm"/></xsl:with-param>
							         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							         <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
								</xsl:call-template>
						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_HEADER_DEPARTURE</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="content">
								<xsl:call-template name="payment-transport-air-details">
									<xsl:with-param name="prefix">payment_insurance_dept</xsl:with-param>
									<xsl:with-param name="carrierNameValue"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/Trnsprt/TrnsprtByAir/AirCrrierNm"/></xsl:with-param>
									<xsl:with-param name="airportCodeValue"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/Trnsprt/TrnsprtByAir/DprtureAirprt/AirprtCd"/></xsl:with-param>
									<xsl:with-param name="townValue"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/Trnsprt/TrnsprtByAir/DprtureAirprt/OthrAirprtDesc/Twn"/></xsl:with-param>
									<xsl:with-param name="airportNameValue"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/Trnsprt/TrnsprtByAir/DprtureAirprt/OthrAirprtDesc/AirprtNm"/></xsl:with-param>
									<xsl:with-param name="override-displaymode">view</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_HEADER_DESTINATION</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="content">
								<xsl:call-template name="payment-transport-air-details">
									<xsl:with-param name="prefix">payment_insurance_dest</xsl:with-param>
									<xsl:with-param name="carrierNameValue"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/Trnsprt/TrnsprtByAir/AirCrrierNm"/></xsl:with-param>
									<xsl:with-param name="airportCodeValue"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/Trnsprt/TrnsprtByAir/DstnAirprt/AirprtCd"/></xsl:with-param>
									<xsl:with-param name="townValue"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/Trnsprt/TrnsprtByAir/DstnAirprt/OthrAirprtDesc/Twn"/></xsl:with-param>
									<xsl:with-param name="airportNameValue"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/Trnsprt/TrnsprtByAir/DstnAirprt/OthrAirprtDesc/AirprtNm"/></xsl:with-param>
									<xsl:with-param name="override-displaymode">view</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				<!-- Transport by sea  -->
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_SEA</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
		    	 		<xsl:call-template name="payment-transport-sea-details">
					 		<xsl:with-param name="prefix">insurance_rs_transport_sea</xsl:with-param>
							<xsl:with-param name="carrierNameValue"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/Trnsprt/TrnsprtBySea/SeaCrrierNm"/></xsl:with-param>
							<xsl:with-param name="loadingPortValue"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/Trnsprt/TrnsprtBySea/PortOfLoadng"/></xsl:with-param>
							<xsl:with-param name="dischargePortValue"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/Trnsprt/TrnsprtBySea/PortOfDschrge"/></xsl:with-param>
							<xsl:with-param name="vesselNameValue"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/Trnsprt/TrnsprtBySea/VsslNm"/></xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template> 
					</xsl:with-param>
				</xsl:call-template>
				<!-- Transport by Road  -->
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_ROAD</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="payment-transport-road-rail-details">
			      			<xsl:with-param name="prefix">insurance_rs_transport_road</xsl:with-param>
							<xsl:with-param name="receiptPlaceValue"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/Trnsprt/TrnsprtByRoad/PlcOfRct"/></xsl:with-param>
							<xsl:with-param name="deliveryPlaceValue"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/Trnsprt/TrnsprtByRoad/PlcOfDlvry"/></xsl:with-param>
							<xsl:with-param name="carrierNameValue"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/Trnsprt/TrnsprtByRoad/RoadCrrierNm"/></xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				<!-- Transport by Rail  -->
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_RAIL</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="payment-transport-road-rail-details">
		     				<xsl:with-param name="prefix">insurance_rs_transport_rail</xsl:with-param>
							<xsl:with-param name="receiptPlaceValue"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/Trnsprt/TrnsprtByRail/PlcOfRct"/></xsl:with-param>
							<xsl:with-param name="deliveryPlaceValue"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/Trnsprt/TrnsprtByRail/PlcOfDlvry"/></xsl:with-param>
							<xsl:with-param name="carrierNameValue"><xsl:value-of select="payment_insurance_dataset/InsrncDataSet/Trnsprt/TrnsprtByRail/RailCrrierNm"/></xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
		<!-- *********************************************************** -->
		<!-- END : Payment Insurance Dataset Routing Summary Details 	 -->
		<!-- *********************************************************** -->
		
		<!-- ************************************************************** -->
		<!-- START : Payment Certificate Dataset Routing Summary Details 	-->
		<!-- ************************************************************** -->
	<xd:doc>
		<xd:short>Certificate dataset Transport By Rail Details</xd:short>
		<xd:detail>
			This templates displays Certificate Dataset Routing summary Details
 		</xd:detail>
 	</xd:doc>
	<xsl:template name="payment-certificate-routing-summary-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_ROUTING_SUMMARY_DETAILS</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="content">
			<!-- Transport by air  -->
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_AIR</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="input-field">
					         <xsl:with-param name="label">XSL_CARRIER_NAME</xsl:with-param>
					         <xsl:with-param name="name">payment_insurance_air_carrier_name</xsl:with-param>
					         <xsl:with-param name="type">text</xsl:with-param>
					         <xsl:with-param name="value"><xsl:value-of select ="payment_certificate_dataset/CertDataSet/Trnsprt/TrnsprtByAir/AirCrrierNm"/></xsl:with-param>
					         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
					         <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_HEADER_DEPARTURE</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="content">
							<!-- Departure Details  -->
								<xsl:call-template name="payment-transport-air-details">
									<xsl:with-param name="prefix">payment_certificate_dept</xsl:with-param>
									<xsl:with-param name="carrierNameValue"><xsl:value-of select="payment_certificate_dataset/CertDataSet/Trnsprt/TrnsprtByAir/AirCrrierNm"/></xsl:with-param>
									<xsl:with-param name="airportCodeValue"><xsl:value-of select="payment_certificate_dataset/CertDataSet/Trnsprt/TrnsprtByAir/DprtureAirprt/AirprtCd"/></xsl:with-param>
									<xsl:with-param name="townValue"><xsl:value-of select="payment_certificate_dataset/CertDataSet/Trnsprt/TrnsprtByAir/DprtureAirprt/OthrAirprtDesc/Twn"/></xsl:with-param>
									<xsl:with-param name="airportNameValue"><xsl:value-of select="payment_certificate_dataset/CertDataSet/Trnsprt/TrnsprtByAir/DprtureAirprt/OthrAirprtDesc/AirprtNm"/></xsl:with-param>
									<xsl:with-param name="override-displaymode">view</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_HEADER_DESTINATION</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="content">
								<!--Destination Details -->
								<xsl:call-template name="payment-transport-air-details">
									<xsl:with-param name="prefix">payment_certificate_dest</xsl:with-param>
									<xsl:with-param name="carrierNameValue"><xsl:value-of select="payment_certificate_dataset/CertDataSet/Trnsprt/TrnsprtByAir/AirCrrierNm"/></xsl:with-param>
									<xsl:with-param name="airportCodeValue"><xsl:value-of select="payment_certificate_dataset/CertDataSet/Trnsprt/TrnsprtByAir/DstnAirprt/AirprtCd"/></xsl:with-param>
									<xsl:with-param name="townValue"><xsl:value-of select="payment_certificate_dataset/CertDataSet/Trnsprt/TrnsprtByAir/DstnAirprt/OthrAirprtDesc/Twn"/></xsl:with-param>
									<xsl:with-param name="airportNameValue"><xsl:value-of select="payment_certificate_dataset/CertDataSet/Trnsprt/TrnsprtByAir/DstnAirprt/OthrAirprtDesc/AirprtNm"/></xsl:with-param>
									<xsl:with-param name="override-displaymode">view</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				<!-- Transport by sea  -->
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_SEA</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="payment-transport-sea-details">
					 		<xsl:with-param name="prefix">certificate_rs_transport_sea</xsl:with-param>
							<xsl:with-param name="carrierNameValue"><xsl:value-of select="payment_certificate_dataset/CertDataSet/Trnsprt/TrnsprtBySea/SeaCrrierNm"/></xsl:with-param>
							<xsl:with-param name="loadingPortValue"><xsl:value-of select="payment_certificate_dataset/CertDataSet/Trnsprt/TrnsprtBySea/PortOfLoadng"/></xsl:with-param>
							<xsl:with-param name="dischargePortValue"><xsl:value-of select="payment_certificate_dataset/CertDataSet/Trnsprt/TrnsprtBySea/PortOfDschrge"/></xsl:with-param>
							<xsl:with-param name="vesselNameValue"><xsl:value-of select="payment_certificate_dataset/CertDataSet/Trnsprt/TrnsprtBySea/VsslNm"/></xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				<!--Transport by Road  -->
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_ROAD</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="payment-transport-road-rail-details">
		       				<xsl:with-param name="prefix">insurance_rs_transport_road</xsl:with-param>
							<xsl:with-param name="receiptPlaceValue"><xsl:value-of select="payment_certificate_dataset/CertDataSet/Trnsprt/TrnsprtByRoad/PlcOfRct"/></xsl:with-param>
							<xsl:with-param name="deliveryPlaceValue"><xsl:value-of select="payment_certificate_dataset/CertDataSet/Trnsprt/TrnsprtByRoad/PlcOfDlvry"/></xsl:with-param>
							<xsl:with-param name="carrierNameValue"><xsl:value-of select="payment_certificate_dataset/CertDataSet/Trnsprt/TrnsprtByRoad/RoadCrrierNm"/></xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
				<!--Transport by Rail  -->
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_RAIL</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="payment-transport-road-rail-details">
		      					<xsl:with-param name="prefix">insurance_rs_transport_rail</xsl:with-param>
							<xsl:with-param name="receiptPlaceValue"><xsl:value-of select="payment_certificate_dataset/CertDataSet/Trnsprt/TrnsprtByRail/PlcOfRct"/></xsl:with-param>
							<xsl:with-param name="deliveryPlaceValue"><xsl:value-of select="payment_certificate_dataset/CertDataSet/Trnsprt/TrnsprtByRail/PlcOfDlvry"/></xsl:with-param>
							<xsl:with-param name="carrierNameValue"><xsl:value-of select="payment_certificate_dataset/CertDataSet/Trnsprt/TrnsprtByRail/RailCrrierNm"/></xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<!-- ************************************************************** -->
	<!-- END : Payment Certificate Dataset Routing Summary Details 	-->
	<!-- ************************************************************** -->
</xsl:stylesheet>