let validInput = true;
$("#logout").click(function() {
        if (confirm("Are you sure you want to Logout")) {
            $.ajax({
                url: 'index.cfm?action=userAuth.logout',
                type: 'POST',
                success: function(result) {
                  location.reload();
                },
                error: function() {
                    
                }
            });
        }
});


function validate()
{
	let validInputUser = true;
	const fullName = document.getElementById("fullName").value;
	const email = document.getElementById("email").value;
	const userName = document.getElementById("username").value;
	const password = document.getElementById("password").value;
	const confirmPassword = document.getElementById("confirmPassword").value;
    const profilePhoto = document.getElementById("profile");
    console.log(profilePhoto.files.length)
	let nameError = document.getElementById("nameError");
	let mailError = document.getElementById("mailError");
	let usernameError = document.getElementById("userError");
	let passwordError = document.getElementById("passwordError");
	let passwordMatchError = document.getElementById("passwordMatchError");
    let profileError = document.getElementById("profileError");

	nameError.textContent = "";
	mailError.textContent = "";
	usernameError.textContent = "";
	passwordError.textContent = "";
	passwordMatchError.textContent = "";
    profileError.textContent = "";

	if(fullName.trim() === "")
	{
		nameError.textContent = "Name cannot be Empty";
		validInputUser = false;
	}
	if(email.trim() === "")
	{
		mailError.textContent = "Email cannot be empty";
		validInputUser = false;
	}
	else if(!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email))
	{
		mailError.textContent = "Invalid mail";
		validInputUser = false;
	}			
	if(userName.trim() === "")
	{
		usernameError.textContent = "Username cannot be empty";
		validInputUser = false;
	}
	else if(!/^[a-z0-9_.]+$/.test(userName))
	{
		usernameError.textContent = "Invalid Username";
		validInputUser = false;
	}
	if(password.trim() === "")
	{
		passwordError.textContent = "Password cannot be empty";
		validInputUser = false;
	}
	else if( password.search(/[a-z]/) < 0)
	{
		passwordError.textContent = "Password should contain Atleast one lowercase";
		validInputUser = false;
	}
	else if( password.search(/[A-Z]/) < 0)
	{
		passwordError.textContent = "Password should contain Atleast one Uppercase";
		validInputUser = false;
	}
	else if(password.search(/[0-9]/) < 0)
	{
		passwordError.textContent = "Password should contain Atleast one Digit";
		validInputUser = false;
	}
	else if(password.length<6)
	{
		passwordError.textContent = "Password should contain Atleast Six characters";
		validInputUser = false;
	}
    if(confirmPassword.trim() === "")
    {
        passwordMatchError.textContent = "Password cannot be empty";
        validInputUser = false;
    }
    
	else if(password != confirmPassword)
	{
		passwordMatchError.textContent = "Password does'nt match";
		validInputUser = false;
	}

    if(profilePhoto.files.length === 0)
    {
        profileError.textContent = "select an image";
        validInputUser = false;
    }
  
	return validInputUser;
}

function viewData(contactId)
{
	$.ajax({
   	 url: 'index.cfm?action=main.getContactDetails',
   	 type: 'POST',
   	 data: {contactId:contactId.value},
   	 success: function(result) {
		 document.getElementById("cntName").textContent = result.FIRSTNAME;
		 document.getElementById("cntGender").textContent = result.GENDER;
		 document.getElementById("cntDob").textContent = result.DATEOFBIRTH;
		 document.getElementById("cntAddress").textContent = result.ADDRESS+" "+result.STREET+" "+result.DISTRICT+" "+result.STATE+" "+result.NATIONALITY;
		 document.getElementById("cntPincode").textContent = result.PINCODE;
		 document.getElementById("cntMail").textContent = result.EMAILID;
		 document.getElementById("cntPhone").textContent = result.PHONENUMBER;
		 document.getElementById("profile").src = "Images/Uploads/"+result.PHOTO;
   	 },
   	 error: function() {		
   	 }
      });
}

function deleteContact(contactId)
{	
	if (confirm("Are you sure you want to delete"))
	{
		$.ajax({		
   	 url: 'index.cfm?action=main.deleteContact',
   	 type: 'POST',
   	 data: {contactId:contactId.value},
   	 success: function() {			
			document.getElementById(contactId.value).remove();
   	 },
   	 error: function() {		
   	 }
      });
	}	
}

function validateContact()
{	
    let validInput = true;
	let title = document.getElementById("title").value;	
	let firstName = document.getElementById("firstName").value;
	let lastName = document.getElementById("lastName").value;
	let gender = document.getElementById("gender").value;
	let dateOfBirth = document.getElementById("dob").value;	
	let address = document.getElementById("address").value;
	let street = document.getElementById("street").value;
	let district = document.getElementById("district").value;
	let state = document.getElementById("state").value;
	let nationality = document.getElementById("nationality").value;
	let pincode = document.getElementById("pincode").value;
	let email = document.getElementById("email").value;
	let phone = document.getElementById("phone").value;
    let photo = document.getElementById("photo").value;

	let titleError = document.getElementById("titleError");
	let firstNameError = document.getElementById("firstNameError");
	let lastNameError = document.getElementById("lastNameError");
	let genderError = document.getElementById("genderError");
	let dateOfBirthError = document.getElementById("dobError");
	let photoError = document.getElementById("photoError");
	let addressError = document.getElementById("addressError");
	let streetError = document.getElementById("streetError");
	let districtError = document.getElementById("districtError");
	let stateError = document.getElementById("stateError");
	let nationalityError = document.getElementById("nationalityError");
	let pincodeError = document.getElementById("pincodeError");
    let emailError = document.getElementById("emailError");
	let phoneError = document.getElementById("phoneError");
	

	titleError.innerHTML = "";
	firstNameError.innerHTML = "";
	lastNameError.innerHTML = "";
	genderError.innerHTML = "";
	dateOfBirthError.innerHTML = "";
	photoError.innerHTML = "";
	addressError.innerHTML = "";
	streetError.innerHTML = "";
	districtError.innerHTML = "";
	stateError.innerHTML = "";
	nationalityError.innerHTML = "";
	pincodeError.innerHTML = "";
	phoneError.innerHTML = "";	
	
	var CurrentDate = new Date();
	GivenDate = new Date(dateOfBirth);

	if(title == "notSelect")
	{		
		titleError.innerHTML = "Select Any title"
		validInput = false;
	}
	if(firstName.trim() === "")
	{
		firstNameError.innerHTML = "FirstName required"
		validInput = false;
	}
	if(lastName.trim() === "")
	{
		lastNameError.innerHTML = "LastName required"
		validInput = false;
	}
	if(gender == "notSelect")
	{
		genderError.innerHTML = "Gender required"
		validInput = false;
	}
	if(dateOfBirth.trim() === "")
	{
		dateOfBirthError.innerHTML = "DateOfBirth required"
		validInput = false;
	}
	else if(GivenDate > CurrentDate)
	{
		dateOfBirthError.innerHTML = "Invalid DateOfBirth"
		validInput = false;
	}

	if(address.trim() === "")
	{
		addressError.innerHTML = "address required"
		validInput = false;
	}
	if(street.trim() === "")
	{
		streetError.innerHTML = "street required"
		validInput = false;
	}
	if(district.trim() === "")
	{
		districtError.innerHTML = "district required"
		validInput = false;
	}
	if(state.trim() === "")
	{
		stateError.innerHTML = "state required"
		validInput = false;
	}
	if(nationality.trim() === "")
	{
		nationalityError.innerHTML = "nationality required"
		validInput = false;
	}
	if(pincode.trim() === "")
	{
		pincodeError.innerHTML = "pincode required"
		validInput = false;
	}
	
	if(phone.trim() === "")
	{
		phoneError.innerHTML = "phone required"
		validInput = false;
	}

    if(email.trim() === "")
    {
        emailError.innerHTML = "email required"
        validInput = false;
    }

	return validInput;
}

function validateLogin()
{
    let isvalid = true;
    const userName = document.getElementById("userName").value;
    const password = document.getElementById("password").value;

    let usernameError = document.getElementById("userNameErrorLogin");
    let passwordError = document.getElementById("passwordErrorLogin");
    
    usernameError.innerHTML = "";
    passwordError.innerHTML = "";

    if(userName.trim() === "")
    {
        usernameError.innerHTML = "userName cannot be empty";
        isvalid = false;
    }
    if(password.trim() === "")
    {
         passwordError.innerHTML = "password cannot be empty";
         isvalid = false;
    }
    return isvalid;
}

function editContact(contactId)
{
	validInput = true;
	let titleError = document.getElementById("titleError");
	let firstNameError = document.getElementById("firstNameError");
	let lastNameError = document.getElementById("lastNameError");
	let genderError = document.getElementById("genderError");
	let dateOfBirthError = document.getElementById("dobError");
	let photoError = document.getElementById("photoError");
	let addressError = document.getElementById("addressError");
	let streetError = document.getElementById("streetError");
	let districtError = document.getElementById("districtError");
	let stateError = document.getElementById("stateError");
	let nationalityError = document.getElementById("nationalityError");
	let pincodeError = document.getElementById("pincodeError");
	let emailError = document.getElementById("emailError");
	let phoneError = document.getElementById("phoneError");

	titleError.innerHTML = "";
	firstNameError.innerHTML = "";
	lastNameError.innerHTML = "";
	genderError.innerHTML = "";
	dateOfBirthError.innerHTML = "";
	photoError.innerHTML = "";
	addressError.innerHTML = "";
	streetError.innerHTML = "";
	districtError.innerHTML = "";
	stateError.innerHTML = "";
	nationalityError.innerHTML = "";
	pincodeError.innerHTML = "";
	emailError.innerHTML = "";
	phoneError.innerHTML = "";
	$.ajax({		
   	 url: 'index.cfm?action=main.getContactDetails',
   	 type: 'POST',
   	 data: {contactId:contactId.value},
   	 success: function(result) {
		console.log(result);
		let validGender = result.GENDER.toLowerCase();
         document.getElementById("title").value = result.TITLE;
			document.getElementById("firstName").value = result.FIRSTNAME;
			document.getElementById("lastName").value = result.LASTNAME;
			document.getElementById(validGender).selected = true;
			document.getElementById("dob").value = result.DATEOFBIRTH;			
			document.getElementById("address").value = result.ADDRESS;
			document.getElementById("street").value = result.STREET;
			document.getElementById("district").value = result.DISTRICT;
			document.getElementById("state").value = result.STATE;
			document.getElementById("nationality").value = result.NATIONALITY;
			document.getElementById("pincode").value = result.PINCODE;
			document.getElementById("email").value = result.EMAILID;
			document.getElementById("phone").value = result.PHONENUMBER;
			document.getElementById("imagePathEdit").value = result.PHOTO;
			document.getElementById("distinguishButtons").value = result.CONTACTID; 
			document.getElementById("createContactText").innerHTML = "EDIT CONTACT";
			document.getElementById("submit").innerHTML = "Save Changes";
   	 },
   	 error: function() {		
   	 }
      });
}

function createContact()
{
	validInput = true;
	$(".error").text("");	
	$("#select").val("").trigger("chosen:updated");
	document.getElementById("createContactText").innerHTML = "CREATE CONTACT";
	document.getElementById("form").reset();
}

function printContact()
{
	window.print();
}


