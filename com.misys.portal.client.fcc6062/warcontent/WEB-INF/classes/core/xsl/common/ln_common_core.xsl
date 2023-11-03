<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates that are common to loan module
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
  version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
  xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
  xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
  xmlns:user="xalan://com.misys.portal.security.GTPUser"
  xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
  xmlns:loanIQ="xalan://com.misys.portal.loan.loaniq.LoanIQAdapter"
  exclude-result-prefixes="localization utils security user loanIQ defaultresource">

<xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
<xsl:param name="actionDownImage"><xsl:value-of select="$images_path"/>action-down.png</xsl:param>
<xsl:param name="actionUpImage"><xsl:value-of select="$images_path"/>action-up.png</xsl:param>

 
   
<!-- facility details -->
<xsl:template name="facility-details">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_FACILITY_DETAILS</xsl:with-param>
		<xsl:with-param name="legend-type">indented-header</xsl:with-param>
		<xsl:with-param name="content">

			<!-- deal -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_FACILITYDETAILS_DEAL</xsl:with-param>
				<xsl:with-param name="name">bo_deal_name</xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
				
			<!-- facility -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_FACILITYDETAILS_FACILITY</xsl:with-param>
				<xsl:with-param name="name">bo_facility_name</xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>

			<!-- facility fcn -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_FACILITYDETAILS_ID</xsl:with-param>
				<xsl:with-param name="name">fcn</xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
			
			<!-- facility issue (effective) date -->
   			<xsl:call-template name="input-field">
   				<xsl:with-param name="type">date</xsl:with-param>
     			<xsl:with-param name="label">XSL_LOAN_EFFECTIVE_DATE</xsl:with-param>
   	 			<xsl:with-param name="name">facility_effective_date</xsl:with-param>
   				<xsl:with-param name="override-displaymode">view</xsl:with-param>
    		</xsl:call-template>
    		
   			<!-- facility expiry date -->
   			<xsl:call-template name="input-field">
   				<xsl:with-param name="type">date</xsl:with-param>
     			<xsl:with-param name="label">XSL_GENERALDETAILS_EXPIRY_DATE</xsl:with-param>
   	 			<xsl:with-param name="name">facility_expiry_date</xsl:with-param>
   				<xsl:with-param name="override-displaymode">view</xsl:with-param>
    		</xsl:call-template>
   		
   			<!-- facility maturity date -->
   			<xsl:call-template name="input-field">
   				<xsl:with-param name="type">date</xsl:with-param>
     			<xsl:with-param name="label">XSL_GENERALDETAILS_MATURITY_DATE</xsl:with-param>
   	 			<xsl:with-param name="name">facility_maturity_date</xsl:with-param>
   				<xsl:with-param name="override-displaymode">view</xsl:with-param>
   			</xsl:call-template>
   		
   			<!-- borrower limit amount -->
			<xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_FACILITY_BORROWER_LIMIT</xsl:with-param>
				<xsl:with-param name="product-code">borrower_limit</xsl:with-param>
				<xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
				<xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
			</xsl:call-template>

	   		<!-- borrower available to draw -->
			<xsl:call-template name="currency-field">
				<xsl:with-param name="label">XSL_FACILITY_BORROWER_AVAILABLE</xsl:with-param>
				<xsl:with-param name="product-code">borrower_available</xsl:with-param>
				<xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
				<xsl:with-param name="override-amt-displaymode">view</xsl:with-param>
			</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>




<!-- Borrower Details -->
<xsl:template name="borrower-details">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_BANK_DETAILS</xsl:with-param>
		<xsl:with-param name="legend-type">indented-header</xsl:with-param>
		<xsl:with-param name="content">
			<xsl:call-template name="input-field">
	    		<xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
	     		<xsl:with-param name="label">XSL_PARTIESDETAILS_BANK_NAME</xsl:with-param>
	     		<xsl:with-param name="override-displaymode">view</xsl:with-param>
	     		<xsl:with-param name="value"><xsl:value-of select="issuing_bank/abbv_name"/></xsl:with-param>
    		</xsl:call-template>
    		<div style="white-space:pre;">
	   			<xsl:call-template name="input-field">
		    		<xsl:with-param name="name">borrower_reference</xsl:with-param>
		     		<xsl:with-param name="label">XSL_LOAN_BORROWER_REFERENCE</xsl:with-param>
		     		<xsl:with-param name="override-displaymode">view</xsl:with-param>
		     		<xsl:with-param name="value"><xsl:value-of select="utils:decryptApplicantReference(borrower_reference)"/></xsl:with-param>
	    		</xsl:call-template>
    		</div>
    		<xsl:call-template name="hidden-field">
    			<xsl:with-param name="name">issuing_bank_abbv_name</xsl:with-param>
    			<xsl:with-param name="value"><xsl:value-of select="issuing_bank/abbv_name"/></xsl:with-param>
    		</xsl:call-template>
    		<xsl:call-template name="hidden-field">
    			<xsl:with-param name="name">issuing_bank_name</xsl:with-param>
    			<xsl:with-param name="value"><xsl:value-of select="issuing_bank/name"/></xsl:with-param>
    		</xsl:call-template>
    		<xsl:call-template name="hidden-field">
    			<xsl:with-param name="name">borrower_reference</xsl:with-param>
    		</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template> 

<!-- loan details -->
<xsl:template name="loan-details">
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_LOAN_DETAILS</xsl:with-param>
		<xsl:with-param name="legend-type">indented-header</xsl:with-param>
		<xsl:with-param name="content">
			
			<!-- issue (effective) date -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_LOAN_EFFECTIVE_DATE</xsl:with-param>
				<xsl:with-param name="name">effective_date</xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>

			<!-- maturity_date -->
			<xsl:call-template name="input-field">
				<xsl:with-param name="label">XSL_GENERALDETAILS_MATURITY_DATE</xsl:with-param>
				<xsl:with-param name="name">ln_maturity_date</xsl:with-param>
				<xsl:with-param name="override-displaymode">view</xsl:with-param>
			</xsl:call-template>
			
			<!-- original loan liability amount -->
			<xsl:call-template name="currency-field">
    			<xsl:with-param name="label">XSL_LOAN_AMOUNT</xsl:with-param>
    			<xsl:with-param name="product-code">ln</xsl:with-param>
    			<xsl:with-param name="override-currency-displaymode">view</xsl:with-param>
    			<xsl:with-param name="disabled">Y</xsl:with-param>
				<xsl:with-param name="override-amt-name">org_ln_liab_amt</xsl:with-param>
				<xsl:with-param name="override-amt-value">
					<xsl:value-of select="org_previous_file/ln_tnx_record/ln_liab_amt" />
				</xsl:with-param>
				<xsl:with-param name="amt-readonly">Y</xsl:with-param>
    		</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>

<!-- saved remittance details -->
<xsl:template name="saved-remittance-details">
<xsl:call-template name="fieldset-wrapper">
	<xsl:with-param name="content">
	<h2><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_REMITTANCE_INSTRUCTION_DETAILS')"/></h2>
	<div>
	<script type="text/javascript">
						var gridLayoutSavedRemittanceLoanTransactions;
						dojo.ready(function(){
					    	gridLayoutSavedRemittanceLoanTransactions = {"cells" : [ 
					                  [
					                  { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'REMITTANCE_INSTRUCTION_CURRENCY')"/>", "field": "currency", "width": "15%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'REMITTANCE_INSTRUCTION_ACCOUNT_NO')"/>", "field": "accountNo", "width": "15%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},					                
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'REMITTANCE_INSTRUCTION_DESCRIPTION')"/>", "field": "description", "width": "20%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"}
					                    ]
					              ]};
					              
					              
													
						});
	</script>
	<script>
						var gridremittanceDetailsData = [];
						dojo.ready(function(){
							gridremittanceDetailsData = [
									
										{"currency" :  "<xsl:value-of select="ln_cur_code"/>",  
										"accountNo" :  "<xsl:value-of select="rem_inst_account_no"/>", 
										"description" :  "<xsl:value-of select="rem_inst_description"/>"
										}
										
										];
										
										console.log('Store created' + "<xsl:value-of select="ln_cur_code"/>");
							
						});
	</script>
	<div style="width:100%;height:100%" class="widgetContainer clear" id="loanRemittanceGrid">
						<div dojoType="dojo.data.ItemFileWriteStore" jsId="storeSavedRemittanceTransaction" >
							<xsl:attribute name="data">
								{"items" : gridremittanceDetailsData}
							</xsl:attribute>
						</div>
						<table 
							store="storeSavedRemittanceTransaction" structure="gridLayoutSavedRemittanceLoanTransactions" class="grid" 
							autoHeight="true" id="gridSavedRemittanceDetailsLoanTransactions" dojoType="dojox.grid.EnhancedGrid" 
							noDataMessage="{localization:getGTPString($language, 'NO_REMITTANCE_INSTRUCTION')}" selectionMode="none" 
							escapeHTMLInData="true" loadingMessage="{localization:getGTPString($language, 'TABLE_LOADING_RECORDS_LIST')}" >
							<thead>
								<tr></tr>
							</thead>
							<tfoot>
								<tr><td></td></tr>
							</tfoot>
							<tbody>
								<tr><td></td></tr>
							</tbody>
						</table>
						<div class="clear" style="height:1px">&nbsp;</div>
						
					</div>
	
	
	
	</div>
	
	
	</xsl:with-param>
	</xsl:call-template>

</xsl:template> 

<xsl:template name="saved-repricing-remittance-details">
<xsl:call-template name="fieldset-wrapper">
	<xsl:with-param name="content">
	<h2><xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_REMITTANCE_INSTRUCTION_DETAILS')"/></h2>
	<div>
	<script type="text/javascript">
						var gridLayoutSavedRemittanceLoanTransactions;
						dojo.ready(function(){
					    	gridLayoutSavedRemittanceLoanTransactions = {"cells" : [ 
					                  [
					                  { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'REMITTANCE_INSTRUCTION_CURRENCY')"/>", "field": "currency", "width": "15%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'REMITTANCE_INSTRUCTION_ACCOUNT_NO')"/>", "field": "accountNo", "width": "15%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"},					                
					                   { "noresize":"true", "name": "<xsl:value-of select="localization:getGTPString($language, 'REMITTANCE_INSTRUCTION_DESCRIPTION')"/>", "field": "description", "width": "20%", "styles":"white-space:nowrap;text-align: center;", "headerStyles":"white-space:nowrap;"}
					                    ]
					              ]};
					              
					              
													
						});
	</script>
	<script>
						var gridremittanceDetailsData = [];
						dojo.ready(function(){
							gridremittanceDetailsData = [
									
										{"currency" :  "<xsl:value-of select="product_file_set/ln_tnx_record/ln_cur_code"/>",  
										"accountNo" :  "<xsl:value-of select="product_file_set/ln_tnx_record/rem_inst_account_no"/>", 
										"description" :  "<xsl:value-of select="product_file_set/ln_tnx_record/rem_inst_description"/>"
										}
										
										];
										
										console.log('Store created' + "<xsl:value-of select="ln_cur_code"/>");
							
						});
	</script>
	<div style="width:100%;height:100%" class="widgetContainer clear" id="loanRemittanceGrid">
						<div dojoType="dojo.data.ItemFileWriteStore" jsId="storeSavedRemittanceTransaction" >
							<xsl:attribute name="data">
								{"items" : gridremittanceDetailsData}
							</xsl:attribute>
						</div>
						<table 
							store="storeSavedRemittanceTransaction" structure="gridLayoutSavedRemittanceLoanTransactions" class="grid" 
							autoHeight="true" id="gridSavedRemittanceDetailsLoanTransactions" dojoType="dojox.grid.EnhancedGrid" 
							noDataMessage="{localization:getGTPString($language, 'NO_REMITTANCE_INSTRUCTION')}" selectionMode="none" 
							escapeHTMLInData="true" loadingMessage="{localization:getGTPString($language, 'TABLE_LOADING_RECORDS_LIST')}" >
							<thead>
								<tr></tr>
							</thead>
							<tfoot>
								<tr><td></td></tr>
							</tfoot>
							<tbody>
								<tr><td></td></tr>
							</tbody>
						</table>
						<div class="clear" style="height:1px">&nbsp;</div>
						
					</div>
	
	
	
	</div>
	
	
	</xsl:with-param>
	</xsl:call-template>

</xsl:template>
<xsl:template name="bank_legal_text_template">
<xsl:param name="legal"/>
<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_LEGAL_SECTION</xsl:with-param>
		<xsl:with-param name="content">		  
			  <div id="LegalTextContainer" >
				  <div id="LegalTextDetailsGrid">
				 		 <xsl:call-template name="replace-eof-with-br-tag">
				 		 	<xsl:with-param name="text" select="$legal"/>
				 		 </xsl:call-template>
				  </div>
				  </div>
	<div class="loan-repricing-interest-details">
						 <xsl:call-template name="checkbox-field">
							 <xsl:with-param name="label">XSL_HEADER_LEGAL_CHECK_BOX_LABEL</xsl:with-param>
							<xsl:with-param name="name">accept_legal_text</xsl:with-param>
							<xsl:with-param name="id">accept_legal_text</xsl:with-param>
							<xsl:with-param name="checked">
								<xsl:choose>
								        <xsl:when test="$displaymode ='view' or $displaymode ='edit'"><xsl:value-of select="isLegalTextAccepted"/></xsl:when>
								        <xsl:otherwise>N</xsl:otherwise>
			       				</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="disabled">
								<xsl:choose>
						        		<xsl:when test="$displaymode ='view' or $displaymode ='edit'">Y</xsl:when>
						        		<xsl:otherwise>N</xsl:otherwise>
		     				 	</xsl:choose>
							 </xsl:with-param>
							 <xsl:with-param name="override-displaymode">edit</xsl:with-param>


						 </xsl:call-template>
					</div>
					</xsl:with-param>
					</xsl:call-template>
						

</xsl:template>
<xsl:template name="legal_text_template">
	<xsl:param name="legal"/>
  	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">XSL_HEADER_LEGAL_SECTION</xsl:with-param>
		
		<xsl:with-param name="content">
			
	   		
		  
		  <div id="legalTextSection">
			  			<div class="wipeInOutTabHeaderAsPerWindowSize">
							<div id="actionDown" onclick="misys.toggleLegalTextDetails()" style="cursor: pointer; display: block;">
<!-- 							    <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LEGAL_SECTION')"/> -->
							    <span class="collapsingImgSpanLeftSide">
							        <img>
							        	<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($actionDownImage)"/></xsl:attribute>
							        </img>
							    </span>
							</div>
							<div id="actionUp" onclick="misys.toggleLegalTextDetails()" style="display: none; cursor: pointer;">
<!-- 							    <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LEGAL_SECTION')"/> -->
							    <span class="collapsingImgSpanLeftSide">
							        <img>
							        	<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($actionUpImage)"/></xsl:attribute>
							        </img>
							    </span>
							</div>
						</div>
			  
			  <div id="LegalTextContainer" >
				  <div id="LegalTextDetailsGrid">
				 		 <xsl:call-template name="replace-eof-with-br-tag">
				 		 	<xsl:with-param name="text" select="$legal"/>
				 		 </xsl:call-template>
				  </div>
			   </div>			   
			   		 <div class="loan-repricing-interest-details">
<!-- 			   		 <xsl:if test="$displaymode='edit'"> -->
						 <xsl:call-template name="checkbox-field">
							 <xsl:with-param name="label">XSL_HEADER_LEGAL_CHECK_BOX_LABEL</xsl:with-param>
							<xsl:with-param name="name">accept_legal_text</xsl:with-param>
							<xsl:with-param name="id">accept_legal_text</xsl:with-param>
							<xsl:with-param name="checked">Y</xsl:with-param>
							 <xsl:with-param name="override-displaymode">edit</xsl:with-param>
						 </xsl:call-template>
					</div>	
					
		   </div>
		  
		 </xsl:with-param>
	</xsl:call-template>
  </xsl:template>
 
 <!-- The below template will replace \n with <br/> tags.
 Something like 'Loan \n Increase' will be replaced by 'Loan <br/> Increase' --> 
  <xsl:template name="replace-eof-with-br-tag">
	  <xsl:param name="text"/>
	  <xsl:choose>
	    <xsl:when test="contains($text, '&#xa;')">
	      <xsl:value-of select="substring-before($text, '&#xa;')"/>
	      <br/>
	      <xsl:call-template name="replace-eof-with-br-tag">
	        <xsl:with-param 
	          name="text" 
	          select="substring-after($text, '&#xa;')"
	        />
	      </xsl:call-template>
	    </xsl:when>
	    <xsl:otherwise>
	      <xsl:value-of select="$text"/>
	    </xsl:otherwise>
	  </xsl:choose>
</xsl:template>


  <xsl:template name="legal_text_popup_template">
  <xsl:param name="legal"/>
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="content">

		 	  <div id="legalTextSection">
			  <div id="LegalTextContainer" class ="hide"  >
			  		<div id="legalDialog" dojoType="misys.widget.Dialog" class ="dialog" title = "Legal Consent" style="width: 720px; height:auto; overflow:auto;">
				  <div id="legalDialogContent"  >
				 		 <xsl:call-template name="replace-eof-with-br-tag">
				 		 	<xsl:with-param name="text" select="$legal"/>
				 		 </xsl:call-template>
				  </div>
				  <br></br>
 					<div class="field" id = "legaltextcheckbox" align="left" style="font-weight: bold;">
						<input type="checkbox" dojoType="dijit.form.CheckBox" name="accept_legal_text" id="accept_legal_text" >
							<xsl:attribute name="onChange">if(this.checked){dijit.byId('submitlegal').set('disabled',false);}else{dijit.byId('submitlegal').set('disabled',true);}
							</xsl:attribute>
						</input>
						&nbsp;<xsl:value-of select="localization:getGTPString($language, 'XSL_ACCEPT_TERMS')"/>
					
					</div>		
					<div class="dijitDialogPaneActionBar">
						<button dojoType="dijit.form.Button" name="submitlegal" id="submitlegal" type="submit" disabled="true">	
							<xsl:value-of select="localization:getGTPString($language, 'OK')"/>
						</button>
						<button dojoType="dijit.form.Button" type="button" name="cancel" id="cancel" onmouseup="dijit.byId('legalDialog').hide();" >
							<xsl:value-of select="localization:getGTPString($language, 'CANCEL')"/>
						</button>
					</div>	   
				</div>
		    </div>
		  </div> 
		
		   </xsl:with-param>
	   	</xsl:call-template>
  </xsl:template>

<!-- Display Authoriser name displays the name of the authoriser -->
<xsl:template name="display-authorizer-name">
	   <xsl:param name="list"/>
		<xsl:variable name="userNames" select="utils:extractUserName($list)"/>
			<xsl:if test ="$userNames != '' and defaultresource:getResource('DISPLAY_AUTHORIZER_NAME') = 'true'">
				<xsl:call-template name="fieldset-wrapper">
					<xsl:with-param name="content">
						<b><xsl:value-of select="localization:getGTPString($language, 'XSL_AUTHORIZED_USER_NAME')"/></b>
					 		<xsl:call-template name="replace-eof-with-br-tag">
				 		 		<xsl:with-param name="text" select="$userNames"/>
				 		 	</xsl:call-template>
		  		 	</xsl:with-param>
	  	 		</xsl:call-template>	
			</xsl:if>
 </xsl:template>
</xsl:stylesheet>