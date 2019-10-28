var MoMo = (function() {
	// instance stores a reference to the Singleton
	var instance;

	function createInstance() {
		// private variables
		var key;
		var type;
		var childsInfo;
		var settingInfo;
		var colNameInfo;
		var colTypeInfo;
		var dataInfo;
		var sqlInfo;
		var tableTag;
		var json;
		var colTypePair;
		var childInfo;

		function makeTableTag(json){
			console.log(json);
			// console.log("jsonLength : " + jsonLength);
			var rownum = 1;
			var tag = '';
			for (var key in json) {
				if(key == "COL_NAME"){
					var a_json = json[key];
					tag = tag + 
						'<tr style="font-weight: bold;">' +
							'<td></td>';
					for(var i=0; i<json[key].length; i++){
						tag = tag + 
							'<th>' + json[key][i] + '</th>';
					}
					tag = tag+
						'</tr>';
				}else if(key == "DATA"){
					var a_json = json[key];
				
					for(a_key in a_json){
						tag = tag +
						'<tr>' +
							'<td>' + a_key + '</td>';
						for(var i=0; i<a_json[a_key].length; i++){
							tag = tag + 
							'<td>' + a_json[a_key][i] + '</td>';
						}
					}
					tag = tag+
						'</tr>';
					rownum += 1;
				}
			}
			
			return tag;
		}

		return {
			// public variables

			// public methods
			
			setChildInfo : function(ci){
				childInfo = ci;
			},
			getChildInfo : function(){
				return childInfo;
			},
			setMoMo : function(result){
				//console.log("result : " + result);
				var json = JSON.parse(result);
				var array = new Array();
				var map = new Map();
				
				for(var key in json){
					if(key == "COL_NM_TYPE"){
						//console.log(json[key]);
						colTypePair = json[key];
					}else if(key == "SQL"){
						//console.log(json[key]);
						sqlInfo = json[key];
					}else if(key == "COL_NAME"){
						//console.log(json[key]);
						colNameInfo = json[key];
					}else if(key == "COL_TYPE"){
						//console.log(json[key]);
						colTypeInfo = json[key];
					}else{
						//console.log(json[key]);
						dataInfo = json[key];
					}	
				}
					
				var tag = makeTableTag(json);
				//momo.setJson(new Array(JSON.stringify(jsonArray)));
				tableTag = tag;
				
				//console.log("[momo] tag : " + tableTag);
			},
			replace : function(k, t, c) {
				//console.log(k + ", " + t);	
				key = k;
				type = t;
				childsInfo = c;
			},
			setColTypePair : function(p){
				colTypePair = p;
			},
			setJson : function(p) {
				json = p;
			},
			setKey : function(p) {
				key = p;
			},
			setType : function(p) {
				type = p;
			},
			setChildsInfo : function(p) {
				childsInfo = p;
			},
			setSettingInfo : function(p) {
				//console.log(p)
				settingInfo = p;
				//console.log("settingInfo : " + settingInfo);
			},
			setColNameInfo : function(p) {
				//console.log(p);
				colNameInfo = p;
			},
			setColTypeInfo : function(p) {
				colTypeInfo = p;
			},
			setDataInfo : function(p) {
				dataInfo = p;
			},
			setSqlInfo : function(p) {
				sqlInfo = p;
			},
			setTableTag : function(p) {
				tableTag = p;
			},
			getColTypePair : function(){
				return colTypePair;
			},
			getJson : function() {
				return json;
			},
			getKey : function() {
				return key;
			},
			getType : function() {
				return type;
			},
			getChildsInfo : function() {
				return childsInfo;
			},
			getSettingInfo : function() {
				//console.log("momo | getSettingInfo : " + settingInfo);
				return settingInfo;
			},
			getColNameInfo : function() {
				return colNameInfo;
			},
			getColTypeInfo : function() {
				return colTypeInfo;
			},
			getDataInfo : function() {
				return dataInfo;
			},
			getSqlInfo : function() {
				return sqlInfo;
			},
			getTableTag : function() {
				return tableTag;
			},
			setTag : function(p){
				tag = p;
			},
			getTag : function(){
				return tag;
			},
		};
	}

	return {
		// Get the Singleton instance if it exists
		// or create one if doesn't
		getInstance : function() {
			if (!instance) {
				instance = createInstance();
			}
			return instance;
		}
	};
})();