<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for the details of

Transaction Bulk (BK) Repayment for IP from Customer Side.

Copyright (c) 2000-2017 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      12/07/2017
author:    Meenal Sahasrabudhe
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
        xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
        xmlns:collabutils="xalan://com.misys.portal.common.tools.CollaborationUtils"
        exclude-result-prefixes="localization securitycheck utils defaultresource collabutils">
        
        <xsl:param name="rundata" />
	<xsl:param name="language">en</xsl:param>
	<xsl:param name="mode">DRAFT</xsl:param>
	<xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
	<xsl:param name="collaborationmode">none</xsl:param>
	<xsl:param name="product-code">BK</xsl:param>
	<xsl:param name="main-form-name">fakeform1</xsl:param>
	<xsl:param name="nextscreen" />
	<xsl:param name="realform-action"><xsl:value-of select="$contextPath" /><xsl:value-of select="$servletPath" />/screen/InvoicePayableScreen</xsl:param>

	<xsl:include href="../../core/xsl/products/product_addons.xsl"/>
	<xsl:include href="../../core/xsl/common/com_cross_references.xsl"/>
	<xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
	<xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" />
	<xsl:include href="../../core/xsl/bk_common.xsl"/>
	<xsl:include href="../../core/xsl/bk_repayment_common.xsl"/>

<!-- 
	 BK TNX FORM TEMPLATE.
	-->
	<xsl:template match="bk_tnx_record">
		<!-- Preloader  -->
		<!-- <xsl:call-template name="loading-message"/> -->
		
		<div>
			<xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
		    <!-- Form #0 : Main Form -->
		    <xsl:call-template name="form-wrapper">
				<xsl:with-param name="name" select="$main-form-name"/>
				<xsl:with-param name="validating">Y</xsl:with-param>
				<xsl:with-param name="content">
		      		<!-- Disclaimer Notice -->
		      		<xsl:call-template name="disclaimer"/>      
			      	<xsl:call-template name="bk-fscm-hidden-fields">
			      		<xsl:with-param name="childProductCode">IP</xsl:with-param>
			      	</xsl:call-template>	      	    
		
						<!-- Reauthentication -->
					    <xsl:call-template name="server-message">
					 		<xsl:with-param name="name">server_message</xsl:with-param>
					 		<xsl:with-param name="content"><xsl:value-of select="message"/></xsl:with-param>
					 		<xsl:with-param name="appendClass">serverMessage</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="reauthentication" />

	      		   		<div>

						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_HEADER_GENERAL_DETAILS</xsl:with-param>
							<xsl:with-param name="content">
								<xsl:call-template name="hidden-field">
					    			<xsl:with-param name="name">ref_id</xsl:with-param>
					    		</xsl:call-template>
								<xsl:call-template name="column-container">
									<xsl:with-param name="content">
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_BK_REF_ID</xsl:with-param>	
											<xsl:with-param name="id">general_ref_id_view</xsl:with-param>
  												<xsl:with-param name="value" select="ref_id" />
											<xsl:with-param name="override-displaymode">view</xsl:with-param>
										</xsl:call-template>
										<xsl:if test="entities[number(.) &gt; 0]">
						  					<xsl:call-template name="entity-field">
							    				<xsl:with-param name="required">Y</xsl:with-param>
							    				<xsl:with-param name="button-type">entity</xsl:with-param>
							    				<xsl:with-param name="prefix">applicant</xsl:with-param>
							    				<xsl:with-param name="override-sub-product-code">BK:IPBR</xsl:with-param>
						    				</xsl:call-template>
										</xsl:if>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
					</xsl:call-template>
  	<!-- Bank details -->
	<xsl:call-template name="bank-details" />
	<xsl:call-template name="bulk-repayment-details" />
	<xsl:call-template name="bulk_finances_repay">
		<xsl:with-param name="childProduct">IP</xsl:with-param>
	</xsl:call-template>	
	<xsl:if test="$displaymode='edit'">
		<xsl:call-template name="bulk-finances-repay-grid">
			<xsl:with-param name="childProduct">IP</xsl:with-param>
		</xsl:call-template>
	</xsl:if>	
	<xsl:if test="$displaymode='view'">			
		<xsl:call-template name="bulk-finances-repay-grid-view">
			<xsl:with-param name="childProduct">IP</xsl:with-param>
		</xsl:call-template>
	</xsl:if>			
	</div>

	<xsl:call-template name="fieldset-wrapper">
      <xsl:with-param name="legend">XSL_HEADER_INSTRUCTIONS</xsl:with-param>
      <xsl:with-param name="content" >
      <xsl:choose>
        <xsl:when test="$displaymode='edit'">
             <xsl:call-template name="row-wrapper">
                  <xsl:with-param name="id">free_format_text</xsl:with-param> 
                <xsl:with-param name="required">N</xsl:with-param>
                <xsl:with-param name="type">textarea</xsl:with-param>
                <xsl:with-param name="content">
                   <xsl:call-template name="textarea-field">
                    <xsl:with-param name="name">free_format_text</xsl:with-param>
                    <xsl:with-param name="rows">5</xsl:with-param>
                    <xsl:with-param name="cols">35</xsl:with-param>
                    <xsl:with-param name="required">N</xsl:with-param>
                   </xsl:call-template>
                  </xsl:with-param>
            </xsl:call-template>
        </xsl:when>
          <xsl:when test=" $displaymode='view' and free_format_text[.!='']">
             <xsl:call-template name="big-textarea-wrapper">
              <xsl:with-param name="label">XSL_INSTRUCTIONS_OTHER_INFORMATION</xsl:with-param>
              <xsl:with-param name="content">
               <div class="content">
                  <xsl:value-of select="free_format_text"/>
               </div>
              </xsl:with-param>
             </xsl:call-template>
          </xsl:when>
          </xsl:choose>
          <xsl:call-template name="disclaimer-bulk-repayment"/>
       </xsl:with-param>
    </xsl:call-template>

				<xsl:call-template name="comments-for-return">
					<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
					<xsl:with-param name="mode"><xsl:value-of select="$mode"/></xsl:with-param>
				</xsl:call-template>
				<!-- Form #1 : Attach Files -->
			    <xsl:if test="$displaymode = 'edit' or ($displaymode != 'edit' and $mode = 'UNSIGNED')">
			    	<xsl:call-template name="attachments-file-dojo"/>
			    </xsl:if>
   	 			<xsl:call-template name="menu">
					<xsl:with-param name="second-menu">Y</xsl:with-param>
					<xsl:with-param name="show-return">Y</xsl:with-param>
					<xsl:with-param name="show-submit-bulk">N</xsl:with-param>
					<xsl:with-param name="show-submit">Y</xsl:with-param>
					<xsl:with-param name="show-save">Y</xsl:with-param>
					<xsl:with-param name="show-template">N</xsl:with-param>
					<xsl:with-param name="show-help">N</xsl:with-param>
					<xsl:with-param name="show-cancel">N</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="realform"/>
		</div>
              
		<!-- Javascript imports  -->
		<xsl:call-template name="common-js-imports">
			<xsl:with-param name="binding">misys.binding.openaccount.create_ip_bk_repayment</xsl:with-param>
			<xsl:with-param name="override-help-access-key">BK_01</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
  	<!--
	Real form for Bulk
	-->
	<xsl:template name="realform">
		<xsl:call-template name="form-wrapper">
			<xsl:with-param name="name">realform</xsl:with-param>
			<xsl:with-param name="method">POST</xsl:with-param>
			<xsl:with-param name="action" select="$realform-action"/>
			<xsl:with-param name="content">
				<div class="widgetContainer">
				<xsl:call-template name="localization-dialog"/>
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
						<xsl:with-param name="name">option</xsl:with-param>
						<xsl:with-param name="value">BULK_REPAY</xsl:with-param>
					</xsl:call-template> 
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">tnxtype</xsl:with-param>
						<xsl:with-param name="value">01</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">productcode</xsl:with-param>
						<xsl:with-param name="value">BK</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">subproductcode</xsl:with-param>
						<xsl:with-param name="value">IPBR</xsl:with-param>
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
						<xsl:with-param name="name">bulk_autoforward</xsl:with-param>
						<xsl:with-param name="value"/>
					</xsl:call-template>   
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">displaymode</xsl:with-param>
						<xsl:with-param name="value" select="$displaymode"/>
					</xsl:call-template>
					<xsl:call-template name="e2ee_transaction"/>
					<xsl:call-template name="reauth_params"/>
				</div>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
