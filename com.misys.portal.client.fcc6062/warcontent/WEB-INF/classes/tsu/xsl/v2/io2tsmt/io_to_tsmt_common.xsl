<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  
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
		<xsl:if test="type ='01'">
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
		<xsl:if test="type ='02'">
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
		<xsl:if test="type ='03'">
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
		<xsl:if test="type ='04'">
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
		<xsl:if test="type ='08'">
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
	
	<xsl:template match="product_identifier">
	  <PdctIdr>
	    <xsl:choose>
	      <xsl:when test="type != 'OTHR'">
	      	<StrdPdctIdr>
	        	<Tp><xsl:value-of select="type"/></Tp>
	        	<Idr><xsl:value-of select="identifier"/></Idr>
	        </StrdPdctIdr>
	      </xsl:when>
	      <xsl:otherwise>
	      	<OthrPdctIdr>
		        <Id><xsl:value-of select="other_type"/></Id>
		        <IdTp><xsl:value-of select="identifier"/></IdTp>
	        </OthrPdctIdr>
	      </xsl:otherwise>
	    </xsl:choose>
	  </PdctIdr>
	</xsl:template>
	
	<xsl:template match="product_characteristic">
	  <PdctChrtcs>
	    <xsl:choose>
	      <xsl:when test="type != 'OTHR'">
	      	<StrdPdctChrtcs>
		        <Tp><xsl:value-of select="type"/></Tp>
		        <Chrtcs><xsl:value-of select="characteristic"/></Chrtcs>
	        </StrdPdctChrtcs>
	      </xsl:when>
	      <xsl:otherwise>
	      	<OthrPdctChrtcs>
		        <Id><xsl:value-of select="other_type"/></Id>
		        <IdTp><xsl:value-of select="characteristic"/></IdTp>
	        </OthrPdctChrtcs>
	      </xsl:otherwise>
	    </xsl:choose>
	  </PdctChrtcs>
	</xsl:template>
	
	<xsl:template match="product_category">
	  <PdctCtgy>
	    <xsl:choose>
	      <xsl:when test="type != 'OTHR'">
	      	<StrdPdctCtgy>
		        <Tp><xsl:value-of select="type"/></Tp>
		        <Ctgy><xsl:value-of select="category"/></Ctgy>
	        </StrdPdctCtgy>
	      </xsl:when>
	      <xsl:otherwise>
	      	<OthrPdctCtgy>
		        <Id><xsl:value-of select="other_type"/></Id>
		        <IdTp><xsl:value-of select="category"/></IdTp>
	        </OthrPdctCtgy>
	      </xsl:otherwise>
	    </xsl:choose>
	  </PdctCtgy>
	</xsl:template>
	<xsl:template match="routing_summary" mode="individual">
		<xsl:if test="transport_type='01'">
	        <xsl:if test="transport_mode ='01'">
	        	<xsl:call-template name="TrnsprtByAir"/>
	        </xsl:if>
		    <xsl:if test="transport_mode ='02'">
		       	<xsl:call-template select="TrnsprtBySea"/>
		    </xsl:if>
		    <xsl:if test="transport_mode ='03'">
		      	<xsl:call-template select="TrnsprtByRoad"/>
		    </xsl:if>
		    <xsl:if test="transport_mode ='04'">
		       	<xsl:call-template select="TrnsprtByRail"/>
		    </xsl:if>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="routing_summary" mode="multimodal">
		<xsl:if test="transport_type='02'">
		    <MltmdlTrnsprt>
		       <TakngInChrg></TakngInChrg>
		       <PlcOfFnlDstn></PlcOfFnlDstn>
		    </MltmdlTrnsprt>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="TrnsprtByAir">
		<TrnsprtByAir>
			<xsl:apply-templates select="DprtureAirprt"/>
			<xsl:apply-templates select="DstnAirprt"/>
			<AirCrrierNm></AirCrrierNm>
			<AirCrrierCtry></AirCrrierCtry>
			<CrrierAgtNm></CrrierAgtNm>
			<CrrierAgtCtry></CrrierAgtCtry>
		</TrnsprtByAir>
	</xsl:template>
	
	<xsl:template name="TrnsprtBySea">
		<TrnsprtBySea>
			<xsl:apply-templates select="PortOfLoadng"/>
			<xsl:apply-templates select="PortOfDschrge"/>
			<SeaCrrierNm></SeaCrrierNm>
			<VsslNm></VsslNm>
			<SeaCrrierCtry></SeaCrrierCtry>
			<CrrierAgtNm></CrrierAgtNm>
			<CrrierAgtCtry></CrrierAgtCtry>
		</TrnsprtBySea>
	</xsl:template>
	
	<xsl:template name="TrnsprtByRoad">
		<TrnsprtByRoad>
			<xsl:apply-templates select="PlcOfRct"/>
			<xsl:apply-templates select="PlcOfDlvry"/>
			<RoadCrrierNm></RoadCrrierNm>
			<RoadCrrierCtry></RoadCrrierCtry>
			<CrrierAgtNm></CrrierAgtNm>
			<CrrierAgtCtry></CrrierAgtCtry>
		</TrnsprtByRoad>
	</xsl:template>
	
	<xsl:template name="TrnsprtByRail">
		<TrnsprtByRail>
			<xsl:apply-templates select="PlcOfRct"/>
			<xsl:apply-templates select="PlcOfDlvry"/>
			<RailCrrierNm></RailCrrierNm>
			<RailCrrierCtry></RailCrrierCtry>
			<CrrierAgtNm></CrrierAgtNm>
			<CrrierAgtCtry></CrrierAgtCtry>
		</TrnsprtByRail>
	</xsl:template>
	
	<xsl:template match="BuyrSdSubmitgBk">
		<BuyrSdSubmitgBk>
			<BIC></BIC>
		</BuyrSdSubmitgBk>
	</xsl:template>
	
	<xsl:template match="SellrSdSubmitgBk">
		<SellrSdSubmitgBk>
			<BIC></BIC>
		</SellrSdSubmitgBk>
	</xsl:template>
		
	<xsl:template match="product_orgn">
		<PdctOrgn><xsl:value-of select="."/></PdctOrgn>
	</xsl:template>
	
	<xsl:template match="ShipmntSubSchdl">
		<ShipmntSubSchdl>
			<SubQtyVal></SubQtyVal>
			<EarlstShipmntDt></EarlstShipmntDt>
			<LatstShipmntDt></LatstShipmntDt>
		</ShipmntSubSchdl>
	</xsl:template>
	
	<xsl:template match="DprtureAirprt">
		<DprtureAirprt>
			<AirprtCd></AirprtCd>
			<OthrAirprtDesc>
				<Twn></Twn>
				<AirprtNm></AirprtNm>
			</OthrAirprtDesc>
		</DprtureAirprt>
	</xsl:template>
	
	<xsl:template match="DstnAirprt">
		<DstnAirprt>
			<AirprtCd></AirprtCd>
			<OthrAirprtDesc>
				<Twn></Twn>
				<AirprtNm></AirprtNm>
			</OthrAirprtDesc>
		</DstnAirprt>
	</xsl:template>
	
	<xsl:template match="PortOfLoadng">
		<PortOfLoadng></PortOfLoadng>
	</xsl:template>
	
	<xsl:template match="PortOfDschrge">
		<PortOfDschrge></PortOfDschrge>
	</xsl:template>
	
	<xsl:template match="PlcOfRct">
		<PlcOfRct></PlcOfRct>
	</xsl:template>
	
	<xsl:template match="PlcOfDlvry">
		<PlcOfDlvry></PlcOfDlvry>
	</xsl:template>
	
	<xsl:template match="allowance" mode="adjustment">
	  <Adjstmnt>
	  	<Tp>
		    <xsl:choose>
		      <xsl:when test="type != 'OTHR'">
		        <Tp><xsl:value-of select="type"/></Tp>
		      </xsl:when>
		      <xsl:otherwise>
		        <OthrAdjstmntTp><xsl:value-of select="other_type"/></OthrAdjstmntTp>
		      </xsl:otherwise>
		    </xsl:choose>
	    </Tp>
	    <AmtOrPctg>
		    <xsl:choose>
		      <xsl:when test="amt !=''">
		        <Amt>
		          <xsl:attribute name="Ccy"><xsl:value-of select="cur_code"/></xsl:attribute>
		          <xsl:value-of select="amt"/>
		        </Amt>
		      </xsl:when>
		      <xsl:otherwise>
		        <Pctg><xsl:value-of select="rate"/></Pctg>
		      </xsl:otherwise>
		    </xsl:choose>
	    </AmtOrPctg>
	    <Drctn><xsl:value-of select="direction"/></Drctn>
	  </Adjstmnt>
	</xsl:template>
	
	<xsl:template match="adjustment">
	  <Adjstmnt>
	  	<Tp>
		    <xsl:choose>
		      <xsl:when test="type != 'OTHR'">
		        <Tp><xsl:value-of select="type"/></Tp>
		      </xsl:when>
		      <xsl:otherwise>
		        <OthrAdjstmntTp><xsl:value-of select="other_type"/></OthrAdjstmntTp>
		      </xsl:otherwise>
		    </xsl:choose>
	    </Tp>
	    <AmtOrPctg>
		    <xsl:choose>
		      <xsl:when test="amt !=''">
		        <Amt>
		          <xsl:attribute name="Ccy"><xsl:value-of select="cur_code"/></xsl:attribute>
		          <xsl:value-of select="amt"/>
		        </Amt>
		      </xsl:when>
		      <xsl:otherwise>
		        <Pctg><xsl:value-of select="rate"/></Pctg>
		      </xsl:otherwise>
		    </xsl:choose>
	    </AmtOrPctg>
	    <Drctn><xsl:value-of select="direction"/></Drctn>
	  </Adjstmnt>
	</xsl:template>
	
	<xsl:template match="allowance" mode="freight_charge">
	  <Chrgs>
	  	<Tp>
		    <xsl:choose>
		      <xsl:when test="type != 'OTHR'">
		        <Tp><xsl:value-of select="type"/></Tp>
		      </xsl:when>
		      <xsl:otherwise>
		        <OthrChrgsTp><xsl:value-of select="other_type"/></OthrChrgsTp>
		      </xsl:otherwise>
		    </xsl:choose>
	    </Tp>
	    <AmtOrPctg>
		    <xsl:choose>
		      <xsl:when test="amt !=''">
		        <Amt>
		          <xsl:attribute name="Ccy"><xsl:value-of select="cur_code"/></xsl:attribute>
		          <xsl:value-of select="amt"/>
		        </Amt>
		      </xsl:when>
		      <xsl:otherwise>
		        <Pctg><xsl:value-of select="rate"/></Pctg>
		      </xsl:otherwise>
		    </xsl:choose>
	    </AmtOrPctg>
	  </Chrgs>
	</xsl:template>
	
	<xsl:template match="freightCharge">
	  <Chrgs>
	  	<Tp>
		    <xsl:choose>
		      <xsl:when test="type != 'OTHR'">
		        <Tp><xsl:value-of select="type"/></Tp>
		      </xsl:when>
		      <xsl:otherwise>
		        <OthrChrgsTp><xsl:value-of select="other_type"/></OthrChrgsTp>
		      </xsl:otherwise>
		    </xsl:choose>
	    </Tp>
	    <AmtOrPctg>
		    <xsl:choose>
		      <xsl:when test="amt !=''">
		        <Amt>
		          <xsl:attribute name="Ccy"><xsl:value-of select="cur_code"/></xsl:attribute>
		          <xsl:value-of select="amt"/>
		        </Amt>
		      </xsl:when>
		      <xsl:otherwise>
		        <Pctg><xsl:value-of select="rate"/></Pctg>
		      </xsl:otherwise>
		    </xsl:choose>
	    </AmtOrPctg>
	  </Chrgs>
	</xsl:template>
	
	<xsl:template match="allowance" mode="tax">
	  <Tax>
	  	<Tp>
		    <xsl:choose>
		      <xsl:when test="type != 'OTHR'">
		        <Tp><xsl:value-of select="type"/></Tp>
		      </xsl:when>
		      <xsl:otherwise>
		        <OthrTaxTp><xsl:value-of select="other_type"/></OthrTaxTp>
		      </xsl:otherwise>
		    </xsl:choose>
	    </Tp>
	    <AmtOrPctg>
		    <xsl:choose>
		      <xsl:when test="amt !=''">
		        <Amt>
		          <xsl:attribute name="Ccy"><xsl:value-of select="cur_code"/></xsl:attribute>
		          <xsl:value-of select="amt"/>
		        </Amt>
		      </xsl:when>
		      <xsl:otherwise>
		        <Pctg><xsl:value-of select="rate"/></Pctg>
		      </xsl:otherwise>
		    </xsl:choose>
	    </AmtOrPctg>
	  </Tax>
	</xsl:template>
	
	<xsl:template match="tax">
	  <Tax>
	  	<Tp>
		    <xsl:choose>
		      <xsl:when test="type != 'OTHR'">
		        <Tp><xsl:value-of select="type"/></Tp>
		      </xsl:when>
		      <xsl:otherwise>
		        <OthrTaxTp><xsl:value-of select="other_type"/></OthrTaxTp>
		      </xsl:otherwise>
		    </xsl:choose>
	    </Tp>
	    <AmtOrPctg>
		    <xsl:choose>
		      <xsl:when test="amt !=''">
		        <Amt>
		          <xsl:attribute name="Ccy"><xsl:value-of select="cur_code"/></xsl:attribute>
		          <xsl:value-of select="amt"/>
		        </Amt>
		      </xsl:when>
		      <xsl:otherwise>
		        <Pctg><xsl:value-of select="rate"/></Pctg>
		      </xsl:otherwise>
		    </xsl:choose>
	    </AmtOrPctg>
	  </Tax>
	</xsl:template>
	
	<xsl:template match="incoterm">
	  <Incotrms>
	  	<IncotrmsCd>
		    <xsl:choose>
		      <xsl:when test="code != 'OTHR'">
		        <Cd><xsl:value-of select="code"/></Cd>
		      </xsl:when>
		      <xsl:otherwise>
		        <Prtry>
		        	<Id></Id>
		        	<SchmeNm></SchmeNm>
		        	<Issr></Issr>
		        </Prtry>
		      </xsl:otherwise>
		    </xsl:choose>
	    </IncotrmsCd>
	    <Lctn><xsl:value-of select="location"/></Lctn>
	  </Incotrms>
	</xsl:template>
	
	<xsl:template match="user_defined_information">
		<xsl:if test="type ='01'">
		  <BuyrDfndInf>
		    <Labl><xsl:value-of select="label"/></Labl>
		    <Inf><xsl:value-of select="information"/></Inf>
		  </BuyrDfndInf>
	  	</xsl:if>
	  	<xsl:if test="type ='02'">
		  <SellrDfndInf>
		    <Labl><xsl:value-of select="label"/></Labl>
		    <Inf><xsl:value-of select="information"/></Inf>
		  </SellrDfndInf>
	  	</xsl:if>
	</xsl:template>
	
	<xsl:template match="payment" mode="amend">
	  <PmtTerms>
	  	<PmtTerms>
		    <xsl:choose>
		      <xsl:when test="code != ''">
		        <PmtCd>
		          <Cd><xsl:value-of select="code"/></Cd>
		          <xsl:if test="nb_days !=''"><NbOfDays><xsl:value-of select="nb_days"/></NbOfDays></xsl:if>
		        </PmtCd>
		      </xsl:when>
		      <xsl:when test="paymt_date != ''">
		      	<PmtDueDt></PmtDueDt>
		      </xsl:when>
		      <xsl:when test="other_paymt_terms != ''">
		        <OthrPmtTerms><xsl:value-of select="other_paymt_terms"/></OthrPmtTerms>
		      </xsl:when>
		    </xsl:choose>
		   </PmtTerms>
		    <AmtOrPctg>
			    <xsl:choose>
			      <xsl:when test="amt !=''">
			        <Amt>
			          <xsl:attribute name="Ccy"><xsl:value-of select="cur_code"/></xsl:attribute>
			          <xsl:value-of select="amt"/>
			        </Amt>
			      </xsl:when>
			      <xsl:otherwise>
			        <Pctg><xsl:value-of select="pct"/></Pctg>
			      </xsl:otherwise>
			    </xsl:choose>
		    </AmtOrPctg>
	  </PmtTerms>
	</xsl:template>
	
	<xsl:template match="PmtOblgtn">
	  <PmtOblgtn>
	  	<OblgrBk>
	  		<BIC><xsl:value-of select="OblgrBk/BIC"/></BIC>
	  	</OblgrBk>
	  	<RcptBk>
	  		<BIC><xsl:value-of select="RcptBk/BIC"/></BIC>
	  	</RcptBk>
	  	<PmtOblgtnAmt>
	  		<xsl:choose>
	  			<xsl:when test="PmtOblgtnAmt/Amt !=''">
	  				<Amt><xsl:value-of select="PmtOblgtnAmt/Amt"/></Amt>
	  			</xsl:when>
	  			<xsl:otherwise>
	  				<Pctg><xsl:value-of select="PmtOblgtnAmt/Pctg"/></Pctg>
	  			</xsl:otherwise>
	  		</xsl:choose>
	  	</PmtOblgtnAmt>
	  	<xsl:if test="Chrgs and Chrgs !=''">
	  		<xsl:apply-templates select="Chrgs" mode="PmtOblgtn"/>
	  	</xsl:if>
	  	<XpryDt><xsl:value-of select="XpryDt"/></XpryDt>
	  	<xsl:if test="(AplblRules/URBPOVrsn and AplblRules/URBPOVrsn !='') or (AplblRules/OthrRulesAndVrsn and AplblRules/OthrRulesAndVrsn !='')">
		  	<AplblRules>
		  		<xsl:choose>
		  			<xsl:when test="AplblRules/URBPOVrsn !=''">
		  				<URBPOVrsn><xsl:value-of select="AplblRules/URBPOVrsn"/></URBPOVrsn>
		  			</xsl:when>
		  			<xsl:otherwise>
		  				<OthrRulesAndVrsn><xsl:value-of select="AplblRules/OthrRulesAndVrsn"/></OthrRulesAndVrsn>
		  			</xsl:otherwise>
		  		</xsl:choose>
		  	</AplblRules>
	  	</xsl:if>
	  	<xsl:if test="AplblLaw and AplblLaw !=''"><AplblLaw><xsl:value-of select="AplblLaw"/></AplblLaw></xsl:if>
	  	<xsl:if test="PlcOfJursdctn/Ctry !='' or PlcOfJursdctn/CtrySubDvsn/Cd !='' or PlcOfJursdctn/CtrySubDvsn/Prtry/Id !='' or PlcOfJursdctn/CtrySubDvsn/Prtry/SchmeNm !='' or PlcOfJursdctn/CtrySubDvsn/Prtry/Issr !='' or PlcOfJursdctn/Txt !=''">
		  	<PlcOfJursdctn>
		  		<Ctry><xsl:value-of select="PlcOfJursdctn/Ctry"/></Ctry>
		  		<CtrySubDvsn>
		  			<xsl:choose>
			  			<xsl:when test="PlcOfJursdctn/CtrySubDvsn/Cd !=''">
			  				<Cd><xsl:value-of select="PlcOfJursdctn/CtrySubDvsn/Cd"/></Cd>
			  			</xsl:when>
			  			<xsl:otherwise>
			  				<Prtry>
			  					<Id><xsl:value-of select="PlcOfJursdctn/CtrySubDvsn/Prtry/Id"/></Id>
			        			<SchmeNm><xsl:value-of select="PlcOfJursdctn/CtrySubDvsn/Prtry/SchmeNm"/></SchmeNm>
			        			<Issr><xsl:value-of select="PlcOfJursdctn/CtrySubDvsn/Prtry/Issr"/></Issr>
			  				</Prtry>
			  			</xsl:otherwise>
		  			</xsl:choose>
		  		</CtrySubDvsn>
		  		<Txt><xsl:value-of select="PlcOfJursdctn/Txt"/></Txt>
		  	</PlcOfJursdctn>
	  	</xsl:if>
	  	
	  	<xsl:if test="PmtTerms/AmtOrPctg/Amt !='' or PmtTerms/AmtOrPctg/Pctg !=''">
	  		<xsl:apply-templates select="PmtTerms" mode="PmtOblgtn"/>
	  	</xsl:if>
	  	
	  	<xsl:if test="SttlmTerms/CdtrAcct/Id/IBAN !='' or SttlmTerms/CdtrAcct/Id/Othr/Id !=''">
		  	<SttlmTerms>
		  		  <xsl:if test="SttlmTerms/CdtrAgt/BIC !='' or SttlmTerms/CdtrAgt/NmAndAdr/Nm !=''">
				      <CdtrAgt>
				        <xsl:choose>
				          <xsl:when test="SttlmTerms/CdtrAgt/BIC !=''">
				            <BIC><xsl:value-of select="SttlmTerms/CdtrAgt/BIC"/></BIC>
				          </xsl:when>
				          <xsl:otherwise>
				            <NmAndAdr>
				              <Nm><xsl:value-of select="SttlmTerms/CdtrAgt/NmAndAdr/Nm"/></Nm>
				              <Adr>
				                <xsl:if test="SttlmTerms/CdtrAgt/NmAndAdr/Adr/StrtNm and SttlmTerms/CdtrAgt/NmAndAdr/Adr/StrtNm !=''"><StrtNm><xsl:value-of select="SttlmTerms/CdtrAgt/NmAndAdr/Adr/StrtNm"/></StrtNm></xsl:if>
				                <PstCdId><xsl:value-of select="SttlmTerms/CdtrAgt/NmAndAdr/Adr/PstCdId"/></PstCdId>
				                <TwnNm><xsl:value-of select="SttlmTerms/CdtrAgt/NmAndAdr/Adr/TwnNm"/></TwnNm>
				                <xsl:if test="SttlmTerms/CdtrAgt/NmAndAdr/Adr/CtrySubDvsn and SttlmTerms/CdtrAgt/NmAndAdr/Adr/CtrySubDvsn !=''"><CtrySubDvsn><xsl:value-of select="SttlmTerms/CdtrAgt/NmAndAdr/Adr/CtrySubDvsn"/></CtrySubDvsn></xsl:if>
				                <Ctry><xsl:value-of select="SttlmTerms/CdtrAgt/NmAndAdr/Adr/Ctry"/></Ctry>
				              </Adr>
				            </NmAndAdr>
				          </xsl:otherwise>
				        </xsl:choose>
				      </CdtrAgt>
			      </xsl:if>
			    <CdtrAcct>
		          <Id>
		            <xsl:choose>
		              <xsl:when test="SttlmTerms/CdtrAcct/Id/IBAN !=''"><IBAN><xsl:value-of select="SttlmTerms/CdtrAcct/Id/IBAN"/></IBAN></xsl:when>
		              <xsl:otherwise>
		              <Othr>
		              	<Id><xsl:value-of select="SttlmTerms/CdtrAcct/Id/Othr/Id"/></Id>
		              	<xsl:if test="SttlmTerms/CdtrAcct/Id/Othr/SchmeNm/Cd !='' or SttlmTerms/CdtrAcct/Id/Othr/SchmeNm/Prtry !=''">
			              	<SchmeNm>
			              		<xsl:choose>
			              			<xsl:when test="SttlmTerms/CdtrAcct/Id/Othr/SchmeNm/Cd !=''">
			              				<Cd><xsl:value-of select="SttlmTerms/CdtrAcct/Id/Othr/SchmeNm/Cd"/></Cd>
			              			</xsl:when>
			              			<xsl:otherwise>
			              				<Prtry><xsl:value-of select="SttlmTerms/CdtrAcct/Id/Othr/SchmeNm/Prtry"/></Prtry>
			              			</xsl:otherwise>
			              		</xsl:choose>
			              	</SchmeNm>
		              	</xsl:if>
		              	<xsl:if test="SttlmTerms/CdtrAcct/Id/Othr/Issr and SttlmTerms/CdtrAcct/Id/Othr/Issr !=''"><Issr><xsl:value-of select="SttlmTerms/CdtrAcct/Id/Othr/Issr"/></Issr></xsl:if>
		              </Othr>
		             </xsl:otherwise>
		            </xsl:choose>
		          </Id>
			        <xsl:if test="SttlmTerms/CdtrAcct/Tp/Cd !='' or SttlmTerms/CdtrAcct/Tp/Prtry !=''">
				        <Tp>
				        	<xsl:choose>
				        		<xsl:when test="SttlmTerms/CdtrAcct/Tp/Cd !=''">
				        			<Cd><xsl:value-of select="SttlmTerms/CdtrAcct/Tp/Cd"/></Cd>
				        		</xsl:when>
				        		<xsl:otherwise>
				        			<Prtry><xsl:value-of select="SttlmTerms/CdtrAcct/Tp/Prtry"/></Prtry>
				        		</xsl:otherwise>
				        	</xsl:choose>
				        </Tp>
			        </xsl:if>
			      <xsl:if test="SttlmTerms/CdtrAcct/Ccy and SttlmTerms/CdtrAcct/Ccy !=''"><Ccy></Ccy></xsl:if>
			      <xsl:if test="SttlmTerms/CdtrAcct/Nm and SttlmTerms/CdtrAcct/Nm !=''"><Nm></Nm></xsl:if>
			    </CdtrAcct>
			  </SttlmTerms>
		  </xsl:if>
	  </PmtOblgtn>
	</xsl:template>
	
	<xsl:template match="Chrgs" mode="PmtOblgtn">
		<Chrgs>
	  		<ChrgsPyer><xsl:value-of select="ChrgsPyer"/></ChrgsPyer>
	  		<ChrgsPyee><xsl:value-of select="ChrgsPyee"/></ChrgsPyee>
	  		<xsl:if test="Amt and Amt !=''"><Amt><xsl:value-of select="Amt"/></Amt></xsl:if>
	  		<xsl:if test="Pctg and Pctg !=''"><Pctg><xsl:value-of select="Pctg"/></Pctg></xsl:if>
	  		<xsl:if test="Tp and Tp !=''"><Tp><xsl:value-of select="Tp"/></Tp></xsl:if>
	  	</Chrgs>
	</xsl:template>
	
	<xsl:template match="Submitr">
		<Submitr>
	  		<BIC><xsl:value-of select="BIC"/></BIC>
	  	</Submitr>
	</xsl:template>
	
	<xsl:template match="ClausesReqrd">
		<ClausesReqrd><xsl:value-of select="."/></ClausesReqrd>
	</xsl:template>
	
	<xsl:template match="CertDataSetReqrd">
		<CertDataSetReqrd>
			<xsl:apply-templates select="Submitr"/>
			<CertTp><xsl:value-of select="CertTp"/></CertTp>
			<xsl:if test="MtchIssr/Nm and MtchIssr/Nm !=''">
				<MtchIssr>
					<Nm><xsl:value-of select="MtchIssr/Nm"/></Nm>
					<xsl:if test="MtchIssr/PrtryId/Id and MtchIssr/PrtryId/Id !=''">
						<PrtryId>
		      				<Id><xsl:value-of select="MtchIssr/PrtryId/Id"/></Id>
		      				<IdTp><xsl:value-of select="MtchIssr/PrtryId/IdTp"/></IdTp>
		      			</PrtryId>
	      			</xsl:if>
	      			<Ctry><xsl:value-of select="MtchIssr/Ctry"/></Ctry>
				</MtchIssr>
			</xsl:if>
			<MtchIsseDt><xsl:value-of select="MtchIsseDt"/></MtchIsseDt>
			<MtchInspctnDt><xsl:value-of select="MtchInspctnDt"/></MtchInspctnDt>
			<AuthrsdInspctrInd><xsl:value-of select="AuthrsdInspctrInd"/></AuthrsdInspctrInd>
			<MtchConsgn><xsl:value-of select="MtchConsgn"/></MtchConsgn>
			<xsl:if test="MtchManfctr/Nm and MtchManfctr/Nm !=''">
				<MtchManfctr>
					<Nm><xsl:value-of select="MtchManfctr/Nm"/></Nm>
					<xsl:if test="MtchManfctr/PrtryId/Id and MtchManfctr/PrtryId/Id !=''">
						<PrtryId>
		      				<Id><xsl:value-of select="MtchManfctr/PrtryId/Id"/></Id>
		      				<IdTp><xsl:value-of select="MtchManfctr/PrtryId/IdTp"/></IdTp>
		      			</PrtryId>
	      			</xsl:if>
	      			<Ctry><xsl:value-of select="MtchManfctr/Ctry"/></Ctry>
				</MtchManfctr>
			</xsl:if>
			<xsl:if test="LineItmId and LineItmId !=''">
				<xsl:apply-templates select="LineItmId"/>
			</xsl:if>
		</CertDataSetReqrd>
	</xsl:template>
	
	<xsl:template match="LineItmId">
		<LineItmId><xsl:value-of select="."/></LineItmId>
	</xsl:template>
	
	<xsl:template match="OthrCertDataSetReqrd">
		<OthrCertDataSetReqrd>
			<xsl:apply-templates select="Submitr"/>
			<CertTp><xsl:value-of select="CertTp"/></CertTp>
		</OthrCertDataSetReqrd>
	</xsl:template>
	
	<xsl:template match="PmtTerms" mode="PmtOblgtn">
		<PmtTerms>
	  		<PmtTerms>
	  			<xsl:choose>
		  			<xsl:when test="PmtTerms/PmtCd/Cd !=''">
			  			<PmtCd>
			  				<Cd><xsl:value-of select="PmtTerms/PmtCd/Cd"/></Cd>
			  				<NbOfDays><xsl:value-of select="PmtTerms/PmtCd/NbOfDays"/></NbOfDays>
			  			</PmtCd>
		  			</xsl:when>
		  			<xsl:when test="PmtTerms/PmtDueDt !=''">
		  				<PmtDueDt><xsl:value-of select="PmtTerms/PmtDueDt"/></PmtDueDt>
		  			</xsl:when>
		  			<xsl:when test="PmtTerms/OthrPmtTerms !=''">
		  				<OthrPmtTerms><xsl:value-of select="PmtTerms/OthrPmtTerms"/></OthrPmtTerms>
		  			</xsl:when>
	  			</xsl:choose>
	  		</PmtTerms>
	  		<AmtOrPctg>
	  			<xsl:choose>
		  			<xsl:when test="AmtOrPctg/Amt !=''">
	  					<Amt><xsl:value-of select="AmtOrPctg/Amt"/></Amt>
	  				</xsl:when>
	  				<xsl:otherwise>
	  					<Pctg><xsl:value-of select="AmtOrPctg/Pctg"/></Pctg>
	  				</xsl:otherwise>
	  			</xsl:choose>
	  		</AmtOrPctg>
	  	</PmtTerms>
	</xsl:template>
</xsl:stylesheet>