<?xml version="1.0" encoding="UTF-8"?>
<!--Very basic stylesheet that transform some html tags in DocBook tag -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="xml"/>
	<xsl:template match="/">
		<xsl:apply-templates select="BODY"/>
	</xsl:template>
	<xsl:template match="BODY">
		<section>
			<title></title>
			<xsl:apply-templates />
		</section>
	</xsl:template>
	<xsl:template match="P">
		<para role="TEXT">
			<xsl:apply-templates />
		</para>
	</xsl:template>
	<xsl:template match="TABLE">
		<xsl:variable name="nbCols" select="count(TR[1]/TD)"/>
		<informaltable role="TEXT">
			<tgroup cols="{$nbCols}">
				<xsl:choose>
					<xsl:when test="$nbCols = 3">
						<colspec colname="c1" colwidth="3.0*" />
						<colspec colname="c2" colwidth="1.0*" />
						<colspec colname="c3" colwidth="6.0*" />
					</xsl:when>
					<xsl:when test="$nbCols = 2">
						<colspec colname="c1" colwidth="1.0*" />
						<colspec colname="c2" colwidth="1.5*" />
					</xsl:when>
				</xsl:choose>
				<xsl:if test="count(TR) &gt; 1">
					<thead>
						<row>
							<xsl:for-each select="TR[1]/TD">
								<xsl:call-template name="td"/>
							</xsl:for-each>
						</row>
					</thead>
				</xsl:if>
				<tbody>
					<xsl:choose>
						<xsl:when test="count(TR) &gt; 1">
							<xsl:apply-templates select="TR[position() &gt; 1]">
								<xsl:with-param name="nbCols">
									<xsl:value-of select="$nbCols"/>
								</xsl:with-param>
							</xsl:apply-templates>
						</xsl:when>
						<xsl:otherwise>
							<xsl:apply-templates>
								<xsl:with-param name="nbCols">
									<xsl:value-of select="$nbCols"/>
								</xsl:with-param>
							</xsl:apply-templates>
						</xsl:otherwise>
					</xsl:choose>
				</tbody>
			</tgroup>
		</informaltable>
	</xsl:template>
	<xsl:template name="colspec">
		<xsl:for-each select="TR[1]/TD">
			<colspec colname="c1" colwidth="3.0*" />
			<colspec colname="c2" colwidth="1.0*" />
			<colspec colname="c3" colwidth="6.0*" />
		</xsl:for-each>
	</xsl:template>
	<xsl:template match="THEAD">
		<xsl:param name="nbCols"/>
		<thead>
			<row>
				<xsl:for-each select="TR/TH">
					<xsl:call-template name="th">
						<xsl:with-param name="colspan">
							<xsl:value-of select="$nbCols" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:for-each>
			</row>
		</thead>
	</xsl:template>
	<xsl:template match="TBODY/TR">
		<xsl:param name="nbCols"/>
		<tbody>
			<row>
				<xsl:for-each select="TD">
					<xsl:call-template name="td">
						<xsl:with-param name="colspan">
							<xsl:value-of select="$nbCols" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:for-each>
			</row>
		</tbody>
	</xsl:template>
	<xsl:template match="TR" >
		<xsl:param name="nbCols"/>
		<row>
			<xsl:for-each select="TD">
				<xsl:call-template name="td">
					<xsl:with-param name="colspan">
						<xsl:value-of select="$nbCols" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
		</row>
	</xsl:template>
	<!--Not work-->
	<xsl:template name="compteColonne">
		<xsl:param name="nbColonne"/>
		<xsl:choose>
			<xsl:when test="./TBODY/TR">
				<xsl:for-each select="../TBODY/TR">
					<xsl:if test="count(./TD) &gt; $nbColonne">
						<xsl:call-template name="compteColonne">
							<xsl:with-param name="nbColonne">
								<xsl:value-of select="count(.)"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:variable name="aa">
					<xsl:for-each select="./TR">
						<xsl:if test="count(TD) &gt; $nbColonne">
							<xsl:call-template name="compteColonne">
								<xsl:with-param name="nbColonne" 
									select="count(TD)"/>
							</xsl:call-template>
						</xsl:if>
					</xsl:for-each>
				</xsl:variable>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:value-of select="$nbColonne"/>
	</xsl:template>
	<xsl:template name="th">
		<xsl:param name="colspan"/>
		<xsl:attribute name="colspan">
			<xsl:value-of select="$colspan"/>
		</xsl:attribute>
		<entry>
			<xsl:apply-templates />
		</entry>
	</xsl:template>
	<xsl:template name="td">
		<entry>
			<xsl:apply-templates />
		</entry>
	</xsl:template>
	<xsl:template match="UL|OL">
		<itemizedlist>
			<xsl:apply-templates />
		</itemizedlist>
	</xsl:template>
	<xsl:template match="PRE|CODE">
		<programlisting>
			<xsl:apply-templates />
		</programlisting>
	</xsl:template>
	<xsl:template match="UL/LI | OL/LI">
		<listitem>
			<para>
				<xsl:apply-templates />
			</para>
		</listitem>
	</xsl:template>
	<xsl:template match="LI">
		<itemizedlist>
			<xsl:if test="LI[1]">
				<listitem>
					<para>
						<xsl:apply-templates />
					</para>
				</listitem>
			</xsl:if>
			<xsl:for-each select="*/LI[position()>1]">
				<listitem>
					<para>
						<xsl:apply-templates />
					</para>
				</listitem>
			</xsl:for-each>
		</itemizedlist>
	</xsl:template>
	<xsl:template match="IMG">
		<xsl:variable name="src">
			<xsl:choose>
				<xsl:when test="contains(@src,'/content/images/manuals/')">
					<xsl:value-of 
						select="concat('../images/',substring-after(./@src, '/content/images/manuals/'))"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of 
						select="concat('../images/',substring-after(./@src, '/content/images/'))"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<inlinemediaobject>
			<imageobject>
				<imagedata fileref="{$src}" />
			</imageobject>
		</inlinemediaobject>
	</xsl:template>
	<xsl:template match="*">
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="BODY/text()">
		<xsl:variable name="cleanText">
			<xsl:apply-templates />
		</xsl:variable>
		<xsl:if test="string-length(normalize-space($cleanText))">
			<para role="TEXT">
				<xsl:value-of select="$cleanText"/>
			</para>
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>