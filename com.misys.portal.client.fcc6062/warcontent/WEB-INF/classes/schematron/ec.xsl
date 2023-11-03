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
<axsl:template mode="M0" priority="4000" match="/ec_tnx_record">
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
<axsl:template mode="M1" priority="4000" match="/ec_tnx_record">
<axsl:if test="tnx_type_code = '01' and          ((not(company_name) or company_name = '')          or (not(tnx_stat_code) or tnx_stat_code = '')          or (not(product_code) or product_code = '')          or (not(term_code) or term_code = '')          or (not(drawer_name) or drawer_name = '')          or (not(drawer_address_line_1) or drawer_address_line_1 = '')          or (not(drawee_name) or drawee_name = '')          or (not(drawee_address_line_1) or drawee_address_line_1 = '')          or (not(ec_cur_code) or ec_cur_code = '')          or (not(ec_amt) or ec_amt = '')          or (not(remitting_bank/abbv_name) or remitting_bank/abbv_name = '')          or (not(docs_send_mode) or docs_send_mode = ''))">In pattern tnx_type_code = '01' and ((not(company_name) or company_name = '') or (not(tnx_stat_code) or tnx_stat_code = '') or (not(product_code) or product_code = '') or (not(term_code) or term_code = '') or (not(drawer_name) or drawer_name = '') or (not(drawer_address_line_1) or drawer_address_line_1 = '') or (not(drawee_name) or drawee_name = '') or (not(drawee_address_line_1) or drawee_address_line_1 = '') or (not(ec_cur_code) or ec_cur_code = '') or (not(ec_amt) or ec_amt = '') or (not(remitting_bank/abbv_name) or remitting_bank/abbv_name = '') or (not(docs_send_mode) or docs_send_mode = '')):
   Some mandatory elements are missing.
</axsl:if>
<axsl:apply-templates mode="M1"/>
</axsl:template>
<axsl:template mode="M1" priority="-1" match="text()"/>
<axsl:template mode="M2" priority="4000" match="/ec_tnx_record">
<axsl:if test="tnx_type_code = '01' and          (ref_id           or bo_ref_id           or tnx_id           or company_id           or inp_user_id           or inp_dttm           or ctl_user_id           or ctl_dttm           or release_user_id           or release_dttm           or bo_inp_user_id           or bo_inp_dttm           or bo_ctl_user_id           or bo_ctl_dttm           or bo_release_user_id           or bo_release_dttm           or bo_comment           or charges)">In pattern tnx_type_code = '01' and (ref_id or bo_ref_id or tnx_id or company_id or inp_user_id or inp_dttm or ctl_user_id or ctl_dttm or release_user_id or release_dttm or bo_inp_user_id or bo_inp_dttm or bo_ctl_user_id or bo_ctl_dttm or bo_release_user_id or bo_release_dttm or bo_comment or charges):
   A not authorised element is defined.
</axsl:if>
<axsl:apply-templates mode="M2"/>
</axsl:template>
<axsl:template mode="M2" priority="-1" match="text()"/>
<axsl:template mode="M3" priority="4000" match="/ec_tnx_record">
<axsl:if test="tnx_type_code = '01' and          (term_code = '02' and (not(tenor_desc) or tenor_desc = ''))">In pattern tnx_type_code = '01' and (term_code = '02' and (not(tenor_desc) or tenor_desc = '')):
   If tenor is D/A, the tenor description must be defined.
</axsl:if>
<axsl:apply-templates mode="M3"/>
</axsl:template>
<axsl:template mode="M3" priority="-1" match="text()"/>
<axsl:template mode="M4" priority="4000" match="/ec_tnx_record">
<axsl:if test="tnx_type_code = '01' and ec_type_code = '02' and          ((not(presenting_bank/name) or presenting_bank/name = '')          or (not(presenting_bank/address_line_1) or presenting_bank/address_line_1 = ''))">In pattern tnx_type_code = '01' and ec_type_code = '02' and ((not(presenting_bank/name) or presenting_bank/name = '') or (not(presenting_bank/address_line_1) or presenting_bank/address_line_1 = '')):
   If the collection is direct, the presenting bank must be defined.
</axsl:if>
<axsl:apply-templates mode="M4"/>
</axsl:template>
<axsl:template mode="M4" priority="-1" match="text()"/>
<axsl:template mode="M5" priority="4000" match="/ec_tnx_record">
<axsl:if test="tnx_type_code = '13' and          ((not(company_name) or company_name = '')          or (not(tnx_stat_code) or tnx_stat_code = '')          or (not(product_code) or product_code = '')          or (not(free_format_text) or free_format_text = ''))">In pattern tnx_type_code = '13' and ((not(company_name) or company_name = '') or (not(tnx_stat_code) or tnx_stat_code = '') or (not(product_code) or product_code = '') or (not(free_format_text) or free_format_text = '')):
   Some mandatory elements are missing.
</axsl:if>
<axsl:apply-templates mode="M5"/>
</axsl:template>
<axsl:template mode="M5" priority="-1" match="text()"/>
<axsl:template mode="M6" priority="4000" match="/ec_tnx_record">
<axsl:if test="tnx_type_code = '13' and          (tnx_id          or company_id          or lc_ref_id          or entity          or inp_user_id           or inp_dttm           or ctl_user_id           or ctl_dttm           or release_user_id           or release_dttm           or bo_inp_user_id           or bo_inp_dttm           or bo_ctl_user_id           or bo_ctl_dttm           or bo_release_user_id           or bo_release_dttm           or appl_date          or tnx_cur_code          or tnx_amt          or ec_cur_code          or ec_amt          or ec_liab_amt          or ec_type_code          or drawee_abbv_name          or drawee_name          or drawee_address_line_1          or drawee_address_line_2          or drawee_dom          or drawee_reference          or drawer_abbv_name          or drawer_name          or drawer_address_line_1          or drawer_address_line_2          or drawer_dom          or drawer_reference          or bol_number          or shipping_mode          or shipping_by          or ship_from          or ship_to          or inco_term          or inco_place          or term_code          or docs_send_mode          or accpt_adv_send_mode          or protest_non_paymt          or protest_non_accpt          or protest_adv_send_mode          or accpt_defd_flag          or store_goods_flag          or paymt_adv_send_mode          or tenor_desc          or tenor          or tenor_unit          or tenor_event          or tenor_start_date          or tenor_maturity_date          or open_chrg_brn_by_code          or corr_chrg_brn_by_code          or waive_chrg_flag          or int_rate          or int_start_date          or int_maturity_date          or principal_act_no          or fee_act_no          or fwd_contract_no          or insr_req_flag          or bo_comment          or dir_coll_letter_flag          or collecting_bank/abbv_name          or collecting_bank/name          or collecting_bank/address_line_1          or collecting_bank/address_line_2          or collecting_bank/dom          or collecting_bank/reference          or presenting_bank/abbv_name          or presenting_bank/name          or presenting_bank/address_line_1          or presenting_bank/address_line_2          or presenting_bank/dom          or presenting_bank/reference          or correspondent_bank/abbv_name          or correspondent_bank/name          or correspondent_bank/address_line_1          or correspondent_bank/address_line_2          or correspondent_bank/dom          or correspondent_bank/reference          or narrative_additional_instructions          or charges          or documents)">In pattern tnx_type_code = '13' and (tnx_id or company_id or lc_ref_id or entity or inp_user_id or inp_dttm or ctl_user_id or ctl_dttm or release_user_id or release_dttm or bo_inp_user_id or bo_inp_dttm or bo_ctl_user_id or bo_ctl_dttm or bo_release_user_id or bo_release_dttm or appl_date or tnx_cur_code or tnx_amt or ec_cur_code or ec_amt or ec_liab_amt or ec_type_code or drawee_abbv_name or drawee_name or drawee_address_line_1 or drawee_address_line_2 or drawee_dom or drawee_reference or drawer_abbv_name or drawer_name or drawer_address_line_1 or drawer_address_line_2 or drawer_dom or drawer_reference or bol_number or shipping_mode or shipping_by or ship_from or ship_to or inco_term or inco_place or term_code or docs_send_mode or accpt_adv_send_mode or protest_non_paymt or protest_non_accpt or protest_adv_send_mode or accpt_defd_flag or store_goods_flag or paymt_adv_send_mode or tenor_desc or tenor or tenor_unit or tenor_event or tenor_start_date or tenor_maturity_date or open_chrg_brn_by_code or corr_chrg_brn_by_code or waive_chrg_flag or int_rate or int_start_date or int_maturity_date or principal_act_no or fee_act_no or fwd_contract_no or insr_req_flag or bo_comment or dir_coll_letter_flag or collecting_bank/abbv_name or collecting_bank/name or collecting_bank/address_line_1 or collecting_bank/address_line_2 or collecting_bank/dom or collecting_bank/reference or presenting_bank/abbv_name or presenting_bank/name or presenting_bank/address_line_1 or presenting_bank/address_line_2 or presenting_bank/dom or presenting_bank/reference or correspondent_bank/abbv_name or correspondent_bank/name or correspondent_bank/address_line_1 or correspondent_bank/address_line_2 or correspondent_bank/dom or correspondent_bank/reference or narrative_additional_instructions or charges or documents):
   A not authorised element is defined.
</axsl:if>
<axsl:apply-templates mode="M6"/>
</axsl:template>
<axsl:template mode="M6" priority="-1" match="text()"/>
<axsl:template priority="-1" match="text()"/>
</axsl:stylesheet>
