<?xml version="1.0" encoding="UTF-8"?>
<!-- ########################################################## Templates 
	for Fund Transfer (FT) Form, Customer Side. Copyright (c) 2000-2011 Misys 
	(http://www.misys.com), All Rights Reserved. version: 1.0 date: 28/09/11 
	author: Lithwin ########################################################## -->

<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
	xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:ftProcessing="xalan://com.misys.portal.cash.common.services.FTProcessing"
	exclude-result-prefixes="xmlRender localization ftProcessing securitycheck utils">

   <!-- Global Parameters. These are used in the imported XSL, and to set global 
		params in the JS -->
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="local_language"/>
    <xsl:param name="user_language"/>
    <xsl:param name="languages"/>
    <xsl:param name="nextscreen"/>
    <xsl:param name="option"/>
    <xsl:param name="action"/>
    <xsl:param name="token"/>
    <xsl:param name="displaymode">edit</xsl:param>
    <xsl:param name="main-form-name">fakeform1</xsl:param>
    <xsl:param name="operation">SAVE_FEATURES</xsl:param>
	<xsl:param name="rundata" />
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="mode">DRAFT</xsl:param>
	<xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
	<xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a 
			collab summary screen --> 
	<xsl:param name="product-code">FT</xsl:param>
	<xsl:param name="main-form-name">fakeform1</xsl:param>
	<xsl:param name="realform-action">
		<xsl:value-of select="$contextPath" />
		<xsl:value-of select="$servletPath" />/screen/FundTransferScreen</xsl:param>
	<xsl:param name="isMultiBank">N</xsl:param>	
	<xsl:param name="nicknameEnabled"/>
	<!-- Global Imports. -->
	<xsl:include href="../../core/xsl/common/trade_common.xsl" />
	<xsl:include href="./common/ft_common.xsl" />
	<xsl:output method="html" version="4.01" indent="no"
		encoding="UTF-8" omit-xml-declaration="yes" />
	<xsl:template match="/">
	    <xsl:apply-templates select="input" />
<!-- 	    <xsl:call-template name="input"/> -->
	</xsl:template>


	<!-- Additional JS imports for this form are -->
	<!-- added here. -->
	<xsl:template name="js-imports">
		<xsl:variable name="loc_lan"><xsl:value-of select="$local_language"/></xsl:variable>
		<xsl:variable name="user_lan"><xsl:value-of select="$user_language"/></xsl:variable>
		<xsl:call-template name="common-js-imports">
			<xsl:with-param name="binding">misys.binding.cash.select_payee_service</xsl:with-param>
			<xsl:with-param name="override-product-code" select="product_code" />
			<xsl:with-param name="override-help-access-key">BILLP_02</xsl:with-param>
		</xsl:call-template>
		<script>
        dojo.ready(function(){
        dojo.require("dojox.collections.ArrayList");
              misys._config = misys._config || {};
              misys._config.bills = {};
              misys._config.nickname = '<xsl:value-of select="$nicknameEnabled"/>';
              dojo.mixin(misys._config.bills,{
                          payeeArr : new Array(),
                          serviceArr: new Array
              });
              misys._config.payeeCollection = [];
              
               misys._config.serviceCollection=[];
              function isPayeeCodePresent(payeeCollection, payeeCode)
				{
					for (var i=0; i &lt; payeeCollection.length; i++) {
						
						var obj = payeeCollection[i];
						if(obj.value === payeeCode)
							{
							return true;
							}
					}
					return false;
				};
				misys._config.isMultiBank =<xsl:choose>
									 			<xsl:when test="$isMultiBank='Y'">true</xsl:when>
									 			<xsl:otherwise>false</xsl:otherwise>
									 		</xsl:choose>;
				<xsl:if test="$isMultiBank='Y'">
						 dojo.mixin(misys._config, {
								 bankBillerService : {
								 	<xsl:for-each select ="/input/master_service_payee_per_bank/banks/bank_name">
								 		<xsl:variable name="bank_name" select ="self::node()/text()"/>
								 		<xsl:value-of select="."/>:[
									 		<xsl:for-each select ="/input/master_service_payee_per_bank/banks[bank_name=$bank_name]/master_payee">
									 			{ name:"<xsl:value-of select="./payee_name"/>",
												          value:"<xsl:value-of select="./payee_code"/>_<xsl:value-of select="$bank_name"/>"},
											</xsl:for-each>
										 		]<xsl:if test="not(position()=last())">,</xsl:if> 
									 </xsl:for-each>
								 }
						 		});
						 
						  dojo.mixin(misys._config, {
								 bankPayeeService : {
								 	<xsl:for-each select ="/input/master_service_payee_per_bank/banks/bank_name">
								 		<xsl:variable name="bank_name" select ="self::node()/text()"/>
								 		<xsl:for-each select="/input/master_service_payee_per_bank/banks[bank_name=$bank_name]/master_payee">
									 		<xsl:variable name="payee_code" select ="./payee_code"/>
									 		"<xsl:value-of select="./payee_code"/>_<xsl:value-of select="$bank_name"/>":[
										 		{ name:"<xsl:value-of select="./service_name"/>",
													          value:"<xsl:value-of select="./master_payee_id"/>"}
											 		],
										 </xsl:for-each>
									 </xsl:for-each>
								 }
						 		});
						 
						 		
						<!--  dojo.mixin(misys._config, {
								  bankPayeeService : {
								 	<xsl:for-each select ="/input/master_payees/master_payee/service_code">
								 		<xsl:variable name="service_code" select ="self::node()/text()"/>
								 		<xsl:value-of select="."/>: [
								 			<xsl:for-each select ="/input/master_payees/master_payee[service_code=$service_code]/service_name">
								 				{ name:"<xsl:value-of select="."/>",
										          value:"<xsl:value-of select="/input/master_payees/master_payee[service_code=$service_code]/master_payee_id"/>"},
								 			</xsl:for-each>
								 		]<xsl:if test="not(position()=last())">,</xsl:if>
								 	</xsl:for-each>
								 }
						 		}); -->
				</xsl:if>
				
              <xsl:for-each select="/input/master_payees/master_payee">
              <xsl:choose>
					<xsl:when test="$loc_lan = $user_lan">
		              <xsl:choose>
		              <xsl:when test="local_payee_name[.!=''] and local_service_name[.='']">
		              misys._config.serviceCollection['<xsl:value-of select="payee_code"/>'] = misys._config.serviceCollection['<xsl:value-of select="payee_code"/>'] || [];
		                var object = {value:"<xsl:value-of select="payee_code"/>",name:"<xsl:value-of select="local_payee_name"/>" };
					    var payeeCode = '<xsl:value-of select="payee_code"/>'.toString();
					    if(!isPayeeCodePresent(misys._config.payeeCollection,payeeCode))
				  	    {	
						  misys._config.payeeCollection.push(	object);
		 				}
					   misys._config.serviceCollection["<xsl:value-of select="payee_code"/>"].push({value:"<xsl:value-of select="master_payee_id"/>",name:"<xsl:value-of select="service_name"/>" });
		              </xsl:when>
		              <xsl:when test="local_payee_name[.=''] and local_service_name[.!='']">
		              misys._config.serviceCollection['<xsl:value-of select="payee_code"/>'] = misys._config.serviceCollection['<xsl:value-of select="payee_code"/>'] || [];
		                var object = {value:"<xsl:value-of select="payee_code"/>",name:"<xsl:value-of select="payee_name"/>" };
					    var payeeCode = '<xsl:value-of select="payee_code"/>'.toString();
					    if(!isPayeeCodePresent(misys._config.payeeCollection,payeeCode))
				  	    {	
						  misys._config.payeeCollection.push(	object);
		 				}
					   misys._config.serviceCollection["<xsl:value-of select="payee_code"/>"].push({value:"<xsl:value-of select="master_payee_id"/>",name:"<xsl:value-of select="local_service_name"/>" });
		              </xsl:when>
		              <xsl:when test="local_payee_name[.!=''] and local_service_name[.!='']">
		              misys._config.serviceCollection['<xsl:value-of select="payee_code"/>'] = misys._config.serviceCollection['<xsl:value-of select="payee_code"/>'] || [];
		                var object = {value:"<xsl:value-of select="payee_code"/>",name:"<xsl:value-of select="local_payee_name"/>" };
					    var payeeCode = '<xsl:value-of select="payee_code"/>'.toString();
					    if(!isPayeeCodePresent(misys._config.payeeCollection,payeeCode))
				  	    {	
						  misys._config.payeeCollection.push(	object);
		 				}
					   misys._config.serviceCollection["<xsl:value-of select="payee_code"/>"].push({value:"<xsl:value-of select="master_payee_id"/>",name:"<xsl:value-of select="local_service_name"/>" });
		              </xsl:when>
		              <xsl:otherwise>
             			misys._config.serviceCollection['<xsl:value-of select="payee_code"/>'] = misys._config.serviceCollection['<xsl:value-of select="payee_code"/>'] || [];
		                var object = {value:"<xsl:value-of select="payee_code"/>",name:"<xsl:value-of select="payee_name"/>" };
					    var payeeCode = '<xsl:value-of select="payee_code"/>'.toString();
					    if(!isPayeeCodePresent(misys._config.payeeCollection,payeeCode))
				  	    {	
						  misys._config.payeeCollection.push(	object);
		 				}
					   misys._config.serviceCollection["<xsl:value-of select="payee_code"/>"].push({value:"<xsl:value-of select="master_payee_id"/>",name:"<xsl:value-of select="service_name"/>" });
             		   </xsl:otherwise>
		              </xsl:choose>
             		</xsl:when>
             		<xsl:otherwise>
             			misys._config.serviceCollection['<xsl:value-of select="payee_code"/>'] = misys._config.serviceCollection['<xsl:value-of select="payee_code"/>'] || [];
		                var object = {value:"<xsl:value-of select="payee_code"/>",name:"<xsl:value-of select="payee_name"/>" };
					    var payeeCode = '<xsl:value-of select="payee_code"/>'.toString();
					    if(!isPayeeCodePresent(misys._config.payeeCollection,payeeCode))
				  	    {	
						  misys._config.payeeCollection.push(	object);
		 				}
					   misys._config.serviceCollection["<xsl:value-of select="payee_code"/>"].push({value:"<xsl:value-of select="master_payee_id"/>",name:"<xsl:value-of select="service_name"/>" });
             		</xsl:otherwise>
             		</xsl:choose>
              </xsl:for-each>
              
               });
	</script>
	</xsl:template>
	<xsl:template match="input" >
	
		<!-- Preloader -->
		<xsl:call-template name="loading-message" />
		<div>
			<xsl:attribute name="id"><xsl:value-of select="$displaymode" /></xsl:attribute>
			<!-- Form #0 : Main Form -->
			<xsl:call-template name="form-wrapper">
				<xsl:with-param name="name" select="$main-form-name"/>
				<xsl:with-param name="validating">Y</xsl:with-param>
				<xsl:with-param name="content">
				
				<xsl:call-template name="fieldset-wrapper">
						<xsl:with-param name="legend">XSL_HEADER_SERVICE_TRANSACTION_DETAILS</xsl:with-param>
						<xsl:with-param name="content">
					 		<xsl:call-template name="payee-service-details" /> 
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
			  <xsl:call-template name="realform"/>
	   	<!-- Javascript imports  -->
   	
		</div>
		<xsl:call-template name="js-imports"/>
	</xsl:template>
	<xsl:template name="payee-service-details">
		<xsl:choose>
			<xsl:when test="$isMultiBank='Y'">
				<xsl:if test="$isMultiBank='Y'">
					<xsl:call-template name ="select-field">
						<xsl:with-param name ="label">BANK_NAME</xsl:with-param>
						<xsl:with-param name ="required">Y</xsl:with-param>
						<xsl:with-param name ="name">bank</xsl:with-param>
						<xsl:with-param name = "options">
							<xsl:choose>
								<xsl:when test="$displaymode='edit'">
									<xsl:for-each select="/input/banks_list/bank">
										<option>
											<xsl:value-of select ="."/>
										</option>
									</xsl:for-each>
								</xsl:when>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:call-template name="select-field">
				  	    <xsl:with-param name="label">XSL_PAYEE_LABEL</xsl:with-param>
					    <xsl:with-param name="required">Y</xsl:with-param>
					    <xsl:with-param name="name">biller</xsl:with-param>
					  <xsl:with-param name="options">
							<xsl:apply-templates select="master_payees"/>
					 </xsl:with-param>			
				</xsl:call-template>
				<xsl:call-template name="select-field">
			  	    <xsl:with-param name="label">XSL_SERVICE_LABEL</xsl:with-param>
				    <xsl:with-param name="required">Y</xsl:with-param>
				    <xsl:with-param name="name">service</xsl:with-param>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="select-field">
				  	    <xsl:with-param name="label">XSL_PAYEE_LABEL</xsl:with-param>
					    <xsl:with-param name="required">Y</xsl:with-param>
					    <xsl:with-param name="name">biller</xsl:with-param>
					  <xsl:with-param name="options">
							<xsl:apply-templates select="master_payees"/>
					 </xsl:with-param>			
				</xsl:call-template>
					<xsl:call-template name="select-field">
				  	    <xsl:with-param name="label">XSL_SERVICE_LABEL</xsl:with-param>
					    <xsl:with-param name="required">Y</xsl:with-param>
					    <xsl:with-param name="name">service</xsl:with-param>
					</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:call-template name='localization-dialog'/>
		
			<!-- <script>
			dojo.ready(function(){
			dojo.require("dojox.collections.ArrayList");
			misys._config = misys._config || {};
			dojo.mixin(misys._config, {
					billerCollection : new Array(),
					billerServiceCollection : new Array()
			        
	       		});
	       		Build the list of FT types available each of the BK types
	       		<xsl:for-each select="master_payees/master_payee">
							misys._config.billerServiceCollection['<xsl:value-of select="payee_code"/>'] = '<xsl:value-of select="service_name"/>';
							misys._config.billerCollection['<xsl:value-of select="payee_code"/>'] = '<xsl:value-of select="payee_name"/>';
						
				</xsl:for-each>
				
			});
		</script>   -->	
		
		 <xsl:call-template name="row-wrapper">
			   <xsl:with-param name="content">  
			    <button dojoType="dijit.form.Button" type="button">
					<xsl:attribute name="onClick">misys.billService();</xsl:attribute>
						 <xsl:value-of select="localization:getGTPString($language, 'OK')" />
				 </button>
			   	</xsl:with-param>
		   	</xsl:call-template>	
  	
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
      <!-- <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">operation</xsl:with-param>
       <xsl:with-param name="id">realform_operation</xsl:with-param>
       <xsl:with-param name="value">SAVE_FEATURES</xsl:with-param>
      </xsl:call-template> -->
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
        <xsl:with-param name="value">BILLS</xsl:with-param>
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
       <xsl:with-param name="name">tnxtype</xsl:with-param>
       <xsl:with-param name="value">01</xsl:with-param>
      </xsl:call-template>
     
      	<xsl:call-template name="hidden-field">
       		<xsl:with-param name="name">featureid</xsl:with-param>
       		<xsl:with-param name="value"/>
      	</xsl:call-template>
      	</div>
         </xsl:with-param>
   </xsl:call-template>
   </xsl:if>
  </xsl:template>

</xsl:stylesheet>