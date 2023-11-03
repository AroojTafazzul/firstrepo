<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<!--
   Copyright (c) 2000-2011 Misys (http://www.misys.com),
   All Rights Reserved. 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" 
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
    xmlns:colorprovider="xalan://com.misys.portal.common.resources.ColorResourceProvider"
    xmlns:java="http://xml.apache.org/xalan/java">

    <xsl:param name="user"/>
    <xsl:variable name="isdynamiclogo">
        <xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
    </xsl:variable>
    
    <xsl:template match="audit_item">
        <!-- HEADER-->
        <fo:static-content flow-name="xsl-region-before">
            <fo:block font-family="{$pdfFont}" width="{number($pageDetailsWidth)-(2*number($pdfMargin))}pt">
                <fo:table>
                    <fo:table-column column-width="{14}pt" />
                    <fo:table-column column-width="{14}pt" />
                    <fo:table-column column-width="{14}pt" />
                    <fo:table-column column-width="{14}pt" />
                    <fo:table-body>
                        <fo:table-row>
                            <!-- Bank logo -->
<!--                             <fo:table-cell>
                                <fo:block start-indent="{number($pdfMargin)}pt">
                                     fo:external-graphic height="46.5pt" src="{$base_url}/advices/logo.gif" /
                                 	<fo:external-graphic content-height="1.5cm" content-width="3.5cm">
										<xsl:attribute name="src">
											url('<xsl:value-of select="$base_url" />/advices/logo.gif')
						                </xsl:attribute>
									</fo:external-graphic>
                                </fo:block>
                            </fo:table-cell> -->
                            <fo:table-cell>
                               <fo:block background-color="$fontColorTitles" end-indent="20.0pt" font-family="{$pdfFont}" font-weight="bold" space-before.optimum="10.0pt" start-indent="20.0pt">
                                    <xsl:choose>
                                        <xsl:when test="$operation = 'LIST_LOGIN'">
                                           <xsl:value-of select="localization:getGTPString($language, 'XSL_FO_AUDIT_LOGIN')"/>
                                        </xsl:when>
                                        <xsl:when test="$operation = 'LIST_PRODUCT'">
                                           <xsl:value-of select="localization:getGTPString($language, 'XSL_FO_AUDIT_PRODUCT')"/>
                                        </xsl:when>
                                        <xsl:when test="$operation = 'LIST_SYSTEM_FEATURES'">
                                           <xsl:value-of select="localization:getGTPString($language, 'XSL_FO_AUDIT_SYSTEM_FEATURES')"/>
                                        </xsl:when>
                                        <xsl:when test="$operation = 'LIST_OTHER'">
                                           <xsl:value-of select="localization:getGTPString($language, 'XSL_FO_AUDIT_OTHER')"/>
                                        </xsl:when>
	                                    <xsl:otherwise>
	                                       <xsl:value-of select="localization:getGTPString($language, 'XSL_FO_AUDIT')"/>
	                                    </xsl:otherwise>
                                    </xsl:choose>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-body>
                </fo:table>
            </fo:block>
        </fo:static-content>
        <!-- FOOTER-->
 
    		<fo:static-content flow-name="xsl-region-after">
			<fo:block font-family="{$pdfFont}" font-size="8.0pt" keep-together="always">
				<!-- Page number -->
				<fo:block font-weight="bold" text-align="start">
					<!-- <xsl:value-of select="localization:getGTPString($language, 'XSL_FO_PAGE')" />&nbsp; -->
					<fo:page-number/> /
					<!-- &nbsp;<xsl:value-of select="localization:getGTPString($language, 'XSL_FO_OF')" />&nbsp; -->
					<fo:page-number-citation ref-id="last-page"/>
				</fo:block>
				<fo:block text-align="start">
					<xsl:attribute name="end-indent">
	                                 	<xsl:value-of select="number($pdfMargin)"/>pt
	                                 </xsl:attribute>
					<xsl:value-of select="$systemDate"/>
				</fo:block>
			</fo:block>
		</fo:static-content>
		
        <!-- BODY-->
        <fo:flow flow-name="xsl-region-body" font-size="{$pdfFontSize}">
            <fo:block keep-together="always" font-size="9pt" white-space-collapse="false">
                <fo:table width="{$pdfTableWidth}" font-family="{$pdfFontData}" space-before.optimum="-10.0pt">
                    <fo:table-column column-width="{$labelColumnWidth}"/>
                    <fo:table-column column-width="{$detailsColumnWidth}"/>
                    <fo:table-body>
                        <fo:table-row>
                            <fo:table-cell number-columns-spanned="2">
                                <fo:block space-before.optimum="10.0pt" space-after.optimum="10.0pt"
                                    background-color="{$fontColorTitles}" color="{$backgroundSubtitles}"
                                    font-weight="bold" font-family="{$pdfFont}">
                                    <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_AUDIT_SEARCH_CRITERIA')"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <xsl:if test="$actioncode!=''">
                            <fo:table-row keep-with-previous="always">
                                <fo:table-cell>
                                    <fo:block font-family="{$pdfFont}" start-indent="20.0pt">
                                    	<xsl:if test="$operation = 'LIST_SYSTEM_FEATURES'">
                                  	    	  <xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_LABEL')"/>
                                        </xsl:if>
                                        <xsl:if test="$operation = 'LIST_PRODUCT'">
                                     		   <xsl:value-of select="localization:getGTPString($language, 'PRODUCT_LABEL')"/>
                                        </xsl:if>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block font-weight="bold">
                                        <xsl:value-of select="$actioncode"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>
                        <xsl:if test="$search_date!=''">
	                        <fo:table-row keep-with-previous="always">
	                            <fo:table-cell>
	                                <fo:block font-family="{$pdfFont}" start-indent="20.0pt">
	                                    <xsl:value-of select="localization:getGTPString($language, 'DATE_LABEL')"/>
	                                </fo:block>
	                            </fo:table-cell>
	                            <fo:table-cell>
	                                <fo:block font-weight="bold">
	                                    <xsl:value-of select="$search_date"/>
	                                </fo:block>
	                            </fo:table-cell>
	                        </fo:table-row>
	                    </xsl:if>
                        <xsl:if test="$login!=''">
	                        <fo:table-row keep-with-previous="always">
	                            <fo:table-cell>
	                                <fo:block font-family="{$pdfFont}" start-indent="20.0pt">
	                                    <xsl:value-of select="localization:getGTPString($language, 'USER_LABEL')"/>
	                                </fo:block>
	                            </fo:table-cell>
	                            <fo:table-cell>
	                                <fo:block font-weight="bold">
	                                    <xsl:value-of select="$login"/>
	                                </fo:block>
	                            </fo:table-cell>
	                        </fo:table-row>
                        </xsl:if>
                        <xsl:if test="$company!='' and $isbank">
                            <fo:table-row keep-with-previous="always">
                                <fo:table-cell>
                                    <fo:block font-family="{$pdfFont}" start-indent="20.0pt">
                                        <xsl:value-of select="localization:getGTPString($language, 'COMPANY_LABEL')"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block font-weight="bold">
                                        <xsl:value-of select="$company"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>
                        <xsl:if test="$reference!=''">
                            <fo:table-row keep-with-previous="always">
                                <fo:table-cell>
                                    <fo:block font-family="{$pdfFont}" start-indent="20.0pt">
                                        <xsl:value-of select="localization:getGTPString($language, 'REFERENCEID_LABEL')"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block font-weight="bold">
                                        <xsl:value-of select="$reference"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>
                        <xsl:if test="$result!=''">
                            <fo:table-row keep-with-previous="always">
                                <fo:table-cell>
                                    <fo:block font-family="{$pdfFont}" start-indent="20.0pt">
                                        <xsl:value-of select="localization:getGTPString($language, 'RESULT_LABEL')"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block font-weight="bold">
                                        <xsl:value-of select="$result"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>
                        <xsl:if test="$ipaddress!=''">
                            <fo:table-row keep-with-previous="always">
                                <fo:table-cell>
                                    <fo:block font-family="{$pdfFont}" start-indent="20.0pt">
                                        <xsl:value-of select="localization:getGTPString($language, 'IPADDRESS_LABEL')"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block font-weight="bold">
                                        <xsl:value-of select="$ipaddress"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>
                    </fo:table-body>
                </fo:table>
          	</fo:block>
	        <fo:table width="{$pdfTableWidth}" font-family="{$pdfFont}" space-before.optimum="20.0pt" font-size="8pt">
	           
	           <xsl:if test="$isbank='Y'">
	           		<xsl:choose>
		           		<xsl:when test="$operation != 'LIST_LOGIN'">
			           		<fo:table-column column-width="14.28%"/>
				        	<fo:table-column column-width="14.28%"/>
				        	<fo:table-column column-width="14.28%"/>
			                <fo:table-column column-width="14.28%"/>
				        	<fo:table-column column-width="14.28%"/>
				        	<fo:table-column column-width="14.28%"/>
				        	<fo:table-column column-width="14.28%"/>
		           		</xsl:when>
		           		<xsl:otherwise>
		           			<fo:table-column column-width="16.66%"/>
				        	<fo:table-column column-width="16.66%"/>
				        	<fo:table-column column-width="16.66%"/>
			                <fo:table-column column-width="16.66%"/>
				        	<fo:table-column column-width="16.66%"/>
				        	<fo:table-column column-width="16.66%"/>
		           		</xsl:otherwise>
		           	</xsl:choose>
	        	</xsl:if>
	        	<xsl:if test="$isbank !='Y'">
	        		<xsl:choose>
		           		<xsl:when test="$operation != 'LIST_LOGIN'">
			    		    <fo:table-column column-width="16.66%"/>
				        	<fo:table-column column-width="16.66%"/>
				        	<fo:table-column column-width="16.66%"/>
				        	<fo:table-column column-width="16.66%"/>
				        	<fo:table-column column-width="16.66%"/>
				        	<fo:table-column column-width="16.66%"/>
			       		 </xsl:when>
			       		 <xsl:otherwise>
			       		 	<fo:table-column column-width="20%"/>
				        	<fo:table-column column-width="20%"/>
				        	<fo:table-column column-width="20%"/>
				        	<fo:table-column column-width="20%"/>
				        	<fo:table-column column-width="20%"/>
			        	</xsl:otherwise>
			       </xsl:choose>
	        	</xsl:if>
				<fo:table-header>
				
					<fo:table-row background-color="{$fontColorTitles}">
						<fo:table-cell padding="1pt" border-width="0.5pt" border-style="solid" border-color="black">
							<fo:block background-color="{$fontColorTitles}" color="{$backgroundSubtitles}" font-weight="bold" font-family="{$pdfFont}" text-align="center"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER')"/></fo:block>
						</fo:table-cell>
                        <fo:table-cell padding="1pt" border-width="0.5pt" border-style="solid" border-color="black">
                            <fo:block background-color="{$fontColorTitles}" color="{$backgroundSubtitles}" font-weight="bold" font-family="{$pdfFont}" text-align="center"><xsl:value-of select="localization:getGTPString($language, 'DATE')"/></fo:block>
                        </fo:table-cell>
						
						<fo:table-cell padding="1pt" border-width="0.5pt" border-style="solid" border-color="black">
							<fo:block background-color="{$fontColorTitles}" color="{$backgroundSubtitles}" font-weight="bold" font-family="{$pdfFont}" text-align="center"><xsl:value-of select="localization:getGTPString($language, 'USER')"/></fo:block>
						</fo:table-cell>
                        <xsl:if test="$operation != 'LIST_LOGIN'">
                            <fo:table-cell padding="1pt" border-width="0.5pt" border-style="solid" border-color="black">
                                <fo:block background-color="{$fontColorTitles}" color="{$backgroundSubtitles}" font-weight="bold" font-family="{$pdfFont}" text-align="center"><xsl:value-of select="localization:getGTPString($language, 'IDENTIFIER')"/></fo:block>
                            </fo:table-cell>
                        </xsl:if>
						<xsl:if test="$isbank">
							<fo:table-cell padding="1pt" border-width="0.5pt" border-style="solid" border-color="black">
								<fo:block background-color="{$fontColorTitles}" color="{$backgroundSubtitles}" font-weight="bold" font-family="{$pdfFont}" text-align="center"><xsl:value-of select="localization:getGTPString($language, 'BANKANDCOMPANY')"/></fo:block>
							</fo:table-cell>
						</xsl:if>
						<fo:table-cell padding="1pt" border-width="0.5pt" border-style="solid" border-color="black">
							<fo:block background-color="{$fontColorTitles}" color="{$backgroundSubtitles}" font-weight="bold" font-family="{$pdfFont}" text-align="center"><xsl:value-of select="localization:getGTPString($language, 'RESULT')"/></fo:block>
						</fo:table-cell>
						<fo:table-cell padding="1pt" border-width="0.5pt" border-style="solid" border-color="black">
							<fo:block background-color="{$fontColorTitles}" color="{$backgroundSubtitles}" font-weight="bold" font-family="{$pdfFont}" text-align="center"><xsl:value-of select="localization:getGTPString($language, 'IPADDRESS')"/></fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-header>
	        	<fo:table-body>
					<xsl:apply-templates select="items"/>
				</fo:table-body>
	        </fo:table>
	        <fo:block id="last-page" />
        </fo:flow>
    </xsl:template>
    
    <!--  TEMPLATE Statement Lines -->
    <xsl:template match="items">
		<fo:table-row keep-with-previous="auto">
			<xsl:variable name="bgcolor">
				<xsl:if test="position() mod 2 = 1">
					<xsl:value-of select="colorprovider:getBackGroundList1()"/>
				</xsl:if> 
				<xsl:if test="position() mod 2 = 0">
					<xsl:value-of select="colorprovider:getBackGroundList2()"/>
				</xsl:if>
			</xsl:variable>
				        <fo:table-cell padding="3pt" border-width="0.5pt" border-style="solid" border-color="black" background-color="#{$bgcolor}">
	            <fo:block font-family="{$pdfFont}" text-align="center">
	                <xsl:value-of select="ACTION"/>
	            </fo:block>
	        </fo:table-cell>
            <fo:table-cell padding="3pt" border-width="0.5pt" border-style="solid" border-color="black" background-color="#{$bgcolor}">
                <fo:block font-family="{$pdfFont}" text-align="center">
                <xsl:value-of select="DATE" />
               </fo:block>
            </fo:table-cell>
	        <fo:table-cell padding="3pt" border-width="0.5pt" border-style="solid" border-color="black" background-color="#{$bgcolor}">
	            <fo:block font-family="{$pdfFont}" text-align="center">
	                <xsl:value-of select="USER"/>
	            </fo:block>
	        </fo:table-cell>
            <xsl:if test="$operation != 'LIST_LOGIN'">
                <fo:table-cell padding="3pt" border-width="0.5pt" border-style="solid" border-color="black" background-color="#{$bgcolor}">
                    <fo:block font-family="{$pdfFont}" text-align="center">
                        <xsl:value-of select="IDENTIFIER" />
                    </fo:block>
                </fo:table-cell>
            </xsl:if>
	        <xsl:if test="$isbank">
	            <fo:table-cell padding="3pt" border-width="0.5pt" border-style="solid" border-color="black" background-color="#{$bgcolor}">
	                <fo:block font-family="{$pdfFont}" text-align="center">
	                    <xsl:value-of select="BANKANDCOMPANY" />
	                </fo:block>
	            </fo:table-cell>
            </xsl:if>
	        <fo:table-cell padding="3pt" border-width="0.5pt" border-style="solid" border-color="black" background-color="#{$bgcolor}">
	            <fo:block font-family="{$pdfFont}" text-align="center">
	                <xsl:value-of select="RESULT" />
	            </fo:block>
	        </fo:table-cell>
            <fo:table-cell padding="3pt" border-width="0.5pt" border-style="solid" border-color="black" background-color="#{$bgcolor}">
                <fo:block font-family="{$pdfFont}" text-align="center">          
                    <xsl:value-of select="IPADDRESS" />
                </fo:block>
            </fo:table-cell>
        </fo:table-row>
    </xsl:template>
    
</xsl:stylesheet>
