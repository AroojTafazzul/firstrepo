<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 RolePerm Screen, System Form.

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
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
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
  <xsl:param name="token"/>
  <xsl:param name="displaymode">edit</xsl:param>
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="operation"/>
  <xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
  <xsl:param name="arrowDownImage"><xsl:value-of select="$images_path"/>arrow_down.png</xsl:param>
  <xsl:param name="arrowUpImage"><xsl:value-of select="$images_path"/>arrow_up.png</xsl:param>
  

  <!-- Global Imports. -->
  <xsl:include href="../common/system_common.xsl" />
    
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
   <xsl:apply-templates select="role_record"/>
  </xsl:template>
  
  <xsl:template match="role_record">
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
      <xsl:apply-templates select="role" mode="input"/>
      <xsl:call-template name="permission-details"/>
      <xsl:call-template name="system-menu"/>
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
   <xsl:with-param name="xml-tag-name">role_record</xsl:with-param>
   <xsl:with-param name="binding">misys.binding.system.role_perm</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are  -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <div class="widgetContainer">
    <xsl:call-template name="hidden-field">
  	  <xsl:with-param name="name">brch_code</xsl:with-param>
   	</xsl:call-template>
 </div>
 </xsl:template>
 
 <!-- ***************************************************************************************** -->
 <!-- ************************************* STATIC ROLE FORM ********************************** -->
 <!-- ***************************************************************************************** -->
 <xsl:template name="role-details">
 	<!-- Show the role details -->
 	<xsl:choose>
		<xsl:when test="role/id[.='']">
			<xsl:apply-templates select="role" mode="input"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="role" mode="display"/>
		</xsl:otherwise>
	</xsl:choose>
 </xsl:template>
 
  	<!-- =========================================================================== -->
  	<!-- =================== Template for Role Details in INPUT mode =============== -->
  	<!-- =========================================================================== -->
	<xsl:template match="role" mode="input">
		
   		<xsl:call-template name="fieldset-wrapper">
   			<xsl:with-param name="legend">XSL_HEADER_ROLES_DETAILS</xsl:with-param>
   			<xsl:with-param name="content">
   						
   			 	<!-- Role Code  -->
    			<xsl:call-template name="input-field">
    				<xsl:with-param name="label">XSL_JURISDICTION_ROLE_CODE</xsl:with-param>
      				<xsl:with-param name="name">name</xsl:with-param>
      				<xsl:with-param name="size">30</xsl:with-param>
     				<xsl:with-param name="maxsize">30</xsl:with-param>
                    <xsl:with-param name="required">Y</xsl:with-param>
     			</xsl:call-template>
     				
     			<!-- Role Description  -->
    			<xsl:call-template name="input-field">
    				<xsl:with-param name="label">XSL_JURISDICTION_ROLE_DESCRIPTION</xsl:with-param>
      				<xsl:with-param name="name">role_description</xsl:with-param>
      				<xsl:with-param name="size">99</xsl:with-param>
     				<xsl:with-param name="maxsize">99</xsl:with-param>
                    <xsl:with-param name="required">Y</xsl:with-param>
     			</xsl:call-template>
    
				<!-- Role Destination  -->    
	 			<xsl:call-template name="select-field">
     				<xsl:with-param name="label">XSL_JURISDICTION_ROLE_DESTINATION</xsl:with-param>
     				<xsl:with-param name="name">roledest</xsl:with-param>
     				<xsl:with-param name="required">Y</xsl:with-param>
			     	<xsl:with-param name="options">
     					<xsl:call-template name="roleDest-options"/>
    				</xsl:with-param>
    			</xsl:call-template> 
    			
    			<!-- Role Type    -->   
    			
	 			<xsl:call-template name="select-field">
     				<xsl:with-param name="label">XSL_JURISDICTION_ROLE_TYPE</xsl:with-param>
     				<xsl:with-param name="name">roletype</xsl:with-param>
     				<xsl:with-param name="required">Y</xsl:with-param>
				   	<xsl:with-param name="options">
     					<xsl:call-template name="roleType-options"/>
    				</xsl:with-param>
    			</xsl:call-template>
   						
   			</xsl:with-param>
   		</xsl:call-template>
   		
	</xsl:template>
  
  	<!-- =========================================================================== -->
  	<!-- ================= Template for Role Details in DISPLAY mode =============== -->
  	<!-- =========================================================================== -->
  
   <xsl:template match="role" mode="display">
      <div class="widgetContainer">
		<xsl:call-template name="hidden-field">
  	  		<xsl:with-param name="name">role_id</xsl:with-param>
  	  		<xsl:with-param name="value"><xsl:value-of select="id"/></xsl:with-param>
   		</xsl:call-template>
   		<xsl:call-template name="hidden-field">
  	  		<xsl:with-param name="name">name</xsl:with-param>
   		</xsl:call-template>
   		<xsl:call-template name="hidden-field">
  	  		<xsl:with-param name="name">roledest</xsl:with-param>
   		</xsl:call-template>
   		<xsl:call-template name="hidden-field">
  	  		<xsl:with-param name="name">roletype</xsl:with-param>
   		</xsl:call-template>
	</div>
		<xsl:call-template name="fieldset-wrapper">
   			<xsl:with-param name="legend">XSL_HEADER_ROLES_DETAILS</xsl:with-param>
   			<xsl:with-param name="content">
   						
   		 		<!-- Role Code -->
    			<xsl:call-template name="input-field">
    				<xsl:with-param name="label">XSL_JURISDICTION_ROLE_CODE</xsl:with-param>
      				<xsl:with-param name="name">name</xsl:with-param>
      				<xsl:with-param name="size">30</xsl:with-param>
     				<xsl:with-param name="maxsize">30</xsl:with-param>
     				<xsl:with-param name="override-displaymode">view</xsl:with-param>
     			</xsl:call-template>
     				
     			<!-- Role Description -->
    			<xsl:call-template name="input-field">
    				<xsl:with-param name="label">XSL_JURISDICTION_ROLE_DESCRIPTION</xsl:with-param>
      				<xsl:with-param name="name">role_description</xsl:with-param>
      				<xsl:with-param name="size">99</xsl:with-param>
     				<xsl:with-param name="maxsize">99</xsl:with-param>
     			</xsl:call-template>
    
				<!-- Role Destination -->   
				<xsl:variable name="dest"><xsl:value-of select="roledest"/></xsl:variable>  
	 			<xsl:call-template name="input-field">
	     			<xsl:with-param name="label">XSL_JURISDICTION_ROLE_DESTINATION</xsl:with-param>
    	 			<xsl:with-param name="name">roledest</xsl:with-param>
     				<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N051', $dest)"/></xsl:with-param>
     				<xsl:with-param name="override-displaymode">view</xsl:with-param>
    			</xsl:call-template>
    					
    			<!-- Role Type -->
    			<xsl:variable name="type"><xsl:value-of select="roletype"/></xsl:variable>     
	 			<xsl:call-template name="input-field">
	     			<xsl:with-param name="label">XSL_JURISDICTION_ROLE_TYPE</xsl:with-param>
     				<xsl:with-param name="name">roletype</xsl:with-param>
     				<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N052', $type)"/></xsl:with-param>
     				<xsl:with-param name="override-displaymode">view</xsl:with-param>
    			</xsl:call-template>
   						
   			</xsl:with-param>
	   	</xsl:call-template>
	</xsl:template>

  
  <!--
    Role Destination options.
   -->
  <xsl:template name="roleDest-options">
     <xsl:choose>
      <xsl:when test="$displaymode='edit'">
       <!-- Customer option -->
       <option value="03">
      	<xsl:value-of select="localization:getDecode($language, 'N051', '03')"/>
       </option>
       <!-- Bank option -->
       <option value="01">
      	<xsl:value-of select="localization:getDecode($language, 'N051', '01')"/>
       </option>
       <!-- Bank Group option  -->
       <xsl:if test="../company_type[.='02']">
      	<option value="02">
      		<xsl:value-of select="localization:getDecode($language, 'N051', '02')"/>
     	</option>
       </xsl:if>
        <!-- Entity Option -->
       <option value="04">
      		<xsl:value-of select="localization:getDecode($language, 'N051', '04')"/>
     	</option>
      </xsl:when>
      <xsl:otherwise>
       <xsl:if test="roledest[. = '03']"><xsl:value-of select="localization:getDecode($language, 'N051', '03')"/></xsl:if>
       <xsl:if test="roledest[. = '01']"><xsl:value-of select="localization:getDecode($language, 'N051', '01')"/></xsl:if>
       <xsl:if test="roledest[. = '02']"><xsl:value-of select="localization:getDecode($language, 'N051', '02')"/></xsl:if>
       <xsl:if test="roledest[. = '04']"><xsl:value-of select="localization:getDecode($language, 'N051', '04')"/></xsl:if>
      </xsl:otherwise>
     </xsl:choose>
  </xsl:template>
  
  <!--
    Role Type options.
   -->
  <xsl:template name="roleType-options">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <!-- Role option -->
	 <option value="01">
	  <xsl:value-of select="localization:getDecode($language, 'N052', '01')"/>
	 </option>
	 <!-- Authorisation level option -->
	 <option value="02">
	  <xsl:value-of select="localization:getDecode($language, 'N052', '02')"/>
	 </option>
    </xsl:when>
    <xsl:otherwise>
	 <xsl:if test="roletype[. = '01']"><xsl:value-of select="localization:getDecode($language, 'N052', '01')"/></xsl:if>
     <xsl:if test="roletype[. = '02']"><xsl:value-of select="localization:getDecode($language, 'N052', '02')"/></xsl:if>
    </xsl:otherwise>
   </xsl:choose>
	</xsl:template>
 
 <!-- ***************************************************************************************** -->
 <!-- ************************************** PERMISSION FORM ********************************** -->
 <!-- ***************************************************************************************** -->
 
 <xsl:template name="permission-details">	
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_ATTACHED_PERMISSIONS</xsl:with-param>
   <xsl:with-param name="id">permission-details</xsl:with-param>
   <xsl:with-param name="content">
    <div style="text-align:center">
       <xsl:if test="$displaymode = 'edit'">
   	    <xsl:attribute name="class">collapse-label</xsl:attribute>
   	   </xsl:if>
   	   <xsl:if test="$displaymode = 'edit'">
       <xsl:call-template name="select-field">
        <xsl:with-param name="id">avail_list_nosend</xsl:with-param>
        <xsl:with-param name="name"></xsl:with-param>
        <xsl:with-param name="type">multiple</xsl:with-param>
        <xsl:with-param name="size">10</xsl:with-param>
        <xsl:with-param name="options">
         <xsl:choose>
		  <xsl:when test="$displaymode='edit'">
		   <xsl:apply-templates select="avail_permissions/permission" mode="input_roleperm"/>
		  </xsl:when>
		  <xsl:otherwise>
		   <ul class="multi-select">
		    <xsl:apply-templates select="existing_permissions/permission" mode="input_roleperm"/>
		   </ul>
		  </xsl:otherwise>
		 </xsl:choose>
        </xsl:with-param>
       </xsl:call-template>
        <div id="add-remove-buttons" class="multiselect-buttons">
         <button dojoType="dijit.form.Button" type="button" id="add"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_ADD')" />
         <img>
      	   <xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($arrowDownImage)"/></xsl:attribute>
      	   <xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_ADD')" /></xsl:attribute>
          </img>
         </button>
         <button dojoType="dijit.form.Button" type="button" id="remove"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REMOVE')" />
         <img>
      	  <xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($arrowUpImage)"/></xsl:attribute>
      	  <xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REMOVE')" /></xsl:attribute>
          </img>
         </button>
        </div>
        </xsl:if>
		<xsl:call-template name="select-field">
         <xsl:with-param name="name">permission_list</xsl:with-param>
         <xsl:with-param name="type">multiple</xsl:with-param>
         <xsl:with-param name="size">10</xsl:with-param>
         <xsl:with-param name="options">
          <xsl:choose>
		   <xsl:when test="$displaymode='edit'">
		    <xsl:apply-templates select="existing_permissions/permission" mode="input_roleperm"/>
		   </xsl:when>
		   <xsl:otherwise>
		    <ul class="multi-select">
             <xsl:apply-templates select="existing_permissions/permission" mode="input_roleperm"/>
            </ul>
		   </xsl:otherwise>
		  </xsl:choose>
          </xsl:with-param>
        </xsl:call-template>
      </div>
     </xsl:with-param>
   	</xsl:call-template>
   		
 </xsl:template>
 
 <!-- Template for Permission Description (whether already given or still available) in Input Mode -->
 <xsl:template match="existing_permissions/permission | avail_permissions/permission" mode="input_roleperm">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <option>
      <xsl:attribute name="value"><xsl:value-of select="name"/></xsl:attribute>
      <xsl:value-of select="name"/>
     </option>
    </xsl:when>
    <xsl:otherwise>
     <xsl:if test="name[.!='']">
      <li><xsl:value-of select="name"/></li>
     </xsl:if>
    </xsl:otherwise>
   </xsl:choose>
	
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
   <xsl:with-param name="action"> <xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$nextscreen"/></xsl:with-param>
    <xsl:with-param name="content">
     <div class="widgetContainer">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">operation</xsl:with-param>
       <xsl:with-param name="id">realform_operation</xsl:with-param>
       <xsl:with-param name="value">SAVE_FEATURES</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
       <xsl:with-param name="value">ROLE_MAINTENANCE</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:if test="role/id[.!='']">
      	<xsl:call-template name="hidden-field">
       		<xsl:with-param name="name">featureid</xsl:with-param>
       		<xsl:with-param name="value"><xsl:value-of select="role/name"/></xsl:with-param>
      	</xsl:call-template>
      </xsl:if>
     	 <xsl:call-template name="hidden-field">
	     <xsl:with-param name="name">token</xsl:with-param>
	      <xsl:with-param name="value"><xsl:value-of select="$token" /></xsl:with-param>
  		</xsl:call-template>
     </div>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:if>
  </xsl:template>
  
</xsl:stylesheet>