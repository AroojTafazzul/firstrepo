<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for : TO DO : CANCEL + PASSBACK ENTITY

 Bank Company Screen, System Form (Attached Banks Screen).

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      30/07/2011
author:    Gurudath Reddy
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:securityUtils="xalan://com.misys.portal.common.tools.SecurityUtils"
    xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
    exclude-result-prefixes="localization securityUtils">
    <xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
    <xsl:param name="actionDownImage"><xsl:value-of select="$images_path"/>action-down.png</xsl:param>
	<xsl:param name="actionUpImage"><xsl:value-of select="$images_path"/>action-up.png</xsl:param>
	<xsl:param name="arrowDownImage"><xsl:value-of select="$images_path"/>arrow_down.png</xsl:param>
	<xsl:param name="arrowUpImage"><xsl:value-of select="$images_path"/>arrow_up.png</xsl:param>
	
    <xsl:template name="user-entity-grid">
	 <xsl:call-template name="fieldset-wrapper">
	     <xsl:with-param name="legend">XSL_HEADER_ENTITY</xsl:with-param>
	     <xsl:with-param name="content">
		 <div class="widgetContainer">
		 	<xsl:variable name="defaultEntityData">
		 		<xsl:apply-templates select="entity_record" mode="entityRecordData"/>
		 	</xsl:variable>
		    <xsl:variable name="currentDefaultEntity"><xsl:value-of select="entity_record[(default_entity='Y')]/entity_id"/></xsl:variable>
		     <xsl:variable name="defaultEntityMandatoryCheck"><xsl:value-of select="../static_user/defaultEntityMandatoryCheck"/></xsl:variable>
  			<xsl:variable name="currentDefaultEntityName"><xsl:value-of select="entity_record[(default_entity='Y')]/entity_name"/></xsl:variable>
		 	<xsl:variable name="entityExists"><xsl:value-of select="count(entity_record[(entity_flag='Y')])"/></xsl:variable>
		 	  <script>
					dojo.ready(function(){
						misys._config = misys._config || {};
						misys._config.entity = {};
						misys._config.defaultEntityData = '<xsl:value-of select="$defaultEntityData"/>';
						dojo.mixin(misys._config.entity,{
							count : <xsl:value-of select="count(entity_record)"></xsl:value-of>
						});
				       	dojo.mixin(misys._config, {
				       		defaultEntityArray : new Array()
						});
						<xsl:for-each select="entity_record">
						    <xsl:variable name="entity_record" select="."/>
						    <xsl:variable name="position" select="position()" />
						     misys._config.defaultEntityArray['<xsl:value-of select="$position"/>'] = misys._config.defaultEntityArray['<xsl:value-of select="$position"/>'] || [];
						     misys._config.defaultEntityArray['<xsl:value-of select="$position"/>'] = new Array(<xsl:value-of select='count($entity_record/entity_id)'/>);
						     misys._config.defaultEntityArray['<xsl:value-of select="$position"/>']= 
						     {
						     id: "<xsl:value-of select="$entity_record/entity_id"/>",
						     name: "<xsl:value-of select="$entity_record/entity_name"/>",
						     abbvName: "<xsl:value-of select="$entity_record/entity_abbv_name"/>"
						     };
						</xsl:for-each>
					});
			 </script>
			 <xsl:call-template name="hidden-field">
			 	<xsl:with-param name="name">base_currency_hidden</xsl:with-param>
			 	<xsl:with-param name="value"><xsl:value-of select="$base_currency"/></xsl:with-param>
			 </xsl:call-template>
			  <xsl:call-template name="hidden-field">
					<xsl:with-param name="name">defaultEntityMandatory</xsl:with-param>
					<xsl:with-param name="value"><xsl:value-of select="$defaultEntityMandatoryCheck"/></xsl:with-param>	
			</xsl:call-template>	
		 	  <xsl:call-template name="select-field">
		      		<xsl:with-param name="label">DEFAULT_ENTITY</xsl:with-param>
				    <xsl:with-param name="name">default_entity</xsl:with-param>
				    <xsl:with-param name="value" select="$currentDefaultEntity"/>
				    <xsl:with-param name="fieldsize">medium</xsl:with-param>
				    <xsl:with-param name="override-displaymode"><xsl:value-of select="$displaymode"/></xsl:with-param>
				   	<xsl:with-param name="show-clear-button">Y</xsl:with-param>
				    <xsl:with-param name="options">
				      <xsl:choose>
				 	  <xsl:when test="$displaymode='edit'"> 
					  <xsl:apply-templates select="entity_record" mode="entities"/>
					  </xsl:when>
					  <xsl:otherwise>
					   <xsl:value-of select="$currentDefaultEntityName"/>
					  </xsl:otherwise>
				 	 </xsl:choose>
				    </xsl:with-param>
				</xsl:call-template>
    			<div  id="userEntityTabel" style="width:100%;">
					<div id="misysCustomisableTabelHeaderContainer" style="width:100%;">
						
						<div class="userEntityTableCell userEntityTableCellHeader userEntityHeaderSelector">
								<p class="hide">a</p>
						</div>
						<div class="userEntityTableCell userEntityTableCellHeader width85per">
							<xsl:value-of select="localization:getGTPString($language, 'ENTITY')"/>
						</div>
						<div class="userEntityTableCell userEntityTableCellHeader width10per">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_ROLES')"/>
						</div>
					</div>
					
					<xsl:for-each select="entity_record">
						<xsl:variable name="entity_record" select="."/>
						<xsl:variable name="position" select="position()" />
						<xsl:variable name="entity_id" select="$entity_record/entity_id" />
						<xsl:variable name="isEntityExpanded">
							<xsl:choose>
								<xsl:when test="$entity_record/entity_flag='Y'">true</xsl:when>
								<xsl:otherwise>false</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						
							<xsl:if test="$displaymode='edit' or ($displaymode='view' and $entity_record/entity_flag='Y')">
							<div class="entityRows"><xsl:attribute name="id">entity_row_<xsl:value-of select="$entity_id"/></xsl:attribute>
								
								<div class="userEntityTableCell userEntityTableCellOdd userEntityHeaderSelector alignCenter referenceTable">
									<div dojoType="dijit.form.CheckBox">
										<xsl:attribute name="id">entity_flag_nosend_<xsl:value-of select="$entity_id"/></xsl:attribute>
										
										<xsl:if test="$displaymode = 'view'">
											<xsl:attribute name="checked">
											<xsl:choose>
												<xsl:when test="$isEntityExpanded='true'">Y</xsl:when>
												<xsl:otherwise>N</xsl:otherwise>											
											</xsl:choose>
											</xsl:attribute>
											<xsl:attribute name="disabled">Y</xsl:attribute>
										</xsl:if>
									</div>
									<xsl:call-template name="hidden-field">
										<xsl:with-param name="name">enity_flag_<xsl:value-of select="$entity_id"/></xsl:with-param>
										<xsl:with-param name="value"><xsl:value-of select="$entity_record/entity_flag"/></xsl:with-param>	
									</xsl:call-template>			
								</div>
								<div class="userEntityTableCell userEntityTableCellOdd width85per referenceTable">
									<span style="margin-left:3px;"><xsl:value-of select="$entity_record/entity_name"/>&nbsp;(<xsl:value-of select="$entity_record/entity_abbv_name"/>)</span>
									<xsl:call-template name="hidden-field">
										<xsl:with-param name="name">entity_id_nosend_<xsl:value-of select="$position"/></xsl:with-param>
										<xsl:with-param name="value"><xsl:value-of select="$entity_record/entity_id"/></xsl:with-param>	
									</xsl:call-template>
									<xsl:call-template name="hidden-field">
										<xsl:with-param name="name">entity_abbv_name_nosend_<xsl:value-of select="$entity_id"/></xsl:with-param>
										<xsl:with-param name="value"><xsl:value-of select="securityUtils:encodeXML($entity_record/entity_abbv_name)"/></xsl:with-param>	
									</xsl:call-template>
									<xsl:call-template name="hidden-field">
										<xsl:with-param name="name">entity_name_nosend_<xsl:value-of select="$entity_id"/></xsl:with-param>
										<xsl:with-param name="value"><xsl:value-of select="$entity_record/entity_name"/></xsl:with-param>	
									</xsl:call-template>
								</div>
								 <div class="userEntityTableCell userEntityTableCellOdd width10per alignCenter referenceTable">
									<xsl:choose>
										<xsl:when test="$displaymode = 'edit' or ($displaymode != 'edit' and (count(existing_roles/role[(roledest='04') and (roletype='01')]) != 0)) ">
										<span style="vertical-align:top;" ><xsl:attribute name="id">entity_roles_indicator_<xsl:value-of select="$position"/></xsl:attribute>
											<xsl:if test="$displaymode='view'">	
												<xsl:value-of select="count(existing_roles/role[(roledest='04') and (roletype='01')])"/>&nbsp;<xsl:value-of select="localization:getGTPString($language, 'XSL_USER_ENTITY_ROLES_COUNT')"/>
											</xsl:if>
										</span>
										<span>
											<xsl:attribute name="style">
												<xsl:choose>
													<xsl:when test="$displaymode = 'view' and $isEntityExpanded = 'true'">display:none;cursor:pointer;vertical-align:middle;</xsl:when>
													<xsl:otherwise>cursor:pointer;vertical-align:middle;</xsl:otherwise>
												</xsl:choose>
											</xsl:attribute>
											
										
											<xsl:attribute name="id">entity_roles_down_<xsl:value-of select="$entity_id"/></xsl:attribute>
											<a>
												<xsl:attribute name="onClick">misys.toggleDisplayRoles('<xsl:value-of select="$entity_id"/>','down');</xsl:attribute>
												<img>
													<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($actionDownImage)"/></xsl:attribute>
													<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'OPEN_ROLES_ASSIGNMENT')"/></xsl:attribute>
													<xsl:attribute name="title"><xsl:value-of select="localization:getGTPString($language, 'OPEN_ROLES_ASSIGNMENT')"/></xsl:attribute>
												</img>
											</a>
										</span>
										<span>
											<xsl:attribute name="style">
												<xsl:choose>
													<xsl:when test="$displaymode = 'view' and $isEntityExpanded = 'true'">display:inline;cursor:pointer;vertical-align:middle;</xsl:when>
													<xsl:otherwise>display:none;cursor:pointer;vertical-align:middle;</xsl:otherwise>
												</xsl:choose>
											</xsl:attribute>
											
											<xsl:attribute name="id">entity_roles_up_<xsl:value-of select="$entity_id"/></xsl:attribute>
											<a>
												<xsl:attribute name="onClick">misys.toggleDisplayRoles('<xsl:value-of select="$entity_id"/>','up');</xsl:attribute>
												<img>
													<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($actionUpImage)"/></xsl:attribute>
													<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'CLOSE_ROLES_ASSIGNMENT')"/></xsl:attribute>
												</img>
											</a>
										</span>
										</xsl:when>
										<xsl:otherwise>
											<span><xsl:value-of select="localization:getGTPString($language, 'XSL_NO_ROLES')"></xsl:value-of></span>	
										</xsl:otherwise>
									</xsl:choose>
									
									
								</div>
							</div>
							<div class="userEntityTableMergedCellContainer permissions">
							<xsl:attribute name="style">
								<xsl:choose>
									<xsl:when test="$displaymode = 'view' and $isEntityExpanded = 'true'">display:inline;</xsl:when>
									<xsl:otherwise>display:none;</xsl:otherwise>
								</xsl:choose>
							width:99.5%;
							</xsl:attribute>
							
								<xsl:attribute name="id">entity_roles_div_<xsl:value-of select="$entity_id"/></xsl:attribute>

							    <div>
							    <xsl:if test="$displaymode = 'edit'">
							   	  <xsl:attribute name="class">collapse-label</xsl:attribute>
							   	 </xsl:if>
							     <xsl:if test="$displaymode = 'edit'">
							     <xsl:call-template name="select-field">
							      <xsl:with-param name="label"></xsl:with-param>
							  	  <xsl:with-param name="id">entity_roles_avail_nosend_<xsl:value-of select="$entity_id"/></xsl:with-param>
							  	  <xsl:with-param name="name"></xsl:with-param>
							   	  <xsl:with-param name="type">multiple</xsl:with-param>
							      <xsl:with-param name="size">10</xsl:with-param>
							      <xsl:with-param name="options">
							       <xsl:choose>
								    <xsl:when test="$displaymode='edit'">
								      <xsl:apply-templates select="avail_roles/role[(roledest='04') and (roletype='01')]" mode="input"/>
								    </xsl:when>
								    <xsl:otherwise>
								     <ul class="multi-select">
								      <xsl:apply-templates select="avail_roles/role[(roledest='04') and (roletype='01')]" mode="input"/>
								     </ul>
								    </xsl:otherwise>
								   </xsl:choose>
							  	  </xsl:with-param>
							  	 </xsl:call-template>
							      <div id="add-remove-buttons" class="multiselect-buttons" style="text-align:center;">
							       <button dojoType="dijit.form.Button" type="button"><xsl:attribute name="id">add_<xsl:value-of select="$entity_id"/></xsl:attribute>
								       <xsl:attribute name="onClick">misys.addEntityMultiSelectItems(dijit.byId('entity_roles_exist_nosend_<xsl:value-of select="$entity_id"/>'), dijit.byId('entity_roles_avail_nosend_<xsl:value-of select="$entity_id"/>'),dojo.byId('entity_roles_indicator_<xsl:value-of select="$position"/>'),dijit.byId('entity_roles_exist_nosend_<xsl:value-of select="$entity_id"/>'));</xsl:attribute>
								       <xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_ADD')" />&nbsp;
								       <img>
      										<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($arrowDownImage)"/></xsl:attribute>
      										<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_ADD')" /></xsl:attribute>
     									</img>
								   </button>&nbsp;
							       <button dojoType="dijit.form.Button" type="button"><xsl:attribute name="id">remove_<xsl:value-of select="$entity_id"/></xsl:attribute>
								       <xsl:attribute name="onClick">misys.addEntityMultiSelectItems(dijit.byId('entity_roles_avail_nosend_<xsl:value-of select="$entity_id"/>'), dijit.byId('entity_roles_exist_nosend_<xsl:value-of select="$entity_id"/>'),dojo.byId('entity_roles_indicator_<xsl:value-of select="$position"/>'),dijit.byId('entity_roles_exist_nosend_<xsl:value-of select="$entity_id"/>'));</xsl:attribute>
								       <xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REMOVE')" />&nbsp;
								       <img>
      										<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($arrowUpImage)"/></xsl:attribute>
      										<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REMOVE')" /></xsl:attribute>
      								   </img>
   								   </button>
							      </div>
							      </xsl:if>
							      <xsl:call-template name="select-field">
							       <xsl:with-param name="label"></xsl:with-param>
								   <xsl:with-param name="name">entity_roles_exist_nosend_<xsl:value-of select="$entity_id"/></xsl:with-param>
								   <xsl:with-param name="type">multiple</xsl:with-param>
							       <xsl:with-param name="size">10</xsl:with-param>
								   <xsl:with-param name="options">
								    <xsl:choose>
								     <xsl:when test="$displaymode='edit'">
								      <xsl:apply-templates select="existing_roles/role[(roledest='04') and (roletype='01')]" mode="input"/>
								     </xsl:when>
								     <xsl:otherwise>
								      <ul class="multi-select">
							           <xsl:apply-templates select="existing_roles/role[(roledest='04') and (roletype='01')]" mode="input"/>
							          </ul>
								     </xsl:otherwise>
								    </xsl:choose>
								   </xsl:with-param>
							      </xsl:call-template>
							    </div>
							</div>
						  </xsl:if>
					</xsl:for-each>
				</div>
			</div>
		  </xsl:with-param>
		 </xsl:call-template>
	   
	</xsl:template>
	<xsl:template match="entity_record" mode="entities">
	   <xsl:choose>
	   <xsl:when test="$displaymode='edit'">
	    <option>
	     <xsl:attribute name="value"><xsl:value-of select="entity_id"/></xsl:attribute>
	     <xsl:value-of select="entity_name"/>
	    </option>
	   </xsl:when>
	  </xsl:choose>
   </xsl:template>
   <xsl:template match="entity_record" mode="entityRecordData">
		<option>
			<xsl:attribute name="value"><xsl:value-of select="entity_id"/></xsl:attribute>
     		<xsl:value-of select="entity_name"/>
			<xsl:if test="not(position()=last())">,</xsl:if>
		</option>
   </xsl:template>
</xsl:stylesheet>


