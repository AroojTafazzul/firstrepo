<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools"
	xmlns:security="xalan://com.misys.portal.security.GTPSecurity"
	exclude-result-prefixes="converttools security">
<!--
   Copyright (c) 2000-2009 Misys (http://www.misys.com),
   All Rights Reserved. 
-->

	<!-- Get the parameters -->

	<xsl:output method="xml" indent="no"/>
	
	<!-- Get the language code -->
	<xsl:param name="language"/>
	<xsl:param name="rundata"/>
	<xsl:param name="text" value="_" />


	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates/>
	</xsl:template>

	<!-- Process Letter of Credit and Issued Stand By-->
	<xsl:template match="report">
    
		<xsl:element name="listdef">
			<xsl:attribute name="page"><xsl:value-of select="max_nb_lines"/></xsl:attribute>
			<xsl:if test="input_source_type != ''">
				<xsl:attribute name="source">
						<xsl:value-of select="input_source_type"/>
				</xsl:attribute>
			</xsl:if> 
			<xsl:if test="order_list_by_default = 'Y'">
				<xsl:attribute name="default_order"><xsl:value-of select="order_column"/></xsl:attribute>
				<xsl:attribute name="default_order_type"><xsl:value-of select="order_type"/></xsl:attribute>
			</xsl:if>
			<!-- Set hideSearch attribute to true for report preview screens, to not show the search container -->
			<xsl:attribute name="hideSearch">false</xsl:attribute>
			<xsl:attribute name="huge">
				<xsl:if test="parameters/parameter and parameters/parameter/parameter_name and parameters/parameter/mandatory = 'Y'">Y</xsl:if>
			</xsl:attribute>
			<xsl:element name="script">
				var productCode = row.getColumnValue("product_code");
				if(("BK").equals(""+productCode+""))
				{
					return com.misys.portal.report.tools.Tools.checkBulkFileAmountAndItemPermission(runData, row);
				}
				else
				{
					return true; 
				}
			</xsl:element>
			<reportId>
				<xsl:value-of select="report_id"></xsl:value-of>
			</reportId>
			<name>
				<xsl:value-of select="report_name"></xsl:value-of>
			</name>
			<description>
				<xsl:value-of select="report_desc"></xsl:value-of>
			</description>
			<multiProduct>
				<xsl:value-of select="multi_product"/>
			</multiProduct>
			<report_type>
				<xsl:value-of select="report_type"/>
			</report_type>
			

			<!-- Build the list of product codes -->
			<product_code>
				<xsl:call-template name="PRODUCT_CODES"/>
			</product_code>
    
			<!-- Equivalent currency -->
			<equivalentCurrency>
				<xsl:value-of select="equivalent_currency"></xsl:value-of>
			</equivalentCurrency>
			
			
			<!-- Displayed columns -->
			<xsl:call-template name="DISPLAYED_COLUMNS"/>

			<!-- Hidden columns -->
			<xsl:call-template name="HIDDEN_COLUMNS"/>
			
			<!-- Parameters -->
			<xsl:call-template name="PARAMETERS"/>
			
			<!-- Add CSV Export -->
			<xsl:element name="parameter">
				<xsl:attribute name="name">export_list</xsl:attribute>
				<xsl:attribute name="file"><xsl:value-of select="report_name"/></xsl:attribute>
				<xsl:attribute name="type">export</xsl:attribute>
				<xsl:attribute name="file_name"><xsl:value-of select="report_name"/></xsl:attribute>
			</xsl:element>
			
			<!-- Filters -->
			<xsl:call-template name="FILTERS"/>
			
			<!-- Aggregates -->
			<xsl:if test="chart_flag != 'Y'">
				<xsl:call-template name="OVERALL_AGGREGATES"/>
			</xsl:if>
			
			<!-- Grouping -->
			<xsl:if test="chart_flag != 'Y'">
				<xsl:call-template name="GROUPING"/>
			</xsl:if>
			
			<!-- Chart -->
			<xsl:if test="chart_flag = 'Y'">
				<xsl:call-template name="CHART"/>
			</xsl:if>
			
			<!-- Executable Flag -->
			<xsl:if test="executable_flag != ''">
				<executable_flag><xsl:value-of select="executable_flag"/></executable_flag>
			</xsl:if>					

			<!-- All banks Flag -->
			<xsl:if test="all_banks_flag != ''">
				<all_banks_flag><xsl:value-of select="all_banks_flag"/></all_banks_flag>
			</xsl:if>

		</xsl:element>
	</xsl:template>

	
	<!--*******************-->
	<!-- Displayed columns -->
	<!--*******************-->

	<xsl:template name="DISPLAYED_COLUMNS">
		<xsl:element name="use_absolute_width">
			<xsl:value-of select="use_absolute_width"/>
		</xsl:element>
		<xsl:element name="order_list_by_default">
			<xsl:value-of select="order_list_by_default"/>
		</xsl:element>
		
		<xsl:apply-templates select="columns/column"/>
		
	</xsl:template>
			
	<xsl:template match="column">
		<xsl:if test="count(../column/column[.='action_code_derived']) > 0 and count(../column/column[.='action_code']) = 0" >
			<xsl:element name="column">
				<xsl:attribute name="name">action_code</xsl:attribute>
				<xsl:attribute name="hidden">y</xsl:attribute>
			</xsl:element>
		</xsl:if>
		<xsl:element name="column">
			<xsl:if test="computed_field_id = ''">
				<xsl:attribute name="name"><xsl:value-of select="column"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="computed_field_id != ''">
				<xsl:attribute name="computation"><xsl:value-of select="operation"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="alignment != ''">
				<xsl:attribute name="align"><xsl:value-of select="alignment"/></xsl:attribute>
			</xsl:if>
			<!-- Width should always be considered as percentage -->
			<xsl:if test="width != '' and width != '0' and width != 'NaN'">
				<xsl:attribute name="width"><xsl:value-of select="width"/>%</xsl:attribute>
			</xsl:if>
			<xsl:if test="eqv_cur_code != ''">
				<xsl:attribute name="cur"><xsl:value-of select="eqv_cur_code"/></xsl:attribute>
				<xsl:attribute name="altName">
					<xsl:value-of select="column"/>
					<xsl:text>_</xsl:text>
					<xsl:value-of select="eqv_cur_code"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="abbreviation != ''">
				<xsl:attribute name="abbreviation"><xsl:value-of select="abbreviation"/></xsl:attribute>
			</xsl:if>
			<xsl:if test="computed_field_id != ''">
				<xsl:attribute name="name"><xsl:value-of select="computed_field_id"/></xsl:attribute>
				<xsl:element name="column">
					<xsl:attribute name="name"><xsl:value-of select="column"/></xsl:attribute>
				</xsl:element>
				<xsl:element name="column">
					<xsl:attribute name="name"><xsl:value-of select="operand"/></xsl:attribute>
				</xsl:element>
			</xsl:if>
			<xsl:for-each select="*[starts-with(name(), 'label_')]">
				<xsl:variable name="selectedLanguage" select="substring-after(name(), 'label_')"/>
				<xsl:if test=". != ''">
					<xsl:element name="description">
						<xsl:attribute name="locale"><xsl:value-of select="$selectedLanguage"/></xsl:attribute>
						<xsl:value-of select="."/>
					</xsl:element>
				</xsl:if>
			</xsl:for-each>
			<xsl:if test="./column = 'action_code_derived'">
				<xsl:element name ="script">
					value = com.misys.portal.common.localization.Localization.getGTPString(language,""+row.getColumnValue("action_code")+"");
				</xsl:element>	
			</xsl:if> 
		</xsl:element>
		<xsl:if test="computed_field_id != ''">
			<xsl:element name="column">
				<xsl:attribute name="name"><xsl:value-of select="column"/></xsl:attribute>
				<xsl:attribute name="hidden">y</xsl:attribute>
			</xsl:element>
			<xsl:element name="column">
				<xsl:attribute name="name"><xsl:value-of select="operand"/></xsl:attribute>
				<xsl:attribute name="hidden">y</xsl:attribute>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	
	<!--****************-->
	<!-- Hidden columns -->
	<!--****************-->
	<xsl:template name="HIDDEN_COLUMNS">
		<xsl:for-each select="hiddenColumn">
			<xsl:if test="computed_field_id = ''">
				<xsl:element name="column">
					<xsl:attribute name="name"><xsl:value-of select="."/></xsl:attribute>
					<xsl:attribute name="hidden">y</xsl:attribute>
				</xsl:element>
			</xsl:if>
		</xsl:for-each>
		
		<!-- Add primary keys in order to be sure to select every row -->
    	<xsl:variable name="product">
    		<xsl:choose>
    			<xsl:when test="report_type = '01'">
    				<xsl:choose>
						<xsl:when test="multi_product = 'Y'"><xsl:value-of select="products/product[position() = 1]"/></xsl:when>
						<xsl:otherwise><xsl:value-of select="single_product"/></xsl:otherwise>
					</xsl:choose>
    			</xsl:when>
    			<xsl:when test="report_type = '02'">
    				<xsl:value-of select="single_product"/>
    			</xsl:when>
    			<xsl:otherwise>
    				<xsl:choose>
						<xsl:when test="multi_product = 'Y'"><xsl:value-of select="products/product[position() = 1]"/></xsl:when>
						<xsl:otherwise><xsl:value-of select="single_product"/></xsl:otherwise>
					</xsl:choose>
    			</xsl:otherwise>
    		</xsl:choose> 
		</xsl:variable>

		<!-- If the candidate(s) is(are) a transaction product(s), add the column tnx_id -->
		<xsl:if test="substring-before($product, 'Tnx') != ''">
			<xsl:if test="count(columns/column[column = 'tnx_id']) = 0">
				<xsl:element name="column">
					<xsl:attribute name="name">tnx_id</xsl:attribute>
					<xsl:attribute name="hidden">y</xsl:attribute>
				</xsl:element>
			</xsl:if>
			<xsl:if test="$product = 'BK'">
						<xsl:element name="column">
				<xsl:attribute name="name">Bulk@bk_type</xsl:attribute>
				<xsl:attribute name="hidden">y</xsl:attribute>
			</xsl:element>
			<xsl:element name="column">
				<xsl:attribute name="name">Bulk@ObjectDataString@payroll_type</xsl:attribute>
				<xsl:attribute name="hidden">y</xsl:attribute>
			</xsl:element>
			
			<xsl:element name="column">
				<xsl:attribute name="name">product_code</xsl:attribute>
				<xsl:attribute name="hidden">y</xsl:attribute>
			</xsl:element>
			</xsl:if>
		</xsl:if>
		
		<xsl:if test="order_column != ''">
			<xsl:element name="column">
					<xsl:attribute name="name"><xsl:value-of select="order_column"/></xsl:attribute>
					<xsl:attribute name="hidden">y</xsl:attribute>
			</xsl:element>
		</xsl:if>
		
		<!-- If the candidate(s) is(are) a master product(s), add the column ref_id -->
		<xsl:if test="substring-before($product, 'Tnx') = '' and $product != 'Audit'">
			<xsl:if test="count(columns/column[column = 'ref_id']) = 0">
				<xsl:element name="column">
					<xsl:attribute name="name">ref_id</xsl:attribute>
					<xsl:attribute name="hidden">y</xsl:attribute>
				</xsl:element>
			</xsl:if>
						<xsl:if test="$product = 'BK'">
			
			<xsl:element name="column">
				<xsl:attribute name="name">BulkMaster@bk_type</xsl:attribute>
				<xsl:attribute name="hidden">y</xsl:attribute>
			</xsl:element>
			<xsl:element name="column">
				<xsl:attribute name="name">BulkMaster@ObjectDataString@payroll_type</xsl:attribute>
				<xsl:attribute name="hidden">y</xsl:attribute>
			</xsl:element>
			
			<xsl:element name="column">
				<xsl:attribute name="name">product_code</xsl:attribute>
				<xsl:attribute name="hidden">y</xsl:attribute>
			</xsl:element>
			</xsl:if>
		</xsl:if>

		<!-- If a charge is involved in the report, add the column charge id -->
		<xsl:if test="count(//*[starts-with(., 'Charge')])!=0">
			<xsl:if test="count(columns/column[column = 'Charge@chrg_id']) = 0">
				<xsl:element name="column">
					<xsl:attribute name="name">Charge@chrg_id</xsl:attribute>
					<xsl:attribute name="hidden">y</xsl:attribute>
				</xsl:element>
			</xsl:if>
		</xsl:if>
		
		<!-- <xsl:if test="count(//*[starts-with(., 'LastControllerUser')])!=0">
			
			<xsl:if test="count(columns/column[column = 'LastController@validation_dttm']) = 0">
				<xsl:element name="column">
					<xsl:attribute name="name">LastController@validation_dttm</xsl:attribute>
					<xsl:attribute name="hidden">y</xsl:attribute>
				</xsl:element>
			</xsl:if>
			
		</xsl:if> -->
		
		<!-- Add any columns used in a criterium -->
		<xsl:for-each select="filters/filter">
			<xsl:for-each select="criteria/criterium">
				<xsl:if test="./column != 'ObjectDataString@recurring_payment_enabled'">
					<xsl:element name="column">
						<xsl:attribute name="name"><xsl:value-of select="./column"/></xsl:attribute>
						<xsl:attribute name="hidden">y</xsl:attribute>
					</xsl:element>
				</xsl:if>
			</xsl:for-each>
		</xsl:for-each>

		<!-- Add any column used as a group -->
		<xsl:for-each select="grouping_column">
			<xsl:if test="./column != 'ObjectDataString@recurring_payment_enabled'">
				<xsl:element name="column">
					<xsl:attribute name="name"><xsl:value-of select="."/></xsl:attribute>
					<xsl:attribute name="hidden">y</xsl:attribute>
				</xsl:element>
			</xsl:if>
		</xsl:for-each>

		<!-- Add any column used for the axis X in a chart -->
		<xsl:for-each select="chart_axis_x">
			<xsl:if test="./column != 'ObjectDataString@recurring_payment_enabled'">
				<xsl:element name="column">
					<xsl:attribute name="name"><xsl:value-of select="."/></xsl:attribute>
					<xsl:attribute name="hidden">y</xsl:attribute>
				</xsl:element>
			</xsl:if>
		</xsl:for-each>

		<!-- Add any columns used in a group aggregate -->
		<xsl:for-each select="grouping_aggregates/aggregate">
			<xsl:if test="./column != 'ObjectDataString@recurring_payment_enabled'">
				<xsl:element name="column">
					<xsl:attribute name="name"><xsl:value-of select="./column"/></xsl:attribute>
					<xsl:attribute name="hidden">y</xsl:attribute>
				</xsl:element>
			</xsl:if>
		</xsl:for-each>
		
		<!-- Add any columns used in a chart aggregate -->
		<xsl:for-each select="chart_aggregates/aggregate">
			<xsl:if test="./column != 'ObjectDataString@recurring_payment_enabled'">
				<xsl:element name="column">
					<xsl:attribute name="name"><xsl:value-of select="./column"/></xsl:attribute>
					<xsl:attribute name="hidden">y</xsl:attribute>
				</xsl:element>
			</xsl:if>	
		</xsl:for-each>

		<!-- Add any columns used in an aggregate -->
		<xsl:for-each select="aggregates/aggregate">
			<xsl:if test="./column != 'ObjectDataString@recurring_payment_enabled'">
				<xsl:element name="column">
					<xsl:attribute name="name"><xsl:value-of select="./column"/></xsl:attribute>
					<xsl:attribute name="hidden">y</xsl:attribute>
				</xsl:element>
			</xsl:if>
		</xsl:for-each>
		
		<xsl:for-each select="columns/column">
		<xsl:if test="./column != 'action_code_derived' and ./column != 'ObjectDataString@recurring_payment_enabled'">
				<xsl:if test="eqv_cur_code != ''">
					<xsl:element name="column">
						<xsl:attribute name="name"><xsl:value-of select="./column"/></xsl:attribute>
						<xsl:attribute name="cur"><xsl:value-of select="eqv_cur_code"/></xsl:attribute>
						<xsl:attribute name="altName">
							<xsl:value-of select="./column"/>
							<xsl:text>_</xsl:text>
							<xsl:value-of select="eqv_cur_code"/>
						</xsl:attribute>						
						<xsl:attribute name="hidden">y</xsl:attribute>
					</xsl:element>
				</xsl:if>
			<xsl:if test="eqv_cur_code = ''">				
				<xsl:element name="column">
					<xsl:attribute name="name"><xsl:value-of select="./column"/></xsl:attribute>
					<xsl:attribute name="cur"><xsl:value-of select="eqv_cur_code"/></xsl:attribute>
					<xsl:attribute name="hidden">y</xsl:attribute>
				</xsl:element>
			</xsl:if>
		</xsl:if>
		</xsl:for-each>

	</xsl:template>



	<!--************-->
	<!-- Parameters -->
	<!--************-->

	<xsl:template name="PARAMETERS">
		<xsl:for-each select="parameters/parameter">
			
			<xsl:variable name="parameterName" select="translate(normalize-space(parameter_name),' ','')"/>
			 <xsl:element name="parameter">
				<xsl:attribute name="input">y</xsl:attribute>
				<xsl:attribute name="name">
					<xsl:value-of select="$parameterName"/>
				</xsl:attribute>
				<xsl:if test="size != ''">
					<xsl:attribute name="size">
						<xsl:value-of select="size"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="max_length != ''">
					<xsl:attribute name="max_length">
						<xsl:value-of select="max_length"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:attribute name="mandatory">
					<xsl:choose>
						<xsl:when test="mandatory = 'Y'">true</xsl:when>
						<xsl:otherwise>false</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
				<xsl:attribute name="currency">
				<xsl:if test="count(//report/filters/filter/criteria/criterium[parameter = $parameterName and default_amount_cur_code != '']) > 0">
				<xsl:value-of select="//report/filters/filter/criteria/criterium[parameter = $parameterName]/default_amount_cur_code"/>
				</xsl:if>
				</xsl:attribute>
				<xsl:attribute name="type">
				<xsl:if test="count(//report/filters/filter/criteria/criterium[parameter = $parameterName and column_type != '']) > 0">
				<xsl:value-of select="//report/filters/filter/criteria/criterium[parameter = $parameterName]/column_type"/>
				</xsl:if>
				</xsl:attribute>
				
				<!-- Defaut values -->
				<xsl:choose>
					<xsl:when test="count(//report/filters/filter/criteria/criterium[parameter = $parameterName and default_string_value != '']) > 0">
						<xsl:attribute name="default">
							<xsl:value-of select="//report/filters/filter/criteria/criterium[parameter = $parameterName]/default_string_value"/>
						</xsl:attribute>
					</xsl:when>
					<xsl:when test="count(//report/filters/filter/criteria/criterium[parameter = $parameterName and default_number_value != '']) > 0">
						<xsl:attribute name="default">
							<xsl:value-of select="//report/filters/filter/criteria/criterium[parameter = $parameterName]/default_number_value"/>
						</xsl:attribute>
					</xsl:when>
					<xsl:when test="count(//report/filters/filter/criteria/criterium[parameter = $parameterName and default_amount_value != '']) > 0">
						<xsl:attribute name="default">
							<xsl:value-of select="//report/filters/filter/criteria/criterium[parameter = $parameterName]/default_amount_value"/>
						</xsl:attribute>
					</xsl:when>
					<xsl:when test="count(//report/filters/filter/criteria/criterium[parameter = $parameterName and default_date_value != '']) > 0">
						<xsl:attribute name="default">
							<xsl:value-of select="//report/filters/filter/criteria/criterium[parameter = $parameterName]/default_date_value"/>
						</xsl:attribute>
					</xsl:when>
					<xsl:when test="count(//report/filters/filter/criteria/criterium[parameter = $parameterName and default_values_set != '']) > 0">
						<xsl:attribute name="default">
							<xsl:value-of select="//report/filters/filter/criteria/criterium[parameter = $parameterName]/default_values_set"/>
						</xsl:attribute>
					</xsl:when>
				</xsl:choose>

				<xsl:for-each select="*[starts-with(name(), 'label_')]">
					<xsl:variable name="selectedLanguage" select="substring-after(name(), 'label_')"/>
					<xsl:if test=". != ''">
						<xsl:element name="description">
							<xsl:attribute name="locale"><xsl:value-of select="$selectedLanguage"/></xsl:attribute>
							<xsl:value-of select="."/>
						</xsl:element>
					</xsl:if>
				</xsl:for-each>
								
			</xsl:element>
		</xsl:for-each>	

		<!-- Parameters auto-generated (for pre-defined values) -->
		<xsl:if test="count(//report/filters/filter/criteria/criterium[default_date_type != '']) > 0">
			
			<xsl:for-each select="//report/filters/filter/criteria/criterium[default_date_type != '']">
				<xsl:variable name="selectedCriterium" select="."/>
				
				<xsl:element name="parameter">
					<xsl:attribute name="input">n</xsl:attribute>
					<xsl:attribute name="autogenerated">y</xsl:attribute>
					<xsl:attribute name="mandatory">false</xsl:attribute>
					<xsl:attribute name="name">
						<xsl:call-template name="AUTO_GENERATE_PARAMETER_NAME">
							<xsl:with-param name="criterium" select="$selectedCriterium"/>
						</xsl:call-template>
					</xsl:attribute>
				
					<xsl:choose>
						<xsl:when test="$selectedCriterium/default_date_type = '01'">
							<xsl:element name="default">
								<xsl:element name="execution_date">
									<xsl:if test="$selectedCriterium/default_date_report_exec_date_offset_days[. != '' or . != '0']">
										<xsl:attribute name="day_offset">
											<xsl:if test="$selectedCriterium/default_date_report_exec_date_offset = '02'">-</xsl:if><xsl:value-of select="$selectedCriterium/default_date_report_exec_date_offset_days"/>
										</xsl:attribute>
									</xsl:if>
								</xsl:element>
							</xsl:element>
						</xsl:when>
						<xsl:when test="$selectedCriterium/default_date_type = '02'">
							<xsl:element name="default">
								<xsl:element name="first_day">
									<xsl:if test="$selectedCriterium/default_date_first_day_of_month_offset_days[. != '' or . != '0']">
										<xsl:attribute name="day_offset">
											<xsl:if test="$selectedCriterium/default_date_first_day_of_month_offset = '02'">-</xsl:if><xsl:value-of select="$selectedCriterium/default_date_first_day_of_month_offset_days"/>
										</xsl:attribute>
										<xsl:attribute name="period">month</xsl:attribute>
									</xsl:if>
								</xsl:element>
							</xsl:element>
						</xsl:when>
						<xsl:when test="$selectedCriterium/default_date_type = '03'">
							<xsl:element name="default">
								<xsl:element name="last_day">
									<xsl:if test="$selectedCriterium/default_date_last_day_of_month_offset_days[. != '' or . != '0']">
										<xsl:attribute name="day_offset">
											<xsl:if test="$selectedCriterium/default_date_last_day_of_month_offset = '02'">-</xsl:if><xsl:value-of select="$selectedCriterium/default_date_last_day_of_month_offset_days"/>
										</xsl:attribute>
										<xsl:attribute name="period">month</xsl:attribute>
									</xsl:if>
								</xsl:element>
							</xsl:element>
						</xsl:when>
						<xsl:when test="$selectedCriterium/default_date_type = '04'">
							<xsl:element name="default">
								<xsl:element name="today"/>
							</xsl:element>
						</xsl:when>
						<xsl:when test="$selectedCriterium/default_date_type = '05'">
							<xsl:element name="default">
								<xsl:element name="tomorrow"/>
							</xsl:element>
						</xsl:when>
						<xsl:when test="$selectedCriterium/default_date_type = '06'">
							<xsl:element name="default">
								<xsl:element name="yesterday"/>
							</xsl:element>
						</xsl:when>
	
						<!-- <xsl:when test="$selectedCriterium/default_date_type = '07'">
							<xsl:element name="default">
								<xsl:attribute name="type">07</xsl:attribute>
								<xsl:value-of select="$selectedCriterium/default_date_value"/>
							</xsl:element>
						</xsl:when>
						<xsl:otherwise>
							<xsl:element name="default">
								<xsl:attribute name="type"><xsl:value-of select="$selectedCriterium/default_date_type"/></xsl:attribute>
							</xsl:element>
						</xsl:otherwise>-->
					</xsl:choose>
				
				</xsl:element>
			</xsl:for-each>
			
		</xsl:if>


	</xsl:template>

	<!-- Auto generate parameter name based on criterium details -->
	<xsl:template name="AUTO_GENERATE_PARAMETER_NAME">
		<xsl:param name="criterium"/>
		
		<xsl:value-of select="$criterium/column"/>_<xsl:value-of select="$criterium/operator"/>_<xsl:choose>
			<xsl:when test="$criterium/default_date_type = '01'">
				<xsl:value-of select="$criterium/default_date_type"/>_<xsl:value-of select="$criterium/default_date_report_exec_date_offset"/>_<xsl:value-of select="$criterium/default_date_report_exec_date_offset_days"/>
			</xsl:when>
			<xsl:when test="$criterium/default_date_type = '02'">
				<xsl:value-of select="$criterium/default_date_type"/>_<xsl:value-of select="$criterium/default_date_first_day_of_month_offset"/>_<xsl:value-of select="$criterium/default_date_first_day_of_month_offset_days"/>
			</xsl:when>
			<xsl:when test="$criterium/default_date_type = '03'">
				<xsl:value-of select="$criterium/default_date_type"/>_<xsl:value-of select="$criterium/default_date_last_day_of_month_offset"/>_<xsl:value-of select="$criterium/default_date_last_day_of_month_offset_days"/>
			</xsl:when>
			<xsl:when test="$criterium/default_date_type = '04' or  $criterium/default_date_type = '05' or $criterium/default_date_type = '06'">
				<xsl:value-of select="$criterium/default_date_type"/>
			</xsl:when>
		</xsl:choose>

	</xsl:template>

	<!--*******************-->
	<!-- Filters/Criterias -->
	<!--*******************-->

	<xsl:template name="FILTERS">
		<xsl:choose>
			<xsl:when test="report_type = '01'">
				<xsl:choose>
				<xsl:when test="multi_product = 'Y'">
					<xsl:for-each select="products/product/product">
						<xsl:call-template name="FILTERS_CANDIDATE">
							<xsl:with-param name="product" select="."/>
						</xsl:call-template>
					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="FILTERS_CANDIDATE">
						<xsl:with-param name="product" select="single_product"/>
					</xsl:call-template>
				</xsl:otherwise>
		    </xsl:choose>
			</xsl:when>
			<xsl:when test="report_type = '02'">
				<xsl:call-template name="FILTERS_CANDIDATE">
						<xsl:with-param name="product" select="system_product"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="multi_product = 'Y'">
						<xsl:for-each select="products/product/product">
							<xsl:call-template name="FILTERS_CANDIDATE">
								<xsl:with-param name="product" select="."/>
							</xsl:call-template>
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="FILTERS_CANDIDATE">
							<xsl:with-param name="product" select="single_product"/>
						</xsl:call-template>
					</xsl:otherwise>
		    	</xsl:choose>		
			</xsl:otherwise>
		</xsl:choose>		
	</xsl:template>

	<xsl:template name="FILTERS_CANDIDATE">
		<xsl:param name="product"/>
		<!-- MPS-22873 : Modifying the product code appropriately(eg FTTnx -> FT, SETnx ->SE)-->
		<xsl:element name="candidate">
			<xsl:attribute name="name">
				<xsl:choose><xsl:when test="substring-before($product, 'Y') != ''"><xsl:value-of select="substring-before($product, 'Y')"/></xsl:when><xsl:otherwise><xsl:value-of select="$product"/></xsl:otherwise></xsl:choose>
			</xsl:attribute>
		
			<xsl:choose>
				<xsl:when test="count(//report/filters/filter) != 0">
					<xsl:for-each select="//report/filters/filter">
						<xsl:element name="filter">
							<xsl:for-each select="criteria/criterium">
								<xsl:element name="criteria">
									<xsl:element name="column">
										<xsl:attribute name="name"><xsl:value-of select="column"/></xsl:attribute>
										<xsl:attribute name="type">
										<xsl:value-of select="column_type"/>
									</xsl:attribute>
									</xsl:element>
									
									<xsl:element name="operator">
										<xsl:attribute name="type"><xsl:value-of select="operator"/></xsl:attribute>
									</xsl:element>
									<xsl:if test="operator != 'isNull' and operator != 'isNotNull'">
										<xsl:variable name="valueType">
											<xsl:choose>
												<xsl:when test="parameter != '' or default_date_type != ''">parameter</xsl:when>
												<xsl:otherwise>string</xsl:otherwise>
											</xsl:choose>
										</xsl:variable>	
										<xsl:element name="value">
										 	<xsl:attribute name="type"><xsl:value-of select="$valueType"/></xsl:attribute>
										 	<xsl:choose>
										 		<xsl:when test="$valueType = 'parameter'">
										 			<xsl:choose>
										 				<xsl:when test="parameter != ''">
										 					<xsl:value-of select="translate(normalize-space(parameter),' ','')"/>
										 				</xsl:when>
										 				<xsl:when test="default_date_type != ''">
										 					<xsl:call-template name="AUTO_GENERATE_PARAMETER_NAME">
																<xsl:with-param name="criterium" select="."/>
															</xsl:call-template>
										 				</xsl:when>
										 			</xsl:choose>
										 		</xsl:when>
										 		<xsl:when test="$valueType = 'string'">
										 			<xsl:choose>
										 				<xsl:when test="string_value != ''">
										 					<xsl:value-of select="string_value"/>
										 				</xsl:when>
										 				<xsl:when test="number_value != ''">
										 					<xsl:value-of select="number_value"/>
										 				</xsl:when>
										 				<xsl:when test="amount_value != ''">
										 					<xsl:value-of select="concat(converttools:stringAmountToBigDecimal(amount_value, $language), '@', amount_cur_code)"/>
										 				</xsl:when>
										 				<xsl:when test="date_value != ''">
										 					<xsl:value-of select="converttools:getDefaultTimestampRepresentation(date_value, $language)"/>
										 				</xsl:when>
										 				<xsl:when test="values_set != ''">
										 					<xsl:value-of select="values_set"/>
										 				</xsl:when>
										 			</xsl:choose>
										 		</xsl:when>
										 	</xsl:choose>
										</xsl:element>
									</xsl:if>
								</xsl:element>
							</xsl:for-each>
							
							<!-- If the product is of type transaction, add a criterion to each filter	-->
							<!-- in order to add a constraint on the transaction status code			-->
							<!-- that currently can only be equal to ACKNOWLEDGED						-->
							<xsl:if test="security:isBank($rundata)">
								<xsl:if test="count(criteria/criterium[column='tnx_stat_code']) = 0">
									<xsl:call-template name="ACKNOWLEDGED_TRANSACTION_CRITERION"/>
								</xsl:if>
							</xsl:if>
						</xsl:element>
					</xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="ACKNOWLEDGED_TRANSACTION_CRITERION"/>
				</xsl:otherwise>
			</xsl:choose>

		</xsl:element>
	
	</xsl:template>

			
	<!--********************-->
	<!-- Overall Aggregates -->
	<!--********************-->

	<xsl:template name="OVERALL_AGGREGATES">
		
		<xsl:apply-templates select="aggregates/aggregate"/>
	
	</xsl:template>
			
	<xsl:template match="aggregate">
			<xsl:element name="aggregate">
				<xsl:attribute name="type"><xsl:value-of select="type"/></xsl:attribute>
				<xsl:if test="eqv_cur_code != ''">
					<xsl:attribute name="cur"><xsl:value-of select="eqv_cur_code"/></xsl:attribute>
				</xsl:if>
				
				<xsl:element name="column">
					<xsl:attribute name="name"><xsl:value-of select="column"/></xsl:attribute>
				</xsl:element>
				
				<xsl:for-each select="*[starts-with(name(), 'label_')]">
					<xsl:variable name="selectedLanguage" select="substring-after(name(), 'label_')"/>
					<xsl:if test=". != ''">
						<xsl:element name="description">
							<xsl:attribute name="locale"><xsl:value-of select="$selectedLanguage"/></xsl:attribute>
							<xsl:value-of select="."/>
						</xsl:element>
					</xsl:if>
				</xsl:for-each>
			</xsl:element>
	</xsl:template>

	<!--**********-->
	<!-- Grouping -->
	<!--**********-->

	<xsl:template name="GROUPING">
		<xsl:if test="grouping_enable = 'Y'">
			<xsl:element name="group">
				<xsl:if test="grouping_display_records = 'Y'">
					<xsl:attribute name="details">Y</xsl:attribute>
				</xsl:if>
				<xsl:element name="column">
					<xsl:attribute name="name">
						<xsl:value-of select="grouping_column"/>
					</xsl:attribute>
					<xsl:if test="grouping_column_scale != ''">
						<xsl:attribute name="hierarchy">
							<xsl:value-of select="grouping_column_scale"/>
						</xsl:attribute>
					</xsl:if>
				</xsl:element>
				
				<xsl:apply-templates select="grouping_aggregates/aggregate"/>
				
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<!--*******-->
	<!-- Chart -->
	<!--*******-->

	<xsl:template name="CHART">
		
		<xsl:element name="group">
			<xsl:attribute name="graph">
				<xsl:value-of select="chart_rendering"/>
			</xsl:attribute>

			<xsl:element name="column">
				<xsl:attribute name="name">
					<xsl:value-of select="chart_axis_x"/>
				</xsl:attribute>
				<xsl:attribute name="hierarchy">
					<xsl:value-of select="chart_axis_x_scale"/>
				</xsl:attribute>
			</xsl:element>

			<xsl:apply-templates select="chart_aggregates/aggregate"/>

		</xsl:element>
		
	</xsl:template>
	
	<!--*************************************-->
	<!-- Acknowledged transactions criterion -->
	<!--*************************************-->
	<xsl:template name="ACKNOWLEDGED_TRANSACTION_CRITERION">
    
    	<xsl:variable name="product"><xsl:choose>
			<xsl:when test="multi_product = 'Y'"><xsl:value-of select="products/product[position() = 1]"/></xsl:when>
			<xsl:otherwise><xsl:value-of select="single_product"/></xsl:otherwise>
		</xsl:choose></xsl:variable>

		<!-- If the candidate(s) is(are) a transaction product(s), add a criterium stating a transaction status code as Acknowledged -->
		<xsl:if test="substring-before($product, 'Tnx') != ''">
			<xsl:element name="criteria">
				<xsl:element name="column">
					<xsl:attribute name="name">tnx_stat_code</xsl:attribute>
					<xsl:attribute name="type">ValuesSet</xsl:attribute>
				</xsl:element>
				<xsl:element name="operator">
					<xsl:attribute name="type">like</xsl:attribute>
				</xsl:element>
				<xsl:element name="value">
					<xsl:attribute name="type">string</xsl:attribute>
					<xsl:text>04</xsl:text>
				</xsl:element>
			</xsl:element>
		</xsl:if>

	</xsl:template>


	<!--***************-->
	<!-- Product codes -->
	<!--***************-->

	<xsl:template name="PRODUCT_CODES">
		<!-- MPS-22873 : Modifying the product code appropriately(eg FTTnx -> FT, SETnx ->SE)-->
		<xsl:choose>
		<xsl:when test="report_type = '01'">
			<xsl:choose>
					<xsl:when test="multi_product = 'Y'"><xsl:for-each select="products/product"><xsl:choose><xsl:when test="substring-before(product, 'Tnx') != ''"><xsl:value-of select="substring-before(product, 'Tnx')"/>,</xsl:when><xsl:otherwise><xsl:value-of select="product"/>,</xsl:otherwise></xsl:choose></xsl:for-each></xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="substring-before(single_product, 'Tnx') != ''"><xsl:value-of select="substring-before(single_product, 'Tnx')"/></xsl:when>
							<xsl:otherwise><xsl:value-of select="single_product"/></xsl:otherwise>
						</xsl:choose>
						
					</xsl:otherwise>
			    </xsl:choose>
		</xsl:when>
		<xsl:when test="report_type = '02'">
			<xsl:choose>
					<xsl:when test="substring-before(system_product, 'Tnx') != ''"><xsl:value-of select="substring-before(system_product, 'Tnx')"/></xsl:when>
					<xsl:otherwise><xsl:value-of select="system_product"/></xsl:otherwise>
				</xsl:choose>
		</xsl:when>
		<xsl:otherwise>
			<xsl:choose>
					<xsl:when test="multi_product = 'Y'"><xsl:for-each select="products/product"><xsl:choose><xsl:when test="substring-before(product, 'Tnx') != ''"><xsl:value-of select="substring-before(product, 'Tnx')"/>,</xsl:when><xsl:otherwise><xsl:value-of select="product"/>,</xsl:otherwise></xsl:choose></xsl:for-each></xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="substring-before(single_product, 'Tnx') != ''"><xsl:value-of select="substring-before(single_product, 'Tnx')"/></xsl:when>
							<xsl:otherwise><xsl:value-of select="single_product"/></xsl:otherwise>
						</xsl:choose>
						
					</xsl:otherwise>
			    </xsl:choose>
		</xsl:otherwise>
		</xsl:choose>
	    
	</xsl:template>

</xsl:stylesheet>
