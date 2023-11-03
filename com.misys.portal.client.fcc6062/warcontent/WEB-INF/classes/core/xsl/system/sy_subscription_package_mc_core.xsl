<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Subscription Package, System Form.

Copyright (c) 2000-2011 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      03/03/2011
author:    Sam Sundar
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		exclude-result-prefixes="localization">
 
  <!-- 	
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="languages"/>
  <xsl:param name="nextscreen"/>
  <xsl:param name="option"/>
  <xsl:param name="action"/>
  <xsl:param name="displaymode">edit</xsl:param>
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="maintenaceDetails"/>
  
  <xsl:param name="operation">SAVE_FEATURES</xsl:param>
  <xsl:param name="processdttm"/>

  <!-- Global Imports. -->
  <xsl:include href="../common/system_common.xsl" />
  <xsl:include href="../../../core/xsl/system/sy_jurisdiction.xsl" />
  <xsl:include href="../common/maker_checker_common.xsl" />
    
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
   <xsl:apply-templates select="subscription_package_record"/>
  </xsl:template>
  
  
  
  <xsl:template match="subscription_package_record">
   <!-- Loading message  -->
   <xsl:call-template name="loading-message"/>
   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
   	 <xsl:with-param name="name" select="$main-form-name"/>
   	 <xsl:with-param name="validating">Y</xsl:with-param>
   	 <xsl:with-param name="content">
      <xsl:apply-templates select="subscription_package" mode="input"/>
      <xsl:call-template name="roles-attached-to-subscription-package" />
     <xsl:if test="$canCheckerReturnComments = 'true'">
      	<xsl:call-template name="comments-for-return-mc">
      		<xsl:with-param name="value"><xsl:value-of select="subscription_package/return_comments"/></xsl:with-param>
      	</xsl:call-template>
     </xsl:if>
      <xsl:call-template name="maker-checker-menu"/>
     </xsl:with-param>
    </xsl:call-template>
     <xsl:call-template name="realform"/>
   </div>

   <!-- Javascript imports  -->
   <xsl:call-template name="js-imports"/>
  </xsl:template>
  
 <!-- Additional JS imports for this form are -->
 <!-- added here. -->
 <xsl:template name="js-imports">
  <xsl:call-template name="system-common-js-imports">
   <xsl:with-param name="xml-tag-name">subscription_package_record</xsl:with-param>
   <xsl:with-param name="binding">misys.binding.create_subscription</xsl:with-param>
   <xsl:with-param name="override-home-url">'/screen/<xsl:value-of select="$nextscreen"/>?option=<xsl:value-of select="$option"/>'</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
  	<!-- =========================================================================== -->
  	<!-- =================== Template for Basic Package Details in INPUT mode =============== -->
  	<!-- =========================================================================== -->
  	<xsl:template match="subscription_package" mode="input">
  		<xsl:call-template name="fieldset-wrapper">
  		<xsl:with-param name="legend">XSL_HEADER_BASIC_PACKAGE_DETAILS</xsl:with-param>
  		<xsl:with-param name="button-type">
   			<xsl:if test="$hideMasterViewLink!='true'">mc-master-details</xsl:if>
   		</xsl:with-param>
  		<xsl:with-param name="override-displaymode">edit</xsl:with-param>
   			<xsl:with-param name="content">
   			    <xsl:if test="$maintenaceDetails='Y' and creation_date[. !='']">
   			    <xsl:call-template name="input-field">
    				<xsl:with-param name="label">SUBSCRIPTION_PACKAGE_MODIFY_CREATION_DATE</xsl:with-param>
      				<xsl:with-param name="name">creation_date</xsl:with-param>
                    <xsl:with-param name="override-displaymode">view</xsl:with-param>                    
     			</xsl:call-template>
     			</xsl:if>
     			<xsl:if test="$maintenaceDetails='Y' and last_maintenance_date[. !='']">
   			    <xsl:call-template name="input-field">
    				<xsl:with-param name="label">SUBSCRIPTION_PACKAGE_MODIFY_LAST_MAINTENANCE_DATE</xsl:with-param>
      				<xsl:with-param name="name">last_maintenance_date</xsl:with-param>
                    <xsl:with-param name="override-displaymode">view</xsl:with-param>                    
     			</xsl:call-template>
     			</xsl:if>
     			<xsl:if test="$maintenaceDetails='Y' and lastMaintenanceUserName[. !='']">
   			    <xsl:call-template name="input-field">
    				<xsl:with-param name="label">SUBSCRIPTION_PACKAGE_MODIFY_LAST_MAINTENANCE_USER</xsl:with-param>
      				<xsl:with-param name="name">lastMaintenanceUserName</xsl:with-param>
                    <xsl:with-param name="override-displaymode">view</xsl:with-param>                    
     			</xsl:call-template>
     			</xsl:if>
    			<xsl:call-template name="input-field">
    				<xsl:with-param name="label">XSL_JURISDICTION_SUBSCRIPTION_PACKAGE_CODE</xsl:with-param>
      				<xsl:with-param name="name">subscription_code</xsl:with-param>
      				<xsl:with-param name="size">10</xsl:with-param>
     				<xsl:with-param name="maxsize">10</xsl:with-param>
                    <xsl:with-param name="required">Y</xsl:with-param>
     			</xsl:call-template>
     			<xsl:call-template name="input-field">
    				<xsl:with-param name="label">XSL_JURISDICTION_SUBSCRIPTION_PACKAGE_DESCRIPTION</xsl:with-param>
      				<xsl:with-param name="name">subscription_description</xsl:with-param>
      				<xsl:with-param name="size">35</xsl:with-param>
     				<xsl:with-param name="maxsize">35</xsl:with-param>
                    <xsl:with-param name="required">Y</xsl:with-param>
     			</xsl:call-template>
     			<xsl:call-template name="currency-field">
    				<xsl:with-param name="label">XSL_JURISDICTION_SUBSCRIPTION_PACKAGE_STANDARD_CHARGE</xsl:with-param>
    				<xsl:with-param name="product-code">charging</xsl:with-param>
   					<xsl:with-param name="override-currency-value"><xsl:value-of select="charging_cur_code"/></xsl:with-param>
	                <xsl:with-param name="override-amt-value"><xsl:value-of select="standard_charge"/></xsl:with-param>
                    <xsl:with-param name="required">Y</xsl:with-param>
     			</xsl:call-template>
     			<xsl:call-template name="hidden-field">
     				<xsl:with-param name="name">base_currency_nosend</xsl:with-param>
     				<xsl:with-param name="value"><xsl:value-of select="../base_currency"/></xsl:with-param>
     			</xsl:call-template>
     			<xsl:if test="$displaymode='edit'"> 
		     	<xsl:call-template name="multichoice-field">
					<xsl:with-param name="label">XSL_JURISDICTION_SUBSCRIPTION_PACKAGE_APPLY_TAX</xsl:with-param>
					<xsl:with-param name="name">local_tax</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="local_tax"/></xsl:with-param>
					<xsl:with-param name="type">checkbox</xsl:with-param>
				</xsl:call-template>
     			</xsl:if>
     		</xsl:with-param>
  		</xsl:call-template>
  	</xsl:template>
 
 <!-- ***************************************************************************************** -->
 <!-- ************************************** ROLES FORM ********************************** -->
 <!-- ***************************************************************************************** -->
 
 <xsl:template name="roles-attached-to-subscription-package">
 <xsl:call-template name="fieldset-wrapper">
  <xsl:with-param name="legend">XSL_HEADER_SUBSCRIPTION_PACKAGE_ROLES_ATTACHED</xsl:with-param>
  <xsl:with-param name="content">
   <xsl:apply-templates select="group_record" mode="role_input">
	<xsl:with-param name="dest">04</xsl:with-param>
	<xsl:with-param name="dest_bis">*</xsl:with-param>
	<xsl:with-param name="type">01</xsl:with-param>
   </xsl:apply-templates>	
   <!-- 
	 Header for authorisation roles: we now automatically give
 	 all available authorisation levels: this is simulated by hiding
 	 the div and automatically defaulting the authorised levels with
 	 the option give_all=Y
   -->
   <div style="display:none">
   <xsl:call-template name="fieldset-wrapper">
	<xsl:with-param name="legend">XSL_HEADER_LEVELS</xsl:with-param>
	<xsl:with-param name="content">
     <xsl:apply-templates select="group_record" mode="authorisation_input">
	  <xsl:with-param name="dest">04</xsl:with-param>
	  <xsl:with-param name="dest_bis">*</xsl:with-param>
	  <xsl:with-param name="type">02</xsl:with-param>
	  <xsl:with-param name="give_all">Y</xsl:with-param>
	 </xsl:apply-templates>
	</xsl:with-param>
   </xsl:call-template>
   </div>	 	
  </xsl:with-param>
 </xsl:call-template>	
 </xsl:template>
 
 <!-- Template for Permission Description (whether already given or still available) in Input Mode -->


 <!-- ***************************************************************************************** -->
 <!-- ************************************** REALFORM ***************************************** -->
 <!-- ***************************************************************************************** -->
 <xsl:template name="realform">
  <!-- Do not display this section when the counterparty mode is 'counterparty' -->
  <xsl:if test="$collaborationmode != 'counterparty'">
  <xsl:call-template name="form-wrapper">
   <xsl:with-param name="name">realform</xsl:with-param>
   <xsl:with-param name="method">POST</xsl:with-param>
   <xsl:with-param name="action"> <xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$nextscreen"/></xsl:with-param>
    <xsl:with-param name="content">
     <div class="widgetContainer">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">operation</xsl:with-param>
       <xsl:with-param name="id">realform_operation</xsl:with-param>
       <xsl:with-param name="value" select="$operation"></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
       <xsl:with-param name="value">SUBSCRIPTION_PACKAGE_MAINTENANCE_MC</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">token</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$token"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">processdttm</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$processdttm"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:if test="subscription_package/package_id[.!='']">
      	<xsl:call-template name="hidden-field">
       		<xsl:with-param name="name">featureid</xsl:with-param>
       		<xsl:with-param name="value"><xsl:value-of select="subscription_package/package_id"/></xsl:with-param>
      	</xsl:call-template>
      </xsl:if>
      <xsl:if test="subscription_package/tnx_id[.!='']">
      	<xsl:call-template name="hidden-field">
       		<xsl:with-param name="name">tnxid</xsl:with-param>
       		<xsl:with-param name="value"><xsl:value-of select="subscription_package/tnx_id"/></xsl:with-param>
      	</xsl:call-template>
      </xsl:if>
      <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">mode</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$draftMode"/></xsl:with-param>
      </xsl:call-template>
     </div>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:if>
  </xsl:template>
</xsl:stylesheet>