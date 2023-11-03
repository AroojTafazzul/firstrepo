<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	
	<!-- Process News Item-->
	<xsl:template match="channel_record">
		<result>
			<com.misys.portal.admin.news.common.NewsChannel>
				<xsl:if test="channel_id">
					<channel_id>
						<xsl:value-of select="channel_id"/>
					</channel_id>
				</xsl:if>
				<xsl:if test="channel_name">
					<channel_name>
						<xsl:value-of select="channel_name"/>
					</channel_name>
				</xsl:if>
				<xsl:if test="description">
					<description>
						<xsl:value-of select="description"/>
					</description>
				</xsl:if>
				<xsl:if test="channel_type">
					<channel_type>
						<xsl:value-of select="channel_type"/>
					</channel_type>
				</xsl:if>
				<xsl:if test="company_id">
					<company_id>
						<xsl:value-of select="company_id"/>
					</company_id>
				</xsl:if>
				<xsl:if test="news_destination">
					<news_destination>
						<xsl:value-of select="news_destination"/>
					</news_destination>
				</xsl:if>
			</com.misys.portal.admin.news.common.NewsChannel>
			<!-- Create Topic elements -->
			<xsl:for-each select="//*[starts-with(name(), 'topic_id_')]">
				<xsl:variable name="position">
					<xsl:value-of select="substring-after(name(), 'topic_id_')"/>
				</xsl:variable>
				<xsl:call-template name="TOPIC">
					<xsl:with-param name="topicId"><xsl:value-of select="//*[starts-with(name(),concat('topic_id_', $position))]"/></xsl:with-param>
					<xsl:with-param name="channelId"><xsl:value-of select="/channel_record/channel_id"/></xsl:with-param>
					<xsl:with-param name="title"><xsl:value-of select="//*[starts-with(name(),concat('title_', $position))]"/></xsl:with-param>
					<xsl:with-param name="link"><xsl:value-of select="//*[starts-with(name(),concat('link_', $position))]"/></xsl:with-param>
					<xsl:with-param name="imgFileId"><xsl:value-of select="//*[starts-with(name(),concat('img_file_id_', $position))]"/></xsl:with-param>
				</xsl:call-template>
			</xsl:for-each>
		</result>
	</xsl:template>
	
	<xsl:template name="TOPIC">
		<xsl:param name="topicId"/>
		<xsl:param name="channelId"/>
		<xsl:param name="title"/>
		<xsl:param name="link"/>
		<xsl:param name="imgFileId"/>		
		
		<com.misys.portal.admin.news.common.NewsTopic>
			<xsl:if test="$topicId">
				<topic_id>
					<xsl:value-of select="$topicId"/>
				</topic_id>
			</xsl:if>
			<xsl:if test="$channelId">
				<channel_id>
					<xsl:value-of select="$channelId"/>
				</channel_id>
			</xsl:if>
			<xsl:if test="$title">
				<title>
					<xsl:value-of select="$title"/>
				</title>
			</xsl:if>
			<xsl:if test="$link">
				<link>
					<xsl:value-of select="$link"/>
				</link>
			</xsl:if>
			<xsl:if test="$imgFileId">
				<img_file_id>
					<xsl:value-of select="$imgFileId"/>
				</img_file_id>
			</xsl:if>
		</com.misys.portal.admin.news.common.NewsTopic>
	</xsl:template>
	
	
</xsl:stylesheet>