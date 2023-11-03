<?xml version="1.0"?>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:service="xalan://com.misys.portal.common.boreference.BOReferenceBrokerService"		
		exclude-result-prefixes="localization service">
<!--
   Copyright (c) 2000-2010 Misys (http://www.misysbanking.com),
   All Rights Reserved. 
-->
	<!-- Transform MT798<766/769> (Advice of Reduction or Release Details) into bg_tnx_record or si_tnx_record
	MT769 is used for both products. We use the XML tag value RelatedReference that should contains
	our reference id and thus the product code.
	 -->
	<!-- Import common functions -->
	<xsl:import href="MTXXX_common.xsl"/>
   <xsl:param name="reference"/>
   <xsl:param name="language">en</xsl:param>
   <!-- reference should be equal to CustomerReferenceNumber in the message --> 
   <xsl:param name="product_code"><xsl:value-of select="substring($reference,1,2)"/></xsl:param>       
   
    <xsl:template match="/">
        <xsl:apply-templates select="MeridianMessages/MeridianMessage[ExternalMessageType = 'MT769']"/>
    </xsl:template>
	
    <xsl:template match="MeridianMessage[ExternalMessageType = 'MT769']">		 		
    	<xsl:variable name="lowercase_product_code">
    		<xsl:value-of select="translate($product_code, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')"/>
    	</xsl:variable>
    	<xsl:variable name="applRef" select="service:retrieveCustomerBankReferenceFromMaster($reference, $product_code)" />
    	<xsl:variable name="root_node"><xsl:value-of select="$lowercase_product_code"/>_tnx_record</xsl:variable>
		<xsl:element name="{$root_node}">
			 <xsl:attribute name="xsi:noNamespaceSchemaLocation">
			 	<xsl:choose>
			 		<xsl:when test="$lowercase_product_code = 'bg'">http://www.neomalogic.com/gtp/interfaces/xsd/bg.xsd</xsl:when>
			 		<xsl:when test="$lowercase_product_code = 'si'">http://www.neomalogic.com/gtp/interfaces/xsd/si.xsd</xsl:when>
			 		<xsl:when test="$lowercase_product_code = 'br'">http://www.neomalogic.com/gtp/interfaces/xsd/br.xsd</xsl:when>
			 		<xsl:when test="$lowercase_product_code = 'sr'">http://www.neomalogic.com/gtp/interfaces/xsd/sr.xsd</xsl:when>
			 	</xsl:choose>
    		</xsl:attribute>
        <brch_code>00001</brch_code>
        <xsl:if test="$lowercase_product_code = 'br' or $lowercase_product_code = 'sr' or $lowercase_product_code = 'bg' or $lowercase_product_code = 'si'">
        <!-- Customer Reference number is the $reference -->
          <ref_id><xsl:value-of select="$reference"/></ref_id>
        </xsl:if>
        <xsl:choose>
        	<xsl:when test="$lowercase_product_code = 'sr'">
        		<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT766']/GuaranteeCreditNumber[.!='']">
        			<lc_ref_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT766']/GuaranteeCreditNumber"/></lc_ref_id>
        		</xsl:if>
        	</xsl:when>
        	<xsl:otherwise>
        		<bo_ref_id><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT766']/GuaranteeCreditNumber"/></bo_ref_id>
        	</xsl:otherwise>
        </xsl:choose>
		<tnx_type_code>03</tnx_type_code>
		<sub_tnx_type_code>05</sub_tnx_type_code>
		<prod_stat_code>11</prod_stat_code>
		<tnx_stat_code>04</tnx_stat_code>  
		<product_code><xsl:value-of select="translate($product_code, 'abcdefghijklmnopqrstuvwxyz', 'ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/></product_code>	
		<amd_date><xsl:apply-templates select="DateReductionRelease"/></amd_date>
		<xsl:if test="AmountReducedReleased">
			<!-- Guarantee amount -->
			<xsl:variable name="amount">
				<xsl:call-template name="format_amount"><xsl:with-param name="amount"><xsl:value-of select="substring(AmountReducedReleased,4)"/></xsl:with-param>
				<xsl:with-param name="language"><xsl:value-of select="$language"/></xsl:with-param></xsl:call-template>		
			</xsl:variable>
			<tnx_cur_code><xsl:value-of select="substring(AmountReducedReleased,1,3)"/></tnx_cur_code>			  	
      		<tnx_amt><xsl:value-of select="$amount"/></tnx_amt>
      	</xsl:if>
		<xsl:if test="AmountOutstanding">
			<!-- Guarantee amount -->
			<xsl:variable name="amount">
				<xsl:call-template name="format_amount"><xsl:with-param name="amount"><xsl:value-of select="substring(AmountOutstanding,4)"/></xsl:with-param>
				<xsl:with-param name="language"><xsl:value-of select="$language"/></xsl:with-param></xsl:call-template>		
			</xsl:variable>	
		 	<xsl:choose>
		 		<xsl:when test="$lowercase_product_code = 'bg' or $lowercase_product_code = 'br'">
		 			<bg_liab_amt><xsl:value-of select="$amount"/></bg_liab_amt>
		 		</xsl:when>
		 		<xsl:when test="$lowercase_product_code = 'si' or $lowercase_product_code = 'sr'">
		 			<lc_liab_amt><xsl:value-of select="$amount"/></lc_liab_amt>
		 		</xsl:when>
		 	</xsl:choose>
      	</xsl:if>
      	
      	<xsl:if test="AmountReducedReleased">
	      	<xsl:if test="$lowercase_product_code = 'bg' or $lowercase_product_code = 'si'">
	      		<xsl:variable name="amount">
					<xsl:call-template name="format_amount"><xsl:with-param name="amount"><xsl:value-of select="substring(AmountReducedReleased,4)"/></xsl:with-param>
					<xsl:with-param name="language"><xsl:value-of select="$language"/></xsl:with-param></xsl:call-template>		
				</xsl:variable>
	      		<release_amt><xsl:value-of select="$amount"/></release_amt>
	      	</xsl:if>
	    </xsl:if>
      	
      	<xsl:choose>
			<xsl:when test="$lowercase_product_code = 'br' or $lowercase_product_code = 'sr'">
			  <beneficiary_reference>
				<xsl:call-template name="extract_customer_reference">
					<xsl:with-param name="input">
						<xsl:value-of select="/MeridianMessages/MeridianMessage[ExternalMessageType = 'MT766']/BanktoCorporateInformation"/>
					</xsl:with-param>
				</xsl:call-template>
			  </beneficiary_reference>
			</xsl:when>
			<xsl:when test="$lowercase_product_code = 'bg' or $lowercase_product_code = 'si'">
			  <applicant_reference><xsl:value-of select="$applRef"/></applicant_reference>
			</xsl:when>
			<xsl:otherwise>
			  <applicant_reference>
				<xsl:call-template name="extract_customer_reference">
					<xsl:with-param name="input">
						<xsl:value-of select="/MeridianMessages/MeridianMessage[ExternalMessageType = 'MT766']/BanktoCorporateInformation"/>
					</xsl:with-param>
				</xsl:call-template>
			  </applicant_reference>	
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="$lowercase_product_code = 'br'">
			<issuing_bank>
        		<reference><xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT766']/GuaranteeCreditNumber"/></reference>
        	</issuing_bank>
		</xsl:if>
		
		<xsl:choose>
			<xsl:when test="$lowercase_product_code = 'br' or $lowercase_product_code = 'sr'">
				<bo_comment>
					<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT766']/BanktoCorporateInformation and ../MeridianMessage[ExternalMessageType = 'MT766']/BanktoCorporateInformation != ''">
						<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="substring-after(../MeridianMessage[ExternalMessageType = 'MT766']/BanktoCorporateInformation, '\n')"/>
						</xsl:with-param>
						</xsl:call-template><xsl:text>
						</xsl:text>
					</xsl:if>
					<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT766']/BankContact and ../MeridianMessage[ExternalMessageType = 'MT766']/BankContact != ''">
						<xsl:call-template name="backslashn_replace">
						<xsl:with-param name="input_text">
							<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT766']/BankContact"/>
						</xsl:with-param>
						</xsl:call-template>
					</xsl:if>			
				</bo_comment>
			</xsl:when>
			<xsl:when test="$lowercase_product_code = 'bg'">
				<bo_comment>
					<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT766']/BanktoCorporateInformation and ../MeridianMessage[ExternalMessageType = 'MT766']/BanktoCorporateInformation != ''">
						<xsl:value-of select="localization:getGTPString($language, 'BANK_TO_CORPORATE_INFO')"/>
						<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
						<xsl:call-template name="backslashn_replace">
							<xsl:with-param name="input_text">
								<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT766']/BanktoCorporateInformation" />
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
					</xsl:if>
					<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT769']/SenderReceiverInfo and ../MeridianMessage[ExternalMessageType = 'MT769']/SenderReceiverInfo != ''">
						<xsl:value-of select="localization:getGTPString($language, 'SENDER_TO_RECEIVER_INFO')"/>
						<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
						<xsl:call-template name="backslashn_replace">
							<xsl:with-param name="input_text">
								<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT769']/SenderReceiverInfo"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>	
				</bo_comment>
			</xsl:when>
			<xsl:when test="$lowercase_product_code = 'si'">
				<!-- Setting bank to corporate info to narrative additional instructions -->
				<xsl:call-template name="add-narrative"/>
				
				<!-- setting sender_to_receiver to bo_comment -->
				<bo_comment>
					<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT769']/SenderReceiverInfo and ../MeridianMessage[ExternalMessageType = 'MT769']/SenderReceiverInfo != ''">
						<xsl:call-template name="backslashn_replace">
							<xsl:with-param name="input_text">
								<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT769']/SenderReceiverInfo"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:if>	
				</bo_comment>
			</xsl:when>
		</xsl:choose>
		
		<xsl:if test="$lowercase_product_code = 'bg' or $lowercase_product_code = 'si'">
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT769']/AmountSpecification and ../MeridianMessage[ExternalMessageType = 'MT769']/AmountSpecification !=''">
				 <amd_details>
				    <xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT769']/AmountSpecification"/>
				  </amd_details>
			</xsl:if>
		</xsl:if>
		
		<xsl:if test="$lowercase_product_code = 'bg' or $lowercase_product_code = 'si'">
			<xsl:if test="(../MeridianMessage[ExternalMessageType = 'MT769']/AmountChargesB and ../MeridianMessage[ExternalMessageType = 'MT769']/AmountChargesB != '') or (../MeridianMessage[ExternalMessageType = 'MT769']/AmountChargesD and ../MeridianMessage[ExternalMessageType = 'MT769']/AmountChargesD != '')">
				<xsl:call-template name="add-charges"/>
			</xsl:if>
		</xsl:if>
		
      </xsl:element>
    </xsl:template>
    
	<xsl:template match="Narrative">		
		<xsl:call-template name="backslashn_replace">
		<xsl:with-param name="input_text"><xsl:value-of select="."/></xsl:with-param>
	</xsl:call-template><xsl:text>
	</xsl:text>	
	</xsl:template>	
	
	<xsl:template match="DateReductionRelease">
		<xsl:call-template name="format_date"><xsl:with-param name="input_date" select="."/></xsl:call-template>	
	</xsl:template>	 
	
	<xsl:template name="add-charges">
  	  	<xsl:variable name="chargetype">
			<xsl:choose>
				<xsl:when test="../MeridianMessage[ExternalMessageType = 'MT769']/AmountChargesB and ../MeridianMessage[ExternalMessageType = 'MT769']/AmountChargesB != ''">B</xsl:when>
				<xsl:when test="../MeridianMessage[ExternalMessageType = 'MT769']/AmountChargesD and ../MeridianMessage[ExternalMessageType = 'MT769']/AmountChargesD != ''">D</xsl:when>
				<xsl:otherwise>B</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="chargecurcode">
			<xsl:choose>
				<xsl:when test="../MeridianMessage[ExternalMessageType = 'MT769']/AmountChargesB and ../MeridianMessage[ExternalMessageType = 'MT769']/AmountChargesB != ''">
					<xsl:value-of select="substring(../MeridianMessage[ExternalMessageType = 'MT769']/AmountChargesB,1,3)"/>
				</xsl:when>
				<xsl:when test="../MeridianMessage[ExternalMessageType = 'MT769']/AmountChargesD and ../MeridianMessage[ExternalMessageType = 'MT769']/AmountChargesD != ''">
					<xsl:value-of select="substring(../MeridianMessage[ExternalMessageType = 'MT769']/AmountChargesD,7,3)" />
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
  	    <xsl:variable name="chargedate">
			<xsl:choose>
				<xsl:when test="../MeridianMessage[ExternalMessageType = 'MT769']/AmountChargesD and ../MeridianMessage[ExternalMessageType = 'MT769']/AmountChargesD != ''">
					<xsl:call-template name="format_date">
						<xsl:with-param name="input_date"
							select="normalize-space(AmountChargesD)" />
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="chargeamt">
			<xsl:choose>
				<xsl:when test="../MeridianMessage[ExternalMessageType = 'MT769']/AmountChargesB and ../MeridianMessage[ExternalMessageType = 'MT769']/AmountChargesB != ''">
					<xsl:call-template name="format_amount">
						<xsl:with-param name="amount">
							<xsl:value-of select="substring(AmountChargesB,4)" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="../MeridianMessage[ExternalMessageType = 'MT769']/AmountChargesD and ../MeridianMessage[ExternalMessageType = 'MT769']/AmountChargesD != ''">
					<xsl:call-template name="format_amount">
						<xsl:with-param name="amount">
							<xsl:value-of select="substring(AmountChargesD,10)" />
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
			
    	<!-- charge details set as "OTHER". status set as settled. date as settlement date. charge is "OTHER". -->
		<charges>
			<charge>
				<!-- <chrg_id>0</chrg_id> -->
				<chrg_code>OTHER</chrg_code>
				<amt><xsl:value-of select="$chargeamt" /></amt>
				<cur_code><xsl:value-of select="$chargecurcode" /></cur_code>
				
				<xsl:choose>
					<xsl:when test="$chargetype = 'D'">
						<status>01</status>
					</xsl:when>
					<xsl:otherwise>
						<status>99</status>
					</xsl:otherwise>
				</xsl:choose>
				
				<!-- to be set as "01" for LC and "02" for EL -->
				<bearer_role_code>01</bearer_role_code>
				
				<!-- to be same as iss_date. How to populate it? -->
				<!-- <inception_date><xsl:value-of select="$issdate" /></inception_date> -->
				
				<xsl:if test="$chargetype = 'D'">
					<settlement_date><xsl:value-of select="$chargedate" /></settlement_date>
				</xsl:if>
				<additional_comment>
					<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT769']/DetailsCharges and ../MeridianMessage[ExternalMessageType = 'MT769']/DetailsCharges !=''">
						<xsl:value-of select="localization:getGTPString($language, 'CHARGE_DETAILS')"/>
						<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
						<xsl:call-template name="backslashn_replace">
							<xsl:with-param name="input_text">
								<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT769']/DetailsCharges" />
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
					</xsl:if>
					
					<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT769']/AccId and ../MeridianMessage[ExternalMessageType = 'MT769']/AccId !=''">
						<xsl:value-of select="localization:getGTPString($language, 'ACCOUNT_IDENTIFICATION')"/>
						<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
						<xsl:call-template name="backslashn_replace">
							<xsl:with-param name="input_text">
								<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT769']/AccId" />
							</xsl:with-param>
						</xsl:call-template>
						<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
					</xsl:if>
					<xsl:choose>
						<xsl:when test="../MeridianMessage[ExternalMessageType = 'MT769']/AccWithBankA and ../MeridianMessage[ExternalMessageType = 'MT769']/AccWithBankA !=''">
							<xsl:value-of select="localization:getGTPString($language, 'ACCOUNT_WITH_BANK')"/>
							<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
							<xsl:call-template name="backslashn_replace">
								<xsl:with-param name="input_text">
									<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT769']/AccWithBankA" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="../MeridianMessage[ExternalMessageType = 'MT769']/AccWithBankB and ../MeridianMessage[ExternalMessageType = 'MT769']/AccWithBankB !=''">
							<xsl:value-of select="localization:getGTPString($language, 'ACCOUNT_WITH_BANK')"/>
							<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
							<xsl:call-template name="backslashn_replace">
								<xsl:with-param name="input_text">
									<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT769']/AccWithBankB" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
						<xsl:when test="../MeridianMessage[ExternalMessageType = 'MT769']/AccWithBankD and ../MeridianMessage[ExternalMessageType = 'MT769']/AccWithBankD !=''">
							<xsl:value-of select="localization:getGTPString($language, 'ACCOUNT_WITH_BANK')"/>
							<xsl:call-template name="backslashn_replace"><xsl:with-param name="input_text">\n</xsl:with-param></xsl:call-template>
							<xsl:call-template name="backslashn_replace">
								<xsl:with-param name="input_text">
									<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT769']/AccWithBankD" />
								</xsl:with-param>
							</xsl:call-template>
						</xsl:when>
					</xsl:choose>
				</additional_comment>
				<created_in_session>Y</created_in_session>
				<xsl:if test="$chargetype = 'D'">
					<chrg_type><xsl:value-of select="$chargetype" /></chrg_type>
				</xsl:if>
			</charge>
		</charges>
    </xsl:template>  
    
    <xsl:template name="add-narrative">
   		<narrative_additional_instructions>
			<xsl:if test="../MeridianMessage[ExternalMessageType = 'MT766']/BanktoCorporateInformation and ../MeridianMessage[ExternalMessageType = 'MT766']/BanktoCorporateInformation != ''">
				<xsl:call-template name="backslashn_replace">
					<xsl:with-param name="input_text">
						<xsl:value-of select="../MeridianMessage[ExternalMessageType = 'MT766']/BanktoCorporateInformation" />
					</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
		</narrative_additional_instructions>
    </xsl:template> 
</xsl:stylesheet>