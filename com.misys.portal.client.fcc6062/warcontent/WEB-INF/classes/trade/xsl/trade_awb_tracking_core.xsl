<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
  version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
  xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
  exclude-result-prefixes="localization">
  
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
 <xsl:param name="contextPath"/>
 <xsl:param name="servletPath"/>
 <xsl:param name="language">en</xsl:param>
 <xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
 
<xsl:param name="dhlLogoHomepageImage"><xsl:value-of select="$images_path"/>dhl_logo_homepage.jpg</xsl:param>
 
 <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
 
  <xsl:template match="/">
    <xsl:apply-templates select="rootNode"/> 
  </xsl:template>
	
  <xsl:template match="rootNode"> 
	<div class="AWBClickTrack">
	  <a onClick="misys.showAWB();">
		<img id="dhl_logo_portlet">
			<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($dhlLogoHomepageImage)"/></xsl:attribute>
		</img>
	  </a>
	</div>
	<input type="hidden" id="dhlUrl" >
		<xsl:attribute name="value"><xsl:value-of select="dhlTrackingUrl"></xsl:value-of></xsl:attribute>
	</input>
  		
  	<div class="hide" id="AWBDialogContainer">
	 <div dojoType="misys.widget.Dialog" id="AWBDialog" class="AWBTrackingDialog">
	 	<xsl:attribute name="title">
	 		<xsl:value-of select="localization:getGTPString($language, 'PORTLET_AWB_TRACKING')"/>
	 	</xsl:attribute>
	 	<div id="AWBAlertDialogContent1">
			<div id="AWBDisclaimerMain">
				<xsl:value-of select="localization:getGTPString($language, 'DHL_DISCLAIMER_HOME_DIALOG_CONFIRMATION')"></xsl:value-of><br/>
				<br/>
			</div>
			<div id="dialogButtonsAWB" class="dialogButtons dijitDialogPaneActionBar">
				<div class="field">
					<a id="proceedButton" class="cssButton" onClick="misys.goToDHLTracking();"><xsl:value-of select="localization:getGTPString($language, 'PROCEED')"/></a>&nbsp;
					<a id="cancelButtonAWB1" class="cssButton" onClick="misys.onCancelAWB();"><xsl:value-of select="localization:getGTPString($language, 'CANCEL')"/></a>
				</div>
			</div>
		</div>
    </div>
   </div>
  	<script>
  		dojo.ready(function(){
  			dojo.require("misys.binding.trade.awb_tracking");
  		});
  	</script>
  </xsl:template>
</xsl:stylesheet>