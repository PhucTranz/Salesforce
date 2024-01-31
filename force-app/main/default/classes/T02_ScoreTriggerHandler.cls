/**
 * クラス名：T02_ScoreTriggerHandler
 * クラス概要：Score trigger
 * @created：2024/01/24 Tran Dinh Phuc
 * @modified：
 */
public without sharing class T02_ScoreTriggerHandler {

    /**
     * updateSubjectScore
     * @param：List<Score__c> newScores
     * @return：なし
     * @created：2024/01/24 Tran Dinh Phuc
     * @modified：
     */
    public static void updateSubjectScore(List<Score__c> newScores) {
        try {
            //get list subjectScore Id
            List<String> subjectScoreIds = new List<String>();
            for (Score__c score: newScores) {
                subjectScoreIds.add(score.SubjectScore_look__c);
            }

            List<Score__c> listScore = [
                                        SELECT Id,
                                        ExamType__c,
                                        Score__c,
                                        SubjectScore_look__c
                                        FROM Score__c
                                        WHERE SubjectScore_look__c =:subjectScoreIds];
                       
            //get if there are all 4 types of exams
            Map<String,Integer> countScore = new Map<String,Integer>();
            List<Score__c> filteredList = new List<Score__c>();
            for (Score__c score: listScore) {
                if (countScore.containsKey(score.SubjectScore_look__c)) {
                    Integer value = countScore.get(score.SubjectScore_look__c);
                    countScore.put(score.SubjectScore_look__c, value + 1);
                } else {
                    countScore.put(score.SubjectScore_look__c, 1);
                }
            }
            for (Score__c score: listScore) {
                if (countScore.get(score.SubjectScore_look__c) == 4) {
                    filteredList.add(score);
                }
            }

            //calculate average score
            Map<String,Decimal> mapAvg = new Map<String,Decimal>();
            for (Score__c score: filteredList) {
                Decimal value = 0;
                if (mapAvg.containsKey(score.SubjectScore_look__c)) {
                    value = mapAvg.get(score.SubjectScore_look__c);
                }
                if (score.ExamType__c == 'Progress') {
                    mapAvg.put(score.SubjectScore_look__c, value + score.Score__c * 0.1);
                } else if (score.ExamType__c == 'Practical' || score.ExamType__c == 'Midterm Exam') {
                    mapAvg.put(score.SubjectScore_look__c, value + score.Score__c * 0.2);
                } else if (score.ExamType__c == 'FinalTerm Exam') {
                    mapAvg.put(score.SubjectScore_look__c, value + score.Score__c * 0.5);
                }
            }

            List<SubjectScore__c> subjectScores = [
                                                    SELECT Id, 
                                                    AverageScore__c, 
                                                    Status__c 
                                                    FROM SubjectScore__c
                                                    WHERE Id = :mapAvg.keySet()];
                                                    
            //update subjectScore
            for (SubjectScore__c subjectScore: subjectScores) {
                Decimal avgScore = mapAvg.get(subjectScore.Id).setScale(2, System.RoundingMode.HALF_UP);
                subjectScore.AverageScore__c = avgScore;
                if (avgScore >= 5) {
                    subjectScore.Status__c = 'Passed';
                } else {
                    subjectScore.Status__c = 'Not Passed';
                }
            }

            update subjectScores;
        } catch (Exception e) {
            System.debug(e);
        }
    }
}