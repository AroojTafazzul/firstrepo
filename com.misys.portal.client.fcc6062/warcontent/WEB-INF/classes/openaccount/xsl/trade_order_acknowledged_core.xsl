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
   Copyright (c) 2000-2010 Misys (http://www.misys.com),
   All Rights Reserved. 
-->

	<xsl:import href="../../core/xsl/products/product_addons.xsl"/>
	<xsl:import href="../com_attachment.xsl"/>

	<xsl:output method="html" indent="no"/>

	<!-- Get the language code -->
	<xsl:param name="language"/>
	<xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
	<xsl:param name="executeImage"><xsl:value-of select="$images_path"/>execute.png</xsl:param>
	<xsl:param name="editImage"><xsl:value-of select="$images_path"/>edit.png</xsl:param>
	<xsl:param name="deleteImage"><xsl:value-of select="$images_path"/>delete.png</xsl:param>
	<xsl:param name="searchImage"><xsl:value-of select="$images_path"/>search.png</xsl:param>

	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>

	<!--TEMPLATE Main-->

	<xsl:template match="so_tnx_record">

		<!--Define the nodeName and screenName variables for the current product -->

		<xsl:variable name="nodeName"><xsl:value-of select="name(.)"/></xsl:variable>
		<xsl:variable name="screenName">SellOrderScreen</xsl:variable>
		
		<script type="text/javascript" src="/content/OLD/javascript/com_functions.js"/>
		<script type="text/javascript">
			<xsl:attribute name="src">/content/OLD/javascript/com_error_<xsl:value-of select="$language"/>.js</xsl:attribute>
		</script>
		<script type="text/javascript" src="/content/OLD/javascript/trade_message.js"></script>
		
		<!-- Include some eventual additional elements -->
		<xsl:call-template name="client_addons"/>
		
		<table border="0" width="100%" cellspacing="2" cellpadding="4" class="FORMTABLEBORDER">
		<tr>
		<td class="FORMTABLE" align="center">
		
		<table border="0">
		<tr>
		<td align="center">
							
			<table border="0" cellspacing="2" cellpadding="8">
				<tr>
					<td align="middle" valign="center">
						<a href="javascript:void(0)">
							<xsl:attribute name="onclick">fncPerform('save','<xsl:value-of select="$nodeName"/>','<xsl:value-of select="$screenName"/>');return false;</xsl:attribute>
							<img border="0" src="/content/images/pic_form_save.gif"/><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SAVE')"/>
						</a>
					</td>
					<td align="middle" valign="center">
						<a href="javascript:void(0)">
							<xsl:attribute name="onclick">fncPerform('submit','<xsl:value-of select="$nodeName"/>','<xsl:value-of select="$screenName"/>');return false;</xsl:attribute>
							<img border="0" src="/content/images/pic_form_send.gif"/><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SUBMIT')"/>
						</a>
					</td>
					<td align="middle" valign="center">
						<a href="javascript:void(0)">
							<xsl:attribute name="onclick">fncPerform('cancel','<xsl:value-of select="$nodeName"/>','<xsl:value-of select="$screenName"/>');return false;</xsl:attribute>
							<img border="0" src="/content/images/pic_form_cancel.gif"/><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/>
						</a>
					</td>
					<td align="middle" valign="center">
						<a href="javascript:void(0)">
							<xsl:attribute name="onclick">fncPerform('help','<xsl:value-of select="$nodeName"/>','<xsl:value-of select="$screenName"/>');return false;</xsl:attribute>
							<img border="0" src="/content/images/pic_form_help.gif"/><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_HELP')"/>
						</a>
					</td>
				</tr>
			</table>

		</td>
		</tr>
		<tr>
		<td align="left">

			<div style="display:none;">
				<table>
					<tbody>
						<xsl:attribute name="id">files_template</xsl:attribute>
						<xsl:call-template name="FILES_UPLOAD_DETAILS">
							<xsl:with-param name="structure_name">files</xsl:with-param>
							<xsl:with-param name="mode">template</xsl:with-param>
							<xsl:with-param name="formName">sendfiles</xsl:with-param>
							<xsl:with-param name="max_file">1</xsl:with-param>
						</xsl:call-template>
					</tbody>
				</table>
			</div>
			<p><br/></p>
			
			<form name="fakeform1">
			
			<!--Insert the Branch Code and Company ID as hidden fields-->
			
			<input type="hidden" name="brch_code"><xsl:attribute name="value"><xsl:value-of select="brch_code"/></xsl:attribute></input>
			<input type="hidden" name="company_id"><xsl:attribute name="value"><xsl:value-of select="company_id"/></xsl:attribute></input>
			<input type="hidden" name="company_name"><xsl:attribute name="value"><xsl:value-of select="company_name"/></xsl:attribute></input>
			<input type="hidden" name="tnx_id"><xsl:attribute name="value"><xsl:value-of select="tnx_id"/></xsl:attribute></input>
			<input type="hidden" name="issuing_bank_abbv_name"><xsl:attribute name="value"><xsl:value-of select="issuing_bank/abbv_name"/></xsl:attribute></input>
			<input type="hidden" name="tnx_amt"><xsl:attribute name="value"><xsl:value-of select="tnx_amt"/></xsl:attribute></input>
			<input type="hidden" name="total_cur_code"><xsl:attribute name="value"><xsl:value-of select="total_cur_code"/></xsl:attribute></input>
			<input type="hidden" name="total_amt"><xsl:attribute name="value"><xsl:value-of select="total_amt"/></xsl:attribute></input>
			<!-- Previous ctl date, used for synchronisation issues -->
			<input type="hidden" name="old_ctl_dttm"><xsl:attribute name="value"><xsl:value-of select="ctl_dttm"/></xsl:attribute></input>
			<input type="hidden" name="tnx_type_code"><xsl:attribute name="value">13</xsl:attribute></input>
			
			<!--Empty the principal and fee accounts-->
			<input type="hidden" name="principal_act_no" value=""/>
			<input type="hidden" name="fee_act_no" value=""/>
			
			<!--General Details-->
			
			<table border="0" width="570" cellpadding="0" cellspacing="0">
				<tr>
					<td class="FORMH1">
						<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_GENERAL_DETAILS')"/></b>
					</td>
					<td align="right" class="FORMH1">
						<a name="anchor_view_full_details" href="javascript:void(0)">
						<xsl:attribute name="onclick">fncShowReporting('DETAILS', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="ref_id"/>', '<xsl:value-of select="cross_references/cross_reference[type_code='01']/tnx_id"/>');return false;</xsl:attribute>
							<img border="0" src="/content/images/preview.png" name="img_view_full_details">
								<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_VIEW_ORDER_ADVICE')"/></xsl:attribute>
							</img>
						</a>
					</td>
				</tr>
			</table>
			
			<table border="0" width="570" cellpadding="0" cellspacing="0">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REF_ID')"/>
					</td>
					<td>
						<font class="REPORTBLUE"><xsl:value-of select="ref_id"/></font>
						<input type="hidden" name="ref_id">
							<xsl:attribute name="value"><xsl:value-of select="ref_id"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<xsl:if test="cust_ref_id[.!='']">
					<tr>
						<td width="40">&nbsp;</td>
						<td width="150">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CUST_REF_ID')"/>
						</td>
						<td>
							<font class="REPORTDATA"><xsl:value-of select="cust_ref_id"/></font>
							<input type="hidden" name="cust_ref_id">
								<xsl:attribute name="value"><xsl:value-of select="cust_ref_id"/></xsl:attribute>
							</input>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="bo_ref_id[.!='']">
					<tr>
						<td width="40">&nbsp;</td>
						<td width="150">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID')"/>
						</td>
						<td>
							<font class="REPORTDATA"><xsl:value-of select="bo_ref_id"/></font>
							<input type="hidden" name="bo_ref_id">
								<xsl:attribute name="value"><xsl:value-of select="bo_ref_id"/></xsl:attribute>
							</input>
						</td>
					</tr>
				</xsl:if>
				<xsl:if test="iss_date[.!='']">
					<tr><td>&nbsp;</td></tr>
					<tr>
						<td width="40">&nbsp;</td>
						<td width="150">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_ISSUE_DATE')"/>
						</td>
						<td>
							<font class="REPORTDATA"><xsl:value-of select="iss_date"/></font>
							<input type="hidden" name="iss_date">
								<xsl:attribute name="value"><xsl:value-of select="iss_date"/></xsl:attribute>
							</input>
						</td>
					</tr>
				</xsl:if>
				<tr><td colspan="3">&nbsp;</td></tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150">
						<font class="FORMMANDATORY">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_ORDER_RESPONSE')"/>
						</font>
					</td>
					<td>
						<select name="acknowledged">
							<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','acknowledged')</xsl:attribute>
							<xsl:attribute name="onchange">
							if(this.options[this.selectedIndex].value == 'N') 
							{
								document.forms['fakeform1'].elements['sub_tnx_type_code'].value='14';
							} 
							else
							{
								document.forms['fakeform1'].elements['sub_tnx_type_code'].value='13';
							}
							</xsl:attribute>
							<option value ="">
								<xsl:if test="acknowledged[.='']">
									<xsl:attribute name="selected"/>
								</xsl:if>
							</option>
							<option value="Y">
								<xsl:if test="acknowledged[.='Y']">
									<xsl:attribute name="selected"/>
								</xsl:if>
								<xsl:value-of select="localization:getGTPString($language, 'N003_13')"/>
							</option>
							<option value="N">
								<xsl:if test="acknowledged[.='N']">
									<xsl:attribute name="selected"/>
								</xsl:if>
								<xsl:value-of select="localization:getGTPString($language, 'N003_14')"/>
							</option>
						</select>
						<input type="hidden" name="sub_tnx_type_code">
						<xsl:attribute name="value">
						<xsl:choose><xsl:when test="acknowledged[.='Y']">13</xsl:when><xsl:otherwise>14</xsl:otherwise></xsl:choose>
						</xsl:attribute>
						</input>
					</td>
					
				</tr>
			</table>
		
			<p><br/></p>
			
			<!--Free Format Message-->
			<p><br/></p>
			<table border="0" width="570" cellpadding="0" cellspacing="0">
				<tr>
					<td class="FORMH1">
						<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FREE_FORMAT')"/></b>
					</td>
					<td align="right" class="FORMH1">
						<a href="#">
							<img border="0" src="/content/images/pic_up.gif">
								<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_TOP_PAGE')"/></xsl:attribute>
							</img>
						</a>
					</td>
				</tr>
			</table>
	
			<br/>
	
			<table>
				<tr>
					<td width="5">&nbsp;</td>
					<td>
						<textarea wrap="hard" name="free_format_text" cols="65" rows="12">
							<xsl:attribute name="onblur">fncFormatTextarea(this,100,65);fncRestoreInputStyle('fakeform1','free_format_text')</xsl:attribute>
							<xsl:value-of select="free_format_text"/>
						</textarea>
					</td>
					<td valign="top">
						<a href="javascript:void(0)">
							<xsl:attribute name="onclick">fncSearchPopup('phrase','fakeform1',"['free_format_text']",'', '', '<xsl:value-of select="product_code"/>');return false;</xsl:attribute>
							<xsl:attribute name="name">anchor_search_free_format_text</xsl:attribute>
							<img border="0" src="/content/images/open_dialog.png">
								<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_PHRASES')"/></xsl:attribute>
								<xsl:attribute name="name">img_search_free_format_text</xsl:attribute>
							</img>
						</a>
					</td>
				</tr>
			</table>
			
			
		</form>
		
		<p><br/></p>
		<table border="0" width="570" cellpadding="0" cellspacing="0">
			<tr>
				<td width="5">&nbsp;</td>
				<td>
					<form name="realform" accept-charset="UNKNOWN" method="POST">
						<xsl:attribute name="action">/gtp/screen/<xsl:value-of select="$screenName"/></xsl:attribute>
						<input type="hidden" name="operation" value=""/>
						<input type="hidden" name="mode" value="DRAFT"/>
						<input type="hidden" name="tnxtype" value="13"/>
						<input type="hidden" name="attIds" value=""/>
						<input type="hidden" name="TransactionData"/>
						<xsl:call-template name="hidden-field">
						   <xsl:with-param name="name">referenceid</xsl:with-param>
						   <xsl:with-param name="value" select="ref_id"/>
						</xsl:call-template>
						<xsl:call-template name="hidden-field">
						   <xsl:with-param name="name">tnxid</xsl:with-param>
						   <xsl:with-param name="value" select="tnx_id"/>
						</xsl:call-template>
					</form>
				</td>
			</tr>
		</table>

		<p><br/></p>
					
	</td>
	</tr>
	<tr align="left">
	<td>
    <form name="sendfiles" id="sendfiles" enctype="multipart/form-data" method="post" target="hiddeniframe">
			<table border="0" width="570" cellpadding="0" cellspacing="0">
				<tr>
					<td class="FORMH1" colspan="3">
						<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_OPTIONAL_FILE_UPLOAD')"/></b>
					</td>
					<td align="right" class="FORMH1">
						<a href="#">
							<img border="0" src="/content/images/pic_up.gif">
								<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_TOP_PAGE')"/></xsl:attribute>
							</img>
						</a>
					</td>
				</tr>
			</table>
		
			<br/>

			<div>
				<xsl:attribute name="id">files_disclaimer</xsl:attribute>
				<xsl:if test="count(attachments/attachment) != 0">
					<xsl:attribute name="style">display:none</xsl:attribute>
				</xsl:if>
				<b><xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_NO_FILE_ITEM')"/></b>
			</div>

			<table border="0" width="560" cellpadding="0" cellspacing="1" id="files_master_table" >
				<xsl:if test="count(attachments/attachment) = 0">
					<xsl:attribute name="style">position:absolute;visibility:hidden;</xsl:attribute>
				</xsl:if>
				<tbody id="files_table">

					<tr>
						<xsl:attribute name="id">files_table_header_1</xsl:attribute>
						<xsl:if test="count(attachments/attachment) = 0">
							<xsl:attribute name="style">visibility:hidden;</xsl:attribute>
						</xsl:if>
						<th class="FORMH2" align="center" width="45%"><xsl:value-of select="localization:getGTPString($language, 'XSL_FILES_COLUMN_TITLE')"/></th>
						<th class="FORMH2" align="center" width="45%"><xsl:value-of select="localization:getGTPString($language, 'XSL_FILES_COLUMN_FILE')"/></th>
						<th class="FORMH2" width="10%">&nbsp;</th>
					</tr>

					<xsl:for-each select="attachments/attachment">
						<xsl:call-template name="FILES_UPLOAD_DETAILS">
							<xsl:with-param name="structure_name">files</xsl:with-param>
							<xsl:with-param name="mode">existing</xsl:with-param>
							<xsl:with-param name="formName">sendfiles</xsl:with-param>
							<xsl:with-param name="max_file">1</xsl:with-param>
						</xsl:call-template>
					</xsl:for-each>
					
				</tbody>
			</table>
			<br/>
			
			<div>
				<xsl:attribute name="id">attachment_add</xsl:attribute>
				<xsl:if test="count(attachments/attachment) > 0">
					<xsl:attribute name="style">display:none</xsl:attribute>
				</xsl:if>
				<a href="javascript:void(0)">
					<xsl:attribute name="onClick">fncPreloadImages('<xsl:value-of select="utils:getImagePath($searchImage)"/>', '<xsl:value-of select="utils:getImagePath($executeImage)"/>', '<xsl:value-of select="utils:getImagePath($editImage)"/>', '<xsl:value-of select="utils:getImagePath($deleteImage)"/>'); fncLaunchProcess("fncAddElement('sendfiles', 'files', '')");</xsl:attribute>
					<xsl:value-of select="localization:getGTPString($language, 'XSL_FILESDETAILS_ADD_FILE_ITEM')"/>
				</a>
			</div>

			<p><br/></p>
        <div id="messageCallBack"></div>
		<input type="hidden" name="attachmentid"/>
		<input type="hidden" name="identifier"/>
		<input type="hidden" name="returnFunction"/>
		<input type="hidden" name="att_company_id"><xsl:attribute name="value"><xsl:value-of select="company_id"/></xsl:attribute></input>
		<input type="hidden" name="att_ref_id"><xsl:attribute name="value"><xsl:value-of select="ref_id"/></xsl:attribute></input>
		<input type="hidden" name="att_tnx_id"><xsl:attribute name="value"><xsl:value-of select="tnx_id"/></xsl:attribute></input>
		<input type="hidden" name="att_title"/>
		<input type="hidden" name="operation"/>
    </form>
    <iframe name="hiddeniframe" id="hiddeniframe" style="display:none;" src="about:blank"></iframe>
	</td>
	</tr>
	<tr>
		<td align="center">
			<table border="0" cellspacing="2" cellpadding="8">
				<tr>
					<td align="middle" valign="center">
						<a href="javascript:void(0)">
							<xsl:attribute name="onclick">fncPerform('save','<xsl:value-of select="$nodeName"/>','<xsl:value-of select="$screenName"/>');return false;</xsl:attribute>
							<img border="0" src="/content/images/pic_form_save.gif"/><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SAVE')"/>
						</a>
					</td>
					<td align="middle" valign="center">
						<a href="javascript:void(0)">
							<xsl:attribute name="onclick">fncPerform('submit','<xsl:value-of select="$nodeName"/>','<xsl:value-of select="$screenName"/>');return false;</xsl:attribute>
							<img border="0" src="/content/images/pic_form_send.gif"/><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SUBMIT')"/>
						</a>
					</td>
					<td align="middle" valign="center">
						<a href="javascript:void(0)">
							<xsl:attribute name="onclick">fncPerform('cancel','<xsl:value-of select="$nodeName"/>','<xsl:value-of select="$screenName"/>');return false;</xsl:attribute>
							<img border="0" src="/content/images/pic_form_cancel.gif"/><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/>
						</a>
					</td>
					<td align="middle" valign="center">
						<a href="javascript:void(0)">
							<xsl:attribute name="onclick">fncPerform('help','<xsl:value-of select="$nodeName"/>','<xsl:value-of select="$screenName"/>');return false;</xsl:attribute>
							<img border="0" src="/content/images/pic_form_help.gif"/><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_HELP')"/>
						</a>
					</td>
				</tr>
			</table>

		</td>
		</tr>
		</table>
	
		</td>
		</tr>
		</table>
	
	</xsl:template>

</xsl:stylesheet>
