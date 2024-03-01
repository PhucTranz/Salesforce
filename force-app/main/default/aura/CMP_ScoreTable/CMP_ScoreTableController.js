/**
* クラス名：CMP_ScoreTableController
* クラス概要：Scoretable controller
* @created： 2024/01/08 Tran Dinh Phuc
* @modified：
*/
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
