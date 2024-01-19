import { api } from 'lwc';
import LightningModal from 'lightning/modal';
import createStudent from '@salesforce/apex/LWC_CreateStudentCtrl.createStudent';
export default class LWC_CreateStudent extends LightningModal {
    @api classOptions;

    get options() {
        return [
            { label: 'Male', value: 'true' },
            { label: 'Female', value: 'false' },
        ];
    }

    closeModal() {
        this.close()
    }

    saveRecordData() {
        var firstName = this.template.querySelector('.firstName').value;
        var lastName = this.template.querySelector('.lastName').value;
        var gender = this.template.querySelector('.gender').value;
        var birthDay = this.template.querySelector('.birthDay').value;
        var Class = this.template.querySelector('.class').value;
        var address = this.template.querySelector('.address').value;

        if (this.validation(firstName, lastName, gender, birthDay, Class, address)){
            createStudent({studentJson: JSON.stringify({
                FirstName__c: firstName, 
                LastName__c: lastName, 
                Gender__c: gender, 
                BirthDay__c: birthDay, 
                Class__c: Class, 
                Address__c: address})})
            .then(result =>{
                const reloadEvt = new CustomEvent('reloadstudent');
                this.dispatchEvent(reloadEvt);
                this.closeModal();
            })
            .catch(err => {
                alert(err.body.message)
            })
        }
    }

    validation(firstName, lastName, gender, birthDay, Class, address) {
        var isValid = true;

        if (this.isBlank(firstName)) {
            this.template.querySelector(".FNMessage").innerHTML = "Please enter first name";
            isValid = false;
        } else if (firstName.length > 255) {
            this.template.querySelector(".FNMessage").innerHTML = 'First name must be less than 255 characters';
            isValid = false;
        } else {
            this.template.querySelector(".FNMessage").innerHTML = '';
        }
        
        if (this.isBlank(lastName)) {
            this.template.querySelector(".LNMessage").innerHTML = 'Please enter last name';
            isValid = false;
        } else if (lastName.length > 255) {
            this.template.querySelector(".LNMessage").innerHTML = 'Last name must be less than 255 characters';
            isValid = false;
        } else {
            this.template.querySelector(".LNMessage").innerHTML = '';
        }

        if (this.isBlank(address)) {
            this.template.querySelector(".AMessage").innerHTML = 'Please enter address';
            isValid = false;
        } else if (address.length > 255) {
            this.template.querySelector(".AMessage").innerHTML = 'Address must be less than 255 characters';
            isValid = false;
        } else {
            this.template.querySelector(".AMessage").innerHTML = '';
        }

        if (this.isBlank(birthDay)) {
            this.template.querySelector(".BDMessage").innerHTML = 'Please enter birthday';
            isValid = false;
        } else {
            var parts = birthDay.split("-");
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

        if (this.isBlank(Class)) {
            this.template.querySelector(".CMessage").innerHTML = 'Please choose a class';
            isValid = false;
        } else {
            this.template.querySelector(".CMessage").innerHTML = '';
        }  

        if (this.isBlank(gender)) {
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