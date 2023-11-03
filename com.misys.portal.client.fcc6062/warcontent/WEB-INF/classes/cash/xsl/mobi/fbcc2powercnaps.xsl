<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:default="xalan://com.misys.portal.common.resources.DefaultResourceProvider" 
    xmlns:converttools="xalan://com.misys.portal.common.tools.ConvertTools" 
    xmlns:jetSpeed="xalan://com.misys.portal.core.util.JetspeedResources"
    xmlns:technicalResource="xalan://com.misys.portal.common.resources.TechnicalResourceProvider"
    xmlns:java="http://xml.apache.org/xalan/java"
    exclude-result-prefixes="default converttools jetSpeed technicalResource java">
     
    <xsl:param name="language">en</xsl:param>
    
    <xsl:template match="ft_tnx_record">
        	  	
        <!-- Number Format for parsing amount -->
        <xsl:variable name="fbcc_number_format" select="java:java.text.DecimalFormat.new('###,###.##')" />
        <xsl:variable name="powercnaps_number_format" select="'###0.00'" />
        <xsl:variable name="payment_narrative" select="utils:retrievePaymentNarrativeFromTnxId(tnx_id)"></xsl:variable>
        <xsl:variable name="passRefId"><xsl:value-of select="default:getResource('PASS_FBCC_REFID_AS_IFMID')"/></xsl:variable>
	  	<!-- Priority Code -->  
	    <xsl:variable name="priority_code">
	    
		    <!--  HVPS & HVXB Payment Type -->
		    <xsl:if test="product_code = 'FT' and (sub_product_code = 'HVPS' or sub_product_code = 'HVXB')" >
		    	<xsl:choose>
		    		<xsl:when test="./additional_field[@name = 'urgent_transfer'] = 'Y'"><xsl:value-of select="'URGT'" /></xsl:when>
		    		<xsl:otherwise><xsl:value-of select="'NORM'"/></xsl:otherwise>
		    	</xsl:choose>	    
		    </xsl:if>
	    
	    </xsl:variable>  
	    
	    <xsl:variable name="transaction_release_date">
	    	<xsl:value-of select="converttools:timstampToStringDateYYYYMMDD(converttools:stringDateToTimestamp(iss_date, $language))" />
	    </xsl:variable>
	  
	  	<xsl:variable name="transaction_release_time">
	  		 <xsl:value-of select="java:format(java:java.text.SimpleDateFormat.new('HHmmss'), java:java.util.Date.new())" />
	  	</xsl:variable>
		
		<Application>
		  <CommonReqHdr>
		    <APPNAME><xsl:value-of select="'FBCC'"/></APPNAME>
		    <PROCCODE><xsl:value-of select="'CREATE'"/></PROCCODE>
		    <REQUID><xsl:value-of select="bo_ref_id"/></REQUID>
		    <TRANSID>	
		     	<xsl:choose>
                	 <xsl:when test="$passRefId='true'">  
	                    <xsl:value-of select="ref_id" />
		             </xsl:when>
		             <xsl:otherwise>
		                <xsl:value-of select="tnx_id" />
		             </xsl:otherwise>
                </xsl:choose>
			</TRANSID>
		    <TRANDATE><xsl:value-of select="$transaction_release_date" /></TRANDATE>
		    <TRANTIME><xsl:value-of select="$transaction_release_time"/></TRANTIME>
		    <VERSION><xsl:value-of select="'1.0'"/></VERSION>
		  </CommonReqHdr>
		  <Data>
		    <SENDBANK></SENDBANK>
		    <RECVBANK></RECVBANK>
		    <RECVIRBANK><xsl:value-of select="./additional_field[@name = 'cnaps_bank_code']"/></RECVIRBANK>
		    <PAYERBANK></PAYERBANK>
		    <DEBTORACTNO><xsl:value-of select="applicant_act_no" /></DEBTORACTNO>
		    <DEBTORNAME></DEBTORNAME>
		    <DEBTORADDR></DEBTORADDR>
		    <RECVERBANK><xsl:value-of select="./additional_field[@name = 'cnaps_bank_code']"/></RECVERBANK>
		    <CRDTORTACTNO><xsl:value-of select="counterparties/counterparty/counterparty_act_no" /></CRDTORTACTNO>
		    <CRDTORNAME><xsl:value-of select="counterparties/counterparty/counterparty_name"/></CRDTORNAME>
		    <CRDTORADDR></CRDTORADDR>
		    <DEBTORBKNAME></DEBTORBKNAME>
		    <CRDTORBKNAME><xsl:value-of select="./additional_field[@name = 'cnaps_bank_name']"/></CRDTORBKNAME>
		    <AMT><xsl:value-of select="string(format-number(java:parse($fbcc_number_format,ft_amt), $powercnaps_number_format))" /></AMT>
		    <BIZTYPE><xsl:value-of select="./additional_field[@name = 'business_type']"/></BIZTYPE>
		    <BIZDTLTYPE><xsl:value-of select="./additional_field[@name = 'business_detail_type']"/></BIZDTLTYPE>
		    <BIZPRTY><xsl:value-of select="$priority_code"/></BIZPRTY>
		    <ADDTLINF><xsl:value-of select="$payment_narrative" /></ADDTLINF>
		    <CROPLYDT>
		    	<xsl:choose>
		    		<xsl:when test="sub_product_code = 'HVXB'"><xsl:value-of select="converttools:timstampToStringDateYYYYMMDD(converttools:stringDateToTimestamp(./additional_field[@name = 'related_transaction_date'], $language))" /></xsl:when>
		    		<xsl:otherwise><xsl:value-of select="''"/></xsl:otherwise>
		    	</xsl:choose>	    		    
		    </CROPLYDT>
		    <CROPLYREFNB><xsl:value-of select="bo_ref_id"/></CROPLYREFNB>
		    <CROPLYCOSTCD>
		    	<xsl:choose>
		    		<xsl:when test="sub_product_code = 'HVXB'"><xsl:value-of select="./additional_field[@name = 'charge_option']"/></xsl:when>
		    		<xsl:otherwise><xsl:value-of select="''"/></xsl:otherwise>
		    	</xsl:choose>	    
		    </CROPLYCOSTCD>
		    <CROPLYSNDGBKCOST></CROPLYSNDGBKCOST>
		    <CROPLYRCVGBKCOST></CROPLYRCVGBKCOST>
		    <CROPLYADDTLINF>
		    	<xsl:choose>
		    		<xsl:when test="sub_product_code = 'HVXB'"><xsl:value-of select="./additional_field[@name = 'cross_border_remark']"/></xsl:when>
		    		<xsl:otherwise><xsl:value-of select="''"/></xsl:otherwise>
		    	</xsl:choose>	    
		    </CROPLYADDTLINF>
		  </Data>
		</Application>
	
    </xsl:template>    

</xsl:stylesheet>
