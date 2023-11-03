<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 User Screen, System Form.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      29/04/08
author:    Laure Blin
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:technicalresource="xalan://com.misys.portal.common.resources.TechnicalResourceProvider"
		xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		exclude-result-prefixes="localization technicalresource securitycheck security utils defaultresource">
 
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="languages"/>
  <xsl:param name="nextscreen"/>
  <xsl:param name="option"/>
  <xsl:param name="action"/>
  <xsl:param name="displaymode">edit</xsl:param>
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="operation">UPLOAD_TEMPLATE_SAVE</xsl:param>
  <xsl:param name="token"/>
  <xsl:param name="currentOpe"/>
  
  <xsl:param name="screen"/>
  <xsl:param name="productcode"/>
  <xsl:param name="default_template"/>
  <xsl:param name="invoice_type"/>
  
  <xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
  <xsl:param name="actionDownImage"><xsl:value-of select="$images_path"/>action-down.png</xsl:param>
  <xsl:param name="actionUpImage"><xsl:value-of select="$images_path"/>action-up.png</xsl:param>
  
   <xsl:variable name="fscm_cash_customization_enable">
  		<xsl:value-of select="defaultresource:getResource('FSCM_CASH_CUSTOMIZATION_ENABLE')"/>
  	</xsl:variable>

  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/system_common.xsl" />
  <xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
    
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
   <xsl:apply-templates select="upload_template"/>
  </xsl:template>
  
  <xsl:template match="upload_template">
   <!-- Loading message  -->
   <xsl:call-template name="loading-message"/>
   
   <script type="text/javascript">
      		<xsl:call-template name="Columns_Definitions"/>
      		
   </script>
   
   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
    
    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
      <xsl:call-template name="hidden-fields"/>
      <xsl:call-template name="upload-template-general-details" />
      <xsl:call-template name="upload-template-mapping-columns" />
      <xsl:call-template name="update-column-information" />
     </xsl:with-param>
    </xsl:call-template>
 
 	<!--  Display common menu.  -->
	<xsl:choose>
    	<xsl:when test="default_template != 'Y'">
    		<xsl:call-template name="system-menu"/>
    	</xsl:when>
    	<xsl:otherwise>
    		<xsl:call-template name="menu" >
				<xsl:with-param name="show-template">N</xsl:with-param>
				<xsl:with-param name="show-submit">N</xsl:with-param>
				<xsl:with-param name="show-save">N</xsl:with-param>
			</xsl:call-template>
      	</xsl:otherwise>
	</xsl:choose> 	
    
    <xsl:call-template name="realform"/>
    <!--  Display common menu. -->
    
     <!-- Javascript imports  -->
  	<xsl:call-template name="js-imports"/>
   </div>

   <!-- Javascript imports  -->
<!--    <xsl:call-template name="js-imports"/> -->
  </xsl:template>
  
 <!-- Additional JS imports for this form are -->
 <!-- added here. -->
 <xsl:template name="js-imports">
  <xsl:call-template name="system-common-js-imports">
   <xsl:with-param name="xml-tag-name">upload_template</xsl:with-param>
   <xsl:with-param name="binding">misys.binding.openaccount.upload_template</xsl:with-param>
   <xsl:with-param name="override-home-url">'/screen/<xsl:value-of select="$screen"/>'</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!--
  Main Details of the Company 
  -->
 <xsl:template name="upload-template-general-details">
 	<xsl:call-template name="fieldset-wrapper">
   		<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
   		<xsl:with-param name="content">
	   	<!-- Template Name -->
	   	
	  	 <xsl:call-template name="input-field">
		    <xsl:with-param name="label">XSL_BASELINE_TEMPLATE_NAME</xsl:with-param>
		    <xsl:with-param name="name">name</xsl:with-param>
		    <xsl:with-param name="required"><xsl:if test="($productcode != 'PO' or $productcode != 'IN' and $productcode != 'IP' and default_template != 'Y') ">Y</xsl:if></xsl:with-param>
		    <xsl:with-param name="disabled"><xsl:if test="(($productcode = 'PO' or $productcode = 'IN' or $productcode = 'IP') and default_template = 'Y')">Y</xsl:if></xsl:with-param>
	    </xsl:call-template>
	    	<!-- Template Description -->
	    <xsl:call-template name="input-field">
		    <xsl:with-param name="label">XSL_BASELINE_TEMPLATE_DESC</xsl:with-param>
		    <xsl:with-param name="name">description</xsl:with-param>
		    <xsl:with-param name="required"><xsl:if test="($productcode != 'PO' or $productcode != 'IN'  and $productcode != 'IP' and default_template != 'Y')">Y</xsl:if></xsl:with-param>
		    <xsl:with-param name="disabled"><xsl:if test="(($productcode = 'PO' or $productcode = 'IN' or $productcode = 'IP') and default_template = 'Y')">Y</xsl:if></xsl:with-param>
	    </xsl:call-template>
			
		<xsl:choose>
			<xsl:when test="default_template != 'Y'">
		    <div class="field inline-group">
				<label>
					<xsl:attribute name="for">column_mapping</xsl:attribute>
					<label>
						 <xsl:if test="$rundata!='' ">
						<xsl:call-template name="localization-dblclick">
							<xsl:with-param name="xslName">XSL_BASELINE_TEMPLATE_COLUMN_MAPPING</xsl:with-param>
							<xsl:with-param name="localName" select="localization:getGTPString($rundata, $language, 'XSL_BASELINE_TEMPLATE_COLUMN_MAPPING')" />
						</xsl:call-template>
						</xsl:if>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_BASELINE_TEMPLATE_COLUMN_MAPPING')"/>
					</label>
			
				</label>
			    <xsl:choose>
			    	<xsl:when test="definition/delimiter/@type[.='fixed']"> 
			    	  <xsl:call-template name="radio-field">
			  			<xsl:with-param name="label">XSL_BASELINE_TEMPLATE_FIXED_SIZE</xsl:with-param>
			   			<xsl:with-param name="name">mapping</xsl:with-param>
			   			<xsl:with-param name="value">fixed</xsl:with-param>
			   			<xsl:with-param name="id">mapping_fixed</xsl:with-param>
			   			<xsl:with-param name="checked">Y</xsl:with-param>
				   	  </xsl:call-template>
			    	</xsl:when>
			    	<xsl:otherwise>
			    	 <xsl:call-template name="radio-field">
			  			<xsl:with-param name="label">XSL_BASELINE_TEMPLATE_FIXED_SIZE</xsl:with-param>
			   			<xsl:with-param name="name">mapping</xsl:with-param>
			   			<xsl:with-param name="value">fixed</xsl:with-param>
			   			<xsl:with-param name="id">mapping_fixed</xsl:with-param>
				   	</xsl:call-template>
			    	</xsl:otherwise>
			    </xsl:choose>
			    <xsl:choose>
			    	<xsl:when test="definition/delimiter/@type[.='dynamic']"> 
			    	  <xsl:call-template name="radio-field">
				  			<xsl:with-param name="label">XSL_BASELINE_TEMPLATE_DELIMITED</xsl:with-param>
				   			<xsl:with-param name="name">mapping</xsl:with-param>
				   			<xsl:with-param name="value">delimited</xsl:with-param>
				   			<xsl:with-param name="id">mapping_delimited</xsl:with-param>
				   			<xsl:with-param name="checked">Y</xsl:with-param>
				   		</xsl:call-template>
			    	</xsl:when>
			    	<xsl:otherwise>
			    	 <xsl:call-template name="radio-field">
			  			<xsl:with-param name="label">XSL_BASELINE_TEMPLATE_DELIMITED</xsl:with-param>
			   			<xsl:with-param name="name">mapping</xsl:with-param>
			   			<xsl:with-param name="value">delimited</xsl:with-param>
			   			<xsl:with-param name="id">mapping_delimited</xsl:with-param>
			   		</xsl:call-template>
			    	</xsl:otherwise>
			    </xsl:choose>

			
		   		<div id="delimiter_select_div" style="margin-left:4px;" class="inlineBlock">
			   		<xsl:call-template name="select-field">
				     	<xsl:with-param name="name">delimiter</xsl:with-param>
						<xsl:with-param name="value">
							<!-- Hack to deal with the Dijit FilteringSelect not handling properly comma character value --> 
							<xsl:call-template name="convert-delimiter-value">
								<xsl:with-param name="value" select="definition/delimiter"/>
							</xsl:call-template>
						</xsl:with-param> 
				     	<xsl:with-param name="fieldsize">x-small</xsl:with-param>
				     	<xsl:with-param name="appendClass">inlineBlock inlineBlockNoLabel</xsl:with-param>
				     	<xsl:with-param name="options">
				     	<xsl:call-template name="delimiter-options"/>
				    	</xsl:with-param>
					</xsl:call-template>
				</div>
				<div id="delimiter_text_div" class="inlineBlock">
			   		<xsl:call-template name="input-field">
				     	<xsl:with-param name="name">delimiter_text</xsl:with-param>
				     	<xsl:with-param name="value"><xsl:value-of select="delimiter_text"/></xsl:with-param>
				     	<xsl:with-param name="fieldsize">x-small</xsl:with-param>
				     	<xsl:with-param name="appendClass">inlineBlock inlineBlockNoLabel</xsl:with-param>
					</xsl:call-template>
				</div>
	   		</div>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="input-field">
			    	<xsl:with-param name="name">delimiter_text</xsl:with-param>
			    	<xsl:with-param name="label">XSL_BASELINE_TEMPLATE_COLUMN_MAPPING_DELIMITER_LABEL</xsl:with-param>
			    	<xsl:with-param name="size">3</xsl:with-param>
		       		<xsl:with-param name="fieldsize">xxx-small</xsl:with-param>
		       		<xsl:with-param name="maxsize">5</xsl:with-param>
	       			<xsl:with-param name="value">
			       		<xsl:choose>
			       			<xsl:when test = "$productcode = 'PO'">
			       				<xsl:value-of select="defaultresource:getResource('PO_UPLOAD_TEMPLATE_DELIMITER')"/>
			       			</xsl:when>
			       			<xsl:when test = "$productcode = 'IN' or $productcode = 'IP'">
			       				<xsl:value-of select="defaultresource:getResource('FSCM_UPLOAD_TEMPLATE_DELIMITER')"/>
			       			</xsl:when>
			       		</xsl:choose>
			       	</xsl:with-param>	 
		       		<xsl:with-param name="disabled">Y</xsl:with-param>
		   		</xsl:call-template>				
			</xsl:otherwise>
		</xsl:choose>
	    
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">hidden_delimiter</xsl:with-param>
			<xsl:with-param name="value">
				<!-- Hack to deal with the Dijit FilteringSelect not handling properly comma character value --> 
				<xsl:call-template name="convert-delimiter-value">
					<xsl:with-param name="value" select="definition/delimiter"/>
				</xsl:call-template>
			</xsl:with-param> 
		</xsl:call-template>
				
   		<xsl:call-template name="multichoice-field">
	    	<xsl:with-param name="label">XSL_BASELINE_TEMPLATE_RELEASED_FLAG</xsl:with-param>
	    	<xsl:with-param name="name">executable</xsl:with-param>
	    	<xsl:with-param name="type">checkbox</xsl:with-param>
		    <xsl:with-param name="disabled"><xsl:if test="(($productcode = 'PO' or $productcode = 'IN' or $productcode = 'IP') and default_template = 'Y')">Y</xsl:if></xsl:with-param>
	    	<xsl:with-param name="checked">
	    		<xsl:choose>
	    			<xsl:when test="executable[.='Y']">true</xsl:when>
	    			<xsl:otherwise>false</xsl:otherwise>
	    		</xsl:choose>
	    	</xsl:with-param>
	    </xsl:call-template>
		 	
		<div id='disclaimer' style='display:none'>
			 <xsl:value-of select="localization:getGTPString($language, 'XSL_BASELINE_TEMPLATE_OLD_MESSAGE')"/>
		</div>	
		
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- =========================================================================== -->
 <!-- ======================== Template Attached Banks ========================= -->
 <!-- =========================================================================== -->
 <xsl:template name="upload-template-mapping-columns">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_BASELINE_TEMPLATE_MAPPED_COLUMNS</xsl:with-param>
   <xsl:with-param name="content">
   	<div style="text-align:center;">
   		<div class="inlineBlock" style="padding-top:260px;vertical-align:top;">
   			 <div>
				<img id="move_column_up_img">
					<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($actionUpImage)"/></xsl:attribute>
				</img>
			 </div>
		  	 <div>
				<img id="move_column_down_img">
					<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($actionDownImage)"/></xsl:attribute>
				</img>
		     </div>
   		</div>
   		<div style="text-align:center;">
		   	 <xsl:attribute name="class">
		   	 		 inlineBlock	<xsl:if test="$displaymode = 'edit'"> collapse-label</xsl:if>
		   	 </xsl:attribute>
		   	 <xsl:if test="$displaymode='edit'">
		      <xsl:call-template name="select-field">
		       <xsl:with-param name="name"></xsl:with-param>
		       <xsl:with-param name="id">avail_mapped_columns_list_nosend</xsl:with-param>
		       <xsl:with-param name="type">multiple</xsl:with-param>
		       <xsl:with-param name="size">10</xsl:with-param>
		       <xsl:with-param name="sort-multi-select">N</xsl:with-param>
		       <xsl:with-param name="disabled">
		       		<xsl:if test="(($productcode = 'PO' or $productcode = 'IN' or $productcode = 'IP' ) and default_template = 'Y')">Y</xsl:if>   	
		       </xsl:with-param>
		       <xsl:with-param name="options">
		        <xsl:choose>
			     <xsl:when test="$displaymode='edit'">
			     <xsl:call-template name="avail_columns" />
			     </xsl:when>
			     <xsl:otherwise>
			      <ul>
			       <xsl:apply-templates select="avail_desc_record" mode="input_bankcompany"/>
			      </ul>
			     </xsl:otherwise>
			    </xsl:choose>
		       </xsl:with-param>
		      </xsl:call-template>
		      <div id="add-remove-banks" class="multiselect-buttons">
		      <xsl:choose>
		      	<xsl:when test="(($productcode = 'PO' or $productcode = 'IN' or $productcode = 'IP' )  and default_template = 'Y')">
		      		<!-- Disable action buttons for PO product in template upload screen -->
			       <button dojoType="dijit.form.Button" type="button" id="add_column" disabled="true"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_ADD')" />&nbsp;&#8595;</button>
			       <button dojoType="dijit.form.Button" type="button" id="remove_column" disabled="true"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REMOVE')" />&nbsp;&#8593;</button>
		      	</xsl:when>
		      	<xsl:otherwise>
			       <button dojoType="dijit.form.Button" type="button" id="add_column"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_ADD')" />&nbsp;&#8595;</button>
			       <button dojoType="dijit.form.Button" type="button" id="remove_column"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REMOVE')" />&nbsp;&#8593;</button>
		      	</xsl:otherwise>
		      </xsl:choose>
		      </div>
		     </xsl:if>
		     <div class="field inline-group">
			      <xsl:call-template name="select-field">
			       <xsl:with-param name="name">user_list</xsl:with-param>
			       <xsl:with-param name="type">multiple</xsl:with-param>
			       <xsl:with-param name="size">10</xsl:with-param>
			       <xsl:with-param name="sort-multi-select">N</xsl:with-param>
			       <xsl:with-param name="options">
			        <xsl:choose>
				     <xsl:when test="$displaymode='edit'">
				      <!-- Render columns in the list -->
					  <xsl:apply-templates select="definition/column" mode="list"/>
				     </xsl:when>
				     <xsl:otherwise>
				      <ul class="multi-select">
				       <xsl:apply-templates select="definition/column" mode="list"/>
				      </ul>
				     </xsl:otherwise>
				    </xsl:choose>
			       </xsl:with-param>
			      </xsl:call-template>
		      </div>
		      <xsl:call-template name="column-information" />
		  </div>
		  
      </div>
 	</xsl:with-param>
 	</xsl:call-template>
 </xsl:template>
 
 
 <!-- Additional hidden fields for this form are  -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <div class="widgetContainer">
  <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">product_code</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="$productcode"/></xsl:with-param>
  </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">sub_product_code</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="$invoice_type"/></xsl:with-param>
  </xsl:call-template>
  <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">upload_template_id</xsl:with-param>
  </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">default_template</xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="default_template"/></xsl:with-param>
  </xsl:call-template>
    <xsl:call-template name="hidden-field">
    	<xsl:with-param name="name">current_ope</xsl:with-param>
     	<xsl:with-param name="value"><xsl:value-of select="$currentOpe"/></xsl:with-param>
  	</xsl:call-template>
  </div>
 </xsl:template>
 
 <!-- 
  Realform
  -->
 <xsl:template name="realform">
  <!-- Do not display this section when the counterparty mode is 'counterparty' -->
  <xsl:if test="$collaborationmode != 'counterparty'">
  <xsl:call-template name="form-wrapper">
   <xsl:with-param name="name">realform</xsl:with-param>
   <xsl:with-param name="method">POST</xsl:with-param>
   <xsl:with-param name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$screen"/></xsl:with-param>
    <xsl:with-param name="content">
     <div class="widgetContainer">
      <xsl:call-template name="localization-dialog"/>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">operation</xsl:with-param>
       <xsl:with-param name="id">realform_operation</xsl:with-param>
       <xsl:with-param name="value">UPLOAD_TEMPLATE_SAVE</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
      </xsl:call-template>
	  <xsl:if test="upload_template_id[.!='']">
	  <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">featureid</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="upload_template_id"/></xsl:with-param>
      </xsl:call-template>
	  </xsl:if>
	  <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">productcode</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="$productcode"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">token</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$token"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="e2ee_transaction"/>
     </div>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:if>
  </xsl:template>
  
  
   <!--  Delimeter options -->
   <xsl:template name="delimiter-options">
	 <option value=""></option>	 
	 <option value="comma"><xsl:value-of select="localization:getGTPString($language, 'XSL_BASELINE_TEMPLATE_DELIMITER_COMMA')"/></option>
	 <option value=";;"><xsl:value-of select="localization:getGTPString($language, 'XSL_BASELINE_TEMPLATE_DELIMITER_SEMICOLON')"/></option>
	 <option value="OTHER"><xsl:value-of select="localization:getGTPString($language, 'XSL_BASELINE_TEMPLATE_DELIMITER_OTHER')"/></option>
   </xsl:template>
   
   <!-- Create one column entry -->
 	<xsl:template name="avail_column">
	 	<xsl:param name="column_name" />
	 	<xsl:param name="column_type" />
	 	<xsl:param name="column_name_label" select="$column_name"/>
	 	<xsl:variable name="codeval">XSL_REPORT_COL_<xsl:value-of select="$column_name_label"/></xsl:variable>
 		<xsl:if test="count(definition/column/name[.=$column_name])=0">
			<option>
				<xsl:attribute name="value"><xsl:value-of select="$column_name"/></xsl:attribute>
				<xsl:value-of select="localization:getGTPString($language, $codeval)"/>
			</option>
		</xsl:if>
 	</xsl:template>
 	
 	<!-- List of available columns -->
	<xsl:template name="avail_columns">
	<xsl:if test="($productcode = 'PO' or $productcode = 'IP' or $productcode='IN') and default_template != 'Y'">
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_CUST_REF_ID')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_PRODUCT_NAME')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_LAST_SHIP_DATE')"/></xsl:with-param>
			<xsl:with-param name="column_type">Date</xsl:with-param>
			<xsl:with-param name="column_name_label">line_item_last_ship_date</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_UNIT_CODE')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
			<xsl:with-param name="column_name_label">line_item_qty_unit_measr_code</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_QUANTITY_VALUE')"/></xsl:with-param>
			<xsl:with-param name="column_type">Number</xsl:with-param>
			<xsl:with-param name="column_name_label">line_item_qty_val</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_QUANTITY_FACTOR')"/></xsl:with-param>
			<xsl:with-param name="column_type">Number</xsl:with-param>
			<xsl:with-param name="column_name_label">line_item_qty_factor</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_QUANTITY_TOLERANCE_POSITIVE_PERCENTAGE')"/></xsl:with-param>
			<xsl:with-param name="column_type">Number</xsl:with-param>
			<xsl:with-param name="column_name_label">line_item_qty_tol_pstv_pct</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_QUANTITY_TOLERANCE_NEGATIVE_PERCENTAGE')"/></xsl:with-param>
			<xsl:with-param name="column_type">Number</xsl:with-param>
			<xsl:with-param name="column_name_label">line_item_qty_tol_neg_pct</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_PRICE_AMOUNT')"/></xsl:with-param>
			<xsl:with-param name="column_type">Number</xsl:with-param>
			<xsl:with-param name="column_name_label">line_item_price_amt</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_PRICE_CUR_CODE')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
			<xsl:with-param name="column_name_label">line_item_price_cur_code</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_PRICE_FACTOR')"/></xsl:with-param>
			<xsl:with-param name="column_type">Number</xsl:with-param>
			<xsl:with-param name="column_name_label">line_item_price_factor</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_PRICE_TOLERANCE_POSITIVE_PERCENTAGE')"/></xsl:with-param>
			<xsl:with-param name="column_type">Number</xsl:with-param>
			<xsl:with-param name="column_name_label">line_item_price_tol_pstv_pct</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_PRICE_TOLERANCE_NEGATIVE_PERCENTAGE')"/></xsl:with-param>
			<xsl:with-param name="column_type">Number</xsl:with-param>
			<xsl:with-param name="column_name_label">line_item_price_tol_neg_pct</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_TOTAL_AMOUNT')"/></xsl:with-param>
			<xsl:with-param name="column_type">Number</xsl:with-param>
			<xsl:with-param name="column_name_label">line_item_total_amt</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_TOTAL_CUR_CODE')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
			<xsl:with-param name="column_name_label">line_item_total_cur_code</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_IGNORED_COLUMN')"/></xsl:with-param>
			<xsl:with-param name="column_type">Blank</xsl:with-param>
		</xsl:call-template>
		<!--
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name">inco_term</xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name">inco_place</xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		-->
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ERP_ID')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:if test="$productcode ='IP' or $productcode = 'IN'">
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_FSCM_PROGRAMME_CODE')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		</xsl:if>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_CUST_REF_ID')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ISSUER_REF_ID')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
			<xsl:with-param name="column_name_label">
				<xsl:choose>
					<xsl:when test="($productcode='IP' or $productcode = 'IN')">invoice_ref_id</xsl:when>
					<xsl:when test="$productcode='PO'">po_reference</xsl:when>
					<xsl:otherwise>issuer_ref_id</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
		<!-- 
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_PO_REFERENCE')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		-->
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ISSUE_DATE')"/></xsl:with-param>
			<xsl:with-param name="column_type">Date</xsl:with-param>
			<xsl:with-param name="column_name_label">
				<xsl:choose>
					<xsl:when test="$productcode='IP' or $productcode = 'IN'">invoice_date</xsl:when>
					<xsl:otherwise>iss_date</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_DUE_DATE')"/></xsl:with-param>
			<xsl:with-param name="column_type">Date</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SELLER_ABBREVIATED_NAME')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SELLER_NAME')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_BUYER_ABBREVIATED_NAME')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_BUYER_NAME')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TOTAL_NET_AMOUNT')"/></xsl:with-param>
			<xsl:with-param name="column_type">Number</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TOTAL_NET_CUR_CODE')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ISSUING_BANK_ABBREVIATED_NAME')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ISSUING_BANK_CUSTOMER_REFERENCE')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_PAYMENT_TERM_CODE')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_OTHER_PAYMENT_CONDITION')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_PAYMENT_TERM_NB_DAYS')"/></xsl:with-param>
			<xsl:with-param name="column_type">Number</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_PAYMENT_TERM_CUR_CODE')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_PAYMENT_TERM_AMT')"/></xsl:with-param>
			<xsl:with-param name="column_type">Number</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_PAYMENT_PCT')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<!--The fields before the customer reference and issuer reference ID should be mandatory . hence changing the order of adjustment fields in template files solves MPS-49381  -->
		<xsl:if test="$productcode='IP' or $productcode = 'IN' or  $productcode = 'PO'">
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ADJUSTMENT_TYPE')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
			<xsl:with-param name="column_name_label">adjustment_type</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ADJUSTMENT_DIR')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
			<xsl:with-param name="column_name_label">adjustment_direction</xsl:with-param>
		</xsl:call-template> 
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ADJUSTMENT_CUR_CODE')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
			<xsl:with-param name="column_name_label">adjustment_cur_code</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ADJUSTMENT_AMT')"/></xsl:with-param>
			<xsl:with-param name="column_type">Number</xsl:with-param>
			<xsl:with-param name="column_name_label">adjustment_amt</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ADJUSTMENT_PERCENTAGE')"/></xsl:with-param>
			<xsl:with-param name="column_type">Number</xsl:with-param>
			<xsl:with-param name="column_name_label">adjustment_percentage</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ADJUSTMENT_CREDIT_NOTE_REFERENCE')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
			<xsl:with-param name="column_name_label">adjustment_credit_note_reference</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ADJUSTMENT_OTHER_CODE')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
			<xsl:with-param name="column_name_label">adjustment_other_code</xsl:with-param>
		</xsl:call-template>
		
		<!-- Taxes -->
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TAX_TYPE')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
			<xsl:with-param name="column_name_label">tax_type</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TAX_CUR_CODE')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
			<xsl:with-param name="column_name_label">tax_cur_code</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TAX_AMT')"/></xsl:with-param>
			<xsl:with-param name="column_type">Number</xsl:with-param>
			<xsl:with-param name="column_name_label">tax_amt</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TAX_PERCENTAGE')"/></xsl:with-param>
			<xsl:with-param name="column_type">Number</xsl:with-param>
			<xsl:with-param name="column_name_label">tax_percentage</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TAX_OTHER_CODE')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
			<xsl:with-param name="column_name_label">tax_other_code</xsl:with-param>
		</xsl:call-template>
		
		<!-- Freight Charge -->
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_FREIGHT_CHARGE_TYPE')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
			<xsl:with-param name="column_name_label">freight_charge_type</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_FREIGHT_CHARGE_CUR_CODE')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
			<xsl:with-param name="column_name_label">freight_charge_cur_code</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_FREIGHT_CHARGE_AMT')"/></xsl:with-param>
			<xsl:with-param name="column_type">Number</xsl:with-param>
			<xsl:with-param name="column_name_label">freight_charge_amt</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_FREIGHT_CHARGE_PERCENTAGE')"/></xsl:with-param>
			<xsl:with-param name="column_type">Number</xsl:with-param>
			<xsl:with-param name="column_name_label">freight_charge_percentage</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_FREIGHT_CHARGE_OTHER_CODE')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
			<xsl:with-param name="column_name_label">freight_charge_other_code</xsl:with-param>
		</xsl:call-template>
		
		</xsl:if>
		<xsl:if test="$fscm_cash_customization_enable = 'true' and $productcode = 'IN'">
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name">discount_exp_date</xsl:with-param>
			<xsl:with-param name="column_type">Date</xsl:with-param>
			<xsl:with-param name="column_name_label">discount_exp_date</xsl:with-param>
		</xsl:call-template>
		</xsl:if>
		</xsl:if>
 	</xsl:template>
 	
 	<!-- Definition of columns -->
	<xsl:template name="Columns_Definitions">
		dojo.ready(function(){
  		misys._config = (misys._config) || {};
		misys._config.arrColumn = misys._config.arrColumn || [];
		
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_CUST_REF_ID')"/>"] = new Array("String", true);
		//misys._config.arrColumn["line_item_nb"] = new Array("String", true);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_PRODUCT_NAME')"/>"] = new Array("String", true);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_LAST_SHIP_DATE')"/>"] = new Array("Date", false);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_UNIT_CODE')"/>"] = new Array("String", true);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_QUANTITY_VALUE')"/>"] = new Array("Number", true);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_QUANTITY_FACTOR')"/>"] = new Array("Number", false);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_QUANTITY_TOLERANCE_POSITIVE_PERCENTAGE')"/>"] = new Array("Number", false);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_QUANTITY_TOLERANCE_NEGATIVE_PERCENTAGE')"/>"] = new Array("Number", false);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_PRICE_CUR_CODE')"/>"] = new Array("String", true);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_PRICE_AMOUNT')"/>"] = new Array("Number", true);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_PRICE_FACTOR')"/>"] = new Array("Number", false);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_PRICE_TOLERANCE_POSITIVE_PERCENTAGE')"/>"] = new Array("Number", false);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_PRICE_TOLERANCE_NEGATIVE_PERCENTAGE')"/>"] = new Array("Number", false);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_TOTAL_CUR_CODE')"/>"] = new Array("String", false);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_TOTAL_AMOUNT')"/>"] = new Array("Number", false);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_TOTAL_NET_CUR_CODE')"/>"] = new Array("String", false);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_TOTAL_NET_AMOUNT')"/>"] = new Array("Number", false);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_OTHER_PAYMENT_CONDITION')"/>"] = new Array("String", false);
		
		misys._config.arrColumn["ignored_column"] = new Array("Blank", false);
			
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ERP_ID')"/>"] = new Array("String", false);
		<xsl:choose>
		<xsl:when test = "$productcode='IP' or $productcode='IN' or $productcode='PO'">
		<!-- Adjustments -->
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ADJUSTMENT_TYPE')"/>"] = new Array("String", false);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ADJUSTMENT_DIR')"/>"] = new Array("String", false); 
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ADJUSTMENT_CUR_CODE')"/>"] = new Array("String", false);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ADJUSTMENT_AMT')"/>"] = new Array("Number", false);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ADJUSTMENT_PERCENTAGE')"/>"] = new Array("Number", false);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ADJUSTMENT_CREDIT_NOTE_REFERENCE')"/>"] = new Array("String", false);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ADJUSTMENT_OTHER_CODE')"/>"] = new Array("String", false);
		misys._config.arrColumn["discount_exp_date"] = new Array("Date", true);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_FSCM_PROGRAMME_CODE')"/>"] = new Array("String", true);
		
		<!-- Taxes -->
		
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TAX_TYPE')"/>"] = new Array("String", false);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TAX_CUR_CODE')"/>"] = new Array("String", false);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TAX_AMT')"/>"] = new Array("Number", false);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TAX_PERCENTAGE')"/>"] = new Array("Number", false);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TAX_OTHER_CODE')"/>"] = new Array("String", false);
		
		<!-- Freight Charges -->
		
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_FREIGHT_CHARGE_TYPE')"/>"] = new Array("String", false);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_FREIGHT_CHARGE_CUR_CODE')"/>"] = new Array("String", false);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_FREIGHT_CHARGE_AMT')"/>"] = new Array("Number", false);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_FREIGHT_CHARGE_PERCENTAGE')"/>"] = new Array("Number", false);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_FREIGHT_CHARGE_OTHER_CODE')"/>"] = new Array("String", false);
	
		</xsl:when>
		
		<xsl:otherwise>
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_FSCM_PROGRAMME_CODE')"/>"] = new Array("String", false);
		</xsl:otherwise>
		</xsl:choose>
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_CUST_REF_ID')"/>"] = new Array("String", true);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ISSUER_REF_ID')"/>"] = new Array("String", true);
		//misys._config.arrColumn["po_reference"]  = new Array("String", false);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ISSUE_DATE')"/>"] = new Array("Date", true);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_DUE_DATE')"/>"] = new Array("Date", true);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SELLER_ABBREVIATED_NAME')"/>"] = new Array("String", true);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SELLER_NAME')"/>"] = new Array("String", false);
		<xsl:choose>
		<xsl:when test="$productcode = 'PO' or $productcode='IP'">
			misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_BUYER_ABBREVIATED_NAME')"/>"] = new Array("String", true);
			misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_BUYER_NAME')"/>"] = new Array("String", false);
		</xsl:when>
		<xsl:otherwise>
			misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_BUYER_ABBREVIATED_NAME')"/>"] = new Array("String", true);
			misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_BUYER_NAME')"/>"] = new Array("String", false);
		</xsl:otherwise>
		</xsl:choose>
		<xsl:choose>
		<xsl:when test = "$productcode ='IN'">
			misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TOTAL_NET_AMOUNT')"/>"] = new Array("Number", false);
			misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TOTAL_NET_CUR_CODE')"/>"] = new Array("String", false);
		</xsl:when>
		<xsl:otherwise>
			misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TOTAL_NET_AMOUNT')"/>"] = new Array("Number", true);
			misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TOTAL_NET_CUR_CODE')"/>"] = new Array("String", true);
		</xsl:otherwise>
		</xsl:choose>
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ISSUING_BANK_ABBREVIATED_NAME')"/>"] = new Array("String", true);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ISSUING_BANK_CUSTOMER_REFERENCE')"/>"] = new Array("String", false);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_PAYMENT_TERM_CODE')"/>"] = new Array("String", true);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_PAYMENT_TERM_NB_DAYS')"/>"] = new Array("Number", true);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_PAYMENT_TERM_CUR_CODE')"/>"] = new Array("String", true);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_PAYMENT_TERM_AMT')"/>"] = new Array("Number", true);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_PAYMENT_PCT')"/>"] = new Array("Number", true);
		<xsl:if test="(($productcode = 'IN' or $productcode = 'IP' ) and default_template = 'Y')">
			misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ISSUER_REF_ID')"/>"] = new Array("String", true);
		    misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_CUST_REF_ID')"/>"] = new Array("String", true);
		    misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ISSUE_DATE')"/>"] = new Array("Date", true);
		    misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_DUE_DATE')"/>"] = new Array("Date", true);
		    misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_BUYER_NAME')"/>"] = new Array("String", true);
		    misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_BUYER_COUNTRY')"/>"] = new Array("String", true);
		    misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SELLER_NAME')"/>"] = new Array("String", true);
			misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_FSCM_PROGRAMME_CODE')"/>"] = new Array("String", true);
			misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SELLER_COUNTRY')"/>"] = new Array("String", true);
			misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TOTAL_NET_CUR_CODE')"/>"] = new Array("String", true);
			misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ADJUSTMENT_AMT')"/>"] = new Array("Number", true);
			misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_FACE_TOTAL_CUR_CODE')"/>"] = new Array("String", true);
			misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_FACE_TOTAL_AMT')"/>"] = new Array("Number", true);
			misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TOTAL_NET_AMOUNT')"/>"] = new Array("Number", true);
			misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ISSUING_BANK_ABBREVIATED_NAME')"/>"] = new Array("String", true);
		    misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ISSUING_BANK_CUSTOMER_REFERENCE')"/>"] = new Array("String", false);
		</xsl:if>
    });
	</xsl:template>
	
	<!-- Creates an editing form for a selected column -->
	<xsl:template name="column-information">
		<div style="text-align:left;">
			<div>
				<div class="field inline-group" style="width:240px;">
					<div id="column_date_format_div" class="inlineBlock">
						<xsl:choose>
							<xsl:when test="((($productcode = 'IN' or $productcode = 'IP') and $invoice_type = 'ISO') or $productcode = 'PO') and default_template = 'Y'">
				    			<xsl:call-template name="select-field">
									<xsl:with-param name="label">XSL_BASELINE_UPLOAD_FORMAT</xsl:with-param>
							     	<xsl:with-param name="name">date_format_select</xsl:with-param>
							     	<xsl:with-param name="value">yyyyMMdd</xsl:with-param>
									 <xsl:with-param name="fieldsize">small</xsl:with-param>
									 <xsl:with-param name="disabled">Y</xsl:with-param>
									 <xsl:with-param name="options">
								     	<option value="yyyyMMdd">
											<xsl:if test="format = 'yyyyMMdd'">
												<xsl:attribute name="selected"/>
											</xsl:if>
											yyyyMMdd
										</option>
									 </xsl:with-param>
								 </xsl:call-template>   		
				    		</xsl:when>
				    		<xsl:when test="($productcode = 'IN' or $productcode = 'IP') and default_template = 'Y' and invoice_type = 'SMP'">
				    			<xsl:call-template name="select-field">
									<xsl:with-param name="label">XSL_BASELINE_UPLOAD_FORMAT</xsl:with-param>
							     	<xsl:with-param name="name">date_format_select</xsl:with-param>
							     	<xsl:with-param name="value">ddMMyyyy</xsl:with-param>
									 <xsl:with-param name="fieldsize">small</xsl:with-param>
									 <xsl:with-param name="disabled">Y</xsl:with-param>
									 <xsl:with-param name="options">
								     	<option value="ddMMyyyy">
											<xsl:if test="format = 'ddMMyyyy'">
												<xsl:attribute name="selected"/>
											</xsl:if>
											ddMMyyyy
										</option>
									 </xsl:with-param>
								 </xsl:call-template>   		
				    		</xsl:when>
				    		<xsl:otherwise>
								<xsl:call-template name="select-field">
									<xsl:with-param name="label">XSL_BASELINE_UPLOAD_FORMAT</xsl:with-param>
							     	<xsl:with-param name="name">date_format_select</xsl:with-param>
							     	<xsl:with-param name="value"><xsl:value-of select="columnName_format"/></xsl:with-param>
							     	<xsl:with-param name="options">
								     	<option value="">
											<xsl:if test="format = ''">
												<xsl:attribute name="selected"/>
											</xsl:if>
										</option>
										<option value="MM/dd/yy">
											<xsl:if test="format = 'MM/dd/yy'">
												<xsl:attribute name="selected"/>
											</xsl:if>
											<xsl:value-of select="localization:getGTPString($language, 'XSL_BASELINE_UPLOAD_FORMAT_DATE_ENGLISH')"/>
										</option>
										<option value="dd/MM/yy">
											<xsl:if test="format = 'dd/MM/yy'">
												<xsl:attribute name="selected"/>
											</xsl:if>
											<xsl:value-of select="localization:getGTPString($language, 'XSL_BASELINE_UPLOAD_FORMAT_DATE_FRENCH')"/>
										</option>
										<option value="ddMMyyyy">
											<xsl:if test="format = 'ddMMyyyy'">
												<xsl:attribute name="selected"/>
											</xsl:if>
											ddMMyyyy
										</option>
										<option value="MMddyyyy">
											<xsl:if test="format = 'MMddyyyy'">
												<xsl:attribute name="selected"/>
											</xsl:if>
											MMddyyyy
										</option>
										<option value="yyyyMMdd">
											<xsl:if test="format = 'yyyyMMdd'">
												<xsl:attribute name="selected"/>
											</xsl:if>
											yyyyMMdd
										</option>
										<option value="yyyyddMM">
											<xsl:if test="format = 'yyyyddMM'">
												<xsl:attribute name="selected"/>
											</xsl:if>
											yyyyddMM
										</option>
										<option value="ddMMyy">
											<xsl:if test="format = 'ddMMyy'">
												<xsl:attribute name="selected"/>
											</xsl:if>
											ddMMyy
										</option>
										<option value="MMddyy">
											<xsl:if test="format = 'MMddyy'">
												<xsl:attribute name="selected"/>
											</xsl:if>
											MMddyy
										</option>
										<option value="yyMMdd">
											<xsl:if test="format = 'yyMMdd'">
												<xsl:attribute name="selected"/>
											</xsl:if>
											yyMMdd
										</option>
										<option value="yyddMM">
											<xsl:if test="format = 'yyddMM'">
												<xsl:attribute name="selected"/>
											</xsl:if>
											yyddMM
										</option>
										<!-- <option value="OTHER"><xsl:value-of select="localization:getGTPString($language, 'XSL_BASELINE_TEMPLATE_DELIMITER_OTHER')"/></option> -->
							    	</xsl:with-param>
							    <xsl:with-param name="fieldsize">small</xsl:with-param>
							</xsl:call-template>
						</xsl:otherwise>
				    </xsl:choose>
		
					<div id="date_format_select_other_div" class="hide">
						<xsl:call-template name="input-field">
					    	<xsl:with-param name="name">date_format_other</xsl:with-param>
					    	<xsl:with-param name="id">date_format_other</xsl:with-param>
					    	<xsl:with-param name="size">3</xsl:with-param>
				       		<xsl:with-param name="maxsize">35</xsl:with-param>
				       		<xsl:with-param name="fieldsize">small</xsl:with-param>
				   		</xsl:call-template>
					</div>
				</div>
			</div>
			<div class="field inline-group" style="width:240px;">
			<div id="column_amount_format_div" class="inlineBlock">
			<xsl:choose>
				<xsl:when test="($productcode = 'IN' or $productcode = 'IP' or $productcode = 'PO') and default_template = 'Y'">
					<xsl:call-template name="select-field">
						<xsl:with-param name="label">XSL_BASELINE_UPLOAD_FORMAT</xsl:with-param>
				     	<xsl:with-param name="name">amount_format_select</xsl:with-param>
				     	<xsl:with-param name="value">dot decimal separator</xsl:with-param>
						 <xsl:with-param name="fieldsize">small</xsl:with-param>
						 <xsl:with-param name="disabled">Y</xsl:with-param>
						 <xsl:with-param name="options">
					     	<option value="dot decimal separator">
								<xsl:if test="format = 'dot decimal separator'">
									<xsl:attribute name="selected"/>
								</xsl:if>
								dot decimal separator
							</option>
						 </xsl:with-param>
				    </xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="select-field">
								<xsl:with-param name="label">XSL_BASELINE_UPLOAD_FORMAT</xsl:with-param>
						     	<xsl:with-param name="name">amount_format_select</xsl:with-param>
						     	<xsl:with-param name="value"><xsl:value-of select="columnName_format"/></xsl:with-param>
						     	<xsl:with-param name="options">
							     	<option value="">
									<xsl:if test="format = ''">
										<xsl:attribute name="selected"/>
									</xsl:if>
									</option>
									<option value="english">
										<xsl:if test="format = 'english'">
											<xsl:attribute name="selected"/>
										</xsl:if>
										<xsl:value-of select="localization:getGTPString($language, 'XSL_BASELINE_UPLOAD_FORMAT_DECIMAL_ENGLISH')"/>
									</option>
									<option value="french">
										<xsl:if test="format = 'french'">
											<xsl:attribute name="selected"/>
										</xsl:if>
										<xsl:value-of select="localization:getGTPString($language, 'XSL_BASELINE_UPLOAD_FORMAT_DECIMAL_FRENCH')"/>
									</option>
						    	</xsl:with-param>
						    	<xsl:with-param name="fieldsize">small</xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
			<div id="amount_format_select_other_div" class="hide">
				<xsl:call-template name="input-field">
			    	<xsl:with-param name="name">amount_format_other</xsl:with-param>
			    	<xsl:with-param name="id">amount_format_other</xsl:with-param>
			    	<xsl:with-param name="size">3</xsl:with-param>
		       		<xsl:with-param name="maxsize">35</xsl:with-param>
		       		<xsl:with-param name="fieldsize">small</xsl:with-param>
		   		</xsl:call-template>
			</div>
			</div>
		</div>
		</div> 
				<div class="inlineBlock" style="width:240px;">
					<div id="column_start_length_div" class="hide">
						<xsl:call-template name="input-field">
					    	<xsl:with-param name="label">XSL_BASELINE_UPLOAD_FORMAT_START</xsl:with-param>
					    	<xsl:with-param name="name">start</xsl:with-param>
					    	<xsl:with-param name="id">start</xsl:with-param>
					    	<xsl:with-param name="size">3</xsl:with-param>
				       		<xsl:with-param name="maxsize">35</xsl:with-param>
				       		<xsl:with-param name="fieldsize">xx-small</xsl:with-param>
				   		</xsl:call-template>
				   		<xsl:call-template name="input-field">
					    	<xsl:with-param name="label">XSL_BASELINE_UPLOAD_FORMAT_LENGTH</xsl:with-param>
					    	<xsl:with-param name="name">format_length</xsl:with-param>
					    	<xsl:with-param name="id">format_length</xsl:with-param>
					    	<xsl:with-param name="size">3</xsl:with-param>
				       		<xsl:with-param name="maxsize">35</xsl:with-param>
				       		<xsl:with-param name="fieldsize">xx-small</xsl:with-param>
				       		<xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
				   		</xsl:call-template>
					</div>
				</div> 
				<div id="unit_code_div" class="hide">
				(<a class="InterestRatesAlink">
					<xsl:attribute name="onclick">misys.helpQuantityCodesDialog();</xsl:attribute>	
					 <xsl:value-of select="localization:getGTPString($language, 'XSL_HELP_IP_UNIT_CODES')"/>
				 </a>)
				 </div>
				 <div id="quantity_code_help_container" class="hide">
				 	<div id="quantity_code_help_table_container">
				 	<table border="1">
				 		<tr>
							<th><xsl:value-of select="localization:getGTPString($language, 'NAME')" /></th>
							<th><xsl:value-of select="localization:getGTPString($language, 'VALUE')" /></th>
				 		</tr>
				 		<tr>
				 			<td>EA</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'EA')" /></td>
				 		</tr>
				 		<tr>
				 			<td>BG</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'BG')" /></td>
				 		</tr>
				 		<tr>
				 			<td>BL</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'BL')" /></td>
				 		</tr>
				 		<tr>
				 			<td>BO</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'BO')" /></td>
				 		</tr>
				 		<tr>
				 			<td>BX</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'BX')" /></td>
				 		</tr>
				 		<tr>
				 			<td>CH</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'CH')" /></td>
				 		</tr>
				 		<tr>
				 			<td>CT</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'CT')" /></td>
				 		</tr>
				 		<tr>
				 			<td>CR</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'CR')" /></td>
				 		</tr>
				 		<tr>
				 			<td>CLT</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'CLT')" /></td>
				 		</tr>
				 		<tr>
				 			<td>GRM</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'GRM')" /></td>
				 		</tr>
				 		<tr>
				 			<td>KGM</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'KGM')" /></td>
				 		</tr>
				 		<tr>
				 			<td>LTN</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'LTN')" /></td>
				 		</tr>
				 		<tr>
				 			<td>LBR</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'LBR')" /></td>
				 		</tr>
				 		<tr>
				 			<td>ONZ</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'ONZ')" /></td>
				 		</tr>
				 		<tr>
				 			<td>STN</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'STN')" /></td>
				 		</tr>
				 		<tr>
				 			<td>INQ</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'INQ')" /></td>
				 		</tr>
				 		<tr>
				 			<td>LTR</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'LTR')" /></td>
				 		</tr>
				 		<tr>
				 			<td>MTQ</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'MTQ')" /></td>
				 		</tr>
				 		<tr>
				 			<td>OZA</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'OZA')" /></td>
				 		</tr>
				 		<tr>
				 			<td>OZI</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'OZI')" /></td>
				 		</tr>
				 		<tr>
				 			<td>PT</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'PT')" /></td>
				 		</tr>
				 		<tr>
				 			<td>PTI</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'PTI')" /></td>
				 		</tr>
				 		<tr>
				 			<td>QT</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'QT')" /></td>
				 		</tr>
				 		<tr>
				 			<td>QTI</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'QTI')" /></td>
				 		</tr>
				 		<tr>
				 			<td>FTK</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'FTK')" /></td>
				 		</tr>
				 		<tr>
				 			<td>INK</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'INK')" /></td>
				 		</tr>
				 		<tr>
				 			<td>KMK</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'KMK')" /></td>
				 		</tr>
				 		<tr>
				 			<td>MIK</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'MIK')" /></td>
				 		</tr>
				 		<tr>
				 			<td>MMK</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'MMK')" /></td>
				 		</tr>
				 		<tr>
				 			<td>MTK</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'MTK')" /></td>
				 		</tr>
				 		<tr>
				 			<td>YDK</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'YDK')" /></td>
				 		</tr>
				 		<tr>
				 			<td>CMK</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'CMK')" /></td>
				 		</tr>
				 		<tr>
				 			<td>1A</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', '1A')" /></td>
				 		</tr>
				 		<tr>
				 			<td>CMT</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'CMT')" /></td>
				 		</tr>
				 		<tr>
				 			<td>FOT</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'FOT')" /></td>
				 		</tr>
				 		<tr>
				 			<td>INH</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'INH')" /></td>
				 		</tr>
				 		<tr>
				 			<td>KTM</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'KTM')" /></td>
				 		</tr>
				 		<tr>
				 			<td>LY</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'LY')" /></td>
				 		</tr>
				 		<tr>
				 			<td>MTR</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'MTR')" /></td>
				 		</tr>
				 		<tr>
				 			<td>OTHR</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N202', 'OTHR')" /></td>
				 		</tr>
				 	</table>
				 	</div>
				 </div>
				 	<div id="payment_term_code_div" class="hide">
				(<a class="InterestRatesAlink">
					<xsl:attribute name="onclick">misys.helpPaymentTermCodesDialog();</xsl:attribute>	
					 <xsl:value-of select="localization:getGTPString($language, 'XSL_HELP_PAYMNT_TERM_CODES')"/>
				 </a>)
				 </div>
				 <div id="payment_term_code_help_container" class="hide">
				 	<div id="payment_term_code_help_table_container">
				 	<table border="1">
				 		<tr>
							<th><xsl:value-of select="localization:getGTPString($language, 'NAME')" /></th>
							<th><xsl:value-of select="localization:getGTPString($language, 'VALUE')" /></th>
				 		</tr>
				 		<tr>
				 			<td>CASH</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N208', 'CASH')" /></td>
				 		</tr>
				 		<tr>
				 			<td>EMTD</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N208', 'EMTD')" /></td>
				 		</tr>
				 		<tr>
				 			<td>EMTR</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N208', 'EMTR')" /></td>
				 		</tr>
				 		<tr>
				 			<td>EPRD</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N208', 'EPRD')" /></td>
				 		</tr>
				 		<tr>
				 			<td>EPRR</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N208', 'EPRR')" /></td>
				 		</tr>
				 		<tr>
				 			<td>IREC</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N208', 'IREC')" /></td>
				 		</tr>
				 		<tr>
				 			<td>PRMD</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N208', 'PRMD')" /></td>
				 		</tr>
				 		<tr>
				 			<td>PRMR</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N208', 'PRMR')" /></td>
				 		</tr>
				 		<tr>
				 			<td>OTHR</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N208', 'OTHR')" /></td>
				 		</tr>
				 		</table>
				 	</div>
				 </div>
				 <!-- Adjustment help codes added as part of MPS-47256  -->
				 <div id="adjustment_type_div" class="hide">
				(<a class="InterestRatesAlink">
					<xsl:attribute name="onclick">misys.helpAdjustmentTypesDialog();</xsl:attribute>	
					 <xsl:value-of select="localization:getGTPString($language, 'XSL_HELP_ADJUSTMENT_TYPES')"/>
				 </a>)
				 </div>
				 <div id="adjustment_type_help_container" class="hide">
				 	<div id="adjustment_type_help_table_container">
				 	<table border="1">
				 		<tr>
							<th><xsl:value-of select="localization:getGTPString($language, 'NAME')" /></th>
							<th><xsl:value-of select="localization:getGTPString($language, 'VALUE')" /></th>
				 		</tr>
				 		<tr>
				 			<td>REBA</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N210', 'REBA')" /></td>
				 		</tr>
				 		<xsl:if test ="(($fscm_cash_customization_enable = 'false' and $productcode = 'IP') or $productcode = 'IN' )">
				 		<tr>
				 			<td>DISC</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N210', 'DISC')" /></td>
				 		</tr>
				 		</xsl:if>
				 		<tr>
				 			<td>CREN</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N210', 'CREN')" /></td>
				 		</tr>
				 		<tr>
				 			<td>DEBN</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N210', 'DEBN')" /></td>
				 		</tr>
				 		<tr>
				 			<td>OTHR</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N210', 'OTHR')" /></td>
				 		</tr>
				 		</table>
				 	</div>
				 </div>
				  <div id="adjustment_dir_div" class="hide" width = '200px'>
				(<a class="InterestRatesAlink">
					<xsl:attribute name="onclick">misys.helpAdjustmentDirectionDialog();</xsl:attribute>	
					 <xsl:value-of select="localization:getGTPString($language, 'XSL_HELP_ADJUSTMENT_DIRECTION')"/>
				 </a>)
				 </div>
				 <div id="adjustment_dir_help_container" class="hide">
				 	<div id="adjustment_dir_help_table_container">
				 	<table border="1">
				 		<tr>
							<th><xsl:value-of select="localization:getGTPString($language, 'NAME')" /></th>
							<th><xsl:value-of select="localization:getGTPString($language, 'VALUE')" /></th>
				 		</tr>
				 		<tr>
				 			<td>ADDD</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N216', 'ADDD')" /></td>
				 		</tr>
				 		<tr>
				 			<td>SUBS</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N216', 'SUBS')" /></td>
				 		</tr>
				 		</table>
				 	</div>
				 </div>
				 
				 
				  <div id="tax_type_div" class="hide" width = '200px'>
				(<a class="InterestRatesAlink">
					<xsl:attribute name="onclick">misys.helpTaxTypeDialog();</xsl:attribute>	
					 <xsl:value-of select="localization:getGTPString($language, 'XSL_HELP_TAX_TYPE')"/>
				 </a>)
				 </div>
				 <div id="tax_type_help_container" class="hide">
				 	<div id="tax_type_help_table_container">
				 	<table border="1">
				 		
				 		<tr>
							<th><xsl:value-of select="localization:getGTPString($language, 'NAME')" /></th>
							<th><xsl:value-of select="localization:getGTPString($language, 'VALUE')" /></th>
				 		</tr>
				 		<tr>
				 			<td>COAX</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N210', 'COAX')" /></td>
				 		</tr>
				 		<tr>
				 			<td>NATI</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N210', 'NATI')" /></td>
				 		</tr>
				 		<tr>
				 			<td>PROV</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N210', 'PROV')" /></td>
				 		</tr>
				 		<tr>
				 			<td>STAM</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N210', 'STAM')" /></td>
				 		</tr>
				 		<tr>
				 			<td>STAT</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N210', 'STAT')" /></td>
				 		</tr>
				 		
				 		<tr>
				 			<td>STAM</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N210', 'STAM')" /></td>
				 		</tr>
				 		
				 		<tr>
				 			<td>WITH</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N210', 'WITH')" /></td>
				 		</tr>
				 		
				 		<tr>
				 			<td>CUST</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N210', 'CUST')" /></td>
				 		</tr>
				 		
				 		<tr>
				 			<td>VATA</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N210', 'VATA')" /></td>
				 		</tr>
				 		
				 		</table>
				 	</div>
				 </div>
				 
				 
				  <div id="freight_charge_type_div" class="hide" width = '200px'>
				(<a class="InterestRatesAlink">
					<xsl:attribute name="onclick">misys.helpFreightChargeTypeDialog();</xsl:attribute>	
					 <xsl:value-of select="localization:getGTPString($language, 'XSL_HELP_FREIGHT_CHARGE_TYPE')"/>
				 </a>)
				 </div>
				 <div id="freight_charge_type_help_container" class="hide">
				 	<div id="freight_charge_type_help_table_container">
				 	<table border="1">
				 		
				 		
				 		<tr>
							<th><xsl:value-of select="localization:getGTPString($language, 'NAME')" /></th>
							<th><xsl:value-of select="localization:getGTPString($language, 'VALUE')" /></th>
				 		</tr>
				 		<tr>
				 			<td>AIRF</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N210', 'AIRF')" /></td>
				 		</tr>
				 		<tr>
				 			<td>CHDE</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N210', 'CHDE')" /></td>
				 		</tr>
				 		<tr>
				 			<td>CHOR</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N210', 'CHOR')" /></td>
				 		</tr>
				 		<tr>
				 			<td>COLF</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N210', 'COLF')" /></td>
				 		</tr>
				 		<tr>
				 			<td>DNGR</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N210', 'DNGR')" /></td>
				 		</tr>
				 		
				 		<tr>
				 			<td>COLF</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N210', 'COLF')" /></td>
				 		</tr>
				 		
				 		<tr>
				 			<td>INSU</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N210', 'INSU')" /></td>
				 		</tr>
				 		
				 		<tr>
				 			<td>PACK</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N210', 'PACK')" /></td>
				 		</tr>
				 		
				 		<tr>
				 			<td>PICK</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N210', 'PICK')" /></td>
				 		</tr>
				 		
				 		<tr>
				 			<td>SECU</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N210', 'SECU')" /></td>
				 		</tr>
				 		
				 		<tr>
				 			<td>SIGN</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N210', 'SIGN')" /></td>
				 		</tr>
				 		
				 		<tr>
				 			<td>STOR</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N210', 'STOR')" /></td>
				 		</tr>
				 		
				 		<tr>
				 			<td>STDE</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N210', 'STDE')" /></td>
				 		</tr>
				 		
				 		<tr>
				 			<td>TRPT</td>
				 			<td><xsl:value-of select="localization:getDecode($language, 'N210', 'TRPT')" /></td>
				 		</tr>
				 		
				 		</table>
				 	</div>
				 </div>
				 
				 
				 <div id="fscm_programme_code_div" class="hide">
				 </div>
			</div>
	</xsl:template>
	
	<!--********************************-->
	<!-- Populate Existing Column Stuff -->
	<!--********************************-->
	
	<!-- Creates a new Option element for the list of column -->
	<xsl:template match="column" mode="list">
		<xsl:variable name="codeval">
			<xsl:choose>
				<xsl:when test="name='iss_date' and ($productcode='IP' or $productcode='IN')">XSL_REPORT_COL_invoice_date</xsl:when>
				<xsl:when test="name='issuer_ref_id' and ($productcode='IP' or $productcode='IN')">XSL_REPORT_COL_invoice_ref_id</xsl:when>
				<xsl:when test="name='issuer_ref_id' and ($productcode='PO')">XSL_REPORT_COL_po_reference</xsl:when>
				<xsl:otherwise>XSL_REPORT_COL_<xsl:value-of select="name"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<option>
			<xsl:attribute name="value"><xsl:value-of select="name"/></xsl:attribute>
			<xsl:value-of select="localization:getGTPString($language, $codeval)"/>
		</option>
	</xsl:template>
	
	<xsl:template name="update-column-information">
		<script>
			dojo.ready(function(){
			misys._config = (misys._config) || {};
			misys._config.mappedColumns = misys._config.mappedColumns || [];
			misys._config.matchedColumn = "Y";

			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_CUST_REF_ID')"/>"]  		= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			//misys._config.mappedColumns["line_item_nb"] = {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_PRODUCT_NAME')"/>"]	= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_LAST_SHIP_DATE')"/>"]  	= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_UNIT_CODE')"/>"]  		= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_QUANTITY_VALUE')"/>"] 	= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_QUANTITY_FACTOR')"/>"] 	= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_QUANTITY_TOLERANCE_POSITIVE_PERCENTAGE')"/>"] 	= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_QUANTITY_TOLERANCE_NEGATIVE_PERCENTAGE')"/>"]	= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_PRICE_CUR_CODE')"/>"]	= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_PRICE_AMOUNT')"/>"] = {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_PRICE_FACTOR')"/>"] = {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_PRICE_TOLERANCE_POSITIVE_PERCENTAGE')"/>"] = {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_PRICE_TOLERANCE_NEGATIVE_PERCENTAGE')"/>"] = {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_TOTAL_CUR_CODE')"/>"] 			= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_TOTAL_AMOUNT')"/>"] 			= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_TOTAL_NET_CUR_CODE')"/>"] 		= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_TOTAL_NET_AMOUNT')"/>"] 		= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["ignored_column"] 		= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ERP_ID')"/>"] = {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			<!--Adjustment section  -->
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ADJUSTMENT_TYPE')"/>"] = {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ADJUSTMENT_DIR')"/>"] = {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ADJUSTMENT_CUR_CODE')"/>"] = {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ADJUSTMENT_AMT')"/>"] = {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ADJUSTMENT_PERCENTAGE')"/>"] = {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ADJUSTMENT_CREDIT_NOTE_REFERENCE')"/>"] = {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ADJUSTMENT_OTHER_CODE')"/>"] = {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["discount_exp_date"] = {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			 <!-- Taxes -->
			 
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TAX_TYPE')"/>"] = {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TAX_CUR_CODE')"/>"] = {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TAX_AMT')"/>"] = {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TAX_PERCENTAGE')"/>"] = {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TAX_OTHER_CODE')"/>"] = {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			<!-- Freight Charges -->
			
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_FREIGHT_CHARGE_TYPE')"/>"] = {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_FREIGHT_CHARGE_CUR_CODE')"/>"] = {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_FREIGHT_CHARGE_AMT')"/>"] = {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_FREIGHT_CHARGE_PERCENTAGE')"/>"] = {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_FREIGHT_CHARGE_OTHER_CODE')"/>"] = {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_FSCM_PROGRAMME_CODE')"/>"] = {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_CUST_REF_ID')"/>"]  			= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ISSUER_REF_ID')"/>"]  		= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			//misys._config.mappedColumns["po_reference"] 		= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			//misys._config.mappedColumns["lt_cust_ref_id"] 		= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ISSUE_DATE')"/>"]  			= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_DUE_DATE')"/>"]  			= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SELLER_ABBREVIATED_NAME')"/>"] 			= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SELLER_NAME')"/>"] 			= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_BUYER_ABBREVIATED_NAME')"/>"] 			= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_BUYER_NAME')"/>"] 			= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TOTAL_NET_CUR_CODE')"/>"] 					= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TOTAL_NET_AMOUNT')"/>"]  					= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ISSUING_BANK_ABBREVIATED_NAME')"/>"] 		= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ISSUING_BANK_CUSTOMER_REFERENCE')"/>"] 		= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_PAYMENT_TERM_CODE')"/>"]						= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_OTHER_PAYMENT_CONDITION')"/>"]				= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_PAYMENT_TERM_NB_DAYS')"/>"] 					= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_PAYMENT_TERM_CUR_CODE')"/>"]					= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_PAYMENT_TERM_AMT')"/>"] 						= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_PAYMENT_PCT')"/>"] 						= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			
			//misys._config.mappedColumns["inco_term"] 			= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			//misys._config.mappedColumns["inco_place"] 		= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			
			// PO Upload Mapped Fields - starts here
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_PAYMENT_IN_PROGRESS')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_PENDING_NET_AMT')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_PENDING_AMT')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_PENDING_QTY')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_ORIGINAL_NET_AMT')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_ORIGINAL_AMT')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_ORIGINAL_QTY')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_EARLIEST_SHIP_DATE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_FREIGHT_CHARGES_TYPE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_ACCPT_TOTAL_AMT')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_ACCPT_TOTAL_CUR_CODE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_ACCPT_TOTAL_NET_AMT')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_ACCPT_TOTAL_NET_CUR_CODE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_LIAB_TOTAL_AMT')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_LIAB_TOTAL_CUR_CODE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_OUTSTANDING_TOTAL_AMT')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_LIAB_TOTAL_NET_AMT')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_LIAB_TOTAL_NET_CUR_CODE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_ORDER_TOTAL_AMT')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_ORDER_TOTAL_CUR_CODE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_ORDER_TOTAL_NET_AMT')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_ORDER_TOTAL_NET_CUR_CODE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_PRICE_OTHER_UNIT_MEASR')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_PRICE_UNIT_MEASR_CODE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_LINE_ITEM_QTY_OTHER_UNIT_MEASR')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_PAYMENT_TERM_OTHER_PAYMT_TERMS')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_PAYMENT_TERM_PAYMT_DATE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			
			
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_RS_CARRIER_NAME')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_RS_TAKING_IN_CHARGE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_RS_PLACE_OF_FINAL_DESTINATION')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_RS_ROUTING_SUMMARY_MODE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_RS_ROUTING_SUMMARY_TYPE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			
			
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_RS_DETAILS_AIRPORT_CODE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_RS_DETAILS_AIRPORT_NAME')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_RS_DETAILS_TOWN')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_RS_DETAILS_PLACE_NAME')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_RS_DETAILS_PORT_NAME')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_RS_DETAILS_ROUTING_SUMMARY_SUB_TYPE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			
			
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TRNSPT_TOWN_DISCHARGE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TRNSPT_TOWN_LOADING')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TRNSPT_TRANSPORT_GROUP')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TRNSPT_TRANSPORT_MODE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TRNSPT_TRANSPORT_SUB_TYPE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TRNSPT_TRANSPORT_TYPE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TRNSPT_AIRPORT_DISCHARGE_CODE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TRNSPT_AIRPORT_DISCHARGE_NAME')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TRNSPT_AIRPORT_LOADING_CODE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TRNSPT_AIRPORT_LOADING_NAME')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TRNSPT_PLACE_DELIVERY')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TRNSPT_PLACE_FINAL_DEST')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_TRNSPT_PLACE_RECEIPT')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			
				
			
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_USER_INFO_TYPE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_USER_INFO_INFORMATION')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_USER_INFO_LABEL')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_INCO_TERM_CODE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_INCO_TERM_LOCATION')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_INCO_TERM_OTHER')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_GOODS_CATEGORY')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_GOODS_TYPE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_GOODS_IDENTIFIER')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_GOODS_CHARACTERISTIC')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_GOODS_GOODS_TYPE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_GOODS_GOODS_SUB_TYPE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_GOODS_OTHER_TYPE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_CONTACT_PERSON_TYPE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_CONTACT_PERSON_NAME_PREFIX')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_CONTACT_PERSON_NAME')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_CONTACT_PERSON_GIVEN_NAME')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_CONTACT_PERSON_ROLE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_CONTACT_PERSON_PHONE_NUMBER')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_CONTACT_PERSON_FAX_NUMBER')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_CONTACT_PERSON_EMAIL')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_CONTACT_PERSON_BIC')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SHIPMENT_SUB_SCHEDULE_SUB_SHIPMENT_QUANTITY_VALUE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SHIPMENT_SUB_SCHEDULE_EARLIEST_SHIP_DATE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SHIPMENT_SUB_SCHEDULE_LATEST_SHIP_DATE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_CONSGNOR_ABBV_NAME')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_CONSGNOR_NAME')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_CONSGNOR_BEI')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_CONSGNOR_STREET_NAME')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_CONSGNOR_TOWN_NAME')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_CONSGNOR_COUNTRY_SUB_DIV')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_CONSGNOR_POST_CODE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_CONSGNOR_COUNTRY')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SELLER_ACCOUNT_TYPE_CODE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SELLER_ACCOUNT_TYPE_PROP')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_EARLIEST_SHIP_DATE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SELLER_ACCOUNT_CUR_CODE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_FINAL_PRESENTATION')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ISSUER_TYPE_CODE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			
			
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_PAYMENT_TERMS_TYPE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_PRESENTATION_FLAG')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_SUBMISSION_TYPE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_PO_ISSUE_DATE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_ELIGIBILITY_FLAG')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_FINANCE_REQUESTED_FLAG')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_FULL_FINANCE_ACCEPTED_FLAG')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_INV_ELIGIBLE_AMT')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_INV_ELIGIBLE_CUR_CODE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_FINANCE_AMT')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_FINANCE_CUR_CODE')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_FINANCE_OFFER_FLAG')"/>"]	={"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			// PO Upload Mapped Fields - ends here
			
			<!-- Before populating the column parameters, checking if the template is old or new. If template is old dispaly appropriate message --> 
			<xsl:for-each select="definition/column">
			if(misys._config.mappedColumns['<xsl:value-of select="name"/>'] === undefined)
			{
				misys._config.matchedColumn = "N";
				return;
			}
			</xsl:for-each>
			
			<!-- Populating column parameters -->
			<xsl:for-each select="definition/column">
			<xsl:if test="start[.!='']">
				misys._config.mappedColumns['<xsl:value-of select="name"/>'].start 	= <xsl:value-of select="start"/>;
			</xsl:if>
			<xsl:if test="length[.!='']">
				misys._config.mappedColumns['<xsl:value-of select="name"/>'].formatLength = <xsl:value-of select="length"/>;
			</xsl:if>
			<xsl:if test="type[.!='']">
				misys._config.mappedColumns['<xsl:value-of select="name"/>'].dataType = '<xsl:value-of select="type"/>';
			</xsl:if>
			<xsl:if test="key[.!='']">
				misys._config.mappedColumns['<xsl:value-of select="name"/>'].key = '<xsl:value-of select="key"/>';
			</xsl:if>
			<xsl:if test="format[.!='']">
				<xsl:choose>
					<xsl:when test="type[.='Number']">
						misys._config.mappedColumns['<xsl:value-of select="name"/>'].amountFormat = '<xsl:value-of select="format"/>';
						misys._config.mappedColumns['<xsl:value-of select="name"/>'].amountFormatText = '<xsl:value-of select="format"/>';
					</xsl:when>
					<xsl:when test="type[.='Date']">
						misys._config.mappedColumns['<xsl:value-of select="name"/>'].dateFormatText = '<xsl:value-of select="format"/>';
						misys._config.mappedColumns['<xsl:value-of select="name"/>'].dateFormat = '<xsl:value-of select="format"/>';
					</xsl:when>
				</xsl:choose>
			</xsl:if>
		</xsl:for-each>
		 });	
		</script>
	</xsl:template>
	
	<xsl:template name="convert-delimiter-value">
		<xsl:param name="value"/>
		<xsl:choose>
			<xsl:when test="$value = ','">comma</xsl:when>
			<xsl:otherwise><xsl:value-of select="$value"/></xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
</xsl:stylesheet>