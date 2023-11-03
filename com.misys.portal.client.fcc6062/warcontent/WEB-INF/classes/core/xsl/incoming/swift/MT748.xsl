<?xml version="1.0"?>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"	
		xmlns:service="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"	
		exclude-result-prefixes="localization service defaultresource">
	<!--
		Copyright (c) 2000-2012 Misys (http://www.misys.com),
   		All Rights Reserved. 
	-->
	<!-- Transform Advice of discrepancy (B2C) MT798<748> into lc_tnx_record -->
	<!-- Same behaviour as MT798<748,750> -->

	<!-- Import common functions -->
	<xsl:import href="MT750_748.xsl"/>

</xsl:stylesheet>
