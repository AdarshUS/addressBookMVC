component accessors="true" {
	property contact;
	public void function default( rc ) {
	if(structKeyExists(session,"loginUserId"))
    {
        rc.contactList = contact.fetchContacts(session.loginUserId);
    }
	}
}
