var Storage = (function () {
    // instance stores a reference to the Singleton
    var instance;

    function createInstance() {
        // private variables and methods
        var privateVariable = 'I am a private variable';

        function getStorageFormat(momo){
        	//console.log("format : " + momo.getDataInfo());
        	var key = momo.getKey();
        	var value = 
        		{ "SETTING" : momo.getTag(),
        		 //"DATA" : momo.getDataInfo(),
        		 "SQL" : momo.getSqlInfo(),
        		// "CHID_KEY" : momo.getKey(),
        		 //"GRAND_CHILD_KEY" : momo.getChildsInfo(),
        		 //"COL_NAME" : momo.getColNameInfo(),
        		 //"COL_TYPE" : momo.getColTypeInfo(),	
        		 "COL_NM_TYPE" : momo.getColTypePair(),
        		 "DISPLAY_TABLE_TAG" : momo.getTableTag()}
        	
        	var map = new Map();
        	map[key] = value;
        	var result = JSON.stringify(map);
        	//var result = map;
        	//console.log("result : " + result);
        	
        	return result;
        }

        return {
        	isThere : function(k) {
        		var YN = localStorage.getItem(k);
        		//console.log("storage key : " + k);
    			if(YN == null){
    				YN = false;
    				return YN;
    			}else{
    				YN = true;
    				//console.log("There is in storage");
    				return  YN;
    			}
        	},        	
        	getChildInfo : function(k, c) {
        		var childs = c;
        		var childCnt = childs.length ;
        		var childDataArray = new Array();
        		var map = new Map();
        		
        		for(var i=0; i<childCnt; i++){
        			var data = localStorage.getItem(childs[i]);
        			//console.log("localstorage : " + data);
        			//var json = JSON.parse(data);
        			//console.log(json);
        			//hildDataArray.push(JSON.parse(data));
        			childDataArray.push(data);
        		}
        		//console.log("childDataArray : " + childDataArray);
        		
        		return childDataArray;
        	},
        	getLocalStorage : function(k, d) {
        		var data = localStorage.getItem(k);
        		var result = data;
        		//console.log("[storage] data : " + data);
        		var json = JSON.parse(data);
        		
        		switch (d){
        			case "SETTING" :
        				result = json[k].SETTING;
        				break;
        			case "DISPLAY_TABLE_TAG" :
        				result = json[k].DISPLAY_TABLE_TAG;
        				break;
        			case "" :
        				break;
        			case "" :
        				break;
        			case "" :
        				break;
        			case "" :
        				break;        			
        		}
        		//console.log('[storage] result : ' + result);
        		
        		return result;
        	},
        	setLocalStorage : function(momo) {
        		var value = getStorageFormat(momo); //value : json -> string 형태로 변형함
        		//console.log(momo.getSettingInfo());
        		//console.log("value : " + value);
        		//console.log("Storage : " + value);
        		localStorage.setItem(momo.getKey(), value);
        		//localStorage.setItem(momo.getKey(), momo.getTag());
        		//console.log("Storage  : " + localStorage.getItem(momo.getKey()));
        	}
        };
    }
     
    return {
        // Get the Singleton instance if it exists
        // or create one if doesn't
        getInstance: function () {
            if (!instance) {
                instance = createInstance();
            }
            return instance;
        }
    };
})();
