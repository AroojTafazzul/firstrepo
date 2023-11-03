<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:xd="http://www.pnp-software.com/XSLTdoc"
		exclude-result-prefixes="localization">

  <xd:doc>
		<xd:short>Main form</xd:short>
		<xd:detail>
			This XSL is for displaying all the details of FSCM program.
 		</xd:detail>
 </xd:doc>
  <xsl:param name="language">en</xsl:param>
  <xsl:param name="languages"/>
  <xsl:param name="nextscreen"/>
  <xsl:param name="option"/>
  <xsl:param name="action"/>
  <xsl:param name="token"/>
  <xsl:param name="displaymode">edit</xsl:param>
  <xsl:param name="collaborationmode">none</xsl:param> <!-- set to none, counterparty or bank, depending on whether we are in a collab summary screen  -->
  <xsl:param name="main-form-name">fakeform1</xsl:param>
  <xsl:param name="operation"/>
  <xsl:param name="processdttm"/>
  <xsl:param name="allowReturnAction">false</xsl:param>
  <xsl:param name="registrations_made">Y</xsl:param>
   <xsl:param name="currentmode"/>
  <!-- Global Imports. -->
  <xsl:include href="../common/system_common.xsl" />
  <xsl:include href="../common/maker_checker_common.xsl" />
    
  <xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />
  <xsl:template match="/">
   <!-- Loading message  -->
   <xsl:call-template name="loading-message"/>
   <div>
 
    <!-- Form #0 : Main Form -->
    <xsl:call-template name="form-wrapper">
   	 	<xsl:with-param name="name" select="$main-form-name"/>
   	 	<xsl:with-param name="validating">Y</xsl:with-param>
   	 	<xsl:with-param name="content">
      			<xsl:apply-templates select="fscm_program"/>
      
     	</xsl:with-param>
    </xsl:call-template>
    	<xsl:call-template name="realform"/>
   </div>
    
   	<!-- Javascript imports  -->
  <xsl:call-template name="js-imports"/>
  </xsl:template>
 <!-- Additional JS imports for this form are -->
 <!-- added here. -->
 
   <xd:doc>
		<xd:short>Additional JS Imports</xd:short>
		<xd:detail>
			Additional JS is binded
 		</xd:detail>
 </xd:doc>
 <xsl:template name="js-imports">
 	 <xsl:call-template name="system-common-js-imports">
 	  	<xsl:with-param name="xml-tag-name">fscm_program</xsl:with-param>
  	 	<xsl:with-param name="override-home-url">'/screen/<xsl:value-of select="$nextscreen"/>?option=<xsl:value-of select="$option"/>'</xsl:with-param>
  	</xsl:call-template>
 </xsl:template>
 
 <xd:doc>
		<xd:short>Template for Building main form</xd:short>
		<xd:detail>
			This template builds main form and all the view details of the form
 		</xd:detail>
 </xd:doc>
 <xsl:template match="fscm_program">
  	<xsl:call-template name="fieldset-wrapper">
  		<xsl:with-param name="legend">XSL_HEADER_PROGRAM_DETAILS</xsl:with-param>
	 	<xsl:with-param name="content">
	 	<xsl:call-template name="column-wrapper">
		   <xsl:with-param name="content">
		   <div id="display_row1" class="field">
					<span class="label"><xsl:value-of select="localization:getGTPString($language, 'FSCM_PROGRAM_ID_LABEL')"/></span>
					<div class="content"><xsl:value-of select="program_id"/></div> 
			</div>
			<div id="display_row3" class="field">
					<span class="label"><xsl:value-of select="localization:getGTPString($language, 'FSCM_PROGRAM_NAME_LABEL')"/></span>
					<div class="content"><xsl:value-of select="program_name"/></div> 
			</div>
			<div id="display_row4" class="field">
					<span class="label"><xsl:value-of select="localization:getGTPString($language, 'FSCM_START_DATE_LABEL')"/></span>
					<div class="content"><xsl:value-of select="start_date"/></div> 
			</div>
			<div id="display_row5" class="field">
					<span class="label"><xsl:value-of select="localization:getGTPString($language, 'FSCM_EXPIRY_DATE_LABEL')"/></span>
					<div class="content"><xsl:value-of select="expiry_date"/></div> 
			</div>
			</xsl:with-param>
		</xsl:call-template>
			
			
			
			<xsl:call-template name="column-wrapper">
		  		 <xsl:with-param name="content">
		  		 <div id="display_row11" class="field">
						<span class="label"><xsl:value-of select="localization:getGTPString($language, 'FSCM_STATUS_LABEL')"/></span>
						<div class="content"><xsl:value-of select="localization:getDecode($language, 'N223', status)" /></div> 
			</div>
				<div id="display_row27" class="field">
						<span class="label"><xsl:value-of select="localization:getGTPString($language, 'FSCM_CREDIT_LIMIT_LABEL')"/></span>
						<div class="content"><xsl:value-of select="fscm_counterparty_list/fscm_counterparty_record/limit_cur_code"/>&nbsp;<xsl:value-of select="fscm_counterparty_list/fscm_counterparty_record/limit_amt"/></div> 
			</div>
				 <div id="display_row7" class="field">
						<span class="label"><xsl:value-of select="localization:getGTPString($language, 'FSCM_CUSTOMER_REFERENCE_LABEL')"/></span>
						<div class="content"><xsl:value-of select="customer_reference"/></div> 
				</div>
			<div id="display_row8" class="field">
						<span class="label"><xsl:value-of select="localization:getGTPString($language, 'FSCM_CUSTOMER_ABBV_NAME_LABEL')"/></span>
						<div class="content"><xsl:value-of select="customer_abbv_name"/></div> 
			</div>
			<div id="display_row9" class="field">
						<span class="label"><xsl:value-of select="localization:getGTPString($language, 'FSCM_BANK_ABBV_NAME_LABEL')"/></span>
						<div class="content"><xsl:value-of select="bank_abbv_name"/></div> 
			</div>
			<xsl:if test="modified_dttm[.!='']"> 
			<div id="display_row5" class="field">
						<span class="label"><xsl:value-of select="localization:getGTPString($language, 'FSCM_MODIFIED_DATE_LABEL')"/></span>
						<div class="content"><xsl:value-of select="modified_dttm"/></div> 
			</div>
			</xsl:if>
			<xsl:if test="created_dttm[.!='']"> 
			<div id="display_row5" class="field">
						<span class="label"><xsl:value-of select="localization:getGTPString($language, 'FSCM_CREATED_DATE_LABEL')"/></span>
						<div class="content"><xsl:value-of select="created_dttm"/></div> 
			</div>
			</xsl:if>
			<div id="display_row12" class="field">
						<span class="label"><xsl:value-of select="localization:getGTPString($language, 'FSCM_NARRATIVE_LABEL')"/></span>
						<div class="content"><xsl:value-of select="narrative"/></div> 
			</div>
			</xsl:with-param>
			</xsl:call-template>
			</xsl:with-param>
			</xsl:call-template>
		
			<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_PROGRAM_TYPE_DETAILS</xsl:with-param>
			<xsl:with-param name="button-type">
			</xsl:with-param>
			<xsl:with-param name="content">
				<xsl:call-template name="column-wrapper">
					<xsl:with-param name="content">
						<div id="display_row13" class="field">
							<span class="label">
								<xsl:value-of
									select="localization:getGTPString($language, 'FSCM_PROGRAM_TYPE_LABEL')" />
							</span>
							<div class="content">
								<xsl:choose>
									<xsl:when test="program_type[.='01']">
										Buyer Centric
									</xsl:when>
									<xsl:otherwise>
										Seller Centric
									</xsl:otherwise>
								</xsl:choose>
							</div>
						</div>
						<div id="display_row10" class="field">
							<span class="label">
								<xsl:value-of
									select="localization:getGTPString($language, 'FSCM_MULTIPLE_FINANCE_ALLOWED_LABEL')" />
							</span>
							<div class="content">
								<xsl:value-of select="multiple_finance_allowed" />
							</div>
						</div>
					</xsl:with-param>
				</xsl:call-template>
				<xsl:call-template name="column-wrapper">
					<xsl:with-param name="content">
						<div id="display_row2" class="field">
							<span class="label">
								<xsl:value-of
									select="localization:getGTPString($language, 'FSCM_PROGRAM_CODE_LABEL')" />
							</span>
							<div class="content">
								<xsl:value-of select="program_code" />
							</div>
						</div>
						<div id="display_row14" class="field">
							<span class="label">
								<xsl:value-of
									select="localization:getGTPString($language, 'FSCM_PROGRAM_SUB_TYPE_LABEL')" />
							</span>
							<div class="content">
								<xsl:value-of select="program_sub_type" />
							</div>
						</div>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
					
	
	
		<div style="height:3px">&nbsp;</div>
	<xsl:call-template name="fieldset-wrapper">
		<xsl:with-param name="legend">FSCM_PROGRAM_ROLES</xsl:with-param>
		<xsl:with-param name="button-type">
		</xsl:with-param>
		<xsl:with-param name="content">
			<xsl:call-template name="column-wrapper">
				<xsl:with-param name="content">
					<div id="display_row15" class="field">
						<span class="label">
							<xsl:value-of
								select="localization:getGTPString($language, 'FSCM_CUSTOMER_ROLE_LABEL')" />
						</span>
						<div class="content">
							<xsl:value-of
								select="localization:getDecode($language, 'N224', customer_role)" />
						</div>
					</div>
					<div id="display_row15" class="field">
						<span class="label">
							<xsl:value-of
								select="localization:getGTPString($language, 'FSCM_ANCHORPARTY_ROLE_LABEL')" />
						</span>
						<div class="content">
							<xsl:value-of
								select="localization:getDecode($language, 'N224', anchorparty_role)" />
						</div>
					</div>
					<div id="display_row16" class="field">
						<span class="label">
							<xsl:value-of
								select="localization:getGTPString($language, 'FSCM_COUNTERPARTY_ROLE_LABEL')" />
						</span>
						<div class="content">
							<xsl:value-of
								select="localization:getDecode($language, 'N224', counterparty_role)" />
						</div>
					</div>
					<div id="display_row17" class="field">
						<span class="label">
							<xsl:value-of
								select="localization:getGTPString($language, 'FSCM_INVOICE_SETTLED_BY_LABEL')" />
						</span>
						<div class="content">
							<xsl:value-of
								select="localization:getDecode($language, 'N224', invoice_settled_by)" />
						</div>
					</div>
					<div id="display_row18" class="field">
						<span class="label">
							<xsl:value-of
								select="localization:getGTPString($language, 'FSCM_RESIDUAL_PAYMENT_BY_LABEL')" />
						</span>
						<div class="content">
							<xsl:value-of
								select="localization:getDecode($language, 'N224', residual_payment_by)" />
						</div>
					</div>
					<div id="display_row19" class="field">
						<span class="label">
							<xsl:value-of
								select="localization:getGTPString($language, 'FSCM_PRINCIPAL_RISK_PARTY_LABEL')" />
						</span>
						<div class="content">
							<xsl:value-of
								select="localization:getDecode($language, 'N224', principal_risk_party)" />
						</div>
					</div>
				</xsl:with-param>
			</xsl:call-template>


			<xsl:call-template name="column-wrapper">
				<xsl:with-param name="content">
					<div id="display_row20" class="field">
						<span class="label">
							<xsl:value-of
								select="localization:getGTPString($language, 'FSCM_BUYER_ACCEPTANCE_REQUIRED_LABEL')" />
						</span>
						<div class="content">
							<xsl:value-of
								select="localization:getDecode($language, 'N034', buyer_acceptance_required)" />
						</div>
					</div>
					<div id="display_row21" class="field">
						<span class="label">
							<xsl:value-of
								select="localization:getGTPString($language, 'FSCM_INVOICE_SUBMITTED_BY_LABEL')" />
						</span>
						<div class="content">
							<xsl:value-of
								select="localization:getDecode($language, 'N224', invoice_submitted_by)" />
						</div>
					</div>
					<div id="display_row22" class="field">
						<span class="label">
							<xsl:value-of
								select="localization:getGTPString($language, 'FSCM_FINANCE_REQUESTED_BY_LABEL')" />
						</span>
						<div class="content">
							<xsl:value-of
								select="localization:getDecode($language, 'N224', finance_requested_by)" />
						</div>
					</div>
					<div id="display_row23" class="field">
						<span class="label">
							<xsl:value-of
								select="localization:getGTPString($language, 'FSCM_FINANCE_DEBIT_PARTY_LABEL')" />
						</span>
						<div class="content">
							<xsl:value-of
								select="localization:getDecode($language, 'N224', finance_debit_party)" />
						</div>
					</div>
					<div id="display_row24" class="field">
						<span class="label">
							<xsl:value-of
								select="localization:getGTPString($language, 'FSCM_FINANCE_CREDIT_PARTY_LABEL')" />
						</span>
						<div class="content">
							<xsl:value-of
								select="localization:getDecode($language, 'N224', finance_credit_party)" />
						</div>
					</div>

					<div id="display_row25" class="field">
						<span class="label">
							<xsl:value-of
								select="localization:getGTPString($language, 'FSCM_CN_SUBMITTED_LABEL')" />
						</span>
						<div class="content">
							<xsl:value-of
								select="localization:getDecode($language, 'N224', credit_note_submitted_by)" />
						</div>
					</div>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
  </xsl:template>

 <!-- ***************************************************************************************** -->
 <!-- ************************************** REALFORM ***************************************** -->
 <!-- ***************************************************************************************** -->
 <xsl:template name="realform">
  <!-- Do not display this section when the counterparty mode is 'counterparty' -->
  <xsl:if test="$collaborationmode != 'counterparty'">
  <xsl:call-template name="form-wrapper">
   <xsl:with-param name="name">realform</xsl:with-param>
   <xsl:with-param name="method">POST</xsl:with-param>
   <xsl:with-param name="action"> <xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/<xsl:value-of select="$nextscreen"/></xsl:with-param>
    <xsl:with-param name="content">
     <div class="widgetContainer">
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">operation</xsl:with-param>
       <xsl:with-param name="id">realform_operation</xsl:with-param>
       <xsl:with-param name="value"><xsl:value-of select="$operation"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       <xsl:with-param name="name">option</xsl:with-param>
        <xsl:with-param name="value"><xsl:value-of select="$option"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="hidden-field">
       	<xsl:with-param name="name">token</xsl:with-param>
       	<xsl:with-param name="value"><xsl:value-of select="$token"/></xsl:with-param>
      </xsl:call-template>
      </div>
    </xsl:with-param>
   </xsl:call-template>
   </xsl:if>
  </xsl:template>
</xsl:stylesheet>