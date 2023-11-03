<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:Doc="urn:swift:xsd:$tsmt.018.001.02"
	xmlns:default="xalan://com.misys.portal.common.resources.DefaultResourceProvider" 
	xmlns:intools="xalan://com.misys.portal.interfaces.tools.InterfacesTools"
	xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools"
	exclude-result-prefixes="default intools tools">

	<xsl:import href="common.xsl"/>
	
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	<!-- Get the interface environment -->
	<xsl:param name="context"/>
	<xsl:param name="BIC"/>
	<xsl:param name="language"/>
	<!--
	Copyright (c) 2000-2007 NEOMAlogic (http://www.neomalogic.com),
	All Rights Reserved. 
	-->
	
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="Doc:Document">
		<xsl:apply-templates/>
	</xsl:template>
	
	<!-- Process TSU Message -->
	<xsl:template match="Doc:tsmt.018.001.02">
		
		<!-- Create a new SO only for Initial Baseline Submissions -->
		<xsl:if test="Doc:RptPurp/Doc:Tp = 'FWIS'">
			<so_tnx_record xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.neomalogic.com/gtp/interfaces/xsd/so.xsd">
				<brch_code>00001</brch_code>
				<issuer_ref_id><xsl:value-of select="Doc:UsrTxRef/Doc:Id"/></issuer_ref_id>
				<tnx_type_code>01</tnx_type_code>
				<sub_tnx_type_code/>
				<prod_stat_code>03</prod_stat_code>
				<!-- incomplete bank -->
				<tnx_stat_code>05</tnx_stat_code>
				<product_code>SO</product_code>
				
				<xsl:apply-templates select="Doc:PushdThrghBaseln">
					<xsl:with-param name="submission_type">FPTR</xsl:with-param>
				</xsl:apply-templates>
		
				<!--contacts/>
				<payments/>
				<incoterms/>
				<adjustments/>
				<taxes/>
				<user_defined_informations/>
				<freight_charges/>
				<routing_summaries/-->
				
				<buyer_bank>
					<abbv_name/>
					<name><xsl:value-of select="intools:retrieveNameFromBICDirectory(Doc:PushdThrghBaseln/Doc:BuyrBk/Doc:BIC, $context)"/></name>
					<iso_code><xsl:value-of select="Doc:PushdThrghBaseln/Doc:BuyrBk/Doc:BIC"/></iso_code>
				</buyer_bank>
				<issuing_bank>
					<abbv_name/>
					<name><xsl:value-of select="intools:retrieveNameFromBICDirectory(Doc:PushdThrghBaseln/Doc:SubmitrBaselnId/Doc:Submitr/Doc:BIC, $context)"/></name>
					<iso_code><xsl:value-of select="Doc:PushdThrghBaseln/Doc:SubmitrBaselnId/Doc:Submitr/Doc:BIC"/></iso_code>
				</issuing_bank>
				<seller_bank>
					<abbv_name/>
					<name><xsl:value-of select="intools:retrieveNameFromBIC(Doc:PushdThrghBaseln/Doc:SellrBk/Doc:BIC, $context)"/></name>
					<iso_code><xsl:value-of select="Doc:PushdThrghBaseln/Doc:SellrBk/Doc:BIC"/></iso_code>
				</seller_bank>
				<advising_bank>
					<abbv_name><xsl:value-of select="intools:retrieveAbbvNameFromBIC(Doc:PushdThrghBaseln/Doc:SellrBk/Doc:BIC, $context)"/></abbv_name>
					<name><xsl:value-of select="intools:retrieveNameFromBIC(Doc:PushdThrghBaseln/Doc:SellrBk/Doc:BIC, $context)"/></name>
					<iso_code><xsl:value-of select="Doc:PushdThrghBaseln/Doc:SellrBk/Doc:BIC"/></iso_code>
				</advising_bank>
				
				<bo_comment>This is an automatic notification of a Purchase Order.</bo_comment>
			</so_tnx_record>
		</xsl:if>
	</xsl:template>
	
	
	
	
	<!--                               -->
	<!-- TSU to Open Account templates -->
	<!--                               -->
	
	<!-- Baseline -->
   <xsl:template match="Doc:PushdThrghBaseln"> 
    	<xsl:param name="submission_type"/>
    	
   	<tnx_cur_code><xsl:value-of select="Doc:Goods/Doc:LineItmsTtlAmt/@Ccy"/></tnx_cur_code>
   	<tnx_amt>
   		<xsl:call-template name="TP_amount">
   			<xsl:with-param name="amount"><xsl:value-of select="Doc:Goods/Doc:LineItmsTtlAmt"/></xsl:with-param>
   		</xsl:call-template>
   	</tnx_amt>
   	
   	<!--entity></entity-->
   	
   	<!--- Parties -->
   	<xsl:apply-templates select="Doc:Buyr"/>
   	<xsl:apply-templates select="Doc:Sellr"/>
   	<xsl:apply-templates select="Doc:BllTo"/>
   	<xsl:apply-templates select="Doc:ShipTo"/>
   	<xsl:apply-templates select="Doc:Consgn"/>
   	
   	<xsl:if test="Doc:Goods/Doc:GoodsDesc">
   		<goods_desc><xsl:value-of select="Doc:Goods/Doc:GoodsDesc"/></goods_desc>
   	</xsl:if>
   	
   	<xsl:if test="Doc:Goods/Doc:PrtlShipmnt">
   		<part_ship>
   			<xsl:choose>
					<xsl:when test="Doc:Goods/Doc:PrtlShipmnt='true'">Y</xsl:when>
					<xsl:when test="Doc:Goods/Doc:PrtlShipmnt='false'">N</xsl:when>
				</xsl:choose>
			</part_ship>
   	</xsl:if>
   	
   	<xsl:if test="Doc:Goods/Doc:TrnsShipmnt">
   		<tran_ship>
   			<xsl:choose>
					<xsl:when test="Goods/TrnsShipmnt='true'">Y</xsl:when>
					<xsl:when test="Goods/TrnsShipmnt='false'">N</xsl:when>
				</xsl:choose>
			</tran_ship>
   	</xsl:if>
   	
   	<xsl:if test="Doc:Goods/Doc:LatstShipmntDt">
   		<last_ship_date>
   			<xsl:call-template name="ISODate2TP">
   				<xsl:with-param name="date"><xsl:value-of select="Doc:Goods/Doc:LatstShipmntDt"/></xsl:with-param>
   			</xsl:call-template>
   		</last_ship_date>
   	</xsl:if>
   	
   	<nb_mismatch></nb_mismatch>
   	<full_match></full_match>
   	
   	<!-- Amounts -->
   	<total_amt>
   		<xsl:call-template name="TP_amount">
   			<xsl:with-param name="amount"><xsl:value-of select="Doc:Goods/Doc:LineItmsTtlAmt"/></xsl:with-param>
   		</xsl:call-template>
   	</total_amt>
   	<total_cur_code><xsl:value-of select="Doc:Goods/Doc:LineItmsTtlAmt/@Ccy"/></total_cur_code>
   	<total_net_amt>
			<xsl:call-template name="TP_amount">
   			<xsl:with-param name="amount"><xsl:value-of select="Doc:Goods/Doc:TtlNetAmt"/></xsl:with-param>
   		</xsl:call-template>
   	</total_net_amt>
   	<total_net_cur_code><xsl:value-of select="Doc:Goods/Doc:TtlNetAmt/@Ccy"/></total_net_cur_code>
   	<liab_total_amt>
   		<xsl:call-template name="TP_amount">
   			<xsl:with-param name="amount"><xsl:value-of select="Doc:Goods/Doc:LineItmsTtlAmt"/></xsl:with-param>
   		</xsl:call-template>
   	</liab_total_amt>
   	<liab_total_cur_code><xsl:value-of select="Doc:Goods/Doc:LineItmsTtlAmt/@Ccy"/></liab_total_cur_code>

   	<liab_total_net_amt>
			<xsl:call-template name="TP_amount">
   			<xsl:with-param name="amount"><xsl:value-of select="Doc:Goods/Doc:TtlNetAmt"/></xsl:with-param>
   		</xsl:call-template>
   	</liab_total_net_amt>
   	<liab_total_net_cur_code><xsl:value-of select="Doc:Goods/Doc:TtlNetAmt/@Ccy"/></liab_total_net_cur_code>
   	
   	<!-- Settlements -->
   	<xsl:apply-templates select="Doc:SttlmTerms"/>
   	
   	<xsl:if test="Doc:DataSetReqrd">
   		<xsl:if test="Doc:DataSetReqrd/Doc:LatstMtchDt[.!='']">
	      	<last_match_date>
	      		<xsl:call-template name="ISODate2TP">
	      				<xsl:with-param name="date"><xsl:value-of select="Doc:DataSetReqrd/Doc:LatstMtchDt"/></xsl:with-param>
	      		</xsl:call-template>
	      	</last_match_date>
	    </xsl:if>
	   	<reqrd_commercial_dataset>
	   		<xsl:choose>
	   			<xsl:when test="Doc:DataSetReqrd/Doc:ReqrdComrclDataSet = 'true'">Y</xsl:when>
	   			<xsl:otherwise>N</xsl:otherwise>
	   		</xsl:choose>
	   	</reqrd_commercial_dataset>
	   	<reqrd_transport_dataset>
	   		<xsl:choose>
	   			<xsl:when test="Doc:DataSetReqrd/Doc:ReqrdTrnsprtDataSet = 'true'">Y</xsl:when>
	   			<xsl:otherwise>N</xsl:otherwise>
	   		</xsl:choose>
	   	</reqrd_transport_dataset>
   	</xsl:if>
   	
   	<xsl:if test="Doc:SubmitrBaselnId/Doc:Submitr/Doc:BIC">
   		<submitr_bic></submitr_bic>
   	</xsl:if>
   	
   	<!--data_set_id></data_set_id-->
   	
   	<xsl:if test="Doc:Goods/Doc:FrghtChrgs">
      	<freight_charges_type><xsl:value-of select="Doc:Goods/Doc:FrghtChrgs/Doc:Tp"/></freight_charges_type>
   	</xsl:if>
   	
   	<xsl:if test="Doc:PmtTerms">
      	<payment_terms_type>
      		<xsl:choose>
      			<xsl:when test="Doc:PmtTerms/Doc:Pctg">PRCT</xsl:when>
      			<xsl:when test="Doc:PmtTerms/Doc:Amt">AMNT</xsl:when>
      			<xsl:otherwise/>
      		</xsl:choose>
      	</payment_terms_type>
   	</xsl:if>

      <!--version></version-->
   	
   	<xsl:if test="$submission_type='FPTR'">
      	<buyer_bank_type_code>01</buyer_bank_type_code>
      			<!--xsl:choose>
      			<xsl:when test="$submission_type='FPTR'">01</xsl:when>
      			<xsl:when test="$submission_type='LODG'"-->
      				<!--xsl:choose>
							<xsl:when test="BuyrBk">01</xsl:when>
							<xsl:when test="BuyrBk/BIC = ../SellrBk/BIC">02</xsl:when>
						</xsl:choose-->
					<!--/xsl:when>
				</xsl:choose-->
      	<seller_bank_type_code>02</seller_bank_type_code>
      			<!--xsl:choose>
      			<xsl:when test="$submission_type='FPTR'">02</xsl:when>
      			<xsl:when test="$submission_type='LODG'"-->
      				<!--xsl:choose>
							<xsl:when test="BuyrBk">01</xsl:when>
							<xsl:when test="BuyrBk/BIC = ../SellrBk/BIC">02</xsl:when>
						</xsl:choose-->
					<!--/xsl:when>
				</xsl:choose-->
		</xsl:if>
		
   	<!--issuer_type_code></issuer_type_code-->
   	
   	<!--final_presentation></final_presentation-->
   	
   	<xsl:if test="$submission_type = 'LODG' or $submission_type = 'FPTR'">
   		<submission_type><xsl:value-of select="$submission_type"/></submission_type>
   	</xsl:if>
   	
   	<!-- TID -->
   	<tid><xsl:value-of select="//Doc:TxId/Doc:Id"/></tid>
   	
   	<!-- Purchase Order Ref Id -->
   	<po_ref_id><xsl:value-of select="Doc:PurchsOrdrRef/Doc:Id"/></po_ref_id>
   	
   	<!-- Purchase Order Issue Date -->
   	<po_issue_date>
  		<xsl:call-template name="ISODate2TP">
  			<xsl:with-param name="date"><xsl:value-of select="Doc:PurchsOrdrRef/Doc:DtOfIsse"/></xsl:with-param>
  		</xsl:call-template>
   	</po_issue_date>

   	<!-- Additional fields -->
   	<additional_field name="hasLineItem" type="string" scope="none">Y</additional_field>

   	<!-- Line Items -->
   	<line_items>
   		<xsl:apply-templates select="Doc:Goods/Doc:LineItmDtls"/>
   	</line_items>
   						
   	<!-- Contacts -->
   	<xsl:if test="//Doc:BuyrCtctPrsn[.!=''] | //Doc:SellrCtctPrsn[.!=''] | //Doc:SellrBkCtctPrsn[.!=''] | //Doc:BllToCtctPrsn[.!=''] | //Doc:ShipToCtctPrsn[.!=''] | //Doc:ConsgnCtctPrsn[.!='']">
      	<contacts>
         	<xsl:apply-templates select="//Doc:BuyrCtctPrsn">
         		<xsl:with-param name="type">02</xsl:with-param>
         	</xsl:apply-templates>
         	<xsl:apply-templates select="//Doc:SellrCtctPrsn">
         		<xsl:with-param name="type">01</xsl:with-param>
         	</xsl:apply-templates>
         	<xsl:apply-templates select="//Doc:BuyrBkCtctPrsn">
         		<xsl:with-param name="type">04</xsl:with-param>
         	</xsl:apply-templates>
         	<xsl:apply-templates select="//Doc:SellrBkCtctPrsn">
         		<xsl:with-param name="type">03</xsl:with-param>
         	</xsl:apply-templates>
         	<xsl:apply-templates select="//Doc:BllToCtctPrsn">
         		<xsl:with-param name="type">05</xsl:with-param>
         	</xsl:apply-templates>
         	<xsl:apply-templates select="//Doc:ShipToCtctPrsn">
         		<xsl:with-param name="type">06</xsl:with-param>
         	</xsl:apply-templates>
         	<xsl:apply-templates select="//Doc:ConsgnCtctPrsn">
         		<xsl:with-param name="type">07</xsl:with-param>
         	</xsl:apply-templates>
      	</contacts>
      </xsl:if>
     	
   	<!-- Payments -->
   	<xsl:if test="Doc:PmtTerms">
      	<payments>
      		<xsl:apply-templates select="Doc:PmtTerms"/>
      	</payments>
   	</xsl:if>

	<!-- Inco Terms -->
	<incoterms>
   		<xsl:apply-templates select="Doc:Goods/Doc:Incotrms"/>
   	</incoterms>      	
   	
   	<!-- Adjustments -->
   	<adjustments>
   		<xsl:apply-templates select="Doc:Goods/Doc:Adjstmnt"/>
   	</adjustments>
   	   			
    	<!-- Taxes -->
   	<taxes>
   		<xsl:apply-templates select="Doc:Goods/Doc:Tax"/>
   	</taxes>

      	<!-- Freight Charges -->
   	<freight_charges>
   		<xsl:apply-templates select="Doc:FrghtChrgs/Doc:Chrgs"/>
   	</freight_charges>
   	
   	<!-- User information -->
   	<xsl:if test="Doc:Goods/Doc:BuyrDfndInf or Doc:Goods/Doc:SellrDfndInf">
   		<user_defined_informations>
      		<xsl:apply-templates select="Doc:Goods/Doc:BuyrDfndInf"/>
      		<xsl:apply-templates select="Doc:Goods/Doc:SellrDfndInf"/>
			</user_defined_informations>
		</xsl:if>
   	      	
  		<!-- Routing Summaries -->
   	<!--xsl:apply-templates select=""/-->
   	
	</xsl:template>
	
	
	<!-- Party Template -->
	
	<!-- Buyer -->
	<xsl:template match="Doc:Buyr">
			<xsl:call-template name="TP_party">
				<xsl:with-param name="party_name">buyer</xsl:with-param>
				<xsl:with-param name="bic"><xsl:value-of select="//Doc:BuyrBk/Doc:BIC"/></xsl:with-param>
			</xsl:call-template>
	</xsl:template>
	
	<!-- Seller -->
	<xsl:template match="Doc:Sellr">
			<xsl:call-template name="TP_party">
				<xsl:with-param name="party_name">seller</xsl:with-param>
				<xsl:with-param name="bic"><xsl:value-of select="//Doc:SellrBk/Doc:BIC"/></xsl:with-param>
			</xsl:call-template>
	</xsl:template>
	
	<!-- Bill To -->
	<xsl:template match="Doc:BllTo">
			<xsl:call-template name="TP_party">
				<xsl:with-param name="party_name">bill_to</xsl:with-param>
				<xsl:with-param name="bic"/>
			</xsl:call-template>
	</xsl:template>
	
	<!-- Consignee -->
	<xsl:template match="Doc:Consgn">
			<xsl:call-template name="TP_party">
				<xsl:with-param name="party_name">consgn</xsl:with-param>
				<xsl:with-param name="bic"/>
			</xsl:call-template>
	</xsl:template>
	
	<!-- Ship To -->
	<xsl:template match="Doc:ShipTo">
			<xsl:call-template name="TP_party">
				<xsl:with-param name="party_name">ship_to</xsl:with-param>
				<xsl:with-param name="bic"/>
			</xsl:call-template>
	</xsl:template>
	
	<!-- Common TP Party Template -->
	<xsl:template name="TP_party">
		<xsl:param name="party_name"/>
		<xsl:param name="bic"/>
		<!--xsl:element name="{$party_name}_abbv_name></buyer_reference-->
		<xsl:element name="{$party_name}_name"><xsl:value-of select="Doc:Nm"/></xsl:element>
		<xsl:element name="{$party_name}_bei"><xsl:value-of select="Doc:Bei"/></xsl:element>
		<xsl:if test="$bic != ''">
			<xsl:element name="{$party_name}_bank_bic"><xsl:value-of select="$bic"/></xsl:element>
		</xsl:if>
		<xsl:apply-templates select="Doc:PstlAdr">
			<xsl:with-param name="party_name"><xsl:value-of select="$party_name"/></xsl:with-param>
		</xsl:apply-templates>
		<!--xsl:element name="{$party_name}_reference></buyer_reference-->
	</xsl:template>
	
	<!-- Common party template : address -->
	<xsl:template match="Doc:PstlAdr | Doc:Adr">
		<xsl:param name="party_name"/>
		<xsl:element name="{$party_name}_street_name"><xsl:value-of select="Doc:StrtNm"/></xsl:element>
		<xsl:element name="{$party_name}_post_code"><xsl:value-of select="Doc:PstCdId"/></xsl:element>
		<xsl:element name="{$party_name}_town_name"><xsl:value-of select="Doc:TwnNm"/></xsl:element>
		<xsl:element name="{$party_name}_country_sub_div"><xsl:value-of select="Doc:CtrySubDvsn"/></xsl:element>
		<xsl:element name="{$party_name}_country"><xsl:value-of select="Doc:Ctry"/></xsl:element>
	</xsl:template>
	
	<!-- Settlement -->
	<xsl:template match="Doc:SttlmTerms">
		<xsl:apply-templates select="Doc:FnlAgt"/>
		<xsl:apply-templates select="Doc:BnfcryAcct"/>
   </xsl:template>
    
   <!-- Financial Institution -->
   <xsl:template match="Doc:FnlAgt">
    	<fin_inst_bic><xsl:value-of select="Doc:BIC"/></fin_inst_bic>
    	<fin_inst_name><xsl:value-of select="Doc:NmAndAdr/Doc:Nm"/></fin_inst_name>
    	<xsl:apply-templates select="Doc:NmAndAdr/Doc:Adr">
			<xsl:with-param name="party_name">fin_inst</xsl:with-param>
		</xsl:apply-templates>
   </xsl:template>
    
   <!-- Beneficiary Account -->
   <xsl:template match="Doc:BnfcryAcct">
   	<xsl:choose>
   		<xsl:when test="Doc:Nm">
   			<seller_account_name><xsl:value-of select="Doc:Nm"/></seller_account_name>
   		</xsl:when>
   		<xsl:when test="Doc:Id">
         	<seller_account_iban><xsl:value-of select="Doc:Id/Doc:IBAN"/></seller_account_iban>
         	<seller_account_bban><xsl:value-of select="Doc:Id/Doc:BBAN"/></seller_account_bban>
         	<seller_account_upic><xsl:value-of select="Doc:Id/Doc:UPIC"/></seller_account_upic>
         	<seller_account_id><xsl:value-of select="Doc:Id/Doc:DmstAcct/Doc:Id"/></seller_account_id>
      	</xsl:when>
      	<xsl:when test="Doc:NmAndId">
      		<seller_account_name><xsl:value-of select="Doc:NmAndId/Doc:Nm"/></seller_account_name>
      		<seller_account_iban><xsl:value-of select="Doc:NmAndId/Doc:IBAN"/></seller_account_iban>
         	<seller_account_bban><xsl:value-of select="Doc:NmAndId/Doc:BBAN"/></seller_account_bban>
         	<seller_account_upic><xsl:value-of select="Doc:NmAndId/Doc:UPIC"/></seller_account_upic>
         	<seller_account_id><xsl:value-of select="Doc:NmAndId/Doc:Id/Doc:DmstAcct/Doc:Id"/></seller_account_id>
      	</xsl:when>
   	</xsl:choose>
   </xsl:template>
   
   
   <!-- Inco Terms -->
    <xsl:template match="Doc:Incotrms">
    	<incoterm>
			<!--inco_term_id></inco_term_id-->
			<xsl:choose>
				<xsl:when test="Doc:Cd[.!='']"><code><xsl:value-of select="Doc:Cd"/></code></xsl:when>
				<xsl:otherwise><other><xsl:value-of select="Doc:Othr"/></other></xsl:otherwise>
			</xsl:choose>
			<location><xsl:value-of select="Doc:Lctn"/></location>
		</incoterm>
    </xsl:template>
    
    <!-- Adjustments -->
    <xsl:template match="Doc:Adjstmnt">
    	<allowance>
			<!--allowance_id></allowance_id-->
			<allowance_type>02</allowance_type>
			<xsl:choose>
				<xsl:when test="Doc:Tp[.!='']"><type><xsl:value-of select="Doc:Tp"/></type></xsl:when>
				<xsl:otherwise><other_type><xsl:value-of select="Doc:OthrAdjstmntTp"/></other_type></xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="Doc:Amt[.!='']">
					<amt>
   					<xsl:call-template name="TP_amount">
      					<xsl:with-param name="amount"><xsl:value-of select="Doc:Amt"/></xsl:with-param>
      				</xsl:call-template>
      			</amt>
      			<cur_code><xsl:value-of select="Doc:Amt/@Ccy"/></cur_code>
      		</xsl:when>
      		<xsl:otherwise><rate><xsl:value-of select="Doc:Rate"/></rate></xsl:otherwise>
      	</xsl:choose>
      	<xsl:if test="Doc:Drctn[. != '']">
			<direction><xsl:value-of select="Doc:Drctn"/></direction>
		</xsl:if>
		</allowance>
    </xsl:template>
    
    <!-- Freight Charges -->
    <xsl:template match="Doc:Chrgs">
    	<allowance>
			<!--allowance_id></allowance_id-->
			<allowance_type>03</allowance_type>
			<xsl:choose>
				<xsl:when test="Doc:Tp[.!='']"><type><xsl:value-of select="Doc:Tp"/></type></xsl:when>
				<xsl:otherwise><other_type><xsl:value-of select="Doc:OthrChrgsTp"/></other_type></xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="Doc:Amt[.!='']">
					<amt>
   					<xsl:call-template name="TP_amount">
      					<xsl:with-param name="amount"><xsl:value-of select="Doc:Amt"/></xsl:with-param>
      				</xsl:call-template>
      			</amt>
      			<cur_code><xsl:value-of select="Doc:Amt/@Ccy"/></cur_code>
      		</xsl:when>
      		<xsl:otherwise><rate><xsl:value-of select="Doc:Rate"/></rate></xsl:otherwise>
      	</xsl:choose>
			<xsl:if test="direction[. != '']">
				<direction><xsl:value-of select="Doc:Drctn"/></direction>
			</xsl:if>
		</allowance>
    </xsl:template>
    
	<!-- Taxes -->
   <xsl:template match="Doc:Tax">
    	<allowance>
   		<!--allowance_id></allowance_id-->
   		<allowance_type>01</allowance_type>
   		<xsl:choose>
				<xsl:when test="Doc:Tp[.!='']"><type><xsl:value-of select="Doc:Tp"/></type></xsl:when>
				<xsl:otherwise><other_type><xsl:value-of select="Doc:OthrTaxTp"/></other_type></xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="Doc:Amt[.!='']">
					<amt>
   					<xsl:call-template name="TP_amount">
      					<xsl:with-param name="amount"><xsl:value-of select="Doc:Amt"/></xsl:with-param>
      				</xsl:call-template>
      			</amt>
      			<cur_code><xsl:value-of select="Doc:Amt/@Ccy"/></cur_code>
      		</xsl:when>
      		<xsl:otherwise><rate><xsl:value-of select="Doc:Rate"/></rate></xsl:otherwise>
      	</xsl:choose>
   		<xsl:if test="direction[. != '']">
				<direction><xsl:value-of select="Doc:Drctn"/></direction>
			</xsl:if>
   	</allowance>
    </xsl:template>

   <!-- Payment Terms -->
 	<xsl:template match="Doc:PmtTerms">
    	<payment>
   		<!--payment_id></payment_id-->
   		<xsl:choose>
   			<xsl:when test="Doc:PmtCd/Doc:Cd">
   				<code><xsl:value-of select="Doc:PmtCd/Doc:Cd"/></code>
   			</xsl:when>
   			<xsl:when test="Doc:OthrPmtTerms">
   				<other_paymt_terms><xsl:value-of select="Doc:OthrPmtTerms"/></other_paymt_terms>
   			</xsl:when>
   		</xsl:choose>
   		<nb_days><xsl:value-of select="Doc:PmtCd/Doc:NbOfDays"/></nb_days>
   		<amt>
   			<xsl:call-template name="TP_amount">
      			<xsl:with-param name="amount"><xsl:value-of select="Doc:Amt"/></xsl:with-param>
      		</xsl:call-template>
      	</amt>
   		<cur_code><xsl:value-of select="Doc:Amt/@Ccy"/></cur_code>
   		<pct><xsl:value-of select="Doc:Pctg"/></pct>
   	</payment>
    </xsl:template>
    
   <!-- User Informations -->
 	<xsl:template match="Doc:BuyrDfndInf">
    	<user_defined_information>
   		<!--user_info_id></user_info_id-->
   		<type>01</type>
   		<label><xsl:value-of select="Doc:Labl"/></label>
   		<information><xsl:value-of select="Doc:Inf"/></information>
   	</user_defined_information>
    </xsl:template>
    
 	<xsl:template match="Doc:SellrDfndInf">
    	<user_defined_information>
   		<!--user_info_id></user_info_id-->
   		<type>02</type>
   		<label><xsl:value-of select="Doc:Labl"/></label>
   		<information><xsl:value-of select="Doc:Inf"/></information>
   	</user_defined_information>
    </xsl:template>
    
    <!-- Line Items -->
    <xsl:template match="Doc:LineItmDtls">
    	<lt_tnx_record>
			<cust_ref_id><xsl:value-of select="Doc:LineItmId"/></cust_ref_id>
			<product_code>LT</product_code>
			<tnx_cur_code><xsl:value-of select="Doc:TtlAmt/@Ccy"/></tnx_cur_code>
			<tnx_amt>
				<xsl:call-template name="TP_amount">
      				<xsl:with-param name="amount"><xsl:value-of select="Doc:TtlAmt"/></xsl:with-param>
      			</xsl:call-template>
			</tnx_amt>
			<line_item_number><xsl:value-of select="Doc:LineItmId"/></line_item_number>
			<xsl:if test="Doc:Qty/Doc:UnitOfMeasrCd">
				<qty_unit_measr_code><xsl:value-of select="Doc:Qty/Doc:UnitOfMeasrCd"/></qty_unit_measr_code>
			</xsl:if>
			<qty_other_unit_measr><xsl:value-of select="Doc:Qty/Doc:OthrUnitOfMeasr"/></qty_other_unit_measr>
			<qty_val><xsl:value-of select="Doc:Qty/Doc:Val"/></qty_val>
			<xsl:if test="Doc:Qty/Doc:Fctr">
				<qty_factor><xsl:value-of select="Doc:Qty/Doc:Fctr"/></qty_factor>
			</xsl:if>
			<xsl:if test="Doc:QtyTlrnce/Doc:PlusPct">
				<qty_tol_pstv_pct><xsl:value-of select="Doc:QtyTlrnce/Doc:PlusPct"/></qty_tol_pstv_pct>
			</xsl:if>
			<xsl:if test="Doc:QtyTlrnce/Doc:MnsPct">
				<qty_tol_neg_pct><xsl:value-of select="Doc:QtyTlrnce/Doc:MnsPct"/></qty_tol_neg_pct>
			</xsl:if>
			<xsl:if test="Doc:UnitPric/Doc:UnitOfMeasrCd">
				<price_unit_measr_code><xsl:value-of select="Doc:UnitPric/Doc:UnitOfMeasrCd"/></price_unit_measr_code>
			</xsl:if>
			<price_other_unit_measr><xsl:value-of select="Doc:UnitPric/Doc:OthrUnitOfMeasr"/></price_other_unit_measr>
			<price_amt>
				<xsl:call-template name="TP_amount">
      			<xsl:with-param name="amount"><xsl:value-of select="Doc:UnitPric/Doc:Amt"/></xsl:with-param>
      		</xsl:call-template>
			</price_amt>
			<price_cur_code><xsl:value-of select="Doc:UnitPric/Doc:Amt/@Ccy"/></price_cur_code>
			<xsl:if test="Doc:UnitPric/Doc:Fctr">
				<price_factor><xsl:value-of select="Doc:UnitPric/Doc:Fctr"/></price_factor>
			</xsl:if>
			<xsl:if test="Doc:PricTlrnce/Doc:PlusPct">
				<price_tol_pstv_pct><xsl:value-of select="Doc:PricTlrnce/Doc:PlusPct"/></price_tol_pstv_pct>
			</xsl:if>
			<xsl:if test="Doc:PricTlrnce/Doc:MnsPct">
				<price_tol_neg_pct><xsl:value-of select="Doc:PricTlrnce/Doc:MnsPct"/></price_tol_neg_pct>
			</xsl:if>
			<xsl:if test="Doc:PdctNm">
				<product_name><xsl:value-of select="Doc:PdctNm"/></product_name>
			</xsl:if>
			<xsl:if test="Doc:PdctOrgn">
				<product_orgn><xsl:value-of select="Doc:PdctOrgn"/></product_orgn>
			</xsl:if>
			<xsl:if test="Doc:LatstShipmntDt">
	   			<last_ship_date>
	   				<xsl:call-template name="ISODate2TP">
	      				<xsl:with-param name="date"><xsl:value-of select="Doc:LatstShipmntDt"/></xsl:with-param>
	      			</xsl:call-template>
	      		</last_ship_date>
      		</xsl:if>
      		<!-- Compute line item total_amt ( = Qty * UnitPric/Amt) since only the total net amount is available in the TSU message (Doc:TtlAmt) -->
			<total_amt>
				<xsl:value-of select="format-number(Doc:UnitPric/Doc:Amt,'##################.#####') * format-number(Doc:Qty/Doc:Val,'##################.#####')"/>
			</total_amt>
			<total_cur_code><xsl:value-of select="Doc:TtlAmt/@Ccy"/></total_cur_code>
			<total_net_amt>
				<xsl:call-template name="TP_amount">
      				<xsl:with-param name="amount"><xsl:value-of select="Doc:TtlAmt"/></xsl:with-param>
      			</xsl:call-template>
      		</total_net_amt>
			<total_net_cur_code><xsl:value-of select="Doc:TtlAmt/@Ccy"/></total_net_cur_code>
			
			<!--order_total_amt/>
			<order_total_cur_code/>
			<order_total_net_amt/>
			<order_total_net_cur_code/-->
			
			<!--accepted_total_amt/>
			<accepted_total_cur_code/>
			<accepted_total_net_amt/>
			<accepted_total_net_cur_code/-->
			
			<!--liab_total_amt/>
			<liab_total_cur_code/>
			<liab_total_net_amt/>
			<liab_total_net_cur_code/-->
			
			<!-- Inco Terms -->
			<incoterms>
				<xsl:apply-templates select="Doc:Incotrms"/>
			</incoterms>
      	
			<!-- Adjustments -->
			<adjustments>
				<xsl:apply-templates select="Doc:Adjstmnt"/>
			</adjustments>
      	
			<!-- Taxes -->
			<taxes>
				<xsl:apply-templates select="Doc:Tax"/>
			</taxes>

			<!-- Freight Charges -->
			<freight_charges>
				<xsl:apply-templates select="Doc:FrghtChrgs/Doc:Chrgs"/>
			</freight_charges>
      	
			<!-- Goods definition -->
			<xsl:if test="Doc:PdctIdr">
				<product_identifiers>
					<xsl:apply-templates select="Doc:PdctIdr"/>
				</product_identifiers>
			</xsl:if>
      	
			<xsl:if test="Doc:PdctCtgy">
				<product_categories>
					<xsl:apply-templates select="Doc:PdctCtgy"/>
				</product_categories>
			</xsl:if>
      	
			<xsl:if test="Doc:PdctChrtcs">
				<product_characteristics>
					<xsl:apply-templates select="Doc:PdctChrtcs"/>
				</product_characteristics>
			</xsl:if>
			
			<!-- Routing Summaries -->
			<xsl:if test="Doc:RtgSummry">
				<routing_summaries>
					<xsl:apply-templates select="Doc:RtgSummry"/>
				</routing_summaries>
			</xsl:if>
      	
		</lt_tnx_record>
    </xsl:template>
    
    <!-- Goods definition -->
    <!-- Product Identifier-->
    <xsl:template match="Doc:PdctIdr">
    	<product_identifier>
   		<!--goods_id></goods_id-->
   		<goods_type>01</goods_type>
   		<goods_sub_type><xsl:value-of select="Doc:Inf"/></goods_sub_type>
   		<type><xsl:value-of select="Doc:StrdPdctIdr/Doc:Tp"/></type>
   		<other_type><xsl:value-of select="Doc:OthrPdctIdr/Doc:IdTp"/></other_type>
   		<identifier>
      		<xsl:choose>
      			<xsl:when test="Doc:StrdPdctIdr/Doc:Tp"><xsl:value-of select="Doc:StrdPdctIdr/Doc:Idr"/></xsl:when>
      			<xsl:when test="Doc:OthrPdctIdr/Doc:Id"><xsl:value-of select="Doc:OthrPdctIdr/Doc:IdTp"/></xsl:when>
      		</xsl:choose>
   		</identifier>
   		<characteristic/>
   		<category/>
   	</product_identifier>
    </xsl:template>
    
    <!-- Product Characteristic-->
    <xsl:template match="Doc:PdctChrtcs">
    	<product_characteristic>
   		<!--goods_id></goods_id-->
   		<goods_type>03</goods_type>
   		<goods_sub_type><xsl:value-of select="Doc:Inf"/></goods_sub_type>
   		<type><xsl:value-of select="Doc:StrdPdctChrtcs/Doc:Tp"/></type>
   		<other_type><xsl:value-of select="Doc:OthrPdctChrtcs/Doc:IdTp"/></other_type>
   		<identifier/>
   		<characteristic>
      		<xsl:choose>
      			<xsl:when test="Doc:StrdPdctChrtcs/Doc:Tp"><xsl:value-of select="Doc:StrdPdctChrtcs/Doc:Chrtcs"/></xsl:when>
      			<xsl:when test="Doc:OthrPdctChrtcs/Doc:Id"><xsl:value-of select="Doc:OthrPdctChrtcs/Doc:IdTp"/></xsl:when>
      		</xsl:choose>
      	</characteristic>
   		<category/>
   	</product_characteristic>
    </xsl:template>
    
    <!-- Product Category-->
    <xsl:template match="Doc:PdctCtgy">
    	<product_category>
   		<!--goods_id></goods_id-->
   		<goods_type>02</goods_type>
   		<goods_sub_type><xsl:value-of select="Doc:Inf"/></goods_sub_type>
   		<type><xsl:value-of select="Doc:StrdPdctCtgy/Doc:Tp"/></type>
   		<other_type><xsl:value-of select="Doc:StrdPdctCtgy/Doc:IdTp"/></other_type>
   		<identifier/>
   		<characteristic/>
   		<category>
      		<xsl:choose>
      			<xsl:when test="Doc:StrdPdctCtgy/Doc:Tp"><xsl:value-of select="Doc:StrdPdctCtgy/Doc:Ctgy"/></xsl:when>
      			<xsl:when test="Doc:OthrPdctCtgy/Doc:Id"><xsl:value-of select="Doc:OthrPdctCtgy/Doc:IdTp"/></xsl:when>
      		</xsl:choose>
      	</category>
   	</product_category>
    </xsl:template>
    
    <!-- Contacts -->
    <xsl:template match="Doc:BuyrCtctPrsn | Doc:SellrCtctPrsn | Doc:BuyrBkCtctPrsn | Doc:SellrBkCtctPrsn | Doc:BllToCtctPrsn | Doc:ShipToCtctPrsn | Doc:ConsgnCtctPrsn">
    	<xsl:param name="type"/>
    	<contact>
       	<!--ctcprsn_id-->
			<type><xsl:value-of select="$type"/></type>		
			<name><xsl:value-of select="Doc:Nm"/></name>
			<name_prefix><xsl:value-of select="Doc:NmPrfx"/></name_prefix>
			<given_name><xsl:value-of select="Doc:GvnNm"/></given_name>
			<role><xsl:value-of select="Doc:Role"/></role>
			<phone_number><xsl:value-of select="Doc:PhoneNb"/></phone_number>
			<fax_number><xsl:value-of select="Doc:FaxNb"/></fax_number>
			<email><xsl:value-of select="Doc:EmailAdr"/></email>
    	</contact>
    </xsl:template>	
	
	<!-- Routing Summary -->
	<xsl:template match="Doc:RtgSummry">
		<xsl:choose>
			<xsl:when test="Doc:IndvTrnsprt">
					<!-- Transport By Air -->
					<xsl:apply-templates select="Doc:IndvTrnsprt/Doc:TrnsprtByAir">
						<xsl:with-param name="transportType">01</xsl:with-param>
					</xsl:apply-templates>

					<!-- Transport By Sea -->
					<xsl:apply-templates select="Doc:IndvTrnsprt/Doc:TrnsprtBySea">
						<xsl:with-param name="transportType">01</xsl:with-param>
					</xsl:apply-templates>

					<!-- Transport By Road -->
					<xsl:apply-templates select="Doc:IndvTrnsprt/Doc:TrnsprtByRoad">
						<xsl:with-param name="transportType">01</xsl:with-param>
					</xsl:apply-templates>

					<!-- Transport By Rail -->
					<xsl:apply-templates select="Doc:IndvTrnsprt/Doc:TrnsprtByRail">
						<xsl:with-param name="transportType">01</xsl:with-param>
					</xsl:apply-templates>
			</xsl:when>
			<xsl:when test="Doc:MltmdlTrnsprt">

					<!-- Departure Airport -->
					<xsl:apply-templates select="Doc:MltmdlTrnsprt/Doc:DprtureAirprt">
						<xsl:with-param name="transportType">02</xsl:with-param>
						<xsl:with-param name="transportSubType">01</xsl:with-param>
						<xsl:with-param name="transportMode">01</xsl:with-param>
					</xsl:apply-templates>

					<!-- Destination Airport -->
					<xsl:apply-templates select="Doc:MltmdlTrnsprt/Doc:DstnAirprt">
						<xsl:with-param name="transportType">02</xsl:with-param>
						<xsl:with-param name="transportSubType">02</xsl:with-param>
						<xsl:with-param name="transportMode">01</xsl:with-param>
					</xsl:apply-templates>

					<!-- Port of Loading -->
					<xsl:apply-templates select="Doc:MltmdlTrnsprt/Doc:PortOfLoadng">
						<xsl:with-param name="transportType">02</xsl:with-param>
						<xsl:with-param name="transportSubType">01</xsl:with-param>
						<xsl:with-param name="transportMode">02</xsl:with-param>
					</xsl:apply-templates>

					<!-- Port of Discharge -->
					<xsl:apply-templates select="Doc:MltmdlTrnsprt/Doc:PortOfDschrge">
						<xsl:with-param name="transportType">02</xsl:with-param>
						<xsl:with-param name="transportSubType">02</xsl:with-param>
						<xsl:with-param name="transportMode">02</xsl:with-param>
					</xsl:apply-templates>

					<!-- Place of Receipt -->
					<xsl:apply-templates select="Doc:MltmdlTrnsprt/Doc:PlcOfRct">
						<xsl:with-param name="transportType">02</xsl:with-param>
						<xsl:with-param name="transportSubType">01</xsl:with-param>
						<xsl:with-param name="transportMode"></xsl:with-param>
					</xsl:apply-templates>

					<!-- Place of Delivery -->
					<xsl:apply-templates select="Doc:MltmdlTrnsprt/Doc:PlcOfDlvry">
						<xsl:with-param name="transportType">02</xsl:with-param>
						<xsl:with-param name="transportSubType">02</xsl:with-param>
						<xsl:with-param name="transportMode"></xsl:with-param>
					</xsl:apply-templates>

					<!-- Taking in Charge -->
					<xsl:apply-templates select="Doc:MltmdlTrnsprt/Doc:TakngInChrg">
						<xsl:with-param name="transportType">02</xsl:with-param>
						<xsl:with-param name="transportSubType"></xsl:with-param>
						<xsl:with-param name="transportMode"></xsl:with-param>
					</xsl:apply-templates>

					<!-- Place of Final Destination -->
					<xsl:apply-templates select="Doc:MltmdlTrnsprt/Doc:PlcOfFnlDstn">
						<xsl:with-param name="transportType">02</xsl:with-param>
						<xsl:with-param name="transportSubType"></xsl:with-param>
						<xsl:with-param name="transportMode"></xsl:with-param>
					</xsl:apply-templates>

			</xsl:when>
		</xsl:choose>
	</xsl:template>
	
	
	<xsl:template match="Doc:TrnsprtByAir">
		<xsl:param name="transportType"/>
		<xsl:variable name="position" select="position()"/>		

		<xsl:apply-templates select="Doc:DprtureAirprt">
			<xsl:with-param name="transportType"><xsl:value-of select="$transportType"/></xsl:with-param>
			<xsl:with-param name="transportSubType">01</xsl:with-param>
			<xsl:with-param name="transportMode">01</xsl:with-param>
			<xsl:with-param name="transportGroup"><xsl:value-of select="$position"/></xsl:with-param>
		</xsl:apply-templates>
	
		<xsl:apply-templates select="Doc:DstnAirprt">
			<xsl:with-param name="transportType"><xsl:value-of select="$transportType"/></xsl:with-param>
			<xsl:with-param name="transportSubType">02</xsl:with-param>
			<xsl:with-param name="transportMode">01</xsl:with-param>
			<xsl:with-param name="transportGroup"><xsl:value-of select="$position"/></xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template match="Doc:TrnsprtBySea">
		<xsl:param name="transportType"/>
		<xsl:variable name="position" select="position()"/>		

		<xsl:apply-templates select="Doc:PortOfLoadng">
			<xsl:with-param name="transportType"><xsl:value-of select="$transportType"/></xsl:with-param>
			<xsl:with-param name="transportSubType">01</xsl:with-param>
			<xsl:with-param name="transportMode">02</xsl:with-param>
			<xsl:with-param name="transportGroup"><xsl:value-of select="$position"/></xsl:with-param>
		</xsl:apply-templates>
	
		<xsl:apply-templates select="Doc:PortOfDschrge">
			<xsl:with-param name="transportType"><xsl:value-of select="$transportType"/></xsl:with-param>
			<xsl:with-param name="transportSubType">02</xsl:with-param>
			<xsl:with-param name="transportMode">02</xsl:with-param>
			<xsl:with-param name="transportGroup"><xsl:value-of select="$position"/></xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template match="Doc:TrnsprtByRoad">
		<xsl:param name="transportType"/>
		<xsl:variable name="position" select="position()"/>		

		<xsl:apply-templates select="Doc:PlcOfRct">
			<xsl:with-param name="transportType"><xsl:value-of select="$transportType"/></xsl:with-param>
			<xsl:with-param name="transportSubType">01</xsl:with-param>
			<xsl:with-param name="transportMode">03</xsl:with-param>
			<xsl:with-param name="transportGroup"><xsl:value-of select="$position"/></xsl:with-param>
		</xsl:apply-templates>
	
		<xsl:apply-templates select="Doc:PlcOfDlvry">
			<xsl:with-param name="transportType"><xsl:value-of select="$transportType"/></xsl:with-param>
			<xsl:with-param name="transportSubType">02</xsl:with-param>
			<xsl:with-param name="transportMode">03</xsl:with-param>
			<xsl:with-param name="transportGroup"><xsl:value-of select="$position"/></xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template match="Doc:TrnsprtByRail">
		<xsl:param name="transportType"/>
		<xsl:variable name="position" select="position()"/>

		<xsl:apply-templates select="Doc:PlcOfRct">
			<xsl:with-param name="transportType"><xsl:value-of select="$transportType"/></xsl:with-param>
			<xsl:with-param name="transportSubType">01</xsl:with-param>
			<xsl:with-param name="transportMode">04</xsl:with-param>
			<xsl:with-param name="transportGroup"><xsl:value-of select="$position"/></xsl:with-param>
		</xsl:apply-templates>
	
		<xsl:apply-templates select="Doc:PlcOfDlvry">
			<xsl:with-param name="transportType"><xsl:value-of select="$transportType"/></xsl:with-param>
			<xsl:with-param name="transportSubType">02</xsl:with-param>
			<xsl:with-param name="transportMode">04</xsl:with-param>
			<xsl:with-param name="transportGroup"><xsl:value-of select="$position"/></xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>



	<xsl:template match="Doc:DprtureAirprt | Doc:DstnAirprt | 
						Doc:PortOfLoadng | Doc:PortOfDschrge | 
						Doc:PlcOfRct | Doc:PlcOfDlvry | 
						Doc:TakngInChrg | Doc:PlcOfFnlDstn">
		<xsl:param name="transportType"/>
		<xsl:param name="transportSubType"/>
		<xsl:param name="transportMode"/>
		<xsl:param name="transportGroup"/>
		
		<routing_summary>
			<xsl:if test="$transportMode != ''">
				<transport_mode><xsl:value-of select="$transportMode"/></transport_mode>
			</xsl:if>
			<transport_type><xsl:value-of select="$transportType"/></transport_type>
			<xsl:if test="$transportGroup != ''">
				<transport_group><xsl:value-of select="$transportGroup"/></transport_group>
			</xsl:if>
			<xsl:if test="$transportSubType != ''">
				<transport_sub_type><xsl:value-of select="$transportSubType"/></transport_sub_type>
			</xsl:if>
			
			<xsl:choose>
				<xsl:when test="local-name() = 'DprtureAirprt'">
					<xsl:choose>
						<xsl:when test="Doc:AirprtCd">
							<airport_loading_code><xsl:value-of select="Doc:AirprtCd"/></airport_loading_code>
						</xsl:when>
						<xsl:otherwise>
							<airport_loading_name><xsl:value-of select="Doc:OthrAirprtDesc/Doc:AirprtNm"/></airport_loading_name>
							<town_loading><xsl:value-of select="Doc:OthrAirprtDesc/Doc:Twn"/></town_loading>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="local-name() = 'DstnAirprt'">
					<xsl:choose>
						<xsl:when test="Doc:AirprtCd">
							<airport_loading_code><xsl:value-of select="Doc:AirprtCd"/></airport_loading_code>
						</xsl:when>
						<xsl:otherwise>
							<airport_discharge_name><xsl:value-of select="Doc:OthrAirprtDesc/Doc:AirprtNm"/></airport_discharge_name>
							<town_discharge><xsl:value-of select="Doc:OthrAirprtDesc/Doc:Twn"/></town_discharge>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="local-name() = 'PortOfLoadng'">
					<port_loading><xsl:value-of select="."/></port_loading>
				</xsl:when>
				<xsl:when test="local-name() = 'PortOfDschrge'">
					<port_discharge><xsl:value-of select="."/></port_discharge>
				</xsl:when>
				<xsl:when test="local-name() = 'PlcOfRct'">
					<place_receipt><xsl:value-of select="."/></place_receipt>
				</xsl:when>
				<xsl:when test="local-name() = 'PlcOfDlvry'">
					<place_delivery><xsl:value-of select="."/></place_delivery>
				</xsl:when>
				<xsl:when test="local-name() = 'TakngInChrg'">
					<taking_in_charge><xsl:value-of select="."/></taking_in_charge>
				</xsl:when>
				<xsl:when test="local-name() = 'PlcOfFnlDstn'">
					<place_final_dest><xsl:value-of select="."/></place_final_dest>
				</xsl:when>
			</xsl:choose>
		</routing_summary>
	</xsl:template>
	
</xsl:stylesheet>