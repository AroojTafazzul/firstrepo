<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet
		version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		exclude-result-prefixes="localization">


<!--
Templates for the references table
 -->
<xsl:include href="../common/attachment_templates.xsl" />


<!-- 
 Global Parameters.
 These are used in the imported XSL, and to set global params in the JS 
-->
<xsl:param name="language">en</xsl:param>
<xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
<xsl:param name="main-form-name">fakeform1</xsl:param>
<xsl:param name="displaymode">edit</xsl:param>
<xsl:param name="customerDetailsEnabled">false</xsl:param>


<!-- Global Imports. -->
<xsl:include href="../common/system_common.xsl" />


<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />

<xsl:template match="/">
	<xsl:apply-templates select="references_record" />
</xsl:template>

<!--TEMPLATE Main-->
<xsl:template match="references_record">
	<!-- Loading message  -->
	<xsl:call-template name="loading-message" />

	<!-- main -->
	<div>
	 <xsl:attribute name="id"><xsl:value-of select="$displaymode" /></xsl:attribute>
	
     <xsl:call-template name="form-wrapper">
		<xsl:with-param name="name" select="$main-form-name" />
		<xsl:with-param name="validating">Y</xsl:with-param>
   		<xsl:with-param name="content">
     		
  			<!-- remind customer details -->
			<xsl:apply-templates select="static_company" />
				
			<!-- customer references for each bank -->
			<div class="widgetContainer">
			 <xsl:call-template name="attachments-customer-references"> 
				<xsl:with-param name="customerDetailsEnabled" select="$customerDetailsEnabled"></xsl:with-param>
			 </xsl:call-template>
			</div>

			<!-- save, cancel, help buttons -->
			<xsl:call-template name="system-menu" />

		</xsl:with-param>
	 </xsl:call-template>
	
	 <!-- Real Form -->
	 <xsl:call-template name="realform" />
	
	 <!-- Javascript imports  -->
     <xsl:call-template name="js-imports"/>
	</div>
</xsl:template>



<!--  static company -->
<xsl:template match="static_company">
	<xsl:call-template name="fieldset-wrapper">
  		<xsl:with-param name="legend">XSL_HEADER_COMPANY_DETAILS</xsl:with-param>
    	<xsl:with-param name="content">

			<!-- company_id -->
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">company_id</xsl:with-param>
				<xsl:with-param name="value" select="company_id" />
			</xsl:call-template>

	 		<!-- Abbreviated Name -->
 			<xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_JURISDICTION_ABREVIATED_NAME</xsl:with-param>
		      	<xsl:with-param name="name">abbv_name</xsl:with-param>
		      	<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">abbv_name</xsl:with-param>
				<xsl:with-param name="value" select="abbv_name" />
			</xsl:call-template>

			<!-- brch_code -->
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">brch_code</xsl:with-param>
				<xsl:with-param name="value" select="brch_code" />
			</xsl:call-template>			

 			<!-- Name -->
 			<xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_JURISDICTION_NAME</xsl:with-param>
      			<xsl:with-param name="name">name</xsl:with-param>
      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
    		</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">name</xsl:with-param>
				<xsl:with-param name="value" select="name" />
			</xsl:call-template>			

 			<!-- Address -->
 			<xsl:call-template name="input-field">
      			<xsl:with-param name="label">XSL_JURISDICTION_ADDRESS</xsl:with-param>
      			<xsl:with-param name="name">address_line_1</xsl:with-param>
      			<xsl:with-param name="override-displaymode">view</xsl:with-param>
    		</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">address_line_1</xsl:with-param>
				<xsl:with-param name="value" select="address_line_1" />
			</xsl:call-template>			
    		
    		<!-- Address 2 (if exists) -->
    		<xsl:if test="address_line_2[.!='']">
    			<xsl:call-template name="input-field">
					<xsl:with-param name="label" />
					<xsl:with-param name="name">address_line_2</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
    			</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">address_line_2</xsl:with-param>
					<xsl:with-param name="value" select="address_line_2" />
				</xsl:call-template>	
			</xsl:if>
    		
    		<!-- Contact Name (if exists) -->
    		<xsl:if test="contact_name[.!='']">
    			<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_JURISDICTION_CONTACT_NAME</xsl:with-param>
					<xsl:with-param name="name">contact_name</xsl:with-param>
					<xsl:with-param name="override-displaymode">view</xsl:with-param>
    			</xsl:call-template>
    			<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">contact_name</xsl:with-param>
					<xsl:with-param name="value" select="contact_name" />
				</xsl:call-template>	
			</xsl:if>
			
			<!-- dom -->
			<xsl:if test="contact_name[.!='']">
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">dom</xsl:with-param>
					<xsl:with-param name="value" select="dom" />
				</xsl:call-template>				
			</xsl:if>
			
    	</xsl:with-param>
    </xsl:call-template>
</xsl:template>



<!-- Additional JS imports for this form -->
<xsl:template name="js-imports">
	<xsl:call-template name="system-common-js-imports">
	  <xsl:with-param name="xml-tag-name">references_record</xsl:with-param>
	  <xsl:with-param name="binding">misys.binding.system.customer_reference</xsl:with-param>
	</xsl:call-template>
</xsl:template>



<!-- real form -->
<xsl:template name="realform">
	<xsl:call-template name="form-wrapper">
		<xsl:with-param name="name">realform</xsl:with-param>
		<xsl:with-param name="method">POST</xsl:with-param>
		<xsl:with-param name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/BankSystemFeaturesScreen</xsl:with-param>
		<xsl:with-param name="content">
		 <div class="widgetContainer">
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">operation</xsl:with-param>
				<xsl:with-param name="id">realform_operation</xsl:with-param>
				<xsl:with-param name="value">SAVE_FEATURES</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">featureid</xsl:with-param>
				<xsl:with-param name="value" select="static_company/abbv_name" />
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">option</xsl:with-param>
				<xsl:with-param name="value">CUSTOMER_REFERENCES_MAINTENANCE</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">TransactionData</xsl:with-param>
				<xsl:with-param name="value" />
			</xsl:call-template>
		 </div>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>



</xsl:stylesheet>
