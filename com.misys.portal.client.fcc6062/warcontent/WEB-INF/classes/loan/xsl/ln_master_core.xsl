<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet
		version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:backoffice="xalan://com.misys.portal.loaniq.LoanIQAdapter"
		exclude-result-prefixes="localization backoffice">


<!-- Parameters -->  
<xsl:param name="rundata"/>
<xsl:param name="language">en</xsl:param>
<xsl:param name="displaymode">view</xsl:param>
<xsl:param name="mode">DRAFT</xsl:param>
<xsl:param name="collaborationmode">none</xsl:param>
<xsl:param name="product-code">LN</xsl:param>
<xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/LoanScreen</xsl:param>


<!-- Global Imports. -->
<xsl:include href="../../core/xsl/common/trade_common.xsl" />


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
	<!-- Preloader -->
	<xsl:call-template name="loading-message"/>

	<div>
		<xsl:attribute name="id"><xsl:value-of select="$displaymode" /></xsl:attribute>
		
		<!-- main -->	
		<xsl:call-template name="form-wrapper">
			<xsl:with-param name="name">fakeform</xsl:with-param>
			<xsl:with-param name="validating">Y</xsl:with-param>
			<xsl:with-param name="content">
				<!--  Display common menu.  -->
				<xsl:call-template name="menu">
					<xsl:with-param name="show-template">N</xsl:with-param>
				</xsl:call-template>
			
				<xsl:call-template name="general-details" />
				<xsl:call-template name="loan-details" />
				
				<!--  Display common menu.  -->
				<xsl:call-template name="menu">
					<xsl:with-param name="show-template">N</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>

		<!-- real form -->
		<xsl:call-template name="realform" />
	</div>
	
	<!-- Table of Contents -->
	<xsl:call-template name="toc"/>
	   
    <!--  Collaboration Window -->     
    <xsl:call-template name="collaboration">
     <xsl:with-param name="editable">true</xsl:with-param>
     <xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>
     <xsl:with-param name="contextPath"><xsl:value-of select="$contextPath"/></xsl:with-param>
    </xsl:call-template>
    
   
	
</xsl:template>


<!-- general details -->
<xsl:template name="general-details">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
		<xsl:with-param name="content">
			<!-- system id -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="name">ref_id</xsl:with-param>
				<xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>

			<!-- bo ref id -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="name">bo_ref_id</xsl:with-param>
				<xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID_LN</xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
		
			<!-- customer reference -->
			<xsl:call-template name="input-field">
  				<xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>
				<xsl:with-param name="name">cust_ref_id</xsl:with-param>
				<xsl:with-param name="size">20</xsl:with-param>
				<xsl:with-param name="maxsize">34</xsl:with-param>
			</xsl:call-template>		
		
			<!-- loan amount -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">PROD_STAT_CODE</xsl:with-param>
				<xsl:with-param name="name">prod_stat_code</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N005', prod_stat_code)"/></xsl:with-param>
			</xsl:call-template>
		
			<!-- loan amount -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_RISK_TYPE</xsl:with-param>
				<xsl:with-param name="name">risk_type</xsl:with-param>
			</xsl:call-template>
		   	
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_FACILITYDETAILS_DEAL</xsl:with-param>
				<xsl:with-param name="name">bo_deal_name</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_FACILITYDETAILS_FACILITY</xsl:with-param>
				<xsl:with-param name="name">bo_facility_name</xsl:with-param>
			</xsl:call-template>						
			
			<xsl:call-template name="borrower-details" />
			<xsl:call-template name="issuing-bank-details" />
						
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>


<!-- facility details -->
<xsl:template name="facility-details">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_FACILITY_DETAILS</xsl:with-param>
		<xsl:with-param name="legend-type">indented-header</xsl:with-param>
		<xsl:with-param name="content">

			<!-- deal -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_FACILITYDETAILS_DEAL</xsl:with-param>
				<xsl:with-param name="name">bo_deal_name</xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
				
			<!-- facility -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_FACILITYDETAILS_FACILITY</xsl:with-param>
				<xsl:with-param name="name">bo_facility_name</xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>

			<!-- facility fcn -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_FACILITYDETAILS_ID</xsl:with-param>
				<xsl:with-param name="name">fcn</xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
			
			<!-- facility issue (effective) date -->
   			<xsl:call-template name="input-field">
   				<xsl:with-param name="type">date</xsl:with-param>
     			<xsl:with-param name="label">XSL_LOAN_EFFECTIVE_DATE</xsl:with-param>
   	 			<xsl:with-param name="name">facility_effective_date</xsl:with-param>
   				<xsl:with-param name="override-displaymode">view</xsl:with-param>
    		</xsl:call-template>
    		
   			<!-- facility expiry date -->
   			<xsl:call-template name="input-field">
   				<xsl:with-param name="type">date</xsl:with-param>
     			<xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
   	 			<xsl:with-param name="name">facility_expiry_date</xsl:with-param>
   				<xsl:with-param name="override-displaymode">view</xsl:with-param>
    		</xsl:call-template>
   		
   			<!-- borrower limit amount -->
			<xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_FACILITY_BORROWER_LIMIT</xsl:with-param>
				<xsl:with-param name="product-code">borrower_limit</xsl:with-param>
				<xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
				<xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
			</xsl:call-template>

	   		<!-- borrower available to draw -->
			<xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_FACILITY_BORROWER_AVAILABLE</xsl:with-param>
				<xsl:with-param name="product-code">borrower_available</xsl:with-param>
				<xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
				<xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
			</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>


<!-- borrower -->
<xsl:template name="borrower-details">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_BORROWER_DETAILS</xsl:with-param>
		<xsl:with-param name="legend-type">indented-header</xsl:with-param>
		<xsl:with-param name="content">
			<xsl:call-template name="address">
		        <xsl:with-param name="show-entity">Y</xsl:with-param>
				<xsl:with-param name="prefix">borrower</xsl:with-param>
			</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>


<!-- issuing bank -->
<xsl:template name="issuing-bank-details">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_LOAN_ISSUING_BANK</xsl:with-param>
		<xsl:with-param name="legend-type">indented-header</xsl:with-param>
		<xsl:with-param name="content">
			<xsl:call-template name="issuing-bank-tabcontent">
   				<xsl:with-param name="main-bank-name">issuing_bank</xsl:with-param>
   				<xsl:with-param name="sender-name">borrower</xsl:with-param>
   				<xsl:with-param name="sender-reference-name">borrower_reference</xsl:with-param>
   			</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>


<!-- loan details -->
<xsl:template name="loan-details">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_LOAN_DETAILS</xsl:with-param>
		<xsl:with-param name="content">
			
			<!-- loan amount -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">PROPERTY_NAME</xsl:with-param>
				<xsl:with-param name="name">property_name</xsl:with-param>
			</xsl:call-template>
			
			<!-- reporting_method -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_REPORTING_METHOD</xsl:with-param>
				<xsl:with-param name="name">reporting_method</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N720', reporting_method)" /></xsl:with-param>
		    	<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
			
		    <!-- application date -->
    		<xsl:call-template name="input-field">
    			<xsl:with-param name="type">date</xsl:with-param>
    			<xsl:with-param name="name">appl_date</xsl:with-param>
     			<xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
     			<xsl:with-param name="value" select="appl_date" />
     			<xsl:with-param name="override-displaymode">view</xsl:with-param>
    		</xsl:call-template>

		    <!-- issue (effective) date -->
    		<xsl:call-template name="input-field">
    			<xsl:with-param name="type">date</xsl:with-param>
    			<xsl:with-param name="name">effective_date</xsl:with-param>
     			<xsl:with-param name="label">XSL_LOAN_EFFECTIVE_DATE</xsl:with-param>
     			<xsl:with-param name="fieldsize">small</xsl:with-param>
     			<xsl:with-param name="size">10</xsl:with-param>
     			<xsl:with-param name="maxsize">10</xsl:with-param>
     			<xsl:with-param name="required">Y</xsl:with-param>
    		</xsl:call-template>
    		
    		<!-- loan maturity date -->
    		<xsl:call-template name="input-field">
    			<xsl:with-param name="type">date</xsl:with-param>
    			<xsl:with-param name="name">lockout_date</xsl:with-param>
     			<xsl:with-param name="label">XSL_LOAN_LOCKOUT_DATE</xsl:with-param>
     			<xsl:with-param name="fieldsize">small</xsl:with-param>
     			<xsl:with-param name="maxsize">10</xsl:with-param>
     			<xsl:with-param name="required">Y</xsl:with-param>
    		</xsl:call-template>

		
			<xsl:call-template name="input-field">
		   		<xsl:with-param name="label">XSL_EOC_DDLPI</xsl:with-param>
		  		<xsl:with-param name="name">eoc_ddlpi</xsl:with-param>
		   	</xsl:call-template>
		
			<xsl:call-template name="input-field">
		   		<xsl:with-param name="label">XSL_EOM_DDLPI</xsl:with-param>
		  		<xsl:with-param name="name">eom_ddlpi</xsl:with-param>
		   	</xsl:call-template>

			<!-- calculation method -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_LOAN_CALC_METHOD</xsl:with-param>
				<xsl:with-param name="name">calculation_method</xsl:with-param>
			</xsl:call-template>			

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
				<xsl:with-param name="value">01</xsl:with-param>
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
