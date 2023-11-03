<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
 

##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
    xmlns:xmlutils="xalan://com.misys.portal.common.tools.XMLUtils"
    xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
    xmlns:securityUtils="xalan://com.misys.portal.common.tools.SecurityUtils"
    xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
    xmlns:jetspeedresources="xalan://com.misys.portal.core.util.JetspeedResources"
    xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
    xmlns:xd="http://www.pnp-software.com/XSLTdoc"
    exclude-result-prefixes="localization utils xmlutils securityCheck security jetspeedresources xd">
	
 <xsl:variable name="localization-permission"><xsl:value-of select="localization:checkLocalizationPermission($rundata)"/></xsl:variable>
   <xsl:template name='localization-dialog'>
	<xsl:call-template name="dialog">
         <xsl:with-param name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_LOCALIZATION_DETAILS')"/></xsl:with-param>
         <xsl:with-param name="id">localizationDialog</xsl:with-param>
         <xsl:with-param name="content">
          <xsl:call-template name="form-wrapper">
          <xsl:with-param name="name">sendfiles</xsl:with-param>
          <xsl:with-param name="parseFormOnLoad">N</xsl:with-param>
          <xsl:with-param name="enctype">multipart/form-data</xsl:with-param>
          <!-- <xsl:with-param name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/GTPUploadScreen</xsl:with-param>
           --><xsl:with-param name="override-displaymode">edit</xsl:with-param>
          <xsl:with-param name="content">
          <div class="widgetContainer">
               
           <xsl:call-template name="hidden-field">
            <xsl:with-param name="name">xsl_name</xsl:with-param>
            
           </xsl:call-template>
         
          </div>
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_LOCALIZATION_NEW_VALUE</xsl:with-param>
           <xsl:with-param name="name">new_title</xsl:with-param>
           <xsl:with-param name="value"/>
           <xsl:with-param name="size">30</xsl:with-param>
           <xsl:with-param name="maxsize">255</xsl:with-param>
           <xsl:with-param name="swift-validate">N</xsl:with-param>
          </xsl:call-template>
          
         </xsl:with-param>
         </xsl:call-template>
         </xsl:with-param>
         <xsl:with-param name="buttons">
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="id">uploadButton</xsl:with-param>
           <xsl:with-param name="content">
            <button dojoType="dijit.form.Button" id="uploadButton" onclick="misys.submitLocalization()" type="button">
             <xsl:attribute name="value"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_SUBMIT')"/></xsl:attribute>
             <xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_SUBMIT')"/>
            </button>
            <button dojoType="dijit.form.Button" id="cancelUpload" onclick="dijit.byId('localizationDialog').hide()" type="button">
             <xsl:attribute name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/></xsl:attribute>
             <xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/>
            </button>
            <button dojoType="dijit.form.Button" id="uploadButton1" onclick="misys.undoLocalization()" type="button">
             <xsl:attribute name="value"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_UNDO')"/></xsl:attribute>
              <xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_UNDO')"/>
            </button>
           </xsl:with-param>
          </xsl:call-template>
         </xsl:with-param>
       
     </xsl:call-template> 
    </xsl:template> 

<!-- <xsl:variable name="localization-permission"><xsl:value-of select="localization:checkLocalizationPermission($rundata)"/></xsl:variable> -->  
    <xsl:template name="localization-button">
   		<xsl:param name="xslName"/>
   		<xsl:param name="localName"/>
   		<xsl:if test="$localization-permission='true' and ( $localName!=null or $localName!='')">
   		<div id="buttonsdiv"  >
				<button dojoType="dijit.form.Button" type="button" style=" float:right; position: relative; z-index: 5;">
					<xsl:attribute name="onClick">misys.showLocalizationDialog('<xsl:value-of select="$xslName"/>','<xsl:value-of select="$localName"/>');</xsl:attribute>
				</button>
		</div>
   		</xsl:if>
   </xsl:template>
   <xsl:template name="localization-dblclick">
   		<xsl:param name="xslName"/>
   		<xsl:param name="localName"/>
   		<xsl:if test="$localization-permission='true' and ($localName!=null or $localName!='') and xslName!='XSL_LOCALIZATION_NEW_VALUE'">
   		<xsl:attribute name="ondblclick">misys.showLocalizationDialog('<xsl:value-of select="$xslName"/>','<xsl:value-of select="$localName"/>');</xsl:attribute>							 	
		</xsl:if>
   </xsl:template>
  
</xsl:stylesheet>