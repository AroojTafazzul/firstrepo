<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 User Screen, System Form.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
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
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		exclude-result-prefixes="localization technicalresource securitycheck utils">
 
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
  
  <xsl:param name="screen"/>
  <xsl:param name="productcode"/>
  <xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
  <xsl:param name="actionDownImage"><xsl:value-of select="$images_path"/>action-down.png</xsl:param>
  <xsl:param name="actionUpImage"><xsl:value-of select="$images_path"/>action-up.png</xsl:param>

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
 
 	<xsl:call-template name="system-menu"/>
    
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
   <xsl:with-param name="binding">misys.binding.openaccount.upload_template_cn</xsl:with-param>
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
		    <xsl:with-param name="label">XSL_CN_TEMPLATE_NAME</xsl:with-param>
		    <xsl:with-param name="name">name</xsl:with-param>
		    <xsl:with-param name="required">Y</xsl:with-param>
	    </xsl:call-template>
	    	<!-- Template Description -->
	    <xsl:call-template name="input-field">
		    <xsl:with-param name="label">XSL_CN_TEMPLATE_DESC</xsl:with-param>
		    <xsl:with-param name="name">description</xsl:with-param>
		    <xsl:with-param name="required">Y</xsl:with-param>
	    </xsl:call-template>
	    <div class="field inline-group">
			<label>
				<xsl:attribute name="for">column_mapping</xsl:attribute>
				<xsl:value-of select="localization:getGTPString($language, 'XSL_CN_TEMPLATE_COLUMN_MAPPING')"/>
			</label>
	    <xsl:choose>
	    	<xsl:when test="definition/delimiter/@type[.='fixed']"> 
	    	  <xsl:call-template name="radio-field">
		  			<xsl:with-param name="label">XSL_CN_TEMPLATE_FIXED_SIZE</xsl:with-param>
		   			<xsl:with-param name="name">mapping</xsl:with-param>
		   			<xsl:with-param name="value">fixed</xsl:with-param>
		   			<xsl:with-param name="id">mapping_fixed</xsl:with-param>
		   			<xsl:with-param name="checked">Y</xsl:with-param>
		   	  </xsl:call-template>
	    	</xsl:when>
	    	<xsl:otherwise>
	    	 <xsl:call-template name="radio-field">
		  			<xsl:with-param name="label">XSL_CN_TEMPLATE_FIXED_SIZE</xsl:with-param>
		   			<xsl:with-param name="name">mapping</xsl:with-param>
		   			<xsl:with-param name="value">fixed</xsl:with-param>
		   			<xsl:with-param name="id">mapping_fixed</xsl:with-param>
		   	</xsl:call-template>
	    	</xsl:otherwise>
	    </xsl:choose>
	    <xsl:choose>
	    	<xsl:when test="definition/delimiter/@type[.='dynamic']"> 
	    	  <xsl:call-template name="radio-field">
		  			<xsl:with-param name="label">XSL_CN_TEMPLATE_DELIMITED</xsl:with-param>
		   			<xsl:with-param name="name">mapping</xsl:with-param>
		   			<xsl:with-param name="value">delimited</xsl:with-param>
		   			<xsl:with-param name="id">mapping_delimited</xsl:with-param>
		   			<xsl:with-param name="checked">Y</xsl:with-param>
		   		</xsl:call-template>
	    	</xsl:when>
	    	<xsl:otherwise>
	    	 <xsl:call-template name="radio-field">
	  			<xsl:with-param name="label">XSL_CN_TEMPLATE_DELIMITED</xsl:with-param>
	   			<xsl:with-param name="name">mapping</xsl:with-param>
	   			<xsl:with-param name="value">delimited</xsl:with-param>
	   			<xsl:with-param name="id">mapping_delimited</xsl:with-param>
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
   		<xsl:call-template name="multichoice-field">
	    	<xsl:with-param name="label">XSL_CN_TEMPLATE_RELEASED_FLAG</xsl:with-param>
	    	<xsl:with-param name="name">executable</xsl:with-param>
	    	<xsl:with-param name="type">checkbox</xsl:with-param>
	    	<xsl:with-param name="checked">
	    		<xsl:choose>
	    			<xsl:when test="executable[.='Y']">true</xsl:when>
	    			<xsl:otherwise>false</xsl:otherwise>
	    		</xsl:choose>
	    	</xsl:with-param>
	    </xsl:call-template>
		 	
		<div id='disclaimer' style='display:none'>
			 <xsl:value-of select="localization:getGTPString($language, 'XSL_CN_TEMPLATE_OLD_MESSAGE')"/>
		</div>	
		
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- =========================================================================== -->
 <!-- ======================== Template Attached Banks ========================= -->
 <!-- =========================================================================== -->
 <xsl:template name="upload-template-mapping-columns">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_CN_TEMPLATE_MAPPED_COLUMNS</xsl:with-param>
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
		       <button dojoType="dijit.form.Button" type="button" id="add_column"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_ADD')" />&nbsp;&#8595;</button>
		       <button dojoType="dijit.form.Button" type="button" id="remove_column"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REMOVE')" />&nbsp;&#8593;</button>
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
    <xsl:with-param name="name">upload_template_id</xsl:with-param>
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
  		 
	 <option value="">
		<!-- <xsl:if test="definition/delimiter = ''">
			<xsl:attribute name="selected"/>
		</xsl:if>-->
	 </option>	 
		 
	 <option value="comma">
		<!-- <xsl:if test="definition/delimiter [.= ',']">
			<xsl:attribute name="selected"/>
		</xsl:if>-->
		<xsl:value-of select="localization:getGTPString($language, 'XSL_CN_TEMPLATE_DELIMITER_COMMA')"/>
	 </option>
	 
	  <option value=";;">
		<!-- <xsl:if test="definition/delimiter [.= ';;']">
			<xsl:attribute name="selected"/>
		</xsl:if>-->
		<xsl:value-of select="localization:getGTPString($language, 'XSL_CN_TEMPLATE_DELIMITER_SEMICOLON')"/>
	 </option>
	 		 
	 <!-- <option value="tab">
		<xsl:if test="definition/delimiter [.= 'tab']">
			<xsl:attribute name="selected"/>
		</xsl:if>
		<xsl:value-of select="localization:getGTPString($language, 'XSL_CN_TEMPLATE_DELIMITER_TAB')"/>
	 </option> -->
	 
	 <option value="OTHER">
		<!-- <xsl:if test="definition/delimiter [.!= ''] and definition/delimiter [.!= ','] and definition/delimiter [.!= ';'] and definition/delimiter [.!= ';;'] and definition/delimiter [.!= 'tab']">
			<xsl:attribute name="selected"/>
		</xsl:if>-->
		<xsl:value-of select="localization:getGTPString($language, 'XSL_CN_TEMPLATE_DELIMITER_OTHER')"/>
	 </option>
	 
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
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('CN_UPLOAD_CUST_REF_ID')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('CN_UPLOAD_FSCM_PRGRAMME_CODE')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('CN_UPLOAD_SELLER_ABBREVIATED_NAME')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('CN_UPLOAD_BUYER_ABBREVIATED_NAME')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('CN_UPLOAD_ISSUING_BANK_ABBREVIATED_NAME')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('CN_UPLOAD_ISSUER_REF_ID')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('CN_UPLOAD_CN_AMT')"/></xsl:with-param>
			<xsl:with-param name="column_type">Number</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('CN_UPLOAD_CUR_CODE')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
<!-- 		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_INVOICE_REF_ID')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template> -->
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('CN_UPLOAD_INVOICE_REF')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('CN_UPLOAD_CN_INV_AMT')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="avail_column">
			<xsl:with-param name="column_name"><xsl:value-of select="technicalresource:getTechnicalResource('CN_UPLOAD_CN_REFERENCE')"/></xsl:with-param>
			<xsl:with-param name="column_type">String</xsl:with-param>
		</xsl:call-template>
		
		
 	</xsl:template>
 	
 	<!-- Definition of columns -->
	<xsl:template name="Columns_Definitions">
		dojo.ready(function(){
  		misys._config = (misys._config) || {};
		misys._config.arrColumn = misys._config.arrColumn || [];
		
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('CN_UPLOAD_CUST_REF_ID')"/>"] = new Array("String", true);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('CN_UPLOAD_FSCM_PRGRAMME_CODE')"/>"] = new Array("String", true);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('CN_UPLOAD_SELLER_ABBREVIATED_NAME')"/>"] = new Array("String", true);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('CN_UPLOAD_BUYER_ABBREVIATED_NAME')"/>"] = new Array("String", true);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('CN_UPLOAD_ISSUING_BANK_ABBREVIATED_NAME')"/>"] = new Array("String", true);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('CN_UPLOAD_ISSUER_REF_ID')"/>"] = new Array("String", true);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('CN_UPLOAD_CUR_CODE')"/>"] = new Array("String", true);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('CN_UPLOAD_CN_AMT')"/>"] = new Array("String", true);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('CN_UPLOAD_INVOICE_REF')"/>"] = new Array("String", false);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('CN_UPLOAD_CN_INV_AMT')"/>"] = new Array("String", false);
		misys._config.arrColumn["<xsl:value-of select="technicalresource:getTechnicalResource('CN_UPLOAD_CN_REFERENCE')"/>"] = new Array("String", true);
    });
	</xsl:template>
	
	
	<!-- Creates an editing form for a selected column -->
	
	
	<xsl:template name="column-information">
			<div style="text-align:left;">
				<div>
					<div id="column_amount_format_div" class="inlineBlock">
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
								<!-- <option value="OTHER">
									<xsl:if test="format [.!= ''] and format [.!= 'english'] and format [.!= 'french']">
										<xsl:attribute name="selected"/>
									</xsl:if>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_BASELINE_TEMPLATE_DELIMITER_OTHER')"/>
								</option> -->
					    	</xsl:with-param>
					    	<xsl:with-param name="fieldsize">small</xsl:with-param>
						</xsl:call-template>
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
			</div>
	</xsl:template>
	
	<!--********************************-->
	<!-- Populate Existing Column Stuff -->
	<!--********************************-->
	
	<!-- Creates a new Option element for the list of column -->
	<xsl:template match="column" mode="list">
		<xsl:variable name="codeval">XSL_REPORT_COL_<xsl:value-of select="name"/></xsl:variable>
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

			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('CN_UPLOAD_CUST_REF_ID')"/>"]  					= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('CN_UPLOAD_FSCM_PRGRAMME_CODE')"/>"]				= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('CN_UPLOAD_SELLER_ABBREVIATED_NAME')"/>"] 		= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('CN_UPLOAD_BUYER_ABBREVIATED_NAME')"/>"]  		= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('CN_UPLOAD_ISSUING_BANK_ABBREVIATED_NAME')"/>"] 	= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('CN_UPLOAD_ISSUER_REF_ID')"/>"] 					= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('CN_UPLOAD_CUR_CODE')"/>"] 						= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('CN_UPLOAD_CN_AMT')"/>"] 							= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			<!-- misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('BASELINE_UPLOAD_INVOICE_REF_ID')"/>"] 					= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""}; -->
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('CN_UPLOAD_INVOICE_REF')"/>"] 					= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('CN_UPLOAD_CN_INV_AMT')"/>"] 							= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
			misys._config.mappedColumns["<xsl:value-of select="technicalresource:getTechnicalResource('CN_UPLOAD_CN_REFERENCE')"/>"] 					= {"dataType":"","value":"","minLength":"","maxLength":"","key":"","start":"","formatLength":"","dateFormat":"","dateFormatText":"","amountFormat":"","amountFormatText":""};
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
						<xsl:choose>
							<xsl:when test="format [.!= ''] and format [.!= 'english'] and format [.!= 'french']">
								misys._config.mappedColumns['<xsl:value-of select="name"/>'].amountFormatText = '<xsl:value-of select="format"/>';
								misys._config.mappedColumns['<xsl:value-of select="name"/>'].amountFormat = 'OTHER';
							</xsl:when>
							<xsl:otherwise>
								misys._config.mappedColumns['<xsl:value-of select="name"/>'].amountFormat = '<xsl:value-of select="format"/>';		
							</xsl:otherwise>
						</xsl:choose>
					
					</xsl:when>
					<!-- <xsl:when test="type[.='Date']">
						<xsl:choose>
							<xsl:when test="format [.!= ''] and format [.!= 'dd/MM/yy'] and format [.!= 'MM/dd/yy']">
								misys._config.mappedColumns['<xsl:value-of select="name"/>'].dateFormatText = '<xsl:value-of select="format"/>';
								misys._config.mappedColumns['<xsl:value-of select="name"/>'].dateFormat = 'OTHER';
							</xsl:when>
							<xsl:otherwise>
								misys._config.mappedColumns['<xsl:value-of select="name"/>'].dateFormat = '<xsl:value-of select="format"/>';		
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when> -->
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