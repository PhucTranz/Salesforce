@IsTest
private class B01_DeleteSubjectScoreBatchTest {
    @IsTest 
    private static void testB01() {
        List<SubjectScore__c> subjectScores = new List<SubjectScore__c>();
        for (Integer i = 0; i < 100; i++) {
            subjectScores.add(new SubjectScore__c());
        }
        insert subjectScores;

        Test.startTest();
        B01_DeleteSubjectScoreBatch b01 = new B01_DeleteSubjectScoreBatch();
        Database.executeBatch(b01);
        Test.stopTest();

        subjectScores = [SELECT Id FROM SubjectScore__c];
        System.assertEquals(0, subjectScores.size());
        Batchlog__c log = [SELECT Id, Result__c FROM Batchlog__c WHERE Name = 'B01_科目得点削除バッチ' LIMIT 1];
        System.assertEquals('Success', log.Result__c);
    }
}