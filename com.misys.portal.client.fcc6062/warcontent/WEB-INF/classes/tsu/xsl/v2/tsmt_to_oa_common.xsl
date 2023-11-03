<?xml version="1.0"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<!--
   Copyright (c) 2000-2006 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->

	<xsl:template match="Buyr">
		<xsl:if test="Nm  != ''">
			<buyer_abbv_name>
				<xsl:value-of select="Nm"/>
			</buyer_abbv_name>
			<buyer_name>
				<xsl:value-of select="Nm"/>
			</buyer_name>
		</xsl:if>
		<xsl:if test="PrtryId/Id  != ''">
			<buyer_proprietary_id>
				<xsl:value-of select="PrtryId/Id"/>
			</buyer_proprietary_id>
		</xsl:if>
		<xsl:if test="PrtryId/IdTp  != ''">
			<buyer_proprietary_id_type>
				<xsl:value-of select="PrtryId/IdTp"/>
			</buyer_proprietary_id_type>
		</xsl:if>
		<xsl:if test="//BuyrBk/BIC">
				<buyer_bank_bic><xsl:value-of select="//BuyrBk/BIC"/></buyer_bank_bic>
		</xsl:if>
		<xsl:if test="PstlAdr/StrtNm  != ''">
			<buyer_street_name>
				<xsl:value-of select="PstlAdr/StrtNm"/>
			</buyer_street_name>
		</xsl:if>
		<xsl:if test="PstlAdr/PstCdId  != ''">
			<buyer_post_code>
				<xsl:value-of select="PstlAdr/PstCdId"/>
			</buyer_post_code>
		</xsl:if>
		<xsl:if test="PstlAdr/TwnNm  != ''">
			<buyer_town_name>
				<xsl:value-of select="PstlAdr/TwnNm"/>
			</buyer_town_name>
		</xsl:if>
		<xsl:if test="PstlAdr/CtrySubDvsn  != ''">
			<buyer_country_sub_div>
				<xsl:value-of select="PstlAdr/CtrySubDvsn"/>
			</buyer_country_sub_div>
		</xsl:if>
		<xsl:if test="PstlAdr/Ctry  != ''">
			<buyer_country>
				<xsl:value-of select="PstlAdr/Ctry"/>
			</buyer_country>
		</xsl:if>
	</xsl:template>
	<!-- Seller Details -->
	<xsl:template match="Sellr">
		<xsl:if test="Nm  != ''">
			<seller_abbv_name>
				<xsl:value-of select="Nm"/>
			</seller_abbv_name>
			<seller_name>
				<xsl:value-of select="Nm"/>
			</seller_name>
		</xsl:if>
		<xsl:if test="PrtryId/Id  != ''">
			<seller_proprietary_id>
				<xsl:value-of select="PrtryId/Id"/>
			</seller_proprietary_id>
		</xsl:if>
		<xsl:if test="PrtryId/IdTp  != ''">
			<seller_proprietary_id_type>
				<xsl:value-of select="PrtryId/IdTp"/>
			</seller_proprietary_id_type>
		</xsl:if>
		<xsl:if test="//SellrBk/BIC">
			<seller_bank_bic><xsl:value-of select="//SellrBk/BIC"/></seller_bank_bic>
		</xsl:if>
		<xsl:if test="PstlAdr/StrtNm  != ''">
			<seller_street_name>
				<xsl:value-of select="PstlAdr/StrtNm"/>
			</seller_street_name>
		</xsl:if>
		<xsl:if test="PstlAdr/PstCdId  != ''">
			<seller_post_code>
				<xsl:value-of select="PstlAdr/PstCdId"/>
			</seller_post_code>
		</xsl:if>
		<xsl:if test="PstlAdr/TwnNm  != ''">
			<seller_town_name>
				<xsl:value-of select="PstlAdr/TwnNm"/>
			</seller_town_name>
		</xsl:if>
		<xsl:if test="PstlAdr/CtrySubDvsn  != ''">
			<seller_country_sub_div>
				<xsl:value-of select="PstlAdr/CtrySubDvsn"/>
			</seller_country_sub_div>
		</xsl:if>
		<xsl:if test="PstlAdr/Ctry  != ''">
			<seller_country>
				<xsl:value-of select="PstlAdr/Ctry"/>
			</seller_country>
		</xsl:if>
	</xsl:template>
	
	<!-- Bill To Details -->
	<xsl:template match="BllTo">
		<xsl:if test="Nm  != ''">
			<bill_to_abbv_name>
				<xsl:value-of select="Nm"/>
			</bill_to_abbv_name>
			<bill_to_name>
				<xsl:value-of select="Nm"/>
			</bill_to_name>
		</xsl:if>
		<xsl:if test="PrtryId/Id  != ''">
			<proprietary_id>
				<xsl:value-of select="PrtryId/Id"/>
			</proprietary_id>
		</xsl:if>
		<xsl:if test="PrtryId/IdTp  != ''">
			<proprietary_id_type>
				<xsl:value-of select="PrtryId/IdTp"/>
			</proprietary_id_type>
		</xsl:if>
		<xsl:if test="PstlAdr/StrtNm  != ''">
			<bill_to_street_name>
				<xsl:value-of select="PstlAdr/StrtNm"/>
			</bill_to_street_name>
		</xsl:if>
		<xsl:if test="PstlAdr/TwnNm  != ''">
			<bill_to_town_name>
				<xsl:value-of select="PstlAdr/TwnNm"/>
			</bill_to_town_name>
		</xsl:if>
		<xsl:if test="PstlAdr/CtrySubDvsn  != ''">
			<bill_to_country_sub_div>
				<xsl:value-of select="PstlAdr/CtrySubDvsn"/>
			</bill_to_country_sub_div>
		</xsl:if>
		<xsl:if test="PstlAdr/PstCdId  != ''">
			<bill_to_post_code>
				<xsl:value-of select="PstlAdr/PstCdId"/>
			</bill_to_post_code>
		</xsl:if>
		<xsl:if test="PstlAdr/Ctry  != ''">
			<bill_to_country>
				<xsl:value-of select="PstlAdr/Ctry"/>
			</bill_to_country>
		</xsl:if>
	</xsl:template>
	
	<!-- Ship To Details -->
	<xsl:template match="ShipTo">
		<xsl:if test="Nm  != ''">
			<ship_to_abbv_name>
				<xsl:value-of select="Nm"/>
			</ship_to_abbv_name>
			<ship_to_name>
				<xsl:value-of select="Nm"/>
			</ship_to_name>
		</xsl:if>
		<xsl:if test="PrtryId/Id  != ''">
			<proprietary_id>
				<xsl:value-of select="PrtryId/Id"/>
			</proprietary_id>
		</xsl:if>
		<xsl:if test="PrtryId/IdTp  != ''">
			<proprietary_id_type>
				<xsl:value-of select="PrtryId/IdTp"/>
			</proprietary_id_type>
		</xsl:if>
		<xsl:if test="PstlAdr/StrtNm  != ''">
			<ship_to_street_name>
				<xsl:value-of select="PstlAdr/StrtNm"/>
			</ship_to_street_name>
		</xsl:if>
		<xsl:if test="PstlAdr/TwnNm  != ''">
			<ship_to_town_name>
				<xsl:value-of select="PstlAdr/TwnNm"/>
			</ship_to_town_name>
		</xsl:if>
		<xsl:if test="PstlAdr/CtrySubDvsn  != ''">
			<ship_to_country_sub_div>
				<xsl:value-of select="PstlAdr/CtrySubDvsn"/>
			</ship_to_country_sub_div>
		</xsl:if>
		<xsl:if test="PstlAdr/PstCdId  != ''">
			<ship_to_post_code>
				<xsl:value-of select="PstlAdr/PstCdId"/>
			</ship_to_post_code>
		</xsl:if>
		<xsl:if test="PstlAdr/Ctry  != ''">
			<ship_to_country>
				<xsl:value-of select="PstlAdr/Ctry"/>
			</ship_to_country>
		</xsl:if>
	</xsl:template>
	
	<!-- Consigne Details -->
	<xsl:template match="Consgn">
		<xsl:if test="Nm  != ''">
			<consgn_abbv_name>
				<xsl:value-of select="Nm"/>
			</consgn_abbv_name>
			<consgn_name>
				<xsl:value-of select="Nm"/>
			</consgn_name>
		</xsl:if>
		<xsl:if test="PrtryId/Id  != ''">
			<proprietary_id>
				<xsl:value-of select="PrtryId/Id"/>
			</proprietary_id>
		</xsl:if>
		<xsl:if test="PrtryId/IdTp  != ''">
			<proprietary_id_type>
				<xsl:value-of select="PrtryId/IdTp"/>
			</proprietary_id_type>
		</xsl:if>
		<xsl:if test="PstlAdr/StrtNm  != ''">
			<consgn_street_name>
				<xsl:value-of select="PstlAdr/StrtNm"/>
			</consgn_street_name>
		</xsl:if>
		<xsl:if test="PstlAdr/TwnNm  != ''">
			<consgn_town_name>
				<xsl:value-of select="PstlAdr/TwnNm"/>
			</consgn_town_name>
		</xsl:if>
		<xsl:if test="PstlAdr/CtrySubDvsn  != ''">
			<consgn_country_sub_div>
				<xsl:value-of select="PstlAdr/CtrySubDvsn"/>
			</consgn_country_sub_div>
		</xsl:if>
		<xsl:if test="PstlAdr/PstCdId  != ''">
			<consgn_post_code>
				<xsl:value-of select="PstlAdr/PstCdId"/>
			</consgn_post_code>
		</xsl:if>
		<xsl:if test="PstlAdr/Ctry  != ''">
			<consgn_country>
				<xsl:value-of select="PstlAdr/Ctry"/>
			</consgn_country>
		</xsl:if>
	</xsl:template>
	
	<!-- Goods Details - Line Items, Adjustments, Taxes, Incoterms etc -->
	<xsl:template match="Goods">
		<xsl:if test="GoodsDesc  != ''">
			<goods_desc>
				<xsl:value-of select="GoodsDesc"/>
			</goods_desc>
			</xsl:if>
			<xsl:if test="ShipmntDtRg/LatstShipmntDt  != ''">
			<last_ship_date>
				<xsl:value-of select="ShipmntDtRg/LatstShipmntDt"/>
			</last_ship_date>
			</xsl:if>
			<xsl:if test="ShipmntDtRg/EarlstShipmntDt  != ''">
				<earliest_ship_date>
					<xsl:value-of select="ShipmntDtRg/EarlstShipmntDt"/>
				</earliest_ship_date>
			</xsl:if>
			<xsl:if test="PrtlShipmnt  != ''">
			<part_ship>
			    <xsl:choose>
			    		<xsl:when test="PrtlShipmnt[.='true']">Y</xsl:when>
			    		<xsl:otherwise>N</xsl:otherwise>
			    </xsl:choose>
			</part_ship>
			</xsl:if>
			<xsl:if test="TrnsShipmnt  != ''">
			<tran_ship>
				 <xsl:choose>
			    		<xsl:when test="TrnsShipmnt[.='true']">Y</xsl:when>
			    		<xsl:otherwise>N</xsl:otherwise>
			    </xsl:choose>
			</tran_ship>
			</xsl:if>
			<xsl:if test="LineItmsTtlAmt != ''">
				<total_amt>
					<xsl:value-of select="LineItmsTtlAmt"/>
				</total_amt>
				<total_cur_code>
					<xsl:value-of select="LineItmsTtlAmt/@Ccy"/>
				</total_cur_code>
			</xsl:if>
			<xsl:if test="TtlNetAmt != ''">
				<total_net_amt>
					<xsl:value-of select="TtlNetAmt"/>
				</total_net_amt>
				<total_net_cur_code>
					<xsl:value-of select="TtlNetAmt/@Ccy"/>
				</total_net_cur_code>
				<tnx_amt>
					<xsl:value-of select="TtlNetAmt"/>
				</tnx_amt>
				<tnx_cur_code>
					<xsl:value-of select="TtlNetAmt/@Ccy"/>
				</tnx_cur_code>
			</xsl:if>
			<xsl:if test="LineItmDtls  != ''">
				<lineItems>
					<xsl:apply-templates select="LineItmDtls"/>
			   	</lineItems>
			</xsl:if>
			<xsl:if test="RtgSummry/IndvTrnsprt != ''">
 	   			<xsl:apply-templates select="RtgSummry/IndvTrnsprt"/>		 
		    </xsl:if>
		    <xsl:if test="RtgSummry/MltmdlTrnsprt!=''">
				<xsl:if test="RtgSummry/MltmdlTrnsprt/TakngInChrg != ''">
					<taking_in_charge>
						<xsl:value-of select="RtgSummry/MltmdlTrnsprt/TakngInChrg"/>
					</taking_in_charge>
				</xsl:if>
				<xsl:if test="RtgSummry/MltmdlTrnsprt/PlcOfFnlDstn != ''">
					<final_dest_place>
						<xsl:value-of select="RtgSummry/MltmdlTrnsprt/PlcOfFnlDstn"/>
					</final_dest_place>
				</xsl:if>
		    </xsl:if>
		   	
			<xsl:if test="FrghtChrgs  != ''">
				<xsl:if test="FrghtChrgs/Tp  != ''">
					<freight_charges_type>
						<xsl:value-of select="FrghtChrgs/Tp"/>
					</freight_charges_type>
				</xsl:if>
				<xsl:if test="FrghtChrgs/Chrgs">
					<freightCharges>
						<xsl:apply-templates select="FrghtChrgs/Chrgs"/>
					</freightCharges>
				</xsl:if>
			</xsl:if>
			<xsl:if test="Tax  != ''">
				<taxes>
					<xsl:apply-templates select="Tax"/>
				</taxes>
			</xsl:if>
			<xsl:if test="Incotrms  != ''">
			<incoterms>
				<xsl:apply-templates select="Incotrms"/>
			</incoterms>
			</xsl:if>
			<xsl:if test="Adjstmnt  != ''">
				<adjustments>
					<xsl:apply-templates select="Adjstmnt"/>
		  		</adjustments>
		  	</xsl:if>
		  	<xsl:if test="BuyrDfndInf  != ''">
			  <buyer_defined_informations>
			  		<xsl:apply-templates select="BuyrDfndInf"/>
			  </buyer_defined_informations>
		  	</xsl:if>
			  <xsl:if test="SellrDfndInf  != ''">
				  <seller_defined_informations>
				  		<xsl:apply-templates select="SellrDfndInf"/>
				  </seller_defined_informations>
			  </xsl:if>
	</xsl:template>
	
	<!-- Payment Terms -->
	<xsl:template match="PmtTerms">
		<payment>
			<xsl:choose>
				<xsl:when test="OthrPmtTerms!=''">
					<other_paymt_terms>
						<xsl:value-of select="OthrPmtTerms"/>
					</other_paymt_terms>
				</xsl:when>
				 <xsl:otherwise>
					<xsl:if test="PmtCd/Cd  != ''">
						<code>
							 <xsl:value-of select="PmtCd/Cd"/>
						</code>
					</xsl:if>
					<xsl:if test="PmtCd/NbOfDays  != ''">
						<nb_days>
							<xsl:value-of select="PmtCd/NbOfDays"/>
						</nb_days>
					</xsl:if>
				 </xsl:otherwise>
		      </xsl:choose>
		      <xsl:choose>
			   <xsl:when test="Pctg  != ''">
				 <pct>
					<xsl:value-of select="Pctg"/>
				 </pct>
			   </xsl:when>
			  <xsl:otherwise>
				<xsl:if test="Amt/@Ccy  != ''">
					<cur_code>
						<xsl:value-of select="Amt/@Ccy"/>
					</cur_code>
				</xsl:if>
				<xsl:if test="Amt  != ''">
					<amt>
						<xsl:value-of select="Amt"/>
					</amt>
				</xsl:if>
			</xsl:otherwise>
		   </xsl:choose>
			<is_valid>Y</is_valid>
		</payment>
	</xsl:template>
	
	<!-- Settlement Terms -->
	<xsl:template match="SttlmTerms">
		<xsl:choose>
			<xsl:when test="CdtrAcct/Id/IBAN != ''">
				<seller_account_iban><xsl:value-of select="CdtrAcct/Id/IBAN"/></seller_account_iban>
			</xsl:when>
			<xsl:when test="CdtrAcct/Id/BBAN != ''">
				<seller_account_bban><xsl:value-of select="CdtrAcct/Id/BBAN"/></seller_account_bban>
			</xsl:when>
			<xsl:when test="CdtrAcct/Id/UPIC != ''">
				<seller_account_upic><xsl:value-of select="CdtrAcct/Id/UPIC"/></seller_account_upic>
			</xsl:when>
			<xsl:when test="CdtrAcct/Id/PrtryAcct != ''">
				<seller_account_id><xsl:value-of select="CdtrAcct/Id/PrtryAcct/Id"/></seller_account_id>
			</xsl:when>
		</xsl:choose>
		<xsl:if test="CdtrAcct/Tp/Cd != ''">
			<seller_account_type_code><xsl:value-of select="CdtrAcct/Tp/Cd"/></seller_account_type_code>
		</xsl:if>
		<xsl:if test="CdtrAcct/Tp/Prtry != ''">
			<seller_account_type_prop><xsl:value-of select="CdtrAcct/Tp/Prtry"/></seller_account_type_prop>
		</xsl:if>
		
		<xsl:if test="CdtrAcct/Ccy != ''">
			<seller_account_cur_code><xsl:value-of select="CdtrAcct/Ccy"/></seller_account_cur_code>
		</xsl:if>
		<xsl:if test="CdtrAcct/Nm != ''">
			<seller_account_name><xsl:value-of select="CdtrAcct/Nm"/></seller_account_name>
		</xsl:if>
		
		<xsl:if test="CdtrAgt/BIC != ''">
			<fin_inst_bic><xsl:value-of select="CdtrAgt/BIC"/></fin_inst_bic>
		</xsl:if>
		<xsl:if test="CdtrAgt/NmAndAdr/Nm != ''">
			<fin_inst_name><xsl:value-of select="CdtrAgt/NmAndAdr/Nm"/></fin_inst_name>
		</xsl:if>
		
		<xsl:if test="CdtrAgt/NmAndAdr/Adr/StrtNm != ''">
			<fin_inst_street_name><xsl:value-of select="CdtrAgt/NmAndAdr/Adr/StrtNm"/></fin_inst_street_name>
		</xsl:if>
		<xsl:if test="CdtrAgt/NmAndAdr/Adr/PstCdId != ''">
			<fin_inst_post_code><xsl:value-of select="CdtrAgt/NmAndAdr/Adr/PstCdId"/></fin_inst_post_code>
		</xsl:if>
		<xsl:if test="CdtrAgt/NmAndAdr/Adr/TwnNm != ''">
			<fin_inst_town_name><xsl:value-of select="CdtrAgt/NmAndAdr/Adr/TwnNm"/></fin_inst_town_name>
		</xsl:if>
		
		<xsl:if test="CdtrAgt/NmAndAdr/Adr/CtrySubDvsn != ''">
			<fin_inst_country_sub_div><xsl:value-of select="CdtrAgt/NmAndAdr/Adr/CtrySubDvsn"/></fin_inst_country_sub_div>
		</xsl:if>
		<xsl:if test="CdtrAgt/NmAndAdr/Adr/Ctry != ''">
			<fin_inst_country><xsl:value-of select="CdtrAgt/NmAndAdr/Adr/Ctry"/></fin_inst_country>
		</xsl:if>
	</xsl:template>
  
  <!-- Product Characteristics -->
  <xsl:template match="PdctChrtcs">
		<productCharacteristic>
			<xsl:choose>
				<xsl:when test="StrdPdctChrtcs !=''">
					<xsl:if test="StrdPdctChrtcs/Tp  != ''">
					<type>
						<xsl:value-of select="StrdPdctChrtcs/Tp"/>
					</type>
					</xsl:if>
					<xsl:if test="StrdPdctChrtcs/Chrtcs  != ''">
						<description>
							<xsl:value-of select="StrdPdctChrtcs/Chrtcs"/>
						</description>
					</xsl:if>
				</xsl:when>
				<xsl:when test="OthrPdctChrtcs !=''">
					<type>OTHR</type>
					<xsl:if test="OthrPdctChrtcs/IdTp  != ''">
						<other_type>
							<xsl:value-of select="OthrPdctChrtcs/IdTp"/>
						</other_type>
					</xsl:if>
					<xsl:if test="OthrPdctChrtcs/Id  != ''">
						<description>
							<xsl:value-of select="OthrPdctChrtcs/Id"/>
						</description>
					</xsl:if>
				</xsl:when>
			</xsl:choose>
			<goods_type>03</goods_type>
			<is_valid>Y</is_valid>
		</productCharacteristic>
	</xsl:template>
	
	<!-- Product Identifiers -->
	<xsl:template match="PdctIdr">
		<productIdentifier>
			<xsl:choose>
				<xsl:when test="StrdPdctIdr !=''">
					<xsl:if test="StrdPdctIdr/Tp  != ''">
						<type>
							<xsl:value-of select="StrdPdctIdr/Tp"/>
						</type>
					</xsl:if>
					<xsl:if test="StrdPdctIdr/Idr  != ''">
						<description>
							<xsl:value-of select="StrdPdctIdr/Idr"/>
						</description>
					</xsl:if>
				</xsl:when>
				<xsl:when test="OthrPdctIdr !=''">
					<type>OTHR</type>
					<xsl:if test="OthrPdctIdr/IdTp  != ''">
						<other_type>
							<xsl:value-of select="OthrPdctIdr/IdTp"/>
						</other_type>
					</xsl:if>
					<xsl:if test="OthrPdctIdr/Id  != ''">
						<description>
							<xsl:value-of select="OthrPdctIdr/Id"/>
						</description>
					</xsl:if>
				</xsl:when>
			</xsl:choose>
			<goods_type>01</goods_type>
			<is_valid>Y</is_valid>
		</productIdentifier>
	</xsl:template>
	
	<!-- Product Category -->
	<xsl:template match="PdctCtgy">
		<productCategory>
			<xsl:choose>
				<xsl:when test="StrdPdctCtgy !=''">
					<xsl:if test="StrdPdctCtgy/Tp  != ''">
						<type>
							<xsl:value-of select="StrdPdctCtgy/Tp"/>
						</type>
					</xsl:if>
					<xsl:if test="StrdPdctCtgy/Ctgy  != ''">
						<description>
							<xsl:value-of select="StrdPdctCtgy/Ctgy"/>
						</description>
					</xsl:if>
				</xsl:when>
				<xsl:when test="OthrPdctCtgy != ''">
					<type>OTHR</type>
					<xsl:if test="OthrPdctCtgy/IdTp  != ''">
						<other_type>
							<xsl:value-of select="OthrPdctCtgy/IdTp"/>
						</other_type>
					</xsl:if>
					<xsl:if test="OthrPdctCtgy/Id  != ''">
						<description>
							<xsl:value-of select="OthrPdctCtgy/Id"/>
						</description>
					</xsl:if>
				</xsl:when>
			</xsl:choose>
			<goods_type>02</goods_type>
			<is_valid>Y</is_valid>
		</productCategory>
	</xsl:template>
	
	<!-- Shipment Sub-Schedule -->
	<xsl:template match="ShipmntSchdl/ShipmntSubSchdl" >
		<shipmentSchedule>
			<xsl:if test="SubQtyVal  != ''">
				<sub_shipment_quantity_value>
					<xsl:value-of select="SubQtyVal" />
				</sub_shipment_quantity_value>
			</xsl:if>
			<xsl:if test="LatstShipmntDt  != ''">
				<schedule_latest_ship_date>
					<xsl:value-of select="LatstShipmntDt" />
				</schedule_latest_ship_date>
			</xsl:if>
		
			<xsl:if test="EarlstShipmntDt  != ''">
				<schedule_earliest_ship_date>
					<xsl:value-of select="EarlstShipmntDt" />
				</schedule_earliest_ship_date>
			</xsl:if>
		</shipmentSchedule>
	</xsl:template>
	
	<!-- Freight Charges -->
	<xsl:template match="FrghtChrgs/Chrgs">
		<freightCharge>
			<xsl:if test="Tp  != ''">
				<type>
					<xsl:value-of select="Tp"/>
				</type>
			</xsl:if>
			<xsl:if test="OthrChrgsTp  != ''">
				<other_type>
					<xsl:value-of select="OthrChrgsTp"/>
				</other_type>
			</xsl:if>
			<xsl:if test="Amt/@Ccy  != ''">
				<cur_code>
					<xsl:value-of select="Amt/@Ccy"/>
				</cur_code>
			</xsl:if>
			<xsl:if test="Amt  != ''">
				<amt>
					<xsl:value-of select="Amt"/>
				</amt>
			</xsl:if>
			<xsl:if test="Rate  != ''">
				<rate>
					<xsl:value-of select="Rate"/>
				</rate>
			</xsl:if>
			<is_valid>Y</is_valid>
		</freightCharge>
	</xsl:template>
	
	<!-- Tax -->
	<xsl:template match="Tax">
		<tax>
			<xsl:if test="Tp  != ''">
				<type>
					<xsl:value-of select="Tp"/>
				</type>
			</xsl:if>
			<xsl:if test="OthrTaxTp  != ''">
				<other_type>
					<xsl:value-of select="OthrTaxTp"/>
				</other_type>
			</xsl:if>
			<xsl:if test="Amt/@Ccy  != ''">
				<cur_code>
					<xsl:value-of select="Amt/@Ccy"/>
				</cur_code>
			</xsl:if>
			<xsl:if test="Amt  != ''">
				<amt>
					<xsl:value-of select="Amt"/>
				</amt>
			</xsl:if>
			<xsl:if test="Rate  != ''">
				<rate>
					<xsl:value-of select="Rate"/>
				</rate>
			</xsl:if>
			<is_valid>Y</is_valid>
		</tax>
	</xsl:template>
	
	<!-- Incoterms -->
	<xsl:template match="Incotrms">
		<incoterm>
			<xsl:if test="Cd != ''">
			<code>
				<xsl:value-of select="Cd"/>
			</code>
			</xsl:if>
			<xsl:if test="Othr  != ''">
				<code>OTHR</code>
				 <other>
					<xsl:value-of select="Othr" />
				 </other>
			</xsl:if>
			<xsl:if test="Lctn != ''">
				<location>
					<xsl:value-of select="Lctn"/>
				</location>
			</xsl:if>			
			<is_valid>Y</is_valid>
		</incoterm>
	</xsl:template>
	
	<!-- Adjustment -->
	<xsl:template match="Adjstmnt">
		<adjustment>
			 <xsl:if test="Tp !=''">
				<type>
					<xsl:value-of select="Tp"/>
				</type>
			</xsl:if>
			 <xsl:if test="OthrAdjstmntTp !=''">
				<other_type>
					<xsl:value-of select="OthrAdjstmntTp"/>
				</other_type>
			</xsl:if>
			 <xsl:if test="Amt/@Ccy !=''">
				<cur_code>
					<xsl:value-of select="Amt/@Ccy"/>
				</cur_code>
			</xsl:if>
			 <xsl:if test="Amt !=''">
				<amt>
					<xsl:value-of select="Amt"/>
				</amt>
			</xsl:if>
			 <xsl:if test="Rate !=''">
				<rate>
					<xsl:value-of select="Rate"/>
				</rate>
			</xsl:if>
			<xsl:if test="Drctn  != ''">
					<direction>
						<xsl:value-of select="Drctn"/>
					</direction>
			</xsl:if>
			<is_valid>Y</is_valid>					
		</adjustment>
	</xsl:template>
	
	<!-- Line Items -->
	
	<xsl:template match="LineItmDtls | ComrclLineItms">
		<lineItem>
	   		<xsl:if test="LineItmId  != ''">
		   		<line_item_number>
		   		 	 <xsl:value-of select="LineItmId"/>
		   		</line_item_number>
	   		</xsl:if>
	   		<xsl:if test="Qty/UnitOfMeasrCd  != ''">
		   		<qty_unit_measr_code>
		   		 	<xsl:value-of select="Qty/UnitOfMeasrCd"/>
		   		</qty_unit_measr_code>
		   		 <qty_unit_measr_label>
		   		 	<xsl:value-of select="Qty/UnitOfMeasrCd"/>
		   		</qty_unit_measr_label> 
	   		</xsl:if>
	   		<xsl:if test="Qty/OthrUnitOfMeasr  != ''">
		   		<qty_other_unit_measr>
		   		 	<xsl:value-of select="Qty/OthrUnitOfMeasr"/>
		   		</qty_other_unit_measr>
   			</xsl:if>
	   		<xsl:if test="Qty/Val  != ''">
		   		<qty_val>
		   			<xsl:value-of select="Qty/Val"/>
		   		</qty_val>
	   		</xsl:if>
	   		<xsl:if test="Qty/Fctr  != ''">
		   		<qty_factor>
		   			<xsl:value-of select="Qty/Fctr"/>
		   		</qty_factor>
	   		</xsl:if>
	   		<xsl:if test="QtyTlrnce/PlusPct  != ''">
		   		<qty_tol_pstv_pct>
		   			<xsl:value-of select="QtyTlrnce/PlusPct"/>
		   		</qty_tol_pstv_pct>
	   		</xsl:if>
	   		<xsl:if test="QtyTlrnce/MnsPct  != ''">
				<qty_tol_neg_pct>
					<xsl:value-of select="QtyTlrnce/MnsPct"/>
				</qty_tol_neg_pct>
			</xsl:if>
			<xsl:if test="UnitPric/UnitOfMeasrCd  != ''">
		   		<price_unit_measr_code>
		   			<xsl:value-of select="UnitPric/UnitOfMeasrCd"/>
		   		</price_unit_measr_code>
	   		</xsl:if>
	   		<xsl:if test="UnitPric/OthrUnitOfMeasr  != ''">
		   		<price_other_unit_measr>
		   			<xsl:value-of select="UnitPric/OthrUnitOfMeasr"/>
		   		</price_other_unit_measr>
	   		</xsl:if>
	   		<xsl:if test="UnitPric/Amt/@Ccy  != ''">
		   		<price_cur_code>
		   			<xsl:value-of select="UnitPric/Amt/@Ccy"/>
		   		</price_cur_code>
	   		</xsl:if>
	   		<xsl:if test="UnitPric/Amt  != ''">
		   		<price_amt>
		   			<xsl:value-of select="UnitPric/Amt"/>
		   		</price_amt>
	   		</xsl:if>
	   		<xsl:if test="PricTlrnce/PlusPct  != ''">
		   		<price_factor>
		   			<xsl:value-of select="PricTlrnce/PlusPct"/>
		   		</price_factor>
	   		</xsl:if>
	   		<xsl:if test="PricTlrnce/MnsPct  != ''">
		   		<price_tol_pstv_pct>
		   			<xsl:value-of select="PricTlrnce/MnsPct"/>
		   		</price_tol_pstv_pct>
	   		</xsl:if>
	   		<xsl:if test="PdctNm  != ''">
		   		<product_name>
		   			<xsl:value-of select="PdctNm"/>
		   		</product_name>
	   		</xsl:if>
	   		<xsl:if test="TtlAmt/@Ccy  != ''">
		   		<total_net_cur_code>
		   			<xsl:value-of select="TtlAmt/@Ccy"/>
		   		</total_net_cur_code>
		   		<total_cur_code>
		   			<xsl:value-of select="TtlAmt/@Ccy"/>
		   		</total_cur_code>
	   		</xsl:if>
	   		<xsl:if test="TtlAmt  != ''">
		   		<total_amt>
					<xsl:value-of select="TtlAmt"/>
		   		</total_amt>
		   		<total_net_amt><xsl:value-of select="TtlAmt"/></total_net_amt>
	   		</xsl:if>
	   		<xsl:if test="PdctOrgn  != ''">
		   		<product_orgn>
		   			<xsl:value-of select="PdctOrgn"/>
		   		</product_orgn>
	   		</xsl:if>
	   		<xsl:if test="ShipmntSchdl/ShipmntDtRg/LatstShipmntDt  != ''">
		   		<last_ship_date>
		   			<xsl:value-of select="ShipmntSchdl/ShipmntDtRg/LatstShipmntDt"/>
		   		</last_ship_date>
	   		</xsl:if>
	   		<xsl:if test="ShipmntSchdl/ShipmntDtRg/EarlstShipmntDt  != ''">
		   		<earliest_ship_date>
		   			<xsl:value-of select="ShipmntSchdl/ShipmntDtRg/EarlstShipmntDt"/>
		   		</earliest_ship_date>
	   		</xsl:if>
	   		<xsl:if test="ShipmntSchdl/ShipmntSubSchdl != ''">
	   			<shipmentSchedules>
	   			 	<xsl:apply-templates select="ShipmntSchdl/ShipmntSubSchdl"/>
	   			 </shipmentSchedules>
	   		</xsl:if>
	   		<xsl:if test="PdctIdr  != ''">
		   		<productIdentifiers>
		   			 <xsl:apply-templates select="PdctIdr"/>
			   </productIdentifiers>
		   </xsl:if>
		   <xsl:if test="PdctChrtcs  != ''">
			   <productCharacteristics>
			      <xsl:apply-templates select="PdctChrtcs"/>
				</productCharacteristics>
			</xsl:if>
			<xsl:if test="PdctCtgy  != ''">
				<productCategories>
					<xsl:apply-templates select="PdctCtgy"/>
				</productCategories>
			</xsl:if>
			<xsl:if test="RtgSummry/IndvTrnsprt != ''">
   				<xsl:apply-templates select="RtgSummry/IndvTrnsprt"/>		 
		    </xsl:if>
		    <xsl:if test="RtgSummry/MltmdlTrnsprt!=''">
				<xsl:if test="RtgSummry/MltmdlTrnsprt/TakngInChrg != ''">
					<taking_in_charge>
						<xsl:value-of select="RtgSummry/MltmdlTrnsprt/TakngInChrg"/>
					</taking_in_charge>
				</xsl:if>
				<xsl:if test="RtgSummry/MltmdlTrnsprt/PlcOfFnlDstn != ''">
					<final_dest_place>
						<xsl:value-of select="RtgSummry/MltmdlTrnsprt/PlcOfFnlDstn"/>
					</final_dest_place>
				</xsl:if>
		    </xsl:if>
			<xsl:if test="FrghtChrgs  != ''">
				<xsl:if test="FrghtChrgs/Tp  != ''">
				<freight_charges_type>
					<xsl:value-of select="FrghtChrgs/Tp"/>
				</freight_charges_type>
				</xsl:if>
				<xsl:if test="FrghtChrgs/Chrgs">
					<freightCharges>
						<xsl:apply-templates select="FrghtChrgs/Chrgs"/>
					</freightCharges>
				</xsl:if>
			</xsl:if>
			<xsl:if test="Tax  != ''">
				<taxes>
					<xsl:apply-templates select="Tax"/>
				</taxes>
			</xsl:if>
			<xsl:if test="Incotrms  != ''">
				<incoterms>
					<xsl:apply-templates select="Incotrms"/>
				</incoterms>
			</xsl:if>
			<xsl:if test="Adjstmnt  != ''">
				<adjustments>
					<xsl:apply-templates select="Adjstmnt"/>
	  			</adjustments>
	  		</xsl:if>
	   </lineItem>
	</xsl:template>
	<!-- Line Items -->
	<!-- Buyer/Seller Defined Information -->
	<xsl:template match="BuyrDfndInf">
		<buyer_defined_information>
			<xsl:if test="Labl != ''">
				<label><xsl:value-of select="Labl"/></label>
			</xsl:if>
			<xsl:if test="Inf != ''">
				<information><xsl:value-of select="Inf"/></information>
			</xsl:if>
			<is_valid>Y</is_valid>
		</buyer_defined_information>
	</xsl:template>
	
	<xsl:template match="SellrDfndInf">
		<seller_defined_information>
			<xsl:if test="Labl != ''">
				<label><xsl:value-of select="Labl"/></label>
			</xsl:if>
			<xsl:if test="Inf != ''">
				<information><xsl:value-of select="Inf"/></information>
			</xsl:if>
			<is_valid>Y</is_valid>
		</seller_defined_information>
	</xsl:template>
	<!-- Buyer/Seller Defined Information -->
	
	<!-- BPO -->
	<xsl:template match="PushdThrghBaseln/PmtOblgtn">
		<bank_payment_obligation>
			<bpo>
   				<xsl:variable name="cdata">![CDATA[</xsl:variable>
				<xsl:variable name="end">]]</xsl:variable>
				<xsl:text disable-output-escaping="yes">&lt;</xsl:text><xsl:value-of select="$cdata" /><xsl:copy-of select="."/><xsl:value-of select="$end" /><xsl:text disable-output-escaping="yes">&gt;</xsl:text>
			</bpo>
			<bpo_xml>
				<xsl:copy-of select="."/>
			</bpo_xml>
		</bank_payment_obligation>
	</xsl:template>
	<!-- BPO -->
	
	<!-- All Dataset -->
	<xsl:template match="PushdThrghBaseln/PmtOblgtn | PushdThrghBaseln/ComrclDataSetReqrd | PushdThrghBaseln/TrnsprtDataSetReqrd | PushdThrghBaseln/InsrncDataSetReqrd | PushdThrghBaseln/CertDataSetReqrd | PushdThrghBaseln/OthrCertDataSetReqrd | TrnsprtDataSet| InsrncDataSet | CertDataSet | OthrCertDataSet">
		<xsl:variable name="cdata">![CDATA[</xsl:variable>
		<xsl:variable name="end">]]</xsl:variable>
		<xsl:text disable-output-escaping="yes">&lt;</xsl:text>
		<xsl:value-of select="$cdata" /><xsl:copy-of select="."/><xsl:value-of select="$end" /><xsl:text disable-output-escaping="yes">&gt;</xsl:text>
	</xsl:template>
	<!-- Routing Summary -->
	
	<!-- departures -->	
	<xsl:template match="DprtureAirprt">
		<xsl:param name="routing_summary_sub_type"/>
			<departure>
				<routing_summary_sub_type><xsl:value-of select="$routing_summary_sub_type"/></routing_summary_sub_type>
				<xsl:if test="AirprtCd !=''">
					<departure_airport_code>
						<xsl:value-of select="AirprtCd"/>
					</departure_airport_code>
				</xsl:if>
				<xsl:if test="OthrAirprtDesc/AirprtNm !=''">
					<departure_airport_name>
						<xsl:value-of select="OthrAirprtDesc/AirprtNm"/>
					</departure_airport_name>
				</xsl:if>
				<xsl:if test="OthrAirprtDesc/Twn !=''">
					<departure_air_town>
						<xsl:value-of select="OthrAirprtDesc/Twn"/>
					</departure_air_town>
				</xsl:if>
				<is_valid>Y</is_valid>
			</departure>
	</xsl:template>
	<!-- Destinations -->
	<xsl:template match="DstnAirprt">
		<xsl:param name="routing_summary_sub_type"/>
			<destination>
				<routing_summary_sub_type><xsl:value-of select="$routing_summary_sub_type"/></routing_summary_sub_type>
				<xsl:if test="AirprtCd !=''">
					<destination_airport_code>
						<xsl:value-of select="AirprtCd"/>
					</destination_airport_code>
				</xsl:if>
				<xsl:if test="OthrAirprtDesc/AirprtNm !=''">
					<destination_airport_name>
						<xsl:value-of select="OthrAirprtDesc/AirprtNm"/>
					</destination_airport_name>
				</xsl:if>
				<xsl:if test="OthrAirprtDesc/Twn !=''">
					<destination_air_town>
						<xsl:value-of select="OthrAirprtDesc/Twn"/>
					</destination_air_town>
				</xsl:if>
				<is_valid>Y</is_valid>
			</destination>
	</xsl:template>
	
	<xsl:template match="PortOfLoadng">
		<xsl:param name="routing_summary_sub_type"/>
			<loading_port>
				<routing_summary_sub_type><xsl:value-of select="$routing_summary_sub_type"/></routing_summary_sub_type>
				<loading_port_name>
					<xsl:value-of select="."/>
				</loading_port_name>
				<is_valid>Y</is_valid>
			</loading_port>
	</xsl:template>
	
	<xsl:template match="PortOfDschrge">
		<xsl:param name="routing_summary_sub_type"/>
			<discharge_port>
				<routing_summary_sub_type><xsl:value-of select="$routing_summary_sub_type"/></routing_summary_sub_type>
				<discharge_port_name>
					<xsl:value-of select="."/>
				</discharge_port_name>
				<is_valid>Y</is_valid>
			</discharge_port>
	</xsl:template>
	
	<xsl:template match="PlcOfRct">
		<xsl:param name="routing_summary_sub_type"/>
			<xsl:choose>
				<xsl:when test="$routing_summary_sub_type ='05'">
					<road_receipt_place>
						<routing_summary_sub_type><xsl:value-of select="$routing_summary_sub_type"/></routing_summary_sub_type>
						<road_receipt_place_name><xsl:value-of select="."/></road_receipt_place_name>
						<is_valid>Y</is_valid>
					</road_receipt_place>
				</xsl:when>
				<xsl:when test="$routing_summary_sub_type ='07'">
					<rail_receipt_place>
						<routing_summary_sub_type><xsl:value-of select="$routing_summary_sub_type"/></routing_summary_sub_type>
						<rail_receipt_place_name><xsl:value-of select="."/></rail_receipt_place_name>
						<is_valid>Y</is_valid>
					</rail_receipt_place>
				</xsl:when>
			</xsl:choose>
	</xsl:template>
	
	<xsl:template match="PlcOfDlvry">
	<xsl:param name="routing_summary_sub_type"/>
		<xsl:choose>
			<xsl:when test="$routing_summary_sub_type = '06'">
				<road_delivery_place>
					<routing_summary_sub_type><xsl:value-of select="$routing_summary_sub_type"/></routing_summary_sub_type>
					<road_delivery_place_name>
						<xsl:value-of select="."/>
					</road_delivery_place_name>
					<is_valid>Y</is_valid>
				</road_delivery_place>
			</xsl:when>
			<xsl:when test="$routing_summary_sub_type = '08'">
					<rail_delivery_place>
						<routing_summary_sub_type><xsl:value-of select="$routing_summary_sub_type"/></routing_summary_sub_type>
						<rail_delivery_place_name>
							<xsl:value-of select="."/>
						</rail_delivery_place_name>
						<is_valid>Y</is_valid>
					</rail_delivery_place>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="RtgSummry/IndvTrnsprt | Goods/RtgSummry/IndvTrnsprt" >
			<xsl:if test="TrnsprtByAir[.!='']">
				<routingSummaries>
					<xsl:for-each select="TrnsprtByAir">
						<routingSummary>
							<routing_summary_type>01</routing_summary_type>
							<routing_summary_mode>01</routing_summary_mode>
							<xsl:if test="AirCrrierNm != ''">
								<air_carrier_name>
									<xsl:value-of select="AirCrrierNm"/>
								</air_carrier_name>
							</xsl:if>
							<xsl:if test="DprtureAirprt != ''">
								<departures>
									<xsl:apply-templates select="DprtureAirprt">
										<xsl:with-param name="routing_summary_sub_type">01</xsl:with-param>
									</xsl:apply-templates>
								</departures>
							</xsl:if>
							<xsl:if test="DstnAirprt != ''">
								<destinations>
									<xsl:apply-templates select="DstnAirprt">
										<xsl:with-param name="routing_summary_sub_type">02</xsl:with-param>
									</xsl:apply-templates>
								</destinations>
							</xsl:if>
							<is_valid>Y</is_valid>
						</routingSummary>
					</xsl:for-each>
				</routingSummaries>
			</xsl:if>
			<xsl:if test="TrnsprtBySea[.!='']">
				<routingSummaries>
				 <xsl:for-each select="TrnsprtBySea">
					<routingSummary>
						<routing_summary_type>01</routing_summary_type>
						<routing_summary_mode>02</routing_summary_mode>
						<xsl:if test="SeaCrrierNm != ''">
								<sea_carrier_name>
									<xsl:value-of select="SeaCrrierNm"/>
								</sea_carrier_name>
						</xsl:if>
						<xsl:if test="PortOfLoadng != ''">
						<loading_ports>
							<xsl:apply-templates select="PortOfLoadng">
								<xsl:with-param name="routing_summary_sub_type">03</xsl:with-param>
							</xsl:apply-templates>
						</loading_ports>
						</xsl:if>
						<xsl:if test="PortOfDschrge !=''">
							<discharge_ports>
								<xsl:apply-templates select="PortOfDschrge">
									<xsl:with-param name="routing_summary_sub_type">04</xsl:with-param>
								</xsl:apply-templates>
							</discharge_ports>
						</xsl:if>
						<is_valid>Y</is_valid>
					</routingSummary>
				</xsl:for-each>
				</routingSummaries>
			</xsl:if>
			<xsl:if test="TrnsprtByRoad[.!='']">
				<routingSummaries>
				 <xsl:for-each select="TrnsprtByRoad">
						<routingSummary>
							<routing_summary_type>01</routing_summary_type>
							<routing_summary_mode>03</routing_summary_mode>
							<xsl:if test="RoadCrrierNm != ''">
								<road_carrier_name>
									<xsl:value-of select="RoadCrrierNm"/>
								</road_carrier_name>
							</xsl:if>
							<xsl:if test="PlcOfRct !=''">
							<road_receipt_places>
								<xsl:apply-templates select="PlcOfRct">
									<xsl:with-param name="routing_summary_sub_type">05</xsl:with-param>
								</xsl:apply-templates>
							</road_receipt_places>
							</xsl:if>
							<xsl:if test="PlcOfDlvry !=''">
							<road_delivery_places>
								 <xsl:apply-templates select="PlcOfDlvry">
									<xsl:with-param name="routing_summary_sub_type">06</xsl:with-param>
								</xsl:apply-templates>
							</road_delivery_places>
							</xsl:if>
							<is_valid>Y</is_valid>
						</routingSummary>
					</xsl:for-each>
					</routingSummaries>
			</xsl:if>
			
			<xsl:if test="TrnsprtByRail[.!='']">
				<routingSummaries>
				<xsl:for-each select="TrnsprtByRail">
					<routingSummary>
						<routing_summary_type>01</routing_summary_type>
						<routing_summary_mode>04</routing_summary_mode>
						<xsl:if test="RailCrrierNm != ''">
								<rail_carrier_name>
									<xsl:value-of select="RailCrrierNm"/>
								</rail_carrier_name>
						</xsl:if>
						<xsl:if test="PlcOfRct !=''">
							<rail_receipt_places>
								<xsl:apply-templates select="PlcOfRct">
									<xsl:with-param name="routing_summary_sub_type">07</xsl:with-param>
								</xsl:apply-templates>
							</rail_receipt_places>
						 </xsl:if>
						 <xsl:if test="PlcOfDlvry !=''">
							<rail_delivery_places>
								<xsl:apply-templates select="PlcOfDlvry">
									<xsl:with-param name="routing_summary_sub_type">08</xsl:with-param>
								</xsl:apply-templates>
							</rail_delivery_places>
						 </xsl:if>
						<is_valid>Y</is_valid>
					</routingSummary>
				</xsl:for-each>
				</routingSummaries>
			</xsl:if>
	</xsl:template>
	
	<!-- Routing Summary -->
	
	<!-- Contact Person -->
	<xsl:template match="SellrCtctPrsn | BuyrCtctPrsn | SellrBkCtctPrsn | BuyrBkCtctPrsn | OthrBkCtctPrsn">
		<xsl:param name="contact_type"/>
		<xsl:call-template name="CONTACT_DETAILS">
			<xsl:with-param name="contact_type"><xsl:value-of select="$contact_type"/></xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="CONTACT_DETAILS">
		<xsl:param name="contact_type"/>
		<contact>
	   	    <type><xsl:value-of select="$contact_type"/></type>
	   	    <xsl:if test="BIC">
	   	    	<bic><xsl:value-of select="BIC"/></bic>
	   	    </xsl:if>
			<xsl:if test="NmPrfx">
				<name_prefix>
					<xsl:value-of select="NmPrfx"/>
				</name_prefix>
			</xsl:if>
			<xsl:if test="Nm">
				<name_value>
					<xsl:value-of select="Nm"/>
				</name_value>
			</xsl:if>
			<xsl:if test="GvnNm">
				<given_name>
					<xsl:value-of select="GvnNm"/>
				</given_name>
			</xsl:if>
			<xsl:if test="Role">
				<role>
					<xsl:value-of select="Role"/>
				</role>
			</xsl:if>
			<xsl:if test="PhneNb">
				<phone_number>
					<xsl:value-of select="PhneNb"/>
				</phone_number>
			</xsl:if>
			<xsl:if test="FaxNb">
				<fax_number>
					<xsl:value-of select="FaxNb"/>
				</fax_number>
			</xsl:if>
			<xsl:if test="EmailAdr">
				<email>
					<xsl:value-of select="EmailAdr"/>
				</email>
			</xsl:if>
			<is_valid>Y</is_valid>
	   	 </contact>
	</xsl:template>

  
</xsl:stylesheet>