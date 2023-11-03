<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
		exclude-result-prefixes="localization">

<xsl:import href="../common/trade_common.xsl"/>

<!--
   Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->

	<xsl:param name="option"/>
	<xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
	<xsl:param name="executeImage"><xsl:value-of select="$images_path"/>execute.png</xsl:param>
	<xsl:param name="editImage"><xsl:value-of select="$images_path"/>edit.png</xsl:param>
	<xsl:param name="deleteImage"><xsl:value-of select="$images_path"/>delete.png</xsl:param>
	<xsl:param name="searchImage"><xsl:value-of select="$images_path"/>search.png</xsl:param>
	
	
	<!-- ********************************************************* -->
	<!-- Add some elements in the product forms on the client side -->
	<!-- ********************************************************* -->

	<xsl:template name="client_addons">
	</xsl:template>
  
  <!--TEMPLATE Main Bank (selectbox)-->
  
  <xsl:template name="main_bank_selectbox">
    <xsl:param name="main_bank_form"/> 
    <xsl:param name="main_bank_name"/>
    <xsl:param name="sender_name"/>
    <xsl:param name="sender_reference_name"/>

    <xsl:variable name="main_bank_abbv_name_value">
      <xsl:value-of select="//*[name()=$main_bank_name]/abbv_name"/>
    </xsl:variable>
    
    <xsl:variable name="main_bank_name_value">
      <xsl:if test="//*[name()=$main_bank_name]/name">
        <xsl:value-of select="//*[name()=$main_bank_name]/name"/>
      </xsl:if>
    </xsl:variable>
    
    <xsl:variable name="sender_reference_value"><xsl:value-of select="//*[name()=$sender_reference_name]"/></xsl:variable>
        
    <select> 
      <xsl:attribute name="name"><xsl:value-of select="$main_bank_name"/>_abbv_name</xsl:attribute>
      <xsl:attribute name="onchange">document.<xsl:value-of select="$main_bank_form"/>.<xsl:value-of select="$main_bank_name"/>_name.value = this.options[this.selectedIndex].text;fncPopulateReferences(this,document.<xsl:value-of select="$main_bank_form"/>.<xsl:value-of select="$main_bank_name"/>_customer_reference,document.<xsl:value-of select="$main_bank_form"/>.<xsl:value-of select="$sender_reference_name"/>, document.fakeform1.entity);fncRestoreInputStyle('<xsl:value-of select="$main_bank_form"/>','<xsl:value-of select="$main_bank_name"/>_abbv_name');</xsl:attribute>
      <xsl:if test="count(avail_main_banks/bank)>1">
        <option value="">&nbsp;</option>
      </xsl:if>
      <xsl:apply-templates select="avail_main_banks/bank" mode="main"/>
    </select>
    <input type="hidden">
      <xsl:attribute name="name"><xsl:value-of select="$main_bank_name"/>_name</xsl:attribute>
      <xsl:attribute name="value">
        <xsl:choose>
          <xsl:when test="$main_bank_name_value !=''"><xsl:value-of select="$main_bank_name_value"/></xsl:when>
          <!-- never used because if only one available main bank, server set it to current main bank -->
          <xsl:when test="count(//*/avail_main_banks/bank)=1"><xsl:value-of select="//*/avail_main_banks/bank/name"/></xsl:when>
          <xsl:otherwise/>
        </xsl:choose>
      </xsl:attribute>
    </input>
   </xsl:template>
   
   
  <!--TEMPLATE Customer References (input)-->
  <xsl:template name="customer_reference_input">
    <xsl:param name="sender_reference_name"/>
    
    <xsl:if test="not(avail_main_banks/bank/entity/customer_reference) and not(avail_main_banks/bank/customer_reference)">
      <tr>
        <td>&nbsp;</td>
        <td><xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_REFERENCE')"/></td>
        <td>
          <input type="text" size="35" maxlength="34">
            <xsl:attribute name="name"><xsl:value-of select="$sender_reference_name"/></xsl:attribute>
            <xsl:attribute name="value"><xsl:value-of select="//*[name()=$sender_reference_name]"/></xsl:attribute>
            <xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of select="$sender_reference_name"/>');</xsl:attribute>
          </input>
        </td>
      </tr>
    </xsl:if>
  </xsl:template>
                     
                      
  <!--TEMPLATE Customer References (selectbox)-->
  
  <xsl:template name="customer_reference_selectbox">
    <xsl:param name="main_bank_form"/> 
    <xsl:param name="main_bank_name"/>
    <xsl:param name="sender_name"/>
    <xsl:param name="sender_reference_name"/>
    
    <xsl:variable name="main_bank_abbv_name_value">
      <xsl:value-of select="//*[name()=$main_bank_name]/abbv_name"/>
    </xsl:variable>
    
    <xsl:variable name="sender_reference_value">
      <xsl:choose>
        <!-- current customer reference not null (draft) -->
        <xsl:when test="//*[name()=$sender_reference_name] != ''">
          <xsl:value-of select="//*[name()=$sender_reference_name]"/>
        </xsl:when>
        <!-- not entity defined and only one bank and only one customer reference available -->
        <xsl:when test="entities[.= '0']">
          <xsl:if test="count(avail_main_banks/bank/customer_reference)=1">
            <xsl:value-of select="avail_main_banks/bank/customer_reference/reference"/>
          </xsl:if>
        </xsl:when>
        <!-- only one entity, only one bank and only one customer reference available -->
        <xsl:otherwise>
          <xsl:if test="count(avail_main_banks/bank/entity/customer_reference)=1">
            <xsl:value-of select="avail_main_banks/bank/entity/customer_reference/reference"/>
          </xsl:if>          
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
   
    <!-- Check if customer references are defined for entities or not -->
    <xsl:if test="//*/avail_main_banks/bank/entity/customer_reference or avail_main_banks/bank/customer_reference">
    
	    <xsl:call-template name="select-field">
			<xsl:with-param name="label">XSL_PARTIESDETAILS_CUST_REFERENCE</xsl:with-param>
			<xsl:with-param name="name"><xsl:value-of select="$main_bank_name"/>_customer_reference</xsl:with-param>
			<!-- 
			<xsl:attribute name="onblur">fncRestoreInputStyle('<xsl:value-of select="$main_bank_form"/>','<xsl:value-of select="$main_bank_name"/>_customer_reference');</xsl:attribute>
            <xsl:attribute name="onchange">document.<xsl:value-of select="$main_bank_form"/>.<xsl:value-of select="$sender_name"/>_reference.value = this.options[this.selectedIndex].value;</xsl:attribute>
             -->
			<xsl:with-param name="options">
					<!-- Add a blank option if input field (hidden) applicant reference is empty to force user to select a value.-->
					<xsl:if test="$sender_reference_value=''">
	                  <option value=""><xsl:attribute name="selected"/></option>
					</xsl:if>
	                <xsl:choose>
		              <!-- if not entity defined -->         
		              <xsl:when test="entities[.= '0']">
		                <xsl:apply-templates select="avail_main_banks/bank[./abbv_name=$main_bank_abbv_name_value]/customer_reference" mode="option">
		                  <xsl:with-param name="selected_reference"><xsl:value-of select="$sender_reference_value"/></xsl:with-param>
		                </xsl:apply-templates>        
			          </xsl:when>
			          <!-- else -->  
			          <xsl:otherwise>
		                <xsl:apply-templates select="avail_main_banks/bank[./abbv_name=$main_bank_abbv_name_value]/entity[@name=../../../entity]/customer_reference" mode="option">
		                  <xsl:with-param name="selected_reference"><xsl:value-of select="$sender_reference_value"/></xsl:with-param>
		                </xsl:apply-templates>
		              </xsl:otherwise>
	            </xsl:choose>
			</xsl:with-param>
		</xsl:call-template>
		
        <xsl:call-template name="hidden-field">
			<xsl:with-param name="name"><xsl:value-of select="$sender_reference_name"/></xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="$sender_reference_value"/></xsl:with-param>
	    </xsl:call-template>
    </xsl:if>
  </xsl:template>
 
  
  
  <!--TEMPLATE Available Main Banks (Customer References JS Array)-->
  
	<xsl:template match="bank" mode="customer_references">
    <xsl:choose>
      <xsl:when test="../../entities[.= '0']">
         misys._config.customerReferences['<xsl:value-of select="abbv_name"/>_'] = [<xsl:call-template name="quote_replace"><xsl:with-param name="input_text"><xsl:value-of select="@name"/></xsl:with-param></xsl:call-template><xsl:apply-templates select="customer_reference" mode="array"/>];
         misys._config.isoCodes = misys._config.isoCodes || {};
    	 misys._config.isoCodes['<xsl:value-of select="abbv_name"/>'] = '<xsl:value-of select="iso_code"/>';
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="entity" mode="array"/>
      </xsl:otherwise>
    </xsl:choose>
	</xsl:template>
	
  
  <!--TEMPLATE Customer References (Customer References JS Array Entry)-->
	<xsl:template match="entity" mode="array">
		 misys._config.customerReferences['<xsl:value-of select="../abbv_name"/>_<xsl:call-template name="quote_replace"><xsl:with-param name="input_text"><xsl:value-of select="@name"/></xsl:with-param></xsl:call-template>'] = [<xsl:apply-templates select="customer_reference" mode="array"/>];
		 misys._config.isoCodes = misys._config.isoCodes || {};
		 misys._config.isoCodes['<xsl:value-of select="../abbv_name"/>'] = '<xsl:value-of select="../iso_code"/>';
	</xsl:template>
	
	
	<!--TEMPLATE Customer References (Customer References JS Array name, description)-->

	<xsl:template match="customer_reference" mode="array">'<xsl:value-of select="description"/>','<xsl:value-of select="reference"/>'<xsl:if test="not(position()=last())">,</xsl:if></xsl:template>
  
	<!--TEMPLATE Customer References (Selectbox Option)-->

	<xsl:template match="customer_reference" mode="option">
		<xsl:param name="selected_reference"/>
    <option>
    <xsl:attribute name="value"><xsl:value-of select="reference"/></xsl:attribute>
    <xsl:if test="reference[.=$selected_reference]">
      <xsl:attribute name="selected"/>
    </xsl:if>
    <xsl:value-of select="description"/>
  </option>
	</xsl:template>

<!-- 
	<xsl:template name="quote_replace">
            <xsl:param name="input_text"/>
            <xsl:variable name="quote"><xsl:text>'</xsl:text></xsl:variable>
            <xsl:choose>
                <xsl:when test="contains($input_text,$quote)">
                    <xsl:value-of select="substring-before($input_text,$quote)"/><xsl:text>\'</xsl:text><xsl:call-template name="quote_replace">
                        <xsl:with-param name="input_text" select="substring-after($input_text,$quote)"/>
                    </xsl:call-template>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$input_text"/>
                    </xsl:otherwise>
		</xsl:choose>
	</xsl:template>
 -->
 
	<xsl:template match="counterparties">

		<!--************************-->
		<!-- Counterparties Details -->
		<!--************************-->
		<!--<form> -->
		<!-- xsl:attribute name="name">form_<xsl:value-of select="counterparties"/></xsl:attribute-->
		<!--xsl:attribute name="name">fakeform1</xsl:attribute>-->

		<br/>
		<div id="counterparty_section">

			<table border="0" width="100%" cellspacing="0">
				<tr>
					<td width="40">&nbsp;</td>
					<td>
						<div>
							<xsl:attribute name="id">counterparty_disclaimer</xsl:attribute>
							<xsl:if test="count(counterparty) != 0">
								<xsl:attribute name="style">display:none</xsl:attribute>
							</xsl:if>
							<b><xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_NO_COUNTERPARTY')"/></b>
						</div>
								
						<table border="0" width="524" cellspacing="0" id="counterparty_master_table">
							<xsl:if test="count(/*/counterparties/counterparty) = 0">
								<xsl:attribute name="style">position:absolute;visibility:hidden;</xsl:attribute>
							</xsl:if>
							<tbody id="counterparty_table">

								<tr>
									<xsl:attribute name="id">counterparty_table_header_1</xsl:attribute>
									<xsl:if test="count(counterparty) = 0">
										<xsl:attribute name="style">visibility:hidden;</xsl:attribute>
									</xsl:if>
									<th class="FORMH3" align="center" width="55%"><xsl:value-of select="localization:getGTPString($language, 'XSL_FT_HEADER_BENEFICIARY_ACT_NO')"/></th>
									<th class="FORMH3" align="center" width="10%"><xsl:value-of select="localization:getGTPString($language, 'XSL_FT_HEADER_CUR_CODE')"/></th>
									<th class="FORMH3" align="center" width="25%"><xsl:value-of select="localization:getGTPString($language, 'XSL_FT_HEADER_AMOUNT')"/></th>
									<th class="FORMH3" width="10%">&nbsp;</th>
								</tr>

								<xsl:for-each select="counterparty">
									
									<xsl:call-template name="COUNTERPARTY_DETAILS">
										<xsl:with-param name="structure_name">counterparty</xsl:with-param>
										<xsl:with-param name="mode">
											<xsl:choose>
												<xsl:when test="$option='TEMPLATE'">copy</xsl:when>
												<xsl:otherwise>existing</xsl:otherwise>
											</xsl:choose>
										</xsl:with-param>
									</xsl:call-template>
									
								</xsl:for-each>
							</tbody>
						</table>
						<br/>
						<a href="javascript:void(0)">
							<xsl:attribute name="onClick">if (!fncCheckField('fakeform1', 'input_cur_code')){return false;}fncPreloadImages('<xsl:value-of select="utils:getImagePath($searchImage)"/>', '<xsl:value-of select="utils:getImagePath($executeImage)"/>', '<xsl:value-of select="utils:getImagePath($editImage)"/>', '<xsl:value-of select="utils:getImagePath($deleteImage)"/>'); fncLaunchProcess("fncAddElement('fakeform1', 'counterparty', 'fncPopulateCurCode')");</xsl:attribute>
							<xsl:value-of select="localization:getGTPString($language, 'XSL_DETAILS_ADD_COUNTERPARTY')"/>
						</a>
					</td>
				</tr>
			</table>
			<br/>
		</div>

	</xsl:template>
	
	
	<!-- Counterparties Details -->
	<xsl:template name="COUNTERPARTY_DETAILS">

		<xsl:param name="structure_name"/>
		<xsl:param name="mode"/>
		<xsl:param name="suffix">
			<xsl:if test="$mode = 'existing' or $mode = 'copy'"><xsl:value-of select="position()"></xsl:value-of></xsl:if>
			<xsl:if test="$mode = 'template'">nbElement</xsl:if>
		</xsl:param>
		
		<xsl:variable name="currentPrefix">
			<xsl:if  test="//tnx_type_code[.!='01']">customer_</xsl:if>
		</xsl:variable>
		
		<xsl:variable name="currentEntity">
				<xsl:value-of select="//entity"/>
		</xsl:variable>
		
		
		<xsl:variable name="currentFTType">
				<xsl:value-of select="//ft_type"/>
		</xsl:variable>
		
		<!-- Initialize the entitycontext request paramater. It is used to select
			the right accounts.
			On the client side, when a FT is created, we pass the entity
			populated in the form by the user.
			On the bank side, when a reporting is done on a FT, the entitycontext value
			is one of the FT
		<xsl:variable name="entityValue">
			<xsl:choose>
   				<xsl:when test="$currentEntity != ''">entitycontext=<xsl:value-of select="$currentEntity"/></xsl:when>
				<xsl:otherwise>entitycontext='+document.forms["fakeform1"].elements["entity"].value + '</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:param name="formName"/>-->
		
		<tr>
			<xsl:if test="$mode = 'template'">
				<xsl:attribute name="style">visibility:hidden;</xsl:attribute>
			</xsl:if>
			<xsl:attribute name="id">
				<xsl:value-of select="$structure_name"/>_header_<xsl:value-of select="$suffix"/>
			</xsl:attribute>
			
			<td align="left">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_1</xsl:attribute>
				</xsl:if>
				<!-- 
				<div align="left">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_label_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:value-of select="counterparty_label"/>
					</xsl:if>
				</div>
				-->
				<div align="left">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_act_no_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:value-of select="counterparty_act_no"/>
					</xsl:if>
				</div>				
			</td>
			<td align="center">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_2</xsl:attribute>
				</xsl:if>
				<div align="center">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_ft_cur_code_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:value-of select="counterparty_cur_code"/>
					</xsl:if>
				</div>
			</td>
			<td align="right">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_3</xsl:attribute>
				</xsl:if>
				<div align="right">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_header_ft_amt_<xsl:value-of select="$suffix"/></xsl:attribute>
					<xsl:if test="$mode = 'existing'">
						<xsl:value-of select="counterparty_amt"/>
					</xsl:if>
				</div>
			</td>
			<td align="center">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_header_template_cell_4</xsl:attribute>
				</xsl:if>
				<a href="javascript:void(0)">
					<xsl:attribute name="onClick">fncDisplayElement('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>);</xsl:attribute>
					<img border="0" src="/content/images/edit.png">
						<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_MODIFY')"/></xsl:attribute>
					</img>
				</a>
				<a href="javascript:void(0)">
					<xsl:attribute name="onClick">fncDeleteElement('fakeform1', '<xsl:value-of  select="$structure_name"/>', <xsl:value-of select="$suffix"/>, ['counterparty_table_header_1']); fncComputeFTTotalAmount('fakeform1', 'counterparty', 'ft_amt', 'tnx_amt', 'ft_cur_code');</xsl:attribute>
					<img border="0" src="/content/images/delete.png">
						<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'ACTION_USER_DELETE')"/></xsl:attribute>
					</img>
				</a>
			</td>
		</tr>

		<tr>
			<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_details_<xsl:value-of select="$suffix"/></xsl:attribute>
			<td colspan="6">
				<xsl:if test="$mode = 'template'">
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_IE_details_template_cell_1</xsl:attribute>
				</xsl:if>
				<div>
					<xsl:if test="$mode = 'existing'">
						<xsl:attribute name="style">display:none;</xsl:attribute>
					</xsl:if>
					<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_display_details_<xsl:value-of select="$suffix"/></xsl:attribute>
					<table border="1" width="100%" cellspacing="0" cellpadding="0">
						<tr>
							<td>
								<table width="100%" cellspacing="0" cellpadding="0" border="0">
									<tr>
										<td colspan="3">&nbsp;</td>
										<!--  hidden counter and id -->
										<input type="hidden">
											<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_position_<xsl:value-of select="$suffix"/></xsl:attribute>
											<xsl:attribute name="id"><xsl:value-of  select="$structure_name"/>_details_position_<xsl:value-of select="$suffix"/></xsl:attribute>
											<xsl:attribute name="value">
												<xsl:value-of select="$suffix"/>
											</xsl:attribute>
										</input>
										<input type="hidden">
											<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_id_<xsl:value-of select="$suffix"/></xsl:attribute>
											<xsl:attribute name="value"><xsl:value-of select="counterparty_id"/></xsl:attribute>
										</input>
									</tr>
									<tr>
					          			<td width="40">&nbsp;</td>
				          				<td width="150">
											<font class="FORMMANDATORY">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BENEFICIARY_ACT_NO')"/>
											</font>
			          					</td>
			          					<td>
											<input type="text" size="34" maxlength="34">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_act_no_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="counterparty_act_no"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of select="$structure_name"/>_details_act_no_<xsl:value-of select="$suffix"/>');</xsl:attribute>
											</input>&nbsp;
											<a name="anchor_search_beneficiary" href="javascript:void(0)">
												<xsl:attribute name="onclick">fncSearchPopup('account', 'fakeform1',"['<xsl:value-of select="$structure_name"/>_details_act_no_<xsl:value-of select="$suffix"/>','<xsl:value-of select="$structure_name"/>_details_name_<xsl:value-of select="$suffix"/>','<xsl:value-of select="$structure_name"/>_details_address_line_1_<xsl:value-of select="$suffix"/>','<xsl:value-of select="$structure_name"/>_details_address_line_2_<xsl:value-of select="$suffix"/>', '<xsl:value-of select="$structure_name"/>_details_dom_<xsl:value-of select="$suffix"/>' ]",'&amp;company_id=<xsl:value-of select="company_id"/>&amp;entity_name=<xsl:value-of select="$currentEntity"/>', '', '<xsl:value-of select="//product_code"/>');return false;</xsl:attribute>
												<img border="0" name="img_search_beneficiary">
													<xsl:attribute name="src"><xsl:value-of select="utils:getImagePath($searchImage)"/></xsl:attribute>
													<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_BENEFICIARY')"/>	</xsl:attribute>
												</img>
											</a>
										</td>			          					
							       	</tr>
									<tr>
							          <td width="40">&nbsp;</td>
							          <td width="150">
							            <font class="FORMMANDATORY">
							              	<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_BENEFICIARY_NAME')"/>
							            </font>
							          </td>
								      <td>
											<input type="text" size="34" maxlength="34">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_name_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of select="$structure_name"/>_details_name_<xsl:value-of select="$suffix"/>');</xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="counterparty_name"/></xsl:attribute>
							            </input>
								      </td>
							       	</tr>
							       	<!-- Display the address (address line 1 addres line 2 and domiciliation) part for the  outgoing fund transfer
							         Note, it is possible to display it for the internal fund transfer by removing the line below and the line  under which there is "Delete the line above to display the addionnal address part" -->
									<xsl:if test="$currentFTType = '02'">
										<tr>
											<td width="40">&nbsp;</td>
									          <td width="150">
									              <xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_ADDRESS')"/>
									          </td>														
								        <td>						
										<input type="text" size="35" maxlength="35">
											<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_address_line_1_<xsl:value-of select="$suffix"/></xsl:attribute>
											<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of select="$structure_name"/>_details_address_line_1_<xsl:value-of select="$suffix"/>');</xsl:attribute>
											<xsl:attribute name="value"><xsl:value-of select="counterparty_address_line_1"/></xsl:attribute>
										</input>													
									 </td>
									</tr>
									<tr>
										<td width="40">&nbsp;</td>
							          	<td width="150">&nbsp;</td>
							          	<td>						
											<input type="text" size="35" maxlength="35">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_address_line_2_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of select="$structure_name"/>_details_address_line_2_<xsl:value-of select="$suffix"/>');</xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="counterparty_address_line_2"/></xsl:attribute>
											</input>													
							       		</td>
									</tr>
									<tr>
			          					<td width="40">&nbsp;</td>
							          	<td width="150">&nbsp;</td>														
						       			<td>						
											<input type="text" size="35" maxlength="35">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_dom_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of select="$structure_name"/>_details_dom_<xsl:value-of select="$suffix"/>');</xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="counterparty_dom"/></xsl:attribute>
								            </input>            
						          		</td>
									</tr>
									</xsl:if>
									<!-- Delete the line above to display the addionnal address part -->
									
							        <tr>
						          		<td width="40">&nbsp;</td>
						          		<td width="150">
					            			<font class="FORMMANDATORY">
				              					<xsl:value-of select="localization:getGTPString($language, 'XSL_PARTIESDETAILS_FT_AMT_LABEL')"/>
		            						</font>
		          						</td>
								        <td>
								        	<input type="text" size="3" maxlength="3">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_ft_cur_code_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_ft_cur_code_<xsl:value-of select="$suffix"/>');</xsl:attribute>
												<xsl:attribute name="onfocus">this.blur()</xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="counterparty_cur_code"/></xsl:attribute>
											</input>
											<input type="text" size="21" maxlength="21">
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_ft_amt_<xsl:value-of select="$suffix"/>');fncFormatAmount(this,fncGetCurrencyDecNo(document.forms['fakeform1'].<xsl:value-of  select="$structure_name"/>_details_ft_cur_code_<xsl:value-of select="$suffix"/>.value));</xsl:attribute>
              									<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_ft_amt_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="value"><xsl:value-of select="counterparty_amt"/></xsl:attribute>
            								</input><!--&nbsp;
											<a name="anchor_search_ft_currency" href="javascript:void(0)">
												<xsl:attribute name="onclick">fncSearchPopup('currency', 'fakeform1',"['<xsl:value-of  select="$structure_name"/>_details_ft_cur_code_<xsl:value-of select="$suffix"/>']");return false;</xsl:attribute>
												<img border="0" src="/content/images/search.png" name="img_search_ft_currency">
													<xsl:attribute name="alt"><xsl:value-of select="localization:getGTPString($language, 'XSL_ALT_CURRENCY')"/></xsl:attribute>
												</img>
											</a>-->										
								        </td>
							        </tr>
									<tr>
										<td width="40">&nbsp;</td>
										<td width="150">
										<font class="FORMMANDATORY">
											<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_FT_COUNTERPARTY_REFERENCE')"/>
										</font>
										</td>
										
										<td>
								        	<input type="text" size="12" maxlength="12">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_reference_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_reference_<xsl:value-of select="$suffix"/>');</xsl:attribute>
              									<xsl:attribute name="value"><xsl:value-of select="counterparty_reference"/></xsl:attribute>
											</input>
										</td>
									</tr>
									<!-- <tr>
										<td width="40">&nbsp;</td>
										<td width="150">
											<font class="FORMMANDATORY">
												<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_FT_COUNTERPARTY_LABEL')"/>
											</font>
										</td>
										<td>
								        	<input type="text" size="31" maxlength="31">
												<xsl:attribute name="name"><xsl:value-of  select="$structure_name"/>_details_label_<xsl:value-of select="$suffix"/></xsl:attribute>
												<xsl:attribute name="onblur">fncRestoreInputStyle('fakeform1','<xsl:value-of  select="$structure_name"/>_details_label_<xsl:value-of select="$suffix"/>');</xsl:attribute>
              									<xsl:attribute name="value"><xsl:value-of select="counterparty_label"/></xsl:attribute>
											</input>
										</td>
									</tr>-->
									<tr>
										<td colspan="3">&nbsp;</td>
									</tr>
									<tr>
										<td colspan="3">
											<table width="100%">
												<td align="right" width="45%">
													<a href="javascript:void(0)">
														<xsl:attribute name="onclick">if (fncAddElementValidate('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, '', ['name','act_no', 'ft_cur_code', 'ft_amt', 'reference'], ['act_no', 'ft_cur_code', 'ft_amt'], ['counterparty_table_header_1']) == true) {fncComputeFTTotalAmount('fakeform1', 'counterparty', 'ft_amt', 'tnx_amt', 'ft_cur_code')}</xsl:attribute>
														<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_OK')"/>
													</a>
												</td>
												<td width="10%"/>
												<td align="left" width="45%">
													<a href="javascript:void(0)">
														<xsl:attribute name="id"><xsl:value-of select="$structure_name"/>_cancel_button_<xsl:value-of select="$suffix"/></xsl:attribute>
														<xsl:attribute name="onclick">fncAddElementCancel('fakeform1', '<xsl:value-of select="$structure_name"/>', <xsl:value-of select="$suffix"/>, 'ft_amt', ['counterparty_table_header_1']); fncComputeFTTotalAmount('fakeform1', 'counterparty', 'ft_amt', 'tnx_amt', 'ft_cur_code');</xsl:attribute>
														<xsl:value-of select="localization:getGTPString($language, 'XSL_SYSTEMFEATURES_CANCEL')"/>
													</a>
												</td>
											</table>
										</td>
									</tr>
								</table>
							</td>
						</tr>		
					</table>
				</div>
			</td>
		</tr>
	</xsl:template>


     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>

