<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
        exclude-result-prefixes="localization defaultresource">
        
      <!-- 
	   Global Parameters.
	   These are used in the imported XSL, and to set global params in the JS 
	  -->
	  <xsl:param name="rundata"/>
	  <xsl:param name="url"/>
	  <xsl:param name="language">en</xsl:param>
	  <xsl:param name="collaborationmode">none</xsl:param>
	  
	  <!-- Global Imports. -->
		<xsl:include href="../../../core/xsl/common/system_common.xsl" />
	  
	  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
	  <xsl:template match="/">
	   <xsl:apply-templates select="entitlement"/>
	  </xsl:template>
	  
	<xsl:template match="entitlement">
	<xsl:call-template name="entitlement-details"/>
	<xsl:call-template name = "fcm-entitlement-view"/>
      <xsl:call-template name ="entitlement-iframe-section"/>
	</xsl:template>
	
	  <xsl:template name="entitlement-details">
   		<xsl:call-template name="fieldset-wrapper">
	     	<xsl:with-param name="legend">XSL_ENTITLEMENT_DETAILS</xsl:with-param>
	     	<xsl:with-param name="content">
	     	<xsl:call-template name="column-container">
				<xsl:with-param name="content">			 
					<xsl:call-template name="column-wrapper">
						<xsl:with-param name="content">	     										
						<xsl:call-template name="multioption-inline-wrapper">								
						<xsl:with-param name="group-label">XSL_ENTITLEMENT_CODE</xsl:with-param>
						<xsl:with-param name="content">
							<span class = "content"><xsl:value-of select="entitlement_code"/></span>
						</xsl:with-param>								
					</xsl:call-template>																			    
				</xsl:with-param>
			</xsl:call-template>
			</xsl:with-param>
	     	</xsl:call-template>
	     	<xsl:call-template name="column-container">
				<xsl:with-param name="content">			 
					<xsl:call-template name="column-wrapper">
						<xsl:with-param name="content">	     										
						<xsl:call-template name="multioption-inline-wrapper">								
						<xsl:with-param name="group-label">XSL_ENTITLEMENT_DESCRIPTION</xsl:with-param>
						<xsl:with-param name="content">
							<span class = "content"><xsl:value-of select="entitlement_description"/></span>
						</xsl:with-param>								
					</xsl:call-template>																			    
				</xsl:with-param>
			</xsl:call-template>
			</xsl:with-param>
	     	</xsl:call-template>
	     	</xsl:with-param>
	     	</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="fcm-entitlement-view">
   		<xsl:call-template name="fieldset-wrapper">
	     	<xsl:with-param name="legend">XSL_FCM_ENTITLEMENT_VIEW</xsl:with-param>
	     	<xsl:with-param name="content">
	     	<xsl:call-template name="column-wrapper">
						<xsl:with-param name="content">	     										
							<span style="color:white;" class = "content"><xsl:value-of select="localization:getGTPString($language, 'XSL_EMPTY_KEY')"/></span>
					</xsl:with-param>
					</xsl:call-template>
	     	</xsl:with-param>
	     	</xsl:call-template>
	</xsl:template>
	
	   <xsl:template name="entitlement-iframe-section">
        <xsl:param name="width" select = "'1300'"/>
        <xsl:param name="height" select = "'500'"/>
        <xsl:param name="color" select="'ffffff'"/>
        <xsl:param name="title" select="'0'"/>
        <xsl:param name="byline" select="'0'"/>
        <xsl:param name="portrait" select="'0'"/>
        <xsl:param name="frameborder" select="'0'"/>
        <!-- <xsl:param name="url"><xsl:value-of select="url"/></xsl:param> -->
        
        <div class="entitlement-container">
        <iframe class="view-entitlement" sandbox="allow-same-origin allow-scripts allow-popups allow-forms" width="{$width}" height="{$height}" src="{$url}" frameborder="{$frameborder}">
            <xsl:comment> Entitlemnts Section </xsl:comment>
        </iframe>
               
        </div>
    </xsl:template>
    
</xsl:stylesheet>