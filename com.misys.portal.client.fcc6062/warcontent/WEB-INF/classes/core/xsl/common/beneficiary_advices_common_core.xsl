<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Beneficiary Advice Section with Table Template

version:   1.0
date:      28/11/2011
author:    Gurudath Reddy (gurudath.reddy@misys.com)
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
	<xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
    
  <!-- Beneficiary Advice Section -->
  <xsl:template name="beneficiary-advices-section">
  	<xsl:param name="override-displaymode"><xsl:value-of select="$displaymode"/></xsl:param>
  	<xsl:param name="sub-product-code-widget-id"/> 
  	<xsl:param name="entity-widget-id"/>
  	<xsl:param name="bank-abbv-name-widget-id"/>
  	
  	<!-- Beneficiary Advice Hidden fields to store default values from Bene Master selection  -->
  	<div class="widgetContainer">
  		<xsl:call-template name="bene-adv-hidden-fields"/>
  	</div>
    <script>
    	dojo.ready(function(){
    		misys._config = misys._config || {};
			misys._config.bene_advice = {};
		});
    </script>
    <!-- Beneficiary Advice Container -->
  	<xsl:if test="(beneficiary_advice/parameter_config and $override-displaymode = 'edit') or (bene_adv_flag = 'Y' and $override-displaymode = 'view')">
	 <div id="beneficiaryAdvicesTransactionContainer">
  	 <xsl:call-template name="fieldset-wrapper">
      <xsl:with-param name="legend">XSL_HEADER_BENE_ADVICE_DETAILS</xsl:with-param>
      <xsl:with-param name="content">
	  	<div class="widgetContainer beneficiaryAdvicesTransactionContainer">
	  		<div>
  				<xsl:attribute name="class">
  					<xsl:choose>
  					<xsl:when test="$override-displaymode = 'view'">hide</xsl:when>
  					</xsl:choose>
  				</xsl:attribute>
			    <xsl:call-template name="multichoice-field">
				 	<xsl:with-param name="label">XSL_BENE_ADVICE_FLAG</xsl:with-param>
				 	<xsl:with-param name="type">checkbox</xsl:with-param>
				 	<xsl:with-param name="name">bene_adv_flag</xsl:with-param>
				 	<xsl:with-param name="override-displaymode">edit</xsl:with-param>
	          		<xsl:with-param name="readonly">
	           		 		<xsl:if test="$override-displaymode = 'view'">Y</xsl:if>
	           		</xsl:with-param>
			    </xsl:call-template>
		    </div>
		    <script>
				dojo.ready(function(){
					misys._config = misys._config || {};
					misys._config.bene_advice = {};
					
					dojo.mixin(misys._config.bene_advice,{
						parameterConfig : new Array(),
						beneAdvTemplates : new Array(),
						beneAdvTemplatesDescription : new Array(),
						beneAdvBankEntityTemplates : new Array(),
						postal_codes : {
									  		<xsl:for-each select="beneficiary_advice/postal_codes/postal_code">
										   		<xsl:value-of select="code"/>:'<xsl:value-of select="length" />'
										   		<xsl:if test="position()!=last()">,</xsl:if>
									  		</xsl:for-each>
			  							},
			  			beneAdvSubProductCodeWidgetId : '<xsl:value-of select="$sub-product-code-widget-id"/>',
			  			beneAdvEntityWidgetId : '<xsl:value-of select="$entity-widget-id"/>',
			  			beneAdvBankAbbvNameWidgetId :  '<xsl:value-of select="$bank-abbv-name-widget-id"/>',
			  			beneAdvTableFormat : "<xsl:value-of select="bene_adv_table_format"/>",
			  			beneAdvTableFormatTime : '<xsl:value-of select="bene_adv_table_format_time"/>'
			  			<xsl:if test="bene_advice_table_data">
			  			,beneAdvTableData : <xsl:value-of select="bene_advice_table_data"/>
			  			</xsl:if>
			  			<xsl:if test="bene_adv_table_format_json">
			  			,beneAdvTableFormatJson : <xsl:value-of select="bene_adv_table_format_json"/>
			  			</xsl:if>
					});
					<xsl:for-each select="beneficiary_advice/parameter_config">
							<xsl:variable name="config" select="."/>
							misys._config.bene_advice.parameterConfig["<xsl:value-of select="$config/sub_product_code"/>"] = <xsl:value-of select="$config/parameters"/>;
					</xsl:for-each>
					<xsl:for-each select="beneficiary_advice/table_designer/template">
							<xsl:variable name="templates" select="."/>
							misys._config.bene_advice.beneAdvTemplates["<xsl:value-of select="$templates/template_id"/>"] = <xsl:value-of select="$templates/template_json"/>;
							misys._config.bene_advice.beneAdvTemplatesDescription["<xsl:value-of select="$templates/template_id"/>"] = "<xsl:value-of select="$templates/template_description"/>";
					</xsl:for-each>
					<xsl:for-each select="beneficiary_advice/table_designer/bank">
							<xsl:variable name="bank" select="."/>
							misys._config.bene_advice.beneAdvBankEntityTemplates["<xsl:value-of select="$bank/bank_abbv_name"/>"] = new Array(<xsl:value-of select="count($bank/entity)"/>);
							<xsl:for-each select="$bank/entity">
								<xsl:variable name="entity" select="."/>
								misys._config.bene_advice.beneAdvBankEntityTemplates["<xsl:value-of select="$bank/bank_abbv_name"/>"]["<xsl:value-of select="$entity/entity_abbv_name"/>"] = [
									{ value:"",name:""},
									<xsl:for-each select="$entity/entity_templates/entity_template">
											<xsl:variable name="entity_template" select="."/>
											{ value:"<xsl:value-of select="$entity_template/template_id"/>",
								         	  name:"<xsl:value-of select="$entity_template/template_id"/>"}
					   						<xsl:if test="not(position()=last())">,</xsl:if>
									</xsl:for-each>	
								];
							</xsl:for-each>
					</xsl:for-each>
				});
				<xsl:if test="$override-displaymode = 'view'">
					dojo.subscribe('ready',function(){
							misys.handleBeneAdvViewMode();
					});
				</xsl:if>
			</script>
		 	<div id="beneAdvDiv">
		 		<!-- Beneficiary Advice Destination Details -->
		    	<xsl:call-template name="animatedFieldSetHeader">
			   		<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DESTINATION_DETAILS')"/></xsl:with-param>
			   		<xsl:with-param name="animateDivId">destination-details</xsl:with-param>
			   		<xsl:with-param name="prefix">bene_adv_dest</xsl:with-param>
			   		<xsl:with-param name="onClickFlag">N</xsl:with-param>
			   	</xsl:call-template>
			    <xsl:call-template name="bene-adv-dest-details">
		 			<xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
		 		</xsl:call-template>
				 	
				<!-- Beneficiary Advice Content -->
				<xsl:call-template name="animatedFieldSetHeader">
			   		<xsl:with-param name="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_ADV_CONTENT')"/></xsl:with-param>
			   		<xsl:with-param name="animateDivId">advice-content</xsl:with-param>
			   		<xsl:with-param name="prefix">bene_adv_advice_content</xsl:with-param>
			   		<xsl:with-param name="onClickFlag">N</xsl:with-param>
			   	</xsl:call-template>
			   	<xsl:call-template name="bene-adv-advice-content">
			   		<xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
		 		</xsl:call-template>
			</div>
		 </div>
		 </xsl:with-param>
	 	</xsl:call-template>
	   </div>
	 </xsl:if>
   </xsl:template>
   
   <!-- Beneficiary Advice Destination Details -->
   <xsl:template name="bene-adv-dest-details">
   		<xsl:param name="override-displaymode"/>
	     <div id="destination-details">
	   		<div style="font-weight:bold;margin-left:100px;"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE')"/></div>
		    <div id="beneAdvEmailDiv">
		    	<xsl:if test="($override-displaymode = 'edit') or ($override-displaymode = 'view' and bene_adv_email_flag = 'Y')">
			 		<xsl:call-template name="multioption-inline-wrapper">
					      <xsl:with-param name="group-label">XSL_BENE_ADVICE_EMAIL</xsl:with-param>
					      <xsl:with-param name="content">
						         <xsl:call-template name="multichoice-field">
					 		    	<xsl:with-param name="group-label">XSL_BENE_ADVICE_EMAIL</xsl:with-param>
				          		 	<xsl:with-param name="label"></xsl:with-param>
				          		 	<xsl:with-param name="type">checkbox</xsl:with-param>
				           		 	<xsl:with-param name="name">bene_adv_email_flag</xsl:with-param>
				           		 	<xsl:with-param name="inline">Y</xsl:with-param>
				           		 	<xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
					            </xsl:call-template>
							    <div id="beneAdvEmailDiv1" class="inlineBlock"> 
						 		  	<xsl:call-template name="input-field">
									    <xsl:with-param name="name">bene_adv_email_1</xsl:with-param>
									    <xsl:with-param name="size">50</xsl:with-param>
	      								<xsl:with-param name="maxsize">50</xsl:with-param>
									    <xsl:with-param name="appendClass">inlineBlock inlineBlockNoLabel</xsl:with-param>
									    <xsl:with-param name="swift-validate">N</xsl:with-param>
									    <xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
									</xsl:call-template>
							    </div>
					    	</xsl:with-param>
				    </xsl:call-template>
				    <div id="beneAdvEmailDiv2" >
			 		  	<xsl:call-template name="input-field">
						    <xsl:with-param name="name">bene_adv_email_21</xsl:with-param>
						    <xsl:with-param name="size">50</xsl:with-param>
	      					<xsl:with-param name="maxsize">50</xsl:with-param>
	      					<xsl:with-param name="swift-validate">N</xsl:with-param>
	      					<xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
					    </xsl:call-template>
					    <xsl:call-template name="input-field">
						    <xsl:with-param name="name">bene_adv_email_22</xsl:with-param>
						    <xsl:with-param name="size">50</xsl:with-param>
	      					<xsl:with-param name="maxsize">50</xsl:with-param>
	      					<xsl:with-param name="swift-validate">N</xsl:with-param>
	      					<xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
					    </xsl:call-template>
					</div>
				</xsl:if>
			</div>
			<div id="beneAdvPhoneDiv">
				<xsl:if test="($override-displaymode = 'edit') or ($override-displaymode = 'view' and bene_adv_phone_flag = 'Y')">
			 		<xsl:call-template name="multioption-inline-wrapper">
					      <xsl:with-param name="group-label">XSL_BENE_ADVICE_PHONE</xsl:with-param>
					      <xsl:with-param name="content">
						         <xsl:call-template name="multichoice-field">
					 		    	<xsl:with-param name="group-label">XSL_BENE_ADVICE_PHONE</xsl:with-param>
				          		 	<xsl:with-param name="type">checkbox</xsl:with-param>
				           		 	<xsl:with-param name="name">bene_adv_phone_flag</xsl:with-param>
				           		 	<xsl:with-param name="inline">Y</xsl:with-param>
				           		 	<xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
					            </xsl:call-template>
							    <xsl:call-template name="input-field">
								    <xsl:with-param name="name">bene_adv_phone</xsl:with-param>
								    <xsl:with-param name="size">30</xsl:with-param>
	      							<xsl:with-param name="maxsize">30</xsl:with-param>
								    <xsl:with-param name="appendClass">inlineBlock inlineBlockNoLabel</xsl:with-param>
								    <xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
							    </xsl:call-template>
						  </xsl:with-param>
				    </xsl:call-template>
			    </xsl:if>
			</div>
			<div id="beneAdvFaxDiv">
				<xsl:if test="($override-displaymode = 'edit') or ($override-displaymode = 'view' and bene_adv_fax_flag = 'Y')">
			 		<xsl:call-template name="multioption-inline-wrapper">
					      <xsl:with-param name="group-label">XSL_BENE_ADVICE_FAX</xsl:with-param>
					      <xsl:with-param name="content">
						         <xsl:call-template name="multichoice-field">
					 		    	<xsl:with-param name="group-label">XSL_BENE_ADVICE_FAX</xsl:with-param>
				          		 	<xsl:with-param name="type">checkbox</xsl:with-param>
				           		 	<xsl:with-param name="name">bene_adv_fax_flag</xsl:with-param>
				           		 	<xsl:with-param name="inline">Y</xsl:with-param>
				           		 	<xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
					            </xsl:call-template>
							    <xsl:call-template name="input-field">
								    <xsl:with-param name="name">bene_adv_fax</xsl:with-param>
								    <xsl:with-param name="size">30</xsl:with-param>
	      							<xsl:with-param name="maxsize">30</xsl:with-param>
								    <xsl:with-param name="appendClass">inlineBlock inlineBlockNoLabel</xsl:with-param>
								    <xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
							    </xsl:call-template>
						  </xsl:with-param>
				    </xsl:call-template>
			    </xsl:if>
			</div>
			<div id="beneAdvIVRDiv">
				<xsl:if test="($override-displaymode = 'edit') or ($override-displaymode = 'view' and bene_adv_ivr_flag = 'Y')">
			 		<xsl:call-template name="multioption-inline-wrapper">
					      <xsl:with-param name="group-label">XSL_BENE_ADVICE_IVR</xsl:with-param>
					      <xsl:with-param name="content">
						         <xsl:call-template name="multichoice-field">
					 		    	<xsl:with-param name="group-label">XSL_BENE_ADVICE_IVR</xsl:with-param>
				          		 	<xsl:with-param name="type">checkbox</xsl:with-param>
				           		 	<xsl:with-param name="name">bene_adv_ivr_flag</xsl:with-param>
				           		 	<xsl:with-param name="inline">Y</xsl:with-param>
				           		 	<xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
					            </xsl:call-template>
							    <xsl:call-template name="input-field">
								    <xsl:with-param name="name">bene_adv_ivr</xsl:with-param>
								    <xsl:with-param name="size">15</xsl:with-param>
	      							<xsl:with-param name="maxsize">15</xsl:with-param>
								    <xsl:with-param name="appendClass">inlineBlock inlineBlockNoLabel</xsl:with-param>
								    <xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
							    </xsl:call-template>
						  </xsl:with-param>
				    </xsl:call-template>
			    </xsl:if>
			</div>
			<div id="beneAdvPrintDiv">
				<xsl:call-template name="multioption-inline-wrapper">
				      <xsl:with-param name="group-label">XSL_BENE_ADVICE_PRINT</xsl:with-param>
				      <xsl:with-param name="content">
					      <div>
			  				<xsl:attribute name="class">
			  					<xsl:choose>
			  					<xsl:when test="$override-displaymode = 'view'">hide</xsl:when>
			  					<xsl:otherwise>inlineBlock</xsl:otherwise>
			  					</xsl:choose>
			  				</xsl:attribute>
					        <xsl:call-template name="multichoice-field">
				 		    	<xsl:with-param name="group-label">XSL_BENE_ADVICE_PRINT</xsl:with-param>
			          		 	<xsl:with-param name="type">checkbox</xsl:with-param>
			           		 	<xsl:with-param name="name">bene_adv_print_flag</xsl:with-param>
			           		 	<xsl:with-param name="inline">Y</xsl:with-param>
			           		 	<xsl:with-param name="checked">Y</xsl:with-param>
			           		 	<xsl:with-param name="readonly">Y</xsl:with-param>
			           		 	<xsl:with-param name="override-displaymode">edit</xsl:with-param>
			           		</xsl:call-template>
			           	 </div>
			           	 <div>
			           	 	<xsl:attribute name="class">
			  					<xsl:choose> 
			  					<xsl:when test="$override-displaymode = 'edit'">hide</xsl:when>
			  					<xsl:otherwise>inlineBlock</xsl:otherwise>
			  					</xsl:choose>
			  				</xsl:attribute>
			           	 	<b>Yes</b>
			           	 </div>
					  </xsl:with-param>
			    </xsl:call-template>
			</div>
			<div id="beneAdvMailDiv">
				<xsl:if test="($override-displaymode = 'edit') or ($override-displaymode = 'view' and bene_adv_mail_flag = 'Y')">
			 		<xsl:call-template name="multioption-inline-wrapper">
					      <xsl:with-param name="group-label">XSL_BENE_ADVICE_MAIL</xsl:with-param>
					      <xsl:with-param name="content">
					      		<div>
					  				<xsl:attribute name="class">
					  					<xsl:choose>
					  					<xsl:when test="$override-displaymode = 'view'">hide</xsl:when>
					  					<xsl:otherwise>inlineBlock</xsl:otherwise>
					  					</xsl:choose>
					  				</xsl:attribute>
							        <xsl:call-template name="multichoice-field">
						 		    	<xsl:with-param name="group-label">XSL_BENE_ADVICE_MAIL</xsl:with-param>
					          		 	<xsl:with-param name="type">checkbox</xsl:with-param>
					           		 	<xsl:with-param name="name">bene_adv_mail_flag</xsl:with-param>
					           		 	<xsl:with-param name="inline">Y</xsl:with-param>
					           		 	<xsl:with-param name="override-displaymode">edit</xsl:with-param>
					           		 	<xsl:with-param name="readonly">
						           		 		<xsl:if test="$override-displaymode = 'view'">Y</xsl:if>
						           		</xsl:with-param>
						            </xsl:call-template>
						        </div>
						        <div>
					           	 	<xsl:attribute name="class">
					  					<xsl:choose> 
					  					<xsl:when test="$override-displaymode = 'edit'">hide</xsl:when>
					  					<xsl:otherwise>inlineBlock</xsl:otherwise>
					  					</xsl:choose>
					  				</xsl:attribute>
					           	 	<b>Yes</b>
					           	 </div>
						  </xsl:with-param>
				    </xsl:call-template>
			    </xsl:if>
			</div>
			<xsl:if test="($override-displaymode = 'edit') or ($override-displaymode = 'view' and bene_adv_mail_flag = 'Y')">
				<div class="indented-header" id="mailAdditionalDetails">
					<h3 class="toc-item">
						<span class="legend"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_MAIL_ADDITIONAL_DETAILS')"/></span>
					</h3>
					<div class="fieldset-content">
					    <xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_BENE_ADVICE_MAILING_NAME_ADDRESS</xsl:with-param>
							<xsl:with-param name="name">bene_adv_mailing_name_add_1</xsl:with-param>
							<xsl:with-param name="size">40</xsl:with-param>
	      					<xsl:with-param name="maxsize">40</xsl:with-param>
	      					<xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">bene_adv_mailing_name_add_2</xsl:with-param>
							<xsl:with-param name="size">40</xsl:with-param>
	      					<xsl:with-param name="maxsize">40</xsl:with-param>
	      					<xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">bene_adv_mailing_name_add_3</xsl:with-param>
							<xsl:with-param name="size">40</xsl:with-param>
	      					<xsl:with-param name="maxsize">40</xsl:with-param>
	      					<xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">bene_adv_mailing_name_add_4</xsl:with-param>
							<xsl:with-param name="size">40</xsl:with-param>
	      					<xsl:with-param name="maxsize">40</xsl:with-param>
	      					<xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">bene_adv_mailing_name_add_5</xsl:with-param>
							<xsl:with-param name="size">40</xsl:with-param>
	      					<xsl:with-param name="maxsize">40</xsl:with-param>
	      					<xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">bene_adv_mailing_name_add_6</xsl:with-param>
							<xsl:with-param name="size">40</xsl:with-param>
	      					<xsl:with-param name="maxsize">40</xsl:with-param>
	      					<xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
			      			<xsl:with-param name="label">XSL_BENEFICIARY_POSTAL_CODE</xsl:with-param>
			      			<xsl:with-param name="name">bene_adv_postal_code</xsl:with-param>
			      			<xsl:with-param name="size">15</xsl:with-param>
			       			<xsl:with-param name="maxsize">15</xsl:with-param>
			       			<xsl:with-param name="fieldsize">small</xsl:with-param>
			       			<xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
			       			<xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
			    		</xsl:call-template>
			    		<xsl:call-template name="country-field">
			    			<xsl:with-param name="label">XSL_BENEFICIARY_COUNTRY</xsl:with-param>
			      			<xsl:with-param name="name">bene_adv_country</xsl:with-param>
			      			<xsl:with-param name="prefix">bene_adv</xsl:with-param>
			      			<xsl:with-param name="appendClass">inlineBlock beneAdvCountry</xsl:with-param>
			      			<xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
			    		</xsl:call-template>
					</div>
				</div>
			</xsl:if>
		</div>
   </xsl:template>
   
   <!-- Beneficiary Advice Content -->
   <xsl:template name="bene-adv-advice-content">
   	 <xsl:param name="override-displaymode"/>
	   	<div id="advice-content">
			<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_BENE_ADVICE_BENEFICIARY_ID</xsl:with-param>
					<xsl:with-param name="name">bene_adv_beneficiary_id</xsl:with-param>
					<xsl:with-param name="size">20</xsl:with-param>
		       		<xsl:with-param name="maxsize">20</xsl:with-param>
		       		<xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_BENE_ADVICE_PAYER_NAME</xsl:with-param>
				<xsl:with-param name="name">bene_adv_payer_name_1</xsl:with-param>
				<xsl:with-param name="size">40</xsl:with-param>
		        <xsl:with-param name="maxsize">40</xsl:with-param>
		        <xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="input-field">
				<xsl:with-param name="name">bene_adv_payer_name_2</xsl:with-param>
				<xsl:with-param name="size">40</xsl:with-param>
		       	<xsl:with-param name="maxsize">40</xsl:with-param>
		       	<xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_BENE_ADVICE_PAYER_REF_NO</xsl:with-param>
				<xsl:with-param name="name">bene_adv_payer_ref_no</xsl:with-param>
				<xsl:with-param name="size">30</xsl:with-param>
		       	<xsl:with-param name="maxsize">30</xsl:with-param>
		       	<xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
			</xsl:call-template>
			<div id="bene_advice_msg_note_div">
				<xsl:call-template name="row-wrapper">
					  <xsl:with-param name="label">XSL_BENE_ADVICE_FREE_FORMAT_MSG</xsl:with-param>
				      <xsl:with-param name="type">textarea</xsl:with-param>
				      <xsl:with-param name="content">
					       <xsl:call-template name="textarea-field">
						        <xsl:with-param name="name">bene_adv_free_format_msg</xsl:with-param>
						        <xsl:with-param name="rows">4</xsl:with-param>
								<xsl:with-param name="cols">65</xsl:with-param>
								<xsl:with-param name="maxlines">4</xsl:with-param>
								<xsl:with-param name="swift-validate">N</xsl:with-param>
								<xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
							</xsl:call-template>
				      </xsl:with-param>
	     		</xsl:call-template>
	     		<br/>
	     		<xsl:if test="$override-displaymode = 'edit'">
	     			<div style="font-weight:bold;margin-left:358px;font-style:italic;"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_NOTE')"/></div>
	     		</xsl:if>
			</div>
			<div id="beneAdvTemplateDiv">
				<xsl:call-template name="select-field">
			      <xsl:with-param name="label">XSL_BENE_ADVICE_TABLE_FORMAT</xsl:with-param>
			      <xsl:with-param name="name">bene_adv_table_format</xsl:with-param>
			      <xsl:with-param name="override-displaymode"><xsl:value-of select="$override-displaymode"/></xsl:with-param>
			      <xsl:with-param name="options">
			      	<xsl:if test="$override-displaymode = 'view'">
			      		<xsl:value-of select="bene_adv_table_format_view"/>
			      	</xsl:if>
			      </xsl:with-param>
			    </xsl:call-template>
			    <!-- Beneficiary Advice Template Tables will be append here from JS dynamically -->
			    <div id="beneAdvTableDivContainer" style="margin:10px 7px 0px;display:none;width:100%;">
					<div class="indented-header">
						<h3 class="toc-item">
							<span class="legend"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_TABULAR_TEMPLATE')"/></span>
						</h3>
					</div>
				</div>
			</div>
		</div>
   </xsl:template>
   
   <!-- Beneficiary Advice Table Dialog for GridMultipleItem -->
   <xsl:template name="bene-advices-dialog-template">
   		<div id="beneAdvDialogDivContainer">
	    	<div id="beneAdvTable-dialog-template" style="display:none" class="widgetContainer">
	    		<div id="beneAdvTable-dialog-template-content">
	    		</div>
	    		<div class="dijitDialogPaneActionBar">
					<xsl:call-template name="label-wrapper">
						<xsl:with-param name="content">
							<button dojoType="dijit.form.Button" type="button" id="beneAdvDialogOkButton">
								<xsl:attribute name="onClick">misys.updateGridDataFromDialog();</xsl:attribute>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')"/>
							</button>
							<button dojoType="dijit.form.Button" type="button" id="beneAdvDialogCancelButton">
								<xsl:attribute name="onClick">dijit.byId('beneAdvTable-dialog-template').hide();</xsl:attribute>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')"/>
							</button>
						</xsl:with-param>
					</xsl:call-template>
				</div>
	    	</div>
	    </div>
	    <div id="beneAdvTable-template" style="display:none">
			<div class="clear">
				<p dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADV_NO_ROW_ADDED')"/>
				</p>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode"/>
				</div>
				<button dojoType="dijit.form.Button" type="button" id="addBeneAdvTableButton" dojoAttachEvent="onClick: addItem" dojoAttachPoint="addButtonNode">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_ADD_ROW')"/>
				</button>
			</div>
		</div>
   </xsl:template>
   
   <!-- Beneficiary Advice hidden fields for defaulting values from Bene Master -->
   <xsl:template name="bene-adv-hidden-fields">
   			<xsl:call-template name="hidden-field">
   				<xsl:with-param name="name">bene_adv_beneficiary_id_no_send</xsl:with-param>
   			</xsl:call-template>
   			<xsl:call-template name="hidden-field">
   				<xsl:with-param name="name">bene_adv_mailing_name_add_1_no_send</xsl:with-param>
   			</xsl:call-template>
   			<xsl:call-template name="hidden-field">
   				<xsl:with-param name="name">bene_adv_mailing_name_add_2_no_send</xsl:with-param>
   			</xsl:call-template>
   			<xsl:call-template name="hidden-field">
   				<xsl:with-param name="name">bene_adv_mailing_name_add_3_no_send</xsl:with-param>
   			</xsl:call-template>
   			<xsl:call-template name="hidden-field">
   				<xsl:with-param name="name">bene_adv_mailing_name_add_4_no_send</xsl:with-param>
   			</xsl:call-template>
   			<xsl:call-template name="hidden-field">
   				<xsl:with-param name="name">bene_adv_mailing_name_add_5_no_send</xsl:with-param>
   			</xsl:call-template>
   			<xsl:call-template name="hidden-field">
   				<xsl:with-param name="name">bene_adv_mailing_name_add_6_no_send</xsl:with-param>
   			</xsl:call-template>
   			<xsl:call-template name="hidden-field">
   				<xsl:with-param name="name">bene_adv_postal_code_no_send</xsl:with-param>
   			</xsl:call-template>
   			<xsl:call-template name="hidden-field">
   				<xsl:with-param name="name">bene_adv_country_no_send</xsl:with-param>
   			</xsl:call-template>
   			<xsl:call-template name="hidden-field">
   				<xsl:with-param name="name">bene_adv_email_no_send</xsl:with-param>
   			</xsl:call-template>
   			<xsl:call-template name="hidden-field">
   				<xsl:with-param name="name">bene_adv_email_no_send1</xsl:with-param>
   			</xsl:call-template>
   			<xsl:call-template name="hidden-field">
   				<xsl:with-param name="name">beneficiary_postal_code</xsl:with-param>
   			</xsl:call-template>
   			<xsl:call-template name="hidden-field">
   				<xsl:with-param name="name">beneficiary_country</xsl:with-param>
   				<xsl:with-param name="value"><xsl:value-of select="counterparties/counterparty/counterparty_country" /></xsl:with-param>
   			</xsl:call-template>
   			<xsl:call-template name="hidden-field">
   				<xsl:with-param name="name">bene_adv_fax_no_send</xsl:with-param>
   			</xsl:call-template>
   			<xsl:call-template name="hidden-field">
   				<xsl:with-param name="name">bene_adv_ivr_no_send</xsl:with-param>
   			</xsl:call-template>
   			<xsl:call-template name="hidden-field">
   				<xsl:with-param name="name">bene_adv_phone_no_send</xsl:with-param>
   			</xsl:call-template>
</xsl:template>
</xsl:stylesheet>