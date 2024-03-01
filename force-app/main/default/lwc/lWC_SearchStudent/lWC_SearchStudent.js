/**
* クラス名：LWC_SearchStudent
* クラス概要：search student
* @created： 2024/01/08 Tran Dinh Phuc
* @modified：
*/
import { LightningElement, track, wire } from 'lwc';
import searchCondition from '@salesforce/apex/LWC_SearchStudentCtrl.searchCondition';
import getListClass from '@salesforce/apex/LWC_SearchStudentCtrl.getListClass';
import delSelectedStudent from '@salesforce/apex/LWC_SearchStudentCtrl.delSelectedStudent';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import createStudent from 'c/lWC_CreateStudent';
import updateStudent from 'c/lWC_UpdateStudent';
import detailStudent from 'c/lWC_DetailStudent';
import { loadStyle } from 'lightning/platformResourceLoader';
import LWC_SearchStudentCSS from '@salesforce/resourceUrl/LWC_SearchStudentCSS';

export default class LWC_SearchStudent extends LightningElement {
    @track listStudent = [];
    @track studentToView = [];
    @track selectListDay = [];
    @track pages = [];
    @track studentToDelete = {}
    showDeleteSelectedModal = false;
    showDeleteModal = false;
    pageNumber = 1;
    pageSize = 7;
    totalPages = 1;
    isLoading = false;
    classOptions = [];

    renderedCallback() {
        
        Promise.all([
            loadStyle( this, LWC_SearchStudentCSS )
            ]).then(() => {
                console.log( 'Files loaded' );
            })
            .catch(error => {
                console.log( error );
        });

    }

    connectedCallback() {
        this.getSelectListDay();
        this.getClassOptions();
        this.search();
    }

    formatDate(date) {
        if (date) {
            var part = date.split("-");
            if (part.length == 3) {
                return part[2] + "/" + part[1] + "/" + part[0];
            } else {
                return date;
            }
        }
        return "";
    }

    get genderOptions() {
        return [
            { label: '----', value: '' },
            { label: 'Male', value: 'Male' },
            { label: 'Female', value: 'Female' },
        ];
    }

    getClassOptions() {
        getListClass()
        .then(result => {
            var option = [{ label: '----', value: '' }];
            result.forEach(e => {
                option.push({ label: e.Name, value: e.Id })
            })
            this.classOptions = option;         
        })
        .catch(err => {
            alert(err);
        })
    }

    get selectListYear() {
        var options = [];
        options.push({ label : "----", value : '0'});

        for (var i = 2007; i >= 1980; i--) {
            options.push({label : String(i), value : String(i) });
        }

        return options;
    }

    get selectListMonth() {
        var options = [];
        options.push({ label : "----", value : '0'});

        for (var i = 1; i <= 12; i++) {
            options.push({label : String(i), value : String(i) });
        }
        
        return options;
    }

    getSelectListDay() {
        var year = 0;
        var month = 0;
        var daySelected = 0;

        if (this.template.querySelector('.searchYear')) {
            year = this.template.querySelector('.searchYear').value || 0;
        }
        if(this.template.querySelector('.searchMonth')) {
            month = this.template.querySelector('.searchMonth').value || 0;
        }
        if(this.template.querySelector('.searchDay')) {
            daySelected = this.template.querySelector('.searchDay').value || 0;
        }
        
        
        var options = [];
        options.push({label : '----', value : '0'});
    
        var daysInMonth = new Date(year, month, 0).getDate();
        for (var i = 1; i <= daysInMonth; i++) {
            options.push({label : String(i), value : String(i) });
        }
        
        if(daySelected > daysInMonth){
            this.template.querySelector('.searchDay').value = 0;
        }

        this.selectListDay = options;
    }

    selectedMonthOrYear() {
        this.template.querySelector('.searchBirthDay').value = null;
        this.getSelectListDay();
    }

    selectedDay() {
        this.template.querySelector('.searchBirthDay').value = null;
    }

    selectedBirthday() {
        this.template.querySelector('.searchDay').value = 0;
        this.template.querySelector('.searchMonth').value = 0;
        this.template.querySelector('.searchYear').value = 0;
    }

    getStudents() {
        this.isLoading = true;
        const inputFields = this.template.querySelectorAll('.search-input');
        var searchInput = []
        inputFields.forEach(e => {
            searchInput.push(e.value);
        })

        var searchDTO = {
            searchByStudentCode: searchInput[0] || null,
            searchByName: searchInput[1] || null,
            searchByGender: searchInput[2] || null,
            searchByClass: searchInput[3] || null, 
            searchByBirthday: searchInput[4] || null,
            searchByDay: searchInput[5] || null,
            searchByMonth: searchInput[6] || null,
            searchByYear: searchInput[7] || null
        };

        searchCondition({
            searchJSON: JSON.stringify(searchDTO)
        })
        .then(result => {
            result.forEach(e => {
                e.selected = false;
            });
            this.listStudent = result;
            this.handlePaging();
            this.isLoading = false;
        })
        .catch(err => {
            alert(err.message)
            console.log(err)
            this.isLoading = false;
        })
    }

    search() {
        this.pageNumber = 1;
        this.getStudents()
    }

    handlePaging() {
        var i = 0;
        this.studentToView = [];
        if (this.pageNumber != 1) {
            i = (this.pageNumber-1)*this.pageSize;
        }

        for (i; i < this.listStudent.length && this.studentToView.length < this.pageSize; i++) {
            this.listStudent[i].STT = i + 1;
            this.listStudent[i].BirthDay = this.formatDate(this.listStudent[i].BirthDay__c);
            this.listStudent[i].Class = this.listStudent[i].Class_look__r.Name;
            this.studentToView.push(this.listStudent[i]);
        }

        this.totalPages = Math.floor((this.listStudent.length + this.pageSize - 1) / this.pageSize);
        this.pages = [];
        var n = 0;
        if (this.pageNumber - 2 > 0) {
            n = 2;
        }
        if (this.pageNumber - 2 == 0) {
            n = 1;
        }
        if (this.pageNumber == this.totalPages) {
            n = 4;
        }
        if (this.totalPages - this.pageNumber == 1) {
            n = 3;
        }
        for (var i = this.pageNumber - n; i <= this.totalPages && this.pages.length < 5; i++) {
            if (i > 0) {
                if (i == this.pageNumber) {
                    this.pages.push({number: i, current: true});
                } else {
                    this.pages.push({number: i, current: false});
                }
            }
        }

        this.isCheckedAll();
    }

    firstPage() {
        this.pageNumber = 1;
        this.handlePaging();
    }

    lastPage() {
        this.pageNumber = this.totalPages;
        this.handlePaging();
    }

    previousPage() {
        this.pageNumber -= 1;
        this.handlePaging();
    }

    nextPage() {
        this.pageNumber += 1;
        this.handlePaging();
    }

    goToPage(event) {
        this.pageNumber = event.target.label;
        this.handlePaging();
    }

    get isDisablePreviousPage() {
        return this.pageNumber == 1;
    }

    get isDisablehasNextPage() {
        if(this.totalPages == 0){
            return true;
        }
        return this.pageNumber == this.totalPages;
    }

    checkAll(event){
        this.studentToView.forEach(e => {
            e.selected = event.target.checked;
        })
        this.countChecked();
    }

    selectStudent(event) {
        this.studentToView.forEach(e => {
            if (e.StudentCode__c === event.target.value) {
                e.selected = event.target.checked;
            }
        })
        this.isCheckedAll();
    }

    isCheckedAll() {
        var checkAll = true;
        this.studentToView.forEach(e => {
            if (!e.selected) {
                checkAll = false;
            }
        })
        if(this.studentToView.length > 0){
            this.template.querySelector('.checkAll').checked = checkAll;
        }
        this.countChecked();
    }

    countChecked(){
        var count = 0;
        this.listStudent.forEach(e => {
            if (e.selected){
                count ++;
            }
        })
        if (count == 0) {
            this.template.querySelector('.deleteSelected').disabled = true;
        } else {
            this.template.querySelector('.deleteSelected').disabled = false;
        }
        var message = this.template.querySelector('.message')
        message.innerHTML  = "Selected " + count + " of " + this.listStudent.length + " students";
    }

    openDeleteSelectedModal() {
        this.showDeleteSelectedModal = true;
    }

    openDeleteModal(event) {
        this.studentToDelete = this.studentToView[event.target.dataset.index];
        this.showDeleteModal = true;
    }

    closeModal() {
        this.showDeleteSelectedModal = false;
        this.showDeleteModal = false;
    }

    deleteSelectedStudent() {
        this.isLoading = true;
        var selectedStudent = [];
        this.listStudent.forEach(e => {
            if(e.selected){
                selectedStudent.push(e.StudentCode__c);
            }
        })

        delSelectedStudent({studentCodes : selectedStudent})
        .then(result => {
            this.getStudents();
            const event = new ShowToastEvent({
                title: 'Success',
                message: 'Delete success',
                variant: 'success'
            });
            this.dispatchEvent(event);
        })
        .catch(err => {
            this.getStudents();
            const event = new ShowToastEvent({
                title: 'Error',
                message: 'Student not exist or something error',
                variant: 'error'
            });
            this.dispatchEvent(event);
        })
        this.closeModal();
        this.isLoading = false;
    }

    deleteStudent() {
        this.isLoading = true;
        var selectedStudent = [];
        selectedStudent.push(this.studentToDelete.StudentCode__c)

        delSelectedStudent({studentCodes : selectedStudent})
        .then(result => {
            this.getStudents();
            const event = new ShowToastEvent({
                title: 'Success',
                message: 'Delete success',
                variant: 'success'
            });
            this.dispatchEvent(event);
        })
        .catch(err => {
            this.getStudents();
            const event = new ShowToastEvent({
                title: 'Error',
                message: 'Student not exist or something error',
                variant: 'error'
            });
            this.dispatchEvent(event);
        })
        this.closeModal();
        this.isLoading = false;
    }

    openCreateModal() {
        try{
            createStudent.open({
                label: 'Add new student',
                size: 'small',
                classOptions: this.classOptions,
                onreloadstudent: (e) => {
                    e.stopPropagation();
                    this.getStudents();
                    const event = new ShowToastEvent({
                        title: 'Success',
                        message: 'Add success',
                        variant: 'success'
                    });
                    this.dispatchEvent(event);
                }
            });
        }catch(err){
            alert(err)
        }
        
    }

    openUpdateModal(event) {
        try{
            updateStudent.open({
                label: 'update student',
                size: 'small',
                classOptions: this.classOptions,
                studentId: event.target.dataset.id,
                onreloadstudent: (e) => {
                    e.stopPropagation();
                    this.getStudents();
                    const event = new ShowToastEvent({
                        title: 'Success',
                        message: 'Update success',
                        variant: 'success'
                    });
                    this.dispatchEvent(event);
                },
                onupdateerror: (e) => {
                    e.stopPropagation();
                    this.getStudents();
                    const event = new ShowToastEvent({
                        title: 'Error',
                        message: e.detail.msg,
                        variant: 'error'
                    });
                    this.dispatchEvent(event);
                }
            });
        }catch(err){
            alert(err)
        }
        
    }

    openDetailModal(event) {
        try{
            detailStudent.open({
                label: 'Detail student',
                size: 'large',
                studentId: event.target.dataset.id,
                ondetailerror: (e) => {
                    e.stopPropagation();
                    this.getStudents();
                    const event = new ShowToastEvent({
                        title: 'Error',
                        message: e.detail.msg,
                        variant: 'error'
                    });
                    this.dispatchEvent(event);
                }
            });
        }catch(err){
            alert(err)
        }
        
    }

    clearInput() {
        this.template.querySelector('[data-field="studentCode"]').value = '';
        this.template.querySelector('[data-field="name"]').value = '';
        this.template.querySelector('[data-field="class"]').value = null;
        this.template.querySelector('[data-field="gender"]').value = null;
        this.template.querySelector('[data-field="birthday"]').value = null;
        this.template.querySelector('[data-field="day"]').value = null;
        this.template.querySelector('[data-field="month"]').value = null;
        this.template.querySelector('[data-field="year"]').value = null;
    }

    sortStudentsByBirthDay() {
        var icon = this.template.querySelector(".sortIconByBirthDay").iconName;
        if (icon == "utility:arrowup") {
            this.listStudent.sort(function(a, b) {
                var dateA = new Date(a.BirthDay__c);
                var dateB = new Date(b.BirthDay__c);
                return dateA - dateB;
            });
            this.template.querySelector(".sortIconByBirthDay").iconName = "utility:arrowdown";
        } else {
            this.listStudent.sort(function(a, b) {
                var dateA = new Date(a.BirthDay__c);
                var dateB = new Date(b.BirthDay__c);
                return dateB - dateA;
            });
            this.template.querySelector(".sortIconByBirthDay").iconName = "utility:arrowup"
        }
        this.handlePaging();
    }

    sortStudentsByName() {
        var icon = this.template.querySelector(".sortIconByName").iconName;
        if (icon == "utility:arrowup") {
            this.listStudent.sort(function(a, b) {
                return b.Name.localeCompare(a.Name); 
            });
            this.template.querySelector(".sortIconByName").iconName = "utility:arrowdown";
        } else {
            this.listStudent.sort(function(a, b) {
                return a.Name.localeCompare(b.Name); 
            });
            this.template.querySelector(".sortIconByName").iconName = "utility:arrowup"
        }
        this.handlePaging();
    }

    sortStudentsStudentCode() {
        var icon = this.template.querySelector(".sortIconByStudentCode").iconName;
        if (icon == "utility:arrowup") {
            this.listStudent.sort(function(a, b) {
                return b.StudentCode__c.localeCompare(a.StudentCode__c); 
            });
            this.template.querySelector(".sortIconByStudentCode").iconName = "utility:arrowdown";
        } else {
            this.listStudent.sort(function(a, b) {
                return a.StudentCode__c.localeCompare(b.StudentCode__c); 
            });
            this.template.querySelector(".sortIconByStudentCode").iconName = "utility:arrowup"
        }
        this.handlePaging();
    }
}