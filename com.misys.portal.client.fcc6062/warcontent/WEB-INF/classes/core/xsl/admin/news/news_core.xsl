<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	
	<!-- Process News Item-->
	<xsl:template match="news_record">
		<result>
			<com.misys.portal.admin.news.common.NewsItem>
				<xsl:if test="item_id">
					<item_id>
						<xsl:value-of select="item_id"/>
					</item_id>
				</xsl:if>
				<xsl:if test="title">
					<title>
						<xsl:value-of select="title"/>
					</title>
				</xsl:if>
				<xsl:if test="link">
					<link>
						<xsl:value-of select="link"/>
					</link>
				</xsl:if>
				<xsl:if test="description">
					<description>
						<xsl:value-of select="description"/>
					</description>
				</xsl:if>
				<xsl:if test="topic_id">
					<topic_id>
						<xsl:value-of select="topic_id"/>
					</topic_id>
				</xsl:if>
				<xsl:if test="last_modified">
					<last_modified>
						<xsl:value-of select="last_modified"/>
					</last_modified>
				</xsl:if>
				<xsl:if test="start_display_date">
					<start_display_date>
						<xsl:value-of select="start_display_date"/>
					</start_display_date>
				</xsl:if>
				<xsl:if test="end_display_date">
					<end_display_date>
						<xsl:value-of select="end_display_date"/>
					</end_display_date>
				</xsl:if>
			</com.misys.portal.admin.news.common.NewsItem>
			
			<com.misys.portal.admin.news.common.NewsTopic>
				<xsl:if test="topic_id">
					<topic_id>
						<xsl:value-of select="topic_id"/>
					</topic_id>
				</xsl:if>			
				<xsl:if test="channel_id">
					<channel_id>
						<xsl:value-of select="channel_id"/>
					</channel_id>
				</xsl:if>
			</com.misys.portal.admin.news.common.NewsTopic>
		</result>
	</xsl:template>
</xsl:stylesheet>