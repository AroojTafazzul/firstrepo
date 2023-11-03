<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="text"/>

	<xsl:param name="tnx.start.command"/>
	<xsl:param name="tnx.end.command"/>

	<xsl:template match="/">
		<xsl:if test="$tnx.start.command != ''">
<xsl:value-of select="$tnx.start.command"/><xsl:text>&#10;</xsl:text>
		</xsl:if>
		<xsl:apply-templates select="root/dataset"/>
		<xsl:if test="$tnx.end.command != ''">
<xsl:text>&#10;</xsl:text><xsl:value-of select="$tnx.end.command"/>
		</xsl:if>	
	</xsl:template>
 
	<xsl:template match="dataset">
		<xsl:apply-templates select="gtp_permission"/>
		<xsl:apply-templates select="gtp_role"/>
		<xsl:apply-templates select="gtp_role_permission"/>
		<xsl:apply-templates select="gtp_company"/>		
		<xsl:apply-templates select="gtp_customer_bank"/>
		<xsl:apply-templates select="gtp_user"/>
		<xsl:apply-templates select="gtp_group"/>
		<xsl:apply-templates select="gtp_user_group_role"/>
		<xsl:apply-templates select="gtp_company_role"/>
		<xsl:apply-templates select="gtp_bank_currency"/>
		<xsl:apply-templates select="gtp_code_data"/>
		<xsl:apply-templates select="gtp_master_currency"/>
		<xsl:apply-templates select="gtp_xch_rates"/>
		<xsl:apply-templates select="gtp_scheduled_job"/>
		<xsl:apply-templates select="gtp_id_table"/>
		<xsl:apply-templates select="gtp_bank_data"/>
	</xsl:template>
	
	<xsl:template match="gtp_permission">
		<xsl:variable name="permission_id" select="permission_id"/>
		<xsl:if test="count(//exclude/permission_id[.=$permission_id])=0">
			<xsl:text>INSERT INTO </xsl:text>
			<xsl:value-of select="name()"/>
			<!-- Columns -->
			<xsl:text> (</xsl:text>
			<xsl:for-each select="*">
				<xsl:value-of select="name()"/>
				<xsl:if test="position() != last()">
					<xsl:text>, </xsl:text>
				</xsl:if>
			</xsl:for-each>
			<xsl:text>) VALUES (</xsl:text>
			<!-- Values -->
			<xsl:for-each select="*">
				<xsl:value-of select="."/>
				<xsl:if test="position() != last()">
					<xsl:text>, </xsl:text>
				</xsl:if>
			</xsl:for-each>
			<xsl:text>);
</xsl:text>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="gtp_role | gtp_company_role">
		<xsl:variable name="role_id" select="role_id"/>
		<xsl:if test="count(//exclude/role_id[.=$role_id])=0">
			<xsl:text>INSERT INTO </xsl:text>
			<xsl:value-of select="name()"/>
			<!-- Columns -->
			<xsl:text> (</xsl:text>
			<xsl:for-each select="*">
				<xsl:value-of select="name()"/>
				<xsl:if test="position() != last()">
					<xsl:text>, </xsl:text>
				</xsl:if>
			</xsl:for-each>
			<xsl:text>) VALUES (</xsl:text>
			<!-- Values -->
			<xsl:for-each select="*">
				<xsl:value-of select="."/>
				<xsl:if test="position() != last()">
					<xsl:text>, </xsl:text>
				</xsl:if>
			</xsl:for-each>
			<xsl:text>);
</xsl:text>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="gtp_role_permission">
		<xsl:variable name="role_id" select="role_id"/>
		<xsl:variable name="permission_id" select="permission_id"/>
		<xsl:if test="count(//exclude/role_id[.=$role_id])=0 and count(//exclude/permission_id[.=$permission_id])=0">
			<xsl:text>INSERT INTO </xsl:text>
			<xsl:value-of select="name()"/>
			<!-- Columns -->
			<xsl:text> (</xsl:text>
			<xsl:for-each select="*">
				<xsl:value-of select="name()"/>
				<xsl:if test="position() != last()">
					<xsl:text>, </xsl:text>
				</xsl:if>
			</xsl:for-each>
			<xsl:text>) VALUES (</xsl:text>
			<!-- Values -->
			<xsl:for-each select="*">
				<xsl:value-of select="."/>
				<xsl:if test="position() != last()">
					<xsl:text>, </xsl:text>
				</xsl:if>
			</xsl:for-each>
			<xsl:text>);</xsl:text>
			<xsl:text>
</xsl:text>
		</xsl:if>
	</xsl:template>

	<xsl:template match="gtp_customer_bank | gtp_user | gtp_group | gtp_user_group_role | gtp_company | gtp_bank_currency | gtp_code_data | gtp_master_currency | gtp_xch_rates | gtp_scheduled_job | gtp_id_table | gtp_bank_data">
			<xsl:text>INSERT INTO </xsl:text>
			<xsl:value-of select="name()"/>
			<!-- Columns -->
			<xsl:text> (</xsl:text>
			<xsl:for-each select="*">
				<xsl:value-of select="name()"/>
				<xsl:if test="position() != last()">
					<xsl:text>, </xsl:text>
				</xsl:if>
			</xsl:for-each>
			<xsl:text>) VALUES (</xsl:text>
			<!-- Values -->
			<xsl:for-each select="*">
				<xsl:value-of select="."/>
				<xsl:if test="position() != last()">
					<xsl:text>, </xsl:text>
				</xsl:if>
			</xsl:for-each>
			<xsl:text>);
</xsl:text>
	</xsl:template>		
</xsl:stylesheet>