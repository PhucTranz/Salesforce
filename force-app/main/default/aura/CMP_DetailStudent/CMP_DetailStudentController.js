/**
* クラス名：CMP_DetailStudentController
* クラス概要：detail student controller
* @created： 2023/12/27 Tran Dinh Phuc
* @modified：
*/
({
    getDetailModal: function(component, event, helper) {
        helper.doInit(component, event);
    },

    closeModel: function(component, event, helper) {
        component.set("v.showModal", false);
    },
})
