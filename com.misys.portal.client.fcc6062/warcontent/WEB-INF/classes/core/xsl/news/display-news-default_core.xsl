<?xml version="1.0" encoding="UTF-8" ?>

<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
 xmlns:localization="xalan://com.misys.portal.common.localization.Localization" 	
 version="1.0"
 xmlns:appdata="xalan://com.misys.portal.common.tools.GTPApplicationData"
 exclude-result-prefixes="appdata">
 
 <xsl:param name="contextPath"/>
 <xsl:param name="servletPath"/>
 <xsl:param name="displaymode">view</xsl:param>
 <xsl:param name="lowercase-product-code"></xsl:param>
 <xsl:param name="language"></xsl:param>
 <xsl:param name="logged"></xsl:param>
 
 <xsl:include href="common-news-templates.xsl" />
<!--
   Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
	This product includes software developed by the Java Apache Project (http://java.apache.org/).
-->
	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />

    <!-- News parent template -->
	<xsl:template match="/news_items">
	  <xsl:choose>
	  	<xsl:when test="count(//news_record) = 0">
	  		&nbsp;&nbsp;<b><xsl:value-of select="localization:getGTPString($language, 'XSL_NO_NEWS_AVAILABLE')"/></b><div class="clear">&nbsp;</div>
	  	</xsl:when>
	  	<xsl:otherwise>
	  		<xsl:apply-templates select="//news_record"/>
	  	</xsl:otherwise>
	  </xsl:choose>
      <div class="widgetContainer"><xsl:call-template name="upload-form-news"></xsl:call-template></div>
	</xsl:template>

    <!-- News Items -->
	<xsl:template match="news_record">
     <div class="para">
      <div class="icon" style="margin: 0 10px 0 0;">  		
       <xsl:variable name="topicId" select="topic_id"/>
       <xsl:call-template name="topics">
        <xsl:with-param name="logo-id" select="//channel_record/topics/topic[topic_id = $topicId]/img_file_id" />
        <xsl:with-param name="title" select="//channel_record/topics/topic[topic_id = $topicId]/title" />
        <xsl:with-param name="link" select="//channel_record/topics/topic[topic_id = $topicId]/link" />
       </xsl:call-template>
      </div>
      <div class="paracontent">
       <h3>
        <xsl:choose>
         <xsl:when test="link[. != '']">
         <xsl:variable name="linkToNews"><xsl:value-of select="link"/></xsl:variable>
         <a id="title" style="cursor:pointer;">
         <xsl:attribute name="onclick">window.open('<xsl:value-of select="$linkToNews"/>','_blank');</xsl:attribute>       
         <xsl:value-of select="title"/></a>
         </xsl:when> 
         <xsl:otherwise>
         <xsl:value-of select="title"/>         
         </xsl:otherwise>
        </xsl:choose>
       </h3>
       <p>

		<div id="newsDisplay" style="text-align:justify;text-justify:inter-word;">

        <xsl:value-of select="description" disable-output-escaping="yes"/>
        </div>
       </p>
       <xsl:if test="$logged = 'true'">
	       <div class="attachmentsDownload">
	        <xsl:apply-templates select="attachments/attachment"/>
	       </div>
       </xsl:if>
      </div>
     </div>
     <div class="clear">&nbsp;</div>
	</xsl:template>


	<xsl:template match="p">
     <xsl:value-of select="."/>
	</xsl:template>
	
	<xsl:template match="attachment">
     &nbsp;&nbsp;
     <a style="cursor:pointer;">
     	<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_TITLE_ATTACHMENT_DOWNLOAD')"/></xsl:attribute>
	    <xsl:attribute name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_TITLE_ATTACHMENT_DOWNLOAD')"/></xsl:attribute>
     	<xsl:attribute name="onclick">misys.downloadFile( '<xsl:value-of select="attachment_id"/>', 'news-attachment');</xsl:attribute>
     	<img width="12" height="12" >
	     <xsl:attribute name="src">
	      <xsl:call-template name="get-image-icon">
	       <xsl:with-param name="fileName"><xsl:value-of select="file_name"/></xsl:with-param>
	      </xsl:call-template>
	     </xsl:attribute>
	    </img>	    
     	<b><xsl:value-of select="title"/></b>
     </a>
     &nbsp;&nbsp;
	</xsl:template>
    
	<xsl:template name="topics">
	<xsl:param name="logo-id" />
	<xsl:param name="title" />
	<xsl:param name="link" />
	<xsl:choose>
	 		<xsl:when test="$link[. != '']">
	     <a id="logoLink" style="cursor:pointer;">
	        <xsl:attribute name="onclick">window.open('<xsl:value-of select="$link"/>','_blank');</xsl:attribute>       
	      	<img class="newsIcon" alt="{$title}" title="{$title}" width="40" height="40">
	      	 <xsl:attribute name="src"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/AjaxScreen/action/GetCustomerLogo?logoid=<xsl:value-of select="$logo-id"/></xsl:attribute>
	        </img>
	     </a>
	     </xsl:when>
		<xsl:otherwise>
	     <img class="newsIcon" alt="{$title}" title="{$title}" width="40" height="40">
	       <xsl:attribute name="src"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/AjaxScreen/action/GetCustomerLogo?logoid=<xsl:value-of select="$logo-id"/></xsl:attribute>
	     </img>
	     </xsl:otherwise>
	</xsl:choose>
	</xsl:template>
</xsl:stylesheet>