({
    doInit : function(component, event) {
        var action = component.get('c.getStudentByID');
        var params = event.getParam('arguments');

        action.setParams({studentId: params.studentId});
        action.setCallback(this, function(actionResult){
            var state = actionResult.getState();
            if (state === "SUCCESS") {   
                var student = actionResult.getReturnValue();
                if(student.BirthDay__c){
                    var part = student.BirthDay__c.split("-");
                    student.BirthDay__c = part[2]+"/"+part[1]+"/"+part[0];
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
})
