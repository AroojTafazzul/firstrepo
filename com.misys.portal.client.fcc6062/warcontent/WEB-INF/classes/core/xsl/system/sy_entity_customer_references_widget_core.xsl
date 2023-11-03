<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
User Accounts Assignment

version:   1.0
date:      22/10/2011
author:    veena jyothi
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
    exclude-result-prefixes="localization utils">
    <xsl:param name="currentmode"/>
	<xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
	<xsl:param name="actionDownImage"><xsl:value-of select="$images_path"/>action-down.png</xsl:param>
	<xsl:param name="actionUpImage"><xsl:value-of select="$images_path"/>action-up.png</xsl:param>
	
	<xsl:template name="entity_customer_references-component">
		<xsl:param name="companyType"/>
	 <xsl:call-template name="fieldset-wrapper">
	     <xsl:with-param name="legend">XSL_ENTITY_CIF_DETAILS</xsl:with-param>
	     <xsl:with-param name="content">
			 <div class="widgetContainer entitycustomerreferences">
				 <xsl:call-template name="hidden-field">
                 	<xsl:with-param name="name">CompanyId</xsl:with-param>
                  	<xsl:with-param name="value" select="/entity_record/company_id" />
               	 </xsl:call-template> 
	             <xsl:call-template name="hidden-field">
	                <xsl:with-param name="name">Curr_mode</xsl:with-param>
	                <xsl:with-param name="value" select="$currentmode" />
	             </xsl:call-template>               
				  
				<script>
				     dojo.ready(function(){
				  		misys._config = misys._config || {};
				  		misys._config.entityArray = "<xsl:value-of select='utils:getEntityArrayForCompany($company)'/>";
				  		dojo.mixin(misys._config, {
				  			entityReferencesMapping: {
					  			<xsl:for-each select="entity_reference">
								     <xsl:variable name="entity_reference_record" select="."/>					    
										     <xsl:variable name="customerref" ><xsl:value-of select="$entity_reference_record/reference"/></xsl:variable>
										     <xsl:variable name="customerdesc" ><xsl:value-of select="$entity_reference_record/description"/></xsl:variable>
										     <xsl:variable name="customerbank" ><xsl:value-of select="$entity_reference_record/bank_abbv_name"/></xsl:variable>
										"<xsl:value-of select="$customerref"/>":"<xsl:value-of select="$customerdesc"/>"
										<xsl:if test="position()!=last()">,</xsl:if> 
									</xsl:for-each>
								},
							entityReferencesBanks: [
					  			<xsl:for-each select="entity_reference">
								     <xsl:variable name="entity_reference_record" select="."/>					    
										     <xsl:variable name="customerbank" ><xsl:value-of select="$entity_reference_record/bank_abbv_name"/></xsl:variable>
										"<xsl:value-of select="$customerbank"/>"
										<xsl:if test="position()!=last()">,</xsl:if> 
								</xsl:for-each>
								]
								
				        });
				   	});
			  	</script>
			  	
						
				<!-- Check if customer references exists for a customer -->
	  			<xsl:choose>
				 	<xsl:when test="count(customer_references) > 0 ">
					 	<xsl:call-template name="entity_customer_references_table"/>				 	 	
					</xsl:when>
					<xsl:otherwise>
						<div><xsl:value-of select="localization:getGTPString($language, 'XSL_NO_CUSTOMER_REFERENCES')"></xsl:value-of></div>		
					</xsl:otherwise>
			   </xsl:choose>
			</div>
		</xsl:with-param>
	 </xsl:call-template>
   </xsl:template>
   
   <xsl:template name="entity_customer_references_table">
   		<div style="width:100%;">
		 <xsl:for-each select="banks/bank">
		 	<xsl:variable name="customerbank" select="abbv_name" />
			<!--<xsl:sort select="bank"></xsl:sort> -->
			<xsl:variable name="customer_reference" select="//customer_references[bank_abbv_name = $customerbank]"/>
			<xsl:variable name="bank_id" select="id"></xsl:variable>
			
			 <xsl:variable name="entiycustomerreferencesCount"><xsl:value-of select="count($customer_reference)"/></xsl:variable>
				 
		     <xsl:call-template name="hidden-field">
                	<xsl:with-param name="name">Customer_references_count_<xsl:value-of select="$customerbank"/></xsl:with-param>
                 	<xsl:with-param name="value" select="$entiycustomerreferencesCount" />
             </xsl:call-template>
             
             <xsl:call-template name="hidden-field">
                	<xsl:with-param name="name">bank_id_<xsl:value-of select="$customerbank"/></xsl:with-param>
                 	<xsl:with-param name="value" select="$bank_id" />
             </xsl:call-template>
             
             <script>
			     dojo.ready(function(){
			  		misys._config = misys._config || {};
			  		misys._config.attachedBanks = misys._config.attachedBanks || new Array();
			  		misys._config.attachedBanks.push('<xsl:value-of select="$customerbank"/>');
			   	});
		  	</script>
		  	
		  	<xsl:variable name="isRefSecExpanded">
		  		<xsl:choose>
		  			<xsl:when test="count(//entity_reference[bank_abbv_name = $customerbank]) > 0">Y</xsl:when>
		  			<xsl:otherwise>N</xsl:otherwise>
		  		</xsl:choose>
		  	</xsl:variable>						
			
			<xsl:if test="count($customer_reference) > 0">
				<div>
					<div class="entityReferencesTableCell entityReferencesTableCellOdd alignLeftWithPadding moderncolor" style="width:96%;"> 
						 <xsl:value-of select="name" /> (<xsl:value-of select="$customerbank" />)&nbsp;								
					</div>
					<div class="entityReferencesTableCell entityReferencesTableCellOdd alignCenterWithPadding moderncolor" style="width:3%;">
					<span>
						<xsl:attribute name="id">customer_bank_down_<xsl:value-of select="$customerbank"/></xsl:attribute>
						<xsl:attribute name="style">
							<xsl:choose>
								<xsl:when test="$isRefSecExpanded = 'Y'">display:none;</xsl:when>
								<xsl:otherwise>display:inline;</xsl:otherwise>
							</xsl:choose>
							cursor:pointer;vertical-align:middle;
						</xsl:attribute>
						<a>
							<xsl:attribute name="onClick">misys.toggleReferenceSection('<xsl:value-of select="$customerbank"/>','down');</xsl:attribute>
							<img>
								<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($actionDownImage)"/></xsl:attribute>
								<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'OPEN_PRODUCTS_ASSIGNMENT')"/></xsl:attribute>
							</img>
						</a>
					</span>
					<span>
						<xsl:attribute name="style">
							<xsl:choose>
								<xsl:when test="$isRefSecExpanded = 'N'">display:none;</xsl:when>
								<xsl:otherwise>display:inline;</xsl:otherwise>
							</xsl:choose>
							cursor:pointer;vertical-align:middle;
						</xsl:attribute>
						 <xsl:attribute name="id">customer_bank_up_<xsl:value-of select="$customerbank"/></xsl:attribute>
						 <a>
							<xsl:attribute name="onClick">misys.toggleReferenceSection('<xsl:value-of select="$customerbank"/>','up');</xsl:attribute>
							<img>
								<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($actionUpImage)"/></xsl:attribute>
								<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'CLOSE_PRODUCTS_ASSIGNMENT')"/></xsl:attribute>
							</img>
						</a> 
					</span>
					</div>
				</div>			
			
				<div id="{$customerbank}" class="alignCenterWithPadding">
					<xsl:attribute name="style">
						<xsl:choose>
							<xsl:when test="$isRefSecExpanded = 'Y'">display:inline;padding:5px;</xsl:when>
							<xsl:otherwise>display:none;padding:5px;</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>	
				<div>
				<div class="entityReferencesTableCell entityReferencesTableCellHeader" style="width:3%">
				</div>
				<div class="entityReferencesTableCell entityReferencesTableCellHeader  entityReferencesColumnCell" style="width:40%;">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_TABLE_HEADER_CUSTOMER_REFERENCE')"/>
					    </div>
			   			<div class="entityReferencesTableCell entityReferencesTableCellHeader  entityReferencesColumnCell" style="width:40%;">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_TABLE_HEADER_CUSTOMER_DESCRIPTION')"/>
						</div>
				</div>
				
				<xsl:for-each select="$customer_reference">
					<xsl:variable name="customer_reference_position" select="position()" />
				 	<xsl:variable name="customerref" select="$customer_reference[$customer_reference_position]/reference" />
					<xsl:variable name="customerdesc" select="$customer_reference[$customer_reference_position]/description" />
					<xsl:variable name="bankabbvname" select="$customer_reference[$customer_reference_position]/bank_abbv_name" />
					
					<xsl:call-template name="hidden-field">
					 	<xsl:with-param name="name">custbank_<xsl:value-of select="$customerbank"/>_<xsl:value-of select="$customer_reference_position"/></xsl:with-param>
	                  	<xsl:with-param name="value" select="$customerbank" />
	                 </xsl:call-template>
			
					<div>
					<div class="entityReferencesTableCell entityReferencesTableCellOdd alignCenterWithPadding entityReferencesHeaderSelector referenceTable" style="width:3%">
						<xsl:call-template name="column-check-box">
							<xsl:with-param name="id">ref_enabled_<xsl:value-of select="$customerbank"/>_<xsl:value-of select="$customer_reference_position"/></xsl:with-param>
							<xsl:with-param name="disabled">
								<xsl:choose>
									<xsl:when test="$currentmode ='VIEW'">Y</xsl:when>
									<xsl:otherwise>N</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>
							<xsl:with-param name="checked">
								<xsl:choose>
									<xsl:when test="$currentmode ='VIEW'">
										<xsl:choose>
											<xsl:when test="count(//entity_reference[reference = utils:decryptApplicantReference($customerref)]) > 0 and 
											                count(//entity_reference[bank_abbv_name = $bankabbvname]) > 0 ">Y</xsl:when>
											<xsl:otherwise>N</xsl:otherwise>
										</xsl:choose>
									</xsl:when>
									<xsl:otherwise>N</xsl:otherwise>
								</xsl:choose>
							</xsl:with-param>			
						</xsl:call-template>
					</div>	 
					<div class="entityReferencesTableCell entityReferencesTableCellOdd alignLeftWithPadding referenceTable" style="width:40%;">
						 <xsl:call-template name="hidden-field">
						 	<xsl:with-param name="name">custref_<xsl:value-of select="$customerbank"/>_<xsl:value-of select="$customer_reference_position"/></xsl:with-param>
		                  	<xsl:with-param name="value" select="utils:decryptApplicantReference($customerref)" />
		                 </xsl:call-template> 				
						 <xsl:value-of select="utils:decryptApplicantReference($customerref)"/>&nbsp;														
					</div>										
													
					<div class="entityReferencesTableCell entityReferencesTableCellOdd alignLeftWithPadding referenceTable" style="width:40%;">
						 <xsl:call-template name="hidden-field">
						 	<xsl:with-param name="name">custdesc_<xsl:value-of select="$customerbank"/>_<xsl:value-of select="$customer_reference_position"/></xsl:with-param>
		                  	<xsl:with-param name="value" select="$customerdesc" />
		                 </xsl:call-template> 
						 <xsl:value-of select="$customerdesc"/>&nbsp;								
					</div>
					</div>
			
				</xsl:for-each>
				
					
				
					
				</div>
			
			</xsl:if>
			
  		</xsl:for-each>
  		</div>
  </xsl:template>
  
  <xsl:template name="entity_references_table">
   		<xsl:choose>
              <xsl:when test="count(entity_reference) > 0 ">
	            <xsl:for-each select="entity_reference">
					<xsl:variable name="entity_ref" select="."/>
					<xsl:variable name="entity_ref_position" select="position()" />
					<xsl:variable name="entityrefer" select="$entity_ref/reference" />
					<xsl:variable name="entitydesc" select="$entity_ref/description" />
					<xsl:variable name="entitybank" select="$entity_ref/bank" />			
	
					<div style="width:100%;">
						<div class="entityReferencesTableCell entityReferencesTableCellOdd alignLeftWithPadding" style="width:100%;">
							 <xsl:call-template name="hidden-field">
							 	<xsl:with-param name="name">custbank_<xsl:value-of select="$entity_ref_position"/></xsl:with-param>
			                  	<xsl:with-param name="value" select="$entitybank" />
		                 	 </xsl:call-template> 
							 <xsl:value-of select="$entitybank"/>&nbsp;								
						</div>
					</div>	
	  			</xsl:for-each>
	 		</xsl:when>
	        <xsl:otherwise>
				<div><xsl:value-of select="localization:getGTPString($language, 'XSL_NO_CUSTOMER_REFERENCES')"></xsl:value-of></div>		
			</xsl:otherwise>
		</xsl:choose>			
   </xsl:template>
   
   <xsl:template name="column-check-box">
		<xsl:param name="disabled"/>
	    <xsl:param name="readonly"/>
	    <xsl:param name="checked"/>
	    <xsl:param name="id"/>
		<div dojoType="dijit.form.CheckBox">
			<xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
			<xsl:if test="$disabled='Y'">
	         <xsl:attribute name="disabled">true</xsl:attribute>
	        </xsl:if>
	        <xsl:if test="$readonly='Y' or $displaymode='view'">
	         <xsl:attribute name="readOnly">true</xsl:attribute>
	        </xsl:if>
	        <xsl:if test="$checked='Y'">
	         <xsl:attribute name="checked"/>
	        </xsl:if>	 	 
  		</div>
   </xsl:template>


</xsl:stylesheet>