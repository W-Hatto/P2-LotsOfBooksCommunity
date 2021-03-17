({
	getBooks : function(component, event, isbn) {

		let action = component.get("c.getBook")
        action.setParams({isbn: 'ISBN:' + isbn}) 
        action.setCallback(this, function(response) {
            
            if(response.getState() == 'SUCCESS') {
                let searchResultList = response.getReturnValue()

                // If there are search results, store them.
                if (searchResultList.length > 0) {
            		component.set("v.searchResults", searchResultList)
            	}
                else {
                    component.set("v.matchNotFound", true)
                }
            }      
            else {
                console.log(response.getState())
                console.log(response.getError())
            }
        })
        $A.enqueueAction(action)
	}
})