<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for : TO DO : CANCEL + PASSBACK ENTITY

 Bank Company Screen, System Form (Attached Banks Screen).

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      01/03/2012
author:    Pavan Kumar
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
    xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
    xmlns:java="http://xml.apache.org/xalan/java"
    xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
    exclude-result-prefixes="localization defaultresource java">
    
    <xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
    <xsl:param name="actionDownImage"><xsl:value-of select="$images_path"/>action-down.png</xsl:param>
	<xsl:param name="actionUpImage"><xsl:value-of select="$images_path"/>action-up.png</xsl:param>
    
    
	<xsl:template match="error_log">
    <xsl:param name="file_ref_id"/>
    <xsl:param name="file_name"/>
	    <xsl:call-template name="fieldset-wrapper">
	     <xsl:with-param name="legend">XSL_ERROR_LOG</xsl:with-param>
	     <xsl:with-param name="content">
	     	<xsl:choose>	
	     	<xsl:when test="count(file_error/errors/error) >=1 or count(batch_error/errors/error) >=1 or count(validation_error/errors/error) >=1 or count(transaction_error/errors/error) >=1">
	        <xsl:if test="count(file_error/errors/error) >=1">
	         <xsl:call-template name="fieldset-wrapper">
	           <xsl:with-param name="legend">XSL_FILE_LEVEL_ERROR</xsl:with-param>
   			   <xsl:with-param name="legend-type">intended-header</xsl:with-param>
   			   <xsl:with-param name="content">
   			       <xsl:apply-templates select="file_error/errors">
   			         <xsl:with-param name="show_ref">N</xsl:with-param> 
   			         <xsl:with-param name="file_ref_id"><xsl:value-of select="$file_ref_id"/></xsl:with-param>
   			         <xsl:with-param name="file_name"><xsl:value-of select="$file_name"/></xsl:with-param>
   			       </xsl:apply-templates>
   			   </xsl:with-param>
   			 </xsl:call-template>
	        </xsl:if>
	        <xsl:if test="count(batch_error/errors/error) >=1">
	         <xsl:call-template name="fieldset-wrapper">
	           <xsl:with-param name="legend">XSL_BATCH_LEVEL_ERROR</xsl:with-param>
   			   <xsl:with-param name="legend-type">intended-header</xsl:with-param>
   			   <xsl:with-param name="content">
   			  	   <xsl:apply-templates select="batch_error/errors">
   			         <xsl:with-param name="show_ref">N</xsl:with-param>
   			         <xsl:with-param name="file_ref_id"><xsl:value-of select="$file_ref_id"/></xsl:with-param>
   			         <xsl:with-param name="file_name"><xsl:value-of select="$file_name"/></xsl:with-param>
   			       </xsl:apply-templates>
   			   </xsl:with-param>
   			 </xsl:call-template>
	        </xsl:if>
	        <xsl:if test="count(validation_error/errors/error) >=1">
	         <xsl:call-template name="fieldset-wrapper">
	           <xsl:with-param name="legend">XSL_VALIDATION_LEVEL_ERROR</xsl:with-param>
   			   <xsl:with-param name="legend-type">intended-header</xsl:with-param>
   			   <xsl:with-param name="content">
   			     <xsl:apply-templates select="validation_error/errors">
   			         <xsl:with-param name="show_ref">Y</xsl:with-param>
   			         <xsl:with-param name="file_ref_id"><xsl:value-of select="$file_ref_id"/></xsl:with-param>
   			         <xsl:with-param name="file_name"><xsl:value-of select="$file_name"/></xsl:with-param>
   			      </xsl:apply-templates>
   			   </xsl:with-param>
   			 </xsl:call-template>
	        </xsl:if>
	        <xsl:if test="count(transaction_error/errors/error) >=1">
	         <xsl:call-template name="fieldset-wrapper">
	           <xsl:with-param name="legend">XSL_TRANSACTION_LEVEL_ERROR</xsl:with-param>
   			   <xsl:with-param name="legend-type">intended-header</xsl:with-param>
   			   <xsl:with-param name="content">
   			       <xsl:apply-templates select="transaction_error/errors">
   			         <xsl:with-param name="show_ref">Y</xsl:with-param>
   			         <xsl:with-param name="file_ref_id"><xsl:value-of select="$file_ref_id"/></xsl:with-param>
   			         <xsl:with-param name="file_name"><xsl:value-of select="$file_name"/></xsl:with-param>
   			      </xsl:apply-templates>
   			   </xsl:with-param>
   			 </xsl:call-template>
	        </xsl:if>
	        </xsl:when>
	        <xsl:otherwise>
	        	<xsl:call-template name="input-field">
				<xsl:with-param name="label"/>	
				<xsl:with-param name="value" select="localization:getGTPString($language, 'XSL_NO_ERROR_FOUND')" />
			</xsl:call-template>
	        </xsl:otherwise>
	        </xsl:choose>
	     </xsl:with-param>
	    </xsl:call-template>
	</xsl:template>
	<!--  Template to show errors -->
	<xsl:template match="errors">
	<xsl:param name="show_ref"/>
	<xsl:param name="file_ref_id"/>
	<xsl:param name="file_name"/>
      <xsl:for-each select="error">

		   <xsl:variable name="pos"><xsl:value-of select="localization:getGTPString($language, 'XSL_BK_ERROR_NBR')"/><xsl:value-of select="position()"/></xsl:variable>
		   <xsl:call-template name="input-field">
		     <xsl:with-param name="override-label" select="$pos"></xsl:with-param>
		     <xsl:with-param name="id">bk_upload_error_view</xsl:with-param>
		     <xsl:with-param name="value">&nbsp;</xsl:with-param>
		     <xsl:with-param name="override-displaymode">view</xsl:with-param>
	       </xsl:call-template>
      	   <xsl:call-template name="input-field">
		     <xsl:with-param name="label">XSL_FILE_NAME</xsl:with-param>
		     <xsl:with-param name="id">bk_file_name_view</xsl:with-param>
		     <xsl:with-param name="value"><xsl:value-of select="$file_name"></xsl:value-of></xsl:with-param>
		     <xsl:with-param name="override-displaymode">view</xsl:with-param>
	       </xsl:call-template>
	       <xsl:call-template name="input-field">
		     <xsl:with-param name="label">XSL_FILE_REF_ID</xsl:with-param>
		     <xsl:with-param name="id">bk_file_ref_id_view</xsl:with-param>
		     <xsl:with-param name="value"><xsl:value-of select="$file_ref_id"></xsl:value-of></xsl:with-param>
		     <xsl:with-param name="override-displaymode">view</xsl:with-param>
	       </xsl:call-template>
		   <xsl:if test="$show_ref='Y' and $file_ref_id !=  ref_id">
	       <xsl:call-template name="input-field">
		     <xsl:with-param name="id">bk_ref_id_view</xsl:with-param>
		     <xsl:with-param name="value"><xsl:value-of select="ref_id"></xsl:value-of></xsl:with-param>
		     <xsl:with-param name="override-displaymode">view</xsl:with-param>
	       </xsl:call-template>
	       </xsl:if>
	       <xsl:if test="line_number[.!= '']">
		       <xsl:call-template name="input-field">
			     <xsl:with-param name="label">XSL_LINE_NUMBER</xsl:with-param>
			     <xsl:with-param name="id">bk_line_number_view</xsl:with-param>
			     <xsl:with-param name="value"><xsl:value-of select="line_number"></xsl:value-of></xsl:with-param>
			     <xsl:with-param name="override-displaymode">view</xsl:with-param>
		       </xsl:call-template>
	       </xsl:if>
	       <xsl:if test="column_number[.!= '']">
		       <xsl:call-template name="input-field">
			     <xsl:with-param name="label">XSL_COLUMN_NUMBER</xsl:with-param>
			     <xsl:with-param name="id">bk_column_number_view</xsl:with-param>
			     <xsl:with-param name="value"><xsl:value-of select="column_number"></xsl:value-of></xsl:with-param>
			     <xsl:with-param name="override-displaymode">view</xsl:with-param>
		       </xsl:call-template>
	       </xsl:if>
	        <xsl:choose>
	        <xsl:when test="msg_with_args">
            	<xsl:value-of select="msg_with_args"/>
            </xsl:when>
             <xsl:when test="error_code[.!='']">
             	<xsl:variable name="error_code"><xsl:value-of select="error_code"/></xsl:variable>
             	<div class="field">
					<span class="label" style="width:240px;"><xsl:value-of select="localization:getGTPString($language, 'XSL_BK_ERROR_DESCRIPTION')"/></span><xsl:value-of select="localization:getGTPString($language, $error_code)"/>&nbsp;
					<div class="content inlineBlock"><xsl:value-of select="error_value"></xsl:value-of>&nbsp;</div>
				</div>
             </xsl:when>
             <xsl:otherwise>
                <xsl:value-of select="error_value"></xsl:value-of>&nbsp; 
             </xsl:otherwise>
           </xsl:choose>
      </xsl:for-each>	
	</xsl:template>
	
		<xsl:template name="failed-records">
		<xsl:variable name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:variable>
		<div>
			<!-- Header with toggle link -->
			<div class="wipeInOutTabHeader">
				<div id="actionDown" onclick="misys.toggleFailedRecordsGrid()" style="cursor: pointer; display: block;">
				    <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_VIEW_FAILED')"/>
				    <span class="collapsingImgSpan">
				        <img>
				        	<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($actionDownImage)"/></xsl:attribute>
				        </img>
				    </span>
				</div>
				<div id="actionUp" onclick="misys.toggleFailedRecordsGrid()" style="display: none; cursor: pointer;">
				    <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_VIEW_FAILED')"/>
				    <span class="collapsingImgSpan">
				        <img>
				        	<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($actionUpImage)"/></xsl:attribute>
				        </img>
				    </span>
				</div>
			</div>
            <xsl:variable name="arrayList" select="java:java.util.ArrayList.new()" />
            <xsl:variable name="void" select="java:add($arrayList, concat('', defaultresource:getResource('BULK_POSTDATED_DAYS')))"/>
            <xsl:variable name="args" select="java:toArray($arrayList)"/>
			<!-- Failed records table -->
			<div id="failedRecords" style="height: auto; display: none; width:100%;">
				<table style="border-collapse: collapse;">
					<tr>
						<td style="width:25%;">
							<div class="userAccountsTableCell userAccountsTableCellHeader  userAccountColumnCell" style="width:100%;">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LINE_NO')"/>
							</div>
						</td>
						<td style="width:25%;">
							<div class="userAccountsTableCell userAccountsTableCellHeader  userAccountColumnCell" style="width:100%;">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_COL_NO')"/>
							</div>
						</td>
						<td style="width:50%;">
							<div class="userAccountsTableCell userAccountsTableCellHeader  userAccountColumnCell" style="width:100%;">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FAIL_REASON')"/>
							</div>
						</td>
						</tr>
					<xsl:for-each select="error_log/errors/error">
						<xsl:sort select="line_number" data-type="number"/>						
						<tr>
							<td style="width:165px;">
								<div class="userAccountsTableCell userAccountColumnCell userAccountsTableCellOdd alignCenterWithPadding" style="width:100%;">
									<xsl:value-of select="line_number"/>
								</div>
							</td>
							<td style="width:165px;">
								<div class="userAccountsTableCell userAccountColumnCell userAccountsTableCellOdd alignCenterWithPadding" style="width:100%;">
									<xsl:value-of select="column_number"/>
								</div>
							</td>	
							<td style="width:1000px">
								<div class="userAccountsTableCell userAccountColumnCell userAccountsTableCellOdd alignCenterWithPadding" style="width:100%;text-align:left;">
									<xsl:choose>
									   <xsl:when test="msg_with_args">
							            	<xsl:value-of select="msg_with_args"/>
							           </xsl:when>
                                      <xsl:when test="error_code[.!='']">
             							<xsl:variable name="error_code"><xsl:value-of select="error_code"/></xsl:variable>
             							<xsl:value-of select="localization:getFormattedString($language, $error_code, $args)"/>
                                      </xsl:when>
            						 <xsl:otherwise>
                						<xsl:value-of select="error_value"></xsl:value-of>&nbsp; 
             						</xsl:otherwise>
           						</xsl:choose> 
							</div>
							</td>
						</tr>
					</xsl:for-each>
						
				</table>
			
				</div>		
		</div>
	</xsl:template>  
	
	<xd:doc>
		<xd:short>To show successful Bulk from Local service.</xd:short>
		<xd:detail>
			All the successfull bulk upload through local service.
		</xd:detail>
	</xd:doc>
	<xsl:template name="successful-records">		
		<xsl:variable name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:variable>
			<div>
			<!-- Header with toggle link -->
			<div class="wipeInOutTabHeader">
				<div id="actionDown" onclick="misys.toggleSuccessfulRecordsGrid()" style="cursor: pointer; display: block;">
				    <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_VIEW_SUCCSESSFUL')"/>
				    <span class="collapsingImgSpan">
				        <img>
				        	<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($actionDownImage)"/></xsl:attribute>
				        </img>
				    </span>
				</div>
				<div id="actionUp" onclick="misys.toggleSuccessfulRecordsGrid()" style="display: none; cursor: pointer;">
				    <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_VIEW_SUCCSESSFUL')"/>
				    <span class="collapsingImgSpan">
				        <img>
				        	<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($actionUpImage)"/></xsl:attribute>
				        </img>
				    </span>
				</div>
			</div>
			<!-- Successful records table -->
					<div id="successfulRecords" style="height: auto; display: none; width:100%;">
						<table style="border-collapse: collapse;">
							<tr>
								<td style="width:25%;">
									<div
										class="userAccountsTableCell userAccountsTableCellHeader  userAccountColumnCell"
										style="width:100%;">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_HEADER_LINE_NO')" />
									</div>
								</td>
								<td style="width:50%;">
									<div
										class="userAccountsTableCell userAccountsTableCellHeader  userAccountColumnCell"
										style="width:100%;">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_HEADER_BULK_REFERNCE')" />
									</div>
								</td>
								<td style="width:100%;">
									<div
										class="userAccountsTableCell userAccountsTableCellHeader  userAccountColumnCell"
										style="width:100%;">
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_HEADER_FUND_TRANSFER_REFERNCE')" />
									</div>
								</td>
							</tr>				
						<xsl select="bkftrecords">
							<xsl:for-each select="bo_comment/bkftrecords/bkftrecord">
								<tr>
									<td style="width:165px;">
										<div
											class="userAccountsTableCell userAccountColumnCell userAccountsTableCellOdd alignCenterWithPadding"
											style="width:100%;">
												<xsl:value-of select="line_number" />
										</div>
									</td>
									<td style="width:1000px">
										<div
											class="userAccountsTableCell userAccountColumnCell userAccountsTableCellOdd alignCenterWithPadding"
											style="width:100%;text-align:left;">
											<xsl:value-of select="bkref" />
										</div>
									</td>
									<td style="width:1000px">
										<div
											class="userAccountsTableCell userAccountColumnCell userAccountsTableCellOdd alignCenterWithPadding"
											style="width:100%;text-align:left;">
											<xsl:value-of select="ftref" />
										</div>
									</td>
								</tr>
								</xsl:for-each>
							</xsl>
						</table>			
				</div>		
		</div>
	</xsl:template>
	
</xsl:stylesheet>