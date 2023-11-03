<?xml version="1.0" encoding="UTF-8"?>
<!-- Copyright (c) 2000-2011 Misys (http://www.misys.com), All Rights Reserved. -->
<xsl:stylesheet xmlns:colorresource="xalan://com.misys.portal.common.resources.ColorResourceProvider" 
				xmlns:convertTools="xalan://com.misys.portal.common.tools.ConvertTools" 
				xmlns:defaultresource="xalan://com.misys.portal.common.resources.DefaultResourceProvider" 
				xmlns:fo="http://www.w3.org/1999/XSL/Format" 
				xmlns:localization="xalan://com.misys.portal.common.localization.Localization" 
				xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:java="http://xml.apache.org/xalan/java"
				xmlns:xd="http://www.pnp-software.com/XSLTdoc">

	<xsl:variable name="isdynamiclogo">
		<xsl:value-of select="defaultresource:getResource('PDF_LOGO_ISDYNAMIC')"/>
	</xsl:variable>
	<xsl:template match="bulk_upload_file_details">
		<!-- HEADER -->
		
		<!-- FOOTER -->
		
		<!-- BODY -->
		
	<xsl:call-template name="header"/>
    <xsl:call-template name="footer"/>
    <xsl:call-template name="body"/>
  </xsl:template>
	<xsl:template match="se_tnx_record">
		<xsl:variable name="prodStadCode" select="prod_stat_code"/>
		<xsl:variable name="status">
			<xsl:choose>
				<xsl:when test="prod_stat_code[.='01']">
					<xsl:value-of select="localization:getString($language, 'FILE_PROCESS_FAILED')"/>
				</xsl:when>
				<xsl:when test="prod_stat_code[.='02']">
					<xsl:value-of select="localization:getString($language, 'FILE_PROCESS_PROGRESS')"/>
				</xsl:when>
				<xsl:when test="prod_stat_code[.='25']">
					<xsl:value-of select="localization:getString($language, 'FILE_PROCESS_PARTIAL')"/>
				</xsl:when>
				<xsl:when test="prod_stat_code[.='03']">
					<xsl:value-of select="localization:getString($language, 'FILE_PROCESS_SUCCESS')"/>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<fo:block id="gendetails"/>
		<xsl:call-template name="table_template">
			<xsl:with-param name="text">
				<xsl:call-template name="title">
					<xsl:with-param name="text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_GENERAL_DETAILS')"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		<fo:block white-space-collapse="false">
			<fo:table>
				<fo:table-column column-width="50%"/>
				<fo:table-column column-width="50%"/>
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell padding-bottom="2.5pt" padding-left="10pt">
							<fo:table>
								<fo:table-column column-width="40%"/>
								<fo:table-column column-width="60%"/>
								<fo:table-body start-indent="2pt">
									<fo:table-row>
										<fo:table-cell>
											<fo:block> 
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block> 
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<fo:table-row>
										<fo:table-cell>
											<fo:block>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_FILE_REF_ID')"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<xsl:value-of select="ref_id"/>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>

									<fo:table-row>
										<fo:table-cell>
											<fo:block>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_FILE_UPLOADED_DATE_TIME')"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<xsl:value-of select="inp_dttm"/>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>

									<fo:table-row>
										<fo:table-cell>
											<fo:block>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_FILE_SIZE')"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<xsl:value-of select="file_size"/>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>

								<xsl:if test="reference[.!='']">
									<fo:table-row>
										<fo:table-cell>
											<fo:block>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_FILE_REFERENCE')"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<xsl:value-of select="reference"/>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</xsl:if>
								
									<fo:table-row>
										<fo:table-cell>
											<fo:block>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_FILE_NAME')"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<xsl:value-of select="file_name"/>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<xsl:if test="upload_description[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_FILE_DESCRIPTION')"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="upload_description"/>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
									</xsl:if>
									<xsl:if test="name[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_FILE_BANK')"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="name"/>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
									</xsl:if>
									<xsl:if test="file_type[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_FILE_TYPE')"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="file_type"/>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
									</xsl:if>
									<xsl:if test="format_name[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_FILE_FORMAT')"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="format_name"/>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
									</xsl:if>
									<xsl:if test="format_type[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_FILE_FORMAT_TYPE')"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="format_type"/>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
									</xsl:if>
									<xsl:if test="file_encrypted[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_FILE_ENCRYPTED')"/>
												</fo:block>
											</fo:table-cell>
											<xsl:choose>
												<xsl:when test="file_encrypted[.='N']">
													<fo:table-cell>
														<fo:block>
															<xsl:value-of select="localization:getDecode($language, 'N034','N')"/>
														</fo:block>
													</fo:table-cell>
												</xsl:when>
												<xsl:otherwise>
													<fo:table-cell>
														<fo:block>
															<xsl:value-of select="localization:getDecode($language, 'N034','Y')"/>
														</fo:block>
													</fo:table-cell>
												</xsl:otherwise>
											</xsl:choose>
										</fo:table-row>
									</xsl:if>
								</fo:table-body>
							</fo:table>
						</fo:table-cell>
						<fo:table-cell>
							<fo:table>
								<fo:table-column column-width="50%"/>
								<fo:table-column column-width="50%"/>
								<fo:table-body start-indent="1pt">
									<fo:table-row>
										<fo:table-cell>
											<fo:block> 
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block> 
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<xsl:if test="amendable[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_FILE_AMENDABLE')"/>
												</fo:block>
											</fo:table-cell>
											<xsl:choose>
												<xsl:when test="amendable[.='N']">
													<fo:table-cell>
														<fo:block>
															<xsl:value-of select="localization:getDecode($language, 'N034','N')"/>
														</fo:block>
													</fo:table-cell>
												</xsl:when>
												<xsl:otherwise>
													<fo:table-cell>
														<fo:block>
															<xsl:value-of select="localization:getDecode($language, 'N034','Y')"/>
														</fo:block>
													</fo:table-cell>
												</xsl:otherwise>
											</xsl:choose>
										</fo:table-row>
									</xsl:if>
									<fo:table-row>
										<fo:table-cell>
											<fo:block>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_FILE_PRODUCT_GROUP')"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<xsl:value-of select="product_group"/>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<xsl:if test="payroll_type[.!='**']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_FILE_PAYROL_TYPE')"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="payroll_type"/>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
									</xsl:if>
									<fo:table-row>
										<fo:table-cell>
											<fo:block>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_FILE_PRODUCT_TYPE')"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<xsl:value-of select="product_type"/>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								
								<xsl:if test="entity[.!='']">
									<fo:table-row>
										<fo:table-cell>
											<fo:block>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_FILE_ENTITY')"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<xsl:value-of select="entity"/>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</xsl:if>
								
								<xsl:if test="file_upload_act_no[.!='']">
									<fo:table-row>
										<fo:table-cell>
											<fo:block>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_FILE_ACCOUNT')"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<xsl:value-of select="file_upload_act_no"/>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
								</xsl:if>	
								
								<xsl:if test="tnx_id[.!=''] and value_date[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_FILE_VALUE_DATE')"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="value_date"/>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
								</xsl:if>
									<fo:table-row>
										<fo:table-cell>
											<fo:block>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_FILE_STATUS')"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<xsl:value-of select="$status"/>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
			
									<xsl:if test="user[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_FILE_USER')"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="user"/>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
									</xsl:if>
									
									<xsl:if test="user_country[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_FILE_country')"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="user_country"/>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
									</xsl:if>
									<fo:table-row>
										<fo:table-cell>
											<fo:block>
												<xsl:value-of select="localization:getGTPString($language, 'XSL_FILE_COMPANY')"/>
											</fo:block>
										</fo:table-cell>
										<fo:table-cell>
											<fo:block>
												<xsl:value-of select="company_name"/>
											</fo:block>
										</fo:table-cell>
									</fo:table-row>
									<xsl:if test="upload_resulting_bulk[.!='']">
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="localization:getGTPString($language, 'XSL_FILE_NO_BULK_RESULTING')"/>
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>
													<xsl:value-of select="upload_resulting_bulk"/>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
									</xsl:if>
								</fo:table-body>
							</fo:table>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>

	<xsl:template match="error_log">
		<xsl:param name="file_ref_id"/>
		<xsl:param name="file_name"/>

		<!--Error Log -->
		<fo:block id="errorLog"/>
		<xsl:call-template name="table_template">
			<xsl:with-param name="text">
				<xsl:call-template name="title">
					<xsl:with-param name="text">
						<xsl:value-of select="localization:getGTPString($language, 'XSL_ERROR_LOG')"/>
					</xsl:with-param>
				</xsl:call-template>
			</xsl:with-param>
		</xsl:call-template>
		<xsl:choose>
			<xsl:when test="count(file_error/errors/error) &gt;=1 or count(batch_error/errors/error) &gt;=1 or count(validation_error/errors/error) &gt;=1 or count(transaction_error/errors/error) &gt;=1">
				<!-- File Error Details -->
				<xsl:if test="count(file_error/errors/error) &gt;=1">
					<fo:block id="file_error"/>
					<xsl:call-template name="table_template">
						<xsl:with-param name="text">
							<xsl:call-template name="subtitle">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_FILE_LEVEL_ERROR')"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:apply-templates select="file_error/errors">
						<xsl:with-param name="show_ref">
							N
						</xsl:with-param>
						<xsl:with-param name="file_ref_id">
							<xsl:value-of select="$file_ref_id"/>
						</xsl:with-param>
						<xsl:with-param name="file_name">
							<xsl:value-of select="$file_name"/>
						</xsl:with-param>
					</xsl:apply-templates>
				</xsl:if>
				<!-- Batch Error Details -->
				<xsl:if test="count(batch_error/errors/error) &gt;=1">
					<fo:block id="batch_error"/>
					<xsl:call-template name="table_template">
						<xsl:with-param name="text">
							<xsl:call-template name="subtitle">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_BATCH_LEVEL_ERROR')"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:apply-templates select="batch_error/errors">
						<xsl:with-param name="show_ref">
							N
						</xsl:with-param>
						<xsl:with-param name="file_ref_id">
							<xsl:value-of select="$file_ref_id"/>
						</xsl:with-param>
						<xsl:with-param name="file_name">
							<xsl:value-of select="$file_name"/>
						</xsl:with-param>
					</xsl:apply-templates>
				</xsl:if>
				<!-- Validation Error Details -->
				<xsl:if test="count(validation_error/errors/error) &gt;=1">
					<fo:block id="validation_error"/>
					<xsl:call-template name="table_template">
						<xsl:with-param name="text">
							<xsl:call-template name="subtitle">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_VALIDATION_LEVEL_ERROR')"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:apply-templates select="validation_error/errors">
						<xsl:with-param name="show_ref">
							Y
						</xsl:with-param>
						<xsl:with-param name="file_ref_id">
							<xsl:value-of select="$file_ref_id"/>
						</xsl:with-param>
						<xsl:with-param name="file_name">
							<xsl:value-of select="$file_name"/>
						</xsl:with-param>
					</xsl:apply-templates>
				</xsl:if>
				<!-- Transaction Error Details -->
				<xsl:if test="count(transaction_error/errors/error) &gt;=1">
					<fo:block id="transaction_error"/>
					<xsl:call-template name="table_template">
						<xsl:with-param name="text">
							<xsl:call-template name="subtitle">
								<xsl:with-param name="text">
									<xsl:value-of select="localization:getGTPString($language, 'XSL_TRANSACTION_LEVEL_ERROR')"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:with-param>
					</xsl:call-template>
					<xsl:apply-templates select="transaction_error/errors">
						<xsl:with-param name="show_ref">
							Y
						</xsl:with-param>
						<xsl:with-param name="file_ref_id">
							<xsl:value-of select="$file_ref_id"/>
						</xsl:with-param>
						<xsl:with-param name="file_name">
							<xsl:value-of select="$file_name"/>
						</xsl:with-param>
					</xsl:apply-templates>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<fo:block id="No_error_log" text-align="center">
					<xsl:value-of select="localization:getGTPString($language, 'XSL_NO_ERROR_FOUND')"/>
				</fo:block>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- Template to display Errors -->
	<xsl:template match="errors">
		<xsl:param name="show_ref"/>
		<xsl:param name="file_ref_id"/>
		<xsl:param name="file_name"/>
		<xsl:for-each select="error">
			<fo:block white-space-collapse="false">
				<fo:table>
					<fo:table-column column-width="100%"/>
					<fo:table-body>
						<fo:table-row>
							<fo:table-cell padding-bottom="2.5pt" padding-left="10pt">
								<fo:table>
									<fo:table-column column-width="50%"/>
									<fo:table-column column-width="50%"/>
									<fo:table-body start-indent="2pt">
										<fo:table-row>
											<fo:table-cell>
												<fo:block> 
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block> 
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
										<fo:table-row>
											<fo:table-cell>
												<fo:block>
													<fo:table>
														<fo:table-column column-width="50%"/>
														<fo:table-column column-width="50%"/>
														<fo:table-body start-indent="0pt">
															<fo:table-row>
																<fo:table-cell>
																	<fo:block>
																		<xsl:value-of select="position()"/>.<xsl:value-of select="localization:getGTPString($language, 'XSL_FILE_NAME')"/>
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block>
																		<xsl:value-of select="$file_name"/>
																	</fo:block>
																</fo:table-cell>
															</fo:table-row>
															<fo:table-row>
																<fo:table-cell>
																	<fo:block>
																		<xsl:value-of select="localization:getGTPString($language, 'XSL_FILE_REF_ID')"/>
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block>
																		<xsl:value-of select="$file_ref_id"/>
																	</fo:block>
																</fo:table-cell>
															</fo:table-row>
															<xsl:if test="$show_ref ='Y' and ref_id[.!='']">
																<fo:table-row>
																	<fo:table-cell>
																		<fo:block>
																			<xsl:value-of select="localization:getGTPString($language, 'XSL_JURISDICTION_REFERENCE_ID')"/>
																		</fo:block>
																	</fo:table-cell>
																	<fo:table-cell>
																		<fo:block>
																			<xsl:value-of select="ref_id"/>
																		</fo:block>
																	</fo:table-cell>
																</fo:table-row>
															</xsl:if>
															<xsl:if test="line_number[.!='']">
															<fo:table-row>
																<fo:table-cell>
																	<fo:block>
																		<xsl:value-of select="localization:getGTPString($language, 'XSL_LINE_NUMBER')"/>
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block>
																		<xsl:value-of select="line_number"/>
																	</fo:block>
																</fo:table-cell>
															</fo:table-row>
															</xsl:if>
															<xsl:if test="column_number[.!='']">
															<fo:table-row>
																<fo:table-cell>
																	<fo:block>
																		<xsl:value-of select="localization:getGTPString($language, 'XSL_COLUMN_NUMBER')"/>
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell>
																	<fo:block>
																		<xsl:value-of select="column_number"/>
																	</fo:block>
																</fo:table-cell>
															</fo:table-row>
															</xsl:if>
															<xsl:if test="error_code[.!='']">
															<fo:table-row>
																<fo:table-cell>
																	<fo:block>
																		<xsl:value-of select="localization:getGTPString($language, 'XSL_BK_ERROR_DESCRIPTION')"/>
																	</fo:block>
																</fo:table-cell>
																<fo:table-cell>
																	<xsl:choose>
																		<xsl:when test="msg_with_args">
								             								<xsl:value-of select="msg_with_args"/>
								                                    	</xsl:when>
																		<xsl:when test="error_code[.!='']">
																			<xsl:variable name="error_code">
																				<xsl:value-of select="error_code"/>
																			</xsl:variable>
																			<fo:block>
																				<xsl:value-of select="localization:getGTPString($language, $error_code)"/>
																			</fo:block>
																			<fo:block>
																				<xsl:value-of select="error_value"/>
																			</fo:block>
																		</xsl:when>
																		<xsl:otherwise>
																			<fo:block>
																				<xsl:value-of select="error_value"/>
																			</fo:block>
																		</xsl:otherwise>
																	</xsl:choose>
																</fo:table-cell>
															</fo:table-row>
															</xsl:if>
														</fo:table-body>
													</fo:table>
												</fo:block>
											</fo:table-cell>
										</fo:table-row>
									</fo:table-body>
								</fo:table>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>
				</fo:table>
			</fo:block>
		</xsl:for-each>
	</xsl:template>
	
<!-- template to display errors at pdf -->		
	<xsl:template name="failed-records">
		<fo:block id="failedRecords"/>
		<xsl:if test="(count(error_log/errors/error) &gt; 0)">	
			<fo:block white-space-collapse="false" xmlns:colorresource="xalan://com.misys.portal.common.resources.ColorResourceProvider">
				<fo:table>
					<fo:table-column column-width="50%"/>
					<fo:table-column column-width="25%"/>
					<fo:table-column column-width="25%"/>
					
					<fo:table-header>
						<fo:table-row font-size="8.0pt" keep-with-next="always">
							<fo:table-cell number-columns-spanned="2">
								<xsl:call-template name="title_private">
									<xsl:with-param name="content">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_VIEW_FAILED')"/>
									</xsl:with-param>
								</xsl:call-template>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-header>
					<fo:table-body> 
				     		<fo:table-row>
								<fo:table-cell>
									<fo:block>
                 						<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_LINE_NO')"/>
              						</fo:block>
								</fo:table-cell>
							  	<fo:table-cell>
									<fo:block>
					                  	<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_COL_NO')"/>
					                </fo:block>
					            </fo:table-cell>
								<fo:table-cell>
									<fo:block>
	                 					 <xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_FAIL_REASON')"/>
	            				    </fo:block>
								</fo:table-cell>
							</fo:table-row>
                        <xsl:variable name="arrayList" select="java:java.util.ArrayList.new()" />
                        <xsl:variable name="void" select="java:add($arrayList, concat('', defaultresource:getResource('BULK_POSTDATED_DAYS')))"/>
                        <xsl:variable name="args" select="java:toArray($arrayList)"/>
						<xsl:for-each select="error_log/errors/error">	
						  <xsl:sort data-type="number" select="line_number"/>					
							<fo:table-row>
								<fo:table-cell>
									<fo:block>    
										<xsl:value-of select="./line_number"/>
                 					 </fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block>    
										<xsl:value-of select="./column_number"/>
             					     </fo:block>
								</fo:table-cell>
								<fo:table-cell>
								<fo:block>
								<xsl:choose>
									<xsl:when test="msg_with_args">
										<xsl:value-of select="msg_with_args"/>
									</xsl:when>
									<xsl:when test="error_code[.!='']">
										<xsl:variable name="error_code">
				                          <xsl:value-of select="error_code"/>
				                        </xsl:variable>
										<xsl:value-of select="localization:getFormattedString($language, $error_code, $args)"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="error_value"/>  
									</xsl:otherwise>
								</xsl:choose> 
									
									</fo:block>
								</fo:table-cell>
							</fo:table-row>	
							
						</xsl:for-each>
					</fo:table-body>
				</fo:table>
			</fo:block>
		</xsl:if>
	</xsl:template>

<!-- Template to display successful reocrds in PDF -->
	<xd:doc>
		<xd:short>To show successful Bulk from Local service.</xd:short>
		<xd:detail>
			All the successfull bulk upload through local service.
		</xd:detail>
	</xd:doc>
	<xsl:template name="successful-records">
		<fo:block id="successfulRecords"/>
			<fo:block white-space-collapse="false" xmlns:colorresource="xalan://com.misys.portal.common.resources.ColorResourceProvider">
				<fo:table>
					<fo:table-column column-width="30%"/>
					<fo:table-column column-width="40%"/>
					<fo:table-column column-width="30%"/>
					
					<fo:table-header>
						<fo:table-row font-size="8.0pt" keep-with-next="always">
							<fo:table-cell number-columns-spanned="2">
								<xsl:call-template name="title_private">
									<xsl:with-param name="content">
										<xsl:value-of select="localization:getGTPString($language, 'XSL_HEADER_VIEW_SUCCSESSFUL')"/>
									</xsl:with-param>
								</xsl:call-template>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-header>
				<fo:table-body>
							<fo:table-row>
								<fo:table-cell>
									<fo:block>
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_HEADER_LINE_NO')" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block>
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_HEADER_BULK_REFERNCE')" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell>
									<fo:block>
										<xsl:value-of
											select="localization:getGTPString($language, 'XSL_HEADER_FUND_TRANSFER_REFERNCE')" />
									</fo:block>
								</fo:table-cell>
							</fo:table-row>	
						<xsl:for-each select="bo_comment/bkftrecords/bkftrecord">	
						  <xsl:sort data-type="number" select="line_number"/>					
								<fo:table-row>
									<fo:table-cell>
										<fo:block>    <xsl:value-of select="line_number"/> </fo:block>
									</fo:table-cell>
									
									<fo:table-cell>
										<fo:block><xsl:value-of select="bkref" /></fo:block>
									</fo:table-cell>
									
									<fo:table-cell>
										<fo:block><xsl:value-of select="ftref" /></fo:block>
									</fo:table-cell>
								</fo:table-row>								
						</xsl:for-each>
					</fo:table-body>
				</fo:table>
			</fo:block>
	</xsl:template>
	
<xsl:template name="header">
    <fo:static-content flow-name="xsl-region-before">
			<xsl:call-template name="header_issuing_bank"/>
		</fo:static-content>
  </xsl:template>
  <xsl:template name="body">
    <fo:flow flow-name="xsl-region-body" font-size="{$pdfFontSize}">
			<xsl:apply-templates select="se_tnx_record"/>
			<xsl:if test="format='STANDARD'">
			<xsl:apply-templates select="error_log">
				<xsl:with-param name="file_ref_id">
					<xsl:value-of select="se_tnx_record/ref_id"/>
				</xsl:with-param>
				<xsl:with-param name="file_name">
					<xsl:value-of select="se_tnx_record/file_name"/>
				</xsl:with-param>
			</xsl:apply-templates>
			</xsl:if>
			<xsl:if test="format='FLEXI'">
	 		 <xsl:choose>
			 <xsl:when test="count(error_log/errors/error) &gt;=1">
				<xsl:call-template name="failed-records"/>
			 </xsl:when>
			 <xsl:otherwise>
			 	<xsl:call-template name="successful-records"/>
			</xsl:otherwise>
		</xsl:choose>		 
		 </xsl:if>
			<xsl:element name="fo:block">
				<xsl:attribute name="font-size">1pt</xsl:attribute>
				<xsl:attribute name="id">
                    <xsl:value-of select="concat('LastPage_',../@section)"/>
                </xsl:attribute>
			</xsl:element>
		</fo:flow>
  </xsl:template>
  <xsl:template name="footer">
    <fo:static-content flow-name="xsl-region-after">
			<fo:block font-family="{$pdfFont}" font-size="8.0pt" keep-together="always">
				<!-- Page number -->
				<fo:block color="{$footerFontColor}" font-weight="bold" text-align="start">
					<fo:page-number/>
					/
					<fo:page-number-citation>
						<xsl:attribute name="ref-id">
							<xsl:value-of select="concat('LastPage_',../@section)"/>
						</xsl:attribute>
					</fo:page-number-citation>
				</fo:block>
				<fo:block color="{$footerFontColor}" text-align="start">
					<xsl:attribute name="end-indent">
						<xsl:value-of select="number($pdfMargin)"/>
					</xsl:attribute>
					<xsl:value-of select="convertTools:internalDateToStringDate($systemDate,$language)"/>
				</fo:block>
			</fo:block>
		</fo:static-content>
  </xsl:template>
</xsl:stylesheet>
