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
<axsl:apply-templates mode="M18" select="/"/>
<axsl:apply-templates mode="M19" select="/"/>
<axsl:apply-templates mode="M20" select="/"/>
<axsl:apply-templates mode="M21" select="/"/>
<axsl:apply-templates mode="M22" select="/"/>
<axsl:apply-templates mode="M23" select="/"/>
<axsl:apply-templates mode="M24" select="/"/>
<axsl:apply-templates mode="M25" select="/"/>
<axsl:apply-templates mode="M26" select="/"/>
<axsl:apply-templates mode="M27" select="/"/>
<axsl:apply-templates mode="M28" select="/"/>
</axsl:template>
<axsl:template mode="M0" priority="4000" match="/lc_tnx_record">
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
<axsl:template mode="M1" priority="4000" match="/lc_tnx_record">
<axsl:choose>
<axsl:when test="tnx_stat_code = '01' or tnx_stat_code = '02' or tnx_stat_code = '03'"/>
<axsl:otherwise>In pattern tnx_stat_code = '01' or tnx_stat_code = '02' or tnx_stat_code = '03':
   The transaction status code<axsl:text xml:space="preserve"> </axsl:text>
<axsl:value-of select="tnx_stat_code"/>
<axsl:text xml:space="preserve"> </axsl:text>is not authorised.
</axsl:otherwise>
</axsl:choose>
<axsl:apply-templates mode="M1"/>
</axsl:template>
<axsl:template mode="M1" priority="-1" match="text()"/>
<axsl:template mode="M2" priority="4000" match="/lc_tnx_record">
<axsl:if test="tnx_type_code = '01' and           tnx_stat_code = '01' and          ((not(company_name) or company_name = '')          or (not(product_code) or product_code = '')          or (not(appl_date) or appl_date = ''))">In pattern tnx_type_code = '01' and tnx_stat_code = '01' and ((not(company_name) or company_name = '') or (not(product_code) or product_code = '') or (not(appl_date) or appl_date = '')):
   Some mandatory elements are missing (incomplete mode).
</axsl:if>
<axsl:apply-templates mode="M2"/>
</axsl:template>
<axsl:template mode="M2" priority="-1" match="text()"/>
<axsl:template mode="M3" priority="4000" match="/lc_tnx_record">
<axsl:if test="tnx_type_code = '01' and           (tnx_stat_code = '02' or tnx_stat_code = '03') and          ((not(company_name) or company_name = '')          or (not(product_code) or product_code = '')          or (not(appl_date) or appl_date = '')          or (not(exp_date) or exp_date = '')          or (not(expiry_place) or expiry_place = '')          or (not(lc_cur_code) or lc_cur_code = '')          or (not(lc_amt) or lc_amt = '')          or (not(applicable_rules) or applicable_rules = '')          or (not(applicant_name) or applicant_name = '')          or (not(applicant_address_line_1) or applicant_address_line_1 = '')          or (not(beneficiary_name) or beneficiary_name = '')          or (not(beneficiary_address_line_1) or beneficiary_address_line_1 = '')          or (not(cr_avl_by_code) or cr_avl_by_code = '')          or (not(issuing_bank/abbv_name) or issuing_bank/abbv_name = '')          or (not(credit_available_with_bank/name) or credit_available_with_bank/name = '')          or (not(narrative_description_goods) or narrative_description_goods = '')          or (not(narrative_documents_required) or narrative_documents_required = '')          or (not(adv_send_mode) or adv_send_mode = ''))">In pattern tnx_type_code = '01' and (tnx_stat_code = '02' or tnx_stat_code = '03') and ((not(company_name) or company_name = '') or (not(product_code) or product_code = '') or (not(appl_date) or appl_date = '') or (not(exp_date) or exp_date = '') or (not(expiry_place) or expiry_place = '') or (not(lc_cur_code) or lc_cur_code = '') or (not(lc_amt) or lc_amt = '') or (not(applicable_rules) or applicable_rules = '') or (not(applicant_name) or applicant_name = '') or (not(applicant_address_line_1) or applicant_address_line_1 = '') or (not(beneficiary_name) or beneficiary_name = '') or (not(beneficiary_address_line_1) or beneficiary_address_line_1 = '') or (not(cr_avl_by_code) or cr_avl_by_code = '') or (not(issuing_bank/abbv_name) or issuing_bank/abbv_name = '') or (not(credit_available_with_bank/name) or credit_available_with_bank/name = '') or (not(narrative_description_goods) or narrative_description_goods = '') or (not(narrative_documents_required) or narrative_documents_required = '') or (not(adv_send_mode) or adv_send_mode = '')):
   Some mandatory elements are missing (uncontrolled/controlled mode).
</axsl:if>
<axsl:apply-templates mode="M3"/>
</axsl:template>
<axsl:template mode="M3" priority="-1" match="text()"/>
<axsl:template mode="M4" priority="4000" match="/lc_tnx_record">
<axsl:if test="tnx_type_code = '01' and          (ref_id           or bo_ref_id           or tnx_id           or company_id           or imp_bill_ref_id           or iss_date          or inp_user_id           or inp_dttm           or ctl_user_id           or ctl_dttm           or release_user_id           or release_dttm           or bo_inp_user_id           or bo_inp_dttm           or bo_ctl_user_id           or bo_ctl_dttm           or bo_release_user_id           or bo_release_dttm           or bo_comment           or amd_details           or amd_no          or amd_date          or narrative_full_details           or charges)">In pattern tnx_type_code = '01' and (ref_id or bo_ref_id or tnx_id or company_id or imp_bill_ref_id or iss_date or inp_user_id or inp_dttm or ctl_user_id or ctl_dttm or release_user_id or release_dttm or bo_inp_user_id or bo_inp_dttm or bo_ctl_user_id or bo_ctl_dttm or bo_release_user_id or bo_release_dttm or bo_comment or amd_details or amd_no or amd_date or narrative_full_details or charges):
   A not authorised element is defined.
</axsl:if>
<axsl:apply-templates mode="M4"/>
</axsl:template>
<axsl:template mode="M4" priority="-1" match="text()"/>
<axsl:template mode="M5" priority="4000" match="/lc_tnx_record">
<axsl:if test="tnx_type_code = '01' and (tnx_stat_code = '02' or tnx_stat_code = '03') and          ((cr_avl_by_code = '04' or cr_avl_by_code = '05')           and (not(draft_term) or draft_term = ''))">In pattern tnx_type_code = '01' and (tnx_stat_code = '02' or tnx_stat_code = '03') and ((cr_avl_by_code = '04' or cr_avl_by_code = '05') and (not(draft_term) or draft_term = '')):
   The draft term must be defined if the credit is available by deferred or mixed payment.
</axsl:if>
<axsl:apply-templates mode="M5"/>
</axsl:template>
<axsl:template mode="M5" priority="-1" match="text()"/>
<axsl:template mode="M6" priority="4000" match="/lc_tnx_record">
<axsl:if test="tnx_type_code = '01' and (tnx_stat_code = '02' or tnx_stat_code = '03') and          ((cr_avl_by_code = '02' or cr_avl_by_code = '03')           and ((not(draft_term) or draft_term = '')            or (not(drawee_details_bank/name) or drawee_details_bank_name = '')))">In pattern tnx_type_code = '01' and (tnx_stat_code = '02' or tnx_stat_code = '03') and ((cr_avl_by_code = '02' or cr_avl_by_code = '03') and ((not(draft_term) or draft_term = '') or (not(drawee_details_bank/name) or drawee_details_bank_name = ''))):
   The draft term and drawee details bank must be defined if the credit is available by acceptance or negociation.
</axsl:if>
<axsl:apply-templates mode="M6"/>
</axsl:template>
<axsl:template mode="M6" priority="-1" match="text()"/>
<axsl:template mode="M7" priority="4000" match="/lc_tnx_record">
<axsl:if test="tnx_type_code = '01' and cr_avl_by_code = '01' and draft_term != ''">In pattern tnx_type_code = '01' and cr_avl_by_code = '01' and draft_term != '':
   The draft term must not be defined if the credit is available by payment.
</axsl:if>
<axsl:apply-templates mode="M7"/>
</axsl:template>
<axsl:template mode="M7" priority="-1" match="text()"/>
<axsl:template mode="M8" priority="4000" match="/lc_tnx_record">
<axsl:if test="tnx_type_code = '01' and (tnx_stat_code = '02' or tnx_stat_code = '03') and          (inco_term != '' and (not(inco_place) or inco_place = ''))">In pattern tnx_type_code = '01' and (tnx_stat_code = '02' or tnx_stat_code = '03') and (inco_term != '' and (not(inco_place) or inco_place = '')):
   The named place associated with the incoterm must be defined if an incoterm exists.
</axsl:if>
<axsl:apply-templates mode="M8"/>
</axsl:template>
<axsl:template mode="M8" priority="-1" match="text()"/>
<axsl:template mode="M9" priority="4000" match="/lc_tnx_record">
<axsl:if test="tnx_type_code = '01' and (tnx_stat_code = '02' or tnx_stat_code = '03') and          ((not(last_ship_date) or last_ship_date = '')           and (not(narrative_shipment_period) or narrative_shipment_period = ''))">In pattern tnx_type_code = '01' and (tnx_stat_code = '02' or tnx_stat_code = '03') and ((not(last_ship_date) or last_ship_date = '') and (not(narrative_shipment_period) or narrative_shipment_period = '')):
   The last shipment date or the shipment period must be defined.
</axsl:if>
<axsl:apply-templates mode="M9"/>
</axsl:template>
<axsl:template mode="M9" priority="-1" match="text()"/>
<axsl:template mode="M10" priority="4000" match="/lc_tnx_record">
<axsl:if test="tnx_type_code = '01' and          (last_ship_date != '' and narrative_shipment_period != '')">In pattern tnx_type_code = '01' and (last_ship_date != '' and narrative_shipment_period != ''):
   The last shipment date and the shipment period are mutually exclusive.
</axsl:if>
<axsl:apply-templates mode="M10"/>
</axsl:template>
<axsl:template mode="M10" priority="-1" match="text()"/>
<axsl:template mode="M11" priority="4000" match="/lc_tnx_record">
<axsl:if test="tnx_type_code = '01' and         (number(concat(concat(substring(appl_date,7,4), substring(appl_date,4,2)), substring(appl_date,1,2))) &lt;         number(concat(concat(substring(iss_date,7,4), substring(iss_date,4,2)), substring(iss_date,1,2))))">In pattern tnx_type_code = '01' and (number(concat(concat(substring(appl_date,7,4), substring(appl_date,4,2)), substring(appl_date,1,2))) &lt; number(concat(concat(substring(iss_date,7,4), substring(iss_date,4,2)), substring(iss_date,1,2)))):
   The issue date must be posterior or equal to the application date.
</axsl:if>
<axsl:apply-templates mode="M11"/>
</axsl:template>
<axsl:template mode="M11" priority="-1" match="text()"/>
<axsl:template mode="M12" priority="4000" match="/lc_tnx_record">
<axsl:if test="tnx_type_code = '01' and         (number(concat(concat(substring(exp_date,7,4), substring(exp_date,4,2)), substring(exp_date,1,2))) &lt;         number(concat(concat(substring(iss_date,7,4), substring(iss_date,4,2)), substring(iss_date,1,2))))">In pattern tnx_type_code = '01' and (number(concat(concat(substring(exp_date,7,4), substring(exp_date,4,2)), substring(exp_date,1,2))) &lt; number(concat(concat(substring(iss_date,7,4), substring(iss_date,4,2)), substring(iss_date,1,2)))):
   The issue date must be prior or equal to the expiry date.
</axsl:if>
<axsl:apply-templates mode="M12"/>
</axsl:template>
<axsl:template mode="M12" priority="-1" match="text()"/>
<axsl:template mode="M13" priority="4000" match="/lc_tnx_record">
<axsl:if test="tnx_type_code = '01' and last_ship_date != '' and         (number(concat(concat(substring(last_ship_date,7,4), substring(last_ship_date,4,2)), substring(last_ship_date,1,2))) &lt;         number(concat(concat(substring(appl_date,7,4), substring(appl_date,4,2)), substring(appl_date,1,2))))">In pattern tnx_type_code = '01' and last_ship_date != '' and (number(concat(concat(substring(last_ship_date,7,4), substring(last_ship_date,4,2)), substring(last_ship_date,1,2))) &lt; number(concat(concat(substring(appl_date,7,4), substring(appl_date,4,2)), substring(appl_date,1,2)))):
   The last shipment date must be posterior or equal to the application date.
</axsl:if>
<axsl:apply-templates mode="M13"/>
</axsl:template>
<axsl:template mode="M13" priority="-1" match="text()"/>
<axsl:template mode="M14" priority="4000" match="/lc_tnx_record">
<axsl:if test="tnx_type_code = '01' and last_ship_date != '' and         (number(concat(concat(substring(exp_date,7,4), substring(exp_date,4,2)), substring(exp_date,1,2))) &lt;         number(concat(concat(substring(appl_date,7,4), substring(appl_date,4,2)), substring(appl_date,1,2))))">In pattern tnx_type_code = '01' and last_ship_date != '' and (number(concat(concat(substring(exp_date,7,4), substring(exp_date,4,2)), substring(exp_date,1,2))) &lt; number(concat(concat(substring(appl_date,7,4), substring(appl_date,4,2)), substring(appl_date,1,2)))):
   The expiry date must be posterior or equal to the applicaton date.
</axsl:if>
<axsl:apply-templates mode="M14"/>
</axsl:template>
<axsl:template mode="M14" priority="-1" match="text()"/>
<axsl:template mode="M15" priority="4000" match="/lc_tnx_record">
<axsl:if test="tnx_type_code = '01' and last_ship_date != '' and         (number(concat(concat(substring(exp_date,7,4), substring(exp_date,4,2)), substring(exp_date,1,2))) &lt;         number(concat(concat(substring(last_ship_date,7,4), substring(last_ship_date,4,2)), substring(last_ship_date,1,2))))">In pattern tnx_type_code = '01' and last_ship_date != '' and (number(concat(concat(substring(exp_date,7,4), substring(exp_date,4,2)), substring(exp_date,1,2))) &lt; number(concat(concat(substring(last_ship_date,7,4), substring(last_ship_date,4,2)), substring(last_ship_date,1,2)))):
   The expiry date must be posterior or equal to the last shipment date.
</axsl:if>
<axsl:apply-templates mode="M15"/>
</axsl:template>
<axsl:template mode="M15" priority="-1" match="text()"/>
<axsl:template mode="M16" priority="4000" match="/lc_tnx_record">
<axsl:if test="tnx_type_code = '01' and          (irv_flag = 'N' and ntrf_flag = 'N' and stnd_by_lc_flag = 'Y')">In pattern tnx_type_code = '01' and (irv_flag = 'N' and ntrf_flag = 'N' and stnd_by_lc_flag = 'Y'):
   A standby LC must be irrevocable to be transferrable.
</axsl:if>
<axsl:apply-templates mode="M16"/>
</axsl:template>
<axsl:template mode="M16" priority="-1" match="text()"/>
<axsl:template mode="M17" priority="4000" match="/lc_tnx_record">
<axsl:if test="tnx_type_code = '01' and          (max_cr_desc_code != '' and (neg_tol_pct != '' or pstv_tol_pct != ''))">In pattern tnx_type_code = '01' and (max_cr_desc_code != '' and (neg_tol_pct != '' or pstv_tol_pct != '')):
   The positive or negative tolerances and the maximum credit amount are mutually exclusive.
</axsl:if>
<axsl:apply-templates mode="M17"/>
</axsl:template>
<axsl:template mode="M17" priority="-1" match="text()"/>
<axsl:template mode="M18" priority="4000" match="/lc_tnx_record">
<axsl:if test="tnx_type_code = '03' and          ((not(company_name) or company_name = '')          or (not(tnx_stat_code) or tnx_stat_code = '')          or (not(product_code) or product_code = '')          or (not(sub_tnx_type_code) or sub_tnx_type_code = '')          or (not(exp_date) or exp_date = '')          or (not(amd_date) or amd_date = '')          or (not(adv_send_mode) or adv_send_mode = ''))">In pattern tnx_type_code = '03' and ((not(company_name) or company_name = '') or (not(tnx_stat_code) or tnx_stat_code = '') or (not(product_code) or product_code = '') or (not(sub_tnx_type_code) or sub_tnx_type_code = '') or (not(exp_date) or exp_date = '') or (not(amd_date) or amd_date = '') or (not(adv_send_mode) or adv_send_mode = '')):
   Some mandatory elements are missing.
</axsl:if>
<axsl:apply-templates mode="M18"/>
</axsl:template>
<axsl:template mode="M18" priority="-1" match="text()"/>
<axsl:template mode="M19" priority="4000" match="/lc_tnx_record">
<axsl:if test="tnx_type_code = '03' and          (template_id          or tnx_id          or company_id          or imp_bill_ref_id          or entity          or inp_user_id           or inp_dttm           or ctl_user_id           or ctl_dttm           or release_user_id           or release_dttm           or bo_inp_user_id           or bo_inp_dttm           or bo_ctl_user_id           or bo_ctl_dttm           or bo_release_user_id           or bo_release_dttm           or appl_date          or iss_date          or amd_no          or lc_cur_code          or lc_amt          or lc_liab_amt          or beneficiary_abbv_name          or beneficiary_name          or beneficiary_address_line_1          or beneficiary_address_line_2          or beneficiary_dom          or beneficiary_reference          or applicant_abbv_name          or applicant_name          or applicant_address_line_1          or applicant_address_line_2          or applicant_dom          or applicant_reference          or expiry_place          or inco_term          or inco_place          or part_ship_detl          or tran_ship_detl          or draft_term          or cty_of_dest          or rvlv_lc_type_code          or max_no_of_rvlv          or cr_avl_by_code          or dir_reim_flag          or irv_flag          or ntrf_flag          or stnd_by_lc_flag          or cfm_inst_code          or cfm_flag          or cfm_chrg_brn_by_code          or corr_chrg_brn_by_code          or open_chrg_brn_by_code          or bo_comment          or eucp_flag          or eucp_version          or eucp_presentation_place          or advising_bank/abbv_name          or advising_bank/name          or advising_bank/address_line_1          or advising_bank/address_line_2          or advising_bank/dom          or advising_bank/reference          or advise_thru_bank/abbv_name          or advise_thru_bank/name          or advise_thru_bank/address_line_1          or advise_thru_bank/address_line_2          or advise_thru_bank/dom          or advise_thru_bank/reference          or credit_available_with_bank/abbv_name          or credit_available_with_bank/name          or credit_available_with_bank/address_line_1          or credit_available_with__bank/address_line_2          or credit_available_with__bank/dom          or credit_available_with__bank/reference          or drawee_details_bank/abbv_name          or drawee_details_bank/name          or drawee_details_bank/address_line_1          or drawee_details_bank/address_line_2          or drawee_details_bank/dom          or drawee_details_bank/reference          or narrative_description_goods          or narrative_documents_required          or narrative_additional_instructions          or narrative_charges          or narrative_payment_instructions          or narrative_period_presentation          or narrative_sender_to_receiver          or narrative_full_details          or charges)">In pattern tnx_type_code = '03' and (template_id or tnx_id or company_id or imp_bill_ref_id or entity or inp_user_id or inp_dttm or ctl_user_id or ctl_dttm or release_user_id or release_dttm or bo_inp_user_id or bo_inp_dttm or bo_ctl_user_id or bo_ctl_dttm or bo_release_user_id or bo_release_dttm or appl_date or iss_date or amd_no or lc_cur_code or lc_amt or lc_liab_amt or beneficiary_abbv_name or beneficiary_name or beneficiary_address_line_1 or beneficiary_address_line_2 or beneficiary_dom or beneficiary_reference or applicant_abbv_name or applicant_name or applicant_address_line_1 or applicant_address_line_2 or applicant_dom or applicant_reference or expiry_place or inco_term or inco_place or part_ship_detl or tran_ship_detl or draft_term or cty_of_dest or rvlv_lc_type_code or max_no_of_rvlv or cr_avl_by_code or dir_reim_flag or irv_flag or ntrf_flag or stnd_by_lc_flag or cfm_inst_code or cfm_flag or cfm_chrg_brn_by_code or corr_chrg_brn_by_code or open_chrg_brn_by_code or bo_comment or eucp_flag or eucp_version or eucp_presentation_place or advising_bank/abbv_name or advising_bank/name or advising_bank/address_line_1 or advising_bank/address_line_2 or advising_bank/dom or advising_bank/reference or advise_thru_bank/abbv_name or advise_thru_bank/name or advise_thru_bank/address_line_1 or advise_thru_bank/address_line_2 or advise_thru_bank/dom or advise_thru_bank/reference or credit_available_with_bank/abbv_name or credit_available_with_bank/name or credit_available_with_bank/address_line_1 or credit_available_with__bank/address_line_2 or credit_available_with__bank/dom or credit_available_with__bank/reference or drawee_details_bank/abbv_name or drawee_details_bank/name or drawee_details_bank/address_line_1 or drawee_details_bank/address_line_2 or drawee_details_bank/dom or drawee_details_bank/reference or narrative_description_goods or narrative_documents_required or narrative_additional_instructions or narrative_charges or narrative_payment_instructions or narrative_period_presentation or narrative_sender_to_receiver or narrative_full_details or charges):
   A not authorised element is defined.
</axsl:if>
<axsl:apply-templates mode="M19"/>
</axsl:template>
<axsl:template mode="M19" priority="-1" match="text()"/>
<axsl:template mode="M20" priority="4000" match="/lc_tnx_record">
<axsl:if test="tnx_type_code = '03' and          (          (max_cr_desc_code != '' and (not(neg_tol_pct) or not(pstv_tol_pct))) or          (neg_tol_pct != '' and (not(max_cr_desc_code) or not(pstv_tol_pct))) or          (pstv_tol_pct != '' and (not(max_cr_desc_code) or not(neg_tol_pct)))          )">In pattern tnx_type_code = '03' and ( (max_cr_desc_code != '' and (not(neg_tol_pct) or not(pstv_tol_pct))) or (neg_tol_pct != '' and (not(max_cr_desc_code) or not(pstv_tol_pct))) or (pstv_tol_pct != '' and (not(max_cr_desc_code) or not(neg_tol_pct))) ):
   The maximum credit description, negative tolerance and positive tolerance must all be defined.
</axsl:if>
<axsl:apply-templates mode="M20"/>
</axsl:template>
<axsl:template mode="M20" priority="-1" match="text()"/>
<axsl:template mode="M21" priority="4000" match="/lc_tnx_record">
<axsl:if test="tnx_type_code = '03' and          (          (last_ship_date != '' and not(narrative_shipment_period)) or          (narrative_shipment_period != '' and not(last_ship_date))          )">In pattern tnx_type_code = '03' and ( (last_ship_date != '' and not(narrative_shipment_period)) or (narrative_shipment_period != '' and not(last_ship_date)) ):
   The last shipment date and shipment period must all be defined.
</axsl:if>
<axsl:apply-templates mode="M21"/>
</axsl:template>
<axsl:template mode="M21" priority="-1" match="text()"/>
<axsl:template mode="M22" priority="4000" match="/lc_tnx_record">
<axsl:if test="tnx_type_code = '03' and          (number(concat(concat(substring(amd_date,7,4), substring(amd_date,4,2)), substring(amd_date,1,2))) &lt;         number(concat(concat(substring(exp_date,7,4), substring(exp_date,4,2)), substring(exp_date,1,2))))">In pattern tnx_type_code = '03' and (number(concat(concat(substring(amd_date,7,4), substring(amd_date,4,2)), substring(amd_date,1,2))) &lt; number(concat(concat(substring(exp_date,7,4), substring(exp_date,4,2)), substring(exp_date,1,2)))):
   The amendment date must be prior or equal to the expiry date.
</axsl:if>
<axsl:apply-templates mode="M22"/>
</axsl:template>
<axsl:template mode="M22" priority="-1" match="text()"/>
<axsl:template mode="M23" priority="4000" match="/lc_tnx_record">
<axsl:if test="tnx_type_code = '03' and last_ship_date != '' and         (number(concat(concat(substring(exp_date,7,4), substring(exp_date,4,2)), substring(exp_date,1,2))) &lt;         number(concat(concat(substring(last_ship_date,7,4), substring(last_ship_date,4,2)), substring(last_ship_date,1,2))))">In pattern tnx_type_code = '03' and last_ship_date != '' and (number(concat(concat(substring(exp_date,7,4), substring(exp_date,4,2)), substring(exp_date,1,2))) &lt; number(concat(concat(substring(last_ship_date,7,4), substring(last_ship_date,4,2)), substring(last_ship_date,1,2)))):
   The expiry date must be posterior or equal to the last shipment date.
</axsl:if>
<axsl:apply-templates mode="M23"/>
</axsl:template>
<axsl:template mode="M23" priority="-1" match="text()"/>
<axsl:template mode="M24" priority="4000" match="/lc_tnx_record">
<axsl:if test="tnx_type_code = '03' and           (last_ship_date != '' and narrative_shipment_period != '')">In pattern tnx_type_code = '03' and (last_ship_date != '' and narrative_shipment_period != ''):
   The last shipment date and the shipment period are mutually exclusive.
</axsl:if>
<axsl:apply-templates mode="M24"/>
</axsl:template>
<axsl:template mode="M24" priority="-1" match="text()"/>
<axsl:template mode="M25" priority="4000" match="/lc_tnx_record">
<axsl:if test="tnx_type_code = '03' and           (max_cr_desc_code != '' and (neg_tol_pct != '' or pstv_tol_pct != ''))">In pattern tnx_type_code = '03' and (max_cr_desc_code != '' and (neg_tol_pct != '' or pstv_tol_pct != '')):
   The last shipment date and the shipment period are mutually exclusive.
</axsl:if>
<axsl:apply-templates mode="M25"/>
</axsl:template>
<axsl:template mode="M25" priority="-1" match="text()"/>
<axsl:template mode="M26" priority="4000" match="/lc_tnx_record">
<axsl:if test="tnx_type_code = '13' and          ((not(company_name) or company_name = '')          or (not(tnx_stat_code) or tnx_stat_code = '')          or (not(product_code) or product_code = '')          or (not(free_format_text) or free_format_text = ''))">In pattern tnx_type_code = '13' and ((not(company_name) or company_name = '') or (not(tnx_stat_code) or tnx_stat_code = '') or (not(product_code) or product_code = '') or (not(free_format_text) or free_format_text = '')):
   Some mandatory elements are missing.
</axsl:if>
<axsl:apply-templates mode="M26"/>
</axsl:template>
<axsl:template mode="M26" priority="-1" match="text()"/>
<axsl:template mode="M27" priority="4000" match="/lc_tnx_record">
<axsl:if test="tnx_type_code = '13' and          (template_id          or tnx_id          or company_id          or imp_bill_ref_id          or entity          or inp_user_id           or inp_dttm           or ctl_user_id           or ctl_dttm           or release_user_id           or release_dttm           or bo_inp_user_id           or bo_inp_dttm           or bo_ctl_user_id           or bo_ctl_dttm           or bo_release_user_id           or bo_release_dttm           or adv_send_mode          or tnx_id          or appl_date          or iss_date          or exp_date          or amd_date          or amd_no          or last_ship_date          or tnx_cur_code          or tnx_amt          or lc_cur_code          or lc_amt          or lc_liab_amt          or lc_type          or beneficiary_abbv_name          or beneficiary_name          or beneficiary_address_line_1          or beneficiary_address_line_2          or beneficiary_dom          or beneficiary_reference          or applicant_abbv_name          or applicant_name          or applicant_address_line_1          or applicant_address_line_2          or applicant_dom          or applicant_reference          or expiry_place          or inco_term          or inco_place          or part_ship_detl          or tran_ship_detl          or ship_from          or ship_loading          or ship_discharge          or ship_to          or draft_term          or cty_of_dest          or rvlv_lc_type_code          or max_no_of_rvlv          or neg_tol_pct          or pstv_tol_pct          or max_cr_desc_code          or cr_avl_by_code          or dir_reim_flag          or irv_flag          or ntrf_flag          or stnd_by_lc_flag          or cfm_inst_code          or cfm_flag          or cfm_chrg_brn_by_code          or corr_chrg_brn_by_code          or open_chrg_brn_by_code          or principal_act_no          or fee_act_no          or bo_comment          or amd_details          or eucp_flag          or eucp_version          or eucp_presentation_place          or advising_bank/abbv_name          or advising_bank/name          or advising_bank/address_line_1          or advising_bank/address_line_2          or advising_bank/dom          or advising_bank/reference          or advise_thru_bank/abbv_name          or advise_thru_bank/name          or advise_thru_bank/address_line_1          or advise_thru_bank/address_line_2          or advise_thru_bank/dom          or advise_thru_bank/reference          or credit_available_with_bank/abbv_name          or credit_available_with_bank/name          or credit_available_with_bank/address_line_1          or credit_available_with__bank/address_line_2          or credit_available_with__bank/dom          or credit_available_with__bank/reference          or drawee_details_bank/abbv_name          or drawee_details_bank/name          or drawee_details_bank/address_line_1          or drawee_details_bank/address_line_2          or drawee_details_bank/dom          or drawee_details_bank/reference          or narrative_description_goods          or narrative_documents_required          or narrative_additional_instructions          or narrative_charges          or narrative_payment_instructions          or narrative_period_presentation          or narrative_sender_to_receiver          or narrative_full_details          or charges)">In pattern tnx_type_code = '13' and (template_id or tnx_id or company_id or imp_bill_ref_id or entity or inp_user_id or inp_dttm or ctl_user_id or ctl_dttm or release_user_id or release_dttm or bo_inp_user_id or bo_inp_dttm or bo_ctl_user_id or bo_ctl_dttm or bo_release_user_id or bo_release_dttm or adv_send_mode or tnx_id or appl_date or iss_date or exp_date or amd_date or amd_no or last_ship_date or tnx_cur_code or tnx_amt or lc_cur_code or lc_amt or lc_liab_amt or lc_type or beneficiary_abbv_name or beneficiary_name or beneficiary_address_line_1 or beneficiary_address_line_2 or beneficiary_dom or beneficiary_reference or applicant_abbv_name or applicant_name or applicant_address_line_1 or applicant_address_line_2 or applicant_dom or applicant_reference or expiry_place or inco_term or inco_place or part_ship_detl or tran_ship_detl or ship_from or ship_loading or ship_discharge or ship_to or draft_term or cty_of_dest or rvlv_lc_type_code or max_no_of_rvlv or neg_tol_pct or pstv_tol_pct or max_cr_desc_code or cr_avl_by_code or dir_reim_flag or irv_flag or ntrf_flag or stnd_by_lc_flag or cfm_inst_code or cfm_flag or cfm_chrg_brn_by_code or corr_chrg_brn_by_code or open_chrg_brn_by_code or principal_act_no or fee_act_no or bo_comment or amd_details or eucp_flag or eucp_version or eucp_presentation_place or advising_bank/abbv_name or advising_bank/name or advising_bank/address_line_1 or advising_bank/address_line_2 or advising_bank/dom or advising_bank/reference or advise_thru_bank/abbv_name or advise_thru_bank/name or advise_thru_bank/address_line_1 or advise_thru_bank/address_line_2 or advise_thru_bank/dom or advise_thru_bank/reference or credit_available_with_bank/abbv_name or credit_available_with_bank/name or credit_available_with_bank/address_line_1 or credit_available_with__bank/address_line_2 or credit_available_with__bank/dom or credit_available_with__bank/reference or drawee_details_bank/abbv_name or drawee_details_bank/name or drawee_details_bank/address_line_1 or drawee_details_bank/address_line_2 or drawee_details_bank/dom or drawee_details_bank/reference or narrative_description_goods or narrative_documents_required or narrative_additional_instructions or narrative_charges or narrative_payment_instructions or narrative_period_presentation or narrative_sender_to_receiver or narrative_full_details or charges):
   A not authorised element is defined.
</axsl:if>
<axsl:apply-templates mode="M27"/>
</axsl:template>
<axsl:template mode="M27" priority="-1" match="text()"/>
<axsl:template mode="M28" priority="4000" match="/lc_tnx_record">
<axsl:if test="tnx_type_code = '13' and sub_tnx_type_code != '' and          (sub_tnx_type_code != '08' and sub_tnx_type_code != '09')">In pattern tnx_type_code = '13' and sub_tnx_type_code != '' and (sub_tnx_type_code != '08' and sub_tnx_type_code != '09'):
   Not authorised sub -transaction type code.
</axsl:if>
<axsl:apply-templates mode="M28"/>
</axsl:template>
<axsl:template mode="M28" priority="-1" match="text()"/>
<axsl:template priority="-1" match="text()"/>
</axsl:stylesheet>
