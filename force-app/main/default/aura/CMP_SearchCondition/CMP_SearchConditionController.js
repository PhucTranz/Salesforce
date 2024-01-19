({
    doInit : function(component, event, helper) {
        helper.getStudents(component, true);
        helper.selectListYear(component);
        helper.selectListMonth(component);
        helper.selectListDay(component);
        helper.getClassOptions(component);
    },

    search : function(component, event, helper) {
        helper.getStudents(component, true);
    },
    
    selectedMonthOrYear : function(component, event, helper) {
        component.set("v.searchByBirthday", null);
        helper.selectListDay(component);
    },

    selectedDay : function(component, event, helper) {
        component.set("v.searchByBirthday", null);
    },

    selectedBirthday : function(component, event, helper) {
        component.set("v.searchByDay", 0);
        component.set("v.searchByMonth", 0);
        component.set("v.searchByYear", 0);
        helper.selectListDay(component);
    },

    reloadTable : function(component, event, helper) {
        helper.getStudents(component, false);
    },
})
