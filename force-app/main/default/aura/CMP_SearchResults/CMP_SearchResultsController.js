/**
* クラス名：CMP_SearchResultController
* クラス概要：Search result controller
* @created： 2024/01/03 Tran Dinh Phuc
* @modified：
*/
({
    receiveData : function(component, event, helper) {
        helper.doInit(component, event);
    },

    goToPage : function(component, event, helper) {
        var clickedPage = event.currentTarget.dataset.page;
        component.set("v.pageNumber", parseInt(clickedPage));
        helper.handlePaging(component);
    },

    firstPage : function(component, event, helper) {
        component.set("v.pageNumber", 1);
        helper.handlePaging(component);
    },

    previousPage : function(component, event, helper) {
        component.set("v.pageNumber", component.get("v.pageNumber") - 1);
        helper.handlePaging(component);
    },

    nextPage : function(component, event, helper) {
        component.set("v.pageNumber", parseInt(component.get("v.pageNumber")) + 1);
        helper.handlePaging(component);
    },
    
    lastPage : function(component, event, helper) {
        component.set("v.pageNumber", component.get("v.totalPages"));
        helper.handlePaging(component);
    },

    checkAll: function(component, event, helper) {
        var isChecked = event.currentTarget.checked;
        var studentsToTable = component.get("v.studentsToTable");
        studentsToTable.forEach(e => {
            e.selected = isChecked;
            document.getElementById("btn-deleteSelected").disabled = !isChecked;
        })
        component.set("v.studentsToTable",studentsToTable)
        helper.handlePaging(component);
    },

    checkChecked: function(component, event, helper) {
        var studentsToTable = component.get("v.studentsToTable");
        studentsToTable.forEach(e => {
            if (e.StudentCode__c == event.target.value) {
                e.selected = event.target.checked;
            }
        })
        component.set("v.studentsToTable",studentsToTable);
        helper.isCheckedAll(component);
    },

    createStudent: function(component, event, helper) {
        component.find("createStudent").getAddModal();
    },

    updateStudent: function(component, event, helper) {
        var studentId = event.currentTarget.value;
        component.find("updateStudent").getEditModal(studentId);
    },

    deleteStudent: function(component, event, helper) {
        helper.getStudentToDelete(component, event);
    },

    studentDetail: function(component, event, helper) {
        var studentId = event.currentTarget.value;
        component.find("studentDetail").getDetailModal(studentId);
    },

    deleteSelected: function(component, event, helper) {
        var selectedStudent = [];
        var students = component.get("v.students");
        students.forEach(e => {
            if (e.selected)
                selectedStudent.push(e.StudentCode__c);
        })
        component.set("v.selectedStudent", selectedStudent);
        component.set("v.showDeleteSelectedModal", true);
    },

    sortStudentsByBirthDay: function(component, event, helper) {
        var icon = document.getElementById("sortIconByBirthDay").iconName;
        if (icon == "utility:arrowup") {
            document.getElementById("sortIconByBirthDay").iconName = "utility:arrowdown";
            helper.sortStudentsByBirthDay(component,0);
        } else {
            document.getElementById("sortIconByBirthDay").iconName = "utility:arrowup"
            helper.sortStudentsByBirthDay(component,1);
        }
    },

    sortStudentsByName: function(component, event, helper) {
        var icon = document.getElementById("sortIconByName").iconName;
        if (icon == "utility:arrowup") {
            document.getElementById("sortIconByName").iconName = "utility:arrowdown";
            helper.sortStudentsByName(component,0);
        } else {
            document.getElementById("sortIconByName").iconName = "utility:arrowup"
            helper.sortStudentsByName(component,1);
        }
    },

    sortStudentsStudentCode: function(component, event, helper) {
        var icon = document.getElementById("sortIconByStudentCode").iconName;
        if (icon == "utility:arrowup") {
            document.getElementById("sortIconByStudentCode").iconName = "utility:arrowdown";
            helper.sortStudentsStudentCode(component,0);
        } else {
            document.getElementById("sortIconByStudentCode").iconName = "utility:arrowup"
            helper.sortStudentsStudentCode(component,1);
        }
    },

    closeModel: function(component, event, helper) {
        component.set("v.showModal", false);
        component.set("v.showDeleteSelectedModal", false);
    },

    deleteSelectedStudent : function(component, event, helper) {
        helper.deleteSelectedStudent(component);
        component.set("v.showDeleteSelectedModal", false);
    },

    doDeleteStudent: function(component, event, helper) {
        helper.deleteStudent(component);
        component.set("v.showModal", false);
    },
})
