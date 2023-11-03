<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Pooling Structure
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
	xmlns:ftProcessing="xalan://com.misys.portal.cash.common.services.FTProcessing"
	xmlns:collabutils="xalan://com.misys.portal.common.tools.CollaborationUtils"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	exclude-result-prefixes="xmlRender localization ftProcessing securitycheck utils security collabutils defaultresource">
	
	

	<!-- 
	Global Parameters.
	These are used in the imported XSL, and to set global params in the JS 
	--> 
	<xsl:param name="rundata"/>
  	<xsl:param name="option"/>
  	<xsl:param name="language">en</xsl:param>
  	<xsl:param name="nextscreen"/>
  	<xsl:param name="mode"></xsl:param>
  	<xsl:param name="action"/>
	<xsl:param name="displaymode">edit</xsl:param>
  	<xsl:param name="operation">SAVE_FEATURES</xsl:param>
  	<xsl:param name="isMakerCheckerMode"/>
	<xsl:param name="makerCheckerState"/>
	<xsl:param name="canCheckerReturnComments"/>
	<xsl:param name="checkerReturnCommentsMode"/>
  	<xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
   	<xsl:param name="main-form-name">fakeform1</xsl:param>
   	<xsl:param name="modifyMode">N</xsl:param>
   	<xsl:param name="token"/>
	<xsl:param name="processdttm"/>
	<xsl:param name="company"/>
   	<xsl:param name="allowReturnAction">false</xsl:param>
  	<xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$nextscreen"/></xsl:param>
  	<xsl:param name="product-code"/>

  <xsl:param name="actionperformed"></xsl:param>
  <xsl:param name="validateCode"/>
  <xsl:param name="validateDescription"/>
  
  
	
	<!-- Global Imports. -->
	<xsl:include href="../../core/xsl/common/trade_common.xsl" />
	<xsl:include href="../../core/xsl/common/e2ee_common.xsl" />
	<xsl:include href="../../core/xsl/system/sy_reauthenticationdialog.xsl" /> 
	<xsl:include href="../../core/xsl/common/maker_checker_common.xsl" />
  
	<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
	<xsl:template match="/">
		<xsl:apply-templates select="pooling_structure"/>
	</xsl:template>
	
	<xsl:template match="pooling_structure">
		<!-- Preloader -->
		<xsl:call-template name="loading-message"/>
		<xsl:call-template name="balgroup-details-declaration"/> 
		<xsl:call-template name="balsubgroup-details-declaration"/>
		<xsl:call-template name="balacctsubgroup-details-declaration"/>  
		
		
		<div>
			<xsl:attribute name="id"><xsl:value-of select="$displaymode"/></xsl:attribute>
			<!-- Form #0 : Main Form -->
			<xsl:call-template name="form-wrapper">
				<xsl:with-param name="name" select="$main-form-name" />
				<xsl:with-param name="validating">Y</xsl:with-param>
				<xsl:with-param name="content">
					<!-- Disclaimer Notice -->
					<!-- <xsl:call-template name="disclaimer" />-->
					
					<xsl:if test="$mode='copy'">
						<div id="INT_DISCLAIMER" class="ftDisclaimer intDisclaimer">
							<xsl:call-template name="simple-disclaimer">
								<xsl:with-param name="label">XSL_POOLING_STRUCTURE_DISCLAIMER</xsl:with-param>
							</xsl:call-template>
						</div>
					</xsl:if>
					<div>
						<xsl:call-template name="server-message">
							<xsl:with-param name="name">server_message</xsl:with-param>
							<xsl:with-param name="content"><xsl:value-of select="message" /></xsl:with-param>
							<xsl:with-param name="appendClass">serverMessage</xsl:with-param>
						</xsl:call-template>
						<!-- Reauthentication -->
						<!-- <xsl:call-template name="reauthentication" /> -->
						<!-- Transfer sections -->						
						<xsl:call-template name="pooling-details"/>
						<xsl:if test="$mode !='copy'">   
						<xsl:call-template name="balancegroup-details"/>
						 </xsl:if>	 

						<!-- comments for return -->
						 <xsl:if test="$canCheckerReturnComments = 'true'">
						<xsl:call-template name="comments-for-return-mc">
							<xsl:with-param name="value"><xsl:value-of select="return_comments"/></xsl:with-param>
						</xsl:call-template>
					</xsl:if>
					</div>
					<!--  Display common menu. -->
					<xsl:call-template name="maker-checker-menu">						
					</xsl:call-template>
						<!-- Reauthentication -->
		      		<xsl:call-template name="reauthentication"/>
				</xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="realform" />    
		</div>
		<!-- Javascript imports  -->
	<xsl:call-template name="js-imports"/> 
		 
	</xsl:template>
	
	<xsl:template name="js-imports">  
		<xsl:call-template name="common-js-imports">	                                        
			<xsl:with-param name="xml-tag-name">pooling_structure</xsl:with-param>
	    	<xsl:with-param name="binding">misys.binding.cash.create_pooling_structure</xsl:with-param>
	    	<xsl:with-param name="show-period-js">Y</xsl:with-param>
	    	<xsl:with-param name="override-help-access-key">LIQ_01</xsl:with-param>
	    	 <xsl:with-param name="override-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$nextscreen"/>?option=<xsl:value-of select="$option"/></xsl:with-param> 
	    </xsl:call-template>
	</xsl:template>
	
	<xsl:template name="balancegroup-details">	
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_LIST_OF_BALANCING_GROUPS</xsl:with-param>
			<xsl:with-param name="content">
				&nbsp;					
				<!-- Line items grid -->
			<xsl:call-template name="build-balgrp-dojo-items">
				<xsl:with-param name="items" select="balgroups/balgroup" />
			</xsl:call-template>	
						
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="balgroup-details-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="balgroup-dialog-declaration" /> 
		<!-- Dialog End -->
			<div id="balgroup-template" style="display:none">
				<div class="clear multigrid">
					<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_GROUP')" />
					</div>
					<div dojoAttachPoint="itemsNode">
						<div dojoAttachPoint="containerNode" />
					</div>					
					<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
										dojoAttachPoint="addButtonNode">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_ADD_GROUP')" />
					</button>
				</div>				
			</div>
							
    </xsl:template>
    
    <xsl:template name="balsubgroup-details-declaration">
	<!-- Dialog Start -->
		<xsl:call-template name="balsubgroup-dialog-declaration" /> 
							<!-- Dialog End -->
			<div id="balsubgroup-template" style="display:none">
				<div class="clear multigrid">
					<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NO_SUB_GROUP')" />
					</div>
					<div dojoAttachPoint="itemsNode">
						<div dojoAttachPoint="containerNode" />
					</div>					
					<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
										dojoAttachPoint="addButtonNode">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_ADD_SUB_GROUP')" />
					</button>
				</div>				
			</div>
							
    </xsl:template>
    
    <xsl:template name="balacctsubgroup-details-declaration">
	 <!-- Dialog Start -->
		<xsl:call-template name="balacctsubgroup-dialog-declaration" /> 
							<!-- Dialog End -->
			<div id="balacctsubgroup-template" style="display:none">
				<div class="clear multigrid">
					<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NO_ACCOUNT')" />
					</div>
					<div dojoAttachPoint="itemsNode">
						<div dojoAttachPoint="containerNode" />
					</div>					
					<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
										dojoAttachPoint="addButtonNode">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_ADD_ACCOUNT')" />
					</button>
				</div>				
			</div>
							
    </xsl:template>
    
    	<xsl:template name="balgroup-dialog-declaration">
		<div id="balgroup-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>

				<div id="balgroup-dialog-template-content">
					<div>
						
						<!-- Balancing Group code -->
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DETAILS_GROUP_CODE</xsl:with-param>
							<xsl:with-param name="name">group_code</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
						</xsl:call-template>
						<!-- Description -->
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DESCRIPTION</xsl:with-param>
							<xsl:with-param name="name">description</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
						</xsl:call-template> 
						<xsl:choose>
						<xsl:when test="$displaymode = 'edit'">
						 <xsl:call-template name="select-field">
						<xsl:with-param name="label">XSL_FREQUENCY</xsl:with-param>
						<xsl:with-param name="name">frequency</xsl:with-param>
						<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
						<xsl:with-param name="options">
						<xsl:for-each select="liquidity_setting/liquidity_frequency">
							    <xsl:variable name="currentfreqcode"><xsl:value-of select="./liquidity_frequency_code"/></xsl:variable>							  
							    <xsl:if test="./checked[.='Y']"> 
				                  		<option>
				                     		<xsl:attribute name="value"><xsl:value-of select="$currentfreqcode"/></xsl:attribute>				                      		
											<xsl:value-of select="./liquidity_frequency_desc"/>			                      		
				                   		</option>
							 	</xsl:if> 
							</xsl:for-each>				              
				          </xsl:with-param>
					</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
					     <xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_FREQUENCY</xsl:with-param>
								<xsl:with-param name="name">frequency_label</xsl:with-param>
								<xsl:with-param name="override-displaymode">edit</xsl:with-param>								
							</xsl:call-template>					
					</xsl:otherwise>
					</xsl:choose>
					
					<xsl:choose>	
						<xsl:when test="$displaymode = 'edit'">			
			 		 <xsl:call-template name="select-field">
					      <xsl:with-param name="label">XSL_BALANCE_TYPE</xsl:with-param>
					      <xsl:with-param name="name">balance_type</xsl:with-param>
					     <xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param> 
					      <xsl:with-param name="options">
						      <xsl:call-template name="code-data-options">
								 <xsl:with-param name="paramId">C072</xsl:with-param>
								 <xsl:with-param name="productCode">*</xsl:with-param>
								 <xsl:with-param name="specificOrder">Y</xsl:with-param>
							  </xsl:call-template>
					      </xsl:with-param>
			       </xsl:call-template>
			       </xsl:when>
			       <xsl:otherwise>
			          <xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_BALANCE_TYPE</xsl:with-param>
								<xsl:with-param name="name">balance_type_label</xsl:with-param>
								<xsl:with-param name="override-displaymode">edit</xsl:with-param>								
							</xsl:call-template>
			       </xsl:otherwise>
			       </xsl:choose>
		  	  		
		  	  	 <xsl:choose>	
						<xsl:when test="$displaymode = 'edit'">	
						  <xsl:call-template name="currency-field">
							<xsl:with-param name="label">XSL_CURRENCY</xsl:with-param>
							<xsl:with-param name="product-code">balGrp</xsl:with-param>
							<xsl:with-param name="override-currency-name">balGrp_cur_code</xsl:with-param>
							<xsl:with-param name="required">Y</xsl:with-param>
							<xsl:with-param name="show-amt">N</xsl:with-param>
							<xsl:with-param name="currency-readonly">N</xsl:with-param>	
							<xsl:with-param name="show-button">Y</xsl:with-param>
						</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
						  <xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_CURRENCY</xsl:with-param>
							<xsl:with-param name="name">currency_label</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>	
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>	
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_MINIMUM</xsl:with-param>
							<xsl:with-param name="name">minimum</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
							<xsl:with-param name="size">16</xsl:with-param>
							<xsl:with-param name="maxsize">16</xsl:with-param>
							<xsl:with-param name="type">amount</xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_ROUNDING</xsl:with-param>
							<xsl:with-param name="name">rounding</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
							<xsl:with-param name="size">16</xsl:with-param>
							<xsl:with-param name="maxsize">16</xsl:with-param>
							<xsl:with-param name="type">amount</xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_ORDER</xsl:with-param>
							<xsl:with-param name="name">group_order</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
							<xsl:with-param name="size">10</xsl:with-param>
							<xsl:with-param name="maxsize">10</xsl:with-param>
							<xsl:with-param name="type">number</xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="bal-sub-grp-temp">
											
						</xsl:call-template>
						
							<div class="dijitDialogPaneActionBar">
								<xsl:call-template name="label-wrapper">
									<xsl:with-param name="content">
										<button type="button" dojoType="dijit.form.Button">
											<xsl:attribute name="onmouseup">dijit.byId('balgroup-dialog-template').hide();</xsl:attribute>
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
										</button>
										<xsl:if test="$displaymode = 'edit'">
											<button dojoType="dijit.form.Button">
												<xsl:attribute name="onClick">dijit.byId('balgroup-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
												<xsl:value-of
													select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
											</button>
										</xsl:if>										
									</xsl:with-param>
								</xsl:call-template>
						</div>
					</div>
				</div>
		</div>
	</xsl:template>	
	<xsl:template name="bal-sub-grp-temp">
	
	
	<!-- List of Sub Balancing Group -->		
								<xsl:call-template name="fieldset-wrapper">
									<xsl:with-param name="legend">XSL_LIST_OF_SUB_BALANCING_GROUPS</xsl:with-param>
									<xsl:with-param name="legend-type">indented-header</xsl:with-param>
									<xsl:with-param name="toc-item">N</xsl:with-param>
									<xsl:with-param name="content">
										&nbsp;
										<xsl:call-template name="build-sub-groups-dojo-items">
										   <xsl:with-param name="id">sub_group_identifiers</xsl:with-param>
											<!-- <xsl:with-param name="items" select="balsubgroups/balsubgroup" /> -->
										</xsl:call-template>
									</xsl:with-param>
								</xsl:call-template>	
								
		</xsl:template>						
	
	    	<xsl:template name="balacctsubgroup-dialog-declaration">
		<div id="balacctsubgroup-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>

				<div class="balacctsubgroup-dialog-template-content">
					<div>
						
						<!-- Balancing Group code -->
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">ACCOUNT_NUMBER_LABEL</xsl:with-param>
							<xsl:with-param name="name">account_no</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
						</xsl:call-template>
						 <xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_ACCT_DESCRIPTION</xsl:with-param>
							<xsl:with-param name="name">acctdesc</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
						</xsl:call-template>
						
						 <xsl:choose>
							<xsl:when test="$displaymode = 'edit'">
							 <xsl:call-template name="select-field">
							<xsl:with-param name="label">XSL_SUB_GROUP_PIVOT</xsl:with-param>
							<xsl:with-param name="name">sub_group_pivot</xsl:with-param>
							 <xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param> 
							<xsl:with-param name="options">
							 <option value="Yes">
							        <xsl:value-of select="localization:getGTPString($language, 'XSL_YES')"/>
							 </option>
							 <option value="No">
							    <xsl:value-of select="localization:getGTPString($language, 'XSL_NO')"/>
							 </option>         
					          </xsl:with-param>
						</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
						     <xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_SUB_GROUP_PIVOT</xsl:with-param>
									<xsl:with-param name="name">acctsubgrppivot_label</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>								
								</xsl:call-template>					
						</xsl:otherwise>
			        </xsl:choose>
					
							<div class="dijitDialogPaneActionBar">
								<xsl:call-template name="label-wrapper">
									<xsl:with-param name="content">
										<button type="button" dojoType="dijit.form.Button">
											<xsl:attribute name="onmouseup">dijit.byId('balacctsubgroup-dialog-template').hide();</xsl:attribute>
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
										</button>
										<xsl:if test="$displaymode = 'edit'">
											<button dojoType="dijit.form.Button">
												<xsl:attribute name="onClick">dijit.byId('balacctsubgroup-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
												<xsl:value-of
													select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
											</button>
										</xsl:if>										
									</xsl:with-param>
								</xsl:call-template>
						</div>
					</div>
				</div>
		</div>
	</xsl:template>	
    
    
    	<xsl:template name="balsubgroup-dialog-declaration">
		<div id="balsubgroup-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>

				<div id="balsubgroup-dialog-template-content">
					<div>
						
						<!-- Balancing Group code -->
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DETAILS_SUB_GROUP_CODE</xsl:with-param>
							<xsl:with-param name="name">sub_group_code</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DESCRIPTION</xsl:with-param>
							<xsl:with-param name="name">subgrp_description</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
						</xsl:call-template>
						
						<xsl:choose>
							<xsl:when test="$displaymode = 'edit'">
								<xsl:call-template name="select-field">
									<xsl:with-param name="label">XSL_BALANCE_SUB_GROUP_PIVOT</xsl:with-param>
									<xsl:with-param name="name">subGrpPivot</xsl:with-param>
									<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param> 
									<xsl:with-param name="options">
										<option value="Yes">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_YES')"/>
										</option>
										<option value="No">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_NO')"/>
										</option>         
									</xsl:with-param>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_BALANCE_SUB_GROUP_PIVOT</xsl:with-param>
									<xsl:with-param name="name">subgrppivot_label</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>								
								</xsl:call-template>					
							</xsl:otherwise>
						</xsl:choose>
												
						<xsl:choose>
						<xsl:when test="$displaymode = 'edit'">
						 <xsl:call-template name="select-field">
						<xsl:with-param name="label">XSL_BALANCE_SUB_GROUP_TYPE</xsl:with-param>
						<xsl:with-param name="name">subGrpType</xsl:with-param>
						 <xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param> 
						<xsl:with-param name="options">
						<xsl:for-each select="liquidity_setting/liquidity_balance_type">
							    <xsl:variable name="currentsubgrpcode"><xsl:value-of select="./liquidity_balance_type_code"/></xsl:variable>							  
							    <xsl:if test="./checked[.='Y']"> 
			                  		<option>
			                     		<xsl:attribute name="value"><xsl:value-of select="$currentsubgrpcode"/></xsl:attribute>				                      		
										<xsl:value-of select="./liquidity_balance_type_desc"/>			                      		
			                   		</option>
							 	</xsl:if> 
							</xsl:for-each>				              
				          </xsl:with-param>
						</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
					     <xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_BALANCE_SUB_GROUP_TYPE</xsl:with-param>
								<xsl:with-param name="name">subGrp_label</xsl:with-param>
								<xsl:with-param name="override-displaymode">edit</xsl:with-param>								
							</xsl:call-template>					
						</xsl:otherwise>
						</xsl:choose>

						<xsl:choose>
							<xsl:when test="defaultresource:isKTPEnabled()">
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_LOW_BALANCE_TARGET</xsl:with-param>
									<xsl:with-param name="name">low_balance_target</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param> 
									<xsl:with-param name="size">35</xsl:with-param>
									<xsl:with-param name="maxsize">35</xsl:with-param>
									<xsl:with-param name="type">amount</xsl:with-param>
								</xsl:call-template>
						
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_HIGH_BALANCE_TARGET</xsl:with-param>
									<xsl:with-param name="name">high_balance_target</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param> 
									<xsl:with-param name="size">35</xsl:with-param>
									<xsl:with-param name="maxsize">35</xsl:with-param>
									<xsl:with-param name="type">amount</xsl:with-param>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_BALANCE_TARGET</xsl:with-param>
									<xsl:with-param name="name">balance_target</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param> 
									<xsl:with-param name="size">35</xsl:with-param>
									<xsl:with-param name="maxsize">35</xsl:with-param>
									<xsl:with-param name="type">amount</xsl:with-param>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
						
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_LOW_TARGET</xsl:with-param>
							<xsl:with-param name="name">low_target</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="type">amount</xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_HIGH_TARGET</xsl:with-param>
							<xsl:with-param name="name">high_target</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="type">amount</xsl:with-param>
						</xsl:call-template>
						
						<xsl:if test="defaultresource:isKTPEnabled()">
							<xsl:choose>
								<xsl:when test="$displaymode = 'edit'">
									<xsl:call-template name="select-field">
										<xsl:with-param name="label">XSL_INDIRECT_TYPE</xsl:with-param>
										<xsl:with-param name="name">indirect</xsl:with-param>
										<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param> 
										<xsl:with-param name="options">
											<option value="Y">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_YES')"/>
											</option>
											<option value="N">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_NO')"/>
											</option>         
										</xsl:with-param>
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="input-field">
										<xsl:with-param name="label">XSL_INDIRECT_TYPE</xsl:with-param>
										<xsl:with-param name="name">indirect</xsl:with-param>
										<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N034', indirect)"/></xsl:with-param>
										<xsl:with-param name="override-displaymode">edit</xsl:with-param>								
									</xsl:call-template>					
								</xsl:otherwise>
							</xsl:choose>		
						</xsl:if>
							 
						<!-- List of Accounts -->		
						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_LIST_OF_ACCOUNTS</xsl:with-param>
							<xsl:with-param name="legend-type">indented-header</xsl:with-param>
							<xsl:with-param name="toc-item">N</xsl:with-param>
							<xsl:with-param name="content">
								&nbsp;
							<xsl:call-template name="build-acct-sub-groups-dojo-items">
								   <xsl:with-param name="id">bal_account_identifiers</xsl:with-param>											
								</xsl:call-template> 
							</xsl:with-param>
						</xsl:call-template>	
											
					
							<div class="dijitDialogPaneActionBar">
								<xsl:call-template name="label-wrapper">
									<xsl:with-param name="content">
										<button type="button" dojoType="dijit.form.Button">
											<xsl:attribute name="onmouseup">dijit.byId('balsubgroup-dialog-template').hide();</xsl:attribute>
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
										</button>
										<xsl:if test="$displaymode = 'edit'">
											<button dojoType="dijit.form.Button">
												<xsl:attribute name="onClick">dijit.byId('balsubgroup-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
												<xsl:value-of
													select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
											</button>
										</xsl:if>										
									</xsl:with-param>
								</xsl:call-template>
						</div>
					</div>
				</div>
		</div>
	</xsl:template>	
	
	<xsl:template name="build-acct-sub-groups-dojo-items">		
		<xsl:param name="id" />
		<xsl:param name="items" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->

		<div dojoType="misys.liquidity.widget.BalAccounts" dialogId="balacctsubgroup-dialog-template" id="balacctsubgroup-items">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
		 <xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_ADD_ACCOUNT')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_MODIFY_ACCOUNT')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_VIEW_ACCOUNT')" /></xsl:attribute>	
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
			<xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="acctsubgroup" select="." />
					<div dojoType="misys.liquidity.widget.BalAccount">
					<xsl:attribute name="sub_group_code"><xsl:value-of
							select="$acctsubgroup/sub_group_code" /></xsl:attribute>					
						<xsl:attribute name="account_no"><xsl:value-of
							select="$acctsubgroup/account_no" /></xsl:attribute>
						<xsl:attribute name="account_id"><xsl:value-of
							select="$acctsubgroup/account_id" /></xsl:attribute>
						<xsl:attribute name="company_id"><xsl:value-of
							select="$acctsubgroup/company_id" /></xsl:attribute>
						<xsl:attribute name="sub_group_id"><xsl:value-of
							select="$acctsubgroup/sub_group_id" /></xsl:attribute>							
						<xsl:attribute name="sub_group_pivot"><xsl:value-of
							select="$acctsubgroup/sub_group_pivot" /></xsl:attribute>	
						<xsl:attribute name="acctdesc"><xsl:value-of
							select="$acctsubgroup/description" /></xsl:attribute>	
						
					</div>
				</xsl:for-each>
			</xsl:if>
		</div>

	</xsl:template>
	
 
	<!--
	Real form for FT INT
	-->
	<xsl:template name="realform">
		<xsl:call-template name="form-wrapper">
		    <xsl:with-param name="name">realform</xsl:with-param>
		    <xsl:with-param name="method">POST</xsl:with-param>
		    <xsl:with-param name="action" select="$realform-action"/>
		    <xsl:with-param name="content">
				<div class="widgetContainer">
					
				   
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">operation</xsl:with-param>
						<xsl:with-param name="id">realform_operation</xsl:with-param>
						<xsl:with-param name="value" select="$operation"></xsl:with-param> 
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">option</xsl:with-param>
						<xsl:with-param name="value">
							<xsl:choose>
								<xsl:when test="$option != ''"><xsl:value-of select="$option"/></xsl:when>
								<xsl:otherwise>LIQUIDITY_MC</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">token</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="$token"/></xsl:with-param>
					</xsl:call-template>
				
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">featureid</xsl:with-param>
						<xsl:with-param name="value"><xsl:value-of select="./structure_id"/></xsl:with-param>
					</xsl:call-template>
					
					<!-- <xsl:call-template name="hidden-field">
						<xsl:with-param name="name">tnxtype</xsl:with-param>
						<xsl:with-param name="value">01</xsl:with-param>
					</xsl:call-template>  -->
					<!-- <xsl:call-template name="hidden-field">
						<xsl:with-param name="name">attIds</xsl:with-param>
						<xsl:with-param name="value"/>
					</xsl:call-template> -->
				
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">tnxid</xsl:with-param>
						<xsl:with-param name="value" select="tnx_id"/>
					</xsl:call-template> 
					<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">processdttm</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="$processdttm"/></xsl:with-param>
						</xsl:call-template>
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">mode</xsl:with-param>
						<xsl:with-param name="value" select="$mode"/>
					</xsl:call-template> 
					<xsl:call-template name="e2ee_transaction"/>
						<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">TransactionData</xsl:with-param>
						<xsl:with-param name="value"/>
					</xsl:call-template>
			 <xsl:call-template name="reauth_params"/>
				</div>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	
	<xsl:template name="build-sub-groups-dojo-items">		
		<xsl:param name="id" />
		<xsl:param name="items" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->

		<div dojoType="misys.liquidity.widget.BalSubGroups" dialogId="balsubgroup-dialog-template" id="balsubgroup-items">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
		 <xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_ADD_SUB_GROUP')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_MODIFY_SUB_GROUP')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_VIEW_SUB_GROUP')" /></xsl:attribute>			
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
			<xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="balsubgrp" select="." />
					<div dojoType="misys.liquidity.widget.BalSubGroup">
						<xsl:attribute name="sub_group_code"><xsl:value-of select="$balsubgrp/sub_group_code" /></xsl:attribute>
						<xsl:attribute name="group_code"><xsl:value-of select="$balsubgrp/group_code" /></xsl:attribute>
						<xsl:attribute name="company_id"><xsl:value-of select="$balsubgrp/company_id" /></xsl:attribute>
						<xsl:attribute name="description"><xsl:value-of select="$balsubgrp/description" /></xsl:attribute>							
						<xsl:attribute name="subGrpPivot"><xsl:value-of select="$balsubgrp/sub_group_pivot" /></xsl:attribute>	
						<xsl:attribute name="subGrpType"><xsl:value-of select="$balsubgrp/sub_group_type" /></xsl:attribute>	
						<xsl:attribute name="balance_target"><xsl:value-of select="$balsubgrp/balance_target" /></xsl:attribute>	
						<xsl:attribute name="low_target"><xsl:value-of select="$balsubgrp/low_target" /></xsl:attribute>	
						<xsl:attribute name="high_target"><xsl:value-of select="$balsubgrp/high_target" /></xsl:attribute>	
						<xsl:attribute name="sub_group_id"><xsl:value-of select="$balsubgrp/sub_group_id" /></xsl:attribute>	
						<xsl:attribute name="group_id"><xsl:value-of select="$balsubgrp/group_id" /></xsl:attribute>
						<xsl:attribute name="indirect"><xsl:value-of select="$balsubgrp/indirect" /></xsl:attribute>
								
						<xsl:apply-templates select="$balsubgrp/acctsubgroups"/>
					</div>
				</xsl:for-each>
			</xsl:if>
		</div>

	</xsl:template>
	
	<xsl:template name="build-balgrp-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
		<div dojoType="misys.liquidity.widget.BalGroups" dialogId="balgroup-dialog-template" id="balgroup-items">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_ADD_BAL_GRP')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_EDIT_BAL_GRP')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_VIEW_BAL_GRP')" /></xsl:attribute>
			
		 	<xsl:for-each select="$items"> 
				<xsl:variable name="balgroup" select="." />
				
				<div dojoType="misys.liquidity.widget.BalGroup">
					<xsl:attribute name="group_code"><xsl:value-of select="$balgroup/group_code" /></xsl:attribute>
					<xsl:attribute name="structure_code"><xsl:value-of select="$balgroup/structure_code" /></xsl:attribute>
					<xsl:attribute name="description"><xsl:value-of select="$balgroup/description" /></xsl:attribute>
					<xsl:attribute name="frequency"><xsl:value-of select="$balgroup/frequency" /></xsl:attribute>
					<xsl:attribute name="frequency_label">
						<xsl:choose>
							<xsl:when test="defaultresource:isKTPEnabled()">
								<xsl:value-of select="localization:getDecode($language, 'C054', $balgroup/frequency)"/>					
							</xsl:when>
							<xsl:otherwise>
								<xsl:if test="$balgroup/freq_desc != ''">
									<xsl:value-of select="$balgroup/freq_desc" />
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<xsl:attribute name="balance_type"><xsl:value-of select="$balgroup/balance_type" /></xsl:attribute>
					<xsl:attribute name="balance_type_label">
						<xsl:choose>
							<xsl:when test="defaultresource:isKTPEnabled()">
								<xsl:value-of select="localization:getDecode($language, 'C072', $balgroup/balance_type)"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:if test="$balgroup/bal_desc != ''">
									<xsl:value-of select="$balgroup/bal_desc" />
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<xsl:attribute name="currency">	
					    <xsl:if test="$balgroup/currency != ''">				
							<xsl:value-of select="$balgroup/currency" />	
						</xsl:if>				
					</xsl:attribute>
					<xsl:attribute name="currency_label"><xsl:value-of select="$balgroup/currency" /></xsl:attribute>
					<xsl:attribute name="minimum"><xsl:value-of select="$balgroup/minimum" /></xsl:attribute>
					<xsl:attribute name="rounding"><xsl:value-of select="$balgroup/rounding" /></xsl:attribute>
					<xsl:attribute name="group_order"><xsl:value-of select="$balgroup/group_order" /></xsl:attribute>
					<xsl:attribute name="structure_id"><xsl:value-of select="$balgroup/structure_id" /></xsl:attribute>
					<xsl:attribute name="company_id"><xsl:value-of select="$balgroup/company_id" /></xsl:attribute>
					<xsl:attribute name="group_id"><xsl:value-of select="$balgroup/group_id" /></xsl:attribute>
				 <xsl:apply-templates select="$balgroup/balsubgroups"/> 
				</div>
		 </xsl:for-each> 
		</div>

	</xsl:template>
	
	
	
	<xsl:template match="balsubgroups">
	
		<div dojoType="misys.liquidity.widget.BalSubGroups">
			<xsl:apply-templates select="balsubgroup"/>			
	</div>
	</xsl:template>
	
	<xsl:template match="balsubgroup">	

		<div dojoType="misys.liquidity.widget.BalSubGroup">
			<xsl:attribute name="sub_group_code"><xsl:value-of select="sub_group_code" /></xsl:attribute>
			<xsl:attribute name="group_code"><xsl:value-of select="group_code" /></xsl:attribute>
			<xsl:attribute name="company_id"><xsl:value-of select="company_id" /></xsl:attribute>
			<xsl:attribute name="subgrp_description"><xsl:value-of select="description" /></xsl:attribute>							
			<xsl:attribute name="subGrpPivot"><xsl:value-of select="sub_group_pivot" /></xsl:attribute>	
			<xsl:attribute name="subgrppivot_label">
				<xsl:choose>
					<xsl:when test="defaultresource:isKTPEnabled()">
						<xsl:value-of select="localization:getDecode($language, 'N153', sub_group_pivot)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="subGrpPivot ='Y'"><xsl:value-of select="localization:getGTPString($language, 'XSL_YES')"/></xsl:if>
						<xsl:if test="subGrpPivot ='N'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NO')"/></xsl:if>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>	
			<xsl:attribute name="subGrpType"><xsl:value-of select="sub_group_type" /></xsl:attribute>
			<xsl:attribute name="subGrp_label">
				<xsl:choose>
					<xsl:when test="defaultresource:isKTPEnabled()">
						<xsl:value-of select="localization:getDecode($language, 'C055', sub_group_type)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="subgrp_desc != ''">
							<xsl:value-of select="subgrp_desc" />
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:attribute name="balance_target"><xsl:value-of select="balance_target" /></xsl:attribute>	
			<xsl:attribute name="low_balance_target"><xsl:value-of select="low_balance_target" /></xsl:attribute>	
			<xsl:attribute name="high_balance_target"><xsl:value-of select="high_balance_target" /></xsl:attribute>	
			<xsl:attribute name="low_target"><xsl:value-of select="low_target" /></xsl:attribute>	
			<xsl:attribute name="high_target"><xsl:value-of select="high_target" /></xsl:attribute>	
			<xsl:attribute name="sub_group_id"><xsl:value-of select="sub_group_id" /></xsl:attribute>	
			<xsl:attribute name="group_id"><xsl:value-of select="group_id" /></xsl:attribute>
			<xsl:attribute name="indirect"><xsl:value-of select="localization:getDecode($language, 'N034', indirect)"/></xsl:attribute>
		 	<xsl:if test="acctsubgroups != ''">
				<xsl:apply-templates select="acctsubgroups"/>
			</xsl:if> 
		</div>

	</xsl:template>
	
	 <xsl:template match="acctsubgroups">
		<div dojoType="misys.liquidity.widget.BalAccounts">
			<xsl:apply-templates select="acctsubgroup"/>
		</div>
	</xsl:template>
	
	 <xsl:template match="acctsubgroup">
		<div dojoType="misys.liquidity.widget.BalAccount">
			<xsl:attribute name="sub_group_code"><xsl:value-of select="sub_group_code" /></xsl:attribute>
			<xsl:attribute name="account_no"><xsl:value-of select="account_no" /></xsl:attribute>
			<xsl:attribute name="account_id"><xsl:value-of select="account_id" /></xsl:attribute>
			<xsl:attribute name="company_id"><xsl:value-of select="company_id" /></xsl:attribute>
			<xsl:attribute name="sub_group_id"><xsl:value-of select="sub_group_id" /></xsl:attribute>
			<xsl:attribute name="sub_group_pivot"><xsl:value-of select="sub_group_pivot" /></xsl:attribute>
			<xsl:attribute name="acctsubgrppivot_label">
				<xsl:choose>
					<xsl:when test="defaultresource:isKTPEnabled()">
						<xsl:if test="sub_group_pivot != ''">
							<xsl:value-of select="localization:getDecode($language, 'N154', sub_group_pivot)"/>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="sub_group_pivot != ''">
							<xsl:if test="sub_group_pivot[.='Yes']"><xsl:value-of select="localization:getGTPString($language, 'XSL_YES')"/></xsl:if>
							<xsl:if test="sub_group_pivot[.='No']"><xsl:value-of select="localization:getGTPString($language, 'XSL_NO')"/></xsl:if>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:attribute name="description"><xsl:value-of select="description" /></xsl:attribute>								
		</div>
	</xsl:template> 

	
	<xsl:template name="pooling-details">	  
		<xsl:call-template name="fieldset-wrapper">
   			<xsl:with-param name="legend">XSL_STRUCTURE_DETAILS</xsl:with-param>
   			<xsl:with-param name="button-type">
   				<xsl:if test="$hideMasterViewLink!='true'">mc-master-details</xsl:if>
   			</xsl:with-param> 
   			<xsl:with-param name="override-displaymode">edit</xsl:with-param>
   			<xsl:with-param name="content">
   			
   	    	<xsl:if test="$mode='copy'">   			
   			<xsl:call-template name="input-field">
			 		<xsl:with-param name="label">XSL_COPY_FROM</xsl:with-param>
			 		<xsl:with-param name="name">existing_structure_code</xsl:with-param>
			 		<xsl:with-param name="override-displaymode">view</xsl:with-param>
			 	</xsl:call-template>
			 	
			 	</xsl:if>
			 
   			<!-- structure Code -->
				<xsl:call-template name="input-field">
			 		<xsl:with-param name="label">XSL_STRUCTURE_CODE</xsl:with-param>
			 		<xsl:with-param name="name">structure_code</xsl:with-param>
			 		 <xsl:with-param name="required">Y</xsl:with-param>
			 	</xsl:call-template>
				<!-- structure description -->
				<xsl:call-template name="input-field">
			 		<xsl:with-param name="label">XSL_STRUCTURE_DESCRIPTION</xsl:with-param>
			 		<xsl:with-param name="name">structure_description</xsl:with-param>
			 		 <xsl:with-param name="required">Y</xsl:with-param>
			 	</xsl:call-template> 
			   <!--  Effective Date. --> 
		      <xsl:call-template name="input-field">
		       <xsl:with-param name="label">XSL_EFFECTIVE_DATE</xsl:with-param>
		       <xsl:with-param name="name">effective_date</xsl:with-param>
		       <xsl:with-param name="size">10</xsl:with-param>
		       <xsl:with-param name="maxsize">10</xsl:with-param>
		       <xsl:with-param name="type">date</xsl:with-param>
		       <xsl:with-param name="fieldsize">small</xsl:with-param>
		       <xsl:with-param name="required">Y</xsl:with-param>
		      </xsl:call-template>	
		 		
		 		<!-- hidden fields -->
		 	
              	<xsl:call-template name="hidden-field">
              		<xsl:with-param name="name">company_id</xsl:with-param>
             		<xsl:with-param name="value" select="company_id"/>
             	</xsl:call-template>
             		<xsl:call-template name="hidden-field">
              		<xsl:with-param name="name">existing_code</xsl:with-param>
             		<xsl:with-param name="value" select="structure_code"/>
             	</xsl:call-template>
             	<xsl:call-template name="hidden-field">
              		<xsl:with-param name="name">existing_eff_date</xsl:with-param>
             		<xsl:with-param name="value" select="effective_date"/>
             	</xsl:call-template>
             		<xsl:call-template name="hidden-field">
              		<xsl:with-param name="name">structure_id</xsl:with-param>
             		<xsl:with-param name="value" select="structure_id"/>
             	</xsl:call-template>             	
             	<xsl:call-template name="hidden-field">
              		<xsl:with-param name="name">reference</xsl:with-param>
             		<xsl:with-param name="value" select="reference"/>
             	</xsl:call-template>
             	<xsl:call-template name="hidden-field">
              		<xsl:with-param name="name">description</xsl:with-param>
             		<xsl:with-param name="value" select="structure_description"/>
             	</xsl:call-template>
             	<xsl:call-template name="hidden-field">
              		<xsl:with-param name="name">reg_exp_validationCode</xsl:with-param>
             		<xsl:with-param name="value" select="$validateCode"/>
             	</xsl:call-template>
             	<xsl:call-template name="hidden-field">
              		<xsl:with-param name="name">reg_exp_validationDesc</xsl:with-param>
             		<xsl:with-param name="value" select="$validateDescription"/>
             	</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>  
	<!-- for disclaimers -->
	<xsl:template name="simple-disclaimer">
		<xsl:param name="label"/>
		<div><xsl:value-of select="localization:getGTPString($language, $label)" disable-output-escaping="yes" /></div>
	</xsl:template>    	

</xsl:stylesheet>
