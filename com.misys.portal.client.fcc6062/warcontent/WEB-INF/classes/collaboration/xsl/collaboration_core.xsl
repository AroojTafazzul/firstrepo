<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
 <!ENTITY nbsp "&#160;">
]>
<!--
##########################################################
Templates for

 Collaboration Floating Window.

Copyright (c) 2000-2009 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.1
date:      23/01/09
author:    Cormac Flynn
email:     cormac.flynn@misys.com
##########################################################
-->

<xsl:stylesheet 
        version="1.0" 
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
        xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
        xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
        xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
        xmlns:rundataservice="xalan://com.misys.portal.services.rundata.GTPRunDataService"
        xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
        xmlns:collabutils="xalan://com.misys.portal.common.tools.CollaborationUtils"
        exclude-result-prefixes="localization securitycheck security rundataservice utils collabutils">
  
  <!-- 
   Global Parameters.
   These are used in the imported XSL, and to set global params in the JS 
  -->
  <xsl:param name="rundata"/>
  <xsl:include href="collaboration_common.xsl" />
  <xsl:include href="collaboration_notification_tasks.xsl" />
  <xsl:include href="collaboration_private_tasks.xsl" />
  <xsl:include href="collaboration_public_tasks.xsl" />
  
  
  <xsl:template name="collaboration">
   <xsl:param name="editable"/>
   <xsl:param name="productCode"/>
   <xsl:param name="contextPath"/>
   <xsl:param name="type">pre-validate</xsl:param>
   <xsl:param name="any-existing-tasks" select="todo_lists/todo_list/tasks/task[(type = '01' or type = '02' or type = '03')  and performed = 'N' and frozen != 'Y']"></xsl:param>
   <xsl:param name="bank_name_widget_id"></xsl:param>
   <xsl:param name="bank_abbv_name_widget_id"></xsl:param>
   <!-- 
    Only display the floating window if we have the security permission, and if we're 
    in edit mode, or in the collaboration summary screen.
   -->
   
   <xsl:if test="securitycheck:hasPermission(utils:getUserACL($rundata),'collaboration_access',utils:getUserEntities($rundata)) and $collaborationmode != 'none' and (tnx_stat_code='' or tnx_stat_code= '01' or tnx_stat_code= '02')">

     <!-- Floating Window -->
     <div id="collaborationWindowContainer">
     
     <div id="collaborationWindow">
      <xsl:choose>
      	<xsl:when test="$type = 'post-validate'">
      		<xsl:attribute name="dojotype">misys.layout.FloatingPane</xsl:attribute>
      		<xsl:attribute name="resizable">true</xsl:attribute>
      		<xsl:attribute name="closable">false</xsl:attribute>
      		<xsl:attribute name="dockable">false</xsl:attribute>
      		<xsl:attribute name="open">
	      		<xsl:choose>
	      			<xsl:when test="tnx_stat_code = '02' or tnx_stat_code = '06'">true</xsl:when>
	      			<xsl:otherwise>false</xsl:otherwise>
	      		</xsl:choose>
      		</xsl:attribute>
      	</xsl:when>
      	<xsl:otherwise>
      		<xsl:attribute name="dojotype">misys.layout.FloatingPane</xsl:attribute>
      		<xsl:attribute name="resizable">true</xsl:attribute>
      		<xsl:attribute name="closable">false</xsl:attribute>
      		<xsl:attribute name="dockable">false</xsl:attribute>
      		<xsl:attribute name="open">
	      		<xsl:choose>
	      			<xsl:when test="count($any-existing-tasks) > 0">true</xsl:when>
	      			<xsl:otherwise>false</xsl:otherwise>
	      		</xsl:choose>
      		</xsl:attribute>
      	</xsl:otherwise>
      </xsl:choose>
      
      <xsl:attribute name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_COLLABORATION_WINDOW_TITLE')"/></xsl:attribute>

     <!-- <div dojotype="dijit.layout.TabContainer" id="tasksContainer"> --> 
	       
       <xsl:if test="$type = 'post-validate'">
	       <!-- Notification Tasks -->
	       <div class="tasksBox">
	        <div class="tasksBoxTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_COLLABORATION_NOTIFICATION_TASKS')"/></div>
		      <xsl:call-template name="notification-tasks-list">
		        <xsl:with-param name="productCode" select="$productCode"/>
		      </xsl:call-template>
	       </div>
	       <br/>
	       <div id = "show-tasks-details-link">
	       	  <a href="javascript:void(0)" onclick="misys.showCollaborationTaskDetails();return false;"><xsl:value-of select="localization:getGTPString($language, 'XSL_MORE_TASKS')"/></a>
	       </div>
       </xsl:if>

	       
	  <div id="collaboration-more-tasks">
	  	<xsl:if test="$type = 'post-validate'">
	  		<xsl:attribute name="style">display: none;</xsl:attribute>
	  	</xsl:if>
        <!-- Public Tasks -->
        <div class="tasksBox">
        	<div class="tasksBoxTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_COLLABORATION_PUBLIC_TASKS')"/></div>
	        <xsl:call-template name="public-tasks">
	         <xsl:with-param name="productCode" select="$productCode"/>
	        </xsl:call-template>
	        <xsl:call-template name="hidden-field">
      			<xsl:with-param name="name">bank_name_widget_id_hidden</xsl:with-param>
      			<xsl:with-param name="value"><xsl:value-of select="$bank_name_widget_id"/></xsl:with-param>
  			</xsl:call-template>
	        <xsl:call-template name="hidden-field">
      			<xsl:with-param name="name">bank_abbv_name_widget_id_hidden</xsl:with-param>
      			<xsl:with-param name="value"><xsl:value-of select="$bank_abbv_name_widget_id"/></xsl:with-param>
  			</xsl:call-template>
  		</div>

       <xsl:if test="securitycheck:hasPermission(utils:getUserACL($rundata), 'collaboration_add_private_task',utils:getUserEntities($rundata)) or securitycheck:hasPermission(utils:getUserACL($rundata), 'collaboration_bank_add_private_task',utils:getUserEntities($rundata))">
       	<!-- Private Tasks -->
       	<xsl:if test="not(security:isBank($rundata))">
       		<br></br>
       		<div class="tasksBox">
       		  <div class="tasksBoxTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_COLLABORATION_PRIVATE_TASKS')"/></div>
		         <xsl:call-template name="private-tasks-list">
		          <xsl:with-param name="productCode" select="$productCode"/>
		          <xsl:with-param name="connectedUserId" select="rundataservice:getUserId($rundata)"/>
		         </xsl:call-template>
	        </div>
	    </xsl:if>
       </xsl:if>
       </div>
     <!--  </div>  -->

      <xsl:call-template name="form-wrapper">
      	<xsl:with-param name="name">collaboration_form</xsl:with-param>
      	<xsl:with-param name="validating">Y</xsl:with-param>
      	<xsl:with-param name="content">
      		<xsl:call-template name="hidden-field">
	   			<xsl:with-param name="name">todo_list_id</xsl:with-param>
	   			<xsl:with-param name="value">
		   			<xsl:choose>
	   					<xsl:when test="todo_lists/todo_list/todo_list_id">
	   						<xsl:value-of select="todo_lists/todo_list/todo_list_id" />
	     				</xsl:when>
	     				<xsl:otherwise>
	    	   				<xsl:value-of select="utils:getNextStringId('GTP_TODO_LIST_SEQ')" />
	     				</xsl:otherwise>
	   				</xsl:choose>
	   			</xsl:with-param>
	  		</xsl:call-template>
      	</xsl:with-param>
      </xsl:call-template>

	  <xsl:call-template name="hidden-field">
	   <xsl:with-param name="name">connected_user_id</xsl:with-param>
	   <xsl:with-param name="value"><xsl:value-of select="rundataservice:getUserId($rundata)"/></xsl:with-param>
	  </xsl:call-template>
	  <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">connected_company_abbv_name</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="rundataservice:getCompanyAbbvName($rundata)"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">user_email</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="rundataservice:getUserEmail($rundata)"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">sentence_posted_by</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_COLLABORATION_POSTED_BY')"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">sentence_you</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_COLLABORATION_YOU')"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">sentence_to</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_COLLABORATION_TO')"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">sentence_on</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_COLLABORATION_ON')"/></xsl:with-param>
      </xsl:call-template>
     </div>
	</div>
   <xsl:if test="$displaymode='edit' or ($displaymode = 'view' and $collaborationmode != 'none')">
    <xsl:call-template name="notification-tasks-fields">
    	<xsl:with-param name="type"><xsl:value-of select="$type"/> </xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="private-tasks-fields">
    	<xsl:with-param name="type"><xsl:value-of select="$type"/> </xsl:with-param>
    	<xsl:with-param name="productCode" select="$productCode"/>
    </xsl:call-template>
    <xsl:call-template name="public-tasks-fields">
    	<xsl:with-param name="type"><xsl:value-of select="$type"/> </xsl:with-param>
    	<xsl:with-param name="productCode" select="$productCode"/>
    </xsl:call-template>
   </xsl:if>
   
   <script>
		dojo.ready(function(){			
	   		misys._config = misys._config || {};			
			misys._config.task_mode = '<xsl:value-of select="collabutils:getProductTaskMode($rundata, product_code, sub_product_code)"/>';
		});
 	</script>
   
   </xsl:if>   
  </xsl:template>
  
</xsl:stylesheet>