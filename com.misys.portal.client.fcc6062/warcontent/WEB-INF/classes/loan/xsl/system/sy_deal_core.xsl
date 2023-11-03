<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.neomalogic.gtp.common.localization.Localization"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		exclude-result-prefixes="localization">
		
<!--
   Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->

	<xsl:output method="html" indent="yes" />

	<!-- Get the language code -->
	<xsl:param name="language"/>

	<!-- Get the target parameters -->
	<xsl:param name="nextScreen"/>
	<xsl:param name="fields"/>
	<xsl:param name="formname"/>
  	<xsl:param name="productcode"/>
  	<xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
  	<xsl:param name="searchImage"><xsl:value-of select="$images_path"/>search.png</xsl:param>
  	<xsl:param name="formSaveImage"><xsl:value-of select="$images_path"/>pic_form_save.gif</xsl:param>
	<xsl:param name="formCancelImage"><xsl:value-of select="$images_path"/>pic_form_cancel.png</xsl:param>
	<xsl:param name="formHelpImage"><xsl:value-of select="$images_path"/>pic_form_help.png</xsl:param>
  	
  	
  
	<xsl:template match="/">
		<xsl:apply-templates select="static_deal"/>
	</xsl:template>

	<!--TEMPLATE Main-->

	<xsl:template match="static_deal">
    <xsl:param name="productCode">
      <xsl:choose>
        <xsl:when test="not (productcode[.=''])"><xsl:value-of select="$productcode"/></xsl:when>
        <xsl:otherwise>*</xsl:otherwise>
      </xsl:choose>
    </xsl:param>
	
	<!--set deal properties-->
	<xsl:variable name="company_name">
		<xsl:choose>
			<xsl:when test="company_name[.='']">
				<xsl:value-of select="static_company/name"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="company_name"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="address_line_1">
		<xsl:choose>
			<xsl:when test="address_line_1[.='']">
				<xsl:value-of select="static_company/address_line_1"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="address_line_1"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="address_line_2">
		<xsl:choose>
			<xsl:when test="address_line_2[.='']">
				<xsl:value-of select="static_company/address_line_2"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="address_line_2"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="dom">
		<xsl:choose>
			<xsl:when test="dom[.='']">
				<xsl:value-of select="static_company/dom"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="dom"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="country">
		<xsl:choose>
			<xsl:when test="country[.='']">
				<xsl:value-of select="static_company/country"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="country"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>	
	
		<!--Define the nodeName variable for the current static data -->
		<xsl:variable name="nodeName"><xsl:value-of select="name(.)"/></xsl:variable>
		<script language="JavaScript1.2" src="/content/javascript/com_functions.js"></script>
		<script language="JavaScript1.2">
			<xsl:attribute name="src">/content/javascript/com_error_<xsl:value-of select="$language"/>.js</xsl:attribute>
		</script>
		<script language="JavaScript1.2" src="/content/javascript/loaniq/sy_deal.js"></script>
		<script language="JavaScript1.2" src="/content/javascript/com_amount.js"></script>
		<script language="JavaScript1.2" src="/content/javascript/com_function.js"></script>
		<script language="JavaScript1.2" src="/content/javascript/com_currency.js"></script>
		
		<!--add title if popup-->
		<xsl:if test="$formname != ''">
			<b><xsl:value-of select="localization:getGTPString($language, 'OpenAddDealCSF')"/></b>
		</xsl:if>
		
		<p><br/></p>
		
		<table border="0" width="100%">
		<tr>
		<td align="center">
		
		<table border="0">
		<tr>
		<td align="left">

			<form name="fakeform1" onsubmit="return false;">
	
			<input type="hidden" name="brch_code"><xsl:attribute name="value"><xsl:value-of select="brch_code"/></xsl:attribute></input>
			<input type="hidden" name="company_id"><xsl:attribute name="value"><xsl:value-of select="company_id"/></xsl:attribute></input>
			<input type="hidden" name="deal_id"><xsl:attribute name="value"><xsl:value-of select="deal_id"/></xsl:attribute></input>
	
			<table border="0" width="570" cellpadding="0" cellspacing="0">
        
        <xsl:choose>
         <xsl:when test="entities">
            <tr>
              <td width="40">&nbsp;</td>
              <td width="150">
                <font class="FORMMANDATORY">
                  <xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_ENTITY')"/>
                </font>
              </td>
              <td>
                <input name="entity" size="35" onblur="fncRestoreInputStyle('fakeform1','entity');" onfocus="this.blur();">
                  <xsl:attribute name="value"><xsl:value-of select="entity"/></xsl:attribute>
                </input>
                &nbsp;                  
                  <a name="anchor_search_entity" href="javascript:void(0)">
                    <xsl:attribute name="onclick">
                      <!-- PopUp : list of user's entities, otherwise : company's entities -->
                      <xsl:choose>
                        <xsl:when test="$nextScreen='StaticDataListPopup'">
                          misys.showEntityDialog('entity', 'fakeform1',"['entity']",'<xsl:value-of select="$productCode"/>','','','USER');return false;
                        </xsl:when>
                        <xsl:otherwise>
			                          misys.showEntityDialog('entity', 'fakeform1',"['entity']",'<xsl:value-of select="$productCode"/>','','','COMPANY');return false;
                        </xsl:otherwise>
                      </xsl:choose>
                    </xsl:attribute>
                    <img border="0" name="img_search_entity">
                      <xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($searchImage)"/></xsl:attribute>
                      <xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_ENTITY')"/></xsl:attribute>
                    </img>
                  </a>
              </td>
            </tr>
          </xsl:when>
          <xsl:otherwise>
            <input name="entity" type="hidden" value="*"/>
          </xsl:otherwise>
        </xsl:choose>			
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150">
						<font class="FORMMANDATORY">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_DEAL_NAME')"/>
						</font>
					</td>
					<td>
						<input type="text" size="34" maxlength="34" name="name">
							<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','name'); return false;</xsl:attribute>
							<xsl:attribute name="value"><xsl:value-of select="name"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150"><xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_DEAL_DESCRIPTION')"/></td>
					<td>
						<input type="text" size="34" maxlength="34" name="description" onblur="fncRestoreInputStyle('fakeform1','description'); return false;">
							<xsl:attribute name="value"><xsl:value-of select="description"/></xsl:attribute>
						</input>
					</td>
				</tr>
				<tr>
					<td width="40">&nbsp;</td>
					<td width="150">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_DEAL_AMOUNT')"/>
					</td>
					<td>
						<input type="text" size="3" maxlength="3" name="deal_cur_code" onblur="fncRestoreInputStyle('fakeform1','deal_cur_code');fncCheckValidCurrency(this);fncFormatAmount(document.forms['fakeform1'].deal_amt, fncGetCurrencyDecNo(this.value));document.forms['fakeform1'].deal_amt.value=document.forms['fakeform1'].deal_amt.value;">
							<xsl:attribute name="value"><xsl:value-of select="deal_cur_code"/></xsl:attribute>
						</input>&nbsp;
						<input type="text" size="20" maxlength="15" name="deal_amt" onblur="fncRestoreInputStyle('fakeform1','deal_amt');fncFormatAmount(this,fncGetCurrencyDecNo(document.forms['fakeform1'].deal_cur_code.value));document.forms['fakeform1'].deal_amt.value=this.value;">
							<xsl:attribute name="value"><xsl:value-of select="deal_amt"/></xsl:attribute>
						</input>
						<a name="anchor_search_deal_currency" href="javascript:void(0)">
							<xsl:attribute name="onclick">fncSearchPopup('currency', 'fakeform1',"['deal_cur_code']");return false;</xsl:attribute>
							<img border="0" name="img_search_deal_currency">
								<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($searchImage)"/></xsl:attribute>
								<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_CURRENCY')"/></xsl:attribute>
							</img>
						</a>
					</td>
				</tr>
				<tr>
					<td>
						<input type="hidden" name="company_name" value="{$company_name}"/>
					</td>
				</tr>
			</table>
	
			</form>
			
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
							<xsl:attribute name="onCLick">fncPerform('save');return false;</xsl:attribute>
							<img border="0">
							<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($formSaveImage)"/></xsl:attribute>
							</img><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_SAVE')"/>
						</a>
					</td>
					<td align="middle" valign="center">
						<a href="javascript:void(0)">
						<xsl:choose>
   						<xsl:when test="$formname =''">
   							<xsl:attribute name="onclick">fncPerform('cancel','<xsl:value-of select="$nodeName"/>');return false;</xsl:attribute>
   						</xsl:when>
   						<xsl:otherwise>
   							<xsl:attribute name="onclick">fncCancelStaticData('<xsl:value-of select="$formname" />',&quot;<xsl:value-of select="$fields" />&quot;,'<xsl:value-of select="$productcode"/>');return false;</xsl:attribute>
   						</xsl:otherwise>
						</xsl:choose>
							<img border="0">
							 <xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($formCancelImage)"/></xsl:attribute>
							</img><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_CANCEL')"/>
						</a>
					</td>
					<td align="middle" valign="center">
						<a href="javascript:void(0)" onclick="fncPerform('help');return false;">
							<img border="0">
							 <xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($formHelpImage)"/></xsl:attribute>
							</img><br/>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_HELP')"/>
						</a>
					</td>
				</tr>
			</table>

		</center>

		<form name="realform" method="POST">
				<xsl:attribute name="action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$nextScreen"/>
			</xsl:attribute>
			<input type="hidden" name="operation" value="SAVE_FEATURES"/>
			<input type="hidden" name="option">
				<xsl:attribute name="value">DEALS_MAINTENANCE</xsl:attribute>	
			</input>
			<xsl:if test="$formname != ''">
				<input type="hidden" name="formname" value="{$formname}"/>
			</xsl:if>	
			<xsl:if test="$fields != ''">
				<input type="hidden" name="fields" value="{$fields}"/>
			</xsl:if>						
      <xsl:if test="$productCode != '' ">
        <input type="hidden" name="productcode">
          <xsl:attribute name="value">
            <xsl:value-of select="$productCode"/>
          </xsl:attribute>
        </input>
			</xsl:if>
      <input type="hidden" name="TransactionData"/>
		</form>

	</xsl:template>
	
</xsl:stylesheet>
