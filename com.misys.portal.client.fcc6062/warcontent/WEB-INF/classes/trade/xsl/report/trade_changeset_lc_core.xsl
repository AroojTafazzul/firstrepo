<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 Import Letter of Credit (LC) Form, Customer Side.
 
 Note: Templates beginning with lc_ are in lc_common.xsl

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

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
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	xmlns:common="http://exslt.org/common"
	exclude-result-prefixes="localization utils common">
  
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">LC</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/LetterOfCreditScreen</xsl:param>
  <xsl:param name="featureid"></xsl:param>
  <!-- Local variables. -->
  <xsl:param name="show-eucp">N</xsl:param>
 
  <!-- Global Imports. -->
  <xsl:include href="../../../core/xsl/common/trade_common.xsl" />
  <xsl:include href="../../../core/xsl/common/lc_common.xsl" />
  <xsl:include href="../../../core/xsl/common/static_document_upload_templates.xsl" />
  <xsl:include href="../../../core/xsl/system/sy_reauthenticationdialog.xsl" />
  <xsl:include href="../../../trade/xsl/report/lc_changeset_common.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="lc_tnx_record"/>
  </xsl:template>
  
  <!-- 
   LC TNX FORM TEMPLATE.
  -->
  <xsl:template match="lc_tnx_record">
   <!-- Preloader  -->
   <xsl:call-template name="loading-message"/>
  
   <xsl:call-template name="static-document-dialog"/>
   <div>
    <xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>

    <!-- Form #0 : Main Form -->    
    <xsl:call-template name="form-wrapper">
     <xsl:with-param name="name" select="$main-form-name"/>
     <xsl:with-param name="validating">Y</xsl:with-param>
     <xsl:with-param name="content">
      <!--  Display common menu.  -->
      <xsl:call-template name="menu" >
      <xsl:with-param name="show-return">Y</xsl:with-param>
      </xsl:call-template>
      
      <!-- Disclaimer Notice -->
      <xsl:call-template name="disclaimer"/>

      <xsl:apply-templates select="cross_references" mode="hidden_form"/>
      <xsl:call-template name="general-details" />
      <xsl:call-template name="applicant-details"/>
      <xsl:call-template name="beneficiary-details"/>
      
      <xsl:call-template name="lc-amt-details-header"/>
      
      <xsl:call-template name="lc-revolving-details-header"/>
      <xsl:call-template name="lc-payment-details-header"/>
      <xsl:call-template name="lc-shipment-details-header"/>
      
      <!-- Bank Details -->
      <xsl:call-template name="lc-bank-details-new"/>
      
      <!-- license details -->
      <xsl:call-template name="linked-ls-declaration-new"/>
      <xsl:call-template name="linked-licenses-new">
	  	<xsl:with-param name="path" select="/lc_tnx_record"></xsl:with-param>
	  </xsl:call-template>
	  <xsl:call-template name="linked-licenses-new">
	  	<xsl:with-param name="path" select="/lc_tnx_record/original_xml/lc_tnx_record"></xsl:with-param>
	  </xsl:call-template>
      
      <!-- Narrative Details -->
      <xsl:call-template name="lc-narrative-details-new"/>
   
      <!-- Narrative Period -->
      <xsl:call-template name="lc-narrative-period-new"/>
      
      <!-- Narrative Charges -->
      <xsl:call-template name="lc-narrative-charges-new"/>
      
      <xsl:call-template name="bank-instructions-header">
       <xsl:with-param name="send-mode-required">N</xsl:with-param>
       <xsl:with-param name="delivery-channel-displayed">Y</xsl:with-param>
      </xsl:call-template>
     </xsl:with-param>
    </xsl:call-template>
    
    <!-- Form #11 : Attach Files -->  
     <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
    	<xsl:call-template name="attachments-file-dojo">
    		<xsl:with-param name="callback">misys.toggleFields(misys._config.customerBanksMT798Channel[dijit.byId("issuing_bank_abbv_name")] == true &amp;&amp; misys.hasAttachments() &amp;&amp; dijit.byId("adv_send_mode").get("value") == '01', null, ["delivery_channel"], false, false)</xsl:with-param>
    		<xsl:with-param name="title-size">35</xsl:with-param>
    	</xsl:call-template>
    </xsl:if>

    <xsl:call-template name="realform"/>
    </div>
   <!-- Javascript imports  -->
   <xsl:call-template name="js-imports"/>
  </xsl:template>

  <!--                                     -->  
  <!-- BEGIN LOCAL TEMPLATES FOR THIS FORM -->
  <!--                                     -->
  
  <!-- 
   Additional JS imports for this form can be 
   added here. 
  -->
  <xd:doc>
  	<xd:short>Import Javascript libraries.</xd:short>
  	<xd:detail>
	 Additional JS imports for this form can be 
  	 added here. 
  	</xd:detail>
  </xd:doc>
  <xsl:template name="js-imports">
   <xsl:call-template name="common-js-imports">
    <xsl:with-param name="binding">misys.binding.trade.create_lc</xsl:with-param>
    <xsl:with-param name="show-period-js">Y</xsl:with-param>
    <xsl:with-param name="override-help-access-key">LC_01</xsl:with-param>
   </xsl:call-template>
  </xsl:template>


 <!-- This template displays the general details fieldset of the transaction -->
  <xd:doc>
  	<xd:short>General details.</xd:short>
  	<xd:detail>
		This template displays the general details fieldset of the transaction
  	</xd:detail>
  </xd:doc>
 <xsl:template name="general-details">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
   <xsl:call-template name="disclaimer-new"/>
    <xsl:call-template name="column-container">
       <xsl:with-param name="content">
         <xsl:call-template name="column-wrapper">
             <xsl:with-param name="content">
			     <!-- Common general details. -->
			   <xsl:call-template name="common-general-details-new">
			     <xsl:with-param name="path" select="/lc_tnx_record"></xsl:with-param> 
			   </xsl:call-template>
			     <!-- LC Details. -->
			   <xsl:call-template name="lc-general-details-new">
			     <xsl:with-param name="path" select="/lc_tnx_record"></xsl:with-param> 
			   </xsl:call-template>
	       </xsl:with-param>
	    </xsl:call-template>
    <!-- second Column -->
	     <xsl:call-template name="column-wrapper">
	         <xsl:with-param name="content">
				<!-- Common general details. -->
				<xsl:call-template name="common-general-details-new">
				    <xsl:with-param name="path" select="/lc_tnx_record/original_xml/lc_tnx_record"></xsl:with-param> 
				</xsl:call-template>
				<!-- LC Details. -->
				<xsl:call-template name="lc-general-details-new">
				   <xsl:with-param name="path" select="/lc_tnx_record/original_xml/lc_tnx_record"></xsl:with-param>
				</xsl:call-template>
	       </xsl:with-param>
	    </xsl:call-template>
    </xsl:with-param>
    </xsl:call-template>  
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- This template displays the beneficiary details fieldset of the transaction -->
 <xd:doc>
  	<xd:short>Beneficiary details.</xd:short>
  	<xd:detail>
		This template displays the beneficiary details fieldset of the transaction.
  	</xd:detail>
  </xd:doc>
  <xsl:template name="beneficiary-details">
    <xsl:call-template name="fieldset-wrapper">
	      <xsl:with-param name="legend">XSL_HEADER_BENEFICIARY_DETAILS</xsl:with-param>
	      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
	      <xsl:with-param name="button-type"></xsl:with-param>
	      <xsl:with-param name="content">
	        <xsl:call-template name="column-container">
		       <xsl:with-param name="content">			 
		         <xsl:call-template name="column-wrapper">
		             <xsl:with-param name="content">
				       <xsl:call-template name="beneficiaryaddress">
	      					 <xsl:with-param name="path" select="/lc_tnx_record"/> 		        	        
	      			 </xsl:call-template>
	                </xsl:with-param>
	            </xsl:call-template>
	       <xsl:call-template name="column-wrapper">
		        <xsl:with-param name="content">
				  <xsl:call-template name="beneficiaryaddress">
				       <xsl:with-param name="path" select="/lc_tnx_record/original_xml/lc_tnx_record"/> 		        	        
				  </xsl:call-template>     
	            </xsl:with-param>
	       </xsl:call-template>
	       </xsl:with-param>
	       </xsl:call-template>
	      </xsl:with-param>
	 </xsl:call-template> 
   </xsl:template>
 
 <!-- This template displays the LC amount details fieldset of the transaction -->
  <xd:doc>
  	<xd:short>Amount Details .</xd:short>
  	<xd:detail>
		This template displays the LC amount details fieldset of the transaction
  	</xd:detail>
  </xd:doc>
  <xsl:template name="lc-amt-details-header">
  <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="column-container">
       <xsl:with-param name="content">
         <xsl:call-template name="column-wrapper">
             <xsl:with-param name="content">
			     <!-- LC details. -->
			     <xsl:call-template name="lc-amt-details-new">
				     <xsl:with-param name="show-standby">Y</xsl:with-param>
	       			 <xsl:with-param name="show-revolving">Y</xsl:with-param>
				     <xsl:with-param name="path" select="/lc_tnx_record"></xsl:with-param> 
			     </xsl:call-template>     
	       </xsl:with-param>
	    </xsl:call-template>
 
	     <xsl:call-template name="column-wrapper">
	         <xsl:with-param name="content">
				     <!-- Common general details. -->
				     <xsl:call-template name="lc-amt-details-new">
					     <xsl:with-param name="show-standby">Y</xsl:with-param>
	       				 <xsl:with-param name="show-revolving">Y</xsl:with-param>
					     <xsl:with-param name="path" select="/lc_tnx_record/original_xml/lc_tnx_record"></xsl:with-param> 
				     </xsl:call-template>
	       </xsl:with-param>
	    </xsl:call-template>
    </xsl:with-param>
    </xsl:call-template>  
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- This template displays the LC revolving details fieldset of the transaction -->
 <xd:doc>
  	<xd:short>Revolving Details.</xd:short>
  	<xd:detail>
		This template displays the LC revolving details fieldset of the transaction
  	</xd:detail>
  </xd:doc>
  <xsl:template name="lc-revolving-details-header">
  <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_REVOLVING_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="column-container">
       <xsl:with-param name="content">
         <xsl:call-template name="column-wrapper">
             <xsl:with-param name="content">
			    <!-- LC details. -->
			    <xsl:call-template name="lc-revolving-details-new">
			       <xsl:with-param name="path" select="/lc_tnx_record"></xsl:with-param> 
			    </xsl:call-template>     
       		</xsl:with-param>
    	</xsl:call-template>
	    <!-- second Column -->
	     <xsl:call-template name="column-wrapper">
	         <xsl:with-param name="content">
				<!-- Common general details. -->
				<xsl:call-template name="lc-revolving-details-new">
				    <xsl:with-param name="path" select="/lc_tnx_record/original_xml/lc_tnx_record"></xsl:with-param> 
				</xsl:call-template>
	       </xsl:with-param>
	    </xsl:call-template>
     </xsl:with-param>
    </xsl:call-template>  
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!-- This template displays the shipment details fieldset of the transaction -->
  <xd:doc>
  	<xd:short>Shipment Details.</xd:short>
  	<xd:detail>
		This template displays the shipment details fieldset of the transaction
  	</xd:detail>
  </xd:doc>
 <xsl:template name="lc-shipment-details-header">
  <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_SHIPMENT_DETAILS</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="column-container">
       <xsl:with-param name="content">
         <xsl:call-template name="column-wrapper">
             <xsl:with-param name="content">
			     <!-- LC details. -->
			     <xsl:call-template name="lc-shipment-details-new">
			     <xsl:with-param name="path" select="/lc_tnx_record"></xsl:with-param> 
			     </xsl:call-template>     
	       </xsl:with-param>
	    </xsl:call-template>
	    <!-- second Column -->
	     <xsl:call-template name="column-wrapper">
	         <xsl:with-param name="content">
				     <!-- Common general details. -->
				     <xsl:call-template name="lc-shipment-details-new">
				      <xsl:with-param name="path" select="/lc_tnx_record/original_xml/lc_tnx_record"></xsl:with-param> 
				     </xsl:call-template>
	       </xsl:with-param>
	    </xsl:call-template>
    </xsl:with-param>
    </xsl:call-template>  
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>

<!-- This template displays the bank instruction details fieldset of the transaction -->
  <xd:doc>
  	<xd:short>Bank instruction Details.</xd:short>
  	<xd:detail>
		This template displays the bank instruction details fieldset of the transaction.
  	</xd:detail>
  </xd:doc>
  <xsl:template name="bank-instructions-header">
  <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_INSTRUCTIONS</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="column-container">
       <xsl:with-param name="content">
         <xsl:call-template name="column-wrapper">
             <xsl:with-param name="content">
			     <!-- LC details. -->
			     <xsl:call-template name="bank-instructions-new">
			     <xsl:with-param name="path" select="/lc_tnx_record"></xsl:with-param> 
			     </xsl:call-template>     
	       </xsl:with-param>
	    </xsl:call-template>
	    <!-- second Column -->
	     <xsl:call-template name="column-wrapper">
	         <xsl:with-param name="content">
				     <!-- Common general details. -->
				     <xsl:call-template name="bank-instructions-new">
				      <xsl:with-param name="path" select="/lc_tnx_record/original_xml/lc_tnx_record"></xsl:with-param> 
				     </xsl:call-template>
	       </xsl:with-param>
    	</xsl:call-template>
    </xsl:with-param>
    </xsl:call-template>  
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
  
  <!-- This template displays the payment details section of the transaction -->
   <xd:doc>
  	<xd:short>Payment Details.</xd:short>
  	<xd:detail>
		This template displays the payment details section of the transaction.
  	</xd:detail>
  </xd:doc>
  <xsl:template name="lc-payment-details-header">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_PAYMENT_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
     <!-- Credit Available With -->
     <xsl:call-template name="fieldset-wrapper">
      <xsl:with-param name="legend">XSL_PAYMENTDETAILS_CR_AVAIL_WITH_LABEL</xsl:with-param>
      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
      <xsl:with-param name="content">
      <xsl:call-template name="column-container">
       <xsl:with-param name="content">
           <xsl:call-template name="column-wrapper">
		       <xsl:with-param name="content">
			       <xsl:apply-templates select="credit_available_with_bank" mode="select"/>
			       <xsl:call-template name="credit-available-by-new">
			       	  <xsl:with-param name="path">lc_tnx_record</xsl:with-param> 
			       </xsl:call-template>
		       </xsl:with-param>
       	   </xsl:call-template>
	       <xsl:call-template name="column-wrapper">
	           <xsl:with-param name="content">
			       <xsl:apply-templates select="original_xml/lc_tnx_record/credit_available_with_bank" mode="select"/>
			       <xsl:call-template name="credit-available-by-new">
			       	  <xsl:with-param name="path">/lc_tnx_record/original_xml/lc_tnx_record</xsl:with-param> 
			       </xsl:call-template>
		       </xsl:with-param>
	       </xsl:call-template>
       </xsl:with-param>
       </xsl:call-template>
      </xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <!-- This template displays the narrative details section of the transaction -->
   <xd:doc>
  	<xd:short>Narrative Details.</xd:short>
  	<xd:detail>
		This template displays the narrative details section of the transaction.
  	</xd:detail>
  </xd:doc>
  <xsl:template name="lc-narrative-details-new">
   <xsl:param name="in-fieldset">Y</xsl:param>
   <!-- Tabgroup #1 : Narrative Details (3 Tabs) -->
   <xsl:call-template name="tabgroup-wrapper">
    <xsl:with-param name="in-fieldset"><xsl:value-of select="$in-fieldset"></xsl:value-of></xsl:with-param>
    <xsl:with-param name="tabgroup-label">XSL_HEADER_NARRATIVE_DETAILS</xsl:with-param>
    <xsl:with-param name="tabgroup-id">narrative-details-tabcontainer</xsl:with-param>
    <xsl:with-param name="tabgroup-height">350px;</xsl:with-param>
    
    <!-- Tab 0 - Description of Goods  -->
    <xsl:with-param name="tab0-label">XSL_NARRATIVEDETAILS_TAB_DESCRIPTION_GOODS</xsl:with-param>
    <xsl:with-param name="tab0-content"> 
        <xsl:call-template name="column-container">
             <xsl:with-param name="content">			 
             <xsl:call-template name="column-wrapper">
	             <xsl:with-param name="content"> 
		    		 <xsl:call-template name="input-field">
				      <xsl:with-param name="name">narrative_description_goods</xsl:with-param>
				      <xsl:with-param name="value" select="narrative_description_goods/text"></xsl:with-param>
				     </xsl:call-template>
			     </xsl:with-param>
		     </xsl:call-template>
		     <xsl:call-template name="column-wrapper">
	             <xsl:with-param name="content"> 
		    		 <xsl:call-template name="input-field">
				      <xsl:with-param name="name">narrative_description_goods</xsl:with-param>
				      <xsl:with-param name="value" select="original_xml/lc_tnx_record/narrative_description_goods/text"></xsl:with-param>
				     </xsl:call-template>
			     </xsl:with-param>
		     </xsl:call-template>
		     </xsl:with-param>
	   </xsl:call-template>
    </xsl:with-param>
     
    <!-- Tab 1 - Documents Required  -->
    <xsl:with-param name="tab1-label">XSL_NARRATIVEDETAILS_TAB_DOCUMENTS_REQUIRED</xsl:with-param>
    <xsl:with-param name="tab1-content">
      <xsl:call-template name="column-container">
             <xsl:with-param name="content">			 
	             <xsl:call-template name="column-wrapper">
		             <xsl:with-param name="content"> 
			    		 <xsl:call-template name="input-field">
					      <xsl:with-param name="name">narrative_documents_required</xsl:with-param>
					      <xsl:with-param name="value" select="narrative_documents_required/text"></xsl:with-param>
					     </xsl:call-template>
				     </xsl:with-param>
			     </xsl:call-template>
			     <xsl:call-template name="column-wrapper">
		             <xsl:with-param name="content"> 
			    		 <xsl:call-template name="input-field">
					      <xsl:with-param name="name">narrative_documents_required</xsl:with-param>
					      <xsl:with-param name="value" select="original_xml/lc_tnx_record/narrative_documents_required/text"></xsl:with-param>
					     </xsl:call-template>
				     </xsl:with-param>
			     </xsl:call-template>
		     </xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
     
    <!-- Tab 2 - Additional Instructions  -->
    <xsl:with-param name="tab2-label">XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_INSTRUCTIONS</xsl:with-param>
    <xsl:with-param name="tab2-content">
      <xsl:call-template name="column-container">
             <xsl:with-param name="content">			 
	             <xsl:call-template name="column-wrapper">
		             <xsl:with-param name="content"> 
			    		 <xsl:call-template name="input-field">
					      <xsl:with-param name="name">narrative_additional_instructions</xsl:with-param>
					      <xsl:with-param name="value" select="narrative_additional_instructions/text"></xsl:with-param>
					     </xsl:call-template>
				     </xsl:with-param>
			     </xsl:call-template>
			     <xsl:call-template name="column-wrapper">
		             <xsl:with-param name="content"> 
			    		 <xsl:call-template name="input-field">
					      <xsl:with-param name="name">narrative_additional_instructions</xsl:with-param>
					      <xsl:with-param name="value" select="original_xml/lc_tnx_record/narrative_additional_instructions/text"></xsl:with-param>
					     </xsl:call-template>
				     </xsl:with-param>
			     </xsl:call-template>
		     </xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <!-- This template displays the charges/payment instruction/other details section of the transaction -->
   <xd:doc>
  	<xd:short>Charges/Payment Details.</xd:short>
  	<xd:detail>
		This template displays the charges/payment instruction/other details section of the transaction.
  	</xd:detail>
  </xd:doc>
  <xsl:template name="lc-narrative-charges-new">
   <!-- Tabgroup #1 : Narrative Details (3 Tabs) -->
   <xsl:call-template name="tabgroup-wrapper">
    <!-- Tab 0 - Description of Goods  -->
    <xsl:with-param name="tab0-label">XSL_NARRATIVEDETAILS_TAB_CHARGES</xsl:with-param>
    <xsl:with-param name="tab0-content"> 
        <xsl:call-template name="column-container">
             <xsl:with-param name="content">			 
             <xsl:call-template name="column-wrapper">
	             <xsl:with-param name="content"> 
		    		 <xsl:call-template name="input-field">
				      <xsl:with-param name="name">narrative_charges</xsl:with-param>
				      <xsl:with-param name="value" select="narrative_charges/text"></xsl:with-param>
				     </xsl:call-template>
			     </xsl:with-param>
		     </xsl:call-template>
		     <xsl:call-template name="column-wrapper">
	             <xsl:with-param name="content"> 
		    		 <xsl:call-template name="input-field">
				      <xsl:with-param name="name">narrative_charges</xsl:with-param>
				      <xsl:with-param name="value" select="original_xml/lc_tnx_record/narrative_charges/text"></xsl:with-param>
				     </xsl:call-template>
			     </xsl:with-param>
		     </xsl:call-template>
		     </xsl:with-param>
	   </xsl:call-template>
    </xsl:with-param>
     
    <!-- Tab 1 - Documents Required  -->
    <xsl:with-param name="tab1-label">XSL_NARRATIVEDETAILS_TAB_SENDER_TO_RECEIVER</xsl:with-param>
    <xsl:with-param name="tab1-content">
      <xsl:call-template name="column-container">
             <xsl:with-param name="content">			 
	             <xsl:call-template name="column-wrapper">
		             <xsl:with-param name="content"> 
			    		 <xsl:call-template name="input-field">
					      <xsl:with-param name="name">narrative_sender_to_receiver</xsl:with-param>
					      <xsl:with-param name="value" select="narrative_sender_to_receiver/text"></xsl:with-param>
					     </xsl:call-template>
				     </xsl:with-param>
			     </xsl:call-template>
			     <xsl:call-template name="column-wrapper">
		             <xsl:with-param name="content"> 
			    		 <xsl:call-template name="input-field">
					      <xsl:with-param name="name">narrative_sender_to_receiver</xsl:with-param>
					      <xsl:with-param name="value" select="original_xml/lc_tnx_record/narrative_sender_to_receiver/text"></xsl:with-param>
					     </xsl:call-template>
				     </xsl:with-param>
			     </xsl:call-template>
		     </xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
     
    <!-- Tab 2 - Additional Instructions  -->
    <xsl:with-param name="tab2-label">XSL_NARRATIVEDETAILS_TAB_PAYMT_INSTRUCTIONS</xsl:with-param>
    <xsl:with-param name="tab2-content">
      <xsl:call-template name="column-container">
             <xsl:with-param name="content">			 
	             <xsl:call-template name="column-wrapper">
		             <xsl:with-param name="content"> 
			    		 <xsl:call-template name="input-field">
					      <xsl:with-param name="name">narrative_payment_instructions</xsl:with-param>
					      <xsl:with-param name="value" select="narrative_payment_instructions/text"></xsl:with-param>
					     </xsl:call-template>
				     </xsl:with-param>
			     </xsl:call-template>
			     <xsl:call-template name="column-wrapper">
		             <xsl:with-param name="content"> 
			    		 <xsl:call-template name="input-field">
					      <xsl:with-param name="name">narrative_payment_instructions</xsl:with-param>
					      <xsl:with-param name="value" select="original_xml/lc_tnx_record/narrative_payment_instructions/text"></xsl:with-param>
					     </xsl:call-template>
				     </xsl:with-param>
			     </xsl:call-template>
		     </xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
    </xsl:call-template>
   </xsl:template>
  
  <!-- This template displays the bank details section of the transaction -->
  <xd:doc>
  	<xd:short>Bank Details.</xd:short>
  	<xd:detail>
		This template displays the bank details section of the transaction.
  	</xd:detail>
  </xd:doc>
  <xsl:template name="lc-bank-details-new">
   <!-- Tabgroup #0 : Bank Details (3 Tabs) -->
   <xsl:call-template name="tabgroup-wrapper">
    <xsl:with-param name="tabgroup-label">XSL_HEADER_BANK_DETAILS</xsl:with-param>
    <xsl:with-param name="tabgroup-id">bank-details-tabcontainer</xsl:with-param>
    <xsl:with-param name="tabgroup-height">250px</xsl:with-param>

    <!-- Tab 0_0 - Issuing Bank  -->
    <xsl:with-param name="tab0-label">XSL_BANKDETAILS_TAB_ISSUING_BANK</xsl:with-param>
    <xsl:with-param name="tab0-content">
       <xsl:call-template name="column-container">
             <xsl:with-param name="content">			 
               <xsl:call-template name="column-wrapper">
                <xsl:with-param name="content">  
	      <xsl:call-template name="main-bank-selectbox-new">
	      <xsl:with-param name="path" select="/lc_tnx_record"/> 
	    <xsl:with-param name="main-bank-name">issuing_bank</xsl:with-param>
	    <xsl:with-param name="sender-name">applicant</xsl:with-param>
	    <xsl:with-param name="sender-reference-name">applicant_reference</xsl:with-param>
	   </xsl:call-template>
	   <xsl:call-template name="customer-reference-selectbox-new">
	    <xsl:with-param name="main-bank-name">issuing_bank</xsl:with-param>
	    <xsl:with-param name="sender-name">applicant</xsl:with-param>
	    <xsl:with-param name="sender-reference-name">applicant_reference</xsl:with-param>
	   </xsl:call-template>
	   </xsl:with-param>
	   </xsl:call-template>
	   
	   <xsl:call-template name="column-wrapper">
                <xsl:with-param name="content">  
	      <xsl:call-template name="main-bank-selectbox-new">
	      <xsl:with-param name="path" select="/lc_tnx_record/original_xml/lc_tnx_record"/>
	   <xsl:with-param name="main-bank-name">issuing_bank</xsl:with-param>
	    <xsl:with-param name="sender-name">applicant</xsl:with-param>
	    <xsl:with-param name="sender-reference-name">applicant_reference</xsl:with-param>
	   </xsl:call-template>
	   <xsl:call-template name="customer-reference-selectbox-new">
	    <xsl:with-param name="main-bank-name">issuing_bank</xsl:with-param>
	    <xsl:with-param name="sender-name">applicant</xsl:with-param>
	    <xsl:with-param name="sender-reference-name">applicant_reference</xsl:with-param>
	   </xsl:call-template>
	   </xsl:with-param>
	   </xsl:call-template>
	   </xsl:with-param>
	   </xsl:call-template>
    </xsl:with-param>
     
    <!-- Tab 0_1 - Advising Bank -->
    <xsl:with-param name="tab1-label">XSL_BANKDETAILS_TAB_ADVISING_BANK</xsl:with-param>
    <xsl:with-param name="tab1-content">
        <xsl:call-template name="column-container">
             <xsl:with-param name="content">			 
               <xsl:call-template name="column-wrapper">
                <xsl:with-param name="content">  
		       <xsl:apply-templates select="advising_bank">
		        <xsl:with-param name="theNodeName">advising_bank</xsl:with-param>
		       </xsl:apply-templates>
		       </xsl:with-param>
		       </xsl:call-template>
		       
       <xsl:call-template name="column-wrapper">
                <xsl:with-param name="content">  
       <xsl:apply-templates select="original_xml/lc_tnx_record/advising_bank">
        <xsl:with-param name="theNodeName">advising_bank</xsl:with-param>
       </xsl:apply-templates>
       </xsl:with-param>
       </xsl:call-template>
       </xsl:with-param>
       </xsl:call-template>
    </xsl:with-param>
     
    <!-- Tab 0_2 - Advise Thru Bank -->
    <xsl:with-param name="tab2-label">XSL_BANKDETAILS_TAB_ADVISE_THRU_BANK</xsl:with-param>
    <xsl:with-param name="tab2-content">
       <xsl:call-template name="column-container">
             <xsl:with-param name="content">			 
               <xsl:call-template name="column-wrapper">
                <xsl:with-param name="content"> 
       <xsl:apply-templates select="advise_thru_bank">
        <xsl:with-param name="theNodeName">advise_thru_bank</xsl:with-param>
       </xsl:apply-templates>
       </xsl:with-param>
       </xsl:call-template>
       
        <xsl:call-template name="column-wrapper">
                <xsl:with-param name="content"> 
       <xsl:apply-templates select="original_xml/lc_tnx_record/advise_thru_bank">
        <xsl:with-param name="theNodeName">advise_thru_bank</xsl:with-param>
       </xsl:apply-templates>
       </xsl:with-param>
       </xsl:call-template>
       </xsl:with-param>
       </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <!-- This template displays the narrative period presentation details section of the transaction -->
   <xd:doc>
  	<xd:short>Narrative perid Details.</xd:short>
  	<xd:detail>
		This template displays the narrative period presentation details section of the transaction.
  	</xd:detail>
  </xd:doc>
   <xsl:template name="lc-narrative-period-new">
	<xsl:param name="in-fieldset">Y</xsl:param>
   <xsl:call-template name="tabgroup-wrapper">
   <xsl:with-param name="in-fieldset"><xsl:value-of select="$in-fieldset"></xsl:value-of></xsl:with-param>
    <xsl:with-param name="tabgroup-id">narrative-period-tabcontainer</xsl:with-param>
    
    <!-- Tab 0 - Period Presentation  -->
    <xsl:with-param name="tab0-label">XSL_NARRATIVEDETAILS_TAB_PERIOD_PRESENTATION</xsl:with-param>
    <xsl:with-param name="tab0-content"> 
       <xsl:call-template name="column-container">
             <xsl:with-param name="content">			 
	             <xsl:call-template name="column-wrapper">
		             <xsl:with-param name="content"> 
			    		 <xsl:call-template name="input-field">
					      <xsl:with-param name="name">narrative_period_presentation</xsl:with-param>
					      <xsl:with-param name="value" select="narrative_period_presentation/text"></xsl:with-param>
					     </xsl:call-template>
				     </xsl:with-param>
			     </xsl:call-template>
			     <xsl:call-template name="column-wrapper">
		             <xsl:with-param name="content"> 
			    		 <xsl:call-template name="input-field">
					      <xsl:with-param name="name">narrative_period_presentation</xsl:with-param>
					      <xsl:with-param name="value" select="original_xml/lc_tnx_record/narrative_period_presentation/text"></xsl:with-param>
					     </xsl:call-template>
				     </xsl:with-param>
			     </xsl:call-template>
		     </xsl:with-param>
		</xsl:call-template>
    </xsl:with-param>
    
    <!-- Tab 1 - Shipment Period  -->
    <xsl:with-param name="tab1-label">XSL_NARRATIVEDETAILS_TAB_SHIPMENT_PERIOD</xsl:with-param>
    <xsl:with-param name="tab1-content">
     	<xsl:call-template name="column-container">
             <xsl:with-param name="content">			 
	             <xsl:call-template name="column-wrapper">
		             <xsl:with-param name="content"> 
					     <xsl:call-template name="input-field">
					      <xsl:with-param name="name">narrative_shipment_period</xsl:with-param>
					      <xsl:with-param name="value" select="narrative_shipment_period/text"></xsl:with-param>
					     </xsl:call-template>
				     </xsl:with-param>
			     </xsl:call-template>
			     <xsl:call-template name="column-wrapper">
				     <xsl:with-param name="content"> 
					     <xsl:call-template name="input-field">
					      <xsl:with-param name="name">narrative_shipment_period</xsl:with-param>
					      <xsl:with-param name="value" select="original_xml/lc_tnx_record/narrative_shipment_period/text"></xsl:with-param>
					     </xsl:call-template>
				     </xsl:with-param>
			     </xsl:call-template>
		     </xsl:with-param>
     	</xsl:call-template>
    </xsl:with-param>
     
    <!-- Tab 2 - Additional Amount  -->
    <xsl:with-param name="tab2-label">XSL_NARRATIVEDETAILS_TAB_ADDITIONAL_AMOUNT</xsl:with-param>
    <xsl:with-param name="tab2-content">
	      <xsl:call-template name="column-container">
		      <xsl:with-param name="content">			 
			      <xsl:call-template name="column-wrapper">
				      <xsl:with-param name="content"> 
					      <xsl:call-template name="input-field">
						      <xsl:with-param name="name">narrative_additional_amount</xsl:with-param>
						      <xsl:with-param name="value" select="narrative_additional_amount/text"></xsl:with-param>
					      </xsl:call-template>
				      </xsl:with-param>
			      </xsl:call-template>
			      <xsl:call-template name="column-wrapper">
				      <xsl:with-param name="content"> 
					      <xsl:call-template name="input-field">
						      <xsl:with-param name="name">narrative_additional_amount</xsl:with-param>
						      <xsl:with-param name="value" select="original_xml/lc_tnx_record/narrative_additional_amount/text"></xsl:with-param>
					      </xsl:call-template>
				      </xsl:with-param>
			      </xsl:call-template>
	      	  </xsl:with-param>
	      </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
    <!-- This template displays the applicant details section of the transaction -->
   <xd:doc>
  	<xd:short>Applicant Details.</xd:short>
  	<xd:detail>
		This template displays the applicant details section of the transaction.
  	</xd:detail>
  </xd:doc>
    <xsl:template name="applicant-details">
	     <xsl:call-template name="fieldset-wrapper">
	      <xsl:with-param name="legend">XSL_HEADER_APPLICANT_DETAILS</xsl:with-param>
	      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
	      <xsl:with-param name="content">
	       <xsl:call-template name="column-container">
	         <xsl:with-param name="content">
                <!-- First column -->			 
                <xsl:call-template name="column-wrapper">
                 <xsl:with-param name="content">
			        <xsl:call-template name="applicantaddress">
			          <xsl:with-param name="path" select="/lc_tnx_record"/> 
			        </xsl:call-template>
		         </xsl:with-param>
		       </xsl:call-template>
		       <!-- second column -->
		       <xsl:call-template name="column-wrapper">
	            <xsl:with-param name="content">                         
				    <xsl:call-template name="applicantaddress">
				       <xsl:with-param name="path" select="/lc_tnx_record/original_xml/lc_tnx_record"/> 
			    	</xsl:call-template>			      
		       </xsl:with-param>
		     </xsl:call-template>
		   </xsl:with-param>
		  </xsl:call-template>
	     </xsl:with-param>
	    </xsl:call-template>
   </xsl:template>
   
  <!-- This template displays the linked license details section of the transaction -->
  <xd:doc>
  	<xd:short>License Details.</xd:short>
  	<xd:detail>
		This template displays the linked license details section of the transaction.
  	</xd:detail>
  </xd:doc>
  <xsl:template name="linked-ls-declaration-new">
  <xsl:call-template name="fieldset-wrapper">
   <xsl:with-param name="legend">XSL_HEADER_LINKED_LICENSES</xsl:with-param>
   <xsl:with-param name="content">
    <xsl:call-template name="column-container">
       <xsl:with-param name="content">
         <xsl:call-template name="column-wrapper">
             <xsl:with-param name="content">
			   <xsl:call-template name="linkedlsdeclaration">
			     <xsl:with-param name="path" select="/lc_tnx_record"></xsl:with-param> 
			   </xsl:call-template>
	       </xsl:with-param>
	    </xsl:call-template>
    <!-- second Column -->
	     <xsl:call-template name="column-wrapper">
	         <xsl:with-param name="content">
				<xsl:call-template name="linkedlsdeclaration">
				   <xsl:with-param name="path" select="/lc_tnx_record/original_xml/lc_tnx_record"></xsl:with-param>
				</xsl:call-template>
	       </xsl:with-param>
	    </xsl:call-template>
    </xsl:with-param>
    </xsl:call-template>  
   </xsl:with-param>
  </xsl:call-template>
 </xsl:template>
 
 <!--
  LC Realform.
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
     <xsl:call-template name="reauth_params"/>   
     </div>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
<!--  -->  
<!-- END LOCAL TEMPLATES FOR THIS FORM -->
<!--  -->

</xsl:stylesheet>