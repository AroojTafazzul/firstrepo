<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
        xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
        xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
        xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
        exclude-result-prefixes="xmlRender securityCheck utils">
        
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> 
  <xsl:param name="collaborationmode">none</xsl:param>  
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="nextscreen"/>
  <xsl:param name="option"/>
  <xsl:param name="token"/>
  <xsl:param name="draftMode"/>
  <xsl:param name="operation">SAVE_FEATURES</xsl:param>
  <xsl:param name="processdttm"/>
  <xsl:param name="entitiescount"/>
  
    <!-- Global Imports. -->
  <xsl:include href="../../../core/xsl/common/system_common.xsl" />
  <xsl:include href="../common/e2ee_common.xsl" /> 
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  
 <xsl:template match="/">
	<xsl:apply-templates select="entity_account_record"/>
 </xsl:template>
	
 <xsl:template match="entity_account_record">
		<xsl:call-template name="loading-message"/>
		<div>
			<xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
			    
			<xsl:call-template name="server-message">
		 		<xsl:with-param name="name">server_message</xsl:with-param>
		 		<xsl:with-param name="content"><xsl:value-of select="message"/></xsl:with-param>
		 		<xsl:with-param name="appendClass">serverMessage</xsl:with-param>
			</xsl:call-template>
			
			<!-- Form #0 : Main Form -->
			<xsl:call-template name="form-wrapper">
			     <xsl:with-param name="name" select="$main-form-name"/>
			     <xsl:with-param name="validating">Y</xsl:with-param>
			     <xsl:with-param name="content">
			     	 <xsl:call-template name="company-details"/>
			     	 <xsl:call-template name="nickname-account-details"/>
			     	 <!--  Display common menu. -->
			     	 <xsl:if test="$option='ENTITY_ACCOUNTS_NICKNAME_CHANGE'">
      					<xsl:call-template name="system-menu"/>
      				 </xsl:if>
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
  <xsl:with-param name="override-help-access-key">AN_01</xsl:with-param>
   <xsl:with-param name="override-home-url">'/screen/<xsl:value-of select="$nextscreen"/>?option=ENTITY_ACCOUNTS_NICKNAME_MAINTENANCE&amp;entity=<xsl:value-of select="entity/entity_id"/>&amp;company=<xsl:value-of select="entity/company_abbv_name"/>'</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <xsl:template name="company-details">
 <xsl:call-template name="fieldset-wrapper">
   		<xsl:with-param name="legend">XSL_HEADER_ENTITY_DETAILS</xsl:with-param>
   		<xsl:with-param name="content">
   		<!--<xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_TOKEN_COMPANY_NAME</xsl:with-param>
      			<xsl:with-param name="value"><xsl:value-of select="entity/company_abbv_name"/></xsl:with-param>
      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
     	</xsl:call-template>
     	--><xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_ENTITY_NAME</xsl:with-param>
      			<xsl:with-param name="id">entity_name_view</xsl:with-param>
      			<xsl:with-param name="value"><xsl:value-of select="entity/name"/></xsl:with-param>
      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
     	</xsl:call-template>
     	<xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_ENTITY_ABBV_NAME</xsl:with-param>
      			<xsl:with-param name="id">entity_abbv_name_view</xsl:with-param>
      			<xsl:with-param name="value"><xsl:value-of select="entity/abbv_name"/></xsl:with-param>
      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
     	</xsl:call-template>
   		</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 
  <!--
  Main Details of the Accounts
  -->
 <xsl:template name="nickname-account-details">
	<xsl:variable name="current"><xsl:value-of select="static_company/language"/></xsl:variable>
  	<xsl:call-template name="fieldset-wrapper">
   		<xsl:with-param name="legend">XSL_ACCOUNT_NAME_LABEL</xsl:with-param>
   		<xsl:with-param name="content">
   			 <xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_ACCOUNT_NAME</xsl:with-param>
      			<xsl:with-param name="id">account_name_view</xsl:with-param>
      			<xsl:with-param name="value">
      				<xsl:choose>
      					<xsl:when test="$entitiescount>0">
      						<xsl:value-of select="account_name"/>
      					</xsl:when>
      					<xsl:otherwise>
      						<xsl:value-of select="acct_name"/>
      					</xsl:otherwise>
      				</xsl:choose>
      			</xsl:with-param>
      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>
     		 <xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_ACCOUNT_NUMBER</xsl:with-param>
      			<xsl:with-param name="id">account_no_view</xsl:with-param>
      			<xsl:with-param name="value">
      				<xsl:choose>
      					<xsl:when test="$entitiescount>0">
      						<xsl:value-of select="account_no"/>
      					</xsl:when>
      					<xsl:otherwise>
      						<xsl:value-of select="account_no"/>
      					</xsl:otherwise>
      				</xsl:choose>
      			</xsl:with-param>
      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>
     		<xsl:call-template name="input-field">
       	  		<xsl:with-param name="label">XSL_ACCOUNT_CURRENCY</xsl:with-param>
       	  		<xsl:with-param name="id">account_cur_code_view</xsl:with-param>
       	  		<xsl:with-param name="value">
      				<xsl:choose>
      					<xsl:when test="$entitiescount>0">
      						<xsl:value-of select="account_cur_code"/>
      					</xsl:when>
      					<xsl:otherwise>
      						<xsl:value-of select="cur_code"/>
      					</xsl:otherwise>
      				</xsl:choose>
      			</xsl:with-param>
           		<xsl:with-param name="override-displaymode">view</xsl:with-param>
        	 </xsl:call-template>
			<xsl:call-template name="input-field">
      			 <xsl:with-param name="label">XSL_ACCOUNT_DESCRIPTION</xsl:with-param>
      			 <xsl:with-param name="id">account_description_view</xsl:with-param>
      			 <xsl:with-param name="value">
      				<xsl:choose>
      					<xsl:when test="$entitiescount>0">
      						<xsl:value-of select="account_description"/>
      					</xsl:when>
      					<xsl:otherwise>
      						<xsl:value-of select="description"/>
      					</xsl:otherwise>
      				</xsl:choose>
      			</xsl:with-param>
      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
     		</xsl:call-template>
     		<xsl:choose>
     			<xsl:when test="$option='ENTITY_ACCOUNTS_NICKNAME_CHANGE'">
     				<xsl:call-template name="input-field">
				      	<xsl:with-param name="label">XSL_ACCOUNT_NICK_NAME_LABEL</xsl:with-param>
				      	<xsl:with-param name="name">account_nick_name</xsl:with-param>
				      	<xsl:with-param name="type">text</xsl:with-param>
				      	<xsl:with-param name="value">
		      				<xsl:choose>
		      					<xsl:when test="$entitiescount>0">
		      						<xsl:value-of select="account_nick_name"/>
		      					</xsl:when>
		      					<xsl:otherwise>
		      						<xsl:value-of select="nickname"/>
		      					</xsl:otherwise>
		      				</xsl:choose>
      					</xsl:with-param>
				        <xsl:with-param name="size">35</xsl:with-param>
				       	<xsl:with-param name="maxsize">35</xsl:with-param>
				    </xsl:call-template>
     			</xsl:when>
     			<xsl:otherwise>
     				<xsl:call-template name="input-field">
		      			 <xsl:with-param name="label">XSL_ACCOUNT_NICK_NAME_LABEL</xsl:with-param>
		      			 <xsl:with-param name="id">account_nick_name_view</xsl:with-param>
		      			 <xsl:with-param name="value"><xsl:value-of select="account_nick_name"/></xsl:with-param>
		      			 <xsl:with-param name="override-displaymode">view</xsl:with-param>
	     			</xsl:call-template>
     			</xsl:otherwise>
     		</xsl:choose>
	   </xsl:with-param>
	 </xsl:call-template>
 </xsl:template>
	
 <!-- Realform -->
 <xsl:template name="realform">
  <xsl:call-template name="form-wrapper">
   <xsl:with-param name="name">realform</xsl:with-param>
   <xsl:with-param name="method">POST</xsl:with-param>
   <xsl:with-param name="action">
    <xsl:choose>
     <xsl:when test="$nextscreen"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$nextscreen"/></xsl:when>
    </xsl:choose>
   </xsl:with-param>
    <xsl:with-param name="content">
     <div class="widgetContainer">
      <xsl:call-template name="localization-dialog"/>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">operation</xsl:with-param>
       <xsl:with-param name="id">realform_operation</xsl:with-param>
       <xsl:with-param name="value">SAVE_FEATURES</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
       <xsl:with-param name="value">SAVE_ACCOUNTS_NICKNAME_MAINTENANCE</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
	  <xsl:call-template name="hidden-field">
    	<xsl:with-param name="name">featureid</xsl:with-param>
    	<xsl:with-param name="value"><xsl:value-of select="account_no"/></xsl:with-param>
   	  </xsl:call-template>
   	   <xsl:call-template name="hidden-field">
    	<xsl:with-param name="name">accountid</xsl:with-param>
    	<xsl:with-param name="value"><xsl:value-of select="account_id"/></xsl:with-param>
   	  </xsl:call-template> 
   	  <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">token</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$token"/></xsl:with-param>
      </xsl:call-template>
	  <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">mode</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$draftMode"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">entity</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="entity/entity_id"/></xsl:with-param>
      </xsl:call-template>
   	  	<xsl:call-template name="hidden-field">
       		<xsl:with-param name="name">company</xsl:with-param>
       		<xsl:with-param name="value"><xsl:value-of select="entity/company_abbv_name"/></xsl:with-param>
      	</xsl:call-template>
	  <xsl:call-template name="e2ee_transaction"/>      	
     </div>
    </xsl:with-param>
   </xsl:call-template>
 </xsl:template>
	 
</xsl:stylesheet>