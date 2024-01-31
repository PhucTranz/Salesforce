/**
 * クラス名：B01_DeleteSubjectScoreScheduler
 * クラス概要：Batch schedule
 * @created：2024/01/25 Tran Dinh Phuc
 * @modified：
 */
public with sharing class B01_DeleteSubjectScoreScheduler implements Schedulable {
    /**
     * execute
     * @param：SchedulableContext sc
     * @return：なし
     * @created：2024/01/25 Tran Dinh Phuc
     * @modified：
     */
    public void execute(SchedulableContext sc) {
        B01_DeleteSubjectScoreBatch batch = new B01_DeleteSubjectScoreBatch();
        Database.executeBatch(batch);
    }

    /**
     * scheduleJob
     * @param：なし
     * @return：なし
     * @created：2024/01/31 Tran Dinh Phuc
     * @modified：
     */
    public static void scheduleJob() {
        String jobName = 'B01_DeleteSubjectScoreJob';
        String cronExp = '0 0 1 1 * ?';
        B01_DeleteSubjectScoreScheduler scheduler = new B01_DeleteSubjectScoreScheduler();
        System.schedule(jobName, cronExp, scheduler);
    }
}