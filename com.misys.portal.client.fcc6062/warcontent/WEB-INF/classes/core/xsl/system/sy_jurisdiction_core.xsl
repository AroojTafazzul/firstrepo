<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Jurisdiction Page, System Form.

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
 	 	exclude-result-prefixes="localization utils">

<xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
<xsl:param name="arrowDownImage"><xsl:value-of select="$images_path"/>arrow_down.png</xsl:param>
<xsl:param name="arrowUpImage"><xsl:value-of select="$images_path"/>arrow_up.png</xsl:param>



 <!-- Template for User Details-->
 <xsl:template match="static_user" mode="display">
  <xsl:param name="additional-content"/>
  <xsl:call-template name="static-user-hidden-fields"/>
  <xsl:call-template name="static-user-fields">
   <xsl:with-param name="additional-content"><xsl:copy-of select="$additional-content"/></xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- Hidden Jurisdiction Fields (Static User, Display Mode) -->
 <xsl:template name="static-user-hidden-fields">
  <div class="widgetContainer">
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">brch_code</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">company_id</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">company_abbv_name</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">login_id</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">user_id</xsl:with-param>
   </xsl:call-template>
 </div>
 </xsl:template>
 
 <!--
  Main Jurisdiction Fields (Static User, Display Mode)
  -->
 <xsl:template name="static-user-fields">
  <xsl:param name="additional-content"/>
   	<xsl:param name="firstName"><xsl:value-of select='first_name'/></xsl:param>
	<xsl:param name="lastName"><xsl:value-of select='last_name'/></xsl:param>
	<xsl:param name="defaultStyle">false</xsl:param>
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_USER_DETAILS</xsl:with-param>
   <xsl:with-param name="button-type">
   		<xsl:if test="$hideMasterViewLink!='true'">mc-master-details</xsl:if>
   </xsl:with-param>
   <xsl:with-param name="override-displaymode">edit</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_JURISDICTION_COMPANY</xsl:with-param>
     <xsl:with-param name="id">user_company_abbv_name_view</xsl:with-param>
     <xsl:with-param name="value" select="company_abbv_name"/>
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_JURISDICTION_LOGIN_ID</xsl:with-param>
     <xsl:with-param name="id">login_id_view</xsl:with-param>
     <xsl:with-param name="value" select="login_id"/>
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
	<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_JURISDICTION_NAME</xsl:with-param>
		<xsl:with-param name="id">user_name_view</xsl:with-param>
		<xsl:with-param name="value" select="utils:getFirstNameLastName($firstName,$lastName,$defaultStyle)"/>
		<xsl:with-param name="override-displaymode">view</xsl:with-param>
	</xsl:call-template>
	    <!-- Additional content, usually authorization levels -->
    <xsl:copy-of select="$additional-content"/>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
  
 <!-- Template for Company Details-->
 <xsl:template match="static_company" mode="display">
  <!-- Form #0 : Main Form -->
  <xsl:call-template name="static-company-hidden-fields"/>
  <xsl:call-template name="static-company-fields"/>
 </xsl:template>
 
 <!-- 
  Template for Bank Details
  
  Note - use same templates as company
 -->
 <xsl:template match="static_bank" mode="display">
  <xsl:call-template name="static-company-hidden-fields"/>
  <xsl:call-template name="static-company-fields"/>
 </xsl:template>
 
 <!-- Hidden Jurisdiction Fields (Static Company/Bank, Display Mode) -->
 <xsl:template name="static-company-hidden-fields">
  <div class="widgetContainer">
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">brch_code</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">company_id</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">abbv_name</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">name</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">address_line_1</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">address_line_2</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">dom</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">contact_name</xsl:with-param>
   </xsl:call-template>
  </div>
 </xsl:template>
 
 <!-- Main Jurisdiction Fields (Static Company/Bank, Display Mode) -->
 <xsl:template name="static-company-fields">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_COMPANY_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_JURISDICTION_ABREVIATED_NAME</xsl:with-param>
     <xsl:with-param name="id">company_abbv_name_view</xsl:with-param>
     <xsl:with-param name="value" select="abbv_name"/>
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_JURISDICTION_NAME</xsl:with-param>
     <xsl:with-param name="id">company_name_view</xsl:with-param>
     <xsl:with-param name="value" select="name"/>
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_JURISDICTION_ADDRESS</xsl:with-param>
     <xsl:with-param name="id">address_line_1_view</xsl:with-param>
     <xsl:with-param name="value" select="address_line_1"/>
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
     <xsl:with-param name="id">address_line_2_view</xsl:with-param>
     <xsl:with-param name="value" select="address_line_2"/>
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
     <xsl:with-param name="id">dom_view</xsl:with-param>
     <xsl:with-param name="value" select="dom"/>
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_JURISDICTION_CONTACT_NAME</xsl:with-param>
     <xsl:with-param name="id">contact_name_view</xsl:with-param>
     <xsl:with-param name="value" select="contact_name"/>
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>

 <!-- 
 Template for Roles Input Mode
 -->
 <xsl:template match="group_record" mode="role_input">
  <xsl:param name="dest"/>
  <!-- An alternative destination option may be required ('*' passed if not used) -->
  <xsl:param name="dest_bis"/>
  <xsl:param name="type"/>

  <!-- Form #0 : Main Form -->
  <xsl:call-template name="group-input-hidden-fields">
   <xsl:with-param name="dest" select="$dest"/>
   <xsl:with-param name="type" select="$type"/>
  </xsl:call-template>
  <xsl:call-template name="group-input-fields">
   <xsl:with-param name="dest" select="$dest"/>
   <xsl:with-param name="dest_bis" select="$dest_bis"/>
   <xsl:with-param name="type" select="$type"/>
  </xsl:call-template>
 </xsl:template>
 
 <!--
 Template for Roles Input Mode
 -->
 <xsl:template match="group_record" mode="authorisation_input">
  <xsl:param name="give_all">N</xsl:param>
  <xsl:param name="dest"/>
  <!-- An alternative destination option may be required ('*' passed if not used) -->
  <xsl:param name="dest_bis"/>
  <xsl:param name="type"/>

  <!-- Form #0 : Main Form -->
  <xsl:call-template name="group-auth-hidden-fields">
   <xsl:with-param name="dest" select="$dest"/>
   <xsl:with-param name="type" select="$type"/>
  </xsl:call-template>
  <xsl:call-template name="group-input-fields">
   <xsl:with-param name="dest" select="$dest"/>
   <xsl:with-param name="dest_bis" select="$dest_bis"/>
   <xsl:with-param name="type" select="$type"/>
   <xsl:with-param name="give_all" select="$give_all"/>
  </xsl:call-template>
 </xsl:template>
 
 
 <!-- Hidden Fields (Roles Input Mode) -->
 <xsl:template name="group-input-hidden-fields">
  <xsl:param name="dest"/>
  <xsl:param name="type"/>
  
  <xsl:variable name="prefix">
   <xsl:choose>
    <xsl:when test="$dest='01' or $dest='02'">bank</xsl:when>
    <xsl:when test="$dest='03'">company</xsl:when>
    <xsl:when test="$dest='04'">entity</xsl:when>
   </xsl:choose>
  </xsl:variable>
  
  <div class="widgetContainer">
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_group_abbv_name</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="group_abbv_name"/></xsl:with-param>
   </xsl:call-template>
  </div>
 </xsl:template>
 
 <!-- Main Fields (Roles Input Mode) -->
 <xsl:template name="group-input-fields">
  <xsl:param name="dest"/> <!-- Required -->
  <xsl:param name="dest_bis"/>
  <xsl:param name="type"/> <!-- required -->
  <xsl:param name="give_all">N</xsl:param>
  
  <!-- Choose the name -->
  <xsl:variable name="prefix">
   <xsl:choose>
    <xsl:when test="$dest='01' or $dest='02'">bank</xsl:when>
    <xsl:when test="$dest='03'">company</xsl:when>
     <xsl:when test="$dest='04'">entity</xsl:when>
   </xsl:choose>
  </xsl:variable>
  <xsl:variable name="name">
   <xsl:choose>
    <xsl:when test="$type='01'">role_list</xsl:when>
    <xsl:when test="$type='02'">auth_level</xsl:when>
   </xsl:choose>
  </xsl:variable>
  <div>
    <xsl:if test="$displaymode = 'edit'">
   	  <xsl:attribute name="class">collapse-label</xsl:attribute>
   	</xsl:if>
   	<xsl:if test="$displaymode = 'edit'">
    <xsl:if test="$give_all!='Y'">
      <xsl:call-template name="select-field">
       <xsl:with-param name="id"><xsl:value-of select="$prefix"/>_avail_list_nosend</xsl:with-param>
       <xsl:with-param name="name"></xsl:with-param>
       <xsl:with-param name="type">multiple</xsl:with-param>
       <xsl:with-param name="size">10</xsl:with-param>
       <xsl:with-param name="options">
	     <xsl:apply-templates select="avail_roles/role[(roledest=$dest or roledest=$dest_bis or roledest='*') and (roletype=$type)]" mode="input"/>
       </xsl:with-param>
      </xsl:call-template>
   </xsl:if>
    <div id="add-remove-buttons" class="multiselect-buttons">
     <button dojoType="dijit.form.Button" type="button">
      <xsl:attribute name="onClick">misys.addMultiSelectItems(dijit.byId('<xsl:value-of select="$prefix"/>_<xsl:value-of select="$name"/>'), dijit.byId('<xsl:value-of select="$prefix"/>_avail_list_nosend'));</xsl:attribute>
      <xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_ADD')" />
      <img>
      	<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($arrowDownImage)"/></xsl:attribute>
      	<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_ADD')" /></xsl:attribute>
      </img>
     </button>
     <button dojoType="dijit.form.Button" type="button">
      <xsl:attribute name="onClick">misys.addMultiSelectItems(dijit.byId('<xsl:value-of select="$prefix"/>_avail_list_nosend'), dijit.byId('<xsl:value-of select="$prefix"/>_<xsl:value-of select="$name"/>'))</xsl:attribute>
      <xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REMOVE')" />
       <img>
      	<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($arrowUpImage)"/></xsl:attribute>
      	<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REMOVE')" /></xsl:attribute>
      </img>
     </button>
    </div>
    </xsl:if>
    <xsl:call-template name="select-field">
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_<xsl:value-of select="$name"/></xsl:with-param>
    <xsl:with-param name="type">multiple</xsl:with-param>
    <xsl:with-param name="size">10</xsl:with-param>
    <xsl:with-param name="options">
      <xsl:choose>
	   <xsl:when test="$displaymode='edit'">
	    <xsl:apply-templates select="existing_roles/role[(roledest=$dest or roledest=$dest_bis or roledest='*') and (roletype=$type)]" mode="input"/>
	    <xsl:if test="$give_all = 'Y'">
	     <xsl:apply-templates select="avail_roles/role[(roledest=$dest or roledest=$dest_bis or roledest='*') and (roletype=$type)]" mode="input"/>
	    </xsl:if>
	   </xsl:when>
	   <xsl:otherwise>
	    <ul class="multi-select">
	      <xsl:apply-templates select="existing_roles/role[(roledest=$dest or roledest=$dest_bis or roledest='*') and (roletype=$type)]" mode="input">
	       <xsl:with-param name="mode">text</xsl:with-param>
	      </xsl:apply-templates>
	      <xsl:if test="$give_all = 'Y'">
	       <xsl:apply-templates select="avail_roles/role[(roledest=$dest or roledest=$dest_bis or roledest='*') and (roletype=$type)]" mode="input">
	        <xsl:with-param name="mode">text</xsl:with-param>
	       </xsl:apply-templates>
	      </xsl:if>
	    </ul>
	   </xsl:otherwise>
	  </xsl:choose>
    </xsl:with-param>
   </xsl:call-template>
  </div>
 </xsl:template>
 
 <!-- Template for Authorisation Roles related to a given user Input Mode -->
 <xsl:template match="group_record" mode="user_authorisation_input">
  <xsl:param name="dest"/>      <!-- company type, 01: bank, customer: 03 -->
  <xsl:param name="dest_bis"/>  <!-- An alternative destination option may be required ('*' passed if not used) -->
  <xsl:param name="type"/>      <!-- role type, 01: permission, 02: authorisation -->

	  <xsl:call-template name="group-auth-hidden-fields">
	   <xsl:with-param name="dest" select="$dest"/>
	   <xsl:with-param name="type" select="$type"/>
	  </xsl:call-template>
	  <xsl:call-template name="group-auth-fields">
	   <xsl:with-param name="dest" select="$dest"/>
	   <xsl:with-param name="dest_bis" select="$dest_bis"/>
	   <xsl:with-param name="type" select="$type"/>
	  </xsl:call-template>
 </xsl:template>
 
 <xsl:template name="populateAuthLevels">
  <xsl:param name="dest"/>      <!-- company type, 01: bank, customer: 03 -->
  <xsl:param name="dest_bis"/>  <!-- An alternative destination option may be required ('*' passed if not used) -->
  <xsl:param name="type"/>
 
	  <xsl:call-template name="group-auth-hidden-fields">
	   <xsl:with-param name="dest" select="$dest"/>
	   <xsl:with-param name="type" select="$type"/>
	  </xsl:call-template>
	  <xsl:call-template name="group-auth-fields">
	   <xsl:with-param name="dest" select="$dest"/>
	   <xsl:with-param name="dest_bis" select="$dest_bis"/>
	   <xsl:with-param name="type" select="$type"/>
	  </xsl:call-template>
 </xsl:template>
 
 
<!--  Hidden Fields (Roles Authorisation Input Mode) -->
 <xsl:template name="group-auth-hidden-fields">
  <xsl:param name="dest"/>
  <xsl:param name="type"/>
  
  <xsl:variable name="prefix">
   <xsl:choose>
    <xsl:when test="$dest='01' or $dest='02'">bank</xsl:when>
    <xsl:when test="$dest='03'">company</xsl:when>
   </xsl:choose>
  </xsl:variable>
  
  <div class="widgetContainer">
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_auth_abbv_name_<xsl:value-of select="position()"/></xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="group_abbv_name"/></xsl:with-param>
   </xsl:call-template>
  </div>
 </xsl:template>
 
 <!-- Main Fields (Roles Authorisation Input Mode) -->
 <xsl:template name="group-auth-fields">
  <xsl:param name="dest"/>
  <xsl:param name="dest_bis"/>
  <xsl:param name="type"/>
  
  <xsl:variable name="prefix">
   <xsl:choose>
    <xsl:when test="$dest='01' or $dest='02'">bank</xsl:when>
    <xsl:when test="$dest='03'">company</xsl:when>
   </xsl:choose>
  </xsl:variable>
  
  <xsl:variable name="current"><xsl:value-of select="existing_roles/role[(roledest=$dest or roledest=$dest_bis or roledest='*') and (roletype=$type)]/name"/></xsl:variable>
  <xsl:variable name="currentdesc"><xsl:value-of select="existing_roles/role[(roledest=$dest or roledest=$dest_bis or roledest='*') and (roletype=$type)]/role_description"/></xsl:variable>
  <xsl:variable name="limit_amount"><xsl:value-of select="existing_roles/role[(roledest='03') and (roletype='02')]/limit_amt"/></xsl:variable>
	<xsl:variable name="limit_amount_cur_code"><xsl:value-of select="existing_roles/role[(roledest='03') and (roletype='02')]/limit_cur_code"/></xsl:variable>
  <xsl:if test="$current != '' or $displaymode='edit'">
  <!--  <h3 class="clear" style="margin-left:5px;">
    <xsl:choose>
     <xsl:when test="group_name[.!='' and .!='global']">
      <xsl:value-of select="group_name"/>
     </xsl:when>
     <xsl:when test="group_name[.='global'] and $dest='03'">
      <xsl:value-of select="localization:getDecode($language, 'N001', 'DM')"/>
     </xsl:when>
    </xsl:choose>
   </h3> -->
   
   <!-- select authorisation -->
   <xsl:call-template name="select-field">
    <xsl:with-param name="label">XSL_JURISDICTION_LEVEL</xsl:with-param>
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_auth_level_<xsl:value-of select="position()"/></xsl:with-param>
    <xsl:with-param name="value" select="$current"/>
    <xsl:with-param name="options">
      <xsl:choose>
 	  <xsl:when test="$displaymode='edit'"> 
	   <option>
        <xsl:attribute name="value"><xsl:value-of select="$current"/></xsl:attribute>
        <xsl:value-of select="$currentdesc"/>
       </option>
	   <!--   	   Empty option always allowed for role_2 -->
	   <xsl:if test="$current!=''"><option value=""></option></xsl:if>
	   <!--   	   Other options (only authorisation ones) -->
	   <xsl:apply-templates select="avail_roles/role[name!=$current and (roledest=$dest or roledest=$dest_bis or roledest='*') and (roletype=$type)]" mode="input">
	    <xsl:sort select="role_description" />
	   </xsl:apply-templates>
	  </xsl:when>
	  <xsl:otherwise>
	  	<xsl:choose>
		  	 <xsl:when test="$dest='03'"> 
		  		<xsl:value-of select="$current"/>
		  	</xsl:when>
		  	<xsl:otherwise>
		  		<xsl:value-of select="$currentdesc"/>
		  	</xsl:otherwise>
	  	</xsl:choose>
	  </xsl:otherwise>
 	 </xsl:choose>
    </xsl:with-param>
   </xsl:call-template>
   
   <!-- limit per day -->
   <xsl:if test="$dest='03'">
   
    <xsl:variable name="isLimAmtAvailable"><xsl:value-of select="(existing_roles/role[(roledest='03') and (roletype='02')]/limit_amt) != ''"/></xsl:variable>
    <xsl:if test="$displaymode='edit' or ($displaymode='view' and $isLimAmtAvailable='true')">
		<xsl:call-template name="currency-field">
			<xsl:with-param name="label">XSL_JURISDICTION_LIMIT_PER_DAY</xsl:with-param>
			<xsl:with-param name="override-currency-name">
				<xsl:value-of select="$prefix"/>_limit_cur_code_<xsl:value-of select="position()"/>
			</xsl:with-param>
			<xsl:with-param name="override-amt-name">
				<xsl:value-of select="$prefix"/>_limit_amt_<xsl:value-of select="position()"/>
			</xsl:with-param>
			<xsl:with-param name="show-button">N</xsl:with-param>
			<xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
			<xsl:with-param name="override-currency-value" select="existing_roles/role[(roledest='03') and (roletype='02')]/limit_cur_code"></xsl:with-param>   
			<xsl:with-param name="override-amt-value">
 	 	 	 	<xsl:choose>
 	 	 	 	<xsl:when test="$displaymode='edit'">
 	 	 	 	        <xsl:value-of select="existing_roles/role[(roledest='03') and (roletype='02')]/limit_amt"/>
 	 	 	 	</xsl:when>
 	 	 	 	<xsl:otherwise>
 	 	 	 	        <xsl:value-of select="utils:bigDecimalToAmountString($limit_amount,$limit_amount_cur_code,$language)"/>
 	 	 	 	</xsl:otherwise>
 	 	 	 	</xsl:choose> 
 	 	 	 </xsl:with-param>
		</xsl:call-template>
	</xsl:if>
		<xsl:if test="$displaymode='edit'">
		  <xsl:call-template name="button-wrapper">
			<xsl:with-param name="label">XSL_ALT_CURRENCY</xsl:with-param>
			<xsl:with-param name="show-border">N</xsl:with-param>
			<xsl:with-param name="show-image">Y</xsl:with-param>
			<xsl:with-param name="onclick">
				misys.showSearchDialog('currency',"['<xsl:value-of select="$prefix"/>_limit_cur_code_<xsl:value-of select="position()"/>']", '', '', '', 'width:450px;height:330px;', '<xsl:value-of select="localization:getGTPString($language, 'TABLE_SUMMARY_CURRENCIES_LIST')"/>', '', '');return false;
			</xsl:with-param>
			<xsl:with-param name="id">
				<xsl:value-of select="$prefix"/>_button_img_<xsl:value-of select="position()"/>
			</xsl:with-param>
			<xsl:with-param name="non-dijit-button">N</xsl:with-param>
		  </xsl:call-template>
		</xsl:if>	
	</xsl:if>
  </xsl:if>
 </xsl:template>
 
 <!-- Template for Roles in Control/Display Mode -->
 <xsl:template match="group_record" mode="role_control">
  <xsl:param name="dest"/>
  <xsl:param name="dest_bis"/>
  <xsl:param name="type"/>

  <xsl:variable name="prefix">
   <xsl:choose>
    <xsl:when test="$dest='01'">bank</xsl:when>
    <xsl:when test="$dest='03'">company</xsl:when>
   </xsl:choose>
  </xsl:variable>

  <div>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_group_abbv_name</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="group_abbv_name"/></xsl:with-param>
   </xsl:call-template>
  </div>
  <!-- Disclaimer if no items -->
  <xsl:if test="not(existing_roles/role[(roledest=$dest or roledest=$dest_bis or roledest='*') and (roletype=$type)])">
   <div id="roles_disclaimer"><xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_NO_ROLE')"/></div>
  </xsl:if>
  <ul>
   <xsl:apply-templates select="existing_roles/role[(roledest=$dest or roledest=$dest_bis or roledest='*') and (roletype=$type)]" mode="control"/>
  </ul>
 </xsl:template>
 
 <!-- Template for Roles in Control/Display Mode -->
 <xsl:template match="group_record" mode="authorisation_control">
  <xsl:param name="dest"/>
  <xsl:param name="dest_bis"/>
  <xsl:param name="type"/>
  
  <xsl:variable name="prefix">
   <xsl:choose>
    <xsl:when test="$dest='01'">bank</xsl:when>
    <xsl:when test="$dest='03'">company</xsl:when>
   </xsl:choose>
  </xsl:variable>

  <div>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_auth_abbv_name</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="group_abbv_name"/></xsl:with-param>
   </xsl:call-template>
  </div>
  <ul>
   <xsl:apply-templates select="existing_roles/role[(roledest=$dest or roledest=$dest_bis or roledest='*') and (roletype=$type)]" mode="control"/>
  </ul>
 </xsl:template>
 
 <!-- Template for Roles for users in Control/Display Mode -->
 <xsl:template match="group_record" mode="user_authorisation_control">
  <xsl:param name="dest"/>
  <!-- An alternative destination option may be required ('*' passed if not used) -->
  <xsl:param name="dest_bis"/>
  <xsl:param name="type"/>
  
  <xsl:variable name="current"><xsl:value-of select="existing_roles/role[(roledest=$dest or roledest=$dest_bis or roledest='*') and (roletype=$type)]/name"/></xsl:variable>
  <xsl:variable name="currentdesc"><xsl:value-of select="existing_roles/role[(roledest=$dest or roledest=$dest_bis or roledest='*') and (roletype=$type)]/role_description"/></xsl:variable>
  
  <xsl:variable name="prefix">
   <xsl:choose>
    <xsl:when test="$dest='01'">bank</xsl:when>
    <xsl:when test="$dest='03'">company</xsl:when>
   </xsl:choose>
  </xsl:variable>
  
  <div>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name"><xsl:value-of select="$prefix"/>_auth_abbv_name</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="group_abbv_name"/></xsl:with-param>
   </xsl:call-template>
  </div>
  <div class="field">
   <div class="label">
    <xsl:choose>
     <xsl:when test="group_name[.!='' and .!='global']">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_LEVEL_FOR')"/><xsl:value-of select="group_name"/> (<xsl:value-of select="group_abbv_name"/>):
     </xsl:when>
     <xsl:when test="group_name[.='global'] and $dest='03'">
       <xsl:value-of select="localization:getDecode($language, 'N001', 'DM')"/>:
     </xsl:when>
     <xsl:otherwise>
       <xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_LEVEL')"/>:
     </xsl:otherwise>
    </xsl:choose>
   </div>
   <div class="content">
    <xsl:choose>
     <xsl:when test="$currentdesc!=''"><xsl:value-of select="$currentdesc"/></xsl:when>
     <xsl:otherwise>-</xsl:otherwise>
    </xsl:choose>
   </div>
  </div>
 </xsl:template>
 
 <!-- Template for Role Description (whether already given or still available) in Input Mode -->
 <xsl:template match="avail_roles/role | existing_roles/role" mode="input">

 
  <xsl:choose>
   <xsl:when test="$displaymode='edit'">
    <option>
     <xsl:attribute name="value"><xsl:value-of select="name"/></xsl:attribute>
     <xsl:value-of select="role_description"/>
    </option>
   </xsl:when>
   <xsl:otherwise>
    <li><xsl:value-of select="role_description"/></li>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>

 <!-- Template for Role Description (whether already given or still available) in Control/Display Mode -->
 <xsl:template match="existing_roles/role" mode="control">
  <li><xsl:value-of select="role_description"/> (<xsl:value-of select="name"/>)</li>
 </xsl:template>
</xsl:stylesheet>