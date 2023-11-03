<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:utils="xalan://com.misys.portal.common.tools.Utils">
    
  <xsl:param name="isMakerCheckerMode"/>
  <xsl:param name="makerCheckerState"/>
  <xsl:param name="token"/>
 
  <xsl:param name="canCheckerReturnComments"/>
  <xsl:param name="checkerReturnCommentsMode"/>
  <xsl:param name="allowReturnAction">false</xsl:param>
  <xsl:param name="draftMode" />
  <xsl:param name="screenMode" />
  <xsl:param name="allowDraftMode" />
  <xsl:param name="hideStandardMenu">false</xsl:param>
  <xsl:param name="master_url" /> 
  <xsl:param name="hideMasterViewLink" />  
    
 <!-- ***************************************************************************************** -->
 <!-- ************************************** MAKER-CHECKER-MENU ***************************************** -->
 <!-- ***************************************************************************************** -->
   <xsl:template name="maker-checker-menu">
   <xsl:param name="second-menu">N</xsl:param>
   <xsl:param name="submit-type">MAKER_SUBMIT</xsl:param>
   <xsl:param name="submit-type-bene">MAKER_BENE_SUBMIT</xsl:param>
   <xsl:param name="submit-type-bene-file-upload">MAKER_BENE_FILE_UPLOAD_SUBMIT</xsl:param>
   <xsl:param name="submit-type-bene-approve">CHECKER_BENE_SUBMIT</xsl:param>
   <xsl:param name="submit-type-bene-file-upload-approve">CHECKER_BENE_FILE_UPLOAD_SUBMIT</xsl:param>
   <xsl:param name="submit-type-warn-delete-role-approve">CHECKER_WARN_DELETE_ROLE_SUBMIT</xsl:param>   
   <xsl:param name="option"><xsl:value-of select="utils:getParamaterName($rundata,'option')"/></xsl:param>
   
   <xsl:param name="show-save">Y</xsl:param>
   
   <xsl:variable name="saveButtonId">
    	<xsl:choose>
    		<xsl:when test="$second-menu='Y'">sySubmitButton2</xsl:when>
    		<xsl:otherwise>sySubmitButton</xsl:otherwise>
    	</xsl:choose>
    </xsl:variable>
    <xsl:variable name="cancelButtonId">
    	<xsl:choose>
    		<xsl:when test="$second-menu='Y'">cancelButton2</xsl:when>
    		<xsl:otherwise>menuCancelButton</xsl:otherwise>
    	</xsl:choose>
    </xsl:variable>
    <xsl:variable name="helpButtonId">
    	<xsl:choose>
    		<xsl:when test="$second-menu='Y'">helpButton2</xsl:when>
    		<xsl:otherwise>helpButton</xsl:otherwise>
    	</xsl:choose>
    </xsl:variable>        
   <xsl:variable name="approveButtonId">
     	<xsl:choose>
     		<xsl:when test="$second-menu='Y'">approveButton2</xsl:when>
     		<xsl:otherwise>approveButton</xsl:otherwise>
     	</xsl:choose>
   </xsl:variable>
   <xsl:variable name="revertButtonId">
     	<xsl:choose>
     		<xsl:when test="$second-menu='Y'">revertButton2</xsl:when>
     		<xsl:otherwise>revertButton</xsl:otherwise>
     	</xsl:choose>
   </xsl:variable>
   <xsl:variable name="deleteButtonId">
     	<xsl:choose>
     		<xsl:when test="$second-menu='Y'">deleteButton2</xsl:when>
     		<xsl:otherwise>deleteButton</xsl:otherwise>
     	</xsl:choose>
   </xsl:variable>
   <xsl:variable name="returnButtonId">
     	<xsl:choose>
     		<xsl:when test="$second-menu='Y'">returnButton2</xsl:when>
     		<xsl:otherwise>returnButton</xsl:otherwise>
     	</xsl:choose>
   </xsl:variable>
   <xsl:variable name="draftButtonId">
     	<xsl:choose>
     		<xsl:when test="$second-menu='Y'">draftButton2</xsl:when>
     		<xsl:otherwise>draftButton</xsl:otherwise>
     	</xsl:choose>
   </xsl:variable>
    <div class="menu widgetContainer">
    <xsl:call-template name="hidden-field">
    	<!-- <xsl:with-param name="name">master_url</xsl:with-param> -->
    	<xsl:with-param name="id">master_url</xsl:with-param>
    	<xsl:with-param name="value"><xsl:value-of select="$master_url"/></xsl:with-param>
    </xsl:call-template>
    <xsl:choose>
	    <xsl:when test="$screenMode ='checker'">
	    <xsl:if test="$displaymode='view' and $isMakerCheckerMode='true'">
			    <xsl:choose>
			    <!-- If maker checker state is delete then show delete button -->
				<xsl:when test="$makerCheckerState='12' and $option='ROLE_MAINTENANCE_MC'">
				     <xsl:call-template name="button-wrapper">
				      <xsl:with-param name="label">XSL_ACTION_APPROVE</xsl:with-param>
				 	  <xsl:with-param name="id" select="$deleteButtonId"></xsl:with-param>      
				      <xsl:with-param name="onclick">misys.submit('<xsl:value-of select="$submit-type-warn-delete-role-approve"/>');return false;</xsl:with-param>
				      <xsl:with-param name="show-text-label">Y</xsl:with-param>
				     </xsl:call-template>
				</xsl:when>
			    <xsl:when test="$makerCheckerState='12' and $option!='ROLE_MAINTENANCE_MC'">
				     <xsl:call-template name="button-wrapper">
				      <xsl:with-param name="label">XSL_ACTION_APPROVE</xsl:with-param>
				 	  <xsl:with-param name="id" select="$deleteButtonId"></xsl:with-param>      
				      <xsl:with-param name="onclick">misys.submit('DELETE');return false;</xsl:with-param>
				      <xsl:with-param name="show-text-label">Y</xsl:with-param>
				     </xsl:call-template>
				</xsl:when>
				
				 <xsl:when test="$makerCheckerState!='12' and ($option='BENEFICIARY_MASTER_MAINTENANCE_MC' or $option='CUSTOMER_BENEFICIARY_MASTER_MAINTENANCE_MC')" >
	                  <xsl:call-template name="button-wrapper">
	                  	<xsl:with-param name="label">XSL_ACTION_APPROVE</xsl:with-param>
	                  	<xsl:with-param name="id" select="$approveButtonId"></xsl:with-param>
	                    <xsl:with-param name="onclick">misys.submit('<xsl:value-of select="$submit-type-bene-approve"/>');return false;</xsl:with-param>
	                    <xsl:with-param name="show-text-label">Y</xsl:with-param>
	                  </xsl:call-template>
	             </xsl:when>
	             <xsl:when test="$makerCheckerState!='12' and ($option='BENEFICIARY_FILE_UPLOAD_MC' or $option='CUSTOMER_BENEFICIARY_UPLOAD_MAINTENANCE_MC')">
	                  <xsl:call-template name="button-wrapper">
	                  	<xsl:with-param name="label">XSL_ACTION_APPROVE</xsl:with-param>
	                    <xsl:with-param name="id" select="$approveButtonId"></xsl:with-param>
	                    <xsl:with-param name="onclick">misys.submit('<xsl:value-of select="$submit-type-bene-file-upload-approve"/>');return false;</xsl:with-param>
	                    <xsl:with-param name="show-text-label">Y</xsl:with-param>
	                  </xsl:call-template>
                  </xsl:when>
	             <xsl:when test = "$makerCheckerState!='12' and $option!='BENEFICIARY_MASTER_MAINTENANCE_MC' and $option!='BENEFICIARY_FILE_UPLOAD_MC' and $option!='CUSTOMER_BENEFICIARY_MASTER_MAINTENANCE_MC' and $option!='CUSTOMER_BENEFICIARY_UPLOAD_MAINTENANCE_MC'">
				    <xsl:call-template name="button-wrapper">
				      <xsl:with-param name="label">XSL_ACTION_APPROVE</xsl:with-param>
				 	  <xsl:with-param name="id" select="$approveButtonId"></xsl:with-param>      
				      <xsl:with-param name="onclick">misys.submit('APPROVE');return false;</xsl:with-param>
				      <xsl:with-param name="show-text-label">Y</xsl:with-param>
				     </xsl:call-template>
				 </xsl:when>
			    </xsl:choose>
			 	<xsl:call-template name="button-wrapper">
			      <xsl:with-param name="label">XSL_ACTION_REVERT</xsl:with-param>
			 	  <xsl:with-param name="id" select="$revertButtonId"></xsl:with-param>      
			      <xsl:with-param name="onclick">misys.submit('REVERT');return false;</xsl:with-param>
			      <xsl:with-param name="show-text-label">Y</xsl:with-param>
			    </xsl:call-template>
			    <xsl:if test="$allowReturnAction = 'true'">
					<xsl:call-template name="button-wrapper">
				      <xsl:with-param name="label">XSL_ACTION_RETURN</xsl:with-param>
				 	  <xsl:with-param name="id" select="$returnButtonId"></xsl:with-param>      
				      <xsl:with-param name="onclick">misys.submit('RETURN');return false;</xsl:with-param>
				      <xsl:with-param name="show-text-label">Y</xsl:with-param>
				    </xsl:call-template>
			    </xsl:if>
			    <xsl:call-template name="button-wrapper">
			      <xsl:with-param name="label">XSL_ACTION_CANCEL</xsl:with-param>
			      <xsl:with-param name="id" select="$cancelButtonId"></xsl:with-param>
			      <xsl:with-param name="class">cancelButton</xsl:with-param>
			      <xsl:with-param name="show-text-label">Y</xsl:with-param>
			    </xsl:call-template>
		 </xsl:if>
		 </xsl:when>
		 <xsl:otherwise>
		 	<xsl:if test="$allowDraftMode = 'true' and $isMakerCheckerMode='true' and $show-save='Y' and $displaymode!='view' ">
			 	<xsl:call-template name="button-wrapper">
			      <xsl:with-param name="label">XSL_ACTION_SAVE</xsl:with-param>
			 	  <xsl:with-param name="id" select="$draftButtonId"></xsl:with-param>      
			      <xsl:with-param name="onclick">misys.submit('DRAFT');return false;</xsl:with-param>
			      <xsl:with-param name="show-text-label">Y</xsl:with-param>
				</xsl:call-template>
			</xsl:if>
			<xsl:if test="$hideStandardMenu = 'false'">
				<xsl:if test="$makerCheckerState='12'">
				<xsl:call-template name="button-wrapper">
				   <xsl:with-param name="label">XSL_ACTION_DELETE</xsl:with-param>
				 	  <xsl:with-param name="id" select="$deleteButtonId"></xsl:with-param>      
				      <xsl:with-param name="onclick">misys.submit('<xsl:value-of select="$submit-type"/>');return false;</xsl:with-param>
				      <xsl:with-param name="show-text-label">Y</xsl:with-param>
				</xsl:call-template>
				</xsl:if>
				
				<xsl:if test="$makerCheckerState!='12' and ($option='BENEFICIARY_MASTER_MAINTENANCE_MC' or $option='CUSTOMER_BENEFICIARY_MASTER_MAINTENANCE_MC')">
                    <xsl:call-template name="button-wrapper">
	                	<xsl:with-param name="label">ACTION_USER_SUBMIT</xsl:with-param>
	                	<xsl:with-param name="id" select="$saveButtonId"></xsl:with-param>
	                	<xsl:with-param name="show-text-label">Y</xsl:with-param>
	                	<xsl:with-param name="onclick">misys.submit('<xsl:value-of select="$submit-type-bene"/>');return false;</xsl:with-param>
	               </xsl:call-template>
	            </xsl:if>
	                  
				 <xsl:if test="$makerCheckerState!='12' and ($option='BENEFICIARY_FILE_UPLOAD_MC' or $option='CUSTOMER_BENEFICIARY_UPLOAD_MAINTENANCE_MC')">
				<xsl:call-template name="button-wrapper">
			      <xsl:with-param name="label">ACTION_USER_SUBMIT</xsl:with-param>
			 	  <xsl:with-param name="id" select="$saveButtonId"></xsl:with-param>      
			      <xsl:with-param name="show-text-label">Y</xsl:with-param>
			      <xsl:with-param name="onclick">misys.submit('<xsl:value-of select="$submit-type-bene-file-upload"/>');return false;</xsl:with-param>
			    </xsl:call-template>
			    </xsl:if>
			    
			      <xsl:if test="$displaymode!='view' and $makerCheckerState!='12' and $option!='BENEFICIARY_MASTER_MAINTENANCE_MC' and $option!='BENEFICIARY_FILE_UPLOAD_MC' and $option!='CUSTOMER_BENEFICIARY_MASTER_MAINTENANCE_MC' and $option!='CUSTOMER_BENEFICIARY_UPLOAD_MAINTENANCE_MC'">
                  	<xsl:call-template name="button-wrapper">
	                	<xsl:with-param name="label">ACTION_USER_SUBMIT</xsl:with-param>
	                	<xsl:with-param name="id" select="$saveButtonId"></xsl:with-param>
	                    <xsl:with-param name="show-text-label">Y</xsl:with-param>
	                    <xsl:with-param name="onclick">misys.submit('<xsl:value-of select="$submit-type"/>');return false;</xsl:with-param>
	              	</xsl:call-template>
	              </xsl:if>
			      <!-- <xsl:if test="$displaymode!='view'"> -->
				    <xsl:call-template name="button-wrapper">
				      <xsl:with-param name="label">XSL_ACTION_CANCEL</xsl:with-param>
				      <xsl:with-param name="id" select="$cancelButtonId"></xsl:with-param>
				      <xsl:with-param name="class">cancelButton</xsl:with-param>
				      <xsl:with-param name="show-text-label">Y</xsl:with-param>
				    </xsl:call-template>
				 <!--  </xsl:if> -->
				 <!--  <xsl:if test="$displaymode!='view'"> -->
				    <xsl:call-template name="button-wrapper">
				      <xsl:with-param name="label">XSL_ACTION_HELP</xsl:with-param>
				       <xsl:with-param name="id" select="$helpButtonId"></xsl:with-param>
				       <xsl:with-param name="class">helpButton</xsl:with-param>
				       <xsl:with-param name="show-text-label">Y</xsl:with-param>
				    </xsl:call-template>
				  <!-- </xsl:if> -->
		    </xsl:if>
		 </xsl:otherwise>
     </xsl:choose>
    </div>
   <!-- We put the display mode in a global variable to know in js in what mode we are. The code is here solely because this should be included in every page. -->
    <script>
		dojo.ready(function(){
    	misys._config = misys._config || {};
		dojo.mixin(misys._config, {
			displayMode : '<xsl:value-of select="$displaymode"/>'
		});
		dojo.require("misys.binding.core.maker_checker_common");
	});       
    </script>
  	</xsl:template>
    
    <!-- Template for return comments component -->
    <xsl:template name="comments-for-return-mc">
    <xsl:param name="value" />
   		<xsl:call-template name="fieldset-wrapper">
	  		<xsl:with-param name="legend">XSL_HEADER_MC_COMMENTS_FOR_RETURN</xsl:with-param>
	   		<xsl:with-param name="id">comments-for-return</xsl:with-param>
	   		<xsl:with-param name="content">
			    <xsl:call-template name="textarea-field">
					<xsl:with-param name="label"></xsl:with-param>
					<xsl:with-param name="name">return_comments</xsl:with-param>
					<xsl:with-param name="messageValue"><xsl:value-of select="$value"/></xsl:with-param>
					<xsl:with-param name="rows">5</xsl:with-param>
				   	<xsl:with-param name="cols">50</xsl:with-param>
			   		<xsl:with-param name="maxlines">5</xsl:with-param>
			   		<xsl:with-param name="maxlength">250</xsl:with-param>
			   		<xsl:with-param name="override-displaymode" select="$checkerReturnCommentsMode"></xsl:with-param>
			 	</xsl:call-template>
	   		</xsl:with-param>
   		</xsl:call-template>
   </xsl:template>
</xsl:stylesheet>