({    
    favorite : function(component, event, helper) {
        
    	let book = component.get("v.book")
    	let action = component.get("c.addToFavorites")	
    	action.setParams({bookToFavorite: book})
        
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