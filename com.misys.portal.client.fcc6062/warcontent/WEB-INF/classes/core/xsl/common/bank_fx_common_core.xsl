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

  <xsl:param name="rundata"/>
  <xsl:param name="language">en</xsl:param>
  
  <xsl:template name="bank-fx-template">
  <xsl:param name="override-displaymode"/>
  <div id ="fx-section">
  <xsl:if test="fx_rates_type[.!=''] and ((fx_rates_type[.='01'] and fx_exchange_rate and fx_exchange_rate[.!='']) or (fx_rates_type[.='02']))">
    <xsl:call-template name="fieldset-wrapper">
    <xsl:with-param name="legend">XSL_HEADER_EXCHANGE_RATE</xsl:with-param>
    <xsl:with-param name="content">
    <!-- Exchange Rage Types -->
    <xsl:call-template name="fx_types">
    	<xsl:with-param name="override-displaymode" select="$override-displaymode"></xsl:with-param>
    </xsl:call-template>
    <!-- Board Rates Fields -->
    <div id="fx-board-rate-type">
    <!-- Exchange Rate  and Equivalent Amount-->
    <xsl:call-template name="exchange_rate">
    	<xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>

    <xsl:call-template name="tolerance_rate">
    	<xsl:with-param name="override-displaymode">view</xsl:with-param>
    </xsl:call-template>

    <!-- Tolerance Rate and Equivalent Amount -->

	</div>
    <!-- FX Contracts Fields -->
    <div id="fx-contracts-type">
	    <xsl:call-template name="fx-contracts">
	    	<xsl:with-param name="override-displaymode" select="$override-displaymode"></xsl:with-param>
	    </xsl:call-template>
	    <xsl:call-template name="total-amt-utilise">
	    	<xsl:with-param name="override-displaymode" select="$override-displaymode"></xsl:with-param>
	    </xsl:call-template>
	</div>
	<div id="contractMsgDiv" style="float: left;margin-left:65px" >
    </div>
	<div id="totalUtiliseDiv" style="float:left;">
	</div>
    <div id="hideDiv" style="display : None">
     <xsl:call-template name="currency-field">
	    <xsl:with-param name="label">XSL_FX_EQUIVALENT_AMT</xsl:with-param>
	    <xsl:with-param name="override-amt-name">contract_nbr_amt</xsl:with-param>
	    <xsl:with-param name="override-currency-name">contract_nbr_cur_code</xsl:with-param>
	    <xsl:with-param name="currency-readonly">Y</xsl:with-param>
	    <xsl:with-param name="amt-readonly">N</xsl:with-param>
	    <xsl:with-param name="show-button">N</xsl:with-param>
	  </xsl:call-template>
	 
	  </div>
	   <script>
    	dojo.ready(function(){
    	   dojo.require("misys.binding.common.bank_create_fx");
			misys._config = misys._config || {};
			dojo.mixin(misys._config, {
				});
			});
    </script>
    </xsl:with-param>
    </xsl:call-template>
    </xsl:if>
  </div>
  </xsl:template>
  
  <!-- Exchange Rage Types -->
   <xsl:template name="fx_types">
   <xsl:param name="override-displaymode"/>
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
			    <xsl:with-param name="readonly">
			    	<xsl:choose>
			    		<xsl:when test="$override-displaymode != ''">N</xsl:when>
			    		<xsl:otherwise>N</xsl:otherwise>
			    	</xsl:choose>
			    </xsl:with-param>
			    <xsl:with-param name="disabled">
			    	<xsl:choose>
			    		<xsl:when test="$override-displaymode != 'view'">N</xsl:when>
			    		<xsl:otherwise>Y</xsl:otherwise>
			    	</xsl:choose>
			    </xsl:with-param>
			   </xsl:call-template>
			   <xsl:call-template name="multichoice-field">
			    <xsl:with-param name="label">XSL_FX_CONTRACTS</xsl:with-param>
			    <xsl:with-param name="name">fx_rates_type</xsl:with-param>
			    <xsl:with-param name="id">fx_rates_type_2</xsl:with-param>
			    <xsl:with-param name="value">02</xsl:with-param>
			    <xsl:with-param name="type">radiobutton</xsl:with-param>
			    <xsl:with-param name="checked"><xsl:if test="fx_rates_type[. = '02']">Y</xsl:if></xsl:with-param> 
			    <xsl:with-param name="inline">Y</xsl:with-param>
			    <xsl:with-param name="readonly">
			    	<xsl:choose>
			    		<xsl:when test="$override-displaymode != ''">N</xsl:when>
			    		<xsl:otherwise>N</xsl:otherwise>
			    	</xsl:choose>
			    </xsl:with-param>
			    <xsl:with-param name="disabled">
			    	<xsl:choose>
			    		<xsl:when test="$override-displaymode != 'view'">N</xsl:when>
			    		<xsl:otherwise>Y</xsl:otherwise>
			    	</xsl:choose>
			    </xsl:with-param>
			   </xsl:call-template>
		 </xsl:with-param>
	</xsl:call-template>
	</xsl:template>
  
  <!-- Exchange Rate  and Equivalent Amount-->
  <xsl:template name="exchange_rate">
  	<xsl:param name="override-displaymode"/>
       <xsl:call-template name="column-container">
           <xsl:with-param name="content">
              <xsl:call-template name="column-wrapper">
	            <xsl:with-param name="content">
	            <xsl:call-template name="input-field">
			    <xsl:with-param name="label">XSL_FX_EXCHANGE_RATE</xsl:with-param>
			    <xsl:with-param name="name">fx_exchange_rate</xsl:with-param>
			    <xsl:with-param name="type">text</xsl:with-param>
			    <xsl:with-param name="fieldsize">small</xsl:with-param>
			    <xsl:with-param name="readonly">N</xsl:with-param>
			    <xsl:with-param name="required">N</xsl:with-param>
			    <xsl:with-param name="maxsize">12</xsl:with-param>
			    <xsl:with-param name="override-constraints">{pattern:'####.#######'}</xsl:with-param>
			    <xsl:with-param name="appendClass">inlineBlock</xsl:with-param>
			   <xsl:with-param name="override-displaymode">view</xsl:with-param>
			    </xsl:call-template>
			       <!-- Exchange Rate Message -->
			    <xsl:if test="fx_rates_type[.=01]">
			    &nbsp;<span style="font-weight:bold;"><xsl:value-of select="localization:getGTPString($language, 'XSL_FX_BOARD_RATE_LABEL')"></xsl:value-of></span>
			    </xsl:if>				    
			  </xsl:with-param>
             </xsl:call-template>
             <xsl:call-template name="column-wrapper">
               <xsl:with-param name="content">
              	 <xsl:if test="fx_exchange_rate != ''"> 
		               <xsl:call-template name="input-field">
					    <xsl:with-param name="label">XSL_FX_EQUIVALENT_AMT</xsl:with-param>
					    <xsl:with-param name="override-amt-name">fx_exchange_rate_amt</xsl:with-param>
					    <xsl:with-param name="override-currency-name">fx_exchange_rate_cur_code</xsl:with-param>
					   <!--  <xsl:with-param name="currency-readonly">N</xsl:with-param>
					    <xsl:with-param name="amt-readonly">N</xsl:with-param>
					    <xsl:with-param name="show-button">N</xsl:with-param> -->
					     <xsl:with-param name="value"><xsl:value-of select="fx_exchange_rate_cur_code"/>&#160;<xsl:value-of select="fx_exchange_rate_amt"/></xsl:with-param>
						<xsl:with-param name="override-displaymode">view</xsl:with-param>
					  </xsl:call-template>
					</xsl:if>
		      </xsl:with-param>
           </xsl:call-template>
           </xsl:with-param>
        </xsl:call-template>
  </xsl:template>
  
  <!-- Tolerance Rate and EQuivalent Amount -->
    <xsl:template name="tolerance_rate">
    <xsl:param name="override-displaymode"/>
    <div id="tolerance_div">
       <xsl:call-template name="column-container">
           <xsl:with-param name="content">
              <xsl:call-template name="column-wrapper">
	            <xsl:with-param name="content">
	            <xsl:call-template name="input-field">
			    <xsl:with-param name="label">XSL_FX_TOLERANCE_RATE</xsl:with-param>
			    <xsl:with-param name="name">fx_tolerance_rate</xsl:with-param>
			    <xsl:with-param name="fieldsize">small</xsl:with-param>
			    <xsl:with-param name="required">N</xsl:with-param>
			    <xsl:with-param name="type">text</xsl:with-param>
			    <xsl:with-param name="maxsize">12</xsl:with-param>
			    <xsl:with-param name="override-constraints">{pattern:'####.#######'}</xsl:with-param>
			    <xsl:with-param name="override-displaymode">view</xsl:with-param>
			    </xsl:call-template>
		        </xsl:with-param>
             </xsl:call-template>
             <xsl:call-template name="column-wrapper">
               <xsl:with-param name="content">
                   <xsl:if test="fx_tolerance_rate != ''"> 
					   <xsl:call-template name="input-field">
					    <xsl:with-param name="label">XSL_FX_EQUIVALENT_AMT</xsl:with-param>
					    <xsl:with-param name="name">fx_tolerance_rate_amt</xsl:with-param>
					    <xsl:with-param name="currency-name">fx_tolerance_rate_cur_code</xsl:with-param>
					    <xsl:with-param name="value"><xsl:value-of select="fx_tolerance_rate_cur_code"/>&#160;<xsl:value-of select="fx_tolerance_rate_amt"/></xsl:with-param>
					    <!-- <xsl:with-param name="currency-readonly">N</xsl:with-param>
					    <xsl:with-param name="amt-readonly">N</xsl:with-param>
					    <xsl:with-param name="show-button">N</xsl:with-param> -->
					    <xsl:with-param name="override-displaymode">view</xsl:with-param>
					   </xsl:call-template>
				</xsl:if>
		      </xsl:with-param>
           </xsl:call-template>
           </xsl:with-param>
        </xsl:call-template>
     </div>
  </xsl:template>

  <!-- FX Contracts Fields -->
  <xsl:template name="fx-contracts">
  <xsl:param name="override-displaymode"/>
  	<xsl:call-template name="nbr-of-fx-contracts-">
     <xsl:with-param name="i">1</xsl:with-param>
     <xsl:with-param name="count"><xsl:value-of select="fx_nbr_contracts"/></xsl:with-param>
     <xsl:with-param name="override-displaymode" select="$override-displaymode"></xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
  <xsl:template name="nbr-of-fx-contracts-">
  		<xsl:param name="override-displaymode"/>
	   <xsl:param name="i"/>
	   <xsl:param name="count" />
	   <xsl:if test="$i &lt;= $count">
	   <xsl:variable name="row"><xsl:value-of select="$i" /></xsl:variable>
	      <xsl:call-template name="fx-contract-nbr-fields">
	       <xsl:with-param name="row"><xsl:value-of select="$i" /></xsl:with-param>
	       <xsl:with-param name="override-displaymode">view</xsl:with-param>
	      </xsl:call-template>
	   </xsl:if>
	   <xsl:if test="$i &lt;= $count">
	      <xsl:call-template name="nbr-of-fx-contracts-">
	          <xsl:with-param name="i">
	              <xsl:value-of select="$i + 1"/>
	          </xsl:with-param>
	          <xsl:with-param name="count">
	              <xsl:value-of select="$count"/>
	          </xsl:with-param>
	         <xsl:with-param name="override-displaymode">view</xsl:with-param>
	      </xsl:call-template>
		</xsl:if>
  </xsl:template>
  
   <!-- Contract Number and Amount to Utilise Fields-->
  <xsl:template name="fx-contract-nbr-fields">
  <xsl:param name="override-displaymode"/>
  <xsl:param name="row" />
       <xsl:call-template name="column-container">
           <xsl:with-param name="content">
              <xsl:call-template name="column-wrapper">
	            <xsl:with-param name="content">
	            <xsl:call-template name="input-field">
			    <xsl:with-param name="label">XSL_FX_CONTRACT_NBR</xsl:with-param>
			    <xsl:with-param name="name">fx_contract_nbr_<xsl:value-of select="$row"/></xsl:with-param>
			    <xsl:with-param name="fieldsize">small</xsl:with-param>
			    <xsl:with-param name="maxsize">9</xsl:with-param>
			    <xsl:with-param name="required">N</xsl:with-param>
			   <xsl:with-param name="override-displaymode">view</xsl:with-param>
			    </xsl:call-template>
		        </xsl:with-param>
             </xsl:call-template>
             <xsl:call-template name="column-wrapper">
               <xsl:with-param name="content">
				<xsl:if test="//*[starts-with(name(), concat('fx_contract_nbr_', $row))] != ''"> 
					  <xsl:call-template name="input-field">
					    <xsl:with-param name="label">XSL_FX_EQUIVALENT_AMT</xsl:with-param>
					    <xsl:with-param name="name">fx_contract_nbr_amt_<xsl:value-of select="$row"/></xsl:with-param>
					    <xsl:with-param name="currency-name">fx_contract_nbr_cur_code_<xsl:value-of select="$row"/></xsl:with-param>
					    <xsl:with-param name="value">
					    <xsl:value-of select="//*[starts-with(name(), concat('fx_contract_nbr_cur_code_', $row))]"/>&#160;<xsl:value-of select="//*[starts-with(name(), concat('fx_contract_nbr_amt_', $row))]"/>
					    </xsl:with-param>
					   <!--  <xsl:with-param name="currency-readonly">N</xsl:with-param>
					    <xsl:with-param name="amt-readonly">N</xsl:with-param>
					    <xsl:with-param name="show-button">N</xsl:with-param> -->
					   <xsl:with-param name="override-displaymode">view</xsl:with-param>
					    <xsl:with-param name="fieldsize">small</xsl:with-param>
			    		<xsl:with-param name="maxsize">9</xsl:with-param>
					  </xsl:call-template>
				</xsl:if>
		      </xsl:with-param>
           </xsl:call-template>
           </xsl:with-param>
        </xsl:call-template>
  </xsl:template> 
  
   <xsl:template name="total-amt-utilise">
   		<xsl:param name="override-displaymode"/>
   		<xsl:if test="fx_rates_type[.='02']">
		       <xsl:call-template name="column-container">
		           <xsl:with-param name="content">
		              <xsl:call-template name="column-wrapper">
			            <xsl:with-param name="content">
			            <span style="font-weight:bold;"><xsl:value-of select="localization:getGTPString($language, 'XSL_FX_CONTRACT_LABEL')"></xsl:value-of></span>
			          </xsl:with-param>
		             </xsl:call-template>
		             <xsl:call-template name="column-wrapper">
		               <xsl:with-param name="content">
					  <xsl:call-template name="input-field">
					    <xsl:with-param name="label">XSL_FX_TOTAL_AMT_TO_UTILISE</xsl:with-param>
					    <xsl:with-param name="value"><xsl:value-of select="fx_total_utilise_cur_code"/>&#160;<xsl:value-of select="fx_total_utilise_amt"/></xsl:with-param>
					    <xsl:with-param name="override-currency-name">fx_total_utilise_cur_code</xsl:with-param>
					    <xsl:with-param name="currency-readonly">N</xsl:with-param>
					    <xsl:with-param name="amt-readonly">N</xsl:with-param>
					    <xsl:with-param name="show-button">N</xsl:with-param>
					    <xsl:with-param name="override-displaymode">view</xsl:with-param>
					  <!--   <xsl:with-param name="override-currency-displaymode">
							<xsl:choose>
							   	<xsl:when test="$override-displaymode != '' "><xsl:value-of select="$override-displaymode"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="$displaymode"/></xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
						<xsl:with-param name="override-amt-displaymode">
							<xsl:choose>
							   	<xsl:when test="$override-displaymode != '' "><xsl:value-of select="$override-displaymode"/></xsl:when>
								<xsl:otherwise><xsl:value-of select="$displaymode"/></xsl:otherwise>
							</xsl:choose>
						</xsl:with-param> -->
					  </xsl:call-template>
				      </xsl:with-param>
		           </xsl:call-template>
		           </xsl:with-param>
		        </xsl:call-template>
		     </xsl:if>
  </xsl:template>
	
	
</xsl:stylesheet>