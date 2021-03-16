({
	doInit : function(component, event, helper) {
        
        let tilesPerPage = component.get("v.tilesPerPage")
        
		let action = component.get("c.getFavoriteBooks") 
        console.log('Created the action')
        action.setCallback(this, function(response) {
            console.log('Entered the Callback method')
            
            if (response.getState() == 'SUCCESS') {
                
                console.log('Response was successful')
                let favBookList = response.getReturnValue()
                
                console.log(favBookList)
                component.set("v.bookList", favBookList)
                console.log(component.get("v.bookList[0]"))

                // Set the max page number. The ceil() method rounds up.
                let maxPageNumber = Math.ceil(favBookList.length/tilesPerPage)
                component.set("v.maxPageNumber", maxPageNumber)
                console.log('maxPageNumber: ' + maxPageNumber)
                console.log('Tiles Per page: ' + tilesPerPage)
                
                // Assign the first page of books to the corresponding attributes,
                // but don't exceed the length of the bookList.         
                for (let i=1; i<=tilesPerPage; i++) {
                    console.log('Assigning Tile' + i)
                    if (i <= favBookList.length) {
                		component.set("v.tile" + i + "Book", favBookList[i-1])
                    }
                    // Make sure any tiles that don't get a new Book__c value are null
                    else {
                        component.set("v.tile" + i + "Book", null)
                    }
                }
                console.log('Successfully set tile attributes.')
            }
            else {
                console.log(response.getState())
            }
        })
        $A.enqueueAction(action)
	},
    
    next : function(component, event, helper) {
        // Figure out the offset
        let tilesPerPage = component.get("v.tilesPerPage")
        let currentPage = component.get("v.pageNumber")
        let offset = currentPage * tilesPerPage
        
        // No pages exist after the max page Number.
        let maxPageNumber = component.get("v.maxPageNumber")
        if (currentPage >= maxPageNumber) {
            return
        }
        
        // Assign books to the corresponding attributes.
        let bookList = component.get("v.booklist")
        for (let i=1; i<=tilesPerPage; i++) {
            // Assign new book values to the tiles, but don't exceed the 
            // length of the bookList.
            if ((i + offset) <= bookList.length) {
            	component.set("v.tile" + i + "Book", favBookList[i-1 + offset])
            }
      		// Nullify any tiles that don't get a new Book__c value
            else {
                component.set("v.tile" + i + "Book", null)    
            }
        }
        component.set("v.pageNumber", currentPage + 1)  
    },
    
        previous : function(component, event, helper) {
        // Figure out the offset
        let tilesPerPage = component.get("v.tilesPerPage")
        let currentPage = component.get("v.pageNumber")
        let offset = tilesPerPage * (currentPage-2)
        
        // No pages exist below page 1.
        if (currentPage <= 1) {
            return
        }
        
        // Assign books to the corresponding attributes.
        // Since going to a previous page implies the next page had values,
        // no checks should be necessary
        let bookList = component.get("v.booklist")
        for (let i=1; i<=tilesPerPage; i++) {
        	component.set("v.tile" + i + "Book", favBookList[i-1 + offset])
        }
        component.set("v.pageNumber", currentPage + 1)  
    }
})