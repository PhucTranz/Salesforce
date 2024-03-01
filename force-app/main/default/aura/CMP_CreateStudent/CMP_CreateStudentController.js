/**
* クラス名：CMP_CreateStudentController
* クラス概要：create student controller
* @created： 2023/12/25 Tran Dinh Phuc
* @modified：
*/
({
    getAddModal: function(component, event, helper) {
        helper.doInit(component);
        component.set("v.showModal", true);
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
