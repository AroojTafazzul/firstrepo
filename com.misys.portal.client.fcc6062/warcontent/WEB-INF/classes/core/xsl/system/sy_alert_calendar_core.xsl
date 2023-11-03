<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 		
		xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization" 		
		xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		exclude-result-prefixes="xmlRender localization security securityCheck utils defaultresource">


<!-- Global Parameters. -->
<xsl:param name="language">en</xsl:param>
<xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
<xsl:param name="nextscreen" />
<xsl:param name="option" />
<xsl:param name="rundata" />
<xsl:param name="token"/>
<xsl:param name="alert_global_code">N050</xsl:param>
<xsl:param name="parm_id" />
<xsl:param name="company_name_param"><xsl:value-of select="alert_records/static_company/abbv_name"/></xsl:param>
<xsl:param name="company_type_param"><xsl:value-of select="alert_records/static_company/type"/></xsl:param>
<xsl:param name="languages" />
<xsl:param name="hasEntities">
	<xsl:choose>
		<xsl:when test="alert_records/entities">Y</xsl:when>
		<xsl:otherwise>N</xsl:otherwise>
	</xsl:choose>
</xsl:param>
<xsl:variable name="isSwift2019Enabled" select="defaultresource:isSwift2019Enabled()"/>
<xsl:param name="main-form-name">fakeform1</xsl:param>
<xsl:param name="displaymode">edit</xsl:param>  


<!-- Global Imports. -->
<xsl:include href="../common/system_common.xsl" />
<xsl:include href="../common/attachment_templates.xsl" />
 <xsl:include href="../../../core/xsl/system/sy_reauthenticationdialog.xsl" />
 <xsl:include href="../../../core/xsl/common/e2ee_common.xsl" />

	
<!-- Output -->  
<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />

  
<!-- MAIN -->
<xsl:template match="alert_records">
	<!-- Loading message  -->
	<xsl:call-template name="loading-message" />
	<script>
		dojo.ready(function(){
			misys._config = misys._config || {};
			dojo.mixin(misys._config, {
				languagesCollection : {
				<xsl:for-each select="$languages/languages/language">
					<xsl:variable name="optionLanguage"><xsl:value-of select="."/></xsl:variable>
	        		"<xsl:value-of select="$optionLanguage"/>":"<xsl:value-of select="localization:getDecode($language, 'N061', $optionLanguage)"/>",
       			</xsl:for-each>
       			"*":"*"},
       			datesCollection : {
				<xsl:for-each select="//date/localization">
					<xsl:variable name="optionDate"><xsl:value-of select="."/></xsl:variable>
	        		"<xsl:value-of select="$optionDate"/>":"<xsl:value-of select="localization:getString($language, $optionDate)"/>",
       			</xsl:for-each>
       			"":""},
       			productsCollection : {
        		<xsl:for-each select="//alert_records/avail_products/product_code">
         			<xsl:variable name="avail_prodcode"><xsl:value-of select="."/></xsl:variable>
   					<xsl:choose>
			     		<xsl:when test="($isSwift2019Enabled = 'true') and $avail_prodcode = 'BG'">
			     	 		"<xsl:value-of select="$avail_prodcode"/>":"<xsl:value-of select="localization:getDecode($language, 'N001', 'IU')"/>",
						</xsl:when>
						<xsl:when test="($isSwift2019Enabled = 'true') and $avail_prodcode = 'BR'">
			     	 		"<xsl:value-of select="$avail_prodcode"/>":"<xsl:value-of select="localization:getDecode($language, 'N001', 'RU')"/>",
						</xsl:when>
			     	 	<xsl:otherwise>
			     	 		"<xsl:value-of select="$avail_prodcode"/>":"<xsl:value-of select="localization:getDecode($language, 'N001', $avail_prodcode)"/>",
						</xsl:otherwise>
		     		</xsl:choose>
         		</xsl:for-each>
       				"*":"*"},
       			typesCollection : {
					"01":"<xsl:value-of select="localization:getDecode($language, 'N002', '01')"/>",
					"03":"<xsl:value-of select="localization:getDecode($language, 'N002', '03')"/>",
					"13":"<xsl:value-of select="localization:getDecode($language, 'N002', '13')"/>",
					"15":"<xsl:value-of select="localization:getDecode($language, 'N002', '15')"/>",
					"18":"<xsl:value-of select="localization:getDecode($language, 'N002', '18')"/>",
					"*":"*"},
				recipientCollection : {
					"INPUT_USER":"<xsl:value-of select="localization:getGTPString($language, 'INP_USER')"/>",
					"CONTROL_USER":"<xsl:value-of select="localization:getGTPString($language, 'CTL_USER')"/>",
					"RELEASE_USER":"<xsl:value-of select="localization:getGTPString($language, 'RLS_USER')"/>",
					"BO_INPUT_USER":"<xsl:value-of select="localization:getGTPString($language, 'INP_USER')"/>",
					"BO_CONTROL_USER":"<xsl:value-of select="localization:getGTPString($language, 'CTL_USER')"/>",
					"BO_RELEASE_USER":"<xsl:value-of select="localization:getGTPString($language, 'RLS_USER')"/>"
					},					
				productDates : {
					<xsl:for-each select="main_dates/date">												
						<xsl:value-of select="@product_code"/>:[],							
					</xsl:for-each>	
					}
				});
				<xsl:for-each select="main_dates/date">												
					misys._config.productDates['<xsl:value-of select="@product_code"/>'].push("<xsl:value-of select="localization"/>;<xsl:value-of select="localization:getString($language, localization)"/>");
				</xsl:for-each>
			});
	</script>
	<!-- main -->
	<div class="widgetContainer">
	<xsl:attribute name="id"><xsl:value-of select="$displaymode" /></xsl:attribute>
	<xsl:call-template name="form-wrapper">
		<xsl:with-param name="name" select="$main-form-name" />
		<xsl:with-param name="method"></xsl:with-param>
		<xsl:with-param name="validating">Y</xsl:with-param>
		<xsl:with-param name="parseFormOnLoad">N</xsl:with-param>
   		<xsl:with-param name="content">
     		
  			<!-- remind customer details -->
			<xsl:apply-templates select="static_company" />
			
			<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="legend">XSL_EMAIL</xsl:with-param>
				<xsl:with-param name="parse-widgets">N</xsl:with-param>
				<xsl:with-param name="content">
					<xsl:call-template name="build-alerts-dojo-items">
						<xsl:with-param name="items" select="//alert[alert_type = '01']" />
						<xsl:with-param name="type_alert">01</xsl:with-param>
						<xsl:with-param name="hasentities">
							<xsl:choose>
								<xsl:when test="//entities">Y</xsl:when>
								<xsl:otherwise>N</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
					<!-- This div is required to force the content to appear -->
					<div style="height:1px">&nbsp;</div>
				</xsl:with-param>
			</xsl:call-template>

			<xsl:if test="securityCheck:hasPermission(utils:getUserACL($rundata),'sy_alert_sms',utils:getUserEntities($rundata))">
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_SMS</xsl:with-param>
					<xsl:with-param name="parse-widgets">N</xsl:with-param>
					<xsl:with-param name="content">
						<xsl:call-template name="build-alerts-dojo-items">
							<xsl:with-param name="items" select="//alert[alert_type = '02']" />
							<xsl:with-param name="type_alert">02</xsl:with-param>
							<xsl:with-param name="hasentities">
								<xsl:choose>
									<xsl:when test="//entities">Y</xsl:when>
									<xsl:otherwise>N</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
						<!-- This div is required to force the content to appear -->
						<div style="height:1px">&nbsp;</div>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			
			<!-- save, cancel, help buttons -->
			<xsl:call-template name="system-menu" />
			
		</xsl:with-param>
	</xsl:call-template>
	</div>
	<xsl:call-template name="alert-adds">
		<xsl:with-param name="type_alert">01</xsl:with-param>
		<xsl:with-param name="hasentities">
			<xsl:choose>
				<xsl:when test="//entities">Y</xsl:when>
				<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		</xsl:with-param>
	</xsl:call-template>
	<xsl:call-template name="alert-adds">
		<xsl:with-param name="type_alert">02</xsl:with-param>
		<xsl:with-param name="hasentities">
			<xsl:choose>
				<xsl:when test="//entities">Y</xsl:when>
				<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		</xsl:with-param>
	</xsl:call-template>
	
	
	<!-- Real Form -->
	<xsl:call-template name="realform" />
	
	<!-- Reauthentication -->
      <xsl:call-template name="reauthentication"/>
		
	
	<!-- Javascript imports  -->
    <xsl:call-template name="js-imports" />

</xsl:template>	

<xsl:template name="build-alerts-dojo-items">
		<xsl:param name="hasentities">N</xsl:param>
		<xsl:param name="type_alert"/>
		<xsl:param name="items"/>
		<div dojoType="misys.admin.widget.AlertsCalendar">
			<xsl:attribute name="isBank">
				<xsl:choose>
					<xsl:when test="security:isBank($rundata)">Y</xsl:when>
					<xsl:otherwise>N</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:if test="$hasentities = 'Y'"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALERT_ENTITY_COL')"/>,</xsl:if>
				<xsl:value-of select="localization:getGTPString($language, 'XSL_ALERT_PRODUCT_COL')"/>,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_ALERT_DATE_COL')"/>,
				<xsl:if test="security:isBank($rundata)">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_ALERT_CUSTOMER_COL')"/>,
				</xsl:if>
				<xsl:choose>
					<xsl:when test="$type_alert = '01'">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_ALERT_EMAIL_ADDRESS_COL')"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_ALERT_SMS_COL')"/>
					</xsl:otherwise>
				</xsl:choose>
				
			</xsl:attribute>
			<xsl:attribute name="HasEntity"><xsl:value-of select="$hasentities"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_ADD_ALERT')"/></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_UPDATE_ALERT')"/></xsl:attribute>
			<xsl:attribute name="AlertType"><xsl:value-of select="$type_alert"/></xsl:attribute>
			<xsl:attribute name="dialogId">alert<xsl:value-of select="$type_alert"/>-dialog-template</xsl:attribute>
			<xsl:attribute name="xmlTagName">alerts<xsl:value-of select="$type_alert"/></xsl:attribute>
			<xsl:attribute name="xmlSubTagName">alert<xsl:value-of select="$type_alert"/></xsl:attribute>
			<xsl:attribute name="id">alerts<xsl:value-of select="$type_alert"/></xsl:attribute>						
			
			<xsl:for-each select="$items">
				<xsl:variable name="alert" select="."/>
				<div>
					<xsl:choose>
						<xsl:when test="$hasentities = 'Y'">
							<xsl:attribute name="dojoType">misys.admin.widget.AlertCalendarEntity</xsl:attribute>
							<xsl:attribute name="entity"><xsl:value-of select="$alert/entity"/></xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="dojoType">misys.admin.widget.AlertCalendar</xsl:attribute>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:attribute name="prod_code"><xsl:value-of select="$alert/prod_code"/></xsl:attribute>
					<xsl:attribute name="customer_abbv_name"><xsl:value-of select="$alert/customer_abbv_name"/></xsl:attribute>
					<xsl:attribute name="address"><xsl:value-of select="$alert/address"/></xsl:attribute>
					<xsl:attribute name="alertlanguage"><xsl:value-of select="$alert/alertlanguage"/></xsl:attribute>
					<xsl:attribute name="issuer_abbv_name"><xsl:value-of select="$alert/issuer_abbv_name"/></xsl:attribute>
					<xsl:attribute name="alert_type"><xsl:value-of select="$alert/alert_type"/></xsl:attribute>
					<xsl:attribute name="date_code"><xsl:value-of select="$alert/date_code"/></xsl:attribute>
					<xsl:attribute name="offset"><xsl:value-of select="$alert/offset"/></xsl:attribute>
					<xsl:attribute name="offsetsign"><xsl:value-of select="$alert/offsetsign"/></xsl:attribute>
				</div>
			</xsl:for-each>
		</div>
		
	</xsl:template>

<!-- Additional JS imports for this form -->
<xsl:template name="js-imports">
	<xsl:call-template name="system-common-js-imports">
		<xsl:with-param name="xml-tag-name">alert_records</xsl:with-param>
		<xsl:with-param name="binding">misys.binding.system.alert_calendar</xsl:with-param>
		<xsl:with-param name="override-help-access-key">SY_ALERT</xsl:with-param>
	</xsl:call-template>
</xsl:template>

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
       <xsl:with-param name="value">SAVE_FEATURES</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">token</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$token"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
	   <xsl:with-param name="value"><xsl:value-of select="$option"/></xsl:with-param>
      </xsl:call-template>

      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">TransactionData</xsl:with-param>
       <xsl:with-param name="value"/>
      </xsl:call-template>
       <!-- static_company is only passed for customer matrix maintenance on bankgroup side -->
      <xsl:if test="$option='CUSTOMER_ENTITY_MAINTENANCE'">
      	<xsl:call-template name="hidden-field">
       		<xsl:with-param name="name">company</xsl:with-param>
       		<xsl:with-param name="value"><xsl:value-of select="company_abbv_name"/></xsl:with-param>
      	</xsl:call-template>
      </xsl:if>
      <xsl:call-template name="reauth_params"/>
      <xsl:call-template name="e2ee_transaction"/>
      <xsl:call-template name="localization-dialog"/>
     </div>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:if>
  </xsl:template>


<xsl:template match="static_company">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_COMPANY_DETAILS</xsl:with-param>
		<xsl:with-param name="content">

			<!-- abbv name -->			
			<xsl:call-template name="row-wrapper">
				<xsl:with-param name="label">XSL_JURISDICTION_ABREVIATED_NAME</xsl:with-param>
				<xsl:with-param name="content">
				 <div class="content">
				  <xsl:value-of select="abbv_name"/>
				 </div>
				</xsl:with-param>
			</xsl:call-template>
	
			<!-- name -->
			<xsl:call-template name="row-wrapper">
				<xsl:with-param name="label">XSL_JURISDICTION_NAME</xsl:with-param>
				<xsl:with-param name="content">
				 <div class="content">
				  <xsl:value-of select="name"/>
				 </div>
				</xsl:with-param>
			</xsl:call-template>

			<!-- address -->
			<xsl:call-template name="row-wrapper">
				<xsl:with-param name="label">XSL_JURISDICTION_ADDRESS</xsl:with-param>
				<xsl:with-param name="content"><div class="content"><xsl:value-of select="address_line_1"/></div></xsl:with-param>
			</xsl:call-template>
			<xsl:if test="address_line_2[.!='']">
				<xsl:call-template name="row-wrapper">
					<xsl:with-param name="content"><div class="content"><xsl:value-of select="address_line_2"/></div></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="dom[.!='']">
				<xsl:call-template name="row-wrapper">
					<xsl:with-param name="content"><div class="content"><xsl:value-of select="dom"/></div></xsl:with-param>
				</xsl:call-template>
			</xsl:if>

			<!-- contact name -->
			<xsl:if test="contact_name[.!='']">
				<xsl:call-template name="row-wrapper">
					<xsl:with-param name="label">XSL_JURISDICTION_CONTACT_PERSON</xsl:with-param>
					<xsl:with-param name="content"><div class="content"><xsl:value-of select="contact_name"/></div></xsl:with-param>
				</xsl:call-template>
			</xsl:if>				
			
			<xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">company_id</xsl:with-param>
		       <xsl:with-param name="value" select="company_id" />
		    </xsl:call-template>
		    
		    <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">type</xsl:with-param>
		       <xsl:with-param name="value" select="type" />
		    </xsl:call-template>
		    
		    <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">brch_code</xsl:with-param>
		       <xsl:with-param name="value" select="brch_code" />
		    </xsl:call-template>
		    
		    <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">abbv_name</xsl:with-param>
		       <xsl:with-param name="value" select="abbv_name" />
		    </xsl:call-template>
		    
		    <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">name</xsl:with-param>
		       <xsl:with-param name="value" select="name" />
		    </xsl:call-template>
		    
		    <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">address_line_1</xsl:with-param>
		       <xsl:with-param name="value" select="address_line_1" />
		    </xsl:call-template>
     
    		<xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">address_line_2</xsl:with-param>
		       <xsl:with-param name="value" select="address_line_2" />
		    </xsl:call-template>
			
			<xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">dom</xsl:with-param>
		       <xsl:with-param name="value" select="dom" />
		    </xsl:call-template>
			
			<!-- Alerts EMAIL -->
			<xsl:if test="securityCheck:hasCompanyPermission($rundata,'sy_alert_email')">
				 <xsl:call-template name="hidden-field">
			       <xsl:with-param name="name">alert_type_code</xsl:with-param>
			       <xsl:with-param name="id">alert_type_code_01</xsl:with-param>
			       <xsl:with-param name="value">01</xsl:with-param>
			    </xsl:call-template>
			</xsl:if>
			<!-- Alerts SMS -->
			<xsl:if test="securityCheck:hasCompanyPermission($rundata,'sy_alert_sms')">
				 <xsl:call-template name="hidden-field">
			       <xsl:with-param name="name">alert_type_code</xsl:with-param>
			       <xsl:with-param name="id">alert_type_code_02</xsl:with-param>
			       <xsl:with-param name="value">02</xsl:with-param>
			    </xsl:call-template>
			</xsl:if>
			
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>


<xsl:template name="alert-adds">
<xsl:param name="type_alert"/>
<xsl:param name="hasentities">N</xsl:param>
<!-- DIALOG START -->
<div style="display:none" class="widgetContainer">
	<xsl:attribute name="title">Confirmation</xsl:attribute>
	<xsl:attribute name="id">alert<xsl:value-of select="$type_alert"/>-dialog-template</xsl:attribute>

			<xsl:call-template name="select-field">
				<xsl:with-param name="label">XSL_REPORT_PRODUCT</xsl:with-param>
				<xsl:with-param name="name">prod_code<xsl:value-of select="$type_alert"/></xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
				<xsl:with-param name="options">
					<xsl:for-each select="//alert_records/avail_products/product_code">
	         			<xsl:variable name="avail_prodcode"><xsl:value-of select="."/></xsl:variable>
	   					<option>
	   						<xsl:attribute name="value"><xsl:value-of select="$avail_prodcode"/></xsl:attribute>
	   						<xsl:if test="prod_code=$avail_prodcode">
	   							<xsl:attribute name="selected" />
	   						</xsl:if>
		      				<xsl:choose>
					     		<xsl:when test="($isSwift2019Enabled = 'true') and $avail_prodcode = 'BG'">
		      						<xsl:value-of select="localization:getDecode($language, 'N001', 'IU')"/>
		      					</xsl:when>
		      					<xsl:when test="($isSwift2019Enabled = 'true') and $avail_prodcode = 'BR'">
		      						<xsl:value-of select="localization:getDecode($language, 'N001', 'RU')"/>
		      					</xsl:when>
		      					<xsl:otherwise>
		      						<xsl:value-of select="localization:getDecode($language, 'N001', $avail_prodcode)"/>
		      					</xsl:otherwise>
	      					</xsl:choose>
	   					</option>
	         		</xsl:for-each>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="select-field">
				<xsl:with-param name="label">XSL_JURISDICTION_DATE_LABEL</xsl:with-param>
				<xsl:with-param name="name">date_code<xsl:value-of select="$type_alert"/></xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>
				<xsl:with-param name="options">
					<xsl:for-each select="//date[not(localization=preceding-sibling::date/localization)] ">
	         			<xsl:variable name="avail_date"><xsl:value-of select="localization"/></xsl:variable>
	   					<option>
	   						<xsl:attribute name="value"><xsl:value-of select="$avail_date"/></xsl:attribute>
	      					<xsl:value-of select="localization:getString($language, $avail_date)"/>
	   					</option>
	         		</xsl:for-each>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:if test="$hasentities='Y'">
				<xsl:call-template name="entity-field">
					<xsl:with-param name="popup-entity-prefix"><xsl:value-of select="$type_alert"/></xsl:with-param>
					<xsl:with-param name="prefix"></xsl:with-param>
				    <xsl:with-param name="button-type">system-entity</xsl:with-param>
				    <xsl:with-param name="empty">Y</xsl:with-param>
				    <xsl:with-param name="required">
					    <xsl:choose>
						    <xsl:when test="count(entities)=0">N</xsl:when>
						    <xsl:otherwise>Y</xsl:otherwise>
					    </xsl:choose>
				    </xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="security:isBank($rundata)">
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_TRANSACTIONDETAILS_CUSTOMER</xsl:with-param>
					<xsl:with-param name="name">customer_abbv_name<xsl:value-of select="$type_alert"/></xsl:with-param>
					<xsl:with-param name="call-back-customer-field-post-name"><xsl:value-of select="$type_alert"/></xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
					<xsl:with-param name="readonly">Y</xsl:with-param>
					<xsl:with-param name="button-type">system-customers-entity</xsl:with-param>
					<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('ABBVNAME_ASTERISK_VALIDATION_REGEX')"/></xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_JURISDICTION_OFFSET_LABEL</xsl:with-param>
				<xsl:with-param name="name">offset<xsl:value-of select="$type_alert"/></xsl:with-param>
				<xsl:with-param name="size">2</xsl:with-param>
				<xsl:with-param name="type">number</xsl:with-param>
				<xsl:with-param name="maxsize">2</xsl:with-param>
				<xsl:with-param name="fieldsize">x-small</xsl:with-param>
				<xsl:with-param name="override-constraints">{min:0,pattern: '##'}</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="radio-field">
				<xsl:with-param name="label">XSL_JURISDICTION_OFFSET_BEFORE_HEADER</xsl:with-param>
				<xsl:with-param name="name">offsetsign<xsl:value-of select="$type_alert"/></xsl:with-param>
				<xsl:with-param name="id">offsetsign<xsl:value-of select="$type_alert"/>_0</xsl:with-param>
				<xsl:with-param name="value">0</xsl:with-param>
			</xsl:call-template>
            <xsl:call-template name="radio-field">
				<xsl:with-param name="label">XSL_JURISDICTION_OFFSET_AFTER_HEADER</xsl:with-param>
				<xsl:with-param name="name">offsetsign<xsl:value-of select="$type_alert"/></xsl:with-param>
				<xsl:with-param name="id">offsetsign<xsl:value-of select="$type_alert"/>_1</xsl:with-param>
				<xsl:with-param name="value">1</xsl:with-param>
			</xsl:call-template>	
			<xsl:call-template name="multioption-group">
		     <xsl:with-param name="group-label">XSL_PARTIESDETAILS_ABBV_NAME</xsl:with-param>
		     <xsl:with-param name="content">
		       <xsl:call-template name="radio-field">
			    <xsl:with-param name="label">INP_USER</xsl:with-param>
			    <xsl:with-param name="name">issuer_abbv_name<xsl:value-of select="$type_alert"/></xsl:with-param>
			    <xsl:with-param name="id">issuer_abbv_name<xsl:value-of select="$type_alert"/>_1</xsl:with-param>
			    <xsl:with-param name="value">
					<xsl:choose>
	          			<xsl:when test="not($company_type_param ='03')">BO_INPUT_USER</xsl:when>
	         			<xsl:otherwise>INPUT_USER</xsl:otherwise>
	           		</xsl:choose>
				</xsl:with-param>
			   </xsl:call-template>
			   <xsl:call-template name="radio-field">
			    <xsl:with-param name="label">CTL_USER</xsl:with-param>
			    <xsl:with-param name="name">issuer_abbv_name<xsl:value-of select="$type_alert"/></xsl:with-param>
			    <xsl:with-param name="id">issuer_abbv_name<xsl:value-of select="$type_alert"/>_2</xsl:with-param>
			    <xsl:with-param name="value">
					<xsl:choose>
	          			<xsl:when test="not($company_type_param ='03')">BO_CONTROL_USER</xsl:when>
	         			<xsl:otherwise>CONTROL_USER</xsl:otherwise>
	           		</xsl:choose>
				</xsl:with-param>
			   </xsl:call-template>
			   <xsl:call-template name="radio-field">
			    <xsl:with-param name="label">RLS_USER</xsl:with-param>
			    <xsl:with-param name="name">issuer_abbv_name<xsl:value-of select="$type_alert"/></xsl:with-param>
			    <xsl:with-param name="id">issuer_abbv_name<xsl:value-of select="$type_alert"/>_3</xsl:with-param>
			    <xsl:with-param name="value">
					<xsl:choose>
	          			<xsl:when test="not($company_type_param ='03')">BO_RELEASE_USER</xsl:when>
	         			<xsl:otherwise>RELEASE_USER</xsl:otherwise>
	           		</xsl:choose>
				</xsl:with-param>
			   </xsl:call-template>
			   <xsl:call-template name="radio-field">
			    <xsl:with-param name="label">CUSTOM_USER</xsl:with-param>
			    <xsl:with-param name="name">issuer_abbv_name<xsl:value-of select="$type_alert"/></xsl:with-param>
			    <xsl:with-param name="id">issuer_abbv_name<xsl:value-of select="$type_alert"/>_4</xsl:with-param>
			    <xsl:with-param name="value">*</xsl:with-param>
			   </xsl:call-template>
		     </xsl:with-param>
		    </xsl:call-template>
	
			<div style="display:none">
			<xsl:attribute name="id">language-address-id-<xsl:value-of select="$type_alert"></xsl:value-of> </xsl:attribute>
				<xsl:call-template name="select-field">
					<xsl:with-param name="label">XSL_JURISDICTION_LANGUAGE_LOCALE</xsl:with-param>
					<xsl:with-param name="name">alertlanguage<xsl:value-of select="$type_alert"/></xsl:with-param>
					<xsl:with-param name="options">
						  <xsl:choose>
			     		   <xsl:when test="$displaymode='edit'">
			                <xsl:variable name="current"><xsl:value-of select="alertlanguage"/></xsl:variable>
							<xsl:for-each select="$languages/languages/language">
			                	<xsl:variable name="optionLanguage"><xsl:value-of select="."/></xsl:variable>
			                  		<option>
			                     		<xsl:attribute name="value"><xsl:value-of select="$optionLanguage"/></xsl:attribute>
			                      		<xsl:choose>
				                           	<xsl:when test="$current = $optionLanguage">
				                            	<xsl:attribute name="selected"/>
			    		                    </xsl:when>
			            		            <xsl:otherwise/>
			                    	  	</xsl:choose>
			                      		<xsl:value-of select="localization:getDecode($language, 'N061', $optionLanguage)"/>
			                   		</option>
			                </xsl:for-each>
			               </xsl:when>
			               <xsl:otherwise>
			                <xsl:variable name="optionLanguage"><xsl:value-of select="./language"/></xsl:variable>
			     			<xsl:value-of select="localization:getDecode($language, 'N061', $optionLanguage)"/>
			               </xsl:otherwise>
			              </xsl:choose>
			          </xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">
						<xsl:choose>
							<xsl:when test="$type_alert='01'">XSL_JURISDICTION_EMAIL_ADDRESS_LABEL</xsl:when>
							<xsl:otherwise>XSL_JURISDICTION_SMS_LABEL</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
					<xsl:with-param name="name">address<xsl:value-of select="$type_alert"/></xsl:with-param>
					<xsl:with-param name="size">255</xsl:with-param>
     				<xsl:with-param name="maxsize">255</xsl:with-param>
				</xsl:call-template>
			</div>
			<div class="dijitDialogPaneActionBar">
				<xsl:call-template name="label-wrapper">
					<xsl:with-param name="content">
						<button dojoType="dijit.form.Button" type="button">
							<xsl:attribute name="onClick">misys.dialog.submitCalendarAlert('alert<xsl:value-of select="$type_alert"/>-dialog-template', '<xsl:value-of select="$type_alert"/>')</xsl:attribute>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')"/>
						</button>
						<button dojoType="dijit.form.Button" type="button">
							<xsl:attribute name="onClick">dijit.byId('alert<xsl:value-of select="$type_alert"/>-dialog-template').hide();</xsl:attribute>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')"/>
						</button>
					</xsl:with-param>
				</xsl:call-template>
			</div>
		
</div>
<!-- Dialog End -->
<div id="alerts-template" style="display:none">
	<xsl:attribute name="id">alerts<xsl:value-of select="$type_alert"/>-template</xsl:attribute>
	<div class="clear">
		<p dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
			<xsl:value-of select="localization:getGTPString($language, 'XSL_NO_ALERTS')"/>
		</p>
		<div dojoAttachPoint="itemsNode">
			<div dojoAttachPoint="containerNode"/>
		</div>
		<button dojoType="dijit.form.Button" type="button" dojoAttachEvent="onClick: addItem">
			<xsl:choose>
				<xsl:when test="$type_alert='01'"><xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_ADD_EMAIL_ADDRESS')"/></xsl:when>
				<xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_ADD_SMS_ADDRESS')"/></xsl:otherwise>
			</xsl:choose>
		</button>
	</div>
</div>
</xsl:template>

</xsl:stylesheet>
