<?xml version="1.0" encoding="utf-8"?>

<!--

Written by Olivier Berthier - NEOMAlogic (21 Oct 2002)

Remotely based on Pretty XML Tree Viewer 1.0 (15 Oct 2001):
An XPath/XSLT visualisation tool for XML documents
Written by Mike J. Brown and Jeni Tennison.

-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" indent="no"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>XML Pretty View</title>
        <link type="text/css" rel="stylesheet" href="/content/css/tree-view.css"/>
      </head>
      <body>
        <h3>XML Pretty View</h3>
        <xsl:apply-templates select="." mode="render"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="/" mode="render">
    <xsl:apply-templates mode="render"/>
  </xsl:template>

  <xsl:template match="*" mode="render">
    <xsl:if test="normalize-space(.) != ''">
        
        <br/>
        
        <xsl:choose>
           <xsl:when test="count(ancestor::*)>2">
             <xsl:for-each select="ancestor::*">
                <span>
                	 <xsl:if test="position()>2">
                      <xsl:attribute name="class">name<xsl:value-of select="position()-1"/></xsl:attribute>
                   </xsl:if>
                   &#160;&#160;&#160;
                </span>
             </xsl:for-each>   
           </xsl:when>
           <xsl:otherwise>
             <br/>
             <xsl:for-each select="ancestor::*">
                   &#160;&#160;&#160;
             </xsl:for-each>
           </xsl:otherwise>
        </xsl:choose>

        <span>
           <xsl:attribute name="class">name<xsl:value-of select="count(ancestor::*)"/></xsl:attribute>
           &#160;
           <xsl:call-template name="prettyelement">
		        <xsl:with-param name="theName" select="concat(translate(substring(local-name(), 1, 1), 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'),substring(local-name(), 2))"/>
   		  </xsl:call-template>
   		  &#160;
         </span>

         <xsl:apply-templates mode="render"/>
       
    </xsl:if>
  </xsl:template>

  <xsl:template match="text()" mode="render">
    <xsl:if test="normalize-space(translate(translate(., '&#xA;&#xD;', '  '), '&#x9;', ' ')) != ''">
       <xsl:text>&#160; : &#160;&#160;</xsl:text>
       <span class="value">
         <!-- make spaces be non-breaking spaces, since this is HTML -->
         <xsl:call-template name="escape-ws">
           <xsl:with-param name="text" select="translate(.,' ','&#160;')"/>
         </xsl:call-template>
       </span>
    </xsl:if>
  </xsl:template>

  <!-- recursive template to escape linefeeds, tabs -->
  <xsl:template name="escape-ws">
    <xsl:param name="text"/>
    <xsl:choose>
      <xsl:when test="contains($text, '&#xA;')">
        <xsl:call-template name="escape-ws">
          <xsl:with-param name="text" select="substring-before($text, '&#xA;')"/>
        </xsl:call-template>
        <span class="escape">\n</span>
        <xsl:call-template name="escape-ws">
          <xsl:with-param name="text" select="substring-after($text, '&#xA;')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="contains($text, '&#x9;')">
        <xsl:value-of select="substring-before($text, '&#x9;')"/>
        <span class="escape">\t</span>
        <xsl:call-template name="escape-ws">
          <xsl:with-param name="text" select="substring-after($text, '&#x9;')"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise><xsl:value-of select="$text"/></xsl:otherwise>
    </xsl:choose>
  </xsl:template>

 <xsl:template name="prettyelement">
    <xsl:param name="theName" />
    <xsl:param name="prettyName" />
    <xsl:choose>
       <xsl:when test="$theName">
          <xsl:choose>
             <xsl:when test="translate(substring($theName, 1, 1), 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ') = substring($theName, 1, 1)">
                <xsl:call-template name="prettyelement">
                   <xsl:with-param name="theName" select="substring($theName, 2)" />
                   <xsl:with-param name="prettyName" select="concat($prettyName, concat(' ', substring($theName, 1, 1)))" />
                </xsl:call-template>
             </xsl:when>
             <xsl:otherwise>
                <xsl:call-template name="prettyelement">
                   <xsl:with-param name="theName" select="substring($theName, 2)" />
                   <xsl:with-param name="prettyName" select="concat($prettyName, substring($theName, 1, 1))" />
                </xsl:call-template>
             </xsl:otherwise>   
          </xsl:choose>
       </xsl:when>
       <xsl:otherwise>
          <xsl:value-of select="$prettyName" />
       </xsl:otherwise>
    </xsl:choose>
 </xsl:template>

</xsl:stylesheet>
