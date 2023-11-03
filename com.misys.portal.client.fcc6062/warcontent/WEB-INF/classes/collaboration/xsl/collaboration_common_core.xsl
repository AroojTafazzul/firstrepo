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
	  
	  <xsl:template name="tasks-comments">
		  <xsl:param name="type">public_tasks</xsl:param>
		  <xsl:param name="existing-tasks" select="todo_lists/todo_list/tasks/task"/>
		  
		  <xsl:variable name="connectedUserId">
		   <xsl:value-of select="rundataservice:getUserId($rundata)"/>
		  </xsl:variable>
		  <xsl:variable name="connectedCompanyAbbvName">
		   <xsl:value-of select="rundataservice:getCompanyAbbvName($rundata)"/>
		  </xsl:variable>
		 
		  <!--
		   Hidden comments form for existing tasks 
		   -->
		  <div style="display:none">
		   <xsl:attribute name="id"><xsl:value-of select="$type"/>_comments_div</xsl:attribute>
		   
		   <xsl:call-template name="dialog">
		  		<xsl:with-param name="id"><xsl:value-of select="$type"/>_comments_dialog</xsl:with-param>
		  		<xsl:with-param name="title"><xsl:value-of select="localization:getGTPString($language, 'XSL_COLLABORATION_SHOW_COMMENTS')"/></xsl:with-param>
		  		<xsl:with-param name="content">
		      	<div>
		    		<xsl:attribute name="id"><xsl:value-of select="$type"/>_comment_fields</xsl:attribute>
				    <xsl:for-each select="$existing-tasks">
				      <ol style="display:none" class="comment-list">
				       <xsl:attribute name="id"><xsl:value-of select="$type"/>_comments_<xsl:value-of select="task_id"/></xsl:attribute>
				       <xsl:for-each select="comments/comment">
				        <li>
				         <xsl:value-of select="description"/><br/>
				         <span class="commentInfo">
				          <xsl:value-of select="localization:getGTPString($language, 'XSL_COLLABORATION_POSTED_BY')"/>&nbsp;
				          <xsl:choose>
				           <xsl:when test="issue_company_abbv_name = $connectedCompanyAbbvName">
				            <xsl:choose>
				             <xsl:when test="issue_user_id = $connectedUserId">
				              <xsl:value-of select="localization:getGTPString($language, 'XSL_COLLABORATION_YOU')"/>
				             </xsl:when>
				             <xsl:otherwise>
				              <xsl:value-of select="issue_user_first_name"/>&nbsp;<xsl:value-of select="issue_user_last_name"/>
				             </xsl:otherwise>
				            </xsl:choose>
				           </xsl:when>
				           <xsl:otherwise>
				            <xsl:value-of select="issue_company_name"/>
				           </xsl:otherwise>
				          </xsl:choose>
				          &nbsp;<xsl:value-of select="localization:getGTPString($language, 'XSL_COLLABORATION_ON')"/>&nbsp;<xsl:value-of select="issue_date"/>
				         </span>
				        </li>
				       </xsl:for-each>
				      </ol>
				     </xsl:for-each>
				     <!-- Comment Form for submitting a new comment. -->
				     <xsl:call-template name="form-wrapper">
				      <xsl:with-param name="name"><xsl:value-of select="$type"/>_comments_form</xsl:with-param>
				      <xsl:with-param name="content">
				       <xsl:call-template name="row-wrapper">
				        <xsl:with-param name="id"><xsl:value-of select="$type"/>_description_nosend</xsl:with-param>
				        <xsl:with-param name="label">XSL_COLLABORATION_COMMENT</xsl:with-param>
				        <xsl:with-param name="override-displaymode">edit</xsl:with-param>
				        <xsl:with-param name="content">
				         <xsl:call-template name="textarea-field">
				         <xsl:with-param name="name"><xsl:value-of select="$type"/>_description_nosend</xsl:with-param>
				         <xsl:with-param name="rows">4</xsl:with-param>
				         <xsl:with-param name="cols">40</xsl:with-param>
				         <xsl:with-param name="maxlines">5</xsl:with-param>
				         <xsl:with-param name="override-displaymode">edit</xsl:with-param>
				         <xsl:with-param name="swift-validate">N</xsl:with-param>
				        </xsl:call-template>
				       </xsl:with-param>
				      </xsl:call-template>
				     </xsl:with-param>
				    </xsl:call-template>
				    <!-- Stores the id of the last opened task -->
				    <xsl:call-template name="hidden-field">
				     <xsl:with-param name="name"><xsl:value-of select="$type"/>_comments_current_id_nosend</xsl:with-param>
				    </xsl:call-template>
		    	</div>
		   	   </xsl:with-param>
			   <xsl:with-param name="buttons">
			   <div>
			       <button dojoType="dijit.form.Button" type="button">
			        <xsl:attribute name="onclick">misys.addCollaborationComment('<xsl:value-of select="$type"/>')</xsl:attribute>
			        <xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')"/>
			       </button>
			       <button dojoType="dijit.form.Button" type="button" title="Cancel">
			        <xsl:attribute name="onmouseup">dijit.byId('<xsl:value-of select="$type"/>_comments_dialog').hide()</xsl:attribute>
			        Exit
			       </button>
			      </div>
			  </xsl:with-param>
		 </xsl:call-template>
		</div>
 	</xsl:template>
	 
	<!-- Tasks List --> 
	<xsl:template name="tasks-list">
		  <xsl:param name="type"/>
		  <xsl:param name="existing-tasks"/>
		  <xsl:param name="connectedUserId"/>
		  <xsl:param name="connectedCompanyAbbvName"/>
		  <xsl:param name="noDataLabel">XSL_COLLABORATION_NO_TASK</xsl:param>
		  
		  <ol>
		   <xsl:attribute name="id"><xsl:value-of select="$type"/>_master_list</xsl:attribute>
		   <xsl:if test="count($existing-tasks) = 0">
		    <xsl:attribute name="style">display:none;</xsl:attribute>
		    <li style="display:none"></li> <!-- For HTML validation purposes -->
		   </xsl:if>
		
		   <xsl:for-each select="$existing-tasks">
		    <li>
		     <xsl:attribute name="id"><xsl:value-of select="$type"/>_item_<xsl:value-of select="task_id"/></xsl:attribute>
		     <label for="irv_flag">
		      <xsl:attribute name="for"><xsl:value-of select="$type"/>_dismiss_<xsl:value-of select="task_id"/></xsl:attribute>
		      
		      <!-- <xsl:if test="security:isCustomer($rundata)">-->
		      <input dojoType="dijit.form.CheckBox" type="checkbox">
		       <xsl:attribute name="id"><xsl:value-of select="$type"/>_dismiss_<xsl:value-of select="task_id"/></xsl:attribute>
		       <xsl:attribute name="name"><xsl:value-of select="$type"/>_dismiss_<xsl:value-of select="task_id"/></xsl:attribute>
		       <xsl:attribute name="onclick">misys.finishCollaborationTask(this,'<xsl:value-of select="$type"/>','<xsl:value-of select="task_id"/>');</xsl:attribute>
		       <xsl:if test="performed = 'Y'"><xsl:attribute name="checked"/></xsl:if>
		      </input>
		      <!-- </xsl:if>-->
		      <span>
		       <xsl:choose>
		    		<xsl:when test="performed = 'Y'"><xsl:attribute name="class">checkBoxTextLineThrough</xsl:attribute></xsl:when>
		     		<xsl:when test="performed = 'N'"><xsl:attribute name="class">checkBoxTextLineNone</xsl:attribute></xsl:when>
		     	</xsl:choose> 	
		       <xsl:attribute name="id"><xsl:value-of select="$type"/>_desc_<xsl:value-of select="task_id"/></xsl:attribute>
		       <xsl:value-of select="description"/>
		      </span>
		     </label>
		     <span class="taskInfo">
		      <xsl:value-of select="localization:getGTPString($language, 'XSL_COLLABORATION_POSTED_BY')"/>&nbsp;
		      <xsl:choose>
		       <xsl:when test="issue_company_abbv_name = $connectedCompanyAbbvName">
		        <xsl:choose>
		         <xsl:when test="issue_user_id = $connectedUserId">
		          <xsl:value-of select="localization:getGTPString($language, 'XSL_COLLABORATION_YOU')"/>
		         </xsl:when>
		         <xsl:otherwise>
		          <xsl:value-of select="issue_user_first_name"/>&nbsp;<xsl:value-of select="issue_user_last_name"/>
		         </xsl:otherwise>
		        </xsl:choose>
		       </xsl:when>
		       <xsl:otherwise>
		        <xsl:value-of select="issue_company_name"/>
		       </xsl:otherwise>
		      </xsl:choose>
		      &nbsp;<xsl:value-of select="localization:getGTPString($language, 'XSL_COLLABORATION_ON')"/>&nbsp;<xsl:value-of select="issue_date"/>
		     </span>
		     <xsl:if test="issue_user_id = $connectedUserId">
				<span class="commentInfo">
					<xsl:attribute name="id">task_edit_<xsl:value-of select="task_id"/></xsl:attribute>
					<xsl:choose>
						<xsl:when test="performed = 'N'">
							<xsl:attribute name="style">display:inline</xsl:attribute>
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="style">display:none</xsl:attribute>
						</xsl:otherwise>
					</xsl:choose>
					&nbsp;|&nbsp;				 
					<a href="javascript:void(0)">
						<xsl:attribute name="onClick">misys.openTaskForUpdate('<xsl:value-of select="task_id"/>')</xsl:attribute>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_COLLABORATION_EDIT_TASK')"/>
					</a>
				</span>
			</xsl:if>
		     <span class="commentInfo">
		      &nbsp;|&nbsp;
		      <a href="javascript:void(0)">
		       <xsl:attribute name="onClick">misys.openCollaborationComment('<xsl:value-of select="$type"/>','<xsl:value-of select="task_id"/>')</xsl:attribute>
		       <xsl:value-of select="localization:getGTPString($language, 'XSL_COLLABORATION_SHOW_COMMENTS')"/> (<span><xsl:attribute name="id"><xsl:value-of select="$type"/>_comment_count_<xsl:value-of select="task_id"/></xsl:attribute>
		       <xsl:value-of select="count(comments/comment)"/></span>)
		      </a>
		     </span>
		    </li>
		   </xsl:for-each>
		  </ol>
		  <!-- Disclaimer -->
		  <p class="empty-list-notice">
		   <xsl:attribute name="id"><xsl:value-of select="$type"/>_notice</xsl:attribute>
		   <xsl:if test="count($existing-tasks)!=0">
		    <xsl:attribute name="style">display:none</xsl:attribute>
		   </xsl:if>
		   <strong><xsl:value-of select="localization:getGTPString($language, $noDataLabel)"/></strong>
		  </p>
 	</xsl:template>  
	  
</xsl:stylesheet>