<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp '&#160;'>
	<!ENTITY lt '&#x003C;'>
]>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 	
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization" 		
		xmlns:security="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		exclude-result-prefixes="localization security">
 
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="nextscreen"/>
  <xsl:param name="option"/>
  <xsl:param name="rundata" />
  <xsl:param name="selparm"/>
  <xsl:param name="largeparam"/>
  <xsl:param name="updateMode"/>
  <xsl:param name="userName"/>
  <xsl:param name="userId"/>
  <xsl:param name="userIdExists"/>
  <xsl:param name="bankAbbvName"/>
  <xsl:param name="baseCurCode"/>
  <xsl:param name="token"/>
  <xsl:param name="displaymode">edit</xsl:param>
  <xsl:param name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$nextscreen"/></xsl:param>
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="canCheckerReturnComments"/>
  <xsl:param name="checkerReturnCommentsMode"/>
  <xsl:param name="operation">SAVE_FEATURES</xsl:param>  
  
  <xsl:param name="main-form-name">parmForm</xsl:param>
  <!--
  need to identify based on security and what is mentioned in the maintparameter
  -->
  <xsl:param name="displaymode">edit</xsl:param>  
  <!-- Global Imports. -->
  <xsl:include href="../common/system_common.xsl" />
   <xsl:include href="../common/e2ee_common.xsl" />
  <xsl:include href="../../../core/xsl/common/maker_checker_common.xsl" />
  
  <xsl:variable name ="returnData" select="//return_comments" />
  <xsl:variable name="returnComments"><xsl:value-of select="substring-before(substring-after($returnData,'&lt;![CDATA['),']]&gt;')" /></xsl:variable>
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
	
	<!-- MAIN -->
	<xsl:template match="/">
		<!-- Loading message  -->
		<xsl:call-template name="loading-message" />
	    <div>
			<xsl:attribute name="id"><xsl:value-of select="$displaymode" /></xsl:attribute>
			<xsl:call-template name="form-wrapper">
				<xsl:with-param name="name" select="$main-form-name" />
				<xsl:with-param name="method"></xsl:with-param>
				<xsl:with-param name="validating">Y</xsl:with-param>
		   		<xsl:with-param name="content">
					<xsl:apply-templates select="maintainparameters/maintainParameter" />
					<!-- save, cancel, help buttons -->
					<xsl:if test="$canCheckerReturnComments = 'true'">
				      	<xsl:call-template name="comments-for-return-mc">
				      		<xsl:with-param name="value"><xsl:value-of select="$returnComments"/></xsl:with-param>
				      	</xsl:call-template>
		      		</xsl:if>
					<xsl:call-template name="maker-checker-menu"/>
					
				</xsl:with-param>
			</xsl:call-template>
			<script>
				dojo.ready(function(){
			  		misys._config = misys._config || {};
			  		dojo.mixin(misys._config, {
			  					productCodes :  new Array(),
								subProductCodes : new Array()
					});
		  			<xsl:for-each select="maintainparameters/avail_products/product">
						<xsl:variable name="productCode"><xsl:value-of select="./product_code"/></xsl:variable>
							misys._config.subProductCodes["<xsl:value-of select="$productCode"/>"] = new Array(<xsl:value-of select="count(./sub_product_code) + 1"/>);
							<xsl:for-each select="./sub_product_code">
								<xsl:variable name="position" select="position()" />
								misys._config.subProductCodes["<xsl:value-of select="$productCode"/>"][<xsl:value-of select="$position"/>]= {value:"<xsl:value-of select="."/>",name:"<xsl:value-of select="localization:getDecode($language, 'N047', .)"/>"};
		        			</xsl:for-each>
		        			misys._config.subProductCodes["<xsl:value-of select="$productCode"/>"][0]= {value:"*",name:"*"};
					</xsl:for-each>
					misys._config.subProductCodes["*"]= new Array(1);
					misys._config.subProductCodes["*"][0] = {value:"*",name:"*"};
				});
		  	</script>
			<!-- Real Form -->
			<xsl:call-template name="realform" />
			
			<!-- Javascript imports  -->
		    <xsl:call-template name="js-imports" />
		</div>
	</xsl:template>	

	<!-- Real Form -->
	<xsl:template name="realform">
	  <!-- Do not display this section when the counterparty mode is 'counterparty' -->
	  <xsl:if test="$collaborationmode != 'counterparty'">
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
	       <xsl:with-param name="value"><xsl:value-of select="$operation"/></xsl:with-param>
	      </xsl:call-template>
	     
	      <xsl:call-template name="hidden-field">
	       <xsl:with-param name="name">option</xsl:with-param>
		   <xsl:with-param name="value"><xsl:value-of select="$option"/></xsl:with-param>
	      </xsl:call-template>
	      <xsl:call-template name="hidden-field">
	       <xsl:with-param name="name">featureid</xsl:with-param>
		   <xsl:with-param name="value"><xsl:value-of select="$selparm"/></xsl:with-param>
	      </xsl:call-template>
	      <xsl:call-template name="hidden-field">
	       <xsl:with-param name="name">updatemode</xsl:with-param>
		   <xsl:with-param name="value"><xsl:value-of select="$updateMode"/></xsl:with-param>
	      </xsl:call-template>
	      <xsl:call-template name="hidden-field">
	       <xsl:with-param name="name">tnxTypeCode</xsl:with-param>
		   <xsl:with-param name="value"><xsl:value-of select="$makerCheckerState"/></xsl:with-param>
	      </xsl:call-template>
	      <xsl:call-template name="hidden-field">
	       <xsl:with-param name="name">TransactionData</xsl:with-param>
	       <xsl:with-param name="value"/>
	      </xsl:call-template>
	       <xsl:call-template name="hidden-field">
				<xsl:with-param name="name">token</xsl:with-param>
				 <xsl:with-param name="value"><xsl:value-of select="$token"/></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
       <xsl:with-param name="name">tnxid</xsl:with-param>
       <xsl:with-param name="value" select="//tnx_id"/>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
	  	<xsl:with-param name="name">groupNameRegexValue</xsl:with-param>
		<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('RM_GROUP_NAME_VALIDATION_REGEX')"/></xsl:with-param>
	  </xsl:call-template>
	  <xsl:call-template name="hidden-field">
       		<xsl:with-param name="name">groupIdRegexValue</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="defaultresource:getResource('RM_GROUP_ID_VALIDATION_REGEX')"/></xsl:with-param>
	   </xsl:call-template>
	       <!-- static_company is only passed for customer matrix maintenance on bankgroup side -->
	      <xsl:if test="$option='CUSTOMER_ENTITY_MAINTENANCE'">
	      	<xsl:call-template name="hidden-field">
	       		<xsl:with-param name="name">company</xsl:with-param>
	       		<xsl:with-param name="value"><xsl:value-of select="company_abbv_name"/></xsl:with-param>
	      	</xsl:call-template>
	      </xsl:if>
		<xsl:call-template name="e2ee_transaction"/>	      
	     </div>
	    </xsl:with-param>
	   </xsl:call-template>
	   </xsl:if>
	</xsl:template>

	<!-- Additional JS imports for this form -->
	<xsl:template name="js-imports">
	  <xsl:call-template name="system-common-js-imports">
	   <xsl:with-param name="xml-tag-name">maintainParameter</xsl:with-param>
	      <xsl:with-param name="binding">misys.binding.system.generic_parameter</xsl:with-param>
	      <xsl:with-param name="override-help-access-key">BA_PARAM</xsl:with-param>
	   <xsl:with-param name="override-home-url">'/screen/<xsl:value-of select="$nextscreen"/>?option=<xsl:value-of select="$option"/>&amp;parmid=<xsl:value-of select="$selparm"/>'</xsl:with-param>
	  </xsl:call-template>
	</xsl:template>
 
	<!-- Maintain Parameter Template  -->
	<xsl:template match="maintainParameter">
	   <xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend"><xsl:value-of select="@label"/></xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_GENPARMMAINT_KEY</xsl:with-param>
				 	<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="hidden-field">
				       		<xsl:with-param name="name">parm_id</xsl:with-param>
				       		<xsl:with-param name="value" select="@name" />
				    	</xsl:call-template>
				    	<!--if update mode store the old parmid -->
				    	<xsl:if test="$updateMode">
				    		<xsl:call-template name="hidden-field">
					       		<xsl:with-param name="name">old_parm_id</xsl:with-param>
					       		<xsl:with-param name="value" select="@name" />
				    		</xsl:call-template>
				    	</xsl:if>
					   <xsl:apply-templates select="company_id"/>
					   <xsl:apply-templates select="company_id" mode="old"/>
					   <!-- provide the param_id for multiple values -->
					   <xsl:call-template name="paramid">
					      <xsl:with-param name="multiple" select="@mode" />
					   </xsl:call-template>
					   <xsl:apply-templates select="key" mode="old"/>
					   <xsl:apply-templates select="key"/>
					  
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_GENPARMMAINT_DATA</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
				    <xsl:with-param name="content">
				   		<xsl:if test="$largeparam">
							<xsl:call-template name="configurable-grid-details" />
							<xsl:call-template name="configurable-grid-declaration" />
						</xsl:if>
						<xsl:if test="not ($largeparam)">
				    			<xsl:apply-templates select="data"/>
				    	</xsl:if>
				  </xsl:with-param>
			  </xsl:call-template>
			</xsl:with-param>		   
		</xsl:call-template>
	</xsl:template>
	
	<!-- Company Details -->
	<xsl:template match="company_id">
	    <xsl:choose>
	    	<xsl:when test="@hidden='true'">
	    		<xsl:call-template name="hidden-field">
	    			<xsl:with-param name="name"><xsl:value-of select="@column"/></xsl:with-param>
	    			<xsl:with-param name="value" ><xsl:value-of select="../../parameter_data/company_id"></xsl:value-of></xsl:with-param>
	    		</xsl:call-template>
	    		
	    	</xsl:when>
	   		<xsl:otherwise>
				<xsl:call-template name="input-field">
		      		<xsl:with-param name="label"><xsl:value-of select="@label"/></xsl:with-param>
		      		<xsl:with-param name="name"><xsl:value-of select="@column"/></xsl:with-param>
		      		<xsl:with-param name="required"><xsl:value-of select="@mandatory" /></xsl:with-param>
		      		<xsl:with-param name="maxsize">65</xsl:with-param>
		      		
		      		<xsl:with-param name="value">
		      			 <xsl:value-of select="../../parameter_data/company_id"></xsl:value-of>
		      		</xsl:with-param>
		     	</xsl:call-template>
	     	</xsl:otherwise>
	     </xsl:choose>
	     
	</xsl:template>
	<xsl:template match="company_id" mode="old">
	    <xsl:if test="$updateMode">
	    	
	     <xsl:call-template name="hidden-field">
	    			<xsl:with-param name="name">old_<xsl:value-of select="@column"/></xsl:with-param>
	    			 <xsl:with-param name="value" ><xsl:value-of select="../../parameter_data/company_id"></xsl:value-of></xsl:with-param>
	    </xsl:call-template>
	    </xsl:if>
	</xsl:template>

	<!-- Template which builds the fields for key fields -->
	<xsl:template match="key">
		<xsl:choose>
			<xsl:when test="@hidden !='true'">
				<xsl:choose>
				    <xsl:when test="@type='COUNTRY_TYPE'">
				    	<xsl:call-template name="input-field">
				      		<xsl:with-param name="label"><xsl:value-of select="@label"/></xsl:with-param>
				      		<xsl:with-param name="name"><xsl:value-of select="@column"/>_country</xsl:with-param>
				      		<xsl:with-param name="required"><xsl:value-of select="@mandatory" /></xsl:with-param>
				      		<xsl:with-param name="prefix"><xsl:value-of select="@column"/></xsl:with-param>
				      		<xsl:with-param name="button-type">codevalue</xsl:with-param>
				      		<xsl:with-param name="maxsize"><xsl:value-of select="@length"/></xsl:with-param>
				      		<xsl:with-param name="fieldsize">small</xsl:with-param>
				      		<xsl:with-param name="appendClass"><xsl:value-of select="@appendClass"/></xsl:with-param>
				      		<xsl:with-param name="value">
					      		<xsl:call-template name="selectkeyvalue">
					      			<xsl:with-param name="keyname"><xsl:value-of select="@column"/></xsl:with-param>
					      		</xsl:call-template>
				      		</xsl:with-param>
			     		</xsl:call-template>
			     	</xsl:when>
			     	<xsl:when test="@type='DATE'">
				     		<xsl:call-template name="input-field">
					      		<xsl:with-param name="label"><xsl:value-of select="@label"/></xsl:with-param>
					      		<xsl:with-param name="name"><xsl:value-of select="@column"/></xsl:with-param>
					      		<xsl:with-param name="required"><xsl:value-of select="@mandatory" /></xsl:with-param>
					      		<xsl:with-param name="maxsize"><xsl:value-of select="@length"/></xsl:with-param>
					      		<xsl:with-param name="size"><xsl:value-of select="@length"/></xsl:with-param>
					      		<xsl:with-param name="type">date</xsl:with-param>
					      		<xsl:with-param name="fieldsize">small</xsl:with-param>
					      		<xsl:with-param name="appendClass"><xsl:value-of select="@appendClass"/></xsl:with-param>
					      		<xsl:with-param name="value">
							      		<xsl:call-template name="selectkeyvalue">
							      			<xsl:with-param name="keyname"><xsl:value-of select="@column"/></xsl:with-param>
							      		</xsl:call-template>
					      		</xsl:with-param>
					     	</xsl:call-template>
					</xsl:when>
					<xsl:when test="@type='SUBSCRIPTION_CODE'">
				    	<xsl:call-template name="select-field">
								<xsl:with-param name="label"><xsl:value-of select="@label"/></xsl:with-param>
								<xsl:with-param name="name"><xsl:value-of select="@column"/></xsl:with-param>
								<xsl:with-param name="required"><xsl:value-of select="@mandatory"/></xsl:with-param>
								<xsl:with-param name="maxsize"><xsl:value-of select="@length"/></xsl:with-param>
								<xsl:with-param name="appendClass"><xsl:value-of select="@appendClass"/></xsl:with-param>
								<xsl:with-param name="fieldsize"><xsl:value-of select="@fieldSize"/></xsl:with-param>
								<xsl:with-param name="options">
									<option value="*">*</option>
									<xsl:apply-templates select="../../subscription_codes/subscription_code"/>
								</xsl:with-param>
								<xsl:with-param name="value">
						      		<xsl:call-template name="selectkeyvalue">
						      			<xsl:with-param name="keyname"><xsl:value-of select="@column"/></xsl:with-param>
						      			<xsl:with-param name="optiontype" select="true()"/>
						      		</xsl:call-template>
		      					</xsl:with-param>
						</xsl:call-template>
			     	</xsl:when>
			     	
			     	<xsl:when test="@code='N503'">
				     	    	<xsl:choose>
				     	    		<xsl:when test="$displaymode = 'edit'">
					     	    		<xsl:call-template name="select-field">
												<xsl:with-param name="label"><xsl:value-of select="@label"/></xsl:with-param>
												<xsl:with-param name="name"><xsl:value-of select="@column"/></xsl:with-param>
												<!--  <xsl:with-param name="maxsize"><xsl:value-of select="@length"/></xsl:with-param> -->
												<xsl:with-param name="id">clearing_value</xsl:with-param>
												<xsl:with-param name="appendClass"><xsl:value-of select="@appendClass"/></xsl:with-param>
												<xsl:with-param name="fieldsize"><xsl:value-of select="@fieldSize"/></xsl:with-param>
												<xsl:with-param name="required"><xsl:value-of select="@mandatory" /></xsl:with-param>
												<xsl:with-param name="options">
														
														<option value="*">*</option>
														
													<xsl:apply-templates select="../../clearing_system/clearing_value"/>
												</xsl:with-param>
												<xsl:with-param name="value">
										      		<xsl:call-template name="selectkeyvalue">
										      			<xsl:with-param name="keyname"><xsl:value-of select="@column"/></xsl:with-param>
										      			<xsl:with-param name="optiontype" select="true()"/>
										      		</xsl:call-template>
						      					</xsl:with-param>
										</xsl:call-template>
									</xsl:when>
									<xsl:otherwise>
										<xsl:call-template name="input-field">
													<xsl:with-param name="label"><xsl:value-of select="@label"/></xsl:with-param>
													<xsl:with-param name="name"><xsl:value-of select="@column"/></xsl:with-param>
													<xsl:with-param name="id">clearing_value</xsl:with-param>
													<xsl:with-param name="value">
														<xsl:value-of select="localization:getDecode($language, 'N503', //key_10)"/>
							      					</xsl:with-param>
											</xsl:call-template>
									</xsl:otherwise>
								</xsl:choose>
			     	    	</xsl:when>
			     	<xsl:when test="@type='AMOUNT'">		     		
			     	 	<xsl:call-template name="currency-field">
				    		<xsl:with-param name="label"><xsl:value-of select="@label"/></xsl:with-param>
				    		<xsl:with-param name="override-amt-name"><xsl:value-of select="@column"/></xsl:with-param>				    		
				      		<xsl:with-param name="required"><xsl:value-of select="@mandatory"/></xsl:with-param>
				      		 <xsl:with-param name="show-currency">N</xsl:with-param>
				      		  <xsl:with-param name="show-button">N</xsl:with-param>
				      		<xsl:with-param name="override-amt-value">
						      		<xsl:call-template name="selectkeyvalue">
						      			<xsl:with-param name="keyname"><xsl:value-of select="@column"/></xsl:with-param>
						      		</xsl:call-template>
				      		</xsl:with-param>				      		
				     	</xsl:call-template>				     	
			     	</xsl:when>
			     	<xsl:when test="@type='CURRENCY'">		     					    	
				     	<xsl:call-template name="currency-field">
							<xsl:with-param name="label"><xsl:value-of select="@label"/></xsl:with-param>								 				
							<xsl:with-param name="override-currency-name"><xsl:value-of select="@column"/></xsl:with-param>							
							<xsl:with-param name="override-product-code">
							<xsl:if test="../@name ='P109'">param109</xsl:if>
							<xsl:if test="../@name ='P110'">param110</xsl:if>							
							</xsl:with-param>					
							<xsl:with-param name="required">N</xsl:with-param>
							<xsl:with-param name="show-amt">N</xsl:with-param>
							<xsl:with-param name="currency-readonly">N</xsl:with-param>	
							<xsl:with-param name="show-button">Y</xsl:with-param>								
						</xsl:call-template>			
				     	<script>
				     		dojo.ready(function(){
				     			misys._config = misys._config || {};
				     			dojo.mixin(misys._config, {
				  					amountField : "<xsl:value-of select="@column"/>"
								});
				     		});
				     	</script>
		     		</xsl:when>
			     	<!-- the combo box for the business codes needs to be provided.
			     	 Technical approach is for all the business code build the code as store and 
			     	 supply for combo. This is to make sure that the only permissible codes are avilable for selection  --> 
			     	 <xsl:when test="@type='CODE' ">
			     	 	<xsl:choose>
			     	    	<xsl:when test="@code='N082'">
			     	    		<xsl:choose>
			     	    			<xsl:when test="$displaymode='edit'">
					     	    		<xsl:call-template name="select-field">
											<xsl:with-param name="label"><xsl:value-of select="@label"/></xsl:with-param>
											<xsl:with-param name="name"><xsl:value-of select="@column"/></xsl:with-param>
											<xsl:with-param name="required"><xsl:value-of select="@mandatory" /></xsl:with-param>
											<xsl:with-param name="maxsize"><xsl:value-of select="@length"/></xsl:with-param>
											<xsl:with-param name="appendClass"><xsl:value-of select="@appendClass"/></xsl:with-param>
											<xsl:with-param name="fieldsize"><xsl:value-of select="@fieldSize"/></xsl:with-param>
											<xsl:with-param name="sort-filter-select">N</xsl:with-param>
											<xsl:with-param name="options">
												<xsl:call-template name="dayofweek-options-java"/>
											</xsl:with-param>
											<xsl:with-param name="value">
									      		<xsl:call-template name="selectkeyvalue">
									      			<xsl:with-param name="type">list</xsl:with-param>
									      			<xsl:with-param name="keyname"><xsl:value-of select="@column"/></xsl:with-param>
									      		</xsl:call-template>
						      				</xsl:with-param>
										 </xsl:call-template>
									</xsl:when>
									<xsl:otherwise>
									<xsl:if test="@column='key_8'">
										<xsl:call-template name="input-field">
											<xsl:with-param name="label"><xsl:value-of select="@label"/></xsl:with-param>
											<xsl:with-param name="name"><xsl:value-of select="@column"/></xsl:with-param>
											<xsl:with-param name="value">
									      		<xsl:value-of select="localization:getDecode($language, 'N082', //key_8)"/>
						      				</xsl:with-param>
										 </xsl:call-template>
									</xsl:if>
									<xsl:if test="@column='key_9'">
										<xsl:call-template name="input-field">
											<xsl:with-param name="label"><xsl:value-of select="@label"/></xsl:with-param>
											<xsl:with-param name="name"><xsl:value-of select="@column"/></xsl:with-param>
											<xsl:with-param name="value">
									      		<xsl:value-of select="localization:getDecode($language, 'N082', //key_9)"/>
						      				</xsl:with-param>
										 </xsl:call-template>
									</xsl:if>
									</xsl:otherwise>
								 </xsl:choose>
			     	    	</xsl:when>
			     	    	<xsl:when test="@code='N001'">
				     	    	<xsl:choose>
				     	    		<xsl:when test="$displaymode = 'edit'">
					     	    		<xsl:call-template name="select-field">
												<xsl:with-param name="label"><xsl:value-of select="@label"/></xsl:with-param>
												<xsl:with-param name="name"><xsl:value-of select="@column"/></xsl:with-param>
												<xsl:with-param name="maxsize"><xsl:value-of select="@length"/></xsl:with-param>
												<xsl:with-param name="id">product_code</xsl:with-param>
												<xsl:with-param name="appendClass"><xsl:value-of select="@appendClass"/></xsl:with-param>
												<xsl:with-param name="fieldsize"><xsl:value-of select="@fieldSize"/></xsl:with-param>
												<xsl:with-param name="required"><xsl:value-of select="@mandatory" /></xsl:with-param>
												<xsl:with-param name="options">
														
														<option value="*">*</option>
														
													<xsl:apply-templates select="../../avail_products/product/product_code"/>
												</xsl:with-param>
												<xsl:with-param name="value">
										      		<xsl:call-template name="selectkeyvalue">
										      			<xsl:with-param name="keyname"><xsl:value-of select="@column"/></xsl:with-param>
										      			<xsl:with-param name="optiontype" select="true()"/>
										      		</xsl:call-template>
						      					</xsl:with-param>
										</xsl:call-template>
									</xsl:when>
									<xsl:otherwise>
										<xsl:call-template name="input-field">
													<xsl:with-param name="label"><xsl:value-of select="@label"/></xsl:with-param>
													<xsl:with-param name="name"><xsl:value-of select="@column"/></xsl:with-param>
													<xsl:with-param name="id">product_code</xsl:with-param>
													<xsl:with-param name="value">
														<xsl:value-of select="localization:getDecode($language, 'N001', //key_2)"/>
							      					</xsl:with-param>
											</xsl:call-template>
									</xsl:otherwise>
								</xsl:choose>
			     	    	</xsl:when>
			     	    	
			     	    	<xsl:when test="@code='N503'">
				     	    	<xsl:choose>
				     	    		<xsl:when test="$displaymode = 'edit'">
					     	    		<xsl:call-template name="select-field">
												<xsl:with-param name="label"><xsl:value-of select="@label"/></xsl:with-param>
												<xsl:with-param name="name"><xsl:value-of select="@column"/></xsl:with-param>
												<!--  <xsl:with-param name="maxsize"><xsl:value-of select="@length"/></xsl:with-param> -->
												<xsl:with-param name="id">clearing_value</xsl:with-param>
												<xsl:with-param name="appendClass"><xsl:value-of select="@appendClass"/></xsl:with-param>
												<xsl:with-param name="fieldsize"><xsl:value-of select="@fieldSize"/></xsl:with-param>
												<xsl:with-param name="required"><xsl:value-of select="@mandatory" /></xsl:with-param>
												<xsl:with-param name="options">
														
														<option value="*">*</option>
														
													<xsl:apply-templates select="../../clearing_system/clearing_value"/>
												</xsl:with-param>
												<xsl:with-param name="value">
										      		<xsl:call-template name="selectkeyvalue">
										      			<xsl:with-param name="keyname"><xsl:value-of select="@column"/></xsl:with-param>
										      			<xsl:with-param name="optiontype" select="true()"/>
										      		</xsl:call-template>
						      					</xsl:with-param>
										</xsl:call-template>
									</xsl:when>
									<xsl:otherwise>
										<xsl:call-template name="input-field">
													<xsl:with-param name="label"><xsl:value-of select="@label"/></xsl:with-param>
													<xsl:with-param name="name"><xsl:value-of select="@column"/></xsl:with-param>
													<xsl:with-param name="id">clearing_value</xsl:with-param>
													<xsl:with-param name="value">
														<xsl:value-of select="localization:getDecode($language, 'N503', //key_10)"/>
							      					</xsl:with-param>
											</xsl:call-template>
									</xsl:otherwise>
								</xsl:choose>
			     	    	</xsl:when>
			     	    	<xsl:when test="@code='N047'">
				     	    	<xsl:choose>
					     	    	<xsl:when test="$displaymode = 'edit'">
					     	    		<xsl:call-template name="select-field">
												<xsl:with-param name="label"><xsl:value-of select="@label"/></xsl:with-param>
												<xsl:with-param name="name"><xsl:value-of select="@column"/></xsl:with-param>
												<xsl:with-param name="id">sub_product_code</xsl:with-param>
												<xsl:with-param name="maxsize"><xsl:value-of select="@length"/></xsl:with-param>
												<xsl:with-param name="appendClass"><xsl:value-of select="@appendClass"/></xsl:with-param>
												<xsl:with-param name="fieldsize"><xsl:value-of select="@fieldSize"/></xsl:with-param>
												<xsl:with-param name="required"><xsl:value-of select="@mandatory" /></xsl:with-param>
												<xsl:with-param name="value">
									      		<xsl:call-template name="selectkeyvalue">
									      			<xsl:with-param name="keyname"><xsl:value-of select="@column"/></xsl:with-param>
									      			<xsl:with-param name="optiontype" select="true()"/>
									      		</xsl:call-template>
						      				</xsl:with-param>
										</xsl:call-template>
										<xsl:call-template name="hidden-field">
											<xsl:with-param name="name">sub_product_code_hidden</xsl:with-param>
											<xsl:with-param name="value">
												<xsl:call-template name="selectkeyvalue">
									      			<xsl:with-param name="keyname"><xsl:value-of select="@column"/></xsl:with-param>
									      			<xsl:with-param name="optiontype" select="true()"/>
									      		</xsl:call-template>
											</xsl:with-param>
										</xsl:call-template>
									</xsl:when>
									<xsl:otherwise>
										<xsl:call-template name="input-field">
												<xsl:with-param name="label"><xsl:value-of select="@label"/></xsl:with-param>
												<xsl:with-param name="name"><xsl:value-of select="@column"/></xsl:with-param>
												<xsl:with-param name="id">sub_product_code</xsl:with-param>
												<xsl:with-param name="value">
									      			<xsl:value-of select="localization:getDecode($language, 'N047', //key_3)"/>
						      					</xsl:with-param>
										</xsl:call-template>
										<xsl:call-template name="hidden-field">
											<xsl:with-param name="name">sub_product_code_hidden</xsl:with-param>
											<xsl:with-param name="value">
												<xsl:value-of select="localization:getDecode($language, 'N047', //key_3)"/>
											</xsl:with-param>
										</xsl:call-template>
									</xsl:otherwise>
								</xsl:choose>
			     	    	</xsl:when>
				     	    <xsl:otherwise>
				     	    	<xsl:call-template name="input-field">
						      		<xsl:with-param name="label"><xsl:value-of select="@label"/></xsl:with-param>
						      		<xsl:with-param name="name"><xsl:value-of select="@column"/></xsl:with-param>
						      		<xsl:with-param name="required"><xsl:value-of select="@mandatory" /></xsl:with-param>
						      		<xsl:with-param name="maxsize"><xsl:value-of select="@length"/></xsl:with-param>
						      		<xsl:with-param name="type"><xsl:value-of select="@type"/></xsl:with-param>
						      		<xsl:with-param name="appendClass"><xsl:value-of select="@appendClass"/></xsl:with-param>
									<xsl:with-param name="fieldsize"><xsl:value-of select="@fieldSize"/></xsl:with-param>
						      		<xsl:with-param name="value">
								      		<xsl:call-template name="selectkeyvalue">
								      			<xsl:with-param name="keyname"><xsl:value-of select="@column"/></xsl:with-param>
								      		</xsl:call-template>
						      		</xsl:with-param>
					     		</xsl:call-template>
				     		</xsl:otherwise>
			     		</xsl:choose>
			     	</xsl:when>
				    <xsl:otherwise>
						<xsl:call-template name="input-field">
				      		<xsl:with-param name="label"><xsl:value-of select="@label"/></xsl:with-param>
				      		<xsl:with-param name="name"><xsl:value-of select="@column"/></xsl:with-param>
				      		<xsl:with-param name="required"><xsl:value-of select="@mandatory" /></xsl:with-param>
				      		<xsl:with-param name="maxsize"><xsl:value-of select="@length"/></xsl:with-param>
				      		<xsl:with-param name="size"><xsl:value-of select="@length"/></xsl:with-param>
				      		<xsl:with-param name="type"><xsl:value-of select="@type"/></xsl:with-param>
				      		<xsl:with-param name="appendClass"><xsl:value-of select="@appendClass"/></xsl:with-param>
							<xsl:with-param name="fieldsize"><xsl:value-of select="@fieldSize"/></xsl:with-param>
				      		<xsl:with-param name="value">
						      		<xsl:call-template name="selectkeyvalue">
						      			<xsl:with-param name="keyname"><xsl:value-of select="@column"/></xsl:with-param>
						      		</xsl:call-template>
				      		</xsl:with-param>
				     	</xsl:call-template>
			     	</xsl:otherwise>
		     	</xsl:choose>     		
		     </xsl:when>
		     <xsl:otherwise>
		     	<xsl:choose>
		     		<xsl:when test="@type='BANKABBREVNAME'">
		     			<xsl:call-template name="hidden-field">
			     			<xsl:with-param name="name"><xsl:value-of select="@column"/></xsl:with-param>
			     			<xsl:with-param name="value">
							      		<xsl:value-of select="$bankAbbvName"></xsl:value-of>
							</xsl:with-param>
			     		</xsl:call-template>
		     		</xsl:when>
		     		<xsl:otherwise>
			     		<xsl:call-template name="hidden-field">
			     			<xsl:with-param name="name"><xsl:value-of select="@column"/></xsl:with-param>
			     			<xsl:with-param name="value">
							      		<xsl:call-template name="selectkeyvalue">
							      			<xsl:with-param name="keyname"><xsl:value-of select="@column"/></xsl:with-param>
							      		</xsl:call-template>
					      	</xsl:with-param>
			     		</xsl:call-template>
		     		</xsl:otherwise>
		     	</xsl:choose>
		     </xsl:otherwise>
	     </xsl:choose>	
	</xsl:template>
	
	<!-- Template which builds the fields for data fields -->
	<xsl:template match="data">
		<xsl:choose>
			<xsl:when test="@hidden !='true'">
				<xsl:choose>
				    <xsl:when test="@type='COUNTRY_TYPE'">
				    	<xsl:call-template name="input-field">
				      		<xsl:with-param name="label"><xsl:value-of select="@label"/></xsl:with-param>
				      		<xsl:with-param name="name"><xsl:value-of select="@column"/>_country</xsl:with-param>
				      		<xsl:with-param name="required"><xsl:value-of select="@mandatory" /></xsl:with-param>
				      		<xsl:with-param name="prefix"><xsl:value-of select="@column"/></xsl:with-param>
				      		<xsl:with-param name="button-type">codevalue</xsl:with-param>
				      		<xsl:with-param name="maxsize"><xsl:value-of select="@length"/></xsl:with-param>
				      		<xsl:with-param name="appendClass"><xsl:value-of select="@appendClass"/></xsl:with-param>
				      		<xsl:with-param name="fieldsize">small</xsl:with-param>
				      		<xsl:with-param name="value">
					      		<xsl:call-template name="selectkeyvalue">
					      			<xsl:with-param name="keyname"><xsl:value-of select="@column"/></xsl:with-param>
					      			<xsl:with-param name="optiontype" select="true()"/>
					      		</xsl:call-template>
				      		</xsl:with-param>
			     		</xsl:call-template>
			     	</xsl:when>
			     	<xsl:when test="@type='DATE'">
				     		<xsl:call-template name="input-field">
					      		<xsl:with-param name="label"><xsl:value-of select="@label"/></xsl:with-param>
					      		<xsl:with-param name="name"><xsl:value-of select="@column"/></xsl:with-param>
					      		<xsl:with-param name="required"><xsl:value-of select="@mandatory" /></xsl:with-param>
					      		<xsl:with-param name="maxsize"><xsl:value-of select="@length"/></xsl:with-param>
					      		<xsl:with-param name="size"><xsl:value-of select="@length"/></xsl:with-param>
					      		<xsl:with-param name="type">date</xsl:with-param>
					      		<xsl:with-param name="appendClass"><xsl:value-of select="@appendClass"/></xsl:with-param>
					      		<xsl:with-param name="fieldsize">small</xsl:with-param>
					      		<xsl:with-param name="value">
							      		<xsl:call-template name="selectkeyvalue">
							      			<xsl:with-param name="keyname"><xsl:value-of select="@column"/></xsl:with-param>
							      		</xsl:call-template>
					      		</xsl:with-param>
					     	</xsl:call-template>
					</xsl:when>
					<xsl:when test="@type='USER_NAME'">
							<xsl:call-template name="hidden-field">
								<xsl:with-param name="name"><xsl:value-of select="@column"/></xsl:with-param>
								<xsl:with-param name="value">
							    	<xsl:value-of select="$userName"></xsl:value-of>
					      		</xsl:with-param>
							</xsl:call-template>
					</xsl:when>
			     	<xsl:when test="@type='TIME_ZONE'">
				    	<xsl:call-template name="select-field">
			     			<xsl:with-param name="label"><xsl:value-of select="@label"/></xsl:with-param>
							<xsl:with-param name="name"><xsl:value-of select="@column"/></xsl:with-param>
							<xsl:with-param name="maxsize"><xsl:value-of select="@length"/></xsl:with-param>
			     			<xsl:with-param name="required"><xsl:value-of select="@mandatory" /></xsl:with-param>
			     			<xsl:with-param name="appendClass"><xsl:value-of select="@appendClass"/></xsl:with-param>
							<xsl:with-param name="fieldsize"><xsl:value-of select="@fieldSize"/></xsl:with-param>
			     			<xsl:with-param name="options">
			     				<xsl:choose>
			     					<xsl:when test="$displaymode='edit'">
					     				<xsl:call-template name="time_zone-options"/>
			     					</xsl:when>
			     					<xsl:otherwise>
			     						<xsl:value-of select="time_zone" />
			     					</xsl:otherwise>
			     				</xsl:choose>
			     			</xsl:with-param>
			     		</xsl:call-template>
			     	</xsl:when>
			     	<xsl:when test="@type='HOUR'">
				     	<xsl:choose>
				     	    <xsl:when test="$displaymode='edit'">
					     	 	<xsl:call-template name="select-field">
									<xsl:with-param name="label"><xsl:value-of select="@label"/></xsl:with-param>
									<xsl:with-param name="name"><xsl:value-of select="@column"/></xsl:with-param>
									<xsl:with-param name="required"><xsl:value-of select="@mandatory" /></xsl:with-param>
									<xsl:with-param name="maxsize"><xsl:value-of select="@length"/></xsl:with-param>
									<xsl:with-param name="appendClass"><xsl:value-of select="@appendClass"/></xsl:with-param>
									<xsl:with-param name="fieldsize"><xsl:value-of select="@fieldSize"/></xsl:with-param>
									<xsl:with-param name="sort-filter-select">N</xsl:with-param>
									<xsl:with-param name="options">
										<xsl:call-template name="hours"/>
									</xsl:with-param>
									<xsl:with-param name="value">
										<xsl:variable name="keyname"><xsl:value-of select="@column"/></xsl:variable>
										<xsl:variable name="value"><xsl:value-of select="../../parameter_data/*[name()=$keyname]"/></xsl:variable>
										<xsl:value-of select="format-number($value, '00')"/>
				      				</xsl:with-param>
								 </xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
											<xsl:call-template name="input-field">
												<xsl:with-param name="label"><xsl:value-of select="@label"/></xsl:with-param>
												<xsl:with-param name="name"><xsl:value-of select="@column"/></xsl:with-param>
												<xsl:with-param name="appendClass"><xsl:value-of select="@appendClass"/></xsl:with-param>
												<xsl:with-param name="value">
										<xsl:variable name="keyname"><xsl:value-of select="@column"/></xsl:variable>
										<xsl:variable name="value"><xsl:value-of select="../../parameter_data/*[name()=$keyname]"/></xsl:variable>
										<xsl:value-of select="format-number($value, '00')"/>
						      					</xsl:with-param>
											</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
				     	</xsl:when>
			     	<xsl:when test="@type='MINUTE'">
			     		<xsl:choose>
			     	    	<xsl:when test="$displaymode='edit'">
				     	 	    <xsl:call-template name="select-field">
								<xsl:with-param name="label"><xsl:value-of select="@label"/></xsl:with-param>
								<xsl:with-param name="name"><xsl:value-of select="@column"/></xsl:with-param>
								<xsl:with-param name="required"><xsl:value-of select="@mandatory" /></xsl:with-param>
								<xsl:with-param name="maxsize"><xsl:value-of select="@length"/></xsl:with-param>
								<xsl:with-param name="appendClass"><xsl:value-of select="@appendClass"/></xsl:with-param>
								<xsl:with-param name="fieldsize"><xsl:value-of select="@fieldSize"/></xsl:with-param>
								<xsl:with-param name="sort-filter-select">N</xsl:with-param>
								<xsl:with-param name="options">
									<xsl:call-template name="minutes"/>
								</xsl:with-param>
								<xsl:with-param name="value">
									<xsl:variable name="keyname"><xsl:value-of select="@column"/></xsl:variable>
									<xsl:variable name="value"><xsl:value-of select="../../parameter_data/*[name()=$keyname]"/></xsl:variable>
									<xsl:value-of select="format-number($value, '00')"/>
			      				</xsl:with-param>
							  </xsl:call-template>
							 </xsl:when>
							 <xsl:otherwise>
										<xsl:call-template name="input-field">
											<xsl:with-param name="label"><xsl:value-of select="@label"/></xsl:with-param>
											<xsl:with-param name="name"><xsl:value-of select="@column"/></xsl:with-param>
											<xsl:with-param name="appendClass"><xsl:value-of select="@appendClass"/></xsl:with-param>
											<xsl:with-param name="value">
										<xsl:variable name="keyname"><xsl:value-of select="@column"/></xsl:variable>
										<xsl:variable name="value"><xsl:value-of select="../../parameter_data/*[name()=$keyname]"/></xsl:variable>
										<xsl:value-of select="format-number($value, '00')"/>
						      				</xsl:with-param>
										</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
			     	</xsl:when>
			     	<!-- the combo box for the business codes needs to be provided.
			     	 Technical approach is for all the business code build the code as store and 
			     	 supply for combo. This is to make sure that the only permissible codes are avilable for selection  --> 
			     	 <xsl:when test="@type='CODE' ">
			     	 	<xsl:choose>
			     	    	<xsl:when test="@code='N082'">
			     	    		<xsl:choose>
			     	    			<xsl:when test="$displaymode='edit'">
					     	    		<xsl:call-template name="select-field">
											<xsl:with-param name="label"><xsl:value-of select="@label"/></xsl:with-param>
											<xsl:with-param name="name"><xsl:value-of select="@column"/></xsl:with-param>
											<xsl:with-param name="required"><xsl:value-of select="@mandatory" /></xsl:with-param>
											<xsl:with-param name="maxsize"><xsl:value-of select="@length"/></xsl:with-param>
											<xsl:with-param name="appendClass"><xsl:value-of select="@appendClass"/></xsl:with-param>
											<xsl:with-param name="fieldsize"><xsl:value-of select="@fieldSize"/></xsl:with-param>
											<xsl:with-param name="sort-filter-select">N</xsl:with-param>
											<xsl:with-param name="options">
												<xsl:call-template name="dayofweek-options-java"/>
											</xsl:with-param>
											<xsl:with-param name="value">
									      		<xsl:call-template name="selectkeyvalue">
									      			<xsl:with-param name="type">list</xsl:with-param>
									      			<xsl:with-param name="keyname"><xsl:value-of select="@column"/></xsl:with-param>
									      		</xsl:call-template>
						      				</xsl:with-param>
										 </xsl:call-template>
									</xsl:when>
									<xsl:otherwise>
										<xsl:call-template name="input-field">
											<xsl:with-param name="label"><xsl:value-of select="@label"/></xsl:with-param>
											<xsl:with-param name="name"><xsl:value-of select="@column"/></xsl:with-param>
											<xsl:with-param name="value">
									      		<xsl:value-of select="localization:getDecode($language, 'N082', //key_9)"/>
						      				</xsl:with-param>
										 </xsl:call-template>
									</xsl:otherwise>
								 </xsl:choose>
			     	    	</xsl:when>
			     	    	<xsl:when test="@code='N001'">
			     	    		<xsl:choose>
				     	    		<xsl:when test="$displaymode = 'edit'">
					     	    		<xsl:call-template name="select-field">
												<xsl:with-param name="label"><xsl:value-of select="@label"/></xsl:with-param>
												<xsl:with-param name="name"><xsl:value-of select="@column"/></xsl:with-param>
												<xsl:with-param name="maxsize"><xsl:value-of select="@length"/></xsl:with-param>
												<xsl:with-param name="id">product_code</xsl:with-param>
												<xsl:with-param name="appendClass"><xsl:value-of select="@appendClass"/></xsl:with-param>
												<xsl:with-param name="fieldsize"><xsl:value-of select="@fieldSize"/></xsl:with-param>
												<xsl:with-param name="required"><xsl:value-of select="@mandatory" /></xsl:with-param>
												<xsl:with-param name="options">
													
														<option value="*">*</option>
													
													<xsl:apply-templates select="../../avail_products/product/product_code"/>
												</xsl:with-param>
												<xsl:with-param name="value">
										      		<xsl:call-template name="selectkeyvalue">
										      			<xsl:with-param name="keyname"><xsl:value-of select="@column"/></xsl:with-param>
										      			<xsl:with-param name="optiontype" select="true()"/>
										      		</xsl:call-template>
						      					</xsl:with-param>
										</xsl:call-template>
									</xsl:when>
									<xsl:otherwise>
										<xsl:call-template name="input-field">
													<xsl:with-param name="label"><xsl:value-of select="@label"/></xsl:with-param>
													<xsl:with-param name="name"><xsl:value-of select="@column"/></xsl:with-param>
													<xsl:with-param name="id">product_code</xsl:with-param>
													<xsl:with-param name="value">
														<xsl:value-of select="localization:getDecode($language, 'N001', //key_2)"/>
							      					</xsl:with-param>
											</xsl:call-template>
									</xsl:otherwise>
								</xsl:choose>
			     	    	</xsl:when>
			     	    	<xsl:when test="@code='N047'">
			     	    		<xsl:choose>
					     	    	<xsl:when test="$displaymode = 'edit'">
					     	    		<xsl:call-template name="select-field">
												<xsl:with-param name="label"><xsl:value-of select="@label"/></xsl:with-param>
												<xsl:with-param name="name"><xsl:value-of select="@column"/></xsl:with-param>
												<xsl:with-param name="id">sub_product_code</xsl:with-param>
												<xsl:with-param name="maxsize"><xsl:value-of select="@length"/></xsl:with-param>
												<xsl:with-param name="appendClass"><xsl:value-of select="@appendClass"/></xsl:with-param>
												<xsl:with-param name="fieldsize"><xsl:value-of select="@fieldSize"/></xsl:with-param>
												<xsl:with-param name="required"><xsl:value-of select="@mandatory" /></xsl:with-param>
												<xsl:with-param name="value">
									      		<xsl:call-template name="selectkeyvalue">
									      			<xsl:with-param name="keyname"><xsl:value-of select="@column"/></xsl:with-param>
									      			<xsl:with-param name="optiontype" select="true()"/>
									      		</xsl:call-template>
						      				</xsl:with-param>
										</xsl:call-template>
										<xsl:call-template name="hidden-field">
											<xsl:with-param name="name">sub_product_code_hidden</xsl:with-param>
											<xsl:with-param name="value">
												<xsl:call-template name="selectkeyvalue">
									      			<xsl:with-param name="keyname"><xsl:value-of select="@column"/></xsl:with-param>
									      			<xsl:with-param name="optiontype" select="true()"/>
									      		</xsl:call-template>
											</xsl:with-param>
										</xsl:call-template>
									</xsl:when>
									<xsl:otherwise>
										<xsl:call-template name="input-field">
												<xsl:with-param name="label"><xsl:value-of select="@label"/></xsl:with-param>
												<xsl:with-param name="name"><xsl:value-of select="@column"/></xsl:with-param>
												<xsl:with-param name="id">sub_product_code</xsl:with-param>
												<xsl:with-param name="value">
									      			<xsl:value-of select="localization:getDecode($language, 'N047', //key_3)"/>
						      					</xsl:with-param>
										</xsl:call-template>
										<xsl:call-template name="hidden-field">
											<xsl:with-param name="name">sub_product_code_hidden</xsl:with-param>
											<xsl:with-param name="value">
												<xsl:value-of select="localization:getDecode($language, 'N047', //key_3)"/>
											</xsl:with-param>
										</xsl:call-template>
									</xsl:otherwise>
								</xsl:choose>
			     	    	</xsl:when>
				     	    <xsl:otherwise>
				     	    	<xsl:call-template name="input-field">
						      		<xsl:with-param name="label"><xsl:value-of select="@label"/></xsl:with-param>
						      		<xsl:with-param name="name"><xsl:value-of select="@column"/></xsl:with-param>
						      		<xsl:with-param name="required"><xsl:value-of select="@mandatory" /></xsl:with-param>
						      		<xsl:with-param name="maxsize"><xsl:value-of select="@length"/></xsl:with-param>
						      		<xsl:with-param name="type"><xsl:value-of select="@type"/></xsl:with-param>
						      		<xsl:with-param name="appendClass"><xsl:value-of select="@appendClass"/></xsl:with-param>
									<xsl:with-param name="fieldsize"><xsl:value-of select="@fieldSize"/></xsl:with-param>
						      		<xsl:with-param name="value">
								      		<xsl:call-template name="selectkeyvalue">
								      			<xsl:with-param name="keyname"><xsl:value-of select="@column"/></xsl:with-param>
								      		</xsl:call-template>
						      		</xsl:with-param>
					     		</xsl:call-template>
				     		</xsl:otherwise>
			     		</xsl:choose>
			     	</xsl:when>
				    <xsl:otherwise>
						<xsl:call-template name="input-field">
				      		<xsl:with-param name="label"><xsl:value-of select="@label"/></xsl:with-param>
				      		<xsl:with-param name="name"><xsl:value-of select="@column"/></xsl:with-param>
				      		<xsl:with-param name="required"><xsl:value-of select="@mandatory" /></xsl:with-param>
				      		<xsl:with-param name="maxsize"><xsl:value-of select="@length"/></xsl:with-param>
				      		<xsl:with-param name="size"><xsl:value-of select="@length"/></xsl:with-param>
				      		<xsl:with-param name="type"><xsl:value-of select="@type"/></xsl:with-param>
				      		<xsl:with-param name="appendClass"><xsl:value-of select="@appendClass"/></xsl:with-param>
							<xsl:with-param name="fieldsize"><xsl:value-of select="@fieldSize"/></xsl:with-param>
				      		<xsl:with-param name="value">
						      		<xsl:call-template name="selectkeyvalue">
						      			<xsl:with-param name="keyname"><xsl:value-of select="@column"/></xsl:with-param>
						      		</xsl:call-template>
				      		</xsl:with-param>
				     	</xsl:call-template>
			     	</xsl:otherwise>
		     	</xsl:choose>
		     </xsl:when>
		     <xsl:otherwise>
		     	 <xsl:choose>
		     		<xsl:when test="@type='USER_ID'">
							<xsl:call-template name="hidden-field">
								<xsl:with-param name="name"><xsl:value-of select="@column"/></xsl:with-param>
								<xsl:with-param name="value">
							        <xsl:value-of select="$userId"></xsl:value-of>
					      		</xsl:with-param>
							</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
			     		<xsl:call-template name="hidden-field">
			     			<xsl:with-param name="name"><xsl:value-of select="@column"/></xsl:with-param>
			     			<xsl:with-param name="value">
							      		<xsl:call-template name="selectkeyvalue">
							      			<xsl:with-param name="keyname"><xsl:value-of select="@column"/></xsl:with-param>
							      		</xsl:call-template>
					      	</xsl:with-param>
			     		</xsl:call-template>
		     		</xsl:otherwise>
		     	</xsl:choose>
		     </xsl:otherwise>
	     </xsl:choose>	
	</xsl:template>
	
	<xsl:template match="key" mode="old">
	   <xsl:variable name="avail_prodcode"><xsl:value-of select="."/></xsl:variable>
	   <xsl:if test="$updateMode and @mandatory ='Y'" >
			<xsl:call-template name="hidden-field">
				    <xsl:with-param name="name">old_<xsl:value-of select="@column"/></xsl:with-param>
		     		<xsl:with-param name="value" >
		     			<xsl:call-template name="selectkeyvalue">
			      				<xsl:with-param name="keyname"><xsl:value-of select="@column"/></xsl:with-param>
			      		</xsl:call-template>
		     		</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name ="selectkeyvalue">
	   <xsl:param name="keyname"/>
	   <xsl:param name="type">input</xsl:param>
	   <xsl:param name="optiontype" select="false()"/>
	  		<xsl:variable name="value"><xsl:value-of select="../../parameter_data/*[name()=$keyname]"/></xsl:variable>
	  		<xsl:choose>
	  			<xsl:when test="boolean($optiontype) and $value ='*'">*</xsl:when>
	  			<xsl:when test="$type ='list' and (not($value))"  >-1</xsl:when>
	  			<xsl:otherwise><xsl:value-of select="$value" /></xsl:otherwise>
	  		</xsl:choose>	
	</xsl:template>
	
	<xsl:template name ="selectdatavalue">
	   <xsl:param name="keyname"/>
	   <xsl:param name="type">input</xsl:param>
	   <xsl:param name="optiontype" select="false()"/>
	   <xsl:param name="value"/>
	  		<xsl:choose>
	  			<xsl:when test="boolean($optiontype) and $value='*'">WILDCARD</xsl:when>
	  			<xsl:when test="$type ='list' and (not($value))"  >-1</xsl:when>
	  			<xsl:otherwise><xsl:value-of select="$value" /></xsl:otherwise>
	  		</xsl:choose>	
	</xsl:template>
	
	<xsl:template match="data_1" mode="input" >
		<xsl:choose>
		   <xsl:when test="$displaymode='edit'">
		    <option>
		     <xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
		     <xsl:value-of select="."/>
		    </option>
		   </xsl:when>
		   <xsl:otherwise>
		    <li><xsl:value-of select="."/></li>
		   </xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- Template for day select box option -->
	<xsl:template name="dayofweek-options-java">
	 <xsl:param name="label">N082_</xsl:param>
	 	 <option value="">
	     </option>
	 	 <option value="MO">
	        <xsl:value-of select="localization:getGTPString($language, concat($label,'MO'))"/>
	     </option>
	     <option value="TU">
	      <xsl:value-of select="localization:getGTPString($language, concat($label,'TU'))"/>
	     </option>
	     <option value="WE">
	      <xsl:value-of select="localization:getGTPString($language, concat($label,'WE'))"/>
	     </option>
	      <option value="TH">
	      <xsl:value-of select="localization:getGTPString($language, concat($label,'TH'))"/>
	     </option>
	      <option value="FR">
	      <xsl:value-of select="localization:getGTPString($language, concat($label,'FR'))"/>
	     </option>
	      <option value="SA">
	      <xsl:value-of select="localization:getGTPString($language, concat($label,'SA'))"/>
	     </option>
	      <option value="SU">
	      <xsl:value-of select="localization:getGTPString($language, concat($label,'SU'))"/>
	     </option>
	</xsl:template>
	
    <xsl:template name="hours">
		<xsl:param name="counter">0</xsl:param>
		<xsl:if test="$counter &lt;= 23">
			<option>
				<xsl:attribute name="value"><xsl:value-of select="format-number($counter, '00')"/></xsl:attribute>
				<xsl:value-of select="format-number($counter, '00')"/>
	     	</option>
	     	<xsl:call-template name="hours">
            	<xsl:with-param name="counter" select="$counter + 1"/>
        	</xsl:call-template>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="minutes">
	 	<xsl:param name="counter">0</xsl:param>
		<xsl:if test="$counter &lt;= 59">
			<option>
				<xsl:attribute name="value"><xsl:value-of select="format-number($counter, '00')"/></xsl:attribute>
				<xsl:value-of select="format-number($counter, '00')"/>
	     	</option>
	     	<xsl:call-template name="minutes">
            	<xsl:with-param name="counter" select="$counter + 1"/>
        	</xsl:call-template>
		</xsl:if>
	</xsl:template>
	    
	<xsl:template match="product_code">
	 	<xsl:variable name="avail_prodcode"><xsl:value-of select="."/></xsl:variable>
	 	<option>
			<xsl:attribute name="value"><xsl:value-of select="$avail_prodcode"/></xsl:attribute>
			<xsl:value-of select="localization:getDecode($language, 'N001', $avail_prodcode)"/>
		</option>
	</xsl:template>
	
	<xsl:template match="clearing_value">
	 	<xsl:variable name="clearing_code"><xsl:value-of select="."/></xsl:variable>
	 	<option>
			<xsl:attribute name="value"><xsl:value-of select="$clearing_code"/></xsl:attribute>
			<xsl:value-of select="localization:getDecode($language, 'N503', $clearing_code)"/>
		</option>
	</xsl:template>
	
	<xsl:template match="subscription_code">
	 	<option>
			<xsl:attribute name="value"><xsl:value-of select="./code"/></xsl:attribute>
			<xsl:value-of select="./description"/>
		</option>
	</xsl:template>
	
	<xsl:template name="paramid">
		<xsl:param name="multiple"/>
		<xsl:if test="$multiple='Multiple'" >
		<xsl:call-template name="hidden-field">
	     		<xsl:with-param name="name">old_param_id</xsl:with-param>
	     		<xsl:with-param name="value" >
	     				<xsl:value-of select="../parameter_data/*[name()='param_id']"></xsl:value-of>
	     		</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
	     		<xsl:with-param name="name">param_id</xsl:with-param>
	     		<xsl:with-param name="value" >
	     				<xsl:value-of select="../parameter_data/*[name()='param_id']"></xsl:value-of>
	     		</xsl:with-param>
		</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<xsl:template name="build-configurable-grid-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<script>
  		   dojo.addOnLoad(function() {	
  			    dojo.require(&quot;misys.grid.GridMultipleItems&quot;);
				dojo.require(&quot;dijit.form.Button&quot;);
   				dojo.require(&quot;misys.widget.Dialog&quot;);
				dojo.require(&quot;dijit._Contained&quot;);
				dojo.require(&quot;dijit._Widget&quot;);
				dojo.require(&quot;misys.layout.SimpleItem&quot;);	
			    dojo.declare(&quot;misys.widget.ConfigurableGridItem&quot;,[ dijit._Widget, dijit._Contained, misys.layout.SimpleItem ],{
						<xsl:for-each select="data">
							<xsl:value-of select="@column"/>: &quot;&quot;,
						</xsl:for-each>
						'edit':'',
	
						createItem: function()
						{
						console.debug("[GP] createItem start");
							var item = {
							<xsl:for-each select="data">
								<xsl:value-of select="@column"/>:this.get('<xsl:value-of select="@column"/>')<xsl:if test="not(position()=last())"> <xsl:text>,</xsl:text></xsl:if>
							</xsl:for-each>
							,
							'edit':this.get('edit')
							};
							if(this.hasChildren &amp;&amp; this.hasChildren())
							{
								dojo.forEach(this.getChildren(), function(child)
								{
									if (child.createItem)
									{
										item.push(child.createItem());
									}
								}, this);
				    		}
				    		console.debug("[GP] createItem End");
				    		return item;
						},
			
						constructor: function()
						{
							console.debug(&quot;[ConfigurableGridItem] constructor&quot;);
						}
					}
			    );  	 
		    	dojo.declare(&quot;misys.widget.ConfigurableGrid&quot;, [misys.grid.GridMultipleItems],{
			    	// Initialization parameters
			    	data: { identifier: 'store_id', label: 'store_id', items: [] },
					handle: null,
					templatePath: null,
					templateString: dojo.byId("configurable-grid-template").innerHTML,
					dialogId: 'configurable-grid-item-dialog-template',
					xmlTagName: 'data',
					xmlSubTagName: 'datum',
					hasEntity: 'Y',
					//gridColumns: ['data1', 'data2'],
					gridColumns: ['edit',<xsl:for-each select="data">'<xsl:value-of select="@column"/>'<xsl:if test="not(position()=last())"> <xsl:text>,</xsl:text></xsl:if></xsl:for-each>],
					
					propertiesMap: {
					<xsl:for-each select="data">
							<xsl:value-of select="@column"/>: '<xsl:value-of select="@column"/>',
					</xsl:for-each>
					uniqueRef: 'uniqueRef',
					edit:'edit'
					},
					layout: [
							<xsl:for-each select="data">
								<xsl:choose>
									<xsl:when test="./@hidden ='true'">
										{ name: '<xsl:value-of select="localization:getGTPString($language, @label)"/>', field: '<xsl:value-of select="@column"/>', width: '0%',headerStyles: 'display:none', cellStyles: 'display:none'},
									</xsl:when>
									<xsl:when test="./@type='DATE'">
										{ name: '<xsl:value-of select="localization:getGTPString($language, @label)"/>', field: '<xsl:value-of select="@column"/>', formatter: misys.grid.formatDateTimeColumn , width: '10%',cellStyles:'text-align:center' ,noresize:true},
									</xsl:when>
									<xsl:otherwise>
										{ name: "<xsl:value-of select="localization:getGTPString($language, @label)"/>", field: '<xsl:value-of select="@column"/>', width: '10%',cellStyles:'text-align:center' ,noresize:true},
									</xsl:otherwise>
								</xsl:choose>
							</xsl:for-each>
							<xsl:if test="$displaymode='edit'">
								{ name: ' ', field: 'actions', formatter: misys.grid.formatReportActions, width: '10%' , noresize:true}
								,
							</xsl:if>
							{ name: 'Id', field: 'store_id', headerStyles: 'display:none', cellStyles: 'display:none' }
							],
					startup: function()
					{
						console.debug("[ConfigurableGrid] startup start");
						// Prepare data store
						this.dataList = [];
						if(this.hasChildren())
						{
							dojo.forEach(this.getChildren(), function(child){
								// Mark the child as started.
								// This will prevent Dojo from parsing the child
								// as we don't want to make it appear on the form now.
								if (child.createItem)
								{
									var item = child.createItem();
									this.dataList.push(item);
								}
							}, this);
						}
						this.inherited(arguments);
						console.debug("[ConfigurableGrid] startup end");
					}
						<xsl:if test="$userIdExists">
						,
						openDialogFromExistingItem: function(items, request)
						{
							this.inherited(arguments);
							dijit.byId('<xsl:value-of select="data[(@type='USER_ID')]/@column"/>').set('value','<xsl:value-of select="$userId"/>');
							dijit.byId('<xsl:value-of select="data[(@type='USER_NAME')]/@column"/>').set('value','<xsl:value-of select="$userName"/>');
						}
					</xsl:if>
					,
					updateData: function(event)
					{	
						
						console.debug("[GP] updateData start");	
						this.inherited(arguments);
						if(dijit.byId("parm_id").get("value") == "P109")
						{
						var configurableItems = dijit.byId("configurable_grid_items");
						var date_data_1 = dijit.byId("data_1").get("value");
						var dateTimeColumnValue;
						var j = 0;
						dojo.forEach(configurableItems.store._arrayOfTopLevelItems, function(entry, i){
							  dateTimeColumnValue = configurableItems.store._arrayOfTopLevelItems[i].data_1[0];
							  console.debug(entry, "at index", i);
							  if(!dateTimeColumnValue.match(/^[0-9]+$/i))
							  {
							  	j=i;
							  }
							});
							//configurableItems.store._arrayOfTopLevelItems[j].data_1[0] = String(date_data_1.getTime());
						}
						console.debug("[GP] updateData end");
					},
					performValidation: function()
					{
						console.debug("[GP] validate start");
						if(this.validateDialog(true))
						{
							this.inherited(arguments);
						}
						console.debug("[GP] validate end");
					}
					
			  });
  		  });
		</script>
		<div dojoType="misys.widget.ConfigurableGrid" dialogId="configurable-grid-dialog-template">
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARA_ADD_DATA')"/></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_PARA_UPDATE_DATA')"/></xsl:attribute>
			<xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="paramdata" select="." />
					 <xsl:variable name="count">
    						<xsl:number/>
  					 </xsl:variable>
					
					<div dojoType="misys.widget.ConfigurableGridItem" >
											
						<xsl:for-each select="../../maintainParameter/data">
							<xsl:variable name="columnname" select="@column" />
							<xsl:attribute name="{$columnname}" >
								<xsl:call-template name="selectdatavalue">
		      							<xsl:with-param name="keyname"><xsl:value-of select="$columnname"/></xsl:with-param>
		      							<xsl:with-param name="value" select="$paramdata/*[name()=$columnname]"></xsl:with-param>
		      					</xsl:call-template>
		      				</xsl:attribute>
						</xsl:for-each>
						<xsl:attribute name="edit" >N</xsl:attribute>
					</div>
				</xsl:for-each>
			</xsl:if>
		</div>
	</xsl:template>
	
	<xsl:template name="configurable-grid-details">
		<xsl:call-template name="row-wrapper">
			<xsl:with-param name="content">
			&nbsp;
				<xsl:call-template name="build-configurable-grid-dojo-items">
					<xsl:with-param name="items" select="../parameter_data/data_record" />
					<xsl:with-param name="id">configurable_grid_items</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>	
		
	<xsl:template name="configurable-grid-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="configurable-grid-dialog-declaration" />
		<!-- Dialog End -->
		<div id="configurable-grid-template" style="display:none">
			<div class="clear">
				<p dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_GEN_PARAM_TABLE_FORMAT_NO_ROW')" />
				</p>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<p>
					<br></br>
				</p>
				<xsl:if test="$displaymode = 'edit'">
					<div dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
						dojoAttachPoint="addButtonNode">
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_ACTION_ADD')" />
					</div>
				</xsl:if>
			</div>
		</div>
	</xsl:template>
	
	<xsl:template name="configurable-grid-dialog-declaration">
		<div id="configurable-grid-dialog-template" style="display:none"
			class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
			<xsl:apply-templates select="data"/>
			<xsl:call-template name="hidden-field">
								<xsl:with-param name="name">edit</xsl:with-param>
								<xsl:with-param name="value">Y</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="label-wrapper">
				<xsl:with-param name="content">
					<div dojoType="dijit.form.Button" type="submit">
					<xsl:attribute name="onClick">dijit.byId('edit').set('value','Y'); </xsl:attribute>
					<xsl:if test="@name='P109'">
					<xsl:attribute name="onClick">dijit.byId('<xsl:value-of select="data[(@type='USER_NAME')]/@column"/>').set('value','<xsl:value-of select="$userName"/>');dijit.byId('configurable-grid-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
 					</xsl:if>
 						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
					</div>&nbsp;
					<div dojoType="dijit.form.Button">
						<xsl:attribute name="onmouseup">dijit.byId('configurable-grid-dialog-template').hide();</xsl:attribute>
						<xsl:value-of
							select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
					</div>
				</xsl:with-param>
			</xsl:call-template>
		</div>
	</xsl:template>
		
</xsl:stylesheet>