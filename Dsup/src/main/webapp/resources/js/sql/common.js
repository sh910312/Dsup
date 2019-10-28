var Common = (function () {
    // instance stores a reference to the Singleton
	var instance;

    function createInstance() {
        // private variables and methods
    	
        return {
            // public methods and variables
        	getToDay : function(){
        		let today = new Date();
        		
        		return today.toLocaleString();
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