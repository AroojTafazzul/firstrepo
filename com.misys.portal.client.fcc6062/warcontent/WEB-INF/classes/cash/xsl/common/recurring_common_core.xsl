<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [
  <!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:securitycheck="xalan://com.misys.portal.common.security.GTPSecurityCheck"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
		xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
		exclude-result-prefixes="localization securitycheck utils security defaultresource">
	
	
   	<xsl:param name="bothFieldsEnabled"><xsl:value-of select="defaultresource:getResource('RECURRING_PAYMENT_ALLOW_BOTH_FIELDS')"/></xsl:param>
	<xsl:param name="rundata"/>
	
	<xsl:variable name="isBothFieldsEnabled">
		<xsl:choose>
			<xsl:when test="$bothFieldsEnabled='true'">Y</xsl:when>
			<xsl:otherwise>N</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	
	<!--
  	 Recurring Details Fieldset. 
   	-->
   	<xsl:template name="recurring-details">
   		<xsl:param name="isBankReporting"/>
   		<xsl:param name="isMultiBank"/>
   		<xsl:param name="endDate"><xsl:value-of select="defaultresource:getResource('RECURRING_PAYMENT_BY_END_DATE')"/></xsl:param>
  		<xsl:param name="override-displaymode"/>
  		<xsl:variable name="display">
			<xsl:choose>
				<xsl:when test="$isBankReporting='Y'">Y</xsl:when>
				<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="isEndDate">
			<xsl:choose>
				<xsl:when test="$endDate='true'">Y</xsl:when>
				<xsl:otherwise>N</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<script>
			dojo.ready(function(){			
         	  	misys._config = misys._config || {};			
				misys._config.bothFieldsEnabled = '<xsl:value-of select="$bothFieldsEnabled"/>';
			});
	  	</script>
   		<xsl:call-template name="fieldset-wrapper">
	     	<xsl:with-param name="legend">XSL_RECURRING_PAYMENT_DETAILS</xsl:with-param>
	     	<xsl:with-param name="content">
	     	<xsl:call-template name="column-container">
				<xsl:with-param name="content">			 
					<xsl:call-template name="column-wrapper">
						<xsl:with-param name="content">	     		
							<xsl:call-template name="business-date-field">
								<xsl:with-param name="label">XSL_SO_START_DATE</xsl:with-param>
								<xsl:with-param name="name">recurring_start_date</xsl:with-param>
								<xsl:with-param name="size">10</xsl:with-param>
								<xsl:with-param name="maxsize">10</xsl:with-param>
								<xsl:with-param name="required">N</xsl:with-param>
								<xsl:with-param name="fieldsize">small</xsl:with-param>
								<xsl:with-param name="override-displaymode">
								    <xsl:choose>
								    	<xsl:when test="bulk_ref_id[.='']">
									    	<xsl:choose>
										    	<xsl:when test="$override-displaymode != '' "><xsl:value-of select="$override-displaymode"/></xsl:when>
										    	<xsl:when test="$displaymode = 'edit'">edit</xsl:when>
										    	<xsl:otherwise>view</xsl:otherwise>
									    	</xsl:choose>
								    	</xsl:when>
								    	<xsl:otherwise>view</xsl:otherwise>
								    </xsl:choose>
						    	</xsl:with-param>
							</xsl:call-template>
							<div style="display:none;">
								<xsl:call-template name="input-field">
						  			<xsl:with-param name="id">todays_date</xsl:with-param>
						  			<xsl:with-param name="value"><xsl:value-of select="todays_date"/></xsl:with-param>
						  			<xsl:with-param name="type">date</xsl:with-param>
						  			 <xsl:with-param name="swift-validate">N</xsl:with-param>
						  		</xsl:call-template>
					  		</div>
							<xsl:call-template name="select-field">
								<xsl:with-param name="label">XSL_FREQUENCY_MODE</xsl:with-param>
								<xsl:with-param name="name">recurring_frequency</xsl:with-param>
								<xsl:with-param name="required">N</xsl:with-param>
								<xsl:with-param name="fieldsize">small</xsl:with-param>
								<xsl:with-param name="override-displaymode">
								    <xsl:choose>
								    	<xsl:when test="bulk_ref_id[.='']">
									    	<xsl:choose>
									    		<xsl:when test="$override-displaymode != '' "><xsl:value-of select="$override-displaymode"/></xsl:when>
										    	<xsl:when test="$displaymode = 'edit'">edit</xsl:when>
										    	<xsl:otherwise>view</xsl:otherwise>
									    	</xsl:choose>
								    	</xsl:when>
								    	<xsl:otherwise>view</xsl:otherwise>
								    </xsl:choose>
						    	</xsl:with-param>
								<xsl:with-param name="options">
								<xsl:if test="$isMultiBank !='Y'">
									<xsl:call-template name="frequency_mode">
											<xsl:with-param name="override-displaymode">
												<xsl:choose>
													<xsl:when test="bulk_ref_id[.='']">
														<xsl:choose>
															<xsl:when test="$override-displaymode != '' ">
																<xsl:value-of select="$override-displaymode" />
															</xsl:when>
															<xsl:when test="$displaymode = 'edit'">
																edit
															</xsl:when>
															<xsl:otherwise>
																view
															</xsl:otherwise>
														</xsl:choose>
													</xsl:when>
													<xsl:otherwise>
														view
													</xsl:otherwise>
												</xsl:choose>
											</xsl:with-param>									
									</xsl:call-template>
								</xsl:if>
								</xsl:with-param>
							</xsl:call-template>
							<div id="recurring_on_div">
								<xsl:choose>
		      		   			<xsl:when test="$displaymode='edit'">	
		      		   			  <xsl:choose>
		      		   			  	<xsl:when test="security:isCustomer($rundata)">					
										<xsl:call-template name="multioption-inline-wrapper">								
											<xsl:with-param name="group-id">recurring_group_wrapper</xsl:with-param>
											<xsl:with-param name="show-required-prefix">Y</xsl:with-param>
											<xsl:with-param name="group-label">XSL_RECUR_ON</xsl:with-param>
											<xsl:with-param name="content">				      
											<xsl:call-template name="multichoice-field">
												<xsl:with-param name="group-label" select="XSL_RECUR_ON"/>			  
												<xsl:with-param name="label">XSL_RECUR_ON_EXACT_DAY</xsl:with-param>
												<xsl:with-param name="name">recurring_on</xsl:with-param>
												<xsl:with-param name="id">exact_day</xsl:with-param>
												<xsl:with-param name="value">01</xsl:with-param>		
												<xsl:with-param name="checked"><xsl:if test="recurring_on[. = '01']">Y</xsl:if></xsl:with-param>	
												<xsl:with-param name="disabled"><xsl:value-of select="$display"/></xsl:with-param>    
												<xsl:with-param name="type">radiobutton</xsl:with-param>
												<xsl:with-param name="inline">Y</xsl:with-param>
											</xsl:call-template>						    
											<xsl:call-template name="multichoice-field">			  
												<xsl:with-param name="label">XSL_RECUR_ON_LAST_DAY</xsl:with-param>
												<xsl:with-param name="name">recurring_on</xsl:with-param>
												<xsl:with-param name="id">last_day</xsl:with-param>
												<xsl:with-param name="value">02</xsl:with-param>
												<xsl:with-param name="checked"><xsl:if test="recurring_on[. = '02']">Y</xsl:if></xsl:with-param>	
												<xsl:with-param name="disabled"><xsl:value-of select="$display"/></xsl:with-param>  		  
												<xsl:with-param name="type">radiobutton</xsl:with-param>
												<xsl:with-param name="inline">Y</xsl:with-param>
											</xsl:call-template>				         
											</xsl:with-param>								
										</xsl:call-template>
								    </xsl:when>
								    <xsl:otherwise>
								    	<xsl:if test="recurring_frequency[.='MONTHLY'] or recurring_frequency[.='QUARTERLY']">
									    	<xsl:call-template name="multioption-inline-wrapper">								
												<xsl:with-param name="group-id">recurring_group_wrapper</xsl:with-param>
												<xsl:with-param name="show-required-prefix">Y</xsl:with-param>
												<xsl:with-param name="group-label">XSL_RECUR_ON</xsl:with-param>
												<xsl:with-param name="content">				      
												<xsl:call-template name="multichoice-field">
													<xsl:with-param name="group-label" select="XSL_RECUR_ON"/>			  
													<xsl:with-param name="label">XSL_RECUR_ON_EXACT_DAY</xsl:with-param>
													<xsl:with-param name="name">recurring_on</xsl:with-param>
													<xsl:with-param name="id">exact_day</xsl:with-param>
													<xsl:with-param name="value">01</xsl:with-param>		
													<xsl:with-param name="checked"><xsl:if test="recurring_on[. = '01']">Y</xsl:if></xsl:with-param>	
													<xsl:with-param name="disabled">Y</xsl:with-param>    
													<xsl:with-param name="type">radiobutton</xsl:with-param>
													<xsl:with-param name="inline">Y</xsl:with-param>
												</xsl:call-template>						    
												<xsl:call-template name="multichoice-field">			  
													<xsl:with-param name="label">XSL_RECUR_ON_LAST_DAY</xsl:with-param>
													<xsl:with-param name="name">recurring_on</xsl:with-param>
													<xsl:with-param name="id">last_day</xsl:with-param>
													<xsl:with-param name="value">02</xsl:with-param>
													<xsl:with-param name="checked"><xsl:if test="recurring_on[. = '02']">Y</xsl:if></xsl:with-param>	
													<xsl:with-param name="disabled">Y</xsl:with-param>  		  
													<xsl:with-param name="type">radiobutton</xsl:with-param>
													<xsl:with-param name="inline">Y</xsl:with-param>
												</xsl:call-template>				         
												</xsl:with-param>								
											</xsl:call-template>
										</xsl:if>
								    </xsl:otherwise>
		      		   			  </xsl:choose>
								</xsl:when>
								<xsl:when test="$displaymode='view'">
									<xsl:if test="recurring_frequency[.='MONTHLY'] or recurring_frequency[.='QUARTERLY']">									
										<xsl:call-template name="multioption-inline-wrapper">								
										<xsl:with-param name="group-label">XSL_RECUR_ON</xsl:with-param>
										<xsl:with-param name="content">
											<xsl:choose>
							      				<xsl:when test="recurring_on[. = '01']"><span class = "content"><xsl:value-of select="localization:getGTPString($language, 'XSL_RECUR_ON_EXACT_DAY')"/></span></xsl:when>
							      				<xsl:when test="recurring_on[. = '02']"><span class = "content"><xsl:value-of select="localization:getGTPString($language, 'XSL_RECUR_ON_LAST_DAY')"/></span></xsl:when>
						    	 			</xsl:choose>			      
										<!-- <xsl:call-template name="multichoice-field">
											<xsl:with-param name="group-label" select="XSL_RECUR_ON"/>			  
											<xsl:with-param name="label">XSL_RECUR_ON_EXACT_DAY</xsl:with-param>
											<xsl:with-param name="name">recurring_on</xsl:with-param>
											<xsl:with-param name="id">exact_day</xsl:with-param>
											<xsl:with-param name="value">01</xsl:with-param>		
											<xsl:with-param name="checked"><xsl:if test="recurring_on[. = '01']">Y</xsl:if></xsl:with-param>	  
											<xsl:with-param name="type">radiobutton</xsl:with-param>
											<xsl:with-param name="inline">Y</xsl:with-param>
										</xsl:call-template>						    
										<xsl:call-template name="multichoice-field">			  
											<xsl:with-param name="label">XSL_RECUR_ON_LAST_DAY</xsl:with-param>
											<xsl:with-param name="name">recurring_on</xsl:with-param>
											<xsl:with-param name="id">last_day</xsl:with-param>
											<xsl:with-param name="value">02</xsl:with-param>
											<xsl:with-param name="checked"><xsl:if test="recurring_on[. = '02']">Y</xsl:if></xsl:with-param>			  
											<xsl:with-param name="type">radiobutton</xsl:with-param>
											<xsl:with-param name="inline">Y</xsl:with-param>
										</xsl:call-template> -->				         
										</xsl:with-param>								
									</xsl:call-template>									
									</xsl:if>								
								</xsl:when>
								</xsl:choose>								
							</div>
							<div id="recurring_instruction_div">
								<xsl:if test="$isBothFieldsEnabled='Y' or $isEndDate='Y'">
									<xsl:call-template name="business-date-field">
										<xsl:with-param name="label">XSL_SO_END_DATE</xsl:with-param>
										<xsl:with-param name="name">recurring_end_date</xsl:with-param>
										<xsl:with-param name="size">10</xsl:with-param>
										<xsl:with-param name="maxsize">10</xsl:with-param>
										<xsl:with-param name="required">Y</xsl:with-param>
										<xsl:with-param name="fieldsize">small</xsl:with-param>
										<xsl:with-param name="override-displaymode">
										    <xsl:choose>
										    	<xsl:when test="bulk_ref_id[.='']">
											    	<xsl:choose>
											    	<xsl:when test="$override-displaymode != '' "><xsl:value-of select="$override-displaymode"/></xsl:when>
											    	<xsl:when test="$displaymode = 'edit'">edit</xsl:when>
											    	<xsl:otherwise>view</xsl:otherwise>
											    	</xsl:choose>
										    	</xsl:when>
										    	<xsl:otherwise>view</xsl:otherwise>
										    </xsl:choose>
									    </xsl:with-param>
									</xsl:call-template>
								</xsl:if>
								<xsl:if test="$isBothFieldsEnabled='Y' or $isEndDate='N'">
									<xsl:call-template name="column-wrapper">
										<xsl:with-param name="content">
											<xsl:call-template name="input-field">
											    <xsl:with-param name="label">XSL_NUMBER_OF_TRANSFERS</xsl:with-param>
											    <xsl:with-param name="name">recurring_number_transfers</xsl:with-param>
											    <xsl:with-param name="type">number</xsl:with-param>
											    <xsl:with-param name="maxsize">3</xsl:with-param>
											    <xsl:with-param name="fieldsize">xx-small</xsl:with-param>
											    <xsl:with-param name="required">Y</xsl:with-param>
											    <xsl:with-param name="override-constraints">{places:'0', min:1, max: 999,pattern: '##'}</xsl:with-param>
											    <xsl:with-param name="override-displaymode">
											    <xsl:choose>
											    	<xsl:when test="bulk_ref_id[.='']">
												    	<xsl:choose>
												    	<xsl:when test="$override-displaymode != '' "><xsl:value-of select="$override-displaymode"/></xsl:when>
												    	<xsl:when test="$displaymode = 'edit'">edit</xsl:when>
												    	<xsl:otherwise>view</xsl:otherwise>
												    	</xsl:choose>
											    	</xsl:when>
											    	<xsl:otherwise>view</xsl:otherwise>
											    </xsl:choose>
										    </xsl:with-param>
						  					</xsl:call-template>
						  				</xsl:with-param>
						  			</xsl:call-template>
					  			</xsl:if>
							</div>
							<div style="display:none;">
					  		<xsl:call-template name="input-field">
					  			<xsl:with-param name="name">appl_date_hidden</xsl:with-param>
					  			<xsl:with-param name="value"><xsl:value-of select="appl_date"/></xsl:with-param>
					  			<xsl:with-param name="type">date</xsl:with-param>
					  			<xsl:with-param name="swift-validate">N</xsl:with-param> 
					  		</xsl:call-template>
					  		<xsl:call-template name="hidden-field">
								<xsl:with-param name="name">allow_both_fields</xsl:with-param>
								<xsl:with-param name="value" select="$isBothFieldsEnabled"/>
					  		</xsl:call-template>
					  		<xsl:choose>
					  			<xsl:when test="$displaymode='edit'">
						  			<xsl:call-template name="multichoice-field">
							  			<xsl:with-param name="name">recurring_payment_enabled</xsl:with-param>
							  			<xsl:with-param name="type">checkbox</xsl:with-param>
						  			</xsl:call-template>
					  			</xsl:when>
					  			<xsl:otherwise>
						  			<xsl:call-template name="hidden-field">
				   						<xsl:with-param name="name">recurring_payment_enabled</xsl:with-param>
									</xsl:call-template>
					  			</xsl:otherwise>
					  		</xsl:choose>
				  			</div>										    
						</xsl:with-param>
				</xsl:call-template>
				</xsl:with-param>
	     	</xsl:call-template>
	     	</xsl:with-param>
		</xsl:call-template>
	</xsl:template>	
	
	<xsl:template name="recurring_content">
  	<xsl:param name="override-displaymode"/>
	<!-- never for bulk -->
	<xsl:param name="isBankReporting"/>
	<xsl:param name="isMultiBank"/>
	<xsl:if test="bulk_ref_id[.='']">	
		<div id="recurring_payment_div">
			<xsl:choose>
				<xsl:when test="$displaymode='edit'">
					<xsl:call-template name="recurring-details">
						<xsl:with-param name="override-displaymode" select="$override-displaymode"/>
						<xsl:with-param name="isBankReporting" select="$isBankReporting"/>
						<xsl:with-param name="isMultiBank" select="$isMultiBank"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:when test="$displaymode='view'">
					<xsl:if test="recurring_payment_enabled[.='Y']">
						<xsl:if test="not(tnx_id) or tnx_type_code[.!='15']">
							<xsl:call-template name="recurring-details">
								<xsl:with-param name="override-displaymode" select="$override-displaymode"/>
							</xsl:call-template>
						</xsl:if>
					</xsl:if>
				</xsl:when>
			</xsl:choose>
			<xsl:if test="$displaymode = 'edit' and $isBothFieldsEnabled='Y'">
				<div id='disclaimer' style="text-align:left;">
					 <xsl:value-of select="localization:getGTPString($language, 'XSL_FT_RECURRING_NOTE_MESSAGE')"/>
				</div>
			</xsl:if>
		</div>
	</xsl:if>
	</xsl:template>
	
	 <xsl:template name="frequency_mode">
	 <xsl:param name="override-displaymode"/>
 	  <xsl:choose>
   		 <xsl:when test="$override-displaymode='edit'">   
    		<xsl:for-each select="frequency/frequency_mode">
	          <xsl:variable name="recurring_frequency_type"><xsl:value-of select="frequency_type"/></xsl:variable>
 	               <option value ="{$recurring_frequency_type}">
	                  <xsl:value-of select="localization:getDecode($language, 'N416', $recurring_frequency_type)"/>
 	               </option>
	         </xsl:for-each>
    	</xsl:when>
   		<xsl:otherwise>
   		   <xsl:value-of select="localization:getDecode($language, 'N416', recurring_frequency)"/>
    	</xsl:otherwise>
  	 </xsl:choose>
  </xsl:template>
  
  <xsl:template name="recurring_payment_details_script">
  			misys._config.offset = misys._config.offset ||
			[ 
			{
			<xsl:for-each select="start_dt_offset/offset">
					'<xsl:value-of select="sub_prod_type_offset" />':[<xsl:value-of select="minimum_offset" />,<xsl:value-of select="maximum_offset" />]
					<xsl:if test="position()!=last()">,</xsl:if>
			</xsl:for-each>	
			}
			];
			misys._config.frequency_mode = misys._config.frequency_mode || 
			[
			{
			<xsl:for-each select="frequency/frequency_mode">
				'<xsl:value-of select="frequency_type"/>':['<xsl:value-of select="exact_flag" />','<xsl:value-of select="last_flag" />','<xsl:value-of select="transfer_limit" />']
            	<xsl:if test="position()!=last()">,</xsl:if>
            </xsl:for-each>
            }
            ];
	</xsl:template>
	<xsl:template name="recurring_checkbox">
  	 	<xsl:param name="recurring-disabled">N</xsl:param> 
	 	<xsl:param name="recurring-displaymode">edit</xsl:param>
	 	<xsl:param name="show-product-types">Y</xsl:param>
	 	<xsl:call-template name="fieldset-wrapper">
    		<xsl:with-param name="content">
				   <div id="recurring_payment_checkbox">
				   <xsl:call-template name="multichoice-field">
          		 		<xsl:with-param name="label">XSL_RECURRING_PAYMENT</xsl:with-param>
          		 		<xsl:with-param name="type">checkbox</xsl:with-param>
           		 		<xsl:with-param name="name">recurring_flag</xsl:with-param>
           		 		<xsl:with-param name="disabled" select = "$recurring-disabled"/>	           		 		
           		 	 	<xsl:with-param name="override-displaymode" select = "$recurring-displaymode"/> 	           		 		
	            	</xsl:call-template>
	               </div>
			</xsl:with-param>
	   	</xsl:call-template>
	</xsl:template>
	
</xsl:stylesheet>