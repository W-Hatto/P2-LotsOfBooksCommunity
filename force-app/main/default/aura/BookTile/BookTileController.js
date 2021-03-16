({
	doInit : function(component, event, helper) {
        /*
        console.log("Initialization of BookTile has begun.")
		let currentBook = component.get("v.book")
        console.log(currentBook)
        //console.log(currentBook.title)
        
        //console.log("url: " + currentBook.cover.medium)
        component.set("v.coverUrl", currentBook.Cover_URL__c)
        */
	},
    
    favorite : function(component, event, helper) {
    	let book = component.get("v.book")
    	let action = component.get("c.addBookToFavorites")	
    	action.setParams({bookToFavorite: book})
		action.setCallback(this, function (response) {
            if (response.getStatus() == 'SUCCESS') {
                console.log("Book added to favorites")
            }
            else {
                console.log(response.getStatus())
            }
		} )
    	$A.enqueueAction(action)
	}
    
})