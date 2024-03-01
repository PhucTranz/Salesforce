/**
* クラス名：LWC_DetailStudent
* クラス概要：detail student
* @created： 2024/01/12 Tran Dinh Phuc
* @modified：
*/
import { api, track } from 'lwc';
import LightningModal from 'lightning/modal';
import getStudentByID from '@salesforce/apex/LWC_DetailStudentCtrl.getStudentByID';

export default class LWC_DetailStudent extends LightningModal {
    @api studentId;
    @track student = {};
    isLoading = false;

    connectedCallback() {
        this.isLoading = true;
        getStudentByID({studentId: this.studentId})
        .then(result => {

            if(result.BirthDay__c){
                var part = result.BirthDay__c.split("-");
                result.BirthDay__c = part[2]+"/"+part[1]+"/"+part[0];
            }
            result.Class = result.Class_look__r.Name;

            this.student = result;
            this.isLoading = false;
        })
        .catch(err => {
            const errEvt = new CustomEvent('detailerror', {
                detail: { msg: 'Student not exist or something error' }
            });
            this.dispatchEvent(errEvt);
            this.isLoading = false;
            this.closeModal();
        })
        
    }

    closeModal() {
        this.close()
    }
}