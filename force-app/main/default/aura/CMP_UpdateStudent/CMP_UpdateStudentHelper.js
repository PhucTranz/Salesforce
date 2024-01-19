({
    doInit : function(component, event) {
        var action = component.get('c.getStudentByID');
        var params = event.getParam('arguments');

        action.setParams({studentId: params.studentId});
        action.setCallback(this, function(actionResult) {
            var state = actionResult.getState();
            if (state === "SUCCESS") {   
                component.set('v.student', actionResult.getReturnValue());
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

    validation : function(student){
        var isValid = true;

        if (this.isBlank(student.FirstName__c)) {
            document.getElementById("FNMessage").innerHTML = "Please enter first name";
            isValid = false;
        } else if (student.FirstName__c.length > 255) {
            document.getElementById("FNMessage").innerHTML = 'First name must be less than 255 characters';
            isValid = false;
        } else {
            document.getElementById("FNMessage").innerHTML = '';
        }
        
        if (this.isBlank(student.LastName__c)) {
            document.getElementById("LNMessage").innerHTML = 'Please enter last name';
            isValid = false;
        } else if (student.LastName__c.length > 255) {
            document.getElementById("LNMessage").innerHTML = 'Last name must be less than 255 characters';
            isValid = false;
        } else {
            document.getElementById("LNMessage").innerHTML = '';
        }

        if (this.isBlank(student.Address__c)) {
            document.getElementById("AMessage").innerHTML = 'Please enter address';
            isValid = false;
        } else if (student.Address__c.length > 255) {
            document.getElementById("AMessage").innerHTML = 'Address must be less than 255 characters';
            isValid = false;
        } else {
            document.getElementById("AMessage").innerHTML = '';
        }

        if (this.isBlank(student.BirthDay__c)) {
            document.getElementById("BDMessage").innerHTML = 'Please enter birthday';
            isValid = false;
        } else {
            var parts = student.BirthDay__c.split("-");
            var birthYear = parseInt(parts[0], 10);
            var currentDate = new Date();
            var currentYear = currentDate.getFullYear();
            if (currentYear - birthYear < 18) {
                document.getElementById("BDMessage").innerHTML = 'You must be at least 18 years old';
                isValid = false;
            } else {
                document.getElementById("BDMessage").innerHTML = '';
            }
        }
        if (this.isBlank(student.Class__c)) {
            document.getElementById("CMessage").innerHTML = 'Please choose a class';
            isValid = false;
        } else {
            document.getElementById("CMessage").innerHTML = '';
        }  

        if (student.Gender__c == null) {
            document.getElementById("GMessage").innerHTML = 'Please choose gender';
            isValid = false;
        } else {
            document.getElementById("GMessage").innerHTML = '';
        }  

        return isValid; 
    },

    isBlank : function(str) {
        if (str) {
            if(str.trim() === ''){
                return true;
            }
        } else {
            return true;
        }
        return false;
    },

    saveStudent : function(component) {
        var action = component.get('c.updateStudent');
        action.setParams({ student : component.get("v.student") });
        action.setCallback(this, function(actionResult){
            var state = actionResult.getState();

            var reload_evt = $A.get("e.c:CMP_reloadStudentEvt");
            reload_evt.fire();

            var toastEvent = $A.get("e.force:showToast");
            if (state === "SUCCESS") {   
                toastEvent.setParams({
                    "title": "Success!",
                    "type": "success",
                    "message": "Update successful"
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
