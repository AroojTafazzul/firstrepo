<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		exclude-result-prefixes="localization securityCheck">

<!--
   Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->

<xsl:import href="../../core/xsl/common/trade_common.xsl"/>
<xsl:import href="../com_attachment.xsl"/>

<xsl:import href="../../core/xsl/products/product_addons.xsl"/>

<xsl:output method="html" indent="no" />

	<!-- Get the language code -->  
	<xsl:param name="language"/>

	<xsl:param name="rundata"/>
	
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>

	<!--TEMPLATE Main-->

	<xsl:template match="po_tnx_record">

	<!--Define the nodeName and screenName variables for the current product -->
	<xsl:variable name="nodeName"><xsl:value-of select="name(.)"/></xsl:variable>
	<xsl:variable name="screenName">PurchaseOrderScreen</xsl:variable>

	<script type="text/javascript" src="/content/OLD/javascript/com_functions.js"></script>
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
   						<xsl:attribute name="onclick">fncPerform('submit','<xsl:value-of select="$nodeName"/>','<xsl:value-of select="$screenName"/>');return false;</xsl:attribute>
   						<img border="0" src="/content/images/pic_form_send.gif"></img><br/>
   						<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SUBMIT')"/>
   					</a>
   				</td>
				<td align="middle" valign="center">
					<a href="javascript:void(0)">
						<xsl:attribute name="onclick">fncShowReporting('SUMMARY','<xsl:value-of select="product_code"/>','<xsl:value-of select="ref_id"/>','<xsl:value-of select="tnx_id"/>');return false;</xsl:attribute>
						<img border="0" src="/content/images/pic_printer.gif"></img><br/>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_PREVIEW')"/>
					</a>
				</td>
				<td align="middle" valign="center">
					<a href="javascript:void(0)">
						<xsl:attribute name="onclick">fncPerform('cancel','<xsl:value-of select="$nodeName"/>','<xsl:value-of select="$screenName"/>');return false;</xsl:attribute>
						<img border="0" src="/content/images/pic_form_cancel.gif"></img><br/>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/>
					</a>
				</td>
				<td align="middle" valign="center">
					<a href="javascript:void(0)">
						<xsl:attribute name="onclick">fncPerform('help','<xsl:value-of select="$nodeName"/>','<xsl:value-of select="$screenName"/>');return false;</xsl:attribute>
						<img border="0" src="/content/images/pic_form_help.gif"></img><br/>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_HELP')"/>
					</a>
				</td>
			</tr>
		</table>
		
	</td>
	</tr>
	<tr>
	<td align="left">
	
		<p><br/></p>
		
		<form name="fakeform1">
		
		<!--Insert the details required to perform the submission-->
		
		<input type="hidden" name="brch_code"><xsl:attribute name="value"><xsl:value-of select="brch_code"/></xsl:attribute></input>
		<input type="hidden" name="company_id"><xsl:attribute name="value"><xsl:value-of select="company_id"/></xsl:attribute></input>
		<input type="hidden" name="company_name"><xsl:attribute name="value"><xsl:value-of select="company_name"/></xsl:attribute></input>
		<input type="hidden" name="ref_id"><xsl:attribute name="value"><xsl:value-of select="ref_id"/></xsl:attribute></input>
		<input type="hidden" name="tnx_id"><xsl:attribute name="value"><xsl:value-of select="tnx_id"/></xsl:attribute></input>
		<input type="hidden" name="issuing_bank_abbv_name">
			<xsl:attribute name="value"><xsl:value-of select="issuing_bank/abbv_name"/></xsl:attribute>
		</input>

		<input type="hidden" name="tnx_amt"><xsl:attribute name="value"><xsl:value-of select="tnx_amt"/></xsl:attribute></input>
		<input type="hidden" name="total_cur_code"><xsl:attribute name="value"><xsl:value-of select="lc_cur_code"/></xsl:attribute></input>
		<input type="hidden" name="total_amt"><xsl:attribute name="value"><xsl:value-of select="lc_amt"/></xsl:attribute></input>

		<input type="hidden" name="sub_tnx_type_code"><xsl:attribute name="value"><xsl:value-of select="sub_tnx_type_code"/></xsl:attribute></input>
		<!-- Previous ctl date, used for synchronisation issues -->
		<input type="hidden" name="old_ctl_dttm"><xsl:attribute name="value"><xsl:value-of select="ctl_dttm"/></xsl:attribute></input>


		</form>

		<form name="realform" method="POST">
			<xsl:attribute name="action">/gtp/screen/<xsl:value-of select="$screenName"/></xsl:attribute>
			
			<input type="hidden" name="operation" value=""/>
			<input type="hidden" name="mode" value="UNSIGNED"/>
			<input type="hidden" name="tnxtype" value="13"/>
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
		
		<!--General Details-->

		<table border="0" width="570" cellpadding="0" cellspacing="0">
			<tr>
				<td class="FORMH1" colspan="3">
					<b><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_GENERAL_DETAILS')"/></b>
				</td>
				<td align="right" class="FORMH1">
					<a name="anchor_view_full_details" href="javascript:void(0)">
						<xsl:attribute name="onclick">fncShowPreview('SUMMARY', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="ref_id"/>', '<xsl:value-of select="cross_references/cross_reference[type_code='01']/tnx_id"/>');return false;</xsl:attribute>
						<img border="0" src="/content/images/preview.png" name="img_view_full_details">
							<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_VIEW_DISCREPANCY_ADVICE')"/></xsl:attribute>
						</img>
					</a>
				</td>
			</tr>
		</table>
		
		<table border="0" width="570" cellpadding="0" cellspacing="0">
			<tr>
				<td width="40">&nbsp;</td>
				<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_REF_ID')"/></td>
				<td>
					<font class="REPORTBLUE"><xsl:value-of select="ref_id"/></font>
				</td>
			</tr>
			<xsl:if test="cust_ref_id[.!='']">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_CUST_REF_ID')"/></td>
					<td><font class="REPORTDATA"><xsl:value-of select="cust_ref_id"/></font></td>
				</tr>
			</xsl:if>
			<xsl:if test="bo_ref_id[.!='']">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_BO_REF_ID')"/></td>
					<td><font class="REPORTDATA"><xsl:value-of select="bo_ref_id"/></font></td>
				</tr>
			</xsl:if>
			<xsl:if test="iss_date[.!='']">
				<tr><td colspan="3">&nbsp;</td></tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_ISSUE_DATE')"/></td>
					<td><font class="REPORTDATA"><xsl:value-of select="iss_date"/></font></td>
				</tr>
			</xsl:if>
			<xsl:if test="exp_date[.!='']">
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_EXPIRY_DATE')"/></td>
					<td><font class="REPORTDATA"><xsl:value-of select="exp_date"/></font></td>
				</tr>
			</xsl:if>
			<tr><td colspan="3">&nbsp;</td></tr>
			<tr>
				<td width="40">&nbsp;</td>
				<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_GENERALDETAILS_DISCREPANCY_RESPONSE')"/></td>
				<td>
					<font class="REPORTBLUE">
						<xsl:choose>
							<xsl:when test="sub_tnx_type_code[.='08']">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_YES')"/>
							</xsl:when>
							<xsl:when test="sub_tnx_type_code[.='09']">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_NO')"/>
							</xsl:when>
						</xsl:choose>
					</font>
				</td>
			</tr>
		</table>
		
		<p><br/></p>

		<xsl:if test="free_format_text[.!='']">

			<!--Narrative Details-->

			<table border="0" width="570" cellpadding="0" cellspacing="0">
				<tbody>
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
				</tbody>
			</table>
			
			<br/>
			
			<table border="0" cellspacing="0" width="570">
				<tr>
					<td width="15">&nbsp;</td>
					<td>
						<font class="REPORTNORMAL">
							<xsl:call-template name="string_replace">
								<xsl:with-param name="input_text" select="free_format_text" />
							</xsl:call-template>
							<br/>
						</font>
					</td>
				</tr>
			</table>
			
			<p><br/></p>
		
		</xsl:if>

		<!--Optional File Upload Details-->

		<xsl:if test="attachments/attachment/file_name[.!='']">
			<xsl:apply-templates select="attachments/attachment" mode="control"/>
		</xsl:if>

		<p><br/></p>

			
	</td>
	</tr>
	<tr>
	<td align="center">
	
		<table border="0" cellspacing="2" cellpadding="8">
			<tr>
				<!-- BEGIN BNPP SPECIFIC : Check lc_submit permission -->
				<xsl:if test="securityCheck:hasPermission($rundata,'lc_submit')">
   				<td align="middle" valign="center">
   					<a href="javascript:void(0)">
   						<xsl:attribute name="onclick">fncPerform('submit','<xsl:value-of select="$nodeName"/>','<xsl:value-of select="$screenName"/>');return false;</xsl:attribute>
   						<img border="0" src="/content/images/pic_form_send.gif"></img><br/>
   						<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SUBMIT')"/>
   					</a>
   				</td>
   			</xsl:if>
				<!-- END BNPP SPECIFIC -->
				<td align="middle" valign="center">
					<a href="javascript:void(0)">
						<xsl:attribute name="onclick">fncShowPreview('SUMMARY','<xsl:value-of select="product_code"/>','<xsl:value-of select="ref_id"/>','<xsl:value-of select="tnx_id"/>');return false;</xsl:attribute>
						<img border="0" src="/content/images/pic_printer.gif"></img><br/>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_PREVIEW')"/>
					</a>
				</td>
				<td align="middle" valign="center">
					<a href="javascript:void(0)">
						<xsl:attribute name="onclick">fncPerform('cancel','<xsl:value-of select="$nodeName"/>','<xsl:value-of select="$screenName"/>');return false;</xsl:attribute>
						<img border="0" src="/content/images/pic_form_cancel.gif"></img><br/>
						<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/>
					</a>
				</td>
				<td align="middle" valign="center">
					<a href="javascript:void(0)">
						<xsl:attribute name="onclick">fncPerform('help','<xsl:value-of select="$nodeName"/>','<xsl:value-of select="$screenName"/>');return false;</xsl:attribute>
						<img border="0" src="/content/images/pic_form_help.gif"></img><br/>
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
