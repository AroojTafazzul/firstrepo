/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.binding.cash.ktp.common.ktp_common"]){dojo._hasResource["misys.binding.cash.ktp.common.ktp_common"]=true;dojo.provide("misys.binding.cash.ktp.common.ktp_common");(function(d,dj,m){d.mixin(m,{exportListToFormat:function(_1){if(_1==="pdf"){_1="com.misys.portal.report.viewer.ViewerLandScapePDF";}dj.byId("export_list").set("value",_1);dj.byId("TransactionSearchForm").submit();dj.byId("export_list").set("value","screen");}});d.mixin(m,{setGridCellFormatter:function(){if(window){for(var _2 in window){if(_2.indexOf("gridLayout")===0){m.ktpGridId=_2.substr(10);var _3=window[_2];var _4=_3.cells;d.forEach(_4[0],function(_5){d.mixin(_5,{formatter:misys.ktpCellFormatter});});}}}},ktpCellFormatter:function(_6,_7){var _8=misys.grid.formatHTML(_6);return _8;},searchGridLayoutCellByFieldName:function(_9,_a){var _b;if(_9){var _c=_9.cells;_b=m.searchCellDefinitionByName(_c,_a);}return _b;},searchCellDefinitionByName:function(_d,_e){var _f;for(var i=0;i<_d.length;i++){_f=_d[i];if(d.isArray(_f)){_f=m.searchCellDefinitionByName(_f,_e);if(_f){break;}}else{if(_f.field===_e){break;}}}return _f;},searchGridLayout:function(){var _10;if(window){for(var _11 in window){if(_11.indexOf("gridLayout")===0){_10=window[_11];break;}}}return _10;},ibanFormatter:function(_12,_13){var _14,_15;if(_12.text){_14=_12.text.match(/.{1,4}/g);_15=_14.join(" ");_12.text=_15;return "<a href=\""+_12.href+"\">"+_12.text+"</a>";}if(_12.split(" ").join("").length==27&&_12.substring(0,2)==="FR"){_14=_12.match(/.{1,4}/g);_15="";if(_14){_15=_14.join(" ");}return "<a href=\""+"/portal/screen/CashInquiryScreen?ktpaccountno="+_12.split(" ").join("")+"&operation=KTP_REPORT_2"+"\">"+_15+"</a>";}else{_12=_12.split("&lt;").join("<");return _12;}},hideReportDescription:function(){var _16=d.query("#GTPRootPortlet > .portlet-section-body > .widgetContainer > b");if(_16&&_16.length>0){_16[0].style.display="none";}}});})(dojo,dijit,misys);}