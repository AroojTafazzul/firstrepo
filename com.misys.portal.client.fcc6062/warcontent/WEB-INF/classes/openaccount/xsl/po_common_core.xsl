<?xml version="1.0" encoding="UTF-8" ?>

<!DOCTYPE xsl:stylesheet [
<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	xmlns:xd="http://www.pnp-software.com/XSLTdoc"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	exclude-result-prefixes="localization defaultresource">

	<!--
		Copyright (c) 2000-2006 NEOMAlogic (http://www.neomalogic.com), All
		Rights Reserved. TODO: REFACTOR the dynamic structures templates
		management.
	-->
	<xsl:include href="../../core/xsl/common/localization_popup.xsl"/>

	<xsl:param name="option" />

    <xsl:variable name="fscm_cash_customization_enable">
  		<xsl:value-of select="defaultresource:getResource('FSCM_CASH_CUSTOMIZATION_ENABLE')"/>
  	</xsl:variable>

	<!-- Purchase Order Adjustment Details -->
	<xsl:template match="allowance[allowance_type='02']" mode="controlled">

		<!-- Set the displayed direction -->
		<xsl:variable name="adjustment_direction">
			<xsl:value-of select="direction" />
		</xsl:variable>
		<xsl:variable name="displayedDirection">
			<xsl:if test="direction[. != '']">
				<xsl:value-of
					select="localization:getDecode($language, 'N216', $adjustment_direction)" />
			</xsl:if>
		</xsl:variable>

		<!-- Set the value of the displayed type-->
		<xsl:variable name="displayedType">
			<xsl:choose>
				<xsl:when test="type[. !='']">
					<xsl:value-of select="localization:getDecode($language, 'N210', type)" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="other_type" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<tr>
			<td align="left">
				<font class="REPORTDATA">
					<xsl:value-of select="$displayedType" />
				</font>
			</td>
			<xsl:choose>
				<xsl:when
					test="count(../allowance[amt!='']) != 0 and count(../allowance[rate!='']) = 0">
					<td align="center">
						<font class="REPORTDATA">
							<xsl:value-of select="cur_code" />
						</font>
					</td>
					<td align="right">
						<font class="REPORTDATA">
							<xsl:choose>
								<xsl:when test="direction[.='ADDD']">
									+
								</xsl:when>
								<xsl:when test="direction[.='SUBS']">
									-
								</xsl:when>
								<xsl:otherwise />
							</xsl:choose>
							<xsl:value-of select="amt" />
						</font>
					</td>
				</xsl:when>
				<xsl:when
					test="count(../allowance[rate!='']) != 0 and count(../allowance[amt!='']) = 0">
					<td align="right">
						<font class="REPORTDATA">
							<xsl:choose>
								<xsl:when test="direction[.='ADDD']">
									+
								</xsl:when>
								<xsl:when test="direction[.='SUBS']">
									-
								</xsl:when>
								<xsl:otherwise />
							</xsl:choose>
							<xsl:value-of select="rate" />
							%
						</font>
					</td>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="cur_code[.!=''] or amt[.!='']">
							<td align="center">
								<font class="REPORTDATA">
									<xsl:value-of select="cur_code" />
								</font>
							</td>
							<td align="right">
								<font class="REPORTDATA">
									<xsl:choose>
										<xsl:when test="direction[.='ADDD']">
											+
										</xsl:when>
										<xsl:when test="direction[.='SUBS']">
											-
										</xsl:when>
										<xsl:otherwise />
									</xsl:choose>
									<xsl:value-of select="amt" />
								</font>
							</td>
						</xsl:when>
						<xsl:otherwise>
							<td align="center">&nbsp;
							</td>
							<td align="right">
								<font class="REPORTDATA">
									<xsl:choose>
										<xsl:when test="direction[.='ADDD']">
											+
										</xsl:when>
										<xsl:when test="direction[.='SUBS']">
											-
										</xsl:when>
										<xsl:otherwise />
									</xsl:choose>
									<xsl:value-of select="rate" />
									%
								</font>
							</td>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</tr>
	</xsl:template>


	<!-- Purchase Order tax Details -->
	<xsl:template match="allowance[allowance_type='01']" mode="controlled">

		<!-- Set the value of the displayed type-->
		<xsl:variable name="displayedType">
			<xsl:choose>
				<xsl:when test="type[. !='']">
					<xsl:value-of select="localization:getDecode($language, 'N210', type)" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="other_type" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<tr>
			<td align="left">
				<font class="REPORTDATA">
					<xsl:value-of select="$displayedType" />
				</font>
			</td>
			<xsl:choose>
				<xsl:when
					test="count(../allowance[amt!='']) != 0 and count(../allowance[rate!='']) = 0">
					<td align="center">
						<font class="REPORTDATA">
							<xsl:value-of select="cur_code" />
						</font>
					</td>
					<td align="right">
						<font class="REPORTDATA">
							+
							<xsl:value-of select="amt" />
						</font>
					</td>
				</xsl:when>
				<xsl:when
					test="count(../allowance[rate!='']) != 0 and count(../allowance[amt!='']) = 0">
					<td align="right">
						<font class="REPORTDATA">
							+
							<xsl:value-of select="rate" />
							%
						</font>
					</td>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="cur_code[.!=''] or amt[.!='']">
							<td align="center">
								<font class="REPORTDATA">
									<xsl:value-of select="cur_code" />
								</font>
							</td>
							<td align="right">
								<font class="REPORTDATA">
									+
									<xsl:value-of select="amt" />
								</font>
							</td>
						</xsl:when>
						<xsl:otherwise>
							<td align="center">&nbsp;
							</td>
							<td align="right">
								<font class="REPORTDATA">
									+
									<xsl:value-of select="rate" />
									%
								</font>
							</td>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</tr>
	</xsl:template>

	<!-- Purchase Order freight charges Details: controlled view -->
	<xsl:template match="allowance[allowance_type='03']" mode="controlled">

		<!-- Set the value of the displayed type-->
		<xsl:variable name="displayedType">
			<xsl:choose>
				<xsl:when test="type[. !='']">
					<xsl:value-of select="localization:getDecode($language, 'N210', type)" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="other_type" />
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<tr>
			<td align="left">
				<font class="REPORTDATA">
					<xsl:value-of select="$displayedType" />
				</font>
			</td>
			<xsl:choose>
				<xsl:when
					test="count(../allowance[amt!='']) != 0 and count(../allowance[rate!='']) = 0">
					<td align="center">
						<font class="REPORTDATA">
							<xsl:value-of select="cur_code" />
						</font>
					</td>
					<td align="right">
						<font class="REPORTDATA">
							+
							<xsl:value-of select="amt" />
						</font>
					</td>
				</xsl:when>
				<xsl:when
					test="count(../allowance[rate!='']) != 0 and count(../allowance[amt!='']) = 0">
					<td align="right">
						<font class="REPORTDATA">
							+
							<xsl:value-of select="rate" />
							%
						</font>
					</td>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<xsl:when test="cur_code[.!=''] or amt[.!='']">
							<td align="center">
								<font class="REPORTDATA">
									<xsl:value-of select="cur_code" />
								</font>
							</td>
							<td align="right">
								<font class="REPORTDATA">
									+
									<xsl:value-of select="amt" />
								</font>
							</td>
						</xsl:when>
						<xsl:otherwise>
							<td align="center">&nbsp;
							</td>
							<td align="right">
								<font class="REPORTDATA">
									+
									<xsl:value-of select="rate" />
									%
								</font>
							</td>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</tr>
	</xsl:template>

	<!--**************************************-->
	<!-- PO User Defined Informations Details -->
	<!--**************************************-->
	
	<xsl:template name="user-defined-dialog-declaration">
		<xsl:param name="user_info_type" />
		<xsl:param name="prefix">
			<xsl:choose>
				<xsl:when test="$user_info_type='01'">po_buyer</xsl:when>
				<xsl:when test="$user_info_type='02'">po_seller</xsl:when>
				<xsl:otherwise />
			</xsl:choose>
		</xsl:param>
		<div style="display:none" class="widgetContainer">
			<xsl:attribute name="id"><xsl:value-of select="$prefix" />-user-defined-dialog-template</xsl:attribute>
			<xsl:attribute name="title">Confirmation</xsl:attribute>

					<div>
						<!-- <xsl:call-template name="localization-dialog"/> -->
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DETAILS_PO_USER_INFORMATION_LABEL</xsl:with-param>
							<xsl:with-param name="name"><xsl:value-of select="$prefix" />_label</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="required">N</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							<xsl:with-param name="value">
								<xsl:value-of select="label" />
							</xsl:with-param>
							<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>
						
						<xsl:choose>
							<xsl:when test="$displaymode='edit'">
								<xsl:call-template name="textarea-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_USER_INFORMATION_INFORMATION</xsl:with-param>
									<xsl:with-param name="name"><xsl:value-of select="$prefix" />_information</xsl:with-param>
									<xsl:with-param name="required">N</xsl:with-param>
									<xsl:with-param name="maxlines">4</xsl:with-param>
									<xsl:with-param name="cols">35</xsl:with-param>
									<xsl:with-param name="rows">10</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_USER_INFORMATION_INFORMATION</xsl:with-param>
									<xsl:with-param name="name"><xsl:value-of select="$prefix" />_information</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
						
						
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name"><xsl:value-of select="$prefix" />_user_id</xsl:with-param>
							<xsl:with-param name="value">
								<xsl:value-of select="id" />
							</xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name"><xsl:value-of select="$prefix" />_info_id</xsl:with-param>
							<xsl:with-param name="value">
								<xsl:value-of select="user_info_id" />
							</xsl:with-param>
						</xsl:call-template>
						<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
						<xsl:if test="$productCode='PO'">
						<xsl:call-template name="localization-dialog"/>
						</xsl:if>
						<div class="dijitDialogPaneActionBar">
							<xsl:call-template name="label-wrapper">
								<xsl:with-param name="content">
									<button type="button" dojoType="dijit.form.Button">
										<xsl:attribute name="onmouseup">dijit.byId('<xsl:value-of select="$prefix" />-user-defined-dialog-template').hide();</xsl:attribute>
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
									</button>	
									<xsl:if test="$displaymode = 'edit'">							
									<button dojoType="dijit.form.Button">
										<xsl:attribute name="onClick">dijit.byId('<xsl:value-of select="$prefix" />-user-defined-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
									</button>
									</xsl:if>
								</xsl:with-param>
							</xsl:call-template>
						</div>
						
					</div>

		</div>
	</xsl:template>

	<xsl:template name="user-defined-informations-declaration">
		<xsl:param name="user_info_type" />
		<xsl:param name="prefix">
			<xsl:choose>
				<xsl:when test="$user_info_type='01'">po_buyer</xsl:when>
				<xsl:when test="$user_info_type='02'">po_seller</xsl:when>
				<xsl:otherwise />
			</xsl:choose>
		</xsl:param>
		<!-- Dialog Start -->
		<xsl:call-template name="user-defined-dialog-declaration" >
			<xsl:with-param name="user_info_type">
				<xsl:value-of select="$user_info_type" />
			</xsl:with-param>
		</xsl:call-template>
		<!-- Dialog End -->
		<div style="display:none">
			<xsl:attribute name="id"><xsl:value-of select="$prefix" />-user-defined-template</xsl:attribute>
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:choose>
						<xsl:when test="$user_info_type='01'">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_DETAILS_PO_NO_BUYER_DEFINED_INFORMATION')" />
						</xsl:when>
						<xsl:when test="$user_info_type='02'">
							<xsl:value-of
								select="localization:getGTPString($language, 'XSL_DETAILS_PO_NO_SELLER_DEFINED_INFORMATION')" />
						</xsl:when>
						<xsl:otherwise />
					</xsl:choose>
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
						<xsl:choose>
							<xsl:when test="$user_info_type='01'">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_BUYER_DEFINED_INFORMATION')" />
							</xsl:when>
							<xsl:when test="$user_info_type='02'">
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_SELLER_DEFINED_INFORMATION')" />
							</xsl:when>
							<xsl:otherwise />
						</xsl:choose>
				</button>
			</div>
		</div>
	</xsl:template>



	<xsl:template name="user_defined_informations_buyer">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->

		<div dojoType="misys.openaccount.widget.BUserInformations" dialogId="po_buyer-user-defined-dialog-template">
		<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
		<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_BUYER_DEFINED_INFORMATION')" /></xsl:attribute>
		<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_EDIT_BUYER_DEFINED_INFORMATION')" /></xsl:attribute>
		<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_VIEW_BUYER_DEFINED_INFORMATION')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of
					select="localization:getGTPString($language, 'XSL_HEADER_PO_USER_INFORMATION_LABEL')" />,
				<xsl:value-of
					select="localization:getGTPString($language, 'XSL_HEADER_PO_USER_INFORMATION_INFORMATION')" />
			</xsl:attribute>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>

			<xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="userInformations" select="." />
					<div dojoType="misys.openaccount.widget.BUserInformation">
						<xsl:attribute name="label"><xsl:value-of
							select="$userInformations/label" /></xsl:attribute>
						<xsl:attribute name="information"><xsl:value-of
							select="$userInformations/information" /></xsl:attribute>
						<xsl:attribute name="is_valid"><xsl:value-of
							select="$userInformations/is_valid" /></xsl:attribute>
					</div>
				</xsl:for-each>
			</xsl:if>
		</div>

	</xsl:template>

	<xsl:template name="user_defined_informations_seller">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->

		<div dojoType="misys.openaccount.widget.SUserInformations" dialogId="po_seller-user-defined-dialog-template">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_SELLER_DEFINED_INFORMATION')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_EDIT_SELLER_DEFINED_INFORMATION')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_VIEW_SELLER_DEFINED_INFORMATION')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of
					select="localization:getGTPString($language, 'XSL_HEADER_PO_USER_INFORMATION_LABEL')" />,
				<xsl:value-of
					select="localization:getGTPString($language, 'XSL_HEADER_PO_USER_INFORMATION_INFORMATION')" />
			</xsl:attribute>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>

			<xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="userInformations" select="." />
					<div dojoType="misys.openaccount.widget.SUserInformation">
						<xsl:attribute name="label"><xsl:value-of
							select="$userInformations/label" /></xsl:attribute>
						<xsl:attribute name="information"><xsl:value-of
							select="$userInformations/information" /></xsl:attribute>
						<xsl:attribute name="is_valid"><xsl:value-of
							select="$userInformations/is_valid" /></xsl:attribute>
					</div>
				</xsl:for-each>
			</xsl:if>
		</div>

	</xsl:template>

	<xsl:template name="payment-dialog-declaration">
		<div id="payment-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
			<div class="standardPODialogContent">
						<!-- Payment Code -->
						<xsl:choose>
							<xsl:when test="$displaymode = 'edit'">
								<xsl:call-template name="select-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_PAYMENT_TYPE</xsl:with-param>
									<xsl:with-param name="name">details_code</xsl:with-param>
									<xsl:with-param name="required">Y</xsl:with-param>
									<xsl:with-param name="options">
									 <xsl:call-template name="payment-details-code"/>
									</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="hidden-field">
									<xsl:with-param name="name">details_label</xsl:with-param>
									<xsl:with-param name="value">
										<xsl:choose>
											<xsl:when test="details_code"><xsl:value-of	select="localization:getDecode($language, 'N208', details_code)" /></xsl:when>
											<xsl:otherwise></xsl:otherwise>
										</xsl:choose>
									</xsl:with-param>							
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_PAYMENT_TYPE</xsl:with-param>
									<xsl:with-param name="name">details_label</xsl:with-param>
									<xsl:with-param name="size">35</xsl:with-param>
									<xsl:with-param name="maxsize">35</xsl:with-param>
									<xsl:with-param name="readonly">Y</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
						
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DETAILS_PO_PAYMENT_OTHER_CONDITION</xsl:with-param>
							<xsl:with-param name="name">details_other_paymt_terms</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="readonly">Y</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							<xsl:with-param name="value">
								<xsl:value-of select="other_paymt_terms" />
							</xsl:with-param>
							<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>

						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DETAILS_PO_PAYMENT_NB_DAYS</xsl:with-param>
							<xsl:with-param name="name">details_nb_days</xsl:with-param>
							<xsl:with-param name="size">3</xsl:with-param>
							<xsl:with-param name="maxsize">3</xsl:with-param>
							<xsl:with-param name="type">integer</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							<xsl:with-param name="value">
								<xsl:value-of select="nb_days" />
							</xsl:with-param>
							<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>
						<div id="po_payment_details_amt_section">
							<xsl:choose>
								<xsl:when test="$displaymode='edit'">
									<xsl:call-template name="currency-field">
										<xsl:with-param name="label">XSL_DETAILS_PO_PAYMENT_AMT</xsl:with-param>
										<xsl:with-param name="override-currency-name">details_cur_code</xsl:with-param>
										<xsl:with-param name="override-amt-name">details_amt</xsl:with-param>
										<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="currency-field">
										<xsl:with-param name="label">XSL_DETAILS_PO_PAYMENT_AMT</xsl:with-param>
										<xsl:with-param name="override-currency-name">details_cur_code</xsl:with-param>
										<xsl:with-param name="override-amt-name">details_amt</xsl:with-param>
										<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
										<xsl:with-param name="show-button">N</xsl:with-param>
										<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										<xsl:with-param name="currency-readonly">Y</xsl:with-param>
										<xsl:with-param name="override-currency-displaymode">edit</xsl:with-param>
										<xsl:with-param name="amt-readonly">Y</xsl:with-param>
										<xsl:with-param name="override-amt-displaymode">edit</xsl:with-param>
									</xsl:call-template>
								</xsl:otherwise>
							</xsl:choose>
						</div>
						<div id="po_payment_details_pct_section">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_DETAILS_PO_PAYMENT_PERCENTAGE</xsl:with-param>
								<xsl:with-param name="name">details_pct</xsl:with-param>
								<xsl:with-param name="size">10</xsl:with-param>
								<xsl:with-param name="maxsize">10</xsl:with-param>
								<xsl:with-param name="override-displaymode">edit</xsl:with-param>
								<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								<xsl:with-param name="value">
									<xsl:value-of select="rate" />
								</xsl:with-param>
								<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
							</xsl:call-template>
						</div>
						<div id="po_payment_date" style="display: none">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_DETAILS_PO_PAYMENT_DATE</xsl:with-param>
								<xsl:with-param name="name">details_date</xsl:with-param>
								<xsl:with-param name="type">date</xsl:with-param>
								<xsl:with-param name="fieldsize">small</xsl:with-param>
								<xsl:with-param name="override-displaymode">edit</xsl:with-param>
								<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
							</xsl:call-template>
						</div>
						<div class="dijitDialogPaneActionBar">
						<xsl:call-template name="label-wrapper">
							<xsl:with-param name="content">
								<button type="button" dojoType="dijit.form.Button">
									<xsl:attribute name="onmouseup">dijit.byId('payment-dialog-template').hide();</xsl:attribute>
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
								</button>							
								<xsl:if test="$displaymode = 'edit'">
									<button dojoType="dijit.form.Button">
										<xsl:attribute name="onClick">dijit.byId('payment-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
									</button>
								</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
						</div>
					</div>
			<!--
				<xsl:call-template name="PAYMENT_DETAILS"> <xsl:with-param
				name="structure_name">po_payment</xsl:with-param> <xsl:with-param
				name="mode">template</xsl:with-param> <xsl:with-param
				name="form_name">form_payments</xsl:with-param> </xsl:call-template>
			-->
		</div>
	</xsl:template>

	<xsl:template name="payments-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="payment-dialog-declaration" />
		<!-- Dialog End -->
		<div id="payments-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_DETAILS_PO_NO_PAYMENT')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode" id="add_payment_term_button">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_PAYMENT')" />
				</button>
			</div>
		</div>
	</xsl:template>

	<xsl:template name="payments-new">
		<xsl:param name="items" />
		<xsl:param name="type" /> <!-- void | utilize  -->
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
		
		<xsl:variable name="payment_class">
			<xsl:choose>
				<xsl:when test="$type='utilize'">misys.openaccount.widget.UtilizePayments</xsl:when>
				<xsl:otherwise>misys.openaccount.widget.Payments</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="headers_add_on">
			<xsl:choose>
				<xsl:when test="$type='utilize'">,<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_PAYMENT_DATE')" /></xsl:when>
				<xsl:otherwise></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<div dialogId="payment-dialog-template">
			<xsl:attribute name="dojoType"><xsl:value-of select="$payment_class"/></xsl:attribute>
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_PAYMENT')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_EDIT_PAYMENT')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_VIEW_PAYMENT')" /></xsl:attribute>
			<xsl:attribute name="headers">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_PAYMENT_CONDITION')" />,
					<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_PAYMENT_CUR_CODE')" />,
					<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_PAYMENT_AMOUNT_OR_PCT')" />
					<xsl:value-of select="with_date_headers_add_on"></xsl:value-of>
				</xsl:attribute>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>

			<xsl:for-each select="$items">
				<xsl:variable name="payment" select="." />
				<div dojoType="misys.openaccount.widget.Payment">
					<xsl:attribute name="ref_id"><xsl:value-of
						select="$payment/ref_id" /></xsl:attribute>
					<xsl:attribute name="tnx_id"><xsl:value-of
						select="$payment/tnx_id" /></xsl:attribute>
					<xsl:attribute name="payment_id"><xsl:value-of
						select="$payment/payment_id" /></xsl:attribute>
					<xsl:attribute name="payment_date"><xsl:value-of
						select="$payment/payment_date" /></xsl:attribute>
					<xsl:attribute name="code"><xsl:value-of
						select="$payment/code" /></xsl:attribute>
					<xsl:attribute name="label"><xsl:value-of
						select="localization:getDecode($language, 'N208', $payment/code)" /></xsl:attribute>
					<xsl:attribute name="other_paymt_terms"><xsl:value-of
						select="$payment/other_paymt_terms" /></xsl:attribute>
					<xsl:attribute name="nb_days"><xsl:value-of
						select="$payment/nb_days" /></xsl:attribute>
					<xsl:attribute name="cur_code"><xsl:value-of
						select="$payment/cur_code" /></xsl:attribute>
					<xsl:attribute name="amt"><xsl:value-of
						select="$payment/amt" /></xsl:attribute>
					<xsl:attribute name="pct"><xsl:value-of
						select="$payment/pct" /></xsl:attribute>
					<xsl:attribute name="is_valid"><xsl:value-of
						select="$payment/is_valid" /></xsl:attribute>
				</div>
			</xsl:for-each>
		</div>

	</xsl:template>

	<!-- **************** -->
	<!-- Contact Details  -->
	<!-- **************** -->
	<xd:doc>
		<xd:short>Contact Details Declaration</xd:short>
		<xd:detail>This templates displayes message if no contact person are there,or adds button in contact person info is there</xd:detail>
	</xd:doc>
	<xsl:template name="contact-details-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="contact-details-dialog-declaration" />
		<!-- Dialog End -->
		<div id="contact-details-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_DETAILS_PO_NO_CONTACT_PERSON')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_CONTACT_PERSON')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Contact Details Dialog Declaration</xd:short>
		<xd:detail>This templates calls different template for different field(contact name,Contact type,Phone number etc) and sets its parameters,It
					also gives the value for contact type dropdown.It also adds cancel and OK button in the dialog box</xd:detail>
	</xd:doc>
	<xsl:template name="contact-details-dialog-declaration">
		<div id="contact-details-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>
			<div class="standardPODialogContent">
					<div>
						<xsl:choose>
						<xsl:when test="$displaymode='edit'">
							<xsl:call-template name="hidden-field">
								<xsl:with-param name="override-displaymode">edit</xsl:with-param>
								<xsl:with-param name="name">contact_type_decode</xsl:with-param>							
								<xsl:with-param name="value">
								<xsl:choose>
									<xsl:when test="contact_type"><xsl:value-of select="localization:getDecode($language, 'N200', contact_type)" /></xsl:when>
									<xsl:otherwise></xsl:otherwise>
								</xsl:choose>
								</xsl:with-param>							
							</xsl:call-template>
							<xsl:call-template name="select-field">
								<xsl:with-param name="label">XSL_DETAILS_PO_CONTACT_TYPE</xsl:with-param>
								<xsl:with-param name="name">contact_type</xsl:with-param>
								<xsl:with-param name="required">Y</xsl:with-param>
								<xsl:with-param name="override-displaymode">edit</xsl:with-param>
								<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								<xsl:with-param name="options">
									<option value="01">
										<xsl:value-of
											select="localization:getDecode($language, 'N200', '01')" />
									</option>
									<option value="02">
										<xsl:value-of
											select="localization:getDecode($language, 'N200', '02')" />
									</option>
									<option value="03">
										<xsl:value-of
											select="localization:getDecode($language, 'N200', '03')" />
									</option>
									<option value="04">
										<xsl:value-of
											select="localization:getDecode($language, 'N200', '04')" />
									</option>
									<xsl:choose>
									<xsl:when test="product_code[.='IO' or .='EA']">
									<option value="08">
										<xsl:value-of
											select="localization:getDecode($language, 'N200', '08')" />
									</option>
									</xsl:when>
									<xsl:otherwise>
										<option value="05">
										<xsl:value-of
											select="localization:getDecode($language, 'N200', '05')" />
									</option>
									<option value="06">
										<xsl:value-of
											select="localization:getDecode($language, 'N200', '06')" />
									</option>
									<option value="07">
										<xsl:value-of
											select="localization:getDecode($language, 'N200', '07')" />
									</option>
									</xsl:otherwise>
									</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>		
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_DETAILS_PO_CONTACT_TYPE</xsl:with-param>
								<xsl:with-param name="override-displaymode">edit</xsl:with-param>
								<xsl:with-param name="name">contact_type_decode</xsl:with-param>							
								<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>						
							</xsl:call-template>				
						</xsl:otherwise>
						</xsl:choose>
						
						<xsl:if test= "product_code[.='IO' or .='EA']">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DETAILS_PO_CONTACT_BIC</xsl:with-param>
							<xsl:with-param name="name">contact_bic</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="required">N</xsl:with-param>
							<xsl:with-param name="size">11</xsl:with-param>
							<xsl:with-param name="maxsize">11</xsl:with-param>
							<xsl:with-param name="fieldsize">small</xsl:with-param>
							<xsl:with-param name="value">
								<xsl:value-of select="bic" />
							</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
						
						<xsl:choose>
						<xsl:when test="$displaymode='edit'">
							<xsl:call-template name="hidden-field">
								<xsl:with-param name="override-displaymode">edit</xsl:with-param>
								<xsl:with-param name="name">contact_name_prefix_desc</xsl:with-param>							
								<xsl:with-param name="value">
								<xsl:choose>
									<xsl:when test="name_prefix"><xsl:value-of select="localization:getDecode($language, 'N204', name_prefix)" /></xsl:when>
									<xsl:otherwise></xsl:otherwise>
								</xsl:choose>
								</xsl:with-param>							
							</xsl:call-template>
							<xsl:call-template name="select-field">
								<xsl:with-param name="label">XSL_DETAILS_PO_CONTACT_NAME_PREFIX</xsl:with-param>
								<xsl:with-param name="name">contact_name_prefix</xsl:with-param>
								<xsl:with-param name="override-displaymode">edit</xsl:with-param>
								<xsl:with-param name="fieldsize">small</xsl:with-param>
								<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								<xsl:with-param name="options">
									<option value="">&nbsp;</option>
									<option value="DOCT">
										<xsl:value-of
											select="localization:getDecode($language, 'N204', 'DOCT')" />
									</option>
									<option value="MIST">
										<xsl:value-of
											select="localization:getDecode($language, 'N204', 'MIST')" />
									</option>
									<option value="MISS">
										<xsl:value-of
											select="localization:getDecode($language, 'N204', 'MISS')" />
									</option>
									<option value="MADM">
										<xsl:value-of
											select="localization:getDecode($language, 'N204', 'MADM')" />
									</option>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>				
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_DETAILS_PO_CONTACT_NAME_PREFIX</xsl:with-param>
								<xsl:with-param name="override-displaymode">edit</xsl:with-param>
								<xsl:with-param name="name">contact_name_prefix</xsl:with-param>	
								<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>							
							</xsl:call-template>
						</xsl:otherwise>
						</xsl:choose>

						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DETAILS_PO_CONTACT_NAME</xsl:with-param>
							<xsl:with-param name="name">contact_name</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="value">
								<xsl:value-of select="name" />
							</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>

						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DETAILS_PO_CONTACT_GIVEN_NAME</xsl:with-param>
							<xsl:with-param name="name">contact_given_name</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="required">N</xsl:with-param>
							<xsl:with-param name="value">
								<xsl:value-of select="given_name" />
							</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>

						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DETAILS_PO_CONTACT_ROLE</xsl:with-param>
							<xsl:with-param name="name">contact_role</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="value">
								<xsl:value-of select="role" />
							</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DETAILS_PO_CONTACT_PHONE_NUMBER</xsl:with-param>
							<xsl:with-param name="name">contact_phone_number</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="regular-expression">\+[0-9]{1,3}-[0-9()+\-]{1,30}</xsl:with-param>
							<xsl:with-param name="value">
								<xsl:value-of select="phone_number" />
							</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DETAILS_PO_CONTACT_FAX_NUMBER</xsl:with-param>
							<xsl:with-param name="name">contact_fax_number</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="regular-expression">\+[0-9]{1,3}-[0-9()+\-]{1,30}</xsl:with-param>
							<xsl:with-param name="value">
								<xsl:value-of select="fax_number" />
							</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DETAILS_PO_CONTACT_EMAIL</xsl:with-param>
							<xsl:with-param name="name">contact_email</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="maxsize">256</xsl:with-param>
							<xsl:with-param name="value">
								<xsl:value-of select="email" />
							</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
						</xsl:call-template>

						<div class="dijitDialogPaneActionBar">
						<xsl:call-template name="label-wrapper">
							<xsl:with-param name="content">
								<button type="button" dojoType="dijit.form.Button">
									<xsl:attribute name="onmouseup">dijit.byId('contact-details-dialog-template').hide();</xsl:attribute>
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
								</button>
								<xsl:if test="$displaymode = 'edit'">							
								<button dojoType="dijit.form.Button">
									<xsl:attribute name="onClick">dijit.byId('contact-details-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
								</button>
								</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
						</div>
					</div>
				</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Build Contact detail</xd:short>
		<xd:detail>
			This templates displays header for diplaying dataset in add,edit and view mode,also displayes contact person and type header in table adds different
			attributes and fills it with given selected value.
 		</xd:detail>
 		<xd:param name="items"> Items to be build to form display</xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">display mode can be overriden in edit form.</xd:param>		
 	</xd:doc>
	<xsl:template name="build-contact-details-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->

		<div dojoType="misys.openaccount.widget.ContactDetails" dialogId="contact-details-dialog-template" id="contact-details">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_CONTACT_PERSON')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_EDIT_CONTACT_PERSON')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_VIEW_CONTACT_PERSON')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of
						select="localization:getGTPString($language, 'XSL_HEADER_PO_CONTACT_PERSON_TYPE')" />,
				<xsl:value-of
						select="localization:getGTPString($language, 'XSL_HEADER_PO_CONTACT_PERSON_NAME')" />
			</xsl:attribute>
			<xsl:attribute name="contact_bic"><xsl:value-of select="BIC"/></xsl:attribute>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
			
			<xsl:if test="$items">
			<xsl:for-each select="$items">
				<xsl:variable name="contact" select="." />
				<div dojoType="misys.openaccount.widget.ContactDetail">
					<xsl:attribute name="ctcprsn_id"><xsl:value-of
						select="$contact/ctcprsn_id" /></xsl:attribute>
					<xsl:attribute name="type"><xsl:value-of
						select="$contact/type" /></xsl:attribute>
					<xsl:attribute name="type_decode"><xsl:value-of
						select="localization:getDecode($language, 'N200', $contact/type)" /></xsl:attribute>
					<xsl:attribute name="name_prefix"><xsl:value-of
						select="$contact/name_prefix" /></xsl:attribute>
					<xsl:attribute name="name_value"><xsl:value-of
						select="$contact/name" /></xsl:attribute>
					<xsl:attribute name="given_name"><xsl:value-of
						select="$contact/given_name" /></xsl:attribute>
					<xsl:attribute name="role"><xsl:value-of
						select="$contact/role" /></xsl:attribute>
					<xsl:attribute name="phone_number"><xsl:value-of
						select="$contact/phone_number" /></xsl:attribute>
					<xsl:attribute name="fax_number"><xsl:value-of
						select="$contact/fax_number" /></xsl:attribute>
					<xsl:attribute name="email"><xsl:value-of
						select="$contact/email" /></xsl:attribute>
					<xsl:attribute name="is_valid"><xsl:value-of
						select="$contact/is_valid" /></xsl:attribute>
				</div>
			</xsl:for-each>
			</xsl:if>
		</div>
	</xsl:template>
	
	<!-- **************** -->
	<!-- Contact Details  -->
	<!-- **************** -->
	<xd:doc>
		<xd:short>Account type Identification Codes</xd:short>
		<xd:detail>
			This templates adds value attributes and fills it with given selected value.
 		</xd:detail>
 	</xd:doc>
	<xsl:template name="account_type_identification_codes">
		<xsl:for-each select="account_identification_types/account_identification_type_details">
	        <option>
	           <xsl:attribute name="value">
	            <xsl:value-of select="account_identification_type_code"></xsl:value-of>
	            </xsl:attribute>
	            <xsl:value-of select="account_identification_type_description"/>
	        </option>
      	</xsl:for-each>
	</xsl:template>
	

	<!-- ********** -->
	<!-- Line Items -->
	<!-- ********** -->
	<!-- Template for the declaration of line items -->
	 <xd:doc>
		<xd:short>Displayes the line item dialog field</xd:short>
		<xd:detail>
 		Line item form is displayed containing Product which include product identifiers and amount etc.Calls different template for displaying different section such as 'build-product-identifiers-dojo-items' ,'quantity-unit-measure-codes' etc
		</xd:detail>
	</xd:doc> 
	<xsl:template name="line-item-dialog-declaration">
		<div id="line-item-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>

				<div id="line-item-dialog-template-content">
					<div>
						<xsl:if test="$displaymode = 'edit'">
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="name">line_item_qty_unit_measr_label</xsl:with-param>							
							<xsl:with-param name="value">
							<xsl:choose>
								<xsl:when test="qty_unit_measr_code">
									<xsl:if test="qty_unit_measr_code != ''">
										<xsl:value-of select="localization:getDecode($language, 'N202', qty_unit_measr_code)" />
									</xsl:if>
								</xsl:when>
								<xsl:otherwise></xsl:otherwise>
							</xsl:choose>
							</xsl:with-param>							
						</xsl:call-template>
						</xsl:if>
						<!-- Line Item number -->
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_NUMBER</xsl:with-param>
							<xsl:with-param name="name">line_item_nb</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="swift-validate">N</xsl:with-param>
							<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
							<xsl:with-param name="size">64</xsl:with-param>
							<xsl:with-param name="maxsize">64</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>
						<!-- Line Item PO Reference -->
						<xsl:if test="$section_line_item_po_reference!='N'">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_GENERALDETAILS_PO_REF_ID</xsl:with-param>
							<xsl:with-param name="name">line_item_po_reference</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="swift-validate">N</xsl:with-param>
							<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>
						</xsl:if>
						<!-- Products section -->
						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_HEADER_LINE_ITEMS_PRODUCT</xsl:with-param>
							<xsl:with-param name="parse-widgets">N</xsl:with-param>
							<xsl:with-param name="toc-item">N</xsl:with-param>
							<xsl:with-param name="content">
								<!-- Product name -->
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_PRODUCT_NAME</xsl:with-param>
									<xsl:with-param name="name">line_item_product_name</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="swift-validate">N</xsl:with-param>
									<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
									<xsl:with-param name="size">70</xsl:with-param>
									<xsl:with-param name="maxsize">70</xsl:with-param>
									<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
								</xsl:call-template>
								<!-- Product origin -->
								<xsl:call-template name="country-field">
								    <xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_PRODUCT_ORIGIN</xsl:with-param>
								    <xsl:with-param name="name">line_item_product_orgn</xsl:with-param>
								    <xsl:with-param name="override-displaymode">edit</xsl:with-param>
								    <xsl:with-param name="prefix">line_item_product_orgn</xsl:with-param>
								    <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							    </xsl:call-template>
								<!-- Product identifiers -->
								<xsl:call-template name="fieldset-wrapper">
									<xsl:with-param name="legend">XSL_HEADER_LINE_ITEMS_PRODUCT_IDENTIFIERS</xsl:with-param>
									<xsl:with-param name="legend-type">indented-header</xsl:with-param>
									<xsl:with-param name="toc-item">N</xsl:with-param>
									<xsl:with-param name="content">
										&nbsp;
										<xsl:call-template name="build-product-identifiers-dojo-items">
											<xsl:with-param name="id">line_item_product_identifiers</xsl:with-param>
										</xsl:call-template>
									</xsl:with-param>
								</xsl:call-template>
								<!-- Product characteristics -->
								<xsl:call-template name="fieldset-wrapper">
									<xsl:with-param name="legend">XSL_HEADER_LINE_ITEMS_PRODUCT_CHARACTERISTICS</xsl:with-param>
									<xsl:with-param name="legend-type">indented-header</xsl:with-param>
									<xsl:with-param name="toc-item">N</xsl:with-param>
									<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
									<xsl:with-param name="content">
										&nbsp;
										<xsl:call-template name="build-product-characteristics-dojo-items">
											<xsl:with-param name="id">line_item_product_characteristics</xsl:with-param>
											<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
										</xsl:call-template>
									</xsl:with-param>
								</xsl:call-template>
								<!-- Product categories -->
								<xsl:call-template name="fieldset-wrapper">
									<xsl:with-param name="legend">XSL_HEADER_LINE_ITEMS_PRODUCT_CATEGORIES</xsl:with-param>
									<xsl:with-param name="legend-type">indented-header</xsl:with-param>
									<xsl:with-param name="toc-item">N</xsl:with-param>
									<xsl:with-param name="content">
										&nbsp;
										<xsl:call-template name="build-product-categories-dojo-items">
											<xsl:with-param name="id">line_item_product_categories</xsl:with-param>
										</xsl:call-template>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>

						<!-- Amount section -->
						<xsl:call-template name="fieldset-wrapper">
							<xsl:with-param name="legend">XSL_HEADER_AMOUNT_DETAILS</xsl:with-param>
							<xsl:with-param name="toc-item">N</xsl:with-param>
							<xsl:with-param name="content">
								<!-- Quantity section -->
								<xsl:call-template name="fieldset-wrapper">
									<xsl:with-param name="legend">XSL_HEADER_LINE_ITEMS_QUANTITY</xsl:with-param>
									<xsl:with-param name="legend-type">indented-header</xsl:with-param>
									<xsl:with-param name="toc-item">N</xsl:with-param>
									<xsl:with-param name="content">
										<!-- Quantity unit measure code -->
										<xsl:choose>
											<xsl:when test="$displaymode = 'edit'">
												<xsl:call-template name="select-field">
													<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_QUANTITY_CODE</xsl:with-param>
													<xsl:with-param name="name">line_item_qty_unit_measr_code</xsl:with-param>
													<xsl:with-param name="override-displaymode">edit</xsl:with-param>
													<xsl:with-param name="required">Y</xsl:with-param>
													<xsl:with-param name="options">
														<xsl:call-template name="quantity-unit-measure-codes">
															<xsl:with-param name="field-name">line_item_qty_unit_measr_code</xsl:with-param>
														</xsl:call-template>
													</xsl:with-param>
												</xsl:call-template>
											</xsl:when>
											<xsl:otherwise>
												<xsl:call-template name="input-field">
													<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_QUANTITY_CODE</xsl:with-param>
													<xsl:with-param name="name">line_item_qty_unit_measr_label</xsl:with-param>
													<xsl:with-param name="override-displaymode">edit</xsl:with-param>
													<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
												</xsl:call-template>
											</xsl:otherwise>
										</xsl:choose>
										
										<!-- Quantity unit measure: Other -->
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_QUANTITY_OTHER</xsl:with-param>
											<xsl:with-param name="name">line_item_qty_unit_measr_other</xsl:with-param>
											<xsl:with-param name="size">35</xsl:with-param>
											<xsl:with-param name="maxsize">35</xsl:with-param>
											<xsl:with-param name="override-displaymode">edit</xsl:with-param>
											<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
											<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
										</xsl:call-template>
										
										<!-- Quantity value -->
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_QUANTITY_VALUE</xsl:with-param>
											<xsl:with-param name="name">line_item_qty_val</xsl:with-param>
											<xsl:with-param name="override-displaymode">edit</xsl:with-param>
											<xsl:with-param name="swift-validate">N</xsl:with-param>
											<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
											<xsl:with-param name="regular-expression">^(?:\d{1,18}|(?=.*\.)(?!.*\..*\.)[\d.]{1,19})$</xsl:with-param>
											<xsl:with-param name="fieldsize">small</xsl:with-param>
											<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										</xsl:call-template>
										<!-- Quantity factor -->
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_QUANTITY_FACTOR</xsl:with-param>
											<xsl:with-param name="name">line_item_qty_factor</xsl:with-param>
											<xsl:with-param name="override-displaymode">edit</xsl:with-param>
											<xsl:with-param name="swift-validate">N</xsl:with-param>
											<xsl:with-param name="size">15</xsl:with-param>
											<xsl:with-param name="maxsize">15</xsl:with-param>
											<xsl:with-param name="regular-expression">^([1-9]\d*|0){1,15}</xsl:with-param>
											<xsl:with-param name="fieldsize">small</xsl:with-param>
											<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										</xsl:call-template>
										<!-- Tolerance + -->
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_PRICE_TOLERANCE_POS</xsl:with-param>
											<xsl:with-param name="name">line_item_qty_tol_pstv_pct</xsl:with-param>
											<xsl:with-param name="override-displaymode">edit</xsl:with-param>
											<xsl:with-param name="swift-validate">N</xsl:with-param>
											<xsl:with-param name="content-after">&#037;</xsl:with-param>
											<xsl:with-param name="regular-expression">^(?:\d{1,11}|(?=.*\.)(?!.*\..*\.)[\d.]{1,12})$</xsl:with-param>
											<xsl:with-param name="fieldsize">small</xsl:with-param>
											<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										</xsl:call-template>
										<!-- Tolerance - -->
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_PRICE_TOLERANCE_NEG</xsl:with-param>
											<xsl:with-param name="name">line_item_qty_tol_neg_pct</xsl:with-param>
											<xsl:with-param name="swift-validate">N</xsl:with-param>
											<xsl:with-param name="override-displaymode">edit</xsl:with-param>
											<xsl:with-param name="content-after">&#037;</xsl:with-param>
											<xsl:with-param name="regular-expression">^(?:\d{1,11}|(?=.*\.)(?!.*\..*\.)[\d.]{1,12})$</xsl:with-param>
											<xsl:with-param name="fieldsize">small</xsl:with-param>
											<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										</xsl:call-template>
									</xsl:with-param>
								</xsl:call-template>

								<!-- Price section -->
								<xsl:call-template name="fieldset-wrapper">
									<xsl:with-param name="legend">XSL_HEADER_LINE_ITEMS_PRICE</xsl:with-param>
									<xsl:with-param name="legend-type">indented-header</xsl:with-param>
									<xsl:with-param name="toc-item">N</xsl:with-param>
									<xsl:with-param name="content">
										<!-- Price unit measure code -->
										<xsl:choose>
											<xsl:when test="$displaymode = 'edit'">
												<xsl:call-template name="select-field">
													<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_PRICE_CODE</xsl:with-param>
													<xsl:with-param name="override-displaymode">edit</xsl:with-param>
													<xsl:with-param name="name">line_item_price_unit_measr_code</xsl:with-param>
													<xsl:with-param name="readonly">Y</xsl:with-param>
													<xsl:with-param name="options">
														<xsl:call-template name="quantity-unit-measure-codes" >
															<xsl:with-param name="field-name">line_item_price_unit_measr_code</xsl:with-param>
														</xsl:call-template>
													</xsl:with-param>
												</xsl:call-template>
											</xsl:when>
											<xsl:otherwise>
												<xsl:call-template name="input-field">
													<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_PRICE_CODE</xsl:with-param>
													<xsl:with-param name="name">line_item_price_unit_measr_label</xsl:with-param>
													<xsl:with-param name="override-displaymode">edit</xsl:with-param>
													<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
												</xsl:call-template>
											</xsl:otherwise>
										</xsl:choose>
										
										<!-- Price -->
										<xsl:choose>
											<xsl:when test="$displaymode = 'edit'">
												<xsl:call-template name="currency-field">
													<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_PRICE_VALUE</xsl:with-param>
													<xsl:with-param name="override-currency-displaymode">edit</xsl:with-param>
													<xsl:with-param name="override-amt-displaymode">edit</xsl:with-param>
													<xsl:with-param name="override-currency-name">line_item_price_cur_code</xsl:with-param>
													<xsl:with-param name="currency-readonly">Y</xsl:with-param>
													<xsl:with-param name="override-amt-name">line_item_price_amt</xsl:with-param>
													<xsl:with-param name="show-button">N</xsl:with-param>
													<xsl:with-param name="required">Y</xsl:with-param>
													<xsl:with-param name="regular-expression">^(?:\d{1,18}|(?=.*\.)(?!.*\..*\.)[\d.]{1,19})$</xsl:with-param>
												</xsl:call-template>
											</xsl:when>
											<xsl:otherwise>
												<xsl:call-template name="currency-field">
													<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_PRICE_VALUE</xsl:with-param>
													<xsl:with-param name="override-currency-name">price_cur_code</xsl:with-param>
													<xsl:with-param name="currency-readonly">Y</xsl:with-param>
													<xsl:with-param name="override-amt-name">line_item_price_amt</xsl:with-param>
													<xsl:with-param name="show-button">N</xsl:with-param>
													<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
													<xsl:with-param name="amt-readonly">Y</xsl:with-param>
													<xsl:with-param name="override-amt-displaymode">edit</xsl:with-param>
												</xsl:call-template>
											</xsl:otherwise>
										</xsl:choose>
										
										<!-- Price factor -->
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_PRICE_FACTOR</xsl:with-param>
											<xsl:with-param name="name">line_item_price_factor</xsl:with-param>
											<xsl:with-param name="override-displaymode">edit</xsl:with-param>
											<xsl:with-param name="swift-validate">N</xsl:with-param>
											<xsl:with-param name="size">15</xsl:with-param>
											<xsl:with-param name="maxsize">15</xsl:with-param>
											<xsl:with-param name="regular-expression">^([1-9]\d*|0){1,15}</xsl:with-param>
											<xsl:with-param name="fieldsize">small</xsl:with-param>
											<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										</xsl:call-template>
										<!-- Tolerance + -->
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_PRICE_TOLERANCE_POS</xsl:with-param>
											<xsl:with-param name="name">line_item_price_tol_pstv_pct</xsl:with-param>
											<xsl:with-param name="override-displaymode">edit</xsl:with-param>
											<xsl:with-param name="swift-validate">N</xsl:with-param>
											<xsl:with-param name="content-after">&#037;</xsl:with-param>
											<xsl:with-param name="regular-expression">^(?:\d{1,11}|(?=.*\.)(?!.*\..*\.)[\d.]{1,12})$</xsl:with-param>
											<xsl:with-param name="fieldsize">small</xsl:with-param>
											<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										</xsl:call-template>
										<!-- Tolerance - -->
										<xsl:call-template name="input-field">
											<xsl:with-param name="label">XSL_DETAILS_LINE_ITEMS_PRICE_TOLERANCE_NEG</xsl:with-param>
											<xsl:with-param name="name">line_item_price_tol_neg_pct</xsl:with-param>
											<xsl:with-param name="swift-validate">N</xsl:with-param>
											<xsl:with-param name="override-displaymode">edit</xsl:with-param>
											<xsl:with-param name="regular-expression">^(?:\d{1,11}|(?=.*\.)(?!.*\..*\.)[\d.]{1,12})$</xsl:with-param>
											<xsl:with-param name="content-after">&#037;</xsl:with-param>
											<xsl:with-param name="fieldsize">small</xsl:with-param>
											<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										</xsl:call-template>
										<!-- Line Item Amount -->
										<xsl:choose>
											<xsl:when test="$displaymode = 'edit'">
												<xsl:call-template name="currency-field">
													<xsl:with-param name="label">XSL_DETAILS_PO_LINE_ITEM_AMT</xsl:with-param>
													<xsl:with-param name="override-currency-name">line_item_total_cur_code</xsl:with-param>
													<xsl:with-param name="override-currency-displaymode">edit</xsl:with-param>
													<xsl:with-param name="currency-readonly">Y</xsl:with-param>
													<xsl:with-param name="override-amt-name">line_item_total_amt</xsl:with-param>
													<xsl:with-param name="override-amt-displaymode">edit</xsl:with-param>
													<xsl:with-param name="required">Y</xsl:with-param>
													<xsl:with-param name="show-button">N</xsl:with-param>
													<xsl:with-param name="amt-readonly">Y</xsl:with-param>
												</xsl:call-template>
											</xsl:when>
											<xsl:otherwise>
												<xsl:call-template name="currency-field">
													<xsl:with-param name="label">XSL_DETAILS_PO_LINE_ITEM_AMT</xsl:with-param>
													<xsl:with-param name="override-currency-name">total_cur_code</xsl:with-param>
													<xsl:with-param name="currency-readonly">Y</xsl:with-param>
													<xsl:with-param name="override-amt-name">line_item_total_amt</xsl:with-param>
													<xsl:with-param name="show-button">N</xsl:with-param>
													<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
													<xsl:with-param name="amt-readonly">Y</xsl:with-param>
													<xsl:with-param name="override-amt-displaymode">edit</xsl:with-param>
												</xsl:call-template>
											</xsl:otherwise>
										</xsl:choose>
										
									</xsl:with-param>
								</xsl:call-template>

								<!-- Adjustments -->
								<xsl:if test="$section_line_item_adjustments_details!='N'">
									<xsl:call-template name="fieldset-wrapper">
										<xsl:with-param name="legend">XSL_HEADER_ADJUSTMENTS_DETAILS</xsl:with-param>
										<xsl:with-param name="legend-type">indented-header</xsl:with-param>
										<xsl:with-param name="toc-item">N</xsl:with-param>
										<xsl:with-param name="content">
											&nbsp;
											<xsl:call-template name="build-adjustments-dojo-items">
												<xsl:with-param name="id">line_item_adjustments</xsl:with-param>
											</xsl:call-template>
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
								
								<!-- Taxes -->
								<xsl:if test="$section_line_item_taxes_details!='N'">
									<xsl:call-template name="fieldset-wrapper">
										<xsl:with-param name="legend">XSL_HEADER_TAXES_DETAILS</xsl:with-param>
										<xsl:with-param name="legend-type">indented-header</xsl:with-param>
										<xsl:with-param name="toc-item">N</xsl:with-param>
										<xsl:with-param name="content">
											&nbsp;
											<xsl:call-template name="build-taxes-dojo-items">
												<xsl:with-param name="id">line_item_taxes</xsl:with-param>
											</xsl:call-template>
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>

								<!-- Freight charges -->
								<xsl:if test="$section_line_item_freight_charges_details!='N'">
									<xsl:call-template name="fieldset-wrapper">
										<xsl:with-param name="legend">XSL_HEADER_FREIGHT_CHARGES_DETAILS</xsl:with-param>
										<xsl:with-param name="legend-type">indented-header</xsl:with-param>
										<xsl:with-param name="toc-item">N</xsl:with-param>
										<xsl:with-param name="content">
											<!-- Price unit measure code -->
											<xsl:choose>
	        									<xsl:when test="$displaymode = 'edit'">
	        										<xsl:call-template name="select-field">
														<xsl:with-param name="label">XSL_DETAILS_PO_FREIGHT_CHARGES_TYPE</xsl:with-param>
														<xsl:with-param name="name">line_item_freight_charges_type</xsl:with-param>
														<xsl:with-param name="override-displaymode">edit</xsl:with-param>
														<xsl:with-param name="options">
															<option value="CLCT">
																<xsl:value-of
																	select="localization:getDecode($language, 'N211', 'CLCT')" />
																<xsl:if test="freight_charges_type[. = 'CLCT']">
																	<xsl:attribute name="selected" />
																</xsl:if>
															</option>
															<option value="PRPD">
																<xsl:value-of
																	select="localization:getDecode($language, 'N211', 'PRPD')" />
																<xsl:if test="freight_charges_type[. = 'PRPD']">
																	<xsl:attribute name="selected" />
																</xsl:if>
															</option>
														</xsl:with-param>
													</xsl:call-template>
	        									</xsl:when>
	        									<xsl:otherwise>
	        										<xsl:call-template name="input-field">
														<xsl:with-param name="label">XSL_DETAILS_PO_FREIGHT_CHARGES_TYPE</xsl:with-param>
														<xsl:with-param name="name">line_item_freight_charges_type</xsl:with-param>
														<xsl:with-param name="override-displaymode">edit</xsl:with-param>
													</xsl:call-template>
	        									</xsl:otherwise>
	        								</xsl:choose>
											&nbsp;
											<xsl:call-template name="build-freight-charges-dojo-items">
												<xsl:with-param name="id">line_item_freight_charges</xsl:with-param>
											</xsl:call-template>
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>

								<!-- Line Item Net Amount -->	
								<xsl:choose>							
								<xsl:when test="$section_line_item_total_net_amount_details!='N'">
								<div style="display:block;">	
								<xsl:call-template name="currency-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_LINE_ITEM_NET_AMT</xsl:with-param>
									<xsl:with-param name="override-currency-name">line_item_total_net_cur_code</xsl:with-param>
									<xsl:with-param name="override-amt-name">line_item_total_net_amt</xsl:with-param>
									<xsl:with-param name="override-currency-displaymode">edit</xsl:with-param>
									<xsl:with-param name="override-amt-displaymode">edit</xsl:with-param>
									<xsl:with-param name="currency-readonly">Y</xsl:with-param>
									<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
									<xsl:with-param name="show-button">N</xsl:with-param>
									<xsl:with-param name="amt-readonly">Y</xsl:with-param>
								</xsl:call-template>
								</div>							
								</xsl:when>
								<xsl:otherwise>
								<div style="display:none;">	
								<xsl:call-template name="currency-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_LINE_ITEM_NET_AMT</xsl:with-param>
									<xsl:with-param name="override-currency-name">line_item_total_net_cur_code</xsl:with-param>
									<xsl:with-param name="override-amt-name">line_item_total_net_amt</xsl:with-param>
									<xsl:with-param name="override-currency-displaymode">edit</xsl:with-param>
									<xsl:with-param name="override-amt-displaymode">edit</xsl:with-param>
									<xsl:with-param name="currency-readonly">Y</xsl:with-param>
									<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
									<xsl:with-param name="show-button">N</xsl:with-param>
									<xsl:with-param name="amt-readonly">Y</xsl:with-param>
								</xsl:call-template>
								</div>	
								</xsl:otherwise>								
								</xsl:choose>
								
								<!-- Incoterms -->
								<xsl:if test="$section_line_item_inco_terms_details!='N'">
									<xsl:call-template name="fieldset-wrapper">
										<xsl:with-param name="legend">XSL_HEADER_INCO_TERMS_DETAILS</xsl:with-param>
										<xsl:with-param name="legend-type">indented-header</xsl:with-param>
										<xsl:with-param name="toc-item">N</xsl:with-param>
										<xsl:with-param name="content"> &nbsp; 
											<xsl:call-template name="build-incoterms-dojo-items">
												<xsl:with-param name="id">line_item_incoterms</xsl:with-param>
												<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
											</xsl:call-template>
										</xsl:with-param>
									</xsl:call-template>
								</xsl:if>
								
								<!-- Shipment details -->
								<xsl:if test="$section_line_item_shipment_details!='N'">
								<xsl:call-template name="fieldset-wrapper">
									<xsl:with-param name="legend">XSL_HEADER_SHIPMENT_DETAILS</xsl:with-param>
									<xsl:with-param name="toc-item">N</xsl:with-param>
									<xsl:with-param name="content">
										<xsl:call-template name="fieldset-wrapper">
											<xsl:with-param name="legend">XSL_HEADER_SHIPMENT_DATE_RANGE</xsl:with-param>
											<xsl:with-param name="legend-type">indented-header</xsl:with-param>
											<xsl:with-param name="toc-item">N</xsl:with-param>
											<xsl:with-param name="content"> &nbsp;
												<xsl:variable name="controlType">
													<xsl:choose>
														<xsl:when test="$displaymode = 'edit'">date</xsl:when>
														<xsl:otherwise>text</xsl:otherwise>
													</xsl:choose>
												</xsl:variable>
												<xsl:call-template name="input-field">
													<xsl:with-param name="label">XSL_SHIPMENTDETAILS_EARLIEST_SHIP_DATE</xsl:with-param>
													<!-- events : onblur, onfocus -->
													<xsl:with-param name="name">line_item_earliest_ship_date</xsl:with-param>
													<xsl:with-param name="type" select="$controlType"></xsl:with-param>
													<xsl:with-param name="value">
														<xsl:value-of select="line_item_earliest_ship_date" />
													</xsl:with-param>
													<xsl:with-param name="size">10</xsl:with-param>
													<xsl:with-param name="maxsize">10</xsl:with-param>
													<xsl:with-param name="fieldsize">small</xsl:with-param>
													<xsl:with-param name="swift-validate">N</xsl:with-param>
													<xsl:with-param name="override-displaymode">edit</xsl:with-param>
													<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
											  </xsl:call-template>
											  <xsl:call-template name="input-field">
													<xsl:with-param name="label">XSL_SHIPMENTDETAILS_LAST_SHIP_DATE</xsl:with-param>
													<!-- events : onblur, onfocus -->
													<xsl:with-param name="name">line_item_last_ship_date</xsl:with-param>
													<xsl:with-param name="type" select="$controlType"></xsl:with-param>
													<xsl:with-param name="value">
														<xsl:value-of select="line_item_last_ship_date" />
													</xsl:with-param>
													<xsl:with-param name="size">10</xsl:with-param>
													<xsl:with-param name="maxsize">10</xsl:with-param>
													<xsl:with-param name="fieldsize">small</xsl:with-param>
													<xsl:with-param name="swift-validate">N</xsl:with-param>
													<xsl:with-param name="override-displaymode">edit</xsl:with-param>
													<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
											  </xsl:call-template>
											</xsl:with-param>
										</xsl:call-template>
										<xsl:if test="$section_shipment_sub_schedule !='N'">
											<xsl:call-template name="fieldset-wrapper">
												<xsl:with-param name="legend">XSL_HEADER_SUB_SHIPMENT_SCHEDULE_DETAILS</xsl:with-param>
												<xsl:with-param name="legend-type">indented-header</xsl:with-param>
												<xsl:with-param name="toc-item">N</xsl:with-param>
												<xsl:with-param name="content"> 
													&nbsp; 
													<xsl:call-template name="build-shipment-schedule-dojo-items">
														<xsl:with-param name="id">line_item_shipment_schedules</xsl:with-param>
													</xsl:call-template>
												</xsl:with-param>
											</xsl:call-template>
										</xsl:if>
									</xsl:with-param>
								</xsl:call-template>
								</xsl:if>
								
								<!-- Routing Summary -->
									<xsl:if test="$section_line_item_routing_summary!='N'">
										<xsl:call-template name="routing-summary">
											<xsl:with-param name="prefix">line_item_</xsl:with-param>
										</xsl:call-template>
									</xsl:if>
								
							</xsl:with-param>
						</xsl:call-template>
						<div class="dijitDialogPaneActionBar">
								<xsl:call-template name="label-wrapper">
									<xsl:with-param name="content">
										<button type="button" dojoType="dijit.form.Button">
											<xsl:attribute name="onmouseup">dijit.byId('line-item-dialog-template').hide();</xsl:attribute>
											<xsl:value-of
												select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
										</button>
										<xsl:if test="$displaymode = 'edit'">
											<button dojoType="dijit.form.Button">
												<xsl:attribute name="onClick">dijit.byId('line-item-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
												<xsl:value-of
													select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
											</button>
										</xsl:if>										
									</xsl:with-param>
								</xsl:call-template>
						</div>
					</div>
				</div>
		</div>
	</xsl:template>	
	 <xd:doc>
		<xd:short>Declares the line items</xd:short>
		<xd:detail>
		Creates the buttons for adding line items and displays no line item message if no line items are present
 		</xd:detail>
	</xd:doc>
	<xsl:template name="line-items-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="line-item-dialog-declaration" /> 
		<!-- Dialog End -->
		<div id="line-items-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_NO_LINE_ITEM')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<!--
				TODO: Only possible if PO currency is selected (total_cur_code)
				-->
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_LINE_ITEM')" />
				</button>
			</div>
		</div>
	</xsl:template>
	
	<!-- LineItems - Dojo objects -->
	<xd:doc>
		<xd:short>Build line items</xd:short>
		<xd:detail>
		Prepared the header for adding,and editing or viewing line items also provides header of the line item list.It also adds the attributes that will be put in Line item results set.
 		</xd:detail>
		<xd:param name="name">Name of the Field for form subbmission</xd:param>
	</xd:doc>
	<xsl:template name="build-line-items-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
		<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
		<div dojoType="misys.openaccount.widget.LineItems" dialogId="line-item-dialog-template" id="line-items">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_LINE_ITEM')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_EDIT_LINE_ITEM')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_VIEW_LINE_ITEM')" /></xsl:attribute>
			<xsl:attribute name="headers">
			<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_LINE_ITEM_NUMBER')" />,
			<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_LINE_ITEM_PRODUCT')" />
			</xsl:attribute>
			<xsl:for-each select="$items">
				<xsl:variable name="lineItem" select="." />
				<div dojoType="misys.openaccount.widget.LineItem">
					<xsl:attribute name="cust_ref_id">
					<xsl:choose>
						<xsl:when test="$productCode='EA' or $productCode='IO'">
							<xsl:value-of select="$lineItem/line_item_number" />
						</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="$lineItem/cust_ref_id" />
					</xsl:otherwise>
					</xsl:choose>
					</xsl:attribute>
					<xsl:attribute name="line_item_number"><xsl:value-of
						select="$lineItem/line_item_number" /></xsl:attribute>
					<xsl:attribute name="po_reference"><xsl:value-of
						select="$lineItem/po_reference" /></xsl:attribute>
					<xsl:attribute name="product_name"><xsl:value-of
						select="$lineItem/product_name" /></xsl:attribute>
					<xsl:attribute name="product_orgn"><xsl:value-of
						select="$lineItem/product_orgn" /></xsl:attribute>
					<xsl:attribute name="qty_unit_measr_code"><xsl:value-of select="$lineItem/qty_unit_measr_code" /></xsl:attribute>
					<xsl:attribute name="qty_unit_measr_label">
						<xsl:if test="$lineItem/qty_unit_measr_code != ''">
							<xsl:value-of select="localization:getDecode($language, 'N202', $lineItem/qty_unit_measr_code)" />
						</xsl:if>
					</xsl:attribute>
					<xsl:attribute name="qty_other_unit_measr"><xsl:value-of
						select="$lineItem/qty_other_unit_measr" /></xsl:attribute>
					<xsl:attribute name="qty_val"><xsl:value-of
						select="$lineItem/qty_val" /></xsl:attribute>
					<xsl:attribute name="qty_factor"><xsl:value-of
						select="$lineItem/qty_factor" /></xsl:attribute>
					<xsl:attribute name="qty_tol_pstv_pct"><xsl:value-of
						select="$lineItem/qty_tol_pstv_pct" /></xsl:attribute>
					<xsl:attribute name="qty_tol_neg_pct"><xsl:value-of
						select="$lineItem/qty_tol_neg_pct" /></xsl:attribute>
					<xsl:attribute name="price_unit_measr_code"><xsl:value-of select="$lineItem/price_unit_measr_code" /></xsl:attribute>
					<xsl:attribute name="price_unit_measr_label">
						<xsl:if test="$lineItem/price_unit_measr_code">
							<xsl:value-of select="localization:getDecode($language, 'N202', $lineItem/price_unit_measr_code)" />
						</xsl:if>
					</xsl:attribute>
					<xsl:attribute name="price_other_unit_measr"><xsl:value-of
						select="$lineItem/price_other_unit_measr" /></xsl:attribute>
					<xsl:attribute name="price_cur_code"><xsl:value-of
						select="$lineItem/price_cur_code" /></xsl:attribute>
					<xsl:attribute name="price_amt"><xsl:value-of
						select="$lineItem/price_amt" /></xsl:attribute>
					<xsl:attribute name="price_factor"><xsl:value-of
						select="$lineItem/price_factor" /></xsl:attribute>
					<xsl:attribute name="price_tol_pstv_pct"><xsl:value-of
						select="$lineItem/price_tol_pstv_pct" /></xsl:attribute>
					<xsl:attribute name="price_tol_neg_pct"><xsl:value-of
						select="$lineItem/price_tol_neg_pct" /></xsl:attribute>
					<xsl:attribute name="total_cur_code"><xsl:value-of
						select="$lineItem/total_cur_code" /></xsl:attribute>
					<xsl:attribute name="total_amt"><xsl:value-of
						select="$lineItem/total_amt" /></xsl:attribute>
					<xsl:attribute name="freight_charges_type"><xsl:value-of
						select="$lineItem/freight_charges_type" /></xsl:attribute>
					<xsl:attribute name="total_net_cur_code"><xsl:value-of
						select="$lineItem/total_net_cur_code" /></xsl:attribute>
					<xsl:attribute name="total_net_amt"><xsl:value-of
						select="$lineItem/total_net_amt" /></xsl:attribute>
					<xsl:attribute name="last_ship_date"><xsl:value-of
						select="$lineItem/last_ship_date" /></xsl:attribute>
					<xsl:attribute name="is_valid"><xsl:value-of
						select="$lineItem/is_valid" /></xsl:attribute>
					<xsl:attribute name="ref_id"><xsl:value-of
						select="$lineItem/ref_id" /></xsl:attribute>
					<xsl:attribute name="earliest_ship_date"><xsl:value-of
						select="$lineItem/earliest_ship_date" /></xsl:attribute>	
					<xsl:if test="$productCode='IO' or $productCode='PO' or $productCode='EA'">
						<xsl:attribute name="taking_in_charge"><xsl:value-of
							select="$lineItem/routing_summaries/rs_tnx_record/taking_in_charge" /></xsl:attribute>
						<xsl:attribute name="final_dest_place"><xsl:value-of
							select="$lineItem/routing_summaries/rs_tnx_record/place_of_final_destination" /></xsl:attribute>
					</xsl:if>
					<xsl:apply-templates select="$lineItem/product_identifiers"/>
					<xsl:apply-templates select="$lineItem/product_categories"/>
					<xsl:apply-templates select="$lineItem/product_characteristics"/>
					<xsl:apply-templates select="$lineItem/adjustments"/>
					<xsl:apply-templates select="$lineItem/taxes"/>
					<xsl:apply-templates select="$lineItem/freight_charges"/>
					<xsl:apply-templates select="$lineItem/incoterms"/>
					<xsl:apply-templates select="$lineItem/transports"/>
					<xsl:if test="$productCode='IO' or $productCode='PO' or $productCode='EA'">						
						<xsl:apply-templates select="$lineItem/shipment_schedules"/>
						<xsl:apply-templates select="$lineItem/routing_summaries/air_routing_summaries/rs_tnx_record"/>
						<xsl:apply-templates select="$lineItem/routing_summaries/sea_routing_summaries/rs_tnx_record"/>
						<xsl:apply-templates select="$lineItem/routing_summaries/rail_routing_summaries/rs_tnx_record"/>
						<xsl:apply-templates select="$lineItem/routing_summaries/road_routing_summaries/rs_tnx_record"/>
					</xsl:if>
				</div>
			</xsl:for-each>
		</div>

	</xsl:template>

	<xd:doc>
		<xd:short>Air Routing Summaries</xd:short>
		<xd:detail>
		It calls template routing summary to populate air routing summaries inside line items.
 		</xd:detail>
	</xd:doc>
	<xsl:template match="routing_summaries/air_routing_summaries/rs_tnx_record">
		<div dojoType="misys.openaccount.widget.AirRoutingSummaries">
			<xsl:call-template name="routing_summary">
				<xsl:with-param name="id">line_item_air_routing_summaries</xsl:with-param>
			</xsl:call-template>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Sea Routing Summaries</xd:short>
		<xd:detail>
		It calls template routing summary to populate sea routing summaries inside line items.
 		</xd:detail>
	</xd:doc>
	<xsl:template match="routing_summaries/sea_routing_summaries/rs_tnx_record">
		<div dojoType="misys.openaccount.widget.SeaRoutingSummaries">
			<xsl:call-template name="routing_summary">
				<xsl:with-param name="id">line_item_sea_routing_summaries</xsl:with-param>
			</xsl:call-template>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Road Routing Summaries</xd:short>
		<xd:detail>
		It calls template routing summary to populate road routing summaries inside line items.
 		</xd:detail>
	</xd:doc>
	<xsl:template match="routing_summaries/road_routing_summaries/rs_tnx_record">
		<div dojoType="misys.openaccount.widget.RoadRoutingSummaries">
			<xsl:call-template name="routing_summary">
				<xsl:with-param name="id">line_item_road_routing_summaries</xsl:with-param>
			</xsl:call-template>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Rail Routing Summaries</xd:short>
		<xd:detail>
		It calls template routing summary to populate rail routing summaries inside line items.
 		</xd:detail>
	</xd:doc>
	<xsl:template match="routing_summaries/rail_routing_summaries/rs_tnx_record">
		<div dojoType="misys.openaccount.widget.RailRoutingSummaries">
			<xsl:call-template name="routing_summary">
				<xsl:with-param name="id">line_item_rail_routing_summaries</xsl:with-param>
			</xsl:call-template>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Routing Summary</xd:short>
		<xd:detail>
		It  gets the value of different attributes such as ref_id,tnx_id,routing_summary_mode,
		routing_summary_type and carrier name (air,sea,road,rail) and linked_ref_id and linked_tnx_id inside line items widget.
 		</xd:detail>
	</xd:doc>
	<xsl:template name="routing_summary">
		<xsl:param name="id"></xsl:param>
		<div dojoType="misys.openaccount.widget.RoutingSummary">
			<xsl:attribute name="ref_id"><xsl:value-of
				select="ref_id" /></xsl:attribute>
			<xsl:attribute name="tnx_id"><xsl:value-of
				select="tnx_id" /></xsl:attribute>
			<xsl:attribute name="routing_summary_mode"><xsl:value-of
				select="routing_summary_mode" /></xsl:attribute>
			<xsl:attribute name="routing_summary_type"><xsl:value-of
				select="routing_summary_type" /></xsl:attribute>
			<xsl:attribute name="linked_ref_id"><xsl:value-of
				select="linked_ref_id" /></xsl:attribute>
			<xsl:attribute name="linked_tnx_id"><xsl:value-of
				select="linked_tnx_id" /></xsl:attribute>
				<xsl:choose>
					<xsl:when test="air_carrier_name != ''">
						<xsl:attribute name="air_carrier_name">
							<xsl:value-of select="air_carrier_name" />
						</xsl:attribute>
					</xsl:when>
					<xsl:when test="sea_carrier_name != ''">
						<xsl:attribute name="sea_carrier_name">
							<xsl:value-of select="sea_carrier_name" />
						</xsl:attribute>
					</xsl:when>
					<xsl:when test="road_carrier_name != ''">
						<xsl:attribute name="road_carrier_name">
							<xsl:value-of select="road_carrier_name" />
						</xsl:attribute>
					</xsl:when>
					<xsl:when test="rail_carrier_name != ''">
						<xsl:attribute name="rail_carrier_name">
							<xsl:value-of select="rail_carrier_name" />
						</xsl:attribute>
					</xsl:when>
				</xsl:choose>
			<!-- Apply the templates for sub tags departures/departure : This will call the template defined to be called for a match of tag name departures -->
			<xsl:if test="departures != ''">
				<xsl:apply-templates select="departures"/>
			</xsl:if>
			<xsl:if test="destinations != ''">
				<xsl:apply-templates select="destinations"/>
			</xsl:if>
			<xsl:if test="loading_ports != ''">
				<xsl:apply-templates select="loading_ports"/>
			</xsl:if>
			<xsl:if test="discharge_ports != ''">
				<xsl:apply-templates select="discharge_ports"/>
			</xsl:if>
			<xsl:if test="rail_receipt_places != ''">
				<xsl:apply-templates select="rail_receipt_places"/>
			</xsl:if>
			<xsl:if test="rail_delivery_places != ''">
				<xsl:apply-templates select="rail_delivery_places"/>
			</xsl:if>
			<xsl:if test="road_receipt_places != ''">
				<xsl:apply-templates select="road_receipt_places"/>
			</xsl:if>
			<xsl:if test="road_delivery_places != ''">
				<xsl:apply-templates select="road_delivery_places"/>
			</xsl:if>
		</div>
	</xsl:template>

	<xd:doc>
		<xd:short>Product Identifiers</xd:short>
		<xd:detail>
		It calls product identifier template inside productIdentifiers widget
 		</xd:detail>
	</xd:doc>
	<xsl:template match="product_identifiers">
		<div dojoType="misys.openaccount.widget.ProductIdentifiers">
			<xsl:apply-templates select="product_identifier"/>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Product Identifier</xd:short>
		<xd:detail>
		It  gets the value of different attributes such as ref_id,tnx_id,goods_id,type,type_label,other_type
		and description inside productIdentifiers widget.
 		</xd:detail>
	</xd:doc>
	<xsl:template match="product_identifier">
		<div dojoType="misys.openaccount.widget.ProductIdentifier">
			<xsl:attribute name="goods_id"><xsl:value-of select="goods_id"/></xsl:attribute>
			<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
			<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
			<xsl:attribute name="type"><xsl:value-of select="type"/></xsl:attribute>
			<xsl:attribute name="type_label"><xsl:if test="type !=''"><xsl:value-of
						select="localization:getDecode($language, 'N220', type)" /></xsl:if></xsl:attribute>
			<xsl:attribute name="other_type"><xsl:value-of select="other_type"/></xsl:attribute>
			<xsl:attribute name="description"><xsl:value-of select="identifier"/></xsl:attribute>
		</div>
	</xsl:template>

	<xd:doc>
		<xd:short>Product Categories</xd:short>
		<xd:detail>
		It calls product_categories inside productCategories widget.(instantiating a widget?)
 		</xd:detail>
	</xd:doc>
	<xsl:template match="product_categories">
		<div dojoType="misys.openaccount.widget.ProductCategories">
			<xsl:apply-templates select="product_category"/>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Product Categories</xd:short>
		<xd:detail>
		It gets value of different attributes such as goods_id,ref_id,tnx_id,type,type_label,other_type and description inside productCategories widget
 		</xd:detail>
	</xd:doc>
	<xsl:template match="product_category">
		<div dojoType="misys.openaccount.widget.ProductCategory">
			<xsl:attribute name="goods_id"><xsl:value-of select="goods_id"/></xsl:attribute>
			<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
			<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
			<xsl:attribute name="type"><xsl:value-of select="type"/></xsl:attribute>
			<xsl:attribute name="type_label"><xsl:value-of
						select="localization:getDecode($language, 'N221', type)" /></xsl:attribute>
			<xsl:attribute name="other_type"><xsl:value-of select="other_type"/></xsl:attribute>
			<xsl:attribute name="description"><xsl:value-of select="category"/></xsl:attribute>
		</div>
	</xsl:template>

	<xd:doc>
		<xd:short>Product Characteristics</xd:short>
		<xd:detail>
		It calls product_characteristic template inside productCharacteristics widget
 		</xd:detail>
	</xd:doc>
	<xsl:template match="product_characteristics">
		<div dojoType="misys.openaccount.widget.ProductCharacteristics">
			<xsl:apply-templates select="product_characteristic"/>
		</div>
	</xsl:template>

	<xd:doc>
		<xd:short>Product Characteristics</xd:short>
		<xd:detail>
		It select value of different attributes such as goods_id,ref_id,tnx_id,type,type_label,other_type,description and is_valid inside productCharacteristic widget
 		</xd:detail>
	</xd:doc>
	<xsl:template match="product_characteristic">
		<div dojoType="misys.openaccount.widget.ProductCharacteristic">
			<xsl:attribute name="goods_id"><xsl:value-of select="goods_id"/></xsl:attribute>
			<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
			<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
			<xsl:attribute name="type"><xsl:value-of select="type"/></xsl:attribute>
			<xsl:attribute name="type_label"><xsl:value-of
						select="localization:getDecode($language, 'N222', type)" /></xsl:attribute>
			<xsl:attribute name="other_type"><xsl:value-of select="other_type"/></xsl:attribute>
			<xsl:attribute name="description"><xsl:value-of select="characteristic"/></xsl:attribute>
			<xsl:attribute name="is_valid"><xsl:value-of select="is_valid"/></xsl:attribute>
		</div>
	</xsl:template>

	<xd:doc>
		<xd:short>Adjustment Template</xd:short>
		<xd:detail>
		It calls allowanace template with adjustment mode inside adjustment widget
 		</xd:detail>
	</xd:doc>
	<xsl:template match="adjustments">
		<div dojoType="misys.openaccount.widget.Adjustments">
			<xsl:apply-templates select="allowance" mode="adjustment"/>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Allowance Template with adjustment mode</xd:short>
		<xd:detail>
		It select value of different attributes such allowance_id,ref_id,tnx_id,type,type_label,other_type,direction,direction_lable,cur_code,amt,cn_reference_id,rate and is_valid inside adjustment widget.
 		</xd:detail>
	</xd:doc>
	<xsl:template match="allowance" mode="adjustment">
		<div dojoType="misys.openaccount.widget.Adjustment">
			<xsl:attribute name="allowance_id"><xsl:value-of select="allowance_id"/></xsl:attribute>
			<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
			<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
			<xsl:attribute name="type"><xsl:value-of select="type"/></xsl:attribute>
			<xsl:attribute name="type_label"><xsl:value-of select="localization:getDecode($language, 'N210', type)" /></xsl:attribute>
			<xsl:attribute name="other_type"><xsl:value-of select="other_type"/></xsl:attribute>
			<xsl:attribute name="direction"><xsl:value-of select="direction"/></xsl:attribute>
			<xsl:attribute name="direction_label"><xsl:value-of select="localization:getDecode($language, 'N216', direction)" /></xsl:attribute>
			<xsl:attribute name="cur_code"><xsl:value-of select="cur_code"/></xsl:attribute>
			<xsl:attribute name="amt"><xsl:value-of select="amt"/></xsl:attribute>
			<xsl:attribute name="cn_reference_id"><xsl:value-of select="cn_reference_id"/></xsl:attribute>
			<xsl:attribute name="discount_exp_date"><xsl:value-of select="discount_exp_date"/></xsl:attribute>
			<xsl:attribute name="rate"><xsl:value-of select="rate"/></xsl:attribute>
			<xsl:attribute name="is_valid"><xsl:value-of select="is_valid"/></xsl:attribute>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Taxes</xd:short>
		<xd:detail>
		It applies allowance templates of mode tax for multiple calls inside taxes widget.
 		</xd:detail>
	</xd:doc>
	<xsl:template match="taxes">
		<div dojoType="misys.openaccount.widget.Taxes">
			<xsl:apply-templates select="allowance" mode="tax"/>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Allowance Template with Tax Mode</xd:short>
		<xd:detail>
		It adds attributes which are allowance_id,ref_id,tnx_id,type,type_label,other_type,cur_code,amt,rate and is_valid and takes value in given selected field inside taxes widget.
 		</xd:detail>
	</xd:doc>
	<xsl:template match="allowance" mode="tax">
		<div dojoType="misys.openaccount.widget.Tax">
			<xsl:attribute name="allowance_id"><xsl:value-of select="allowance_id"/></xsl:attribute>
			<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
			<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
			<xsl:attribute name="type"><xsl:value-of select="type"/></xsl:attribute>
			<xsl:attribute name="type_label"><xsl:value-of	select="localization:getDecode($language, 'N210', type)" /></xsl:attribute>
			<xsl:attribute name="other_type"><xsl:value-of select="other_type"/></xsl:attribute>
			<xsl:attribute name="cur_code"><xsl:value-of select="cur_code"/></xsl:attribute>
			<xsl:attribute name="amt"><xsl:value-of select="amt"/></xsl:attribute>
			<xsl:attribute name="rate"><xsl:value-of select="rate"/></xsl:attribute>
			<xsl:attribute name="is_valid"><xsl:value-of select="is_valid"/></xsl:attribute>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Freight Charges</xd:short>
		<xd:detail>
		It applies allowance templates with freightCharge mode in freightCharges Widget.
 		</xd:detail>
	</xd:doc>
	<xsl:template match="freight_charges">
		<div dojoType="misys.openaccount.widget.FreightCharges">
			<xsl:apply-templates select="allowance" mode="freightCharge"/>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Freight Charges</xd:short>
		<xd:detail>
		It selects attributes which are allowance_id,ref_id,tnx_id,type,type_label,other_type,cur_code,amt and rate in freightCharges Widget.
 		</xd:detail>
	</xd:doc>
	<xsl:template match="allowance" mode="freightCharge">
		<div dojoType="misys.openaccount.widget.FreightCharge">
			<xsl:attribute name="allowance_id"><xsl:value-of select="allowance_id"/></xsl:attribute>
			<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
			<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
			<xsl:attribute name="type"><xsl:value-of select="type"/></xsl:attribute>
			<xsl:attribute name="type_label"><xsl:value-of
						select="localization:getDecode($language, 'N210', type)" /></xsl:attribute>
			<xsl:attribute name="other_type"><xsl:value-of select="other_type"/></xsl:attribute>
			<xsl:attribute name="cur_code"><xsl:value-of select="cur_code"/></xsl:attribute>
			<xsl:attribute name="amt"><xsl:value-of select="amt"/></xsl:attribute>
			<xsl:attribute name="rate"><xsl:value-of select="rate"/></xsl:attribute>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Incoterms</xd:short>
		<xd:detail>
			This template applies incoterm template for mutliple call events
 		</xd:detail>
	</xd:doc>
	<xsl:template match="incoterms">
		<div dojoType="misys.openaccount.widget.Incoterms">
			<xsl:apply-templates select="incoterm"/>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Incoterm</xd:short>
		<xd:detail>
			This template adds different attributes of incoterms and fills it with given selected value. 
 		</xd:detail>
	</xd:doc>
	<xsl:template match="incoterm">
		<div dojoType="misys.openaccount.widget.Incoterm">
			<xsl:attribute name="inco_term_id"><xsl:value-of select="inco_term_id"/></xsl:attribute>
			<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
			<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
			<xsl:attribute name="code"><xsl:value-of select="code"/></xsl:attribute>
			<xsl:attribute name="code_label"><xsl:value-of
						select="localization:getDecode($language, 'N212', code)" /></xsl:attribute>
			<xsl:attribute name="other"><xsl:value-of select="other"/></xsl:attribute>
			<xsl:attribute name="location"><xsl:value-of select="location"/></xsl:attribute>
			<xsl:attribute name="is_valid"><xsl:value-of select="is_valid"/></xsl:attribute>
		</div>
	</xsl:template>

	<!-- Quantity unite measure codes -->
	<xd:doc>
		<xd:short>Unit of Quantity</xd:short>
		<xd:detail>
			This displayes the quantity units codes given in drop down
 		</xd:detail>
 		<xd:param name="field-name">Name of the field in the form submission</xd:param>
	</xd:doc>
	<xsl:template name="quantity-unit-measure-codes">
	<xsl:param name="field-name"/>
	 <xsl:choose>
        <xsl:when test="$displaymode='edit'">
		<option value="EA">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'EA')" />
		</option>
		<option value="BG">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'BG')" />
		</option>
		<option value="BL">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'BL')" />
		</option>
		<option value="BO">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'BO')" />
		</option>
		<option value="BX">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'BX')" />
		</option>
		<option value="CH">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'CH')" />
		</option>
		<option value="CT">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'CT')" />
		</option>
		<option value="CR">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'CR')" />
		</option>
		<option value="CLT">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'CLT')" />
		</option>
		<option value="GRM">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'GRM')" />
		</option>
		<option value="KGM">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'KGM')" />
		</option>
		<option value="LTN">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'LTN')" />
		</option>
		<option value="LBR">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'LBR')" />
		</option>
		<option value="ONZ">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'ONZ')" />
		</option>
		<option value="STN">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'STN')" />
		</option>
		<option value="INQ">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'INQ')" />
		</option>
		<option value="LTR">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'LTR')" />
		</option>
		<option value="MTQ">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'MTQ')" />
		</option>
		<option value="OZA">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'OZA')" />
		</option>
		<option value="OZI">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'OZI')" />
		</option>
		<option value="PT">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'PT')" />
		</option>
		<option value="PTI">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'PTI')" />
		</option>
		<option value="QT">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'QT')" />
		</option>
		<option value="QTI">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'QTI')" />
		</option>
		<option value="FTK">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'FTK')" />
		</option>
		<option value="INK">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'INK')" />
		</option>
		<option value="KMK">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'KMK')" />
		</option>
		<option value="MIK">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'MIK')" />
		</option>
		<option value="MMK">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'MMK')" />
		</option>
		<option value="MTK">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'MTK')" />
		</option>
		<option value="YDK">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'YDK')" />
		</option>
		<option value="CMK">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'CMK')" />
		</option>
		<option value="1A">
			<xsl:value-of select="localization:getDecode($language, 'N202', '1A')" />
		</option>
		<option value="CMT">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'CMT')" />
		</option>
		<option value="FOT">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'FOT')" />
		</option>
		<option value="INH">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'INH')" />
		</option>
		<option value="KTM">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'KTM')" />
		</option>
		<option value="LY">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'LY')" />
		</option>
		<option value="MTR">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'MTR')" />
		</option>
		<option value="BLL">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'BLL')" />
		</option>
		<option value="GLI">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'GLI')" />
		</option>
		<option value="GLL">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'GLL')" />
		</option>
		<option value="MMQ">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'MMQ')" />
		</option>
		<option value="MMT">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'MMT')" />
		</option>
		<option value="TNE">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'TNE')" />
		</option>
		<option value="OTHR">
			<xsl:value-of select="localization:getDecode($language, 'N202', 'OTHR')" />
		</option>
		 </xsl:when>
        <xsl:otherwise>
         <xsl:choose>
          <xsl:when test="$field-name = 'EA'"><xsl:value-of select="localization:getDecode($language, 'N202', 'EA')" /></xsl:when>
          <xsl:when test="$field-name = 'BG'"><xsl:value-of select="localization:getDecode($language, 'N202', 'BG')" /></xsl:when>
          <xsl:when test="$field-name = 'BL'"><xsl:value-of select="localization:getDecode($language, 'N202', 'BL')" /></xsl:when>
          <xsl:when test="$field-name = 'BO'"><xsl:value-of select="localization:getDecode($language, 'N202', 'BO')" /></xsl:when>
          <xsl:when test="$field-name = 'BX'"><xsl:value-of select="localization:getDecode($language, 'N202', 'BX')" /></xsl:when>
          <xsl:when test="$field-name = 'CH'"><xsl:value-of select="localization:getDecode($language, 'N202', 'CH')" /></xsl:when>
          <xsl:when test="$field-name = 'CT'"><xsl:value-of select="localization:getDecode($language, 'N202', 'CT')" /></xsl:when>
          <xsl:when test="$field-name = 'CR'"><xsl:value-of select="localization:getDecode($language, 'N202', 'CR')" /></xsl:when>
          <xsl:when test="$field-name = 'CLT'"><xsl:value-of select="localization:getDecode($language, 'N202', 'CLT')" /></xsl:when>
          <xsl:when test="$field-name = 'GRM'"><xsl:value-of select="localization:getDecode($language, 'N202', 'GRM')" /></xsl:when>
          <xsl:when test="$field-name = 'KGM'"><xsl:value-of select="localization:getDecode($language, 'N202', 'KGM')" /></xsl:when>
          <xsl:when test="$field-name = 'LTN'"><xsl:value-of select="localization:getDecode($language, 'N202', 'LTN')" /></xsl:when>
          <xsl:when test="$field-name = 'LBR'"><xsl:value-of select="localization:getDecode($language, 'N202', 'LBR')" /></xsl:when>
          <xsl:when test="$field-name = 'ONZ'"><xsl:value-of select="localization:getDecode($language, 'N202', 'ONZ')" /></xsl:when>
          <xsl:when test="$field-name = 'STN'"><xsl:value-of select="localization:getDecode($language, 'N202', 'STN')" /></xsl:when>
          <xsl:when test="$field-name = 'INQ'"><xsl:value-of select="localization:getDecode($language, 'N202', 'INQ')" /></xsl:when>
          <xsl:when test="$field-name = 'LTR'"><xsl:value-of select="localization:getDecode($language, 'N202', 'LTR')" /></xsl:when>
          <xsl:when test="$field-name = 'MTQ'"><xsl:value-of select="localization:getDecode($language, 'N202', 'MTQ')" /></xsl:when>
          <xsl:when test="$field-name = 'OZA'"><xsl:value-of select="localization:getDecode($language, 'N202', 'OZA')" /></xsl:when>
          <xsl:when test="$field-name = 'OZI'"><xsl:value-of select="localization:getDecode($language, 'N202', 'OZI')" /></xsl:when>
          <xsl:when test="$field-name = 'PT'"><xsl:value-of select="localization:getDecode($language, 'N202', 'PT')" /></xsl:when>
          <xsl:when test="$field-name = 'PTI'"><xsl:value-of select="localization:getDecode($language, 'N202', 'PTI')" /></xsl:when>
          <xsl:when test="$field-name = 'QT'"><xsl:value-of select="localization:getDecode($language, 'N202', 'QT')" /></xsl:when>
          <xsl:when test="$field-name = 'QTI'"><xsl:value-of select="localization:getDecode($language, 'N202', 'QTI')" /></xsl:when>
          <xsl:when test="$field-name = 'FTK'"><xsl:value-of select="localization:getDecode($language, 'N202', 'FTK')" /></xsl:when>
          <xsl:when test="$field-name = 'INK'"><xsl:value-of select="localization:getDecode($language, 'N202', 'INK')" /></xsl:when>
          <xsl:when test="$field-name = 'KMK'"><xsl:value-of select="localization:getDecode($language, 'N202', 'KMK')" /></xsl:when>
          <xsl:when test="$field-name = 'MIK'"><xsl:value-of select="localization:getDecode($language, 'N202', 'MIK')" /></xsl:when>
          <xsl:when test="$field-name = 'MMK'"><xsl:value-of select="localization:getDecode($language, 'N202', 'MMK')" /></xsl:when>
          <xsl:when test="$field-name = 'MTK'"><xsl:value-of select="localization:getDecode($language, 'N202', 'MTK')" /></xsl:when>
          <xsl:when test="$field-name = 'YDK'"><xsl:value-of select="localization:getDecode($language, 'N202', 'YDK')" /></xsl:when>
          <xsl:when test="$field-name = 'CMK'"><xsl:value-of select="localization:getDecode($language, 'N202', 'CMK')" /></xsl:when>
          <xsl:when test="$field-name = '1A'"><xsl:value-of select="localization:getDecode($language, 'N202', '1A')" /></xsl:when>
          <xsl:when test="$field-name = 'CMT'"><xsl:value-of select="localization:getDecode($language, 'N202', 'CMT')" /></xsl:when>
          <xsl:when test="$field-name = 'FOT'"><xsl:value-of select="localization:getDecode($language, 'N202', 'FOT')" /></xsl:when>
          <xsl:when test="$field-name = 'INH'"><xsl:value-of select="localization:getDecode($language, 'N202', 'INH')" /></xsl:when>
          <xsl:when test="$field-name = 'KTM'"><xsl:value-of select="localization:getDecode($language, 'N202', 'KTM')" /></xsl:when>
          <xsl:when test="$field-name = 'LY'"><xsl:value-of select="localization:getDecode($language, 'N202', 'LY')" /></xsl:when>
          <xsl:when test="$field-name = 'MTR'"><xsl:value-of select="localization:getDecode($language, 'N202', 'MTR')" /></xsl:when>
          <xsl:when test="$field-name = 'BLL'"><xsl:value-of select="localization:getDecode($language, 'N202', 'BLL')" /></xsl:when>
          <xsl:when test="$field-name = 'GLI'"><xsl:value-of select="localization:getDecode($language, 'N202', 'GLI')" /></xsl:when>
          <xsl:when test="$field-name = 'GLL'"><xsl:value-of select="localization:getDecode($language, 'N202', 'GLL')" /></xsl:when>
          <xsl:when test="$field-name = 'MMQ'"><xsl:value-of select="localization:getDecode($language, 'N202', 'MMQ')" /></xsl:when>
          <xsl:when test="$field-name = 'MMT'"><xsl:value-of select="localization:getDecode($language, 'N202', 'MMT')" /></xsl:when>
          <xsl:when test="$field-name = 'TNE'"><xsl:value-of select="localization:getDecode($language, 'N202', 'TNE')" /></xsl:when>
          <xsl:otherwise></xsl:otherwise>
         </xsl:choose>
        </xsl:otherwise>
       </xsl:choose>
	</xsl:template>

	<!-- ******************* -->
	<!-- Product Identifiers -->
	<!-- ******************* -->
	<!-- Template for the declaration of line items -->
	<xd:doc>
		<xd:short>Product Identifier Dialog</xd:short>
		<xd:detail>
			This template calls various templates and sets different parameters of these different field.Also adds OK and CANCEL button at end of dialog
 		</xd:detail>
 		<xd:param name="field-name">Name of the field in the form submission</xd:param>
	</xd:doc>
	<xsl:template name="product-identifier-dialog-declaration">
		<div id="product-identifier-dialog-template" style="display:none"
			class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>

				<div class="standardPODialogContent">
					<div>
						<!-- Product Identifier Code -->
						<!-- In view mode, we should return an input field -->
						<xsl:choose>
							<xsl:when test="$displaymode = 'edit'">
								<xsl:call-template name="hidden-field">
									<xsl:with-param name="name">product_identifier_code_label</xsl:with-param>							
									<xsl:with-param name="value">
										<xsl:choose>
											<xsl:when test="product_identifier_code"><xsl:value-of select="localization:getDecode($language, 'N220', product_identifier_code)" /></xsl:when>
											<xsl:otherwise></xsl:otherwise>
										</xsl:choose>
									</xsl:with-param>							
								</xsl:call-template>
								<xsl:call-template name="select-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_PRODUCT_IDENTIFIER_CODE</xsl:with-param>
									<xsl:with-param name="name">product_identifier_code</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="required">Y</xsl:with-param>
									<xsl:with-param name="options">
										<xsl:call-template name="product-identifier-codes" >
											<xsl:with-param name="field-name">product_identifier_code</xsl:with-param>
										</xsl:call-template>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_PRODUCT_IDENTIFIER_CODE</xsl:with-param>
									<xsl:with-param name="name">product_identifier_code_label</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									<xsl:with-param name="swift-validate">N</xsl:with-param>
									<xsl:with-param name="size">35</xsl:with-param>
									<xsl:with-param name="maxsize">35</xsl:with-param>
									<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
						
						<!-- Product identifier other type -->
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DETAILS_PO_PRODUCT_IDENTIFIER_OTHER_CODE</xsl:with-param>
							<xsl:with-param name="name">product_identifier_other_code</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							<xsl:with-param name="swift-validate">N</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="readonly">Y</xsl:with-param>
							<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>
						<!-- Product identifier description -->
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DETAILS_PO_PRODUCT_IDENTIFIER_DESCRIPTION</xsl:with-param>
							<xsl:with-param name="name">product_identifier_description</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							<xsl:with-param name="swift-validate">N</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>
						<div class="dijitDialogPaneActionBar">
						<xsl:call-template name="label-wrapper">
							<xsl:with-param name="content">
								<button type="button" dojoType="dijit.form.Button">
									<xsl:attribute name="onmouseup">dijit.byId('product-identifier-dialog-template').hide();</xsl:attribute>
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
								</button>
								<xsl:if test="$displaymode = 'edit'">
									<button dojoType="dijit.form.Button">
										<xsl:attribute name="onClick">dijit.byId('product-identifier-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
									</button>
								</xsl:if>								
							</xsl:with-param>
						</xsl:call-template>
						</div>
					</div>
				</div>
		</div>
	</xsl:template>

	<xd:doc>
		<xd:short>Product Identifier Declaration</xd:short>
		<xd:detail>
			This template displayes message if there is no identifier and adds button to add identifier. 
 		</xd:detail>
 	</xd:doc>
	<xsl:template name="product-identifiers-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="product-identifier-dialog-declaration" />
		<!-- Dialog End -->
		<div id="product-identifiers-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_DETAILS_PO_NO_PRODUCT_IDENTIFIER')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<!--
TODO: Only possible if PO currency is selected (total_cur_code)
-->
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_PRODUCT_IDENTIFIER')" />
				</button>
			</div>
		</div>
	</xsl:template>

	<!-- ProductIdentifiers - Dojo objects -->
	<xd:doc>
		<xd:short>Product Identifier dojo items </xd:short>
		<xd:detail>
			This selects values to add,update or view the product identifiers,it also adds different attributes to widget product identifier.
 		</xd:detail>
 		<xd:param name="items"> Items to be build to form display </xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">Overridden display mode.</xd:param>
 	</xd:doc>
	<xsl:template name="build-product-identifiers-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->

		<div dojoType="misys.openaccount.widget.ProductIdentifiers" dialogId="product-identifier-dialog-template">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_PRODUCT_IDENTIFIER')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_EDIT_PRODUCT_IDENTIFIER')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_VIEW_PRODUCT_IDENTIFIER')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_PRODUCT_IDENTIFIER_CODE')" />,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_PRODUCT_IDENTIFIER_DESCRIPTION')" />
			</xsl:attribute>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
			<xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="productIdentifier" select="." />
					<div dojoType="misys.openaccount.widget.ProductIdentifier">
						<xsl:attribute name="goods_id"><xsl:value-of
							select="$productIdentifier/goods_id" /></xsl:attribute>
						<xsl:attribute name="ref_id"><xsl:value-of
							select="$productIdentifier/ref_id" /></xsl:attribute>
						<xsl:attribute name="tnx_id"><xsl:value-of
							select="$productIdentifier/tnx_id" /></xsl:attribute>
						<xsl:attribute name="type"><xsl:value-of
							select="$productIdentifier/type" /></xsl:attribute>
						<xsl:attribute name="type_label"><xsl:if test="$productIdentifier/type !=''"><xsl:value-of select="localization:getDecode($language, 'N220', $productIdentifier/type)" /></xsl:if></xsl:attribute>
						<xsl:attribute name="other_type"><xsl:value-of
							select="$productIdentifier/other_type" /></xsl:attribute>
						<xsl:attribute name="description"><xsl:value-of
							select="$productIdentifier/description" /></xsl:attribute>
					</div>
				</xsl:for-each>
			</xsl:if>
		</div>

	</xsl:template>

	<!-- <xsl:template name="build-product-identifiers-json">
		<xsl:param name="items" />
			<xsl:if test="$items">
				{items: [<xsl:for-each select="$items"><xsl:variable name="productIdentifier" select="." />{goods_id: '<xsl:value-of select="$productIdentifier/goods_id" />',ref_id: '<xsl:value-of select="$productIdentifier/ref_id" />',tnx_id: '<xsl:value-of select="$productIdentifier/tnx_id" />',type: '<xsl:value-of select="$productIdentifier/type" />',other_type: '<xsl:value-of select="$productIdentifier/other_type" />',description: '<xsl:value-of select="$productIdentifier/identifier" />'},</xsl:for-each>{}]}
			</xsl:if>
	</xsl:template>-->

	<!-- Product identifier codes -->
	<xd:doc>
		<xd:short>Product Identifier codes</xd:short>
		<xd:detail>
			This selects different codes of product identifier such as buyer item number etc
 		</xd:detail>
 		<xd:param name="field-name">Name of the input field in the form </xd:param> 		
 	</xd:doc>
	<xsl:template name="product-identifier-codes">
	<xsl:param name="field-name"/>
	 <xsl:choose>
        <xsl:when test="$displaymode='edit'">
		<option value="BINR">
			<xsl:value-of select="localization:getDecode($language, 'N220', 'BINR')" />
		</option>
		<option value="COMD">
			<xsl:value-of select="localization:getDecode($language, 'N220', 'COMD')" />
		</option>
		<option value="EANC">
			<xsl:value-of select="localization:getDecode($language, 'N220', 'EANC')" />
		</option>
		<option value="HRTR">
			<xsl:value-of select="localization:getDecode($language, 'N220', 'HRTR')" />
		</option>
		<option value="MANI">
			<xsl:value-of select="localization:getDecode($language, 'N220', 'MANI')" />
		</option>
		<option value="MODL">
			<xsl:value-of select="localization:getDecode($language, 'N220', 'MODL')" />
		</option>
		<option value="PART">
			<xsl:value-of select="localization:getDecode($language, 'N220', 'PART')" />
		</option>
		<option value="QOTA">
			<xsl:value-of select="localization:getDecode($language, 'N220', 'QOTA')" />
		</option>
		<option value="STYL">
			<xsl:value-of select="localization:getDecode($language, 'N220', 'STYL')" />
		</option>
		<option value="SUPI">
			<xsl:value-of select="localization:getDecode($language, 'N220', 'SUPI')" />
		</option>
		<option value="UPCC">
			<xsl:value-of select="localization:getDecode($language, 'N220', 'UPCC')" />
		</option>
		<option value="OTHR">
			<xsl:value-of select="localization:getDecode($language, 'N220', 'OTHR')" />
		</option>
		 </xsl:when>
        <xsl:otherwise>
         <xsl:choose>
          <xsl:when test="$field-name = 'BINR'"><xsl:value-of select="localization:getDecode($language, 'N220', 'BINR')" /></xsl:when>
          <xsl:when test="$field-name = 'COMD'"><xsl:value-of select="localization:getDecode($language, 'N220', 'COMD')" /></xsl:when>
          <xsl:when test="$field-name = 'EANC'"><xsl:value-of select="localization:getDecode($language, 'N220', 'EANC')" /></xsl:when>
          <xsl:when test="$field-name = 'HRTR'"><xsl:value-of select="localization:getDecode($language, 'N220', 'HRTR')" /></xsl:when>
          <xsl:when test="$field-name = 'MANI'"><xsl:value-of select="localization:getDecode($language, 'N220', 'MANI')" /></xsl:when>
          <xsl:when test="$field-name = 'MODL'"><xsl:value-of select="localization:getDecode($language, 'N220', 'MODL')" /></xsl:when>
          <xsl:when test="$field-name = 'PART'"><xsl:value-of select="localization:getDecode($language, 'N220', 'PART')" /></xsl:when>
          <xsl:when test="$field-name = 'QOTA'"><xsl:value-of select="localization:getDecode($language, 'N220', 'QOTA')" /></xsl:when>
          <xsl:when test="$field-name = 'STYL'"><xsl:value-of select="localization:getDecode($language, 'N220', 'STYL')" /></xsl:when>
          <xsl:when test="$field-name = 'SUPI'"><xsl:value-of select="localization:getDecode($language, 'N220', 'SUPI')" /></xsl:when>
          <xsl:when test="$field-name = 'UPCC'"><xsl:value-of select="localization:getDecode($language, 'N220', 'UPCC')" /></xsl:when>
          <xsl:otherwise><xsl:value-of select="localization:getDecode($language, 'N220', 'OTHR')" /></xsl:otherwise>
         </xsl:choose>
        </xsl:otherwise>
       </xsl:choose>
	</xsl:template>


	<!-- ******************** -->
	<!-- Product Categories -->
	<!-- ******************** -->
	<!-- Template for the declaration of line items -->
	<xd:doc>
		<xd:short>Product category dialog</xd:short>
		<xd:detail>
			This template adds difference parameter for different template called inside this,also adds product category drop-down,
			Also adds CANCEL and OK button at the end of dialog
 		</xd:detail> 		
 	</xd:doc>
	<xsl:template name="product-category-dialog-declaration">
		<div id="product-category-dialog-template" style="display:none"
			class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>

			<div class="standardPODialogContent">
					<div>
						
						<!-- Product Category Code -->
						<xsl:choose>
							<xsl:when test="$displaymode = 'edit'">
								<xsl:call-template name="hidden-field">
									<xsl:with-param name="name">product_category_code_label</xsl:with-param>							
									<xsl:with-param name="value">
										<xsl:choose>
											<xsl:when test="product_category_code"><xsl:value-of select="localization:getDecode($language, 'N221', product_category_code)" /></xsl:when>
											<xsl:otherwise></xsl:otherwise>
										</xsl:choose>
									</xsl:with-param>							
								</xsl:call-template>
								<xsl:call-template name="select-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_PRODUCT_CATEGORY_CODE</xsl:with-param>
									<xsl:with-param name="name">product_category_code</xsl:with-param>
									<xsl:with-param name="required">Y</xsl:with-param>
									<xsl:with-param name="options">
										<xsl:call-template name="product-category-codes" >
										<xsl:with-param name="field-name">product_category_code</xsl:with-param>
										</xsl:call-template>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_PRODUCT_CATEGORY_CODE</xsl:with-param>
									<xsl:with-param name="name">product_category_code_label</xsl:with-param>
									<xsl:with-param name="swift-validate">N</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									<xsl:with-param name="size">35</xsl:with-param>
									<xsl:with-param name="maxsize">35</xsl:with-param>
									<xsl:with-param name="readonly">Y</xsl:with-param>
									<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
						
						<!-- Product Category other type -->
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DETAILS_PO_PRODUCT_CATEGORY_OTHER_CODE</xsl:with-param>
							<xsl:with-param name="name">product_category_other_code</xsl:with-param>
							<xsl:with-param name="swift-validate">N</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="readonly">Y</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>
						<!-- Product Category description -->
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DETAILS_PO_PRODUCT_CATEGORY_DESCRIPTION</xsl:with-param>
							<xsl:with-param name="name">product_category_description</xsl:with-param>
							<xsl:with-param name="swift-validate">N</xsl:with-param>
							<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>
						<div class="dijitDialogPaneActionBar">
						<xsl:call-template name="label-wrapper">
							<xsl:with-param name="content">
								<button type="button" dojoType="dijit.form.Button">
									<xsl:attribute name="onmouseup">dijit.byId('product-category-dialog-template').hide();</xsl:attribute>
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
								</button>
								<xsl:if test="$displaymode='edit'">
									<button dojoType="dijit.form.Button">
										<xsl:attribute name="onClick">dijit.byId('product-category-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
									</button>
								</xsl:if>								
							</xsl:with-param>
						</xsl:call-template>
						</div>
					</div>
			</div>

		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Product category declaration</xd:short>
		<xd:detail>
			This displayes message if no product category is available else adds button to add product category
 		</xd:detail> 		
 	</xd:doc>
	<xsl:template name="product-categories-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="product-category-dialog-declaration" />
		<!-- Dialog End -->
		<div id="product-categories-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_DETAILS_PO_NO_PRODUCT_CATEGORY')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<!--
TODO: Only possible if PO currency is selected (total_cur_code)
-->
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_PRODUCT_CATEGORY')" />
				</button>
			</div>
		</div>
	</xsl:template>

	<!-- <xsl:template name="build-product-categories-json">
		<xsl:param name="items" />
		<xsl:if test="$items">
			{items: [<xsl:for-each select="$items"><xsl:variable name="productCategory" select="." />{goods_id: '<xsl:value-of select="$productCategory/goods_id" />',ref_id: '<xsl:value-of select="$productCategory/ref_id" />',tnx_id: '<xsl:value-of select="$productCategory/tnx_id" />',type: '<xsl:value-of select="$productCategory/type" />',other_type: '<xsl:value-of select="$productCategory/other_type" />',description: '<xsl:value-of select="$productCategory/category" />'},</xsl:for-each>{}]}
		</xsl:if>
	</xsl:template>-->

	<!-- ProductCategories - Dojo objects -->
	<xd:doc>
		<xd:short>Build product category</xd:short>
		<xd:detail>
			This displayes header to add,update and view the product category details,adds headers code and discription
			 and adds different attributes of product category and fills it with given selected value.
 		</xd:detail>
 		<xd:param name="items"> Items to be build to form display</xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">display mode can be overriden in edit form.</xd:param>		
 	</xd:doc>
	<xsl:template name="build-product-categories-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->

		<div dojoType="misys.openaccount.widget.ProductCategories"
			dialogId="product-category-dialog-template">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_PRODUCT_CATEGORY')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_EDIT_PRODUCT_CATEGORY')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_VIEW_PRODUCT_CATEGORY')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_PRODUCT_CATEGORY_CODE')" />,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_PRODUCT_CATEGORY_DESCRIPTION')" />
			</xsl:attribute>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
			 <xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="productCategory" select="." />
					<div dojoType="misys.openaccount.widget.ProductCategory">
						<xsl:attribute name="goods_id"><xsl:value-of
							select="$productCategory/goods_id" /></xsl:attribute>
						<xsl:attribute name="ref_id"><xsl:value-of
							select="$productCategory/ref_id" /></xsl:attribute>
						<xsl:attribute name="tnx_id"><xsl:value-of
							select="$productCategory/tnx_id" /></xsl:attribute>
						<xsl:attribute name="type"><xsl:value-of
							select="$productCategory/type" /></xsl:attribute>
						<xsl:attribute name="type_label"><xsl:value-of select="localization:getDecode($language, 'N221', $productCategory/type)" /></xsl:attribute>
						<xsl:attribute name="other_type"><xsl:value-of
							select="$productCategory/other_type" /></xsl:attribute>
						<xsl:attribute name="description"><xsl:value-of
							select="$productCategory/category" /></xsl:attribute>
						<xsl:attribute name="is_valid"><xsl:value-of
							select="$productCategory/is_valid" /></xsl:attribute>
					</div>
				</xsl:for-each>
			</xsl:if>
		</div>

	</xsl:template>

	<!-- Product identifier codes -->
	<xd:doc>
		<xd:short>Product category</xd:short>
		<xd:detail>
			This displayes product categories codes in drop down.
 		</xd:detail> 
 		<xd:param name="field-name">Name of the field in the form submission</xd:param>		
 	</xd:doc>
	<xsl:template name="product-category-codes">
	<xsl:param name="field-name"/>
	 <xsl:choose>
        <xsl:when test="$displaymode='edit'">
		<option value="HRTR">
			<xsl:value-of select="localization:getDecode($language, 'N221', 'HRTR')" />
		</option>
		<option value="QOTA">
			<xsl:value-of select="localization:getDecode($language, 'N221', 'QOTA')" />
		</option>
		<option value="PRGP">
			<xsl:value-of select="localization:getDecode($language, 'N221', 'PRGP')" />
		</option>
		<option value="LOBU">
			<xsl:value-of select="localization:getDecode($language, 'N221', 'LOBU')" />
		</option>
		<option value="GNDR">
			<xsl:value-of select="localization:getDecode($language, 'N221', 'GNDR')" />
		</option>
		<option value="OTHR">
			<xsl:value-of select="localization:getDecode($language, 'N221', 'OTHR')" />
		</option>
		 </xsl:when>
        <xsl:otherwise>
         <xsl:choose>
          <xsl:when test="$field-name = 'HRTR'"><xsl:value-of select="localization:getDecode($language, 'N221', 'HRTR')" /></xsl:when>
          <xsl:when test="$field-name = 'QOTA'"><xsl:value-of select="localization:getDecode($language, 'N221', 'QOTA')" /></xsl:when>
          <xsl:when test="$field-name = 'PRGP'"><xsl:value-of select="localization:getDecode($language, 'N221', 'PRGP')" /></xsl:when>
          <xsl:when test="$field-name = 'LOBU'"><xsl:value-of select="localization:getDecode($language, 'N221', 'LOBU')" /></xsl:when>
          <xsl:when test="$field-name = 'GNDR'"><xsl:value-of select="localization:getDecode($language, 'N221', 'GNDR')" /></xsl:when>
          <xsl:otherwise><xsl:value-of select="localization:getDecode($language, 'N221', 'OTHR')" /></xsl:otherwise>
         </xsl:choose>
        </xsl:otherwise>
       </xsl:choose>
	</xsl:template>

	<!-- *********************** -->
	<!-- Product Characteristics -->
	<!-- *********************** -->
	<!-- Template for the declaration of line items -->
	<xd:doc>
		<xd:short>product charecteristic dialog declaration</xd:short>
		<xd:detail>
			This template adds different parameter for different template called inside this,Also adds CANCEL and OK button at the end of dialog
 		</xd:detail> 
 		<xd:param name="field-name">Name of the field in the form submission</xd:param>		
 	</xd:doc>
	<xsl:template name="product-characteristic-dialog-declaration">
		<div id="product-characteristic-dialog-template" style="display:none"
			class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>

			<div class="standardPODialogContent">
					<div>
						<!-- Product Category Code -->
						<xsl:choose>
							<xsl:when test="$displaymode = 'edit'">
								<xsl:call-template name="select-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_PRODUCT_CHARACTERISTIC_CODE</xsl:with-param>
									<xsl:with-param name="name">product_characteristic_code</xsl:with-param>
									<xsl:with-param name="required">Y</xsl:with-param>
									<xsl:with-param name="options">
										<xsl:call-template name="product-characteristic-codes" />
									</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="hidden-field">
									<xsl:with-param name="name">product_characteristic_code_label</xsl:with-param>							
									<xsl:with-param name="value">
										<xsl:choose>
											<xsl:when test="product_characteristic_code"><xsl:value-of select="localization:getDecode($language, 'N222', product_characteristic_code)" /></xsl:when>
											<xsl:otherwise></xsl:otherwise>
										</xsl:choose>
									</xsl:with-param>							
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_PRODUCT_CHARACTERISTIC_CODE</xsl:with-param>
									<xsl:with-param name="name">product_characteristic_code_label</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									<xsl:with-param name="swift-validate">N</xsl:with-param>
									<xsl:with-param name="size">35</xsl:with-param>
									<xsl:with-param name="maxsize">35</xsl:with-param>
									<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
						
						<!-- Product Category other type -->
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DETAILS_PO_PRODUCT_CHARACTERISTIC_OTHER_CODE</xsl:with-param>
							<xsl:with-param name="name">product_characteristic_other_code</xsl:with-param>
							<xsl:with-param name="swift-validate">N</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="readonly">Y</xsl:with-param>
							<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>
						<!-- Product Category description -->
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DETAILS_PO_PRODUCT_CHARACTERISTIC_DESCRIPTION</xsl:with-param>
							<xsl:with-param name="name">product_characteristic_description</xsl:with-param>
							<xsl:with-param name="swift-validate">N</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>
						<div class="dijitDialogPaneActionBar">
						<xsl:call-template name="label-wrapper">
							<xsl:with-param name="content">
								<button type="button" dojoType="dijit.form.Button">
									<xsl:attribute name="onmouseup">dijit.byId('product-characteristic-dialog-template').hide();</xsl:attribute>
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
								</button>
								<xsl:if test="$displaymode = 'edit'">
									<button dojoType="dijit.form.Button">
										<xsl:attribute name="onClick">dijit.byId('product-characteristic-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
									</button>
								</xsl:if>								
							</xsl:with-param>
						</xsl:call-template>
						</div>
					</div>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>product characteristic declaration</xd:short>
		<xd:detail>
			This add button to add product charecteristic and also displayes message if no product characteristic are present.
 		</xd:detail> 	
 	</xd:doc>
	<xsl:template name="product-characteristics-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="product-characteristic-dialog-declaration" />
		<!-- Dialog End -->
		<div id="product-characteristics-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_DETAILS_PO_NO_PRODUCT_CHARACTERISTIC')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<!--
TODO: Only possible if PO currency is selected (total_cur_code)
-->
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_PRODUCT_CHARACTERISTIC')" />
				</button>
			</div>
		</div>
	</xsl:template>

	<!-- <xsl:template name="build-product-characteristics-json">
		<xsl:param name="items" />
			<xsl:if test="$items">
				{items: [<xsl:for-each select="$items"><xsl:variable name="productCharacteristic" select="." />{goods_id: '<xsl:value-of select="$productCharacteristic/goods_id" />',ref_id: '<xsl:value-of select="$productCharacteristic/ref_id" />',tnx_id: '<xsl:value-of select="$productCharacteristic/tnx_id" />',type: '<xsl:value-of select="$productCharacteristic/type" />',other_type: '<xsl:value-of select="$productCharacteristic/other_type" />',description: '<xsl:value-of select="$productCharacteristic/characteristic" />'},</xsl:for-each>{}]}
			</xsl:if>
	</xsl:template>-->

	<!-- ProductCharacteristics - Dojo objects -->
	<xd:doc>
		<xd:short>build product charecteristic</xd:short>
		<xd:detail>
			This add input and select field for product charecteristic code etc
 		</xd:detail> 
 		<xd:param name="items">Items to be build to form display</xd:param>
 		<xd:param name="id">ID of the input field used in form submission</xd:param>
 		<xd:param name="override-displaymode">Defaults to value of displaymode</xd:param>
 	</xd:doc>
	<xsl:template name="build-product-characteristics-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->

		<div dojoType="misys.openaccount.widget.ProductCharacteristics"
			dialogId="product-characteristic-dialog-template" id="product-characteristics">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_PRODUCT_CHARACTERISTIC')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_EDIT_PRODUCT_CHARACTERISTIC')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_VIEW_PRODUCT_CHARACTERISTIC')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_PRODUCT_CHARACTERISTIC_CODE')" />,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_PRODUCT_CHARACTERISTIC_DESCRIPTION')" />
			</xsl:attribute>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
			 <xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="productCharacteristic" select="." />
					<div dojoType="misys.openaccount.widget.ProductCharacteristic">
						<xsl:attribute name="goods_id"><xsl:value-of
							select="$productCharacteristic/goods_id" /></xsl:attribute>
						<xsl:attribute name="ref_id"><xsl:value-of
							select="$productCharacteristic/ref_id" /></xsl:attribute>
						<xsl:attribute name="tnx_id"><xsl:value-of
							select="$productCharacteristic/tnx_id" /></xsl:attribute>
						<xsl:attribute name="type"><xsl:value-of
							select="$productCharacteristic/type" /></xsl:attribute>
						<xsl:attribute name="type_label"><xsl:value-of 
							select="localization:getDecode($language, 'N222', $productCharacteristic/type)" /></xsl:attribute>
						<xsl:attribute name="other_type"><xsl:value-of
							select="$productCharacteristic/other_type" /></xsl:attribute>
						<xsl:attribute name="description"><xsl:value-of
							select="$productCharacteristic/characteristic" /></xsl:attribute>
					</div>
				</xsl:for-each>
			</xsl:if>
		</div>

	</xsl:template>

	<!-- Product characteristic codes -->
	<xd:doc>
		<xd:short>Product Charecteristic Codes </xd:short>
		<xd:detail>
			This displayes different product charecteristic codes available in drop down
 		</xd:detail>
 		<xd:param name="field-name"> </xd:param>
 	</xd:doc>
	<xsl:template name="product-characteristic-codes">
		<xsl:param name="field-name"/>
		
		<xsl:choose>
			<xsl:when test="$displaymode = 'edit'">
				<option value="BISP">
					<xsl:value-of select="localization:getDecode($language, 'N222', 'BISP')" />
				</option>
				<option value="CHNR">
					<xsl:value-of select="localization:getDecode($language, 'N222', 'CHNR')" />
				</option>
				<option value="CLOR">
					<xsl:value-of select="localization:getDecode($language, 'N222', 'CLOR')" />
				</option>
				<option value="EDSP">
					<xsl:value-of select="localization:getDecode($language, 'N222', 'EDSP')" />
				</option>
				<option value="ENNR">
					<xsl:value-of select="localization:getDecode($language, 'N222', 'ENNR')" />
				</option>
				<option value="OPTN">
					<xsl:value-of select="localization:getDecode($language, 'N222', 'OPTN')" />
				</option>
				<option value="ORCR">
					<xsl:value-of select="localization:getDecode($language, 'N222', 'ORCR')" />
				</option>
				<option value="PCTV">
					<xsl:value-of select="localization:getDecode($language, 'N222', 'PCTV')" />
				</option>
				<option value="SISP">
					<xsl:value-of select="localization:getDecode($language, 'N222', 'SISP')" />
				</option>
				<option value="SIZE">
					<xsl:value-of select="localization:getDecode($language, 'N222', 'SIZE')" />
				</option>
				<option value="SZRG">
					<xsl:value-of select="localization:getDecode($language, 'N222', 'SZRG')" />
				</option>
				<option value="SPRM">
					<xsl:value-of select="localization:getDecode($language, 'N222', 'SPRM')" />
				</option>
				<option value="STOR">
					<xsl:value-of select="localization:getDecode($language, 'N222', 'STOR')" />
				</option>
				<option value="VINR">
					<xsl:value-of select="localization:getDecode($language, 'N222', 'VINR')" />
				</option>
				<option value="OTHR">
					<xsl:value-of select="localization:getDecode($language, 'N222', 'OTHR')" />
				</option>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$field-name = 'BISP'"><xsl:value-of select="localization:getDecode($language, 'N222', 'BISP')" /></xsl:when>
					<xsl:when test="$field-name = 'CHNR'"><xsl:value-of select="localization:getDecode($language, 'N222', 'CHNR')" /></xsl:when>
					<xsl:when test="$field-name = 'CLOR'"><xsl:value-of select="localization:getDecode($language, 'N222', 'CLOR')" /></xsl:when>
					<xsl:when test="$field-name = 'EDSP'"><xsl:value-of select="localization:getDecode($language, 'N222', 'EDSP')" /></xsl:when>
					<xsl:when test="$field-name = 'ENNR'"><xsl:value-of select="localization:getDecode($language, 'N222', 'ENNR')" /></xsl:when>
					<xsl:when test="$field-name = 'OPTN'"><xsl:value-of select="localization:getDecode($language, 'N222', 'OPTN')" /></xsl:when>
					<xsl:when test="$field-name = 'ORCR'"><xsl:value-of select="localization:getDecode($language, 'N222', 'ORCR')" /></xsl:when>
					<xsl:when test="$field-name = 'PCTV'"><xsl:value-of select="localization:getDecode($language, 'N222', 'PCTV')" /></xsl:when>
					<xsl:when test="$field-name = 'SISP'"><xsl:value-of select="localization:getDecode($language, 'N222', 'SISP')" /></xsl:when>
					<xsl:when test="$field-name = 'SIZE'"><xsl:value-of select="localization:getDecode($language, 'N222', 'SIZE')" /></xsl:when>
					<xsl:when test="$field-name = 'SZRG'"><xsl:value-of select="localization:getDecode($language, 'N222', 'SZRG')" /></xsl:when>
					<xsl:when test="$field-name = 'SPRM'"><xsl:value-of select="localization:getDecode($language, 'N222', 'SPRM')" /></xsl:when>
					<xsl:when test="$field-name = 'STOR'"><xsl:value-of select="localization:getDecode($language, 'N222', 'STOR')" /></xsl:when>
					<xsl:when test="$field-name = 'VINR'"><xsl:value-of select="localization:getDecode($language, 'N222', 'VINR')" /></xsl:when>
					<xsl:when test="$field-name = 'OTHR'"><xsl:value-of select="localization:getDecode($language, 'N222', 'OTHR')" /></xsl:when>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>

	<!-- ********** -->
	<!-- Line Items -->
	<!-- ********** -->
	<!-- *********** -->
	<!-- Adjustments -->
	<!-- *********** -->
	<!-- Template for the declaration of line items -->
	<xd:doc>
		<xd:short>Adjustment dialogue </xd:short>
		<xd:detail>
			This template adds different parameter for different template called inside this,Also adds CANCEL and OK button at the end of dialog
 		</xd:detail>
 	</xd:doc>
	<xsl:template name="adjustment-dialog-declaration">
		<div id="adjustment-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>

			<div class="standardPODialogContent">
						<!-- Adjustment Code -->
						<xsl:choose>
							<xsl:when test="$displaymode = 'edit'">
								<xsl:call-template name="hidden-field">
									<xsl:with-param name="name">adjustment_type_label</xsl:with-param>							
									<xsl:with-param name="value">
										<xsl:choose>
											<xsl:when test="adjustment_type"><xsl:value-of select="localization:getDecode($language, 'N210', adjustment_type)" /></xsl:when>
											<xsl:otherwise></xsl:otherwise>
										</xsl:choose>
									</xsl:with-param>							
								</xsl:call-template>
								<xsl:call-template name="select-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_ADJUSTMENT_TYPE</xsl:with-param>
									<xsl:with-param name="name">adjustment_type</xsl:with-param>
									<xsl:with-param name="required">Y</xsl:with-param>
									<xsl:with-param name="options">
										<xsl:call-template name="adjustment-codes" >
										<xsl:with-param name="field-name">adjustment_type</xsl:with-param>
										</xsl:call-template>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_ADJUSTMENT_TYPE</xsl:with-param>
									<xsl:with-param name="name">adjustment_type_label</xsl:with-param>
									<xsl:with-param name="swift-validate">N</xsl:with-param>
									<xsl:with-param name="size">35</xsl:with-param>
									<xsl:with-param name="maxsize">35</xsl:with-param>
									<xsl:with-param name="readonly">Y</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:call-template name="hidden-field">
					    	<xsl:with-param name="name">type_hidden</xsl:with-param>	    
					     	<xsl:with-param name="value">
					     	 	<xsl:choose>
									<xsl:when test="adjustment_type[.='OTHR']"><xsl:value-of select="adjustment_other_type" /></xsl:when>
									<xsl:otherwise><xsl:value-of select="localization:getDecode($language, 'N210', adjustment_type)" /></xsl:otherwise>
								</xsl:choose>
					     	</xsl:with-param>  
					     </xsl:call-template>
							<!-- Adjustment : Credit note reference id -->
						<xsl:if test="product_code[.='IN' or .='IP']">
							<xsl:choose>
								<xsl:when test="adjustments/adjustment/cn_reference_id[.!='']">
									<xsl:call-template name="input-field">
										<xsl:with-param name="label">XSL_CN_REFERENCE</xsl:with-param>
										<xsl:with-param name="name">cn_reference_id</xsl:with-param>
										<xsl:with-param name="swift-validate">N</xsl:with-param>
										<xsl:with-param name="size">20</xsl:with-param>
										<xsl:with-param name="maxsize">20</xsl:with-param>
										<xsl:with-param name="readonly">N</xsl:with-param>
										<xsl:with-param name="override-displaymode">edit</xsl:with-param>
										<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										<xsl:with-param name="value"><xsl:value-of select = "adjustments/adjustment/cn_reference_id"/></xsl:with-param>
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_CN_REFERENCE</xsl:with-param>
									<xsl:with-param name="name">cn_reference_id</xsl:with-param>
									<xsl:with-param name="swift-validate">N</xsl:with-param>
									<xsl:with-param name="size">20</xsl:with-param>
									<xsl:with-param name="maxsize">20</xsl:with-param>
									<xsl:with-param name="readonly">N</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									<xsl:with-param name="value"><xsl:value-of select = "line_items/lt_tnx_record/adjustments/allowance/cn_reference_id"/></xsl:with-param>
								</xsl:call-template>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:if>
						<!-- Adjustment other type -->
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DETAILS_PO_PRODUCT_CHARACTERISTIC_OTHER_CODE</xsl:with-param>
							<xsl:with-param name="name">adjustment_other_type</xsl:with-param>
							<xsl:with-param name="swift-validate">N</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="readonly">Y</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>
						<!-- Adjustment direction -->
						<xsl:choose>
							<xsl:when test="$displaymode = 'edit'">
								<xsl:call-template name="multioption-group">
									<xsl:with-param name="group-label">XSL_DETAILS_PO_ADJUSTMENT_DIRECTION</xsl:with-param>
									<xsl:with-param name="content">
										<xsl:call-template name="radio-field">
											<xsl:with-param name="label">N216_ADDD</xsl:with-param>
											<xsl:with-param name="name">adjustment_direction</xsl:with-param>
											<xsl:with-param name="id">adjustment_direction_1</xsl:with-param>
											<xsl:with-param name="value">ADDD</xsl:with-param>
										</xsl:call-template>
										<xsl:call-template name="radio-field">
											<xsl:with-param name="label">N216_SUBS</xsl:with-param>
											<xsl:with-param name="name">adjustment_direction</xsl:with-param>
											<xsl:with-param name="id">adjustment_direction_2</xsl:with-param>
											<xsl:with-param name="value">SUBS</xsl:with-param>
										</xsl:call-template>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_ADJUSTMENT_DIRECTION</xsl:with-param>
									<xsl:with-param name="name">adjustment_direction_label</xsl:with-param>
									<xsl:with-param name="value"><xsl:value-of select="localization:getDecode($language, 'N216', adjustment_direction_label)"/></xsl:with-param>
									<xsl:with-param name="swift-validate">N</xsl:with-param>
									<xsl:with-param name="size">35</xsl:with-param>
									<xsl:with-param name="maxsize">35</xsl:with-param>
									<xsl:with-param name="readonly">Y</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
						
						<!-- Adjustment Amount -->
						<xsl:choose>
							<xsl:when test="$displaymode = 'edit'">
								<xsl:call-template name="currency-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_ADJUSTMENT_AMT</xsl:with-param>
									<xsl:with-param name="override-currency-name">adjustment_cur_code</xsl:with-param>
									<xsl:with-param name="override-amt-name">adjustment_amt</xsl:with-param>
									<xsl:with-param name="override-product-code">adjustment</xsl:with-param>
									<xsl:with-param name="required">Y</xsl:with-param>
									<xsl:with-param name="currency-readonly">Y</xsl:with-param>
									<xsl:with-param name="show-button">N</xsl:with-param>
									<xsl:with-param name="regular-expression">^(?:\d{1,18}|(?=.*\.)(?!.*\..*\.)[\d.]{1,19})$</xsl:with-param>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="currency-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_ADJUSTMENT_AMT</xsl:with-param>
									<xsl:with-param name="override-currency-name">adjustment_cur_code</xsl:with-param>
									<xsl:with-param name="override-amt-name">adjustment_amt</xsl:with-param>
									<xsl:with-param name="show-button">N</xsl:with-param>
									<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									<xsl:with-param name="currency-readonly">Y</xsl:with-param>
									<xsl:with-param name="override-currency-displaymode">edit</xsl:with-param>
									<xsl:with-param name="amt-readonly">Y</xsl:with-param>
									<xsl:with-param name="override-amt-displaymode">edit</xsl:with-param>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
						<!-- Adjustment rate -->
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DETAILS_PO_ADJUSTMENT_RATE</xsl:with-param>
							<xsl:with-param name="name">adjustment_rate</xsl:with-param>
							<xsl:with-param name="swift-validate">N</xsl:with-param>
							<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							<xsl:with-param name="regular-expression">^(?:\d{1,11}|(?=.*\.)(?!.*\..*\.)[\d.]{1,12})$</xsl:with-param>
						</xsl:call-template>
						<xsl:if test="(($fscm_cash_customization_enable = 'true') and ( product_code[.='IN'] or ($displaymode = 'view' and product_code[.='IP'])))">
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
							<xsl:with-param name="name">discount_exp_date</xsl:with-param>
							<xsl:with-param name="type">date</xsl:with-param>
							<xsl:with-param name="size">10</xsl:with-param>
							<xsl:with-param name="maxsize">10</xsl:with-param>
							<xsl:with-param name="fieldsize">small</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
						</xsl:call-template>
						</xsl:if>
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">cashCustomizationEnable</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="$fscm_cash_customization_enable"/></xsl:with-param>							
						</xsl:call-template>

						<div class="dijitDialogPaneActionBar">
						<xsl:call-template name="label-wrapper">
							<xsl:with-param name="content">
								<button type="button" dojoType="dijit.form.Button">
									<xsl:attribute name="onmouseup">dijit.byId('adjustment-dialog-template').hide();</xsl:attribute>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
								</button>
								<xsl:if test="$displaymode = 'edit'">
									<button dojoType="dijit.form.Button">
										<xsl:attribute name="onClick">dijit.byId('adjustment-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
										<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
									</button>
								</xsl:if>								
							</xsl:with-param>
						</xsl:call-template>
						</div>
				</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Adjustment declaration </xd:short>
		<xd:detail>
			This templates displays message if there is NO Adjustment or else add button to add adjustment
 		</xd:detail>
 	</xd:doc>
	<xsl:template name="adjustments-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="adjustment-dialog-declaration" />
		<!-- Dialog End -->
		<div id="adjustments-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_NO_ADJUSTMENT')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<!--
TODO: Only possible if PO currency is selected (total_cur_code)
-->
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_ADJUSTMENT')" />
				</button>
			</div>
		</div>
	</xsl:template>

	<!-- Adjustments - Dojo objects -->
	<xd:doc>
		<xd:short>Build adjustment items</xd:short>
		<xd:detail>
			This templates displayes label for the table for adjustment type,cur-code,amount/rate,it also displayed header in case of adding updating and viewing adjustment,adds different attribute to
			adjustment widget.
 		</xd:detail>
 		<xd:param name="items">Items to be build to form display</xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">Overridden display mode.Shows in edit mode of the parent form</xd:param>
 	</xd:doc>
	<xsl:template name="build-adjustments-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->

		<div dojoType="misys.openaccount.widget.Adjustments" dialogId="adjustment-dialog-template">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_ADJUSTMENT')"/></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_EDIT_ADJUSTMENT')"/></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_VIEW_ADJUSTMENT')"/></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ADJUSTMENT_TYPE')" />,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ADJUSTMENT_CUR_CODE')" />,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_ADJUSTMENT_AMOUNT_OR_RATE')" />
			</xsl:attribute>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
			 <xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="adjustment" select="." />
					<div dojoType="misys.openaccount.widget.Adjustment">
						<xsl:attribute name="ref_id"><xsl:value-of select="$adjustment/ref_id" /></xsl:attribute>
						<xsl:attribute name="tnx_id"><xsl:value-of select="$adjustment/tnx_id" /></xsl:attribute>
						<xsl:attribute name="allowance_id"><xsl:value-of select="$adjustment/allowance_id" /></xsl:attribute>
						<xsl:attribute name="type"><xsl:value-of select="$adjustment/type" /></xsl:attribute>
						<xsl:attribute name="type_label">
							<xsl:value-of select="localization:getDecode($language, 'N210', $adjustment/type)" />
						</xsl:attribute>
						<xsl:attribute name="other_type"><xsl:value-of select="$adjustment/other_type" /></xsl:attribute>
						<xsl:attribute name="direction"><xsl:value-of select="$adjustment/direction" /></xsl:attribute>
						<xsl:attribute name="direction_label">
							<xsl:value-of select="localization:getDecode($language, 'N216', $adjustment/direction)" />
						</xsl:attribute>
						<xsl:attribute name="cur_code"><xsl:value-of select="$adjustment/cur_code" /></xsl:attribute>
						<xsl:attribute name="amt"><xsl:value-of select="$adjustment/amt" /></xsl:attribute>
						<xsl:attribute name="rate"><xsl:value-of select="$adjustment/rate" /></xsl:attribute>
						<xsl:attribute name="is_valid"><xsl:value-of select="$adjustment/is_valid" /></xsl:attribute>
						<xsl:attribute name="cn_reference_id"><xsl:value-of select="$adjustment/cn_reference_id" /></xsl:attribute>
						<xsl:attribute name="discount_exp_date"><xsl:value-of select="$adjustment/discount_exp_date" /></xsl:attribute>	
						<xsl:attribute name="type_hidden">
							<xsl:choose>
								<xsl:when test="$adjustment/type[.='OTHR']"><xsl:value-of select="$adjustment/other_type" /></xsl:when>
								<xsl:otherwise><xsl:value-of select="localization:getDecode($language, 'N210', $adjustment/type)" /></xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
					</div>
				</xsl:for-each>
			</xsl:if>
		</div>

	</xsl:template>
	<!-- Adjustment codes -->
	<xd:doc>
		<xd:short>Adjustment codes</xd:short>
		<xd:detail>
			This templates displayes values of adjustment type available in drop down.
 		</xd:detail>
 		<xd:param name="field-name">Displayed name of the field in the form</xd:param>
 	</xd:doc>
	<xsl:template name="adjustment-codes">
	<xsl:param name="field-name"/>
	 <xsl:choose>
        <xsl:when test="$displaymode='edit'">
		<option value="REBA">
			<xsl:value-of select="localization:getDecode($language, 'N210', 'REBA')" />
		</option>
		<xsl:choose>
		<xsl:when test="$fscm_cash_customization_enable ='true'">
		<xsl:if test="product_code[.!= 'IP']">
		<option value="DISC">
			<xsl:value-of select="localization:getDecode($language, 'N210', 'DISC')" />
		</option>
		</xsl:if>
		</xsl:when>
		<xsl:otherwise>
		<option value="DISC">
			<xsl:value-of select="localization:getDecode($language, 'N210', 'DISC')" />
		</option>
		</xsl:otherwise>
		</xsl:choose>
		<option value="CREN">
			<xsl:value-of select="localization:getDecode($language, 'N210', 'CREN')" />
		</option>
		<xsl:if test="product_code[.!= 'IO' and .!='EA'] ">
			<option value="DEBN">
				<xsl:value-of select="localization:getDecode($language, 'N210', 'DEBN')" />
			</option>
		</xsl:if>
		<xsl:if test="product_code[.= 'IO' or .='EA'] ">
			<option value="SURC">
				<xsl:value-of select="localization:getDecode($language, 'N210', 'SURC')" />
			</option>
		</xsl:if>
		<option value="OTHR">
			<xsl:value-of select="localization:getDecode($language, 'N210', 'OTHR')" />
		</option>
		 </xsl:when>
        <xsl:otherwise>
         <xsl:choose>
          <xsl:when test="$field-name = 'REBA'"><xsl:value-of select="localization:getDecode($language, 'N210', 'REBA')" /></xsl:when>
          <xsl:when test="$field-name = 'DISC'"><xsl:value-of select="localization:getDecode($language, 'N210', 'DISC')" /></xsl:when>
          <xsl:when test="$field-name = 'CREN'"><xsl:value-of select="localization:getDecode($language, 'N210', 'CREN')" /></xsl:when>
          <xsl:when test="$field-name = 'DEBN'"><xsl:value-of select="localization:getDecode($language, 'N210', 'DEBN')" /></xsl:when>
          <xsl:otherwise><xsl:value-of select="localization:getDecode($language, 'N210', 'OTHR')" /></xsl:otherwise>
         </xsl:choose>
        </xsl:otherwise>
       </xsl:choose>
	</xsl:template>
	
	<!-- *********** -->
	<!-- Adjustments -->
	<!-- *********** -->

	<!-- ***** -->
	<!-- Taxes -->
	<!-- ***** -->
	<!-- Template for the declaration of line items -->
	<xd:doc>
		<xd:short>Tax dialog declaration</xd:short>
		<xd:detail>
			This template adds different parameter for different template called inside this,Also adds CANCEL and OK button at the end of dialog
 		</xd:detail>
 		<xd:param name="field-name">Displayed name of the field in the form</xd:param>
 	</xd:doc>
	<xsl:template name="tax-dialog-declaration">
		<div id="tax-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>

			<div class="standardPODialogContent">
						<!-- Tax Code -->
						<xsl:choose>
							<xsl:when test="$displaymode = 'edit'">
								<xsl:call-template name="hidden-field">
									<xsl:with-param name="name">tax_type_label</xsl:with-param>							
									<xsl:with-param name="value">
										<xsl:choose>
											<xsl:when test="tax_type"><xsl:value-of select="localization:getDecode($language, 'N210', tax_type)" /></xsl:when>
											<xsl:otherwise></xsl:otherwise>
										</xsl:choose>
									</xsl:with-param>							
								</xsl:call-template>
								<xsl:call-template name="select-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_TAX_TYPE</xsl:with-param>
									<xsl:with-param name="name">tax_type</xsl:with-param>
									<xsl:with-param name="required">Y</xsl:with-param>
									<xsl:with-param name="options">
										<xsl:call-template name="tax-codes" >
										<xsl:with-param name="field-name">tax_type</xsl:with-param>
										</xsl:call-template>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_TAX_TYPE</xsl:with-param>
									<xsl:with-param name="name">tax_type_label</xsl:with-param>
									<xsl:with-param name="swift-validate">N</xsl:with-param>
									<xsl:with-param name="size">12</xsl:with-param>
									<xsl:with-param name="maxsize">12</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
						
						<!-- Tax other type -->
						<xsl:call-template name="input-field">
							<xsl:with-param name="label"></xsl:with-param>
							<xsl:with-param name="name">tax_other_type</xsl:with-param>
							<xsl:with-param name="swift-validate">N</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="readonly">Y</xsl:with-param>
							<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>
						<!-- Tax Amount -->
						<div id="po_tax_amt_section">
							<xsl:choose>
								<xsl:when test="$displaymode = 'edit'">
									<xsl:call-template name="currency-field">
										<xsl:with-param name="label">XSL_DETAILS_PO_TAX_AMT</xsl:with-param>
										<xsl:with-param name="override-currency-name">tax_cur_code</xsl:with-param>
										<xsl:with-param name="override-product-code">tax</xsl:with-param>
										<xsl:with-param name="override-amt-name">tax_amt</xsl:with-param>
										<xsl:with-param name="currency-readonly">Y</xsl:with-param>
										<xsl:with-param name="override-displaymode">edit</xsl:with-param>
										<xsl:with-param name="required">Y</xsl:with-param>
										<xsl:with-param name="show-button">N</xsl:with-param>
										<xsl:with-param name="regular-expression">^(?:\d{1,18}|(?=.*\.)(?!.*\..*\.)[\d.]{1,19})$</xsl:with-param>
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<xsl:call-template name="currency-field">
										<xsl:with-param name="label">XSL_DETAILS_PO_TAX_AMT</xsl:with-param>
										<xsl:with-param name="override-currency-name">tax_cur_code</xsl:with-param>
										<xsl:with-param name="override-amt-name">tax_amt</xsl:with-param>
										<xsl:with-param name="show-button">N</xsl:with-param>
										<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
										<xsl:with-param name="currency-readonly">Y</xsl:with-param>
										<xsl:with-param name="override-currency-displaymode">edit</xsl:with-param>
										<xsl:with-param name="amt-readonly">Y</xsl:with-param>
										<xsl:with-param name="override-amt-displaymode">edit</xsl:with-param>
									</xsl:call-template>
								</xsl:otherwise>
							</xsl:choose>
						</div>
						<!-- Tax rate -->
						<div id="po_tax_rate_section">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_DETAILS_PO_TAX_RATE</xsl:with-param>
								<xsl:with-param name="name">tax_rate</xsl:with-param>
								<xsl:with-param name="swift-validate">N</xsl:with-param>
								<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
								<xsl:with-param name="override-displaymode">edit</xsl:with-param>
								<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								<xsl:with-param name="regular-expression">^(?:\d{1,11}|(?=.*\.)(?!.*\..*\.)[\d.]{1,12})$</xsl:with-param>
							</xsl:call-template>
						</div>
						<div class="dijitDialogPaneActionBar">
						<xsl:call-template name="label-wrapper">
							<xsl:with-param name="content">
								<button type="button" dojoType="dijit.form.Button">
									<xsl:attribute name="onmouseup">dijit.byId('tax-dialog-template').hide();</xsl:attribute>
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
								</button>
								<xsl:if test="$displaymode = 'edit'">
									<button dojoType="dijit.form.Button">
										<xsl:attribute name="onClick">dijit.byId('tax-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
									</button>
								</xsl:if>								
							</xsl:with-param>
						</xsl:call-template>
						</div>
				</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Tax declaration</xd:short>
		<xd:detail>
			This templates displayes message if no tax is displayes and add button to display taxes
 		</xd:detail>
 	</xd:doc>
	<xsl:template name="taxes-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="tax-dialog-declaration" />
		<!-- Dialog End -->
		<div id="taxes-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_DETAILS_PO_NO_TAX')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_TAX')" />
				</button>
			</div>
		</div>
	</xsl:template>

	<!-- <xsl:template name="build-taxes-json">
		<xsl:param name="items" />
		<xsl:if test="$items">{items: [<xsl:for-each select="$items"><xsl:variable name="tax" select="." />{ref_id: '<xsl:value-of select="$tax/ref_id" />',tnx_id: '<xsl:value-of select="$tax/tnx_id" />',allowance_id: '<xsl:value-of select="$tax/allowance_id" />',type: '<xsl:value-of select="$tax/type" />',other_type: '<xsl:value-of select="$tax/other_type" />',cur_code: '<xsl:value-of select="$tax/cur_code" />',amt: '<xsl:value-of select="$tax/amt" />',rate: '<xsl:value-of select="$tax/rate" />'},</xsl:for-each>{}]}
			</xsl:if>
	</xsl:template>-->
	
	<!-- Taxes - Dojo objects -->
	<xd:doc>
		<xd:short>Build Tax items</xd:short>
		<xd:detail>
			This templates displayes headers based on adding editing and viewing tax dialog in tax dialog popup,it also displayes headers on the grid,and adds different attributes to tax widget.
 		</xd:detail>
 		<xd:param name="items"> Items to be build to form display </xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">Overridden display mode.</xd:param>
 	</xd:doc>
	<xsl:template name="build-taxes-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->		

		<div dojoType="misys.openaccount.widget.Taxes" dialogId="tax-dialog-template">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_TAX')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_EDIT_TAX')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_VIEW_TAX')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_TAX_TYPE')" />,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_TAX_CUR_CODE')" />,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_TAX_AMOUNT_OR_RATE')" />
			</xsl:attribute>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
			<xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="tax" select="." />
					<div dojoType="misys.openaccount.widget.Tax">
						<xsl:attribute name="ref_id"><xsl:value-of
							select="$tax/ref_id" /></xsl:attribute>
						<xsl:attribute name="tnx_id"><xsl:value-of
							select="$tax/tnx_id" /></xsl:attribute>
						<xsl:attribute name="allowance_id"><xsl:value-of
							select="$tax/allowance_id" /></xsl:attribute>
						<xsl:attribute name="type"><xsl:value-of
							select="$tax/type" /></xsl:attribute>
						<xsl:attribute name="type_label">
							<xsl:value-of select="localization:getDecode($language, 'N210', $tax/type)" />
							</xsl:attribute>
						<xsl:attribute name="other_type"><xsl:value-of
							select="$tax/other_type" /></xsl:attribute>
						<xsl:attribute name="cur_code"><xsl:value-of
							select="$tax/cur_code" /></xsl:attribute>
						<xsl:attribute name="amt"><xsl:value-of
							select="$tax/amt" /></xsl:attribute>
						<xsl:attribute name="rate"><xsl:value-of
							select="$tax/rate" /></xsl:attribute>
						<xsl:attribute name="is_valid"><xsl:value-of
							select="$tax/is_valid" /></xsl:attribute>
					</div>
				</xsl:for-each>
 			</xsl:if> 
		</div>

	</xsl:template>

	<!-- Tax codes -->
	<xd:doc>
		<xd:short>Tax codes</xd:short>
		<xd:detail>
			This templates displayes different tax codes which is available in drop down.
 		</xd:detail>
 	</xd:doc>
	<xsl:template name="tax-codes">
	<xsl:param name="field-name"/>
	 <xsl:choose>
        <xsl:when test="$displaymode='edit'">
		<option value="COAX">
			<xsl:value-of select="localization:getDecode($language, 'N210', 'COAX')" />
		</option>
		<option value="CUST">
			<xsl:value-of select="localization:getDecode($language, 'N210', 'CUST')" />
		</option>
		<option value="NATI">
			<xsl:value-of select="localization:getDecode($language, 'N210', 'NATI')" />
		</option>
		<option value="PROV">
			<xsl:value-of select="localization:getDecode($language, 'N210', 'PROV')" />
		</option>
		<option value="STAM">
			<xsl:value-of select="localization:getDecode($language, 'N210', 'STAM')" />
		</option>
		<option value="STAT">
			<xsl:value-of select="localization:getDecode($language, 'N210', 'STAT')" />
		</option>
		<option value="VATA">
			<xsl:value-of select="localization:getDecode($language, 'N210', 'VATA')" />
		</option>
		<option value="WITH">
			<xsl:value-of select="localization:getDecode($language, 'N210', 'WITH')" />
		</option>
		<option value="OTHR">
			<xsl:value-of select="localization:getDecode($language, 'N210', 'OTHR')" />
		</option>
	 </xsl:when>
        <xsl:otherwise>
         <xsl:choose>
          <xsl:when test="$field-name = 'COAX'"><xsl:value-of select="localization:getDecode($language, 'N210', 'COAX')" /></xsl:when>
          <xsl:when test="$field-name = 'NATI'"><xsl:value-of select="localization:getDecode($language, 'N210', 'NATI')" /></xsl:when>
          <xsl:when test="$field-name = 'PROV'"><xsl:value-of select="localization:getDecode($language, 'N210', 'PROV')" /></xsl:when>
          <xsl:when test="$field-name = 'STAM'"><xsl:value-of select="localization:getDecode($language, 'N210', 'STAM')" /></xsl:when>
          <xsl:when test="$field-name = 'STAT'"><xsl:value-of select="localization:getDecode($language, 'N210', 'STAT')" /></xsl:when>
          <xsl:when test="$field-name = 'WITH'"><xsl:value-of select="localization:getDecode($language, 'N210', 'WITH')" /></xsl:when>
          <xsl:when test="$field-name = 'CUST'"><xsl:value-of select="localization:getDecode($language, 'N210', 'CUST')" /></xsl:when>
          <xsl:when test="$field-name = 'VATA'"><xsl:value-of select="localization:getDecode($language, 'N210', 'VATA')" /></xsl:when>
          <xsl:otherwise><xsl:value-of select="localization:getDecode($language, 'N210', 'OTHR')" /></xsl:otherwise>
         </xsl:choose>
        </xsl:otherwise>
       </xsl:choose>
	</xsl:template>
	
	<!-- ***** -->
	<!-- Taxes -->
	<!-- ***** -->

	<!-- ************** -->
	<!-- Freight Charge -->
	<!-- ************** -->
	<!-- Template for the declaration of line items -->
	<xd:doc>
		<xd:short>Freight Charge dialog</xd:short>
		<xd:detail>
			This templates displays freight charges type,amount,rate label and its properties such as size etc,also adds cancel and ok button in the dialog box.
 		</xd:detail>
 	</xd:doc>
	<xsl:template name="freight-charge-dialog-declaration">
		<div id="freight-charge-dialog-template" style="display:none"
			class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>

					<div>
						<!-- Tax Code -->
						<xsl:choose>
							<xsl:when test="$displaymode='edit'">
								<xsl:call-template name="select-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_FREIGHT_CHARGES_TYPE</xsl:with-param>
									<xsl:with-param name="name">freight_charge_type</xsl:with-param>
									<xsl:with-param name="required">Y</xsl:with-param>
									<xsl:with-param name="options">
										<xsl:call-template name="freight-charge-codes" >
											<xsl:with-param name="field-name">freight_charge_type</xsl:with-param>
										</xsl:call-template>
									</xsl:with-param>
								</xsl:call-template>
								<xsl:call-template name="hidden-field">
									<xsl:with-param name="name">freight_charge_type_label</xsl:with-param>							
									<xsl:with-param name="value">
										<xsl:choose>
											<xsl:when test="freight_charge_type"><xsl:value-of select="localization:getDecode($language, 'N210', freight_charge_type)" /></xsl:when>
											<xsl:otherwise></xsl:otherwise>
										</xsl:choose>
									</xsl:with-param>							
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_FREIGHT_CHARGES_TYPE</xsl:with-param>
									<xsl:with-param name="name">freight_charge_type_label</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
						
						<!-- Tax other type -->
						<xsl:call-template name="input-field">
							<xsl:with-param name="label"></xsl:with-param>
							<xsl:with-param name="name">freight_charge_other_type</xsl:with-param>
							<xsl:with-param name="swift-validate">N</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="readonly">Y</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>
						<!-- Tax Amount -->
						<xsl:choose>
							<xsl:when test="$displaymode='edit'">
								<xsl:call-template name="currency-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_FREIGHT_CHARGES_AMT</xsl:with-param>
									<xsl:with-param name="override-currency-name">freight_charge_cur_code</xsl:with-param>
									<xsl:with-param name="override-amt-name">freight_charge_amt</xsl:with-param>
									<xsl:with-param name="override-product-code">freight_charge</xsl:with-param>
									<xsl:with-param name="required">Y</xsl:with-param>
									<xsl:with-param name="currency-readonly">Y</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="show-button">N</xsl:with-param>
									<xsl:with-param name="regular-expression">^(?:\d{1,18}|(?=.*\.)(?!.*\..*\.)[\d.]{1,19})$</xsl:with-param>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="currency-field">
									<xsl:with-param name="label">XSL_DETAILS_PO_FREIGHT_CHARGES_AMT</xsl:with-param>
									<xsl:with-param name="override-currency-name">freight_charge_cur_code</xsl:with-param>
									<xsl:with-param name="override-amt-name">freight_charge_amt</xsl:with-param>
									<xsl:with-param name="show-button">N</xsl:with-param>
									<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									<xsl:with-param name="currency-readonly">Y</xsl:with-param>
									<xsl:with-param name="override-currency-displaymode">edit</xsl:with-param>
									<xsl:with-param name="amt-readonly">Y</xsl:with-param>
									<xsl:with-param name="override-amt-displaymode">edit</xsl:with-param>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
						<!-- Tax rate  -->
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DETAILS_PO_FREIGHT_CHARGES_RATE</xsl:with-param>
							<xsl:with-param name="name">freight_charge_rate</xsl:with-param>
							<xsl:with-param name="required"><xsl:if test="$displaymode='edit'">Y</xsl:if></xsl:with-param>
							<xsl:with-param name="swift-validate">N</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							<xsl:with-param name="regular-expression">^(?:\d{1,11}|(?=.*\.)(?!.*\..*\.)[\d.]{1,12})$</xsl:with-param>
						</xsl:call-template>
						<div class="dijitDialogPaneActionBar">
						<xsl:call-template name="label-wrapper">
							<xsl:with-param name="content">
								<button type="button" dojoType="dijit.form.Button">
									<xsl:attribute name="onmouseup">dijit.byId('freight-charge-dialog-template').hide();</xsl:attribute>
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
								</button>							
								<xsl:if test="$displaymode = 'edit'">
									<button dojoType="dijit.form.Button">
										<xsl:attribute name="onClick">dijit.byId('freight-charge-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
									</button>
								</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
						</div>
					</div>

		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Freight Charge declaration</xd:short>
		<xd:detail>
			This templates displays message of no freight charges and add button of add freight charges.
 		</xd:detail>
 	</xd:doc>
	<xsl:template name="freight-charges-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="freight-charge-dialog-declaration" />
		<!-- Dialog End -->
		<div id="freight-charges-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_DETAILS_PO_NO_FREIGHT_CHARGES')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_FREIGHT_CHARGES')" />
				</button>
			</div>
		</div>
	</xsl:template>


	<!-- <xsl:template name="build-freight-charges-json">
		<xsl:param name="items" />
		<xsl:if test="$items">{items: [<xsl:for-each select="$items"><xsl:variable name="freightCharge" select="." />{ref_id: '<xsl:value-of select="$freightCharge/ref_id" />',tnx_id: '<xsl:value-of select="$freightCharge/tnx_id" />',allowance_id: '<xsl:value-of select="$freightCharge/allowance_id" />',type: '<xsl:value-of select="$freightCharge/type" />',other_type: '<xsl:value-of select="$freightCharge/other_type" />',cur_code: '<xsl:value-of select="$freightCharge/cur_code" />',amt: '<xsl:value-of select="$freightCharge/amt" />',rate: '<xsl:value-of select="$freightCharge/rate" />'},</xsl:for-each>{}]}
			</xsl:if>
	</xsl:template>-->

	<!-- Freight Charges - Dojo objects -->
	<xd:doc>
		<xd:short>Build Freight Charge</xd:short>
		<xd:detail>
			This templates displays header for the freight charge in case of add edit and view mode,displayes header for the grid and adds different attributes to the freight charges.
 		</xd:detail>
 		<xd:param name="items"> Items to be build to form display </xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">Overridden display mode.Shows in edit mode of the parent form</xd:param>
 	</xd:doc>
	<xsl:template name="build-freight-charges-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
		
		<div dojoType="misys.openaccount.widget.FreightCharges" dialogId="freight-charge-dialog-template">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_FREIGHT_CHARGES')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_EDIT_FREIGHT_CHARGES')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_VIEW_FREIGHT_CHARGES')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_FREIGHT_CHARGES_TYPE')" />,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_FREIGHT_CHARGES_CUR_CODE')" />,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_FREIGHT_CHARGES_AMOUNT_OR_RATE')" />
			</xsl:attribute>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
			 <xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="freightCharge" select="." />
					<div dojoType="misys.openaccount.widget.FreightCharge">
						<xsl:attribute name="ref_id"><xsl:value-of
							select="$freightCharge/ref_id" /></xsl:attribute>
						<xsl:attribute name="tnx_id"><xsl:value-of
							select="$freightCharge/tnx_id" /></xsl:attribute>
						<xsl:attribute name="allowance_id"><xsl:value-of
							select="$freightCharge/allowance_id" /></xsl:attribute>
						<xsl:attribute name="type"><xsl:value-of
							select="$freightCharge/type" /></xsl:attribute>
						<xsl:attribute name="type_label">
							<xsl:value-of select="localization:getDecode($language, 'N210', $freightCharge/type)" />
							</xsl:attribute>
						<xsl:attribute name="other_type"><xsl:value-of
							select="$freightCharge/other_type" /></xsl:attribute>
						<xsl:attribute name="cur_code"><xsl:value-of
							select="$freightCharge/cur_code" /></xsl:attribute>
						<xsl:attribute name="amt"><xsl:value-of
							select="$freightCharge/amt" /></xsl:attribute>
						<xsl:attribute name="rate"><xsl:value-of
							select="$freightCharge/rate" /></xsl:attribute>
						<xsl:attribute name="is_valid"><xsl:value-of
							select="$freightCharge/is_valid" /></xsl:attribute>
					</div>
				</xsl:for-each>
			</xsl:if>
		</div>

	</xsl:template>

	<!-- Freight Charge codes -->
	<xd:doc>
		<xd:short>Freight Charge Codes</xd:short>
		<xd:detail>
			This templates displays different freight charge type available in the drop down.
 		</xd:detail>
 		<xd:param name="field-name">Name of the field in the form submission</xd:param>
 	</xd:doc>
	<xsl:template name="freight-charge-codes">
	<xsl:param name="field-name"/>
	 <xsl:choose>
        <xsl:when test="$displaymode='edit'">
		<option value="AIRF">
			<xsl:value-of select="localization:getDecode($language, 'N210', 'AIRF')" />
		</option>
		<option value="CHDE">
			<xsl:value-of select="localization:getDecode($language, 'N210', 'CHDE')" />
		</option>
		<option value="CHOR">
			<xsl:value-of select="localization:getDecode($language, 'N210', 'CHOR')" />
		</option>
		<option value="COLF">
			<xsl:value-of select="localization:getDecode($language, 'N210', 'COLF')" />
		</option>
		<option value="DNGR">
			<xsl:value-of select="localization:getDecode($language, 'N210', 'DNGR')" />
		</option>
		<option value="INSU">
			<xsl:value-of select="localization:getDecode($language, 'N210', 'INSU')" />
		</option>
		<option value="PACK">
			<xsl:value-of select="localization:getDecode($language, 'N210', 'PACK')" />
		</option>
		<option value="PICK">
			<xsl:value-of select="localization:getDecode($language, 'N210', 'PICK')" />
		</option>
		<option value="SECU">
			<xsl:value-of select="localization:getDecode($language, 'N210', 'SECU')" />
		</option>
		<option value="SIGN">
			<xsl:value-of select="localization:getDecode($language, 'N210', 'SIGN')" />
		</option>
		<option value="STDE">
			<xsl:value-of select="localization:getDecode($language, 'N210', 'STDE')" />
		</option>
		<option value="STOR">
			<xsl:value-of select="localization:getDecode($language, 'N210', 'STOR')" />
		</option>
		<option value="TRPT">
			<xsl:value-of select="localization:getDecode($language, 'N210', 'TRPT')" />
		</option>
		<option value="OTHR">
			<xsl:value-of select="localization:getDecode($language, 'N210', 'OTHR')" />
		</option>
		 </xsl:when>
        <xsl:otherwise>
         <xsl:choose>
          <xsl:when test="$field-name = 'AIRF'"><xsl:value-of select="localization:getDecode($language, 'N210', 'AIRF')" /></xsl:when>
          <xsl:when test="$field-name = 'CHDE'"><xsl:value-of select="localization:getDecode($language, 'N210', 'CHDE')" /></xsl:when>
          <xsl:when test="$field-name = 'CHOR'"><xsl:value-of select="localization:getDecode($language, 'N210', 'CHOR')" /></xsl:when>
          <xsl:when test="$field-name = 'COLF'"><xsl:value-of select="localization:getDecode($language, 'N210', 'COLF')" /></xsl:when>
          <xsl:when test="$field-name = 'DNGR'"><xsl:value-of select="localization:getDecode($language, 'N210', 'DNGR')" /></xsl:when>
          <xsl:when test="$field-name = 'INSU'"><xsl:value-of select="localization:getDecode($language, 'N210', 'INSU')" /></xsl:when>
          <xsl:when test="$field-name = 'PACK'"><xsl:value-of select="localization:getDecode($language, 'N210', 'PACK')" /></xsl:when>
          <xsl:when test="$field-name = 'PICK'"><xsl:value-of select="localization:getDecode($language, 'N210', 'PICK')" /></xsl:when>
          <xsl:when test="$field-name = 'SECU'"><xsl:value-of select="localization:getDecode($language, 'N210', 'SECU')" /></xsl:when>
          <xsl:when test="$field-name = 'SIGN'"><xsl:value-of select="localization:getDecode($language, 'N210', 'SIGN')" /></xsl:when>
          <xsl:when test="$field-name = 'STDE'"><xsl:value-of select="localization:getDecode($language, 'N210', 'STDE')" /></xsl:when>
          <xsl:when test="$field-name = 'STOR'"><xsl:value-of select="localization:getDecode($language, 'N210', 'STOR')" /></xsl:when>
          <xsl:when test="$field-name = 'TRPT'"><xsl:value-of select="localization:getDecode($language, 'N210', 'TRPT')" /></xsl:when>
          <xsl:otherwise><xsl:value-of select="localization:getDecode($language, 'N210', 'OTHR')" /></xsl:otherwise>
         </xsl:choose>
        </xsl:otherwise>
       </xsl:choose>
	</xsl:template>

	<!-- ************** -->
	<!-- Freight Charge -->
	<!-- ************** -->
	
	<!-- ********* -->
	<!-- Incoterms -->
	<!-- ********* -->
	<!-- Template for the declaration of line items -->
	<xd:doc>
		<xd:short>Incoterms dialogue declaration</xd:short>
		<xd:detail>
			This templates sets parameter of incoterm label,and location label and its parameters such as size,requirement,
			name etc for the different templates called inside,it also adds button cancel and ok in dialog box.
 		</xd:detail>
 	</xd:doc>
	<xsl:template name="incoterm-dialog-declaration">
		<div id="incoterm-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>

			<div class="standardPODialogContent">
				<!-- Incoterm Code -->
				<xsl:choose>
					<xsl:when test="$displaymode = 'edit'">
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">incoterm_code_label</xsl:with-param>							
							<xsl:with-param name="value">
								<xsl:choose>
									<xsl:when test="incoterm_code"><xsl:value-of select="localization:getDecode($language, 'N212', incoterm_code)" /></xsl:when>
									<xsl:otherwise></xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>							
						</xsl:call-template>
						<xsl:call-template name="select-field">
							<xsl:with-param name="label">XSL_DETAILS_PO_INCO_TERMS_CODE</xsl:with-param>
							<xsl:with-param name="name">incoterm_code</xsl:with-param>
							<xsl:with-param name="required">Y</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="options">
								<xsl:call-template name="incoterm-codes" >
									<xsl:with-param name="field-name">incoterm_code</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_DETAILS_PO_INCO_TERMS_CODE</xsl:with-param>
							<xsl:with-param name="name">incoterm_code_label</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							<xsl:with-param name="swift-validate">N</xsl:with-param>
							<xsl:with-param name="size">35</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="readonly">Y</xsl:with-param>
							<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
				
				<!-- Incoterm other code -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label"></xsl:with-param>
					<xsl:with-param name="name">incoterm_other</xsl:with-param>
					<xsl:with-param name="override-displaymode">edit</xsl:with-param>
					<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
					<xsl:with-param name="swift-validate">N</xsl:with-param>
					<xsl:with-param name="size">35</xsl:with-param>
					<xsl:with-param name="maxsize">35</xsl:with-param>
					<xsl:with-param name="readonly">Y</xsl:with-param>
					<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
				</xsl:call-template>
				<!-- Incoterm location -->
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_DETAILS_PO_INCO_TERMS_LOCATION</xsl:with-param>
					<xsl:with-param name="name">incoterm_location</xsl:with-param>
					<xsl:with-param name="override-displaymode">edit</xsl:with-param>
					<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
					<xsl:with-param name="swift-validate">N</xsl:with-param>
					<xsl:with-param name="size">35</xsl:with-param>
					<xsl:with-param name="maxsize">35</xsl:with-param>
					<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
				</xsl:call-template>
				<div class="dijitDialogPaneActionBar">
					<xsl:call-template name="label-wrapper">
						<xsl:with-param name="content">
							<button type="button" dojoType="dijit.form.Button">
								<xsl:attribute name="onmouseup">dijit.byId('incoterm-dialog-template').hide();</xsl:attribute>
								<xsl:value-of
									select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
							</button>
							<xsl:if test="$displaymode = 'edit'">
								<button dojoType="dijit.form.Button">
									<xsl:attribute name="onClick">dijit.byId('incoterm-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
									<xsl:value-of
										select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
								</button>
							</xsl:if>
						</xsl:with-param>
					</xsl:call-template>
				</div>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Incoterms declaration</xd:short>
		<xd:detail>
			This templates displays no incoterms in there id no incoterms and also adds a button to add incoterms
 		</xd:detail>
 	</xd:doc>
	<xsl:template name="incoterms-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="incoterm-dialog-declaration" />
		<!-- Dialog End -->
		<div id="incoterms-template" style="display:none">
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_DETAILS_PO_NO_INCO_TERMS')" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem"
					dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_INCO_TERMS')" />
				</button>
			</div>
		</div>
	</xsl:template>

	<!-- Incoterms - Dojo objects -->
	<xd:doc>
		<xd:short>Build Incoterms</xd:short>
		<xd:detail>
			This templates displays headers of incoterm dialog in add,edit or view mode,displayed header for incoterm grid and also gets values of adds attributes of inco-terms.
 		</xd:detail>
 		<xd:param name="items">Items to be build to form display </xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">Overridden display mode.Shows in edit mode of the parent form</xd:param>
 	</xd:doc>
	<xsl:template name="build-incoterms-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
		<div dojoType="misys.openaccount.widget.Incoterms" dialogId="incoterm-dialog-template">
		<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
		<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_INCO_TERMS')" /></xsl:attribute>
		<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_EDIT_INCO_TERMS')" /></xsl:attribute>
		<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_VIEW_INCO_TERMS')" /></xsl:attribute>
			<xsl:attribute name="headers">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_INCO_TERMS_CODE')" />,
				<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_INCO_TERMS_LOCATION')" />
			</xsl:attribute>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
			 <xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="incoterm" select="." />
					<div dojoType="misys.openaccount.widget.Incoterm">
						<xsl:attribute name="ref_id"><xsl:value-of
							select="$incoterm/ref_id" /></xsl:attribute>
						<xsl:attribute name="tnx_id"><xsl:value-of
							select="$incoterm/tnx_id" /></xsl:attribute>
						<xsl:attribute name="inco_term_id"><xsl:value-of
							select="$incoterm/inco_term_id" /></xsl:attribute>
						<xsl:attribute name="code"><xsl:value-of
							select="$incoterm/code" /></xsl:attribute>
						<xsl:attribute name="code_label">
							<xsl:value-of select="localization:getDecode($language, 'N212', $incoterm/code)" />
						</xsl:attribute>
						<xsl:attribute name="other"><xsl:value-of
							select="$incoterm/other" /></xsl:attribute>
						<xsl:attribute name="location"><xsl:value-of
							select="$incoterm/location" /></xsl:attribute>
						<xsl:attribute name="is_valid"><xsl:value-of
							select="$incoterm/is_valid" /></xsl:attribute>
					</div>
				</xsl:for-each>
			</xsl:if>
		</div>

	</xsl:template>
	
	
	<!-- Incoterm codes -->
	<xd:doc>
		<xd:short>Incoterm codes</xd:short>
		<xd:detail>
			This templates displays all incoterm types in the drop down box.
 		</xd:detail>
 		<xd:param name="field-name">Name of the field in the form submission</xd:param>
 	</xd:doc>
	<xsl:template name="incoterm-codes">
		<xsl:param name="field-name"/>
		<xsl:choose>
			<xsl:when test="$displaymode='edit'">
				<option value="EXW">
					<xsl:value-of select="localization:getDecode($language, 'N212', 'EXW')" />
				</option>
				<option value="FCA">
					<xsl:value-of select="localization:getDecode($language, 'N212', 'FCA')" />
				</option>
				<option value="FAS">
					<xsl:value-of select="localization:getDecode($language, 'N212', 'FAS')" />
				</option>
				<option value="FOB">
					<xsl:value-of select="localization:getDecode($language, 'N212', 'FOB')" />
				</option>
				<option value="CFR">
					<xsl:value-of select="localization:getDecode($language, 'N212', 'CFR')" />
				</option>
				<option value="CIF">
					<xsl:value-of select="localization:getDecode($language, 'N212', 'CIF')" />
				</option>
				<option value="CPT">
					<xsl:value-of select="localization:getDecode($language, 'N212', 'CPT')" />
				</option>
				<option value="CIP">
					<xsl:value-of select="localization:getDecode($language, 'N212', 'CIP')" />
				</option>
				<option value="DAF">
					<xsl:value-of select="localization:getDecode($language, 'N212', 'DAF')" />
				</option>
				<xsl:if test="product_code[.!='IO']">
					<option value="DAT">
						<xsl:value-of select="localization:getDecode($language, 'N212', 'DAT')" />
					</option>
					<option value="DAP">
						<xsl:value-of select="localization:getDecode($language, 'N212', 'DAP')" />
					</option>
				</xsl:if>
				<option value="DES">
					<xsl:value-of select="localization:getDecode($language, 'N212', 'DES')" />
				</option>
				<option value="DEQ">
					<xsl:value-of select="localization:getDecode($language, 'N212', 'DEQ')" />
				</option>
				<option value="DDU">
					<xsl:value-of select="localization:getDecode($language, 'N212', 'DDU')" />
				</option>
				<option value="DDP">
					<xsl:value-of select="localization:getDecode($language, 'N212', 'DDP')" />
				</option>
				<option value="OTHR">
					<xsl:value-of select="localization:getDecode($language, 'N212', 'OTHR')" />
				</option>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$field-name = 'EXW'"><xsl:value-of select="localization:getDecode($language, 'N212', 'EXW')" /></xsl:when>
					<xsl:when test="$field-name = 'FCA'"><xsl:value-of select="localization:getDecode($language, 'N212', 'FCA')" /></xsl:when>
					<xsl:when test="$field-name = 'FAS'"><xsl:value-of select="localization:getDecode($language, 'N212', 'FAS')" /></xsl:when>
					<xsl:when test="$field-name = 'FOB'"><xsl:value-of select="localization:getDecode($language, 'N212', 'FOB')" /></xsl:when>
					<xsl:when test="$field-name = 'CFR'"><xsl:value-of select="localization:getDecode($language, 'N212', 'CFR')" /></xsl:when>
					<xsl:when test="$field-name = 'CIF'"><xsl:value-of select="localization:getDecode($language, 'N212', 'CIF')" /></xsl:when>
					<xsl:when test="$field-name = 'CPT'"><xsl:value-of select="localization:getDecode($language, 'N212', 'CPT')" /></xsl:when>
					<xsl:when test="$field-name = 'CIP'"><xsl:value-of select="localization:getDecode($language, 'N212', 'CIP')" /></xsl:when>
					<xsl:when test="$field-name = 'DAF'"><xsl:value-of select="localization:getDecode($language, 'N212', 'DAF')" /></xsl:when>
					<xsl:when test="$field-name = 'DAT'"><xsl:value-of select="localization:getDecode($language, 'N212', 'DAT')" /></xsl:when>
					<xsl:when test="$field-name = 'DAP'"><xsl:value-of select="localization:getDecode($language, 'N212', 'DAP')" /></xsl:when>
					<xsl:when test="$field-name = 'DES'"><xsl:value-of select="localization:getDecode($language, 'N212', 'DES')" /></xsl:when>
					<xsl:when test="$field-name = 'DEQ'"><xsl:value-of select="localization:getDecode($language, 'N212', 'DEQ')" /></xsl:when>
					<xsl:when test="$field-name = 'DDU'"><xsl:value-of select="localization:getDecode($language, 'N212', 'DDU')" /></xsl:when>
					<xsl:when test="$field-name = 'DDP'"><xsl:value-of select="localization:getDecode($language, 'N212', 'DDP')" /></xsl:when>
					<xsl:otherwise><xsl:value-of select="localization:getDecode($language, 'N212', 'OTHR')" /></xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	
	<!-- ********* -->
	<!-- Incoterms -->
	<!-- ********* -->
	<xd:doc>
		<xd:short>Payment detail codes</xd:short>
		<xd:detail>
			This templates displays all payment codes types(details per mention in payment dialog box) in the drop down box.
 		</xd:detail>
 	</xd:doc>
	<xsl:template name="payment-details-code">
		<xsl:choose>
			<xsl:when test="$displaymode='edit'">
				<option value="CASH">
					<xsl:value-of
						select="localization:getDecode($language, 'N208', 'CASH')" />
				</option>
				<option value="EMTD">
					<xsl:value-of
						select="localization:getDecode($language, 'N208', 'EMTD')" />
				</option>
				<option value="EPRD">
					<xsl:value-of
						select="localization:getDecode($language, 'N208', 'EPRD')" />
				</option>
				<option value="PRMD">
					<xsl:value-of
						select="localization:getDecode($language, 'N208', 'PRMD')" />
				</option>
				<option value="IREC">
					<xsl:value-of
						select="localization:getDecode($language, 'N208', 'IREC')" />
				</option>
				<option value="PRMR">
					<xsl:value-of
						select="localization:getDecode($language, 'N208', 'PRMR')" />
				</option>
				<option value="EPRR">
					<xsl:value-of
						select="localization:getDecode($language, 'N208', 'EPRR')" />
				</option>
				<option value="EMTR">
					<xsl:value-of
						select="localization:getDecode($language, 'N208', 'EMTR')" />
				</option>
				<option value="OTHR">
					<xsl:value-of
						select="localization:getDecode($language, 'N208', 'OTHR')" />
				</option>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="details_code[. = 'CASH']"><xsl:value-of select="localization:getDecode($language, 'N208', 'CASH')" /></xsl:when>
					<xsl:when test="details_code[. = 'EMTD']"><xsl:value-of select="localization:getDecode($language, 'N208', 'EMTD')" /></xsl:when>
					<xsl:when test="details_code[. = 'PRMD']"><xsl:value-of select="localization:getDecode($language, 'N208', 'EPRD')" /></xsl:when>
					<xsl:when test="details_code[. = 'IREC']"><xsl:value-of select="localization:getDecode($language, 'N208', 'IREC')" /></xsl:when>
					<xsl:when test="details_code[. = 'PRMR']"><xsl:value-of select="localization:getDecode($language, 'N208', 'PRMR')" /></xsl:when>
					<xsl:when test="details_code[. = 'EPRR']"><xsl:value-of select="localization:getDecode($language, 'N208', 'EPRR')" /></xsl:when>
					<xsl:when test="details_code[. = 'EMTR']"><xsl:value-of select="localization:getDecode($language, 'N208', 'EMTR')" /></xsl:when>
					<xsl:otherwise><xsl:value-of select="localization:getDecode($language, 'N208', 'OTHR')" /></xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

<!-- LineItems - Dojo objects -->
	<xd:doc>
		<xd:short>Build commercial item dataset line item</xd:short>
		<xd:detail>
			This templates build all header for add,update or view of commercial dataset line items,it also displayes header of the table of commercial dataset of line item.
			It also selects the different attributes of line item widget.
 		</xd:detail>
 		<xd:param name="items">Items to be build to form display </xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">Overridden display mode.Shows in edit mode of the parent form</xd:param>
 	</xd:doc>
	<xsl:template name="build-commercial-dataset-line-items-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="poReference"/>
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
		<div dojoType="misys.openaccount.widget.LineItems" dialogId="line-item-dialog-template" id="line-items">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_LINE_ITEM')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_EDIT_LINE_ITEM')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_VIEW_LINE_ITEM')" /></xsl:attribute>
			<xsl:attribute name="headers">
			<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_LINE_ITEM_NUMBER')" />,
			<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_LINE_ITEM_PRODUCT')" />
			</xsl:attribute>
			<xsl:for-each select="$items">
				<xsl:variable name="lineItem" select="." />
				<div dojoType="misys.openaccount.widget.LineItem">
					<xsl:attribute name="cust_ref_id"><xsl:value-of
						select="$lineItem/LineItmId" /></xsl:attribute>
					<xsl:attribute name="po_reference"><xsl:value-of
						select="$poReference" /></xsl:attribute>
					<xsl:attribute name="product_name"><xsl:value-of
						select="$lineItem/PdctNm" /></xsl:attribute>
					<xsl:attribute name="product_orgn"><xsl:value-of
						select="$lineItem/PdctOrgn" /></xsl:attribute>
					<xsl:attribute name="qty_unit_measr_code"><xsl:value-of 
						select="$lineItem/Qty/UnitOfMeasr/UnitOfMeasrCd" /></xsl:attribute>
					<xsl:attribute name="qty_unit_measr_label">
						<xsl:if test="$lineItem/Qty/UnitOfMeasr/UnitOfMeasrCd != ''">
							<xsl:value-of select="localization:getDecode($language, 'N202', $lineItem/Qty/UnitOfMeasr/UnitOfMeasrCd)" />
						</xsl:if>
					</xsl:attribute>
					<xsl:attribute name="qty_other_unit_measr"><xsl:value-of
						select="$lineItem/Qty/UnitOfMeasr/OthrUnitOfMeasr" /></xsl:attribute>
					<xsl:attribute name="qty_val"><xsl:value-of
						select="$lineItem/Qty/Val" /></xsl:attribute>
					<xsl:attribute name="qty_factor"><xsl:value-of
						select="$lineItem/Qty/Fctr" /></xsl:attribute>
					<xsl:attribute name="qty_tol_pstv_pct"><xsl:value-of
						select="$lineItem/qty_tol_pstv_pct" /></xsl:attribute>
					<xsl:attribute name="qty_tol_neg_pct"><xsl:value-of
						select="$lineItem/qty_tol_neg_pct" /></xsl:attribute>
					<xsl:attribute name="price_unit_measr_code"><xsl:value-of 
						select="$lineItem/UnitPric/UnitPric/UnitOfMeasrCd" /></xsl:attribute>
					<xsl:attribute name="price_unit_measr_label">
						<xsl:if test="$lineItem/UnitPric/UnitPric/UnitOfMeasrCd">
							<xsl:value-of select="localization:getDecode($language, 'N202', $lineItem/UnitPric/UnitPric/UnitOfMeasrCd)" />
						</xsl:if>
					</xsl:attribute>
					<xsl:attribute name="price_other_unit_measr"><xsl:value-of
						select="$lineItem/UnitPric/UnitPric/OthrUnitOfMeasr" /></xsl:attribute>
					<xsl:attribute name="price_cur_code"><xsl:value-of
						select="$lineItem/UnitPric/Amt/@Ccy" /></xsl:attribute>
					<xsl:attribute name="price_amt"><xsl:value-of
						select="$lineItem/UnitPric/Amt" /></xsl:attribute>
					<xsl:attribute name="price_factor"><xsl:value-of
						select="$lineItem/UnitPric/Fctr" /></xsl:attribute>
					<xsl:attribute name="price_tol_pstv_pct"><xsl:value-of
						select="$lineItem/price_tol_pstv_pct" /></xsl:attribute>
					<xsl:attribute name="price_tol_neg_pct"><xsl:value-of
						select="$lineItem/price_tol_neg_pct" /></xsl:attribute>
					<xsl:attribute name="total_cur_code"><xsl:value-of
						select="$lineItem/TtlAmt/@Ccy" /></xsl:attribute>
					<xsl:attribute name="total_amt"><xsl:value-of
						select="$lineItem/TtlAmt" /></xsl:attribute>
					<xsl:attribute name="freight_charges_type"><xsl:value-of
						select="$lineItem/FrghtChrgs/Tp" /></xsl:attribute>
					<xsl:attribute name="total_net_cur_code"><xsl:value-of
						select="$lineItem/TtlAmt/@Ccy" /></xsl:attribute>
					<xsl:attribute name="total_net_amt"><xsl:value-of
						select="$lineItem/TtlAmt" /></xsl:attribute>
					<xsl:attribute name="last_ship_date"><xsl:value-of
						select="$lineItem/last_ship_date" /></xsl:attribute>
					<xsl:attribute name="is_valid">Y</xsl:attribute>
					<xsl:if test="$lineItem/PdctIdr != ''">
						<div dojoType="misys.openaccount.widget.ProductIdentifiers">
							<xsl:apply-templates select="PdctIdr"/>
						</div>
					</xsl:if>
					<xsl:if test="$lineItem/PdctChrtcs != ''">
						<div dojoType="misys.openaccount.widget.ProductCharacteristics">
							<!-- <xsl:for-each select="$lineItem/PdctChrtcs"> -->
								<xsl:apply-templates select="PdctChrtcs"/>
							<!-- </xsl:for-each> -->
						</div>
					</xsl:if>
					<xsl:if test="$lineItem/PdctCtgy != ''">
						<div dojoType="misys.openaccount.widget.ProductCategories">
							<!-- <xsl:for-each select="$lineItem/PdctCtgy"> -->
								<xsl:apply-templates select="PdctCtgy"/>
							<!-- </xsl:for-each> -->
						</div>
					</xsl:if>
					<xsl:if test="$lineItem/Adjstmnt != ''">
						<div dojoType="misys.openaccount.widget.Adjustments">
							<!-- <xsl:for-each select="$lineItem/Adjstmnt"> -->
								<xsl:apply-templates select="Adjstmnt" mode="adjustment"/>
							<!-- </xsl:for-each> -->
						</div>
					</xsl:if>
					<xsl:if test="$lineItem/Tax != ''">
						<div dojoType="misys.openaccount.widget.Taxes">
							<!-- <xsl:for-each select="$lineItem/Tax"> -->
								<xsl:apply-templates select="Tax" mode="tax"/>
							<!-- </xsl:for-each> -->
						</div>
					</xsl:if>
					<xsl:if test="$lineItem/FrghtChrgs != ''">
						<div dojoType="misys.openaccount.widget.FreightCharges">
							<!-- <xsl:for-each select="$lineItem/FrghtChrgs"> -->
								<xsl:apply-templates select="FrghtChrgs"  mode="freightCharge"/>
							<!-- </xsl:for-each> -->
						</div>
					</xsl:if>
					<xsl:if test="$lineItem/Incotrms != ''">
						<div dojoType="misys.openaccount.widget.Incoterms">
							<!-- <xsl:for-each select="$lineItem/Incotrms"> -->
								<xsl:apply-templates select="Incotrms"/>
							<!-- </xsl:for-each> -->
						</div>
					</xsl:if>
					<!-- <xsl:apply-templates select="$lineItem/PdctChrtcs"/>
					<xsl:apply-templates select="$lineItem/PdctCtgy"/>
					<xsl:apply-templates select="$lineItem/Adjstmnt"/>
					<xsl:apply-templates select="$lineItem/Tax"/>
					<xsl:apply-templates select="$lineItem/FrghtChrgs"/>
					<xsl:apply-templates select="$lineItem/Incotrms"/>  -->
				</div>
			</xsl:for-each>
		</div>
	</xsl:template>
	
	
	<xd:doc>
		<xd:short>Product Identifier</xd:short>
		<xd:detail>
			This templates adds different attributes and fills it with given selected value in productidentifier widget
 		</xd:detail>
 	</xd:doc>
	<xsl:template match="PdctIdr">
		<div dojoType="misys.openaccount.widget.ProductIdentifier">
			<xsl:attribute name="goods_id"><xsl:value-of select="generate-id(.)"/></xsl:attribute>
			<xsl:attribute name="ref_id"><xsl:value-of select="/io_tnx_record/ref_id"/></xsl:attribute>
			<xsl:attribute name="tnx_id"><xsl:value-of select="/io_tnx_record/tnx_id"/></xsl:attribute>
			<xsl:attribute name="type"><xsl:value-of select="StrdPdctIdr/Tp"/></xsl:attribute>
			<xsl:attribute name="type_label">
				<xsl:choose>
					<xsl:when test="StrdPdctIdr/Tp !=''">
						<xsl:value-of select="localization:getDecode($language, 'N220', StrdPdctIdr/Tp)" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="localization:getDecode($language, 'N220', OthrPdctIdr/Id)" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:attribute name="other_type"><xsl:value-of select="OthrPdctIdr/Id"/></xsl:attribute>
			<xsl:attribute name="description">
				<xsl:choose>
					<xsl:when test="StrdPdctIdr/Idr !=''">
						<xsl:value-of select="StrdPdctIdr/Idr" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="OthrPdctIdr/IdTp" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:attribute name="is_valid">Y</xsl:attribute>
		</div>
	</xsl:template>
	
	
	<xd:doc>
		<xd:short>Product Category</xd:short>
		<xd:detail>
			This templates adds different attributes and fills it with given selected value in productCategory widget
 		</xd:detail>
 	</xd:doc>
	<xsl:template match="PdctCtgy">
		<div dojoType="misys.openaccount.widget.ProductCategory">
			<xsl:attribute name="goods_id"><xsl:value-of select="generate-id(.)"/></xsl:attribute>
			<xsl:attribute name="ref_id"><xsl:value-of select="/io_tnx_record/ref_id"/></xsl:attribute>
			<xsl:attribute name="tnx_id"><xsl:value-of select="/io_tnx_record/tnx_id"/></xsl:attribute>
			<xsl:attribute name="type"><xsl:value-of select="StrdPdctCtgy/Tp"/></xsl:attribute>
			<xsl:attribute name="type_label">
				<xsl:choose>
					<xsl:when test="StrdPdctCtgy/Tp !=''">
						<xsl:value-of select="localization:getDecode($language, 'N221', StrdPdctCtgy/Tp)" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="localization:getDecode($language, 'N221', OthrPdctCtgy/Id)" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:attribute name="other_type"><xsl:value-of select="OthrPdctCtgy/Id"/></xsl:attribute>
			<xsl:attribute name="description">
				<xsl:choose>
					<xsl:when test="StrdPdctCtgy/Ctgy !=''">
						<xsl:value-of select="StrdPdctCtgy/Ctgy" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="OthrPdctCtgy/IdTp" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:attribute name="is_valid">Y</xsl:attribute>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Product Characteristics</xd:short>
		<xd:detail>
			This templates adds different attributes and fills it with given selected value in productCharacteristic widget
 		</xd:detail>
 	</xd:doc>
	<xsl:template match="PdctChrtcs">
		<div dojoType="misys.openaccount.widget.ProductCharacteristic">
			<xsl:attribute name="goods_id"><xsl:value-of select="generate-id(.)"/></xsl:attribute>
			<xsl:attribute name="ref_id"><xsl:value-of select="/io_tnx_record/ref_id"/></xsl:attribute>
			<xsl:attribute name="tnx_id"><xsl:value-of select="/io_tnx_record/tnx_id"/></xsl:attribute>
			<xsl:attribute name="type"><xsl:value-of select="StrdPdctChrtcs/Tp"/></xsl:attribute>
			<xsl:attribute name="type_label">
				<xsl:choose>
					<xsl:when test="StrdPdctChrtcs/Tp !=''">
						<xsl:value-of select="localization:getDecode($language, 'N222', StrdPdctChrtcs/Tp)" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="localization:getDecode($language, 'N222', OthrPdctChrtcs/Id)" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:attribute name="other_type"><xsl:value-of select="OthrPdctChrtcs/Id"/></xsl:attribute>
			<xsl:attribute name="description">
				<xsl:choose>
					<xsl:when test="StrdPdctChrtcs/Chrtcs !=''">
						<xsl:value-of select="StrdPdctChrtcs/Chrtcs" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="OthrPdctChrtcs/IdTp" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:attribute name="is_valid">Y</xsl:attribute>
		</div>
	</xsl:template>

	<xd:doc>
		<xd:short>Adjustment</xd:short>
		<xd:detail>
			This templates adds different attributes  and fills it with given selected value in Adjustment widget
 		</xd:detail>
 	</xd:doc>
	<xsl:template match="Adjstmnt" mode="adjustment">
		<div dojoType="misys.openaccount.widget.Adjustment">
			<xsl:attribute name="allowance_id"><xsl:value-of select="generate-id(.)"/></xsl:attribute>
			<xsl:attribute name="ref_id"><xsl:value-of select="/io_tnx_record/ref_id"/></xsl:attribute>
			<xsl:attribute name="tnx_id"><xsl:value-of select="/io_tnx_record/tnx_id"/></xsl:attribute>
			<xsl:attribute name="type"><xsl:value-of select="Tp/Tp"/></xsl:attribute>
			<xsl:attribute name="type_label">
				<xsl:choose>
					<xsl:when test="Tp/Tp !=''">
						<xsl:value-of select="localization:getDecode($language, 'N210', Tp/Tp)" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="localization:getDecode($language, 'N210', Tp/OthrAdjstmntTp)" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:attribute name="other_type"><xsl:value-of select="Tp/OthrAdjstmntTp"/></xsl:attribute>
			<xsl:attribute name="direction"><xsl:value-of select="Drctn"/></xsl:attribute>
			<xsl:attribute name="direction_label"><xsl:value-of select="localization:getDecode($language, 'N216', Drctn)" /></xsl:attribute>
			<xsl:attribute name="cur_code"><xsl:value-of select="Amt/@Ccy"/></xsl:attribute>
			<xsl:attribute name="amt"><xsl:value-of select="Amt"/></xsl:attribute>
			<xsl:attribute name="rate"><xsl:value-of select="rate"/></xsl:attribute>
			<xsl:attribute name="is_valid">Y</xsl:attribute>
		</div>
	</xsl:template>


	<xd:doc>
		<xd:short>Tax</xd:short>
		<xd:detail>
			This templates with tax mode adds different attributes and fills it with given selected value in Tax widget
 		</xd:detail>
 	</xd:doc>
	<xsl:template match="Tax" mode="tax">
		<div dojoType="misys.openaccount.widget.Tax">
			<xsl:attribute name="allowance_id"><xsl:value-of select="generate-id(.)"/></xsl:attribute>
			<xsl:attribute name="ref_id"><xsl:value-of select="/io_tnx_record/ref_id"/></xsl:attribute>
			<xsl:attribute name="tnx_id"><xsl:value-of select="/io_tnx_record/tnx_id"/></xsl:attribute>
			<xsl:attribute name="type"><xsl:value-of select="Tp/Tp"/></xsl:attribute>
			<xsl:attribute name="type_label">
				<xsl:choose>
					<xsl:when test="Tp/Tp !=''">
						<xsl:value-of select="localization:getDecode($language, 'N210', Tp/Tp)" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="localization:getDecode($language, 'N210', Tp/OthrTaxTp)" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:attribute name="other_type"><xsl:value-of select="Tp/OthrTaxTp"/></xsl:attribute>
			<xsl:attribute name="cur_code"><xsl:value-of select="Amt/@Ccy"/></xsl:attribute>
			<xsl:attribute name="amt"><xsl:value-of select="Amt"/></xsl:attribute>
			<xsl:attribute name="rate"><xsl:value-of select="rate"/></xsl:attribute>
			<xsl:attribute name="is_valid">Y</xsl:attribute>
		</div>
	</xsl:template>

	<xd:doc>
		<xd:short>Freight Charges</xd:short>
		<xd:detail>
			This templates with Freight Charge mode adds different attributes and fills it with given selected value in FreightCharge widget.
 		</xd:detail>
 	</xd:doc>
	<xsl:template match="FrghtChrgs" mode="freightCharge">
		<div dojoType="misys.openaccount.widget.FreightCharge">
			<xsl:attribute name="allowance_id"><xsl:value-of select="generate-id(.)"/></xsl:attribute>
			<xsl:attribute name="ref_id"><xsl:value-of select="/io_tnx_record/ref_id"/></xsl:attribute>
			<xsl:attribute name="tnx_id"><xsl:value-of select="/io_tnx_record/tnx_id"/></xsl:attribute>
			<xsl:attribute name="type"><xsl:value-of select="Tp"/></xsl:attribute>
			<xsl:attribute name="type_label">
				<xsl:choose>
					<xsl:when test="Tp !=''">
						<xsl:value-of select="localization:getDecode($language, 'N210', Tp)" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="localization:getDecode($language, 'N210', Chrgs/ChrgsTp/OthrChrgsTp)" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:attribute name="other_type"><xsl:value-of select="Chrgs/ChrgsTp/OthrChrgsTp"/></xsl:attribute>
			<xsl:attribute name="cur_code"><xsl:value-of select="Amt/@Ccy"/></xsl:attribute>
			<xsl:attribute name="amt"><xsl:value-of select="Amt"/></xsl:attribute>
			<xsl:attribute name="rate"><xsl:value-of select="rate"/></xsl:attribute>
			<xsl:attribute name="is_valid">Y</xsl:attribute>
		</div>
	</xsl:template>

	<xd:doc>
		<xd:short>Incoterms</xd:short>
		<xd:detail>
			This templates adds different attributes and fills it with given selected value in Incoterm widget
 		</xd:detail>
 	</xd:doc>
	<xsl:template match="Incotrms">
		<div dojoType="misys.openaccount.widget.Incoterm">
			<xsl:attribute name="inco_term_id"><xsl:value-of select="generate-id(.)"/></xsl:attribute>
			<xsl:attribute name="ref_id"><xsl:value-of select="/io_tnx_record/ref_id"/></xsl:attribute>
			<xsl:attribute name="tnx_id"><xsl:value-of select="/io_tnx_record/tnx_id"/></xsl:attribute>
			<xsl:attribute name="code"><xsl:value-of select="IncotrmsCd/Cd"/></xsl:attribute>
			<xsl:attribute name="code_label">
				<xsl:choose>
					<xsl:when test="IncotrmsCd/Cd !=''">
						<xsl:value-of select="localization:getDecode($language, 'N212', IncotrmsCd/Cd)" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="localization:getDecode($language, 'N212', IncotrmsCd/Prtry)" />
					</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			<xsl:attribute name="other"><xsl:value-of select="IncotrmsCd/Prtry"/></xsl:attribute>
			<xsl:attribute name="location"><xsl:value-of select="Lctn"/></xsl:attribute>
			<xsl:attribute name="is_valid">Y</xsl:attribute>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Build baseline payment</xd:short>
		<xd:detail>
			This templates displayed header of add,edit or view payment term.It also displayes header of the baseline payment table which is condition,code or amount/percentage.It also selects
			different attributes of the payment in payment widget.
 		</xd:detail>
 		<xd:param name="items"> Items to be build to form display</xd:param>
 		<xd:param name="id">ID of the input field for form submission</xd:param>
 		<xd:param name="override-displaymode">display mode can be overriden in edit form.</xd:param>
 	</xd:doc>
	<xsl:template name="build-baseline-payments-details">
		<xsl:param name="items" />
		<xsl:param name="id" />
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->
		
		<div dojoType="misys.openaccount.widget.Payments" dialogId="payment-dialog-template" id="baseline-payment">
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dialogAddItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_PAYMENT')" /></xsl:attribute>
			<xsl:attribute name="dialogUpdateItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_EDIT_PAYMENT')" /></xsl:attribute>
			<xsl:attribute name="dialogViewItemTitle"><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_VIEW_PAYMENT')" /></xsl:attribute>
			<xsl:attribute name="headers">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_PAYMENT_CONDITION')" />,
					<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_PAYMENT_CUR_CODE')" />,
					<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_PO_PAYMENT_AMOUNT_OR_PCT')" />
				</xsl:attribute>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>

			<xsl:for-each select="$items">
				<xsl:variable name="payment" select="." />
				<div dojoType="misys.openaccount.widget.Payment">
					<xsl:attribute name="ref_id"><xsl:value-of
						select="/io_tnx_record/ref_id" /></xsl:attribute>
					<xsl:attribute name="tnx_id"><xsl:value-of
						select="/io_tnx_record/tnx_id" /></xsl:attribute>
					<xsl:attribute name="payment_id"><xsl:value-of
						select="generate-id(.)" /></xsl:attribute>
					<xsl:attribute name="payment_date"><xsl:value-of
						select="$payment/PmtTerms/PmtDueDt" /></xsl:attribute>
					<xsl:attribute name="code"><xsl:value-of
						select="$payment/PmtTerms/PmtCd/Cd" /></xsl:attribute>
					<xsl:attribute name="label"><xsl:value-of
						select="localization:getDecode($language, 'N208', $payment/PmtTerms/PmtTerms/PmtCd/Cd)" /></xsl:attribute>
					<xsl:attribute name="other_paymt_terms"><xsl:value-of
						select="$payment/PmtTerms/OthrPmtTerms" /></xsl:attribute>
					<xsl:attribute name="nb_days"><xsl:value-of
						select="$payment/PmtTerms/PmtCd/NbOfDays" /></xsl:attribute>
					<xsl:attribute name="cur_code"><xsl:value-of
						select="$payment/AmtOrPctg/Amt/@Ccy" /></xsl:attribute>
					<xsl:attribute name="amt"><xsl:value-of
						select="$payment/AmtOrPctg/Amt" /></xsl:attribute>
					<xsl:attribute name="pct"><xsl:value-of
						select="$payment/AmtOrPctg/Pctg" /></xsl:attribute>
					<xsl:attribute name="is_valid">Y</xsl:attribute>
				</div>
			</xsl:for-each>
		</div>

	</xsl:template>
	
	<!-- Settlement terms template -->
	<xd:doc>
		<xd:short>baseline settlement terms details</xd:short>
		<xd:detail>
			This templates sets different parameters for different template being called(based on the condition).
 		</xd:detail>
 		<xd:param name="node">Provides path for test condition</xd:param>
 	</xd:doc>
		<xsl:template name="baseline-settlement-terms-details">
				<xsl:param name="node" />
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_SETTLEMENT_TERMS</xsl:with-param>
					<xsl:with-param name="content">
					   
				      	<xsl:if test="$node/CdtrAgt/BIC !=''">
    					 <xsl:call-template name="input-field">
    					 	<xsl:with-param name="label">XSL_PURCHASE_ORDER_SUBMITTER_BIC</xsl:with-param>
					         <xsl:with-param name="id">bl_creditor_agent_bic</xsl:with-param>
					         <xsl:with-param name="value"><xsl:value-of select="$node/CdtrAgt/BIC" /> </xsl:with-param>
					         <xsl:with-param name="type">text</xsl:with-param>
					         <xsl:with-param name="size">11</xsl:with-param>
					         <xsl:with-param name="maxsize">11</xsl:with-param>
					         <xsl:with-param name="fieldsize">small</xsl:with-param>
					         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
				         </xsl:call-template>
				        </xsl:if>
					    
					   <xsl:if test="$node/CdtrAgt/NmAndAdr/Nm !=''">
				        <xsl:call-template name="input-field">
					         <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_NAME</xsl:with-param>
					         <xsl:with-param name="id">bl_creditor_agent_name</xsl:with-param>
					         <xsl:with-param name="value"><xsl:value-of select="$node/CdtrAgt/NmAndAdr/Nm" /></xsl:with-param>
					         <xsl:with-param name="type">text</xsl:with-param>
				        </xsl:call-template>
				       </xsl:if>
				       <xsl:if test="$node/CdtrAgt/NmAndAdr/Adr/StrtNm !=''">
				         <xsl:call-template name="input-field">
					         <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_STREET</xsl:with-param>
					         <xsl:with-param name="id">bl_creditor_street_name</xsl:with-param>
					         <xsl:with-param name="value"><xsl:value-of select="$node/CdtrAgt/NmAndAdr/Adr/StrtNm"/></xsl:with-param>
					         <xsl:with-param name="type">text</xsl:with-param>
				        </xsl:call-template>
				       </xsl:if>
				       <xsl:if test="$node/CdtrAgt/NmAndAdr/Adr/PstCdId !=''">
				        <xsl:call-template name="input-field">
					         <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_POST_CODE</xsl:with-param>
					         <xsl:with-param name="id">bl_creditor_post_code_identification</xsl:with-param>
					         <xsl:with-param name="value"><xsl:value-of select="$node/CdtrAgt/NmAndAdr/Adr/PstCdId" /></xsl:with-param>
					         <xsl:with-param name="type">text</xsl:with-param>
					         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
				        </xsl:call-template>
				       </xsl:if>
				       <xsl:if test="$node/CdtrAgt/NmAndAdr/Adr/TwnNm !=''">
				        <xsl:call-template name="input-field">
					         <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_TOWN</xsl:with-param>
					         <xsl:with-param name="id">bl_creditor_town_name</xsl:with-param>
					         <xsl:with-param name="value"><xsl:value-of select="$node/CdtrAgt/NmAndAdr/Adr/TwnNm" /></xsl:with-param>
					         <xsl:with-param name="type">text</xsl:with-param>
					         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
				        </xsl:call-template>
				        </xsl:if>
				        <xsl:if test="$node/CdtrAgt/NmAndAdr/Adr/CtrySubDvsn !=''">
				        <xsl:call-template name="input-field">
					         <xsl:with-param name="label">XSL_PO_PARTIESDETAILS_COUNTRY_SUB_DIVISION</xsl:with-param>
					         <xsl:with-param name="id">bl_creditor_country_sub_div</xsl:with-param>
					         <xsl:with-param name="value"><xsl:value-of select="$node/CdtrAgt/NmAndAdr/Adr/CtrySubDvsn" /></xsl:with-param>
					         <xsl:with-param name="type">text</xsl:with-param>
					         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
				        </xsl:call-template>
				       </xsl:if>
				       <xsl:if test="$node/CdtrAgt/NmAndAdr/Adr/Ctry !=''">
				        <xsl:call-template name="country-field">
							<xsl:with-param name="prefix">creditor</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							<xsl:with-param name="value"><xsl:value-of select="$node/CdtrAgt/NmAndAdr/Adr/Ctry"/> </xsl:with-param>
						</xsl:call-template>
						</xsl:if>
			      
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="legend">XSL_HEADER_CREDITOR_ACCOUNT_DETAILS</xsl:with-param>
					<xsl:with-param name="legend-type">indented-header</xsl:with-param>
					<xsl:with-param name="content">  
				      	<xsl:if test="$node/CdtrAcct/Id/IBAN !=''">
		   					 <xsl:call-template name="input-field">
						         <xsl:with-param name="label">XSL_PURCHASE_ORDER_ACCOUNT_TYPE_IBAN_LABEL</xsl:with-param>
						         <xsl:with-param name="id">bl_creditor_account_id_iban</xsl:with-param>
						         <xsl:with-param name="value"><xsl:value-of select="$node/CdtrAcct/Id/IBAN"/></xsl:with-param>
						         <xsl:with-param name="type">text</xsl:with-param>
					        </xsl:call-template>
					   </xsl:if>
							    
						<xsl:if test="$node/CdtrAcct/Id/Othr/Id != ''">	      
				        <xsl:call-template name="input-field">
					         <xsl:with-param name="label">XSL_BPO_IDENTIFICATION</xsl:with-param>
					         <xsl:with-param name="id">bl_creditor_account_other_id</xsl:with-param>
					         <xsl:with-param name="value"><xsl:value-of select="$node/CdtrAcct/Id/Othr/Id" /></xsl:with-param>
					         <xsl:with-param name="type">text</xsl:with-param>
					         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
				        </xsl:call-template>
				       </xsl:if>
				       <xsl:if test="$node/CdtrAcct/Id/Othr/Issr != ''">
				         <xsl:call-template name="input-field">
					         <xsl:with-param name="label">XSL_BPO_ISSUER</xsl:with-param>
					         <xsl:with-param name="id">bl_creditor_account_other_issuer</xsl:with-param>
					         <xsl:with-param name="value"><xsl:value-of select="$node/CdtrAcct/Id/Othr/Issr"/> </xsl:with-param>
					         <xsl:with-param name="type">text</xsl:with-param>
					         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
				        </xsl:call-template>
						</xsl:if>       
				      	<xsl:if test="$node/CdtrAcct/Id/Othr/SchmeNm/Cd != ''">
			    			<xsl:call-template name="input-field">
						         <xsl:with-param name="label">XSL_DETAILS_PO_PRODUCT_IDENTIFIER_CODE</xsl:with-param>
						         <xsl:with-param name="id">bl_creditor_account_scheme_code</xsl:with-param>
						         <xsl:with-param name="value"><xsl:value-of select="$node/CdtrAcct/Id/Othr/SchmeNm/Cd"/> </xsl:with-param>
						         <xsl:with-param name="type">text</xsl:with-param>
						         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
					        </xsl:call-template>
					     </xsl:if>
					     <xsl:if test="$node/CdtrAcct/Id/Othr/SchmeNm/Prtry != ''">
			    			 <xsl:call-template name="input-field">
				         		 <xsl:with-param name="label">XSL_BPO_PROPRIETARY</xsl:with-param>
						         <xsl:with-param name="id">bl_creditor_account_scheme_prop</xsl:with-param>
						         <xsl:with-param name="value"><xsl:value-of select="$node/CdtrAcct/Id/Othr/SchmeNm/Prtry" /> </xsl:with-param>
						         <xsl:with-param name="type">text</xsl:with-param>
						         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
					        </xsl:call-template>
					      </xsl:if>
									  
						<xsl:if test="$node/CdtrAcct/Tp/Cd != ''">	      		
							<xsl:variable name="code_type"><xsl:value-of select="$node/CdtrAcct/Tp/Cd"></xsl:value-of></xsl:variable>
							<xsl:variable name="productCode"><xsl:value-of select="product_code"/></xsl:variable>
							<xsl:variable name="subProductCode"><xsl:value-of select="sub_product_code"/></xsl:variable>
							<xsl:variable name="parameterId">C025</xsl:variable>
				   			<xsl:call-template name="input-field">
						         <xsl:with-param name="label">XSL_HEADER_PO_PRODUCT_CHARACTERISTIC_CODE</xsl:with-param>
						         <xsl:with-param name="id">bl_creditor_account_type_code</xsl:with-param>
						         <xsl:with-param name="value"><xsl:value-of select="localization:getCodeData($language,'*',$productCode,$parameterId, $code_type)"/></xsl:with-param>
				       			<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
				       		</xsl:call-template>
					   </xsl:if>
					   <xsl:if test="$node/CdtrAcct/Tp/Prtry != ''">
			   			<xsl:call-template name="input-field">
					         <xsl:with-param name="label">XSL_BPO_LABEL_PROPRIETARY</xsl:with-param>
					         <xsl:with-param name="id">bl_creditor_account_type_prop</xsl:with-param>
					         <xsl:with-param name="value"><xsl:value-of select="$node/CdtrAcct/Tp/Prtry" /> </xsl:with-param>
					         <xsl:with-param name="type">text</xsl:with-param>
					         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
				        </xsl:call-template>
				       </xsl:if>
						<xsl:if test="$node/CdtrAcct/Nm != ''">			  
						     <xsl:call-template name="input-field">
						         <xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
						         <xsl:with-param name="id">bl_creditor_account_name</xsl:with-param>
						         <xsl:with-param name="value"><xsl:value-of select="$node/CdtrAcct/Nm"></xsl:value-of> </xsl:with-param>
						         <xsl:with-param name="type">text</xsl:with-param>
						         <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
					        </xsl:call-template>
					    </xsl:if>
					    <xsl:if test="$node/CdtrAcct/Ccy != ''">
					        <xsl:call-template name="currency-field">
								<xsl:with-param name="label">XSL_SYSTEMFEATURES_ACCOUNT_CURRENCY</xsl:with-param>
								<xsl:with-param name="id">bl_creditor_account_cur</xsl:with-param>
								<xsl:with-param name="override-currency-name">creditor_account_cur</xsl:with-param>
								<xsl:with-param name="show-button">Y</xsl:with-param>
								<xsl:with-param name="show-amt">N</xsl:with-param>
								 <xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								 <xsl:with-param name="override-currency-value"><xsl:value-of select="$node/CdtrAcct/Ccy" /></xsl:with-param>
							</xsl:call-template>
						</xsl:if>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			    </xsl:call-template>
		</xsl:template>
		
	<!-- ************************* -->
	<!-- Routing Summary For IN/IP -->
	<!-- ************************* -->
	
	<xd:doc>
		<xd:short>Routing Summary dialog</xd:short>
		<xd:detail>
			This template calls different templates.
 		</xd:detail>
 	</xd:doc>
	<xsl:template name="routing-summary-dialog-declaration">
		<xsl:call-template name="routing-summary-air-dialog-declaration"/>
		<xsl:call-template name="routing-summary-sea-dialog-declaration"/>
		<xsl:call-template name="routing-summary-rail-dialog-declaration"/>
		<xsl:call-template name="routing-summary-road-dialog-declaration"/>
		<xsl:call-template name="routing-summary-place-dialog-declaration"/>
		<xsl:call-template name="routing-summary-taking-in-dialog-declaration"/>
		<xsl:call-template name="routing-summary-final-destination-dialog-declaration"/>
		
	</xsl:template>
	
	<xd:doc>
		<xd:short>Routing Summary air dialog declaration</xd:short>
		<xd:detail>
			This template adds different parameter(such as label,name,value,size etc) for different template called inside this,
			Also adds CANCEL and OK button at the end of dialog
 		</xd:detail>
 	</xd:doc>
	<xsl:template name="routing-summary-air-dialog-declaration">
		<div id="routing-summary-air-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>

					<div>
						<xsl:if test="$displaymode = 'edit'">
							<xsl:call-template name="hidden-field">
								<xsl:with-param name="name">air_transport_sub_type_label</xsl:with-param>							
								<xsl:with-param name="value">
								<xsl:choose>
									<xsl:when test="air_transport_sub_type"><xsl:value-of select="localization:getDecode($language, 'N215', air_transport_sub_type)" /></xsl:when>
									<xsl:otherwise></xsl:otherwise>
								</xsl:choose>
								</xsl:with-param>							
							</xsl:call-template>
						</xsl:if>
						<xsl:choose>
							<xsl:when test="$displaymode='edit'">
								<xsl:call-template name="select-field">
									<xsl:with-param name="label">XSL_PO_ROUTING_SUMMARY_TRANSPORT_TYPE</xsl:with-param>
									<xsl:with-param name="name">air_transport_sub_type</xsl:with-param>
									<xsl:with-param name="required">Y</xsl:with-param>
									<xsl:with-param name="options">
										<option value="02">
											<xsl:value-of select="localization:getDecode($language, 'N215', '02')" />
										</option>&nbsp;
										<option value="01">
											<xsl:value-of select="localization:getDecode($language, 'N215', '01')" />
										</option>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:when>
							<xsl:otherwise>
								<xsl:call-template name="input-field">
									<xsl:with-param name="label">XSL_PO_ROUTING_SUMMARY_TRANSPORT_TYPE</xsl:with-param>
									<xsl:with-param name="name">air_transport_sub_type_label</xsl:with-param>
									<xsl:with-param name="override-displaymode">edit</xsl:with-param>
									<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
									<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
								</xsl:call-template>
							</xsl:otherwise>
						</xsl:choose>
						
						
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">air_transport_mode</xsl:with-param>
							<xsl:with-param name="value">01</xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="input-field">
							<!-- events : onfocus and onchange -->
							<xsl:with-param name="label">XSL_DETAILS_PO_ROUTING_SUMMARY_AIRPORT_CODE</xsl:with-param>
							<xsl:with-param name="name">airport_code</xsl:with-param>
							<xsl:with-param name="maxsize">6</xsl:with-param>
							<xsl:with-param name="fieldsize">x-small</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="input-field">
							<!-- events : onfocus and onchange -->
							<xsl:with-param name="label">XSL_DETAILS_PO_ROUTING_SUMMARY_TOWN</xsl:with-param>
							<xsl:with-param name="name">air_town</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>
						
						<xsl:call-template name="input-field">
							<!-- events : onfocus and onchange -->
							<xsl:with-param name="label">XSL_DETAILS_PO_ROUTING_SUMMARY_AIRPORT_NAME</xsl:with-param>
							<xsl:with-param name="name">airport_name</xsl:with-param>
							<xsl:with-param name="maxsize">35</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>
						<div class="dijitDialogPaneActionBar">
						<xsl:call-template name="label-wrapper">
							<xsl:with-param name="content">
								<button type="button" dojoType="dijit.form.Button">
									<xsl:attribute name="onmouseup">dijit.byId('routing-summary-air-dialog-template').hide();</xsl:attribute>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
								</button>
								<xsl:if test="$displaymode = 'edit'">
								<button dojoType="dijit.form.Button">
									<xsl:attribute name="onClick">dijit.byId('routing-summary-air-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
								</button>
								</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
						</div>
					</div>

		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Routing Summary sea dialog declaration</xd:short>
		<xd:detail>
			This template adds different parameter(such as label,name,value,size etc) for different template called inside this,
			Also adds CANCEL and OK button at the end of dialog
 		</xd:detail>
 	</xd:doc>
	<xsl:template name="routing-summary-sea-dialog-declaration">
		<div id="routing-summary-sea-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>

			<div>
				<xsl:if test="$displaymode = 'edit'">
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">sea_transport_sub_type_label</xsl:with-param>							
						<xsl:with-param name="value">
						<xsl:choose>
							<xsl:when test="sea_transport_sub_type"><xsl:value-of select="localization:getDecode($language, 'N215', sea_transport_sub_type)" /></xsl:when>
							<xsl:otherwise></xsl:otherwise>
						</xsl:choose>
						</xsl:with-param>							
					</xsl:call-template>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="$displaymode='edit'">
						<xsl:call-template name="select-field">
							<xsl:with-param name="label">XSL_PO_ROUTING_SUMMARY_TRANSPORT_TYPE</xsl:with-param>
							<xsl:with-param name="name">sea_transport_sub_type</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="required">Y</xsl:with-param>
							<xsl:with-param name="options">
								<option value="02">
									<xsl:value-of select="localization:getDecode($language, 'N215', '02')" />
								</option>&nbsp;
								<option value="01">
									<xsl:value-of select="localization:getDecode($language, 'N215', '01')" />
								</option>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PO_ROUTING_SUMMARY_TRANSPORT_TYPE</xsl:with-param>
							<xsl:with-param name="name">sea_transport_sub_type_label</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">sea_transport_mode</xsl:with-param>
					<xsl:with-param name="value">02</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_DETAILS_PO_ROUTING_SUMMARY_PORT</xsl:with-param>
					<xsl:with-param name="name">port_name</xsl:with-param>
					<xsl:with-param name="maxsize">35</xsl:with-param>
					<xsl:with-param name="override-displaymode">edit</xsl:with-param>
					<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
					<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
				</xsl:call-template>
				<div class="dijitDialogPaneActionBar">
				<xsl:call-template name="label-wrapper">
					<xsl:with-param name="content">
						<button type="button" dojoType="dijit.form.Button">
							<xsl:attribute name="onmouseup">dijit.byId('routing-summary-sea-dialog-template').hide();</xsl:attribute>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
						</button>	
						<xsl:if test="$displaymode = 'edit'">						
						<button dojoType="dijit.form.Button">
							<xsl:attribute name="onClick">dijit.byId('routing-summary-sea-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
						</button>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
				</div>
			</div>	
		</div>
	</xsl:template>
	
	
	<xd:doc>
		<xd:short>Routing Summary rail dialog declaration</xd:short>
		<xd:detail>
			This template adds different parameter(such as label,name,value,size etc) for different template called inside this,
			Also adds CANCEL and OK button at the end of dialog
 		</xd:detail>
 	</xd:doc>
	<xsl:template name="routing-summary-rail-dialog-declaration">
		<div id="routing-summary-rail-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>

				<div>
					<xsl:if test="$displaymode = 'edit'">
						<xsl:call-template name="hidden-field">
							<xsl:with-param name="name">rail_transport_sub_type_label</xsl:with-param>							
							<xsl:with-param name="value">
							<xsl:choose>
								<xsl:when test="rail_transport_sub_type"><xsl:value-of select="localization:getDecode($language, 'N215', rail_transport_sub_type)" /></xsl:when>
								<xsl:otherwise></xsl:otherwise>
							</xsl:choose>
							</xsl:with-param>							
						</xsl:call-template>
					</xsl:if>
					<xsl:choose>
						<xsl:when test="$displaymode='edit'">
							<xsl:call-template name="select-field">
								<xsl:with-param name="label">XSL_PO_ROUTING_SUMMARY_TRANSPORT_TYPE</xsl:with-param>
								<xsl:with-param name="name">rail_transport_sub_type</xsl:with-param>
								<xsl:with-param name="required">Y</xsl:with-param>
								<xsl:with-param name="options">
									<option value="02">
										<xsl:value-of select="localization:getDecode($language, 'N215', '02')" />
									</option>&nbsp;
									<option value="01">
										<xsl:value-of select="localization:getDecode($language, 'N215', '01')" />
									</option>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_PO_ROUTING_SUMMARY_TRANSPORT_TYPE</xsl:with-param>
								<xsl:with-param name="name">rail_transport_sub_type_label</xsl:with-param>
								<xsl:with-param name="override-displaymode">edit</xsl:with-param>
								<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
								<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
					
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">rail_transport_mode</xsl:with-param>
						<xsl:with-param name="value">04</xsl:with-param>
					</xsl:call-template>
					
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_DETAILS_PO_ROUTING_SUMMARY_PLACE</xsl:with-param>
						<xsl:with-param name="name">rail_place_name</xsl:with-param>
						<xsl:with-param name="maxsize">35</xsl:with-param>
						<xsl:with-param name="override-displaymode">edit</xsl:with-param>
						<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
						<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
					</xsl:call-template>
					<div class="dijitDialogPaneActionBar">
						<xsl:call-template name="label-wrapper">
							<xsl:with-param name="content">
								<button type="button" dojoType="dijit.form.Button">
									<xsl:attribute name="onmouseup">dijit.byId('routing-summary-rail-dialog-template').hide();</xsl:attribute>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
								</button>
								<xsl:if test="$displaymode = 'edit'">								
								<button dojoType="dijit.form.Button">
									<xsl:attribute name="onClick">dijit.byId('routing-summary-rail-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
								</button>
								</xsl:if>
							</xsl:with-param>
						</xsl:call-template>
					</div>
				</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Routing Summary road dialog declaration</xd:short>
		<xd:detail>
			This template adds different parameter(such as label,name,value,size etc) for different template called inside this,
			Also adds CANCEL and OK button at the end of dialog
 		</xd:detail>
 	</xd:doc>
	<xsl:template name="routing-summary-road-dialog-declaration">
		<div id="routing-summary-road-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>

			<div>
				<xsl:if test="$displaymode = 'edit'">
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">road_transport_sub_type_label</xsl:with-param>							
						<xsl:with-param name="value">
						<xsl:choose>
							<xsl:when test="road_transport_sub_type"><xsl:value-of select="localization:getDecode($language, 'N215', road_transport_sub_type)" /></xsl:when>
							<xsl:otherwise></xsl:otherwise>
						</xsl:choose>
						</xsl:with-param>							
					</xsl:call-template>
				</xsl:if>
				<xsl:choose>
     						<xsl:when test="$displaymode='edit'">
						<xsl:call-template name="select-field">
							<xsl:with-param name="label">XSL_PO_ROUTING_SUMMARY_TRANSPORT_TYPE</xsl:with-param>
							<xsl:with-param name="name">road_transport_sub_type</xsl:with-param>
							<xsl:with-param name="required">Y</xsl:with-param>
							<xsl:with-param name="options">
								<option value="02">
									<xsl:value-of select="localization:getDecode($language, 'N215', '02')" />
								</option>&nbsp;
								<option value="01">
									<xsl:value-of select="localization:getDecode($language, 'N215', '01')" />
								</option>
							</xsl:with-param>
						</xsl:call-template>
     						</xsl:when>
     						<xsl:otherwise>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PO_ROUTING_SUMMARY_TRANSPORT_TYPE</xsl:with-param>
							<xsl:with-param name="name">road_transport_sub_type_label</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>
     						</xsl:otherwise>
     					</xsl:choose>
										
				<xsl:call-template name="hidden-field">
					<xsl:with-param name="name">road_transport_mode</xsl:with-param>
					<xsl:with-param name="value">03</xsl:with-param>
				</xsl:call-template>
				
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_DETAILS_PO_ROUTING_SUMMARY_TAKING_IN_CHARGE</xsl:with-param>
					<xsl:with-param name="name">road_place_name</xsl:with-param>
					<xsl:with-param name="maxsize">35</xsl:with-param>
					<xsl:with-param name="override-displaymode">edit</xsl:with-param>
					<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
					<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
				</xsl:call-template>

				<div class="dijitDialogPaneActionBar">
				<xsl:call-template name="label-wrapper">
					<xsl:with-param name="content">
						<button type="button" dojoType="dijit.form.Button">
							<xsl:attribute name="onmouseup">dijit.byId('routing-summary-road-dialog-template').hide();</xsl:attribute>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
						</button>
						<xsl:if test="$displaymode = 'edit'">
						<button dojoType="dijit.form.Button">
							<xsl:attribute name="onClick">dijit.byId('routing-summary-road-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
						</button>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
				</div>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Routing Summary taking in dialog declaration</xd:short>
		<xd:detail>
			This template adds different parameter(such as label,name,value,size etc) for different template called inside this,
			Also adds CANCEL and OK button at the end of dialog
 		</xd:detail>
 	</xd:doc>
	<xsl:template name="routing-summary-taking-in-dialog-declaration">
		<div id="routing-summary-taking-in-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>

			<div>
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_DETAILS_PO_ROUTING_SUMMARY_TAKING_IN_CHARGE</xsl:with-param>
					<xsl:with-param name="name">taking_in_name</xsl:with-param>
					<xsl:with-param name="maxsize">35</xsl:with-param>
					<xsl:with-param name="override-displaymode">edit</xsl:with-param>
					<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
					<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
				</xsl:call-template>
				<div class="dijitDialogPaneActionBar">
				<xsl:call-template name="label-wrapper">
					<xsl:with-param name="content">
						<button type="button" dojoType="dijit.form.Button">
							<xsl:attribute name="onmouseup">dijit.byId('routing-summary-taking-in-dialog-template').hide();</xsl:attribute>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
						</button>
						<xsl:if test="$displaymode = 'edit'">
						<button dojoType="dijit.form.Button">
							<xsl:attribute name="onClick">dijit.byId('routing-summary-taking-in-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
						</button>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
				</div>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Routing Summary place dialog declaration</xd:short>
		<xd:detail>
			This template sets parameter of the template field called under this.It also displayes drop-down of tranport type(Departure and destination)This also adds buttons of cancel and ok at end of dialog box.
 		</xd:detail>
 	</xd:doc>
	<xsl:template name="routing-summary-place-dialog-declaration">
		<div id="routing-summary-place-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>

			<div>
				<xsl:if test="$displaymode = 'edit'">
					<xsl:call-template name="hidden-field">
						<xsl:with-param name="name">place_transport_sub_type_label</xsl:with-param>							
						<xsl:with-param name="value">
						<xsl:choose>
							<xsl:when test="place_transport_sub_type"><xsl:value-of select="localization:getDecode($language, 'N215', place_transport_sub_type)" /></xsl:when>
							<xsl:otherwise></xsl:otherwise>
						</xsl:choose>
						</xsl:with-param>							
					</xsl:call-template>
				</xsl:if>
				
				<xsl:choose>
     						<xsl:when test="$displaymode='edit'">
						<xsl:call-template name="select-field">
							<xsl:with-param name="label">XSL_PO_ROUTING_SUMMARY_TRANSPORT_TYPE</xsl:with-param>
							<xsl:with-param name="name">place_transport_sub_type</xsl:with-param>
							<xsl:with-param name="required">Y</xsl:with-param>
							<xsl:with-param name="options">
								<option value="02">
									<xsl:value-of select="localization:getDecode($language, 'N215', '02')" />
								</option>&nbsp;
								<option value="01">
									<xsl:value-of select="localization:getDecode($language, 'N215', '01')" />
								</option>
							</xsl:with-param>
						</xsl:call-template>
     						</xsl:when>
     						<xsl:otherwise>
						<xsl:call-template name="input-field">
							<xsl:with-param name="label">XSL_PO_ROUTING_SUMMARY_TRANSPORT_TYPE</xsl:with-param>
							<xsl:with-param name="name">place_transport_sub_type_label</xsl:with-param>
							<xsl:with-param name="override-displaymode">edit</xsl:with-param>
							<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
							<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
						</xsl:call-template>
     						</xsl:otherwise>
     					</xsl:choose>						
				
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_DETAILS_PO_ROUTING_SUMMARY_PLACE</xsl:with-param>
					<xsl:with-param name="name">place_name</xsl:with-param>
					<xsl:with-param name="maxsize">35</xsl:with-param>
					<xsl:with-param name="override-displaymode">edit</xsl:with-param>
					<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
					<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
				</xsl:call-template>
				<div class="dijitDialogPaneActionBar">
				<xsl:call-template name="label-wrapper">
					<xsl:with-param name="content">
						<button type="button" dojoType="dijit.form.Button">
							<xsl:attribute name="onmouseup">dijit.byId('routing-summary-place-dialog-template').hide();</xsl:attribute>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
						</button>
						<xsl:if test="$displaymode = 'edit'">
						<button dojoType="dijit.form.Button">
							<xsl:attribute name="onClick">dijit.byId('routing-summary-place-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
						</button>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
				</div>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Routing Summary final destination dialog declaration</xd:short>
		<xd:detail>
			This template adds different parameter(such as label,name,value,size etc) for different template called inside this,
			Also adds CANCEL and OK button at the end of dialog
 		</xd:detail>
 	</xd:doc>
	<xsl:template name="routing-summary-final-destination-dialog-declaration">
		<div id="routing-summary-final-destination-dialog-template" style="display:none" class="widgetContainer">
			<xsl:attribute name="title">Confirmation</xsl:attribute>

			<div>					
				<xsl:call-template name="input-field">
					<xsl:with-param name="label">XSL_DETAILS_PO_ROUTING_SUMMARY_PLACE_FINAL_DEST</xsl:with-param>
					<xsl:with-param name="name">final_destination_name</xsl:with-param>
					<xsl:with-param name="maxsize">35</xsl:with-param>
					<xsl:with-param name="override-displaymode">edit</xsl:with-param>
					<xsl:with-param name="appendClass">fscmLineItemInputField</xsl:with-param>
					<xsl:with-param name="regular-expression"><xsl:value-of select="defaultresource:getResource('PO_DESCRIPTION_REGEX')"/></xsl:with-param>
				</xsl:call-template>
				<div class="dijitDialogPaneActionBar">
				<xsl:call-template name="label-wrapper">
					<xsl:with-param name="content">
						<button type="button" dojoType="dijit.form.Button">
							<xsl:attribute name="onmouseup">dijit.byId('routing-summary-final-destination-dialog-template').hide();</xsl:attribute>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')" />
						</button>
						<xsl:if test="$displaymode = 'edit'">							
						<button dojoType="dijit.form.Button">
							<xsl:attribute name="onClick">dijit.byId('routing-summary-final-destination-dialog-template').gridMultipleItemsWidget.performValidation(); return false;</xsl:attribute>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')" />
						</button>
						</xsl:if>
					</xsl:with-param>
				</xsl:call-template>
				</div>
			</div>
		</div>
	</xsl:template>
	
	<xd:doc>
		<xd:short>Routing Summary generic declaration</xd:short>
		<xd:detail>
			This templayes displayes message of No item if no transport is used in routing summary and provides button to add a transport details
 		</xd:detail>
 		<xd:param name="label-add-button">label to add diffent button</xd:param>
 		<xd:param name="label-no-item">label when no item is present</xd:param>
 		<xd:param name="div id">id of specific grid on browser</xd:param>
 	</xd:doc>
	<xsl:template name="routing-summary-generic-declaration">
	<xsl:param name="label-add-button"></xsl:param>
	<xsl:param name="label-no-item"></xsl:param>
	<xsl:param name="div-id"></xsl:param>
	
		<div style="display:none">
		<xsl:attribute name="id"><xsl:value-of select="$div-id"/></xsl:attribute>
			<div class="clear multigrid">
				<div dojoAttachPoint="noItemLabelNode" class="empty-list-notice">
					<xsl:value-of select="localization:getGTPString($language, $label-no-item)" />
				</div>
				<div dojoAttachPoint="itemsNode">
					<div dojoAttachPoint="containerNode" />
				</div>
				<button type="button" dojoType="dijit.form.Button" dojoAttachEvent="onClick: addItem" dojoAttachPoint="addButtonNode">
					<xsl:value-of
						select="localization:getGTPString($language, $label-add-button)" />
				</button>
			</div>
		</div>
	</xsl:template>	
	
		<xd:doc>
		<xd:short>Routing Summary declaration</xd:short>
		<xd:detail>
			This templates gives label on button to add a transport and displayes a message when no transport is added.
 		</xd:detail>
 		</xd:doc>
	<xsl:template name="routing-summary-declaration">
		<!-- Dialog Start -->
		<xsl:call-template name="routing-summary-dialog-declaration" />
		<!-- Dialog End -->
		<!-- Air  -->
		<xsl:call-template name="routing-summary-generic-declaration">
			<xsl:with-param name="label-add-button">XSL_DETAILS_PO_ADD_ROUTING_SUMMARY_TRANSPORT_MODE_AIR</xsl:with-param>
			<xsl:with-param name="label-no-item">XSL_DETAILS_PO_NO_ROUTING_SUMMARY_TRANSPORT_MODE_AIR</xsl:with-param>
			<xsl:with-param name="div-id">routing-summary-air-template</xsl:with-param>
		</xsl:call-template>
		<!-- Sea  -->
		<xsl:call-template name="routing-summary-generic-declaration">
			<xsl:with-param name="label-add-button">XSL_DETAILS_PO_ADD_ROUTING_SUMMARY_TRANSPORT_MODE_SEA</xsl:with-param>
			<xsl:with-param name="label-no-item">XSL_DETAILS_PO_NO_ROUTING_SUMMARY_TRANSPORT_MODE_SEA</xsl:with-param>
			<xsl:with-param name="div-id">routing-summary-sea-template</xsl:with-param>
		</xsl:call-template>
		<!-- Rail  -->
		<xsl:call-template name="routing-summary-generic-declaration">
			<xsl:with-param name="label-add-button">XSL_DETAILS_PO_ADD_ROUTING_SUMMARY_TRANSPORT_MODE_RAIL</xsl:with-param>
			<xsl:with-param name="label-no-item">XSL_DETAILS_PO_NO_ROUTING_SUMMARY_TRANSPORT_MODE_RAIL</xsl:with-param>
			<xsl:with-param name="div-id">routing-summary-rail-template</xsl:with-param>
		</xsl:call-template>
		<!-- Road  -->
		<xsl:call-template name="routing-summary-generic-declaration">
			<xsl:with-param name="label-add-button">XSL_DETAILS_PO_ADD_ROUTING_SUMMARY_TRANSPORT_MODE_ROAD</xsl:with-param>
			<xsl:with-param name="label-no-item">XSL_DETAILS_PO_NO_ROUTING_SUMMARY_TRANSPORT_MODE_ROAD</xsl:with-param>
			<xsl:with-param name="div-id">routing-summary-road-template</xsl:with-param>
		</xsl:call-template>
		<!-- place  -->
		<xsl:call-template name="routing-summary-generic-declaration">
			<xsl:with-param name="label-add-button">XSL_DETAILS_PO_ADD_ROUTING_SUMMARY_PLACE</xsl:with-param>
			<xsl:with-param name="label-no-item">XSL_DETAILS_PO_NO_ROUTING_SUMMARY_PLACE</xsl:with-param>
			<xsl:with-param name="div-id">routing-summary-place-template</xsl:with-param>
		</xsl:call-template>
		<!-- final_Destination  -->
		<xsl:call-template name="routing-summary-generic-declaration">
			<xsl:with-param name="label-add-button">XSL_DETAILS_PO_ADD_ROUTING_SUMMARY_PLACE_FINAL_DEST</xsl:with-param>
			<xsl:with-param name="label-no-item">XSL_DETAILS_PO_NO_ROUTING_SUMMARY_PLACE_FINAL_DEST</xsl:with-param>
			<xsl:with-param name="div-id">routing-summary-final-destination-template</xsl:with-param>
		</xsl:call-template>
		<!-- taking in  -->
		<xsl:call-template name="routing-summary-generic-declaration">
			<xsl:with-param name="label-add-button">XSL_DETAILS_PO_ADD_ROUTING_SUMMARY_TAKING_IN_CHARGE</xsl:with-param>
			<xsl:with-param name="label-no-item">XSL_DETAILS_PO_NO_ROUTING_SUMMARY_TAKING_IN_CHARGE</xsl:with-param>
			<xsl:with-param name="div-id">routing-summary-taking-in-template</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	

	<xd:doc>
		<xd:short>Build Routing Summary</xd:short>
		<xd:detail>
			This templates takes different parameters and adds attributes and fills it with given selected value(based on condition of routing summary).
 		</xd:detail>
 		<xd:param name="items"> Items to be build to form display</xd:param>
 		<xd:param name="items-filter"> Items to be filter based on mode</xd:param>
 		<xd:param name="type-filter">Types to be filter based on mode</xd:param>
 		<xd:param name="no-items">Value from this is filled when an in no-item attribute</xd:param>
 		<xd:param name="id">Id of the form field for submission</xd:param>
 		<xd:param name="widget">This is added in dojotype</xd:param>
 		<xd:param name="override-displaymode">display mode can be overriden</xd:param>
 	</xd:doc>
	<xsl:template name="build-routing-summary-dojo-items">
		<xsl:param name="items" />
		<xsl:param name="items-filter" /><!-- transport mode numbre or PLACE,FINALDEST,TAKINGIN -->
		<xsl:param name="type-filter" /><!-- transport mode numbre or PLACE,FINALDEST,TAKINGIN -->
		<xsl:param name="no-items">N</xsl:param>
		<xsl:param name="id" />
		<xsl:param name="widget"/>
		<xsl:param name="override-displaymode" select="$displaymode"/> <!-- displaymode can be overriden to show field values in an edit form -->

		<div dojoType="">
			<xsl:attribute name="dialogAddItemTitle">

				<!-- Dialog Header Selection for Transport Type - Individual -->
				<xsl:if test="contains($id,'po-air-routing-summary')">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_ROUTING_SUMMARY_TRANSPORT_MODE_AIR')" />
				</xsl:if>
				<xsl:if test="contains($id,'po-sea-routing-summary')">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_ROUTING_SUMMARY_TRANSPORT_MODE_SEA')" />
				</xsl:if>
				<xsl:if test="contains($id,'po-rail-routing-summary')">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_ROUTING_SUMMARY_TRANSPORT_MODE_RAIL')" />
				</xsl:if>
				<xsl:if test="contains($id,'po-road-routing-summary')">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_ROUTING_SUMMARY_TRANSPORT_MODE_ROAD')" />
				</xsl:if>
	
				<!-- Dialog Header Selection for Transport Type - Multimodal -->	
				<xsl:if test="contains($id,'po-multimodal-air-routing-summary')">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_ROUTING_SUMMARY_TRANSPORT_MODE_AIR')" />
				</xsl:if>
				<xsl:if test="contains($id,'po-multimodal-sea-routing-summary')">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_ROUTING_SUMMARY_TRANSPORT_MODE_SEA')" />
				</xsl:if>
				<xsl:if test="contains($id,'po-multimodal-place-routing-summary')">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_ROUTING_SUMMARY_PLACE')" />
				</xsl:if>
				<xsl:if test="contains($id,'po-multimodal-taking-in-routing-summary')">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_ROUTING_SUMMARY_TAKING_IN_CHARGE')" />
				</xsl:if>
				<xsl:if test="contains($id,'po-multimodal-final-destination-routing-summary')">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_PO_ADD_ROUTING_SUMMARY_PLACE_FINAL_DEST')" />
				</xsl:if>
				
			</xsl:attribute>
			<xsl:attribute name="overrideDisplaymode"><xsl:value-of select="$override-displaymode"/></xsl:attribute>
			<xsl:attribute name="dojoType"><xsl:value-of select="$widget" /></xsl:attribute>
			<xsl:if test="$id != ''">
				<xsl:attribute name="id"><xsl:value-of select="$id" /></xsl:attribute>
			</xsl:if>
			<xsl:if test="$no-items='N'">			
			 <xsl:if test="$items">
				<xsl:for-each select="$items">
					<xsl:variable name="transport" select="." />
					<xsl:choose>
					<xsl:when test="($transport/transport_mode[.=$items-filter] and $transport/transport_type[.=$type-filter] and $transport/transport_type = '01')">
						<div dojoType="misys.openaccount.widget.Transport">
							<xsl:attribute name="id"><xsl:value-of select="concat($id, '_', 'misys_openaccount_widget_Transport_', position())" /></xsl:attribute>
							<xsl:attribute name="ref_id"><xsl:value-of
								select="$transport/ref_id" /></xsl:attribute>
							<xsl:attribute name="tnx_id"><xsl:value-of
								select="$transport/tnx_id" /></xsl:attribute>
							<xsl:attribute name="transport_id"><xsl:value-of
								select="$transport/transport_id" /></xsl:attribute>
							<xsl:attribute name="transport_mode"><xsl:value-of
								select="$transport/transport_mode" /></xsl:attribute>
							<xsl:attribute name="transport_type"><xsl:value-of
								select="$transport/transport_type" /></xsl:attribute>
							<xsl:attribute name="transport_sub_type"><xsl:value-of
								select="$transport/transport_sub_type" /></xsl:attribute>
							<xsl:attribute name="transport_sub_type_label"><xsl:value-of
										select="localization:getDecode($language, 'N215', $transport/transport_sub_type)" /></xsl:attribute>
							<xsl:attribute name="transport_group"><xsl:value-of
								select="$transport/transport_group" /></xsl:attribute>
							<xsl:choose>
								<xsl:when test="$transport/airport_discharge_name != ''">
									<xsl:attribute name="airport_name"><xsl:value-of select="$transport/airport_discharge_name" /></xsl:attribute>
								</xsl:when>
								<xsl:when test="$transport/airport_loading_name != ''">
									<xsl:attribute name="airport_name"><xsl:value-of select="$transport/airport_loading_name" /></xsl:attribute>
								</xsl:when>
							</xsl:choose>
							<xsl:choose>
								<xsl:when test="$transport/airport_discharge_code != ''">
									<xsl:attribute name="airport_code"><xsl:value-of select="$transport/airport_discharge_code" /></xsl:attribute>
								</xsl:when>
								<xsl:when test="$transport/airport_loading_code != ''">
									<xsl:attribute name="airport_code"><xsl:value-of select="$transport/airport_loading_code" /></xsl:attribute>
								</xsl:when>
							</xsl:choose>
							<xsl:choose>
								<xsl:when test="$transport/town_discharge != ''">
									<xsl:attribute name="town"><xsl:value-of select="$transport/town_discharge" /></xsl:attribute>
								</xsl:when>
								<xsl:when test="$transport/town_loading != ''">
									<xsl:attribute name="town"><xsl:value-of select="$transport/town_loading" /></xsl:attribute>
								</xsl:when>
							</xsl:choose>
							<xsl:choose>
								<xsl:when test="$transport/port_loading != ''">
									<xsl:attribute name="port_name"><xsl:value-of select="$transport/port_loading" /></xsl:attribute>
								</xsl:when>
								<xsl:when test="$transport/port_discharge != ''">
									<xsl:attribute name="port_name"><xsl:value-of select="$transport/port_discharge" /></xsl:attribute>
								</xsl:when>
							</xsl:choose>
							<xsl:choose>
								<xsl:when test="$transport/place_receipt != ''">
									<xsl:attribute name="place_name"><xsl:value-of select="$transport/place_receipt" /></xsl:attribute>
								</xsl:when>
								<xsl:when test="$transport/place_delivery != ''">
									<xsl:attribute name="place_name"><xsl:value-of select="$transport/place_delivery" /></xsl:attribute>
								</xsl:when>
							</xsl:choose>
							<xsl:if test="$transport/taking_in_charge != ''">
								<xsl:attribute name="taking_in"><xsl:value-of select="$transport/taking_in_charge" /></xsl:attribute>
							</xsl:if>
							<xsl:if test="$transport/place_final_dest != ''">
								<xsl:attribute name="final_place_name"><xsl:value-of select="$transport/place_final_dest" /></xsl:attribute>
							</xsl:if>
						</div>
					</xsl:when>
					<xsl:when test="($transport/transport_type = '02') 
									and (($transport/transport_mode[.=$items-filter] and $transport/transport_type[.=$type-filter]) or (($transport/place_receipt[.!=''] or $transport/place_delivery[.!='']) and $items-filter='PLACE')
									or ($transport/taking_in_charge[.!=''] and $items-filter='TAKINGIN')
									or ($transport/place_final_dest[.!=''] and $items-filter='FINALDEST'))">
						<div dojoType="misys.openaccount.widget.Transport">
							<xsl:attribute name="id"><xsl:value-of select="concat($id, '_', 'misys_openaccount_widget_Transport_', position())" /></xsl:attribute>
							<xsl:attribute name="ref_id"><xsl:value-of
								select="$transport/ref_id" /></xsl:attribute>
							<xsl:attribute name="tnx_id"><xsl:value-of
								select="$transport/tnx_id" /></xsl:attribute>
							<xsl:attribute name="transport_id"><xsl:value-of
								select="$transport/transport_id" /></xsl:attribute>
							<xsl:attribute name="transport_mode"><xsl:value-of
								select="$transport/transport_mode" /></xsl:attribute>
							<xsl:attribute name="transport_type"><xsl:value-of
								select="$transport/transport_type" /></xsl:attribute>
							<xsl:attribute name="transport_sub_type"><xsl:value-of
								select="$transport/transport_sub_type" /></xsl:attribute>
							<xsl:attribute name="transport_sub_type_label"><xsl:value-of
										select="localization:getDecode($language, 'N215', $transport/transport_sub_type)" /></xsl:attribute>
							<xsl:attribute name="transport_group"><xsl:value-of
								select="$transport/transport_group" /></xsl:attribute>
							<xsl:choose>
								<xsl:when test="$transport/airport_discharge_name != ''">
									<xsl:attribute name="airport_name"><xsl:value-of select="$transport/airport_discharge_name" /></xsl:attribute>
								</xsl:when>
								<xsl:when test="$transport/airport_loading_name != ''">
									<xsl:attribute name="airport_name"><xsl:value-of select="$transport/airport_loading_name" /></xsl:attribute>
								</xsl:when>
							</xsl:choose>
							<xsl:choose>
								<xsl:when test="$transport/airport_discharge_code != ''">
									<xsl:attribute name="airport_code"><xsl:value-of select="$transport/airport_discharge_code" /></xsl:attribute>
								</xsl:when>
								<xsl:when test="$transport/airport_loading_code != ''">
									<xsl:attribute name="airport_code"><xsl:value-of select="$transport/airport_loading_code" /></xsl:attribute>
								</xsl:when>
							</xsl:choose>
							<xsl:choose>
								<xsl:when test="$transport/town_discharge != ''">
									<xsl:attribute name="town"><xsl:value-of select="$transport/town_discharge" /></xsl:attribute>
								</xsl:when>
								<xsl:when test="$transport/town_loading != ''">
									<xsl:attribute name="town"><xsl:value-of select="$transport/town_loading" /></xsl:attribute>
								</xsl:when>
							</xsl:choose>
							<xsl:choose>
								<xsl:when test="$transport/port_loading != ''">
									<xsl:attribute name="port_name"><xsl:value-of select="$transport/port_loading" /></xsl:attribute>
								</xsl:when>
								<xsl:when test="$transport/port_discharge != ''">
									<xsl:attribute name="port_name"><xsl:value-of select="$transport/port_discharge" /></xsl:attribute>
								</xsl:when>
							</xsl:choose>
							<xsl:choose>
								<xsl:when test="$transport/place_receipt != ''">
									<xsl:attribute name="place_name"><xsl:value-of select="$transport/place_receipt" /></xsl:attribute>
								</xsl:when>
								<xsl:when test="$transport/place_delivery != ''">
									<xsl:attribute name="place_name"><xsl:value-of select="$transport/place_delivery" /></xsl:attribute>
								</xsl:when>
							</xsl:choose>
							<xsl:if test="$transport/taking_in_charge != ''">
								<xsl:attribute name="taking_in"><xsl:value-of select="$transport/taking_in_charge" /></xsl:attribute>
							</xsl:if>
							<xsl:if test="$transport/place_final_dest != ''">
								<xsl:attribute name="final_place_name"><xsl:value-of select="$transport/place_final_dest" /></xsl:attribute>
							</xsl:if>
						</div>
					</xsl:when>
					</xsl:choose>
				</xsl:for-each>
			</xsl:if>
			</xsl:if>
		</div>
	</xsl:template>


	<xd:doc>
		<xd:short>Routing summary individual-div</xd:short>
		<xd:detail>
			This template calls different template and sets different parameter of these template
 		</xd:detail>
 		<xd:param name="hidden">hidden field in routing summary</xd:param>
 		<xd:param name="prefix">Forms an id of the field when this is included</xd:param>
 		<xd:param name="no-items">Value from this is filled when an in no-item attribute</xd:param>
 		<xd:param name="isWidgetContainer">adds class attributes and fill it with WidgetContainer if its value is set to Y</xd:param>
 	</xd:doc>
	<xsl:template name="routing-summary-individuals-div">
	<xsl:param name="hidden">Y</xsl:param>
	<xsl:param name="prefix"></xsl:param>
	<xsl:param name="no-items">N</xsl:param>
	<xsl:param name="isWidgetContainer">Y</xsl:param>
	
	<xsl:variable name="varItems" select="routing_summaries/routing_summary"></xsl:variable>
		
	<div>
		<xsl:if test="$isWidgetContainer='Y'">
				<xsl:attribute name="class">widgetContainer</xsl:attribute>
		</xsl:if>
		<xsl:if test="$hidden='Y'">
				<xsl:attribute name="style">display:none</xsl:attribute>
		</xsl:if>

		<xsl:attribute name="id"><xsl:value-of select ="$prefix"/>routing-summary-individuals-div</xsl:attribute>
		<!-- Air widget -->
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_AIR</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="content">
			<!-- magical nbsp without it this widget is not parse!  -->
			<div>&nbsp;</div>
				
				<xsl:call-template name="build-routing-summary-dojo-items">
						<xsl:with-param name="items" select="$varItems"/>
						<xsl:with-param name="items-filter">01</xsl:with-param>
						<xsl:with-param name="type-filter">01</xsl:with-param>
						<xsl:with-param name="no-items"><xsl:value-of select ="$no-items"/></xsl:with-param>
						<xsl:with-param name="id"><xsl:value-of select ="$prefix"/>po-air-routing-summary</xsl:with-param>
						<xsl:with-param name="widget">misys.openaccount.widget.AirTransports</xsl:with-param>
				</xsl:call-template> 
			</xsl:with-param>
		</xsl:call-template>
		
		<!-- Sea widget -->
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_SEA</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="content">
			<!-- magical nbsp without it this widget is not parse!  -->
			<div>&nbsp;</div>
			<xsl:call-template name="build-routing-summary-dojo-items">
					<xsl:with-param name="items" select="$varItems"/>
					<xsl:with-param name="items-filter">02</xsl:with-param>
					<xsl:with-param name="no-items"><xsl:value-of select ="$no-items"/></xsl:with-param>
					<xsl:with-param name="type-filter">01</xsl:with-param>
					<xsl:with-param name="id"><xsl:value-of select ="$prefix"/>po-sea-routing-summary</xsl:with-param>
					<xsl:with-param name="widget">misys.openaccount.widget.SeaTransports</xsl:with-param>
			</xsl:call-template> 
			</xsl:with-param>
		</xsl:call-template>
		
		<!-- Rail widget -->
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_RAIL</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="content">
			<!-- magical nbsp without it this widget is not parse!  -->
			<div>&nbsp;</div>
			<xsl:call-template name="build-routing-summary-dojo-items">
					<xsl:with-param name="items" select="$varItems"/>
					<xsl:with-param name="items-filter">04</xsl:with-param>
					<xsl:with-param name="no-items"><xsl:value-of select ="$no-items"/></xsl:with-param>
					<xsl:with-param name="type-filter">01</xsl:with-param>
					<xsl:with-param name="id"><xsl:value-of select ="$prefix"/>po-rail-routing-summary</xsl:with-param>
					<xsl:with-param name="widget">misys.openaccount.widget.RailTransports</xsl:with-param>
			</xsl:call-template> 
			</xsl:with-param>
		</xsl:call-template>
		
		<!-- Road widget -->
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_ROAD</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="content">
			<!-- magical nbsp without it this widget is not parse!  -->
			<div>&nbsp;</div>
			<xsl:call-template name="build-routing-summary-dojo-items">
					<xsl:with-param name="items" select="$varItems"/>
					<xsl:with-param name="items-filter">03</xsl:with-param>
					<xsl:with-param name="no-items"><xsl:value-of select ="$no-items"/></xsl:with-param>
					<xsl:with-param name="type-filter">01</xsl:with-param>
					<xsl:with-param name="id"><xsl:value-of select ="$prefix"/>po-road-routing-summary</xsl:with-param>
					<xsl:with-param name="widget">misys.openaccount.widget.RoadTransports</xsl:with-param>
			</xsl:call-template> 
			</xsl:with-param>
		</xsl:call-template>

	</div>
	
	</xsl:template>
	
	<xd:doc>
		<xd:short>Routing summary multimodal-div</xd:short>
		<xd:detail>
			This template calls different template and sets different parameter of these template
 		</xd:detail>
 		<xd:param name="hidden">hidden field in routing summary</xd:param>
 		<xd:param name="prefix">Forms an id of the field when this is included</xd:param>
 		<xd:param name="no-items">Value from this is filled when an in no-item attribute</xd:param>
 		<xd:param name="isWidgetContainer">adds class attributes and fill it with WidgetContainer if its value is set to Y</xd:param>
 	</xd:doc>
	<xsl:template name="routing-summary-multimodal-div">
		<xsl:param name="hidden">Y</xsl:param>
		<xsl:param name="prefix"></xsl:param>
		<xsl:param name="no-items">N</xsl:param>
		<xsl:param name="isWidgetContainer">Y</xsl:param>
		
	
		<!-- <xsl:variable name="selectItems" select="routing_summaries/routing_summary"/> -->
		<xsl:variable name="varItems" select="routing_summaries/routing_summary"></xsl:variable>
	
		<div>
			<xsl:if test="$isWidgetContainer='Y'">
					<xsl:attribute name="class">widgetContainer</xsl:attribute>
			</xsl:if>
			<xsl:if test="$hidden='Y'">
					<xsl:attribute name="style">display:none</xsl:attribute>
			</xsl:if>
	
			<xsl:attribute name="id"><xsl:value-of select ="$prefix"/>routing-summary-multimodal-div</xsl:attribute>
			<!-- Air widget -->
			<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="legend">XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_AIR</xsl:with-param>
				<xsl:with-param name="legend-type">indented-header</xsl:with-param>
				<xsl:with-param name="content">
				<!-- magical nbsp without it this widget is not parse!  -->
				<div>&nbsp;</div>
				<xsl:call-template name="build-routing-summary-dojo-items">
					<xsl:with-param name="items" select="$varItems"/>
					<xsl:with-param name="items-filter">01</xsl:with-param>
					<xsl:with-param name="no-items"><xsl:value-of select ="$no-items"/></xsl:with-param>
					<xsl:with-param name="type-filter">02</xsl:with-param>
					<xsl:with-param name="id"><xsl:value-of select ="$prefix"/>po-multimodal-air-routing-summary</xsl:with-param>
					<xsl:with-param name="widget">misys.openaccount.widget.AirTransports</xsl:with-param>
				</xsl:call-template> 
				</xsl:with-param>
			</xsl:call-template>
			
			<!-- Sea widget -->
			<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="legend">XSL_HEADER_PO_ROUTING_SUMMARY_TRANSPORT_MODE_SEA</xsl:with-param>
				<xsl:with-param name="legend-type">indented-header</xsl:with-param>
				<xsl:with-param name="content">
				<!-- magical nbsp without it this widget is not parse!  -->
				<div>&nbsp;</div>
				<xsl:call-template name="build-routing-summary-dojo-items">
						<xsl:with-param name="items" select="$varItems"/>
						<xsl:with-param name="items-filter">02</xsl:with-param>
						<xsl:with-param name="no-items"><xsl:value-of select ="$no-items"/></xsl:with-param>
						<xsl:with-param name="type-filter">02</xsl:with-param>
						<xsl:with-param name="id"><xsl:value-of select ="$prefix"/>po-multimodal-sea-routing-summary</xsl:with-param>
						<xsl:with-param name="widget">misys.openaccount.widget.SeaTransports</xsl:with-param>
				</xsl:call-template> 
				</xsl:with-param>
			</xsl:call-template>
			
			<!-- place widget -->
			<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="legend">XSL_HEADER_PO_ROUTING_SUMMARY_PLACE</xsl:with-param>
				<xsl:with-param name="legend-type">indented-header</xsl:with-param>
				<xsl:with-param name="content">
				<!-- magical nbsp without it this widget is not parse!  -->
				<div>&nbsp;</div>
				<xsl:call-template name="build-routing-summary-dojo-items">
						<xsl:with-param name="items" select="$varItems"/>
						<xsl:with-param name="items-filter">PLACE</xsl:with-param>
						<xsl:with-param name="no-items"><xsl:value-of select ="$no-items"/></xsl:with-param>
						<xsl:with-param name="type-filter">02</xsl:with-param>
						<xsl:with-param name="id"><xsl:value-of select ="$prefix"/>po-multimodal-place-routing-summary</xsl:with-param>
						<xsl:with-param name="widget">misys.openaccount.widget.PlaceTransports</xsl:with-param>
				</xsl:call-template> 
				</xsl:with-param>
			</xsl:call-template>
			
			<!-- taking in widget -->
			<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="legend">XSL_HEADER_PO_ROUTING_SUMMARY_TAKING_IN_CHARGE</xsl:with-param>
				<xsl:with-param name="legend-type">indented-header</xsl:with-param>
				<xsl:with-param name="content">
				<!-- magical nbsp without it this widget is not parse!  -->
				<div>&nbsp;</div>
				<xsl:call-template name="build-routing-summary-dojo-items">
						<xsl:with-param name="items" select="$varItems"/>
						<xsl:with-param name="items-filter">TAKINGIN</xsl:with-param>
						<xsl:with-param name="no-items"><xsl:value-of select ="$no-items"/></xsl:with-param>
						<xsl:with-param name="type-filter">02</xsl:with-param>
						<xsl:with-param name="id"><xsl:value-of select ="$prefix"/>po-multimodal-taking-in-routing-summary</xsl:with-param>
						<xsl:with-param name="widget">misys.openaccount.widget.TakingInTransports</xsl:with-param>
				</xsl:call-template> 
				</xsl:with-param>
			</xsl:call-template>
			
			<!-- fianl destination widget -->
			<xsl:call-template name="fieldset-wrapper">
				<xsl:with-param name="legend">XSL_HEADER_PO_ROUTING_SUMMARY_PLACE_FINAL_DEST</xsl:with-param>
				<xsl:with-param name="legend-type">indented-header</xsl:with-param>
				<xsl:with-param name="content">
				<!-- magical nbsp without it this widget is not parse!  -->
				<div>&nbsp;</div>
				<xsl:call-template name="build-routing-summary-dojo-items">
						<xsl:with-param name="items" select="$varItems"/>
						<xsl:with-param name="items-filter">FINALDEST</xsl:with-param>
						<xsl:with-param name="no-items"><xsl:value-of select ="$no-items"/></xsl:with-param>
						<xsl:with-param name="type-filter">02</xsl:with-param>
						<xsl:with-param name="id"><xsl:value-of select ="$prefix"/>po-multimodal-final-destination-routing-summary</xsl:with-param>
						<xsl:with-param name="widget">misys.openaccount.widget.FinalDestinationTransports</xsl:with-param>
				</xsl:call-template> 
				</xsl:with-param>
			</xsl:call-template>
		</div>
	</xsl:template>
	<!-- ************************* -->
	<!-- Routing Summary For IN/IP -->
	<!-- ************************* -->
		
</xsl:stylesheet>
