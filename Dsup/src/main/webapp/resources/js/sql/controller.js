var Controller = (function () {
    // instance stores a reference to the Singleton
    var instance;
    var command;
    
    function createInstance() {
        // private variables and methods
        
        return {
            // public methods and variables
            momoDrop : function(momoCnt){
            	if(momoCnt == 1){
            		command = Command.getInstance();
            		command.momoDrop(true);
            	}else{            		
            		command.momoDrop(false);
            	}            	
            },
            
            momoClick : function(k, t, c){
            	command.momoClick(k, t, c);
            },
            
            apply : function(t){
            	//console.log("apply type : " + t)
            	command.apply();
            },
            add : function(t){
            	command.add(t);
            },
            save : function(){
            	command.save();
            },
            load : function(){
            	command.load();
            },
            tableClick : function(obj){
            	command.tableClick(obj);
            },
            tableDoubleClick : function(obj){
            	command.tableDoubleClick(obj);
            },
            showData : function(k){
            	command.showData(k);
            },
            join : function(){
            	command.join();
            },
            selectChanged : function(obj){
            	command.selectChanged(obj);
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