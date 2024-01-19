/**
 * クラス名：VF_CreateStudentCtrl
 * クラス概要：create a new student
 * @created：2023/12/13 Tran Dinh Phuc
 * @modified：
 */
public with sharing class VF_CreateStudentCtrl {

    public Student__c student {get; set;}

    /**
     * クラス名：VF_CreateStudentCtrl
     * @created：2023/12/13 Tran Dinh Phuc
     * @modified：
     */
    public VF_CreateStudentCtrl() {
        this.student = new Student__c();
    }

    /**
     * getOptions
     * @param：なし
     * @return：List<SelectOption>
     * @created：2023/12/13 Tran Dinh Phuc
     * @modified：
     */
    public List<SelectOption> getOptions() {
        List<SelectOption> options = new List<SelectOption>();
        List<Class__c> listClass = getListClass();
        for(Class__c cl: listClass){
            options.add(new SelectOption(cl.Id, cl.Name));
        }
        return options;
    }

    /**
     * createStudent
     * @param：なし
     * @return：PageReference
     * @created：2023/12/13 Tran Dinh Phuc
     * @modified：
     */
    public PageReference createStudent(){
        try {
            student.Name = student.FirstName__c.left(39) + ' ' +  student.LastName__c.left(39);
            insert student;
            String url = '/apex/VF_DetailStudent?studentId=' + student.Id;
            return new PageReference(url);
        } catch (Exception e) {
            ApexPages.addMessages(e);
            return null;
        }
    }

    /**
     * getListClass
     * @param：なし
     * @return：List<Class__c>
     * @created：2023/12/14 Tran Dinh Phuc
     * @modified：
     */
    private static List<Class__c> getListClass(){
        return [SELECT ClassCode__c, Name FROM Class__c ORDER BY ClassCode__c ASC];
    }
}