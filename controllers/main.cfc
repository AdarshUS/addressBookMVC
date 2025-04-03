component accessors="true" {
	property contactService;

     function init( fw ) {
        variables.framework = arguments.fw;
        return this;
    }
	public void function default( rc ) {
     if(structKeyExists(rc,"submit") && structKeyExists(rc,"distinguishButtons") && rc.distinguishButtons != "")
        {
            local.contactedEdited = contactService.editContact(
                contactId = rc.distinguishButtons,
                title = rc.title,
                firstName = rc.firstName,
                lastName = rc.lastName,
                gender = rc.gender,
                dateOfBirth = rc.dob,
                photo = rc.photo,
                address = rc.Address,
                street = rc.street,
                district = rc.district,
                state = rc.state,
                nationality = rc.nationality,
                pinCode = rc.pincode,
                emailId = rc.email,
                phoneNumber = rc.phone,
                hiddenPhoto = rc.imagepathedit
            )
            rc.contactMessage = local.contactedEdited.message;
        }
        else if(structKeyExists(rc,"submit")){
            local.userAdded = contactService.addContact(
                title = rc.title,
                firstName = rc.firstName,
                lastName = rc.lastName,
                gender = rc.gender,
                dateOfBirth = rc.dob,
                photo = photo,
                Address = Address,
                street = street,
                district = district,
                state = state,
                nationality = nationality,
                pinCode = pincode,
                email = email,
                phone = phone
            )
            rc.contactMessage = local.userAdded.message;
        }
	if(structKeyExists(session,"loginUserId"))
    {
        rc.contactList = contactService.fetchContacts(session.loginUserId);
    }
	}

    function getContactDetails(struct rc)
    {
        local.contactDetails = contactService.fetchSingleContact(rc.contactId);
        variables.framework.renderData().data(local.contactDetails).type( "json");
    }

    function deleteContact(struct rc)
    {
        contactService.deleteContact(rc.contactId);
        variables.framework.renderData().data("true").type("json")
    }
}
