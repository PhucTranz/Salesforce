/**
 * クラス名：VF_SearchStudentCtrl
 * クラス概要：Search student controller
 * @created：2023/12/14 Tran Dinh Phuc
 * @modified：
 */
public with sharing class VF_SearchStudentCtrl {
    
    // //properties for add, update, detail, delete Student
    // public List<Student__c> students { get; set; }
    // public Student__c student { get; set; }
    // public String studentId { get; set; }
    // public String className {get; set;}
    // public Map<String, Boolean> selectedStudent {get; set;}
    // public Integer countSelected {get; set;}
    // public List<String> studentsToDelete {get; set;}
    // public String studentCode { get; set; }

    // //properties for paging and search
    // public String searchByName { get; set; }
    // public String searchByStudentCode { get; set; }
    // public String searchByGender { get; set; }
    // public String searchByClass { get; set; }
    // public Date searchByBirthday { get; set; }
    // public Integer searchByYear { get; set; }
    // public Integer searchByMonth { get; set; }
    // public Integer searchByDay { get; set; }
    // public Integer pageSize { get; set; }
    // public Integer pageNumber { get; set; }
    // public Integer totalRecords { get; set; }
    // public Integer totalPages { get; set; }
    // public Boolean hasPreviousPage {get { return pageNumber > 1; }}
    // public Boolean hasNextPage {get { return pageNumber < totalPages; }}

    // /**
    //  * クラス名：VF_SearchStudentCtrl
    //  * @created：2023/12/14 Tran Dinh Phuc
    //  * @modified：
    //  */
    // public VF_SearchStudentCtrl() {
    //     student = new Student__c();
    //     pageSize = 5;
    //     pageNumber = 1;
    //     selectedStudent = new Map<String, Boolean>();
    //     countSelected = 0;
    //     loadData();
    // }

    // /**
    //  * loadData
    //  * @param：なし
    //  * @return：なし
    //  * @created：2023/12/14 Tran Dinh Phuc
    //  * @modified：
    //  */
    // public void loadData() {
    //     Integer offset = pageSize * (pageNumber - 1);
    //     String query = 'SELECT Id, Name, Address__c, Gender__c, StudentCode__c, Class__r.Name, BirthDay__c FROM Student__c';
    //     List<String> lstWhereConditions = new List<String>();
    //     if (String.isNotBlank(searchByName)) {
    //         lstWhereConditions.add(' Name LIKE \'%' + String.escapeSingleQuotes(searchByName.trim()) + '%\'');
    //     }

    //     if (String.isNotBlank(searchByStudentCode)) {
    //         lstWhereConditions.add(' StudentCode__c LIKE \'%' + String.escapeSingleQuotes(searchByStudentCode.trim()) + '%\'');
    //     }

    //     if (String.isNotBlank(searchByGender)) {
    //         lstWhereConditions.add(' Gender__c = ' + Boolean.valueOf(searchByGender));
    //     }

    //     if (String.isNotBlank(searchByClass)) {
    //         lstWhereConditions.add(' Class__c = :searchByClass');
    //     }

    //     if (searchByBirthday != null) {
    //         lstWhereConditions.add(' BirthDay__c = :searchByBirthday');
    //     }

    //     if (searchByYear != 0 && searchByYear != null) {
    //         lstWhereConditions.add(' CALENDAR_YEAR(BirthDay__c) = :searchByYear');
    //     }

    //     if (searchByMonth != 0 && searchByMonth != null) {
    //         lstWhereConditions.add(' CALENDAR_MONTH(BirthDay__c) = :searchByMonth');
    //     }

    //     if (searchByDay != 0 && searchByDay != null) {
    //         lstWhereConditions.add(' DAY_IN_MONTH(BirthDay__c) = :searchByDay');
    //     }

    //     if (!lstWhereConditions.isEmpty()) {
    //         String whereClause = String.join( lstWhereConditions, ' AND ' );
    //         query += ' WHERE' + whereClause;
    //         totalRecords = Database.countQuery('SELECT COUNT() FROM Student__c WHERE ' + whereClause);
    //     } else {
    //         totalRecords = [SELECT COUNT() FROM Student__c];
    //     }

    //     query += ' ORDER BY StudentCode__c DESC LIMIT :pageSize OFFSET :offset';
    //     students = Database.query(query);

    //     for (Student__c st : students) {
    //         if (!selectedStudent.containsKey(st.StudentCode__c)) {
    //             selectedStudent.put(st.StudentCode__c, false);
    //         }
    //     }
        
    //     totalPages = (totalRecords + pageSize - 1) / pageSize;
    //     getPages();
    // }

    // /**
    //  * getPages
    //  * @param：なし
    //  * @return：List<Integer>
    //  * @created：2023/12/20 Tran Dinh Phuc
    //  * @modified：
    //  */
    // public List<Integer> getPages(){
    //     List<Integer> pages = new List<Integer>();
    //     Integer n = 0;
    //     if(pageNumber - 2 > 0)
    //         n = 2;
    //     if(pageNumber - 2 == 0)
    //         n = 1;
    //     if(!hasNextPage)
    //         n = 4;
    //     if(totalPages - pageNumber == 1)
    //         n = 3;
    //     for(Integer i = pageNumber-n; i<=totalPages && pages.size() < 5; i++){
    //         if(i > 0)
    //             pages.add(i);
    //     }
    //     return pages;
    // }

    // /**
    //  * getFirstPage
    //  * @param：なし
    //  * @return：PageReference
    //  * @created：2023/12/14 Tran Dinh Phuc
    //  * @modified：
    //  */
    // public PageReference getFirstPage() {
    //     pageNumber = 1;
    //     loadData();
    //     return null;
    // }

    // /**
    //  * handlePreviousPage
    //  * @param：なし
    //  * @return：PageReference
    //  * @created：2023/12/14 Tran Dinh Phuc
    //  * @modified：
    //  */
    // public PageReference handlePreviousPage() {
    //     pageNumber--;
    //     loadData();
    //     return null;
    // }

    // /**
    //  * handleNextPage
    //  * @param：なし
    //  * @return：PageReference
    //  * @created：2023/12/14 Tran Dinh Phuc
    //  * @modified：
    //  */
    // public PageReference handleNextPage() {
    //     pageNumber++;
    //     loadData();
    //     return null;
    // }

    // /**
    //  * getlastPage
    //  * @param：なし
    //  * @return：PageReference
    //  * @created：2023/12/14 Tran Dinh Phuc
    //  * @modified：
    //  */
    // public PageReference getlastPage() {
    //     pageNumber = totalPages;
    //     loadData();
    //     return null;
    // }
    
    // /**
    //  * moveToPage
    //  * @param：なし
    //  * @return：PageReference
    //  * @created：2023/12/20 Tran Dinh Phuc
    //  * @modified：
    //  */
    // public PageReference moveToPage() {
    //     loadData();
    //     return null;
    // }

    // /**
    //  * setStudent
    //  * @param：なし
    //  * @return：なし
    //  * @created：2023/12/15 Tran Dinh Phuc
    //  * @modified：
    //  */
    // public void setStudent(){
    //     if(String.isNotBlank(studentId)){
    //         this.student = [SELECT Address__c, BirthDay__c,Class__r.Name, FirstName__c, Gender__c, LastName__c, StudentCode__c FROM Student__c WHERE Id = :studentId];
    //         this.className = student.Class__r.Name;
    //     }else{
    //         this.student = new Student__c();
    //     }
    // }

    // /**
    //  * getOptions
    //  * @param：なし
    //  * @return：List<SelectOption>
    //  * @created：2023/12/15 Tran Dinh Phuc
    //  * @modified：
    //  */
    // public List<SelectOption> getOptions() {
    //     List<SelectOption> options = new List<SelectOption>();
    //     List<Class__c> listClass = getListClass();
    //     options.add(new SelectOption('', '---'));
    //     for(Class__c cl: listClass){
    //         options.add(new SelectOption(cl.Id, cl.Name));
    //     }
    //     return options;
    // }

    // /**
    //  * getGenderOptions
    //  * @param：なし
    //  * @return：List<SelectOption>
    //  * @created：2023/12/18 Tran Dinh Phuc
    //  * @modified：
    //  */
    // public List<SelectOption> getGenderOptions() {
    //     List<SelectOption> genderOptions = new List<SelectOption>();
    //     genderOptions.add(new SelectOption('','Both'));
    //     genderOptions.add(new SelectOption('true', 'Male'));
    //     genderOptions.add(new SelectOption('false', 'Female'));
    //     return genderOptions;
    // }

    // /**
    //  * getListClass
    //  * @param：なし
    //  * @return：List<Class__c>
    //  * @created：2023/12/15 Tran Dinh Phuc
    //  * @modified：
    //  */
    // private static List<Class__c> getListClass(){
    //     return [SELECT ClassCode__c, Name FROM Class__c ORDER BY ClassCode__c ASC];
    // }

    // /**
    //  * createStudent
    //  * @param：なし
    //  * @return：なし
    //  * @created：2023/12/16 Tran Dinh Phuc
    //  * @modified：
    //  */
    // public void createStudent(){
    //     try {
    //         student.Id = (new Student__c()).Id;
    //         student.Name = student.FirstName__c.left(39) + ' ' +  student.LastName__c.left(39);
    //         insert student;
    //         loadData();
    //         ApexPages.Message susscessMessage = new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Add successful');
    //         ApexPages.addMessage(susscessMessage);
    //     } catch (Exception e) {
    //         ApexPages.addMessages(e);
    //     }
    // }

    // /**
    //  * search
    //  * @param：なし
    //  * @return：なし
    //  * @created：2023/12/17 Tran Dinh Phuc
    //  * @modified：
    //  */
    // public void search() {
    //     pageNumber = 1;
    //     loadData();
    // }

    // /**
    //  * updateStudent
    //  * @param：なし
    //  * @return：なし
    //  * @created：2023/12/17 Tran Dinh Phuc
    //  * @modified：
    //  */
    // public void updateStudent(){
    //     try {
    //         student.Name = student.FirstName__c.left(39) + ' ' +  student.LastName__c.left(39);
    //         update student;
    //         loadData();
    //         ApexPages.Message susscessMessage = new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Update successful');
    //         ApexPages.addMessage(susscessMessage);
    //     } catch (Exception e) {
    //         ApexPages.addMessages(e);
    //     }
    // }

    // /**
    //  * deleteStudent
    //  * @param：なし
    //  * @return：なし
    //  * @created：2023/12/18 Tran Dinh Phuc
    //  * @modified：
    //  */
    // public void deleteStudent(){
    //     try {
    //         delete student;
    //         loadData();
    //         ApexPages.Message susscessMessage = new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Delete successful');
    //         ApexPages.addMessage(susscessMessage);
    //     } catch (Exception e) {
    //         ApexPages.addMessages(e);
    //     }
    // }

    // /**
    //  * deleteSelectedStudent
    //  * @param：なし
    //  * @return：なし
    //  * @created：2023/12/19 Tran Dinh Phuc
    //  * @modified：
    //  */
    // public void deleteSelectedStudent(){
    //     try{
    //         List<String> liststudentCode = new List<String>();
    //         for (String key : selectedStudent.keySet()) {
    //             if(selectedStudent.get(key)){
    //                 liststudentCode.add(key);
    //             }
    //         }
            
    //         List<Student__c> listStudent =  [SELECT Id FROM Student__c WHERE StudentCode__c = :liststudentCode];
            
    //         delete listStudent;
    //         selectedStudent = new Map<String, Boolean>();
    //         countSelected();
    //         loadData();
    //         ApexPages.Message susscessMessage = new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Delete successful');
    //         ApexPages.addMessage(susscessMessage);
    //     }catch(Exception e){
    //         ApexPages.addMessages(e);
    //     }
    // }

    // /**
    //  * selectAllStudent
    //  * @param：なし
    //  * @return：なし
    //  * @created：2023/12/19 Tran Dinh Phuc
    //  * @modified：
    //  */
    // public void selectAllStudent(){
    //     for (Student__c st : students) {
    //         selectedStudent.put(st.StudentCode__c, true);
    //     }
    //     countSelected();
    // }

    // /**
    //  * clearSelectedStudent
    //  * @param：なし
    //  * @return：なし
    //  * @created：2023/12/19 Tran Dinh Phuc
    //  * @modified：
    //  */
    // public void clearSelectedStudent(){
    //     for (Student__c st : students) {
    //         selectedStudent.put(st.StudentCode__c, false);
    //     }
    //     countSelected();
    // }

    // /**
    //  * selectStudent
    //  * @param：なし
    //  * @return：なし
    //  * @created：2024/01/18 Tran Dinh Phuc
    //  * @modified：
    //  */
    // public void selectStudent() {
    //     if (String.isNotBlank(studentCode)) {
    //         Boolean value = selectedStudent.get(studentCode);
    //         selectedStudent.put(studentCode, value);
    //     }
    //     countSelected();
    // }

    // /**
    //  * countSelected
    //  * @param：なし
    //  * @return：なし
    //  * @created：2024/01/18 Tran Dinh Phuc
    //  * @modified：
    //  */
    // public void countSelected(){
    //     studentsToDelete = new List<String>();
    //     countSelected = 0;
    //     for (String key : selectedStudent.keySet()) {
    //         if(selectedStudent.get(key)){
    //             countSelected++;
    //             studentsToDelete.add(key);
    //         }
    //     }
    // }
}