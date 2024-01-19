({
    getDetailModal: function(component, event, helper) {
        helper.doInit(component, event);
    },

    closeModel: function(component, event, helper) {
        component.set("v.showModal", false);
    },
})
