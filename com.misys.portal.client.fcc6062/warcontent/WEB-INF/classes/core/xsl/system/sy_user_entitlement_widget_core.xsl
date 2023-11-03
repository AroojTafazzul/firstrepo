<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for : TO DO : CANCEL + PASSBACK ENTITLEMENT

 Bank Company Screen, System Form (Attached Banks Screen).

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

##############################
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
    <xsl:param name="viewImage"><xsl:value-of select="$images_path"/>preview_large.png</xsl:param>
	
	
	
    <xsl:template name="user-entitlement-grid">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_EXTERNAL_LOB</xsl:with-param>
			<xsl:with-param name="content">
				<!-- Selection of the Lob -->
				<xsl:call-template name="select-field">
					<xsl:with-param name="label">XSL_LOB</xsl:with-param>
					<xsl:with-param name="name">external_lob</xsl:with-param>
					<xsl:with-param name="required">Y</xsl:with-param>
					<xsl:with-param name="options">
						<xsl:choose>
							<xsl:when test="$displaymode='edit'">
								<option value="None">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_NONE')"/>
								</option>
								<option value="01">
									<xsl:value-of select="localization:getCodeData($language,'*', '*','C099', '01')"/>
								</option>
							</xsl:when>
							<xsl:otherwise>
								<xsl-value>: </xsl-value>
								<xsl:choose>
									<xsl:when test="external_lob != 'None'">
							        	<xsl:value-of select="localization:getCodeData($language,'*', '*','C099', '01')"/>
							        </xsl:when>
							        <xsl:otherwise>
							        	<xsl:value-of select="localization:getGTPString($language, 'XSL_NONE')"/>
							        </xsl:otherwise>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:if test="$displaymode='edit' or (external_lob != 'None' and $displaymode='view')">
			<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="legend">XSL_LIST_OF_ROLE_TEMP</xsl:with-param>
				<xsl:with-param name="legend-type">intended-header</xsl:with-param>
				<xsl:with-param name="name">list_of_role</xsl:with-param>
				<xsl:with-param name="id">list_of_role</xsl:with-param>
				<xsl:with-param name="content">
					<div>
						<xsl:if test="$displaymode='edit'">
							<span style="color:black; font-weight:bold; font-style:italic;" id="disclaimer_message">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_ROLE_TEMP_NOTE')"/>
							</span>
						</xsl:if>
					</div>
					<xsl:call-template name="fieldset-wrapper">
						<xsl:with-param name="content">
							<div class="widgetContainer">
								<script>
									dojo.ready(function(){
									misys._config = misys._config || {};
									misys._config.entitlement = {};
									dojo.mixin(misys._config.entitlement,{
									count : <xsl:value-of select="count(entitlement_record)"/>
									});
									});
								</script>
								<div id="userEntityTabel" style="width:100%;">
									<div id="misysCustomisableTabelHeaderContainer" style="width:100%;">
										<div class="userEntityTableCell userEntityTableCellHeader width30per">
											<xsl:value-of select="localization:getGTPString($language, 'ROLE_TEMPLATE')"/>
										</div>
										<div class="userEntityTableCell userEntityTableCellHeader width60per">
											<xsl:value-of select="localization:getGTPString($language, 'AVAILABLE_ENTITIES')"/>
										</div>
										<div class="userEntityTableCell userEntityTableCellHeader width8per">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTIONS')"/>
										</div>
									</div>
									<xsl:for-each select="entitlement_record">
										<xsl:variable name="entitlement_record" select="."/>
										<xsl:variable name="position" select="position()"/>
										<xsl:variable name="entity_id" select="$entitlement_record/entitlement_id"/>
										<xsl:variable name="entitlement_code" select="$entitlement_record/entitlement_code"/>
										<xsl:variable name="entitlement_description" select="$entitlement_record/entitlement_description"/>
										<xsl:variable name="subsidiary_list" select="$entitlement_record/subsidiary_List"/>
										<xsl:if test="$entitlement_record/active_flag ='Y'">
											<div class="entityRows">
												<xsl:attribute name="id">entity_row_<xsl:value-of select="$entity_id"/>
												</xsl:attribute>
												<div class="userEntityTableCell userEntityTableCellOdd width30per referenceTable" style="height: 36px">
													<span style="margin-left:3px; font-family: italian, Helvetica, sans-serif; font-weight: normal;">
														<xsl:value-of select="$entitlement_record/entitlement_description"/>&nbsp;(<xsl:value-of select="$entitlement_record/entitlement_code"/>)</span>
													<xsl:call-template name="hidden-field">
														<xsl:with-param name="name">entitlement_id_nosend_<xsl:value-of select="$position"/>
														</xsl:with-param>
														<xsl:with-param name="value">
															<xsl:value-of select="$entitlement_record/entitlement_id"/>
														</xsl:with-param>
													</xsl:call-template>
													<xsl:call-template name="hidden-field">
														<xsl:with-param name="name">entitlement_code_nosend_<xsl:value-of select="$entity_id"/>
														</xsl:with-param>
														<xsl:with-param name="value">
															<xsl:value-of select="$entitlement_record/entitlement_code"/>
														</xsl:with-param>
													</xsl:call-template>
													<xsl:call-template name="hidden-field">
														<xsl:with-param name="name">entitlement_name_nosend_<xsl:value-of select="$entity_id"/>
														</xsl:with-param>
														<xsl:with-param name="value">
															<xsl:value-of select="$entitlement_record/entitlement_description"/>
														</xsl:with-param>
													</xsl:call-template>
													<xsl:call-template name="hidden-field">
														<xsl:with-param name="name">entitlement_valid_flag_nosend_<xsl:value-of select="$entity_id"/>
														</xsl:with-param>
														<xsl:with-param name="value">
															<xsl:value-of select="$entitlement_record/active_flag"/>
														</xsl:with-param>
													</xsl:call-template>
													<xsl:call-template name="hidden-field">
														<xsl:with-param name="name">subsidiary_id_list_<xsl:value-of select="$entity_id"/>
														</xsl:with-param>
														<xsl:with-param name="value">
															<xsl:value-of select="$entitlement_record/subsidiary_List"/>
														</xsl:with-param>
													</xsl:call-template>
												</div>
												<xsl:variable name="subsidiaries_assigned_1" select="$entitlement_record/subsidiaries_assigned"/>
												<div class="userEntityTableCell userEntityTableCellOdd width60per referenceTable" style="overflow: auto; height: 36px">
													<xsl:for-each select="$subsidiaries_assigned_1/subsidiary">
														<script>
															dojo.ready(function(){
															misys._config = misys._config || {};
															misys._config.subsidiary = {};
															dojo.mixin(misys._config.subsidiary,{
															count : <xsl:value-of select="count($entitlement_record/subsidiaries_assigned/subsidiary)"/>
															});
															});
														</script>
														<xsl:variable name="subsidiary_1" select="."/>
														<xsl:variable name="position" select="position()"/>
														<xsl:variable name="subsidiary_code" select="$subsidiary_1/subsidiary_code" />
														<xsl:variable name="subsidiary_id" select="$subsidiary_1/subsidiary_id" />
														<xsl:variable name="entitlement_code" select="$subsidiary_1/subsidiary_entitlement_code" />
														<xsl:variable name="entitlement_id" select="$subsidiary_1/subsidiary_entitlement_id" />
														<xsl:variable name="default_sibsidiary_id" select="$subsidiary_1/default_subsidiary_id" />
														<span style="margin-left:3px; font-family: italian, Helvetica, sans-serif; font-weight: normal;">
															<xsl:choose>
																<xsl:when test="$subsidiary_1/entity_name">
																	<xsl:value-of select="$subsidiary_1/entity_name"/>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:value-of select="$subsidiary_1/subsidiary_code"/>
																</xsl:otherwise>
															</xsl:choose>
															<xsl:if test="not(position()=last())">,</xsl:if>
														</span>
														<xsl:call-template name="hidden-field">
															<xsl:with-param name="name">entity_name_<xsl:value-of select="$entitlement_record/entitlement_id"/>_<xsl:value-of select="$position"/></xsl:with-param>
															<xsl:with-param name="value">
																<xsl:choose>
																	<xsl:when test="$subsidiary_1/entity_name">
																		<xsl:value-of select="$subsidiary_1/entity_name"/>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:value-of select="$subsidiary_1/subsidiary_code"/>
																	</xsl:otherwise>
																</xsl:choose>
															</xsl:with-param>	
														</xsl:call-template>
														<xsl:call-template name="hidden-field">
															<xsl:with-param name="name">subsidiary_code_nosend_<xsl:value-of select="$entitlement_record/entitlement_id"/>_<xsl:value-of select="$position"/></xsl:with-param>
															<xsl:with-param name="value">
																<xsl:choose>
																	<xsl:when test="$subsidiary_1/entity_name">
																		<xsl:value-of select="$subsidiary_1/entity_name"/>
																	</xsl:when>
																	<xsl:otherwise>
																		<xsl:value-of select="$subsidiary_1/subsidiary_code"/>
																	</xsl:otherwise>
																</xsl:choose>
															</xsl:with-param>	
														</xsl:call-template>
														<xsl:call-template name="hidden-field">
															<xsl:with-param name="name">subsidiary_id_nosend_<xsl:value-of select="$entitlement_record/entitlement_id"/>_<xsl:value-of select="$position"/></xsl:with-param>
															<xsl:with-param name="value"><xsl:value-of select="$subsidiary_1/subsidiary_id"/></xsl:with-param>	
														</xsl:call-template>
														<xsl:if test="position()=1">
														<xsl:call-template name="hidden-field">
															<xsl:with-param name="name">entitlement_subsidiary_count_<xsl:value-of select="$entitlement_record/entitlement_id"/>_<xsl:value-of select="$position"/></xsl:with-param>
															<xsl:with-param name="value"><xsl:value-of select="count($entitlement_record/subsidiaries_assigned/subsidiary)"/></xsl:with-param>	
														</xsl:call-template>
														</xsl:if>
														<xsl:call-template name="hidden-field">
															<xsl:with-param name="name">subsidiary_code_fcm_nosend_<xsl:value-of select="$entitlement_record/entitlement_id"/>_<xsl:value-of select="$position"/></xsl:with-param>
															<xsl:with-param name="value"><xsl:value-of select="$subsidiary_1/subsidiary_code"/></xsl:with-param>	
														</xsl:call-template>
													</xsl:for-each>
												</div>
												<div class="userEntityTableCell userEntityTableCellOdd width8per alignCenter referenceTable" style="height: 36px">
													 <xsl:choose>
														<xsl:when test="$displaymode = 'edit'">
															<span>
																<xsl:attribute name="style">
																	<xsl:choose>
																		<xsl:when test="$displaymode = 'view'">display:none;cursor:pointer;vertical-align:middle;</xsl:when>
																		<xsl:otherwise>cursor:pointer;vertical-align:middle;float:left;margin-left:10px;</xsl:otherwise>
																	</xsl:choose>
																</xsl:attribute>
																<xsl:attribute name="id">entitlement_roles_down_<xsl:value-of select="$entity_id"/>
																</xsl:attribute>
																<a>
																	<xsl:attribute name="onClick">misys.toggleDisplayRoles('<xsl:value-of select="$entity_id"/>','down');</xsl:attribute>
																	<img>
																		<xsl:attribute name="src">
																			<xsl:value-of select="utils:getImagePath($viewImage)"/>
																		</xsl:attribute>
																		<xsl:attribute name="onclick">misys.popup.openIframePopup('VIEW_ENTITLEMENT_POPUP', '<xsl:value-of select="$entitlement_code"/>', '<xsl:value-of select="$entitlement_description"/>', dijit.byId('company_abbv_name').get('value'));return false;</xsl:attribute>
																		<xsl:attribute name="alt">
																			<xsl:value-of select="localization:getGTPString($language, 'OPEN_ROLES_ASSIGNMENT')"/>
																		</xsl:attribute>
																		<xsl:attribute name="title">
																			<xsl:value-of select="localization:getGTPString($language, 'OPEN_ROLES_ASSIGNMENT')"/>
																		</xsl:attribute>
																	</img>
																</a>
															</span>
														</xsl:when>
														<xsl:otherwise>
															<xsl:attribute name="style">cursor:pointer;vertical-align:middle;</xsl:attribute>
															<xsl:attribute name="id">entitlement_roles_down_<xsl:value-of select="$entity_id"/>
															</xsl:attribute>
															<a>
																<xsl:attribute name="onClick">misys.toggleDisplayRoles('<xsl:value-of select="$entity_id"/>','down');</xsl:attribute>
																<img>
																	<xsl:attribute name="src">
																		<xsl:value-of select="utils:getImagePath($viewImage)"/>
																	</xsl:attribute>
																	<xsl:attribute name="onclick">misys.popup.openIframePopup('VIEW_ENTITLEMENT_POPUP', '<xsl:value-of select="$entitlement_code"/>', '<xsl:value-of select="$entitlement_description"/>', dijit.byId('company_abbv_name').get('value'));return false;</xsl:attribute>
																	<xsl:attribute name="alt">
																		<xsl:value-of select="localization:getGTPString($language, 'OPEN_ROLES_ASSIGNMENT')"/>
																	</xsl:attribute>
																	<xsl:attribute name="title">
																		<xsl:value-of select="localization:getGTPString($language, 'OPEN_ROLES_ASSIGNMENT')"/>
																	</xsl:attribute>
																</img>
															</a>
														</xsl:otherwise>
													</xsl:choose>
													<input dojoType="dijit.form.RadioButton" type="radio" name="date_type" style="margin-top:5px; position:absolute;">
														<xsl:attribute name="id">subsidiary_radio_flag_nosend_<xsl:value-of select="$entitlement_record/entitlement_id"/></xsl:attribute>
														<xsl:attribute name="onClick">misys.toggleRadioSubsidiary('<xsl:value-of select="$entitlement_record/entitlement_id"/>','<xsl:value-of select="$entitlement_record/entitlement_code"/>');</xsl:attribute>
							        						<xsl:if test="$displaymode = 'view'">
																		<xsl:attribute name="checked">
																		<!-- <xsl:choose>
																			<xsl:when test="$entity_id = $entitlement_id">true</xsl:when>
																			<xsl:otherwise>false</xsl:otherwise>											
																		</xsl:choose> -->
																		</xsl:attribute>
																		<xsl:attribute name="disabled">Y</xsl:attribute>
															</xsl:if>
													</input>	
												</div>
											</div>
										</xsl:if>
									</xsl:for-each>
									<xsl:call-template name="hidden-field">
								       <xsl:with-param name="name">default_role_template</xsl:with-param>
								    </xsl:call-template>
			    					<xsl:call-template name="hidden-field">
								       <xsl:with-param name="name">entity_List</xsl:with-param>
								    </xsl:call-template>
								    <xsl:call-template name="hidden-field">
								       <xsl:with-param name="name">entity_abbv_List</xsl:with-param>
								    </xsl:call-template>
								</div>
							</div>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>
	<xsl:template match="entitlement_record" mode="entitlement">
	   <xsl:choose>
	   <xsl:when test="$displaymode='edit'">
	    <option>
	     <xsl:attribute name="value"><xsl:value-of select="entitlement_id"/></xsl:attribute>
	     <xsl:value-of select="entitlement_name"/>
	    </option>
	   </xsl:when>
	  </xsl:choose>
   </xsl:template>
   
   <xsl:template name="column-check-box">
		<xsl:param name="disabled"/>
	    <xsl:param name="readonly"/>
	    <xsl:param name="checked"/>
	    <xsl:param name="id"/>
		<div dojoType="dijit.form.CheckBox">
			<xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
			<xsl:if test="$disabled='Y'">
	         <xsl:attribute name="disabled">true</xsl:attribute>
	        </xsl:if>
	        <xsl:if test="$readonly='Y' or $displaymode='view'">
	         <xsl:attribute name="readOnly">true</xsl:attribute>
	        </xsl:if>
	        <xsl:if test="$checked='Y'">
	         <xsl:attribute name="checked"/>
	        </xsl:if>	 	 
  		</div>
   </xsl:template>
</xsl:stylesheet>


