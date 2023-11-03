<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!--
   Copyright (c) 2000-2004 NEOMAlogic (http://www.neomalogic.com),
   All Rights Reserved. 
-->
	<xsl:param name="parm_id"/>
	<xsl:param name="company_id"/>
	<xsl:param name="mutipleparam"/>
	<xsl:param name="updatemode"/>

	<!-- Match template -->
	<xsl:template match="/">
		<xsl:apply-templates select="maintainParameter"/>
	</xsl:template>
	
		
	<xsl:template name="selectkey">
		<xsl:param name="key"/>
		<xsl:choose>
			<xsl:when test="$key = ''">**</xsl:when>   
			<xsl:when test="$key = 'WILDCARD'">*</xsl:when>
			<xsl:otherwise><xsl:value-of select="$key"/></xsl:otherwise>
 		</xsl:choose>
		
	</xsl:template>
	
	
	<xsl:template match="maintainParameter">
		
		<parameter_data>
			<xsl:element name="parm_id">
				<xsl:value-of select="$parm_id"/>
			</xsl:element>
			<xsl:element name="company_id">
				<!-- priority given to the company id passed from client -->
				<xsl:variable name="compid"><xsl:value-of select="company_id"/> </xsl:variable>
				<xsl:choose>
					<xsl:when test="$compid != ''">
						<xsl:value-of select="$compid"/>
					</xsl:when>
					<xsl:otherwise><xsl:value-of select="$company_id"/></xsl:otherwise>
		 		</xsl:choose>
						
			</xsl:element>
			
			<key_1>
			<xsl:call-template name="selectkey">
					<xsl:with-param name="key"><xsl:value-of select="//*[starts-with(name(),'key_1')]"/></xsl:with-param>
				</xsl:call-template>
			</key_1>
			<key_2>
				<xsl:call-template name="selectkey">
					<xsl:with-param name="key"><xsl:value-of select="//*[starts-with(name(),'key_2')]"/></xsl:with-param>
				</xsl:call-template>
			</key_2>
			<key_3>
				<xsl:call-template name="selectkey">
					<xsl:with-param name="key"><xsl:value-of select="//*[starts-with(name(),'key_3')]"/></xsl:with-param>
				</xsl:call-template>
			</key_3>
			<key_4>
				<xsl:call-template name="selectkey">
					<xsl:with-param name="key"><xsl:value-of select="//*[starts-with(name(),'key_4')]"/></xsl:with-param>
				</xsl:call-template>
			</key_4>
			<key_5>
			<xsl:call-template name="selectkey">
					<xsl:with-param name="key"><xsl:value-of select="//*[starts-with(name(),'key_5')]"/></xsl:with-param>
				</xsl:call-template>
			</key_5>
			<key_6>
				<xsl:call-template name="selectkey">
					<xsl:with-param name="key"><xsl:value-of select="//*[starts-with(name(),'key_6')]"/></xsl:with-param>
				</xsl:call-template>
			</key_6>
			<key_7>
				<xsl:call-template name="selectkey">
					<xsl:with-param name="key"><xsl:value-of select="//*[starts-with(name(),'key_7')]"/></xsl:with-param>
				</xsl:call-template>
			</key_7>
			<key_8>
				<xsl:call-template name="selectkey">
					<xsl:with-param name="key"><xsl:value-of select="//*[starts-with(name(),'key_8')]"/></xsl:with-param>
				</xsl:call-template>
			</key_8>
			<key_9>
				<xsl:call-template name="selectkey">
					<xsl:with-param name="key"><xsl:value-of select="//*[starts-with(name(),'key_9')]"/></xsl:with-param>
				</xsl:call-template>
			</key_9>
			<key_10>
				<xsl:call-template name="selectkey">
					<xsl:with-param name="key"><xsl:value-of select="//*[starts-with(name(),'key_10')]"/></xsl:with-param>
				</xsl:call-template>
			</key_10>
			
				<key_11>
				<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="//*[starts-with(name(),'key_11')]"/></xsl:with-param>
					</xsl:call-template>
				</key_11>
				<key_12>
					<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="//*[starts-with(name(),'key_12')]"/></xsl:with-param>
					</xsl:call-template>
				</key_12>
				<key_13>
					<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="//*[starts-with(name(),'key_13')]"/></xsl:with-param>
					</xsl:call-template>
				</key_13>
				<key_14>
					<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="//*[starts-with(name(),'key_14')]"/></xsl:with-param>
					</xsl:call-template>
				</key_14>
				<key_15>
				<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="//*[starts-with(name(),'key_15')]"/></xsl:with-param>
					</xsl:call-template>
				</key_15>
				<key_16>
					<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="//*[starts-with(name(),'key_16')]"/></xsl:with-param>
					</xsl:call-template>
				</key_16>
				<key_17>
					<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="//*[starts-with(name(),'key_17')]"/></xsl:with-param>
					</xsl:call-template>
				</key_17>
				<key_18>
					<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="//*[starts-with(name(),'key_18')]"/></xsl:with-param>
					</xsl:call-template>
				</key_18>
				<key_19>
					<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="//*[starts-with(name(),'key_19')]"/></xsl:with-param>
					</xsl:call-template>
				</key_19>
				<key_20>
					<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="//*[starts-with(name(),'key_20')]"/></xsl:with-param>
					</xsl:call-template>
				</key_20>
			
			<xsl:if test="$mutipleparam">
				<old_param_id>
					<xsl:value-of select="old_param_id"/>
				</old_param_id>
				<param_id>
					<xsl:value-of select="param_id"/>
				</param_id>
				<xsl:for-each select="data/datum">
					<data>
						<data_1>
							<xsl:call-template name="selectkey">
								<xsl:with-param name="key"><xsl:value-of select="data_1"/></xsl:with-param>
							</xsl:call-template>
						</data_1>
						<data_2>
							<xsl:call-template name="selectkey">
								<xsl:with-param name="key"><xsl:value-of select="data_2"/></xsl:with-param>
							</xsl:call-template>
						</data_2>
						<data_3>
							<xsl:call-template name="selectkey">
									<xsl:with-param name="key"><xsl:value-of select="data_3"/></xsl:with-param>
							</xsl:call-template>
						</data_3>
						<data_4>
							<xsl:call-template name="selectkey">
								<xsl:with-param name="key"><xsl:value-of select="data_4"/></xsl:with-param>
							</xsl:call-template>
						</data_4>
						<data_5>
							<xsl:call-template name="selectkey">
								<xsl:with-param name="key"><xsl:value-of select="data_5"/></xsl:with-param>
							</xsl:call-template>
						</data_5>
						<data_6>
							<xsl:call-template name="selectkey">
								<xsl:with-param name="key"><xsl:value-of select="data_6"/></xsl:with-param>
							</xsl:call-template>
						</data_6>
						<data_7>
							<xsl:call-template name="selectkey">
								<xsl:with-param name="key"><xsl:value-of select="data_7"/></xsl:with-param>
							</xsl:call-template>
						</data_7>
						<data_8>
							<xsl:call-template name="selectkey">
								<xsl:with-param name="key"><xsl:value-of select="data_8"/></xsl:with-param>
							</xsl:call-template>
						</data_8>
						<data_9>
							<xsl:call-template name="selectkey">
								<xsl:with-param name="key"><xsl:value-of select="data_9"/></xsl:with-param>
							</xsl:call-template>
						</data_9>
						<data_10>
							<xsl:call-template name="selectkey">
								<xsl:with-param name="key"><xsl:value-of select="data_10"/></xsl:with-param>
							</xsl:call-template>
						</data_10>
						<data_11>
						<xsl:call-template name="selectkey">
							<xsl:with-param name="key"><xsl:value-of select="data_11"/></xsl:with-param>
						</xsl:call-template>
						</data_11>
						<data_12>
							<xsl:call-template name="selectkey">
								<xsl:with-param name="key"><xsl:value-of select="data_12"/></xsl:with-param>
							</xsl:call-template>
						</data_12>
						<data_13>
							<xsl:call-template name="selectkey">
								<xsl:with-param name="key"><xsl:value-of select="data_13"/></xsl:with-param>
							</xsl:call-template>
						</data_13>
						<data_14>
							<xsl:call-template name="selectkey">
								<xsl:with-param name="key"><xsl:value-of select="data_14"/></xsl:with-param>
							</xsl:call-template>
						</data_14>
						<data_15>
							<xsl:call-template name="selectkey">
								<xsl:with-param name="key"><xsl:value-of select="data_15"/></xsl:with-param>
							</xsl:call-template>
						</data_15>
						<data_16>
							<xsl:call-template name="selectkey">
								<xsl:with-param name="key"><xsl:value-of select="data_16"/></xsl:with-param>
							</xsl:call-template>
						</data_16>
						<data_17>
							<xsl:call-template name="selectkey">
								<xsl:with-param name="key"><xsl:value-of select="data_17"/></xsl:with-param>
							</xsl:call-template>
						</data_17>
						<data_18>
							<xsl:call-template name="selectkey">
								<xsl:with-param name="key"><xsl:value-of select="data_18"/></xsl:with-param>
							</xsl:call-template>
						</data_18>
						<data_19>
							<xsl:call-template name="selectkey">
								<xsl:with-param name="key"><xsl:value-of select="data_19"/></xsl:with-param>
							</xsl:call-template>
						</data_19>
						<data_20>
							<xsl:call-template name="selectkey">
								<xsl:with-param name="key"><xsl:value-of select="data_20"/></xsl:with-param>
							</xsl:call-template>
						</data_20>
					</data>
				</xsl:for-each>
				</xsl:if>
			<xsl:if test="not($mutipleparam)">
				<data_1>
					<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="data_1"/></xsl:with-param>
					</xsl:call-template>
				</data_1>
				<data_2>
					<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="data_2"/></xsl:with-param>
					</xsl:call-template>
				</data_2>
				<data_3>
					<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="data_3"/></xsl:with-param>
					</xsl:call-template>
				</data_3>
				<data_4>
					<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="data_4"/></xsl:with-param>
					</xsl:call-template>
				</data_4>
				<data_5>
					<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="data_5"/></xsl:with-param>
					</xsl:call-template>
				</data_5>
				<data_6>
					<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="data_6"/></xsl:with-param>
					</xsl:call-template>
				</data_6>
				<data_7>
					<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="data_7"/></xsl:with-param>
					</xsl:call-template>
				</data_7>
				<data_8>
					<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="data_8"/></xsl:with-param>
					</xsl:call-template>
				</data_8>
				<data_9>
					<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="data_9"/></xsl:with-param>
					</xsl:call-template>
				</data_9>
				<data_10>
					<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="data_10"/></xsl:with-param>
					</xsl:call-template>
				</data_10>
				<data_11>
				<xsl:call-template name="selectkey">
					<xsl:with-param name="key"><xsl:value-of select="data_11"/></xsl:with-param>
				</xsl:call-template>
				</data_11>
				<data_12>
					<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="data_12"/></xsl:with-param>
					</xsl:call-template>
				</data_12>
				<data_13>
					<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="data_13"/></xsl:with-param>
					</xsl:call-template>
				</data_13>
				<data_14>
					<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="data_14"/></xsl:with-param>
					</xsl:call-template>
				</data_14>
				<data_15>
					<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="data_15"/></xsl:with-param>
					</xsl:call-template>
				</data_15>
				<data_16>
					<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="data_16"/></xsl:with-param>
					</xsl:call-template>
				</data_16>
				<data_17>
					<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="data_17"/></xsl:with-param>
					</xsl:call-template>
				</data_17>
				<data_18>
					<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="data_18"/></xsl:with-param>
					</xsl:call-template>
				</data_18>
				<data_19>
					<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="data_19"/></xsl:with-param>
					</xsl:call-template>
				</data_19>
				<data_20>
					<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="data_20"/></xsl:with-param>
					</xsl:call-template>
				</data_20>
			</xsl:if>
			<xsl:if test="not($mutipleparam) and $updatemode ">
				
				<!-- First identify old parameter present to identify is the data is for update or insert -->
				<xsl:element name="old_parm_id">
					<xsl:value-of select="old_parm_id"/>
				</xsl:element>
				<xsl:element name="old_company_id">
					<!-- priority given to the company id passed from client -->
					<xsl:variable name="compid"><xsl:value-of select="old_company_id"/> </xsl:variable>
					<xsl:choose>
						<xsl:when test="$compid != ''">
							<xsl:value-of select="$compid"/>
						</xsl:when>
						<xsl:otherwise><xsl:value-of select="$company_id"/></xsl:otherwise>
			 		</xsl:choose>
							
				</xsl:element>
				
				<old_key_1>
				<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="old_key_1"/></xsl:with-param>
					</xsl:call-template>
				</old_key_1>
				<old_key_2>
					<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="old_key_2"/></xsl:with-param>
					</xsl:call-template>
				</old_key_2>
				<old_key_3>
					<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="old_key_3"/></xsl:with-param>
					</xsl:call-template>
				</old_key_3>
				<old_key_4>
					<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="old_key_4"/></xsl:with-param>
					</xsl:call-template>
				</old_key_4>
				<old_key_5>
				<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="old_key_5"/></xsl:with-param>
					</xsl:call-template>
				</old_key_5>
				<old_key_6>
					<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="old_key_6"/></xsl:with-param>
					</xsl:call-template>
				</old_key_6>
				<old_key_7>
					<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="old_key_7"/></xsl:with-param>
					</xsl:call-template>
				</old_key_7>
				<old_key_8>
					<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="old_key_8"/></xsl:with-param>
					</xsl:call-template>
				</old_key_8>
				<old_key_9>
					<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="old_key_9"/></xsl:with-param>
					</xsl:call-template>
				</old_key_9>
				<old_key_10>
					<xsl:call-template name="selectkey">
						<xsl:with-param name="key"><xsl:value-of select="old_key_10"/></xsl:with-param>
					</xsl:call-template>
				</old_key_10>
			
			</xsl:if>
		</parameter_data>
	</xsl:template>
	
     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>


