<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for Re Authentication Page.

Copyright (c) 2000-2013 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      10/01/12
author:    Raja Rao

##########################################################
-->
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    exclude-result-prefixes="localization">
  
	<!-- Global Parameters. -->
	<!-- These are used in the XSL, and to set global params in the JS -->
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="collaborationmode">none</xsl:param>
	<xsl:param name="displaymode">edit</xsl:param>
	
	<xsl:param name="reauth_type"/>

   
	<!-- Global Imports. -->
	<xsl:include href="../common/system_common.xsl"/>
	
	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
	
	<!-- Main ReAuth Template -->
	<xsl:template match="/">
		<!-- Main Content -->
		<xsl:call-template name="reauth_type_content">
			<xsl:with-param name="reauth-type" select="$reauth_type"/>
		</xsl:call-template>
	</xsl:template>
	 
	<!--                                     -->  
	<!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
	<!--                                     -->
 
	<!-- Additional JS imports for this form are -->
	<!-- added here. -->
	<xsl:template name="js-imports">
		<script></script>
	</xsl:template>
 
	<xsl:template name="reauth_type_content">
		<xsl:param name="reauth-type"/>
		<div class="widgetContainer">
			<xsl:call-template name="fieldset-wrapper">   		
				<xsl:with-param name="content">
					<xsl:call-template name="column-container">
						<xsl:with-param name="content">
							<div>
								<xsl:choose>
									<xsl:when test="$reauth-type='PASSWORD'">
										<div id="display_msg" class="field">
											<div class="content"><xsl:value-of select="localization:getGTPString($language, 'REAUTH_PASSWORD_MSG')"/></div>
										</div>
									</xsl:when>
									<xsl:otherwise>
										<div id="display_msg" class="field">
											<div class="content"><xsl:value-of select="localization:getGTPString($language, 'REAUTH_GENERIC_MSG')" disable-output-escaping="yes"/></div>
										</div>
									</xsl:otherwise>
								</xsl:choose>
							</div>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
		</div>
	</xsl:template>

</xsl:stylesheet>