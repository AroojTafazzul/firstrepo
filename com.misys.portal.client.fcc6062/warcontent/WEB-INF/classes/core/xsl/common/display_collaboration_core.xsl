<!--
##########################################################
Templates for displaying transaction summaries.

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      12/03/08
author:    Cormac Flynn
email:     cormac.flynn@misys.com
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
 xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools"
 xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
 xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
 xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
 xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
 xmlns:collabutils="xalan://com.misys.portal.common.tools.CollaborationUtils"
 exclude-result-prefixes="localization converttools xmlRender security utils collabutils">
 
 <xsl:param name="rundata"/>
 <xsl:param name="language">en</xsl:param>
 <xsl:param name="mode"/>
 <xsl:param name="displaymode">edit</xsl:param>
 <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
 <xsl:param name="product-code"/>
 <xsl:param name="main-form-name"/>
 <xsl:param name="realform-action"/>
 <xsl:param name="business-area">TRADE</xsl:param>
 
   <xsl:include href="trade_common.xsl"/>
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
   
  <xsl:template match="/">
   <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="lc_tnx_record | ri_tnx_record | li_tnx_record | sg_tnx_record | tf_tnx_record | el_tnx_record | ec_tnx_record | ic_tnx_record | ir_tnx_record | si_tnx_record | sr_tnx_record | bg_tnx_record | ft_tnx_record | po_tnx_record | so_tnx_record | in_tnx_record | br_tnx_record | ln_tnx_record | sw_tnx_record | td_tnx_record | fx_tnx_record | xo_tnx_record | eo_tnx_record | sw_tnx_record | ts_tnx_record | cs_tnx_record | cx_tnx_record | ct_tnx_record | st_tnx_record | se_tnx_record | la_tnx_record | to_tnx_record | sp_tnx_record | fa_tnx_record | bk_tnx_record | ip_tnx_record | br_tnx_record">
   	<div>
   	
   		<div class="widgetContainer">
   			<xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">ref_id</xsl:with-param>
		    </xsl:call-template>
		    <xsl:call-template name="common-hidden-fields"/>
   		</div>
   		
   		<xsl:if test="securitycheck:hasPermission(utils:getUserACL($rundata),'collaboration_access',utils:getUserEntities($rundata)) and ($displaymode='edit' or ($displaymode = 'view' and $collaborationmode != 'none'))">
	   		<div id="right_skiper" style="width: 330px; float: right;">
	   			&nbsp;
	   		</div>
   		</xsl:if>
   		
   		
   		<xsl:if test="$collaborationmode != 'none'">
   			<xsl:call-template name="collaboration">
				<xsl:with-param name="editable">true</xsl:with-param>
				<xsl:with-param name="productCode"><xsl:value-of select="product_code"/></xsl:with-param>
				<xsl:with-param name="contextPath"><xsl:value-of select="$contextPath"/></xsl:with-param>
				<xsl:with-param name="bank_name_widget_id"></xsl:with-param>
				<xsl:with-param name="bank_abbv_name_widget_id"></xsl:with-param>
				<xsl:with-param name="type">post-validate</xsl:with-param>
			</xsl:call-template>
   		</xsl:if>
   	</div>
   	<script>
		dojo.ready(function(){
			misys._config = misys._config || {};			
			misys._config.task_mode = '<xsl:value-of select="collabutils:getProductTaskMode($rundata, product_code, sub_product_code)"/>';
			dojo.mixin(misys, {
				preDisplayAssigneeType : function(/*Array of Objects*/ assigneeTypeFields){
			    	 var taskMode = misys._config.task_mode || "userandbank";
			    	 dojo.forEach(assigneeTypeFields, function(fieldObj){
			    		if(fieldObj.description === "user_to_bank" &amp;&amp; dijit.byId(fieldObj.id))
			    		{
			    			if(taskMode === "userandbank")
			    			{
			    				dijit.byId(fieldObj.id).set('disabled', false);
			    			}
			    			else
			    			{
			    				dijit.byId(fieldObj.id).set('disabled', true);
			    				console.info("Tasks for Bank is not allowed. Disabling the radio button.");
			    			}	
			    		}	 
			    	});
				}
			});
		});
	</script>
   </xsl:template>
  
 
 </xsl:stylesheet>