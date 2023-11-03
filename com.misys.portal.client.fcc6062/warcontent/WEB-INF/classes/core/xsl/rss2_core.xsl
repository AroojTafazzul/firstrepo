<?xml version="1.0" encoding="UTF-8" ?> 
<!--
   Copyright (c) 2000-2001 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
	Derived from: Kevin A Burton (burton@apache.org)
	This product includes software developed by the Java Apache Project
   (http://java.apache.org/)."
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:downlevel="http://my.netscape.com/rdf/simple/0.9/"
                xmlns:appdata="xalan://com.misys.portal.common.tools.GTPApplicationData"
                version="1.0"
                exclude-result-prefixes="appdata">
    <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />

	 <!-- Get the number of items to display -->
    <xsl:param name="item_displayed" select="number(10)"/>

    <!-- BEGIN /document node support for RSS-->
    <xsl:template match="/rss">
     <xsl:apply-templates select="channel"/>
     <ul class="bulleted-list">
      <xsl:apply-templates select="channel/item[$item_displayed>=position()]"/>
     </ul>
     <xsl:apply-templates select="channel/textinput"/>            
    </xsl:template>
    <xsl:template match="/rdf:RDF">
    <div>
     <xsl:apply-templates select="downlevel:channel"/>
     <xsl:apply-templates select="downlevel:item[$item_displayed>=position()]"/>
     <xsl:apply-templates select="downlevel:textinput"/> 
    </div>
    </xsl:template>

    <!-- END /document node support for RSS-->    
    <xsl:template match="item">
     <xsl:variable name="description" select="downlevel:description"/>
     <li>
      <a>
	   <xsl:attribute name="href"><xsl:value-of select="link"/></xsl:attribute>
       <xsl:value-of select="title"/>
      </a>
      <xsl:if test="$description != ''">
       <xsl:value-of select="$description"/>
      </xsl:if>
     </li>   
    </xsl:template>
    
    <xsl:template match="channel">
     <xsl:variable name="description" select="description"/>    
     <xsl:if test="$description != ''">
      <p>
       <xsl:apply-templates select="image"/>
       <xsl:value-of select="$description"/>            
      </p>
     </xsl:if> 
    </xsl:template>

    <xsl:template match="downlevel:item">
     <xsl:variable name="description" select="downlevel:description"/>
     <li>
      <a>
	   <xsl:attribute name="href"><xsl:value-of select="downlevel:link"/></xsl:attribute>
       <xsl:value-of select="downlevel:title"/>
      </a>
      <p>
       <xsl:if test="$description != ''">
        <xsl:value-of select="$description"/>            
       </xsl:if>
      </p>
     </li>
    </xsl:template>
    
    <xsl:template match="downlevel:channel">
     <xsl:variable name="description" select="downlevel:description"/>
     <xsl:if test="$description != ''">
      <p>
       <xsl:apply-templates select="../downlevel:image"/>
       <xsl:value-of select="$description"/>
      </p>
     </xsl:if>  
    </xsl:template>
    
    <!-- BEGIN TEXTINPUT SUPPORT -->
    <xsl:template match="downlevel:textinput">
     <form>
	  <xsl:attribute name="action"><xsl:value-of select="./downlevel:link"/></xsl:attribute>
      <xsl:value-of select="./downlevel:description"/>
      <br/>
      <input type="text" name="{./downlevel:name}" value="">
	   <xsl:attribute name="name"><xsl:value-of select="./downlevel:name"/></xsl:attribute>
	  </input>
      <input type="submit" name="submit">
	   <xsl:attribute name="value"><xsl:value-of select="./downlevel:title"/></xsl:attribute>
	  </input>      
     </form>
    </xsl:template>

    <xsl:template match="textinput">
     <form>
	  <xsl:attribute name="action"><xsl:value-of select="./link"/></xsl:attribute>
      <xsl:value-of select="./description"/>
      <br/>
      <input type="text" value="">
	   <xsl:attribute name="name"><xsl:value-of select="./name"/></xsl:attribute>
	  </input>
      <input type="submit" name="submit">
	   <xsl:attribute name="value"><xsl:value-of select="./title"/></xsl:attribute>
	  </input>
     </form>
    </xsl:template>

    
    <!-- END TEXTINPUT SUPPORT -->    
    
    <!-- BEGIN IMAGE SUPPORT -->        

    <xsl:template match="image">
     <!-- 1. Commented out to avoid issues under HTTPS -->
	 <xsl:if test="starts-with(url, '/')">
      <a style="float:right">
	   <xsl:attribute name="href"><xsl:value-of select="./link"/></xsl:attribute>
       <img>
	    <xsl:attribute name="alt"><xsl:value-of select="./title"/></xsl:attribute>
        <xsl:attribute name="title"><xsl:value-of select="./title"/></xsl:attribute>
	    <xsl:attribute name="src"><xsl:value-of select="appdata:getContextPath()"/><xsl:value-of select="./url"/></xsl:attribute>
	   </img>
      </a>
     </xsl:if>
    </xsl:template>

    <xsl:template match="downlevel:image">
     <!-- Commented out to avoid issues under HTTPS -->
	 <xsl:if test="starts-with(url, '/')">
     <a style="float:right">
      <xsl:attribute name="href"><xsl:value-of select="./downlevel:link"/></xsl:attribute>
      <img>
	   <xsl:attribute name="alt"><xsl:value-of select="./downlevel:title"/></xsl:attribute>
	   <xsl:attribute name="src"><xsl:value-of select="appdata:getContextPath()"/><xsl:value-of select="./downlevel:url"/></xsl:attribute>
	   <xsl:attribute name="width"><xsl:value-of select="./downlevel:width"/></xsl:attribute>
	   <xsl:attribute name="height"><xsl:value-of select="./downlevel:height"/></xsl:attribute>
 	  </img>
     </a>
    </xsl:if>
    </xsl:template>  
</xsl:stylesheet>