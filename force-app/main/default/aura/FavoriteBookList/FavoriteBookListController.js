({
	doInit : function(component, event, helper) {
        helper.initializePageOne(component, event)
	},
    
    next : function(component, event, helper) {
		helper.nextPage(component, event)
	},
    
    previous : function(component, event, helper) {
        helper.prevPage(component, event)
    }
})