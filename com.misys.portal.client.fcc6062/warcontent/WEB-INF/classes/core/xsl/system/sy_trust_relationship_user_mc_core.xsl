<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################


Copyright (c) 2000-2011 Misys (http://www.misys.com),
All Rights Reserved. 


##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		exclude-result-prefixes="localization">
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
  <xsl:param name="token"/>
  <xsl:param name="displaymode">edit</xsl:param>
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="operation"/>
  <xsl:param name="processdttm"/>
  <xsl:param name="canCheckerReturnComments"/>
  <xsl:param name="checkerReturnCommentsMode"/>
  <xsl:param name="allowReturnAction">false</xsl:param>
  <xsl:param name="registrations_made">Y</xsl:param>
  <xsl:param name="operation">SAVE_FEATURES</xsl:param>
   <xsl:param name="currentmode"/>
  <!-- Global Imports. -->
  <xsl:include href="../common/system_common.xsl" />
  <xsl:include href="../common/maker_checker_common.xsl" />
    
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
   <!-- Loading message  -->
   <xsl:call-template name="loading-message"/>
      
   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
   	 	<xsl:with-param name="name" select="$main-form-name"/>
   	 	<xsl:with-param name="validating">Y</xsl:with-param>
   	 	<xsl:with-param name="content">
      			<xsl:apply-templates select="input/trust_relationship_user_record" mode="input"/>
		      		 <xsl:if test="$canCheckerReturnComments = 'true'">
				      	<xsl:call-template name="comments-for-return-mc">
				      		<xsl:with-param name="value"><xsl:value-of select="//return_comments"/></xsl:with-param>
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
   	<xsl:with-param name="xml-tag-name">trust_relationship_user_record</xsl:with-param>
   	<xsl:with-param name="binding">misys.binding.system.trust_relationship</xsl:with-param>
   	<xsl:with-param name="override-home-url">'/screen/<xsl:value-of select="$nextscreen"/>?option=<xsl:value-of select="$option"/>'</xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
<!-- =========================================================================== -->
<!-- =================== Template for Basic Package Details in INPUT mode =============== -->
<!-- =========================================================================== -->
  <xsl:template match="trust_relationship_user_record" mode="input">
  	<xsl:call-template name="fieldset-wrapper">
  		<xsl:with-param name="legend">XSL_HEADER_TRUST_RELATIONSHIP_DETAILS</xsl:with-param>
 			<xsl:with-param name="content">
 				<xsl:variable name="isUniDirectional"><xsl:value-of select="//is_unidirectional"/></xsl:variable>
		 				<xsl:if test="trust_relation_user_id[.!='']">
					      		<xsl:call-template name="hidden-field">
					       			<xsl:with-param name="name">trust_relation_user_id</xsl:with-param>
					       			<xsl:with-param name="value"><xsl:value-of select="trust_relation_user_id"/></xsl:with-param>
					      		</xsl:call-template>
			 			</xsl:if>
			 			<xsl:call-template name="input-field">
					    	 <xsl:with-param name="label">XSL_FROM_BANK_TRELATIONSHIP</xsl:with-param>
						     <xsl:with-param name="id">from_bank</xsl:with-param>
						     <xsl:with-param name="name">from_bank</xsl:with-param>
						    <xsl:with-param name="fieldsize">large</xsl:with-param>
		   					<xsl:with-param name="required">Y</xsl:with-param>
   							<xsl:with-param name="disabled">Y</xsl:with-param>
					    </xsl:call-template>
			 			<xsl:call-template name="input-field">
		  					<xsl:with-param name="label">XSL_FROM_COMPANY_TRELATIONSHIP</xsl:with-param>
		    				<xsl:with-param name="name">from_company</xsl:with-param>
		    				<xsl:with-param name="fieldsize">large</xsl:with-param>
		   					<xsl:with-param name="required">Y</xsl:with-param>
   							<xsl:with-param name="disabled">Y</xsl:with-param>
   						</xsl:call-template>
   						 <xsl:call-template name="hidden-field">
				       		<xsl:with-param name="name">from_company_id_hidden</xsl:with-param>
				       		<xsl:with-param name="value"><xsl:value-of select="from_company_id"/> </xsl:with-param>
	   		 			 </xsl:call-template>
	 					<xsl:call-template name="input-field">
					    	 <xsl:with-param name="label">XSL_FROM_USER_TRELATIONSHIP</xsl:with-param>
						     <xsl:with-param name="id">from_user</xsl:with-param>
						     <xsl:with-param name="name">from_user</xsl:with-param>
						     <xsl:with-param name="required">Y</xsl:with-param>
						     <xsl:with-param name="readonly">Y</xsl:with-param>
						     <xsl:with-param name="button-type">set-from-user</xsl:with-param>
					    </xsl:call-template>
					     <xsl:call-template name="hidden-field">
				       		<xsl:with-param name="name">from_user_id_hidden</xsl:with-param>
				       		<xsl:with-param name="value"><xsl:value-of select="from_user_id"/> </xsl:with-param>
	   		 			 </xsl:call-template>
	   		 			 <xsl:call-template name="input-field">
					    	 <xsl:with-param name="label">XSL_TO_BANK_TRELATIONSHIP</xsl:with-param>
						     <xsl:with-param name="id">to_bank</xsl:with-param>
						      <xsl:with-param name="name">to_bank</xsl:with-param>
						    <xsl:with-param name="fieldsize">large</xsl:with-param>
		   					<xsl:with-param name="required">Y</xsl:with-param>
   							<xsl:with-param name="disabled">Y</xsl:with-param>
					    </xsl:call-template>
	   		 			 <xsl:call-template name="input-field">
		  					<xsl:with-param name="label">XSL_TO_COMPANY_TRELATIONSHIP</xsl:with-param>
		    				<xsl:with-param name="name">to_company</xsl:with-param>
		    				<xsl:with-param name="fieldsize">large</xsl:with-param>
		   					<xsl:with-param name="required">Y</xsl:with-param>
   							<xsl:with-param name="disabled">Y</xsl:with-param>
   						</xsl:call-template>
   						 <xsl:call-template name="hidden-field">
				       		<xsl:with-param name="name">to_company_id_hidden</xsl:with-param>
				       		<xsl:with-param name="value"><xsl:value-of select="to_company_id"/> </xsl:with-param>
	   		 			 </xsl:call-template>
					    <xsl:call-template name="input-field">
					    	 <xsl:with-param name="label">XSL_TO_USER_TRELATIONSHIP</xsl:with-param>
						     <xsl:with-param name="id">to_user</xsl:with-param>
						     <xsl:with-param name="name">to_user</xsl:with-param>
						     <xsl:with-param name="required">Y</xsl:with-param>
						     <xsl:with-param name="readonly">Y</xsl:with-param>
						     <xsl:with-param name="button-type">set-to-user</xsl:with-param>
					    </xsl:call-template>
					     <xsl:call-template name="hidden-field">
				       		<xsl:with-param name="name">to_user_id_hidden</xsl:with-param>
				       		<xsl:with-param name="value"><xsl:value-of select="to_user_id"/> </xsl:with-param>
	   		 			 </xsl:call-template>
					   	 <xsl:choose>
			   				<xsl:when  test="$displaymode = 'edit'">
			   				<xsl:call-template name="select-field">
			   					<xsl:with-param name="label">XSL_TRUST_RELATIONSHIP_ACTIVE_LABEL</xsl:with-param>
									<xsl:with-param name="name">trust_relationship_status</xsl:with-param>
				     				<xsl:with-param name="size">10</xsl:with-param>
							     	<xsl:with-param name="required">Y</xsl:with-param>
							      	<xsl:with-param name="options">
										<xsl:call-template name="status_options"/>
							      	</xsl:with-param>
							      	<xsl:with-param name="value"><xsl:value-of select="status"/> </xsl:with-param>
			   				</xsl:call-template>
			   				</xsl:when>
			   				<xsl:otherwise>
			   					<xsl:call-template name="input-field">
			   					<xsl:with-param name="label">XSL_TRUST_RELATIONSHIP_ACTIVE_LABEL</xsl:with-param>
			   						<xsl:with-param name="name">trust_relationship_status</xsl:with-param>
			   						<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N020', status)"/></xsl:with-param>
			   					</xsl:call-template>
			   				</xsl:otherwise>
   						</xsl:choose>
   						 <xsl:choose>
   						 	<xsl:when  test="$displaymode = 'edit' and $isUniDirectional = 'Y'">
				   					<xsl:call-template name="select-field">
				   					<xsl:with-param name="label">XSL_TRUST_DIRECTION_LABEL</xsl:with-param>
										<xsl:with-param name="name">trust_direction_status</xsl:with-param>
					     				<xsl:with-param name="size">10</xsl:with-param>
								     	<xsl:with-param name="required">Y</xsl:with-param>
								      	<xsl:with-param name="options">
										<option>
												<xsl:attribute name="value">U</xsl:attribute>
												<xsl:value-of select="localization:getGTPString($language,'UNIDIRECTIONAL_TRUST_RELATIONSHIP')"/> 
										</option>
								      	</xsl:with-param>
								      	<xsl:with-param name="disabled">Y</xsl:with-param>
								      	<xsl:with-param name="value">U</xsl:with-param>
				   				</xsl:call-template>
			   				</xsl:when>
			   				<xsl:when  test="$displaymode = 'edit' and $isUniDirectional != 'Y'">
				   				<xsl:call-template name="select-field">
				   					<xsl:with-param name="label">XSL_TRUST_DIRECTION_LABEL</xsl:with-param>
										<xsl:with-param name="name">trust_direction_status</xsl:with-param>
					     				<xsl:with-param name="size">10</xsl:with-param>
								     	<xsl:with-param name="required">Y</xsl:with-param>
								      	<xsl:with-param name="options">
										<option>
												<xsl:attribute name="value">B</xsl:attribute>
												<xsl:value-of select="localization:getGTPString($language,'BIDIRECTIONAL_TRUST_RELATIONSHIP')"/> 
										</option>
								      	</xsl:with-param>
								      	<xsl:with-param name="disabled">Y</xsl:with-param>
								      	<xsl:with-param name="value">B</xsl:with-param>
				   				</xsl:call-template>
			   				</xsl:when>
			   				<xsl:otherwise>
			   					<xsl:call-template name="input-field">
			   					<xsl:with-param name="label">XSL_TRUST_DIRECTION_LABEL</xsl:with-param>
			   						<xsl:with-param name="name">trust_direction_status</xsl:with-param>
			   						<xsl:with-param name="value">
			   							<xsl:choose>
			   								<xsl:when test="direction[.='U']">
			   									<xsl:value-of select="localization:getGTPString($language,'UNIDIRECTIONAL_TRUST_RELATIONSHIP')"/> 
			   								</xsl:when>
			   								<xsl:otherwise>
			   									<xsl:value-of select="localization:getGTPString($language,'BIDIRECTIONAL_TRUST_RELATIONSHIP')"/> 
			   								</xsl:otherwise>
			   							</xsl:choose>
			   						</xsl:with-param>
			   					</xsl:call-template>
			   				</xsl:otherwise>
   						</xsl:choose>
     		</xsl:with-param>      		
  		</xsl:call-template>
  	</xsl:template>
  	
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
       <xsl:with-param name="value"><xsl:value-of select="$operation"/></xsl:with-param>
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
       <xsl:with-param name="value"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
			<xsl:with-param name="name">processdttm</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="$processdttm"/></xsl:with-param>
	  </xsl:call-template>
	  <xsl:call-template name="hidden-field">
			<xsl:with-param name="name">company</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="input/company_abbv_name"/></xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
       <xsl:with-param name="name">tnxid</xsl:with-param>
       <xsl:with-param name="value" select="input/trust_relationship_user_record/tnx_id"/>
      </xsl:call-template>
	 <xsl:if test="input/trust_relationship_user_record/trust_relation_user_id[.!='']">
      	<xsl:call-template name="hidden-field">
       		<xsl:with-param name="name">featureid</xsl:with-param>
       		<xsl:with-param name="value"><xsl:value-of select="input/trust_relationship_user_record/trust_relation_user_id"/></xsl:with-param>
      	</xsl:call-template>
     </xsl:if>
	 </div>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:if>
  </xsl:template>
 
 <xsl:template name="status_options">
   		<option>
			<xsl:attribute name="value">A</xsl:attribute>
			<xsl:value-of select="localization:getGTPString($language,'N020_A')"/> 
		</option>
		<option>
			<xsl:attribute name="value">I</xsl:attribute>
			<xsl:value-of select="localization:getGTPString($language,'N020_I')"/> 
		</option>
 </xsl:template>
 <xsl:template name="direction_options">
   		<option>
			<xsl:attribute name="value">U</xsl:attribute>
			<xsl:value-of select="localization:getGTPString($language,'UNIDIRECTIONAL_TRUST_RELATIONSHIP')"/> 
		</option>
		<option>
			<xsl:attribute name="value">B</xsl:attribute>
			<xsl:value-of select="localization:getGTPString($language,'BIDIRECTIONAL_TRUST_RELATIONSHIP')"/> 
		</option>
 </xsl:template>
</xsl:stylesheet>