<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- Copyright (c) 2000-2011 Misys , All Rights Reserved. -->
	<xsl:template match="/">
		<xsl:apply-templates />
	</xsl:template>
	<!-- Process customer payee -->
	<xsl:template match="master_payee_record">
		<result>
			<com.misys.portal.common.payee.MasterPayeeTnx>
				<!-- keys must be attributes -->
				<xsl:attribute name="master_payee_id"><xsl:value-of select="master_payee_id" /></xsl:attribute>
				<!-- does  not change 
				<brch_code>
					<xsl:value-of select="brch_code" />
				</brch_code>
				<company_id>
					<xsl:value-of select="company_id" />
				</company_id>
				
				
				<bank_abbv_name>
					<xsl:value-of select="bank_abbv_name" />
				</bank_abbv_name>
				-->
				<payee_type>
					<xsl:value-of select="payee_type" />
				</payee_type>
				<payee_code>
					<xsl:value-of select="payee_code" />
				</payee_code>
				<payee_name>
					<xsl:value-of select="payee_name" />
				</payee_name>
				<local_payee_name>
					<xsl:value-of select="local_payee_name" />
				</local_payee_name>
				<payee_category>
					<xsl:value-of select="payee_category" />
				</payee_category>
				<service_code>
					<xsl:value-of select="service_code" />
				</service_code>
				<service_name>
					<xsl:value-of select="service_name" />
				</service_name>
				<local_service_name>
					<xsl:value-of select="local_service_name" />
				</local_service_name>
				<description>
					<xsl:value-of select="description" />
				</description>
					<local_description>
					<xsl:value-of select="local_description" />
				</local_description>
				<cur_code>
					<xsl:value-of select="base_cur_code" />
				</cur_code>
				<limit_amt>
					<xsl:value-of select="limit_amt" />
				</limit_amt>
				<end_date>
					<xsl:value-of select="end_date" />
				</end_date>
				<samp_bill_path>
					<xsl:value-of select="samp_bill_path" />
				</samp_bill_path>
				<additional_Info>
					<xsl:value-of select="additional_Info" />
				</additional_Info>
				<local_additional_Info>
					<xsl:value-of select="local_additional_Info" />
				</local_additional_Info>
				<return_comments>
					<xsl:value-of select="return_comments" />
				</return_comments>
				<!--<creation_date>
					<xsl:value-of select="creation_date" />
				</creation_date>
				<last_maintenance_date>
					<xsl:value-of select="last_maintenance_date" />
				</last_maintenance_date>
				<last_maintenance_user>
					<xsl:value-of select="last_maintenance_user" />
				</last_maintenance_user>
			-->
     <!-- Custom additional fields -->
     <xsl:call-template name="product-additional-fields"/>
     </com.misys.portal.common.payee.MasterPayeeTnx>
			<xsl:apply-templates select="master_payee_refs/master_payee_ref">
				<xsl:with-param name="payee_id"><xsl:value-of select="master_payee_id"/></xsl:with-param>
			</xsl:apply-templates>
		</result>
	</xsl:template>
	<xsl:template match="master_payee_ref">
		<xsl:param name="payee_id"></xsl:param>
			<com.misys.portal.common.payee.MasterPayeeRefTnx>
				<!-- keys must be attributes -->
				<xsl:attribute name="master_payee_id"><xsl:value-of select="$payee_id" /></xsl:attribute>
				<xsl:attribute name="reference_id"><xsl:value-of select="reference_id" /></xsl:attribute>
				<reference_seq>
					<xsl:value-of select="position()" />
				</reference_seq>
				<label>
					<xsl:value-of select="label" />
				</label>
				<local_label>
					<xsl:value-of select="local_label" />
				</local_label>
				<help_message>
					<xsl:value-of select="help_message" />
				</help_message>
				<local_help_message>
					<xsl:value-of select="local_help_message" />
				</local_help_message>
				<optional>
					<xsl:value-of select="optional" />
				</optional>
				<validation_format>
					<xsl:value-of select="validation_format" />
				</validation_format>
				<external_validation>
					<xsl:value-of select="external_validation" />
				</external_validation>
				<input_in_type>
					<xsl:value-of select="input_in_type" />
				</input_in_type>
				<field_type>
					<xsl:value-of select="field_type" />
				</field_type>
				
		</com.misys.portal.common.payee.MasterPayeeRefTnx>
	</xsl:template>
	

     <xsl:template name="product-additional-fields"/>
     </xsl:stylesheet>

