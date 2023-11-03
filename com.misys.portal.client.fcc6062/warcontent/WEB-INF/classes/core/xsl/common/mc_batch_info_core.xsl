<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Batch Transactions Information Screen

Copyright (c) 2000-2012 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      02/04/2012
author:    Gurudath Reddy
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
        xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
        xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
        exclude-result-prefixes="xmlRender localization securitycheck utils security">
 
 <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
 <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="mode">DRAFT</xsl:param>
  <xsl:param name="displaymode">edit</xsl:param> <!-- set to edit for form, view to view data. -->
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="product-code">BT</xsl:param> 
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/MessageCenterScreen</xsl:param>
  <xsl:param name="gridContent"/>
  
  <xsl:include href="trade_common.xsl" />
  <xsl:include href="../system/sy_reauthenticationdialog.xsl" />
   <xsl:include href="../../../core/xsl/common/e2ee_common.xsl" />
  
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />

  <xsl:template match="/">
	<xsl:apply-templates select="batch"/>
  </xsl:template>
  
  <xsl:template match="batch">
  
  	<!-- Preloader  -->
	<xsl:call-template name="loading-message"/>
	
	
	 <xsl:call-template name="reauthentication"/>	
	 
	<div>
		<xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
		<xsl:call-template name="form-wrapper">
			<xsl:with-param name="name" select="$main-form-name"/>
			<xsl:with-param name="validating">Y</xsl:with-param>
			<xsl:with-param name="content">
				<div class="column-container">
					<div>
						<xsl:attribute name="class">
							<xsl:if test="remote_authorise">
								column-wrapper
							</xsl:if>
						</xsl:attribute>
						<div class="field">
							<span class="label"><xsl:value-of select="localization:getGTPString($language, 'BATCHID')"/>:</span>
							<div class="content"><xsl:value-of select="batch_id"/></div>
						</div>
						<div class="field">
							<span class="label"><xsl:value-of select="localization:getGTPString($language, 'BATCH_DATE')"/>:</span>
							<div class="content"><xsl:value-of select="batch_dttm"/></div>
						</div>
						<div class="field">
							<span class="label"><xsl:value-of select="localization:getGTPString($language, 'BATCH_MAKER')"/>:</span>
							<div class="content"><xsl:value-of select="batch_maker"/></div>
						</div>
						<div class="field">
							<span class="label"><xsl:value-of select="localization:getGTPString($language, 'BATCH_TNX_COUNT')"/>:</span>
							<div class="content"><xsl:value-of select="batch_total_tnx"/></div>
						</div>
						<div class="field">
							<span class="label"><xsl:value-of select="localization:getGTPString($language, 'BATCH_AMOUNT')"/>:</span>
							<div class="content"><xsl:value-of select="batch_cur_code"/>&nbsp;<xsl:value-of select="batch_amt_new"/></div>
						</div>  
					</div>
				</div>
				
				<div style="clear:both;">
					<xsl:value-of select="$gridContent" disable-output-escaping="yes"/>
				</div>
		  		
		  		<div style="text-align:right;" class="widgetContainer">
		  		<xsl:if test="batch_delete[.='true']">
			  		<div dojoType="dijit.form.Button">
			  			<xsl:attribute name="onClick">misys.deleteBatch('OPERATION_DELETE_BATCH')</xsl:attribute>
			  			<xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_DELETE')"/>
			  		</div>
			  	</xsl:if>
			  		<xsl:if test="batch_submit[.='true']">
				  		<div dojoType="dijit.form.Button">
				  			<xsl:attribute name="onClick">misys.submitBatchWithHolidayCutOffValidation('<xsl:value-of select="batch_id"/>','OPERATION_SUBMIT_BATCH')</xsl:attribute>
					  		<xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_SUBMIT')"/>
					  	</div>
			  		</xsl:if>
		  		</div>
		  		
		  				  		
		  		<xsl:if test="refKeys">
		  			<div  class="column-container">
						 <div class="field">
								<div style="line-height:10px; padding-left:5px;" class="content"><xsl:value-of select="localization:getGTPString($language,'BATCH_TNX_LIST_MSG')"/></div>
						</div>
					</div>
		  			<div>
						<table border="0" cellpadding="0" cellspacing="0" class="attachments" style="margin-left: 5px; width: 500px;">
					      <thead>
					       <tr>
					        <th class="small-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'XSL_BATCH_REF_ID')"/></th>
					      </tr>
					      </thead>
					      <tbody>
					      	<xsl:for-each select="refKeys">
					          <tr>
					            <td><xsl:value-of select="reference_id"/></td>
					          </tr>
					        </xsl:for-each>
					    </tbody>
					    </table>
					</div>
				</xsl:if>
				
		  	</xsl:with-param>
	  	</xsl:call-template>
	  	
	  	<xsl:call-template name="realform"/>
	  	<!-- Reauthentication -->
     
      
	</div>
	<xsl:call-template name="js-imports"/> 
  </xsl:template>
  
  <xsl:template name="js-imports">
		<xsl:call-template name="common-js-imports">
			<xsl:with-param name="binding">misys.binding.common.mc_batch_info</xsl:with-param>
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
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">featureid</xsl:with-param>
						<xsl:with-param name="value" select="batch_id"/>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">operation</xsl:with-param>
						<xsl:with-param name="id">realform_operation</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">TransactionData</xsl:with-param>
						<xsl:with-param name="value"/>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">autoForward</xsl:with-param>
						<xsl:with-param name="value">N</xsl:with-param>
					</xsl:call-template>
					 <xsl:call-template name="reauth_params"/>
					 <xsl:call-template name="e2ee_transaction"/>
				</div>
			</xsl:with-param>
			
		</xsl:call-template>
	</xsl:template>
	
</xsl:stylesheet>