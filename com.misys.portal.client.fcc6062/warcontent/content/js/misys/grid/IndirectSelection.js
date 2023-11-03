/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["misys.grid.IndirectSelection"]){dojo._hasResource["misys.grid.IndirectSelection"]=true;dojo.provide("misys.grid.IndirectSelection");dojo.require("dojo.string");dojo.require("dojox.grid.cells.dijit");dojo.require("dojox.grid.enhanced._Plugin");dojo.declare("misys.grid.IndirectSelection",dojox.grid.enhanced._Plugin,{name:"misysIndirectSelection",constructor:function(){var _1=this.grid.layout;this.connect(_1,"setStructure",dojo.hitch(_1,this.addRowSelectCell,this.option));},addRowSelectCell:function(_2){if(!this.grid.misysIndirectSelection||this.grid.selectionMode=="none"){return;}var _3=false,_4=["get","formatter","field","fields"],_5={type:misys.grid.MultipleRowSelector,name:"",width:"30px",styles:"text-align: center;"};if(_2.headerSelector){_2.name="";}if(this.grid.rowSelectCell){this.grid.rowSelectCell.destroy();}dojo.forEach(this.structure,function(_6){var _7=_6.cells;if(_7&&_7.length>0&&!_3){var _8=_7[0];if(_8[0]&&_8[0].isRowSelector){_3=true;return;}var _9,_a=this.grid.selectionMode=="single"?misys.grid.SingleRowSelector:misys.grid.MultipleRowSelector;_9=dojo.mixin(_5,_2,{type:_a,editable:false,notselectable:true,filterable:false,navigatable:true,nosort:true});dojo.forEach(_4,function(_b){if(_b in _9){delete _9[_b];}});if(_7.length>1){_9.rowSpan=_7.length;}dojo.forEach(this.cells,function(_c,i){if(_c.index>=0){_c.index+=1;}else{console.warn("Error:IndirectSelection.addRowSelectCell()-  cell "+i+" has no index!");}});var _d=this.addCellDef(0,0,_9);_d.index=0;_8.unshift(_d);this.cells.unshift(_d);this.grid.rowSelectCell=_d;_3=true;}},this);this.cellCount=this.cells.length;},destroy:function(){if(this.grid&&this.grid.rowSelectCell){this.grid.rowSelectCell.destroy();delete this.grid.rowSelectCell;}this.inherited(arguments);}});dojo.declare("misys.grid.RowSelector",dojox.grid.cells._Widget,{inputType:"",map:null,disabledMap:null,isRowSelector:true,_connects:null,_subscribes:null,checkedText:"&#8730;",unCheckedText:"O",constructor:function(){this.map={};this.disabledMap={};this.disabledCount=0;this._connects=[];this._subscribes=[];this.inA11YMode=dojo.hasClass(dojo.body(),"dijit_a11y");this.baseClass="dojoxGridRowSelector dijitReset dijitInline dijit"+this.inputType;this.checkedClass=" dijit"+this.inputType+"Checked";this.disabledClass=" dijit"+this.inputType+"Disabled";this.checkedDisabledClass=" dijit"+this.inputType+"CheckedDisabled";this.statusTextClass=" dojoxGridRowSelectorStatusText";this._connects.push(dojo.connect(this.grid,"dokeyup",this,"_dokeyup"));this._connects.push(dojo.connect(this.grid.selection,"onSelected",this,"_onSelected"));this._connects.push(dojo.connect(this.grid.selection,"onDeselected",this,"_onDeselected"));this._connects.push(dojo.connect(this.grid.scroller,"invalidatePageNode",this,"_pageDestroyed"));this._connects.push(dojo.connect(this.grid,"onCellClick",this,"_onClick"));this._connects.push(dojo.connect(this.grid,"updateRow",this,"_onUpdateRow"));},formatter:function(_e,_f){var _10=this.baseClass;var _11=this.getValue(_f);var _12=!!this.disabledMap[_f];if(_11){_10+=this.checkedClass;if(_12){_10+=this.checkedDisabledClass;}}else{if(_12){_10+=this.disabledClass;}}if(window.isAccessibilityEnabled&&window.isAccessibilityEnabled===true){var _13="";try{var _14=dojo.attr(this.grid.id+"_rowSelector_a11y-1-context","innerHTML");var _15=dojo.attr(this.grid.id+"_rowSelector_a11y-1-keys","innerHTML").split(",");var _16=this.grid.store;var _17=_16._items[_f];var _18=dojo.map(_15,function(key){return _16.getValue(_17,key);});_13=misys.getLocalization("unchecked")+dojo.string.substitute(_14,_18);}catch(exc){_13="Onclick selects/deselects the row ";}return ["<div tabindex = -1 ","id = '"+this.grid.id+"_rowSelector_"+_f+"' ","name = '"+this.grid.id+"_rowSelector' class = '"+_10+"' ","role = 'checkbox' aria-checked = '"+_11+"' aria-disabled = '"+_12+"' aria-label = '"+dojo.string.substitute(this.grid._nls["indirectSelection"+this.inputType],[_f+1])+(_11?this.checkedText:this.unCheckedText)+"'>","<span class = '"+this.statusTextClass+"'>"+(_11?this.checkedText:this.unCheckedText)+"</span>","<span class = 'sr-only' aria-live='polite' id='"+this.grid.id+"_rowSelector_"+_f+"_a11y_text' class='sr-only'>"+_13+" </span>","</div>"].join("");}else{return ["<div tabindex = -1 ","id = '"+this.grid.id+"_rowSelector_"+_f+"' ","name = '"+this.grid.id+"_rowSelector' class = '"+_10+"' ","role = 'presentation' aria-checked = '"+_11+"' aria-disabled = '"+_12+"' aria-label = '"+dojo.string.substitute(this.grid._nls["indirectSelection"+this.inputType],[_f+1])+"'>","<span class = '"+this.statusTextClass+"'>"+(_11?this.checkedText:this.unCheckedText)+"</span>","</div>"].join("");}},setValue:function(_19,_1a){},getValue:function(_1b){return this.grid.selection.isSelected(_1b);},toggleRow:function(_1c,_1d){this._nativeSelect(_1c,_1d);},setDisabled:function(_1e,_1f){if(_1e<0){return;}this._toggleDisabledStyle(_1e,_1f);},disabled:function(_20){return !!this.disabledMap[_20];},_onClick:function(e){if(e.cell===this){this._selectRow(e);}},_dokeyup:function(e){if(e.cellIndex==this.index&&e.rowIndex>=0&&(e.keyCode==dojo.keys.SPACE||e.keyCode==dojo.keys.ENTER)){this._selectRow(e);}},focus:function(_21){var _22=this.map[_21];if(_22){_22.focus();}},_focusEndingCell:function(_23,_24){var _25=this.grid.getCell(_24);this.grid.focus.setFocusCell(_25,_23);},_nativeSelect:function(_26,_27){this.grid.selection[_27?"select":"deselect"](_26);},_onSelected:function(_28){this._toggleCheckedStyle(_28,true);},_onDeselected:function(_29){this._toggleCheckedStyle(_29,false);},_onUpdateRow:function(_2a){delete this.map[_2a];},_toggleCheckedStyle:function(_2b,_2c){var _2d=this._getSelector(_2b);if(_2d){dojo.toggleClass(_2d,this.checkedClass,_2c);if(this.disabledMap[_2b]){dojo.toggleClass(_2d,this.checkedDisabledClass,_2c);}dijit.setWaiState(_2d,"checked",_2c);if(this.inA11YMode){dojo.attr(_2d.firstChild,"innerHTML",_2c?this.checkedText:this.unCheckedText);}if(window.isAccessibilityEnabled&&window.isAccessibilityEnabled===true){var _2e=(_2c)?(this.inputType+" "+misys.getLocalization("checked")+"."):(this.inputType+" "+misys.getLocalization("unchecked")+".");dojo.attr(dojo.query("#"+this.grid.id+"_rowSelector_"+_2b)[0],"aria-label",dojo.string.substitute(this.grid._nls["indirectSelection"+this.inputType],[_2b+1])+" "+_2e);try{var _2f=dojo.attr(dojo.query("#"+this.grid.id+"_rowSelector_"+_2b+"_a11y_text")[0],"innerHTML");_2f=_2f.replace(misys.getLocalization("unchecked"),"");_2f=_2f.replace(misys.getLocalization("checked"),"");var _30=(_2c)?misys.getLocalization("checked"):misys.getLocalization("unchecked");dojo.attr(dojo.query("#"+this.grid.id+"_rowSelector_"+_2b+"_a11y_text")[0],"innerHTML",_30+_2f);}catch(exc){}}}},_toggleDisabledStyle:function(_31,_32){var _33=this._getSelector(_31);if(_33){dojo.toggleClass(_33,this.disabledClass,_32);if(this.getValue(_31)){dojo.toggleClass(_33,this.checkedDisabledClass,_32);}dijit.setWaiState(_33,"disabled",_32);}this.disabledMap[_31]=_32;if(_31>=0){this.disabledCount+=_32?1:-1;}},_getSelector:function(_34){var _35=this.map[_34];if(!_35){var _36=this.view.rowNodes[_34];if(_36){_35=dojo.query(".dojoxGridRowSelector",_36)[0];if(_35){this.map[_34]=_35;}}}return _35;},_pageDestroyed:function(_37){var _38=this.grid.scroller.rowsPerPage;var _39=_37*_38,end=_39+_38-1;for(var i=_39;i<=end;i++){if(!this.map[i]){continue;}dojo.destroy(this.map[i]);delete this.map[i];}},destroy:function(){for(var i in this.map){dojo.destroy(this.map[i]);delete this.map[i];}for(i in this.disabledMap){delete this.disabledMap[i];}dojo.forEach(this._connects,dojo.disconnect);dojo.forEach(this._subscribes,dojo.unsubscribe);delete this._connects;delete this._subscribes;}});dojo.declare("misys.grid.SingleRowSelector",misys.grid.RowSelector,{inputType:"Radio",_selectRow:function(e){var _3a=e.rowIndex;if(this.disabledMap[_3a]){return;}this._focusEndingCell(_3a,0);this._nativeSelect(_3a,!this.grid.selection.selected[_3a]);}});dojo.declare("misys.grid.MultipleRowSelector",misys.grid.RowSelector,{inputType:"CheckBox",swipeStartRowIndex:-1,swipeMinRowIndex:-1,swipeMaxRowIndex:-1,toSelect:false,lastClickRowIdx:-1,toggleAllTrigerred:false,unCheckedText:"&#9633;",constructor:function(){this._connects.push(dojo.connect(dojo.doc,"onmouseup",this,"_domouseup"));this._connects.push(dojo.connect(this.grid,"onRowMouseOver",this,"_onRowMouseOver"));this._connects.push(dojo.connect(this.grid.focus,"move",this,"_swipeByKey"));this._connects.push(dojo.connect(this.grid,"onCellMouseDown",this,"_onMouseDown"));if(this.headerSelector){this._connects.push(dojo.connect(this.grid.views,"render",this,"_addHeaderSelector"));this._connects.push(dojo.connect(this.grid,"onSelectionChanged",this,"_onSelectionChanged"));this._connects.push(dojo.connect(this.grid,"onKeyDown",this,function(e){if(e.rowIndex==-1&&e.cellIndex==this.index&&(e.keyCode==dojo.keys.SPACE||e.keyCode==dojo.keys.ENTER)){this._toggletHeader();}}));}},toggleAllSelection:function(_3b){var _3c=this.grid,_3d=_3c.selection;if(_3b){_3d.selectRange(0,_3c.rowCount-1);}else{_3d.deselectAll();}this.toggleAllTrigerred=true;var _3e=this.grid.rowCount;for(var i=0;i<_3e;i++){var _3f=this.grid.getItem(i);var _40;if(_3f){_40=this.grid.store.getValue(_3f,"disable_selection");}if(_40==="Y"){this.grid.rowSelectCell.toggleRow(i,false);}}},_onMouseDown:function(e){if(e.cell==this){this._startSelection(e.rowIndex);dojo.stopEvent(e);}},_onRowMouseOver:function(e){this._updateSelection(e,0);},_domouseup:function(e){if(dojo.isIE){this.view.content.decorateEvent(e);}var _41=e.cellIndex>=0&&this.inSwipeSelection()&&!this.grid.edit.isEditRow(e.rowIndex);if(_41){this._focusEndingCell(e.rowIndex,e.cellIndex);}this._finishSelect();},_dokeyup:function(e){this.inherited(arguments);if(!e.shiftKey){this._finishSelect();}},_startSelection:function(_42){this.swipeStartRowIndex=this.swipeMinRowIndex=this.swipeMaxRowIndex=_42;this.toSelect=!this.getValue(_42);},_updateSelection:function(e,_43){if(!this.inSwipeSelection()){return;}var _44=_43!==0;var _45=e.rowIndex,_46=_45-this.swipeStartRowIndex+_43;if(_46>0&&this.swipeMaxRowIndex<_45+_43){this.swipeMaxRowIndex=_45+_43;}if(_46<0&&this.swipeMinRowIndex>_45+_43){this.swipeMinRowIndex=_45+_43;}var min=_46>0?this.swipeStartRowIndex:_45+_43;var max=_46>0?_45+_43:this.swipeStartRowIndex;for(var i=this.swipeMinRowIndex;i<=this.swipeMaxRowIndex;i++){if(this.disabledMap[i]||i<0){continue;}if(i>=min&&i<=max){this._nativeSelect(i,this.toSelect);}else{if(!_44){this._nativeSelect(i,!this.toSelect);}}}},_swipeByKey:function(_47,_48,e){if(!e||_47===0||!e.shiftKey||e.cellIndex!=this.index||this.grid.focus.rowIndex<0){return;}var _49=e.rowIndex;if(this.swipeStartRowIndex<0){this.swipeStartRowIndex=_49;if(_47>0){this.swipeMaxRowIndex=_49+_47;this.swipeMinRowIndex=_49;}else{this.swipeMinRowIndex=_49+_47;this.swipeMaxRowIndex=_49;}this.toSelect=this.getValue(_49);}this._updateSelection(e,_47);},_finishSelect:function(){this.swipeStartRowIndex=-1;this.swipeMinRowIndex=-1;this.swipeMaxRowIndex=-1;this.toSelect=false;},inSwipeSelection:function(){return this.swipeStartRowIndex>=0;},_nativeSelect:function(_4a,_4b){this.grid.selection[_4b?"addToSelection":"deselect"](_4a);},_selectRow:function(e){var _4c=e.rowIndex;if(this.disabledMap[_4c]){return;}dojo.stopEvent(e);this._focusEndingCell(_4c,0);var _4d=_4c-this.lastClickRowIdx;var _4e=!this.grid.selection.selected[_4c];if(this.lastClickRowIdx>=0&&!e.ctrlKey&&!e.altKey&&e.shiftKey){var min=_4d>0?this.lastClickRowIdx:_4c;var max=_4d>0?_4c:this.lastClickRowIdx;for(var i=min;i>=0&&i<=max;i++){this._nativeSelect(i,_4e);}}else{this._nativeSelect(_4c,_4e);}this.lastClickRowIdx=_4c;},getValue:function(_4f){if(_4f==-1){var g=this.grid;return g.rowCount>0&&g.rowCount<=g.selection.getSelectedCount();}return this.inherited(arguments);},_addHeaderSelector:function(){var _50=this.view.getHeaderCellNode(this.index);if(!_50){return;}dojo.empty(_50);var g=this.grid;var _51=null;if(window.isAccessibilityEnabled&&window.isAccessibilityEnabled===true){if(!dojo.byId(g.id+"_rowSelector_a11y-1-context")){var _52=dojo.filter(this.grid.layout.cells,function(_53){return (_53.a11ySelectionContext==="true");});var _54="";var _55="";var _56=0;dojo.map(_52,function(_57){if(_54==""){_54=_57.name+": ${"+(_56++)+"}";_55=_57.field;}else{_54=_54+", "+misys.getLocalization("with")+" "+_57.name+" ${"+(_56++)+"}";_55=_55+","+_57.field;}});this.grid.domNode.appendChild(dojo.create("span",{"id":g.id+"_rowSelector_a11y-1-context","class":"sr-only","innerHTML":_54}));this.grid.domNode.appendChild(dojo.create("span",{"id":g.id+"_rowSelector_a11y-1-keys","class":"sr-only","innerHTML":_55}));}_51=_50.appendChild(dojo.create("div",{"tabindex":-1,"id":g.id+"_rowSelector_-1","class":this.baseClass,"role":"checkbox","aria-checked":"false","aria-describedby":g.id+"_rowSelector_a11y-1-text","innerHTML":"<span  class = 'sr-only' aria-live='polite' id='"+g.id+"_rowSelector_a11y-1-text' class='sr-only'/>"}));}else{_51=_50.appendChild(dojo.create("div",{"tabindex":-1,"id":g.id+"_rowSelector_-1","class":this.baseClass,"role":"presentation","innerHTML":"<span class = '"+this.statusTextClass+"'></span><span style='height: 0; width: 0; overflow: hidden; display: block;'>"+g._nls["selectAll"]+"</span>"}));}this.map[-1]=_51;var idx=this._headerSelectorConnectIdx;if(idx!==undefined){dojo.disconnect(this._connects[idx]);this._connects.splice(idx,1);}this._headerSelectorConnectIdx=this._connects.length;this._connects.push(dojo.connect(_51,"onclick",this,"_toggletHeader"));if(window.isAccessibilityEnabled&&window.isAccessibilityEnabled===true){try{var _58=misys.getLocalization("unchecked")+this.grid.paginationEnhanced.plugin.paginators[0].descriptionDiv.innerHTML;dojo.attr(this.grid.id+"_rowSelector_a11y-1-text","innerHTML",_58);}catch(exc){}}this._onSelectionChanged();},_toggletHeader:function(){if(!!this.disabledMap[-1]){return;}this.grid._selectingRange=true;this.toggleAllSelection(!this.getValue(-1));this._onSelectionChanged();this.grid._selectingRange=false;if(window.isAccessibilityEnabled&&window.isAccessibilityEnabled===true){try{var _59=this.grid.paginationEnhanced.plugin.paginators[0].descriptionDiv.innerHTML;var _5a=!this.getValue(-1)?misys.getLocalization("unchecked"):misys.getLocalization("checked");dojo.attr(this.grid.id+"_rowSelector_a11y-1-text","innerHTML",_5a+_59);}catch(exc){}}},_onSelectionChanged:function(){var g=this.grid;if(!this.map[-1]||g._selectingRange){return;}this._toggleCheckedStyle(-1,this.getValue(-1));},_toggleDisabledStyle:function(_5b,_5c){this.inherited(arguments);if(this.headerSelector){var _5d=(this.grid.rowCount==this.disabledCount);if(_5d!=!!this.disabledMap[-1]){arguments[0]=-1;arguments[1]=_5d;this.inherited(arguments);}}}});dojox.grid.EnhancedGrid.registerPlugin(misys.grid.IndirectSelection,{"preInit":true});}