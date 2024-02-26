import { api, track, LightningElement } from 'lwc';
import getSubjectScore from '@salesforce/apex/LWC_DetailStudentCtrl.getSubjectScore';

export default class LWC_ScoreTable extends LightningElement {
    @api studentId;
    @api gpa;
    @api totalCredit;
    @track semesterOptions = [];
    @track data = [];

    connectedCallback() {
        this.getSubjectScores();
    }

    getSubjectScores() {
        getSubjectScore({studentId: this.studentId})
        .then(result => {  
            const semesters = new Map(); 
            this.semesterOptions = [{ label: '全て', value: '' }];
            result.forEach(e => {
                if (!semesters.has(e.Semester_look__r.Id)) {
                    semesters.set(e.Semester_look__r.Id, e.Semester_look__r.Name)
                    this.semesterOptions.push({ label: e.Semester_look__r.Name, value: e.Semester_look__r.Id })
                }
                if (e.Score__r) {
                    e.Score__r.forEach(score => {
                        if (score.ExamType__c === 'Progress') {
                            e.progress = score.Score__c
                        } else if (score.ExamType__c === 'Practical') {
                            e.practical = score.Score__c
                        } else if (score.ExamType__c === 'Midterm Exam') {
                            e.midterm = score.Score__c
                        } else if (score.ExamType__c === 'FinalTerm Exam') {
                            e.finnal = score.Score__c
                        }
                    })
                }
            })
            this.semesterOptions.sort((a, b) => {
                var label1 = a.label.split(', ');
                var label2 = b.label.split(', ');
                if (label1.length == 2 && label2.length == 2) {
                    if (label1[1].localeCompare(label2[1]) > 0) {
                        return 1;
                    } else if (label1[1].localeCompare(label2[1]) < 0) {
                        return -1;
                    }
                }
                return a.label.localeCompare(b.label);
            });

            for (const key of semesters.keys()) {
                const subjectScores = result.filter(e => e.Semester_look__c === key);
                var credit = 0;
                var avg = 0;
                subjectScores.forEach(e => {
                    if (e.AverageScore__c) {
                        credit += e.Subject_look__r.CourseCredit__c;
                        avg += e.AverageScore__c * e.Subject_look__r.CourseCredit__c;
                    }
                })
                if (credit != 0) {
                    avg = (avg/credit).toFixed(2);
                }
                this.data.push({show: true, subjectScores, semester: semesters.get(key), id: key, avg, credit})
            }
            this.data.sort((a, b) => {
                var semester1 = a.semester.split(', ');
                var semester2 = b.semester.split(', ');
                if (semester1.length == 2 && semester2.length == 2) {
                    if (semester1[1].localeCompare(semester2[1]) > 0) {
                        return 1;
                    } else if (semester1[1].localeCompare(semester2[1]) < 0) {
                        return -1;
                    }
                }
                return a.semester.localeCompare(b.semester);
            });
        })
        .catch(err => {
            console.log(err.message);
        })
    }

    changeSemester() {
        const semester = this.template.querySelector('.semester').value;
        this.data.forEach(e => {
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
    }
}