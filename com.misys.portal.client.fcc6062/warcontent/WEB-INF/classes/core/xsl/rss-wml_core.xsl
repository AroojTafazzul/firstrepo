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
                exclude-result-prefixes="downlevel rdf"
                version="1.0">

    <xsl:output indent="no" 
                method="xml"
                standalone="no"
                doctype-system="http://www.wapforum.org/DTD/wml_1.1.xml"
                doctype-public="-//WAPFORUM//DTD WML 1.1//EN"/>

        <!--
        <!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
        -->
    
    
    <!-- BEGIN /document node support for RSS-->
    <xsl:template match="/rss">
        <wml>

            <template>
                <do type="accept" label="Back">
                    <prev/>
                </do>
            </template>        
            
            <card id="init">
						<xsl:attribute name="title"><xsl:value-of select="./title"/></xsl:attribute>
                <xsl:apply-templates select="channel"/>
                <xsl:apply-templates select="channel/item"/>
            </card>

        </wml>
        
    </xsl:template>


    <xsl:template match="/rdf:RDF">
        <wml>

            <template>
                <do type="accept" label="Back">
                    <prev/>
                </do>
            </template>


            <xsl:apply-templates select="downlevel:channel"/>
            
        </wml>
    </xsl:template>

    <!-- END /document node support for RSS-->    
    
    <xsl:template match="item">

        <xsl:variable name="description"     select="description"/>
    
        <p>
            <b><xsl:value-of select="title"/></b>
        </p>

        <xsl:if test="$description != ''">
           <p>
               <xsl:value-of select="$description"/>            
           </p>
       </xsl:if>
        
    </xsl:template>
    

    <xsl:template match="downlevel:item">

        <xsl:variable name="description"     select="downlevel:description"/>
    
        <p>
           <b><xsl:value-of select="downlevel:title"/></b>
        </p>

        <xsl:if test="$description != ''">
            <p>
                <xsl:value-of select="$description"/>            
            </p>
        </xsl:if>

    </xsl:template>


   <xsl:template match="channel">

        <p>
            <xsl:value-of select="./title"/>
        </p>

   </xsl:template>
    
    <xsl:template match="downlevel:channel">

        <card id="init">
				<xsl:attribute name="title"><xsl:value-of select="/downlevel:title"/></xsl:attribute>

            <p>
                <xsl:value-of select="./downlevel:title"/> 
            </p>

            <xsl:apply-templates select="../downlevel:item"/>
        
        </card>
       
    </xsl:template>
    

    <!-- 
    FIX ME:
    
    Add <image> support here through wbmp support.
    Add <textinput> support
    -->
    
</xsl:stylesheet>



