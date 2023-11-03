<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates that are common to all Letter of Credit forms for displaying
updated data (i.e. LC, SI).

Letter of Credit forms should import this template after importing
trade_common.xsl (on the customer side) or bank_common.xsl (on the bank
side).

Copyright (c) 2000-2017 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      28/09/17
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
    xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools" 
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	xmlns:common="http://exslt.org/common"
	xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
	exclude-result-prefixes="localization utils common security">

	<!-- This template displays the common general details fieldset of the transaction like ref_id, bo_ref_id, template_id etc.-->
	<xd:doc>
		<xd:short>LC common general details.</xd:short>
		<xd:detail>
		Common general detail fieldset.
		</xd:detail>
	</xd:doc>
	<xsl:template name="common-general-details-amend">
		<xsl:param name="show-template-id">Y</xsl:param>
		<xsl:param name="show-cust-ref-id">Y</xsl:param>
		<xsl:param name="cross-ref-summary-option"/>
		<xsl:param name="path"/>
		<xsl:param name="org_path"/>
		<xsl:param name="org_path1">N</xsl:param>

		<!--  System ID. -->
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_GENERALDETAILS_REF_ID</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/ref_id"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/ref_id"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/ref_id"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>

		<!-- Bank Reference -->
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_GENERALDETAILS_BO_REF_ID</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/bo_ref_id"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/bo_ref_id"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/bo_ref_id"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>

		<!-- Cross Refs -->
		<!-- Shown in consolidated view  -->
		<xsl:if test="common:node-set($path)/cross_references">
			<xsl:apply-templates select="common:node-set($path)/cross_references" mode="display_table_tnx">
				<xsl:with-param name="cross-ref-summary-option">
					<xsl:value-of select="$cross-ref-summary-option"/>
				</xsl:with-param>
			</xsl:apply-templates>
		</xsl:if>

		<!-- Template ID. -->
		<xsl:if test="$show-template-id='Y'">
			<xsl:call-template name="amend-input-field">
				<xsl:with-param name="label">XSL_GENERALDETAILS_TEMPLATE_ID</xsl:with-param>
				<xsl:with-param name="text">
					<xsl:value-of select="common:node-set($path)/template_id"/>
				</xsl:with-param>
				<xsl:with-param name="org-text">
					<xsl:value-of select="common:node-set($org_path)/template_id"/>
				</xsl:with-param>
				<xsl:with-param name="tnx-text">
					<xsl:value-of select="common:node-set($org_path1)/template_id"/>
				</xsl:with-param>
				<xsl:with-param name="master" select="$org_path1" />
			</xsl:call-template>
		</xsl:if>

		<!-- Customer reference -->
		<xsl:if test="$show-cust-ref-id='Y'">
			<xsl:call-template name="amend-input-field">
				<xsl:with-param name="label">XSL_GENERALDETAILS_CUST_REF_ID</xsl:with-param>
				<xsl:with-param name="text">
					<xsl:value-of select="common:node-set($path)/cust_ref_id"/>
				</xsl:with-param>
				<xsl:with-param name="org-text">
					<xsl:value-of select="common:node-set($org_path)/cust_ref_id"/>
				</xsl:with-param>
				<xsl:with-param name="tnx-text">
					<xsl:value-of select="common:node-set($org_path1)/cust_ref_id"/>
				</xsl:with-param>
				<xsl:with-param name="master" select="$org_path1" />
			</xsl:call-template>
		</xsl:if>

		<!--  Application date. -->
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_GENERALDETAILS_APPLICATION_DATE</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/appl_date"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/appl_date"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/appl_date"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>
	</xsl:template>
	
	<!-- This template displays the Charge details fieldset of the transaction -->
	<xsl:template name="amend-charges-details">
		<xsl:param name="path"/>
		<xsl:param name="org_path"/>
		<xsl:param name="org_path1">N</xsl:param>
		<xsl:param name="in_sesion"/>
		<xsl:param name="existing-attachments" select="common:node-set($path)/charges/charge"/>
		<xsl:for-each select="$existing-attachments">
		  <xsl:if test="created_in_session[.=$in_sesion] or $in_sesion =''">
			<xsl:call-template name="amend-input-field">
				<xsl:with-param name="label">XSL_REPORTINGDETAILS_CHARGE_HEADER_CHARGE</xsl:with-param>
				<xsl:with-param name="text">
					<xsl:choose>
				       <xsl:when test="chrg_code[.='ISSFEE']">
				        <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_CODE_ISSFEE')"/>
				       </xsl:when>
				       <xsl:when test="chrg_code[.='COMMISSION']">
				        <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_CODE_COMMISSION')"/>
				       </xsl:when>
				       <xsl:when test="chrg_code[.='OTHER']">
				        <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_CODE_OTHER')"/>
				       </xsl:when>
				    </xsl:choose>
				</xsl:with-param>
				<xsl:with-param name="org-text">
					<xsl:choose>
				       <xsl:when test="chrg_code[.='ISSFEE']">
				        <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_CODE_ISSFEE')"/>
				       </xsl:when>
				       <xsl:when test="chrg_code[.='COMMISSION']">
				        <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_CODE_COMMISSION')"/>
				       </xsl:when>
				       <xsl:when test="chrg_code[.='OTHER']">
				        <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_CODE_OTHER')"/>
				       </xsl:when>
				    </xsl:choose>
				</xsl:with-param>
				<xsl:with-param name="tnx-text">
					<xsl:choose>
				       <xsl:when test="chrg_code[.='ISSFEE']">
				        <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_CODE_ISSFEE')"/>
				       </xsl:when>
				       <xsl:when test="chrg_code[.='COMMISSION']">
				        <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_CODE_COMMISSION')"/>
				       </xsl:when>
				       <xsl:when test="chrg_code[.='OTHER']">
				        <xsl:value-of select="localization:getGTPString($language, 'XSL_CHARGE_CODE_OTHER')"/>
				       </xsl:when>
				    </xsl:choose>
				</xsl:with-param>
				<xsl:with-param name="master" select="$org_path1" />
			</xsl:call-template>
			<xsl:call-template name="amend-input-field">
				<xsl:with-param name="label">XSL_REPORTINGDETAILS_CHARGE_HEADER_COMMENT</xsl:with-param>
				<xsl:with-param name="text">
				        <xsl:value-of select="additional_comment"/>
				</xsl:with-param>
				<xsl:with-param name="org-text">
					<xsl:value-of select="additional_comment"/>
				</xsl:with-param>
				<xsl:with-param name="tnx-text">
					<xsl:value-of select="additional_comment"/>
				</xsl:with-param>
				<xsl:with-param name="master" select="$org_path1" />
			</xsl:call-template>
			<xsl:call-template name="amend-input-field">
				<xsl:with-param name="label">XSL_REPORTINGDETAILS_CHARGE_HEADER_AMOUNT</xsl:with-param>
				<xsl:with-param name="text"><xsl:value-of select="cur_code"/>
				        <xsl:value-of select="amt"/>
				</xsl:with-param>
				<xsl:with-param name="org-text"><xsl:value-of select="cur_code"/>
					<xsl:value-of select="amt"/>
				</xsl:with-param>
				<xsl:with-param name="tnx-text"><xsl:value-of select="cur_code"/>
					<xsl:value-of select="amt"/>
				</xsl:with-param>
				<xsl:with-param name="master" select="$org_path1" />
			</xsl:call-template>
			<xsl:call-template name="amend-input-field">
				<xsl:with-param name="label">XSL_REPORTINGDETAILS_CHARGE_HEADER_STATUS</xsl:with-param>
				<xsl:with-param name="text">
					<xsl:choose>
				       <xsl:when test="status[.=01]">
				        <xsl:value-of select="localization:getDecode($language, 'N057', '01')"/>
				       </xsl:when>
				       <xsl:when test="status[.=02]">
				        <xsl:value-of select="localization:getDecode($language, 'N057', '02')"/>
				       </xsl:when>
				       <xsl:when test="status[.=03]">
				        <xsl:value-of select="localization:getDecode($language, 'N057', '03')"/>
				       </xsl:when>
				       <xsl:when test="status[.=99]">
				        <xsl:value-of select="localization:getDecode($language, 'N057', '99')"/>
				       </xsl:when>
				    </xsl:choose>
				</xsl:with-param>
				<xsl:with-param name="org-text">
					<xsl:choose>
				       <xsl:when test="status[.=01]">
				        <xsl:value-of select="localization:getDecode($language, 'N057', '01')"/>
				       </xsl:when>
				       <xsl:when test="status[.=02]">
				        <xsl:value-of select="localization:getDecode($language, 'N057', '02')"/>
				       </xsl:when>
				       <xsl:when test="status[.=03]">
				        <xsl:value-of select="localization:getDecode($language, 'N057', '03')"/>
				       </xsl:when>
				       <xsl:when test="status[.=99]">
				        <xsl:value-of select="localization:getDecode($language, 'N057', '99')"/>
				       </xsl:when>
				    </xsl:choose>
				</xsl:with-param>
				<xsl:with-param name="tnx-text">
					<xsl:choose>
				       <xsl:when test="status[.=01]">
				        <xsl:value-of select="localization:getDecode($language, 'N057', '01')"/>
				       </xsl:when>
				       <xsl:when test="status[.=02]">
				        <xsl:value-of select="localization:getDecode($language, 'N057', '02')"/>
				       </xsl:when>
				       <xsl:when test="status[.=03]">
				        <xsl:value-of select="localization:getDecode($language, 'N057', '03')"/>
				       </xsl:when>
				       <xsl:when test="status[.=99]">
				        <xsl:value-of select="localization:getDecode($language, 'N057', '99')"/>
				       </xsl:when>
				    </xsl:choose>
				</xsl:with-param>
				<xsl:with-param name="master" select="$org_path1" />
			</xsl:call-template>
			<xsl:call-template name="amend-input-field">
				<xsl:with-param name="label">XSL_REPORTINGDETAILS_CHARGE_HEADER_SETTLEMENT_DATE</xsl:with-param>
				<xsl:with-param name="text">
				        <xsl:value-of select="settlement_date"/>
				</xsl:with-param>
				<xsl:with-param name="org-text">
					<xsl:value-of select="settlement_date"/>
				</xsl:with-param>
				<xsl:with-param name="tnx-text">
					<xsl:value-of select="settlement_date"/>
				</xsl:with-param>
				<xsl:with-param name="master" select="$org_path1" />
			</xsl:call-template>
			<br/>
			</xsl:if>
		</xsl:for-each>
	</xsl:template>

	<!-- This template displays the LC general details fieldset of the transaction -->
	<xsl:template name="lc-general-details-amend">
		<xsl:param name="path"/>
		<xsl:param name="org_path"/>
		<xsl:param name="org_path1">N</xsl:param>
		
		<!-- Issueing reference  Displayed in consolidated view -->
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_GENERALDETAILS_IMPORT_LC_REF_ID</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/lc_ref_id"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/lc_ref_id"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/lc_ref_id"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>

		<!-- Issue Date Displayed in consolidated view -->
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_GENERALDETAILS_ISSUE_DATE</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/iss_date"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/iss_date"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/iss_date"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>

		<!-- Expiry Type -->
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">GENERALDETAILS_EXPIRY_TYPE</xsl:with-param>
			<xsl:with-param name="text">
			   <xsl:choose>
					<xsl:when test="common:node-set($path)/lc_exp_date_type_code[.='01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_LC_EXP_DATE_TYPE_SPECIFIC')"/></xsl:when>
					<xsl:when test="common:node-set($path)/lc_exp_date_type_code[.='02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_LC_EXP_DATE_TYPE_CONDITIONAL')"/></xsl:when>
					<xsl:when test="common:node-set($path)/lc_exp_date_type_code[.='03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_LC_EXP_DATE_TYPE_UNLIMITED')"/></xsl:when>
				</xsl:choose>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:choose>
					<xsl:when test="common:node-set($org_path)/lc_exp_date_type_code[.='01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_LC_EXP_DATE_TYPE_SPECIFIC')"/></xsl:when>
					<xsl:when test="common:node-set($org_path)/lc_exp_date_type_code[.='02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_LC_EXP_DATE_TYPE_CONDITIONAL')"/></xsl:when>
					<xsl:when test="common:node-set($org_path)/lc_exp_date_type_code[.='03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_LC_EXP_DATE_TYPE_UNLIMITED')"/></xsl:when>
				</xsl:choose>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:choose>
					<xsl:when test="common:node-set($org_path1)/lc_exp_date_type_code[.='01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_LC_EXP_DATE_TYPE_SPECIFIC')"/></xsl:when>
					<xsl:when test="common:node-set($org_path1)/lc_exp_date_type_code[.='02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_LC_EXP_DATE_TYPE_CONDITIONAL')"/></xsl:when>
					<xsl:when test="common:node-set($org_path1)/lc_exp_date_type_code[.='03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_LC_EXP_DATE_TYPE_UNLIMITED')"/></xsl:when>
				</xsl:choose>		
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>


		<!--  Expiry Date. -->
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/exp_date"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/exp_date"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/exp_date"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>		
		<!--  Expiry Event -->
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_EVENT</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/exp_event"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/exp_event"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/exp_event"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>		
		<!-- Expiry place. -->
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_PLACE</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/expiry_place"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/expiry_place"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/expiry_place"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>
		
		<!--  Amendment Number -->
		 <xsl:call-template name="amend-input-field">
             <xsl:with-param name="label">XSL_GENERALDETAILS_AMD_NO</xsl:with-param>
             <xsl:with-param name="text">
				<xsl:value-of select="utils:formatAmdNo(common:node-set($path)/amd_no)"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="utils:formatAmdNo(common:node-set($org_path)/amd_no)"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="utils:formatAmdNo(common:node-set($org_path1)/amd_no)"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
         </xsl:call-template>
		
		<!--  Lc Govern Country. -->
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_LC_PLACE_OF_JURISDICTION</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/lc_govern_country"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/lc_govern_country"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/lc_govern_country"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>
		
		<!--  Lc Govern Law Text. -->
		<xsl:call-template name="amend-input-field">
		<xsl:with-param name="label">GOVERNING_LABEL</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/lc_govern_text"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/lc_govern_text"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/lc_govern_text"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>		 

		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_DEMAND_INDICATOR</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:choose>
					<xsl:when test="common:node-set($path)/demand_indicator[.='NMLT']"><xsl:value-of select="localization:getGTPString($language, 'XSL_DEMAND_INDICATOR_NMLT')"/>&nbsp;</xsl:when>
					<xsl:when test="common:node-set($path)/demand_indicator[.='NMPT']"><xsl:value-of select="localization:getGTPString($language, 'XSL_DEMAND_INDICATOR_NMPT')"/>&nbsp;</xsl:when>
					<xsl:when test="common:node-set($path)/demand_indicator[.='NPRT']"><xsl:value-of select="localization:getGTPString($language, 'XSL_DEMAND_INDICATOR_NPRT')"/>&nbsp;</xsl:when>
					<xsl:when test="common:node-set($path)/demand_indicator[.='PMPT']"><xsl:value-of select="localization:getGTPString($language, 'XSL_DEMAND_INDICATOR_PMPT')"/>&nbsp;</xsl:when>
				</xsl:choose>				  
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:choose>
					<xsl:when test="common:node-set($org_path)/demand_indicator[.='NMLT']"><xsl:value-of select="localization:getGTPString($language, 'XSL_DEMAND_INDICATOR_NMLT')"/>&nbsp;</xsl:when>
					<xsl:when test="common:node-set($org_path)/demand_indicator[.='NMPT']"><xsl:value-of select="localization:getGTPString($language, 'XSL_DEMAND_INDICATOR_NMPT')"/>&nbsp;</xsl:when>
					<xsl:when test="common:node-set($org_path)/demand_indicator[.='NPRT']"><xsl:value-of select="localization:getGTPString($language, 'XSL_DEMAND_INDICATOR_NPRT')"/>&nbsp;</xsl:when>
					<xsl:when test="common:node-set($org_path)/demand_indicator[.='PMPT']"><xsl:value-of select="localization:getGTPString($language, 'XSL_DEMAND_INDICATOR_PMPT')"/>&nbsp;</xsl:when>
				</xsl:choose>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:choose>
					<xsl:when test="common:node-set($org_path1)/demand_indicator[.='NMLT']"><xsl:value-of select="localization:getGTPString($language, 'XSL_DEMAND_INDICATOR_NMLT')"/>&nbsp;</xsl:when>
					<xsl:when test="common:node-set($org_path1)/demand_indicator[.='NMPT']"><xsl:value-of select="localization:getGTPString($language, 'XSL_DEMAND_INDICATOR_NMPT')"/>&nbsp;</xsl:when>
					<xsl:when test="common:node-set($org_path1)/demand_indicator[.='NPRT']"><xsl:value-of select="localization:getGTPString($language, 'XSL_DEMAND_INDICATOR_NPRT')"/>&nbsp;</xsl:when>
					<xsl:when test="common:node-set($org_path1)/demand_indicator[.='PMPT']"><xsl:value-of select="localization:getGTPString($language, 'XSL_DEMAND_INDICATOR_PMPT')"/>&nbsp;</xsl:when>
				</xsl:choose>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>		 

		<!--  Transfer Condition. -->
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">TRANSFER_CONDITION</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/narrative_transfer_conditions/text"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/narrative_transfer_conditions/text"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/narrative_transfer_conditions/text"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>
		
		<!--  Delivery Mode. -->
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_BENE_ADVICE_DELIVERY_MODE</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:choose>
					<xsl:when test="common:node-set($path)/delv_org[.='01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_COLLECTION')"/>&nbsp;</xsl:when>
					<xsl:when test="common:node-set($path)/delv_org[.='02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_COURIER')"/>&nbsp;</xsl:when>
					<xsl:when test="common:node-set($path)/delv_org[.='03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_MAIL')"/>&nbsp;</xsl:when>
					<xsl:when test="common:node-set($path)/delv_org[.='04']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_MESSENGER')"/>&nbsp;</xsl:when>
					<xsl:when test="common:node-set($path)/delv_org[.='05']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_REGISTERED_MAIL')"/>&nbsp;</xsl:when>
					<xsl:when test="common:node-set($path)/delv_org[.='99']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_OTHER')"/>&nbsp;</xsl:when>
				</xsl:choose>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:choose>
					<xsl:when test="common:node-set($org_path)/delv_org[.='01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_COLLECTION')"/>&nbsp;</xsl:when>
					<xsl:when test="common:node-set($org_path)/delv_org[.='02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_COURIER')"/>&nbsp;</xsl:when>
					<xsl:when test="common:node-set($org_path)/delv_org[.='03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_MAIL')"/>&nbsp;</xsl:when>
					<xsl:when test="common:node-set($org_path)/delv_org[.='04']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_MESSENGER')"/>&nbsp;</xsl:when>
					<xsl:when test="common:node-set($org_path)/delv_org[.='05']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_REGISTERED_MAIL')"/>&nbsp;</xsl:when>
					<xsl:when test="common:node-set($org_path)/delv_org[.='99']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_OTHER')"/>&nbsp;</xsl:when>
				</xsl:choose>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
			<xsl:choose>
					<xsl:when test="common:node-set($org_path1)/delv_org[.='01']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_COLLECTION')"/>&nbsp;</xsl:when>
					<xsl:when test="common:node-set($org_path1)/delv_org[.='02']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_COURIER')"/>&nbsp;</xsl:when>
					<xsl:when test="common:node-set($org_path1)/delv_org[.='03']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_MAIL')"/>&nbsp;</xsl:when>
					<xsl:when test="common:node-set($org_path1)/delv_org[.='04']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_MESSENGER')"/>&nbsp;</xsl:when>
					<xsl:when test="common:node-set($org_path1)/delv_org[.='05']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_REGISTERED_MAIL')"/>&nbsp;</xsl:when>
					<xsl:when test="common:node-set($org_path1)/delv_org[.='99']"><xsl:value-of select="localization:getGTPString($language, 'XSL_BENE_ADVICE_DELIVERY_MODE_BY_OTHER')"/>&nbsp;</xsl:when>
				</xsl:choose>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>
		
		<!-- Delivery Mode Other Text. -->
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/delv_org_text"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/delv_org_text"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/delv_org_text"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>
		
		<!-- Delivery To. -->
		<xsl:call-template name="amend-input-field">
		<xsl:with-param name="label">XSL_LC_DELIVERY_TO_COLLECTION_BY</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:variable name="delv_to_code"><xsl:value-of select="common:node-set($path)/delivery_to"></xsl:value-of></xsl:variable>		
				<xsl:value-of select="localization:getDecode($language, 'N292', $delv_to_code)"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:variable name="delv_to_code"><xsl:value-of select="common:node-set($org_path)/delivery_to"></xsl:value-of></xsl:variable>			
				<xsl:value-of select="localization:getDecode($language, 'N292', $delv_to_code)"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:variable name="delv_to_code"><xsl:value-of select="common:node-set($org_path1)/delivery_to"></xsl:value-of></xsl:variable>		
				<xsl:value-of select="localization:getDecode($language, 'N292', $delv_to_code)"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>
		
		<!-- Delivery To Other Text. -->
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/narrative_delivery_to/text"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/narrative_delivery_to/text"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/narrative_delivery_to/text"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>
		
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_AMEND_CANCELLATION_REQUEST_VIEW</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/cancellation_req_flag"/>
			</xsl:with-param>
			<xsl:with-param name="text">
					<xsl:choose>
				       <xsl:when test="common:node-set($path)/cancellation_req_flag[.='N']">
				        <xsl:value-of select="localization:getGTPString($language, 'N034_NO')"/>
				       </xsl:when>
				       <xsl:when test="common:node-set($path)/cancellation_req_flag[.='Y']">
				        <xsl:value-of select="localization:getGTPString($language, 'N034_YES')"/>
				       </xsl:when>
				    </xsl:choose>
				</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:choose>
				       <xsl:when test="common:node-set($org_path)/cancellation_req_flag[.='N']">
				        <xsl:value-of select="localization:getGTPString($language, 'N034_NO')"/>
				       </xsl:when>
				       <xsl:when test="common:node-set($org_path)/cancellation_req_flag[.='Y']">
				        <xsl:value-of select="localization:getGTPString($language, 'N034_YES')"/>
				       </xsl:when>
				    </xsl:choose>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:choose>
				       <xsl:when test="common:node-set($org_path1)/cancellation_req_flag[.='N']">
				        <xsl:value-of select="localization:getGTPString($language, 'N034_NO')"/>
				       </xsl:when>
				       <xsl:when test="common:node-set($org_path1)/cancellation_req_flag[.='Y']">
				        <xsl:value-of select="localization:getGTPString($language, 'N034_YES')"/>
				       </xsl:when>
				    </xsl:choose>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>
		<!-- 
	    Change show-eucp (global param in the main xslt of the form) to Y to show the EUCP section.
	    Pass in a show-presentation parameter set to Y to display the presentation fields.
	    
	    If set to N, the template will instead insert a hidden field with the value 1.0
	   -->
		<xsl:call-template name="eucp-details">
			<xsl:with-param name="show-eucp" select="$show-eucp"/>
		</xsl:call-template>
	</xsl:template>	

	<!-- This template displays the applicant address -->
	<xsl:template name="applicantaddress"> 
		<xsl:param name="path"/>
		<xsl:param name="org_path"/>
		<xsl:param name="org_path1">N</xsl:param>
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_PARTIESDETAILS_ENTITY</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/entity"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/entity"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/entity"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>

		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/applicant_name"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/applicant_name"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/applicant_name"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>

		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/applicant_address_line_1"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/applicant_address_line_1"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/applicant_address_line_1"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />	   
		</xsl:call-template>

		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/applicant_address_line_2"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/applicant_address_line_2"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/applicant_address_line_2"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>

		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_PARTIESDETAILS_CONTRY</xsl:with-param>
			<xsl:with-param name="value" select="localization:getCodeData($language,'*','*','C006',common:node-set($path)/applicant_country)"/>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/applicant_country"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/applicant_country"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/applicant_country"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
			<xsl:with-param name="translate-as">country</xsl:with-param>
		</xsl:call-template>

		<xsl:call-template name="amend-input-field">		   
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/applicant_dom"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/applicant_dom"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/applicant_dom"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
			<xsl:with-param name="text">
         		<xsl:value-of select="utils:decryptApplicantReference(common:node-set($path)/applicant_reference)"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="utils:decryptApplicantReference(common:node-set($org_path)/applicant_reference)"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
         		<xsl:value-of select="utils:decryptApplicantReference(common:node-set($org_path1)/applicant_reference)"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>
	</xsl:template>	

	<!-- This template displays the alternate applicant address -->
	<xsl:template name="alt-applicantaddress"> 
		<xsl:param name="path"/>
		<xsl:param name="org_path"/>
		<xsl:param name="org_path1">N</xsl:param>

		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_PARTIESDETAILS_ALT_APPLICANT_NAME</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/alt_applicant_name"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/alt_applicant_name"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/alt_applicant_name"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>

		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_PARTIESDETAILS_ALT_APPLICANT_ADDRESS</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/alt_applicant_address_line_1"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/alt_applicant_address_line_1"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/alt_applicant_address_line_1"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>

		<xsl:call-template name="amend-input-field">
			<!-- <xsl:with-param name="label">XSL_PARTIESDETAILS_ALT_APPLICANT_ADDRESS</xsl:with-param> -->
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/alt_applicant_address_line_2"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/alt_applicant_address_line_2"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/alt_applicant_address_line_2"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>

		<xsl:call-template name="amend-input-field">
			<!-- <xsl:with-param name="label">XSL_PARTIESDETAILS_ALT_APPLICANT_ADDRESS</xsl:with-param> -->
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/alt_applicant_dom"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/alt_applicant_dom"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/alt_applicant_dom"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>
		
		<xsl:call-template name="amend-input-field">
			<!-- <xsl:with-param name="label">XSL_PARTIESDETAILS_ALT_APPLICANT_ADDRESS_LINE 4</xsl:with-param> -->
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/alt_applicant_address_line_4"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/alt_applicant_address_line_4"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/alt_applicant_address_line_4"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>

		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_PARTIESDETAILS_ALT_APPLICANT_COUNTRY</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/alt_applicant_country"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/alt_applicant_country"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/alt_applicant_country"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
			<xsl:with-param name="translate-as">country</xsl:with-param>
		</xsl:call-template>

		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_ALTERNATE_APPLICANT_REF</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/alt_applicant_cust_ref"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/alt_applicant_cust_ref"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/alt_applicant_cust_ref"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>		

	</xsl:template>	

	<!-- This template displays the beneficiary address -->
	<xsl:template name="beneficiaryaddressAmend">
		<xsl:param name="path"/>
		<xsl:param name="org_path"/> 
		<xsl:param name="org_path1">N</xsl:param>
		
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_PARTIESDETAILS_ENTITY</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/entity"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/entity"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/entity"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>

		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_PARTIESDETAILS_ABBV_NAME</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/beneficiary_abbv_name"/> 
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/beneficiary_abbv_name"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/beneficiary_abbv_name"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>
		
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_PARTIESDETAILS_NAME</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/beneficiary_name"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/beneficiary_name"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/beneficiary_name"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>

		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/beneficiary_address_line_1"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/beneficiary_address_line_1"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/beneficiary_address_line_1"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>

		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/beneficiary_address_line_2"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/beneficiary_address_line_2"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/beneficiary_address_line_2"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>

		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/beneficiary_dom"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/beneficiary_dom"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/beneficiary_dom"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>
		
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/beneficiary_address_line_4"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/beneficiary_address_line_4"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/beneficiary_address_line_4"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>

		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_PARTIESDETAILS_CONTRY</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/beneficiary_country"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/beneficiary_country"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/beneficiary_country"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
			<xsl:with-param name="translate-as">country</xsl:with-param>
		</xsl:call-template>

		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_PARTIESDETAILS_REFERENCE</xsl:with-param>
			<xsl:with-param name="text">
         		<xsl:value-of select="utils:decryptApplicantReference(common:node-set($path)/beneficiary_reference)"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="utils:decryptApplicantReference(common:node-set($org_path)/beneficiary_reference)"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
         		<xsl:value-of select="utils:decryptApplicantReference(common:node-set($org_path1)/beneficiary_reference)"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>

	</xsl:template>

	<!-- This template displays the amount details section of the transaction -->
	<xsl:template name="lc-amt-details-amend">
		<xsl:param name="show-form-lc">Y</xsl:param>
		<xsl:param name="show-variation-drawing">Y</xsl:param>
		<xsl:param name="show-bank-confirmation">Y</xsl:param>
		<xsl:param name="show-outstanding-amt">N</xsl:param>
		<xsl:param name="show-standby">Y</xsl:param>
		<xsl:param name="show-amt">Y</xsl:param>
		<xsl:param name="show-revolving">Y</xsl:param>
		<xsl:param name="show-release-amt">Y</xsl:param>
		<xsl:param name="path"/>
		<xsl:param name="org_path"/>
		<xsl:param name="org_path1">N</xsl:param>

		<div id="lc-amt-details">
			<xsl:if test="$show-form-lc='Y'">
				<xsl:call-template name="multioption-group">
					<xsl:with-param name="group-label">XSL_AMOUNTDETAILS_FORM_LABEL</xsl:with-param>
					<xsl:with-param name="content"> 

						<xsl:if test="common:node-set($path)/irv_flag[.='Y']">
							<xsl:call-template name="input-field">          		 	
								<xsl:with-param name="name">irv_flag</xsl:with-param>
								<xsl:with-param name="value">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_IRREVOCABLE')" />
								</xsl:with-param>
							</xsl:call-template>
	       	   				&nbsp;
						</xsl:if>

						
							<xsl:call-template name="input-field">          		 	
								<xsl:with-param name="name">ntrf_flag</xsl:with-param>
								<xsl:with-param name="value">
								<xsl:if test="common:node-set($path)/ntrf_flag[.='Y']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_NON_TRANSFERABLE')" />
								</xsl:if>
								<xsl:if test="common:node-set($path)/ntrf_flag[.='N']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_TRANSFERABLE')" />
								</xsl:if>
								</xsl:with-param>
								<xsl:with-param name="highlight">
									<xsl:choose>
										<xsl:when test="common:node-set($path)/ntrf_flag = common:node-set($org_path)/ntrf_flag">N</xsl:when>
										<xsl:otherwise>Y</xsl:otherwise>
									</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
							&nbsp;
						<xsl:if test="$show-standby='Y' and common:node-set($path)/stnd_by_lc_flag[.='Y']">
							<xsl:call-template name="input-field">          		 	
								<xsl:with-param name="name">stnd_by_lc_flag</xsl:with-param>
								<xsl:with-param name="value">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_STAND_BY')" />
								</xsl:with-param>
								<xsl:with-param name="highlight">
									<xsl:choose>
										<xsl:when test="common:node-set($path)/stnd_by_lc_flag = common:node-set($org_path)/stnd_by_lc_flag">N</xsl:when>
										<xsl:otherwise>Y</xsl:otherwise>
									</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
	          				&nbsp;
						</xsl:if>

						<xsl:if test="$show-revolving='Y' and common:node-set($path)/revolving_flag[.='Y']">
							<xsl:call-template name="input-field">          		 	
								<xsl:with-param name="name">revolving_flag</xsl:with-param>
								<xsl:with-param name="value">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_FORM_REVOLVING')" />
								</xsl:with-param>
								<xsl:with-param name="highlight">
									<xsl:choose>
										<xsl:when test="common:node-set($path)/revolving_flag = common:node-set($org_path)/revolving_flag">N</xsl:when>
										<xsl:otherwise>Y</xsl:otherwise>
									</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>

					</xsl:with-param>
				</xsl:call-template>

				<!-- Confirmation Instructions Radio Buttons -->
				<xsl:if test="(common:node-set($path)/cfm_inst_code != common:node-set($org_path)/cfm_inst_code) or 
				($org_path1 != 'N' and common:node-set($org_path)/cfm_inst_code != common:node-set($org_path1)/cfm_inst_code) or
				(common:node-set($path)/cfm_inst_code!='' and common:node-set($org_path)/cfm_inst_code!='')">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_AMOUNTDETAILS_CFM_INST_LABEL</xsl:with-param>
						<xsl:with-param name="value">
							<xsl:choose>
								<xsl:when test="common:node-set($path)/cfm_inst_code [. = '01']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_CFM_INST_CONFIRM')"/>
								</xsl:when>
								<xsl:when test="common:node-set($path)/cfm_inst_code [. = '02']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_CFM_INST_MAY_ADD')"/>
								</xsl:when>
								<xsl:when test="common:node-set($path)/cfm_inst_code [. = '03']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_CFM_INST_WITHOUT')"/>
								</xsl:when>
								<xsl:otherwise>&lt;BLANK&gt;</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
						<xsl:with-param name="highlight">
							<xsl:choose>
								<xsl:when test="common:node-set($path)/cfm_inst_code = common:node-set($org_path)/cfm_inst_code">N</xsl:when>
								<xsl:otherwise>Y</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if> 

			</xsl:if>

			<!-- LC Currency and Amount -->
			<xsl:if test="$show-amt='Y'">
				<xsl:call-template name="amend-input-field">
						<xsl:with-param name="label">XSL_AMOUNTDETAILS_LC_AMT_LABEL</xsl:with-param>
						<xsl:with-param name="text">
							<xsl:value-of select="common:node-set($path)/lc_cur_code"/>&nbsp;<xsl:value-of select="common:node-set($path)/lc_amt"/>
						</xsl:with-param>
						<xsl:with-param name="org-text">
							<xsl:value-of select="common:node-set($path)/lc_cur_code"/>&nbsp;<xsl:value-of select="common:node-set($org_path)/lc_amt"/>
						</xsl:with-param>
						<xsl:with-param name="tnx-text">
							<xsl:value-of select="common:node-set($path)/lc_cur_code"/>&nbsp;<xsl:value-of select="common:node-set($org_path1)/lc_amt"/>
						</xsl:with-param>
						<xsl:with-param name="master" select="$org_path1" />
				</xsl:call-template>
			</xsl:if>
			
			<xsl:if test="common:node-set($path)/lc_available_amt !='' or common:node-set($org_path)/lc_available_amt!='' or common:node-set($org_path1)/lc_available_amt!=''">
				<xsl:call-template name="amend-input-field">
						<xsl:with-param name="label">XSL_AMOUNTDETAILS_AVAILABLE_AMT_LABEL</xsl:with-param>
						<xsl:with-param name="text">
							<xsl:value-of select="common:node-set($path)/lc_cur_code"/>&nbsp;<xsl:value-of select="common:node-set($path)/lc_available_amt"/>
						</xsl:with-param>
						<xsl:with-param name="org-text">
							<xsl:value-of select="common:node-set($path)/lc_cur_code"/>&nbsp;<xsl:value-of select="common:node-set($org_path)/lc_available_amt"/>
						</xsl:with-param>
						<xsl:with-param name="tnx-text">
							<xsl:value-of select="common:node-set($path)/lc_cur_code"/>&nbsp;<xsl:value-of select="common:node-set($org_path1)/lc_available_amt"/>
						</xsl:with-param>
						<xsl:with-param name="master" select="$org_path1" />
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="(common:node-set($path)/lc_liab_amt !='' or common:node-set($org_path)/lc_liab_amt!='' or common:node-set($org_path1)/lc_liab_amt!='') and security:isBank($rundata) ">
				<xsl:call-template name="amend-input-field">
						<xsl:with-param name="label">XSL_AMOUNTDETAILS_LIABILITY_AMT_LABEL</xsl:with-param>
						<xsl:with-param name="text">
							<xsl:value-of select="common:node-set($path)/lc_cur_code"/>&nbsp;<xsl:value-of select="common:node-set($path)/lc_liab_amt"/>
						</xsl:with-param>
						<xsl:with-param name="org-text">
							<xsl:value-of select="common:node-set($path)/lc_cur_code"/>&nbsp;<xsl:value-of select="common:node-set($org_path)/lc_liab_amt"/>
						</xsl:with-param>
						<xsl:with-param name="tnx-text">
							<xsl:value-of select="common:node-set($path)/lc_cur_code"/>&nbsp;<xsl:value-of select="common:node-set($org_path1)/lc_liab_amt"/>
						</xsl:with-param>
						<xsl:with-param name="master" select="$org_path1" />
				</xsl:call-template>
			</xsl:if>
			
			<!-- outstanding amount -->
			<xsl:if test="$show-outstanding-amt='Y'">
				<xsl:call-template name="amend-input-field">
						<xsl:with-param name="label">XSL_AMOUNTDETAILS_OS_AMT_LABEL</xsl:with-param>
						<xsl:with-param name="text">
							<xsl:value-of select="common:node-set($path)/lc_cur_code"/>&nbsp;<xsl:value-of select="common:node-set($path)/lc_liab_amt"/>
						</xsl:with-param>
						<xsl:with-param name="org-text">
							<xsl:value-of select="common:node-set($path)/lc_cur_code"/>&nbsp;<xsl:value-of select="common:node-set($org_path)/lc_liab_amt"/>
						</xsl:with-param>
						<xsl:with-param name="tnx-text">
							<xsl:value-of select="common:node-set($path)/lc_cur_code"/>&nbsp;<xsl:value-of select="common:node-set($org_path1)/lc_liab_amt"/>
						</xsl:with-param>
						<xsl:with-param name="master" select="$org_path1" />
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="$show-release-amt='Y'">
				<xsl:if test="common:node-set($path)/release_amt !='' or common:node-set($org_path)/release_amt!='' or common:node-set($org_path1)/release_amt!=''">
					<xsl:call-template name="amend-input-field">
						<xsl:with-param name="label">XSL_AMOUNTDETAILS_SI_RELEASE_AMT_LABEL</xsl:with-param>
						<xsl:with-param name="text">
							<xsl:value-of select="common:node-set($path)/lc_cur_code"/>&nbsp;<xsl:value-of select="common:node-set($path)/release_amt"/>
						</xsl:with-param>
						<xsl:with-param name="org-text">
							<xsl:value-of select="common:node-set($path)/lc_cur_code"/>&nbsp;<xsl:value-of select="common:node-set($org_path)/release_amt"/>
						</xsl:with-param>
						<xsl:with-param name="tnx-text">
							<xsl:value-of select="common:node-set($path)/lc_cur_code"/>&nbsp;<xsl:value-of select="common:node-set($org_path1)/release_amt"/>
						</xsl:with-param>
						<xsl:with-param name="master" select="$org_path1" />
					</xsl:call-template>
				</xsl:if>
			</xsl:if>
			

			<!-- Variation in drawing. -->
			<xsl:if test="$show-variation-drawing='Y' and (common:node-set($path)/lc_type[.!='04'] or common:node-set($path)/tnx_type_code[.!='01'])">       	
				<xsl:call-template name="label-wrapper">
					<xsl:with-param name="label">XSL_AMOUNTDETAILS_TOL_LABEL</xsl:with-param>
					<xsl:with-param name="content">

						<xsl:if test="common:node-set($path)/pstv_tol_pct[.!=''] or common:node-set($org_path)/pstv_tol_pct[.!=''] or ($org_path1 != 'N' and common:node-set($org_path1)/pstv_tol_pct[.!=''])">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_AMOUNTDETAILS_TOL_PSTV</xsl:with-param>
								<xsl:with-param name="name">pstv_tol_pct</xsl:with-param>
								<!-- <xsl:with-param name="type">integer</xsl:with-param> -->
								<xsl:with-param name="fieldsize">x-small</xsl:with-param>
								<xsl:with-param name="swift-validate">N</xsl:with-param>
								<xsl:with-param name="override-constraints">{places:'0',min:0, max:99}</xsl:with-param>        
								<xsl:with-param name="size">2</xsl:with-param>
								<xsl:with-param name="maxsize">2</xsl:with-param>
								<!-- <xsl:with-param name="content-after">%</xsl:with-param>-->
								<xsl:with-param name="appendClass">block</xsl:with-param> 			   
								<xsl:with-param name="value">
									<xsl:choose>
										<xsl:when test="common:node-set($path)/pstv_tol_pct[.!=''] and substring-before(common:node-set($path)/pstv_tol_pct,'.') != ''">
											<xsl:value-of select="substring-before(common:node-set($path)/pstv_tol_pct,'.')"/>%
										</xsl:when>
										<xsl:when test="common:node-set($path)/pstv_tol_pct[.!='']">
											<xsl:value-of select="common:node-set($path)/pstv_tol_pct"/>%
										</xsl:when>
										<xsl:otherwise>&lt;BLANK&gt;</xsl:otherwise>
									</xsl:choose>       		
								</xsl:with-param>	           
								<xsl:with-param name="highlight">
									<xsl:choose>
										<xsl:when test="common:node-set($path)/pstv_tol_pct = common:node-set($org_path)/pstv_tol_pct">N</xsl:when>
										<xsl:otherwise>Y</xsl:otherwise>
									</xsl:choose>
								</xsl:with-param>        
							</xsl:call-template>
						</xsl:if>

						<xsl:if test="common:node-set($path)/neg_tol_pct[.!=''] or common:node-set($org_path)/neg_tol_pct[.!=''] or ($org_path1 != 'N' and common:node-set($org_path1)/neg_tol_pct[.!=''])"> 
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_AMOUNTDETAILS_TOL_NEG</xsl:with-param>
								<xsl:with-param name="name">neg_tol_pct</xsl:with-param>
								<!-- <xsl:with-param name="type">integer</xsl:with-param> -->
								<xsl:with-param name="fieldsize">x-small</xsl:with-param>
								<xsl:with-param name="swift-validate">N</xsl:with-param>
								<xsl:with-param name="override-constraints">{places:'0',min:0, max:99}</xsl:with-param>
								<xsl:with-param name="size">2</xsl:with-param>
								<xsl:with-param name="maxsize">2</xsl:with-param>
								<!-- <xsl:with-param name="content-after">%</xsl:with-param> -->
								<xsl:with-param name="appendClass">block</xsl:with-param>
								<xsl:with-param name="value">
									<xsl:choose>
										<xsl:when test="common:node-set($path)/neg_tol_pct[.!=''] and substring-before(common:node-set($path)/neg_tol_pct,'.') != ''">
											<xsl:value-of select="substring-before(common:node-set($path)/neg_tol_pct,'.')"/>%
										</xsl:when>
										<xsl:when test="common:node-set($path)/neg_tol_pct[.!='']">
											<xsl:value-of select="common:node-set($path)/neg_tol_pct"/>%
										</xsl:when>
										<xsl:otherwise>&lt;BLANK&gt;</xsl:otherwise>
									</xsl:choose>       		
								</xsl:with-param>	           
								<xsl:with-param name="highlight">
									<xsl:choose>
										<xsl:when test="common:node-set($path)/neg_tol_pct = common:node-set($org_path)/neg_tol_pct">N</xsl:when>
										<xsl:otherwise>Y</xsl:otherwise>
									</xsl:choose>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:if>

						<!-- <xsl:if test="common:node-set($path)/max_cr_desc_code[.!=''] or common:node-set($org_path)/max_cr_desc_code[.!=''] or ($org_path1 != 'N' and common:node-set($org_path1)/max_cr_desc_code[.!=''])">
							<xsl:call-template name="input-field">
								<xsl:with-param name="label">XSL_AMOUNTDETAILS_TOL_MAX_CREDIT_LABEL</xsl:with-param>
								<xsl:with-param name="name">max_cr_desc_code</xsl:with-param>
								<xsl:with-param name="value">
									<xsl:choose>
										<xsl:when test="common:node-set($path)/max_cr_desc_code[.='3']">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_AMOUNTDETAILS_TOL_MAX_CREDIT_NOTEXCEEDING')"/>
										</xsl:when>
										<xsl:otherwise>&lt;BLANK&gt;</xsl:otherwise>
									</xsl:choose>       		
								</xsl:with-param>		           		           
								<xsl:with-param name="highlight">
									<xsl:choose>
										<xsl:when test="common:node-set($path)/max_cr_desc_code = common:node-set($org_path)/max_cr_desc_code">N</xsl:when>
										<xsl:otherwise>Y</xsl:otherwise>
									</xsl:choose>
								</xsl:with-param>		           
							</xsl:call-template>
						</xsl:if> -->

					</xsl:with-param>
				</xsl:call-template>

				<xsl:if test="(common:node-set($path)/open_chrg_brn_by_code != common:node-set($org_path)/open_chrg_brn_by_code) or
				 ($org_path1 != 'N' and common:node-set($org_path1)/open_chrg_brn_by_code != common:node-set($org_path)/open_chrg_brn_by_code) or
				 (common:node-set($path)/open_chrg_brn_by_code!='' and common:node-set($org_path)/open_chrg_brn_by_code!='')">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_CHRGDETAILS_ISS_LABEL</xsl:with-param>
						<xsl:with-param name="value">
							<xsl:if test="common:node-set($path)/open_chrg_brn_by_code [. = '01']">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_FT_APPLICANT')"/>
							</xsl:if>
							<xsl:if test="common:node-set($path)/open_chrg_brn_by_code [. = '02']">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_FT_BENEFICIARY')"/>
							</xsl:if>
						</xsl:with-param>
						<xsl:with-param name="highlight">
							<xsl:choose>
								<xsl:when test="common:node-set($path)/open_chrg_brn_by_code = common:node-set($org_path)/open_chrg_brn_by_code">N</xsl:when>
								<xsl:otherwise>Y</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>		
					</xsl:call-template>
				</xsl:if>

				<xsl:if test="(common:node-set($path)/corr_chrg_brn_by_code != common:node-set($org_path)/corr_chrg_brn_by_code) or
				 ($org_path1 != 'N' and common:node-set($org_path1)/corr_chrg_brn_by_code != common:node-set($org_path)/corr_chrg_brn_by_code) or
				 (common:node-set($path)/corr_chrg_brn_by_code!='' and common:node-set($org_path)/corr_chrg_brn_by_code!='')">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_CHRGDETAILS_CORR_LABEL</xsl:with-param>
						<xsl:with-param name="value">
							<xsl:if test="common:node-set($path)/corr_chrg_brn_by_code [. = '01']">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_FT_APPLICANT')"/>
							</xsl:if>
							<xsl:if test="common:node-set($path)/corr_chrg_brn_by_code [. = '02']">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_FT_BENEFICIARY')"/>
							</xsl:if>
						</xsl:with-param>
						<xsl:with-param name="highlight">
							<xsl:choose>
								<xsl:when test="common:node-set($path)/corr_chrg_brn_by_code = common:node-set($org_path)/corr_chrg_brn_by_code">N</xsl:when>
								<xsl:otherwise>Y</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>

				<xsl:if test="is_MT798[.='N'] and $confirmationChargesEnabled and (common:node-set($path)/cfm_chrg_brn_by_code != common:node-set($org_path)/cfm_chrg_brn_by_code) or 
				($org_path1 != 'N' and common:node-set($org_path1)/cfm_chrg_brn_by_code != common:node-set($org_path)/cfm_chrg_brn_by_code) or
				(common:node-set($path)/cfm_chrg_brn_by_code!='' and common:node-set($org_path)/cfm_chrg_brn_by_code!='')">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_CHRGDETAILS_CFM_LABEL</xsl:with-param>
						<xsl:with-param name="value">
							<xsl:choose>
								<xsl:when test="common:node-set($path)/cfm_chrg_brn_by_code [. = '01']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_FT_APPLICANT')"/>
								</xsl:when>
								<xsl:when test="common:node-set($path)/cfm_chrg_brn_by_code [. = '02']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_FT_BENEFICIARY')"/>
								</xsl:when>
								<xsl:otherwise>&lt;BLANK&gt;</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
						<xsl:with-param name="highlight">
							<xsl:choose>
								<xsl:when test="common:node-set($path)/cfm_chrg_brn_by_code = common:node-set($org_path)/cfm_chrg_brn_by_code">N</xsl:when>
								<xsl:otherwise>Y</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>

				<xsl:if test="(is_MT798[.='N']) and ((common:node-set($path)/amd_chrg_brn_by_code != common:node-set($org_path)/amd_chrg_brn_by_code) or ($org_path1 != 'N' and common:node-set($org_path1)/amd_chrg_brn_by_code != common:node-set($org_path)/amd_chrg_brn_by_code) or
				(common:node-set($path)/narrative_amend_charges_other/text != common:node-set($org_path)/narrative_amend_charges_other/text) or ($org_path1 != 'N' and common:node-set($org_path1)/narrative_amend_charges_other/text != common:node-set($org_path)/narrative_amend_charges_other/text) or
				(common:node-set($path)/amd_chrg_brn_by_code!='' and common:node-set($org_path)/amd_chrg_brn_by_code!='') or (common:node-set($path)/narrative_amend_charges_other/text!='' and common:node-set($org_path)/narrative_amend_charges_other/text!=''))">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_CHRGDETAILS_AMD_LABEL</xsl:with-param>
						<xsl:with-param name="value">
							<xsl:choose>
								<xsl:when test="common:node-set($path)/amd_chrg_brn_by_code [. = '01']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_APPLICANT')"/>
								</xsl:when>
								<xsl:when test="common:node-set($path)/amd_chrg_brn_by_code [. = '02']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_BENEFICIARY')"/>
								</xsl:when>
								<xsl:when test="common:node-set($path)/amd_chrg_brn_by_code [. = '07']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_OTHER')"/>
								</xsl:when>
								<xsl:when test="common:node-set($path)/amd_chrg_brn_by_code [. = '05']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_SHARED')"/>
								</xsl:when>
								<xsl:when test="common:node-set($path)/amd_chrg_brn_by_code [. = '09']">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_CHRGDETAILS_NONE')"/>
								</xsl:when>
								<xsl:otherwise>&lt;BLANK&gt;</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
						<xsl:with-param name="highlight">
							<xsl:choose>
								<xsl:when test="common:node-set($path)/amd_chrg_brn_by_code = common:node-set($org_path)/amd_chrg_brn_by_code">N</xsl:when>
								<xsl:otherwise>Y</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:if test="common:node-set($path)/amd_chrg_brn_by_code [. = '05' or .='07'] or common:node-set($org_path)/amd_chrg_brn_by_code [. = '05' or .='07'] or common:node-set($org_path1)/amd_chrg_brn_by_code [. = '05' or .='07']">
						<div style="margin-left:250px;">
						<xsl:call-template name="narrative-scroll">
							<xsl:with-param name="text" select="common:node-set($path)/narrative_amend_charges_other/text" />
							<xsl:with-param name="org-text" select="common:node-set($org_path)/narrative_amend_charges_other/text" />				
						</xsl:call-template>
						</div>
					</xsl:if>
				</xsl:if>
				
				<xsl:if test="(common:node-set($path)/applicable_rules != common:node-set($org_path)/applicable_rules) or
				 ($org_path1 != 'N' and common:node-set($org_path1)/applicable_rules != common:node-set($org_path)/applicable_rules) or
				 (common:node-set($path)/applicable_rules!='' and common:node-set($org_path)/applicable_rules!='')">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_GTEEDETAILS_RULES_LABEL</xsl:with-param>
						<xsl:with-param name="value">
							<xsl:choose>
								<xsl:when test="common:node-set($path)/applicable_rules [. = '01']"><xsl:value-of select="localization:getDecode($language, 'N065', '01')"/></xsl:when>
     							<xsl:when test="common:node-set($path)/applicable_rules [. = '02']"><xsl:value-of select="localization:getDecode($language, 'N065', '02')"/></xsl:when>
      							<xsl:when test="common:node-set($path)/applicable_rules [. = '03']"><xsl:value-of select="localization:getDecode($language, 'N065', '03')"/></xsl:when>
      							<xsl:when test="common:node-set($path)/applicable_rules [. = '04']"><xsl:value-of select="localization:getDecode($language, 'N065', '04')"/></xsl:when>
      							<xsl:when test="common:node-set($path)/applicable_rules [. = '05']"><xsl:value-of select="localization:getDecode($language, 'N065', '05')"/></xsl:when>
      							<xsl:when test="common:node-set($path)/applicable_rules [. = '09']"><xsl:value-of select="localization:getDecode($language, 'N065', '09')"/></xsl:when>
     							<xsl:when test="common:node-set($path)/applicable_rules [. = '99']"><xsl:value-of select="localization:getDecode($language, 'N065', '99')"/></xsl:when>
     							<xsl:otherwise>&lt;BLANK&gt;</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
						<xsl:with-param name="highlight">
							<xsl:choose>
								<xsl:when test="common:node-set($path)/applicable_rules = common:node-set($org_path)/applicable_rules">N</xsl:when>
								<xsl:otherwise>Y</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>		
					</xsl:call-template>
					<xsl:if test="common:node-set($path)/applicable_rules_text!='' or common:node-set($org_path)/applicable_rules_text!=''">
					<div style="margin-left:250px;">
						<xsl:call-template name="narrative-scroll">
							<xsl:with-param name="text" select="common:node-set($path)/applicable_rules_text" />
							<xsl:with-param name="org-text" select="common:node-set($org_path)/applicable_rules_text" />				
						</xsl:call-template>
					</div>
					</xsl:if>
				</xsl:if>
				

			</xsl:if>
		</div>
	</xsl:template>
	
	<xsl:template name="stand-by-details-amend">
		<xsl:param name="path"/>
		<xsl:param name="org_path"/>
		<xsl:param name="org_path1">N</xsl:param>
		<!-- Type of Standby LC -->
		<xsl:if test="(common:node-set($path)/product_type_code != common:node-set($org_path)/product_type_code) or
			($org_path1 != 'N' and common:node-set($org_path1)/product_type_code != common:node-set($org_path)/product_type_code) or
			(common:node-set($path)/product_type_code!='' and common:node-set($org_path)/product_type_code!='')">
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_SBLCDETAILS_TYPE_LABEL</xsl:with-param>
				<xsl:with-param name="value">
					<xsl:choose>
						<xsl:when test="common:node-set($path)/product_type_code [. = '01']"><xsl:value-of select="localization:getDecode($language, 'C010', '01')"/></xsl:when>
     					<xsl:when test="common:node-set($path)/product_type_code [. = '02']"><xsl:value-of select="localization:getDecode($language, 'C010', '02')"/></xsl:when>
      					<xsl:when test="common:node-set($path)/product_type_code [. = '03']"><xsl:value-of select="localization:getDecode($language, 'C010', '03')"/></xsl:when>
      					<xsl:when test="common:node-set($path)/product_type_code [. = '04']"><xsl:value-of select="localization:getDecode($language, 'C010', '04')"/></xsl:when>
      					<xsl:when test="common:node-set($path)/product_type_code [. = '05']"><xsl:value-of select="localization:getDecode($language, 'C010', '05')"/></xsl:when>
      					<xsl:when test="common:node-set($path)/product_type_code [. = '06']"><xsl:value-of select="localization:getDecode($language, 'C010', '06')"/></xsl:when>
      					<xsl:when test="common:node-set($path)/product_type_code [. = '07']"><xsl:value-of select="localization:getDecode($language, 'C010', '07')"/></xsl:when>
     					<xsl:when test="common:node-set($path)/product_type_code [. = '09']"><xsl:value-of select="localization:getDecode($language, 'C010', '09')"/></xsl:when>
						<xsl:when test="common:node-set($path)/product_type_code [. = '10']"><xsl:value-of select="localization:getDecode($language, 'C010', '10')"/></xsl:when>
						<xsl:when test="common:node-set($path)/product_type_code [. = '11']"><xsl:value-of select="localization:getDecode($language, 'C010', '11')"/></xsl:when>
     					<xsl:when test="common:node-set($path)/product_type_code [. = '99']"><xsl:value-of select="localization:getDecode($language, 'C010', '99')"/></xsl:when>
     					<xsl:otherwise>&lt;BLANK&gt;</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
				<xsl:with-param name="highlight">
					<xsl:choose>
						<xsl:when test="common:node-set($path)/product_type_code = common:node-set($org_path)/product_type_code">N</xsl:when>
						<xsl:otherwise>Y</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>		
			</xsl:call-template>
		</xsl:if>
		<!-- Rules Applicable -->
		<xsl:if test="(common:node-set($path)/standby_rule_code != common:node-set($org_path)/standby_rule_code) or
				 ($org_path1 != 'N' and common:node-set($org_path1)/standby_rule_code != common:node-set($org_path)/standby_rule_code) or
				 (common:node-set($path)/standby_rule_code!='' and common:node-set($org_path)/standby_rule_code!='')">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_GTEEDETAILS_RULES_LABEL</xsl:with-param>
						<xsl:with-param name="value">
							<xsl:choose>
								<xsl:when test="common:node-set($path)/standby_rule_code [. = '01']"><xsl:value-of select="localization:getDecode($language, 'C012', '01')"/></xsl:when>
     							<xsl:when test="common:node-set($path)/standby_rule_code [. = '02']"><xsl:value-of select="localization:getDecode($language, 'C012', '02')"/></xsl:when>
      							<xsl:when test="common:node-set($path)/standby_rule_code [. = '03']"><xsl:value-of select="localization:getDecode($language, 'C012', '03')"/></xsl:when>
      							<xsl:when test="common:node-set($path)/standby_rule_code [. = '04']"><xsl:value-of select="localization:getDecode($language, 'C012', '04')"/></xsl:when>
      							<xsl:when test="common:node-set($path)/standby_rule_code [. = '05']"><xsl:value-of select="localization:getDecode($language, 'C012', '05')"/></xsl:when>
      							<xsl:when test="common:node-set($path)/standby_rule_code [. = '06']"><xsl:value-of select="localization:getDecode($language, 'C012', '06')"/></xsl:when>
      							<xsl:when test="common:node-set($path)/standby_rule_code [. = '07']"><xsl:value-of select="localization:getDecode($language, 'C012', '07')"/></xsl:when>
     							<xsl:when test="common:node-set($path)/standby_rule_code [. = '09']"><xsl:value-of select="localization:getDecode($language, 'C012', '09')"/></xsl:when>
     							<xsl:when test="common:node-set($path)/standby_rule_code [. = '99']"><xsl:value-of select="localization:getDecode($language, 'C012', '99')"/></xsl:when>
     							<xsl:otherwise>&lt;BLANK&gt;</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
						<xsl:with-param name="highlight">
							<xsl:choose>
								<xsl:when test="common:node-set($path)/standby_rule_code = common:node-set($org_path)/standby_rule_code">N</xsl:when>
								<xsl:otherwise>Y</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>		
					</xsl:call-template>
					<xsl:if test="common:node-set($path)/standby_rule_other!='' or common:node-set($org_path)/standby_rule_other!=''">
						<div style="margin-left:250px;">
							<xsl:call-template name="narrative-scroll">
								<xsl:with-param name="text" select="common:node-set($path)/standby_rule_other" />
								<xsl:with-param name="org-text" select="common:node-set($org_path)/standby_rule_other" />				
							</xsl:call-template>
						</div>
					</xsl:if>
				</xsl:if>	
	</xsl:template>

	<!-- This template displays the revolving details fieldset of the transaction -->
	<xsl:template name="lc-revolving-details-amend">
		<xsl:param name="path"/>
		<xsl:param name="org_path"/>
		<xsl:param name="org_path1">N</xsl:param>
		<xsl:param name="master">N</xsl:param>

		<!-- <xsl:if test="common:node-set($path)/revolving_flag = 'Y'"> -->
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_REVOLVE_PERIOD</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/revolve_period"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/revolve_period"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/revolve_period"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
			<xsl:with-param name="translate-as">integer</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_REVOLVE_FREQUENCY</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/revolve_frequency"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/revolve_frequency"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/revolve_frequency"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
			<xsl:with-param name="translate-as">frequency</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_REVOLVE_TIME_NUMBER</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/revolve_time_no"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/revolve_time_no"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/revolve_time_no"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
			<xsl:with-param name="translate-as">integer</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/cumulative_flag"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/cumulative_flag"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/cumulative_flag"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
			<xsl:with-param name="translate-as">cumulative</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_NEXT_REVOLVE_DATE</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/next_revolve_date"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/next_revolve_date"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/next_revolve_date"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_NOTICE_DAYS</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/notice_days"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/notice_days"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/notice_days"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
			<xsl:with-param name="translate-as">integer</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_CHARGE_UPTO</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/charge_upto"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/charge_upto"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/charge_upto"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
			<xsl:with-param name="translate-as">charge_upto</xsl:with-param>
		</xsl:call-template>
		<!-- </xsl:if> -->
	</xsl:template>



	<!-- This template displays the shipment details section of the transaction -->
	<xsl:template name="lc-shipment-details-amend">
		<xsl:param name="path"/>
		<xsl:param name="org_path"/>
		<xsl:param name="org_path1">N</xsl:param>

		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_SHIPMENTDETAILS_SHIP_FROM</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/ship_from"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/ship_from"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/ship_from"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>

		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_SHIPMENTDETAILS_SHIP_LOADING</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/ship_loading"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/ship_loading"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/ship_loading"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>

		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_SHIPMENTDETAILS_SHIP_DISCHARGE</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/ship_discharge"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/ship_discharge"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/ship_discharge"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>

		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_SHIPMENTDETAILS_SHIP_TO</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/ship_to"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/ship_to"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/ship_to"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>

		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_SHIPMENTDETAILS_PART_SHIP_LABEL</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/part_ship_detl"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/part_ship_detl"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/part_ship_detl"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>

		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_SHIPMENTDETAILS_TRAN_SHIP_LABEL_LC</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/tran_ship_detl"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/tran_ship_detl"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/tran_ship_detl"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>

		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_SHIPMENTDETAILS_LAST_SHIP_DATE</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/last_ship_date"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/last_ship_date"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/last_ship_date"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>
		<xsl:variable name="incoTerm"><xsl:value-of select="inco_term"/></xsl:variable>
		<xsl:variable name="orgIncoTerm"><xsl:value-of select="common:node-set($org_path)/inco_term"/></xsl:variable>
		<xsl:variable name="tnxIncoTerm"><xsl:value-of select="common:node-set($org_path1)/inco_term"/></xsl:variable>
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_INCO_TERM_YEAR</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/inco_term_year"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/inco_term_year"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/inco_term_year"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>
		<xsl:call-template name="amend-input-field">
		<xsl:with-param name="label">XSL_SHIPMENTDETAILS_INCO_TERM</xsl:with-param>
			<xsl:with-param name="text">
			<xsl:value-of select="localization:getCodeData($language,'*','*','N212',$incoTerm)"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="localization:getCodeData($language,'*','*','N212',$orgIncoTerm)"/>
			</xsl:with-param>			
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="localization:getCodeData($language,'*','*','N212',$tnxIncoTerm)"/>
			</xsl:with-param>			
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>

		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_SHIPMENTDETAILS_INCO_PLACE</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/inco_place"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/inco_place"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/inco_place"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>

	</xsl:template>

	<!-- This template displays the Credit Available with section of the transaction -->
	<xsl:template name="credit-available-by-amend">
		<xsl:param name="show-drawee">Y</xsl:param>
		<xsl:param name="path"/>
		<xsl:param name="org_path"/>
		<xsl:param name="org_path1">N</xsl:param>

		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_PAYMENTDETAILS_CR_AVAIL_BY_LABEL</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:call-template name="get-cr-avl-by-code">
					<xsl:with-param name="cr_avl_by_code_value" select="common:node-set($path)/cr_avl_by_code"/>
				</xsl:call-template>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:call-template name="get-cr-avl-by-code">
					<xsl:with-param name="cr_avl_by_code_value" select="common:node-set($org_path)/cr_avl_by_code"/>
				</xsl:call-template>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:call-template name="get-cr-avl-by-code">
					<xsl:with-param name="cr_avl_by_code_value" select="common:node-set($org_path1)/cr_avl_by_code"/>
				</xsl:call-template>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>
			
		<xsl:choose>
			<xsl:when test="common:node-set($path)/cr_avl_by_code[.!='05']">
				<xsl:call-template name="amend-input-field">
					<xsl:with-param name="label">XSL_PAYMENTDETAILS_DRAFT_TERM_LABEL</xsl:with-param>
					<xsl:with-param name="text">
					    <xsl:value-of select="localization:getGTPString($language, 'MATURITY_DATE')"/><xsl:text> </xsl:text><xsl:value-of select="common:node-set($path)/draft_term"/>
					</xsl:with-param>
					<xsl:with-param name="org-text">
					    <xsl:value-of select="localization:getGTPString($language, 'MATURITY_DATE')"/><xsl:text> </xsl:text><xsl:value-of select="common:node-set($org_path)/draft_term"/>
					</xsl:with-param>
					<xsl:with-param name="tnx-text">
					    <xsl:value-of select="localization:getGTPString($language, 'MATURITY_DATE')"/><xsl:text> </xsl:text><xsl:value-of select="common:node-set($org_path1)/draft_term"/>
					</xsl:with-param>
					<xsl:with-param name="master" select="$org_path1" />
				</xsl:call-template> 			
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="amend-input-field">
					<xsl:with-param name="label">XSL_PAYMENTDETAILS_CR_AVAIL_BY_MIXED_DETAILS</xsl:with-param>
					<xsl:with-param name="text">
						<xsl:value-of select="common:node-set($path)/draft_term"/>
					</xsl:with-param>
					<xsl:with-param name="org-text">
						<xsl:value-of select="common:node-set($org_path)/draft_term"/>
					</xsl:with-param>
					<xsl:with-param name="tnx-text">
						<xsl:value-of select="common:node-set($org_path1)/draft_term"/>
					</xsl:with-param>
					<xsl:with-param name="master" select="$org_path1" />
				</xsl:call-template> 			
			</xsl:otherwise>
		</xsl:choose>

		<xsl:if test="$show-drawee='Y'">
			<xsl:call-template name="amend-input-field">
				<xsl:with-param name="label">XSL_HEADER_DRAWEE_DETAILS</xsl:with-param>
				<xsl:with-param name="text">
					<xsl:value-of select="common:node-set($path)/drawee_details_bank/name"/>
				</xsl:with-param>
				<xsl:with-param name="org-text">
					<xsl:value-of select="common:node-set($org_path)/drawee_details_bank/name"/>
				</xsl:with-param>
				<xsl:with-param name="tnx-text">
					<xsl:value-of select="common:node-set($org_path1)/drawee_details_bank/name"/>
				</xsl:with-param>
				<xsl:with-param name="master" select="$org_path1" />
			</xsl:call-template>
		</xsl:if>

	</xsl:template>

	<!-- This template declares the linked licenses of the transaction -->
	<xsl:template name="linkedlsdeclaration">
		<xsl:param name="path"/>
		<xsl:call-template name="fieldset-wrapper">
			<!-- <xsl:with-param name="legend">XSL_HEADER_LICENSES</xsl:with-param> -->
			<xsl:with-param name="content">
				<div id="ls-items-template">
					<div class="clear multigrid">
						<script type="text/javascript">
							var gridLayoutLicense, pluginsData;
							dojo.ready(function(){
						    	gridLayoutLicense = {"cells" : [
						                  [{ "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'REFERENCEID')"/>", "field": "REFERENCEID", "width": "10em", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
						                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'XSL_BACK_OFFICE_REFERENCE')"/>", "field": "BO_REF_ID", "width": "10em", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
						                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LICENSE_NUMBER')"/>", "field": "LS_NUMBER", "width": "20%%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
						                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LS_AMT')"/>", "field": "LS_AMT", "styles":"white-space:nowrap;display:none;", "headerStyles":"white-space:nowrap;"},
						                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'LS_OS_AMT')"/>", "field": "LS_OS_AMT", "styles":"white-space:nowrap;display:none;", "headerStyles":"white-space:nowrap;"},
						                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'CONVERTED_OS_AMT')"/>", "field": "CONVERTED_OS_AMT", "styles":"white-space:nowrap;display:none;", "headerStyles":"white-space:nowrap;"},
						                   {"noresize":"true", "name":"<xsl:value-of select="localization:getGTPString($language, 'LS_ALLOCATED_AMT')"/>", "field":"LS_ALLOCATED_AMT", "width": "10em", "type": dojox.grid.cells._Widget},
							<!-- {"noresize":"true", "name":"<xsl:value-of select="localization:getGTPString($language, 'LS_ALLOCATED_ADD_AMT')"/>", "field":"LS_ALLOCATED_ADD_AMT", "width": "10em", "type": dojox.grid.cells._Widget}, -->
						                   {"noresize":"true", "name":"<xsl:value-of select="localization:getGTPString($language, 'XSL_LICENSE_ALLOW_OVERDRAW')"/>", "field":"ALLOW_OVERDRAW", "styles":"white-space:nowrap;display:none;", "headerStyles":"white-space:nowrap;"}
							<xsl:if test="$displaymode='edit'">
						                   		,{ "noresize":"true", "name": "&nbsp;", "field": "ACTION", "width": "6em", "styles": "text-align:center;", "headerStyles": "text-align: center", "formatter": misys.grid.formatHTML}
						                    ]
							</xsl:if>
						        ]};
								pluginsData = {indirectSelection: {headerSelector: "false",width: "30px",styles: "text-align: center;"}, paginationEnhanced: {pageSizes: ["10","25","50","100"], description: true, sizeSwitch: true, pageStepper: true, gotoButton: true, maxPageStep: 7, position: " top "}}						
							});
						</script>
						<div style="width:100%;height:100%;" class="widgetContainer clear content">
							<table border="0" cellpadding="0" cellspacing="0" class="attachments">
								<xsl:attribute name="id">ls_table</xsl:attribute>
								<xsl:choose>
									<xsl:when test="common:node-set($path)/linked_licenses/license">
										<thead>
											<tr>
												<th class="medium-tblheader" scope="col">
													<xsl:value-of select="localization:getGTPString($language, 'REFERENCEID')"/>
												</th>
												<th class="medium-tblheader" scope="col">
													<xsl:value-of select="localization:getGTPString($language, 'XSL_BACK_OFFICE_REFERENCE')"/>
												</th>
												<th class="medium-tblheader" scope="col">
													<xsl:value-of select="localization:getGTPString($language, 'LICENSE_NUMBER')"/>
												</th>
												<th class="medium-tblheader" scope="col">
													<xsl:value-of select="localization:getGTPString($language, 'LS_ALLOCATED_AMT')"/>
												</th>
												<!-- <th class="medium-tblheader" scope="col"><xsl:value-of select="localization:getGTPString($language, 'LS_ALLOCATED_ADD_AMT')"/></th> -->
											</tr>
										</thead>
										<tbody>
											<xsl:attribute name="id">license_table_details</xsl:attribute>      
											<xsl:for-each select="common:node-set($path)/linked_licenses/license">
												<tr>
													<td>
														<xsl:value-of select="ls_ref_id"/>
													</td>
													<td>
														<xsl:value-of select="bo_ref_id"/>
													</td>
													<td>
														<xsl:value-of select="ls_number"/>
													</td>
													<td>
														<xsl:value-of select="ls_allocated_amt"/>
													</td>
													<!-- <td><xsl:value-of select="ls_allocated_add_amt"/></td> -->
												</tr>
											</xsl:for-each>
										</tbody>
									</xsl:when>
									<xsl:otherwise>
										<div>
											<xsl:value-of select="localization:getGTPString($language, 'XSL_NO_LINKED_LS_ITEMS')"/>
										</div>
										<tbody/>
									</xsl:otherwise>
								</xsl:choose>
							</table>
							<div class="clear" style="height:1px">&nbsp;</div>
						</div>
					</div>
				</div>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<!-- This template instantiates the linked licenses -->
	<xsl:template name="linked-licenses-new">
		<xsl:param name="path"/>
		<script type="text/javascript">
			var linkedLsItems =[];
			<xsl:for-each select="common:node-set($path)/linked_licenses/license">
				var refLs = "<xsl:value-of select="ls_ref_id"/>";
				linkedLsItems.push({ "REFERENCEID" :"<xsl:value-of select="ls_ref_id"/>", "BO_REF_ID" :"<xsl:value-of select="bo_ref_id"/>", "LS_NUMBER":"<xsl:value-of select="ls_number"/>", "LS_ALLOCATED_AMT" :"<xsl:value-of select="ls_allocated_amt"/>", "LS_AMT" :"<xsl:value-of select="ls_amt"/>", "LS_OS_AMT" :"<xsl:value-of select="ls_os_amt"/>", "CONVERTED_OS_AMT" :"<xsl:value-of select="converted_os_amt"/>", "ALLOW_OVERDRAW" :"<xsl:value-of select="allow_overdraw"/>", "ACTION" : "<![CDATA[<img src=\"/content/images/delete.png\" onClick =\"javascript:misys.deleteLsRecord(refLs)\"/>]]>"});
			</xsl:for-each>	
		</script>
	</xsl:template>

	<!-- This template displays the bank instruction details section of the transaction -->
	<xsl:template name="bank-instructions-amend">
		<xsl:param name="send-mode-required">Y</xsl:param>
		<xsl:param name="send-mode-displayed">Y</xsl:param>
		<xsl:param name="send-mode-label">XSL_INSTRUCTIONS_LC_ADV_SEND_MODE_LABEL</xsl:param>
		<xsl:param name="forward-contract-shown">Y</xsl:param>
		<xsl:param name="principal-acc-displayed">Y</xsl:param>
		<xsl:param name="fee-acc-displayed">Y</xsl:param>
		<xsl:param name="delivery-to-shown">Y</xsl:param>
		<xsl:param name="delivery-channel-displayed">Y</xsl:param>
		<xsl:param name="free-format-text-displayed">Y</xsl:param>
		<xsl:param name="path"/>

		<xsl:choose>
			<xsl:when test="$mode = 'DRAFT' and $displaymode='view'">
				<!-- Don't show the file details for the draft view mode, but do in all other cases -->

			</xsl:when>

			<xsl:otherwise>
				<xsl:if test="$send-mode-displayed='Y'">
					<xsl:call-template name="select-field">
						<xsl:with-param name="label" select="$send-mode-label"/>
						<xsl:with-param name="name">adv_send_mode</xsl:with-param>
						<xsl:with-param name="required">
							<xsl:value-of select="$send-mode-required"/>
						</xsl:with-param>
						<xsl:with-param name="fieldsize">small</xsl:with-param>
						<xsl:with-param name="options">
							<xsl:if test="common:node-set($path)/adv_send_mode[. = '01']">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_SWIFT')"/>
							</xsl:if>
							<xsl:if test="common:node-set($path)/adv_send_mode[. = '02']">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_TELEX')"/>
							</xsl:if>
							<xsl:if test="common:node-set($path)/adv_send_mode[. = '03']">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_COURIER')"/>
							</xsl:if>
							<xsl:if test="common:node-set($path)/adv_send_mode[. = '04']">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_INSTRUCTIONS_ADV_SEND_MODE_REGISTERED_POST')"/>
							</xsl:if>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="$delivery-channel-displayed='Y'">
					<xsl:call-template name="select-field">
						<xsl:with-param name="label">XSL_FILESDETAILS_FILEACT_DELIVERY_CHANNEL</xsl:with-param>
						<xsl:with-param name="name">delivery_channel</xsl:with-param>
						<xsl:with-param name="fieldsize">small</xsl:with-param>
						<xsl:with-param name="value">
							<xsl:value-of select="localization:getDecode($language, 'N802', common:node-set($path)/delivery_channel)"/>
						</xsl:with-param> 			
					</xsl:call-template>
				</xsl:if>           
				<xsl:if test="$principal-acc-displayed='Y'">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_INSTRUCTIONS_PRINCIPAL_ACT_NO_LABEL</xsl:with-param>
						<xsl:with-param name="button-type">account</xsl:with-param>
						<xsl:with-param name="type">account</xsl:with-param>
						<xsl:with-param name="name">principal_act_no</xsl:with-param>
						<xsl:with-param name="value">
							<xsl:value-of select="common:node-set($path)/principal_act_no"/>
						</xsl:with-param> 
						<xsl:with-param name="readonly">Y</xsl:with-param>
						<xsl:with-param name="size">34</xsl:with-param>
						<xsl:with-param name="maxsize">34</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="$fee-acc-displayed='Y'">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_INSTRUCTIONS_FEE_ACT_NO_LABEL</xsl:with-param>
						<xsl:with-param name="button-type">account</xsl:with-param>
						<xsl:with-param name="type">account</xsl:with-param>
						<xsl:with-param name="name">fee_act_no</xsl:with-param>
						<xsl:with-param name="value">
							<xsl:value-of select="common:node-set($path)/fee_act_no"/>
						</xsl:with-param> 
						<xsl:with-param name="readonly">Y</xsl:with-param>
						<xsl:with-param name="size">34</xsl:with-param>
						<xsl:with-param name="maxsize">34</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="$forward-contract-shown='Y'">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_INSTRUCTIONS_FWD_CONTRACT_NO_LABEL</xsl:with-param>
						<xsl:with-param name="name">fwd_contract_no</xsl:with-param>
						<xsl:with-param name="value">
							<xsl:value-of select="common:node-set($path)/fwd_contract_no"/>
						</xsl:with-param>
						<xsl:with-param name="size">34</xsl:with-param>
						<xsl:with-param name="maxsize">34</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
				<xsl:if test="$delivery-to-shown='Y'">
					<xsl:call-template name="select-field">
						<xsl:with-param name="label">XSL_GTEEDETAILS_DELIVERY_TO_LABEL</xsl:with-param>
						<xsl:with-param name="name">delivery_to</xsl:with-param>
						<xsl:with-param name="options">
							<xsl:if test="common:node-set($path)/delivery_to[. = '01']">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_DELIVERY_TO_OURSELVES')"/>
							</xsl:if>
							<xsl:if test="common:node-set($path)/delivery_to[. = '02']">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_DELIVERY_TO_PARTY')"/>
							</xsl:if>
							<xsl:if test="common:node-set($path)/delivery_to[. = '03']">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_GTEEDETAILS_DELIVERY_TO_BENEFICIARY')"/>
							</xsl:if>
							<xsl:if test="common:node-set($path)/delivery_to[. = '04']">
								<xsl:call-template name="row-wrapper">
									<xsl:with-param name="id">delivery_to_other</xsl:with-param>
									<xsl:with-param name="type">textarea</xsl:with-param>
									<xsl:with-param name="content">
										<xsl:call-template name="input-field">
											<xsl:with-param name="name">delivery_to_other</xsl:with-param>
											<xsl:with-param name="value">
												<xsl:value-of select="common:node-set($path)/delivery_to_other"/>
											</xsl:with-param>
										</xsl:call-template>
									</xsl:with-param>
								</xsl:call-template>
							</xsl:if>
						</xsl:with-param> 
					</xsl:call-template>
				</xsl:if>

				<xsl:if test="$free-format-text-displayed='Y'">
					<xsl:call-template name="big-textarea-wrapper">
						<xsl:with-param name="id">free_format_text</xsl:with-param>
						<xsl:with-param name="label">XSL_INSTRUCTIONS_OTHER_INFORMATION</xsl:with-param>
						<xsl:with-param name="type">textarea</xsl:with-param>
						<xsl:with-param name="content">
							<xsl:call-template name="textarea-field">
								<xsl:with-param name="name">free_format_text</xsl:with-param>
								<xsl:with-param name="value">
									<xsl:value-of select="common:node-set($path)/free_format_text"/>
								</xsl:with-param>
								<xsl:with-param name="swift-validate">N</xsl:with-param>
								<xsl:with-param name="rows">13</xsl:with-param>
								<xsl:with-param name="cols">60</xsl:with-param>
								<xsl:with-param name="maxlines">100</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="bank-record-amend">
		<xsl:param name="path"/> 
		<xsl:param name="org_path"/> 
		<xsl:param name="tnx_path"/>
		<xsl:param name="master">N</xsl:param>
		
		<!-- <xsl:variable name="org_path1" />
		<xsl:choose>
			<xsl:when test="$tnx_path = ''"><xsl:variable name="org_path1" select="$path" /></xsl:when>
			<xsl:otherwise><xsl:variable name="org_path1" select="$tnx_path" /></xsl:otherwise>
		</xsl:choose> -->

		<xsl:call-template name="amend-input-field">
		    <xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>    
			<xsl:with-param name="text"><xsl:value-of select="common:node-set($path)/name"/></xsl:with-param>
			<xsl:with-param name="org-text"><xsl:value-of select="common:node-set($org_path)/name"/></xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:choose>
					<xsl:when test="$master='N'"><xsl:value-of select="common:node-set($path)/name"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="common:node-set($tnx_path)/name"/></xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
			<xsl:with-param name="master" select="$master"/>
		</xsl:call-template>
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_PARTIESDETAILS_ADDRESS</xsl:with-param>
			<xsl:with-param name="text"><xsl:value-of select="common:node-set($path)/address_line_1"/></xsl:with-param>
			<xsl:with-param name="org-text"><xsl:value-of select="common:node-set($org_path)/address_line_1"/></xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:choose>
					<xsl:when test="$master='N'"><xsl:value-of select="common:node-set($path)/address_line_1"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="common:node-set($tnx_path)/address_line_1"/></xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
			<xsl:with-param name="master" select="$master" />
		</xsl:call-template>
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="text"><xsl:value-of select="common:node-set($path)/address_line_2"/></xsl:with-param>
			<xsl:with-param name="org-text"><xsl:value-of select="common:node-set($org_path)/address_line_2"/></xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:choose>
					<xsl:when test="$master='N'"><xsl:value-of select="common:node-set($path)/address_line_2"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="common:node-set($tnx_path)/address_line_2"/></xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
			<xsl:with-param name="master" select="$master" />
		</xsl:call-template>
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="text"><xsl:value-of select="common:node-set($path)/dom"/></xsl:with-param>
			<xsl:with-param name="org-text"><xsl:value-of select="common:node-set($org_path)/dom"/></xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:choose>
					<xsl:when test="$master='N'"><xsl:value-of select="common:node-set($path)/dom"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="common:node-set($tnx_path)/dom"/></xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
			<xsl:with-param name="master" select="$master" />
		</xsl:call-template>
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="text"><xsl:value-of select="common:node-set($path)/address_line_4"/></xsl:with-param>
			<xsl:with-param name="org-text"><xsl:value-of select="common:node-set($org_path)/address_line_4"/></xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:choose>
					<xsl:when test="$master='N'"><xsl:value-of select="common:node-set($path)/address_line_4"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="common:node-set($tnx_path)/address_line_4"/></xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
			<xsl:with-param name="master" select="$master" />
		</xsl:call-template>
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_JURISDICTION_BIC_CODE</xsl:with-param>
			<xsl:with-param name="text"><xsl:value-of select="common:node-set($path)/iso_code"/></xsl:with-param>
			<xsl:with-param name="org-text"><xsl:value-of select="common:node-set($org_path)/iso_code"/></xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:choose>
					<xsl:when test="$master='N'"><xsl:value-of select="common:node-set($path)/iso_code"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="common:node-set($tnx_path)/iso_code"/></xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
			<xsl:with-param name="master" select="$master" />
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="credit_available_with_bank">
		<!-- Credit Available With Bank -->
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_PAYMENTDETAILS_CR_AVAIL_WITH_LABEL</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="column-container">
					<xsl:with-param name="content">
						<xsl:variable name="txn-value" select="translate(common:node-set($tnx_path)/credit_available_with_bank/name,$up,$lo)" />
						<xsl:variable name="master-value" select="translate(common:node-set($prev_path)/credit_available_with_bank/name,$up,$lo)" />

 						<xsl:variable name="txn-val">
							<xsl:choose>
								<xsl:when test="$txn-value = '' or $txn-value='advising bank' or $txn-value='any bank' or $txn-value='issuing bank' or $txn-value='other'">
									<xsl:value-of select="common:node-set($tnx_path)/credit_available_with_bank/name"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_WITH_OTHER')"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>
						<xsl:variable name="master-val">
							<xsl:choose>
								<xsl:when test="$master-value = '' or $master-value='advising bank' or $master-value='any bank' or $master-value='issuing bank' or $master-value='other'">
									<xsl:value-of select="common:node-set($prev_path)/credit_available_with_bank/name"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_WITH_OTHER')"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:variable>

						<!-- master Column -->
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="appendClass">contentGray</xsl:with-param>
							<xsl:with-param name="content">
								<xsl:call-template name="amend-input-field">
								    <xsl:with-param name="label">XSL_PAYMENTDETAILS_CR_AVAIL_WITH_TYPE</xsl:with-param>    
									<xsl:with-param name="text"><xsl:value-of select="$master-val"/></xsl:with-param>
									<xsl:with-param name="org-text"><xsl:value-of select="$master-val"/></xsl:with-param>
									<xsl:with-param name="tnx-text"><xsl:value-of select="$txn-val"/></xsl:with-param>
									<xsl:with-param name="master">Y</xsl:with-param>
								</xsl:call-template>							
								<xsl:call-template name="bank-record-amend">
									<xsl:with-param name="path" select="common:node-set($tnx_path)/credit_available_with_bank"/> 
									<xsl:with-param name="org_path" select="common:node-set($prev_path)/credit_available_with_bank"/> 
									<xsl:with-param name="tnx_path" select="common:node-set($tnx_path)/credit_available_with_bank"/>
									<xsl:with-param name="master">Y</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						<!-- tnx Column -->
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="content">
								<xsl:call-template name="amend-input-field">
								    <xsl:with-param name="label">XSL_PAYMENTDETAILS_CR_AVAIL_WITH_TYPE</xsl:with-param>    
									<xsl:with-param name="text"><xsl:value-of select="$txn-val"/></xsl:with-param>
									<xsl:with-param name="org-text"><xsl:value-of select="$master-val"/></xsl:with-param>
								</xsl:call-template>								
								<xsl:call-template name="bank-record-amend">
									<xsl:with-param name="path" select="common:node-set($tnx_path)/credit_available_with_bank"/> 
									<xsl:with-param name="org_path" select="common:node-set($prev_path)/credit_available_with_bank"/> 
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="requested_confirmation_party">
		<!-- Requested Confirmation Party -->
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_BANKDETAILS_TAB_REQUESTED_CONFIRMATION_PARTY</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="column-container">
					<xsl:with-param name="content">
						<!-- master Column -->
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="appendClass">contentGray</xsl:with-param>
							<xsl:with-param name="content">
								<xsl:call-template name="amend-input-field">
								    <xsl:with-param name="label">XSL_CONFDETAILS_REQUESTED_CONFIRMATION_PARTY</xsl:with-param>    
									<xsl:with-param name="text"><xsl:value-of select="common:node-set($prev_path)/req_conf_party_flag"/></xsl:with-param>
									<xsl:with-param name="org-text"><xsl:value-of select="common:node-set($prev_path)/req_conf_party_flag"/></xsl:with-param>
									<xsl:with-param name="tnx-text"><xsl:value-of select="common:node-set($tnx_path)/req_conf_party_flag"/></xsl:with-param>
									<xsl:with-param name="master">Y</xsl:with-param>
								</xsl:call-template>
								
								<xsl:call-template name="bank-record-amend">
									<xsl:with-param name="path" select="common:node-set($tnx_path)/requested_confirmation_party"/> 
									<xsl:with-param name="org_path" select="common:node-set($prev_path)/requested_confirmation_party"/> 
									<xsl:with-param name="tnx_path" select="common:node-set($tnx_path)/requested_confirmation_party"/>
									<xsl:with-param name="master">Y</xsl:with-param>
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
						<!-- tnx Column -->
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="content">								
								<xsl:call-template name="amend-input-field">
								    <xsl:with-param name="label">XSL_CONFDETAILS_REQUESTED_CONFIRMATION_PARTY</xsl:with-param>    
									<xsl:with-param name="text"><xsl:value-of select="common:node-set($tnx_path)/req_conf_party_flag"/></xsl:with-param>
									<xsl:with-param name="org-text"><xsl:value-of select="common:node-set($prev_path)/req_conf_party_flag"/></xsl:with-param>
								</xsl:call-template>
								
								<xsl:call-template name="bank-record-amend">
									<xsl:with-param name="path" select="common:node-set($tnx_path)/requested_confirmation_party"/> 
									<xsl:with-param name="org_path" select="common:node-set($prev_path)/requested_confirmation_party"/> 
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="bank_info">
		<xsl:param name="nodeName" />
		<xsl:param name="legend" />
		<!-- generic Bank Info template-->
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend"><xsl:value-of select="$legend" /></xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="column-container">
					<xsl:with-param name="content">
						<!-- master Column -->
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="appendClass">contentGray</xsl:with-param>
							<xsl:with-param name="content">
								<xsl:choose>
									<!-- Advising Bank -->
									<xsl:when test="$nodeName = 'advising_bank'">
										<xsl:call-template name="bank-record-amend">
											<xsl:with-param name="path" select="common:node-set($tnx_path)/advising_bank"/> 
											<xsl:with-param name="org_path" select="common:node-set($prev_path)/advising_bank"/> 
											<xsl:with-param name="tnx_path" select="common:node-set($tnx_path)/advising_bank"/>
											<xsl:with-param name="master">Y</xsl:with-param>
										</xsl:call-template>
									</xsl:when>
									<!-- Advise thru Bank -->
									<xsl:when test="$nodeName = 'advise_thru_bank'">
										<xsl:call-template name="bank-record-amend">
											<xsl:with-param name="path" select="common:node-set($tnx_path)/advise_thru_bank"/> 
											<xsl:with-param name="org_path" select="common:node-set($prev_path)/advise_thru_bank"/> 
											<xsl:with-param name="tnx_path" select="common:node-set($tnx_path)/advise_thru_bank"/>
											<xsl:with-param name="master">Y</xsl:with-param>
										</xsl:call-template>									
									</xsl:when>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
						<!-- tnx Column -->
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="content">
								<xsl:choose>
									<!-- Advising Bank -->
									<xsl:when test="$nodeName = 'advising_bank'">
										<xsl:call-template name="bank-record-amend">
											<xsl:with-param name="path" select="common:node-set($tnx_path)/advising_bank"/> 
											<xsl:with-param name="org_path" select="common:node-set($prev_path)/advising_bank"/> 
										</xsl:call-template>
									</xsl:when>
									<!-- Advise thru Bank -->
									<xsl:when test="$nodeName = 'advise_thru_bank'">
										<xsl:call-template name="bank-record-amend">
											<xsl:with-param name="path" select="common:node-set($tnx_path)/advise_thru_bank"/> 
											<xsl:with-param name="org_path" select="common:node-set($prev_path)/advise_thru_bank"/> 
										</xsl:call-template>
									</xsl:when>
								</xsl:choose>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>	

	<xsl:template name="get-cr-avl-by-code">
		<xsl:param name="cr_avl_by_code_value"/>

		<xsl:choose>
			<xsl:when test="$cr_avl_by_code_value = '01'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_BY_PAYMENT')"/>
			</xsl:when>
			<xsl:when test="$cr_avl_by_code_value = '02'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_BY_ACCEPTANCE')"/>
			</xsl:when>
			<xsl:when test="$cr_avl_by_code_value = '03'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_BY_NEGOTIATION')"/>
			</xsl:when>
			<xsl:when test="$cr_avl_by_code_value = '04'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_BY_DEFERRED')"/>
			</xsl:when>
			<xsl:when test="$cr_avl_by_code_value = '05'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_BY_MIXED')"/>
			</xsl:when>
			<xsl:when test="$cr_avl_by_code_value = '06'">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_CR_AVAIL_BY_DEMAND')"/>
			</xsl:when>
		</xsl:choose>		
	</xsl:template>
	
	<xsl:template name="get-inco-term">
		<xsl:param name="inco-term"/>

		<xsl:if test="$inco-term = 'EXW'">
			<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_EXW')"/>
		</xsl:if>
		<xsl:if test="$inco-term = 'FCA'">
			<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_FCA')"/>
		</xsl:if>
		<xsl:if test="$inco-term = 'FAS'">
			<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_FAS')"/>
		</xsl:if>
		<xsl:if test="$inco-term = 'FOB'">
			<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_FOB')"/>
		</xsl:if>
		<xsl:if test="$inco-term = 'CFR'">
			<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_CFR')"/>
		</xsl:if>
		<xsl:if test="$inco-term = 'CIF'">
			<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_CIF')"/>
		</xsl:if>
		<xsl:if test="$inco-term = 'DAT'">
			<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_DAT')"/>
		</xsl:if>
		<xsl:if test="$inco-term = 'DAP'">
			<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_DAP')"/>
		</xsl:if>
		<xsl:if test="$inco-term = 'CPT'">
			<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_CPT')"/>
		</xsl:if>
		<xsl:if test="$inco-term = 'CIP'">
			<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_CIP')"/>
		</xsl:if>
		<xsl:if test="$inco-term = 'DDP'">
			<xsl:value-of select="localization:getGTPString($language, 'XSL_SHIPMENT_INCOTERM_DDP')"/>
		</xsl:if>	
	</xsl:template>
	
	<xsl:template name="get-renew-time-period-options">
		<xsl:param name="renew-time-period-options"/>
	  <xsl:if test="$renew-time-period-options = 'D'"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_DAYS')"/></xsl:if>
      <xsl:if test="$renew-time-period-options = 'W'"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_WEEKS')"/></xsl:if>
      <xsl:if test="$renew-time-period-options = 'M'"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_MONTHS')"/></xsl:if>
      <xsl:if test="$renew-time-period-options = 'Y'"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_YEARS')"/></xsl:if>
	</xsl:template>

	<xsl:template name="amend-input-field">
		<xsl:param name="label"/>
		<xsl:param name="text"/>
		<xsl:param name="org-text"/>
		<xsl:param name="master">N</xsl:param>
		<xsl:param name="tnx-text"/>
		<xsl:param name="translate-as"/>		

		<!--  ==<xsl:value-of select="$org-text" />==::==<xsl:value-of select="$text" />==<xsl:value-of select="$master" />	  -->
		<!-- to display everything. SHould be commented and uncomment any of the below 2 -->
		<!-- <xsl:if test="1 = 1"> -->
		<!-- uncomment below to hide only if both blanks or same -->
		<!-- <xsl:if test="($text != $org-text) or ($master!='N' and $org-text != $tnx-text)"> -->
		<!-- uncomment below to hide only if both are  blanks -->
		 <xsl:if test="($text != $org-text) or ($master!='N' and $org-text != $tnx-text) or ($text!='' and $org-text!='')">
			<xsl:call-template name="input-field">
				<xsl:with-param name="label" select="$label" />
				<xsl:with-param name="type">
					<xsl:choose>
						<xsl:when test="$translate-as = ''">text</xsl:when>
						<xsl:when test="$translate-as = 'integer' and (($master != 'N' and $org-text !='') or ($master = 'N' and $text !=''))">integer</xsl:when>
						<xsl:otherwise>text</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
				<xsl:with-param name="value">
					<xsl:choose>
						<xsl:when test="$master != 'N' and $org-text !=''">
							<xsl:choose>
								<xsl:when test="$translate-as = ''">
									<xsl:value-of select="$org-text"/>
								</xsl:when>
								<xsl:when test="$translate-as = 'country'">
									<xsl:value-of select="localization:getCodeData($language,'*','*','C006',$org-text)"/>
								</xsl:when>
								<xsl:when test="$translate-as = 'frequency'">
									<xsl:value-of select="localization:getDecode($language, 'C049', $org-text)"/>
								</xsl:when>
								<xsl:when test="$translate-as = 'frequency-DWMY'">
									<xsl:if test="$org-text = 'D'"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_DAYS')"/></xsl:if>
      								<xsl:if test="$org-text = 'W'"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_WEEKS')"/></xsl:if>
      								<xsl:if test="$org-text = 'M'"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_MONTHS')"/></xsl:if>
      								<xsl:if test="$org-text = 'Y'"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_YEARS')"/></xsl:if>
								</xsl:when>
								<xsl:when test="$translate-as = 'renew-amt'">
									<xsl:choose>
										<xsl:when test="$org-text = '01'"><xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_ORIGINAL_AMOUNT')"/></xsl:when>
						  				<xsl:when test="$org-text = '02'"><xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_CURRENT_AMOUNT')"/></xsl:when>
						  				<xsl:otherwise>&lt;BLANK&gt;</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:when test="$translate-as = 'cumulative'">
									<xsl:choose>
										<xsl:when test="$org-text='Y'"><xsl:value-of select="localization:getGTPString($language, 'XSL_CUMULATIVE')"/></xsl:when>
										<xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_NON_CUMULATIVE')"/></xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:when test="$translate-as = 'charge_upto'">
									<xsl:value-of select="localization:getDecode($language, 'C050', $org-text)"/>
								</xsl:when>
								<xsl:when test="$translate-as = 'renew-on'">
									<xsl:choose>
										<xsl:when test="$org-text = '01'">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EXPIRY')"/>
										</xsl:when>
										<xsl:when test="$org-text = '03'">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EVERY')"/>
										</xsl:when>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise><xsl:value-of select="$org-text"/></xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:when test="$master = 'N' and $text !=''">
							<xsl:choose>
								<xsl:when test="$translate-as = ''">
									<xsl:value-of select="$text"/>
								</xsl:when>
								<xsl:when test="$translate-as = 'country'">
									<xsl:value-of select="localization:getCodeData($language,'*','*','C006',$text)"/>
								</xsl:when>
								<xsl:when test="$translate-as = 'frequency'">
									<xsl:value-of select="localization:getDecode($language, 'C049', $text)"/>
								</xsl:when>
								<xsl:when test="$translate-as = 'frequency-DWMY'">
									<xsl:if test="$text = 'D'"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_DAYS')"/></xsl:if>
      								<xsl:if test="$text = 'W'"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_WEEKS')"/></xsl:if>
      								<xsl:if test="$text = 'M'"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_MONTHS')"/></xsl:if>
      								<xsl:if test="$text = 'Y'"><xsl:value-of select="localization:getGTPString($language, 'XSL_PAYMENTDETAILS_TENOR_YEARS')"/></xsl:if>
								</xsl:when>
								<xsl:when test="$translate-as = 'renew-amt'">
									<xsl:choose>
										<xsl:when test="$text = '01'"><xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_ORIGINAL_AMOUNT')"/></xsl:when>
						  				<xsl:when test="$text = '02'"><xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_CURRENT_AMOUNT')"/></xsl:when>
						  				<xsl:otherwise>&lt;BLANK&gt;</xsl:otherwise>
									</xsl:choose>
								</xsl:when>
								<xsl:when test="$translate-as = 'cumulative'">
									<xsl:choose>
										<xsl:when test="$text='Y'"><xsl:value-of select="localization:getGTPString($language, 'XSL_CUMULATIVE')"/></xsl:when>
										<xsl:otherwise><xsl:value-of select="localization:getGTPString($language, 'XSL_NON_CUMULATIVE')"/></xsl:otherwise>
									</xsl:choose>
								</xsl:when>
				 				<xsl:when test="$translate-as = 'charge_upto'">
									<xsl:value-of select="localization:getDecode($language, 'C050', $text)"/>
								</xsl:when>
								<xsl:when test="$translate-as = 'renew-on'">
									<xsl:choose>
										<xsl:when test="$text = '01'">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EXPIRY')"/>
										</xsl:when>
										<xsl:when test="$text = '03'">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EVERY')"/>
										</xsl:when>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise><xsl:value-of select="$text"/></xsl:otherwise>
							</xsl:choose>							
						</xsl:when>						
						<xsl:otherwise>&lt;BLANK&gt;</xsl:otherwise>
					</xsl:choose>       		
				</xsl:with-param>
				<xsl:with-param name="highlight">
					<xsl:choose>
						<xsl:when test="$master = 'N' and $text != $org-text">Y</xsl:when>
						<xsl:otherwise>N</xsl:otherwise>
					</xsl:choose>
				</xsl:with-param>
			</xsl:call-template>		
		</xsl:if>		
	</xsl:template>
	
	
	<xsl:template name="narrative-amend-content">
		<xsl:param name="id"/>
		<xsl:param name="text"/>
		<xsl:param name="org-text"/>
		<xsl:param name="header"/>
		<xsl:variable name="narrativeMaster">
			<xsl:if test = "$org-text/issuance/data/datum/text != ''">
				&lt;b&gt;<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>&lt;/b&gt;&lt;br&gt;<xsl:value-of select="$org-text/issuance/data/datum/text"/>&lt;br&gt;
			</xsl:if>
  			<xsl:for-each select="$org-text/amendments/amendment">
	  			<xsl:if test = "(/lc_tnx_record/tnx_stat_code [.!= '04'] or /si_tnx_record/tnx_stat_code [.!= '04'] or /el_tnx_record/tnx_stat_code [.!= '04'] or /sr_tnx_record/tnx_stat_code [.!= '04'])
	  			                and //amd_no &gt;= sequence">
					&lt;b&gt;<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>&lt;/b&gt;&lt;br&gt;
					<xsl:for-each select="data/datum">
						<xsl:if test="verb != ''">
							&lt;b&gt;/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
							<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
							<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/&lt;/b&gt;
						</xsl:if>
						<xsl:if test="text != ''">
						<p style="white-space: pre-wrap;">
						<xsl:value-of select="text" />&lt;br&gt;
						</p>
						</xsl:if>
					</xsl:for-each>
					&lt;br&gt;
				</xsl:if>	
				<xsl:if test = "(/lc_tnx_record/tnx_stat_code [.= '04'] or /si_tnx_record/tnx_stat_code [.= '04'] or /el_tnx_record/tnx_stat_code [.= '04'] or /sr_tnx_record/tnx_stat_code [.= '04'])
				                and //amd_no &gt; sequence">
					&lt;b&gt;<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>&lt;/b&gt;&lt;br&gt;
					<xsl:for-each select="data/datum">
						<xsl:if test="verb != ''">
							&lt;b&gt;/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
							<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
							<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/&lt;/b&gt;
						</xsl:if>
						<xsl:if test="text != ''">
						<p style="white-space: pre-wrap;">
						<xsl:value-of select="text" />&lt;br&gt;
						</p>
						</xsl:if>
					</xsl:for-each>
					&lt;br&gt;
				</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<xsl:variable name="narrativeTnx">
			<xsl:if test="$text/amendments/amendment">
			&lt;br&gt;&lt;b&gt;<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="$text/amendments/amendment/sequence"/>&lt;/b&gt;&lt;br&gt;
				<xsl:for-each select="$text/amendments/amendment/data/datum">
					<xsl:if test="verb != ''">
						&lt;b&gt;/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
						<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
						<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/&lt;/b&gt;
					</xsl:if>
					<xsl:if test="text != ''">
					<p style="white-space: pre-wrap;">
					<xsl:value-of select="text" />&lt;br&gt;
					</p>
					</xsl:if>
				</xsl:for-each>
				&lt;br&gt;
			</xsl:if>	
		</xsl:variable>
			<xsl:call-template name="column-container">
				<xsl:with-param name="content">
					<!-- master Column -->
					<xsl:call-template name="column-wrapper">
						<xsl:with-param name="appendClass">contentGray</xsl:with-param>
						<xsl:with-param name="content"> 
						<xsl:call-template name="fieldset-wrapper">
					    	<xsl:with-param name="legend"><xsl:value-of select="$header"/></xsl:with-param>
						    <xsl:with-param name="legend-type">indented-header</xsl:with-param>
						    <xsl:with-param name="button-type">
						    	<xsl:choose>
							    	<xsl:when test="$org-text/issuance/data/datum/text!='' or ($org-text/amendments and //amd_no &gt; $org-text/amendments/amendment/sequence)">extended-narrative</xsl:when>
							    	<xsl:otherwise/>
						    	</xsl:choose>
						    </xsl:with-param>
						    <xsl:with-param name="id" select="$id"/>
						    <xsl:with-param name="messageValue"><xsl:value-of select="$narrativeMaster"/></xsl:with-param>
						    <xsl:with-param name="content">
							<xsl:call-template name="narrative-amend-codeword-master">
								<xsl:with-param name="text1" select="$org-text" />
								<xsl:with-param name="isMaster">Y</xsl:with-param>
							</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>	             
						</xsl:with-param>
					</xsl:call-template>
					<!-- tnx Column -->
					<xsl:call-template name="column-wrapper">
						<xsl:with-param name="content"> 
						<xsl:call-template name="fieldset-wrapper">
					    	<xsl:with-param name="legend"><xsl:value-of select="$header"/></xsl:with-param>
						    <xsl:with-param name="legend-type">indented-header</xsl:with-param>
						    <xsl:with-param name="button-type">extended-narrative</xsl:with-param>
						    <xsl:with-param name="id" select="$id"/>
						    <xsl:with-param name="messageValue"><xsl:value-of select="$narrativeTnx"/></xsl:with-param>
						    <xsl:with-param name="content">
							<xsl:call-template name="narrative-amend-codeword-master">
								<xsl:with-param name="text1" select="$text" />
								<xsl:with-param name="isMaster">N</xsl:with-param>
							</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>			     
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="narrative-amend-codeword-master">
		<xsl:param name="text1" />	
		<xsl:param name="isMaster">N</xsl:param>
		<div class="divScrollNarrativeWide">
		<xsl:if test="$text1/issuance/data/datum/text !=''">
  			<div style="width:98%;">
			<div class="indented-header" style="width:100%;" align="left">
				<h3 class="toc-item">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_ISSUANCE')"/>
				</h3>
			</div>
			<div style="width:100%;">
				<p style="white-space: pre-wrap;width:100%;">
					<xsl:value-of select="converttools:displaySwiftNarrative($text1/issuance/data/datum/text, 6)" />
				</p>
			</div>
		</div>
		</xsl:if>
  			<xsl:if test="$text1/amendments/amendment/data/datum">
	  			<div style="width:98%;">
				<xsl:for-each select="$text1/amendments/amendment">
					<xsl:if test="(/lc_tnx_record/tnx_stat_code [.!= '04'] or /si_tnx_record/tnx_stat_code [.!= '04'] or /el_tnx_record/tnx_stat_code [.!= '04'] or /sr_tnx_record/tnx_stat_code [.!= '04'])
                                   and ($isMaster ='N' or (//amd_no &gt;= sequence))">
					<div class="indented-header" style="width:100%;" align="left">
						<h3 class="toc-item">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>
						</h3>
					</div>
					<xsl:for-each select="data/datum">
						<div style="width:100%;">
							<p style="white-space: pre-wrap;width:100%;">
								<b>/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
								<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
								<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/</b>&nbsp;<xsl:value-of select="converttools:displaySwiftNarrative(text, 2)" />
							</p>
						</div>
					</xsl:for-each>
					</xsl:if>
					
					<xsl:if test="(/lc_tnx_record/tnx_stat_code [.= '04'] or /si_tnx_record/tnx_stat_code [.= '04'] or /el_tnx_record/tnx_stat_code [.= '04'] or /sr_tnx_record/tnx_stat_code [.= '04'])
					              and ($isMaster ='N' or (//amd_no &gt; sequence))">
				
					<div class="indented-header" style="width:100%;" align="left">
						<h3 class="toc-item">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_SUB_AMENDMENT')"/>&nbsp;<xsl:value-of select="sequence"/>
						</h3>
					</div>
					<xsl:for-each select="data/datum">
						<div style="width:100%;">
							<p style="white-space: pre-wrap;width:100%;">
								<b>/<xsl:if test="verb = 'ADD'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_ADD')"/></xsl:if>
								<xsl:if test="verb = 'DELETE'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_DELETE')"/></xsl:if>
								<xsl:if test="verb = 'REPALL'"><xsl:value-of select="localization:getGTPString($language, 'XSL_NARRATIVE_REPALL')"/></xsl:if>/</b>&nbsp;<xsl:value-of select="converttools:displaySwiftNarrative(text, 2)" />
							</p>
						</div>
					</xsl:for-each>
					</xsl:if>
					
				</xsl:for-each>
				</div>	
			</xsl:if>		
			<xsl:if test="$isMaster = 'Y' and $text1/issuance/data/datum/text=''">&lt;<xsl:value-of select="localization:getGTPString($language, 'XSL_NO_ISSUANCE_DATA')"/>&gt;</xsl:if>
			<xsl:if test="$isMaster = 'Y'  and not($text1/amendments)"><br></br>&lt;<xsl:value-of select="localization:getGTPString($language, 'XSL_NO_AMENDMENT_DATA')"/>&gt;</xsl:if>
		</div>
	</xsl:template>

	<xsl:template name="narrative-tab-content">
		<xsl:param name="text"/>
		<xsl:param name="org-text"/>
		 <xsl:if test="$text != $org-text or ($text != '' and $org-text != '')"> 
			<xsl:call-template name="column-container">
				<xsl:with-param name="content">
					<!-- master Column -->
					<xsl:call-template name="column-wrapper">
						<xsl:with-param name="appendClass">contentGray</xsl:with-param>
						<xsl:with-param name="content"> 
							<xsl:call-template name="narrative-scroll">
								<xsl:with-param name="text" select="$org-text" />
								<xsl:with-param name="org-text" select="$org-text" />
							</xsl:call-template>	             
						</xsl:with-param>
					</xsl:call-template>
					<!-- tnx Column -->
					<xsl:call-template name="column-wrapper">
						<xsl:with-param name="content"> 
							<xsl:call-template name="narrative-scroll">
								<xsl:with-param name="text" select="$text" />
								<xsl:with-param name="org-text" select="$org-text" />
							</xsl:call-template>			     
						</xsl:with-param>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<xsl:template name="narrative-scroll">
		<xsl:param name="text" />
		<xsl:param name="org-text" />
		<xsl:variable name="highlight">
			<xsl:choose>
				<xsl:when test="$text = $org-text">N</xsl:when>
				<xsl:otherwise>Y</xsl:otherwise>
			</xsl:choose>		
		</xsl:variable>

		<div>
			<xsl:choose>
				<xsl:when test="$highlight='Y'">
					<xsl:attribute name="class">divScrollNarrative highlight</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="class">divScrollNarrative</xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>		
			<xsl:choose>
				<xsl:when test="$text != ''">
					<xsl:call-template name="string_replace">
						<xsl:with-param name="input_text" select="$text"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>&lt;BLANK&gt;</xsl:otherwise>
			</xsl:choose>
		</div>
	</xsl:template>
	
  <!-- This template displays the beneficiary address -->
	<xsl:template name="renewaldetails">
		<xsl:param name="path"/>
		<xsl:param name="org_path"/> 
		<xsl:param name="org_path1">N</xsl:param>

		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_RENEWAL_ALLOWED</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/renew_flag"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/renew_flag"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/renew_flag"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>
		<xsl:if test="common:node-set($path)/renew_on_code!='' or  common:node-set($org_path)/renew_on_code!=''">	
			<xsl:call-template name="amend-input-field">
				<xsl:with-param name="label">XSL_RENEWAL_RENEW_ON</xsl:with-param>
				<xsl:with-param name="text">
					<xsl:value-of select="common:node-set($path)/renew_on_code"/>			
				</xsl:with-param>
				<xsl:with-param name="org-text">
					<xsl:value-of select="common:node-set($org_path)/renew_on_code"/>
				</xsl:with-param>
				<xsl:with-param name="tnx-text">
					<xsl:value-of select="common:node-set($path)/renew_on_code"/>
				</xsl:with-param>
				<xsl:with-param name="master" select="$org_path1" />
				<xsl:with-param name="translate-as">renew-on</xsl:with-param>
		</xsl:call-template>
		</xsl:if>
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label"/>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/renewal_calendar_date"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/renewal_calendar_date"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/renewal_calendar_date"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>		
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_RENEWAL_RENEW_FOR</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/renew_for_nb"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/renew_for_nb"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/renew_for_nb"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label"/>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/renew_for_period"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/renew_for_period"/>			
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/renew_for_period"/>				
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
			<xsl:with-param name="translate-as">frequency-DWMY</xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_RENEWAL_ADVISE_FO</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/advise_renewal_flag"/>			
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/advise_renewal_flag"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/advise_renewal_flag"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>
      <xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_RENEWAL_DAYS_NOTICE</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/advise_renewal_days_nb"/>			
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/advise_renewal_days_nb"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/advise_renewal_days_nb"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>

		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_RENEWAL_ROLLING_RENEWAL_FO</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/rolling_renewal_flag"/>			
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/rolling_renewal_flag"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/rolling_renewal_flag"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>
		<xsl:if test="common:node-set($path)/rolling_renew_on_code!='' or  common:node-set($org_path)/rolling_renew_on_code!=''">
		<xsl:call-template name="input-field">
			<xsl:with-param name="label">XSL_RENEWAL_RENEW_ON</xsl:with-param>
			<xsl:with-param name="value">
				<xsl:choose>
					<xsl:when test="common:node-set($path)/rolling_renew_on_code [. = '01']">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EXPIRY')"/>
					</xsl:when>
					<xsl:when test="common:node-set($path)/rolling_renew_on_code [. = '03']">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_RENEWAL_EVERY')"/>
					</xsl:when>
					<xsl:otherwise>&lt;BLANK&gt;</xsl:otherwise>
				</xsl:choose>
			</xsl:with-param>
			<xsl:with-param name="highlight">
				<xsl:choose>
					<xsl:when test="common:node-set($path)/rolling_renew_on_code = common:node-set($org_path)/rolling_renew_on_code">N</xsl:when>
					<xsl:otherwise>Y</xsl:otherwise>
					</xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
		</xsl:if>
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">FREQUENCY_LABEL</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/rolling_renew_for_nb"/>			
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/rolling_renew_for_nb"/>
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/rolling_renew_for_nb"/>
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label"/>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/rolling_renew_for_period"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/rolling_renew_for_period"/>			
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/rolling_renew_for_period"/>				
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
			<xsl:with-param name="translate-as">frequency-DWMY</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_ROLLING_DAY_IN_MONTH</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/rolling_day_in_month"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/rolling_day_in_month"/>			
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/rolling_day_in_month"/>				
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
			<xsl:with-param name="translate-as">integer</xsl:with-param>
		</xsl:call-template>	
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_RENEWAL_NUMBER_RENEWALS</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/rolling_renewal_nb"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/rolling_renewal_nb"/>			
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/rolling_renewal_nb"/>				
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
			<xsl:with-param name="translate-as">integer</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_RENEWAL_CANCELLATION_NOTICE</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/rolling_cancellation_days"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/rolling_cancellation_days"/>			
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/rolling_cancellation_days"/>				
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
			<xsl:with-param name="translate-as">integer</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_RENEWAL_AMOUNT</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/renew_amt_code"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/renew_amt_code"/>			
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/renew_amt_code"/>				
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
			<xsl:with-param name="translate-as">renew-amt</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_RENEWAL_PROJECTED_EXPIRY_DATE</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/projected_expiry_date"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/projected_expiry_date"/>			
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/projected_expiry_date"/>				
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>
		<xsl:call-template name="amend-input-field">
			<xsl:with-param name="label">XSL_RENEWAL_FINAL_EXPIRY_DATE</xsl:with-param>
			<xsl:with-param name="text">
				<xsl:value-of select="common:node-set($path)/final_expiry_date"/>
			</xsl:with-param>
			<xsl:with-param name="org-text">
				<xsl:value-of select="common:node-set($org_path)/final_expiry_date"/>			
			</xsl:with-param>
			<xsl:with-param name="tnx-text">
				<xsl:value-of select="common:node-set($org_path1)/final_expiry_date"/>				
			</xsl:with-param>
			<xsl:with-param name="master" select="$org_path1" />
		</xsl:call-template>
	</xsl:template>
	
	<!-- This template displays the issuing bank details of the transaction -->
	<xsl:template name="amend-view-issuing-bank-details">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_BANKDETAILS_TAB_ISSUING_BANK</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="content">
						<!-- master Column -->
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="appendClass">contentGray</xsl:with-param>
							<xsl:with-param name="content">								
										<xsl:call-template name="bank-record-amend">
											<xsl:with-param name="path" select="common:node-set($tnx_path)/issuing_bank"/> 
											<xsl:with-param name="org_path" select="common:node-set($prev_path)/issuing_bank"/> 
											<xsl:with-param name="tnx_path" select="common:node-set($tnx_path)/issuing_bank"/>
											<xsl:with-param name="master">Y</xsl:with-param>
										</xsl:call-template>									
							</xsl:with-param>
						</xsl:call-template>
						<!-- tnx Column -->
						<xsl:call-template name="column-wrapper">
							<xsl:with-param name="content">								
										<xsl:call-template name="bank-record-amend">
											<xsl:with-param name="path" select="common:node-set($tnx_path)/issuing_bank"/> 
											<xsl:with-param name="org_path" select="common:node-set($prev_path)/issuing_bank"/> 
										</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>	

</xsl:stylesheet>