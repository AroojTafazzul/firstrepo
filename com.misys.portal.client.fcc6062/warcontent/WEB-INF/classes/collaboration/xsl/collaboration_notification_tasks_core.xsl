<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
 <!ENTITY nbsp "&#160;">
]>
<!--
##########################################################
Templates for

 Collaboration Floating Window.

Copyright (c) 2000-2011 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1
date:      11/04/2011
author:    Gurudath
email:     gurudath.reddy@misys.com
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
        exclude-result-prefixes="localization securitycheck security rundataservice utils">
        
        <!-- 
	   Global Parameters.
	   These are used in the imported XSL, and to set global params in the JS 
	  -->
	  <xsl:param name="rundata"/>
	   <!--
	   Static fields for the Notification Tasks list 
	   -->
	  <xsl:template name="notification-tasks-list">
	   <xsl:param name="connectedUserId"/>
	   <xsl:param name="productCode"/>
	   <xsl:param name="existing-tasks" select="todo_lists/todo_list/tasks/task[type = '01' and performed = 'N' and frozen != 'Y' and issue_user_id = $connectedUserId]"/>
	   
	   <xsl:variable name="connectedUserId">
	    <xsl:value-of select="rundataservice:getUserId($rundata)"/>
	   </xsl:variable>
	   <xsl:variable name="connectedCompanyAbbvName">
	    <xsl:value-of select="rundataservice:getCompanyAbbvName($rundata)"/>
	   </xsl:variable>
	   <xsl:variable name="userEmail">
	    <xsl:value-of select="rundataservice:getUserEmail($rundata)"/>
	   </xsl:variable>
	   
	   <!--
	    Display the list of existing tasks. 
	    -->
	   <xsl:call-template name="tasks-list">
	    <xsl:with-param name="existing-tasks" select="$existing-tasks"/>
	    <xsl:with-param name="type">notification_tasks</xsl:with-param>
	    <xsl:with-param name="connectedUserId"><xsl:value-of select="$connectedUserId"/></xsl:with-param>
	    <xsl:with-param name="connectedCompanyAbbvName"><xsl:value-of select="$connectedCompanyAbbvName"/></xsl:with-param>
	    <xsl:with-param name="noDataLabel">XSL_COLLABORATION_NO_NOTIFICATION</xsl:with-param>
	   </xsl:call-template>
	   
	   <div id="openNotificationTaskButtonDiv">
	    <button dojoType="dijit.form.Button" type="button" id="openNotificationTaskButton">
	     <xsl:attribute name="onclick">misys.openNotificationTaskDialog();</xsl:attribute>
	     <xsl:value-of select="localization:getGTPString($language, 'XSL_COLLABORATION_ADD_NOTIFICATION')"/>
	    </button>
	   </div>
	   
	   <!--
	    Submit form and hidden fields for each existing task 
	    -->
	   <xsl:call-template name="form-wrapper">
	    <xsl:with-param name="name">notification_tasks_form</xsl:with-param>
	    <xsl:with-param name="content">
	     <xsl:if test="count($existing-tasks) = 0">
	      <div></div> <!-- For HTML validation -->
	     </xsl:if>
	     <xsl:for-each select="$existing-tasks">
	      <xsl:call-template name="hidden-field">
	       <xsl:with-param name="name">notification_task_details_task_id_<xsl:value-of select="task_id"/></xsl:with-param>
	       <xsl:with-param name="value"><xsl:value-of select="task_id"/></xsl:with-param>
	      </xsl:call-template>
	      <xsl:call-template name="hidden-field">
	       <xsl:with-param name="name">notification_task_details_issue_date_<xsl:value-of select="task_id"/></xsl:with-param>
	       <xsl:with-param name="value"><xsl:value-of select="issue_date"/></xsl:with-param>
	      </xsl:call-template>
	      <xsl:call-template name="hidden-field">
	       <xsl:with-param name="name">notification_task_details_issue_user_id_<xsl:value-of select="task_id"/></xsl:with-param>
	       <xsl:with-param name="value"><xsl:value-of select="issue_user_id"/></xsl:with-param>
	      </xsl:call-template>
	      <xsl:call-template name="hidden-field">
	       <xsl:with-param name="name">notification_task_details_issue_company_abbv_name_<xsl:value-of select="task_id"/></xsl:with-param>
	       <xsl:with-param name="value"><xsl:value-of select="issue_company_abbv_name"/></xsl:with-param>
	      </xsl:call-template>
	      <xsl:call-template name="hidden-field">
	       <xsl:with-param name="name">notification_task_details_type_<xsl:value-of select="task_id"/></xsl:with-param>
	       <xsl:with-param name="value">01</xsl:with-param>
	      </xsl:call-template>
	     </xsl:for-each>
	    </xsl:with-param>
	   </xsl:call-template>
	  </xsl:template>
	  
	  <xsl:template name="notification-tasks-fields">
		  <xsl:param name="type">pre-validate</xsl:param>
		
		   <xsl:variable name="connectedUserId">
		    <xsl:value-of select="rundataservice:getUserId($rundata)"/>
		   </xsl:variable>
		  
		   <div id="notification-task-fields">
		    <xsl:call-template name="dialog">
		     <xsl:with-param name="id">notification_tasks_dialog</xsl:with-param>
		     <xsl:with-param name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TASK_DETAILS')"/></xsl:with-param>
		     <xsl:with-param name="show">N</xsl:with-param>
		     <xsl:with-param name="content">

		      <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">notification_task_id_nosend</xsl:with-param>
		      </xsl:call-template>

		      <xsl:call-template name="input-field">
		         <xsl:with-param name="label">XSL_COLLABORATION_TASK_ASSIGNEE</xsl:with-param>
		         <xsl:with-param name="name">notification_task_details_other_user_assignee_login_id_nosend</xsl:with-param>
		         <xsl:with-param name="maxsize">71</xsl:with-param>
		         <xsl:with-param name="size">20</xsl:with-param>
		         <xsl:with-param name="readonly">Y</xsl:with-param>
		         <xsl:with-param name="value">
		           <xsl:if test="dest_user_first_name[.!=''] or dest_user_last_name[.!='']">
		             <xsl:value-of select="dest_user_first_name"/>&nbsp;<xsl:value-of select="dest_user_last_name"/>
		           </xsl:if>
		         </xsl:with-param>
		         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
		         <xsl:with-param name="swift-validate">N</xsl:with-param>
		         <xsl:with-param name="button-type">user_collaboration_notification</xsl:with-param>
		      </xsl:call-template>
		      <xsl:call-template name="hidden-field">
	       		<xsl:with-param name="name">notification_task_details_other_user_assignee_user_id_nosend</xsl:with-param>
	       		<xsl:with-param name="value">
	       		  <xsl:if test="assignee_type = '01'">
	        		 <xsl:value-of select="dest_user_id"/>
	        	  </xsl:if>
	       		</xsl:with-param>
	   		  </xsl:call-template>
	   		  <xsl:call-template name="hidden-field">
		         <xsl:with-param name="name">other_user_email_id_hidden</xsl:with-param>
		        </xsl:call-template>
		      <xsl:call-template name="row-wrapper">
		        <xsl:with-param name="id">notification_task_details_description_nosend</xsl:with-param>
		        <xsl:with-param name="label">XSL_COLLABORATION_COMMENT</xsl:with-param>
		        <xsl:with-param name="override-displaymode">edit</xsl:with-param>
		        <xsl:with-param name="type">textarea</xsl:with-param>
		        <xsl:with-param name="content">
		         <xsl:call-template name="textarea-field">
		         <xsl:with-param name="name">notification_description_nosend</xsl:with-param>
		         <xsl:with-param name="rows">4</xsl:with-param>
		         <xsl:with-param name="cols">40</xsl:with-param>
		         <xsl:with-param name="maxlines">5</xsl:with-param>
		         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
		         <xsl:with-param name="swift-validate">N</xsl:with-param>
		        </xsl:call-template>
		       </xsl:with-param>
		      </xsl:call-template>
		      <xsl:call-template name="checkbox-field">
		      <xsl:with-param name="label">XSL_COLLABORATION_TASK_EMAIL_NOTIFICATION</xsl:with-param>
		       <xsl:with-param name="name">notification_task_details_email_notification_nosend</xsl:with-param>
		       <xsl:with-param name="checked">
		        <xsl:choose>
		         <xsl:when test="email_notification = 'Y'">Y</xsl:when>
		         <xsl:otherwise>N</xsl:otherwise>
		        </xsl:choose>
		       </xsl:with-param>
		       <xsl:with-param name="override-displaymode">edit</xsl:with-param>
		      </xsl:call-template>
		      <xsl:call-template name="input-field">
		       <xsl:with-param name="label">XSL_COLLABORATION_TASK_EMAIL</xsl:with-param>
		       <xsl:with-param name="name">notification_task_details_email_nosend</xsl:with-param>
		       <xsl:with-param name="readonly">Y</xsl:with-param>
		       <xsl:with-param name="disabled">Y</xsl:with-param>
		       <xsl:with-param name="value"><xsl:value-of select="email"/></xsl:with-param>
		       <xsl:with-param name="override-displaymode">edit</xsl:with-param>
		       <xsl:with-param name="swift-validate">N</xsl:with-param>
		      </xsl:call-template>
		     </xsl:with-param>
		     <xsl:with-param name="buttons">
		      <xsl:call-template name="row-wrapper">
		       <xsl:with-param name="id">addNotificationTaskButton</xsl:with-param>
		       <xsl:with-param name="override-displaymode">edit</xsl:with-param>
		       <xsl:with-param name="content">
		        <button dojoType="dijit.form.Button" type="button" id="addNotificationTaskButton"><xsl:attribute name="onclick">misys.addCollaborationTask('notification_tasks'<xsl:if test="$type = 'post-validate'"> , 'Y'</xsl:if>);</xsl:attribute><xsl:value-of select="localization:getGTPString($language, 'OK')"/></button>
		        <button dojoType="dijit.form.Button" type="button" id="dismissNotificationTaskDialog" title="Cancel" onmouseup="dijit.byId('notification_tasks_dialog').hide()"><xsl:value-of select="localization:getGTPString($language, 'CANCEL')"/></button>
		       </xsl:with-param>
		      </xsl:call-template>
		     </xsl:with-param>
		    </xsl:call-template>
		    <xsl:call-template name="tasks-comments">
		     <xsl:with-param name="type">notification_tasks</xsl:with-param>
		     <xsl:with-param name="existing-tasks" select="todo_lists/todo_list/tasks/task[type = '01' and performed = 'N' and frozen != 'Y' and issue_user_id = $connectedUserId]"/>
		    </xsl:call-template>
		   </div>
	 </xsl:template>
 </xsl:stylesheet>