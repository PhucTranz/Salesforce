({
    doInit :  function(component, event) {
        var students = event.getParam("students");
        students.forEach(e => {
            e.selected = false;
        })
        component.set("v.students",students);
        if(event.getParam("isReload"))
            component.set("v.pageNumber",1)
        this.handlePaging(component);
        document.getElementById("message").innerHTML = "Selected 0 of "+component.get("v.totalRecords")+" students";
        document.getElementById("btn-deleteSelected").disabled = true;
        this.getClassOptions(component);
    },

    handlePaging : function(component) {
        var pageNumber = component.get("v.pageNumber");
        var pageSize = component.get("v.pageSize");
        var i = 0;
        var st = []
        if (pageNumber != 1) {
            i = (pageNumber-1)*pageSize;
        }

        var students = component.get("v.students");
        for (i; i< students.length && st.length < pageSize; i++) {
            students[i].STT = i + 1;
            students[i].BirthDay = this.formatDate(students[i].BirthDay__c);
            students[i].Class = students[i].Class_look__r.Name;
            st.push(students[i]);
        }

        var totalPages = Math.floor((students.length + pageSize - 1) / pageSize);
        var pages = [];
        var n = 0;
        if (pageNumber - 2 > 0) {
            n = 2;
        }
        if (pageNumber - 2 == 0) {
            n = 1;
        }
        if (pageNumber == totalPages) {
            n = 4;
        }
        if (totalPages - pageNumber == 1) {
            n = 3;
        }
        for (var i = pageNumber-n; i<=totalPages && pages.length < 5; i++) {
            if (i > 0) {
                pages.push(i);
            }
        }
        
        component.set("v.pages", pages);
        component.set("v.totalRecords", students.length);
        component.set("v.totalPages", totalPages);
        component.set("v.studentsToTable", st);
        this.isCheckedAll(component)
    },

    formatDate : function(date) {
        if (date) {
            var part = date.split("-");
            if (part.length == 3) {
                return part[2] + "/" + part[1] + "/" + part[0];
            } else {
                return date;
            }
        }
        return "";
    },

    isCheckedAll: function(component) {
        var isCheckAll = true; 
        var studentsToTable = component.get("v.studentsToTable");
        studentsToTable.forEach(e => {
            if (!e.selected) {
                isCheckAll = false;
            }
        })
        document.getElementById("checkAll").checked = isCheckAll;
        this.countChecked(component);
    },

    countChecked: function(component) {
        var count = 0;
        var students = component.get("v.students");
        students.forEach(e => {
            if (e.selected) {
                count ++;
            }
        })
        if (count == 0) {
            document.getElementById("btn-deleteSelected").disabled = true;
        } else {
            document.getElementById("btn-deleteSelected").disabled = false;
        }
        document.getElementById("message").innerHTML = "Selected " + count + " of " + component.get("v.totalRecords") + " students";
    },

    sortStudentsByBirthDay: function(component, flag) {
        var students = component.get("v.students");
        if (flag == 1) {
            students.sort(function(a, b) {
                var dateA = new Date(a.BirthDay__c);
                var dateB = new Date(b.BirthDay__c);
                return dateA - dateB;
            });
        } else {
            students.sort(function(a, b) {
                var dateA = new Date(a.BirthDay__c);
                var dateB = new Date(b.BirthDay__c);
                return dateB - dateA;
            });
        }
        
        component.set("v.students", students);
        this.handlePaging(component);
    },

    sortStudentsByName: function(component, flag) {
        var students = component.get("v.students");
        if (flag == 0) {
            students.sort(function(a, b) {
                return a.Name.localeCompare(b.Name); 
            });
        } else {
            students.sort(function(a, b) {
                return b.Name.localeCompare(a.Name); 
            });
        }
        
        component.set("v.students", students);
        this.handlePaging(component);
    },

    sortStudentsStudentCode: function(component, flag) {
        var students = component.get("v.students");
        if (flag == 0) {
            students.sort(function(a, b) {
                return a.StudentCode__c.localeCompare(b.StudentCode__c); 
            });
        } else {
            students.sort(function(a, b) {
                return b.StudentCode__c.localeCompare(a.StudentCode__c); 
            });
        }
        
        component.set("v.students", students);
        this.handlePaging(component);
    },

    getClassOptions: function(component) {
        var action = component.get("c.getListClass");

        action.setCallback(this, function(actionResult) {
            var state = actionResult.getState();
            if (state === "SUCCESS") {
                var classOptions = [];
                classOptions.push({"value":"","label":"----"})
                var classes = actionResult.getReturnValue();
                for (var i = 0; i < classes.length; i++) {
                    classOptions.push({"value":classes[i].Id,"label":classes[i].Name});
                }
                component.set("v.classOptions", classOptions);
            }
        });

        $A.enqueueAction(action);
    },

    getStudentToDelete : function(component, event) {
        var studentId = event.currentTarget.value;
        var action = component.get('c.getStudentByID');
        action.setParams({studentId: studentId});
        action.setCallback(this, function(actionResult) {
            var state = actionResult.getState();
            if (state === "SUCCESS") {  
                var student = actionResult.getReturnValue();
                if(student.BirthDay__c){
                    var part = student.BirthDay__c.split("-");
                    student.BirthDay__c = part[2] + "/" + part[1] + "/" + part[0];
                }
                component.set('v.student', student);
                component.set("v.showModal", true);
            } else {
                var reload_evt = $A.get("e.c:CMP_reloadStudentEvt");
                reload_evt.fire();

                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "title": "Error!",
                    "type": "error",
                    "message": "Couldn't get student from database"
                });
                toastEvent.fire();
            }
        });
        $A.enqueueAction(action);
    },

    deleteStudent : function(component) {
        var action = component.get('c.delStudentByID');
        action.setParams({ studentId : component.get("v.student").Id });
        action.setCallback(this, function(actionResult) {
            var state = actionResult.getState();
            var reload_evt = $A.get("e.c:CMP_reloadStudentEvt");
            reload_evt.fire();
            var toastEvent = $A.get("e.force:showToast");

            if (state === "SUCCESS") { 
                toastEvent.setParams({
                    "title": "Success!",
                    "type": "success",
                    "message": "Delete successful"
                });
            } else {
                toastEvent.setParams({
                    "title": "Error!",
                    "type": "error",
                    "message": "Couldn't get student from database"
                });
            }
            toastEvent.fire();
        });
        $A.enqueueAction(action);
    },

    deleteSelectedStudent: function(component) {
        var action = component.get('c.delSelectedStudent');
        action.setParams({studentCodes : component.get("v.selectedStudent")});
        action.setCallback(this, function(actionResult) {
            var state = actionResult.getState();
            var reload_evt = $A.get("e.c:CMP_reloadStudentEvt");
            reload_evt.fire();
            var toastEvent = $A.get("e.force:showToast");

            if (state === "SUCCESS") { 
                toastEvent.setParams({
                    "title": "Success!",
                    "type": "success",
                    "message": "Delete successful"
                });
            } else {
                toastEvent.setParams({
                    "title": "Error!",
                    "type": "error",
                    "message": "Couldn't get student from database"
                });
            }
            toastEvent.fire();
        });
        $A.enqueueAction(action);
    },
})
