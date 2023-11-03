<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tools="xalan://com.misys.portal.tsu.util.common.Tools"
	exclude-result-prefixes="tools">
	
	<xsl:output method="xml"/>
	
	<xsl:param name="tnxId"/>
	<xsl:param name="serviceCode"/>
	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>
	
	<!-- Match template -->
	<xsl:template match="ea_tnx_record">
	<Document>
		<InitlBaselnSubmissn>
			<SubmissnId>
				<Id><xsl:value-of select="$tnxId"/></Id>
				<CreDtTm><xsl:value-of select="tools:getCurrentTMAFormatDateTime()"/></CreDtTm>
			</SubmissnId>
			<SubmitrTxRef>
				<Id><xsl:value-of select="$tnxId"/></Id>
			</SubmitrTxRef>
			<Instr>FPTR</Instr>
			<!-- Actual baseline details -->
			<Baseln>
				<SubmitrBaselnId>
					<Id><xsl:value-of select="$tnxId"/></Id>
					<Vrsn>1</Vrsn>
					<Submitr>
						<BIC><xsl:value-of select="buyer_bank_bic"/></BIC>
					</Submitr>
				</SubmitrBaselnId>
				<!-- Externalize this to portal.properties -->
				<SvcCd><xsl:value-of select="$serviceCode"/></SvcCd>
				<PurchsOrdrRef>
					<Id><xsl:value-of select="po_ref_id"/></Id>
					<DtOfIsse><xsl:value-of select="tools:getCurrentTMAFormatDateTime()"/></DtOfIsse>
				</PurchsOrdrRef>
				<!-- Buyer details start -->
				<Buyr>
					<Nm><xsl:value-of select="buyer_abbv_name"/></Nm>
					<!-- TODO:: what need to be added (?)ProprietaryIdentification need to be added relation(0..1) -->
					<PstlAdr>
						<xsl:if test="buyer_street_name">
							<StrtNm><xsl:value-of select="buyer_street_name"/></StrtNm>
						</xsl:if>
					<!-- TODO:: correct mapping? PostCodeIdentification <PstCdId> -->
						<xsl:if test="buyer_post_code">
							<PstCdId><xsl:value-of select="buyer_post_code"/></PstCdId>
						</xsl:if>
						<xsl:if test="buyer_town_name">
							<TwnNm><xsl:value-of select="buyer_town_name"/></TwnNm>
						</xsl:if>
						<xsl:if test="buyer_country_sub_div">
							<CtrySubDvsn><xsl:value-of select="buyer_country_sub_div"/></CtrySubDvsn>
						</xsl:if>
						<Ctry><xsl:value-of select="buyer_country"/></Ctry>
					</PstlAdr>
				</Buyr>
				<!-- Buyer details end -->
				
				<!-- Seller details start -->
				<Sellr>
					<Nm><xsl:value-of select="seller_abbv_name"/></Nm>
					<!-- what need to be added (?)ProprietaryIdentification need to be added relation(0..1) -->
					<PstlAdr>
						<xsl:if test="seller_street_name">
							<StrtNm><xsl:value-of select="seller_street_name"/></StrtNm>
						</xsl:if>
					<!-- correct mapping? PostCodeIdentification <PstCdId> -->
						<xsl:if test="seller_post_code">
							<PstCdId><xsl:value-of select="seller_post_code"/></PstCdId>
						</xsl:if>
						<xsl:if test="seller_town_name">
							<TwnNm><xsl:value-of select="seller_town_name"/></TwnNm>
						</xsl:if>
						<xsl:if test="seller_country_sub_div">
							<CtrySubDvsn><xsl:value-of select="seller_country_sub_div"/></CtrySubDvsn>
						</xsl:if>
						<Ctry><xsl:value-of select="seller_country"/></Ctry>
					</PstlAdr>
				</Sellr>
				<!-- Seller details end -->
				
				<!-- Buyer bank- ? from where the value need to get-->
				<BuyrBk>
					<BIC><xsl:value-of select="buyer_bank_bic"/></BIC>
				</BuyrBk>
				<!-- Seller bank- ? from where the value need to get -->
				<SellrBk>
					<BIC><xsl:value-of select="seller_bank_bic"/></BIC>
				</SellrBk>
				<!-- ? check this need to be added BuyerSideSubmittingBank <BuyrSdSubmitgBk>0..* -->
				<!-- ? check this need to be added SellerSideSubmittingBank <SellrSdSubmitgBk>0..* -->
				<!-- BillTo <BllTo> (0..1)-->
				<!-- ShipTo <ShipTo> (0..1)-->
				<!-- Consignee <Consgn> (0..1) -->
				
				<!-- Goods -->
				<Goods>
					<PrtlShipmnt>
						<xsl:choose>
							<xsl:when test="part_ship[.='Y']">true</xsl:when>
							<xsl:otherwise>false</xsl:otherwise>
						</xsl:choose>
					</PrtlShipmnt>
					<!-- Line Items -->
					<xsl:apply-templates select="line_items/lt_tnx_record"/>
				</Goods>
				<PmtTerms>
					<xsl:apply-templates select="payments/payment"/>
				</PmtTerms>
				<xsl:if test="bank_payment_obligation/PmtOblgtn">
					<xsl:copy-of select="bank_payment_obligation/PmtOblgtn"/>
				</xsl:if>
				<xsl:if test="commercial_dataset/ComrclDataSetReqrd">
					<xsl:copy-of select="commercial_dataset/ComrclDataSetReqrd"/>
				</xsl:if>
				<xsl:if test="transport_dataset/TrnsprtDataSetReqrd">
					<xsl:copy-of select="transport_dataset/TrnsprtDataSetReqrd"/>
				</xsl:if>
				<xsl:if test="insurance_dataset/TrnsprtDataSetReqrd">
					<xsl:copy-of select="insurance_dataset/TrnsprtDataSetReqrd"/>
				</xsl:if>
				<xsl:if test="other_certificate_dataset/OthrCertDataSetReqrd">
					<xsl:copy-of select="other_certificate_dataset/OthrCertDataSetReqrd" />
				</xsl:if>
				<xsl:if test="certificate_dataset/CertDataSetReqrd">
					<xsl:copy-of select="certificate_dataset/CertDataSetReqrd" />
				</xsl:if>
				<xsl:apply-templates select="contacts/contact"/>
			</Baseln>
		</InitlBaselnSubmissn>
	</Document>
	</xsl:template>
	<!-- Line Items -->
	<xsl:template match="line_items/lt_tnx_record">
		<LineItmDtls>
			<LineItmId><xsl:value-of select="line_item_number"/></LineItmId>
			<Qty>
				<UnitOfMeasrCd><xsl:value-of select="qty_unit_measr_code"/></UnitOfMeasrCd>
				<Val><xsl:value-of select="qty_val"/></Val>
			</Qty>
			<TtlAmt>
			<xsl:attribute name="Ccy"><xsl:value-of select="total_cur_code"/></xsl:attribute>
			<xsl:value-of select="total_net_amt"/></TtlAmt>
		</LineItmDtls>
	</xsl:template>
	<!-- Payment Items -->
	<xsl:template match="payments/payment">
		<PmtCd><xsl:value-of select="code"/></PmtCd>
	</xsl:template>
	
	<!-- Contact Details -->
	<xsl:template match="contacts/contact">
		<xsl:if test="type[.='01']">
			<SellrCtctPrsn>
				<Nm><xsl:value-of select="name"/></Nm>
				<NmPrfx><xsl:value-of select="name_prefix"/></NmPrfx>
				<GvnNm><xsl:value-of select="given_name"/></GvnNm>
				<Role><xsl:value-of select="role"/></Role>
				<PhneNb><xsl:value-of select="phone_number"/></PhneNb>
				<FaxNb><xsl:value-of select="fax_number"/></FaxNb>
				<EmailAdr><xsl:value-of select="email"/></EmailAdr>
			</SellrCtctPrsn>		
		</xsl:if>
		<xsl:if test="type[.='02']">
			<BuyrCtctPrsn>
				<Nm><xsl:value-of select="name"/></Nm>
				<NmPrfx><xsl:value-of select="name_prefix"/></NmPrfx>
				<GvnNm><xsl:value-of select="given_name"/></GvnNm>
				<Role><xsl:value-of select="role"/></Role>
				<PhneNb><xsl:value-of select="phone_number"/></PhneNb>
				<FaxNb><xsl:value-of select="fax_number"/></FaxNb>
				<EmailAdr><xsl:value-of select="email"/></EmailAdr>
			</BuyrCtctPrsn>		
		</xsl:if>
		<xsl:if test="type[.='03']">
			<SellrBkCtctPrsn>
				<Nm><xsl:value-of select="name"/></Nm>
				<NmPrfx><xsl:value-of select="name_prefix"/></NmPrfx>
				<GvnNm><xsl:value-of select="given_name"/></GvnNm>
				<Role><xsl:value-of select="role"/></Role>
				<PhneNb><xsl:value-of select="phone_number"/></PhneNb>
				<FaxNb><xsl:value-of select="fax_number"/></FaxNb>
				<EmailAdr><xsl:value-of select="email"/></EmailAdr>
			</SellrBkCtctPrsn>		
		</xsl:if>
		<xsl:if test="type[.='04']">
			<BuyrBkCtctPrsn>
				<Nm><xsl:value-of select="name"/></Nm>
				<NmPrfx><xsl:value-of select="name_prefix"/></NmPrfx>
				<GvnNm><xsl:value-of select="given_name"/></GvnNm>
				<Role><xsl:value-of select="role"/></Role>
				<PhneNb><xsl:value-of select="phone_number"/></PhneNb>
				<FaxNb><xsl:value-of select="fax_number"/></FaxNb>
				<EmailAdr><xsl:value-of select="email"/></EmailAdr>
			</BuyrBkCtctPrsn>		
		</xsl:if>
		<xsl:if test="type[.='08']">
			<OthrBkCtctPrsn>
				<BIC><xsl:value-of select="bic"/></BIC>
				<Nm><xsl:value-of select="name"/></Nm>
				<NmPrfx><xsl:value-of select="name_prefix"/></NmPrfx>
				<GvnNm><xsl:value-of select="given_name"/></GvnNm>
				<Role><xsl:value-of select="role"/></Role>
				<PhneNb><xsl:value-of select="phone_number"/></PhneNb>
				<FaxNb><xsl:value-of select="fax_number"/></FaxNb>
				<EmailAdr><xsl:value-of select="email"/></EmailAdr>
			</OthrBkCtctPrsn>		
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>

