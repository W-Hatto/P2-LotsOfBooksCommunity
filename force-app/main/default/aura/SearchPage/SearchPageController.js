({    
    searchByISBN : function(component, event, SearchPageHelper) {      

    	let searchTerm = component.get("v.searchTerm")
        
        // Reset attributes. The first three are used to display text to 
        // alert the user when something is wrong. The fourth holds the 
        // search results.
        component.set("v.serverError", null)
        component.set("v.matchNotFound", null)
        component.set("v.badInput", null)
        component.set("v.searchResults", null)
        
        if ( (searchTerm == null) || (searchTerm == '') ) {
            return
        }

   		// Make sure the ISBN is either 10 or 13 chars long and is a number.
   		// Then, call the getBooks() method.
    	if ( (searchTerm.length == 10 || searchTerm.length == 13) && (!isNaN(searchTerm)) ) {
            SearchPageHelper.getBooks(component, event, searchTerm)
        }
        else {
            component.set("v.badInput", true)
        }
	}
})