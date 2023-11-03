<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
XSLT templates for HTML elements and general form layout, that are common to all pages that 
contain forms. This is divided into two sections - the first lists all HTML element templates, 
the second lists all other templates used in forms.

This is already imported by trade_common.xsl, bank_common.xsl and system_common.xsl.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      12/03/08
author:    Cormac Flynn
email:     cormac.flynn@misys.com
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
    xmlns:xmlutils="xalan://com.misys.portal.common.tools.XMLUtils"
    xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
    xmlns:securityUtils="xalan://com.misys.portal.common.tools.SecurityUtils"
    xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
    xmlns:jetspeedresources="xalan://com.misys.portal.core.util.JetspeedResources"
    xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
    xmlns:xd="http://www.pnp-software.com/XSLTdoc"
    exclude-result-prefixes="localization utils xmlutils securityCheck security jetspeedresources defaultresource xd">
    
 <xd:doc type="stylesheet">
 	Common templates for rendering UI controls
  </xd:doc>
  <xd:doc type="string">
	  <xd:short>Display mode in which the screen is rendered.</xd:short>
	  <xd:detail>
	  	One of <code>view</code> or <code>edit</code>.
	  	<br/>Should be set in templates that import this file, even if no value is assigned
	  </xd:detail>
  </xd:doc>
  <xsl:param name="is_from_local_service">N</xsl:param>
  <xsl:param name="displaymode"/>
  <xd:doc type="string">
  	<xd:short>Product code in lower case.</xd:short>
  	<xd:detail>
  	 For example, <code>lc</code> for Import Letter of Credit
  	<br/>Should be set in templates that import this file, even if no value is assigned
  	</xd:detail>
  </xd:doc>
  <xsl:param name="lowercase-product-code"/>
  <xd:doc type="string">
  	<xd:short>Language code in lower case.</xd:short>
  	<xd:detail>
  	 For example, <code>en</code> for English
  	<br/>Should be set in templates that import this file, even if no value is assigned
  	</xd:detail>
  </xd:doc>	
  <xsl:param name="language"/>
  <xd:doc type="string">
  	Indicator whether to display an Add button for Bulk
  </xd:doc>
  <xsl:param name="show-bulk-add">N</xsl:param>
  <xd:doc type="string">
  	Indicator whether to display an Update button for Bulk
  </xd:doc>
 <xsl:param name="show-bulk-update">N</xsl:param>
 <xd:doc type="string">
 	Character set for uppercase alphabets
 </xd:doc>
 <xsl:param name="up">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:param>
 <xd:doc type="string">
 	Character set for lowercase alphabets
 </xd:doc>
 <xsl:param name="lo">abcdefghijklmnopqrstuvwxyz</xsl:param>
 <xsl:param name="nicknameEnabled">false</xsl:param>
 <xsl:param name="trade_total_combined_sizeallowed"/>
 <xsl:param name="beneficiaryNicknameEnabled">false</xsl:param> 
 <xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
 <xsl:param name="deleteImage"><xsl:value-of select="$images_path"/>delete.png</xsl:param>
 <xsl:param name="previewImage"><xsl:value-of select="$images_path"/>preview.png</xsl:param>
 <xsl:param name="openDialogImage"><xsl:value-of select="$images_path"/>open_dialog.png</xsl:param>
 <xsl:param name="arrowRightImage"><xsl:value-of select="$images_path"/>arrow_right.png</xsl:param>
 <xsl:param name="noticeImage"><xsl:value-of select="$images_path"/>notice.png</xsl:param>
 <xsl:param name="extendedViewImage"><xsl:value-of select="$images_path"/>extended_view.png</xsl:param>
 <xsl:param name="amendPopUpImage"><xsl:value-of select="$images_path"/>amend_popup.png</xsl:param>
 <xsl:param name="printPreviewImage"><xsl:value-of select="$images_path"/>printpreview.png</xsl:param>
 <xsl:param name="compareImage"><xsl:value-of select="$images_path"/>compare.png</xsl:param>
 <xsl:param name="searchImage"><xsl:value-of select="$images_path"/>search.png</xsl:param>
 <xsl:param name="cleanUpImage"><xsl:value-of select="$images_path"/>cleanUp.png</xsl:param>
 <xsl:param name="actionDownImage"><xsl:value-of select="$images_path"/>action-down.png</xsl:param>
 <xsl:param name="actionUpImage"><xsl:value-of select="$images_path"/>action-up.png</xsl:param>
 <xsl:param name="eyeDownImage"><xsl:value-of select="$images_path"/>eye_slash_icon.png</xsl:param>
 <xsl:param name="eyeUpImage"><xsl:value-of select="$images_path"/>eye_icon.png</xsl:param>
 <xsl:param name="addImage"><xsl:value-of select="$images_path"/>pic_add.gif</xsl:param>
 <xsl:param name="removeImage"><xsl:value-of select="$images_path"/>pic_remove.gif</xsl:param>
 <xsl:param name="tabCloseHoverImage"><xsl:value-of select="$images_path"/>tabCloseHover.gif</xsl:param>
 <xsl:param name="clearImage"><xsl:value-of select="$images_path"/>pic_clear.gif</xsl:param>
    
 
  <!--
  ########################################################################
  #1 - HTML TEMPLATES
 
  Below, all templates for HTML elements (<input>, <form> etc.) 
  ########################################################################
  -->
  <xd:doc>
  	<xd:short>HTML Input Hidden field.</xd:short>
  	<xd:detail>
	  Notes:	
	  <br/>1. If no id is given, the id equals the name.
	  <br/>2. If no value is specified, the field is given the value of the node
	    that equals the name.
	  <br/>3. If no value should be set, pass an empty string as the value
  	</xd:detail>
  	<xd:param name="name">Name of the input field used in form submission. <b>Mandatory</b></xd:param>
  	<xd:param name="id">ID of the input field used in form submission. If no id is given, the id equals the name.</xd:param>
  	<xd:param name="value">Value of the input field. Defaulted to the value of the node matching the <code>name</code> property</xd:param>
  </xd:doc>
 <xsl:template name="hidden-field">
  <!-- Required Parameters -->
  <xsl:param name="name"/>
  
  <!-- Optional --> 
  <xsl:param name="id" select="$name"/> 
  <xsl:param name="value" select="//*[name()=$name]" />
 
  <!-- HTML -->
  <input type="hidden" dojoType="dijit.form.TextBox" readOnly="true">
   <xsl:if test="$name != ''">
   	<xsl:attribute name="name"><xsl:value-of select="$name"/></xsl:attribute>
   </xsl:if>
   <xsl:if test="$id!=''">
    <xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
   </xsl:if>
   <xsl:if test="$value!=''">
    <xsl:attribute name="value"><xsl:value-of select="$value"/></xsl:attribute>
   </xsl:if>
  </input>
 </xsl:template>
 
 	<xd:doc>
		<xd:short>HTML Input Field.</xd:short>
		<xd:detail>
		By default it renders an editable, non-required text input box with a size and maxsize of 35 characters.
		    
		  <br/>Renders the following types
		  <ul>
		  	<li>Input field</li>
		  	<li>Currency input field</li>
		  	<li>Account field</li>
		  	<li>Entity field</li>
		  </ul>
		   <br>Notes</br>
		   <ol>
		   	<li>If no value is given for value, the value of the node with the same name
		     as name is selected. Pass an empty string if you want no value.</li>
		  	<li>The id is given the same value as the name</li>
		   </ol>
		</xd:detail>
		<xd:param name="name">Name of the input field for form submission. <b>Mandatory</b></xd:param>
		<xd:param name="label">Localization key for the label</xd:param>
		<xd:param name="id">ID of the input field for form submission</xd:param>
		<xd:param name="value">Value of the input field. defaults to the value of the node matching the <code>name</code> property</xd:param>
		<xd:param name="content-after">content to be displayed after the value </xd:param>
		<xd:param name="type">
			Type of the input field. Defaults to text, which creates a dijit.form.ValidationTextBox. The following types are supported
			<ul>
				<li>date - Create a dijit.form.DateTextBox</li>		  
				<li>time - Create a dijit.form.TimeTextBox</li>
				<li>amount - Create a misys.form.CurrencyTextBox</li>
				<li>number or parity or integer - Create a dijit.form.NumberTextBox</li>
				<li>percentnumber - Create a misys.form.PercentNumberTextBox</li>
				<li>spreadnumber - Create a misys.form.SpreadTextBox</li>
				<li>file - Create a dijit.form.TextBox</li>
			</ul>
		</xd:param>
		<xd:param name="currency-value">Name of the currency to use if the field is an amount</xd:param>
		<xd:param name="appendClass">Add a custom class to this input</xd:param>
		<xd:param name="id">ID of the input field for form submission</xd:param>
		<xd:param name="size">Size of the input when rendered on screen. Not used by Dojo, but kept for backwards compatibility. Defaults to 35</xd:param>
		<xd:param name="maxsize">Maximum number of characters. Defaults to 35</xd:param>
		<xd:param name="fieldsize">Size of the input when rendered on screen. One among x-small, small, medium, large. Defaults to medium</xd:param>
		<xd:param name="disabled">Whether field is disabled. Defaults to N</xd:param>
		<xd:param name="required">Whether field is required or mandatory. Defaults to N</xd:param>
		<xd:param name="hide-required-status">Whether to hide the required indicator. Defaults to N</xd:param>
		<xd:param name="readonly">Whether field is readonly. Defaults to N</xd:param>
		<xd:param name="uppercase">Whether the field should contain all uppercase characters. Defaults to N</xd:param>
		<xd:param name="swift-validate">Whether field should be SWIFT validate. Defaults to Y</xd:param>
		<xd:param name="button-type">Whether to add a popup search icon.</xd:param>
		<xd:param name="override-displaymode">Defaults to value of displaymode</xd:param>
		<xd:param name="override-product-code">Defaults to value of lowercase-product-code</xd:param>
		<xd:param name="override-sub-product-code">Overridden value of sub-product code</xd:param>
		<xd:param name="prefix">Valid only if button-type is specified</xd:param>
		<xd:param name="keep-entity-product-button">Valid only if button-type is specified</xd:param>
		<xd:param name="override-constraints"></xd:param>
		<xd:param name="call-back-customer-field-post-name">Valid only if button-type is specified</xd:param>
		<xd:param name="override_company_abbv_name">Valid only if button-type is specified</xd:param>
		<xd:param name="regular-expression">Regular expression of the valid entry. Applies for ValidationTextBox and its Child Widgets</xd:param>
		<xd:param name="override-label"></xd:param>
		<xd:param name="swift">Defaults to N</xd:param>
		<xd:param name="codevalue-product-code">Valid only if button-type is specified</xd:param>
		<xd:param name="codevalue-sub-product-code">Valid only if button-type is specified</xd:param>
		<xd:param name="override-number-constraint"></xd:param>
		<xd:param name="override-applicant-reference">Valid only if button-type is specified</xd:param>
		<xd:param name="hide-label">Whether to hide the associated label. Defaults to N</xd:param>
		<xd:param name="title">Text to be displayed on hovering over the input field. Defaults to empty.</xd:param>
	</xd:doc>
  <xsl:template name="input-field">
   <!-- Required Parameters -->
    <xsl:param name="name"/>
  
   <!-- Optional -->
   <xsl:param name="label"/>
   <xsl:param name="id" select="$name"/>
   <xsl:param name="value" select="//*[name()=$name]" />
   <xsl:param name="content-after" /> 			<!--  content to be displayed after the value -->
   <xsl:param name="type">text</xsl:param>        <!-- Type of content that the field will hold -->
   <xsl:param name="currency-value"></xsl:param>        <!-- name of the currency to use if the field is an amount -->
   <xsl:param name="appendClass"></xsl:param>        <!-- Add a custom class to this input -->
   <xsl:param name="size">35</xsl:param>          <!-- Size is not used by Dojo, but kept for backwards compatibility -->
   <xsl:param name="maxsize">35</xsl:param>
   <xsl:param name="fieldsize">medium</xsl:param> <!-- x-small, small, medium, large -->
   <xsl:param name="disabled">N</xsl:param>
   <xsl:param name="required">N</xsl:param>       <!-- Whether this is a mandatory field. -->
   <xsl:param name="hide-required-status">N</xsl:param>  
   <xsl:param name="readonly">N</xsl:param> 
   <xsl:param name="uppercase">N</xsl:param>      <!-- Whether the field should contain all uppercase characters. -->
   <xsl:param name="swift-validate">Y</xsl:param>
   <xsl:param name="button-type"/> <!-- Whether to add a popup search icon. -->
   <xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
   <xsl:param name="override-product-code" select="$lowercase-product-code"/> <!-- product-code can be overridden -->
   <xsl:param name="override-sub-product-code"/> 
   <xsl:param name="prefix"/>
   <xsl:param name="keep-entity-product-button"/>
   <xsl:param name="override-constraints" />
   <xsl:param name="call-back-customer-field-post-name"/>
   <xsl:param name="override_company_abbv_name"/>
   <xsl:param name="regular-expression"/> <!-- Applies for ValidationTextBox and its Child Widgets -->
   <xsl:param name="override-label"></xsl:param>
   <xsl:param name="swift">N</xsl:param>
   <xsl:param name="codevalue-product-code"/>
   <xsl:param name="codevalue-sub-product-code"/>
   <xsl:param name="override-number-constraint"/>
   	<!--    used by set entity maintain -->
   <xsl:param name="override-applicant-reference"/>
   <xsl:param name="hide-label">N</xsl:param>
   <xsl:param name="override-value">N</xsl:param> <!-- Whether the field value is overriden for display -->
   <xsl:param name="custom-value"/> <!-- overriden custom value for display -->
   <xsl:param name="title" />
   <xsl:param name="companyId" /> <!-- Company Id Value -->
   <xsl:param name="highlight">N</xsl:param>
   
   <!-- HTML -->
	
   <xsl:call-template name="row-wrapper">
    <xsl:with-param name="id" select="$id"/>
    <xsl:with-param name="label" select="$label"/>
    <xsl:with-param name="appendClass" select="$appendClass"/>
    <xsl:with-param name="override-label" select="$override-label"/>
    <xsl:with-param name="required">
    	<xsl:choose>
    		<xsl:when test="$hide-required-status='Y'">N</xsl:when>
    		<xsl:otherwise><xsl:value-of select="$required"/></xsl:otherwise>
    	</xsl:choose>
    </xsl:with-param>
    <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
    <xsl:with-param name="hide-label" select="$hide-label"/>
    <xsl:with-param name="content">
     <xsl:choose>
      <xsl:when test="$override-displaymode='edit'">
       <div trim="true">
        <!-- Required Attributes -->
        <!-- Select Dojo Type -->
        <xsl:attribute name="dojoType">
         <xsl:choose>
          <xsl:when test="$type='date'">dijit.form.DateTextBox</xsl:when>
          <xsl:when test="$type='time'">dijit.form.TimeTextBox</xsl:when>          
          <xsl:when test="$type='amount'">misys.form.CurrencyTextBox</xsl:when>
          <xsl:when test="$type='number' or $type='parity' or $type='integer' or $type='exchrate'">dijit.form.NumberTextBox</xsl:when>
          <xsl:when test="$type='percentnumber'">misys.form.PercentNumberTextBox</xsl:when>
          <xsl:when test="$type='spreadnumber'">misys.form.SpreadTextBox</xsl:when>
          <xsl:when test="$type='file'">dijit.form.TextBox</xsl:when>
          <xsl:otherwise>dijit.form.ValidationTextBox</xsl:otherwise>
         </xsl:choose>
        </xsl:attribute>
        <xsl:if test="$name != ''">
        	<xsl:attribute name="name"><xsl:value-of select="$name"/></xsl:attribute>
        </xsl:if>
        <xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
        <!-- Dojo equivalent of maxsize is maxLength -->
        <xsl:attribute name="maxLength"><xsl:value-of select="$maxsize"/></xsl:attribute>
        <xsl:if test="$type='number' or $type='integer'">
         <xsl:attribute name="constraints">{min:0}</xsl:attribute>
        </xsl:if>
        <xsl:if test="$type='parity' or $type='integer'">
         <xsl:attribute name="constraints">{places:0}</xsl:attribute>
        </xsl:if>
        <xsl:if test="$type='exchrate'">
         <xsl:attribute name="constraints">{places:'0,8', pattern:'#0.#####'}</xsl:attribute>
        </xsl:if>
        <xsl:if test="$type='percentnumber'">
         <xsl:attribute name="constraints">{places:'0,8', pattern:'#0.#####'}</xsl:attribute>
        </xsl:if>        
        <xsl:if test="$type='spreadnumber'">
         <xsl:attribute name="constraints">{places:'0,6', pattern:'#0.#####'}</xsl:attribute>
        </xsl:if>
        <xsl:if test="$type='date'">
         <xsl:attribute name="constraints">{datePattern:'<xsl:value-of select="localization:getGTPString($language, 'DATE_FORMAT')"/>'}</xsl:attribute>
        </xsl:if>
        <xsl:if test="$title != ''">
        	<xsl:attribute name="title"><xsl:value-of select="$title"/></xsl:attribute>
        </xsl:if>
                
        <!-- Set style classes -->
        <xsl:attribute name="class">
         <xsl:value-of select="$fieldsize"/>
         <xsl:if test="$type!='password' and $swift-validate='Y'"> swift</xsl:if>
         <xsl:if test="$type='file'"> file</xsl:if>
         <!-- onfocusError popup is not being displayed for password field because of the below class added. -->
         <!-- <xsl:if test="$type='password'"> nofocusonerror</xsl:if> -->
         <xsl:if test="$appendClass != ''"><xsl:text> </xsl:text><xsl:value-of select="$appendClass"/></xsl:if>
        </xsl:attribute>
        
        <!-- Optional Attributes -->
        <xsl:if test="$type!='password' and (string-length(normalize-space($value)) > 0)">
         <xsl:attribute name="value"><xsl:value-of select="$value"/></xsl:attribute>
         <!-- Dates need to have the displayedValue set -->
         <xsl:if test="$type='date' or $type='amount'">
          <xsl:attribute name="displayedValue"><xsl:value-of select="$value"/></xsl:attribute>
         </xsl:if>
         <xsl:if test="$type='number' or $type='integer'">
         <xsl:choose>
          <xsl:when test="$override-number-constraint!=''">
           <xsl:attribute name="constraints"><xsl:value-of select="$override-number-constraint"></xsl:value-of></xsl:attribute>
          </xsl:when>
          <xsl:otherwise>
           <xsl:attribute name="constraints">{min:0}</xsl:attribute> 
          </xsl:otherwise>
         </xsl:choose>
         </xsl:if>
         <xsl:if test="$type='amount'">
         	<xsl:choose>
         	<xsl:when test="$currency-value!=''"><xsl:attribute name="constraints">{min:0, currency:'<xsl:value-of select="$currency-value"></xsl:value-of>'}</xsl:attribute></xsl:when>
         	<xsl:otherwise><xsl:attribute name="constraints">{min:0}</xsl:attribute></xsl:otherwise>
         	</xsl:choose>
        </xsl:if>
         
        </xsl:if>
        <xsl:if test="$disabled='Y'">
         <xsl:attribute name="disabled">true</xsl:attribute>
        </xsl:if>
        <xsl:if test="$required='Y'">
         <xsl:attribute name="required">true</xsl:attribute>
        </xsl:if>
        <xsl:if test="$readonly='Y'">
         <xsl:attribute name="readOnly">true</xsl:attribute>
        </xsl:if>
        <xsl:if test="$uppercase='Y'">
         <xsl:attribute name="uppercase">true</xsl:attribute>
        </xsl:if>
        
        <!-- Sometimes we have to set the type attribute -->
        <xsl:choose>
         <xsl:when test="$type='password'"><xsl:attribute name="type">password</xsl:attribute></xsl:when>
         <xsl:when test="$type='file'"><xsl:attribute name="type">file</xsl:attribute></xsl:when>
        </xsl:choose>
        
        <!-- override contraints -->
        <xsl:if test="$override-constraints != ''">
         <xsl:attribute name="constraints"><xsl:value-of select="$override-constraints" /></xsl:attribute>
        </xsl:if>
        
        <!-- override contraints -->
        <xsl:if test="$regular-expression != ''">
         <xsl:attribute name="regExp"><xsl:value-of select="$regular-expression" /></xsl:attribute>
        </xsl:if>
       </div> 
       <xsl:copy-of select="$content-after"/>
      </xsl:when>
      <xsl:otherwise>
       <xsl:if test="$value!=''">        
    	<div>
	      <xsl:choose>
        	<xsl:when test="$highlight='Y'">
        		<xsl:attribute name="class">contentAmendView highlight</xsl:attribute>
        	</xsl:when>
        	<xsl:otherwise>
        		<xsl:attribute name="class">content</xsl:attribute>
        	</xsl:otherwise>
	      </xsl:choose>
          <xsl:choose>
  		  <xsl:when test="$type='number' or $type='integer' ">
  		  <xsl:choose>
   			  <xsl:when test="$language = 'fr'"><xsl:value-of select="translate(format-number($value, '###,###,###,###,###'), ',', ' ' )" /><xsl:copy-of select="$content-after"/></xsl:when>
    	      <xsl:otherwise><xsl:value-of select="format-number($value, '###,###,###,###,###')"/><xsl:copy-of select="$content-after"/></xsl:otherwise>
          </xsl:choose>
          </xsl:when>
  		  <xsl:when test="$type='percentnumber'">
           <xsl:choose>
   			  <xsl:when test="$language = 'fr'">  <xsl:value-of select="translate(format-number(translate($value, ',','.') * 100, '#.########'),'.',',')"/><xsl:copy-of select="$content-after"/></xsl:when>
    	     <xsl:otherwise><xsl:value-of select="format-number($value * 100, '#.########')"/><xsl:copy-of select="$content-after"/></xsl:otherwise>
          </xsl:choose>
          </xsl:when>
          <xsl:when test="$type='spreadnumber'">
           <xsl:value-of select="format-number($value * 10000, '#.######')"/><xsl:copy-of select="$content-after"/>
          </xsl:when>
          <xsl:when test="$type='reference' and count(avail_main_banks/bank/entity/customer_reference[reference=$value]) >= 1">
           <xsl:value-of select="//*/avail_main_banks/bank/entity/customer_reference[reference=$value]/description"/><xsl:copy-of select="$content-after"/>
          </xsl:when>
          <xsl:when test="$type='reference' and count(avail_main_banks/bank/entity/customer_reference[reference=$value]) = 0">
           <xsl:value-of select="//*/avail_main_banks/bank/customer_reference[reference=$value]/description"/><xsl:copy-of select="$content-after"/>
          </xsl:when>
          <xsl:when test="$override-value = 'Y' and $custom-value != ''">
          	<xsl:value-of select="$custom-value"/>
          </xsl:when>
          <xsl:when test="$type='list'">
          	<xsl:value-of select="$value" disable-output-escaping="yes"/><xsl:copy-of select="$content-after"/>
          </xsl:when>
          <xsl:otherwise>
           <xsl:value-of select="$value"/><xsl:copy-of select="$content-after"/>
          </xsl:otherwise>
         </xsl:choose>
        </div>
       </xsl:if>
      </xsl:otherwise>
     </xsl:choose>

     <!--
      Append a button, if we have to
      -->
     <xsl:if test="$override-displaymode='edit' and $button-type!=''">
      <xsl:call-template name="get-button">
       <xsl:with-param name="button-type" select="$button-type"/>
       <xsl:with-param name="label">XSL_ALT_BENEFICIARY</xsl:with-param>
       <xsl:with-param name="id" select="$id"/>
       <xsl:with-param name="override-product-code" select="$override-product-code"/>
       <xsl:with-param name="override-sub-product-code" select="$override-sub-product-code"/>
       <xsl:with-param name="prefix" select="$prefix"/>
       <xsl:with-param name="keep-entity-product-button" select="$keep-entity-product-button"/>
       <xsl:with-param name="call-back-customer-field-post-name" select="$call-back-customer-field-post-name"/>
       <xsl:with-param name="override_company_abbv_name" select="$override_company_abbv_name" />
       <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
       <xsl:with-param name="swift" select="$swift"></xsl:with-param>
	   <xsl:with-param name="codevalue-product-code" select="$codevalue-product-code"/>
       <xsl:with-param name="codevalue-sub-product-code" select="$codevalue-sub-product-code"/>
       <xsl:with-param name="override-applicant-reference" select="$override-applicant-reference"/>
       <xsl:with-param name="alert-type" select="$value"/>
       <xsl:with-param name="companyId" select="$companyId"/>
      </xsl:call-template>
     </xsl:if>

	 <!-- Append the Date format if it is a date, set a empty localization value to disable it -->
     <xsl:if test="$type='date' and (($override-displaymode='view' and $value!='') or $override-displaymode='edit')">
       <span class="dateFormatLabel"><xsl:value-of select="localization:getGTPString($language, 'DATE_FORMAT_LABEL')"/>&nbsp;</span>
     </xsl:if>
    </xsl:with-param>
   </xsl:call-template>
   <xsl:if test="$rundata!='' ">
   <xsl:call-template name="localization-dblclick">
					<xsl:with-param name="xslName" select="$label" />
					<xsl:with-param name="localName" select="localization:getGTPString($rundata, $language, $label)" />
	</xsl:call-template>
	</xsl:if>
  </xsl:template>
  
  <!-- Country field -->
	<xd:doc>
		An input field to accept country code
		<xd:param name="prefix">An identifier for the field. The ID is formed by &lt;prefix&gt;_country</xd:param>
		<xd:param name="name">Name for form submission. Defaults to country</xd:param>
		<xd:param name="label">Localization key for label. Defaults to XSL_JURISDICTION_COUNTRY</xd:param>
		<xd:param name="value">Value of the field. Defaults to the value of the node matching the name value</xd:param>
		<xd:param name="displayedValue">Value of the field. Defaults to the value of the node matching the name value</xd:param>
		<xd:param name="required">Whether a required field. Defaults to N</xd:param>
		<xd:param name="override-displaymode">Displaymode can be overriden to show field values in an edit form. Defaults to displaymode of parent form</xd:param>
		<xd:param name="appendClass">CSS class to be applied</xd:param>
		<xd:param name="readonly">Whether readonly. Defaults to N</xd:param>
		<xd:param name="disabled">Whether disabled. Defaults to N</xd:param>
		<xd:param name="codevalue-product-code">Whether values are fetched from a Code value specific to a Product code</xd:param>
		<xd:param name="codevalue-sub-product-code">Whether values are fetched from a Code value specific to a Sub-Product code. Used along with codevalue-product-code</xd:param>
		<xd:param name="show-search-icon">Whether to show a lookup icon. Defaults to Y</xd:param>
	</xd:doc>
  <xsl:template name="country-field">
	<xsl:param name="prefix"></xsl:param>
	<xsl:param name="name">country</xsl:param>
	<xsl:param name="label">XSL_JURISDICTION_COUNTRY</xsl:param>
	<xsl:param name="value"  select="//*[name()=$name]" />
	<xsl:param name="displayedValue"  select="//*[name()=$name]" />
	<xsl:param name="required">N</xsl:param>
	<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
	<xsl:param name="appendClass"/>
	<xsl:param name="readonly">N</xsl:param>
	<xsl:param name="disabled">N</xsl:param>
	<xsl:param name="codevalue-product-code"/>
    <xsl:param name="codevalue-sub-product-code"/>
    <xsl:param name="show-search-icon">Y</xsl:param>
	
	<xsl:call-template name="row-wrapper">
	      <xsl:with-param name="id"><xsl:value-of select="$prefix"/>_country</xsl:with-param>
          <xsl:with-param name="label"><xsl:value-of select="$label"/></xsl:with-param>
          <xsl:with-param name="required"><xsl:value-of select="$required"/></xsl:with-param>
          <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
          <xsl:with-param name="appendClass" select="$appendClass"/>
	      <xsl:with-param name="content"> 
	      	<xsl:choose>
	    	  	<xsl:when test="$override-displaymode='edit'">
			      <div trim="true" uppercase="true" dojoType="dijit.form.ValidationTextBox" regExp="^[a-zA-Z]*$" class="xx-small">
				       <!-- Required Attributes -->
				       <xsl:attribute name="name"><xsl:value-of select="$name"/></xsl:attribute>
				       <xsl:attribute name="id"><xsl:value-of select="$prefix"/>_country</xsl:attribute>
				       <xsl:attribute name="maxLength">2</xsl:attribute>
				       
				       <!-- Optional Attributes -->
				       <xsl:if test="$value!=''">
				        	<xsl:attribute name="value"><xsl:value-of select="$value"/></xsl:attribute>
				        	<xsl:attribute name="displayedValue"><xsl:value-of select="$displayedValue"/></xsl:attribute>
				       </xsl:if>
				       <xsl:if test="$required='Y'">
					      	<xsl:attribute name="required">true</xsl:attribute>
					   </xsl:if>
					   <xsl:if test="$readonly='Y'">
					        <xsl:attribute name="readOnly">true</xsl:attribute>
					   </xsl:if>
					    <xsl:if test="$disabled='Y'">
					        <xsl:attribute name="disabled">true</xsl:attribute>
					   </xsl:if>
			      </div>
			      <xsl:if test="$show-search-icon = 'Y'">
			      <xsl:call-template name="get-button">
						<xsl:with-param name="button-type">codevalue</xsl:with-param>
						<xsl:with-param name="id"><xsl:value-of select="$prefix"/>_country_btn</xsl:with-param>
						<xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
						<xsl:with-param name="codevalue-product-code"><xsl:value-of select="$codevalue-product-code"/></xsl:with-param>
						<xsl:with-param name="codevalue-sub-product-code"><xsl:value-of select="$codevalue-sub-product-code"/></xsl:with-param>
				  </xsl:call-template>
				  </xsl:if>
				</xsl:when>
	      		<xsl:otherwise>
		      		 <xsl:if test="$value!=''">
		      		 <div class="content"><xsl:value-of select="$value"/></div>
		      		 </xsl:if>
		        </xsl:otherwise>
		     </xsl:choose>
		  </xsl:with-param>
	 </xsl:call-template>
  </xsl:template>
  
  <!--
   Creates a currency field pair ie. a field for the currency and a field for the amount.
   
   We need a special template for this pair since they occupy the same horizontal space and
   row-wrapper was not performing correctly in IE, in this instance.
   
   TODO Refactor
   -->
	<xd:doc>
		<xd:short>Creates a currency field pair</xd:short>
		<xd:detail>
 		A pair of fields for currency and amount are rendered. Internally, dijit.form.ValidationTextBox is used for currency field and misys.form.CurrencyTextBox is used for amount field
		</xd:detail>
		<xd:param name="label">Localized label for the field. <b>Mandatory</b>.</xd:param>
		<xd:param name="product-code">Product code. Used for displaying currencies in lookup. <b>Mandatory</b>.</xd:param>
		<xd:param name="override-product-code">Override value provided in product-code. Defaults to value of product-code</xd:param>
		<xd:param name="override-currency-name">Overridden name of currency field. Formed as &lt;product-code&gt;_cur_code</xd:param>
		<xd:param name="override-currency-value">Overridden value of the currency field. Defaults to the value of the node matching override-currency-name</xd:param>
		<xd:param name="override-amt-name">Overridden name of amount field. Formed as &lt;product-code&gt;_amt</xd:param>
		<xd:param name="override-amt-value">Overridden value of the amount field. Defaults to the value of the node matching override-amt-name</xd:param>
		<xd:param name="override-currency-displaymode">Overridden display mode of currency field</xd:param>
		<xd:param name="override-amt-displaymode">Overridden display mode of amount field</xd:param>
		<xd:param name="get-data-action">Server side Ajax action to fetch currencies in the lookup. <b>Mandatory</b> if show-button is Y.</xd:param>
		<xd:param name="maxsize">Maximum size of amount field. Defaults to 16</xd:param>
		<xd:param name="disabled">Whether disabled. Defaults to N</xd:param>
		<xd:param name="required">Whether mandatory. Defaults to N</xd:param>
		<xd:param name="currency-readonly">Whether currency field is readonly. Defaults to N</xd:param>
		<xd:param name="amt-readonly">Whether amount field is readonly. Defaults to N</xd:param>
		<xd:param name="show-button">Whether to show a currency lookup icon button. Defaults to Y</xd:param>
		<xd:param name="button-type">Buuton type for lookup. Defaults to &quot;currency&quot;</xd:param>
		<xd:param name="constraints">Whether to display the amount rounded off to two decimal places. Defaults to Y</xd:param>
		<xd:param name="show-amt">Whether to display amount field. Defaults to Y</xd:param>
		<xd:param name="appendClass">CSS class to be applied</xd:param>
		<xd:param name="show-currency">Whether to display currency field. Defaults to Y</xd:param>
		<xd:param name="user-action">Used by cash module to retrieve specific currencies from the back end</xd:param>
	</xd:doc>
  <xsl:template name="currency-field">
   <!-- Required fields -->
  
   <xsl:param name="label"/>
   <xsl:param name="product-code"/>
   <xsl:param name="override-product-code"/>
   <xsl:param name="sub-product-code"/>
   <xsl:param name="override-sub-product-code"/>   
   <xsl:param name="override-currency-name"><xsl:value-of select="$product-code"/>_cur_code</xsl:param>
   <xsl:param name="override-currency-value" select="//*[name()=$override-currency-name]"></xsl:param>   
   <xsl:param name="override-amt-name"><xsl:value-of select="$product-code"/>_amt</xsl:param>
   <xsl:param name="override-amt-value" select="//*[name()=$override-amt-name]"></xsl:param>
   <xsl:param name="override-currency-displaymode" select="$displaymode"/>
   <xsl:param name="override-amt-displaymode" select="$displaymode"/>
   <xsl:param name="get-data-action" />
   
   <!-- Amount is not more than 16 by default -->
   <xsl:param name="maxsize">15</xsl:param>  
  
   <!-- Field details -->
   <!-- <xsl:param name="value" select="//*[name()=$name]" />  -->
   <xsl:param name="disabled">N</xsl:param>
   <xsl:param name="required">N</xsl:param>       <!-- Whether this is a mandatory field. -->
   <xsl:param name="currency-readonly">N</xsl:param>
   <xsl:param name="amt-readonly">N</xsl:param>
   <xsl:param name="show-button">Y</xsl:param>
   <xsl:param name="button-type">currency</xsl:param>
   <xsl:param name="constraints">Y</xsl:param>
   <xsl:param name="show-amt">Y</xsl:param>
   <xsl:param name="appendClass"></xsl:param>
   <xsl:param name="show-currency">Y</xsl:param>
   <!-- Used by cash module to retrieve specific currencies from the back end-->
   <xsl:param name="user-action"/>
   <!--
    Setup the variables for the two fields 
    -->
   <xsl:variable name="currency-name"><xsl:value-of select="$override-currency-name"/></xsl:variable>
   <xsl:variable name="currency-value" select="$override-currency-value"/>
   
   <xsl:variable name="amt-name"><xsl:value-of select="$override-amt-name"/></xsl:variable>
   <xsl:variable name="amt-value" select="$override-amt-value"/>
   <xsl:variable name="row-name">
	    <xsl:choose>
		     <xsl:when test="$override-currency-displaymode='edit'"><xsl:value-of select="$currency-name"/></xsl:when>
		     <xsl:otherwise><xsl:value-of select="$amt-name"/></xsl:otherwise>
	    </xsl:choose>
   </xsl:variable>
   <xsl:call-template name="row-wrapper">
	    <xsl:with-param name="id" select="$row-name"/>
	    <xsl:with-param name="label" select="$label"/>
	    <xsl:with-param name="required" select="$required"/>
	    <xsl:with-param name="appendClass" select="$appendClass"/>
	    <!-- xsl:with-param name="override-displaymode" select="$override-amt-displaymode"/ -->
	    <xsl:with-param name="content">
		     <xsl:choose>
			      <xsl:when test="$override-currency-displaymode='edit' or $override-amt-displaymode='edit'">
					      <!-- Currency Code -->
					      <xsl:choose>
					      		<xsl:when test="$override-currency-displaymode = 'edit'">
					      			<xsl:if test="$show-currency = 'Y'">
									      <div trim="true" uppercase="true" dojoType="dijit.form.ValidationTextBox" regExp="^[a-zA-Z]*$">
										       <!-- Required Attributes -->
											   <xsl:attribute name="class">xx-small<xsl:text> </xsl:text><xsl:value-of select="$appendClass"/></xsl:attribute>
										       <xsl:attribute name="name"><xsl:value-of select="$currency-name"/></xsl:attribute>
										       <xsl:attribute name="id"><xsl:value-of select="$currency-name"/></xsl:attribute>
										       <xsl:attribute name="maxLength">3</xsl:attribute>
										       
										       <!-- Optional Attributes -->
										       <xsl:choose>
										       		<xsl:when test="$currency-value!=''">
										       			<xsl:attribute name="value"><xsl:value-of select="$currency-value"/></xsl:attribute>
											        	<xsl:attribute name="displayedValue"><xsl:value-of select="$currency-value"/></xsl:attribute>
										       		</xsl:when>
										       		<xsl:when test="$product-code !='bk' and  product_currencies/product_currencies_enabled[.='Y'] and product_currencies/product/sub_products/sub_product/default_sub_product_currency[.!='']">
										       			<xsl:attribute name="value"><xsl:value-of select="product_currencies/product/sub_products/sub_product/default_sub_product_currency"/></xsl:attribute>
											        	<xsl:attribute name="displayedValue"><xsl:value-of select="product_currencies/product/sub_products/sub_product/default_sub_product_currency"/></xsl:attribute>
										       		</xsl:when>										       		
										       </xsl:choose>
										
										       <xsl:if test="$disabled='Y'">
										        	<xsl:attribute name="disabled">true</xsl:attribute>
										       </xsl:if>
										         
										       <xsl:if test="$required='Y'">
										        	<xsl:attribute name="required">true</xsl:attribute>
										       </xsl:if>
										         
										       <xsl:if test="$currency-readonly='Y'">
										        	<xsl:attribute name="readOnly">true</xsl:attribute>
										       </xsl:if>
									      </div>
								    </xsl:if>
					      		</xsl:when>
						        <xsl:otherwise>
							       <xsl:if test="$show-currency = 'Y'">
							       			<div class="content"><xsl:value-of select="$currency-value"/></div>&nbsp;
							       </xsl:if>
						        </xsl:otherwise>
					      </xsl:choose>
					      <!-- Amount -->
							<xsl:choose>
								<xsl:when test="$override-amt-displaymode = 'edit'">
									<xsl:if test="$show-amt = 'Y'">
										<div trim="true" dojoType="misys.form.CurrencyTextBox">
											<!-- Required Attributes -->
											<xsl:attribute name="class">small<xsl:text> </xsl:text><xsl:value-of select="$appendClass"/></xsl:attribute>
											
											<xsl:attribute name="name"><xsl:value-of select="$amt-name" /></xsl:attribute>
											<xsl:attribute name="id"><xsl:value-of select="$amt-name" /></xsl:attribute>
											
											 <xsl:attribute name="maxLength"><xsl:value-of select="$maxsize"/></xsl:attribute>
							
											<xsl:if test="$constraints='Y'">
												<xsl:attribute name="constraints">{currency:'<xsl:value-of select="$currency-value"/>', min:0.00}</xsl:attribute>
											</xsl:if>
							
											<!-- Optional Attributes -->
											<xsl:if test="$amt-value!=''">
												<xsl:attribute name="value"><xsl:value-of
													select="$amt-value" /></xsl:attribute>
												<xsl:attribute name="displayedValue"><xsl:value-of
													select="$amt-value" /></xsl:attribute>
												<!-- <xsl:attribute name="constraints">{currency:'<xsl:value-of select="$currency-value"/>', min:0.00}</xsl:attribute>-->
											</xsl:if>
							
											<xsl:if test="$disabled='Y'">
												<xsl:attribute name="disabled">true</xsl:attribute>
											</xsl:if>
							
											<xsl:if test="$required='Y'">
												<xsl:attribute name="required">true</xsl:attribute>
											</xsl:if>
							
											<xsl:if test="$amt-readonly='Y'">
												<xsl:attribute name="readOnly">true</xsl:attribute>
											</xsl:if>
										</div>
									</xsl:if>
								</xsl:when>
								<xsl:otherwise>
									<xsl:if test="$show-amt = 'Y'">
										<div class="content">
											<xsl:value-of select="$amt-value" />
										</div>
									</xsl:if>
								</xsl:otherwise>
					      </xsl:choose>
				
						  <!-- Currency button -->
						  <xsl:if test="$override-currency-displaymode = 'edit' and $show-button='Y'">
								<xsl:choose>
									<xsl:when test="$override-product-code != ''">
										<xsl:call-template name="get-button">
											<xsl:with-param name="button-type">
												<xsl:value-of select="$button-type" />
											</xsl:with-param>
											<xsl:with-param name="id">
												<xsl:value-of select="$amt-name" />
											</xsl:with-param>
											<xsl:with-param name="override-product-code"
												select="$override-product-code" />
											<xsl:with-param name="override-sub-product-code"
												select="$sub-product-code" />												
											<xsl:with-param name="user-action" select="$user-action"/>
											<xsl:with-param name="get-data-action" select="$get-data-action" />
										</xsl:call-template>
									</xsl:when>
									<xsl:otherwise>
										<xsl:call-template name="get-button">
											<xsl:with-param name="button-type">
												<xsl:value-of select="$button-type" />
											</xsl:with-param>
											<xsl:with-param name="id">
												<xsl:value-of select="$amt-name" />
											</xsl:with-param>
											<xsl:with-param name="override-product-code">
												<xsl:value-of select="$product-code" />
											</xsl:with-param>
											<xsl:with-param name="override-sub-product-code"
												select="$sub-product-code" />											
											<xsl:with-param name="user-action" select="$user-action"/>
											<xsl:with-param name="get-data-action" select="$get-data-action" />
										</xsl:call-template>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:if>
			      </xsl:when>
			      <xsl:otherwise>
				       <xsl:if test=" $amt-value!='' or  $currency-value!='' ">
				 			<!-- We force concatenation otherwise the test $amt-value='' returns true even if $amt-value is not empty -->
				 			<!-- other solution: <xsl:if test="$show-amt = 'Y' and $show-currency = 'Y' and $amt-value!=''"> works also fine-->
					        <xsl:if test="not($show-amt = 'Y' and $show-currency = 'Y' and concat($amt-value, '')='')">
						        <div class="content">
						         <xsl:value-of select="$currency-value"/>&nbsp;<xsl:value-of select="$amt-value"/>
						        </div>
					        </xsl:if>
				       </xsl:if>
			      </xsl:otherwise>
		     </xsl:choose>&nbsp;
	     </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
  <!--
   HTML Select Field (Single and Multi Select).
   
   Note that required select fields must not have an empty option (the field
   will be blank by default), so that validation works correctly.
   
   ** Notes **
    1. If no value is given for value, the value of the node with the same name
     as name is selected. Pass an empty string if you want no value.
    2. The id is given the same value as the name
   ***********
   -->
	<xd:doc>
		<xd:short>HTML Select Field (Single and Multi Select)</xd:short>
		<xd:detail>
		Renders a single select or multi-select control.
		<br/><b>Note</b> that required select fields must not have an empty option (the field will be blank by default), so that validation works correctly.
		<br/>If no value is given for value, the value of the node with the same name as name is selected. Pass an empty string if you want no value.
		<br/>The id is given the same value as the name
		</xd:detail>
		<xd:param name="name">Name of the field for form submission. <b>Mandatory</b></xd:param>
		<xd:param name="label">Localized label for the field</xd:param>
		<xd:param name="id">ID of the field. Defaults to the value of <code>name</code></xd:param>
		<xd:param name="value">Selected value of the field. Defaults to the value of the node matching the <code>name</code></xd:param>
		<xd:param name="disabled">Whether disabled. Defaults to N</xd:param>
		<xd:param name="required">Whether mandatory. Defaults to N</xd:param>
		<xd:param name="type">
			Type of the select field. Following values are supported.
			<ul>
				<li>filter - Renders a select field. Internally uses a dijit.form.FilteringSelect or misys.form.SortedFilteringSelect based on whether <code>$sort-filter-select</code> is Y or N respectively</li>
				<li>multiple - Renders a multi-select. Internally uses a misys.form.MultiSelect or dijit.form.MultiSelect based on whether <code>$sort-multi-select</code> is Y or N respectively</li>
			</ul>
			If value is anything apart from <code>fiter</code> or <code>multiple</code>, renders a single select field by default which internally uses a dijit.form.Select
		</xd:param>
		<xd:param name="size">Number of items visible. Used only id type is <code>multiple</code></xd:param>
		<xd:param name="fieldsize">Size of the rendered control. Should be one among x-small, small, medium or large</xd:param>
		<xd:param name="appendClass">CSS class name to be applied</xd:param>
		<xd:param name="options">Raw HTML, listing the &lt;option&gt; tags for this element</xd:param>
		<xd:param name="store">Dojo data store used to feed the selectbox. If provided, <code>options</code> are ignored.</xd:param>
		<xd:param name="override-displaymode">Overridden display mode. Defaults to the display mode of the parent form</xd:param>
		<xd:param name="override-label">Overridden localized key for label</xd:param>
		<xd:param name="readonly">Whether readonly. Defaults to N</xd:param>
		<xd:param name="content-after">Content to be displayed after the value</xd:param>
		<xd:param name="sort-multi-select">Whether the visible options for multi-select are sorted</xd:param>
		<xd:param name="sort-filter-select">Whether the visible options for filter-select are sorted</xd:param>
	</xd:doc>
  <xsl:template name="select-field">
   <!-- Required Parameters -->
   <xsl:param name="name"/>
   
   <!-- Optional -->
   <xsl:param name="label"/>
   <xsl:param name="id" select="$name"/>
   <xsl:param name="value" select="//*[name()=$name]" />
   <xsl:param name="disabled">N</xsl:param>
   <xsl:param name="required">N</xsl:param>
   <xsl:param name="type">filter</xsl:param> <!-- Select, Filter or Multiple -->
   <xsl:param name="size"></xsl:param>     <!-- Used for multi-select -->
   <xsl:param name="fieldsize">medium</xsl:param>
   <xsl:param name="appendClass"></xsl:param>        <!-- Add a custom class to this input -->
   <xsl:param name="options"/> <!-- Raw html, listing the <option> tags for this element -->
   <xsl:param name="store"/> <!-- if set, the store is used to feed the selectbox ; options are ignored. -->
   <xsl:param name="override-displaymode" select="$displaymode"/>
   <xsl:param name="override-label"></xsl:param>
   <xsl:param name="readonly">N</xsl:param> 
   <xsl:param name="content-after" /> 			<!--  content to be displayed after the value -->
   <xsl:param name="sort-multi-select">Y</xsl:param>
   <xsl:param name="sort-filter-select">N</xsl:param>
   <xsl:param name="show-clear-button">N</xsl:param>
   <xsl:param name="highlight">N</xsl:param>
   <!-- HTML -->
<!--    <xsl:call-template name="localization-dblclick">
					<xsl:with-param name="xslName" select="$label" />
					<xsl:with-param name="localName" select="localization:getGTPString($rundata,$language, $label)" />
	</xsl:call-template> -->
   <xsl:call-template name="row-wrapper">
    <xsl:with-param name="id" select="$id"/>
    <xsl:with-param name="label" select="$label"/>
     <xsl:with-param name="appendClass" select="$appendClass"/>
     <xsl:with-param name="override-label" select="$override-label"/>
    <xsl:with-param name="required" select="$required='Y' and $override-displaymode='edit'"/>
    <xsl:with-param name="content">
     <xsl:choose>
      <xsl:when test="$override-displaymode='edit' and $store=''">
       <select autocomplete="true">
        <xsl:attribute name="dojoType">
         <xsl:choose>
          <xsl:when test="$type='multiple' and $sort-multi-select='Y'">misys.form.MultiSelect</xsl:when>
          <xsl:when test="$type='multiple' and $sort-multi-select='N'">dijit.form.MultiSelect</xsl:when>
          <xsl:when test="$type='filter' and $sort-filter-select='Y'">misys.form.SortedFilteringSelect</xsl:when>
          <xsl:when test="$type='filter' and $sort-filter-select='N'">dijit.form.FilteringSelect</xsl:when>
          <xsl:otherwise>dijit.form.Select</xsl:otherwise>
         </xsl:choose>
        </xsl:attribute>
        <!-- Required Attributes -->
        <xsl:if test="$name != ''">
        	<xsl:attribute name="name"><xsl:value-of select="$name"/></xsl:attribute>
        </xsl:if>
        <xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
        <xsl:attribute name="class"><xsl:value-of select="$fieldsize"/><xsl:if test="$type='multiple'"> multi-select nofocusonerror</xsl:if></xsl:attribute>
        <!-- Optional Attributes -->
        <xsl:if test="$disabled='Y'">
         <xsl:attribute name="disabled">true</xsl:attribute>
        </xsl:if>
		<xsl:if test="$readonly='Y'">
         <xsl:attribute name="readOnly">true</xsl:attribute>
        </xsl:if>
		
		<xsl:choose>
         <xsl:when test="$required='Y'">
          <xsl:attribute name="required">true</xsl:attribute>
          <xsl:attribute name="value"><xsl:value-of select="$value"/></xsl:attribute>
         </xsl:when>
         <xsl:when test="$required='N'">
          <xsl:attribute name="required">false</xsl:attribute>
          <xsl:attribute name="value"><xsl:value-of select="$value"/></xsl:attribute>
         </xsl:when>
         <xsl:otherwise>
          <xsl:if test="$value != ''">
           <xsl:attribute name="value"><xsl:value-of select="$value"/></xsl:attribute>
          </xsl:if>
         </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="$type='multiple'">
         <xsl:attribute name="multiple">true</xsl:attribute>
         <xsl:attribute name="size"><xsl:value-of select="$size"/></xsl:attribute>
        </xsl:if>
        <!-- Copy <option> elements. These are passed in as raw HTML -->
        <xsl:copy-of select="$options"/>
       </select>
      </xsl:when>
      <xsl:when test="$override-displaymode='edit' and $store!=''">
       <input autocomplete="true" dojoType="dijit.form.FilteringSelect">
        <!-- Required Attributes -->
        <xsl:attribute name="name"><xsl:value-of select="$name"/></xsl:attribute>
        <xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
        <xsl:attribute name="class"><xsl:value-of select="$fieldsize"/><xsl:if test="$type='multiple'"> multi-select</xsl:if></xsl:attribute>
        <xsl:attribute name="store"><xsl:value-of select="$store"/></xsl:attribute>
        <!-- Optional Attributes -->
        <xsl:if test="$disabled='Y'">
         <xsl:attribute name="disabled">true</xsl:attribute>
        </xsl:if>
        <!--
         Note that the value must be set to null if empty, otherwise the first option
         in the list will be chosen and a required select with no value will not be correctly
         validated.
        -->
        <xsl:choose>
         <xsl:when test="$required='Y'">
          <xsl:attribute name="required">true</xsl:attribute>
          <xsl:attribute name="value"><xsl:value-of select="$value"/></xsl:attribute>
         </xsl:when>
         <xsl:otherwise>
          <xsl:attribute name="required">false</xsl:attribute>
          <xsl:attribute name="value"><xsl:value-of select="$value"/></xsl:attribute>
         </xsl:otherwise>
        </xsl:choose>
       </input>
      </xsl:when>
      <xsl:otherwise>
       <div>
        <xsl:attribute name="class">
         <xsl:choose>
          <xsl:when test="$type='multiple' and $highlight='Y'">contentAmendView highlight multiple</xsl:when>
          <xsl:when test="$type='multiple'">content multiple</xsl:when>
          <xsl:when test="$highlight='Y'">contentAmendView highlight</xsl:when>
          <xsl:otherwise>content</xsl:otherwise>
         </xsl:choose>
        </xsl:attribute>
        <xsl:choose>
        	<xsl:when test="$store!=''">
        		<xsl:copy-of select="$store"/>
        	</xsl:when>
        	<xsl:otherwise>
        		<xsl:copy-of select="$options"/>
        	</xsl:otherwise> 
        </xsl:choose>
       </div>
      </xsl:otherwise>
     </xsl:choose>
   	 <xsl:if test="$show-clear-button ='Y'">
	 	<xsl:call-template name="button-wrapper">
		   <xsl:with-param name="label">XSL_ALT_CLEAR</xsl:with-param>
		   <xsl:with-param name="show-image">Y</xsl:with-param>
		   <xsl:with-param name="show-border">N</xsl:with-param>
		   <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($cleanUpImage)"/></xsl:with-param>
		   <xsl:with-param name="img-height">16</xsl:with-param>
		   <xsl:with-param name="img-width">13</xsl:with-param>
		   <xsl:with-param name="onclick">dijit.byId('<xsl:value-of select="$id"/>').set("value", '')</xsl:with-param>
		   <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_clear_img</xsl:if></xsl:with-param>
	 	</xsl:call-template>
   	 </xsl:if>
     <xsl:copy-of select="$content-after"/>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>

<!-- Template for day select box option -->
<xsl:template name="daynumber-options">
 <xsl:param name="label">XSL_DATE_NUMBER_</xsl:param>
 <xsl:param name="day-max">31</xsl:param> <!-- 28,29,30 or 31  -->
	  <option value="01">01</option>
      <option value="02">02</option>
      <option value="03">03</option>
      <option value="04">04</option>
      <option value="05">05</option>
      <option value="06">06</option>
      <option value="07">07</option>
      <option value="08">08</option>
      <option value="09">09</option>
      <option value="10">10</option>
      <option value="11">11</option>
      <option value="12">12</option>
      <option value="13">13</option>
      <option value="14">14</option>
      <option value="15">15</option>
      <option value="16">16</option>
      <option value="17">17</option>
      <option value="18">18</option>
      <option value="19">19</option>
      <option value="20">20</option>
      <option value="21">21</option>
      <option value="22">22</option>
      <option value="23">23</option>
      <option value="24">24</option>
      <option value="25">25</option>
      <option value="26">26</option>
      <option value="27">27</option>
     <option value="28">28</option>
     <xsl:if test="$day-max!='28'">
	      <option value="29">29</option>
	     <xsl:if test="$day-max!='29'">
		      <option value="30">30</option>
		     <xsl:if test="$day-max!='30'">
			      <option value="31">31</option>
		     </xsl:if>
	     </xsl:if>
     </xsl:if>
</xsl:template>   

<!-- Template for day select box option -->
<xsl:template name="dayofweek-options">
 <xsl:param name="label">N082_</xsl:param>
 	 <option value="MO">
        <xsl:value-of select="localization:getGTPString($language, concat($label,'MO'))"/>
     </option>
     <option value="TU">
       	<xsl:value-of select="localization:getGTPString($language, concat($label,'TU'))"/>
     </option>
     <option value="WE">
      	<xsl:value-of select="localization:getGTPString($language, concat($label,'WE'))"/>
     </option>
     <option value="TH">
      	<xsl:value-of select="localization:getGTPString($language, concat($label,'TH'))"/>
     </option>
     <option value="FR">
      	<xsl:value-of select="localization:getGTPString($language, concat($label,'FR'))"/>
     </option>
     <option value="SA">
      	<xsl:value-of select="localization:getGTPString($language, concat($label,'SA'))"/>
     </option>
     <option value="SU">
      	<xsl:value-of select="localization:getGTPString($language, concat($label,'SU'))"/>
     </option>
</xsl:template>    
  <!--
    A collection of checkbox fields. Combining these into a template allows us to control
    how it is displayed in view mode.
   -->
	<xd:doc>
		A collection of checkbox fields.
		<xd:param name="group-label">Localization key for label. <b>Mandatory</b></xd:param>
		<xd:param name="content">Raw HTML to display the checkboxes. <b>Mandatory</b></xd:param>
		<xd:param name="override-displaymode">Overridden display mode. Defaults to the display mode of the parent form</xd:param>
	</xd:doc>
  <xsl:template name="multioption-group">
   <!-- Required Parameters -->
   <xsl:param name="group-label"/>
   <xsl:param name="content"/>
   
   <!-- Optional -->
   <xsl:param name="override-displaymode" select="$displaymode"/>

   <!-- HTML -->
   <xsl:choose>
	    <xsl:when test="$override-displaymode='edit'">
		     <xsl:call-template name="label-wrapper">
			      <xsl:with-param name="label" select="$group-label"/>
			      <xsl:with-param name="label-class">multioption-group-label</xsl:with-param>
			      <xsl:with-param name="content">
			       		<xsl:copy-of select="$content"/>
			      </xsl:with-param>
		     </xsl:call-template>
	    </xsl:when>
	    <xsl:otherwise>
		     <xsl:call-template name="row-wrapper">
			      <xsl:with-param name="label" select="$group-label"/>
			      <xsl:with-param name="content">
			        	<xsl:copy-of select="$content"/>
			      </xsl:with-param>
		     </xsl:call-template>
	    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>

  <!--
   HTML Checkbox Field
   
   ** Notes **
    1. If no value is given for value, the value of the node with the same name
     as name is selected. Pass an empty string if you want no value.
    2. The id is given the same value as the name
    3. If checked, the label is displayed in the summary. If not checked, the unchecked-label
       is displayed (if there is one)
   ***********
   -->
	<xd:doc>
		<xd:short>HTML Checkbox Field</xd:short>
		<xd:detail>
  			If no value is given for value, the value of the node with the same name as name is selected. Pass an empty string if you want no value.
  			<br/>If checked, the label is displayed in the summary. If not checked, the <code>unchecked-label</code> is displayed (if there is one)
		</xd:detail>
		<xd:param name="name">Name of the field for form submission. <b>Mandatory</b></xd:param>
		<xd:param name="label">Localization key for label. <b>Mandatory</b></xd:param>
		<xd:param name="id">ID of the field. Defaults to the value of <code>name</code></xd:param>
		<xd:param name="value">Value of the field. Defaults to the value of the node matching the <code>name</code></xd:param>
		<xd:param name="checked">Whether checked by default. Defaults to N</xd:param>
		<xd:param name="required">Whether mandatory. Defaults to N</xd:param>
		<xd:param name="disabled">Whether disabled. Defaults to N</xd:param>
		<xd:param name="readonly">Whether readonly. Defaults to N</xd:param>
		<xd:param name="override-displaymode">Overridden display mode. Defaults to the display mode of the parent form.</xd:param>
		<xd:param name="unchecked-label">Localization key for label to display when the checkbox is not checked</xd:param>
		<xd:param name="checked-label">Only used by the products list in the system entity screen, since we can't use the standard localization to get the product name.</xd:param>
	</xd:doc>
  <xsl:template name="checkbox-field">
   <!-- Required Parameters -->
   <xsl:param name="name"/>
   <xsl:param name="label"/>
   
   <!-- Optional -->
   <xsl:param name="id" select="$name"/>
   <xsl:param name="value" select="//*[name()=$name]" />
   <xsl:param name="checked">N</xsl:param>
   <xsl:param name="required">N</xsl:param>
   <xsl:param name="disabled">N</xsl:param>
   <xsl:param name="readonly">N</xsl:param>
   <xsl:param name="override-displaymode" select="$displaymode"/>
   <xsl:param name="unchecked-label"/> <!-- Label to display when the checkbox is not checked -->
   
   <!-- 
    checked-label is only used by the products list in the system entity screen, since we can't use
    the standard localization to get the product name.
   -->
   <xsl:param name="checked-label"/> 

   <!-- HTML -->
   <xsl:call-template name="row-wrapper">
	    <xsl:with-param name="id" select="$name"/>
	    <xsl:with-param name="label"><xsl:if test="$override-displaymode = 'edit'"><xsl:value-of select="$label"/></xsl:if></xsl:with-param>
	    <xsl:with-param name="override-label" select="$checked-label"/>
	    <xsl:with-param name="type">checkbox</xsl:with-param>
	    <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
	    <xsl:with-param name="content">
	    <xsl:choose>
		      <xsl:when test="$override-displaymode='edit'">
			       <input type="checkbox" dojoType="dijit.form.CheckBox">
				        <!-- Required Attributes -->
				        <xsl:attribute name="name"><xsl:value-of select="$name"/></xsl:attribute>
				        <xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
				        
				        <!-- Others -->
				        <xsl:if test="$value='Y' or $checked='Y'">
				         	<xsl:attribute name="checked">checked</xsl:attribute>
				        </xsl:if>
				        <xsl:if test="$disabled='Y'">
				         	<xsl:attribute name="disabled">true</xsl:attribute>
				        </xsl:if>
				        <xsl:if test="$readonly='Y'">
				         	<xsl:attribute name="readOnly">true</xsl:attribute>
				        </xsl:if>
				        <xsl:if test="$required='Y'">
				         	<xsl:attribute name="required">true</xsl:attribute>
				        </xsl:if>
			       </input>
		      </xsl:when>
		      <xsl:otherwise>
			       <xsl:choose>
				         <xsl:when test="$value='Y' or $checked='Y'">
					          <div class="content">
					          	 <ul>
						          	<li>
							           <xsl:choose>
								            <xsl:when test="$checked-label!=''"><xsl:value-of select="$checked-label"/></xsl:when>
								            <!-- Add a space so the row label is shown -->
								            <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, $label)"/></xsl:otherwise>
							           </xsl:choose>
						          	</li>
					          	 </ul>
					          </div>
				         </xsl:when>
				         <xsl:when test="($value='N' or $checked='N') and $unchecked-label!=''">
					          <div class="content">
					           		<xsl:value-of select="localization:getGTPString($language, $unchecked-label)"/>
					          </div>
				         </xsl:when>
			        </xsl:choose> 
		      </xsl:otherwise>
	      </xsl:choose>
	    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>

   <!--
   HTML Radio Field.
   
   ** Notes **
   1. Radio fields in a group should share the same name, but have different IDs.
   ***********
   -->
	<xd:doc>
		<xd:short>HTML Radio Field.</xd:short>
		<xd:detail>
	  Radio fields in a group should share the same name, but have different IDs.
		</xd:detail>
		<xd:param name="name">Name of the field for form submission. <b>Mandatory</b></xd:param>
		<xd:param name="label">Localization key for label. <b>Mandatory</b></xd:param>
		<xd:param name="id">ID of the field. Defaults to the value of <code>name</code></xd:param>
		<xd:param name="value">Value of the field. Defaults to the value of the node matching the <code>name</code></xd:param>
		<xd:param name="checked">Whether checked by default. Defaults to N</xd:param>
		<xd:param name="required">Whether mandatory. Defaults to N</xd:param>
		<xd:param name="disabled">Whether disabled. Defaults to N</xd:param>
		<xd:param name="override-displaymode">Overridden display mode. Defaults to the display mode of the parent form.</xd:param>
		<xd:param name="content">Additional HTML to be displayed after the radio button</xd:param>
		<xd:param name="class">CSS class name</xd:param>
	</xd:doc>   
  <xsl:template name="radio-field">
   <!-- Required Parameters -->
   <xsl:param name="label"/>
   <xsl:param name="name"/>
   
   <!-- Optional -->
   <xsl:param name="id" select="$name"/>
   <xsl:param name="value"/>
   <xsl:param name="checked">N</xsl:param>
   <xsl:param name="required">N</xsl:param>
   <xsl:param name="disabled">N</xsl:param>
   <xsl:param name="override-displaymode" select="$displaymode"/>
   <xsl:param name="content"/>
   <xsl:param name="class"/>
   <xsl:param name="highlight">N</xsl:param>
   
   <!-- HTML -->
   <xsl:param name="radio-value" select="//*[name()=$name]"/>
   <xsl:call-template name="row-wrapper">
	      <xsl:with-param name="id" select="$id"/>
	      <xsl:with-param name="label"><xsl:if test="$override-displaymode = 'edit'"><xsl:value-of select="$label"/></xsl:if></xsl:with-param>
	      <xsl:with-param name="type">radio</xsl:with-param>
	      <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
	      <xsl:with-param name="content">
			   <xsl:choose>
				    <xsl:when test="$override-displaymode='edit'">
					       <input type="radio" dojoType="dijit.form.RadioButton">
						        <!-- Required Attributes. -->
						        <xsl:attribute name="name"><xsl:value-of select="$name"/></xsl:attribute>
						        <xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
						        <xsl:attribute name="value"><xsl:value-of select="$value"/></xsl:attribute>
						        <xsl:if test="($radio-value = $value) or $checked='Y'">
						         	<xsl:attribute name="checked">checked</xsl:attribute>
						        </xsl:if>
						        <xsl:if test="$disabled='Y'">
						         	<xsl:attribute name="disabled">true</xsl:attribute>
						        </xsl:if>
						        <xsl:if test="$required='Y'">
						         	<xsl:attribute name="required">true</xsl:attribute>
						        </xsl:if>
						        <xsl:if test="$class!=''">
						        	<xsl:attribute name="class"><xsl:value-of select="$class"/></xsl:attribute>
						        </xsl:if>
				       	   </input>
			    	</xsl:when>
			    	<xsl:otherwise>
					       <xsl:if test="$radio-value = $value">
						       <!-- <div class="content"> --> <!-- ajithkkb: extended to allow highlighting the amended -->
						       <div>
							        <xsl:choose>
							        	<xsl:when test="$highlight='Y'">
							        		<xsl:attribute name="class">contentAmendView highlight</xsl:attribute>
							        	</xsl:when>
							        	<xsl:otherwise>
							        		<xsl:attribute name="class">content</xsl:attribute>
							        	</xsl:otherwise>
							        </xsl:choose>
						       		<xsl:value-of select="localization:getGTPString($language, $label)"/>
						       </div>
					       </xsl:if>
			   		</xsl:otherwise>
		       </xsl:choose>
	      </xsl:with-param>
	      <!-- 
	       Sometimes we want to display additional HTML in the radio button space; it 
	       should be sent in this parameter
	       -->
	      <xsl:with-param name="additional-content">
	       	  <xsl:copy-of select="$content"/>
	      </xsl:with-param>
     </xsl:call-template>
    </xsl:template>
  
  <!--
   HTML Textarea.
   
   By default it creates a textarea with 15 rows and 65 cols and a phrase button.
   
   TODO Remove label stuff here, it should be controlled at row level
   -->
	<xd:doc>
		HTML Textarea.   
   		By default creates a textarea with 15 rows and 65 cols and a phrase button.
		<xd:param name="name">Name of the field for form submission. <b>Mandatory</b></xd:param>
		<xd:param name="label">Localization key for label. <b>Mandatory</b></xd:param>
		<xd:param name="id">ID of the field. Defaults to the value of <code>name</code></xd:param>
		<xd:param name="messageValue">Content of the textarea. Defaults to the value of the node matching the <code>name</code></xd:param>
		<xd:param name="rows">Number of rows in the textarea. Defaults to 15.</xd:param>
		<xd:param name="cols">Number of rows in the textarea. Defaults to 65.</xd:param>
		<xd:param name="maxlines">Maximum number of lines supported by the textarea. Defaults to 300</xd:param>
		<xd:param name="maxlength">Maximum number of characters, including line breaks and whitespaces</xd:param>
		<xd:param name="required">Whether mandatory. Defaults to N</xd:param>
		<xd:param name="disabled">Whether disabled. Defaults to N</xd:param>
		<xd:param name="class">CSS class name</xd:param>
		<xd:param name="swift-validate">Whether value is SWIFT validated. Defaults to Y</xd:param>
		<xd:param name="override-displaymode">Overridden display mode. Defaults to the display mode of the parent form.</xd:param>
		<xd:param name="button-type">Whether to add a popup search icon. Defaults to <code>phrase</code></xd:param>
		<xd:param name="phrase-params">Parameters for fetching available phrases, in JSON format. Defaults to <code>{}</code></xd:param>
	</xd:doc>   
  <xsl:template name="textarea-field">
   <!-- Required Parameters -->
   <xsl:param name="name"/>
   
   <!-- Optional -->
   <xsl:param name="label"/>
   <xsl:param name="id" select="$name"/>
   <xsl:param name="messageValue" select="//*[name()=$name]" />
   <xsl:param name="rows">15</xsl:param>
   <xsl:param name="cols">65</xsl:param>
   <xsl:param name="maxlines">300</xsl:param>
   <xsl:param name="maxlength"/>
   <xsl:param name="disabled">N</xsl:param>
   <xsl:param name="required">N</xsl:param>
   <xsl:param name="readonly">N</xsl:param>
   <xsl:param name="class"/>
   <xsl:param name="view-style"/>
   <xsl:param name="swift-validate">Y</xsl:param>
   <xsl:param name="override-displaymode" select="$displaymode"/>
   <xsl:param name="button-type">phrase</xsl:param> <!-- Whether to add a popup search icon. -->
   <xsl:param name="button-type-ext-view"></xsl:param> 
   <xsl:param name="phrase-params">{}</xsl:param>	
   <xsl:param name="word-wrap"/>
   <xsl:param name="override-value"/>
   <xsl:param name="show-label">Y</xsl:param>
   <xsl:param name="regular-expression"/>	
   
   
   <!-- HTML -->
   <xsl:choose>
    <xsl:when test="$override-displaymode='edit'">
     <div style="display:none">&nbsp;</div>
		<xsl:if test="$label">
			<!-- <div class="label"> -->
		<xsl:choose>
    		<xsl:when test="$show-label='N'" >
			<div hidden="true">
				<label>	
					<xsl:attribute name="for">
	       				<xsl:value-of select="$name"/>
	       			</xsl:attribute>
	       			<xsl:if test="$rundata!='' ">
					<xsl:call-template name="localization-dblclick">
						<xsl:with-param name="xslName" select="$label" />
						<xsl:with-param name="localName"
							select="localization:getGTPString($rundata,$language, $label)" />
					</xsl:call-template>
					</xsl:if>
					<xsl:choose>
						<xsl:when test="$rundata!='' ">
							<xsl:value-of
								select="localization:getGTPString($rundata,$language, $label)" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of
								select="localization:getGTPString($language, $label)" />
						</xsl:otherwise>
					</xsl:choose>&nbsp;
				</label>
			</div>
			</xsl:when>
			<xsl:otherwise>
				<label>	
					<xsl:attribute name="for">
	       				<xsl:value-of select="$name"/>
	       			</xsl:attribute>
	       			<xsl:if test="$rundata!='' ">
					<xsl:call-template name="localization-dblclick">
						<xsl:with-param name="xslName" select="$label" />
						<xsl:with-param name="localName"
							select="localization:getGTPString($rundata,$language, $label)" />
					</xsl:call-template>
					</xsl:if>
					<xsl:choose>
						<xsl:when test="$rundata!='' ">
							<xsl:value-of
								select="localization:getGTPString($rundata,$language, $label)" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:value-of
								select="localization:getGTPString($language, $label)" />
						</xsl:otherwise>
					</xsl:choose>&nbsp;
				</label>
			</xsl:otherwise>
			</xsl:choose>
			
		</xsl:if>

     <textarea dojoType="misys.form.SimpleTextarea">
      <xsl:attribute name="class">
      	<xsl:if test="$class != ''"><xsl:value-of select="$class"/></xsl:if>
      	<xsl:if test="$swift-validate='Y'"> swift</xsl:if>
      </xsl:attribute>
       <!-- override contraints -->
      <xsl:if test="$regular-expression != ''">
        <xsl:attribute name="regExp"><xsl:value-of select="$regular-expression" /></xsl:attribute>
      </xsl:if>
              
      <!-- Required Attributes -->
      <xsl:if test="$name != ''">
      	<xsl:attribute name="name"><xsl:value-of select="$name"/></xsl:attribute>
      </xsl:if>
      <xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
      <xsl:attribute name="rows"><xsl:value-of select="$rows"/></xsl:attribute>
      <xsl:attribute name="cols"><xsl:value-of select="$cols"/></xsl:attribute>
      <xsl:attribute name="maxSize"><xsl:value-of select="$maxlines"/></xsl:attribute>
      <xsl:attribute name="maxlength"><xsl:value-of select="$maxlength"/></xsl:attribute> 
      <xsl:if test="$disabled='Y'">
       <xsl:attribute name="disabled">true</xsl:attribute>
      </xsl:if>
      <xsl:if test="$required='Y'">
       <xsl:attribute name="required">true</xsl:attribute>
      </xsl:if>
      <xsl:if test="$readonly='Y'">
       <xsl:attribute name="readonly">true</xsl:attribute>
      </xsl:if>       
      <!-- Field value -->
      <xsl:value-of select="$messageValue"/>
     </textarea>
     <xsl:if test="$button-type!=''">
      <div class="textarea-button"> 
       <xsl:call-template name="get-button">
        <xsl:with-param name="button-type" select="$button-type"/>
        <xsl:with-param name="id" select="$id"/>
        <xsl:with-param name="phrase-params" select="$phrase-params" />
       </xsl:call-template>
      </div>
     </xsl:if> 
     <xsl:if test="$button-type-ext-view!=''">
      <div class="textarea-button"> 
       <xsl:call-template name="get-button">
        <xsl:with-param name="button-type" select="$button-type-ext-view"/>
        <xsl:with-param name="id" select="$id"/>
        <xsl:with-param name="messageValue" select="$messageValue"/>
        <xsl:with-param name="widget-name" select="$name"/>
       </xsl:call-template>
      </div>
     </xsl:if>     
    </xsl:when>
    <xsl:otherwise>
    	<xsl:variable name="message-value">     
	      <xsl:choose>
		      <xsl:when test="$override-value !=''">
		      	<xsl:value-of select="$override-value"/>
		      </xsl:when>
		      <xsl:otherwise>
		      	<xsl:value-of select="$messageValue"/>
		      </xsl:otherwise>
	      </xsl:choose>
		</xsl:variable>
		     
     <xsl:if test="$message-value!=''">
      <xsl:if test="$label">
       <div class="label">
       <xsl:choose>
 			<xsl:when test="$rundata!='' ">
 				<xsl:value-of select="localization:getGTPString($rundata,$language, $label)"/>
 			</xsl:when>
	   		<xsl:otherwise>
	   			<xsl:value-of select="localization:getGTPString($language, $label)"/>
	   		</xsl:otherwise>
	  	</xsl:choose>
       </div>
      </xsl:if>
      <xsl:if test="$word-wrap!='Y'">
      <div class="content textareacontent">
      	<xsl:attribute name="style">
      		<xsl:if test="$view-style != ''"><xsl:value-of select="$view-style"/></xsl:if>
      	</xsl:attribute>
		<xsl:call-template name="string_replace">
        	<xsl:with-param name="input_text" select="$message-value"/>
        </xsl:call-template>
      </div>
     </xsl:if>
     <xsl:if test="$word-wrap='Y'">
 	   <div class="content textareacontent textareawordwrap">
 	   <xsl:attribute name="style">
      		<xsl:if test="$view-style != ''"><xsl:value-of select="$view-style"/></xsl:if>
      	</xsl:attribute>
              <xsl:call-template name="string_replace">
              <xsl:with-param name="input_text" select="$message-value"/>
		      </xsl:call-template>
       </div>
	</xsl:if>
	</xsl:if>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
   
   <!--
    A rich text editing field. Note that the value is set via javascript (as below)
    -->
   <xsl:template name="richtextarea-field">
    <!-- Required Parameters -->
    <xsl:param name="name"/>
    
    <!-- Optional -->
    <xsl:param name="label"/> 
    <xsl:param name="id" select="$name"/>
    <xsl:param name="value" select="//*[name()=$name]" />
    <xsl:param name="rows">15</xsl:param>
    <xsl:param name="cols">65</xsl:param>
    <xsl:param name="maxlines">300</xsl:param>
    <xsl:param name="disabled">N</xsl:param>
    <xsl:param name="required">N</xsl:param>
    <xsl:param name="menu">Y</xsl:param>
    <xsl:param name="swift-validate">Y</xsl:param>
    <!-- This optional parameter defines the event used to instantiate the RTE editor as the editor can not be instantiated if its container is not displayed. -->
    <xsl:param name="instantiation-event"/>	
    
    <xsl:choose>
     <xsl:when test="$displaymode='edit'">
        <div>
         <xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
        </div>
        <div id="rteContent" style="display:none">
        	<xsl:value-of select="$value"/>
        	<xsl:if test="$value != ''">&nbsp;</xsl:if>
        </div>
     </xsl:when>
     <xsl:otherwise>
      <xsl:if test="$value!=''">
       <div class="content">
        <xsl:call-template name="string_replace">
         <xsl:with-param name="input_text" select="$value"/>
        </xsl:call-template>
       </div>
      </xsl:if>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:template>
  
  <!--  
   HTML Fieldset elements.
   
   Originally this produced a real <fieldset> but, due to performance issues on Internet Explorer
   and the consequent need to flatten the DOM, this template instead signifies a logical fieldset
   rather than an actual one.
  -->
  <xsl:template name="fieldset-wrapper">
   <!-- Required Parameters -->
  
   <!-- Optional -->
   <xsl:param name="legend"/>
   <xsl:param name="legend-id"/>
   <xsl:param name="legend-type">toplevel-header</xsl:param>
   <xsl:param name="button-type"/>
   <xsl:param name="override-displaymode" select="$displaymode"/>
   <xsl:param name="id"/>
   <xsl:param name="collapsible-prefix"/>
   <xsl:param name="messageValue"/>
   <xsl:param name="localized">Y</xsl:param>
   <xsl:param name="required">N</xsl:param>
   <xsl:param name="toc-item">Y</xsl:param>
   <xsl:param name="override-product-code"/>
   <!-- 
    Set to N to defer parsing, or if the form will already be parsed due to a parent node of class 'widgetContainer'
   -->
   <xsl:param name="parse-widgets">Y</xsl:param>
   
   <!-- Fieldset content -->
   <xsl:param name="content"/>
   <!-- HTML -->
   <xsl:if test="$content != ''">
    <xsl:variable name="legend-content">
      <xsl:choose>
        <xsl:when test="$localized='N' and $legend-id!=''">
          <span id="free_format_msg" class="legend"><xsl:value-of select="$legend"/></span>        
        </xsl:when>
        <xsl:when test="$localized='N' and $legend-id=''">
          <span class="legend"><xsl:value-of select="$legend"/></span>        
        </xsl:when>
        <xsl:when test="$localized!='N' and $legend-id!=''">
          <span id="free_format_msg" class="legend"><xsl:value-of select="localization:getGTPString($language, $legend, $rundata)"/></span>                
        </xsl:when>
        <xsl:otherwise>
          <span class="legend"><xsl:value-of select="localization:getGTPString($language, $legend, $rundata)"/></span>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:call-template name="get-button">
      	<xsl:with-param name="id" select="$id"/>
        <xsl:with-param name="button-type" select="$button-type"/>
        <xsl:with-param name="messageValue" select="$messageValue"/>
        <xsl:with-param name="label">XSL_ALT_BENEFICIARY</xsl:with-param>
        <xsl:with-param name="non-dijit-button">Y</xsl:with-param>
        <xsl:with-param name="override-product-code"><xsl:value-of select="$override-product-code"/></xsl:with-param>
        <xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="className"><xsl:if test="$parse-widgets='Y'">widgetContainer</xsl:if></xsl:variable>

    <div>
     <xsl:if test="$id != ''">
      <xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
     </xsl:if>
     <xsl:choose>
      <xsl:when test="$legend-type='toplevel-header'">
       <xsl:attribute name="class"><xsl:value-of select="$className"/> toplevel-header</xsl:attribute>
       <xsl:if test="$legend-content != ''">
        <h2>
        <span>
        <xsl:if test="$rundata!='' ">
         <xsl:call-template name="localization-dblclick">
					<xsl:with-param name="xslName" select="$legend" />
					<xsl:with-param name="localName">
				<xsl:choose>
				<xsl:when test="$localized='N'"><xsl:value-of select="$legend"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="localization:getGTPString($rundata,$language, $legend)"/></xsl:otherwise>
					</xsl:choose>
					</xsl:with-param>
							
		</xsl:call-template>
		</xsl:if>
         <xsl:if test="$toc-item = 'Y'"><xsl:attribute name="class">toc-item</xsl:attribute></xsl:if>
         <xsl:if test="$required = 'Y' and $override-displaymode = 'edit'">
          <span class="required-field-symbol"><xsl:value-of select="localization:getGTPString($language, 'REQUIRED_PREFIX')"/></span>
         </xsl:if>
         <xsl:copy-of select="$legend-content"/>
         </span>
        </h2>
       </xsl:if>
      </xsl:when>
      <xsl:when test="$legend-type='collapsible'">
      <xsl:attribute name="class"><xsl:value-of select="$className"/></xsl:attribute>
       <xsl:if test="$legend-content != ''">
		  	<div class="collapsible-header">
		  		<div class="collapsible-header-inner">
		  		<xsl:attribute name="id"><xsl:value-of select="$collapsible-prefix"/>_collapsible_header</xsl:attribute>
			  		<div>
			  			<span class="legend"><xsl:value-of select="$legend-content"/></span>
			  		</div>
			  		<div class="image">
				  		<img class="collapsible-img">
				  			<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($arrowRightImage)"/></xsl:attribute>
				  			<xsl:attribute name="id"><xsl:value-of select="$collapsible-prefix"/>_collapsible_img</xsl:attribute>
				  		</img>
			  		</div>
		  		</div>
		  	</div>	
       </xsl:if>
      </xsl:when>      
      <xsl:otherwise>
       <xsl:attribute name="class">indented-header</xsl:attribute>
        <xsl:if test="$legend-content != ''">
	        <h3>
	        <span>
	        <xsl:if test="$rundata!='' ">
        		<xsl:call-template name="localization-dblclick">
					<xsl:with-param name="xslName" select="$legend" />
					<xsl:with-param name="localName">
				<xsl:choose>
				<xsl:when test="$localized='N'"><xsl:value-of select="$legend"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="localization:getGTPString($rundata,$language, $legend)"/></xsl:otherwise>
					</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
	         <xsl:if test="$toc-item = 'Y'"><xsl:attribute name="class">toc-item</xsl:attribute></xsl:if>
	         <xsl:if test="$required = 'Y' and $override-displaymode = 'edit'">
              <span class="required-field-symbol"><xsl:value-of select="localization:getGTPString($language, 'REQUIRED_PREFIX')"/></span>
             </xsl:if>
	         <xsl:copy-of select="$legend-content"/>
	         </span>
	        </h3>
       </xsl:if>
      </xsl:otherwise>
     </xsl:choose>
     <div class="fieldset-content">
     	<xsl:if test="$collapsible-prefix != ''">
			<xsl:attribute name="id"><xsl:value-of select="$collapsible-prefix"/>_collapsible_content</xsl:attribute>
		</xsl:if>     	
     	<xsl:if test="$collapsible-prefix != ''">
			<xsl:attribute name="class">collapsible-left-margin</xsl:attribute>     	
		</xsl:if>
    	<xsl:copy-of select="$content"/>
     </div>
    </div>
   </xsl:if>
 </xsl:template>


 <!--
  An HTML Form
  
  *** Notes ***
  ** 1. Set validate to Y and the values of this form will be       ** 
  **    validated and collected for the XML.                        **
  -->
 <xsl:template name="form-wrapper">
  <!-- Required Parameters -->
  <xsl:param name="name"/>
  <xsl:param name="action"/>
 
  <!-- Optional -->
  <xsl:param name="id" select="$name"/>
  <xsl:param name="method">POST</xsl:param>
  <xsl:param name="enctype"/>
  <xsl:param name="onsubmit"/>
  <xsl:param name="content"/>
  <xsl:param name="validating">N</xsl:param>
  <!-- 
   Whether to parse the form (but not its children) on page load. Sometimes you
   don't want to do this e.g. for a form in a dialog, we want to parse the dialog
   content the very first time its loaded. If the form has already been parsed, we'll
   get an ID clash.
   
   Note: on page load, we instantiate all forms with the class .form
   -->
  <xsl:param name="parseFormOnLoad">Y</xsl:param> 
  
  <!-- HTML -->
  <div dojoType="dijit.form.Form">
	   <!-- Required attributes -->
	   <xsl:attribute name="name"><xsl:value-of select="$name"/></xsl:attribute>
	   <xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
	   <xsl:attribute name="action"><xsl:value-of select="$action"/></xsl:attribute>
	   <xsl:attribute name="class"><xsl:if test="$parseFormOnLoad = 'Y'">form</xsl:if><xsl:if test="$validating='Y'"> validate</xsl:if></xsl:attribute>
	   <!-- Optional Attributes -->
	   <xsl:if test="$method!=''">
	    	<xsl:attribute name="method"><xsl:value-of select="$method"/></xsl:attribute>
	   </xsl:if>
	   <xsl:if test="$enctype!=''">
	    	<xsl:attribute name="enctype"><xsl:value-of select="$enctype"/></xsl:attribute>
	   </xsl:if>
	   <xsl:if test="$onsubmit!=''">
	    	<xsl:attribute name="onsubmit"><xsl:value-of select="$onsubmit"/></xsl:attribute>
	   </xsl:if>
	   <xsl:copy-of select="$content"/>
  </div>
 </xsl:template>
 
<!--
 ########################################################################
 #2 - COMMON TEMPLATES
 
 Below, all templates commonly used across all pages that contain forms.
 ########################################################################
 -->
 
 <!--
  Common javascript imports for pages with forms (bank and customer side) 
  
   Javascript variables
     - tenor period
     - context paths and other vars
     - common dojo imports
     - dojo onloads and parser call 
  -->
 <xsl:template name="common-js-imports">
  <!-- Required Parameters -->
  <xsl:param name="binding"/>
   
  <!-- Optional -->
  <xsl:param name="override-product-code" select="$product-code"/>
  <xsl:param name="override-lowercase-product-code" select="$lowercase-product-code"/>
  <xsl:param name="override-action" select="$realform-action"/>
  <xsl:param name="override-help-access-key" select="$product-code"/>
  <xsl:param name="xml-tag-name"><xsl:value-of select="$override-lowercase-product-code"/>_tnx_record</xsl:param>
  <xsl:param name="show-collaboration-js">Y</xsl:param>
  <xsl:param name="show-period-js">N</xsl:param>
  
  <!-- HTML -->
  <!-- Message for js-disabled users. -->
  <noscript>
	   <div class="notice">
		    <img alt="Alert" title="Alert">
		     	<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($noticeImage)"/></xsl:attribute>
		    </img>
		    <p><xsl:value-of select="localization:getGTPString($language, 'NOSCRIPT_MSG')"/></p>
	   </div>
	   <style type="text/css">
	    /* Hide the preloader and form*/
	    #main-loading-message,
	    #edit
	    {
	        display:none;
	    }
	   </style>
  </noscript>
  
  <script>
   <xsl:variable name="help-language">
    <xsl:choose>
     <xsl:when test="$language = 'fr'">fr</xsl:when>
     <xsl:when test="$language = 'us'">us</xsl:when>
     <xsl:otherwise>en</xsl:otherwise>
    </xsl:choose>
   </xsl:variable>
   dojo.ready(function(){
   		<xsl:if test="$displaymode='edit'">
    	 <xsl:if test="$show-period-js='Y'"><xsl:call-template name="tenor-period-js"/></xsl:if>
  		</xsl:if>
  		
  		misys._config = misys._config || {};
    	dojo.mixin(misys._config, {
    	    disableFocusTrap:<xsl:value-of select="jetspeedresources:getString('portal.errorMsg.behaviour.allowCancel')"/>,
   	 		productCode: '<xsl:value-of select="$override-product-code"/>',
   	 		xmlTagName: '<xsl:value-of select="$xml-tag-name"/>',
   	 		homeUrl: '<xsl:value-of select="$override-action"/>',
   	 		onlineHelpUrl: misys.getServletURL('/screen/OnlineHelpScreen?helplanguage=<xsl:value-of select="$help-language"/>&amp;accesskey=<xsl:value-of select="$override-help-access-key"/>'),
   	 		requiredFieldPrefix: '<xsl:value-of select="localization:getGTPString($language, 'REQUIRED_PREFIX')"/>',
   	 		swift2018Enabled : <xsl:value-of select="defaultresource:isSwift2018Enabled()"/>,
   	 		licenseBeneficiaryEnabled : <xsl:value-of select="defaultresource:isLicenseBeneficiaryEnabled()"/>,
   	 		codeword_enabled : <xsl:value-of select="defaultresource:getResource('SWIFT_NARRATIVE_AMEND_ENABLE_CODEWORDS')"/>,
   	 		confirmationChargesEnabled : <xsl:value-of select="defaultresource:getResource('CONFIRMATION_CHARGES_ENABLED')"/>,
	 		opics_name_codeword : <xsl:value-of select="defaultresource:getResource('SWIFT_NAME_CODEWORD')"/>,
	 		opics_add1_codeword : <xsl:value-of select="defaultresource:getResource('SWIFT_ADD1_CODEWORD')"/>,
	 		opics_add2_codeword : <xsl:value-of select="defaultresource:getResource('SWIFT_ADD2_CODEWORD')"/>,
	 		opics_city_codeword : <xsl:value-of select="defaultresource:getResource('SWIFT_CITY_CODEWORD')"/>
    	});
   		<xsl:if test="$binding != ''"> <!-- and ($displaymode = 'edit' or ($displaymode = 'view' and $mode = 'UNSIGNED'))"-->
    		dojo.require("<xsl:value-of select="$binding"/>");
   		</xsl:if>
   });
  </script>
 </xsl:template>
 
 <!--
  Javascript for the tenor period strings, and LC javascript global variables.
  -->
 <xsl:template name="tenor-period-js">
  	misys._config = misys._config || {};
  	var periodLabels = misys._config.tenorPeriodLabels = [];
  	periodLabels[""] = "";
  	periodLabels["D"] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_DAYS')"/>";
  	periodLabels["W"] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_WEEKS')"/>";
  	periodLabels["M"] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_MONTHS')"/>";
  	periodLabels["Y"] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_YEARS')"/>";
  	
  	var fromAfterLabels = misys._config.tenorFromAfterLabels = [];
  	fromAfterLabels[""] = "";
  	fromAfterLabels["F"] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_FROM')"/>";
  	fromAfterLabels["A"] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_AFTER')"/>"; 
  	
  	var daysTypeLabels = misys._config.tenorDaysTypeLabels = [];
  	daysTypeLabels[""] = "";
  	daysTypeLabels["07"] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_TYPE_07')"/>";
  	daysTypeLabels["01"] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_TYPE_01')"/>";
  	daysTypeLabels["02"] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_TYPE_02')"/>";
  	daysTypeLabels["03"] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_TYPE_03')"/>";
  	daysTypeLabels["04"] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_TYPE_04')"/>";
  	daysTypeLabels["05"] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_TYPE_05')"/>";
  	daysTypeLabels["06"] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_TYPE_06')"/>";
  	daysTypeLabels["08"] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_TYPE_08')"/>";
  	daysTypeLabels["99"] = "<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_TYPE_99')"/>";

   	misys.setLocalization("tenorSight", "<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_SIGHT')"/>");
   	misys.setLocalization("tenorMaturityDate", "<xsl:value-of select="localization:getGTPString($language, 'MATURITY_DATE')"/>");
   	misys.setLocalization("tenorOtherDate", "<xsl:value-of select="localization:getGTPString($language, 'OTHER_DATE')"/>");
 </xsl:template>
 
 <!-- 
  A row in a form.
 
  Wraps a set of input elements, or their values, in appropriate tags
  to represent a form row.
  -->
 <xsl:template name="row-wrapper">
  <!-- Required parameters -->
  <xsl:param name="id"/>
  
  <!-- Optional -->
  <xsl:param name="label"/>
  <xsl:param name="type">text</xsl:param>
  <xsl:param name="required">N</xsl:param>
  <xsl:param name="appendClass"></xsl:param>
  <xsl:param name="content"/>
  <xsl:param name="override-displaymode" select="$displaymode"/>
  <xsl:param name="additional-content"/> <!-- Content that should appear after the radio/check label -->

  <!-- 
    override-label is only used by the products list in the system entity screen, since we can't use
    the standard localization to get the product name.
   -->
  <xsl:param name="override-label"/> 
  <xsl:param name="force-label">N</xsl:param>
  <xsl:param name="hide-label">N</xsl:param>
  
  <!-- Only display the row when there is content to show -->
  <xsl:choose>
  <xsl:when  test="($override-displaymode='edit') or ($override-displaymode='view' and $content!='')">
   <div>
   <xsl:if test="$rundata!='' ">
   <xsl:call-template name="localization-dblclick">
					<xsl:with-param name="xslName" select="$label" />
					<xsl:with-param name="localName" select="localization:getGTPString($rundata, $language, $label)" />
	</xsl:call-template>
	</xsl:if>
    <xsl:if test="$id != ''">
     <xsl:attribute name="id"><xsl:value-of select="$id"/>_row</xsl:attribute>
    </xsl:if>
    <xsl:attribute name="class">
     <xsl:choose>
      <xsl:when test="$type='checkbox'">field checkbox <xsl:value-of select="$appendClass"/></xsl:when>
      <xsl:when test="$type='radio'">field radio <xsl:value-of select="$appendClass"/></xsl:when>
      <xsl:when test="$type='textarea'">field textarea <xsl:value-of select="$appendClass"/></xsl:when>
      <xsl:when test="$type='noprint'">field noprint <xsl:value-of select="$appendClass"/></xsl:when>
      <xsl:otherwise>field <xsl:value-of select="$appendClass"/></xsl:otherwise>
     </xsl:choose>
     <xsl:if test="$required='Y'"> required</xsl:if>
    </xsl:attribute>
    <xsl:choose>
     <xsl:when test="$override-displaymode='edit'">
     <xsl:if test="($type!='textarea' or ($type='textarea' and ($override-label!='' or $label!=''))) and $hide-label != 'Y'">
       <label>
        <xsl:attribute name="for"><xsl:value-of select="$id"/></xsl:attribute>
        <xsl:if test="$type='checkbox' or $type='radio'">
         <xsl:copy-of select="$content"/>
        </xsl:if>
        <xsl:if test="$required='Y'">
         <span class="required-field-symbol"><xsl:value-of select="localization:getGTPString($language, 'REQUIRED_PREFIX')"/></span>
        </xsl:if>
        <xsl:choose>
         <xsl:when test="$override-label='' and $label!=''">
         	<xsl:choose>
         		<xsl:when test="$rundata!='' ">
         			<xsl:value-of select="localization:getGTPString($rundata, $language, $label)"/>
         		</xsl:when>
         		<xsl:otherwise>
         			<xsl:value-of select="localization:getGTPString($language, $label)"/>
         		</xsl:otherwise>
         	</xsl:choose>&nbsp;</xsl:when>
         <xsl:otherwise><xsl:value-of select="$override-label"/>&nbsp;</xsl:otherwise>
        </xsl:choose>
        <xsl:if test="$type='checkbox' or $type='radio'">
         <xsl:copy-of select="$additional-content"/>
        </xsl:if>
       </label>
      </xsl:if>
      <xsl:if test="$type!='checkbox' and $type!='radio'">
       <xsl:copy-of select="$content"/>
      </xsl:if>
      </xsl:when>
     <xsl:otherwise>
      <span class="label">
       <xsl:choose>
         <xsl:when test="$override-label='' and $label!=''">
         	<xsl:choose>
         		<xsl:when test="$rundata!='' ">
         			<xsl:value-of select="localization:getGTPString($rundata, $language, $label)"/>
         		</xsl:when>
         		<xsl:otherwise>
         			<xsl:value-of select="localization:getGTPString($language, $label)"/>
         		</xsl:otherwise>
         	</xsl:choose>&nbsp;</xsl:when>
         <xsl:otherwise><xsl:value-of select="$override-label"/>&nbsp;</xsl:otherwise>
        </xsl:choose></span>
      <xsl:copy-of select="$content"/>
     </xsl:otherwise>
    </xsl:choose>
   </div>
   </xsl:when>
  <xsl:when test="$force-label='Y'">
  	 <div>
    <xsl:if test="$id != ''">
     <xsl:attribute name="id"><xsl:value-of select="$id"/>_row</xsl:attribute>
    </xsl:if>
    <xsl:attribute name="class">
      field <xsl:value-of select="$appendClass"/>
     </xsl:attribute>
      <span class="label">
       <xsl:choose>
         <xsl:when test="$override-label='' and $label!=''">
         <xsl:choose>
         		<xsl:when test="$rundata!= '' ">
         			<xsl:value-of select="localization:getGTPString($rundata, $language, $label)"/>
         		</xsl:when>
         		<xsl:otherwise>
         			<xsl:value-of select="localization:getGTPString($language, $label)"/>
         		</xsl:otherwise>
         	</xsl:choose>&nbsp;</xsl:when>
         <xsl:otherwise><xsl:value-of select="$override-label"/>&nbsp;</xsl:otherwise>
        </xsl:choose></span>
      <xsl:copy-of select="$content"/>
   </div>
  </xsl:when>
  </xsl:choose>
 </xsl:template>
 
 <!--
    Collection of Address Fields
    i.e.
    1. Entity (optional)
    2. Address Line 1
    3. Address Line 2
    4. Address DOM
    5. Reference (optional) 
   -->
   <xd:doc>
		<xd:short>Address Field.</xd:short>
		<xd:detail>
		The address would be shown based on the applicant, benificary etc.
		It shows all the address related input fields.
		    
		  <br/>Renders the following types
		  <ul>
		  	<li>Input field</li>
		  	<li>Currency input field</li>
		  	<li>Entity field</li>
		  </ul>
		</xd:detail>
		<xd:param name="label">Localization key for the label</xd:param>
		<xd:param name="name-label">Label used for name field</xd:param>
		<xd:param name="prefix">
			prefix string to create the address fields.
			<ul>
				<li>applicant - applicant address</li>		  
				<li>drawer - drawer address</li>
				<li>borrower - borrower address</li>
				<li>buyer - buyer address</li>
				<li>seller - seller address</li>
			</ul>
		</xd:param>
		<xd:param name="value">not used</xd:param>
		<xd:param name="show-entity">whether to show the entity or not </xd:param>
		<xd:param name="show-entity-button">whether to show the entity or not</xd:param>
		<xd:param name="entity-type">Entity type</xd:param>
		<xd:param name="show-reference">show the reference or not</xd:param>
		<xd:param name="show-abbv">show abbrevation or not</xd:param>
		<xd:param name="show-name">show name of the party</xd:param>
		<xd:param name="show-address">show the party address</xd:param>   
		<xd:param name="address-label">label</xd:param>   
		<xd:param name="show-country">show country field or not</xd:param>
		<xd:param name="country-label">label for country</xd:param>
		<xd:param name="show-contact-name">show contact name or not default N</xd:param>
		<xd:param name="show-contact-number">show contact number, default N</xd:param>
		<xd:param name="show-fax-number">show fax number, default N</xd:param>
		<xd:param name="show-email">show email </xd:param>
		<xd:param name="entity-required">entity required/not</xd:param>
		<xd:param name="required">required-address param depends on this required</xd:param>
		<xd:param name="required-address">whether address is required or not</xd:param>
		<xd:param name="readonly">readonly</xd:param>
		<xd:param name="address-readonly">address readonly, default N</xd:param>
		<xd:param name="disabled">diabled address, default N</xd:param>
		<xd:param name="button-content">button content</xd:param>
		<xd:param name="contact-name-length">contact name length</xd:param>
		<xd:param name="contact-number-length">contact number length</xd:param>
		<xd:param name="beneficiary-reference">beneficiary reference</xd:param>
		<xd:param name="max-size">max size for the party reference</xd:param>
		<xd:param name="reg-exp">reg expression for the party reference</xd:param>	
	</xd:doc>
	
  <xsl:template name="address">
   <!-- Required parameters -->
 
  
   <!-- Optional -->
   <xsl:param name="label"/>
   <xsl:param name="name-label">XSL_PARTIESDETAILS_NAME</xsl:param> <!-- Label used for name field -->
   
   <!-- Field details. -->
   <xsl:param name="prefix"/>  <!-- applicant, beneficary, etc -->
   <xsl:param name="value"/>
   <xsl:param name="show-entity">N</xsl:param>
    <xsl:param name="show-button">N</xsl:param>
   <xsl:param name="show-entity-button">Y</xsl:param>
   <xsl:param name="entity-type">entity</xsl:param>
   <xsl:param name="show-reference">N</xsl:param>
   <xsl:param name="show-abbv">N</xsl:param>
   <xsl:param name="show-name">Y</xsl:param>
   <xsl:param name="show-address">Y</xsl:param>   
   <xsl:param name="address-label">XSL_PARTIESDETAILS_ADDRESS</xsl:param>   
   <xsl:param name="show-country">N</xsl:param>
   <xsl:param name="country-label">XSL_PARTIESDETAILS_CONTRY</xsl:param>
   <xsl:param name="show-contact-name">N</xsl:param>
   <xsl:param name="show-contact-number">N</xsl:param>
   <xsl:param name="show-fax-number">N</xsl:param>
   <xsl:param name="show-email">N</xsl:param>
   <xsl:param name="entity-required">Y</xsl:param>
   <xsl:param name="required">Y</xsl:param>
   <xsl:param name="required-address" select="$required"/>
   <xsl:param name="readonly">N</xsl:param>
   <xsl:param name="address-readonly">Y</xsl:param>
   <xsl:param name="disabled">N</xsl:param>
   <xsl:param name="button-content"/>
   <xsl:param name="search-button-type"/>
   <xsl:param name="contact-name-length">35</xsl:param>
   <xsl:param name="contact-number-length">35</xsl:param>
   <xsl:param name="beneficiary-reference">N</xsl:param>
   <xsl:param name="max-size"/>
   <xsl:param name="reg-exp"/>
   <xsl:param name="required-country" select="$required"/>
   <!-- Displaymode can be overridden -->
   <xsl:param name="override-displaymode" select="$displaymode"/>

   <!-- Entity Field. -->
   <xsl:if test="$show-entity='Y'">
	    <xsl:call-template name="entity-field">
		     <xsl:with-param name="required" select="$entity-required"/>
		     <xsl:with-param name="prefix" select="$prefix"/>
		     <xsl:with-param name="button-type">
			      <xsl:choose>
				       <xsl:when test="$show-entity-button='Y' and $search-button-type!=''"><xsl:value-of select="$search-button-type"/></xsl:when>
				       <xsl:otherwise><xsl:value-of select="$entity-type"/></xsl:otherwise>
			      </xsl:choose>
		     </xsl:with-param>
	    </xsl:call-template>
	    <xsl:if test="$button-content"><xsl:copy-of select="$button-content"/></xsl:if>
   </xsl:if>
   
   <!-- Abbv Field. -->
   <xsl:if test="$show-abbv='Y'">
	    <xsl:call-template name="input-field">
		     <xsl:with-param name="label">XSL_PARTIESDETAILS_ABBV_NAME</xsl:with-param>
		     <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_abbv_name</xsl:with-param>
		     <xsl:with-param name="readonly" select="$readonly"/>
		     <xsl:with-param name="disabled" select="$disabled"/>
		     <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
		     <xsl:with-param name="required" select="$required"/>
	    </xsl:call-template>
	    <xsl:if test="$button-content and $show-entity!='Y'"><xsl:copy-of select="$button-content"/></xsl:if>
   </xsl:if>
   
   <!-- Name. -->
   <xsl:if test="$show-name='Y'">
   	<xsl:choose>
     <xsl:when test="(($prefix='applicant' or $prefix='drawer' or $prefix='borrower'or $prefix='buyer') and security:isCustomer($rundata)) or (($prefix='beneficiary' or $prefix='applicant' or $prefix='drawee' or $prefix='borrower' or $prefix='buyer') and $readonly ='Y')">
      	<xsl:call-template name="input-field">
		     <xsl:with-param name="label" select="$name-label"/>
		     <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_name</xsl:with-param>
		     <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
		     <xsl:with-param name="required" select="$required"/>
		     <xsl:with-param name="readonly" select="$readonly"/>
		     <xsl:with-param name="disabled" select="$disabled"/>
		     <xsl:with-param name="maxsize">
		     	<xsl:choose>
					<xsl:when test="product_code [.='BG' or .='BR' or .='EC' or .='EL' or .='IC' or .='LC' or .='SG' or .='SI' or .='SR']"><xsl:value-of select="defaultresource:getResource('NAME_TRADE_LENGTH')"/></xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="defaultresource:getResource('MAXIMUM_ALLOWED_COMP_NAME')"/>
					</xsl:otherwise>
				</xsl:choose>
		     </xsl:with-param>
	    </xsl:call-template>
	  </xsl:when>
	  	<xsl:when test="$prefix='alt_applicant' and $show-button='N'">
	  		<xsl:call-template name="input-field">
			     <xsl:with-param name="label" select="$name-label"/>
			     <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_name</xsl:with-param>
			     <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
			     <xsl:with-param name="required" select="$required"/>
			     <xsl:with-param name="readonly" select="$readonly"/>
			     <xsl:with-param name="disabled" select="$disabled"/>
			     <xsl:with-param name="maxsize">
		     				<xsl:choose>
								<xsl:when test="product_code [.='BG' or .='BR' or .='EC' or .='EL' or .='IC' or .='LC' or .='SG' or .='SI' or .='SR']"><xsl:value-of select="defaultresource:getResource('NAME_TRADE_LENGTH')"/></xsl:when>
								<xsl:otherwise>35</xsl:otherwise>
							</xsl:choose>
		     			 </xsl:with-param>
			</xsl:call-template>
	  	</xsl:when>
	  	<xsl:otherwise>
	          	<xsl:if test="$show-button='Y'">
	      			<xsl:call-template name="input-field">
	                     <xsl:with-param name="label" select="$name-label"/>
	                     <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_name</xsl:with-param>
	                     <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
	                     <xsl:with-param name="required" select="$required"/>
	                     <xsl:with-param name="readonly" select="$readonly"/>
	                     <xsl:with-param name="disabled" select="$disabled"/>
	                     <xsl:with-param name="maxsize">
		     				<xsl:choose>
								<xsl:when test="product_code [.='BG' or .='BR' or .='EC' or .='EL' or .='IC' or .='LC' or .='SG' or .='SI' or .='SR']"><xsl:value-of select="defaultresource:getResource('NAME_TRADE_LENGTH')"/></xsl:when>
								<xsl:otherwise>35</xsl:otherwise>
							</xsl:choose>
		     			 </xsl:with-param>
	                     <xsl:with-param name="button-type"><xsl:value-of select="$prefix"/></xsl:with-param>
	            	</xsl:call-template>
	           	</xsl:if>
		    	<xsl:if test="$show-button='N'">
		    		<xsl:call-template name="input-field">
					     <xsl:with-param name="label" select="$name-label"/>
					     <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_name</xsl:with-param>
					     <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
					     <xsl:with-param name="required" select="$required"/>
					     <xsl:with-param name="readonly" select="$readonly"/>
					     <xsl:with-param name="disabled" select="$disabled"/>
					     <xsl:with-param name="maxsize">
		     				<xsl:choose>
								<xsl:when test="product_code [.='BG' or .='BR' or .='EC' or .='EL' or .='IC' or .='LC' or .='SG' or .='SI' or .='SR']"><xsl:value-of select="defaultresource:getResource('NAME_TRADE_LENGTH')"/></xsl:when>
								<xsl:otherwise>35</xsl:otherwise>
							</xsl:choose>
		     			 </xsl:with-param>
			    	</xsl:call-template>
				</xsl:if>
	      </xsl:otherwise>
	</xsl:choose>
	<xsl:if test="$button-content  and $show-entity!='Y' and $show-abbv!='Y'"><xsl:copy-of select="$button-content"/></xsl:if>
	<xsl:if test="product_code [.='FT'] and $prefix='counterparty'">
		<xsl:call-template name="beneficiary-nickname-field-template"/>
	</xsl:if>
  </xsl:if>
   <script>
		dojo.ready(function()
			{
				misys._config = misys._config || {};
				misys._config.swiftRelatedSections = misys._config.swiftRelatedSections || [];
				misys._config.swiftRelatedSections.push('<xsl:value-of select="$prefix"/>');
			});
   </script>
   
   <!-- Address Lines -->
   <xsl:if test="$show-address='Y'">
	   <xsl:call-template name="input-field">
		    <xsl:with-param name="label"><xsl:value-of select="$address-label"/></xsl:with-param>
		    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_address_line_1</xsl:with-param>
		    <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
		   	<xsl:with-param name="required" select="$required-address" />
		    <xsl:with-param name="readonly">
		    	<xsl:choose>
				    <xsl:when test="$readonly = 'Y' and $address-readonly = 'Y'">Y</xsl:when>
				    <xsl:otherwise>N</xsl:otherwise>
			    </xsl:choose>
		    </xsl:with-param>
		    <xsl:with-param name="disabled" select="$disabled"/>
		    <xsl:with-param name="maxsize">
			    <xsl:choose>
				    <xsl:when test="($product-code='BR' or $product-code='EC' or $product-code='EL' or $product-code='IC' or $product-code='LC' or $product-code='SG' or $product-code='SI' or $product-code='SR')">
						<xsl:value-of select="defaultresource:getResource('ADDRESS1_TRADE_LENGTH')"/>
					</xsl:when>
				    <xsl:when test="product_code [.='LS']">40</xsl:when>
				    <xsl:otherwise>35</xsl:otherwise>
			    </xsl:choose>
		    </xsl:with-param>
	   </xsl:call-template>
	   <xsl:call-template name="input-field">
		    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_address_line_2</xsl:with-param>
		    <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
		    <xsl:with-param name="readonly" >
		    	<xsl:choose>
				    <xsl:when test="$readonly = 'Y' and $address-readonly = 'Y'">Y</xsl:when>
				    <xsl:otherwise>N</xsl:otherwise>
			    </xsl:choose>
		    </xsl:with-param>
		    <xsl:with-param name="disabled" select="$disabled"/>
		     <xsl:with-param name="maxsize">
			    <xsl:choose>
				    <xsl:when test="($product-code='BR' or $product-code='EC' or $product-code='EL' or $product-code='IC' or $product-code='LC' or $product-code='SG' or $product-code='SI' or $product-code='SR')">
						<xsl:value-of select="defaultresource:getResource('ADDRESS2_TRADE_LENGTH')"/>
					</xsl:when>
				    <xsl:when test="product_code [.='LS']">40</xsl:when>
				    <xsl:otherwise>35</xsl:otherwise>
			    </xsl:choose>
		    </xsl:with-param>
	   </xsl:call-template>
	   <xsl:call-template name="input-field">
		    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_dom</xsl:with-param>
		    <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
		    <xsl:with-param name="readonly"> 
		    	<xsl:choose>
				    <xsl:when test="$readonly = 'Y' and $address-readonly = 'Y'">Y</xsl:when>
				    <xsl:otherwise>N</xsl:otherwise>
			    </xsl:choose>
		    </xsl:with-param>
		    <xsl:with-param name="disabled" select="$disabled"/>
		    <xsl:with-param name="maxsize">
			    <xsl:choose>
				    <xsl:when test="($product-code='BR' or $product-code='EC' or $product-code='EL' or $product-code='IC' or $product-code='LC' or $product-code='SG' or $product-code='SI' or $product-code='SR')">
						<xsl:value-of select="defaultresource:getResource('DOM_TRADE_LENGTH')"/>
					</xsl:when>
				    <xsl:when test="product_code [.='LS']">40</xsl:when>	
				    <xsl:otherwise>35</xsl:otherwise>
			    </xsl:choose>
			</xsl:with-param>
	   </xsl:call-template> 
	   <xsl:if test="product_code [.='BG' or .='BR' or .='EC' or .='EL' or .='IC' or .='LC' or .='SG' or .='SI' or .='SR']">
	   <xsl:call-template name="input-field">
		    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_address_line_4</xsl:with-param>
		    <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
		    <xsl:with-param name="readonly"> 
		    	<xsl:choose>
				    <xsl:when test="$readonly = 'Y' and $address-readonly = 'Y'">Y</xsl:when>
				    <xsl:otherwise>N</xsl:otherwise>
			    </xsl:choose>
		    </xsl:with-param>
		    <xsl:with-param name="disabled" select="$disabled"/>
		    <xsl:with-param name="maxsize">
			    <xsl:value-of select="defaultresource:getResource('ADDRESS4_TRADE_LENGTH')"/>
    		</xsl:with-param>
    		  <xsl:with-param name="swift-validate">N</xsl:with-param>
	   </xsl:call-template>
	   </xsl:if>
	    <script>
    		dojo.ready(function(){ 
			dojo.mixin(misys._config, {
				trade_total_combined_sizeallowed :'<xsl:value-of select="defaultresource:getResource('TRADE_TOTAL_COMBINED_SIZEALLOWED')"/>'
				});
			});   
		</script>
	   <xsl:if test="$beneficiary-reference='Y'">
	   <xsl:call-template name="hidden-field">
	        <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_reference</xsl:with-param>
	        </xsl:call-template>		
       </xsl:if>
   </xsl:if>
   <xsl:if test="$show-country='Y'">
   	<xsl:choose>
     <xsl:when test="$override-displaymode='edit'">
   		<xsl:call-template name="input-field">
	    	<xsl:with-param name="label"><xsl:value-of select="$country-label"/></xsl:with-param>
	    	<xsl:with-param name="name"><xsl:value-of select="$prefix"/>_country</xsl:with-param>
		    <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
    		<xsl:with-param name="disabled" select="$disabled"/>
	    	<xsl:with-param name="size">2</xsl:with-param>
	    	<xsl:with-param name="maxsize">2</xsl:with-param>
	    	<xsl:with-param name="readonly" select="$readonly"/>
    		<xsl:with-param name="fieldsize">xx-small</xsl:with-param>
    		<xsl:with-param name="uppercase">Y</xsl:with-param>
	    	<xsl:with-param name="prefix" select="$prefix"/>    
    		<xsl:with-param name="button-type">
    			<xsl:if test="$readonly = 'N'">codevalue</xsl:if>
    		</xsl:with-param>
		    <xsl:with-param name="required" select="$required"/>
   		</xsl:call-template>
   	  </xsl:when>
   	  <xsl:otherwise>
   	  	<xsl:variable name="name"><xsl:value-of select="$prefix"/>_country</xsl:variable>
   	  	<xsl:variable name="codeValue" select="//*[name()=$name]"/>
   	  	<xsl:call-template name="input-field">
	    	<xsl:with-param name="label"><xsl:value-of select="$country-label"/></xsl:with-param>
	    	<xsl:with-param name="name"><xsl:value-of select="$name"/></xsl:with-param>
	    	<xsl:with-param name="value" select="localization:getCodeData($language,'*','*','C006',$codeValue)"/>
	    	<xsl:with-param name="override-displaymode" select="$override-displaymode"/>
   		</xsl:call-template>
   	  </xsl:otherwise>
   	 </xsl:choose>
   	</xsl:if>
   
   <!-- Add a textfield for the country -->
   <!--  
   <xsl:call-template name="input-field">
   	<xsl:with-param name="label">XSL_PARTIESDETAILS_COUNTRY</xsl:with-param>
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_country</xsl:with-param>
    <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
    <xsl:with-param name="readonly">Y</xsl:with-param>
    <xsl:with-param name="disabled" select="$disabled"/>
    <xsl:with-param name="size">2</xsl:with-param>
    <xsl:with-param name="maxsize">2</xsl:with-param>
    <xsl:with-param name="fieldsize">x-small</xsl:with-param>
    <xsl:with-param name="uppercase">Y</xsl:with-param>
   	<xsl:with-param name="prefix" select="$prefix"/>
    <xsl:with-param name="button-type">codevalue</xsl:with-param>
   </xsl:call-template>
   -->
   
   <!--
    Reference
    -->
   <xsl:if test="$show-reference='Y'">
	   <xsl:choose>
	     <xsl:when test="$override-displaymode='edit'">
	     	 <xsl:variable name="maxSize">
		     	<xsl:choose>
		     		<xsl:when test="$max-size != ''"><xsl:value-of select="$max-size"/></xsl:when>
			     	<xsl:otherwise>34</xsl:otherwise>
		     	</xsl:choose>
		     </xsl:variable>
		     <xsl:variable name="regExp">
		     	<xsl:choose>
		     		<xsl:when test="$reg-exp != ''"><xsl:value-of select="$reg-exp"/></xsl:when>
			     	<xsl:otherwise></xsl:otherwise>
		     	</xsl:choose>
		     </xsl:variable>
		    <xsl:call-template name="input-field">
			     <xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
			     <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_reference</xsl:with-param>
			     <xsl:with-param name="size">20</xsl:with-param>
			     <xsl:with-param name="maxsize"><xsl:value-of select="$maxSize"/></xsl:with-param>
			     <!-- <xsl:with-param name="regular-expression"><xsl:value-of select="$regExp"/></xsl:with-param>  -->			     
			     <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
			     <xsl:with-param name="fieldsize">medium</xsl:with-param>
			     <xsl:with-param name="readonly" select="$readonly"/>
			     <xsl:with-param name="disabled" select="$disabled"/>
			     <xsl:with-param name="type">reference</xsl:with-param>
			     <xsl:with-param name="swift-validate">N</xsl:with-param>
			     <xsl:with-param name="value"> 
			     <xsl:choose>
						     <xsl:when test="$prefix = 'applicant'">
						        <xsl:value-of select="utils:decryptApplicantReference(applicant_reference)"/>
						     </xsl:when>  
						     <xsl:when test="$prefix = 'drawer'">
						        <xsl:value-of select="utils:decryptApplicantReference(drawer_reference)"/>
						     </xsl:when>  
						     <xsl:otherwise>  
						         <xsl:variable name="referenceValue"><xsl:value-of select="$prefix"/>_reference</xsl:variable> 
						        <xsl:value-of select="//*[name()=$referenceValue]"/>
						     </xsl:otherwise>
				</xsl:choose>		     
			    </xsl:with-param>
		    </xsl:call-template>
		    </xsl:when>
		    <xsl:otherwise>
		    	<xsl:variable name="name"><xsl:value-of select="$prefix"/>_reference</xsl:variable>
		        <xsl:variable name="ben_ref" select="//*[name()=$name]"/>
   	  			<xsl:call-template name="input-field">
		    		<xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
		    		<xsl:with-param name="name"><xsl:value-of select="$name"/></xsl:with-param>
		    		<xsl:with-param name="value"><xsl:value-of select="utils:decryptApplicantReference($ben_ref)"/></xsl:with-param>
	      		</xsl:call-template>
			  </xsl:otherwise>
	   </xsl:choose>
   </xsl:if>
   <xsl:if test="$show-contact-name='Y'">
	    <xsl:call-template name="input-field">
		     <xsl:with-param name="label">XSL_JURISDICTION_CONTACT_NAME</xsl:with-param>
		     <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_contact_name</xsl:with-param>
		     <xsl:with-param name="size">20</xsl:with-param>
		     <xsl:with-param name="maxsize" select="$contact-name-length"></xsl:with-param>
		     <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
		     <xsl:with-param name="fieldsize">medium</xsl:with-param>
		     <xsl:with-param name="readonly" select="$readonly"/>
		     <xsl:with-param name="disabled" select="$disabled"/>
	    </xsl:call-template>
   </xsl:if>
   
   <xsl:if test="$show-contact-number='Y'">
	    <xsl:call-template name="input-field">
		     <xsl:with-param name="label">XSL_BENEFICIARY_CONTACT_NUMBER</xsl:with-param>
		     <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_contact_number</xsl:with-param>
		     <xsl:with-param name="size">20</xsl:with-param>
		     <xsl:with-param name="maxsize" select="$contact-number-length"></xsl:with-param>
		     <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
		     <xsl:with-param name="fieldsize">medium</xsl:with-param>
		     <xsl:with-param name="readonly" select="$readonly"/>
		     <xsl:with-param name="disabled" select="$disabled"/>
	    </xsl:call-template>
   </xsl:if>
   
   <xsl:if test="$show-fax-number='Y'">
	    <xsl:call-template name="input-field">
		     <xsl:with-param name="label">XSL_DETAILS_PO_CONTACT_FAX_NUMBER</xsl:with-param>
		     <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_fax_num</xsl:with-param>
		     <xsl:with-param name="size">20</xsl:with-param>
		     <xsl:with-param name="maxsize">35</xsl:with-param>
		     <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
		     <xsl:with-param name="fieldsize">medium</xsl:with-param>
		     <xsl:with-param name="readonly" select="$readonly"/>
		     <xsl:with-param name="disabled" select="$disabled"/>
	    </xsl:call-template>
   </xsl:if>
   <!--  Client Specific FDS1.6 Changes -->
   <xsl:if test="$show-email='Y'">
	    <xsl:call-template name="input-field">
		     <xsl:with-param name="label">XSL_JURISDICTION_EMAIL</xsl:with-param>
		     <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_email</xsl:with-param>
		     <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
		     <xsl:with-param name="readonly" select="$readonly"/>
		     <xsl:with-param name="disabled" select="$disabled"/>
		     <xsl:with-param name="swift-validate">N</xsl:with-param>
	    </xsl:call-template>
   </xsl:if>
  </xsl:template>
  
  <!--
   Display entity field 
   
   If only one entity is given to the user, the entity is automatically selected
   Note: if current entity not setup, this means the init values hasn't been done, and we
   allow the selection of the entities
   -->
  <xsl:template name="entity-field">
   <!-- Optional -->
   <xsl:param name="entity-label">XSL_PARTIESDETAILS_ENTITY</xsl:param>
   <xsl:param name="popup-entity-prefix"></xsl:param>
   <xsl:param name="prefix"></xsl:param>
   <xsl:param name="button-type">entity</xsl:param> <!-- Can be entity or entity-basic -->
   <xsl:param name="required">Y</xsl:param>
   <xsl:param name="override-product-code" select="product_code"/>
   <xsl:param name="override-sub-product-code" select="sub_product_code"/>
   <xsl:param name="empty"/>
   <xsl:param name="keep-entity-product-button"/>
   <xsl:param name="override_company_abbv_name"></xsl:param>
   <xsl:param name="readonly">Y</xsl:param>
   
   <xsl:choose>
	  <xsl:when test="$empty='Y'">
	  	<xsl:call-template name="input-field">
		    <xsl:with-param name="label" select="$entity-label"/>
		    <xsl:with-param name="id"><xsl:value-of select="$popup-entity-prefix"/>entity</xsl:with-param>
		    <xsl:with-param name="name">entity</xsl:with-param>
		    <xsl:with-param name="required" select="$required"/>
		    <xsl:with-param name="readonly" select="$readonly"/>
		    <xsl:with-param name="button-type" select="$button-type"/>
		    <xsl:with-param name="override-product-code" select="$override-product-code"/>
		    <xsl:with-param name="override-sub-product-code" select="$override-sub-product-code"/>
		    <xsl:with-param name="prefix" select="$prefix"/>
		    <xsl:with-param name="value"></xsl:with-param>
		    <xsl:with-param name="keep-entity-product-button" select="$keep-entity-product-button"/>
		    <xsl:with-param name="override_company_abbv_name" select="$override_company_abbv_name" />
		    <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('ABBVNAME_ASTERISK_VALIDATION_REGEX')"/></xsl:with-param>
		 </xsl:call-template>
	  </xsl:when>
	  <xsl:otherwise>
		  <xsl:choose>
		   	<xsl:when test="entities[.= '0']"/>
		   	<xsl:when test="entities[.= '1'] and entity[. != '']">
		   	  <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">entity</xsl:with-param>
		      </xsl:call-template>
		      <xsl:call-template name="input-field">
		       <xsl:with-param name="label" select="$entity-label"/>
		       <xsl:with-param name="value" select="entity"/>
		       <xsl:with-param name="id">entity_view</xsl:with-param>
		       <xsl:with-param name="override-displaymode">view</xsl:with-param>
		       <xsl:with-param name="keep-entity-product-button" select="$keep-entity-product-button"/>
		       <xsl:with-param name="override_company_abbv_name" select="$override_company_abbv_name" />
		       <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('ABBVNAME_ASTERISK_VALIDATION_REGEX')"/></xsl:with-param>
		      </xsl:call-template>
		   	</xsl:when>
		   	<xsl:otherwise>
		   	 <xsl:call-template name="input-field">
		       <xsl:with-param name="label" select="$entity-label"/>
		       <xsl:with-param name="id"><xsl:value-of select="$popup-entity-prefix"/>entity</xsl:with-param>
		       <xsl:with-param name="name">entity</xsl:with-param>
		       <xsl:with-param name="required" select="$required"/>
		       <xsl:with-param name="readonly" select="$readonly"/>
		       <xsl:with-param name="button-type" select="$button-type"/>
		       <xsl:with-param name="override-product-code" select="$override-product-code"/>
		       <xsl:with-param name="override-sub-product-code" select="$override-sub-product-code"/>
		       <xsl:with-param name="prefix" select="$prefix"/>
		       <xsl:with-param name="keep-entity-product-button" select="$keep-entity-product-button"/>
		       <xsl:with-param name="override_company_abbv_name" select="$override_company_abbv_name" />
		       <xsl:with-param name="swift-validate">N</xsl:with-param>
		       <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('ABBVNAME_ASTERISK_VALIDATION_REGEX')"/></xsl:with-param>
		      </xsl:call-template>
		      <!-- In the Unsigned mode we need entity information for reauthentication -->
		      <xsl:if test="$displaymode='view'">
		      	<xsl:call-template name="hidden-field">
			       <xsl:with-param name="name">entity</xsl:with-param>
			    </xsl:call-template>
		      </xsl:if>
		   	</xsl:otherwise>
		   </xsl:choose>
	  </xsl:otherwise>
   </xsl:choose>
	   	
	   
	   
  </xsl:template>
  
 <!--
    Party details (derived from the TSU schema) 
    i.e.
    1. Entity (optional)
    2. Name
    3. BEI
    4. Street name
    5. Post code
    6. Town name
    7. Country Sub division
    8. Country
    9. Reference (optional) 
   -->
  <xsl:template name="party-details">
   <!-- Required parameters -->
  
   <!-- Optional -->
   <xsl:param name="label"/>
   <xsl:param name="name-label">XSL_PARTIESDETAILS_NAME</xsl:param> <!-- Label used for name field -->
   
   <!-- Field details. -->
   <xsl:param name="prefix"/>  <!-- applicant, beneficary, etc -->
   <xsl:param name="value"/>
   <xsl:param name="show-entity">N</xsl:param>
   <xsl:param name="show-entity-button">Y</xsl:param>
   <xsl:param name="entity-type">entity</xsl:param>
   <xsl:param name="show-reference">N</xsl:param>
   <xsl:param name="show-abbv">N</xsl:param>
   <xsl:param name="show-name">Y</xsl:param>
   <xsl:param name="show-program">N</xsl:param>
   <xsl:param name="show-program-dropdown-invoice">N</xsl:param>
   <xsl:param name="show-BEI">N</xsl:param>
   <xsl:param name="show-button">N</xsl:param>   <!-- add a button at field name to fill parties -->
   <xsl:param name="entity-required">Y</xsl:param>
   <xsl:param name="required">Y</xsl:param>
   <xsl:param name="readonly">N</xsl:param>
   <xsl:param name="disabled">N</xsl:param>
   <xsl:param name="show-country-icon">Y</xsl:param>
   <xsl:param name="show-bank-bic">N</xsl:param>   
   <xsl:param name="readonly-bank-bic">N</xsl:param>
   <xsl:param name="display-program">N</xsl:param>  
   
   <!-- Displaymode can be overridden -->
   <xsl:param name="override-displaymode" select="$displaymode"/>

   <!-- Entity Field. -->
   <xsl:if test="$show-entity='Y'">
	    <xsl:call-template name="entity-field">
		     <xsl:with-param name="required" select="$entity-required"/>
		     <xsl:with-param name="prefix" select="$prefix"/>
		     <xsl:with-param name="button-type">
			      <xsl:choose>
				       <xsl:when test="$show-entity-button='Y'"><xsl:value-of select="$entity-type"/></xsl:when>
				       <xsl:otherwise></xsl:otherwise>
			      </xsl:choose>
		     </xsl:with-param>
	    </xsl:call-template>
   </xsl:if>
   <!-- Abbv Field. -->
   <xsl:choose>
   <xsl:when test="$show-abbv='Y'">
	    <xsl:call-template name="input-field">
		     <xsl:with-param name="label">XSL_PARTIESDETAILS_ABBV_NAME</xsl:with-param>
		     <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_abbv_name</xsl:with-param>
		     <xsl:with-param name="readonly" select="$readonly"/>
		     <xsl:with-param name="disabled" select="$disabled"/>
		     <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
		     <xsl:with-param name="required" select="$required"/>
	    </xsl:call-template>
   </xsl:when>
   <xsl:otherwise>
   		<xsl:call-template name="hidden-field">
		     <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_abbv_name</xsl:with-param>
	    </xsl:call-template>
   </xsl:otherwise>
   </xsl:choose>
   
   <!-- Name. -->
   <xsl:if test="$show-name='Y'">
   <xsl:choose>
	   <xsl:when test="((($prefix='buyer' and ($product-code = 'PO' or $product-code = 'IP')) or ($prefix='seller' and ($product-code = 'IN' or $product-code = 'CN'))) and security:isCustomer($rundata))">
		  <xsl:call-template name="input-field">
		     <xsl:with-param name="label" select="$name-label"/>
		     <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_name</xsl:with-param>
		     <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
		     <xsl:with-param name="button-type"> <xsl:if test="$show-button='Y'"><xsl:value-of select="$prefix"/></xsl:if></xsl:with-param> <!-- Whether to add a popup search icon. -->
		     <xsl:with-param name="required" select="$required"/>
		     <xsl:with-param name="readonly" select="$readonly"/>
		     <xsl:with-param name="disabled" select="$disabled"/>
		     <xsl:with-param name="maxsize"><xsl:if test="$product-code ='IO' or $product-code ='PO'"><xsl:value-of select="defaultresource:getResource('MAXIMUM_ALLOWED_COMP_NAME')"/></xsl:if></xsl:with-param>
		  </xsl:call-template>
	   </xsl:when>
	   <xsl:otherwise>
		  <xsl:call-template name="input-field">
			 <xsl:with-param name="label" select="$name-label"/>
			 <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_name</xsl:with-param>
			 <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
			 <xsl:with-param name="button-type"> <xsl:if test="$show-button='Y'"><xsl:value-of select="$prefix"/></xsl:if></xsl:with-param> <!-- Whether to add a popup search icon. -->
			 <xsl:with-param name="required" select="$required"/>
			 <xsl:with-param name="readonly" select="$readonly"/>
			 <xsl:with-param name="disabled" select="$disabled"/>
			 <xsl:with-param name="maxsize">
		     	<xsl:choose>
					<xsl:when test="product_code [.='BG' or .='BR' or .='EC' or .='EL' or .='IC' or .='LC' or .='SG' or .='SI' or .='SR']"><xsl:value-of select="defaultresource:getResource('NAME_TRADE_LENGTH')"/></xsl:when>
					<xsl:otherwise>35</xsl:otherwise>
				</xsl:choose>
		     </xsl:with-param>
		  </xsl:call-template>
	   </xsl:otherwise>
   </xsl:choose>
   </xsl:if>
   <script>
		dojo.ready(function()
			{
				if(misys._config.swiftRelatedSection !== undefined)
				{
					misys._config.swiftRelatedSections.push('<xsl:value-of select="$prefix"/>');
				}
			});
   </script>
   
   <!-- PROGRAM -->
   	<xsl:if test="security:isCounterparty($rundata)">
    <xsl:if test="$show-program-dropdown-invoice='Y' and ($prefix='seller' or $prefix='buyer')">
    <xsl:call-template name="select-field">
	      <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_PROGRAM</xsl:with-param>
	      <xsl:with-param name="name">fscm_programme_code</xsl:with-param>
	      <xsl:with-param name="required">Y</xsl:with-param>
	      <xsl:with-param name="options">
	       <xsl:choose>
		    <xsl:when test="$displaymode='edit'">
		    <xsl:for-each select="fscmProgcode/value">
		    	<xsl:if test="self::node()[text()= '03']">
			   <option value="03">
			    <xsl:value-of select="localization:getDecode($language, 'N084', '03')"/>
			   </option>
			   </xsl:if>
			   <xsl:if test="self::node()[text()= '05']">
			   <option value="05">
			    <xsl:value-of select="localization:getDecode($language, 'N084', '05')"/>
			   </option>
			   </xsl:if>
			   </xsl:for-each>
		    </xsl:when>
		    <xsl:otherwise>
		     <xsl:choose>
	          <xsl:when test="fscm_programme_code[.='03']"><xsl:value-of select="localization:getDecode($language, 'N084', '03')"/></xsl:when>
	          <xsl:when test="fscm_programme_code[.='05']"><xsl:value-of select="localization:getDecode($language, 'N084', '05')"/></xsl:when>
	         </xsl:choose>
		    </xsl:otherwise>
		   </xsl:choose>	   
	      </xsl:with-param>
	     </xsl:call-template>
     </xsl:if>
     </xsl:if>
      <!-- PROGRAM -->
   
     <xsl:if test="$show-program='Y' and ($prefix='seller' or $prefix='buyer')">
	     <xsl:variable name = "fscm_programme_code"> 
       			<xsl:value-of select="fscm_programme_code"/>
       	 </xsl:variable>
		<xsl:choose>
			<xsl:when test="$displaymode='edit'">
				<xsl:call-template name="select-field">
		      	   <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_PROGRAM</xsl:with-param>
			       <xsl:with-param name="name">fscm_programme_code</xsl:with-param>
			       <xsl:with-param name="fieldsize">medium</xsl:with-param>
			       <xsl:with-param name="required">Y</xsl:with-param>
			       <xsl:with-param name="options"> 
				       <xsl:if test = "$fscm_programme_code!=''">
				       		<xsl:element name="option">
								<xsl:attribute name="value">
									<xsl:value-of select="fscm_programme_code"/>
								</xsl:attribute>
								<xsl:attribute name="selected">selected</xsl:attribute>
								<xsl:value-of
									select="localization:getDecode($language, 'N084',$fscm_programme_code )" />
							</xsl:element>
				       </xsl:if>
			       </xsl:with-param>
		      </xsl:call-template>
		  </xsl:when>
		  <xsl:otherwise>
				<xsl:if test = "$fscm_programme_code!=''">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_PO_PARTIESDETAILS_PROGRAM</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of
										select="localization:getDecode($language, 'N084',$fscm_programme_code )"/></xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
   </xsl:if>   
   
   <!-- BEI -->
   <xsl:if test="$show-BEI='Y'">
	    <xsl:call-template name="input-field">
		     <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_BEI</xsl:with-param>
		     <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_bei</xsl:with-param>
		     <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
		     <xsl:with-param name="readonly" select="$readonly"/>
		     <xsl:with-param name="disabled" select="$disabled"/>
		     <xsl:with-param name="size">11</xsl:with-param>
		     <xsl:with-param name="maxsize">11</xsl:with-param>
		     <xsl:with-param name="fieldsize">small</xsl:with-param>
	    </xsl:call-template>
   </xsl:if>


   <!-- Address Lines -->
   <xsl:call-template name="input-field">
	    <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_STREET</xsl:with-param>
	    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_street_name</xsl:with-param>
	    <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
	    <xsl:with-param name="readonly" select="$readonly"/>
	    <xsl:with-param name="disabled" select="$disabled"/>
	    <xsl:with-param name="maxsize"><xsl:if test="$product-code ='IO' or $product-code ='PO' or $product-code ='IN' or $product-code ='IP'">70</xsl:if></xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="input-field">
	    <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_TOWN</xsl:with-param>
	    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_town_name</xsl:with-param>
	    <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
	    <xsl:with-param name="readonly" select="$readonly"/>
	    <xsl:with-param name="disabled" select="$disabled"/>
	    <xsl:with-param name="maxsize">35</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="input-field">
	    <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION</xsl:with-param>
	    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_country_sub_div</xsl:with-param>
	    <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
	    <xsl:with-param name="readonly" select="$readonly"/>
	    <xsl:with-param name="disabled" select="$disabled"/>
	    <xsl:with-param name="maxsize">35</xsl:with-param>
   </xsl:call-template>
    <xsl:call-template name="input-field">
	    <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_POST_CODE</xsl:with-param>
	    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_post_code</xsl:with-param>
	    <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
	    <xsl:with-param name="readonly" select="$readonly"/>
	    <xsl:with-param name="disabled" select="$disabled"/>
	    <xsl:with-param name="size">16</xsl:with-param>
		<xsl:with-param name="maxsize">16</xsl:with-param>
	    <xsl:with-param name="fieldsize">small</xsl:with-param>
   </xsl:call-template>
   
   <xsl:call-template name="country-field">
	    <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_COUNTRY</xsl:with-param>
	    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_country</xsl:with-param>
	    <xsl:with-param name="readonly" select="$readonly"/>
	    <xsl:with-param name="disabled" select="$disabled"/>
	    <xsl:with-param name="prefix" select="$prefix"/>
	    <xsl:with-param name="required" select="$required"/>
	    <xsl:with-param name="show-search-icon">
	    <xsl:choose>
	    	<xsl:when test="$show-country-icon='N'">N</xsl:when>
	    	<xsl:otherwise>Y</xsl:otherwise>
	    </xsl:choose>
	    </xsl:with-param> 
  </xsl:call-template>
  
   <!-- BANK BIC -->
   <xsl:if test="$show-bank-bic='Y'">
	    <xsl:call-template name="input-field">
		     <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_SELLER_BANK_BIC</xsl:with-param>
		     <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_bank_bic</xsl:with-param>
		     <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
		     <xsl:with-param name="readonly" select="$readonly-bank-bic"/>
		     <xsl:with-param name="disabled" select="$disabled"/>
		     <xsl:with-param name="required">Y</xsl:with-param>
		     <xsl:with-param name="size">11</xsl:with-param>
		     <xsl:with-param name="maxsize">11</xsl:with-param>
		     <xsl:with-param name="fieldsize">small</xsl:with-param>
	    </xsl:call-template>
   </xsl:if>
   
   <!--
    Reference
    -->
   <xsl:if test="$show-reference='Y'">
	    <xsl:call-template name="input-field">
		     <xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
		     <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_reference</xsl:with-param>
		     <xsl:with-param name="size">20</xsl:with-param>
		     <xsl:with-param name="maxsize">64</xsl:with-param>
		     <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
		     <xsl:with-param name="fieldsize">small</xsl:with-param>
		     <xsl:with-param name="readonly" select="$readonly"/>
		     <xsl:with-param name="disabled" select="$disabled"/>
	    </xsl:call-template>
   </xsl:if>
   <xsl:if test="($product-code='CN' and $prefix='seller') or ($product-code='CR' and $prefix='buyer')or ($product-code='IN' and $prefix='buyer') or ($product-code='IP' and $prefix='seller')">
   <xsl:call-template name="hidden-field">
		<xsl:with-param name="id">access_opened</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="access_opened"/></xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="id">transaction_counterparty_email</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="transaction_counterparty_email"/></xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="id">ben_company_abbv_name</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="ben_company_abbv_name"/></xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="id">productCode</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="$product-code"/></xsl:with-param>
	</xsl:call-template>
	</xsl:if>
  </xsl:template>
  

  <!--  
   Common menu buttons (view and edit mode) used across all products.
  
   Save, Submit, Template, Cancel, Help. 
   
   Note that the CSS classes referenced below are needed for event handling
  -->
  
  <xd:doc>
  	<xd:short>Menu field(save,Submit,cancel,help etc) for all transactions</xd:short>
  	<xd:detail>
	Menu field(save,Submit,cancel,help etc) for all transactions
  	</xd:detail>
  	<xd:param name="show-submit">Shows Submit button in transaction</xd:param>
  	<xd:param name="show-save">Shows Save button in transaction</xd:param>
  	<xd:param name="show-upload">Shows Upload button in transaction</xd:param>
  	<xd:param name="bulk-transaction-mode">If the transaction is inside bulk</xd:param>
  	<xd:param name="cash-bankft-bulk-cancel">If transaction is inside bulk and cancel bulk at some place needs to behave like normal cancel button</xd:param>
  </xd:doc>
  
  <xsl:template name="menu">
   <!-- Node name and screen name are optional -->
   <xsl:param name="show-template">
		<xsl:choose>
			<xsl:when test="bulk_ref_id[.!='']">N</xsl:when>
			<xsl:otherwise>Y</xsl:otherwise>
		</xsl:choose>
   </xsl:param>
   <xsl:param name="show-submit">Y</xsl:param>
   <xsl:param name="show-save">Y</xsl:param>
   <xsl:param name="show-upload">N</xsl:param>
   <xsl:param name="show-validate">N</xsl:param>
   <xsl:param name="show-forward">N</xsl:param>
   <xsl:param name="show-reject">N</xsl:param>
   <xsl:param name="show-return">N</xsl:param>
   <xsl:param name="show-submit-bulk">N</xsl:param>
   <xsl:param name="second-menu">N</xsl:param>
   <xsl:param name="floating">N</xsl:param>
   <xsl:param name="show-resubmit">N</xsl:param>
   <xsl:param name="add-button-begin"></xsl:param>
   <xsl:param name="add-button-end"></xsl:param>
   <xsl:param name="show-accept">N</xsl:param>
   <xsl:param name="bulk-transaction-mode">
		<xsl:choose>
			<xsl:when test="bulk_ref_id[.!=''] and product_code !='IN' and product_code !='IP'">Y</xsl:when>
			<xsl:otherwise>N</xsl:otherwise>
		</xsl:choose>
   </xsl:param>
   <xsl:param name="treasury-fund-transfer-mode">N</xsl:param>
   <xsl:param name="cash-bankft-bulk-cancel">N</xsl:param>
    
     <xsl:variable name="validateButtonId">
     	<xsl:choose>
     		<xsl:when test="$second-menu='Y'">validateButton2</xsl:when>
     		<xsl:otherwise>validateButton</xsl:otherwise>
     	</xsl:choose>
     </xsl:variable>
     
     <xsl:variable name="saveButtonId">
     	<xsl:choose>
     		<xsl:when test="$second-menu='Y'">saveButton2</xsl:when>
     		<xsl:otherwise>saveButton</xsl:otherwise>
     	</xsl:choose>
     </xsl:variable>
     
     <xsl:variable name="submitButtonId">
     	<xsl:choose>
     		<xsl:when test="$second-menu='Y'">submitButton2</xsl:when>
     		<xsl:otherwise>submitButton</xsl:otherwise>
     	</xsl:choose>
     </xsl:variable>
     
     <xsl:variable name="forwardButtonId">
     	<xsl:choose>
     		<xsl:when test="$second-menu='Y'">forwardButton2</xsl:when>
     		<xsl:otherwise>forwardButton</xsl:otherwise>
     	</xsl:choose>
     </xsl:variable>
     
     <xsl:variable name="rejectButtonId">
     	<xsl:choose>
     		<xsl:when test="$second-menu='Y'">rejectButton2</xsl:when>
     		<xsl:otherwise>rejectButton</xsl:otherwise>
     	</xsl:choose>
     </xsl:variable>
     
     <xsl:variable name="returnTransactionButtonId">
     	<xsl:choose>
     		<xsl:when test="$second-menu='Y'">returnTransactionButton2</xsl:when>
     		<xsl:otherwise>returnTransactionButton</xsl:otherwise>
     	</xsl:choose>
     </xsl:variable>
     
     <xsl:variable name="templateButtonId">
     	<xsl:choose>
     		<xsl:when test="$second-menu='Y'">templateButton2</xsl:when>
     		<xsl:otherwise>templateButton</xsl:otherwise>
     	</xsl:choose>
     </xsl:variable>
     
     <xsl:variable name="cancelButtonId">
     	<xsl:choose>
     		<xsl:when test="$second-menu='Y'">cancelButton2</xsl:when>
     		<xsl:otherwise>menuCancelButton</xsl:otherwise>
     	</xsl:choose>
     </xsl:variable>
     
     
     <xsl:variable name="helpButtonId">
     	<xsl:choose>
     		<xsl:when test="$second-menu='Y'">helpButton2</xsl:when>
     		<xsl:otherwise>helpButton</xsl:otherwise>
     	</xsl:choose>
     </xsl:variable>     
     
     <xsl:variable name="previewButtonId">
     	<xsl:choose>
     		<xsl:when test="$second-menu='Y'">previewButton2</xsl:when>
     		<xsl:otherwise>previewButton</xsl:otherwise>
     	</xsl:choose>
     </xsl:variable>                          

     <xsl:variable name="submitBulkButtonId">
     	<xsl:choose>
     		<xsl:when test="$second-menu='Y'">submitBulkButton2</xsl:when>
     		<xsl:otherwise>submitBulkButton</xsl:otherwise>
     	</xsl:choose>
     </xsl:variable>

	<xsl:variable name="addBulkButtonId">
		<xsl:choose>
			<xsl:when test="$second-menu='Y'">addBulkButton2</xsl:when>
			<xsl:otherwise>addBulkButton</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:variable name="updateBulkButtonId">
		<xsl:choose>
			<xsl:when test="$second-menu='Y'">updateBulkButton2</xsl:when>
			<xsl:otherwise>updateBulkButton</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:variable name="templateBulkButtonId">
		<xsl:choose>
			<xsl:when test="$second-menu='Y'">templateBulkButton2</xsl:when>
			<xsl:otherwise>templateBulkButton</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:variable name="cancelBulkButtonId">
		<xsl:choose>	
			<xsl:when test="$second-menu='Y'">cancelBulkButton2</xsl:when>
			<xsl:otherwise>cancelBulkButton</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:variable name="helpButtonId">
		<xsl:choose>
			<xsl:when test="$second-menu='Y'">helpButton2</xsl:when>
			<xsl:otherwise>helpButton</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:variable name="uploadButtonId">
		<xsl:choose>
			<xsl:when test="$second-menu='Y'">uploadFormButton2</xsl:when>
			<xsl:otherwise>uploadFormButton</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<xsl:variable name="resubmitButtonId">
		<xsl:choose>
			<xsl:when test="$second-menu='Y'">resubmitButton2</xsl:when>
			<xsl:otherwise>resubmitButton</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="viewFeesButtonId">
     	<xsl:choose>
     		<xsl:when test="$second-menu='Y'">viewFeesButton2</xsl:when>
     		<xsl:otherwise>viewFeesButton</xsl:otherwise>
     	</xsl:choose>
     </xsl:variable>
	
	<xsl:if test="$displaymode='edit' or ($displaymode='view' and $mode='UNSIGNED')  or ($displaymode='view' and $mode='ACCEPT') or ($displaymode='view' and $mode='RESUBMIT')  or ($displaymode='view' and $mode='DRAFT' and $is_from_local_service='Y')">
		<xsl:if test="$bulk-transaction-mode = 'N' and $treasury-fund-transfer-mode = 'N'">
		<div>
	     <xsl:choose>
	      <xsl:when test="$floating='Y'"><xsl:attribute name="class">menu floating noprint</xsl:attribute></xsl:when>
	      <xsl:otherwise><xsl:attribute name="class">menu widgetContainer noprint</xsl:attribute></xsl:otherwise>
	     </xsl:choose>
	
	     <xsl:choose>
	      <!-- Edit mode buttons. -->
	      <xsl:when test="$displaymode='edit'">
	       <xsl:if test="$show-validate='Y'">
	         <xsl:call-template name="button-wrapper">
	         <xsl:with-param name="label">XSL_ACTION_VALIDATE</xsl:with-param>
	         <xsl:with-param name="id" select="$validateButtonId"></xsl:with-param>
	         <xsl:with-param name="class">validateButton</xsl:with-param>
	         <xsl:with-param name="show-text-label">Y</xsl:with-param>
	        </xsl:call-template>
	       </xsl:if>
	       <xsl:if test="$show-save='Y'">
	        <xsl:call-template name="button-wrapper">
	         <xsl:with-param name="label">XSL_ACTION_SAVE</xsl:with-param>
	         <xsl:with-param name="id" select="$saveButtonId"></xsl:with-param>
	         <xsl:with-param name="class">saveButton</xsl:with-param>
	         <xsl:with-param name="show-text-label">Y</xsl:with-param>
	        </xsl:call-template>
	       </xsl:if>
	       <xsl:if test="$show-submit='Y'">
	        <xsl:call-template name="button-wrapper">
	         <xsl:with-param name="label">XSL_ACTION_SUBMIT</xsl:with-param>
	         <xsl:with-param name="id" select="$submitButtonId"></xsl:with-param>
	         <xsl:with-param name="class">submitButton</xsl:with-param>
	         <xsl:with-param name="show-text-label">Y</xsl:with-param>
	        </xsl:call-template>
	       </xsl:if>
	       <xsl:if test="$show-accept='Y'">
	        <xsl:call-template name="button-wrapper">
	         <xsl:with-param name="label">XSL_ACTION_ACCEPT</xsl:with-param>
	         <xsl:with-param name="id" select="$submitButtonId"></xsl:with-param>
	         <xsl:with-param name="class">submitButton</xsl:with-param>
	         <xsl:with-param name="show-text-label">Y</xsl:with-param>
	        </xsl:call-template>
	       </xsl:if>
	       <xsl:if test="$show-submit-bulk='Y'">
	        <xsl:call-template name="button-wrapper">
	         <xsl:with-param name="label">XSL_ACTION_SUBMIT</xsl:with-param>
	         <xsl:with-param name="id" select="$submitBulkButtonId"></xsl:with-param>
	         <xsl:with-param name="class">submitBulkButton</xsl:with-param>
	         <xsl:with-param name="show-text-label">Y</xsl:with-param>
	        </xsl:call-template>
	       </xsl:if>
	       <xsl:if test="$show-template='Y'">
	        <xsl:call-template name="button-wrapper">
	         <xsl:with-param name="label">XSL_ACTION_TEMPLATE</xsl:with-param>
	         <xsl:with-param name="id" select="$templateButtonId"></xsl:with-param>
	         <xsl:with-param name="class">saveTemplateButton</xsl:with-param>
	         <xsl:with-param name="show-text-label">Y</xsl:with-param>
	        </xsl:call-template>
	       </xsl:if>
	       <xsl:if test="$show-forward='Y'">
	        <xsl:call-template name="button-wrapper">
	         <xsl:with-param name="label">XSL_ACTION_FORWARD</xsl:with-param>
	         <xsl:with-param name="id" select="$forwardButtonId"></xsl:with-param>
	         <xsl:with-param name="class">forwardButton</xsl:with-param>
	         <xsl:with-param name="show-text-label">Y</xsl:with-param>
	        </xsl:call-template>
	       </xsl:if>
	       <xsl:if test="$show-upload='Y'">
	        <xsl:call-template name="button-wrapper">
	         <xsl:with-param name="label">XSL_ACTION_UPLOAD</xsl:with-param>
	       	 <xsl:with-param name="id" select="$uploadButtonId"></xsl:with-param>
	         <xsl:with-param name="class">submitButton</xsl:with-param>
	         <xsl:with-param name="show-text-label">Y</xsl:with-param>
	        </xsl:call-template>
	       </xsl:if>
	       <xsl:call-template name="button-wrapper">
	        <xsl:with-param name="label">XSL_ACTION_CANCEL</xsl:with-param>
	        <xsl:with-param name="id" select="$cancelButtonId"></xsl:with-param>
	        <xsl:with-param name="class">cancelButton</xsl:with-param>
	        <xsl:with-param name="show-text-label">Y</xsl:with-param>
	       </xsl:call-template>
	       <xsl:if test = "product_code[.!='TM']">
		       <xsl:call-template name="button-wrapper">
		        <xsl:with-param name="label">XSL_ACTION_HELP</xsl:with-param>
		        <xsl:with-param name="id" select="$helpButtonId"></xsl:with-param>
		        <xsl:with-param name="class">helpButton</xsl:with-param>
		        <xsl:with-param name="show-text-label">Y</xsl:with-param>
		       </xsl:call-template>
	      </xsl:if>
	      </xsl:when>
	      <!-- View (unsigned) buttons. -->
	      <xsl:when test="$displaymode='view' and $mode='UNSIGNED'">
	       <xsl:if test="$show-submit='Y'">
	        <xsl:call-template name="button-wrapper">
	         <xsl:with-param name="label">XSL_ACTION_SUBMIT</xsl:with-param>
	         <xsl:with-param name="id" select="$submitButtonId"></xsl:with-param>
	         <xsl:with-param name="class">submitButton</xsl:with-param>
	         <xsl:with-param name="show-text-label">Y</xsl:with-param>
	        </xsl:call-template>
	       </xsl:if>
	       <xsl:if test="$show-submit-bulk='Y'">
	        <xsl:call-template name="button-wrapper">
	         <xsl:with-param name="label">XSL_ACTION_SUBMIT</xsl:with-param>
	         <xsl:with-param name="id" select="$submitBulkButtonId"></xsl:with-param>
	         <xsl:with-param name="class">submitBulkButton</xsl:with-param>
	         <xsl:with-param name="show-text-label">Y</xsl:with-param>
	        </xsl:call-template>
	       </xsl:if>
	       <xsl:if test="$show-reject='Y'">
	        <xsl:call-template name="button-wrapper">
	         <xsl:with-param name="label">XSL_ACTION_REJECT</xsl:with-param>
	         <xsl:with-param name="id" select="$rejectButtonId"></xsl:with-param>
	         <xsl:with-param name="class">rejectButton</xsl:with-param>
	         <xsl:with-param name="show-text-label">Y</xsl:with-param>
	        </xsl:call-template>
	       </xsl:if>
	       <xsl:if test="$show-return='Y'">
	        <xsl:call-template name="button-wrapper">
	         <xsl:with-param name="label">XSL_ACTION_RETURN</xsl:with-param>
	         <xsl:with-param name="id" select="$returnTransactionButtonId"></xsl:with-param>
	         <xsl:with-param name="class">returnTransactionButton</xsl:with-param>
	         <xsl:with-param name="show-text-label">Y</xsl:with-param>
	        </xsl:call-template>
	       </xsl:if>
	       <xsl:call-template name="button-wrapper">
	        <xsl:with-param name="label">XSL_ACTION_PREVIEW</xsl:with-param>
	        <xsl:with-param name="id" select="$previewButtonId"></xsl:with-param>
	        <xsl:with-param name="onclick">misys.popup.showPreview('FULL','<xsl:value-of select="product_code"/>','<xsl:value-of select="ref_id"/>','<xsl:value-of select="tnx_id"/>');return false;</xsl:with-param>
	        <xsl:with-param name="show-text-label">Y</xsl:with-param>
	       </xsl:call-template>
	       <xsl:call-template name="button-wrapper">
	        <xsl:with-param name="label">XSL_ACTION_CANCEL</xsl:with-param>
	        <xsl:with-param name="id" select="$cancelButtonId"></xsl:with-param>
	        <xsl:with-param name="class">cancelButton</xsl:with-param>
	        <xsl:with-param name="show-text-label">Y</xsl:with-param>
	       </xsl:call-template>
	       <xsl:call-template name="button-wrapper">
	        <xsl:with-param name="label">XSL_ACTION_HELP</xsl:with-param>
	        <xsl:with-param name="id" select="$helpButtonId"></xsl:with-param>
	        <xsl:with-param name="class">helpButton</xsl:with-param>
	        <xsl:with-param name="show-text-label">Y</xsl:with-param>
	       </xsl:call-template>
	      </xsl:when>
	      
	      <!-- View (accept) buttons. -->
	      <xsl:when test="$displaymode='view' and $mode='ACCEPT'">
	       <xsl:if test="$show-accept='Y'">
	        <xsl:call-template name="button-wrapper">
	         <xsl:with-param name="label">XSL_ACTION_ACCEPT</xsl:with-param>
	         <xsl:with-param name="id" select="$submitButtonId"></xsl:with-param>
	         <xsl:with-param name="class">submitButton</xsl:with-param>
	         <xsl:with-param name="show-text-label">Y</xsl:with-param>
	        </xsl:call-template>
	       </xsl:if>
	       <xsl:if test="$show-reject='Y'">
	        <xsl:call-template name="button-wrapper">
	         <xsl:with-param name="label">XSL_ACTION_REJECT</xsl:with-param>
	         <xsl:with-param name="id" select="$rejectButtonId"></xsl:with-param>
	         <xsl:with-param name="class">rejectButton</xsl:with-param>
	         <xsl:with-param name="show-text-label">Y</xsl:with-param>
	        </xsl:call-template>
	       </xsl:if>
	       
	       <xsl:if test="$show-submit='Y'">
	        <xsl:call-template name="button-wrapper">
	         <xsl:with-param name="label">XSL_ACTION_SUBMIT</xsl:with-param>
	         <xsl:with-param name="id" select="$submitButtonId"></xsl:with-param>
	         <xsl:with-param name="class">submitButton</xsl:with-param>
	         <xsl:with-param name="show-text-label">Y</xsl:with-param>
	        </xsl:call-template>
	       </xsl:if>
	       <xsl:if test="$show-return='Y'">
	        <xsl:call-template name="button-wrapper">
	         <xsl:with-param name="label">XSL_ACTION_RETURN</xsl:with-param>
	         <xsl:with-param name="id" select="$returnTransactionButtonId"></xsl:with-param>
	         <xsl:with-param name="class">returnTransactionButton</xsl:with-param>
	         <xsl:with-param name="show-text-label">Y</xsl:with-param>
	        </xsl:call-template>
	       </xsl:if>
	       <xsl:call-template name="button-wrapper">
	        <xsl:with-param name="label">XSL_ACTION_CANCEL</xsl:with-param>
	        <xsl:with-param name="id" select="$cancelButtonId"></xsl:with-param>
	        <xsl:with-param name="class">cancelButton</xsl:with-param>
	        <xsl:with-param name="show-text-label">Y</xsl:with-param>
	       </xsl:call-template>
	       <xsl:call-template name="button-wrapper">
	        <xsl:with-param name="label">XSL_ACTION_HELP</xsl:with-param>
	        <xsl:with-param name="id" select="$helpButtonId"></xsl:with-param>
	        <xsl:with-param name="class">helpButton</xsl:with-param>
	        <xsl:with-param name="show-text-label">Y</xsl:with-param>
	       </xsl:call-template>
	      </xsl:when>
	      
	       <!-- View (Resubmit) buttons. -->
	      <xsl:when test="$displaymode='view' and $mode='RESUBMIT'">
	       <xsl:if test="$show-resubmit='Y'">
	       <xsl:call-template name="button-wrapper">
	        <xsl:with-param name="label">XSL_ACTION_RESUBMIT</xsl:with-param>
	        <xsl:with-param name="id" select="$resubmitButtonId"></xsl:with-param>
	        <xsl:with-param name="class">resubmitButton</xsl:with-param>
	        <xsl:with-param name="show-text-label">Y</xsl:with-param>
	       </xsl:call-template>
	       </xsl:if>
	       <xsl:call-template name="button-wrapper">
	        <xsl:with-param name="label">XSL_ACTION_CANCEL</xsl:with-param>
	        <xsl:with-param name="id" select="$cancelButtonId"></xsl:with-param>
	        <xsl:with-param name="class">cancelButton</xsl:with-param>
	        <xsl:with-param name="show-text-label">Y</xsl:with-param>
	       </xsl:call-template>
	      </xsl:when>
	      <xsl:when test="$displaymode='view' and $mode='DRAFT'">
	       <xsl:call-template name="button-wrapper">
	        <xsl:with-param name="label">XSL_ACTION_CANCEL</xsl:with-param>
	        <xsl:with-param name="id" select="$cancelButtonId"></xsl:with-param>
	        <xsl:with-param name="class">cancelButton</xsl:with-param>
	        <xsl:with-param name="show-text-label">Y</xsl:with-param>
	       </xsl:call-template>
	      </xsl:when>
	     </xsl:choose>
	    </div>
    </xsl:if>
    
	   	<xsl:if test="$bulk-transaction-mode = 'Y'">
			<div>
		    	<xsl:choose>
		     		<xsl:when test="$floating='Y'"><xsl:attribute name="class">menu floating noprint</xsl:attribute></xsl:when>
					<xsl:otherwise><xsl:attribute name="class">menu widgetContainer noprint</xsl:attribute></xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
				<!-- Edit mode buttons. -->
					<xsl:when test="$displaymode='edit'">
						<xsl:if test="$show-bulk-add='Y'">
							<xsl:call-template name="button-wrapper">
								<xsl:with-param name="label">XSL_ACTION_ADD</xsl:with-param>
								<xsl:with-param name="id" select="$addBulkButtonId"></xsl:with-param>
								<xsl:with-param name="class">addBulkButton</xsl:with-param>
								<xsl:with-param name="show-text-label">Y</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="$show-bulk-update='Y'">
							<xsl:call-template name="button-wrapper">
								<xsl:with-param name="label">XSL_ACTION_UPDATE</xsl:with-param>
								<xsl:with-param name="id" select="$updateBulkButtonId"></xsl:with-param>
								<xsl:with-param name="class">updateBulkButton</xsl:with-param>
								<xsl:with-param name="show-text-label">Y</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:if test="$show-template='Y'">
							<xsl:call-template name="button-wrapper">
								<xsl:with-param name="label">XSL_ACTION_TEMPLATE</xsl:with-param>
								<xsl:with-param name="id" select="$templateBulkButtonId"></xsl:with-param>
								<xsl:with-param name="class">saveTemplateBulkButton</xsl:with-param>
								<xsl:with-param name="show-text-label">Y</xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						<xsl:choose>
							<xsl:when test="$cash-bankft-bulk-cancel='Y'">
								<xsl:call-template name="button-wrapper">
									<xsl:with-param name="label">XSL_ACTION_CANCEL</xsl:with-param>
									<xsl:with-param name="id" select="$cancelBulkButtonId"></xsl:with-param>
									<xsl:with-param name="class">cancelButton</xsl:with-param>
									<xsl:with-param name="show-text-label">Y</xsl:with-param>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="button-wrapper">
									<xsl:with-param name="label">XSL_ACTION_CANCEL</xsl:with-param>
									<xsl:with-param name="id" select="$cancelBulkButtonId"></xsl:with-param>
									<xsl:with-param name="class">cancelBulkButton</xsl:with-param>
									<xsl:with-param name="show-text-label">Y</xsl:with-param>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>

						<xsl:call-template name="button-wrapper">
							<xsl:with-param name="label">XSL_ACTION_HELP</xsl:with-param>
							<xsl:with-param name="id" select="$helpButtonId"></xsl:with-param>
							<xsl:with-param name="class">helpButton</xsl:with-param>
							<xsl:with-param name="show-text-label">Y</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<!-- View (unsigned) buttons. -->
					<xsl:when test="$displaymode='view' and $mode='UNSIGNED'">
						<xsl:call-template name="button-wrapper">
							<xsl:with-param name="label">XSL_ACTION_CANCEL</xsl:with-param>
							<xsl:with-param name="id" select="$cancelBulkButtonId"></xsl:with-param>
							<xsl:with-param name="class">cancelBulkButton</xsl:with-param>
							<xsl:with-param name="show-text-label">Y</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="button-wrapper">
							<xsl:with-param name="label">XSL_ACTION_HELP</xsl:with-param>
							<xsl:with-param name="id" select="$helpButtonId"></xsl:with-param>
							<xsl:with-param name="class">helpButton</xsl:with-param>
							<xsl:with-param name="show-text-label">Y</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
				</xsl:choose>
			</div>
	   	</xsl:if> 
    </xsl:if>
    <!-- FIX Later in sprint 17 -->
    <xsl:if test="$treasury-fund-transfer-mode ='Y' and ($displaymode='edit' or ($displaymode='view' and $mode='UNSIGNED'))">
		<div>
	     <xsl:choose>
	      <xsl:when test="$floating='Y'"><xsl:attribute name="class">menu floating noprint</xsl:attribute></xsl:when>
	      <xsl:otherwise><xsl:attribute name="class">menu widgetContainer noprint</xsl:attribute></xsl:otherwise>
	     </xsl:choose>
	
	     <xsl:choose>
	      <!-- Edit mode buttons. -->
	      <xsl:when test="$displaymode='edit'">

	      
	       <xsl:if test="$show-validate='Y'">
	         <xsl:call-template name="button-wrapper">
	         <xsl:with-param name="label">XSL_ACTION_VALIDATE</xsl:with-param>
	         <xsl:with-param name="id" select="$validateButtonId"></xsl:with-param>
	         <xsl:with-param name="class">validateButton</xsl:with-param>
	         <xsl:with-param name="show-text-label">Y</xsl:with-param>
	        </xsl:call-template>
	       </xsl:if>
	       <xsl:if test="$show-save='Y'">
	        <xsl:call-template name="button-wrapper">
	         <xsl:with-param name="label">XSL_ACTION_SAVE</xsl:with-param>
	         <xsl:with-param name="id" select="$saveButtonId"></xsl:with-param>
	         <xsl:with-param name="class">saveButton</xsl:with-param>
	         <xsl:with-param name="show-text-label">Y</xsl:with-param>
	        </xsl:call-template>
	       </xsl:if>

	       	<!-- add button  -->
			<xsl:copy-of select="$add-button-begin"/>
	       
	       <xsl:if test="$show-template='Y'">
	        <xsl:call-template name="button-wrapper">
	         <xsl:with-param name="label">XSL_ACTION_TEMPLATE</xsl:with-param>
	         <xsl:with-param name="id" select="$templateButtonId"></xsl:with-param>
	         <xsl:with-param name="class">saveTemplateButton</xsl:with-param>
	         <xsl:with-param name="show-text-label">Y</xsl:with-param>
	        </xsl:call-template>
	       </xsl:if>
	       <xsl:if test="$show-forward='Y'">
	        <xsl:call-template name="button-wrapper">
	         <xsl:with-param name="label">XSL_ACTION_FORWARD</xsl:with-param>
	         <xsl:with-param name="id" select="$forwardButtonId"></xsl:with-param>
	         <xsl:with-param name="class">forwardButton</xsl:with-param>
	         <xsl:with-param name="show-text-label">Y</xsl:with-param>
	        </xsl:call-template>
	       </xsl:if>
	       <xsl:if test="$show-reject='Y'">
	        <xsl:call-template name="button-wrapper">
	         <xsl:with-param name="label">XSL_ACTION_REJECT</xsl:with-param>
	         <xsl:with-param name="id" select="$rejectButtonId"></xsl:with-param>
	         <xsl:with-param name="class">rejectButton</xsl:with-param>
	         <xsl:with-param name="show-text-label">Y</xsl:with-param>
	        </xsl:call-template>
	       </xsl:if>
	       <xsl:call-template name="button-wrapper">
	        <xsl:with-param name="label">XSL_ACTION_CANCEL</xsl:with-param>
	        <xsl:with-param name="id" select="$cancelButtonId"></xsl:with-param>
	        <xsl:with-param name="class">cancelButton</xsl:with-param>
	        <xsl:with-param name="show-text-label">Y</xsl:with-param>
	       </xsl:call-template>
	       <xsl:call-template name="button-wrapper">
	        <xsl:with-param name="label">XSL_ACTION_HELP</xsl:with-param>
	        <xsl:with-param name="id" select="$helpButtonId"></xsl:with-param>
	        <xsl:with-param name="class">helpButton</xsl:with-param>
	        <xsl:with-param name="show-text-label">Y</xsl:with-param>
	       </xsl:call-template>
	       <!-- add button  -->
	       <xsl:copy-of select="$add-button-end"/>
	      </xsl:when>
	      <!-- View (unsigned) buttons. -->
	      <xsl:when test="$displaymode='view' and $mode='UNSIGNED'">
	      <!-- add button  -->
			<xsl:copy-of select="$add-button-begin"/>	   

	       <xsl:if test="$show-submit='Y'">
	        <xsl:call-template name="button-wrapper">
	         <xsl:with-param name="label">XSL_ACTION_SUBMIT</xsl:with-param>
	         <xsl:with-param name="id" select="$submitButtonId"></xsl:with-param>
	         <xsl:with-param name="class">submitButton</xsl:with-param>
	         <xsl:with-param name="show-text-label">Y</xsl:with-param>
	        </xsl:call-template>
	       </xsl:if>
	       <xsl:if test="$show-return='Y'">
	        <xsl:call-template name="button-wrapper">
	         <xsl:with-param name="label">XSL_ACTION_RETURN</xsl:with-param>
	         <xsl:with-param name="id" select="$returnTransactionButtonId"></xsl:with-param>
	         <xsl:with-param name="class">returnTransactionButton</xsl:with-param>
	         <xsl:with-param name="show-text-label">Y</xsl:with-param>
	        </xsl:call-template>
	        </xsl:if>
	        
	        <xsl:call-template name="button-wrapper">
	        <xsl:with-param name="label">XSL_ACTION_PREVIEW</xsl:with-param>
	        <xsl:with-param name="id" select="$previewButtonId"></xsl:with-param>
	        <xsl:with-param name="onclick">misys.popup.showPreview('FULL','<xsl:value-of select="product_code"/>','<xsl:value-of select="ref_id"/>','<xsl:value-of select="tnx_id"/>');return false;</xsl:with-param>
	        <xsl:with-param name="show-text-label">Y</xsl:with-param>
	        </xsl:call-template>

	       <xsl:call-template name="button-wrapper">
	        <xsl:with-param name="label">XSL_ACTION_CANCEL</xsl:with-param>
	        <xsl:with-param name="id" select="$cancelButtonId"></xsl:with-param>
	        <xsl:with-param name="class">cancelButton</xsl:with-param>
	        <xsl:with-param name="show-text-label">Y</xsl:with-param>
	       </xsl:call-template>
	       <xsl:call-template name="button-wrapper">
	        <xsl:with-param name="label">XSL_ACTION_HELP</xsl:with-param>
	        <xsl:with-param name="id" select="$helpButtonId"></xsl:with-param>
	        <xsl:with-param name="class">helpButton</xsl:with-param>
	        <xsl:with-param name="show-text-label">Y</xsl:with-param>
	       </xsl:call-template>
	       <!-- add button  -->
			<xsl:copy-of select="$add-button-end"/>	       
	      </xsl:when>
	     </xsl:choose>
	    </div>
    </xsl:if>
  
    <!-- We put the display mode in a global variable to know in js in what mode we are. The code is here solely because this should be included in every page. -->
    <xsl:if test="$second-menu='N'">
	    <script>
	    	dojo.ready(function(){
	    		misys._config = misys._config || {};
				misys._config.displayMode = '<xsl:value-of select="$displaymode"/>';
			});    
	    </script>
    </xsl:if>     
  </xsl:template>
  
  <xsl:template name="system-menu">
   <xsl:param name="second-menu">N</xsl:param>
   <xsl:param name="submit-type">SYSTEM_SUBMIT</xsl:param>

  	<xsl:variable name="saveButtonId">
     	<xsl:choose>
     		<xsl:when test="$second-menu='Y'">sySubmitButton2</xsl:when>
     		<xsl:otherwise>sySubmitButton</xsl:otherwise>
     	</xsl:choose>
     </xsl:variable>
     
     <xsl:variable name="cancelButtonId">
     	<xsl:choose>
     		<xsl:when test="$second-menu='Y'">cancelButton2</xsl:when>
     		<xsl:otherwise>menuCancelButton</xsl:otherwise>
     	</xsl:choose>
     </xsl:variable>
     
     <xsl:variable name="helpButtonId">
     	<xsl:choose>
     		<xsl:when test="$second-menu='Y'">helpButton2</xsl:when>
     		<xsl:otherwise>helpButton</xsl:otherwise>
     	</xsl:choose>
     </xsl:variable>        
   
   <xsl:if test="$displaymode='edit'">
    <div class="menu widgetContainer">

     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ACTION_SAVE</xsl:with-param>
 	  <xsl:with-param name="id" select="$saveButtonId"></xsl:with-param>      
      <xsl:with-param name="show-text-label">Y</xsl:with-param>
      <xsl:with-param name="class">systemSaveButton</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ACTION_CANCEL</xsl:with-param>
      <xsl:with-param name="id" select="$cancelButtonId"></xsl:with-param>
      <xsl:with-param name="class">cancelButton</xsl:with-param>
      <xsl:with-param name="show-text-label">Y</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ACTION_HELP</xsl:with-param>
       <xsl:with-param name="id" select="$helpButtonId"></xsl:with-param>
       <xsl:with-param name="class">helpButton</xsl:with-param>
       <xsl:with-param name="show-text-label">Y</xsl:with-param>
     </xsl:call-template>
    </div>
   </xsl:if>
   
   <!-- We put the display mode in a global variable to know in js in what mode we are. The code is here solely because this should be included in every page. -->
   <xsl:if test="$second-menu='N'">
    <script>
    	dojo.ready(function(){
    		misys._config = misys._config || {};
			misys._config.displayMode = '<xsl:value-of select="$displaymode"/>';
		});
    </script>
   </xsl:if>
  </xsl:template>
  
  <xsl:template name="popup-menu">
   <xsl:param name="second-menu">N</xsl:param>
  
  	 <xsl:variable name="saveButtonId">
     	<xsl:choose>
     		<xsl:when test="$second-menu='Y'">popupSubmitButton2</xsl:when>
     		<xsl:otherwise>popupSubmitButton</xsl:otherwise>
     	</xsl:choose>
     </xsl:variable>
        
     <xsl:variable name="cancelButtonId">
     	<xsl:choose>
     		<xsl:when test="$second-menu='Y'">popupCancelButton2</xsl:when>
     		<xsl:otherwise>popupMenuCancelButton</xsl:otherwise>
     	</xsl:choose>
     </xsl:variable>
     
     <xsl:variable name="helpButtonId">
     	<xsl:choose>
     		<xsl:when test="$second-menu='Y'">popupHelpButton2</xsl:when>
     		<xsl:otherwise>popupHelpButton</xsl:otherwise>
     	</xsl:choose>
     </xsl:variable>   
       
   <div class="menu clear" style="position:relative">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ACTION_SAVE</xsl:with-param>
      <xsl:with-param name="id" select="$saveButtonId"></xsl:with-param>
      <xsl:with-param name="show-text-label">Y</xsl:with-param>
      <xsl:with-param name="class">savePopupButton</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ACTION_CANCEL</xsl:with-param>
       <xsl:with-param name="id" select="$cancelButtonId"></xsl:with-param>
      <xsl:with-param name="show-text-label">Y</xsl:with-param>
      <xsl:with-param name="class">cancelPopupButton</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ACTION_HELP</xsl:with-param>
       <xsl:with-param name="id" select="$helpButtonId"></xsl:with-param>
       <xsl:with-param name="show-text-label">Y</xsl:with-param>
       <xsl:with-param name="class">helpPopupButton</xsl:with-param>
     </xsl:call-template>
    </div>
    <br></br>
  </xsl:template>

  <!--
  Displays one of the standard MTP buttons
   e.g. select beneficiary, account, currency, bank etc.
   
   TODO Refactor
  -->
  <xsl:template name="get-button">
   <!-- Required fields -->
   <xsl:param name="button-type"/>

   <!-- Button details. -->
   <xsl:param name="name"><xsl:value-of select="$button-type"/></xsl:param>
   <xsl:param name="id" select="$name"/>
   <xsl:param name="label"/>
   <xsl:param name="override-product-code" select="$lowercase-product-code"/> <!-- Just used for currency -->
   <xsl:param name="override-sub-product-code"/>
   <xsl:param name="beneficiary-cur-code"/> <!-- Used only by the beneficiary search dialog -->
   <xsl:param name="nbElement"/>
   <xsl:param name="prefix"/>
   <xsl:param name="non-dijit-button">N</xsl:param>
   <xsl:param name="dimensions">width: 650px;height: 350px;</xsl:param>
   <xsl:param name="keep-entity-product-button"/>
   <xsl:param name="get-data-action" />
   <xsl:param name="call-back-customer-field-post-name"></xsl:param>
   <xsl:param name="override_company_abbv_name"></xsl:param>
   <xsl:param name="override-displaymode" select="$displaymode"/>
   <xsl:param name="swift">N</xsl:param>
   <xsl:param name="codevalue-product-code"/>
   <xsl:param name="codevalue-sub-product-code"/>
   <xsl:param name="override-sub-product-code"/>
   <xsl:param name="phrase-params"/>
   <xsl:param name="messageValue"/>
   <xsl:param name="widget-name"/>
   <!-- Used by cash module to retrieve specific currencies from the back end -->
   <xsl:param name="user-action"/>
	<!--    used by set entity maintain -->
   <xsl:param name="override-applicant-reference"/>
   <xsl:param name="companyId"/>
   <xsl:param name="alert-type"/>
   <xsl:param name="amendment-no"/>
   <xsl:param name="overrideDimensions">width: 1100px;height: 450px;</xsl:param>
        
   <xsl:variable name="entityTitle">
    <xsl:value-of select="localization:getGTPString($language, 'TABLE_SUMMARY_ENTITIES_LIST')"/>
   </xsl:variable>

   <xsl:variable name="extendedMasterIssuance">
   	<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ISSUANCE')"/>
   </xsl:variable>
   <xsl:variable name="extendedMasterAmendments">
   	<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_AMENDMENT')"/>
   </xsl:variable>
   <xsl:variable name="extendedTitle">
   <xsl:choose>
	   <xsl:when test="$id ='narrative_description_goods' or $id ='narrative_amend_goods' or $id ='narrative_amend_goods_view' or $id ='narrative_amend_goods_mo' or $id ='narrative_amend_goods_popup'">
	   		<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_DESCRIPTION_GOODS')"/>
	   </xsl:when>
	   <xsl:when test="$id ='narrative_documents_required' or $id ='narrative_amend_docs' or $id ='narrative_amend_docs_view' or $id ='narrative_amend_docs_mo' or $id ='narrative_amend_docs_popup'">
	   		<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_DOCUMENTS_REQUIRED')"/>
	   </xsl:when>
	   <xsl:when test="$id ='narrative_additional_instructions' or $id ='narrative_amend_instructions' or $id ='narrative_amend_instructions_view' or $id ='narrative_amend_instructions_mo' or $id ='narrative_amend_instructions_popup'">
	   		<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_INSTRUCTIONS')"/>
	   </xsl:when>
	   <xsl:when test="$id ='narrative_special_beneficiary' or $id ='narrative_amend_sp_beneficiary' or $id ='narrative_amend_sp_beneficiary_view' or $id ='narrative_amend_sp_beneficiary_mo' or $id ='narrative_amend_sp_beneficiary_popup'">
	   		<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_BENEF')"/>
	   </xsl:when>
	   <xsl:when test="$id ='narrative_special_recvbank' or $id ='narrative_amend_sp_recvbank' or $id ='narrative_amend_sp_recvbank_view' or $id ='narrative_amend_sp_recvbank_mo' or $id ='narrative_amend_sp_recvbank_popup'">
	   		<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVEDETAILS_TAB_SPECIAL_PMNT_CON_RECEIV')"/>
	   </xsl:when>
	   <xsl:otherwise/>
   </xsl:choose>
   </xsl:variable>
   
   <xsl:variable name="customerTitle">
    <xsl:value-of select="localization:getGTPString($language, 'TABLE_SUMMARY_CUSTOMER_LIST')"/>
   </xsl:variable>

   <xsl:variable name="beneficiaryTitle">
    <xsl:value-of select="localization:getGTPString($language, 'TABLE_SUMMARY_COUNTERPARTIES_LIST')"/>
   </xsl:variable>
   
   <xsl:variable name="currencyTitle">
    <xsl:value-of select="localization:getGTPString($language, 'TABLE_SUMMARY_CURRENCIES_LIST')"/>
   </xsl:variable>
   
   <xsl:variable name="countryTitle">
    <xsl:value-of select="localization:getGTPString($language, 'TABLE_SUMMARY_COUNTRY_LIST')"/>
   </xsl:variable>
   
   <xsl:variable name="phraseTitle">
    <xsl:value-of select="localization:getGTPString($language, 'TABLE_SUMMARY_PHRASES_LIST')"/>
   </xsl:variable>
   
   <xsl:variable name="bankTitle">
    <xsl:value-of select="localization:getGTPString($language, 'TABLE_SUMMARY_BANKS_LIST')"/>
   </xsl:variable>
   
   <xsl:variable name="userTitle">
   	<xsl:value-of select="localization:getGTPString($language, 'TABLE_SUMMARY_USERS_LIST')"/>
   </xsl:variable>
   
    <xsl:variable name="bankTrustRelationshipTitle">
   		<xsl:value-of select="localization:getGTPString($language, 'TABLE_SUMMARY_BANK_LIST_TR')"/>
   	</xsl:variable>
   	
   	  <xsl:variable name="companyTrustRelationshipTitle">
   		<xsl:value-of select="localization:getGTPString($language, 'TABLE_SUMMARY_CUSTOMERS_LIST_TR')"/>
   	</xsl:variable>
	   
   <xsl:variable name="accountTitle">
	   <xsl:value-of select="localization:getGTPString($language, 'TABLE_SUMMARY_ACCOUNTS_LIST')"/>
   </xsl:variable> 
   <xsl:if test="$override-displaymode='edit'">
   <xsl:choose>
    <!-- Buttons for the customer and bank side.  -->
    <xsl:when test="$button-type='beneficiary' or $button-type='shippingCompany' or $button-type='consignee'  or $button-type='notifyParty' or $button-type='sec_beneficiary' or $button-type='assignee' or $button-type='applicant' or $button-type='remitter' or $button-type='drawer' or $button-type='drawee'">
     <!-- This var is to handle the trade message transfer screen -->
     <xsl:variable name="override-product-code">
      <xsl:choose>
       <xsl:when test="$product-code=''"><xsl:value-of select="product_code"/></xsl:when>
       <xsl:otherwise><xsl:value-of select="$product-code"/></xsl:otherwise>
      </xsl:choose>
     </xsl:variable>
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_BENEFICIARY</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="onclick">
      <xsl:choose>
      <xsl:when test="$override-product-code = 'EL' and security:isCustomer($rundata)">
       misys.showSearchDialog('beneficiary', "['<xsl:value-of select="$button-type"/>_abbv_name','<xsl:value-of select="$button-type"/>_name','<xsl:value-of select="$button-type"/>_address_line_1', '<xsl:value-of select="$button-type"/>_address_line_2', '<xsl:value-of select="$button-type"/>_dom','<xsl:value-of select="$button-type"/>_country','<xsl:value-of select="$button-type"/>_contact_name','<xsl:value-of select="$button-type"/>_contact_number','<xsl:value-of select="$button-type"/>_fax_num','<xsl:value-of select="$button-type"/>_email']", '', '', '<xsl:value-of select="$override-product-code"/>', 'width:710px;height:350px;', '<xsl:value-of select="$beneficiaryTitle"/>');return false;
      </xsl:when>
      <xsl:otherwise>
       misys.showSearchDialog('beneficiary', "['<xsl:value-of select="$button-type"/>_name','<xsl:value-of select="$button-type"/>_address_line_1', '<xsl:value-of select="$button-type"/>_address_line_2', '<xsl:value-of select="$button-type"/>_dom','<xsl:value-of select="$button-type"/>_country','<xsl:value-of select="$button-type"/>_contact_name','<xsl:value-of select="$button-type"/>_contact_number','<xsl:value-of select="$button-type"/>_fax_num','<xsl:value-of select="$button-type"/>_email']", '', '', '<xsl:value-of select="$override-product-code"/>', 'width:710px;height:350px;', '<xsl:value-of select="$beneficiaryTitle"/>');return false;
      </xsl:otherwise>
      </xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <!-- This is handling individually as the field names differes from orderingparty to other -->
    <xsl:when test="$button-type='ordering_party'">
     <!-- This var is to handle the trade message transfer screen -->
     <xsl:variable name="override-product-code">
      <xsl:choose>
       <xsl:when test="$product-code=''"><xsl:value-of select="product_code"/></xsl:when>
       <xsl:otherwise><xsl:value-of select="$product-code"/></xsl:otherwise>
      </xsl:choose>
     </xsl:variable>
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_BENEFICIARY</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
       <xsl:with-param name="onclick">misys.showSearchDialog('beneficiary', "['<xsl:value-of select="$button-type"/>_name', '<xsl:value-of select="$button-type"/>_address_line_1', '<xsl:value-of select="$button-type"/>_address_line_2', '<xsl:value-of select="$button-type"/>_address_dom','<xsl:value-of select="$button-type"/>_country','<xsl:value-of select="$button-type"/>_contact_name','<xsl:value-of select="$button-type"/>_phone','<xsl:value-of select="$button-type"/>_fax_num','<xsl:value-of select="$button-type"/>_email']", '', '', '<xsl:value-of select="$override-product-code"/>', 'width:710px;height:350px;', '<xsl:value-of select="$beneficiaryTitle"/>');return false;</xsl:with-param>
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
   <xsl:when test="$button-type='seller' or $button-type='bill_to' or $button-type='ship_to' or $button-type='consgn' or $button-type='buyer'">
     <!-- This var is to handle the trade message transfer screen -->
     <xsl:variable name="override-product-code">
      <xsl:choose>
       <xsl:when test="$product-code=''"><xsl:value-of select="product_code"/></xsl:when>
       <xsl:otherwise><xsl:value-of select="$product-code"/></xsl:otherwise>
      </xsl:choose>
     </xsl:variable>
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_COUNTERPARTY</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
       <xsl:with-param name="onclick">
	       <xsl:choose>
		       <xsl:when test="$override-product-code='IO' or $override-product-code='PO' or $override-product-code='EA' ">
		       		misys.showSearchDialog('baselineCustomer', "['<xsl:value-of select="$button-type"/>_name','<xsl:value-of select="$button-type"/>_abbv_name','<xsl:value-of select="$button-type"/>_bei', '<xsl:value-of select="$button-type"/>_street_name','<xsl:value-of select="$button-type"/>_post_code', '<xsl:value-of select="$button-type"/>_town_name','<xsl:value-of select="$button-type"/>_country_sub_div', '<xsl:value-of select="$button-type"/>_country','<xsl:value-of select="$button-type"/>_account_type','<xsl:value-of select="$button-type"/>_account_value','fscm_programme_01','fscm_programme_02','fscm_programme_03','fscm_programme_04','access_opened','transaction_counterparty_email','ben_company_abbv_name','fscm_programme_06']", {show_add_counterparty_button: 'N'}, '', '<xsl:value-of select="$override-product-code"/>', 'width:710px;height:350px;', '<xsl:value-of select="$beneficiaryTitle"/>');return false;
		       </xsl:when>
		      	<xsl:otherwise>
	       			misys.showSearchDialog('baselineCustomer', "['<xsl:value-of select="$button-type"/>_name','<xsl:value-of select="$button-type"/>_abbv_name','<xsl:value-of select="$button-type"/>_bei', '<xsl:value-of select="$button-type"/>_street_name','<xsl:value-of select="$button-type"/>_post_code', '<xsl:value-of select="$button-type"/>_town_name','<xsl:value-of select="$button-type"/>_country_sub_div', '<xsl:value-of select="$button-type"/>_country','<xsl:value-of select="$button-type"/>_account_type','<xsl:value-of select="$button-type"/>_account_value','fin_inst_bic','fin_inst_name','fin_inst_street_name','fin_inst_town_name','fin_inst_country_sub_div','access_opened','transaction_counterparty_email','ben_company_abbv_name',]", {show_add_counterparty_button: 'N'}, '', '<xsl:value-of select="$override-product-code"/>', 'width:710px;height:350px;', '<xsl:value-of select="$beneficiaryTitle"/>');return false;
	       		</xsl:otherwise>
	      	</xsl:choose>
       </xsl:with-param>
       
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="$button-type='fin_inst'">
      <xsl:variable name="override-product-code">
      <xsl:choose>
       <xsl:when test="$product-code=''"><xsl:value-of select="product_code"/></xsl:when>
       <xsl:otherwise><xsl:value-of select="$product-code"/></xsl:otherwise>
      </xsl:choose>
     </xsl:variable>
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_BANK</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="onclick">misys.showSearchDialog('baseline_bank',"['<xsl:value-of select="$button-type"/>_name', '<xsl:value-of select="$button-type"/>_bic', '<xsl:value-of select="$button-type"/>_street_name', '<xsl:value-of select="$button-type"/>_post_code', '<xsl:value-of select="$button-type"/>_town_name', '<xsl:value-of select="$button-type"/>_country_sub_div' , '<xsl:value-of select="$button-type"/>_country']", '', '', '<xsl:value-of select="$override-product-code"/>', '<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$bankTitle"/>');return false;</xsl:with-param>
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
	<xsl:when test="$button-type='currency'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_CURRENCY</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="onclick">
       <xsl:choose>
        <xsl:when test="$override-product-code='tf'">misys.showSearchDialog('<xsl:value-of select="$button-type"/>',"['fin_cur_code']", '', '', '', 'width:450px;height:400px;', '<xsl:value-of select="$currencyTitle"/>');return false;</xsl:when>
        <xsl:when test="$override-product-code='el'">misys.showSearchDialog('<xsl:value-of select="$button-type"/>',"['lc_cur_code']", '', '', '', 'width:450px;height:400px;', '<xsl:value-of select="$currencyTitle"/>');return false;</xsl:when>
        <xsl:when test="$override-product-code='iso'">misys.showSearchDialog('<xsl:value-of select="$button-type"/>',"['iso_code']", '', '', '', 'width:450px;height:400px;', '<xsl:value-of select="$currencyTitle"/>');return false;</xsl:when>
        <xsl:when test="$override-product-code='br'">misys.showSearchDialog('<xsl:value-of select="$button-type"/>',"['bg_cur_code']", '', '', '', 'width:450px;height:400px;', '<xsl:value-of select="$currencyTitle"/>');return false;</xsl:when>
        <xsl:when test="$override-product-code='param109'">misys.showSearchDialog('<xsl:value-of select="$button-type"/>',"['key_5']", '', '', '', 'width:450px;height:400px;', '<xsl:value-of select="$currencyTitle"/>');return false;</xsl:when>
        <xsl:when test="$override-product-code='param110'">misys.showSearchDialog('<xsl:value-of select="$button-type"/>',"['key_8']", '', '', '', 'width:450px;height:400px;', '<xsl:value-of select="$currencyTitle"/>');return false;</xsl:when>
        <xsl:when test="$override-product-code='ft'">misys.showSearchDialog('<xsl:value-of select="$button-type"/>',"['<xsl:value-of select="$override-product-code"/>_cur_code']", '', '', '<xsl:value-of select="$product-code"/>', 'width:450px;height:350px;', '<xsl:value-of select="$currencyTitle"/>', '', '<xsl:value-of select="$get-data-action" />', '', '<xsl:value-of select="$user-action"/>','', '<xsl:value-of select="$override-sub-product-code"/>');return false;</xsl:when>
        <xsl:when test="$override-product-code='bk'">misys.showSearchDialog('<xsl:value-of select="$button-type"/>',"['<xsl:value-of select="$override-product-code"/>_cur_code']", '', '', '<xsl:value-of select="$product-code"/>', 'width:450px;height:350px;', '<xsl:value-of select="$currencyTitle"/>', '', '<xsl:value-of select="$get-data-action" />', '', '<xsl:value-of select="$user-action"/>','', dijit.byId('sub_product_code').get('value'));return false;</xsl:when>
        <xsl:otherwise>
        	<xsl:choose>
        		<xsl:when test="$product-code!=''">misys.showSearchDialog('<xsl:value-of select="$button-type"/>',"['<xsl:value-of select="$override-product-code"/>_cur_code']", '', '', '<xsl:value-of select="$product-code"/>', 'width:450px;height:350px;', '<xsl:value-of select="$currencyTitle"/>', '', '<xsl:value-of select="$get-data-action" />', '', '', '', '<xsl:value-of select="$override-sub-product-code"/>');return false;</xsl:when>
				<xsl:otherwise>misys.showSearchDialog('<xsl:value-of select="$button-type"/>',"['<xsl:value-of select="$override-product-code"/>_cur_code']", '', '', '', 'width:450px;height:350px;', '<xsl:value-of select="$currencyTitle"/>', '', '<xsl:value-of select="$get-data-action" />', '', '', '',dijit.byId('product_type'));return false;</xsl:otherwise>
        	</xsl:choose>
        </xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="$button-type='charge'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_CURRENCY</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="onclick">misys.showSearchDialog('currency', "['<xsl:value-of select="$button-type"/>_details_cur_code_nosend']", '', '', '', 'width:400px;height:400px', '<xsl:value-of select="$currencyTitle"/>');return false;</xsl:with-param>
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="$button-type='fee'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_CURRENCY</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="onclick">misys.showSearchDialog('currency', "['cur_code']", '', '', '', 'width:400px;height:400px', '<xsl:value-of select="$currencyTitle"/>');return false;</xsl:with-param>
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    
    <xsl:when test="$button-type='rmGroup'">
     	<xsl:variable name="companyId">     		
     		 <xsl:choose>
       			<xsl:when test="company_id!=''"><xsl:value-of select="company_id"/></xsl:when>
       			<xsl:otherwise><xsl:value-of select="owner_id"/></xsl:otherwise>
       		</xsl:choose>
    	</xsl:variable>         
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_RMGROUP</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="onclick">misys.showSearchDialog('rmGroup', "['rmGroupName']", '', '', '', 'width:600px;height:400px', 'RMGROUP','<xsl:value-of select="$companyId"/>');return false;</xsl:with-param>
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    
    <!-- Popup for Country codes list -->
    <xsl:when test="$button-type='codevalue'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_COUNTRY</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="onclick">misys.showCountryCodeDialog('codevalue', "['<xsl:value-of select="$prefix"/>_country']", 'C006', '', '<xsl:value-of select="$codevalue-product-code"/>','<xsl:value-of select="$codevalue-sub-product-code"/>', 'width:400px;height:375px', '<xsl:value-of select="$countryTitle"/>', '<xsl:value-of select="$prefix"/>' === 'popup');return false;</xsl:with-param>
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="$button-type='ft_currency'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_CURRENCY</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="onclick">misys.showSearchDialog('currency', "['input_cur_code','<xsl:value-of select="$override-product-code"/>_cur_code']", '', '', '', 'width:400px;height:400px', '<xsl:value-of select="$currencyTitle"/>');return false;</xsl:with-param>
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="$button-type='credit_available_with_bank_other'">
     <xsl:variable name="prefix">credit_available_with_bank</xsl:variable>
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_BANK</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="onclick">misys.showBankTypeDialog('bank', "['<xsl:value-of select="$prefix"/>_name', '<xsl:value-of select="$prefix"/>_address_line_1', '<xsl:value-of select="$prefix"/>_address_line_2', '<xsl:value-of select="$prefix"/>_dom']", '<xsl:value-of select="$product-code"/>', '<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$bankTitle"/>');return false;</xsl:with-param>
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="$button-type='account'">
     <xsl:call-template name="button-wrapper">
	  <xsl:with-param name="label">XSL_ALT_PRINCIPAL_ACT</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="onclick">misys.showSearchDialog('account', "['<xsl:value-of select="$id"/>']", '', '', '<xsl:value-of select="$product-code"/>', '<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$accountTitle"/>');return false;</xsl:with-param>
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="$button-type='balances-alert-account'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_PRINCIPAL_ACT</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="onclick">misys.showSearchUserAccountsDialog("companyaccountwildcard", "['<xsl:value-of select="$alert-type"/>entity','account_no','account_num<xsl:value-of select="$alert-type"/>','', '','','']", 
						'', '<xsl:value-of select="$alert-type"/>entity', '', 'BA', 'width:750px;height:400px;', misys.getLocalization("ListOfAccountsTitleMessage"),'', '<xsl:value-of select="$companyId"/>');</xsl:with-param>
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>    
    <xsl:when test="$button-type='ddaccount'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_PRINCIPAL_ACT</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="onclick">misys.showSearchDialog('ddaccount', "['<xsl:value-of select="$id"/>']", '', '', '<xsl:value-of select="$product-code"/>', '<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$accountTitle"/>');return false;</xsl:with-param>
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
     <xsl:when test="$button-type='transfer-to-account'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_PRINCIPAL_ACT</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
       <!-- <xsl:with-param name="onclick">misys.showSearchDialog('account', "['<xsl:value-of select="$id"/>','beneficiary_name', '', '', '','beneficiary_account_type']", '', '', '<xsl:value-of select="$product-code"/>', '<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$accountTitle"/>');return false;</xsl:with-param> -->
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when> 
    <xsl:when test="$button-type='extended-narrative' or $button-type='dataGridExtendedView' or $button-type='narrative_amend_goods_popup' or $button-type='narrative_amend_docs_popup' or $button-type='narrative_amend_instructions_popup' or $button-type='narrative_amend_sp_beneficiary_popup' or $button-type='narrative_amend_sp_recvbank_popup'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">TABLE_SUMMARY_EXTENDED_NARRATIVE</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($extendedViewImage)"/></xsl:with-param>
      <xsl:with-param name="onclick">misys.showExtendedNarrativeView('<xsl:value-of select="$button-type"/>','<xsl:value-of select="$override-product-code"/>','<xsl:value-of select="$extendedTitle"/>','<xsl:value-of select="securityUtils:encodeHTML($messageValue)"/>','<xsl:value-of select="$widget-name"/>');return false;</xsl:with-param>
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_ext_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button">N</xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="$button-type='narrative_amend_goods' or $button-type='narrative_amend_docs' or $button-type='narrative_amend_instructions' or $button-type='narrative_amend_sp_beneficiary' or $button-type='narrative_amend_sp_recvbank'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">AMEND_NARRATIVE_BUTTON_LABEL</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($amendPopUpImage)"/></xsl:with-param>
      <!-- <xsl:with-param name="onclick">misys.editNarrativeInPopUp('<xsl:value-of select="$button-type"/>','<xsl:value-of select="$override-product-code"/>','<xsl:value-of select="$extendedTitle"/>','<xsl:value-of select="securityUtils:encodeHTML($messageValue)"/>','<xsl:value-of select="$widget-name"/>');return false;</xsl:with-param> -->
      <xsl:with-param name="onclick">misys.editNarrativeInPopUp('<xsl:value-of select="$button-type"/>','<xsl:value-of select="$messageValue"/>', '<xsl:value-of select="$widget-name" />', '<xsl:value-of select="$override-product-code"/>', '<xsl:value-of select="$overrideDimensions"/>', '<xsl:value-of select="$extendedTitle"/>', '<xsl:value-of select="$amendment-no"/>');return false;</xsl:with-param>
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button">N</xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    
    <xsl:when test="$button-type='narrative_amend_goods_view' or $button-type='narrative_amend_docs_view' or $button-type='narrative_amend_instructions_view' or $button-type='narrative_amend_sp_beneficiary_view' or $button-type='narrative_amend_sp_recvbank_view'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">TABLE_SUMMARY_EXTENDED_NARRATIVE</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($extendedViewImage)"/></xsl:with-param>
      <!-- <xsl:with-param name="onclick">misys.editNarrativeInPopUp('<xsl:value-of select="$button-type"/>','<xsl:value-of select="$override-product-code"/>','<xsl:value-of select="$extendedTitle"/>','<xsl:value-of select="securityUtils:encodeHTML($messageValue)"/>','<xsl:value-of select="$widget-name"/>');return false;</xsl:with-param> -->
      <xsl:with-param name="onclick">misys.viewNarrativeInPopUp('<xsl:value-of select="$button-type"/>','<xsl:value-of select="$messageValue"/>', '<xsl:value-of select="$widget-name" />', '<xsl:value-of select="$override-product-code"/>', '<xsl:value-of select="$overrideDimensions"/>', '<xsl:value-of select="$extendedTitle"/>', '<xsl:value-of select="$amendment-no"/>');return false;</xsl:with-param>
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button">N</xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    
    <xsl:when test="$button-type='extended-preview-issuance'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_VIEW_TRANSACTION_DETAILS</xsl:with-param>
      <xsl:with-param name="onclick">misys.showExtendedNarrativeView('<xsl:value-of select="$button-type"/>', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="$extendedMasterIssuance"/>', '<xsl:value-of select="securityUtils:encodeHTML($messageValue)"/>');return false;</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="id">master-issuance</xsl:with-param>
      <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($extendedViewImage)"/></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    
    <xsl:when test="$button-type='extended-preview-amendments'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_VIEW_TRANSACTION_DETAILS</xsl:with-param>
      <xsl:with-param name="onclick">misys.showExtendedNarrativeView('<xsl:value-of select="$button-type"/>', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="$extendedMasterAmendments"/>', '<xsl:value-of select="securityUtils:encodeHTML($messageValue)"/>');return false;</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="id">master-amendments</xsl:with-param>
      <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($extendedViewImage)"/></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    
    <xsl:when test="$button-type='phrase'">
    	<xsl:if test="security:isBank($rundata) or (securityCheck:hasPermission(utils:getUserACL($rundata),'sy_static_phrase_access',utils:getUserEntities($rundata))) or (securityCheck:hasPermission(utils:getUserACL($rundata),'sy_dynamic_phrase_access',utils:getUserEntities($rundata)))">
	     <!-- This var is to handle the trade message screen -->
	     <xsl:variable name="override-product-code">
	      <xsl:choose>
	       <xsl:when test="$product-code=''"><xsl:value-of select="product_code"/></xsl:when>
	       <xsl:otherwise><xsl:value-of select="$product-code"/></xsl:otherwise>
	      </xsl:choose>
	     </xsl:variable>
	     <xsl:call-template name="button-wrapper">
	      <xsl:with-param name="label">XSL_ALT_PHRASES</xsl:with-param>
	      <xsl:with-param name="show-image">Y</xsl:with-param>
	      <xsl:with-param name="show-border">N</xsl:with-param>
	      <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($openDialogImage)"/></xsl:with-param>
	      <xsl:with-param name="onclick">misys.showSearchDialog('<xsl:value-of select="$button-type"/>',"['<xsl:value-of select="$id"/>']", <xsl:value-of select="$phrase-params" />, '', '<xsl:value-of select="$override-product-code"/>', '<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$phraseTitle"/>');return false;</xsl:with-param>
	      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
	      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
	     </xsl:call-template>
	   </xsl:if>
    </xsl:when>
    <xsl:when test="$swift='N' and ($button-type='bank' or $button-type='advising_bank' or $button-type='processing_bank' or $button-type='advise_thru_bank' or $button-type='issuing_bank' or $button-type='confirming_bank' or $button-type='presenting_bank' or $button-type='pay_through_bank' or $button-type='account_with_bank' or $button-type='credit_available_with_bank' or $button-type='remitting_bank' or $button-type='collecting_bank' or $button-type='requested_confirmation_party')">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_BANK</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="onclick">misys.showSearchDialog('bank',"['<xsl:value-of select="$button-type"/>_name', '<xsl:value-of select="$button-type"/>_address_line_1', '<xsl:value-of select="$button-type"/>_address_line_2', '<xsl:value-of select="$button-type"/>_dom', '<xsl:value-of select="$button-type"/>_iso_code', '<xsl:value-of select="$button-type"/>_contact_name', '<xsl:value-of select="$button-type"/>_phone']", '', '', '<xsl:value-of select="//product_code"/>', '<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$bankTitle"/>');return false;</xsl:with-param>
	  <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="$swift='Y' and ($button-type='bank' or $button-type='advising_bank' or $button-type='processing_bank' or $button-type='advise_thru_bank' or $button-type='issuing_bank' or $button-type='confirming_bank' or $button-type='presenting_bank' or $button-type='pay_through_bank' or $button-type='account_with_bank' or $button-type='credit_available_with_bank' or $button-type='remitting_bank' or $button-type='collecting_bank' or $button-type='requested_confirmation_party')">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_BANK</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="onclick">misys.showSearchDialog('bank',"['<xsl:value-of select="$button-type"/>_name', '<xsl:value-of select="$button-type"/>_address_line_1', '<xsl:value-of select="$button-type"/>_address_line_2', '<xsl:value-of select="$button-type"/>_dom', '<xsl:value-of select="$button-type"/>_iso_code', '<xsl:value-of select="$button-type"/>_contact_name', '<xsl:value-of select="$button-type"/>_phone']", {swiftcode: true}, '', '<xsl:value-of select="//product_code"/>', 'width:800px;height:400px;', '<xsl:value-of select="$bankTitle"/>');return false;</xsl:with-param>
	  <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="$swift='N' and ($button-type='transferee_bank')">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_BANK</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="onclick">misys.showSearchDialog('bank',"['<xsl:value-of select="$button-type"/>_name', '<xsl:value-of select="$button-type"/>_address_line_1', '<xsl:value-of select="$button-type"/>_address_line_2', '<xsl:value-of select="$button-type"/>_dom', '<xsl:value-of select="$button-type"/>_swift_code', '<xsl:value-of select="$button-type"/>_contact_name', '<xsl:value-of select="$button-type"/>_phone']", '', '', '<xsl:value-of select="$override-product-code"/>', '<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$bankTitle"/>');return false;</xsl:with-param>
	  <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="$swift='Y' and ($button-type='transferee_bank')">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_BANK</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="onclick">misys.showSearchDialog('bank',"['<xsl:value-of select="$button-type"/>_name', '<xsl:value-of select="$button-type"/>_address_line_1', '<xsl:value-of select="$button-type"/>_address_line_2', '<xsl:value-of select="$button-type"/>_dom', '<xsl:value-of select="$button-type"/>_swift_code', '<xsl:value-of select="$button-type"/>_contact_name', '<xsl:value-of select="$button-type"/>_phone']", {swiftcode: true}, '', '<xsl:value-of select="$override-product-code"/>', 'width:800px;height:400px;', '<xsl:value-of select="$bankTitle"/>');return false;</xsl:with-param>
	  <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <!-- Show SWIFT ISO codes only -->
    <xsl:when test="$button-type='swift'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_BANK</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="onclick">misys.showSearchDialog('bank',"['<xsl:value-of select="$prefix"/>_name', '<xsl:value-of select="$prefix"/>_address_line_1', '<xsl:value-of select="$prefix"/>_address_line_2', '<xsl:value-of select="$prefix"/>_dom', '<xsl:value-of select="$prefix"/>_iso_code', '<xsl:value-of select="$prefix"/>_contact_name', '<xsl:value-of select="$prefix"/>_phone','<xsl:value-of select="$prefix"/>_country']", {swiftcode: false, bankcode: false}, '', '<xsl:value-of select="$override-product-code"/>', '<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$bankTitle"/>');return false;</xsl:with-param>
	  <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="$button-type='bank_collaboration'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_BANK</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="onclick">misys.showSearchDialog('bank',"['public_task_details_bank_assignee_name_nosend']", '', '', '<xsl:value-of select="$override-product-code"/>', '<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$bankTitle"/>');return false;</xsl:with-param>
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="$button-type='counterparty'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_COUNTERPARTY</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="onclick">misys.showSearchDialog('account', "['<xsl:value-of select="$button-type"/>_details_act_no_nosend','<xsl:value-of select="$button-type"/>_details_name_nosend','<xsl:value-of select="$button-type"/>_details_address_line_1_nosend','<xsl:value-of select="$button-type"/>_details_address_line_2_nosend', '<xsl:value-of select="$button-type"/>_details_dom_nosend' ]",{company_id: <xsl:value-of select="company_id"/>, entity_name: '<xsl:value-of select="//entity"/>'}, '', '<xsl:value-of select="//product_code"/>', '<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$beneficiaryTitle"/>');return false;</xsl:with-param>
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="$button-type='counterparty_collaboration'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_COUNTERPARTY</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="onclick">misys.showSearchDialog('counterparty_collaboration', "['public_task_details_counterparty_assignee_name_nosend', 'public_task_details_counterparty_assignee_abbv_name_nosend', 'counterparty_email_id_hidden']", {company_id:<xsl:value-of select="company_id"/>, entity_name:'<xsl:value-of select="//entity"/>'}, '', '<xsl:value-of select="//product_code"/>', '<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$beneficiaryTitle"/>');return false;</xsl:with-param>
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="$button-type='user_collaboration'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_ASSIGNEE</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="onclick">misys.showSearchDialog('user_collaboration', "['public_task_details_other_user_assignee_login_id_nosend','other_user_email_id_hidden','public_task_details_other_user_assignee_user_id_nosend']", {company_id:<xsl:value-of select="company_id"/>,entity_name:'<xsl:value-of select="//entity"/>'}, '', '<xsl:value-of select="//product_code"/>', '<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$userTitle"/>');return false;</xsl:with-param>
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="$button-type='user_collaboration_notification'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_ASSIGNEE</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="onclick">misys.showSearchDialog('user_collaboration', "['notification_task_details_other_user_assignee_login_id_nosend','other_user_email_id_hidden','notification_task_details_other_user_assignee_user_id_nosend']", {company_id:<xsl:value-of select="company_id"/>,entity_name:'<xsl:value-of select="//entity"/>'}, '', '<xsl:value-of select="//product_code"/>', '<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$userTitle"/>');return false;</xsl:with-param>
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
     <xsl:when test="$button-type='set-from-bank'">
	     <xsl:call-template name="button-wrapper">
	      <xsl:with-param name="label">XSL_ALT_BANK_TRUST_RELATIONSHIP</xsl:with-param>
	      <xsl:with-param name="show-image">Y</xsl:with-param>
	      <xsl:with-param name="show-border">N</xsl:with-param>
	      <xsl:with-param name="onclick">misys.showSearchDialog('trust_bank', "['from_bank','from_bank_id_hidden']",{company_id: <xsl:value-of select="company_id"/>}, '', '', '<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$bankTrustRelationshipTitle"/>');return false;</xsl:with-param>
	      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
	      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
	     </xsl:call-template>
    </xsl:when>
     <xsl:when test="$button-type='set-to-bank'">
	     <xsl:call-template name="button-wrapper">
	      <xsl:with-param name="label">XSL_ALT_BANK_TRUST_RELATIONSHIP</xsl:with-param>
	      <xsl:with-param name="show-image">Y</xsl:with-param>
	      <xsl:with-param name="show-border">N</xsl:with-param>
	      <xsl:with-param name="onclick">misys.showSearchDialog('trust_bank', "['to_bank','to_bank_id_hidden']",{company_id: <xsl:value-of select="company_id"/>}, '', '', '<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$bankTrustRelationshipTitle"/>');return false;</xsl:with-param>
	      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
	      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
	     </xsl:call-template>
    </xsl:when>
     <xsl:when test="$button-type='set-from-company'">
	     <xsl:call-template name="button-wrapper">
	      <xsl:with-param name="label">XSL_ALT_CUSTOMER_TRUST_RELATIONSHIP</xsl:with-param>
	      <xsl:with-param name="show-image">Y</xsl:with-param>
	      <xsl:with-param name="show-border">N</xsl:with-param>
	      <xsl:with-param name="onclick">misys.showSearchDialog('trust_customers', "['from_company','from_company_id_hidden']",{company_id: <xsl:value-of select="company_id"/>,from_bank: dijit.byId("from_bank").get("value"),to_company:dijit.byId("to_company").get("value")}, '', '', '<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$companyTrustRelationshipTitle"/>');return false;</xsl:with-param>
	      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
	      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
	     </xsl:call-template>
    </xsl:when>
     <xsl:when test="$button-type='set-to-company'">
	     <xsl:call-template name="button-wrapper">
	      <xsl:with-param name="label">XSL_ALT_CUSTOMER_TRUST_RELATIONSHIP</xsl:with-param>
	      <xsl:with-param name="show-image">Y</xsl:with-param>
	      <xsl:with-param name="show-border">N</xsl:with-param>
	      <xsl:with-param name="onclick">misys.showSearchDialog('trust_customers', "['to_company','to_company_id_hidden']",{company_id: <xsl:value-of select="company_id"/>,to_bank: dijit.byId("to_bank").get("value"),from_company:dijit.byId("from_company").get("value")}, '', '', '<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$companyTrustRelationshipTitle"/>');return false;</xsl:with-param>
	      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
	      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
	     </xsl:call-template>
    </xsl:when>
     <xsl:when test="$button-type='set-from-user'">
	     <xsl:call-template name="button-wrapper">
	      <xsl:with-param name="label">XSL_ALT_USER_TRUST_RELATIONSHIP</xsl:with-param>
	      <xsl:with-param name="show-image">Y</xsl:with-param>
	      <xsl:with-param name="show-border">N</xsl:with-param>
	      <xsl:with-param name="onclick">misys.showSearchDialog('trust_users', "['from_user','from_user_id_hidden']",{company_id: <xsl:value-of select="company_id"/>,from_company_id: dijit.byId("from_company_id_hidden").get("value")}, '', '', '<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$companyTrustRelationshipTitle"/>');return false;</xsl:with-param>
	      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
	      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
	     </xsl:call-template>
    </xsl:when>
     <xsl:when test="$button-type='set-to-user'">
	     <xsl:call-template name="button-wrapper">
	      <xsl:with-param name="label">XSL_ALT_USER_TRUST_RELATIONSHIP</xsl:with-param>
	      <xsl:with-param name="show-image">Y</xsl:with-param>
	      <xsl:with-param name="show-border">N</xsl:with-param>
	      <xsl:with-param name="onclick">misys.showSearchDialog('trust_users', "['to_user','to_user_id_hidden']",{company_id: <xsl:value-of select="company_id"/>,to_company_id: dijit.byId("to_company_id_hidden").get("value")}, '', '', '<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$companyTrustRelationshipTitle"/>');return false;</xsl:with-param>
	      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
	      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
	     </xsl:call-template>
    </xsl:when>
    <xsl:when test="$button-type='entity'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_ENTITY</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="onclick">
      <xsl:choose>
        <!-- <xsl:when test="ft_type and ft_type[.='02']">misys.showEntityDialog('<xsl:value-of select="$button-type"/>',"['<xsl:value-of select="$button-type"/>', '<xsl:value-of select="$prefix"/>_name', '<xsl:value-of select="$prefix"/>_address_line_1', '<xsl:value-of select="$prefix"/>_address_line_2', '<xsl:value-of select="$prefix"/>_dom']",'<xsl:value-of select="$override-product-code"/>','USER', '', '', '', '<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$entityTitle"/>','<xsl:value-of select="$override-sub-product-code"/>');return false;</xsl:when> -->
        <xsl:when test="translate($override-product-code,$up,$lo)='bg'">misys.showEntityDialog('<xsl:value-of select="$button-type"/>',"['<xsl:value-of select="$button-type"/>', '<xsl:value-of select="$prefix"/>_name', '<xsl:value-of select="$prefix"/>_address_line_1', '<xsl:value-of select="$prefix"/>_address_line_2', '<xsl:value-of select="$prefix"/>_dom', '<xsl:value-of select="$prefix"/>_country']",'<xsl:value-of select="$override-product-code"/>','USER', '', '', '', '<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$entityTitle"/>','<xsl:value-of select="$override-sub-product-code"/>');return false;</xsl:when>
        <xsl:when test="product_code[.='IO' or .='PO' or .='IN' or .='IP' or .='CN' or .='CR'] or (product_code[.='EA'] and tnx_type_code[.='01'])">misys.showEntityDialog('<xsl:value-of select="$button-type"/>',"['<xsl:value-of select="$button-type"/>', '<xsl:value-of select="$prefix"/>_name', '<xsl:value-of select="$prefix"/>_street_name','<xsl:value-of select="$prefix"/>_town_name','<xsl:value-of select="$prefix"/>_country_sub_div','<xsl:value-of select="$prefix"/>_post_code','<xsl:value-of select="$prefix"/>_country']",'<xsl:value-of select="$override-product-code"/>','FSCM_USER_ENTITIES_NO_WILDCARD', '', '', '', '<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$entityTitle"/>','<xsl:value-of select="$override-sub-product-code"/>');return false;</xsl:when>
        <xsl:when test="product_code[.='EA'] and tnx_type_code[.!='01']">misys.showEntityDialog('<xsl:value-of select="$button-type"/>',"['<xsl:value-of select="$button-type"/>']",'<xsl:value-of select="$override-product-code"/>','FSCM_USER_ENTITIES_NO_WILDCARD', '', '', '', '<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$entityTitle"/>','<xsl:value-of select="$override-sub-product-code"/>');return false;</xsl:when>
        <xsl:otherwise>misys.showEntityDialog('<xsl:value-of select="$button-type"/>',"['<xsl:value-of select="$button-type"/>', '<xsl:value-of select="$prefix"/>_name', '<xsl:value-of select="$prefix"/>_address_line_1', '<xsl:value-of select="$prefix"/>_address_line_2', '<xsl:value-of select="$prefix"/>_dom']",'<xsl:value-of select="$override-product-code"/>', 'USER', '', '', '', '<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$entityTitle"/>','<xsl:value-of select="$override-sub-product-code"/>');return false;</xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="$button-type='system-entity'">
     <xsl:variable name="entity-product">
      <xsl:choose>
      	<xsl:when test="$keep-entity-product-button='*'">*</xsl:when>
      	<xsl:otherwise>
      		  <xsl:choose>
		       <xsl:when test="authorisation/product_code[.='']">*</xsl:when>
		       <xsl:otherwise><xsl:value-of select="authorisation/product_code"/></xsl:otherwise>
		      </xsl:choose>
      	</xsl:otherwise>
      </xsl:choose>
     </xsl:variable>
     <!-- For authorisation screen -->
     <xsl:variable name="company-name">
      <xsl:choose>
      	<xsl:when test="$override_company_abbv_name  != ''">
      		<xsl:value-of select="$override_company_abbv_name"/>
      	</xsl:when>
      	<xsl:when test="static_company/abbv_name">
      		<xsl:value-of select="static_company/abbv_name"/>
      	</xsl:when>
      	<xsl:otherwise></xsl:otherwise>
      </xsl:choose>
     </xsl:variable>
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_ENTITY</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="onclick">misys.showEntityDialog('entity',"['entity']",'<xsl:value-of select="$entity-product"/>','COMPANY', '<xsl:value-of select="$company-name"/>', '', '', 'height: 350px;', '<xsl:value-of select="$entityTitle"/>','<xsl:value-of select="$override-sub-product-code"/>');return false;</xsl:with-param>
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="$button-type='set-entity'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_ENTITY</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="onclick">misys.showEntityDialog('entity',"['entity']",'<xsl:value-of select="$override-product-code"/>', 'ENTITIES_FROM_REFERENCE', '', '<xsl:value-of select="$override-applicant-reference"/>', '','<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$entityTitle"/>','<xsl:value-of select="$override-sub-product-code"/>');return false;</xsl:with-param>
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="$button-type='popup-entity'">
     <xsl:variable name="entity-product">
      <xsl:choose>
       <xsl:when test="authorisation/product_code[.='']">*</xsl:when>
       <xsl:otherwise><xsl:value-of select="authorisation/product_code"/></xsl:otherwise>
      </xsl:choose>
     </xsl:variable>
     <!-- For authorisation screen -->
     <xsl:variable name="company-name">
      <xsl:if test="static_company/abbv_name">
       <xsl:value-of select="static_company/abbv_name"/>
      </xsl:if>
     </xsl:variable>
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_ENTITY</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="onclick">misys.showEntityDialog('entity',"['sy_entity']",'<xsl:value-of select="$override-product-code"/>','USER', '<xsl:value-of select="$company-name"/>', '', '', '<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$entityTitle"/>','<xsl:value-of select="$override-sub-product-code"/>', true, false);return false;</xsl:with-param>
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="$button-type='system-guarantee-maintenance-entity'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_ENTITY</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="onclick">misys.showEntityDialog('entity',"['company_id','customer_abbv_name<xsl:value-of select="$call-back-customer-field-post-name"/>','customer_entity','customer_name']", 'BG', 'GRP_CUSTOMER_WITH_ENTITY_WILDCARD', '', '', '', '<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$entityTitle"/>','<xsl:value-of select="$override-sub-product-code"/>');return false;</xsl:with-param>
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
     <xsl:when test="$button-type='system-standby-maintenance-entity'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_ENTITY</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="onclick">misys.showEntityDialog('entity',"['company_id','customer_abbv_name<xsl:value-of select="$call-back-customer-field-post-name"/>','customer_entity','customer_name']", 'SI', 'GRP_CUSTOMER_WITH_ENTITY_WILDCARD', '', '', '', '<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$entityTitle"/>','<xsl:value-of select="$override-sub-product-code"/>');return false;</xsl:with-param>
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="$button-type='system-license-maintenance-entity'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_ENTITY</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="onclick">misys.showEntityDialog('entity',"['company_id','customer_abbv_name<xsl:value-of select="$call-back-customer-field-post-name"/>', 'customer_entity','customer_name','','','','entity_id']", 'BG', 'GRP_CUSTOMER_WITH_ENTITY_WILDCARD', '', '', '', '<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$entityTitle"/>','<xsl:value-of select="$override-sub-product-code"/>');return false;</xsl:with-param>
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="$button-type='system-beneficiary-advice-designer-entity'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_ENTITY</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="onclick">misys.showEntityDialog('entity',"['company_id','customer_abbv_name<xsl:value-of select="$call-back-customer-field-post-name"/>','customer_entity','customer_name']", 'FT', 'CUSTOMER_WITH_ENTITY_WILDCARD', '', '', '', 'width:800px;height:400px;', '<xsl:value-of select="$customerTitle"/>','<xsl:value-of select="$override-sub-product-code"/>');return false;</xsl:with-param>
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="$button-type='system-customers-entity'"> 
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_ENTITY</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="onclick">misys.showEntityDialog('entity',"['company_id','customer_abbv_name<xsl:value-of select="$call-back-customer-field-post-name"/>','customer_entity','customer_name']", '', 'CUSTOMER', '', '', '', '<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$entityTitle"/>','<xsl:value-of select="$override-sub-product-code"/>', null, null, null, 'Y');return false;</xsl:with-param>
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="$button-type='bank-entity'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_ENTITY</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="onclick">misys.showEntityDialog('entity', "['company_id','<xsl:value-of select="$prefix"/>_abbv_name','entity','<xsl:value-of select="$prefix"/>_name','<xsl:value-of select="$prefix"/>_address_line_1','<xsl:value-of select="$prefix"/>_address_line_2','<xsl:value-of select="$prefix"/>_dom']",'<xsl:value-of select="product_code"/>','CUSTOMER','','', '', '<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$entityTitle"/>','<xsl:value-of select="$override-sub-product-code"/>');return false; </xsl:with-param>
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="$button-type='bank-beneficiary' or $button-type='bank-drawee'">
     <xsl:variable name="prefix">
      <xsl:choose>
       <xsl:when test="$button-type='bank-beneficiary'">beneficiary</xsl:when>
       <xsl:when test="$button-type='bank-drawee'">drawee</xsl:when>
      </xsl:choose>
     </xsl:variable>
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_BENEFICIARY</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
   <xsl:with-param name="onclick">misys.showEntityDialog('entity', "['company_id','<xsl:value-of select="$prefix"/>_abbv_name','entity','<xsl:value-of select="$prefix"/>_name','<xsl:value-of select="$prefix"/>_address_line_1','<xsl:value-of select="$prefix"/>_address_line_2','<xsl:value-of select="$prefix"/>_dom','<xsl:value-of select="$prefix"/>_reference' ]",'<xsl:value-of select="$product-code"/>','CUSTOMER','','','','<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$entityTitle"/>','<xsl:value-of select="$override-sub-product-code"/>');return false;</xsl:with-param>
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
   <xsl:when test="$button-type='entity-basic'">
     <xsl:call-template name="button-wrapper">
	      <xsl:with-param name="label">XSL_ALT_ENTITY</xsl:with-param>
	      <xsl:with-param name="show-image">Y</xsl:with-param>
	      <xsl:with-param name="show-border">N</xsl:with-param>
	      <xsl:with-param name="onclick">
	      <xsl:choose>
	      <xsl:when test ="sub_product_code='BILLP' or sub_product_code='BILLS' or payee_code!=''">
	      misys.showEntityDialog('entity', "['entity']",'FT','USER', '<xsl:value-of select="$override_company_abbv_name"/>', '<xsl:value-of select="payee_code"/>', '', '<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$entityTitle"/>','<xsl:value-of select="$override-sub-product-code"/>');return false;
	     </xsl:when>
	     <xsl:otherwise>
	     misys.showEntityDialog('entity', "['entity']",'<xsl:value-of select="$product-code"/>','USER', '', '', '', '<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$entityTitle"/>','<xsl:value-of select="$override-sub-product-code"/>');return false;
	     </xsl:otherwise>
	     </xsl:choose>
	     </xsl:with-param>
	      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
	      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="$button-type='entity-basic-company'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_ENTITY</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="onclick">misys.showEntityDialog('entity', "['entity']",'<xsl:value-of select="$product-code"/>','COMPANY', '', '', '', '<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$entityTitle"/>','<xsl:value-of select="$override-sub-product-code"/>');return false;</xsl:with-param>
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="$button-type='summary-details'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_VIEW_TRANSACTION_DETAILS</xsl:with-param>
      <xsl:with-param name="onclick">misys.popup.showReporting('DETAILS', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="ref_id"/>');return false;</xsl:with-param>
      <xsl:with-param name="id">img_view_full_details</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($previewImage)"/></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="$button-type='crossref-summary'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_VIEW_TRANSACTION_DETAILS</xsl:with-param>
      <xsl:with-param name="onclick">misys.popup.showReporting('SUMMARY', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="ref_id"/>', '<xsl:value-of select="cross_references/cross_reference[type_code='01']/tnx_id"/>');return false;</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="id">img_view_full_details</xsl:with-param>
      <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($previewImage)"/></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    
     <xsl:when test="$button-type='cross-ref-updated'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_VIEW_TRANSACTION_DETAILS</xsl:with-param>
      <xsl:with-param name="onclick">misys.popup.showReporting('UPDATED', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="ref_id"/>', '<xsl:value-of select="cross_references/cross_reference[type_code='01']/tnx_id"/>');return false;</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="id">img_view_full_details</xsl:with-param>
      <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($previewImage)"/></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    
    
     <xsl:when test="$button-type='crossref-full'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_VIEW_TRANSACTION_DETAILS</xsl:with-param>
      <xsl:with-param name="onclick">misys.popup.showReporting('FULL', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="ref_id"/>', '<xsl:value-of select="cross_references/cross_reference[type_code='01']/tnx_id"/>');return false;</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="id">img_view_full_details</xsl:with-param>
      <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($previewImage)"/></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when> 
    
    <xsl:when test="$button-type='crossref-full-resubmission'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_VIEW_TRANSACTION_DETAILS</xsl:with-param>
      <xsl:with-param name="onclick">misys.popup.showReporting('FULL', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="ref_id"/>', '<xsl:value-of select="cross_references/cross_reference[type_code='03']/tnx_id"/>');return false;</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="id">img_view_full_details</xsl:with-param>
      <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($previewImage)"/></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    
    
     <xsl:when test="$button-type='transaction-list'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_TRANSACTION_SEARCH</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
	  <xsl:with-param name="onclick">misys.showSearchTransactionsDialog('<xsl:value-of select="company_id"/>','<xsl:value-of select="product_code"/>', '<xsl:value-of select="ref_id"/>');</xsl:with-param>
	  <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
	  <xsl:with-param name="non-dijit-button">N</xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="$button-type='drawee_details_bank'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_BANK</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="onclick">misys.showDraweeDialog('bank', '',"['<xsl:value-of select="$button-type"/>_name', '<xsl:value-of select="$button-type"/>_address_line_1', '<xsl:value-of select="$button-type"/>_address_line_2', '<xsl:value-of select="$button-type"/>_dom', '<xsl:value-of select="$button-type"/>_iso_code']", '<xsl:value-of select="$bankTitle"/>');return false;</xsl:with-param>
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="$button-type='summary-full'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_VIEW_TRANSACTION_DETAILS</xsl:with-param>
      <xsl:with-param name="onclick">misys.popup.showReporting('FULL', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="ref_id"/>', '<xsl:value-of select="tnx_id"/>');return false;</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="id">img_view_full_details</xsl:with-param>
      <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($previewImage)"/></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <!-- Summary buttons -->
    <xsl:when test="$button-type='summary'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_VIEW_TRANSACTION_DETAILS</xsl:with-param>
      <xsl:with-param name="onclick">misys.popup.showReporting('SUMMARY', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="ref_id"/>', '<xsl:value-of select="tnx_id"/>');return false;</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="id">img_view_full_details</xsl:with-param>
      <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($previewImage)"/></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="$button-type='document'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_PREVIEW_COLL_LETTER</xsl:with-param>
      <xsl:with-param name="onclick">misys.popup.showSummary('export', 'PDF_EC_DETAILS', '<xsl:value-of select="ref_id"/>','<xsl:value-of select="tnx_id"/>','EC'); return false;</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($printPreviewImage)"/></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="$button-type='download-static-document'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_TITLE_DOCUMENT_DOWNLOAD</xsl:with-param>
      <xsl:with-param name="onclick">misys.downloadStaticDocument('document_id'); return false;</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($printPreviewImage)"/></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="$button-type='remove-item'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_REMOVE_ITEM</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($deleteImage)"/></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
      <xsl:with-param name="dojo-attach-event">onclick: removeItem</xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="$button-type='report-language'">
     <a id="display_displayed_column_labels">
		<img border="0">
		    <xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($addImage)"/></xsl:attribute>
			<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_DISPLAY_OTHER_LANGUAGES')"/></xsl:attribute>
		</img>
	 </a>
	 <a id="hide_displayed_column_labels" style="display:none">
		<img border="0">
		    <xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($removeImage)"/></xsl:attribute>
			<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_HIDE_OTHER_LANGUAGES')"/></xsl:attribute>
		</img>
	 </a>
    </xsl:when>
    <xsl:when test="$button-type='report-parameter'">
     <a id="display_parameter_labels">
		<img border="0">
			<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($addImage)"/></xsl:attribute>
			<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_DISPLAY_OTHER_LANGUAGES')"/></xsl:attribute>
		</img>
	 </a>
	 <a id="hide_parameter_labels" style="display:none">
		<img border="0">
			<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($removeImage)"/></xsl:attribute>
			<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_HIDE_OTHER_LANGUAGES')"/></xsl:attribute>
		</img>
	 </a>
    </xsl:when>
    <xsl:when test="$button-type='report-aggregate'">
     <a id="display_aggregate_labels">
		<img border="0">
			<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($addImage)"/></xsl:attribute>
			<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_DISPLAY_OTHER_LANGUAGES')"/></xsl:attribute>
		</img>
	 </a>
	 <a id="hide_aggregate_labels" style="display:none">
		<xsl:attribute name="style">display:none</xsl:attribute>
		<img border="0">
			<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($removeImage)"/></xsl:attribute>
			<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORT_HIDE_OTHER_LANGUAGES')"/></xsl:attribute>
		</img>
	 </a>
    </xsl:when>
    <!-- Used by Cash Module in the account popup (Search Button) -->
    <xsl:when test="$button-type='account_search_popup'">
    	<xsl:call-template name="button-wrapper">
			<xsl:with-param name="label">XSL_ACCOUNT_SEARCH</xsl:with-param>
			<xsl:with-param name="show-image">Y</xsl:with-param>
			<xsl:with-param name="show-border">N</xsl:with-param>
			<!-- The search function has to be define in the binding js file -->
			<!-- because we can have several tables and several search fields -->
			<xsl:with-param name="onclick">fncFilteringAccount('<xsl:value-of select="$id"/>');</xsl:with-param>
			<xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
			<xsl:with-param name="non-dijit-button">N</xsl:with-param>
		</xsl:call-template>
	</xsl:when>
    <!-- TO FINISH -->

    <!-- Buttons for the bank side only -->
    
    <xsl:when test="$button-type='bank-applicant'">
     <xsl:variable name="prefix">applicant</xsl:variable>
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_BENEFICIARY</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="onclick">misys.showEntityDialog('entity', "['company_id','<xsl:value-of select="$prefix"/>_abbv_name','entity','<xsl:value-of select="$prefix"/>_name','<xsl:value-of select="$prefix"/>_address_line_1','<xsl:value-of select="$prefix"/>_address_line_2','<xsl:value-of select="$prefix"/>_dom' ]",'<xsl:value-of select="$product-code"/>','CUSTOMER','','','','<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$entityTitle"/>','<xsl:value-of select="$override-sub-product-code"/>');return false;</xsl:with-param>
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    
    <!-- Summit START -->
    <xsl:when test="$button-type='summit-summary-full'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_VIEW_TRANSACTION_DETAILS</xsl:with-param>
      <xsl:with-param name="onclick">fncSummitShowReporting('FULL', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="bo_ref_id"/>', 'SummitReportingPopup');return false;</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="id">img_view_full_details</xsl:with-param>
      <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($previewImage)"/></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
	<!-- Summit END -->
	<!-- Summit START -->
    <xsl:when test="$button-type='mc-master-details'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_VIEW_TRANSACTION_DETAILS</xsl:with-param>
      <xsl:with-param name="onclick">misys.popup.showMaster();return false;</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="id">img_view_full_details</xsl:with-param>
      <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($previewImage)"/></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <!-- Summit END -->    
    <xsl:when test="$button-type='amend-summary-details'">
	     <xsl:call-template name="button-wrapper">
	      <xsl:with-param name="label">XSL_ALT_VIEW_COMPARE_DETAILS</xsl:with-param>
	      <xsl:with-param name="onclick">misys.popup.showReporting('FULL', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="ref_id"/>', '<xsl:value-of select="tnx_id"/>');return false;</xsl:with-param>
	      <xsl:with-param name="id">img_view_compare_details</xsl:with-param>
	      <xsl:with-param name="show-image">Y</xsl:with-param>
	      <xsl:with-param name="show-border">N</xsl:with-param>
	      <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($compareImage)"/></xsl:with-param>
	      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
	     </xsl:call-template>
	</xsl:when>  
	
	<!-- FSCM Program Code -->	
	<xsl:when test="$button-type='fscm_programme'">
		<xsl:choose>
			<xsl:when test="$product-code ='IN' or $product-code ='IP'">
				<xsl:call-template name="button-wrapper">
			      <xsl:with-param name="label">XSL_ALT_PROGRAMME</xsl:with-param>
			      <xsl:with-param name="onclick">misys.showSearchFSCMProgramDialog('fscmprogram', "['program_name', '<xsl:value-of select="$prefix"/>_code', 'program_id']", 'width:750px;height:400px;', '<xsl:value-of select="localization:getGTPString($language, 'OpenBankCustomerFscmProgramListBSF')"/>', {product_code: '<xsl:value-of select="product_code"/>'}, '', '');return false;</xsl:with-param>
			      <xsl:with-param name="show-image">Y</xsl:with-param>
			      <xsl:with-param name="show-border">N</xsl:with-param>
			      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
		     	</xsl:call-template>
			</xsl:when>
			<xsl:when test="$product-code ='CN' or $product-code ='CR'">
				<xsl:call-template name="button-wrapper">
			      <xsl:with-param name="label">XSL_ALT_PROGRAMME</xsl:with-param>
			      <xsl:with-param name="onclick">misys.showSearchFSCMProgramDialog('cn_fscm_programs', "['program_name', '<xsl:value-of select="$prefix"/>_code', 'program_id']", 'width:750px;height:400px;', '<xsl:value-of select="localization:getGTPString($language, 'OpenBankCustomerFscmProgramListBSF')"/>', {product_code: '<xsl:value-of select="product_code"/>'}, '', '');return false;</xsl:with-param>
			      <xsl:with-param name="show-image">Y</xsl:with-param>
			      <xsl:with-param name="show-border">N</xsl:with-param>
			      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
		     	</xsl:call-template>
			</xsl:when>
		</xsl:choose>
    </xsl:when> 
   </xsl:choose>
   </xsl:if>
   <xsl:if test="$override-displaymode='view'">
   <xsl:choose>
    <xsl:when test="$button-type='narrative_amend_goods_view' or $button-type='narrative_amend_docs_view' or $button-type='narrative_amend_instructions_view' or $button-type='narrative_amend_sp_beneficiary_view' or $button-type='narrative_amend_sp_recvbank_view'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">AMEND_NARRATIVE_BUTTON_LABEL</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($extendedViewImage)"/></xsl:with-param>
      <xsl:with-param name="onclick">misys.viewNarrativeInPopUp('<xsl:value-of select="$button-type"/>','<xsl:value-of select="$messageValue"/>', '<xsl:value-of select="$widget-name" />', '<xsl:value-of select="$override-product-code"/>', '<xsl:value-of select="$overrideDimensions"/>', '<xsl:value-of select="$extendedTitle"/>', '<xsl:value-of select="$amendment-no"/>');return false;</xsl:with-param>
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button">N</xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="$button-type='extended-narrative'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">TABLE_SUMMARY_EXTENDED_NARRATIVE</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($extendedViewImage)"/></xsl:with-param>
      <xsl:with-param name="onclick">misys.showExtendedNarrativeView('<xsl:value-of select="$button-type"/>','<xsl:value-of select="$override-product-code"/>','<xsl:value-of select="$extendedTitle"/>','<xsl:value-of select="securityUtils:encodeHTML($messageValue)"/>','<xsl:value-of select="$widget-name"/>');return false;</xsl:with-param>
      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_ext_img</xsl:if></xsl:with-param>
      <xsl:with-param name="non-dijit-button">Y</xsl:with-param>
     </xsl:call-template>
    </xsl:when> 
	   <xsl:when test="$button-type='crossref-full-amendment'">
	     	<xsl:call-template name="button-wrapper">
		      <xsl:with-param name="label">XSL_ALT_VIEW_TRANSACTION_DETAILS</xsl:with-param>
		      <xsl:with-param name="onclick">misys.popup.showReporting('FULL', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="ref_id"/>');return false;</xsl:with-param>
		      <xsl:with-param name="show-image">Y</xsl:with-param>
		      <xsl:with-param name="show-border">N</xsl:with-param>
		      <xsl:with-param name="id">img_view_full_details</xsl:with-param>
		      <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($previewImage)"/></xsl:with-param>
		      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
	     	</xsl:call-template>
    	</xsl:when> 
	    <xsl:when test="$button-type='amend-summary-details'">
	     <xsl:call-template name="button-wrapper">
	      <xsl:with-param name="label">XSL_ALT_VIEW_COMPARE_DETAILS</xsl:with-param>
	      <xsl:with-param name="onclick">misys.popup.showReporting('FULL', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="ref_id"/>', '<xsl:value-of select="tnx_id"/>');return false;</xsl:with-param>
	      <xsl:with-param name="id">img_view_compare_details</xsl:with-param>
	      <xsl:with-param name="show-image">Y</xsl:with-param>
	      <xsl:with-param name="show-border">N</xsl:with-param>
	      <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($compareImage)"/></xsl:with-param>
	      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
	     </xsl:call-template>
	    </xsl:when>       
	<xsl:when test="$button-type='crossref-summary'">
	<xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_VIEW_TRANSACTION_DETAILS456</xsl:with-param>
      <xsl:with-param name="onclick">misys.popup.showReporting('SUMMARY', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="ref_id"/>', '<xsl:value-of select="cross_references/cross_reference[type_code='01']/tnx_id"/>');return false;</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="id">img_view_full_details</xsl:with-param>
      <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($previewImage)"/></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="$button-type='crossref-full'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_VIEW_TRANSACTION_DETAILS</xsl:with-param>
      <xsl:with-param name="onclick">misys.popup.showReporting('FULL', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="ref_id"/>', '<xsl:value-of select="cross_references/cross_reference[type_code='01']/tnx_id"/>');return false;</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="id">img_view_full_details</xsl:with-param>
      <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($previewImage)"/></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when> 
     <xsl:when test="$button-type='cross-ref-updated'">
     <xsl:call-template name="button-wrapper">
      <xsl:with-param name="label">XSL_ALT_VIEW_TRANSACTION_DETAILS</xsl:with-param>
      <xsl:with-param name="onclick">misys.popup.showReporting('UPDATED', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="ref_id"/>', '<xsl:value-of select="cross_references/cross_reference[type_code='01']/tnx_id"/>');return false;</xsl:with-param>
      <xsl:with-param name="show-image">Y</xsl:with-param>
      <xsl:with-param name="show-border">N</xsl:with-param>
      <xsl:with-param name="id">img_view_full_details</xsl:with-param>
      <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($previewImage)"/></xsl:with-param>
      <xsl:with-param name="non-dijit-button"><xsl:value-of select="$non-dijit-button"/></xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    </xsl:choose>
   </xsl:if>
  </xsl:template>
  
  <!--
   HTML img for an MTP button (i.e. main menu buttons, and search/pop-up window buttons)
  
   ** Notes **
   1. The default image src is set to search.png, since this is the most common icon used.
   ***********
   
   TODO Refactor
  -->
  <xsl:template name="button-wrapper">
   <xsl:param name="label"/>
   <xsl:param name="id"/>
   <xsl:param name="onclick"/>
   <xsl:param name="img-src"><xsl:value-of select="utils:getImagePath($searchImage)"/></xsl:param>
   <xsl:param name="img-width"></xsl:param>
   <xsl:param name="img-height"></xsl:param>
   <xsl:param name="show-text-label">N</xsl:param>
   <xsl:param name="show-image">N</xsl:param>
   <xsl:param name="non-dijit-button">N</xsl:param>
   <xsl:param name="show-border">Y</xsl:param>
   <xsl:param name="disabled">N</xsl:param>
   <xsl:param name="dojo-attach-event"/>
   <xsl:param name="class"/>
   
   <button type="button">
    <xsl:if test="$non-dijit-button='N'"><xsl:attribute name="dojoType">dijit.form.Button</xsl:attribute></xsl:if>
    <xsl:if test="$onclick!=''"><xsl:attribute name="onclick"><xsl:value-of select="$onclick"/></xsl:attribute></xsl:if>
    <xsl:if test="$dojo-attach-event!=''"><xsl:attribute name="dojoAttachEvent"><xsl:value-of select="$dojo-attach-event"/></xsl:attribute></xsl:if>
    <xsl:if test="$id!=''"><xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute></xsl:if>
    <xsl:if test="$disabled='Y'"><xsl:attribute name="disabled">true</xsl:attribute></xsl:if>
    <xsl:attribute name="class">noprint <xsl:if test="$show-border='N'">noborder </xsl:if> <xsl:if test="$show-image='Y'">imgButton </xsl:if><xsl:value-of select="$class"/></xsl:attribute>
    <xsl:if test="$show-image='Y'">
     <img>
      <xsl:attribute name="src"><xsl:value-of select="$img-src"/></xsl:attribute>
      <xsl:if test="$img-width != ''">
      	<xsl:attribute name="width"><xsl:value-of select="$img-width"/></xsl:attribute>
      </xsl:if>
      <xsl:if test="$img-height != ''">
      	<xsl:attribute name="height"><xsl:value-of select="$img-height"/></xsl:attribute>
      </xsl:if>
      <xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, $label)"/></xsl:attribute>
      <xsl:attribute name="title"><xsl:value-of select="localization:getGTPString($language, $label)"/></xsl:attribute>
     </img>
    </xsl:if>
    <xsl:if test="$show-text-label='Y'">
     <xsl:value-of select="localization:getGTPString($language, $label)"/>
    </xsl:if>
   </button>
  </xsl:template>
  
  <!--
   Wraps a DIV around some content
  -->
  <xsl:template name="label-wrapper">
   <xsl:param name="label"/>
   <xsl:param name="content"/>
   <xsl:param name="label-class"/> <!-- Additional class for this label -->
   <xsl:if test="$content!=''">
	    <div>
	    
		     <xsl:attribute name="class">
			      <xsl:choose>
				       <xsl:when test="$label-class != ''">field <xsl:value-of select="$label-class"/></xsl:when>
				       <xsl:otherwise>field</xsl:otherwise>
			      </xsl:choose>
		     </xsl:attribute>  
		     <span class="label">
		     <xsl:if test="$rundata!='' ">
		     	<xsl:call-template name="localization-dblclick">
					<xsl:with-param name="xslName" select="$label" />
					<xsl:with-param name="localName" select="localization:getGTPString($rundata, $language, $label)" />
			</xsl:call-template>
			</xsl:if>
			<xsl:choose>
	 			<xsl:when test="$rundata!='' ">
	 				<xsl:value-of select="localization:getGTPString($rundata,$language, $label)"/>
	 			</xsl:when>
		   		<xsl:otherwise>
		   			<xsl:value-of select="localization:getGTPString($language, $label)"/>
		   		</xsl:otherwise>
		  	</xsl:choose>&nbsp;</span>	
		     <xsl:copy-of select="$content"/>
	    </div>
   </xsl:if>
  </xsl:template>

	<!-- server message-->
	<xsl:template name="server-message">
		<xsl:param name="name"/>
		<xsl:param name="id" select="$name"/>
		<xsl:param name="appendClass"/>
		<xsl:param name="content"/>
		<xsl:param name="show-close">Y</xsl:param>
		<xsl:param name="timeout">999</xsl:param>
		<xsl:if test="$content!=''">
			<div>
				<xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
				<xsl:attribute name="class"><xsl:value-of select="$appendClass"/></xsl:attribute>
				<xsl:copy-of select="$content"/>
				<div style="float:right;">
					<a>
						<xsl:attribute name="onClick">misys.animate('fadeOut','<xsl:value-of select="$id"/>');</xsl:attribute>
						<img>
							<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($tabCloseHoverImage)"/></xsl:attribute>
						</img>
					</a>
				</div>
			</div>
		</xsl:if>
	</xsl:template>
 <!--
  ########################################################################
  The following three templates are for tabbed content. You need to provide
  the content for at least 2 tabs.
  ########################################################################
  -->
  <!--
   Displays a group of 3 (max) dynamic tabs. 
   -->
  <xsl:template name="tabgroup-wrapper">
  
  <xsl:param name="in-fieldset">Y</xsl:param><!-- Surrounds the content with a fieldset -->
  
   <!-- Required parameters -->
   <xsl:param name="tabgroup-label"/>
   <xsl:param name="tabgroup-height"/>
   <xsl:param name="toc-item">Y</xsl:param>
  
   <!-- Tab #0 Details -->
   <xsl:param name="tab0-label"/>
   <xsl:param name="tab0-content"/>
   
   <!-- Tab #1 Details -->
   <xsl:param name="tab1-label"/>
   <xsl:param name="tab1-content"/>
   
   <!-- Tab #2 Details -->
   <xsl:param name="tab2-label"/>
   <xsl:param name="tab2-content"/>
   
   <!-- Tab #3 Details -->
   <xsl:param name="tab3-label"/>
   <xsl:param name="tab3-content"/>
   
   <!--  Optionally set an unique ID -->
   <xsl:param name="tabgroup-id"/>
   
   <!-- Legend Type, toplevel or indented -->
   <xsl:param name="legend-type">toplevel-header</xsl:param>
   
   <!--  Whether to add the tabStrip background -->
   <xsl:param name="tabStrip">N</xsl:param>
   
   <!-- Additional content, included in the fieldset but appended after the tabgroup -->
   <xsl:param name="additional-content"></xsl:param>
   
   <xsl:choose>
   <xsl:when test="$in-fieldset = 'Y'">
   
	   <xsl:call-template name="fieldset-wrapper">
	    <xsl:with-param name="legend"><xsl:value-of select="$tabgroup-label"/></xsl:with-param>
	    <xsl:with-param name="legend-type"><xsl:value-of select="$legend-type"/></xsl:with-param>
	     <xsl:with-param name="toc-item"><xsl:value-of select="$toc-item"/></xsl:with-param>
	    <xsl:with-param name="content">
	     
	     	<xsl:call-template name="tabgroup-content">
	     		 <!-- Required parameters -->
				<xsl:with-param name="tabgroup-height"><xsl:value-of select="$tabgroup-height"/></xsl:with-param>
			  
			   <xsl:with-param name="tab0-label" ><xsl:value-of select="$tab0-label"/></xsl:with-param>
			   <xsl:with-param name="tab0-content" ><xsl:copy-of  select="$tab0-content"/></xsl:with-param>
			   
			   <xsl:with-param name="tab1-label" ><xsl:value-of select="$tab1-label"/></xsl:with-param>
			   <xsl:with-param name="tab1-content" ><xsl:copy-of  select="$tab1-content"/></xsl:with-param>
			   
			   <xsl:with-param name="tab2-label" ><xsl:value-of select="$tab2-label"/></xsl:with-param>
			   <xsl:with-param name="tab2-content" ><xsl:copy-of  select="$tab2-content"/></xsl:with-param>
			   
			   <xsl:with-param name="tab3-label" ><xsl:value-of select="$tab3-label"/></xsl:with-param>
			   <xsl:with-param name="tab3-content" ><xsl:copy-of  select="$tab3-content"/></xsl:with-param>
			   
			   <xsl:with-param name="tabgroup-id" ><xsl:value-of select="$tabgroup-id"/></xsl:with-param>
			   
			   <xsl:with-param name="tabStrip" ><xsl:value-of select="$tabStrip"/></xsl:with-param>
			   
			   <xsl:with-param name="additional-content" ><xsl:copy-of select="$additional-content"/></xsl:with-param>
   
	     	</xsl:call-template>
	     
	    </xsl:with-param>
	   </xsl:call-template>
   
   </xsl:when>
   <xsl:otherwise>
   	     	<xsl:call-template name="tabgroup-content">
	     		 <!-- Required parameters -->
				<xsl:with-param name="tabgroup-height"><xsl:value-of select="$tabgroup-height"/></xsl:with-param>
			  
			   <xsl:with-param name="tab0-label" ><xsl:value-of select="$tab0-label"/></xsl:with-param>
			   <xsl:with-param name="tab0-content" ><xsl:copy-of  select="$tab0-content"/></xsl:with-param>
			   
			   <xsl:with-param name="tab1-label" ><xsl:value-of select="$tab1-label"/></xsl:with-param>
			   <xsl:with-param name="tab1-content" ><xsl:copy-of  select="$tab1-content"/></xsl:with-param>
			   
			   <xsl:with-param name="tab2-label" ><xsl:value-of select="$tab2-label"/></xsl:with-param>
			   <xsl:with-param name="tab2-content" ><xsl:copy-of  select="$tab2-content"/></xsl:with-param>
			   
			   <xsl:with-param name="tab3-label" ><xsl:value-of select="$tab3-label"/></xsl:with-param>
			   <xsl:with-param name="tab3-content" ><xsl:copy-of  select="$tab3-content"/></xsl:with-param>
			   
			   <xsl:with-param name="tabgroup-id" ><xsl:value-of select="$tabgroup-id"/></xsl:with-param>
   
   				<xsl:with-param name="additional-content" ><xsl:copy-of select="$additional-content"/></xsl:with-param>
	     	</xsl:call-template>
   </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
  
  <xsl:template name="tabgroup-content">
     <!-- Required parameters -->
	<xsl:param name="tabgroup-height"/>
  
   <!-- Tab #0 Details -->
   <xsl:param name="tab0-label"/>
   <xsl:param name="tab0-content"/>
   
   <!-- Tab #1 Details -->
   <xsl:param name="tab1-label"/>
   <xsl:param name="tab1-content"/>
   
   <!-- Tab #2 Details -->
   <xsl:param name="tab2-label"/>
   <xsl:param name="tab2-content"/>
   
   <!-- Tab #3 Details -->
   <xsl:param name="tab3-label"/>
   <xsl:param name="tab3-content"/>
   
   <!--  Optionally set an unique ID -->
   <xsl:param name="tabgroup-id"/>
   
   <!-- Optionally set the tabStrip background beneath the tabs -->
   <xsl:param name="tabStrip">N</xsl:param>

   <!-- Additional content, included in the fieldset but appended after the tabgroup -->
   <xsl:param name="additional-content"></xsl:param>

   <xsl:choose>
      <xsl:when test="$displaymode='edit'">
       <div dojoType="dijit.layout.TabContainer" class="tabcontainer">
       		<xsl:if test="$tabStrip = 'Y'">
       			<xsl:attribute name="tabStrip">true</xsl:attribute>
       		</xsl:if>
	        <xsl:if test="$tabgroup-id != ''">
	         	<xsl:attribute name="id"><xsl:value-of select="$tabgroup-id"/></xsl:attribute>
	        </xsl:if>
	        <xsl:if test="$tabgroup-height != ''">
	         	<xsl:attribute name="style">height:<xsl:value-of select="$tabgroup-height"/></xsl:attribute>
	        </xsl:if>
	        <xsl:if test="$tab0-label != ''">
		        <div dojoType="dijit.layout.ContentPane" selected="true" class="tabContentDiv">
		         	<xsl:attribute name="title">
		         	<xsl:choose>
			 			<xsl:when test="$rundata!='' ">
			 				<xsl:value-of select="localization:getGTPString($rundata,$language, $tab0-label)"/>
			 			</xsl:when>
				   		<xsl:otherwise>
				   			<xsl:value-of select="localization:getGTPString($language, $tab0-label)"/>
				   		</xsl:otherwise>
				  	</xsl:choose>
				  	</xsl:attribute>
				  	 <xsl:if test="$rundata!='' ">
		         	<xsl:call-template name="localization-button">
						<xsl:with-param name="xslName" select="$tab0-label" />
						<xsl:with-param name="localName" select="localization:getGTPString($rundata,$language, $tab0-label)" />
					</xsl:call-template>
					</xsl:if>
		         	<xsl:copy-of select="$tab0-content"/>
		        </div>
	        </xsl:if>
	        <xsl:if test="$tab1-label != ''">
		        <div dojoType="dijit.layout.ContentPane" class="tabContentDiv">
		         	<xsl:attribute name="title">
		         	<xsl:choose>
			 			<xsl:when test="$rundata!='' ">
			 				<xsl:value-of select="localization:getGTPString($rundata,$language, $tab1-label)"/>
			 			</xsl:when>
				   		<xsl:otherwise>
				   			<xsl:value-of select="localization:getGTPString($language, $tab1-label)"/>
				   		</xsl:otherwise>
				  	</xsl:choose>
		         	</xsl:attribute>
		        	 <xsl:call-template name="localization-button">
						<xsl:with-param name="xslName" select="$tab1-label" />
						<xsl:with-param name="localName"
							select="localization:getGTPString($language, $tab1-label)" />
					</xsl:call-template>
		        	 <xsl:copy-of select="$tab1-content"/>
		        </div>
	        </xsl:if>
	        <xsl:if test="$tab2-label != ''">
	         	<div dojoType="dijit.layout.ContentPane" class="tabContentDiv">
	          		<xsl:attribute name="title">
	          		<xsl:choose>
			 			<xsl:when test="$rundata!='' ">
			 				<xsl:value-of select="localization:getGTPString($rundata,$language, $tab2-label)"/>
			 			</xsl:when>
				   		<xsl:otherwise>
				   			<xsl:value-of select="localization:getGTPString($language, $tab2-label)"/>
				   		</xsl:otherwise>
				  	</xsl:choose>
					</xsl:attribute>
					 <xsl:if test="$rundata!='' ">
	          		<xsl:call-template name="localization-button">
						<xsl:with-param name="xslName" select="$tab2-label" />
						<xsl:with-param name="localName" select="localization:getGTPString($rundata,$language, $tab2-label)" />
					</xsl:call-template>
					</xsl:if>
	          		<xsl:copy-of select="$tab2-content"/>
	            </div>
	        </xsl:if>
	        <xsl:if test="$tab3-label != ''">
	         	<div dojoType="dijit.layout.ContentPane" class="tabContentDiv">
	          		<xsl:attribute name="title">
					<xsl:choose>
			 			<xsl:when test="$rundata!='' ">
			 				<xsl:value-of select="localization:getGTPString($rundata,$language, $tab3-label)"/>
			 			</xsl:when>
				   		<xsl:otherwise>
				   			<xsl:value-of select="localization:getGTPString($language, $tab3-label)"/>
				   		</xsl:otherwise>
				  	</xsl:choose>
					</xsl:attribute>
					 <xsl:if test="$rundata!='' ">
		          	<xsl:call-template name="localization-button">
						<xsl:with-param name="xslName" select="$tab3-label" />
						<xsl:with-param name="localName" select="localization:getGTPString($rundata,$language, $tab3-label)" />
					</xsl:call-template>
					 </xsl:if>
	          		<xsl:copy-of select="$tab3-content"/>
	            </div>
	        </xsl:if>
       </div>
      </xsl:when>
      <xsl:otherwise>
       <xsl:if test="$tab0-content!=''">
        <div class="indented-header">
         <h3 class="toc-item">
          <span class="legend"><xsl:choose>
			 			<xsl:when test="$rundata!='' ">
			 				<xsl:value-of select="localization:getGTPString($rundata,$language, $tab0-label)"/>
			 			</xsl:when>
				   		<xsl:otherwise>
				   			<xsl:value-of select="localization:getGTPString($language, $tab0-label)"/>
				   		</xsl:otherwise>
				  	</xsl:choose></span>
         </h3>
         <xsl:copy-of select="$tab0-content"/>
        </div>
       </xsl:if>
       <xsl:if test="$tab1-content!=''">
        <div class="indented-header">
          <h3 class="toc-item">
           <span class="legend"><xsl:choose>
			 			<xsl:when test="$rundata!='' ">
			 				<xsl:value-of select="localization:getGTPString($rundata,$language, $tab1-label)"/>
			 			</xsl:when>
				   		<xsl:otherwise>
				   			<xsl:value-of select="localization:getGTPString($language, $tab1-label)"/>
				   		</xsl:otherwise>
				  	</xsl:choose></span>
          </h3>
          <xsl:copy-of select="$tab1-content"/>
        </div>
       </xsl:if>
       <xsl:if test="$tab2-content!=''">
        <div class="indented-header">
          <h3 class="toc-item">
           <span class="legend"><xsl:choose>
			 			<xsl:when test="$rundata!='' ">
			 				<xsl:value-of select="localization:getGTPString($rundata,$language, $tab2-label)"/>
			 			</xsl:when>
				   		<xsl:otherwise>
				   			<xsl:value-of select="localization:getGTPString($language, $tab2-label)"/>
				   		</xsl:otherwise>
				  	</xsl:choose></span>
          </h3>
          <xsl:copy-of select="$tab2-content"/>
        </div>
       </xsl:if>
       <xsl:if test="$tab3-content!=''">
        <div class="indented-header">
          <h3 class="toc-item">
           <span class="legend"><xsl:choose>
			 			<xsl:when test="$rundata!='' ">
			 				<xsl:value-of select="localization:getGTPString($rundata,$language, $tab3-label)"/>
			 			</xsl:when>
				   		<xsl:otherwise>
				   			<xsl:value-of select="localization:getGTPString($language, $tab3-label)"/>
				   		</xsl:otherwise>
				  	</xsl:choose></span>
          </h3>
          <xsl:copy-of select="$tab3-content"/>
        </div>
       </xsl:if>
      </xsl:otherwise>
     </xsl:choose>
     <xsl:copy-of select="$additional-content"/>
  </xsl:template>
  
  <!-- 
   A dijit dialog
   -->
  <xsl:template name="dialog">
   <xsl:param name="content"/>
   <xsl:param name="buttons"/>
   <xsl:param name="title"/>
   <xsl:param name="validate">N</xsl:param>
   
   <!-- optional -->
   <xsl:param name="id"/>
   <xsl:param name="show">Y</xsl:param>

   <div dojoType="misys.widget.Dialog" refocus="false" draggable="false">
    <xsl:attribute name="title"><xsl:value-of select="$title"/></xsl:attribute>
    <xsl:if test="$id != ''">
     	<xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="$show = 'N'">
     	<xsl:attribute name="style">display:none</xsl:attribute>
    </xsl:if>
    <xsl:if test="$validate = 'Y'">
     	<xsl:attribute name="class">validate</xsl:attribute>
    </xsl:if>
    
    <div class="dijitDialogPaneContentArea">
     	<xsl:copy-of select="$content"/>
    </div>
    <div class="dijitDialogPaneActionBar">
     	<xsl:copy-of select="$buttons"/>
    </div>
   </div>
  </xsl:template>
  
  <!-- 
   A dijit noCloseDialog
   -->
  <xsl:template name="no-close-dialog">
   <xsl:param name="content"/>
   <xsl:param name="buttons"/>
   <xsl:param name="title"/>
   <xsl:param name="validate">N</xsl:param>
   
   <!-- optional -->
   <xsl:param name="id"/>
   <xsl:param name="show">Y</xsl:param>

   <div dojoType="misys.widget.NoCloseDialog" refocus="false" draggable="false">
    <xsl:attribute name="title"><xsl:value-of select="$title"/></xsl:attribute>
    <xsl:if test="$id != ''">
     	<xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
    </xsl:if>
    <xsl:if test="$show = 'N'">
     	<xsl:attribute name="style">display:none</xsl:attribute>
    </xsl:if>
    <xsl:if test="$validate = 'Y'">
     	<xsl:attribute name="class">validate</xsl:attribute>
    </xsl:if>
    
    <div class="dijitDialogPaneContentArea">
     	<xsl:copy-of select="$content"/>
    </div>
    <div class="dijitDialogPaneActionBar">
     	<xsl:copy-of select="$buttons"/>
    </div>
   </div>
  </xsl:template>
  
  <!--
   Floating Table of Contents 
   -->
  <xsl:template name="toc">
   <xsl:if test="$displaymode='edit' or ($displaymode = 'view' and $collaborationmode != 'none')">
    <div id="toc">
     <p><a href="javascript:void(0)" id="toggleTocLink"><xsl:value-of select="localization:getGTPString($language, 'FORM_SUMMARY_LINK')"/></a>&nbsp;|&nbsp;<a href="#" id="goto_body"><xsl:value-of select="localization:getGTPString($language, 'FORM_TOP_LINK')"/></a></p>
     <div id="toccontent" style="display:none;"/>
    </div>
   </xsl:if>
  </xsl:template>
  
  <!--
   Preloader 
   -->
  <xsl:template name="loading-message">
     <div id="loading-message">
       <p><xsl:value-of select="localization:getGTPString($language, 'LOADING_ALERT')"/></p>
       <div id="loadingProgressBar"></div>
     </div>
  </xsl:template>
   
  <xsl:template name="clearing-code-loader">
  		<script>
  		<xsl:variable name="swift_flag" select="defaultresource:getResource('OPICS_SWIFT_ENABLED')='true'"/>
  		<xsl:if test="$swift_flag='true'">
			dojo.ready(function(){
				misys._config = misys._config || {};
				
				
				misys._config.clearingCodes = misys._config.clearingCodes || 
					{
					<xsl:for-each select="//clearing_code_set/clearing_code">
							'<xsl:value-of select="code" />':'<xsl:value-of select="description" />'
							<xsl:if test="position()!=last()">,</xsl:if>
					</xsl:for-each>	
					};
							
				misys._config.swift_allowed = <xsl:value-of select="defaultresource:getResource('OPICS_SWIFT_ENABLED') = 'true'"/>;
				misys._config.opics_name_codeword = <xsl:value-of select="defaultresource:getResource('SWIFT_NAME_CODEWORD')"/>;
			});
			</xsl:if>
		</script>
  </xsl:template>
  
  <xsl:template name="left-trim">
  <xsl:param name="s" />
  <xsl:choose>
    <xsl:when test="substring($s, 1, 1) = ''">
      <xsl:value-of select="$s"/>
    </xsl:when>
    <xsl:when test="normalize-space(substring($s, 1, 1)) = ''">
      <xsl:call-template name="left-trim">
        <xsl:with-param name="s" select="substring($s, 2)" />
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$s" />
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="right-trim">
  <xsl:param name="s" />
  <xsl:choose>
    <xsl:when test="substring($s, 1, 1) = ''">
      <xsl:value-of select="$s"/>
    </xsl:when>
    <xsl:when test="normalize-space(substring($s, string-length($s))) = ''">
      <xsl:call-template name="right-trim">
        <xsl:with-param name="s" select="substring($s, 1, string-length($s) - 1)" />
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$s" />
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="trim">
  <xsl:param name="s" />
  <xsl:call-template name="right-trim">
    <xsl:with-param name="s">
      <xsl:call-template name="left-trim">
        <xsl:with-param name="s" select="$s" />
      </xsl:call-template>
    </xsl:with-param>
  </xsl:call-template>
</xsl:template>

<!-- 
    HTML Date & Term Code Input field
    Display a Date field followed by a fixed list of Term Codes & Static Codes
    When a Date is selected, Codes are disabled
    When a Term Code is selected, the Date field becomes mandatory and only accepts a numeric value range
    When a Static Code is selected, the Date field is disabled
 -->
<xsl:template name="input-date-term-field">
	<!-- Required param -->
	<xsl:param name="name"/>
	
	<xsl:param name="term-options"/> <!-- Raw html, listing the <option> tags for this element -->
	<xsl:param name="static-options"/> <!-- Raw html, listing the <option> tags for this element -->
	<xsl:param name="store"/> <!-- if set, the store is used to feed the selectbox ; options are ignored. -->
	
	<!-- Optional -->
	<xsl:param name="id" select="$name"/>
	<xsl:param name="label"/>
	<xsl:param name="required">N</xsl:param> <!-- Whether this is a mandatory field. -->
	<xsl:param name="hide-required-status">N</xsl:param>
	<xsl:param name="readonly">N</xsl:param>
	<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
	<xsl:param name="fieldsize">small</xsl:param> <!-- x-small, small, medium, large -->
	
	<xsl:param name="value" select="concat(//*[name()=concat($name, '_date')], //*[name()=concat($name, '_code')])" />
	<xsl:param name="date" select="//*[name()=concat($name, '_date')]" />
	<xsl:param name="code" select="//*[name()=concat($name, '_code')]" />

	<!-- HTML -->
	<xsl:if test="$displaymode='edit' or $date != '' or $code !=''">
		<xsl:call-template name="row-wrapper">
		    <xsl:with-param name="id" select="$name"/>
		    <xsl:with-param name="label" select="$label"></xsl:with-param>
		    <xsl:with-param name="required">
	    	<xsl:choose>
	    		<xsl:when test="$hide-required-status='Y'">N</xsl:when>
	    		<xsl:otherwise><xsl:value-of select="$required"/></xsl:otherwise>
	    	</xsl:choose>
	    	</xsl:with-param>   
		    <xsl:with-param name="content">
				<div dojoType="misys.form.DateTermField">
			        <xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
		       		<xsl:attribute name="fieldsize"><xsl:value-of select="$fieldsize"/></xsl:attribute>
	    		    <xsl:if test="$required='Y'"><xsl:attribute name="required">true</xsl:attribute></xsl:if>
	    		    <xsl:attribute name="displaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
					<xsl:if test="$readonly='Y'"><xsl:attribute name="readonly">true </xsl:attribute></xsl:if>
	    		    <xsl:attribute name="value"><xsl:value-of select="$value"/></xsl:attribute>
	    		    <xsl:attribute name="date"><xsl:value-of select="$date"/></xsl:attribute>
					<xsl:attribute name="code"><xsl:value-of select="$code"/></xsl:attribute>
	    		    <xsl:attribute name="store"><xsl:value-of select="$store"/></xsl:attribute>
					<!-- select tag has to be the first child of the div -->
					<select>
						<xsl:copy-of select="$term-options"/>
					</select>
					<select>
						<xsl:copy-of select="$static-options"/>
					</select>
				</div>
			</xsl:with-param>
		</xsl:call-template> 
	</xsl:if>
</xsl:template> 

<!-- 
    HTML Date/Term Code & Date/Text Input field
    Display a fixed list of Date/Term code followed by Date/Text field
    When a Date code is selected, Date field is enabled and Text field is disabled, which accepts only Date value
    When a Term Code is selected, the Date field is disabled and Text field becomes mandatory which accepts a numeric value
 -->
<xsl:template name="input-date-or-term-field">
	<!-- Required param -->
	<xsl:param name="name"/>	
	<xsl:param name="term-options"/> <!-- Raw html, listing the <option> tags for this element -->
	<xsl:param name="static-options"/>
	
	<!-- Optional -->
	<xsl:param name="id" select="$name"/>
	<xsl:param name="label"/>
	<xsl:param name="required">N</xsl:param> <!-- Whether this is a mandatory field. -->
	<xsl:param name="hide-required-status">N</xsl:param>
	<xsl:param name="readonly">N</xsl:param>
	<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
	<xsl:param name="fieldsize">small</xsl:param> <!-- x-small, small, medium, large -->
	
	<xsl:param name="value" select="concat(//*[name()=concat($name, '_date')], //*[name()=concat($name, '_code')])" />
	<xsl:param name="date" select="//*[name()=concat($name, '_date')]" />
	<xsl:param name="code" select="//*[name()=concat($name, '_code')]" />

	<!-- HTML -->
	<xsl:if test="$displaymode='edit' or $date != '' or $code !=''">
		<xsl:call-template name="row-wrapper">
		    <xsl:with-param name="id" select="$name"/>
		    <xsl:with-param name="label" select="$label"></xsl:with-param>
		    <xsl:with-param name="required">
	    	<xsl:choose>
	    		<xsl:when test="$hide-required-status='Y'">N</xsl:when>
	    		<xsl:otherwise><xsl:value-of select="$required"/></xsl:otherwise>
	    	</xsl:choose>
	    	</xsl:with-param>  
	    	<xsl:with-param name="content">
				<div dojoType="misys.form.DateOrTermField">
			        <xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
		       		<xsl:attribute name="fieldsize"><xsl:value-of select="$fieldsize"/></xsl:attribute>
	    		    <xsl:if test="$required='Y'"><xsl:attribute name="required">true</xsl:attribute></xsl:if>
	    		    <xsl:attribute name="displaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
					<xsl:if test="$readonly='Y'"><xsl:attribute name="readonly">true</xsl:attribute></xsl:if>
	    		    <xsl:attribute name="value"><xsl:value-of select="$value"/></xsl:attribute>
	    		    <xsl:attribute name="date"><xsl:value-of select="$date"/></xsl:attribute>
					<xsl:attribute name="code"><xsl:value-of select="$code"/></xsl:attribute>
					<!-- select tag has to be the first child of the div -->
					<select>
						<xsl:copy-of select="$term-options"/>
					</select>
					<select>
						<xsl:copy-of select ="$static-options"/>					
					</select>
				</div>
				<xsl:if test="$static-options!=''"> 
		        	<div class="content" id="date-value_description" ></div>
 		       </xsl:if>
			</xsl:with-param>
		</xsl:call-template> 
	</xsl:if>
</xsl:template> 

 <!-- 
    HTML Business Date Input field
    Allows only business dates 
 -->
 <xsl:template name="business-date-field">
   <!-- Required Parameters -->
    <xsl:param name="name"/>
  
   <!-- Optional -->
   <xsl:param name="label"/>
   <xsl:param name="id" select="$name"/>
   <xsl:param name="value" select="//*[name()=$name]" />
   <xsl:param name="size">35</xsl:param>          <!-- Size is not used by Dojo, but kept for backwards compatibility -->
   <xsl:param name="maxsize">35</xsl:param>
   <xsl:param name="fieldsize">medium</xsl:param> <!-- x-small, small, medium, large -->
   <xsl:param name="disabled">N</xsl:param>
   <xsl:param name="required">N</xsl:param>       <!-- Whether this is a mandatory field. -->
   <xsl:param name="hide-required-status">N</xsl:param>  
   <xsl:param name="readonly">N</xsl:param> 
   <xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
   <xsl:param name="cur-code-widget-id" /> <!--If business dates must be shown based on currency   -->
   <xsl:param name="country-widget-id" />  <!--If business dates must be shown based on country   -->
   <xsl:param name="product-code-widget-id"/> <!--OPTIONAL parameter (bcoz misys._config already has productCode -->
   <xsl:param name="sub-product-code-widget-id"/> <!--If business dates must be shown based on sub product code   -->
   <xsl:param name="bank-abbv-name-widget-id"/><!-- If business dates must be shown based on Bank  -->
   
   <xsl:call-template name="row-wrapper">
	    <xsl:with-param name="id" select="$id"/>
	    <xsl:with-param name="label" select="$label"/>
	    <xsl:with-param name="required">
	    	<xsl:choose>
	    		<xsl:when test="$hide-required-status='Y'">N</xsl:when>
	    		<xsl:otherwise><xsl:value-of select="$required"/></xsl:otherwise>
	    	</xsl:choose>
	    </xsl:with-param>
	    <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
	    <xsl:with-param name="content">
	     <xsl:choose>
	      <xsl:when test="$override-displaymode='edit'">
	       <div dojoType="misys.form.BusinessDateTextBox">
		        <xsl:attribute name="name"><xsl:value-of select="$name"/></xsl:attribute>
		        <xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
		        <xsl:attribute name="maxLength"><xsl:value-of select="$maxsize"/></xsl:attribute>
		        <xsl:attribute name="curCodeWidgetId"><xsl:value-of select="$cur-code-widget-id"/></xsl:attribute>
		        <xsl:attribute name="countryWidgetId"><xsl:value-of select="$country-widget-id"/></xsl:attribute>
		       	<xsl:attribute name="productCodeWidgetId"><xsl:value-of select="$product-code-widget-id"/></xsl:attribute>
		       	<xsl:attribute name="subProductCodeWidgetId"><xsl:value-of select="$sub-product-code-widget-id"/></xsl:attribute>
		       	<xsl:attribute name="bankAbbvNameWidgetId"><xsl:value-of select="$bank-abbv-name-widget-id"/></xsl:attribute>
		        <xsl:attribute name="class"><xsl:value-of select="$fieldsize"/></xsl:attribute>
		        <xsl:attribute name="displayedValue"><xsl:value-of select="$value"/></xsl:attribute>
				<xsl:attribute name="constraints">{datePattern:'<xsl:value-of select="localization:getGTPString($language, 'DATE_FORMAT')"/>'}</xsl:attribute>
		        <xsl:if test="$disabled='Y'">
		         	<xsl:attribute name="disabled">true</xsl:attribute>
		        </xsl:if>
		        <xsl:if test="$required='Y'">
		         	<xsl:attribute name="required">true</xsl:attribute>
		        </xsl:if>
		        <xsl:if test="$readonly='Y'">
		         	<xsl:attribute name="readOnly">true</xsl:attribute>
		        </xsl:if>
		   </div>
	  	  </xsl:when>
	      <xsl:otherwise>
		       <xsl:if test="$value!=''">
		        	<div class="content"><xsl:value-of select="$value"/></div>
		       </xsl:if>
	      </xsl:otherwise>
	    </xsl:choose>
	    <span class="dateFormatLabel"><xsl:value-of select="localization:getGTPString($language, 'DATE_FORMAT_LABEL')"/>&nbsp;</span>
		</xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="transaction_popup">
 	<xsl:param name="tnx_id"/>
 	
 	
 	<xsl:call-template name="row-wrapper">
 	 <xsl:with-param name="id">linked_transaction_row</xsl:with-param>
     <xsl:with-param name="label">XSL_GENERALDETAILS_LINKED_TRANSACTION</xsl:with-param>
     <xsl:with-param name="content">
 	 <div id="TransactionLink" style="display:inline">
	 	 <xsl:choose>
	 	 <xsl:when test="linkedTransaction">
			     <a id="javascriptLink" href="javascript:void(0)">
				     <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_TRANSACTION_LINK')"/>
			     </a>
		 </xsl:when>
		 <xsl:otherwise>
			<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_NO_LINKED_TRANSACTION')"/>
		 </xsl:otherwise>
		 </xsl:choose>
	</div>
	     <xsl:if test="$displaymode='edit'">
	     <div id="buttonRow" style="display:inline" class="widgetContainer">
		    <xsl:call-template name="get-button">
		 		<xsl:with-param name="button-type">transaction-list</xsl:with-param>
		 	</xsl:call-template>
		 	<xsl:call-template name="button-wrapper">
		     <xsl:with-param name="label">XSL_ALT_TRANSACTION_SEARCH</xsl:with-param>
		     <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($deleteImage)"/></xsl:with-param>
		      <xsl:with-param name="show-image">Y</xsl:with-param>
		      <xsl:with-param name="show-border">N</xsl:with-param>
			  <xsl:with-param name="onclick">misys.deleteTransactions();</xsl:with-param>
			  <xsl:with-param name="id">delete_linkedTransaction_button</xsl:with-param>
			  <xsl:with-param name="non-dijit-button">N</xsl:with-param>
		 	</xsl:call-template>
	 	</div>
	 	</xsl:if>
 	
 	</xsl:with-param>
 	
 	</xsl:call-template>
 	
 	<xsl:call-template name="hidden-field">
       <xsl:with-param name="name">imp_bill_ref_id</xsl:with-param>
 	</xsl:call-template>
 	
 	<div class="widgetContainer">
 	<xsl:call-template name="dialog">
 		<xsl:with-param name="id">linkedTransaction_dialog</xsl:with-param>
    	<xsl:with-param name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_LINKED_TRANSACTION')" /></xsl:with-param>
	    <xsl:with-param name="content">
			<div>
	    		<xsl:attribute name="id">linkedTransaction_div</xsl:attribute>
	    	</div>
	    </xsl:with-param>
	    <xsl:with-param name="buttons"/>
 	</xsl:call-template>
 	</div>
 	
 	
  </xsl:template>
    <!-- 
 		Container for columns
 	 -->
	<xsl:template name="column-container">
		<xsl:param name="content"/>
		<div class="column-container">
			<xsl:copy-of select="$content"/>
			<div style="clear: both;"/>
		</div>
	</xsl:template>
	
	<!-- Column wrapper -->
	<xsl:template name="column-wrapper">
		<xsl:param name="appendClass"></xsl:param>
		<xsl:param name="content"/>
  		<div >
  		 	<xsl:attribute name="class">
			     column-wrapper<xsl:if test="$appendClass!=''"><xsl:text> </xsl:text><xsl:value-of select="$appendClass"/></xsl:if>
		    </xsl:attribute>
			<xsl:copy-of select="$content"/>	
		</div>
	</xsl:template>
	
	<xsl:template name="multioption-inline-wrapper">
		<xsl:param name="content"/>
		<xsl:param name="group-id"/>
		<xsl:param name="group-label"/>
		<xsl:param name="show-required-prefix">N</xsl:param>
  		<div class="field">
  		<span>
  		<xsl:if test="$rundata!='' ">
  			<xsl:call-template name="localization-dblclick">
					<xsl:with-param name="xslName" select="$group-label" />
					<xsl:with-param name="localName" select="localization:getGTPString($rundata, $language, $group-label)" />
			</xsl:call-template>
			</xsl:if>
  			 <label>
		    	<xsl:attribute name="for"><xsl:value-of select="$group-id"/></xsl:attribute>
		    	<xsl:attribute name="id"><xsl:value-of select="$group-id"/>_group_label</xsl:attribute>
		    		<xsl:if test="$show-required-prefix='Y'">
		    			<span class="required-field-symbol"><xsl:value-of select="localization:getGTPString($language, 'REQUIRED_PREFIX')"/></span>
		    		</xsl:if>
		        <xsl:if test="$content != ''">
		        <xsl:choose>
         			<xsl:when test="$rundata!='' ">
         				<xsl:value-of select="localization:getGTPString($rundata, $language, $group-label)"/>
         			</xsl:when>
	         		<xsl:otherwise>
	         			<xsl:value-of select="localization:getGTPString($language, $group-label)"/>
	         		</xsl:otherwise>
         		</xsl:choose>
		         </xsl:if>
		    </label>
		    </span>
  		 	<xsl:copy-of select="$content"/>	
		</div>
	</xsl:template>
	
	<!--Field for multioption widgets (Checkbox and RadioButton) -->
	<xsl:template name="multichoice-field">
		<!-- Required Parameters -->
		   <xsl:param name="group-label"/>
		   <xsl:param name="label"/>
		   <xsl:param name="name"/>
		   <xsl:param name="type"/>
		   
		   <!-- Optional -->
		   <xsl:param name="id" select="$name"/>
		   <xsl:param name="inline">N</xsl:param>
		   <xsl:param name="value"><xsl:if test="$type='checkbox'"><xsl:value-of select="//*[name()=$name]"></xsl:value-of></xsl:if></xsl:param>
		   <xsl:param name="checked">N</xsl:param>
		   <xsl:param name="required">N</xsl:param>
		   <xsl:param name="readonly">N</xsl:param>
		   <xsl:param name="disabled">N</xsl:param>
		   <xsl:param name="override-displaymode" select="$displaymode"/>
		   <xsl:param name="content"/>
		   <xsl:param name="unchecked-label"/> <!-- Label to display when the checkbox is not checked -->
		   <xsl:param name="appendClass"/>
		   <!-- 
    		checked-label is only used by the products list in the system entity screen, since we can't use
    		the standard localization to get the product name.
   			-->
  		    <xsl:param name="checked-label"/> 
		   
		   <!-- HTML -->
		   <xsl:variable name="checkbox-value" select="$value"/>
		   <xsl:if test="$rundata!='' ">
		   <xsl:call-template name="localization-dblclick">
					<xsl:with-param name="xslName" select="$label" />
					<xsl:with-param name="localName" select="localization:getGTPString($rundata, $language, $label)" />
			</xsl:call-template>
			</xsl:if>
   		   <xsl:variable name="radio-value" select="//*[name()=$name]"/>
   		   <xsl:choose>
			  <xsl:when test="$inline = 'N' or ($inline = 'Y' and $override-displaymode = 'view')">
	   		   <xsl:call-template name="row-wrapper">
				      <xsl:with-param name="label" select="$group-label"/>
				      <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
				      <xsl:with-param name="required"><xsl:value-of select="$required"/></xsl:with-param>
				      <xsl:with-param name="appendClass" select="$appendClass"/>
				      <xsl:with-param name="content">
						   <xsl:choose>
							    <xsl:when test="$override-displaymode='edit'">
							    		<xsl:if test="$type='radiobutton'">
									       <input type="radio" dojoType="dijit.form.RadioButton">
										        <!-- Required Attributes. -->
										        <xsl:attribute name="name"><xsl:value-of select="$name"/></xsl:attribute>
										        <xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
										        <xsl:attribute name="value"><xsl:value-of select="$value"/></xsl:attribute>
										        <xsl:if test="$checked='Y'">
										         	<xsl:attribute name="checked">checked</xsl:attribute>
										        </xsl:if>
										        <xsl:if test="$disabled='Y'">
										         	<xsl:attribute name="disabled">true</xsl:attribute>
										        </xsl:if>
										        <xsl:if test="$required='Y'">
										         	<xsl:attribute name="required">true</xsl:attribute>
										        </xsl:if>
								       	   </input>
								       	</xsl:if>
								       	<xsl:if test="$type='checkbox'">
									       <input type="checkbox" dojoType="dijit.form.CheckBox">
					        					<!-- Required Attributes -->
					        					<xsl:attribute name="name"><xsl:value-of select="$name"/></xsl:attribute>
					        					<xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
					        
					        					<!-- Others -->
					        					<xsl:if test="$checkbox-value='Y' or $checked='Y'">
					         						<xsl:attribute name="checked">checked</xsl:attribute>
					       					 	</xsl:if>
					        					<xsl:if test="$disabled='Y'">
					         						<xsl:attribute name="disabled">true</xsl:attribute>
					        					</xsl:if>
					        					<xsl:if test="$readonly='Y'">
					         						<xsl:attribute name="readOnly">true</xsl:attribute>
					        					</xsl:if>
					        					<xsl:if test="$required='Y'">
					         						<xsl:attribute name="required">true</xsl:attribute>
					        					</xsl:if>
				       						</input>
								       	</xsl:if>
							       	   <label class="radio-checkbox-field-label">
							       	   		<xsl:attribute name="for"><xsl:value-of select="$id"/></xsl:attribute>
							       	   		<xsl:choose>
									 			<xsl:when test="$rundata!='' ">
									 				<xsl:value-of select="localization:getGTPString($rundata,$language, $label)"/>
									 			</xsl:when>
										   		<xsl:otherwise>
										   			<xsl:value-of select="localization:getGTPString($language, $label)"/>
										   		</xsl:otherwise>
										  	</xsl:choose>
							       	   </label>
						    	</xsl:when>
						    	<xsl:otherwise>
						    		<xsl:if test="$type='radiobutton'">
								       <xsl:if test="$radio-value = $value">
									       <div class="content">
									       		<xsl:choose>
									 			<xsl:when test="$rundata!='' ">
									 				<xsl:value-of select="localization:getGTPString($rundata,$language, $label)"/>
									 			</xsl:when>
										   		<xsl:otherwise>
										   			<xsl:value-of select="localization:getGTPString($language, $label)"/>
										   		</xsl:otherwise>
										  	</xsl:choose>
									       </div>
								       </xsl:if>
								     </xsl:if>
								     <xsl:if test="$type='checkbox'">
								     		<xsl:choose>
					         					 <xsl:when test="$checkbox-value='Y' or $checked='Y'">
						          						<div class="content">
							         						<xsl:choose>
									            				<xsl:when test="$checked-label!=''"><xsl:value-of select="$checked-label"/></xsl:when>
									            					<!-- Add a space so the row label is shown -->
									            				<xsl:otherwise>
																	<xsl:choose>
															 			<xsl:when test="$rundata!='' ">
															 				<xsl:value-of select="localization:getGTPString($rundata,$language, $label)"/>
															 			</xsl:when>
																   		<xsl:otherwise>
																   			<xsl:value-of select="localization:getGTPString($language, $label)"/>
																   		</xsl:otherwise>
																  	</xsl:choose>
																</xsl:otherwise>
								           					</xsl:choose>
							          					</div>
					        					 </xsl:when>
					         					 <xsl:when test="($checkbox-value='N' or $checked='N') and $unchecked-label!=''">
						          					<div class="content">
						          						<xsl:choose>
												 			<xsl:when test="$rundata!='' ">
												 				<xsl:value-of select="localization:getGTPString($rundata,$language, $unchecked-label)"/>
												 			</xsl:when>
													   		<xsl:otherwise>
													   			<xsl:value-of select="localization:getGTPString($language, $unchecked-label)"/>
													   		</xsl:otherwise>
													  	</xsl:choose>
						          					</div>
					         					 </xsl:when>
				        					</xsl:choose> 
								     </xsl:if>
						   		</xsl:otherwise>
					       </xsl:choose>
				      </xsl:with-param>
			      <!-- 
			       Sometimes we want to display additional HTML in the radio button space; it 
			       should be sent in this parameter
			       -->
			      <xsl:with-param name="additional-content">
			       	  <xsl:copy-of select="$content"/>
			      </xsl:with-param>
	     		</xsl:call-template>
	     	</xsl:when>
	     	<xsl:otherwise>
	     		<div style="display:inline;" class="inlineRadioButtons">
	     		<xsl:if test="$type='radiobutton'">
			       <input type="radio" dojoType="dijit.form.RadioButton">
				        <!-- Required Attributes. -->
				        <xsl:attribute name="name"><xsl:value-of select="$name"/></xsl:attribute>
				        <xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
				        <xsl:attribute name="value"><xsl:value-of select="$value"/></xsl:attribute>
				        <xsl:if test="$checked='Y'">
				         	<xsl:attribute name="checked">checked</xsl:attribute>
				        </xsl:if>
				        <xsl:if test="$disabled='Y'">
				         	<xsl:attribute name="disabled">true</xsl:attribute>
				        </xsl:if>
				        <xsl:if test="$required='Y'">
				         	<xsl:attribute name="required">true</xsl:attribute>
				        </xsl:if>
		       	   </input>
		       	</xsl:if>
		       	<xsl:if test="$type='checkbox'">
			       <input type="checkbox" dojoType="dijit.form.CheckBox">
       					<!-- Required Attributes -->
       					<xsl:attribute name="name"><xsl:value-of select="$name"/></xsl:attribute>
       					<xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
       
       					<!-- Others -->
       					<xsl:if test="$checkbox-value='Y' or $checked='Y'">
        						<xsl:attribute name="checked">checked</xsl:attribute>
      					 	</xsl:if>
       					<xsl:if test="$disabled='Y'">
        						<xsl:attribute name="disabled">true</xsl:attribute>
       					</xsl:if>
       					<xsl:if test="$readonly='Y'">
        						<xsl:attribute name="readOnly">true</xsl:attribute>
       					</xsl:if>
       					<xsl:if test="$required='Y'">
        						<xsl:attribute name="required">true</xsl:attribute>
       					</xsl:if>
     						</input>
		       	</xsl:if>
	       	   <label class="radio-checkbox-field-label">
	       	   		<xsl:attribute name="for"><xsl:value-of select="$id"/></xsl:attribute>
	       	   		<xsl:value-of select="localization:getGTPString($language, $label)"/>
	       	   </label>
	       	  </div>
			</xsl:otherwise>
	    </xsl:choose>
  	</xsl:template>
  	
  	<!-- Wrapper to group fields (Give extra spacing between different groups ) -->
  	<xsl:template name="group-container">
		<xsl:param name="content"/>
		<div class="groupContainer">
			<xsl:copy-of select="$content"/>
		</div>
	</xsl:template>

	<!-- common template for account nickname feature -->
	<xsl:template name="nickname-field-template">
		<xsl:if test="$nicknameEnabled='true' and security:isCustomer($rundata) and securityCheck:hasPermission($rundata,'sy_account_nickname_access')">
			<div id="applicant_act_nickname_row" class="field">
				<span class="label" id="label">
					<xsl:attribute name="style">
							<xsl:choose>
								<xsl:when test="applicant_act_nickname!=''">display:inline-block</xsl:when>
								<xsl:otherwise>display:none</xsl:otherwise>
							</xsl:choose>
					</xsl:attribute>
					<xsl:value-of select="localization:getGTPString($language,'XSL_ACCOUNT_NICK_NAME')"/>
				</span>
				<div id="nickname" class="content">
					<xsl:attribute name="style">
						<xsl:choose>
							<xsl:when test="applicant_act_nickname!=''">display:inline</xsl:when>
							<xsl:otherwise>display:none</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<xsl:value-of select="applicant_act_nickname"/>
				</div> 
			</div>
		</xsl:if>	
	</xsl:template>
	
	<xsl:template name="beneficiary-nickname-field-template">
		<xsl:if test="$beneficiaryNicknameEnabled='true' and security:isCustomer($rundata)">
			<div id="beneficiary_nickname_row" class="field">
				<span class="label" id="ben_label">
					<xsl:attribute name="style">
						<xsl:choose>
							<xsl:when test="counterparties/counterparty/beneficiary_nickname!=''">display:inline-block</xsl:when>
							<xsl:otherwise>display:none</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<xsl:value-of select="localization:getGTPString($language,'BENEFICIARY_NICKNAME_LABEL')"/>
				</span>
				<div id="beneficiarynickname" class="content">
					<xsl:attribute name="style">
						<xsl:choose>
							<xsl:when test="counterparties/counterparty/beneficiary_nickname!=''">display:inline</xsl:when>
							<xsl:otherwise>display:none</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<xsl:value-of select="counterparties/counterparty/beneficiary_nickname"/>
				</div> 
			</div>
		</xsl:if>	
	</xsl:template>	
		
	<!-- Text area wrapper for very big textareas -->
	<xsl:template name="big-textarea-wrapper">
	<xsl:param name="label"></xsl:param>
	<xsl:param name="required">N</xsl:param>
	<xsl:param name="content"/>
	<xsl:if test="$displaymode='edit'">
		<div>
		<xsl:if test="$rundata!='' ">
		<xsl:call-template name="localization-dblclick">
					<xsl:with-param name="xslName" select="$label" />
					<xsl:with-param name="localName" select="localization:getGTPString($rundata,$language, $label)" />
			</xsl:call-template>
			</xsl:if>
			<xsl:attribute name="class">
				<xsl:if test="$displaymode='edit'">field</xsl:if>
			</xsl:attribute>
			<label class="big-textarea-wrapper-label" style="vertical-align:top;">
				<xsl:if test="$required='Y'">
     		 		<span class="required-field-symbol"><xsl:value-of select="localization:getGTPString($language, 'REQUIRED_PREFIX')"/></span>
      	  		</xsl:if>
			<xsl:choose>
	 			<xsl:when test="$rundata!='' ">
	 				<xsl:value-of select="localization:getGTPString($rundata,$language, $label)"/>
	 			</xsl:when>
		   		<xsl:otherwise>
		   			<xsl:value-of select="localization:getGTPString($language, $label)"/>
		   		</xsl:otherwise>
		  	</xsl:choose>
			</label>
		<div class="big-textarea-wrapper-content">
			<xsl:copy-of select="$content"/>
		</div>
		</div>
		
	</xsl:if>
	<xsl:if test="$displaymode='view'">
		<div>
			<xsl:attribute name="class">
				<xsl:if test="$displaymode!='edit'">field</xsl:if>
			</xsl:attribute>
			<label class="big-textarea-wrapper-label">
			<xsl:choose>
	 			<xsl:when test="$rundata!='' ">
	 				<xsl:value-of select="localization:getGTPString($rundata,$language, $label)"/>
	 			</xsl:when>
		   		<xsl:otherwise>
		   			<xsl:value-of select="localization:getGTPString($language, $label)"/>
		   		</xsl:otherwise>
		  	</xsl:choose>&nbsp;</label>
			<div class="big-textarea-wrapper-content">
				<xsl:copy-of select="$content"/>
			</div>
		</div>
	</xsl:if>
	</xsl:template>
	
	<!--
   Creates a principal-account-field  ie. a field for the account with a search popup and hidden fields to store account values and parameters.
   -->
<xsl:template name="principal-account-field">
   <xsl:param name="name"/>

  	<xsl:param name="id" select="$name"/>
   <xsl:param name="label"/>
   <xsl:param name="appendClass"/>
   <xsl:param name="content-after" /> 
   <xsl:param name="disabled">N</xsl:param>
   <xsl:param name="required">N</xsl:param>
   <xsl:param name="readonly">Y</xsl:param>
   <xsl:param name="size">34</xsl:param>
   <xsl:param name="maxsize">34</xsl:param>
   <xsl:param name="fieldsize">medium</xsl:param>
   <xsl:param name="content-after"/>
   <xsl:param name="override-name" select="$name"/>
   <xsl:param name="override-id" select="$name"/>
   <xsl:param name="override-displaymode" select="$displaymode"/>
   <xsl:param name="value" select="//*[name()=$override-name]"/>
   <xsl:param name="hide-required-status">N</xsl:param>
   <xsl:param name="show-product-types">Y</xsl:param>
   <xsl:param name="product-types-required">N</xsl:param>
   <xsl:param name="internal-external-accts">none</xsl:param>
   <xsl:param name="show-clear-button"><xsl:choose>
    		<xsl:when test="$required='Y'">N</xsl:when>
    		<xsl:otherwise>Y</xsl:otherwise>
    	</xsl:choose>
    </xsl:param>
   
   <xsl:param name="excluded-value-field"/> <!-- the account to exclude in the list (e.g. for IAFT, debit and credit accounts must be different)-->
   <xsl:param name="entity-field"/> <!-- the name of the Entity field in the page if any -->
   <xsl:param name="dr-cr"/> <!-- either a debit or a credit account -->
   <xsl:param name= "dimensions"/>

   <xsl:param name="product_types"/><!-- the list of enabled products (comma seperated) for the searchable accounts -->
   <xsl:param name="product_types-as-js">N</xsl:param><!-- simply renders what we pass in the product_types list without quotes, so we can use a function or variable instead of a fixed list -->
   <xsl:param name="parameter"/>
   <xsl:param name="ccy-code-fields"/><!-- the list of currency fields (comma seperated) for the searchable accounts -->
   <!-- prodCode is added as in some xsls the value of product code is not globally available -->
   <xsl:param name="prodCode"><xsl:value-of select="$product-code"/></xsl:param>
   <xsl:variable name="accountTitle">
	   <xsl:value-of select="localization:getGTPString($language, 'TABLE_SUMMARY_ACCOUNTS_LIST')"/>
   </xsl:variable>
   
   <xsl:call-template name="row-wrapper">
   	<xsl:with-param name="id" select="$override-id"/>
    <xsl:with-param name="label" select="$label"/>
   	<xsl:with-param name="appendClass" select="$appendClass"/>
    <xsl:with-param name="required">
    	<xsl:choose>
    		<xsl:when test="$hide-required-status='Y'">N</xsl:when>
    		<xsl:otherwise><xsl:value-of select="$required"/></xsl:otherwise>
    	</xsl:choose>
    </xsl:with-param>
    <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
    <xsl:with-param name="content">
     <xsl:choose>
      <xsl:when test="$override-displaymode='edit'">
       <div trim="true" dojoType="dijit.form.ValidationTextBox">
        <xsl:attribute name="name"><xsl:value-of select="$override-name"/></xsl:attribute>
        <xsl:attribute name="id"><xsl:value-of select="$override-id"/></xsl:attribute>
        <!-- Dojo equivalent of maxsize is maxLength -->
        <xsl:attribute name="maxLength"><xsl:value-of select="$maxsize"/></xsl:attribute>
        
        <!-- Set style classes -->
        <xsl:attribute name="class">
         <xsl:value-of select="$fieldsize"/>
         <xsl:if test="$appendClass != ''"><xsl:text> </xsl:text><xsl:value-of select="$appendClass"/></xsl:if>
        </xsl:attribute>
         <xsl:attribute name="value"><xsl:value-of select="$value"/></xsl:attribute>
        <xsl:if test="$disabled='Y'">
         <xsl:attribute name="disabled">true</xsl:attribute>
        </xsl:if>
        <xsl:if test="$required='Y'">
         <xsl:attribute name="required">true</xsl:attribute>
        </xsl:if>
        <xsl:if test="$readonly='Y'">
         <xsl:attribute name="readOnly">true</xsl:attribute>
        </xsl:if>
       </div>
       <xsl:call-template name="button-wrapper">
	      <xsl:with-param name="label">ACTION_TOKEN_SEARCH</xsl:with-param>
	      <xsl:with-param name="show-image">Y</xsl:with-param>
	      <xsl:with-param name="name"><xsl:value-of select="$name"/></xsl:with-param>
	      <xsl:with-param name="show-border">N</xsl:with-param>
	      <xsl:with-param name="onclick">misys.showSearchExtAccountDialog('account', "['<xsl:value-of select="$id"/>']", '', '', '<xsl:value-of select="$prodCode"/>', '<xsl:value-of select="$dimensions"/>', '<xsl:value-of select="$accountTitle"/>','<xsl:value-of select="$entity-field"/>');return false;			 
	      </xsl:with-param>
	      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
	      <xsl:with-param name="non-dijit-button">N</xsl:with-param>
	   </xsl:call-template>
	 <xsl:call-template name="button-wrapper">		      
	 <xsl:with-param name="label">XSL_ALT_CLEAR</xsl:with-param>
	 <xsl:with-param name="show-image">Y</xsl:with-param>
	 <xsl:with-param name="show-border">N</xsl:with-param>
	 <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($clearImage)"/></xsl:with-param>
	 <xsl:with-param name="img-height">16</xsl:with-param>
	 <xsl:with-param name="img-width">13</xsl:with-param>
	 <xsl:with-param name="onclick">dijit.byId('<xsl:value-of select="$id"/>').set("value", '');</xsl:with-param>
	 <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_clear_img</xsl:if></xsl:with-param>
	 </xsl:call-template>  	  
      	<xsl:copy-of select="$content-after"/>
      </xsl:when>
      <xsl:otherwise>
       <xsl:if test="$value!=''">
        <div class="content">
           <xsl:value-of select="$value"/><xsl:copy-of select="$content-after"/>
        </div>
	    <xsl:call-template name="hidden-field">
		     <xsl:with-param name="name"><xsl:value-of select="$name"/>_act_name</xsl:with-param>
		     <xsl:with-param name="prefix"><xsl:value-of select="$name"/></xsl:with-param>
		     <xsl:with-param name="value"><xsl:value-of select="$value"/></xsl:with-param>		
		     <xsl:with-param name="id"><xsl:value-of select="$override-id"/></xsl:with-param>
	    </xsl:call-template>
       </xsl:if>
      </xsl:otherwise>
     </xsl:choose>

    </xsl:with-param>
	</xsl:call-template>
  </xsl:template>
	
  <!--
   Creates a user account field ie. a field for the account with a search popup and hidden fields to store account values and parameters.
   -->
  <xsl:template name="user-account-field">
   <xsl:param name="name"/>

   <xsl:param name="id" select="$name"/>
   <xsl:param name="label"/>
   <xsl:param name="appendClass"/>
   <xsl:param name="disabled">N</xsl:param>
   <xsl:param name="required">N</xsl:param>
   <xsl:param name="readonly">Y</xsl:param>
   <xsl:param name="size">34</xsl:param>
   <xsl:param name="maxsize">34</xsl:param>
   <xsl:param name="fieldsize">medium</xsl:param>
   <xsl:param name="content-after"/>
   <xsl:param name="override-name" select="concat($name,'_act_name')"/>
   <xsl:param name="override-id" select="concat($name,'_act_name')"/>
   <xsl:param name="override-name-trade" select="concat($name,'_act_no')"/>
   <xsl:param name="override-id-trade" select="concat($name,'_act_no')"/>
   <xsl:param name="override-displaymode" select="$displaymode"/>
   <xsl:param name="value" select="//*[name()=$override-name]"/>
   <xsl:param name="value-trade" select="//*[name()=$override-name-trade]"/>
   <xsl:param name="hide-required-status">N</xsl:param>
   <xsl:param name="show-product-types">Y</xsl:param>
   <xsl:param name="product-types-required">N</xsl:param>
   <xsl:param name="internal-external-accts">none</xsl:param>
   <xsl:param name="show-clear-button"><xsl:choose>
    		<xsl:when test="$required='Y'">N</xsl:when>
    		<xsl:otherwise>Y</xsl:otherwise>
    	</xsl:choose>
    </xsl:param>
   <xsl:param name="trade_internal_account">N</xsl:param>
   <xsl:param name="excluded-value-field"/> <!-- the account to exclude in the list (e.g. for IAFT, debit and credit accounts must be different)-->
   <xsl:param name="entity-field"/> <!-- the name of the Entity field in the page if any -->
   <xsl:param name="dr-cr"/> <!-- either a debit or a credit account -->

   <xsl:param name="product_types"/><!-- the list of enabled products (comma seperated) for the searchable accounts -->
   <xsl:param name="product_types-as-js">N</xsl:param><!-- simply renders what we pass in the product_types list without quotes, so we can use a function or variable instead of a fixed list -->
   <xsl:param name="parameter"/>
   <xsl:param name="ccy-code-fields"/><!-- the list of currency fields (comma seperated) for the searchable accounts -->
   <xsl:param name="account_types"/><!-- the list of account types (comma separated) for the searchable accounts -->
   <xsl:param name="excluded-acct-type"/><!-- Accounts to exclude in the list (e.g DDA Account in Account Summary) -->
   <xsl:param name="isMultiBankParam">N</xsl:param><!-- To check whether the user is a MultiBank user -->
   
   <xsl:call-template name="row-wrapper">
   	<xsl:with-param name="id" select="$override-id"/>
    <xsl:with-param name="label" select="$label"/>
   	<xsl:with-param name="appendClass" select="$appendClass"/>
    <xsl:with-param name="required">
    	<xsl:choose>
    		<xsl:when test="$hide-required-status='Y'">N</xsl:when>
    		<xsl:otherwise><xsl:value-of select="$required"/></xsl:otherwise>
    	</xsl:choose>
    </xsl:with-param>
    <xsl:with-param name="override-displaymode" select="$override-displaymode"/>
    <xsl:with-param name="content">
     <xsl:choose>
      <xsl:when test="$override-displaymode='edit'">
       <div trim="true" dojoType="dijit.form.ValidationTextBox">
        <xsl:attribute name="name">
        	<xsl:choose>
        		<xsl:when test="$trade_internal_account = 'Y'">
        			<xsl:value-of select="$override-name-trade"/>
        		</xsl:when>
        		<xsl:otherwise>
        			 <xsl:value-of select="$override-name"/>
        		</xsl:otherwise>
        	</xsl:choose>
        </xsl:attribute>
        <xsl:attribute name="id">
             <xsl:choose>
        		<xsl:when test="$trade_internal_account = 'Y'">
        			<xsl:value-of select="$override-id-trade"/>
        		</xsl:when>
        		<xsl:otherwise>
        			 <xsl:value-of select="$override-id"/>
        		</xsl:otherwise>
        	</xsl:choose>
        </xsl:attribute>
        <!-- Dojo equivalent of maxsize is maxLength -->
        <xsl:attribute name="maxLength"><xsl:value-of select="$maxsize"/></xsl:attribute>
        
        <!-- Set style classes -->
        <xsl:attribute name="class">
         <xsl:value-of select="$fieldsize"/>
         <xsl:if test="$appendClass != ''"><xsl:text> </xsl:text><xsl:value-of select="$appendClass"/></xsl:if>
        </xsl:attribute>
          <xsl:attribute name="value">
           <xsl:choose>
	      	<xsl:when test="$trade_internal_account = 'Y'">         
         		<xsl:value-of select="$value-trade"/>
         	</xsl:when>
           <xsl:otherwise>
         	<xsl:value-of select="$value"/>
           </xsl:otherwise>		
           </xsl:choose>
        </xsl:attribute>
        <xsl:if test="$disabled='Y'">
         <xsl:attribute name="disabled">true</xsl:attribute>
        </xsl:if>
        <xsl:if test="$required='Y'">
         <xsl:attribute name="required">true</xsl:attribute>
        </xsl:if>
        <xsl:if test="$readonly='Y'">
         <xsl:attribute name="readOnly">true</xsl:attribute>
        </xsl:if>
       </div>
	   <xsl:call-template name="button-wrapper">
	      <xsl:with-param name="label">XSL_ALT_ACCOUNT</xsl:with-param>
	      <xsl:with-param name="show-image">Y</xsl:with-param>
	      <xsl:with-param name="name">
	      	<xsl:choose>
	      		<xsl:when test="$trade_internal_account = 'Y'">
	      			<xsl:value-of select="$name"/>_act_no</xsl:when>
	      		<xsl:otherwise>
	      			<xsl:value-of select="$name"/>_act_name</xsl:otherwise>
	      	</xsl:choose>
	      </xsl:with-param>
	      <xsl:with-param name="show-border">N</xsl:with-param>
	      <xsl:with-param name="onclick">
			  <xsl:variable name="listProductTypes">
			  	  <xsl:choose>
			  	  <xsl:when test="$product_types-as-js='Y'"><xsl:value-of select="$product_types"/></xsl:when>
			  	  <xsl:otherwise>'<xsl:value-of select="$product_types"/>'</xsl:otherwise>
			  	  </xsl:choose>
			  </xsl:variable>
	      <xsl:choose>
	      <xsl:when test="$product_types = 'FX:SPOT' or $product_types = 'FT:TRINT' or $product_types = 'FT:TRTPT'">
	      		misys.showSearchUserAccountsDialog('useraccount', "['<xsl:value-of select="$name"/>_act_name', '<xsl:value-of select="$name"/>_act_no', '', '<xsl:value-of select="$name"/>_act_cur_code', '<xsl:value-of select="$name"/>_act_description','<xsl:value-of select="$name"/>_act_pab','<xsl:value-of select="$name"/>_act_product_types', '', '', '<xsl:value-of select="$name"/>_reference', '','<xsl:value-of select="$name"/>_act_nickname']", '<xsl:value-of select="$excluded-value-field"/>', '<xsl:value-of select="$entity-field"/>', '<xsl:value-of select="$dr-cr"/>', <xsl:value-of select="$listProductTypes"/>, 'width:750px;height:400px;', '<xsl:value-of select="localization:getGTPString($language, 'TABLE_SUMMARY_ACCOUNTS_LIST')"/>','ownerType:<xsl:value-of select="$internal-external-accts"/>', '', '', '', '','<xsl:value-of select="$ccy-code-fields"/>','<xsl:value-of select="$account_types"/>','<xsl:value-of select="$excluded-acct-type"/>');return false;
	      </xsl:when>
	      <xsl:when test="$parameter !=''">
			    misys.showSearchUserAccountsDialog('useraccount', "['<xsl:value-of select="$name"/>_act_name', '<xsl:value-of select="$name"/>_act_no','<xsl:value-of select="$name"/>_act_id',  '<xsl:value-of select="$name"/>_act_cur_code', '<xsl:value-of select="$name"/>_act_description','<xsl:value-of select="$name"/>_act_pab','<xsl:value-of select="$name"/>_act_product_types', '', '','<xsl:value-of select="$name"/>_reference', '','<xsl:value-of select="$name"/>_act_nickname']", '<xsl:value-of select="$excluded-value-field"/>', '<xsl:value-of select="$entity-field"/>', '<xsl:value-of select="$dr-cr"/>', <xsl:value-of select="$listProductTypes"/>, 'width:750px;height:400px;', '<xsl:value-of select="localization:getGTPString($language, 'TABLE_SUMMARY_ACCOUNTS_LIST')"/>',dijit.byId('<xsl:value-of select="$parameter"/>').get('value'), '', '', '', '','<xsl:value-of select="$ccy-code-fields"/>','');return false;
	      </xsl:when>
	      <xsl:when test="$internal-external-accts !='none'">
			 	misys.showSearchUserAccountsDialog('useraccount', "['<xsl:value-of select="$name"/>_act_name', '<xsl:value-of select="$name"/>_act_no','<xsl:value-of select="$name"/>_act_id',  '<xsl:value-of select="$name"/>_act_cur_code', '<xsl:value-of select="$name"/>_act_description','<xsl:value-of select="$name"/>_act_pab','<xsl:value-of select="$name"/>_act_product_types', '', '', '<xsl:value-of select="$name"/>_reference', '','<xsl:value-of select="$name"/>_act_nickname']", '<xsl:value-of select="$excluded-value-field"/>', '<xsl:value-of select="$entity-field"/>', '<xsl:value-of select="$dr-cr"/>', <xsl:value-of select="$listProductTypes"/>, 'width:750px;height:400px;', '<xsl:value-of select="localization:getGTPString($language, 'TABLE_SUMMARY_ACCOUNTS_LIST')"/>','ownerType:<xsl:value-of select="$internal-external-accts"/>', '', '', '', '','<xsl:value-of select="$ccy-code-fields"/>','');return false;
	      </xsl:when>
	      <xsl:when test="$isMultiBankParam = 'Y'">
			 	misys.showSearchUserAccountsDialog('useraccount', "['<xsl:value-of select="$name"/>_act_name', '<xsl:value-of select="$name"/>_act_no','<xsl:value-of select="$name"/>_act_id',  '<xsl:value-of select="$name"/>_act_cur_code', '<xsl:value-of select="$name"/>_act_description','<xsl:value-of select="$name"/>_act_pab','<xsl:value-of select="$name"/>_act_product_types', '', '', '<xsl:value-of select="$name"/>_reference', '', '<xsl:value-of select="$name"/>_act_nickname', 'customer_associated_bank']", '<xsl:value-of select="$excluded-value-field"/>', '<xsl:value-of select="$entity-field"/>', '<xsl:value-of select="$dr-cr"/>', <xsl:value-of select="$listProductTypes"/>, 'width:750px;height:400px;', '<xsl:value-of select="localization:getGTPString($language, 'TABLE_SUMMARY_ACCOUNTS_LIST')"/>','ownerType:<xsl:value-of select="$internal-external-accts"/>', '', '', '', '','<xsl:value-of select="$ccy-code-fields"/>','');return false;
	      </xsl:when>
	      <xsl:otherwise>
			    misys.showSearchUserAccountsDialog('useraccount', "['<xsl:value-of select="$name"/>_act_name', '<xsl:value-of select="$name"/>_act_no', '<xsl:value-of select="$name"/>_act_id', '<xsl:value-of select="$name"/>_act_cur_code', '<xsl:value-of select="$name"/>_act_description','<xsl:value-of select="$name"/>_act_pab','<xsl:value-of select="$name"/>_act_product_types', '', '', '<xsl:value-of select="$name"/>_reference', '','<xsl:value-of select="$name"/>_act_nickname']", '<xsl:value-of select="$excluded-value-field"/>', '<xsl:value-of select="$entity-field"/>', '<xsl:value-of select="$dr-cr"/>', <xsl:value-of select="$listProductTypes"/>, 'width:750px;height:400px;', '<xsl:value-of select="localization:getGTPString($language, 'TABLE_SUMMARY_ACCOUNTS_LIST')"/>', '', '', '', '', '','<xsl:value-of select="$ccy-code-fields"/>','');return false;
	      </xsl:otherwise>
	      </xsl:choose>
	      </xsl:with-param>

	      <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_img</xsl:if></xsl:with-param>
	      <xsl:with-param name="non-dijit-button">N</xsl:with-param>
	   </xsl:call-template>   
	   	  <xsl:if test="$show-clear-button ='Y'">
			<xsl:call-template name="button-wrapper">
		   
		      <xsl:with-param name="label">XSL_ALT_CLEAR</xsl:with-param>
		      <xsl:with-param name="show-image">Y</xsl:with-param>
		      <xsl:with-param name="show-border">N</xsl:with-param>
		      <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($cleanUpImage)"/></xsl:with-param>
		      <xsl:with-param name="img-height">16</xsl:with-param>
		      <xsl:with-param name="img-width">13</xsl:with-param>
		      <xsl:with-param name="onclick">dijit.byId('<xsl:value-of select="$override-id"/>').set("value", '');dijit.byId('<xsl:value-of select="$name"/>_act_cur_code').set("value", '');dijit.byId('<xsl:value-of select="$name"/>_act_no').set("value", '');dijit.byId('<xsl:value-of select="$name"/>_act_pab').set("value", '');dijit.byId('<xsl:value-of select="$name"/>_act_description').set("value", '');</xsl:with-param>
		  	  <xsl:with-param name="id"><xsl:if test="$id!=''"><xsl:value-of select="$id"/>_clear_img</xsl:if></xsl:with-param>
		   </xsl:call-template>
          </xsl:if> 
		
      	<xsl:copy-of select="$content-after"/>
      </xsl:when>
      <xsl:otherwise>
       <xsl:choose>
            <xsl:when test="$trade_internal_account = 'Y'">
       			<xsl:if test="$value-trade!=''">
       			 <div class="content">
           			<xsl:value-of select="$value-trade"/><xsl:copy-of select="$content-after"/>
        		</div>
	    		<xsl:call-template name="hidden-field">
		     		<xsl:with-param name="name"><xsl:value-of select="$name"/>_act_no</xsl:with-param>
		    	 	<xsl:with-param name="prefix"><xsl:value-of select="$name"/></xsl:with-param>
	    		</xsl:call-template>
       			</xsl:if>
       		</xsl:when>
       		<xsl:otherwise>
       <xsl:if test="$value!=''">
        <div class="content">
           <xsl:value-of select="$value"/><xsl:copy-of select="$content-after"/>
        </div>
	    <xsl:call-template name="hidden-field">
		     <xsl:with-param name="name"><xsl:value-of select="$name"/>_act_name</xsl:with-param>
		     <xsl:with-param name="prefix"><xsl:value-of select="$name"/></xsl:with-param>
	    </xsl:call-template>
       </xsl:if>
       </xsl:otherwise>
      </xsl:choose>
     </xsl:otherwise>
    </xsl:choose>

     <xsl:if test="$show-product-types='Y'">
	      <xsl:call-template name="select-field">
	      	   <xsl:with-param name="label">XSL_PRODUCT_TYPE</xsl:with-param>
		       <xsl:with-param name="name"><xsl:value-of select="$name"/>_act_product_types</xsl:with-param>
		       <xsl:with-param name="fieldsize">medium</xsl:with-param>
		       <xsl:with-param name="required"><xsl:value-of select="$product-types-required"/></xsl:with-param>
		       <xsl:with-param name="options"/>
	      </xsl:call-template>
     </xsl:if>
     <xsl:call-template name="hidden-field">
	     <xsl:with-param name="name"><xsl:value-of select="$name"/>_act_cur_code</xsl:with-param>
     </xsl:call-template>
     <xsl:if test="$trade_internal_account != 'Y'">    
     <xsl:call-template name="hidden-field">
	     <xsl:with-param name="name"><xsl:value-of select="$name"/>_act_no</xsl:with-param>
     </xsl:call-template>
     </xsl:if>
     <xsl:if test="$trade_internal_account = 'Y'">      
     	<xsl:call-template name="hidden-field">
	    	 <xsl:with-param name="name"><xsl:value-of select="$name"/>_act_name</xsl:with-param>
    	 </xsl:call-template>
     </xsl:if>
     <xsl:call-template name="hidden-field">
	     <xsl:with-param name="name"><xsl:value-of select="$name"/>_act_description</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
	     <xsl:with-param name="name"><xsl:value-of select="$name"/>_act_pab</xsl:with-param>
     </xsl:call-template>
  	</xsl:with-param>
	</xsl:call-template>
   </xsl:template>

   <!--
   		Creates a header with collapsing up and down images with actions. 
   		(Current Usage: User Accounts, Beneficiary Advices)
   -->
   <xsl:template name="animatedFieldSetHeader">
   		<xsl:param name="label"/>
   		<xsl:param name="animateDivId"/>
   		<xsl:param name="prefix"/>
   		<xsl:param name="show">Y</xsl:param>
   		<xsl:param name="onClickFlag">Y</xsl:param> <!-- Show arrows with actions on the header or not -->
   		<div class="animatedFieldSetHeader">
	   		<div class="wipeInOutTabHeader">
	   			<div>
	   				<xsl:attribute name="id"><xsl:value-of select="$prefix"/>_img_down</xsl:attribute>
	   				<xsl:attribute name="style">
					    <xsl:choose>
							<xsl:when test="$show='Y'">display:none;</xsl:when>
							<xsl:when test="$show!='Y' and $onClickFlag = 'Y'">cursor:pointer;</xsl:when>
						</xsl:choose>
					</xsl:attribute>
					<xsl:attribute name="onClick">
						<xsl:if test="$onClickFlag = 'Y'">
							misys.toggleFieldSetContent('<xsl:value-of select="$animateDivId"/>','<xsl:value-of select="$prefix"/>','down');
						</xsl:if>
					</xsl:attribute>
					<xsl:value-of select="$label"/>
					<xsl:if test="$onClickFlag = 'Y'">
					<span class="collapsingImgSpan">
						<img>
							<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($actionDownImage)"/></xsl:attribute>
						</img>
					</span>
					</xsl:if>
				</div>
				<div>
					<xsl:attribute name="style">
						<xsl:choose>
							<xsl:when test="$show!='Y'">display:none;</xsl:when>
							<xsl:when test="$show='Y' and $onClickFlag = 'Y'">cursor:pointer;</xsl:when>
						</xsl:choose>
				    </xsl:attribute>
			        <xsl:attribute name="id"><xsl:value-of select="$prefix"/>_img_up</xsl:attribute>
			        <xsl:attribute name="onClick">
			        	<xsl:if test="$onClickFlag = 'Y'">
			        		misys.toggleFieldSetContent('<xsl:value-of select="$animateDivId"/>','<xsl:value-of select="$prefix"/>','up');
						</xsl:if>
					</xsl:attribute>
					<xsl:value-of select="$label"/>
					<xsl:if test="$onClickFlag = 'Y'">
						<span class="collapsingImgSpan">
							<img>
								<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($actionUpImage)"/></xsl:attribute>
							</img>
						</span>
					</xsl:if>
				</div>
			</div>
		</div>
   </xsl:template>
   
   <xsl:template name="entity-fieldset-wrapper">
   <!-- Required Parameters -->
  
   <!-- Optional -->
   <xsl:param name="legend"/>
   <xsl:param name="legend-type">toplevel-header</xsl:param>
   <xsl:param name="button-type"/>
   <xsl:param name="override-displaymode" select="$displaymode"/>
   <xsl:param name="id"/>
   <xsl:param name="collapsible-prefix"/>
   <xsl:param name="localized">Y</xsl:param>
   <xsl:param name="required">N</xsl:param>
   <xsl:param name="toc-item">Y</xsl:param>
   <xsl:param name="override-product-code"/>
   <!-- 
    Set to N to defer parsing, or if the form will already be parsed due to a parent node of class 'widgetContainer'
   -->
   <xsl:param name="parse-widgets">Y</xsl:param>
   
   <!-- Fieldset content -->
   <xsl:param name="content"/>

   <!-- HTML -->
    <xsl:variable name="legend-content">
      <xsl:choose>
        <xsl:when test="$localized='N'">
          <span class="legend"><xsl:value-of select="$legend"/></span>        
        </xsl:when>
        <xsl:otherwise>
          <span class="legend"><xsl:value-of select="localization:getGTPString($language, $legend)"/></span>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:call-template name="get-button">
        <xsl:with-param name="button-type" select="$button-type"/>
        <xsl:with-param name="label">XSL_ALT_BENEFICIARY</xsl:with-param>
        <xsl:with-param name="non-dijit-button">Y</xsl:with-param>
        <xsl:with-param name="override-product-code"><xsl:value-of select="$override-product-code"/></xsl:with-param>
        <xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="className"><xsl:if test="$parse-widgets='Y'">widgetContainer</xsl:if></xsl:variable>

    <div>
     <xsl:if test="$id != ''">
      <xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
     </xsl:if>
     <xsl:choose>
      <xsl:when test="$legend-type='toplevel-header'">
       <xsl:attribute name="class"><xsl:value-of select="$className"/> toplevel-header</xsl:attribute>
       <xsl:if test="$legend-content != ''">
        <h2>
         <span>
         <xsl:if test="$rundata!='' ">
	        <xsl:call-template name="localization-dblclick">
						<xsl:with-param name="xslName" select="$legend" />
						<xsl:with-param name="localName" select="localization:getGTPString($rundata,$language, $legend)" />
			</xsl:call-template>
			</xsl:if>
	         <xsl:if test="$toc-item = 'Y'"><xsl:attribute name="class">toc-item</xsl:attribute></xsl:if>
	         <xsl:if test="$required = 'Y' and $override-displaymode = 'edit'">
	          <span class="required-field-symbol"><xsl:value-of select="localization:getGTPString($language, 'REQUIRED_PREFIX')"/></span>
	         </xsl:if>
	         <xsl:copy-of select="$legend-content"/>
         </span>
        </h2>
       </xsl:if>
      </xsl:when>
      <xsl:when test="$legend-type='collapsible'">
      <xsl:attribute name="class"><xsl:value-of select="$className"/></xsl:attribute>
       <xsl:if test="$legend-content != ''">
		  	<div class="collapsible-header">
		  		<div class="collapsible-header-inner">
		  		<xsl:attribute name="id"><xsl:value-of select="$collapsible-prefix"/>_collapsible_header</xsl:attribute>
			  		<div>
			  			<span class="legend"><xsl:value-of select="$legend-content"/></span>
			  		</div>
			  		<div class="image">
				  		<img class="collapsible-img">
				  			<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($arrowRightImage)"/></xsl:attribute>
				  			<xsl:attribute name="id"><xsl:value-of select="$collapsible-prefix"/>_collapsible_img</xsl:attribute>
				  		</img>
			  		</div>
		  		</div>
		  	</div>	
       </xsl:if>
      </xsl:when>      
      <xsl:otherwise>
       <xsl:attribute name="class">indented-header</xsl:attribute>
        <xsl:if test="$legend-content != ''">
	        <h3>
	         <span>
	         <xsl:if test="$rundata!='' ">
		        <xsl:call-template name="localization-dblclick">
							<xsl:with-param name="xslName" select="$legend" />
							<xsl:with-param name="localName" select="localization:getGTPString($rundata,$language, $legend)" />
				</xsl:call-template>
				</xsl:if>
		         <xsl:if test="$toc-item = 'Y'"><xsl:attribute name="class">toc-item</xsl:attribute></xsl:if>
		         <xsl:if test="$required = 'Y' and $override-displaymode = 'edit'">
	              <span class="required-field-symbol"><xsl:value-of select="localization:getGTPString($language, 'REQUIRED_PREFIX')"/></span>
	             </xsl:if>
		         <xsl:copy-of select="$legend-content"/>
		     </span>
	        </h3>
       </xsl:if>
      </xsl:otherwise>
     </xsl:choose>
     <div class="fieldset-content">
     	<xsl:if test="$collapsible-prefix != ''">
			<xsl:attribute name="id"><xsl:value-of select="$collapsible-prefix"/>_collapsible_content</xsl:attribute>
		</xsl:if>     	
     	<xsl:if test="$collapsible-prefix != ''">
			<xsl:attribute name="class">collapsible-left-margin</xsl:attribute>     	
		</xsl:if>
    	<xsl:copy-of select="$content"/>
     </div>
    </div>
 </xsl:template>
 
   <!-- This template is used to fetch code data fields for the given code id and product code -->
	<xd:doc>
		
		<xd:short>Form &lt;option&gt; tags by fetching code data fields for the given code id and product code</xd:short>
	<xd:detail>
  	Should be used to pass value to the parameter <code>options</code> for the <code>select-field</code> template, if the select options should be fetched from code data.
	</xd:detail>
		<xd:param name="paramId">Code ID for which values should be fetched. <b>Mandatory</b></xd:param>
		<xd:param name="productCode">Product Code for which values should be filtered. <b>Mandatory</b></xd:param>
	</xd:doc>   
   <xsl:template name="code-data-options"> 
	   	<xsl:param name="paramId" />
	   	<xsl:param name="productCode">*</xsl:param>
	   	<xsl:param name="specificOrder">N</xsl:param>
	   	<xsl:param name="subProductCode">*</xsl:param>
	   	<xsl:param name="exactMatch">N</xsl:param>
	   	<xsl:param name="bankSpecific">N</xsl:param>
	   	<xsl:variable name="codeDataOptions">
	   		<xsl:choose>
	   			<xsl:when test="$subProductCode = '*'">
	 		&lt;code&gt;<xsl:value-of select="utils:buildCodeDataFields($rundata, $productCode ,$paramId,'code_details','code_type','code_description', $specificOrder, $bankSpecific)" />&lt;/code&gt;
	 			</xsl:when>
	 			<xsl:when test="$subProductCode != '*' and $exactMatch = 'Y'">
	 				&lt;code&gt;<xsl:value-of select="utils:makeExactCodeDataFields($rundata, $productCode ,$paramId,'code_details','code_type','code_description', $specificOrder, $subProductCode, $bankSpecific)" />&lt;/code&gt;
	 			</xsl:when>	 			
	 			<xsl:otherwise>
	 				&lt;code&gt;<xsl:value-of select="utils:makeCodeDataFields($rundata, $productCode ,$paramId,'code_details','code_type','code_description', $specificOrder, $subProductCode, $bankSpecific)" />&lt;/code&gt;
	 			</xsl:otherwise>
	 		</xsl:choose>
	 	</xsl:variable>
 		<xsl:for-each select="xmlutils:parse($codeDataOptions)/code/code_details">
	        <option>
	           <xsl:attribute name="value">
	            <xsl:value-of select="code_type"></xsl:value-of>
	           </xsl:attribute>
	           <xsl:value-of select="code_description"/>
	        </option>
      	</xsl:for-each>
   </xsl:template>
   
    <xsl:template name="download-button">
   		<xsl:param name="label"/>
   		<xsl:param name="divId"/>
   		<xsl:param name="showcsv">Y</xsl:param>
   		<xsl:param name="showxls">Y</xsl:param>
   		<xsl:param name="onClickFlag">Y</xsl:param> <!-- Show arrows with actions on the header or not -->
   		<div class="widgetContainer clear exportContainer">
	   		
				<xsl:call-template name="download-button-wrapper">
			      <xsl:with-param name="label">ACTION_USER_DOWNLOAD_FILE</xsl:with-param>
			      <xsl:with-param name="show-image">Y</xsl:with-param>
			      <xsl:with-param name="show-border">Y</xsl:with-param>
			      <!-- <xsl:with-param name="id">DropDownButton</xsl:with-param> -->
			      <xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($previewImage)"/></xsl:with-param>
			      <xsl:with-param name="non-dijit-button">N</xsl:with-param>
		     	</xsl:call-template>
		</div>
   </xsl:template>
   
   
   <xsl:template name="download-button-wrapper">
   <xsl:param name="label"/>
   <xsl:param name="id"/>
   <xsl:param name="onclick"/>
   <xsl:param name="img-src"><xsl:value-of select="utils:getImagePath($searchImage)"/></xsl:param>
   <xsl:param name="img-width"></xsl:param>
   <xsl:param name="img-height"></xsl:param>
   <xsl:param name="show-text-label">Y</xsl:param>
   <xsl:param name="show-image">N</xsl:param>
   <xsl:param name="non-dijit-button">N</xsl:param>
   <xsl:param name="show-border">Y</xsl:param>
   <xsl:param name="disabled">N</xsl:param>
   <xsl:param name="dojo-attach-event"/>
   <xsl:param name="class"/>
   
   <button type="button">
    <xsl:if test="$non-dijit-button='N'"><xsl:attribute name="dojoType">dijit.form.DropDownButton</xsl:attribute></xsl:if>
    <xsl:if test="$onclick!=''"><xsl:attribute name="onclick"><xsl:value-of select="$onclick"/></xsl:attribute></xsl:if>
    <xsl:if test="$id!=''"><xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute></xsl:if>
    <xsl:if test="$disabled='Y'"><xsl:attribute name="disabled">true</xsl:attribute></xsl:if>
    <xsl:attribute name="style">float:right;</xsl:attribute>
    <xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, $label)"/></xsl:attribute>
    <xsl:attribute name="title"><xsl:value-of select="localization:getGTPString($language, $label)"/></xsl:attribute>
   	<span><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_DOWNLOAD_FILE')"/></span> 
    <div class="toolTipFromDropDown" style="outline: none;cursor:pointer;" dojoType="dijit.TooltipDialog">
		<div>
			<a onclick="misys.exportListToFormatInXsl('csv');" href="javascript:void(0);return false;">CSV</a>
			<br/>
			<a onclick="misys.exportListToFormatInXsl('xls'); " href="javascript:void(0);return false;">Spreadsheet</a>
		</div>
    </div>
   </button>
  </xsl:template>
  
  	<xsl:template name="errors">
		<xsl:if test="$displaymode='edit'">
			<div id="errorSection" style="display:none;">
			<p><a href="javascript:void(0)" id="errorLink"><xsl:value-of select="localization:getGTPString($language, 'FORM_ERROR_LINK')"/></a>&nbsp;|&nbsp;<a href="#" id="goto_body">Top</a></p>
			<div id="errorContent" style="display:none;"/>
			</div>
		</xsl:if>
	</xsl:template>

   <xsl:variable name="localization-permission"><xsl:value-of select="localization:checkLocalizationPermission($rundata)"/></xsl:variable>
	 
	<xsl:template name="localization-button">
   		<xsl:param name="xslName"/>
   		<xsl:param name="localName"/>
   		<xsl:if test="$localization-permission='true' and ( $localName!=null or $localName!='')">
   		<div id="buttonsdiv"  >
				<button dojoType="dijit.form.Button" type="button" style=" float:right; position: relative; z-index: 5;">
					<xsl:attribute name="onClick">misys.showLocalizationDialog('<xsl:value-of select="$xslName"/>','<xsl:value-of select="$localName"/>');</xsl:attribute>
				</button>
		</div>
   		</xsl:if>
   </xsl:template>
   <xsl:template name="localization-dblclick">
   		<xsl:param name="xslName"/>
   		<xsl:param name="localName"/>
   		<xsl:if test="$localization-permission='true' and ($localName!=null or $localName!='') and $xslName!='XSL_LOCALIZATION_NEW_VALUE'">
   		<xsl:attribute name="ondblclick">misys.showLocalizationDialog('<xsl:value-of select="$xslName"/>','<xsl:value-of select="$localName"/>');</xsl:attribute>							 	
		</xsl:if>
   </xsl:template>

   <xsl:template name='localization-dialog'>
    <xsl:if test="$localization-permission='true'">
	<xsl:call-template name="dialog">
         <xsl:with-param name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_LOCALIZATION_DETAILS')"/></xsl:with-param>
         <xsl:with-param name="id">localizationDialog</xsl:with-param>
         <xsl:with-param name="content">
          <xsl:call-template name="form-wrapper">
          <xsl:with-param name="name">sendfiles</xsl:with-param>
          <xsl:with-param name="parseFormOnLoad">N</xsl:with-param>
          <xsl:with-param name="enctype">multipart/form-data</xsl:with-param>
          <!-- <xsl:with-param name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/GTPUploadScreen</xsl:with-param>
           --><xsl:with-param name="override-displaymode">edit</xsl:with-param>
          <xsl:with-param name="content">
          <div class="widgetContainer">
               
           <xsl:call-template name="hidden-field">
            <xsl:with-param name="name">xsl_name</xsl:with-param>
            
           </xsl:call-template>
         
          </div>
          <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_LOCALIZATION_NEW_VALUE</xsl:with-param>
           <xsl:with-param name="name">new_title</xsl:with-param>
           <xsl:with-param name="value"/>
           <xsl:with-param name="size">30</xsl:with-param>
           <xsl:with-param name="maxsize">255</xsl:with-param>
           <xsl:with-param name="swift-validate">N</xsl:with-param>
          </xsl:call-template>        
         </xsl:with-param>
         </xsl:call-template>
         </xsl:with-param>
         <xsl:with-param name="buttons">
          <xsl:call-template name="row-wrapper">
           <xsl:with-param name="id">uploadButton</xsl:with-param>
           <xsl:with-param name="content">
            <button dojoType="dijit.form.Button" id="uploadButton" onclick="misys.submitLocalization()" type="button">
             <xsl:attribute name="value"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_SUBMIT')"/></xsl:attribute>
             <xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_SUBMIT')"/>
            </button>
            <button dojoType="dijit.form.Button" id="cancelUpload" onclick="dijit.byId('localizationDialog').hide()" type="button">
             <xsl:attribute name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/></xsl:attribute>
             <xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/>
            </button>
            <button dojoType="dijit.form.Button" id="uploadButton1" onclick="misys.undoLocalization()" type="button">
             <xsl:attribute name="value"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_UNDO')"/></xsl:attribute>
              <xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_UNDO')"/>
            </button>
           </xsl:with-param>
          </xsl:call-template>
         </xsl:with-param>
       
     </xsl:call-template>
     </xsl:if>
    </xsl:template>
    <!-- Text area wrapper for very big textareas -->
	<xsl:template name="big-textarea-wrapper-narrative">
	<xsl:param name="label"></xsl:param>
	<xsl:param name="content"/>
	<xsl:if test="$displaymode='view'">
		<div style="vertical-align: top;">
			<xsl:attribute name="class">
				<xsl:if test="$displaymode!='edit'">field</xsl:if>
			</xsl:attribute>
			<label class="narrativeFieldLabel">
			<xsl:choose>
	 			<xsl:when test="$rundata!='' ">
	 				<xsl:value-of select="localization:getGTPString($rundata,$language, $label)"/>
	 			</xsl:when>
		   		<xsl:otherwise>
		   			<xsl:value-of select="localization:getGTPString($language, $label)"/>
		   		</xsl:otherwise>
		  	</xsl:choose>&nbsp;</label>
			<span class="narrativeFieldValue">
				<xsl:copy-of select="$content"/>
			</span>
		</div>
	</xsl:if>
	</xsl:template> 
   
   <xsl:template name="i-icon-toggle">
   		<xsl:param name="label"/>
   		<xsl:param name="animateDivId"/>
   		<xsl:param name="prefix"/>
   		<xsl:param name="value"/>
   		<xsl:param name="toggleFieldName"/>
   		<xsl:param name="show">Y</xsl:param>
   		<xsl:param name="onClickFlag">Y</xsl:param> <!-- Show arrows with actions on the header or not -->
   		<span class="eyeUpDownHeader">
   			<span class="eyeDownHeader">
   				<xsl:attribute name="id"><xsl:value-of select="$prefix"/>_eye_down</xsl:attribute>
   				<xsl:attribute name="style">
				    <xsl:choose>
						<xsl:when test="$show!='Y'">display:none;</xsl:when>
						<xsl:when test="$show!='Y' and $onClickFlag = 'Y'">cursor:pointer;</xsl:when>
					</xsl:choose>
				</xsl:attribute>
				<xsl:attribute name="onClick">
					<xsl:if test="$onClickFlag = 'Y'">
						misys.toggleEyeSetContent('<xsl:value-of select="$animateDivId"/>','<xsl:value-of select="$prefix"/>','down', '<xsl:value-of select="$value"/>', '<xsl:value-of select="$toggleFieldName"/>');
					</xsl:if>
				</xsl:attribute>
				<xsl:value-of select="$label"/>
				<xsl:if test="$onClickFlag = 'Y'">
				<span class="collapsingEyeImgSpan">
					<img>
						<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($eyeDownImage)"/></xsl:attribute>
					</img>
				</span>
				</xsl:if>
			</span>
			<span class="eyeUpHeader">
				<xsl:attribute name="style">
					<xsl:choose>
						<xsl:when test="$show='Y'">display:none;</xsl:when>
						<xsl:when test="$show='Y' and $onClickFlag = 'Y'">cursor:pointer;</xsl:when>
					</xsl:choose>
			    </xsl:attribute>
		        <xsl:attribute name="id"><xsl:value-of select="$prefix"/>_eye_up</xsl:attribute>
		        <xsl:attribute name="onClick">
		        	<xsl:if test="$onClickFlag = 'Y'">
		        		misys.toggleEyeSetContent('<xsl:value-of select="$animateDivId"/>','<xsl:value-of select="$prefix"/>','up', '<xsl:value-of select="$value"/>', '<xsl:value-of select="$toggleFieldName"/>');
					</xsl:if>
				</xsl:attribute>
				<xsl:value-of select="$label"/>
				<xsl:if test="$onClickFlag = 'Y'">
					<span class="collapsingEyeImgSpan">
						<img>
							<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($eyeUpImage)"/></xsl:attribute>
						</img>
					</span>
				</xsl:if>
			</span>
		</span>
   </xsl:template>
   
</xsl:stylesheet>