<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet
		version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:backoffice="xalan://com.misys.portal.loan.loaniq.LoanIQAdapter"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		exclude-result-prefixes="localization backoffice utils defaultresource">


<!-- Parameters -->  
<xsl:param name="rundata"/>
<xsl:param name="language">en</xsl:param>
<xsl:param name="displaymode">edit</xsl:param>
<xsl:param name="mode">DRAFT</xsl:param>
<xsl:param name="collaborationmode">none</xsl:param>
<xsl:param name="product-code">LN</xsl:param>
<xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/LoanScreen</xsl:param>
<xsl:param name="currencies"/>
<xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
<xsl:param name="actionDownImage"><xsl:value-of select="$images_path"/>action-down.png</xsl:param>
<xsl:param name="actionUpImage"><xsl:value-of select="$images_path"/>action-up.png</xsl:param>
<xsl:param name="optionCode">OTHERS</xsl:param>
<xsl:param name="authorizerid"></xsl:param>
<xsl:param name="reviewandprint">false</xsl:param>



<!-- Global Imports. -->
<xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
<xsl:include href="../../core/xsl/common/trade_common.xsl" />
<xsl:include href="../../core/xsl/common/ln_common.xsl" />
<xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />


<!-- output -->
<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />


<!-- main -->
<xsl:template match="/">
	<xsl:apply-templates select="ln_tnx_record"/>
</xsl:template>


<!-- 
  LN TNX FORM TEMPLATE.
 -->
<xsl:template match="ln_tnx_record">
<xsl:variable name="is_legal"><xsl:value-of select="isLegalTextAccepted"/></xsl:variable>
<xsl:variable name="legal_text_value" select="backoffice:getLegalText($language,issuing_bank/abbv_name,facility_type,'INCREASE')"/>

<script>
				dojo.ready(function(){			
					  	misys._config = misys._config || {};			
					    misys._config.legalTextEnabled = false;
									
					});
	  			</script>
	<!-- Preloader -->
	<xsl:call-template name="loading-message"/>

	<!-- Javascript and Dojo imports  -->
	<xsl:call-template name="js-imports"/>
	
	<div>
		<xsl:attribute name="id"><xsl:value-of select="$displaymode" /></xsl:attribute>
		
		<!-- main -->	
		<xsl:call-template name="form-wrapper">
			<xsl:with-param name="name">fakeform1</xsl:with-param>
			<xsl:with-param name="validating">Y</xsl:with-param>
			<xsl:with-param name="content">
				<!--  Display common menu.  -->
				<xsl:call-template name="menu">
					<xsl:with-param name="show-template">N</xsl:with-param>
					<xsl:with-param name="show-return">Y</xsl:with-param>
					<xsl:with-param name="bulk-transaction-mode">N</xsl:with-param>
				</xsl:call-template>
				

				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
					<xsl:with-param name="button-type">summary-details</xsl:with-param>
					<xsl:with-param name="content">
						<!-- system id -->
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">ref_id</xsl:with-param>
							<xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>

						<!-- back office id -->
						<div style="white-space:pre;">
						<xsl:call-template name="input-field">
							<xsl:with-param name="name">bo_ref_id</xsl:with-param>
							<xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID_LN</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
						</div>
								
						<!-- customer reference -->
						<div style="white-space:pre;">
						<xsl:call-template name="input-field">
  							<xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>
							<xsl:with-param name="name">cust_ref_id</xsl:with-param>
							<xsl:with-param name="override-displaymode">view</xsl:with-param>
						</xsl:call-template>
						</div>
						
						<!-- <xsl:apply-templates select="data/facility" /> -->
						<xsl:choose>
							<xsl:when test="$displaymode != 'view'">
								<xsl:call-template name="facility-details" />
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_FACILITYDETAILS_DEAL</xsl:with-param>
									<xsl:with-param name="name">bo_deal_name</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_FACILITYDETAILS_FACILITY</xsl:with-param>
									<xsl:with-param name="name">bo_facility_name</xsl:with-param>
								</xsl:call-template>
								<xsl:if test="amd_no[.!='']">
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_GENERALDETAILS_AMD_COUNT</xsl:with-param>
									<xsl:with-param name="name">amd_no</xsl:with-param>
								</xsl:call-template>
                     			</xsl:if>									
							</xsl:otherwise>
						</xsl:choose>
						<xsl:call-template name="borrower-details" />
						<xsl:call-template name="loan-details" />
					</xsl:with-param>
				</xsl:call-template>
			
				<xsl:call-template name="hidden-fields">
						<xsl:with-param name="legal_text_value"><xsl:value-of select="$legal_text_value"/></xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="loan-amend-details" />
				<xsl:call-template name="loan-additional-details" />
				
				 <!-- comments for return -->
		        <xsl:call-template name="comments-for-return">
			  		<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
			   		<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
		   	    </xsl:call-template>
						
				<!-- Attach Files -->
    			<xsl:call-template name="attachments-file-dojo"/>
				<xsl:choose>
    				<xsl:when test = "($mode = 'DRAFT' or $mode = 'UNSIGNED') and ($optionCode != 'SNAPSHOT' and $reviewandprint != 'true') and $legal_text_value != ''">
						<xsl:call-template name="legal_text_popup_template" >
							<xsl:with-param name="legal">
								<xsl:value-of select="$legal_text_value"/>
							</xsl:with-param>
						</xsl:call-template>
    				</xsl:when>
    				<xsl:otherwise>
    					<xsl:if test = "$displaymode = 'view' and legal_text_value != '' and ($optionCode = 'SNAPSHOT' or $reviewandprint = 'true') and defaultresource:getResource('DISPLAY_LEGAL_TEXT_FOR_LOAN') = 'true' and $is_legal != 'N'" >
    						<xsl:call-template name="legal_text_template" >
								<xsl:with-param name="legal">
									<xsl:value-of select="legal_text_value"/>
								</xsl:with-param>
							</xsl:call-template>
    					</xsl:if>
    				</xsl:otherwise>
    			</xsl:choose>
    			
    			<xsl:if test="$optionCode = 'SNAPSHOT' or $reviewandprint = 'true' and $is_legal != 'N'">
    				<!-- For displaying all Authorizer's name -->
	    			<xsl:call-template name="display-authorizer-name">
	    				<xsl:with-param name="list"><xsl:value-of select="authorizer_id"/></xsl:with-param>
	    			</xsl:call-template>
    			</xsl:if>	
								
				<!--  Display common menu.  -->
				<xsl:call-template name="menu">
					<xsl:with-param name="show-template">N</xsl:with-param>
					<xsl:with-param name="second-menu">Y</xsl:with-param>
					<xsl:with-param name="show-return">Y</xsl:with-param>
					<xsl:with-param name="bulk-transaction-mode">N</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="toc"/>
		<xsl:call-template name="reauthentication"/>
		
		 <!--  Collaboration Window -->     
	   	<xsl:call-template name="collaboration">
		    <xsl:with-param name="editable">true</xsl:with-param>
		    <xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>
		    <xsl:with-param name="contextPath"><xsl:value-of select="$contextPath"/></xsl:with-param>
		    <xsl:with-param name="bank_name_widget_id">issuing_bank_name</xsl:with-param>
			<xsl:with-param name="bank_abbv_name_widget_id">issuing_bank_abbv_name</xsl:with-param>
	   	</xsl:call-template>
   
     
		<!-- real form -->
		<xsl:call-template name="realform" />
		
	</div>
</xsl:template>


<!-- Additional JS imports -->
<xsl:template name="js-imports">
	<xsl:call-template name="common-js-imports">
		<xsl:with-param name="binding">misys.binding.loan.amend_ln</xsl:with-param>
		<xsl:with-param name="show-period-js">Y</xsl:with-param>
		<xsl:with-param name="override-help-access-key">LN_03</xsl:with-param>
	</xsl:call-template>
	<script type="text/javascript">
		dojo.ready(function(){
			misys._config.warnFacilityAmtExceeded = {};
			misys._config.warnFacilityAmtExceeded = <xsl:value-of select="defaultresource:getResource('FACILITY_LIMIT_EXCEEDED_WARNING')" />
		});
	</script>
</xsl:template>

<xsl:template name="loan-additional-details">
	<xsl:param name="override-displaymode"/>
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_LOAN_ADDITIONAL_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
    <xsl:choose>
    	<xsl:when test="$displaymode !='view'">
    		<xsl:call-template name="textarea-field">	
    	            <xsl:with-param name="label">XSL_LOAN_INCREASE_REASON</xsl:with-param>
			        <xsl:with-param name="name">free_format_text</xsl:with-param>
			        <xsl:with-param name="cols">68</xsl:with-param>
			        <xsl:with-param name="rows">5</xsl:with-param>
			        <xsl:with-param name="maxlines">5</xsl:with-param>	
			        <xsl:with-param name="swift-validate">N</xsl:with-param>		        
			        <xsl:with-param name="override-displaymode">
						<xsl:value-of select="$displaymode"/>
					</xsl:with-param>
	   	 	</xsl:call-template>
    	</xsl:when>
    	<xsl:otherwise>
    		 <xsl:call-template name="big-textarea-wrapper">	
    	            <xsl:with-param name="label">XSL_LOAN_INCREASE_REASON</xsl:with-param>
			        <xsl:with-param name="content"><div class="content">
		            <xsl:value-of select="free_format_text"/>
		           	</div></xsl:with-param>
			        <xsl:with-param name="cols">68</xsl:with-param>
			        <xsl:with-param name="rows">5</xsl:with-param>
			        <xsl:with-param name="maxlines">5</xsl:with-param>	
			        <xsl:with-param name="swift-validate">N</xsl:with-param>		        
			        <xsl:with-param name="override-displaymode">
						<xsl:value-of select="$displaymode"/>
					</xsl:with-param>
	   		 </xsl:call-template>
    	</xsl:otherwise>
    </xsl:choose>
    	
     </xsl:with-param>
   </xsl:call-template>
</xsl:template>

<!-- loan details -->
<xsl:template name="loan-amend-details">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_LOAN_AMENDMENT</xsl:with-param>
		<xsl:with-param name="content">
		
			<xsl:if test="$displaymode != 'view'">
			<script>
				// if currenciesStore not already defined
					
				dojo.ready(function(){
					misys._config.currenciesStore = {} ; 
					misys._config.currenciesStore = new dojo.data.ItemFileReadStore(<xsl:value-of select="$currencies"/>);
				});				
			</script>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">facility_available_amt</xsl:with-param>
					<xsl:with-param name="value" select="borrower_available_amt" />
				</xsl:call-template>
			</xsl:if>
			
			
			<!-- application date -->
    		<xsl:call-template name="input-field">
    			<xsl:with-param name="name">appl_date</xsl:with-param>
     			<xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
     			<xsl:with-param name="value" select="appl_date" />
     			<xsl:with-param name="override-displaymode">view</xsl:with-param>
    		</xsl:call-template>
			
		    <!-- amend date -->
    		<xsl:call-template name="input-field">
    			<xsl:with-param name="label">XSL_GENERALDETAILS_LOAN_AMD_DATE</xsl:with-param>
     			<xsl:with-param name="name">amd_date</xsl:with-param>
    			<xsl:with-param name="type">date</xsl:with-param>
    			<xsl:with-param name="fieldsize">small</xsl:with-param>
     			<xsl:with-param name="size">15</xsl:with-param>
    			<xsl:with-param name="maxsize">20</xsl:with-param>
     			<xsl:with-param name="required">Y</xsl:with-param>
    		</xsl:call-template>

			<!-- increase amount -->
     		<xsl:call-template name="currency-field">
      			<xsl:with-param name="label">XSL_LOAN_AMEND_INCREASE_AMT</xsl:with-param>
      			<xsl:with-param name="product-code">ln</xsl:with-param>
      			<xsl:with-param name="required">Y</xsl:with-param>
      			<xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
      			<xsl:with-param name="override-amt-name">tnx_amt</xsl:with-param>
     		</xsl:call-template>
     
			<!-- new loan liab amount -->
    		<xsl:call-template name="currency-field">
    			<xsl:with-param name="label">XSL_LOAN_LIAB_NEW_AMT</xsl:with-param>
    			<xsl:with-param name="product-code">ln</xsl:with-param>
    			<xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
    			<xsl:with-param name="disabled">Y</xsl:with-param>
				<xsl:with-param name="override-amt-name">ln_liab_amt</xsl:with-param>
				<xsl:with-param name="override-amt-value"><xsl:value-of select="ln_liab_amt"/></xsl:with-param>
				<xsl:with-param name="amt-readonly">Y</xsl:with-param>
    		</xsl:call-template>
    		<xsl:if test="fac_cur_code [.!=''] and fac_cur_code != ln_cur_code">
    		<xsl:variable name="fx_rate" select="backoffice:getFXRate(fac_cur_code,ln_cur_code,issuing_bank/abbv_name,$language)"/>
    			<xsl:choose>
    				<xsl:when test="tnx_stat_code != 04">
	    				<xsl:call-template name="input-field">
			    			<xsl:with-param name="type">text</xsl:with-param>
			    			<xsl:with-param name="name">fx_display</xsl:with-param>
			     			<xsl:with-param name="label">XSL_INDICATIVE_FX_RATE</xsl:with-param>
			     			<xsl:with-param name="disabled">Y</xsl:with-param>
			     			<xsl:with-param name="value">1 <xsl:value-of select="fac_cur_code"/> = <xsl:value-of select="$fx_rate"/><xsl:text> </xsl:text><xsl:value-of select="ln_cur_code" /></xsl:with-param>
			     			<xsl:with-param name="fieldsize">medium</xsl:with-param>
		    			</xsl:call-template>   
		    			<div style="font-weight:bold;margin-left:245px;font-style:italic;"><xsl:value-of select="localization:getGTPString($language, 'XSL_INDICATIVE_FX_NOTE')"/></div>
			    		<xsl:call-template name="hidden-field">
					       <xsl:with-param name="name">fx_conversion_rate</xsl:with-param>
					       <xsl:with-param name="value" select="$fx_rate"/>
					    </xsl:call-template>
    				</xsl:when>
    				<xsl:otherwise>
    					<xsl:call-template name="input-field">
			     			<xsl:with-param name="label">LN_FX_RATE</xsl:with-param>
			     			<xsl:with-param name="value"><xsl:value-of select="$fx_rate"/></xsl:with-param>
		    			</xsl:call-template>
    				</xsl:otherwise>
   				</xsl:choose>
		    </xsl:if>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>


<!-- real form -->
<xsl:template name="realform">
	<xsl:call-template name="form-wrapper">
		<xsl:with-param name="name">realform</xsl:with-param>
		<xsl:with-param name="action"><xsl:value-of select="$realform-action"></xsl:value-of></xsl:with-param>
		<xsl:with-param name="content">
		 <div class="widgetContainer">
			<xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">referenceid</xsl:with-param>
		       <xsl:with-param name="value" select="ref_id"/>
		      </xsl:call-template>
		      <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">tnxid</xsl:with-param>
		       <xsl:with-param name="value" select="tnx_id"/>
		      </xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">operation</xsl:with-param>
				<xsl:with-param name="id">realform_operation</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">mode</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="$mode"></xsl:value-of>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">tnxtype</xsl:with-param>
				<xsl:with-param name="value">03</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">TransactionData</xsl:with-param>
				<xsl:with-param name="value" />
			</xsl:call-template>
			 <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">attIds</xsl:with-param>
		       <xsl:with-param name="value"/>
     	  </xsl:call-template>
		 <xsl:call-template name="e2ee_transaction"/>
        <xsl:call-template name="reauth_params"/>
		 </div>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>


<xsl:template name="hidden-fields">
	<xsl:param name="legal_text_value"></xsl:param>
	<xsl:call-template name="common-hidden-fields">
	<xsl:with-param name="show-tnx-amt">N</xsl:with-param>
	</xsl:call-template>
	 <div class="widgetContainer">
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">ref_id</xsl:with-param>
		</xsl:call-template>
   		<!-- <xsl:call-template name="hidden-field">
    		<xsl:with-param name="name">tnx_id</xsl:with-param>
   		</xsl:call-template> -->
   		
   		<!-- access_type -->
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">ln_access_type</xsl:with-param>
		</xsl:call-template>
   		<xsl:call-template name="hidden-field">
    		<xsl:with-param name="name">amd_no</xsl:with-param>
   		</xsl:call-template>
   		 <xsl:call-template name="hidden-field">
   			<xsl:with-param name="name">org_ln_amt</xsl:with-param>
   			<xsl:with-param name="value"><xsl:value-of select="backoffice:getAmount(ln_amt)" /></xsl:with-param>
   		</xsl:call-template>
    	<xsl:call-template name="hidden-field">
   			<xsl:with-param name="name">ln_amt</xsl:with-param>
   		</xsl:call-template>
    	<xsl:call-template name="hidden-field">
   			<xsl:with-param name="name">ln_cur_code</xsl:with-param>
   		</xsl:call-template>
   		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">iss_date</xsl:with-param>
		</xsl:call-template>
				<!-- bo_facility_name -->
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">bo_facility_name</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">ln_maturity_date</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">effective_date</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">expiryDate</xsl:with-param>
		</xsl:call-template>	
  		<xsl:call-template name="hidden-field">
  	 		<xsl:with-param name="name">entity</xsl:with-param>
  		</xsl:call-template>
  		<xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">facility_expiry_date</xsl:with-param>
     	</xsl:call-template>
     	<xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">repricing_date</xsl:with-param>
     	</xsl:call-template>
		<xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">sub_product_code</xsl:with-param>
     	</xsl:call-template>
     	<xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">sublimit_expiry_date</xsl:with-param>
     	</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">authorizer_id</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select= "$authorizerid"/></xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">legal_text_value</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select= "$legal_text_value"/></xsl:with-param>
		</xsl:call-template>
     	
		<!-- appl_date to save while amending -->
		<xsl:call-template name="hidden-field">
			<xsl:with-param name="name">appl_date</xsl:with-param>
		</xsl:call-template>    
		
		<xsl:call-template name="hidden-field">
				<xsl:with-param name="name">amd_date_unsinged</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="amd_date"/></xsl:with-param>
			</xsl:call-template>
	    <xsl:call-template name="hidden-field">
				<xsl:with-param name="name">sub_tnx_type_code</xsl:with-param>
				<xsl:with-param name="value">B2</xsl:with-param>
		</xsl:call-template>
  	 </div>
	
</xsl:template>

</xsl:stylesheet>
