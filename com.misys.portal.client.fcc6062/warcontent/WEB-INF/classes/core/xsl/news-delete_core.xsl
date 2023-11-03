<?xml version="1.0" encoding="UTF-8" ?>

<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization" 
		xmlns:appdata="xalan://com.misys.portal.common.tools.GTPApplicationData"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		exclude-result-prefixes="localization appdata">
		
		<xsl:param name="rundata"/>
		<xsl:param name="contextPath"/>
		<xsl:param name="servletPath"/>
		<xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
		<xsl:param name="editImage"><xsl:value-of select="$images_path"/>edit.png</xsl:param>
		<xsl:param name="deleteImage"><xsl:value-of select="$images_path"/>delete.png</xsl:param>
		<xsl:param name="upImage"><xsl:value-of select="$images_path"/>pic_up.gif</xsl:param>
		<xsl:param name="downImage"><xsl:value-of select="$images_path"/>pic_down.gif</xsl:param>
		
		
<!--
   Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
	This product includes software developed by the Java Apache Project (http://java.apache.org/).
-->

<!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->

	<!-- <xsl:import href="../OLD/xsl/trade_common.xsl"/>-->
	
	<!-- Get the language code -->
	<xsl:param name="language"/>

  <xsl:param name="provider"/>
  
	<xsl:output method="html" indent="no"/>

	<xsl:template match="/content">
    
        <script type="text/javascript" src="/content/OLD/javascript/richtext.js"></script>
        <script type="text/javascript" src="/content/OLD/javascript/news.js"></script>
		
        <script type="text/javascript">
            var nb_rows = '<xsl:value-of select="count(./channel/item)"/>';
        </script>
      
        <table border="0" cellspacing="0" cellpadding="0">
            <xsl:apply-templates select="/content/channel/item"/>
        </table>

       <form name="fakeform1" accept-charset="UNKNOWN" method="POST" enctype="multipart/form-data">
          <xsl:attribute name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/NewsScreen</xsl:attribute>
          <input type="hidden" name="operation" value=""/>
          <input type="hidden" name="option" value="INTERNAL"/>
          <input type="hidden" name="provider">
            <xsl:attribute name="value">
              <xsl:call-template name="quote_replace">
                <xsl:with-param name="input_text" select="$provider"/>
              </xsl:call-template>
            </xsl:attribute>
          </input>
          <input type="hidden" name="item_no" value=""/>
          <input type="hidden" name="sort" value=""/>
       </form>

	</xsl:template>

	<xsl:template match="/content/channel/item">
	
        <tr width="100%">
        <xsl:attribute name="row_id"><xsl:value-of select="position()"/></xsl:attribute>
        <td width="100%" colspan="2">
        <hr><!--breaker--></hr>
        </td>
        </tr>

        <tr width="100%">
        
				<td width="60" align="center" valign="top">
		        <xsl:call-template name="topics">
		            <xsl:with-param name="topic"><xsl:value-of select="./topic"/></xsl:with-param>
		        </xsl:call-template>
				</td>
		
				<td width="100%" align="left" valign="top">
				<xsl:choose>
   				<xsl:when test="link[. != '']">
   					<a target="_blank">	
   						<xsl:attribute name="href"><xsl:value-of select="link"/></xsl:attribute>
   						<b><xsl:value-of select="./title"/></b>
   					</a>
   				</xsl:when>	
   				<xsl:otherwise>
  						<b><xsl:value-of select="./title"/></b>			
   				</xsl:otherwise>
  				</xsl:choose>
					<xsl:apply-templates select="./quote"/>
					<p align="left"><xsl:value-of select="./description" disable-output-escaping="yes"/></p>
				</td>
				<td align="right" valign="middle">
					<a href="javascript:void(0)">
						<xsl:attribute name="onclick">fncModifyNews('<xsl:value-of select="position()"/>');return false;</xsl:attribute>
						<img border="0">
							<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($editImage)"/></xsl:attribute>
							<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_MODIFY')"/></xsl:attribute>
						</img>
					</a>
				</td>
        <td>&nbsp;</td>
				<td align="right" valign="middle">
					<a href="javascript:void(0)">
						<xsl:attribute name="onclick">fncDeleteNews('<xsl:call-template name="quote_replace"><xsl:with-param name="input_text" select="./title"/></xsl:call-template>','<xsl:value-of select="position()"/>');return false;</xsl:attribute>
						<img border="0">
							<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($deleteImage)"/></xsl:attribute>
							<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_DELETE')"/></xsl:attribute>
						</img>
					</a>
				</td>
        <td>&nbsp;</td>
				<td align="right" valign="middle">
          <table>
            <xsl:if test="position() != 1">
              <tr>
                <td>
                  <a href="javascript:void(0)">
                    <xsl:attribute name="onclick">fncSortUp('<xsl:value-of select="position()"/>');return false;</xsl:attribute>
                    <img border="0">
                      <xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($upImage)"/></xsl:attribute>
                      <xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_SORT_UP')"/></xsl:attribute>
                    </img>
                  </a>
                </td>
              </tr>
            </xsl:if>
            <xsl:if test="position() != count(//content/channel/item)">
              <tr>
                <td>
                  <a href="javascript:void(0)">
                    <xsl:attribute name="onclick">fncSortDown('<xsl:value-of select="position()"/>');return false;</xsl:attribute>
                    <img border="0">
                      <xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($downImage)"/></xsl:attribute>
                      <xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_SORT_DOWN')"/></xsl:attribute>
                    </img>
                  </a>
                </td>
              </tr>
           </xsl:if>
          </table>
				</td>
       </tr>
               
	</xsl:template>

	<xsl:template match="/content/channel/item/quote">

        <p align="left">from:
				<a target="_new">
					<xsl:attribute name="href"><xsl:value-of select="./link"/></xsl:attribute>
					<xsl:value-of select="./author"/>
				</a>
			</p>
        <xsl:apply-templates select="./p"/>

	</xsl:template>

	<xsl:template match="p">
      <p>
          <i>
              <xsl:value-of select="."/>
          </i>
      </p>
	</xsl:template>
    
	<xsl:template name="topics">
		<xsl:param name="topic"/>

		<xsl:variable name="link"  select="/content/channel/topics/entry[@name=$topic]/image/link"/>
		<xsl:variable name="url"   select="/content/channel/topics/entry[@name=$topic]/image/url"/>
		<xsl:variable name="title" select="/content/channel/topics/entry[@name=$topic]/image/title"/>
		<center>
			<a target="_blank">
				<xsl:attribute name="href"><xsl:value-of select="$link"/></xsl:attribute>
        		<img border="0">
					<xsl:attribute name="src"><xsl:value-of select="appdata:getContextPath()"/><xsl:value-of select="$url"/></xsl:attribute>
					<xsl:attribute name="alt"><xsl:value-of select="$title"/></xsl:attribute>
				</img>
        	</a>
		</center>
	</xsl:template>
	
	<xsl:template name="quote_replace">
	  <xsl:param name="input_text"/>
	  <xsl:variable name="squote"><xsl:text>'</xsl:text></xsl:variable>
	  <xsl:choose>
			<xsl:when test="contains($input_text,$squote)">
				<xsl:value-of select="substring-before($input_text,$squote)"/>\<xsl:value-of select="$squote"/>
				<xsl:call-template name="quote_replace">
					<xsl:with-param name="input_text" select="substring-after($input_text,$squote)"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$input_text"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

</xsl:stylesheet>

