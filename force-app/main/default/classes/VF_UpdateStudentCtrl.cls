/**
 * VF_UpdateStudentCtrl
 * クラス概要：update student's information
 * @created：2023/12/14 Tran Dinh Phuc
 * @modified：
 */
public with sharing class VF_UpdateStudentCtrl {

    public Student__c student {get; set;}

    /**
     * VF_UpdateStudentCtrl
     * @created：2023/12/14 Tran Dinh Phuc
     * @modified：
     */
    public VF_UpdateStudentCtrl() {
        this.student = getStudent();
    }

    /**
     * getOptions
     * @param：なし
     * @return：List<SelectOption>
     * @created：2023/12/14 Tran Dinh Phuc
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
     * getStudent
     * @param：なし
     * @return：Student__c
     * @created：2023/12/14 Tran Dinh Phuc
     * @modified：
     */
    private static Student__c getStudent(){
        String studentId = ApexPages.currentPage().getParameters().get('studentId');
        return [SELECT Id,
                    Address__c, 
                    BirthDay__c, 
                    Class_look__c, 
                    FirstName__c, 
                    Gender__c, 
                    LastName__c, 
                    StudentCode__c 
                    FROM Student__c 
                    WHERE Id = :studentId];
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

    /**
     * updateStudent
     * @param：なし
     * @return：PageReference
     * @created：2023/12/14 Tran Dinh Phuc
     * @modified：
     */
    public PageReference updateStudent(){
        try {
            student.Name = student.FirstName__c.left(39) + ' ' +  student.LastName__c.left(39);
            update student;

            String url = '/apex/VF_DetailStudent?studentId=' + student.Id;
            return new PageReference(url);
        } catch (Exception e) {
            ApexPages.addMessages(e);
            return null;
        }
    }
}