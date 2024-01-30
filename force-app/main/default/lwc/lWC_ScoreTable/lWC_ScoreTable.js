import { api, track, LightningElement } from 'lwc';
import getSubjectScore from '@salesforce/apex/LWC_DetailStudentCtrl.getSubjectScore';
import getStudentByID from '@salesforce/apex/LWC_DetailStudentCtrl.getStudentByID';

export default class LWC_ScoreTable extends LightningElement {
    @api studentId;
    @api gpa;
    @api totalCredit;
    // @track subjectScores = [];
    // @track subjectScoresToView = [];
    @track semesterOptions = [];
    @track data = [];

    connectedCallback() {
        this.getSubjectScores();
    }

    // getSubjectScores() {
    //     getSubjectScore({studentId: this.studentId})
    //     .then(result => {  
    //         const semesters = new Map(); 
    //         this.semesterOptions = [{ label: '全て', value: '' }];
    //         result.forEach(e => {
    //             if (!semesters.has(e.Semester_look__r.Id)) {
    //                 semesters.set(e.Semester_look__r.Id, e.Semester_look__r.Name)
    //                 this.semesterOptions.push({ label: e.Semester_look__r.Name, value: e.Semester_look__r.Id })
    //             }
    //             e.Score__r.forEach(score => {
    //                 if (score.ExamType__c === 'Progress') {
    //                     e.progress = score.Score__c
    //                 } else if (score.ExamType__c === 'Practical') {
    //                     e.practical = score.Score__c
    //                 } else if (score.ExamType__c === 'Midterm Exam') {
    //                     e.midterm = score.Score__c
    //                 } else if (score.ExamType__c === 'FinalTerm Exam') {
    //                     e.finnal = score.Score__c
    //                 }
    //             })
    //         })
    //         this.semesterOptions.sort((a, b) => {
    //             return a.label.localeCompare(b.label);
    //         });
            
    //         this.subjectScores = result;
    //         this.subjectScoresToView = this.subjectScores;
    //     })
    //     .catch(err => {
    //         console.log(err.message);
    //     })
    // }

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
            })
            this.semesterOptions.sort((a, b) => {
                return a.label.localeCompare(b.label);
            });

            for (const key of semesters.keys()) {
                const subjectScores = result.filter(e => e.Semester_look__c === key);
                this.data.push({show: true, subjectScores, semester: semesters.get(key), id: key})
            }
            this.data.sort((a, b) => {
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