var Display = (function () {
    // instance stores a reference to the Singleton
    var instance;

    function createInstance() {
        // private variables and methods
        var newName, n=0;
        
        function newWindow(value)
        {
           n = n + 1;
           newName = value + n;     
        }	
        
    	return {
            // public methods and variables
    		showData : function(){
    			if(tag == ""){
    				
    			}else{
    				newWindow("MyWindow");
    				//console.log("[display] tag : " + tag);
    				window.open("ShowData.do", 
    						newName, 
    				"width=600, height=400, toolbar=no, menubar=no, scrollbars=no, resizable=yes, location=no");
    				
    			}
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
 