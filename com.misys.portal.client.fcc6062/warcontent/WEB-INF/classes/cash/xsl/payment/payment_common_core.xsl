<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
XSLT templates that are common to GPP Integration

Copyright (c) 2019-2020 Finastra (http://www.finastra.com),
All Rights Reserved. 

version:   1.0
date:      26/06/2019
author:    Avilash Ghosh
##########################################################
-->

<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:default="xalan://com.misys.portal.common.resources.DefaultResourceProvider" 
    xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools" 
    xmlns:jetSpeed="xalan://com.misys.portal.core.util.JetspeedResources"
    xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
    xmlns:technicalResource="xalan://com.misys.portal.common.resources.TechnicalResourceProvider"
    exclude-result-prefixes="default converttools jetSpeed utils technicalResource">
    
    <xsl:template name="initiation-context">
    	<id>
    		<xsl:if test = "ref_id">
				<xsl:value-of select="ref_id" />
			</xsl:if>
		</id>
		<subId></subId>
		<targetSchemeNm>
			<xsl:choose>
				<xsl:when test="sub_product_code[.='INT']">BOOK</xsl:when>
				<xsl:when test="sub_product_code[.='TPT']">BOOK</xsl:when>
				<xsl:when test="sub_product_code[.='MT103']">SWIFT</xsl:when>
				<xsl:when test="sub_product_code[.='RTGS']">CHATSHKD</xsl:when>
			</xsl:choose>
		</targetSchemeNm>
		<saveOnError></saveOnError>
		<sourceId>FCC</sourceId>
		<preCalculatedCharges>
			<xsl:call-template name="preCalculatedCharges"></xsl:call-template>
		</preCalculatedCharges>		
    </xsl:template>
    
    <xsl:template name="group-Header">
			<MsgId>
				<xsl:choose>
					<xsl:when test="bulk_ref_id[.!='']">
						<xsl:value-of select="bulk_ref_id" />
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="ref_id" />
					</xsl:otherwise>
				</xsl:choose>
			</MsgId>
			<CreDtTm><xsl:value-of select="utils:stringUTCDateTime(inp_dttm)" /></CreDtTm>
			<Authstn></Authstn>
			<Cd></Cd>
			<Prtry></Prtry>
			<NbOfTxs>01</NbOfTxs>
			<InitgPty>
				<xsl:call-template name="InitgPty"></xsl:call-template>
			</InitgPty>
    </xsl:template>
    
    <xsl:template name="PmtInf">
    	<PmtInfId><xsl:value-of select="tnx_id" /></PmtInfId>
		<PmtMtd>TRF</PmtMtd>
		<BtchBookg>FALSE</BtchBookg>
		<NbOfTxs>01</NbOfTxs>
		<CtrlSum></CtrlSum>
		<PmtTpInf>
			<xsl:call-template name="PmtTpInf"></xsl:call-template>
		</PmtTpInf>
		<ReqdExctnDt><xsl:value-of select="converttools:stringDateToIsoDateString(tnx_val_date)" /></ReqdExctnDt>
		<Dbtr>
			<xsl:call-template name="Dbtr"></xsl:call-template>
		</Dbtr>
		<DbtrAcct>
			<xsl:call-template name="DbtrAcct"></xsl:call-template>
		</DbtrAcct>
		<DbtrAgt>
			<xsl:call-template name="FinInstnId"></xsl:call-template>
		</DbtrAgt>
		<ChrgBr>
			<xsl:if test = "additional_field[@name='charge_option']">
	     		<xsl:value-of select="additional_field[@name='charge_option']" />
	   		</xsl:if>
		</ChrgBr>
		<CdtTrfTxInf>
			<PmtId>
				<InstrId>
					<xsl:value-of select="ref_id" />
				</InstrId>
				<EndToEndId>
					<xsl:value-of select="ref_id" />
				</EndToEndId>
			</PmtId>
			<xsl:if test = "additional_field[@name='fx_rates_type'] = '02'">
			<XchgRateInf>   
   				<CtrctId>
    				<xsl:value-of select="additional_field[@name='fx_contract_nbr_1']" />
   				</CtrctId>
			</XchgRateInf>
			</xsl:if>
			<Amt>
				<InstdAmt>
					<Amt>
						<xsl:value-of select="ft_amt" />
					</Amt>
					<Ccy>
						<xsl:value-of select="ft_cur_code" />
					</Ccy>
				</InstdAmt>
			</Amt>
			<ChrgBr>
			</ChrgBr>
			<IntrmyAgt1>
				<xsl:call-template name="IntrmyAgt1"></xsl:call-template>
			</IntrmyAgt1>
			<CdtrAgt>
				<xsl:call-template name="CdtrAgt"></xsl:call-template>
			</CdtrAgt>
			<Cdtr>
				<xsl:call-template name="Cdtr"></xsl:call-template>
			</Cdtr>
			<CdtrAcct>
				<xsl:call-template name="CdtrAcct"></xsl:call-template>
			</CdtrAcct>
		</CdtTrfTxInf>
    </xsl:template>
    
    <!-- InitgPty -->
     <xsl:template name="InitgPty">
     	<Nm><xsl:value-of select="issuing_bank/name" /></Nm>
		<PstlAdr>
			<xsl:call-template name="PstlAdr"></xsl:call-template>
		</PstlAdr>
		<Id>
			<xsl:call-template name="Id"></xsl:call-template>
		</Id>
		<CtryOfRes></CtryOfRes>
		<CtctDtls>
			<xsl:call-template name="CtctDtls"></xsl:call-template>
		</CtctDtls>
		<FwdgAgt>
			<xsl:call-template name="FwdgAgt"></xsl:call-template>
		</FwdgAgt>
     </xsl:template>
     
      <xsl:template name="DbtrAcct">
		<Id>
			<xsl:call-template name="IdDbtrAcct"></xsl:call-template>
		</Id>
		<Ccy></Ccy>
		<Nm></Nm>
     </xsl:template>
     
     <xsl:template name="Dbtr">
     	<Nm><xsl:value-of select="applicant_abbv_name" /></Nm>
		<PstlAdr>
			<xsl:call-template name="PstlAdrDbtr"></xsl:call-template>
		</PstlAdr>
		<Id>
			<xsl:call-template name="IdDbtr"></xsl:call-template>
		</Id>
		<CtryOfRes><xsl:value-of select="applicant_country" /></CtryOfRes>
		<CtctDtls>
			<xsl:call-template name="CtctDtlsDbtr"></xsl:call-template>
		</CtctDtls>
     </xsl:template>
     
       <xsl:template name="Cdtr">
     	<Nm><xsl:value-of select="counterparties/counterparty/counterparty_name" /></Nm>
		<PstlAdr>
			<xsl:choose>
				<xsl:when test="sub_product_code[.='INT']">
					<xsl:call-template name="PstlAdrDbtr"></xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="PstlAdrCdtr"></xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</PstlAdr>
		<Id>
			<xsl:call-template name="IdCdtr"></xsl:call-template>
		</Id>
		<CtryOfRes></CtryOfRes>
		<CtctDtls>
			<xsl:call-template name="CtctDtlsCdtr"></xsl:call-template>
		</CtctDtls>
     </xsl:template>
     
     <!-- Postal Address -->
     <xsl:template name="PstlAdr">
    	<AdrTp>ADDR</AdrTp>
		<Dept></Dept>
		<SubDept></SubDept>
		<StrtNm>
			<xsl:if test = "issuing_bank/address_line_1">
				<xsl:value-of select="issuing_bank/address_line_1" />
			</xsl:if>
		</StrtNm>
		<BldgNb>
			<xsl:if test = "issuing_bank/address_line_2">
				<xsl:value-of select="issuing_bank/address_line_2" />
			</xsl:if>
		</BldgNb>
		<PstCd></PstCd>
		<TwnNm>
			<xsl:if test = "issuing_bank/dom">
				<xsl:value-of select="issuing_bank/dom" />
			</xsl:if>
		</TwnNm>
		<CtrySubDvsn>
			<xsl:if test = "issuing_bank/address_line_4">
				<xsl:value-of select="issuing_bank/address_line_4" />
			</xsl:if>
		</CtrySubDvsn>
		<Ctry>
			<xsl:if test = "issuing_bank/country">
				<xsl:value-of select="issuing_bank/country" />
			</xsl:if>
		</Ctry>
		<AdrLine></AdrLine>
     </xsl:template>
     
      <!-- Id -->
     <xsl:template name="Id">
			 <OrgId>
				 <AnyBIC>
					 <xsl:if test = "issuing_bank/iso_code">
					 	<xsl:value-of select="issuing_bank/iso_code" />
					 </xsl:if>
				 </AnyBIC>
				 <Othr>
					 <Id></Id>
					 <SchmeNm>
						 <Cd></Cd>
						 <Prtry></Prtry>
					 </SchmeNm>
					 <Issr></Issr>
				 </Othr>
			 </OrgId>
			 <PrvtId>
				 <DtAndPlcOfBirth>
					 <BirthDt></BirthDt>
					 <PrvcOfBirth></PrvcOfBirth>
					 <CityOfBirth></CityOfBirth>
					 <CtryOfBirth></CtryOfBirth>
				 </DtAndPlcOfBirth>
				 <Othr>
					 <Id></Id>
					 <SchmeNm>
						 <Cd></Cd>
						 <Prtry></Prtry>
					 </SchmeNm>
					 <Issr></Issr>
				 </Othr>
			 </PrvtId>
     </xsl:template>
     
      <!-- Contact Details -->
     <xsl:template name="CtctDtls">
     	 <NmPrfx></NmPrfx>
     	 <Nm></Nm>
     	 <PhneNb>
     	 	<xsl:if test = "issuing_bank/phone">
				<xsl:value-of select="issuing_bank/phone" />
			</xsl:if>
		</PhneNb>
     	 <MobNb></MobNb>
     	 <FaxNb>
     	 	<xsl:if test = "issuing_bank/fax">
				<xsl:value-of select="issuing_bank/fax" />
			</xsl:if>
     	 </FaxNb>
	     <EmailAdr>
	     	<xsl:if test = "issuing_bank/email">
				<xsl:value-of select="issuing_bank/email" />
			</xsl:if>
	     </EmailAdr>
		 <Othr></Othr>
     </xsl:template>
     
      <!-- Forward Agent -->
     <xsl:template name="FwdgAgt">
		<FwdgAgt>
			<FinInstnId>
				<BICFI>
					<xsl:if test = "account_with_bank/iso_code">
						<xsl:value-of select="account_with_bank/iso_code" />
					</xsl:if>
				</BICFI>
				<ClrSysMmbId>
					<ClrSysId>
						<Cd></Cd>
						<Prtry></Prtry>
					</ClrSysId>
					<MmbId>
						<xsl:if test = "account_with_bank/abbv_name">
							<xsl:value-of select="account_with_bank/abbv_name" />
						</xsl:if>
					</MmbId>
				</ClrSysMmbId>
				<Nm></Nm>
				<PstlAdr>
					<AdrTp>ADDR</AdrTp>
					<Dept></Dept>
					<SubDept></SubDept>
					<StrtNm>
						<xsl:if test = "account_with_bank/address_line_1">
							<xsl:value-of select="account_with_bank/address_line_1" />
						</xsl:if>
					</StrtNm>
					<BldgNb>
						<xsl:if test = "account_with_bank/address_line_2">
							<xsl:value-of select="account_with_bank/address_line_2" />
						</xsl:if>
					</BldgNb>
					<PstCd></PstCd>
					<TwnNm>
						<xsl:if test = "account_with_bank/dom">
							<xsl:value-of select="account_with_bank/dom" />
						</xsl:if>
					</TwnNm>
					<CtrySubDvsn>
						<xsl:if test = "account_with_bank/address_line_4">
							<xsl:value-of select="account_with_bank/address_line_4" />
						</xsl:if>
					</CtrySubDvsn>
					<Ctry>
						<xsl:if test = "account_with_bank/country">
							<xsl:value-of select="account_with_bank/country" />
						</xsl:if>
					</Ctry>
					<AdrLine></AdrLine>
				</PstlAdr>
				<Othr>
					<Id></Id>
					<SchmeNm>
						<Cd></Cd>
						<Prtry></Prtry>
					</SchmeNm>
					<Issr></Issr>
				</Othr>
			</FinInstnId>
			<BrnchId>
				<Id></Id>
				<Nm></Nm>
				<PstlAdr>
					<AdrTp>ADDR</AdrTp>
					<Dept></Dept>
					<SubDept></SubDept>
					<StrtNm></StrtNm>
					<BldgNb></BldgNb>
					<PstCd></PstCd>
					<TwnNm></TwnNm>
					<CtrySubDvsn></CtrySubDvsn>
					<Ctry></Ctry>
					<AdrLine></AdrLine>
				</PstlAdr>
			</BrnchId>
		</FwdgAgt>
     </xsl:template>
     
     <xsl:template name="IntrmyAgt1">
			<FinInstnId>
				<BICFI>
					<xsl:if test = "additional_field[@name='intermediary_bank_swift_bic_code']">
			     		<xsl:value-of select="additional_field[@name='intermediary_bank_swift_bic_code']" />
			   		</xsl:if>
				</BICFI>
				<ClrSysMmbId>
					<ClrSysId>
						<Cd></Cd>
						<Prtry></Prtry>
					</ClrSysId>
					<MmbId></MmbId>
				</ClrSysMmbId>
				<Nm>
					<xsl:if test = "pay_through_bank/name">
						<xsl:value-of select="pay_through_bank/name" />
					</xsl:if>
				</Nm>
				<PstlAdr>
					<AdrTp>ADDR</AdrTp>
					<Dept></Dept>
					<SubDept></SubDept>
					<StrtNm>
						<xsl:if test = "pay_through_bank/address_line_1">
							<xsl:value-of select="pay_through_bank/address_line_1" />
						</xsl:if>
					</StrtNm>
					<BldgNb>
						<xsl:if test = "pay_through_bank/address_line_2">
							<xsl:value-of select="pay_through_bank/address_line_2" />
						</xsl:if>
					</BldgNb>
					<PstCd></PstCd>
					<TwnNm>
						<xsl:if test = "pay_through_bank/dom">
							<xsl:value-of select="pay_through_bank/dom" />
						</xsl:if>
					</TwnNm>
					<CtrySubDvsn></CtrySubDvsn>
					<Ctry>
						<xsl:if test = "pay_through_bank/country">
							<xsl:value-of select="pay_through_bank/country" />
						</xsl:if>
					</Ctry>
					<AdrLine></AdrLine>
				</PstlAdr>
				<Othr>
					<Id></Id>
					<SchmeNm>
						<Cd></Cd>
						<Prtry></Prtry>
					</SchmeNm>
					<Issr></Issr>
				</Othr>
			</FinInstnId>
			<BrnchId>
				<Id></Id>
				<Nm></Nm>
				<PstlAdr>
					<AdrTp>ADDR</AdrTp>
					<Dept></Dept>
					<SubDept></SubDept>
					<StrtNm>
						<xsl:if test = "pay_through_bank/name/address_line_1">
							<xsl:value-of select="pay_through_bank/name/address_line_1" />
						</xsl:if>
					</StrtNm>
					<BldgNb>
						<xsl:if test = "pay_through_bank/address_line_2">
							<xsl:value-of select="pay_through_bank/address_line_2" />
						</xsl:if>
					</BldgNb>
					<PstCd></PstCd>
					<TwnNm>
						<xsl:if test = "pay_through_bank/dom">
							<xsl:value-of select="pay_through_bank/dom" />
						</xsl:if>
					</TwnNm>
					<CtrySubDvsn></CtrySubDvsn>
					<Ctry>
						<xsl:if test = "pay_through_bank/country">
							<xsl:value-of select="pay_through_bank/country" />
						</xsl:if>
					</Ctry>
					<AdrLine></AdrLine>
				</PstlAdr>
			</BrnchId>
     </xsl:template>
     
     <!-- Postal Address -->
     <xsl:template name="PstlAdrDbtr">
    	<AdrTp>ADDR</AdrTp>
		<Dept></Dept>
		<SubDept></SubDept>
		<Ctry>
			<xsl:if test = "applicant_country">
				<xsl:value-of select="applicant_country" />
			</xsl:if>
		</Ctry>
		<AdrLine>
			<xsl:if test = "applicant_address_line_1">
				<xsl:value-of select="applicant_address_line_1" />
			</xsl:if>@<xsl:if test = "applicant_address_line_2">
				<xsl:value-of select="applicant_address_line_2" />
			</xsl:if>@<xsl:if test = "applicant_dom">
				<xsl:value-of select="applicant_dom" />
			</xsl:if>
		</AdrLine>
     </xsl:template>
     
      <!-- Id -->
     <xsl:template name="IdDbtr">
	     <Id>
			 <OrgId>
				 <AnyBIC></AnyBIC>
				 <Othr>
					 <Id></Id>
					 <SchmeNm>
						 <Cd></Cd>
						 <Prtry></Prtry>
					 </SchmeNm>
					 <Issr></Issr>
				 </Othr>
			 </OrgId>
			 <PrvtId>
				 <DtAndPlcOfBirth>
					 <BirthDt></BirthDt>
					 <PrvcOfBirth></PrvcOfBirth>
					 <CityOfBirth></CityOfBirth>
					 <CtryOfBirth></CtryOfBirth>
				 </DtAndPlcOfBirth>
				 <Othr>
					 <Id></Id>
					 <SchmeNm>
						 <Cd></Cd>
						 <Prtry></Prtry>
					 </SchmeNm>
					 <Issr></Issr>
				 </Othr>
			 </PrvtId>
		 </Id>
		 <Ccy></Ccy>
		 <Nm></Nm>
     </xsl:template>
     
     <!-- Id -->
     <xsl:template name="IdDbtrAcct">
	     <Id>
			 <IBAN></IBAN>
			 <Othr>
					 <Id>
						 <xsl:if test = "applicant_act_no">
							<xsl:value-of select="applicant_act_no" />
						</xsl:if>
					 </Id>
					 <SchmeNm>
						 <Cd></Cd>
						 <Prtry></Prtry>
					 </SchmeNm>
					 <Issr></Issr>
			 </Othr>
			 <Tp>
			 	<Cd></Cd>
			 	<Prtry></Prtry>
			 </Tp>
		 </Id>
     </xsl:template>
     
      <!-- Contact Details -->
     <xsl:template name="CtctDtlsDbtr">
     	 <NmPrfx></NmPrfx>
     	 <Nm></Nm>
     	 <PhneNb></PhneNb>
     	 <MobNb></MobNb>
     	 <FaxNb></FaxNb>
	     <EmailAdr></EmailAdr>
		 <Othr></Othr>
     </xsl:template>
     
      <xsl:template name="FinInstnId">
			<FinInstnId>
				<BICFI>
					<xsl:if test = "issuing_bank/iso_code">
						<xsl:value-of select="issuing_bank/iso_code" />
					</xsl:if>
				</BICFI>
				<ClrSysMmbId>
					<ClrSysId>
						<Cd></Cd>
						<Prtry></Prtry>
					</ClrSysId>
					<MmbId></MmbId>
				</ClrSysMmbId>
				<Nm><xsl:value-of select="issuing_bank/abbv_name" /></Nm>
				<PstlAdr>
					<AdrTp>ADDR</AdrTp>
					<Dept></Dept>
					<SubDept></SubDept>
					<StrtNm></StrtNm>
					<BldgNb></BldgNb>
					<PstCd></PstCd>
					<TwnNm></TwnNm>
					<CtrySubDvsn></CtrySubDvsn>
					<Ctry></Ctry>
					<AdrLine></AdrLine>
				</PstlAdr>
				<Othr>
					<Id></Id>
					<SchmeNm>
						<Cd></Cd>
						<Prtry></Prtry>
					</SchmeNm>
					<Issr></Issr>
				</Othr>
			</FinInstnId>
			<BrnchId>
				<Id></Id>
				<Nm></Nm>
				<PstlAdr>
					<AdrTp>ADDR</AdrTp>
					<Dept></Dept>
					<SubDept></SubDept>
					<StrtNm></StrtNm>
					<BldgNb></BldgNb>
					<PstCd></PstCd>
					<TwnNm></TwnNm>
					<CtrySubDvsn></CtrySubDvsn>
					<Ctry></Ctry>
					<AdrLine></AdrLine>
				</PstlAdr>
			</BrnchId>
     </xsl:template>
     
     <xsl:template name="CdtrAgt">
			<FinInstnId>
				<BICFI>
					<xsl:if test = "counterparties/counterparty/cpty_bank_swift_bic_code">
						<xsl:value-of select="counterparties/counterparty/cpty_bank_swift_bic_code" />
					</xsl:if>
				</BICFI>
				<ClrSysMmbId>
					<ClrSysId>
						<Cd></Cd>
						<Prtry></Prtry>
					</ClrSysId>
					<MmbId></MmbId>
				</ClrSysMmbId>
				<Nm><xsl:value-of select="counterparties/counterparty/cpty_bank_name" /></Nm>
				<PstlAdr>
					<AdrTp>ADDR</AdrTp>
					<Dept></Dept>
					<SubDept></SubDept>
					<StrtNm><xsl:value-of select="counterparties/counterparty/cpty_bank_address_line_1" /></StrtNm>
					<BldgNb><xsl:value-of select="counterparties/counterparty/cpty_bank_address_line_2" /></BldgNb>
					<PstCd></PstCd>
					<TwnNm><xsl:value-of select="counterparties/counterparty/cpty_bank_dom" /></TwnNm>
					<CtrySubDvsn></CtrySubDvsn>
					<Ctry><xsl:value-of select="counterparties/counterparty/cpty_bank_country" /></Ctry>
					<AdrLine></AdrLine>
				</PstlAdr>
				<Othr>
					<Id></Id>
					<SchmeNm>
						<Cd></Cd>
						<Prtry></Prtry>
					</SchmeNm>
					<Issr></Issr>
				</Othr>
			</FinInstnId>
			<BrnchId>
				<Id></Id>
				<Nm></Nm>
				<PstlAdr>
					<AdrTp>ADDR</AdrTp>
					<Dept></Dept>
					<SubDept></SubDept>
					<StrtNm><xsl:value-of select="counterparties/counterparty/cpty_bank_address_line_1" /></StrtNm>
					<BldgNb><xsl:value-of select="counterparties/counterparty/cpty_bank_address_line_2" /></BldgNb>
					<PstCd></PstCd>
					<TwnNm><xsl:value-of select="counterparties/counterparty/cpty_bank_dom" /></TwnNm>
					<CtrySubDvsn></CtrySubDvsn>
					<Ctry><xsl:value-of select="counterparties/counterparty/cpty_bank_country" /></Ctry>
					<AdrLine></AdrLine>
				</PstlAdr>
			</BrnchId>
     </xsl:template>
     
     <xsl:template name="PstlAdrCdtr">
    	<AdrTp></AdrTp>
		<Dept></Dept>
		<SubDept></SubDept>
		<Ctry></Ctry>
		<AdrLine>
			<xsl:value-of select="counterparties/counterparty/counterparty_address_line_1" />@<xsl:value-of select="counterparties/counterparty/counterparty_address_line_2" />@<xsl:value-of select="counterparties/counterparty/counterparty_dom" />
		</AdrLine>
     </xsl:template>
     
      <!-- Id -->
     <xsl:template name="IdCdtr">
			 <OrgId>
				 <AnyBIC></AnyBIC>
				 <Othr>
					 <Id></Id>
					 <SchmeNm>
						 <Cd></Cd>
						 <Prtry></Prtry>
					 </SchmeNm>
					 <Issr></Issr>
				 </Othr>
			 </OrgId>
			 <PrvtId>
				 <DtAndPlcOfBirth>
					 <BirthDt></BirthDt>
					 <PrvcOfBirth></PrvcOfBirth>
					 <CityOfBirth></CityOfBirth>
					 <CtryOfBirth></CtryOfBirth>
				 </DtAndPlcOfBirth>
				 <Othr>
					 <Id></Id>
					 <SchmeNm>
						 <Cd></Cd>
						 <Prtry></Prtry>
					 </SchmeNm>
					 <Issr></Issr>
				 </Othr>
			 </PrvtId>
     </xsl:template>
     
      <!-- Contact Details -->
     <xsl:template name="CtctDtlsCdtr">
     	 <NmPrfx></NmPrfx>
     	 <Nm></Nm>
     	 <PhneNb></PhneNb>
     	 <MobNb></MobNb>
     	 <FaxNb></FaxNb>
	     <EmailAdr></EmailAdr>
		 <Othr></Othr>
     </xsl:template>
     
     <xsl:template name="CdtrAcct">
	      <Id>
			 <IBAN></IBAN>
			 <Othr>
					 <Id>
						 <xsl:if test = "counterparties/counterparty/counterparty_act_no">
							<xsl:value-of select="counterparties/counterparty/counterparty_act_no" />
						</xsl:if>
					 </Id>
					 <SchmeNm>
						 <Cd></Cd>
						 <Prtry></Prtry>
					 </SchmeNm>
					 <Issr></Issr>
			 </Othr>
			 <Tp>
			 	<Cd></Cd>
			 	<Prtry></Prtry>
			 </Tp>
		 </Id>
		 <Ccy></Ccy>
		 <Nm></Nm>
     </xsl:template>
     
     
     <!-- Payment Tp Information -->
     <xsl:template name="PmtTpInf">
     	<InstrPrty></InstrPrty>
     	<SvcLvl>
	     	<Cd></Cd>
	     	<Prtry></Prtry>
     	</SvcLvl>
     	<LclInstrm>
     		<Cd></Cd>
	     	<Prtry></Prtry>
     	</LclInstrm>
     	<CtgyPurp>
     		<Cd></Cd>
	     	<Prtry></Prtry>
     	</CtgyPurp>
     </xsl:template>
     
     <xsl:template name="preCalculatedCharges">
     	<amount>0</amount>
		<currency><xsl:value-of select="ft_cur_code" /></currency>
		<suppressAdditionalCharges>false</suppressAdditionalCharges>
     </xsl:template>
       
</xsl:stylesheet>