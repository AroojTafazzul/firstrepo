<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html"/>

	<xsl:variable name="apos">'</xsl:variable>

  	<xsl:template match="/">
  		<html>
  		<head>
			<style type="text/css">
		  	body { font-family: Helvetica, Geneva, Arial, SunSans-Regular, sans-serif; font-size: 0.813em; }
		    ul { font-weight: bold; list-style-type: none; color: #900; }
		    ul span {font-weight: normal; color: #666; padding-left: 0.5em; }
		    li { font-weight: normal; list-style-type: none; padding-left: 2em; color: black; }
			</style>
  		</head>
		<body>  
			<xsl:apply-templates select="root/dataset/gtp_role"/>
  		</body>
  		</html>
 	</xsl:template>
 
	<xsl:template match="gtp_role">
		<xsl:variable name="role_id" select="role_id"/>
		<ul>
			<xsl:value-of select="translate(ROLENAME, $apos, '')"/> <span><xsl:value-of select="$role_id"/></span>
			<xsl:apply-templates select="//gtp_role_permission[role_id=$role_id]"/>
		</ul>
	</xsl:template>

	<xsl:template match="gtp_role_permission">
		<xsl:variable name="permission_id" select="permission_id"/>
		<li><xsl:value-of select="translate(//gtp_permission[permission_id=$permission_id]/PERMISSION, $apos, '')"/> <span><xsl:value-of select="$permission_id"/></span></li>
	</xsl:template>

</xsl:stylesheet>