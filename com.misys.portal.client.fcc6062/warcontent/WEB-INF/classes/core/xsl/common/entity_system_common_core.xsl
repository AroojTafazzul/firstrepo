<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
XSLT templates that are common to all system pages (profile,user, bank, company etc).

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      12/03/08
author:    Cormac Flynn
email:     cormac.flynn@misys.com
##########################################################
-->
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
    xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
    exclude-result-prefixes="localization security securityCheck">
    
   
 <xsl:strip-space elements="*"/>

 <!-- Empty global params -->
 <xsl:param name="lowercase-product-code"/>
 <xsl:param name="realform-action"/>
 <xsl:param name="product-code"/>
 <xsl:param name="rundata"/>
 <xsl:param name="mode"/>
 <xsl:param name="hideMasterViewLink" />
 <xsl:param name="dojo-mode"><xsl:value-of select="securityCheck:getDojoMode()" /></xsl:param>

 <!--                                                  -->
 <!-- Common templates for system forms .              -->
 <!--                                                  -->
 <xsl:include href="common.xsl" />
 <xsl:include href="../../../core/xsl/common/form_templates.xsl"/>
 
 
 <!-- ************************************************************** -->
 <!-- ********************* COMMON SYSTEM IMPORTS ****************** -->
 <!-- ************************************************************** -->
 
 <!--
  Common javascript imports for system pages with forms 
  
   Javascript variables
     - context paths and other vars
     - common dojo imports
     - dojo onloads and parser call 
  -->
 <xsl:template name="system-common-js-imports">
  <xsl:param name="xml-tag-name"/>
  <xsl:param name="override-home-url">
   <xsl:choose>
    <xsl:when test="security:isBank($rundata)">'/screen/BankSystemFeaturesScreen'</xsl:when>
    <xsl:otherwise>'/screen/CustomerSystemFeaturesScreen'</xsl:otherwise>
   </xsl:choose>
  </xsl:param>
  <xsl:param name="binding"/>

  <!-- Message for js-disabled users. -->
  <noscript>
   <p><xsl:value-of select="localization:getGTPString($language, 'NOSCRIPT_MSG')"/></p>
   <style type="text/css">
    /* Hide the preloader and form*/
    #loading-message,
    #edit
    {
        display:none;
    }
   </style>
  </noscript>
  <script>
   dojo.ready(function(){
       misys._config = misys._config || {};
       dojo.mixin(misys._config, {
        xmlTagName: '<xsl:value-of select="$xml-tag-name"/>',
        homeUrl: misys.getServletURL(<xsl:value-of select="$override-home-url"/>),
        onlineHelpUrl: misys.getServletURL('/screen/OnlineHelpScreen?helplanguage=<xsl:value-of select="$language"/>&amp;accesskey=<xsl:value-of select="$language"/>'),
        requiredFieldPrefix: '<xsl:value-of select="localization:getGTPString($language, 'REQUIRED_PREFIX')"/>'
       });
       <xsl:if test="$binding != ''">
        dojo.require("<xsl:value-of select="$binding"/>");
       </xsl:if>
   });
  </script>
 </xsl:template>

 <!-- ************************************************************** -->
 <!-- ************************ CURRENCY PART *********************** -->
 <!-- ************************************************************** -->
 
 <xsl:template name="currency-template">
    <xsl:call-template name="input-field">
        <xsl:with-param name="button-type">currency</xsl:with-param>
        <xsl:with-param name="label">XSL_JURISDICTION_BASE_CURRENCY</xsl:with-param>
        <xsl:with-param name="name">base_cur_code</xsl:with-param>
        <xsl:with-param name="value" select="./base_cur_code"></xsl:with-param>
        <!-- to give the name to the javascript, normally it's a product code -->
        <xsl:with-param name="override-product-code">base</xsl:with-param>
        <xsl:with-param name="size">3</xsl:with-param>
        <xsl:with-param name="fieldsize">x-small</xsl:with-param>
        <xsl:with-param name="maxsize">3</xsl:with-param>
        <xsl:with-param name="uppercase">Y</xsl:with-param>
        <xsl:with-param name="required">Y</xsl:with-param>
    </xsl:call-template>
 </xsl:template>
            
 <!-- ************************************************************** -->
 <!-- ************************ PASSWORD PART *********************** -->
 <!-- ************************************************************** -->
 
 <xsl:template name="initial-admin-password">
 <xsl:param name="isE2EEEnabled"/>
  <xsl:if test="company_id[.='']">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_INITIAL_ADMINISTRATOR</xsl:with-param>
    <xsl:with-param name="content">      
     <xsl:choose>
      <xsl:when test="$displaymode = 'edit'">
       <xsl:call-template name="checkbox-field">
        <xsl:with-param name="name">create_admin</xsl:with-param>
        <xsl:with-param name="checked">Y</xsl:with-param>
        <xsl:with-param name="label">XSL_JURISDICTION_ADMINISTRATOR_CHECKBOX</xsl:with-param>
       </xsl:call-template>
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_JURISDICTION_ADMINISTRATOR_PASSWORD</xsl:with-param>
        <xsl:with-param name="id">password_value</xsl:with-param>
        <xsl:with-param name="name"><xsl:if test="$isE2EEEnabled !='true'">password_value</xsl:if></xsl:with-param>
        <xsl:with-param name="size">12</xsl:with-param>
        <xsl:with-param name="maxsize">12</xsl:with-param>
        <xsl:with-param name="type">password</xsl:with-param>
        <xsl:with-param name="fieldsize">small</xsl:with-param>
        <xsl:with-param name="required">Y</xsl:with-param>
        <xsl:with-param name="readonly">Y</xsl:with-param>
       </xsl:call-template>
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_JURISDICTION_CONFIRM_PASSWORD</xsl:with-param>
        <xsl:with-param name="id">password_confirm</xsl:with-param>
        <xsl:with-param name="name"><xsl:if test="$isE2EEEnabled !='true'">password_confirm</xsl:if></xsl:with-param>
        <xsl:with-param name="size">12</xsl:with-param>
        <xsl:with-param name="maxsize">12</xsl:with-param>
        <xsl:with-param name="type">password</xsl:with-param>
        <xsl:with-param name="fieldsize">small</xsl:with-param>
        <xsl:with-param name="required">Y</xsl:with-param>
        <xsl:with-param name="readonly">Y</xsl:with-param>
       </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
       <xsl:call-template name="input-field">
         <xsl:with-param name="label">XSL_JURISDICTION_ADMINISTRATOR_CREATED</xsl:with-param>
            <xsl:with-param name="name">admin_created</xsl:with-param>
            <xsl:with-param name="size">4</xsl:with-param>
            <xsl:with-param name="maxsize">4</xsl:with-param>
            <xsl:with-param name="value">
                <xsl:choose>
                    <xsl:when test="create_admin[.='Y']"><xsl:value-of select="localization:getGTPString($language, 'XSL_YES')"/></xsl:when>
                    <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_NO')"/></xsl:otherwise>
                </xsl:choose>
            </xsl:with-param>
        </xsl:call-template>
      </xsl:otherwise>
     </xsl:choose>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:if>
 </xsl:template>
 
 <!-- ************************************************************** -->
 <!-- ************************ MAINS DETAILS PART ****************** -->
 <!-- ************************************************************** -->
 
<xsl:template name="main-details">
<xsl:param name="addressMandatory">Y</xsl:param>
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_MAIN_DETAILS</xsl:with-param>
   <xsl:with-param name="button-type">
        <xsl:if test="$hideMasterViewLink!='true'">mc-master-details</xsl:if>
   </xsl:with-param>
   <xsl:with-param name="override-displaymode">edit</xsl:with-param>
   <xsl:with-param name="content">
   
        <!-- Abbreviated Name --> 
        <xsl:choose>
        <xsl:when test="company_id[.='']">
            <xsl:call-template name="input-field">
                <xsl:with-param name="label">XSL_COMPANY_ID</xsl:with-param>
                <xsl:with-param name="name">abbv_name</xsl:with-param>
                <!-- "required" indicates that this attribute is a mandatory one -->
                <xsl:with-param name="required">Y</xsl:with-param>
                <xsl:with-param name="uppercase">Y</xsl:with-param>
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
           <xsl:call-template name="input-field">
                <xsl:with-param name="label">XSL_COMPANY_ID</xsl:with-param>
                <xsl:with-param name="id">company_abbv_name_view</xsl:with-param>
                <xsl:with-param name="value" select="abbv_name" />
                <xsl:with-param name="override-displaymode">view</xsl:with-param>
           </xsl:call-template>         
            <xsl:call-template name="hidden-field">
                <xsl:with-param name="name">abbv_name</xsl:with-param>
            </xsl:call-template>
        </xsl:otherwise>
        </xsl:choose>
     
        <!-- Name -->    
        <xsl:call-template name="input-field">
            <xsl:with-param name="label">XSL_JURISDICTION_NAME</xsl:with-param>
            <xsl:with-param name="name">name</xsl:with-param>
            <xsl:with-param name="required">Y</xsl:with-param>
        </xsl:call-template>
        
        <xsl:call-template name="counterparty-details" />
        <!-- Swift Address / Postal f Tabs -->
        <xsl:call-template name="address-details">
            <xsl:with-param name="addressMandatory"><xsl:value-of select="$addressMandatory"/></xsl:with-param>
        </xsl:call-template>
    
        <!-- Contract Reference -->
        <xsl:choose>
            <!-- if bank -->
            <xsl:when test="type[.='01']">
                <xsl:call-template name="input-field">
                    <xsl:with-param name="label">XSL_JURISDICTION_ADDITIONAL_REFERENCE</xsl:with-param>
                    <xsl:with-param name="name">reference</xsl:with-param>
                    <xsl:with-param name="size">34</xsl:with-param>
                    <xsl:with-param name="maxsize">34</xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="input-field">
                    <xsl:with-param name="label">XSL_JURISDICTION_CONTRACT_REFERENCE</xsl:with-param>
                    <xsl:with-param name="name">reference</xsl:with-param>
                    <xsl:with-param name="size">34</xsl:with-param>
                    <xsl:with-param name="maxsize">34</xsl:with-param>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- ************************************************************** -->
 <!-- ************************* ADDRESS TABS *********************** -->
 <!-- ************************************************************** -->
 <!-- 
 Swift Address / Postal Address Tabs 
 
    You must add events to the binding of forms that use this template. Specifically
       
        dojo.connect(dijit.byId('post_code'), 'onBlur', function(){
    dijit.byId('swift_address_address_line_1').set('value',this.get('value'));
      });
  
      dojo.connect(dijit.byId('address_line_1'), 'onBlur', function(){
        dijit.byId('address_address_line_1').set('value',this.get('value'));
      }); 
 
 -->
 <xsl:template name="address-details">
    <xsl:param name="prefix"/>
    <xsl:param name="addressMandatory"/>
        <xsl:variable name="field-prefix">
    <xsl:choose>
        <xsl:when test="$prefix != ''"><xsl:value-of select="$prefix"/>_</xsl:when>
        <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
    </xsl:variable>
     <!-- Swift Address / Postal Address Tabs -->
     <!-- Tabgroup #0 -->
     <xsl:call-template name="tabgroup-wrapper">
      <!-- Tab 0_0 - SWIFT Address  -->
      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
      <xsl:with-param name="tab1-label">XSL_JURISDICTION_TAB_SWIFT_ADDRESS</xsl:with-param>
      <xsl:with-param name="tab1-content">
       <xsl:if test="$addressMandatory = 'Y'">
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_JURISDICTION_ADDRESS</xsl:with-param>
        <xsl:with-param name="name">address_line_1</xsl:with-param>
        <xsl:with-param name="id"><xsl:value-of select="$field-prefix"/>address_line_1</xsl:with-param>
        <xsl:with-param name="required">Y</xsl:with-param>
       </xsl:call-template>
      </xsl:if>
      <xsl:if test="$addressMandatory = 'N'">
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_JURISDICTION_ADDRESS</xsl:with-param>
        <xsl:with-param name="name">address_line_1</xsl:with-param>
        <xsl:with-param name="id"><xsl:value-of select="$field-prefix"/>address_line_1</xsl:with-param>
       </xsl:call-template>
      </xsl:if>
       <xsl:call-template name="input-field">
        <xsl:with-param name="name">address_line_2</xsl:with-param>
        <xsl:with-param name="id"><xsl:value-of select="$field-prefix"/>address_line_2</xsl:with-param>
       </xsl:call-template>
       <xsl:call-template name="input-field">
        <xsl:with-param name="name">dom</xsl:with-param>
        <xsl:with-param name="id"><xsl:value-of select="$field-prefix"/>dom</xsl:with-param>
       </xsl:call-template>
      </xsl:with-param>
      
      <!-- Tab 0_1 - Postal Address  -->
      <xsl:with-param name="tab0-label">XSL_JURISDICTION_TAB_POSTAL_ADDRESS</xsl:with-param>
      <xsl:with-param name="tab0-content">
        <xsl:call-template name="input-field">
         <xsl:with-param name="label">XSL_JURISDICTION_ADDRESS_STREET_NAME</xsl:with-param>
         <xsl:with-param name="name">street_name</xsl:with-param>
         <xsl:with-param name="id"><xsl:value-of select="$prefix"/>_street_name</xsl:with-param>
         <xsl:with-param name="size">35</xsl:with-param>
         <xsl:with-param name="maxsize">35</xsl:with-param>
        </xsl:call-template>    
        <xsl:call-template name="input-field">
         <xsl:with-param name="label">XSL_JURISDICTION_ADDRESS_POST_CODE</xsl:with-param>
         <xsl:with-param name="name">post_code</xsl:with-param>
         <xsl:with-param name="id"><xsl:value-of select="$prefix"/>_post_code</xsl:with-param>
         <xsl:with-param name="size">16</xsl:with-param>
         <xsl:with-param name="maxsize">16</xsl:with-param>
         <xsl:with-param name="fieldsize">small</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="input-field">
         <xsl:with-param name="label">XSL_JURISDICTION_ADDRESS_TOWN_NAME</xsl:with-param>
         <xsl:with-param name="name">town_name</xsl:with-param>
         <xsl:with-param name="id"><xsl:value-of select="$prefix"/>_town_name</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="input-field">
         <xsl:with-param name="label">XSL_JURISDICTION_ADDRESS_COUNTRY_SUB_DIVISION</xsl:with-param>
         <xsl:with-param name="name">country_sub_div</xsl:with-param>
         <xsl:with-param name="id"><xsl:value-of select="$prefix"/>_country_sub_div</xsl:with-param>
        </xsl:call-template>
      </xsl:with-param>
     </xsl:call-template>
     
     <!-- Country Code -->
     <!--<xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_JURISDICTION_COUNTRY</xsl:with-param>
      <xsl:with-param name="name">country</xsl:with-param>
      <xsl:with-param name="id"><xsl:value-of select="$prefix"/>_country</xsl:with-param>
      <xsl:with-param name="size">2</xsl:with-param>
      <xsl:with-param name="maxsize">2</xsl:with-param>
      <xsl:with-param name="fieldsize">x-small</xsl:with-param>
      <xsl:with-param name="uppercase">Y</xsl:with-param>
     </xsl:call-template>-->
     
     
     <xsl:call-template name="country-field">
        <xsl:with-param name="name">country</xsl:with-param>
        <xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
     </xsl:call-template>
     
 </xsl:template>
 
 <!-- ************************************************************** -->
 <!-- **************************** TIME ZONE *********************** -->
 <!-- ************************************************************** -->
 
  <xsl:template name="time_zone-options">
<option value="Africa/Abidjan">Africa/Abidjan</option>
<option value="Africa/Accra">Africa/Accra</option>
<option value="Africa/Addis_Ababa">Africa/Addis_Ababa</option>
<option value="Africa/Algiers">Africa/Algiers</option>
<option value="Africa/Asmera">Africa/Asmera</option>
<option value="Africa/Bamako">Africa/Bamako</option>
<option value="Africa/Bangui">Africa/Bangui</option>
<option value="Africa/Banjul">Africa/Banjul</option>
<option value="Africa/Bissau">Africa/Bissau</option>
<option value="Africa/Blantyre">Africa/Blantyre</option>
<option value="Africa/Brazzaville">Africa/Brazzaville</option>
<option value="Africa/Bujumbura">Africa/Bujumbura</option>
<option value="Africa/Cairo">Africa/Cairo</option>
<option value="Africa/Casablanca">Africa/Casablanca</option>
<option value="Africa/Ceuta">Africa/Ceuta</option>
<option value="Africa/Conakry">Africa/Conakry</option>
<option value="Africa/Dakar">Africa/Dakar</option>
<option value="Africa/Dar_es_Salaam">Africa/Dar_es_Salaam</option>
<option value="Africa/Djibouti">Africa/Djibouti</option>
<option value="Africa/Douala">Africa/Douala</option>
<option value="Africa/El_Aaiun">Africa/El_Aaiun</option>
<option value="Africa/Freetown">Africa/Freetown</option>
<option value="Africa/Gaborone">Africa/Gaborone</option>
<option value="Africa/Harare">Africa/Harare</option>
<option value="Africa/Johannesburg">Africa/Johannesburg</option>
<option value="Africa/Kampala">Africa/Kampala</option>
<option value="Africa/Khartoum">Africa/Khartoum</option>
<option value="Africa/Kigali">Africa/Kigali</option>
<option value="Africa/Kinshasa">Africa/Kinshasa</option>
<option value="Africa/Lagos">Africa/Lagos</option>
<option value="Africa/Libreville">Africa/Libreville</option>
<option value="Africa/Lome">Africa/Lome</option>
<option value="Africa/Luanda">Africa/Luanda</option>
<option value="Africa/Lubumbashi">Africa/Lubumbashi</option>
<option value="Africa/Lusaka">Africa/Lusaka</option>
<option value="Africa/Malabo">Africa/Malabo</option>
<option value="Africa/Maputo">Africa/Maputo</option>
<option value="Africa/Maseru">Africa/Maseru</option>
<option value="Africa/Mbabane">Africa/Mbabane</option>
<option value="Africa/Mogadishu">Africa/Mogadishu</option>
<option value="Africa/Monrovia">Africa/Monrovia</option>
<option value="Africa/Nairobi">Africa/Nairobi</option>
<option value="Africa/Ndjamena">Africa/Ndjamena</option>
<option value="Africa/Niamey">Africa/Niamey</option>
<option value="Africa/Nouakchott">Africa/Nouakchott</option>
<option value="Africa/Ouagadougou">Africa/Ouagadougou</option>
<option value="Africa/Porto-Novo">Africa/Porto-Novo</option>
<option value="Africa/Sao_Tome">Africa/Sao_Tome</option>
<option value="Africa/Timbuktu">Africa/Timbuktu</option>
<option value="Africa/Tripoli">Africa/Tripoli</option>
<option value="Africa/Tunis">Africa/Tunis</option>
<option value="Africa/Windhoek">Africa/Windhoek</option>
<option value="America/Adak">America/Adak</option>
<option value="America/Anchorage">America/Anchorage</option>
<option value="America/Anguilla">America/Anguilla</option>
<option value="America/Antigua">America/Antigua</option>
<option value="America/Araguaina">America/Araguaina</option>
<option value="America/Aruba">America/Aruba</option>
<option value="America/Asuncion">America/Asuncion</option>
<option value="America/Atikokan">America/Atikokan</option>
<option value="America/Atka">America/Atka</option>
<option value="America/Bahia">America/Bahia</option>
<option value="America/Barbados">America/Barbados</option>
<option value="America/Belem">America/Belem</option>
<option value="America/Belize">America/Belize</option>
<option value="America/Blanc-Sablon">America/Blanc-Sablon</option>
<option value="America/Boa_Vista">America/Boa_Vista</option>
<option value="America/Bogota">America/Bogota</option>
<option value="America/Boise">America/Boise</option>
<option value="America/Buenos_Aires">America/Buenos_Aires</option>
<option value="America/Cambridge_Bay">America/Cambridge_Bay</option>
<option value="America/Campo_Grande">America/Campo_Grande</option>
<option value="America/Cancun">America/Cancun</option>
<option value="America/Caracas">America/Caracas</option>
<option value="America/Catamarca">America/Catamarca</option>
<option value="America/Cayenne">America/Cayenne</option>
<option value="America/Cayman">America/Cayman</option>
<option value="America/Chicago">America/Chicago</option>
<option value="America/Chihuahua">America/Chihuahua</option>
<option value="America/Coral_Harbour">America/Coral_Harbour</option>
<option value="America/Cordoba">America/Cordoba</option>
<option value="America/Costa_Rica">America/Costa_Rica</option>
<option value="America/Cuiaba">America/Cuiaba</option>
<option value="America/Curacao">America/Curacao</option>
<option value="America/Danmarkshavn">America/Danmarkshavn</option>
<option value="America/Dawson">America/Dawson</option>
<option value="America/Dawson_Creek">America/Dawson_Creek</option>
<option value="America/Denver">America/Denver</option>
<option value="America/Detroit">America/Detroit</option>
<option value="America/Dominica">America/Dominica</option>
<option value="America/Edmonton">America/Edmonton</option>
<option value="America/Eirunepe">America/Eirunepe</option>
<option value="America/El_Salvador">America/El_Salvador</option>
<option value="America/Ensenada">America/Ensenada</option>
<option value="America/Fort_Wayne">America/Fort_Wayne</option>
<option value="America/Fortaleza">America/Fortaleza</option>
<option value="America/Glace_Bay">America/Glace_Bay</option>
<option value="America/Godthab">America/Godthab</option>
<option value="America/Goose_Bay">America/Goose_Bay</option>
<option value="America/Grand_Turk">America/Grand_Turk</option>
<option value="America/Grenada">America/Grenada</option>
<option value="America/Guadeloupe">America/Guadeloupe</option>
<option value="America/Guatemala">America/Guatemala</option>
<option value="America/Guayaquil">America/Guayaquil</option>
<option value="America/Guyana">America/Guyana</option>
<option value="America/Halifax">America/Halifax</option>
<option value="America/Havana">America/Havana</option>
<option value="America/Hermosillo">America/Hermosillo</option>
<option value="America/Indianapolis">America/Indianapolis</option>
<option value="America/Inuvik">America/Inuvik</option>
<option value="America/Iqaluit">America/Iqaluit</option>
<option value="America/Jamaica">America/Jamaica</option>
<option value="America/Jujuy">America/Jujuy</option>
<option value="America/Juneau">America/Juneau</option>
<option value="America/Knox_IN">America/Knox_IN</option>
<option value="America/La_Paz">America/La_Paz</option>
<option value="America/Lima">America/Lima</option>
<option value="America/Los_Angeles">America/Los_Angeles</option>
<option value="America/Louisville">America/Louisville</option>
<option value="America/Maceio">America/Maceio</option>
<option value="America/Managua">America/Managua</option>
<option value="America/Manaus">America/Manaus</option>
<option value="America/Martinique">America/Martinique</option>
<option value="America/Mazatlan">America/Mazatlan</option>
<option value="America/Mendoza">America/Mendoza</option>
<option value="America/Menominee">America/Menominee</option>
<option value="America/Merida">America/Merida</option>
<option value="America/Mexico_City">America/Mexico_City</option>
<option value="America/Miquelon">America/Miquelon</option>
<option value="America/Moncton">America/Moncton</option>
<option value="America/Monterrey">America/Monterrey</option>
<option value="America/Montevideo">America/Montevideo</option>
<option value="America/Montreal">America/Montreal</option>
<option value="America/Montserrat">America/Montserrat</option>
<option value="America/Nassau">America/Nassau</option>
<option value="America/New_York">America/New_York</option>
<option value="America/Nipigon">America/Nipigon</option>
<option value="America/Nome">America/Nome</option>
<option value="America/Noronha">America/Noronha</option>
<option value="America/Panama">America/Panama</option>
<option value="America/Pangnirtung">America/Pangnirtung</option>
<option value="America/Paramaribo">America/Paramaribo</option>
<option value="America/Phoenix">America/Phoenix</option>
<option value="America/Port_of_Spain">America/Port_of_Spain</option>
<option value="America/Port-au-Prince">America/Port-au-Prince</option>
<option value="America/Porto_Acre">America/Porto_Acre</option>
<option value="America/Porto_Velho">America/Porto_Velho</option>
<option value="America/Puerto_Rico">America/Puerto_Rico</option>
<option value="America/Rainy_River">America/Rainy_River</option>
<option value="America/Rankin_Inlet">America/Rankin_Inlet</option>
<option value="America/Recife">America/Recife</option>
<option value="America/Regina">America/Regina</option>
<option value="America/Rio_Branco">America/Rio_Branco</option>
<option value="America/Rosario">America/Rosario</option>
<option value="America/Santiago">America/Santiago</option>
<option value="America/Santo_Domingo">America/Santo_Domingo</option>
<option value="America/Sao_Paulo">America/Sao_Paulo</option>
<option value="America/Scoresbysund">America/Scoresbysund</option>
<option value="America/Shiprock">America/Shiprock</option>
<option value="America/St_Kitts">America/St_Kitts</option>
<option value="America/St_Lucia">America/St_Lucia</option>
<option value="America/St_Thomas">America/St_Thomas</option>
<option value="America/St_Vincent">America/St_Vincent</option>
<option value="America/Swift_Current">America/Swift_Current</option>
<option value="America/Tegucigalpa">America/Tegucigalpa</option>
<option value="America/Thule">America/Thule</option>
<option value="America/Thunder_Bay">America/Thunder_Bay</option>
<option value="America/Tijuana">America/Tijuana</option>
<option value="America/Toronto">America/Toronto</option>
<option value="America/Tortola">America/Tortola</option>
<option value="America/Vancouver">America/Vancouver</option>
<option value="America/Virgin">America/Virgin</option>
<option value="America/Whitehorse">America/Whitehorse</option>
<option value="America/Winnipeg">America/Winnipeg</option>
<option value="America/Yakutat">America/Yakutat</option>
<option value="America/Yellowknife">America/Yellowknife</option>
<option value="Antarctica/Casey">Antarctica/Casey</option>
<option value="Antarctica/Davis">Antarctica/Davis</option>
<option value="Antarctica/Mawson">Antarctica/Mawson</option>
<option value="Antarctica/McMurdo">Antarctica/McMurdo</option>
<option value="Antarctica/Palmer">Antarctica/Palmer</option>
<option value="Antarctica/Rothera">Antarctica/Rothera</option>
<option value="Antarctica/South_Pole">Antarctica/South_Pole</option>
<option value="Antarctica/Syowa">Antarctica/Syowa</option>
<option value="Antarctica/Vostok">Antarctica/Vostok</option>
<option value="Arctic/Longyearbyen">Arctic/Longyearbyen</option>
<option value="Asia/Aden">Asia/Aden</option>
<option value="Asia/Almaty">Asia/Almaty</option>
<option value="Asia/Amman">Asia/Amman</option>
<option value="Asia/Anadyr">Asia/Anadyr</option>
<option value="Asia/Aqtau">Asia/Aqtau</option>
<option value="Asia/Aqtobe">Asia/Aqtobe</option>
<option value="Asia/Ashgabat">Asia/Ashgabat</option>
<option value="Asia/Ashkhabad">Asia/Ashkhabad</option>
<option value="Asia/Baghdad">Asia/Baghdad</option>
<option value="Asia/Bahrain">Asia/Bahrain</option>
<option value="Asia/Baku">Asia/Baku</option>
<option value="Asia/Bangkok">Asia/Bangkok</option>
<option value="Asia/Beirut">Asia/Beirut</option>
<option value="Asia/Bishkek">Asia/Bishkek</option>
<option value="Asia/Brunei">Asia/Brunei</option>
<option value="Asia/Calcutta">Asia/Calcutta</option>
<option value="Asia/Choibalsan">Asia/Choibalsan</option>
<option value="Asia/Chongqing">Asia/Chongqing</option>
<option value="Asia/Chungking">Asia/Chungking</option>
<option value="Asia/Colombo">Asia/Colombo</option>
<option value="Asia/Dacca">Asia/Dacca</option>
<option value="Asia/Damascus">Asia/Damascus</option>
<option value="Asia/Dhaka">Asia/Dhaka</option>
<option value="Asia/Dili">Asia/Dili</option>
<option value="Asia/Dubai">Asia/Dubai</option>
<option value="Asia/Dushanbe">Asia/Dushanbe</option>
<option value="Asia/Gaza">Asia/Gaza</option>
<option value="Asia/Harbin">Asia/Harbin</option>
<option value="Asia/Hong_Kong">Asia/Hong_Kong</option>
<option value="Asia/Hovd">Asia/Hovd</option>
<option value="Asia/Irkutsk">Asia/Irkutsk</option>
<option value="Asia/Istanbul">Asia/Istanbul</option>
<option value="Asia/Jakarta">Asia/Jakarta</option>
<option value="Asia/Jayapura">Asia/Jayapura</option>
<option value="Asia/Jerusalem">Asia/Jerusalem</option>
<option value="Asia/Kabul">Asia/Kabul</option>
<option value="Asia/Kamchatka">Asia/Kamchatka</option>
<option value="Asia/Karachi">Asia/Karachi</option>
<option value="Asia/Kashgar">Asia/Kashgar</option>
<option value="Asia/Katmandu">Asia/Katmandu</option>
<option value="Asia/Krasnoyarsk">Asia/Krasnoyarsk</option>
<option value="Asia/Kuala_Lumpur">Asia/Kuala_Lumpur</option>
<option value="Asia/Kuching">Asia/Kuching</option>
<option value="Asia/Kuwait">Asia/Kuwait</option>
<option value="Asia/Macao">Asia/Macao</option>
<option value="Asia/Macau">Asia/Macau</option>
<option value="Asia/Magadan">Asia/Magadan</option>
<option value="Asia/Makassar">Asia/Makassar</option>
<option value="Asia/Manila">Asia/Manila</option>
<option value="Asia/Muscat">Asia/Muscat</option>
<option value="Asia/Nicosia">Asia/Nicosia</option>
<option value="Asia/Novosibirsk">Asia/Novosibirsk</option>
<option value="Asia/Omsk">Asia/Omsk</option>
<option value="Asia/Oral">Asia/Oral</option>
<option value="Asia/Phnom_Penh">Asia/Phnom_Penh</option>
<option value="Asia/Pontianak">Asia/Pontianak</option>
<option value="Asia/Pyongyang">Asia/Pyongyang</option>
<option value="Asia/Qatar">Asia/Qatar</option>
<option value="Asia/Qyzylorda">Asia/Qyzylorda</option>
<option value="Asia/Rangoon">Asia/Rangoon</option>
<option value="Asia/Riyadh">Asia/Riyadh</option>
<option value="Asia/Saigon">Asia/Saigon</option>
<option value="Asia/Sakhalin">Asia/Sakhalin</option>
<option value="Asia/Samarkand">Asia/Samarkand</option>
<option value="Asia/Seoul">Asia/Seoul</option>
<option value="Asia/Shanghai">Asia/Shanghai</option>
<option value="Asia/Singapore">Asia/Singapore</option>
<option value="Asia/Taipei">Asia/Taipei</option>
<option value="Asia/Tashkent">Asia/Tashkent</option>
<option value="Asia/Tbilisi">Asia/Tbilisi</option>
<option value="Asia/Tehran">Asia/Tehran</option>
<option value="Asia/Tel_Aviv">Asia/Tel_Aviv</option>
<option value="Asia/Thimbu">Asia/Thimbu</option>
<option value="Asia/Thimphu">Asia/Thimphu</option>
<option value="Asia/Tokyo">Asia/Tokyo</option>
<option value="Asia/Ujung_Pandang">Asia/Ujung_Pandang</option>
<option value="Asia/Ulaanbaatar">Asia/Ulaanbaatar</option>
<option value="Asia/Ulan_Bator">Asia/Ulan_Bator</option>
<option value="Asia/Urumqi">Asia/Urumqi</option>
<option value="Asia/Vientiane">Asia/Vientiane</option>
<option value="Asia/Vladivostok">Asia/Vladivostok</option>
<option value="Asia/Yakutsk">Asia/Yakutsk</option>
<option value="Asia/Yekaterinburg">Asia/Yekaterinburg</option>
<option value="Asia/Yerevan">Asia/Yerevan</option>
<option value="Atlantic/Azores">Atlantic/Azores</option>
<option value="Atlantic/Bermuda">Atlantic/Bermuda</option>
<option value="Atlantic/Canary">Atlantic/Canary</option>
<option value="Atlantic/Cape_Verde">Atlantic/Cape_Verde</option>
<option value="Atlantic/Faeroe">Atlantic/Faeroe</option>
<option value="Atlantic/Jan_Mayen">Atlantic/Jan_Mayen</option>
<option value="Atlantic/Madeira">Atlantic/Madeira</option>
<option value="Atlantic/Reykjavik">Atlantic/Reykjavik</option>
<option value="Atlantic/South_Georgia">Atlantic/South_Georgia</option>
<option value="Atlantic/St_Helena">Atlantic/St_Helena</option>
<option value="Atlantic/Stanley">Atlantic/Stanley</option>
<option value="Australia/ACT">Australia/ACT</option>
<option value="Australia/Adelaide">Australia/Adelaide</option>
<option value="Australia/Brisbane">Australia/Brisbane</option>
<option value="Australia/Broken_Hill">Australia/Broken_Hill</option>
<option value="Australia/Canberra">Australia/Canberra</option>
<option value="Australia/Currie">Australia/Currie</option>
<option value="Australia/Darwin">Australia/Darwin</option>
<option value="Australia/Hobart">Australia/Hobart</option>
<option value="Australia/LHI">Australia/LHI</option>
<option value="Australia/Lindeman">Australia/Lindeman</option>
<option value="Australia/Lord_Howe">Australia/Lord_Howe</option>
<option value="Australia/Melbourne">Australia/Melbourne</option>
<option value="Australia/North">Australia/North</option>
<option value="Australia/NSW">Australia/NSW</option>
<option value="Australia/Perth">Australia/Perth</option>
<option value="Australia/Queensland">Australia/Queensland</option>
<option value="Australia/South">Australia/South</option>
<option value="Australia/Sydney">Australia/Sydney</option>
<option value="Australia/Tasmania">Australia/Tasmania</option>
<option value="Australia/Victoria">Australia/Victoria</option>
<option value="Australia/West">Australia/West</option>
<option value="Australia/Yancowinna">Australia/Yancowinna</option>
<option value="Brazil/West">Brazil/West</option>
<option value="Canada/Atlantic">Canada/Atlantic</option>
<option value="Europe/Amsterdam">Europe/Amsterdam</option>
<option value="Europe/Andorra">Europe/Andorra</option>
<option value="Europe/Athens">Europe/Athens</option>
<option value="Europe/Belfast">Europe/Belfast</option>
<option value="Europe/Belgrade">Europe/Belgrade</option>
<option value="Europe/Berlin">Europe/Berlin</option>
<option value="Europe/Bratislava">Europe/Bratislava</option>
<option value="Europe/Brussels">Europe/Brussels</option>
<option value="Europe/Bucharest">Europe/Bucharest</option>
<option value="Europe/Budapest">Europe/Budapest</option>
<option value="Europe/Chisinau">Europe/Chisinau</option>
<option value="Europe/Copenhagen">Europe/Copenhagen</option>
<option value="Europe/Dublin">Europe/Dublin</option>
<option value="Europe/Gibraltar">Europe/Gibraltar</option>
<option value="Europe/Guernsey">Europe/Guernsey</option>
<option value="Europe/Helsinki">Europe/Helsinki</option>
<option value="Europe/Isle_of_Man">Europe/Isle_of_Man</option>
<option value="Europe/Istanbul">Europe/Istanbul</option>
<option value="Europe/Jersey">Europe/Jersey</option>
<option value="Europe/Kaliningrad">Europe/Kaliningrad</option>
<option value="Europe/Kiev">Europe/Kiev</option>
<option value="Europe/Lisbon">Europe/Lisbon</option>
<option value="Europe/Ljubljana">Europe/Ljubljana</option>
<option value="Europe/London">Europe/London</option>
<option value="Europe/Luxembourg">Europe/Luxembourg</option>
<option value="Europe/Madrid">Europe/Madrid</option>
<option value="Europe/Malta">Europe/Malta</option>
<option value="Europe/Mariehamn">Europe/Mariehamn</option>
<option value="Europe/Minsk">Europe/Minsk</option>
<option value="Europe/Monaco">Europe/Monaco</option>
<option value="Europe/Moscow">Europe/Moscow</option>
<option value="Europe/Nicosia">Europe/Nicosia</option>
<option value="Europe/Oslo">Europe/Oslo</option>
<option value="Europe/Paris">Europe/Paris</option>
<option value="Europe/Podgorica">Europe/Podgorica</option>
<option value="Europe/Prague">Europe/Prague</option>
<option value="Europe/Riga">Europe/Riga</option>
<option value="Europe/Rome">Europe/Rome</option>
<option value="Europe/Samara">Europe/Samara</option>
<option value="Europe/San_Marino">Europe/San_Marino</option>
<option value="Europe/Sarajevo">Europe/Sarajevo</option>
<option value="Europe/Simferopol">Europe/Simferopol</option>
<option value="Europe/Skopje">Europe/Skopje</option>
<option value="Europe/Sofia">Europe/Sofia</option>
<option value="Europe/Stockholm">Europe/Stockholm</option>
<option value="Europe/Tallinn">Europe/Tallinn</option>
<option value="Europe/Tirane">Europe/Tirane</option>
<option value="Europe/Tiraspol">Europe/Tiraspol</option>
<option value="Europe/Uzhgorod">Europe/Uzhgorod</option>
<option value="Europe/Vaduz">Europe/Vaduz</option>
<option value="Europe/Vatican">Europe/Vatican</option>
<option value="Europe/Vienna">Europe/Vienna</option>
<option value="Europe/Vilnius">Europe/Vilnius</option>
<option value="Europe/Volgograd">Europe/Volgograd</option>
<option value="Europe/Warsaw">Europe/Warsaw</option>
<option value="Europe/Zagreb">Europe/Zagreb</option>
<option value="Europe/Zaporozhye">Europe/Zaporozhye</option>
<option value="Europe/Zurich">Europe/Zurich</option>
<option value="Indian/Antananarivo">Indian/Antananarivo</option>
<option value="Indian/Chagos">Indian/Chagos</option>
<option value="Indian/Christmas">Indian/Christmas</option>
<option value="Indian/Cocos">Indian/Cocos</option>
<option value="Indian/Comoro">Indian/Comoro</option>
<option value="Indian/Kerguelen">Indian/Kerguelen</option>
<option value="Indian/Mahe">Indian/Mahe</option>
<option value="Indian/Maldives">Indian/Maldives</option>
<option value="Indian/Mauritius">Indian/Mauritius</option>
<option value="Indian/Mayotte">Indian/Mayotte</option>
<option value="Indian/Reunion">Indian/Reunion</option>
<option value="Pacific/Apia">Pacific/Apia</option>
<option value="Pacific/Auckland">Pacific/Auckland</option>
<option value="Pacific/Chatham">Pacific/Chatham</option>
<option value="Pacific/Easter">Pacific/Easter</option>
<option value="Pacific/Efate">Pacific/Efate</option>
<option value="Pacific/Enderbury">Pacific/Enderbury</option>
<option value="Pacific/Fakaofo">Pacific/Fakaofo</option>
<option value="Pacific/Fiji">Pacific/Fiji</option>
<option value="Pacific/Funafuti">Pacific/Funafuti</option>
<option value="Pacific/Galapagos">Pacific/Galapagos</option>
<option value="Pacific/Guadalcanal">Pacific/Guadalcanal</option>
<option value="Pacific/Guam">Pacific/Guam</option>
<option value="Pacific/Honolulu">Pacific/Honolulu</option>
<option value="Pacific/Johnston">Pacific/Johnston</option>
<option value="Pacific/Kiritimati">Pacific/Kiritimati</option>
<option value="Pacific/Kosrae">Pacific/Kosrae</option>
<option value="Pacific/Kwajalein">Pacific/Kwajalein</option>
<option value="Pacific/Majuro">Pacific/Majuro</option>
<option value="Pacific/Marquesas">Pacific/Marquesas</option>
<option value="Pacific/Midway">Pacific/Midway</option>
<option value="Pacific/Nauru">Pacific/Nauru</option>
<option value="Pacific/Niue">Pacific/Niue</option>
<option value="Pacific/Norfolk">Pacific/Norfolk</option>
<option value="Pacific/Noumea">Pacific/Noumea</option>
<option value="Pacific/Pago_Pago">Pacific/Pago_Pago</option>
<option value="Pacific/Ponape">Pacific/Ponape</option>
<option value="Pacific/Port_Moresby">Pacific/Port_Moresby</option>
<option value="Pacific/Rarotonga">Pacific/Rarotonga</option>
<option value="Pacific/Saipan">Pacific/Saipan</option>
<option value="Pacific/Samoa">Pacific/Samoa</option>
<option value="Pacific/Tahiti">Pacific/Tahiti</option>
<option value="Pacific/Tarawa">Pacific/Tarawa</option>
<option value="Pacific/Tongatapu">Pacific/Tongatapu</option>
<option value="Pacific/Truk">Pacific/Truk</option>
<option value="Pacific/Wake">Pacific/Wake</option>
<option value="Pacific/Wallis">Pacific/Wallis</option>
<option value="Pacific/Yap">Pacific/Yap</option>
  </xsl:template>
  
<!-- 
 Charging account address  with alternative address with 4 lines
 -->
  <xsl:template name="charge-account-address">
    <xsl:param name="prefix"/>
 
     <!-- Swift Address / Postal Address Tabs -->
     <!-- Tabgroup #0 -->
     <xsl:call-template name="tabgroup-wrapper">
      <!-- Tab 0_0 - SWIFT Address  -->
      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
      <xsl:with-param name="tab0-label">XSL_ENTITY_CHARGE_ACCOUNT_ADDRESS</xsl:with-param>
      <xsl:with-param name="tab0-content">
       <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_JURISDICTION_ADDRESS</xsl:with-param>
        <xsl:with-param name="name">address_line_1</xsl:with-param>
        <xsl:with-param name="id"><xsl:value-of select="$prefix"/>_address_line_1</xsl:with-param>
        <xsl:with-param name="maxsize">35</xsl:with-param>
        <xsl:with-param name="readonly">Y</xsl:with-param>
        <xsl:with-param name="required">Y</xsl:with-param>
       </xsl:call-template>
       <xsl:call-template name="input-field">
        <xsl:with-param name="name">address_line_2</xsl:with-param>
        <xsl:with-param name="id"><xsl:value-of select="$prefix"/>_address_line_2</xsl:with-param>
        <xsl:with-param name="readonly">Y</xsl:with-param>
       </xsl:call-template>
        <xsl:call-template name="input-field">
        <xsl:with-param name="name">address_line_3</xsl:with-param>
        <xsl:with-param name="id"><xsl:value-of select="$prefix"/>_address_line_3</xsl:with-param>
        <xsl:with-param name="readonly">Y</xsl:with-param>
       </xsl:call-template>
       <xsl:call-template name="input-field">
        <xsl:with-param name="name">address_line_4</xsl:with-param>
        <xsl:with-param name="id"><xsl:value-of select="$prefix"/>_address_line_4</xsl:with-param>
        <xsl:with-param name="readonly">Y</xsl:with-param>
       </xsl:call-template>
      </xsl:with-param>
      
      <!-- Tab 0_1 - Postal Address  -->
      <xsl:with-param name="tab1-label">XSL_ENTITY_ALTERNATIVE_ADDRESS</xsl:with-param>
      <xsl:with-param name="tab1-content">
        <xsl:call-template name="input-field">
         <xsl:with-param name="label">XSL_JURISDICTION_ADDRESS</xsl:with-param>
         <xsl:with-param name="name">alternative_address_line_1</xsl:with-param>
         <xsl:with-param name="id"><xsl:value-of select="$prefix"/>_alternative_address_line_1</xsl:with-param>
         <xsl:with-param name="size">40</xsl:with-param>
         <xsl:with-param name="maxsize">35</xsl:with-param>
        </xsl:call-template>    
        <xsl:call-template name="input-field">
         <xsl:with-param name="name">alternative_address_line_2</xsl:with-param>
         <xsl:with-param name="id"><xsl:value-of select="$prefix"/>_alternative_address_line_2</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="input-field">
         <xsl:with-param name="name">alternative_address_line_3</xsl:with-param>
         <xsl:with-param name="id"><xsl:value-of select="$prefix"/>_alternative_address_line_3</xsl:with-param>
        </xsl:call-template>
         <xsl:call-template name="input-field">
         <xsl:with-param name="name">alternative_address_line_4</xsl:with-param>
         <xsl:with-param name="id"><xsl:value-of select="$prefix"/>_alternative_address_line_4</xsl:with-param>
        </xsl:call-template>
      </xsl:with-param>
      
      <!-- Tab 0_2 - Postal Address  -->
      <xsl:with-param name="tab2-label">XSL_JURISDICTION_TAB_POSTAL_ADDRESS</xsl:with-param>
      <xsl:with-param name="tab2-content">
        <xsl:call-template name="input-field">
         <xsl:with-param name="label">XSL_JURISDICTION_ADDRESS_STREET_NAME</xsl:with-param>
         <xsl:with-param name="name">street_name</xsl:with-param>
         <xsl:with-param name="id"><xsl:value-of select="$prefix"/>_street_name</xsl:with-param>
         <xsl:with-param name="size">35</xsl:with-param>
         <xsl:with-param name="maxsize">35</xsl:with-param>
        </xsl:call-template>    
        <xsl:call-template name="input-field">
         <xsl:with-param name="label">XSL_JURISDICTION_ADDRESS_POST_CODE</xsl:with-param>
         <xsl:with-param name="name">post_code</xsl:with-param>
         <xsl:with-param name="id"><xsl:value-of select="$prefix"/>_post_code</xsl:with-param>
         <xsl:with-param name="size">16</xsl:with-param>
         <xsl:with-param name="maxsize">16</xsl:with-param>
         <xsl:with-param name="fieldsize">small</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="input-field">
         <xsl:with-param name="label">XSL_JURISDICTION_ADDRESS_TOWN_NAME</xsl:with-param>
         <xsl:with-param name="name">town_name</xsl:with-param>
         <xsl:with-param name="id"><xsl:value-of select="$prefix"/>_town_name</xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="input-field">
         <xsl:with-param name="label">XSL_JURISDICTION_ADDRESS_COUNTRY_SUB_DIVISION</xsl:with-param>
         <xsl:with-param name="name">country_sub_div</xsl:with-param>
         <xsl:with-param name="id"><xsl:value-of select="$prefix"/>_country_sub_div</xsl:with-param>
        </xsl:call-template>
      </xsl:with-param>
     </xsl:call-template>
     
     <!-- Country Code -->
   <xsl:call-template name="country-field">
        <xsl:with-param name="name">country</xsl:with-param>
        <xsl:with-param name="required">Y</xsl:with-param>
        <xsl:with-param name="prefix"><xsl:value-of select="$prefix"/></xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_JURISDICTION_ADDRESS_BEI_SWIFT</xsl:with-param>
      <xsl:with-param name="name">bei</xsl:with-param>
      <xsl:with-param name="size">11</xsl:with-param>
      <xsl:with-param name="maxsize">11</xsl:with-param>
      <xsl:with-param name="uppercase">Y</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_JURISDICTION_EMAIL</xsl:with-param>
      <xsl:with-param name="name">email</xsl:with-param>
      <xsl:with-param name="size">40</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="contact_email"/></xsl:with-param>
      <xsl:with-param name="maxsize">255</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_CONTACT_PERSON</xsl:with-param>
      <xsl:with-param name="name">contact_person</xsl:with-param>
      <xsl:with-param name="size">40</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
      <xsl:with-param name="maxsize">255</xsl:with-param>
    </xsl:call-template>
 </xsl:template>
 
 <xsl:template name="e2ee-details">
    <xsl:param name="_e2EESessionId"/>
    <xsl:param name="rsa_exp"/>
    <xsl:param name="rsa_mod"/>
    <xsl:param name="_e2EERandomNum"/>
    <xsl:param name="isE2EEEnabled"/>
    <xsl:param name="form_name"/>
    <xsl:param name="changepassword">N</xsl:param>
    <xsl:param name="passwordprovided">Y</xsl:param>
    <xsl:param name="passwordfldName">password</xsl:param>
    <xsl:param name="_e2EEPki"/>
    <xsl:if test="$isE2EEEnabled ='true'">
    <xsl:call-template name="hidden-field">
         <xsl:with-param name="name">e2ee_sid</xsl:with-param>
         <xsl:with-param name="value"><xsl:value-of select="$_e2EESessionId"/></xsl:with-param>
    </xsl:call-template>
    <xsl:choose>
        <xsl:when test="($changepassword='Y' )and ($passwordprovided='Y')">
            <xsl:call-template name="hidden-field">
                <xsl:with-param name="name">e2ee_rpin2</xsl:with-param>
                <xsl:with-param name="value"></xsl:with-param>
            </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
            <xsl:call-template name="hidden-field">
                <xsl:with-param name="name">e2ee_rpin</xsl:with-param>
                <xsl:with-param name="value"></xsl:with-param>
            </xsl:call-template>
        </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="$passwordprovided ='N'">
        <xsl:call-template name="hidden-field">
            <xsl:with-param name="name">e2ee_pki</xsl:with-param>
            <xsl:with-param name="value"><xsl:value-of select="$_e2EEPki"/></xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="hidden-field">
            <xsl:with-param name="name">e2ee_server_random</xsl:with-param>
            <xsl:with-param name="value"><xsl:value-of select="$_e2EERandomNum"/></xsl:with-param>
        </xsl:call-template>
    </xsl:if>
    <xsl:choose>
    <xsl:when test="$dojo-mode = 'DEBUG_ALL' or $dojo-mode = 'DEBUG' ">
        <script type="text/javascript"> 
            <xsl:attribute name="src"><xsl:value-of select="$contextPath"/>/content/js-src/misys/isprint/e2ee.js</xsl:attribute> 
        </script>
    </xsl:when>
    <xsl:otherwise>
        <script type="text/javascript"> 
            <xsl:attribute name="src"><xsl:value-of select="$contextPath"/>/content/js/misys/isprint/e2ee.js</xsl:attribute>
        </script>
    </xsl:otherwise>
    </xsl:choose>
    <script>
    dojo.ready(function(){
        function _getRPIN(pin, rsa_exp, rsa_mod, randomNumber, sessionId) 
        {
            try
            {
            var loginPIN = encryptLoginPin(pin, rsa_exp, rsa_mod, randomNumber.slice());
            return formatEncryptionResult (sessionId, loginPIN, '');
            }
            catch(e)
            {
            alert('Technical Problem, failed to encrypt the password.');
            return '';
            }
        }
        function _getRPIN2(old_pin, new_pin, rsa_exp, rsa_mod, randomNumber, sessionId)
        {
           try
           {
            var resetPIN1 = encryptLoginPin(new_pin, rsa_exp, rsa_mod, randomNumber.slice());
            var resetPIN2 = encryptResetPin(old_pin, new_pin, rsa_exp, rsa_mod, randomNumber.slice());
            return formatEncryptionResult(sessionId, resetPIN1, resetPIN2);
           }
           catch(e)
           {
           alert('Technical Problem, failed to encrypt the password.');
           return '';
           }
        }
        misys._e2ee = misys._e2ee || {}; 
        
        dojo.mixin(misys._e2ee, {
            rsa_exp :'<xsl:value-of select="$rsa_exp"/>',
            rsa_mod :'<xsl:value-of select="$rsa_mod"/>',
            randomNumber :'<xsl:value-of select="$_e2EERandomNum"/>',
            sessionId :'<xsl:value-of select="$_e2EESessionId"/>'
        });
        
        dojo.mixin(misys, {
        onFormSubmit:function() {
                    console.debug("Submitting Login Form");
                    if(dijit.byId('<xsl:value-of select="$form_name"/>').validate())
                    {   <xsl:choose>    
                         <xsl:when test="($changepassword='Y' )and ($passwordprovided='Y')">
                            var passwdfield = dijit.byId('<xsl:value-of select="$passwordfldName"/>');var passwordValue = passwdfield.get('value');
                            var newpasswdfield = dijit.byId('password_value');var newpasswordValue = newpasswdfield.get('value');
                            var newpasswdfieldconfirm = dijit.byId('password_confirm'); var newpasswordValueconfirm= newpasswdfieldconfirm.get('value');
                            var encValue = _getRPIN2(passwordValue,newpasswordValue, misys._e2ee.rsa_exp, misys._e2ee.rsa_mod, misys._e2ee.randomNumber, misys._e2ee.sessionId);
                            newpasswdfield.set("required",false);newpasswdfield.set('value','');
                            newpasswdfieldconfirm.set("required",false);newpasswdfieldconfirm.set('value','');
                            passwdfield.set("required",false);passwdfield.set('value','');
                            dijit.byId('e2ee_rpin2').set('value',encValue);
                        </xsl:when>
                         <xsl:when test="($changepassword='Y') and ($passwordprovided='N')">
                            var newpasswdfield = dijit.byId('password_value');var newpasswordValue = newpasswdfield.get('value');
                            var newpasswdfieldconfirm = dijit.byId('password_confirm'); var newpasswordValueconfirm= newpasswdfieldconfirm.get('value');
                            var encValue = _getRPIN(newpasswordValue, misys._e2ee.rsa_exp, misys._e2ee.rsa_mod, misys._e2ee.randomNumber, misys._e2ee.sessionId);
                            newpasswdfield.set("required",false);newpasswdfield.set('value','');
                            newpasswdfieldconfirm.set("required",false);newpasswdfieldconfirm.set('value','');
                            dijit.byId('e2ee_rpin').set('value',encValue);
                        </xsl:when>
                        <xsl:when test="($changepassword='N') and ($passwordprovided='Y') ">
                            var passwdfield = dijit.byId('<xsl:value-of select="$passwordfldName"/>');var passwordValue = passwdfield.get('value');
                            var encValue = _getRPIN(passwordValue, misys._e2ee.rsa_exp, misys._e2ee.rsa_mod, misys._e2ee.randomNumber, misys._e2ee.sessionId);
                            passwdfield.set("required",false);passwdfield.set('value','');
                            dijit.byId('e2ee_rpin').set('value',encValue);
                        </xsl:when>
                        </xsl:choose>   
                        return true;
                   }else{
                   return false;
                   }
                }
        });
    });   
    </script>
    </xsl:if>
    <xsl:if test="$isE2EEEnabled != 'true'">
    <script>
         dojo.ready(function(){dojo.mixin(misys, {  onFormSubmit:function() {
         console.debug("Submitting Login Form");
         if(dijit.byId('<xsl:value-of select="$form_name"/>').validate()){
            return true;
         }else{
            return false;
         }
         }});});   
    </script>
    </xsl:if>
 </xsl:template>
 
 <xsl:template name="e2ee-resetpwd-details">
    <xsl:param name="_e2EESessionId"/>
    <xsl:param name="rsa_exp"/>
    <xsl:param name="rsa_mod"/>
    <xsl:param name="_e2EERandomNum"/>
    <xsl:param name="isE2EEEnabled"/>
    <xsl:param name="form_name"/>
    <xsl:param name="passwordfldName">password</xsl:param>
    <xsl:param name="_e2EEPki"/>
    <xsl:param name="systemonly">0</xsl:param><!-- 1 - System ,!=1 otherwise manual and system -->
    
    <xsl:choose>
    <xsl:when test="$isE2EEEnabled ='true' and $systemonly !='1'">
    <xsl:call-template name="hidden-field">
         <xsl:with-param name="name">e2ee_sid</xsl:with-param>
         <xsl:with-param name="value"><xsl:value-of select="$_e2EESessionId"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">e2ee_rpin</xsl:with-param>
        <xsl:with-param name="value"></xsl:with-param>
    </xsl:call-template>
        
        <xsl:call-template name="hidden-field">
            <xsl:with-param name="name">e2ee_pki</xsl:with-param>
            <xsl:with-param name="value"><xsl:value-of select="$_e2EEPki"/></xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="hidden-field">
            <xsl:with-param name="name">e2ee_server_random</xsl:with-param>
            <xsl:with-param name="value"><xsl:value-of select="$_e2EERandomNum"/></xsl:with-param>
        </xsl:call-template>
    <xsl:choose>
    <xsl:when test="$dojo-mode = 'DEBUG_ALL' or $dojo-mode = 'DEBUG' "> 
    <script type="text/javascript" > 
         <xsl:attribute name="src"><xsl:value-of select="$contextPath"/>/content/js-src/misys/isprint/e2ee.js</xsl:attribute>  
    </script>
    </xsl:when>
    <xsl:otherwise>
    <script type="text/javascript" > 
    <xsl:attribute name="src"><xsl:value-of select="$contextPath"/>/content/js/misys/isprint/e2ee.js</xsl:attribute>
    </script>
    </xsl:otherwise>
    </xsl:choose>
    <script>
    dojo.ready(function(){
        
            function _getRPIN(pin, rsa_exp, rsa_mod, randomNumber, sessionId) 
            {
                try
                {
                var loginPIN = encryptLoginPin(pin, rsa_exp, rsa_mod, randomNumber.slice());
                return formatEncryptionResult (sessionId, loginPIN, '');
            }
                catch(e)
                {
                alert('Technical Problem, failed to encrypt the password.');
                return '';
                }
            }
           
        misys._e2ee = misys._e2ee || {}; 
        dojo.mixin(misys._e2ee, {
            rsa_exp :'<xsl:value-of select="$rsa_exp"/>',
            rsa_mod :'<xsl:value-of select="$rsa_mod"/>',
            randomNumber :'<xsl:value-of select="$_e2EERandomNum"/>',
            sessionId :'<xsl:value-of select="$_e2EESessionId"/>'
        });
        dojo.mixin(misys, {
        beforeSubmitValidations:function() {
                    if(dijit.byId("password_type_1") &amp;&amp; dijit.byId("password_type_1").get("checked"))
                        {   return true;
                        }
                        else{
                    if(dijit.byId('<xsl:value-of select="$form_name"/>').validate())
                            {       var newpasswdfield = dijit.byId('password_value');var newpasswordValue = newpasswdfield.get('value');
                            var newpasswdfieldconfirm = dijit.byId('password_confirm'); var newpasswordValueconfirm= newpasswdfieldconfirm.get('value');
                                    var encValue = _getRPIN(newpasswordValue, misys._e2ee.rsa_exp, misys._e2ee.rsa_mod, misys._e2ee.randomNumber, misys._e2ee.sessionId);
                            newpasswdfield.set("required",false);newpasswdfield.set('value','');
                            newpasswdfieldconfirm.set("required",false);newpasswdfieldconfirm.set('value','');
                        dijit.byId('e2ee_rpin').set('value',encValue);
                        return true;
                   }
                   return false;
          }
              }
            });
        });   
        </script>
    </xsl:when>
    <xsl:when test="$isE2EEEnabled ='true' and $systemonly ='1'">
        <script>
        dojo.ready(function(){
            dojo.mixin(misys, {
             beforeSubmitValidations : function() {
             var changepwdfld = dijit.byId('change_password');
             if(changepwdfld){
                    if(!changepwdfld.checked){
                        var displayMessage = misys.getLocalization("changepasswordMandatory");
                        //focus on the widget and set state to error and display a tooltip indicating the same
                        changepwdfld.focus();
                        //changepwdfld.set("state","Error");
                        dijit.hideTooltip(changepwdfld.domNode);
                        dijit.showTooltip(displayMessage, changepwdfld.domNode,['above','before'],5000);
                        return false;
                    }
                }
             return true;
            }
        });
    });   
    </script>
        
        
    </xsl:when>
    
    </xsl:choose>
</xsl:template>
 
<xsl:template name="e2ee-change-profile-details">
    <xsl:param name="_e2EESessionId"/>
    <xsl:param name="rsa_exp"/>
    <xsl:param name="rsa_mod"/>
    <xsl:param name="_e2EERandomNum"/>
    <xsl:param name="isE2EEEnabled"/>
    <xsl:param name="form_name"/>
    <xsl:param name="passwordfldName">password</xsl:param>
    <xsl:if test="$isE2EEEnabled ='true'">
    <xsl:call-template name="hidden-field">
         <xsl:with-param name="name">e2ee_sid</xsl:with-param>
         <xsl:with-param name="value"><xsl:value-of select="$_e2EESessionId"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
                <xsl:with-param name="name">e2ee_rpin2</xsl:with-param>
        <xsl:with-param name="value"></xsl:with-param>
    </xsl:call-template>
    <xsl:choose>
    <xsl:when test="$dojo-mode = 'DEBUG_ALL' or $dojo-mode = 'DEBUG' "> 
    <script type="text/javascript"> 
        <xsl:attribute name="src"><xsl:value-of select="$contextPath"/>/content/js-src/misys/isprint/e2ee.js</xsl:attribute> 
    </script>
    </xsl:when>
    <xsl:otherwise>
    <script type="text/javascript" >    
        <xsl:attribute name="src"><xsl:value-of select="$contextPath"/>/content/js/misys/isprint/e2ee.js</xsl:attribute>
    </script>
    </xsl:otherwise>
    </xsl:choose>

    <script>
    dojo.ready(function(){
        
                    function _getRPIN2(old_pin, new_pin, rsa_exp, rsa_mod, randomNumber, sessionId)
                    {   
                        try
                        {
                        var resetPIN1 = encryptLoginPin(new_pin, rsa_exp, rsa_mod, randomNumber.slice());
                        var resetPIN2 = encryptResetPin(old_pin, new_pin, rsa_exp, rsa_mod, randomNumber.slice());
                        return formatEncryptionResult(sessionId, resetPIN1, resetPIN2);
                    }
                        catch(e)
                        {
                        alert('Technical Problem, failed to encrypt the password.');
                        return '';
                        }
                    }
        misys._e2ee = misys._e2ee || {}; 
        dojo.mixin(misys._e2ee, {
            rsa_exp :'<xsl:value-of select="$rsa_exp"/>',
            rsa_mod :'<xsl:value-of select="$rsa_mod"/>',
            randomNumber :'<xsl:value-of select="$_e2EERandomNum"/>',
            sessionId :'<xsl:value-of select="$_e2EESessionId"/>'
        });
        dojo.mixin(misys, {
                        beforeSubmitValidations:function() {
                            if(dijit.byId('<xsl:value-of select="$form_name"/>').validate())
                            {       var passwdfield = dijit.byId('<xsl:value-of select="$passwordfldName"/>');var passwordValue = passwdfield.get('value');
                                    var newpasswdfield = dijit.byId('password_value');var newpasswordValue = newpasswdfield.get('value');
                                    var newpasswdfieldconfirm = dijit.byId('password_confirm'); var newpasswordValueconfirm= newpasswdfieldconfirm.get('value');
                                    var encValue = _getRPIN2(passwordValue,newpasswordValue, misys._e2ee.rsa_exp, misys._e2ee.rsa_mod, misys._e2ee.randomNumber, misys._e2ee.sessionId);
                                    newpasswdfield.set("required",false);newpasswdfield.set('value','');
                                    newpasswdfieldconfirm.set("required",false);newpasswdfieldconfirm.set('value','');
                                    passwdfield.set("required",false);passwdfield.set('value','');
                                    dijit.byId('e2ee_rpin2').set('value',encValue);
                                    return true;
                              }
                        return false;
                              
                        }
                    });
               });   
            </script>
    </xsl:if>
</xsl:template>

 <xsl:template name="e2ee-otp-field-details">
    <xsl:param name="e2ee_server_random"/>
    <xsl:param name="e2ee_pubkey"/>
    <xsl:param name="e2ee_pki"/>
    <xsl:param name="isE2EEOTPEnabled"/>
    <xsl:param name="form_name"/>
    <xsl:param name="fieldName"/>
    <xsl:if test="$isE2EEOTPEnabled ='true'">
    <xsl:call-template name="hidden-field">
         <xsl:with-param name="name">e2ee_pki</xsl:with-param>
         <xsl:with-param name="value"><xsl:value-of select="$e2ee_pki"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
         <xsl:with-param name="name">e2ee_server_random</xsl:with-param>
         <xsl:with-param name="value"><xsl:value-of select="$e2ee_server_random"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">e2ee_rpin</xsl:with-param>
        <xsl:with-param name="value"></xsl:with-param>
    </xsl:call-template>
    
    <xsl:choose>
    <xsl:when test="$dojo-mode = 'DEBUG_ALL' or $dojo-mode = 'DEBUG' ">
    <script type="text/javascript">
        <xsl:attribute name="src"><xsl:value-of select="$contextPath"/>/content/js-src/misys/isprint/json2.js</xsl:attribute>
    </script>
    <script type="text/javascript">
        <xsl:attribute name="src"><xsl:value-of select="$contextPath"/>/content/js-src/misys/isprint/amdp.js</xsl:attribute>
    </script>
    <script type="text/javascript"> 
        <xsl:attribute name="src"><xsl:value-of select="$contextPath"/>/content/js-src/misys/isprint/amcrypto.js</xsl:attribute>
    </script>
    </xsl:when>
    <xsl:otherwise>
    <script type="text/javascript">
        <xsl:attribute name="src"><xsl:value-of select="$contextPath"/>/content/js/misys/isprint/json2.js</xsl:attribute>
    </script>
    <script type="text/javascript">
        <xsl:attribute name="src"><xsl:value-of select="$contextPath"/>/content/js/misys/isprint/amdp.js</xsl:attribute>
    </script>
    <script type="text/javascript"> 
        <xsl:attribute name="src"><xsl:value-of select="$contextPath"/>/content/js/misys/isprint/amcrypto.js</xsl:attribute>
    </script>
    </xsl:otherwise>
    </xsl:choose>
    
    <script>
    dojo.ready(function(){
        misys._e2eeotp = misys._e2eeotp|| {}; 
        dojo.mixin(misys._e2eeotp, {
            cipherparams :'{\"hash\":false}',
            cipherparams_hash :'{\"hash\":true,\"hashAlgo\":\"SHA-256\"}',
            ra :'<xsl:value-of select="$e2ee_server_random"/>',
            pk :'<xsl:value-of select="$e2ee_pubkey"/>'
        });
        dojo.mixin(misys, {
        onFormSubmit:function() {
                    console.debug("Submitting OTP Form");
                    if(dijit.byId('<xsl:value-of select="$form_name"/>').validate())
                    {   
                        
                            var fieldToEE = dijit.byId('<xsl:value-of select="$fieldName"/>');var valueToEE = fieldToEE.get('value');
                            var encValue = amdp.encrypt(misys._e2eeotp.cipherparams,misys._e2eeotp.pk,misys._e2eeotp.ra,valueToEE);
                            fieldToEE.set("required",false);fieldToEE.set('value','');
                            dijit.byId('e2ee_rpin').set('value',encValue);
                            
                            return true;
                    }else{
                            return false;
                    }
          }
        });
        
    });   
    </script>
    </xsl:if>
    
 </xsl:template>
 
 <xsl:template name="counterparty-details">
    <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">is_counterparty_company</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_JURISDICTION_COUNTERPARTY_ERP_ID</xsl:with-param>
        <xsl:with-param name="name">erp_id</xsl:with-param>
        <xsl:with-param name="value"><xsl:value-of select="static_beneficiary_info/erp_id"/></xsl:with-param>
        <xsl:with-param name="size">35</xsl:with-param>
        <xsl:with-param name="maxsize">35</xsl:with-param>
        <xsl:with-param name="fieldsize">small</xsl:with-param>
        <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_JURISDICTION_COUNTERPARTY_LEGAL_ID_NO</xsl:with-param>
        <xsl:with-param name="name">legal_id_no</xsl:with-param>
        <xsl:with-param name="value"><xsl:value-of select="static_beneficiary_info/legal_id_no"/></xsl:with-param>
        <xsl:with-param name="size">15</xsl:with-param>
        <xsl:with-param name="maxsize">15</xsl:with-param>
        <xsl:with-param name="fieldsize">small</xsl:with-param>
        <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_JURISDICTION_COUNTERPARTY_ACCOUNT</xsl:with-param>
        <xsl:with-param name="name">account</xsl:with-param>
        <xsl:with-param name="value"><xsl:value-of select="static_beneficiary_info/account"/></xsl:with-param>
        <xsl:with-param name="size">15</xsl:with-param>
        <xsl:with-param name="maxsize">15</xsl:with-param>
        <xsl:with-param name="fieldsize">small</xsl:with-param>
        <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_BENEFICIARY_SWIFT_BIC_CODE</xsl:with-param>
        <xsl:with-param name="name">bank_iso_code</xsl:with-param>
        <xsl:with-param name="value"><xsl:value-of select="static_beneficiary_info/bank_iso_code"/></xsl:with-param>
        <xsl:with-param name="size">11</xsl:with-param>
        <xsl:with-param name="maxsize">11</xsl:with-param>
        <xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
        <xsl:with-param name="swift-validate">N</xsl:with-param>
        <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
    <!-- BANK NAME -->
    <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_BENEFICIARY_BANK_NAME</xsl:with-param>
        <xsl:with-param name="name">bank_name</xsl:with-param>
        <xsl:with-param name="value"><xsl:value-of select="static_beneficiary_info/bank_name"/></xsl:with-param>
        <xsl:with-param name="size">35</xsl:with-param>
        <xsl:with-param name="maxsize">35</xsl:with-param>
        <xsl:with-param name="swift-validate">N</xsl:with-param>
        <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
    <!-- BANK ADDRESS -->
    <xsl:call-template name="input-field">
        <xsl:with-param name="label">XSL_BENEFICIARY_BANK_ADDRESS</xsl:with-param>
        <xsl:with-param name="name">bank_address_line_1</xsl:with-param>
        <xsl:with-param name="value"><xsl:value-of select="static_beneficiary_info/bank_address_line_1"/></xsl:with-param>
        <xsl:with-param name="size">35</xsl:with-param>
        <xsl:with-param name="maxsize">35</xsl:with-param>
        <xsl:with-param name="swift-validate">N</xsl:with-param>
        <xsl:with-param name="override-displaymode">view</xsl:with-param>
        </xsl:call-template>
    <xsl:call-template name="input-field">
        <xsl:with-param name="name">bank_address_line_2</xsl:with-param>
        <xsl:with-param name="value"><xsl:value-of select="static_beneficiary_info/bank_address_line_2"/></xsl:with-param>
        <xsl:with-param name="size">35</xsl:with-param>
        <xsl:with-param name="maxsize">35</xsl:with-param>
        <xsl:with-param name="swift-validate">N</xsl:with-param>
        <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
        <xsl:with-param name="name">bank_dom</xsl:with-param>
        <xsl:with-param name="value"><xsl:value-of select="static_beneficiary_info/bank_dom"/></xsl:with-param>
        <xsl:with-param name="size">35</xsl:with-param>
        <xsl:with-param name="maxsize">35</xsl:with-param>
        <xsl:with-param name="swift-validate">N</xsl:with-param>
        <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
    <!-- FSCM Programme Conditions -->
    <xsl:for-each select="//*[starts-with(name(),'access_opened_prog_')]">
        <xsl:if test=".='Y'">
        <div class="field">
            <span class="label">
                <xsl:choose>
                        <xsl:when test="starts-with(name(),'access_opened_prog_01')">
                        <xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_COUNTERPARTY_PAYMENT_CONDITIONS_01')"/>
                    </xsl:when>
                        <xsl:when test="starts-with(name(),'access_opened_prog_02')">
                        <xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_COUNTERPARTY_PAYMENT_CONDITIONS_02')"/>
                    </xsl:when>
                        <xsl:when test="starts-with(name(),'access_opened_prog_03')">
                        <xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_COUNTERPARTY_PAYMENT_CONDITIONS_03')"/>
                    </xsl:when>
                </xsl:choose>
            </span>
            <div class="content">
                <xsl:call-template name="textarea-field">
                     <xsl:with-param name="name">
                        <xsl:choose>
                                <xsl:when test="starts-with(name(),'access_opened_prog_01')">conditions_01</xsl:when>
                                <xsl:when test="starts-with(name(),'access_opened_prog_02')">conditions_02</xsl:when>
                                <xsl:when test="starts-with(name(),'access_opened_prog_03')">conditions_03</xsl:when>
                        </xsl:choose>
                     </xsl:with-param>
                     <xsl:with-param name="rows">10</xsl:with-param>
                     <xsl:with-param name="cols">60</xsl:with-param>
                     <xsl:with-param name="maxlines">25</xsl:with-param>
                     <xsl:with-param name="swift-validate">N</xsl:with-param>
                     <xsl:with-param name="button-type">phrase</xsl:with-param>
                     <xsl:with-param name="phrase-params">{override_abbv_name_field:fscm_abbv_name}</xsl:with-param>
                </xsl:call-template>
            </div>
        </div>
    </xsl:if>
    </xsl:for-each>
 </xsl:template>
 
  <xsl:template name="e2ee-resetpwd-cpty-details">
    <xsl:param name="_e2EESessionId"/>
    <xsl:param name="rsa_exp"/>
    <xsl:param name="rsa_mod"/>
    <xsl:param name="_e2EERandomNum"/>
    <xsl:param name="isE2EEEnabled"/>
    <xsl:param name="form_name"/>
    <xsl:param name="passwordfldName">password</xsl:param>
    <xsl:param name="_e2EEPki"/>
    <xsl:param name="debugMode">false</xsl:param>
 
    
    
    <xsl:if test="$isE2EEEnabled ='true' ">
    <xsl:call-template name="hidden-field">
         <xsl:with-param name="name">e2ee_sid</xsl:with-param>
         <xsl:with-param name="value"><xsl:value-of select="$_e2EESessionId"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">e2ee_rpin</xsl:with-param>
        <xsl:with-param name="value"></xsl:with-param>
    </xsl:call-template>
        
        <xsl:call-template name="hidden-field">
            <xsl:with-param name="name">e2ee_pki</xsl:with-param>
            <xsl:with-param name="value"><xsl:value-of select="$_e2EEPki"/></xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="hidden-field">
            <xsl:with-param name="name">e2ee_server_random</xsl:with-param>
            <xsl:with-param name="value"><xsl:value-of select="$_e2EERandomNum"/></xsl:with-param>
        </xsl:call-template>
    <script type="text/javascript" > 
        <xsl:choose> 
         <xsl:when test="$debugMode ='true'">
                <xsl:attribute name="src"><xsl:value-of select="$contextPath"/>/content/js-src/misys/isprint/e2ee.js</xsl:attribute> 
        </xsl:when>
        <xsl:otherwise>
            <xsl:attribute name="src"><xsl:value-of select="$contextPath"/>/content/js/misys/isprint/e2ee.js</xsl:attribute>
        </xsl:otherwise>
        </xsl:choose> 
    </script>
    <script>
    dojo.ready(function(){
        
            function _getRPIN(pin, rsa_exp, rsa_mod, randomNumber, sessionId) 
            {
                try
                {
                var loginPIN = encryptLoginPin(pin, rsa_exp, rsa_mod, randomNumber.slice());
                return formatEncryptionResult (sessionId, loginPIN, '');
            }
                catch(e)
                {
                alert('Technical Problem, failed to encrypt the password.');
                return '';
                }
            }
           
        misys._e2ee = misys._e2ee || {}; 
        dojo.mixin(misys._e2ee, {
            rsa_exp :'<xsl:value-of select="$rsa_exp"/>',
            rsa_mod :'<xsl:value-of select="$rsa_mod"/>',
            randomNumber :'<xsl:value-of select="$_e2EERandomNum"/>',
            sessionId :'<xsl:value-of select="$_e2EESessionId"/>'
        });
        dojo.mixin(misys, {
        beforeSubmitValidations:function() {
                    if(dijit.byId("reset_password") &amp;&amp; dijit.byId("reset_password").get("checked"))
                        {
                            if(dijit.byId('<xsl:value-of select="$form_name"/>').validate())
                                    {       var newpasswdfield = dijit.byId('password_value');var newpasswordValue = newpasswdfield.get('value');
                                    var newpasswdfieldconfirm = dijit.byId('password_confirm'); var newpasswordValueconfirm= newpasswdfieldconfirm.get('value');
                                            var encValue = _getRPIN(newpasswordValue, misys._e2ee.rsa_exp, misys._e2ee.rsa_mod, misys._e2ee.randomNumber, misys._e2ee.sessionId);
                                    newpasswdfield.set("required",false);newpasswdfield.set('value','');
                                    newpasswdfieldconfirm.set("required",false);newpasswdfieldconfirm.set('value','');
                                dijit.byId('e2ee_rpin').set('value',encValue);
                                return true;
                           }
                           return false;
                     }
                     else
                    {
                        return true;
                    }
                     
              }
            });
        });   
        </script>
    </xsl:if>
</xsl:template>
<!-- password policy fields -->
 <xsl:template name="e2ee-password-policy">
    <xsl:param name="password_mimimum_length"/>
    <xsl:param name="password_maximum_length"/>
    <xsl:param name="password_charset"/>
    <xsl:param name="allowUserNameInPasswordValue"/>
    <script>
    dojo.ready(function(){
        misys._e2ee = misys._e2ee || {}; 
        dojo.mixin(misys._e2ee, {
                password_mimimum_length :'<xsl:value-of select="$password_mimimum_length"/>',
                password_maximum_length :'<xsl:value-of select="$password_maximum_length"/>',
                password_charset :'<xsl:value-of select="$password_charset"/>',
                allowUserNameInPasswordValue :'<xsl:value-of select="$allowUserNameInPasswordValue"/>'
        });
    });   
    </script>
</xsl:template>
 
</xsl:stylesheet>