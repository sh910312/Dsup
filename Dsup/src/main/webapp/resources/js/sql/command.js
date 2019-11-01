//공용으로 사용할 수 있는 함수 정의
var common;
var table_tag;
var Command = (function() {
	 var instance;
	
	function createInstance() {
		// private variables and methods
		var first = true;
		//현재 open 되어 있는 설정창의 주인
		var momo;
		var setting;
		var storage;
		var process;
		var display;
		var result;
		
		function setIsFirst(momoCnt){
			console.log(momoCnt)
			if (momoCnt == 1) {
				first = true;
			} else {
				first =  false;
			}
		}

		return {
			// public methods and variables
			momoDrop : function(b) {
				//console.log("Create Instances");
				momo = MoMo.getInstance();
				setting = Setting.getInstance();
				storage = Storage.getInstance();
				process = Process.getInstance();
				common = Common.getInstance();
				display = Display.getInstance();
			
				first = b;
			},
			momoClick : function(k, t, c){
				// 자식 아이콘의 설정 정보
				//var info;
				if (first) {
					// 처음 생성된 icon은 클릭시 icon 인스턴스에 바로 key 설정
					console.log("First momo");
					
					setting.open(k, t);
					setting.decorate(k, t, "", "new");
					
					momo.replace(k, t, c);
					//setting.setDbReadTag($('#dbread-setting-bar').html())
					
				} else {
					if (momo.getKey() != k) {
						// 클릭한 아이콘이 현재 설정창의 주인공 아이콘의 타입이랑 다른지 검사
						if (momo.getType() == t) {
							// 기존에 존재 하는 녀석을 클릭 한건지 새로운 녀석을 클릭했는지 검사
							if (storage.isThere(k)) {
								// 타입 같고 시니어 모모 클릭
								console.log("--- Old and Same Type! ---");
								
								setting.clean(momo.getType())
								var info = storage.getLocalStorage(k, "SETTING");
								//console.log("[momo set info] : " + info);
								setting.decorate(k, t, info, "old");
								momo.replace(k, t, c)
								
							} else {
								// 타입 같고 새로운 모모 클릭
								console.log("--- New and Same Type! ---");
								setting.clean(momo.getType())
								if(t != "DBread"){
									var info = storage.getChildInfo(k, c);
								}else if(t == "DBinsert"){
									process.getDBinsertTargetTableList();
								}
								//console.log("[child info] : " + info);
								setting.decorate(k, t, info, "new");
								momo.replace(k, t, c);
							}
						} else {
							if (storage.isThere(k)) {
								// 타입 다르고 시니어 모모 클릭
								console.log("--- Old and Other Type! ---");
								
								setting.clean(momo.getType());
								setting.close(momo.getKey(), momo.getType());
								var info = storage.getLocalStorage(k, "SETTING");
								//console.log("[momo set info] : " + info);
								setting.decorate(k, t, info, "old");
								setting.open(k, t);
								
								momo.replace(k, t, c);
							} else {
								// 타입 다르고 새로운 모모 클릭
								console.log("--- New and Other Type! ---");
								 
								setting.clean(momo.getType());
								setting.close(momo.getKey(), momo.getType());
								if(t != "DBread"){
									var info = storage.getChildInfo(k, c);
								}
								
								//DBinsert인 경우 schema에 따라 보유한 테이블들의 list를 보여줘야된다.
								if(t == "DBinsert"){
									var list = process.getDBinsertTargetTableList();
									setting.decorateTargetTableList(list);
								}
								//console.log("[child info] : " + info);
								setting.decorate(k, t, info, "new");
								setting.open(k, t);
								
								momo.replace(k, t, c);
							}
						}
					}
				}
			},
			apply : function(t){
				if(t != "DBinsert"){
					if(t != "DBread")
						var info = storage.getChildInfo(momo.getKey(), momo.getChildsInfo());
					//console.log("child info : " + info);
					result = process.getData(momo, info);
					if(result != "{}"){
						momo.setMoMo(result);
						storage.setLocalStorage(momo);
					}else{
						common.errorMessage("설정 조건이 잘못되었습니다.");
					}
					//console.log("momo.getSettingInfo() : " + momo.getSettingInfo());
				}else{
					var info = storage.getChildInfo(momo.getKey(), momo.getChildsInfo());
					process.dbInsert(info);
				}

			},
			add : function(t){
				console.log("[Call Add() Type] " + t);
				setting.add(t);
			},
			save : function(){
				document.getElementById("mySavedModel").value = myDiagram.model.toJson();
				myDiagram.isModified = false;
			},
			load : function() {
				var json = document.getElementById("mySavedModel").value;
				// go.Model.fromJson(json) : JSON to String
				myDiagram.model = go.Model.fromJson(json);
			},
			tableClick : function(obj){
			    //var txt = $(obj).text();
			    //console.log("txt : " + txt);
				console.log("[table click!!]");
				
				setting.tableClick(obj);
				
			},
			tableDoubleClick : function(obj){
				if(momo.getType()=='Addition'){
					console.log("[Addition table double click!!")
					setting.tableDoubleClick(obj);					
				}
			},
			showData : function(k){
				table_tag = storage.getLocalStorage(k, "DISPLAY_TABLE_TAG");
				display.showData();
			},
			join : function(){
				setting.join();
			},
			selectChanged : function(obj){
				setting.selectChanged(obj);
			},
			getTargetTableInfo : function(){
				var targetTableInfo = process.getTargetTableInfo();
				setting.decoTargetTable(targetTableInfo);
				//setting.selectChanged('dbinsert-target-table-changed');
				setting.selectChanged('#target_table_list');
			}
		};
	}
	
	 return {
	        // Get the Singleton instance if it exists
	        // or create one if doesn't
	        getInstance: function () {
	            if (!instance) {
	            	console.log("Create Command");
	                instance = createInstance();
	                localStorage.clear();
	            }else{
	            	console.log("Not Create two Command instance!");
	            }
	            return instance;
	        }
	    };
})();