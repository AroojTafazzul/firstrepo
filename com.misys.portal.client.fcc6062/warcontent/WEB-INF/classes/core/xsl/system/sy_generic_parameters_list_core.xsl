<?xml version="1.0" encoding="UTF-8"?>
<!--

-->
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		exclude-result-prefixes="localization">
 
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="nextscreen"/>
  <xsl:param name="option"/>
  <xsl:param name="selparm"/>
  <xsl:param name="selparmlabel"></xsl:param>
  <xsl:param name="gridcontent"/>
  <xsl:param name="token"/>
  <xsl:param name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$nextscreen"/></xsl:param>
  <xsl:param name="displaymode">edit</xsl:param>
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="message"/>
  <xsl:param name="main-form-name">parmForm</xsl:param>
  	
  <!-- Global Imports. -->
  <xsl:include href="../common/system_common.xsl" />
  <xsl:include href="../common/e2ee_common.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />

  <xsl:template match="/">
	<xsl:apply-templates select="parms"/>
	<xsl:call-template name="realform"/>
  </xsl:template>
  
  <xsl:template match="parms">
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
				      <xsl:call-template name="parm-fields"/>
				      <xsl:call-template name="key-details"/>
			     </xsl:with-param>
		    </xsl:call-template>
		    <!--<xsl:call-template name="messagedispaly"/>
		    -->
	    </div>
	   
	   <!-- Javascript imports  -->
	   <xsl:call-template name="js-imports"/>
  </xsl:template>
  
 <!--                                     -->  
 <!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
 <!--                                     -->
 
 <!-- Additional JS imports for this form are -->
 <!-- added here. -->
  <xsl:template name="messagedispaly">
 	<xsl:if test="$message">
 		<xsl:call-template name="input-field">
 			<xsl:with-param name="id">message_nosend</xsl:with-param>
 			<xsl:with-param name="value" select="$message"/>
 			<xsl:with-param name="readonly">Y</xsl:with-param>
 		</xsl:call-template>
 	</xsl:if>
 </xsl:template>
 <xsl:template name="js-imports">
  	  <xsl:call-template name="system-common-js-imports">
		   <xsl:with-param name="xml-tag-name">generic_parameters</xsl:with-param>
		   <xsl:with-param name="binding">misys.binding.system.generic_parameters_list</xsl:with-param>
		   <xsl:with-param name="override-home-url">'/screen/<xsl:value-of select="$nextscreen"/>?option=<xsl:value-of select="$option"/>'</xsl:with-param>
	  </xsl:call-template>
 </xsl:template>
 
 
 <!-- Additional hidden fields for this form are  -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <div class="widgetContainer">
	  <xsl:if test="$selparm">
		   <xsl:call-template name="hidden-field">
			    <xsl:with-param name="id">parameter</xsl:with-param>
			    <xsl:with-param name="name"><xsl:value-of select="$selparm"/></xsl:with-param>
			    <xsl:with-param name="value"><xsl:value-of select="$selparm"/></xsl:with-param>
		   </xsl:call-template>
	   </xsl:if>
  </div>
 </xsl:template>
 
 <!--
  Main Details of the Bank 
  -->
 <xsl:template name="parm-fields">
  <xsl:call-template name="fieldset-wrapper">
	   <!-- TODO Should have its own localised strings. -->
	   <xsl:with-param name="legend">XSL_GENPARMMAINT_PARAM</xsl:with-param>
	   <xsl:with-param name="content">
		 	<xsl:call-template name="select-field">
			      <xsl:with-param name="label">XSL_GENPARMMAIN_PARAMETER</xsl:with-param>
			      <xsl:with-param name="name">parmid</xsl:with-param>
			      <xsl:with-param name="required">Y</xsl:with-param>
			      <xsl:with-param name="options">
			      		<xsl:for-each select="parm">
				   			 <option>
					    		  <xsl:attribute name="value"><xsl:value-of select="@name"/></xsl:attribute>
					    		  <xsl:value-of select="localization:getGTPString($language, @label)"/>
				   			 </option>
				      	</xsl:for-each>
			       </xsl:with-param>
				    <xsl:with-param name="value">
					    <xsl:choose>
					    	<xsl:when test="$selparm" ><xsl:value-of select="$selparm"/></xsl:when> 
					    	<xsl:otherwise>-1</xsl:otherwise>
					    </xsl:choose>
				    </xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="row-wrapper">
			   <xsl:with-param name="content">  
			    <button dojoType="dijit.form.Button" type="button">
					<xsl:attribute name="onClick">misys.selectParameter();</xsl:attribute>
						 <xsl:value-of select="localization:getGTPString($language, 'PARAMETERSELECT')" />
				 </button>
			   	</xsl:with-param>
		   	</xsl:call-template>
	    </xsl:with-param>
    </xsl:call-template>
</xsl:template>
  
  
  <xsl:template name="key-details">
	  	<xsl:call-template name="fieldset-wrapper">
	   	   <xsl:with-param name="legend"><xsl:value-of select="$selparmlabel"/></xsl:with-param>
		   <xsl:with-param name="content">
		 	 <xsl:copy-of select="$gridcontent"></xsl:copy-of>
		    </xsl:with-param>
	    </xsl:call-template>
 </xsl:template>
 
 <xsl:template name="realform">
  	<xsl:call-template name="form-wrapper">
	   <xsl:with-param name="name">realform</xsl:with-param>
	   <xsl:with-param name="method">POST</xsl:with-param>
	   <xsl:with-param name="action">
	   		<xsl:choose>
	          <xsl:when test="$nextscreen and $nextscreen !=''"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$nextscreen"/></xsl:when>
	          <xsl:otherwise><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/BankSystemFeaturesScreen</xsl:otherwise>
	        </xsl:choose>
	    </xsl:with-param>
	   <xsl:with-param name="content">
		     <div class="widgetContainer">
			      <xsl:call-template name="hidden-field">
				       <xsl:with-param name="name">operation</xsl:with-param>
				       <xsl:with-param name="id">realform_operation</xsl:with-param>
				       <xsl:with-param name="value">SAVE_FEATURES</xsl:with-param>
			      </xsl:call-template>
			     
			      <xsl:call-template name="hidden-field">
				       <xsl:with-param name="name">option</xsl:with-param>
					   <xsl:with-param name="value"><xsl:value-of select="$option"/></xsl:with-param>
			      </xsl:call-template>
			      <xsl:call-template name="hidden-field">
				       <xsl:with-param name="name">featureid</xsl:with-param>
					   <xsl:with-param name="value"><xsl:value-of select="$selparm"/></xsl:with-param>
			      </xsl:call-template>
			     <!--  <xsl:call-template name="hidden-field">
			       <xsl:with-param name="name">updatemode</xsl:with-param>
				   <xsl:with-param name="value"><xsl:value-of select="$updateMode"/></xsl:with-param>
			      </xsl:call-template>
			      -->
			       <xsl:call-template name="hidden-field">
				<xsl:with-param name="name">token</xsl:with-param>
				 <xsl:with-param name="value"><xsl:value-of select="$token"/></xsl:with-param>
				</xsl:call-template>
			      <xsl:call-template name="hidden-field">
				       <xsl:with-param name="name">TransactionData</xsl:with-param>
				       <xsl:with-param name="value"/>
			      </xsl:call-template>
			      <xsl:call-template name="hidden-field">
				       <xsl:with-param name="name">ParameterData</xsl:with-param>
				       <xsl:with-param name="value"/>
			      </xsl:call-template>
			      <xsl:call-template name="e2ee_transaction"/>
		     </div>
	    </xsl:with-param>
   </xsl:call-template>
  
  </xsl:template>
</xsl:stylesheet>