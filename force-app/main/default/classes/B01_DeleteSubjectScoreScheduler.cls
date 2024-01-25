public with sharing class B01_DeleteSubjectScoreScheduler implements Schedulable {
    public void execute(SchedulableContext sc) {
        B01_DeleteSubjectScoreBatch batch = new B01_DeleteSubjectScoreBatch();
        Database.executeBatch(batch);
    }
}