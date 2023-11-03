<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates that are common across all XSLT stylesheets.

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
		xmlns:xd="http://www.pnp-software.com/XSLTdoc" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
        xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools"
        xmlns:securityUtils="xalan://com.misys.portal.common.tools.SecurityUtils"
        xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		 xmlns:buildversion="xalan://com.misys.portal.Version"
		exclude-result-prefixes="localization convertTools securityCheck utils security defaultresource">
 
 <xsl:param name="contextPath"/>
 <xsl:param name="servletPath"/>
 <xsl:param name="option"></xsl:param>
 <xsl:param name="dojo-mode"><xsl:value-of select="securityCheck:getDojoMode()" /></xsl:param>
 <xsl:param name="htmlUsedModulus"/>
 <xsl:param name ="cr_seq"/>
 <xsl:param name="clientSideEncryption"/>
 <xsl:param name="form_mask"/>
 <xsl:variable name="context_Path"><xsl:value-of select="$contextPath"/></xsl:variable>
 <xsl:variable name="swift2018Enabled" select="defaultresource:isSwift2018Enabled()"/>
 <xsl:variable name="swift2019Enabled" select="defaultresource:isSwift2019Enabled()"/>
 <xsl:variable name="licenseBeneficiaryEnabled" select="defaultresource:isLicenseBeneficiaryEnabled()"/>
 <xsl:variable name="confirmationChargesEnabled" select="defaultresource:iscfmChargesEnabled()"/>
  <!-- common variable to use for cache bursting when manually providing js source -->
	<xsl:variable name="build_number"><xsl:value-of select="concat('?',buildversion:getBuildNumber())"/></xsl:variable>
  <xsl:param name="trade_total_combined_sizeallowed"/>
  
 
  
  <!-- ************************************************************** -->
 <!-- ************************ SECURITY PART *********************** -->
 <!-- ************************************************************** -->
  <!--
  	Security password encryption keys
  -->
 <xsl:template name = "security-encryption-keys">
 <script>
   dojo.ready(function(){
	   misys._config = misys._config || {};
	   dojo.mixin(misys._config, {
	   	htmlUsedModulus : '<xsl:value-of select="$htmlUsedModulus"/>' ,
	  	cr_seq : '<xsl:value-of select="$cr_seq"/>',
	  	clientSideEncryption : '<xsl:value-of select="$clientSideEncryption"/>'
	   });
   });
  </script>
 </xsl:template>
  <!--
  	Security password encryption js imports 
  -->
<xsl:template name ="security-pwd-encryption-js-imports">
 <xsl:choose>
	<xsl:when test="$dojo-mode = 'DEBUG_ALL' or $dojo-mode = 'DEBUG' ">
			<script src="{$context_Path}/content/js-src/misys/crypto/jsbn.js{$build_number}"/>
			<script src="{$context_Path}/content/js-src/misys/crypto/prng4.js{$build_number}"/>
			<script src="{$context_Path}/content/js-src/misys/crypto/rng.js{$build_number}"/>
			<script src="{$context_Path}/content/js-src/misys/crypto/rsa.js{$build_number}"/> 
			</xsl:when>
	<xsl:otherwise>
			 <script src="{$context_Path}/content/js/misys/crypto/jsbn.js{$build_number}"/>
			<script src="{$context_Path}/content/js/misys/crypto/prng4.js{$build_number}"/>
			<script src="{$context_Path}/content/js/misys/crypto/rng.js{$build_number}"/>
			<script src="{$context_Path}/content/js/misys/crypto/rsa.js{$build_number}"/>
	</xsl:otherwise>
	</xsl:choose>
</xsl:template> 
  <!--
   Disclaimer Notice. Displayed in summary view 
   -->
  <xsl:template name="disclaimer">
   <xsl:if test="$displaymode='view' and not(tnx_id)">
    <div class="disclaimer">
     <h2><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTING_DISCLAIMER_LABEL')"/></h2>
     <p><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTING_DISCLAIMER')"/></p>
    </div>
   </xsl:if>
  </xsl:template>

  <!--
  Optional EUCP section
  
  ** Notes **
  1. Set show-presentation to Y to show the optional presentation
  ***********
  -->
  <xsl:template name="eucp-details">
   <xsl:param name="show-eucp">N</xsl:param>
   <xsl:param name="show-presentation">N</xsl:param>

   <xsl:choose>
    <xsl:when test="$show-eucp='Y'">
      <xsl:call-template name="multichoice-field">
     	<xsl:with-param name="type">checkbox</xsl:with-param>
      <xsl:with-param name="name">eucp_flag</xsl:with-param>
      <xsl:with-param name="label">XSL_GENERALDETAILS_EUCP_FLAG</xsl:with-param>
     </xsl:call-template>    
     <div id="eucp_details" style="display:none;">
      <xsl:if test="eucp_flag[.='Y']">
       <xsl:attribute name="style">display:block;</xsl:attribute>
      </xsl:if>
      <xsl:call-template name="select-field">
       <xsl:with-param name="label">XSL_GENERALDETAILS_EUCP_VERSION</xsl:with-param>
       <xsl:with-param name="name">eucp_version</xsl:with-param>
       <xsl:with-param name="options">
        <xsl:choose>
         <xsl:when test="$displaymode='edit'">
          <option value="1.0">1.0</option>
         </xsl:when>
         <xsl:otherwise>
          <xsl:if test="eucp_version[.='1.0']">1.0</xsl:if>
         </xsl:otherwise>
        </xsl:choose>
       </xsl:with-param>
      </xsl:call-template>
      <xsl:if test="$show-presentation='Y'">
       <!-- Presentation place not shown in LC: SWIFT 47a should be used instead -->
       <xsl:call-template name="row-wrapper">
        <xsl:with-param name="id">eucp_presentation_place</xsl:with-param>
        <xsl:with-param name="label">XSL_GENERALDETAILS_EUCP_PRESENTATION_PLACE</xsl:with-param>
        <xsl:with-param name="type">textarea</xsl:with-param>
        <xsl:with-param name="content">
         <xsl:call-template name="textarea-field">
          <xsl:with-param name="name">eucp_presentation_place</xsl:with-param>
          <xsl:with-param name="rows">3</xsl:with-param>
          <xsl:with-param name="cols">40</xsl:with-param>
          <xsl:with-param name="button-type" select="''"/>
         </xsl:call-template>
        </xsl:with-param>
       </xsl:call-template>
      </xsl:if>
     </div>
    </xsl:when>
    <xsl:otherwise>
     <xsl:if test="$displaymode='edit'">
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">eucp_version</xsl:with-param>
        <xsl:with-param name="value">1.0</xsl:with-param>
       </xsl:call-template>
       <xsl:call-template name="hidden-field">
        <xsl:with-param name="name">eucp_presentation_place</xsl:with-param>
       </xsl:call-template>
     </xsl:if>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
  
  <!--
   Bank Tab Content
    * advising_bank
    * advise_thru_bank
    * issuing_bank
    * confirming_bank
    * presenting_bank
    * pay_through_bank
    * account_with_bank
    * issuing_bank
    * drawee_details_bank
    * credit_available_with_bank
  -->
  <xsl:template match="advising_bank | advise_thru_bank | issuing_bank | confirming_bank | presenting_bank | pay_through_bank | account_with_bank | drawee_details_bank | credit_available_with_bank | processing_bank | requested_confirmation_party | first_advising_bank">
   <xsl:param name="theNodeName"/>
   <xsl:param name="required">N</xsl:param>
   <xsl:param name="disabled">N</xsl:param>
   <xsl:param name="override-product-code" select="$product-code"/>
   <xsl:param name="override-form"/>
   <xsl:param name="swift-required">N</xsl:param>
   <xsl:param name="show-button">Y</xsl:param>
  
  <xsl:choose>
	  <xsl:when test="$swift-required='Y'">
		   <xsl:call-template name="input-field">
		    <xsl:with-param name="label">XSL_PARTIESDETAILS_SWIFT_CODE</xsl:with-param>
		    <xsl:with-param name="name"><xsl:value-of select="$theNodeName"/>_iso_code</xsl:with-param>
		    <xsl:with-param name="value" select="iso_code"/>
		    <xsl:with-param name="size">11</xsl:with-param>
    		<xsl:with-param name="maxsize">11</xsl:with-param>        
		    <xsl:with-param name="required">N</xsl:with-param>
		    <xsl:with-param name="button-type"><xsl:if test="$show-button='Y'"><xsl:value-of select="$theNodeName"/></xsl:if></xsl:with-param>
		    <xsl:with-param name="swift">Y</xsl:with-param>
		    <xsl:with-param name="fieldsize">small</xsl:with-param>
		   </xsl:call-template>  
		   
		   <xsl:call-template name="input-field">
		    <xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
		    <xsl:with-param name="name"><xsl:value-of select="$theNodeName"/>_name</xsl:with-param>
		    <xsl:with-param name="override-product-code" select="$override-product-code"/>
		    <xsl:with-param name="required" select="$required"/>
		    <xsl:with-param name="value">
				<xsl:choose>
					 <xsl:when test="$theNodeName='drawee_details_bank'">
					 	<xsl:choose>
						<xsl:when test="name[translate(.,$up,$lo)='issuing bank'] or name[.]=localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_ISSUING_BANK')">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_ISSUING_BANK')" />
						</xsl:when>
						<xsl:when test="name[translate(.,$up,$lo)='confirming bank'] or name[.]=localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_CONFIRMING_BANK')">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_CONFIRMING_BANK')" />
						</xsl:when>
						<xsl:when test="name[translate(.,$up,$lo)='advising bank'] or name[.]=localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_ADVISING_BANK')">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_ADVISING_BANK')" />
						</xsl:when>
						<xsl:when test="name[translate(.,$up,$lo)='negotiating bank'] or name[.]=localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_NEGOTIATING_BANK')">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_NEGOTIATING_BANK')" />
						</xsl:when>
						<xsl:when test="name[translate(.,$up,$lo)='reimbursing bank'] or name[.]=localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_REIMBURSING_BANK')">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_REIMBURSING_BANK')" />
						</xsl:when>
						<xsl:when test="name[translate(.,$up,$lo)='applicant'] or name[.]=localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_APPLICANT')">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_APPLICANT')" />
						</xsl:when>
						<xsl:when test="name[translate(.,$up,$lo)='first advising bank'] or name[.]=localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_FIRST_ADVISING_BANK')">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_FIRST_ADVISING_BANK')" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="name[.!='']">
									<xsl:value-of select="name" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_OTHER')" />
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					 	</xsl:choose>
					 </xsl:when>
					 <xsl:otherwise><xsl:value-of select="name"/></xsl:otherwise>
				</xsl:choose>
		    </xsl:with-param>
		    <xsl:with-param name="disabled" select="$disabled"/>
		   </xsl:call-template>
	  </xsl:when>
	  <xsl:otherwise>
	        <xsl:choose>
   		        <xsl:when test="($product-code != 'LC')">
    		      <xsl:call-template name="hidden-field">
    	            <xsl:with-param name="name"><xsl:value-of select="$theNodeName"/>_iso_code</xsl:with-param>
	                <xsl:with-param name="value" select="iso_code" />
	              </xsl:call-template>	
               </xsl:when>
               <xsl:otherwise>
                 <xsl:call-template name="input-field">
	                 <xsl:with-param name="label">XSL_PARTIESDETAILS_SWIFT_CODE</xsl:with-param>
	                 <xsl:with-param name="name"><xsl:value-of select="$theNodeName"/>_iso_code</xsl:with-param>
	                 <xsl:with-param name="value" select="iso_code" />
	             </xsl:call-template>
               </xsl:otherwise>
              </xsl:choose>
	  		<xsl:call-template name="input-field">
		    <xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
		    <xsl:with-param name="name"><xsl:value-of select="$theNodeName"/>_name</xsl:with-param>
		    <xsl:with-param name="type"><xsl:if test="$show-button='Y'"><xsl:value-of select="$theNodeName"/></xsl:if></xsl:with-param>
		    <xsl:with-param name="button-type"><xsl:if test="$show-button='Y'"><xsl:value-of select="$theNodeName"/></xsl:if></xsl:with-param>
		    <xsl:with-param name="override-product-code" select="$override-product-code"/>
		    <xsl:with-param name="required" select="$required"/>
		    <xsl:with-param name="maxsize">
		     	<xsl:choose>
					<xsl:when test="($product-code='BG' or $product-code='BR' or $product-code='EC' or $product-code='EL' or $product-code='IC' or $product-code='LC' or $product-code='SG' or $product-code='SI' or $product-code='SR')">
						<xsl:value-of select="defaultresource:getResource('NAME_TRADE_LENGTH')"/>
					</xsl:when>
					<xsl:otherwise>35</xsl:otherwise>
				</xsl:choose>
		     </xsl:with-param>
			<xsl:with-param name="value">
				<xsl:choose>
					 <xsl:when test="$theNodeName='drawee_details_bank'">
					 	<xsl:choose>
						<xsl:when test="name[translate(.,$up,$lo)='issuing bank'] or name[.]=localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_ISSUING_BANK')">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_ISSUING_BANK')" />
						</xsl:when>
						<xsl:when test="name[translate(.,$up,$lo)='confirming bank'] or name[.]=localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_CONFIRMING_BANK')">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_CONFIRMING_BANK')" />
						</xsl:when>
						<xsl:when test="name[translate(.,$up,$lo)='advising bank'] or name[.]=localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_ADVISING_BANK')">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_ADVISING_BANK')" />
						</xsl:when>
						<xsl:when test="name[translate(.,$up,$lo)='negotiating bank'] or name[.]=localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_NEGOTIATING_BANK')">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_NEGOTIATING_BANK')" />
						</xsl:when>
						<xsl:when test="name[translate(.,$up,$lo)='reimbursing bank'] or name[.]=localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_REIMBURSING_BANK')">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_REIMBURSING_BANK')" />
						</xsl:when>
						<xsl:when test="name[translate(.,$up,$lo)='applicant'] or name[.]=localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_APPLICANT')">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_APPLICANT')" />
						</xsl:when>
						<xsl:when test="name[translate(.,$up,$lo)='first advising bank'] or name[.]=localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_FIRST_ADVISING_BANK')">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_FIRST_ADVISING_BANK')" />
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="name[.!='']">
									<xsl:value-of select="name" />
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_DRAWEE_DETAILS_OTHER')" />
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					 	</xsl:choose>
					 </xsl:when>
					  <xsl:when test="$theNodeName='credit_available_with_bank' and $product-code = 'LC' and type != ''">
					  <xsl:value-of select="localization:getCodeData($language,'*','*','C098', type)"/>
					  </xsl:when>
					 <xsl:otherwise><xsl:value-of select="name"/></xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
		    <xsl:with-param name="disabled" select="$disabled"/>
		   </xsl:call-template>
	  </xsl:otherwise>
  </xsl:choose>
  <script>
	dojo.ready(function()
	{
		if(misys._config.swiftRelatedSection !== undefined)
		{
			misys._config.swiftRelatedSections.push('<xsl:value-of select="$theNodeName"/>');
		}
		else 
		{
			misys._config = misys._config || {};
			misys._config.swiftRelatedSections = misys._config.swiftRelatedSections || [];
			misys._config.swiftRelatedSections.push('<xsl:value-of select="$theNodeName"/>');
		}
	});
  </script>
  
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
    <xsl:with-param name="name"><xsl:value-of select="$theNodeName"/>_address_line_1</xsl:with-param>
    <xsl:with-param name="maxsize">
	 <xsl:choose>
		<xsl:when test="($product-code='BR' or $product-code='EC' or $product-code='EL' or $product-code='IC' or $product-code='LC' or $product-code='SG' or $product-code='SI' or $product-code='SR')">
			<xsl:value-of select="defaultresource:getResource('ADDRESS1_TRADE_LENGTH')"/>
		</xsl:when>
		<xsl:otherwise>35</xsl:otherwise>
	 </xsl:choose>
	</xsl:with-param>
    <xsl:with-param name="value" select="address_line_1" />
    <xsl:with-param name="disabled" select="$disabled"/>
    <xsl:with-param name="required" select="$required"/>    
   </xsl:call-template>
   <xsl:call-template name="input-field">
    <xsl:with-param name="name"><xsl:value-of select="$theNodeName"/>_address_line_2</xsl:with-param>
    <xsl:with-param name="maxsize">
	 <xsl:choose>
		<xsl:when test="($product-code='BR' or $product-code='EC' or $product-code='EL' or $product-code='IC' or $product-code='LC' or $product-code='SG' or $product-code='SI' or $product-code='SR')">
			<xsl:value-of select="defaultresource:getResource('ADDRESS2_TRADE_LENGTH')"/>
		</xsl:when>
		<xsl:otherwise>35</xsl:otherwise>
	 </xsl:choose>
	</xsl:with-param>
    <xsl:with-param name="value" select="address_line_2" />
    <xsl:with-param name="disabled" select="$disabled"/>
   </xsl:call-template>
   <xsl:call-template name="input-field">
    <xsl:with-param name="name"><xsl:value-of select="$theNodeName"/>_dom</xsl:with-param>
     <xsl:with-param name="maxsize">
	 <xsl:choose>
		<xsl:when test="($product-code='BR' or $product-code='EC' or $product-code='EL' or $product-code='IC' or $product-code='LC' or $product-code='SG' or $product-code='SI' or $product-code='SR')">
			<xsl:value-of select="defaultresource:getResource('DOM_TRADE_LENGTH')"/>
		</xsl:when>
		<xsl:otherwise>35</xsl:otherwise>
	 </xsl:choose>
	</xsl:with-param>
    <xsl:with-param name="value" select="dom" />
    <xsl:with-param name="disabled" select="$disabled"/>
   </xsl:call-template>
   <xsl:if test="($product-code='BG' or $product-code='BR' or $product-code='EC' or $product-code='EL' or $product-code='IC' or $product-code='LC' or $product-code='SG' or $product-code='SI' or $product-code='SR')">
   		<xsl:call-template name="input-field">
    	<xsl:with-param name="name"><xsl:value-of select="$theNodeName"/>_address_line_4</xsl:with-param>
    	<xsl:with-param name="maxsize">
    		<xsl:value-of select="defaultresource:getResource('ADDRESS4_TRADE_LENGTH')"/>
    	</xsl:with-param>
    	<xsl:with-param name="value" select="address_line_4" />
    	<xsl:with-param name="disabled" select="$disabled"/>
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
   	 <xsl:if test="reference[.!='']"> 
	   <xsl:call-template name="input-field">
	   <xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
	   <xsl:with-param name="name"><xsl:value-of select="$theNodeName"/>_reference</xsl:with-param>
	   <xsl:with-param name="value" select="reference" />
	   <xsl:with-param name="size">16</xsl:with-param>
	   <xsl:with-param name="maxsize">16</xsl:with-param>
	   </xsl:call-template>
	 </xsl:if>
	   
   <xsl:if test="$theNodeName = 'presenting_bank'">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_DETAILS_CONTACT_PERSON_DETAILS</xsl:with-param>
     <xsl:with-param name="name"><xsl:value-of select="$theNodeName"/>_contact_name</xsl:with-param>
     <xsl:with-param name="value" select="contact_name" />
     <xsl:with-param name="size">35</xsl:with-param>
     <xsl:with-param name="maxsize">35</xsl:with-param>
     <xsl:with-param name="disabled">Y</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_DETAILS_PO_CONTACT_PHONE_NUMBER</xsl:with-param>
     <xsl:with-param name="name"><xsl:value-of select="$theNodeName"/>_phone</xsl:with-param>
     <xsl:with-param name="value" select="phone" />
     <xsl:with-param name="size">32</xsl:with-param>
     <xsl:with-param name="maxsize">32</xsl:with-param>
     <xsl:with-param name="disabled">Y</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name"><xsl:value-of select="$theNodeName"/>_iso_code</xsl:with-param>
     <xsl:with-param name="value" select="iso_code"/>
    </xsl:call-template>    
   </xsl:if>
   <xsl:if test="$theNodeName = 'processing_bank'">
   <xsl:call-template name="hidden-field">
     <xsl:with-param name="name"><xsl:value-of select="$theNodeName"/>_iso_code</xsl:with-param>
     <xsl:with-param name="value" select="iso_code"/>
    </xsl:call-template>
   </xsl:if>
  
   <!--
    Fields specific to account_with_bank and pay_through_bank 
    -->
<!--   <xsl:if test="$theNodeName = 'account_with_bank' or $theNodeName = 'pay_through_bank'">-->
<!--    <xsl:call-template name="input-field">-->
<!--     <xsl:with-param name="label">XSL_JURISDICTION_BIC_CODE</xsl:with-param>-->
<!--     <xsl:with-param name="name"><xsl:value-of select="$theNodeName"/>_iso_code</xsl:with-param>-->
<!--     <xsl:with-param name="value" select="iso_code" />-->
<!--     <xsl:with-param name="size">11</xsl:with-param>-->
<!--     <xsl:with-param name="maxsize">11</xsl:with-param>-->
<!--    </xsl:call-template>-->
<!--   </xsl:if>-->

   <!-- Don't show in unsigned mode -->
   <xsl:if test="$displaymode='edit'">
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name"><xsl:value-of select="$theNodeName"/>_reference</xsl:with-param>
      <xsl:with-param name="value" select="reference" />
     </xsl:call-template>
<!--     <xsl:if test="$theNodeName != 'account_with_bank' and $theNodeName != 'pay_through_bank' and $displaymode='edit'">-->
<!--      <xsl:call-template name="hidden-field">-->
<!--       <xsl:with-param name="name"><xsl:value-of select="$theNodeName"/>_iso_code</xsl:with-param>-->
<!--       <xsl:with-param name="value" select="iso_code" />-->
<!--       <xsl:with-param name="maxsize">11</xsl:with-param>-->
<!--      </xsl:call-template>-->
<!--     </xsl:if>-->
   </xsl:if>
          <!-- To BIC CODE -->
   <xsl:if test="$displaymode = 'view' and iso_code[.!=''] and $theNodeName != 'requested_confirmation_party' and $swift-required !='Y'">
        <xsl:call-template name="row-wrapper">
                <xsl:with-param name="label">XSL_PARTIESDETAILS_BIC_CODE</xsl:with-param>
                <xsl:with-param name="content"><div class="content">
                        <xsl:value-of select="iso_code"/></div>
                </xsl:with-param>
   		</xsl:call-template>
   </xsl:if>
  </xsl:template>
 
  <!--
   Transfer Details 
   -->
  <xsl:template name="transfer-details">
   <xsl:param name="product-code"/>
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_PARTIESDETAILS_TRANSFER_DETAILS</xsl:with-param>
    <xsl:with-param name="legend-type">indented-header</xsl:with-param>
    <xsl:with-param name="content">
    <xsl:choose>
     		<xsl:when test="$displaymode='edit'">
     <xsl:call-template name="multichoice-field">
      <xsl:with-param name="type">checkbox</xsl:with-param>
      <xsl:with-param name="label">XSL_PARTIESDETAILS_NOTIFY_AMENDMENT</xsl:with-param>
      <xsl:with-param name="name">notify_amendment_flag</xsl:with-param>
     </xsl:call-template>
    <xsl:call-template name="multichoice-field">
      <xsl:with-param name="type">checkbox</xsl:with-param>
      <xsl:with-param name="label">XSL_PARTIESDETAILS_SUBSTITUTE_INVOICE</xsl:with-param>
      <xsl:with-param name="name">substitute_invoice_flag</xsl:with-param>
     </xsl:call-template>
     			</xsl:when>
			<xsl:otherwise>
			  <xsl:if test="(notify_amendment_flag!='') or (substitute_invoice_flag!='')">
				<xsl:call-template name="row-wrapper">
					<xsl:with-param name="label">XSL_PARTIESDETAILS_NOTIFY_AMENDMENT</xsl:with-param>
					<xsl:with-param name="content"><div class="content">
						<xsl:choose>
							<xsl:when test="notify_amendment_flag[.='Y']">
							<xsl:value-of select="localization:getGTPString($language, 'N034_Y')"/>
							</xsl:when>
							<xsl:otherwise>
							<xsl:if test="notify_amendment_flag[.='N']">
							<xsl:value-of select="localization:getGTPString($language, 'N034_N')"/>
							</xsl:if>
							</xsl:otherwise>
						</xsl:choose>
					</div></xsl:with-param>
				</xsl:call-template>
					<xsl:call-template name="row-wrapper">
					<xsl:with-param name="label">XSL_PARTIESDETAILS_SUBSTITUTE_INVOICE</xsl:with-param>
						<xsl:with-param name="content"><div class="content">
						<xsl:choose>
							<xsl:when test="substitute_invoice_flag[.='Y']">
							<xsl:value-of select="localization:getGTPString($language, 'N034_Y')"/>
							</xsl:when>
							<xsl:otherwise>
							<xsl:if test="substitute_invoice_flag[.='N']">
							<xsl:value-of select="localization:getGTPString($language, 'N034_N')"/>
							</xsl:if>
							</xsl:otherwise>
						</xsl:choose>
					</div></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
		</xsl:otherwise>
	</xsl:choose>
     
     <xsl:call-template name="select-field">
	   <xsl:with-param name="label">XSL_PARTIESDETAILS_ADVISE_MODE</xsl:with-param>
	   <xsl:with-param name="name">advise_mode_code</xsl:with-param>
	   <xsl:with-param name="required">Y</xsl:with-param>
	   <xsl:with-param name="options">
	    <xsl:choose>
	     <xsl:when test="$displaymode='edit'">
	     	<option value="01">
	     		<xsl:if test="advise_mode_code[.='01']"><xsl:attribute name="selected">selected</xsl:attribute> </xsl:if>
	     		<xsl:value-of select="localization:getDecode($language, 'N103', '01')"/>
	     	</option>
	     	<option value="02">
	     		<xsl:if test="advise_mode_code[.='02']"><xsl:attribute name="selected">selected</xsl:attribute> </xsl:if>
	     		<xsl:value-of select="localization:getDecode($language, 'N103', '02')"/>
	     	</option>
	     </xsl:when>
	     <xsl:otherwise>
	       <xsl:choose>
	     	<xsl:when test="advise_mode_code[. = '01']"><xsl:value-of select="localization:getDecode($language, 'N103', '01')"/></xsl:when>
	     	<xsl:when test="advise_mode_code[. = '02']"><xsl:value-of select="localization:getDecode($language, 'N103', '02')"/></xsl:when>
	       </xsl:choose>	
	     </xsl:otherwise>
	    </xsl:choose>
	   </xsl:with-param>
	 </xsl:call-template>
	
	  <xsl:if test="$displaymode='edit' or advise_thru_bank/name[.!='']">
	     <xsl:call-template name="fieldset-wrapper">
	      <xsl:with-param name="legend">XSL_BANKDETAILS_TAB_ADVISE_THRU_BANK</xsl:with-param>
	      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
	      <xsl:with-param name="content">
	       <xsl:apply-templates select="advise_thru_bank">
	        <xsl:with-param name="theNodeName">advise_thru_bank</xsl:with-param>
	        <xsl:with-param name="override-product-code" select="$product-code"/>
	        <xsl:with-param name="readonly">Y</xsl:with-param>
	       </xsl:apply-templates>
	      </xsl:with-param>
	     </xsl:call-template>
	   </xsl:if>  
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
 
 
  <!--
   Radio Buttons for Issuing Bank Charges, Outside Country Charges, Confirmation Charges.
   
   Common to LC forms and FT.
  -->
  <xsl:template match="open_chrg_brn_by_code | corr_chrg_brn_by_code | cfm_chrg_brn_by_code | amd_chrg_brn_by_code">
   <xsl:param name="node-name"/>
   <xsl:param name="label"/>
   <xsl:param name="first-value">01</xsl:param> <!-- Value of the first radio button -->
   <xsl:param name="second-value">02</xsl:param> <!-- Value of the second radio button -->
   <xsl:param name="third-value">08</xsl:param> <!-- Value of the third radio button -->
   <xsl:param name="fourth-value">07</xsl:param> <!-- Value of the fourth radio button -->
   <xsl:param name="fifth-value">05</xsl:param>
   <xsl:param name="ninth-value">09</xsl:param>
   <xsl:param name="show-option">N</xsl:param>
   <xsl:param name="show-required-prefix">N</xsl:param>
   <!-- Can override labels -->
   <xsl:param name="applicant-label">XSL_CHRGDETAILS_APPLICANT</xsl:param>
   <xsl:param name="beneficiary-label">XSL_CHRGDETAILS_BENEFICIARY</xsl:param>
   <xsl:param name="shared-label">XSL_CHRGDETAILS_SHARED</xsl:param>
   <xsl:param name="splitting-label">XSL_CHRGDETAILS_SPLITTING</xsl:param>
   <xsl:param name="other-label">XSL_CHRGDETAILS_OTHER</xsl:param>
   <xsl:param name="none-label">XSL_CHRGDETAILS_NONE</xsl:param>
   
    <xsl:call-template name="multioption-inline-wrapper">
	      <xsl:with-param name="group-label" select="$label"/>
	      <xsl:with-param name="show-required-prefix" select="$show-required-prefix"/>
	      <xsl:with-param name="content">
		        <xsl:call-template name="multichoice-field">
			      <xsl:with-param name="group-label" select="$label"/>
			      <xsl:with-param name="label" select="$applicant-label"/>
			      <xsl:with-param name="name" select="$node-name"/>
			      <xsl:with-param name="id"><xsl:value-of select="$node-name"/>_1</xsl:with-param>
			      <xsl:with-param name="value" select="$first-value"/>
			      <xsl:with-param name="checked"><xsl:if test="self::node()[. = $first-value]">Y</xsl:if></xsl:with-param>
			      <xsl:with-param name="type">radiobutton</xsl:with-param>
			      <xsl:with-param name="inline">Y</xsl:with-param>
			     </xsl:call-template>
			    
			     <xsl:call-template name="multichoice-field">
			      <xsl:with-param name="label" select="$beneficiary-label"/>
			      <xsl:with-param name="name" select="$node-name"/>
			      <xsl:with-param name="id"><xsl:value-of select="$node-name"/>_2</xsl:with-param>
			      <xsl:with-param name="value" select="$second-value"/>
			      <xsl:with-param name="checked"><xsl:if test="self::node()[. = $second-value]">Y</xsl:if></xsl:with-param>
			      <xsl:with-param name="type">radiobutton</xsl:with-param>
			      <xsl:with-param name="inline">Y</xsl:with-param>
			     </xsl:call-template>
			    <xsl:if test = "$node-name = 'amd_chrg_brn_by_code' and $swift2019Enabled">
			     <xsl:call-template name="multichoice-field">
			      <xsl:with-param name="label" select="$shared-label"/>
			      <xsl:with-param name="name" select="$node-name"/>
			      <xsl:with-param name="id"><xsl:value-of select="$node-name"/>_5</xsl:with-param>
			      <xsl:with-param name="value" select="$fifth-value"/>
			      <xsl:with-param name="checked"><xsl:if test="self::node()[. = $fifth-value]">Y</xsl:if></xsl:with-param>
			      <xsl:with-param name="type">radiobutton</xsl:with-param>
			      <xsl:with-param name="inline">Y</xsl:with-param>
			     </xsl:call-template>
			     </xsl:if>	
			     <xsl:if test="defaultresource:getResource('CHARGE_SPLITTING_LC') = 'true' and $product-code='LC'">
				     <xsl:call-template name="multichoice-field">
				      <xsl:with-param name="label" select="$splitting-label"/>
				      <xsl:with-param name="name" select="$node-name"/>
				      <xsl:with-param name="id"><xsl:value-of select="$node-name"/>_3</xsl:with-param>
				      <xsl:with-param name="value" select="$third-value"/>
				      <xsl:with-param name="checked"><xsl:if test="self::node()[. = $third-value]">Y</xsl:if></xsl:with-param>
				      <xsl:with-param name="type">radiobutton</xsl:with-param>
				      <xsl:with-param name="inline">Y</xsl:with-param>
				      <xsl:with-param name="disabled">Y</xsl:with-param>
			      	    </xsl:call-template>
			     </xsl:if>

			     <xsl:if test="$show-option = 'Y'">			     
				     <xsl:call-template name="multichoice-field">
				      <xsl:with-param name="label" select="$other-label"/>
				      <xsl:with-param name="name" select="$node-name"/>
				      <xsl:with-param name="id"><xsl:value-of select="$node-name"/>_4</xsl:with-param>
				      <xsl:with-param name="value" select="$fourth-value"/>
				      <xsl:with-param name="checked"><xsl:if test="self::node()[. = $fourth-value]">Y</xsl:if></xsl:with-param>
				      <xsl:with-param name="type">radiobutton</xsl:with-param>
				      <xsl:with-param name="inline">Y</xsl:with-param>
				     </xsl:call-template>
				     <xsl:if test = "$node-name = 'amd_chrg_brn_by_code'">
			     <xsl:call-template name="multichoice-field">
			      <xsl:with-param name="label" select="$none-label"/>
			      <xsl:with-param name="name" select="$node-name"/>
			      <xsl:with-param name="id"><xsl:value-of select="$node-name"/>_9</xsl:with-param>
			      <xsl:with-param name="value" select="$ninth-value"/>
			      <xsl:with-param name="checked"><xsl:if test="self::node()[. = $ninth-value]">Y</xsl:if></xsl:with-param>
			      <xsl:with-param name="type">radiobutton</xsl:with-param>
			      <xsl:with-param name="inline">Y</xsl:with-param>
			     </xsl:call-template>
			     </xsl:if>
				     <br/>
				     
					<xsl:if test = "$node-name = 'amd_chrg_brn_by_code'">
				     <div>
				     	<xsl:choose>
				     		<xsl:when test="$displaymode='edit'">
				     			<xsl:attribute name="style">margin-left:420px;</xsl:attribute>
				     		</xsl:when>
				     		<xsl:otherwise>
				     			<xsl:attribute name="style">margin-left:250px;</xsl:attribute>
				     		</xsl:otherwise>
				     	</xsl:choose>
				    				     
				     <xsl:call-template name="textarea-field">
				      <xsl:with-param name="name">narrative_amend_charges_other</xsl:with-param>
				      <xsl:with-param name="messageValue">
				      	<xsl:choose>
							<xsl:when test="$product-code='SI'">
								<xsl:value-of select="/si_tnx_record/narrative_amend_charges_other/text"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="/lc_tnx_record/narrative_amend_charges_other/text"/>
							</xsl:otherwise>
						</xsl:choose>
				      </xsl:with-param>
				      <xsl:with-param name="button-type"></xsl:with-param>
				      <xsl:with-param name="phrase-params">{'category':'42'}</xsl:with-param>
				      <xsl:with-param name="cols">35</xsl:with-param>
				      <xsl:with-param name="rows">6</xsl:with-param>
				      <xsl:with-param name="maxlines">6</xsl:with-param>
				     </xsl:call-template>
				     </div>				     
					</xsl:if>		     
				 </xsl:if>			     
	    	</xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template match="character_commitment">
   <xsl:param name="node-name"/>
   <xsl:param name="label"/>
   <xsl:param name="first-value">01</xsl:param> <!-- Value of the first radio button -->
   <xsl:param name="second-value">02</xsl:param> <!-- Value of the second radio button -->
  
   <!-- Can override labels -->
   <xsl:param name="conditional-label">XSL_GUARANTEE_CONDITIONAL</xsl:param>
   <xsl:param name="first-demand-label">XSL_GUARANTEE_FIRST_DEMAND</xsl:param>   
  <xsl:choose>
	 	<xsl:when test="$displaymode='edit'">  
    <xsl:call-template name="multioption-inline-wrapper">
	      <xsl:with-param name="group-label" select="$label"/>
	      <xsl:with-param name="content">	    
		        <xsl:call-template name="multichoice-field">
			      <xsl:with-param name="group-label" select="$label"/>
			      <xsl:with-param name="label" select="$conditional-label"/>
			      <xsl:with-param name="name" select="$node-name"/>
			      <xsl:with-param name="id"><xsl:value-of select="$node-name"/>_1</xsl:with-param>
			      <xsl:with-param name="value" select="$first-value"/>
			      <xsl:with-param name="checked"><xsl:if test="self::node()[. = $first-value]">Y</xsl:if></xsl:with-param>
			      <xsl:with-param name="type">radiobutton</xsl:with-param>
			      <xsl:with-param name="inline">Y</xsl:with-param>
			     </xsl:call-template>			    	    
			     <xsl:call-template name="multichoice-field">
			      <xsl:with-param name="label" select="$first-demand-label"/>
			      <xsl:with-param name="name" select="$node-name"/>
			      <xsl:with-param name="id"><xsl:value-of select="$node-name"/>_2</xsl:with-param>
			      <xsl:with-param name="value" select="$second-value"/>
			      <xsl:with-param name="checked"><xsl:if test="self::node()[. = $second-value]">Y</xsl:if></xsl:with-param>
			      <xsl:with-param name="type">radiobutton</xsl:with-param>
			      <xsl:with-param name="inline">Y</xsl:with-param>
			     </xsl:call-template>
	    	</xsl:with-param>
    </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
     <xsl:call-template name="multioption-inline-wrapper">
	      <xsl:with-param name="group-label" select="$label"/>
    <xsl:with-param name="content">	 
    <xsl:if test="self::node()[. = $first-value]">      
		        <xsl:call-template name="multichoice-field">
			      <xsl:with-param name="group-label" select="$label"/>
			      <xsl:with-param name="label" select="$conditional-label"/>
			      <xsl:with-param name="name" select="$node-name"/>
			      <xsl:with-param name="id"><xsl:value-of select="$node-name"/>_1</xsl:with-param>
			      <xsl:with-param name="value" select="$first-value"/>
			      <xsl:with-param name="checked"><xsl:if test="self::node()[. = $first-value]">Y</xsl:if></xsl:with-param>
			      <xsl:with-param name="type">radiobutton</xsl:with-param>
			      <xsl:with-param name="inline">Y</xsl:with-param>
			     </xsl:call-template>			    
    </xsl:if>
     <xsl:if test="self::node()[. = $second-value]">         
     <xsl:call-template name="multichoice-field">
			      <xsl:with-param name="label" select="$first-demand-label"/>
			      <xsl:with-param name="name" select="$node-name"/>
			      <xsl:with-param name="id"><xsl:value-of select="$node-name"/>_2</xsl:with-param>
			      <xsl:with-param name="value" select="$second-value"/>
			      <xsl:with-param name="checked"><xsl:if test="self::node()[. = $second-value]">Y</xsl:if></xsl:with-param>
			      <xsl:with-param name="type">radiobutton</xsl:with-param>
			      <xsl:with-param name="inline">Y</xsl:with-param>
			     </xsl:call-template>			    
     </xsl:if>
      </xsl:with-param>
     </xsl:call-template>
     </xsl:otherwise>
     </xsl:choose>
  </xsl:template>
  
  <!--
  Issuing Bank Tab Content. Common to LC forms, and FT.
  -->
  <xsl:template name="issuing-bank-tabcontent">
   <xsl:param name="main-bank-name">issuing_bank</xsl:param>
   <xsl:param name="sender-name">applicant</xsl:param>
   <xsl:param name="sender-reference-name">applicant_reference</xsl:param>
   
   <xsl:if test="$displaymode='edit'">
    <script>
    	dojo.ready(function(){
    		misys._config = misys._config || {};
			misys._config.customerReferences = {};
			misys._config.isoCodes = {};
			<xsl:apply-templates select="avail_main_banks/bank" mode="customer_references"/>
		});
	</script>
   </xsl:if>
   <xsl:call-template name="main-bank-selectbox">
    <xsl:with-param name="main-bank-name" select="$main-bank-name"/>
    <xsl:with-param name="sender-name" select="$sender-name"/>
    <xsl:with-param name="sender-reference-name" select="$sender-reference-name"/>
   </xsl:call-template>
   <xsl:choose>
	   <xsl:when test="$product-code='IO'">
	   	<!-- we need to pass this variable to readonly param, If utils:isBuyerBICEditable() returns Y means field should be read only-->
	   		<xsl:variable name="isbuyerbic-editable">
	   			<xsl:choose>
	   				<xsl:when test="true = utils:isBuyerBICEditable()">Y</xsl:when>
					<xsl:otherwise>N</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>	
		   <xsl:call-template name="customer-reference-selectbox">
		    <xsl:with-param name="main-bank-name" select="$main-bank-name"/>
		    <xsl:with-param name="sender-name" select="$sender-name"/>
		    <xsl:with-param name="sender-reference-name" select="$sender-reference-name"/>
		    <xsl:with-param name="label">XSL_PARTY_BANK_REFERENCE</xsl:with-param>
  			</xsl:call-template>
		   	<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_PARTIESDETAILS_BUYER_BANK_BIC</xsl:with-param>
				<xsl:with-param name="name">buyer_bank_bic</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
				<xsl:with-param name="readonly"><xsl:value-of select="$isbuyerbic-editable"/></xsl:with-param>
				<xsl:with-param name="size">11</xsl:with-param>
				<xsl:with-param name="maxsize">11</xsl:with-param>
			</xsl:call-template>
	   </xsl:when>
	   <xsl:when test="$product-code='EA'">
	   <xsl:call-template name="customer-reference-selectbox">
		    <xsl:with-param name="main-bank-name" select="$main-bank-name"/>
		    <xsl:with-param name="sender-name" select="$sender-name"/>
		    <xsl:with-param name="sender-reference-name" select="$sender-reference-name"/>
		    <xsl:with-param name="label">XSL_PARTY_BANK_REFERENCE</xsl:with-param>
		   </xsl:call-template>
		   	<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_PARTIESDETAILS_SELLER_BANK_BIC</xsl:with-param>
				<xsl:with-param name="name">seller_bank_bic</xsl:with-param>
				<xsl:with-param name="value" select="seller_bank_bic"/>
				<xsl:with-param name="required">Y</xsl:with-param>
				<xsl:with-param name="readonly">Y</xsl:with-param>
				<xsl:with-param name="size">11</xsl:with-param>
				<xsl:with-param name="maxsize">11</xsl:with-param>
			</xsl:call-template>
	   </xsl:when>
	   <xsl:otherwise>
	   	 <xsl:call-template name="customer-reference-selectbox">
		    <xsl:with-param name="main-bank-name" select="$main-bank-name"/>
		    <xsl:with-param name="sender-name" select="$sender-name"/>
		    <xsl:with-param name="sender-reference-name" select="$sender-reference-name"/>
		   </xsl:call-template>
	   </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
 
  <!--
   Main Bank Select Box.  
   -->
  <xsl:template name="main-bank-selectbox">
   <xsl:param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:param>
   <xsl:param name="main-bank-name"/>
   <xsl:param name="sender-name"/>
   <xsl:param name="sender-reference-name"/>
   <xsl:param name="required">Y</xsl:param>

   <xsl:variable name="main_bank_abbv_name_value">
    <xsl:value-of select="//*[name()=$main-bank-name]/abbv_name"/>
   </xsl:variable>
    
   <xsl:variable name="main-bank-name-value">
    <xsl:if test="//*[name()=$main-bank-name]/name">
     <xsl:value-of select="//*[name()=$main-bank-name]/name"/>
    </xsl:if>
   </xsl:variable>
  
   <xsl:variable name="sender-reference-value" select="//*[name()=$sender-reference-name]"/>
  
   <!-- Hidden Fields -->
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name"><xsl:value-of select="$main-bank-name"/>_name</xsl:with-param>
    <xsl:with-param name="value">
     <xsl:choose>
      <xsl:when test="$main-bank-name-value != ''">
       <xsl:value-of select="$main-bank-name-value"/>
      </xsl:when>
      <!-- never used because if only one available main bank, server set it to current main bank -->
      <xsl:when test="count(//*/avail_main_banks/bank)=1"><xsl:value-of select="//*/avail_main_banks/bank/name"/></xsl:when>
      <xsl:otherwise/>
      </xsl:choose>
     </xsl:with-param>
   </xsl:call-template>

   <xsl:choose>
   	<xsl:when test="product_code[.='FX'] or (product_code[.='FT'] and (sub_product_code[.='TRINT'] or sub_product_code[.='TRTPT'])) or (product_code[.='TD'] and sub_product_code[.='TRTD'])">
	   <xsl:call-template name="select-field">
	    <xsl:with-param name="label" select="$label"/>
	    <xsl:with-param name="name"><xsl:value-of select="$main-bank-name"/>_abbv_name</xsl:with-param>
	    <xsl:with-param name="value"><xsl:value-of select="$main_bank_abbv_name_value"/></xsl:with-param>
	    <xsl:with-param name="required">Y</xsl:with-param>
	    <xsl:with-param name="options">
	     <xsl:choose>
	      <xsl:when test="$displaymode='edit'"><xsl:apply-templates select="avail_main_banks/bank[treasury_branch_reference != '']" mode="main"/></xsl:when>
	      <xsl:otherwise><xsl:value-of select="//*[name()=$main-bank-name]/name"/></xsl:otherwise>
	     </xsl:choose>
	    </xsl:with-param>
	   </xsl:call-template>
	</xsl:when>
	<xsl:otherwise>
		<xsl:call-template name="select-field">
	    <xsl:with-param name="label" select="$label"/>
	    <xsl:with-param name="name"><xsl:value-of select="$main-bank-name"/>_abbv_name</xsl:with-param>
	    <xsl:with-param name="value"><xsl:value-of select="$main_bank_abbv_name_value"/></xsl:with-param>
	    <xsl:with-param name="required">Y</xsl:with-param>
	    <xsl:with-param name="disabled"><xsl:if test="bg_code[.!=''] or product_code[.='EA']">Y</xsl:if></xsl:with-param>
	    <xsl:with-param name="readonly"><xsl:if test="product_code[.='IO'] and tnx_type_code[.='03'] and defaultresource:getResource('IO_AMEND_READONLY')">Y</xsl:if></xsl:with-param>
	    <xsl:with-param name="options">
	     <xsl:choose>
	      <xsl:when test="$displaymode='edit'"><xsl:apply-templates select="avail_main_banks/bank" mode="main"/></xsl:when>
	      <xsl:otherwise><xsl:value-of select="//*[name()=$main-bank-name]/name"/></xsl:otherwise>
	     </xsl:choose>
	    </xsl:with-param>
	   </xsl:call-template>
	</xsl:otherwise>   
   </xsl:choose>
   <xsl:if test="$displaymode='view'">
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">remitting_bank_abbv_name</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="remitting_bank/abbv_name"/></xsl:with-param>
     </xsl:call-template>
   </xsl:if>
  </xsl:template>
 
  <!--
   Customer Reference Select Box.
   -->
  <xsl:template name="customer-reference-selectbox">
   <xsl:param name="main-bank-name"/>
   <xsl:param name="sender-name"/>
   <xsl:param name="sender-reference-name"/>
   <xsl:param name="label">XSL_PARTIESDETAILS_CUST_REFERENCE</xsl:param>
   <xsl:variable name="main_bank_abbv_name_value">
    <xsl:value-of select="//*[name()=$main-bank-name]/abbv_name"/>
   </xsl:variable>
   <xsl:variable name="sender-reference-value">
    <xsl:choose>
     <!-- current customer reference not null (draft) -->
     <xsl:when test="//*[name()=$sender-reference-name] != ''">
       <xsl:value-of select="//*[name()=$sender-reference-name]"/>
     </xsl:when>
     <!-- not entity defined and only one bank and only one customer reference available -->
     <xsl:when test="entities[.= '0']">
       <xsl:if test="count(avail_main_banks/bank/customer_reference)=1">
         <xsl:value-of select="avail_main_banks/bank/customer_reference/reference"/>
       </xsl:if>
     </xsl:when>
     <!-- only one entity, only one bank and only one customer reference available -->
     <xsl:otherwise>
       <xsl:if test="count(avail_main_banks/bank/entity/customer_reference)=1">
         <xsl:value-of select="avail_main_banks/bank/entity/customer_reference/reference"/>
       </xsl:if>          
     </xsl:otherwise>
    </xsl:choose>
   </xsl:variable>
   
   <!-- Check if customer references are defined for entities or not -->
   <xsl:if test="//*/avail_main_banks/bank/entity/customer_reference or avail_main_banks/bank/customer_reference">
    <!-- Hidden Fields -->
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name"><xsl:value-of select="$sender-reference-name"/></xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="$sender-reference-value"/></xsl:with-param>
    </xsl:call-template>

    <xsl:choose>
    <xsl:when test="$displaymode='edit'">
        <xsl:call-template name="select-field">
     <xsl:with-param name="label" select="$label"/>
     <xsl:with-param name="name"><xsl:value-of select="$main-bank-name"/>_customer_reference</xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="$sender-reference-value"/></xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="readonly"><xsl:if test="product_code[.='IO'] and tnx_type_code[.='03'] and defaultresource:getResource('IO_AMEND_READONLY')">Y</xsl:if></xsl:with-param>
     <xsl:with-param name="options">
      <xsl:choose>
       <xsl:when test="$displaymode='edit'">
	      <xsl:choose>
	      <!-- if not entity defined -->         
	      <xsl:when test="entities[.= '0']">
	       <xsl:apply-templates select="avail_main_banks/bank[./abbv_name=$main_bank_abbv_name_value]/customer_reference" mode="option">
	        <xsl:with-param name="selected_reference"><xsl:value-of select="$sender-reference-value"/></xsl:with-param>
	       </xsl:apply-templates>
	      </xsl:when>
	      <!-- else -->  
	      <xsl:otherwise>
	       <xsl:apply-templates select="avail_main_banks/bank[./abbv_name=$main_bank_abbv_name_value]/entity/customer_reference" mode="option">
	        <xsl:with-param name="selected_reference"><xsl:value-of select="$sender-reference-value"/></xsl:with-param>
	       </xsl:apply-templates>
	      </xsl:otherwise>
	     </xsl:choose>
       </xsl:when>
       <xsl:otherwise>
	     <xsl:choose>
		     <xsl:when test="count(avail_main_banks/bank/entity/customer_reference[reference=$sender-reference-value]) >= 1 or count(avail_main_banks/bank/entity/customer_reference) >= 1">
		      	<xsl:value-of select="//*/avail_main_banks/bank/entity/customer_reference/description"/>
		     </xsl:when>
		     <xsl:otherwise>
		     	<xsl:value-of select="avail_main_banks/bank[./abbv_name=$main_bank_abbv_name_value]/customer_reference/description"/>
		     </xsl:otherwise>
	     </xsl:choose>
       </xsl:otherwise>
      </xsl:choose>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:when>
   <xsl:otherwise>
        <xsl:variable name="fscm_products">
        	<xsl:value-of select="defaultresource:getResource('FSCM_PRODUCTS_LIST')"/>
        </xsl:variable>
        <xsl:variable name="productCode">
        	<xsl:value-of select="product_code"/>
        </xsl:variable>
   		<xsl:variable name="cust_ref_desc">
   		<xsl:choose>
   		<xsl:when test="count(avail_main_banks/bank/entity/customer_reference[reference=$sender-reference-value]) >= 1 or count(avail_main_banks/bank/entity/customer_reference) >= 1">
   		  <xsl:choose>
           <xsl:when test= "contains($fscm_products, $productCode) or product_code[.='LS']">
          	<xsl:value-of select="//*/avail_main_banks/bank[./abbv_name=$main_bank_abbv_name_value]/entity/customer_reference[reference=$sender-reference-value]/description"/>
          </xsl:when>
          <xsl:when test="defaultresource:getResource('ISSUER_REFERENCE_NAME') = 'true'">
          	<xsl:value-of select="utils:decryptApplicantReference(//*/avail_main_banks/bank[./abbv_name=$main_bank_abbv_name_value]/entity/customer_reference[reference=$sender-reference-value]/reference)"/>
          </xsl:when>
          <xsl:otherwise>
          	<xsl:value-of select="//*/avail_main_banks/bank[./abbv_name=$main_bank_abbv_name_value]/entity/customer_reference[reference=$sender-reference-value]/description"/>
          </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:when test="//*/avail_main_banks/bank[./abbv_name=$main_bank_abbv_name_value]/customer_reference[reference=$sender-reference-value]/description[.!=''] and defaultresource:getResource('ISSUER_REFERENCE_NAME') = 'true'">
        	<xsl:value-of select="utils:decryptApplicantReference(//*/avail_main_banks/bank[./abbv_name=$main_bank_abbv_name_value]/customer_reference[reference=$sender-reference-value]/reference)"/>
        </xsl:when>
        <xsl:when test="//*/avail_main_banks/bank[./abbv_name=$main_bank_abbv_name_value]/customer_reference[reference=$sender-reference-value]/description[.!=''] and defaultresource:getResource('ISSUER_REFERENCE_NAME') = 'false'">
        	<xsl:value-of select="//*/avail_main_banks/bank[./abbv_name=$main_bank_abbv_name_value]/customer_reference[reference=$sender-reference-value]/description"/>
        </xsl:when>
        <xsl:otherwise>
        	<xsl:if test="product_code[.='FX']">
           		<xsl:value-of select="utils:decryptApplicantReference($sender-reference-value)" />	
           	</xsl:if>
        </xsl:otherwise>
        </xsl:choose>
       </xsl:variable>
   	  <xsl:call-template name="input-field">
   	   	 <xsl:with-param name="label" select="$label"/>
    	 <xsl:with-param name="name"><xsl:value-of select="$main-bank-name"/>_customer_reference</xsl:with-param>
    	 <xsl:with-param name="value"><xsl:value-of select="$cust_ref_desc"/></xsl:with-param>
   </xsl:call-template>
   </xsl:otherwise>
  </xsl:choose>
  </xsl:if>
  <!-- <xsl:if test="not(//*/avail_main_banks) and ($displaymode='view') and (product_code[.='LC'] or product_code[.='FX'] or product_code[.='SI'])">
  		<xsl:variable name="cust_ref_desc">
   			<xsl:value-of select="$sender-reference-value"/>
        </xsl:variable>
        <xsl:call-template name="input-field">
	   	   	 <xsl:with-param name="label" select="$label"/>
	    	 <xsl:with-param name="name"><xsl:value-of select="$main-bank-name"/>_customer_reference</xsl:with-param>
	    	 <xsl:with-param name="value"><xsl:value-of select="$cust_ref_desc"/></xsl:with-param>
   		</xsl:call-template>
  </xsl:if> -->
 </xsl:template>
 
 <!--
 	Store to keep the current amendment's Narrative Data -->
 	<xsl:template name="amendedNarrativesStore">
   <script>  
    	dojo.ready(function(){
    		misys._config = misys._config || {};
    		dojo.mixin(misys._config, {
    				narrativeDescGoodsDataStore : [
    				<xsl:if test="/lc_tnx_record/narrative_description_goods/amendments/amendment/data/datum">
						<xsl:for-each select="/lc_tnx_record/narrative_description_goods/amendments/amendment/data/datum">
							 { 
								verb: ["<xsl:value-of select="verb"/>"],
								content: ["<xsl:value-of select="securityUtils:encodeJavaScript(text)"/>"],
								text_size: [<xsl:value-of select="convertTools:splitOnNewLine(text)"/>]
							},
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="/si_tnx_record/narrative_description_goods/amendments/amendment/data/datum">
						<xsl:for-each select="/si_tnx_record/narrative_description_goods/amendments/amendment/data/datum">
							 { 
								verb: ["<xsl:value-of select="verb"/>"],
								content: ["<xsl:value-of select="securityUtils:encodeJavaScript(text)"/>"],
								text_size: [<xsl:value-of select="convertTools:splitOnNewLine(text)"/>]
							},
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="/el_tnx_record/narrative_description_goods/amendments/amendment/data/datum">
						<xsl:for-each select="/el_tnx_record/narrative_description_goods/amendments/amendment/data/datum">
							 { 
								verb: ["<xsl:value-of select="verb"/>"],
								content: ["<xsl:value-of select="securityUtils:encodeJavaScript(text)"/>"],
								text_size: [<xsl:value-of select="convertTools:splitOnNewLine(text)"/>]
							},
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="/sr_tnx_record/narrative_description_goods/amendments/amendment/data/datum">
						<xsl:for-each select="/sr_tnx_record/narrative_description_goods/amendments/amendment/data/datum">
							 { 
								verb: ["<xsl:value-of select="verb"/>"],
								content: ["<xsl:value-of select="securityUtils:encodeJavaScript(text)"/>"],
								text_size: [<xsl:value-of select="convertTools:splitOnNewLine(text)"/>]
							},
						</xsl:for-each>
					</xsl:if>
					],		
    		});
    		dojo.mixin(misys._config, {
    				narrativeDocsReqDataStore : [
    				<xsl:if test="/lc_tnx_record/narrative_documents_required/amendments/amendment/data/datum">
						<xsl:for-each select="/lc_tnx_record/narrative_documents_required/amendments/amendment/data/datum">
							 { 
								verb: ["<xsl:value-of select="verb"/>"],
								content: ["<xsl:value-of select="securityUtils:encodeJavaScript(text)"/>"],
								text_size: [<xsl:value-of select="convertTools:splitOnNewLine(text)"/>]
							},
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="/si_tnx_record/narrative_documents_required/amendments/amendment/data/datum">
						<xsl:for-each select="/si_tnx_record/narrative_documents_required/amendments/amendment/data/datum">
							 { 
								verb: ["<xsl:value-of select="verb"/>"],
								content: ["<xsl:value-of select="securityUtils:encodeJavaScript(text)"/>"],
								text_size: [<xsl:value-of select="convertTools:splitOnNewLine(text)"/>]
							},
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="/el_tnx_record/narrative_documents_required/amendments/amendment/data/datum">
						<xsl:for-each select="/el_tnx_record/narrative_documents_required/amendments/amendment/data/datum">
							 { 
								verb: ["<xsl:value-of select="verb"/>"],
								content: ["<xsl:value-of select="securityUtils:encodeJavaScript(text)"/>"],
								text_size: [<xsl:value-of select="convertTools:splitOnNewLine(text)"/>]
							},
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="/sr_tnx_record/narrative_documents_required/amendments/amendment/data/datum">
						<xsl:for-each select="/sr_tnx_record/narrative_documents_required/amendments/amendment/data/datum">
							 { 
								verb: ["<xsl:value-of select="verb"/>"],
								content: ["<xsl:value-of select="securityUtils:encodeJavaScript(text)"/>"],
								text_size: [<xsl:value-of select="convertTools:splitOnNewLine(text)"/>]
							},
						</xsl:for-each>
					</xsl:if>
					],		
    		});
    		dojo.mixin(misys._config, {
    				narrativeAddInstrDataStore : [
    				<xsl:if test="/lc_tnx_record/narrative_additional_instructions/amendments/amendment/data/datum">
						<xsl:for-each select="/lc_tnx_record/narrative_additional_instructions/amendments/amendment/data/datum">
							 { 
								verb: ["<xsl:value-of select="verb"/>"],
								content: ["<xsl:value-of select="securityUtils:encodeJavaScript(text)"/>"],
								text_size: [<xsl:value-of select="convertTools:splitOnNewLine(text)"/>]
							},
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="/si_tnx_record/narrative_additional_instructions/amendments/amendment/data/datum">
						<xsl:for-each select="/si_tnx_record/narrative_additional_instructions/amendments/amendment/data/datum">
							 { 
								verb: ["<xsl:value-of select="verb"/>"],
								content: ["<xsl:value-of select="securityUtils:encodeJavaScript(text)"/>"],
								text_size: [<xsl:value-of select="convertTools:splitOnNewLine(text)"/>]
							},
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="/el_tnx_record/narrative_additional_instructions/amendments/amendment/data/datum">
						<xsl:for-each select="/el_tnx_record/narrative_additional_instructions/amendments/amendment/data/datum">
							 { 
								verb: ["<xsl:value-of select="verb"/>"],
								content: ["<xsl:value-of select="securityUtils:encodeJavaScript(text)"/>"],
								text_size: [<xsl:value-of select="convertTools:splitOnNewLine(text)"/>]
							},
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="/sr_tnx_record/narrative_additional_instructions/amendments/amendment/data/datum">
						<xsl:for-each select="/sr_tnx_record/narrative_additional_instructions/amendments/amendment/data/datum">
							 { 
								verb: ["<xsl:value-of select="verb"/>"],
								content: ["<xsl:value-of select="securityUtils:encodeJavaScript(text)"/>"],
								text_size: [<xsl:value-of select="convertTools:splitOnNewLine(text)"/>]
							},
						</xsl:for-each>
					</xsl:if>
					],		
    		});
    		dojo.mixin(misys._config, {
    				narrativeSpBeneDataStore : [
    				<xsl:if test="/lc_tnx_record/narrative_special_beneficiary/amendments/amendment/data/datum">
						<xsl:for-each select="/lc_tnx_record/narrative_special_beneficiary/amendments/amendment/data/datum">
							 { 
								verb: ["<xsl:value-of select="verb"/>"],
								content: ["<xsl:value-of select="securityUtils:encodeJavaScript(text)"/>"],
								text_size: [<xsl:value-of select="convertTools:splitOnNewLine(text)"/>]
							},
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="/si_tnx_record/narrative_special_beneficiary/amendments/amendment/data/datum">
						<xsl:for-each select="/si_tnx_record/narrative_special_beneficiary/amendments/amendment/data/datum">
							 { 
								verb: ["<xsl:value-of select="verb"/>"],
								content: ["<xsl:value-of select="securityUtils:encodeJavaScript(text)"/>"],
								text_size: [<xsl:value-of select="convertTools:splitOnNewLine(text)"/>]
							},
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="/el_tnx_record/narrative_special_beneficiary/amendments/amendment/data/datum">
						<xsl:for-each select="/el_tnx_record/narrative_special_beneficiary/amendments/amendment/data/datum">
							 { 
								verb: ["<xsl:value-of select="verb"/>"],
								content: ["<xsl:value-of select="securityUtils:encodeJavaScript(text)"/>"],
								text_size: [<xsl:value-of select="convertTools:splitOnNewLine(text)"/>]
							},
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="/sr_tnx_record/narrative_special_beneficiary/amendments/amendment/data/datum">
						<xsl:for-each select="/sr_tnx_record/narrative_special_beneficiary/amendments/amendment/data/datum">
							 { 
								verb: ["<xsl:value-of select="verb"/>"],
								content: ["<xsl:value-of select="securityUtils:encodeJavaScript(text)"/>"],
								text_size: [<xsl:value-of select="convertTools:splitOnNewLine(text)"/>]
							},
						</xsl:for-each>
					</xsl:if>
					],		
    		});
    		<xsl:if test="security:isBank($rundata)">
    		dojo.mixin(misys._config, {
    				narrativeSpRecvbankDataStore : [
   					<xsl:if test="/lc_tnx_record/narrative_special_recvbank/amendments/amendment/data/datum">
						<xsl:for-each select="/lc_tnx_record/narrative_special_recvbank/amendments/amendment/data/datum">
								 { 
									verb: ["<xsl:value-of select="verb"/>"],
								content: ["<xsl:value-of select="securityUtils:encodeJavaScript(text)"/>"],
									text_size: [<xsl:value-of select="convertTools:splitOnNewLine(text)"/>]
								},
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="/si_tnx_record/narrative_special_recvbank/amendments/amendment/data/datum">
						<xsl:for-each select="/si_tnx_record/narrative_special_recvbank/amendments/amendment/data/datum">
							 { 
								verb: ["<xsl:value-of select="verb"/>"],
								content: ["<xsl:value-of select="securityUtils:encodeJavaScript(text)"/>"],
								text_size: [<xsl:value-of select="convertTools:splitOnNewLine(text)"/>]
							},
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="/el_tnx_record/narrative_special_recvbank/amendments/amendment/data/datum">
						<xsl:for-each select="/el_tnx_record/narrative_special_recvbank/amendments/amendment/data/datum">
							 { 
								verb: ["<xsl:value-of select="verb"/>"],
								content: ["<xsl:value-of select="securityUtils:encodeJavaScript(text)"/>"],
								text_size: [<xsl:value-of select="convertTools:splitOnNewLine(text)"/>]
							},
						</xsl:for-each>
					</xsl:if>
					<xsl:if test="/sr_tnx_record/narrative_special_recvbank/amendments/amendment/data/datum">
						<xsl:for-each select="/sr_tnx_record/narrative_special_recvbank/amendments/amendment/data/datum">
							 { 
								verb: ["<xsl:value-of select="verb"/>"],
								content: ["<xsl:value-of select="securityUtils:encodeJavaScript(text)"/>"],
								text_size: [<xsl:value-of select="convertTools:splitOnNewLine(text)"/>]
							},
						</xsl:for-each>
					</xsl:if>
					],		
    		});
    		</xsl:if>
		});
	</script>
  </xsl:template>

  <!--
   Shipment Details Fieldset, common to EC,IC (customer and bank side)
   -->
  <xsl:template name="ec-shipment-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_SHIPMENT_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_BOL_NUMBER</xsl:with-param>
      <xsl:with-param name="name">bol_number</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
      <xsl:with-param name="size">20</xsl:with-param>
      <xsl:with-param name="maxsize">20</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_SHIPPING_BY</xsl:with-param>
      <xsl:with-param name="name">shipping_by</xsl:with-param>
      <xsl:with-param name="maxsize">65</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_SHIP_FROM</xsl:with-param>
      <xsl:with-param name="name">ship_from</xsl:with-param>
      <xsl:with-param name="maxsize">65</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_SHIP_TO</xsl:with-param>
      <xsl:with-param name="name">ship_to</xsl:with-param>
      <xsl:with-param name="maxsize">65</xsl:with-param>
     </xsl:call-template>
      <xsl:choose>
		<xsl:when test= "$displaymode = 'edit'">
         <xsl:call-template name="select-field">
	 	<xsl:with-param name="label">XSL_INCO_TERM_YEAR</xsl:with-param>
		<xsl:with-param name="name">inco_term_year</xsl:with-param>	 
		 <xsl:with-param name="fieldsize">small</xsl:with-param>
		  <xsl:with-param name="required">N</xsl:with-param>	 
	</xsl:call-template>
	   </xsl:when>
		<xsl:otherwise>
			<xsl:variable name="inco_year"><xsl:value-of select="inco_term_year"/></xsl:variable>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_INCO_TERM_YEAR</xsl:with-param>
					<xsl:with-param name="name">inco_term_year_display</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="$inco_year"/></xsl:with-param>
				</xsl:call-template>
		</xsl:otherwise>
	 </xsl:choose>
	 <xsl:choose>
		<xsl:when test= "$displaymode = 'edit'">
	  <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_INCO_TERM</xsl:with-param>
      <xsl:with-param name="name">inco_term</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      </xsl:call-template>
       </xsl:when>
		<xsl:otherwise>
		<xsl:variable name="incoTerm"><xsl:value-of select="inco_term"/></xsl:variable>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_SHIPMENTDETAILS_INCO_TERM</xsl:with-param>
					<xsl:with-param name="name">inco_term_display</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*','*','N212',$incoTerm)"/></xsl:with-param>
				</xsl:call-template>
		</xsl:otherwise>
	 </xsl:choose>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_INCO_PLACE</xsl:with-param>
      <xsl:with-param name="name">inco_place</xsl:with-param>
      <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('SHIPMENT_NAMED_PLACE_LENGTH')"/></xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
 
  <!--
   EC,IC Collection Instructions
   
   Note: On the bank side, show-need is set to N usually. 
   -->
  <xsl:template name="ec-collection-instructions">
   <xsl:param name="show-need">Y</xsl:param>
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_COLLECTION_INSTRUCTIONS</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_COLLINST_PAYMT_ADV_SEND_MODE_LABEL</xsl:with-param>
      <xsl:with-param name="name">paymt_adv_send_mode</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="options">
       <xsl:call-template name="ec-send-options"/>
      </xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_COLLINST_ACCPT_ADV_SEND_MODE_LABEL</xsl:with-param>
      <xsl:with-param name="name">accpt_adv_send_mode</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="options">
       <xsl:call-template name="ec-send-options-adv"/>
      </xsl:with-param>
     </xsl:call-template>
     <!-- Charges borne by flags -->
      <xsl:choose>
	  <xsl:when test="$displaymode='edit'">
     <xsl:apply-templates select="open_chrg_brn_by_code">
      <xsl:with-param name="node-name">open_chrg_brn_by_code</xsl:with-param>
      <xsl:with-param name="label">XSL_CHRGDETAILS_OPEN_LABEL</xsl:with-param>
      <xsl:with-param name="applicant-label">XSL_CHRGDETAILS_DRAWER</xsl:with-param>
      <xsl:with-param name="beneficiary-label">XSL_CHRGDETAILS_DRAWEE</xsl:with-param>
      <xsl:with-param name="first-value">04</xsl:with-param>
      <xsl:with-param name="second-value">03</xsl:with-param>
     </xsl:apply-templates>
     <xsl:apply-templates select="corr_chrg_brn_by_code">
      <xsl:with-param name="node-name">corr_chrg_brn_by_code</xsl:with-param>
      <xsl:with-param name="label">XSL_CHRGDETAILS_CORR_LABEL</xsl:with-param>
      <xsl:with-param name="applicant-label">XSL_CHRGDETAILS_DRAWER</xsl:with-param>
      <xsl:with-param name="beneficiary-label">XSL_CHRGDETAILS_DRAWEE</xsl:with-param>
      <xsl:with-param name="first-value">04</xsl:with-param>
      <xsl:with-param name="second-value">03</xsl:with-param>
     </xsl:apply-templates>
     </xsl:when>
		     <xsl:otherwise>
		        <xsl:call-template name="input-field">
                     <xsl:with-param name="label">XSL_CHRGDETAILS_OPEN_LABEL</xsl:with-param>
                      <xsl:with-param name="node-name">open_chrg_brn_by_code</xsl:with-param>
                                     <xsl:with-param name="value">
                                   <xsl:choose>
                                                     <xsl:when test="open_chrg_brn_by_code[. = '04']">
                                                    <xsl:value-of select="localization:getGTPString($language,'XSL_CHRGDETAILS_DRAWER')"/>
                                             </xsl:when>
                              <xsl:when test="open_chrg_brn_by_code[. = '03']">
                                     <xsl:value-of select="localization:getGTPString($language,'XSL_CHRGDETAILS_DRAWEE')"/>
                                </xsl:when>

                              </xsl:choose>
                              </xsl:with-param>
                            </xsl:call-template>
		         <xsl:call-template name="input-field">
		          <xsl:with-param name="label">XSL_CHRGDETAILS_CORR_LABEL</xsl:with-param>
                         <xsl:with-param name="node-name">corr_chrg_brn_by_code</xsl:with-param>
                                  <xsl:with-param name="value">
                                                 <xsl:choose>
                                                                         <xsl:when test="corr_chrg_brn_by_code[. = '04']">
                                                                 <xsl:value-of select="localization:getGTPString($language,'XSL_CHRGDETAILS_DRAWER')"/>
                                                          </xsl:when>
                                  <xsl:when test="corr_chrg_brn_by_code[. = '03']">
                                                          <xsl:value-of select="localization:getGTPString($language,'XSL_CHRGDETAILS_DRAWEE')"/>
                          </xsl:when>

                  </xsl:choose>
          		</xsl:with-param>
              </xsl:call-template>
		     </xsl:otherwise>
		     </xsl:choose>
	 <xsl:choose>
	 	<xsl:when test="$displaymode='edit'">
	 	<xsl:call-template name="multichoice-field">
     	<xsl:with-param name="type">checkbox</xsl:with-param>
	  <xsl:with-param name="name">waive_chrg_flag</xsl:with-param>
	  <xsl:with-param name="label">XSL_CHRGDETAILS_WAIVE_FLAG</xsl:with-param>
	 </xsl:call-template>
	 <xsl:call-template name="multichoice-field">
     	<xsl:with-param name="type">checkbox</xsl:with-param>
	  <xsl:with-param name="name">protest_non_paymt</xsl:with-param>
	  <xsl:with-param name="label">XSL_COLLINST_PROTEST_PAYMT_FLAG</xsl:with-param>
	 </xsl:call-template>
	 		</xsl:when>
		<!-- EC changes starts -->
			<xsl:otherwise>
		 	
		 		<xsl:if test="waive_chrg_flag[. = 'Y']">
		 		<xsl:call-template name="row-wrapper">
		 		       <xsl:with-param name="override-label">&nbsp;</xsl:with-param>
					   <xsl:with-param name="content">
					         <div class="content"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_WAIVE_YES')"/>
					       
	           			 	</div>
				       </xsl:with-param>
	           </xsl:call-template>
			   </xsl:if>
			   
				<xsl:if test="waive_chrg_flag[. = 'N']">
				<xsl:call-template name="row-wrapper">
		 		       <xsl:with-param name="override-label">&nbsp;</xsl:with-param>
					   <xsl:with-param name="content">
					         <div class="content"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_WAIVE_NO')"/>
	            	 		</div>
	            	 </xsl:with-param>
	             </xsl:call-template>
				</xsl:if>
			
				  <xsl:if test="protest_non_paymt[. = 'Y']">
				 <xsl:call-template name="row-wrapper">
		 		       <xsl:with-param name="override-label">&nbsp;</xsl:with-param>
					   <xsl:with-param name="content">
					   <div class="content"><xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_PROTEST_PAYMT_YES')"/>
        				</div>
			        </xsl:with-param>
			        </xsl:call-template>  	
				   </xsl:if>
				   <xsl:if test="protest_non_paymt[. = 'N']">
				  <xsl:call-template name="row-wrapper">
					 		       <xsl:with-param name="override-label">&nbsp;</xsl:with-param>
								   <xsl:with-param name="content">
								    <div class="content"><xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_PROTEST_PAYMT_NO')"/>
			         				</div>
			         </xsl:with-param>
			         </xsl:call-template>
				   </xsl:if>
	   
		 </xsl:otherwise>
</xsl:choose>

	   <xsl:choose>
		<xsl:when test="$displaymode='edit'">
	 <xsl:call-template name="multichoice-field">
     	<xsl:with-param name="type">checkbox</xsl:with-param>
	  <xsl:with-param name="name">protest_non_accpt</xsl:with-param>
	  <xsl:with-param name="label">XSL_COLLINST_PROTEST_ACCPT_FLAG</xsl:with-param>
	 </xsl:call-template>
	 	</xsl:when>
	 	<xsl:otherwise>
	 		 <xsl:choose>
		 	  <xsl:when test="term_code[.='02'] and product_code[ .='EC']">
				<xsl:choose>
				<xsl:when test="protest_non_accpt[. = 'Y']">
				  <xsl:call-template name="row-wrapper">
		 		       <xsl:with-param name="override-label">&nbsp;</xsl:with-param>
					   <xsl:with-param name="content">
					         <div class="content"><xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_PROTEST_ACCPT_YES')"/>
             					</div>
             		</xsl:with-param>
             		</xsl:call-template>
				</xsl:when>
				<xsl:when test="protest_non_accpt[. = 'N']">
				   <xsl:call-template name="row-wrapper">
		 		       <xsl:with-param name="override-label">&nbsp;</xsl:with-param>
					   <xsl:with-param name="content">
					        <div class="content"><xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_PROTEST_ACCPT_NO')"/>
			         			</div>
			          </xsl:with-param>
			          </xsl:call-template>
				</xsl:when>
		<!--<xsl:otherwise/>-->
				</xsl:choose>
			</xsl:when>
			 <xsl:when test="product_code[ .='IC']">
                   <xsl:choose>
                   <xsl:when test="protest_non_accpt[. = 'Y']">
                     <xsl:call-template name="row-wrapper">
                          <xsl:with-param name="override-label">&nbsp;</xsl:with-param>
                           <xsl:with-param name="content">
                                 <div class="content"><xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_PROTEST_ACCPT_YES')"/>
                                  </div>
                   </xsl:with-param>
                   </xsl:call-template>
                   </xsl:when>
                   <xsl:when test="protest_non_accpt[. = 'N']">
                      <xsl:call-template name="row-wrapper">
                          <xsl:with-param name="override-label">&nbsp;</xsl:with-param>
                           <xsl:with-param name="content">
                                <div class="content"><xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_PROTEST_ACCPT_NO')"/>
                                 </div>
                        </xsl:with-param>
                        </xsl:call-template>
                   </xsl:when>
                  </xsl:choose>
              </xsl:when>
	 		<xsl:otherwise>
			 <xsl:call-template name="multichoice-field">
		     	<xsl:with-param name="type">checkbox</xsl:with-param>
			  <xsl:with-param name="name">protest_non_accpt</xsl:with-param>
			  <xsl:with-param name="label">XSL_COLLINST_PROTEST_ACCPT_FLAG</xsl:with-param>
			 </xsl:call-template>
			 </xsl:otherwise>
			</xsl:choose>
	 </xsl:otherwise>
	 </xsl:choose>
	 
     <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_COLLINST_PROTEST_ADV_SEND_MODE_LABEL</xsl:with-param>
      <xsl:with-param name="name">protest_adv_send_mode</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="options">
       <xsl:call-template name="ec-send-options-protest"/>
      </xsl:with-param>
     </xsl:call-template>
      <xsl:choose>
		<xsl:when test="$displaymode='edit'">
     <xsl:call-template name="multichoice-field">
     	<xsl:with-param name="type">checkbox</xsl:with-param>
      <xsl:with-param name="name">accpt_defd_flag</xsl:with-param>
      <xsl:with-param name="label">XSL_COLLINST_ACCPT_DEFD_FLAG</xsl:with-param>
     </xsl:call-template>
     	 </xsl:when>
        <xsl:otherwise>
              <xsl:choose>                   
              <xsl:when test="product_code[ .='IC']">
                   <xsl:choose>
                   <xsl:when test="accpt_defd_flag[. = 'Y']">
                     <xsl:call-template name="row-wrapper">
                          <xsl:with-param name="override-label">&nbsp;</xsl:with-param>
                           <xsl:with-param name="content">
                                 <div class="content"><xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_ACCPT_DEFD_YES')"/>
                                  </div>
                   </xsl:with-param>
                   </xsl:call-template>
                   </xsl:when>
                   <xsl:when test="accpt_defd_flag[. = 'N']">
                      <xsl:call-template name="row-wrapper">
                          <xsl:with-param name="override-label">&nbsp;</xsl:with-param>
                           <xsl:with-param name="content">
                                <div class="content"><xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_ACCPT_DEFD_NO')"/>
                                 </div>
                        </xsl:with-param>
                        </xsl:call-template>
                   </xsl:when>
                  </xsl:choose>
              </xsl:when>
           <xsl:when test="term_code[.='02'] and product_code[ .='EC']">
				<xsl:choose>
				  <xsl:when test="accpt_defd_flag[. = 'Y']">
                     <xsl:call-template name="row-wrapper">
                          <xsl:with-param name="override-label">&nbsp;</xsl:with-param>
                           <xsl:with-param name="content">
                                 <div class="content"><xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_ACCPT_DEFD_YES')"/>
                                  </div>
                   </xsl:with-param>
                   </xsl:call-template>
                   </xsl:when>
                   <xsl:when test="accpt_defd_flag[. = 'N']">
                      <xsl:call-template name="row-wrapper">
                          <xsl:with-param name="override-label">&nbsp;</xsl:with-param>
                           <xsl:with-param name="content">
                                <div class="content"><xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_ACCPT_DEFD_NO')"/>
                                 </div>
                        </xsl:with-param>
                        </xsl:call-template>
                   </xsl:when>
              </xsl:choose>
              </xsl:when>
              <xsl:otherwise>
              <xsl:call-template name="multichoice-field">
		     	<xsl:with-param name="type">checkbox</xsl:with-param>
			  	<xsl:with-param name="name">accpt_defd_flag</xsl:with-param>
      			<xsl:with-param name="label">XSL_COLLINST_ACCPT_DEFD_FLAG</xsl:with-param>
			 	</xsl:call-template>
              </xsl:otherwise>
              </xsl:choose>
     </xsl:otherwise>
    </xsl:choose>       
     
     <xsl:choose>
     <xsl:when test="$displaymode='edit'">
     <xsl:call-template name="multichoice-field">
     	<xsl:with-param name="type">checkbox</xsl:with-param>
      <xsl:with-param name="name">store_goods_flag</xsl:with-param>
      <xsl:with-param name="label">XSL_COLLINST_STORE_GOODS_FLAG</xsl:with-param>
     </xsl:call-template>
          </xsl:when>
	 <xsl:otherwise>
      
              <xsl:choose>
              <xsl:when test="store_goods_flag[. = 'Y']">
                <xsl:call-template name="row-wrapper">
                     <xsl:with-param name="override-label">&nbsp;</xsl:with-param>
                      <xsl:with-param name="content">
                            <div class="content"><xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_STORE_GOODS_YES')"/>
                             </div>
              </xsl:with-param>
              </xsl:call-template>
              </xsl:when>
              <xsl:when test="store_goods_flag[. = 'N']">
                 <xsl:call-template name="row-wrapper">
                     <xsl:with-param name="override-label">&nbsp;</xsl:with-param>
                      <xsl:with-param name="content">
                           <div class="content"><xsl:value-of select="localization:getGTPString($language, 'XSL_COLLINST_STORE_GOODS_NO')"/>
                            </div>
                   </xsl:with-param>
                   </xsl:call-template>
              </xsl:when>
     </xsl:choose>
	
    </xsl:otherwise>
    </xsl:choose>     
    <!-- EC changes ends -->
     <xsl:if test="$show-need='Y'">
      <xsl:if test="$displaymode='edit'">
      <xsl:call-template name="big-textarea-wrapper">
	        <xsl:with-param name="id">needs_refer_to</xsl:with-param>
	        <xsl:with-param name="label">XSL_COLLINST_NEEDS_REFER_TO</xsl:with-param>
	        <xsl:with-param name="type">textarea</xsl:with-param>
	        <xsl:with-param name="content">
	         <xsl:call-template name="textarea-field">
	          <xsl:with-param name="name">needs_refer_to</xsl:with-param>
	          <xsl:with-param name="rows">4</xsl:with-param>
	          <xsl:with-param name="cols">34</xsl:with-param>
	          <xsl:with-param name="maxlines">4</xsl:with-param>
	           <xsl:with-param name="messageValue"><xsl:value-of select="needs_refer_to"/></xsl:with-param>
	         </xsl:call-template>
	       </xsl:with-param>
	      </xsl:call-template>
      </xsl:if>	
      <xsl:if test="$displaymode='view' and needs_refer_to[.!='']">
	      <xsl:call-template name="big-textarea-wrapper">
	      <xsl:with-param name="label">XSL_COLLINST_NEEDS_REFER_TO</xsl:with-param>
	      <xsl:with-param name="content"><div class="content">
	        <xsl:value-of select="needs_refer_to"/>
	      </div></xsl:with-param>
	     </xsl:call-template>
     </xsl:if>
      <xsl:if test="($displaymode='view' and needs_refer_to!='')or $displaymode='edit'">
      
       <xsl:call-template name="multichoice-field">
      	<xsl:with-param name="type">radiobutton</xsl:with-param>
        <xsl:with-param name="label">XSL_COLLINST_NEEDS_INFORMATION_ONLY</xsl:with-param>
        <xsl:with-param name="name">needs_instr_by_code</xsl:with-param>
        <xsl:with-param name="id">needs_instr_by_code_1</xsl:with-param>
        <xsl:with-param name="value">Y</xsl:with-param>
        <xsl:with-param name="checked"><xsl:if test="needs_instr_by_code[. = 'Y'] or needs_instr_by_code[. = ''] or not(needs_instr_by_code)">Y</xsl:if></xsl:with-param>
       </xsl:call-template>
       <xsl:call-template name="multichoice-field">
      	<xsl:with-param name="type">radiobutton</xsl:with-param>
        <xsl:with-param name="label">XSL_COLLINST_NEEDS_ACCEPT_NO_RESERVE</xsl:with-param>
        <xsl:with-param name="name">needs_instr_by_code</xsl:with-param>
        <xsl:with-param name="id">needs_instr_by_code_2</xsl:with-param>
        <xsl:with-param name="value">N</xsl:with-param>
        <xsl:with-param name="checked"><xsl:if test="needs_instr_by_code[. = 'N']">Y</xsl:if></xsl:with-param>
       </xsl:call-template>
       
      </xsl:if>
     </xsl:if>
     <xsl:if test="$displaymode='edit'">
     <xsl:call-template name="big-textarea-wrapper">
	      <xsl:with-param name="id">narrative_additional_instructions</xsl:with-param>
	      <xsl:with-param name="label">XSL_COLLINST_OTHER_INSTRUCTIONS</xsl:with-param>
	      <xsl:with-param name="type">textarea</xsl:with-param>
	      <xsl:with-param name="content">
	       <xsl:call-template name="textarea-field">
	        <xsl:with-param name="name">narrative_additional_instructions</xsl:with-param>
	        <xsl:with-param name="rows">8</xsl:with-param>
	        <xsl:with-param name="cols">65</xsl:with-param>
	        <xsl:with-param name="maxlines">100</xsl:with-param>
	       </xsl:call-template>
	     </xsl:with-param>
	    </xsl:call-template>
    </xsl:if>
    <xsl:if test="$displaymode='view' and narrative_additional_instructions[.!='']">
	      <xsl:call-template name="big-textarea-wrapper">
	      <xsl:with-param name="label">XSL_COLLINST_OTHER_INSTRUCTIONS</xsl:with-param>
	      <xsl:with-param name="content"><div class="content">
	        <xsl:value-of select="narrative_additional_instructions"/>
	      </div></xsl:with-param>
	     </xsl:call-template>
     </xsl:if>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <!--
   Instructions for the Bank Fieldset.
   -->
 <xsl:template name="ec-bank-instructions">
 <xsl:param name="is-amendment">N</xsl:param>
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_INSTRUCTIONS</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:if test="ec_type_code[.='01']">
     <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_INSTRUCTIONS_DOCS_SEND_MODE_LABEL</xsl:with-param>
      <xsl:with-param name="name">docs_send_mode</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <!-- <xsl:with-param name="readonly">
      	<xsl:if test="$is-amendment = 'Y'">Y</xsl:if>
      </xsl:with-param> -->
      <xsl:with-param name="options">
       <xsl:choose>
	    <xsl:when test="$displaymode='edit'">
	     <option value=""/>
		 <option value="03">
 		  <xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_COURIER')"/>
		 </option>
	       <!-- option not available with TI -->
	       <!--option value="04">
	    		<xsl:if test="docs_send_mode[. = '04']">
	    			<xsl:attribute name="selected"/>
	    		</xsl:if>
	    		<xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_REGISTERED_POST')"/>
	       </option-->
	     </xsl:when>
	     <xsl:otherwise>
	       <xsl:choose>
	       	<xsl:when test="docs_send_mode[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_COURIER')"/></xsl:when>
	        <xsl:when test="docs_send_mode[. = '04']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_REGISTERED_POST')"/></xsl:when>
	       </xsl:choose>
	     </xsl:otherwise>
	    </xsl:choose>
      </xsl:with-param>
     </xsl:call-template>
    </xsl:if>
    <xsl:variable name="trade_account_source_static">
		<xsl:value-of select="defaultresource:getResource('TRADE_ACCOUNT_SOURCE_STATIC')"/>
	</xsl:variable>
	<xsl:choose>
     	<xsl:when test="$trade_account_source_static = 'true'">  
    <xsl:call-template name="principal-account-field">
     <xsl:with-param name="label">XSL_INSTRUCTIONS_PRINCIPAL_ACT_NO_LABEL</xsl:with-param>
     <xsl:with-param name="button-type">account</xsl:with-param>
     <xsl:with-param name="name">principal_act_no</xsl:with-param>
     <xsl:with-param name="size">34</xsl:with-param>
     <xsl:with-param name="maxsize">34</xsl:with-param>
     <xsl:with-param name="entity-field">entity</xsl:with-param>
    </xsl:call-template>
    </xsl:when>
    	<xsl:otherwise>
    		<xsl:call-template name="user-account-field">
					<xsl:with-param name="label">XSL_INSTRUCTIONS_PRINCIPAL_ACT_NO_LABEL</xsl:with-param>
					<xsl:with-param name="name">principal</xsl:with-param>
					<xsl:with-param name="entity-field">entity</xsl:with-param>
					<xsl:with-param name="dr-cr">debit</xsl:with-param>
					<xsl:with-param name="show-product-types">N</xsl:with-param>
					<xsl:with-param name="product_types"><xsl:value-of select="product_code"/></xsl:with-param>
        			<xsl:with-param name="product-types-required">Y</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
					<xsl:with-param name="trade_internal_account">Y</xsl:with-param>
			</xsl:call-template> 
    	</xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
     	<xsl:when test="$trade_account_source_static = 'true'">  
    <xsl:call-template name="principal-account-field">
     <xsl:with-param name="label">XSL_INSTRUCTIONS_FEE_ACT_NO_LABEL</xsl:with-param>
     <xsl:with-param name="button-type">account</xsl:with-param>
     <xsl:with-param name="name">fee_act_no</xsl:with-param>
     <xsl:with-param name="size">34</xsl:with-param>
     <xsl:with-param name="maxsize">34</xsl:with-param>
     <xsl:with-param name="entity-field">entity</xsl:with-param>
    </xsl:call-template>
       </xsl:when>
   		 	<xsl:otherwise>
   		 		<xsl:call-template name="user-account-field">
					<xsl:with-param name="label">XSL_INSTRUCTIONS_FEE_ACT_NO_LABEL</xsl:with-param>
					<xsl:with-param name="name">fee</xsl:with-param>
					<xsl:with-param name="entity-field">entity</xsl:with-param>
					<xsl:with-param name="dr-cr">debit</xsl:with-param>
					<xsl:with-param name="show-product-types">N</xsl:with-param>
					<xsl:with-param name="product_types"><xsl:value-of select="product_code"/></xsl:with-param>
        			<xsl:with-param name="product-types-required">Y</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
					<xsl:with-param name="trade_internal_account">Y</xsl:with-param>
				</xsl:call-template>
   		 	</xsl:otherwise>
   	</xsl:choose>
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_INSTRUCTIONS_FWD_CONTRACT_NO_LABEL</xsl:with-param>
     <xsl:with-param name="name">fwd_contract_no</xsl:with-param>
     <xsl:with-param name="size">35</xsl:with-param>
     <xsl:with-param name="maxsize">35</xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="big-textarea-wrapper">
     <xsl:with-param name="id">free_format_text</xsl:with-param>
	 <xsl:with-param name="label">
     	<xsl:choose>
    		<xsl:when test="($displaymode='view' and free_format_text/text != '') or $displaymode='edit'">XSL_INSTRUCTIONS_OTHER_INFORMATION</xsl:when>
    	</xsl:choose>
     </xsl:with-param>     
     <xsl:with-param name="type">textarea</xsl:with-param>
     <xsl:with-param name="content">
      <xsl:call-template name="textarea-field">
       <xsl:with-param name="name">free_format_text</xsl:with-param>
       <xsl:with-param name="swift-validate">N</xsl:with-param>
       <xsl:with-param name="rows">13</xsl:with-param>
       <xsl:with-param name="cols">65</xsl:with-param>
           <xsl:with-param name="maxlines">27</xsl:with-param>
      </xsl:call-template>
     </xsl:with-param>
    </xsl:call-template>
   </xsl:with-param>
  </xsl:call-template> 
 </xsl:template>
 
  <!-- 
   EC,IC send options.
   -->
  <xsl:template name="ec-send-options">

   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <option value=""/>
        <xsl:call-template name="code-data-options">
			 <xsl:with-param name="paramId">C063</xsl:with-param>
			 <xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>
			 <xsl:with-param name="specificOrder">Y</xsl:with-param>
		</xsl:call-template>
	</xsl:when>
    <xsl:otherwise>
     <xsl:choose>
      <xsl:when test="paymt_adv_send_mode[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_SWIFT')"/></xsl:when> 
      <xsl:when test="paymt_adv_send_mode[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_TELEX')"/></xsl:when>
      <xsl:when test="paymt_adv_send_mode[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_COURIER')"/></xsl:when>
     </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
  
  <!-- 
   EC Send Options (adv)
   -->
  <xsl:template name="ec-send-options-adv">
   
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
	<!-- <option value=""/> 
		EMPTY or BLANK option needs to be removed, if a business-field undergoes toggling at the client end. 
		Otherwise, issue like MPS-38477 may arise. -->
		<xsl:call-template name="code-data-options">
			<xsl:with-param name="paramId">C063</xsl:with-param>
			<xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>
			<xsl:with-param name="specificOrder">Y</xsl:with-param>
		</xsl:call-template>
     <!-- option not available with TI -->
     <!--option value="04">
       <xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_REGISTERED_POST')"/>
     </option-->
    </xsl:when>
    <xsl:otherwise>
     <xsl:choose>
      <xsl:when test="accpt_adv_send_mode[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_SWIFT')"/></xsl:when>
      <xsl:when test="accpt_adv_send_mode[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_TELEX')"/></xsl:when>
      <xsl:when test="accpt_adv_send_mode[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_COURIER')"/></xsl:when>
     </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
  
  <!--
   EC Send Options (protest) 
   -->
  <xsl:template name="ec-send-options-protest">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <option value=""/>
         <xsl:call-template name="code-data-options">
			 <xsl:with-param name="paramId">C063</xsl:with-param>
			  <xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>
			 <xsl:with-param name="specificOrder">Y</xsl:with-param>
			</xsl:call-template>
		 </xsl:when>
    <xsl:otherwise>
     <xsl:choose>
      <xsl:when test="protest_adv_send_mode[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_SWIFT')"/></xsl:when>
      <xsl:when test="protest_adv_send_mode[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_TELEX')"/></xsl:when>
      <xsl:when test="protest_adv_send_mode[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_COURIER')"/></xsl:when>
      <xsl:when test="protest_adv_send_mode[. = '99']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_OTHER')"/></xsl:when>
     </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
  
  <!--
   BG Guarantee Details 
   -->
  <xsl:template name="bg-guarantee-details">
  	 <xsl:param name="pdfOption"/>
  	 <xsl:param name="isBankReporting"/>
  	 <xsl:variable name="displayProvisionalCheckBox">
			<xsl:choose>
				<xsl:when test="$isBankReporting='Y'">N</xsl:when>
				<xsl:otherwise>Y</xsl:otherwise>
			</xsl:choose>
	</xsl:variable>
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_GTEE_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
    <xsl:if test="$displaymode='edit'">
	      <xsl:call-template name="select-field">
		      <xsl:with-param name="label">XSL_GTEEDETAILS_TYPE_LABEL</xsl:with-param>
		      <xsl:with-param name="name">bg_type_code</xsl:with-param>
		      <xsl:with-param name="required">Y</xsl:with-param>
		      <xsl:with-param name="readonly"><xsl:if test="bg_code[.!='']">Y</xsl:if></xsl:with-param>
		      <xsl:with-param name="value"><xsl:if test="bg_type_code[.!='']"><xsl:value-of select="bg_type_code"/></xsl:if></xsl:with-param>
		      <xsl:with-param name="options">
		       <xsl:call-template name="product_type_code_options"/>
		      </xsl:with-param>
	      </xsl:call-template>
      </xsl:if>
      <xsl:if test="$displaymode='view'">
      			<xsl:variable name="gtee_type_code"><xsl:value-of select="bg_type_code"></xsl:value-of></xsl:variable>
				<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
				<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
				<xsl:variable name="parameterId">C011</xsl:variable>
      		<xsl:call-template name="input-field">
		      <xsl:with-param name="label">XSL_GTEEDETAILS_TYPE_LABEL</xsl:with-param>
		      <xsl:with-param name="name">bg_type_code</xsl:with-param>
		      <xsl:with-param name="required">Y</xsl:with-param>
		      <xsl:with-param name="readonly"><xsl:if test="bg_code[.!='']">Y</xsl:if></xsl:with-param>
		      <xsl:with-param name="value"><xsl:if test="bg_type_code[.!='']"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $gtee_type_code)"/></xsl:if></xsl:with-param>
	      </xsl:call-template>
      </xsl:if>
     <xsl:if test="$displayProvisionalCheckBox='Y'">
	     <div id="pro-check-box">
	       <xsl:choose>
          	<xsl:when test="$displaymode='view'">
	         	 <xsl:choose>
	          		<xsl:when test="provisional_status = 'Y'">
	          			<xsl:call-template name="input-field">
	          				<xsl:with-param name="value" select="localization:getGTPString($language, 'XSL_PROVISIONAL')"/>
	          			</xsl:call-template>
	           		</xsl:when>
	         	</xsl:choose>
          	</xsl:when>
          	<xsl:otherwise>
          		<xsl:call-template name="checkbox-field">
		           <xsl:with-param name="label">XSL_PROVISIONAL</xsl:with-param>
		           <xsl:with-param name="name">provisional_status</xsl:with-param>
          		</xsl:call-template>
          	</xsl:otherwise>
          </xsl:choose>
		 </div>
	 </xsl:if>
     <div id="bgtypedetails-editor">
	     <xsl:call-template name="input-field">
	      <xsl:with-param name="id">bg_type_details</xsl:with-param>
	      <xsl:with-param name="name">bg_type_details</xsl:with-param>
	      <xsl:with-param name="maxsize">40</xsl:with-param>
	      <!-- <xsl:with-param name="required">Y</xsl:with-param> -->
	     </xsl:call-template>
     </div>
     <!-- <xsl:call-template name="input-field">
      <xsl:with-param name="name">bg_type_details</xsl:with-param>
      <xsl:with-param name="maxsize">255</xsl:with-param>
      <xsl:with-param name="readonly">Y</xsl:with-param>
     </xsl:call-template>-->
     <xsl:if test="bg_code[.!='']">
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GUARANTEE_NAME</xsl:with-param>
      <xsl:with-param name="name">bg_code</xsl:with-param>
      <xsl:with-param name="maxsize">40</xsl:with-param>
      <xsl:with-param name="readonly">Y</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
     </xsl:call-template>
     </xsl:if>

	<!-- BG Text type as hidden field -->
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">bg_text_details_code</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">guarantee_type_code</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">guarantee_type_company_id</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">guarantee_type_name</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="hidden-field">
		<xsl:with-param name="name">speciman</xsl:with-param>
	</xsl:call-template>
		<xsl:if test="bg_text_details_code = '01' and $isBankReporting!='Y'">
	     <xsl:choose>
	     <xsl:when test="speciman != ''" >
			<xsl:call-template name="row-wrapper">
				<xsl:with-param name="id">display_specimen</xsl:with-param>
				<xsl:with-param name="content">
			       (<a>
			         <xsl:attribute name="href">javascript:void(0)</xsl:attribute>
			         <xsl:attribute name="onclick">misys.downloadStaticDocument('document_id');</xsl:attribute>
			         <xsl:attribute name="title"><xsl:value-of select="localization:getGTPString($language, 'ACTION_DISPLAY_SPECIMEN')"/></xsl:attribute>
			         <xsl:value-of select="localization:getGTPString($language, 'ACTION_DISPLAY_SPECIMEN')"/>
			        </a>)
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">document_id</xsl:with-param>
					</xsl:call-template>
	        	</xsl:with-param>
	        </xsl:call-template>
	     </xsl:when>
	     <xsl:otherwise>
		     <xsl:if test="$displaymode='edit'" >
		     	<xsl:call-template name="row-wrapper">
			      <xsl:with-param name="id">GTEETextPreview</xsl:with-param>
			      <xsl:with-param name="label"></xsl:with-param>
			      <xsl:with-param name="content">
			       <a name="GTEETextPreview" href="javascript:void(0)" onclick="misys.generateGTEEFromNew();return false;">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_PREVIEW_LABEL')"/>
				   </a>
			      </xsl:with-param>
			     </xsl:call-template>
		     </xsl:if>
	     </xsl:otherwise>
	     </xsl:choose>
	     </xsl:if>
	     <xsl:if test="bg_text_details_code = '02' and $isBankReporting!='Y'">
	     	<xsl:call-template name="row-wrapper">
				<xsl:with-param name="id">display_specimen</xsl:with-param>
				<xsl:with-param name="content">
					<xsl:variable name="refId"><xsl:if test="$option != 'SCRATCH'"><xsl:value-of select="ref_id"/></xsl:if></xsl:variable>
					<xsl:variable name="tnxId"><xsl:if test="$option != 'SCRATCH'"><xsl:value-of select="tnx_id"/></xsl:if></xsl:variable>
								
			       (<a>
			         <xsl:attribute name="href">javascript:void(0)</xsl:attribute>
			         <xsl:attribute name="onclick">javascript:misys.popup.generateDocument('bg-document', '<xsl:value-of select="$pdfOption"/>', '<xsl:value-of select="$refId"/>', '<xsl:value-of select="$tnxId"/>', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="bg_code"/>','<xsl:value-of select="guarantee_type_company_id"/>');</xsl:attribute>
			         <xsl:attribute name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_TYPE_VIEW_EDITED_DOCUMENT')"/></xsl:attribute>
			         <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_TYPE_VIEW_EDITED_DOCUMENT')"/>
			        </a>)
	        	</xsl:with-param>
	        </xsl:call-template>
	     </xsl:if>
     
     <xsl:apply-templates select="character_commitment">
        <xsl:with-param name="node-name">character_commitment</xsl:with-param>
        <xsl:with-param name="label">XSL_GUARANTEE_CHARACTER_COMMITMENT_LABEL</xsl:with-param>
     </xsl:apply-templates>
     <xsl:if test="$displaymode='edit'">
	     <xsl:call-template name="select-field">
	      <xsl:with-param name="label">XSL_GTEEDETAILS_RULES_LABEL</xsl:with-param>
	      <xsl:with-param name="name">bg_rule</xsl:with-param>
	      <xsl:with-param name="options">
	       <xsl:call-template name="product_rule_options"/>
	      </xsl:with-param>
	     </xsl:call-template>
     </xsl:if>
      <xsl:if test="$displaymode='view'">
	    <xsl:variable name="bg_rule_code"><xsl:value-of select="bg_rule"></xsl:value-of></xsl:variable>
		<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
		<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
		<xsl:variable name="parameterId">C013</xsl:variable>
		<xsl:call-template name="input-field">
		 	<xsl:with-param name="label">XSL_GTEEDETAILS_RULES_LABEL</xsl:with-param>
		 	<xsl:with-param name="name">bg_rule</xsl:with-param>
		 	<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $bg_rule_code)"/></xsl:with-param>
		 	<xsl:with-param name="override-displaymode">view</xsl:with-param>	
		</xsl:call-template>
     </xsl:if> 
     <xsl:call-template name="input-field">
	   <xsl:with-param name="name">bg_rule_other</xsl:with-param>
	   <xsl:with-param name="maxsize">35</xsl:with-param>
	   <xsl:with-param name="readonly">Y</xsl:with-param>
	   <xsl:with-param name="required">Y</xsl:with-param>
	 </xsl:call-template>
          
	     <xsl:call-template name="select-field">
	      <xsl:with-param name="label">XSL_GTEEDETAILS_TEXT_TYPE_LABEL</xsl:with-param>
	      <xsl:with-param name="name">bg_text_type_code</xsl:with-param>
	      <xsl:with-param name="required">Y</xsl:with-param>
	      <xsl:with-param name="options">
	       <xsl:call-template name="bg-guarantee-text">
	       		<xsl:with-param name="pdfOption"><xsl:value-of select="$pdfOption"/></xsl:with-param>
	       </xsl:call-template>
	      </xsl:with-param>
	     </xsl:call-template>
	     <xsl:call-template name="input-field">
	      <xsl:with-param name="name">bg_text_type_details</xsl:with-param>
	      <xsl:with-param name="maxsize">255</xsl:with-param>
	      <xsl:with-param name="required">Y</xsl:with-param>
	     </xsl:call-template>
	     <!-- <div id="document-editor" style="display:none;"><br/>
	      <xsl:call-template name="richtextarea-field">
	       <xsl:with-param name="label">XSL_REPORT_BG</xsl:with-param>
	       <xsl:with-param name="name">bg_document</xsl:with-param>
	       <xsl:with-param name="rows">13</xsl:with-param>
	       <xsl:with-param name="cols">40</xsl:with-param>
	       <xsl:with-param name="instantiation-event">/document-editor/display</xsl:with-param>	
	      </xsl:call-template>
	     </div> -->
	     <xsl:call-template name="select-field">
	      <xsl:with-param name="label">XSL_GTEEDETAILS_TEXT_LANGUAGE</xsl:with-param>
	      <xsl:with-param name="name">text_language</xsl:with-param>
	      <xsl:with-param name="options">
	       <xsl:call-template name="bg-text-languages"/>
	      </xsl:with-param>
	     </xsl:call-template>
	     <xsl:call-template name="input-field">
	      <xsl:with-param name="name">text_language_other</xsl:with-param>
	      <xsl:with-param name="maxsize">35</xsl:with-param>
	      <xsl:with-param name="readonly">Y</xsl:with-param>
	      <xsl:with-param name="required">Y</xsl:with-param>
	     </xsl:call-template>
     <!-- </xsl:if> -->
     <xsl:choose>
	     <xsl:when test="$displaymode='edit'">
		     <xsl:call-template name="row-wrapper">
		      <xsl:with-param name="id">narrative_additional_instructions</xsl:with-param>
		      <xsl:with-param name="label">XSL_GTEEDETAILS_OTHER_INSTRUCTIONS</xsl:with-param>
		      <xsl:with-param name="type">textarea</xsl:with-param>
		      <xsl:with-param name="content">
		       <xsl:call-template name="textarea-field">
		        <xsl:with-param name="name">narrative_additional_instructions</xsl:with-param>
		        <xsl:with-param name="rows">13</xsl:with-param>
		        <xsl:with-param name="cols">40</xsl:with-param>
		       </xsl:call-template>
		      </xsl:with-param>
		     </xsl:call-template>
	     </xsl:when>
	     <xsl:when test="$displaymode='view' and narrative_additional_instructions[.!='']">
	     	<xsl:call-template name="big-textarea-wrapper">
		      <xsl:with-param name="label">XSL_GTEEDETAILS_OTHER_INSTRUCTIONS</xsl:with-param>
		      <xsl:with-param name="content"><div class="content">
		        <xsl:value-of select="narrative_additional_instructions"/>
		      </div></xsl:with-param>
		     </xsl:call-template>
	     </xsl:when>
     </xsl:choose>
     <xsl:if test="$displaymode='view'">
	     <xsl:call-template name="hidden-field">
		    <xsl:with-param name="name">bg_text_type_code</xsl:with-param>
		    <xsl:with-param name="value"><xsl:value-of select="bg_text_type_code"/></xsl:with-param>
		 </xsl:call-template>
	 </xsl:if>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <!-- This template provides the contract details for Bankers Guarantee -->
	<xd:doc>
		<xd:short>Banker Guarantee contact details.</xd:short>
		<xd:detail>
			This template used to render BG contact details.
		</xd:detail>
	</xd:doc>
  <xsl:template name="bg-contract-details">
  
    <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_CONTRACT_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
    <xsl:choose>
      <xsl:when test="$displaymode='edit'">
	  	  <xsl:call-template name="select-field">
		      <xsl:with-param name="label">XSL_GTEEDETAILS_CONTRACT_REF_LABEL</xsl:with-param>
		      <xsl:with-param name="name">contract_ref</xsl:with-param>
		      <xsl:with-param name="options">
			       <xsl:call-template name="guarantee-references-options"/>
			  </xsl:with-param>
	      </xsl:call-template>
      </xsl:when>
      <xsl:when test="$displaymode='view'">
      	<xsl:variable name="contract_ref_code"><xsl:value-of select="contract_ref"></xsl:value-of></xsl:variable>
      	<xsl:variable name="parameterId">C051</xsl:variable>
      	<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
     	<xsl:call-template name="input-field">
	      	<xsl:with-param name="label">XSL_GTEEDETAILS_CONTRACT_REF_LABEL</xsl:with-param>
	     	<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $contract_ref_code)"></xsl:value-of></xsl:with-param>
	    </xsl:call-template>
      </xsl:when>
    </xsl:choose>
    
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_CONTRACT_NARRATIVE</xsl:with-param>
     <xsl:with-param name="name">contract_narrative</xsl:with-param>
     <xsl:with-param name="size">35</xsl:with-param>
     <xsl:with-param name="maxsize">35</xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="contract_narrative"/></xsl:with-param>     
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GTEEDETAILS_CONTRACT_DATE_LABEL</xsl:with-param>
      <xsl:with-param name="name">contract_date</xsl:with-param>
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
      <xsl:with-param name="type">date</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="contract_date"/></xsl:with-param>     
     </xsl:call-template>
     
     <div id="tender-exp-date">
		    <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_TENDER_EXP_DATE_LABEL</xsl:with-param>
      <xsl:with-param name="name">tender_expiry_date</xsl:with-param>
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
      <xsl:with-param name="type">date</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="tender_expiry_date"/></xsl:with-param>     
     </xsl:call-template>
		 </div>
		 
     <xsl:if test="$displaymode='edit' or ($displaymode='view' and contract_amt != '')">
     <xsl:call-template name="currency-field">
      <xsl:with-param name="label">XSL_GTEEDETAILS_CONTRACT_AMT_LABEL</xsl:with-param>
      <xsl:with-param name="override-currency-name">contract_cur_code</xsl:with-param>
      <xsl:with-param name="override-amt-name">contract_amt</xsl:with-param>
      <xsl:with-param name="product-code">contract</xsl:with-param>
     </xsl:call-template>
     </xsl:if>
     <xsl:choose>
	     <xsl:when test="$displaymode='edit'">
	     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GTEEDETAILS_CONTRACT_PCT_LABEL</xsl:with-param>
      <xsl:with-param name="name">contract_pct</xsl:with-param>
      <xsl:with-param name="type">number</xsl:with-param>
      <xsl:with-param name="size">13</xsl:with-param>
      <xsl:with-param name="maxsize">13</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="contract_pct"/></xsl:with-param>     
     </xsl:call-template>
         </xsl:when>
    <xsl:otherwise>
    	<xsl:if test="contract_pct != ''">
      <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_GTEEDETAILS_CONTRACT_PCT_LABEL</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="contract_pct"/>&nbsp;
           </div></xsl:with-param>
          </xsl:call-template>
          </xsl:if>
    </xsl:otherwise>
    </xsl:choose>
     </xsl:with-param>
     </xsl:call-template>
  </xsl:template>
   
  <!--
  BG Bank Details Types 
  -->
  <xsl:template name="bg-bankdetails-types">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <option value="01">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TYPE_DIRECT')"/>
     </option>
     <option value="02">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TYPE_INDIRECT')"/>
     </option>
    </xsl:when>
    <xsl:otherwise>
     <xsl:choose>
      <xsl:when test="contains(issuing_bank_type_code,'01')"><xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TYPE_DIRECT')"/></xsl:when>
      <xsl:when test="contains(issuing_bank_type_code,'02')"><xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TYPE_INDIRECT')"/></xsl:when>
     </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
 
   <!--
   BR Guarantee Details 
   -->
  <xsl:template name="br-guarantee-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_GTEE_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:if test="$displaymode='edit'">
     <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_GTEEDETAILS_TYPE_LABEL</xsl:with-param>
      <xsl:with-param name="name">bg_type_code</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
      <!-- Mandatory field for BR -->
      <xsl:with-param name="disabled"><xsl:if test="bg_code[.!='']">Y</xsl:if></xsl:with-param>
      <xsl:with-param name="value"><xsl:if test="bg_type_code[.!='']"><xsl:value-of select="bg_type_code"/></xsl:if></xsl:with-param>
      <xsl:with-param name="options">
       <xsl:call-template name="product_type_code_options"/>
      </xsl:with-param>
     </xsl:call-template>
  	</xsl:if>
  	
  	<xsl:if test="$displaymode='view'">
         <xsl:variable name="gtee_type_code"><xsl:value-of select="bg_type_code"></xsl:value-of></xsl:variable>
         <xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
         <xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
         <xsl:variable name="parameterId">C011</xsl:variable>
         <xsl:call-template name="input-field">
           <xsl:with-param name="label">XSL_GTEEDETAILS_TYPE_LABEL</xsl:with-param>
           <xsl:with-param name="name">bg_type_code</xsl:with-param>
           <xsl:with-param name="required">Y</xsl:with-param>
           <xsl:with-param name="disabled"><xsl:if test="bg_code[.!='']">Y</xsl:if></xsl:with-param>
           <xsl:with-param name="value"><xsl:if test="bg_type_code[.!='']"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $gtee_type_code)"/></xsl:if></xsl:with-param>
        </xsl:call-template>
	</xsl:if>

	 <xsl:if test="$displaymode='edit'">
	     <xsl:call-template name="select-field">
	      <xsl:with-param name="label">XSL_GTEEDETAILS_RULES_LABEL</xsl:with-param>
	      <xsl:with-param name="name">bg_rule</xsl:with-param>
	      <xsl:with-param name="options">
	       <xsl:call-template name="product_rule_options"/>
	      </xsl:with-param>
	     </xsl:call-template>
	 </xsl:if>
 
	<xsl:if test="$displaymode='view'">
         <xsl:variable name="bg_rule_code"><xsl:value-of select="bg_rule"></xsl:value-of></xsl:variable>
         <xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
         <xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
         <xsl:variable name="parameterId">C013</xsl:variable>
         <xsl:call-template name="input-field">
            <xsl:with-param name="label">XSL_GTEEDETAILS_RULES_LABEL</xsl:with-param>
            <xsl:with-param name="name">bg_rule</xsl:with-param>
            <xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $bg_rule_code)"/></xsl:with-param>
            <xsl:with-param name="override-displaymode">view</xsl:with-param>
         </xsl:call-template>
    </xsl:if>
     <xsl:if test="$displaymode='edit'">
     <xsl:call-template name="row-wrapper">
      <xsl:with-param name="id">narrative_additional_instructions</xsl:with-param>
      <xsl:with-param name="label">XSL_GTEEDETAILS_OTHER_INSTRUCTIONS</xsl:with-param>
      <xsl:with-param name="type">textarea</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:call-template name="textarea-field">
        <xsl:with-param name="name">narrative_additional_instructions</xsl:with-param>
        <xsl:with-param name="rows">13</xsl:with-param>
        <xsl:with-param name="cols">40</xsl:with-param>
       </xsl:call-template>
      </xsl:with-param>
     </xsl:call-template>
     </xsl:if>
     <xsl:if test="$displaymode='view' and narrative_additional_instructions[.!='']">
      <xsl:call-template name="big-textarea-wrapper">
      <xsl:with-param name="label">XSL_GTEEDETAILS_OTHER_INSTRUCTIONS</xsl:with-param>
      <xsl:with-param name="content"><div class="content">
        <xsl:value-of select="narrative_additional_instructions"/>
      </div></xsl:with-param>
     </xsl:call-template>
     </xsl:if>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
   
   <!-- This template provides the contract details for Guarantee Recieved -->
   <xd:doc>
		<xd:short> Guarantee Recieved contact details.</xd:short>
		<xd:detail>
			This template used to render BR contact details.
		</xd:detail>
	</xd:doc>
   <xsl:template name="br-contract-details">
    <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_CONTRACT_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
      <xsl:choose>
      	<xsl:when test="$displaymode='edit'">
	  	   	<xsl:call-template name="select-field">
	      	<xsl:with-param name="label">XSL_GTEEDETAILS_CONTRACT_REF_LABEL</xsl:with-param>
	      	<xsl:with-param name="name">contract_ref</xsl:with-param>
	      	<xsl:with-param name="options">
		       	<xsl:call-template name="guarantee-references-options"/>
		  	</xsl:with-param>
	      	</xsl:call-template>
      	</xsl:when>
      	<xsl:when test="$displaymode='view'">
	      	<xsl:variable name="contract_ref_code"><xsl:value-of select="contract_ref"></xsl:value-of></xsl:variable>
	      	<xsl:variable name="parameterId">C051</xsl:variable>
	     	<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
	     	<xsl:call-template name="input-field">
		      	<xsl:with-param name="label">XSL_GTEEDETAILS_CONTRACT_REF_LABEL</xsl:with-param>
		      	<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $contract_ref_code)"></xsl:value-of></xsl:with-param>
		    </xsl:call-template>
      	</xsl:when>
      </xsl:choose>
     <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_CONTRACT_NARRATIVE</xsl:with-param>
     <xsl:with-param name="name">contract_narrative</xsl:with-param>
     <xsl:with-param name="size">35</xsl:with-param>
     <xsl:with-param name="maxsize">35</xsl:with-param>
     
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GTEEDETAILS_CONTRACT_DATE_LABEL</xsl:with-param>
      <xsl:with-param name="name">contract_date</xsl:with-param>
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
      <xsl:with-param name="type">date</xsl:with-param>
     </xsl:call-template>
     
     <div id="tender-exp-date">
     <xsl:if test="contract_ref[.='TEND'] or $displaymode='edit'">
		    <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_TENDER_EXP_DATE_LABEL</xsl:with-param>
      <xsl:with-param name="name">tender_expiry_date</xsl:with-param>
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
      <xsl:with-param name="type">date</xsl:with-param>
     </xsl:call-template>
     </xsl:if>
		 </div>
		 
     <xsl:if test="$displaymode='edit' or ($displaymode='view' and contract_amt != '')">
     <xsl:call-template name="currency-field">
      <xsl:with-param name="label">XSL_GTEEDETAILS_CONTRACT_AMT_LABEL</xsl:with-param>
      <xsl:with-param name="override-currency-name">contract_cur_code</xsl:with-param>
      <xsl:with-param name="override-amt-name">contract_amt</xsl:with-param>
      <xsl:with-param name="product-code">contract</xsl:with-param>
     </xsl:call-template>
     </xsl:if>
     <xsl:choose>
	     <xsl:when test="$displaymode='edit'">
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GTEEDETAILS_CONTRACT_PCT_LABEL</xsl:with-param>
      <xsl:with-param name="name">contract_pct</xsl:with-param>
      <xsl:with-param name="type">number</xsl:with-param>
      <xsl:with-param name="size">13</xsl:with-param>
      <xsl:with-param name="maxsize">13</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
     </xsl:call-template>
          </xsl:when>
      <xsl:otherwise>
      <xsl:if test="contract_pct != ''">
      <xsl:call-template name="row-wrapper">
           <xsl:with-param name="label">XSL_GTEEDETAILS_CONTRACT_PCT_LABEL</xsl:with-param>
           <xsl:with-param name="content"><div class="content">
             <xsl:value-of select="contract_pct"/>&nbsp;%
           </div></xsl:with-param>
          </xsl:call-template>
          </xsl:if>
    </xsl:otherwise>
     </xsl:choose>
       <!-- 20170817 end -->
     
     </xsl:with-param>
     </xsl:call-template>
   </xsl:template>
  <!--
    BG Type Codes. 
  -->
  <!-- <xsl:template name="bg-type-codes">
  <xsl:param name="is-bank-template">N</xsl:param>
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <xsl:if test="$is-bank-template = 'Y'">
	   <option value="99">
	    <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_ANY')"/>
	   </option>
     </xsl:if>
     <option value="01">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_BIDBOND')"/>
     </option>
     <option value="02">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_PERFORMANCEBOND')"/>
     </option>
     <option value="03">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_PAYMTBOND')"/>
     </option>
     <option value="04">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_ADVPAYMTBOND')"/>
     </option>
     <option value="05">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_GTEEDEPOSIT')"/>
     </option>
     <option value="06">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_TEMPADMISSIONPERM')"/>
     </option>
     <option value="07">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_STANDBY')"/>
     </option>
     <option value="08">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_REPAYMENT')"/>
     </option>
     <option value="09">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_RETENTION')"/>
     </option>
     <xsl:if test="$is-bank-template = 'N'">
      <option value="99">
       <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_OTHER')"/>
      </option>
      </xsl:if>
    </xsl:when>
    <xsl:otherwise>
     <xsl:choose>
      <xsl:when test="bg_type_code[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_BIDBOND')"/></xsl:when>
      <xsl:when test="bg_type_code[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_PERFORMANCEBOND')"/></xsl:when>
      <xsl:when test="bg_type_code[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_PAYMTBOND')"/></xsl:when>
      <xsl:when test="bg_type_code[. = '04']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_ADVPAYMTBOND')"/></xsl:when>
      <xsl:when test="bg_type_code[. = '05']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_GTEEDEPOSIT')"/></xsl:when>
      <xsl:when test="bg_type_code[. = '06']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_TEMPADMISSIONPERM')"/></xsl:when>
      <xsl:when test="bg_type_code[. = '07']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_STANDBY')"/></xsl:when>
      <xsl:when test="bg_type_code[. = '08']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_REPAYMENT')"/></xsl:when>
      <xsl:when test="bg_type_code[. = '09']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_RETENTION')"/></xsl:when>
      <xsl:when test="bg_type_code[. = '99']">
      	<xsl:choose>
         <xsl:when test="$is-bank-template = 'Y'">
      	  <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_ANY')"/>
      	 </xsl:when>
      	 <xsl:otherwise>
      	  <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_OTHER')"/>
      	 </xsl:otherwise>
      	</xsl:choose>
      </xsl:when>
     </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template> -->
   
  <!--
   BG Rules 
  -->
   <xsl:template name="bg-rules">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <option value=""/>
     <option value="URDG_758">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_RULES_URDG758')"/>
     </option>
     <option value="UCP_600">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_RULES_UCP600')"/>
     </option>
     <option value="ISP_98">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_RULES_ISP98')"/>
     </option>
     <option value="*">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_RULES_OTHER')"/>
     </option>
    </xsl:when>
    <xsl:otherwise>
     <xsl:choose>
      <xsl:when test="bg_rule[. = 'URDG_758']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_RULES_URDG758')"/></xsl:when>
      <xsl:when test="bg_rule[. = 'UCP_600']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_RULES_UCP600')"/></xsl:when>
      <xsl:when test="bg_rule[. = 'ISP_98']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_RULES_ISP98')"/></xsl:when>
      <xsl:when test="bg_rule[. = '*']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_RULES_OTHER')"/></xsl:when>
     </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template> 
   
   <!--
    BG Text Reference 
    -->
  <xsl:template name="bg-guarantee-text">
  	<xsl:param name="pdfOption"/>
  	
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <option value="01">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_TYPE_BANK_STANDARD')"/>
     </option>
     <option value="02">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_TYPE_WORDING_ATTACHED')"/>
     </option>
     <option value="03">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_TYPE_SAME_AS_SPECIFY')"/>
     </option>
     <option value="04">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_TYPE_BENEFICIARY_ATTACHED')"/>
     </option>
    </xsl:when>
    <xsl:otherwise>
     <xsl:choose>
      <xsl:when test="bg_text_type_code = '01'"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_TYPE_BANK_STANDARD')"/></xsl:when>
      <xsl:when test="bg_text_type_code = '02'"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_TYPE_WORDING_ATTACHED')"/></xsl:when>
      <xsl:when test="bg_text_type_code = '03'"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_TYPE_SAME_AS_SPECIFY')"/></xsl:when>
      <xsl:when test="bg_text_type_code = '04'"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_TYPE_BENEFICIARY_ATTACHED')"/></xsl:when>
      <!-- Propose the PDF anchor when the guarantee text has been created through the WYSIWYG editor either on the bank or on the customer side -->
      <!-- <xsl:when test="bg_text_type_code = '04' or bg_text_details_code='03'">
      	<xsl:call-template name="row-wrapper">
      		<xsl:with-param name="display_specimen"></xsl:with-param>
      		<xsl:with-param name="content">
		       (<a>
		         <xsl:attribute name="href">javascript:void(0)</xsl:attribute>
		         <xsl:attribute name="onclick">javascript:misys.popup.generateDocument('bg-document', '<xsl:value-of select="$pdfOption"/>',  '<xsl:value-of select="ref_id"/>', '<xsl:value-of select="tnx_id"/>', '<xsl:value-of select="product_code"/>','<xsl:value-of select="company_id"/>');</xsl:attribute>
		         <xsl:attribute name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_TYPE_VIEW_EDITED_DOCUMENT')"/></xsl:attribute>
		         <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_TYPE_VIEW_EDITED_DOCUMENT')"/>
		        </a>)
        	</xsl:with-param>
        </xsl:call-template>
      </xsl:when> -->
     </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
  
  <!--
   BG Languages
   -->
  <xsl:template name="bg-text-languages">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <option value=""/>
     <option value="fr">
      <xsl:value-of select="localization:getDecode($language, 'N061', 'fr')"/>
     </option>
     <option value="en">
      <xsl:value-of select="localization:getDecode($language, 'N061', 'en')"/>
     </option>
     <option value="es">
      <xsl:value-of select="localization:getDecode($language, 'N061', 'es')"/>
     </option>
     <option value="*">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_LANGUAGE_OTHER')"/>
     </option>
    </xsl:when>
    <xsl:otherwise>
     <xsl:choose>
      <xsl:when test="text_language[. = 'fr']"><xsl:value-of select="localization:getDecode($language, 'N061', 'fr')"/></xsl:when>
      <xsl:when test="text_language[. = 'en']"><xsl:value-of select="localization:getDecode($language, 'N061', 'en')"/></xsl:when>
      <xsl:when test="text_language[. = 'es']"><xsl:value-of select="localization:getDecode($language, 'N061', 'es')"/></xsl:when>
      <xsl:when test="text_language[. = '*']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_LANGUAGE_OTHER')"/></xsl:when>
     </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
  
  <!--
   BG Exp Dates.
    
   Common to BG From Scratch and BG Amend. 
  -->
  <xsl:template name="bg-exp-dates">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
    <option value="01">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_NONE')"/>
     </option>
     <option value="02">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_FIXED')"/>
     </option>
     <option value="03">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_PROJECTED')"/>
     </option>
    </xsl:when>
    <xsl:otherwise>
     <xsl:choose>
      <xsl:when test="exp_date_type_code[.='01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_NONE')"/></xsl:when>
      <xsl:when test="exp_date_type_code[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_FIXED')"/></xsl:when>
      <xsl:when test="exp_date_type_code[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_PROJECTED')"/></xsl:when>
     </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
  
  <!--  BG Reduction Clause -->
  <xsl:template name="bg-reduction-clause">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <option value="01">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REDUCTION_PER_DELIVERIES')"/>
     </option>
     <option value="02">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REDUCTION_UPON_REALISATION')"/>
     </option>
     <option value="03">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REDUCTION_OTHER')"/>
     </option>
    </xsl:when>
    <xsl:otherwise>
     <xsl:choose>
      <xsl:when test="reduction_clause[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REDUCTION_PER_DELIVERIES')"/></xsl:when>
      <xsl:when test="reduction_clause[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REDUCTION_UPON_REALISATION')"/></xsl:when>
      <xsl:when test="reduction_clause[. = '03']"><xsl:value-of select="reduction_clause_other"/></xsl:when>
     </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
  
  <!--  BG Delivery To -->
  <xsl:template name="bg-delivery-to">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <option value="01">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_DELIVERY_TO_OURSELVES')"/>
     </option>
     <option value="02">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_DELIVERY_TO_PARTY')"/>
     </option>
     <option value="03">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_DELIVERY_TO_BENEFICIARY')"/>
     </option>
     <option value="04">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_DELIVERY_TO_OTHER')"/>
     </option>
    </xsl:when>
    <xsl:otherwise>
     <xsl:choose>
      <xsl:when test="delivery_to[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_DELIVERY_TO_OURSELVES')"/></xsl:when>
      <xsl:when test="delivery_to[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_DELIVERY_TO_PARTY')"/></xsl:when>
      <xsl:when test="delivery_to[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_DELIVERY_TO_BENEFICIARY')"/></xsl:when>
      <xsl:when test="delivery_to[. = '04']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_DELIVERY_TO_OTHER')"/>
      	<!-- <xsl:call-template name="row-wrapper">
      	<xsl:with-param name="id">delivery_to_other</xsl:with-param>
	      <xsl:with-param name="type">textarea</xsl:with-param>
	      <xsl:with-param name="content">
	       <xsl:call-template name="textarea-field">
	        <xsl:with-param name="name">delivery_to_other</xsl:with-param>
	       </xsl:call-template>
	      </xsl:with-param>
	   </xsl:call-template> -->
      </xsl:when>
     </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>

   <!-- 
   	BG Alternative Applicant Details
   -->
  <xsl:template name="bg-alternative-applicant-details">
   <div id="chkBoxAlignPopup">
         <xsl:choose>
          	<xsl:when test="$displaymode='view'">
	         	 <xsl:choose>
	          		<xsl:when test="for_account = 'Y'">
	          			<xsl:call-template name="input-field">
	          				<xsl:with-param name="value" select="localization:getGTPString($language, 'XSL_FOR_THE_ACCOUNT_OF')"/>
	          			</xsl:call-template>
	           		</xsl:when>
	         	</xsl:choose>
          	</xsl:when>
          	<xsl:otherwise>
          		<xsl:call-template name="checkbox-field">
		           <xsl:with-param name="label">XSL_FOR_THE_ACCOUNT_OF</xsl:with-param>
		           <xsl:with-param name="name">for_account</xsl:with-param>
          		</xsl:call-template>
          	</xsl:otherwise>
          </xsl:choose>
   </div>
   <!-- Alternative Applicant Details -->
    <xsl:call-template name="fieldset-wrapper">
      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:call-template name="address">
        <xsl:with-param name="name-label">XSL_PARTIESDETAILS_ALT_APPLICANT_NAME</xsl:with-param>
        <xsl:with-param name="address-label">XSL_PARTIESDETAILS_ALT_APPLICANT_ADDRESS</xsl:with-param>
        <xsl:with-param name="country-label">XSL_PARTIESDETAILS_ALT_APPLICANT_COUNTRY</xsl:with-param>
        <xsl:with-param name="show-country">Y</xsl:with-param>
        <xsl:with-param name="prefix">alt_applicant</xsl:with-param>
       </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
   
  <!--
   SG Guarantee Details (Bank and Customer side)
  -->
  <xsl:template name="sg-guarantee-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_GTEE_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_BOL_NUMBER</xsl:with-param>
      <xsl:with-param name="name">bol_number</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
      <xsl:with-param name="size">20</xsl:with-param>
      <xsl:with-param name="maxsize">35</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_SHIPPING_MODE</xsl:with-param>
      <xsl:with-param name="name">shipping_mode</xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
      <xsl:with-param name="options">
       <xsl:call-template name="sg-shipping-modes"/>
      </xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_SHIPMENTDETAILS_SHIPPING_BY</xsl:with-param>
      <xsl:with-param name="name">shipping_by</xsl:with-param>
      <xsl:with-param name="size">20</xsl:with-param>
      <xsl:with-param name="maxsize">65</xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
   
  <!-- 
   SG Shipping Modes 
  -->
  <xsl:template name="sg-shipping-modes">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <option value="01">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_01_SEA')"/>
     </option>
     <option value="02">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_02_AIR')"/>
     </option>
     <option value="03">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_03_RAIL')"/>
     </option>
     <option value="04">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_04_TRUCK')"/>
     </option>
     <option value="05">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_05_POSTAGE')"/>
     </option>
     <option value="06">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_06_MIXED')"/>
     </option>
     <option value="07">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_07_COURIER')"/>
     </option>
     <option value="08">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_08_LOCAL_DELIVERY')"/>
     </option>
     <option value="99">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_99_OTHER')"/>
     </option>
    </xsl:when>
    <xsl:otherwise>
     <xsl:choose>
      <xsl:when test="shipping_mode[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_01_SEA')"/></xsl:when>
      <xsl:when test="shipping_mode[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_02_AIR')"/></xsl:when>
      <xsl:when test="shipping_mode[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_03_RAIL')"/></xsl:when>
      <xsl:when test="shipping_mode[. = '04']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_04_TRUCK')"/></xsl:when>
      <xsl:when test="shipping_mode[. = '05']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_05_POSTAGE')"/></xsl:when>
      <xsl:when test="shipping_mode[. = '06']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_06_MIXED')"/></xsl:when>
      <xsl:when test="shipping_mode[. = '07']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_07_COURIER')"/></xsl:when>
      <xsl:when test="shipping_mode[. = '08']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_08_LOCAL_DELIVERY')"/></xsl:when>
      <xsl:when test="shipping_mode[. = '99']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPPINGMODE_99_OTHER')"/></xsl:when>
     </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
   
   <!--
    TF Financing Types (Bank and Customer TF forms)
    -->
   <xsl:template name="tf-financing-types">
    <xsl:choose>
     <xsl:when test="$displaymode='edit'">
      <option value='01'>
       <xsl:value-of select="localization:getGTPString($language, 'XSL_FINANCINGTYPE_01_TRUST_RECEIPT')"/>
      </option>
      <option value='02'>
       <xsl:value-of select="localization:getGTPString($language, 'XSL_FINANCINGTYPE_02_IMPORT_LOAN_LC')"/>
      </option>
      <option value='03'>
       <xsl:value-of select="localization:getGTPString($language, 'XSL_FINANCINGTYPE_03_IMPORT_LOAN_COLLECTION')"/>
      </option>
      <option value='20'>
       <xsl:value-of select="localization:getGTPString($language, 'XSL_FINANCINGTYPE_20_EBP_LC')"/>
      </option>
      <option value='21'>
       <xsl:value-of select="localization:getGTPString($language, 'XSL_FINANCINGTYPE_21_EXPORT_DISCOUNTING_LC')"/>
      </option>
      <option value='22'>
       <xsl:value-of select="localization:getGTPString($language, 'XSL_FINANCINGTYPE_22_EBP_COLLECTION')"/>
      </option>
      <option value='23'>
       <xsl:value-of select="localization:getGTPString($language, 'XSL_FINANCINGTYPE_23_EXPORT_DISCOUNTING_COLLECTION')"/>
      </option>
      <option value='24'>
       <xsl:value-of select="localization:getGTPString($language, 'XSL_FINANCINGTYPE_24_PACKING_CREDIT')"/>
      </option>
      <option value='99'>
       <xsl:value-of select="localization:getGTPString($language, 'XSL_FINANCINGTYPE_99_OTHER')"/>
      </option>
     </xsl:when>
     <xsl:otherwise>
      <xsl:choose>
       <xsl:when test="fin_type[.='01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_FINANCINGTYPE_01_TRUST_RECEIPT')"/></xsl:when>
       <xsl:when test="fin_type[.='02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_FINANCINGTYPE_02_IMPORT_LOAN_LC')"/></xsl:when>
       <xsl:when test="fin_type[.='03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_FINANCINGTYPE_03_IMPORT_LOAN_COLLECTION')"/></xsl:when>
       <xsl:when test="fin_type[.='20']"><xsl:value-of select="localization:getGTPString($language, 'XSL_FINANCINGTYPE_20_EBP_LC')"/></xsl:when>
       <xsl:when test="fin_type[.='21']"><xsl:value-of select="localization:getGTPString($language, 'XSL_FINANCINGTYPE_21_EXPORT_DISCOUNTING_LC')"/></xsl:when>
       <xsl:when test="fin_type[.='22']"><xsl:value-of select="localization:getGTPString($language, 'XSL_FINANCINGTYPE_22_EBP_COLLECTION')"/></xsl:when>
       <xsl:when test="fin_type[.='23']"><xsl:value-of select="localization:getGTPString($language, 'XSL_FINANCINGTYPE_23_EXPORT_DISCOUNTING_COLLECTION')"/></xsl:when>
       <xsl:when test="fin_type[.='24']"><xsl:value-of select="localization:getGTPString($language, 'XSL_FINANCINGTYPE_24_PACKING_CREDIT')"/></xsl:when>
       <xsl:when test="fin_type[.='99']"><xsl:value-of select="localization:getGTPString($language, 'XSL_FINANCINGTYPE_99_OTHER')"/></xsl:when>
      </xsl:choose>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:template>
   
    <!--
   Purchase Terms <select> options. 
   -->
  <xsl:template name="purchase-terms-options">
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <option value=""/>
     <option value="EXW"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_EXW')"/></option>
     <option value="FCA"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_FCA')"/></option>
     <option value="FAS"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_FAS')"/></option>
     <option value="FOB"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_FOB')"/></option>
     <option value="CFR"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_CFR')"/></option>
     <option value="CIF"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_CIF')"/></option>
     <option value="DAT"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_DAT')"/></option>
     <option value="DAP"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_DAP')"/></option>
     <option value="CPT"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_CPT')"/></option>
     <option value="CIP"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_CIP')"/></option>
     <option value="DDP"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_DDP')"/></option>
    </xsl:when>
    <xsl:otherwise>
     <xsl:choose>
      <xsl:when test="inco_term[. = 'EXW']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_EXW')"/></xsl:when>
      <xsl:when test="inco_term[. = 'FCA']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_FCA')"/></xsl:when>
      <xsl:when test="inco_term[. = 'FAS']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_FAS')"/></xsl:when>
      <xsl:when test="inco_term[. = 'FOB']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_FOB')"/></xsl:when>
      <xsl:when test="inco_term[. = 'CFR']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_CFR')"/></xsl:when>
      <xsl:when test="inco_term[. = 'CIF']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_CIF')"/></xsl:when>
      <xsl:when test="inco_term[. = 'DAT']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_DAT')"/></xsl:when>
      <xsl:when test="inco_term[. = 'DAP']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_DAP')"/></xsl:when>
      <xsl:when test="inco_term[. = 'CPT']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_CPT')"/></xsl:when>
      <xsl:when test="inco_term[. = 'CIP']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_CIP')"/></xsl:when>
      <xsl:when test="inco_term[. = 'DDP']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_DDP')"/></xsl:when>
      <xsl:when test="inco_term[. = 'OTH']"><xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_OTH')"/></xsl:when>
     </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
  
   <!--                   -->
 <!-- Utility Templates -->
 <!--                   -->
 
 <!--
  Escapes quotes in a string. 
  -->
 <xsl:template name="quote_replace">
  <xsl:param name="input_text"/>
  <xsl:variable name="quote"><xsl:text>'</xsl:text></xsl:variable>
   <xsl:choose>
    <xsl:when test="contains($input_text,$quote)">
     <xsl:value-of select="substring-before($input_text,$quote)"/><xsl:text>\'</xsl:text>
     <xsl:call-template name="quote_replace">
       <xsl:with-param name="input_text" select="substring-after($input_text,$quote)"/>
     </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
     <xsl:value-of select="$input_text"/>
    </xsl:otherwise>
   </xsl:choose>
 </xsl:template>
  
 <xsl:template name="escape_quotes_and_apostrophe">
  <xsl:param name="input_text"/>
  <xsl:variable name="quote"><xsl:text>"</xsl:text></xsl:variable>
  <xsl:variable name="singlequote"><xsl:text>'</xsl:text></xsl:variable>
   <xsl:choose>
    <xsl:when test="contains($input_text,$singlequote)">
     <xsl:value-of select="substring-before($input_text,$singlequote)"/><xsl:text>\'</xsl:text>
     <xsl:call-template name="escape_quotes_and_apostrophe">
       <xsl:with-param name="input_text" select="substring-after($input_text,$singlequote)"/>
     </xsl:call-template>
    </xsl:when>
    <xsl:when test="contains($input_text,$quote)">
     <xsl:value-of select="substring-before($input_text,$quote)"/><xsl:text>\"</xsl:text>
     <xsl:call-template name="escape_quotes_and_apostrophe">
       <xsl:with-param name="input_text" select="substring-after($input_text,$quote)"/>
     </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
     <xsl:value-of select="$input_text"/>
    </xsl:otherwise>
   </xsl:choose>
 </xsl:template>
 
 
 <!-- 
  String replace
  
  Note that the value of cr is a hard carriage return - tidying the markup here
  will break the template
  -->
 	<xsl:template name="string_replace">
	  <xsl:param name="input_text"/>
	  <xsl:variable name="cr"><xsl:text>
</xsl:text></xsl:variable>
	    <xsl:choose>
	      <xsl:when test="string-length($input_text) = 1">
	      	<xsl:choose>
	      		<xsl:when test="contains($input_text,$cr)">
	      			<br/>
	      		</xsl:when>
	      		<xsl:otherwise>
				    <xsl:call-template name="space_replace">
				     <xsl:with-param name="input_text" select="$input_text"/>
				    </xsl:call-template>
			   </xsl:otherwise>
	      	</xsl:choose>
	      </xsl:when>
	      <xsl:when test="string-length($input_text) > 1">
	        <xsl:variable name="halfIndex" select="floor(string-length($input_text) div 2)"/>
	        <xsl:variable name="recursive_result1">
	          <xsl:choose>
		          <xsl:when test="contains(substring($input_text,1,$halfIndex),$cr)">
		          		<xsl:call-template name="space_replace">
					     	<xsl:with-param name="input_text" select="substring-before(substring($input_text,1,$halfIndex),$cr)"/>
					    </xsl:call-template>
						<br/>
					    <xsl:call-template name="string_replace">
					     	<xsl:with-param name="input_text" select="substring-after(substring($input_text,1,$halfIndex),$cr)"/>
					    </xsl:call-template>
				   </xsl:when>
				   <xsl:otherwise>
					    <xsl:call-template name="space_replace">
					     	<xsl:with-param name="input_text" select="substring($input_text,1,$halfIndex)"/>
					    </xsl:call-template>
				   </xsl:otherwise>
			   </xsl:choose>
	        </xsl:variable>
	        <xsl:variable name="recursive_result2">
	          <xsl:choose>
		          <xsl:when test="contains(substring($input_text, $halfIndex+1),$cr)">
		          		<xsl:call-template name="space_replace">
					     	<xsl:with-param name="input_text" select="substring-before(substring($input_text, $halfIndex+1),$cr)"/>
					    </xsl:call-template>
						<br/>
					    <xsl:call-template name="string_replace">
					     	<xsl:with-param name="input_text" select="substring-after(substring($input_text, $halfIndex+1),$cr)"/>
					    </xsl:call-template>
				   </xsl:when>
				   <xsl:otherwise>
					    <xsl:call-template name="space_replace">
					     	<xsl:with-param name="input_text" select="substring($input_text, $halfIndex+1)"/>
					    </xsl:call-template>
				   </xsl:otherwise>
			   </xsl:choose>
	        </xsl:variable>
	      <xsl:copy-of select="$recursive_result1" />
	      <xsl:copy-of select="$recursive_result2" />
	      
	    </xsl:when>
	  </xsl:choose>
	</xsl:template>
   
   <xsl:template name="space_replace">
	   <xsl:param name="input_text"/>
	   <xsl:choose>
	   		<!-- 30 spaces -->
	   		<xsl:when test="contains($input_text,'                              ')">
			     <xsl:value-of select="substring-before($input_text,'                              ')"/>
			     <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
			     <xsl:call-template name="space_replace">
			       <xsl:with-param name="input_text" select="substring-after($input_text,'                              ')"/>
			     </xsl:call-template>
		    </xsl:when>
	   		<!-- 20 spaces -->
	   		<xsl:when test="contains($input_text,'                    ')">
			     <xsl:value-of select="substring-before($input_text,'                    ')"/>
			     <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
			     <xsl:call-template name="space_replace">
			      <xsl:with-param name="input_text" select="substring-after($input_text,'                    ')"/>
			     </xsl:call-template>
		    </xsl:when>
		    <!-- 15 spaces -->
	   		<xsl:when test="contains($input_text,'               ')">
			     <xsl:value-of select="substring-before($input_text,'               ')"/>
			     <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
			     <xsl:call-template name="space_replace">
			      <xsl:with-param name="input_text" select="substring-after($input_text,'               ')"/>
			     </xsl:call-template>
		    </xsl:when>
		    <!-- 10 spaces -->
		    <xsl:when test="contains($input_text,'          ')">
			     <xsl:value-of select="substring-before($input_text,'          ')"/>
			     <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
			     <xsl:call-template name="space_replace">
			      <xsl:with-param name="input_text" select="substring-after($input_text,'          ')"/>
			     </xsl:call-template>
		    </xsl:when>
		    <!-- 9 spaces -->
		    <xsl:when test="contains($input_text,'         ')">
			     <xsl:value-of select="substring-before($input_text,'         ')"/>
			     <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
			     <xsl:call-template name="space_replace">
			      <xsl:with-param name="input_text" select="substring-after($input_text,'         ')"/>
			     </xsl:call-template>
		    </xsl:when>
		    <!-- 8 spaces -->
		    <xsl:when test="contains($input_text,'        ')">
			     <xsl:value-of select="substring-before($input_text,'        ')"/>
			     <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
			     <xsl:call-template name="space_replace">
			      <xsl:with-param name="input_text" select="substring-after($input_text,'        ')"/>
			     </xsl:call-template>
		    </xsl:when>
		    <!-- 7 spaces -->
		    <xsl:when test="contains($input_text,'       ')">
			     <xsl:value-of select="substring-before($input_text,'       ')"/>
			     <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
			     <xsl:call-template name="space_replace">
			      <xsl:with-param name="input_text" select="substring-after($input_text,'       ')"/>
			     </xsl:call-template>
		    </xsl:when>
		    <!-- 6 spaces -->
		    <xsl:when test="contains($input_text,'      ')">
			     <xsl:value-of select="substring-before($input_text,'      ')"/>
			     <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
			     <xsl:call-template name="space_replace">
			      <xsl:with-param name="input_text" select="substring-after($input_text,'      ')"/>
			     </xsl:call-template>
		    </xsl:when>
		    <!-- 5 spaces -->
		    <xsl:when test="contains($input_text,'     ')">
			     <xsl:value-of select="substring-before($input_text,'     ')"/>
			     <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
			     <xsl:call-template name="space_replace">
			      <xsl:with-param name="input_text" select="substring-after($input_text,'     ')"/>
			     </xsl:call-template>
		    </xsl:when>
		    <!-- 4 spaces -->
		    <xsl:when test="contains($input_text,'    ')">
			     <xsl:value-of select="substring-before($input_text,'    ')"/>
			     <xsl:text>&nbsp;&nbsp;&nbsp;&nbsp;</xsl:text>
			     <xsl:call-template name="space_replace">
			      <xsl:with-param name="input_text" select="substring-after($input_text,'    ')"/>
			     </xsl:call-template>
		    </xsl:when>
		    <!-- 3 spaces -->
		    <xsl:when test="contains($input_text,'   ')">
			     <xsl:value-of select="substring-before($input_text,'   ')"/>
			     <xsl:text>&nbsp;&nbsp;&nbsp;</xsl:text>
			     <xsl:call-template name="space_replace">
			      <xsl:with-param name="input_text" select="substring-after($input_text,'   ')"/>
			     </xsl:call-template>
		    </xsl:when>
		    <!-- 2 spaces -->
		    <xsl:when test="contains($input_text,'  ')">
			     <xsl:value-of select="substring-before($input_text,'  ')"/>
			     <xsl:text>&nbsp;&nbsp;</xsl:text>
			     <xsl:call-template name="space_replace">
			      <xsl:with-param name="input_text" select="substring-after($input_text,'  ')"/>
			     </xsl:call-template>
		    </xsl:when>
		    <!-- 1 space -->
		    <xsl:when test="contains($input_text,' ')">
			     <xsl:value-of select="substring-before($input_text,' ')"/>
			     <xsl:text>&nbsp;</xsl:text>
			     <xsl:call-template name="space_replace">
			      <xsl:with-param name="input_text" select="substring-after($input_text,' ')"/>
			     </xsl:call-template>
		    </xsl:when>
		    <xsl:otherwise>
		     	<xsl:value-of select="$input_text"/>
		    </xsl:otherwise>
	   </xsl:choose>
  </xsl:template>
    
    <xsl:template name="authentication">
  </xsl:template>
  
 
   <!--
    SI Type Codes. 
  -->
  <xsl:template name="si-type-codes">
  <!-- <xsl:param name="is-bank-template">N</xsl:param> -->
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
    <!--  <xsl:if test="$is-bank-template = 'Y'">
	   <option value="99">
	    <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_ANY')"/>
	   </option>
     </xsl:if> -->
     <option value="01">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_BIDBOND')"/>
     </option>
     <option value="02">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_PERFORMANCEBOND')"/>
     </option>
     <option value="03">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_PAYMTBOND')"/>
     </option>
     <option value="04">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_ADVPAYMTBOND')"/>
     </option>
     <option value="05">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_GTEEDEPOSIT')"/>
     </option>
     <option value="06">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_TEMPADMISSIONPERM')"/>
     </option>
     <option value="08">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_REPAYMENT')"/>
     </option>
     <option value="09">
      <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_RETENTION')"/>
     </option>
     <!-- <xsl:if test="$is-bank-template = 'N'"> -->
      <option value="99">
       <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_OTHER')"/>
      </option>
     <!-- </xsl:if> -->
    </xsl:when>
    <xsl:otherwise>
     <xsl:choose>
      <xsl:when test="si_type_code[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_BIDBOND')"/></xsl:when>
      <xsl:when test="si_type_code[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_PERFORMANCEBOND')"/></xsl:when>
      <xsl:when test="si_type_code[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_PAYMTBOND')"/></xsl:when>
      <xsl:when test="si_type_code[. = '04']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_ADVPAYMTBOND')"/></xsl:when>
      <xsl:when test="si_type_code[. = '05']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_GTEEDEPOSIT')"/></xsl:when>
      <xsl:when test="si_type_code[. = '06']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_TEMPADMISSIONPERM')"/></xsl:when>
      <xsl:when test="si_type_code[. = '08']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_REPAYMENT')"/></xsl:when>
      <xsl:when test="si_type_code[. = '09']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_RETENTION')"/></xsl:when>
      <xsl:when test="si_type_code[. = '99']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TYPE_OTHER')"/></xsl:when>
     </xsl:choose>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
  
  <xsl:template name="standby-lc-details">
  	<xsl:param name="featureId"/>
  	<xsl:param name="isBank"/>
  	<xsl:param name="isAmend">N</xsl:param>
  	<xsl:param name="isStructuredFormat">N</xsl:param>
  	
  	<xsl:call-template name="fieldset-wrapper">
	    <xsl:with-param name="legend">XSL_HEADER_STANDBY_LC_DETAILS</xsl:with-param>
	    <xsl:with-param name="content">
	    <xsl:call-template name="hidden-field">
			<xsl:with-param name="name">standby_text_type_code</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">standby_template_bank_id</xsl:with-param>
		</xsl:call-template>
	  	<xsl:choose>
	    	<xsl:when test="$displaymode='edit' ">
		    	<xsl:if test= "product_type_code ='' and prod_type_code/product_type_details/product_type_description !='' and $isStructuredFormat != 'Y'">
					<xsl:call-template name="select-field">
			    		<xsl:with-param name="label">XSL_SBLCDETAILS_TYPE_LABEL</xsl:with-param>
			    		<xsl:with-param name="name">product_type_code</xsl:with-param>
			    		<xsl:with-param name="required">Y</xsl:with-param>
			    		<xsl:with-param name="value"></xsl:with-param>
			    		<xsl:with-param name="options">
					      	<xsl:call-template name="product_type_code_options"/>
					    </xsl:with-param>
			    	</xsl:call-template>
				</xsl:if>
				<xsl:if test= "product_type_code ='' and prod_type_code/product_type_details/product_type_description !='' and $isStructuredFormat = 'Y'">
					<xsl:call-template name="select-field">
			    		<xsl:with-param name="label">XSL_SBLCDETAILS_TYPE_LABEL</xsl:with-param>
			    		<xsl:with-param name="name">product_type_code</xsl:with-param>
			    		<xsl:with-param name="required">Y</xsl:with-param>
			    		<xsl:with-param name="disabled">N</xsl:with-param>	
			    		<xsl:with-param name="value"></xsl:with-param>
			    		<xsl:with-param name="options">
					      	<xsl:call-template name="product_type_code_options"/>
					    </xsl:with-param>
			    	</xsl:call-template>
				</xsl:if>
				<xsl:if test="product_type_code[.!=''] and prod_type_code/product_type_details/product_type_description[.!=''] and $isAmend!='Y' and $isBank !='Y'">
		    		<xsl:call-template name="select-field">
			    		<xsl:with-param name="label">XSL_SBLCDETAILS_TYPE_LABEL</xsl:with-param>
			    		<xsl:with-param name="name">product_type_code</xsl:with-param>
			    		<xsl:with-param name="required">Y</xsl:with-param>
			    		<xsl:with-param name="value"><xsl:value-of select="product_type_code"/></xsl:with-param>
			    		<xsl:with-param name="options">
					      	<xsl:call-template name="product_type_code_options"/>
					    </xsl:with-param>
			    	</xsl:call-template>
			    </xsl:if>
			    <xsl:if test="product_type_code[.!=''] and prod_type_code/product_type_details/product_type_description[.!=''] and $isAmend='Y'">
		    		<xsl:variable name="sblc_type_code"><xsl:value-of select="product_type_code"></xsl:value-of></xsl:variable>
					<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
					<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
					<xsl:variable name="parameterId">C010</xsl:variable>
		    		<xsl:call-template name="select-field">
			    		<xsl:with-param name="label">XSL_SBLCDETAILS_TYPE_LABEL</xsl:with-param>
			    		<xsl:with-param name="name">product_type_code</xsl:with-param>
			    		<xsl:with-param name="disabled">Y</xsl:with-param>
			    		<xsl:with-param name="required">Y</xsl:with-param>
			    		<xsl:with-param name="value"><xsl:value-of select="product_type_code"/></xsl:with-param>
			    		<xsl:with-param name="options">
					      	<option>
					           <xsl:attribute name="value">
					            <xsl:value-of select="product_type_code"></xsl:value-of>
					            </xsl:attribute>
					            <xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $sblc_type_code)"/>
					        </option>
					    </xsl:with-param>
			    	</xsl:call-template>
			    </xsl:if>
			    <xsl:if test="product_type_code !='' and $isBank='Y'">
					<xsl:call-template name="select-field">
					 	<xsl:with-param name="label">XSL_SBLCDETAILS_TYPE_LABEL</xsl:with-param>
					 	<xsl:with-param name="name">product_type_code</xsl:with-param>
					 	<xsl:with-param name="value"><xsl:value-of select="product_type_code"/></xsl:with-param>
					 	<xsl:with-param name="options">
					 	<xsl:call-template name="product_type_code_options"/>
					    </xsl:with-param>	
					 	<xsl:with-param name="required">Y</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			    <xsl:if test="product_type_details[.!='']">
					<xsl:call-template name="input-field">
					 	<xsl:with-param name="label"></xsl:with-param>
					 	<xsl:with-param name="name">product_type_details</xsl:with-param>
					 	<xsl:with-param name="value"><xsl:value-of select="product_type_details"/></xsl:with-param>	
					</xsl:call-template>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="$swift2018Enabled">
						<xsl:if test="$isBank!='Y' and $isAmend!='Y'">
						    <div id="pro-check-box">
								 <xsl:call-template name="checkbox-field">
									 <xsl:with-param name="label">XSL_PROVISIONAL</xsl:with-param>
									 <xsl:with-param name="name">provisional_status</xsl:with-param>
								 </xsl:call-template>
							 </div>
						 </xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="$isBank!='Y'">
						    <div id="pro-check-box">
								 <xsl:call-template name="checkbox-field">
									 <xsl:with-param name="label">XSL_PROVISIONAL</xsl:with-param>
									 <xsl:with-param name="name">provisional_status</xsl:with-param>
								 </xsl:call-template>
							 </div>
						 </xsl:if>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="product_type_details =''">
					<xsl:call-template name="input-field">
					 	<xsl:with-param name="label"></xsl:with-param>
					 	<xsl:with-param name="name">product_type_details</xsl:with-param>
					 	<xsl:with-param name="value"></xsl:with-param>	
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="$featureId!='' and stand_by_lc_code[.='']">
			    	<xsl:call-template name="input-field">
			    		<xsl:with-param name="label">XSL_SBLC_NAME</xsl:with-param>
			    		<xsl:with-param name="name">stand_by_lc_code</xsl:with-param>
			    		<xsl:with-param name="required">Y</xsl:with-param>
			    		<xsl:with-param name="value"><xsl:value-of select="$featureId"></xsl:value-of></xsl:with-param>
			    		<xsl:with-param name="disabled">Y</xsl:with-param>
			    	</xsl:call-template> 
			    </xsl:if>
			    <xsl:if test="stand_by_lc_code[.!='']">
			    	<xsl:call-template name="input-field">
			    		<xsl:with-param name="label">XSL_SBLC_NAME</xsl:with-param>
			    		<xsl:with-param name="name">stand_by_lc_code</xsl:with-param>
			    		<xsl:with-param name="required">Y</xsl:with-param>
			    		<xsl:with-param name="value"><xsl:value-of select="stand_by_lc_code"></xsl:value-of></xsl:with-param>
			    		<xsl:with-param name="disabled">Y</xsl:with-param>
			    	</xsl:call-template> 
			    </xsl:if>
			    
			    <xsl:if test="standby_text_type_code = '01' and $isBank!='Y'">
			    <xsl:choose>
			    <xsl:when test="speciman != ''">
					<xsl:call-template name="row-wrapper">
						<xsl:with-param name="id">display_specimen</xsl:with-param>
						<xsl:with-param name="content">
					       (<a>
					         <xsl:attribute name="href">javascript:void(0)</xsl:attribute>
					         <xsl:attribute name="onclick">misys.downloadStaticDocument('document_id');</xsl:attribute>
					         <xsl:attribute name="title"><xsl:value-of select="localization:getGTPString($language, 'ACTION_DISPLAY_STAND_BY_LC_SPECIMEN')"/></xsl:attribute>
					         <xsl:value-of select="localization:getGTPString($language, 'ACTION_DISPLAY_STAND_BY_LC_SPECIMEN')"/>
					        </a>)
							<xsl:call-template name="hidden-field">
								<xsl:with-param name="name">document_id</xsl:with-param>
							</xsl:call-template>
			        	</xsl:with-param>
			        </xsl:call-template>
			     </xsl:when>
			     <xsl:otherwise>
			     	<xsl:call-template name="row-wrapper">
		      		<xsl:with-param name="id">GTEETextPreview</xsl:with-param>
		      		<xsl:with-param name="label"></xsl:with-param>
		      		<xsl:with-param name="content">
		      		<a name="GTEETextPreview" href="javascript:void(0)" onclick="misys.generateGTEEFromNew();return false;">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_SBLCDETAILS_TEXT_PREVIEW_LABEL')"/>
			   		</a>
		     	 	</xsl:with-param>
		     		</xsl:call-template>
			     </xsl:otherwise>	
			     </xsl:choose>
			     </xsl:if>
			     <xsl:if test="standby_text_type_code = '02' and $isBank!='Y'">
			     	<xsl:variable name="pdfOption">
			     		<xsl:choose>
						   <xsl:when test="security:isBank($rundata)">PDF_SI_DOCUMENT_DETAILS_BANK</xsl:when>
						   <xsl:otherwise>PDF_SI_DOCUMENT_DETAILS</xsl:otherwise>
						 </xsl:choose>
			     	</xsl:variable>
			     	<xsl:call-template name="row-wrapper">
						<xsl:with-param name="id">display_specimen</xsl:with-param>
						<xsl:with-param name="content">
							<xsl:variable name="refId"><xsl:if test="$option != 'SCRATCH'"><xsl:value-of select="ref_id"/></xsl:if></xsl:variable>
							<xsl:variable name="tnxId"><xsl:if test="$option != 'SCRATCH'"><xsl:value-of select="tnx_id"/></xsl:if></xsl:variable>
										
					       (<a>
					         <xsl:attribute name="href">javascript:void(0)</xsl:attribute>
					         <xsl:attribute name="onclick">javascript:misys.popup.generateDocument('si-document', '<xsl:value-of select="$pdfOption"/>', '<xsl:value-of select="$refId"/>', '<xsl:value-of select="$tnxId"/>', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="stand_by_lc_code"/>','<xsl:value-of select="standby_template_bank_id"/>');</xsl:attribute>
					         <xsl:attribute name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_TYPE_VIEW_EDITED_DOCUMENT')"/></xsl:attribute>
					         <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_TYPE_VIEW_EDITED_DOCUMENT')"/>
					        </a>)
			        	</xsl:with-param>
			        </xsl:call-template>
			     </xsl:if>
			     <xsl:if test="standby_rule_code[.=''] and prod_rule/product_rule_details/product_rule_description[.!='']">
				     <xsl:call-template name="select-field">
			    		<xsl:with-param name="label">XSL_GTEEDETAILS_RULES_LABEL</xsl:with-param>
			    		<xsl:with-param name="name">standby_rule_code</xsl:with-param>
			    		<xsl:with-param name="value"></xsl:with-param>
			    		<xsl:with-param name="options">
					      	<xsl:call-template name="product_rule_options"/>
					    </xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="standby_rule_code[.!=''] and $isAmend='Y'">
				     <xsl:call-template name="select-field">
			    		<xsl:with-param name="label">XSL_GTEEDETAILS_RULES_LABEL</xsl:with-param>
			    		<xsl:with-param name="name">standby_rule_code</xsl:with-param>
			    		<xsl:with-param name="value"><xsl:value-of select="standby_rule_code"/></xsl:with-param>
			    		<xsl:with-param name="options">
					      	<xsl:call-template name="product_rule_options"/>
					    </xsl:with-param>
					    <xsl:with-param name="disabled">
					    	<xsl:choose>
								<xsl:when test="$swift2018Enabled">N</xsl:when>
								<xsl:otherwise>Y</xsl:otherwise>
							</xsl:choose>
					    </xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			     <xsl:if test="standby_rule_code[.!=''] and $isAmend!='Y'">
				     <xsl:call-template name="select-field">
			    		<xsl:with-param name="label">XSL_GTEEDETAILS_RULES_LABEL</xsl:with-param>
			    		<xsl:with-param name="name">standby_rule_code</xsl:with-param>
			    		<xsl:with-param name="value"><xsl:value-of select="standby_rule_code"/></xsl:with-param>
			    		<xsl:with-param name="options">
					      	<xsl:call-template name="product_rule_options"/>
					    </xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:call-template name="input-field">
				   <xsl:with-param name="name">standby_rule_other</xsl:with-param>
				   <xsl:with-param name="maxsize">35</xsl:with-param>
				   <xsl:with-param name="readonly">Y</xsl:with-param>
				   <xsl:with-param name="required">
				   	<xsl:choose>
							<xsl:when test="$swift2018Enabled">N</xsl:when>
							<xsl:otherwise>Y</xsl:otherwise>
					</xsl:choose>
				   </xsl:with-param>
				</xsl:call-template>
	    	</xsl:when>
	    	
	    	<xsl:otherwise >
	    		<xsl:if test="product_type_code[.!='']">
				<xsl:variable name="sblc_type_code"><xsl:value-of select="product_type_code"></xsl:value-of></xsl:variable>
				<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
				<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
				<xsl:variable name="parameterId">C010</xsl:variable>
					<xsl:call-template name="input-field">
					 	<xsl:with-param name="label">XSL_SBLCDETAILS_TYPE_LABEL</xsl:with-param>
					 	<xsl:with-param name="name">product_type_code</xsl:with-param>
					 	<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $sblc_type_code)"/></xsl:with-param>
					 	<xsl:with-param name="override-displaymode">view</xsl:with-param>	
					</xsl:call-template>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="$swift2018Enabled">
						<xsl:if test="$isBank!='Y' and $isAmend!='Y'">
						    <div id="pro-check-box">
								 <xsl:call-template name="checkbox-field">
									 <xsl:with-param name="label">XSL_PROVISIONAL</xsl:with-param>
									 <xsl:with-param name="name">provisional_status</xsl:with-param>
									 <xsl:with-param name="override-displaymode">view</xsl:with-param>
								 </xsl:call-template>
							 </div>
						 </xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="provisional_status[.='Y'] and $isBank!='Y'">
						    <div id="pro-check-box">
								<xsl:call-template name="row-wrapper">
								<xsl:with-param name="override-label">&nbsp;</xsl:with-param>
								<xsl:with-param name="content">
									<div class="content">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_PROVISIONAL')"/>
									</div>	
								</xsl:with-param>
								<xsl:with-param name="override-displaymode">view</xsl:with-param>
								</xsl:call-template>
							 </div>
						 </xsl:if>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="product_type_details[.!='']">
					<xsl:call-template name="input-field">
					 	<xsl:with-param name="label"></xsl:with-param>
					 	<xsl:with-param name="name">product_type_details</xsl:with-param>
					 	<xsl:with-param name="value"><xsl:value-of select="product_type_details"/></xsl:with-param>
					 	<xsl:with-param name="override-displaymode">view</xsl:with-param>	
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="stand_by_lc_code[.!='']">
					<xsl:call-template name="input-field">
					 	<xsl:with-param name="label">XSL_SBLC_NAME</xsl:with-param>
					 	<xsl:with-param name="name">stand_by_lc_code</xsl:with-param>
					 	<xsl:with-param name="value"><xsl:value-of select="stand_by_lc_code"/></xsl:with-param>
					 	<xsl:with-param name="override-displaymode">view</xsl:with-param>	
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="standby_rule_code[.!='']">
					<xsl:variable name="sblc_rule_code"><xsl:value-of select="standby_rule_code"/></xsl:variable>
					<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
					<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
					<xsl:variable name="parameterId">C012</xsl:variable>
					<xsl:call-template name="input-field">
			    		<xsl:with-param name="label">XSL_GTEEDETAILS_RULES_LABEL</xsl:with-param>
			    		<xsl:with-param name="name">standby_rule_code</xsl:with-param>
			    		<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $sblc_rule_code)"/></xsl:with-param>
			    		<xsl:with-param name="override-displaymode">view</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="standby_text_type_code = '01' and $isBank!='Y'"> 
				    <xsl:if test="speciman != ''">
						<xsl:call-template name="row-wrapper">
							<xsl:with-param name="id">display_specimen</xsl:with-param>
							<xsl:with-param name="content">
						       (<a>
						         <xsl:attribute name="href">javascript:void(0)</xsl:attribute>
						         <xsl:attribute name="onclick">misys.downloadStaticDocument('document_id');</xsl:attribute>
						         <xsl:attribute name="title"><xsl:value-of select="localization:getGTPString($language, 'ACTION_DISPLAY_STAND_BY_LC_SPECIMEN')"/></xsl:attribute>
						         <xsl:value-of select="localization:getGTPString($language, 'ACTION_DISPLAY_STAND_BY_LC_SPECIMEN')"/>
						        </a>)
								<xsl:call-template name="hidden-field">
									<xsl:with-param name="name">document_id</xsl:with-param>
								</xsl:call-template>
				        	</xsl:with-param>
				        </xsl:call-template>
				     </xsl:if>	
			     </xsl:if>
				<xsl:if test="standby_text_type_code = '02' and $isBank!='Y'">
			     	<xsl:variable name="pdfOption">
			     		<xsl:choose>
						   <xsl:when test="security:isBank($rundata)">PDF_SI_DOCUMENT_DETAILS_BANK</xsl:when>
						   <xsl:otherwise>PDF_SI_DOCUMENT_DETAILS</xsl:otherwise>
						 </xsl:choose>
			     	</xsl:variable>
			     	<xsl:call-template name="row-wrapper">
						<xsl:with-param name="id">display_specimen</xsl:with-param>
						<xsl:with-param name="content">
							<xsl:variable name="refId"><xsl:if test="$option != 'SCRATCH'"><xsl:value-of select="ref_id"/></xsl:if></xsl:variable>
							<xsl:variable name="tnxId"><xsl:if test="$option != 'SCRATCH'"><xsl:value-of select="tnx_id"/></xsl:if></xsl:variable>
										
					       (<a>
					         <xsl:attribute name="href">javascript:void(0)</xsl:attribute>
					         <xsl:attribute name="onclick">javascript:misys.popup.generateDocument('si-document', '<xsl:value-of select="$pdfOption"/>', '<xsl:value-of select="$refId"/>', '<xsl:value-of select="$tnxId"/>', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="stand_by_lc_code"/>','<xsl:value-of select="standby_template_bank_id"/>');</xsl:attribute>
					         <xsl:attribute name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_TYPE_VIEW_EDITED_DOCUMENT')"/></xsl:attribute>
					         <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_TYPE_VIEW_EDITED_DOCUMENT')"/>
					        </a>)
			        	</xsl:with-param>
			        </xsl:call-template>
			     </xsl:if>
				<xsl:call-template name="input-field">
				   <xsl:with-param name="name">standby_rule_other</xsl:with-param>
				   <xsl:with-param name="maxsize">35</xsl:with-param>
				   <xsl:with-param name="readonly">Y</xsl:with-param>
				   <xsl:with-param name="required">Y</xsl:with-param>
				</xsl:call-template>
	    	</xsl:otherwise>
	    </xsl:choose>
	    
	    </xsl:with-param>
	   </xsl:call-template>
  </xsl:template>
  <xsl:template name="product_type_code_options">
		<xsl:for-each select="prod_type_code/product_type_details">
	        <option>
	           <xsl:attribute name="value">
	            <xsl:value-of select="product_type_code"></xsl:value-of>
	            </xsl:attribute>
	            <xsl:value-of select="product_type_description"/>
	        </option>
      	</xsl:for-each>
	</xsl:template>
	<xsl:template name="product_rule_options">
		<xsl:for-each select="prod_rule/product_rule_details">
	        <option>
	           <xsl:attribute name="value">
	            <xsl:value-of select="product_rule_code"></xsl:value-of>
	            </xsl:attribute>
	            <xsl:value-of select="product_rule_description"/>
	        </option>
      	</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="treasury_branch_reference_options">
		<xsl:for-each select="treasury_branch_references/branch_reference">
	        <option>
	           <xsl:attribute name="value">
	            	<xsl:value-of select="branch_code" />
	           </xsl:attribute>
	            <xsl:value-of select="branch_code" /> - <xsl:value-of select="branch_name"/>
	        </option>
      	</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="liquidity_branch_reference_options">
		<xsl:for-each select="liquidity_branch_reference/fi_reference">
	        <option>
	           <xsl:attribute name="value">
	            	<xsl:value-of select="fi_code" />
	           </xsl:attribute>
	            <xsl:value-of select="fi_code" /> - <xsl:value-of select="fi_name"/>
	        </option>
      	</xsl:for-each>
      	<option></option>
	</xsl:template>
	
	<xd:doc>
		<xd:short>To build Guarantee contract references.</xd:short>
		<xd:detail>
			To build Guarantee contract references option.
		</xd:detail>
	</xd:doc>
	<xsl:template name="guarantee-references-options">
	<xsl:for-each select="guarantee_references/guarantee_reference">
		<option>
		<xsl:attribute name="value">
		<xsl:value-of select="guarantee_ref_code"></xsl:value-of>
		</xsl:attribute>
		<xsl:value-of select="guarantee_ref_desc"></xsl:value-of>
		</option>
	</xsl:for-each>
	</xsl:template>
	
	<xsl:template name="build-inco-terms-data">
	<script>
		dojo.ready(function(){
			misys._config = misys._config || {};
			 dojo.mixin(misys._config, {
			 
			 incoTermYearMap : {
			    			<xsl:if test="count(//avail_inco_terms/inco_term_banks) > 0" >
			    			<xsl:for-each select="//avail_inco_terms/inco_term_banks">
				        		<xsl:variable name="bank" select="./bank"/>
				        		'<xsl:value-of select="$bank"/>': [
				        		<xsl:for-each select="./inco_term_values">
				        		<xsl:variable name="term-year" select="./year"/>
				        		{ value:'<xsl:value-of select="$term-year"/>',
							     name:'<xsl:value-of select="$term-year"/>'},
				        				</xsl:for-each>]<xsl:if test="not(position()=last())">,</xsl:if>
				         		
				         		</xsl:for-each>
				         		
			         		</xsl:if>
						},
						
				 incoTermProductMap : {
			    			<xsl:if test="count(//avail_inco_terms/inco_term_banks) > 0" >
			    			<xsl:for-each select="//avail_inco_terms/inco_term_banks">
				        		<xsl:variable name="bank" select="./bank"/>
				        	<xsl:for-each select="./inco_term_values">
				        			<xsl:variable name="term-year" select="./year"/>
				        			'<xsl:value-of select="$bank"/>:<xsl:value-of select="$term-year"/>' : [
				        			<xsl:for-each select="./values/value" >
					   							{ value:"<xsl:value-of select="."/>",
							         				name:"<xsl:value-of select="localization:getCodeData($language,'*','*','N212',.)"/>"},
							         </xsl:for-each>
							      ],
			   					</xsl:for-each>
				         		
				         		</xsl:for-each>
				         		
			         		</xsl:if>
						} 
		});
	});
	</script>
	
	</xsl:template>
	<xsl:template name="build-delivery-to-data">
	<script>
		dojo.ready(function(){
			misys._config = misys._config || {};
			 dojo.mixin(misys._config, {
			 
			 deliveryToMap : {
			    			<xsl:if test="count(//avail_delivery_to/delivery_to_banks) > 0" >
			    			<xsl:for-each select="//avail_delivery_to/delivery_to_banks">
				        		<xsl:variable name="bank" select="./bank"/>
				        		'<xsl:value-of select="$bank"/>': [
				        		<xsl:for-each select="./delivery_to_values">
				        		<xsl:variable name="delivery-to-name" select="./label"/>
				        		<xsl:variable name="delivery-to-value" select="./value"/>
				        		{ value:'<xsl:value-of select="$delivery-to-value"/>',
							     name:'<xsl:value-of select="$delivery-to-name"/>'},
				        		</xsl:for-each>]<xsl:if test="not(position()=last())">,</xsl:if>    		
				         		</xsl:for-each>
				         		
			         		</xsl:if>
						} 
		});
	});
	</script>
	
	</xsl:template>
	
	 <!-- facility reference  -->
	<xsl:template name="build-facility-data">
	<script>
		dojo.ready(function(){
			misys._config = misys._config || {};
			 dojo.mixin(misys._config, {
				facilityReferenceCollection : {
					<xsl:for-each select="//facility_details/facility_reference_details/bo_reference">
					'<xsl:value-of select="cust_ref"/>' : {
						<xsl:for-each select="bank_entity">
							'<xsl:value-of select="name"/>' : [
								<xsl:for-each select="facility">
								{
									value:"<xsl:value-of select="id"/>",
						         	name:"<xsl:value-of select="reference"/>"
								}<xsl:if test="not(position()=last())">,</xsl:if>
						</xsl:for-each>
					]<xsl:if test="not(position()=last())">,</xsl:if>
					</xsl:for-each>
					}<xsl:if test="not(position()=last())">,</xsl:if>
				</xsl:for-each>
			},
			facilityReviewDateCollection : {
				<xsl:for-each select="//facility_details/facility_date_details/facility_date_element">
					'<xsl:value-of select="facility"/>' : '<xsl:value-of select="date"/>'<xsl:if test="not(position()=last())">,</xsl:if>
				</xsl:for-each>
			}
		});
	});
	</script>
	</xsl:template>
	
	<xsl:template name= "facility-limit-section">
	<xsl:param name="isBank">N</xsl:param>
	<xsl:param name="displayAmount">Y</xsl:param>
	<xsl:param name="isPreview">N</xsl:param>
	 <xsl:call-template name="fieldset-wrapper">
	    <xsl:with-param name="legend">XSL_HEADER_FACILITY_LIMIT_SECTION</xsl:with-param>
	    <xsl:with-param name="content">
	    	<!-- Facility Details sub section -->
		    <xsl:call-template name="fieldset-wrapper">
			    <xsl:with-param name="legend">XSL_HEADER_FACILITY_DETAILS</xsl:with-param>
		    	<xsl:with-param name="legend-type">indented-header</xsl:with-param>
		    	<xsl:with-param name="content">
		    		<xsl:choose>
		    			<xsl:when test="$isPreview = 'N'">
							<xsl:call-template name="select-field">
						   		<xsl:with-param name="label">XSL_FACILITY_REFERENCE</xsl:with-param>
						     	<xsl:with-param name="name">facility_id</xsl:with-param>
						     	 <xsl:with-param name="value"><xsl:value-of select="limit_details/facility_id"/></xsl:with-param>
						    	 <xsl:with-param name="options">
						    	 	<xsl:if test="$isBank = 'Y'">
						    	 		<xsl:for-each select="facility_details/facility">
											<option>
												<xsl:attribute name="value"><xsl:value-of select="id" /></xsl:attribute>
												<xsl:value-of select="reference" />
											</option>
										</xsl:for-each>
						    	 	</xsl:if>
						    	 </xsl:with-param>
					   		</xsl:call-template>
					   		
					   		<xsl:call-template name="hidden-field">
						     	<xsl:with-param name="name">facility_reference</xsl:with-param>
						    	 <xsl:with-param name="value"><xsl:value-of select="limit_details/facility_reference"/></xsl:with-param>
					   		</xsl:call-template>
					   		
					   		<xsl:variable name="facilityMandatory"><xsl:value-of select="defaultresource:getResource('FACILITY_TRANSACTION_SELECTION_REQUIRED')"/></xsl:variable>
						
								<xsl:call-template name="hidden-field">
									<xsl:with-param name="name">facility_mandatory</xsl:with-param>
						    	 <xsl:with-param name="value"><xsl:value-of select="$facilityMandatory"/></xsl:with-param>
								</xsl:call-template>
							
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="input-field">
						     	<xsl:with-param name="name">facility_reference</xsl:with-param>
 							   	<xsl:with-param name="label">XSL_FACILITY_REFERENCE</xsl:with-param>
						    	 <xsl:with-param name="value"><xsl:value-of select="limit_details/facility_reference"/></xsl:with-param>
					   		</xsl:call-template>
					   		<xsl:call-template name="hidden-field">
						     	<xsl:with-param name="name">facility_id</xsl:with-param>
						    	 <xsl:with-param name="value"><xsl:value-of select="limit_details/facility_id"/></xsl:with-param>
					   		</xsl:call-template>
						</xsl:otherwise>
			   		</xsl:choose>
				    <xsl:call-template name="input-field">
				      <xsl:with-param name="label">XSL_FACILITY_DATE</xsl:with-param>
				      <xsl:with-param name="name">facility_date</xsl:with-param>
				      <xsl:with-param name="size">10</xsl:with-param>
				      <xsl:with-param name="maxsize">10</xsl:with-param>
				      <xsl:with-param name="type">date</xsl:with-param>
				      <xsl:with-param name="fieldsize">small</xsl:with-param>
				      <xsl:with-param name="readonly">Y</xsl:with-param>
				    </xsl:call-template>
			    </xsl:with-param>
			 </xsl:call-template>
			 <!-- Limit Details sub section -->
		    <xsl:call-template name="fieldset-wrapper">
			    <xsl:with-param name="legend">XSL_LIMIT_DETAILS</xsl:with-param>
		    	<xsl:with-param name="legend-type">indented-header</xsl:with-param>
		    	<xsl:with-param name="content">
		    		<xsl:choose>
		    		<xsl:when test="$isPreview = 'N'">
				    <xsl:call-template name="select-field">
				    	<xsl:with-param name="label">XSL_LIMIT_REFERENCE</xsl:with-param>
				     	<xsl:with-param name="name">limit_id</xsl:with-param>
				     	<xsl:with-param name="value"><xsl:value-of select="limit_details/limit_id"/></xsl:with-param>
				    </xsl:call-template>
				    
				    <xsl:call-template name="hidden-field">
				     	<xsl:with-param name="name">limit_reference</xsl:with-param>
				     	<xsl:with-param name="value"><xsl:value-of select="limit_details/limit_reference"/></xsl:with-param>
				    </xsl:call-template>
				    </xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="input-field">
						     	<xsl:with-param name="name">limit_reference</xsl:with-param>
 							   	<xsl:with-param name="label">XSL_LIMIT_REFERENCE</xsl:with-param>
						    	 <xsl:with-param name="value"><xsl:value-of select="limit_details/limit_reference"/></xsl:with-param>
					   		</xsl:call-template>
					   		<xsl:call-template name="hidden-field">
						     	<xsl:with-param name="name">limit_id</xsl:with-param>
						    	 <xsl:with-param name="value"><xsl:value-of select="limit_details/limit_id"/></xsl:with-param>
					   		</xsl:call-template>
						</xsl:otherwise>
			   		</xsl:choose>
				    
				    <xsl:call-template name="input-field">
				      <xsl:with-param name="label">XSL_LIMIT_DATE</xsl:with-param>
				      <xsl:with-param name="name">limit_review_date</xsl:with-param>
				      <xsl:with-param name="size">10</xsl:with-param>
				      <xsl:with-param name="maxsize">10</xsl:with-param>
				      <xsl:with-param name="type">date</xsl:with-param>
				      <xsl:with-param name="fieldsize">small</xsl:with-param>
				      <xsl:with-param name="readonly">Y</xsl:with-param>
				    </xsl:call-template>
				    
				    <xsl:if test="$displayAmount = 'Y'">
				    <xsl:call-template name="currency-field">
						<xsl:with-param name="label">XSL_FACILITY_OUTSTANDING</xsl:with-param>
						<xsl:with-param name="product-code">facility_outstanding</xsl:with-param>
						<xsl:with-param name="override-currency-value"><xsl:value-of select="cur_code"/></xsl:with-param>
						<xsl:with-param name="override-amt-name">facility_outstanding_amount</xsl:with-param>
						 <xsl:with-param name="currency-readonly">Y</xsl:with-param>
  						 <xsl:with-param name="amt-readonly">Y</xsl:with-param>
						<xsl:with-param name="show-button">N</xsl:with-param>
			  		</xsl:call-template>
			  		
				    <xsl:call-template name="currency-field">
						<xsl:with-param name="label">XSL_LIMIT_AMOUNT</xsl:with-param>
						<xsl:with-param name="product-code">limit</xsl:with-param>
						<xsl:with-param name="override-currency-value"><xsl:value-of select="cur_code"/></xsl:with-param>
						<xsl:with-param name="override-amt-name">limit_amount</xsl:with-param>
						 <xsl:with-param name="currency-readonly">Y</xsl:with-param>
  						 <xsl:with-param name="amt-readonly">Y</xsl:with-param>
						<xsl:with-param name="show-button">N</xsl:with-param>
			  		</xsl:call-template>
			  		
			  		<xsl:call-template name="currency-field">
						<xsl:with-param name="label">XSL_LIMIT_OUTSTANDING</xsl:with-param>
						<xsl:with-param name="product-code">limit_outstanding</xsl:with-param>
						<xsl:with-param name="override-currency-value"><xsl:value-of select="cur_code"/></xsl:with-param>
						<xsl:with-param name="override-amt-name">limit_outstanding_amount</xsl:with-param>
						 <xsl:with-param name="currency-readonly">Y</xsl:with-param>
  						 <xsl:with-param name="amt-readonly">Y</xsl:with-param>
						<xsl:with-param name="show-button">N</xsl:with-param>
			  		</xsl:call-template>
			  		</xsl:if>
			  		<xsl:call-template name="currency-field">
						<xsl:with-param name="label">XSL_BOOKING_AMOUNT</xsl:with-param>
						<xsl:with-param name="product-code">booking</xsl:with-param>
						<xsl:with-param name="override-currency-value"><xsl:value-of select="limit_details/cur_code"/></xsl:with-param>
						<xsl:with-param name="override-amt-name">booking_amt</xsl:with-param>
						 <xsl:with-param name="override-amt-value"><xsl:value-of select="/*/limit_details/booking_amt"/></xsl:with-param>
						<xsl:with-param name="show-button">N</xsl:with-param>
						<xsl:with-param name="currency-readonly">Y</xsl:with-param>
			  		</xsl:call-template>
  				</xsl:with-param>
  			</xsl:call-template>
  			<xsl:if test="$isBank = 'Y'">
	  			<script>
					dojo.ready(function(){
						misys._config = misys._config || {};
						 dojo.mixin(misys._config, {
						 
							facilityReviewDateCollection : {
								<xsl:for-each select="//facility_details/facility">
									'<xsl:value-of select="reference"/>' : '<xsl:value-of select="facility_date_element"/>'<xsl:if test="not(position()=last())">,</xsl:if>
								</xsl:for-each>
						}
					});
				});
			  </script>
		  </xsl:if>
		</xsl:with-param>
	 </xsl:call-template>
	</xsl:template>
	
 <xsl:template name="delivery-mode">
   <xsl:param name="option-required">Y</xsl:param>
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <xsl:if test="$option-required='N'">
      <option value=""></option>
     </xsl:if>
     	<xsl:if test="(product_code = 'SR')">
            <xsl:call-template name="code-data-options">
			 <xsl:with-param name="paramId">C086</xsl:with-param>
			 <xsl:with-param name="productCode">SR</xsl:with-param>
			 <xsl:with-param name="specificOrder">Y</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:when>
   </xsl:choose>
  </xsl:template>
    
 
 <xsl:template name="delivery-to">
  <xsl:param name="option-required">Y</xsl:param>
   <xsl:choose>
    <xsl:when test="$displaymode='edit'">
     <xsl:if test="$option-required='Y'">
      <option value=""></option>
     </xsl:if>
     	<xsl:if test="(product_code = 'SR')">
            <xsl:call-template name="code-data-options">
			 <xsl:with-param name="paramId">C087</xsl:with-param>
			 <xsl:with-param name="productCode">SR</xsl:with-param>
			 <xsl:with-param name="specificOrder">Y</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:when>
   </xsl:choose>
  </xsl:template>
  
  <xsl:template name="lc-reporting-credit-available-with-bank">
   <xsl:param name="theNodeName"/>
   <xsl:param name="required">N</xsl:param>
   <xsl:param name="show-button">Y</xsl:param>
    <!-- Swift Code -->
	<xsl:call-template name="input-field">
          <xsl:with-param name="label">XSL_PARTIESDETAILS_SWIFT_CODE</xsl:with-param>
          <xsl:with-param name="name"><xsl:value-of select="$theNodeName"/>_iso_code</xsl:with-param>
          <xsl:with-param name="value"><xsl:value-of select="credit_available_with_bank/iso_code" /></xsl:with-param>
    </xsl:call-template>
   <!-- Name. -->
	<xsl:call-template name="input-field">
	    <xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
	    <xsl:with-param name="name"><xsl:value-of select="$theNodeName"/>_name</xsl:with-param>
	    <xsl:with-param name="type"><xsl:if test="$show-button='Y'"><xsl:value-of select="$theNodeName"/></xsl:if></xsl:with-param>
	    <xsl:with-param name="button-type"><xsl:if test="$show-button='Y'"><xsl:value-of select="$theNodeName"/></xsl:if></xsl:with-param>
	    <xsl:with-param name="required" select="$required"/>
	    <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('NAME_TRADE_LENGTH')"/></xsl:with-param>
	    <xsl:with-param name="value"><xsl:value-of select="credit_available_with_bank/name"/></xsl:with-param>
	</xsl:call-template>
  	  <!-- Address. -->
	 <xsl:call-template name="input-field">
	    <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
	    <xsl:with-param name="name"><xsl:value-of select="$theNodeName"/>_address_line_1</xsl:with-param>
	    <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('ADDRESS1_TRADE_LENGTH')"/></xsl:with-param>
	    <xsl:with-param name="value"><xsl:value-of select="credit_available_with_bank/address_line_1" /></xsl:with-param>
	    <xsl:with-param name="required" select="$required"/>    
	 </xsl:call-template>
   	 <xsl:call-template name="input-field">
	    <xsl:with-param name="name"><xsl:value-of select="$theNodeName"/>_address_line_2</xsl:with-param>
	    <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('ADDRESS2_TRADE_LENGTH')"/></xsl:with-param>
	    <xsl:with-param name="value"><xsl:value-of select="credit_available_with_bank/address_line_2" /></xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
	    <xsl:with-param name="name"><xsl:value-of select="$theNodeName"/>_dom</xsl:with-param>
	    <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('DOM_TRADE_LENGTH')"/></xsl:with-param>
	    <xsl:with-param name="value"><xsl:value-of select="credit_available_with_bank/dom" /></xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
    	<xsl:with-param name="name"><xsl:value-of select="$theNodeName"/>_address_line_4</xsl:with-param>
    	<xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('ADDRESS4_TRADE_LENGTH')"/></xsl:with-param>
    	<xsl:with-param name="value"><xsl:value-of select="credit_available_with_bank/address_line_4" /></xsl:with-param>
     </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>
