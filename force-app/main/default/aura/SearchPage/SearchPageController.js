({    
    searchByISBN : function(component, event, SearchPageHelper) {
        console.log('Entered the getBook() method')
        
    	// For now, assume there is only 1 ISBN inserted.
    	let searchTerm = component.get("v.searchTerm")
        
        // Reset the attributes.
        component.set("v.matchNotFound", null)
        component.set("v.badInput", null)
        component.set("v.searchResults", null)
        
        if ( (searchTerm == null) || (searchTerm == '') ) {
            return
        }

   		// Make sure the ISBN is either 10 or 13 chars long and is a number.
    	if ( (searchTerm.length == 10 || searchTerm.length == 13) && (!isNaN(searchTerm)) ) {
            console.log('Entered if statement. Will now call openLibraryCallout.getBook() method')
            SearchPageHelper.getBooks(component, event, searchTerm)
        }
        else {
            component.set("v.badInput", true)
        }
	}
})