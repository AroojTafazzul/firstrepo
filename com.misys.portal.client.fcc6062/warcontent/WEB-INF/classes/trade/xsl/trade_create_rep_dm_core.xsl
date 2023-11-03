<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		exclude-result-prefixes="localization securityCheck utils">
		
<!--
   Copyright (c) 2000-2001 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->

	<xsl:import href="product_addons.xsl"/>
  <xsl:import href="collaboration/collaboration.xsl"/>
  
	<xsl:output method="html" indent="no" />

	<!-- Get the language code -->
	<xsl:param name="language"/>
	<xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
	<xsl:param name="formCancelImage"><xsl:value-of select="$images_path"/>pic_form_cancel.gif</xsl:param>
	<xsl:param name="formHelpImage"><xsl:value-of select="$images_path"/>pic_form_help.gif</xsl:param>
	<xsl:param name="formSendImage"><xsl:value-of select="$images_path"/>pic_form_send.gif</xsl:param>
	<xsl:param name="printerImage"><xsl:value-of select="$images_path"/>pic_printer.gif</xsl:param>
	

	<xsl:template match="/">
		<script type="text/javascript" src="/content/OLD/javascript/com_functions.js"></script>
		<script type="text/javascript">
			<xsl:attribute name="src">/content/OLD/javascript/com_error_<xsl:value-of select="$language"/>.js</xsl:attribute>
		</script>
		<script type="text/javascript" src="/content/OLD/javascript/trade_create_dm.js"></script>
		<!-- The following javascript is used for the advice generation handling -->
		<script type="text/javascript" src="/content/OLD/javascript/trade_common_dm.js"></script>

    <xsl:if test="securityCheck:hasPermission(utils:getUserACL($rundata),'collaboration_access',utils:getUserEntities($rundata))">
      <xsl:call-template name="COLLABORATION_JAVASCRIPT"/>
    </xsl:if>
    		
		<!-- Include some eventual additional elements -->
		<xsl:call-template name="client_addons"/>
		
		<table border="0" width="100%" cellspacing="2" cellpadding="4" class="FORMTABLEBORDER">
		<tr>
		<td class="FORMTABLE" align="center">
		
		<table border="0">
		<tr>
		<td align="center">
		
					<table border="0" cellspacing="2" cellpadding="8">
						<tr>
							<td align="middle" valign="center">
								<a href="javascript:void(0)" onclick="fncPerform('submit');return false;">
									<img border="0" >
										<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($formSendImage)"/></xsl:attribute>
									</img><br/>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SUBMIT')"/>
								</a>
							</td>
							<td align="middle" valign="center">
								<a href="javascript:void(0)">
									<xsl:attribute name="onclick">fncShowPreview('FULL','<xsl:value-of select="dm_tnx_record/product_code"/>','<xsl:value-of select="dm_tnx_record/ref_id"/>','<xsl:value-of select="dm_tnx_record/tnx_id"/>','DMReportingPopup');return false;</xsl:attribute>
									<img border="0" >
										<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($printerImage)"/></xsl:attribute>
									</img><br/>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_PREVIEW')"/>
								</a>
							</td>
							<td align="middle" valign="center">
								<a href="javascript:void(0)" onclick="fncPerform('cancel');return false;">
									<img border="0">
										<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($formCancelImage)"/></xsl:attribute>
									</img><br/>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/>
								</a>
							</td>
							<td align="middle" valign="center">
								<a href="javascript:void(0)" onclick="fncPerform('help');return false;">
									<img border="0" >
										<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($formHelpImage)"/></xsl:attribute>
									</img><br/>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_HELP')"/>
								</a>
							</td>
						</tr>
					</table>
	</td>
	</tr>
	<tr>
	<td align="left">

		<!-- Main template -->
		<xsl:apply-templates select="dm_tnx_record" mode="folder"/>
		
	</td>
	</tr>
	<tr>
	<td align="center">
	
				
					<table border="0" cellspacing="2" cellpadding="8">
						<tr>
							<td align="middle" valign="center">
								<a href="javascript:void(0)" onclick="fncPerform('submit');return false;">
									<img border="0" >
										<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($formSendImage)"/></xsl:attribute>
									</img><br/>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SUBMIT')"/>
								</a>
							</td>
							<td align="middle" valign="center">
								<a href="javascript:void(0)">
									<xsl:attribute name="onclick">fncShowPreview('FULL','<xsl:value-of select="dm_tnx_record/product_code"/>','<xsl:value-of select="dm_tnx_record/ref_id"/>','<xsl:value-of select="dm_tnx_record/tnx_id"/>');return false;</xsl:attribute>
									<img border="0" >
										<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($printerImage)"/></xsl:attribute>
									</img><br/>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_PREVIEW')"/>
								</a>
							</td>
							<td align="middle" valign="center">
								<a href="javascript:void(0)" onclick="fncPerform('cancel');return false;">
									<img border="0" >
										<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($formCancelImage)"/></xsl:attribute>
									</img><br/>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/>
								</a>
							</td>
							<td align="middle" valign="center">
								<a href="javascript:void(0)" onclick="fncPerform('help');return false;">
									<img border="0" >
										<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($formHelpImage)"/></xsl:attribute>	
									</img><br/>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_HELP')"/>
								</a>
							</td>
						</tr>
					</table>
					
	</td>
	</tr>
	</table>
	
	</td>
	</tr>
	</table>
  
  <xsl:if test="securityCheck:hasPermission(utils:getUserACL($rundata),'collaboration_access',utils:getUserEntities($rundata))">
    <xsl:call-template name="collaboration">
      <xsl:with-param name="editable">true</xsl:with-param>
      <xsl:with-param name="bank_name_widget_id">issuing_bank_name</xsl:with-param>
	  <xsl:with-param name="bank_abbv_name_widget_id">issuing_bank_abbv_name</xsl:with-param>
      <xsl:with-param name="entityFormName">fakeform1</xsl:with-param>
      <xsl:with-param name="productCode"><xsl:value-of select="product_code"/></xsl:with-param>
    </xsl:call-template>
  </xsl:if>
  
	</xsl:template>

	<!--Import the common dm templates -->
	<xsl:include href="trade_common_rep_dm.xsl"/>
	
</xsl:stylesheet>
