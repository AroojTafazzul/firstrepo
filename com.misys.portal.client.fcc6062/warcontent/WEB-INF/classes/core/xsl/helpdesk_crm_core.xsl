<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
	exclude-result-prefixes="localization">

	<!-- Global Parameters. These are used in the imported XSL, and to set global 
		params in the JS -->
	<xsl:param name="rundata" />
	<xsl:param name="contextPath" />
	<xsl:param name="servletPath" />
	<xsl:param name="language" />

	<xsl:output method="html" version="4.01" indent="no"
		encoding="UTF-8" omit-xml-declaration="yes" />

	<xsl:template match="/">
		<xsl:apply-templates select="rootNode" />
	</xsl:template>

	<xsl:template match="rootNode">
		<div>
			<div>
				<xsl:choose>
					<xsl:when test="count(//entity) = 1">
						<xsl:variable name="mailId">
							<xsl:value-of select="entities/entity/entity_email"></xsl:value-of>
						</xsl:variable>
						<div>
							<a>
								<xsl:attribute name="href">mailto:<xsl:value-of
									select="$mailId" /></xsl:attribute>
								<xsl:value-of
									select="localization:getGTPString($language, 'CONTACT_CRM')"></xsl:value-of>
							</a>
							<br></br>
						</div>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="entities/entity/entity_email [.!='']">
							<div class="HelpdeskCrmDiv">
								<a class="HelpdeskCrmAlink"
									onclick="fncShowDialog('UserToolsDialogContainer1','UserToolsDialog1','UserToolsDialogContent1','cancelButton1');">
									<xsl:value-of
										select="localization:getGTPString($language, 'CONTACT_CRM')"></xsl:value-of>
								</a>
							</div>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="count(//bank) = 1">
						<xsl:variable name="bankMailId">
							<xsl:value-of select="banks/bank/bank_email"></xsl:value-of>
						</xsl:variable>
						<div>
							<a>
								<xsl:attribute name="href">mailto:<xsl:value-of
									select="$bankMailId" /></xsl:attribute>
								<xsl:value-of
									select="localization:getGTPString($language, 'CONTACT_HELP_DESK')"></xsl:value-of>
							</a>
							<br></br>
						</div>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="banks/bank/bank_email [.!='']">
							<div class="HelpdeskCrmDiv">
								<a class="HelpdeskCrmAlink"
									onclick="fncShowDialog('UserToolsDialogContainer2','UserToolsDialog2','UserToolsDialogContent2','cancelButton2');">
									<xsl:value-of
										select="localization:getGTPString($language, 'CONTACT_HELP_DESK')"></xsl:value-of>
								</a>
							</div>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
			</div>
			<div class="hide" id="UserToolsDialogContainer1">
				<div dojoType="misys.widget.Dialog" id="UserToolsDialog1" class="HelpdeskCrm">
					<div id="UserToolsDialogContent1">
						<div id="UserToolsHeadingId1" class="HelpdeskCrmHeadingId">
							<xsl:value-of
								select="localization:getGTPString($language, 'EMAIL_MESSAGE_FOR_CRM')"></xsl:value-of>
						</div>

						<xsl:for-each select="entities/entity">
							<div id="UserToolsContentId1" class="HelpdeskCrmDiv">
								<a class="HelpdeskCrmAlink" onClick="dijit.byId('UserToolsDialog1').hide();">
									<xsl:attribute name="href">mailto:<xsl:value-of
										select="entity_email" /></xsl:attribute>
									<xsl:value-of select="entity_name" />
								</a>
							</div>
						</xsl:for-each>

						<div id="dialogButtons1" class="HelpdeskCrmsDiv">
							<button dojoType="dijit.form.Button" id="cancelButton1"
								onmouseup="dijit.byId('UserToolsDialog1').hide();">
								<xsl:value-of select="localization:getGTPString($language, 'CANCEL')" />
							</button>
						</div>
					</div>
				</div>
			</div>

			<div class="hide" id="UserToolsDialogContainer2">
				<div dojoType="misys.widget.Dialog" id="UserToolsDialog2" class="HelpdeskCrm">
					<div id="UserToolsDialogContent2">

						<div id="UserToolsHeadingId2" class="HelpdeskCrmHeadingId">
							<xsl:value-of
								select="localization:getGTPString($language, 'EMAIL_MESSAGE_FOR_HELPDESK')"></xsl:value-of>
						</div>

						<xsl:for-each select="banks/bank">
							<div id="UserToolsContentId2" class="HelpdeskCrmDiv">
								<a class="UserToolsAlink" onClick="dijit.byId('UserToolsDialog2').hide();">
									<xsl:attribute name="href">mailto:<xsl:value-of
										select="bank_email" /></xsl:attribute>
									<xsl:value-of select="bank_name" />
								</a>
							</div>
						</xsl:for-each>

						<div id="dialogButtons2" class="HelpdeskCrmDiv">
							<button dojoType="dijit.form.Button" id="cancelButton2"
								onmouseup="dijit.byId('UserToolsDialog2').hide();">
								<xsl:value-of select="localization:getGTPString($language, 'CANCEL')" />
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script>
			dojo.ready(function(){
				dojo.require("misys.HelpdeskCrmBinding");
			});
  		</script>
	</xsl:template>
</xsl:stylesheet>