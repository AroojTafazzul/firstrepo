<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for

 New Banker's Guarantee (BG) Form, Customer Side

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
	    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		xmlns:common="http://exslt.org/common"
		exclude-result-prefixes="localization utils security common">
      
 <!-- Columns definition import -->
  <xsl:import href="../../../core/xsl/report/report.xsl"/>
  <xsl:include href="../../../core/xsl/system/sy_reauthenticationdialog.xsl" />
  <xsl:include href="../common/bg_common.xsl" /> 
  
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">BG</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/BankerGuaranteeScreen</xsl:param>
  <xsl:param name="option"></xsl:param>
 
  <!-- Global Imports. -->
   <xsl:include href="../../../core/xsl/common/trade_common.xsl" />
  <xsl:include href="../../../core/xsl/common/static_document_upload_templates.xsl" />
  <xsl:include href="../../../core/xsl/common/e2ee_common.xsl"/>
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
    <xsl:apply-templates select="bg_tnx_record"/>
  </xsl:template>
  
  <!-- 
   BG TNX FORM TEMPLATE.
  -->
  <xsl:template match="bg_tnx_record"> 
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
      <!--  Display common menu. -->
      <xsl:call-template name="menu">
      <xsl:with-param name="show-return">Y</xsl:with-param>
      </xsl:call-template> 
      
      <!-- Disclaimer Notice -->
      <xsl:call-template name="disclaimer"/>     
         
      <xsl:call-template name="general-details"/>
      <xsl:call-template name="applicant-details"/>
      <xsl:call-template name="beneficiary-details"/>
      <xsl:call-template name="contact-details"/>
       <xsl:call-template name="bg-amt-details">
       <xsl:with-param name="override-product-code">bg</xsl:with-param>
      </xsl:call-template>
       <xsl:call-template name="bg-renewal-details-new"/>
    <!-- Bank details -->   
      <xsl:call-template name="fieldset-wrapper">
       <xsl:with-param name="legend">XSL_HEADER_BANK_DETAILS</xsl:with-param>
         <xsl:with-param name="content"> 
          <xsl:call-template name="column-container">
             <xsl:with-param name="content">			 
               <xsl:call-template name="column-wrapper">
                <xsl:with-param name="content">    
				    <xsl:call-template name="main-bank-selectbox-new">
				     <xsl:with-param name="path" select="/bg_tnx_record"/> 
			         <xsl:with-param name="label">
			          <xsl:choose>
					   <xsl:when test="issuing_bank_type_code[.='02'] or (not(security:isBank($rundata)))">XSL_TRANSACTIONDETAILS_RECIPIENT_BANK</xsl:when>
					   <xsl:otherwise>XSL_BANKDETAILS_TAB_RECIPIENT_ISSUING_BANK</xsl:otherwise>
					  </xsl:choose>
			         </xsl:with-param>
			         <xsl:with-param name="main-bank-name">recipient_bank</xsl:with-param>
			         <xsl:with-param name="sender-name">applicant</xsl:with-param>
			         <xsl:with-param name="sender-reference-name">applicant_reference</xsl:with-param>
		           </xsl:call-template>
        
			        <xsl:call-template name="customer-reference-selectbox-new">
			        <xsl:with-param name="path" select="/bg_tnx_record"/> 
			         <xsl:with-param name="main-bank-name">recipient_bank</xsl:with-param>
			         <xsl:with-param name="sender-name">applicant</xsl:with-param>
			         <xsl:with-param name="sender-reference-name">applicant_reference</xsl:with-param>
			        </xsl:call-template>
              </xsl:with-param>
        </xsl:call-template>
        <!--  second Column -->
        <xsl:call-template name="column-wrapper">
            <xsl:with-param name="content">    
			    <xsl:call-template name="main-bank-selectbox-new">
			    <xsl:with-param name="path" select="/bg_tnx_record/original_xml/bg_tnx_record"/> 
		         <xsl:with-param name="label">
		          <xsl:choose>
				   <xsl:when test="original_xml/bg_tnx_record/issuing_bank_type_code[.='02'] or (not(security:isBank($rundata)))">XSL_TRANSACTIONDETAILS_RECIPIENT_BANK</xsl:when>
				   <xsl:otherwise>XSL_BANKDETAILS_TAB_RECIPIENT_ISSUING_BANK</xsl:otherwise>
				  </xsl:choose>
		         </xsl:with-param>
		         <xsl:with-param name="main-bank-name">original_xml/bg_tnx_record/recipient_bank</xsl:with-param>
		         <xsl:with-param name="sender-name">original_xml/bg_tnx_record/applicant</xsl:with-param>
		         <xsl:with-param name="sender-reference-name">original_xml/bg_tnx_record/applicant_reference</xsl:with-param>
		        </xsl:call-template>
        
		        <xsl:call-template name="customer-reference-selectbox">
		          <xsl:with-param name="path" select="/bg_tnx_record/original_xml/bg_tnx_record"/> 
		         <xsl:with-param name="main-bank-name">original_xml/bg_tnx_record/recipient_bank</xsl:with-param>
		         <xsl:with-param name="sender-name">original_xml/bg_tnx_record/applicant</xsl:with-param>
		         <xsl:with-param name="sender-reference-name">original_xml/bg_tnx_record/applicant_reference</xsl:with-param>
		        </xsl:call-template>
        </xsl:with-param>
        </xsl:call-template>
        </xsl:with-param>
        </xsl:call-template>
       
       
           <xsl:choose>
     	  <xsl:when test="issuing_bank_type_code[.='02'] or (not(security:isBank($rundata)))">
     	   <xsl:call-template name="tabgroup-wrapper">
     	     <xsl:with-param name="legend-type">indented-header</xsl:with-param>
	         <!-- Tab 0_0 - Issuing Bank  -->
	         <xsl:with-param name="tab0-label">XSL_BANKDETAILS_TAB_LOCAL_GUARANTOR</xsl:with-param>
	         <xsl:with-param name="tab0-content"> 
	          <xsl:call-template name="column-container">
                 <xsl:with-param name="content">			 
                   <xsl:call-template name="column-wrapper">
                         <xsl:with-param name="content">
				        <xsl:call-template name="input-field">
				           <xsl:with-param name="label">XSL_ISSUING_INSTRUCTIONS_LABEL</xsl:with-param>
				           <xsl:with-param name="name">issuing_bank_type_code</xsl:with-param>
				           <xsl:with-param name="required">Y</xsl:with-param>
				           <xsl:with-param name="options">
				           <xsl:if test="contains(issuing_bank_type_code,'01')"><xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TYPE_DIRECT')"/></xsl:if>
			               <xsl:if test="contains(issuing_bank_type_code,'02')"><xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TYPE_INDIRECT')"/></xsl:if>
				           </xsl:with-param>
				          </xsl:call-template>
				          <xsl:apply-templates select="issuing_bank">
				           <xsl:with-param name="theNodeName">issuing_bank</xsl:with-param>
				           <xsl:with-param name="required">Y</xsl:with-param>
			              </xsl:apply-templates>
	             </xsl:with-param>
	        </xsl:call-template>
	        <xsl:call-template name="column-wrapper">
                         <xsl:with-param name="content">
				        <xsl:call-template name="input-field">
				           <xsl:with-param name="label">XSL_ISSUING_INSTRUCTIONS_LABEL</xsl:with-param>
				           <xsl:with-param name="name">issuing_bank_type_code</xsl:with-param>
				           <xsl:with-param name="required">Y</xsl:with-param>
				           <xsl:with-param name="options">
				           <xsl:if test="contains(original_xml/bg_tnx_record/issuing_bank_type_code,'01')"><xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TYPE_DIRECT')"/></xsl:if>
			               <xsl:if test="contains(original_xml/bg_tnx_record/issuing_bank_type_code,'02')"><xsl:value-of select="localization:getGTPString($language, 'XSL_BANKDETAILS_TYPE_INDIRECT')"/></xsl:if>
				           </xsl:with-param>
				          </xsl:call-template>
				          <xsl:apply-templates select="original_xml/bg_tnx_record/issuing_bank">
				           <xsl:with-param name="theNodeName">issuing_bank</xsl:with-param>
				           <xsl:with-param name="required">Y</xsl:with-param>
			              </xsl:apply-templates>
	             </xsl:with-param>
	        </xsl:call-template>
	        </xsl:with-param>
	        </xsl:call-template>
	        </xsl:with-param>
	        
    
	        <!-- Tab 0_1 - Advising Bank  -->
	        <xsl:with-param name="tab1-label">XSL_BANKDETAILS_TAB_ADVISING_BANK</xsl:with-param>
	        <xsl:with-param name="tab1-content">
	           <xsl:call-template name="column-container">
                 <xsl:with-param name="content">			 
                    <xsl:call-template name="column-wrapper">
                      <xsl:with-param name="content">
				         <xsl:apply-templates select="original_xml/bg_tnx_record/advising_bank">
				          <xsl:with-param name="theNodeName">advising_bank</xsl:with-param>
				         </xsl:apply-templates>
				         <xsl:call-template name="checkbox-field">
					      <xsl:with-param name="label">XSL_ADVISING_BANK_CONFIRMATION_REQUIRED</xsl:with-param>
					      <xsl:with-param name="name">original_xml/bg_tnx_record/adv_bank_conf_req</xsl:with-param>
					     </xsl:call-template>
				        </xsl:with-param>
				     </xsl:call-template>
				     
				      <xsl:call-template name="column-wrapper">
                      <xsl:with-param name="content">
				         <xsl:apply-templates select="advising_bank">
				          <xsl:with-param name="theNodeName">advising_bank</xsl:with-param>
				         </xsl:apply-templates>
				         <xsl:call-template name="checkbox-field">
					      <xsl:with-param name="label">XSL_ADVISING_BANK_CONFIRMATION_REQUIRED</xsl:with-param>
					      <xsl:with-param name="name">adv_bank_conf_req</xsl:with-param>
					     </xsl:call-template>
				        </xsl:with-param>
				     </xsl:call-template>
				    </xsl:with-param>
				     </xsl:call-template>
			 </xsl:with-param>
				        
    
	        <!-- Tab 0_2 - Confirming Bank  -->
	        <xsl:with-param name="tab2-label">XSL_BANKDETAILS_TAB_CONFIRMING_BANK</xsl:with-param>
	        <xsl:with-param name="tab2-content">
	           <xsl:call-template name="column-container">
                   <xsl:with-param name="content">			 
                   <xsl:call-template name="column-wrapper">
                       <xsl:with-param name="content">
				         <xsl:apply-templates select="confirming_bank">
				          <xsl:with-param name="theNodeName">confirming_bank</xsl:with-param>
				         </xsl:apply-templates>
				         </xsl:with-param>
				         </xsl:call-template>
				  	<xsl:call-template name="column-wrapper">
                       <xsl:with-param name="content">
				         <xsl:apply-templates select="original_xml/bg_tnx_record/confirming_bank">
				          <xsl:with-param name="theNodeName">confirming_bank</xsl:with-param>
				         </xsl:apply-templates>
				         </xsl:with-param>
				    </xsl:call-template>
				         </xsl:with-param>
				   </xsl:call-template>
	        			</xsl:with-param>
	         	</xsl:call-template>  
     	  </xsl:when>
     	  <xsl:otherwise>
     	   <xsl:call-template name="tabgroup-wrapper">
	        <!-- Tab 0_1 - Advising Bank  -->
	        <xsl:with-param name="tab0-label">XSL_BANKDETAILS_TAB_ADVISING_BANK</xsl:with-param>
	        <xsl:with-param name="tab0-content">
	          <xsl:call-template name="column-container">
                 <xsl:with-param name="content">			 
                    <xsl:call-template name="column-wrapper">
                      <xsl:with-param name="content">
				         <xsl:apply-templates select="advising_bank">
				          <xsl:with-param name="theNodeName">advising_bank</xsl:with-param>
				         </xsl:apply-templates>
				         <xsl:call-template name="checkbox-field">
					      <xsl:with-param name="label">XSL_ADVISING_BANK_CONFIRMATION_REQUIRED</xsl:with-param>
					      <xsl:with-param name="name">adv_bank_conf_req</xsl:with-param>
					     </xsl:call-template>
					   </xsl:with-param>
					   </xsl:call-template>
					 <xsl:call-template name="column-wrapper">
                      <xsl:with-param name="content">
				         <xsl:apply-templates select="original_xml/bg_tnx_record/advising_bank">
				          <xsl:with-param name="theNodeName">advising_bank</xsl:with-param>
				         </xsl:apply-templates>
				         <xsl:call-template name="checkbox-field">
					      <xsl:with-param name="label">XSL_ADVISING_BANK_CONFIRMATION_REQUIRED</xsl:with-param>
					      <xsl:with-param name="name">original_xml/bg_tnx_record/adv_bank_conf_req</xsl:with-param>
					     </xsl:call-template>
					   </xsl:with-param>
					   </xsl:call-template>
					   </xsl:with-param>
					   </xsl:call-template>
	        </xsl:with-param>
    
	        <!-- Tab 0_2 - Confirming Bank  -->
	        <xsl:with-param name="tab1-label">XSL_BANKDETAILS_TAB_CONFIRMING_BANK</xsl:with-param>
	        <xsl:with-param name="tab1-content">
	            <xsl:call-template name="column-container">
                    <xsl:with-param name="content">			 
         				<xsl:call-template name="column-wrapper">
            				 <xsl:with-param name="content">
					         <xsl:apply-templates select="confirming_bank">
					          <xsl:with-param name="theNodeName">confirming_bank</xsl:with-param>
					         </xsl:apply-templates>
					         </xsl:with-param>
					         </xsl:call-template>
					         
					      <xsl:call-template name="column-wrapper">
            				 <xsl:with-param name="content">
					         <xsl:apply-templates select="original_xml/bg_tnx_record/confirming_bank">
					          <xsl:with-param name="theNodeName">confirming_bank</xsl:with-param>
					         </xsl:apply-templates>
					         </xsl:with-param>
					         </xsl:call-template>   
					         </xsl:with-param>
					         </xsl:call-template>
	                         </xsl:with-param>
	       		</xsl:call-template>  
     	  </xsl:otherwise>
     	 </xsl:choose>
     </xsl:with-param> 
   </xsl:call-template>
   
    <xsl:call-template name="bg-guarantee-details-new">
          
      	 <xsl:with-param name="pdfOption">
          <xsl:choose>
		   <xsl:when test="security:isBank($rundata)">PDF_BG_DOCUMENT_DETAILS_BANK</xsl:when>
		   <xsl:otherwise>PDF_BG_DOCUMENT_DETAILS</xsl:otherwise>
		  </xsl:choose>
         </xsl:with-param>
      </xsl:call-template>

      <xsl:call-template name="bank-instructions-new">
      	<xsl:with-param name="send-mode-displayed">Y</xsl:with-param>
		<xsl:with-param name="send-mode-required">Y</xsl:with-param>
		<xsl:with-param name="send-mode-label">XSL_GUARANTEE_DELIVERY_MODE</xsl:with-param>
        <xsl:with-param name="delivery-to-shown">Y</xsl:with-param>
        <xsl:with-param name="delivery-channel-displayed">Y</xsl:with-param>
      </xsl:call-template>
      <!-- comments for return -->
      <xsl:if test="tnx_stat_code[.!='03' and .!='04']">   <!-- MPS-43899 -->
      <xsl:call-template name="comments-for-return-new">
	  		<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
	   		<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
   	  </xsl:call-template>
   	  </xsl:if>
     </xsl:with-param>
    </xsl:call-template>
    
    
     <!-- Attach files. -->  
     
    <xsl:if test="$displaymode = 'edit' or ($displaymode = 'view' and $mode = 'UNSIGNED')">
    	<xsl:call-template name="attachments-file-dojo">
    		<xsl:with-param name="callback">if(misys._config.customerBanksMT798Channel[dijit.byId("recipient_bank_abbv_name").get("value")] == true &amp;&amp; misys.hasAttachments() &amp;&amp; dijit.byId("adv_send_mode").get("value") == '01'){dijit.byId("delivery_channel").set("disabled", false); dijit.byId("delivery_channel").set("required", true);dijit.byId("delivery_channel").set("readOnly", false);}</xsl:with-param>
    		<xsl:with-param name="title-size">35</xsl:with-param>   		
    	</xsl:call-template>
    </xsl:if>
    
   
   <xsl:call-template name="realform"/>    
   
   <xsl:call-template name="menu">
     <xsl:with-param name="second-menu">Y</xsl:with-param>
     <xsl:with-param name="show-return">Y</xsl:with-param>
    </xsl:call-template>
  </div>

  
 </xsl:template>
  <!--
    BG General Details Fieldset.
  -->
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
			     <xsl:with-param name="path" select="/bg_tnx_record"/> 
			     </xsl:call-template>

			   <!-- BG Details. -->
			        <xsl:call-template name="bg-details-new">
			     <xsl:with-param name="path" select="/bg_tnx_record"/> 
			     </xsl:call-template> 

     		<xsl:call-template name="alternativeapplicantaddress" >
     		<xsl:with-param name="path" select="/bg_tnx_record"/> 
     		</xsl:call-template>
     
		     <!-- Beneficiary Details -->
     
       </xsl:with-param>
    </xsl:call-template>
    
    <!-- second Column -->
   
     <xsl:call-template name="column-wrapper">
         <xsl:with-param name="content">
			     <!-- Common general details. -->
			     <xsl:call-template name="common-general-details-new">
			     <xsl:with-param name="path" select="/bg_tnx_record/original_xml/bg_tnx_record"/>
			     </xsl:call-template>
			     <!-- BG Details. -->
			 <xsl:call-template name="bg-details-new">
			     <xsl:with-param name="path" select="/bg_tnx_record/original_xml/bg_tnx_record"/>
			     </xsl:call-template>

     		<xsl:call-template name="alternativeapplicantaddress" >
     		<xsl:with-param name="path" select="/bg_tnx_record/original_xml/bg_tnx_record"/> 
     		</xsl:call-template>
     
       </xsl:with-param>
    </xsl:call-template>
    </xsl:with-param>
    </xsl:call-template>  
    </xsl:with-param>
  </xsl:call-template>
  </xsl:template>
  
  
    <!-- Applicant Details -->
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
						          <xsl:with-param name="path" select="/bg_tnx_record"/> 
						        </xsl:call-template>
				       </xsl:with-param>
				      </xsl:call-template>
				       <!-- second column -->
				       <xsl:call-template name="column-wrapper">
                          <xsl:with-param name="content">                         
						       <xsl:call-template name="applicantaddress">
						       <xsl:with-param name="path" select="/bg_tnx_record/original_xml/bg_tnx_record"/> 
					    </xsl:call-template>			      
				       </xsl:with-param>
				     </xsl:call-template>
				   </xsl:with-param>
				</xsl:call-template>
		      </xsl:with-param>
		     </xsl:call-template>
   </xsl:template>

  
    <!-- 
   BG Details 
  -->
  <xsl:template name="bg-details-new">
   <xsl:param name="path"></xsl:param>
  
   <xsl:call-template name="select-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_EFFECTIVE_DATE_TYPE</xsl:with-param>
    <xsl:with-param name="name">iss_date_type_code</xsl:with-param>
    <xsl:with-param name="fieldsize">x-large</xsl:with-param>
    <xsl:with-param name="required">Y</xsl:with-param>
    <xsl:with-param name="options">
       <xsl:if test="common:node-set($path)/iss_date_type_code[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_UPON_ISSUANCE')"/></xsl:if>
     <xsl:if test="common:node-set($path)/iss_date_type_code[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_UPON_CONTRACT_SIGN')"/></xsl:if>
     <xsl:if test="common:node-set($path)/iss_date_type_code[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_UPON_ADV_PAYMT')"/></xsl:if>
     <xsl:if test="common:node-set($path)/iss_date_type_code[. = '99']"> <xsl:value-of select="iss_date_type_details"/></xsl:if>
    
    </xsl:with-param>
   </xsl:call-template>
   <xsl:if test="$displaymode='view' and (not(common:node-set($path)/tnx_id) or common:node-set($path)/tnx_type_code[.!='01'])">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
     <xsl:with-param name="name">iss_date</xsl:with-param>
     <xsl:with-param name="value" select="common:node-set($path)/iss_date" />
    </xsl:call-template>
   </xsl:if>
   <xsl:call-template name="select-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
    <xsl:with-param name="name">exp_date_type_code</xsl:with-param>
     <xsl:with-param name="value" select="common:node-set($path)/exp_date_type_code" />
    <xsl:with-param name="required">Y</xsl:with-param>
    <xsl:with-param name="options">     
     <xsl:if test="common:node-set($path)/exp_date_type_code[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_FIXED')"/></xsl:if>
      <xsl:if test="common:node-set($path)/exp_date_type_code[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_PROJECTED')"/></xsl:if>
    </xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="input-field">
    <xsl:with-param name="name">exp_date</xsl:with-param>
     <xsl:with-param name="value" select="common:node-set($path)/exp_date" />
    <xsl:with-param name="fieldsize">small</xsl:with-param>
    <xsl:with-param name="size">10</xsl:with-param>
    <xsl:with-param name="maxsize">10</xsl:with-param>
    <xsl:with-param name="type">date</xsl:with-param>
    <xsl:with-param name="required">Y</xsl:with-param>
   </xsl:call-template>
   
   <xsl:call-template name="row-wrapper">
      <xsl:with-param name="id">exp_event</xsl:with-param>
      <xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_EVENT</xsl:with-param>
      <xsl:with-param name="type">textarea</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:call-template name="textarea-field">
        <xsl:with-param name="name">exp_event</xsl:with-param>
        <xsl:with-param name="value" select="common:node-set($path)/exp_event" />
        <xsl:with-param name="button-type"></xsl:with-param>
        <xsl:with-param name="rows">4</xsl:with-param>
        <xsl:with-param name="cols">35</xsl:with-param>
        <xsl:with-param name="maxlines">4</xsl:with-param>
       </xsl:call-template>
      </xsl:with-param>
   </xsl:call-template>
   <xsl:call-template name="checkbox-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_REDUCTION_AUTHORISED</xsl:with-param>
     <xsl:with-param name="name">reduction_authorised</xsl:with-param>
      <xsl:with-param name="value" select="common:node-set($path)/reduction_authorised" />     
   </xsl:call-template>
   <xsl:call-template name="select-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_REDUCTION_CLAUSE</xsl:with-param>
     <xsl:with-param name="name">reduction_clause</xsl:with-param>
     <xsl:with-param name="value" select="common:node-set($path)/reduction_clause" /> 
     <xsl:with-param name="options">
     <xsl:if test="common:node-set($path)/reduction_clause[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REDUCTION_PER_DELIVERIES')"/></xsl:if>
      <xsl:if test="common:node-set($path)/reduction_clause[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REDUCTION_UPON_REALISATION')"/></xsl:if>
      <xsl:if test="common:node-set($path)/reduction_clause[. = '03']"><xsl:value-of select="reduction_clause_other"/></xsl:if>
   </xsl:with-param>
   </xsl:call-template>
   <xsl:if test="$displaymode='edit'">
    <xsl:call-template name="input-field">
      <xsl:with-param name="name">reduction_clause_other</xsl:with-param>
      <xsl:with-param name="value" select="common:node-set($path)/reduction_clause_other" /> 
      <xsl:with-param name="maxsize">35</xsl:with-param>
      <xsl:with-param name="readonly">Y</xsl:with-param>
    </xsl:call-template>
   </xsl:if>
    
  </xsl:template> 
  
   <!-- 
  BG Start Dates 
  -->
  <xsl:template name="bg-start-dates-new">
   <xsl:param name="path"></xsl:param>
     <xsl:if test="common:node-set($path)/iss_date_type_code[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_UPON_ISSUANCE')"/></xsl:if>
     <xsl:if test="common:node-set($path)/iss_date_type_code[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_UPON_CONTRACT_SIGN')"/></xsl:if>
     <xsl:if test="common:node-set($path)/iss_date_type_code[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_START_UPON_ADV_PAYMT')"/></xsl:if>
     <xsl:if test="common:node-set($path)/iss_date_type_code[. = '99']"> <xsl:value-of select="iss_date_type_details"/></xsl:if>
 </xsl:template>

    <!-- BG Amount Details -->
  <xsl:template name="bg-amt-details">
   <xsl:param name="override-product-code"/>
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
    
     <xsl:call-template name="column-container">
      <xsl:with-param name="content">
	     <xsl:call-template name="column-wrapper">
	        <xsl:with-param name="content">
	          <xsl:call-template name="amt-details">
	            <xsl:with-param name="path" select="/bg_tnx_record"/> 
	          </xsl:call-template>
	       </xsl:with-param>
	      </xsl:call-template>
        
	      <xsl:call-template name="column-wrapper">
	        <xsl:with-param name="content">
	          <xsl:call-template name="amt-details">
	            <xsl:with-param name="path" select="/bg_tnx_record/original_xml/bg_tnx_record"/> 
	          </xsl:call-template>
	       </xsl:with-param>
	      </xsl:call-template>
     </xsl:with-param>
      </xsl:call-template>
       </xsl:with-param>       
    
   </xsl:call-template>
  </xsl:template>
  
  
  <xsl:template name="amt-details">
     <xsl:param name="path"></xsl:param>
          <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_AMOUNTDETAILS_GTEE_AMT_LABEL</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="common:node-set($path)/bg_cur_code"/> <xsl:value-of select="common:node-set($path)/bg_amt"/></xsl:with-param>
      <xsl:with-param name="required">Y</xsl:with-param>
     </xsl:call-template>
     <!-- Displayed in details summary view -->
     <xsl:if test="$displaymode='view'">
     <!--  <xsl:variable name="field-name">original_xml/bg_tnx_record/bg_liab_amt</xsl:variable> -->
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
      <!--  <xsl:with-param name="name"><xsl:value-of select="$override-product-code"/>original_xml/bg_tnx_record/bg_liab_amt</xsl:with-param> -->
       <xsl:with-param name="override-displaymode">view</xsl:with-param>
       <xsl:with-param name="value">
         <xsl:variable name="field-value"><xsl:value-of select="common:node-set($path)/bg_liab_amt"/></xsl:variable>
        <!--  <xsl:variable name="curcode-field-name"><xsl:value-of select="$override-product-code"/>_cur_code</xsl:variable> -->
         <xsl:variable name="curcode-field-value"><xsl:value-of select="common:node-set($path)/bg_cur_code"/></xsl:variable>
	     <xsl:if test="$field-value !=''">
	      <xsl:value-of select="$curcode-field-value"></xsl:value-of>&nbsp;<xsl:value-of select="$field-value"></xsl:value-of>
	     </xsl:if>
	   </xsl:with-param>
      </xsl:call-template>
     </xsl:if>

		<div id="consortium_details">
			<!-- Consortium Details -->
			<xsl:call-template name="checkbox-field">
			<xsl:with-param name="label">XSL_AMOUNTDETAILS_CONSORTIUM</xsl:with-param>
			<xsl:with-param name="name">consortium</xsl:with-param>  
			<xsl:with-param name="value">
				<xsl:choose>
					<xsl:when test="common:node-set($path)/consortium = ''">N</xsl:when>
					<xsl:otherwise><xsl:value-of select="common:node-set($path)/consortium"></xsl:value-of></xsl:otherwise>
				</xsl:choose>
			</xsl:with-param> 				
			</xsl:call-template>
	          
			<xsl:call-template name="row-wrapper">
				<xsl:with-param name="id">consortium_details</xsl:with-param>
				<xsl:with-param name="label">XSL_CONSORTIUM_DETAILS_LABEL</xsl:with-param>
				<xsl:with-param name="type">textarea</xsl:with-param>
				<xsl:with-param name="content">
					<xsl:call-template name="input-field">
						<xsl:with-param name="name">consortium_details</xsl:with-param>
						  <xsl:with-param name="value" select="common:node-set($path)/consortium_details" />
						<xsl:with-param name="button-type"></xsl:with-param>
						<xsl:with-param name="rows">6</xsl:with-param>
						<xsl:with-param name="cols">35</xsl:with-param>
						<xsl:with-param name="maxlines">6</xsl:with-param>        
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
	          
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_AMOUNTDETAILS_NET_EXPOSUER_LABEL</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="common:node-set($path)/net_exposure_cur_code"/> <xsl:value-of select="original_xml/bg_tnx_record/net_exposure_amt"/></xsl:with-param>				   
			</xsl:call-template>
		</div>     
     
		<!-- Charges -->
		<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_CHRGDETAILS_BG_ISS_LABEL</xsl:with-param>
		<xsl:with-param name="value">
		<xsl:if test="common:node-set($path)/open_chrg_brn_by_code [. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_FT_APPLICANT')"/></xsl:if>
		<xsl:if test="common:node-set($path)/open_chrg_brn_by_code [. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_FT_BENEFICIARY')"/></xsl:if>
		</xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="input-field">
		<xsl:with-param name="label">XSL_CHRGDETAILS_BG_CORR_LABEL</xsl:with-param>
		<xsl:with-param name="value">
		<xsl:if test="common:node-set($path)/corr_chrg_brn_by_code [. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_FT_APPLICANT')"/></xsl:if>
		<xsl:if test="common:node-set($path)/corr_chrg_brn_by_code [. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_FT_BENEFICIARY')"/></xsl:if>
		</xsl:with-param>
		</xsl:call-template>
		
  
  </xsl:template>
  <!-- common change -->
     <!-- 
   	BG Alternative Applicant Details
   -->
 

  

  
  <!--
   BG Realform
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
      <xsl:call-template name="e2ee_transaction"/>
   <xsl:call-template name="reauth_params"/>
      </div>
     </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
  
   <!--  BG Reduction Clause -->
  <xsl:template name="bg-reduction-clause-new">
   <xsl:param name="path"></xsl:param>
      <xsl:if test="common:node-set($path)/reduction_clause[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REDUCTION_PER_DELIVERIES')"/></xsl:if>
      <xsl:if test="common:node-set($path)/reduction_clause[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REDUCTION_UPON_REALISATION')"/></xsl:if>
      <xsl:if test="common:node-set($path)/reduction_clause[. = '03']"><xsl:value-of select="reduction_clause_other"/></xsl:if>
  </xsl:template>
 
   <xsl:template name="bg-exp-dates-new">   
     <xsl:param name="path"></xsl:param>
      <xsl:if test="common:node-set($path)/exp_date_type_code[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_FIXED')"/></xsl:if>
      <xsl:if test="common:node-set($path)/exp_date_type_code[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_END_DATE_PROJECTED')"/></xsl:if>
  </xsl:template>
  
   <xsl:template name="applicantaddress"> 
     <xsl:param name="path"></xsl:param>
     
      <xsl:if test="not(common:node-set($path)/avail_main_banks/bank/entity/customer_reference) and not(common:node-set($path)/avail_main_banks/bank/customer_reference)">
		<xsl:call-template name="input-field">
		    <xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
		    <xsl:with-param name="name">applicant_reference</xsl:with-param>
		    <xsl:with-param name="value" select="common:node-set($path)/applicant_reference"></xsl:with-param>
		    <xsl:with-param name="maxsize">34</xsl:with-param>
	     </xsl:call-template>		        
	   </xsl:if>
     
	    <xsl:call-template name="input-field">
	    	<xsl:with-param name="label">XSL_PARTIESDETAILS_ENTITY</xsl:with-param>
	    	<xsl:with-param name="name">entity</xsl:with-param>
	    	<xsl:with-param name="value" select="common:node-set($path)/entity"/>
   		</xsl:call-template>
     
       <xsl:call-template name="input-field">
		     <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
		     <xsl:with-param name="name">applicant_name</xsl:with-param>
		     <xsl:with-param name="value"><xsl:value-of select ="common:node-set($path)/applicant_name"/></xsl:with-param>
	    </xsl:call-template>
	    
	    <xsl:call-template name="input-field">
		    <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
		    <xsl:with-param name="name"><xsl:value-of select="applicant_address_line_1"/></xsl:with-param>
		    <xsl:with-param name="value" select="common:node-set($path)/applicant_address_line_1"/>		   
	   </xsl:call-template>
	   <xsl:call-template name="input-field">
		    
		    <xsl:with-param name="name"><xsl:value-of select="applicant_address_line_2"/></xsl:with-param>
		    <xsl:with-param name="value" select="common:node-set($path)/applicant_address_line_2"/>
	   </xsl:call-template>
	   
	   <xsl:call-template name="input-field">		   
		    <xsl:with-param name="name"><xsl:value-of select="applicant_dom"/></xsl:with-param>
		    <xsl:with-param name="value" select="common:node-set($path)/applicant_dom"/>
	   </xsl:call-template>
	   
	   <xsl:call-template name="input-field">
		    
		    <xsl:with-param name="name"><xsl:value-of select="applicant_address_line_4"/></xsl:with-param>
		    <xsl:with-param name="value" select="common:node-set($path)/applicant_address_line_4"/>
	   </xsl:call-template>
	   
	      <xsl:variable name="applicant_country"><xsl:value-of select ="common:node-set($path)/applicant_country"/></xsl:variable>
   	  	<xsl:call-template name="input-field">
	    	<xsl:with-param name="label">XSL_PARTIESDETAILS_CONTRY</xsl:with-param>
	    	<xsl:with-param name="name">country</xsl:with-param>
	    	<xsl:with-param name="value" select="localization:getCodeData($language,'*','*','C006',$applicant_country)"/>
   		</xsl:call-template>
  </xsl:template>
  
  
     <xsl:template name="alternativeapplicantaddress">  
      <xsl:param name="path"></xsl:param>
     <xsl:call-template name="checkbox-field">
     <xsl:with-param name="label">XSL_FOR_THE_ACCOUNT_OF</xsl:with-param>
     <xsl:with-param name="name">for_account</xsl:with-param>
     <xsl:with-param name="value" select="common:node-set($path)/for_account"></xsl:with-param>
    </xsl:call-template>
     
       <xsl:call-template name="input-field">
		     <xsl:with-param name="label">XSL_PARTIESDETAILS_ALT_APPLICANT_NAME</xsl:with-param>
		     <xsl:with-param name="name">alt_applicant_name</xsl:with-param>
		     <xsl:with-param name="value"><xsl:value-of select ="common:node-set($path)/alt_applicant_name"/></xsl:with-param>
	    </xsl:call-template>
	    
	    <xsl:call-template name="input-field">
		    <xsl:with-param name="label">XSL_PARTIESDETAILS_ALT_APPLICANT_ADDRESS</xsl:with-param>
		    <xsl:with-param name="name"><xsl:value-of select="applicant_address_line_1"/></xsl:with-param>
		    <xsl:with-param name="value" select="common:node-set($path)/alt_applicant_address_line_1"/>		   
	   </xsl:call-template>
	   <xsl:call-template name="input-field">
		    
		    <xsl:with-param name="name">applicant_address_line_2</xsl:with-param>
		    <xsl:with-param name="value" select="common:node-set($path)/alt_applicant_address_line_2"/>
	   </xsl:call-template>
	      <xsl:variable name="applicant_country" select="common:node-set($path)/alt_applicant_country"></xsl:variable>
   	  	<xsl:call-template name="input-field">
	    	<xsl:with-param name="label">XSL_PARTIESDETAILS_ALT_APPLICANT_COUNTRY</xsl:with-param>
	    	<xsl:with-param name="name">country</xsl:with-param>
	    	<xsl:with-param name="value" select="localization:getCodeData($language,'*','*','C006',$applicant_country)"/>
   		</xsl:call-template>
	   <xsl:call-template name="input-field">		   
		    <xsl:with-param name="name">applicant_dom</xsl:with-param>
		    <xsl:with-param name="value" select="common:node-set($path)/alt_applicant_dom"/>
	   </xsl:call-template>
	   <xsl:call-template name="input-field">
		    
		    <xsl:with-param name="name">applicant_address_line_4</xsl:with-param>
		    <xsl:with-param name="value" select="common:node-set($path)/alt_applicant_address_line_4"/>
	   </xsl:call-template>
   
  </xsl:template>
  
  
     <xsl:template name="beneficiaryaddress">
     
      <xsl:param name="path"></xsl:param>   
     	
       <xsl:call-template name="input-field">
		     <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
		     <xsl:with-param name="name">applicant_name</xsl:with-param>
		     <xsl:with-param name="value"><xsl:value-of select ="common:node-set($path)/beneficiary_name"/></xsl:with-param>
	    </xsl:call-template>
	    
	    <xsl:call-template name="input-field">
		    <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
		    <xsl:with-param name="name"><xsl:value-of select="applicant_address_line_1"/></xsl:with-param>
		    <xsl:with-param name="value" select="common:node-set($path)/beneficiary_address_line_1"/>		   
	   </xsl:call-template>
	   <xsl:call-template name="input-field">
		    
		    <xsl:with-param name="name"><xsl:value-of select="applicant_address_line_2"/></xsl:with-param>
		    <xsl:with-param name="value" select="common:node-set($path)/beneficiary_address_line_2"/>
	   </xsl:call-template>
	   <xsl:call-template name="input-field">		   
		    <xsl:with-param name="name"><xsl:value-of select="applicant_dom"/></xsl:with-param>
		    <xsl:with-param name="value" select="common:node-set($path)/beneficiary_dom"/>
	   </xsl:call-template>
	   <xsl:call-template name="input-field">
		    
		    <xsl:with-param name="name"><xsl:value-of select="applicant_address_line_4"/></xsl:with-param>
		    <xsl:with-param name="value" select="common:node-set($path)/beneficiary_address_line_4"/>
	   </xsl:call-template>
	   
	    <xsl:variable name="applicant_country"><xsl:value-of select ="common:node-set($path)/beneficiary_country"/></xsl:variable>
   	  	<xsl:call-template name="input-field">
	    	<xsl:with-param name="label">XSL_PARTIESDETAILS_CONTRY</xsl:with-param>
	    	<xsl:with-param name="name">country</xsl:with-param>
	    	<xsl:with-param name="value" select="localization:getCodeData($language,'*','*','C006',$applicant_country)"/>
   		</xsl:call-template>
	   
	   <xsl:call-template name="input-field">
		     <xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
		     <xsl:with-param name="name">beneficiary_reference</xsl:with-param>
		     <xsl:with-param name="value" select="common:node-set($path)/beneficiary_reference"/>
	    </xsl:call-template>
   
  </xsl:template>
  
  
   <xsl:template name="contactaddress">   
     <xsl:param name="path"></xsl:param>  
       <xsl:call-template name="input-field">
		     <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
		     <xsl:with-param name="name">applicant_name</xsl:with-param>
		     <xsl:with-param name="value"><xsl:value-of select ="common:node-set($path)/contact_name"/></xsl:with-param>
	    </xsl:call-template>
	    
	    <xsl:call-template name="input-field">
		    <xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
		    <xsl:with-param name="name"><xsl:value-of select="applicant_address_line_1"/></xsl:with-param>
		    <xsl:with-param name="value" select="common:node-set($path)/contact_address_line_1"/>		   
	   </xsl:call-template>
	   <xsl:call-template name="input-field">
		    
		    <xsl:with-param name="name"><xsl:value-of select="applicant_address_line_2"/></xsl:with-param>
		    <xsl:with-param name="value" select="common:node-set($path)/contact_address_line_2"/>
	   </xsl:call-template>
	   <xsl:call-template name="input-field">		   
		    <xsl:with-param name="name"><xsl:value-of select="applicant_dom"/></xsl:with-param>
		    <xsl:with-param name="value" select="common:node-set($path)/contact_dom"/>
	   </xsl:call-template>
	   <xsl:call-template name="input-field">
		    
		    <xsl:with-param name="name"><xsl:value-of select="applicant_address_line_4"/></xsl:with-param>
		    <xsl:with-param name="value" select="common:node-set($path)/contact_address_line_4"/>
	   </xsl:call-template>
	   
	    <xsl:variable name="applicant_country"><xsl:value-of select ="common:node-set($path)/contact_country"/></xsl:variable>
   	  	<xsl:call-template name="input-field">
	    	<xsl:with-param name="label">XSL_PARTIESDETAILS_CONTRY</xsl:with-param>
	    	<xsl:with-param name="name">country</xsl:with-param>
	    	<xsl:with-param name="value" select="localization:getCodeData($language,'*','*','C006',$applicant_country)"/>
   		</xsl:call-template>

   
  </xsl:template>
  

 
   <xsl:template name="common-general-details-new">
   <xsl:param name="show-template-id">Y</xsl:param>
   <xsl:param name="show-cust-ref-id">Y</xsl:param>
   <xsl:param name="cross-ref-summary-option"></xsl:param>
   <xsl:param name="path"></xsl:param>


   <!--  System ID. -->
   <xsl:call-template name="input-field">
    <xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
    <xsl:with-param name="id">general_ref_id_view</xsl:with-param>
    <xsl:with-param name="value" select="common:node-set($path)/ref_id" />
    <xsl:with-param name="override-displaymode">view</xsl:with-param>
   </xsl:call-template>
   
   <!-- Bank Reference -->
   <!-- Shown in consolidated view -->
   <xsl:if test="$displaymode='view' and (common:node-set($path)/bo_ref_id)!='' and (not(common:node-set($path)/tnx_id) or (common:node-set($path)/tnx_type_code[.!='01']) or (common:node-set($path)/tnx_type_code/preallocated_flag[.='Y']))">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
     <xsl:with-param name="id">general_bo_ref_id_view</xsl:with-param>
     <xsl:with-param name="value" select="common:node-set($path)/bo_ref_id" />
    </xsl:call-template>
   </xsl:if>
   
   <!-- Cross Refs -->
   <!-- Shown in consolidated view  -->
   <xsl:if test="cross_references">
     <xsl:apply-templates select="common:node-set($path)/cross_references" mode="display_table_tnx">
     	<xsl:with-param name="cross-ref-summary-option"><xsl:value-of select="$cross-ref-summary-option"/></xsl:with-param>
    </xsl:apply-templates>
   </xsl:if>
    
   <!-- Template ID. -->
   <xsl:if test="$show-template-id='Y'">
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_TEMPLATE_ID</xsl:with-param>
     <xsl:with-param name="name">template_id</xsl:with-param>
     <xsl:with-param name="value" select="common:node-set($path)/template_id"></xsl:with-param>
     <xsl:with-param name="size">15</xsl:with-param>
     <xsl:with-param name="maxsize">20</xsl:with-param>
     <xsl:with-param name="fieldsize">small</xsl:with-param>
     <xsl:with-param name="swift-validate">N</xsl:with-param>
    </xsl:call-template>
   </xsl:if>
    
    <!-- Customer reference -->
    <xsl:if test="$show-cust-ref-id='Y'">
	    <xsl:call-template name="input-field">
	     <xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>
	     <xsl:with-param name="name">cust_ref_id</xsl:with-param>
	     <xsl:with-param name="value" select ="common:node-set($path)/cust_ref_id"></xsl:with-param>
	     <xsl:with-param name="size">20</xsl:with-param>
	     <xsl:with-param name="maxsize">34</xsl:with-param>
	    </xsl:call-template>
    </xsl:if>
    
    <!--  Application date. -->
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
     <xsl:with-param name="id">appl_date_view</xsl:with-param>
     <xsl:with-param name="value" select="common:node-set($path)/appl_date"></xsl:with-param>
	 <xsl:with-param name="type">date</xsl:with-param>
     <xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
  
  
 <!-- common one bg-common.xsl -->
 
   <xsl:template name="bg-renewal-details-new">
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_RENEWAL_DETAILS_LABEL</xsl:with-param>
    <xsl:with-param name="content">
      <xsl:call-template name="column-container">
       <xsl:with-param name="content">			 
         <xsl:call-template name="column-wrapper">
             <xsl:with-param name="content">
             <xsl:call-template name="renewal-details">
             <xsl:with-param name="path" select="/bg_tnx_record"/> 
             </xsl:call-template>
              </xsl:with-param>
        </xsl:call-template>
     
       <xsl:call-template name="column-wrapper">
         <xsl:with-param name="content">
            <xsl:call-template name="renewal-details">
             <xsl:with-param name="path" select="/bg_tnx_record/original_xml/bg_tnx_record"/> 
             </xsl:call-template>
     
         </xsl:with-param>
       </xsl:call-template>
     
     </xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  <!-- common of common.xsl -->
  
  
  <xsl:template name="renewal-details">
    
 		<xsl:param name="path"></xsl:param>
          <xsl:call-template name="select-field">
      <xsl:with-param name="label">XSL_RENEWAL_RENEW_ON</xsl:with-param>
      <xsl:with-param name="name">renew_on_code</xsl:with-param>
      <xsl:with-param name="value" select ="common:node-set($path)/renew_on_code"/>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="readonly">Y</xsl:with-param>
      <xsl:with-param name="options">
       <xsl:choose>
        <xsl:when test="$displaymode='edit'">
	       <option value="01">
	        <xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EXPIRY')"/>
	       </option>
	       <option value="02">
	       <xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_CALENDAR')"/>
	       </option>
        </xsl:when>
        <xsl:otherwise>
         <xsl:choose>
          <xsl:when test="common:node-set($path)/renew_on_code[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EXPIRY')"/></xsl:when>
          <xsl:when test="common:node-set($path)/renew_on_code[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_CALENDAR')"/></xsl:when>
         </xsl:choose>
        </xsl:otherwise>
       </xsl:choose>
      </xsl:with-param>
     </xsl:call-template> 
     <xsl:call-template name="input-field">
     <xsl:with-param name="name">renewal_calendar_date</xsl:with-param>
     <xsl:with-param name="value" select="common:node-set($path)/renewal_calendar_date"></xsl:with-param> 
     <xsl:with-param name="fieldsize">small</xsl:with-param>
     <xsl:with-param name="size">10</xsl:with-param>
     <xsl:with-param name="maxsize">10</xsl:with-param>
     <xsl:with-param name="readonly">Y</xsl:with-param>
     <xsl:with-param name="type">date</xsl:with-param>
    </xsl:call-template>
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_RENEWAL_RENEW_FOR</xsl:with-param>
       <xsl:with-param name="name">renew_for_nb</xsl:with-param>
       <xsl:with-param name="value"  select="common:node-set($path)/renew_for_nb"></xsl:with-param> 
       <xsl:with-param name="fieldsize">x-small</xsl:with-param>
       <xsl:with-param name="size">3</xsl:with-param>
       <xsl:with-param name="maxsize">3</xsl:with-param>
       <xsl:with-param name="override-constraints">{min:0,max:999}</xsl:with-param>
       <xsl:with-param name="readonly">Y</xsl:with-param>
       <xsl:with-param name="type">integer</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="select-field">
       <xsl:with-param name="name">renew_for_period</xsl:with-param>
       <xsl:with-param name="value"  select="common:node-set($path)/renew_for_period"></xsl:with-param> 
       <xsl:with-param name="fieldsize">small</xsl:with-param>
       <xsl:with-param name="readonly">Y</xsl:with-param>
       <xsl:with-param name="options">
       <xsl:if test="common:node-set($path)/renew_for_period[. = 'D']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_DAYS')"/></xsl:if>
      <xsl:if test="common:node-set($path)/renew_for_period[. = 'W']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_WEEKS')"/></xsl:if>
      <xsl:if test="common:node-set($path)/renew_for_period[. = 'M']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_MONTHS')"/></xsl:if>
      <xsl:if test="common:node-set($path)/renew_for_period[. = 'Y']"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_YEARS')"/></xsl:if>
      </xsl:with-param>
     </xsl:call-template>
	
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_RENEWAL_DAYS_NOTICE</xsl:with-param>
      <xsl:with-param name="name">advise_renewal_days_nb</xsl:with-param>
      <xsl:with-param name="value"  select="common:node-set($path)/advise_renewal_days_nb"></xsl:with-param> 
      <xsl:with-param name="fieldsize">x-small</xsl:with-param>
      <xsl:with-param name="size">3</xsl:with-param>
      <xsl:with-param name="maxsize">3</xsl:with-param>
      <xsl:with-param name="override-constraints">{min:0, max:999}</xsl:with-param>
      <xsl:with-param name="readonly">Y</xsl:with-param>
      <xsl:with-param name="type">integer</xsl:with-param>
     </xsl:call-template>
   
     <xsl:call-template name="input-field">
      <xsl:with-param name="name">rolling_renewal_nb</xsl:with-param>
      <xsl:with-param name="label">XSL_RENEWAL_NUMBER_RENEWALS</xsl:with-param>
      <xsl:with-param name="value"  select="common:node-set($path)/rolling_renewal_nb"></xsl:with-param> 
      <xsl:with-param name="fieldsize">x-small</xsl:with-param>
      <xsl:with-param name="size">3</xsl:with-param>
      <xsl:with-param name="maxsize">3</xsl:with-param>
      <xsl:with-param name="override-constraints">{min:0, max:999}</xsl:with-param>
      <xsl:with-param name="readonly">Y</xsl:with-param>
      <xsl:with-param name="type">integer</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="name">rolling_cancellation_days</xsl:with-param>
      <xsl:with-param name="label">XSL_RENEWAL_CANCELLATION_NOTICE</xsl:with-param>
      <xsl:with-param name="value"  select="common:node-set($path)/rolling_cancellation_days"></xsl:with-param> 
      <xsl:with-param name="fieldsize">x-small</xsl:with-param>
      <xsl:with-param name="size">3</xsl:with-param>
      <xsl:with-param name="maxsize">3</xsl:with-param>
      <xsl:with-param name="override-constraints">{min:0, max:999}</xsl:with-param>
      <xsl:with-param name="readonly">Y</xsl:with-param>
      <xsl:with-param name="type">integer</xsl:with-param>
     </xsl:call-template>     
     <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_RENEWAL_FINAL_EXP_DATE</xsl:with-param>
     <xsl:with-param name="name">final_expiry_date</xsl:with-param>
     <xsl:with-param name="value"  select="common:node-set($path)/final_expiry_date"></xsl:with-param> 
     <xsl:with-param name="fieldsize">small</xsl:with-param>
     <xsl:with-param name="size">10</xsl:with-param>
     <xsl:with-param name="maxsize">10</xsl:with-param>
     <xsl:with-param name="required">N</xsl:with-param> 
     <xsl:with-param name="type">date</xsl:with-param>
    </xsl:call-template>
     <xsl:if test="common:node-set($path)/renew_amt_code[. = '01']">
     
    <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_RENEWAL_AMOUNT</xsl:with-param>
     <xsl:with-param name="name">renew_amt_code</xsl:with-param>
     <xsl:with-param name="value">OriginalAmount</xsl:with-param>     
     <xsl:with-param name="readonly">Y</xsl:with-param>
    </xsl:call-template>
     
     </xsl:if>
    
      <xsl:if test="common:node-set($path)/renew_amt_code[. = '02']">
     
     <xsl:call-template name="input-field">
     <xsl:with-param name="label">XSL_RENEWAL_AMOUNT</xsl:with-param>
     <xsl:with-param name="name">renew_amt_code</xsl:with-param>
     <xsl:with-param name="value">CurrentAmount</xsl:with-param>     
     <xsl:with-param name="readonly">Y</xsl:with-param>
    </xsl:call-template>
     
    </xsl:if>
  
  </xsl:template>
  
    <!--
   Main Bank Select Box.  
   -->
  <xsl:template name="main-bank-selectbox-new">
   <xsl:param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:param>
   <xsl:param name="main-bank-name"/>
   <xsl:param name="sender-name"/>
   <xsl:param name="sender-reference-name"/>   
    <xsl:param name="path"></xsl:param>
 
   <xsl:variable name="main_bank_abbv_name_value">
    <xsl:value-of select="common:node-set($path)/recipient_bank/abbv_name"/>
   </xsl:variable>
    
   <xsl:variable name="main-bank-name-value">
    <xsl:if test="common:node-set($path)/recipient_bank/name">
     <xsl:value-of select="common:node-set($path)/recipient_bank/name"/>
    </xsl:if>
   </xsl:variable>
  
   <xsl:variable name="sender-reference-value" select="common:node-set($path)/applicant_reference"/>
  
   <!-- Hidden Fields -->
   <xsl:call-template name="hidden-field">
    <xsl:with-param name="name"><xsl:value-of select="$main-bank-name"/>_name</xsl:with-param>
    <xsl:with-param name="value">
     <xsl:choose>
      <xsl:when test="$main-bank-name-value != ''">
       <xsl:value-of select="$main-bank-name-value"/>
      </xsl:when>
      <!-- never used because if only one available main bank, server set it to current main bank -->
      <xsl:when test="count(common:node-set($path)/avail_main_banks/bank)=1"><xsl:value-of select="common:node-set($path)/avail_main_banks/bank/name"/></xsl:when>
      <xsl:otherwise/>
      </xsl:choose>
     </xsl:with-param>
   </xsl:call-template>

  
   <xsl:call-template name="select-field">
    <xsl:with-param name="label" select="$label"/>
    <xsl:with-param name="name"><xsl:value-of select="common:node-set($path)/recipient_bank_abbv_name"/></xsl:with-param>
    <xsl:with-param name="value"><xsl:value-of select="$main_bank_abbv_name_value"/></xsl:with-param>
    <xsl:with-param name="required">Y</xsl:with-param>
    <xsl:with-param name="disabled"><xsl:if test="bg_code[.!='']">Y</xsl:if></xsl:with-param>
    <xsl:with-param name="options">
     <xsl:choose>
      <xsl:when test="$displaymode='edit'"><xsl:apply-templates select="avail_main_banks/bank" mode="main"/></xsl:when>
      <xsl:otherwise><xsl:value-of select="common:node-set($path)/recipient_bank/name"/></xsl:otherwise>
     </xsl:choose>
    </xsl:with-param>
   </xsl:call-template>
   
   <xsl:if test="$displaymode='view'">
     <xsl:call-template name="hidden-field">
      <xsl:with-param name="name">remitting_bank_abbv_name</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="common:node-set($path)/remitting_bank/abbv_name"/></xsl:with-param>
     </xsl:call-template>
   </xsl:if>
  </xsl:template>
  
  <!-- common.xsl -->
  
  
  <!--
   BG Guarantee Details 
   -->
  <xsl:template name="bg-guarantee-details-new">
  	
  	 
  	
   <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_GTEE_DETAILS</xsl:with-param>
    <xsl:with-param name="content">
       <xsl:call-template name="column-container">
       <xsl:with-param name="content">			 
         <xsl:call-template name="column-wrapper">
             <xsl:with-param name="content">
				<xsl:call-template name="gaurantee-details">
	             <xsl:with-param name="path" select="/bg_tnx_record"/> 
	           </xsl:call-template>   
	          
	       </xsl:with-param>
	 </xsl:call-template>
	 
	 <xsl:call-template name="column-wrapper">
             <xsl:with-param name="content">
				    
	           <xsl:call-template name="gaurantee-details">
	             <xsl:with-param name="path" select="/bg_tnx_record/original_xml/bg_tnx_record"/> 
	           </xsl:call-template>
	 </xsl:with-param>
	 </xsl:call-template>
	 
	 </xsl:with-param>
	 </xsl:call-template>
	 
    </xsl:with-param>
   </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="gaurantee-details">
      <xsl:param name="path"></xsl:param>
      <xsl:param name="isBankReporting"/>
       <xsl:param name="pdfOption"/>
       <xsl:variable name="displayProvisionalCheckBox">
			<xsl:choose>
				<xsl:when test="$isBankReporting='Y'">N</xsl:when>
				<xsl:otherwise>Y</xsl:otherwise>
			</xsl:choose>
	  </xsl:variable>
     <xsl:if test="$displaymode='view'">
		      			<xsl:variable name="gtee_type_code"><xsl:value-of select="common:node-set($path)/bg_type_code"></xsl:value-of></xsl:variable>
						<xsl:variable name="productCode"><xsl:value-of select="common:node-set($path)/product_code"/></xsl:variable>
						<xsl:variable name="subProductCode"><xsl:value-of select="common:node-set($path)/sub_product_code"/></xsl:variable>
						<xsl:variable name="parameterId">C011</xsl:variable>
			      		<xsl:call-template name="input-field">
					      <xsl:with-param name="label">XSL_GTEEDETAILS_TYPE_LABEL</xsl:with-param>
					      <xsl:with-param name="name">bg_type_code</xsl:with-param>
					      <xsl:with-param name="required">Y</xsl:with-param>
					      <xsl:with-param name="disabled"><xsl:if test="common:node-set($path)/bg_code[.!='']">Y</xsl:if></xsl:with-param>
					      <xsl:with-param name="value"><xsl:if test="common:node-set($path)/bg_type_code[.!='']"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $gtee_type_code)"/></xsl:if></xsl:with-param>
				      </xsl:call-template>
      				</xsl:if>
			     <xsl:if test="$displayProvisionalCheckBox='Y'">
				     <div id="pro-check-box">
					     <xsl:call-template name="checkbox-field">
						     <xsl:with-param name="label">XSL_PROVISIONAL</xsl:with-param>
						     <xsl:with-param name="name">provisional_status</xsl:with-param>
						     <xsl:with-param name="value" select="common:node-set($path)/provisional_status" ></xsl:with-param>
						 </xsl:call-template>
					 </div>
				 </xsl:if>
			     <div id="bgtypedetails-editor">
				     <xsl:call-template name="input-field">
				      <xsl:with-param name="id">bg_type_details</xsl:with-param>
				      <xsl:with-param name="name">bg_type_details</xsl:with-param>
				       <xsl:with-param name="value" select="common:node-set($path)/bg_type_details" ></xsl:with-param>
				      <xsl:with-param name="maxsize">40</xsl:with-param>
				      <!-- <xsl:with-param name="required">Y</xsl:with-param> -->
				     </xsl:call-template>
			     </div>
			   
			     <xsl:if test="bg_code[.!='']">
			     <xsl:call-template name="input-field">
			      <xsl:with-param name="label">XSL_GUARANTEE_NAME</xsl:with-param>
			      <xsl:with-param name="name">bg_code</xsl:with-param>
			      <xsl:with-param name="value" select="common:node-set($path)/bg_code" ></xsl:with-param>
			      <xsl:with-param name="maxsize">40</xsl:with-param>
			      <xsl:with-param name="readonly">Y</xsl:with-param>
			      <xsl:with-param name="required">Y</xsl:with-param>
			     </xsl:call-template>
			     </xsl:if>

				<!-- BG Text type as hidden field -->
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">bg_text_details_code</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">guarantee_type_code</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">guarantee_type_company_id</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">guarantee_type_name</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">speciman</xsl:with-param>
				</xsl:call-template>
	<xsl:if test="common:node-set($path)/bg_text_details_code = '01' and $isBankReporting!='Y'">
     <xsl:choose>
     <xsl:when test="speciman != ''" >
		<xsl:call-template name="row-wrapper">
			<xsl:with-param name="id">display_specimen</xsl:with-param>
			<xsl:with-param name="content">
		       (<a>
		         <xsl:attribute name="href">javascript:void(0)</xsl:attribute>
		         <xsl:attribute name="onclick">misys.downloadStaticDocument('document_id');</xsl:attribute>
		         <xsl:attribute name="title"><xsl:value-of select="localization:getGTPString($language, 'ACTION_DISPLAY_SPECIMEN')"/></xsl:attribute>
		         <xsl:value-of select="localization:getGTPString($language, 'ACTION_DISPLAY_SPECIMEN')"/>
		        </a>)
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">document_id</xsl:with-param>
				</xsl:call-template>
        	</xsl:with-param>
        </xsl:call-template>
     </xsl:when>
     <xsl:otherwise>
     	<xsl:call-template name="row-wrapper">
	      <xsl:with-param name="id">GTEETextPreview</xsl:with-param>
	      <xsl:with-param name="label"></xsl:with-param>
	      <xsl:with-param name="content">
	       <a name="GTEETextPreview" href="javascript:void(0)" onclick="misys.generateGTEEFromNew();return false;">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_PREVIEW_LABEL')"/>
		   </a>
	      </xsl:with-param>
	     </xsl:call-template>
     </xsl:otherwise>
     </xsl:choose>
     </xsl:if>
     <xsl:if test="common:node-set($path)/bg_text_details_code = '02' and $isBankReporting!='Y'">
     	<xsl:call-template name="row-wrapper">
			<xsl:with-param name="id">display_specimen</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:variable name="refId"><xsl:if test="$option != 'SCRATCH'"><xsl:value-of select="ref_id"/></xsl:if></xsl:variable>
				<xsl:variable name="tnxId"><xsl:if test="$option != 'SCRATCH'"><xsl:value-of select="tnx_id"/></xsl:if></xsl:variable>
							
		       (<a>
		         <xsl:attribute name="href">javascript:void(0)</xsl:attribute>
		         <xsl:attribute name="onclick">javascript:misys.popup.generateDocument('bg-document', '<xsl:value-of select="$pdfOption"/>', '<xsl:value-of select="$refId"/>', '<xsl:value-of select="$tnxId"/>', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="bg_code"/>','<xsl:value-of select="guarantee_type_company_id"/>');</xsl:attribute>
		         <xsl:attribute name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_TYPE_VIEW_EDITED_DOCUMENT')"/></xsl:attribute>
		         <xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_TYPE_VIEW_EDITED_DOCUMENT')"/>
		        </a>)
        	</xsl:with-param>
        </xsl:call-template>
     </xsl:if>
     
     <xsl:apply-templates select="common:node-set($path)/character_commitment">
        <xsl:with-param name="node-name">character_commitment</xsl:with-param>
        <xsl:with-param name="label">XSL_GUARANTEE_CHARACTER_COMMITMENT_LABEL</xsl:with-param>
     </xsl:apply-templates>
    
     <xsl:if test="$displaymode='view'">
	    <xsl:variable name="bg_rule_code"><xsl:value-of select="common:node-set($path)/bg_rule"></xsl:value-of></xsl:variable>
		<xsl:variable name="productCode"><xsl:value-of select="common:node-set($path)/product_code"/></xsl:variable>
		<xsl:variable name="subProductCode"><xsl:value-of select="common:node-set($path)/sub_product_code"/></xsl:variable>
		<xsl:variable name="parameterId">C013</xsl:variable>
		<xsl:call-template name="input-field">
		 	<xsl:with-param name="label">XSL_GTEEDETAILS_RULES_LABEL</xsl:with-param>
		 	<xsl:with-param name="name">bg_rule</xsl:with-param>
		 	<xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $bg_rule_code)"/></xsl:with-param>
		 	<xsl:with-param name="override-displaymode">view</xsl:with-param>	
		</xsl:call-template>
     </xsl:if>
     <xsl:call-template name="input-field">
	   <xsl:with-param name="name">bg_rule_other</xsl:with-param>
	     <xsl:with-param name="value" select="common:node-set($path)/bg_rule_other" />
	   <xsl:with-param name="maxsize">35</xsl:with-param>
	   <xsl:with-param name="readonly">Y</xsl:with-param>
	   <xsl:with-param name="required">Y</xsl:with-param>
	 </xsl:call-template>
     
     <!-- <xsl:if test="bg_text_details_code = '01'"> -->
	   <!-- MPS-21209 : BG Initiation - Guarantee details - 'Delivery To' field missing in Review screen  -->
	   <xsl:if test="$displaymode='view'">
     	<xsl:call-template name="select-field">
	      <xsl:with-param name="label">XSL_GTEEDETAILS_DELIVERY_TO_LABEL</xsl:with-param>
	      <xsl:with-param name="name">original_xml/bg_tnx_record/delivery_to</xsl:with-param>
	      <xsl:with-param name="options">
	      <xsl:if test="common:node-set($path)/delivery_to[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_DELIVERY_TO_OURSELVES')"/></xsl:if>
          <xsl:if test="common:node-set($path)/delivery_to[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_DELIVERY_TO_PARTY')"/></xsl:if>
          <xsl:if test="common:node-set($path)/delivery_to[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_DELIVERY_TO_BENEFICIARY')"/></xsl:if>
           <xsl:if test="delivery_to[. = '04']">
		      	<xsl:call-template name="row-wrapper">
		      	<xsl:with-param name="id">delivery_to_other</xsl:with-param>
			      <xsl:with-param name="type">textarea</xsl:with-param>
			      <xsl:with-param name="content">
			       <xsl:call-template name="textarea-field">
			        <xsl:with-param name="name">delivery_to_other</xsl:with-param>
			       </xsl:call-template>
			      </xsl:with-param>
			   </xsl:call-template>
         </xsl:if>
          
	      </xsl:with-param>
	     </xsl:call-template>
    	</xsl:if>
	   	<!-- End : MPS-21209 -->     
	     <xsl:call-template name="select-field">
	      <xsl:with-param name="label">XSL_GTEEDETAILS_TEXT_TYPE_LABEL</xsl:with-param>
	      <xsl:with-param name="name">bg_text_type_code</xsl:with-param>
	      <xsl:with-param name="required">Y</xsl:with-param>
	      <xsl:with-param name="options">
	        <xsl:if test="common:node-set($path)/bg_text_type_code = '01'"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_TYPE_BANK_STANDARD')"/></xsl:if>
            <xsl:if test="common:node-set($path)/bg_text_type_code = '02'"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_TYPE_WORDING_ATTACHED')"/></xsl:if>
            <xsl:if test="common:node-set($path)/bg_text_type_code = '03'"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_TYPE_SAME_AS_SPECIFY')"/></xsl:if>
            <xsl:if test="common:node-set($path)/bg_text_type_code = '04'"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_TYPE_BENEFICIARY_ATTACHED')"/></xsl:if>
	      </xsl:with-param>
	     </xsl:call-template>
	     <xsl:call-template name="input-field">
	      <xsl:with-param name="name">bg_text_type_details</xsl:with-param>
	       <xsl:with-param name="value" select="common:node-set($path)/bg_text_type_details" />
	      <xsl:with-param name="maxsize">255</xsl:with-param>
	      <xsl:with-param name="required">Y</xsl:with-param>
	     </xsl:call-template>
	     <xsl:call-template name="select-field">
	      <xsl:with-param name="label">XSL_GTEEDETAILS_TEXT_LANGUAGE</xsl:with-param>
	      <xsl:with-param name="name">text_language</xsl:with-param>
	      <xsl:with-param name="options">
	      <xsl:if test="common:node-set($path)/text_language[. = 'fr']"><xsl:value-of select="localization:getDecode($language, 'N061', 'fr')"/></xsl:if>
          <xsl:if test="common:node-set($path)/text_language[. = 'en']"><xsl:value-of select="localization:getDecode($language, 'N061', 'en')"/></xsl:if>
          <xsl:if test="common:node-set($path)/text_language[. = 'es']"><xsl:value-of select="localization:getDecode($language, 'N061', 'es')"/></xsl:if>
          <xsl:if test="common:node-set($path)/text_language[. = '*']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_TEXT_LANGUAGE_OTHER')"/></xsl:if>
	      </xsl:with-param>
	     </xsl:call-template>
	     <xsl:call-template name="input-field">
	      <xsl:with-param name="name">text_language_other</xsl:with-param>
	       <xsl:with-param name="value" select="common:node-set($path)/text_language_other" />
	      <xsl:with-param name="maxsize">35</xsl:with-param>
	      <xsl:with-param name="readonly">Y</xsl:with-param>
	      <xsl:with-param name="required">Y</xsl:with-param>
	     </xsl:call-template>

     
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GTEEDETAILS_CONTRACT_REF_LABEL</xsl:with-param>
      <xsl:with-param name="name">contract_ref</xsl:with-param>
       <xsl:with-param name="value" select="common:node-set($path)/contract_ref" />
      <xsl:with-param name="maxsize">255</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GTEEDETAILS_CONTRACT_DATE_LABEL</xsl:with-param>
      <xsl:with-param name="name">contract_date</xsl:with-param>
       <xsl:with-param name="value" select="common:node-set($path)/contract_date" />
      <xsl:with-param name="size">10</xsl:with-param>
      <xsl:with-param name="fieldsize">small</xsl:with-param>
      <xsl:with-param name="maxsize">10</xsl:with-param>
      <xsl:with-param name="type">date</xsl:with-param>
     </xsl:call-template>
     
      <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GTEEDETAILS_CONTRACT_AMT_LABEL</xsl:with-param>
      <xsl:with-param name="value"><xsl:value-of select="common:node-set($path)/contract_cur_code"/> <xsl:value-of select="common:node-set($path)/contract_amt"/></xsl:with-param>
     
     </xsl:call-template>
    
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_GTEEDETAILS_CONTRACT_PCT_LABEL</xsl:with-param>
      <xsl:with-param name="name">contract_pct</xsl:with-param>
       <xsl:with-param name="value" select="common:node-set($path)/contract_pct" />
      <xsl:with-param name="type">number</xsl:with-param>
      <xsl:with-param name="size">5</xsl:with-param>
      <xsl:with-param name="maxsize">5</xsl:with-param>
      <xsl:with-param name="fieldsize">x-small</xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="row-wrapper">
      <xsl:with-param name="id">narrative_additional_instructions</xsl:with-param>
      <xsl:with-param name="label">XSL_GTEEDETAILS_OTHER_INSTRUCTIONS</xsl:with-param>
      <xsl:with-param name="type">textarea</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:call-template name="input-field">
        <xsl:with-param name="name">narrative_additional_instructions</xsl:with-param>
        <xsl:with-param name="value" select="common:node-set($path)/narrative_additional_instructions" />
        <xsl:with-param name="rows">13</xsl:with-param>
        <xsl:with-param name="cols">40</xsl:with-param>
       </xsl:call-template>
      </xsl:with-param>
     </xsl:call-template>
     <xsl:call-template name="hidden-field">
	    <xsl:with-param name="name">bg_text_type_code</xsl:with-param>
	    <xsl:with-param name="value"><xsl:value-of select="common:node-set($path)/bg_text_type_code"/></xsl:with-param>
	 </xsl:call-template>
  
  
  </xsl:template>
    <!--
   Instructions for the Bank Fieldset.
   -->
 <xsl:template name="bank-instructions-new">
  
  
  <xsl:choose>
    <xsl:when test="$mode = 'DRAFT' and $displaymode='view'">
     <!-- Don't show the file details for the draft view mode, but do in all other cases -->
     
    </xsl:when>

    <xsl:otherwise>
    <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_INSTRUCTIONS</xsl:with-param>
    <xsl:with-param name="content">
       <xsl:call-template name="column-container">
       <xsl:with-param name="content">			 
         <xsl:call-template name="column-wrapper">
             <xsl:with-param name="content">
     
               <xsl:call-template name="bank-details1">
                 <xsl:with-param name="path" select="/bg_tnx_record"/> 
               </xsl:call-template>
    
    
   
    
     </xsl:with-param>
     </xsl:call-template>
          <xsl:call-template name="column-wrapper">
             <xsl:with-param name="content">
               <xsl:call-template name="bank-details1">
                 <xsl:with-param name="path" select="/bg_tnx_record/original_xml/bg_tnx_record"/> 
               </xsl:call-template>
     </xsl:with-param>
     </xsl:call-template>
     </xsl:with-param>
     </xsl:call-template>
    </xsl:with-param>
   </xsl:call-template>
    </xsl:otherwise>
   </xsl:choose>
 </xsl:template>
  
  <xsl:template name="bank-details1">
    <xsl:param name="path"></xsl:param>
    	<xsl:param name="send-mode-required">Y</xsl:param>
	  <xsl:param name="send-mode-displayed">Y</xsl:param>
	  <xsl:param name="send-mode-label">XSL_INSTRUCTIONS_LC_ADV_SEND_MODE_LABEL</xsl:param>
	  <xsl:param name="forward-contract-shown">N</xsl:param>
	  <xsl:param name="principal-acc-displayed">Y</xsl:param>
	  <xsl:param name="fee-acc-displayed">Y</xsl:param>
	  <xsl:param name="delivery-to-shown">N</xsl:param>
	  <xsl:param name="delivery-channel-displayed">N</xsl:param>
	  <xsl:param name="free-format-text-displayed">Y</xsl:param>
    
     <xsl:if test="$send-mode-displayed='Y'">
      <xsl:call-template name="select-field">
       <xsl:with-param name="label" select="$send-mode-label"/>
       <xsl:with-param name="name">adv_send_mode</xsl:with-param>
       <xsl:with-param name="required"><xsl:value-of select="$send-mode-required"/></xsl:with-param>
       <xsl:with-param name="fieldsize">small</xsl:with-param>
       <xsl:with-param name="options">
         <xsl:if test="common:node-set($path)/adv_send_mode[. = '01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_SWIFT')"/></xsl:if>
         <xsl:if test="common:node-set($path)/adv_send_mode[. = '02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_TELEX')"/></xsl:if>
         <xsl:if test="common:node-set($path)/adv_send_mode[. = '03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_COURIER')"/></xsl:if>
         <xsl:if test="common:node-set($path)/adv_send_mode[. = '04']"><xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_REGISTERED_POST')"/></xsl:if>
       </xsl:with-param>
      </xsl:call-template>
     </xsl:if>
    <xsl:if test="$delivery-channel-displayed='Y'">
	<xsl:call-template name="select-field">
		<xsl:with-param name="label">XSL_FILESDETAILS_FILEACT_DELIVERY_CHANNEL</xsl:with-param>
		<xsl:with-param name="name">delivery_channel</xsl:with-param>
		<xsl:with-param name="fieldsize">small</xsl:with-param>
	 	<xsl:with-param name="value"><xsl:value-of select="common:node-set($path)/delivery_channel"/></xsl:with-param> 			
		<xsl:with-param name="options">
			 <xsl:value-of select="localization:getDecode($language, 'N802', delivery_channel)"/>
		</xsl:with-param>
	</xsl:call-template>
	</xsl:if>           
     <xsl:if test="$principal-acc-displayed='Y'">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_INSTRUCTIONS_PRINCIPAL_ACT_NO_LABEL</xsl:with-param>
       <xsl:with-param name="button-type">account</xsl:with-param>
       <xsl:with-param name="type">account</xsl:with-param>
       <xsl:with-param name="name">principal_act_no</xsl:with-param>
       <xsl:with-param name="value" select="common:node-set($path)/principal_act_no" />
       <xsl:with-param name="readonly">Y</xsl:with-param>
       <xsl:with-param name="size">34</xsl:with-param>
       <xsl:with-param name="maxsize">34</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     <xsl:if test="$fee-acc-displayed='Y'">
     <xsl:call-template name="input-field">
      <xsl:with-param name="label">XSL_INSTRUCTIONS_FEE_ACT_NO_LABEL</xsl:with-param>
      <xsl:with-param name="button-type">account</xsl:with-param>
      <xsl:with-param name="type">account</xsl:with-param>
      <xsl:with-param name="name">fee_act_no</xsl:with-param>
       <xsl:with-param name="value" select="common:node-set($path)/fee_act_no" />
      <xsl:with-param name="readonly">Y</xsl:with-param>
      <xsl:with-param name="size">34</xsl:with-param>
      <xsl:with-param name="maxsize">34</xsl:with-param>
     </xsl:call-template>
     </xsl:if>
     <xsl:if test="$forward-contract-shown='Y'">
      <xsl:call-template name="input-field">
       <xsl:with-param name="label">XSL_INSTRUCTIONS_FWD_CONTRACT_NO_LABEL</xsl:with-param>
       <xsl:with-param name="name">fwd_contract_no</xsl:with-param>
       <xsl:with-param name="value" select="common:node-set($path)/fwd_contract_no" />
       <xsl:with-param name="size">34</xsl:with-param>
       <xsl:with-param name="maxsize">34</xsl:with-param>
      </xsl:call-template>
     </xsl:if>
     <xsl:if test="$delivery-to-shown='Y'">
	     <xsl:call-template name="select-field">
	      <xsl:with-param name="label">XSL_GTEEDETAILS_DELIVERY_TO_LABEL</xsl:with-param>
	      <xsl:with-param name="name">delivery_to</xsl:with-param>
	      <xsl:with-param name="options">
	         <xsl:if test="common:node-set($path)delivery_to[.='01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_DELIVERY_TO_OURSELVES')"/></xsl:if>
             <xsl:if test="common:node-set($path)delivery_to[.='02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_DELIVERY_TO_PARTY')"/></xsl:if>
             <xsl:if test="common:node-set($path)delivery_to[.='03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_DELIVERY_TO_BENEFICIARY')"/></xsl:if>
      <xsl:if test="common:node-set($path)delivery_to[.='04']">
      	<xsl:call-template name="row-wrapper">
      	<xsl:with-param name="id">delivery_to_other</xsl:with-param>
	      <xsl:with-param name="type">textarea</xsl:with-param>
	      <xsl:with-param name="content">
	       <xsl:call-template name="textarea-field">
	        <xsl:with-param name="name">delivery_to_other</xsl:with-param>
	       </xsl:call-template>
	      </xsl:with-param>
	   </xsl:call-template>
      </xsl:if>
	      </xsl:with-param>
	     </xsl:call-template>
	   
	  </xsl:if>
     
     <xsl:if test="$free-format-text-displayed='Y'">
     <xsl:call-template name="big-textarea-wrapper">
      <xsl:with-param name="id">free_format_text</xsl:with-param>
      <xsl:with-param name="label">XSL_INSTRUCTIONS_OTHER_INFORMATION</xsl:with-param>
      <xsl:with-param name="type">textarea</xsl:with-param>
      <xsl:with-param name="content">
       <xsl:call-template name="textarea-field">
        <xsl:with-param name="name">free_format_text</xsl:with-param>
        <xsl:with-param name="swift-validate">N</xsl:with-param>
        <xsl:with-param name="rows">13</xsl:with-param>
        <xsl:with-param name="cols">60</xsl:with-param>
        <xsl:with-param name="maxlines">100</xsl:with-param>
       </xsl:call-template>
      </xsl:with-param>
     </xsl:call-template>
     </xsl:if>
  
  </xsl:template>
  <xsl:template name="comments-for-return-new">
    <xsl:param name="value" />
    <xsl:param name="mode" />
   		<xsl:call-template name="fieldset-wrapper">
	  		<xsl:with-param name="legend">XSL_HEADER_MC_COMMENTS_FOR_RETURN</xsl:with-param>
	   		<xsl:with-param name="id">comments-for-return</xsl:with-param>
	   		<xsl:with-param name="content">
	   		   <xsl:call-template name="column-container">
       <xsl:with-param name="content">			 
         <xsl:call-template name="column-wrapper">
             <xsl:with-param name="content">
			    <xsl:call-template name="textarea-field">
					<xsl:with-param name="label"></xsl:with-param>
					<xsl:with-param name="name">return_comments</xsl:with-param>
					<xsl:with-param name="messageValue"><xsl:value-of select="$value"/></xsl:with-param>
					<xsl:with-param name="rows">5</xsl:with-param>
				   	<xsl:with-param name="cols">50</xsl:with-param>
			   		<xsl:with-param name="maxlines">300</xsl:with-param>
			   		<xsl:with-param name="override-displaymode">
			   			<xsl:choose>
			   				<xsl:when test="$mode = 'UNSIGNED'">edit</xsl:when>
			   				<xsl:otherwise>view</xsl:otherwise>
			   			</xsl:choose>
			   		</xsl:with-param>
			 	</xsl:call-template>
			 	</xsl:with-param>
			 	</xsl:call-template>
			 	<xsl:call-template name="column-wrapper">
             <xsl:with-param name="content">
			    <xsl:call-template name="textarea-field">
					<xsl:with-param name="label"></xsl:with-param>
					<xsl:with-param name="name">return_comments</xsl:with-param>
					<xsl:with-param name="messageValue"><xsl:value-of select="$value"/></xsl:with-param>
					<xsl:with-param name="rows">5</xsl:with-param>
				   	<xsl:with-param name="cols">50</xsl:with-param>
			   		<xsl:with-param name="maxlines">300</xsl:with-param>
			   		<xsl:with-param name="override-displaymode">
			   			<xsl:choose>
			   				<xsl:when test="$mode = 'UNSIGNED'">edit</xsl:when>
			   				<xsl:otherwise>view</xsl:otherwise>
			   			</xsl:choose>
			   		</xsl:with-param>
			 	</xsl:call-template>
			 	</xsl:with-param>
			 	</xsl:call-template>
			 	</xsl:with-param>
			 	</xsl:call-template>
	   		</xsl:with-param>
   		</xsl:call-template>
   </xsl:template>
   
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
		      					 <xsl:with-param name="path" select="/bg_tnx_record"/> 		        	        
		      			 </xsl:call-template>
		                </xsl:with-param>
		            </xsl:call-template>
		       <xsl:call-template name="column-wrapper">
			        <xsl:with-param name="content">
					  <xsl:call-template name="beneficiaryaddress">
					       <xsl:with-param name="path" select="/bg_tnx_record/original_xml/bg_tnx_record"/> 		        	        
					  </xsl:call-template>     
		            </xsl:with-param>
		       </xsl:call-template>
		       </xsl:with-param>
		       </xsl:call-template>
		      </xsl:with-param>
		     </xsl:call-template> 
   </xsl:template>
   
   
    <xsl:template name="contact-details">
    <xsl:call-template name="fieldset-wrapper">
		      <xsl:with-param name="legend">XSL_HEADER_CONTACT_DETAILS</xsl:with-param>
		      <xsl:with-param name="legend-type">indented-header</xsl:with-param>
		     
		      <xsl:with-param name="content">
		        <xsl:call-template name="column-container">
			       <xsl:with-param name="content">			 
			         <xsl:call-template name="column-wrapper">
			             <xsl:with-param name="content">
					          <xsl:call-template name="contactaddress">
		      					 <xsl:with-param name="path" select="/bg_tnx_record"/>		        	        
		      				 </xsl:call-template>
		               </xsl:with-param>
		            </xsl:call-template>
				    <xsl:call-template name="column-wrapper">
					             <xsl:with-param name="content">
				       <xsl:call-template name="contactaddress">
				       <xsl:with-param name="path" select="/bg_tnx_record/original_xml/bg_tnx_record"/>		        	        
				       </xsl:call-template>
				       </xsl:with-param>
				    </xsl:call-template>
		       </xsl:with-param>
		       </xsl:call-template>
		      </xsl:with-param>
		     </xsl:call-template> 
   </xsl:template>
   
   
   <!--
   Customer Reference Select Box.
   -->
  <xsl:template name="customer-reference-selectbox-new">
   <xsl:param name="main-bank-name"/>
   <xsl:param name="sender-name"/>
   <xsl:param name="sender-reference-name"/>
   <xsl:param name="label">XSL_PARTIESDETAILS_CUST_REFERENCE</xsl:param>
   <xsl:param name="path"></xsl:param>
   <xsl:variable name="main_bank_abbv_name_value">
    <xsl:value-of select="common:node-set($path)/recipient_bank/abbv_name"/>
   </xsl:variable>
 
   <xsl:variable name="sender-reference-value">
    <xsl:choose>
     <!-- current customer reference not null (draft) -->
     <xsl:when test="common:node-set($path)/applicant_reference != ''">
       <xsl:value-of select="common:node-set($path)/applicant_reference"/>
     </xsl:when>
     <!-- not entity defined and only one bank and only one customer reference available -->
     <xsl:when test="entities[.= '0']">
       <xsl:if test="count(common:node-set($path)/avail_main_banks/bank/customer_reference)=1">
         <xsl:value-of select="common:node-set($path)/avail_main_banks/bank/customer_reference/reference"/>
       </xsl:if>
     </xsl:when>
     <!-- only one entity, only one bank and only one customer reference available -->
     <xsl:otherwise>
       <xsl:if test="count(common:node-set($path)/avail_main_banks/bank/entity/customer_reference)=1">
         <xsl:value-of select="common:node-set($path)/avail_main_banks/bank/entity/customer_reference/reference"/>
       </xsl:if>          
     </xsl:otherwise>
    </xsl:choose>
   </xsl:variable>
   
   <!-- Check if customer references are defined for entities or not -->
   <xsl:if test="common:node-set($path)/avail_main_banks/bank/entity/customer_reference or common:node-set($path)/avail_main_banks/bank/customer_reference">
    <!-- Hidden Fields -->
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name"><xsl:value-of select="$sender-reference-name"/></xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="$sender-reference-value"/></xsl:with-param>
    </xsl:call-template>
  
    <xsl:choose>
    <xsl:when test="$displaymode='edit'">
        <xsl:call-template name="select-field">
     <xsl:with-param name="label" select="$label"/>
     <xsl:with-param name="name"><xsl:value-of select="$main-bank-name"/>_customer_reference</xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="$sender-reference-value"/></xsl:with-param>
     <xsl:with-param name="required">Y</xsl:with-param>
     <xsl:with-param name="options">
      <xsl:choose>
       <xsl:when test="$displaymode='edit'">
	      <xsl:choose>
	      <!-- if not entity defined -->         
	      <xsl:when test="entities[.= '0']">
	       <xsl:apply-templates select="avail_main_banks/bank[./abbv_name=$main_bank_abbv_name_value]/customer_reference" mode="option">
	        <xsl:with-param name="selected_reference"><xsl:value-of select="$sender-reference-value"/></xsl:with-param>
	       </xsl:apply-templates>
	      </xsl:when>
	      <!-- else -->  
	      <xsl:otherwise>
	       <xsl:apply-templates select="avail_main_banks/bank[./abbv_name=$main_bank_abbv_name_value]/entity/customer_reference" mode="option">
	        <xsl:with-param name="selected_reference"><xsl:value-of select="$sender-reference-value"/></xsl:with-param>
	       </xsl:apply-templates>
	      </xsl:otherwise>
	     </xsl:choose>
       </xsl:when>
       <xsl:otherwise>
	     <xsl:choose>
		     <xsl:when test="count(common:node-set($path)/avail_main_banks/bank/entity/customer_reference[reference=$sender-reference-value]) >= 1">
		      	<xsl:value-of select="common:node-set($path)/avail_main_banks/bank/entity/customer_reference[reference=$sender-reference-value]/description"/>
		     </xsl:when>
		     <xsl:otherwise>
		     	<xsl:value-of select="common:node-set($path)/avail_main_banks/bank[./abbv_name=$main_bank_abbv_name_value]/customer_reference/description"/>
		     </xsl:otherwise>
	     </xsl:choose>
       </xsl:otherwise>
      </xsl:choose>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:when>
   <xsl:otherwise>
   	  <xsl:call-template name="input-field">
   	   	 <xsl:with-param name="label" select="$label"/>
    	 <xsl:with-param name="name"><xsl:value-of select="common:node-set($path)/recipient_bank_customer_reference"/></xsl:with-param>
    	 <xsl:with-param name="value"> <xsl:value-of select="utils:decryptApplicantReference($sender-reference-value)"/></xsl:with-param>
   </xsl:call-template>
   </xsl:otherwise>
  </xsl:choose>
  </xsl:if>
 </xsl:template>
 
 <xsl:template name="disclaimer-new">
   <xsl:if test="$displaymode='view'">
    <div class="disclaimer">
     <!-- <h2><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTING_DISCLAIMER_LABEL')"/></h2> -->
     <h2><xsl:value-of select="localization:getGTPString($language, 'XSL_UPDATED_DISCLAIMER')"/></h2>
    </div>
   </xsl:if>
  </xsl:template>
  
</xsl:stylesheet>