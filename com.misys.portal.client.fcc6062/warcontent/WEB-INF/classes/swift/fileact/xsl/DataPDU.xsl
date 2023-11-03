<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	exclude-result-prefixes="localization defaultresource">

<xsl:param name="sender-bic-code"></xsl:param>
<xsl:param name="receiver-bic-code"></xsl:param>
<xsl:param name="fileact-filename"></xsl:param>
<xsl:param name="service">swift.generic.fast!p</xsl:param>
<xsl:variable name="smallcase" select="'abcdefghijklmnopqrstuvwxyz'" />
<xsl:variable name="uppercase" select="'ABCDEFGHIJKLMNOPQRSTUVWXYZ'" />
<xsl:template match="lc_tnx_record|bg_tnx_record|si_tnx_record|br_tnx_record|el_tnx_record|sr_tnx_record">
	<xsl:variable name="use_test_bic_for_swift">
  		<xsl:value-of select="defaultresource:getResource('USE_TEST_BIC_FOR_SWIFT')"/>
  	</xsl:variable>
	<DataPDU xmlns="urn:swift:saa:xsd:saa.2.0">
		<Revision>2.0.2</Revision>
		<Header>
			<Message>
				<SenderReference><xsl:value-of select="tnx_id"/></SenderReference>
				<MessageIdentifier>tsmt.xxx.tradedocuments</MessageIdentifier>
				<Format>File</Format>
				<Sender>
					<DN>o=<xsl:value-of select="translate(substring($sender-bic-code, 1, 8), $uppercase, $smallcase)"/>,o=swift</DN>					
					<FullName>
						<X1><xsl:value-of select="$sender-bic-code"/></X1>
					</FullName>
				</Sender>
				<xsl:if test="product_code[.= 'LC'] or product_code [.= 'SI']">
					<xsl:variable name="receiver_iso_code">
						<xsl:choose>
							<xsl:when test="$use_test_bic_for_swift = 'true'">							   	
	    						<xsl:value-of select="$receiver-bic-code"/>	    						
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="issuing_bank/iso_code"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
			        <Receiver>
						<DN>o=<xsl:value-of select="translate(substring($receiver_iso_code, 1, 8), $uppercase, $smallcase)"/>,o=swift</DN>					
						<FullName>
							<X1><xsl:value-of select="$receiver_iso_code"/></X1>
						</FullName>
					</Receiver>
				</xsl:if>
				<xsl:if test="product_code[.= 'BG']">
			        <Receiver>
						<DN>o=<xsl:value-of select="translate(substring(recipient_bank/iso_code, 1, 8), $uppercase, $smallcase)"/>,o=swift</DN>					
						<FullName>
							<X1><xsl:value-of select="recipient_bank/iso_code"/></X1>
						</FullName>
					</Receiver>
				</xsl:if>
				<xsl:if test="product_code[.= 'EL'] or product_code[.= 'BR'] or product_code[.= 'SR']">
			        <Receiver>
						<DN>o=<xsl:value-of select="translate(substring(advising_bank/iso_code, 1, 8), $uppercase, $smallcase)"/>,o=swift</DN>					
						<FullName>
							<X1><xsl:value-of select="advising_bank/iso_code"/></X1>
						</FullName>
					</Receiver>
				</xsl:if>
			      <NetworkInfo>
			     	 <!--<IsNotificationRequested>true</IsNotificationRequested>-->
			     	 <Service><xsl:value-of select="$service"/></Service>
			        <SWIFTNetNetworkInfo>
			          <FileInfo>SwCompression=Zip</FileInfo>
			        </SWIFTNetNetworkInfo>
			      </NetworkInfo>
			      <FileLogicalName><xsl:value-of select="$fileact-filename"/></FileLogicalName>			
			</Message>
		</Header>
		<Body><xsl:value-of select="$fileact-filename"/></Body>
	</DataPDU>
</xsl:template>
</xsl:stylesheet>