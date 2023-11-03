<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 User Screen, System Form.

Copyright (c) 2000-2012 Misys (http://www.misys.com),
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
		xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		xmlns:gtpsecurity="xalan://com.misys.portal.security.GTPSecurity"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		exclude-result-prefixes="localization securitycheck utils defaultresource gtpsecurity">
		
		<xsl:variable name="opics_swift_flag" select="defaultresource:getResource('OPICS_SWIFT_ENABLED')='true'"/>

	<xsl:template name="beneficiary-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_BENEFICIARY_DETAILS</xsl:with-param>
	   		<xsl:with-param name="content">
		   		<xsl:call-template name="column-container">
					<xsl:with-param name="content">
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="appendClass">beneficiary-details-column-wrapper</xsl:with-param>
							<xsl:with-param name="content">
								<!-- Active Flag -->
					    		<xsl:choose>
					    				<xsl:when test= "$displaymode = 'edit'">
					    					<div id="active_flag_div">
						    					<xsl:call-template name="multichoice-field">
									     		<xsl:with-param name="type">checkbox</xsl:with-param>
									       	 	<xsl:with-param name="label">XSL_ACTIVE_FLAG</xsl:with-param>
									  	  		<xsl:with-param name="name">active_flag</xsl:with-param>
								   		 		</xsl:call-template>
							   		 		</div>
					    				</xsl:when>
					    				<xsl:otherwise>
					    					<div id="active_flag_div">
						    					<xsl:call-template name="input-field">
												<xsl:with-param name="label">XSL_ACTIVE_FLAG</xsl:with-param>
												<xsl:with-param name="name">active_flag</xsl:with-param>				
												<xsl:with-param name="value">
													<xsl:if test="active_flag[. = 'Y']"><xsl:value-of select="localization:getGTPString($language, 'XSL_YES')"/></xsl:if>
      												<xsl:if test="active_flag[. = 'N']"><xsl:value-of select="localization:getGTPString($language, 'XSL_NO')"/></xsl:if>
												</xsl:with-param>
												</xsl:call-template>
											</div>
					    				</xsl:otherwise>
					    		</xsl:choose>
								<!-- Left Column Section -->
								<!-- SWIFT BIC Code -->
					    		<div id="iso_code_div">
							  		<xsl:call-template name="input-field">
						      			<xsl:with-param name="label">XSL_BENEFICIARY_SWIFT_BIC_CODE</xsl:with-param>
						      			<xsl:with-param name="name">iso_code</xsl:with-param>
						      			<xsl:with-param name="value"><xsl:value-of select="./iso_code"/></xsl:with-param>
						      			<xsl:with-param name="size">11</xsl:with-param>
						       			<xsl:with-param name="maxsize">11</xsl:with-param>
						       			<xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
						       			<xsl:with-param name="swift-validate">N</xsl:with-param>
						    		</xsl:call-template>
						    		<xsl:if  test= "$displaymode = 'edit'">
							    		<xsl:call-template name="button-wrapper">
											<xsl:with-param name="label">XSL_ALT_BANK</xsl:with-param>
											<xsl:with-param name="show-image">Y</xsl:with-param>
											<xsl:with-param name="show-border">N</xsl:with-param>
											<xsl:with-param name="onclick">misys.setExecuteClientPassBack(true);misys.showSearchDialog('bank',"['counterparty_name', 'address_line_1', 'address_line_2', 'dom', 'iso_code', 'bank_contact_name', 'bank_phone']", {swiftcode: false, bankcode: false}, '', '', 'width:710px;height:350px;', '<xsl:value-of select="localization:getGTPString($language, 'LIST_TITLE_SDATA_LIST_OF_BANKS')"/>');return false;</xsl:with-param>
											<xsl:with-param name="id">iso_img</xsl:with-param>
											<xsl:with-param name="non-dijit-button">N</xsl:with-param>
											<xsl:with-param name="swift-validate">N</xsl:with-param>
									     </xsl:call-template>
								     </xsl:if>
					    		</div>
					    		<!-- Beneficiary Name -->
					   			<div id="counterparty_name_div">
							  		<xsl:call-template name="input-field">
						      			<xsl:with-param name="label">XSL_BENEFICIARY_NAME_SHORT</xsl:with-param>
						      			<xsl:with-param name="name">counterparty_name</xsl:with-param>
						      			<xsl:with-param name="value">
						      				<xsl:choose>
												<xsl:when test="$opics_swift_flag='true' and starts-with(./counterparty_name,'/')"><xsl:value-of select="substring(./counterparty_name,7)"/></xsl:when>
												<xsl:otherwise>
													<xsl:value-of select="./counterparty_name"/>
												</xsl:otherwise>
											</xsl:choose>
						      			</xsl:with-param>
						      			<xsl:with-param name="size">35</xsl:with-param>
						       			<xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('MAXIMUM_ALLOWED_BENEFICIARY_NAME')"/></xsl:with-param>
						       			<!-- <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_VALIDATION_REGEX')"/></xsl:with-param> -->
						       			<xsl:with-param name="required">Y</xsl:with-param>
						       			<xsl:with-param name="swift-validate">N</xsl:with-param>
						    		</xsl:call-template>
						    		<!--beneficiary name regex hidden field-->
									<xsl:call-template name="hidden-field">
											<xsl:with-param name="name">beneficiary_accname_regex_mups</xsl:with-param>
											<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_ACCOUNT_NAME_VALIDATION_REGEX_MUPS')"/></xsl:with-param>
									</xsl:call-template>
									<xsl:call-template name="hidden-field">
											<xsl:with-param name="name">beneficiary_accname_regex_meps</xsl:with-param>
											<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_ACCOUNT_NAME_VALIDATION_REGEX_MEPS')"/></xsl:with-param>
									</xsl:call-template>
									<xsl:call-template name="hidden-field">
											<xsl:with-param name="name">beneficiary_accname_regex_rtgs</xsl:with-param>
											<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_VALIDATION_REGEX_RTGS')"/></xsl:with-param>
									</xsl:call-template>									
									<xsl:if test="$beneficiaryNicknameEnabled = 'true'">
							    		<xsl:call-template name="input-field">
							      			<xsl:with-param name="label">XSL_BENEFICIARY_NICKNAME</xsl:with-param>
							      			<xsl:with-param name="name">counterparty_nickname</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./counterparty_nickname"/></xsl:with-param>
							      			<xsl:with-param name="size">35</xsl:with-param>
							       			<xsl:with-param name="maxsize">35</xsl:with-param>
							       			<xsl:with-param name="required">N</xsl:with-param>
							       			<xsl:with-param name="swift-validate">N</xsl:with-param>
							    		</xsl:call-template>
						    		</xsl:if>
					    		</div>
					    		<xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and (product_type[.='DD']))">
						    		<div id="counterparty_name_2_div">
							    		<xsl:call-template name="input-field">
							      			<xsl:with-param name="name">counterparty_name_2</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./counterparty_name_2"/></xsl:with-param>
							      			<xsl:with-param name="size">35</xsl:with-param>
							       			<xsl:with-param name="maxsize">35</xsl:with-param>
							       			<!-- <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_VALIDATION_REGEX')"/></xsl:with-param> -->
							       			<xsl:with-param name="swift-validate">N</xsl:with-param>
							    		</xsl:call-template>
						    		</div>
						    		<div id="counterparty_name_3_div">
							    		<xsl:call-template name="input-field">
							    			<xsl:with-param name="label">XSL_DD_NOT_APPLICABLE_LABEL</xsl:with-param>
							      			<xsl:with-param name="name">counterparty_name_3</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./counterparty_name_3"/></xsl:with-param>
							      			<xsl:with-param name="size">35</xsl:with-param>
							       			<xsl:with-param name="maxsize">35</xsl:with-param>
							       			<!-- <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_VALIDATION_REGEX')"/></xsl:with-param> -->
							       			<xsl:with-param name="swift-validate">N</xsl:with-param>
							    		</xsl:call-template>
						    		</div>
					    		</xsl:if>
					    		<!-- Beneficiary Address -->
					    		<xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and (product_type[.='MT101' or .='MT103' or .='MEPS' or 'RTGS' or .='FI103' or .='FI202' or .='DD' or .='TTPT' or .='TRSRY' or .='TRSRYFXFT']))">
					    		<div id="address_line_1_div">
						    		<xsl:choose>
										<xsl:when test="starts-with(./address_line_1,'/')">
										<xsl:call-template name="input-field">
							      			<xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
							      			<xsl:with-param name="name">address_line_1</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="substring(./address_line_1,7)"/></xsl:with-param>
							      			<xsl:with-param name="size">35</xsl:with-param>
							       			<xsl:with-param name="maxsize">35</xsl:with-param>
							       			<!-- <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_VALIDATION_ADDRESS_REGEX')"/></xsl:with-param> -->
							       			<xsl:with-param name="swift-validate">N</xsl:with-param>
							    		</xsl:call-template>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="input-field">
							      			<xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
							      			<xsl:with-param name="name">address_line_1</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./address_line_1"/></xsl:with-param>
							      			<xsl:with-param name="size">35</xsl:with-param>
							       			<xsl:with-param name="maxsize">35</xsl:with-param>
							       			<!-- <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_VALIDATION_ADDRESS_REGEX')"/></xsl:with-param> -->
							       			<xsl:with-param name="swift-validate">N</xsl:with-param>
							    		</xsl:call-template>
										</xsl:otherwise>
										</xsl:choose>					    				    	
						    	</div>	
						    		<div id="address_line_2_div">
						    		<xsl:choose>
										<xsl:when test="starts-with(./address_line_2,'/')">
										<xsl:call-template name="input-field">
							      			<xsl:with-param name="name">address_line_2</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="substring(./address_line_2,7)"/></xsl:with-param>
							      			<xsl:with-param name="size">35</xsl:with-param>
							       			<xsl:with-param name="maxsize">35</xsl:with-param>
							       			<!-- <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_VALIDATION_ADDRESS_REGEX')"/></xsl:with-param> -->
							       			<xsl:with-param name="swift-validate">N</xsl:with-param>
							    		</xsl:call-template>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="input-field">
							      			<xsl:with-param name="name">address_line_2</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./address_line_2"/></xsl:with-param>
							      			<xsl:with-param name="size">35</xsl:with-param>
							       			<xsl:with-param name="maxsize">35</xsl:with-param>
							       			<!-- <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_VALIDATION_ADDRESS_REGEX')"/></xsl:with-param> -->
							       			<xsl:with-param name="swift-validate">N</xsl:with-param>
							    		</xsl:call-template>
										</xsl:otherwise>
										</xsl:choose>					    				    	
						    	</div>	
						    							  			  
						    		<xsl:call-template name="hidden-field">
										<xsl:with-param name="name">beneficiary_addr_regex_meps</xsl:with-param>
										<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_VALIDATION_ADDRESS_REGEX_MEPS')"/></xsl:with-param>
									</xsl:call-template>
									<xsl:call-template name="hidden-field">
										<xsl:with-param name="name">beneficiary_addr_regex_rtgs</xsl:with-param>
										<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_VALIDATION_ADDRESS_REGEX_RTGS')"/></xsl:with-param>
									</xsl:call-template>	
									<xsl:call-template name="hidden-field">
										<xsl:with-param name="name">addressStartCharsRegex</xsl:with-param>
										<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_VALIDATION_START_ADDRESS_REGEX_RTGS')"/></xsl:with-param>
									</xsl:call-template>																    		
					    		</xsl:if>
					    		<xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and product_type[.='DD' or .='TTPT' or .='TRSRY'])">
						    		<div id="address_line_3_div">
							    		<xsl:call-template name="input-field">
							      			<xsl:with-param name="name">address_line_3</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./address_line_3"/></xsl:with-param>
							      			<xsl:with-param name="size">35</xsl:with-param>
							       			<xsl:with-param name="maxsize">35</xsl:with-param>
							       			<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_VALIDATION_ADDRESS_REGEX')"/></xsl:with-param>
							       			<xsl:with-param name="swift-validate">N</xsl:with-param>
							    		</xsl:call-template>
						    		</div>
					    		</xsl:if>
					    		<xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and (product_type[.='MT101' or .='MT103' or .='MEPS' or .='RTGS' or .='FI103' or .='FI202' or .='DD' or .='TTPT' or .='TRSRY' or .='TRSRYFXFT']))">
					    		<div id="dom_div"><xsl:choose>
										<xsl:when test="starts-with(./dom,'/')">
										<xsl:call-template name="input-field">
					      			<xsl:with-param name="name">dom</xsl:with-param>
					      			<xsl:with-param name="value"><xsl:value-of select="substring(./dom,7)"/></xsl:with-param>
					      			<xsl:with-param name="size">35</xsl:with-param>
					       			<xsl:with-param name="maxsize">35</xsl:with-param>
					       			<!-- <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_VALIDATION_ADDRESS_REGEX')"/></xsl:with-param> -->
					       			<xsl:with-param name="swift-validate">N</xsl:with-param>
					    		</xsl:call-template>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="input-field">
					      			<xsl:with-param name="name">dom</xsl:with-param>
					      			<xsl:with-param name="value"><xsl:value-of select="./dom"/></xsl:with-param>
					      			<xsl:with-param name="size">35</xsl:with-param>
					       			<xsl:with-param name="maxsize">35</xsl:with-param>
					       			<!-- <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_VALIDATION_ADDRESS_REGEX')"/></xsl:with-param> -->
					       			<xsl:with-param name="swift-validate">N</xsl:with-param>
					    		</xsl:call-template>
										</xsl:otherwise>
										</xsl:choose>					    				    	
						    	</div>	
					    		
					    		</xsl:if>
					    		
					    		<xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and product_type[.='RTGS' or .='MEPS'])">	
							    	<div id="bene_country_div">
					    				<xsl:call-template name="country-field">
							    			<xsl:with-param name="label">XSL_BENEFICIARY_COUNTRY</xsl:with-param>
							      			<xsl:with-param name="name">bene_country</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./bene_country"/></xsl:with-param>
							      			<xsl:with-param name="prefix">beneficiary_cntry</xsl:with-param>
							      			<xsl:with-param name="required">Y</xsl:with-param>
							    		</xsl:call-template>
							    	</div>
							    </xsl:if>	
							    
							    			    		
					    		<!-- Beneficiary Account -->

						    	<xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and product_type[.='TPT' or .='DOM' or .='MUPS'  or .='RTGS'or .='MT101' or .='MT103' or .='MEPS' or .='FI103' or .='TTPT' or .='TRSRY' or .='TRSRYFXFT' or .='HVPS' or .='HVXB'])">

					    		<div id="account_no_div">
					    			<xsl:call-template name="input-field">
					    				<xsl:with-param name="label">XSL_BENEFICIARY_ACCOUNT</xsl:with-param>
						      			<xsl:with-param name="name">account_no</xsl:with-param>
						      			<xsl:with-param name="value"><xsl:value-of select="./account_no"/></xsl:with-param>
						      			<xsl:with-param name="size">34</xsl:with-param>
						       			<xsl:with-param name="maxsize">34</xsl:with-param>
						       			<xsl:with-param name="fieldsize">bene-acc-medium</xsl:with-param>
						      			<xsl:with-param name="maxlength"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_ACCOUNT_NO_VALIDATION_REGEX')"/></xsl:with-param>
						       			<!-- <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_ACCOUNT_NO_VALIDATION_REGEX')"/></xsl:with-param> -->
						       			<xsl:with-param name="swift-validate">N</xsl:with-param>
						       			<xsl:with-param name="required">Y</xsl:with-param>
						    		</xsl:call-template>
					    			<xsl:call-template name="currency-field">
					    				<xsl:with-param name="label">XSL_BENEFICIARY_CURRENCY</xsl:with-param>
						      			<xsl:with-param name="product-code">account</xsl:with-param>
						      			<xsl:with-param name="show-amt">N</xsl:with-param>
						      			<xsl:with-param name="show-button">Y</xsl:with-param>
						      			<xsl:with-param name="required">Y</xsl:with-param>
						      			<xsl:with-param name="override-currency-value"><xsl:value-of select="./cur_code"/></xsl:with-param>
						      			<xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
						      			<xsl:with-param name="currency-readonly">Y</xsl:with-param>
						      			<xsl:with-param name="swift-validate">N</xsl:with-param>
						    		</xsl:call-template> 	
						    		<!-- This is needed for reauthentication -->
						    		<xsl:if test="$displaymode = 'view' ">
							    		<xsl:call-template name="hidden-field">
											<xsl:with-param name="name">account_no</xsl:with-param>
											<xsl:with-param name="value"><xsl:value-of select="./account_no"/></xsl:with-param>
										</xsl:call-template>
									</xsl:if>
									<xsl:call-template name="hidden-field">
											<xsl:with-param name="name">bene_nra_flag</xsl:with-param>
											<xsl:with-param name="value"><xsl:value-of select="bene_nra_flag"/></xsl:with-param>
										</xsl:call-template>
							    	<xsl:call-template name="hidden-field">
											<xsl:with-param name="name">beneficiary_account_regex_mups</xsl:with-param>
											<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_ACCOUNT_NO_VALIDATION_REGEX_MUPS')"/></xsl:with-param>
									</xsl:call-template>
									<xsl:call-template name="hidden-field">
											<xsl:with-param name="name">beneficiary_account_regex</xsl:with-param>
											<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_ACCOUNT_NO_VALIDATION_REGEX')"/></xsl:with-param>
									</xsl:call-template>
									<xsl:call-template name="hidden-field">
											<xsl:with-param name="name">beneficiary_account_regex_meps</xsl:with-param>
											<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_ACCOUNT_NO_VALIDATION_REGEX_MEPS')"/></xsl:with-param>
									</xsl:call-template>									
									<xsl:call-template name="hidden-field">
											<xsl:with-param name="name">beneficiary_account_regex_rtgs</xsl:with-param>
											<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_ACCOUNT_NO_VALIDATION_REGEX_RTGS')"/></xsl:with-param>
									</xsl:call-template>
					    		</div>
					    		</xsl:if>
					    	    <xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and product_type[.='FI202'])">
						    		<div id="account_no_mt202_div">
						    			<xsl:call-template name="input-field">
						    				<xsl:with-param name="label">XSL_BENEFICIARY_INSTITUTION_ACCOUNT</xsl:with-param>
							      			<xsl:with-param name="name">account_no_mt202</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./account_no"/></xsl:with-param>
							      			<xsl:with-param name="size">34</xsl:with-param>
							       			<xsl:with-param name="maxsize">34</xsl:with-param>
							       			<xsl:with-param name="swift-validate">Y</xsl:with-param>
							       			<xsl:with-param name="required">N</xsl:with-param>
							       			<!-- <xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('BENEFICIARY_ACCOUNT_NO_VALIDATION_REGEX')"/></xsl:with-param> -->
							    		</xsl:call-template>
							    		<!-- This is needed for reauthentication -->
							    		<xsl:if test="$displaymode = 'view' ">
							    		<xsl:call-template name="hidden-field">
											<xsl:with-param name="name">account_no_mt202</xsl:with-param>
											<xsl:with-param name="value"><xsl:value-of select="./account_no"/></xsl:with-param>
										</xsl:call-template>
										</xsl:if>
						    		</div>
					    	   </xsl:if>
					    			
					    		<xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and product_type[.='DD' or .='TRSRY' or .='TRSRYFXFT'])">	
							    	<div id="bene_details_country_div">
					    				<xsl:call-template name="country-field">
							    			<xsl:with-param name="label">XSL_BENEFICIARY_COUNTRY</xsl:with-param>
							      			<xsl:with-param name="name">bene_details_country</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./bene_details_country"/></xsl:with-param>
							      			<xsl:with-param name="prefix">bene_details</xsl:with-param>
							      			<xsl:with-param name="appendClass">inlineBlock beneAdvCountry</xsl:with-param>
							    		</xsl:call-template>
							    	</div>	
							    	</xsl:if>
							    <xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and product_type[.='TRSRYFXFT'] )">
							    	<div id="bene_details_clrc_div">
							    	 <xsl:call-template name="select-field">
							    	  <xsl:with-param name="label">XSL_CLEARING_CODE</xsl:with-param>	
							    		<xsl:with-param name="name">bene_details_clrc</xsl:with-param>
							    		<xsl:with-param name="value"><xsl:value-of select="./bene_details_clrc"/></xsl:with-param>
									   <xsl:with-param name="options">
									   <option>
					    			    <xsl:attribute name="value"><xsl:value-of select="./bene_details_clrc"/></xsl:attribute>
					    			    <xsl:value-of select="utils:getDescFromClearingCode(./bene_details_clrc,$rundata)"/>
					   				   </option>
									    </xsl:with-param>
									  </xsl:call-template>
									  </div>
									  </xsl:if>
							    	<xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and product_type[.='DD'])">	
							    	<div id="bene_details_postal_code_div">
							    		<xsl:call-template name="input-field">
							      			<xsl:with-param name="label">XSL_BENEFICIARY_POSTAL_CODE</xsl:with-param>
							      			<xsl:with-param name="name">bene_details_postal_code</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./bene_details_postal_code"/></xsl:with-param>
							      			<xsl:with-param name="size">15</xsl:with-param>
							       			<xsl:with-param name="maxsize">15</xsl:with-param>
							       			<xsl:with-param name="fieldsize">small</xsl:with-param>
							       			<xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
							    		</xsl:call-template>
							    	</div>	
							    </xsl:if>
							    <xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and product_type[.='TRSRY' or .='TRSRYFXFT'] )">
						    		<!-- bank routing number -->
						    		<div id="bank_routing_no_div">
									<xsl:call-template name="input-field">
										<xsl:with-param name="name">bank_routing_no</xsl:with-param>
										<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_BENEFICIARY_BANK_ACCOUNT</xsl:with-param>
										<xsl:with-param name="value"><xsl:value-of select="./bank_routing_no"/></xsl:with-param>
										<xsl:with-param name="maxsize">33</xsl:with-param>
									</xsl:call-template>
									</div>
									<div id="ordering_customer_name_div">
									<xsl:choose>
										<xsl:when test="starts-with(./ordering_customer_name,'/')">
										<xsl:call-template name="input-field">
							      			<xsl:with-param name="name">ordering_customer_name</xsl:with-param>
							      			<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_ORDERING</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="substring(./ordering_customer_name,7)"/></xsl:with-param>
							      			<xsl:with-param name="size">35</xsl:with-param>
							       			<xsl:with-param name="maxsize">35</xsl:with-param>
							    		</xsl:call-template>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="input-field">
							      			<xsl:with-param name="name">ordering_customer_name</xsl:with-param>
							      			<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_ORDERING</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./ordering_customer_name"/></xsl:with-param>
							      			<xsl:with-param name="size">35</xsl:with-param>
							       			<xsl:with-param name="maxsize">35</xsl:with-param>
							    		</xsl:call-template>
										</xsl:otherwise>
										</xsl:choose>
										</div>
										
										<div id="ordering_customer_address_1_div">
									<xsl:choose>
										<xsl:when test="starts-with(./ordering_customer_address_1,'/')">
										<xsl:call-template name="input-field">
							      			<xsl:with-param name="name">ordering_customer_address_1</xsl:with-param>
							      			<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_ORDERING_ADDRESS</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="substring(./ordering_customer_address_1,7)"/></xsl:with-param>
							      			<xsl:with-param name="size">35</xsl:with-param>
							       			<xsl:with-param name="maxsize">35</xsl:with-param>
							    		</xsl:call-template>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="input-field">
							      			<xsl:with-param name="name">ordering_customer_address_1</xsl:with-param>
							      			<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_ORDERING_ADDRESS</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./ordering_customer_address_1"/></xsl:with-param>
							      			<xsl:with-param name="size">35</xsl:with-param>
							       			<xsl:with-param name="maxsize">35</xsl:with-param>
							    		</xsl:call-template>
										</xsl:otherwise>
										</xsl:choose>
										</div>
						    								    							    		
						    		<xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and product_type[.='TRSRYFXFT'] )">
						    		<div id="ordering_customer_address_2_div">
							    		<xsl:choose>
										<xsl:when test="starts-with(./ordering_customer_address_2,'/')">
										<xsl:call-template name="input-field">
							      			<xsl:with-param name="name">ordering_customer_address_2</xsl:with-param>
							      			<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_ORDERING_ADDRESS_2</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="substring(./ordering_customer_address_2,7)"/></xsl:with-param>
							      			<xsl:with-param name="size">35</xsl:with-param>
							       			<xsl:with-param name="maxsize">35</xsl:with-param>
							    		</xsl:call-template>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="input-field">
							      			<xsl:with-param name="name">ordering_customer_address_2</xsl:with-param>
							      			<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_ORDERING_ADDRESS_2</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./ordering_customer_address_2"/></xsl:with-param>
							      			<xsl:with-param name="size">35</xsl:with-param>
							       			<xsl:with-param name="maxsize">35</xsl:with-param>
							    		</xsl:call-template>
										</xsl:otherwise>
										</xsl:choose>
										</div>
						    		</xsl:if>
						    		
						    		<div id="ordering_customer_dom_div">
							    		<xsl:choose>
										<xsl:when test="starts-with(./ordering_customer_dom,'/')">
										<xsl:call-template name="input-field">
							      			<xsl:with-param name="name">ordering_customer_dom</xsl:with-param>
							      			<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_ORDERING_CITY</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="substring(./ordering_customer_dom,7)"/></xsl:with-param>
							      			<xsl:with-param name="size">32</xsl:with-param>
							       			<xsl:with-param name="maxsize">32</xsl:with-param>
							    		</xsl:call-template>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="input-field">
							      			<xsl:with-param name="name">ordering_customer_dom</xsl:with-param>
							      			<xsl:with-param name="label">XSL_SETTLEMENT_DETAILS_ORDERING_CITY</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./ordering_customer_dom"/></xsl:with-param>
							      			<xsl:with-param name="size">32</xsl:with-param>
							       			<xsl:with-param name="maxsize">32</xsl:with-param>
							    		</xsl:call-template>
										</xsl:otherwise>
										</xsl:choose>
										</div>
										
										<div id="ordering_customer_country_div">
							    		<xsl:call-template name="country-field">
							    			<xsl:with-param name="label">XSL_BENEFICIARY_COUNTRY</xsl:with-param>
							      			<xsl:with-param name="prefix">ordering_customer</xsl:with-param>
							      			<xsl:with-param name="name">ordering_customer_country</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./ordering_customer_country"/></xsl:with-param>
							    		</xsl:call-template>
						    		</div>								
																		
						    		<xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and product_type[.='TRSRYFXFT'] )">
							    	<div id="order_details_clrc_div">
							    	 <xsl:call-template name="select-field">
							    		<xsl:with-param name="name">order_details_clrc</xsl:with-param>
							    		<xsl:with-param name="value"><xsl:value-of select="./order_details_clrc"/></xsl:with-param>
									    <xsl:with-param name="label">XSL_CLEARING_CODE</xsl:with-param>		
									     <xsl:with-param name="options">
										   <option>
						    			    <xsl:attribute name="value"><xsl:value-of select="./order_details_clrc"/></xsl:attribute>
						    			    <xsl:value-of select="utils:getDescFromClearingCode(./order_details_clrc,$rundata)"/>
						   				   </option>
									    </xsl:with-param>
									    </xsl:call-template>
									  </div>
									  </xsl:if>
						    		<!-- ordering customer account number -->
									<div id="order_customer_act_no_div">
										<xsl:call-template name="input-field">
											<xsl:with-param name="name">ordering_customer_act_no</xsl:with-param>
											<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_ORDERING_ACCOUNT_NO</xsl:with-param>
											<xsl:with-param name="value"><xsl:value-of select="./ordering_customer_act_no"/></xsl:with-param>
											<xsl:with-param name="maxsize">33</xsl:with-param>
										</xsl:call-template>
									</div>
									<!--  swift charges type -->
									<div id="swift_charges_type_div">
									    <xsl:call-template name="multioption-group">
									     <xsl:with-param name="group-label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_SWIFT_CHARGE_RADIO_FIELDS_ACTION_LABEL</xsl:with-param>
									     <xsl:with-param name="content">
									      <xsl:call-template name="radio-field">
									       <xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_APPLICANT_LABEL</xsl:with-param>
									       <xsl:with-param name="name">swift_charges_type</xsl:with-param>
									       <xsl:with-param name="id">swift_charges_type_1</xsl:with-param>
									       <xsl:with-param name="value">01</xsl:with-param>
									       <xsl:with-param name="checked"><xsl:if test="swift_charges_type = '01' or not(swift_charges_type)">Y</xsl:if></xsl:with-param>
									      </xsl:call-template>
									      <xsl:call-template name="radio-field">
									       <xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_BENEFICIARY_LABEL</xsl:with-param>
									       <xsl:with-param name="name">swift_charges_type</xsl:with-param>
									       <xsl:with-param name="id">swift_charges_type_2</xsl:with-param>
									       <xsl:with-param name="value">02</xsl:with-param>
									       <xsl:with-param name="checked"><xsl:if test="swift_charges_type = '02'">Y</xsl:if></xsl:with-param>
									      </xsl:call-template>
										  <xsl:call-template name="radio-field">
									       <xsl:with-param name="label">XSL_SI_FREE_FORMAT_INSTRUCTIONS_SHARED_LABEL</xsl:with-param>
									       <xsl:with-param name="name">swift_charges_type</xsl:with-param>
									       <xsl:with-param name="id">swift_charges_type_3</xsl:with-param>
									       <xsl:with-param name="value">05</xsl:with-param>
									       <xsl:with-param name="checked"><xsl:if test="swift_charges_type = '05'">Y</xsl:if></xsl:with-param>
									      </xsl:call-template>
										</xsl:with-param>
									   </xsl:call-template>
									</div>
						    	</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="appendClass">width50per</xsl:with-param>
							<xsl:with-param name="content">
								<xsl:variable name="label">XSL_BENEFICIARY_ACCOUNT_WITH_INSTITUTION</xsl:variable>
								<!-- Right Column Section -->
								<!-- Account With Institution Header -->
								<xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and product_type[.='FI202'])">
									<div class="field" id="account_with_institution_div">
										<strong><xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_ACCOUNT_WITH_INSTITUTION')"/></strong>
									</div>
								</xsl:if>
								<!-- BANK SWIFT BIC Code -->
								 <xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and product_type[.='MUPS'])">
						    		<div id="bank_ifsc_code_div">
								  		<xsl:call-template name="input-field">
							      			<xsl:with-param name="label">XSL_BENEFICIARY_IFSC_CODE</xsl:with-param>
							      			<xsl:with-param name="name">bank_ifsc_code</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./bank_iso_code"/></xsl:with-param>
							      			<xsl:with-param name="size">11</xsl:with-param>
							       			<xsl:with-param name="maxsize">11</xsl:with-param>
							       			<xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
							       			<xsl:with-param name="swift-validate">N</xsl:with-param>
							    		</xsl:call-template>
							    		<xsl:if  test= "$displaymode = 'edit'">
								    		<xsl:call-template name="button-wrapper">
												<xsl:with-param name="label">XSL_ALT_BANK</xsl:with-param>
												<xsl:with-param name="show-image">Y</xsl:with-param>
												<xsl:with-param name="show-border">N</xsl:with-param>
												<xsl:with-param name="onclick"> misys.showProductBasedListOfBanksforMUPS();return false;</xsl:with-param>
												<xsl:with-param name="id">bank_ifsc_img</xsl:with-param>
												<xsl:with-param name="non-dijit-button">N</xsl:with-param>
												<xsl:with-param name="swift-validate">N</xsl:with-param>
											</xsl:call-template>
										</xsl:if>
						    		</div>
						    		<div id="bank_ifsc_name_div">
						    		<xsl:if test="$displaymode = 'edit'">	
							    		<xsl:call-template name="input-field">
								      			<xsl:with-param name="label">XSL_BENEFICIARY_IFSC_BANK_NAME</xsl:with-param>
								      			<xsl:with-param name="name">bank_ifsc_name</xsl:with-param>
								      			<xsl:with-param name="value"><xsl:value-of select="./bank_name"/></xsl:with-param>
								      			<xsl:with-param name="size">35</xsl:with-param>
								       			<xsl:with-param name="maxsize">35</xsl:with-param>
								       			<xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
								       			<xsl:with-param name="readonly">Y</xsl:with-param>
								       			<xsl:with-param name="swift-validate">Y</xsl:with-param>
								    		</xsl:call-template>
								    	</xsl:if>
								    	<xsl:if test="$displaymode = 'view' and product_type[.='MUPS']">
											<table cellspacing="0" cellpadding="0" border="0">
												<tr>
													<td class="label" style="text-align:right;"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENEFICIARY_IFSC_BANK_NAME')"/></td>
													<td class="content" style="float:right;clear:right;min-width:100px;max-width:500px;word-wrap: break-word"><xsl:value-of select="./bank_name"/></td>
												</tr>
											</table>
					  					 </xsl:if>
						 			</div>
							    	<div id="bank_ifsc_address_line_1_div">
							    		<xsl:call-template name="input-field">
							    			<xsl:with-param name="label">XSL_BENEFICIARY_IFSC_BANK_ADDRESS</xsl:with-param>
							      			<xsl:with-param name="name">bank_ifsc_address_line_1</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./bank_address_line_1"/></xsl:with-param>
							      			<xsl:with-param name="size">35</xsl:with-param>
							       			<xsl:with-param name="maxsize">35</xsl:with-param>
							       			<xsl:with-param name="readonly">Y</xsl:with-param>
							       			<xsl:with-param name="swift-validate">N</xsl:with-param>
							    		</xsl:call-template>
						    		</div>
						    		<div id="bank_ifsc_address_line_2_div">
							    		<xsl:call-template name="input-field">
							      			<xsl:with-param name="name">bank_ifsc_address_line_2</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./bank_address_line_2"/></xsl:with-param>
							      			<xsl:with-param name="size">35</xsl:with-param>
							       			<xsl:with-param name="maxsize">35</xsl:with-param>
							       			<xsl:with-param name="readonly">Y</xsl:with-param>
							       			<xsl:with-param name="swift-validate">N</xsl:with-param>
							    		</xsl:call-template>
						    		</div>
						    		<div id="bank_ifsc_city_div">
						    		<xsl:call-template name="input-field">
							      			<xsl:with-param name="label">XSL_BENEFICIARY_IFSC_CITY</xsl:with-param>
							      			<xsl:with-param name="name">bank_ifsc_city</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./bank_dom"/></xsl:with-param>
							      			<xsl:with-param name="size">35</xsl:with-param>
							       			<xsl:with-param name="maxsize">35</xsl:with-param>
							       			<xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
							       			<xsl:with-param name="readonly">Y</xsl:with-param>
							       			<xsl:with-param name="swift-validate">N</xsl:with-param>
							    		</xsl:call-template>
							    		</div>
					    		</xsl:if>
								<xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and (product_type[.='MT101' or .='MT103' or .='FI103' or .='FI202' or .='TRSRY' or .='TRSRYFXFT']))">
						    		<div id="bank_iso_code_div">
								  		<xsl:call-template name="input-field">
							      			<xsl:with-param name="label">XSL_BENEFICIARY_SWIFT_BIC_CODE</xsl:with-param>
							      			<xsl:with-param name="name">bank_iso_code</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./bank_iso_code"/></xsl:with-param>
							      			<xsl:with-param name="size">11</xsl:with-param>
							       			<xsl:with-param name="maxsize">11</xsl:with-param>
							       			<xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
							       			<xsl:with-param name="swift-validate">N</xsl:with-param>
							    		</xsl:call-template>
							    		<xsl:if  test= "$displaymode = 'edit'">
								    		<xsl:call-template name="button-wrapper">
												<xsl:with-param name="label">XSL_ALT_BANK</xsl:with-param>
												<xsl:with-param name="show-image">Y</xsl:with-param>
												<xsl:with-param name="show-border">N</xsl:with-param>
												<xsl:with-param name="onclick"> misys.showProductBasedListOfBanks();return false;</xsl:with-param>
												<xsl:with-param name="id">bank_iso_img</xsl:with-param>
												<xsl:with-param name="non-dijit-button">N</xsl:with-param>
												<xsl:with-param name="swift-validate">N</xsl:with-param>
											</xsl:call-template>
										</xsl:if>
						    		</div>
					    		</xsl:if>
					    		<xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and (product_type[.='MEPS']))">
						    		<div id="bank_iso_code_meps_div">
								  		<xsl:call-template name="input-field">
							      			<xsl:with-param name="label">XSL_BENEFICIARY_SWIFT_BIC_CODE</xsl:with-param>
							      			<xsl:with-param name="name">bank_iso_code_meps</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./bank_iso_code"/></xsl:with-param>
							      			<xsl:with-param name="size">11</xsl:with-param>
							       			<xsl:with-param name="maxsize">11</xsl:with-param>
							       			<xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
							       			<xsl:with-param name="swift-validate">N</xsl:with-param>
							    		</xsl:call-template>
							    		<xsl:if  test= "$displaymode = 'edit'">
								    		<xsl:call-template name="button-wrapper">
												<xsl:with-param name="label">XSL_ALT_BANK</xsl:with-param>
												<xsl:with-param name="show-image">Y</xsl:with-param>
												<xsl:with-param name="show-border">N</xsl:with-param>
												<xsl:with-param name="onclick"> misys.showProductBasedListOfBanksforMeps();return false;</xsl:with-param>
												<xsl:with-param name="id">bank_iso_img_meps</xsl:with-param>
												<xsl:with-param name="non-dijit-button">N</xsl:with-param>
												<xsl:with-param name="swift-validate">N</xsl:with-param>
											</xsl:call-template>
										</xsl:if>
						    		</div>
					    		</xsl:if>
					    		<xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and (product_type[.='RTGS']))">
						    		<div id="bank_bic_code_rtgs_div">
								  		<xsl:call-template name="input-field">
							      			<xsl:with-param name="label">XSL_BENEFICIARY_SWIFT_BIC_CODE</xsl:with-param>
							      			<xsl:with-param name="name">bank_bic_code_rtgs</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./bank_iso_code"/></xsl:with-param>
							      			<xsl:with-param name="size">11</xsl:with-param>
							       			<xsl:with-param name="maxsize">11</xsl:with-param>
							       			<xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
							       			<xsl:with-param name="swift-validate">N</xsl:with-param>
							    		</xsl:call-template>
							    		<xsl:if  test= "$displaymode = 'edit'">
								    		<xsl:call-template name="button-wrapper">
												<xsl:with-param name="label">XSL_ALT_BANK</xsl:with-param>
												<xsl:with-param name="show-image">Y</xsl:with-param>
												<xsl:with-param name="show-border">N</xsl:with-param>
												<xsl:with-param name="onclick"> misys.showProductBasedListOfBanksforRTGS();return false;</xsl:with-param>
												<xsl:with-param name="id">bank_bic_img_rtgs</xsl:with-param>
												<xsl:with-param name="non-dijit-button">N</xsl:with-param>
												<xsl:with-param name="swift-validate">N</xsl:with-param>
											</xsl:call-template>
										</xsl:if>
						    		</div>
					    		</xsl:if>					    								    		
					    		<!-- BRANCH BANK CODE -->
					    		<xsl:if test="$displaymode = 'edit'">
						    		<div id="bank_code_div">
								  		<xsl:call-template name="input-field">
							      			<xsl:with-param name="label">XSL_BENEFICIARY_BRANCH_BANK_CODE</xsl:with-param>
							      			<xsl:with-param name="name">bank_code</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./bank_code"/></xsl:with-param>
							      			<xsl:with-param name="size">4</xsl:with-param>
							       			<xsl:with-param name="maxsize">4</xsl:with-param>
							       			<xsl:with-param name="fieldsize">xx-small</xsl:with-param>
							       			<xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
							       			<xsl:with-param name="readonly">N</xsl:with-param>
							       			<xsl:with-param name="swift-validate">N</xsl:with-param>
							    		</xsl:call-template>
							    		<xsl:call-template name="input-field">
							    			<xsl:with-param name="label"></xsl:with-param>
							      			<xsl:with-param name="name">brch_code</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./brch_code"/></xsl:with-param>
							      			<xsl:with-param name="size">3</xsl:with-param>
							       			<xsl:with-param name="maxsize">3</xsl:with-param>
							       			<xsl:with-param name="fieldsize">xx-small</xsl:with-param>
							       			<xsl:with-param name="appendClass">inlineBlock inlineBlockNoLabel</xsl:with-param>
							       			<xsl:with-param name="readonly">N</xsl:with-param>
							       			<xsl:with-param name="swift-validate">N</xsl:with-param>
							    		</xsl:call-template>
							    		<xsl:if  test= "$displaymode = 'edit'">
								    		<xsl:call-template name="button-wrapper">
												<xsl:with-param name="show-image">Y</xsl:with-param>
												<xsl:with-param name="show-border">N</xsl:with-param>
												<xsl:with-param name="onclick">misys.showBankBranchCodeDialog('bank_branch_code', "['bank_code', 'brch_code', 'branch_name','bank_name']", '', '', 'N', '', 'width:710px;height:350px;', '<xsl:value-of select="localization:getGTPString($language, 'LIST_TITLE_SDATA_LIST_OF_BANKS')"/>',false);return false;</xsl:with-param>
												<xsl:with-param name="id">beneficiary_img</xsl:with-param>
												<xsl:with-param name="non-dijit-button">N</xsl:with-param>
											</xsl:call-template>
										</xsl:if>
						    		</div>
					    		</xsl:if>

					    		<!-- CNAPS BANK CODE and NAME -->
					    		<xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and product_type[.='HVPS' or .='HVXB'])">
						    		<div id="cnaps_bank_code_div">
								  		<xsl:call-template name="input-field">
							      			<xsl:with-param name="label">XSL_BENEFICIARY_CNAPS_BANK_CODE</xsl:with-param>
							      			<xsl:with-param name="name">cnaps_bank_code</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./cnaps_bank_code"/></xsl:with-param>
							      			<xsl:with-param name="size">14</xsl:with-param>
							       			<xsl:with-param name="maxsize">14</xsl:with-param>
							       			<xsl:with-param name="fieldsize">small</xsl:with-param>
							       			<xsl:with-param name="required">Y</xsl:with-param>
							       			<xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
							       			<xsl:with-param name="readonly">N</xsl:with-param>
							       			<xsl:with-param name="swift-validate">N</xsl:with-param>
							    		</xsl:call-template>
										
										<xsl:if test="$displaymode='edit'">
											<xsl:call-template name="button-wrapper">
												<xsl:with-param name="label">XSL_ALT_BENEFICIARY</xsl:with-param>
												<xsl:with-param name="show-image">Y</xsl:with-param>
												<xsl:with-param name="show-border">N</xsl:with-param>
												<xsl:with-param name="id">cnaps_bank_code_img</xsl:with-param>
											</xsl:call-template>
										</xsl:if>
									</div>
					    		</xsl:if>					    		
							<!-- BANK NAME -->
					    		<xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and product_type[.='MT101' or .='MT103' or .='FI103' or .='TRSRYFXFT' or .='FI202' or .='TRSRY'or .='RTGS'or .='MEPS' ])">
									<div id="bank_name_div">
							    		<xsl:choose>
										<xsl:when test="starts-with(./bank_name,'/')">
										<xsl:call-template name="input-field">
							      			<xsl:with-param name="label">XSL_BENEFICIARY_BANK_NAME</xsl:with-param>
							      			<xsl:with-param name="name">bank_name</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="substring(./bank_name,7)"/></xsl:with-param>
							      			<xsl:with-param name="size">35</xsl:with-param>
							       			<xsl:with-param name="maxsize">35</xsl:with-param>
							       			<xsl:with-param name="swift-validate">N</xsl:with-param>
							    		</xsl:call-template>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="input-field">
							      			<xsl:with-param name="label">XSL_BENEFICIARY_BANK_NAME</xsl:with-param>
							      			<xsl:with-param name="name">bank_name</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./bank_name"/></xsl:with-param>
							      			<xsl:with-param name="size">35</xsl:with-param>
							       			<xsl:with-param name="maxsize">35</xsl:with-param>
							       			<xsl:with-param name="swift-validate">N</xsl:with-param>
							    		</xsl:call-template>
										</xsl:otherwise>
										</xsl:choose>
										</div>
					    		</xsl:if>

					    		<!-- CNAPS BANK NAME -->
					    		<xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and product_type[.='HVPS' or .='HVXB'])">
						    		<div id="cnaps_bank_name_div">
								  		<xsl:call-template name="input-field">
							      			<xsl:with-param name="label">XSL_BENEFICIARY_BANK_NAME</xsl:with-param>
							      			<xsl:with-param name="name">cnaps_bank_name</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./cnaps_bank_name"/></xsl:with-param>
							      			<xsl:with-param name="size">140</xsl:with-param>
							       			<xsl:with-param name="maxsize">140</xsl:with-param>
							       			<xsl:with-param name="readonly">Y</xsl:with-param>
							       			<xsl:with-param name="swift-validate">N</xsl:with-param>
							    		</xsl:call-template>
						    		</div>
					    		</xsl:if>

					    		<!-- BANK ADDRESS -->
					    		<xsl:if test="$displaymode = 'edit'">
						    		<div id="branch_name_div">
							    		<xsl:call-template name="input-field">
							    			<xsl:with-param name="label">XSL_BRANCH_NAME</xsl:with-param>
							      			<xsl:with-param name="name">branch_name</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./branch_name"/></xsl:with-param>
							      			<xsl:with-param name="size">35</xsl:with-param>
							       			<xsl:with-param name="maxsize">35</xsl:with-param>
							       			<xsl:with-param name="swift-validate">N</xsl:with-param>
							    		</xsl:call-template>
						    		</div>
					    		</xsl:if>
					    		<!-- BANK ADDRESS -->
					    		<xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and product_type[.='MT101' or .='MT103' or .='RTGS' or .='FI103' or .='FI202' or .='MEPS' or .='TRSRY' or .='TRSRYFXFT'])">
					    		<div id="bank_address_line_1_div">
							    		<xsl:choose>
										<xsl:when test="starts-with(./bank_address_line_1,'/')">
										<xsl:call-template name="input-field">
							    			<xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
							      			<xsl:with-param name="name">bank_address_line_1</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="substring(./bank_address_line_1,7)"/></xsl:with-param>
							      			<xsl:with-param name="size">35</xsl:with-param>
							       			<xsl:with-param name="maxsize">35</xsl:with-param>
							       			<xsl:with-param name="swift-validate">N</xsl:with-param>
							    		</xsl:call-template>
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="input-field">
							    			<xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
							      			<xsl:with-param name="name">bank_address_line_1</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./bank_address_line_1"/></xsl:with-param>
							      			<xsl:with-param name="size">35</xsl:with-param>
							       			<xsl:with-param name="maxsize">35</xsl:with-param>
							       			<xsl:with-param name="swift-validate">N</xsl:with-param>
							    		</xsl:call-template>
										</xsl:otherwise>
										</xsl:choose>
										</div>
										<div id="bank_address_line_2_div">
							    		<xsl:call-template name="input-field">
							      			<xsl:with-param name="name">bank_address_line_2</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./bank_address_line_2"/></xsl:with-param>
							      			<xsl:with-param name="size">35</xsl:with-param>
							       			<xsl:with-param name="maxsize">35</xsl:with-param>
							       			<xsl:with-param name="swift-validate">N</xsl:with-param>
							    		</xsl:call-template>
						    			</div>
										<div id="bank_dom_div">
							    		<xsl:choose>
										<xsl:when test="starts-with(./bank_dom,'/')">
										<xsl:call-template name="input-field">
							      			<xsl:with-param name="name">bank_dom</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="substring(./bank_dom,7)"/></xsl:with-param>
							      			<xsl:with-param name="size">32</xsl:with-param>
							       			<xsl:with-param name="maxsize">32</xsl:with-param>
							       			<xsl:with-param name="swift-validate">N</xsl:with-param>
							    		</xsl:call-template>
										</xsl:when>
										<xsl:when test="product_type[.='TRSRY']">
										<xsl:call-template name="input-field">
							      			<xsl:with-param name="name">bank_dom</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./bank_dom"/></xsl:with-param>
							      			<xsl:with-param name="size">32</xsl:with-param>
							       			<xsl:with-param name="maxsize">32</xsl:with-param>
							       			<xsl:with-param name="swift-validate">N</xsl:with-param>
							    		</xsl:call-template>										
										</xsl:when>
										<xsl:otherwise>
											<xsl:call-template name="input-field">
							      			<xsl:with-param name="name">bank_dom</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./bank_dom"/></xsl:with-param>
							      			<xsl:with-param name="size">35</xsl:with-param>
							       			<xsl:with-param name="maxsize">35</xsl:with-param>
							       			<xsl:with-param name="swift-validate">N</xsl:with-param>
							    		</xsl:call-template>
										</xsl:otherwise>
										</xsl:choose>
										</div>
					    		</xsl:if>
					    							    		 		
					    		<!-- Beneficiary Country -->
					    		<xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and product_type[.='MT101' or .='MT103' or .='RTGS' or .='FI103' or .='FI202' or .='MEPS' or .='TRSRY' or .='TRSRYFXFT' ])">
						    		<div id="bank_country_div">
							    		<xsl:call-template name="country-field">
							    			<xsl:with-param name="label">XSL_BENEFICIARY_COUNTRY</xsl:with-param>
							      			<xsl:with-param name="name">country</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./country"/></xsl:with-param>
							      			<xsl:with-param name="prefix">bank</xsl:with-param>
							    		</xsl:call-template>
						    		</div>
					    		</xsl:if>
					    		<xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and product_type[.='TRSRYFXFT'] )">
										<div id="beneficiary_bank_clrc_div">
										  	 <xsl:call-template name="select-field">
										  	 	<xsl:with-param name="name">beneficiary_bank_clrc</xsl:with-param>
										  	 	<xsl:with-param name="value"><xsl:value-of select="./beneficiary_bank_clrc"/></xsl:with-param>
											    <xsl:with-param name="label">XSL_CLEARING_CODE</xsl:with-param>	
											    <xsl:with-param name="options">
												   <option>
								    			    <xsl:attribute name="value"><xsl:value-of select="./beneficiary_bank_clrc"/></xsl:attribute>
								    			    <xsl:value-of select="utils:getDescFromClearingCode(./beneficiary_bank_clrc,$rundata)"/>
								   				   </option>
											    </xsl:with-param>	
											    </xsl:call-template>
									    </div>					    	
	    						</xsl:if>
					    		
					    		
					    		
					    		<xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and product_type[ .='RTGS' or .='MEPS'])">
						    		<div id="bank_country_code_div">
							    		<xsl:call-template name="country-field">
							    			<xsl:with-param name="label">XSL_BENEFICIARY_COUNTRY</xsl:with-param>
							      			<xsl:with-param name="name">bank_code_country</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./bank_country"/></xsl:with-param>
							      			<xsl:with-param name="prefix">bank_code</xsl:with-param>
							    		</xsl:call-template>
						    		</div>
					    		</xsl:if>
					    		<!-- BRANCH ADDRESS -->
					    		<xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and product_type[.='MT101' or .='MT103' or .='RTGS' or .='FI103' or .='FI202'  or .='MEPS' or .='TRSRY' or .='TRSRYFXFT'])">
						    		<div id="branch_address_div">
							    		<xsl:call-template name="multichoice-field">
								    		<xsl:with-param name="label">XSL_BRANCH_ADDRESS_CHECKBOX</xsl:with-param>
								    	    <xsl:with-param name="name">branch_address</xsl:with-param>
								    	    <xsl:with-param name="type">checkbox</xsl:with-param>
								    	</xsl:call-template>
						    		</div>
						    		<div id="branch_address_line_1_div">
								  		<xsl:call-template name="input-field">
							      			<xsl:with-param name="label">XSL_BENEFICIARY_BRANCH_ADDRESS</xsl:with-param>
							      			<xsl:with-param name="name">branch_address_line_1</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./branch_address_line_1"/></xsl:with-param>
							      			<xsl:with-param name="size">35</xsl:with-param>
							       			<xsl:with-param name="maxsize">35</xsl:with-param>
							       			<xsl:with-param name="swift-validate">N</xsl:with-param>
							    		</xsl:call-template>
						    		</div>
						    		<div id="branch_address_line_2_div">
							    		<xsl:call-template name="input-field">
							      			<xsl:with-param name="name">branch_address_line_2</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./branch_address_line_2"/></xsl:with-param>
							      			<xsl:with-param name="size">35</xsl:with-param>
							       			<xsl:with-param name="maxsize">35</xsl:with-param>
							    		</xsl:call-template>
						    		</div>
						    		
						    		<div id="branch_dom_div">
							    		<xsl:call-template name="input-field">
							      			<xsl:with-param name="name">branch_dom</xsl:with-param>
							      			<xsl:with-param name="value"><xsl:value-of select="./branch_dom"/></xsl:with-param>
							      			<xsl:with-param name="size">35</xsl:with-param>
							       			<xsl:with-param name="maxsize">35</xsl:with-param>
							       			<xsl:with-param name="swift-validate">N</xsl:with-param>
							    		</xsl:call-template>
						    		</div>
					    		</xsl:if>
					    		
					    		
					    		<xsl:if test="$displaymode='edit' or ($displaymode='view' and product_type[.!='TRSRY' or .!='TRSRYFXFT'])">
					    		<div id= "pre-approved-beneficiary_beneficiary_div">
					    		<!-- Show Pre Approved Beneficiary Section Fields -->
					    		<xsl:call-template name="beneficiary-preapproved-details"/>
					    		</div>
					    		</xsl:if>
					    		
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
  
	<xsl:template name="beneficiary-preapproved-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="content">
				<xsl:choose>
					<xsl:when test="securitycheck:hasPermission(utils:getUserACL($rundata),'pab_beneficiary_access',utils:getUserEntities($rundata)) or (gtpsecurity:isGroup($rundata) and securitycheck:hasCompanyPermission($rundata,'pab_beneficiary_access'))">
						<!-- PRE APPROVED BENEFICIARY -->
						<xsl:choose>
							<xsl:when test= "$displaymode = 'edit'">
		 						<!-- Limit Amount -->
		 						<div id="pre_approved_div">
		     						<xsl:call-template name="multichoice-field">
										<xsl:with-param name="label">XSL_BENEFICIARY_PRE_APPROVED</xsl:with-param>
										<xsl:with-param name="name">pre_approved</xsl:with-param>
										<xsl:with-param name="type">checkbox</xsl:with-param>
										<xsl:with-param name="checked">
											<xsl:choose>
												<xsl:when test="pre_approved[.='Y']">true</xsl:when>
												<xsl:otherwise>false</xsl:otherwise>
											</xsl:choose>
										</xsl:with-param>
									</xsl:call-template>
								</div>
								<!-- THRESHOLD AMOUNT -->
								<xsl:call-template name="currency-field">
									<xsl:with-param name="label">XSL_BENEFICIARY_MAX_TRANSFER_LIMIT_AMOUNT</xsl:with-param>
									<xsl:with-param name="product-code">threshold</xsl:with-param>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="pre_approved[. = 'Y']">
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_BENEFICIARY_PRE_APPROVED</xsl:with-param>
											<xsl:with-param name="name">pre_approved_display</xsl:with-param>				
											<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N034', 'Y')"/></xsl:with-param>
											<xsl:with-param name="swift-validate">N</xsl:with-param>
										</xsl:call-template>
										<!-- THRESHOLD AMOUNT -->
										<xsl:if test="threshold_amt[.!=''] or threshold_cur_code[.!='']">
											<xsl:call-template name="currency-field">
												<xsl:with-param name="label">XSL_BENEFICIARY_MAX_TRANSFER_LIMIT_AMOUNT</xsl:with-param>
												<xsl:with-param name="product-code">threshold</xsl:with-param>
											</xsl:call-template>										
										</xsl:if>
										<xsl:call-template name="hidden-field">
											<xsl:with-param name="name">pre_approved</xsl:with-param>
											<xsl:with-param name="value">
												<xsl:value-of select="pre_approved"/>
											</xsl:with-param>
										</xsl:call-template>
									</xsl:when>
									<xsl:otherwise>
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_BENEFICIARY_PRE_APPROVED</xsl:with-param>
											<xsl:with-param name="name">pre_approved_display</xsl:with-param>				
											<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N034', 'N')"/></xsl:with-param>
										</xsl:call-template>
										<xsl:call-template name="hidden-field">
											<xsl:with-param name="name">pre_approved</xsl:with-param>
											<xsl:with-param name="value">
												<xsl:value-of select="pre_approved"/>
											</xsl:with-param>
										</xsl:call-template>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">pre_approved</xsl:with-param>
							<xsl:with-param name="value">
								<xsl:choose>
									<xsl:when test="pre_approved[.!='']"><xsl:value-of select="pre_approved"/></xsl:when>
									<xsl:otherwise>N</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">threshold_amt</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="threshold_amt"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">threshold_cur_code</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="threshold_cur_code"/></xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>	
	
	<xsl:template name="additional-instructions">
		<div id="free-format-settlement-additional_div">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_BENEFICIARY_ADDITIONAL_INSTRUCTIONS</xsl:with-param>
	   		<xsl:with-param name="content">
	   		
	   				<!-- intermediary bank BIC/SWIFT code -->
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK_BIC</xsl:with-param>
			<xsl:with-param name="name">inter_bank_swift</xsl:with-param>
			<xsl:with-param name="size">11</xsl:with-param>
			<xsl:with-param name="maxsize">11</xsl:with-param>
		</xsl:call-template>

		<!-- intermediary bank address -->
		<xsl:choose>
		 <xsl:when test="starts-with(./inter_bank_name,'/')">
		 <xsl:call-template name="input-field">
			<xsl:with-param name="name">inter_bank_name</xsl:with-param>
			<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="substring(./inter_bank_name,7)"/></xsl:with-param>
	 		<xsl:with-param name="size">35</xsl:with-param>
			<xsl:with-param name="maxsize">35</xsl:with-param>
		</xsl:call-template>
		 </xsl:when>
		 
		 <xsl:otherwise>
		 <xsl:call-template name="input-field">
			<xsl:with-param name="name">inter_bank_name</xsl:with-param>
			<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="./inter_bank_name"/></xsl:with-param>
	 		<xsl:with-param name="size">35</xsl:with-param>
			<xsl:with-param name="maxsize">35</xsl:with-param>
		</xsl:call-template>
		 </xsl:otherwise>
		</xsl:choose>
		
		
		
		<xsl:choose>
		 <xsl:when test="starts-with(./inter_bank_address_1,'/')">
		 <xsl:call-template name="input-field">
			<xsl:with-param name="name">inter_bank_address_1</xsl:with-param>
			<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK_STREET</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="substring(./inter_bank_address_1,7)"/></xsl:with-param>
			<xsl:with-param name="size">35</xsl:with-param>
			<xsl:with-param name="maxsize">35</xsl:with-param>
			<xsl:with-param name="swift-validate">N</xsl:with-param>
		</xsl:call-template>
		 </xsl:when>
		 
		 <xsl:otherwise>
		 <xsl:call-template name="input-field">
			<xsl:with-param name="name">inter_bank_address_1</xsl:with-param>
			<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK_STREET</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="./inter_bank_address_1"/></xsl:with-param>
			<xsl:with-param name="size">35</xsl:with-param>
			<xsl:with-param name="maxsize">35</xsl:with-param>
			<xsl:with-param name="swift-validate">N</xsl:with-param>
		</xsl:call-template>
		 </xsl:otherwise>
		</xsl:choose>
			
		<xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and product_type[.='TRSRYFXFT'])">
		<div id="inter_bank_address_2_div">
		<xsl:choose>
		 <xsl:when test="starts-with(./inter_bank_address_2,'/')">
		 <xsl:call-template name="input-field">
			<xsl:with-param name="name">inter_bank_address_2</xsl:with-param>
			<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK_LOCALITY</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="substring(./inter_bank_address_2,7)"/></xsl:with-param>
			<xsl:with-param name="size">34</xsl:with-param>
			<xsl:with-param name="maxsize">34</xsl:with-param>
		</xsl:call-template>
		 </xsl:when>
		 
		 <xsl:otherwise>
		 <xsl:call-template name="input-field">
			<xsl:with-param name="name">inter_bank_address_2</xsl:with-param>
			<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK_LOCALITY</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="./inter_bank_address_2"/></xsl:with-param>
			<xsl:with-param name="size">34</xsl:with-param>
			<xsl:with-param name="maxsize">34</xsl:with-param>
		</xsl:call-template>
		 </xsl:otherwise>
		</xsl:choose>		
		</div>
		</xsl:if>
		
		<xsl:choose>
		<xsl:when test="starts-with(./inter_bank_dom,'/')">
		 <xsl:call-template name="input-field">
		  	 	<xsl:with-param name="name">inter_bank_dom</xsl:with-param>
		  	 	<xsl:with-param name="value"><xsl:value-of select="substring(./inter_bank_dom,7)"/></xsl:with-param>
			    <xsl:with-param name="label">XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK_CITY</xsl:with-param>	
			    <xsl:with-param name="size">32</xsl:with-param>
			<xsl:with-param name="maxsize">32</xsl:with-param>	
			  </xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="input-field">
			<xsl:with-param name="name">inter_bank_dom</xsl:with-param>
			<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK_CITY</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="./inter_bank_dom"/></xsl:with-param>
			<xsl:with-param name="size">32</xsl:with-param>
			<xsl:with-param name="maxsize">32</xsl:with-param>
		</xsl:call-template>
		</xsl:otherwise>
		</xsl:choose>

		<xsl:call-template name="country-field">
			<xsl:with-param name="label">XSL_BENEFICIARY_COUNTRY</xsl:with-param>
			<xsl:with-param name="prefix">inter_bank</xsl:with-param>
			<xsl:with-param name="name">inter_bank_country</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="./inter_bank_country"/></xsl:with-param>
		</xsl:call-template>
		
		<xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and product_type[.='TRSRYFXFT'] )">
		<div id="inter_bank_clrc_div">
		<xsl:call-template name="select-field">
	  	 	<xsl:with-param name="name">inter_bank_clrc</xsl:with-param>
	  	 	<xsl:with-param name="value"><xsl:value-of select="./inter_bank_clrc"/></xsl:with-param>
		    <xsl:with-param name="label">XSL_CLEARING_CODE</xsl:with-param>	
		    <xsl:with-param name="options">
			  <option>
			    <xsl:attribute name="value"><xsl:value-of select="./inter_bank_clrc"/></xsl:attribute>
				   <xsl:value-of select="utils:getDescFromClearingCode(./inter_bank_clrc,$rundata)"/>
			  </option>
			  </xsl:with-param>		
		  </xsl:call-template>
		  	
	    </div>					    	
	    </xsl:if>
		
		<!-- intermediary bank routing number -->
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_SI_FREE_FORMAT_INTERMEDIARY_BANK_ABA</xsl:with-param>
			<xsl:with-param name="name">inter_bank_routing_no</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="./inter_bank_routing_no"/></xsl:with-param>
			<xsl:with-param name="maxsize">33</xsl:with-param>
		</xsl:call-template>
		
		
		<!-- special routing instruction 1 -->
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_SI_FREE_FORMAT_ROUTING_INSTRUCTION_1</xsl:with-param>
			<xsl:with-param name="name">special_routing_1</xsl:with-param>
			<xsl:with-param name="maxsize">35</xsl:with-param>
			<xsl:with-param name="swift-validate">N</xsl:with-param>
		</xsl:call-template>
		
		<!-- special routing instruction 2 -->
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_SI_FREE_FORMAT_ROUTING_INSTRUCTION_2</xsl:with-param>
			<xsl:with-param name="name">special_routing_2</xsl:with-param>
			<xsl:with-param name="maxsize">35</xsl:with-param>
		</xsl:call-template>
		
		<!-- special routing instruction 3 -->
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_SI_FREE_FORMAT_ROUTING_INSTRUCTION_3</xsl:with-param>
			<xsl:with-param name="name">special_routing_3</xsl:with-param>
			<xsl:with-param name="maxsize">35</xsl:with-param>
		</xsl:call-template>
		
		<!-- special routing instruction 4 -->
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_SI_FREE_FORMAT_ROUTING_INSTRUCTION_4</xsl:with-param>
			<xsl:with-param name="name">special_routing_4</xsl:with-param>
			<xsl:with-param name="maxsize">35</xsl:with-param>
		</xsl:call-template>
		
		<!-- special routing instruction 5 -->
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_SI_FREE_FORMAT_ROUTING_INSTRUCTION_5</xsl:with-param>
			<xsl:with-param name="name">special_routing_5</xsl:with-param>
			<xsl:with-param name="maxsize">35</xsl:with-param>
		</xsl:call-template>
		
		<!-- special routing instruction 6 -->
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_SI_FREE_FORMAT_ROUTING_INSTRUCTION_6</xsl:with-param>
			<xsl:with-param name="name">special_routing_6</xsl:with-param>
			<xsl:with-param name="maxsize">35</xsl:with-param>
		</xsl:call-template>
	   		
	   		</xsl:with-param>
	   	</xsl:call-template>
	   	</div>
	</xsl:template>
	
		<xsl:template name="payment-details">
		<xsl:if test="$displaymode = 'edit'or $displaymode = 'view'">
		<div id="free-format-settlement-payment_div">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_PAYMENT_DETAILS</xsl:with-param>
	   		<xsl:with-param name="content">
	   		<!-- payment detail 1 -->
 		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_SI_ADDITIONAL_DETAILS_LINE_1</xsl:with-param>
			<xsl:with-param name="name">payment_detail_1</xsl:with-param>
		</xsl:call-template>
		
		<!-- payment detail 2 -->
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_SI_ADDITIONAL_DETAILS_LINE_2</xsl:with-param>
			<xsl:with-param name="name">payment_detail_2</xsl:with-param>
		</xsl:call-template>
		
		<!-- payment detail 3 -->
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_SI_ADDITIONAL_DETAILS_LINE_3</xsl:with-param>
			<xsl:with-param name="name">payment_detail_3</xsl:with-param>
		</xsl:call-template>
		
		<!-- payment detail 4 -->
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_SI_ADDITIONAL_DETAILS_LINE_4</xsl:with-param>
			<xsl:with-param name="name">payment_detail_4</xsl:with-param>
		</xsl:call-template>
	   		</xsl:with-param>
	   		</xsl:call-template>
		</div>
		</xsl:if>
		</xsl:template>
	
</xsl:stylesheet>