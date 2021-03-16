({    
    searchByISBN : function(component, event, SearchPageHelper) {
        console.log('Entered the getBook() method')
    	// For now, assume there is only 1 ISBN inserted.
    	let searchTerm = component.get("v.searchTerm")
        let isNumber = !isNaN(searchTerm)
        console.log("searchTerm: " + searchTerm)
        console.log("isNaN(searchTerm): " + isNaN(searchTerm))
        //console.log("Number(searchTerm) != NaN: " + Number(searchTerm) != NaN)
        console.log("(searchTerm.length == 10 || searchTerm.length == 13): " + (searchTerm.length == 10 || searchTerm.length == 13))
    	if ( (searchTerm.length == 10 || searchTerm.length == 13) && (isNumber) ) {
            console.log('Entered if statement. Will now call openLibraryCallout.getBook() method')
            SearchPageHelper.getBooks(component, event, searchTerm)
        }
	}
})