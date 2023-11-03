<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		exclude-result-prefixes="localization">
		
<!--
   Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
	
	<xsl:output method="html" indent="yes" />

	<!-- Get the language code -->
	<xsl:param name="language"/>
	<xsl:param name="editImage"><xsl:value-of select="$images_path"/>edit.png</xsl:param>
	<xsl:param name="deleteImage"><xsl:value-of select="$images_path"/>delete.png</xsl:param>
	<xsl:param name="formSaveImage"><xsl:value-of select="$images_path"/>pic_form_save.gif</xsl:param>
	<xsl:param name="formCancelImage"><xsl:value-of select="$images_path"/>pic_form_cancel.png</xsl:param>
	
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>

	<!--TEMPLATE Main-->

	<xsl:template match="system_parameters_records">
		<script type="text/javascript" src="/content/javascript/com_functions.js"></script>
		<script type="text/javascript">
			<xsl:attribute name="src">/content/javascript/com_error_<xsl:value-of select="$language"/>.js</xsl:attribute>
		</script>
		<script type="text/javascript" src="/content/javascript/com_amount.js"></script>
		<script type="text/javascript" src="/content/javascript/sy_system_parameters.js"></script>
		
		<table border="0" width="100%">		
		<tr>
		<td align="center">
		
		<table border="0">
		<tr>
		<td align="left">
			<!--
			<div style="display:none;">
					<table>
						<tbody>
							<xsl:attribute name="id">forbiddenwords_template</xsl:attribute>
							<xsl:call-template name="FORBIDDEN_WORDS">
								<xsl:with-param name="structure_name">forbiddenwords</xsl:with-param>
								<xsl:with-param name="mode">template</xsl:with-param>
								<xsl:with-param name="formName">fakeform1</xsl:with-param>
							</xsl:call-template>
						</tbody>
					</table>
				</div>
		
			<form name="fakeform1" onsubmit="return false;">
						
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
						<td class="FORMH1">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEM_PARAMETER_HEADER_GENERAL_PARAMETER')"/></b>
						</td>
					</tr>
				</table>

				<br/>
	
				<table border="0" width="570" cellpadding="0" cellspacing="0">			
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEM_PARAMETER_NB_RECORDS_LIST')"/></td>
					<td>
						<input type="text" size="4" maxlength="4" name="nb_record_per_list" onblur="fncCheckRecord(this)">
							<xsl:attribute name="value"><xsl:value-of select="system_parameter/data_1"/></xsl:attribute>
						</input>
					</td>
				</tr>
				</table>
				
				<br/>
				
				<br/>
				
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
						<td class="FORMH1">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEM_PARAMETER_HEADER_LOGIN')"/></b>
						</td>
					</tr>
				</table>

				<br/>
				
				<table border="0" width="570" cellpadding="0" cellspacing="0">	
				
								<tr>
					<td width="40">&nbsp;</td>
					<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEM_PARAMETER_PASSWORD_EXPIRY')"/></td>
					<td>
						<input type="text" size="4" maxlength="4" name="password_expiry" onblur="fncCheckRecord(this)">
							<xsl:attribute name="value"><xsl:value-of select="system_parameter/data_3"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEM_PARAMETER_PASSWORD_INACTIVITY_PERIOD')"/></td>
					<td>
						<input type="text" size="4" maxlength="4" name="password_inactivity" onblur="fncCheckRecord(this)">
							<xsl:attribute name="value"><xsl:value-of select="system_parameter/data_4"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEM_PARAMETER_PASSWORD_LOGIN_ATTEMPT_FAILURES')"/></td>
					<td>
						<input type="text" size="4" maxlength="4" name="password_login_failures" onblur="fncCheckRecord(this)">
							<xsl:attribute name="value"><xsl:value-of select="system_parameter/data_5"/></xsl:attribute>
						</input>
					</td>
				</tr>
				
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEM_PARAMETER_PASSWORD_FORBIDDEN_CHARACTERS')"/></td>
					<td>
						<input type="text" size="35" maxlength="100" name="password_forbidden_characters">
							<xsl:attribute name="value"><xsl:value-of select="system_parameter/data_2"/></xsl:attribute>
						</input>
					</td>
				</tr>
				
				</table>
				
				<br/>
				
				<table border="0" width="570" cellpadding="0" cellspacing="0">
					<tr>
						<td width="40">&nbsp;</td>
						<td class="FORMH2">
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEM_PARAMETER_PASSWORD_FORBIDDEN_WORDS')"/></b>
						</td>
					</tr>
				
				
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr>
				
					<td width="40">&nbsp;</td>
					<td>
				
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td width="40">&nbsp;</td>
							<td align="left">
								<div>
									<xsl:attribute name="id">forbiddenwords_disclaimer</xsl:attribute>
									<xsl:if test="count(parameter_data_set/parameter_data[parm_id='P121']) != 0">
										<xsl:attribute name="style">display:none</xsl:attribute>
									</xsl:if>
									<b><xsl:value-of select="localization:getGTPString($language, 'XSL_PASSWORD_NO_FORBIDDEN_WORD')"/></b>
								</div> 
								<table border="0" width="560" cellpadding="0" cellspacing="1" id="forbiddenwords_master_table" >
									<xsl:if test="count(parameter_data_set/parameter_data[parm_id='P121']) = 0">
										<xsl:attribute name="style">position:absolute;visibility:hidden;</xsl:attribute>
									</xsl:if>
									<tbody id="forbiddenwords_table">
										<tr>
											<xsl:attribute name="id">forbiddenwords_table_header_1</xsl:attribute>
											<xsl:if test="count(parameter_data_set/parameter_data[parm_id='P121']) = 0">
												<xsl:attribute name="style">visibility:hidden;</xsl:attribute>
											</xsl:if>
								            <th class="FORMH3" align="center" width="95%"><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FORBIDDEN_WORD')"/></th>
											<th class="FORMH3" align="center" width="5%">&nbsp;</th>
										</tr>	
										<xsl:apply-templates select="parameter_data_set/parameter_data[parm_id='P121']"/>			
									</tbody>
								</table>
								
								<br/>
								
								<a href="javascript:void(0)">
									<xsl:attribute name="onClick">fncPreloadImages('/content/images/search.png', '/content/images/execute.png', '/content/images/delete.png'); fncLaunchProcess("fncAddElement('fakeform1', 'forbiddenwords', '')");</xsl:attribute>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PASSWORD_ADD_FORBIDDEN_WORD')"/>
								</a>
							</td>
						</tr>
					</table>
				</td>
				
				<tr><td colspan="3">&nbsp;</td></tr>
				
				</tr>

			</table>
	
			</form>
			-->
		</td>
		</tr>
		</table>
		 
		</td>
		</tr>
		</table>
		
		<br/>

		<center>

			<table border="0" cellspacing="2" cellpadding="8">
				<tr>
					<td align="middle" valign="center">
						<a href="javascript:void(0)">
							<xsl:attribute name="onclick">fncPerform('save');return false;</xsl:attribute>
							<img border="0">
								<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($formSaveImage)"/></xsl:attribute>
							</img><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SAVE')"/>
						</a>
					</td>				
					<td align="middle" valign="center">
						<a href="javascript:void(0)">
							<xsl:attribute name="onclick">fncPerform('cancel');return false;</xsl:attribute>
							<img border="0">
							 <xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($formCancelImage)"/></xsl:attribute>
							</img><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/>
						</a>
					</td>
					<!-- 
					<td align="middle" valign="center">
						<a href="javascript:void(0)">
							<xsl:attribute name="onclick">fncPerform('help');return false;</xsl:attribute>
							<img border="0" src="/content/images/pic_form_help.gif"></img><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_HELP')"/>
						</a>
					</td>
					-->
				</tr>
			</table>

		</center>

		<form name="realform" method="POST">
			<xsl:attribute name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/BankSystemFeaturesScreen</xsl:attribute>
			<input type="hidden" name="operation" value="SAVE_FEATURES"/>
			<input type="hidden" name="option" value="SYSTEM_PARAMETER_MAINTENANCE"/>
			<input type="hidden" name="TransactionData"/>
		</form>
		
	</xsl:template>
	
	<xsl:template match="parameter_data">
		<xsl:call-template name="FORBIDDEN_WORDS">
			<xsl:with-param name="structure_name">forbiddenwords</xsl:with-param>
			<xsl:with-param name="mode">existing</xsl:with-param>
			<xsl:with-param name="formName">fakeform1</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="FORBIDDEN_WORDS">

		<xsl:param name="structure_name"/>
		<xsl:param name="mode"/>
		<xsl:param name="suffix">
			<xsl:if test="$mode = 'existing'"><xsl:value-of select="position()"/></xsl:if>
			<xsl:if test="$mode = 'template'">nbElement</xsl:if>
		</xsl:param>
		<xsl:param name="formName"/>

		<tr>
			<xsl:if test="$mode = 'template'">
				<xsl:attribute name="style">visibility:hidden;</xsl:attribute>
			</xsl:if>
			<xsl:attribute name="id">
				<xsl:value-of select="$structure_name"/>_header_<xsl:value-of select="$suffix"/>
			</xsl:attribute>
			
			<td>
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_1</xsl:attribute>
				</xsl:if>
				<div align="left">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_word_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:value-of select="data_1"/>
					</xsl:if>
				</div>
			</td>
			<td align="center">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_2</xsl:attribute>
				</xsl:if>
				<a href="javascript:void(0)">
					<xsl:attribute name="onClick">fncDisplayElement('<xsl:value-of select="$formName"/>', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>);</xsl:attribute>
					<img border="0">
						<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($editImage)"/></xsl:attribute>
						<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_MODIFY')"/></xsl:attribute>
					</img>
				</a>
				<a href="javascript:void(0)">
					<xsl:attribute name="onClick">fncDeleteElement('<xsl:value-of select="$formName"/>', '<xsl:value-of  select="$structure_name"/>', <xsl:value-of select="$suffix"/>, ['<xsl:value-of  select="$structure_name"/>_table_header_1']);</xsl:attribute>
					<img border="0">
						<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($deleteImage)"/></xsl:attribute>
						<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_DELETE')"/></xsl:attribute>
					</img>
				</a>
			</td>
		</tr>

		<tr>
			<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_details_<xsl:value-of select="$suffix"/></xsl:attribute>
			<td colspan="5">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_details_template_cell_1</xsl:attribute>
				</xsl:if>
				<div>
					<xsl:if test="$mode = 'existing'">
						<xsl:attribute name="style">display:none;</xsl:attribute>
					</xsl:if>
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_display_details_<xsl:value-of select="$suffix"/></xsl:attribute>
					<table border="1" width="100%">
						<tr>
							<td>
								<table width="100%" cellpadding="0" cellspacing="0">
									<!-- Word -->
									<tr>
				                    	<td width="150" align="left">
					                        <font class="FORMMANDATORY">
					                          <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FORBIDDEN_WORD')"/>:
					                        </font>
				                      	</td>
				                      	<td colspan="2" align="left">
					                        <input size="35">
					                          <xsl:attribute name="onblur">fncRestoreInputStyle('<xsl:value-of select="$formName"/>','<xsl:value-of select="$structure_name"/>_details_word_<xsl:value-of select="$suffix"/>');</xsl:attribute>
					                          <xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_word_<xsl:value-of select="$suffix"/></xsl:attribute>
					                          <xsl:attribute name="value"><xsl:value-of select="data_1"/></xsl:attribute>
					                        </input>
					                        <input type="hidden">
												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_position_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value">
													<xsl:value-of select="$suffix"/>
												</xsl:attribute>
											</input>
				                      	</td>	
				                    </tr>	
				                    								
								</table>
								<table width="100%" cellpadding="0" cellspacing="0">
									<tr>
										<td colspan="2">&nbsp;</td>
									</tr>
									<tr>
										<td colspan="2">
											<table width="100%">
												<td align="right" width="45%">
													<a href="javascript:void(0)">
														<xsl:attribute name="onClick">fncAddElementValidate('fakeform1', 'forbiddenwords', <xsl:value-of select="$suffix"/>, '', ['word'], ['word'], ['forbiddenwords_table_header_1'])</xsl:attribute>
														<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')"/>
													</a>
												</td>
												<td width="10%"/>
												<td align="left" width="45%">
													<a href="javascript:void(0)">
														<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_cancel_button_<xsl:value-of select="$suffix"/></xsl:attribute>
														<xsl:attribute name="onClick">fncAddElementCancel('<xsl:value-of select="$formName"/>', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, 'word', ['word_table_header_1']);</xsl:attribute>
														<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')"/>
													</a>
												</td>
											</table>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
	</xsl:template>
	
</xsl:stylesheet>
