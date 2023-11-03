<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet 
		version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
		xmlns:localization="xalan://com.neomalogic.gtp.common.localization.Localization"
		xmlns:backoffice="xalan://com.misys.portal.loaniq.LoanIQAdapter"
		exclude-result-prefixes="localization backoffice">


<xsl:output method="html" version="4.01" indent="no" encoding="UTF-8" omit-xml-declaration="yes" />


<!-- parameters -->
<xsl:param name="collaborationmode">none</xsl:param>
<xsl:param name="displaymode">edit</xsl:param>
<xsl:param name="language" />
<xsl:param name="mode">DRAFT</xsl:param>
<xsl:param name="product-code">LN</xsl:param>
<xsl:param name="realform-action"><xsl:value-of select="$contextPath"/><xsl:value-of select="$servletPath"/>/screen/LoanScreen</xsl:param>
<xsl:param name="rundata" />


<!-- includes -->
<xsl:include href="../../core/xsl/common/trade_common.xsl" />


<xsl:key name="deals-by-id" match="deal" use="id" />


<xsl:template match="/">

	<!-- Javascript imports  -->
    <xsl:call-template name="js-imports" />

	<div id="facilities" style="width: 777px;">
		<!-- Preloader  -->
		<xsl:call-template name="loading-message" />
	</div>

	<script>
		// facilities data
		
		
		
		var facilities = {
			identifier: 'id',
			label: 'name',
			items: [
				<xsl:for-each select="//deal[generate-id() = generate-id(key('deals-by-id', id)[1])]">
					<xsl:call-template name="deal" />
					<xsl:if test="position()!=last()">,</xsl:if>
				</xsl:for-each>
			]
		};
		
		// store
		var facilitiesStore = new dojo.data.ItemFileReadStore(
			{
				data: facilities
			}
		);

		// grid layout
		var layout = [
		{
			field: 'deal',
			name: 'Deal',
			styles: 'text-align: center;',
			width: '30%'
		},
		{
			field: 'facility',
			name: 'Facility',
			styles: 'text-align: center;',
			width: '30%'
		},
		{
			field: 'fcn',
			name: 'FCN',
			styles: 'text-align: center;',
			width: '6em'
		},
		{
			field: 'borrower',
			name: 'Borrower',
			styles: 'text-align: center;',
			width: '8em'
		},
		{
			field: 'available',
			name: 'Available',
			styles: 'text-align: center;',
			width: '8em'
		},
		{
			field: 'currency',
			name: 'Currency',
			styles: 'text-align: center;',
			width: '4em'
		},
		{
			field: 'expiry_date',
			name: 'Expiry Date',
			styles: 'text-align: center;',
			width: '6em'
		},
		{
			field: 'maturity_date',
			name: 'Maturity Date',
			styles: 'text-align: center;',
			width: '6em'
		}];
	
		// tree model
		var treeModel = new dijit.tree.ForestStoreModel(
		{
			childrenAttrs: ['children'],
			query: { deal: '*' },
			store: facilitiesStore 
		});
	
		// grid		
		var facilitiesGrid = new dojox.grid.TreeGrid(
		{
			autoHeight: 20,
			defaultOpen: true,
			structure: layout,
			treeModel: treeModel
		}, document.createElement('div'));
	</script>
	
</xsl:template>


<!-- Additional JS imports for this form -->
<xsl:template name="js-imports">
	<xsl:call-template name="common-js-imports">
		<xsl:with-param name="xml-tag-name">XXX_FIXME_XXX</xsl:with-param>
		<xsl:with-param name="binding">misys.binding.loan.deal_list</xsl:with-param>
	</xsl:call-template>
</xsl:template>


<xsl:template name="deal">
	{
		<xsl:variable name="deal_id" select="id" />
		id: "<xsl:value-of select="$deal_id" />",
		deal: "<xsl:value-of select="name" />",
		facility: '',
		fcn: '',
		borrower: '',
		available: '',
		currency: '',
		expiry_date: '',
		maturity_date: '',
		children: [
			<xsl:for-each select='//deal[id=$deal_id]/facility'>
				<xsl:call-template name="facility" />
				<xsl:if test="position()!=last()">,</xsl:if>
			</xsl:for-each>
		]
	}
</xsl:template>


<xsl:template name="facility">
	{
		id: "<xsl:value-of select="id" />_<xsl:value-of select="../../id" />",
		deal: '',
		facility: "<xsl:value-of select="name" />",
		fcn: "<xsl:value-of select="fcn" />",
		borrower: "<xsl:value-of select="../../name" />",
		available: "<xsl:value-of select="available" />",
		currency: "<xsl:value-of select="currency" />",
		expiry_date: "<xsl:value-of select="backoffice:parseDate(expiryDate, $language)" />",
		maturity_date: "<xsl:value-of select="backoffice:parseDate(maturityDate, $language)" />",
		SCREEN: "LoanScreen?operation=NEW_DRAWDOWN&amp;tnxtype=01&amp;facilityid=<xsl:value-of select="id" />&amp;borrowerid=<xsl:value-of select="../../id" />"
	}
</xsl:template>
	
</xsl:stylesheet>
