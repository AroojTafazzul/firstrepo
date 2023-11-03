<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Role Screen, System Form.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      29/04/08
author:    Laure Blin
##########################################################
-->
<xsl:stylesheet 
        version="1.0" 
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
        xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
        xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
        exclude-result-prefixes="localization securitycheck">
 
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
  <xsl:param name="operation"/>
  <xsl:param name="token"/>
   <xsl:param name="processdttm"/>
    <xsl:param name="return_comments"/>
	<xsl:param name="operation">SAVE_FEATURES</xsl:param>
  <!-- Global Imports. -->
  <xsl:include href="../common/system_common.xsl" />
  <xsl:include href="sy_jurisdiction.xsl" />
  <xsl:include href="../../../core/xsl/common/maker_checker_common.xsl" />
  <xsl:include href="../../../core/xsl/common/e2ee_common.xsl" />
    
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
   <xsl:apply-templates select="roles_record"/>
  </xsl:template>
  
  <xsl:template match="roles_record">
   <!-- Loading message  -->
   <xsl:call-template name="loading-message"/>
  
   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
      <xsl:call-template name="hidden-fields"/>
      <xsl:call-template name="role-details"/>
      <!--  Display common menu. -->
         <xsl:if test="$canCheckerReturnComments = 'true'">
      	<xsl:call-template name="comments-for-return-mc">
      		<xsl:with-param name="value"><xsl:value-of select="static_bank/return_comments"/></xsl:with-param>
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
  
 <!--                                     -->  
 <!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
 <!--                                     -->
 
 <!-- Additional JS imports for this form are -->
 <!-- added here. -->
 <xsl:template name="js-imports">
  <xsl:call-template name="system-common-js-imports">
   <xsl:with-param name="xml-tag-name">roles_record</xsl:with-param>
   <xsl:with-param name="binding">misys.binding.system.role</xsl:with-param>
   <xsl:with-param name="override-home-url">'/screen/<xsl:value-of select="$nextscreen"/>?option=<xsl:value-of select="$option"/>'</xsl:with-param>
   <xsl:with-param name="override-help-access-key">BGM_06</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are  -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
 </xsl:template>
 
 <!-- ***************************************************************************************** -->
 <!-- ************************************* STATIC ROLE FORM ********************************** -->
 <!-- ***************************************************************************************** -->
 <xsl:template name="role-details">
 <div class="widgetContainer">

  <!-- Show the company details: in jurisdiction.xsl  -->
  <xsl:apply-templates select="static_company" mode="display"/>
		
  <!-- Show the bank details: in jurisdiction.xsl -->
  <xsl:apply-templates select="static_bank" mode="display"/>
  <!-- Show the user details: in jurisdiction.xsl -->
  <xsl:apply-templates select="static_user" mode="display">
   <xsl:with-param name="additional-content">
    <xsl:if test="static_user and company_type[.='01' or .='02']">
     <!-- Disable DM (Document Management)
     	<xsl:apply-templates select="group_record" mode="user_authorisation_input">
     -->
     <xsl:apply-templates select="group_record[group_name='global']" mode="user_authorisation_input">
	  <xsl:with-param name="dest">01</xsl:with-param>
	  <xsl:with-param name="dest_bis">02</xsl:with-param>
	  <xsl:with-param name="type">02</xsl:with-param>
	 </xsl:apply-templates>
    </xsl:if>       
   </xsl:with-param>
  </xsl:apply-templates>
  
  <xsl:choose>
   <!-- Show the roles setup for a company -->
   <xsl:when test="static_company">
	<xsl:call-template name="static_company"/>
   </xsl:when> 
   <!-- Show the roles setup for a bank -->
   <xsl:when test="static_bank">
    <xsl:call-template name="static_bank"/>
   </xsl:when>      
   <!-- Show the roles setup for a bank user -->
   <xsl:when test="static_user and company_type[.='01' or .='02']">
    <xsl:call-template name="static_user_type_1_2"/>
   </xsl:when>       
   <!-- Show the roles setup for a customer user -->
   <xsl:when test="static_user and company_type[.='03']">
  	<xsl:call-template name="static_user_type_3"/>
   </xsl:when>
  </xsl:choose>
  
  </div>
 </xsl:template>
 
 <!-- =========================================================================== -->
 <!-- ======================== Template STATIC COMPANY  ========================= -->
 <!-- =========================================================================== -->
 <xsl:template name="static_company">
 <xsl:call-template name="fieldset-wrapper">
  <xsl:with-param name="legend">XSL_HEADER_COMPANY_ROLES</xsl:with-param>
  <xsl:with-param name="content">
     <xsl:apply-templates select="group_record" mode="role_input">
	<xsl:with-param name="dest">03</xsl:with-param>
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
	  <xsl:with-param name="dest">03</xsl:with-param>
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
  
 <!-- =========================================================================== -->
 <!-- =========================== Template STATIC BANK  ========================= --> 
 <!-- =========================================================================== -->
 <xsl:template name="static_bank">
 <!-- Header for bank roles -->
 <xsl:call-template name="fieldset-wrapper">
  <xsl:with-param name="legend">XSL_HEADER_BANK_ROLES</xsl:with-param>
  <xsl:with-param name="content">
   <xsl:apply-templates select="group_record" mode="role_input">
    <!-- Only bank group roles are given -->
    <xsl:with-param name="dest"><xsl:value-of select="static_bank/type"/></xsl:with-param>
    <xsl:with-param name="dest_bis">*</xsl:with-param>
	<xsl:with-param name="type">01</xsl:with-param>
   </xsl:apply-templates>
   
   <div class="clear"></div>

    <!-- Header for authorisation roles: we now automatically give
    all available authorisation levels: this is simulated by hidding
    the div and automatically defaulting the authorised levels with
    the option give_all=Y -->
   <div style="display:none">
    <xsl:call-template name="fieldset-wrapper">
	 <xsl:with-param name="legend">XSL_HEADER_AVAILABLE_ROLES</xsl:with-param>
	 <xsl:with-param name="content">
	  <xsl:apply-templates select="group_record" mode="authorisation_input">
	   <xsl:with-param name="dest">01</xsl:with-param>
	   <xsl:with-param name="dest_bis">*</xsl:with-param>
	   <xsl:with-param name="type">02</xsl:with-param>
	   <xsl:with-param name="give_all">Y</xsl:with-param>
	  </xsl:apply-templates>
	 </xsl:with-param>
    </xsl:call-template>
   </div>	
  </xsl:with-param>
 </xsl:call-template>
   		  
 <!-- Header for company roles -->
 <xsl:call-template name="fieldset-wrapper">
  <xsl:with-param name="legend">XSL_HEADER_COMPANY_ROLES</xsl:with-param>
  <xsl:with-param name="content">			
	<xsl:apply-templates select="group_record" mode="role_input">
     <xsl:with-param name="dest">03</xsl:with-param>
	 <xsl:with-param name="dest_bis">*</xsl:with-param>
	 <xsl:with-param name="type">01</xsl:with-param>
	</xsl:apply-templates>
   					
<!--	 Header for authorisation roles: we now automatically give-->
<!-- 		all available authorisation levels: this is simulated by hidding-->
<!-- 		the div and automatically defaulting the authorised levels with-->
<!-- 		the option give_all=Y -->
    <div style="display:none">
     <xsl:call-template name="fieldset-wrapper">
	  <xsl:with-param name="legend">XSL_HEADER_AVAILABLE_ROLES</xsl:with-param>
	  <xsl:with-param name="content">
	   <xsl:apply-templates select="group_record" mode="authorisation_input">
	   <xsl:with-param name="dest">03</xsl:with-param>
		<xsl:with-param name="dest_bis">*</xsl:with-param>
		<xsl:with-param name="type">02</xsl:with-param>
		<xsl:with-param name="give_all">Y</xsl:with-param>
	   </xsl:apply-templates>
   	  </xsl:with-param>
   	</xsl:call-template>
   </div>
  </xsl:with-param>
 </xsl:call-template>
  <!-- Header for entity roles -->
<xsl:if test="entity_role_access[.='Y']">
 <xsl:call-template name="fieldset-wrapper">
  <xsl:with-param name="legend">XSL_HEADER_ENTITY_ROLES</xsl:with-param>
  <xsl:with-param name="content">			
	<xsl:apply-templates select="group_record" mode="role_input">
     <xsl:with-param name="dest">04</xsl:with-param>
	 <xsl:with-param name="dest_bis">*</xsl:with-param>
	 <xsl:with-param name="type">01</xsl:with-param>
	</xsl:apply-templates>
   					
<!--	 Header for authorisation roles: we now automatically give-->
<!-- 		all available authorisation levels: this is simulated by hidding-->
<!-- 		the div and automatically defaulting the authorised levels with-->
<!-- 		the option give_all=Y -->
    <div style="display:none">
     <xsl:call-template name="fieldset-wrapper">
	  <xsl:with-param name="legend">XSL_HEADER_AVAILABLE_ROLES</xsl:with-param>
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
 </xsl:if>
</xsl:template>
	
	<!-- =========================================================================== -->
  	<!-- =================== Template STATIC USER/COMPANY TYPE 1 OR 2  ============= -->
  	<!-- =========================================================================== -->
	<xsl:template name="static_user_type_1_2">
		<!-- Header for global roles -->
		<xsl:call-template name="fieldset-wrapper">
   			<xsl:with-param name="legend">XSL_HEADER_ROLES</xsl:with-param>
   			<xsl:with-param name="content">
   			   				
				<xsl:apply-templates select="group_record" mode="role_input">
					<!-- Only bank group roles are given -->
					<xsl:with-param name="dest"><xsl:value-of select="company_type"/></xsl:with-param>
					<xsl:with-param name="dest_bis">*</xsl:with-param>
					<xsl:with-param name="type">01</xsl:with-param>
				</xsl:apply-templates>

   			</xsl:with-param>
   		</xsl:call-template>
	</xsl:template>
	
	<!-- =========================================================================== -->
  	<!-- =================== Template STATIC USER/COMPANY TYPE 3  ================== -->
  	<!-- =========================================================================== -->
	<xsl:template name="static_user_type_3">
		<!-- Header for authorisation roles -->
		<xsl:call-template name="fieldset-wrapper">
   			<xsl:with-param name="legend">XSL_HEADER_LEVELS</xsl:with-param>
   			<xsl:with-param name="content">
   				<xsl:apply-templates select="group_record[group_name!='global']" mode="user_authorisation_input">
					<xsl:with-param name="dest">03</xsl:with-param>
					<xsl:with-param name="dest_bis">*</xsl:with-param>
					<xsl:with-param name="type">02</xsl:with-param>
				</xsl:apply-templates>
   				
   				<!-- For some products (DM), we may need some authorisation not
					 associated to any bank -->

            <!-- 	Disable DM (Document Management)
            	<xsl:if test="static_user and company_type[.='03'] and securitycheck:hasCompanyPermission($rundata,'dm_access')">
   					<xsl:apply-templates select="group_record[group_name='global']" mode="user_authorisation_input">
   						<xsl:with-param name="dest">03</xsl:with-param>
   						<xsl:with-param name="dest_bis">*</xsl:with-param>
   						<xsl:with-param name="type">02</xsl:with-param>
   					</xsl:apply-templates>
		 		</xsl:if> -->
   			</xsl:with-param>
   		</xsl:call-template>
   		
   		<!-- Header for global roles -->
		<xsl:call-template name="fieldset-wrapper">
   			<xsl:with-param name="legend">XSL_HEADER_ROLES</xsl:with-param>
   			<xsl:with-param name="content">
   				<xsl:apply-templates select="group_record[group_name='global']" mode="role_input">
					<xsl:with-param name="dest">03</xsl:with-param>
					<xsl:with-param name="dest_bis">*</xsl:with-param>
					<xsl:with-param name="type">01</xsl:with-param>
				</xsl:apply-templates>
   			</xsl:with-param>
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
         <xsl:with-param name="value"><xsl:value-of select="$operation"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="$option"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      
      <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">featureid</xsl:with-param>
        <xsl:with-param name="value">
         <xsl:choose>
          <xsl:when test="$option='PERMISSIONS_MAINTENANCE' or $option='CUSTOMER_USER_PERMISSIONS_MAINTENANCE' or $option='BANK_USER_PERMISSIONS_MAINTENANCE'">
           <xsl:value-of select="static_user/login_id"/>
          </xsl:when>
          <xsl:when test="$option='BANK_PERMISSIONS_MAINTENANCE' or $option='BANK_PERMISSIONS_MAINTENANCE_MC'">
            <xsl:value-of select="static_bank/abbv_name"/>
          </xsl:when>
          <xsl:when test="$option='CUSTOMER_PERMISSIONS_MAINTENANCE'">
           <xsl:value-of select="static_company/abbv_name"/>
          </xsl:when>
         </xsl:choose>        
        </xsl:with-param>
       </xsl:call-template>
     <xsl:if test="$option='CUSTOMER_USER_PERMISSIONS_MAINTENANCE' or $option='BANK_USER_PERMISSIONS_MAINTENANCE'"> 
    	<xsl:call-template name="hidden-field">
      		<xsl:with-param name="name">company</xsl:with-param>
      		<xsl:with-param name="value"><xsl:value-of select="static_user/company_abbv_name"/></xsl:with-param>
      	</xsl:call-template>
     </xsl:if>
      <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">token</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$token"/></xsl:with-param>
      </xsl:call-template>
         <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">processdttm</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$processdttm"/></xsl:with-param>
      </xsl:call-template>
   	  <xsl:call-template name="e2ee_transaction"/>  
     </div>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:if>
  </xsl:template>
</xsl:stylesheet>