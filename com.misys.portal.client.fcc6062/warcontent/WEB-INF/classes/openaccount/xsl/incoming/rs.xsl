<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<!--
   Copyright (c) 2000-2006 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
			<!-- Individual Routing Summary -->
	<xsl:template match="routing_summaries/air_routing_summaries/rs_tnx_record | routing_summaries/sea_routing_summaries/rs_tnx_record | routing_summaries/rail_routing_summaries/rs_tnx_record | routing_summaries/road_routing_summaries/rs_tnx_record">
		<xsl:param name="linked_ref_id"/>
		<xsl:param name="linked_tnx_id"/>
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/>

		<com.misys.portal.openaccount.product.baseline.common.RoutingSummaryFile>
			<!-- Common Values -->
			<com.misys.portal.openaccount.product.baseline.common.RoutingSummary>
				<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
				<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
				<product_code>RS</product_code>
				
				<linked_ref_id><xsl:value-of select="$linked_ref_id"/></linked_ref_id>
				<linked_tnx_id><xsl:value-of select="$linked_tnx_id"/></linked_tnx_id>
				<brch_code><xsl:value-of select="$brchCode"/></brch_code>
				<company_id><xsl:value-of select="$companyId"/></company_id>
				<!-- <entity>
					<xsl:value-of select="//entity"/>
				</entity>
				<company_name>
					<xsl:value-of select="//company_name"/>
				</company_name> -->
				<routing_summary_type><xsl:value-of select="routing_summary_type"/></routing_summary_type>
				<xsl:if test="routing_summary_mode">
					<routing_summary_mode><xsl:value-of select="routing_summary_mode"/></routing_summary_mode>
				</xsl:if>
				<carrier_name>
				<xsl:choose>
					<xsl:when test="routing_summary_mode = '01'">
						<xsl:value-of select="air_carrier_name"/>
					</xsl:when>
					<xsl:when test="routing_summary_mode = '02'">
						<xsl:value-of select="sea_carrier_name"/>
					</xsl:when>
					<xsl:when test="routing_summary_mode = '03'">
						<xsl:value-of select="road_carrier_name"/>
					</xsl:when>
					<xsl:when test="routing_summary_mode = '04'">
						<xsl:value-of select="rail_carrier_name"/>
					</xsl:when>
				</xsl:choose>
				</carrier_name>
				<is_valid><xsl:value-of select="is_valid"/></is_valid>
			</com.misys.portal.openaccount.product.baseline.common.RoutingSummary>

			<!-- Routing Summary Details -->
			<xsl:if test="routing_summary_mode = '01'">
				<xsl:apply-templates select="departures/departure"/>
				<xsl:apply-templates select="destinations/destination"/>
			</xsl:if>
			<xsl:if test="routing_summary_mode = '02'">
				<xsl:apply-templates select="loading_ports/loading_port"/>
				<xsl:apply-templates select="discharge_ports/discharge_port"/>
			</xsl:if>
			<xsl:if test="routing_summary_mode = '03'">
				<xsl:apply-templates select="road_receipt_places/road_receipt_place"/>
				<xsl:apply-templates select="road_delivery_places/road_delivery_place"/>
			</xsl:if>
			<xsl:if test="routing_summary_mode = '04'">
				<xsl:apply-templates select="rail_receipt_places/rail_receipt_place"/>
				<xsl:apply-templates select="rail_delivery_places/rail_delivery_place"/>
			</xsl:if>
		</com.misys.portal.openaccount.product.baseline.common.RoutingSummaryFile>
	</xsl:template>
	
	<xsl:template match="departures/departure | destinations/destination | discharge_ports/discharge_port | loading_ports/loading_port | rail_delivery_places/rail_delivery_place | rail_receipt_places/rail_receipt_place | road_delivery_places/road_delivery_place | road_receipt_places/road_receipt_place">
		<xsl:call-template name="RS_DETAILS">
		</xsl:call-template>
	</xsl:template>

	<!-- Routing Summary Details -->
	<xsl:template name="RS_DETAILS">

		<com.misys.portal.openaccount.product.baseline.util.RoutingSummaryDetails>
			<xsl:attribute name="ref_id"><xsl:value-of select="ref_id"/></xsl:attribute>
			<xsl:attribute name="tnx_id"><xsl:value-of select="tnx_id"/></xsl:attribute>
			<xsl:attribute name="routing_summary_id"><xsl:value-of select="routing_summary_id"/></xsl:attribute>
			<xsl:if test="routing_summary_sub_type">
				<routing_summary_sub_type>
					<xsl:value-of select="routing_summary_sub_type"/>
				</routing_summary_sub_type>
			</xsl:if>
			<xsl:choose>
				<!-- Air Departures -->
				<xsl:when test="routing_summary_sub_type = '01'">
					<xsl:if test="departure_airport_code">
						<airport_code>
							<xsl:value-of select="departure_airport_code"/>
						</airport_code>
					</xsl:if>
					<xsl:if test="departure_airport_name">
						<airport_name>
							<xsl:value-of select="departure_airport_name"/>
						</airport_name>
					</xsl:if>
					<xsl:if test="departure_air_town">
					<town>
						<xsl:value-of select="departure_air_town"/>
					</town>
					</xsl:if>
				</xsl:when>
				<!-- Air Departures -->
				<!-- Air Destinations -->
				<xsl:when test="routing_summary_sub_type = '02'">
					<xsl:if test="destination_airport_code">
						<airport_code>
							<xsl:value-of select="destination_airport_code"/>
						</airport_code>
					</xsl:if>
					<xsl:if test="destination_airport_name">
						<airport_name>
							<xsl:value-of select="destination_airport_name"/>
						</airport_name>
					</xsl:if>
					<xsl:if test="destination_air_town">
					<town>
						<xsl:value-of select="destination_air_town"/>
					</town>
					</xsl:if>
				</xsl:when>
				<!-- Air Destinations -->
				<!-- Sea Loading Ports-->
				<xsl:when test="routing_summary_sub_type = '03'">
					<xsl:if test="loading_port_name">
						<port_name>
							<xsl:value-of select="loading_port_name"/>
						</port_name>
					</xsl:if>
				</xsl:when>
				<!-- Sea Loading Ports-->
				<!-- Sea Discharge Ports-->
				<xsl:when test="routing_summary_sub_type = '04'">
					<xsl:if test="discharge_port_name">
						<port_name>
							<xsl:value-of select="discharge_port_name"/>
						</port_name>
					</xsl:if>
				</xsl:when>
				<!-- Sea Discharge Ports-->
				<!-- Road Receipt Place-->
				<xsl:when test="routing_summary_sub_type = '05'">
					<xsl:if test="road_receipt_place_name">
						<place_name>
							<xsl:value-of select="road_receipt_place_name"/>
						</place_name>
					</xsl:if>
				</xsl:when>
				<!-- Road Receipt Place-->
				<!-- Road Delivery Place-->
				<xsl:when test="routing_summary_sub_type = '06'">
					<xsl:if test="road_delivery_place_name">
						<place_name>
							<xsl:value-of select="road_delivery_place_name"/>
						</place_name>
					</xsl:if>
				</xsl:when>
				<!-- Road Delivery Place-->
				<!-- Rail Receipt Place-->
				<xsl:when test="routing_summary_sub_type = '07'">
					<xsl:if test="rail_receipt_place_name">
						<place_name>
							<xsl:value-of select="rail_receipt_place_name"/>
						</place_name>
					</xsl:if>
				</xsl:when>
				<!-- Rail Receipt Place-->
				<!-- Rail Delivery Place-->
				<xsl:when test="routing_summary_sub_type = '08'">
					<xsl:if test="rail_delivery_place_name">
						<place_name>
							<xsl:value-of select="rail_delivery_place_name"/>
						</place_name>
					</xsl:if>
				</xsl:when>
				<!-- Rail Delivery Place-->
			</xsl:choose>
			<xsl:if test="is_valid">
				<is_valid>
					<xsl:value-of select="is_valid"/>
				</is_valid>
			</xsl:if>
		</com.misys.portal.openaccount.product.baseline.util.RoutingSummaryDetails>
	</xsl:template>
	
	<!-- Multi modal Routing Summary -->
	<xsl:template name="multimodalRS">
		<xsl:param name="linked_ref_id"/>
		<xsl:param name="linked_tnx_id"/>
		<xsl:param name="brchCode"/>
		<xsl:param name="companyId"/> 
		<xsl:param name="place_of_final_destination"/>
		<xsl:param name="taking_in_charge"/>
		<com.misys.portal.openaccount.product.baseline.common.RoutingSummaryFile>
			<com.misys.portal.openaccount.product.baseline.common.RoutingSummary>
				<xsl:if test="product_code">
					<product_code>RS</product_code>
				</xsl:if>
				<linked_ref_id><xsl:value-of select="$linked_ref_id"/></linked_ref_id>
				<linked_tnx_id><xsl:value-of select="$linked_tnx_id"/></linked_tnx_id>
				<brch_code><xsl:value-of select="$brchCode"/></brch_code>
				<company_id><xsl:value-of select="$companyId"/></company_id>
				<routing_summary_type>02</routing_summary_type>
				<place_of_final_destination><xsl:value-of select="$place_of_final_destination"/></place_of_final_destination>
				<taking_in_charge><xsl:value-of select="$taking_in_charge"/></taking_in_charge>
				<is_valid>Y</is_valid>
			</com.misys.portal.openaccount.product.baseline.common.RoutingSummary>
			</com.misys.portal.openaccount.product.baseline.common.RoutingSummaryFile>
	</xsl:template> 
</xsl:stylesheet>
