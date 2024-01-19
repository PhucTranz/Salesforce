import { api, track } from 'lwc';
import LightningModal from 'lightning/modal';
import getStudentByID from '@salesforce/apex/LWC_DetailStudentCtrl.getStudentByID';

export default class LWC_DetailStudent extends LightningModal {
    @api studentId;
    @track student = {};

    connectedCallback() {
        getStudentByID({studentId: this.studentId})
        .then(result => {

            if(result.BirthDay__c){
                var part = result.BirthDay__c.split("-");
                result.BirthDay__c = part[2]+"/"+part[1]+"/"+part[0];
            }
            result.Class = result.Class__r.Name;

            this.student = result;
        })
        .catch(err => {
            const errEvt = new CustomEvent('detailerror', {
                detail: { msg: 'Student not exist or something error' }
            });
            this.dispatchEvent(errEvt);
            this.closeModal();
        })
    }

    closeModal() {
        this.close()
    }
}