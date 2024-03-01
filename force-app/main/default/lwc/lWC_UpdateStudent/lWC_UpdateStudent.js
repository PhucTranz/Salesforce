/**
* クラス名：LWC_UpdateStudent
* クラス概要：update student
* @created： 2024/01/11 Tran Dinh Phuc
* @modified：
*/
import { api, track } from 'lwc';
import LightningModal from 'lightning/modal';
import getStudentByID from '@salesforce/apex/LWC_UpdateStudentCtrl.getStudentByID';
import updateStudent from '@salesforce/apex/LWC_UpdateStudentCtrl.updateStudent';

export default class LWC_UpdateStudent extends LightningModal {
    @api classOptions;
    @api studentId;
    @track student = {};
    isLoading = false;

    connectedCallback() {
        this.isLoading = true;
        getStudentByID({studentId: this.studentId})
        .then(result => {
            this.student = result;
            this.isLoading = false;
        })
        .catch(err => {
            const errEvt = new CustomEvent('updateerror', {
                detail: { msg: 'Student not exist or something error' }
            });
            this.dispatchEvent(errEvt);
            this.isLoading = false;
            this.closeModal();
        })
    }

    get options() {
        return [
            { label: 'Male', value: 'Male' },
            { label: 'Female', value: 'Female' },
        ];
    }

    get learningStatusOptions() {
        return [
            { label: 'Enrolled', value: 'Enrolled' },
            { label: 'Withdrawn', value: 'Withdrawn' },
            { label: 'Graduated', value: 'Graduated' }
        ];
    }

    closeModal() {
        this.close()
    }

    saveRecordData() {
        
        this.student.FirstName__c = this.template.querySelector('.firstName').value;
        this.student.LastName__c = this.template.querySelector('.lastName').value;
        this.student.Gender__c = this.template.querySelector('.gender').value;
        this.student.BirthDay__c = this.template.querySelector('.birthDay').value;
        this.student.Class_look__c = this.template.querySelector('.class').value;
        this.student.Address__c = this.template.querySelector('.address').value;
        this.student.LearningStatus__c = this.template.querySelector('.learningStatus').value;

        if (this.validation()){
            updateStudent({student: this.student})
            .then(result =>{
                const reloadEvt = new CustomEvent('reloadstudent');
                this.dispatchEvent(reloadEvt);
                this.closeModal();
            })
            .catch(err => {
                const errEvt = new CustomEvent('updateerror', {
                    detail: { msg: err.body.message }
                });
                this.dispatchEvent(errEvt);
                this.closeModal();
            })
        }
    }

    validation() {
        var isValid = true;

        if (this.isBlank(this.student.FirstName__c)) {
            this.template.querySelector(".FNMessage").innerHTML = "Please enter first name";
            isValid = false;
        } else if (this.student.FirstName__c.length > 80) {
            this.template.querySelector(".FNMessage").innerHTML = 'First name must be less than 80 characters';
            isValid = false;
        } else {
            this.template.querySelector(".FNMessage").innerHTML = '';
        }
        
        if (this.isBlank(this.student.LastName__c)) {
            this.template.querySelector(".LNMessage").innerHTML = 'Please enter last name';
            isValid = false;
        } else if (this.student.LastName__c.length > 80) {
            this.template.querySelector(".LNMessage").innerHTML = 'Last name must be less than 80 characters';
            isValid = false;
        } else {
            this.template.querySelector(".LNMessage").innerHTML = '';
        }

        if (this.isBlank(this.student.Address__c)) {
            this.template.querySelector(".AMessage").innerHTML = 'Please enter address';
            isValid = false;
        } else if (this.student.Address__c.length > 255) {
            this.template.querySelector(".AMessage").innerHTML = 'Address must be less than 255 characters';
            isValid = false;
        } else {
            this.template.querySelector(".AMessage").innerHTML = '';
        }

        if (this.isBlank(this.student.BirthDay__c)) {
            this.template.querySelector(".BDMessage").innerHTML = 'Please enter birthday';
            isValid = false;
        } else {
            var parts = this.student.BirthDay__c.split("-");
            var birthYear = parseInt(parts[0], 10);
            var currentDate = new Date();
            var currentYear = currentDate.getFullYear();
            if(currentYear - birthYear < 18){
                this.template.querySelector(".BDMessage").innerHTML = 'You must be at least 18 years old';
                isValid = false;
            }else{
                this.template.querySelector(".BDMessage").innerHTML = '';
            }
        }

        if (this.isBlank(this.student.Class_look__c)) {
            this.template.querySelector(".CMessage").innerHTML = 'Please choose a class';
            isValid = false;
        } else {
            this.template.querySelector(".CMessage").innerHTML = '';
        }  

        if (this.isBlank(this.student.LearningStatus__c)) {
            this.template.querySelector(".SMessage").innerHTML = 'Please choose a status';
            isValid = false;
        } else {
            this.template.querySelector(".SMessage").innerHTML = '';
        }  

        if (this.isBlank(this.student.Gender__c)) {
            this.template.querySelector(".GMessage").innerHTML = 'Please choose gender';
            isValid = false;
        } else {
            this.template.querySelector(".GMessage").innerHTML = '';
        }  
        
        return isValid;
    }

    isBlank(str) {
        if (str) {
            if (str.trim() === '') {
                return true;
            }
        } else {
            return true;
        }
        return false;
    }
}