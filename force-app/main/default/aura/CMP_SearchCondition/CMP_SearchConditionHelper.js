({
    getStudents : function(component, isReload) {
        var action = component.get('c.getAllStudent');
        action.setParams({ 
            searchByName : component.get("v.searchByName"),
            searchByClass : component.get("v.searchByClass") ,
            searchByStudentCode : component.get("v.searchByStudentCode") ,
            searchByGender : component.get("v.searchByGender"),
            searchByBirthday : component.get("v.searchByBirthday"),
            searchByYear : component.get("v.searchByYear"),
            searchByMonth : component.get("v.searchByMonth"),
            searchByDay : component.get("v.searchByDay")
        });

        action.setCallback(this, function(actionResult) {
            var state = actionResult.getState();
            if (state === "SUCCESS") {   
                var students = actionResult.getReturnValue();
                var sendDataEvent = $A.get("e.c:CMP_SearchStudentEvt");
                sendDataEvent.setParams({ "students": students, "isReload" : isReload});
                sendDataEvent.fire();
            }
        });
        $A.enqueueAction(action);
    },

    selectListYear: function(component) {
        var yearOptions = [];
        yearOptions.push({"value":0,"label":"----"});

        for (var i = 2007; i >= 1980; i--) {
            yearOptions.push({"value":i,"label":i});
        }
        component.set("v.yearOptions",yearOptions);
    },

    selectListMonth: function(component) {
        var monthOptions = [];
        monthOptions.push({"value":0,"label":"----"});

        for (var i = 1; i <= 12; i++) {
            monthOptions.push({"value":i,"label":i});
        }
        component.set("v.monthOptions",monthOptions);
    },

    selectListDay: function(component) {
        var year = parseInt(component.get("v.searchByYear"));
        var month = parseInt(component.get("v.searchByMonth"));
        var daySelected = component.get("v.searchByDay");
        
        var dayOptions = [];
        dayOptions.push({"value":0,"label":"----"});
    
        var daysInMonth = new Date(year, month, 0).getDate();
        for (var i = 1; i <= daysInMonth; i++) {
            dayOptions.push({"value":i,"label":i});
        }
        component.set("v.dayOptions",dayOptions);

        if (parseInt(daySelected) > daysInMonth || daySelected == null) {
            component.set("v.searchByDay",0);
        } else {
            component.set("v.searchByDay",parseInt(daySelected));
        }
    },

    getClassOptions : function(component) {
        var action = component.get("c.getListClass");

        action.setCallback(this, function(actionResult) {
            var state = actionResult.getState();
            if (state === "SUCCESS") {
                var classOptions = [];
                classOptions.push({"value":"","label":"----"})
                var classes = actionResult.getReturnValue();
                for(var i = 0; i < classes.length; i++){
                    classOptions.push({"value":classes[i].Id,"label":classes[i].Name});
                }
                component.set("v.classOptions", classOptions);
            }
        });

        $A.enqueueAction(action);
    },
})
