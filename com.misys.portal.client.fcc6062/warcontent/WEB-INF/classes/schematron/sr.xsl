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
</axsl:template>
<axsl:template mode="M0" priority="4000" match="/sr_tnx_record">
<axsl:choose>
<axsl:when test="tnx_type_code = '13'"/>
<axsl:otherwise>In pattern tnx_type_code = '13':
   The transaction type code<axsl:text xml:space="preserve"> </axsl:text>
<axsl:value-of select="tnx_type_code"/>
<axsl:text xml:space="preserve"> </axsl:text>is not authorised.
</axsl:otherwise>
</axsl:choose>
<axsl:apply-templates mode="M0"/>
</axsl:template>
<axsl:template mode="M0" priority="-1" match="text()"/>
<axsl:template mode="M1" priority="4000" match="/sr_tnx_record">
<axsl:if test="tnx_type_code = '13' and          ((not(company_name) or company_name = '')          or (not(tnx_stat_code) or tnx_stat_code = '')          or (not(product_code) or product_code = '')          or (not(free_format_text) or free_format_text = ''))">In pattern tnx_type_code = '13' and ((not(company_name) or company_name = '') or (not(tnx_stat_code) or tnx_stat_code = '') or (not(product_code) or product_code = '') or (not(free_format_text) or free_format_text = '')):
   Some mandatory elements are missing.
</axsl:if>
<axsl:apply-templates mode="M1"/>
</axsl:template>
<axsl:template mode="M1" priority="-1" match="text()"/>
<axsl:template mode="M2" priority="4000" match="/sr_tnx_record">
<axsl:if test="tnx_type_code = '13' and          (tnx_id          or company_id          or tnx_id          or imp_bill_ref_id          or entity          or inp_user_id           or inp_dttm           or ctl_user_id           or ctl_dttm           or release_user_id           or release_dttm           or bo_inp_user_id           or bo_inp_dttm           or bo_ctl_user_id           or bo_ctl_dttm           or bo_release_user_id           or bo_release_dttm           or bo_comment          or adv_send_mode          or lc_ref_id          or sub_tnx_type_code          or appl_date          or iss_date          or exp_date          or amd_date          or amd_no          or last_ship_date          or tnx_cur_code          or tnx_amt          or lc_cur_code          or lc_amt          or lc_liab_amt          or lc_type          or applicant_abbv_name          or applicant_name          or applicant_address_line_1          or applicant_address_line_2          or applicant_dom          or applicant_reference          or beneficiary_abbv_name          or beneficiary_name          or beneficiary_address_line_1          or beneficiary_address_line_2          or beneficiary_dom          or beneficiary_reference          or sec_beneficiary_name          or sec_beneficiary_address_line_1          or sec_beneficiary_address_line_2          or sec_beneficiary_dom          or sec_beneficiary_reference          or expiry_place          or inco_term          or part_ship_detl          or tran_ship_detl          or ship_from          or ship_loading          or ship_discharge          or ship_to          or draft_term                     or cty_of_dest                    or rvlv_lc_type_code                 or max_no_of_rvlv                   or neg_tol_pct                    or pstv_tol_pct                    or max_cr_desc_code                  or cr_avl_by_code                   or dir_reim_flag                   or irv_flag                      or ntrf_flag                     or stnd_by_lc_flag                  or cfm_inst_code                   or cfm_flag                      or cfm_chrg_brn_by_code              or corr_chrg_brn_by_code             or open_chrg_brn_by_code             or principal_act_no                  or fee_act_no                        or eucp_flag                         or eucp_version                      or eucp_presentation_place           or inco_place          or issuing_bank/abbv_name          or issuing_bank/name          or issuing_bank/address_line_1          or issuing_bank/address_line_2          or issuing_bank/dom          or issuing_bank/reference          or credit_available_with_bank/abbv_name          or credit_available_with_bank/name          or credit_available_with_bank/address_line_1          or credit_available_with_bank/address_line_2          or credit_available_with_bank/dom          or credit_available_with_bank/reference          or drawee_details_bank/abbv_name          or drawee_details_bank/name          or drawee_details_bank/address_line_1          or drawee_details_bank/address_line_2          or drawee_details_bank/dom          or drawee_details_bank/reference          or narrative_description_goods          or narrative_documents_required          or narrative_additional_instructions          or narrative_charges          or narrative_additional_amount          or narrative_payment_instructions          or narrative_period_presentation          or narrative_shipment_period          or narrative_sender_to_receiver          or narrative_full_details          or charges)">In pattern tnx_type_code = '13' and (tnx_id or company_id or tnx_id or imp_bill_ref_id or entity or inp_user_id or inp_dttm or ctl_user_id or ctl_dttm or release_user_id or release_dttm or bo_inp_user_id or bo_inp_dttm or bo_ctl_user_id or bo_ctl_dttm or bo_release_user_id or bo_release_dttm or bo_comment or adv_send_mode or lc_ref_id or sub_tnx_type_code or appl_date or iss_date or exp_date or amd_date or amd_no or last_ship_date or tnx_cur_code or tnx_amt or lc_cur_code or lc_amt or lc_liab_amt or lc_type or applicant_abbv_name or applicant_name or applicant_address_line_1 or applicant_address_line_2 or applicant_dom or applicant_reference or beneficiary_abbv_name or beneficiary_name or beneficiary_address_line_1 or beneficiary_address_line_2 or beneficiary_dom or beneficiary_reference or sec_beneficiary_name or sec_beneficiary_address_line_1 or sec_beneficiary_address_line_2 or sec_beneficiary_dom or sec_beneficiary_reference or expiry_place or inco_term or part_ship_detl or tran_ship_detl or ship_from or ship_loading or ship_discharge or ship_to or draft_term or cty_of_dest or rvlv_lc_type_code or max_no_of_rvlv or neg_tol_pct or pstv_tol_pct or max_cr_desc_code or cr_avl_by_code or dir_reim_flag or irv_flag or ntrf_flag or stnd_by_lc_flag or cfm_inst_code or cfm_flag or cfm_chrg_brn_by_code or corr_chrg_brn_by_code or open_chrg_brn_by_code or principal_act_no or fee_act_no or eucp_flag or eucp_version or eucp_presentation_place or inco_place or issuing_bank/abbv_name or issuing_bank/name or issuing_bank/address_line_1 or issuing_bank/address_line_2 or issuing_bank/dom or issuing_bank/reference or credit_available_with_bank/abbv_name or credit_available_with_bank/name or credit_available_with_bank/address_line_1 or credit_available_with_bank/address_line_2 or credit_available_with_bank/dom or credit_available_with_bank/reference or drawee_details_bank/abbv_name or drawee_details_bank/name or drawee_details_bank/address_line_1 or drawee_details_bank/address_line_2 or drawee_details_bank/dom or drawee_details_bank/reference or narrative_description_goods or narrative_documents_required or narrative_additional_instructions or narrative_charges or narrative_additional_amount or narrative_payment_instructions or narrative_period_presentation or narrative_shipment_period or narrative_sender_to_receiver or narrative_full_details or charges):
   A not authorised element is defined.
</axsl:if>
<axsl:apply-templates mode="M2"/>
</axsl:template>
<axsl:template mode="M2" priority="-1" match="text()"/>
<axsl:template priority="-1" match="text()"/>
</axsl:stylesheet>
