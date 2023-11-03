<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates that are common to FT forms on the customer and bank side. This
stylesheet should be the first thing imported by customer-side or bank side
XSLTs.

Copyright (c) 2000-2011 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      27/10/11
author:    Lithwin
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
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		xmlns:payeeutils="xalan://com.misys.portal.product.util.PayeeUtil"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		exclude-result-prefixes="localization securitycheck utils payeeutils defaultresource">

	<xsl:param name="local_language"/>
	<xsl:param name="user_language"/>	
	<xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
	<xsl:param name="textImage"><xsl:value-of select="$images_path"/>pic_text.gif</xsl:param>
	<xsl:param name="checkOrRevertImage"><xsl:value-of select="$images_path"/>pic_checkorrevert.gif</xsl:param>
	
	
<!--
  	 Transaction Details Fieldset: Bill Payment 
   	-->
	<xsl:template name="tnx-details-billPayment">			
	
		<xsl:param name="isBankReporting"/>
		<xsl:variable name="display">
			<xsl:choose>
				<xsl:when test="$isBankReporting='Y'">view</xsl:when>
				<xsl:otherwise>edit</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
			<!-- Payment amount field -->
			 <xsl:if test="$displaymode='edit'">
			      	<xsl:call-template name="hidden-field"> 
			       		<xsl:with-param name="name">ft_cur_code</xsl:with-param>			       		
						<xsl:with-param name="value">
							<xsl:choose>
	      							<xsl:when test="ft_cur_code[.!='']"><xsl:value-of select="ft_cur_code"/></xsl:when>
	      							<xsl:otherwise><xsl:value-of select="customer_payee/customer_payee_record/cur_code"/></xsl:otherwise>
	      					</xsl:choose>
						</xsl:with-param>
			      	</xsl:call-template>
			 </xsl:if>
			<xsl:call-template name="currency-field">
		      	<xsl:with-param name="label">XSL_PAYMENT_AMOUNT</xsl:with-param>
			   	<xsl:with-param name="product-code">ft</xsl:with-param>
			   	<xsl:with-param name="override-currency-value">
      				<xsl:choose>
      					<xsl:when test="ft_cur_code[.!='']"><xsl:value-of select="ft_cur_code"/></xsl:when>
      					<xsl:otherwise><xsl:value-of select="customer_payee/customer_payee_record/cur_code"/></xsl:otherwise>
      				</xsl:choose>
      			</xsl:with-param>
	   			<xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
	   			<xsl:with-param name="override-amt-displaymode">
	   				<xsl:choose>
	   					<xsl:when test="$display='view'">view</xsl:when>
	   					<xsl:otherwise><xsl:value-of select="$displaymode"/></xsl:otherwise>
	   				</xsl:choose>
	   			</xsl:with-param>
				<xsl:with-param name="required">Y</xsl:with-param>	
		    </xsl:call-template>
		    				
			<!--	  Transfer Date.  -->
			<div id="transfer_date_div">
				<xsl:choose>
			      	<xsl:when test="$displaymode='edit'">
						<xsl:call-template name="business-date-field">
						    <xsl:with-param name="label">XSL_GENERALDETAILS_TRANSFER_DATE</xsl:with-param>
						    <xsl:with-param name="name">iss_date</xsl:with-param>
						    <xsl:with-param name="size">10</xsl:with-param>
						    <xsl:with-param name="maxsize">10</xsl:with-param>
						    <xsl:with-param name="required">Y</xsl:with-param>
						    <xsl:with-param name="fieldsize">small</xsl:with-param>
						    <xsl:with-param name="override-displaymode"><xsl:value-of select="$display"/></xsl:with-param>
						    <xsl:with-param name="sub-product-code-widget-id">sub_product_code</xsl:with-param>
						    <xsl:with-param name="bank-abbv-name-widget-id">issuing_bank_abbv_name</xsl:with-param>
						    <xsl:with-param name="cur-code-widget-id">ft_cur_code</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:when test="$displaymode='view'">				
						<xsl:if test="recurring_payment_enabled[.='N']">
							<xsl:call-template name="business-date-field">
							    <xsl:with-param name="label">XSL_GENERALDETAILS_TRANSFER_DATE</xsl:with-param>
							    <xsl:with-param name="name">iss_date</xsl:with-param>
							    <xsl:with-param name="size">10</xsl:with-param>
							    <xsl:with-param name="maxsize">10</xsl:with-param>
							    <xsl:with-param name="required">Y</xsl:with-param>
							    <xsl:with-param name="fieldsize">small</xsl:with-param>
							    <xsl:with-param name="sub-product-code-widget-id">sub_product_code</xsl:with-param>
							    <xsl:with-param name="bank-abbv-name-widget-id">issuing_bank_abbv_name</xsl:with-param>
							    <xsl:with-param name="cur-code-widget-id">ft_cur_code</xsl:with-param>
							</xsl:call-template>						
						</xsl:if>
					</xsl:when>
				</xsl:choose>
			</div>
			
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">iss_date_unsigned</xsl:with-param>
		     	<xsl:with-param name="value" select="iss_date"></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">sub_product_code_unsigned</xsl:with-param>
		     	<xsl:with-param name="value" select="sub_product_code"></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">display_entity_unsigned</xsl:with-param>
		     	<xsl:with-param name="value" select="entity"></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">ft_cur_code_unsigned</xsl:with-param>
		     	<xsl:with-param name="value" select="ft_cur_code"></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">ft_amt_unsigned</xsl:with-param>
		     	<xsl:with-param name="value" select="ft_amt"></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">recurring_start_date_unsigned</xsl:with-param>
		     	<xsl:with-param name="value" select="recurring_start_date"></xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">recurring_end_date_unsigned</xsl:with-param>
		     	<xsl:with-param name="value" select="recurring_end_date"></xsl:with-param>
			</xsl:call-template>
	   	
	<!-- Customer Reference -->	
 		<xsl:call-template name="customer-reference-field">
 			<xsl:with-param name="disabled"><xsl:if test="$display = 'view'">Y</xsl:if></xsl:with-param>
 		</xsl:call-template>
 
	</xsl:template>
	
	<!-- payee and reference details -->
	<xsl:template name="payee-details">
	<!-- display payee -->	
		<xsl:param name="isBankReporting"/>
		<xsl:variable name="isReported">
			<xsl:choose>
				<xsl:when test="$isBankReporting='Y'">Y</xsl:when>
				<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="loc_lan"><xsl:value-of select="$local_language"/></xsl:variable>
  		<xsl:variable name="user_lan"><xsl:value-of select="$user_language"/></xsl:variable>
   			    <xsl:call-template name="input-field">
    				<xsl:with-param name="label">XSL_PAYEE</xsl:with-param>
      				<xsl:with-param name="name">payee_name</xsl:with-param>
      				<xsl:with-param name="value">
      					<xsl:choose>
		      				<xsl:when test="$loc_lan = $user_lan and customer_payee/customer_payee_record/local_payee_name[.!='']"><xsl:value-of select="customer_payee/customer_payee_record/local_payee_name"/></xsl:when>
		      				<xsl:when test="payee_name[.!='']"><xsl:value-of select="payee_name"/></xsl:when>
		      				<xsl:otherwise><xsl:value-of select="customer_payee/customer_payee_record/payee_name"/></xsl:otherwise>
	      				</xsl:choose>
      				</xsl:with-param>
      				<xsl:with-param name="size">10</xsl:with-param>
     				<xsl:with-param name="maxsize">10</xsl:with-param>
                    <xsl:with-param name="override-displaymode">view</xsl:with-param>
     			</xsl:call-template>
     			<xsl:if test="customer_payee/customer_payee_record/service_name[.!='']">
     			<xsl:call-template name="input-field">
    				<xsl:with-param name="label">XSL_SERVICE</xsl:with-param>
      				<xsl:with-param name="name">service_name</xsl:with-param>
      				<xsl:with-param name="value">
      					<xsl:choose>
		      				<xsl:when test="$loc_lan = $user_lan and customer_payee/customer_payee_record/local_service_name[.!='']"><xsl:value-of select="customer_payee/customer_payee_record/local_service_name"/></xsl:when>
		      				<xsl:otherwise><xsl:value-of select="customer_payee/customer_payee_record/service_name"/></xsl:otherwise>
	      				</xsl:choose>
      				</xsl:with-param>
      				<xsl:with-param name="size">10</xsl:with-param>
     				<xsl:with-param name="maxsize">10</xsl:with-param>
                    <xsl:with-param name="override-displaymode">view</xsl:with-param>
     			</xsl:call-template>
     			</xsl:if>
     			<xsl:if test="customer_payee/customer_payee_record/samp_bill_path[.!='']">	
						<a target="_blank">
					      	<xsl:attribute name="href"><xsl:value-of select="customer_payee/customer_payee_record/samp_bill_path"/></xsl:attribute>
							<img>
									<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($textImage)"/></xsl:attribute>
									<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_SAMPLE_BILL')"/></xsl:attribute>
							</img>
 						</a>
 				</xsl:if>
     			<xsl:choose >
     				<xsl:when test="customer_payee/customer_payee_record">
     					<xsl:apply-templates select="customer_payee/customer_payee_record/customer_payee_refs/customer_payee_ref_record">
     						<xsl:with-param name="disable"><xsl:value-of select="$isReported"/></xsl:with-param>
     					</xsl:apply-templates>
     				</xsl:when>
     				<xsl:otherwise>
     					<xsl:for-each select="//*[starts-with(name(),'customer_payee_ref_')]">
							<xsl:call-template name="input-field">
					  			<xsl:with-param name="override-label"><xsl:value-of select="localization:getGTPString($language, 'XSL_BILL_REFERENCE')"/> <xsl:number value="position()" format="1" />:</xsl:with-param>			
					  			<xsl:with-param name="name"><xsl:value-of select="name()"/></xsl:with-param>
								
					 		</xsl:call-template>
						</xsl:for-each>
     				</xsl:otherwise>
   				</xsl:choose>			
   								
	 			<!-- Display disclaimer message -->						 			
	 			<div>										
					<span  style="color:red; font-weight:bold;" id="disclaimer_message" >
					<xsl:choose>
		      			<xsl:when test="$loc_lan = $user_lan and customer_payee/customer_payee_record/local_additional_info[.!='']">
		      				<xsl:value-of select="customer_payee/customer_payee_record/local_additional_info"/>
		      			</xsl:when>
		      			<xsl:otherwise>
		      				<xsl:value-of select="customer_payee/customer_payee_record/additional_info"/>
		      			</xsl:otherwise>
	      			</xsl:choose>
					</span>									
				</div>
		</xsl:template>
     <!--
  	 Transaction Details Fieldset: DDA 
   	-->
	<xsl:template name="tnx-details-dda">
	<!-- Limit amount field -->	
	<xsl:if test="$displaymode='edit'">
	      	<xsl:call-template name="hidden-field"> 
	       		<xsl:with-param name="name">ft_cur_code</xsl:with-param>			       		
				<xsl:with-param name="value">
					<xsl:choose>
     							<xsl:when test="ft_cur_code[.!='']"><xsl:value-of select="ft_cur_code"/></xsl:when>
     							<xsl:otherwise><xsl:value-of select="customer_payee/customer_payee_record/cur_code"/></xsl:otherwise>
     					</xsl:choose>
				</xsl:with-param>
	      	</xsl:call-template>
	</xsl:if>
	<xsl:call-template name="currency-field">
      <xsl:with-param name="label">XSL_LIMIT_AMOUNT</xsl:with-param>
      <xsl:with-param name="product-code">ft</xsl:with-param>
      <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
      <xsl:with-param name="override-currency-value">
      	<xsl:choose>
      		<xsl:when test="ft_cur_code[.!='']"><xsl:value-of select="ft_cur_code"/></xsl:when>
      		<xsl:otherwise><xsl:value-of select="customer_payee/customer_payee_record/cur_code"/></xsl:otherwise>
      	</xsl:choose>
      </xsl:with-param>
      <xsl:with-param name="override-amt-value">   
      	<xsl:choose>
      		<xsl:when test="ft_amt[.!='']"><xsl:value-of select="ft_amt"/></xsl:when>
      		<xsl:otherwise>
      			<xsl:choose>
      				<xsl:when test="customer_payee/customer_payee_record/limit_amt[.!='']"><xsl:value-of select="customer_payee/customer_payee_record/limit_amt"/></xsl:when>
      				<xsl:otherwise>999999999999999</xsl:otherwise>
      			</xsl:choose>
      		</xsl:otherwise>
      	</xsl:choose>
      	</xsl:with-param>
	  <xsl:with-param name="required">Y</xsl:with-param>
     </xsl:call-template>
     
	<!--  Start Date. --> 
	   	<xsl:call-template name="business-date-field">
		    <xsl:with-param name="label">XSL_START_DATE</xsl:with-param>
		    <xsl:with-param name="name">start_date</xsl:with-param>
		    <xsl:with-param name="size">10</xsl:with-param>
		    <xsl:with-param name="maxsize">10</xsl:with-param>
		    <xsl:with-param name="required">Y</xsl:with-param>
		    <xsl:with-param name="fieldsize">small</xsl:with-param>
		    <xsl:with-param name="sub-product-code-widget-id">sub_product_code</xsl:with-param>
		    <xsl:with-param name="bank-abbv-name-widget-id">issuing_bank_abbv_name</xsl:with-param>
		     <xsl:with-param name="bank-abbv-name-widget-id">issuing_bank_abbv_name</xsl:with-param>
		</xsl:call-template>
	
	<!--  End Date. --> 
	   	<xsl:call-template name="business-date-field">
		    <xsl:with-param name="label">XSL_END_DATE</xsl:with-param>
		    <xsl:with-param name="name">end_date</xsl:with-param>
		    <xsl:with-param name="size">10</xsl:with-param>
		    <xsl:with-param name="maxsize">10</xsl:with-param>
		    <xsl:with-param name="required">Y</xsl:with-param>
		    <xsl:with-param name="fieldsize">small</xsl:with-param>
		    <xsl:with-param name="sub-product-code-widget-id">sub_product_code</xsl:with-param>
		    <xsl:with-param name="bank-abbv-name-widget-id">issuing_bank_abbv_name</xsl:with-param>
		     <xsl:with-param name="bank-abbv-name-widget-id">issuing_bank_abbv_name</xsl:with-param>
	   	</xsl:call-template>
	   	<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">start_date_unsigned</xsl:with-param>
	     	<xsl:with-param name="value" select="start_date"></xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">end_date_unsigned</xsl:with-param>
	     	<xsl:with-param name="value" select="end_date"></xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">sub_product_code_unsigned</xsl:with-param>
	     	<xsl:with-param name="value" select="sub_product_code"></xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">display_entity_unsigned</xsl:with-param>
	     	<xsl:with-param name="value" select="entity"></xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">ft_cur_code_unsigned</xsl:with-param>
	     	<xsl:with-param name="value" select="ft_cur_code"></xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">ft_amt_unsigned</xsl:with-param>
	     	<xsl:with-param name="value" select="ft_amt"></xsl:with-param>
		</xsl:call-template>
		
	<!-- Customer Reference -->	
	   	<xsl:call-template name="customer-reference-field"/>
	</xsl:template>
	
	<!-- Customer Payee registration details -->
	<!-- Display the references for the payee -->
	<xsl:template match="customer_payee_ref_record">
		<xsl:param name="disable"/>
		<xsl:variable name="makeReadOnly">
			<xsl:choose>
				<xsl:when test="$disable='Y'">Y</xsl:when>
				<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="payeeCode"><xsl:value-of select="/ft_tnx_record/customer_payee/customer_payee_record/payee_code"/></xsl:variable>
		<xsl:variable name="reference_id"><xsl:value-of select="reference_id"/></xsl:variable>
		<xsl:variable name="loc_lan"><xsl:value-of select="$local_language"/></xsl:variable>
  		<xsl:variable name="user_lan"><xsl:value-of select="$user_language"/></xsl:variable>
  		<xsl:variable name="issuing_bank"><xsl:value-of select="/ft_tnx_record/issuing_bank/abbv_name"/></xsl:variable>
		<xsl:choose>
	  		<xsl:when test="field_type[.='S']">
				<xsl:choose>
					<xsl:when test="input_in_type[.='T']">
					<xsl:choose>
						<xsl:when test="$displaymode = 'edit'">
							<script>
						        var item = 0;
						        dojo.ready(function(){
						        	misys._config = misys._config || {};
						        	
							        dojo.mixin(misys._config,{
							        	referenceOptionsArray : misys._config.referenceOptionsArray || []
							        });
							       	misys._config.referenceOptionsArray["<xsl:value-of select="reference_seq"/>"] = misys._config.referenceOptionsArray["<xsl:value-of select="reference_seq"/>"] || [];
							       	
								});
							</script>
							<xsl:variable name="referenceSeq"><xsl:value-of select="reference_seq"/></xsl:variable>
							<xsl:variable name="option"><xsl:value-of select="ref_value"/></xsl:variable>
				     			<xsl:call-template name="select-field">
							      		<xsl:with-param name="label">
							      			<xsl:choose>
						      					<xsl:when test="$loc_lan = $user_lan and local_label[.!='']"><xsl:value-of select="local_label"/>:</xsl:when>
						      					<xsl:otherwise><xsl:value-of select="label"/>:</xsl:otherwise>
					      					</xsl:choose>
							      		</xsl:with-param>
							      		<xsl:with-param name="override-label">
							      			<xsl:choose>
						      					<xsl:when test="$loc_lan = $user_lan and local_label[.!='']"><xsl:value-of select="local_label"/>:</xsl:when>
						      					<xsl:otherwise><xsl:value-of select="label"/>:</xsl:otherwise>
					      					</xsl:choose>
							      		</xsl:with-param>
							      		<xsl:with-param name="name">customer_payee_ref_<xsl:value-of select="reference_seq"/></xsl:with-param>
							      		<xsl:with-param name="value"><xsl:value-of select="ref_value"/></xsl:with-param>
							      		<xsl:with-param name="required">
							      		<xsl:choose><xsl:when test="optional[.='Y']">N</xsl:when><xsl:otherwise>Y</xsl:otherwise></xsl:choose>
							      		</xsl:with-param>
							      		<xsl:with-param name="disabled">
								      		<xsl:choose>
												<xsl:when test="$makeReadOnly='Y'">Y</xsl:when>
												<xsl:otherwise>N</xsl:otherwise>
											</xsl:choose>
							      		</xsl:with-param>
							      		<xsl:with-param name="options">
											<xsl:for-each select="reference_options/reference_option">
												<option>
													<xsl:attribute name="value"><xsl:value-of select="option_code"></xsl:value-of></xsl:attribute>
													<xsl:value-of select="description" />
												</option>
											</xsl:for-each>
											<xsl:for-each select="reference_options">
												<xsl:variable name="sourceReferenceSeq"><xsl:value-of select="@id"/></xsl:variable>
												<script>
												<xsl:for-each select="related_reference">
												<!-- Initializing the referenceOptions array -->
											  	<xsl:variable name="sourceReferenceValue"><xsl:value-of select="@value"/></xsl:variable>
												dojo.ready(function(){
									        		misys._config.referenceOptionsArray["<xsl:value-of select="$referenceSeq"/>"]["<xsl:value-of select="$sourceReferenceValue" />"] = misys._config.referenceOptionsArray["<xsl:value-of select="$referenceSeq"/>"]["<xsl:value-of select="$sourceReferenceValue" />"] || [];
									        		
												});
												</xsl:for-each>
												<!-- Connect event on the change of the field which has a related reference. The store for the related select field is created onChange. -->
												<xsl:if test="$sourceReferenceSeq != 'null'">
												dojo.subscribe("ready",function(){
											  			misys.connect("customer_payee_ref_<xsl:value-of select="$sourceReferenceSeq"/>","onChange",function(){
											  				dijit.byId("customer_payee_ref_<xsl:value-of select="$referenceSeq"/>").set("value", "");
												  			dijit.byId("customer_payee_ref_<xsl:value-of select="$referenceSeq"/>").store = null;
											  				dijit.byId("customer_payee_ref_<xsl:value-of select="$referenceSeq"/>").store = new dojo.data.ItemFileReadStore({
																	data :{
																			identifier : "value",
																			label : "name",
																			items : misys._config.referenceOptionsArray['<xsl:value-of select="$referenceSeq"/>'][this.getValue()]
																		  }
																		});
												  			});
														  			if(dijit.byId("customer_payee_ref_<xsl:value-of select="$referenceSeq"/>").get("value") === "")
														  			{
														  				<!-- verify if the source reference is selected -->
															  			if(dijit.byId("ref_<xsl:value-of select="$sourceReferenceSeq"/>").get("value") !== "")
															  			{
															  				<!-- as the source reference is selected so creating the store for the related reference -->
															  				dijit.byId("customer_payee_ref_<xsl:value-of select="$referenceSeq"/>").store = new dojo.data.ItemFileReadStore({
																			data :{
																				identifier : "value",
																				label : "name",
																				items : misys._config.referenceOptionsArray['<xsl:value-of select="$referenceSeq"/>'][dijit.byId("ref_<xsl:value-of select="$sourceReferenceSeq"/>").get("value")]
																			}
																			});
																			<!-- verify if the related reference has a value -->
																			if(dijit.byId("ref_<xsl:value-of select="$referenceSeq"/>").get("value") !== "")
															  				{
																  				<!-- as the related reference has a value so setting its value for display. -->
																				dijit.byId("customer_payee_ref_<xsl:value-of select="$referenceSeq"/>").set("value", "<xsl:value-of select="$option"/>");
														  					}
																		}
														  			}
										  			});
										  		</xsl:if>
				  								
												</script>
												
												<script>
												<!-- Populating the array -->
												<xsl:for-each select="related_reference">
												<xsl:variable name="sourceReferenceValue"><xsl:value-of select="@value"/></xsl:variable>
												dojo.ready(function(){
									        		misys._config.referenceOptionsArray["<xsl:value-of select="$referenceSeq"/>"]["<xsl:value-of select="$sourceReferenceValue" />"] = [
									        		<xsl:for-each select="reference_option">
												    { 
						   								value:"<xsl:value-of select="./option_code"/>",name:"<xsl:value-of select="./description"/>"
						   							}
						   							<xsl:if test="not(position()=last())">,</xsl:if>
													</xsl:for-each>
									        		];
												});
												</xsl:for-each>
								
												</script>
											</xsl:for-each>
										</xsl:with-param>
						     	</xsl:call-template>
						     	<xsl:call-template name="hidden-field">
							     	<xsl:with-param name="name">ref_<xsl:value-of select="reference_seq"/></xsl:with-param>
							     	<xsl:with-param name="value"><xsl:value-of select="ref_value"/></xsl:with-param>
						     	</xsl:call-template>
						     	</xsl:when>
						     	<xsl:otherwise>
					  			<xsl:variable name="ref_value"><xsl:value-of select="ref_value"/></xsl:variable>
						     		<xsl:call-template name="input-field">
								    	<xsl:with-param name="label">
							      			<xsl:choose>
						      					<xsl:when test="$loc_lan = $user_lan and local_label[.!='']"><xsl:value-of select="local_label"/>:</xsl:when>
						      					<xsl:otherwise><xsl:value-of select="label"/>:</xsl:otherwise>
					      					</xsl:choose>
							      		</xsl:with-param>
							      		<xsl:with-param name="override-label">
							      			<xsl:choose>
						      					<xsl:when test="$loc_lan = $user_lan and local_label[.!='']"><xsl:value-of select="local_label"/>:</xsl:when>
						      					<xsl:otherwise><xsl:value-of select="label"/>:</xsl:otherwise>
					      					</xsl:choose>
							      		</xsl:with-param>
							      		<xsl:with-param name="override-displaymode">view</xsl:with-param>
							      		<xsl:with-param name="value"><xsl:value-of select="payeeutils:getDescriptionFromCode($payeeCode, $reference_id, $ref_value, $user_lan, $loc_lan, $issuing_bank)"/></xsl:with-param>
									</xsl:call-template>
						     	</xsl:otherwise>
					     	</xsl:choose>
					  	</xsl:when>
					  	<xsl:otherwise>
					  	<xsl:variable name="ref_value"><xsl:value-of select="ref_value"/></xsl:variable>
					  		<xsl:call-template name="input-field">
							    	<xsl:with-param name="label">
							      		<xsl:choose>
						      				<xsl:when test="$loc_lan = $user_lan and local_label[.!='']"><xsl:value-of select="local_label"/>:</xsl:when>
						      				<xsl:otherwise><xsl:value-of select="label"/>:</xsl:otherwise>
					      				</xsl:choose>
							      	</xsl:with-param>
							      	<xsl:with-param name="override-label">
							      		<xsl:choose>
						      				<xsl:when test="$loc_lan = $user_lan and local_label[.!='']"><xsl:value-of select="local_label"/>:</xsl:when>
						      				<xsl:otherwise><xsl:value-of select="label"/>:</xsl:otherwise>
					      				</xsl:choose>
							      	</xsl:with-param>
						      		<xsl:with-param name="override-displaymode">view</xsl:with-param>
						      		<xsl:with-param name="value"><xsl:value-of select="payeeutils:getDescriptionFromCode($payeeCode, $reference_id, $ref_value, $user_lan, $loc_lan, $issuing_bank)"/></xsl:with-param>
							   </xsl:call-template>
					  	</xsl:otherwise>
			  		</xsl:choose> 
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="input-field">
			      		<xsl:with-param name="label">
			      			<xsl:choose>
		      					<xsl:when test="$loc_lan = $user_lan and local_label[.!='']"><xsl:value-of select="local_label"/>:</xsl:when>
		      					<xsl:otherwise><xsl:value-of select="label"/>:</xsl:otherwise>
	      					</xsl:choose>
			      		</xsl:with-param>
			      		<xsl:with-param name="override-label">
			      			<xsl:choose>
		      					<xsl:when test="$loc_lan = $user_lan and local_label[.!='']"><xsl:value-of select="local_label"/>:</xsl:when>
		      					<xsl:otherwise><xsl:value-of select="label"/>:</xsl:otherwise>
	      					</xsl:choose>
			      		</xsl:with-param>
			      		<xsl:with-param name="name">customer_payee_ref_<xsl:value-of select="reference_seq"/></xsl:with-param>
			      		<xsl:with-param name="required">
			      			<xsl:choose><xsl:when test="optional[.='Y']">N</xsl:when><xsl:otherwise>Y</xsl:otherwise></xsl:choose>
			      		</xsl:with-param>
						<xsl:with-param name="regular-expression"><xsl:value-of select="validation_format"/></xsl:with-param>
			      		<xsl:with-param name="size">25</xsl:with-param>
			    		<xsl:with-param name="maxsize">25</xsl:with-param>
			      		<xsl:with-param name="fieldsize">small</xsl:with-param>
			      		<xsl:with-param name="appendClass">
			      		<xsl:if test="(help_message[.!=''] or local_help_message[.!='']) and $displaymode = 'edit'">inlineBlock</xsl:if>
			      		</xsl:with-param>
			      		<xsl:with-param name="disabled">
				      		<xsl:choose>
								<xsl:when test="$makeReadOnly='Y'">Y</xsl:when>
								<xsl:otherwise>N</xsl:otherwise>
							</xsl:choose>
			      		</xsl:with-param>
			      		<xsl:with-param name="value">	      		
			      			<xsl:value-of select="ref_value"/>
			      			<xsl:if test="ref_value[.='']"></xsl:if>		      			
			      		</xsl:with-param>
			      		<xsl:with-param name="override-displaymode"><xsl:choose><xsl:when test="input_in_type[.='R']">view</xsl:when><xsl:otherwise><xsl:value-of select="$displaymode"/></xsl:otherwise></xsl:choose></xsl:with-param>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
			 <xsl:if test="input_in_type[.='R']">
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">customer_payee_ref_<xsl:value-of select="reference_seq"/></xsl:with-param>
		       		<xsl:with-param name="value"><xsl:value-of select="ref_value"/></xsl:with-param>
				</xsl:call-template>
			 </xsl:if>
			 <xsl:if test="(help_message[.!=''] or local_help_message[.!='']) and $displaymode = 'edit'">
				 <xsl:call-template name="button-wrapper">
					<xsl:with-param name="show-image">Y</xsl:with-param>
					<xsl:with-param name="show-border">N</xsl:with-param>		      
			     	<xsl:with-param name="img-src"><xsl:value-of select="utils:getImagePath($checkOrRevertImage)"/></xsl:with-param>
			     	<xsl:with-param name="onclick">
				     	<xsl:choose>
			      			<xsl:when test="$loc_lan = $user_lan and local_help_message[.!='']">misys.showReference('<xsl:value-of select="local_help_message"/>');return false;</xsl:when>
			      			<xsl:otherwise>misys.showReference('<xsl:value-of select="help_message"/>');return false;</xsl:otherwise>
			      		</xsl:choose>
		      		</xsl:with-param>
			     	
			     	
			     	<xsl:with-param name="non-dijit-button">N</xsl:with-param>
				 </xsl:call-template>
		   	 </xsl:if>
	</xsl:template>	
	
	<!-- Customer reference. -->
	<xsl:template name="customer-reference-field">
	<xsl:param name="disabled"/>
	<xsl:variable name="makeReadOnly">
		<xsl:choose>
			<xsl:when test="$disabled='Y'">Y</xsl:when>
			<xsl:otherwise>N</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
		<xsl:call-template name="input-field">
  			<xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>			
  			<xsl:with-param name="name">cust_ref_id</xsl:with-param>
			<xsl:with-param name="size">16</xsl:with-param>
			<xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_CASH_LENGTH')"/></xsl:with-param>
			<xsl:with-param name="regular-expression">
					<xsl:value-of select="defaultresource:getResource('CUSTOMER_REFERENCE_CASH_VALIDATION_REGEX')"/>
			</xsl:with-param>
			<xsl:with-param name="fieldsize">small</xsl:with-param>
			<xsl:with-param name="override-displaymode">
				<xsl:choose>
					<xsl:when test="$makeReadOnly='Y'">view</xsl:when>
					<xsl:otherwise><xsl:value-of select="$displaymode"/></xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
 		</xsl:call-template>
 	</xsl:template>
</xsl:stylesheet>