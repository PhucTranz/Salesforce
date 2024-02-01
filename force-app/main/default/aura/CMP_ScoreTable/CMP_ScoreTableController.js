({
    doInit : function(component, event, helper) {
        helper.doInit(component)
    },

    changeSemester: function(component, event) {
        const semester = event.target.value;
        var data = component.get('v.data');
        data.forEach(e => {
            if (semester) {
                if (e.id === semester) {
                    e.show = true;
                } else {
                    e.show = false;
                }
            } else {
                e.show = true;
            }
        })
        component.set('v.data',data);
    }
})
