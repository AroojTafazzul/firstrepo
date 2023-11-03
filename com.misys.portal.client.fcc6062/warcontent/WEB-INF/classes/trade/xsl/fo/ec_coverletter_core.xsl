<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet
		version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fo="http://www.w3.org/1999/XSL/Format"
		xmlns:java="http://xml.apache.org/xalan/java"
		xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools"
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		xmlns:tool="xalan://com.misys.portal.interfaces.core.ToolsFactory"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		exclude-result-prefixes="converttools localization defaultresource tool">
		
	<xsl:import href="../../../core/xsl/fo/fo_summary.xsl"/>
	
	<xsl:param name="base_url"/>
	<xsl:param name="language"/>
	<xsl:param name="contextPath"/>
	<xsl:param name="images_path">
	<xsl:choose>
		<xsl:when test="defaultresource:isIBEXFOService()"><xsl:value-of select="$base_url"/>/content/images/</xsl:when>
		<xsl:otherwise><xsl:value-of select="$contextPath"/>/content/images/</xsl:otherwise>
	</xsl:choose>
	</xsl:param>
	<xsl:param name="advicesLogoImage">
	<xsl:choose>
		<xsl:when test="defaultresource:isIBEXFOService()"><xsl:value-of select="$base_url"/>/advices/logo.gif</xsl:when>
		<xsl:otherwise><xsl:value-of select="$images_path"/>advices/logo.gif</xsl:otherwise>
	</xsl:choose>
	</xsl:param>
	<xsl:param name="logoImage">
	<xsl:choose>
		<xsl:when test="defaultresource:isIBEXFOService()"><xsl:value-of select="$base_url"/>logo.gif</xsl:when>
		<xsl:otherwise><xsl:value-of select="$images_path"/>logo.gif</xsl:otherwise>
	</xsl:choose>
	</xsl:param>
	
	<xsl:variable name="isdynamiclogo">
        <xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
   </xsl:variable>
	
	<!-- common instructions for the webapplication and the incoming loader -->
	<xsl:template match="ec_tnx_record">
		
		<!-- Determine if Cover Letter is not draft -->
		<xsl:param name="isDraft">
			<xsl:choose>
				<!-- Regular : no cover letter -->
				<xsl:when test="ec_type_code[.='01']">Y</xsl:when>
				<!-- Direct : on bank side if the transaction is submitted -->
				<xsl:when test="ec_type_code[.='02'] and tnx_stat_code[.!='04']">Y</xsl:when>
				<!-- Semi Direct : on customer side if transaction is submitted -->
				<xsl:when test="ec_type_code[.='03'] and (tnx_stat_code[.='01'] or tnx_stat_code[.='02'])">Y</xsl:when>
				<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		</xsl:param>
		
		<!-- Compute BO_REF_ID -->
		<xsl:variable name="bo_ref_id">
			<xsl:choose>
				<xsl:when test="bo_ref_id[. != '']">
					<xsl:value-of select="bo_ref_id"/>
				</xsl:when>
				<xsl:otherwise>XXXXXXXXXX</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<fo:layout-master-set>
				<fo:simple-page-master master-name="Section1-pm" margin-right="75.0pt" margin-left="75.0pt" margin-bottom="36.6pt" margin-top="36.6pt" page-height="841.9pt" page-width="595.3pt">
					<fo:region-body margin-bottom="80.0pt" margin-top="100.0pt"/>
					<fo:region-before extent="100.0pt"/>
					<fo:region-after extent="36.6pt"/>
				</fo:simple-page-master>
				<fo:page-sequence-master master-name="Section1-ps">
					<fo:repeatable-page-master-reference master-reference="Section1-pm"/>
				</fo:page-sequence-master>
			</fo:layout-master-set>
			<fo:page-sequence master-reference="Section1-ps">
			
				<!-- HEADER-->
				<fo:static-content flow-name="xsl-region-before">
					<xsl:call-template name="header"/>
				</fo:static-content>
				
				<!-- FOOTER-->
				<fo:static-content flow-name="xsl-region-after">
					<xsl:call-template name="footer">
						<xsl:with-param name="isDraft" select="$isDraft"/>
					</xsl:call-template>
				</fo:static-content>
				
				<!-- BODY-->
					<xsl:call-template name="body">
						<xsl:with-param name="bo_ref_id" select="$bo_ref_id"/>
					</xsl:call-template>
					
			</fo:page-sequence>
		</fo:root>
	</xsl:template>
	<xsl:template match="documents/document">
		<fo:table-row>
			<fo:table-cell border-left-style="solid" border-left-width=".25pt" border-bottom-style="solid" border-bottom-width=".25pt">
				<fo:block start-indent="3.0pt" padding-top="1.0pt" padding-bottom=".5pt">
					<xsl:choose>
                   <xsl:when test="code and code[.!= ''] and code[.!= '99']"><xsl:value-of select="localization:getDecode($language, 'C064', code)"/></xsl:when>
                  <xsl:otherwise><xsl:value-of select="name"/></xsl:otherwise>
               </xsl:choose>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell border-left-style="solid" border-left-width=".25pt" border-bottom-style="solid" border-bottom-width=".25pt">
				<fo:block text-align="center" start-indent="3.0pt" padding-top="1.0pt" padding-bottom=".5pt">
					<xsl:value-of select="first_mail"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell border-left-style="solid" border-left-width=".25pt" border-bottom-style="solid" border-bottom-width=".25pt" border-right-style="solid" border-right-width=".25pt">
				<fo:block text-align="center" start-indent="3.0pt" padding-top="1.0pt" padding-bottom=".5pt">
					<xsl:value-of select="second_mail"/>
				</fo:block>
			</fo:table-cell>
			<fo:table-cell border-left-style="solid" border-left-width=".25pt" border-bottom-style="solid" border-bottom-width=".25pt" border-right-style="solid" border-right-width=".25pt">
				<fo:block text-align="center" start-indent="3.0pt" padding-top="1.0pt" padding-bottom=".5pt">
					<xsl:value-of select="total"/>
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>

	<!--  Templates for customization-->
	
	  <xsl:template name="header">
	  	<fo:block font-size="8.0pt" font-family="serif">
						<fo:table width="440.0pt">
							<fo:table-column column-width="150.0pt"/>
							<fo:table-column column-width="145.0pt"/>
							<fo:table-column column-width="145.0pt"/>
							<fo:table-body>
								<fo:table-row>
									<!-- Bank logo -->
									<fo:table-cell>
									<fo:block>
										<xsl:call-template name="logo"/>
									</fo:block>
									</fo:table-cell>
										<xsl:call-template name="header-text"/>
								</fo:table-row>
							</fo:table-body>
						</fo:table>
					</fo:block>
	  </xsl:template>
	  
	  
		<xsl:template name="logo">
			<fo:external-graphic content-height="1.5cm"
			content-width="3.5cm" text-align="left">
			<xsl:attribute name="src">
				<xsl:choose>
					<xsl:when test="$isdynamiclogo='true'">url('<xsl:value-of select="$base_url" />/<xsl:value-of select="remitting_bank/abbv_name" />/<xsl:value-of select="utils:getImagePath($logoImage)"/>')</xsl:when>
					<xsl:otherwise>url('<xsl:value-of select="utils:getImagePath($advicesLogoImage)" />')</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			</fo:external-graphic>
		</xsl:template>
		
	<xsl:template name="header-text">
		<fo:table-cell>
			<fo:block>
				<xsl:value-of select="remitting_bank/name"/>
			</fo:block>
			<fo:block>
				<xsl:value-of select="remitting_bank/address_line_1"/>
			</fo:block>
			<fo:block>
				<xsl:value-of select="remitting_bank/address_line_2"/>
			</fo:block>
			<fo:block>
				<xsl:value-of select="remitting_bank/dom"/>
			</fo:block>
		</fo:table-cell>
				<!-- Remitting bank phone, fax, telex, swift-->
		<fo:table-cell>
			 <fo:block>Tel: <xsl:value-of select="remitting_bank/phone"/>
			 </fo:block>
			<fo:block>Fax: <xsl:value-of select="remitting_bank/fax"/>
			</fo:block>
			<fo:block>Telex: <xsl:value-of select="remitting_bank/telex"/>
			</fo:block>
			<fo:block>SWIFT: <xsl:value-of select="remitting_bank/iso_code"/>
			</fo:block>
		</fo:table-cell>
	</xsl:template>
	
	<xsl:template name="footer">
	<xsl:param name="isDraft"/>
		<!-- Page number -->
		<xsl:if test="$isDraft = 'Y'">
			<fo:block color="gray" font-size="20.0pt" font-family="sans-serif"
				font-weight="bold" text-align="center">DRAFT</fo:block>
		</xsl:if>
		<fo:block font-size="10.0pt" font-family="serif" text-align="end">Page<fo:page-number />of<fo:page-number-citation ref-id="LastPage" />
		</fo:block>
	</xsl:template>
	
	<xsl:template name="body">
	<xsl:param name="bo_ref_id"/>
	
	<fo:flow flow-name="xsl-region-body" font-size="10.0pt" font-family="serif">
					<!-- Date : bo_release_dttm or bo_inp_dttm or release_dttm -->
					<fo:block text-align="end">
						<xsl:variable name="date">
							<xsl:choose>
								<xsl:when test="bo_release_dttm[.!='']">
									<xsl:value-of select="bo_release_dttm"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:choose>
										<xsl:when test="bo_inp_dttm[. != '']">
											<xsl:value-of select="bo_inp_dttm"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="release_dttm"/>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:value-of select="converttools:formatXSLTPDFDate($date, 'en')"/>
					</fo:block>
					<!-- Presenting bank -->
					<fo:block>
						<xsl:value-of select="presenting_bank/name"/>
					</fo:block>
					<fo:block>
						<xsl:value-of select="presenting_bank/address_line_1"/>
					</fo:block>
					<fo:block>
						<xsl:value-of select="presenting_bank/address_line_2"/>
					</fo:block>
					<fo:block>
						<xsl:value-of select="presenting_bank/dom"/>
					</fo:block>
					<xsl:if test="presenting_bank/contact_name[.!='']">
						<fo:block>
							<xsl:value-of select="presenting_bank/contact_name"/>
						</fo:block>
					</xsl:if>
					<xsl:if test="presenting_bank/phone[.!='']">
						<fo:block>
							<xsl:value-of select="presenting_bank/phone"/>
						</fo:block>
					</xsl:if>
					<!-- BO_REF_ID -->
					<fo:block margin-top="18.0pt" font-size="12.0pt" font-weight="bold">
					<xsl:choose><xsl:when test="ec_type_code = '01'">Documentary</xsl:when>
					<xsl:otherwise>Direct</xsl:otherwise></xsl:choose> Collection No. <xsl:value-of select="$bo_ref_id"/>
					</fo:block>
					<fo:block margin-top="20.0pt">Dear Sirs,</fo:block>
					<fo:block text-align="justify" margin-top="10.0pt">We enclose the below mentioned documents for collection and kindly ask you to act according to the following instructions. This collection is to be handled by you as if received from <xsl:value-of select="remitting_bank/name"/>, and is subject to the Uniform Rules for Collections (Publication No. 522) of the International Chamber of Commerce, Paris, France.</fo:block>
					<fo:table width="440.0pt" margin-top="18.0pt">
						<fo:table-column column-width="140.0pt"/>
						<fo:table-column column-width="300.0pt"/>
						<fo:table-body>
							<!-- Drawee -->
							<fo:table-row>
								<fo:table-cell>
									<fo:block font-weight="bold">Drawee:</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block>
										<xsl:value-of select="drawee_name"/>
									</fo:block>
									<xsl:if test="drawee_address_line_1[. != '']">
										<fo:block>
											<xsl:value-of select="drawee_address_line_1"/>
										</fo:block>
									</xsl:if>
									<xsl:if test="drawee_address_line_2[. != '']">
										<fo:block>
											<xsl:value-of select="drawee_address_line_2"/>
										</fo:block>
									</xsl:if>
									<xsl:if test="drawee_dom[. != '']">
										<fo:block>
											<xsl:value-of select="drawee_dom"/>
										</fo:block>
									</xsl:if>
									<xsl:if test="drawee_address_line_4[. != '']">
										<fo:block>
											<xsl:value-of select="drawee_address_line_4"/>
										</fo:block>
									</xsl:if>
									<fo:block>&nbsp;</fo:block>
								</fo:table-cell>
							</fo:table-row>
							<!-- term_code -->
							<fo:table-row>
								<fo:table-cell>
									<fo:block font-weight="bold">Deliver Documents Against:</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block>
										<xsl:choose>
											<xsl:when test="term_code[. = '01']">Payment</xsl:when>
											<xsl:when test="term_code[. = '02']">Acceptance</xsl:when>
											<xsl:when test="term_code[. = '03']">Other</xsl:when>
											<xsl:when test="term_code[. = '04']">Aval</xsl:when>
										</xsl:choose>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
							<!-- Tenor -->
							<xsl:if test="tenor_maturity_date[. != '']">
								<fo:table-row>
									<fo:table-cell>
										<fo:block font-weight="bold">Maturity Date:</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block>
										  <xsl:value-of select="tenor_maturity_date"/>		
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</xsl:if> 
							<xsl:if test="tenor_days[. != '']  and tenor_period[.!='']">
								<fo:table-row>
									<fo:table-cell>
										<fo:block font-weight="bold">Tenor:</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block>
						     	            <xsl:text>  </xsl:text> <xsl:value-of select="tenor_days"/>
									     	<xsl:text>  </xsl:text>
									     	<xsl:choose>
										     	<xsl:when test="tenor_period[.='D']">
										     	          <xsl:value-of select="localization:getGTPString($language, 'XSL_TENOR_DAYS')"/>
										     	</xsl:when>
										     	<xsl:when test="tenor_period[.='W']">
										     	          <xsl:value-of select="localization:getGTPString($language, 'XSL_TENOR_WEEKS')"/>
										     	</xsl:when>
										     	<xsl:when test="tenor_period[.='M']">
										     	          <xsl:value-of select="localization:getGTPString($language, 'XSL_TENOR_MONTHS')"/>
										     	</xsl:when>
										     	<xsl:when test="tenor_period[.='Y']">
										     	          <xsl:value-of select="localization:getGTPString($language, 'XSL_TENOR_YEARS')"/>
										     	</xsl:when>
									     	</xsl:choose>
									     	<xsl:choose>
										     	<xsl:when test="tenor_from_after[.='A']">
										     		<xsl:text> </xsl:text>
										     	          <xsl:value-of select="localization:getDecode($language, 'C052', tenor_from_after)"/>
										     		<xsl:text> </xsl:text>
										     	</xsl:when>
										     	<xsl:when test="tenor_from_after[.='E']">
										     		<xsl:text> </xsl:text>
										     	          <xsl:value-of select="localization:getDecode($language, 'C052', tenor_from_after)"/>
										     		<xsl:text> </xsl:text>
										     	</xsl:when>
										     	<xsl:when test="tenor_from_after[.='F']">
										     		<xsl:text> </xsl:text>
										     	          <xsl:value-of select="localization:getDecode($language, 'C052', tenor_from_after)"/>
										     		<xsl:text> </xsl:text>
										     	</xsl:when>
									     	</xsl:choose>
									     	<xsl:choose>
										     	<xsl:when test="tenor_days_type[.='O']">
										     			<xsl:value-of select="tenor_type_details"/>
										     	</xsl:when>
										     	<xsl:otherwise>
						     					     	 <xsl:value-of select="localization:getDecode($language, 'C053', tenor_days_type)"/>
										     	</xsl:otherwise>
									     	</xsl:choose>   	
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</xsl:if>
							<xsl:if test="tenor_base_date[. != '']">
								<fo:table-row>
									<fo:table-cell>
										<fo:block font-weight="bold">Base Date:</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block>
										  <xsl:value-of select="tenor_base_date"/>		
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</xsl:if>
							<!-- Amount -->
							<fo:table-row>
								<fo:table-cell>
									<fo:block font-weight="bold">Amount:</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block>
										<xsl:value-of select="ec_cur_code"/>&nbsp;<xsl:value-of select="ec_amt"/>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
							<!-- Cust_ref_id -->
							<xsl:if test="cust_ref_id[. != '']">
								<fo:table-row>
									<fo:table-cell>
										<fo:block font-weight="bold">Drawer's Reference No.:</fo:block>
									</fo:table-cell>
									<fo:table-cell>
										<fo:block>
											<xsl:value-of select="cust_ref_id"/>
										</fo:block>
									</fo:table-cell>
								</fo:table-row>
							</xsl:if>
						</fo:table-body>
					</fo:table>
					<!-- Documents -->
					<xsl:if test="documents/document">
						<fo:table width="440.0pt" margin-top="18.0pt">
							<fo:table-column column-width="240.0pt"/>
							<fo:table-column column-width="80.0pt"/>
							<fo:table-column column-width="80.0pt"/>
							<fo:table-column column-width="80.0pt"/>
							<fo:table-body>
								<fo:table-row>
									<fo:table-cell background-color="#E6E6E6" border-left-style="solid" border-left-width=".25pt" border-top-style="solid" border-top-width=".25pt" border-bottom-style="solid" border-bottom-width=".25pt">
										<fo:block font-weight="bold" text-align="center" padding-top="1.0pt" padding-bottom=".5pt">Documents</fo:block>
									</fo:table-cell>
									<fo:table-cell background-color="#E6E6E6" border-left-style="solid" border-left-width=".25pt" border-top-style="solid" border-top-width=".25pt" border-bottom-style="solid" border-bottom-width=".25pt">
										<fo:block font-weight="bold" text-align="center" padding-top="1.0pt" padding-bottom=".5pt">Originals</fo:block>
									</fo:table-cell>
									<fo:table-cell background-color="#E6E6E6" border-left-style="solid" border-left-width=".25pt" border-right-style="solid" border-right-width=".25pt" border-top-style="solid" border-top-width=".25pt" border-bottom-style="solid" border-bottom-width=".25pt">
										<fo:block font-weight="bold" text-align="center" padding-top="1.0pt" padding-bottom=".5pt">Copies</fo:block>
									</fo:table-cell>
									<fo:table-cell background-color="#E6E6E6" border-left-style="solid" border-left-width=".25pt" border-right-style="solid" border-right-width=".25pt" border-top-style="solid" border-top-width=".25pt" border-bottom-style="solid" border-bottom-width=".25pt">
										<fo:block font-weight="bold" text-align="center" padding-top="1.0pt" padding-bottom=".5pt">Total</fo:block>
									</fo:table-cell>
								</fo:table-row>
								<xsl:apply-templates select="documents/document[first_mail != '' or second_mail != '' or total != '']"/>
							</fo:table-body>
						</fo:table>
					</xsl:if>
					<!-- Collections instructions -->
					<fo:block font-weight="bold" margin-top="10.0pt">Collection Instructions:</fo:block>
					<fo:list-block provisional-distance-between-starts="10.0pt" provisional-label-separation="10.0pt">
						<!-- accpt_adv_send_mode -->
						<xsl:if test="accpt_adv_send_mode[. != '']">
							<fo:list-item start-indent="30.0pt">
								<fo:list-item-label end-indent="label-end()">
									<fo:block padding-top="-7pt">
										<fo:inline font-size="20.0pt" font-family="{$pdfFontData}" font-weight="bold"> &#x2E; </fo:inline>
									</fo:block>
								</fo:list-item-label>
								<fo:list-item-body start-indent="body-start()">
									<fo:block>Advice acceptance and due date by
										<xsl:choose>
											<xsl:when test="accpt_adv_send_mode[.='01']">SWIFT</xsl:when>
											<xsl:when test="accpt_adv_send_mode[.='02']">Telex / Cable</xsl:when>
											<xsl:when test="accpt_adv_send_mode[.='03']">Courier</xsl:when>
											<xsl:when test="accpt_adv_send_mode[.='04']">Registered Post</xsl:when>
										</xsl:choose>
									</fo:block>
								</fo:list-item-body>
							</fo:list-item>
						</xsl:if>
						<!-- protest_non_paymt -->
						<xsl:if test="protest_non_paymt[. != '']">
							<fo:list-item start-indent="30.0pt">
								<fo:list-item-label end-indent="label-end()">
									<fo:block padding-top="-7pt">
										<fo:inline font-size="20.0pt" font-family="{$pdfFontData}" font-weight="bold"> &#x2E; </fo:inline>
									</fo:block>
								</fo:list-item-label>
								<fo:list-item-body start-indent="body-start()">
									<fo:block>
										<xsl:choose>
											<xsl:when test="protest_non_paymt[. = 'Y']">Protest in case of non payment</xsl:when>
											<xsl:when test="protest_non_paymt[. = 'N']">Do not protest in case of non payment</xsl:when>
										</xsl:choose>
									</fo:block>
								</fo:list-item-body>
							</fo:list-item>
						</xsl:if>
						<!-- protest_non_accpt -->
						<xsl:if test="protest_non_accpt[. != ''] and term_code[. = '02']">
							<fo:list-item start-indent="30.0pt">
								<fo:list-item-label end-indent="label-end()">
									<fo:block padding-top="-7pt">
										<fo:inline font-size="20.0pt" font-family="{$pdfFontData}" font-weight="bold"> &#x2E; </fo:inline>
									</fo:block>
								</fo:list-item-label>
								<fo:list-item-body start-indent="body-start()">
									<fo:block>
										<xsl:choose>
											<xsl:when test="protest_non_accpt[. = 'Y']">Protest in case of non acceptance</xsl:when>
											<xsl:when test="protest_non_accpt[. = 'N']">Do not protest in case of non acceptance</xsl:when>
										</xsl:choose>
									</fo:block>
								</fo:list-item-body>
							</fo:list-item>
						</xsl:if>
						<!-- protest_adv_send_mode -->
						<xsl:if test="protest_adv_send_mode[. != '']">
							<fo:list-item start-indent="30.0pt">
								<fo:list-item-label end-indent="label-end()">
									<fo:block padding-top="-7pt">
										<fo:inline font-size="20.0pt" font-family="{$pdfFontData}" font-weight="bold"> &#x2E; </fo:inline>
									</fo:block>
								</fo:list-item-label>
								<fo:list-item-body start-indent="body-start()">
									<fo:block>Advice reason of refusal by
										<xsl:choose>
											<xsl:when test="protest_adv_send_mode[.='01']">SWIFT</xsl:when>
											<xsl:when test="protest_adv_send_mode[.='02']">Telex / Cable</xsl:when>
											<xsl:when test="protest_adv_send_mode[.='03']">Courier</xsl:when>
											<xsl:when test="protest_adv_send_mode[.='04']">Registered Post</xsl:when>
										</xsl:choose>
									</fo:block>
								</fo:list-item-body>
							</fo:list-item>
						</xsl:if>						
						<!-- store_goods_flag -->
						<xsl:if test="store_goods_flag[. != '']">
							<fo:list-item start-indent="30.0pt">
								<fo:list-item-label end-indent="label-end()">
									<fo:block padding-top="-7pt">
										<fo:inline font-size="20.0pt" font-family="{$pdfFontData}" font-weight="bold"> &#x2E; </fo:inline>
									</fo:block>
								</fo:list-item-label>
								<fo:list-item-body start-indent="body-start()">
									<fo:block>
										<xsl:choose>
											<xsl:when test="store_goods_flag[. = 'Y']">If necessary, warehouse/insure the goods in case of delay</xsl:when>
											<xsl:when test="store_goods_flag[. = 'N']">Even if necessary in case of a delay, it is not asked to warehouse/insure the goods</xsl:when>
										</xsl:choose>
									</fo:block>
								</fo:list-item-body>
							</fo:list-item>
						</xsl:if>
						<!-- narrative_additional_instructions -->
						<xsl:if test="narrative_additional_instructions[. != '']">
							<fo:list-item start-indent="30.0pt">
								<fo:list-item-label end-indent="label-end()">
									<fo:block padding-top="-7pt">
										<fo:inline font-size="20.0pt" font-family="{$pdfFontData}" font-weight="bold"> &#x2E; </fo:inline>
									</fo:block>
								</fo:list-item-label>
								<fo:list-item-body start-indent="body-start()">
									<fo:block>
										<xsl:value-of select="narrative_additional_instructions"/>
									</fo:block>
								</fo:list-item-body>
							</fo:list-item>
						</xsl:if>
					</fo:list-block>
					<!-- Remitting bank's name -->
					<fo:block margin-top="10.0pt">Any further instructions will be given by <xsl:value-of select="remitting_bank/name"/>.
					</fo:block>
					<!-- Charges -->
					<fo:block font-weight="bold" margin-top="10.0pt">Charges:</fo:block>
					<fo:list-block provisional-distance-between-starts="10.0pt" provisional-label-separation="10.0pt">
						<!-- open_chrg_brn_by_code -->
						<xsl:if test="open_chrg_brn_by_code[. != '']">
							<fo:list-item start-indent="30.0pt">
								<fo:list-item-label end-indent="label-end()">
									<fo:block padding-top="-7pt">
										<fo:inline font-size="20.0pt" font-family="{$pdfFontData}" font-weight="bold"> &#x2E; </fo:inline>
									</fo:block>
								</fo:list-item-label>
								<fo:list-item-body start-indent="body-start()">
									<fo:block>Remitting bank charges are at the expense of the
										<xsl:choose>
											<xsl:when test="open_chrg_brn_by_code[. = '03']">drawee</xsl:when>
											<xsl:when test="open_chrg_brn_by_code[. = '04']">drawer</xsl:when>
										</xsl:choose>
									</fo:block>
								</fo:list-item-body>
							</fo:list-item>
						</xsl:if>
						<!-- corr_chrg_brn_by_code -->
						<xsl:if test="corr_chrg_brn_by_code[. != '']">
							<fo:list-item start-indent="30.0pt">
								<fo:list-item-label end-indent="label-end()">
									<fo:block padding-top="-7pt">
										<fo:inline font-size="20.0pt" font-family="{$pdfFontData}" font-weight="bold"> &#x2E; </fo:inline>
									</fo:block>
								</fo:list-item-label>
								<fo:list-item-body start-indent="body-start()">
									<fo:block>All your collection charges are at the expense of the
								<xsl:choose>
											<xsl:when test="corr_chrg_brn_by_code[. = '03']">drawee</xsl:when>
											<xsl:when test="corr_chrg_brn_by_code[. = '04']">drawer</xsl:when>
										</xsl:choose>
									</fo:block>
								</fo:list-item-body>
							</fo:list-item>
						</xsl:if>
						<!-- waive_chrg_flag -->
						<xsl:if test="waive_chrg_flag[. != '']">
							<fo:list-item start-indent="30.0pt">
								<fo:list-item-label end-indent="label-end()">
									<fo:block padding-top="-7pt">
										<fo:inline font-size="20.0pt" font-family="{$pdfFontData}" font-weight="bold"> &#x2E; </fo:inline>
									</fo:block>
								</fo:list-item-label>
								<fo:list-item-body start-indent="body-start()">
									<fo:block>
										<xsl:choose>
											<xsl:when test="waive_chrg_flag[. = 'Y']">The charges to be borne by the drawee can be waived if the bill is refused</xsl:when>
											<xsl:when test="waive_chrg_flag[. = 'N']">The charges to be borne by the drawee cannot be waived if the bill is refused</xsl:when>
										</xsl:choose>
									</fo:block>
								</fo:list-item-body>
							</fo:list-item>
						</xsl:if>
					</fo:list-block>
					<fo:table width="445.0pt" margin-top="10.0pt">
						<fo:table-column column-width="445.0pt"/>
						<fo:table-body>
							<!-- Please remit ... -->
							<fo:table-row>
								<fo:table-cell>
									<fo:block text-align="justify">Please remit the proceeds to <xsl:value-of select="static_bank_name"/>
										<xsl:if test="static_bank_bic != ''"> (SWIFT:<xsl:value-of select="static_bank_bic"/>) 
										 </xsl:if> to the Credit of our Account number held with them										 
										. All further correspondence shall be addressed to the Trade Services Department of <xsl:value-of select="static_bank_name"/> quoting the collection no. <xsl:value-of select="$bo_ref_id"/>.
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
							<!-- Signature -->
							<fo:table-row keep-with-previous="always">
								<fo:table-cell>
									<fo:block margin-top="10.0pt">Sincerely,</fo:block>
								</fo:table-cell>
							</fo:table-row>
							<fo:table-row keep-with-previous="always">
								<fo:table-cell>
									<fo:block margin-top="60.0pt" margin-left="275.0pt">Authorized Signature</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</fo:table-body>
					</fo:table>
					<fo:block id="LastPage" font-size="1pt"/>
				</fo:flow>
	</xsl:template>
	
	<!--  End of Templates for customization -->
		
</xsl:stylesheet>