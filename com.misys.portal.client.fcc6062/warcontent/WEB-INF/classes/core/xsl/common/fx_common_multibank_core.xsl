<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
        xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
        exclude-result-prefixes="localization xmlRender">

 <!--  This template being added in the product xsl files --> 
 <xsl:template name="fx-template">
 <div id ="fx-section"> 
    <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_EXCHANGE_RATE</xsl:with-param>
    <xsl:with-param name="content">
	    <!-- Exchange Rage Types Board Rates/Utilize Contract Options -->
	    <xsl:call-template name="fx_types"/>
	    
	    <!-- Board Rates Fields -->
	    <div id="fx-board-rate-type">
	    	<!-- Exchange Rate  and Equivalent Amount-->
		    <xsl:call-template name="exchange_rate"/>
		    <div id="tolerance_div">
		    	<xsl:call-template name="tolerance_rate"/>
		    </div>
		    <xsl:call-template name="hidden-field">
		    	<xsl:with-param name="name">fxBuyOrSell</xsl:with-param>
		    	<xsl:with-param name="value" select="''"/>
		    </xsl:call-template>
		    <!--  Hidden field for storing the fx tnx amt -->
		    <xsl:call-template name="hidden-field">
		    	<xsl:with-param name="name">fxTnxAmt</xsl:with-param>
		    	<xsl:with-param name="value" select="''"/>
		    </xsl:call-template>
		</div>
	    
	    <!-- FX Utilize Contracts Fields -->
	    <div>
	    	<!-- From create_fx_multibank js, contract number label, edit field and Utilize amount label and edit fields created and pushed in to this div -->
		    <div id="fx-contracts-type"/>
		    <!-- From create_fx_multibank js, one static label creates and push in to this div -->		  
			<div id="contractMsgDiv"/>	 
			<!-- From create_fx_multibank js, Total Utilize amount label and edit fields creates and push in to this div -->
			<div id="totalUtiliseDiv"/>
			<!-- Hidden Field for storing the no.of contracts -->
		   <xsl:call-template name="hidden-field">
		    <xsl:with-param name="name">fx_nbr_contracts</xsl:with-param>
		    <xsl:with-param name="value"><xsl:value-of select="fx_nbr_contracts"/></xsl:with-param>
		   </xsl:call-template>
		</div>
		<!-- In this script block, prepare the fx parameter data P316, related to board rate, supporting currencies, amount utilize indicator,
			tolerance display indicator, tolerance percentage, contract currencies, no.of contracts.So that this collection object are used in the bdinging JS -->
	    <script>
	    	dojo.require("misys.binding.common.create_fx_multibank");
	    	dojo.subscribe("ready",function(){
				misys._config = misys._config || {};
				dojo.mixin(misys._config, {
					   		fxParamData:{
			        			<xsl:for-each select="banks_fx_rates/fx_bank_params/fx_bank_product_details">
			        				<xsl:value-of select="fx_sub_product_name"/>: {
			        					<xsl:for-each select="fx_bank_properties">
											"<xsl:value-of select="name"/>" : {
												"bankName" : "<xsl:value-of select="name"/>",
												"isFXEnabled" : "<xsl:value-of select="fx_assign_products"/>",
												"maxNbrContracts" : "<xsl:value-of select="fx_nbr_contract/max_nbr_contracts"/>",
												"amtUtiliseInd" : "<xsl:value-of select="fx_nbr_contract/amt_utilise_ind"/>",
												"toleranceDispInd" : "<xsl:value-of select="fx_tolerance_rate/tolerance_disp_ind"/>",
												"tolerancePercentage" : "<xsl:value-of select="fx_tolerance_rate/tolerance_percentage"/>",
												boardCurrencies: {
												<xsl:for-each select="fx_board_rate/board_rate_currency">
														"<xsl:value-of select="currency_code"/>":{
														"boardRateFlag":"<xsl:value-of select="board_rate_flag"/>",
														"minAmt":"<xsl:value-of select="min_amt"/>",
														"maxAmt":"<xsl:value-of select="max_amt"/>"
														}<xsl:if test="not(position()=last())">,</xsl:if>
												</xsl:for-each>
												},
												contractCurrencies: {
												<xsl:for-each select="fx_contract_opt/contract_opt_currency">
														"<xsl:value-of select="currency_code"/>":{
														"contractRateFlag":"<xsl:value-of select="contract_opt_flag"/>",
														"minAmt":"<xsl:value-of select="min_amt"/>",
														"maxAmt":"<xsl:value-of select="max_amt"/>"
														}<xsl:if test="not(position()=last())">,</xsl:if>
												</xsl:for-each>
												}
											}
											<xsl:if test="not(position()=last())">,</xsl:if>
									</xsl:for-each>	
								}
											<xsl:if test="not(position()=last())">,</xsl:if>
									</xsl:for-each>	
					   		},
					   fxContractData:{
					    	<xsl:for-each select="//*[starts-with(name(), 'fx_contract_nbr_')]">
								<xsl:variable name="position">
									<xsl:value-of select="substring-after(name(), 'fx_contract_nbr_')"/>
								</xsl:variable>
								<xsl:variable name="column_name">
									<xsl:value-of select="concat('fx_contract_nbr_', $position)"/>
								</xsl:variable>
								<xsl:if test="//*[starts-with(name(), concat('fx_contract_nbr_', $position))]">
									    "<xsl:value-of select="$column_name"/>":"<xsl:value-of select="."/>"
										<xsl:if test="not(position()=last())">,</xsl:if>
								</xsl:if>
							</xsl:for-each>
					   }	
					});
				});
	    </script>
      </xsl:with-param>
    </xsl:call-template>
   </div>
  </xsl:template>
  
  <!-- Exchange Rage Types Board Rate/Utilize Contract Options radio buttons-->
   <xsl:template name="fx_types">
    <xsl:call-template name="multioption-inline-wrapper">
	      <xsl:with-param name="group-label">XSL_FX_RATES</xsl:with-param>
	      <xsl:with-param name="content">
			   <xsl:call-template name="multichoice-field">
			   <xsl:with-param name="group-label">XSL_FX_RATES</xsl:with-param>
			    <xsl:with-param name="label">XSL_FX_BOARD_RATES</xsl:with-param>
			    <xsl:with-param name="name">fx_rates_type</xsl:with-param>
			    <xsl:with-param name="id">fx_rates_type_1</xsl:with-param>
			    <xsl:with-param name="value">01</xsl:with-param>
			    <xsl:with-param name="type">radiobutton</xsl:with-param>
			    <xsl:with-param name="checked"><xsl:if test="fx_rates_type[. = '01']">Y</xsl:if></xsl:with-param> 
			    <xsl:with-param name="inline">Y</xsl:with-param>
			   </xsl:call-template>
			   <div id="contracts_div" style="display:inline;">
				   <xsl:call-template name="multichoice-field">
				    <xsl:with-param name="label">XSL_FX_CONTRACTS</xsl:with-param>
				    <xsl:with-param name="name">fx_rates_type</xsl:with-param>
				    <xsl:with-param name="id">fx_rates_type_2</xsl:with-param>
				    <xsl:with-param name="value">02</xsl:with-param>
				    <xsl:with-param name="type">radiobutton</xsl:with-param>
				    <xsl:with-param name="checked"><xsl:if test="fx_rates_type[. = '02']">Y</xsl:if></xsl:with-param> 
				    <xsl:with-param name="inline">Y</xsl:with-param>
				   </xsl:call-template>
			   </div>
		 </xsl:with-param>
	</xsl:call-template>
	</xsl:template>
  
  <!-- Exchange Rate  and Equivalent Amount-->
  <xsl:template name="exchange_rate">
       <xsl:call-template name="column-container">
           <xsl:with-param name="content">
              <xsl:call-template name="column-wrapper">
	            <xsl:with-param name="content">
	            <xsl:call-template name="input-field">
			    <xsl:with-param name="label">XSL_FX_EXCHANGE_RATE</xsl:with-param>
			    <xsl:with-param name="name">fx_exchange_rate</xsl:with-param>
			    <xsl:with-param name="type">text</xsl:with-param>
			    <xsl:with-param name="fieldsize">small</xsl:with-param>
			    <xsl:with-param name="readonly">Y</xsl:with-param>
			    <xsl:with-param name="required">N</xsl:with-param>
			    <xsl:with-param name="maxsize">12</xsl:with-param>
			    <xsl:with-param name="override-constraints">{pattern:'####.#######'}</xsl:with-param>
			    <xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
			   </xsl:call-template>
			     <!-- Exchange Rate Message -->
			    &nbsp;<span style="font-weight:bold;"><xsl:value-of select="localization:getGTPString($language, 'XSL_FX_BOARD_RATE_LABEL')"></xsl:value-of></span>				    
			    </xsl:with-param>
			   </xsl:call-template>                    
             <xsl:call-template name="column-wrapper">
               <xsl:with-param name="content">
               <xsl:call-template name="currency-field">
			    <xsl:with-param name="label">XSL_FX_EQUIVALENT_AMT</xsl:with-param>
			    <xsl:with-param name="override-amt-name">fx_exchange_rate_amt</xsl:with-param>
			    <xsl:with-param name="override-currency-name">fx_exchange_rate_cur_code</xsl:with-param>
			    <xsl:with-param name="currency-readonly">Y</xsl:with-param>
			    <xsl:with-param name="amt-readonly">Y</xsl:with-param>
			    <xsl:with-param name="show-button">N</xsl:with-param>
			  </xsl:call-template>
		      </xsl:with-param>
           </xsl:call-template>
           </xsl:with-param>
        </xsl:call-template>
      </xsl:template>
  
  <!-- Tolerance Rate and EQuivalent Amount -->
    <xsl:template name="tolerance_rate">
    <div id="tolerance_div">
       <xsl:call-template name="column-container">
           <xsl:with-param name="content">
              <xsl:call-template name="column-wrapper">
	            <xsl:with-param name="content">
	            <xsl:call-template name="input-field">
			    <xsl:with-param name="label">XSL_FX_TOLERANCE_RATE</xsl:with-param>
			    <xsl:with-param name="name">fx_tolerance_rate</xsl:with-param>
			     <xsl:with-param name="type">text</xsl:with-param>
			    <xsl:with-param name="fieldsize">small</xsl:with-param>
			    <xsl:with-param name="required">N</xsl:with-param>
			    <xsl:with-param name="maxsize">12</xsl:with-param>
			    <xsl:with-param name="value"><xsl:value-of select="fx_tolerance_rate"/></xsl:with-param>			   
			    <xsl:with-param name="override-constraints">{pattern:'####.#######'}</xsl:with-param>
			    </xsl:call-template>
		        </xsl:with-param>
             </xsl:call-template>
             <xsl:call-template name="column-wrapper">
               <xsl:with-param name="content">
			   <xsl:call-template name="currency-field">
			    <xsl:with-param name="label">XSL_FX_EQUIVALENT_AMT</xsl:with-param>
			    <xsl:with-param name="override-amt-name">fx_tolerance_rate_amt</xsl:with-param>
			    <xsl:with-param name="override-currency-name">fx_tolerance_rate_cur_code</xsl:with-param>
			    <xsl:with-param name="currency-readonly">Y</xsl:with-param>
			    <xsl:with-param name="amt-readonly">Y</xsl:with-param>
			    <xsl:with-param name="show-button">N</xsl:with-param>
			      <xsl:with-param name="override-constraints">{pattern:'####.#######'}</xsl:with-param>
			  </xsl:call-template>
		      </xsl:with-param>
           </xsl:call-template>
           </xsl:with-param>
        </xsl:call-template>
     </div>
  </xsl:template>
  
  <!--  Hidden fields related tolerance -->
  <xsl:template name="tolernace-hidden-fields">
  	   <xsl:call-template name="hidden-field">
	    <xsl:with-param name="name">fx_tolerance_rate</xsl:with-param>
	    <xsl:with-param name="value" select="''"/>
	   </xsl:call-template>
	    <xsl:call-template name="hidden-field">
	    <xsl:with-param name="name">fx_tolerance_rate_cur_code</xsl:with-param>
	    <xsl:with-param name="value" select="''"/>
	   </xsl:call-template>
	   <xsl:call-template name="hidden-field">
	    <xsl:with-param name="name">fx_tolerance_rate_amt</xsl:with-param>
	    <xsl:with-param name="value" select="''"/>
	   </xsl:call-template>
  </xsl:template>
	
</xsl:stylesheet>