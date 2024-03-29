/**
* クラス名：CMP_UpdateStudentController
* クラス概要：Update student controller
* @created： 2023/12/28 Tran Dinh Phuc
* @modified：
*/
({
    getEditModal: function(component, event, helper) {
        helper.doInit(component,event);
    },

    closeModel: function(component, event, helper) {
        component.set("v.showModal", false);
    },

    saveRecordData: function(component, event, helper) {
        var student = component.get("v.student");
        if (helper.validation(student)) {
            helper.saveStudent(component);
            component.set("v.showModal", false);
        }
    },
})
