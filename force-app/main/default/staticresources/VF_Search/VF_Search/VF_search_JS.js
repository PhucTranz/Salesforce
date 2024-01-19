function showModal(idModal) {
    $('#'+idModal).modal('show'); 
}

$(document).ready(function(){
    $("#home").click(function(){
        window.location.href="/apex/VF_SearchStudent"
    });
    checkChecked()
});

function validation(firstName, lastName, birthDay, address, class__c) {
    isValid = true;
    if(firstName === '' || firstName.trim() === ''){
        $(".FNMessage").html('Please enter first name');
        isValid = false;
    }else if (firstName.length > 255){
        $(".FNMessage").html('First name must be less than 255 characters');
        isValid = false;
    } else{
        $(".FNMessage").html('');
    }
    
    if(lastName === '' || lastName.trim() === ''){
        $(".LNMessage").html('Please enter last name');
        isValid = false;
    }else if (lastName.length > 255){
        $(".LNMessage").html('Last name must be less than 255 characters');
        isValid = false;
    } else{
        $(".LNMessage").html('');
    }

    if(address === '' || address.trim() === ''){
        $(".AMessage").html('Please enter address');
        isValid = false;
    }else if (address.length > 255){
        $(".AMessage").html('Address must be less than 255 characters');
        isValid = false;
    }else{
        $(".AMessage").html('');
    }

    if(birthDay === '' || birthDay.trim() === ''){
        $(".BDMessage").html('Please enter birthday');
        isValid = false;
    }else{
        var parts = birthDay.split("-");
        birthYear = parseInt(parts[0], 10);
        var currentDate = new Date();
        var currentYear = currentDate.getFullYear();
        if(currentYear - birthYear < 18){
            $(".BDMessage").html('You must be at least 18 years old');
            isValid = false;
        }else{
            $(".BDMessage").html('');
        }
    }
    if(class__c === ''){
        $(".CMessage").html('Please choose a class');
        isValid = false;
    }else{
        $(".CMessage").html('');
    }  
    return isValid; 
}

function showMessage(idModal){
    $(".custom-messages").slideDown(500);

    setTimeout(function(){
        $(".custom-messages").slideUp(500);
    }, 3000);
    
    $('#'+idModal).modal('hide'); 
}

function checkChecked(){
    count = 0;
    isChecked = false;
    totalRecords = $('#numOfRecords').html();
    countSelected = $('#countSelected').html();
    if(totalRecords == 0)
        $('.btnSelectAll').prop('disabled', true);
    else
        $('.btnSelectAll').prop('disabled', false);

    if (countSelected == 0) {
        $('.btnDelete').prop('disabled', true);
    } else {
        $('.btnDelete').prop('disabled', false);
    }
    
    $(".checkboxes:checked").each(function() {
        $('.btnClear').prop('disabled', false);
        isChecked = true;
        count++;
    });
    if(isChecked == false){
        $('.btnClear').prop('disabled', true);
    }
    $('#numOfSelected').html('Selected '+ countSelected +' of '+ totalRecords + ' students')
}

document.addEventListener('DOMContentLoaded', function() {
    selectListYear();
    selectListMonth();
    selectListDay();
});

function selectListYear(){
    var dropdown = document.getElementById("searchYear");
    var currentYear = new Date().getFullYear();

    var option = document.createElement('option');
    option.value = 0;
    option.text = "---";
    dropdown.add(option);

    for (var i = 2007; i >= 1980; i--) {
        option = document.createElement('option');
        option.value = i;
        option.text = i;
        dropdown.add(option);
    }
}

function selectListMonth(){
    var dropdown = document.getElementById("searchMonth");

    var option = document.createElement('option');
    option.value = 0;
    option.text = "---";
    dropdown.add(option);

    for (var i = 1; i <= 12; i++) {
        option = document.createElement('option');
        option.value = i;
        option.text = i;
        dropdown.add(option);
    }
}

function selectListDay(){
    var year = $("#searchYear").val();
    var month = $("#searchMonth").val();
    var dropdown = document.getElementById("searchDay");
    var daySelected = $("#searchDay").val();
    dropdown.innerHTML = '';

    option = document.createElement('option');
    option.value = 0;
    option.text = "---";
    dropdown.add(option);
    var daysInMonth = new Date(year, month, 0).getDate();
    for (var i = 1; i <= daysInMonth; i++) {
        option = document.createElement("option");
        option.value = i;
        option.text = i;
        dropdown.add(option);
    }

    if(daySelected > daysInMonth || daySelected == null){
        $("#searchDay").val(0);
        updateDay()
    }else{
        $("#searchDay").val(daySelected);
    }
}