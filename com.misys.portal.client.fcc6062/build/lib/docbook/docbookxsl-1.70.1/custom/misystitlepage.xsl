<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0">
<!-- Cover page master -->
<xsl:template name="user.pagemasters">
	<fo:simple-page-master page-height="297mm" page-width="210mm" margin-top="0mm" margin-left="0mm" margin-right="0mm" margin-bottom="0mm" master-name="coversequence-first">
		<fo:region-body margin-top="0mm" margin-left="0mm" margin-right="0mm" margin-bottom="0mm"
		background-position="bottom right" 
		background-repeat="no-repeat"
		background-image="./images/titlepagegraphic.png"/>
		<!-- <fo:region-before  extent="62.99mm" background-color="#2ab5b2"/> -->
		<fo:region-after  extent="0mm"/>
		<fo:region-start  extent="0mm"/>
		<fo:region-end extent="0mm"/>
	</fo:simple-page-master>
	
	<fo:page-sequence-master master-name="coversequence">
	  <fo:repeatable-page-master-alternatives>
		<fo:conditional-page-master-reference 
			master-reference="coversequence-first" page-position="first"/>   <!-- Only the first page uses a customized page master. -->
        <fo:conditional-page-master-reference master-reference="titlepage-odd"/>
	  </fo:repeatable-page-master-alternatives>
	</fo:page-sequence-master>
	</xsl:template>
	
<xsl:template name="select.user.pagemaster">
  <xsl:param name="element"/>
  <xsl:param name="pageclass"/>
  <xsl:param name="default-pagemaster"/>

  <!-- by default, return the default. But if you've created your own
       pagemasters in user.pagemasters, you might want to select one here. -->
       <xsl:choose>
          <xsl:when test="$pageclass = 'titlepage'">coversequence</xsl:when>
       <xsl:otherwise>
		  <xsl:value-of select="$default-pagemaster"/>
	  </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>