<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet xmlns:xsl = "http://www.w3.org/1999/XSL/Transform"
                xmlns:rdf = "http://www.w3.org/1999/02/22-rdf-syntax-ns#"
                xmlns:ocs = "http://alchemy.openjava.org/ocs/ocs-syntax#"
                xmlns:dc  = "http://purl.org/dc/elements/1.0/"
                version   = "1.0">

    <xsl:output indent="no"/>
                
    <xsl:template match="/rdf:RDF">

        <registry>
            <portlets>
                <xsl:apply-templates select="./rdf:description/rdf:description"/>
            </portlets>
        </registry>

    </xsl:template>
    
    <xsl:template match="/rdf:RDF/rdf:description/rdf:description">

        <!--
        Only known formats are RSS 0.90 and RSS 0.91
        -->

        <xsl:variable name="format" select="./rdf:description/ocs:format"/>

        <xsl:variable name="url" select="./rdf:description/@about"/>        

        
        <xsl:comment>
        Format: <xsl:value-of select="$format"/>
        </xsl:comment>

        <xsl:if test="$format = 'http://my.netscape.com/rdf/simple/0.9/'">
            <entry type="ref" parent="RSS">
					<xsl:attribute name="name"><xsl:value-of select="$url"/></xsl:attribute>
                <url><xsl:value-of select="$url"/></url>
                <parameter name="stylesheet" value="/content/xsl/rss.xsl"/>
            </entry>
        </xsl:if>

        
        <xsl:if test="$format = 'http://my.netscape.com/publish/formats/rss-0.91.dtd'">
            <entry type="ref" parent="RSS">
					<xsl:attribute name="name"><xsl:value-of select="$url"/></xsl:attribute>
                <url><xsl:value-of select="$url"/></url>
                <parameter name="stylesheet" value="/content/xsl/rss.xsl"/>
            </entry>
        </xsl:if>
        
            
    </xsl:template>


</xsl:stylesheet>

