<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<axsl:stylesheet xmlns:axsl="http://www.w3.org/1999/XSL/Transform" xmlns:sch="http://www.ascc.net/xml/schematron" version="1.0">
<axsl:output method="text"/>
<axsl:template mode="schematron-get-full-path" match="*|@*">
<axsl:apply-templates mode="schematron-get-full-path" select="parent::*"/>
<axsl:text>/</axsl:text>
<axsl:if test="count(. | ../@*) = count(../@*)">@</axsl:if>
<axsl:value-of select="name()"/>
<axsl:text>[</axsl:text>
<axsl:value-of select="1+count(preceding-sibling::*[name()=name(current())])"/>
<axsl:text>]</axsl:text>
</axsl:template>
<axsl:template match="/">
<axsl:apply-templates mode="M0" select="/"/>
<axsl:apply-templates mode="M1" select="/"/>
<axsl:apply-templates mode="M2" select="/"/>
<axsl:apply-templates mode="M3" select="/"/>
<axsl:apply-templates mode="M4" select="/"/>
<axsl:apply-templates mode="M5" select="/"/>
<axsl:apply-templates mode="M6" select="/"/>
</axsl:template>
<axsl:template mode="M0" priority="4000" match="/tf_tnx_record">
<axsl:choose>
<axsl:when test="tnx_type_code = '01' or tnx_type_code = '13'"/>
<axsl:otherwise>In pattern tnx_type_code = '01' or tnx_type_code = '13':
   The transaction type code<axsl:text xml:space="preserve"> </axsl:text>
<axsl:value-of select="tnx_type_code"/>
<axsl:text xml:space="preserve"> </axsl:text>is not authorised.
</axsl:otherwise>
</axsl:choose>
<axsl:apply-templates mode="M0"/>
</axsl:template>
<axsl:template mode="M0" priority="-1" match="text()"/>
<axsl:template mode="M1" priority="4000" match="/tf_tnx_record">
<axsl:if test="tnx_type_code = '01' and          ((not(company_name) or company_name = '')          or (not(tnx_stat_code) or tnx_stat_code = '')          or (not(product_code) or product_code = '')          or (not(appl_date) or appl_date = '')          or (not(tenor) or tenor = '')          or (not(maturity_date) or maturity_date = '')          or (not(fin_type) or fin_type = '')          or (not(applicant_name) or applicant_name = '')          or (not(applicant_address_line_1) or applicant_address_line_1 = '')          or (not(issuing_bank/abbv_name) or issuing_bank/abbv_name = '')          or (not(fin_cur_code) or fin_cur_code = '')          or (not(fin_amt) or fin_amt = ''))">In pattern tnx_type_code = '01' and ((not(company_name) or company_name = '') or (not(tnx_stat_code) or tnx_stat_code = '') or (not(product_code) or product_code = '') or (not(appl_date) or appl_date = '') or (not(tenor) or tenor = '') or (not(maturity_date) or maturity_date = '') or (not(fin_type) or fin_type = '') or (not(applicant_name) or applicant_name = '') or (not(applicant_address_line_1) or applicant_address_line_1 = '') or (not(issuing_bank/abbv_name) or issuing_bank/abbv_name = '') or (not(fin_cur_code) or fin_cur_code = '') or (not(fin_amt) or fin_amt = '')):
   Some mandatory elements are missing.
</axsl:if>
<axsl:apply-templates mode="M1"/>
</axsl:template>
<axsl:template mode="M1" priority="-1" match="text()"/>
<axsl:template mode="M2" priority="4000" match="/tf_tnx_record">
<axsl:if test="tnx_type_code = '01' and          (ref_id           or bo_ref_id           or tnx_id           or company_id           or iss_date          or inp_user_id           or inp_dttm           or ctl_user_id           or ctl_dttm           or release_user_id           or release_dttm           or bo_inp_user_id           or bo_inp_dttm           or bo_ctl_user_id           or bo_ctl_dttm           or bo_release_user_id           or bo_release_dttm           or bo_comment           or charges)">In pattern tnx_type_code = '01' and (ref_id or bo_ref_id or tnx_id or company_id or iss_date or inp_user_id or inp_dttm or ctl_user_id or ctl_dttm or release_user_id or release_dttm or bo_inp_user_id or bo_inp_dttm or bo_ctl_user_id or bo_ctl_dttm or bo_release_user_id or bo_release_dttm or bo_comment or charges):
   A not authorised element is defined.
</axsl:if>
<axsl:apply-templates mode="M2"/>
</axsl:template>
<axsl:template mode="M2" priority="-1" match="text()"/>
<axsl:template mode="M3" priority="4000" match="/tf_tnx_record">
<axsl:if test="tnx_type_code = '01' and          (number(concat(concat(substring(maturity_date,7,4), substring(maturity_date,4,2)), substring(maturity_date,1,2))) &lt;         number(concat(concat(substring(iss_date,7,4), substring(iss_date,4,2)), substring(iss_date,1,2))))">In pattern tnx_type_code = '01' and (number(concat(concat(substring(maturity_date,7,4), substring(maturity_date,4,2)), substring(maturity_date,1,2))) &lt; number(concat(concat(substring(iss_date,7,4), substring(iss_date,4,2)), substring(iss_date,1,2)))):
   The issue date must be prior or equal to the maturity date.
</axsl:if>
<axsl:apply-templates mode="M3"/>
</axsl:template>
<axsl:template mode="M3" priority="-1" match="text()"/>
<axsl:template mode="M4" priority="4000" match="/tf_tnx_record">
<axsl:if test="tnx_type_code = '01' and          (number(concat(concat(substring(maturity_date,7,4), substring(maturity_date,4,2)), substring(maturity_date,1,2))) &lt;         number(concat(concat(substring(appl_date,7,4), substring(appl_date,4,2)), substring(appl_date,1,2))))">In pattern tnx_type_code = '01' and (number(concat(concat(substring(maturity_date,7,4), substring(maturity_date,4,2)), substring(maturity_date,1,2))) &lt; number(concat(concat(substring(appl_date,7,4), substring(appl_date,4,2)), substring(appl_date,1,2)))):
   The maturity date must be posterior or equal to the application date.
</axsl:if>
<axsl:apply-templates mode="M4"/>
</axsl:template>
<axsl:template mode="M4" priority="-1" match="text()"/>
<axsl:template mode="M5" priority="4000" match="/tf_tnx_record">
<axsl:if test="tnx_type_code = '13' and          ((not(company_name) or company_name = '')          or (not(tnx_stat_code) or tnx_stat_code = '')          or (not(product_code) or product_code = '')          or (not(free_format_text) or free_format_text = ''))">In pattern tnx_type_code = '13' and ((not(company_name) or company_name = '') or (not(tnx_stat_code) or tnx_stat_code = '') or (not(product_code) or product_code = '') or (not(free_format_text) or free_format_text = '')):
   Some mandatory elements are missing.
</axsl:if>
<axsl:apply-templates mode="M5"/>
</axsl:template>
<axsl:template mode="M5" priority="-1" match="text()"/>
<axsl:template mode="M6" priority="4000" match="/tf_tnx_record">
<axsl:if test="tnx_type_code = '13' and          (template_id          or tnx_id          or company_id          or tnx_id          or imp_bill_ref_id          or entity          or inp_user_id           or inp_dttm           or ctl_user_id           or ctl_dttm           or release_user_id           or release_dttm           or bo_inp_user_id           or bo_inp_dttm           or bo_ctl_user_id           or bo_ctl_dttm           or bo_release_user_id           or bo_release_dttm           or appl_date           or tnx_cur_code           or tnx_amt           or fin_cur_code           or fin_amt           or fin_liab_am           or fin_type           or applicant_abbv_name          or applicant_name          or applicant_address_line_1          or applicant_address_line_2          or applicant_dom          or applicant_reference          or principal_act_no          or fee_act_no          or bo_comment          or iss_date          or tenor          or maturity_date          or goods_desc          or charges)">In pattern tnx_type_code = '13' and (template_id or tnx_id or company_id or tnx_id or imp_bill_ref_id or entity or inp_user_id or inp_dttm or ctl_user_id or ctl_dttm or release_user_id or release_dttm or bo_inp_user_id or bo_inp_dttm or bo_ctl_user_id or bo_ctl_dttm or bo_release_user_id or bo_release_dttm or appl_date or tnx_cur_code or tnx_amt or fin_cur_code or fin_amt or fin_liab_am or fin_type or applicant_abbv_name or applicant_name or applicant_address_line_1 or applicant_address_line_2 or applicant_dom or applicant_reference or principal_act_no or fee_act_no or bo_comment or iss_date or tenor or maturity_date or goods_desc or charges):
   A not authorised element is defined.
</axsl:if>
<axsl:apply-templates mode="M6"/>
</axsl:template>
<axsl:template mode="M6" priority="-1" match="text()"/>
<axsl:template priority="-1" match="text()"/>
</axsl:stylesheet>
