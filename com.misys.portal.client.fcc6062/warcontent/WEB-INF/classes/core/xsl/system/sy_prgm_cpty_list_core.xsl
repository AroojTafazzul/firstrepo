<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		xmlns:xd="http://www.pnp-software.com/XSLTdoc"
		exclude-result-prefixes="localization utils defaultresource">

<!--
   Copyright (c) 2000-2010 Misys (http://www.misys.com),
   All Rights Reserved. 
-->
	
	<!-- Get the language code -->
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="languages"/>
	<xsl:param name="nextscreen"/>
	<xsl:param name="option"/>
	<xsl:param name="token"/>
	<xsl:param name="action"/>
	<xsl:param name="displaymode">edit</xsl:param>
	<xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
	<xsl:param name="main-form-name">fakeform1</xsl:param>
	<xsl:param name="operation"/>
	<xsl:param name="program_id"/>
	<xsl:param name="programtype"><xsl:value-of select="program_counterparty/fscm_program/program_type"></xsl:value-of></xsl:param>
	<xsl:param name="operationtype">02</xsl:param>
	<xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
	<xsl:param name="deleteImage"><xsl:value-of select="$images_path"/>delete.png</xsl:param>
	
	
		
	<xsl:include href="../common/system_common.xsl" />
	<xsl:include href='sy_fscm_program.xsl' />
	
    <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
	<!--TEMPLATE Main-->
	 
	<xd:doc>
		<xd:short>Template for Building main form</xd:short>
		<xd:detail>
			This template builds main form and all the view details of the form
 		</xd:detail>
 	</xd:doc>
	<xsl:template match="/">
		<xsl:call-template name="loading-message" />
		<div>
  			<xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
			<xsl:call-template name="form-wrapper">
		     	<xsl:with-param name="name" select="$main-form-name"/>
		     	<xsl:with-param name="validating">Y</xsl:with-param>
		     	<xsl:with-param name="content">
						<xsl:apply-templates select="program_counterparty/fscm_program"/>
				</xsl:with-param> 
			</xsl:call-template>
		
		    <xsl:call-template name="prgm-cpty"/> 
		    <xsl:call-template name="hidden-fields"/>
			<xsl:call-template name="menu">
	     			<xsl:with-param name="show-template">N</xsl:with-param>
	     			<xsl:with-param name="show-submit">Y</xsl:with-param>
	     			<xsl:with-param name="show-save">N</xsl:with-param>
		       		<xsl:with-param name="show-cancel">Y</xsl:with-param>
	      </xsl:call-template>
	      <xsl:call-template name="realform"/>
			
			<!-- Javascript imports  -->
	   		<xsl:call-template name="js-imports"/>
		</div>		
	</xsl:template>	
	<!-- Additional JS imports for this form are -->
 	<!-- added here. -->
 
   <xd:doc>
		<xd:short>Additional JS Imports</xd:short>
		<xd:detail>
			Additional JS is binded
 		</xd:detail>
 	</xd:doc>
	<xsl:template name="js-imports">
	  	<xsl:call-template name="system-common-js-imports">
	   		<xsl:with-param name="xml-tag-name">program_counterparty</xsl:with-param>
	   		<xsl:with-param name="binding">misys.binding.system.prgm_cpty</xsl:with-param>
	   		<xsl:with-param name="override-home-url">'/screen/CustomerSystemFeaturesScreen?option=<xsl:value-of select="$option"/>&amp;program_id=<xsl:value-of select="$program_id"/>'</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

<!-- ***************************************************************************************** -->
 <!-- ************************************** REALFORM ***************************************** -->
 <!-- ***************************************************************************************** -->
	<xsl:template name="realform">
	  <!-- Do not display this section when the counterparty mode is 'counterparty' -->
	  <xsl:if test="$collaborationmode != 'counterparty'">
	  <xsl:call-template name="form-wrapper">
	   	 <xsl:with-param name="name">realform</xsl:with-param>
	  	 <xsl:with-param name="method">POST</xsl:with-param>
	   	 <xsl:with-param name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$nextscreen"/></xsl:with-param>
	     <xsl:with-param name="content">
	      	<div class="widgetContainer">
		      	<xsl:call-template name="hidden-field">
		       		<xsl:with-param name="name">operation</xsl:with-param>
		       		<xsl:with-param name="id">realform_operation</xsl:with-param>
		       		<xsl:with-param name="value">SAVE_FEATURES</xsl:with-param>
		     	 </xsl:call-template>
		     	 <xsl:call-template name="hidden-field">
		      	 	<xsl:with-param name="name">option</xsl:with-param>
		       	 	<xsl:with-param name="value"><xsl:value-of select="$option"/></xsl:with-param>
		     	 </xsl:call-template>	           
		    	   <xsl:call-template name="hidden-field">
		       		<xsl:with-param name="name">token</xsl:with-param>
		       		<xsl:with-param name="value"><xsl:value-of select="$token"/></xsl:with-param>
		       		</xsl:call-template> 
		       		<xsl:call-template name="hidden-field">
       				<xsl:with-param name="name">TransactionData</xsl:with-param>
      			</xsl:call-template>
		      	<xsl:call-template name="hidden-field">
		       		<xsl:with-param name="name">programtype</xsl:with-param>
		       		<xsl:with-param name="value"><xsl:value-of select="$programtype"/></xsl:with-param>
		      	</xsl:call-template>
		      	<xsl:call-template name="hidden-field">
		       		<xsl:with-param name="name">program_id</xsl:with-param>
		       		<xsl:with-param name="value"><xsl:value-of select="$program_id"/></xsl:with-param>
		      	</xsl:call-template>
		      	<xsl:call-template name="hidden-field">
		       		<xsl:with-param name="name">operationtype</xsl:with-param>
		       		<xsl:with-param name="value"><xsl:value-of select="$operationtype"/></xsl:with-param>
		      	</xsl:call-template>
	     	</div>
	    	</xsl:with-param>
	  	</xsl:call-template>
	  </xsl:if>
	</xsl:template>
 	<xsl:template name="hidden-fields">  		
  		<div class="widgetContainer">
  		<xsl:call-template name="hidden-field">
  			 <xsl:with-param name="name">program_id</xsl:with-param>
   			 <xsl:with-param name="value" select="$program_id"/>
  		</xsl:call-template>
  		<xsl:call-template name="hidden-field">
		       		<xsl:with-param name="name">operationtype</xsl:with-param>
		       		<xsl:with-param name="value"><xsl:value-of select="$operationtype"/></xsl:with-param>
		      	</xsl:call-template>
  		</div>
  	</xsl:template>
  	
	<xsl:template name="prgm-cpty">
  		<xsl:call-template name="hidden-field">
		    <xsl:with-param name="name">pc_delete_icon</xsl:with-param>
		    <xsl:with-param name="value"><xsl:value-of select="utils:getImagePath($deleteImage)"/></xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_PRGMCPTY</xsl:with-param>
			<xsl:with-param name="content">
				<div id="pc-items-template">
					<div class="clear multigrid">
						<script type="text/javascript">
							var gridLayoutPC, pluginsData;
							dojo.ready(function(){
						    	gridLayoutPC = {"cells" : [
						                  [{ "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'ABBVNAME')"/>", "field": "ABBVNAME", "width": "20%%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
						                  { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'NAME')"/>", "field": "NAME", "width": "20%%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"}
						                  <xsl:if test="$displaymode = 'edit'">				                 
						                   		,{ "noresize":"true", "name": "&nbsp;", "field": "ACTION", "width": "6em", "styles": "text-align:center;", "headerStyles": "text-align: center", "formatter": misys.grid.formatHTML}
						                   		</xsl:if>
						                    ]
						        ]};
								pluginsData = {indirectSelection: {headerSelector: "false",width: "30px",styles: "text-align: center;"}, paginationEnhanced: {pageSizes: ["10","25","50","100"], description: true, sizeSwitch: true, pageStepper: true, gotoButton: true, maxPageStep: 7, position: " top "}}						
							});
						</script>
						<div style="width:100%;height:100%;" class="widgetContainer clear">
						 
						 <xsl:if test="$displaymode = 'edit'">
							<table class="grid" plugins="pluginsData" structure="gridLayoutPC"
								autoHeight="true" id="gridPC" dojoType="dojox.grid.EnhancedGrid" selectionMode="none" selectable="false" singleClickEdit="true"
								noDataMessage="{localization:getGTPString($language, 'XSL_NO_PRGM_CPTY_ITEMS')}" 
								escapeHTMLInData="true" loadingMessage="{localization:getGTPString($language, 'TABLE_LOADING_RECORDS_LIST')}" >
								<thead>
									<tr></tr>
								</thead>
								<tfoot>
									<tr><td></td></tr>
								</tfoot>
								<tbody>
									<tr><td></td></tr>
								</tbody>
							</table>
						  </xsl:if>  											   
							<div class="clear" style="height:1px">&nbsp;</div>
						</div>
						<xsl:if test="$displaymode='edit'"> 
						<div id="pc-items-add" class="widgetContainer">
							<div id="pc_lookup" type="button" dojoType="dijit.form.Button">
								<xsl:if test="$programtype='01'">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PROGRAMCOUNTERPARTY_DETAILS_ADD_SELLER')" />
								</xsl:if>
								<xsl:if test="$programtype='02'">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PROGRAMCOUNTERPARTY_DETAILS_ADD_BUYER')" />
								</xsl:if>								
								</div>
							</div>
						 </xsl:if> 
					</div>
				</div>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>