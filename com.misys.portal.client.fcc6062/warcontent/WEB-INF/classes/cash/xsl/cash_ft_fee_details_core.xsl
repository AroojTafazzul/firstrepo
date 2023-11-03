<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xmlRender="xalan://com.misys.portal.product.util.XMLProductRender"
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
	xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
	xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
	xmlns:ftProcessing="xalan://com.misys.portal.cash.common.services.FTProcessing"
	xmlns:collabutils="xalan://com.misys.portal.common.tools.CollaborationUtils"
	xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
	xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools"
	exclude-result-prefixes="xmlRender localization ftProcessing securitycheck utils security collabutils defaultresource converttools">
	
	<xsl:template name="ft-fee-details">
	<xsl:call-template name="fieldset-wrapper">
	<xsl:with-param name="legend">XSL_FT_HEADER_FEE_DETAILS</xsl:with-param>
	<xsl:with-param name="override-displaymode" select="$displaymode"/>
	<xsl:with-param name="content">
	<div id="FEE_DETAILS_CONFIRMATION_DISCLAIMER" class="ftDisclaimer intDisclaimer" style="display: none;">
	<xsl:call-template name="simple-disclaimer">
		<xsl:with-param name="label">XSL_FT_FEE_DETAILS_CONFIRMATION_DISCLAIMER</xsl:with-param>
	</xsl:call-template>
	</div>
		<div id="ft-fee-details-template" style="display:none">
			<div class="clear multigrid">
			<xsl:call-template name="column-wrapper">
			   <xsl:with-param name="content">  
			   <button type="button" dojoType="dijit.form.Button" id="add_fee_details_button">
					<xsl:attribute name="onClick">misys.viewFeeDetails();</xsl:attribute>
					<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_VIEW_FEES')" />
				</button>
			   	</xsl:with-param>
		   		</xsl:call-template>
			</div>
		</div>
	<div id="FEE_DETAILS_DISCLAIMER" class="ftDisclaimer intDisclaimer" style="display: none;">
		<xsl:call-template name="simple-disclaimer">
			<xsl:with-param name="label">XSL_FT_FEE_DETAILS_DISCLAIMER</xsl:with-param>
		</xsl:call-template>
	</div>	
	<div id="NO_FEE_DETAILS_DISCLAIMER" class="ftDisclaimer intDisclaimer" style="display: none;">
			<xsl:call-template name="simple-disclaimer">
				<xsl:with-param name="label">XSL_FT_NO_FEE_DETAILS_DISCLAIMER</xsl:with-param>
			</xsl:call-template>
	</div>
	<div id="NO_FEE_DETAILS_DISCLAIMER_BEN" class="ftDisclaimer intDisclaimer" style="display: none;">
		<xsl:call-template name="simple-disclaimer">
			<xsl:with-param name="label">XSL_FT_FEE_DETAILS_DISCLAIMER_BEN</xsl:with-param>
		</xsl:call-template>
	</div>	
	<div id="NO_FEES_FOR_RECCURING_PAYMENT" class="ftDisclaimer intDisclaimer" style="display: none;">
	<xsl:call-template name="simple-disclaimer">
		<xsl:with-param name="label">XSL_FT_NO_FEES_FOR_RECCURING_PAYMENT</xsl:with-param>
	</xsl:call-template>
	</div>
	<div id="XSL_FEE_DETILS_ERROR" class="ftDisclaimer intDisclaimer" style="display: none;">
	<xsl:call-template name="simple-disclaimer">
		<xsl:with-param name="label">XSL_FEE_DETILS_ERROR</xsl:with-param>
	</xsl:call-template>
	</div>
	<xsl:call-template name="hidden-field">
	<xsl:with-param name="name">is_view_fees_btn</xsl:with-param>
	<xsl:with-param name="id">is_view_fees_btn</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="hidden-field">
	<xsl:with-param name="name">to_currency</xsl:with-param>
	<xsl:with-param name="id">to_currency</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="hidden-field">
	<xsl:with-param name="name">to_currency_amount</xsl:with-param>
	<xsl:with-param name="id">to_currency_amount</xsl:with-param>
</xsl:call-template>
<xsl:call-template name="hidden-field">
	<xsl:with-param name="name">response_status</xsl:with-param>
	<xsl:with-param name="id">response_status</xsl:with-param>
</xsl:call-template>
<div id="ft_fee_details_div">

 <div id="fee_details_div">
	<div id="fee_transaction_details_div" style="display: none;">	 	
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_FT_HEADER_TRANSACTION_FEE_DETAILS</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="content">
			<div id="transaction_details_div" style="display: none;" class="feeDetails">
			  <xsl:call-template name="column-container">
			  <xsl:with-param name="override-displaymode" select="$displaymode"/>
			     <xsl:with-param name="content">
			     <xsl:call-template name="column-wrapper">
			     <xsl:with-param name="content">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_FT_FEE_NAME</xsl:with-param>
						<xsl:with-param name="name">fee_name_</xsl:with-param>	
						<xsl:with-param name="id">debit_fee_name</xsl:with-param>
						<xsl:with-param name="value" ></xsl:with-param>
						<xsl:with-param name="readonly">Y</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_FT_FEE_AMOUNT</xsl:with-param>	
						<xsl:with-param name="name">fee_amt_</xsl:with-param>
						<xsl:with-param name="id">debit_fee_amt</xsl:with-param>
						<xsl:with-param name="readonly">Y</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_FT_TAX_AMOUNT</xsl:with-param>	
						<xsl:with-param name="name">tax_amount_</xsl:with-param>
						<xsl:with-param name="id">debit_tax_amount</xsl:with-param>
						<xsl:with-param name="readonly">Y</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_FT_TAX_ON_TAX_AMOUNT</xsl:with-param>	
						<xsl:with-param name="name">tax_on_tax_amt_</xsl:with-param>
						<xsl:with-param name="id">debit_tax_on_tax_amt</xsl:with-param>
						<xsl:with-param name="readonly">Y</xsl:with-param>
					</xsl:call-template>
		</xsl:with-param>
	    	</xsl:call-template>
	    	<xsl:call-template name="column-wrapper">
				 <xsl:with-param name="content">
				 	<xsl:call-template name="hidden-field">
						<xsl:with-param name="label">XSL_FT_REBATE_AMOUNT</xsl:with-param>	
						<xsl:with-param name="name">rebate_amt_</xsl:with-param>
						<xsl:with-param name="id">debit_rebate_amt</xsl:with-param>
						<xsl:with-param name="readonly">Y</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label"></xsl:with-param>
						<xsl:with-param name="name">input-field10</xsl:with-param>	
						<xsl:with-param name="id">input-field10</xsl:with-param>	
						<xsl:with-param name="readonly">Y</xsl:with-param>
					</xsl:call-template>
				 	<xsl:call-template name="input-field">
						<xsl:with-param name="label"></xsl:with-param>
						<xsl:with-param name="name">input-field1</xsl:with-param>	
						<xsl:with-param name="id">input-field1</xsl:with-param>	
						<xsl:with-param name="readonly">Y</xsl:with-param>
					</xsl:call-template>
				 	<xsl:call-template name="input-field">
						<xsl:with-param name="label"></xsl:with-param>
						<xsl:with-param name="name">input-field2</xsl:with-param>	
						<xsl:with-param name="id">input-field2</xsl:with-param>	
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_FT_TOTAL_FEES</xsl:with-param>	
						<xsl:with-param name="name">total_fee_</xsl:with-param>
						<xsl:with-param name="id">debit_total_fee</xsl:with-param>
						<xsl:with-param name="readonly">Y</xsl:with-param>
					</xsl:call-template>
				 </xsl:with-param>
			</xsl:call-template>
		   </xsl:with-param>
	       </xsl:call-template>
	       </div>
	    </xsl:with-param>
	  </xsl:call-template>
	</div> 
	
	<div id="total_transaction_fee_details" class="feeDetails" style="display: none;">
	  <xsl:call-template name="column-container">
        	<xsl:with-param name="content">
	    	<xsl:call-template name="column-wrapper">
				 <xsl:with-param name="content">
				 	<xsl:call-template name="input-field">
						<xsl:with-param name="label"></xsl:with-param>
						<xsl:with-param name="name">input-field3</xsl:with-param>	
						<xsl:with-param name="id">input-field3</xsl:with-param>	
						<xsl:with-param name="readonly">Y</xsl:with-param>
						</xsl:call-template>
				 </xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="column-wrapper">
            <xsl:with-param name="content">
				<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_FT_TOTAL_TRANSACTION_FEES</xsl:with-param>	
						<xsl:with-param name="name">total_transaction_fees</xsl:with-param>
						<xsl:with-param name="id">total_transaction_fees</xsl:with-param>
						<xsl:with-param name="readonly">Y</xsl:with-param>
					</xsl:call-template>
               </xsl:with-param>
           </xsl:call-template>
			</xsl:with-param>
			</xsl:call-template>
		</div>
	   <div id="fee_agent_details_div" style="display: none;">	 	 	
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_FT_HEADER_AGENT_FEE_DETAILS</xsl:with-param>
			<xsl:with-param name="legend-type">indented-header</xsl:with-param>
			<xsl:with-param name="content">
			<div id="agent_details_div" style="display: none;" class="feeDetails">
			  <xsl:call-template name="column-container">
			     <xsl:with-param name="content">
			     <xsl:call-template name="column-wrapper">
			     <xsl:with-param name="content">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_FT_FEE_NAME</xsl:with-param>
						<xsl:with-param name="name">fee_name_</xsl:with-param>	
						<xsl:with-param name="id">agent_fee_name</xsl:with-param>	
						<xsl:with-param name="readonly">Y</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_FT_FEE_AMOUNT</xsl:with-param>	
						<xsl:with-param name="name">fee_amt_</xsl:with-param>
						<xsl:with-param name="id">agent_fee_amt</xsl:with-param>
						<xsl:with-param name="readonly">Y</xsl:with-param>	
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_FT_TAX_AMOUNT</xsl:with-param>	
						<xsl:with-param name="name">tax_amount_</xsl:with-param>
						<xsl:with-param name="id">agent_tax_amount</xsl:with-param>
						<xsl:with-param name="readonly">Y</xsl:with-param>
						</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_FT_TAX_ON_TAX_AMOUNT</xsl:with-param>	
						<xsl:with-param name="name">tax_on_tax_amt_</xsl:with-param>
						<xsl:with-param name="id">agent_tax_on_tax_amt</xsl:with-param>
						<xsl:with-param name="readonly">Y</xsl:with-param>
					</xsl:call-template>
					</xsl:with-param>
	    	</xsl:call-template>
	    	<xsl:call-template name="column-wrapper">
				 <xsl:with-param name="content">
				 	<xsl:call-template name="hidden-field">
						<xsl:with-param name="label">XSL_FT_REBATE_AMOUNT</xsl:with-param>	
						<xsl:with-param name="name">rebate_amt_</xsl:with-param>
						<xsl:with-param name="id">agent_rebate_amt</xsl:with-param>
						<xsl:with-param name="readonly">Y</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label"></xsl:with-param>
						<xsl:with-param name="name">input-field9</xsl:with-param>	
						<xsl:with-param name="id">input-field9</xsl:with-param>	
						<xsl:with-param name="readonly">Y</xsl:with-param>
					</xsl:call-template>
				 	<xsl:call-template name="input-field">
						<xsl:with-param name="label"></xsl:with-param>
						<xsl:with-param name="name">input-field5</xsl:with-param>	
						<xsl:with-param name="id">input-field5</xsl:with-param>	
						<xsl:with-param name="readonly">Y</xsl:with-param>
					</xsl:call-template>
					 	<xsl:call-template name="input-field">
						<xsl:with-param name="label"></xsl:with-param>
						<xsl:with-param name="name">input-field6</xsl:with-param>	
						<xsl:with-param name="id">input-field6</xsl:with-param>	
						<xsl:with-param name="readonly">Y</xsl:with-param>
					</xsl:call-template>
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_FT_TOTAL_FEES</xsl:with-param>	
						<xsl:with-param name="name">total_fee_</xsl:with-param>
						<xsl:with-param name="id">agent_total_fee</xsl:with-param>
						<xsl:with-param name="readonly">Y</xsl:with-param>
					</xsl:call-template>
				 </xsl:with-param>
			</xsl:call-template>
		   </xsl:with-param>
	       </xsl:call-template>
	       </div>
	      </xsl:with-param>
	  </xsl:call-template>
	  </div>
	  <div id="total_agent_fee_details" class="feeDetails" style="display: none;">
	  <xsl:call-template name="column-container">
        	<xsl:with-param name="content">
	    	<xsl:call-template name="column-wrapper">
				 <xsl:with-param name="content">
				 	<xsl:call-template name="input-field">
						<xsl:with-param name="label"></xsl:with-param>
						<xsl:with-param name="name">input-field7</xsl:with-param>	
						<xsl:with-param name="id">input-field7</xsl:with-param>	
						<xsl:with-param name="readonly">Y</xsl:with-param>
						<xsl:with-param name="value" >
						</xsl:with-param>
					</xsl:call-template>
				 </xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="column-wrapper">
            <xsl:with-param name="content">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_FT_TOTAL_AGENT_FEES</xsl:with-param>	
						<xsl:with-param name="name">total_agent_fees</xsl:with-param>
						<xsl:with-param name="id">total_agent_fees</xsl:with-param>
						<xsl:with-param name="readonly">Y</xsl:with-param>
					</xsl:call-template>
               </xsl:with-param>
           </xsl:call-template>
			</xsl:with-param>
			</xsl:call-template>
		</div>
	  </div>
	  <div id="grand_total_fee_details" class="feeDetails" style="display: none;">
	  <xsl:call-template name="column-container">
        	<xsl:with-param name="content">
	    	<xsl:call-template name="column-wrapper">
				 <xsl:with-param name="content">
				 	<xsl:call-template name="input-field">
						<xsl:with-param name="label"></xsl:with-param>
						<xsl:with-param name="name">input-field8</xsl:with-param>	
						<xsl:with-param name="id">input-field8</xsl:with-param>	
						<xsl:with-param name="readonly">Y</xsl:with-param>
						<xsl:with-param name="value" >
						</xsl:with-param>
					</xsl:call-template>
				 </xsl:with-param>
			</xsl:call-template>
			<xsl:call-template name="column-wrapper">
            <xsl:with-param name="content">
					<xsl:call-template name="input-field">
						<xsl:with-param name="label">XSL_GRAND_TOTAL_FEES</xsl:with-param>	
						<xsl:with-param name="name">grand_total_fees</xsl:with-param>
						<xsl:with-param name="id">grand_total_fees</xsl:with-param>
						<xsl:with-param name="readonly">Y</xsl:with-param>
					</xsl:call-template>
               </xsl:with-param>
           </xsl:call-template>
			</xsl:with-param>
			</xsl:call-template>
		</div>
		<div id="FEE_CHARGES_DETAILS_DISCLAIMER" class="ftDisclaimer intDisclaimer" style="display: none;">
			<xsl:call-template name="simple-disclaimer">
				<xsl:with-param name="label">XSL_FT_FEE_CHARGES_DISCLAIMER</xsl:with-param>
			</xsl:call-template>
		</div>
		</div>
	  </xsl:with-param>
</xsl:call-template>
	</xsl:template>
<xsl:template name="ft-fee-details-view">
	 <xsl:call-template name="fieldset-wrapper">
	 <xsl:with-param name="legend">XSL_FT_HEADER_FEE_DETAILS</xsl:with-param>
	 <xsl:with-param name="content">
	 	<div class="ftDisclaimer intDisclaimer">
			<xsl:call-template name="simple-disclaimer">
				<xsl:with-param name="label">XSL_FT_FEE_DETAILS_DISCLAIMER_VIEW</xsl:with-param>
			</xsl:call-template>
		</div>
	 <xsl:call-template name="fieldset-wrapper">
	  <xsl:with-param name="legend">XSL_FT_HEADER_TRANSACTION_FEE_DETAILS</xsl:with-param>
	  <xsl:with-param name="legend-type">indented-header</xsl:with-param>
	  <xsl:with-param name="content">
	  <xsl:for-each select="payment_fee_details/Debit_fees/feeDetails">
	  <xsl:call-template name="fieldset-wrapper">
	  	<xsl:with-param name="legend"></xsl:with-param>
	  	<xsl:with-param name="content">
	    
	    <xsl:call-template name="row-wrapper">
		<xsl:with-param name="label">XSL_FT_FEE_NAME</xsl:with-param>
		<xsl:with-param name="content"><div class="content">
		<xsl:value-of select="fee_name"/>
		</div></xsl:with-param>
		</xsl:call-template>
		
	    <xsl:call-template name="row-wrapper">
		<xsl:with-param name="label">XSL_FT_FEE_AMOUNT</xsl:with-param>
		<xsl:with-param name="content"><div class="content">
		<xsl:value-of select="fee_ccy"/>&nbsp;<xsl:value-of select="fee_amt"/>
		</div></xsl:with-param>
		</xsl:call-template>

		<xsl:call-template name="row-wrapper">
		<xsl:with-param name="label">XSL_FT_TAX_AMOUNT</xsl:with-param>
		<xsl:with-param name="content"><div class="content">
		<xsl:value-of select="fee_ccy"/>&nbsp;<xsl:value-of select="tax_amount"/>
		</div></xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="row-wrapper">
		<xsl:with-param name="label">XSL_FT_TAX_ON_TAX_AMOUNT</xsl:with-param>
		<xsl:with-param name="content"><div class="content">
		<xsl:value-of select="fee_ccy"/>&nbsp;<xsl:value-of select="tax_on_tax_amt"/>
		</div></xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="hidden-field">
		<xsl:with-param name="label">XSL_FT_PAYING_PARTY</xsl:with-param>
		<xsl:with-param name="content"><div class="content">
		<xsl:value-of select="paying_party"/>
		</div></xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="hidden-field">
		<xsl:with-param name="label">XSL_FT_REBATE_AMOUNT</xsl:with-param>
		<xsl:with-param name="content"><div class="content">
		<xsl:value-of select="fee_ccy"/>&nbsp;<xsl:value-of select="rebate_amt"/>
		</div></xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="row-wrapper">
		<xsl:with-param name="label">XSL_FT_TOTAL_FEES</xsl:with-param>
		<xsl:with-param name="content"><div class="content">
		<xsl:value-of select="fee_ccy"/>&nbsp;<xsl:value-of select="total_fee"/>
		</div></xsl:with-param>
		</xsl:call-template>
		
		<xsl:if test="total_transaction_fee != 0.00">
		<xsl:call-template name="row-wrapper">
		<xsl:with-param name="label">XSL_FT_TOTAL_TRANSACTION_FEES</xsl:with-param>
		<xsl:with-param name="content"><div class="content">
		<xsl:value-of select="fee_ccy"/>&nbsp;<xsl:value-of select="total_transaction_fee"/>
		</div></xsl:with-param>
		</xsl:call-template>
		</xsl:if>
		
		<xsl:if test="grand_total_fees != 0.00">
		<xsl:call-template name="row-wrapper">
		<xsl:with-param name="label">XSL_GRAND_TOTAL_FEES</xsl:with-param>
		<xsl:with-param name="content"><div class="content">
		<xsl:value-of select="fee_ccy"/>&nbsp;<xsl:value-of select="grand_total_fees"/>
		</div></xsl:with-param>
		</xsl:call-template>
		</xsl:if>
		</xsl:with-param>
		</xsl:call-template>  
	  </xsl:for-each>
	  </xsl:with-param>
	  </xsl:call-template>
	  <xsl:call-template name="fieldset-wrapper">
	  <xsl:with-param name="legend">XSL_FT_HEADER_AGENT_FEE_DETAILS</xsl:with-param>
	  <xsl:with-param name="legend-type">indented-header</xsl:with-param>
	  <xsl:with-param name="content">
	  <xsl:for-each select="payment_fee_details/Agent_fees/feeDetails">	   
	   <xsl:call-template name="fieldset-wrapper">
	  	<xsl:with-param name="legend"></xsl:with-param>
	  	<xsl:with-param name="content">
	  	
	  	<xsl:call-template name="row-wrapper">
		<xsl:with-param name="label">XSL_FT_FEE_NAME</xsl:with-param>
		<xsl:with-param name="content"><div class="content">
		<xsl:value-of select="fee_name"/>
		</div></xsl:with-param>
		</xsl:call-template>
		
	    <xsl:call-template name="row-wrapper">
		<xsl:with-param name="label">XSL_FT_FEE_AMOUNT</xsl:with-param>
		<xsl:with-param name="content"><div class="content">
		<xsl:value-of select="fee_ccy"/>&nbsp;<xsl:value-of select="fee_amt"/>
		</div></xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="row-wrapper">
		<xsl:with-param name="label">XSL_FT_TAX_AMOUNT</xsl:with-param>
		<xsl:with-param name="content"><div class="content">
		<xsl:value-of select="fee_ccy"/>&nbsp;<xsl:value-of select="tax_amount"/>
		</div></xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="row-wrapper">
		<xsl:with-param name="label">XSL_FT_TAX_ON_TAX_AMOUNT</xsl:with-param>
		<xsl:with-param name="content"><div class="content">
		<xsl:value-of select="fee_ccy"/>&nbsp;<xsl:value-of select="tax_on_tax_amt"/>
		</div></xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="hidden-field">
		<xsl:with-param name="label">XSL_FT_PAYING_PARTY</xsl:with-param>
		<xsl:with-param name="content"><div class="content">
		<xsl:value-of select="paying_party"/>
		</div></xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="hidden-field">
		<xsl:with-param name="label">XSL_FT_REBATE_AMOUNT</xsl:with-param>
		<xsl:with-param name="content"><div class="content">
		<xsl:value-of select="fee_ccy"/>&nbsp;<xsl:value-of select="rebate_amt"/>
		</div></xsl:with-param>
		</xsl:call-template>
		
		<xsl:call-template name="row-wrapper">
		<xsl:with-param name="label">XSL_FT_TOTAL_FEES</xsl:with-param>
		<xsl:with-param name="content"><div class="content">
		<xsl:value-of select="fee_ccy"/>&nbsp;<xsl:value-of select="total_fee"/>
		</div></xsl:with-param>
		</xsl:call-template>
		
		<xsl:if test="total_agent_fee != 0.00">
		<xsl:call-template name="row-wrapper">
		<xsl:with-param name="label">XSL_FT_TOTAL_AGENT_FEES</xsl:with-param>
		<xsl:with-param name="content"><div class="content">
		<xsl:value-of select="fee_ccy"/>&nbsp;<xsl:value-of select="total_agent_fee"/>
		</div></xsl:with-param>
		</xsl:call-template>
		</xsl:if>
		
		<xsl:call-template name="row-wrapper">
		<xsl:with-param name="label">XSL_GRAND_TOTAL_FEES</xsl:with-param>
		<xsl:with-param name="content"><div class="content">
		<xsl:value-of select="fee_ccy"/>&nbsp;<xsl:value-of select="grand_total_fees"/>
		</div></xsl:with-param>
		</xsl:call-template>
		</xsl:with-param>
		</xsl:call-template>
		
	  
	  </xsl:for-each>
	  </xsl:with-param>
	  </xsl:call-template>
	 </xsl:with-param>
	 </xsl:call-template>
	 </xsl:template>	
	</xsl:stylesheet>