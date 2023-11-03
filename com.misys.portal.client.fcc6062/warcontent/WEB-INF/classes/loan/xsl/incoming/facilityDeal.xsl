<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:key name="uniqueFacilitiesCount" match="borrowerFacilities/facilities/facility" use="fcn" />
	<xsl:template match="/">
		<LoanDealDetail>
			<dealId>
				<xsl:value-of select="/borrowerFacilities/facilities/deal/id"/>
			</dealId>
			<dealName>
				<xsl:value-of select="/borrowerFacilities/facilities/deal/name"/>
			</dealName>
			<dealCurrency>
				<xsl:value-of select="/borrowerFacilities/facilities/deal/currency"/>
			</dealCurrency>
			<dealStatus>
				<xsl:value-of select="/borrowerFacilities/facilities/deal/status"/>
			</dealStatus>
			<totalFacilities>
				<xsl:value-of select="count(borrowerFacilities/facilities/facility[generate-id(.) = generate-id(key('uniqueFacilitiesCount', fcn)[1])])"/>
			</totalFacilities>
			<totalLimit>
				<xsl:value-of select="sum(//globalLimitAmount)"/>
			</totalLimit>
			<availableLimit>
				<xsl:value-of select="sum(//globalAvailableAmount)"/>
			</availableLimit>
			<utilisedAmount>
				<xsl:value-of select="sum(//globalLimitAmount)-sum(//globalAvailableAmount)"/>
			</utilisedAmount>
			<balanceOutstanding>
				<xsl:value-of select="sum(//globalOutstandingAmount)"/>
			</balanceOutstanding>
			<repaid>
				<xsl:value-of select="sum(//globalLimitAmount)-sum(//globalAvailableAmount)-sum(//globalOutstandingAmount)"/>
			</repaid>
		</LoanDealDetail>
	</xsl:template>
</xsl:stylesheet>