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
	   Static fields for the collaboration public tasks
	   -->
	  <xsl:template name="public-tasks">
	  		<xsl:param name="userId">
		    	<xsl:value-of select="rundataservice:getUserId($rundata)"/>
		   </xsl:param>
		   <xsl:param name="companyAbbvName">
		   		<xsl:value-of select="rundataservice:getCompanyAbbvName($rundata)"/>
		   </xsl:param>
	  		<xsl:param name="productCode"/>
	  		  <xsl:choose>
		   		<xsl:when test="(security:isCustomer($rundata)) and (not(security:isCounterparty($rundata)))">
		   				<xsl:call-template name="public-tasks-list">
		   					<xsl:with-param name="productCode" select="$productCode"></xsl:with-param>
		   					<xsl:with-param name="existing-tasks" select="todo_lists/todo_list/tasks/task[(type = '02' and frozen != 'Y') or (type = '03' and frozen != 'Y' and (issue_user_id = $userId or dest_user_id = $userId )) ]"></xsl:with-param>
		   				</xsl:call-template>
		   		</xsl:when>
	  		  <xsl:when test="(security:isCounterparty($rundata)) or ((security:isCustomer($rundata)) and ($productCode = 'IN' or $productCode = 'IP' or $productCode = 'CN' or $productCode = 'CR'))">
		   				<xsl:call-template name="public-tasks-list">
		   					<xsl:with-param name="productCode" select="$productCode"></xsl:with-param>
		   					<xsl:with-param name="existing-tasks" select="todo_lists/todo_list/tasks/task[(type = '03' and assignee_type = '03' and frozen != 'Y' and dest_company_abbv_name = $companyAbbvName) ]"></xsl:with-param>
		   				</xsl:call-template>
		   		</xsl:when>
		   		<xsl:when test="security:isBank($rundata)">
		   				<xsl:call-template name="public-tasks-list">
		   					<xsl:with-param name="productCode" select="$productCode"></xsl:with-param>
		   					<xsl:with-param name="existing-tasks" select="todo_lists/todo_list/tasks/task[(type = '03' and assignee_type = '02' and frozen != 'Y' and dest_company_abbv_name = $companyAbbvName )]"></xsl:with-param>
		   				</xsl:call-template>
		   		</xsl:when>
		   		
		      </xsl:choose>
	   </xsl:template>
	   
       <xsl:template name="public-tasks-list">
		   <xsl:param name="existing-tasks" /> 
		   <xsl:param name="productCode"/>
		   
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
		    <xsl:with-param name="type">public_tasks</xsl:with-param>
		    <xsl:with-param name="connectedUserId"><xsl:value-of select="$connectedUserId"/></xsl:with-param>
		    <xsl:with-param name="connectedCompanyAbbvName"><xsl:value-of select="$connectedCompanyAbbvName"/></xsl:with-param>
		   </xsl:call-template>
			
		   <xsl:if test="security:isCustomerNotCntrprty($rundata)">
		   <div id="openPublicTaskButtonDiv">
		    <button dojoType="dijit.form.Button" type="button" id="openPublicTaskButton">
		     <xsl:attribute name="onclick">misys.openPublicTaskDialog();</xsl:attribute>
		     <xsl:value-of select="localization:getGTPString($language, 'XSL_COLLABORATION_ADD_TASK')"/>
		    </button>
		   </div>
			</xsl:if>
		   <!--
		    Submit form and hidden fields for each existing task 
		    -->
		   <xsl:call-template name="form-wrapper">
		    <xsl:with-param name="name">public_tasks_form</xsl:with-param>
		    <xsl:with-param name="content">
		     <xsl:if test="count($existing-tasks) = 0">
		      <div></div> <!-- For HTML validation -->
		     </xsl:if>
		     <xsl:for-each select="$existing-tasks">
		      <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">public_task_details_task_id_<xsl:value-of select="task_id"/></xsl:with-param>
		       <xsl:with-param name="value"><xsl:value-of select="task_id"/></xsl:with-param>
		      </xsl:call-template>
		      <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">public_task_details_issue_date_<xsl:value-of select="task_id"/></xsl:with-param>
		       <xsl:with-param name="value"><xsl:value-of select="issue_date"/></xsl:with-param>
		      </xsl:call-template>
		      <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">public_task_details_issue_user_id_<xsl:value-of select="task_id"/></xsl:with-param>
		       <xsl:with-param name="value"><xsl:value-of select="issue_user_id"/></xsl:with-param>
		      </xsl:call-template>
		      <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">public_task_details_issue_company_abbv_name_<xsl:value-of select="task_id"/></xsl:with-param>
		       <xsl:with-param name="value"><xsl:value-of select="issue_company_abbv_name"/></xsl:with-param>
		      </xsl:call-template>
		      <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">public_task_details_type_<xsl:value-of select="task_id"/></xsl:with-param>
		       <xsl:with-param name="value">01</xsl:with-param>
		      </xsl:call-template>
		      <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">public_task_details_other_user_assignee_user_id_<xsl:value-of select="task_id"/></xsl:with-param>
		       <xsl:with-param name="value"><xsl:value-of select="dest_user_id"/></xsl:with-param>
		      </xsl:call-template>
		      <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">public_task_details_other_user_assignee_first_name_<xsl:value-of select="task_id"/></xsl:with-param>
		       <xsl:with-param name="value"><xsl:value-of select="dest_user_id"/></xsl:with-param>
		      </xsl:call-template>
		      <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">public_task_details_other_user_assignee_last_name_<xsl:value-of select="task_id"/></xsl:with-param>
		       <xsl:with-param name="value"><xsl:value-of select="dest_user_id"/></xsl:with-param>
		      </xsl:call-template>
		      <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">public_task_details_other_user_assignee_alt_login_id_<xsl:value-of select="task_id"/></xsl:with-param>
		       <xsl:with-param name="value"><xsl:value-of select="dest_user_login_id"/></xsl:with-param>
		      </xsl:call-template>
		      <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">public_task_details_bank_assignee_<xsl:value-of select="task_id"/></xsl:with-param>
		       <xsl:with-param name="value">
		        <xsl:if test="assignee_type = '02'">
		         <xsl:value-of select="dest_company_abbv_name"/>
		        </xsl:if>
		       </xsl:with-param>
		      </xsl:call-template>
		     <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">public_task_details_counterparty_assignee_abbv_name_<xsl:value-of select="task_id"/></xsl:with-param>
		       <xsl:with-param name="id">public_task_details_counterparty_assignee_abbv_name_bank_<xsl:value-of select="task_id"/></xsl:with-param>
		       <xsl:with-param name="value">
		        <xsl:if test="assignee_type = '03'">
		         <xsl:value-of select="dest_company_abbv_name"/>
		        </xsl:if>
		       </xsl:with-param>
		      </xsl:call-template>
		      <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">public_task_details_counterparty_assignee_abbv_name_<xsl:value-of select="task_id"/></xsl:with-param>
		       <xsl:with-param name="id">public_task_details_counterparty_assignee_abbv_name_counterparty_<xsl:value-of select="task_id"/></xsl:with-param>
		       <xsl:with-param name="value">
		        <xsl:if test="assignee_type = '03'">
		         <xsl:value-of select="dest_company_abbv_name"/>
		        </xsl:if>
		       </xsl:with-param>
		      </xsl:call-template>
		      <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">public_task_details_bank_other_user_assignee_user_id_<xsl:value-of select="task_id"/></xsl:with-param>
		       <xsl:with-param name="value"><xsl:value-of select="dest_user_id"/></xsl:with-param>
		      </xsl:call-template>
		      <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">public_task_details_bank_other_user_assignee_first_name_<xsl:value-of select="task_id"/></xsl:with-param>
		       <xsl:with-param name="value"><xsl:value-of select="first_name"/></xsl:with-param>
		      </xsl:call-template>
		      <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">public_task_details_bank_other_user_assignee_last_name_<xsl:value-of select="task_id"/></xsl:with-param>
		       <xsl:with-param name="value"><xsl:value-of select="last_name"/></xsl:with-param>
		      </xsl:call-template>
		      <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">public_task_details_bank_other_user_assignee_alt_login_id_<xsl:value-of select="task_id"/></xsl:with-param>
		       <xsl:with-param name="value"><xsl:value-of select="login_id"/></xsl:with-param>
		      </xsl:call-template>
		     </xsl:for-each>
		    </xsl:with-param>
		   </xsl:call-template>
	 </xsl:template>
	 
	 <xsl:template name="public-tasks-fields">
		 <xsl:param name="type">pre-validate</xsl:param>
		  <xsl:param name="productCode"/>
		  <div id="public-tasks-fields" style="display:none;">
		   <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">user_email_id_hidden</xsl:with-param>
		       <xsl:with-param name="value"><xsl:value-of select="rundataservice:getUserEmail($rundata)"/></xsl:with-param>
		   </xsl:call-template>
		   <xsl:call-template name="dialog">
		   <xsl:with-param name="id">public_tasks_dialog</xsl:with-param>
		   <xsl:with-param name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_TASK_DETAILS')"/></xsl:with-param>
		   <xsl:with-param name="content">
		    <div id="public_tasks_fields">

		     <!-- task if (hidden) -->		    
		      <xsl:call-template name="hidden-field">
		       <xsl:with-param name="name">public_task_id_nosend</xsl:with-param>
		      </xsl:call-template>

		     <!-- description -->
		     <xsl:call-template name="input-field">
		      <xsl:with-param name="label">XSL_COLLABORATION_TASK_DESCRIPTION</xsl:with-param>
		      <xsl:with-param name="name">public_task_details_description_nosend</xsl:with-param>
		      <xsl:with-param name="maxsize">200</xsl:with-param>
		      <xsl:with-param name="required">Y</xsl:with-param>
		      <xsl:with-param name="size">30</xsl:with-param>
		      <xsl:with-param name="override-displaymode">edit</xsl:with-param>
		      <xsl:with-param name="swift-validate">N</xsl:with-param>
		     </xsl:call-template>
		     
		     <!-- notify me ? -->
		     <xsl:call-template name="checkbox-field">
		      <xsl:with-param name="label">XSL_COLLABORATION_TASK_EMAIL_NOTIFICATION</xsl:with-param>
		      <xsl:with-param name="name">public_task_details_email_notification_nosend</xsl:with-param>
		      <xsl:with-param name="checked">
		       <xsl:choose>
		        <xsl:when test="email_notification = 'Y'">Y</xsl:when>
		        <xsl:otherwise>N</xsl:otherwise>
		       </xsl:choose>
		      </xsl:with-param>
		      <xsl:with-param name="override-displaymode">edit</xsl:with-param>
		     </xsl:call-template>
		     
		     <!-- email -->
		     <div id="email_input_field_div">
		     <xsl:call-template name="input-field">
		      <xsl:with-param name="label">XSL_COLLABORATION_TASK_EMAIL</xsl:with-param>
		      <xsl:with-param name="name">public_task_details_email_nosend</xsl:with-param>
		      <xsl:with-param name="readonly">Y</xsl:with-param>
		      <xsl:with-param name="disabled">Y</xsl:with-param>
		      <xsl:with-param name="value"><xsl:value-of select="email"/></xsl:with-param>
		      <xsl:with-param name="override-displaymode">edit</xsl:with-param>
		      <xsl:with-param name="swift-validate">N</xsl:with-param>
		     </xsl:call-template>
		     </div>
		     
		     <xsl:if test="security:isCustomer($rundata) and (securitycheck:hasPermission(utils:getUserACL($rundata), 'collaboration_add_public_task_for_other_user',utils:getUserEntities($rundata)) or securitycheck:hasPermission(utils:getUserACL($rundata), 'collaboration_add_public_task_for_bank',utils:getUserEntities($rundata)) or securitycheck:hasPermission(utils:getUserACL($rundata), 'collaboration_add_public_task_for_counterparty',utils:getUserEntities($rundata)))">
		     <!-- type (public or assigned) -->
		     <xsl:call-template name="multioption-group">
		      <xsl:with-param name="group-label">XSL_COLLABORATION_TASK_TYPE</xsl:with-param>
		      <xsl:with-param name="override-displaymode">edit</xsl:with-param>
		      <xsl:with-param name="content">
		      
		       <!-- public task -->
		       <xsl:call-template name="radio-field">
		        <xsl:with-param name="label">XSL_COLLABORATION_TASK_PUBLIC</xsl:with-param>
		        <xsl:with-param name="name">public_task_details_type_nosend</xsl:with-param>
		        <xsl:with-param name="id">public_task_details_type_nosend_2</xsl:with-param>
		        <xsl:with-param name="value">02</xsl:with-param>
		        <xsl:with-param name="checked">Y</xsl:with-param>
		        <xsl:with-param name="override-displaymode">edit</xsl:with-param>
		       </xsl:call-template>
		       
		       <!-- assigned task -->
		       <xsl:call-template name="radio-field">
		        <xsl:with-param name="label">XSL_COLLABORATION_TASK_ASSIGNED</xsl:with-param>
		        <xsl:with-param name="name">public_task_details_type_nosend</xsl:with-param>
		        <xsl:with-param name="id">public_task_details_type_nosend_3</xsl:with-param>
		        <xsl:with-param name="value">03</xsl:with-param>
		        <xsl:with-param name="override-displaymode">edit</xsl:with-param>
		       </xsl:call-template>
		      </xsl:with-param>
		     </xsl:call-template>
		     </xsl:if>
		     
		     <!-- To handle when all three permissions are not assigned -->
		     <xsl:if test="security:isCustomer($rundata) and (not(securitycheck:hasPermission(utils:getUserACL($rundata), 'collaboration_add_public_task_for_other_user',utils:getUserEntities($rundata)))) and (not(securitycheck:hasPermission(utils:getUserACL($rundata), 'collaboration_add_public_task_for_bank',utils:getUserEntities($rundata)))) and (not(securitycheck:hasPermission(utils:getUserACL($rundata), 'collaboration_add_public_task_for_counterparty',utils:getUserEntities($rundata))))">
		      <xsl:call-template name="input-field">
		       <xsl:with-param name="label">XSL_COLLABORATION_TASK_TYPE</xsl:with-param>
		       <xsl:with-param name="value"><xsl:value-of select="localization:getGTPString($language, 'XSL_COLLABORATION_TASK_PUBLIC')"/></xsl:with-param>
		       <xsl:with-param name="id">public_task_details_type_nosend_view</xsl:with-param>
		       <xsl:with-param name="override-displaymode">view</xsl:with-param>
		       <xsl:with-param name="swift-validate">N</xsl:with-param>
		      </xsl:call-template>
		      <xsl:call-template name="hidden-field">
		         <xsl:with-param name="name">public_task_details_type_nosend</xsl:with-param>
		         <xsl:with-param name="value">02</xsl:with-param>
		        </xsl:call-template>
		     </xsl:if>
		     
			<!-- assignee type -->
		     <xsl:if test="not(security:isBank($rundata))">
		     
		      <!--               -->
		      <!-- customer side -->
		      <!--               -->
			  <div id="assigneeTypeFields" style="display:none">
		       <xsl:call-template name="multioption-group">
		       <xsl:with-param name="group-label">XSL_COLLABORATION_TASK_ASSIGNEE_TYPE</xsl:with-param>
		       <xsl:with-param name="override-displaymode">edit</xsl:with-param>
		       <xsl:with-param name="content">
		
		        <!-- customer => other user -->
		        <xsl:if test="security:isCustomer($rundata) and securitycheck:hasPermission(utils:getUserACL($rundata), 'collaboration_add_public_task_for_other_user',utils:getUserEntities($rundata))">
		         <xsl:call-template name="radio-field">
		          <xsl:with-param name="label">XSL_COLLABORATION_TASK_ASSIGNEE_OTHER_USER</xsl:with-param>
		          <xsl:with-param name="name">public_task_details_assignee_type_nosend</xsl:with-param>
		          <xsl:with-param name="id">public_task_details_assignee_type_nosend_1</xsl:with-param>
		          <xsl:with-param name="disabled">Y</xsl:with-param>
		          <xsl:with-param name="value">01</xsl:with-param>
		          <xsl:with-param name="checked">
		           <xsl:choose>
		            <xsl:when test="assignee_type = '01'">Y</xsl:when>
		            <xsl:otherwise>N</xsl:otherwise>
		           </xsl:choose>
		          </xsl:with-param>
		          <xsl:with-param name="override-displaymode">edit</xsl:with-param>
		         </xsl:call-template>
		        </xsl:if>
		        
		        <!-- customer => bank   -->
		        <xsl:if test="security:isCustomer($rundata) and securitycheck:hasPermission(utils:getUserACL($rundata), 'collaboration_add_public_task_for_bank',utils:getUserEntities($rundata))">
		         <xsl:call-template name="radio-field">
		          <xsl:with-param name="label">XSL_COLLABORATION_TASK_ASSIGNEE_BANK</xsl:with-param>
		          <xsl:with-param name="name">public_task_details_assignee_type_nosend</xsl:with-param>
		          <xsl:with-param name="id">public_task_details_assignee_type_nosend_2</xsl:with-param>
		          <xsl:with-param name="value">02</xsl:with-param>
		          <xsl:with-param name="disabled">Y</xsl:with-param>
		          <xsl:with-param name="checked">
		           <xsl:choose>
		            <xsl:when test="assignee_type = '02'">Y</xsl:when>
		            <xsl:otherwise>N</xsl:otherwise>
		           </xsl:choose>
		          </xsl:with-param>
		          <xsl:with-param name="override-displaymode">edit</xsl:with-param>
		         </xsl:call-template>
		        </xsl:if>
		        
		        <!-- customer => counterparty -->
		        <xsl:if	test="security:isCustomer($rundata) and ($productCode='IP' or $productCode='IN' or $productCode='CN'  or $productCode='CR') and securitycheck:hasPermission(utils:getUserACL($rundata), 'collaboration_add_public_task_for_counterparty',utils:getUserEntities($rundata))">		        
		         <xsl:call-template name="radio-field">
		          <xsl:with-param name="label">XSL_COLLABORATION_TASK_ASSIGNEE_COUNTERPARTY</xsl:with-param>
		          <xsl:with-param name="name">public_task_details_assignee_type_nosend</xsl:with-param>
		          <xsl:with-param name="id">public_task_details_assignee_type_nosend_3</xsl:with-param>
		          <xsl:with-param name="value">03</xsl:with-param>
		          <xsl:with-param name="disabled">Y</xsl:with-param>
		          <xsl:with-param name="checked">
		           <xsl:choose>
		            <xsl:when test="assignee_type = '03'">Y</xsl:when>
		            <xsl:otherwise>N</xsl:otherwise>
		           </xsl:choose>
		          </xsl:with-param>
		          <xsl:with-param name="override-displaymode">edit</xsl:with-param>
		         </xsl:call-template>
		        </xsl:if>
		        
		        <!--           -->
		        <!-- bank side --> 
		        <!--           -->
		        <xsl:if test="security:isBank($rundata) and securitycheck:hasPermission(utils:getUserACL($rundata), 'collaboration_bank_add_public_task_for_other_user',utils:getUserEntities($rundata))">
		         <xsl:call-template name="radio-field">
		          <xsl:with-param name="label">XSL_COLLABORATION_TASK_ASSIGNEE_OTHER_USER</xsl:with-param>
		          <xsl:with-param name="name">public_task_details_assignee_type_nosend</xsl:with-param>
		          <xsl:with-param name="id">public_task_details_assignee_type_nosend_4</xsl:with-param>
		          <xsl:with-param name="value">04</xsl:with-param>
		          <xsl:with-param name="disabled">Y</xsl:with-param>
		          <xsl:with-param name="checked">
		           <xsl:choose>
		            <xsl:when test="assignee_type = '04'">Y</xsl:when>
		            <xsl:otherwise>N</xsl:otherwise>
		           </xsl:choose>
		          </xsl:with-param>
		          <xsl:with-param name="override-displaymode">edit</xsl:with-param> 
		         </xsl:call-template>
		        </xsl:if>
		       </xsl:with-param>
		      </xsl:call-template>
		     </div>
		    </xsl:if>   
		    
		    <!-- assignee -->
		    <xsl:choose>
		     <xsl:when test="security:isBank($rundata)">
		      
		      <!--           -->
		      <!-- bank side -->
		      <!--           -->
		      <xsl:if test="securitycheck:hasPermission(utils:getUserACL($rundata), 'collaboration_bank_add_public_task_for_other_user',utils:getUserEntities($rundata))">
		      
		       <!-- assignee -->
		       <div id="bankAssigneeTasks" style="display:none">
		        <xsl:call-template name="fieldset-wrapper">
		         <xsl:with-param name="legend">XSL_COLLABORATION_TASK_ASSIGNEE</xsl:with-param>
		         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
		         <xsl:with-param name="content">
		          <xsl:call-template name="input-field">
		           <xsl:with-param name="label">XSL_GENERALDETAILS_IMPORT_LC_REF_ID</xsl:with-param>
		           <xsl:with-param name="name">public_task_details_bank_other_user_assignee_login_id_nosend</xsl:with-param>
		           <xsl:with-param name="size">20</xsl:with-param>
		           <xsl:with-param name="button-type">user</xsl:with-param>
		           <xsl:with-param name="maxsize">71</xsl:with-param>
		           <xsl:with-param name="readonly">Y</xsl:with-param>
		           <xsl:with-param name="swift-validate">N</xsl:with-param>
		           <xsl:with-param name="value"><xsl:value-of select="dest_user_first_name"/>&nbsp;<xsl:value-of select="dest_user_last_name"/></xsl:with-param>
		           <xsl:with-param name="override-displaymode">edit</xsl:with-param>
		          </xsl:call-template>
		         </xsl:with-param>
		        </xsl:call-template>
		        
		        <!-- notify assignee ? -->
		        <xsl:call-template name="checkbox-field">
		         <xsl:with-param name="label">XSL_COLLABORATION_TASK_ASSIGNEE_EMAIL_NOTIFICATION</xsl:with-param>
		         <xsl:with-param name="name">public_task_details_bank_other_user_assignee_email_notification_nosend</xsl:with-param>
		         <xsl:with-param name="readonly">Y</xsl:with-param>
		         <xsl:with-param name="checked">
		          <xsl:choose>
		           <xsl:when test="dest_user_email_notif = 'Y'">Y</xsl:when>
		           <xsl:otherwise>N</xsl:otherwise>
		          </xsl:choose>
		         </xsl:with-param>
		         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
		        </xsl:call-template>
		        
		        <!-- email -->
		        <xsl:call-template name="input-field">
		         <xsl:with-param name="label">XSL_COLLABORATION_TASK_EMAIL</xsl:with-param>
		         <xsl:with-param name="name">public_task_details_bank_other_user_assignee_email_nosend</xsl:with-param>
		         <xsl:with-param name="maxsize">40</xsl:with-param>
		         <xsl:with-param name="readonly">Y</xsl:with-param>
		         <xsl:with-param name="size">30</xsl:with-param>
		         <xsl:with-param name="value"><xsl:value-of select="dest_user_email"/></xsl:with-param>
		         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
		         <xsl:with-param name="swift-validate">N</xsl:with-param>
		        </xsl:call-template>
		        </div>
		       </xsl:if>
		      </xsl:when>
		      <xsl:otherwise>
		      
		       <!--               -->
		       <!-- customer side -->
		       <!--               -->
		       
		       <!-- user -->
		       <div id="notifyUserFields" style="display:none">
		        <xsl:call-template name="input-field">
		         <xsl:with-param name="label">XSL_COLLABORATION_TASK_ASSIGNEE</xsl:with-param>
		         <xsl:with-param name="name">public_task_details_other_user_assignee_login_id_nosend</xsl:with-param>
		         <xsl:with-param name="maxsize">71</xsl:with-param>
		         <xsl:with-param name="size">20</xsl:with-param>
		         <xsl:with-param name="readonly">Y</xsl:with-param>
		         <xsl:with-param name="disabled">Y</xsl:with-param>
		         <xsl:with-param name="value">
		           <xsl:if test="dest_user_first_name[.!=''] or dest_user_last_name[.!='']">
		             <xsl:value-of select="dest_user_first_name"/>&nbsp;<xsl:value-of select="dest_user_last_name"/>
		           </xsl:if>
		         </xsl:with-param>
		         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
		         <xsl:with-param name="swift-validate">N</xsl:with-param>
		         <xsl:with-param name="button-type">user_collaboration</xsl:with-param>
		        </xsl:call-template>
		        <xsl:call-template name="hidden-field">
		       		<xsl:with-param name="name">public_task_details_other_user_assignee_user_id_nosend</xsl:with-param>
		       			<xsl:with-param name="value">
		       			 <xsl:if test="assignee_type = '01'">
		        			 <xsl:value-of select="dest_user_id"/>
		        		 </xsl:if>
		       		</xsl:with-param>
		   		</xsl:call-template>
		        <!-- notify user ? -->
		        <xsl:call-template name="checkbox-field">
		         <xsl:with-param name="label">XSL_COLLABORATION_TASK_OTHER_USER_EMAIL_NOTIFICATION</xsl:with-param>
		         <xsl:with-param name="name">public_task_details_other_user_assignee_email_notification_nosend</xsl:with-param>
		         <xsl:with-param name="checked">
		          <xsl:choose>
		           <xsl:when test="dest_user_email_notif = 'Y' and assignee_type = '01'">Y</xsl:when>
		           <xsl:otherwise>N</xsl:otherwise>
		          </xsl:choose>
		         </xsl:with-param>
		         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
		        </xsl:call-template>
		        
		        <!-- email -->
		        <!-- To hold the emailId temporarily to assign to (public_task_details_other_user_assignee_email_nosend) -->
		        <xsl:call-template name="hidden-field">
		         <xsl:with-param name="name">other_user_email_id_hidden</xsl:with-param>
		        </xsl:call-template>
		        <div id="other_user_email_input_field_div">
		        <xsl:call-template name="input-field">
		         <xsl:with-param name="label">XSL_COLLABORATION_TASK_EMAIL</xsl:with-param>
		         <xsl:with-param name="name">public_task_details_other_user_assignee_email_nosend</xsl:with-param>
		         <xsl:with-param name="value"><xsl:value-of select="dest_user_email"/></xsl:with-param>
		         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
		         <xsl:with-param name="swift-validate">N</xsl:with-param>
		        </xsl:call-template>
		        </div>
		       </div>
		       
		       <!-- bank -->
		       <div id="notifyBankFields" style="display:none">
		        <xsl:call-template name="input-field">
		         <xsl:with-param name="label">XSL_COLLABORATION_TASK_BANK</xsl:with-param>
		         <xsl:with-param name="name">public_task_details_bank_assignee_name_nosend</xsl:with-param>
		         <xsl:with-param name="readonly">Y</xsl:with-param>
		         <xsl:with-param name="disabled">Y</xsl:with-param>
		         <xsl:with-param name="value">
		          <xsl:if test="assignee_type = '02'">
		                <xsl:value-of select="dest_company_name"/>
		          </xsl:if>
		         </xsl:with-param>
		         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
		         <xsl:with-param name="swift-validate">N</xsl:with-param>
		        </xsl:call-template>
		        <xsl:call-template name="hidden-field">
		       		<xsl:with-param name="name">public_task_details_bank_assignee_abbv_name_nosend</xsl:with-param>
		       		<xsl:with-param name="value">
						<xsl:if test="assignee_type = '02'">
		                	<xsl:value-of select="dest_company_abbv_name"/>
		          		</xsl:if>
					</xsl:with-param>
		   		</xsl:call-template>
		        <!-- notify bank ? -->
		        <xsl:call-template name="checkbox-field">
		         <xsl:with-param name="label">XSL_COLLABORATION_TASK_BANK_EMAIL_NOTIFICATION</xsl:with-param>
		         <xsl:with-param name="name">public_task_details_bank_assignee_email_notification_nosend</xsl:with-param>
		         <xsl:with-param name="checked">
		          <xsl:choose>
		           <xsl:when test="dest_company_email_notif = 'Y' and assignee_type = '02'">Y</xsl:when>
		           <xsl:otherwise>N</xsl:otherwise>
		          </xsl:choose>
		         </xsl:with-param>
		         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
		        </xsl:call-template>
		       </div>
		
		       <!-- counterparty -->
		       <div id="notifyCounterpartyFields" style="display:none">
		        <xsl:call-template name="input-field">
		         <xsl:with-param name="label">XSL_COLLABORATION_TASK_COUNTERPARTY</xsl:with-param>
		         <xsl:with-param name="name">public_task_details_counterparty_assignee_name_nosend</xsl:with-param>
		         <xsl:with-param name="readonly">Y</xsl:with-param>
		         <xsl:with-param name="disabled">Y</xsl:with-param>
		          <xsl:with-param name="value">
		          <xsl:if test="assignee_type = '03'">
		           <xsl:value-of select="dest_company_name"/>
		          </xsl:if>
		         </xsl:with-param>
		         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
		         <xsl:with-param name="swift-validate">N</xsl:with-param>
		        </xsl:call-template>
		        <xsl:call-template name="hidden-field">
		       		<xsl:with-param name="name">public_task_details_counterparty_assignee_abbv_name_nosend</xsl:with-param>
		       		<xsl:with-param name="value">
						<xsl:if test="assignee_type = '03'">
		                	<xsl:value-of select="dest_company_abbv_name"/>
		          		</xsl:if>
					</xsl:with-param>
		   		</xsl:call-template>
		        
		        <!-- notify couterparty ? -->
		        <div class="widgetContainer">
		        <xsl:call-template name="checkbox-field">
		         <xsl:with-param name="label">XSL_COLLABORATION_TASK_COUNTERPARTY_EMAIL_NOTIFICATION</xsl:with-param>
		         <xsl:with-param name="name">public_task_details_counterparty_assignee_email_notification_nosend</xsl:with-param>
		         <xsl:with-param name="checked">
		          <xsl:choose>
		           <xsl:when test="dest_company_email_notif = 'Y' and assignee_type = '03'">Y</xsl:when>
		           <xsl:otherwise>N</xsl:otherwise>
		          </xsl:choose>
		         </xsl:with-param>
		         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
		        </xsl:call-template>
		        </div>
		        <!-- email -->
		        <xsl:call-template name="hidden-field">
		         <xsl:with-param name="name">counterparty_email_id_hidden</xsl:with-param>
		        </xsl:call-template>
		        <div id="counterparty_email_input_field_div">
		           <div class="widgetContainer">
		        <xsl:call-template name="input-field">
		         <xsl:with-param name="label">XSL_COLLABORATION_TASK_EMAIL</xsl:with-param>
		         <xsl:with-param name="name">public_task_details_counterparty_assignee_email_nosend</xsl:with-param>
		         <xsl:with-param name="value"><xsl:value-of select="dest_company_email"/></xsl:with-param>
		         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
		         <xsl:with-param name="swift-validate">N</xsl:with-param>
		        </xsl:call-template>
		        </div>
		        </div>
		       </div>
		      </xsl:otherwise>
		     </xsl:choose>
		    </div>
		   </xsl:with-param>
		   <xsl:with-param name="buttons">
		    <xsl:call-template name="row-wrapper">
		      <xsl:with-param name="id">addPublicTaskButton</xsl:with-param>
		      <xsl:with-param name="override-displaymode">edit</xsl:with-param>
		      <xsl:with-param name="content">
		       <button dojoType="dijit.form.Button" type="button" id="addPublicTaskButton"><xsl:attribute name="onclick">misys.addCollaborationTask('public_tasks'<xsl:if test="$type = 'post-validate'"> , 'Y'</xsl:if>);</xsl:attribute><xsl:value-of select="localization:getGTPString($language, 'OK')"/></button>
		       <button dojoType="dijit.form.Button" type="button" id="dismissPublicTaskDialog" title="Cancel"><xsl:attribute name="onclick">misys.cancelCollaborationTask('public_tasks');</xsl:attribute><xsl:value-of select="localization:getGTPString($language, 'CANCEL')"/></button>
		      </xsl:with-param>
		     </xsl:call-template>
		   </xsl:with-param>
		  </xsl:call-template>
		   <xsl:call-template name="tasks-comments">
		    <xsl:with-param name="type">public_tasks</xsl:with-param>
		    <xsl:with-param name="existing-tasks" select="todo_lists/todo_list/tasks/task"/>
		   </xsl:call-template>
		  </div>
	</xsl:template>
</xsl:stylesheet>