<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
        xmlns:securityCheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
        xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
        xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		exclude-result-prefixes="localization securityCheck security utils">
 
 <xsl:param name="rundata"/>
 <xsl:param name="contextPath"/>
 <xsl:param name="servletPath"/>
 
	<!--
	From General Scratch
	-->
	<xsl:template name="tf-general-financing-types">
		<xsl:choose>
			<xsl:when test="$displaymode='edit'">
				<option value='OTHER'>
					<xsl:value-of select="localization:getDecode($language, 'N047', 'OTHER')"/>
				</option>
			</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="localization:getDecode($language, 'N047', sub_product_code)"/>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<!--
	From Import Scratch
	-->
	<xsl:template name="tf-import-financing-types">
		<xsl:choose>
			<xsl:when test="$displaymode='edit'">
				<!-- <xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_iinvf_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_iinvf_access',utils:getUserEntities($rundata)))))">
					<option value='IINVF'>
					<xsl:value-of select="localization:getDecode($language, 'N047', 'IINVF')"/>
					</option>
				</xsl:if>-->
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_iothf_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_iothf_access',utils:getUserEntities($rundata)))))">
					<option value='IOTHF'>
					<xsl:value-of select="localization:getDecode($language, 'N047', 'IOTHF')"/>
					</option>
				</xsl:if>
			</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="localization:getDecode($language, 'N047', sub_product_code)"/>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
   
	<!--
	From Export Scratch
	-->
	<xsl:template name="tf-export-financing-types">
		<xsl:choose>
			<xsl:when test="$displaymode='edit'">
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_epckc_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_epckc_access',utils:getUserEntities($rundata)))))">
					<option value='EPCKC'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'EPCKC')"/>
					</option>
				</xsl:if>
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_efrtl_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_efrtl_access',utils:getUserEntities($rundata)))))">
					<option value='EFRTL'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'EFRTL')"/>
					</option>
				</xsl:if>
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_einvf_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_einvf_access',utils:getUserEntities($rundata)))))">
					<option value='EINVF'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'EINVF')"/>
					</option>
				</xsl:if>
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_ecrbp_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_ecrbp_access',utils:getUserEntities($rundata)))))">
					<option value='ECRBP'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'ECRBP')"/>
					</option>
				</xsl:if>
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_eothf_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_eothf_access',utils:getUserEntities($rundata)))))">
					<option value='EOTHF'>
						<xsl:value-of select="localization:getDecode($language, 'N047','EOTHF')"/>
					</option>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="localization:getDecode($language, 'N047', sub_product_code)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
   
	<!--
	From Import LC
	-->
	<xsl:template name="tf-import-LC-financing-types">
		<xsl:choose>
			<xsl:when test="$displaymode='edit'">
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_itrpt_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_itrpt_access',utils:getUserEntities($rundata)))))">
					<option value='ITRPT'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'ITRPT')"/>
					</option>
				</xsl:if>
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_ilnlc_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_ilnlc_access',utils:getUserEntities($rundata)))))">
					<option value='ILNLC'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'ILNLC')"/>
					</option>
				</xsl:if>
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_ibclc_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_ibclc_access',utils:getUserEntities($rundata)))))">
					<option value='IBCLC'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'IBCLC')"/>
					</option>
				</xsl:if>
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_iothf_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_iothf_access',utils:getUserEntities($rundata)))))">
					<option value='IOTHF'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'IOTHF')"/>
					</option>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="localization:getDecode($language, 'N047', sub_product_code)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--
	From Import IC
	-->
	<xsl:template name="tf-import-IC-financing-types">
		<xsl:choose>
			<xsl:when test="$displaymode='edit'">
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_itrpt_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_itrpt_access',utils:getUserEntities($rundata)))))">
					<option value='ITRPT'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'ITRPT')"/>
					</option>
				</xsl:if>
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_ilnic_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_ilnic_access',utils:getUserEntities($rundata)))))">
					<option value='ILNIC'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'ILNIC')"/>
					</option>
				</xsl:if>
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_ibclc_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_ibclc_access',utils:getUserEntities($rundata)))))">
					<option value='IBCLC'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'IBCLC')"/>
					</option>
				</xsl:if>
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_iothf_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_iothf_access',utils:getUserEntities($rundata)))))">
					<option value='IOTHF'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'IOTHF')"/>
					</option>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="localization:getDecode($language, 'N047', sub_product_code)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--
	From Export LC
	-->
	<xsl:template name="tf-export-LC-financing-types">
		<xsl:choose>
			<xsl:when test="$displaymode='edit'">
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_ecrbp_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_ecrbp_access',utils:getUserEntities($rundata)))))">
					<option value='ECRBP'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'ECRBP')"/>
					</option>
				</xsl:if>
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_epckc_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_epckc_access',utils:getUserEntities($rundata)))))">
					<option value='EPCKC'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'EPCKC')"/>
					</option>
				</xsl:if>
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_edilc_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_edilc_access',utils:getUserEntities($rundata)))))">
					<option value='EDILC'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'EDILC')"/>
					</option>
				</xsl:if>
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_eothf_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_eothf_access',utils:getUserEntities($rundata)))))">
					<option value='EOTHF'>
						<xsl:value-of select="localization:getDecode($language, 'N047','EOTHF')"/>
					</option>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="localization:getDecode($language, 'N047', sub_product_code)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!--
	From Export Collection
	-->
	<xsl:template name="tf-export-Collection-financing-types">
		<xsl:choose>
			<xsl:when test="$displaymode='edit'">
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_ebexp_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_ebexp_access',utils:getUserEntities($rundata)))))">
					<option value='EBEXP'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'EBEXP')"/>
					</option>
				</xsl:if>
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_ediec_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_ediec_access',utils:getUserEntities($rundata)))))">
					<option value='EDIEC'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'EDIEC')"/>
					</option>
				</xsl:if>
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_eothf_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_eothf_access',utils:getUserEntities($rundata)))))">
					<option value='EOTHF'>
						<xsl:value-of select="localization:getDecode($language, 'N047','EOTHF')"/>
					</option>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="localization:getDecode($language, 'N047', sub_product_code)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
		   
	<!--
	All Financing Types
	-->
	<xsl:template name="tf-all-financing-types">
		<xsl:choose>
			<xsl:when test="$displaymode='edit'">
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_itrpt_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_itrpt_access',utils:getUserEntities($rundata)))))">
					<option value='ITRPT'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'ITRPT')"/>
					</option>
				</xsl:if>
				<!-- <xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_iinvf_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_iinvf_access',utils:getUserEntities($rundata)))))">
					<option value='IINVF'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'IINVF')"/>
					</option>
				</xsl:if>-->
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_ilnlc_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_ilnlc_access',utils:getUserEntities($rundata)))))">
					<option value='ILNLC'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'ILNLC')"/>
					</option>
				</xsl:if>
				<xsl:if	test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_ibclc_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_ibclc_access',utils:getUserEntities($rundata)))))">
					<option value='IBCLC'>
					<xsl:value-of select="localization:getDecode($language, 'N047', 'IBCLC')" />
					</option>
				</xsl:if>
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_ilnic_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_ilnic_access',utils:getUserEntities($rundata)))))">
					<option value='ILNIC'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'ILNIC')"/>
					</option>
				</xsl:if>
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_iothf_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_iothf_access',utils:getUserEntities($rundata)))))">
					<option value='IOTHF'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'IOTHF')"/>
					</option>
				</xsl:if>
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_epckc_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_epckc_access',utils:getUserEntities($rundata)))))">
					<option value='EPCKC'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'EPCKC')"/>
					</option>
				</xsl:if>
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_efrtl_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_efrtl_access',utils:getUserEntities($rundata)))))">
					<option value='EFRTL'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'EFRTL')"/>
					</option>
				</xsl:if>
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_einvf_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_einvf_access',utils:getUserEntities($rundata)))))">
					<option value='EINVF'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'EINVF')"/>
					</option>
				</xsl:if>
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_ecrbp_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_ecrbp_access',utils:getUserEntities($rundata)))))">
					<option value='ECRBP'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'ECRBP')"/>
					</option>
				</xsl:if>
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_ebexp_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_ebexp_access',utils:getUserEntities($rundata)))))">
					<option value='EBEXP'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'EBEXP')"/>
					</option>
				</xsl:if>
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_edilc_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_edilc_access',utils:getUserEntities($rundata)))))">
					<option value='EDILC'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'EDILC')"/>
					</option>
				</xsl:if>
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_ediec_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_ediec_access',utils:getUserEntities($rundata)))))">
					<option value='EDIEC'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'EDIEC')"/>
					</option>
				</xsl:if>
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_eothf_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_eothf_access',utils:getUserEntities($rundata)))))">
					<option value='EOTHF'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'EOTHF')"/>
					</option>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="localization:getDecode($language, 'N047', sub_product_code)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
 
 
	<!--
	Export Financing Types
	-->
	<xsl:template name="tf-export-all-financing-types">
		<xsl:choose>
			<xsl:when test="$displaymode='edit'">
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_epckc_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_epckc_access',utils:getUserEntities($rundata)))))">
					<option value='EPCKC'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'EPCKC')"/>
					</option>
				</xsl:if>
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_efrtl_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_efrtl_access',utils:getUserEntities($rundata)))))">
					<option value='EFRTL'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'EFRTL')"/>
					</option>
				</xsl:if>
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_einvf_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_einvf_access',utils:getUserEntities($rundata)))))">
					<option value='EINVF'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'EINVF')"/>
					</option>
				</xsl:if>
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_ecrbp_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_ecrbp_access',utils:getUserEntities($rundata)))))">
					<option value='ECRBP'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'ECRBP')"/>
					</option>
				</xsl:if>
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_ebexp_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_ebexp_access',utils:getUserEntities($rundata)))))">
					<option value='EBEXP'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'EBEXP')"/>
					</option>
				</xsl:if>
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_edilc_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_edilc_access',utils:getUserEntities($rundata)))))">
					<option value='EDILC'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'EDILC')"/>
					</option>
				</xsl:if>
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_ediec_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_ediec_access',utils:getUserEntities($rundata)))))">
					<option value='EDIEC'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'EDIEC')"/>
					</option>
				</xsl:if>
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_eothf_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_eothf_access',utils:getUserEntities($rundata)))))">
					<option value='EOTHF'>
						<xsl:value-of select="localization:getDecode($language, 'N047','EOTHF')"/>
					</option>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="localization:getDecode($language, 'N047', sub_product_code)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
   
	<!--
	All Import Financing Types
	-->
	<xsl:template name="tf-import-all-financing-types">
		<xsl:choose>
			<xsl:when test="$displaymode='edit'">
				<!-- <xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_iinvf_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_iinvf_access',utils:getUserEntities($rundata)))))">
					<option value='IINVF'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'IINVF')"/>
					</option>
				</xsl:if>-->
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_itrpt_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_itrpt_access',utils:getUserEntities($rundata)))))">
					<option value='ITRPT'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'ITRPT')"/>
					</option>
				</xsl:if>
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_ilnlc_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_ilnlc_access',utils:getUserEntities($rundata)))))">
					<option value='ILNLC'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'ILNLC')"/>
					</option>
				</xsl:if>	
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_ibclc_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_ibclc_access',utils:getUserEntities($rundata)))))">
					<option value='IBCLC'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'IBCLC')"/>
					</option>
				</xsl:if>			
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_ilnic_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_ilnic_access',utils:getUserEntities($rundata)))))">
					<option value='ILNIC'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'ILNIC')"/>
					</option>
				</xsl:if>
				<xsl:if test="(((not(security:isBank($rundata))) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tf_iothf_access',utils:getUserEntities($rundata)))) or 
								(security:isBank($rundata) and (securityCheck:hasPermission(utils:getUserACL($rundata),'tradeadmin_tf_iothf_access',utils:getUserEntities($rundata)))))">
					<option value='IOTHF'>
						<xsl:value-of select="localization:getDecode($language, 'N047', 'IOTHF')"/>
					</option>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="localization:getDecode($language, 'N047', sub_product_code)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
 
 </xsl:stylesheet>