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
    		showData : function(sql, rowCount){
    			
    			if(tag == ""){
    				
    			}else{
    				newWindow("MyWindow");
    				//console.log("[display] tag : " + tag);
    				window.open("ShowData.do?sql=" + encodeURI(sql) + "&rowCount=" + encodeURI(rowCount), 
    						newName, 
    				"width=1200, height=500, toolbar=no, menubar=no, scrollbars=no, resizable=yes, location=no");
    				
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
 