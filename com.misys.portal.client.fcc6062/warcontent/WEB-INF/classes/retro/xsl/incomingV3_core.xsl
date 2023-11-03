<?xml version="1.0"?>
<!--
   Copyright (c) 2000-2011 Misys (http://www.misys.com),
   All Rights Reserved. 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
							xmlns:service="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
							exclude-result-prefixes="service">
	
	<xsl:import href="incomingV3LC.xsl"/>
	<xsl:import href="incomingV3EL.xsl"/>
	<xsl:import href="incomingV3EC.xsl"/>
	<xsl:import href="incomingV3IC.xsl"/>
	<xsl:import href="incomingV3BG.xsl"/>
	<xsl:import href="incomingV3BR.xsl"/>
	<xsl:import href="incomingV3TF.xsl"/>
	<xsl:import href="incomingV3SG.xsl"/>
	<xsl:import href="incomingV3IR.xsl"/>
	<xsl:import href="incomingV3SI.xsl"/>
	<xsl:import href="incomingV3SR.xsl"/>
	<xsl:import href="incomingV3FT.xsl"/>
	<xsl:import href="incomingV3PO.xsl"/>
	<xsl:import href="incomingV3IN.xsl"/>
	<xsl:import href="incomingV3IP.xsl"/>
	<xsl:import href="incomingV3rate.xsl"/>
	<xsl:import href="incomingV3currencies.xsl"/>
	<xsl:import href="incomingV3BORef.xsl"/>
	<xsl:import href="incomingV3IO.xsl"/>
	<xsl:import href="incomingV3CN.xsl"/>
	<xsl:import href="incomingV3LS.xsl"/>
	<xsl:import href="incomingV3EA.xsl"/>
	<xsl:import href="incomingV3BK.xsl"/>
	<xsl:import href="incomingV3LI.xsl"/>
	
	
	<!-- ******* FUNCTIONS *******-->
	<!-- recursive copy of all elements and attributes -->
	<xsl:template match="@*|node()" mode="copy_all">
	  <xsl:copy>
		<xsl:apply-templates select="@*|node()" mode="copy_all"/>
	  </xsl:copy>
	</xsl:template>

	<xsl:template match="*" mode="copy_element">
		<xsl:apply-templates select="." mode="copy_all"></xsl:apply-templates>
	</xsl:template>
	
	<xsl:template match="*" mode="copy_additional">
		<xsl:param name="ignoreAdditional"/>
		<xsl:choose>
			<xsl:when test="contains($ignoreAdditional,@name)"/>
			<xsl:otherwise><xsl:apply-templates select="." mode="copy_all"></xsl:apply-templates></xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<!-- Additional field => element -->
	<xsl:template match="*" mode="add_to_element">
		<xsl:element name="{@name}"><xsl:value-of select="."/></xsl:element>
	</xsl:template>
	
	<!-- 
		creates cross references
		* org_tnx_id => Original tnx
		* prod_stat_code = 12 => Discrepancy 
	-->	
	<xsl:template name="cross_ref">
		<xsl:if test="org_tnx_id!='' or prod_stat_code[.='12' or .='31' or .='78' or .='79' or .='81' or .='84' or .='98'] or sub_tnx_type_code[.='78'] or (prod_stat_code[.='08' or .='06'] and tnx_type_code[.='03' or .='15'] and parent_bo_tnx_id[.!=''])">
			<cross_references>
				<xsl:if test="org_tnx_id!=''">
					<cross_reference>
						<brch_code><xsl:value-of select="brch_code"/></brch_code>
						<ref_id><xsl:value-of select="ref_id"/></ref_id>
						<tnx_id><xsl:value-of select="org_tnx_id"/></tnx_id>
						<cross_reference_id></cross_reference_id>
						<product_code><xsl:value-of select="product_code"/></product_code>
						<child_product_code><xsl:value-of select="product_code"/></child_product_code>
						<child_ref_id><xsl:value-of select="ref_id"/></child_ref_id>
						<child_tnx_id><xsl:value-of select="tnx_id"/></child_tnx_id>
						<type_code>01</type_code>
					</cross_reference>
				</xsl:if>
				<!-- The below portion is taken care in ActionRequiredHandler.java for LC -->
				<xsl:if test="prod_stat_code[.='12' or .='78' or .='79' or .='84'] and product_code [.!='LC']">
						<cross_reference>
							<brch_code><xsl:value-of select="brch_code"/></brch_code>
							<cross_reference_id></cross_reference_id>
							<product_code><xsl:value-of select="product_code"/></product_code>
							<child_product_code><xsl:value-of select="product_code"/></child_product_code>
							<child_ref_id><xsl:value-of select="ref_id"/></child_ref_id>
							<child_tnx_id></child_tnx_id>
							<type_code>01</type_code>
						</cross_reference>
				</xsl:if>
				<xsl:if test="prod_stat_code[.='78' or .='79' or .='84'] and product_code [.='LC']">
						<cross_reference>
							<brch_code><xsl:value-of select="brch_code"/></brch_code>
							<cross_reference_id></cross_reference_id>
							<product_code><xsl:value-of select="product_code"/></product_code>
							<child_product_code><xsl:value-of select="product_code"/></child_product_code>
							<child_ref_id><xsl:value-of select="ref_id"/></child_ref_id>
							<child_tnx_id></child_tnx_id>
							<type_code>01</type_code>
						</cross_reference>
				</xsl:if>				
				<xsl:if test="prod_stat_code[.='31' or .='81']">
						<cross_reference>
							<brch_code><xsl:value-of select="brch_code"/></brch_code>
							<!-- Ref_id and tnx_id are retrieved by the ReferencesManager and passed in incoming.xsl-->
							<cross_reference_id></cross_reference_id>
							<product_code><xsl:value-of select="product_code"/></product_code>
							<child_product_code><xsl:value-of select="product_code"/></child_product_code>
							<child_ref_id>
								<xsl:choose>
									<xsl:when test="not(ref_id) or ref_id=''"><xsl:value-of select="service:retrieveRefIdFromBoRefId(bo_ref_id, product_code, '', '')"/></xsl:when>
									<xsl:otherwise><xsl:value-of select="ref_id"/></xsl:otherwise>
								</xsl:choose>
							</child_ref_id>
							<child_tnx_id></child_tnx_id>
							<type_code>01</type_code>
						</cross_reference>
				</xsl:if>
				<!--START Fix from Portal for MPS-28727-->
				<xsl:if test="prod_stat_code[.='04'] and sub_tnx_type_code[.='78'] and product_code [.='IN']">
					 <cross_reference>
							<brch_code><xsl:value-of select="brch_code"/></brch_code>
							<cross_reference_id></cross_reference_id>
							<product_code><xsl:value-of select="product_code"/></product_code>
							<child_product_code><xsl:value-of select="product_code"/></child_product_code>
							<child_ref_id><xsl:value-of select="ref_id"/></child_ref_id>
							<child_tnx_id></child_tnx_id>
							<type_code>01</type_code>
					 </cross_reference>
				</xsl:if>
				<!--END Fix from Portal for MPS-28727-->
				<xsl:if test="prod_stat_code[.='98'] and product_code[.='LC' or .='TF' or .='BG' or .='SI']">
					<cross_reference>
						<brch_code><xsl:value-of select="brch_code"/></brch_code>
						<ref_id><xsl:value-of select="ref_id"/></ref_id>
						<tnx_id><xsl:value-of select="tnx_id"/></tnx_id>
						<cross_reference_id></cross_reference_id>
						<product_code><xsl:value-of select="product_code"/></product_code>
						<child_product_code><xsl:value-of select="product_code"/></child_product_code>
						<child_ref_id><xsl:value-of select="ref_id"/></child_ref_id>
						<child_tnx_id></child_tnx_id>
						<type_code>01</type_code>
					</cross_reference>
				</xsl:if>
				
				<!-- MPS-41196 Creating Cross Reference tag based on parent_bo_tnx_id -->
				<xsl:if test="prod_stat_code[.='08' or .='06'] and tnx_type_code[.='03' or .='15'] and parent_bo_tnx_id[.!='']">
					<xsl:variable name="ref_id">
						<xsl:choose>
							<xsl:when test="not(ref_id) or ref_id=''"><xsl:value-of select="service:retrieveRefIdFromBoRefId(bo_ref_id, product_code, '', '')"/></xsl:when>
							<xsl:otherwise><xsl:value-of select="ref_id"/></xsl:otherwise>
				    	</xsl:choose>
					</xsl:variable>
						<cross_reference>
							<brch_code><xsl:value-of select="brch_code"/></brch_code>
							<!-- Ref_id and tnx_id are retrieved by the ReferencesManager and passed in incoming.xsl-->
							<cross_reference_id></cross_reference_id>
							<product_code><xsl:value-of select="product_code"/></product_code>
							<child_product_code><xsl:value-of select="product_code"/></child_product_code>
							<ref_id><xsl:value-of select="$ref_id"/>
							</ref_id>
							<child_ref_id><xsl:value-of select="$ref_id"/></child_ref_id>
							<tnx_id></tnx_id>
							<child_tnx_id>
								<xsl:choose>
									<xsl:when test="not(tnx_id) or tnx_id=''"><xsl:value-of select="service:retrieveTnxIdFromBoTnxId($ref_id, parent_bo_tnx_id, product_code, '', '')"/></xsl:when>
									<xsl:otherwise><xsl:value-of select="tnx_id"/></xsl:otherwise>
								</xsl:choose>
							</child_tnx_id>
							<type_code>01</type_code>
						</cross_reference>
				</xsl:if>
				
			</cross_references>
		</xsl:if>
	</xsl:template>
	
</xsl:stylesheet>