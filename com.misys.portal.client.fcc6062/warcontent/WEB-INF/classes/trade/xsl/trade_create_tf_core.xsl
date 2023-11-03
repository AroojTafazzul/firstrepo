<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
        xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
        xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
        exclude-result-prefixes="xmlRender">

  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">TF</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/FinancingRequestScreen</xsl:param>
  <xsl:param name="option" />
  <xsl:param name="modulename" />
  <xsl:param name="relatedref" />
  <!-- Global Imports. -->
  <xsl:include href="../../core/xsl/common/ls_common.xsl" />
  <xsl:include href="../../core/xsl/common/trade_common.xsl" />
  <xsl:include href="../../core/xsl/common/tf_common.xsl" />
  <xsl:include href="../../core/xsl/common/fx_common.xsl" />
  <xsl:include href="../../core/xsl/common/e2ee_common.xsl"/>
  <xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="tf_tnx_record"/>
  </xsl:template>
  
  <!-- 
   TF TNX FORM TEMPLATE.
  -->
  <xsl:template match="tf_tnx_record">
   <!-- Preloader  -->
   <xsl:call-template name="loading-message"/>
  
   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>

    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
      <!--  Display common menu. -->
      <xsl:call-template name="menu">
       <xsl:with-param name="show-template">N</xsl:with-param>
        <xsl:with-param name="show-return">Y</xsl:with-param>
      </xsl:call-template>
      
      <!-- Reauthentication -->
      <xsl:call-template name="server-message">
 		<xsl:with-param name="name">server_message</xsl:with-param>
 		<xsl:with-param name="content"><xsl:value-of select="message"/></xsl:with-param>
 		<xsl:with-param name="appendClass">serverMessage</xsl:with-param>
	  </xsl:call-template>
	  <xsl:call-template name="reauthentication" />
      
      <!-- Disclaimer Notice -->
      <xsl:call-template name="disclaimer"/>
     
      <xsl:apply-templates select="cross_references" mode="hidden_form"/>
      <xsl:call-template name="hidden-fields"/>
      <xsl:call-template name="general-details"/>

      <xsl:call-template name="tf_basic-amt-details">
       <xsl:with-param name="label">XSL_AMOUNTDETAILS_FIN_AMT_LABEL</xsl:with-param>
       <xsl:with-param name="override-product-code">fin</xsl:with-param>
      </xsl:call-template>
      
      <xsl:call-template name="additional-details"/>

		   <xsl:if test="$displaymode='edit' and (option[.='FROM_IMPORT_SCRATCH'] or option[.='FROM_IMPORT_LC'] or option[.='FROM_IMPORT_COLLECTION'] or option[.='FROM_EXPORT_LC'] or option[.='FROM_EXPORT_COLLECTION'] or option[.='IMPORT_DRAFT'] or option[.='EXPORT_DRAFT'] or option[.='FROM_EXPORT_SCRATCH'])
		  			and (banks_fx_rates/fx_bank_params and banks_fx_rates/fx_bank_params/fx_product/fx_assign_products[.='Y'])"> 
	      		<xsl:call-template name="fx-template"/>
	       </xsl:if>  
      
	      <xsl:if test="$displaymode='view' and fx_rates_type and fx_rates_type[.!='']">
	        	<xsl:call-template name="fx-details-for-view" /> 
	      </xsl:if>
	      
	      <xsl:if test="(securitycheck:hasPermission($rundata,'ls_access') and defaultresource:getResource('SHOW_LICENSE_SECTION_FOR_TRADE_PRODUCTS') = 'true')">
   	  <xsl:call-template name="linked-ls-declaration"/>
	  <xsl:call-template name="linked-licenses"/>
   </xsl:if>

	      <xsl:call-template name="bank-instructions">
		       <xsl:with-param name="send-mode-displayed">N</xsl:with-param>
		       <xsl:with-param name="principal-acct-dr-cr">cr</xsl:with-param>
			   <xsl:with-param name="internal-external-accts">internal</xsl:with-param>
	      </xsl:call-template>
      <!-- comments for return -->
      <xsl:if test="tnx_stat_code[.!='03' and .!='04']">   <!-- MPS-43899 -->
      <xsl:call-template name="comments-for-return">
	  		<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
	   		<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
   	  </xsl:call-template>
   	  </xsl:if>

     </xsl:with-param>
    </xsl:call-template>

    <!-- Form #1 : Attach Files -->
    <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED') or ($displaymode != 'edit' and $mode = 'VIEW')">
    	<xsl:call-template name="attachments-file-dojo"/>
    </xsl:if>

    <xsl:call-template name="realform"/>

    <xsl:call-template name="menu">
     <xsl:with-param name="show-template">N</xsl:with-param>
     <xsl:with-param name="second-menu">Y</xsl:with-param>
      <!-- <xsl:with-param name="show-reject">Y</xsl:with-param> -->
      <xsl:with-param name="show-return">Y</xsl:with-param>
    </xsl:call-template>
   </div>
    
   <!-- Table of Contents -->
   <xsl:call-template name="toc"/>
   
   <!--  Collaboration Window -->     
   <xsl:call-template name="collaboration">
    <xsl:with-param name="editable">true</xsl:with-param>
    <xsl:with-param name="productCode"><xsl:value-of select="$product-code"/></xsl:with-param>
    <xsl:with-param name="contextPath"><xsl:value-of select="$contextPath"/></xsl:with-param>
    <xsl:with-param name="bank_name_widget_id">issuing_bank_name</xsl:with-param>
	<xsl:with-param name="bank_abbv_name_widget_id">issuing_bank_abbv_name</xsl:with-param>
   </xsl:call-template>
 
   <!-- Javascript imports  -->
   <xsl:call-template name="js-imports"/>
  </xsl:template>

<!--                                     -->  
<!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
<!--                                     -->

<!-- Additional JS imports for this form are -->
 <!-- added here. -->
 <xsl:template name="js-imports">
  <xsl:call-template name="common-js-imports">
   <xsl:with-param name="binding">misys.binding.trade.create_tf</xsl:with-param>
   <!-- <xsl:with-param name="override-help-access-key">TF_01</xsl:with-param> -->
   <xsl:with-param name="override-help-access-key">
   <xsl:choose>
	   	<xsl:when test="$option ='FROM_IMPORT_LC' or $option ='FROM_IMPORT_COLLECTION' or $option ='IMPORT_DRAFT' or $option ='IMPORT_UNSIGNED'">TF_IMP</xsl:when>
	   	<xsl:when test="$option ='FROM_EXPORT_LC' or $option ='FROM_EXPORT_COLLECTION' or $option ='EXPORT_DRAFT' or $option ='EXPORT_UNSIGNED'">TF_EXP</xsl:when>
	   	<xsl:otherwise>TF_01</xsl:otherwise>
	   </xsl:choose>
	  </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- Additional hidden fields for this form are  -->
 <!-- added here. -->
 <xsl:template name="hidden-fields">
  <xsl:call-template name="common-hidden-fields">
    <xsl:with-param name="show-type">N</xsl:with-param>
  </xsl:call-template>
 </xsl:template>

  <!--
    TF General Details Fieldset.
  -->
  <xsl:template name="general-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
    <xsl:with-param name="content">

     <!-- Common general details. -->
     <xsl:call-template name="common-general-details">
      <xsl:with-param name="show-template-id">N</xsl:with-param>
     </xsl:call-template>
    <!--  20170811_01 starts -->
	<xsl:if test="security:isCustomer($rundata) and tnx_amt[.!=''] and $displaymode='view' and (sub_tnx_type_code[.='38'] or sub_tnx_type_code[.='39'] )">         	
        	<xsl:call-template name="row-wrapper">
	        	<xsl:with-param name="label">XSL_REPAYMENT_AMOUNT</xsl:with-param>
	        	<xsl:with-param name="content"><div class="content">
	         	<xsl:value-of select="tnx_cur_code"/>&nbsp;<xsl:value-of select="tnx_amt"/> 
	         	</div></xsl:with-param>   
	         	</xsl:call-template>    
	         	
         	</xsl:if> 
        <!-- 20170811_01 ends  -->
     <!-- TF Details. -->
     <xsl:call-template name="tf-details"/>
      
     <!-- Applicant Details -->
      <xsl:call-template name="fieldset-wrapper">
      <xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:if test="$displaymode='edit'">
        <script>
        dojo.ready(function(){
        	misys._config = misys._config || {};
			misys._config.customerReferences = {};
			<xsl:apply-templates select="avail_main_banks/bank" mode="customer_references"/>
		});
		</script>
       </xsl:if>
      
       <xsl:call-template name="address">
        <xsl:with-param name="show-entity">Y</xsl:with-param>
        <xsl:with-param name="prefix">applicant</xsl:with-param>
       </xsl:call-template>
        
       <!--
        If we have to, we show the reference field for applicants. This is
        specific to this form.
        -->
        <!-- commented as part of MPS-39538  -->
      <!--  <xsl:if test="not($displaymode='view' and $mode='UNSIGNED') and not(avail_main_banks/bank/entity/customer_reference) and not(avail_main_banks/bank/customer_reference)">
        <xsl:call-template name="input-field">
         <xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
         <xsl:with-param name="name">applicant_reference</xsl:with-param>
         <xsl:with-param name="maxsize"><xsl:value-of select="defaultresource:getResource('APPLICANT_REFERENCE_LENGTH')"/></xsl:with-param>
        </xsl:call-template>
       </xsl:if> -->
      </xsl:with-param>
     </xsl:call-template>
     
     <xsl:call-template name="fieldset-wrapper">
      <xsl:with-param name="legend">XSL_BANKDETAILS_TAB_FINANCING_BANK</xsl:with-param>
      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
      <xsl:with-param name="content">
       <!-- Bank Name -->
       <xsl:if test="$displaymode='edit'">
        <script type="text/javascript">
        dojo.ready(function(){
 			 var customerReferences = new Array();
 			 <xsl:apply-templates select="avail_main_banks/bank" mode="customer_references"/>
		});
       </script>
       </xsl:if>
       <xsl:call-template name="main-bank-selectbox">
        <xsl:with-param name="label">XSL_BANK_NAME</xsl:with-param>
        <xsl:with-param name="main-bank-name">issuing_bank</xsl:with-param>
        <xsl:with-param name="sender-name">applicant</xsl:with-param>
        <xsl:with-param name="sender-reference-name">applicant_reference</xsl:with-param>
       </xsl:call-template>
       <xsl:call-template name="customer-reference-selectbox">
        <xsl:with-param name="main-bank-name">issuing_bank</xsl:with-param>
        <xsl:with-param name="sender-name">applicant</xsl:with-param>
        <xsl:with-param name="sender-reference-name">applicant_reference</xsl:with-param>
        <xsl:with-param name="required">N</xsl:with-param>
       </xsl:call-template>
      </xsl:with-param>
     </xsl:call-template>
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template> 
  
  <!-- TF General Details -->
  <xsl:template name="tf-details">
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_REQUESTED_ISSUE_DATE</xsl:with-param>
    <xsl:with-param name="name">iss_date</xsl:with-param>
    <xsl:with-param name="size">10</xsl:with-param>
    <xsl:with-param name="maxsize">10</xsl:with-param>
    <xsl:with-param name="required">Y</xsl:with-param>
    <xsl:with-param name="type">date</xsl:with-param>
    <xsl:with-param name="fieldsize">small</xsl:with-param>
   </xsl:call-template>
   <!-- 20170811_01 starts -->   
   	<xsl:if test="security:isBank($rundata) and tnx_amt[.!=''] and $displaymode='view'and (sub_tnx_type_code[.='38'] or sub_tnx_type_code[.='39'] )">         	
        	<xsl:call-template name="row-wrapper">
	        	<xsl:with-param name="label">XSL_REPAYMENT_AMOUNT</xsl:with-param>
	        	<xsl:with-param name="content"><div class="content">
	         	<xsl:value-of select="tnx_cur_code"/>&nbsp;<xsl:value-of select="tnx_amt"/> 
	         	</div></xsl:with-param>   
	         	</xsl:call-template>    
	</xsl:if>
     <!-- 20170811_01 ends  -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_TENOR_DAYS</xsl:with-param>
    <xsl:with-param name="name">tenor</xsl:with-param>
    <xsl:with-param name="type">number</xsl:with-param>
    <xsl:with-param name="size">3</xsl:with-param>
    <xsl:with-param name="maxsize">3</xsl:with-param>
    <xsl:with-param name="fieldsize">x-small</xsl:with-param>
    <xsl:with-param name="override-constraints">{min:0,pattern: '###'}</xsl:with-param>
    <xsl:with-param name="required">Y</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_MATURITY_DATE</xsl:with-param>
    <xsl:with-param name="name">maturity_date</xsl:with-param>
    <xsl:with-param name="size">10</xsl:with-param>
    <xsl:with-param name="maxsize">10</xsl:with-param>
    <xsl:with-param name="required">Y</xsl:with-param>
    <xsl:with-param name="type">date</xsl:with-param>
    <xsl:with-param name="fieldsize">small</xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="input-field">
    <xsl:with-param name="name">disclaimer</xsl:with-param>
    <xsl:with-param name="type">date</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_MATURITY_DISCLAIMER')"></xsl:value-of></xsl:with-param>
    <xsl:with-param name="override-displaymode">view</xsl:with-param>
   </xsl:call-template> 
   <!--20170728_01 starts added for Bank reference to be displayed in review pop and sync with pdf  -->
   	<xsl:if test="cross_references/cross_reference/type_code[.='02'] and $displaymode='view' ">
						<xsl:variable name="parent_file" select="xmlRender:getXMLMasterNode(cross_references/cross_reference[./type_code='02']/product_code, cross_references/cross_reference[./type_code='02']/ref_id, $language)"/>
						<xsl:call-template name="row-wrapper">
				       <xsl:with-param name="label">XSL_GENERALDETAILS_BO_LC_REF_ID</xsl:with-param>
				       <xsl:with-param name="content"><div class="content">
				        <xsl:value-of select="$parent_file/bo_ref_id"/>
				      	 </div></xsl:with-param>
				      </xsl:call-template>
	</xsl:if>
	<!-- 20170728_01 ends -->			  
   <xsl:call-template name="select-field">
    <xsl:with-param name="label">XSL_FINANCINGTYPE_LABEL</xsl:with-param>
    <xsl:with-param name="name">sub_product_code</xsl:with-param>
    <xsl:with-param name="required">Y</xsl:with-param>
    <xsl:with-param name="readonly">Y</xsl:with-param>
    <xsl:with-param name="options">
     <xsl:choose>
	      	<xsl:when test="option[.='FROM_GENERAL_SCRATCH'] or option[.='GENERAL_DRAFT']">
	        <xsl:call-template name="tf-general-financing-types"/>
	        </xsl:when>
	      	<xsl:when test="option[.='FROM_IMPORT_SCRATCH']">
	        <xsl:call-template name="tf-import-financing-types"/>
	        </xsl:when>
	        <xsl:when test="option[.='FROM_EXPORT_SCRATCH']">
	        <xsl:call-template name="tf-export-financing-types"/>
	        </xsl:when>
	        <xsl:when test="option[.='FROM_IMPORT_LC']">
	        <xsl:call-template name="tf-import-LC-financing-types"/>
	        </xsl:when>
	        <xsl:when test="option[.='FROM_IMPORT_COLLECTION']">
	        <xsl:call-template name="tf-import-IC-financing-types"/>
	        </xsl:when>
	        <xsl:when test="option[.='FROM_EXPORT_LC']">
	        <xsl:call-template name="tf-export-LC-financing-types"/>
	        </xsl:when>
	        <xsl:when test="option[.='FROM_EXPORT_COLLECTION']">
	        <xsl:call-template name="tf-export-Collection-financing-types"/>
	        </xsl:when>
	        <xsl:otherwise>
	         <xsl:call-template name="tf-all-financing-types"/>
	        </xsl:otherwise>
	       </xsl:choose>
    </xsl:with-param>
   </xsl:call-template> 
   <xsl:if test="sub_product_code[.='IOTHF'] or sub_product_code[.='EOTHF']">            
    <xsl:call-template name="input-field">
	    <xsl:with-param name="label"></xsl:with-param>
	    <xsl:with-param name="name">sub_product_code_text</xsl:with-param>
	    <xsl:with-param name="type">text</xsl:with-param>
	    <xsl:with-param name="size">35</xsl:with-param>
	    <xsl:with-param name="maxsize">35</xsl:with-param>
	    <xsl:with-param name="fieldsize">medium</xsl:with-param>
	    <xsl:with-param name="required">Y</xsl:with-param>	    
   </xsl:call-template> 
   </xsl:if> 
    <!-- Client Related Reference -->
  <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_RELATED_REFERENCE</xsl:with-param>
    <xsl:with-param name="name">related_reference</xsl:with-param>
    <xsl:with-param name="type">text</xsl:with-param>
    <xsl:with-param name="size">16</xsl:with-param>
    <xsl:with-param name="maxsize">16</xsl:with-param>
    <xsl:with-param name="fieldsize">medium</xsl:with-param>
    <xsl:with-param name="required">N</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="related_reference"/></xsl:with-param>
    <xsl:with-param name="readonly">
    <xsl:choose>
		    <xsl:when test="related_reference[.!='']">Y</xsl:when>
		    <xsl:otherwise>N</xsl:otherwise>
	    </xsl:choose>
	</xsl:with-param>
   </xsl:call-template>
   <!-- Client Bill Amount -->
   
   <xsl:variable name="lower">abcdefghijklmnopqrstuvwxyz</xsl:variable>
   <xsl:variable name="upper">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>
				
   <xsl:variable name="parent_product"><xsl:value-of select="cross_references/cross_reference/product_code"/></xsl:variable>
   <xsl:variable name="parent_liab_amt">
   	<xsl:choose>
		<xsl:when test="$parent_product ='EL' or $parent_product ='SI' or $parent_product ='SR'">lc_liab_amt</xsl:when>
		<xsl:when test="$parent_product ='TF'">fin_liab_amt</xsl:when>
		<xsl:when test="$parent_product ='BR'">bg_liab_amt</xsl:when>
		<xsl:otherwise><xsl:value-of select="translate($parent_product, $upper, $lower)"/>_liab_amt</xsl:otherwise>
	</xsl:choose>
   </xsl:variable>
   <xsl:variable name="parent_cur_code">
   	<xsl:choose>
		<xsl:when test="$parent_product ='EL' or $parent_product ='SI' or $parent_product ='SR'">lc_cur_code</xsl:when>
		<xsl:when test="$parent_product ='TF'">fin_cur_code</xsl:when>
		<xsl:when test="$parent_product ='BR'">bg_cur_code</xsl:when>
		<xsl:otherwise><xsl:value-of select="translate($parent_product, $upper, $lower)"/>_cur_code</xsl:otherwise>
	</xsl:choose>
   </xsl:variable>
   
   <xsl:variable name="parent_liab_amt_value" select="//*[name()=$parent_liab_amt]"></xsl:variable>
   <xsl:variable name="parent_liab_cur_code_value" select="//*[name()=$parent_cur_code]"></xsl:variable>
   
  <xsl:if test="bill_amt[.!=''] or $parent_liab_cur_code_value[.!='']">
   <div id="bill_amount_div">
   
  <xsl:call-template name="currency-field">
    <xsl:with-param name="label">XSL_BILL_AMOUNT</xsl:with-param>
    <xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
	<xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
	<xsl:with-param name="override-amt-name">bill_amt</xsl:with-param>
	<xsl:with-param name="override-amt-value">
		<xsl:choose>
		    <xsl:when test="bill_amt[.!='']">
		    	<xsl:value-of select="bill_amt"/>
		    </xsl:when>
		    <xsl:otherwise>
		    	<xsl:value-of select="$parent_liab_amt_value"/>
		    </xsl:otherwise>
	    </xsl:choose>
	</xsl:with-param>
	<xsl:with-param name="override-currency-name">bill_amt_cur_code</xsl:with-param>
	<xsl:with-param name="override-currency-value">
		<xsl:choose>
		    <xsl:when test="bill_amt_cur_code[.!='']">
		    	<xsl:value-of select="bill_amt_cur_code"/>
		    </xsl:when>
		    <xsl:otherwise>
		    	<xsl:value-of select="$parent_liab_cur_code_value"/>
		    </xsl:otherwise>
		  </xsl:choose>
	 </xsl:with-param>
    <xsl:with-param name="show-button">N</xsl:with-param>
  </xsl:call-template>
  </div>
 </xsl:if>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">fin_liab_amt</xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="fin_liab_amt"/></xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">ibReference</xsl:with-param>
       <xsl:with-param name="value" select="ibReference"/>
   </xsl:call-template>
  
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">bill_amt_cur_code</xsl:with-param>
    <xsl:with-param name="value">
    	 <xsl:choose>
		    <xsl:when test="bill_amt_cur_code and bill_amt_cur_code[.!='']">
		    	<xsl:value-of select="bill_amt_cur_code"/>
		    </xsl:when>
		    <xsl:otherwise>
		    	<xsl:value-of select="$parent_liab_cur_code_value"/>
		    </xsl:otherwise>
		  </xsl:choose>
    </xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name">bill_amt</xsl:with-param>
    <xsl:with-param name="value">
    	<xsl:choose>
		    <xsl:when test="bill_amt and bill_amt[.!='']">
		    	<xsl:value-of select="bill_amt"/>
		    </xsl:when>
		    <xsl:otherwise>
		    	<xsl:value-of select="$parent_liab_amt_value"/>
		    </xsl:otherwise>
	    </xsl:choose>
    </xsl:with-param>
   </xsl:call-template>
   
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">menu_from</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="option"></xsl:value-of></xsl:with-param>
     </xsl:call-template>
     <xsl:if test="$displaymode='edit' and banks_fx_rates/fx_bank_params and banks_fx_rates/fx_bank_params/fx_product/fx_assign_products[.='Y']">
	     <xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">fx_rates_type_temp</xsl:with-param>
	      <xsl:with-param name="value"><xsl:value-of select="fx_rates_type"></xsl:value-of></xsl:with-param>
	     </xsl:call-template>
	     <xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">fx_master_currency</xsl:with-param>
	      <xsl:with-param name="value"><xsl:value-of select="fx_contract_nbr_cur_code_1"></xsl:value-of></xsl:with-param>
	     </xsl:call-template>
     </xsl:if>
    <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">product_code</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="$product-code"></xsl:value-of></xsl:with-param>
     </xsl:call-template>
   <!-- Client Description of Goods -->
    <xsl:choose>
	   	<xsl:when test="$displaymode='edit'">
		    <xsl:call-template name="row-wrapper">
		     <xsl:with-param name="id">description_of_goods</xsl:with-param>
		     <xsl:with-param name="label">XSL_DESCRIPTION_OF_GOODS</xsl:with-param>
		     <xsl:with-param name="type">textarea</xsl:with-param>
		     <xsl:with-param name="content">
		     <xsl:call-template name="textarea-field">
		     <xsl:with-param name="name">description_of_goods</xsl:with-param>
		     <xsl:with-param name="rows">3</xsl:with-param>
		     <xsl:with-param name="cols">35</xsl:with-param>
		     <xsl:with-param name="maxlines">3</xsl:with-param>
		     </xsl:call-template>
		     </xsl:with-param>
		    </xsl:call-template>
	    </xsl:when>
	    <xsl:when test="$displaymode='view' and description_of_goods[.!='']">
	    	<xsl:call-template name="big-textarea-wrapper">
		      <xsl:with-param name="label">XSL_DESCRIPTION_OF_GOODS</xsl:with-param>
		      <xsl:with-param name="content"><div class="content">
		        <xsl:value-of select="description_of_goods"/>
		      </div></xsl:with-param>
		     </xsl:call-template>
	    </xsl:when>
    </xsl:choose>
  </xsl:template>
  
  <!--
   Additional Details
   -->
  <xsl:template name="additional-details">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_ADDITIONAL_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <xsl:call-template name="row-wrapper">
      <xsl:with-param name="id">goods_desc</xsl:with-param>
      <xsl:with-param name="type">textarea</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:call-template name="textarea-field">
        <xsl:with-param name="name">goods_desc</xsl:with-param>
        <xsl:with-param name="rows">12</xsl:with-param>
        <xsl:with-param name="required">N</xsl:with-param>
       </xsl:call-template>
      </xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>

  <!--
   Hidden fields for Request for Financing
   -->
  <xsl:template name="realform">
   <xsl:call-template name="form-wrapper">
    <xsl:with-param name="name">realform</xsl:with-param>
    <xsl:with-param name="method">POST</xsl:with-param>
    <xsl:with-param name="action" select="$realform-action"/>
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
      <xsl:with-param name="value" select="$mode"/>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">tnxtype</xsl:with-param>
      <xsl:with-param name="value">01</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">attIds</xsl:with-param>
      <xsl:with-param name="value"/>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">TransactionData</xsl:with-param>
      <xsl:with-param name="value"/>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">modulename</xsl:with-param>
       <xsl:with-param name="value" select="option"/>
      </xsl:call-template>
     <xsl:if test="$displaymode='edit' and banks_fx_rates/fx_bank_params and banks_fx_rates/fx_bank_params/fx_product/fx_assign_products[.='Y']">
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">fxinteresttoken</xsl:with-param>
     </xsl:call-template>
     </xsl:if>
     <xsl:call-template name="e2ee_transaction"/>
     <xsl:call-template name="reauth_params"/> 
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <!--
   Basic Amount Details fieldset, containing just currency and amount fields. 
   -->
  <xsl:template name="tf_basic-amt-details">
   <xsl:param name="override-product-code" select="$lowercase-product-code"/>
   <xsl:param name="label">XSL_AMOUNTDETAILS_LC_AMT_LABEL</xsl:param>
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
    <xsl:choose>
    <xsl:when test="$displaymode='edit'">
    	<xsl:choose>
	    <xsl:when test="option[.='FROM_EXPORT_LC'] or option[.='FROM_EXPORT_COLLECTION'] or (option[.='EXPORT_DRAFT'] and fin_amt[.!=''])">
	     <xsl:call-template name="currency-field">
	      <xsl:with-param name="label" select="$label"/>
	      <xsl:with-param name="product-code"><xsl:value-of select="$override-product-code"/></xsl:with-param>
	      <xsl:with-param name="required">Y</xsl:with-param>
	      <xsl:with-param name="show-button">N</xsl:with-param>
	     </xsl:call-template>
	     </xsl:when>	
	     <xsl:otherwise>	     
	       <xsl:call-template name="currency-field">
	      <xsl:with-param name="label" select="$label"/>
	      <xsl:with-param name="product-code"><xsl:value-of select="$override-product-code"/></xsl:with-param>
	      <xsl:with-param name="required">Y</xsl:with-param>
	     </xsl:call-template>	     
	     </xsl:otherwise>
	     </xsl:choose>
     </xsl:when>
     
     </xsl:choose>
     <!-- Displayed in details summary view -->
     <xsl:if test="$displaymode='view'">
      <xsl:variable name="field-name"><xsl:value-of select="$override-product-code"/>_amt</xsl:variable>
      <xsl:call-template name="input-field">
       <xsl:with-param name="label" select="$label"/>
       <xsl:with-param name="name"><xsl:value-of select="$override-product-code"/>_amt</xsl:with-param>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
       <xsl:with-param name="value">
         <xsl:variable name="field-value"><xsl:value-of select="//*[name()=$field-name]"/></xsl:variable>
         <xsl:variable name="curcode-field-name"><xsl:value-of select="$override-product-code"/>_cur_code</xsl:variable>
         <xsl:variable name="curcode-field-value"><xsl:value-of select="//*[name()=$curcode-field-name]"/></xsl:variable>
	     <xsl:if test="$field-value !=''">
	      <xsl:value-of select="$curcode-field-value"></xsl:value-of>&nbsp;<xsl:value-of select="$field-value"></xsl:value-of>
	     </xsl:if>
	   </xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">fin_amt</xsl:with-param>
	       <xsl:with-param name="value" select="fin_amt"/>
	  </xsl:call-template>
      <xsl:call-template name="hidden-field">
	      <xsl:with-param name="name">fin_cur_code</xsl:with-param>
	      <xsl:with-param name="value" select="fin_cur_code"/>
	  </xsl:call-template>
     </xsl:if>
     <!-- MPS-41651  Outstanding amount -->
     <xsl:if test="$displaymode='view'">
      <xsl:variable name="field-name"><xsl:value-of select="$override-product-code"/>_outstanding_amt</xsl:variable>
      <xsl:call-template name="input-field">
 	 <xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
       <xsl:with-param name="name"><xsl:value-of select="$override-product-code"/>_outstanding_amt</xsl:with-param>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
       <xsl:with-param name="value">
         <xsl:variable name="field-value"><xsl:value-of select="//*[name()=$field-name]"/></xsl:variable>
         <xsl:variable name="curcode-field-name"><xsl:value-of select="$override-product-code"/>_cur_code</xsl:variable>
         <xsl:variable name="curcode-field-value"><xsl:value-of select="//*[name()=$curcode-field-name]"/></xsl:variable>
	     <xsl:if test="$field-value !=''">
	      <xsl:value-of select="$curcode-field-value"></xsl:value-of>&nbsp;<xsl:value-of select="$field-value"></xsl:value-of>
	     </xsl:if>
	   </xsl:with-param>
      </xsl:call-template>
     </xsl:if>
          <!-- MPS-41651 Total Liability amount -->
     <xsl:if test="$displaymode='view'  and security:isBank($rundata)">
      <xsl:variable name="field-name"><xsl:value-of select="$override-product-code"/>_liab_amt</xsl:variable>
      <xsl:call-template name="input-field">
 	 <xsl:with-param name="label">XSL_AMOUNTDETAILS_LIABILITY_AMT_LABEL</xsl:with-param>
       <xsl:with-param name="name"><xsl:value-of select="$override-product-code"/>_liab_amt</xsl:with-param>
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
       <xsl:with-param name="value">
         <xsl:variable name="field-value"><xsl:value-of select="//*[name()=$field-name]"/></xsl:variable>
         <xsl:variable name="curcode-field-name"><xsl:value-of select="$override-product-code"/>_cur_code</xsl:variable>
         <xsl:variable name="curcode-field-value"><xsl:value-of select="//*[name()=$curcode-field-name]"/></xsl:variable>
	     <xsl:if test="$field-value !=''">
	      <xsl:value-of select="$curcode-field-value"></xsl:value-of>&nbsp;<xsl:value-of select="$field-value"></xsl:value-of>
	     </xsl:if>
	   </xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     
         <xsl:call-template name="input-field">
	     <xsl:with-param name="label">XSL_GENERALDETAILS_IN_INVOICE_ELIGIBLE_PCT</xsl:with-param>
	     <xsl:with-param name="name">req_pct</xsl:with-param>
	     <xsl:with-param name="size">3</xsl:with-param>
	     <xsl:with-param name="maxsize">5</xsl:with-param>
	     <xsl:with-param name="fieldsize">x-small</xsl:with-param>
	     <xsl:with-param name="type">percentnumber</xsl:with-param>
	     </xsl:call-template>
	  
	<xsl:call-template name="currency-field">
      	<xsl:with-param name="label">XSL_GENERALDETAILS_IN_INVOICE_ELIGIBLE_AMT</xsl:with-param>
      	<xsl:with-param name="product-code">req</xsl:with-param>
      	<xsl:with-param name="override-currency-value">
   			<xsl:value-of select="fin_cur_code"/>
		</xsl:with-param>
		<xsl:with-param name="currency-readonly">Y</xsl:with-param>
		<xsl:with-param name="amt-readonly">Y</xsl:with-param>
		<xsl:with-param name="show-button">N</xsl:with-param>
    </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>