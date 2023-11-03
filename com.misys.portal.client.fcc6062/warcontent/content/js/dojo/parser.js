/*
	Copyright (c) 2004-2011, The Dojo Foundation All Rights Reserved.
	Available via Academic Free License >= 2.1 OR the modified BSD license.
	see: http://dojotoolkit.org/license for details
*/


if(!dojo._hasResource["dojo.parser"]){dojo._hasResource["dojo.parser"]=true;dojo.provide("dojo.parser");dojo.require("dojo.date.stamp");new Date("X");dojo.parser=new function(){var d=dojo;function _1(_2){if(d.isString(_2)){return "string";}if(typeof _2=="number"){return "number";}if(typeof _2=="boolean"){return "boolean";}if(d.isFunction(_2)){return "function";}if(d.isArray(_2)){return "array";}if(_2 instanceof Date){return "date";}if(_2 instanceof d._Url){return "url";}return "object";};function _3(_4,_5){switch(_5){case "string":return _4;case "number":return _4.length?Number(_4):NaN;case "boolean":return typeof _4=="boolean"?_4:!(_4.toLowerCase()=="false");case "function":if(d.isFunction(_4)){_4=_4.toString();_4=d.trim(_4.substring(_4.indexOf("{")+1,_4.length-1));}try{if(_4===""||_4.search(/[^\w\.]+/i)!=-1){return new Function(_4);}else{return d.getObject(_4,false)||new Function(_4);}}catch(e){return new Function();}case "array":return _4?_4.split(/\s*,\s*/):[];case "date":switch(_4){case "":return new Date("");case "now":return new Date();default:return d.date.stamp.fromISOString(_4);}case "url":return d.baseUrl+_4;default:return d.fromJson(_4);}};var _6={},_7={};d.connect(d,"extend",function(){_7={};});function _8(_9,_a){for(var _b in _9){if(_b.charAt(0)=="_"){continue;}if(_b in _6){continue;}_a[_b]=_1(_9[_b]);}return _a;};function _c(_d,_e){var c=_7[_d];if(!c){var _f=d.getObject(_d),_10=null;if(!_f){return null;}if(!_e){_10=_8(_f.prototype,{});}c={cls:_f,params:_10};}else{if(!_e&&!c.params){c.params=_8(c.cls.prototype,{});}}return c;};this._functionFromScript=function(_11,_12){var _13="";var _14="";var _15=(_11.getAttribute(_12+"args")||_11.getAttribute("args"));if(_15){d.forEach(_15.split(/\s*,\s*/),function(_16,idx){_13+="var "+_16+" = arguments["+idx+"]; ";});}var _17=_11.getAttribute("with");if(_17&&_17.length){d.forEach(_17.split(/\s*,\s*/),function(_18){_13+="with("+_18+"){";_14+="}";});}return new Function(_13+_11.innerHTML+_14);};this.instantiate=function(_19,_1a,_1b){var _1c=[],_1a=_1a||{};_1b=_1b||{};var _1d=(_1b.scope||d._scopeName)+"Type",_1e="data-"+(_1b.scope||d._scopeName)+"-";d.forEach(_19,function(obj){if(!obj){return;}var _1f,_20,_21,_22,_23,_24;if(obj.node){_1f=obj.node;_20=obj.type;_24=obj.fastpath;_21=obj.clsInfo||(_20&&_c(_20,_24));_22=_21&&_21.cls;_23=obj.scripts;}else{_1f=obj;_20=_1d in _1a?_1a[_1d]:_1f.getAttribute(_1d);_21=_20&&_c(_20);_22=_21&&_21.cls;_23=(_22&&(_22._noScript||_22.prototype._noScript)?[]:d.query("> script[type^='dojo/']",_1f));}if(!_21){throw new Error("Could not load class '"+_20);}var _25={};if(_1b.defaults){d._mixin(_25,_1b.defaults);}if(obj.inherited){d._mixin(_25,obj.inherited);}if(_24){var _26=_1f.getAttribute(_1e+"props");if(_26&&_26.length){try{_26=d.fromJson.call(_1b.propsThis,"{"+_26+"}");d._mixin(_25,_26);}catch(e){throw new Error(e.toString()+" in data-dojo-props='"+_26+"'");}}var _27=_1f.getAttribute(_1e+"attach-point");if(_27){_25.dojoAttachPoint=_27;}var _28=_1f.getAttribute(_1e+"attach-event");if(_28){_25.dojoAttachEvent=_28;}dojo.mixin(_25,_1a);}else{var _29=_1f.attributes;for(var _2a in _21.params){var _2b=_2a in _1a?{value:_1a[_2a],specified:true}:_29.getNamedItem(_2a);if(!_2b||(!_2b.specified&&(!dojo.isIE||_2a.toLowerCase()!="value"))){continue;}var _2c=_2b.value;switch(_2a){case "class":_2c="className" in _1a?_1a.className:_1f.className;break;case "style":_2c="style" in _1a?_1a.style:(_1f.style&&_1f.style.cssText);}var _2d=_21.params[_2a];if(typeof _2c=="string"){_25[_2a]=_3(_2c,_2d);}else{_25[_2a]=_2c;}}}var _2e=[],_2f=[];d.forEach(_23,function(_30){_1f.removeChild(_30);var _31=(_30.getAttribute(_1e+"event")||_30.getAttribute("event")),_20=_30.getAttribute("type"),nf=d.parser._functionFromScript(_30,_1e);if(_31){if(_20=="dojo/connect"){_2e.push({event:_31,func:nf});}else{_25[_31]=nf;}}else{_2f.push(nf);}});var _32=_22.markupFactory||_22.prototype&&_22.prototype.markupFactory;var _33=_32?_32(_25,_1f,_22):new _22(_25,_1f);_1c.push(_33);var _34=(_1f.getAttribute(_1e+"id")||_1f.getAttribute("jsId"));if(_34){d.setObject(_34,_33);}d.forEach(_2e,function(_35){d.connect(_33,_35.event,null,_35.func);});d.forEach(_2f,function(_36){_36.call(_33);});});if(!_1a._started){d.forEach(_1c,function(_37){if(!_1b.noStart&&_37&&dojo.isFunction(_37.startup)&&!_37._started&&(!_37.getParent||!_37.getParent())){_37.startup();}});}return _1c;};this.parse=function(_38,_39){var _3a;if(!_39&&_38&&_38.rootNode){_39=_38;_3a=_39.rootNode;}else{_3a=_38;}_39=_39||{};var _3b=(_39.scope||d._scopeName)+"Type",_3c="data-"+(_39.scope||d._scopeName)+"-",_3d=_3c+"type",_3e=_3c+"textdir";var _3f=[];var _40=(_3a?dojo.byId(_3a):dojo.body()).firstChild;var _41={inherited:(_39&&_39.inherited)||{dir:dojo._isBodyLtr()?"ltr":"rtl",textDir:d.body().getAttribute(_3c+"textdir")||d.doc.documentElement.getAttribute(_3c+"textdir")||""}};var _42;var _43;function _44(_45){if(!_45.inherited){var _46=_45.node,_47=_44(_45.parent);_45.inherited={dir:_46.getAttribute("dir")||_47.dir,lang:_46.getAttribute("lang")||_47.lang,textDir:_46.getAttribute(_3e)||_47.textDir};if(typeof _45.inherited.lang=="undefined"){delete _45.inherited.lang;}}return _45.inherited;};while(true){if(!_40){if(!_41||!_41.node){break;}_40=_41.node.nextSibling;_42=_41.scripts;_43=false;_41=_41.parent;continue;}if(_40.nodeType!=1){_40=_40.nextSibling;continue;}if(_42&&_40.nodeName.toLowerCase()=="script"){_48=_40.getAttribute("type");if(_48&&/^dojo\/\w/i.test(_48)){_42.push(_40);}_40=_40.nextSibling;continue;}if(_43){_40=_40.nextSibling;continue;}var _48,_49=_40.getAttribute(_3d);if(_49){_48=_49;}else{_48=_40.getAttribute(_3b);}var _4a=_49==_48;var _4b=_40.firstChild;if(!_48&&(!_4b||(_4b.nodeType==3&&!_4b.nextSibling))){_40=_40.nextSibling;continue;}var _4c={node:_40,scripts:_42,parent:_41};var _4d=_48&&_c(_48,_4a),_4e=_4d&&!_4d.cls.prototype._noScript?[]:null;if(_48){_3f.push({"type":_48,fastpath:_4a,clsInfo:_4d,node:_40,scripts:_4e,inherited:_44(_4c)});}_40=_4b;_42=_4e;_43=_4d&&_4d.cls.prototype.stopParser&&!(_39&&_39.template);_41=_4c;}var _4f=_39&&_39.template?{template:true}:null;return this.instantiate(_3f,_4f,_39);};}();(function(){var _50=function(){if(dojo.config.parseOnLoad){dojo.parser.parse();}};if(dojo.getObject("dijit.wai.onload")===dojo._loaders[0]){dojo._loaders.splice(1,0,_50);}else{dojo._loaders.unshift(_50);}})();}