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
        console.log('Entered favorite function.')
    	let book = component.get("v.book")
    	let action = component.get("c.addToFavorites")	
    	action.setParams({bookToFavorite: book})
        console.log('Created the action and set the params')
		action.setCallback(this, function (response) {

            if (response.getState() == 'SUCCESS') {
                console.log("Book added to favorites")
            }
            else {
                console.log(response.getState())
                console.log(response.getError())
            }
		} )
    	$A.enqueueAction(action)
	}
    
})