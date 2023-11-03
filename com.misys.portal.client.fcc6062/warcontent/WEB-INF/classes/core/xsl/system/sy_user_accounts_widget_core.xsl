<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
User Accounts Assignment

version:   1.0
date:      30/07/2011
author:    Gurudath Reddy
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
    xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider"
    xmlns:utils="xalan://com.misys.portal.common.tools.Utils"
    exclude-result-prefixes="localization defaultresource">
    
	<xsl:param name="images_path"><xsl:value-of select="$contextPath"/>/content/images/</xsl:param>
	<xsl:param name="actionDownImage"><xsl:value-of select="$images_path"/>action-down.png</xsl:param>
	<xsl:param name="actionUpImage"><xsl:value-of select="$images_path"/>action-up.png</xsl:param>
	
	<xsl:template name="user-accounts-component">
		<xsl:call-template name="fieldset-wrapper">
			<xsl:with-param name="legend">XSL_HEADER_USER_ACCOUNTS</xsl:with-param>
			<xsl:with-param name="content">
				<div class="widgetContainer userAccounts">
					<xsl:variable name="entityCount">
						<xsl:value-of select="count(user_entity_accounts_record)"/>
					</xsl:variable>

					<script>
					dojo.ready(function(){
						misys._config = misys._config || {};
						misys._config.userAccounts = {};
						dojo.mixin(misys._config.userAccounts,{  
								user_entity_accounts_record_count : <xsl:value-of select="$entityCount"/>,
								entityAccountArray : new Array(),     

								entityIdArray : [
						<xsl:for-each select="user_entity_accounts_record">
							<xsl:value-of select="entity_id"/>
							<xsl:if test="position()!=last()">,</xsl:if>
						</xsl:for-each>
								],
								accountOwnerType : new Array(),
								accountType : new Array()

						});
						<xsl:for-each select="user_entity_accounts_record">
							<xsl:variable name="entity_record" select="."/>
							<xsl:if test="count($entity_record/account_record) > 0">
								misys._config.userAccounts.entityAccountArray[<xsl:value-of select="entity_id"/>] = [
								<xsl:for-each select="$entity_record/account_record">
									<xsl:value-of select="account_id"/>
									<xsl:if test="position()!=last()">,</xsl:if>
								</xsl:for-each>
								]
							</xsl:if>
						</xsl:for-each>

						<xsl:for-each select="user_entity_accounts_record">
							<xsl:variable name="entity_record" select="."/>
							<xsl:if test="count($entity_record/account_record) > 0">
								<xsl:for-each select="account_record">
								misys._config.userAccounts.accountOwnerType[<xsl:value-of select="account_id"/>] = [							
									<xsl:value-of select="account_owner_type"/>								
								]
								</xsl:for-each>
							</xsl:if>
						</xsl:for-each>
						<xsl:for-each select="user_entity_accounts_record">
							<xsl:variable name="entity_record" select="."/>
							<xsl:if test="count($entity_record/account_record) > 0">
								<xsl:for-each select="account_record">
								misys._config.userAccounts.accountType[<xsl:value-of select="account_id"/>] = [							
									<xsl:value-of select="acc_type"/>								
								]
								</xsl:for-each>
							</xsl:if>
						</xsl:for-each>
					});
					</script>

					<!-- Check if Entities are assigned to the user -->
					<xsl:choose>
						<xsl:when test="count(user_entity_accounts_record) > 0">
							<xsl:call-template name="entity_accounts_table"/>
						</xsl:when>
						<xsl:otherwise>
							<div>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_NO_ENITIES_USER_ACCOUNTS')"/>
							</div>		
						</xsl:otherwise>
					</xsl:choose>
				</div>
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>
	<xsl:template name="entity_accounts_table">
		<xsl:variable name="nonPabAllowed">
			<xsl:value-of select="defaultresource:getResource('NON_PAB_ALLOWED')"/>
		</xsl:variable>
		<xsl:for-each select="user_entity_accounts_record">
			<xsl:variable name="user_entity_accounts_record" select="."/>
			<xsl:variable name="user_entity_position" select="position()" />
			<xsl:variable name="entity_id" select="$user_entity_accounts_record/entity_id" />

			<!-- Containers for each Entities Accounts Table -->
			<xsl:choose>
				<xsl:when test="$user_entity_accounts_record/entity_flag[.!='N']">
					<xsl:call-template name="animatedFieldSetHeader">
						<xsl:with-param name="label">
							<xsl:value-of select="$user_entity_accounts_record/entity_name"/>
						</xsl:with-param>
						<xsl:with-param name="animateDivId">entity_accounts_table_<xsl:value-of select="$entity_id"/>
						</xsl:with-param>
						<xsl:with-param name="prefix">entity_accounts_<xsl:value-of select="$entity_id"/>
						</xsl:with-param>
						<xsl:with-param name="show">
							<xsl:choose>
								<xsl:when test="$displaymode='edit'">N</xsl:when>
								<xsl:otherwise>Y</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</xsl:when>
			</xsl:choose>

			<div>
				<xsl:attribute name="id">entity_accounts_table_<xsl:value-of select="$entity_id"/>
				</xsl:attribute>
				<xsl:attribute name="style">
					<xsl:choose>
						<xsl:when test="$displaymode ='edit' and $user_entity_accounts_record/entity_flag[.='Y']">
						     	display:none;width:100%;padding-left:5px;
						</xsl:when>
						<xsl:otherwise>
						          width:100%;padding-left:5px;
						</xsl:otherwise>
					</xsl:choose>
				</xsl:attribute>
				<xsl:choose>
					<xsl:when test="count($user_entity_accounts_record/account_record) > 0">
						<div id="userAccountsTableHeaderContainer" style="width:100%;">
							<div class="userAccountsTableCell userAccountsTableCellHeader  userAccountsHeaderSelector">
								<xsl:choose>
									<xsl:when test="$displaymode='edit'">
										<xsl:call-template name="column-check-box">
											<xsl:with-param name="id">account_select_all_<xsl:value-of select="$entity_id"/>
											</xsl:with-param>
										</xsl:call-template>
									</xsl:when>
									<xsl:otherwise>
										<p class="hide">auto</p>
									</xsl:otherwise>
								</xsl:choose>
							</div>
							<xsl:choose>
								<xsl:when test="../static_user/static_company/owner_is_group[.!=''] and ../static_user/static_company/owner_is_group[.='Y']">
									<div class="userAccountsTableCell userAccountsTableCellHeader  width15per">
										<xsl:value-of select="localization:getGTPString($language, 'BANK_ABBV_NAME')"/>
									</div>
									<div class="userAccountsTableCell userAccountsTableCellHeader  userAccountColumnCell" >
										<xsl:attribute name="style">
											<xsl:choose>
												<xsl:when test="$nonPabAllowed = 'false'">width:50%;</xsl:when>
												<xsl:otherwise>width:34%;</xsl:otherwise>
											</xsl:choose>
										</xsl:attribute>
										<xsl:value-of select="localization:getGTPString($language, 'XSL_TABLE_HEADER_ACCOUNT')"/>
									</div>
								</xsl:when>
								<xsl:otherwise>
									<div class="userAccountsTableCell userAccountsTableCellHeader  userAccountColumnCell" >
										<xsl:attribute name="style">
											<xsl:choose>
												<xsl:when test="$nonPabAllowed = 'false'">width:65%;</xsl:when>
												<xsl:otherwise>width:49%;</xsl:otherwise>
											</xsl:choose>
										</xsl:attribute>
										<xsl:value-of select="localization:getGTPString($language, 'XSL_TABLE_HEADER_ACCOUNT')"/>
									</div>
								</xsl:otherwise>
							</xsl:choose>
							<div class="userAccountsTableCell userAccountsTableCellHeader  width15per">
								<!-- Hide PAB column if non-PAB accounts are not allowed -->
								<xsl:if test="$nonPabAllowed = 'false'">
									<xsl:attribute name="style">display:none;</xsl:attribute>
								</xsl:if>
								<xsl:value-of select="localization:getGTPString($language, 'XSL_TABLE_HEADER_PAB')"/>
							</div>
							<div class="userAccountsTableCell userAccountsTableCellHeader  width15per">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_TABLE_HEADER_VIEW_STMT')"/>
							</div>
							<div class="userAccountsTableCell userAccountsTableCellHeader  width15per">
								<xsl:value-of select="localization:getGTPString($language, 'XSL_TABLE_HEADER_ACCOUNT_PRODUCTS')"/>
							</div>
						</div>
						
						<xsl:for-each select="$user_entity_accounts_record/account_record">
							<xsl:variable name="account_record" select="."/>
							<xsl:variable name="account_position" select="position()" />
							<xsl:variable name="account_id" select="$account_record/account_id" />
							<xsl:choose>
								<xsl:when test = "$displaymode != 'edit'">
									<xsl:choose>
										<xsl:when test = "($account_record/account_enabled[.='Y'])">
											<div style="width:100%;">
												<div class="userAccountsTableCell userAccountsTableCellOdd alignCenterWithPadding userAccountsHeaderSelector">
													<xsl:call-template name="column-check-box">
														<xsl:with-param name="id">account_enabled_<xsl:value-of select="$entity_id"/>_<xsl:value-of select="$account_id"/>
														</xsl:with-param>
														<xsl:with-param name="checked">
															<xsl:value-of select="$account_record/account_enabled"/>
														</xsl:with-param>
													</xsl:call-template>
												</div>
												<xsl:choose>
													<xsl:when test="../../static_user/static_company/owner_is_group[.!=''] and ../../static_user/static_company/owner_is_group[.='Y']">
														<div class="userAccountsTableCell userAccountsTableCellOdd alignLeftWithPadding width15per">
															<xsl:value-of select="$account_record/account_owner_bank"/>
														</div>
														<div class="userAccountsTableCell userAccountsTableCellOdd alignLeftWithPadding">
															<xsl:attribute name="style">
																<xsl:choose>
																	<xsl:when test="$nonPabAllowed = 'false'">width:50%;</xsl:when>
																	<xsl:otherwise>width:34%;</xsl:otherwise>
																</xsl:choose>
															</xsl:attribute>										
															<xsl:choose>
																<xsl:when test="$account_record/account_owner_type = '05'">
																	<xsl:value-of select="$account_record/acct_name"/>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:value-of select="$account_record/account_cur_code"/>&nbsp;
																	<xsl:value-of select="$account_record/account_no"/>&nbsp;
																	<xsl:value-of select="$account_record/account_type"/>
																</xsl:otherwise>
															</xsl:choose>

														</div>
													</xsl:when>
													<xsl:otherwise>
														<div class="userAccountsTableCell userAccountsTableCellOdd alignLeftWithPadding">
															<xsl:attribute name="style">
																<xsl:choose>
																	<xsl:when test="$nonPabAllowed = 'false'">width:65%;</xsl:when>
																	<xsl:otherwise>width:49%;</xsl:otherwise>
																</xsl:choose>
															</xsl:attribute>										
															<xsl:choose>
																<xsl:when test="$account_record/account_owner_type = '05'">
																	<xsl:value-of select="$account_record/acct_name"/>
																</xsl:when>
																<xsl:otherwise>
																	<xsl:value-of select="$account_record/account_cur_code"/>&nbsp;
																	<xsl:value-of select="$account_record/account_no"/>&nbsp;
																	<xsl:value-of select="$account_record/account_type"/>
																</xsl:otherwise>
															</xsl:choose>

														</div>
													</xsl:otherwise>
												</xsl:choose>
												<div class="userAccountsTableCell userAccountsTableCellOdd alignCenterWithPadding width15per">
													<!-- Hide PAB column if non-PAB accounts are not allowed -->
													<xsl:if test="$nonPabAllowed = 'false'">
														<xsl:attribute name="style">display:none;</xsl:attribute>
													</xsl:if>
													<xsl:call-template name="column-check-box">
														<xsl:with-param name="id">account_pab_enabled_<xsl:value-of select="$entity_id"/>_<xsl:value-of select="$account_id"/>
														</xsl:with-param>
														<xsl:with-param name="checked">
															<xsl:value-of select="$account_record/pab_enabled"/>
														</xsl:with-param>
													</xsl:call-template>
												</div>	
												<div class="userAccountsTableCell userAccountsTableCellOdd alignCenterWithPadding width15per">
													<xsl:call-template name="column-check-box">
														<xsl:with-param name="id">account_view_stmt_enabled_<xsl:value-of select="$entity_id"/>_<xsl:value-of select="$account_id"/>
														</xsl:with-param>
														<xsl:with-param name="checked">
															<xsl:value-of select="$account_record/view_stat_enabled"/>
														</xsl:with-param>
													</xsl:call-template>
												</div>
												<div class="userAccountsTableCell userAccountsTableCellOdd alignCenterWithPadding width15per">
													<xsl:choose>
														<xsl:when test="$displaymode = 'edit' or ($displaymode != 'edit' and (count(existing_products/product) != 0)) ">
															<span style="vertical-align:top;" >
																<xsl:attribute name="id">account_products_indicator_<xsl:value-of select="$entity_id"/>_<xsl:value-of select="$account_id"/>
																</xsl:attribute>
																<xsl:if test="$displaymode='view'">	
																	<xsl:value-of select="count(existing_products/product)"/>&nbsp;<xsl:value-of select="localization:getGTPString($language, 'XSL_USER_ACCOUNTS_PRODUCT_COUNT')"/>
																</xsl:if>
															</span>
															<span>
																<xsl:attribute name="style">
																	<xsl:choose>
																		<xsl:when test="($displaymode !='edit') and ($account_record/account_enabled[.='Y']) and (count($account_record/existing_products/product) > 0)">
																		     	 display:none;cursor:pointer;vertical-align:middle;
																		</xsl:when>
																		<xsl:otherwise>
																		          cursor:pointer;vertical-align:middle;
																		</xsl:otherwise>
																	</xsl:choose>
																</xsl:attribute>
																<xsl:attribute name="id">account_products_down_<xsl:value-of select="$entity_id"/>_<xsl:value-of select="$account_id"/>
																</xsl:attribute>
																<a>
																	<xsl:attribute name="onClick">misys.toggleDisplayProducts('<xsl:value-of select="$entity_id"/>_<xsl:value-of select="$account_id"/>','down');</xsl:attribute>
																	<img>
																		<xsl:attribute name="src">
																			<xsl:value-of select="utils:getImagePath($actionDownImage)"/></xsl:attribute>
																		<xsl:attribute name="alt">
																			<xsl:value-of select="localization:getGTPString($language, 'OPEN_PRODUCTS_ASSIGNMENT')"/>
																		</xsl:attribute>
																	</img>
																</a>
															</span>
															<span>
																<xsl:attribute name="style">
																	<xsl:choose>
																		<xsl:when test="($displaymode !='edit') and ($account_record/account_enabled[.='Y']) and (count($account_record/existing_products/product) > 0)">
																		     	cursor:pointer;vertical-align:middle;
																		</xsl:when>
																		<xsl:otherwise>
																		          display:none;cursor:pointer;vertical-align:middle;
																		</xsl:otherwise>
																	</xsl:choose>
																</xsl:attribute>
																<xsl:attribute name="id">account_products_up_<xsl:value-of select="$entity_id"/>_<xsl:value-of select="$account_id"/>
																</xsl:attribute>
																<a>
																	<xsl:attribute name="onClick">misys.toggleDisplayProducts('<xsl:value-of select="$entity_id"/>_<xsl:value-of select="$account_id"/>','up');</xsl:attribute>
																	<img>
																		<xsl:attribute name="src">
																			<xsl:value-of select="utils:getImagePath($actionUpImage)"/></xsl:attribute>
																		<xsl:attribute name="alt">
																			<xsl:value-of select="localization:getGTPString($language, 'CLOSE_PRODUCTS_ASSIGNMENT')"/>
																		</xsl:attribute>
																	</img>
																</a>
															</span>
														</xsl:when>
														<xsl:otherwise>
															<span>
																<xsl:value-of select="localization:getGTPString($language, 'XSL_NO_PRODUCTS')"/>
															</span>	
														</xsl:otherwise>
													</xsl:choose>
												</div>
											</div>
											<div class="userEntityTableMergedCellContainer">
												<xsl:attribute name="id">account_products_div_<xsl:value-of select="$entity_id"/>_<xsl:value-of select="$account_id"/>
												</xsl:attribute>
												<xsl:attribute name="style">
													<xsl:choose>
														<xsl:when test="($displaymode !='edit') and ($account_record/account_enabled[.='Y']) and (count($account_record/existing_products/product) > 0)">
															<xsl:choose>
																<xsl:when test="$nonPabAllowed = 'false'">width:82.7%;</xsl:when>
																<xsl:otherwise>width:98%;</xsl:otherwise>
															</xsl:choose>
														</xsl:when>
														<xsl:otherwise>
															<xsl:choose>
																<xsl:when test="$nonPabAllowed = 'false'">display:none;width:82.7%;</xsl:when>
																<xsl:otherwise>display:none;width:98%;</xsl:otherwise>
															</xsl:choose>
														</xsl:otherwise>
													</xsl:choose>
												</xsl:attribute>
												<xsl:variable name="displayModeClass">user_account_<xsl:value-of select="$displaymode"/>
												</xsl:variable>
												<div>
													<xsl:attribute name="class">
														<xsl:value-of select="$displayModeClass"/>
													</xsl:attribute>
													<div class="userAccountsMergedCell">
														<xsl:if test="$displaymode = 'edit'">
															<div class="inlineBlock userAccountsMultiSelect">
																<xsl:call-template name="select-field">
																	<xsl:with-param name="label"/>
																	<xsl:with-param name="id">account_products_avail_nosend_<xsl:value-of select="$entity_id"/>_<xsl:value-of select="$account_id"/>
																	</xsl:with-param>
																	<xsl:with-param name="name"/>
																	<xsl:with-param name="type">multiple</xsl:with-param>
																	<xsl:with-param name="size">10</xsl:with-param>
																	<xsl:with-param name="options">
																		<xsl:choose>
																			<xsl:when test="$displaymode='edit'">
																				<xsl:apply-templates select="avail_products/product" mode="input"/>
																			</xsl:when>
																			<xsl:otherwise>
																				<ul class="multi-select">
																					<xsl:apply-templates select="avail_products/product" mode="input"/>
																				</ul>
																			</xsl:otherwise>
																		</xsl:choose>
																	</xsl:with-param>
																</xsl:call-template>
															</div>
															<div id="add-remove-buttons" class="multiselect-buttons inlineBlock" style="text-align:center;">
																<div>
																	<div>
																		<button dojoType="dijit.form.Button" type="button">
																			<xsl:attribute name="id">add_<xsl:value-of select="$entity_id"/>
																				<xsl:value-of select="$account_id"/>
																			</xsl:attribute>
																			<xsl:attribute name="onClick">misys.addProductMultiSelectItems('<xsl:value-of select="$entity_id"/>_<xsl:value-of select="$account_id"/>',true);</xsl:attribute>

																			<xsl:if test="$language = 'ar'">
																				<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_ADD')" />&#8592;&nbsp;
																			</xsl:if>
																			<xsl:if test="$language != 'ar'">
																				<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_ADD')" />&nbsp;&#8594;
																			</xsl:if>

																		</button>
																	</div>
																	<div>
																		<button dojoType="dijit.form.Button" type="button">
																			<xsl:attribute name="id">remove_<xsl:value-of select="$entity_id"/>
																				<xsl:value-of select="$account_id"/>
																			</xsl:attribute>
																			<xsl:attribute name="onClick">misys.addProductMultiSelectItems('<xsl:value-of select="$entity_id"/>_<xsl:value-of select="$account_id"/>',false);</xsl:attribute>

																			<xsl:if test="$language = 'ar'">
																	       		&nbsp;&#8594;<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REMOVE')" />
																			</xsl:if>
																			<xsl:if test="$language != 'ar'">
																	       		&#8592;&nbsp;<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REMOVE')" />
																			</xsl:if>														       														       
																		</button>
																	</div>
																</div>
																<div>
																</div>
															</div>
														</xsl:if>
														<div class="inlineBlock userAccountsMultiSelect">
															<xsl:call-template name="select-field">
																<xsl:with-param name="label"/>
																<xsl:with-param name="name">account_products_exist_nosend_<xsl:value-of select="$entity_id"/>_<xsl:value-of select="$account_id"/>
																</xsl:with-param>
																<xsl:with-param name="type">multiple</xsl:with-param>
																<xsl:with-param name="size">10</xsl:with-param>
																<xsl:with-param name="options">
																	<xsl:choose>
																		<xsl:when test="$displaymode='edit'">
																			<xsl:apply-templates select="existing_products/product" mode="input"/>
																		</xsl:when>
																		<xsl:otherwise>
																			<ul class="multi-select">
																				<xsl:apply-templates select="existing_products/product" mode="input"/>
																			</ul>
																		</xsl:otherwise>
																	</xsl:choose>
																</xsl:with-param>
															</xsl:call-template>
														</div>
													</div>
												</div>
											</div>
										</xsl:when>
										<xsl:otherwise>
										</xsl:otherwise>			
									</xsl:choose>		
								</xsl:when>
								<xsl:otherwise>
									<div style="width:100%;">
										<div class="userAccountsTableCell userAccountsTableCellOdd alignCenterWithPadding userAccountsHeaderSelector">
											<xsl:call-template name="column-check-box">
												<xsl:with-param name="id">account_enabled_<xsl:value-of select="$entity_id"/>_<xsl:value-of select="$account_id"/>
												</xsl:with-param>
												<xsl:with-param name="checked">
													<xsl:value-of select="$account_record/account_enabled"/>
												</xsl:with-param>
											</xsl:call-template>
										</div>
										<xsl:choose>
											<xsl:when test="../../static_user/static_company/owner_is_group[.!=''] and ../../static_user/static_company/owner_is_group[.='Y']">
												<div class="userAccountsTableCell userAccountsTableCellOdd alignLeftWithPadding width15per">
													<xsl:value-of select="$account_record/account_owner_bank"/>
												</div>
												<div class="userAccountsTableCell userAccountsTableCellOdd alignLeftWithPadding">
													<xsl:attribute name="style">
														<xsl:choose>
															<xsl:when test="$nonPabAllowed = 'false'">width:50%;</xsl:when>
															<xsl:otherwise>width:34%;</xsl:otherwise>
														</xsl:choose>
													</xsl:attribute>										
													<xsl:choose>
														<xsl:when test="$account_record/account_owner_type = '05'">
															<xsl:value-of select="$account_record/acct_name"/>
														</xsl:when>
														<xsl:otherwise>
															<xsl:value-of select="$account_record/account_cur_code"/>&nbsp;
															<xsl:value-of select="$account_record/account_no"/>&nbsp;
															<xsl:value-of select="$account_record/account_type"/>
														</xsl:otherwise>
													</xsl:choose>

												</div>
											</xsl:when>
											<xsl:otherwise>
												<div class="userAccountsTableCell userAccountsTableCellOdd alignLeftWithPadding">
													<xsl:attribute name="style">
														<xsl:choose>
															<xsl:when test="$nonPabAllowed = 'false'">width:65%;</xsl:when>
															<xsl:otherwise>width:49%;</xsl:otherwise>
														</xsl:choose>
													</xsl:attribute>										
													<xsl:choose>
														<xsl:when test="$account_record/account_owner_type = '05'">
															<xsl:value-of select="$account_record/acct_name"/>
														</xsl:when>
														<xsl:otherwise>
															<xsl:value-of select="$account_record/account_cur_code"/>&nbsp;
															<xsl:value-of select="$account_record/account_no"/>&nbsp;
															<xsl:value-of select="$account_record/account_type"/>
														</xsl:otherwise>
													</xsl:choose>

												</div>
											</xsl:otherwise>
										</xsl:choose>
										<div class="userAccountsTableCell userAccountsTableCellOdd alignCenterWithPadding width15per">
											<!-- Hide PAB column if non-PAB accounts are not allowed -->
											<xsl:if test="$nonPabAllowed = 'false'">
												<xsl:attribute name="style">display:none;</xsl:attribute>
											</xsl:if>
											<xsl:call-template name="column-check-box">
												<xsl:with-param name="id">account_pab_enabled_<xsl:value-of select="$entity_id"/>_<xsl:value-of select="$account_id"/>
												</xsl:with-param>
												<xsl:with-param name="checked">
													<xsl:value-of select="$account_record/pab_enabled"/>
												</xsl:with-param>
											</xsl:call-template>
										</div>	
										<div class="userAccountsTableCell userAccountsTableCellOdd alignCenterWithPadding width15per">
											<xsl:call-template name="column-check-box">
												<xsl:with-param name="id">account_view_stmt_enabled_<xsl:value-of select="$entity_id"/>_<xsl:value-of select="$account_id"/>
												</xsl:with-param>
												<xsl:with-param name="checked">
													<xsl:value-of select="$account_record/view_stat_enabled"/>
												</xsl:with-param>
											</xsl:call-template>
										</div>
										<div class="userAccountsTableCell userAccountsTableCellOdd alignCenterWithPadding width15per">
											<xsl:choose>
												<xsl:when test="$displaymode = 'edit' or ($displaymode != 'edit' and (count(existing_products/product) != 0)) ">
													<span style="vertical-align:top;" >
														<xsl:attribute name="id">account_products_indicator_<xsl:value-of select="$entity_id"/>_<xsl:value-of select="$account_id"/>
														</xsl:attribute>
														<xsl:if test="$displaymode='view'">	
															<xsl:value-of select="count(existing_products/product)"/>&nbsp;<xsl:value-of select="localization:getGTPString($language, 'XSL_USER_ACCOUNTS_PRODUCT_COUNT')"/>
														</xsl:if>
													</span>
													<span>
														<xsl:attribute name="style">
															<xsl:choose>
																<xsl:when test="($displaymode !='edit') and ($account_record/account_enabled[.='Y']) and (count($account_record/existing_products/product) > 0)">
																     	 display:none;cursor:pointer;vertical-align:middle;
																</xsl:when>
																<xsl:otherwise>
																          cursor:pointer;vertical-align:middle;
																</xsl:otherwise>
															</xsl:choose>
														</xsl:attribute>
														<xsl:attribute name="id">account_products_down_<xsl:value-of select="$entity_id"/>_<xsl:value-of select="$account_id"/>
														</xsl:attribute>
														<a>
															<xsl:attribute name="onClick">misys.toggleDisplayProducts('<xsl:value-of select="$entity_id"/>_<xsl:value-of select="$account_id"/>','down');</xsl:attribute>
															<img>
																<xsl:attribute name="src">
																	<xsl:value-of select="utils:getImagePath($actionDownImage)"/></xsl:attribute>
																<xsl:attribute name="alt">
																	<xsl:value-of select="localization:getGTPString($language, 'OPEN_PRODUCTS_ASSIGNMENT')"/>
																</xsl:attribute>
															</img>
														</a>
													</span>
													<span>
														<xsl:attribute name="style">
															<xsl:choose>
																<xsl:when test="($displaymode !='edit') and ($account_record/account_enabled[.='Y']) and (count($account_record/existing_products/product) > 0)">
																     	cursor:pointer;vertical-align:middle;
																</xsl:when>
																<xsl:otherwise>
																          display:none;cursor:pointer;vertical-align:middle;
																</xsl:otherwise>
															</xsl:choose>
														</xsl:attribute>
														<xsl:attribute name="id">account_products_up_<xsl:value-of select="$entity_id"/>_<xsl:value-of select="$account_id"/>
														</xsl:attribute>
														<a>
															<xsl:attribute name="onClick">misys.toggleDisplayProducts('<xsl:value-of select="$entity_id"/>_<xsl:value-of select="$account_id"/>','up');</xsl:attribute>
															<img>
																<xsl:attribute name="src">
																	<xsl:value-of select="utils:getImagePath($actionUpImage)"/></xsl:attribute>
																<xsl:attribute name="alt">
																	<xsl:value-of select="localization:getGTPString($language, 'CLOSE_PRODUCTS_ASSIGNMENT')"/>
																</xsl:attribute>
															</img>
														</a>
													</span>
												</xsl:when>
												<xsl:otherwise>
													<span>
														<xsl:value-of select="localization:getGTPString($language, 'XSL_NO_PRODUCTS')"/>
													</span>	
												</xsl:otherwise>
											</xsl:choose>
										</div>
									</div>
									<div class="userEntityTableMergedCellContainer">
										<xsl:attribute name="id">account_products_div_<xsl:value-of select="$entity_id"/>_<xsl:value-of select="$account_id"/>
										</xsl:attribute>
										<xsl:attribute name="style">
											<xsl:choose>
												<xsl:when test="($displaymode !='edit') and ($account_record/account_enabled[.='Y']) and (count($account_record/existing_products/product) > 0)">
													<xsl:choose>
														<xsl:when test="$nonPabAllowed = 'false'">width:82.7%;</xsl:when>
														<xsl:otherwise>width:98%;</xsl:otherwise>
													</xsl:choose>
												</xsl:when>
												<xsl:otherwise>
													<xsl:choose>
														<xsl:when test="$nonPabAllowed = 'false'">display:none;width:82.7%;</xsl:when>
														<xsl:otherwise>display:none;width:98%;</xsl:otherwise>
													</xsl:choose>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:attribute>
										<xsl:variable name="displayModeClass">user_account_<xsl:value-of select="$displaymode"/>
										</xsl:variable>
										<div>
											<xsl:attribute name="class">
												<xsl:value-of select="$displayModeClass"/>
											</xsl:attribute>
											<div class="userAccountsMergedCell">
												<xsl:if test="$displaymode = 'edit'">
													<div class="inlineBlock userAccountsMultiSelect">
														<xsl:call-template name="select-field">
															<xsl:with-param name="label"/>
															<xsl:with-param name="id">account_products_avail_nosend_<xsl:value-of select="$entity_id"/>_<xsl:value-of select="$account_id"/>
															</xsl:with-param>
															<xsl:with-param name="name"/>
															<xsl:with-param name="type">multiple</xsl:with-param>
															<xsl:with-param name="size">10</xsl:with-param>
															<xsl:with-param name="options">
																<xsl:choose>
																	<xsl:when test="$displaymode='edit'">
																		<xsl:apply-templates select="avail_products/product" mode="input"/>
																	</xsl:when>
																	<xsl:otherwise>
																		<ul class="multi-select">
																			<xsl:apply-templates select="avail_products/product" mode="input"/>
																		</ul>
																	</xsl:otherwise>
																</xsl:choose>
															</xsl:with-param>
														</xsl:call-template>
													</div>
													<div id="add-remove-buttons" class="multiselect-buttons inlineBlock" style="text-align:center;">
														<div>
															<div>
																<button dojoType="dijit.form.Button" type="button">
																	<xsl:attribute name="id">add_<xsl:value-of select="$entity_id"/>
																		<xsl:value-of select="$account_id"/>
																	</xsl:attribute>
																	<xsl:attribute name="onClick">misys.addProductMultiSelectItems('<xsl:value-of select="$entity_id"/>_<xsl:value-of select="$account_id"/>',true);</xsl:attribute>

																	<xsl:if test="$language = 'ar'">
																		<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_ADD')" />&#8592;&nbsp;
																	</xsl:if>
																	<xsl:if test="$language != 'ar'">
																		<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_ADD')" />&nbsp;&#8594;
																	</xsl:if>

																</button>
															</div>
															<div>
																<button dojoType="dijit.form.Button" type="button">
																	<xsl:attribute name="id">remove_<xsl:value-of select="$entity_id"/>
																		<xsl:value-of select="$account_id"/>
																	</xsl:attribute>
																	<xsl:attribute name="onClick">misys.addProductMultiSelectItems('<xsl:value-of select="$entity_id"/>_<xsl:value-of select="$account_id"/>',false);</xsl:attribute>

																	<xsl:if test="$language = 'ar'">
														       		&nbsp;&#8594;<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REMOVE')" />
																	</xsl:if>
																	<xsl:if test="$language != 'ar'">
														       		&#8592;&nbsp;<xsl:value-of select="localization:getGTPString($language, 'XSL_ACTION_REMOVE')" />
																	</xsl:if>														       														       
																</button>
															</div>
														</div>
														<div>
														</div>
													</div>
												</xsl:if>
												<div class="inlineBlock userAccountsMultiSelect">
													<xsl:call-template name="select-field">
														<xsl:with-param name="label"/>
														<xsl:with-param name="name">account_products_exist_nosend_<xsl:value-of select="$entity_id"/>_<xsl:value-of select="$account_id"/>
														</xsl:with-param>
														<xsl:with-param name="type">multiple</xsl:with-param>
														<xsl:with-param name="size">10</xsl:with-param>
														<xsl:with-param name="options">
															<xsl:choose>
																<xsl:when test="$displaymode='edit'">
																	<xsl:apply-templates select="existing_products/product" mode="input"/>
																</xsl:when>
																<xsl:otherwise>
																	<ul class="multi-select">
																		<xsl:apply-templates select="existing_products/product" mode="input"/>
																	</ul>
																</xsl:otherwise>
															</xsl:choose>
														</xsl:with-param>
													</xsl:call-template>
												</div>
											</div>
										</div>
									</div>
								</xsl:otherwise>			
							</xsl:choose>		
						</xsl:for-each>
					</xsl:when>
					<xsl:otherwise>
						<div style="padding:3px 10px;">
							<xsl:value-of select="localization:getGTPString($language, 'XSL_NO_USER_ACCOUNTS')"/>
						</div>	
					</xsl:otherwise>
				</xsl:choose>
			</div>
		</xsl:for-each>
	</xsl:template>
	<xsl:template name="column-check-box">
		<xsl:param name="disabled"/>
		<xsl:param name="readonly"/>
		<xsl:param name="checked"/>
		<xsl:param name="id"/>
		<div dojoType="dijit.form.CheckBox">
			<xsl:attribute name="id">
				<xsl:value-of select="$id"/>
			</xsl:attribute>
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

	<xsl:template match="avail_products/product | existing_products/product" mode="input">
		<xsl:choose>
			<xsl:when test="$displaymode='edit'">
				<option>
					<xsl:attribute name="value">
						<xsl:value-of select="product_code"/>
					</xsl:attribute>
					<xsl:value-of select="product_name"/>
				</option>
			</xsl:when>
			<xsl:otherwise>
				<li>
					<xsl:value-of select="product_name"/>
				</li>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>