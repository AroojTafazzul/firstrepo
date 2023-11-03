<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:fo="http://www.w3.org/1999/XSL/Format" version="1.0"
	xmlns:date="http://exslt.org/dates-and-times"
    extension-element-prefixes="date">
	<xsl:import href="../fo/docbook.xsl"/>
	<xsl:import href="misystitlepage.xsl"/>

	<!--Page format -->
	<xsl:param name="paper.type" select="'A4'"/>
	<!--Double side printing definition-->
	<xsl:param name="double.sided" select="0"/>
		<!-- Fonts -->
	<xsl:param name="body.font.family" select="'Arial'"/>
	<xsl:param name="title.font.family" select="'Arial'"/>
	<!-- Widows/ Orphans -->
	<xsl:param name="para.widows" select="2"/>
	<xsl:param name="para.orphans" select="2"/>
	<!-- Global color [deprecated]. These were removed for 5.3-->
	
	
	<!-- Branding Colors Generic -->
	<xsl:variable name="white">#ffffff</xsl:variable>
	<xsl:variable name="charcoal">#414141</xsl:variable>
	<xsl:variable name="teal">#2ab5b2</xsl:variable>
	<xsl:variable name="purple">#6b5da5</xsl:variable>
	<xsl:variable name="blue">#5988c6</xsl:variable>
	<xsl:variable name="red">#e94952</xsl:variable>
	<xsl:variable name="mediumgrey">#858586</xsl:variable>
	<xsl:variable name="pink">#ef85b4</xsl:variable>
	<xsl:variable name="Violet">#694ED6</xsl:variable>
	<xsl:variable name="Fuchsia">#C137A2</xsl:variable>
	<xsl:variable name="LightGrey">#EBEBEB</xsl:variable>
	<!-- Branding Colors Banking -->
	<xsl:variable name="orange">#f69257</xsl:variable>
	<xsl:variable name="peach">#f18881</xsl:variable>

	<!--display URL after ulink-->
	<xsl:param name="ulink.show" select="0"></xsl:param>
	<!--Header on blank page or not-->
	<xsl:param name="headers.on.blank.pages" select="0"/>
	<xsl:param name="hyphenate">true</xsl:param>
	<!--Add(0)/Delete(1) the footer rule
		Note: in this doc, we don't use predifined header rule-->
	<xsl:param name="footer.rule" select="1"></xsl:param>
	<xsl:param name="header.rule" select="1"></xsl:param>
	<!--Activate program listing background color-->
	<xsl:param name="shade.verbatim" select="0"/>
	<!--Turn off the draft mode entirely -->
	<xsl:param name="draft.mode">no</xsl:param>
	<xsl:param name="page.margin.top" select="'9mm'"></xsl:param>
	<xsl:param name="page.margin.bottom" select="'16mm'"></xsl:param>
	<xsl:param name="margin.left.inner" select="'25mm'"></xsl:param>
	<xsl:param name="page.margin.outer">
	  <xsl:choose>
	  <xsl:when test="$double.sided != 0">20mm</xsl:when>
	    <xsl:otherwise>20mm</xsl:otherwise>
	  </xsl:choose>
	</xsl:param>
	<xsl:param name="page.margin.inner">
	  <xsl:choose>
	    <xsl:when test="$double.sided != 0">25mm</xsl:when>
	    <xsl:otherwise>25mm</xsl:otherwise>
	  </xsl:choose>
	</xsl:param>
	<xsl:param name="body.margin.top" select="'15mm'"></xsl:param>
	<xsl:param name="body.margin.bottom" select="'10mm'"></xsl:param>
	<xsl:param name="body.start.indent"  select="'0mm'"></xsl:param>
	<!-- <xsl:param name="body.end.indent"  select="'3cm'"></xsl:param>-->
	
	<xsl:param name="title.margin.left">
 	 <xsl:choose>
		<xsl:when test="$passivetex.extensions != 0">0pt</xsl:when>
    	<xsl:otherwise>0pt</xsl:otherwise>
 	 </xsl:choose>
	</xsl:param>
	
	<!--Header rule customisation-->
	<!--Note, the code below is not used for the manual generation
		because we add create a rule that fit better. Just here for information-->
	<xsl:template name="head.sep.rule">
	  <xsl:param name="pageclass"/>
 	 <xsl:param name="sequence"/>
	  <xsl:param name="gentext-key"/>
		<xsl:if test="$header.rule != 0">
			<!--<xsl:attribute name="border-width">1</xsl:attribute>-->
			<xsl:attribute name="padding-bottom">10mm</xsl:attribute>
			<xsl:attribute name="border-bottom-width">0.5pt</xsl:attribute>
			<xsl:attribute name="border-bottom-style">solid</xsl:attribute>
			<xsl:attribute name="border-bottom-color">black</xsl:attribute>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="foot.sep.rule">
  <xsl:param name="pageclass"/>
  <xsl:param name="sequence"/>
  <xsl:param name="gentext-key"/>

  <xsl:if test="$footer.rule != 0">
    <xsl:attribute name="border-top-width">0.5pt</xsl:attribute>
    <xsl:attribute name="border-top-style">solid</xsl:attribute>
    <xsl:attribute name="border-top-color">black</xsl:attribute>
  </xsl:if>
	</xsl:template>
	<!--Header and footer customisation-->
	
	<xsl:template name="header.content">
		<xsl:param name="pageclass" select="''"/>
		<xsl:param name="sequence" select="''"/>
		<xsl:param name="position" select="''"/>
		<xsl:param name="gentext-key" select="''"/>
		<!--definition of header style wether the printing option is setted to double sided or not-->
		<xsl:variable name="candidate">
			<xsl:choose>
				<xsl:when test="$double.sided != 0  and $sequence != 'even'">
					<!-- sequence can be odd, even, first, blank -->
					<!-- position can be left, center, right -->
					<xsl:choose>
						<xsl:when test="$position = 'right'">
						<fo:block end-indent="12mm" >
							<fo:external-graphic src="url(./images/header.gif)" height="7mm" content-height="scale-to-fit"/>
							</fo:block>
							<!--<fo:block>
								<xsl:attribute name="font-size">
									<xsl:value-of 
										select="$body.font.master * 1.1"></xsl:value-of>
									<xsl:text>pt</xsl:text>
								</xsl:attribute>
								<xsl:value-of 
									select="/book/bookinfo/corpauthor"/>
							</fo:block>
							<fo:block>
								<xsl:value-of 
									select="/book/bookinfo/title/productname"/>
							</fo:block>-->
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="$double.sided != 0  and $sequence = 'even'">
					<!-- sequence can be odd, even, first, blank -->
					<!-- position can be left, center, right -->
					<xsl:choose>
						<xsl:when test="$position = 'left'">
							<fo:block end-indent="12mm" >
							<fo:external-graphic src="url(./images/header.gif)" height="7mm" content-height="scale-to-fit"/>
							</fo:block>
							<!--<fo:block>
								<xsl:attribute name="font-size">
									<xsl:value-of 
										select="$body.font.master * 1.1"></xsl:value-of>
									<xsl:text>pt</xsl:text>
								</xsl:attribute>
								<xsl:value-of 
									select="/book/bookinfo/corpauthor"/>
							</fo:block>
							<fo:block>
								<xsl:value-of 
									select="/book/bookinfo/title/productname"/>
							</fo:block>-->
						</xsl:when>
					</xsl:choose>
				</xsl:when>
				
				<xsl:otherwise>
					<!-- sequence can be odd, even, first, blank -->
					<!-- position can be left, center, right -->
					<xsl:choose>
						<xsl:when test="$position = 'left'">
							<!--<fo:block start-indent="12mm" >
								<fo:external-graphic src="url(./images/header.gif)" height="7mm" content-height="scale-to-fit"/>
							</fo:block>-->												
							<fo:block>
								<fo:table width="166mm">
								<fo:table-column column-width="116mm"/>
								<fo:table-column column-width="50mm"/>
									
								  <fo:table-body>
										<fo:table-row>
											<!-- Header Caption -->
											<fo:table-cell>
												<fo:block text-align="left">
													<xsl:attribute name="font-size">
													<xsl:value-of 
														select="$body.font.master * 0.7"></xsl:value-of>
													<xsl:text>pt</xsl:text>
													</xsl:attribute>
													<xsl:attribute name="color">
													 <xsl:value-of select="$charcoal"/>
												    </xsl:attribute>
												    <xsl:value-of select="/book/bookinfo/title[1]"/>&#160;
													<xsl:value-of select="/book/bookinfo/releaseinfo"/>&#160;
												</fo:block>												
											</fo:table-cell>
											<!-- Header logo -->
											<fo:table-cell>
												<fo:block text-align="right">
													<fo:external-graphic src="url(./images/header1.png)" height="6mm" content-height="scale-to-fit"/>
												</fo:block>
											</fo:table-cell>										
											
										</fo:table-row>
									</fo:table-body>
								</fo:table>
							</fo:block>
							<!-- <fo:block>
								<xsl:attribute name="font-size">
									<xsl:value-of 
										select="$body.font.master * 1.1"></xsl:value-of>
									<xsl:text>pt</xsl:text>
								</xsl:attribute>
								<xsl:value-of 
									select="/book/bookinfo/corpauthor"/>
							</fo:block>
							<fo:block>
								<xsl:value-of 
									select="/book/bookinfo/title/productname"/>
							</fo:block>-->
						</xsl:when>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- Really output a header? -->
		<xsl:choose>
			<xsl:when 
				test="$pageclass = 'titlepage' and $gentext-key = 'book'
                    and $sequence='first'">
				<!-- no, book titlepages have no headers at all -->
			</xsl:when>
			<xsl:when 
				test="$sequence = 'blank' and $headers.on.blank.pages = 0">
				<!-- no output -->
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="$candidate"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--Template dealing the rules that separe header and body of a page-->
	<xsl:template name="header.table">
		<xsl:param name="pageclass" select="''"/>
		<xsl:param name="sequence" select="''"/>
		<xsl:param name="gentext-key" select="''"/>
		<!-- default is a single table style for all headers -->
		<!-- Customize it for different page classes or sequence location -->
		<xsl:choose>
			<xsl:when test="$pageclass = 'index'">
				<xsl:attribute name="margin-left">0pt</xsl:attribute>
			</xsl:when>
		</xsl:choose>
		<xsl:attribute name="padding">0pt</xsl:attribute>
		<xsl:attribute name="margin">0pt</xsl:attribute>
		<xsl:variable name="column1">
			<xsl:choose>
				<xsl:when test="$double.sided = 0">1</xsl:when>
				<xsl:when test="$sequence = 'first' or $sequence = 'odd'"> 
					1</xsl:when>
				<xsl:otherwise>3</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="column3">
			<xsl:choose>
				<xsl:when test="$double.sided = 0">3</xsl:when>
				<xsl:when test="$sequence = 'first' or $sequence = 'odd'"> 
					3</xsl:when>
				<xsl:otherwise>1</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="candidate">
			<fo:table table-layout="fixed">
				<xsl:if test="$double.sided = 0">
					<xsl:attribute name="width">165mm</xsl:attribute>
				</xsl:if>
				<xsl:call-template name="head.sep.rule">
					<xsl:with-param name="pageclass" select="$pageclass"/>
					<xsl:with-param name="sequence" select="$sequence"/>
					<xsl:with-param name="gentext-key" select="$gentext-key"/>
				</xsl:call-template>
				<fo:table-column column-number="1">
					<xsl:attribute name="column-width">
						<xsl:text>proportional-column-width(</xsl:text>
						<xsl:call-template name="header.footer.width">
							<xsl:with-param name="location"> 
								header</xsl:with-param>
							<xsl:with-param name="position" select="$column1"/>
						</xsl:call-template>
						<xsl:text>)</xsl:text>
					</xsl:attribute>
				</fo:table-column>
				<fo:table-column column-number="2">
					<xsl:attribute name="column-width">
						<xsl:text>proportional-column-width(</xsl:text>
						<xsl:call-template name="header.footer.width">
							<xsl:with-param name="location"> 
								header</xsl:with-param>
							<xsl:with-param name="position" select="2"/>
						</xsl:call-template>
						<xsl:text>)</xsl:text>
					</xsl:attribute>
				</fo:table-column>
				<fo:table-column column-number="3">
					<xsl:attribute name="column-width">
						<xsl:text>proportional-column-width(</xsl:text>
						<xsl:call-template name="header.footer.width">
							<xsl:with-param name="location"> 
								header</xsl:with-param>
							<xsl:with-param name="position" select="$column3"/>
						</xsl:call-template>
						<xsl:text>)</xsl:text>
					</xsl:attribute>
				</fo:table-column>
				<fo:table-body>
					<fo:table-row height="14pt">
						<fo:table-cell text-align="left" display-align="before">
							<xsl:if test="$fop.extensions = 0">
								<xsl:attribute name="relative-align"> 
									baseline</xsl:attribute>
							</xsl:if>
							<fo:block>
								<xsl:call-template name="header.content">
									<xsl:with-param name="pageclass" 
										select="$pageclass"/>
									<xsl:with-param name="sequence" 
										select="$sequence"/>
									<xsl:with-param name="position" 
										select="'left'"/>
									<xsl:with-param name="gentext-key" 
										select="$gentext-key"/>
								</xsl:call-template>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell text-align="center" 
							display-align="before">
							<xsl:if test="$fop.extensions = 0">
								<xsl:attribute name="relative-align"> 
									baseline</xsl:attribute>
							</xsl:if>
							<fo:block>
								<xsl:call-template name="header.content">
									<xsl:with-param name="pageclass" 
										select="$pageclass"/>
									<xsl:with-param name="sequence" 
										select="$sequence"/>
									<xsl:with-param name="position" 
										select="'center'"/>
									<xsl:with-param name="gentext-key" 
										select="$gentext-key"/>
								</xsl:call-template>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell text-align="right" 
							display-align="before">
							<xsl:if test="$fop.extensions = 0">
								<xsl:attribute name="relative-align"> 
									baseline</xsl:attribute>
							</xsl:if>
							<fo:block>
								<xsl:call-template name="header.content">
									<xsl:with-param name="pageclass" 
										select="$pageclass"/>
									<xsl:with-param name="sequence" 
										select="$sequence"/>
									<xsl:with-param name="position" 
										select="'right'"/>
									<xsl:with-param name="gentext-key" 
										select="$gentext-key"/>
								</xsl:call-template>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</xsl:variable>
		<!-- Really output a header? -->
		<xsl:choose>
			<xsl:when 
				test="$pageclass = 'titlepage' and $gentext-key = 'book'
                    and $sequence='first'">
				<!-- no, book titlepages have no headers at all -->
			</xsl:when>
			<xsl:when 
				test="$sequence = 'blank' and $headers.on.blank.pages = 0">
				<!-- no output -->
			</xsl:when>
			<xsl:otherwise>
				<xsl:copy-of select="$candidate"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

<xsl:template name="footer.content">
  <xsl:param name="pageclass" select="''"/>
  <xsl:param name="sequence" select="''"/>
  <xsl:param name="position" select="''"/>
  <xsl:param name="gentext-key" select="''"/>

<!--
  <fo:block>
    <xsl:value-of select="$pageclass"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="$sequence"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="$position"/>
    <xsl:text>, </xsl:text>
    <xsl:value-of select="$gentext-key"/>
  </fo:block>
-->

  <fo:block>
    <!-- pageclass can be front, body, back -->
    <!-- sequence can be odd, even, first, blank -->
    <!-- position can be left, center, right -->
    <xsl:choose>
      <xsl:when test="$pageclass = 'titlepage'">
        <!-- nop; no footer on title pages -->
      </xsl:when>

      <xsl:when test="$double.sided != 0 and $sequence = 'even'
                      and $position='left'">
			<fo:block text-align="center">
				<xsl:attribute name="font-size">
					<xsl:value-of 
						select="$body.font.master * 0.7"></xsl:value-of>
					<xsl:text>pt</xsl:text>
				</xsl:attribute>						
				<xsl:text>Page </xsl:text>
				<fo:page-number/>
				<xsl:call-template name="page.count.separator"/>
				<fo:page-number-citation ref-id="TOTALPAGE"/>
			</fo:block>
      </xsl:when>
      
		<xsl:when 
			test="($pageclass='body' or $pageclass='back')  and $position='center' and $sequence !='blank'">
			<fo:block text-align="center">
				<xsl:attribute name="font-size">
				<xsl:value-of 
					select="$body.font.master * 0.7"></xsl:value-of>
				<xsl:text>pt</xsl:text>
				</xsl:attribute>
				<xsl:call-template name="datetime.format"> 
			        <xsl:with-param name="date" select="date:date-time()"/>
			        <xsl:with-param name="format" select="'B Y'"/>
			      </xsl:call-template>
			</fo:block>
		</xsl:when>	

      <xsl:when test="$double.sided != 0 and ($sequence = 'odd' or $sequence = 'first')
                      and $position='right'">
			<fo:block text-align="center">
					<xsl:attribute name="font-size">
						<xsl:value-of 
							select="$body.font.master * 0.7"></xsl:value-of>
						<xsl:text>pt</xsl:text>
					</xsl:attribute>						
				<xsl:text>Page </xsl:text>
				<fo:page-number/>
				<xsl:call-template name="page.count.separator"/>
				<fo:page-number-citation ref-id="TOTALPAGE"/>
			</fo:block>
      </xsl:when>
      
		<xsl:when 
			test="($pageclass='body' or $pageclass='back') and $position='right' and $sequence = 'even' and $sequence != 'blank'">
			<fo:block  text-align="center">
			<xsl:attribute name="font-size">
				<xsl:value-of 
					select="$body.font.master * 0.7"></xsl:value-of>
				<xsl:text>pt</xsl:text>
			</xsl:attribute>
			<xsl:value-of select="/book/bookinfo/subtitle"/>
			</fo:block>
		</xsl:when>		      
      
		<xsl:when 
			test="($pageclass='body' or $pageclass='back')  and $position='left' and ($sequence = 'odd' or $sequence = 'first')">
			<fo:block text-align="left">
			<xsl:attribute name="font-size">
				<xsl:value-of 
					select="$body.font.master * 0.7"></xsl:value-of>
				<xsl:text>pt</xsl:text>
			</xsl:attribute>
			<xsl:value-of select="/book/bookinfo/subtitle"/>
			</fo:block>
		</xsl:when>	      
     
	<xsl:when test="$pageclass='body' or $pageclass='back'">
		<xsl:choose>
	      <xsl:when test="$double.sided = 0 and $position='center'">
				<fo:block text-align="center">
					<xsl:attribute name="font-size">
					<xsl:value-of 
						select="$body.font.master * 0.7"></xsl:value-of>
					<xsl:text>pt</xsl:text>
					</xsl:attribute>
						<xsl:call-template name="datetime.format"> 
					        <xsl:with-param name="date" select="date:date-time()"/>
					        <xsl:with-param name="format" select="'B Y'"/>
					      </xsl:call-template>
				</fo:block>
	      </xsl:when>
      
	      <xsl:when test="$double.sided = 0 and $position='right'">
		   		<fo:block text-align="right">
					<xsl:attribute name="font-size">
					<xsl:value-of 
						select="$body.font.master * 0.7"></xsl:value-of>
					<xsl:text>pt</xsl:text>
					</xsl:attribute>
					<xsl:text>Page </xsl:text>
					<fo:page-number/>
					<xsl:call-template name="page.count.separator"/>
					<fo:page-number-citation ref-id="TOTALPAGE"/>
				</fo:block>
			</xsl:when>
		
		  <xsl:when test="$double.sided = 0 and $position='left'">
				<fo:block text-align="center">
				<xsl:attribute name="font-size">
					<xsl:value-of 
						select="$body.font.master * 0.7"></xsl:value-of>
					<xsl:text>pt</xsl:text>
				</xsl:attribute>
				<xsl:value-of select="/book/bookinfo/subtitle"/>
				</fo:block>
			</xsl:when>
			</xsl:choose>
		</xsl:when>

      <xsl:when test="$sequence='blank'">
        <xsl:choose>
          <xsl:when test="$double.sided != 0 and $position = 'left'">
            <fo:page-number/>
          </xsl:when>
          <xsl:when test="$double.sided = 0 and $position = 'center'">
            <fo:page-number/>
          </xsl:when>
          <xsl:otherwise>
            <!-- nop -->
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>


      <xsl:otherwise>
        <!-- nop -->
      </xsl:otherwise>
    </xsl:choose>
  </fo:block>
</xsl:template>

<!-- Footer container -->
<xsl:template name="footer.table">
  <xsl:param name="pageclass" select="''"/>
  <xsl:param name="sequence" select="''"/>
  <xsl:param name="gentext-key" select="''"/>

  <!-- default is a single table style for all footers -->
  <!-- Customize it for different page classes or sequence location -->

  	
  <xsl:choose>
      <xsl:when test="$pageclass = 'index'">
          <xsl:attribute name="margin-left">0pt</xsl:attribute>
      </xsl:when>
  </xsl:choose>

  <xsl:variable name="column1">
    <xsl:choose>
      <xsl:when test="$double.sided = 0">1</xsl:when>
      <xsl:when test="$sequence = 'first' or $sequence = 'odd'">1</xsl:when>
      <xsl:otherwise>3</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="column3">
    <xsl:choose>
      <xsl:when test="$double.sided = 0">3</xsl:when>
      <xsl:when test="$sequence = 'first' or $sequence = 'odd'">3</xsl:when>
      <xsl:otherwise>1</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="candidate">
	  <xsl:if test="($pageclass = 'body' or $pageclass = 'back') and $sequence != 'blank'">
		      <fo:block padding="0mm" margin="0mm" space-after="-4mm">
	   	  		 <xsl:if test="$double.sided = 0">
   	   			<xsl:attribute name="start-indent">-5mm</xsl:attribute>
   	   			</xsl:if>   
		   	 </fo:block>
	  </xsl:if>
    <fo:table table-layout="fixed" width="100%" padding-top="2mm">  
      <xsl:call-template name="foot.sep.rule">
        <xsl:with-param name="pageclass" select="$pageclass"/>
        <xsl:with-param name="sequence" select="$sequence"/>
        <xsl:with-param name="gentext-key" select="$gentext-key"/>
      </xsl:call-template>
      <fo:table-column column-number="1">
        <xsl:attribute name="column-width">
          <xsl:text>proportional-column-width(</xsl:text>
          <xsl:call-template name="header.footer.width">
            <xsl:with-param name="location">footer</xsl:with-param>
            <xsl:with-param name="position" select="$column1"/>
          </xsl:call-template>
          <xsl:text>)</xsl:text>
        </xsl:attribute>
      </fo:table-column>
      <fo:table-column column-number="2">
        <xsl:attribute name="column-width">
          <xsl:text>proportional-column-width(</xsl:text>
          <xsl:call-template name="header.footer.width">
            <xsl:with-param name="location">footer</xsl:with-param>
            <xsl:with-param name="position" select="2"/>
          </xsl:call-template>
          <xsl:text>)</xsl:text>
        </xsl:attribute>
      </fo:table-column>
      <fo:table-column column-number="3">
        <xsl:attribute name="column-width">
          <xsl:text>proportional-column-width(</xsl:text>
          <xsl:call-template name="header.footer.width">
            <xsl:with-param name="location">footer</xsl:with-param>
            <xsl:with-param name="position" select="$column3"/>
          </xsl:call-template>
          <xsl:text>)</xsl:text>
        </xsl:attribute>
      </fo:table-column>

      <fo:table-body>
	  <!-- <xsl:if test="$pageclass = 'body' or $pageclass = 'back'">
	     <fo:table-row>
          <xsl:attribute name="block-progression-dimension.minimum">
            <xsl:value-of select="$footer.table.height"/>
          </xsl:attribute>
          <fo:table-cell text-align="center"
                         display-align="after" number-columns-spanned="3">
            <xsl:if test="$fop.extensions = 0">
              <xsl:attribute name="relative-align">baseline</xsl:attribute>
            </xsl:if>
		      <fo:block start-indent="-5mm" padding="0mm" margin="0mm" background-color="yellow">
		   	 </fo:block>            
            </fo:table-cell>	
   	    </fo:table-row>
	  	</xsl:if>-->
        <fo:table-row>
          <xsl:attribute name="block-progression-dimension.minimum">
            <xsl:value-of select="$footer.table.height"/>
          </xsl:attribute>
          <fo:table-cell text-align="left"
                         display-align="after">
            <xsl:if test="$fop.extensions = 0">
              <xsl:attribute name="relative-align">baseline</xsl:attribute>
            </xsl:if>
            <fo:block>
              <xsl:call-template name="footer.content">
                <xsl:with-param name="pageclass" select="$pageclass"/>
                <xsl:with-param name="sequence" select="$sequence"/>
                <xsl:with-param name="position" select="'left'"/>
                <xsl:with-param name="gentext-key" select="$gentext-key"/>
              </xsl:call-template>
            </fo:block>
          </fo:table-cell>
          <fo:table-cell text-align="center"
                         display-align="after">
            <xsl:if test="$fop.extensions = 0">
              <xsl:attribute name="relative-align">baseline</xsl:attribute>
            </xsl:if>
            <fo:block>
              <xsl:call-template name="footer.content">
                <xsl:with-param name="pageclass" select="$pageclass"/>
                <xsl:with-param name="sequence" select="$sequence"/>
                <xsl:with-param name="position" select="'center'"/>
                <xsl:with-param name="gentext-key" select="$gentext-key"/>
              </xsl:call-template>
            </fo:block>
          </fo:table-cell>
          <fo:table-cell text-align="right"
                         display-align="after">
            <xsl:if test="$fop.extensions = 0">
              <xsl:attribute name="relative-align">baseline</xsl:attribute>
            </xsl:if>
            <fo:block>
              <xsl:call-template name="footer.content">
                <xsl:with-param name="pageclass" select="$pageclass"/>
                <xsl:with-param name="sequence" select="$sequence"/>
                <xsl:with-param name="position" select="'right'"/>
                <xsl:with-param name="gentext-key" select="$gentext-key"/>
              </xsl:call-template>
            </fo:block>
          </fo:table-cell>
        </fo:table-row>
      </fo:table-body>
    </fo:table>
  </xsl:variable>

  <!-- Really output a footer? -->
  <xsl:choose>
    <xsl:when test="$pageclass='titlepage' and $gentext-key='book'
                    and $sequence='first'">
      <!-- no, book titlepages have no footers at all -->
    </xsl:when>
    <xsl:when test="$sequence = 'blank' and $footers.on.blank.pages = 0">
      <!-- no output -->
    </xsl:when>
    <xsl:otherwise>
      <xsl:copy-of select="$candidate"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


	<!--Change section level 1 title style-->
	<xsl:attribute-set name="section.title.level1.properties">
		<xsl:attribute name="color"><xsl:value-of select="$charcoal"/></xsl:attribute>
		<xsl:attribute name="font-size">
			<xsl:value-of select="$body.font.master * 1.3"/>
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
	</xsl:attribute-set>
	<!--Change section level 2 title style-->
	<xsl:attribute-set name="section.title.level2.properties">
		<xsl:attribute name="font-size">
			<xsl:value-of select="$body.font.master * 1.2"></xsl:value-of>
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
		<xsl:attribute name="color"><xsl:value-of select="$charcoal"/></xsl:attribute>
		<xsl:attribute name="margin-left">0mm</xsl:attribute>
	</xsl:attribute-set>
	<!--Change section level 3 title style-->
	<xsl:attribute-set name="section.title.level3.properties">
		<xsl:attribute name="margin-left">0mm</xsl:attribute>
		<xsl:attribute name="font-size">
			<xsl:value-of select="$body.font.master"></xsl:value-of>
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
		<xsl:attribute name="font-size">
			<xsl:value-of select="$body.font.master * 1.2"></xsl:value-of>
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
		<xsl:attribute name="color"><xsl:value-of select="$charcoal"/></xsl:attribute>
	</xsl:attribute-set>
	
	<!--Activation of Fop extensions (generating bookmarks)-->
	<xsl:param name="fop.extensions" select="0"></xsl:param>
	<xsl:param name="fop1.extensions" select="1"></xsl:param>
	<!--Setting label for section and chapter-->
	<xsl:param name="chapter.autolabel" select="1"/>
	<xsl:param name="section.autolabel" select="1"/>
	<!--include chapter number before the section label-->
	<xsl:param name="section.label.includes.component.label" select="1"/>
	<!--Activation of admons graphics  (note, tip, warning...)-->
	<xsl:param name="admon.graphics" select="0"/>
	<!--Set the path for admons graphics-->
	<xsl:param name="admon.graphics.path"> 
		../../../com.neomalogic.docbook/lib/docbookxsl/images/</xsl:param>
	<!--Extension for the admon graphics-->
	<xsl:param name="admon.graphics.extension" select="'.gif'"/>
	<!--Put or not the text label for the admons-->
	<xsl:param name="admon.textlabel" select="1"></xsl:param>
	<!--inline style customization-->
	<xsl:template match="ulink">
		<xsl:param name="content">
			<xsl:apply-templates/>
		</xsl:param>
		<fo:inline>
		<xsl:attribute name="color"><xsl:value-of select="$Violet"/></xsl:attribute>
			<xsl:attribute name="font-style">italic</xsl:attribute>
			<xsl:copy-of select="$content"/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="productname">
		<xsl:param name="content">
			<xsl:apply-templates/>
		</xsl:param>
		<fo:inline>
			<xsl:attribute name="font-style">italic</xsl:attribute>
			<xsl:if test="parent::entry">
				<xsl:attribute name="font-size">
					<xsl:value-of select="$body.font.master * 0.8"/>
					<xsl:text>pt</xsl:text>
				</xsl:attribute>
			</xsl:if>
			<xsl:copy-of select="$content"/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="guimenu">
		<xsl:param name="content">
			<xsl:apply-templates/>
		</xsl:param>
		<fo:inline> 
			<xsl:attribute name="color"><xsl:value-of select="$charcoal"/></xsl:attribute>
			<xsl:attribute name="font-weight">bold</xsl:attribute>
			<!-- <xsl:attribute name="font-style">italic</xsl:attribute> -->
			<xsl:if test="parent::entry">
				<xsl:attribute name="font-size">
					<xsl:value-of select="$body.font.master * 0.8"/>
					<xsl:text>pt</xsl:text>
				</xsl:attribute>
			</xsl:if>
			<xsl:copy-of select="$content"/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="guisubmenu">
		<xsl:param name="content">
			<xsl:apply-templates/>
		</xsl:param>
		<fo:inline>
			<xsl:attribute name="color"><xsl:value-of select="$Fuchsia"/></xsl:attribute>
			<xsl:attribute name="font-weight">bold</xsl:attribute>
			<xsl:if test="parent::entry">
				<xsl:attribute name="font-size">
					<xsl:value-of select="$body.font.master * 0.8"/>
					<xsl:text>pt</xsl:text>
				</xsl:attribute>
			</xsl:if>
			<xsl:copy-of select="$content"/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="guilabel">
		<xsl:param name="content">
			<xsl:apply-templates/>
		</xsl:param>
		<fo:inline>
			<xsl:attribute name="color"><xsl:value-of select="$charcoal"/></xsl:attribute>
			<xsl:attribute name="font-weight">bold</xsl:attribute>
			<!-- <xsl:attribute name="font-style">italic</xsl:attribute> -->
			<xsl:if test="parent::entry">
				<xsl:attribute name="font-size">
					<xsl:value-of select="$body.font.master * 0.8"/>
					<xsl:text>pt</xsl:text>
				</xsl:attribute>
			</xsl:if>
			<xsl:copy-of select="$content"/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="guiicon">
		<xsl:param name="content">
			<xsl:apply-templates/>
		</xsl:param>
		<fo:inline>
			<xsl:attribute name="color"><xsl:value-of select="$purple"/></xsl:attribute>
			<xsl:attribute name="font-weight">bold</xsl:attribute>
			<!-- <xsl:attribute name="font-style">italic</xsl:attribute> -->
			<xsl:if test="parent::entry">
				<xsl:attribute name="font-size">
					<xsl:value-of select="$body.font.master * 0.8"/>
					<xsl:text>pt</xsl:text>
				</xsl:attribute>
			</xsl:if>
			<xsl:copy-of select="$content"/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="guibutton">
		<xsl:param name="content">
			<xsl:apply-templates/>
		</xsl:param>
		<fo:inline>
			<xsl:attribute name="color"><xsl:value-of select="$Violet"/></xsl:attribute>
			<xsl:attribute name="font-weight">bold</xsl:attribute>
			<!-- <xsl:attribute name="font-style">italic</xsl:attribute> -->
			<xsl:if test="parent::entry">
				<xsl:attribute name="font-size">
					<xsl:value-of select="$body.font.master * 0.8"/>
					<xsl:text>pt</xsl:text>
				</xsl:attribute>
			</xsl:if>
			<xsl:copy-of select="$content"/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="guimenuitem">
		<xsl:param name="content">
			<xsl:apply-templates/>
		</xsl:param>
		<fo:inline>
			<xsl:attribute name="color"><xsl:value-of select="$mediumgrey"/></xsl:attribute>
			<xsl:attribute name="font-weight">bold</xsl:attribute>
			<!--
			<xsl:attribute name="text-decoration">underline</xsl:attribute> -->
			<xsl:if test="parent::entry">
				<xsl:attribute name="font-size">
					<xsl:value-of select="$body.font.master * 0.8"/>
					<xsl:text>pt</xsl:text>
				</xsl:attribute>
			</xsl:if>
			<xsl:copy-of select="$content"/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="sgmltag">
		<xsl:param name="content">
			<xsl:apply-templates/>
		</xsl:param>
		<fo:inline xsl:use-attribute-sets="monospace.properties">
			<xsl:attribute name="color">#000000</xsl:attribute>
			<xsl:if test="parent::entry">
				<xsl:attribute name="font-size">
					<xsl:value-of select="$body.font.master * 0.8"/>
					<xsl:text>pt</xsl:text>
				</xsl:attribute>
			</xsl:if>
			<xsl:copy-of select="$content"/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="varname">
		<xsl:param name="content">
			<xsl:apply-templates/>
		</xsl:param>
		<fo:inline xsl:use-attribute-sets="monospace.properties">
			<xsl:attribute name="color">#000000</xsl:attribute>
			<xsl:if test="parent::entry">
				<xsl:attribute name="font-size">
					<xsl:value-of select="$body.font.master * 0.8"/>
					<xsl:text>pt</xsl:text>
				</xsl:attribute>
			</xsl:if>
			<xsl:copy-of select="$content"/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="database">
		<xsl:param name="content">
			<xsl:apply-templates/>
		</xsl:param>
		<fo:inline>
			<xsl:attribute name="color"><xsl:value-of select="$charcoal"/></xsl:attribute>
			<xsl:if test="parent::entry">
				<xsl:attribute name="font-size">
					<xsl:value-of select="$body.font.master * 0.8"/>
					<xsl:text>pt</xsl:text>
				</xsl:attribute>
			</xsl:if>
			<xsl:copy-of select="$content"/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="parameter">
		<xsl:param name="content">
			<xsl:apply-templates/>
		</xsl:param>
		<fo:inline>
			<xsl:attribute name="font-style">italic</xsl:attribute>
			<xsl:attribute name="color">#000000</xsl:attribute>
			<xsl:if test="parent::entry">
				<xsl:attribute name="font-size">
					<xsl:value-of select="$body.font.master * 0.8"/>
					<xsl:text>pt</xsl:text>
				</xsl:attribute>
			</xsl:if>
			<xsl:copy-of select="$content"/>
		</fo:inline>
	</xsl:template>
	<xsl:template match="filename">
		<xsl:param name="content">
			<xsl:apply-templates/>
		</xsl:param>
		<fo:inline xsl:use-attribute-sets="monospace.properties">
			<xsl:if test="@dir">
				<xsl:attribute name="direction">
					<xsl:choose>
						<xsl:when test="@dir = 'ltr' or @dir = 'lro'"> 
							ltr</xsl:when>
						<xsl:otherwise>rtl</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
			</xsl:if>
			<xsl:attribute name="color">#424142</xsl:attribute>
			<xsl:if test="parent::entry">
				<xsl:attribute name="font-size">
					<xsl:value-of select="$body.font.master * 0.8"/>
					<xsl:text>pt</xsl:text>
				</xsl:attribute>
			</xsl:if>
			<xsl:copy-of select="$content"/>
		</fo:inline>
	</xsl:template>
	
	<!--cover template -->
	<xsl:template name="book.titlepage.recto">
		<fo:block space-after="26mm" padding-top="10mm" padding-bottom="40mm" >
			<!-- <xsl:attribute name="background-color">
			<xsl:value-of select="$teal"/>			--> 
			 <xsl:attribute name="background-image">
				
			</xsl:attribute>
			<fo:external-graphic padding-left="10mm" src="url(./images/header.png)" height="11mm"  content-height="scale-to-fit"/>
		</fo:block>
		<fo:block  space-after="2mm" start-indent="25mm" font-size="30pt" font-weight="bold">
			<xsl:attribute name="color">
				<xsl:value-of select="$white"/>
			</xsl:attribute>
			<xsl:attribute name="font-weight">
				<xsl:value-of select="bold"/>
			</xsl:attribute>
			<xsl:value-of select="/book/bookinfo/title[1]"/>
		</fo:block>
			<!--print the second title for the local service manual
					When we call two time a template with mode book.titlepage.recto.auto.mode
					on another title, the output corresponds with the first, so this technic
					has been chosen-->
			 <xsl:if test="count(/book/bookinfo/title) = 2">
				<fo:block space-after="4mm" start-indent="25mm"  font-size="17pt" font-weight="bold">
					<xsl:attribute name="color">
						<xsl:value-of select="$white"/>
					</xsl:attribute>
					<xsl:attribute name="font-family">
						<xsl:value-of select="$title.fontset"/>
					</xsl:attribute>
					<xsl:value-of select="/book/bookinfo/title[2]"/>
				</fo:block>
			</xsl:if>			
		<fo:block space-after="2mm" start-indent="25mm"  font-size="17pt">
			<xsl:attribute name="color">
				<xsl:value-of select="$white"/>
			</xsl:attribute>
			<xsl:value-of select="/book/bookinfo/subtitle"/>
		</fo:block>
		<fo:block space-after="5mm" start-indent="25mm"  font-size="16pt">
			<xsl:attribute name="color">
				<xsl:value-of select="$white"/>
			</xsl:attribute>
			<xsl:value-of select="/book/bookinfo/releaseinfo"/>
		</fo:block>
		<fo:block margin-top="145mm" start-indent="25mm"  font-size="8pt" margin-right="20mm">
			<xsl:attribute name="color">
				<xsl:value-of select="$white"/>
			</xsl:attribute>
			<!-- <xsl:value-of select="/book/bookinfo/legalnotice[1]"/> -->
		</fo:block>
		<fo:block margin-top="2mm" start-indent="25mm"  font-size="8pt" margin-right="20mm">
			<xsl:attribute name="color">
				<xsl:value-of select="$charcoal"/>
			</xsl:attribute>
			<xsl:value-of select="/book/bookinfo/copyright/symbol"/>&#160;<xsl:value-of select="/book/bookinfo/copyright/holder"/>&#160;<xsl:value-of select="/book/bookinfo/copyright/year"/><xsl:text>.</xsl:text>&#160;<xsl:value-of select="/book/bookinfo/copyright/additionaltext"/>
		</fo:block>
	</xsl:template>

	<!-- Expand this template to add properties to any cell's block -->
	<xsl:template name="table.cell.block.properties">
		<!-- highlight this entry? -->
		<xsl:choose>
			<xsl:when test="ancestor::thead">
				<xsl:attribute name="font-size">
					<xsl:value-of select="$body.font.master * 0.8"/>
					<xsl:text>pt</xsl:text>
				</xsl:attribute>			
				<xsl:attribute name="font-weight">bold</xsl:attribute>
				<xsl:attribute name="color">#FFFFFF</xsl:attribute>
				<xsl:attribute name="background-color"><xsl:value-of select="$Violet"/></xsl:attribute>
				<xsl:attribute name="text-align">center</xsl:attribute>
				<xsl:attribute name="display-align">center</xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="margin">2pt</xsl:attribute>
				<xsl:attribute name="font-size">
					<xsl:value-of select="$body.font.master * 0.8"/>
					<xsl:text>pt</xsl:text>
				</xsl:attribute>				
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--color the first row of table containing thead
		use cell color instead because within this customization, borders aren't displayed-->
	<xsl:template match="informaltable/tgroup/thead/row[1]">
		<xsl:param name="spans"/>
		<fo:table-row>
			<xsl:attribute name="keep-together.within-page">always</xsl:attribute>		
			<xsl:call-template name="anchor"/>
			<xsl:apply-templates select="(entry|entrytbl)[1]">
				<xsl:with-param name="spans" select="$spans"/>
			</xsl:apply-templates>
		</fo:table-row>
		<xsl:if test="following-sibling::row">
			<xsl:variable name="nextspans">
				<xsl:apply-templates select="(entry|entrytbl)[1]" mode="span">
					<xsl:with-param name="spans" select="$spans"/>
				</xsl:apply-templates>
			</xsl:variable>
			<xsl:apply-templates select="following-sibling::row[1]">
				<xsl:with-param name="spans" select="$nextspans"/>
			</xsl:apply-templates>
		</xsl:if>
	</xsl:template>	

<xsl:template match="row">
  <xsl:param name="spans"/>

  <xsl:variable name="bgcolor">
    <xsl:call-template name="dbfo-attribute">
      <xsl:with-param name="pis" select="processing-instruction('dbfo')"/>
      <xsl:with-param name="attribute" select="'bgcolor'"/>
    </xsl:call-template>
  </xsl:variable>
  
    <xsl:variable name="keep.together">
    <xsl:call-template name="dbfo-attribute">
      <xsl:with-param name="pis" select="processing-instruction('dbfo')"/>
      <xsl:with-param name="attribute" select="'keep-together'"/>
    </xsl:call-template>
  </xsl:variable>

  <fo:table-row>
 	<xsl:choose>
      <xsl:when test="$keep.together != ''">
        <xsl:attribute name="keep-together.within-page">
          <xsl:value-of select="$keep.together"/>
        </xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="keep-together.within-page">always</xsl:attribute>      
      </xsl:otherwise>
        </xsl:choose>      
    <xsl:call-template name="anchor"/>
    <xsl:if test="$bgcolor != ''">
      <xsl:attribute name="background-color">
        <xsl:value-of select="$bgcolor"/>
      </xsl:attribute>
    </xsl:if>

    <xsl:apply-templates select="(entry|entrytbl)[1]">
      <xsl:with-param name="spans" select="$spans"/>
    </xsl:apply-templates>
  </fo:table-row>

  <xsl:if test="following-sibling::row">
    <xsl:variable name="nextspans">
      <xsl:apply-templates select="(entry|entrytbl)[1]" mode="span">
        <xsl:with-param name="spans" select="$spans"/>
      </xsl:apply-templates>
    </xsl:variable>

    <xsl:apply-templates select="following-sibling::row[1]">
      <xsl:with-param name="spans" select="$nextspans"/>
    </xsl:apply-templates>
  </xsl:if>
</xsl:template>	

	<!--Set the cell padding of the table-->
	<xsl:attribute-set name="table.cell.padding">
		<xsl:attribute name="padding-left">0.7pt</xsl:attribute>
		<xsl:attribute name="padding-right">0.7pt</xsl:attribute>
		<xsl:attribute name="padding-top">0.6pt</xsl:attribute>
		<xsl:attribute name="padding-bottom">0.6pt</xsl:attribute>
	</xsl:attribute-set>
	<!--Chapter title customization-->
	<xsl:attribute-set name="chapter.titlepage.recto.style">
		<xsl:attribute name="color"><xsl:value-of select="$Fuchsia"/></xsl:attribute>
	</xsl:attribute-set>
	<xsl:attribute-set name="chapter.titlepage.verso.style">
		<xsl:attribute name="color"><xsl:value-of select="$Fuchsia"/></xsl:attribute>
	</xsl:attribute-set>
	<xsl:template match="title" mode="chapter.titlepage.recto.auto.mode">
		<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" 
			xsl:use-attribute-sets="chapter.titlepage.recto.style" 
			font-weight="bold">
			<xsl:attribute name="font-size">
				<xsl:value-of select="$body.font.master * 1.5"/>
				<xsl:text>pt</xsl:text>
			</xsl:attribute>
			<xsl:call-template name="component.title">
				<xsl:with-param name="node" 
					select="ancestor-or-self::chapter[1]"/>
			</xsl:call-template>
		</fo:block>
	</xsl:template>
	<!--Appendix cutomisation-->
	<xsl:attribute-set name="appendix.titlepage.recto.style">
		<xsl:attribute name="color"><xsl:value-of select="$Fuchsia"/></xsl:attribute>
	</xsl:attribute-set>
	<xsl:template match="title" mode="appendix.titlepage.recto.auto.mode">
		<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" 
			xsl:use-attribute-sets="appendix.titlepage.recto.style" 
			margin-left="{$title.margin.left}" font-family="{$title.fontset}" 
			font-weight="bold">
			<xsl:attribute name="font-size">
				<xsl:value-of select="$body.font.master * 1.3"/>
				<xsl:text>pt</xsl:text>
			</xsl:attribute>
			<xsl:call-template name="component.title">
				<xsl:with-param name="node" 
					select="ancestor-or-self::appendix[1]"/>
			</xsl:call-template>
		</fo:block>
	</xsl:template>

	<!--Section title properties settings-->
	<xsl:attribute-set name="section.title.properties">
		<xsl:attribute name="font-family">
			<xsl:value-of select="$title.font.family"/>
		</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute  name="color"><xsl:value-of select="$charcoal"/></xsl:attribute>
		<!-- font size is calculated dynamically by section.heading template -->
		<xsl:attribute name="space-before.minimum">0.8em</xsl:attribute>
		<xsl:attribute name="space-before.optimum">1.0em</xsl:attribute>
		<xsl:attribute name="space-before.maximum">1.2em</xsl:attribute>
		<xsl:attribute name="margin-left">0em</xsl:attribute>
	</xsl:attribute-set>
	<!--setting for admonition (note,tip...)-->
	<xsl:attribute-set name="admonition.properties">
		<xsl:attribute name="space-before.optimum">0.2em</xsl:attribute>
		<xsl:attribute name="space-before.minimum">0em</xsl:attribute>
		<xsl:attribute name="space-before.maximum">0.2em</xsl:attribute>	
	</xsl:attribute-set>
	<!--setting for admonition title-->
	<xsl:attribute-set name="admonition.title.properties">
		<xsl:attribute name="font-size">1em</xsl:attribute>
		<xsl:attribute name="font-weight">bold</xsl:attribute>
		<xsl:attribute name="hyphenate">false</xsl:attribute>
		<!--<xsl:attribute name="space-before.optimum"> 0.2em</xsl:attribute>
		<xsl:attribute name="space-before.minimum"> 0em</xsl:attribute>
		<xsl:attribute name="space-before.maximum"> 0.2em</xsl:attribute>-->
	</xsl:attribute-set>
	<!--settings for the admon text label-->
	<xsl:template name="nongraphical.admonition">
		<xsl:variable name="id">
			<xsl:call-template name="object.id"/>
		</xsl:variable>
		<!--template for the note and other admons-->
		<fo:block space-before.minimum="0.8em" space-before.optimum="1em" 
			space-before.maximum="1.2em" start-indent="1em" end-indent="0in" 
			id="{$id}">
			<xsl:attribute name="border-color"><xsl:value-of select="$Fuchsia"/></xsl:attribute>
			<xsl:attribute name="background-color"><xsl:value-of select="$white"/></xsl:attribute>
			<xsl:attribute name="border-style">solid</xsl:attribute>
			<xsl:attribute name="border-left-width">0em</xsl:attribute>
			<xsl:attribute name="border-top-width">1pt</xsl:attribute>
			<xsl:attribute name="border-bottom-width">1pt</xsl:attribute>
			<xsl:attribute name="border-right-width">0pt</xsl:attribute>
			<fo:table table-layout="fixed" width="100%" keep-together.within-page="always">
				<fo:table-column column-width="proportional-column-width(1)"/>
				<fo:table-body>
					<fo:table-row keep-with-next="always">
						<fo:table-cell>
							<xsl:if test="$admon.textlabel != 0 or title">
								<fo:block keep-with-next='always' 
									xsl:use-attribute-sets="admonition.title.properties">
									<xsl:apply-templates select="." 
										mode="object.title.markup"/>
								</fo:block>
							</xsl:if>
						</fo:table-cell>
					</fo:table-row>
					<fo:table-row>
						<fo:table-cell>
							<fo:block 
								xsl:use-attribute-sets="admonition.properties">
								<xsl:apply-templates/>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>
	<!--Properties of the block that surround the table-->
	<xsl:attribute-set name="table.properties">
		<xsl:attribute name="space-before.minimum">0.5em</xsl:attribute>
		<xsl:attribute name="space-before.optimum">1em</xsl:attribute>
		<xsl:attribute name="space-before.maximum">2em</xsl:attribute>
		<xsl:attribute name="space-after.minimum">0.5em</xsl:attribute>
		<xsl:attribute name="space-after.optimum">1em</xsl:attribute>
		<xsl:attribute name="space-after.maximum">2em</xsl:attribute>
	</xsl:attribute-set>
	<!--Properties of the block that surround the informaltable-->
	<xsl:attribute-set name="informaltable.properties" 
		use-attribute-sets="informal.object.properties">
	</xsl:attribute-set>

	<!--hyphanation activated for verbatim environment like programlisting-->
	<xsl:param name="hyphenate.verbatim" select="1"></xsl:param>
	<!--programlisting style-->
	<xsl:attribute-set name="monospace.verbatim.properties" 
		use-attribute-sets="verbatim.properties">
		<xsl:attribute name="font-family">
			<xsl:value-of select="$monospace.font.family"/>
		</xsl:attribute>
		<xsl:attribute name="font-size">
			<xsl:value-of select="$body.font.master * 0.8"/>
			<xsl:text>pt</xsl:text>
		</xsl:attribute>
		<xsl:attribute name="color">#808080</xsl:attribute>
		<xsl:attribute name="padding">1pt</xsl:attribute>
		<xsl:attribute name="border-color">#858586</xsl:attribute>
		<xsl:attribute name="background-color"><xsl:value-of select="$LightGrey"/></xsl:attribute>
		<xsl:attribute name="border-style">solid</xsl:attribute>
		<xsl:attribute name="border-width">medium</xsl:attribute>
		<xsl:attribute name="wrap-option">wrap</xsl:attribute>
		<xsl:attribute name="hyphenation-character">&#160;</xsl:attribute>
	</xsl:attribute-set>
	<!--Page break before some section containing image to avoid empty area-->
	<xsl:template match="processing-instruction('custom-pagebreak')">
		<fo:block break-before='page'/>
	</xsl:template>
	<xsl:template name="section.toc">
		<xsl:param name="toc-context" select="."/>
		<xsl:param name="toc.title.p" select="true()"/>
		<xsl:variable name="id">
			<xsl:call-template name="object.id"/>
		</xsl:variable>
		<xsl:variable name="cid">
			<xsl:call-template name="object.id">
				<xsl:with-param name="object" select="$toc-context"/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:variable name="nodes" 
			select="section|sect1|sect2|sect3|sect4|sect5|sect6|sect7|refentry
                        |bridgehead[$bridgehead.in.toc != 0]"/>
		<xsl:variable name="level">
			<xsl:call-template name="section.level"/>
		</xsl:variable>
		<xsl:if test="$nodes">
			<fo:block id="toc...{$id}" 
				xsl:use-attribute-sets="toc.margin.properties">
				<xsl:if test="$toc.title.p">
					<xsl:call-template name="section.heading">
						<xsl:with-param name="level" select="$level + 1"/>
						<xsl:with-param name="title">
							<fo:block space-after="0.5em">
								<xsl:call-template name="gentext">
									<xsl:with-param name="key" 
										select="'TableofContents'"/>
								</xsl:call-template>
							</fo:block>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<fo:table table-layout="fixed" width="100%">
					<fo:table-column 
						column-width="proportional-column-width(1)"/>
					<fo:table-body>
						<fo:table-row keep-together="always">
							<fo:table-cell>
								<xsl:apply-templates select="$nodes" mode="toc">
									<xsl:with-param name="toc-context" 
										select="$toc-context"/>
								</xsl:apply-templates>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:block>
		</xsl:if>
	</xsl:template>

<!--  -->
<!--  Back cover customization. -->
<!--  -->

<xsl:template name="book.titlepage.verso">
  <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="bookinfo/legalnotice"/>
  <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="info/legalnotice"/>
</xsl:template>

<!--  -->
<!-- Colophon customization-->
<!--  -->
<xsl:template match="colophon">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <xsl:variable name="master-reference">
    <xsl:call-template name="select.pagemaster"/>
  </xsl:variable>

  <fo:page-sequence hyphenate="{$hyphenate}"
                    master-reference="{$master-reference}">
    <xsl:attribute name="language">
      <xsl:call-template name="l10n.language"/>
    </xsl:attribute>
    <xsl:attribute name="format">
      <xsl:call-template name="page.number.format">
        <xsl:with-param name="master-reference" select="$master-reference"/>
      </xsl:call-template>
    </xsl:attribute>
    <xsl:attribute name="initial-page-number">
      <xsl:call-template name="initial.page.number">
        <xsl:with-param name="master-reference" select="$master-reference"/>
      </xsl:call-template>
    </xsl:attribute>
    <xsl:attribute name="force-page-count">
      <xsl:call-template name="force.page.count">
        <xsl:with-param name="master-reference" select="$master-reference"/>
      </xsl:call-template>
    </xsl:attribute>
    <xsl:attribute name="hyphenation-character">
      <xsl:call-template name="gentext">
        <xsl:with-param name="key" select="'hyphenation-character'"/>
      </xsl:call-template>
    </xsl:attribute>
    <xsl:attribute name="hyphenation-push-character-count">
      <xsl:call-template name="gentext">
        <xsl:with-param name="key" select="'hyphenation-push-character-count'"/>
      </xsl:call-template>
    </xsl:attribute>
    <xsl:attribute name="hyphenation-remain-character-count">
      <xsl:call-template name="gentext">
        <xsl:with-param name="key" select="'hyphenation-remain-character-count'"/>
      </xsl:call-template>
    </xsl:attribute>

    <xsl:apply-templates select="." mode="running.head.mode">
      <xsl:with-param name="master-reference" select="$master-reference"/>
    </xsl:apply-templates>

    <xsl:apply-templates select="." mode="running.foot.mode">
      <xsl:with-param name="master-reference" select="$master-reference"/>
    </xsl:apply-templates>

    <fo:flow flow-name="xsl-region-body">
      <fo:block id="{$id}">
        <xsl:call-template name="colophon.titlepage"/>
      </fo:block>
	   <fo:block start-indent="12mm" space-before="180mm"> 
      <!--<fo:block start-indent="0mm" space-before="0mm">-->
      <xsl:apply-templates/>
      </fo:block>
    </fo:flow>
  </fo:page-sequence>
</xsl:template>

<xsl:template name="colophon.titlepage.recto">
	<!-- Do nothnig -->
</xsl:template>

<xsl:template match="/book/colophon/para/itemizedlist/listitem" priority="2">
  <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>

  <xsl:variable name="item.contents">
    <fo:list-item-label>
      <fo:block>&#160;</fo:block>
    </fo:list-item-label>
    <fo:list-item-body>
      <fo:block>
	<xsl:apply-templates/>
      </fo:block>
    </fo:list-item-body>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="parent::*/@spacing = 'compact'">
      <fo:list-item id="{$id}" xsl:use-attribute-sets="compact.list.item.spacing">
        <xsl:copy-of select="$item.contents"/>
      </fo:list-item>
    </xsl:when>
    <xsl:otherwise>
      <fo:list-item id="{$id}">
        <xsl:copy-of select="$item.contents"/>
      </fo:list-item>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!--  -->
<!-- Localized labels -->
<!--  -->
<xsl:param name="local.l10n.xml" select="document('')"/>
<l:i18n xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0">
  <l:l10n language="en">
 			<l:gentext key="TableofContents" text="Contents"/>
  			<l:gentext key="tableofcontents" text="Contents"/>	  
  </l:l10n>  
</l:i18n>

<xsl:template name="page.count.separator">
	<xsl:param name="lang"><xsl:value-of select="/book/@lang"/></xsl:param>
	<xsl:choose>
		<xsl:when test="/book/@lang = 'fr'">
			<xsl:text> de </xsl:text>
		</xsl:when>
		<xsl:otherwise> of </xsl:otherwise>
	</xsl:choose>
</xsl:template>


<!--  -->
<!-- Lists symbol -->
<!--  -->
<xsl:template match="itemizedlist/listitem" priority="1">
  <xsl:variable name="id"><xsl:call-template name="object.id"/></xsl:variable>

  <xsl:variable name="itemsymbol">
    <xsl:call-template name="list.itemsymbol">
      <xsl:with-param name="node" select="parent::itemizedlist"/>
    </xsl:call-template>
  </xsl:variable>

  <xsl:variable name="item.contents">
    <fo:list-item-label end-indent="label-end()">
      <fo:block>
      <xsl:attribute name="color">
    	 <xsl:value-of select="$charcoal"/>
     	</xsl:attribute>
        <xsl:choose>
          <xsl:when test="$itemsymbol='disc'">&#x2022;</xsl:when>
          <xsl:when test="$itemsymbol='bullet'">&#x2022;</xsl:when>
          <!-- why do these symbols not work? -->
          <!--
          <xsl:when test="$itemsymbol='circle'">&#x2218;</xsl:when>
          <xsl:when test="$itemsymbol='round'">&#x2218;</xsl:when>
          <xsl:when test="$itemsymbol='square'">&#x2610;</xsl:when>
          <xsl:when test="$itemsymbol='box'">&#x2610;</xsl:when>
          -->
          <xsl:otherwise>&#x2022;</xsl:otherwise>
        </xsl:choose>
      </fo:block>
    </fo:list-item-label>
    <fo:list-item-body start-indent="body-start()">
      <fo:block>
	<xsl:apply-templates/>
      </fo:block>
    </fo:list-item-body>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="parent::*/@spacing = 'compact'">
      <fo:list-item id="{$id}" xsl:use-attribute-sets="compact.list.item.spacing">
        <xsl:copy-of select="$item.contents"/>
      </fo:list-item>
    </xsl:when>
    <xsl:otherwise>
      <fo:list-item id="{$id}" xsl:use-attribute-sets="list.item.spacing">
        <xsl:copy-of select="$item.contents"/>
      </fo:list-item>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!--List block spacing settings-->
<xsl:attribute-set name="list.block.spacing">
	<xsl:attribute name="space-before.optimum">0.1em</xsl:attribute>
	<xsl:attribute name="space-before.minimum">0.1em</xsl:attribute>
	<xsl:attribute name="space-before.maximum">0.1em</xsl:attribute>
	<xsl:attribute name="space-after.optimum">0.1em</xsl:attribute>
	<xsl:attribute name="space-after.minimum">0.1em</xsl:attribute>
	<xsl:attribute name="space-after.maximum">0.1em</xsl:attribute>
</xsl:attribute-set>
<!--List item spacing settings-->
<xsl:attribute-set name="list.item.spacing">
	<xsl:attribute name="space-before.optimum">0.3em</xsl:attribute>
	<xsl:attribute name="space-before.minimum">0.3em</xsl:attribute>
	<xsl:attribute name="space-before.maximum">0.3em</xsl:attribute>
</xsl:attribute-set>

<!--  -->
<!-- TOC customization -->
<!--  -->
<xsl:attribute-set name="toc.line.properties">
  <xsl:attribute name="font-weight">
  	<xsl:choose>
    <xsl:when test="self::chapter | self::preface | self::appendix">bold</xsl:when>
    <xsl:otherwise>normal</xsl:otherwise>
    </xsl:choose>
  </xsl:attribute>
</xsl:attribute-set>

<!-- TOC title -->
<xsl:attribute-set name="table.of.contents.titlepage.recto.style">
	<xsl:attribute name="color"><xsl:value-of select="$Fuchsia"/></xsl:attribute>
</xsl:attribute-set>

<xsl:template name="table.of.contents.titlepage.recto">
	  <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" xsl:use-attribute-sets="table.of.contents.titlepage.recto.style"  space-after="0.5em" margin-left="{$title.margin.left}" font-size="17.28pt" font-weight="bold" font-family="{$title.fontset}">
		<xsl:call-template name="gentext">
		<xsl:with-param name="key" select="'TableofContents'"/>
		</xsl:call-template>
	</fo:block>
</xsl:template>

<!--Change toc printing style-->
<xsl:template name="toc.line">
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>

  <xsl:variable name="label">
    <xsl:apply-templates select="." mode="label.markup"/>
  </xsl:variable>

<!-- TOC line properties-->
  <fo:block xsl:use-attribute-sets="toc.line.properties"
            end-indent="{$toc.indent.width}pt"
            last-line-end-indent="-{$toc.indent.width}pt">
    <fo:inline keep-with-next.within-line="always">
      <fo:basic-link internal-destination="{$id}">
        <xsl:if test="$label != ''">
          <xsl:copy-of select="$label"/>
          <xsl:value-of select="$autotoc.label.separator"/>
        </xsl:if>
        <xsl:apply-templates select="." mode="titleabbrev.markup"/>
      </fo:basic-link>
    </fo:inline>
    <fo:inline keep-together.within-line="always" font-weight="normal">
      <xsl:text> </xsl:text>
      <fo:leader leader-pattern="dots"
                 leader-pattern-width="3pt"
                 leader-alignment="reference-area"
                 keep-with-next.within-line="always"/>
      <xsl:text> </xsl:text> 
      <fo:basic-link internal-destination="{$id}" xsl:use-attribute-sets="toc.line.properties">
        <fo:page-number-citation ref-id="{$id}"/>
      </fo:basic-link>
    </fo:inline>
  </fo:block>
</xsl:template>

<!-- Para widows and orphans -->
<xsl:template match="para">
  <fo:block xsl:use-attribute-sets="normal.para.spacing">
     <xsl:attribute name="widows"><xsl:value-of select="$para.widows"/></xsl:attribute> 
     <xsl:attribute name="orphans"><xsl:value-of select="$para.orphans"/></xsl:attribute>       
    <xsl:call-template name="anchor"/>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="simpara">
  <fo:block xsl:use-attribute-sets="normal.para.spacing">
     <xsl:attribute name="widows"><xsl:value-of select="$para.widows"/></xsl:attribute> 
     <xsl:attribute name="orphans"><xsl:value-of select="$para.orphans"/></xsl:attribute>       
    <xsl:if test="@id">
      <xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
    </xsl:if>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<xsl:template match="formalpara">
  <fo:block xsl:use-attribute-sets="normal.para.spacing">
     <xsl:attribute name="widows"><xsl:value-of select="$para.widows"/></xsl:attribute> 
     <xsl:attribute name="orphans"><xsl:value-of select="$para.orphans"/></xsl:attribute>       
    <xsl:if test="@id">
      <xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
    </xsl:if>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

<!-- Fop 0.92 does not support double sided document
when there are generated with the current version of the docbook styleets -->
<xsl:template name="force.page.count">
  <xsl:param name="element" select="local-name(.)"/>
  <xsl:param name="master-reference" select="''"/>
  <xsl:choose>
    <!-- double-sided output 
    <xsl:when test="$double.sided != 0">end-on-even</xsl:when>-->
    <!-- single-sided output -->
    <xsl:otherwise>no-force</xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>