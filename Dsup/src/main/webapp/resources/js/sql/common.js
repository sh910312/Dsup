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
        	},
        	errorMessage : function(err){
        		$('.error').fadeIn(400).delay(3000).fadeOut(400);
        		$('.error').html(err);
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