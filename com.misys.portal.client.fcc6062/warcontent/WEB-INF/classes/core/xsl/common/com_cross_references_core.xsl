<?xml version="1.0" encoding="UTF-8"?>
<!--
##########################################################
Templates for cross references. These templates are imported
in trade_common.xsl and bank_common.xsl.

Amendentment forms should import this template after importing
trade_common.xsl (on the customer side) or bank_common.xsl (on the bank
side).

Copyright (c) 2000-2008 Misys (http://www.misys.com),
All Rights Reserved. 

version:   1.0
date:      12/03/08
author:    Cormac Flynn
email:     cormac.flynn@misys.com
##########################################################
-->
<!DOCTYPE xsl:stylesheet [
	<!ENTITY nbsp "&#160;">
]>
<xsl:stylesheet
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.misys.portal.common.localization.Localization"
		exclude-result-prefixes="localization">
     
  <!-- Hidden cross references, Input Form -->
  <xsl:template match="cross_references" mode="hidden_form">
   <xsl:apply-templates select="cross_reference" mode="hidden_form"/>
  </xsl:template> 
  
  <!-- Display cross references, Input Form -->
  <xsl:template match="cross_references" mode="display_form">
    <xsl:apply-templates select="cross_reference" mode="display_form"/>
  </xsl:template>
  
  <!-- Cross Ref Hidden Fields (Hidden Form)-->
  <xsl:template match="cross_reference" mode="hidden_form">
   <div class="widgetContainer">
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">cross_ref_cross_reference_id_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="cross_reference_id"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">cross_ref_ref_id_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="ref_id"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">cross_ref_tnx_id_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="tnx_id"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">cross_ref_product_code_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="product_code"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">cross_ref_child_ref_id_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="child_ref_id"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">cross_ref_child_tnx_id_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="child_tnx_id"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">cross_ref_child_product_code_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="child_product_code"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">cross_ref_type_code_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="type_code"/></xsl:with-param>
    </xsl:call-template>
   </div>
  </xsl:template>
  
  <!-- Cross Ref Hidden Fields (Display Form)-->
  <xsl:template match="cross_reference" mode="display_form">
   <div class="widgetContainer">
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">cross_ref_cross_reference_id_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="cross_reference_id"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">cross_ref_ref_id_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="ref_id"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">cross_ref_tnx_id_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="tnx_id"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">cross_ref_product_code_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="product_code"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">cross_ref_child_ref_id_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="child_ref_id"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">cross_ref_child_tnx_id_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="child_tnx_id"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">cross_ref_child_product_code_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="child_product_code"/></xsl:with-param>
    </xsl:call-template>
    <xsl:call-template name="hidden-field">
     <xsl:with-param name="name">cross_ref_type_code_<xsl:value-of select="position()"/></xsl:with-param>
     <xsl:with-param name="value"><xsl:value-of select="type_code"/></xsl:with-param>
    </xsl:call-template>
   </div>
  </xsl:template>
  
  <!--  																								 -->
  <!--  Cross references tempalte are empty until the security issue related to the company id is solved -->
  <!--  																								 -->
  <!-- Display Cross References, Transaction Reporting -->
  <xsl:template match="cross_references" mode="display_table_tnx">
   <xsl:param name="cross-ref-summary-option"/>
   <xsl:choose>
    <xsl:when test="count(cross_reference[ref_id != child_ref_id]) &gt; 0">
     <!-- Details of child-->
      <xsl:if test="cross_reference/child_product_code[.!='IP' and .!='IN' and .!='PO' and .!='SO' and .!='CR' and .!='CN' and .!='TD'] and ((count(cross_reference[ref_id=../../ref_id and ref_id != child_ref_id]) &gt; 0)  or (cross_reference/child_product_code[.='LN'] and count(cross_reference[ref_id=../../bulk_ref_id and ref_id != child_ref_id])&gt; 0))">
      <div class="field">
       <xsl:if test="count(cross_reference[child_ref_id=../../ref_id and ref_id != child_ref_id]) &gt; 1">
        <xsl:attribute name="style">height:<xsl:value-of select="count(cross_reference[child_ref_id=../../ref_id and ref_id != child_ref_id])*10"/>px;</xsl:attribute>
       </xsl:if>
       <div class="label">
		<xsl:choose>
			<xsl:when test="cross_reference/child_product_code[.='LN']">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_REPRICED_FROM_LINKED_REFERENCE')"/>
			</xsl:when>
			<xsl:when test="cross_reference/child_product_code[.='FX']">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_ANCESTOR_LINKED_REFERENCE')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_CHILD_LINKED_REFERENCE')"/>
			</xsl:otherwise>
		</xsl:choose>
       </div>
       <xsl:choose>
       	<xsl:when test="count(cross_reference[child_ref_id=../../ref_id and ref_id != child_ref_id]) &gt; 1"> 
       		 <ul>
		        <xsl:for-each select="cross_reference[ref_id=../../ref_id and ref_id != child_ref_id]">
		         <li>&nbsp;&nbsp;
		          <a href="javascript:void(0)">
		           <xsl:attribute name="onclick">
		            <xsl:choose>
		             <xsl:when test="$cross-ref-summary-option !=''">misys.popup.showReporting('<xsl:value-of select="$cross-ref-summary-option"/>', '<xsl:value-of select="child_product_code"/>', '<xsl:value-of select="child_ref_id"/>', '<xsl:value-of select="child_tnx_id"/>');return false;</xsl:when>
		             <xsl:when test="child_tnx_id[.!='']">misys.popup.showReporting('FULL', '<xsl:value-of select="child_product_code"/>', '<xsl:value-of select="child_ref_id"/>', '<xsl:value-of select="child_tnx_id"/>');return false;</xsl:when>
		             <xsl:otherwise>misys.popup.showReporting('DETAILS', '<xsl:value-of select="child_product_code"/>', '<xsl:value-of select="child_ref_id"/>');return false;</xsl:otherwise>
		            </xsl:choose>
		           </xsl:attribute>
		           <xsl:attribute name="style">padding:0px 3px 0px 2px;</xsl:attribute> 
		           <xsl:value-of select="child_ref_id"/>
		          </a>
		         <xsl:choose>
		         	<xsl:when test="product_code[.='LN' or .='FX']"/>
		         	<xsl:otherwise>(<xsl:value-of select="localization:getDecode($language, 'N043', type_code)"/>)</xsl:otherwise>
		         </xsl:choose>
		         </li>
		        </xsl:for-each>
      	 	</ul>
       	</xsl:when>
       	<xsl:when test="cross_reference/child_product_code[.='LN'] and count(cross_reference[ref_id=../../bulk_ref_id and ref_id != child_ref_id]) &gt; 0">       	 
	      	 <xsl:for-each select="cross_reference[ref_id=../../bulk_ref_id and ref_id != child_ref_id[1]]">
	      	 <xsl:if test="position()=last()">
	          <a href="javascript:void(0)">
	           <xsl:attribute name="onclick">
	            <xsl:choose>
	             <xsl:when test="$cross-ref-summary-option !=''">misys.popup.showReporting('<xsl:value-of select="$cross-ref-summary-option"/>', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="ref_id"/>', '<xsl:value-of select="tnx_id"/>');return false;</xsl:when>
	             <xsl:when test="tnx_id[.!='']">misys.popup.showReporting('FULL', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="ref_id"/>', '<xsl:value-of select="tnx_id"/>');return false;</xsl:when>
	             <xsl:otherwise>misys.popup.showReporting('DETAILS', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="ref_id"/>');return false;</xsl:otherwise>
	            </xsl:choose>
	           </xsl:attribute>
	           <xsl:attribute name="style">padding:0px 3px 0px 2px;</xsl:attribute> 
	           <xsl:value-of select="ref_id"/>
	         </a>
	         <xsl:choose>
	         	<xsl:when test="product_code[.='LN' or .='BK' or .='FX']"/>
	         	<xsl:otherwise>(<xsl:value-of select="localization:getDecode($language, 'N043', type_code)"/>)</xsl:otherwise>
	         </xsl:choose>
	         </xsl:if>
	        </xsl:for-each>
       	</xsl:when>
       	<xsl:when test="cross_reference/child_product_code[.='FX'] and count(cross_reference[ref_id=../../ref_id and ref_id != child_ref_id]) &gt; 0">       	 
	      	 <xsl:for-each select="cross_reference[ref_id=../../ref_id and ref_id != child_ref_id]">
	          <a href="javascript:void(0)">
	           <xsl:attribute name="onclick">
	            misys.popup.showReporting('FULL', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="child_ref_id"/>');
	           </xsl:attribute>
	           <xsl:attribute name="style">padding:0px 3px 0px 2px;</xsl:attribute> 
	           <xsl:value-of select="child_ref_id"/>
	         </a>
	         <xsl:choose>
	         	<xsl:when test="product_code[.='FX']"/>
	         	<xsl:otherwise>(<xsl:value-of select="localization:getDecode($language, 'N043', type_code)"/>)</xsl:otherwise>
	         </xsl:choose>
	        </xsl:for-each>
       	</xsl:when>
       	<xsl:otherwise>
	      	<xsl:for-each select="cross_reference[ref_id=../../ref_id and ref_id != child_ref_id]">
	          <a href="javascript:void(0)">
	           <xsl:attribute name="onclick">
	            <xsl:choose>
	             <xsl:when test="$cross-ref-summary-option !=''">misys.popup.showReporting('<xsl:value-of select="$cross-ref-summary-option"/>', '<xsl:value-of select="child_product_code"/>', '<xsl:value-of select="child_ref_id"/>', '<xsl:value-of select="child_tnx_id"/>');return false;</xsl:when>
	             <xsl:when test="child_tnx_id[.!='']">misys.popup.showReporting('FULL', '<xsl:value-of select="child_product_code"/>', '<xsl:value-of select="child_ref_id"/>', '<xsl:value-of select="child_tnx_id"/>');return false;</xsl:when>
	             <xsl:otherwise>misys.popup.showReporting('DETAILS', '<xsl:value-of select="child_product_code"/>', '<xsl:value-of select="child_ref_id"/>');return false;</xsl:otherwise>
	            </xsl:choose>
	           </xsl:attribute>
	           <xsl:attribute name="style">padding:0px 3px 0px 2px;</xsl:attribute> 
	           <xsl:value-of select="child_ref_id"/>
	         </a>
	         <xsl:choose>
	         	<xsl:when test="product_code[.='LN' or .='FX']"/>
	         	<xsl:otherwise>(<xsl:value-of select="localization:getDecode($language, 'N043', type_code)"/>)</xsl:otherwise>
	         </xsl:choose>
	        </xsl:for-each>
       	</xsl:otherwise>
       </xsl:choose>
      </div>
     </xsl:if>
     
     <!-- Details of ancestors -->
     <xsl:if test="cross_reference/child_product_code[.!='IP' and .!='IN' and .!='PO' and .!='SO' and .!='CR' and .!='CN' and .!='TD'] and (count(cross_reference[child_ref_id=../../ref_id and ref_id != child_ref_id]) &gt; 0) and (cross_reference/product_code[.!='FB'])">
      <div class="field">
       <span class="label">
        <xsl:if test="count(cross_reference[child_ref_id=../../ref_id and ref_id != child_ref_id]) &gt; 1">
         <xsl:attribute name="style">height:<xsl:value-of select="count(cross_reference[child_ref_id=../../ref_id and ref_id != child_ref_id])*10"/>px;</xsl:attribute>
        </xsl:if>
        <xsl:choose>
        	<xsl:when test="cross_reference/child_product_code[.='LN']">
        		<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_REPRICED_TO_LINKED_REFERENCE')"/>
        	</xsl:when>
        	<xsl:otherwise>
        		<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_ANCESTOR_LINKED_REFERENCE')"/>
        	</xsl:otherwise>
        </xsl:choose>
       </span> 
       <div class="content">
       <xsl:choose>
       	<xsl:when test="count(cross_reference[child_ref_id=../../ref_id and ref_id != child_ref_id]) &gt; 1">
       		 <ul class="crossrefs">
	          <xsl:for-each select="cross_reference[child_ref_id=../../ref_id and ref_id != child_ref_id]">
	         <li>
	          <a href="javascript:void(0)">
	           <xsl:attribute name="onclick">
	            <xsl:choose>
	           	 <xsl:when test="$cross-ref-summary-option !=''">misys.popup.showReporting('<xsl:value-of select="$cross-ref-summary-option"/>', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="ref_id"/>','<xsl:value-of select="tnx_id"/>');return false;</xsl:when>
	             <xsl:when test="tnx_id[.!='']">misys.popup.showReporting('FULL', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="ref_id"/>', '<xsl:value-of select="tnx_id"/>');return false;</xsl:when>
	             <xsl:otherwise>misys.popup.showReporting('DETAILS', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="ref_id"/>');return false;</xsl:otherwise>
	            </xsl:choose>
	           </xsl:attribute>
	           <xsl:value-of select="ref_id"/>
	          </a>
	         <xsl:choose>
	         	<xsl:when test="product_code[.='LN']"/>
	         	<xsl:otherwise>(<xsl:value-of select="localization:getDecode($language, 'N043', type_code)"/>)</xsl:otherwise>
	         </xsl:choose>
	         </li>
	        </xsl:for-each>
	       </ul>
       	</xsl:when>
       	<xsl:otherwise>
	      	<xsl:for-each select="cross_reference[child_ref_id=../../ref_id and ref_id != child_ref_id]">
	      	  <a href="javascript:void(0)">
	           <xsl:attribute name="onclick">
	            <xsl:choose>
	           	 <xsl:when test="$cross-ref-summary-option !=''">misys.popup.showReporting('<xsl:value-of select="$cross-ref-summary-option"/>', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="ref_id"/>','<xsl:value-of select="tnx_id"/>');return false;</xsl:when>
	             <xsl:when test="tnx_id[.!='']">misys.popup.showReporting('FULL', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="ref_id"/>', '<xsl:value-of select="tnx_id"/>');return false;</xsl:when>
	             <xsl:otherwise>misys.popup.showReporting('DETAILS', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="ref_id"/>');return false;</xsl:otherwise>
	            </xsl:choose>
	           </xsl:attribute>
	          <xsl:value-of select="ref_id"/>
	         </a>
	         <xsl:choose>
	         	<xsl:when test="product_code[.='LN']"/>
	         	<xsl:otherwise>(<xsl:value-of select="localization:getDecode($language, 'N043', type_code)"/>)</xsl:otherwise>
	         </xsl:choose>
	        </xsl:for-each>
       	</xsl:otherwise>
       </xsl:choose>
       </div>
      </div>
     </xsl:if>
    </xsl:when>
    <xsl:otherwise>
     <xsl:if test="cross_reference/child_product_code[.!='IP' and .!='IN' and .!='PO' and .!='SO' and .!='CR' and .!='CN' and .!='FX' and .!='TD' and .!='IR' and .!='BG']">
	     <div class="field">
	      <div class="label"><em><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_NO_LINKED_REFERENCE')"/></em></div>
	     </div>
     </xsl:if>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:template>
  
  <xsl:template match="cross_references" mode="display_table_master"> 
   <xsl:choose>
    <xsl:when test="count(cross_reference[ref_id != child_ref_id]) &gt; 0">
     <!-- Details of child-->
     <xsl:if test="cross_reference/child_product_code[.!='IP' and .!='IN' and .!='PO' and .!='SO' and .!='CR' and .!='CN'] and (count(cross_reference[ref_id=../../ref_id and ref_id != child_ref_id]) &gt; 0)">
      <div class="field">
       <div class="label">
        <xsl:if test="count(cross_reference[ref_id=../../ref_id and ref_id != child_ref_id]) &gt; 1">
         <xsl:attribute name="style">height:<xsl:value-of select="count(cross_reference[ref_id=../../ref_id and ref_id != child_ref_id])*10"/>px;</xsl:attribute>
        </xsl:if>
		<xsl:choose>
			<xsl:when test="cross_reference/child_product_code[.='LN']">
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_REPRICED_FROM_LINKED_REFERENCE')"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_CHILD_LINKED_REFERENCE')"/>
			</xsl:otherwise>
		</xsl:choose>
       </div> 
       <xsl:choose>
       	<xsl:when test="count(cross_reference[ref_id=../../ref_id and ref_id != child_ref_id]) &gt; 1">
       	  <ul>
        	<xsl:for-each select="cross_reference[ref_id=../../ref_id and ref_id != child_ref_id]">
         		<li>
		          <a href="javascript:void(0)">
		           <xsl:attribute name="onclick">
		            <xsl:choose>
		            <xsl:when test="product_code[.='BK'] and child_product_code[.='LN']">misys.popup.showReporting('DETAILS', '<xsl:value-of select="child_product_code"/>', '<xsl:value-of select="child_ref_id"/>');return false;</xsl:when>
		             <xsl:when test="tnx_id[.!='']">misys.popup.showReporting('<xsl:value-of select="child_product_code"/>', '<xsl:value-of select="child_ref_id"/>', '<xsl:value-of select="child_tnx_id"/>', 'FULL');return false;</xsl:when>
		             <xsl:otherwise>misys.popup.showReporting('DETAILS', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="ref_id"/>');return false;</xsl:otherwise>
		            </xsl:choose>
		           </xsl:attribute>
		           <xsl:value-of select="child_ref_id"/>
		          </a>
		         <xsl:choose>
		         	<xsl:when test="product_code[.='LN']"/>
		         	<xsl:otherwise>(<xsl:value-of select="localization:getDecode($language, 'N043', type_code)"/>)</xsl:otherwise>
		         </xsl:choose>
         		</li>
        	</xsl:for-each>
       	 </ul>
       	</xsl:when>
       	<xsl:otherwise>
	        <xsl:for-each select="cross_reference[ref_id=../../ref_id and ref_id != child_ref_id]">
	          <a href="javascript:void(0)">
	           <xsl:attribute name="onclick">
	            <xsl:choose>
	             <xsl:when test="product_code[.='BK'] and child_product_code[.='LN']">misys.popup.showReporting('DETAILS', '<xsl:value-of select="child_product_code"/>', '<xsl:value-of select="child_ref_id"/>');return false;</xsl:when>
	             <xsl:when test="tnx_id[.!='']">misys.popup.showReporting('<xsl:value-of select="child_product_code"/>', '<xsl:value-of select="child_ref_id"/>', '<xsl:value-of select="child_tnx_id"/>', 'FULL');return false;</xsl:when>
	             <xsl:otherwise>misys.popup.showReporting('DETAILS', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="ref_id"/>');return false;</xsl:otherwise>
	            </xsl:choose>
	           </xsl:attribute>
	           <xsl:value-of select="child_ref_id"/>
	          </a>
	         <xsl:choose>
	         	<xsl:when test="product_code[.='LN']"/>
	         	<xsl:otherwise>(<xsl:value-of select="localization:getDecode($language, 'N043', type_code)"/>)</xsl:otherwise>
	         </xsl:choose>	          
        	</xsl:for-each>
       	</xsl:otherwise>
       </xsl:choose>
      </div>
     </xsl:if>
     
     <!-- Details of ancestors -->
     <xsl:if test="cross_reference/child_product_code[.!='IP' and .!='IN' and .!='PO' and .!='SO' and .!='CR' and .!='CN'] and (count(cross_reference[child_ref_id=../../ref_id and ref_id != child_ref_id]) &gt; 0)">
      <div class="field">
       <div class="label">
        <xsl:if test="count(cross_reference[child_ref_id=../../ref_id and ref_id != child_ref_id]) &gt; 1">
         <xsl:attribute name="style">height:<xsl:value-of select="count(cross_reference[child_ref_id=../../ref_id and ref_id != child_ref_id])*10"/>px;</xsl:attribute>
        </xsl:if>
        <xsl:choose>
        	<xsl:when test="cross_reference/child_product_code[.='LN']">
        		<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_REPRICED_TO_LINKED_REFERENCE')"/>
        	</xsl:when>
        	<xsl:otherwise>
        	 <xsl:if test="$rundata!='' ">
        		<xsl:call-template name="localization-dblclick">
					<xsl:with-param name="xslName">XSL_REPORTINGDETAILS_ANCESTOR_LINKED_REFERENCE</xsl:with-param>
					<xsl:with-param name="localName" select="localization:getGTPString($rundata, $language, 'XSL_REPORTINGDETAILS_ANCESTOR_LINKED_REFERENCE')" />
				</xsl:call-template>
				</xsl:if>
        		<xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_ANCESTOR_LINKED_REFERENCE')"/>
        	</xsl:otherwise>
        </xsl:choose>
       </div> 
       <xsl:choose>
       	<xsl:when test="count(cross_reference[child_ref_id=../../ref_id and ref_id != child_ref_id]) &gt; 1">
       		 <ul>
	          <xsl:for-each select="cross_reference[child_ref_id=../../ref_id and ref_id != child_ref_id]">
		         <li>
		          <a href="javascript:void(0)">
			          <xsl:attribute name="onclick">misys.popup.showReporting('DETAILS', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="ref_id"/>');return false;</xsl:attribute>
			          <xsl:value-of select="ref_id"/>
			       </a>
		         <xsl:choose>
		         	<xsl:when test="product_code[.='LN']"/>
		         	<xsl:otherwise>(<xsl:value-of select="localization:getDecode($language, 'N043', type_code)"/>)</xsl:otherwise>
		         </xsl:choose>
		         </li>
	        </xsl:for-each>
	       </ul>
       	</xsl:when>
       	<xsl:otherwise>
	        <xsl:for-each select="cross_reference[child_ref_id=../../ref_id and ref_id != child_ref_id]">
	         <a href="javascript:void(0)">
	          <xsl:attribute name="onclick">misys.popup.showReporting('DETAILS', '<xsl:value-of select="product_code"/>', '<xsl:value-of select="ref_id"/>');return false;</xsl:attribute>
	          <xsl:value-of select="ref_id"/>
	         </a>
	         <xsl:choose>
	         	<xsl:when test="product_code[.='LN']"/>
	         	<xsl:otherwise>(<xsl:value-of select="localization:getDecode($language, 'N043', type_code)"/>)</xsl:otherwise>
	         </xsl:choose>
	        </xsl:for-each>
       	</xsl:otherwise>
       </xsl:choose>
     </div>
    </xsl:if>
   </xsl:when>
   <xsl:otherwise>
   	<xsl:if test="cross_reference/child_product_code[.!='IP' and .!='IN' and .!='PO' and .!='SO' and .!='CR' and .!='CN' and .!='FX' and .!='TD' and .!='SI']">
    <div class="field">
     <div class="label"><xsl:value-of select="localization:getGTPString($language, 'XSL_REPORTINGDETAILS_NO_LINKED_REFERENCE')"/></div>
    </div>
    </xsl:if>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
</xsl:stylesheet>