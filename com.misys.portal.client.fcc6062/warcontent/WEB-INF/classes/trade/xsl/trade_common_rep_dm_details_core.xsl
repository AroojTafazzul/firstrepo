<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:gtp="http://www.neomalogic.com"
		xmlns:cmp="http://www.bolero.net"
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools"
		exclude-result-prefixes="localization converttools">
		
<!--
   Copyright (c) 2000-2001 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->

	<!-- Get the language code -->
	<xsl:param name="language"/>
	
	<!-- -->	
	<!--Other Templates-->
	
	<!--Additional Informations-->
	<xsl:template match="AdditionalInformation/line">
		<xsl:value-of select="."/>
	</xsl:template>
	
	<xsl:template name="TERM_DETAILS">
		<xsl:param name="position"/>
		<xsl:param name="data"/>
		<tr>
			<td width="20" align="center"><xsl:value-of select="$position"/></td>
			<td>
				<font class="REPORTDATA"><xsl:value-of select="$data"/></font>
			</td>
		</tr>
	</xsl:template>
	
	<!--Payment Terms-->
	<xsl:template match="PaymentTerms/PaymentTermsDetail/UserDefinedPaymentTerms/line">
		<xsl:value-of select="."/>
	</xsl:template>
	
	<xsl:template name="CHARGE_DETAILS">
		<xsl:param name="position"/>
		<xsl:param name="charge_type"/>
		<xsl:param name="charge_description"/>
		<xsl:param name="charge_currency"/>
		<xsl:param name="charge_amount"/>
		<xsl:param name="charge_rate"/>
		<xsl:param name="charge_reporting_currency"/>
		<xsl:param name="charge_reporting_amount"/>
		<table border="0" cellspacing="0" width="570">
			<tr>
				<td width="15">&nbsp;</td>
				<td class="FORMH2" align="left">
					<b><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_CHARGEDETAILS_CHARGE')"/>&nbsp;<xsl:value-of select="$position"/></b>
				</td>
			</tr>
		</table>
		<table border="0" cellspacing="0" width="570">
			<xsl:if test="$charge_type!=''">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_CHARGEDETAILS_TYPE')"/>
					</td>
					<td>
						<font class="REPORTDATA"><xsl:value-of select="$charge_type"/></font>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="$charge_description!=''">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_CHARGEDETAILS_DESCRIPTION')"/>
					</td>
					<td>
						<font class="REPORTDATA"><xsl:value-of select="$charge_description"/></font>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="$charge_amount!=''">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_CHARGEDETAILS_AMOUNT')"/>
					</td>
					<td>
						<font class="REPORTDATA"><xsl:value-of select="$charge_currency"/>&nbsp;<xsl:value-of select="$charge_amount"/></font>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="$charge_rate!=''">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_CHARGEDETAILS_RATE')"/>
					</td>
					<td>
						<font class="REPORTDATA"><xsl:value-of select="$charge_rate"/></font>
					</td>
				</tr>
				<xsl:if test="$charge_reporting_amount!=''">
					<tr>
						<td width="40">&nbsp;</td>
						<td width="170">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_CHARGEDETAILS_EQV_AMOUNT')"/>
						</td>
						<td>
							<font class="REPORTDATA"><xsl:value-of select="$charge_reporting_currency"/>&nbsp;<xsl:value-of select="$charge_reporting_amount"/></font>
						</td>
					</tr>
				</xsl:if>
			</xsl:if>
		</table>
	</xsl:template>

	
	<xsl:template name="PACKAGE_DETAILS">
		<xsl:param name="position"/>
		<xsl:param name="package_number"/>
		<xsl:param name="package_type"/>
		<xsl:param name="package_description"/>
		<xsl:param name="package_height"/>
		<xsl:param name="package_width"/>
		<xsl:param name="package_length"/>
		<xsl:param name="package_dimension_unit"/>
		<xsl:param name="package_netweight"/>
		<xsl:param name="package_grossweight"/>
		<xsl:param name="package_weight_unit"/>
		<xsl:param name="package_grossvolume"/>
		<xsl:param name="package_volume_unit"/>
		<xsl:param name="package_marks"/>

		<table border="0" cellspacing="0" width="570">
			<tr>
				<td width="15">&nbsp;</td>
				<td class="FORMH2" align="left">
					<b><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_PACKAGE')"/>&nbsp;<xsl:value-of select="$position"/></b>
				</td>
			</tr>
		</table>
		<table border="0" cellspacing="0" width="570">
			<xsl:if test="$package_number != ''">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_NUMBER')"/>
					</td>
					<td>
						<font class="REPORTDATA"><xsl:value-of select="$package_number"/>&nbsp;<xsl:value-of select="$package_type"/></font>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="$package_description !=''">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_DESCRIPTION')"/>
					</td>
					<td>
						<font class="REPORTDATA"><xsl:value-of select="$package_description"/></font>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="$package_height !=''">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_HEIGHT')"/>
					</td>
					<td>
						<font class="REPORTDATA"><xsl:value-of select="$package_height"/>&nbsp;<xsl:value-of select="$package_dimension_unit"/></font>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="$package_width !=''">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_WIDTH')"/>
					</td>
					<td>
						<font class="REPORTDATA"><xsl:value-of select="$package_width"/>&nbsp;<xsl:value-of select="$package_dimension_unit"/></font>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="$package_length !=''">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_LENGTH')"/>
					</td>
					<td>
						<font class="REPORTDATA"><xsl:value-of select="$package_length"/>&nbsp;<xsl:value-of select="$package_dimension_unit"/></font>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="$package_netweight !=''">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_NETWEIGHT')"/>
					</td>
					<td>
						<font class="REPORTDATA"><xsl:value-of select="$package_netweight"/>&nbsp;<xsl:value-of select="$package_weight_unit"/></font>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="$package_grossweight !=''">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_GROSSWEIGHT')"/>
					</td> 
					<td>
						<font class="REPORTDATA"><xsl:value-of select="$package_grossweight"/>&nbsp;<xsl:value-of select="$package_weight_unit"/></font>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="$package_grossvolume !=''">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_GROSSVOLUME')"/>
					</td>
					<td>
						<font class="REPORTDATA"><xsl:value-of select="$package_grossvolume"/>&nbsp;<xsl:value-of select="$package_volume_unit"/></font>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="$package_marks !=''">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PACKAGEDETAILS_MARKS')"/>
					</td>
					<td>
						<font class="REPORTDATA"><xsl:value-of select="$package_marks"/></font>
					</td>
				</tr>
			</xsl:if>
		</table>

	</xsl:template>


	<!--Product Details-->
	<xsl:template name="PRODUCT_DETAILS">
		<xsl:param name="position"/>
		<xsl:param name="product_identifier"/>
		<xsl:param name="product_description"/>
		<xsl:param name="purchase_order_id"/>
		<xsl:param name="export_license_id"/>
		<xsl:param name="base_currency"/>
		<xsl:param name="base_unit"/>
		<xsl:param name="base_price"/>
		<xsl:param name="product_quantity"/>
		<xsl:param name="product_unit"/>
		<xsl:param name="product_currency"/>
		<xsl:param name="product_rate"/>
		<xsl:param name="product_price"/>
		<table border="0" cellspacing="0" width="570">
			<tr>
				<td width="15">&nbsp;</td>
				<td class="FORMH2" align="left">
					<b><xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_PRODUCT_ITEM')"/>&nbsp;<xsl:value-of select="$position"/></b>
				</td>
			</tr>
		</table>
		<table border="0" cellspacing="0" width="570">
			<xsl:if test="$product_identifier != ''">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_REFERENCE')"/>
					</td>
					<td>
						<font class="REPORTDATA"><xsl:value-of select="$product_identifier"/></font>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="$product_description != ''">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_DESCRIPTION')"/>
					</td>
					<td>
						<font class="REPORTDATA"><xsl:value-of select="$product_description"/></font>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="$purchase_order_id != ''">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_PURCHASE_ORDER_ID')"/>
					</td>
					<td>
						<font class="REPORTDATA"><xsl:value-of select="$purchase_order_id"/></font>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="$export_license_id != ''">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_EXPORT_LICENSE_ID')"/>
					</td>
					<td>
						<font class="REPORTDATA"><xsl:value-of select="$export_license_id"/></font>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="$base_currency != ''">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_BASE_UNIT')"/>
					</td>
					<td>
						<font class="REPORTDATA"><xsl:value-of select="$base_unit"/></font>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="$base_price != ''">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_BASE_PRICE')"/>
					</td>
					<td>
						<font class="REPORTDATA"><xsl:value-of select="$base_currency"/>&nbsp;<xsl:value-of select="$base_price"/></font>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="$product_quantity != ''">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_PRODUCT_QUANTITY')"/>
					</td>
					<td>
						<font class="REPORTDATA"><xsl:value-of select="$product_quantity"/></font>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="$product_rate != ''">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_PRODUCT_RATE')"/>
					</td>
					<td>
						<font class="REPORTDATA"><xsl:value-of select="$product_rate"/></font>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="$product_price != ''">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="170">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_DOCUMENT_PRODUCTDETAILS_PRODUCT_PRICE')"/>
					</td>
					<td>
						<font class="REPORTDATA"><xsl:value-of select="$product_currency"/>&nbsp;<xsl:value-of select="$product_price"/></font>
					</td>
				</tr>
			</xsl:if>
		</table>
	</xsl:template>

	<!--Product Summary-->
	<xsl:template name="PRODUCT_SUMMARY">
		<xsl:param name="position"/>
		<xsl:param name="product_identifier"/>
		<xsl:param name="product_description"/>
		<xsl:param name="product_quantity"/>
		<xsl:param name="product_unit"/>
		<tr>
			<td><xsl:value-of select="$position"/></td>
			<td><xsl:value-of select="$product_identifier"/></td>
			<td><xsl:value-of select="$product_description"/></td>
			<td><xsl:value-of select="$product_unit"/></td>
			<td><xsl:value-of select="$product_quantity"/></td>
		</tr>
	</xsl:template>

	<!--Product Details-->
	<xsl:template name="PRODUCT_SIMPLE">
		<xsl:param name="position"/>
		<xsl:param name="product_description"/>
			<tr>
				<td>
					<xsl:value-of select="$position"/>
				</td>
				<td>
					<xsl:value-of select="$product_description"/>
				</td>
			</tr>
	</xsl:template>

</xsl:stylesheet>
