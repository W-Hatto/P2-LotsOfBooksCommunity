({
	getBooks : function(component, event, isbn) {
        console.log("Entered getBooks function in Helper.")
		let action = component.get("c.getBook")
        action.setParams({bibkeys: 'ISBN:' + isbn}) 
        action.setCallback(this, function(response) {
            console.log(response.getState())
            
            if(response.getState() == 'SUCCESS') {
                let searchResultList = response.getReturnValue()
                console.log("Length of returned list: " + searchResultList.length)
                if (searchResultList.length > 0) {
            		component.set("v.searchResults", searchResultList)
            	}
                else {
                    component.set("v.matchNotFound", true)
                }
            }      
            else {
                console.log('This is before we print the state of the response.')
                console.log(response.getState())
                console.log(response.getError())
                console.log('Something went wrong.')
            }
        })
        
        $A.enqueueAction(action)
	}
})