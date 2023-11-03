<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 		
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization" 		
		xmlns:security="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		exclude-result-prefixes="localization security">

<!--
   Copyright (c) 2000-2005 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->

	<xsl:import href="../../core/xsl/common/trade_common.xsl"/>


	<xsl:output method="html" indent="no"/>
	<!-- Get the language code -->
	<xsl:param name="language"/>
	<xsl:param name="nextscreen"/>
	<xsl:param name="option"/>
	<xsl:param name="rundata"/>
	<xsl:param name="alert_global_code">N050</xsl:param>
	<xsl:param name="parm_id"/>
	<xsl:param name="company_name_param"><xsl:value-of select="alert_records/static_company/abbv_name"/></xsl:param>
   <xsl:param name="company_type_param"><xsl:value-of select="alert_records/static_company/type"/></xsl:param>
   <xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
   <xsl:param name="editImage"><xsl:value-of select="$images_path"/>edit.png</xsl:param>
   <xsl:param name="deleteImage"><xsl:value-of select="$images_path"/>delete.png</xsl:param>
   <xsl:param name="formSaveImage"><xsl:value-of select="$images_path"/>pic_form_save.gif</xsl:param>
   <xsl:param name="formCancelImage"><xsl:value-of select="$images_path"/>pic_form_cancel.gif</xsl:param>
   <xsl:param name="formHelpImage"><xsl:value-of select="$images_path"/>pic_form_help.gif</xsl:param>
   <xsl:param name="upImage"><xsl:value-of select="$images_path"/>pic_up.gif</xsl:param>
	<!-- Get the available languages -->
	<xsl:param name="languages"/>
	
	<xsl:template match="/">
		<xsl:apply-templates select="alert_records"/>
	</xsl:template>
	
	
	<!--***************-->
	<!-- TEMPLATE Main -->
	<!--***************-->
	
	<xsl:template match="alert_records">
    <script type="text/javascript" src="/content/OLD/javascript/com_functions.js"/>
    <script type="text/javascript" src="/content/OLD/javascript/com_amount.js"/>
		<script type="text/javascript">
			<xsl:attribute name="src">/content/OLD/javascript/com_error_<xsl:value-of select="$language"/>.js</xsl:attribute>
		</script>
		<script type="text/javascript" src="/content/OLD/javascript/sy_alert.js"/>
		<script type="text/javascript">
			fncPreloadImages('<xsl:value-of select="utils:getImagePath($editImage)"></xsl:value-of>', '<xsl:value-of select="utils:getImagePath($deleteImage)"></xsl:value-of>'); 
		</script>

		<p><br/></p>
		
		<table border="0" width="100%">
			<tr>
				<td align="center" border="0">
					<table border="0">
						<tr>
							<td align="left" border="0">
								
								<!-- Alerts template (EMAIL) -->
									<xsl:variable name="alerttype">01</xsl:variable>
									<div style="position:absolute;visibility:hidden;">
										<table>
											<tbody>
												<xsl:attribute name="id">alerts_<xsl:value-of select="$alerttype"/>_template</xsl:attribute>
												<xsl:call-template name="alert_record">
													<xsl:with-param name="structure_name">alerts_<xsl:value-of select="$alerttype"/>
													</xsl:with-param>
													<xsl:with-param name="mode">template</xsl:with-param>
													<xsl:with-param name="typeCode">
														<xsl:value-of select="$alerttype"/>
													</xsl:with-param>
												</xsl:call-template>
											</tbody>
										</table>
									</div>
								
								<!-- Alerts template (SMS) -->
									<xsl:variable name="alerttype">02</xsl:variable>
									<div style="position:absolute;visibility:hidden;">
										<table>
											<tbody>
												<xsl:attribute name="id">alerts_<xsl:value-of select="$alerttype"/>_template</xsl:attribute>
												<xsl:call-template name="alert_record">
													<xsl:with-param name="structure_name">alerts_<xsl:value-of select="$alerttype"/>
													</xsl:with-param>
													<xsl:with-param name="mode">template</xsl:with-param>
													<xsl:with-param name="typeCode">
														<xsl:value-of select="$alerttype"/>
													</xsl:with-param>
												</xsl:call-template>
											</tbody>
										</table>
									</div>

								<!-- FORM -->
								<form name="fakeform1" onsubmit="return false;">
									<table border="0" cellspacing="0" cellpadding="0" bgcolor="white">
										<!-- Show the company details -->
										<xsl:apply-templates select="static_company"/>
										
										<p><br/></p>
										
                    <!-- Alerts EMAIL -->
                    <!--<xsl:if test="security:hasCompanyPermission($rundata,'sy_alert_email')">-->
                      <xsl:call-template name="alert_body">
                        <xsl:with-param name="alerttype">01</xsl:with-param>
                      </xsl:call-template>
                    <!--</xsl:if>-->
                    <!-- Alerts SMS -->
                    <!--<xsl:if test="security:hasCompanyPermission($rundata,'sy_alert_sms')">-->
                      <xsl:call-template name="alert_body">
                        <xsl:with-param name="alerttype">02</xsl:with-param>
                      </xsl:call-template>
                    <!--</xsl:if>-->
										
                    <p><br/></p>
										
									</table>
								</form>
								<form name="realform" method="POST">
                  <xsl:attribute name="action">/gtp/screen/<xsl:value-of select="$nextscreen"/></xsl:attribute>
									<input type="hidden" name="operation" value="SAVE_FEATURES"/>
                  <input type="hidden" name="option">
                  	<xsl:attribute name="value"><xsl:value-of select="$option"/></xsl:attribute>
                  </input>
                  <!-- Company is only passed for bank user maintenance on bank side -->
                  <xsl:if test="$option='BANK_ALERT_MAINTENANCE'">
                    <input type="hidden" name="company">
                     	<xsl:attribute name="value"><xsl:value-of select="static_company/abbv_name"/></xsl:attribute>
                    </input>
                  </xsl:if>
									<input type="hidden" name="TransactionData"/>
								</form>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<center>
			<table border="0" cellspacing="2" cellpadding="8">
				<tr>
					<td align="middle" valign="center" border="0">
						<a href="javascript:void(0)" onclick="fncPerform('save');return false;">
							<img border="0">
								<xsl:attribute name ="src"><xsl:value-of select="utils:getImagePath($formSaveImage)"></xsl:value-of></xsl:attribute>
							</img>
							<br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SAVE')"/>
						</a>
					</td>
					<td align="middle" valign="center" border="0">
						<a href="javascript:void(0)" onclick="fncPerform('cancel');return false;">
							<img border="0">
								<xsl:attribute name ="src"><xsl:value-of select="utils:getImagePath($formCancelImage)"></xsl:value-of></xsl:attribute>
							</img>
							<br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/>
						</a>
					</td>
					<td align="middle" valign="center" border="0">
						<a href="javascript:void(0)" onclick="fncPerform('help');return false;">
							<img border="0">
								<xsl:attribute name ="src"><xsl:value-of select="utils:getImagePath($formHelpImage)"></xsl:value-of></xsl:attribute>
							</img>
							<br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_HELP')"/>
						</a>
					</td>
				</tr>
			</table>
		</center>
	</xsl:template>

	
	<xsl:template name="alert_body">
		<xsl:param name="alerttype"/>
		<table border="0" width="570" cellpadding="0" cellspacing="0" rules="none">
			<tr>
				<td class="FORMH1" border="0">
					<!-- Input field that stores alert type code -->
					<input type="hidden" name="alert_type_code">
						<xsl:attribute name="value">
							<xsl:value-of select="$alerttype"/>
						</xsl:attribute>
					</input>
					<b>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_ALERT')"/> : &nbsp;<xsl:value-of select="localization:getDecode($language, $alert_global_code, $alerttype)"/>
					</b>
				</td>
				<td align="right" class="FORMH1" border="0">
					<a href="#">
						<img border="0">
							<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($upImage)"></xsl:value-of></xsl:attribute>
							<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_TOP_PAGE')"/></xsl:attribute>
						</img>
					</a>
				</td>
			</tr>
		</table>
		<br/>
		<table border="0" width="570" cellpadding="0" cellspacing="0">
			<tr>
				<td width="40">&nbsp;</td>
				<td>
					<xsl:variable name="countrecords">
						<xsl:value-of select="count(alert[alert_type=$alerttype])"/>
					</xsl:variable>
					<!-- Disclaimer -->
					<div>
						<xsl:attribute name="id">alerts_<xsl:value-of select="$alerttype"/>_disclaimer</xsl:attribute>
						<xsl:if test="$countrecords != 0">
							<xsl:attribute name="style">display:none</xsl:attribute>
						</xsl:if>
						<b><xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_NO_ALERT_SETUP')"/></b>
					</div>
					<!-- Existing records -->
					<table border="0" width="570" cellpadding="0" cellspacing="1">
						<xsl:attribute name="id">alerts_<xsl:value-of select="$alerttype"/>_master_table</xsl:attribute>
						<xsl:if test="$countrecords = 0">
							<xsl:attribute name="style">position:absolute;visibility:hidden;</xsl:attribute>
						</xsl:if>
						<tbody>
							<xsl:attribute name="id">alerts_<xsl:value-of select="$alerttype"/>_table</xsl:attribute>
							<!-- Columns Header -->
							<tr>
								<xsl:attribute name="id">alerts_<xsl:value-of select="$alerttype"/>_table_header_1</xsl:attribute>
								<xsl:if test="$countrecords = 0">
									<xsl:attribute name="style">visibility:hidden;</xsl:attribute>
								</xsl:if>
								<th class="FORMH2" align="center" width="25%">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_PRODUCT_HEADER')"/>
								</th>
								<!-- Submission Alert START -->
								<xsl:choose>
									<!-- Submission Alert START -->
									<xsl:when test="$parm_id='P200'">
										<th class="FORMH2" align="center" width="20%">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_TYPECODE_HEADER')"/>
										</th>
									</xsl:when>
									<!-- Submission Alert END -->
									<!-- Calendar Alert START -->
									<xsl:when test="$parm_id='P201'">
										<th class="FORMH2" align="center" width="25%">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_DATE_HEADER')"/>
										</th>
									</xsl:when>
									<!-- Calendar Alert END -->
								</xsl:choose>
								<th class="FORMH2" align="center" width="30%">
									<xsl:choose>
										<xsl:when test="$alerttype='01'">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_EMAIL_ADDRESS_HEADER')"/>
										</xsl:when>
										<xsl:when test="$alerttype='02'">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_SMS_ADDRESS_HEADER')"/>
										</xsl:when>
									</xsl:choose>
								</th>
								<th class="FORMH2" align="center" width="10%">&nbsp;</th>
							</tr>
							<!-- Details -->
							<xsl:apply-templates select="alert[alert_type=$alerttype]"/>
						</tbody>
					</table>
					<br/>
					<a href="javascript:void(0)">
							<xsl:attribute name="onClick">if (fncCheckAlertNumber('fakeform1','alerts_<xsl:value-of select="$alerttype"/>') ) {fncPreloadImages('<xsl:value-of select="utils:getImagePath($editImage)"></xsl:value-of>', '<xsl:value-of select="utils:getImagePath($deleteImage)"></xsl:value-of>'); fncLaunchProcess("fncAddElement('fakeform1', 'alerts_<xsl:value-of select="$alerttype"/>', '')");}</xsl:attribute>
						<xsl:choose>
							<xsl:when test="$alerttype='01'">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_ADD_EMAIL_ADDRESS')"/>
							</xsl:when>
							<xsl:when test="$alerttype='02'">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_ADD_SMS_ADDRESS')"/>
							</xsl:when>
						</xsl:choose>
					</a>
				</td>
			</tr>
		</table>
		<p>
			<br/>
		</p>
	</xsl:template>


	<!--*******-->
	<!-- Alert -->
	<!--*******-->

	<xsl:template match="alert[alert_type='01' or alert_type='02']">
		<xsl:call-template name="alert_record">
			<xsl:with-param name="structure_name">alerts_<xsl:value-of select="alert_type"/>
			</xsl:with-param>
			<xsl:with-param name="mode">existing</xsl:with-param>
			<xsl:with-param name="typeCode"><xsl:value-of select="alert_type"/></xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	
	<!--******************************-->
	<!-- Template for Company Details -->
	<!--******************************-->
	
	<xsl:template match="static_company">
		<table border="0" width="570" cellpadding="0" cellspacing="0" bgcolor="white">
			<tr>
				<td class="FORMH1" border="0">
					<b>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_COMPANY_DETAILS')"/>
					</b>
				</td>
			</tr>
		</table>
		<br/>
		<table border="0" width="570" cellpadding="0" cellspacing="0" bgcolor="white">
			<tr>
				<td width="40" border="0">&nbsp;</td>
				<td width="200" border="0">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_ABREVIATED_NAME')"/>
				</td>
				<td border="0">
					<font class="REPORTDATA">
						<xsl:value-of select="abbv_name"/>
					</font>
					<input type="hidden" name="company_id">
						<xsl:attribute name="value"><xsl:value-of select="company_id"/></xsl:attribute>
					</input>
					<input type="hidden" name="type">
						<xsl:attribute name="value"><xsl:value-of select="type"/></xsl:attribute>
					</input>
					<input type="hidden" name="brch_code">
						<xsl:attribute name="value"><xsl:value-of select="brch_code"/></xsl:attribute>
					</input>
					<input type="hidden" name="abbv_name">
						<xsl:attribute name="value"><xsl:value-of select="abbv_name"/></xsl:attribute>
					</input>
				</td>
			</tr>
			<tr>
				<td width="40" border="0">&nbsp;</td>
				<td width="200" border="0">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_NAME')"/>
				</td>
				<td border="0">
					<font class="REPORTDATA">
						<xsl:value-of select="name"/>
					</font>
					<input type="hidden" name="name">
						<xsl:attribute name="value"><xsl:value-of select="name"/></xsl:attribute>
					</input>
				</td>
			</tr>
			<tr>
				<td width="40" border="0">&nbsp;</td>
				<td width="200" border="0">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_ADDRESS')"/>
				</td>
				<td border="0">
					<font class="REPORTDATA">
						<xsl:value-of select="address_line_1"/>
					</font>
					<input type="hidden" name="address_line_1">
						<xsl:attribute name="value"><xsl:value-of select="address_line_1"/></xsl:attribute>
					</input>
				</td>
			</tr>
			<xsl:if test="address_line_2[.!='']">
				<tr>
					<td width="40" border="0">&nbsp;</td>
					<td width="200" border="0">&nbsp;</td>
					<td border="0">
						<font class="REPORTDATA">
							<xsl:value-of select="address_line_2"/>
						</font>
						<input type="hidden" name="address_line_2">
							<xsl:attribute name="value"><xsl:value-of select="address_line_2"/></xsl:attribute>
						</input>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="dom[.!='']">
				<tr>
					<td width="40" border="0">&nbsp;</td>
					<td width="200" border="0">&nbsp;</td>
					<td border="0">
						<font class="REPORTDATA">
							<xsl:value-of select="dom"/>
						</font>
						<input type="hidden" name="dom">
							<xsl:attribute name="value"><xsl:value-of select="dom"/></xsl:attribute>
						</input>
					</td>
				</tr>
			</xsl:if>
			<xsl:if test="contact_name[.!='']">
				<tr>
					<td width="40" border="0">&nbsp;</td>
					<td width="200" border="0">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_CONTACT_NAME')"/>
					</td>
					<td border="0">
						<font class="REPORTDATA">
							<xsl:value-of select="contact_name"/>
						</font>
						<input type="hidden" name="contact_name">
							<xsl:attribute name="value"><xsl:value-of select="contact_name"/></xsl:attribute>
						</input>
					</td>
				</tr>
			</xsl:if>
		</table>
	</xsl:template>

	
	<!--******************-->
	<!-- Alert parameters -->
	<!--******************-->

	<xsl:template name="alert_record">
		<!-- Mandatory Parameters -->
		<xsl:param name="structure_name"/>
		<xsl:param name="mode"/>
		<xsl:param name="typeCode"/>
		<xsl:param name="suffix">
			<xsl:if test="$mode = 'existing'">
				<xsl:value-of select="position()"/>
			</xsl:if>
			<xsl:if test="$mode = 'template'">nbElement</xsl:if>
		</xsl:param>
		<!-- Header -->
		<tr>
			<xsl:if test="$mode = 'template'">
				<xsl:attribute name="style">visibility:hidden;</xsl:attribute>
			</xsl:if>
			<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_<xsl:value-of select="$suffix"/></xsl:attribute>
			<td align="left">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_1</xsl:attribute>
				</xsl:if>
				<div>
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_proddecode_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:variable name="codeval"><xsl:value-of select="prod_code"/></xsl:variable>
						<xsl:value-of select="localization:getDecode($language, 'N001', $codeval)"/>
					</xsl:if>
				</div>
			</td>
			<td align="left">
        <xsl:if test="$mode = 'template'">
            <xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_2</xsl:attribute>
          </xsl:if>
        <xsl:choose>
   				<!-- Submission Alert START -->
   				<xsl:when test="$parm_id='P200'">
         			<div>
      					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_tnxtypedecode_<xsl:value-of select="$suffix"/></xsl:attribute>
      					<xsl:if test="$mode = 'existing'">
      						<xsl:variable name="codeval"><xsl:value-of select="tnx_type_code"/></xsl:variable>
      						<xsl:value-of select="localization:getDecode($language, 'N002', $codeval)"/>
      					</xsl:if>
      				</div>
   				</xsl:when>
   				<!-- Submission Alert END -->
   				<!-- Calendar Alert START -->
          <xsl:when test="$parm_id='P201'">
            <div>
              <xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_complete_milestone_<xsl:value-of select="$suffix"/></xsl:attribute>
              <xsl:if test="$mode = 'existing'">
                <xsl:variable name="codeval"><xsl:value-of select="date_code"/></xsl:variable>
                <xsl:variable name="offsetsigncode"><xsl:value-of select="offsetsign"/></xsl:variable>
                <xsl:variable name="offsetcode"><xsl:value-of select="offset"/></xsl:variable>
                <xsl:choose>
                        <xsl:when test="$codeval='*'">*</xsl:when>
                        <xsl:otherwise><xsl:value-of select="localization:getGTPString($language, $codeval)"/>
                          <xsl:choose>
                            <xsl:when test="$offsetsigncode='1'">&nbsp;(+</xsl:when>
                            <xsl:otherwise>&nbsp;(-</xsl:otherwise>
                          </xsl:choose>
                          <xsl:value-of select="$offsetcode"/>)
                        </xsl:otherwise>
                </xsl:choose>
              </xsl:if>
            </div>
          </xsl:when>
          <!-- Calendar Alert END -->
        </xsl:choose>
   		</td>
			<td align="left">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_4</xsl:attribute>
				</xsl:if>
				<div>
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_address_value_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:choose>
							<xsl:when test="address[.='INPUT_USER'] or address[.='BO_INPUT_USER']">
								<xsl:value-of select="localization:getGTPString($language, 'INP_USER')"/>
							</xsl:when>
							<xsl:when test="address[.='CONTROL_USER'] or address[.='BO_CONTROL_USER']">
								<xsl:value-of select="localization:getGTPString($language, 'CTL_USER')"/>
							</xsl:when>
							<xsl:when test="address[.='RELEASE_USER'] or address[.='BO_RELEASE_USER']">
								<xsl:value-of select="localization:getGTPString($language, 'RLS_USER')"/>
							</xsl:when>
							<xsl:otherwise><xsl:value-of select="address"/></xsl:otherwise>
						</xsl:choose>					
					</xsl:if>
				</div>
			</td>
			<!-- Delete / Edit button -->
			<td align="center">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_5</xsl:attribute>
				</xsl:if>
				<a href="javascript:void(0)">
					<xsl:attribute name="onClick">fncDisplayElement('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>);</xsl:attribute>
					<img border="0" src="/content/images/edit.png">
						<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_MODIFY')"/></xsl:attribute>
					</img>
				</a>
				<a href="javascript:void(0)">
					<xsl:attribute name="onClick">fncDeleteElement('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, ['<xsl:value-of select="$structure_name"/>_table_header_1']);</xsl:attribute>
					<img border="0" src="/content/images/delete.png">
						<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_DELETE')"/></xsl:attribute>
					</img>
				</a>
			</td>
		</tr>
		<!-- Details displaid on demand -->
		<tr>
			<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_details_<xsl:value-of select="$suffix"/></xsl:attribute>
			<td colspan="4" width="100%">
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
									<tr>
										<td>&nbsp;</td>
									</tr>
									<tr>
										<td width="150">
											<font class="FORMMANDATORY">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_PRODUCT')"/>
											</font>
										</td>
										<td colspan="2">
											<!-- We store main dates for each product code in a JavaScript array -->
											<xsl:if test="$parm_id='P201'">
												<script type="text/javascript">var mainDates = new Array();</script>
											</xsl:if>
											
											<select>
                        <xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_select_prodcode_<xsl:value-of select="$suffix"/></xsl:attribute>
                        <xsl:attribute name="onblur">var theSelectObj=<xsl:value-of select="$structure_name"/>_details_select_prodcode_<xsl:value-of select="$suffix"/>;<xsl:value-of select="$structure_name"/>_details_prodcode_<xsl:value-of select="$suffix"/>.value=theSelectObj.options[theSelectObj.selectedIndex].value;<xsl:value-of select="$structure_name"/>_details_proddecode_<xsl:value-of select="$suffix"/>.value=theSelectObj.options[theSelectObj.selectedIndex].text;fncRestoreInputStyle('fakeform1','<xsl:value-of select="$structure_name"/>_details_select_prodcode_<xsl:value-of select="$suffix"/>');</xsl:attribute>
                         <xsl:attribute name="onchange">
                          <!-- Case of Calendar Alert : change dates list according to product code -->
                          <xsl:if test="$parm_id='P201'">
                            fncPopulateDates(this,document.fakeform1.<xsl:value-of select="$structure_name"/>_details_select_datecode_<xsl:value-of select="$suffix"/>,document.fakeform1.<xsl:value-of select="$structure_name"/>_details_prodcode_<xsl:value-of select="$suffix"/>);
                          </xsl:if>
                          return;
                         </xsl:attribute>		
                         <!-- First product code select box option -->
                         <xsl:choose>
                           <!-- Submission Alert : default = * -->
                           <xsl:when test="$parm_id='P200'">
                              <option value="*">
                                <xsl:if test="prod_code='*'">
                                  <xsl:attribute name="selected"/>
                                </xsl:if>
                                <xsl:value-of select="localization:getDecode($language, 'N001', 'WILDCARD')"/>
                              </option>
                            </xsl:when>
                            <!-- Calendar Alert : default = &nbsp; -->
                            <xsl:when test="$parm_id='P201'">
                              <option value="">
                                &nbsp;
                              </option>
                            </xsl:when>
                         </xsl:choose>
                                    
                        <!-- Add available product code -->
												<xsl:call-template name="avail_product_code">
													<xsl:with-param name="curr_prodcode"><xsl:value-of select="prod_code"/></xsl:with-param>
												</xsl:call-template>
													
											</select>
											
											<input type="hidden">
												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_prodcode_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value">
													<xsl:choose>
														<xsl:when test="$mode='existing' and prod_code[.!='']">
															<xsl:value-of select="prod_code"/>
														</xsl:when>
														<xsl:otherwise>*</xsl:otherwise>
													</xsl:choose>
												</xsl:attribute>
											</input>
											<input type="hidden">
												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_proddecode_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value">
													<xsl:choose>
														<xsl:when test="$mode='existing' and prod_code[.!='']">
															<xsl:variable name="prodcode"><xsl:value-of select="prod_code"/></xsl:variable>
															<xsl:value-of select="localization:getDecode($language, 'N001', $prodcode)"/>
														</xsl:when>
														<xsl:otherwise>*</xsl:otherwise>
													</xsl:choose>
												</xsl:attribute>
											</input>
										</td>
									</tr>
									<xsl:choose>
										<!-- Submission Alerts START -->
										<xsl:when test="$parm_id='P200'">
      									<tr>
      										<td width="150">
      											<font class="FORMMANDATORY">
      												<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_TNX_TYPE_CODE')"/>
      											</font>
      										</td>
      										<td colspan="2">
      											<select>
      												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_select_tnxtypecode_<xsl:value-of select="$suffix"/></xsl:attribute>
      												<xsl:attribute name="onblur">var theSelectObj = <xsl:value-of select="$structure_name"/>_details_tnxtypecode_<xsl:value-of select="$suffix"/>.value=<xsl:value-of select="$structure_name"/>_details_select_tnxtypecode_<xsl:value-of select="$suffix"/>; <xsl:value-of select="$structure_name"/>_details_tnxtypecode_<xsl:value-of select="$suffix"/>.value=theSelectObj.options[theSelectObj.selectedIndex].value;<xsl:value-of select="$structure_name"/>_details_tnxtypedecode_<xsl:value-of select="$suffix"/>.value=theSelectObj.options[theSelectObj.selectedIndex].text;</xsl:attribute>
                  								<option value='*'>
                  									<xsl:if test="tnx_type_code[.='*']">
                  										<xsl:attribute name="selected"/>
                  									</xsl:if>
                  									<xsl:value-of select="localization:getDecode($language, 'N002', '*')"/>
                  								</option>
                  								<option value='01'>
                  									<xsl:if test="tnx_type_code[.='01']">
                  										<xsl:attribute name="selected"/>
                  									</xsl:if>
                  									<xsl:value-of select="localization:getDecode($language, 'N002', '01')"/>
                  								</option>
                  								<option value='03'>
                  									<xsl:if test="tnx_type_code[.='03']">
                  										<xsl:attribute name="selected"/>
                  									</xsl:if>
                  									<xsl:value-of select="localization:getDecode($language, 'N002', '03')"/>
                  								</option>
                  								<option value='13'>
                  									<xsl:if test="tnx_type_code[.='13']">
                  										<xsl:attribute name="selected"/>
                  									</xsl:if>
                  									<xsl:value-of select="localization:getDecode($language, 'N002', '13')"/>
                  								</option>
               									<option value='15'>
               										<xsl:if test="tnx_type_code[.='15']">
               											<xsl:attribute name="selected"/>
               										</xsl:if>
               										<xsl:value-of select="localization:getDecode($language, 'N002', '15')"/>
               									</option>
               									<!-- Special option for DM Presentation -->
      	                          			<xsl:if test="security:hasCompanyPermission($rundata,'dm_access') or security:hasCompanyPermission($rundata,'tradeadmin_dm_access')">
                  									<option value='18'>
                  										<xsl:if test="tnx_type_code[.='18']">
                  											<xsl:attribute name="selected"/>
                  										</xsl:if>
                  										<xsl:value-of select="localization:getDecode($language, 'N002', '18')"/>
                  									</option>
      	                          			</xsl:if>
      											</select>
      											<input type="hidden">
      												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_tnxtypecode_<xsl:value-of select="$suffix"/></xsl:attribute>
      												<xsl:attribute name="value">
      													<xsl:choose>
      														<xsl:when test="$mode='existing' and tnx_type_code[.!='']">
      															<xsl:value-of select="tnx_type_code"/>
      														</xsl:when>
      														<xsl:otherwise>*</xsl:otherwise>
      													</xsl:choose>
      												</xsl:attribute>
      											</input>
      											<input type="hidden">
      												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_tnxtypedecode_<xsl:value-of select="$suffix"/></xsl:attribute>
      												<xsl:attribute name="value">
      													<xsl:choose>
      														<xsl:when test="$mode='existing' and prod_code[.!='']">
      															<xsl:variable name="tnxtypecode"><xsl:value-of select="tnx_type_code"/></xsl:variable>
      															<xsl:value-of select="localization:getDecode($language, 'N002', $tnxtypecode)"/>
      														</xsl:when>
      														<xsl:otherwise>*</xsl:otherwise>
      													</xsl:choose>
      												</xsl:attribute>
      											</input>
      											</td>
      									<!-- Submission Alerts END -->
      									</tr>
											<!-- The tnx stat code is also an important parameter to
											decide when the alert is triggered. However this value is
											currently hardcoded: the customers can only receive
											transactions saved by banks (ACKNOWLEDGE status: 04), and
											banks receive customer's transactions (CONTROLLED status: 03) -->
											<!--input type="hidden">
												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_tnxstatcode_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value">**</xsl:attribute>
											</input-->
										</xsl:when>
										<xsl:when test="$parm_id='P201'">
											<!-- Calendar Alerts START -->
											<tr>
												<td width="150">
      											<font class="FORMMANDATORY">
      												<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_DATE_HEADER')"/>:
      											</font>
      										</td>
      										<td colspan="2">
      											<select>			
      												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_select_datecode_<xsl:value-of select="$suffix"/></xsl:attribute>
      												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of select="$structure_name"/>_details_select_datecode_<xsl:value-of select="$suffix"/>');var theSelectObj=<xsl:value-of select="$structure_name"/>_details_select_datecode_<xsl:value-of select="$suffix"/>;<xsl:value-of select="$structure_name"/>_details_datecode_<xsl:value-of select="$suffix"/>.value=theSelectObj.options[theSelectObj.selectedIndex].value;<xsl:value-of select="$structure_name"/>_details_datedecode_<xsl:value-of select="$suffix"/>.value=theSelectObj.options[theSelectObj.selectedIndex].text;</xsl:attribute>
      												<xsl:choose>
      													<xsl:when test="prod_code[.!='']">
																<xsl:apply-templates select="." mode="dateSelectBox"/>
															</xsl:when>
															<xsl:otherwise/>
      												</xsl:choose>
      											</select>
      											<input type="hidden">
      												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_datecode_<xsl:value-of select="$suffix"/></xsl:attribute>
      												<xsl:attribute name="value">
      													<xsl:choose>
      														<xsl:when test="$mode='existing' and date_code[.!='']">
      															<xsl:value-of select="date_code"/>
      														</xsl:when>
      													</xsl:choose>
      												</xsl:attribute>
      											</input>
      											<input type="hidden">
      												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_datedecode_<xsl:value-of select="$suffix"/></xsl:attribute>
      												<xsl:attribute name="value">
      													<xsl:choose>
      														<xsl:when test="$mode='existing' and date_code[.!=''] and date_code[.!='*']">
      															<xsl:variable name="datecode"><xsl:value-of select="date_code"/></xsl:variable>
      															<xsl:value-of select="localization:getGTPString($language, $datecode)"/>
      														</xsl:when>
      														<xsl:otherwise>*</xsl:otherwise>
      													</xsl:choose>
      												</xsl:attribute>
      											</input>
      										</td>
											</tr>
											<tr>                     
												<td width="150">
                         <font class="FORMMANDATORY">
                            <xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_OFFSET_HEADER')"/>
                          </font>
                        </td>
                        <td>
                          <input size="1" maxlength="1">			
                            <xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_offsetcode_<xsl:value-of select="$suffix"/></xsl:attribute>
                            <xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of select="$structure_name"/>_details_offsetcode_<xsl:value-of select="$suffix"/>');fncValidateOffset(this)</xsl:attribute>
                            <xsl:attribute name="value"><xsl:value-of select="offset"/></xsl:attribute>
                          </input>
                        </td>
                        <td>
                          <table>
                            <tr>
                              <td>
                                <font class="FORMMANDATORY">
                                  <xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_OFFSET_BEFORE_HEADER')"/>
                                </font>
                              </td>
                              <td>
                                <input type="radio" value="0">			
                                  <xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_offsetsigncode_<xsl:value-of select="$suffix"/></xsl:attribute>
                                    <xsl:if test="offsetsign[.='0']">
                                      <xsl:attribute name="checked"/>
                                    </xsl:if>
                                </input>
                              </td>
                            </tr>
                            <tr>
                              <td>
                                <font class="FORMMANDATORY">
                                  <xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_OFFSET_AFTER_HEADER')"/>
                                </font>
                              </td>
                              <td>
                                <input type="radio" value="1">			
                                  <xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_offsetsigncode_<xsl:value-of select="$suffix"/></xsl:attribute>
                                    <xsl:if test="offsetsign[.='1']">
                                      <xsl:attribute name="checked"/>
                                    </xsl:if>
                                </input>
                                <!-- output type (email, sms, ...) may be choosen by user -->
                               <xsl:variable name="jobName">milestonesjob<xsl:value-of select="$typeCode"/></xsl:variable>
                                <input type="hidden" value="milestonesemailjob">			
                                  <xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_output_<xsl:value-of select="$suffix"/></xsl:attribute>
                                  <xsl:attribute name="value"><xsl:value-of select="$jobName"/></xsl:attribute>
                               </input>
                               <!-- input field is used to concate data+sign+offset. It's computed in JS -->
                               <input type="hidden">			
                                  <xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_complete_milestone_<xsl:value-of select="$suffix"/></xsl:attribute>
                                  <xsl:attribute name="value"/>
                              </input>
                              </td>
                            </tr>
                          </table>
                        </td>                        
											</tr>         
										</xsl:when>
									<!-- Calendar Alerts END -->
									</xsl:choose>
                  <tr>
                  	<td colspan="3">&nbsp;</td>
                  </tr>
                  <!--<tr>
                  	<td colspan="3">
                  		<font class="MESSAGE">
                  			<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_ALERT_RECIPIENT_SELECTION')"/>
                  		</font>
							</td>
                  </tr>
                  <tr>
                  	<td colspan="3">&nbsp;</td>
                  </tr>
                  <tr>
                      <td width="150">
								<font>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ABBV_NAME')"/>
								</font>
							 </td>
                      <td colspan="2">
                        <select>
                          <xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_usercode_<xsl:value-of select="$suffix"/></xsl:attribute>
                                <xsl:attribute name="onclick">fncResetAlertDetails(this,'<xsl:value-of select="$structure_name"/>','<xsl:value-of select="$suffix"/>');</xsl:attribute>
                                <xsl:attribute name="onblur">fncPopulateDetails('<xsl:value-of select="$structure_name"/>','<xsl:value-of select="$suffix"/>');</xsl:attribute>
                                <option value="">&nbsp;</option>
                                <option>
                                  <xsl:choose>
                                    <xsl:when test="not($company_type_param='03')">
                                      <xsl:attribute name="value">BO_INPUT_USER</xsl:attribute>
                                          <xsl:if test="address='BO_INPUT_USER'">
                                                    <xsl:attribute name="selected"/>
                                                </xsl:if>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="value">INPUT_USER</xsl:attribute>
                                        <xsl:if test="address='INPUT_USER'">
                                                  <xsl:attribute name="selected"/>
                                              </xsl:if>
                                          </xsl:otherwise>
                                      </xsl:choose>
                                <xsl:value-of select="localization:getGTPString($language, 'INP_USER')"/>
                              </option>
                                <option value="ctl_user">	
                                  <xsl:choose>
                                    <xsl:when test="not($company_type_param='03')">
                                      <xsl:attribute name="value">BO_CONTROL_USER</xsl:attribute>
                                          <xsl:if test="address='BO_CONTROL_USER'">
                                                    <xsl:attribute name="selected"/>
                                              </xsl:if>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="value">CONTROL_USER</xsl:attribute>
                                        <xsl:if test="address='CONTROL_USER'">
                                                  <xsl:attribute name="selected"/>
                                              </xsl:if>
                                          </xsl:otherwise>
                                      </xsl:choose>
                                <xsl:value-of select="localization:getGTPString($language, 'CTL_USER')"/>
                              </option>
                              <option>
                                  <xsl:choose>
                                    <xsl:when test="not($company_type_param='03')">
                                      <xsl:attribute name="value">BO_RELEASE_USER</xsl:attribute>
                                          <xsl:if test="address='BO_RELEASE_USER'">
                                                    <xsl:attribute name="selected"/>
                                              </xsl:if>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="value">RELEASE_USER</xsl:attribute>
                                        <xsl:if test="address='RELEASE_USER'">
                                                  <xsl:attribute name="selected"/>
                                              </xsl:if>
                                          </xsl:otherwise>
                                         </xsl:choose>
                                <xsl:value-of select="localization:getGTPString($language, 'RLS_USER')"/>
                              </option>
                              </select>
                          </td>
                    </tr>-->
                  
									<tr>
										<td width="150">
											<font>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_LANGUAGE_LOCALE')"/>
											<xsl:value-of select="alertlanguage"/></font>
										</td>
										<td colspan="2">
               			<select>
                      <xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_langcode_<xsl:value-of select="$suffix"/></xsl:attribute>
                          <xsl:attribute name="onchange">fncDisableAlertDetails(this,'<xsl:value-of select="$structure_name"/>','<xsl:value-of select="$suffix"/>');</xsl:attribute>
                          <xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of select="$structure_name"/>_details_langcode_<xsl:value-of select="$suffix"/>');</xsl:attribute>
                          <option value="">
                          <xsl:choose>
                            <xsl:when test="alertlanguage[.='']">
                              <xsl:attribute name="selected"/>
                            </xsl:when>
                            <xsl:otherwise/>
                          </xsl:choose>
                        </option>
                        <xsl:variable name="current"><xsl:value-of select="alertlanguage"/></xsl:variable>
                        <xsl:for-each select="$languages/languages/language">
                           <xsl:variable name="optionLanguage"><xsl:value-of select="."/></xsl:variable>
                           <option>
                              <xsl:attribute name="value"><xsl:value-of select="$optionLanguage"/></xsl:attribute>
                              <xsl:choose>
                                 <xsl:when test="$current = $optionLanguage">
	                                 <xsl:attribute name="selected"/>
                                 </xsl:when>
                                 <xsl:otherwise/>
                              </xsl:choose>
                              <xsl:value-of select="localization:getDecode($language, 'N061', $optionLanguage)"/>
                           </option>
                        </xsl:for-each>
                       </select>
										</td>
									</tr>
									<tr>
										<td width="150">
											<font>
												<xsl:choose>
													<xsl:when test="$typeCode='01'">
														<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_EMAIL_ADDRESS_HEADER')"/>:
													</xsl:when>
													<xsl:when test="$typeCode='02'">
														<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_SMS_ADDRESS_HEADER')"/>:
													</xsl:when>
												</xsl:choose>
											</font>
										</td>
										<td colspan="2">
											<input type="text">
												<xsl:attribute name="onfocus">fncDisableAlertDetails(this,'<xsl:value-of select="$structure_name"/>','<xsl:value-of select="$suffix"/>');</xsl:attribute>
												<xsl:attribute name="onblur">fncPopulateDetails('<xsl:value-of select="$structure_name"/>','<xsl:value-of select="$suffix"/>');fncRestoreInputStyle('fakeform1', '<xsl:value-of select="$structure_name"/>_details_address_<xsl:value-of select="$suffix"/>');</xsl:attribute>
												<!--<xsl:choose>
													<xsl:when test="$typeCode='01'">-->
														<xsl:attribute name="size">40</xsl:attribute>
														<xsl:attribute name="maxlength">255</xsl:attribute>
													<!--</xsl:when>
													<xsl:when test="$typeCode='02'">
														<xsl:attribute name="size">10</xsl:attribute>
														<xsl:attribute name="maxlength">10</xsl:attribute>
													</xsl:when>
												</xsl:choose>-->
												<xsl:attribute name="name">
													<xsl:value-of select="$structure_name"/>_details_address_<xsl:value-of select="$suffix"/>
												</xsl:attribute>
												<!--<xsl:if test="$mode = 'existing' and address[.!='INPUT_USER'] and address[.!='CONTROL_USER'] and address[.!='RELEASE_USER'] and address[.!='BO_INPUT_USER'] and address[.!='BO_CONTROL_USER'] and address[.!='BO_RELEASE_USER']">-->
												<xsl:if test="$mode = 'existing'">
													<xsl:attribute name="value">
														<xsl:value-of select="address"/>
													</xsl:attribute>	
                     		</xsl:if>
 											</input>
											<input type="hidden">
												<xsl:attribute name="name">
													<xsl:value-of select="$structure_name"/>_details_position_<xsl:value-of select="$suffix"/>
												</xsl:attribute>
												<xsl:attribute name="value">
													<xsl:value-of select="$suffix"/>
												</xsl:attribute>
											</input>
											<input type="hidden">
												<xsl:attribute name="name"><xsl:value-of select="$structure_name"/>_details_address_value_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value">
													<!--<xsl:choose>
                     							<xsl:when test="address[.='INPUT_USER'] or address[.='BO_INPUT_USER']">
                     								<xsl:value-of select="localization:getGTPString($language, 'INP_USER')"/>
                     							</xsl:when>
                     							<xsl:when test="address[.='CONTROL_USER'] or address[.='BO_CONTROL_USER']">
                     								<xsl:value-of select="localization:getGTPString($language, 'CTL_USER')"/>
                     							</xsl:when>
                     							<xsl:when test="address[.='RELEASE_USER'] or address[.='BO_RELEASE_USER']">
                     								<xsl:value-of select="localization:getGTPString($language, 'RLS_USER')"/>
                     							</xsl:when>
                     							<xsl:otherwise><xsl:value-of select="address"/></xsl:otherwise>
													</xsl:choose>-->
                          <xsl:value-of select="address"/>
												</xsl:attribute>
											</input>
										</td>
									</tr>
									<tr>
										<td colpan="3">&nbsp;</td>
									</tr>
									<tr>
										<td colspan="3">
											<table width="100%">
												<td align="right" width="45%">
													<a href="javascript:void(0)">
														<xsl:attribute name="onClick">fncAddAlertValidate('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, '', ['<xsl:value-of select="$structure_name"/>_table_header_1']);</xsl:attribute>
														<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')"/>
													</a>
												</td>
												<td width="10%"/>
												<td align="left" width="45%">
													<a href="javascript:void(0)">
														<xsl:attribute name="onClick">fncAddAlertCancel('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, ['<xsl:value-of select="$structure_name"/>_table_header_1']);</xsl:attribute>
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
	
	<!-- Populate Main Dates Select Box (Calendar Alerts) -->
	<xsl:template match="alert" mode="dateSelectBox">
		<xsl:variable name="prodcode"><xsl:value-of select="prod_code"/></xsl:variable>
		<xsl:variable name="datecode"><xsl:value-of select="date_code"/></xsl:variable>
		<!--option>
			<xsl:attribute name="value">*</xsl:attribute>
			<xsl:if test="$datecode='*'">
				<xsl:attribute name="selected"/>
			</xsl:if>
			*
   	</option-->
		<xsl:for-each select="//alert_records/main_dates/date[@product_code=$prodcode]">
			<xsl:variable name="localization"><xsl:value-of select="localization"/></xsl:variable>
   		<option>
   			<xsl:attribute name="value"><xsl:value-of select="$localization"></xsl:value-of></xsl:attribute>
   			<xsl:if test="$datecode=$localization">
   				<xsl:attribute name="selected"/>
   			</xsl:if>
   			<xsl:value-of select="localization:getGTPString($language, $localization)"/>
   		</option>
   	</xsl:for-each>
	</xsl:template>
	
	<!-- Populate Javascript 'mainDates' Array -->	
 	<xsl:template match="date" mode="array"><xsl:param name="localization_key"><xsl:value-of select="localization"/></xsl:param>,'<xsl:call-template name="quote_replace"><xsl:with-param name="input_text" select="localization:getGTPString($language,$localization_key)" /></xsl:call-template>','<xsl:value-of select="$localization_key"/>'</xsl:template>
 	
 	<!-- Populate Product Code Select Box -->
	<xsl:template name="avail_product_code" mode="productSelectBox">
    <xsl:param name="curr_prodcode"/>
    <!-- List of available Products -->
    <xsl:for-each select="//alert_records/avail_products/product_code">
      <xsl:variable name="avail_prodcode"><xsl:value-of select="."/></xsl:variable>
      <option>
        <xsl:attribute name="value"><xsl:value-of select="$avail_prodcode"/></xsl:attribute>
          <xsl:if test="$avail_prodcode=$curr_prodcode">
            <xsl:attribute name="selected"/>
          </xsl:if>
          <xsl:value-of select="localization:getDecode($language, 'N001', $avail_prodcode)"/>
          <xsl:if test="$parm_id='P201'">
            <script type="text/javascript">
              mainDates['<xsl:value-of select="$avail_prodcode"/>'] = new Array('',''<xsl:apply-templates select="//main_dates/date[@product_code=$avail_prodcode]" mode="array"/>);
            </script>
        </xsl:if>
      </option>
    </xsl:for-each>
 	</xsl:template>
 	
	
</xsl:stylesheet>
