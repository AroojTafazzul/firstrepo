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
<axsl:apply-templates mode="M7" select="/"/>
<axsl:apply-templates mode="M8" select="/"/>
<axsl:apply-templates mode="M9" select="/"/>
<axsl:apply-templates mode="M10" select="/"/>
<axsl:apply-templates mode="M11" select="/"/>
<axsl:apply-templates mode="M12" select="/"/>
<axsl:apply-templates mode="M13" select="/"/>
<axsl:apply-templates mode="M14" select="/"/>
<axsl:apply-templates mode="M15" select="/"/>
<axsl:apply-templates mode="M16" select="/"/>
<axsl:apply-templates mode="M17" select="/"/>
</axsl:template>
<axsl:template mode="M0" priority="4000" match="/bg_tnx_record">
<axsl:choose>
<axsl:when test="tnx_type_code = '01' or tnx_type_code = '03' or tnx_type_code = '13'"/>
<axsl:otherwise>In pattern tnx_type_code = '01' or tnx_type_code = '03' or tnx_type_code = '13':
   The transaction type code<axsl:text xml:space="preserve"> </axsl:text>
<axsl:value-of select="tnx_type_code"/>
<axsl:text xml:space="preserve"> </axsl:text>is not authorised.
</axsl:otherwise>
</axsl:choose>
<axsl:apply-templates mode="M0"/>
</axsl:template>
<axsl:template mode="M0" priority="-1" match="text()"/>
<axsl:template mode="M1" priority="4000" match="/bg_tnx_record">
<axsl:if test="tnx_type_code = '01' and          ((not(company_name) or company_name = '')          or (not(tnx_stat_code) or tnx_stat_code = '')          or (not(product_code) or product_code = '')          or (not(iss_date_type_code) or iss_date_type_code = '')          or (not(exp_date_type_code) or exp_date_type_code = '')          or (not(bg_cur_code) or bg_cur_code = '')          or (not(bg_amt) or bg_amt = '')          or (not(applicant_name) or applicant_name = '')          or (not(applicant_address_line_1) or applicant_address_line_1 = '')          or (not(beneficiary_name) or beneficiary_name = '')          or (not(beneficiary_address_line_1) or beneficiary_address_line_1 = '')          or (not(recipient_bank/abbv_name) or recipient_bank/abbv_name = '')          or (not(bg_type_code) or bg_type_code = '')          or (not(bg_text_type_code) or bg_text_type_code = ''))">In pattern tnx_type_code = '01' and ((not(company_name) or company_name = '') or (not(tnx_stat_code) or tnx_stat_code = '') or (not(product_code) or product_code = '') or (not(iss_date_type_code) or iss_date_type_code = '') or (not(exp_date_type_code) or exp_date_type_code = '') or (not(bg_cur_code) or bg_cur_code = '') or (not(bg_amt) or bg_amt = '') or (not(applicant_name) or applicant_name = '') or (not(applicant_address_line_1) or applicant_address_line_1 = '') or (not(beneficiary_name) or beneficiary_name = '') or (not(beneficiary_address_line_1) or beneficiary_address_line_1 = '') or (not(recipient_bank/abbv_name) or recipient_bank/abbv_name = '') or (not(bg_type_code) or bg_type_code = '') or (not(bg_text_type_code) or bg_text_type_code = '')):
   Some mandatory elements are missing.
</axsl:if>
<axsl:apply-templates mode="M1"/>
</axsl:template>
<axsl:template mode="M1" priority="-1" match="text()"/>
<axsl:template mode="M2" priority="4000" match="/bg_tnx_record">
<axsl:if test="tnx_type_code = '01' and          (ref_id           or bo_ref_id           or tnx_id           or company_id           or iss_date           or inp_user_id           or inp_dttm           or ctl_user_id           or ctl_dttm           or release_user_id           or release_dttm           or bo_inp_user_id           or bo_inp_dttm           or bo_ctl_user_id           or bo_ctl_dttm           or bo_release_user_id           or bo_release_dttm           or bo_comment           or amd_details           or amd_no          or amd_date          or bg_release_flag          or charges)">In pattern tnx_type_code = '01' and (ref_id or bo_ref_id or tnx_id or company_id or iss_date or inp_user_id or inp_dttm or ctl_user_id or ctl_dttm or release_user_id or release_dttm or bo_inp_user_id or bo_inp_dttm or bo_ctl_user_id or bo_ctl_dttm or bo_release_user_id or bo_release_dttm or bo_comment or amd_details or amd_no or amd_date or bg_release_flag or charges):
   A not authorised element is defined.
</axsl:if>
<axsl:apply-templates mode="M2"/>
</axsl:template>
<axsl:template mode="M2" priority="-1" match="text()"/>
<axsl:template mode="M3" priority="4000" match="/bg_tnx_record">
<axsl:if test="tnx_type_code = '01' and          (iss_date_type_code = '99' and (not(iss_date_type_details) or iss_date_type_details = ''))">In pattern tnx_type_code = '01' and (iss_date_type_code = '99' and (not(iss_date_type_details) or iss_date_type_details = '')):
   The issue date type description is mandatory.
</axsl:if>
<axsl:apply-templates mode="M3"/>
</axsl:template>
<axsl:template mode="M3" priority="-1" match="text()"/>
<axsl:template mode="M4" priority="4000" match="/bg_tnx_record">
<axsl:if test="tnx_type_code = '01' and          (exp_date_type_code != '01' and (not(exp_date) or exp_date = ''))">In pattern tnx_type_code = '01' and (exp_date_type_code != '01' and (not(exp_date) or exp_date = '')):
   The expiry date is mandatory.
</axsl:if>
<axsl:apply-templates mode="M4"/>
</axsl:template>
<axsl:template mode="M4" priority="-1" match="text()"/>
<axsl:template mode="M5" priority="4000" match="/bg_tnx_record">
<axsl:if test="tnx_type_code = '01' and          (issuing_bank_type_code = '02' and           ((not(issuing_bank/name) or issuing_bank/name = '') or (not(issuing_bank/name) or issuing_bank/name = '')))">In pattern tnx_type_code = '01' and (issuing_bank_type_code = '02' and ((not(issuing_bank/name) or issuing_bank/name = '') or (not(issuing_bank/name) or issuing_bank/name = ''))):
   The issuing bank name and address are mandatory.
</axsl:if>
<axsl:apply-templates mode="M5"/>
</axsl:template>
<axsl:template mode="M5" priority="-1" match="text()"/>
<axsl:template mode="M6" priority="4000" match="/bg_tnx_record">
<axsl:if test="tnx_type_code = '01' and          (bg_type_code = '99' and (not(bg_type_details) or bg_type_details = ''))">In pattern tnx_type_code = '01' and (bg_type_code = '99' and (not(bg_type_details) or bg_type_details = '')):
   The banker's guarantee type is mandatory.
</axsl:if>
<axsl:apply-templates mode="M6"/>
</axsl:template>
<axsl:template mode="M6" priority="-1" match="text()"/>
<axsl:template mode="M7" priority="4000" match="/bg_tnx_record">
<axsl:if test="tnx_type_code = '01' and          (bg_text_type_code = '03' and (not(bg_text_type_details) or bg_text_type_details = ''))">In pattern tnx_type_code = '01' and (bg_text_type_code = '03' and (not(bg_text_type_details) or bg_text_type_details = '')):
   The banker's guarantee text type details is mandatory.
</axsl:if>
<axsl:apply-templates mode="M7"/>
</axsl:template>
<axsl:template mode="M7" priority="-1" match="text()"/>
<axsl:template mode="M8" priority="4000" match="/bg_tnx_record">
<axsl:if test="tnx_type_code = '01' and          (bg_text_type_code = '02' and not(attachments/attachment))">In pattern tnx_type_code = '01' and (bg_text_type_code = '02' and not(attachments/attachment)):
   The banker's guarantee text type details is mandatory.
</axsl:if>
<axsl:apply-templates mode="M8"/>
</axsl:template>
<axsl:template mode="M8" priority="-1" match="text()"/>
<axsl:template mode="M9" priority="4000" match="/bg_tnx_record">
<axsl:if test="tnx_type_code = '03' and          ((not(company_name) or company_name = '')          or (not(tnx_stat_code) or tnx_stat_code = '')          or (not(product_code) or product_code = '')          or (not(sub_tnx_type_code) or sub_tnx_type_code = '')          or (not(amd_date) or amd_date = ''))">In pattern tnx_type_code = '03' and ((not(company_name) or company_name = '') or (not(tnx_stat_code) or tnx_stat_code = '') or (not(product_code) or product_code = '') or (not(sub_tnx_type_code) or sub_tnx_type_code = '') or (not(amd_date) or amd_date = '')):
   Some mandatory elements are missing.
</axsl:if>
<axsl:apply-templates mode="M9"/>
</axsl:template>
<axsl:template mode="M9" priority="-1" match="text()"/>
<axsl:template mode="M10" priority="4000" match="/bg_tnx_record">
<axsl:if test="tnx_type_code = '03' and          (template_id          or lc_ref_id          or tnx_id          or company_id          or entity          or inp_user_id           or inp_dttm           or ctl_user_id           or ctl_dttm           or release_user_id           or release_dttm           or bo_inp_user_id           or bo_inp_dttm           or bo_ctl_user_id           or bo_ctl_dttm           or bo_release_user_id           or bo_release_dttm           or appl_date          or iss_date_type_code          or iss_date_type_details          or iss_date          or amd_no          or bg_cur_code          or bg_amt          or bg_liab_amt          or bg_type_code          or bg_type_details          or bg_rule          or bg_text_type_code          or bg_text_type_details          or applicant_abbv_name          or applicant_name          or applicant_address_line_1          or applicant_address_line_2          or applicant_dom          or applicant_reference          or beneficiary_abbv_name          or beneficiary_name          or beneficiary_address_line_1          or beneficiary_address_line_2          or beneficiary_dom          or beneficiary_reference          or issuing_bank_type_code          or adv_send_mode          or contract_ref          or contract_date          or contract_amt          or contract_cur_code          or contract_pct          or bo_comment          or issuing_bank/abbv_name          or issuing_bank/name          or issuing_bank/address_line_1          or issuing_bank/address_line_2          or issuing_bank/dom          or issuing_bank/reference          or confirming_bank/abbv_name          or confirming_bank/name          or confirming_bank/address_line_1          or confirming_bank/address_line_2          or confirming_bank/dom          or confirming_bank/reference          or advising_bank/abbv_name          or advising_bank/name          or advising_bank/address_line_1          or advising_bank/address_line_2          or advising_bank/dom          or advising_bank/reference          or narrative_additional_instructions          or charges)">In pattern tnx_type_code = '03' and (template_id or lc_ref_id or tnx_id or company_id or entity or inp_user_id or inp_dttm or ctl_user_id or ctl_dttm or release_user_id or release_dttm or bo_inp_user_id or bo_inp_dttm or bo_ctl_user_id or bo_ctl_dttm or bo_release_user_id or bo_release_dttm or appl_date or iss_date_type_code or iss_date_type_details or iss_date or amd_no or bg_cur_code or bg_amt or bg_liab_amt or bg_type_code or bg_type_details or bg_rule or bg_text_type_code or bg_text_type_details or applicant_abbv_name or applicant_name or applicant_address_line_1 or applicant_address_line_2 or applicant_dom or applicant_reference or beneficiary_abbv_name or beneficiary_name or beneficiary_address_line_1 or beneficiary_address_line_2 or beneficiary_dom or beneficiary_reference or issuing_bank_type_code or adv_send_mode or contract_ref or contract_date or contract_amt or contract_cur_code or contract_pct or bo_comment or issuing_bank/abbv_name or issuing_bank/name or issuing_bank/address_line_1 or issuing_bank/address_line_2 or issuing_bank/dom or issuing_bank/reference or confirming_bank/abbv_name or confirming_bank/name or confirming_bank/address_line_1 or confirming_bank/address_line_2 or confirming_bank/dom or confirming_bank/reference or advising_bank/abbv_name or advising_bank/name or advising_bank/address_line_1 or advising_bank/address_line_2 or advising_bank/dom or advising_bank/reference or narrative_additional_instructions or charges):
   A not authorised element is defined.
</axsl:if>
<axsl:apply-templates mode="M10"/>
</axsl:template>
<axsl:template mode="M10" priority="-1" match="text()"/>
<axsl:template mode="M11" priority="4000" match="/bg_tnx_record">
<axsl:if test="tnx_type_code = '03' and          (exp_date != '' and (not(exp_date_type_code) or exp_date_type_code = ''))">In pattern tnx_type_code = '03' and (exp_date != '' and (not(exp_date_type_code) or exp_date_type_code = '')):
   The expiry date type and the expiry date must be all defined.
</axsl:if>
<axsl:apply-templates mode="M11"/>
</axsl:template>
<axsl:template mode="M11" priority="-1" match="text()"/>
<axsl:template mode="M12" priority="4000" match="/bg_tnx_record">
<axsl:if test="tnx_type_code = '03' and          (sub_tnx_type_code = '01' or sub_tnx_type_code = '02') and          (not(amd_details) or amd_details = '')">In pattern tnx_type_code = '03' and (sub_tnx_type_code = '01' or sub_tnx_type_code = '02') and (not(amd_details) or amd_details = ''):
   When increasing or decreasing the amount of the transaction, the reason for such an amendment must be given in the narrative field.
</axsl:if>
<axsl:apply-templates mode="M12"/>
</axsl:template>
<axsl:template mode="M12" priority="-1" match="text()"/>
<axsl:template mode="M13" priority="4000" match="/bg_tnx_record">
<axsl:if test="tnx_type_code = '03' and          (exp_date_type_code != '01' and (not(exp_date) or exp_date = ''))">In pattern tnx_type_code = '03' and (exp_date_type_code != '01' and (not(exp_date) or exp_date = '')):
   Check the expiry date is defined when the expiry type is None.
</axsl:if>
<axsl:apply-templates mode="M13"/>
</axsl:template>
<axsl:template mode="M13" priority="-1" match="text()"/>
<axsl:template mode="M14" priority="4000" match="/bc_tnx_record">
<axsl:if test="tnx_type_code = '03' and exp_date and         (number(concat(concat(substring(amd_date,7,4), substring(amd_date,4,2)), substring(amd_date,1,2))) &lt;         number(concat(concat(substring(exp_date,7,4), substring(exp_date,4,2)), substring(exp_date,1,2))))">In pattern tnx_type_code = '03' and exp_date and (number(concat(concat(substring(amd_date,7,4), substring(amd_date,4,2)), substring(amd_date,1,2))) &lt; number(concat(concat(substring(exp_date,7,4), substring(exp_date,4,2)), substring(exp_date,1,2)))):
   The amendment date must be prior or equal to the new expiry date.
</axsl:if>
<axsl:apply-templates mode="M14"/>
</axsl:template>
<axsl:template mode="M14" priority="-1" match="text()"/>
<axsl:template mode="M15" priority="4000" match="/bg_tnx_record">
<axsl:if test="tnx_type_code = '03' and          (exp_date_type_code != '01' and (not(exp_date) or exp_date = ''))">In pattern tnx_type_code = '03' and (exp_date_type_code != '01' and (not(exp_date) or exp_date = '')):
   Check the expiry date is defined when the expiry type is None.
</axsl:if>
<axsl:apply-templates mode="M15"/>
</axsl:template>
<axsl:template mode="M15" priority="-1" match="text()"/>
<axsl:template mode="M16" priority="4000" match="/bg_tnx_record">
<axsl:if test="tnx_type_code = '13' and          ((not(company_name) or company_name = '')          or (not(tnx_stat_code) or tnx_stat_code = '')          or (not(product_code) or product_code = '')          or (not(free_format_text) or free_format_text = ''))">In pattern tnx_type_code = '13' and ((not(company_name) or company_name = '') or (not(tnx_stat_code) or tnx_stat_code = '') or (not(product_code) or product_code = '') or (not(free_format_text) or free_format_text = '')):
   Some mandatory elements are missing.
</axsl:if>
<axsl:apply-templates mode="M16"/>
</axsl:template>
<axsl:template mode="M16" priority="-1" match="text()"/>
<axsl:template mode="M17" priority="4000" match="/bg_tnx_record">
<axsl:if test="tnx_type_code = '13' and          (template_id          or lc_ref_id          or tnx_id          or company_id          or inp_user_id           or inp_dttm           or ctl_user_id           or ctl_dttm           or release_user_id           or release_dttm           or bo_inp_user_id           or bo_inp_dttm           or bo_ctl_user_id           or bo_ctl_dttm           or bo_release_user_id           or bo_release_dttm           or appl_date          or iss_date_type_code          or iss_date_type_details          or iss_date          or exp_date_type_code          or exp_date          or amd_no          or amd_date          or tnx_cur_code          or tnx_amt          or bg_cur_code          or bg_amt          or bg_liab_amt          or bg_type_code          or bg_type_details          or bg_rule          or bg_text_type_code          or bg_text_type_details          or bg_release_flag          or applicant_abbv_name          or applicant_name          or applicant_address_line_1          or applicant_address_line_2          or applicant_dom          or applicant_reference          or beneficiary_abbv_name          or beneficiary_name          or beneficiary_address_line_1          or beneficiary_address_line_2          or beneficiary_dom          or beneficiary_reference          or issuing_bank_type_code          or adv_send_mode          or contract_ref          or contract_date          or contract_amt          or contract_cur_code          or contract_pct          or principal_act_no          or fee_act_no          or amd_details          or bg_release_flag          or bo_comment          or issuing_bank/abbv_name          or issuing_bank/name          or issuing_bank/address_line_1          or issuing_bank/address_line_2          or issuing_bank/dom          or issuing_bank/reference          or recipient_bank/abbv_name          or recipient_bank/name          or recipient_bank/address_line_1          or recipient_bank/address_line_2          or recipient_bank/dom          or recipient_bank/reference          or confirming_bank/abbv_name          or confirming_bank/name          or confirming_bank/address_line_1          or confirming_bank/address_line_2          or confirming_bank/dom          or confirming_bank/reference          or advising_bank/abbv_name          or advising_bank/name          or advising_bank/address_line_1          or advising_bank/address_line_2          or advising_bank/dom          or advising_bank/reference          or narrative_additional_instructions          or charges)">In pattern tnx_type_code = '13' and (template_id or lc_ref_id or tnx_id or company_id or inp_user_id or inp_dttm or ctl_user_id or ctl_dttm or release_user_id or release_dttm or bo_inp_user_id or bo_inp_dttm or bo_ctl_user_id or bo_ctl_dttm or bo_release_user_id or bo_release_dttm or appl_date or iss_date_type_code or iss_date_type_details or iss_date or exp_date_type_code or exp_date or amd_no or amd_date or tnx_cur_code or tnx_amt or bg_cur_code or bg_amt or bg_liab_amt or bg_type_code or bg_type_details or bg_rule or bg_text_type_code or bg_text_type_details or bg_release_flag or applicant_abbv_name or applicant_name or applicant_address_line_1 or applicant_address_line_2 or applicant_dom or applicant_reference or beneficiary_abbv_name or beneficiary_name or beneficiary_address_line_1 or beneficiary_address_line_2 or beneficiary_dom or beneficiary_reference or issuing_bank_type_code or adv_send_mode or contract_ref or contract_date or contract_amt or contract_cur_code or contract_pct or principal_act_no or fee_act_no or amd_details or bg_release_flag or bo_comment or issuing_bank/abbv_name or issuing_bank/name or issuing_bank/address_line_1 or issuing_bank/address_line_2 or issuing_bank/dom or issuing_bank/reference or recipient_bank/abbv_name or recipient_bank/name or recipient_bank/address_line_1 or recipient_bank/address_line_2 or recipient_bank/dom or recipient_bank/reference or confirming_bank/abbv_name or confirming_bank/name or confirming_bank/address_line_1 or confirming_bank/address_line_2 or confirming_bank/dom or confirming_bank/reference or advising_bank/abbv_name or advising_bank/name or advising_bank/address_line_1 or advising_bank/address_line_2 or advising_bank/dom or advising_bank/reference or narrative_additional_instructions or charges):
   A not authorised element is defined.
</axsl:if>
<axsl:apply-templates mode="M17"/>
</axsl:template>
<axsl:template mode="M17" priority="-1" match="text()"/>
<axsl:template priority="-1" match="text()"/>
</axsl:stylesheet>
