/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["dijit.Calendar"]){dojo._hasResource["dijit.Calendar"]=true;dojo.provide("dijit.Calendar");dojo.require("dojo.cldr.supplemental");dojo.require("dojo.date");dojo.require("dojo.date.locale");dojo.require("dijit._Widget");dojo.require("dijit._Templated");dojo.require("dijit._CssStateMixin");dojo.require("dijit.form.DropDownButton");dojo.declare("dijit.Calendar",[dijit._Widget,dijit._Templated,dijit._CssStateMixin],{templateString:dojo.cache("dijit","templates/Calendar.html","<table cellspacing=\"0\" cellpadding=\"0\" class=\"dijitCalendarContainer\" role=\"grid\" dojoAttachEvent=\"onkeypress: _onKeyPress\" aria-labelledby=\"${id}_year\">\n\t<thead>\n\t\t<tr class=\"dijitReset dijitCalendarMonthContainer\" valign=\"top\">\n\t\t\t<th class='dijitReset dijitCalendarArrow' dojoAttachPoint=\"decrementMonth\">\n\t\t\t\t<img src=\"${_blankGif}\" alt=\"\" class=\"dijitCalendarIncrementControl dijitCalendarDecrease\" role=\"presentation\"/>\n\t\t\t\t<span dojoAttachPoint=\"decreaseArrowNode\" class=\"dijitA11ySideArrow\">-</span>\n\t\t\t</th>\n\t\t\t<th class='dijitReset' colspan=\"5\">\n\t\t\t\t<div dojoType=\"dijit.form.DropDownButton\" dojoAttachPoint=\"monthDropDownButton\"\n\t\t\t\t\tid=\"${id}_mddb\" tabIndex=\"-1\">\n\t\t\t\t</div>\n\t\t\t</th>\n\t\t\t<th class='dijitReset dijitCalendarArrow' dojoAttachPoint=\"incrementMonth\">\n\t\t\t\t<img src=\"${_blankGif}\" alt=\"\" class=\"dijitCalendarIncrementControl dijitCalendarIncrease\" role=\"presentation\"/>\n\t\t\t\t<span dojoAttachPoint=\"increaseArrowNode\" class=\"dijitA11ySideArrow\">+</span>\n\t\t\t</th>\n\t\t</tr>\n\t\t<tr>\n\t\t\t<th class=\"dijitReset dijitCalendarDayLabelTemplate\" role=\"columnheader\"><span class=\"dijitCalendarDayLabel\"></span></th>\n\t\t</tr>\n\t</thead>\n\t<tbody dojoAttachEvent=\"onclick: _onDayClick, onmouseover: _onDayMouseOver, onmouseout: _onDayMouseOut, onmousedown: _onDayMouseDown, onmouseup: _onDayMouseUp\" class=\"dijitReset dijitCalendarBodyContainer\">\n\t\t<tr class=\"dijitReset dijitCalendarWeekTemplate\" role=\"row\">\n\t\t\t<td class=\"dijitReset dijitCalendarDateTemplate\" role=\"gridcell\"><span class=\"dijitCalendarDateLabel\"></span></td>\n\t\t</tr>\n\t</tbody>\n\t<tfoot class=\"dijitReset dijitCalendarYearContainer\">\n\t\t<tr>\n\t\t\t<td class='dijitReset' valign=\"top\" colspan=\"7\">\n\t\t\t\t<h3 class=\"dijitCalendarYearLabel\">\n\t\t\t\t\t<span dojoAttachPoint=\"previousYearLabelNode\" class=\"dijitInline dijitCalendarPreviousYear\"></span>\n\t\t\t\t\t<span dojoAttachPoint=\"currentYearLabelNode\" class=\"dijitInline dijitCalendarSelectedYear\" id=\"${id}_year\"></span>\n\t\t\t\t\t<span dojoAttachPoint=\"nextYearLabelNode\" class=\"dijitInline dijitCalendarNextYear\"></span>\n\t\t\t\t</h3>\n\t\t\t</td>\n\t\t</tr>\n\t</tfoot>\n</table>\n"),widgetsInTemplate:true,value:new Date(""),datePackage:"dojo.date",dayWidth:"narrow",tabIndex:"0",currentFocus:new Date(),baseClass:"dijitCalendar",cssStateNodes:{"decrementMonth":"dijitCalendarArrow","incrementMonth":"dijitCalendarArrow","previousYearLabelNode":"dijitCalendarPreviousYear","nextYearLabelNode":"dijitCalendarNextYear"},_isValidDate:function(_1){return _1&&!isNaN(_1)&&typeof _1=="object"&&_1.toString()!=this.constructor.prototype.value.toString();},setValue:function(_2){dojo.deprecated("dijit.Calendar:setValue() is deprecated.  Use set('value', ...) instead.","","2.0");this.set("value",_2);},_getValueAttr:function(){var _3=new this.dateClassObj(this.value);_3.setHours(0,0,0,0);if(_3.getDate()<this.value.getDate()){_3=this.dateFuncObj.add(_3,"hour",1);}return _3;},_setValueAttr:function(_4,_5){if(_4){_4=new this.dateClassObj(_4);}if(this._isValidDate(_4)){if(!this._isValidDate(this.value)||this.dateFuncObj.compare(_4,this.value)){_4.setHours(1,0,0,0);if(!this.isDisabledDate(_4,this.lang)){this._set("value",_4);this.set("currentFocus",_4);if(_5||typeof _5=="undefined"){this.onChange(this.get("value"));this.onValueSelected(this.get("value"));}}}}else{this._set("value",null);this.set("currentFocus",this.currentFocus);}},_setText:function(_6,_7){while(_6.firstChild){_6.removeChild(_6.firstChild);}_6.appendChild(dojo.doc.createTextNode(_7));},_populateGrid:function(){var _8="";if(dijit.byId("customer_bank")&&dijit.byId("customer_bank").get("value")!==""&&misys&&misys._config&&misys._config.businessDateForBank&&misys._config.businessDateForBank&&[dijit.byId("customer_bank").get("value")][0]&&misys._config.businessDateForBank&&[dijit.byId("customer_bank").get("value")][0].value!==""){_8=misys._config.businessDateForBank[dijit.byId("customer_bank").get("value")][0].value;}else{if(dijit.byId("issuing_bank_abbv_name")&&dijit.byId("issuing_bank_abbv_name").get("value")!==""&&misys&&misys._config&&misys._config.businessDateForBank&&[dijit.byId("issuing_bank_abbv_name").get("value")][0]&&misys._config.businessDateForBank&&[dijit.byId("issuing_bank_abbv_name").get("value")][0].value!==""){_8=misys._config.businessDateForBank[dijit.byId("issuing_bank_abbv_name").get("value")][0].value;}else{if(dijit.byId("remitting_bank_abbv_name")&&dijit.byId("remitting_bank_abbv_name").get("value")!==""&&misys&&misys._config&&misys._config.businessDateForBank&&[dijit.byId("remitting_bank_abbv_name").get("value")][0]&&misys._config.businessDateForBank&&[dijit.byId("remitting_bank_abbv_name").get("value")][0].value!==""){_8=misys._config.businessDateForBank[dijit.byId("remitting_bank_abbv_name").get("value")][0].value;}else{if(dijit.byId("recipient_bank_abbv_name")&&dijit.byId("recipient_bank_abbv_name").get("value")!==""&&misys&&misys._config&&misys._config.businessDateForBank&&[dijit.byId("recipient_bank_abbv_name").get("value")][0]&&misys._config.businessDateForBank&&[dijit.byId("recipient_bank_abbv_name").get("value")][0].value!==""){_8=misys._config.businessDateForBank[dijit.byId("recipient_bank_abbv_name").get("value")][0].value;}else{if(dijit.byId("advising_bank_abbv_name")&&dijit.byId("advising_bank_abbv_name").get("value")!==""&&misys&&misys._config&&misys._config.businessDateForBank&&[dijit.byId("advising_bank_abbv_name").get("value")][0]&&misys._config.businessDateForBank&&[dijit.byId("advising_bank_abbv_name").get("value")][0].value!==""){_8=misys._config.businessDateForBank[dijit.byId("advising_bank_abbv_name").get("value")][0].value;}else{if(dijit.byId("bank_abbv_name")&&dijit.byId("bank_abbv_name").get("value")!==""&&misys&&misys._config&&misys._config.businessDateForBank&&[dijit.byId("bank_abbv_name").get("value")][0]&&misys._config.businessDateForBank&&[dijit.byId("bank_abbv_name").get("value")][0].value!==""){_8=misys._config.businessDateForBank[dijit.byId("bank_abbv_name").get("value")][0].value;}else{if(misys&&misys._config&&misys._config.bankBusinessDate&&misys._config.bankBusinessDate!==""){_8=misys._config.bankBusinessDate;}}}}}}}var _9=new this.dateClassObj(this.currentFocus);_9.setDate(1);var _a=_9.getDay(),_b=this.dateFuncObj.getDaysInMonth(_9),_c=this.dateFuncObj.getDaysInMonth(this.dateFuncObj.add(_9,"month",-1)),_d=null;if(_8!==""){var _e=_8.substring(0,4);var _f=_8.substring(5,7);var _10=_8.substring(8,10);_d=new this.dateClassObj(_e,_f-1,_10);}else{_d=new this.dateClassObj();}var _11=dojo.cldr.supplemental.getFirstDayOfWeek(this.lang);if(_11>_a){_11-=7;}dojo.query(".dijitCalendarDateTemplate",this.domNode).forEach(function(_12,i){i+=_11;var _13=new this.dateClassObj(_9),_14,_15="dijitCalendar",adj=0;if(i<_a){_14=_c-_a+i+1;adj=-1;_15+="Previous";}else{if(i>=(_a+_b)){_14=i-_a-_b+1;adj=1;_15+="Next";}else{_14=i-_a+1;_15+="Current";}}if(adj){_13=this.dateFuncObj.add(_13,"month",adj);}_13.setDate(_14);if(!this.dateFuncObj.compare(_13,_d,"date")){_15="dijitCalendarCurrentDate "+_15;}if(this._isSelectedDate(_13,this.lang)){_15="dijitCalendarSelectedDate "+_15;}if(this.isDisabledDate(_13,this.lang)){_15="dijitCalendarDisabledDate "+_15;}var _16=this.getClassForDate(_13,this.lang);if(_16){_15=_16+" "+_15;}_12.className=_15+"Month dijitCalendarDateTemplate";_12.dijitDateValue=_13.valueOf();dojo.attr(_12,"dijitDateValue",_13.valueOf());var _17=dojo.query(".dijitCalendarDateLabel",_12)[0],_18=_13.getDateLocalized?_13.getDateLocalized(this.lang):_13.getDate();this._setText(_17,_18);},this);var _19=this.dateLocaleModule.getNames("months","wide","standAlone",this.lang,_9);this.monthDropDownButton.dropDown.set("months",_19);this.monthDropDownButton.containerNode.innerHTML=(dojo.isIE==6?"":"<div class='dijitSpacer'>"+this.monthDropDownButton.dropDown.domNode.innerHTML+"</div>")+"<div class='dijitCalendarMonthLabel dijitCalendarCurrentMonthLabel'>"+_19[_9.getMonth()]+"</div>";var y=_9.getFullYear()-1;var d=new this.dateClassObj();dojo.forEach(["previous","current","next"],function(_1a){d.setFullYear(y++);this._setText(this[_1a+"YearLabelNode"],this.dateLocaleModule.format(d,{selector:"year",locale:this.lang}));},this);},goToToday:function(){this.set("value",new this.dateClassObj());},constructor:function(_1b){var _1c=(_1b.datePackage&&(_1b.datePackage!="dojo.date"))?_1b.datePackage+".Date":"Date";this.dateClassObj=dojo.getObject(_1c,false);this.datePackage=_1b.datePackage||this.datePackage;this.dateFuncObj=dojo.getObject(this.datePackage,false);this.dateLocaleModule=dojo.getObject(this.datePackage+".locale",false);},postMixInProperties:function(){if(isNaN(this.value)){delete this.value;}this.inherited(arguments);},buildRendering:function(){this.inherited(arguments);dojo.setSelectable(this.domNode,false);var _1d=dojo.hitch(this,function(_1e,n){var _1f=dojo.query(_1e,this.domNode)[0];for(var i=0;i<n;i++){_1f.parentNode.appendChild(_1f.cloneNode(true));}});_1d(".dijitCalendarDayLabelTemplate",6);_1d(".dijitCalendarDateTemplate",6);_1d(".dijitCalendarWeekTemplate",5);var _20=this.dateLocaleModule.getNames("days",this.dayWidth,"standAlone",this.lang);var _21=dojo.cldr.supplemental.getFirstDayOfWeek(this.lang);dojo.query(".dijitCalendarDayLabel",this.domNode).forEach(function(_22,i){this._setText(_22,_20[(i+_21)%7]);},this);var _23=new this.dateClassObj(this.currentFocus);this.monthDropDownButton.dropDown=new dijit.Calendar._MonthDropDown({id:this.id+"_mdd",onChange:dojo.hitch(this,"_onMonthSelect")});this.set("currentFocus",_23,false);var _24=this;var _25=function(_26,_27,adj){_24._connects.push(dijit.typematic.addMouseListener(_24[_26],_24,function(_28){if(_28>=0){_24._adjustDisplay(_27,adj);}},0.8,500));};_25("incrementMonth","month",1);_25("decrementMonth","month",-1);_25("nextYearLabelNode","year",1);_25("previousYearLabelNode","year",-1);},_adjustDisplay:function(_29,_2a){this._setCurrentFocusAttr(this.dateFuncObj.add(this.currentFocus,_29,_2a));},_setCurrentFocusAttr:function(_2b,_2c){var _2d=this.currentFocus,_2e=_2d?dojo.query("[dijitDateValue="+_2d.valueOf()+"]",this.domNode)[0]:null;_2b=new this.dateClassObj(_2b);_2b.setHours(1,0,0,0);this._set("currentFocus",_2b);this._populateGrid();var _2f=dojo.query("[dijitDateValue="+_2b.valueOf()+"]",this.domNode)[0];_2f.setAttribute("tabIndex",this.tabIndex);if(this._focused||_2c){_2f.focus();}if(_2e&&_2e!=_2f){if(dojo.isWebKit){_2e.setAttribute("tabIndex","-1");}else{_2e.removeAttribute("tabIndex");}}},focus:function(){this._setCurrentFocusAttr(this.currentFocus,true);},_onMonthSelect:function(_30){this.currentFocus=this.dateFuncObj.add(this.currentFocus,"month",_30-this.currentFocus.getMonth());this._populateGrid();},_onDayClick:function(evt){dojo.stopEvent(evt);for(var _31=evt.target;_31&&!_31.dijitDateValue;_31=_31.parentNode){}if(_31&&!dojo.hasClass(_31,"dijitCalendarDisabledDate")){this.set("value",_31.dijitDateValue);}},_onDayMouseOver:function(evt){var _32=dojo.hasClass(evt.target,"dijitCalendarDateLabel")?evt.target.parentNode:evt.target;if(_32&&(_32.dijitDateValue||_32==this.previousYearLabelNode||_32==this.nextYearLabelNode)){dojo.addClass(_32,"dijitCalendarHoveredDate");this._currentNode=_32;}},_onDayMouseOut:function(evt){if(!this._currentNode){return;}if(evt.relatedTarget&&evt.relatedTarget.parentNode==this._currentNode){return;}var cls="dijitCalendarHoveredDate";if(dojo.hasClass(this._currentNode,"dijitCalendarActiveDate")){cls+=" dijitCalendarActiveDate";}dojo.removeClass(this._currentNode,cls);this._currentNode=null;},_onDayMouseDown:function(evt){var _33=evt.target.parentNode;if(_33&&_33.dijitDateValue){dojo.addClass(_33,"dijitCalendarActiveDate");this._currentNode=_33;}},_onDayMouseUp:function(evt){var _34=evt.target.parentNode;if(_34&&_34.dijitDateValue){dojo.removeClass(_34,"dijitCalendarActiveDate");}},handleKey:function(evt){var _35=false;var dk=dojo.keys,_36=-1,_37,_38=this.currentFocus;switch(evt.keyCode){case dk.RIGHT_ARROW:_36=1;case dk.LEFT_ARROW:_37="day";if(!this.isLeftToRight()){_36*=-1;}break;case dk.DOWN_ARROW:_36=1;case dk.UP_ARROW:_37="week";break;case dk.PAGE_DOWN:_36=1;case dk.PAGE_UP:_37=evt.ctrlKey||evt.altKey?"year":"month";break;case dk.END:_38=this.dateFuncObj.add(_38,"month",1);_37="day";case dk.HOME:_38=new this.dateClassObj(_38);_38.setDate(1);break;case dk.ENTER:case dk.SPACE:if(window.isAccessibilityEnabled==true){_35=true;}this.set("value",this.currentFocus);break;default:return true;}if(_37){_38=this.dateFuncObj.add(_38,_37,_36);}this._setCurrentFocusAttr(_38);if(_35){this.domNode.tBodies[0].click();}return false;},_onKeyPress:function(evt){if(!this.handleKey(evt)){dojo.stopEvent(evt);}},onValueSelected:function(_39){},onChange:function(_3a){},_isSelectedDate:function(_3b,_3c){return this._isValidDate(this.value)&&!this.dateFuncObj.compare(_3b,this.value,"date");},isDisabledDate:function(_3d,_3e){},getClassForDate:function(_3f,_40){}});dojo.declare("dijit.Calendar._MonthDropDown",[dijit._Widget,dijit._Templated],{months:[],templateString:"<div class='dijitCalendarMonthMenu dijitMenu' "+"dojoAttachEvent='onclick:_onClick,onmouseover:_onMenuHover,onmouseout:_onMenuHover'></div>",_setMonthsAttr:function(_41){this.domNode.innerHTML=dojo.map(_41,function(_42,idx){return _42?"<div class='dijitCalendarMonthLabel' month='"+idx+"'>"+_42+"</div>":"";}).join("");},_onClick:function(evt){this.onChange(dojo.attr(evt.target,"month"));},onChange:function(_43){},_onMenuHover:function(evt){dojo.toggleClass(evt.target,"dijitCalendarMonthLabelHover",evt.type=="mouseover");}});}