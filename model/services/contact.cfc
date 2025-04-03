<cfcomponent>
    <cffunction name="fetchContacts" access="public" returntype="query">
        <cfargument name="userId" type="string" required="true">
        <cftry>
            <cfquery name="local.getContacts">
                SELECT
                    title,
	                firstName,
	                lastName,
	                gender,
	                dateOfBirth,
	                photo,
	                Address,
	                street,
	                district,
	                STATE,
	                nationality,
	                pinCode,
	                emailId,
	                phoneNumber,
                    contactId
                FROM
                    Contact
                WHERE _createdBy = <cfqueryparam value="#arguments.userId#" cfsqltype="integer">
                AND active = 1
            </cfquery>
        <cfcatch type="any">
            <cfdump var="#cfcatch#">
        </cfcatch>
        </cftry>
        <cfreturn local.getContacts>
    </cffunction>

    <cffunction name="addContact" access="public" returntype="struct">
        <cfargument name="title" type="string" required="true">
        <cfargument name="firstName" type="string" required="true">
        <cfargument name="lastName" type="string" required="true">
        <cfargument name="gender" type="string" required="true">
        <cfargument name="dateOfBirth" type="string" required="true">
        <cfargument name="photo" type="string" required="false" default="">
        <cfargument name="Address" type="string" required="true">
        <cfargument name="street" type="string" required="true">
        <cfargument name="district" type="string" required="true">
        <cfargument name="state" type="string" required="true">
        <cfargument name="nationality" type="string" required="true">
        <cfargument name="pinCode" type="string" required="true">
        <cfargument name="email" type="string" required="true">
        <cfargument name="phone" type="string" required="true">
        <cfset local.result = {
            "success":false,
            "message":""
        }>
        <cftry>
            <cfif NOT len(arguments.photo)>
                <cfset local.image = "profile.png">
            <cfelse>
                <cffile
                    action="upload"
                    fileField = "photo"
                    destination = "C:\ColdFusion2021\cfusion\wwwroot\AddressBookMVC\Images\Uploads"
                    result="local.newPath"
                    nameconflict="overwrite"
                >
                <cfset local.image = local.newPath.serverfile>
            </cfif>
            <cfquery name="local.insertContact" result="local.record">
                INSERT INTO Contact (
                    title,
                    firstName,
                    lastName,
                    gender,
                    dateOfBirth,
                    photo,
                    Address,
                    street,
                    district,
                    STATE,
                    nationality,
                    pinCode,
                    emailId,
                    phoneNumber,
                    _createdBy,
                    _updatedBy,
                    active
                )
                VALUES (
                    <cfqueryparam value="#arguments.title#" cfsqltype="varchar">,
                    <cfqueryparam value="#arguments.firstName#" cfsqltype="varchar">,
                    <cfqueryparam value="#arguments.lastName#" cfsqltype="varchar">,
                    <cfqueryparam value="#arguments.gender#" cfsqltype="varchar">,
                    <cfqueryparam value="#arguments.dateOfBirth#" cfsqltype="date">,
                    <cfqueryparam value="#local.image#" cfsqltype="varchar">,
                    <cfqueryparam value="#arguments.Address#" cfsqltype="varchar">,
                    <cfqueryparam value="#arguments.street#" cfsqltype="varchar">,
                    <cfqueryparam value="#arguments.district#" cfsqltype="varchar">,
                    <cfqueryparam value="#arguments.state#" cfsqltype="varchar">,
                    <cfqueryparam value="#arguments.nationality#" cfsqltype="varchar">,
                    <cfqueryparam value="#arguments.pinCode#" cfsqltype="varchar">,
                    <cfqueryparam value="#arguments.email#" cfsqltype="varchar">,
                    <cfqueryparam value="#arguments.phone#" cfsqltype="varchar">,
                    <cfqueryparam value="#session.loginUserId#" cfsqltype="varchar">,
                    <cfqueryparam value="#session.loginUserId#" cfsqltype="varchar">,
                    1
                )
            </cfquery>
            <cfset local.result.success = true>
            <cfset local.result.message = "contact Added successfully">
        <cfcatch type="any">
            <cfset local.result.message = "some error occured">
        </cfcatch>
        </cftry>
        <cfreturn local.result>
    </cffunction>

    <cffunction name="fetchSingleContact" access="remote" returntype="struct" returnformat="JSON">
        <cfargument name="contactId" type="string" required="true">
        <cfset var local = {}>
        <cfset local.structContact = structNew()>
        <cfquery name="local.fetchAcontact">
            SELECT
                contactId,
                title,
                firstName,
                lastName,
                gender,
                dateOfBirth,
                photo,
                address,
                street,
                district,
                STATE,
                nationality,
                pinCode,
                emailId,
                phoneNumber
            FROM Contact c
            WHERE contactId = <cfqueryparam value="#arguments.contactId#">
        </cfquery>
    <cfset var colname = "">
    <cfloop list="#local.fetchAcontact.columnList#" index="colname">
        <cfset local.structContact[colname] = local.fetchAcontact[colname][1]>
    </cfloop>
    <cfif NOT isNull(local.structContact.dateOfBirth)>
        <cfset local.structContact.dateOfBirth = dateFormat(local.structContact.dateOfBirth, "yyyy-MM-dd")>
    </cfif>
    <cfreturn local.structContact>
    </cffunction>

    <cffunction name="editContact" access="public" returntype="struct">
        <cfargument name="contactId" type="string" required="true">
        <cfargument name="title" type="string" required="true">
        <cfargument name="firstName" type="string" required="true">
        <cfargument name="lastName" type="string" required="true">
        <cfargument name="gender" type="string" required="true">
        <cfargument name="dateOfBirth" type="string" required="true">
        <cfargument name="photo" type="string" required="false" default="">
        <cfargument name="address" type="string" required="true">
        <cfargument name="street" type="string" required="true">
        <cfargument name="district" type="string" required="true">
        <cfargument name="state" type="string" required="true">
        <cfargument name="nationality" type="string" required="true">
        <cfargument name="pincode" type="string" required="true">
        <cfargument name="emailId" type="string" required="true">
        <cfargument name="phoneNumber" type="string" required="true">
        <cfargument name="hiddenPhoto" type="string" required="false" default="./Images/DefaultImage/profile.png">
        <cfset local.result = {
            "success":false,
            "message":""
        }>
        <cftry>
            <cfif len(arguments.photo)>
               <cffile 
                    action="upload"
                    fileField = "photo"
                    destination = "C:\ColdFusion2021\cfusion\wwwroot\AddressBookMVC\Images\Uploads"
                    result="local.newPath"
                    nameconflict="overwrite"
                >
                <cfset local.photo = local.newPath.serverfile>
            <cfelse>
                <cfset local.photo = arguments.hiddenPhoto>
            </cfif>
            <cfset local.todayDate = dateFormat(now(),"dd-mm-yyy")> 
            <cfquery name="local.editContact">
                UPDATE Contact
                SET
                    title = <cfqueryparam value="#arguments.title#" cfsqltype="varchar">,
                    firstName = <cfqueryparam value="#arguments.firstName#" cfsqltype="varchar">,
                    lastName = <cfqueryparam value="#arguments.lastName#" cfsqltype="varchar">,
                    gender = <cfqueryparam value="#arguments.gender#" cfsqltype="varchar">,
                    dateOfBirth = <cfqueryparam value="#arguments.dateOfBirth#" cfsqltype="date">,
                    photo = <cfqueryparam value="#local.photo#" cfsqltype="varchar">,
                    address = <cfqueryparam value="#arguments.address#" cfsqltype="varchar">,
                    street = <cfqueryparam value="#arguments.street#" cfsqltype="varchar">,
                    district = <cfqueryparam value="#arguments.district#" cfsqltype="varchar">,
                    state = <cfqueryparam value="#arguments.state#" cfsqltype="varchar">,
                    nationality = <cfqueryparam value="#arguments.nationality#" cfsqltype="varchar">,
                    pinCode = <cfqueryparam value="#arguments.pincode#" cfsqltype="varchar">,
                    emailId = <cfqueryparam value="#arguments.emailId#" cfsqltype="varchar">,
                    phoneNumber = <cfqueryparam value="#arguments.phoneNumber#" cfsqltype="varchar">,
                    _updatedOn = <cfqueryparam value="#local.todayDate#" cfsqltype="date">
                WHERE contactId = <cfqueryparam value="#arguments.contactId#" cfsqltype="integer">
            </cfquery>
            <cfset local.result.success = true>
            <cfset local.result.message = "contact edited successfully">
        <cfcatch>
            <cfset local.result.message = "some error occured">
        </cfcatch>
        </cftry>
        <cfreturn local.result>
    </cffunction>

    <cffunction name="deleteContact" access="public">
        <cfargument name="contactId" type="integer" required="true">
        <cfquery name="deleteContact">
            UPDATE
                Contact
            SET
                active = 0
            WHERE
                contactId = <cfqueryparam value="#arguments.contactId#" cfsqltype="integer">
        </cfquery>
    </cffunction>
</cfcomponent>